Return-Path: <linux-kernel+bounces-873641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A4C14524
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B1645086D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70301F4C8E;
	Tue, 28 Oct 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZlEbl4hl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AiAyBMQC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1F2747B;
	Tue, 28 Oct 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650123; cv=fail; b=r9HMECuyATnea7pz1lHwJnMY1rjwkqfoh+cjyvo+He+GJATz1Q6/85Mrab2Fb2NXXw9fWpiE5rWQjcr0vI0BuI3SA5DFa00p+ibr9FGG3h48Nv9BfCmeLxes6udJfy+XbsEOjvx/oz59auwDZI9ZEjOVshm8flkL+zifsKNRd+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650123; c=relaxed/simple;
	bh=TGnVao6VflRpyDKLIqXf8OltSacwHnno5YGwbs+VOoU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6a6y3NBLmUmmGPiwV2G4478IC9csJXNBIx5NCCPM3AKHDKpagtOACAFM3or+HtQJUmDWmMYuPJaAzNf+sVRHjY7dVpbe8XZDDuyic3uZn3LBehtPL1XOV6j6veFOy+1R/30mAh21F2bUz6/ODUZSIsKNh61CHBmm6WyF8PTGnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZlEbl4hl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AiAyBMQC; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SA9mmm3329031;
	Tue, 28 Oct 2025 06:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=TGnVao6VflRpyDKLIqXf8OltSacwHnno5YGwbs+VOoU=; b=
	ZlEbl4hlPceQcd4TEQeMH8NF1p16OsNoQHmg2EDkIdstnx6dR62uTyFYQjqLdw9b
	8gy1C4+6ovHEvJB3NqlK1mEHMXZwFslMpybmvG+7P4uiozNrPQqbbTDPa8ize/Jc
	2cxi4f2llMO68XSuaIeKMFL+fYCsWaPmqbDyvxhQ1QrKwa/v7rhsbFok0xnXSsLi
	/hFXiWSOhSuRNUmQj9yAxmmvw9uex9xXZ2zpbr61aghMlvANFQukGIsF9RzHwO4a
	aBQrH2Nr91/9+/tpmuKkgS/mgDLvwAHIkc21+aImony+EbqdX6+ytYq8G9isACUz
	yy0eRjocfSEemH1Lh10HaA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020082.outbound.protection.outlook.com [52.101.193.82])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a0tyjkc1f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 06:15:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGb2I/j45MeNAIIRvE1b5SFvSJbz41jz8oy76+WZWTCrMDmxNFlrCzpizBTsfHMsjM10BZ5AEuOgqxfrsc4y5ECDk9Sv2BTBPWR/kD0opPVAMYhWTYhjXsZT4dEddA+6f3qua0S93qpstUj2d59qOzwb7rHalN6J1MD5tTQ2hV9qz9ak3XlBotDVAqzgbCWNIQPp2jOcdkELYQWrBy2OqoqfB21vAT+OQm+z+yYVWWkPGrzeRboEcg4gbBigWwxgtYklpAE3o8NbBGPs1Y6tULrBgjJUbFexfWOXJrmZmwONymSSHN72R/HBNLnxPR/sRBXTxtdSzB4xO6JIGx4qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGnVao6VflRpyDKLIqXf8OltSacwHnno5YGwbs+VOoU=;
 b=toNw4iWQH6/cxxxKEWW5YdOaTT2/Mey8VLH9FKmL+YVIGdb/dnS44RBM1DX2pCkomlCJGQH/ucwYzLo2FGghFB4V6GvdMGlC17sfbrN0qcKvHuwspFYljBnqkh8JgBsJOUgIawDbKy0hV9JP3IDfgrw3kzgfLxWU6MUV/vmYGeFNphOVbhtR7/O/G3aAiwvT/WFCmqu+DAiLE0FD588FGdri0UiTI7VDPytxCfCymIN7IvZUSCpz34YPqFvPjEELnTi5Mrt7Tknwr2XB8WOjJFrI//t6dNPs0j5qUPI2Wn+JI1/uvfehN5V+rnP8zEwcUkmMHj6T8AX1aegT/jSxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGnVao6VflRpyDKLIqXf8OltSacwHnno5YGwbs+VOoU=;
 b=AiAyBMQCr0Qe/long0Rt+D5G298OZJhyDdeFXjnkon9NFfcregfn7t880f0Rd5F5Iw7gxwX/hlWr0NubazDA+FeKZ7jHLTbIxnwlKQanJnAz7UPs0xQ7big+KDQYVdQg0U3mQu6zxnC3Ze51facbbDkM3QmsAJif4EZ7P89EPZ8=
Received: from BLAPR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:335::12)
 by SJ1PR19MB6236.namprd19.prod.outlook.com (2603:10b6:a03:459::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 11:15:00 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::92) by BLAPR05CA0031.outlook.office365.com
 (2603:10b6:208:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 11:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Tue, 28 Oct 2025 11:14:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6A3CE406547;
	Tue, 28 Oct 2025 11:14:57 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4A92E820257;
	Tue, 28 Oct 2025 11:14:57 +0000 (UTC)
Message-ID: <f6596d39f91115567741add153eec5c476a85656.camel@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: sound: Increase max size of components field
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2025 11:14:57 +0000
In-Reply-To: <20251028004252.GA553484@workstation.local>
References: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
	 <318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz>
	 <87ikg03ecf.wl-tiwai@suse.de>
	 <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
	 <20251028004252.GA553484@workstation.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ1PR19MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ffe38a-37a9-4287-6499-08de16133b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnVPQkV3djcwSWFzT1RIY3BiZForc3N0Y1VHWmF5OStvdmRmenM1Yzk2Q1hF?=
 =?utf-8?B?UlVyelZ3QUZNSWd5ZE56dkpFanhvMmtOV2JKaDhWYUxEYTh0YlAyMVNxcE85?=
 =?utf-8?B?NGFwSEJLMjdnZjRySWtUU0dhMmVQUXl6TkV1RFFyMEpRNDdveENsa1A0a1VR?=
 =?utf-8?B?cDBQY2Q5d3dkZnV2ZzA2NmFOeHdmVjAvdUk5b2MvNzYxb0JkVDdoVjhJOUVk?=
 =?utf-8?B?bzF1enUxS0FmaUhiK0tnZkJ6VFRta0xZcHFXYUhPYVRYbW16UHZNUGZUeDVn?=
 =?utf-8?B?eWlOeTM2aTEzSUxqNjd4d0xvL3dmZ3BFS2d5MHJIbXBtNGhYbVJEbWNWN0pu?=
 =?utf-8?B?NjBHVUtEc1dzZ1piS1A2VFBrRWhyWU51Y1JGK292SGV2V2NFY2FrZWxUWSth?=
 =?utf-8?B?VDNrdmlaV0V0bUgydkgvaDl4WUNGcmU4STZnVVVydS9zNmlFNmpMeDhMOW8x?=
 =?utf-8?B?emlkOUlQYjJjVmJUVk01RGU5RUF4NUo5WkhFdHJ0L1I0QXpNRERRL01qcDRZ?=
 =?utf-8?B?SGEzMTV2c1RJdm92b1VlRVVKdzAvUXlENkE4N2ZhRityMGYvWnJ4bkRPYzN1?=
 =?utf-8?B?RHUzd2ZpamljMHJyYXBQakxzbmowaXNWYUdRdmdqdkl0bkw4T29QVlIwclVt?=
 =?utf-8?B?UlBRcFh4WnVTL0gzMmVqU0VWMGZvZmdGWC9uMnFjcmx1M3NPMTN1VnZRaWhX?=
 =?utf-8?B?alU1NVZkcGdPb2I1cDJ5c2M2NXkwTnRyRVdYR3V6V015OHN6d3E5K28xUyt0?=
 =?utf-8?B?ZjhGZHdLdFEyb3NOZHpJcEd4ZnBmdUtOS2d2b3RybTFZK1pTNktMRkZ3R1d3?=
 =?utf-8?B?T1F1R2ZMRXc1ZzYzZ1VJMzJSVlpmU00xYmRoQzRtaXFZbytHdE01eVhuRFpa?=
 =?utf-8?B?YkI1WllnQ2s5eXdwZW9YWDNITDNXVkFZRE9DMU5BV0dBU2NoS1RLNWQzaVJC?=
 =?utf-8?B?WEFGUTJhWXN6bjRWR3dPbG5FNDY0aDlWZ3Q2Y0NzODR4RUh2ak9ORjF1cTBv?=
 =?utf-8?B?OC9yakJ1dUhSaGprY2tpOEtoNkRiT2FzSkJLQlZRY21MYUgzMFJ5NDBGOVdN?=
 =?utf-8?B?RDZSYTRmNWNPekVEbmlGa0lqd3M4SEVvUzB3Z3pqRE45ZlRIU1loMWRDR09S?=
 =?utf-8?B?VFBUYko3dndRbzJ3bmY2cmMxUFFSdFNCY0Q4bmt6cHZkeHZjMGJPUVZZRnpo?=
 =?utf-8?B?YzVHNlpPVnZ4aUhtRGtrUzNvQkZEU2lMSmVWY3hQMVovdVpnazdxYlRoWk1V?=
 =?utf-8?B?eWlGbURWWnk0bTQxVk92T2pHSTB0Zk1CWmZlRGoxMXNmeGN2NmNhdEliL0RT?=
 =?utf-8?B?QWtJQitjeHJPZ01zdEVKcDVCUHBqN1hiazREQnA5NWpycFByTHduNG1IVEd5?=
 =?utf-8?B?K1FCVzR5bXUxQVJrUkhaaXNHVUUvNkZPNXFzNmVwbUhnYnlwc1NKcGFTTWxB?=
 =?utf-8?B?K056d1k4YjFUR2pFWkFXdVo2TzE4UnRVSjFTWnNVN2c5eTVxVGNLS3lWVnI2?=
 =?utf-8?B?S2E1ZVhGOFRUNnJHdG9ycisrMzRyanZuMkQ0MEhZZklNUm1LTmR2UUZlS0Vp?=
 =?utf-8?B?Q3NqTkhhdUxrUERTQmpSVUpuYzVsR2l4dTk2NktQc0FLM3lkVks0L0k5ZWFB?=
 =?utf-8?B?TWNQeFdkeUw5QWpiaEJLQnBRS1pFcHAxWDNtT0F3RnNtWDduNEpQWStkeTF5?=
 =?utf-8?B?U3VFS0ZxNDJDNzFqSmpvMGlJUkNpY0hleFFqVnhpQmZKV0cyaXhaQjhUb2tW?=
 =?utf-8?B?N3FNZkJmTllzck1oVjRhdGpNblBOcUNxb29vd0ZQbW12T3czZGI1RUZDOXhC?=
 =?utf-8?B?aCtkVXI1d09NYlp0WTRxaVdhMkFxNzlnNUtHamVkc0h2RXdXRG4vcXBjdWNa?=
 =?utf-8?B?MnJqRjJUZ2VFTUtFME1jdkh4MGJoZEFtNzJJNGx0RVpoSTk1WWRTanFsNXc1?=
 =?utf-8?B?MEJoR0RRRWZ1ZlVwcWtLRXMvUElSRXJsWndxRWtSSXBPQ1p2cXNLMTMvR2l1?=
 =?utf-8?B?dnMyaVo1aThpeDFzbG9EMy8xcFR5QUhIanFPcURBelA0ck51UVczZlRONkhC?=
 =?utf-8?B?allTUGFudGRIcFJNUW1IRzRxR0FCZlo2aFNHNWFsS0VoaHpXaTE5OWRCVTlZ?=
 =?utf-8?Q?QD8o=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:14:58.6046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ffe38a-37a9-4287-6499-08de16133b4a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6236
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5NSBTYWx0ZWRfX45PmuQY9jHhd
 4WZz6afxdd75yoKYCMtUhpt8cWFJfAH4mINsBaMEtBNlGvdoWVe904Lci1Ya4aGhQa0ma/qiLwA
 qHyDhsWy4guwnePmdkw6tvoUByfpq6kaW7VvdY9+SI9F5dz3X7G682R/2LD8s75GfdW9dMkscvf
 odB+Z77+JjjKpg6YDNUheS2hxxbr3Myew/yBkgcpGXNb+CzC657zqblq9G7dX2d17OjgWpLnz5K
 53/xeqAEi2IUNOcWiK5bqoya8rYGCvwSMdFvenrIGFkM6oMRCrZg6KAfJXdsAxW406JXfwtjByo
 bdJ9eXzLxMq1/H13QJB5yPf5JrRNXMjWC8hp6lNSK4C9s7I3ySOwsJsWylrA+wpmCrsizn/6xnu
 qe5nJHG2BWXMIgQ6v+rQKg84gedG1Q==
X-Proofpoint-ORIG-GUID: PzN-7Wpaw0pRCh4kwrMt8mc3hqDLJr98
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=6900a5b7 cx=c_pps
 a=92tcjHkeFWwqBtvuWrn0pg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=McPsLfZPzHhC0Iwj1_YA:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: PzN-7Wpaw0pRCh4kwrMt8mc3hqDLJr98
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu wto, 28.10.2025 o=C2=A0godzinie 09=E2=88=B642=E2=80=89+0900, u=
=C5=BCytkownik Takashi
Sakamoto napisa=C5=82:
> Hi,
>=20
> On Mon, Oct 27, 2025 at 11:50:32AM +0000, Maciej Strozek wrote:
> > diff --git a/include/uapi/sound/asound.h
> > b/include/uapi/sound/asound.h
> > index c302698fb685..7d53f6da59e2 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -1069,7 +1069,12 @@ struct snd_ctl_card_info {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char longname[80];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char reserved_[16];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char mixername[80];
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char components[256];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char components[128];
> > +};
>=20
> Any approach to change the result of 'sizeof(struct
> snd_ctl_card_info)'
> breaks ABI to userspace application. This is the reason that Jaroslav
> addresses to the new PCM ioctl command. Unless, the userspace
> application build with the UAPI header provided by the existing
> version
> of Linux kernel does not work as expected in your version of Linux
> kernel, in respect to the sound subsystem.
>=20
Apologies for the confusion, the draft was based on the initial patch
that increased the size of the components, so this snippet is actually
bringing back the original size. This will not be present in V2.

>=20
> Regards
>=20
> Takashi Sakamoto

--=20
Regards,
Maciej

