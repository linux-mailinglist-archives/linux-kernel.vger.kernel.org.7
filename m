Return-Path: <linux-kernel+bounces-786148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF75FB355A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB951772D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B1242D65;
	Tue, 26 Aug 2025 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HX5yOo1/"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012004.outbound.protection.outlook.com [52.101.126.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66569393DE3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193375; cv=fail; b=SoLunAYAdfsb1A7Q7Xldog6e/0RcJymS+AcawKsBTOO8ToNyGbG8XjBAWWr3Y8X/Ea6bcR7ysqcnV3QO7FNlwJjlmADeLhjMHVjuXhK3WZUAZ/c8Ruz3YRxNo9Kodrqy/WNo3GynmdngJ61zH6ep/atSgvnPoVBsCogtHaM3CPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193375; c=relaxed/simple;
	bh=YmwdlQD+/3MPylC3gU/PDJkAqwChAZmY3HOagUttzqs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=epG/3h4vgGu0l/3r4IY8v30u/Kr2ewC9hC+cYUtOPHlZ/MYUVU5AqBra7KB2b/WrEJhPa7RQ4QsWhPX3Ah3VgFQUp9qL4csLDcVN5vNkTUgehtplGWYGugTdEc28nffPWfwXeQ156EvyuXRZEGhSU0JO+/VV9aZjAbykAt+PVMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HX5yOo1/; arc=fail smtp.client-ip=52.101.126.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weiuuOkvsHWhxAAZxLmR1FbjUz9dfrzvFcjBNRzrpT8AhgVJ2r51tzNFE4/cc8IuJac/Ra3wMqo4khY6dJ/UTsO1scku/k88slepVdjZOBywIbcyzVyk56AGjNAKc2xTMAyyg8X194hI2vWGpDxtBkcfN8jFi2ilY4uzjCw4Srd8ZlnTb/hjF5DZqLhiODSNTmnBP/GaOUS9PtWef8hPuqZDCZcGalDOGoeu6wWPzoEvrS3pq8AJkS4h0OK/4vGo2+W3eVPAYk0tEMzfcMx3ym5Azp+BJzUiAPZpIym3U75zWu80duEfM1RuggqNWY9dVpeA7FSro2geaZC32vsDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vi/tKpVg3Z0cgZN78kKDa7KgQ9PNgQwwn4PiKjRIkU=;
 b=edwanpzyliDuyIiK+WlG6dB2QB7hRNvZnPMI6Aj86HoIffYvPXPW/tLBsmvsiejuxPFYn6ri/BSgErnhouuiojD90RaUZyhOIChmoJDTeMi5l6S98kZ0PUDrjxmO7KRcXVxpj7nPxzqU2QBvn1LNfhhBeRhfyxixcYtfFzxYs4icPW7RC/sXi4vwE9w9cvYj2vkhZ6GZLhOyQXxsfG9q+ogcICKV7Igsl5cBi4zzp8Htb73uHLSfOE0/l0TGuGVXodQf1rR9AT2MWnQbwPOzXg5DENI+xoPOXzsqjnJiM5uw7/22hax7AQcEzaLplXBd4pY/EzfA7SZ0N8QR12k5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vi/tKpVg3Z0cgZN78kKDa7KgQ9PNgQwwn4PiKjRIkU=;
 b=HX5yOo1/mVZwm8ot+XPTHBGVOKuLmvXJ0RWfSv8q7c35AJPljmioB2fOpH8a98yGMetfTHm9Y9FCCoaKWwX1CVK3qwxJ6cARxCHyg0i/WwPPiNN8eSpRiSPgt58ubFD4MYtZXPiV/oAy+xbRcEjw6DEeokGdiQaDOWCJ7fFE5Fg9PvergnHnCvdXVSDwrq1isgrn4mNvUyMAAbrg1tTlorif0oRFRiYeRWv9wrsEBMiMh/+ITTdIFPwWl6bokVRkzMSQCt+aRxvEm+M46d/Tc+hxfaFnP7KBs4Esn0ALqcGXxtsa+2YupJpegp/wb758k8t+27Hs9x7+fT9QCzerFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6409.apcprd06.prod.outlook.com (2603:1096:400:411::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 07:29:28 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:29:28 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Min Ma <min.ma@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] accel/amdxdna: Use int instead of u32 to store error codes
Date: Tue, 26 Aug 2025 15:29:17 +0800
Message-Id: <20250826072917.186638-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c86ddf-5a9e-4a54-c28a-08dde4724a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7EAqzwMbbS6bJgzoBGAtawoCU2zGKJ0iRgKJm5/geMspu6ZHvTTPHlqHWg2?=
 =?us-ascii?Q?dA02WTSx6ZV+wzxmV3AnuxteWn2FC647mEfzoAnMPl1Ls9lnQJSqF3cW2fOy?=
 =?us-ascii?Q?LqhRL26VsWpBOVO5X55DKMkjqR6U49we+ARSny4DwCUvv8jGVgWhVE7qBmbU?=
 =?us-ascii?Q?eKgiRh1oUhgHXI54jajAeNGmg+IBvHk5Xm3kY1j6gAO2xjST3reQBuNZIxGB?=
 =?us-ascii?Q?SDAPOBkQkGZW0eUuIpR+Ld7dFzHZAPfl7hINEQMda3ZZZ2pCCaVfNOkpcz8V?=
 =?us-ascii?Q?opnda3tXW3s1kBsEFh30TOiCXbz1AOReA95VhuBnFrKPKm5XK/6X4vqiOEMK?=
 =?us-ascii?Q?9i0vGa0NrPzzqdztrGjxus/jKGe1JFsqRBQ2JCYvgwSfijBqYGOQK6o2UTN/?=
 =?us-ascii?Q?47rpNZaVlGcZBnGD3IcoMG3CshzKc+loTVTQN4Ln5asmf/itAyH5cyu6jUms?=
 =?us-ascii?Q?MugCRiMVqbbiQqXW6T2ZN9j1kMvc+/KFwC7kztxcTuwigeaGcIjhFaAxv4ED?=
 =?us-ascii?Q?e9i4H2fsy16TvotyqbkcUXY5tuattWtF9U2Pv8q/loCDX/zF21ghYExROlk/?=
 =?us-ascii?Q?Tr9QcEwjU9SDS01xgix/a9LwR9U5J6R4yrDPkXaM6VCsz28RsQL0RBLwMJGD?=
 =?us-ascii?Q?fKR8xY1AJ267bevC3ZJ8cyyAR9jmGXIl25xpITJ6LVhYIy/YxLPlWcK+9FBM?=
 =?us-ascii?Q?kHijq2y7wnW3s4jDSbzLjOdxmHtyhJ/FeUOWerp4eZQ4kzCuc5vQE28d4BjP?=
 =?us-ascii?Q?oauNcFJ6Ri/+Fh24yH+fJtAVcYHeciRMiQzJoPJ8ZrvYaylvEVNM6qqDDDoa?=
 =?us-ascii?Q?xr+wFdLEdvP9KM+VbXRzf+asclBSOhB6CmxtD58zi/rqNp0zFOt+VyzmknjK?=
 =?us-ascii?Q?/BVMcasT6SctbJYfBVfvF8NqPhywhWHI7gKf29xVVl5w4RhtUI9VnYcqkOYU?=
 =?us-ascii?Q?F+x3LhS+jiCOvlu+Q6gbLNuzIfG15ITqcN2wDftlMxRARh2mickv5CBdAclR?=
 =?us-ascii?Q?jILN8TFjYjN/cmU2JZ0zt+Rwzbz8lG8/RjROFMpjZNuVueA45Risgt4SvDzk?=
 =?us-ascii?Q?vOB+UDcrpHd+rLkzaszojSj0GlEARkGbuQPYQWtP3N32wOGCuTicOMte0Nhk?=
 =?us-ascii?Q?shaqku+CHqGEV6vGqQrAyHVquw/pNbVuL6LZsDEXGgurbVSIQVUFxBC+pkzl?=
 =?us-ascii?Q?qysVpHjf0wRLJYG+nTrc3DW77/EWjQEPobzavhx2vMyFCcHkGLGmx4l3XrTX?=
 =?us-ascii?Q?EV7g1fBM5lmjRzmo9q9vPaVYWtMn6ZXNIQeuScnt4jiB1ChvdjHzpN4xmWdn?=
 =?us-ascii?Q?KIxwGv2kcPiv+ps4RqyZ0s1F1Ob5Pmqei82B5XdzxXR3RARBgTQGLNiexB8x?=
 =?us-ascii?Q?9L/lrisxZisD0DBq0psRZx/9Kb0f7NOOF0zCb6npen9YSo2QKfQYmsonT4IT?=
 =?us-ascii?Q?P50PAbUZjYmm+hj6wRz/I4LkKtPeLCASTnrLW+QF73y86mZ0QRv21A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+IGC06Lr91dS+b3k9DKgiPe/Y9qRZqGjcTJwQfiHmx1t2Pfcp/qwElYzrhW?=
 =?us-ascii?Q?JvyICto/Vk1TD8KmgBXpUQBdNLHv6qHYfHqdaWp5iPS4Q6djUjaHQFi22yhE?=
 =?us-ascii?Q?hWG3OK8DzlEOEVS6X4C0N3ih0oAkN5LduuGPHsXZwEzWHL1y+mqze8o6jPLb?=
 =?us-ascii?Q?AgHpnTsy3A9vr+TPhw/nho1/RvL2KFjts5Oabkzu8tJwBWV7c5s1Pff2OPG6?=
 =?us-ascii?Q?krHBh4txzRlK1uI5J0Bdi1L86Ffell2SCFyie4uWYrnrWRWM9j5QvSPS1eWW?=
 =?us-ascii?Q?9Qa8cFbmSX8YHYqscWjFwmjKyDqfF2HxWLZ9hk7C8uOa+OoEjE6agWNqO/Tf?=
 =?us-ascii?Q?ORK5Pp5bFdhleMIUqqgHhYa2k+gFhcWL4OIPzsHjomOSjTZFRdpVMhY1jIe7?=
 =?us-ascii?Q?iphnwti4djkzsNB8umOCfLpn5oEI0I7pbhwJ5z+KBIGBe6EkoyO1EkTqpBQ2?=
 =?us-ascii?Q?WuqxeWoKGlKJKe7zXw82jZncgxjYS83iSBZzB+KWxY59fNqG3h+7V8TN7yCx?=
 =?us-ascii?Q?18NsW4hzh28TdClbNRnVG9c/t3INJcbe0GPhsyf8AYDBrQSyEw62e+CMp1wc?=
 =?us-ascii?Q?0A1fyxO47oNY1dw4bT6s7BwsyMma/R/cHkMUAohtL5qrUJMXjX46DHId/vXm?=
 =?us-ascii?Q?eoBElf34PB1WDQ1iYZHvGCmyl3gMRcFxhRgb+Szt6vD7NIiytXekUvdUhNyH?=
 =?us-ascii?Q?FOTPcgoqthNlGM5/zwKCoabQhBQz/oPMmigXaOXItxuNbAdRjQd6r7W5twnx?=
 =?us-ascii?Q?XdwvHbOG1zJSHm6edcvgIUNbAsmuTg4YZyrzSBc9Yn6eclBIl3qWzyKDQ0BM?=
 =?us-ascii?Q?X6AFWPYi6mzQXYKf9LX6UH7bksFAVXNSlCh71Gx93K4HVsJlRzv4+60pWhGw?=
 =?us-ascii?Q?16iiWj1myFMInSEyTl3BrZN+4710UAsfy3exkv3bSEJ/mcwZHQSS1BHcmg1D?=
 =?us-ascii?Q?NlfIqw4b+a3rT80b7HXC63oYxv3Fk5a0rzR+datfTk86aj2K2lvDWp8WsscG?=
 =?us-ascii?Q?5GB4WWh5Bh0iPznTN7XuMwUZ2a9NRs0aX/kvI+I5Qqpmwp9wMKbKFJscNPZI?=
 =?us-ascii?Q?AzPGo/bRT8c8TJ1jY+XQYRHL6izEWHxjbkyBBTHwvJQ2JTeS/nHUWZVfeZGW?=
 =?us-ascii?Q?5DBFtElDG/ib4NEZYnti+2ptnN3+igl1ojpXar65m/Cp5JpPt/MMrfqsLPc4?=
 =?us-ascii?Q?t+F8LZEjjHCqJjP8BOAfXhePmCrpJyoGK20h7uJ2LjzdXrUGzC3fv6KHDsaP?=
 =?us-ascii?Q?8Acm40SdpbP91N0Raza8uwdUTv/hBlA/bafduru3YskGplQKk5/Ypkhlqv7E?=
 =?us-ascii?Q?rcBnGUhbNebdeA2C/N2GlakNhfNzXxeep0LzLSLk7ZhQFS0P/LN3AFBKc4YY?=
 =?us-ascii?Q?TShSNr81aPqiGXzXV303Oltri8tnn5l5pm2JeY56FoQc8YuXnlJFoK0zSLfu?=
 =?us-ascii?Q?SOGMGvm6j3aWeq9e012heKm3IFbyseUaa+vxr6T6+EtKOwCue8V37OrL9LpB?=
 =?us-ascii?Q?AaV2Q1QaLdBlPGl1Zd7ha2LbSpQg7DxkQ2HVSncfIADn2+r3LobP569xavmI?=
 =?us-ascii?Q?ng0KiB/O20eA6by9x7s51gJa9dlPHNnIZ+eWsZFd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c86ddf-5a9e-4a54-c28a-08dde4724a4d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:29:28.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsdWMpDVgYF7XK1D/VDaR1Uztx7P+6GwlySCgclSZRIzQKQ5qFIw3Li6/u5qK9lsvQCgyol/XiV3s3bWzu+Lng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6409

Change the 'ret' variable from u32 to int to store -EINVAL, reducing
potential risks such as incorrect results when comparing 'ret' with
error codes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 420467a5325c..e9f9b1fa5dc1 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -199,7 +199,7 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 {
 	struct amdxdna_sched_job *job = handle;
 	struct amdxdna_gem_obj *cmd_abo;
-	u32 ret = 0;
+	int ret = 0;
 	u32 status;
 
 	cmd_abo = job->cmd_bo;
@@ -229,7 +229,7 @@ static int
 aie2_sched_nocmd_resp_handler(void *handle, void __iomem *data, size_t size)
 {
 	struct amdxdna_sched_job *job = handle;
-	u32 ret = 0;
+	int ret = 0;
 	u32 status;
 
 	if (unlikely(!data))
@@ -257,7 +257,7 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 	u32 fail_cmd_status;
 	u32 fail_cmd_idx;
 	u32 cmd_status;
-	u32 ret = 0;
+	int ret = 0;
 
 	cmd_abo = job->cmd_bo;
 	if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
-- 
2.34.1


