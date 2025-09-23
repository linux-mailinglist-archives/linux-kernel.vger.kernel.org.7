Return-Path: <linux-kernel+bounces-828331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E080B94693
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348B47A95D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8EBA34;
	Tue, 23 Sep 2025 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X6hruTum"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836130CDA5;
	Tue, 23 Sep 2025 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605463; cv=fail; b=Xj4VPFBZb6RgtkDlcHnZgIkkNGqLNHfVOfS74JOhI1iQtTb0tzMCi0i5BVzz5F2Me7Us/w8FnODJ5sLwSgAjd5F6qc3+FZRcpH1T4XsFpzsjo8wPgofg0FzHnI0Lk0eCb0uPjXNPDQ/9reltC2tlaS5unxibDtKzqOWpqHOWLoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605463; c=relaxed/simple;
	bh=Ne+yOb1RQkYJOLda6qL4mVYr5MNzoxlICGeRJscyH1I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXW+T9p6JC37lHX5WwxCwM9ROclV8v+ra9+AbkGZt8KlLSoXFlZf1rMAPgvwjjX3fmAF3pJrXhYjkqA8WI2xh8PcDYPVSI5v745ZfMyG8EZxbBhtkItNocOa7rLXSfXw35Vhy7zfscOa4rvlv65GHJMh2ZoQzN3ZlSu/eLzq4eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X6hruTum; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTQ9J/9l5YU8AccQ87gIKXfWwDmnZ9DsP6WRMqtcYCVOviPSdapWjjnEbpPhA78z/LjijgUh8DwrFdnbOtNNHMh11uBz7taxxeDHE8o+jnT4DverKpPV3EfJexmy102b02HqKq1njQF0sJX2YL2krzi4CP7a57U6qZ8Ecc2waOoWHjLJuvj8q6cpxevjO9BYbOWEsFNpbXnhTZ2Q3NjsQO5xL4wDYRxtcZiOWF7+gJqGePTEt2p0/2xqrz4ylNvrjaQOdxViD7AZVuk7cgG4T2t++ke2zai3VgejWCvgV8K61mdnnkQ1WJkOw2oj9b5feUX0Uv7DO/yeuRnsuLYwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HI67jN4GLO4al06zY3EATYzYT4JGMkxxuF/QuKMLr8=;
 b=HJ0sp4+DVErAEB75QgeVKpQVfmqR7zzmbWbvDbCUa5I8bDMTghMvY+qP2X0Fvva/i7R9ISeDt17fcdL0vKKA4xcUyGzOFn6gTA6pjnyz0VuIUs/3TOvu/0QNQZWT9HwPh9luv/rLX2ybK0LxrUtXdXSuku75WXM1+J/ct3FKzGB68nj0VctmEYQOoD+WGDoG6hxpzKdktazxZ/wNxrjRh3gSOcpAMzhuWiAHZABThoCcVtZyK7sBgPI2Bf64v1401j0NTvlmKBjjrPLNJPh1m09oYMKRfzcvGlEyAWHEh2w3Od+B2w5duBJ1Y/4jAtPSuPryRjaCdmPbNaXhJ5llzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HI67jN4GLO4al06zY3EATYzYT4JGMkxxuF/QuKMLr8=;
 b=X6hruTumedgRiPkC/iG2tSHXDGtlH09H2H3DIVzc/gIKjGAyAfCJ9wEmUCfRgOymji++15fqBIqFQc1vO7xOpORvdDaGDLb6ductCiXvZxpcRyDuyZ1LdwIBlIx6iQBIp3C+ZQG5vloQk98HrFm5VR4fu1kLncuOuIA5XAYwMjeZ8dLHHgBfL1+/BEIU7S4EIWB5B6QiT8tdgn3AEjDDh0y2atnaZ6BvLAvFEPcA94IKO9GPl5pK2AmefkdZ9JrUKUNBIqBylkfmeMwpHIZTvAYVxlG8qyRo0ecrkdEzaUnao7EAYEYovSszY+IOS4Y3jGxiYZ5ft4PJSL06fapyaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA4PR04MB7920.eurprd04.prod.outlook.com (2603:10a6:102:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 05:30:58 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 05:30:58 +0000
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
Subject: [PATCH v7 3/7] drm/bridge: dw-hdmi: Add API dw_hdmi_to_plat_data() to get plat_data
Date: Tue, 23 Sep 2025 13:29:57 +0800
Message-Id: <20250923053001.2678596-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA4PR04MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c210ae1-3156-4109-d02b-08ddfa625fd8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?tq1q30b2scMZkR4WuJA7gCgpBJO+OImGEbNxhEusyV3cSz8nGQ8i9yWdHRf+?=
 =?us-ascii?Q?QQ9TZHLiMl60u89OM3ICmBrXW12sFpcxxxO0hz5GfjsAeGKBw7lb1NTRhHVG?=
 =?us-ascii?Q?9ISh5TwUlwA7XNj86ihq/hX0Al68MvlTLLShMHjSm9zywPyK79SvMRczGDQD?=
 =?us-ascii?Q?9l62TSjFyc/2njWn0QNx4clGEX1JSRlr+fx8Ovl2lTY0BUpy3dI/hA08V1kT?=
 =?us-ascii?Q?r5SVvWYt3kMtX3vAkcOK6Z53ZlMNus7dHiv6KBB1yU3JzcRVk9WVGbyc9KUS?=
 =?us-ascii?Q?m3PvgdHVukXtOVXq4QDHtCSPmDMgjBeo5UnYwc5f96IJZfsJ0Dbi5T6NnvgI?=
 =?us-ascii?Q?a5eX0qZGZfMKieK+YUOL2eBEDNarvAWRRuIftg5IuMfB62ytv8WfEr90TpJs?=
 =?us-ascii?Q?5u63VOEeAN3MhFeZhcVcQRjMWNl1AQbYdtIYoTlThEZlk95Wa8jF5IimvzgF?=
 =?us-ascii?Q?e6HfbQa1u1Ql9bQCTxSzuj26Sm576HlTKTITX50i87v5QxRGMN3gy8RSdTZS?=
 =?us-ascii?Q?ORLAdC6xCvZljZPSW4/dPtpibfefll+1v2qTFzU0pxJB5FtxfLpAChrdjmHx?=
 =?us-ascii?Q?JBJKtX3d2KfY/bmjmYGjMfz8pS9gNAWZHtsvCXDEF1FSp6RhoZMfqbWVHgjR?=
 =?us-ascii?Q?ilB0SCG2K8sI5I3o67NKuxRROrD4nytIgBFkM0Npda74+4SqWF9vdP4X0x1C?=
 =?us-ascii?Q?jKdL7gNzLVay4eyFvusBlkpB3FfBmqUBwwLtOw4GXJwwONvi00Z7BTe0T7Hh?=
 =?us-ascii?Q?V6j5FLTnttlShm5BRukF8YoVeNDzzUx7PNJQ0uBVC0vgaZd0XJbtw7x/cB56?=
 =?us-ascii?Q?chvDcLEy3KpRKI01FlGlWeM/VRnKf7e1uE8ZYPSRhpM0R2ML6dnQJ7qtB/Gu?=
 =?us-ascii?Q?JQbrSKTcgyUw7hEkEzqQQjgCPjOmJ2BVUqnYQXvyFZuSFQpK7X0fBc3+mAlA?=
 =?us-ascii?Q?h7uW8dpkri1NJWOMcaScmja+v21YdgZobj0bQLfKrg2lYACkhc0IvuAqE8Pz?=
 =?us-ascii?Q?adoM8un5kO8rszmYBaxY9IFoBpxbAo3T61b1N4VwU/aNLG0uH7FtQxL4egZL?=
 =?us-ascii?Q?7ngj4dHCpdNMOrzviuULs01zeYAV+9OVRrA/MHgIOuhN+4zoo9lql76QzMjd?=
 =?us-ascii?Q?UZmoFhT7AF/1R2gtC1EAa4ucZfGEjbZ654LEUtizCuCkDkVtPASI5BLsvWUd?=
 =?us-ascii?Q?JwsmAaZlYGoZthEwd+m3byqDQuexT3t33mDF75685FaZOnBpJCbM0XyOZ5Or?=
 =?us-ascii?Q?6w7cyeCD9IUQdK4RRKW/ZROb4XX1iSpOf1pDq10li5aPZlVHThcVWfAxGTIt?=
 =?us-ascii?Q?9RGhqnmfeeVdbrzKV0YG6EDIP3SyuOGfYmYVzqEoQk4cEHXQJ7g4cCKrJJFw?=
 =?us-ascii?Q?1qaHmbV/XRZ7yeUEEx5WHm6Ma2Z+2hE5BjDw6N/soN14NmkFIZ6veAf/O7yf?=
 =?us-ascii?Q?AumnGJpzTCEOy8tbsfOiUId+1y/uUVZm7BxYQRqDrBK5qis2v4fiFTZNj+qM?=
 =?us-ascii?Q?4BKItPZKEkzcoZE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?mKv9POn+Z0Wj4yExFXLGw2kVsTgQEHJvStbDVfB86OiMwgT3SpVKpx5y0X7h?=
 =?us-ascii?Q?+fvBonV2Wk0wzu37X3p6xwH1HHBQKPeltM4Pfse/vu/kiidQMwwqA56jIENh?=
 =?us-ascii?Q?88u43mjOFWFJ32OptG/AASd6Vw602wQE7nL8kAp/G96+iSiwyc61e0WogTjS?=
 =?us-ascii?Q?fokG6VJnshJ56zn4nkvWZyXnZ6rFL+c16BAqR7fO1doJUpeYsq+f9+hkWxgr?=
 =?us-ascii?Q?CP45b9WN1RJO6kwl7MsMKVIOGNcUOhzt7XHkhtfuNpxp+jc0oB1lBbmLnMW4?=
 =?us-ascii?Q?mr92uSOpspRfCjKtEOiAP6qmuDQZWkmzcmDh/mI8/8xVfMJiZ3hLiQrCv79c?=
 =?us-ascii?Q?9414J1MECPovalYgPV9zyPD/WF+f1fTBW38bp5bk0SrOhSq/TlQtxw6ZNsOo?=
 =?us-ascii?Q?yduk+KKu8sE5q7NOgIGuIzv1KW11G5DcGyjULjNDJEzjuPPqLKCgzB9So91T?=
 =?us-ascii?Q?WMxATxCJ03m2ftD6ZQwbiUaecwutHIrmqYF7BMS1ikUi73ONvTK1513F2SHT?=
 =?us-ascii?Q?f7sWviIebehqetNbK8Z6gH9iuQpWDu45KYg4sIKqIZ03BciuceF1k3OeGjj4?=
 =?us-ascii?Q?ang0qXQvqXsW3JReQP41LJcgY3LsWsyxQGwstZnYs61hvYag6EpKhX0yVsHM?=
 =?us-ascii?Q?ZyalxnAb69RS3X6gRa3UC/3DoHLZkzx6s4oV44y+5ob2dzexE7EqeNrgXhsE?=
 =?us-ascii?Q?tknmqjRb3U/NRf9TEeB8AX/tLdwqvmLcS5yONr77PPjaGES9v8aN6RZMLM64?=
 =?us-ascii?Q?5O7nVgIPvPKN2XUgxzFqjiGooW4pMuReWmyU+koWdXq+oimWgI9njgyTqkTP?=
 =?us-ascii?Q?zmTiyuxMits+3fgFiC34RDOAtQdgaelaMvFwLwJknGlVvNQxK9F8ozT10+et?=
 =?us-ascii?Q?VTA6Gn38rOcnRETG71s52alR6315Se8B9ayGztprZfXYR2GvBgznSUtwveZE?=
 =?us-ascii?Q?/sak1Iq0LSSImg3cmMdJrqXOwHvp65F+H5FAjiu12NXmAlTzauY8d2Gfgitp?=
 =?us-ascii?Q?fpxiVzMvfEdicJYewzr8qlcDPPTirZVWEJYu8c7EStMfLfuGojKdzzue7dHq?=
 =?us-ascii?Q?/5SXbIyCQf/bNOLXBxaD9M0lNDEjDlC4P0xc6zKLqKjkQGhUzT+LLAFfUHqO?=
 =?us-ascii?Q?UzS6wgKn65sbzzNkHFZBdOCvCML67G7UjSiFTaTXb2TTw+WtIxuiaKmJBs/c?=
 =?us-ascii?Q?Q8xS13Fy9rv0WvPz+FnVMO8Q5BLbeXIYG2S2bKxLa/1qTiy94jPIft9t64VV?=
 =?us-ascii?Q?UnGpQWrRb2pE9wLRULS2F2uCEu4IxXirvNq/566YUiLVTCXDrSwccvaknqo/?=
 =?us-ascii?Q?JbkgSAj4bTojFWJcenQacDEmJ0gJKLqUAJc1F7hWfwCT88nMNsAl4drq+zfW?=
 =?us-ascii?Q?l/2RspEgSe4idV0sVauGLLolwTgAfCbJxNkw98Fk+QscCtkP1Qo0Fsmqgqx4?=
 =?us-ascii?Q?BivQeIeDZhgPeJl9/BIZibCwzdaDJTajWUCyK5IKdFyiWdX2GiGddzbhQ+tu?=
 =?us-ascii?Q?wW5k6rsKJIra/EWpYrXPejNQZ+171FXTfgFHw7n51YYgIfJk0w0lzrVqEvtM?=
 =?us-ascii?Q?7WQhnV1IFl1lAo2cAtZeN0IXPUWjI4/Q4OSmmABW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c210ae1-3156-4109-d02b-08ddfa625fd8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:30:58.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X8KYYkRXC4+l1Av4d7FGg70Nl7QF7NQZEg0vAA9ECGd+3QGsusJmh0+UurYN9Ui+IOJ+b+b60Lr/8nxKMKIyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7920

Add API dw_hdmi_to_plat_data() to fetch plat_data because audio device
driver needs it to enable(disable)_audio().

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Liu Ying <victor.liu@nxp.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
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


