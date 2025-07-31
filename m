Return-Path: <linux-kernel+bounces-751743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9025B16CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2A5A5FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398629DB61;
	Thu, 31 Jul 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eTzHsBN9"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012055.outbound.protection.outlook.com [52.101.126.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA819CD17
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948509; cv=fail; b=PFJIHB5YlL2pCJgzBracpfPv5dBBUiuEZNGZuz1l6rCKkMJ/V69bIAKws7VufNT34a8hlaGywZQqANuyzV4nddbUnORfskALp/60HkSbkg7irUmUmqb0lkIby77jMv368gKKS6AySzlrdHGoR73xzNXoH7GH0UAdwv2I5FEJ2ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948509; c=relaxed/simple;
	bh=0lCfwINdmhT8EQBAQq4ppiqNReyzYg/ttYzMvJ6ZTdU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cmFRKMyNoyEkemm9DTLX6/iEDk4OW4SUiuZEOKe+Hl/NM/NkrQy7xUnrtcYfOAnL8q0iDO6s1OmwP5i6s+mAtK/26cyJcMs0iX3aZbXDlSNms88s7V/wN1HIU0SRgZmlRVkI1im64aRDZjGxl/XkoJgvpF+Hgwy7H+E18m0gA9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eTzHsBN9; arc=fail smtp.client-ip=52.101.126.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXJf6me+7k6Vnvm09C5kbR5KEVfBoykvj693sz/h71RLhr79UGNvwg+1Czx1ZG3SrFOU6Eiz1VWgCJWky5ofHZ1o5X2fyI85RavMng0CS6ehvjhzcicBvAKncuz9BEsBmO9QHw3JBa144skSewyYD2cfhnGA+DgckJODOt4D2OYxOy+l/sOuYE9S+ckd+2SqCiyRI5ySL8gEDuZt34rOcirs+FDt7q23v1VvBrp3++77BK4BY5QypUHPY5zvIKWbwcvdW/w+ufp+9MfyPWDVr6n9ySFS/tLbreMfboMts5FW5B4Csi7fwvgD/pz4dV2FCbGFiPU+WtDUqnJJArj/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwgXK0RvEiV5p5SnEBt02Sfw2K5rfDxEf2dS6Ax3QNA=;
 b=H+nv3gRKkkLtmsSZpb4gFjchJjW7FEiASwo9VCE2gU2mPqUnHOExo632nvuu7B76jRi/ecJqt8QK5EqsSujmQSE/8Amw+6Kg83b6g/XzepONt68BZn8DQ6OTO0MRFbj0TDq/nnHqGbo0eMvneZPhk1cPZc22+eVM8xfDxw2fKxT54yq4bJg3dEg4Pz79U/heIG8BhQ30+UZU1nKMoXrLjRme3tP6xvsukN7C5UZ5Id4xUxqAq/HfYlkxc1TmcuKZT1/LcAPWztYj9HeJ674YMEmms5TeqXH9324xc0MehbGqz8sj6YVgWmk4qWHdNyrbm3yBVAWXFxc27XuMOQNwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwgXK0RvEiV5p5SnEBt02Sfw2K5rfDxEf2dS6Ax3QNA=;
 b=eTzHsBN99xeoacT/zIrlC4n0z+jBRiDYzzXepvw6YkeuVR4w5z8Kz7NOJAk5KORNkiSjM9PVEmDWLoP7RXm9aHIcSfNSsBnCktDguJuuqzmSup31SYojhxl+uYhBnwXxKGXPWfZbfxydRsDgFIxJbKZa0Lc+k9lucCfvSIbxaFywYZikFMgUKp5pY/vR+gRQ6wgHws81sFe6HhI8oHNGKW90/kHDaBdCBRVA+d11AnuPGfMk/BRHFvxoaFWlVdFvGNzag7IMT1r91jp5TRo10eMqr9OKR896WHbX5WX6kfJy60gbHnzogtcyL+z4tVsjJ6mJJNklzctJpDAtVavfoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
 by TY0PR06MB6801.apcprd06.prod.outlook.com (2603:1096:405:12::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:55:02 +0000
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2]) by TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2%4]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 07:55:02 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: siqueira@igalia.com,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] drm/amd/display: Clean up coding style
Date: Thu, 31 Jul 2025 15:54:50 +0800
Message-Id: <20250731075450.626428-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:404:e2::26) To TYSPR06MB7008.apcprd06.prod.outlook.com
 (2603:1096:400:469::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7008:EE_|TY0PR06MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d6ae3d-b2d6-4400-3b5c-08ddd0078e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZjkZ5mkva0nsI5Y/481bqULFHIdyohi3uXWP45hf/eNedh9PUlZkus2Bpfyw?=
 =?us-ascii?Q?qkAAZMkraAqrxO3FyhkZHkNXaxxROLeHIO08A7HthwXNzgki+BEE7RSshtqr?=
 =?us-ascii?Q?1by0ozcwgFuDxK8/XGxD0ZX4fCd5gp8RrQw1S/FGlrjFRbMrcIWZDEGOxx0B?=
 =?us-ascii?Q?YP/2gkvfv/uN8dvToK5yuihz+5neSlI2hPis+KhHNGgc4soHWCV8raJnRPzK?=
 =?us-ascii?Q?jduaaauNCM0PoueDSSoWaB5YFTXqdYgEiEf1rlG6HVswKokl23J7p8zElwPd?=
 =?us-ascii?Q?PsKCO1yzpEQfsQCFFDBVolngYfIJdPQzhWsnuR0DIBzoiwmA3zNudpn4xtEn?=
 =?us-ascii?Q?SnGPskKPcwpP58syjOu3bJGBUxEVcf16vGttuXzxWjXaxQ6Khsd6SSlKwe1G?=
 =?us-ascii?Q?8ycKqApDi/5yIePYTe4Uqvx5tKG+OBE8kzIGW/+YWh7NEaZzkRLLJ7EiFCZB?=
 =?us-ascii?Q?nz+8kDjbfyNJJjlRUaDWUTRKTe/ilmBXHVf+kO9L3TPlNv4swpHA54feEih6?=
 =?us-ascii?Q?HkVWFO4fDClPqaQSkOpErlwZe4pVq5SUuxERIGZhvBf8x5Hsi4XZ/H2IORQF?=
 =?us-ascii?Q?RmdEaG/2uyIqPX2eGaB0zWCjglmoxNz9T4yZCnOY2q/5itRf1NII+e+OB56X?=
 =?us-ascii?Q?3fhJZp8ck/+NaPVrJ0teZBScO0bFbgtM0z+6iGuQr9bPmVR97PqOcWnj1FuD?=
 =?us-ascii?Q?QKMQQO0L7HJM02ExlIkgPoKlhOqEchpUD5jmbCLBrnLXLOCsYa5ZJzsA+kUl?=
 =?us-ascii?Q?ODkZ6N2gohOwI/+tScdIHpLNSSVW3LVxJ0L1y43Z/dOpLvmMtWO4bBG78jbi?=
 =?us-ascii?Q?FMIJgLkofIBytHLiEKg4NDsxfrtBQA9Gn1j8y18B3XAMibuF9RBuQBZUtcvb?=
 =?us-ascii?Q?3etMJeosa9K8u1WV/YCme4XO3Ko4aXT/n/wlE9cx3vrvHuRfrVyax4YaslSX?=
 =?us-ascii?Q?x/yVdZJDy08qJbTCtg1ukhGWb/UQslCQYULA9FOxT6pHpNDZKYcnHlckU2vW?=
 =?us-ascii?Q?tPL2v7Jz8smbbBFBqn1wsdEwgzHOTf7LZYzwPBvWge/1a7YrmDO4ZRGC6O5P?=
 =?us-ascii?Q?UEbb612WgJbILKwCVxVFr5GfqL1lqpy2zqn6CMoJM8xyGGklcm6Le2UU6UXh?=
 =?us-ascii?Q?uJywHFP+O9B3tkaAXAxN5RcuKGyu/Ml+v6yPjLDH9UU7GnM//68ZKQLRnBIT?=
 =?us-ascii?Q?aeL63P1KWh/2ZTUP6teWQoNKqCrJLCXNIQ5dyy5NQ/SpLriyUrGfGboyLgFs?=
 =?us-ascii?Q?XqI9d/x4ipem+0UcU9mc3JZh76m7Hz1rzDvpu8BXrbr0AGGcf6x7m3dmerNi?=
 =?us-ascii?Q?7rgtgRXsWniHqVUbopta0SmhwiWKi7ULvy5gA++VLyVryewfIIwN51XPbCyg?=
 =?us-ascii?Q?uli19hhHqT88o6pp2QXZJN9a2VRqC9DgDfV0lDJVrMCvYwLlkk49NSIXu2Gm?=
 =?us-ascii?Q?go5Te/8aDtgMIK6B+3dkE+izcWxi0bJQ8BVB9zulBJSM+J9BD5mhFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7008.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xg2PFo7Q96B9e3kBFXAPmOUmFWwc8WmVkO23AzK36G90uwQT315xU901UH+J?=
 =?us-ascii?Q?ipZnUuSpWakYwq8kIPzWnuQAqdyOiRxFym6w7P3IyQ7urqkVxPOcVcsF3fHz?=
 =?us-ascii?Q?YoQ86NndTNITJtcPezAYaE1Xkd+riSblQ0p+uWBcol33tHpRh9pXfIonxp8B?=
 =?us-ascii?Q?7O0ALCdcbkXcWnps6dJF6SnfELIFPIyS6eOQ3K6AJ7xByqSSFMdFSu246836?=
 =?us-ascii?Q?HEbkpGbY+i5iAAEX8UvwQ+cY5BwMZggUeU+pTQ2mfKnAxsdYcFrsWRA6Z58M?=
 =?us-ascii?Q?yR5ddLYjb00RvbxOZJW4n+CiLEG102dgIOCSCRHA6/+tJ4vVpcfYudYeYHpm?=
 =?us-ascii?Q?ycLerZZstaLor7F5cavbwCUHfNkKWPQjWOaezIN1eGjFJiVsAXCWV9xulhkz?=
 =?us-ascii?Q?0QOIDUgcpp16c+C5CdnZmkItHtEAT1DvXxwmGRTDhpiiTraORb884HmEb1Ap?=
 =?us-ascii?Q?uh9qnj8mQZ8wryzw2NeCFVnpm++73phlVn9ZliE7kyOFf+CXBF7EhsyozDmu?=
 =?us-ascii?Q?gIEUmIF8l+75N0wd+hrXka07WE1EU0RaXORS4ZzpkqnliBiqjyWg1pfIzkDZ?=
 =?us-ascii?Q?VWLgj4XpGrF02Sypdfwi5LrCdi49i+98hEK+NTWGMXL+tAYaIgZeydL1w2rV?=
 =?us-ascii?Q?FrwWe0jgfBFISXFuuukcmSCKnIKueMKfxN0BbyzmOJ0JDhF1Luem8s/ssKFz?=
 =?us-ascii?Q?0tcHATvgp8lNFdrDl6f1NTZdAyWXhVqBv+LmyXI8KestYzNL0bbWdkNqP8E0?=
 =?us-ascii?Q?+bzIJJEq8x+mdBXnDsSBBvLE3y99mmXXAo8jebUkEmghPKojb96pcBKEZeoh?=
 =?us-ascii?Q?rQ62afnaPvN0zLzkRyhsE0rC6x4CwV6V9dwH9j23Dnsf9BigTihupOb3zSsv?=
 =?us-ascii?Q?Lf1mmuhC9eLJo+XDgKIkxhuJayrgBBlRZUsGc0wp/wsJtMNMKy7YVfSlC4Qy?=
 =?us-ascii?Q?D46rGdxcvmmwN5cYsaBr0+ezpEhrK94ahED6G/an7hqA6C+aVmRBYQBAEo9c?=
 =?us-ascii?Q?WP52K8yCmL5sOL0uo5O5SYb+f12BvjUPXmAUUX+oq+rbPMFz0bvQODSLHw2d?=
 =?us-ascii?Q?X0YX3oGLK0gIwRA57cv1cq11MaBEih+tT6RRaoWErmncSm7ANiq481lQrDiw?=
 =?us-ascii?Q?go81FRO/JbzhMepLSqOuCKIOteq7+q9aaOnsIM16trmtK30p29SzU3WIHogP?=
 =?us-ascii?Q?LYpraX3NAwOXLJWhyY4VxlluQgAOTgmh5VS+ntY5BzI0Fy6PWc2Zr+9tj9XM?=
 =?us-ascii?Q?yqNoU0uQ9JdHKz8GTkagP5YYfZ3ND6ZAlQQug1Rzn9IvmnwHe1aJqUKWkLLS?=
 =?us-ascii?Q?G6AvhQxTFboTvvHfTAAYvB/5fOGV80uyTkiHmF+jTv4HUiKp07H3rWgAJsg+?=
 =?us-ascii?Q?BiCP/yPVsPJwaWgDuSpIDw8nB+z8EQ0noD8idY24vZBGs7okNbKIx4U3qfH2?=
 =?us-ascii?Q?8497fUhxYLM76hCYqEeG+jCQjRs0MG+omO9cLaJvvOrtF6iR8d3hFyeXz/Yf?=
 =?us-ascii?Q?7KaX3axMjO8hvumzlYu9stIA5jD+mwYHBUoi39dlM8fglpnEco9pYIrcjHzM?=
 =?us-ascii?Q?gsQdwsi6mhGXir5KkQ1+cQQkSrb/WSK1l4q78Z5x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d6ae3d-b2d6-4400-3b5c-08ddd0078e04
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7008.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:55:02.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2/Ft/xdDXcYwIFjhuxJj+92bAuyyGEb90CD4pw12YpKWnbGvrB3gr5d5v0/tNahD1MXyojq3S2qmidOvvPnbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6801

Adjust whitespace around operators to improve code readability
and comply with kernel coding style guidelines.

These changes are purely stylistic and introduce no
functional modifications.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index e0c4416993d9..caddb7dfb133 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1525,8 +1525,8 @@ bool read_is_mst_supported(struct dc_link *link)
 		return false;
 	}
 
-	rev.raw  = 0;
-	cap.raw  = 0;
+	rev.raw = 0;
+	cap.raw = 0;
 
 	st = core_link_read_dpcd(link, DP_DPCD_REV, &rev.raw,
 			sizeof(rev));
@@ -2125,13 +2125,13 @@ void detect_edp_sink_caps(struct dc_link *link)
 						&backlight_adj_cap, sizeof(backlight_adj_cap));
 
 	link->dpcd_caps.dynamic_backlight_capable_edp =
-				(backlight_adj_cap & DP_EDP_DYNAMIC_BACKLIGHT_CAP) ? true:false;
+				(backlight_adj_cap & DP_EDP_DYNAMIC_BACKLIGHT_CAP) ? true : false;
 
 	core_link_read_dpcd(link, DP_EDP_GENERAL_CAP_1,
 						&general_edp_cap, sizeof(general_edp_cap));
 
 	link->dpcd_caps.set_power_state_capable_edp =
-				(general_edp_cap & DP_EDP_SET_POWER_CAP) ? true:false;
+				(general_edp_cap & DP_EDP_SET_POWER_CAP) ? true : false;
 
 	set_default_brightness_aux(link);
 
-- 
2.34.1


