Return-Path: <linux-kernel+bounces-871549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31637C0DA20
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF9534FCD12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75211310777;
	Mon, 27 Oct 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="n/RIseHU";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="MXXf/osI"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7B30E83B;
	Mon, 27 Oct 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568352; cv=fail; b=DylWvQaz1LM5HwUrI+qhxVYKH/S9okWMCA5ZN+UM2MpNrOgHQwOvIMqo3vFM3lIZJzI2wzFEOA5UtGY51RH+xEKTHr4t0osFMWbWMuwLPW6H8sMPIPjTE+vqEKFe3R4/LBVA7fVcmcOQN64bTpsr9yuRuaBI4CBwdTL36NXYe7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568352; c=relaxed/simple;
	bh=Lm+jLBY7XhL8GZijJG/ioJF+M5pGvGvz29pnEcCQyk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4Kgd/tGAu53RTve0r685I0cHQzfmpMf1K34ghoMc9jGchPZ7pBsvKyoKN1ppfemHefHIAI8aXTYIWVYzbCe56CYI0JM7lCLUCOOLK/AfNT6bkxqHPg9ncX6lKmA7w7EtE0VvQ0J/FqCbi/r5zhlK4weLTJ/1HAtgSpw4eLt6vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=n/RIseHU; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=MXXf/osI; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R3oE9X313076;
	Mon, 27 Oct 2025 07:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=5vBZWUHIpiCZUuXV2t4qX0u1Yp5M7FTxUVksntIVHzs=; b=
	n/RIseHUDndAOsdNy6ahKaSjlptP5OuipmWGn6QTeJkfV47Tkv4P3Fjh324FNpV1
	mguNuPr7G9H+K80Zp3RlqVhi2Qn1bHXuX1xAWW+vAyUExWmD23/R6Bm9Il40i1qS
	VNercjY6ZkxOIUdsAP1OMGSncQOyeSqBLmUhp7iGm1djwC6vUuLjgF5Up0VFhg1e
	m1kUzEfiEEGApCWGXrw2Sc4rIQASD1nqd47yw3d1PwlogNpTPmqVVDkO/PTSIz7o
	bCacQuhBPmeTjWa6+A1SmIuGoHBJghYWedCRwIVr8/p3uSA3nCSJyE52L4U/q5yr
	HfLjbrSx+lVv5xzPCUnl0g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020086.outbound.protection.outlook.com [40.93.198.86])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a0tyjhy1n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 07:32:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPoP9p7wzTFoFcF2kf4JspOt7EhQrgVTvH8YEGBrnyGSCGpDcCES8T75nZJ2EJwkTFaJ43IwVGMQg3uYiexxI7Py7kWAW6tj9ZKk5RQvYKwzk3Qp3hG9lBAQr45SpJnqmIIG6GPTYUHJe2uRKF0tuw93PFXI+HPZTrbbc/zvqHn07GJJKw3zDE71ER34cb8k5pkrbSUMX8dHu/VP4ziQWJAiV9akVYmzqsvk+X+KiTfh499nK6KRHOgK7zmf3VLzFinIav47orViDq2RLcBTiWsC24TTsATRgJtooieztb+rmRQehIC/8CXS6dsik8DCh1TrzKvbXYUwz8mUOLlVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vBZWUHIpiCZUuXV2t4qX0u1Yp5M7FTxUVksntIVHzs=;
 b=kisHIz3S5BDqj4gu5ucja6+i+bgyofyzNi1cyo+C42Dt5e3ZTBmON0CSwpw3xg/U5p1QnBb5mpRU5zFEQZPdaF/Xr7815irt0lVsQZxtCgHvSSDZxOaVK+mMnhjDmxPJ0x8T3ReHZFD1YJQorwPikPoEgzMDSDvz0hT4py/GUeK38ihJvO0UBhe6INm/OzvQlwH607MUuwa1MYtwRnjVTBN2f1/Gd/9adpJcY3YhB54TKQm6wwm+R2uiU6Bwr+AsuHFIMvL4SouE/OPJ2E1BeI7zWxlYUpC4vVBJuZUmsMODB6Cglx1g7LBd9FIYS7FUmrBwisCGkGZqCxoetRPLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vBZWUHIpiCZUuXV2t4qX0u1Yp5M7FTxUVksntIVHzs=;
 b=MXXf/osIKsvn5WL+79vVMvt1iwfX1CuCgfJrrLCDsg+tiL7il/e+S2qte5VfJwE5dQTXj5NZDAdK+L2FYID+Aci7P3BOdmxln56kK1aXKukjUbWvdUfitbYLinjAQQRJekDFNvaZECeUflyp4BEeHxW11blsNHfEJZUd9503SSM=
Received: from CH2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:20::15)
 by SJ0PR19MB4477.namprd19.prod.outlook.com (2603:10b6:a03:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 12:32:06 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::d0) by CH2PR07CA0002.outlook.office365.com
 (2603:10b6:610:20::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 12:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Mon, 27 Oct 2025 12:32:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6DDCF406547;
	Mon, 27 Oct 2025 12:32:03 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 564E6820244;
	Mon, 27 Oct 2025 12:32:03 +0000 (UTC)
Message-ID: <642d872a-fdb0-45b0-a8a4-84df6422d1d0@opensource.cirrus.com>
Date: Mon, 27 Oct 2025 12:32:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: sound: Increase max size of components field
To: Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
 <318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz> <87ikg03ecf.wl-tiwai@suse.de>
 <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SJ0PR19MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f46a168-421c-4118-f65f-08de1554d607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFZaZFplUncrMmV6T25nRVNaNVBRVWU1QnR5OHdaSTFRVEl1N05LVWtXaWR2?=
 =?utf-8?B?Y09LUTB2ZGsySExuZCsyL0NmT2U4UkIzNUlBS2IvL2lodURyYjFYdkc0RUlu?=
 =?utf-8?B?MXMxcHhZK2ZFTnk3enBYZktpZVQreDB3M1lBUFg5V2s0TEwycGorY2tUSWRW?=
 =?utf-8?B?cjYvcmlKTDJMbXZraUYvdmV6ZkpFZFpJMitabUdTa3ZUeVpmU2pkWjYwRWNW?=
 =?utf-8?B?cjNIMFNxZUllOFJjNWRIc092VFRuSklXRXc5dTVtR1Z0eFc5L1ArdkRrenkx?=
 =?utf-8?B?TUcxR0JIZWdiZHczbmtmSkZrV3BrNllJTVNBK3J3T3dhL3hDT2JaQ2NXTld6?=
 =?utf-8?B?SVRXT09HcThZU3l0THlHazBKVkpmajdpWCtxc1dEK3pBSEhyZGZ1Zk9VVXJK?=
 =?utf-8?B?SUNkT0tHODB2dVl4eENTcnZJSTU4VmxndWJQMTNkeWZPY2pWOTJTdUt0SjYw?=
 =?utf-8?B?amFTOEFWVktXaWlDa3Ircll6L2cvUXpUVlFxQmMwNTRKSCs2Z3lIQTVnMFJn?=
 =?utf-8?B?UEswdllERGh4MVJ5SWtMMWhtaCtVd3diVnNHVllaUXRKY3Zhb0ZXeVhwUUZv?=
 =?utf-8?B?LzdMMi9weTZXK1g5Y0gzWFJjSDZISWIrNG9TNm8vTm5nSlRvZnIvaGZkZ2p4?=
 =?utf-8?B?RFdTRWVtUGNETnd0dFc2bHp4a2s1eWkxbVBHU3VxZk04TmdhSDhFREUzS09z?=
 =?utf-8?B?d28vL0FsUCtoNmpMcTd2TE9Ia3MyZXZMVmE0WWFhd0pKQi9GQ3Zra05UV096?=
 =?utf-8?B?RDZrTndTSnNJZ1B0YWZwMVFabHhjdGNPd25kKy8rRlg4THdQbXZwWmJ0Mzgz?=
 =?utf-8?B?akd2b3ZaVWpZN0RDT1gxOFAzK1RZTzl1RklMaUtaL28rTGk3TUtRWVJmT1p2?=
 =?utf-8?B?dHdEQXVBRmlpbWc5dmRrblN1Y05rcHRoTll5eGgwMjNYQmcxRE1QNlAySDNW?=
 =?utf-8?B?djFUM3B1NzlUWW5ZQzFIdTR1VzFiV0c0VDVpcmRQZ2diTFBXTXdYMjBXTUk0?=
 =?utf-8?B?TDBJaG9ZQmZKa1V4V0o3aGNMMWk4dkQ5UXJ1RTU5K2VyU3VmMnp4U2djbTdF?=
 =?utf-8?B?enhxOTJsT2E2eUtGeHY1aWsyenVtNElKb3JoN2ZGTFdQZ1VIM1Vtd1l1dXZS?=
 =?utf-8?B?NUxmc2M4RGpNQUxBeXFoS0VoUEhxOW95Skwrbm1aNndlQ2VGVHRTcXFCVURM?=
 =?utf-8?B?NE1SR0IvQm5Mb2dXWFhKM2JYTitvZldUWHdNMi9lWWZJUUQxbEpiL3FkOFJT?=
 =?utf-8?B?ZEk4Mld4aXhWYkZ3cmlMN212QXo1T2Z2ZWhNVVpkS1NBWkFtRGJPMHQ4dmQ2?=
 =?utf-8?B?M2JDS0hjTTNRUFd1U2M2T21oQnlGTG10TTRUL3Y2Tkt3RGRDdjJPS2JlSUpN?=
 =?utf-8?B?NGVyVGpGamRRWnY0QWhtN1BqYWFqOWhYV0puMFh2RXlpZFFwaXlOOFRHdG5R?=
 =?utf-8?B?WVUweWVNbW1Gc0d4QWtnd3dPTExIN3VFc3VpQitmaHFOSDFMbmU4S1RSV1My?=
 =?utf-8?B?U1RHcU50MHJoZ0ZkNXpyM0hDVGtuTjJWeXFleVB1WVdRTzBJeTNFaFc0YUw5?=
 =?utf-8?B?aGJDeGovMm5lQ3A2OHdKRllicjdTTlZmeTJ6T0hhWVI0TG93cEZHeVU3S3JF?=
 =?utf-8?B?OEhEQUtjTnp4RVJqT2hQckdQSnNKbFExdHFQOWFCRzQxZEdJTldZalhKV2Zn?=
 =?utf-8?B?WG9qZHVXMnJuaitGcWxKMlhnSGxkd09SSW9CaFNpRmNtOU5hWFp3amZncmlX?=
 =?utf-8?B?bDlhZDg2K1h0YVM4ZXE5MENVWEZTWTBGaHNGN3M1VUJMTkNKaGpxek02M0p1?=
 =?utf-8?B?OTVCZHBrL3FtMUJibkxUbjFzNkttSmdhVjZBV09oSVdBMVpKVGNSVWpiYnFG?=
 =?utf-8?B?TGxOSEpoRWM5dlBFM1NxWENSTEQ5RmNHUk1PRjZlNFg0bFFjTjhXbkZPR2p2?=
 =?utf-8?B?ZXFuTlZIOFRWUEloQlA4UmhabFFaMEEwRmF2K2VtOGVTZnlvYUxCVXN6OXlx?=
 =?utf-8?B?cCtxN2R4OWo3Nkdjdi8zamgySVh6QVdkWGlQQ0FnOHBDRW95cXo0di9EUGg5?=
 =?utf-8?B?bW90TTFSQlBXWituUE93dTkvcmQvbEl2L0ViSi9UdWx1S2tzaEMvNHpLak5w?=
 =?utf-8?Q?6BWM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:32:04.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f46a168-421c-4118-f65f-08de1554d607
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4477
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNyBTYWx0ZWRfX02o0ntoGfPug
 O1lp8+Cd/O/xTi+WHOI+3hFBIlyys8NxQsOOXKHPP3Z9DuuiiJLqoOgN+F+a4yzhjy6YZCDyQ4x
 89LbhVYYmrtpP2gPJUWVMu4IYtURyvqGc/f934NIXdB2Sj9e+qEpy5nFrwryP21bC3+ID9U9XcJ
 uedolLXMNUP7ct++69MlnYyZMc01TjitqK+jvUNYRi7zxGdqhzZ8ASvEcDNUjGKAgyjj/iIfMAe
 wjoynik8SGfstxgFyLJiVXldb8oa+Zo6j3RFxNVu4M1cFJpkxKkg2zFq2ZZTnjbd/D5Ipon5ecM
 yg31Pvr0DF370QXqN2G2yWtjje+iQm7aqDxQ6YYKNujpScfiRcjlUIQT69/foytu8xZqExaTYWu
 Y6nNyaDqSzHRavxsrVKf4DmOVKS9DQ==
X-Proofpoint-ORIG-GUID: U5ALZqo3oEHDsCzn3NpE9tmDasEL7S6q
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=68ff6649 cx=c_pps
 a=lEAsXE5stpqivpVhnk0CUA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=sMd2wrY86-rG4vJogY8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: U5ALZqo3oEHDsCzn3NpE9tmDasEL7S6q
X-Proofpoint-Spam-Reason: safe

On 27/10/2025 11:50 am, Maciej Strozek wrote:
> W dniu pon, 27.10.2025 o godzinie 10∶04 +0100, użytkownik Takashi Iwai
> napisał:
>> On Thu, 23 Oct 2025 13:56:26 +0200,
>> Jaroslav Kysela wrote:
>>>
>>> Or, we may introduce a separate ioctl for the components string.
>>> The
>>> stripped components string in struct snd_ctl_card_info may have a
>>> special ASCII mark like '>' at the end of string specifying the
>>> availability of the complete string through another ioctl. I would
>>> prefer this solution.
>>>
>>> Also, the components string may be dynamic in the kernel structure
>>> (pointer) to save some space. 256 bytes is not small number.
>>
>> As Jaroslav suggested, we need a different solution to keep the
>> compatibility.
>>
>> My gut feeling is for the option to provide a new ioctl as it can be
>> most straightforward, but we can discuss further which is the good
>> choice.
>>
> 
> Thank you for the advice! Not sure if I understand Jaroslav's new ioctl
> approach properly, can you have a look at the quick draft below and say
> if this is (more or less) what you would expect? If it is OK then I
> will prepare a proper V2 patch here with a corresponding change for
> alsa-lib repo too.
> 
> 
> diff --git a/include/sound/core.h b/include/sound/core.h
> index 0eb2e3ee0dd5..c4e52fb1704b 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -88,7 +88,9 @@ struct snd_card {
>          char irq_descr[32];             /* Interrupt description */
>          char mixername[80];             /* mixer name */
>          char components[256];           /* card components delimited
> with
> -                                                               space
> */
> +                                                       space */
> +       char *components_pointer;       /* full components string */
> +       size_t components_pointer_len;  /* length of full components
> string */

You don't need components_pointer_len because you can mandate that
components_pointer must point to a NUL-terminated string.

I expect the new ioctl should require the caller to provide a pointer to
a buffer into which the string will be copied, and the length of that
buffer. It would return an error if the provided buffer is not long
enough to copy the content of components_pointer. Usual protocol is
that it can pass a NULL buffer pointer to retrieve the length of the
string so it knows how big a buffer to allocate.

I assume the ideal API would be that the new ioctl will return the
contents of the old components[] string if there isn't a new
components_pointer string. So if the kernel and user code both support
the new ioctl the user code only needs to call that new ioctl.


