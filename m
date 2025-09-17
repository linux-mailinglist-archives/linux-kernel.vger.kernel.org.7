Return-Path: <linux-kernel+bounces-820998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D639FB7FFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51B51C81C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E1D2D3A6D;
	Wed, 17 Sep 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QnNlqHss"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C533C77A;
	Wed, 17 Sep 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118889; cv=fail; b=OHHzFrzfzlh+z3ccezdmkvPtnsusdaoW6yeTrwjZMY8wli3Dt/QpbSHr6VSA6fFsON6nza4BHP/QJwb4GrOFsTsf+3YwLzDvdtEzeZ7t4Zimqd0aMbwJW3xOEoCy+oPCLdnucw4+cnrB8V12Iyqn21xCQ/9gK7vYpJB6bKXhN3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118889; c=relaxed/simple;
	bh=sRoUCPlRX9kDRcSS4bY4qw0lt8izRt/KNYXTdT/Vwuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HymkD4da/yU9i/xxFln2+wM7RQaDUJuspN4E7Z5ibPnEgx24rkDubyEbtqPbkzNasCP24SmR13dN8/g7YVFIicFFujxClLpFyj7flvLLVLOCPdtH0ZgRs7Z9kssMVlHaian7BQysfeTtOVYr24XwR3INxJpj1gw85+Wy3xDTrdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QnNlqHss; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDofBc019816;
	Wed, 17 Sep 2025 16:20:52 +0200
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxgv7xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 16:20:52 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF6UdREvVCXfMucWSpFYzdzuvegrOs1F1gOjRVcUM8bGAtR09xdzUdU/1qCQVhD6665O5Qa/5oS7GljBXW2aIwyJ/JUKa/80g5je+N5fHWCOIn3yCIIqaquYrCxfxnAwVPlGAacpj7JMNwP9Z7D9dpL2JaXwlYXv/0widte9/gTmfiMqrvnoEEzotWpMxDz+iRvTZP4Mbo5KGzQf0BWSxb2uewy5wXuVHn9gxbBz3Oxg+SFY39odCRnTU0ItfAPVs8Yhdzg6mYTEOc54gDI90KWj9IvxT29DrpLoEC/Zx4s4a0jGnOjA38pX1O75YXZZ1V2Y34dPSejfMzNlL8fFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fXWnAcwy4QY30y7K29mOFLIbpOkUW2fwS3ybjf2ArY=;
 b=xPgTj4EnXUGDQoIUdYVsFXXvGOmPPF1enNSvhtQvaefk1ED6AjZUv8C5yC/3+gmvTtkdiM/pM5lhoQN/LwpcLL52tRCbT030ZBJNILxVE3OuIMm3yMp5ZizpLJBdAorxaVeiBKhGoT2QXvA/I4qXyAYU7VuiX5YhPOzRoV5VC6bXFvQ2sFPyxhp738AxLlczJuoSj5C495TJA60XfPiPdBVDEjGWFATvTOQZ55ZM3an/St5dcksAezP1qxSVbOMs3jutwxvGQcUUPONLrct7x2gKJkvIq6Y3CDkDx5uzlolConbhIGwPrhFJKSAXsVds0Z7HHlfpjcv8JpmqLyKZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fXWnAcwy4QY30y7K29mOFLIbpOkUW2fwS3ybjf2ArY=;
 b=QnNlqHsstu88oeKVfN78rfr1h4zxT/AxMn8G86wqb2Khc5CKaNvycsWEjV5CrUCEyked3881HbVyGu4xoHJInt/NNW/13M1xfqaP0rA3Fc6bWu7Wj0xr1+IX0UeYyghYqTFOJh8x7RaAG2Sb1IgOMBG61DRqKzsk7e2V8RIuDRgDxwXohrXGjrqihQHRhdE/9cvY0en0QkEZLKhRHbGqosZB43ZUZI0GlHWD2C3q/h4s67HvYDOzPQoAv+dFyvF/BQtaED1K/wUFpyyK6VK1aScIp5Kn0W9H0+ErOKfOhi9rqtxSO7ENkOC23xxskqlm0sidUJ8/K3dgOeY1ed3zwg==
Received: from DU2PR04CA0244.eurprd04.prod.outlook.com (2603:10a6:10:28e::9)
 by FRWPR10MB9254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 14:20:48 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::8e) by DU2PR04CA0244.outlook.office365.com
 (2603:10a6:10:28e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 14:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 14:20:47 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 16:18:22 +0200
Received: from [10.252.19.234] (10.252.19.234) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 16:20:46 +0200
Message-ID: <a9725bfd-a2b8-4343-83f2-d18908029ea0@foss.st.com>
Date: Wed, 17 Sep 2025 16:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: stm32: sai: manage context in set_sysclk callback
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-sound@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250916123118.84175-1-olivier.moysan@foss.st.com>
 <87ms6taph0.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <87ms6taph0.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|FRWPR10MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: a187dd9a-1bdd-4446-1b9e-08ddf5f5657d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkRCR1RSSVhYTFhIK0s1Q2VuK2gyRkNVeE1ZOEcvRnVZR1A3emtnRW1XSXpF?=
 =?utf-8?B?bTAwd2JEVlNqL3VnOVlFWmlSV0cvYTlYWFZkVm1WY1R6WlhlOWxyR2pPTDNq?=
 =?utf-8?B?T3pQNENRWHVrUjNyQ2l5aHZRTjVtaCt4Z1NLWG55OUZielFQNlZCaGI5Tk9M?=
 =?utf-8?B?aHJHb0ZvOXloN25ybFEyUnhWalY2Y3JSMWpMdC9uOEIzdlBLVHByRHN2Vzlv?=
 =?utf-8?B?SDJiUUQ5dzJ6anUwUXRpeEJjTHJXOW5BTTdBbGswT3R6ZFVuNmxXRm1WK01k?=
 =?utf-8?B?UHlzcllUR0RJaDNZQmp3VjFtanBnMkVHZGg4dGMySzVhUW5MVGJGWkF3a2E4?=
 =?utf-8?B?Z2xVdmhZRVNJYTMyOTlrWHM3bTY2MTB2cEpoSUZsS0ljU0FSSFhxVFh5SFJq?=
 =?utf-8?B?TzlKcFUzdWhoTDltT1JwRitVRlByYjRuNFNUQVp5QnhtOTlEY01qa1EvTFJW?=
 =?utf-8?B?bHJJS3N5Wk16SDhjVVhVamtpekN6SHdKZFFtbllxQnRod0d0clZ6a0hXa1dX?=
 =?utf-8?B?TXBvQklVU1Zud1NzdHlLb3M0SlF0MGRlb0Q3ZmE1VklxdmZJRzBGSStna0wx?=
 =?utf-8?B?cm1HT3QrbHBXZ2hnUDg5cGg4WktuUGI1Njl3NmFHM04rQmJySUpPbjZiNjkr?=
 =?utf-8?B?Wkdkb1pVQWQ1Um5uQnJNOXIrblFVUmR4bHJKTXdHMVZmQUptQTY2SnArUHUz?=
 =?utf-8?B?K3RCbUFwcHI2eTFwWEp1MkRVbnA1VmRmTERBemhFQ05RclNuMmJBNEpBT1hq?=
 =?utf-8?B?Ti9BYStGTG11TVAzR2k3MmpEUXkrV1loV1lWYWc2K0RrQkpDWFpXVnJUVXVM?=
 =?utf-8?B?M3BvQkNYbTl0SUo1OHovNWpveXRnMVkzWXFHRDBXNFVRYXk4Rko5dlVseGpJ?=
 =?utf-8?B?dTdLRGNETnVsSDlmcG9BMEx1bFlCT1hGdzIrVjZZRzltUGl3NFR2M1lSZTht?=
 =?utf-8?B?UHZvQW9hTnEwWWFGZGFxNmpBSkRIakYvQ2V5ejB6TDRVK3dsN0l0aDNZcnpN?=
 =?utf-8?B?TnhzTHF4TWlQWXAwZ1AzWWY1eWxFMCtzVDQvTnJ4NWo5ejRUUGJmazM5N3Q2?=
 =?utf-8?B?TVVxVjBqc1RoMUphT1llSFRjK3BKRkMwYWg0UDZwR2JKeXJBTHBTU2Z3dXBx?=
 =?utf-8?B?WWNPWTdMdFVIMllFQ1p6b2o4N3Rab2dCTUZJczVoNm9UMGQvYWprNmRGdmYz?=
 =?utf-8?B?VFZMRHVXY096VVR4REhJdmxtMGFNdjJ5MElNTC9NMWgvTU02dWNtaFpFVUJR?=
 =?utf-8?B?aCtJbmkrMGZZQ3Vrb0ZtdmRKNFZPMVYzMUFoQ0cyQXc3Q2hBMTdNcWtVRTFB?=
 =?utf-8?B?alRmR3NQb0Y1eno0UndjclluZC8yVXVlR1ZwUGhjTDNiZjVMWk5nM0NQT0Rw?=
 =?utf-8?B?Y2l5NkdCSVI2cFd3ek51T2I2VWFndE51WjdyWU5iVVJwTXg4RTlxbG5oY3dN?=
 =?utf-8?B?dEtJbC9EVDZhbkYvWTZEVXVKenJTeDJBZmJ6eGJJaFVlazBmbmRCRTlEWk5I?=
 =?utf-8?B?ZnNsTHJwZFg2RStJbzRYNTl3bXVydXBKRmpNOHVIb0ZSc1VKdEFNMmFDd2FK?=
 =?utf-8?B?amlJNWxxa2NUN1o2dTVRUVlUazA1NEpxUnZrTnBpWkJCby8yOGQzNFJLOU5P?=
 =?utf-8?B?Y2pNamJ2WS8yS2UyR2Nqd1FaQk5LaVJJSzdmbUJQbktRcncvVEpSTFJDUXZD?=
 =?utf-8?B?SHRSWE8vNTlHZDdxcnJlNGtNd2ljcXJxRFlFbWJIWHQ0djU4bGVKdy80T3Y1?=
 =?utf-8?B?dTFwOUxONm5Gd3RzbDRBRFJNNlpyY2t2MXNuUWo2eXlNbytxWHFzckRzOGR3?=
 =?utf-8?B?QmhyZ0liUGUxUUlKKzNQS3ppQ2tBWXRFYmJFWFVVQkg5VHRaTnA3bTRITFFJ?=
 =?utf-8?B?SWo3NTNXaXN6QlQ0Wm5wYmRLckpXMTRmclNWOVZTVzlLdzF2ems0NnRCK0pL?=
 =?utf-8?B?dktteE41N1BBZUZmMHZjVTVVeDJ0VE5XWWt3aFdqUXB5NUtBRHBQNnNQeXY5?=
 =?utf-8?B?QldFNnlYbXlwV1dROXk1QWxGbFRyMkZwVlp0dlU5Slp1enNDa3dpd1FJWlVN?=
 =?utf-8?Q?qzCJIi?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:20:47.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a187dd9a-1bdd-4446-1b9e-08ddf5f5657d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9254
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/iF0vQFtHLeI 5NTZ+nyv9LFHwdTLN0zpgkf2w0Ihku5tPAXUs3YWGYL9LwTe3bA0NQeahYUtpAKnd7BRotCFGMU 5I+O6gMvymi8NdZXrmE+MT0zIGkLcaDnISSUrNw7kHC9wBm48DyTAnogwa3bU3HQgOa1LfxpfrF
 JDPuglkRKhB33syEOd40/4mEKyG+XtGuD/UPjGGVNgnn5o319L58/6+O2aOHdkUir3CK2H+Z2fE yPF+z3yfV23hiXrcUYVYwEpr5oGqva6uE0FlRLORWC+BARo+BoubrB+9Fz81fBk8SjmvQjo2ahT Avp1H5Qq/taIY3wAjWk2BvyDlDxR8GqImdZh42DSB6vT+QzXUMIaJ+jd6NizSenW+g/gKvA4Bv4 HpLL2JF3
X-Proofpoint-ORIG-GUID: kxZtXdqFilDc6Lm_9nLKaXdFnWvOFzhT
X-Authority-Analysis: v=2.4 cv=aJLwqa9m c=1 sm=1 tr=0 ts=68cac3c4 cx=c_pps a=jAp52Qr6e1vdGvI99yDuOQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=tmmfVvVmf_gA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=tbB4qTXv7ZqPBi31GnQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kxZtXdqFilDc6Lm_9nLKaXdFnWvOFzhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Hi Kuninori,

On 9/17/25 02:32, Kuninori Morimoto wrote:
> 
> Hi Olivier
> 
> Thank you for your feedback
> 
>> Here is feedback regarding commit 5725bce709db1c001140d79398581e067e28c031
>> ASoC: simple-card-utils: Unify clock direction by clk_direction
> (snip)
>> To accommodate the change introduced by this commit, I added the property
>> "system-clock-direction-out" in the SAI device tree node.
> (snip)
>> * Before the change:
>> - Initialization:
>> simple_init_dai() -> set_sysclk(id=0, freq=sai_ck freq, dir=out)
>> 	Calls clk_set_rate_exclusive()
>> simple_util_shutdown() -> set_sysclk(id=0, freq=0, dir=out)
>> 	Calls clk_rate_exclusive_put() (releases the mclk clock)
> 
> Here, about "Before the change". Does this "change" mean "before adding
> system-clock-direction-out" or "before commit 5725bce709db1..." ?
> 

Oh yes, I mean both in fact. Namely, before having the commit and the 
system-clock-direction-out property. Typically, I tested on a v6.10 and 
on a v6.17 (or later) where I noticed a change in the SAI driver behavior.

>> * After the change:
>> - Initialization:
>> simple_init_dai() -> set_sysclk(id=0, freq=sai_ck freq, dir=out)
>> 	Calls clk_set_rate_exclusive()
>> simple_util_shutdown() -> set_sysclk(id=0, freq=0, dir=in)
>> 	clk_rate_exclusive_put() NOT called (mclk clock is not released)
> 
> Hmm...
> If it was latest kernel, and if you added "system-clock-direction-out" in DT,
> dir should be "out" in my understanding. dir=in means it doesn't have
> "system-clock-direction-out".
> 
> And, dir will not be changed (out/in) in init / shutdown.
> Are these same DAI ? Both "struct snd_soc_dai" and "struct simple_util_dai"
> have "*name". Could you please double-check it ?
> 

I did supplementary checks, keeping only one DAI and adding additional 
traces. It seems I reached a wrong conclusion regarding the cause of 
unbalanced calls. Sorry for the confusion.
Looking at the traces (see below), initially, we had one call with the 
'in' direction (kernel clock frequency) and one call with the 'out' 
direction.
Now, both calls have the 'out' direction when the property 
'system-clock-direction-out' is set. This seems more consistent with the 
changes from commit 5725bce709db1.
In my setup, the kernel clock is an input clock. Maybe it should be 
tagged as an input clock. However, we have no 
'system-clock-direction-in' property yet.
Anyway, the patch in the STM32 SAI driver is still valid.

v6.10

simple_init_dai - dai: 0x110b6418, dai name: cs42l51-hifi,
simple_init_dai - dai: 0x6204899f, dai name: 4400b004.audio-controller,
stm32_sai_set_sysclk - dai: 0x6204899f, dai name: 
4400b004.audio-controller, id: 0, freq: 29700000, dir: 0
stm32_sai_set_sysclk - dai: 0x6204899f, dai name: 
4400b004.audio-controller, id: 0, freq: 12288000, dir: 1
stm32_sai_set_sysclk - dai: 0x6204899f, [set_rate] current freq: 0, 
request freq: 12288000
simple_util_shutdown - dai: 0x6204899f, dai name: 
4400b004.audio-controller, dir: 0
stm32_sai_set_sysclk - dai: 0x6204899f, dai name: 
4400b004.audio-controller, id: 0, freq: 0, dir: 1
stm32_sai_set_sysclk - dai: 0x6204899f, [put_rate]

v6.17

simple_init_dai - dai: 0xbca889eb, dai name: cs42l51-hifi,
simple_init_dai - dai: 0x4c0382ed, dai name: 4400b004.audio-controller,
stm32_sai_set_sysclk - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, id: 0, freq: 29700000, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, [set_rate] current freq: 0, 
request freq: 29700000
stm32_sai_set_sysclk - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, id: 0, freq: 12288000, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, [set_rate] current freq: 
24573875, request freq: 12288000
stm32_sai_set_sysclk - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, id: 0, freq: 12288000, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, [set_rate] current freq: 
24573875, request freq: 12288000
stm32_sai_set_sysclk - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, id: 0, freq: 12288000, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, [set_rate] current freq: 
24573875, request freq: 12288000
stm32_sai_set_sysclk - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, id: 0, freq: 12288000, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, [set_rate] current freq: 
24573875, request freq: 12288000
simple_util_shutdown - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, dai name: 
4400b004.audio-controller, id: 0, freq: 0, dir: 1
stm32_sai_set_sysclk - dai: 0x4c0382ed, [put_rate]

I hope this can be helpful.

Thanks and Best regards
Olivier

> Thank you for your help !!
> 
> Best regards
> ---
> Kuninori Morimoto

