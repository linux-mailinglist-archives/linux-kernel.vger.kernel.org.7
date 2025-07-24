Return-Path: <linux-kernel+bounces-743672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FCFB1019F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029DEAC13B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37E23C4EA;
	Thu, 24 Jul 2025 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GESHSfAS"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CF23B604;
	Thu, 24 Jul 2025 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341829; cv=fail; b=tnwphapQyNDtlFU4JWO93GTaqYsuHB0UrARBZADQbgX8zXxNYUb4d0JkrOSpUqQSX5ZrX4DJkjlQyj/1ofG+5g5WxwdhzIH4wkYZw36dsSHEZMuPrX3rGVEmVYMQxn+STQsK7SkhY4m3C5BpQkTUz4HzAMqaNu4uigVXWiNUXEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341829; c=relaxed/simple;
	bh=WzEKbNSvB38NlKXdDcCy61A7pMp+NSl6i/klKAfSt3c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bw9En2YyG1A3RV/m/3XtRrBa+YUM4pxMz5duvjfUpNrWXfCE49cUFe7r+me4ovrGrVBtUv2I863CGHCL/yV3jAuDqQFZNroimbku/AhodImlKKc1RTM1M5oF4e0qnZ+HYZW3FoAAozTdsWYzxgyOqGF2wrsfkuZ8gLCSjEAi9M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GESHSfAS; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJvb+t77BTapofScz/PF5be9OP5JIP+5a2dvtapMTtD+Qoepw3AGZpH7xIIMkWS3rRGectjt1DGTHIFUhYsTYuVc10kFubzCQru4Qm2pXheixUqYcpZvu29XBc2vox6iGqp9MVZ1PM1ZnKHXC+qhCxYeM1f9iMJhd5jvFJMr3y4A3h2gcXqV1xGJ9t+JUxZjb/EWarhvYoo/yd8wGX73F1U8MkFS8uHGD1+WGEj/GJgJqJA7FzNhNgmHrd2POOVdXh3b/iZWbYB2it1qxAeru1ll77nt6ouD75E0jOWdHkwcVHYaUYAfzG8PPK6/wHPFEqj6mQ3fVnUU3V66qWCkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhr6adJpFc5GauDPAC3Pw8zxh+WbV8gOqJ/93bN2dLM=;
 b=DiFn4qt9dMNYwfjgwm36v9pUULa3IY5o75K5d4qnORPGv4n1ptyzemcJuX6TdFxsgORkE2p3MntUNgpq/I8vf1i94RxkK8035wIw51l6Bqlq35/aLz6bmhMiJxaUJkEodbi8xPMUHzpIGiXUUX3gTXNySGHlNkB5eylM6ukgTuLkcBn8kMC/JNL7MUH7TUiDVXgkfpXzI2DH5XqR4uyVzGSWiUIhXtsWuf70fQJ/8DmpaNerI6qenT5QcEMZEV4fbbInAiVvH1pvkfTFjxw2bqFPqGCWYSTeW5FglzCqCvgK8psPT/ILKtRMb8v3QEmPXwL+q1l8Yi3FBvczptdU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhr6adJpFc5GauDPAC3Pw8zxh+WbV8gOqJ/93bN2dLM=;
 b=GESHSfASHkL5BEe8o3iGADxNqKt/pZ9OmIMdTeqVZN0KPtiNKVRRFt3F30m7UE+XYBWI1nzplr2yJkfvz7sTsAHTnKlf14eNUdc+SSqFTG4GD8k0KHJuatYJLzSrB2bLVGBCIitrCEtdj6gnbmXjERcdxD4sh0Ya30x9wd6CXTHNY7kxjH1pGYl+Vf9e9/9SvONAEQ/ANab373p+VJvozjuEfZhmFPMun38uUzWjDoCrEpSyTFay41taWs6yLhcX06PCgrWueVQ/MC7lBgK/CtuQ5tbpDk9s001W3KyVKiS1f+LE1GFy5rM47odWdxkkgSJuA0OyFd4zm4DvCtciMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM0PR04MB6915.eurprd04.prod.outlook.com (2603:10a6:208:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:23:43 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:23:43 +0000
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
Subject: [PATCH v2 3/6] drm/bridge: dw-hdmi: Add API dw_hdmi_to_plat_data() to get plat_data
Date: Thu, 24 Jul 2025 15:22:45 +0800
Message-Id: <20250724072248.1517569-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250724072248.1517569-1-shengjiu.wang@nxp.com>
References: <20250724072248.1517569-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM0PR04MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: f17de192-3da0-404a-f706-08ddca830543
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?bFM4uvRlpbCeg62aSAfU4RBPd5Djz/8MHmeYOfLN+WDRTQ20AkKbgvTQpaLY?=
 =?us-ascii?Q?Oob+0Qv40D1QWE95yD7XcZjPJtxo39czaPYqFTxHFYz5gPfHHQQleZ9ryvU2?=
 =?us-ascii?Q?9tUorVN1pOMBOJAQVX2Bngu4xXoKmDvWHrgAikbn966RNEdjlPJ3kxsUhGe/?=
 =?us-ascii?Q?3K+N1W82ATqs0xBb0foh5PkTFZhfCLRMK9afS0wXG3VOQe691UTVhf5N8KDJ?=
 =?us-ascii?Q?dSEtRNvO+luM5S0PWSX2787KCAvtiZFpvQzvHQ0DH1veyen0r06oajVEa5Eq?=
 =?us-ascii?Q?YzFNBooHb2KL2Q8eY12B+xZ/CLkjbk53QJR9gP3q8qseH1HlTxb4/XUtLKgY?=
 =?us-ascii?Q?rw3uLYo2HQK6bGM5+M1tdMZn0HyEbzWbKD8H1ZmcMH8icWnqVb0LyyfmUiFi?=
 =?us-ascii?Q?Um9rVOMCsC0/yaun91aI3g7fMVfMaUDVSmnvfSi+rbd3SzgsNOHJgwmJjSZr?=
 =?us-ascii?Q?L3u+gTEdgBjCvhoVVCMn01JxLMAihTkepdLt9Qnp+G+ncBb4J3KqW/jNYCKq?=
 =?us-ascii?Q?ztsaqm0uaf9J1USxjgo0aP4HliKE91M7zUFQGFDeXpsejDFHYCvgnH/8zgOL?=
 =?us-ascii?Q?tK8LvKhoyjsB0t+3gGkTxEGVh6OEgznPRdF9OmYpelbkX+lvn3Qd9p2ygaSd?=
 =?us-ascii?Q?iFngfy38g6GQchcEQjPAjKIKjlvseInq7pGvuAlkdBTHXsOjaz52JfQ9y1Q2?=
 =?us-ascii?Q?QhIuN+67JLmdgkdGhTbD2/TZ4THh1ucVTny1r2zx1xCy4YHiiVG+92RtkSNe?=
 =?us-ascii?Q?vnGGnq+9G5lUXOKQAG/EDTiJh0llfExLLz+huqxd28XfKyjeqQ22g/TrBaqx?=
 =?us-ascii?Q?Ft4EcuxWlBpFScbWxtgjZCETRg+TyU8KyB5JelgP/HFxvA88x+m2NodcxB+9?=
 =?us-ascii?Q?WLRZXwUc9PWM+PjLmvhKQCHWZ4R3dTJx7HxwTraeqMaUWlV3FJu3vph7q1p6?=
 =?us-ascii?Q?XEr5BzzFtVdJr5Hzz0j9Je00HjvrCnBj39ZSa7zAi7R+W9zABpugksxHU6Gy?=
 =?us-ascii?Q?r2JlDZwVzzj2BXFpeJ3PkWPk3R8GGPgF1LB5/GnCTXHb8n30VA3aerKB7T16?=
 =?us-ascii?Q?ypk7/EwHzyJYYZqKbulEu9l77fs1X2vC5lLpPPR10677Ty4ZK9e5sh3aIFED?=
 =?us-ascii?Q?6t6o+Al8kPcnJrI4+p/O3QcK2Mc9DmV4+XRWk9spds3ZEvnKADpOz3uY/tUG?=
 =?us-ascii?Q?QB/WV0gdvXTXTFHEjIOIDrt5yQtaOiPfYA24Ib5/kbiS4waVrA+3BphTM2+1?=
 =?us-ascii?Q?6dZwm9VtP6lZcyoyBtIUHOKh1UVrz75ZL6xLBQzMF45uvuG/gInTE/TQYJwI?=
 =?us-ascii?Q?nrkQQxNKgv1j99clroQyPzrjpQciv0QFJGDu3qK0vafUxVpsDXAgkI5ysx+5?=
 =?us-ascii?Q?URpb8udPj3xAQZkmWUVxLCIo1UaWmjiB8Ww+EunxI/umw3I0V08fvB2tCiyp?=
 =?us-ascii?Q?VTKi9ZBwH3AWmTo9NvrdpucXNu6yL0VAhpDT2M0RRYf/LdXKyXwauoCREQJR?=
 =?us-ascii?Q?e0iUHFIBfMgixBY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?oax0AJz4DA3QbZ4ulHSMzYJZNKrZ8xEtyR89gm5hCM3DvizHYRPSBSPYKb1G?=
 =?us-ascii?Q?tnerEx5BwHv9MfGz2X5W2EZ6DEIGY7IPK1p85AOm2d5NCQpvdZJgul2siolH?=
 =?us-ascii?Q?y8Z8yY+6rpRqQNpRU7ujBgt8jXJCK9p54qFw8S/RwU8ur6IjW6U38ksSblgo?=
 =?us-ascii?Q?4Kc4uQWerMZ5IwLnNxS+/cfJzvpbHpzrz0GW1ais/M1RHRhd6GUC1UaT167U?=
 =?us-ascii?Q?9NGs5coKYf82ZTj5VO/snPdxlqm6XPUIKRMWiIGCTcVheucf6IDxdgFNipOX?=
 =?us-ascii?Q?aSiGthcliJhiaFR8ECJIV0+CNFQs7+LX2LDsMylaJTzGrax0sl/WY5pQ42DT?=
 =?us-ascii?Q?t7mxRjqntEQGbb/kvb1bDNGxB/VR2SRwwsnNFf/lvh5L7i5Iw4F/CtvkoIDe?=
 =?us-ascii?Q?awyxYnu5liNT5d778OQQMZUh8AIGYu4rqJXaGzkcXWKqGwX8mDb6s41LltuB?=
 =?us-ascii?Q?Gj6rA1wp4eNbXye7FOY2HCwrLi8QU+ZsGmqPwJG1hGQC7IKMN2e4xSI0cRSb?=
 =?us-ascii?Q?zhR5nBcpOwwTueltQ8axMakk8rdIQaHAWcE2DYlU4+RTOw5BOGld6aqHF/Xa?=
 =?us-ascii?Q?9M+zzZnQhFgRejeqzagy5HnDuwC/GAWrKV52Ly8vz+CeSX+H4/H+hhfEHn/7?=
 =?us-ascii?Q?LRI8T/rbzfjcOc55PiDlX5GkNxXE0dqqnV2A2TCdfpf1J7Qssw8u/YNoQMfE?=
 =?us-ascii?Q?C2Z4gxoup6Jjxn/zpuF/FtSGdX5mOutELbBEnLom9yxxOiYoAM0unUso/GAt?=
 =?us-ascii?Q?b/IAZbBp914OYKxxKSrx9qsCnvoB54QSvl0GL7mUlZJbsgCoIuSs1K5dVfgz?=
 =?us-ascii?Q?21VY+Ly6KoYY6my62CXsqEvCFSSD3LjYM9Rp6u22DoJZUImU1d9/S6YurdaH?=
 =?us-ascii?Q?ye/Io+cmFl/RnRJaxgVLh4EFHFq9D+/XdsWMAmcCacA5LxQdAUcjVd+QhBYf?=
 =?us-ascii?Q?v27jo7bq5SlMhB4fv2ZAS2+nT5SmzSxdbJsczoaFW9tzCy1wO2VvzuxvY4ld?=
 =?us-ascii?Q?Y/0IJ7mt90T5RltohqosDOg741tMLJI57z0LZzRihTwR+Dp4L9N3T/UaGhzU?=
 =?us-ascii?Q?XBh+7djDXbDEHRGO2NCYrnIjyfHgeLX/ICflVpFBqsvx8fCLo7uxJnILOdZG?=
 =?us-ascii?Q?WM6C3rTqPuD9tmtJ9Oi29rwZ/NbtwP39/2L/TrRqjGGUsFvmGYCHZBxXWxzU?=
 =?us-ascii?Q?7EJMrkdmxXODUwjNbwcmcfuc1Ikexs3ljAdwJprX1gXkhWTBPx9nLVjcUO7H?=
 =?us-ascii?Q?iBYafP5KRiGebybLY18y/mUqyx5SBqkW8BgtXHhur/UExhSuLGxK+DD8tsva?=
 =?us-ascii?Q?vX5RgzKKY6Ep0eJKsofOrmoKDqCP15dVcPn8jvZN/LuN4Pcylfx344ofunRX?=
 =?us-ascii?Q?fX2du6sdXZOnn8T0QML9cld3pRxKU9iO2MBtHnIUtLar505WIKtrvmb/hCcf?=
 =?us-ascii?Q?jrCrCqrFS5udV7konA09BU2bQtCqZuWm8H7meH7RX4IftEHjqAvOIfkWqVyq?=
 =?us-ascii?Q?nlBBYz9eflE/39mPLsDqDoZsvbRNqecgPqc3Yi44/cd7zvWHmfB8VjrKT3AR?=
 =?us-ascii?Q?Wue4eUY89+mku8rLbCKGHaH8FrzDAhwyAuIJOFYg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17de192-3da0-404a-f706-08ddca830543
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:23:43.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ijhKhIIaZK8/IGIuBq0fg3visJxlWNn+ETJSjb1cXggaXkoayGaVmKe16tkxCIxJt71U6NUKWOI5CCCYdlPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6915

Add API dw_hdmi_to_plat_data() to fetch plat_data because audio device
driver needs it to enable(disable)_audio().

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 206b099a35e9..8d096b569cf1 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -198,6 +198,12 @@ struct dw_hdmi {
 	enum drm_connector_status last_connector_result;
 };
 
+const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
+{
+	return hdmi->plat_data;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_to_plat_data);
+
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
 	(HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
 	 HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 6a46baa0737c..b8fc4fdf5a21 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -208,4 +208,6 @@ void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
 
 bool dw_hdmi_bus_fmt_is_420(struct dw_hdmi *hdmi);
 
+const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi);
+
 #endif /* __IMX_HDMI_H__ */
-- 
2.34.1


