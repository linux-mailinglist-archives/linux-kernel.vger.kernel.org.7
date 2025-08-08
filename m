Return-Path: <linux-kernel+bounces-759895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68377B1E423
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F131462627F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB2255F57;
	Fri,  8 Aug 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChHAAyCP"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CBC253B42;
	Fri,  8 Aug 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640452; cv=fail; b=V2p+C7GlL3yWUa+YnkY7TXoii0xbKNJ60To0Au7DfVUM3W/BhCbuVpcVykszNhRY1EZOPfTGlP3Sn65GxgN+orjH10CLLQuM8OMJG2PFll7tlF9z3WtHIGYGh+ugG44/lfs1E6wu6EePMhpQc3u/NVn73Hp3XogPZaDiuTuJ4IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640452; c=relaxed/simple;
	bh=tUtCjkdFp7RjxVAQ210SGLZwsZDREAgTWqLmVLny0SU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEY2esytGzjlZufvymm0pIo4C9g8GKh8uMg6JiygjMHkrWWL5B1hjDb2UlNFyMp3heBO7pJrLtboQx2g8rJtVihVpcbUkkiJgbbSkjomSfKo9h6EhHK0xSEXlQRwdm53z4qWt2vyMxD/GMmAdmukrzi7KIwNi9bg5bSZOPlB14U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ChHAAyCP; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouKsc6g51GS1MyTCAh9dgdPVVivrLUBWsl0Z6wZuilk3N6/hUvQtynQkG3/ykhQYqA70QuRl6xC5Qu/byZ9C07OXocHjtWzaLDNgYQ7TW0k/sTAKqF5xbwCkxRNZwqINcAbQXoJ0RV4wihZ4rQO/x9DkU2eceKsJ3VlmUweZL3i4S/ApHZRo+spIwoi5sRSRFtINe4pfcoh5qgsXt5qqyjIjIFJBMYlVp+FsCBruN2SGxRypP8Mx9re8wPx0AtGNtbm+TJlFdb4zFBpkSAdTYxAM8XmY/QkAJ5Ylsn9fttaGjJGtn2A3h8np3VVnjC2b8XsIGQkoLrPOaJzCsBDW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwuzSRcdbT4FeTWmL6GOGjyAYrKZdmCsC0Ftjbi0UFI=;
 b=qeLqIk/IVJco5s7LumX8mfHEmRc/+/9rtYvvcQfRF6dQkBjDqPR7nnCu9V2GN/VswrznQgiveH8FRSWGdYhnA75ZvN4kSyCkAA2Ov9C0ZUGUbYfrHNWbNDeSQzeCxpFUpVfICXUa0yaOVhhfDK8rl98KEsF93c3Ditd4+o+bnZFPMRaRoeCraaHWznDRj6xstdEmujkxgGaxW3/fkWURu8lrK5SYKwoEXdaJ7dUSEV/i2rfTHSa83Z390MqXO2hMxO5rwE7Kcpa+jWT/1J0rvB5YRbDgs9xrDGSGhSjdVERRHVhvo5HRHxwpN/uypUoU26D4198hUbQVcYsMslKYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwuzSRcdbT4FeTWmL6GOGjyAYrKZdmCsC0Ftjbi0UFI=;
 b=ChHAAyCPNVx4q+oLjQKSDhZVoSLxUg+75fUxF0xMuGjdZ4RBapY6uAC+3EZ/O8wNK/QF0kkHD86dG86LzYRpH/uxV+KhY1HD0BnOCpDIYHnpbj8LSRL9qQ5z6N1wJIUx1JhCzf0116usCuroZpD4aSIp7puOTbgr7zF93QJclYYp9aTRnrh9YsJJJiOE3DGb39CJKlx8Xu0uhpRSrohjv5yM7MtJ76hfAGQNUkQHrlckAY6QHZe9Vdz12T9NVAd4tASJTS6LTuJ/sEwJo9ubIPrcdJpDtvrVY2P0xo7tqfXdGb0nmyg6VMBDBtxJvoE9ol837khnQPMV9CAm5KN8Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 08:07:27 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:07:26 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	dianders@chromium.org,
	cristian.ciocaltea@collabora.com,
	luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	victor.liu@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	l.stach@pengutronix.de,
	shengjiu.wang@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH v4 4/7] drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958() for iec958 format
Date: Fri,  8 Aug 2025 16:06:14 +0800
Message-Id: <20250808080617.2924184-5-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250808080617.2924184-1-shengjiu.wang@nxp.com>
References: <20250808080617.2924184-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a0c7f4-166b-440d-1481-08ddd6529ce1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Jpx20oqu1qYyLr6wdPQ4f0yh7KDrgrcY0M9a+Jm2J9bp5nVcwuIlWIHPdQWg?=
 =?us-ascii?Q?9NHAkODAhVK2AsDrV9A3QVp0MOxv/rgPdyoHBpXrAWRknEah0gHjqZOb/fuu?=
 =?us-ascii?Q?tkVwA2OU/Xi6HPTXgTQ2Gd3qYucPjqL8yTl8lOOwQWIpF/nRxsEszYBqC70z?=
 =?us-ascii?Q?7gnnq0p6M6oTcYe1UI5hPo6F02bQl/HXIA1sYNKVdHeSbXFJEUoioYbDjzmg?=
 =?us-ascii?Q?4B49szXnozkIfu5Dlql0azRqR16N7X3k7K5BJRVsiHnlgwFl65HF2hzUVwmB?=
 =?us-ascii?Q?pdoqfhDdMybtmN+xvYbnRDivQ8pgugQoxLvzavhblqTqxEPiWa3qRDes3OHM?=
 =?us-ascii?Q?udRG0LeNK8cUi470eb91D6y1PQnSbgw+Y2fLyxqtClFMxhd8WnSxD2JhlCIj?=
 =?us-ascii?Q?cggJK8UtCX35kgeS3cEOY6lK5GaQaY7cWVzNmJKG0rANe8WHU76DGcUSvob+?=
 =?us-ascii?Q?/ykyAIDUUnE/qebAHRbYlab5zAL1oV1URU771+JYTamXp4WsFhMd1/J4S+Ky?=
 =?us-ascii?Q?aQeez7FRIPGpm0wQ01xyFawhdezrv/UGjqkgQapsNLRG4SZrXqFLFEHCOJ3y?=
 =?us-ascii?Q?vNKVxPsUja9AEZk+i1FzWJOcCim0EfmmJUZ2HZEmmwk/C/gJwoQ1VoqoEbsB?=
 =?us-ascii?Q?roAMQbE/goo7zjmNT2EXJfXARgWgIkYIMckdLYn5RLwiua3OnPtKeM6pPXxY?=
 =?us-ascii?Q?sOo6UNI7L6YP6k+ttRs2qn5r/5Xta6ieZrj75+4dCv12pTQdtfdWub96GabR?=
 =?us-ascii?Q?yk0fr9+FVgDyLGldistBHbdSieaxuVA3AkXxG/lZKW4kAJmT7Kzr/cJqLX1v?=
 =?us-ascii?Q?/4ccBRHc7BVw22Or/YhPR40ySMmUyl7RsziWoG92WyYZAFZNg2xvTLPdm5U0?=
 =?us-ascii?Q?sDzWmHUQ5DcNaWpfuUw7Yqy+xNS/tX0u+3Wh2tw7A3lkJGjOeHMzeMdULmzD?=
 =?us-ascii?Q?KlYYsTIl4mEtN6oZbi00oK8iMjW3YFrtpdfjq6U6lQhi+DrF49k0Fkaav0OB?=
 =?us-ascii?Q?C+p6Pp3kvSuWpNE19KawLV8QP51F30gY19FbYkgPAKoywzPGOObzCe8rRe0T?=
 =?us-ascii?Q?1PkR3S9C3cwf+mFJ86N3XiNw2a5p2nHLgcLflLxywc8S7t24r45uRf1DdEwW?=
 =?us-ascii?Q?TWxv2QYKIeBLNxtupEhhlgwsrlf1zIOzOxgg751oraO1VVBj95/d91m4jtiM?=
 =?us-ascii?Q?7I1F8decFfKj4uttQCWOQQ8Gw5dlwIWaftSz+dzIznsJWwXhUabyPSzZEI36?=
 =?us-ascii?Q?YGRmsFyyB6BF1FMMsAVB/gNXDXU7OdUtG/lDxezykUqQGW7Gi5Va37cwKgqT?=
 =?us-ascii?Q?rTkkZVZhhySySpXfaKqd11EQgi+DkHeSuqObCQQk/LVpSAITYEcdqe1P9Xa+?=
 =?us-ascii?Q?CFlcjW8W8t+S87Cf5jepEeZ9qG0KMeAkpg8z8nY0Fq/2M+NjF+agqpDQOtaD?=
 =?us-ascii?Q?TT02WObPFGJ42xdhzVXPEKdQ/OELYc0Vu+rD56eiN7Te+9qEYhdv/h9S2l1z?=
 =?us-ascii?Q?tHHQrgpcXocq/pU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?moIlsrM83jZTn2Fn2bu+x28xI4NoVvbKVE3JRRUPF3AdXIfa5dmDG6sBcIvs?=
 =?us-ascii?Q?QNyc+OVwfPRVRLJmJEG0BKVYK46FiMEBQorRft2mmuRwMlM3tj2t7rzJhshx?=
 =?us-ascii?Q?mxb8U+hoJMAWfbzTCT5lcf7174w1hUrFwj27ts3fWGI0w8WNhhzESGtFcVLU?=
 =?us-ascii?Q?w/Wt1NV8yP/wCJA8/UYRWxMhH7XygzyAeGzqQq72ZZ1yafSZO/v0GSvnpbKJ?=
 =?us-ascii?Q?cSbl7onXXreqBP1s1nMG4dmscdwT1QJAGctiBeqjxWmFmG9XGIdLPTk9l4fq?=
 =?us-ascii?Q?2/NJbav0kZfzT32xtD6Nn5BcG7zStrEm9FxnRMjLIb3Y3nruI2rXQWiyu77F?=
 =?us-ascii?Q?Rnci4yX52RPilnprBcQIs53J88JE0AScJ35/MzCRtcCmBwMb2LK/DXKi9GEE?=
 =?us-ascii?Q?VSoZ8XFvQ955aOHeMcMW+N6tFoKO30z4VnkkSzjCI5xWs85fvq4qbrQRSS2s?=
 =?us-ascii?Q?UZxSCxWEs7VVTI06we8WPdAl2HhbWZtgzvY6R830N1YtBqjmFAd8ZDgHqj6H?=
 =?us-ascii?Q?4Qhfh/jv39UH431Gw2vaWjVX9JwYQO3TrHgW/SWExj8zAF6EZUBguWpjZV0m?=
 =?us-ascii?Q?Q3CE7mgKGpBLVFP53KCut39n8iplxJWgs3PtiM56zWGkuHaw6v72Cbsry7U2?=
 =?us-ascii?Q?P2nQ2yww9pvMgdPbfo2hr1FhFpyWfoLmhybG+NJYsuG9sZXEysisTvh/ORqq?=
 =?us-ascii?Q?iA1LgkpXB3KyhadgpgK9QgXg6kV03kuayyISa//AEF5ABmxkBlyov71ew7hJ?=
 =?us-ascii?Q?1af67oXeSvq0e4PdoQQ1ceUU21pTxClrbpZTuysia/cu6xCqH36Ps+JCSQZe?=
 =?us-ascii?Q?VrTIoTfE4fcsk+1PK2aXsyQ6BaWhh5HmSRzQBWl2ai5iHfKz9Rn/eklb04dd?=
 =?us-ascii?Q?2rxO3zvXPwF/0wIQL5nAoYhCYTAFofiGqGWlx6V/G7oZ8+Stjr6RLRi3vGFq?=
 =?us-ascii?Q?sGC6bpmkxyToPUWYlOIi7Epi2BsrSbuBQtY51fI3rlBazOJ47DUMRlvKWYjG?=
 =?us-ascii?Q?++2PMbItMKL1qcxwmwuf3YKIycpR73mIDpiX9dKsq3+0Hdh0wvk9zzNyFX8d?=
 =?us-ascii?Q?bwiCVlI/WBwrY5xrrNG0y1IoBYsR24xxxbso0PFKEZPe7RE93Gs6S27LR13z?=
 =?us-ascii?Q?JpggKI1v94rH4ju9Oh+fHUe0dBJffm4AYJZlKymoj3XDq7oJHPZ0Lx+zZ5ns?=
 =?us-ascii?Q?of7u/3nnBe1y1E+vMKYRwoRpeMp6zuzCm0tEQR6TsQ0FdrctAB/kmiLxsCPZ?=
 =?us-ascii?Q?4QDBqNATe+m2pQeF0i7rFpcgycLKI/ixmXUyLrxsp4BQd/XLE18owsF/lSu8?=
 =?us-ascii?Q?hDPoWu0hxi7MvBqjHxBflrEj4BYNFd4H/T9/oLYIE6T3FhEsGEIuRK0nXtaa?=
 =?us-ascii?Q?MmEf8cq0K6lIMX5L46xtHXQjgyExvzEYlfvdevjBJeGjdbOTGZQ0Kh9tDOpu?=
 =?us-ascii?Q?o1gzrHjiAwb/iftmzvFA136NU94iA53QcMb4tIJxS/1refIuP5WWWYGMHGcz?=
 =?us-ascii?Q?ukkICev2aAqXe1idv1NSeSjo/NO/n8D03Y+5fIfe62pOQT1CcLCDWEWJOqhT?=
 =?us-ascii?Q?Y6sjdGZTKlp9uW4qXUfB0cZWByxfmuwz3qmcAcXB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a0c7f4-166b-440d-1481-08ddd6529ce1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:07:26.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PambkHo+TgMH/V/LrTQFUDwXgjhZboZGmoJe2jUoEQbjzkrOJVDTmWcVGeWLqxzPrCCESZo6ImpLeUqWZaRO3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192

Add API dw_hdmi_set_sample_iec958() for iec958 format because audio device
driver needs iec958 information to configure this specific setting.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c |  5 +++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 12 +++++++++++-
 include/drm/bridge/dw_hdmi.h                       |  3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c
index ab18f9a3bf23..df7a37eb47f4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c
@@ -90,6 +90,11 @@ static int audio_hw_params(struct device *dev,  void *data,
 				   params->iec.status[0] & IEC958_AES0_NONAUDIO);
 	dw_hdmi_set_sample_width(dw->data.hdmi, params->sample_width);
 
+	if (daifmt->bit_fmt == SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
+		dw_hdmi_set_sample_iec958(dw->data.hdmi, 1);
+	else
+		dw_hdmi_set_sample_iec958(dw->data.hdmi, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 8d096b569cf1..3b77e73ac0ea 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -177,6 +177,7 @@ struct dw_hdmi {
 
 	spinlock_t audio_lock;
 	struct mutex audio_mutex;
+	unsigned int sample_iec958;
 	unsigned int sample_non_pcm;
 	unsigned int sample_width;
 	unsigned int sample_rate;
@@ -718,6 +719,14 @@ void dw_hdmi_set_sample_non_pcm(struct dw_hdmi *hdmi, unsigned int non_pcm)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_non_pcm);
 
+void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned int iec958)
+{
+	mutex_lock(&hdmi->audio_mutex);
+	hdmi->sample_iec958 = iec958;
+	mutex_unlock(&hdmi->audio_mutex);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_iec958);
+
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
 {
 	mutex_lock(&hdmi->audio_mutex);
@@ -849,7 +858,8 @@ static void dw_hdmi_gp_audio_enable(struct dw_hdmi *hdmi)
 				    hdmi->channels,
 				    hdmi->sample_width,
 				    hdmi->sample_rate,
-				    hdmi->sample_non_pcm);
+				    hdmi->sample_non_pcm,
+				    hdmi->sample_iec958);
 }
 
 static void dw_hdmi_gp_audio_disable(struct dw_hdmi *hdmi)
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index b8fc4fdf5a21..095cdd9b7424 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -145,7 +145,7 @@ struct dw_hdmi_plat_data {
 
 	/* Platform-specific audio enable/disable (optional) */
 	void (*enable_audio)(struct dw_hdmi *hdmi, int channel,
-			     int width, int rate, int non_pcm);
+			     int width, int rate, int non_pcm, int iec958);
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
 	/* Vendor PHY support */
@@ -179,6 +179,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 int dw_hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn,
 			   struct device *codec_dev);
 void dw_hdmi_set_sample_non_pcm(struct dw_hdmi *hdmi, unsigned int non_pcm);
+void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned int iec958);
 void dw_hdmi_set_sample_width(struct dw_hdmi *hdmi, unsigned int width);
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt);
-- 
2.34.1


