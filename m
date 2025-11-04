Return-Path: <linux-kernel+bounces-885581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A774CC3363F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E89C34C3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D22FABF7;
	Tue,  4 Nov 2025 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AjPN+I0G"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8526B2E1C65;
	Tue,  4 Nov 2025 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298977; cv=fail; b=oxMTtaVXiSKSiXGPeeJJZacGK6UIjgJAAqh6/1mcyrEaqh8wtsjj5czOcd4sjkZoc4ZXfB3J2tTyrUDXIUD2SWxIuEBAEuDOS05KACXEIH6+d5BkoLoXfhHN5f0M1H/fTOIJEeqzmmFO22N++geuM2ufarMZgFkZRLP+rd9V0R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298977; c=relaxed/simple;
	bh=gyFox4kl7V0sY6L7nOUZyrDQ6v5JHR31+8KyuJCgSgE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BijVocsoCWLfAkryyzmttuJPLcG76IVLNTtXkZJ/D3Zq1IKWs2w50BiMzpapzl2wm7fHWiI/aUgL9B7Qt/pEa4JEkQn2D5s1M8XwraXbufb/3n6AOmBdVsq4g9O0/5nkyjbTraCnC8LRkJOKdfJVK2HBbA6CuP/ld3Lhzq+8fsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AjPN+I0G; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiK4sg+yWfl3zvbsAwFyo1zfd0AJeQW1v1sHd+zj0QMZAS13cHCh3dcrv8eC8cNUfm9etKQ9Mve8XzHC9z/A/CAjxsyBRdmAPwkKPFb3J8qjQJs0a0Haylmel1dwEaDHsXuOg/dzuQ4M1bXOS33d0tqluj5FuNE1jh55hpOi1L5iM4eAu1u21APzgfyHDQ3nQXaExrefvnV613yKIvTwKdGoQ+FdUzgEg5qJZbFdNauIQhzMH0FJUC7oy1O5MeIatwT0zrqPsH2192ElAifjLqNBjwzOiXN/0TXmmGdunhoLNem97sRqw7u+lNFjNkXwmr0hb7s0+k+5IMOWB7WVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmPLnlfQBjQoBWDw12ajgDXahiR2Uwd7vyoLeCwS064=;
 b=BUu1o1wJqI2rKMkTHfrVkBcRCuGDW6/UqnuXR3OEetxVwmZ1hoC5BBCzXO6oGBFmyvl406Hf9xNl2rcY+xzkMDr0lEOEUmwJ2Rt6mBfxJCDruUlxaiqC/iV3KQ6H+OLqpln+ABtqOPKapJd4MecFVCJtDMeNKE0CdKzjhB9fEWWRPgerSDa6lw2u9hIZOAjqdXFya7UhlHIQo0EBRs14yZNOHpN/YAGqsGByslbVC4Et35LsQROYAKIdFjuHsPNf1SRKQsfWMWIeBSWwiLcSbIZzZdExxnRYh8aJm7DQSRDdQIVNcwpI1eh9rF4SSm/lvimLCMbSLn9j6to+tUCojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmPLnlfQBjQoBWDw12ajgDXahiR2Uwd7vyoLeCwS064=;
 b=AjPN+I0Gx2iQt34Ag+H+ooKLJ7KgIpkOdAB8lYfAXhamggEa4C9ByH9Uy3VkNhEyAhHbLKT9AsHJAoBs0rQmFIGpfDCEHQ5IXLs/erhslfkQoy3pBJuO1zK5bjyJXFgTeP+Q0UlqAk+/t0QTis0YABi757hH5nCfdpT9pwEoO3KCYrKnMW2lCQ6fUAjiNPoR2ASxd4mzdT5kCvqIeNzzQiJxmtgzL9hz4uUYRnaEKc8syhKla3yhhJji7XVTV1DUxs67KJ0vJlYyxuAyCbHs0BocRudTMlh9GO2xvkfNXRJeAMI8/HMYAGtOqIyNf+aQ/XJVoEU1U4bA9OLZWlmWJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BY1PR03MB7239.namprd03.prod.outlook.com (2603:10b6:a03:534::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 23:29:33 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 4 Nov 2025
 23:29:33 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v4 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory region
Date: Wed,  5 Nov 2025 07:29:17 +0800
Message-ID: <6e5aac300191643f147e5deccc23c09075b6906e.1762297657.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762297657.git.khairul.anuar.romli@altera.com>
References: <cover.1762297657.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|BY1PR03MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: fffdc794-806c-4e89-9969-08de1bfa025e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgaXR8jheGFhbLvbedEGnsDkjUKOPbJ32hE9wtCNypoiE0G1SsPxLLQHiWr+?=
 =?us-ascii?Q?vlmHIV2bkm6y+RM6rfzThxcwVsKdj1OF9FhGrMwAEfhKBBDweRmuHOjVRB9K?=
 =?us-ascii?Q?X7ElTpR+JaYr4Cyf9ik0dWv/RS04hAgUsqzHL27bkDg3zllIi/vSfpi3eYxP?=
 =?us-ascii?Q?jVAM9SYqJSg8h2/OO6uHKzV+lhEv+or5S14wTESU3n77F4BFOnjgIE4sE8C4?=
 =?us-ascii?Q?F91MR+7xtRaZeI5mHk7NBgZiTfY8qejOLMNwOcsEfjvUNgYbaS5vMvRYZ+r1?=
 =?us-ascii?Q?onKwBfgy4gCyn+1whPPQDab2cdjdrGO+jiZqGJiJGcl981jPeXersFXoTt07?=
 =?us-ascii?Q?q81HzMoBYp1IYCpNpzPYMAW83Eb6Vso3iAdAGSWQWG2d9bj7oC4GDPIHGCBy?=
 =?us-ascii?Q?44mttsvl0koRHK7b7Ykay2HCXZTCV8exHTVVublocBWnmA1xYW1ppXpxEF9b?=
 =?us-ascii?Q?TEfRJLzBAANGs8Y7eaLRcRfHVJcVVdKsB0EL71SdFIveDe0qoqil8WPUT4jO?=
 =?us-ascii?Q?pcfi+T6cT36oBUtybqyCxL4yU+mnBqSL+A++XjfLyj1E4L0sHcuuPfM3D4G2?=
 =?us-ascii?Q?QN+XiqDgN2L0FZyxAVJximmoJ82H84Ox7bu/gjLDBmV2w8xPDVD0fmzoMHD6?=
 =?us-ascii?Q?eDR8j8q8QRkZGJYiRMgYpcO3UJDlw5Jk40svvMhCDAakez1vMh4d+wH5xp0E?=
 =?us-ascii?Q?lID/TxK/PM2OFS79a716qlD7cr8XPnjtHlc/9KOLyM+F2meODI+zbhmX+fLG?=
 =?us-ascii?Q?Z7oqWVLd9WSNSlkEkt1W0k9GjPpPB3L+seUAmsUE8mqwrymI9LIs5tAUud3a?=
 =?us-ascii?Q?XXy+oCt66HG+mKbGbuZxBLLN+gNFFO1R+bo6M9Ky1vkWMApTI5CThtYdb/WQ?=
 =?us-ascii?Q?VCgrcoHkVFbaWTu3K2e0tYIRh9iS8G6CoTWL1EvMKbW2n3Hl81DmNQ7z8FxR?=
 =?us-ascii?Q?dkzHK8urDr23/TIP5nEAccdLiLH85zKZNNAcv5nEznIxPLBkD2iVSmIVCv0x?=
 =?us-ascii?Q?gXL23y1N1ucl80U0Dc8HigAXg+96ll9tC+3482Sd2BGwgOP4WCs+s1NV1hVU?=
 =?us-ascii?Q?sMK91acYNVsUjT/7YyX++dQQToEhDBx/jqBTiS1VyQjUQVnqar301JZQ7KOB?=
 =?us-ascii?Q?HABKL4CBeM5T6SOhiKR3FaJ/pFBe1+Ptdc5a247SIGtbMKma5m7kn/1PPSW/?=
 =?us-ascii?Q?2+n//2My8Bqu11UNEjF83HU/nkGtilVjFZx7D2SK5zHoT0rhMxL/ht0tWEWH?=
 =?us-ascii?Q?dkRsbQAK3xzIjlr09VCaacvuOSyBeYzEO5M7T8NYdlWFP+0nyDaHUkGf9D24?=
 =?us-ascii?Q?TKkswqOeYd8n72zKiRjCRUmSogfOhyIq9XV2kVh0a2WhHzPrpLWBRaoYcYEV?=
 =?us-ascii?Q?++jvqaL6fxkPkgb7k+QDzb1i57M8OVoZuMedOHpm4AcRSe/gH1zkSXwYw43l?=
 =?us-ascii?Q?h+Agdiqc6p5UhknDQbCr8vFOv+fBBO2RqOPEFkDg5TH6RCCEpMDIHD7en/Xh?=
 =?us-ascii?Q?IJELW1PJSr4B08s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZFM5qA1VBNb2Uj94ZVcw/oWdVHpV/zYD+1mLA5rrePA8rRAWAhsr117nWSF?=
 =?us-ascii?Q?/D0ZWwOQfSDC/rVcChSi48YRV20oWkZV6yFsSYOVC3I7eKQOS96Lgd+W71uJ?=
 =?us-ascii?Q?VouUTeBOO3tS8nSwULYP6j3yGfGff7oyMQSePAqjCBUxtHvpb1a9+La7YiBj?=
 =?us-ascii?Q?e6yLNCTtiHce5UQM+Nl5mVpLCTa5P4JBHw7Gh1OgiNFQhgYZ9vZNveBQDbMH?=
 =?us-ascii?Q?iS9ZGcTLZibbD6N3VTayd3pQ0Z/eNPA3yTAHL4Gm4wBsBN6yxgfX/Jcn8Ius?=
 =?us-ascii?Q?Zp467Yz5qdRnlgxQYAY6UPGM3WksQwqMC6JAV4poeUAtp7nOyqc3M60RC/aW?=
 =?us-ascii?Q?3lT9e5D6IrKo0O9Fw/cAGMtvJN7IhjNtlw40qBOZG188Z/CXy5ELL1P95tlm?=
 =?us-ascii?Q?lSjzyy281GsDAvyVy0Azhm7JAEEGXH649hYv23DtYyPRYs84+MysvO8DiC4I?=
 =?us-ascii?Q?Ajl9dET0QgqptbrBV0cxWxgY9me9+Nb7uscf39+bnsU8ZFN7EwSgOEO8JQMT?=
 =?us-ascii?Q?MQ931cbKUYrnJ+vyyYttNDDD6cCPS5lwzuTwIEN/fjwp1D30u1yfISZgSMul?=
 =?us-ascii?Q?nnOaopJmgw75MUZsH5u2gw/5vYTXctjnE0snvcesK6cG9dJC3zRFMkEngDqc?=
 =?us-ascii?Q?Rqx/M1tcv+x3I/CcZpL8d8FthI4HsXwKYYK15vxzjvLcvT1opjpuYk3Q7iC5?=
 =?us-ascii?Q?kXVJ49lvvsR35Lo3yBFxDqVB40zPrbgB5QiE3DAibJL1Oourso20fpGb5mDW?=
 =?us-ascii?Q?r9DK1ZnF8XuYMbjAAsTpqvWUORATZ6wgnBPD7TtK2aD9VDA0M7q2oVVFf61e?=
 =?us-ascii?Q?3xKGjn1+5x7pNVuSr8nfyrauBuK0+OFNS3z9EoFTnU0wghs1gXpSaXltWb+1?=
 =?us-ascii?Q?y1z2ii+/Y32B/tRaD94P/jSlJGep6I3EquNgxvCLu+t7wTw2NQ2bwT5d3IEl?=
 =?us-ascii?Q?jx0rIXN9Y+mcvB7VG30tc2hNLHJo+c6QY/PkXalkFYU9XRLhqScfnDzKkNkt?=
 =?us-ascii?Q?/8c8n2wZ6v37z2FFhz8XuCKWYz6LxQkQ1Tb7LWHm9TSigVIx7/VOjWRdy4hE?=
 =?us-ascii?Q?isfE+qmDBt+tVoxf+vTK3ULQF/cUI/YswNeYg+rVn1AlKW6ucpTrnYfjjywD?=
 =?us-ascii?Q?Nbjx4wQbZGpm/YHAZb+9N5TBIw6nFGseUzMFAnFlpGQSBlrHx+jBRutrRf+0?=
 =?us-ascii?Q?8P8yPcngfPwQWwKZLK5KZ6E4vwZGwZaWFm+qPxsNa8hX6FKCI9tyanj7wCzM?=
 =?us-ascii?Q?YDLJyDP65f1zQ0XzLaCBAMGkFtE50w61UYODoWGbk4zbZfetysblxPw4rDLm?=
 =?us-ascii?Q?MAQITWoc815cyUbRcZMg3AsaD/ltBYlC1w9NBVAKoGpdtZbSoNO/G1TS41PS?=
 =?us-ascii?Q?VHSGo/qX6d+3qrEHR69Db4/fBf509oO1sEzRFzzDuDvDoACscE2fWJVcE9O0?=
 =?us-ascii?Q?VbKnUQQKS1phesUjFDf8jFbRKj4ze4TGK7u7aVKfAI8Ahw7Sz1SmQPKwun5V?=
 =?us-ascii?Q?dpGlujNv/c6mrcS9oivpkHFhX8nhcg9IKVuvCpaEi/fkNqdAEWgEXbhm+u74?=
 =?us-ascii?Q?lJEsZsy++i955AuQx1nhBW/fjB3hmKslIva/MK3rdYAAigb7sQHQ0jgu+7OE?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffdc794-806c-4e89-9969-08de1bfa025e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 23:29:33.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMOfV+vGSvfc/tUlcQIfndHA6Y3WB5YwmZrR7ZH3uRnfV2nKcF0unTVY0pggvgE7qS8PBOzBCJ/v2fLI3jcgrkg3NNChRgXIYc25GvunDS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7239

Introduce the Stratix10 SoC Service Layer (SVC) node for Agilex5 SoCs. This
node includes the compatible string "intel,agilex5-svc" and references a
reserved memory region used for communication with the Secure Device
Manager (SDM).

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations, particularly with the addition of
IOMMU support. Unlike earlier platforms, Agilex5 enables the use of the
Translation Buffer Unit (TBU) in non-secure mode, allowing Linux to access
it through the IOMMU framework. This commit updates the device tree
structure to support Agilex5-specific handling of the SVC interface,
including the necessary bindings for IOMMU integration.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v4:
	- Exclude peers reviewers in the sign off.
Changes in v3:
	- include iommu property in svc node.
	- Rephrase git commit message to describe iommu presence
	  in Agilex5
Changes in v2:
	- Rephrase commit message to exclude mentioning iommu
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 +++++++++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a13ccee3c4c3..15284092897e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -841,5 +841,14 @@ queue7 {
 				};
 			};
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,agilex5-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+				iommus = <&smmu 10>;
+			};
+		};
 	};
 };
-- 
2.43.7


