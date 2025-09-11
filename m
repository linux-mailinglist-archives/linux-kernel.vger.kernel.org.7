Return-Path: <linux-kernel+bounces-811203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15745B525D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEEC686EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2022264B7;
	Thu, 11 Sep 2025 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wa76KtL5"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D9222581;
	Thu, 11 Sep 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554678; cv=fail; b=Lgbw8QqXAMqeTIkqwUOFwPX0PlrT2M8jwPlWqlTSFjEG5pvH5RnqJnl13Fq+eOKEw313XeMxFNDpMxTHJvqbtfhvk/Tj96R697zvgAZ6AOKSJ28VZS683q0Bv3R78cW4LPaXOfsvCehERhg1lMk5+NlM1nMYHCA11hx6iGSjUJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554678; c=relaxed/simple;
	bh=tFT8aWNVgbe+/a4dXvo4KAt9iyIVs+Qp9O7BSgRHg+o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVCtEoQ+xhQQJDt7WH5qhSfvwzHbZlH70bhvX4QIAk9NtXAbUqkrU3mZli1uUmCh+qX2KHh+rs3lEueNfwJ2LX8JVujQMWJX7vRi9b3vv6114ecgbQrXNDqgvSQYdjioJHw+DK5QTpiUpkzp2F4Pxlm9YNCta6h6CwzQcdNwhEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wa76KtL5; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvApSood1yx+FZINU582BmxE7ZruDEtAioooMRuYIsc8Q/KqKPbSdEqmPMMtKwuo5Y67/6sOOLYGGpoMI0LvX3z3G+GtdspHjhKGCoHnzHWc/L6GDv0j04xZlUISe4y08AeyQBOv2ojWKiROYFmubwJy1x4tjLaWxLT7nWpI7wkqaN/uqEJFn6Idyoe7V3qdQW8i/xzSpNzThPTRgoX1cmzwCJeW9WLeU6qpTY3AwQlnOFaQT8sKLOFBEyb7YFV21O0T98p+lrYWj95pDuBTGk5ahCYRC4okoAcG6YJNg0aMRPItJN2ONmXHHD5hN2mXYYRx2n+R9zuQEScWuwc9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN5ZC3T9WHB4VsyzAhwogEAPTOfBYIYfmfaUvaWIYxo=;
 b=O6Dl+95pPDCfPjElBf/GSh1bfj20j/pwsKWyEw1OzAV9qRdr987jwFFeyfAkX6RQOQZ9kX7787mKZ2zwXUdKan1b4kn/e9lqJQjrAbNalt0OpeIxUOWuncI6mNEx/1LKmnXwQMlEULpJR/CB2+m0d6ewkHsXqTjw3N3eAiS+okCG/cHCcpa30mlZUsCHEP4PTrJLxxErY/J6sZGpfKBOvVgPiNKlqR/szOmxs1T5UYZ5HlThsKyCT7Oq9qxX8xe8TdcNcHvhIlhIAOG5Ewd6LVbf/v4/DkfVTLW6T1M1/G3gTdIMMiQ3w7lvMQdBJoWIIbfVVOkS+c+kd14StkqOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN5ZC3T9WHB4VsyzAhwogEAPTOfBYIYfmfaUvaWIYxo=;
 b=wa76KtL5xG6yeU/dnjIySbTVIu9cqjYwBLZ55cyhDVmwr+aZPm6HVz+GofP8JATpxeDQyGtjqBrE5PkaTvYx4NyQjBrYbxi10B2IPsH1dWIoweBSif6N05pW85/r6EOYEmokKC5Za8QKRqHGifLBytKeW/moaeUOnOYKSlzpMcU5r8Ru6y2ywP2xc0eZPkTnYGJ4ve926vf+m7BeC+1gM36qlGT40Fp5KLe0iQl3Pjo6/c3SEpbWb/JhP5oHdO8eyGvGZQCITKlrvheTE52mSFOm83glcv+u7D+ZBzAVZLHqzrKhHTCTH+vh3DvFnDzQhSXssb3ez4DgsgyCPX+hqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by SA1PR03MB8083.namprd03.prod.outlook.com (2603:10b6:806:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 01:37:55 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:37:55 +0000
From: yankei.fong@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 3/4] arm64: dts: socfpga: agilex: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:37:25 +0800
Message-Id: <112410d51ee916590b974b07a0a3e082ac09aa68.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|SA1PR03MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f3a0ac-67d0-4007-944c-08ddf0d3d44b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qE1ouyYKnZsGw1o/Efg6y4QYt3UiDBy/Qu5NiGFL+ExKIGMkdiNpiowDyo5s?=
 =?us-ascii?Q?ZszRY6+BuvQpQV9IilH24mmuGzxyBGytquk10RVPEIRYyhGlC48RFUnEUsyN?=
 =?us-ascii?Q?9qoGm8xP40Iyz5rhGbvAJrPktAgDnGkQAF5QmdzwBUvpKDxk2BQIoQ8WkFMw?=
 =?us-ascii?Q?xW6mVqt9eQrmS2jSbIuXQl0LMsmIX+dKxrHUerCID5D0ZeaaTr9DGQi2pJO8?=
 =?us-ascii?Q?5zyp71NXDvD5lkeuMIj9tFLFT4Jedcgdp4gBjzhIwIq9Dos7/8Mng/BII/qk?=
 =?us-ascii?Q?1oAt3otYt95wKUbpw9X3IaKyzV42u5AArQYs90LMrlKQBx2Sx4LvGXNVDKFV?=
 =?us-ascii?Q?bVIKeDl8Wn8G1ftx2dotZXkzwcHvWTyfXNCcfKnZH/WllKP+q+QKHCuZos+C?=
 =?us-ascii?Q?n4BiNXKO/rHQNFIJzp0EEYdWxOGH7X73CAJD/X7oK4PPimovAzG+54IE6jKJ?=
 =?us-ascii?Q?yH69W336K7ndqdJxQVidyqqfSKKbJJ6zesey/+nI9ek7FO4RLSTTMoAex4mV?=
 =?us-ascii?Q?g4sOyXTIeqki9cu9n/0e/C7586lpLtkSSPMsQPbsD3LDjiwB+pPS6AiROtZ9?=
 =?us-ascii?Q?2rlge9p/zNGJxTBBSdZN9M9VQUVbl2iXAQsmAqxJykw3Ednx1ei4ebWcTkZ3?=
 =?us-ascii?Q?S3xFlALoGBZCUmOWgPOydqSgGBvlh8J0jVs3y0nUskGFcvXlYOIs3eVcPNW1?=
 =?us-ascii?Q?38Ne09K9JDf/W962WWnehSi9sttlLpwhAreWRLwjv4VKSdNgACTLNENe3V1Q?=
 =?us-ascii?Q?VbfNedwU31cHO0d2j3NkSWyTxCvWenow0ILG7hMViWZdZBKXf0GKGrDeEwtl?=
 =?us-ascii?Q?EnTyOvGB+6m5AkP/6xweUlMnr4FzrB8oH1s86fvwL4g5nhEsTqdt72WMc/4R?=
 =?us-ascii?Q?OB1vKhfCNspEf8TWUKgu5cyTK5pcIsFwu+kfhr2YT3YjMG7RYe/QMeN/GWiy?=
 =?us-ascii?Q?OUDCUgozL43ZW5IfAs2kdSvbnULQye1XH+VcaR64QbqnIdlOCssr7b2fuDHd?=
 =?us-ascii?Q?D7GzgdT/1H1Tw2K9U+2Po149V+EqosNFRfTJlTRjin6tnhKJC9ltSENyZvOU?=
 =?us-ascii?Q?AeojyOEtqfBmBH3UHAA52C1yhuD4fOUEFiavQEnqyytk+7TyOZJVwgRgStWn?=
 =?us-ascii?Q?cCmrnw4rSU0PSIZijSW/+A/cE1TL5WppT18euA57RCFs+3kHvHUZCxP7ZTVH?=
 =?us-ascii?Q?jOI+x4XLv6gyMQRKNsqDA2yEWgXlRsWjspK7iCEF+FEMJW7IC4QwSmdfqisk?=
 =?us-ascii?Q?avbm5fCGdaJIyC+wBOoo5140xfWWIkqZu93W8Ky3fS6YcemR7Z8kcVMKeztD?=
 =?us-ascii?Q?4WpkLxZ0J2EBFzxJw+C72uj+fAgl5veZJd41Wwo547mt1xz92G9vNvBf1k6T?=
 =?us-ascii?Q?sztWATke9dTirbcdVKl4hbVNx4CxG0zWbxA+qIpeHBa95nfRubvhpA3P/OqV?=
 =?us-ascii?Q?lENMg5peAHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wVwJ7Lc/eaC52GHVhq+pF0NTwbOjVU7kgZfzgmRpjpsCPYZt4mT2wS5QMGZR?=
 =?us-ascii?Q?flHoQzwNaOZqGRjzg/sQe1dM+SvgjG0VuOhS9h7oBfEqYMaM2wT4br4O8odm?=
 =?us-ascii?Q?BE7NkyUkG0cEeSRcNCLyGfurBAnPUKNagd6cZTVssLpwv7aEDJwv9z4iZLKn?=
 =?us-ascii?Q?UroDSh+OL0+BSZ1NuUq9KtyMdMeBvJ9spryWn3JPRx6p8iG+8wFnFpQMU57O?=
 =?us-ascii?Q?xsDkJhsCuIBlPLnji7bQYiNEAbuBT3ROiOZpw8fDpcmrTM43NsoahNGnc5u+?=
 =?us-ascii?Q?dJRAwDTJnxtZCGd68zGCLBsI22nWt+bOyXKiLfOWKXDzZIUt/rlWggStvoVd?=
 =?us-ascii?Q?fCBy3G0zp6Xk5fWsYgHa2xDX5MvIhXVQCDpEPPhUc50CxxkfnvJ7pQvUeX7i?=
 =?us-ascii?Q?uK2pFQDhuGx4xaYGEH6dtlbyJnDeZZtPekziE86tKDmD7mv74jTIqkAm4pS4?=
 =?us-ascii?Q?F482i7mCNo11Ro1afIEuVrs+JkP4Cf3zXe99aE56s6RTsOCo2AFqSjnOJ9CZ?=
 =?us-ascii?Q?aJTOp1X8zoPTze8ZhiKyRM4ENM5k+IbTwxUXfkbpykmISAEZVK2JE/9HkPEn?=
 =?us-ascii?Q?bzOigd7HvH7Q0B42vg/GgV0HPnba52JZlpSOPPNMwKu+MW7AQl1kXNqk/sCL?=
 =?us-ascii?Q?6JnnFlDHG+QOOJYJeXq44uBZmZrdzGdHBz6dnQOTv+MgpMzvjTi+738IGGSy?=
 =?us-ascii?Q?PCzf4kkb34YKPu5nLMuAEOhDi4+9vrw3KlRiYNdMSpfvcND2DeNyi+KaCP/I?=
 =?us-ascii?Q?rGWFow6WL0JX+f/sCadMMmhtxDQEu3SzPzGgjk1BWzlqfAzxmE4KKwHjjl58?=
 =?us-ascii?Q?88c3ye5h/ldv4hSSc2Ebr4bm587+zXiWftHclaw5oNmfSWnuEduwbUIiUgSW?=
 =?us-ascii?Q?QGX8jS7p/ku3lvayKZdhyqekW0T7wSuJloNIriS+WlWvrtiBfjbIRpKtmr9N?=
 =?us-ascii?Q?60XqeJuWt/smNAAGKqE/+f0+ob2A3DXdB8WCH2mdAS/rV1ZjmT5n+gfllCSL?=
 =?us-ascii?Q?QzFb6+V5VEMxHGnBB7D4xjKuRbaEjuV8Rd+ds8EAu6GpSvXFL8crM9alixAq?=
 =?us-ascii?Q?tnSDpGKxEP/YsIvTT15FQx/DQ/yHS/DlSYrbZTruYMqqyB6L86L7pm/hbzDr?=
 =?us-ascii?Q?Z+Sjz1ixeK+IeuMgFwsV9G8aTFct/g102VnhcAh50Rev5ydY4lF24WlNXxGJ?=
 =?us-ascii?Q?YkGW3b7eOIeP7sMdBnNe/q+kncWhmW/t0MdTiffn1fNgXEnzdmT29q95VPcK?=
 =?us-ascii?Q?jpkpHDivmACMXozbAG5DtLm0sSeSKWwf8Uvp8XKuNfa89IbjexTXJj1uZcNQ?=
 =?us-ascii?Q?77IVHZnAxhbn90+NF8gsBSx5PtrX66Q2G5d8lyQ3sttWwQyhb2TdDkN+30fi?=
 =?us-ascii?Q?7T2n66ndrNwN+jPTvkUu5cCdvegLHGuM3F2fw5xmDJqaFvG+NGoeu3qLPGbv?=
 =?us-ascii?Q?SNgbLqZtsaPmAzEoa7aQrC9R09jrhRwLr6EaHRRz4USQAUselavEYwQLQnka?=
 =?us-ascii?Q?OeBspkJZvt7ZK3lj9pCRhK1H8Q8dcguIFD44uW87TG1YeYFC2Qr8eIc48kLg?=
 =?us-ascii?Q?8R8fxvrvp31Y+ec07UT0toWIOVITQ+zv9Qpng80m?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f3a0ac-67d0-4007-944c-08ddf0d3d44b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:37:55.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFZesNrLxuK4F+85Jam77odNr0vWMPo3d9SFs9LuRgG5XWDZteZdPw3nrIpzlg0ie4+9jFCh1Wze5e57g579sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8083

From: "Fong, Yan Kei" <yan.kei.fong@altera.com>

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the agilex
device tree. This update configures the SPI controller to use a 4-bit bus width
for both transmission and reception, potentially improving SPI throughput and
matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index b31cfa6b802d..9ee312bae8d2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -116,6 +116,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


