Return-Path: <linux-kernel+bounces-811224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF31B52631
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B60454E02B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CE623183C;
	Thu, 11 Sep 2025 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="QcMIDTZT"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D820E011;
	Thu, 11 Sep 2025 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555909; cv=fail; b=q/xNyU1L15iAA/xIvxbzKUDEnI5Gjr1Kp+3mN4QX81L3KnCpLoZEaDI1fO67rGxyg5B8o4FLaUACl9AAqGY82UUxMfVYdkYaewZdqfpyS0i+xy5VJF8O9ygbKWtQxrCf3sTMrJnQPg8xKJVfZTGdtU7OT+UokIQ8EYwwxjUf4as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555909; c=relaxed/simple;
	bh=WE47q4KfI9IzuW9B/zPD8O3V6Vaumqw3295tFuBRsQc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCa4PSJJbKJvqTbjR0zT1nm4r0GBk7CTXjGNjE+yIoEN0vjYsPRthwr+udcMeqF275oriK4bt7Y1BdAge3N9dhfP6iOFNXVzYkk0MIDaf2Hy9soWc5nnxjWEW76Pk1jqcG/JS6UvJdgVzh/ZeN03W4BEsyM1svJ3pGtfacyh73I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=QcMIDTZT; arc=fail smtp.client-ip=40.107.208.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0adqUZQpxK05w1IVGzfY6W280eV8fRtdwBgenKYX2gebmMyBtDSHOpBgl0UhNHjF4U97ue7Lmj1/2dmK/RAnMMSPrhsnq53dZV9HQQZkWwt4nneouy36tqRIZ6RU+xiKcleJpkbc6NUPEnFCrIi055FvOgWsvetMAKR9dN6o8lRC4imi+wZnQicoldNCFqbYgCLzoBf7egMfoHwV4XWoPUE2Ltu7aHrbQn3KfQJj1Ge1iV37sjOqStl5PdI+x27Yu7dzbe5uBCz5EVTaFVx9u0w8VuWUIhqpHL4OAFKZ2yEfIYY/8s22OTLnG+yEEzCmzqIFYDaQve1Sefl4zEyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQK+zxk/GgPYqtQ6h91S5LDiFI5zMNURTPh6n9Ke0PM=;
 b=vmqMyaPJLvM0KQp1OuapLk+A0uUHDvWZwSlxN6U9ZNAPBHmupQOWH4nTen0yDY737ynydYnJ/frog85GuJEal9h/lSzBjpbNi/0g3CiSgI3gSwZ7Q3ka79+tWeUCCPIOGAX240K1dRTDB27XkoucdbgeSNDkc1KLeXNfE1WI1JAf/8XY70IwyJt7B0KhyPQnNeRfQ6+h6hYa6ZlgK41b2LsAV4lBV/06m0LpuCDa0kl3pQguFXIv/fpuDLwFEmKTo6Ngt61IGkV9y5ekym3T58EEYb5v1lwqDHqq3237qjNhc0QQGx/4XY/ubQZvZAaZ9ALuREKyzvHZ5Z8ZT14ZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQK+zxk/GgPYqtQ6h91S5LDiFI5zMNURTPh6n9Ke0PM=;
 b=QcMIDTZTK9zmFUTN5zfnOj6NUUQ3OnAgZ+ASZhkCJDMs+d7C2zZ1myWMPE6izbwlikCFPm28r4RNPyu0dVKCjqvf7s6ioVxsBaHBXXQ2FnXFtTmXTKcOYpl9C1e//qnZG0rXS9Y1JaGUtr2HZZhgf2U/PfhFh1CDnMf5hcRRBQGS4UkdCAqAgiCWmRuxMj2gGAlgDq5R9lbHUjw2+jtQxmM/HOl5Xq0AbdOPJy6ZsOUbpWGEw6Emu86MSIKCxzWHxjZc1WNXYWq52cYwHtQx2iy+Qt8QjziZwz44Ry0MMOLF3AjELS4gwsWLoJzQlwT1sVmjnOKCSwwL8Y/+eOsnNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by MW4PR03MB6650.namprd03.prod.outlook.com (2603:10b6:303:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 01:58:24 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:58:24 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 2/4] arm64: dts: socfpga: stratix10: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:58:10 +0800
Message-Id: <b81326e74f23b4babe03f5812ab01b0a8c78f32a.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|MW4PR03MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 584a5421-9dff-446d-60db-08ddf0d6b0e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RzpVbCS+yHeJOxJ/3vJNN22rHsE9zwe/CzX/YIvN+N4QhhNZEgY0NqXeLQ5/?=
 =?us-ascii?Q?1hlcbkstR5bMhX65OHTrniHgaRO5VfGpU5TFE7siSTFrasfCNBwho6JvxVE4?=
 =?us-ascii?Q?m/KoP1Oeg7TP2Z/pCa/pw/uRTVEAyFONUw2yqc/gT5AxpQ2uPgtr8D8s+ugO?=
 =?us-ascii?Q?bDwY1JxIIViVoeVC4xr3lZlTnWn3kx3UsCjJGy+9asrTE7jP3/bBAcwN7iOg?=
 =?us-ascii?Q?j32auSvYChh4aFRnFasPGL9w8D0RMSCVctkEUom+5XDVe5NFAp9ToDHtGpFY?=
 =?us-ascii?Q?RF3JbdyIuN6S3vAQTDfXxpAbaQHZzCy7YEtchbvzJF13DurMUql+FyaaKSz9?=
 =?us-ascii?Q?PFGP4CxDY2p/jowypB9HmLRs/DVXmrfNdSPW4a41+nwocaR9P5ZtTp+sFWFR?=
 =?us-ascii?Q?uuI9ODFiVAH0eidfSd0cSkWefiLDR0TCICaalM5D46wIUHU1/M25J41k/UTo?=
 =?us-ascii?Q?1fP3MqaRY4e1qpTp3KVLFWP/oPGZZ9tm9xTeAYH6bXtQ6cMBWZpbrlOUi7Ut?=
 =?us-ascii?Q?GEA3WZfpLEeyXhhoHzOH8a461BR6WQsr2s6ApV1u/L59MmXaoyLjRgws/t4B?=
 =?us-ascii?Q?65llI5d4ZVBttPXzQncmNjFoZuvIRQThsRj6Lh/qvIa3Rd75UxMzeaZ7HcLF?=
 =?us-ascii?Q?lLMtNN+uyk/PhVvjciquA3QtwWOqeuSFFZ3FoZlMUUcm0eF3MCgJCvpkcJ0d?=
 =?us-ascii?Q?vWVHbpKV9cugDdbJyMTQu7iHPbooxYZHGbn8e/tzkQ4/9NDJNA4hAd8Emf+b?=
 =?us-ascii?Q?EM7CKFO3ya0VL9rvFqEdP51c5igpaDGpMDUecFdNd5fv8rT2j4RnDuppg1KF?=
 =?us-ascii?Q?Fbl6dAmwGFHfjTiApVZs4XZD0odakC8zWdk8t8cxkT8mEJch72seq1Xs+9aG?=
 =?us-ascii?Q?/qe4xBumA1yrgRhnSZp8DlzEMgPvbFBEEjencBJ/P52OqZ6ZT7iF4Y0hX1KK?=
 =?us-ascii?Q?B0gRdY06TjHr2QtQteGpbsTpjLRuRk4fWsC8cCe0kulYMRtUcgMU2PVrFY8Y?=
 =?us-ascii?Q?viW0dSWBckSFDO7R/rbVQY5ndVBchTxjCavK79vPX8Ma3hR3QNw/9frmFWx8?=
 =?us-ascii?Q?LsYPjtsNEa0jkYlZneCduuvGmTr75/WosJfRvwe5eVX0dfvs9gs2tBk12KyS?=
 =?us-ascii?Q?R18VLmr2RX7gFNvDnNcozWrQgoE006zLLFkghRIPIvKa6mjNrF/MF++Pw5eK?=
 =?us-ascii?Q?pvtFCQPq/RXGRk9oEsEDLVLeGlGf+ZpNiKhi6B42gPdtc7kYaLHvMM4heLk/?=
 =?us-ascii?Q?ClPqCfQE9L+pr66oCbSomWzxSuP5WdPxnNe8HlI64Pdi8AAbZj0UcJJpRQrG?=
 =?us-ascii?Q?4nG/gCN7PRH4+Cj11bLnHg3O6PZQHjAj8/FkZnCGSPNgADPQYV/etQ/ZyiqG?=
 =?us-ascii?Q?mZg48rjju71daeAh+DHGbWE9N2LlLz+LKRpacyQ9yyD94+zX/T8ORsajbHuL?=
 =?us-ascii?Q?sAf/JsnWecI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wxrQPFcKMeTxO0ptS08gu/nhTLMcwweY0SYNOXK8Lov6GTbSZbWqjuF/i0X0?=
 =?us-ascii?Q?bXv2c/jXXm185A+oX7IPCG9rm1KlLUcWgIc4VrFDoehXDpYOEQRVp0grGjXs?=
 =?us-ascii?Q?scTUUSg6/iiaKZT7Iz3/tL+sFtpHJSefp9lW8Vw7sxzxmyjmp3JDiFtPfK1v?=
 =?us-ascii?Q?SCuypWtuC/3HdqK3bWFtH5f2vPk3s1hvWpkeg7fI1/+Fh7Ed/tWpF8nEWx5Z?=
 =?us-ascii?Q?jdLY0x6VlcQzz2mXaFJIedvRzXSP5c76PIWqjpN1F9xcvU8czFqc4gbcVwwU?=
 =?us-ascii?Q?+9QutIjgL7oYqGq+Mq2NXlg+CWSt5cXVcnyfc2TWQkAKUC6PDfDqJpAeIUga?=
 =?us-ascii?Q?7wbwXQVFc2jL4gthKynFW7V2L0NGGmzrd3fV4ifduB73yNgD+tGtPI7QwkfM?=
 =?us-ascii?Q?DHLFrfRzyET+T0v3f5brQW3afRC9nWowrtlYFXXDclyFINKPnmQVAVq+MoBl?=
 =?us-ascii?Q?kORS8cGtwD6Hpz97epH0twmwBNNWlQiEHQ2WZdg6YaDFHl3rzCHCzA+LWUu2?=
 =?us-ascii?Q?5WFy7hE7GsDAG5nupRso4Fs8QkTBxRjVqNMHce4dLY3oPUJrZK8uTwbNitTi?=
 =?us-ascii?Q?TlY0cpyL4Y6OSdgLbLH7fr917WhQsg0OyEoI0bldPH98yH8ynYcaX+YjlUCl?=
 =?us-ascii?Q?RtvjzH+oiKb9XmtxvZvco9NE0brEx2GPBLsDihWKz31+zj8+BC/JQh0ceJfk?=
 =?us-ascii?Q?O0aMrRI8V5MEVU3DFv+t5lxcXXHv8jsDCy3bdNLwxJ9LWeRAMZydWYXzLKHN?=
 =?us-ascii?Q?rxa4Iqg3FRkPMg9UOa/jyteFFwY8a0G0ADrmoPCJ4GCGSYVgCxk48AYs1mzx?=
 =?us-ascii?Q?M3IR8AWLErfJ0IycA6Jrg8nwdXd0H7ysHNyrF3U3I4poifM9wp9F3pIXxXGj?=
 =?us-ascii?Q?mdP3qrf/JjaNbVU9X6k5v/36pRM4RObAio5kTXmrrec/a6fAZrW2cAr+e64c?=
 =?us-ascii?Q?B+6DMvnoQQ2kVv7QoVmQjsqwpgxF0j0KtX5r8sVWsOSYNIt4WMkRz5V1tCkJ?=
 =?us-ascii?Q?HXmdan5U+V1FZpbg1XOKIHglLCuldmBS9kCbvLwB+w3d579N+4vbR0CBwvZN?=
 =?us-ascii?Q?wWfyMiWPIYViiE9KU/SNV8YobyFTijJAi38dBc/ndW9IDlDxECF4FsRGSa/u?=
 =?us-ascii?Q?DvkL73ftPa82v8RWD/NG+CacbQe02R2WVp5Y8U24p0/GoOOUelODJSuz/WFd?=
 =?us-ascii?Q?RfCG+5R9+F7+h5W7XitFD87IzfEtHi6jeO8rsBeG6zKZlwwOySCIvVov6Kvc?=
 =?us-ascii?Q?sAZ1WpL68r5cCIk0QGP1WIERDRdVlprtjd+FTTA+DXOoE03aDyLDO4K+XYFg?=
 =?us-ascii?Q?adwudfbR534gkFQfbiAAgbVdGJBIzRFYTs2LQwewA/iHgEiEG+6c6JXlLutn?=
 =?us-ascii?Q?AAVuNGRcsnc13WKXCSkKSit0Jl/6uIZUmWYGgyiK+NGaExgwz9x8XzAQ/5eN?=
 =?us-ascii?Q?4s2LHrakJAdTF2gIbGY68WbIFju6brhvm8H7QQVOcVrDLBowwN30G6YN+t1L?=
 =?us-ascii?Q?+2pVyZ3Wv1OoxrB1hmxxDGYhDHT3zbBIV4EAv/OgoNsQwDj+HyGgXgEHfUep?=
 =?us-ascii?Q?Bu2YXMZdsVG9yV2w1m5ACCcnbSu7duxitpCvYIslQaKdotrHOrlpJuXR5AOa?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584a5421-9dff-446d-60db-08ddf0d6b0e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:58:24.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7EKkgTpHHH8WBhDQRjIF9YsxKiqfU3S/o+oqcG4q/5cch3CSj2DOnf01K2c+jnL0nNlb7KRcN7f3OFM4RUfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6650

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the
stratix10 device tree. This update configures the SPI controller to use a 4-bit
bus width for both transmission and reception, potentially improving SPI
throughput and matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 4eee777ef1a1..6ff6ea0c6b2d 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -190,6 +190,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


