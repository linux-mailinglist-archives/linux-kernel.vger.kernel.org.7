Return-Path: <linux-kernel+bounces-734031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA448B07C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795653B6E57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA892F6F93;
	Wed, 16 Jul 2025 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FioIvDL7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vlXrU617"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7FF23BD0B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687530; cv=fail; b=Z8dIY4Mg80j6q6ST3AtTAybJwulBsa5adiB7f6B3Esypw8COo5WoqM+RiV+kK7gqF50QO6kvRBbGI+rzkWUb2YTeG5P134TrMDHR0vS8UZR1TMVVAqjjg1Zz6NJH3l6JZxX1HAOONSe6f1FE8DtnDxMuKjkLRPkPPp3FeVuEI74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687530; c=relaxed/simple;
	bh=+2BQJ9UNURcE0K95XlVe4cyG0JoXWaU52im4FKBVuzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJmHOEUqzclrFefIsk6MoVGi1pnwfnh6vBpdTE1/HYSExZUP7NGkrdmTfsEMPeQf3e3YPzzjp/bAIjmYV5D82a0wQ1lR532fg7Kbe9J+EzyPZqa2JFdtSdmN+10lhAx0X5qsYY/HYmZPr/ECuEDrRa030fbEjlM40XFfoU9qCwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FioIvDL7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vlXrU617; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqQSI025000;
	Wed, 16 Jul 2025 17:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nRXAw/ySxM0kZIdLqpkIstosYWCmyi9ku3bEi5jfmoM=; b=
	FioIvDL7czuJY99oTFBDj6TH48eFh02vk5hgNsPjWQgYwoAlmZF2kHYVZJxj86eJ
	CW6SfXoE45vLAuXlsJVY5ZAFDKTGK9pHgEo39T+XhEFDM45UUsaOrJTfTKaH4gkn
	SStRBFk2p/1dwy6S7Z0J0G58Sh6goeWKfv8zDBy5OwTrxOz7QXR9f69Pd4+Cp0kw
	UmdGUgNfX5j6XnkofLPSYllAjj5hmeFqww8Bpu7UrmagBJkw1e8UQBoXvaPl7zIi
	SpDXE8YDVKKHoID50NV5JrwICC3U7+wD78wdvMUiOs6vBqgG7m+X9WkYwsI2zgts
	F+i8ZEl2ax7t9/cvguIwlA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx81nsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGjssd029769;
	Wed, 16 Jul 2025 17:38:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bcnq0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4N7+W4Nely9bt3udLR5SDlXz81/P1aUFnMOHMpXb3wjcsziYRsy4Br5/0gfjVtz4KZ6/4JKj2Nch0vXupb05uHvJebsagCyvvOl7hrf7fc96qRN5eLF+KNHib7fvQ3capYX4JRDlE9ZUHf9nctAhrwLimP133SpqWFJHhA3iCEiE4toIHruJh60FIQXldxGhigmd5H3eGECOOxt5I9R/YNamUh7UMBT0MqB9AXbId1/+4ahurjf2Hm0hwB+oJt5r1AvDHIPK4CLURb8YhTRtYi5ZPQC9QABtqVEacyCKjPuncw2EA6sWDifmjPGiOSXiyLNPPTVXxC8dQU4bsyjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRXAw/ySxM0kZIdLqpkIstosYWCmyi9ku3bEi5jfmoM=;
 b=plo6uE9pku5w4H1sgNN0Qht8WqjFJSRdjOIAuwzMEyB0H9T0JiTOGfVL5YqygkxUrITqXS/63h1LNFt7HVUSHKQ9HqN+a0vyEpHOXGQoEb6J9Onmo8DhqvFXnoHQhLlS1WDGkdilI6lrL1gLf6T3smbhQ0Je1GIdEWVxV2bpH1paCmtAYzFWW0NVvW0hleyWhj3mZc3WqpwH50fe/+c6flqdb31LgyDwDLf8oErRX1pOF4OZwj1J9iTX34tWE5i/oW92HfuA0qLWeaVpnirG6AeN0JgOIflntDjq0hLFBZcsWhSjVcHUHWuBj/Fsqcm32vm5JXA+wgMzeyf37EMLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRXAw/ySxM0kZIdLqpkIstosYWCmyi9ku3bEi5jfmoM=;
 b=vlXrU6179Fh30xTY2+J652DIscC2K8S3HIXw1UCaowj5DbAW28grvgv46ZflD6hNSQJuhb/8ilhh3J0fbPB7JP2WOO+CS091Igur4ti7w5j/YKQUMMejVJAfBbTQO7kyQwvSblUY5rFFDkvvgrrQjTauKoFVDz8z3dbApL28OqA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 16 Jul
 2025 17:38:34 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 17:38:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 3/5] mm/mseal: small cleanups
Date: Wed, 16 Jul 2025 18:38:04 +0100
Message-ID: <ac51c2a3c68a2475149b54180ff012fffab72c02.1752687069.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcabc9f-aee3-440b-ef4d-08ddc48f919b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/p2DlczqscLR8wmrcU1TuuC3cBWOazaWdf4IhSiIXPgGCDA2mExEzj04kPIi?=
 =?us-ascii?Q?KwcgS6ABd7o51B5hFkrvY0pGCrwlbeTg2agDfGVmKgd/gIPgc/E9y4upgBXV?=
 =?us-ascii?Q?RnYfdq0YrrDAgxLETK/qgvHYkd3wTQxzw0TlT8+qQ4g6Q+I7BlrJDCODWHte?=
 =?us-ascii?Q?nkN7gcYvZJR+qbjmpaGgYjJOjv2LBM1DfKggRtdzfLO4wzPdVZhMrqeV2YJC?=
 =?us-ascii?Q?21bvxZ9vOgUZTfWJEROqQ3SRtTHx5sW0sqMzKq12kkdy7baxRhlIXdxE+N3K?=
 =?us-ascii?Q?eadO8oRcGCI/2BDM7Rkl/IwmfP+lHW+QKguwtI8A+bn/RkwPWGA7sh1w2zY0?=
 =?us-ascii?Q?jzlqjPUUx6G15UMnKkBNA4x/NjaZoHXZ/Yg8bEJ9P71WqZpnR8CX8NROIIAh?=
 =?us-ascii?Q?6LgdF8HZ75BHzT7UEJ9WYaL623PJpBmdU8pkCPo2Yk8vJAgVzyAKbcRfMAAM?=
 =?us-ascii?Q?dvOjB7JygPlQFJyVnHOSO4SYmmNBZr3qOOnm6srK4zwyzjWc3fqe4UnwaKCd?=
 =?us-ascii?Q?gcMUhLYc1HKXm9micXfKAtU1FdHjG8FwuQ8zyvCfQvIIaAPAt3XnThzt4tM9?=
 =?us-ascii?Q?oDPZVkZVuX1uj3XvhvAQqUlnxmVjqtR7/Pcq/x+9wzmdFwfTM81ZrHVtgdWh?=
 =?us-ascii?Q?uFQkqdfCOZpvCbJvW2vB5laYMj4LrYJMi1rM8Y5xdq3kxNivoYax/eI74z8v?=
 =?us-ascii?Q?ofYpQP1OTbfH6ovU2EzsPOMaRrruk8+uxw44lvVizQw4mxpAhLsilYpqalaE?=
 =?us-ascii?Q?i6RmPQ2fQHRbKJ0cPJLQhC1IUo3QjQvt5Rk5QCHhTb0Ycmhevr+RSmXZtN71?=
 =?us-ascii?Q?FNkp/LtcJUoNdY53XeYnvwuLxnrB5jYHWW7fSu15dIdZpiMMfoBsnEXs6tX6?=
 =?us-ascii?Q?FgXIOMRHY8BiA9/UELfYH5lh3dPRn0X3tQAYZ5hGWAjCyMPSjfz0e0RySg0s?=
 =?us-ascii?Q?jd+QLAS+bLTQTSwF/6TGax+nYvA9Ar7WS0gQo/c08DmFQbxg/IgVpdJ+PdwD?=
 =?us-ascii?Q?69Kzxq4rccHod738z2bkTC+/f4hFInYQtLZPKePk6cQbjf1NhFdJbwXZEfHY?=
 =?us-ascii?Q?+T9VgttGEEYQMbZQ2Rg2CNppYdQQmxXgJVR8TOkUOsLBLxkg8UGDqxj0OZuy?=
 =?us-ascii?Q?XuvK8uL7gRCoPbSi/wWhc4hw7rqm899DrFBIB7az9zDxwmf/wBQBV9zIOt4o?=
 =?us-ascii?Q?VJqy+SbiewnAk9jIUUkUuSiYl34ORSyDmssec5sLcUdQwANHuRc915QN7msH?=
 =?us-ascii?Q?Ep0H2zjpUTDN7z5wOVloannXYHYAqwsuRpKo2kjYmzjkc5sPcOvGxIhr16Hh?=
 =?us-ascii?Q?Ec66stNGmvUUYxlszBXmxpsjJU5zT2Vq3vPu4YF2WHE+Q5H1toW51C4uDzqp?=
 =?us-ascii?Q?LR0UkhIploK3nTPnaYrmljfKLOPvTnzrVn1wpdx2Zwh2CpAq8DXx3CEA0NKh?=
 =?us-ascii?Q?Pd3gcV5H4Qc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1YjCwsn1AFrvCyb4Ud2qKaCJYQFCwV/n1bze9A5Azx4NSQ72BX0cjCQZjRP?=
 =?us-ascii?Q?nydU4d+yWsnWzNmRnMBozR/iW70L61ax9WSWpi2/aZnkIiBlpLAopYaraggp?=
 =?us-ascii?Q?tx0UvjxKNgIl+Hp/9gBpVW3ghV/2B03k5l1Oek7Wmwyc3YrdP9KpbSutkz8/?=
 =?us-ascii?Q?0JmjD8XLLAHeiQAydeYYKwjB7B7BS1d2Yz3QRqOSsukg+9SjBPd7Ml2IsfdE?=
 =?us-ascii?Q?O9YCzmb/UsR46yU1zH1VGaM0WM8MmO/GBkprxNbJ4977DvIGHxhHSxMybZEA?=
 =?us-ascii?Q?wtSviQ9L/NS/gy1o1KaCCO46L4vqNGkIK7yAGQ3qbM91ipltIKlCpxFS3pDd?=
 =?us-ascii?Q?CAMJtzFizjXLQK1vz0XMSjRPxgwnoXw/gDJU9dHp39YQ54qcMEHn1WtiN3yq?=
 =?us-ascii?Q?IxxDMFxZezFxdheboNUpNnW9HiHzm05MH9jVSbwkZXA0qEKVebFUoz7PaJ/K?=
 =?us-ascii?Q?4VdpPSQtDH6AvwvwOtCTIFwU4oVrxQJON7V4E5blDBlhuSY9tVJVAiY0rW7G?=
 =?us-ascii?Q?aPm07gb9nfRMeW/gKITtHQ7dfkVqTnmqwyf+cNJNtcBrzRNAdaX6JYCVSSLu?=
 =?us-ascii?Q?SctzjIaYu7E3QNenhFgROKx/uSFeO4gupQVN4awwzeYCqo90nGZW7npv+oWC?=
 =?us-ascii?Q?LgL3dlf5aB7p41aJwbdItl+0EMf/NVI5AavwR5a6xJVkP8wqkvlrJKZmyA+c?=
 =?us-ascii?Q?pFGPPXavlZyH8XjYQ6pwkLfm1o58oakK2v1eoEjVYOclY2KZkgtLF3sKqf9s?=
 =?us-ascii?Q?tRNdHl0WUTGSr5UYizigt5CRYpQRdepWKLV2YZSEG7k8aSp56x+dcFmkiodE?=
 =?us-ascii?Q?S2ZfLU5SCz4rDx/s01eXJe+OJqUIApixpYQjYIUL5P7N9QGXGIDEYtej5Lze?=
 =?us-ascii?Q?Zi0JkuTdDYgRmns0giDd3krbZTDMb1uAhteELXeF/y2fXffiGHpZAd6aLsqc?=
 =?us-ascii?Q?S5hx/q0tFFVVh8s1f1FdLIVRbXd62aorWkKaOHFgmCW8/PiQAtb/OU2dmxw0?=
 =?us-ascii?Q?F7KEGNvHkqZ5tfTbg8pIh3Od9nIWNnnSh/ca+SnLmannzHiQJ6iJUr5zamUC?=
 =?us-ascii?Q?4RvYlSnjV2Nl/aKZFNrtupIAm6LO7vgPi0YYG96vzkZXdBITuG1OyGEY4UeF?=
 =?us-ascii?Q?wAuUO1job0iOehwCZ2vURURPQ9vqaz/26LgxOjTCtv4wnwiSIKNVaFzLoaOH?=
 =?us-ascii?Q?ndys8u+c+UO2oIXVK40ls9fzAxHvvzXCwy5p+vfb7lTE697N+lUHppmBL81M?=
 =?us-ascii?Q?aIdcqZzNNnyY1jOUKG30IzEFR0Xp8tSepP0LIyMGCbRn3mRSrUvSgi5W4Ial?=
 =?us-ascii?Q?nDtMI+cn+l7eDcJRJi4G6al3J6CTjKKB41rnBRBYiP+jo4Vmfg5CSoJKrMOb?=
 =?us-ascii?Q?ii5pOlYht93BcKihPRFzURt7DYJNW4lDATk21wsms2beUiOXULK3wSDoP8a8?=
 =?us-ascii?Q?7bpVP3qvuDQNJ6546gnviaL7X3Tpz7k8IM75mES/LVN+R8bUj2RB2ZoOQaBA?=
 =?us-ascii?Q?TxCop875xeZZeUA+X1nvdWI2pRLUQzbaHqcwP/cSwE8Ajbg9A7osy3v3zT20?=
 =?us-ascii?Q?bvTCqTfsJsU73MMLdnTHHEG17Vd+zgesMEK8YivU4/NT15RNjEGI+iaNSvV2?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jAn77fI4E6LDpI+xgc3ytgC8CVZr9W8kst1V+aHTSadHLntqhs8LJRi7VecIau2UQjZl7g3+WlRpeEK0aWa8la4pAD4PP+I7W0DDCTy18OudnxF7eX6DsYvJt1srt1a7KiZCxGzJbbBUjJHuQX169bpBiTQrilLdKYmLcGJ/hizf6TIdDyT4GrvSDeKEB/k2hgULqLRJSMOeMpKEnuW0EqIAxI5tmM67zi4N1kcW/6/gSiWtz+UExXLhjw7yAaa514gugJIUjmnBpoFjN+ROYPw3G+5nyFe3pkBgPmYR37UWxhNuNyB/eNTszT4IQ6aJNHyDabudTCwvar/ZQBGg7ve6xtNLmUAYEqQe3nwXSc6RZb4p/2zK7dML4UwRft5SYJif/r5exVSQCbgKmjlzE2zsW9TXOG6jN1aSejOHyiaDe/8OjvX5elJmEVaudh/8Fk3pGXmI2SpJmJSLQbZgR5C34jXJS98T1KCM2kGOKQfKtpYd3kc5/kuCNRLXHiMnenil2e938U+3stRE8qdvwlxxE8f0k9qyL9utem+PcQpTUbeS5WkRHU3gnyZuRdHUvdvt0ZUksq4spV4wDdF+ZjdstkFu00PyjgG8BLbDGw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcabc9f-aee3-440b-ef4d-08ddc48f919b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:38:34.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8/pzD/+qOPMLziHq6iQ0m2l/DudbzUXYoDQF4OBxwanOm37vxdab6rEwGNhbXcVHUqAh5WbyKKHjr5ubsykmUgMyWzAiF8ZEHQIlQ2J0qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160159
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6877e39d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=m8tF4krmssD7b1Yu0uMA:9
X-Proofpoint-ORIG-GUID: N7kaRjSeQsqZnJaFIKpHwLYLu_HOTj_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1OSBTYWx0ZWRfX1F3/qTLAzkrx A+aeleF7eAGLevdAn9nKszEwcbQHfMDrqdo0Nm74HyLAkNLeHenMkitPcLzEcm+M7AL6Gm/tL4X Emtw+U6IHbQteVmsSYuC69ziBj0NCzjaOwbHzY0Um90ixHAJf1xkwyfX89RboQAEmKgsHg+xv9v
 gIoSUWgDdD5wkNYaJ17Yjz8kNaXnHmZaUjeR+lnHd134d/7vgirt6x5qerlYuPPqYO0yprjgbij jJBpOtbesVIqW+GPHuEJ4IXuAYHe1tYNpkubIX+t3xqrqWmjnQFdEjPhsJXkqRJB2WWXjQwgZpq OgqPw9nHWTlNP5TsfmpXnPOdr2tCrx4jXxDu/6Myz1qtiTB1SUuAqrINHly+3X9foz6PU2SMX08
 pZ+iqFHJmHMzjPzyGy9G4te032dxjLUevpBf+fBxuk/6FK+487ujsq1nImmB84dlJ4Bt2Bi3
X-Proofpoint-GUID: N7kaRjSeQsqZnJaFIKpHwLYLu_HOTj_c

Drop the wholly unnecessary set_vma_sealed() helper(), which is used only
once, and place VMA_ITERATOR() declarations in the correct place.

Retain vma_is_sealed(), and use it instead of the confusingly named
can_modify_vma(), so it's abundantly clear what's being tested, rather then
a nebulous sense of 'can the VMA be modified'.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/madvise.c  |  2 +-
 mm/mprotect.c |  2 +-
 mm/mremap.c   |  2 +-
 mm/mseal.c    |  9 +--------
 mm/vma.c      |  4 ++--
 mm/vma.h      | 20 ++------------------
 6 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index dc3d8497b0f4..da6e0e7c00b5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1286,7 +1286,7 @@ static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
 	struct vm_area_struct *vma = madv_behavior->vma;
 
 	/* If the VMA isn't sealed we're good. */
-	if (can_modify_vma(vma))
+	if (!vma_is_sealed(vma))
 		return true;
 
 	/* For a sealed VMA, we only care about discard operations. */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 88709c01177b..807939177065 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -605,7 +605,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	unsigned long charged = 0;
 	int error;
 
-	if (!can_modify_vma(vma))
+	if (vma_is_sealed(vma))
 		return -EPERM;
 
 	if (newflags == oldflags) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 5b7fe8f36074..8e93eca86721 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1649,7 +1649,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 		return -EFAULT;
 
 	/* If mseal()'d, mremap() is prohibited. */
-	if (!can_modify_vma(vma))
+	if (vma_is_sealed(vma))
 		return -EPERM;
 
 	/* Align to hugetlb page size, if required. */
diff --git a/mm/mseal.c b/mm/mseal.c
index 1308e88ab184..adbcc65e9660 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -15,11 +15,6 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static inline void set_vma_sealed(struct vm_area_struct *vma)
-{
-	vm_flags_set(vma, VM_SEALED);
-}
-
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, vm_flags_t newflags)
@@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}
 
-	set_vma_sealed(vma);
+	vm_flags_set(vma, VM_SEALED);
 out:
 	*prev = vma;
 	return ret;
@@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma;
 	unsigned long nstart = start;
-
 	VMA_ITERATOR(vmi, current->mm, start);
 
 	/* going through each vma to check. */
@@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 {
 	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
-
 	VMA_ITERATOR(vmi, current->mm, start);
 
 	vma = vma_iter_load(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index fc502b741dcf..75fd2759964b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1351,7 +1351,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		}
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
-		if (!can_modify_vma(vms->vma)) {
+		if (vma_is_sealed(vms->vma)) {
 			error = -EPERM;
 			goto start_split_failed;
 		}
@@ -1371,7 +1371,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	for_each_vma_range(*(vms->vmi), next, vms->end) {
 		long nrpages;
 
-		if (!can_modify_vma(next)) {
+		if (vma_is_sealed(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
diff --git a/mm/vma.h b/mm/vma.h
index 85db5e880fcc..b123a9cdedb0 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -559,31 +559,15 @@ struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
 }
 
 #ifdef CONFIG_64BIT
-
 static inline bool vma_is_sealed(struct vm_area_struct *vma)
 {
 	return (vma->vm_flags & VM_SEALED);
 }
-
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
-static inline bool can_modify_vma(struct vm_area_struct *vma)
-{
-	if (unlikely(vma_is_sealed(vma)))
-		return false;
-
-	return true;
-}
-
 #else
-
-static inline bool can_modify_vma(struct vm_area_struct *vma)
+static inline bool vma_is_sealed(struct vm_area_struct *vma)
 {
-	return true;
+	return false;
 }
-
 #endif
 
 #if defined(CONFIG_STACK_GROWSUP)
-- 
2.50.1


