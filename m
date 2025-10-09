Return-Path: <linux-kernel+bounces-846529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00D7BC840D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714FE3E04FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5728CF42;
	Thu,  9 Oct 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kgkz8j2I";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nbXFRUOO"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AC212568;
	Thu,  9 Oct 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001499; cv=fail; b=dEAGEdgUd8TdqZUwZd7csnz9/0yrxdB43gQW0isjiZFp/CSlf9HpnANIGCRCQjeMIbsP256eoswm3bb237hWI3Dln3jbPYYfaWZlU78ksOQDRVCXiMLzgrtCwfSASt0RY2oE25onuAEMLt2zFfFppkjsQvKUHe/L1YJfQgbLowM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001499; c=relaxed/simple;
	bh=ELX9LC3qDteeox7s4oxoBq69cNoWErRImYy3e23AbEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e84tRKndezjPEXHmSBvNO7BSE7zKie1rWXRDLX7VSRfdB1XAdmdEdZFK3XZUPi/N8pHpeqe3sQ2+4/Si84JOnZpaBvj40sMYVaUEdwqIpBVBJa0J1yBApGDhHlioLM3ejgmKqD6F3a2aVulImN5nCodcv7BxcZDdaYdv6T0EYTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kgkz8j2I; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=nbXFRUOO; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5994xutN2321904;
	Thu, 9 Oct 2025 04:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=I3iL1dlz7W5sCdqZF2
	fwebWcKkxoFHmDNj5iFceG8rY=; b=kgkz8j2Iv7Tj+2nDIpLfcV9Dp506n7eFb1
	wR7q551/QknbON/bBKRKPTv/yi2tPVSUENT2M5eJ2849RX81TxYOkrgJRh6xudhw
	RmSwDVugueKvMLqESXv713RA8eRTYaDpTYbcRw5OvnW6wYwyw5yjso0ER5f9zQSj
	pKZwonefOxcwpxqc7ow8K2rdEd0kSCeMTxV8pqP7C68ju5XQSv4mKr4F1zpbCNWb
	2OFQqVGyQab/Tf3JKMMCmM2VHfEUuZ6ADthZ1kNxq3UwYq5j2zA8+5KxMSyPg2Il
	A8ZyjomU9eNEXKq9zc9vyW2i+7URY+4YO8+lT1oD5aOgchaYbGTQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020073.outbound.protection.outlook.com [40.93.198.73])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49nxqw8hxt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 04:18:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHYHZPOSO6QHu1TWJ59X+pVd5zsQJabDqWLqHtQ3g+x/qpv6bvFNSpocJIqwO35U9KIlzP128aXXNXxeALd5Z6q5qTOjZIFXz2YmXrh6XGL9/Mh2/DBjfXwY6/gFvtQxb52yWj8nI9Y93w4D4QYddhbaEdKecYPIkiCkcr/ozOO82bd8/TPihIWDf1mTegdQTpftEj8i2edQUjUGC9sjKdf4sXTa//QyfFXtd6Of4vc2zUPGpea3oMTW5Ood41PBVJurs++b1bO/pCQdo6EzZmmOa+SeBn9YQMW/akPg9tEIHalOxp+lNH4AlXLCg0V9Jz/ZkaAAYl9u+vad7LEv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3iL1dlz7W5sCdqZF2fwebWcKkxoFHmDNj5iFceG8rY=;
 b=ersmkWDncQOABBbnnBtNjaMEsq7x+Sa4SEgBP/HJCiPuY0QXY5fizojdeCdGQSD+MA6MfC0GpIDmkoeMwy5KUJqGv6CVSetP/B9Nay3QUE+ndJuZ7yYpZxr9k98ekj0oJWG8wiPJXT7u2BWAaF/wnemWnR3+jXvUcbrBZ7AIse6QUXvx5dvnV7wNoRUfLj4r5d9PXDMROpO+Y4Gus863KkhzcgLCNyeJuRQJADkHZDMxNPdxhzLyhFoJcyRdZ681EuDBkMC23pUJcEmnkzDVQc6YoUnACvzNN41kidHAhNJ5QUOuL09nHol0ecx3JERXknMAEv9dwLwa1RPUTNjInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3iL1dlz7W5sCdqZF2fwebWcKkxoFHmDNj5iFceG8rY=;
 b=nbXFRUOOit/igqxw6ZClsz3AfitjVrLHOQLhk9jxpoBec8/IeuiGqe+/9dIvTI5p8o1kZCqxPQoMQk0Yi6CP/SQoEZc/u2tf7teLcbNnJo31d6TcRkE7w5BOsJd3k3KURTDfkAitZsF6Mg/RdOe6R8K4e5y5hXFMVvr+iKKBT5U=
Received: from PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::33)
 by SA1PR19MB7040.namprd19.prod.outlook.com (2603:10b6:806:2bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 09:18:04 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::cf) by PH8P221CA0020.outlook.office365.com
 (2603:10b6:510:2d8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 09:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Thu, 9 Oct 2025 09:18:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 40F63406540;
	Thu,  9 Oct 2025 09:18:02 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2BE26820249;
	Thu,  9 Oct 2025 09:18:02 +0000 (UTC)
Date: Thu, 9 Oct 2025 10:18:01 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Brian Sune <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <aOd9yUj9H4L4fbtc@opensource.cirrus.com>
References: <20251008205207.1781-1-briansune@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008205207.1781-1-briansune@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA1PR19MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b795cf-b2b3-45a3-4c6f-08de0714c05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mehf9tb1atZgYOiPf8IkBOAnxdljpgAZivsktwC6oCE8eAticz/7jRvqYeZx?=
 =?us-ascii?Q?BI3B/mCII4JYYpPC4+jXBBaJxCKBXta+BVry2nwbLU49E22fK/j3x/2A5CwS?=
 =?us-ascii?Q?WgAMMJrvptBRMCDvjZyD+jL8brGDSPO2Av5tDHvECFK7/YzLlJz0ZVowU/mk?=
 =?us-ascii?Q?Zr9qIxiqzaDKgS7qBE2+hO+8a4lX0KQIrk5mfwYpTJT4h/mCzLyy19TMRWt7?=
 =?us-ascii?Q?9ffE3We2xhFkq1pPoYrlxhHcbIvpOd8Wwt0qhVjtpUdqdSnwzyijBIT9m9qW?=
 =?us-ascii?Q?MuwhBWS/wN9yC5sV7vV7C+d4cx0LzZ3vSk5mdvnh/NFIEDR1nm09ZvzSe8uN?=
 =?us-ascii?Q?pWbuZ2JSVHC3W+XIiqN4ZObggLksyhjN5dpz1zS3d79Gt+Nfc2tH3lZsnXyM?=
 =?us-ascii?Q?ehKKWDbvTyZ5jivmJYlvhn+EAZmpsmixxxmQUzxrA/BW08297Cczmx1bZ1ki?=
 =?us-ascii?Q?cbn137xEKAFdYxcm5u+ZzNReGcm4Vzbo7yzUqcsf7JGyuA/Wax0obS4gjhPg?=
 =?us-ascii?Q?vIYfnrIw0iEug3TaNQZNEcDblTR8lZkQ8U9TIeqj/OqiUtCqkyBxKSH2gOTK?=
 =?us-ascii?Q?9sbk/2nE5jnFA4tWEiDtrwSogniwhl3n6rmgiR5asF+gwz5Spyo1rwHHBjuZ?=
 =?us-ascii?Q?xChTXSM+edK/d+GTr7OIN7X4LIB3VkXH31CUKrGaUqDcaKBeSxTmUPgHMo0t?=
 =?us-ascii?Q?NVaG0x/7uxXakIvMz44IOZKeIDoS4Jgqzaqh6aa26uaj9zk4kbsJUFoYL31A?=
 =?us-ascii?Q?5dCB7dKKD/GM3VF4qln5NIHvXQfeMSku2IBLaTkkWn7ttLkfr3Qf8z131Chs?=
 =?us-ascii?Q?P/mn4KkJJr9PmD3c3dJ+2nuwdqGdHwbUTC8/P+iytMoMsCg5ympFnvx/9aBJ?=
 =?us-ascii?Q?eytbxUG1Rq8L2C1mFt6yFYJpMp3unAvOk+wbDjAOzYVkt/RqM3Bp8K6WywFK?=
 =?us-ascii?Q?RJUPmycWSb0S8cq9TkAI9wYbhQwFsJarxfNxPuKMujypiks/caUeAm253HLe?=
 =?us-ascii?Q?64syD8HYR7hKScTTGgzzecmp/LK1dghJeTep/mGG/aC8FxJacjJeqN7irnmT?=
 =?us-ascii?Q?19Yq5Lz6lKsT5xrAAv4J8Wvj22EGj+o78UTnGlw26RvnjRF4sHKq3F9OviAA?=
 =?us-ascii?Q?8O/nI+ijqv5XEmnctXGTfaCmwF+cJJHc5WIs0OXWY1Yoqq+SnB8uBh+gjVxw?=
 =?us-ascii?Q?5iZPY6wCnzLYS01J2wbGoNgZNLuC5l7MaZOOJqMLYl7QUfm574CfvUfG+vYO?=
 =?us-ascii?Q?KIAvYrYg+JbVwYMpu34JIJxtDpJVZkPQyxyekV3az0JLYMk+x4l2YlmCCCIJ?=
 =?us-ascii?Q?YnK/qaFHsR0mGwkU4+ekwTPBIlgBBAYGKy1A3C7g/9To0zHT3hHX6iws4v6q?=
 =?us-ascii?Q?EX0iiy4Or6ehZYsWDl06gw5lFmcXyb2xXiKmI7Uyckp+XIw7R0ekmM/XZeCL?=
 =?us-ascii?Q?qLrrVevpIGKDKWILC1Wm4871khnGHzQiZh/jUeHN7plens6bKfx4HPwvZoj9?=
 =?us-ascii?Q?kSfhoHQwsIkGs00rnJvgW7sLndx04OimdCuR40lZN7PtP9gfKW98rjX766Sp?=
 =?us-ascii?Q?Gu6LH1MA/zDpw35ZlkA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:18:03.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b795cf-b2b3-45a3-4c6f-08de0714c05b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7040
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA1MiBTYWx0ZWRfX1DVU60IV5sb8
 9Gh2ZsYzudOQVhmeiKYOHJml1m3ZMeZsbY1ObL/911uDXY/cH7FeLPgdXpilWz8tE63eY+f2OzH
 X9RsfMvFw+aSR9Jjf3l5ZKQVAMJ+nbHFm/KpGV1pYeyswXInvVvI1w/EFphvhpD88Zi+onsVi+8
 IWs4AMajJZPH+sI4P0PkSBDkC034585wLzBr812Rgfj8y7UbayIauTjLTWHsZavnDUjjkHjdtF5
 6oGZq0xXWknUVAUoTUUmpafRkqgdLVORne/Sle4cRM5beggmDaNo6eGgMBpWUQIpZ+Tz69DS1Iy
 1bBf85PzG5kJb/rGU11ftctDpRSqMm012CikLP+0+rf0yWoKpMa0YrCAui6x6B2w4yOsmuREgXg
 a//QkNkFlaZl5QKXYx96KkgLoASTIw==
X-Authority-Analysis: v=2.4 cv=HoR72kTS c=1 sm=1 tr=0 ts=68e77dd0 cx=c_pps
 a=XGteBKPvimVCBgpwGHxg/w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=9ctn3jT6NFRT-2unMuYA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: H1nM7HrT-VIiEaHpSGwBmYWz0N_qihPz
X-Proofpoint-ORIG-GUID: H1nM7HrT-VIiEaHpSGwBmYWz0N_qihPz
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 09, 2025 at 04:52:07AM +0800, Brian Sune wrote:
> In previous WM8978 codec driver versions, wm8978_set_dai_clkdiv
> might not have been called for BCLK, leaving the bit clock
> divider unconfigured. This could cause incorrect or unstable audio
> clocks depending on sample rate and word length.
> 
> This patch adds a check in wm8978_hw_params: if the BCLK divider
> has not been set via wm8978_set_dai_clkdiv, it is dynamically
> calculated and configured at runtime.
> This ensures that BCLK is always correctly set, whether the
> machine driver configures it explicitly or not.
> 
> Whatever relieved from hell~
> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

