Return-Path: <linux-kernel+bounces-808893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FCB505E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9B3B1A25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546993168FC;
	Tue,  9 Sep 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MI7MkyKL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T2IS4Hg/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63923314B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445036; cv=fail; b=GKvJX91bZYBWmgOnQyec699rGNCOkeTro2Y5mou/MT4YNJhP0t+tK8YbiXl4WZ2WbMbUsoqBHUywCBO0dY9mldqelOtD0cYLX2UmBx26aFaXAYMBF18EdBiMi3PIQyiUiJuRP81+9CbKTruH1KlMKf8SbLU/gsjrEkoerqKaIOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445036; c=relaxed/simple;
	bh=EfmpKKL0HjuGw7uhONUMK39CjiKGDIddra46LFx4z0w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sg2LcQ4HzD92nlGmZZGhlqKFrgePLl7B5tih7AvTdnlqxeDKSFaTYexO2KUrnce8ATRSClNeQSvOgfNnzuO+r50yAsBHu5dNukUWz5F8RI6cv9iktF9dyxJOP3tBTBT5eofOJ5istD1zVcHQ1Ch/mnX1bYsK/VUBQB6aAqtvxys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MI7MkyKL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T2IS4Hg/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Fu10C017787;
	Tue, 9 Sep 2025 19:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=KCwoB648AgS7Io66
	c0wn9LM/bnawRWjb4LfNizAWeZ0=; b=MI7MkyKL8HMWQmSgtIzsw8Oo6uHjm1CY
	joFlRrK9DZejI4h4UxcUcHwL4VlUkDLre9HjcTRC24CSDI9nnh3+yqtUm53UP8SN
	cJfhL8wuFh/2kGH5WJhOMOQWo0GnIIfmYHu9sqrdTE/umz3Is3P698R/9KFwuDtW
	SOri9OOp+NjTw/oNkh7BoS6IR9vhgbTCBgRhXHYbLpXHK8NRGmosm+Ksss/XZbUK
	Q2YOojaebLjpVVredgyK/sSCruloF7flB8qM54Xlwp38ewM5SrSeXicC56vEQ9xB
	GkWzS6c5S6817smxwBsryWvy2E6Z9Obw0tkWYOJmcYgJ6XhWZ5Vukg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2tr1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:09:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589HjDTm026015;
	Tue, 9 Sep 2025 19:09:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bda224t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEpf60c/TlJxV2KFrPKlyRXPVIR9io1lH+eSn014YNI1BgLJnymi+NlBKr8Yg0QESQDY710uxrXUFNEYFa2PPKnPM9RlGUqHVzR4DIpiNT00dGAxANZsq61LheuQQJAOy71ZrKa593021Pd3V8d4TT5tnudJbbdX+O24hSjOGqLkfpyygt76AU3hVpLt2yRDv47jB61Od/hFYR7EoX6vL3Ia1lXo32MkSagBwxSltOIMZmxwg0d8R7lKInt8SdCcwPh0D+mh3blzk1s8qUFgN4ewluPptvAxu1zeSDnBepXNA3y2tXU3ofvb3zNAa+CAamdk+n2XvoSzWp2ZfVl2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCwoB648AgS7Io66c0wn9LM/bnawRWjb4LfNizAWeZ0=;
 b=Fwk2Kx+XQoRhxpr7Nh/VHQ6RkmFsp4/b+DlMwDbpHaCqBs95teQSYzeJGPk04C2SZOIAuDeZhTAgSLyo8ckl3uBRCQjqiirHv5t8vGG62PpFI1SJQzIrr8fwR/cy+vaQyMcRF4XA80fZqyVzoqGoVV9UMmBL/aTb4X4TGEuCbzE8tRro1rzKyu8b9rrL9gO8Hvg9c1Kp5Sr6s9Eclw0aNgpb3E8ntt4QsD6ipRYjHMVPzsHb/gyBYOatCLJbrgt2NblrYhTu+rDdqM1wqvbpMLIia7YRfmPQ77VUvVo0pxlCcH47izL1BWE6PY3MEkCywqwUq64yW4B1saV3xQ8/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCwoB648AgS7Io66c0wn9LM/bnawRWjb4LfNizAWeZ0=;
 b=T2IS4Hg/G8GNksdq0iKzSod+q3jIEXggJat/sPwGP8Fain1w9axaijRy4LtsQ3QksEyg5Q/aZQqLvlu7vDJn9/ykDTiOzPEL0IhRdBPDOoWQnkONtbYTWifNgdGtkHftDgz43gEyUBXGD2Z46orDOEr/G8SiSbCjClbFNi3RYhI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7052.namprd10.prod.outlook.com (2603:10b6:8:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:09:49 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:09:49 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v1 0/9] Remove XA_ZERO from error recovery of dup_mmap()
Date: Tue,  9 Sep 2025 15:09:36 -0400
Message-ID: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ae32ef-e6e9-4cc2-e865-08ddefd47250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZGGG9gr17MH4Gq24Lw/6ocuGtVLWbmwHfXH6SLT9VIdS9p1ynsckMcIMAE7?=
 =?us-ascii?Q?CGqfzhZqf0ceIrfNwd6NG06pX9u55tNITZRxL1YbPqKco5zhaD0JJPtCZ+g0?=
 =?us-ascii?Q?yzWFM9s4q+ySINaT8qyAJnc66PNxItsRFrX859R3+fWqaGzRFSEVfTOxKS1D?=
 =?us-ascii?Q?8slkPXa2DH8jwTIqkKSDJLdCPB6jj14tGeH1Zv56epp2v5Pmw0IUFDiySo+j?=
 =?us-ascii?Q?eanqSquAFiImLk27L1w0/rnQT5ckN+9mKWejuMLmpR6SfgO53ah8Ja8RBEmp?=
 =?us-ascii?Q?+U3szvNnhEB0dDuGDb6yb/X37pDGem6kev2awNNb/KtH2Cqyz3Z1mF6qHrrA?=
 =?us-ascii?Q?95hdE9SLDD4tOsPT8uihD5gTfQgiM20ChnyBYpdx+FOWdk9m5ZpSP3AHiJFi?=
 =?us-ascii?Q?G0Z2Bhz9sJTLKr7YoQBqE3l0jdc1jcSvUAkRjeMArE+YkMMrdxrsxzwanWma?=
 =?us-ascii?Q?GdsNXkhjbEc2va8HHvvRfouPZGFEv/PYNGOj1tIKnU+xr7x8f7ICUa9dG+4Y?=
 =?us-ascii?Q?Lk5q/kQJ1jHL/fWthupkxU/dBJY1m5rvOm9MXZE+en/JbjD4ah/Dv1vBco9P?=
 =?us-ascii?Q?shbLtKMApPELFTjxeBtHM205nQNPnw2vPvrPaP9b1Zm7LTMX1fNUgZzf4q4E?=
 =?us-ascii?Q?oWPZPur7Us/Iy3+vqMggCxVdYovwPIfhlflx7jItk1DisEZItHaAOtCmvik1?=
 =?us-ascii?Q?eQykzZ5luV30WPlRPt1TI6LYJz8yLwl9xgjIuzMDv4XL99uz5QMPGt6IFj/m?=
 =?us-ascii?Q?G5pLo8plf9+o8hbn95vye6D/QeC0i8l2a7kmpeadaBJr2v0OiLJPFPoIlGUn?=
 =?us-ascii?Q?c8hyITrZiEIzVVnmn+2r9Me+Z3b5nbImO4Ih3Q/HvTadWwKLXTvA1DK3NZSH?=
 =?us-ascii?Q?EjVRrzKGdv37JvE92KxX3p7ajIHtnYgm2YiDqWs5CJ4eLV9ppM5sYFvwqynT?=
 =?us-ascii?Q?EWMXzq0CEiliyL/EZO2+oIUkskHkaj91ysPf1iQ8yfTzYhsG+O/Kj0HF8+Qg?=
 =?us-ascii?Q?XdLQixEQAsxO99pwKFaYzA0H89PViFP3/+H04/ol+joVtyyXVopmke0EXjQz?=
 =?us-ascii?Q?6+iVr30ipAaolibEroKzXVOfnCZIOqnVl8LcJUHV0uqcSSusbdlQ7/MhNEK/?=
 =?us-ascii?Q?uijah9UpPxF44EOj7CEFZfvzfS2ORJWMkPzBLPfGHKqi6QU4J7zyB8bCiBrb?=
 =?us-ascii?Q?pO7rCzsz7EeSX/fpIitQbzQKwH9VINOT+AFjbJDg7YHgPpJcAMu1PAZh8m6q?=
 =?us-ascii?Q?fFKTBKAiTdru1VsJ0W2iHYKcE51CRL3eUJ8AJrBQT5OK8P46UD6Xdiy57+mc?=
 =?us-ascii?Q?PJ5/WeH/rNd9NQGjIuW5BKGszcekGFVSln5sDIzbL/tFvlPD8P99aVG6lX1T?=
 =?us-ascii?Q?1/RtUkvjA61QgLrGGJD/L1A3Dl9UMFUO9r70tr3ct1cM6MPDNkUl5FtGZs2/?=
 =?us-ascii?Q?zBpxEXzhKFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnLYow1cFlKqnRwKWwGUOx/DsP0eQkxOfrKPBDGuQFeN5Nw/lw9yCv4s1v3f?=
 =?us-ascii?Q?1p5yooTEBlBqlPVVmuyBpykhekonxkSzoETcIf13ByQu5facloXZB1szmoJX?=
 =?us-ascii?Q?E9EleZGinvA8q6QRNTust+XqgiXsJBXf+ENYFa+BDlR2atMqeKuQlpk/UMRS?=
 =?us-ascii?Q?nYgHWEoH+uorElwewIdIriYOU4k970La/AYLO1qhBofFHolsDBXuWrRdKtEu?=
 =?us-ascii?Q?PDoYKhrG+OdlxxH32TRKbSpoeVvgAjELQs+EKXCBuwj/2KB/26E7gS0++ef9?=
 =?us-ascii?Q?oWzTukdYmBNLk75AVtaJJMsJ85KCbaB9K3mpktSUR+j52ur9fgEAcMOgRqQS?=
 =?us-ascii?Q?Q7NCYKn5em61YHZ7Iav/CUks/J+lBQpPs7ktPaMHcYeRvGjc/eRWesG55NVn?=
 =?us-ascii?Q?5y4N+Ym6RvrVScXiW8scQaQNxBaF1XfxaJ036m/Bm7AJ/MSznr9ezdh/6+5n?=
 =?us-ascii?Q?RGfhPnjd3y+IGwtB6QSzxMn31HC/F+xYI7vQgPP+6U4RQlZYmUO4KWLYkF7H?=
 =?us-ascii?Q?6udAklyJfSU85/cPtwr2AAss9s4tk4gUHbhcs82buEQ89brm0DvfFjjQ6HRC?=
 =?us-ascii?Q?q0ZWaDhqN78TeV738pAa0rbJtM0G/ESEYRHVmHkuUqKjJtSEvitAJfhWbSW8?=
 =?us-ascii?Q?BvXz7qq9Ql1JRhYpZPvcRViVer3BqEWpvFr86cXEQT2Xf4l2ZloKAPVioFR4?=
 =?us-ascii?Q?nhJOw9W6i46kLuYVXb/Fj5ZVWMnmC0lsun1nyMCFDR4lKPZ0QfqShS2KS07x?=
 =?us-ascii?Q?FW6nglN1pehjC5WHnD4u81VaEOSkFqhbKF5t4RuCUZ5m5wueeIyfqZKmv6qb?=
 =?us-ascii?Q?+bXZm1//qp/VrsYEqiv/LlRbcz2VVynL7bhs3urUH5IiOHrgujKKpi6SDq4g?=
 =?us-ascii?Q?aM6yvvnLZRV/6LPZQ8LXSH89wvGvAuKakjETS3Dnd1HIMfEHhsMjWg6/ChL8?=
 =?us-ascii?Q?RIkwz+J/fM6aYsJUzevAACCa4aM91zAYRoAEUxeH3or6LBajcCaIZr2Ke8VB?=
 =?us-ascii?Q?jgsHhnG+dCdG0i1PErIiLt8yyrjBhfybHcA4mGWVXSaeW8NwETspronaBFdG?=
 =?us-ascii?Q?VxeDcd7o7rw5yfyeO+vhbYr5XPVT+oXk525LEq1BSJwd7EPeJ4tcNC5QdpY5?=
 =?us-ascii?Q?bxvejKuGW68ZozfAG6fM8HaXaiE1XM9AdRGTtXUg/2Pj9uaDe/HXGTn//K7e?=
 =?us-ascii?Q?9139s9NNqRZ2WAN3bjQd5F9O6clCPKhNYDUAdwXrhB4n6to431ujDdC+XGww?=
 =?us-ascii?Q?fc0U2vBtF6tFLrT8ihL6Qf/9sNiKXP7V0GcH/fwgWpZPaYEzHj4XA5kGpWDU?=
 =?us-ascii?Q?l1xQ1k/5OmHdyaVc1343rF0xJHSmC6l7tjmjx9TQE3AX4v8HeSXkkB+Nsq5j?=
 =?us-ascii?Q?IHy6rdMMlaJm+jxGpvkq6Dae1jaXSSQET2muFDNLvY+DPeaSUzvOM2jTep0L?=
 =?us-ascii?Q?O4quTSI/FhUDzddJ4HDTfYoYdqMAZ/bYy8j1ambdUPeWZO7v/fT3MsrGtLgC?=
 =?us-ascii?Q?0fQ8wN8ojfg68NDquYNc8OCTs9rip/1cWXVyZz8ue+IReHXQG5zSUGB07NGh?=
 =?us-ascii?Q?r3nwgUDEtWcTJZfnhNc6j7toQw+znl+HxX0MNIVy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lSDcEGP41Q3MKUJC0eP0+KuadCHqcWJMfTIgCFE0XS7ssinCsoxHvEU7XhV7obzbKR857MDFNgDC0UGHHJ3MnPASRGV+LJU5wUGvM/QmipHu3b9QvW32YvChmixfqFHmYJb7ZqPe+ZK+X6ADSofBk7cl+dD8fsTAARnpqQpbYLCXdoHEnvhCEA1m2cxYQpMDK9gTpFGKUJfkXRyZJ/GRaYGicBk+gNpvGxJgJKjv+1bL0SMK90N8q3Ogp3qZAf8dSTi40TLk/kJsChN4PHarORF6pMpsd9gD3i0SdcxgddyxyKni2oXQTPc+1BGa6tBYPIMhBZdnMceT489+6aPTAlvnyl6B02sjcjt2LoPDRXwhRwukB1xPNZgWZ1HPdIU2vhBln2ySZ1QdeXgkWcNbLCrcMVrgr/7wm2qlnaY2+3mjWgX/VhcmvfH9G2QXQ0GmvtCJdDdE3ZG7BvTCATb98MY73sYMG7hoshA6JM5aEtPcTR27JZGM30OKoCinggniqh39SKa9cvklJjGffkIQl8fERu/h+89+ueYpdm3vaVUJ2f5qaETWw2q0R2xlOJGLMr7iKnYlZN/L/bJ2g4hOyfD4eY6/VR1xtM9kD7ela3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ae32ef-e6e9-4cc2-e865-08ddefd47250
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:09:48.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymLZvNRIy1Kge/bNfu7AcR1jgICQ7b6ENzUYNHeYFwDMz1mALpAjIyPbUPLAL2wmnLlX73Xp6Qk7gRDhHWSV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090188
X-Proofpoint-GUID: RXeoGNLQ04sHdN6Zj0wu9QdqtoOyexD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfXxD6kyl/tyYSV
 Tmc0Nnzx3fatC3imEoN2pSydNaJDhmI420mBlEeVOkAyr183QDvgw4na+8FAerttT+B69tQ6muf
 J7gX8LkLnC8VfhMHXINDT/I2VywuXsMztP1NijN1XAv53l48lXBFk6YKT9AqcktSAsimwEws13/
 vbJzDqlP3xk/RV2XhzhP+y58FrXTgvzBDTv49fWMc+s2Lj12Ui+LX+jebhDxDKfX6U+b37sDDOF
 6JUS82KZqhy7Y46hcR+kN689pk/Qcog8DNfIPbkbxMWuL/x6kuRTZomYvIndvWi8n3udfR6I/ws
 2jWzNLkC6mDFTH6gDAS5Qm6+41Wzq6Cm/IJVozQj7Sm6SYgMjjqye43ZXkEFUrtVyl2s3yz7wgP
 TqY0lH+Pp7tRm9a97Evv28ezAjy1YQ==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c07b80 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1Cp9xoOITP4FoG_vIv4A:9
 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: RXeoGNLQ04sHdN6Zj0wu9QdqtoOyexD9

It is possible that the dup_mmap() call fails on allocating or setting
up a vma after the maple tree of the oldmm is copied.  Today, that
failure point is marked by inserting an XA_ZERO entry over the failure
point so that the exact location does not need to be communicated
through to exit_mmap().

However, a race exists in the tear down process because the dup_mmap()
drops the mmap lock before exit_mmap() can remove the partially set up
vma tree.  This means that other tasks may get to the mm tree and find
the invalid vma pointer (since it's an XA_ZERO entry), even though the
mm is marked as MMF_OOM_SKIP and MMF_UNSTABLE.

To remove the race fully, the tree must be cleaned up before dropping
the lock.  This is accomplished by extracting the vma cleanup in
exit_mmap() and changing the required functions to pass through the vma
search limit.  Any other tree modifications would require extra cycles
which should be spent on freeing memory.

This does run the risk of increasing the possibility of finding no vmas
(which is already possible!) in code this isn't careful.

The final three patches are to address the excessive argument lists
being passed between the functions.  Using the struct unmap_desc also
allows some special-case code to be removed in favour of the struct
setup differences.

RFC: https://lore.kernel.org/linux-mm/20250815191031.3769540-1-Liam.Howlett@oracle.com/
Changes since RFC:
- Change BUG_ON to WARN_ON_ONCE in tear_down_vmas() - Thanks Lorenzo
- Added sanity WARN_ON_ONCE() to free_pgtables() for ceiling and
  tree_max - Thanks Lorenzo
- Added comment to free_pgtables() in a vain attempt to inform users
  what's going on - Thanks Lorenzo
- Fixed free_pgtables() in testing code
- Added struct unmap_desc to describe the unmap event to reduce the
  argument list  - Thanks Lorenzo
- Rebased against mm-new

Liam R. Howlett (9):
  mm/mmap: Move exit_mmap() trace point
  mm/mmap: Abstract vma clean up from exit_mmap()
  mm/vma: Add limits to unmap_region() for vmas
  mm/memory: Add tree limit to free_pgtables()
  mm/vma: Add page table limit to unmap_region()
  mm: Change dup_mmap() recovery
  mm: Introduce unmap_desc struct to reduce function arguments
  mm/vma: Use unmap_desc in vms_clear_ptes() and exit_mmap()
  mm: Use unmap_desc struct for freeing page tables.

 include/linux/mm.h               |  3 -
 mm/internal.h                    |  8 ++-
 mm/memory.c                      | 69 +++++++++++++----------
 mm/mmap.c                        | 96 ++++++++++++++++++++++----------
 mm/vma.c                         | 55 +++++++++---------
 mm/vma.h                         | 48 +++++++++++++++-
 tools/testing/vma/vma_internal.h | 24 ++------
 7 files changed, 193 insertions(+), 110 deletions(-)

-- 
2.47.2


