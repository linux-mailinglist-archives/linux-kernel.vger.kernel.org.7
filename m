Return-Path: <linux-kernel+bounces-786737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE9B36768
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43EF980BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21234DCFC;
	Tue, 26 Aug 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gCVDwyLF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QnEK51IP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE93451DE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216232; cv=fail; b=Zch1YH8sBw8B6k9tjyrvYAMMdRdqkqjXaF8CDrPAUo9bP5W1v4us89jtYq92pT6OKMxRfmiIgYLVXFg6QFwoH94R6304JBITJkULOxUF9zfTK75a3YRlIytNm02bwD2g8zCJtYO2gMgqGFbtcCGDWCcEalZkrhuebGFr211QR7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216232; c=relaxed/simple;
	bh=Ts7tWz/LC6PFC70o0qSjje8dk4X87EdrBdfwtEiSW8M=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EHVVKkM7oSeYCxjgZbpx0aBzM5I16W6si3sQnB3+aeYNgUoN/9LGRw8a0hoNF/+qHhc00BZYB9vMqtu/eB2reD+ca5ePCdUAB+DaC6pLZ/g1Bnj2G4wkLnufQr01cYI/gm0CAxl2J+8leOZ278C7hGVknLd9VLPJbw0co340UzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gCVDwyLF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QnEK51IP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCIM3H002893;
	Tue, 26 Aug 2025 13:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CF5meC3KY51Wlx7zYa
	FQGLhvJy4qwAC8YUU1Lhl6i8w=; b=gCVDwyLFxdSo732E4rj+NvTQHH6lUQUahV
	2+pzjqawvBVlMyjZfAf1Iij2o8uZmf2eNzqMJhATbeCE2ubpSXiIlvdH2FsegyC8
	GMLEPafhybirqWjliU3TkLSGTWZErv45h0zUfp4nC5UwdfCgH74cR7CHHYCqQjfY
	6S6IuU+SHNw7dWGg/H0OdsIsJr6NRLC53RHTbYMfV1hZFSSmlcxhmdYt0XgG9oGX
	O2epx5pwBHGyMAUF4PbXJLyZ1Rs7QBHVaF56y3RzB5oTiG2b5U6CjUVOxh1d70MD
	NX4N+RxHKKpW+4uA8JH7aeH2i3izGD91f5qYcVqo/yKpnowyMaFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e24j6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:50:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QD792w026697;
	Tue, 26 Aug 2025 13:50:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439g24v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NykTgneH995oNXrk+SYx+t6TfdSutKNV0Ggp48xmTugESk8H5m0HGaMeQEEcPKnyR2y60V20Q7sQ8O4Dp06PpHnbWvslyDY9YO0E4rLBFdj7eknG5gk54TNQz05CLvy8xht56+Igq13gdgns03jrNts22HLMYRCy/n4QCzX8qYi+84+EvBR41fdUFXsUL/7WdNQuQAqSN8A0Y3mwV9xIYWfc0/3t13Gg235qMTX0zzjKe+5v8+Pc2S3GWNiiorPHu/U4f/P8yv7bpTENHDoXMizajjoifodMBXYVm0u9IMs5Zk2Yhq/AOT+NUOZdkchUsCj12Tichx4xrd/mKRHxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF5meC3KY51Wlx7zYaFQGLhvJy4qwAC8YUU1Lhl6i8w=;
 b=RxtqHxkwef7w/ilT/J9d+7Psm4dfhZ5W2Q5hbPhtTVo6/rn+9NWdVqrwUZDt4C+tFxXrKryVirUCpJTmy9BgYO08fqGKSEz1roYPxbVBrvInynGs2gQu+TIlQS4ln2mwCTkE7QtGd+69wRIYRj/doCQCRDi5eNNASkHsp7+MsxJ4ybnjMYIvvj6rlyXaZPd3rsJ/xIGPtpcHXfuEhogMF+Qgt/VYjmOcMcQ/cd7NNBMU+t9qmN11Sp9A8DzKGWIbh/DdM1N1oMj8F8oQuLMZfB0LwED7jBhWrMINRKAi3D1w9J47M7VWLACdtxGgkOk34OkwU0VdCavxY7Y05pEHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF5meC3KY51Wlx7zYaFQGLhvJy4qwAC8YUU1Lhl6i8w=;
 b=QnEK51IPxagT9VZB0JLvj34x8pht5Ir34ifM3LIJLPQZsE5e6f/PFuI9WFwQ9ri/JmbczkDBnU0dYF51rkEYv4ToOkadi9QpEHlesBoo/8C1/XqC6dDgtdI+yKM19+XQSDUeKkNkOpVpaM5LMBPLHhNdpuEUCfqY8Ppi5z1zRYI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 13:50:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:50:03 +0000
Date: Tue, 26 Aug 2025 14:50:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        zhongjinji <zhongjinji@honor.com>, mhocko@suse.com,
        rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
Message-ID: <bcabe7cb-d09c-4789-ae39-407b2e0653da@lucifer.local>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-3-zhongjinji@honor.com>
 <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
 <nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy>
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad260f3-eb4a-4435-0efa-08dde4a77567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCtwrb8AhTrR3lWxOVFxpyNeAAE7L77wLAzo+IjcIuJ27U3g96GV2wetRiQz?=
 =?us-ascii?Q?Wc2r6dbH8ZwbhTGs1weGJzMw0v669Ldw3chRKJ9Xp2dm3b+dOX+3YGHXmQ5t?=
 =?us-ascii?Q?g2Lbuge9LtF2Fp1gRZiW5+Dpxa916V8TgYRfMMMmWStODIdvOF3z830dg6Lk?=
 =?us-ascii?Q?hMbRcB4YhVhrKEMSTkvEf68Wml4J8d0LKylfu3GkQf90cXUXW4M3gGrUEgyr?=
 =?us-ascii?Q?k04F6qAE1VqYWfaHRPqVp0RjZtDGLzMgKJDcVXEos+kd2ge6YEypgKRe//hm?=
 =?us-ascii?Q?zpSc1E6NRdXYkUJSWszybt8O9v0fy/s9QYdnVyWUWOGuyCWAblbsi4t5ofe7?=
 =?us-ascii?Q?LKiNBFPeaMwkgnumRSpnlXAnY1hUy7zFPeOn2IRvTMmBSzpXIrW7jFrafocY?=
 =?us-ascii?Q?Q+dGvlmxA6jGGOfd+w5GoBX2yDYCstun28KkN45z9D1k73VswwoHZJXMYVWL?=
 =?us-ascii?Q?rwZJ6S7b82t9D6tIRdnF7aXDHQghJ746SrYLvdFK0coqFfa7auxQtmGETGZ7?=
 =?us-ascii?Q?IWLXd29dlYXcpmeZjvnkoo8YyMEVo7mdY1oOpzMz5w3xIGyiyrZ2vfaFzxq3?=
 =?us-ascii?Q?IWkoahu4hEk/tW0oLnD9MOjUhHUjlvQF4uMCYOBg8QHo56axGQRDH+BUiRG9?=
 =?us-ascii?Q?hKhqjda9fXCBpJiPqGMzA74Ma0i7NYKQ//S2TGDQOagsE36MzLSA+w2TNJIj?=
 =?us-ascii?Q?E0uHQPD4vRQ0d7lr5va6AynGqZOkFJrQHbj9KxQZ2PvHN8V9IpKzlzqgJeOk?=
 =?us-ascii?Q?PpVwcoCq16MjCoes9taZyZk60EomzzqtlxKwd8E9mIsJJTvG9Dc35+vP0Z+F?=
 =?us-ascii?Q?y9up3DZZlcZsJYyse1EFx18GnlE6FQiIAwf7AYNSN1im4oqrv/GvrvgbncFT?=
 =?us-ascii?Q?vT1hfxndZNEnlfR+gURwbrvxGGLJVmgp7BbBIOssQoys2FLxJ9EyRd6+OwAj?=
 =?us-ascii?Q?aksxUjY9rg9s1A+J5Tyrxdbji5NqpTIe7rv1ei3XHRfaKeZxSVN+HtVK5fEa?=
 =?us-ascii?Q?XpbzB1cwQmp7XQiP62jND9g0C23FUS5a8+Tlzm9ZQiT25lq/0wIwHnEUVilV?=
 =?us-ascii?Q?JGzYqXBKwkDpUSELPpOQaDhb8hPlT85PBIYLzG3YtjogJQGMMrej2sRb89RB?=
 =?us-ascii?Q?8vcWbwrWvkMDCfV79xDibIJNDq5HxzRmD1MC45hD1CG9A2BkWLVYQj+bKWVT?=
 =?us-ascii?Q?4khSa6pxKo64oXc9EwC7p4BV8Jd5SC+38fJUDWQkEQYIs0pkopgIuq5xlFVE?=
 =?us-ascii?Q?xcqYcELZyEWOpm0da1mUEVVzvbedsl1hgAbQ7fP5zldW+Omst//x/NKDMMW1?=
 =?us-ascii?Q?yGuE7LiA+/3Lc++ZKk69Vq2zV3G+LRcE2+oWqb6/1M9Bh0zHtFzgICNg9//M?=
 =?us-ascii?Q?ve+LLNmFXwMi+HZI4aY9NVARzpAtXg1HYq+RPBYe+5bwJQBPYBw45LpBgnEZ?=
 =?us-ascii?Q?SgQExSjE9zBNlda3RWtBjJuh9eX7TC5D0k96l4NzyNWFybBurjABGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbFcWhEg6qUMHcquVBUokRUxZ3m3wUHiyyS8PWxXmNk+VksqwQSc4xIJWCLM?=
 =?us-ascii?Q?UBbUrjDkFv4AGIZhMk05NRooc3IZQTYkflErrlo3vhTwNu7G1c4jMEy5tp5U?=
 =?us-ascii?Q?yMhNeIi6rgRvk4fc5f3vzj3hqhpCU6LTi2BvRdUV2Zxdv164SwEAdIb1/7Qu?=
 =?us-ascii?Q?yCOTgWT+yuSlUt9seo+yG3exyKmMUshTyJ8/fZP8R7blz2S9xr/3vYDkX/Kk?=
 =?us-ascii?Q?6zzBeYkKUqy9Gu9DZyEq52bfuwYBF2O4bfJOe3LvB0EkHsf4W/jAfXOFRELj?=
 =?us-ascii?Q?NvD8oDg+PlNQBilMSRqw18jjg8rwY18sv/TuN95SygBwExD5gJfAjgzlujem?=
 =?us-ascii?Q?GWhdOBxNEmAOAwEnuOxxw/2TOxGZD1984KGcSjUEv9EkwNae2SPSHo2KrPrD?=
 =?us-ascii?Q?9GjD8qJt+FWAb/uPKr7A9LNUh3ShVr9kPhFS3ghQ2tiWVcUdPK/JKjE3GFc7?=
 =?us-ascii?Q?aanNa14+pKbE2PkDabgtsp6WB2zVzYO6yzIIsCk7I5akEPT0O4w0BI39tstR?=
 =?us-ascii?Q?tivB1WiJkTnBAGiMTqPJk7S+B/ciqHigZmmuhJHnZi+pllJNflVr0DMCS0Df?=
 =?us-ascii?Q?nG9LJ+A3k81oPynEUe/52pu0OX3dnVn9iA238m+XrFq/4UJqm5k71qJsm66m?=
 =?us-ascii?Q?hOv6NckkraQUVxxfc9yfUIq4zBIhVx5rgqN8yMr6wpWpjQYeU9awyRxhiVAv?=
 =?us-ascii?Q?DYFVHvtQm05EC6dIwpcjUvnMakhn/HmpZZZUiklsAcQRDHRWrb6ajkfzKt1P?=
 =?us-ascii?Q?E8tcs81L2hxRh4o9rjJBilqU3YhXN8NqnWwMJfXC7GU0+/b8XX5g6ZPhvYrO?=
 =?us-ascii?Q?a1rflyXfI2WN1g+rV0d7m7YtcmBIkV2VBJGEwzSwwkU2Dgu62Zuo+yLwYafT?=
 =?us-ascii?Q?gufn4uNMUXEjSH16tO7qu5c69QXpU0ygSlU8Vcj+cVKqb6hV+xcV0n4Jm5Rl?=
 =?us-ascii?Q?HVg2mQyQSe5J8R+2WJ4Opz/O3ktZpzziY5X4ARCO3AGjOVWeOHOdbDOojrRB?=
 =?us-ascii?Q?Hauj74PVgwbRmMnuqQRVdicxXtAWYCfzORoVvUmlNEufEapBLh9NEEYqcTT9?=
 =?us-ascii?Q?3j1AokalymeRufJcoT2zpyqq3GWBM78uERGkWRD0o7cbKmDLfggwKFFYF4FS?=
 =?us-ascii?Q?UkTC/hoiN2TpXwJfM7y9dpxnk0T8E4xF2QYRmekcl/dI/FEv1+rhtdQ5le+y?=
 =?us-ascii?Q?VgJXyPqvc2Bx82FgmBdE9bPasn/M8Lu/NDID4lKEiKHqfvMDG+6ZVm7B09SR?=
 =?us-ascii?Q?WLn0ZgCnVxNzjLoGGIej2uXmq9eh7ObLVe7OuoxbyTwRyAuZNwfS8XNAeIl4?=
 =?us-ascii?Q?Hr58U+Yh5xKKhIeQPM2PyDx3wPBVhLEcBoniTS6QZuopWwss52quGH1lvmHd?=
 =?us-ascii?Q?r9jiyYblMAEje0dhH8/oki1v0s+KvguQrFXU8V/rA4tnbgQN7b8TCXqAFOQD?=
 =?us-ascii?Q?fnfLvNG3TxI9MUU8qI3cm616wUrJ5kBD+0DAOu6Rp0h+mBYC1sQqpe3S87/u?=
 =?us-ascii?Q?XU7k1K3m4BYdZiCtmJskcPhonUMuCKBdV80KLTszZBdkO4K9tweVbIhv2o1e?=
 =?us-ascii?Q?OM+U+G8W/p6VEe8NH3MX0fesZigDMjGfPWjHWu9F5G9+x7WlLGsmgUE3pH2Q?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oHI+hE22BhOGHZRjbNAcwvSFFv8K2bCjNUEcfhwC2ju8p2aYSETM/EianHUbxxU56yMn31BMG3vk7wDHGAk+gxQqFfIuvxm41XQ05HQhui7lQxmxSiHNO6bU/pn+c/9DGQM2CwQgivVdimhRHA7k1wg+hxZjvPYKFhsYun2CnU6reY9SjUeoXg5Jio4OzlKMzuOKAXq5C00ZWlQ3/WM3ICQQwtjF6P2Rt9yr+ISzehM7GAS5OJ4I9LgMiGlFMUBliGJr03J5eYAWtrA7YYVDJsyx5h9JpMt+/RBa/0WzhkjsS5f62Nj5+QQg8WVB3rPzSWkBnvyG5ocDSbOKt3y3MSVUo5qF0z73bNlJV1lh0Cd4uRUr/7plQe/fG94tkhe8zaaienLvoevk2I2XMEJYR0uv0UP9V/4zmaFnn0qI7jhPpBwLDy7I4AKGadsk8VA9e2HXaPNaaSxuxCPXbecTebEj/PPL2Sl7prpMuMOVHGsqRqUX59F43OcB3phGuPDZgBlL/ySH5mtm/Wx92fifR/dZebiA5ROX83BkgL/d1BnxMtvcmIdvMf98Te9IPbyF5on1mu/NbC8gEJpi0iPWM1LIkiBFDRkRpHZrhZea6WU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad260f3-eb4a-4435-0efa-08dde4a77567
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:50:03.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wEtl4d0GDFHt4Jan0iMRR6zRd7JoPypoo2XelYAO59aiaKCWjMmX3kMQsh9zPMDn0JStbTqhF7+jF49LRTbX7rPOsub4UuFx7PICFViM4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX892fd1P5uqOm
 xGKynl9gAEe56Df10/Hz+1yLjxPcgELukuw42xtenvC4+EyF3rwnEo9OWY8QxTZKEGp7n7nnXV2
 StnlfijqAGIBcj4cwec6pe6h3wnOp4wL7DcR6pEStxKOHwwAxJCjD0/3zKF2/I35iHhTtObOPFH
 Mko6h10sFcd4mIONANMk+76FdllbSYdGPV6q0XYaLKDoKf9UpdxeS5UlX4gidDPvg3lTntWjyHT
 3vTd8zKtkplbIUuDqGAfRoyvN7Xn4OPSiQGG9kXpgwMCrS2P3sB5+e9pRofM+Nmnp/IUBO5c6Ix
 WpZq8I79WLE6990HkYnRoQ4RDwD76d53GAAsVwT+va2IgaPLm2hZygNjdGeSIANA9SuvO4b28tC
 8TVgr/2c
X-Proofpoint-ORIG-GUID: avNhyppIiyAwnql3CE5fn-ZzZNZ_FROc
X-Proofpoint-GUID: avNhyppIiyAwnql3CE5fn-ZzZNZ_FROc
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68adbb8f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=GSu4MAoSDA285qga7vAA:9
 a=CjuIK1q_8ugA:10

On Tue, Aug 26, 2025 at 09:37:22AM -0400, Liam R. Howlett wrote:
> I really don't think this is worth doing.  We're avoiding a race between
> oom and a task unmap - the MMF bits should be used to avoid this race -
> or at least mitigate it.

Yes for sure, as explored at length in previous discussions this feels like
we're papering over cracks here.

_However_, I'm sort of ok with a minimalistic fix that solves the proximate
issue even if it is that, as long as it doesn't cause issues in doing so.

So this is my take on the below and why I'm open to it!

>
> They are probably both under the read lock, but considering how rare it
> would be, would a racy flag check be enough - it is hardly critical to
> get right.  Either would reduce the probability.

Zongjinji - I'm stil not sure that you've really indicated _why_ you're
seeing such a tight and unusual race. Presumably some truly massive number
of tasks being OOM'd and unmapping but... yeah that seems odd anyway.

But again, if we can safely fix this in a way that doesn't hurt stuff too
much I'm ok with it (of course, these are famous last words in the kernel
often...!)

Liam - are you open to a solution on the basis above, or do you feel we
ought simply to fix the underlying issue here?

to me we're at a simple enough implementaiton of this (esp. utilising the
helper you mention) that probably kthis is fine (like the meme,
or... hopefully not :)

I will go with your judgment here!

Cheers, Lorenzo

