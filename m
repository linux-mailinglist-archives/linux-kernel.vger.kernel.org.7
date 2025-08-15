Return-Path: <linux-kernel+bounces-771372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50FB2862D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959DAB08003
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23E23D7F6;
	Fri, 15 Aug 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HmY/UYXD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q5aPkRr8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E31E25ED
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285093; cv=fail; b=ja2hzuDR+m1ENQWLodkhW8VXpwiJbGtOu9N8s2CWkypCxyc8NSpiz44coILheEDhSmVUjuDnF8ahF/KJLCbvWHlMkkkFckjUkDMg/zZExt52Lk6hLxnTqVZEZjECdeiPoIpFPiDWpIj1SDcTVhMCBCwZt4DMk1efBdJ7afpDkCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285093; c=relaxed/simple;
	bh=Lk+pp5ueAF9jl9xjI4dkHgIGXdo6J6esQZd9hqHoJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUzBykw6e5lmG6Dcc2H58g5nAwJvuF5aLDrW45bEaKLv/FnEIHC04F9X8AzQTtYiBL0JMXVSszX4ICf9oYwVgisGVOHktrSiOrxusH+xi4gYRYy4uthWnlkC5q2N09QBkdjkLH70pVLPpGd6WzJb4pQ0nuCwzrM2vH2zNx0EVeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HmY/UYXD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q5aPkRr8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHmBBV022684;
	Fri, 15 Aug 2025 19:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0vse5ELWEn6c7lnMQ4Z0Fv2MBxeJmeOC2SYKm0my1Mc=; b=
	HmY/UYXD7ELuXlvFoSQ2x2VP5V3HrztukboQYMaleCrCNmOsQ6Y9/2MlUIvoiq4k
	pKhuCESkecEIHjrt1o/1SgWGlSMDiBA3PSA4vB8jE1+1KzzApWNAoaaB7EcXJDqt
	NZsojbsosFfUuiqis+NmVb2TLgB5cNmNO5ifhssLgANfbSi1vWBzehxEz3tXsysP
	4LNQuFMQdw8jTmqumgDXxS5TviVZMMThWY6Htba5Un9RS4uh+iCAvwCpwmDyyMJX
	+9AX25dpD7wH2pDg+RoooeOvvhANMqQHu6n/uYFcwTd7dU1rX44Mu6SrI5SgzC9r
	ulsIvZUDD4y9jN5LjkBEjw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcfcn5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHThJt009928;
	Fri, 15 Aug 2025 19:10:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsmnb3r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTWN9VT/CeUEney+TR2viB8ZJJCDsbGrcE6yCWYTT0oIg5hxtZh5TYndCvFO/KR7dQ9grlD85xRCvlkj7X5WCNMOwPL+hniU5Gc2tdBuu8uCNTP6BlMXoRgJe2bYXU9dFVVaYu3rPqqTXChFu4hNG48qOtvRxAq82AJ17XpO9lD2r2T9dz+IOgeKE/s+TtZqfMr9A0+taJVZ1BkQfNt8cKRvTKZskQ8jAgDz4B0YVAtGNk1jNs6SgDKXp5RhWLutJ3VdidyMtF+rfggMM4LXRio40TsAmv/LIWIWjnUxTuRRCS5iA8gGMGMjh3XUihx14ob+yYlD6t24ZKvbNbK/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vse5ELWEn6c7lnMQ4Z0Fv2MBxeJmeOC2SYKm0my1Mc=;
 b=rVmJ/SPo+wWRnKtt/JIS/slTXPnzebHD9l8jZKAx/1lGcbAVZF9jE4m8hPNMvgZg9TialegYBgUGF3lmcPnEcdFs+AYvKspV/JwVUxsYzM8Ej7i380x/6MX0GX/1JKyOI13pxKy7U+UtHJ9xirIcCKaUAKn1ZFqoAvJ2gM4iA9khMo0vIRvvumajz42k7pCiFP7tc+DXbm5GSjOFE11jyIHgdswZGVcQ7Ywp5FipYRK0dFQwXxMGZcobcFU9r6k3IPtw3knW2BlJnPcLR0wcxA8e7wIHtnMSoO0WcCiO4pmafp4nPmSq5GvBkJEz1ZR+83EDwFlnyzBnikh/MJTPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vse5ELWEn6c7lnMQ4Z0Fv2MBxeJmeOC2SYKm0my1Mc=;
 b=q5aPkRr8ofeDgp3JtPaePCZkYQaihFlslkuJ87iaA8ZIncj6TlMvq3HT4Hr/rMzCLGn/PPYSkMfdQ3UBpjNFsDKFxataCuk2zJLN1yTVml+u0M1+cqKiIWpHdB+oPYtP56mxX7tbdPGJ6qBopcgnMUQdSqT89fGs5/tGdKFX8wY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 19:10:39 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:10:39 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [RFC PATCH 1/6] mm/mmap: Move exit_mmap() trace point
Date: Fri, 15 Aug 2025 15:10:26 -0400
Message-ID: <20250815191031.3769540-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: e6512361-6202-40c6-7cad-08dddc2f6c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BscxwCuaEMcva7gFhJr69NJB6Ka7acpBMFARgTE8cfthGLvWnGh5lGm1PpuY?=
 =?us-ascii?Q?kS6tmQe2xyKb0ur9fq6TdSRqrRrl17tuXCUJY3QmnW4afBHpCVtOIOIfKGT7?=
 =?us-ascii?Q?qQOhfjBDNZZsu83pBLvutK6hyLyFBJEJOLQ6LbtQxk906O4/2VwBf4XbfwvU?=
 =?us-ascii?Q?TUwVNUdwXw859NJjGt/rEWpLmUdgcfSJ0HzrHT6EexginQnV8v1+HZjQBAKo?=
 =?us-ascii?Q?1IHTzxTECQhqtILHDizzg0GtTU2NcMRNnN+qLdTi9FwMWbX3dlG/CRXfm2Zr?=
 =?us-ascii?Q?zQ6MjSg19luQ6mOoSYkLk+KJFTgKzWMo4FS4LfFmXGo4SH2uwEBEskbG/3Vn?=
 =?us-ascii?Q?sgmePcULv5Pz34rTOh5ZRYpfSLDsucW1SFvB8sUhIhZHGm89pbG4Ubm4wFEA?=
 =?us-ascii?Q?hOrBt9kVR8eHtPY5Vs30XnTgEVC0u2Q73WYxaqFNY/qezpkfVdP+KQ8/kObE?=
 =?us-ascii?Q?ADz1aT37Q0BO1K1FoIA203mJqBzXeOhWkK/c+34VILLAFrLKD8Ej7yFgEuus?=
 =?us-ascii?Q?DtevrWCKwJSUi1PjfeDCz9KH4drm0OVNWD/SDLM7hCoMLGw5Mg1DZJCxEEkv?=
 =?us-ascii?Q?zH/+4MDr7mE9Ps3TRRtBCYTc+H4cZe0zpQms8twaUQCzk55kjwd7PBTgIwBg?=
 =?us-ascii?Q?e5ODlsDdL692Ugi293tw18Jv/dDLAKgV/kxfB1FK5Hs9+wYZMZnarSs5fn9K?=
 =?us-ascii?Q?LyQuoATR060QFFqv7v2u8R5DSc4HqX/UMdFaBj8oYGGflwSpBLwZBfMViOsG?=
 =?us-ascii?Q?LeuzY+sB8d60tUqijfaD9Svzn8BapirosrBRBO2UWYGHvYUWPbAu8Yj3cQoM?=
 =?us-ascii?Q?6l3b40Bm1GN8HdnQcv47DAjRdxN14nJ8NSmtqgR2fmwEWc7fKsS6HU/PoftC?=
 =?us-ascii?Q?aeF7ElgDayFPXta9fZ36Kmq953JGEBuPUz+qA4jyu3sLSCoFbm7S0m87IXGX?=
 =?us-ascii?Q?DMLNpQmXzLSzVsPlwmDwJRBE0Ve0Y4cgsuayYQcT9YF/brJmUskbCF5YwPlI?=
 =?us-ascii?Q?Ul5hmUACC/a1U4mOc5urnkDi/QTDattbLn1GfFOj0qG2NqWucnK9h9G5dpog?=
 =?us-ascii?Q?xsjMe7zS6v27l2ZuQCh86dEFo1j61a6AMz/Ft1oGNayrJE+igsooDqkQI5Yn?=
 =?us-ascii?Q?TGzAsKpUZYIM5VQ3I4CrIlZr1IgzhO5H806EM9u6T9uP9Ad1wJAQiHdceeKo?=
 =?us-ascii?Q?MmwNz/ErWOHu12wSrasFR17eYgtEIGUCwOmJKc5BPjUsYj+ydPdv5ngxvp9a?=
 =?us-ascii?Q?KD9ucu4jiXx2ySSg7NkRWM5HLeNgRNVPQfaX/uPfFOQbNLARdaxS0z9SkiAg?=
 =?us-ascii?Q?RhY2o2g4L7De/MM4tUnKgTf6W+jxSDxFDK1pTlRjRq74ja6WeEmfZA0PeKtX?=
 =?us-ascii?Q?IQCjizws+gNyLurp7rCnAtX4/ItScYpB2MA8exLV26brtPpmSgsnjG9f4eco?=
 =?us-ascii?Q?iUf7k9kCkKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZsk/ugkBvZb6+k0MBwSy0yEAdeH2w2Oj4Nae2nf2AiWBB+uPbS2WfcpPtzC?=
 =?us-ascii?Q?s7oLQ6QYIt4zReEPhp/SL7BizcvKvI6BYxz2xqu2NxaPzohCYm5UyigEj+A0?=
 =?us-ascii?Q?oPW4qGS2ATvuuE3Bc38T2LVXiqHSs/aH8uI50gB/061l8mxStNoD3W2os7Mr?=
 =?us-ascii?Q?CsYKDt4ROHOECTNYLSic9tTkvbz9RnxtjkE46H7BzN8JyL951vVFGeL00MMh?=
 =?us-ascii?Q?5whl6puOT9oAk/j4139nC1JHRhdeDptiWE0eesk2Fnx5RDc7hA3c3hwXBjwP?=
 =?us-ascii?Q?KKV+AvoIoc+cpuV2ZoIfLnopgIQVtMBZ9ITOdcSlh0LkWFgDY7DXZjqVP4oh?=
 =?us-ascii?Q?ySZkf9x525X3quRKOwllRVnaS/dmmDS/9OuW4hs/UD0L4YMfKwaPFzR+Sy7y?=
 =?us-ascii?Q?X3/5kNwAJ8jW85/Tz8jPqfSOl4SJH3RTkQ/jQuBUSx0k0qOCVxQhN0hRLN+4?=
 =?us-ascii?Q?7I24zecytRsCJxtn2QsNYyCW4uPgjNTg/g85JSr2HK2Ztkvge0pBpAJaAji/?=
 =?us-ascii?Q?x/oqMQwrokhoji6FfUXzsWx8TAO5gGLjHjmPb4PqiWynl7MOrh3RHAo4TQrH?=
 =?us-ascii?Q?OS7IpDetEwpiLye3dst11O9nHEx9/iESMfABA46K3qrvaGTkU3LprH4ESTaP?=
 =?us-ascii?Q?Q167duBPZ+v5HYUtnUFMa3jgTd1XHIm2m8TdkcRYNlTcqvrolf/SOkzIBG3b?=
 =?us-ascii?Q?P7jcZP/mp4A1BeTtBhnSfLfna8SPGVPwDIEO17jDooFtAKj+2gFMHGqJy+V9?=
 =?us-ascii?Q?NwQ6sDODTcukkxyuusd6QW5HGZmtmGUg7aju69lHp8EWrt6JgRhFCLTks19k?=
 =?us-ascii?Q?Vg1gEYbqera2Z1ansT4ESXSmRmvgSl+Cy2oAniG7YkdvNXFyZff5vb2KDTaJ?=
 =?us-ascii?Q?N6geLCS3/64wYYJXTNrva0GksFCcTR1zuSQH4qWMDltQ/H6psI4prXVOOFFF?=
 =?us-ascii?Q?4TECMo+bCODJvrdbig/ip9YOYECVcEYw63mykjTi3YyZMjj7cZ30yE0DNcjk?=
 =?us-ascii?Q?mxDp4AAcSpqmdmjZf/jkiUuTUFcRI30aMvOYUchgK7B8JVxabCOfRDlSnnqT?=
 =?us-ascii?Q?bPWV3VpUwFx5HFpx6cZxVNjCmGxodZCAAsbnhRfxMqib14Gq37ffcclTF+IS?=
 =?us-ascii?Q?9FsGXij11SZ6yhhu3hwpwcmqbs2ulQCM8sy5BhYm9VzxhLAenQJkqikHhsCx?=
 =?us-ascii?Q?UE20zkxPZgy7v7kx/mgLx9bF3XgeDIPBrUorXqRsQwg3tLwOCffrUmWSB1Gc?=
 =?us-ascii?Q?CpG22vNbRqfaHeOsxJI6r76fYyI7zNb13SCW5kskKJt8wMc4TMer6JW0oiaw?=
 =?us-ascii?Q?CjD5FGNEbg5BFv1Aa9oSJgNltq+IXiLDM7V41iyFLq5uStmCh17sluGRaIpn?=
 =?us-ascii?Q?iwgOzA5e1PPil2QWvxjb27GKSdlr4YmFx5BA/eCUIVHolHYvWULi6zBXgozx?=
 =?us-ascii?Q?8aCZg7nE0tYeVQlSSYxFjvirwydjmCCzxv7/WU09WRK+sILV9X9CyYM+/lLj?=
 =?us-ascii?Q?3Ke7iJ/61gEE9i6BTueaG1hp568RLSRZneAkZ2U1MMAk4mjzdgxqYrDvllsI?=
 =?us-ascii?Q?bFeG0SgLLN1187FSc8xsRjuW04ErqkqjVyY8tlgz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CbbBi8jTeDkstQRq6vDlovrKRSH8VKcN5mN4Gw4kOhCG24cxDaPxZrrzLO+M4JmFhHUIRCFB+NUnyIxAahBW8kEsnF30+v/JXL35bJqZms1uhm3cYQIMs5KuetG42sjpXWUpWaeVU2sH3Rld32V9V5RXICdYEwAnrQ+oZAN+y4Q3Lut41r5kWYYgFz4DPB0dzo1g5CD4uJM5LjKDB8QM2YzMYh6msBcHP30gUF5iAhmDAASrhiRygZGCS79BzBXJ1G8RypRjvaBrI6dleGiCn0nTgitVz5fQz5OoemljWwFb0BRLRUEf6VK5WNtgj/a2aQaKGbx4RuR4HjrCOsIljvVHi4F3sOR+McnrxEGuOvfSheLLVgE7KQUNuOI+D5mXlMrdV0eKRKaiWEWZ8PxE0pnQhvJSRHM43tJsDaUaA7IBM+QXAlP3NRTiKMsr/CPYPjkqX6c7ewJvxLgWOUcNSFJgiJehW0Dy8qWlCm9DSEIzgWdfM7HMxtz3eyS11di4A3lQEzqJ3cteUDVtXnKb5VbwouGec6xeJZDOGThTKQAG0XHbqTnkQwgLcHJTPj+lAuxRk7aD+qbEgoDmYCTfZW5CJdrF/YWJeySGuhQp+2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6512361-6202-40c6-7cad-08dddc2f6c14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:10:39.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/R77kJ9gYoPbTrr+BUFwboyg6QxjAumkasy1wDdw62l8UcMDWK+RkvL2EVTv99YlGV7woociK5dGsd+KsPYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150162
X-Proofpoint-GUID: LLMNW1YfjRMd8d4DLmukcIkfQu_vJr5y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE2MiBTYWx0ZWRfXypsa4bH1f2KK
 OhCjo9nm0Vf6LToDZ5biYhBKOSpoFBKUwgq/ozASs/5lVOWUvNZA/FSoucHQmVyvsepqU2ASG4o
 NXUzlSaCF+6erJotidH+6RSOU8QtGvQiKN8c1Bx7m0nb4aK3jaEKkrYfQXNbQeDJf6XDm/iY+Eu
 JYkpoA/LbiM4JZrxvlLRMzxv2cH8D86BknMza+6agLP2VB2nzo0Hb+pS51x8I2shn70vZxRJ7NN
 I5uIEjROy/zvZlvd1fBVDgFPzg0I9jSX/u7/XB2XlVPhuqkPzyymx9BLUSvK+jj57erNhINNo9H
 45NTA2y48LqZxsg3fYFefnQ5iyta86SNyG0RTE/wluEGw830+iyfuDibZxslQCt9B8jxTroEsHW
 oIbIosHH8G+KYcFJ6uzTPBCc5hTp7+T0GIf1fjRaILQQKpf7ydum6qrLwttYwVgj9ZzM5zUr
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689f8632 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=tpUyc1irQyRqAcisbJgA:9 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: LLMNW1YfjRMd8d4DLmukcIkfQu_vJr5y

Move the trace point later in the function so that it is not skipped in
the event of a failed fork.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b57..c4c315b480af7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1310,9 +1310,9 @@ void exit_mmap(struct mm_struct *mm)
 
 	BUG_ON(count != mm->map_count);
 
-	trace_exit_mmap(mm);
 destroy:
 	__mt_destroy(&mm->mm_mt);
+	trace_exit_mmap(mm);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
-- 
2.47.2


