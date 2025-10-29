Return-Path: <linux-kernel+bounces-875652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A769EC19898
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8514F1870
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F4328618;
	Wed, 29 Oct 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BdDekprI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EXmrd4xW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFF31AF3B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731703; cv=fail; b=aH4J2TQk2U/0Z+wzxsbe/bdBvAbGiTomMLHcE8erMwoHHLKNgE0W5cfSvnsqZdjUkCToZLskGwvyv/vuXlgTvDDr4h2WEfG4QtweRjJMVRCzpgtu0zbAjDskDNCo7zzDUV8bbpDojFUSKBL9tuLQ3uXgsFzub5TYtSDUg22UzXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731703; c=relaxed/simple;
	bh=4+QCk3PoUtyDlMjDUEuJy0k7qyei+mvV0gCLBm/6Xuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JdBSGoxeaoiHwL5fM6sr5PX9QtdCv92pK9/tSGnP2Wc6amWPITxQvcLxHQxlEk8HnzCF5QZ0ot32ISvDbpbkUwuSP+RSFmAbp7SrcSDl6JiV5uRFgda1VyENdZkRakF1yB1luBH9mNjs7CxiZ/bO03G65llcgjL+/GCZH0TL2EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BdDekprI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EXmrd4xW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gE0b002365;
	Wed, 29 Oct 2025 09:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W37LlIobXiPf6KXjO7
	1ApqEewz26/CyEJyhWtF6TqPQ=; b=BdDekprIkJgSymPPZDn7TyHuiv82sWw6PT
	/NytzJ1sx/odOsnzwhFKkaC4SgnRfPs8XszWm3aF56UrtWnbprmzsHaIaDm12kK8
	v48R6dZ8YOm9Y/vxyIQfMwPoj2smq8FamXbnptJVCA1rVFhYRSN/io/UBY9aKxjb
	zdPvNaCUFa90OdIBfVoJycFZrzwqS4NQCuN7SKWvl+h6hQg+ez/X4SWnRRXDIsl2
	1e9mlKmgOqj6y2OaDoEGw+AoGQZ/LM4zmsO3aSPdYBXZFmt0m+jOr0mSfOWNGBZu
	sXbtT7JOgzhPQNloDAtnT7m6fW7GbDcdCmHK8HokXna+A1mtz9lw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cv98eac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:54:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9Lajq015922;
	Wed, 29 Oct 2025 09:54:50 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q7esc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMZlaQXpojuzC36Z20sswqE9oKLvENYtJ54aTmz+AtnwyLOl1Pa2q90O+wigeym5QBISnfq3vw1KLTGZGFh1ILMnOIDt1QTDPedyobKW3fPjSc29Ih2OLVxD9endZ50n1uCDM5jSkL7AkzasH5BvncFMBPSmqmt66DcMWAoIuAZ60wP26RWIvYnLhzkf7MBEA8Nw1inmDzBZ71U/MH17EuaUzmT032wqGPj0YjbdNEkxSZrCNdeA+O5ByzLmkt8cj8KE0B6B2gJ2jsFLt6egxORPiLBtnyhqOeTaIJmhjRnUvi55s/RK3bFOZFk4Oumg2MGl8yGqUyp9OZvf+5JM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W37LlIobXiPf6KXjO71ApqEewz26/CyEJyhWtF6TqPQ=;
 b=ASQYY7me8knv9erGEevvGVOyhCMVY4dTxnmfQHTRjhxor/ogIKRasHkyZfIOaD+4dRl0Y1UPtQxomUgRuzidJxyuPeIHVkXS+J7A23ezVMnmGgDHyJDyZ3B1PHc+eCQWRAK1cbi2GoDkx37PfyDnNReeEFQCgjoIs3KLjo+ffNN2e6K1F3gL+skdAIHsycox2fMM4TPAnwUvhEFcm3zEyqiiags84xi/i3eI0i+1lQM051ZGtLYQLDOjOB/mfET1Jar0oGNNbELEnJiJIF0OJNjF5SQYqzhUGgq+0yN6EmMemDX8WkGq7eYpPqR+gcFgqRr3Wy/2lN1eG8tMPjpV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W37LlIobXiPf6KXjO71ApqEewz26/CyEJyhWtF6TqPQ=;
 b=EXmrd4xWf1fuQDuceNy9FvvQrlyOcwatQbxIhmtBHgKDYF6W5s5rRLKMl9+yr2qEeGijq84Ef0xSRwxTmV09dh5MFnrYDWJ34TMvVeHgz8OQEXeR8c1As9qoigv51OfdUGA524RxUiGmyPCEVr3WUYcTRo0aNVhZPn7F01P0Tlk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 09:54:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:54:47 +0000
Date: Wed, 29 Oct 2025 18:54:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] slab: constify slab debug strings
Message-ID: <aQHkWyBjAlyh5tNX@hyeyoo>
References: <cover.1761324765.git.ptesarik@suse.com>
 <819095b921f6ae03bb54fd69ee4020e2a3aef675.1761324765.git.ptesarik@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <819095b921f6ae03bb54fd69ee4020e2a3aef675.1761324765.git.ptesarik@suse.com>
X-ClientProxiedBy: SL2P216CA0084.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f2e09f-57a7-4f4f-1a5a-08de16d1317d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFWW97TIzr/ZbXZyR3oRQX0pz/hgRSeiomE14hCcTs9731872V6wOGhlnmr0?=
 =?us-ascii?Q?C3pOL1jvo+Ctx0qjYopmKgrAhdBvvR/UzkEDhYW1N6IR3Ul8+N+XRbjiqFrn?=
 =?us-ascii?Q?SDJie3Q+6C7zKjDIXo77uLMPnlchcNXFKo9wCyGVXHLalzojluKuR3Z1P4aT?=
 =?us-ascii?Q?yAmiliswgQJ795l0UP6rBP/8VmCC3bxlcQAFsbBmUbCBH4bzovoIl9JDmWDU?=
 =?us-ascii?Q?w1LUpjIq5UkP0wtf+ja3yaEKAqHcozw0ZyO/aKUE4MJ7vkKyboY2xmowDPRk?=
 =?us-ascii?Q?ie09SL1c04yy+BFcj+ot/1Ck9M6BUbWYTcl/lbmxbelQJsaEE0ygLiR7Ehwx?=
 =?us-ascii?Q?dOhQplD4zwX2rvJrq2TbZmIkdbFT72CS5q4psg6bbUktl7Ge5CZ9JAjma655?=
 =?us-ascii?Q?5mtWdBx6CCQdjkTfb5Q/NqnXJGPNjzeIkEzRq7FHH8ZB1MPrV4hWznBlYy/H?=
 =?us-ascii?Q?74WLgKZEG2rPGDPQDLHp46J3aCckWHLi+Jo4/QB/6SdfnyB+gH5sN4uPnkwv?=
 =?us-ascii?Q?jGbjaYQ39zz+ItzP8FH7QeBX2EG7uPe3p6e6RfF9tZhwMlp/POYRRt+2wag9?=
 =?us-ascii?Q?DKkZec/6Q5JWVEVYktKiSwcNE75O5hzP4tbUXl5rSkPM5FW5RVTcE1zjcelo?=
 =?us-ascii?Q?B2UbUEcbNcOH+Lo5YdDi2qOOK/fRtGGlR+0UGDbgC5SvqFAgv1NQxkXHoaaT?=
 =?us-ascii?Q?QUf9CQ+SScBLMwfD9Rqw9xK5aiPzkWued7fffYDiLFUXOf5wq6Wh61JWFQAj?=
 =?us-ascii?Q?2SXDMvhR2Ka/0ww6hqw0z8y8teGofAP6WgLjZ63F7YBcZNdL/yKog5K8upul?=
 =?us-ascii?Q?oS/WYXQtLB+/EDwEUEhiuItfLyGiyECf1hYiOlLP5F+qE8GqBJhxLi1BMDKK?=
 =?us-ascii?Q?P7pLjlRwmr/bnK/V9Xp5SKL2FkzUWytojZYXUNWdQkCRopgPRgXAojnqP8NO?=
 =?us-ascii?Q?ilTviapGjKKT6aH2dYQww21FoPck+7AK6/UpIh+TQTXByhaS/Yd0CvO127uP?=
 =?us-ascii?Q?Ejr7UgyYIgxynUXSYHTJ8Ilyr4cZdzkj7pPW77lWVWCpHtBda+lRCg94vD1y?=
 =?us-ascii?Q?7kEZW0hvuz1UHEcNhJfjBTr4aS/p8WfmLZrM5jt6+6Oy2AbG0w/vR6K9MKAi?=
 =?us-ascii?Q?+mz3svYyfud7TNNVWaHMTqjFmzu4tK5yrv5NSav7cGByP8IBKydPbAJtet+h?=
 =?us-ascii?Q?6HiQag6Ods1pjFtI0ztGs4OF6n2J8tUZm/JTCkJn9rk8JsBc3Acdq0LefUCK?=
 =?us-ascii?Q?IqBMLzfqrN719wHwQrDJvKgj9tdiw5glJe1/qcPzmnfhYdNX9iA/4JM/+y4c?=
 =?us-ascii?Q?xVJN+5A3OsIrtAeiKswYDR5cMeMm8Pj6lzym+5Oo+plBYiQ66xenhQNIk5CD?=
 =?us-ascii?Q?0QUX5U0+nkA1XqTpddPBdQB57s56oNvTGpsAKHyxXAYYExTabGB4wAQlTMmx?=
 =?us-ascii?Q?PRcDl6hTga1gfr78de1oRQVkKDD4rgZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E3kpQy2LZrg6G1jfAqf40khwkCEk66LoSa3YUJJlUfNuhamah3AR9NwikCFp?=
 =?us-ascii?Q?iTQP5V4Ioigb37EaHmCHzRl4UzrXBPyr4QNX7B6/MEhhIvd3c30AGv84olHi?=
 =?us-ascii?Q?f58CHe+CusOUaAFsWF+CCVzUP9y6oo7+BaXqVTWJsmJajYMhGdGqgtE15Cty?=
 =?us-ascii?Q?V4q2HUjfYeEVjMAS4O31lTNqWlSWDDRyG8h0FBngL+P7oms/bym9a60oyTnD?=
 =?us-ascii?Q?QgOFARXuiUz6IGjPhFVsLOiZRwwh1ZIxD1Cso11XPZdmZ4ZKg3LS8la2+jhK?=
 =?us-ascii?Q?/yvPpwkRRVD81wSrrTBnG90TRvAJZeAUhi6Ga8+lfIiCeD3rnqyADzx2Z4Mz?=
 =?us-ascii?Q?kUEbv1Ub3ZITW/fzvQKu3ewzVC45hjQo30d3JySAD62PIMRYG7oO6q1dCin8?=
 =?us-ascii?Q?ZL/NrZWaa3Gj9citRKGFpTjs9L24iytejFLW5rbEQDjZLlpsVSl61dB9Kt2V?=
 =?us-ascii?Q?A0mj61TjddZNIPZLk282FfXp+CMAqi2FgEH056UT8djtrLLD0d82e1lMItb6?=
 =?us-ascii?Q?VKRAYCB2ilEhiYeM2Vm5wFEzDcYeyCuaOIx4LwXgr7PPDPupF+skLkRe83Jk?=
 =?us-ascii?Q?5BA/5Knk2gYgDSrVo0ldL3D6WklMTsjMGqa+peqqgTn5wNHpQypksVfDDGjx?=
 =?us-ascii?Q?pyKNnvSE2V1Samc1b1WGKCtMrGt40fgdhGJlHP0HhHd2xbNiKV2nOoMuS5w2?=
 =?us-ascii?Q?Xf8AakZlPi+RiMDpEUUrQltuRQZ6U8hHi7gECLGN7HPknUCWbIbXYMi0A6Or?=
 =?us-ascii?Q?peGLldTyP6FqSmh75Wyvg7XNJllsrxm48zi57DkRJz6pmP+U2fB+GUit1T1e?=
 =?us-ascii?Q?k831BsIx2DI3f1N+fW2rGxQmbfraqYmS/Bz4AecaSzUgCJjxHon6MQZx3bvy?=
 =?us-ascii?Q?PdZlncjcaC+6BO66XKIf1CYTUSVxXZdVVWMP6I7vnAoNCJPghYBOHwWrk5fG?=
 =?us-ascii?Q?/NQ/bvec6muIj6DjXg5S4sttWN6RfyPa/G0CyNiCFx071+br6lUX/ts+fTl/?=
 =?us-ascii?Q?DYMq5PaNueI4FvBEfvINhkIydEnkVTGuuW2z29Li7UXc+Q3tXZnMsUzXMMrH?=
 =?us-ascii?Q?Za4bimxt2wHGvJok5XQzzTZFxP97RPn0vZ99B2G0t3f7w0Cnv3I0MdKq4Wg8?=
 =?us-ascii?Q?w3tlMwnjtJyJIhP/AElHtOUcxENcBv2WihFEEpHfdH8m5J6t6+WesCOuh4h2?=
 =?us-ascii?Q?VK1TKl430Djj3dUOCvNuyRdXNNBHQSvEcjOSZusOVV1tPCnvvw62Uj/uTmve?=
 =?us-ascii?Q?G6ghvy71BTNhNiuByChtrBGCExbm7UKBSn1XYQIUdPSkukJp2NEKgRAyp0uK?=
 =?us-ascii?Q?SjjWvYssw4dB5I71vSSKMIBJ1hirezdNSa6cEWaMyJLLKo4DwtlqGGd11tkz?=
 =?us-ascii?Q?qu+CzBRFCS74oKdplu0wdB1pSGHCoixIKN4oSlkHQ2s8kkZMPWeA4+wu7U3n?=
 =?us-ascii?Q?20mxYZReZVoCNbpFN5GGXI/WFSvXneBioImSr/Yvdw64n6dzBnMxSVVnwkK/?=
 =?us-ascii?Q?z3LWL2Bf59fpfTVgs8buDL7b979FYBpms9N34wIRYu2nDi2O5b0hSHsK7Nu7?=
 =?us-ascii?Q?dAc/VCaMAwkYXKtkpuHRCbt+eIuGliTFwgqpb6rR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cSoeBI6ixg5c9q1wdO9c8rM3XimST+pbfJXsTX6R8m9e6/Bgmy2izlaLja00K69Ty4svrnnYBhLg5SW2fBfm3AfEqkDdAUHpwvCEcO/W+OJSyxlJ7doF9XV9a5UhG3e83Ykq1TcgVGTikUC/x/H32A0t7D2K+DPAE6fxJs8r9tNsP2kBg82IJs6OOKSPObrFtkoe2poJ0x8YUXWyWVNP6O3LCG9qPvhHh4036qNOIKRklpPYGkhwtaeel3lbz6T3+HtmVa0RIy956pkyoYqUQrKEea65pllNywHizlu6/SO5OKCOcms7GKG5tfQI2gg/uURCi7EjcAcxY5yNIwsKKTlBH12fs8IOUW1D6mpngzjwnkJ5shBtMX3uLLcZvDJE8H9hKETYTftPeBcMclkKwjA+NmnKY0BSpuP1hPTMTzTi1Ipv4cNt6tSd+ptZAF2IS1A2xabDM60ulDsWqmQ1JGFKxGHSjJ+10iAiqLRfYyW/ar9TZToeh5zm6pmIRNUjdIxdTuQvooWugxmNpyrs/06UuXCU4CAWCKOoNmE8djrSb2MKGjESChVLBWrjh689KpwPz5tUh/RmKFTEz9KyLU33jwU5meGzZqNrvxL+E7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f2e09f-57a7-4f4f-1a5a-08de16d1317d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:54:47.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abv8iDnwhLOCUogjnLt2RXGlM9UiHSV634n6FC7BZ0eTWVCgb20sppFThFAeXSpr2ufMw6goHIr/JiVNA7GbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=994 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290074
X-Authority-Analysis: v=2.4 cv=NfrrFmD4 c=1 sm=1 tr=0 ts=6901e46a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=LyrMqAReekixEasevH8A:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:12124
X-Proofpoint-GUID: QqeHr1hqvhESIi3mjjga5Sh2OW9H7w34
X-Proofpoint-ORIG-GUID: QqeHr1hqvhESIi3mjjga5Sh2OW9H7w34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzOSBTYWx0ZWRfX1XacLbPcg21f
 zwFAsxVIPUU7Bv4WHHUbOmulCKtWQ6TlFhAd8yyKHjUs0keedP6+evMiLa00McRkUmPA07634BD
 2OsSpSNjftPExVSk8PvgGFOFaqZvWRBvHScHg4gqguo9sbt9kgUpv3YE5fmIUSfujGTmO9lq+ps
 pEsou12SZ/hGQV+4ohVRADEgPF3Slk41KjYLaLdf3C4FBzWra9YXUusA1BQs7PkzFrGbL6kdtmM
 wbRw6b+pDmTO/fZgsncu/kGXx+e7oSUHsxl+E0a3zuyrXjCEY6lBZgjasjGvPJZaOwLPeetyJD9
 Ih5GmzIZ4JsJtFXgnG6wTWUyX0xDFflM3aQfsHFJN/hPl/gb+PsC5FqksymxpNgIH/prtz0wf+u
 PJby4UM48kRjet0g25t2rJjAzO13Mb9IDAjTJ2hIDRodb0x0XKo=

On Fri, Oct 24, 2025 at 07:06:52PM +0200, Petr Tesarik wrote:
> Since the string passed to slab_debug is never modified, use pointers to
> const char in all places where it is processed.
> 
> No functional changes intended.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

