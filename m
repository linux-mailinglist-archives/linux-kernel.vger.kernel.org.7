Return-Path: <linux-kernel+bounces-734794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30035B08670
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E3717F50D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915B21D5A9;
	Thu, 17 Jul 2025 07:22:19 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022087.outbound.protection.outlook.com [52.101.126.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2672192EA;
	Thu, 17 Jul 2025 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736938; cv=fail; b=HNK/VLye0pltKA6UIK0/PhC643OFDlWKsRsGW0htnN0B25zbLj17jLP2aR7xEbnu1XLe/RY6O/KY6oZmss4vfcNb1cBfUMhg6s9j7S60thLB9mt5bBdNuAoWTRRA47aCnQsLUCDKRdwB5AlZWZ+afXM0FISvkyNLwuDN9Jm5L0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736938; c=relaxed/simple;
	bh=edy+5ElxroJP4348TtrTlsmHY00vcCr/yTHX1Vo0B+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6jqB8bcM5t8vPtNQdoONqv5fD0j6VLtbKmK3NNOPQZg6VfOKHFOykQCfrwbnRFH/uudfiENHzg0aOfdokrqZ5gy23UmVRBDaCqEDh3yWWZW1EM690E/RcQTE2E1eZLXZMaB9q7/Ng88YZeNeh2SoiD26fOrDY/hDU+csTMPEZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrPNFijHkeXdqxT693I78nIPefmfVOXcr1y5wL61WXflWw8lATncS8rEh4BO6e8/ETty/zSiGlk+2dt5SFsWEIiqfvk4Gc5TGPCQMEx5hzHpNLIBASyQasWK9GvdvWSv027AfcJ32/AnCsg3cl89SDsNWpVaWxQ8v5XJaqtrk4fow+gv3sMKwEgvnJewFxPOpNr3VI3WhLh3lOhTxACdHVwTuExFhg6gBMoQEvGCfi3nbOLyH5ptzeQZvl/Sk1W0gdjBbanlD3KcgSTaBAns8BjaAXI2rnqbYBlhWLDC/gCdO9+5PJlQWM5RrcDDsJuXV1ciD8jbBkmfA2aRBdvlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXzEBs56JYF3kuyf685C5oYk8b4lm1+jJLdzMsHhq2c=;
 b=YflRsJuvAOky7KeP5TrHTxdEnlFzUehdt0guCGFlE/hi1jh18tmyXUuRGW0cBCr3XDmKZyx5AuAln54i/xOFb+0/uvejtpu2whD8Ka5YwTdjuh70phe2u0Qf3U+jVNxpK9sBDVfk8A9EeXBDXENapYkHSoOUG/NJtEGkNk/bVNtCXNL+EWaH/YzcFAHhc7VGi1QOfBmGzMRB6uoBI3VFQwvbwD8XYG6sB8vVAi0jupjLAGatlFW3kzNqYXy0YCj2HIFSxbaoDK+yQHcGx+CT9cJ0MBj/xc7bYZ/iZ+CpjNK1iBV+FHi+CRvuytMlz+bfAI76vWYskDObKM3BQg+ZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:4:188::15)
 by KU2PPF6981E6D66.apcprd06.prod.outlook.com (2603:1096:d18::49b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:22:12 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::16) by SG2PR02CA0132.outlook.office365.com
 (2603:1096:4:188::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 07:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 07:22:11 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 090674160505;
	Thu, 17 Jul 2025 15:22:10 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	jassisinghbrar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	maz@kernel.org,
	sudeep.holla@arm.com,
	kajetan.puchalski@arm.com,
	eballetb@redhat.com,
	Peter Chen <peter.chen@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 6/9] arm64: defconfig: Enable CIX SoC
Date: Thu, 17 Jul 2025 15:22:06 +0800
Message-Id: <20250717072209.176807-7-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717072209.176807-1-peter.chen@cixtech.com>
References: <20250717072209.176807-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|KU2PPF6981E6D66:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6651e38f-6540-4bd7-bae0-08ddc502a5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKaMXh6XIPUVpsi3WZFgJ92Fc2qYPsuXgdYYm276ln8mgiO1CpE2iZafYOh1?=
 =?us-ascii?Q?IGSFOs5+9pQOteIwqAIIP/dQxZ3xg4pHIvghFJWK7s9+c3Jmwa78amTZz0cg?=
 =?us-ascii?Q?/nx9aOqY6wH26c28NFF+FGH1wt80f/vlXpQ4g0z/Y0XwhRu4MdpcNw8KRork?=
 =?us-ascii?Q?imv9xbRJPQgBzoLQawHIPbHpp5RX0jcefUmQMgSixj6YCR+MzXoBhsRuotvD?=
 =?us-ascii?Q?aVKUQ/FZljRp1+8dxNcaWj4ZQQjAZOwpIntDRD8VlLaHfVJ4x+YSWLWGyo4T?=
 =?us-ascii?Q?4qJJGYxXGLNIIhHA57aMB1RM1iYMAt4tzHNqK2rqY9LBpCTad+rGWkV0xqrR?=
 =?us-ascii?Q?X5+Rm34sqJtXNS9qkftfwE0z/QHRbvhHcBB3J2lxlSHhxhG/UBFklXXg1nFn?=
 =?us-ascii?Q?uJhjP8WKuBZ3ybqEBHYmWISXfLMwp4dC9D+3zuny3FUtqZQFKIef7EEe+eiy?=
 =?us-ascii?Q?1esB2nTwXayrJxFK4M0PPIkEgCUyBfrr1SWey/kzBXK+n5DL+4zQsJa6x3VC?=
 =?us-ascii?Q?bnNUgJHmUP6RcQEV+zRrGecKmV5rLxM7MA2jh0WWflKW3FkRvL/TZ2bI15ak?=
 =?us-ascii?Q?jA21vvnFlFVSI3wHkE4SBIQknveI39SqhBQCVwqQW+C6DK86yHy0A8EIAtQb?=
 =?us-ascii?Q?llP2UdX8pB7H0ZyIRevuQLEcakB6NQtNxulzQW1UqJSzBAfKOAAR8+rNbSRn?=
 =?us-ascii?Q?fBXnv9nTtIVD5A4MXjy+cjRh74yuICqDXqjvEr46sCHKcvFydk0P65qqPkeY?=
 =?us-ascii?Q?zympFVlvmLpIujipFNp53K4ud1xvGgjjm+y80PpqjL28kdM1ajtiACqL+50n?=
 =?us-ascii?Q?n8w/e4HQmMb7SjRpQjxfl0wp0GktVjSQvI+5V34eA0tNNlwEZk4rFwEd3k5N?=
 =?us-ascii?Q?FHo+Iu+9Kue1fKLCWpFHPYtqi0XKzXRzbyKcVN5RWjqIqUnAjvGO25Idlb0O?=
 =?us-ascii?Q?N0RGIxVGyrjWPtbR53zvo9XqF/dO6YhU1pfoXMY+gTFiuCkSOZcUY2MNNX0C?=
 =?us-ascii?Q?UddbfBQE6TD4w/HJgXb1iVUd1udbciDO3okNjxm27nXvZPFP0vYUVe8Eoq5O?=
 =?us-ascii?Q?VJ9eqFko29YJrn7tpGWFoPsYm7uoIYLyvm6hokkycgcg2F8IOUlOhkgAhE5Y?=
 =?us-ascii?Q?Fpq8BMGqbP+K0DDxBSc9cJmpbcnQPt9nwhwDq9ewFQcoshYMI31+3TSC0Pm0?=
 =?us-ascii?Q?/6n9K3aaRNwphe97f0iPM3umO5AIoB4jc1vewIViqcZuptKnRSFAlRxi7G4Q?=
 =?us-ascii?Q?A930kORxGLPFP+00iIDVfL13QjU6vlwDOhhJKCMgx4h7YGHpukZZPNXd0d+6?=
 =?us-ascii?Q?Vb/rmUNZJw9V5z7EA1kDbVLJonJ6wiao5ZDUJDKB5HfNUvWMByGfGKkoX/ux?=
 =?us-ascii?Q?n10KuCYqqPD9Z4JemHXHESWJSuKiXjOUm3lYRJtRXRm4CwcXHqGZZ3fHyuqQ?=
 =?us-ascii?Q?PaWjiNzQrhcTG2SWNuXsC7Bd5+pPvcLV801a3VN9nyjfmyIlnsPAhbVFiro7?=
 =?us-ascii?Q?1+On/gUzTPJYXqwvOxYXeCtaW8o10xXY6NiD?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:22:11.9177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6651e38f-6540-4bd7-bae0-08ddc502a5ec
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF6981E6D66

- Enable CIX SoC support at ARM64 defconfig
- Enable CIX mailbox
At CIX SoC platforms, the clock handling uses Arm SCMI protocol,
the physical clock access is at sub processor, so it needs to enable
mailbox by default.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v8:
- Add Krzysztof Kozlowski's Reviewed-by tag
Changes for v7:
- Add both CIX SoC and mailbox configuration at one patch

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..181c5f91b032 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BLAIZE=y
+CONFIG_ARCH_CIX=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y
@@ -1445,6 +1446,7 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_MTK_ADSP_MBOX=m
 CONFIG_QCOM_IPCC=y
+CONFIG_CIX_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
-- 
2.25.1


