Return-Path: <linux-kernel+bounces-776360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DBFB2CC67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEF23BB7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901D31B133;
	Tue, 19 Aug 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTl1hMgf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uumunfgD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE625A359
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629376; cv=fail; b=bulYAjap0wiH7SRWP87AMi1KohsjSRJhQPzF6X5IRn7A0XF7kJiY1ms9+q50aVBQWyVALIqIBSMQKMsWiKrvRK54WbcE6MF/OSZdBEYIbgBeEPNJnPYa63vHp/gYbKUv1Tw/YuWbiYwEiMinT+Qdbh21UpAzaUk9sAA2SO6P5Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629376; c=relaxed/simple;
	bh=r5cUddwRfac56P1C9KKhcM7tngrTtEcKt+QHmjDOEgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGnAfBiqEmKqBKTCilMqmCnRCs0tb/s49l4PC45MlxML05/QD/GzWEuHJcgrr3lyf4pMb3206INVdwQf6Vrq6Jrbf0OL3Z10e5c+P9+aTmeesr+cstNUgBV+b7MPkEr9+rfu4WQ7lpctxkpN0jw/QZmiY6Db4VictWfDHDaLBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NTl1hMgf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uumunfgD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JICtYw003028;
	Tue, 19 Aug 2025 18:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=P5QQ9XKEVmBTO/HFam
	UeixpoJfEPqFJQNGEJaIDtJc4=; b=NTl1hMgfTfkw5CgVBrQtYHSDfFqLHMLHB5
	3KWCn1kbKEpKU5gc9YECGSa1jOVABlm1yKTYMNEIWr7ib/ewpTJgEI7nHXcK5jBG
	1lDBoiveqX16+enZC9IfHqSm3LSQ6Kr1ZbIpUgu3UoiBD/CP3Xjq0dv5XnTdxTVh
	k2PzBupeYl1xVpZ2g72VEn7Bqt1wS9wS8a3CchO+Q7Qo2vqHko1hDZ0VxzPmYygQ
	XuKiWZ6hSkXqudMI8IBFely3hb9uY7XRNtBXk0CN7Cx3YI5QUnw8g8FkrzhUN8J5
	0+42PddPXrykLeRIrGzB3p7Ioc+xN7f3JRluaeGfbdpTOOKBo76w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhvde05c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 18:48:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHf6MA016816;
	Tue, 19 Aug 2025 18:48:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgeatv94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 18:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUhD1he8gbJLuqFDSNUEGlzRQNEBQ5us6BJx2Iz+KBTIfKkYSAD4NvBXEsmePDjktK6aiJ+8qNC7vUcqQih8k+hbdCJH624B6QUJlIIAiWzwt5eLfhRaXgZIEgTZbBCH2gBo7ID4mu/OUu5YX3LD+fAIqFNvaU2rjNAP68XbVGcGwJzXkj2NacQ0gZDEbjhEJLi/cbIBkK93DxxlUiLkxXnd326679/0RA/qx6hgIIu2XwXzh7O8Fsoichytmwim4Tyr+59niDA4/VfBCDAOhwbFOKjfP/78YAk7GV4yEK3ftZ1xBw3vYgDqHwao6L69GOvp2SZlyfNTxhq9rNCtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5QQ9XKEVmBTO/HFamUeixpoJfEPqFJQNGEJaIDtJc4=;
 b=Jnd1mOyOhwQuMZm16mcIiJv8onjKlU64ch035Ff7MPMtoijrW//XfsrKVfqa/0eAnVzog0PMsqFuYZVTzIZsbWeTGpeHOl3lUcrl4YG4WeVIdsBrpbi6G07pRGkDG8+9ycpeQjhcB4L4dOIHIcwopY1N/B5gXCwKfPrivT960u4kclv2jHOuiL2Jko6bOWmmigNIMaSEMboODM+NM+yz0SU1NhZr6G9++1BYmEI++g5cClZCDCFsyhF06pRwM95pdtmrxwIfznb7Q4vvJY54wY9e4HWC3XJEHqaj/uMndzzT1UB6cAjx9ELVIB/NjPKXJxwfU7A21HRIONd++wS81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5QQ9XKEVmBTO/HFamUeixpoJfEPqFJQNGEJaIDtJc4=;
 b=uumunfgD8bf30TxAql+8sg84RNz6a9vGPKOVH47oOXfxfU57eH3dzIw+7IhTQp02XgSIBPJYmwFdKLWJhVYd/DybzqDmkTelx2sKi/PCKVxt948oLu0IPXe07SNpzzm84c3DZr969TO+bDRxWgp6/nuUKAT1qqRN6Q7hahy2VUg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 18:48:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 18:48:23 +0000
Date: Tue, 19 Aug 2025 19:48:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 3/6] mm/vma: Add limits to unmap_region() for vmas
Message-ID: <a32ea375-f093-4f8f-9270-fbe9f7977cc6@lucifer.local>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-4-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815191031.3769540-4-Liam.Howlett@oracle.com>
X-ClientProxiedBy: GV3PEPF00002BA5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1c) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb0c9eb-4e6b-44af-941c-08dddf50f9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2YeOc5IB/eC/s1lwJvY00yAK3ti9qs+hGHy7y5HRpUda/h6MsWm2EplIrGM3?=
 =?us-ascii?Q?eIyM7a9Qld8Rm5TJx1JqyAfN2WGYV9F37YjcBWRq+7E8HX8khwfTmmnwtlbn?=
 =?us-ascii?Q?bP8Ba/5c5YNt5QZELXD0vJgTV/mDhpALp8cm27crRTb8NOrtkF0+yc3gOmwc?=
 =?us-ascii?Q?AnMFvmHykluIT9NI2RH2e4QmZbaz4gIO6aHIyBWzBnkU4FeUhPN/Z8pR14IL?=
 =?us-ascii?Q?SrMMJbvlfTeTxvd+DDgZSsZu01DhWnvN4/He8AqR4//5/J1oGCliFIdpyHAU?=
 =?us-ascii?Q?K9ALuxG5G/jBJokvx4d9J0d1V+mI0GbZ9y++ljvt+YWcWY77EyLCEcJG7JGV?=
 =?us-ascii?Q?ey4o4rxpC3XjI60HY9f6iYoVLnIc16ndt+5dXBrbd6DNumjZ+aOV8JWcmBWD?=
 =?us-ascii?Q?6AMTRZYXIKAsdSlycM5rectbrN+/XoxXYagzJ0fMYKaB3BiDCAcahDzlYmaG?=
 =?us-ascii?Q?HeX5qVwmzYO1wkDIIdadKcC9bMTh6ubGQOfhQYVzfWu96cy6yZVmnb2527er?=
 =?us-ascii?Q?A+IYETA8kwaszyBWhhrGUO8WuOtKK7UteeWKeihfYiJWDZgwTy9uO5lPlyKH?=
 =?us-ascii?Q?jMBv25tGoAdumlvdlblB+iZoQuvkTchnU0XkavQnt6zIufWmjjfzcR8U/rLF?=
 =?us-ascii?Q?NQuoN+/Ev2fxnb7GPlPILf+kOSFInCQOgj1bXY43yvGvGJRsquXeF1bFbA6r?=
 =?us-ascii?Q?6nTqS5b3b114i9OoaArnCieYVkOcyuYi+2cxAtuYHd3xDoDH8hzgJ+huDxKB?=
 =?us-ascii?Q?lBkcdRO7jTiDRX6XxyyfPCAjM8vdBKl+CiettEjsm4zaBLkiPl2r6GBBZ2F/?=
 =?us-ascii?Q?O/XPsJlse2lEKYLvlA7FuZbltXEykrp0HxX1OgW3K+R0qRFCM/6kAHHj1UDh?=
 =?us-ascii?Q?K2ZZFOmI+sgOaRWq4mGfVO2OsBGegtvIf06LiliBXdXSpwjRscPOGT2DL5wr?=
 =?us-ascii?Q?6PMjbYbIvDDkHL/t4EJoK5CVQ/gzKcqphoJyggAKDWGfG61nEHko/QJyf54n?=
 =?us-ascii?Q?3NPbgIlB1wTqv8EkLYtNr0jmiE0cbJAHYNTMTtXQf/Tq6TI5F5sraLv6AJa2?=
 =?us-ascii?Q?4YX/s2Upna4+aNIy59LhGG1k+aeEWSjP3wlpfO+tK1gc5l9mJzHwIT++eluS?=
 =?us-ascii?Q?Glx2+JSMedfwK1g0XXcBDDl+exTEhFVxU99lZO60zzMo6qqa+/rJM0kZBLIM?=
 =?us-ascii?Q?Xxf6ZjvjW+RftZl7Ofgp2dXTc0FIULvx6MpTSrSZQOk8/RzfbBo7RL96Qyzu?=
 =?us-ascii?Q?8BPVCWIp4IGGSjrz746J9jM+7DVE9cC7E1kPwBeSBk/qEUsDhy92JiRvgnwe?=
 =?us-ascii?Q?y08OKqrwRLZqhUUCQPtFWOlgVFel8R8CC5atd0WF/hkOQCw/dUzpihYOpS/X?=
 =?us-ascii?Q?7cspbiMRooXnCdRr4E6FhKacfyo2TbXteWFoLsxLelCwDN9ffw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jNqw86K6GaXrASC2P8ybgYGBRYNxHOoabjmjjf8LOR0LQ6jO1lqe6yTQh3+?=
 =?us-ascii?Q?yC2x5c4fF2O5yA8ZfPAe7y5BgApqHANfEM4mAbAZwJG88xbzupRRp8SS+rFh?=
 =?us-ascii?Q?FuzBefjaMWqtNYUkJSgqtQXzmOtfKX5/i2XvgmWo/k9ngmo0urRiKDx/pdSO?=
 =?us-ascii?Q?6cAW+X58Tad+PEq5gMa+I5Ql+jSMcVi3ej+oCOU3IK0IzbbovLoPz16GGURy?=
 =?us-ascii?Q?USp48cVIYxqG1NjHMVriS6HA2oG0TOPssoS5om6jiXkWZkESFnvG35NFG6UT?=
 =?us-ascii?Q?FG96WIYFC8owbgLdaU0YHl9OR0dj6i2HtQH0dGSf8F+CCNuQNoG1pXUenwDx?=
 =?us-ascii?Q?cRG2239XguDl4zwpaI2Q5t0PLoxhD6MOl+WLconMrDnmOoh1SB16vbbzhVev?=
 =?us-ascii?Q?PjYIhFCm8O3nFIsJUsaacDKc53F7TuKk926wRKixHDcB1gDG4aYdeozJSRkt?=
 =?us-ascii?Q?6KLGrS71/pFR2Hkn4KFlbwZp8zcP0s4J/1e3RwtCWA3i0DHHsS257nlpT/TW?=
 =?us-ascii?Q?pct3xcziJ2P4VFUJlQKgdX/PlkHZD41EYseAPPggl6iJMEXKzTf1hnwfWtcf?=
 =?us-ascii?Q?kxxNAx4jdEzqBh7+NmCmRN/pBgZobSOVc9CzB/AZEJV5gWMXLT6109v2M5/Q?=
 =?us-ascii?Q?cJzpN/TQSnA5EcS/G+57D8d22j5rIem/yS4/K74PIdyEGyJgrC6OnxIGlPnp?=
 =?us-ascii?Q?MhUHVaq0ZdT9J7h5c+mxVresi9iOkfNltE+jOWjSqJmxiJstyZ/+lMEPvF1Q?=
 =?us-ascii?Q?zwKGwkeoBLeDV1vIIZJGYFxKYwiSwNOsYtLY2ZHWCL2mhdLNowtzw0OcYO6H?=
 =?us-ascii?Q?Vb8c0sIhGh85wWnHnlQNy5v+M7d05n4RLn0AOnPAy8OX1n0SXVlV3e7rOtnj?=
 =?us-ascii?Q?3LATQYHOfTldz2vtZfIOYG2nITW9zT2P860FXYbbeihGgFEIpWijcGZ2NP2h?=
 =?us-ascii?Q?PDndXDgvwR8snPYTBuxf6jYiaLqhxG3yHJsCVwuZ3UUyqllSfmYg7c2nctOt?=
 =?us-ascii?Q?ybnYpnIkGuSPkC/tnQkOozg2mESQGQGqye8y1WXAnlZjRZgTxA1tsLR7K+wK?=
 =?us-ascii?Q?4p/JKT7vPuOqq1vc4RDDB8vGxBjN1Cp8P9+mPP8EhqJu1JOCHLuMRTvnnvNX?=
 =?us-ascii?Q?u84ommBuS2U5CIxwNBXxCP3znmKae2N0TohXk4hBkccWV8D6pW9o2d7dGrVv?=
 =?us-ascii?Q?aYgK+CMa4AdaHsr4sVBaWEzy1diUp1N5D9D3yQgaH3TDtnfw8WU/bUOdpWJt?=
 =?us-ascii?Q?96tHFBStjU/cGf48ipJ/BEhAs62bWlt35lvw9rOcqxkqAldKd53rLoOztKfP?=
 =?us-ascii?Q?PLDbxH7rFNjJbznctgZPBM+jv71+kdGpufmaAN+vT8zgm7wA+CVJCzW76HVE?=
 =?us-ascii?Q?yBD3VPByXsl0dR2J4yTJG7jdjRHy/IgtuEWRW5U4YU+W2NeQiBRJIOoXhTjc?=
 =?us-ascii?Q?77kON9c06C48tR8aW8IIIwe5sJ3TyqgHdw/4KVYQwB+RjiX6YrNKTkU9WQEZ?=
 =?us-ascii?Q?h0Dw15I/65e74EoFHZQBhQeyO7ZaFLOpANCDK5m7Zt50MVMP0yLZ4QlQrDgE?=
 =?us-ascii?Q?K/aFEF6HCGbEuppfqKdClHT3RgPYwVv6ub9PdPm+fuVBh4FA0t8KtKM5YoYG?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	60kls284kERzT7fgFGzrT6XMwNCpkxtZZHlBZ3liIUftYGblwSM8fGfjC5euPZr1mSO2nOi3NVf9LTKxmvakE8l8/hwVDSElND3JtTqxbwjHHxt2feGJpzu3yG7wcATbRoh04CDQHI9aIvO3R2vY3F6A8pyhU5wywqLsEKpIgWuia2VZtqfTiVREpvegwZh6K6AkjxiTBDhmwbM0yrEOkEfScw1qMsVONIViWZAZg7PuZvD+9uww7Gly5xjmsPD6oWL5QocTutggot6E6JRhm7IGyVNm/j3uzCD0vKdx5SV76g85BizhgnM/ubqjds/ZcUlAPT+8dPa1OYOUW2loHwoMp2JZEsBToL0rLIBkxhThYkvou+eqHRko+0mWJi7VKQ6qeO+BGaGNNEVdQv4f07iFA+mIlYcFv/iRgY/hzBJsRjWNVUzyxeU3BVTmjPQFv6qUASnL167hIsE8atlKy7fCu1LbxWbgXQUgzRPr1OeLI30/7s8tX2gkdHGjsqPDNMIsIyBVlVGifzAmwS85ypPQfjhGhfLEYEqGoWuXXVsDbPkt1NndzDmris5yeBMgqhNvdfG31ljKYQluQ3Qdg4bzSDuc39wacDjmrNa8hrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb0c9eb-4e6b-44af-941c-08dddf50f9d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 18:48:23.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKJE8zMwLJCNZIxAWTtoNltuDF2CP5TMR1UjVrFQeRuKyRH1d4Il82sOUQUUiiZg1zuYdtJaWKi3Y3NfxTiSjfB6KeX0hpo80ckJ0xKIih0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=881 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508190174
X-Authority-Analysis: v=2.4 cv=TNZFS0la c=1 sm=1 tr=0 ts=68a4c704 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VRXCJ1H8SIvS0E0DQAYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE3MyBTYWx0ZWRfXwl+UIvNPxaQ0
 S4iySzWPdm+iwJFmOshTC3BGwRMwWs3Ok/pWE53QojtV8q+uPbCYd74JUjoPgbiNLee8nRQbpcN
 4TDCcPmny9+pLnFuHCZ8qv0os9LBtNB0Ju3GOfjSJqqjOyBKeH3kGLpRgOtQvso1g4msdoSyVpJ
 JOomeXyIiWnFkTehoJzoWxOPLCM9lL8kFSu+diqkwinbSJQDzMKaWT6njdklZ4gstGj7KY7cEZR
 uAB71B11Nu1l79x78etzAD74UvZ1hX6TGM3OGsPmnMU4wdm8pXeutncgaIBkuNvHk8q9QiaYBvT
 5sqebsvLGRunfLn7pBnPF1+toqoS8/4t1EDhLnko/8/blZxJ5U7Sha5anNIspz70yhdQeoN36yb
 j9wZksYEuIrrsy9vbwzTHJcvDkwh5YvaY2DcGYZaNCKbvctzWGojmrS2pylkbCaDKTFufRDb
X-Proofpoint-GUID: c9QwltI_opcKYgCL4ZxuIqPRSPGB25sP
X-Proofpoint-ORIG-GUID: c9QwltI_opcKYgCL4ZxuIqPRSPGB25sP

On Fri, Aug 15, 2025 at 03:10:28PM -0400, Liam R. Howlett wrote:
> Add a limit to the vma search instead of using the start and end of the
> one passed in.
>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/vma.c | 6 ++++--
>  mm/vma.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index 3b12c7579831b..fd270345c25d3 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -474,6 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
>   * Called with the mm semaphore held.
>   */
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +		unsigned long vma_min, unsigned long vma_max,
>  		struct vm_area_struct *prev, struct vm_area_struct *next)

Luckily we will be getting rid of this as soon as I complete the mmap_prepare +
friends series (_actively_ working on this right now).

Anyway, this is getting quickly horrid, since this is only in vma.c, we could
make this static and pass through map to reduce some of the horror?

We actually can hand it vmi (and thus &vmi->mas via map, so we could implement
it as:

void unmap_region(struct mmap_state *map, struct vm_area_struct *vma,
		  unsigned long min, unsigned long max);

>  {
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -481,7 +482,7 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
> -	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
> +	unmap_vmas(&tlb, mas, vma, vma_min, vma_max, vma_max,
>  		   /* mm_wr_locked = */ true);
>  	mas_set(mas, vma->vm_end);
>  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> @@ -2417,7 +2418,8 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>
>  		vma_iter_set(vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(&vmi->mas, vma, map->prev, map->next);
> +		unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> +			     map->prev, map->next);
>
>  		return error;
>  	}
> diff --git a/mm/vma.h b/mm/vma.h
> index b123a9cdedb0d..336dae295853e 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -281,6 +281,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  void remove_vma(struct vm_area_struct *vma);
>
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> +		unsigned long min, unsigned long max,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>
>  /* We are about to modify the VMA's flags. */
> --
> 2.47.2
>

