Return-Path: <linux-kernel+bounces-837346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD1EBAC199
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392E63BAFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85079256C6C;
	Tue, 30 Sep 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JRuliGS3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HWRlYkSn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EA2BB17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221832; cv=fail; b=DGWBcu0UhkIF3UQ847Xl7WfVWxnel9DUvj9L0SLY0Q/qiPwcBPbHZwfIVQKMO/mvdnG3QIDyQIJbGHB9iIPix4kJUA90eGPp+zL0qXkwc74YI9kcCRtbFfM3aZs+oUq7XJ4haxUjteOp+jCwyveeSAXDCfWt7A9bhThsRtq+VAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221832; c=relaxed/simple;
	bh=KY/Lr7kqmgSWl+cAhQEyHMtdjn3kKmcuBZ25lXGKuQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJkGStQz3HH/OiX2MmkdvclmHIsE80gUnENQWSaXin6wVO6sX44mMj/q3zA23mQGk+Dhh5mSMCCGP/OREvccx1KvwL6WzpuMEqh3qVTodH2H9gsV7FJXeVucNSZkb/kGoe/7NaF96hu/SJuh1NZ7D9BfzUiuLRmSGyPkQEwmiQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JRuliGS3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HWRlYkSn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8Op6D014018;
	Tue, 30 Sep 2025 08:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8go3LxWS2AQgmUoQOf
	IJWFGiic9REvHLXyknuAUkinQ=; b=JRuliGS3K+EEKTWczDTxxORZJNkmbQ4p17
	8QNc+22qTUVB0GL5oNKDIdqYI2JXD7vVJXvPxBaJog5ImWfsiqaLEnNnV/WMgRP/
	7aiyk4VUHxuOV/kYPhxfN8+p7gHEueUuplLNdykwdCk/WtQ4UVSLmABJeYy+CXzD
	Lq1c9LS/iJEYdCrcHjQ1LEKLfrcvIhU2Z2j5I5ovxgILZdCr9ROQazKEOSNffKyw
	t5FAmR9Fm2LXIR7xNxsy7z8szqCieFMU3M3Zvo/v7gcw1xdH8R6s859LI+zznvV1
	X6SiMk2C29aOsp6bG/BmNHilJ9UUjrR0jccmbLvwtu0k5mrzBkqQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gbntg0tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 08:43:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58U7Uviw002110;
	Tue, 30 Sep 2025 08:43:26 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ce1ujj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 08:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLmr7oQRd61SXPfR/Jo0FshlDfcvDw13f7ZTtaN93+HzOCTZKMnQ3yxqt4R3RNhqcrPZwWLKf1Q9syed+VuPmHZajk7r+IyApgEHtZLl6Z24b9QEwccvYyRdeVRBdplEHMWcBXsxW57A7m5f4NFlKWWCT/1JDCriuRKM9dtTMY1fm47dJ+ttDCNe37BWPdaMKsYzFxQrOhscaUBws1/7dAu3vQzGRED4+c4/1h4W3prPImKj5CYM89hm4TihWEwXzLv89Uw+id42UykjbfFleDiBX5EVmQ/eCtL2PdYqiBh0+dJqz92J4duDGESwiCVsLGg5Cd2rKEEQgFMPSzBD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8go3LxWS2AQgmUoQOfIJWFGiic9REvHLXyknuAUkinQ=;
 b=Fb8f6P8QmmAsbcXEfb6vOpFq6YSnVgZRGUaKxBIhCO0W986/esMlv22MPqECXxK1TTHEV0fO0g2XDzU3JRsgI+11OWRh3665IPy7/w6il+55oIYDTHV7u+nInjcVhNZlSjFzMGbQjAV0tYkVxbBdiSWFdmaFLR+tkXYYZ7K6HeZMoySbNRfn/u1PWXfDo2OuftdGYV2VBJV/CQvvD/eugW2bBgt23RxWgDu1fSsB4hPbkuvO49vHGsnjmQZPFmskhKzlcKaiZ0/tkHjCwv070lf9PXcrDkUcSOsM2lanRwup/i/+WOSB96xTacLj2bTP4cw+d4MVlmv+lyrXHV3tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8go3LxWS2AQgmUoQOfIJWFGiic9REvHLXyknuAUkinQ=;
 b=HWRlYkSnygEQ4L182RWV6sb5fru96UtES5OgAQcnPkrzpH7sfQLfjDi8+inTmqLpTJOUCXELJIWHEpoaQFK+FZewHfqlG31rA2+Tqf68O5stwiJtIshVthBJSmlxvbs9SV9XBZK9FBgUb997hJAuRlrMEVtjsg51fHzjKBYtH+A=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:43:23 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:43:23 +0000
Date: Tue, 30 Sep 2025 17:42:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: ranxiaokai627@163.com
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn
Subject: Re: [PATCH] slab: Add allow_spin check to eliminate kmemleak warnings
Message-ID: <aNuX9wZHjOZgJdTm@hyeyoo>
References: <20250930063831.782815-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930063831.782815-1-ranxiaokai627@163.com>
X-ClientProxiedBy: SE2P216CA0094.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3ac557-e2d3-43ec-0e45-08ddfffd69f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uX2pz93vk7BeYkAWlwXDE76Q5lNwMwqSURoWY5B/eJdIAABRQH6g44ZYdkNK?=
 =?us-ascii?Q?IuOMZuZ/+6jq9ad67KLNRbws2XDNyZaFT+6Jx0VYtmuVc0TFZ3jLf/7dVvA6?=
 =?us-ascii?Q?gDbiCIT3JgV900vJnBWUwXgdMkx02Hzkkx2YsvHSUQD/KetWN2p5SU+au/wk?=
 =?us-ascii?Q?E8linZGMBK41p7aJh//zIK3sBiTRiAXXGOeenmfZ2ZAHPyO6d9cGVYbcJEVm?=
 =?us-ascii?Q?v+Is93FwY6FRtsyJifVrz0/otReGbTEkN2CAd6UacZLaooUQA6LstRsmufrE?=
 =?us-ascii?Q?GXPcY1H/ePWRLWFH+AZU0G6FJS+NmIbQdtnm4QvwdCL+To9/LQAVG1LkwiFp?=
 =?us-ascii?Q?N7ELu36h4kMX1VkI6Q9hrKvUaNtQ5CRVk+QaQn9fcwPElJA1jkoniX1uCxHw?=
 =?us-ascii?Q?1brwRsOT6qKbAGImVvh2JkP7QeCSyvrgkdbxqtGzjCqSeswHvIWHDbYQckfv?=
 =?us-ascii?Q?Gsw+duV2BGiyXlLXAAYjche8mjlpBYkf+r1sNvOkSi4ANWxxfZEy6D61GBMc?=
 =?us-ascii?Q?W5bJtLuRgFDmEcOFEFy7wNaLnWD3a/+biiTOLuVrd9/4aAubfhmgDdvsZrvq?=
 =?us-ascii?Q?c2Blc6Mo/81eyx3DGueWhkrMysHbjxAx5qITd5vWUefF6o62eH02qAq4dyY4?=
 =?us-ascii?Q?Q32aCZ+poBjkP82PLRPskd8OJgHz6YFcrqhSlRBWejfzFZzFQDroZkIiO3c+?=
 =?us-ascii?Q?JS2oQXs2cOwUdRrdM6oU+boscrAF580NB/G5x+jY2zs2SlExdQJ9PzRUjhm5?=
 =?us-ascii?Q?WgAaJGdIwdCIYqM2LkTRm/9x3trwiL9ifdRlNcDRT21RKJ7OBp3UubxjryzQ?=
 =?us-ascii?Q?40UmlVB5GeOyBpIYNbHChYPJCFYUVCpEzniAeTAYtqonXdKgchUZIoEQmLc2?=
 =?us-ascii?Q?nz/kB9AKBzxo5YOKBZUnh8hB4ByLInuquz9L7xBAeQrFc5LMd6jy+AGAwZKR?=
 =?us-ascii?Q?6o7yg4yVMPr0I4ZWdEwqCF01IGRcgjzbEQCLQAjF4KZN6JMiYKomxQ+Meuf9?=
 =?us-ascii?Q?RvWUK+stL54CCC2H7pvkkvoQrXu3R/yKpPdamFao2H4FfKuqqvWKR24o23/v?=
 =?us-ascii?Q?Qgj/tRo6zAzdYEFWGz3TJHkXDqNVOIcTOET/KvD8KardrzMabWD/C9trTQuh?=
 =?us-ascii?Q?dz+nIns8I4LLdhvzP3OALg66uJOgzv4yyHsqL8t6hQdlivTzmpM2AxYy2s1o?=
 =?us-ascii?Q?M+Co4e5/cB7SDvv0MORPWh3v/BriFUNFroKYADvaVd+fx8rGZ5cWfpbONGiE?=
 =?us-ascii?Q?r9Dlt1WwhdzevqEt+oJd/SZ/5VvpVwfMWf8tpEQczfTls2ylhmiVxWXsFAN1?=
 =?us-ascii?Q?Q8xPJRP3KaNX16si5hHF11gvoQ4d1mmkj7sh1RdYiEO8q3ol4KX20bQkieZ0?=
 =?us-ascii?Q?2ss2z/aCs7ntxAZrOs3wQ+1ytXNZwxOn004GHwD0UnpdT9/kO2xfO/XUDpkO?=
 =?us-ascii?Q?+jummXdxozkWqCXF6csHuH7nuV0GJYAV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?70wR99Kkbv1w4EcJ4tGjVBGhiCOOCNX3dzE1Ow5lsTvzlrUJrCOqf0W9FFqz?=
 =?us-ascii?Q?KYv344lrzH93x94TEeo8SeftlkGHlkZf0PTOVFb21VfxF/5tj5xnsOHeYkgZ?=
 =?us-ascii?Q?VX0sgLN1XZfblk+I0bpQJrzcMzNPB3KJtaz4fLSH57TOcVnL+uNWEFGabLNI?=
 =?us-ascii?Q?+pZW++2ESNMp13nBuJWFYGB/YWIeps3h1NXievulqc2E5QihMvyVcRDD1CtP?=
 =?us-ascii?Q?xwWPQYMqJIkY+Rza5LOq9LjzE/Pc6p9XachGT4qGYEj/0I+sp7cO6wEaKPCR?=
 =?us-ascii?Q?HZVm5EWl2Df06YVRDJAgCpwrRs9zBBUnKPG59XsVrekSSGU0YLF8H9c2vwBA?=
 =?us-ascii?Q?BQ22JbooQi4KS4uYGGGAtRaSlpUBGXGKFcbmap2r+7Z/Iul0fMKP/EGzSBRY?=
 =?us-ascii?Q?sbKWWA6UfO02bWZ7CvHDnsjq++c9kWf0HOo5dy66q6xOu4X2eZjSc94tTZc3?=
 =?us-ascii?Q?fQgcEJqEvraEoSUwFmNf31cYyqwZikMeTk0u66RIjxnLU4lGp4jUqe2DNO0o?=
 =?us-ascii?Q?/sAgvtNe1xmlQ9b8ZcXPMbcPK5C92IT4ZBlw1snU37q6lYanmdh06W4qLnxr?=
 =?us-ascii?Q?LDx0Cc415pesi6m5cIi/z11/abaH74WAb87Hs3dMIP7QekEC3BOcCB7MmhDs?=
 =?us-ascii?Q?8rxhy7XiCcG/xTg0PpPd6PNrnM9cu4RTBVbbD8TJdgwT6eH0itd8J9ybk94n?=
 =?us-ascii?Q?io9pTZIybRWcJxgKAb58gQ4rAhrbM7xD90DRkd0mQUIjJJmJgCDOVj1XoAa7?=
 =?us-ascii?Q?1+DtWcdDnzBD0ptnH7VrUzmjZRXXfgl4nP3P5v5TWeMqLu1LR4w+6akcGL1E?=
 =?us-ascii?Q?MT66rFeQCerNDuxZeMgyxZF4g7cxYBK9zamVFA5c0Ox0V6cODgpO3fg2JL6y?=
 =?us-ascii?Q?qsNiYjZ0apoElvck5wlQzPJF7IqoNQLt7+BYTUP8uEf7aGE+lplK3XtCnSn+?=
 =?us-ascii?Q?qcqn/6oW+rjxkOmqpOIS+EAVhc9Y9Cmqi5OmOe21LxFR1iiYPEtq9+YJ2vmr?=
 =?us-ascii?Q?ck9pcYTZqpy9GLQXS6Nomto6IEbHgkCPeJdhFsiiGrACE2OcpkIxZm9Bak1l?=
 =?us-ascii?Q?lMzg2KvK/ilXQ9WjTjR+fQrbCx/a+kGbDvP4VGZnzGXXh1yHIUS9oOrnbGgg?=
 =?us-ascii?Q?Fm7Mk3gL3McsJ+bQ8YlV4RblHEK9FnYrLFK48XMUUJmKlASI22e0Tb+tsveJ?=
 =?us-ascii?Q?cByFPe2Dos1hsXM7k5JXQehc5WaBPUMGe7opId2YvlOZG6iyA/0/8tlCs2qW?=
 =?us-ascii?Q?4ATgyHwuQP1qzm9Cm5TbdDv3Hcxp1uk7PHkkUORtBnp602Q1iQEB6JL42sPG?=
 =?us-ascii?Q?fTaOS6ryF13tUS3P7+aAzPzC31r7w6zVYyYA953RT0oMZtp4jBSg5Y/mcSYN?=
 =?us-ascii?Q?Jxu3agJ4OFvfDaVhsw8dnvRoFfbeJrmEJ157hehuDn91iy1sTv5W6q/+5mTJ?=
 =?us-ascii?Q?VK0wvu8Eg96pNMX+9VGPPSuhtg+5nTHDoHlvjTQjSxKNJM7QRFc2L6GtVwsU?=
 =?us-ascii?Q?CrDq4PWJP3kKW2PpeyO7obS0qvQVG92bjlcQwsaCtyzDjC3aURGS+0cjri0R?=
 =?us-ascii?Q?coJdIB5b1h0N2btqBCOSj2LIdxYpPWxxw6epZyK5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WSVY4Ea9p9TCi9KJ2IE/UJ2GHTBsVVUVhIHX0f6mRtYmAIL/k5fkGbr2NgWkRfvWpeL4FT1kYDqLWUoodnn94xFpMHTDQAJhTboe+Yf9A6/vmtq5GWj8NwWZLE+j6Or7Pi4ofRArhpPGO6DGsWDJ8YzVMKbdUUoYPQunCT3X+6sELXH2LezW3NKb829kezRxIQuenvUEnQQg4/l4bBn/p9xaluA/wp51cMBFqFP9a2z/zGScOHmpG3ayZOWNT2eIgnHbEUdlG8W1Vpr35JjD+hmGXu3Npnsqxe+NZCidctKrb2D5mRnLFEB5HF2KruBsemULL3sUvE+X+oKBLUbpJuNrI9txjOMmYz6+zWPQ9otOeoTtZDLkG7DByR3oS4FVdbyh5WQrb32Fh2rQWC4MXd1iG5AHy6xtaZLQ3+7ZnKmEwfDRsGUBXw6PSGZOl+WPPBZim72WksLUKrkP3No2vXte/GJ3oxhXWfF3lLCx8DDD3DY+LInG03JvRRigCYx0q4OMs9yjqjEajbBeR1Tntaov9ZUG37mXRZ2wrN1HR8dC08RYTonXnziMji7zo6zwkXjFgpBKn+Xq1/6LboDXs6wkKSHZMoIu364KptLqBUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3ac557-e2d3-43ec-0e45-08ddfffd69f8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 08:43:23.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UArjrF9J9u9Gft6bYhzNyvqM+dwy9j1RJhCcwsUKaPEE7bIQmZEGjVxN71uqqlL8RAk7XlaJnHV0s/zB4E4UyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300077
X-Authority-Analysis: v=2.4 cv=R7EO2NRX c=1 sm=1 tr=0 ts=68db982f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Byx-y9mGAAAA:8 a=1RTuLK3dAAAA:8
 a=yPCof4ZbAAAA:8 a=BjJr512o6nFGqQHzpZAA:9 a=CjuIK1q_8ugA:10
 a=kRpfLKi8w9umh8uBmg1i:22 cc=ntf awl=host:12089
X-Proofpoint-GUID: JTwBewigSqXleaQHTjs4-2-3vVHTRlzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA3NCBTYWx0ZWRfXy5iPKtkHgpeL
 1IiJnZT4CTBOnXPb9JZvLVrvfHs0T/4BsqlO6Hd0+j+KdxI2e7mQ65f+ztl2JVcF0QNDjIclVJK
 g382Q4/lpWDBtNMfEyxGnASofQPJibXsmGAhlv1Sa04t6Zu7zHujF2Qivc5qlGIkU6kV/Vk/dA6
 mEJCymatmN2kczH/XO2wxxtvQF51SHd4+WrrnHOP6FmtAmPHcmxCamvZcSxcQY7QQ5528++lxsP
 OYIjFEOgG5UcfFiUeKNtfvG3gk28WSrwVWpXg5l7M/x09aoNNyFgApa7l/dLxBuKLdqB3QAx6/I
 ztTlj3rwPZBCE1B8Yi8J1OQ8NxwTlPyuMt807bltu7SHt4ij+edJ2S2sk/I7CO50ewN0egtwe1C
 t+PvOON0S72siEPwDPZAwCAq3abjJ3e3S50I98QXy4wrr4znTgE=
X-Proofpoint-ORIG-GUID: JTwBewigSqXleaQHTjs4-2-3vVHTRlzt

On Tue, Sep 30, 2025 at 06:38:31AM +0000, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> In slab_post_alloc_hook(), kmemleak check is skipped when
> gfpflags_allow_spinning() returns false since commit 13d872ade8be
> ("slab: Introduce kmalloc_nolock() and kfree_nolock().").
> Therefore, unconditionally calling kmemleak_not_leak() in
> alloc_slab_obj_exts() would trigger the following warning:

Good catch.

> kmemleak: Trying to color unknown object at 0xffff8881057f5000 as Grey
> Call Trace:
>  alloc_slab_obj_exts+0x1b5/0x370
>  __alloc_tagging_slab_alloc_hook+0x9f/0x2d0
>  __kmalloc_cache_noprof+0x1c4/0x5c0
>  __set_page_owner+0x10d/0x1c0
>  post_alloc_hook+0x84/0xf0
>  get_page_from_freelist+0x73b/0x1380
>  __alloc_frozen_pages_noprof+0x110/0x2c0
>  alloc_pages_mpol+0x44/0x140
>  alloc_slab_page+0xac/0x150
>  allocate_slab+0x78/0x3a0
>  ___slab_alloc+0x76b/0xed0
>  __slab_alloc.constprop.0+0x5a/0xb0
> 
> Add the allow_spin check in alloc_slab_obj_exts() to
> eliminate the above warning.
> 
> Fixes: 13d872ade8be ("slab: Introduce kmalloc_nolock() and kfree_nolock().")

The commit hash in the tag and commit message will be adjusted after -rc1
when picking up this patch.

> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 09cbe580842c..a76275f4870a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2145,7 +2145,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		return 0;
>  	}
>  
> -	kmemleak_not_leak(vec);
> +	if (allow_spin)
> +		kmemleak_not_leak(vec);
>  	return 0;
>  }
>  
> -- 
> 2.25.1

