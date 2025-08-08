Return-Path: <linux-kernel+bounces-759689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40088B1E121
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5678F161003
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4443D167DB7;
	Fri,  8 Aug 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NGvUvDio"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013027.outbound.protection.outlook.com [52.101.127.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566C26AD9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754625714; cv=fail; b=OKR+N+hctswJyPpQZPVpxIU1t61kUYEh0HplCiW6WDx2x1mB3VL1RoX3hc8YbqzykpAu/BmXB13aDBEctGhUS7cK6ezyBBS/nW5/4ZDzoLug8c0sOn3vKveJ/aoJQjT7+PaCT5TOFDX+CKxrI0WQEfce+sWrjvbikx/S0Oc+o6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754625714; c=relaxed/simple;
	bh=duPQFrGAkoZrEYnVc/GLzoMBDiMD1eiuEiF0JtsF+lg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QXJOtPJPQNK2QzeTBDsTO5Azsf4h8ujoOMlJKV6dnQDWUzzgkrA7F3rbmoxmXU+3+tg+6+3XOb5JX10pm2DmkAeCzrtjtIs6EgMH2xkwwubR8JILzs8IwTkbdUNu5ERMbwhIaLhky5HnAMKimMo0G95hrfTfKvgWajoPHbCluW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NGvUvDio; arc=fail smtp.client-ip=52.101.127.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I29qxWUTr9QE8ZOtoKSCbRVZrB2h3AI6H2Of3kBz29UnKeA0ELl0jLB4D6w4/CEihVN55m/2xQN2ZTCRx8Gb5FuBySo603lsa01QlQvPwMu5WQRzIZmorJmSf5g3E8k7R00NvcaG6RYlw0Ncj1XMtA8hvDKyYNnK1SQ3fPk2qK39oOKZhjQuY8+3lVWtjnZm9SyhsCqWNaSDjzDNknmEH1yQPrgnV9PttjoOdXixe1usMyNZXQBMHgD/YX9hNRpURDKf3AmWZ1Ea6VqSTW/9H5X0zurjvH0oX9Rk3+g0SIUG3buhpp28xpQvDj0k/e1yH8ncmTiovSW1BUZvO8FD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSBFh3TDlbVFyrrsJyeTDNvUakVfBnyDatY/BIC68aI=;
 b=QlUZnSWvnPhoJgAesbZKHmk+9RQr0zikMFStYbdEMTMqOjw1/WCZvY11u0oeUDR0Lmfy4+d/O9gCXXNKzSMitn5FN6em5bjyI6RwSilqW86cY+y2q8GcTHtAw532RHHQZknzV1VfmfC/y9IesfqdxsJwF/OvDDyDgx3koCqeXfsc4qWyQ4Vum5P9HSHquBg2erKEgyITpE5m/jFFHo8w2wwakMn2qo/SnWh3+ddIFbrons/0ZBM3JL2wZBUMihkKviEwR/al0I0DjJwxAneEdRV/I1DL9jJntxQ57VVllxc9UAKioBu/JbZD0CYGITOIsT7IMcQptH9rI5vwynoJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSBFh3TDlbVFyrrsJyeTDNvUakVfBnyDatY/BIC68aI=;
 b=NGvUvDioU1dryPJRQ/APub2wHlqPGWkIVvplFhGGs8oNZHp/Y6RCFMKl78acb59zdFlbVZAV/zWYHkC2Vkud1qEz2gd6fl/DsYSgxYUY+zXHm0gne8k/RTqeBI+BnRGEhLDoHlIioJYnZUFtQaavNdb+vf11qHGoHEyLkZw3DvJHE/Qp0X8etX+McUyjWrcqH2tTUJ2hVxO8oubW9nOpAll+h/J8jK3VNGUM26H7pv3zlRNHRv4zaWuDvWiyP/U3DyZ57lgjN0oEf6tfmN4SeCKg+sYE2hoG23gArB6H4UhCOA8Wm4TCE+0QGSFydOF+ovEML3MsdoeGpla/aABiwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com (2603:1096:400:32f::14)
 by SE1PPF72E96065F.apcprd06.prod.outlook.com (2603:1096:108:1::41d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.24; Fri, 8 Aug
 2025 04:01:44 +0000
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263]) by TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 04:01:43 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2] drm/bridge: cdns-dsi: Remove unnecessary memset
Date: Fri,  8 Aug 2025 11:59:37 +0800
Message-Id: <20250808035939.134861-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To TY0PR06MB5579.apcprd06.prod.outlook.com
 (2603:1096:400:32f::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5579:EE_|SE1PPF72E96065F:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c54491-7565-4fce-29a3-08ddd6304957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cwv/r5d46+oefsZv3EOcDVE29M8rVv3WtLlIQKu9AVV9RESfvPqFzrK5WATl?=
 =?us-ascii?Q?Gn1yr12LzC3Rhg8/DyWgdd63g2/FJnaxLmvzW0WLEvpKQT5gCSDIzat9zNaw?=
 =?us-ascii?Q?YyPJ2zloSBA9mb7t4LsiSAr24Ipac+rTTWmBc/c+uUbBtfJREZ69uzvTjk4M?=
 =?us-ascii?Q?iw6s3jIkX12uvWeCPmgz8DDd9dt7hCun8bI8SdjsOdQ6ojSgCbUq5pNQn8NH?=
 =?us-ascii?Q?+fKNeRawA5S7wY6JKJl6HdgRsyr3JleBIONxuDhE89U55CiF+exiTrHoVGoK?=
 =?us-ascii?Q?0KvnwlnnOaaUDJ8DjsVW/jfvtqW6afnSKiQ1U1MzdDNW33nB3DdX4RXiSqfS?=
 =?us-ascii?Q?EzTO7KMirMglDem0d46Ic7+1swy/W20Bhy2uYKdOA6fUal0ubLbvGeDg61tD?=
 =?us-ascii?Q?HU1PWjF0MuIa4++I/Y+WZBQvRbVsF0ayDZY+tC6rxAm+qy4h9+uKnUSCihdq?=
 =?us-ascii?Q?gqHRInWILDXRyNEZPaQhpPdEV87nT5BRdFH+sFPACPhg9fsOZ1pUvtxdZpXm?=
 =?us-ascii?Q?uwQArjQ7Wc+Z278Xk3eZ8N2qASLT902wHIh3+ePefDCb+26GAyk9GpQlumNX?=
 =?us-ascii?Q?2wSukbU6nYr5HU6+0KnX+ohw9pSRv+mG0r9KHEa3n8z16HfZQfqubRn5Fos5?=
 =?us-ascii?Q?5NRrwL06vThKuxxQOzZRJHGeduHlgaHyasqgu4hNhxTXhB32mcJMh3wMUweS?=
 =?us-ascii?Q?cVur/74LyKrfcSj2tO4Jn9SCgBaFGPrKSDBN+ELOCnQ2g0YmNQGLNNaEf8e9?=
 =?us-ascii?Q?11bych38Sz05Yvn51eO2/oqQLbm5cilAQJ3KGC1rADL+GBj3sXLP+ANvthc1?=
 =?us-ascii?Q?VfyjeIQYSVwZ37F8dJRePNIjzwMLdsS2jB6vZP9ak1/t5kxcWhIDtPVwA4Og?=
 =?us-ascii?Q?NHlbk+7950rd4rqFQFuW6dsttekmT0Y1n8jw/9JWwXDl/OMIwsH4l3XwBBPL?=
 =?us-ascii?Q?5KK/RsMI0PPeIKEmRZB1SrnAygymS1Hk+pkXrfJal3r44sRxPH6xd/mBzl2S?=
 =?us-ascii?Q?8uZ8HAQMmk04Qc0EDY/GiTw3Y1woZ2OX8Icq9NqFJXqG/epwDmBzU19cPuTz?=
 =?us-ascii?Q?Tlno3MK5TxY50+kHlghmdJR4UdmLwPEBVagkFd3uXV4bWp7SXRkCPa0ye7Bn?=
 =?us-ascii?Q?RinALJB1jdqb6FHIGR/GvPlLjShf7bocVuZ1D8rrhnP2zwKRqzRZecYGTMpC?=
 =?us-ascii?Q?B2zthzx6VfKP5vQFJdsq5GqxE/AG5R/hLBIg3Tw+BUVdXidbZ7GWCZlTh6Mr?=
 =?us-ascii?Q?Ne2aT6R6yBUFUOzuUnrtlZDd+IiZOEawQbSSAEn8CDwmMr0/bvONTjkaaJGi?=
 =?us-ascii?Q?wEwMv8YcoZYD35wa3uSZF/yPR3BGd8i2gRkAH22altByQZGj2mK4kWRrXoRA?=
 =?us-ascii?Q?GluLsyEpd4NjnA+98DRxJmTSR5A+y0vkZs6fsOEc3DqAF+m86+K5G6LewSm6?=
 =?us-ascii?Q?rTvz/gfKTzgXUVB1fna6+Llh5P9haUVfANfph4L3tk6uYBaYhOHKTmMbznkS?=
 =?us-ascii?Q?0R6Tjae9vCj/0Do=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5579.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JnNLQ9If/46VtHxqZ9zNEX+rJU5+NowkjyjFTbp6hE+SPPZQjajyNqmDiuyb?=
 =?us-ascii?Q?RRWK8tf03nE7SFCUvuDJ6oizZNH5TZqfAfVHM5AoVlO0dTnfF4GgXPlc2AmM?=
 =?us-ascii?Q?SNOR2vwk4zTPCTwFZJ7ZhLknEYcgZDkFm/Ky8IYDaTBXcJPYcV1NNeIz7S7I?=
 =?us-ascii?Q?qbinuFdK0op8uqByIDIXrvePc7RO6ZrVd5Ur8IwCL2h4hu3XV1Yil841L3Fm?=
 =?us-ascii?Q?k/OVdsYytXalSDAO8rKro9u06qP8glZ7fswRfe7yVD4EcR7zr0m5/jDN9DI4?=
 =?us-ascii?Q?ti3j7u5Fr9sHjUUuD+0M2w0LLsTjJV9E8J1iT7X6U1sqa3QQjoZ1t6oI2sni?=
 =?us-ascii?Q?Q9qg2Xa3tKe2p7zTBKAn9VX9UonwgY2v1siRImL2RvseV6/ZCm1Bc5HvVjEA?=
 =?us-ascii?Q?oJ8zsKtD5ZGlLVwnxePZ+PYJ6cWPUPHiCGlArPVlixFtQQTDt7jNnGfxksDX?=
 =?us-ascii?Q?1AVE1axBvOIPpqEWD5U6S/DpannCnN1G7lfRReodwD7At1hvcLf5vK2+MlGb?=
 =?us-ascii?Q?5rxNOJCY1lUlECwujUlfTkDoqTQAsCXpj2jNeemUO3Ol07jTqcm54DCIBnCa?=
 =?us-ascii?Q?fOYx5DHYIRI+rcWmg6USNVu7kLnoUA8eCc6XH3h+yfIJXxOEVdzUjFKnhzkG?=
 =?us-ascii?Q?GfURWxS0lnmA5YwBTet7YcSjZRdKmuEEOxrF6lrDrxizazE9+JEoQowUq84T?=
 =?us-ascii?Q?gsFCoRVNxz1VJjbCrl4fYDYbkfrVXTBt6NYyVuHuYzzI9Q+lJ/8IUII7HTLh?=
 =?us-ascii?Q?cYZDuigv4UKXa8E4GRB9dcEnhGnleW4AeF0J+oNIuSHrt9k3umH7DaVmKiCb?=
 =?us-ascii?Q?L0H2j7WgSgFrnZPxkvqizervMNeUWJYeot3+VlQViP00AJdlsbdCsY6+dhtU?=
 =?us-ascii?Q?5ihuSP29w58ZVHTm3VbdKlNghzE/3SsHP+Kb8nH/nFa3UtPUReSKQqVngA+6?=
 =?us-ascii?Q?Jy5nDXwecT0YC1+MaBr4Kyd81KYRoTLNxIN3swdOoJHg5tXpj2c62nBRCdfD?=
 =?us-ascii?Q?Bz91oqF/ZzC6LjwLN2bCZ/OdYTYXp3FWqoqW9dDhv/OM4dOFxkXJnC10Dv4n?=
 =?us-ascii?Q?s6k8HfwWAzKt/mpDsRlp0rhmuC3/Cq+EADfTX2fX8OnHpLNHxQD9kq5kC3+f?=
 =?us-ascii?Q?3AEJWoPNCeZdEZlvIV44p1YMlkZSW9+1bjvdo2HxAbRwhd9qfTeCOWbCgXj4?=
 =?us-ascii?Q?8bxvlGIVKwgdaGxU4arCZPCI2x5ZNxQWPEmEZYss0c9I4PXf9UiNDoATlQU0?=
 =?us-ascii?Q?ZjucBgyvbb7b+BHe2s8xRGirMNmToU/Dr7N+l6aV3ZogJ0evEe85r/H66fIe?=
 =?us-ascii?Q?EfaUX+CJ/NoFRfKEWSs57DRtK0xDvLpNeOMRj/U0s+/2OWKZ7SYqZoBOYJaK?=
 =?us-ascii?Q?+OmjCD0JiWQ/aqdI2x8zsAlZ5l6HLQP1N/BGkmrkLGAUV/Wm7qCat6BBLtX+?=
 =?us-ascii?Q?1eTQiNT7fOzKt09H7HQTY/DMPsMM/DMyqktVd6ibDcpAptx1X26LH/HtKL1M?=
 =?us-ascii?Q?MATa4qN7LWhw/FF1PvWq5u2EumqEJSifZUgBPgqb9niNBnPcW2//7RdBgsUN?=
 =?us-ascii?Q?FcnTBnK8cR98UaNYehPMst3DIfeG6OvtRcnwUDjK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c54491-7565-4fce-29a3-08ddd6304957
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5579.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 04:01:43.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd6Kn8tdMQMtxr+LMvZUwsOMT3cz86Hnxw6GfwMbfFDNWPfLbQvgN2WCIZSleiq1Fer6tzznXn2EDb3lKwTVIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF72E96065F

kzalloc() has already been initialized to full 0 space, there is no need to
use memset() to initialize again.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
Changes in v2:
	Modify the subject prefix.
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index a57ca8c3bdae..590f7c75744e 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1047,7 +1047,6 @@ cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
 	if (!dsi_state)
 		return NULL;
 
-	memset(dsi_state, 0, sizeof(*dsi_state));
 	dsi_state->base.bridge = bridge;
 
 	return &dsi_state->base;
-- 
2.34.1


