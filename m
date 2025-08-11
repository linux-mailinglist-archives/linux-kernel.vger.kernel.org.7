Return-Path: <linux-kernel+bounces-763627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3FB217CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF26230D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB12E3B14;
	Mon, 11 Aug 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P1ySX2dl"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667522E4255
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949435; cv=fail; b=pAB6oMDyJLJTL6lWxFchQ9pJd8aHVtyFp38/esfMynKqGLClaLVlF8Tdx7TEwV+/UudEDhe4+VIwh6bivXeYpE8BRyMjP4FN+V8Lzs+CrzkeE17mmwgt+ydGZbcCu503mPzGvQNyZn5WVW+plV98XoBzmR7kq19PqaG39z2pYjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949435; c=relaxed/simple;
	bh=kJAIo6G8dD9VBzttEwTGNKG+6lP08vmOCJJD4ii9zmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q3cFQH/K0HPKKyqZ1IypEjTBtHl4AXVyZnW4S1TfAFmwOrh9Prz9NyYTDVHk9+t6EGfBowHEHfyTsCnvm8Zu2W0PJpUlqo4cTim/2Waa8Laj2CbYxPP1A2H4utY2o/LKQ1D9GrtW8kD8C4neO81I6WJOl4eChSBinKn0A7SVpFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P1ySX2dl; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My9pWyPbH0gkdXyd3jTWYPtNg7BmIfguzcTQfTfVOroaz3S7u2Z/7SXpAl8XNdqZnar76SYDv4NAl+VLIkorj1ZsbpyYCp4fw/xiJCm5pCcKg2jS84G5kuKJbjV86ATt6izmiOIcWNKxaaAng3J4j9nEBfLSCEIy7wldXF3JONEGZ0qmolNmoDPo6gBkEjA38gMdh2pwohPH6wBdbp99G+a6sG8ybep5cflHpc1q9iikDkw15itAMTeKDYgUdl9ZeDAY9thV7vAryvtbnbxN+Cu25hIGAHJB90UzAFHF7SXb7JXB7XaIlbK/iDLQCJo+1EhOfbiym1a6wRBo33wzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P62SQeRITPq6AjqdHqJbZ7lVGt4MzG0jNVLRzKk90js=;
 b=TwKzatdbQ3Z68cITt1sa6s+6PrE9iz4sPrqIEy5J6W6Dftk+AeAd0yg8zepSRYzDFWgYCqubXxIjYRkQuXqhYMOHvzJ/gofqF6wcocn1RmAK/QKy1vfa1E7XK+ERcpYqGRCefi/pfAOYkJJg9cPFp1zbL9GHntxFrIFFQ1QOQWdNf4ps5qJy3HRHhow392YSbIGPG/dT92ynoI18NgivAfmTv7wEoWnJwQrQ1LajEFERGnziDrQ4i6iqcx1Z1CIlOBZk3ePQ0b/PMFsnOnLvfrkpaw/KKlFcv4aCuHeiZ3ckkPppBxuuTau+ddO4FcbxyIoEypQi6FgOciiGIVOaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P62SQeRITPq6AjqdHqJbZ7lVGt4MzG0jNVLRzKk90js=;
 b=P1ySX2dljQ5oViAtctvuEVBOc2dvn8lEbtTN/athB+ZnOoOX84IKPxST+LC2ZDlbYnRJ/exWLYZ8jzDTJUpKvlDZBJlCflORFzxgIH2+M7RXUSlL5IYJuNtEt2YLVBRX6zLr2xLVHvfi5sO9XYlEQSVQMmtBOckbVLF4elyf78ey/JXcHdbQItnP+KxY0I0e7jtD3mkB5K0lH3oYKoWKNqB6WmOXS4XJFKAOjozNx2ylSTX99jAbLPEFWti+jMTdVfUomNXGvwczKk3TcfhfnJcuVpsA0FoQ5jyUSnN90EJIJCMHmknUE9vYQ3YfNQogzAjhz+CKCk0ZaInlc04Oyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:57:10 +0000
Received: from SN7PR12MB6691.namprd12.prod.outlook.com
 ([fe80::d15a:729a:9a36:4376]) by SN7PR12MB6691.namprd12.prod.outlook.com
 ([fe80::d15a:729a:9a36:4376%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:57:10 +0000
From: James Jones <jajones@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	James Jones <jajones@nvidia.com>
Subject: [PATCH 1/3] drm: define NVIDIA DRM format modifiers for GB20x
Date: Mon, 11 Aug 2025 15:00:15 -0700
Message-ID: <20250811220017.1337-2-jajones@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811220017.1337-1-jajones@nvidia.com>
References: <20250811220017.1337-1-jajones@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN7PR12MB6691.namprd12.prod.outlook.com
 (2603:10b6:806:271::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6691:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2104f5cf-2a2a-425a-2cfa-08ddd9220597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTttguq1ncZm7lHA00M7Z8tGN8xpaPwSSn30+B0TTDQ/ydmUWv/0Aep++dRu?=
 =?us-ascii?Q?qAKvqPFWXiFW5gFLQ+J3XJ6Sk7vRAC+H6Wp4Xse2LdtlHPkuNIE2OBFWf7X0?=
 =?us-ascii?Q?DCyuJ3yfDKLCV/AzZVgGjBvEjdvvuY/S1BrTzUce67wScNlQ978ldQAF36R3?=
 =?us-ascii?Q?49qls6jKzsP2n12/yBlCoqLbdSzfZ+z3HX92/gReo929vShcDbpT8aBgYTmm?=
 =?us-ascii?Q?65gczKYXKA5tXulm05s93LfW6w2Bp2EZl3k2NYu4UeO3YsnSZzBqFTDPTOdc?=
 =?us-ascii?Q?W9S5JUqDvcsomQpWmMrASlSs45VzjxgHt5s5Fj6n0MMwKDwnmz3dfOMWqhUT?=
 =?us-ascii?Q?e+pAE/7vmJbEkUUrriq24xMVxrehjrU1JW4cL64gMP2dsojaTMZ5/2LhSLeQ?=
 =?us-ascii?Q?Mg4oobceAeA3jatWeV9+du9z395eE2MgDZ6MZL7Wq6WcD4ifW2KptJB9Ml1j?=
 =?us-ascii?Q?mr2rMSgZ3XeX2a7fg9qduASezHCuq4g1y9l1ZgvdX46HxXNnO4xfAs36kCcv?=
 =?us-ascii?Q?qF222qbqiiWCYrPt8bV5yiKXEatymFJEoFabxb+6cxOGvT3DhCEyNXzYRJfE?=
 =?us-ascii?Q?/2E8cXN5Q3ndmbB8b+AFwITbKHNHz9hy7zAKTSNl0sRWnXo/XDjPr4pmaOmM?=
 =?us-ascii?Q?dJOQAV3qNSU714Cyh6npuGfmsuoNjPUIXxP28MQy++Xjv9KXxFb5O6xAmhD6?=
 =?us-ascii?Q?rYF5wTXtWNCFSHnjTbSuUSDkIqTBG5swavtdAhdsXRVdL75YDUdxnozuFHwY?=
 =?us-ascii?Q?u3e0E2SrnjBocBIGk208G9s7TqMC/p7Vj5AY4T6kzfGzDbguLqyuZ1aYJv/h?=
 =?us-ascii?Q?yHMpneWGW8rFZwilqp/PRBkPQsIG7R77Q3czbOfpq0diQREFPK599LIpjN/v?=
 =?us-ascii?Q?jsDjm2UQSJBPV4YPAMiz/ayhzNkP9TeWrh1q9Es/Ay5LOV7VQ3U3wa44AZQk?=
 =?us-ascii?Q?klSjM8b8sUauVGI2HPKrdLRg0tRMzkxcyBx/9A6XXVBxUrHfM1Bc/qsXngbU?=
 =?us-ascii?Q?JofMhMRsA+LjOGXHmbKF2etjjxuLUfAsGG50cs/G3EoMAPyi2PNL6Yn/IIMT?=
 =?us-ascii?Q?J2bBEL9NVc5nlW2/ORjuO4AsME9aU5C8XVfhQPDGjKIyIlVQv0ZAf3RAxa78?=
 =?us-ascii?Q?KSu5vndVvoCsaBuo5ejaJRplRx++fWrD2Q4vka8rmYOQIw42MAY373UFnLkK?=
 =?us-ascii?Q?XrAA8NlvYbtLCftsvVce34plxHGRGQyQdMML3soZ0Bdh0Z5CrsqwOi3GKonc?=
 =?us-ascii?Q?tQDtibb0mqkptWuyEL3Ic7zOXXfSwbboqddRROhz+/Hy+lv3PoSa5cAIj5l7?=
 =?us-ascii?Q?RADddZz1evTQSjh3GMgvgYFCORKkasMgn0dpoUd+9gWd/Z8C/OXMAW0xbJyT?=
 =?us-ascii?Q?qchM7lK3avPD/x14SAqGv7Ru8FFMMYf7Bfz7s45xKvbv9Q9RZ684i4c0hyyl?=
 =?us-ascii?Q?K+I3nGm8HvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjqA7MWQDqSiP8H/VU5wCuIM1U+TEjyXrEWb0V1rtLaxqQfoofPFq/g36CqF?=
 =?us-ascii?Q?fKVf0ZgzY0xSN7nKfzJxJm9TZOn4XrONvVK494zvj7jrLN57OVYOvd9t8ikP?=
 =?us-ascii?Q?mh8DIi3Ko2HHw5cVL4ZoQQxjiJxVcg2RKafiI6Rdjrqs95Kua4nPpoOQOEp9?=
 =?us-ascii?Q?Nz07rVo28YpQ73SX8zMXkDMEOu9iNP7+EbOgVWTMl9s0qgZdideOH8gcagEc?=
 =?us-ascii?Q?nxtPAm0M2dOPVNhyd5mo0U5eA70qwbuWgBoWUFZQ1uSNLd3XFaYNaAm4NO8P?=
 =?us-ascii?Q?xQ/rXmDEutSO53C9G+edN5LlWlCbFn3FqeqmZMR8zhCWz7RNdwBIfjVo4vWr?=
 =?us-ascii?Q?vE0Jsn3zAMD1kJB8ktxYWK+Y0eyeRVIzmHE+z2Bxq7KoN0KLEVouH6QJ/uN6?=
 =?us-ascii?Q?DsBogByxr6x2Tsujr50qirYIJ4GcWQ9itIg+FgnbVzl2td6heSlv3r+qUZyV?=
 =?us-ascii?Q?Btat6NsOjHaW3PEHvob+RuqXUpfz/6UbtouuLtwImQrsnUB4BXKYYvhggaAl?=
 =?us-ascii?Q?G2AJpc4eSJjBzswJNAbmUW4lQew/XURw3upTx2STyfX1IhVMr7pgMXYZ2Oo8?=
 =?us-ascii?Q?yyaUBtAacIP9+hs7cS3lu/ugKwoN0xfRB5Pp7Tcxoz8mzhE3A4M9GqrPHEQW?=
 =?us-ascii?Q?QJ9S1m919KgvM9McTaSp5cRrebEJ6+3Ri5lVitlvvHunZwXIwNxJ1KsI9zV5?=
 =?us-ascii?Q?P+KImagH+WMyp30k/gLN5HU7WCD3bKV0wl+Qugu/9dHN7wFJ74C4MGdA3+Vv?=
 =?us-ascii?Q?FFm7eI5QIXtCIfUv7i88g3F3Q0c3cmgcrR0etqVMq1egR5CNJmnuwZXsemFT?=
 =?us-ascii?Q?75H1pB78A433e21aF+4AIBxXu02Rzv7DBi+ddeTxGxAIFAXRuHU50d3ZYP6j?=
 =?us-ascii?Q?zLiosF4FVUH4zm9UIHVK/GbUI3AxB3hB/rPaG/xczOishaMGjh85bzBAI9PS?=
 =?us-ascii?Q?2XMVQbpce9IoGlNnUEekf7sSIdO9OsX4Re+1QPUderJ88gjwWl07RZXdyZmg?=
 =?us-ascii?Q?gRppsGq2yL4RK4h+96MdR5VbxmFKNPIbe3PMGk6PmTiHgVj/E9wZiaOC99t7?=
 =?us-ascii?Q?IQWW9ve+qdGrSQc4vhwjYPR+8b8bg+focepT5ySd+4pemuikBWDTVI/UM0fT?=
 =?us-ascii?Q?PFVTnom7VHVJYJzmYfrHNRn5WjI4L3L9sMt83QcsY/bHfsvZ6SVckPZNL4My?=
 =?us-ascii?Q?AXmDct79FhxnTdDFiLqvdBe/swn8MhPKeRHjJO6tTsNAkA84nOs3+pxOwmy4?=
 =?us-ascii?Q?qXZY/ioUu8g8LSzm6z7Zl8jbsxQg+ocuosooC8x2UXqA8+LOK0MVSFa8it5H?=
 =?us-ascii?Q?H8wLvsvCd7FVCbuKsrTkbyJ2zmX3BeKe6PxCj8jSediCL1hxNOebMxf3bLrm?=
 =?us-ascii?Q?weN4QiR4DZ9Fxe4Km1jhyv3stLJxqD1egASJYpVGaeiJHaXu4RqhOVZFd+lN?=
 =?us-ascii?Q?/RtabxWMrLO7TkyNYbBlO/sAdZ9L7JVxL/R5p/XmSzH0odfJmpIFjCRY+phG?=
 =?us-ascii?Q?rUW5QKSEFdQDfJGq17QQ+GoyWQ1mmg/C73ahxA4caYcYHwfqlm7z+9gjNYul?=
 =?us-ascii?Q?TEODJpMYmdSk75O765uELH4ByMPDSIpqkeWRwFSA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2104f5cf-2a2a-425a-2cfa-08ddd9220597
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:57:10.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fngtosco3YuG5bOIVBqHmXv8DwnYHSzGmx9k/qM2JW+379ufF9uZ9TFKBnTAn+NbPKARMX1f38IuC0HHnTg8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

The layout of bits within the individual tiles
(referred to as sectors in the
DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro)
changed for 8 and 16-bit surfaces starting in
Blackwell 2 GPUs (With the exception of GB10).
To denote the difference, extend the sector field
in the parametric format modifier definition used
to generate modifier values for NVIDIA hardware.

Without this change, it would be impossible to
differentiate the two layouts based on modifiers,
and as a result software could attempt to share
surfaces directly between pre-GB20x and GB20x
cards, resulting in corruption when the surface
was accessed on one of the GPUs after being
populated with content by the other.

Of note: This change causes the
DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro to
evaluate its "s" parameter twice, with the side
effects that entails. I surveyed all usage of the
modifier in the kernel and Mesa code, and that
does not appear to be problematic in any current
usage, but I thought it was worth calling out.

Signed-off-by: James Jones <jajones@nvidia.com>
---
 include/uapi/drm/drm_fourcc.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ea91aa8afde9..e527b24bd824 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -979,14 +979,20 @@ extern "C" {
  *               2 = Gob Height 8, Turing+ Page Kind mapping
  *               3 = Reserved for future use.
  *
- * 22:22 s     Sector layout.  On Tegra GPUs prior to Xavier, there is a further
- *             bit remapping step that occurs at an even lower level than the
- *             page kind and block linear swizzles.  This causes the layout of
- *             surfaces mapped in those SOC's GPUs to be incompatible with the
- *             equivalent mapping on other GPUs in the same system.
- *
- *               0 = Tegra K1 - Tegra Parker/TX2 Layout.
- *               1 = Desktop GPU and Tegra Xavier+ Layout
+ * 22:22 s     Sector layout.  There is a further bit remapping step that occurs
+ * 26:27       at an even lower level than the page kind and block linear
+ *             swizzles.  This causes the bit arrangement of surfaces in memory
+ *             to differ subtly, and prevents direct sharing of surfaces between
+ *             GPUs with different layouts.
+ *
+ *               0 = Tegra K1 - Tegra Parker/TX2 Layout
+ *               1 = Pre-GB20x, GB20x 32+ bpp, GB10, Tegra Xavier-Orin Layout
+ *               2 = GB20x(Blackwell 2)+ 8 bpp surface layout
+ *               3 = GB20x(Blackwell 2)+ 16 bpp surface layout
+ *               4 = Reserved for future use.
+ *               5 = Reserved for future use.
+ *               6 = Reserved for future use.
+ *               7 = Reserved for future use.
  *
  * 25:23 c     Lossless Framebuffer Compression type.
  *
@@ -1001,7 +1007,7 @@ extern "C" {
  *               6 = Reserved for future use
  *               7 = Reserved for future use
  *
- * 55:25 -     Reserved for future use.  Must be zero.
+ * 55:28 -     Reserved for future use.  Must be zero.
  */
 #define DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(c, s, g, k, h) \
 	fourcc_mod_code(NVIDIA, (0x10 | \
@@ -1009,6 +1015,7 @@ extern "C" {
 				 (((k) & 0xff) << 12) | \
 				 (((g) & 0x3) << 20) | \
 				 (((s) & 0x1) << 22) | \
+				 (((s) & 0x6) << 25) | \
 				 (((c) & 0x7) << 23)))
 
 /* To grandfather in prior block linear format modifiers to the above layout,
-- 
2.50.1


