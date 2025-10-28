Return-Path: <linux-kernel+bounces-873392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C7C13D52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41EF462EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB043301484;
	Tue, 28 Oct 2025 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="P908qGzF"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D330149C;
	Tue, 28 Oct 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643754; cv=fail; b=ARQ5E35tAuYpL41qZosUI68dIJkzvqJ8NFNa7/XUxvSGKL0ZW4IZ0ys3hum/Y8xwVDlhJtcjBGa3fJYx0ZhOVLJeZkxjDZ9JZD4xNP8ibPSjl4k4sORwjxKpnes6ya9awOXi1qhESEmsmSKjMb5AiJFTvJmmGKu6GlpR2Zjji4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643754; c=relaxed/simple;
	bh=KbvJPGhTra7aAN/4SsX5R4+D+n3TLbieOczFvgUq2qY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEOrP00K+iNNzgiO+ztwCX4YkuQlPKnXwkSefjo8+DO7W1gNcs4Pd8s0ONr4f6aGpIHI3iWIxlashKiRXd5oHUedQU0dutxpj4NQ8FP2mN/fGFEjnTWjxs/edfqASzl+T+K7XYez93DiLmkVPtgmusvzHX1dxj2tfuatxPfNdK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=P908qGzF; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZHCHGRx6JuVbn7N4M067S5hHJGl6QdC6I3Ofyoazy0rexP7PTpWgsvLvOCANQZJ1fnwPrNp/tlv0RH/9IVJZBUUJqrkjXmEXDD1YBZvOJCiQu1ARXW7uaowW/wF3rzNxFUv/rHIz2T/bkSA7d/IffmOGX4GE+z2rBktFztgyAC+rVGAOgXXnZutO4fEIqGEmvhWud8IVH+vWGd35PquLMuESvkCp4wcUHE7WHDzKgU7y/wKXUOBlHg3waAophdNaAqNxP8lBl4e/YspSYd+HlS7Rh5+PXm1s8+sDyFz4bzfFRTMdxAGbHmcAfepwY+xwmiGAhn/DzYpfRMDVrTPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eChPoC2Avd9GgbkJjFoq2AO+mCIt+I5u9NwhRmStbsA=;
 b=V1rWWPdtomxjtPL1aXg4z340ZAGQ+U+w0jjDgEMVJvr5CUZHldVpXnkd/Xoa+cJINoxOpdx8zzPvWZ3QUJN+36b27mhIf8ZC04nr1riGyZ+EwCa/Jr5bHnAw+eJtOEpjeRmKsK+PQkdYYQLzMnN0UyT2xW68b51AyxBktgZdvAHRYpoM1wf/cKc6brhz0pzEGv/LGCjGaDW0lsYAVb525fHE75InuPWVP0HIH9ulOfTfGrZtBGBRTn22CNgGiMSAh0f+7cJNs/PkQEvzFxOIiPyZeU5V3wii8Ot17BuSlRV1k9DslR0+xArTf1+ENeBegxCTXgQs55BVVN3smyn3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eChPoC2Avd9GgbkJjFoq2AO+mCIt+I5u9NwhRmStbsA=;
 b=P908qGzFAoEOJ0zsS4vyNtPRs5jlPgkkXujGimUdY5IzQ3bBgxGk1hlW/PAAsUf0Werw4eN2VGzF1UGLfV8QnlvfiKz8eMrVEILkask0GME0AcE3eX6O4TKWvQXnxNh1nCQOlqslSMepa/ZxpVCfouXspAhJjMFgVs9p/p17u9dZmsCF4X+e336WprJZpZyLgYBAe3hpQo2pj8RXq1n6kkC7tQkiQnCi/Vevk/s/BL2vjpJi5vqqq8F/wNVRGJVvX+sDMRsW+hoayhfa3ShhY9ZRfYApWNh4vUq+hdAdNxmNlbrFMQYUuI3bh7C4hZ44/8l+xFwxdCbgLsMpEIlmPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by DM6PR03MB5338.namprd03.prod.outlook.com (2603:10b6:5:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:29:10 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 09:29:10 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory region
Date: Tue, 28 Oct 2025 17:29:00 +0800
Message-ID: <a3182556c07839dcd9227fa6a4a9d295507f3e8e.1761643239.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1761643239.git.khairul.anuar.romli@altera.com>
References: <cover.1761643239.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|DM6PR03MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cab0c8-f248-4055-0cfc-08de16047364
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UchSb6I9hXvj52QTpLsShlzFfLFmUwU/sMm0ZZmWmR4IJf25xBY6pwduKTNz?=
 =?us-ascii?Q?e6sODcnF8p3eCsQGzc7vff6VkpCy6hF0H5RiiGumoOYoVa/cs64nxPYXa79Y?=
 =?us-ascii?Q?nO2FDpZwk7/zO+qR+/9cG3a9iFkXxoe/fiUna7047fAfsbycbdI034ekxnLD?=
 =?us-ascii?Q?wvLliyfv/9IgnYsGkA4AsQ/p+tydsf5y+DU9JVlooPpifE3t4ELUHIji+TVU?=
 =?us-ascii?Q?S3eOY/dYwfBHKlY7rpm1nSmXs+tor0emhzMRSScF0Qq9Bhcpnrq8DRxFZffL?=
 =?us-ascii?Q?4OqqHnxpsqqdT6C5PSHrAVyCUZSnwvdXjee4sf/QX7W09tmpuuYisavRJ4l8?=
 =?us-ascii?Q?GP3bJgKaJ6591gLajQ2IGUlVQDP3VdRCoPq9hCARJoQklLNyDT/veo506JlJ?=
 =?us-ascii?Q?KvszvlXjvoRo8I9uXPr1TzlDj8NXBVg43PaN8niwNoyGpWOF3VrC6E4EpT24?=
 =?us-ascii?Q?XJlVtG7191WTD6s7A61BwgaFZsmo2kqBWZJV+WIGFpZ69CTfKyj59x44+MKQ?=
 =?us-ascii?Q?/q4Odf85w52keVXIVhb2BmuqDASPOKExXbZQtj34hyY28mX5rtlgGSCxQ52A?=
 =?us-ascii?Q?u9XsXQkceOfMXD/uz/3DKTn1DjtYCXSy1tUCqKBNGZKfyO/SwNJ6zqfQv5W6?=
 =?us-ascii?Q?aBVXx8G3148skZCqchbbNFsW9Qkz0Y/1ajd6n1UHuWT961XQiJtqgoZ1q6xC?=
 =?us-ascii?Q?60SabhlCdY2+UL0f9WMsa/zS59/u8nsmJNM6eJDbUcZe4/X/M1QBpfCQCWbq?=
 =?us-ascii?Q?SfsbjPGPiKJJ2+nxtmUaaOR2+tT8iKyI74xUm1gBwlwV7hcLdVtZg0Y9LwQ3?=
 =?us-ascii?Q?/6huRwDc4lqC3jOmnwQnZ+C49AXZo1c3Q2gG0gbVkF3qUO1wziigZyKwoS0e?=
 =?us-ascii?Q?B4+s0pzP88MNnQf6aeFwI9cyDpGj4/2jdSWoTXIuKzbNBMwe+VlBGkrldzOY?=
 =?us-ascii?Q?ZG1OMr0osLtwg0HGt7bqQKs7diYLhR3qDwGJOkiRuzvJPHL8R0h6Vl338WW9?=
 =?us-ascii?Q?JZaweAq9+OO3wOZQbTlaovtr4GYjVE882zh7vmDF9Ub3NpP/OOnfotD/yz/c?=
 =?us-ascii?Q?YLGBBLLNRcEylx8lcurJpIfMDDwwNw6lLY3dUJFjiHFvUx8kVjLl5UTEwQPV?=
 =?us-ascii?Q?CNtioktLy9CbooJ1mXSXllbdqYl1DYwRML1cnLJF7QwIwW9HlksBb5rtifsl?=
 =?us-ascii?Q?sAuIVdSp8RbupKrVzL3KYBZeRyoMYSLiUcQGNJ6Th9liN6RbVd+BhGCCrBd8?=
 =?us-ascii?Q?LnDv/X2H5jrQ+7M6mgxOLLmkBVS8/f56SOSCi9yxiKMuWkLsGr3tievDFjp0?=
 =?us-ascii?Q?EvhGVQMdF+CALLKN7JaeG7wqaXYJKV7RdjRNS81uCqrycZcHPVRu0P5OOcY2?=
 =?us-ascii?Q?/aqp1or+k6/MKF7bdjMvgp/PE2L0ct0RvZwYf1f39FVW4c4xPAwe0Z/ikibW?=
 =?us-ascii?Q?H9lgeyN4kzYmyG7TKy5xUrlznxeFso72?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RX5dqSXZbra1KCrTPocZCITSqruq49O3QZ3HCNUZXQNymNaF5Ybw3eOzzVKx?=
 =?us-ascii?Q?WDgO3mjnbRLTB6EJgS4TflKc2nvq0oJ9/VNBUlZTgLpPbzYbFU1+Ztv3Uii8?=
 =?us-ascii?Q?SGbrMIcz6meVbrk3c4QaENYUmnYlGv8X+NRLBxwsKJA0QnQ07AT26iYg77KN?=
 =?us-ascii?Q?a1Oj8XW5uFiMPUTigZNRrQ/rq3AXT31yT8vb2Jd1+b3gaKyxOJFO90ia5mVb?=
 =?us-ascii?Q?+Hd3UQAMrQsODETMazVS2nFbsqJeaxbQtBDmcN/HUVI4AlTRuPXgo30U/RQg?=
 =?us-ascii?Q?xe1lmmdrg6JnPx+d+KJS+qsNUY4F/P318Yg+h1fMwTxdbLGj15vDrfwKj/G7?=
 =?us-ascii?Q?ZjzjMJXy1WoymW/GYKTrH6kCbh7LdKlBuykEaT4TeY2e4Im/EA4TUOOq5GS9?=
 =?us-ascii?Q?qqOYgp77AUfv7xvAL2dgeV67yYJNTp1I8AfJI3pIoYTxUSfpR0L0gakg15eK?=
 =?us-ascii?Q?CjAzL5dx/l+FvH15IYI5wl7Pt0vgxMsLRSkwcEVCcKXFR4R+kJWDoeVFT1Fz?=
 =?us-ascii?Q?R5cQv8ukTZaIhmXS76qs6I6uLB0RUA4NeLUsJHidgbH7dk/Rk3nOufaIuUGL?=
 =?us-ascii?Q?oh4biekVNM7DhxWTW8hXH2jkmUavTxVoDME07vfvDaQJizsmKZYutjLLTP6q?=
 =?us-ascii?Q?1/YUHyWojqYnxvXoHbX2YR88kjutaVeupGj9Dqg8r1SPfuezq2mgTOxTnVaF?=
 =?us-ascii?Q?oXqUdqwfU8mFtDM5NrD9cTyIqpvmiwNnWQPMURyr+2bUK7TxzPXP+ro5NCUb?=
 =?us-ascii?Q?KguON9D4kpFWjHW20s/D9bCVMtPfjTx0hyeE5cZCXbryXNNWqA0mdCqaRPRy?=
 =?us-ascii?Q?/PMu11jcLkTDam5XXkIRfEfPJN6xi/24394qSuc0jTjUuiPVH2i/fCUP5hmP?=
 =?us-ascii?Q?Nn+oRvXa+z5FrBWPbzxIr5iJt6qrtzF8Ne/1IvADauX2icUhVJLvNabm7U5P?=
 =?us-ascii?Q?5/Ivzbg0znVVYcG1rszy9VWAnlJm3k7FSNP/ZdihHyVE3L7r6C+TJPirie1Y?=
 =?us-ascii?Q?F92f6kkI9xqm2srRIllVrercsc2QOk7jXYrvmRm6zy4ofdbRSGUEb63hOgCn?=
 =?us-ascii?Q?ip7j+VqiVbDw4qxATobMqw/VQFL0uhTTUpf0CZK9pKKIjaKWESC/roEXycN3?=
 =?us-ascii?Q?ynahkW+nTF5JTi5YDS0ew08IziKjJ1XOnfQku//OWtEuqmhJ30KMha8d7sqv?=
 =?us-ascii?Q?xW9WAQ1KIUomGIkQlEZNOa2ZeGUtU3hIETcX2DSD4p/EY5OgCSyK6aK+weuf?=
 =?us-ascii?Q?b6+7ooHmeQRSAfNrDEgcpOcqCO+KieDKfCkTDqghqHL4UK3eYLtMENznXmFg?=
 =?us-ascii?Q?uipzp4J95T2O3NWbE1L8kMXdGzOGz2QjkpiXgFxRKEK9jK8kaOgDLi7ZG51e?=
 =?us-ascii?Q?XqPGVAQO49sP2HqmorGcQyNlWls9hV4CIUqohsTPb/XQxaFNxo8WEyahv+sF?=
 =?us-ascii?Q?7zYixV5IUXu7VU8awS9UP7ukkLbWT+EjSEYJuUC9X2ZaWiHe4uKi/2my8WqG?=
 =?us-ascii?Q?f/Tb7NToGL9xH1QJvX6T+uWeFeRQoyBLiZggxWThUPHRLkAN0HkYvow+ydYu?=
 =?us-ascii?Q?yPzXozY+lFsWNMDdmsA3b5EP02aecyN7P/Y2Tlxr1lAECTIswlhXgObvhhZa?=
 =?us-ascii?Q?IAz37MU44oam8ZWhLGp75xU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cab0c8-f248-4055-0cfc-08de16047364
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:29:10.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7kgjpinZkBxk8vBbCDglIJZOfjglL24feWgGk8nbiocvwVj7PENT/XfV8ZK2Z4yOujRl2jVoa4ZaW/6JjV5OAI9GcoBPeh9o2vPI1EK3VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5338

Introduce the Stratix10 SoC service layer (SVC) node for Agilex5 SoCs.
The node includes the compatible string "intel,agilex5-svc" and references
a reserved memory region required for communication with the Secure Device
Manager (SDM).

Agilex5 introduces a dependency on IOMMU-based translation for reserved
memory, unlike prior Agilex platforms. This commit introduces the
structural changes needed to support this feature once the IOMMU driver
is upstreamed.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
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


