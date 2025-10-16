Return-Path: <linux-kernel+bounces-856672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767DBE4C37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AC6189AFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4D328B6D;
	Thu, 16 Oct 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AK7LjPJe";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Vnh1b2Hl"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D234F479;
	Thu, 16 Oct 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633945; cv=fail; b=PMdh5wHvqRQqb82uNEFLkVEjNM4nJubQogpanJbctt+f0f1t5wL+736nT45KgvkvMt3/MuHDPEjpgsGFB8v3W5PF5+edh61uw/c2k+urmJqmCvhe61MC0uLpENnb5p1yr51KCfrbvfbdOCsokOLDPwVk0Al/sCClHy/ByG+1aUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633945; c=relaxed/simple;
	bh=t0yChBw+oCh2c5xX+LW4uYJw3gRedhE7wMblsIpFS1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTYKwGNWKox5syMNDxkQYVh/lzlL6LgWHgH9Sd1DWI12xUCSIMflFkFjnsR/DglFwEFsJe53tWG33wNVxzDzv4yB2WE6+nz09v03feYMNtIhwdPhFrr+NkpwwxeHO5OO21TXtnz+nh9Ngz0nH04BZVkSrnZ/D7rmxFzJaKqhD9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AK7LjPJe; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Vnh1b2Hl; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGSm6Q298642;
	Thu, 16 Oct 2025 11:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=; b=
	AK7LjPJeCEE6j+CwYmf3S+VW452YRiD/sjJ0zwBC/oiCQqPMShs6piluj0EpMeK6
	1Gemb4HoZbMksitQhfz8FZLIg7YHumk9cKn5KjFjVFL4kU8y3eelyhJRAi64/LeF
	UQSdOX0ZSWvaGcwqCSLqCpoIgH3PVYD/YEHf5sCBB/ywtvmVfNEmw7+lEoKPP8ME
	9FOSXIYJYSrL9PVC1rTEf6nQ9jJA45vlUxHASp0moKGsMRMmsDcMECqLrjX7NYBr
	gLZ8bq8858HBlwbtpQe/SKt8y/6vuJgSBgk+W9W36OK6vLKWVFYKw34KX1SuEAUJ
	2uodZEhzj4RHSc5+hFF71Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022083.outbound.protection.outlook.com [40.107.200.83])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9h1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm74hfiFoS4sfX7mUDCuLP9N9itjCGZcT3GjfSY0rF6Ruw0JQIdNvZVVBW+4IkRLKRTk8xAPSr+xrEuHsNn4O1k6Dy8WD+N3Ylmdc5DFjpLoPDzO4cxEizaBz/9/93up2lt7F9ckgQMXfCLUW6b+FSfP3z7//QE1eUDw1L628F9WXDmhk+TxivYRav14T28y8+8VROpEYYUkeC8n3vjpgY+7uZTpNYn3GKzBHjGQw2XXMFkX7qQiCpkV13d/RQ7rYVQ3bkdUGu3tRllrbrB4HZsrDGWLRcNwGpP8Eu96yVq/lfD/V3E3eze50rRwLdmEsCLaGgXNp2Sr3XJcs7ERFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=;
 b=mX68VlUbA1iw8ckUNpVMk/XUHp9nRmZZE7YhUMpMS1vPRqICqmqjo7uvl+Z+uUuUpCnbvI6wy+bL13sE+HyTlmYlTVXZWk92a2MdZa0TkdMfwe+vXXGaE2ZWsSY5FMq8lN36bmAMMLewwgJXyIE/5OoWxaN5hFgDDfC45uNpHeewCL4QEwj8oReM5Cj/u9/am4j3qUTDYQcabv862WZmez84WPg1RTF+xm+BE6/lOmT3mhEe56CnPc6rPAqNPn6xfwXmRhmKnxhYa5Vx6uNhrd1/MLODBBZBQ/tx1hZSandOMGXZHfl8OeGkOdW1p6CzoTrsPamYKl52gZQjLrFYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=;
 b=Vnh1b2HlUJ9zbyHc6Zk876g6JsXu293TH0bSBEcmn0x1xC8DvQCIrd2TczHKLcmm6R7aLBl38TCAsZtqz5NWCC4sMAtTTjy7oclm/wGR7OhQ3wccUskhDV2EJ5vQ8zCcP3ta4J5R+ulUkk2HeXEMuwMCHhxDhnF1SFpIQ7llgpk=
Received: from SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::18)
 by MW4PR19MB5590.namprd19.prod.outlook.com (2603:10b6:303:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:58:51 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ff) by SA1P222CA0037.outlook.office365.com
 (2603:10b6:806:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 88507406569;
	Thu, 16 Oct 2025 16:58:48 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 33B7F820244;
	Thu, 16 Oct 2025 16:58:48 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 10/11] ASoC: cs530x: Add SPI bus support for cs530x parts
Date: Thu, 16 Oct 2025 17:58:21 +0100
Message-ID: <20251016165835.143832-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW4PR19MB5590:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96dd5e80-17b1-4d82-0729-08de0cd54812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?by9/726Dyh+mpdcuOpL/tjAN9bhhtf8iAWrfyNIPHjSMZU5GqVOUD7QFLJyB?=
 =?us-ascii?Q?63fc8jEyeD6HxMr9wKrrq5raJMdx4dIu0YPAKDYqkra1babSv+sBUFdVioHM?=
 =?us-ascii?Q?HE8AGJyM9xZu6yFtCTxsThU9T3pxuo+IYiY6RrrwqaGfe6u8HUxcRYNN2UYh?=
 =?us-ascii?Q?H9MuSZj9Vtr3mCJV+pPbRsyr9IYPA0tJD9mIh6XXLV4NhHsRNqRaCl4MQSBp?=
 =?us-ascii?Q?IY5U3sC6YTTO2Nk3DC5/8x946Ids3as+ssvFR+kz9EpHwbaJbUIuerubg3QP?=
 =?us-ascii?Q?F1lSxckNA9B8VXLTrEzu1+ih4VV8GZ2oy2yCMydlpCfFZtF5WY8IbjYjevWK?=
 =?us-ascii?Q?RFZ0K/WGhTaWGT0vn6H5PxHQZnFRxou0MBlSfjRDufd8zMSZq0VkL7hL61Ci?=
 =?us-ascii?Q?MDpu3LZ7JGsD2a7wG1TVtaDdOauDgvbouIveGAX7TJFBsMYit0EiY4I1wByB?=
 =?us-ascii?Q?O+GSm/EIv/jY/KnmLXbT+eeWyxqg/VnyWkAyQixElYLxiGSRap90+6Pn8tGP?=
 =?us-ascii?Q?c0O/Qs1Dyne7zaRsfUZ94RyyPG76jVWLlFLWJM54/EYO9xZn2N5qkz2TCoso?=
 =?us-ascii?Q?UTONjrnChtSobY+VwUoYXvz8JVF8eL9UGWd9wpKYd5g876qB1p4k9Zbwj+Lw?=
 =?us-ascii?Q?IKckHX4qt3rOr2lHLYE3Iitpsb2nIdFaVQeMQ3oIZ6FBWuLf4MSrpKzg99zd?=
 =?us-ascii?Q?orwEHWPMiwyVlCJ6cNR8tJqDbxzLi+WganfNSyD1J5b49kbUV+m9UWjceVzE?=
 =?us-ascii?Q?K+rqPjnV6YboPY6j44v51C2NXrUWkjhM9cF+n9yTj8LqhIX+p0YnxoW9/VI1?=
 =?us-ascii?Q?hPMHqb9Lx8tBPFJHjUc+7BMKWNCmH8xAnSmRhIk/dL8Ts9fLYmBXcl8DncQJ?=
 =?us-ascii?Q?8UjLxzVAc35A95iV1EwNCBKGb+rB0RrCa0nvghqcW+1KadGIkHtyYF5sUcBj?=
 =?us-ascii?Q?QsGwc0okUVNiH0QtozDpOi+l6IFgDTEWtAy8mBFdnP7ZDqZBxFHhk7RjKJWq?=
 =?us-ascii?Q?DLQ4qz83sBxfysq2Gjf86+bHvKO8DWpturcPrD3nJmLIVP0EcgoAJXg3PDwj?=
 =?us-ascii?Q?uaeOQXYEnnMYGIdg/zJuu419hHxCzVdufL8XAg/GyH/gm4wiIU7ZMqTz4z/A?=
 =?us-ascii?Q?LhGAJNVrOdd0xBkARggN/inNGLXqZzW+ZlStk/13HUQobYztACxGrkKjZlac?=
 =?us-ascii?Q?TD3cxGACg//e4b4soED8fr2mlgXJ71Nt46N7NNNCgEh7ueDvW3U8ppKsSXQN?=
 =?us-ascii?Q?ylQXZG5fU6HRclJXtfQ0pvF4gqkeLiJMvMuN1LhPnINRT+zXNoWQJQ0/c+dL?=
 =?us-ascii?Q?AMHrH6cLUbULpNxe3WIdwp0o7QVKXlYN9sFbLwJ6sGwg62xFfAhwrD0Sz2LC?=
 =?us-ascii?Q?TnI0VW/QD+3sFFQjiFgN/E8k2Xna0o74wfqxcSZbpcb4dsUujlHyY9eT38C4?=
 =?us-ascii?Q?793WBYlI8+yGBDDv2o5zrAtDgNx29K3aeLn6BcJk2rwm3j6GQd31W0idBbuO?=
 =?us-ascii?Q?pnu6zwlGhUN7RucTQ0m1HDtIaDAFDmV18kq5solOopI+DNdmAfGFiViqtzpZ?=
 =?us-ascii?Q?z+Pg5oq6psgv5XdLtR8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:50.7104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd5e80-17b1-4d82-0729-08de0cd54812
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5590
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfXxwu/efVUB1xe
 onS6dscJ79ujEuhhQHED92hic18dogGQKB+dAmZ5IFYoy6IjbGLpYWCuAstBenNIaLXdyx5oeoL
 hf8yVyPMu0daRioNBN+Qa5vyG3tdOezDc3JVVxOltdcgLt4u1BKfRSNsPg8oCFktujhgIpgf3Ow
 oVBHQ2e2URnKPF050DrcjXydw8OF460w9K0QmtNacIRQPCHr9d2qDPfEhXvzLHwiR7B6nGPpgy6
 sqqxULT/hWiMrIhHVOCilXMAswCbHktE4zJMm3AA59k8iykVlQP+Tt7RYKN12eLb4p5kLBNzJ6A
 SfkVVqzNgHeJ1pGfhqac3m67iwk4w9IZHMp1udeIp7nXV7Zj9dAFWng1JlwCEJpkhXe8aafRiuJ
 dvmr8Tv+8fKO3iX/aFYcYNwoUOhKrQ==
X-Proofpoint-ORIG-GUID: x1U6iKKl5oXZSl5IssLEo7CBmA62N7xV
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244e cx=c_pps
 a=ZzZLShWY4Ra8+E12r48fxg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=0hqhs4pA57X8KY1vVdsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: x1U6iKKl5oXZSl5IssLEo7CBmA62N7xV
X-Proofpoint-Spam-Reason: safe

Cirrus Logic cs530x device family has 2 control buses I2C and SPI.
This patch adds SPI support.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig      | 10 ++++
 sound/soc/codecs/Makefile     |  2 +
 sound/soc/codecs/cs530x-spi.c | 92 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs530x.c     | 21 ++++++++
 sound/soc/codecs/cs530x.h     |  1 +
 5 files changed, 126 insertions(+)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..ef49f71e8b34 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -106,6 +106,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS48L32
 	imply SND_SOC_CS53L30
 	imply SND_SOC_CS530X_I2C
+	imply SND_SOC_CS530X_SPI
 	imply SND_SOC_CX20442
 	imply SND_SOC_CX2072X
 	imply SND_SOC_DA7210
@@ -1082,6 +1083,15 @@ config SND_SOC_CS530X_I2C
 	  Enable support for Cirrus Logic CS530X ADCs
 	  with I2C control.
 
+config SND_SOC_CS530X_SPI
+	tristate "Cirrus Logic CS530x ADCs (SPI)"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	select SND_SOC_CS530X
+	help
+	  Enable support for Cirrus Logic CS530X ADCs
+	  with SPI control.
+
 config SND_SOC_CX20442
 	tristate
 	depends on TTY
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bd95a7c911d5..39138d96a720 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -115,6 +115,7 @@ snd-soc-cs48l32-y := cs48l32.o cs48l32-tables.o
 snd-soc-cs53l30-y := cs53l30.o
 snd-soc-cs530x-y := cs530x.o
 snd-soc-cs530x-i2c-y := cs530x-i2c.o
+snd-soc-cs530x-spi-y := cs530x-spi.o
 snd-soc-cx20442-y := cx20442.o
 snd-soc-cx2072x-y := cx2072x.o
 snd-soc-da7210-y := da7210.o
@@ -546,6 +547,7 @@ obj-$(CONFIG_SND_SOC_CS48L32)	+= snd-soc-cs48l32.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CS530X)	+= snd-soc-cs530x.o
 obj-$(CONFIG_SND_SOC_CS530X_I2C)	+= snd-soc-cs530x-i2c.o
+obj-$(CONFIG_SND_SOC_CS530X_SPI)	+= snd-soc-cs530x-spi.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
diff --git a/sound/soc/codecs/cs530x-spi.c b/sound/soc/codecs/cs530x-spi.c
new file mode 100644
index 000000000000..dbf1e7bbec19
--- /dev/null
+++ b/sound/soc/codecs/cs530x-spi.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS530x CODEC driver
+//
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include "cs530x.h"
+
+static const struct of_device_id cs530x_of_match[] = {
+	{
+		.compatible = "cirrus,cs4282",
+		.data = (void *)CS4282,
+	}, {
+		.compatible = "cirrus,cs4302",
+		.data = (void *)CS4302,
+	}, {
+		.compatible = "cirrus,cs4304",
+		.data = (void *)CS4304,
+	}, {
+		.compatible = "cirrus,cs4308",
+		.data = (void *)CS4308,
+	}, {
+		.compatible = "cirrus,cs5302",
+		.data = (void *)CS5302,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5304,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5308,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs530x_of_match);
+
+static const struct spi_device_id cs530x_spi_id[] = {
+	{ "cs4282", CS4282 },
+	{ "cs4302", CS4302 },
+	{ "cs4304", CS4304 },
+	{ "cs4308", CS4308 },
+	{ "cs5302", CS5302 },
+	{ "cs5304", CS5304 },
+	{ "cs5308", CS5308 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, cs530x_spi_id);
+
+static int cs530x_spi_probe(struct spi_device *spi)
+{
+	struct cs530x_priv *cs530x;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	cs530x = devm_kzalloc(dev, sizeof(struct cs530x_priv), GFP_KERNEL);
+	if (cs530x == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs530x);
+
+	cs530x->regmap = devm_regmap_init_spi(spi, &cs530x_regmap_spi);
+	if (IS_ERR(cs530x->regmap)) {
+		ret = PTR_ERR(cs530x->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs530x->devtype = (unsigned long)spi_get_device_match_data(spi);
+	cs530x->dev = &spi->dev;
+
+	return cs530x_probe(cs530x);
+}
+
+static struct spi_driver cs530x_spi_driver = {
+	.driver = {
+		.name		= "cs530x",
+		.of_match_table = cs530x_of_match,
+	},
+	.id_table	= cs530x_spi_id,
+	.probe		= cs530x_spi_probe,
+};
+
+module_spi_driver(cs530x_spi_driver);
+
+MODULE_DESCRIPTION("SPI CS530X driver");
+MODULE_IMPORT_NS("SND_SOC_CS530X");
+MODULE_AUTHOR("Vitaly Rodionov <vitalyr@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 027d936c0912..6df1b37fc6c4 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -12,6 +12,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -1142,6 +1143,26 @@ const struct regmap_config cs530x_regmap_i2c = {
 };
 EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
+const struct regmap_config cs530x_regmap_spi = {
+	.reg_bits = 16,
+	.pad_bits = 16,
+	.val_bits = 16,
+
+	.reg_stride = 2,
+
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = CS530X_MAX_REGISTER,
+	.writeable_reg = cs530x_writeable_register,
+	.readable_reg = cs530x_readable_register,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = cs530x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
+};
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_spi, "SND_SOC_CS530X");
+
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
 	struct device *dev = cs530x->dev;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 8675a86d7d95..8af7921b3c3e 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -221,6 +221,7 @@ struct cs530x_priv {
 };
 
 extern const struct regmap_config cs530x_regmap_i2c;
+extern const struct regmap_config cs530x_regmap_spi;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


