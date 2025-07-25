Return-Path: <linux-kernel+bounces-745860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D4B11FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF78175BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56EC1C6FF5;
	Fri, 25 Jul 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FWioz/D7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eqVFUmPJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC310FD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452269; cv=fail; b=sSVZ2wiilgt/CddAo4pM+TcG5uYtrGE7ZafRQOY5ODBvMQ1UIsCIaVhbGnPJB3eBjYQ1D7PimwA62VGE4+te6RLkFBetUZS6O9wUaQK4V/XduORXAW3lEC6GGlDhcG3A3A0cOwhB9/zdr8cB/2aher6WFuN3OH45hsFYoA/NftA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452269; c=relaxed/simple;
	bh=nTVONeeWY65fUMmai+rWqz1oOtv5Gman1bIO+0SxsWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qngwH5AP+6GBkcHm3ZRjnJFIwlkfKcYtlOW9fD1qJLMqO8mC5fArTtvmJrBCMHVS9tkHt6WlDK7HDXxtUkdKzkjW6vwh9DRerrEa9vd+6Mr7kAN0lqTCGZhbHjAai+hM2lQhcOiFTHS/L9B7tKqOnbNTBBgZDnlPOT1UNieL2ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FWioz/D7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eqVFUmPJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PDfrXw017868;
	Fri, 25 Jul 2025 14:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nTVONeeWY65fUMmai+
	rWqz1oOtv5Gman1bIO+0SxsWQ=; b=FWioz/D7b4HPte8bKMJ2OAoiESLgBu9Ccq
	V94lXnsFbavmCV6AhMkrC2XplG3QH0fCOF727P0oA18v18OJPKk3hrc+/CrYTuAw
	CgudeUXMmM7CmWmvQs9eMxOSCKWSpB2Ob27mH0+WPovu16/N5GRUppQutChK9F7I
	eoI8DKGhhuJXvo1hnG3CQhDHmCvzAIWvQ17vR/EIPTPt0ihbdTCnxww/03EgOGAE
	OTw3xBkYT76zT/DJYVMiV18WzyDU8hbIjD8/GtCgzwhkjJ8vnuR0ORQdTxbcDttH
	/BK7Vx2Lj34s2xEzN4ss6unDuSfsKQGlxG2jFDYV9P/iRHBKWSfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1jh457-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:04:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PDbb3e010459;
	Fri, 25 Jul 2025 14:04:07 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801td3m8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:04:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haTDmMm8q3AQUUD9wFZTmgDrDQ9bHOWZKlvrxB5IEFGVHvJmJL5wyJ0H8aKGbP2rHIa3g/s7/2OiUDJ/dDddxdiogymLiYnxnB4t/y1J2WO1yThOHaXSYBSZa5wqTSjfJXPKWAEsWZU4Gjn6OViww9/6ZsSRRqs3zSJ38sIz0VXQ8ChF9swd3AQj0+M8L+8JsJuVi/0GgVfeXEiGtqBHShnmMq0z7x9tzWNKMj3lNwud9cg0llMyvF4Rdn3CU0fmVcnIT/E1yXVXJrJtfvXgEiD5YSDcpCsr98amX3cEOq98fVt6ijFB7rqtXDmMo7YegthxIxqFAI4u/9OG5NTHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTVONeeWY65fUMmai+rWqz1oOtv5Gman1bIO+0SxsWQ=;
 b=ZbGpI2rd3tXXl3vUAr/twq2T0VZ6od/OkIWPJXfv7LCVUQEpGPJV3ViTkn5spG2S1cPQyozBFBuOATwZPpczs+JDm3Wrg3o2dnnPlsPgvF1lY3NrFeKqzd5omZCBz6jpDGYnUwrTsd4LHDMwvxVNFts7JXGte91QW+oIO1F/94GEdAPkhyJ7U+aquqVaQDxkAsWA7XiIKqJkCcFEEq3XIUXyWwp7tixsE6AF2kktlRQH8IqlXMou4/Hb3WmNgpcFjh2Au+N+ZF/MSTFu9lUAn4oD8+CC+fHmGxfrBRUohMbS00gFDJKi20hc6zUPc5LsLPvPHJEvRdkaJfBafQin1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTVONeeWY65fUMmai+rWqz1oOtv5Gman1bIO+0SxsWQ=;
 b=eqVFUmPJM6kt052JiJ454KZe1gMTEuVISeWphPrdLr9q6Y0d1Tau4F1IsnG6hWeprSDDy5Fe6lfbIfRStEl3Bn/4v7skZf7Uvg/c2exfPoNq2Vq7s+QSLYrJuwZ5fGibLbwq3NOg8a+4EDoHxKqVJnN95Pdrd/ikYREwAIrrmF4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB7462.namprd10.prod.outlook.com (2603:10b6:610:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 14:04:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 14:04:05 +0000
Date: Fri, 25 Jul 2025 15:04:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove io-mapping
Message-ID: <3c188899-a829-41f6-aa6b-ad31e9c9d686@lucifer.local>
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
 <199a9d2c-9e50-4740-b29a-6ffe906e7d9d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199a9d2c-9e50-4740-b29a-6ffe906e7d9d@lucifer.local>
X-ClientProxiedBy: LO4P123CA0560.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed5d47e-8f14-4b17-c67c-08ddcb841dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?paeBqSvNFkJzBvt5/BThSfjsCg1ZYCy67qeC7JxFvV8Ez7ZSNgZsg70pHpXK?=
 =?us-ascii?Q?LiorL+xS9AqG2bAjiLW5EC7D0T/akfJrau6UklV6C/xPMu0BJZxQf/s92iMX?=
 =?us-ascii?Q?H3b9Hp+kbaUEBhUNYBHWG3OIVnNz5lp4AD05ecUdUheuz2sd74mfULtRdzKJ?=
 =?us-ascii?Q?/0EeBIbQM1GsV/TlOO6YBqt2mJA8s8oSvafWkAwOXFWdxqW58jHutfp7PIvi?=
 =?us-ascii?Q?QncxAPNwogw1S7ZKkYh7e2P9yI54TepgISigR5nJUTpi/87+OBCu2Jq7Cxe3?=
 =?us-ascii?Q?1IsBg9wCTzYzBgR/zu+POkXDKyPKHnPoYQRWOPljonq48Yzyixa8WS4jZt0l?=
 =?us-ascii?Q?PHvOssgARja4wWfZU8X57M3VlUIfbMvVtx/12VWdi+Yl38Edz0/lFP6pj8Ee?=
 =?us-ascii?Q?CRnV9LB9dMIOlJFz2zszGFOCGH10lGtCix0Dgk0C1eEw6YVWsUSLBPt/XEi2?=
 =?us-ascii?Q?tDnYrZanODbgBO5FY0ecE/ATmvy/+zB6QO0E7nUWVmxOgwNoGlHYCcselcyQ?=
 =?us-ascii?Q?s3jOD1qijV7e1O2CQNHDuNI2D3oQdzXh0CpQHs3YksAge5uYvGmWg39A9arF?=
 =?us-ascii?Q?npHaWZqATwH9JXSCj9Hj+2EMbmRdYJn4vlpQKrIR0LpJklx9AjAHLVx8hPr3?=
 =?us-ascii?Q?8EqWmfxsoE4s+PRd//Ow+hKy5zASvYnC/bT8UUQ90BGo7AXUm7eiUJZI8AYZ?=
 =?us-ascii?Q?5lU+7BJnAVR03FZc8nra70uoUZ2OY89WfeEXyfAB4d39FTK7UPxwFEuCOij+?=
 =?us-ascii?Q?pyqvTNFzYdfryK4JqOauUeUphG1E7gIsHHRZCruo2771j76Hxid7ZnrWPbvJ?=
 =?us-ascii?Q?rTol0jMr6zBcYyqVQ25wTj15bwYz5Pu/SIxzfk56LZCdgwaYA49C+RPO9FRH?=
 =?us-ascii?Q?GQCljHwbJl8NiZ3Zmcsp2Y4NZnegugBUVKDByZsfheXqcaTa6dWmN4g2m6Jj?=
 =?us-ascii?Q?hc/uS9hfqO3et6JVccpa1/vT/jThCVSGsHGaVI8MgDG2cwRRX26V3va62x7F?=
 =?us-ascii?Q?ru5Zuzi2abkUkV/MsGWiWnmosLG+Xw7PdKUoetsJp/In2H4nItTvUIgx47FU?=
 =?us-ascii?Q?d0NkCzuXqBaOvgRgYicaIRm8xiIzmhY5T7UYCs531c7ppOHscgUVOgWZDFQB?=
 =?us-ascii?Q?5A17TP7GDmHOxHQji84mvz8XlPhnpZVfzAlPXXvyAL2bkYQBxBf4Ppv5cS8S?=
 =?us-ascii?Q?+HCj/kVsDGF9Vrwcf4D+rd/LV+4Um59MGjqKMF9rcQ5UOfc9X+76qvDZv07C?=
 =?us-ascii?Q?1rl8uTJalNTvJP6uXZpgKQa4H7Y+636uo/8ho0n42evYfYWZ7Y4Xm+nC2w0s?=
 =?us-ascii?Q?WnDDUlDRcOY0B/ZaCLkqew1ZQVOs1zb8UYk8JTU+PruJGWc9grucWyJx4EZr?=
 =?us-ascii?Q?sX1pf5ndXIvhfexBJuF3tkJk+K4ZEK4CE/Cgby2DXZxfvuiifeEkv2GTepm7?=
 =?us-ascii?Q?HyWRidZ8hWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g62RZr7F10OOamVg5HzYu1b7zMCimlwEdgD+YwadXEmdAIuqPE1Akb4QgP1t?=
 =?us-ascii?Q?QrV/vpPgDwKvhD59jAOBMJLSQqgtNnCucY3zmOIVKIJ+OL9hhkbPB55eHxck?=
 =?us-ascii?Q?GpZhKqNkbBzd8+1qDc1GyI5fYHr9+Lra/4Of/fDPG0+2txxsi3VTT6ag6/tD?=
 =?us-ascii?Q?YCr4eZ6WXK9SQTVShvxPZsOJswsX8gyfDHPJv0GEAbIM5CrYdjV7rqFmc1uZ?=
 =?us-ascii?Q?WmqRDo1lxx6jsmnG/ld9SdIlD7e4Vdv6rYZ4LlMPeqWqCNr/3zHs8vRJoPp9?=
 =?us-ascii?Q?dGte1fb9okH2IxFnpLLNZyoIeyFUtDd/LMg7GJ6YMe3Of6Oo0aL1us6vj4Tm?=
 =?us-ascii?Q?W7c5ZAYk1+HN0W+yauPmIhs328VxpmzHN51KqTm8jcKXm61IrwcsTleXtMvk?=
 =?us-ascii?Q?vb58uOwoq5+cL/JniMRJKZBCKm6vYt/pjWOOJh9Z/feQNoJpJbTdtBS8u4Vu?=
 =?us-ascii?Q?afz9s8EhYa3zz1Q+1uUdTc10WGTTMcQP7lXZ2kSCQGxorqPdNiBIEqqsZhtO?=
 =?us-ascii?Q?++bQmu2hoKQesF9rFgzUKy0bBXWzXLkayhTVGIGMjqt6LEeUuMpRa+mmH6wK?=
 =?us-ascii?Q?tF4NvLxR9+dvmrxNtJhPNOgIzHvqYU6BJKbzv+U2bh5ym6+ipAboFAlbS1jH?=
 =?us-ascii?Q?AhV2tDv9z2h9n3nNXUww5/b8a2wjewh492ztUjQQztvqCD1ktAxyyl4hpnpX?=
 =?us-ascii?Q?sfYAnDZQXUUuN0ru+Uw83IPF+BDoDV3p0yh66x6+0T5ILGV7i3W996cG0RB3?=
 =?us-ascii?Q?g8MBKHjsYI/6nC6qsOQbwZB4YKRlgTzkHHgBcUpSzRVka9JiV+4M5ulOAggV?=
 =?us-ascii?Q?JwziRfIlrBp0o1xzxHdSS1Ca+X7921l915+SxRTYJsOewWuKKHXo3NU0aiD5?=
 =?us-ascii?Q?1zMI9qjAEEJCfUMHPWMjJIRjNNOChvX24l7Q/SFCsHYQNw7LSe8B3ppmSwlW?=
 =?us-ascii?Q?v4ls+mlONnTv5L+bmR45WwJ+NQBAIJkXQ6WvKULHDfq6JwwtVMVEMUMKmpCk?=
 =?us-ascii?Q?0SiOO0H6tMbLOmqJuGO7Nj64LV7G+2dQBCVfOGC30jVUcWk2D/VxnHZ2Z3Lk?=
 =?us-ascii?Q?/eoovmfyuprXXWhMFGWCniyO062zv2S2rEmnD3PwZY11Ht+FOnN+xV1hHuEV?=
 =?us-ascii?Q?VXQedldlMIAKR1CKYBl5OhwaROdGjIB2m08kVPK1ob8UQ0lkvxkkIMyS359B?=
 =?us-ascii?Q?rZ4WLc4AhNcfXI3q4ELS/0LMD+SecFgjmiSCclwNqPHa+rqnGUzUq0NKwZzg?=
 =?us-ascii?Q?N+W2C2h0NGLaY5jZ1O8DzkELrCbjr3WfYAMr3xpfVvJxzjhjsEWUhSJdp4gw?=
 =?us-ascii?Q?NsoqvQsdXSMSeVDZcGtenfekF/f55EyH94oeO7kXnG8g3lxDFtzPOdCijjtp?=
 =?us-ascii?Q?kg3sutAfYGbMRxci5O+DAyUdlPTzj9xUPrKzMpEHZ8xWY+CgGDDT+pDXPctP?=
 =?us-ascii?Q?P5aBLT8gsMGKlXCUv27yxu3axrumEfDsXiOaWbSRt0tSacmYpobLx67dmmDt?=
 =?us-ascii?Q?c7y7Z00mvHF643wpvQ1D2f2w9C0xeu7U+qcJTre5EwVUzj9mf61hsXjcYgae?=
 =?us-ascii?Q?AKog0HOMT7HY7KJd9a1kzJc4bGIh85sfviFEOEowuk5jloCEA8Z3CJXkewzL?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aCNbcUkn68hUkp79eWVGG2j/lS4kbjjiyogaEi44hURp93+k/wblJ1mQ/QiXt0EMIlmAw2ixFnbWULvj05w+zdj2JgFVXwVbySG6Mm5SIIwjENfTppnT5Z83JD9thApvB+infr7v5MZhrL1q8nUVnhawPozKJVRTPJJhVXc9y57y2XBlWmZxipBqf1LNMULv8igagPu5LXCuSID5QEnscWxGiFnVkpS0kOL39Itl2hHk0G61BqVJwGd8u43Gcm6MG/nW2vbesoNM0vEfbQ8yQEGMoEaoY3h8ZOpzM53mqmLOSM2ctlGQlWRpDmsecQZyEeO2Cvqjq/e7Rc+uZDy+RR78azm57Wjg2+B5J6C2sqal0Dtzh1aPnhXgx8wJQeqscWyJhcNFIPDWxx0PUhW/w7wZk4ExmG5i7rlSDWhUlZfyR+G0H1apqP3BtMmqVy4tJRuqW9VgM9gdbLnAQsjIgYpGn/aSJMI3HXqxTYR0zixrz7dLNjEJwC+lA6GUhOA6C0/lgVbmUa0l7dQ7DOr5AOd9hMVnPc93Xqim/DkZwjbrb8+pe/SvMFtCSQmfbIPPwQMGQoWaaNbXOsKrkrQIr4qwnSgYbILLLEO5OOurKJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed5d47e-8f14-4b17-c67c-08ddcb841dfa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:04:05.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAg4SMYpAwbs0JBEAYOgRl7E/GY6JrDo1eu+7iCU0NNzNLvw+9+3qF9vDOW4zay5l+Rnr/Kqje7FquAf56LM2W9vjnGePo3/0NEylziUrr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=712 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEyMCBTYWx0ZWRfX6a1AdP+qfaOX
 D6/CHuoo7H1AeiUA1hWCxIY17LDkmkary/1KltCrN2KW9ZBDxoZLhVjE3Bt7yyIDKhYR6EoDaqb
 bxaPokONT3i2sAfokVURBSrRoykhWc6A2ejKN7XeX5Ar3TN4Xx/dBu7Bzl+qlXEmL7LjmIds0V3
 IETDDyWKcDXK48+T/u49TF6xmcaOkOHdyK9oGqHVmZC13r5tcR9IVESvBb5b8SQrT5aweXFneXd
 1nGujPpYWC8tifyEJD6tlTK2gknjFSxxTG2A9T1SqmcG+srgb/UV0rTPxmjpO9OZ4uucxLSM9HG
 2fwAeW25soDGy3FZC/iCQsX6Fm0E7WMFzlh+MKCYTgeUv8GpODBDXaYEjtBVGe0VUzdtTZsDbzr
 w5jQ3PGv9jr8pAJmiRoO8z4PhmUnR3OAss45B+J9X6xEYjJImOkVv0LftUc4nQoxCuRtK1by
X-Authority-Analysis: v=2.4 cv=W+s4VQWk c=1 sm=1 tr=0 ts=68838ed8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=tuJsxtcMrjbttJQSmeoA:9 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: zbSBZi4NIidCo7PyQFigBP-ghw-NvEE3
X-Proofpoint-GUID: zbSBZi4NIidCo7PyQFigBP-ghw-NvEE3

On Thu, Jul 24, 2025 at 04:39:16PM +0100, Lorenzo Stoakes wrote:
> Sorry Andrew please ignore this for now, I'll send a v2 later.
>
> I'm not having a great day here...
>
> I wrongly assumed that, since this is wholly unused in practice, that nobody
> would refer to it or include the header, but it turns out that's incorrect.

Yeah long week :) the header is used all over the place, so we just need to
drop the function decl.

v2 incoming soon.

