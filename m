Return-Path: <linux-kernel+bounces-893769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F6C484BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9A61886C71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AD2BDC29;
	Mon, 10 Nov 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eOklfgtE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y9oXnlrD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506C29BDAB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795401; cv=fail; b=sUr0mSEBhS5HuJLy8rboszvJEu3APtsRwF9h2vCpaOo/kuzHtXVS6dncVmAKut7X2HE/+QVMveL0/1kVOZVck4V+IaFeqBIfOZQ5g0vgxZ8fUDnjMuZv92qiVMpDilg1Rll6RCgAZ3thdR/yn8OQWFYLR4zdq1vZnxwq55TfccE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795401; c=relaxed/simple;
	bh=qp21szC1b9CO7S/MBFjCsgoTCsjbNmwKaqjqnUAWqPw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BDINrmLzQTqgQNhYgtz3TX+54hWghvdVEUebIEkFdtJ5uYNN/WkHUyaku8aXwSjGET/1xLVLfmaixTw6II5G9byahcNfpeqaBRlIhBsCNpciEkLQV2pPl2z/LVtl4kot397ykixxUWYXCR/S+V+ntPT55ceNkBXu486xBqRqQw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eOklfgtE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y9oXnlrD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGBW7f012149;
	Mon, 10 Nov 2025 17:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=c3v6OFKIUsYGIOza
	fG9txePmTkuJdmBWWILfebVsf90=; b=eOklfgtE/OTWplS0pDbIzBPZ9caD6xt2
	GMwDUzc/twr8TXZXH5y5ro+11UJ5fgw4HCiRNTCSD1bgzag1R66VgfejDJCDPfXj
	xMEbuQib/+UT+iFoqszg3ml1y9djUKHTwnibw1ltE12XfHoaGT9GH4OGO8uZz2CQ
	khHniaV890D6vTnjosAaO9cwRZv4iiGoxbv2SL7cxvfhbjk6zmAJkAP6fxzpY1iT
	/aPJvZIBrkSV+vmlNLR9TBhHqzb0j7jND1reaEygr9uHCD6vuUlWKur8K+mFfW9f
	wRNMYR4xCvl+A9uF+QwPdP0735LXnr541hj5d1B1CgvtQKJ6K0RM6A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abjug090x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:23:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAG4lgv010112;
	Mon, 10 Nov 2025 17:23:07 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaj6srj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:23:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk9G9JQ56rWY2zQDim2a+3umRM+mu35zTcD1v7RNhb5sPMYd+Z3VaPUyMgDeR9QwNLYvNNrumpiJ7GWVK89ceM+ZTfjnKMVvd/wuQzzK0t9HbYVu6cw2AIDYLT0VN2N2mEEnADmnKGEmrKqYEnVG+pSkiunerz9eL3J/xNX0clH9xImvj9ap7o2xxS9o6nK0LGhKzJ1P6DFOWW7LqlEtonkS7O69oNHE6kLAUtWqZQHIiElJkJxKqPJpIcyJM9Vna/ZSe2WFwh4KzUqoqF79/BS6rY7GmCjmDJGNIN4NHDXd/vn1lRqkScyAnm/OXH8b/emUuhiSCtHry6UyaIoOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3v6OFKIUsYGIOzafG9txePmTkuJdmBWWILfebVsf90=;
 b=WK4x2HeC7uyoAJ5fgBGjsgH9+l17dK4UHuOypXJxNKI79g6DudLSslZO9+I7gaNxTvo8n01cHfkloqXgH5L85uXz7L9O1MdY9V/02iNu3OWTzSzJKBSSs14YOKB05qU2+9IbyAIBvEe5DjbNYm88HBjBjKX9GZbbOzbc7wdmptFDv+VG4e5dZUWE5RNb3/dUsTYbVYfyr7naX9DUuUGt84+4sxuf2H6RbXysW6jM3J75sbXCEBRu0oioc4Sbth8/HMAu94D/4TrvaCqxaP6lOAeEZbHaME+Wc7ZdvCD+ve65OVihfIriY+XFqEFJTxc0s7CdyJvgLyzQaI0hgXo+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3v6OFKIUsYGIOzafG9txePmTkuJdmBWWILfebVsf90=;
 b=Y9oXnlrDNMcg2yIBKbSk2Loy0cTep3Bnul574G/i8BKfmagU3NCqSbbGUCHq/bWk3Gmg8v9HHXoph1zs5gTZ2R2h3wXX/AyluvQNwYkLebxJbYJoVG8DWQEjMqrTp+Of2N4VWe4VgZQ1EWTrpbyOnpFC/dEYZ31sQLuvWRHusec=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Mon, 10 Nov
 2025 17:23:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 17:23:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: perform guard region install/remove under VMA lock
Date: Mon, 10 Nov 2025 17:22:56 +0000
Message-ID: <cover.1762795245.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: edd8b2a4-ae9e-4436-b117-08de207dce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcFrTiTK18VOB12sMmZaW7t5pvjOGnvmxXAy2tgyYDEEkaVm8ZMEBIj8uFkX?=
 =?us-ascii?Q?EkzIn8OFhHk90dv38LKllrX09+TUWCdg1cazF77dRWu7d/5SSujpaVEdDzvB?=
 =?us-ascii?Q?Byaigwu8FdoMb8PHjCDkB+UZpr9silI2x77eGd/p5KFTIUT07jCiFzuTovPB?=
 =?us-ascii?Q?eob0lUMw9LgjFsGXULKanFVLlXD8GADD6AUoqN5iqb9hSWSWs+EIfa6n7+61?=
 =?us-ascii?Q?947zTg8ztxXRwbAF/yGuOvnmhCgrCHOexz2wXsaF1z5rRtvyxHdzbDg8GW0y?=
 =?us-ascii?Q?8Dy335f+4rpV+vC1hK1Lj6fJl9ff8KlPvrhoiW5xpLSV3RK8zwY8H/FZ8cC+?=
 =?us-ascii?Q?7x8r3b2wxdIkUeyejIBKC+kv+Ve7ppWjL0DVMSu92q3N89D0w8NY9PKK/fUa?=
 =?us-ascii?Q?Yh0F8BqM/Ys9nbxpwX+NaUS8atrK/bgAvz9Bj+/Gv58uUkdyfPjSjZLmldRk?=
 =?us-ascii?Q?ToFvkHRIE+l2Lwzs58/jlU1A6OE/KNYd1O83jE78XsMXrs7ovg/p8oOelOuv?=
 =?us-ascii?Q?4r57KZYFnf0EdOJG/YjjOLvFbDU1c2fiUyRjZlxuzB2yh8WjHIWKh1X22lPZ?=
 =?us-ascii?Q?nveqWN6M3PC0/amDC+nnRt8UAYhDNynTUWp7lYn8RSc/hudpT0loiicM9CUG?=
 =?us-ascii?Q?/tQ1w8D/L/8NIlg5voxFC8IQM7l1xuYOnuMXCzn3G6FaM66zTCNkZ1FbxCJC?=
 =?us-ascii?Q?RGmqRLAr7fjwIgJm/+636Mx8w151J8FQdN/eip2dzEMH1OTjwA+/B1+3CSSc?=
 =?us-ascii?Q?vMjEyrHEJ26IctCHQZA3n/HjGFOOTubwx+cujQXlNfZtb6E3j1HClB6uvSaI?=
 =?us-ascii?Q?Y1HO1iFIO2Kw0rJ8Cs/P/2W1ItEfmHadvVHirlEnrD1muTXt5TaTpgzcBRwo?=
 =?us-ascii?Q?hn7rkvDe/E83Ew8asH/KND6eWjdwoWq4HDhL0FR/vbwdmyjlpeeEz6iC5I0/?=
 =?us-ascii?Q?xbKifMve79eWqPjMUhDzoG9hvJ4VttdP+dI0USutnqsV//2BZblToNlGKwhA?=
 =?us-ascii?Q?VBBmrt/tB4atozy77TdunvhYpzW+yztUSSmQXB1h5fJDlASs9xriCZ6CEvcQ?=
 =?us-ascii?Q?yqgEvbfUzhRVd0j5tjOhAMzwl8KDM90IfQzy5pw/xOqNo7HSVZcL8HsAwF81?=
 =?us-ascii?Q?6+kj7kS9Lo3RPQ5MKfyDKm+9624tIjheGSy7qtIcjxi6CK7fXYPL/u++zprc?=
 =?us-ascii?Q?E3qAINjS7gEby3ruluTLHzBNUmZeGk5GPo9m6H1WAqGvguhDnpixdPGYXjS7?=
 =?us-ascii?Q?afJIo7bZsoNYfiy+dECE1+EOBq5aVdMvRYX0ZtLp9szV9oO+JW/h5dajOAsR?=
 =?us-ascii?Q?ZNViRFH/pWtkILqTwhSvcYWnCLmlElLbiZ9wJkFGQr21HknZeiFeCMtbQn5O?=
 =?us-ascii?Q?ozDnH1/swIbnLOqut9vpMy905p0SnWKrFvgMiTy9M0rcpfzI8LLc2vlIo2Rz?=
 =?us-ascii?Q?b2gS+QwstOu4rs0m7e9cGbVqK6u7CBINqPcmiA59GR5mW/r+NKIRWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O47QYlIrg9WXrdCnHx6Tc9wUv2zDYQ+ZspH4BCZ5BhnTHUEIuW8ssAoS20hl?=
 =?us-ascii?Q?sOrR0qa6ZI6BAiL7wX5ShPJdfVVKNkOlU1QhJhwiF5AyU+KflG4r0xTmt3dB?=
 =?us-ascii?Q?uEQ3glRVdSf4oYX0pKd5tBxredyC2z91uETYnod994oyKO62Pdz5qEAeS/cV?=
 =?us-ascii?Q?wOLynq5g7B4WI6rXPBAWO6tWlC03sNNHevJHRp4ZEEOJXE+fe9CsUvHIx4nn?=
 =?us-ascii?Q?yZqnj5d9D1eNjfWjrwIITaX+qeyZyrm9omHPJjLuBa7eXZA1YvTCYKrU2iLp?=
 =?us-ascii?Q?GvmxrTEdZyJPN2zajoLXZXcH/VS4H9zWjMYxPbQhiJgE9aWIrdY3rAF+MsQB?=
 =?us-ascii?Q?8GEJpQTkKTRk5k9vYLERIaqjzwrOMGFj9B8DBd0EYhM4LdhPpLeTT4QPuxdX?=
 =?us-ascii?Q?h6bd7kj1MfbFXnZOFQpAXgFQ59w2Wztx7pLgu7U8ht4ngnEdfydozbUry4sf?=
 =?us-ascii?Q?t0pjd2+TPoz9UHEcsrxpbajpCdS/uPZSGp8jufJM04rUGUjl1hpRQ6Kdyr4W?=
 =?us-ascii?Q?RX/m1YuNaxDtjItNg7TGmWsVUK+AW+BzKB7Ib1KeaoLMtH4a5H9k0maZmnXk?=
 =?us-ascii?Q?l82iuvunXETwt364PH0DRvrqvSKgBzIbRMmXgwjD+Ns33AZSEHnz9dAOhb3G?=
 =?us-ascii?Q?NemVE+4bvHhVTLcNM+4rgj6MtS0QvPXcu9CfIwpyS2IrW1A6WNMOdH35Kqhc?=
 =?us-ascii?Q?SJq0s6F2uVMKP4tI5D+0tF1TJNcIaywi+S5PDaiYQ/2JtsIK/vYqsmOQKmRs?=
 =?us-ascii?Q?twteeL2SxMB8P9kv3nOcGBSa57NSWTGRtkOioK96E5Xgpu4eMdIJjcuc88Eo?=
 =?us-ascii?Q?vyZpl5NgjLYla+xw3ToM8Pulahy655jGZc2EPe53SjGyf7duxCf28Dvv3i9z?=
 =?us-ascii?Q?09TXqgFIArIgcp/Atp3QH/insyNhthLqFpIZQQrn3SqBLZ+M4SUPN7eTSinS?=
 =?us-ascii?Q?9yeU1nEDnZ3JZ317ujX1IF4qvCzM9ixg+B1TxoE/drE4L6JuYtzrhkIUwEDH?=
 =?us-ascii?Q?2cZiSzLE0YE9syCNrkEe4+8MPJDMBRr7u6pFXGCu8oe8TtClUtMRpczC3s4w?=
 =?us-ascii?Q?O1SQouSN6MzGbJ0Xa8HQCbyeDY4MZoM1svyGL+xJrCD1jxTB5AGc8rZw5Ro6?=
 =?us-ascii?Q?rUR/dtj09ATHJzcPliY3tpkhm/EF3kg7IoTsbB/EYppTvPPMSz7H9fXhYUL+?=
 =?us-ascii?Q?LOzYscQBRgpiR5mslIwWhE59ZeO4HodqBqVLsE8QtrYZ2vGdCRqConnKq3Q9?=
 =?us-ascii?Q?hC/Teb65xafiOmYOYD8dsWQQQ2kKIIM9aRsImAAe5+698OzYCDR1ESzsQiB4?=
 =?us-ascii?Q?TZRxj4tLM6oHXsrKZUbldZ5AIcUlyB+2ee7dZ+4UrigiseqZp68/NzYn1jpU?=
 =?us-ascii?Q?fRImBiHzZDmu+9eszcW1nP6byNeM5OyZXuQ/zVr2bZ8ddiVz5/V3axtV1rUg?=
 =?us-ascii?Q?bIl0HcEOR+M6twhT33iOhoM2OaMCDiPBkJpR8DCAnNrybtYMa9InOIJSTlZ8?=
 =?us-ascii?Q?z35/R5+sWGVzmKDBO2p1jckHAR9CYnCZOPqj1GMKkvhNOcwxUYsfou995kpt?=
 =?us-ascii?Q?Klg6Ilt4FLPsp/Ylvh5lY6UA7LCU4+W5XXA6x1uz0s9cFTKerZsjECq1Y3RA?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R4+JVCQKPDQKWUpuOqSKWOmbGE4p6mfoFvY6c2mss936GiS4BcsJYrLjGVbaauUdEcozF6q18PrOeRbDttRs5PYEWfB8mroLHw1tfSh7VTNvtGS4+s0rhbRZEuZcSAVl38q3pWnA94GqpOPC93M7FqophDMbCZNQKfdSVWGUSLhuo9AKJ6Wb0xybstpROLkjn70lErfWzxLVzKWEBZPG4mlNtagMKjqcy81EpQTg5K53tZr7RiLns6SMzwhz95h6FSt243KgoruWXMYPjMvHfxgximrWBwsXJB29u259DuwUzIvpWRdmyjG2LLsnsxn0j0eGFlo488Cpi8HeIfXT437X2V2jJHzlf+BDfrLyb5zo7Um2zRPAW7sK/1tE0l1J/jlSS9mmU0HQAN6AXnET4GVMs5JOMFIpYtLCVENBnxsUZTJojw4oDhOQg6Eyf0aveliONAyxC/Pw/FVOodIM6jR3YA9+8KEiBXylF2HsIkROPg+RYSbPZXIQrMZX7gsXoD0yV6l/XwSM028JHN3AvwfiWqOhTEyyyPulMMcAcEAvVS5xWCThMuLQ696y6GNjyc+jNvdXn+Rfl+83PHoEnbJ2sKt/+I39bX/6J8HOJ2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd8b2a4-ae9e-4436-b117-08de207dce93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:23:04.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr7s1sErD67Kma1AkIjfei4vrFAUbW9FNwkYvUbLutFEQ7dZHZOX+RS1S39PHwn64dFsnYSaFB05diRaNmgKrvFy8va4uYBoT/p358yStK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=927 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100147
X-Proofpoint-ORIG-GUID: 2kN1nC2HO6xWpdmRrEJoeSviH-7SUyTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzMiBTYWx0ZWRfX3MMxt6ZCWMTd
 GPPLlm77zKppe3C52bLMMlhdHtU35nzIZWjWwlrC9awkHGvO0JVmsoTnSQ8olc8Xk3ECEvm0/zH
 8hFI7j6jpwgtImA95WnbHCfRpC8lStZpB3+dt6plt7UTUYWCPPA7AQNYklSOi2o5MSBcRZkv37E
 xiZp78SP7QYa2WSgzYH1yRc52vyGCLUZHf4/EdzsqEFuyn/5FsAsHKLLc7i6Zhtm28XbRlo3in5
 Uus//l1+HAI4Kr9p2VJJpsswxDTcX04pM/bpEcn0aWVI8jRjoyE3WUEQvBPT6KPtN1ZFZug4Zzd
 KDsM3TZDizOgx7SGQffJ1UTiZij+RJP5QTu2DlcrbV5p2Yr+7UthzO6vfgBG9ivKsEBkrBtJMOL
 Mee4PJOc7TAG+oKFXLQ7uGnm/8OtBr8SsXYfyJBnJ2Q+gjBWBqk=
X-Authority-Analysis: v=2.4 cv=YIeSCBGx c=1 sm=1 tr=0 ts=69121f7c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=WRmLX566G3Uji8YqiXYA:9 cc=ntf awl=host:12100
X-Proofpoint-GUID: 2kN1nC2HO6xWpdmRrEJoeSviH-7SUyTV

There is no reason why can't perform guard region operations under the VMA
lock, as long we take proper precautions to ensure that we do so in a safe
manner.

This is fine, as VMA lock acquisition is always best-effort, so if we are
unable to do so, we can simply fall back to using the mmap read lock.

Doing so will reduce mmap lock contention for callers performing guard
region operations and help establish a precedent of trying to use the VMA
lock where possible.

As part of this change we perform a trivial rename of page walk functions
which bypass safety checks (i.e. whether or not mm_walk_ops->install_pte is
specified) in order that we can keep naming consistent with the mm walk.

This is because we need to expose a VMA-specific walk that still allows us
to install PTE entries.


v2:
* Rename check_ops_valid() to check_ops_safe() as per David.
* Renamed is_vma_lock_valid() to is_vma_lock_sufficient() as per David.

v1:
https://lore.kernel.org/all/cover.1762686301.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (2):
  mm: rename walk_page_range_mm()
  mm/madvise: allow guard page install/remove under VMA lock

 mm/internal.h |   5 ++-
 mm/madvise.c  | 110 ++++++++++++++++++++++++++++++++++++--------------
 mm/pagewalk.c |  37 ++++++++++-------
 3 files changed, 105 insertions(+), 47 deletions(-)

--
2.51.0

