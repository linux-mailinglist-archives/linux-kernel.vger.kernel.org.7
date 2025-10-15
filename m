Return-Path: <linux-kernel+bounces-853622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F470BDC212
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD7F19A2F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455B30BF76;
	Wed, 15 Oct 2025 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GWnu0omQ"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ED7308F32;
	Wed, 15 Oct 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494489; cv=fail; b=S8DfYTOMtYx/R7PVXpfsIR3IcYlC6SpaLH9JZG6rJyyStDaUl/XDEWZ7GkfwD2POJunwjsCwOtiZV1Zj0mwY6T6DLvWKZMtlZOMua1xfpqfXpF9ghFZWrkMcd37SLKKqWZLc8NW05CXJTGRDXOFxvM3X6cT5P7twf4CldOV3vzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494489; c=relaxed/simple;
	bh=SrU2R7qmReFAlq6K1/4g5SiZfeUV6qIiFzeefKszL2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPofoGd3byB3mbs8lX2q4c1ReLc1bcM6O28KonfcDrcAp7URG1BDJ5yF/lVe9zKGKZEXm2XIV1BUPdVwYxV0vrz55n5/EmhjgH5Vc0Ioe6Won+WWmCbySF/FxzXzaERUcQQ6/iXEozIc6l8EakLCnyhSIbjp+bUUjnaQmkwx5ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GWnu0omQ; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwVEAg1hNyg6r6uBvmul5zzVz7c7OX4tj6bdjkb+7FFy3TisDqn8XbDjdseWeKYAVH5g/zKAmlq5YvINkiub/VHicl9OulpuuWHG2ze8yaa44cwMht/lgXDJwCrQwVTpXinfSorBZvfzO1pgXSYnM/u/6pCXyxv0vscHvRaFg8LW1Fes0xXYjGFn0rclpa79i+y4LHpOMY3by1J38yQvvqZycm70Pke85RWWZ14F6zaaxlhC6nvHx3RKAgDt/cxg8q5ex+DVORhNyV7Gk6mg+abrhslVoGCVtixbSRqA8tvG2XgDrzZ5htCk1NgnVb7S5l6SC9zCrRL34oQhPPVSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F8SPI3nBtuBkNScNBqBiy4Vb3Osfx3nT4OWrO9hRCM=;
 b=UtQyNDdqR8ZX88BqlUUoTtjvSnWTWI+F6xaNbJBROnGLkXjwExww3F5ITAOIYqoTCq7hCl4OLP5jU3b5KmOcRVapA5BJuIoVy2KqzApU+RXzs9Li01WkixnNRs5jttGBaul6xCicBs/YNXT3a3Lv5eM/xrpiTmbn+qXmrgb1GO6Zc/ZfqVOH8Zro7OI+hBtfUqbdR2QhLcsslf+9PhnIT1xBK81ctrGN3djH+hyl4rypQMCVpxVOmQ+xR4n1U2edJL04Tm8xAo0es82cpsTIR3DGGm6mEUpnU84n1p8ZoHI2Hi5SyayXD7pCDaFSNBK4urVhuaPFzAFeDYAqPgb9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F8SPI3nBtuBkNScNBqBiy4Vb3Osfx3nT4OWrO9hRCM=;
 b=GWnu0omQc80DyThXqCsWcG7asBbWp66d2EVicpuB5b8ANB4KrtmjxlCs/BLyb926XJNQoE/rI740QE66MSqr9/KZFqPz+Anj+RQ+/2T9WAYENg7a1Q63GiIIa9ERBFibGxRSgt3bjxiZDAmMS1xNpKKLBRlboyVJ2kI/jUT0Q014GhevxztD2GfY7PTPwqX9XBPygKYjZcxqU0qdHIJB9raAe6Pdin8Cblrg5463BDw9sPPmJMsEOhMctWRLRRCaBRFvrtRLlUkWd0N5RvEfJpXYAj7VGnIRfvgt2HdH1PicdaOL7tQa1Nl3i+H21WiFLJGayCdvT4JndmGL4z+WHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 BY1PR03MB7876.namprd03.prod.outlook.com (2603:10b6:a03:5b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 02:14:45 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 02:14:44 +0000
From: adrianhoyin.ng@altera.com
To: robh@kernel.org,
	dinguyen@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 2/2] arm64: dts: socfpga: agilex5: Add SMMU-V3-PMCG nodes
Date: Wed, 15 Oct 2025 10:12:43 +0800
Message-ID: <1192765d18a1dd0886e2c5a7435dc0af922996ce.1760426064.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <fd13839ae0d1d67f77b4cce8641bc241005797c2.1760426064.git.adrianhoyin.ng@altera.com>
References: <fd13839ae0d1d67f77b4cce8641bc241005797c2.1760426064.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU1PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:802:19::31) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|BY1PR03MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b860d3-3cd4-408c-a1bc-08de0b909b3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKYXYLZqpF20L7e0MU8HZzXGtHKD0YYMSQ6EsWFhO0m/DWC3n0uPMqUv35f4?=
 =?us-ascii?Q?+rXPnIyYM+nU9vS5WK7k+56gYliu93R/NNNZy+i3QGr2zSh+UesNR08m3rB2?=
 =?us-ascii?Q?Y6G61gXDPcJlTarPMlGX6tflH48wR8p14spyusDfFEAxkxWVqDL2PlE52EjE?=
 =?us-ascii?Q?+JI8ZtP6hkAtZlM8ciGm1wAtZksWf+6gym+akaNZMeOgm0/zBvUhFLM5w/s/?=
 =?us-ascii?Q?fuTHP6TqfgnD5PZiNDUkIMMwjMJ0eV14TklWQtkyag3xCwPBCnsiZxTZYe7i?=
 =?us-ascii?Q?lNI9nRcpAtJMi8yxJ5pvSz+WKZPZaz5zSn69mOy3apJPKJzGxjIxz3sCIQHT?=
 =?us-ascii?Q?YIo5dZFI6J92/2OzAzSzYedF0LLf+8tsT7Xq7+2iUPfShu4USTMXTQlZTDU7?=
 =?us-ascii?Q?9nEUsCk8FEquL0HDWJg6lyFqc56xRr2et3jTiUBEy/P3Tc52JrYOdz2IlVUp?=
 =?us-ascii?Q?R7MUsN8nrF5NhvgkLvh2poAwwxxyVDErylde7xA1eYx5BlSJCvklB85QLSRv?=
 =?us-ascii?Q?UHzq3j9qRPH2Kdwhb5YvNPj44B+O4vvwIm6Ebkdu7LjqrYdCfn0eShOgCYHK?=
 =?us-ascii?Q?gsJMQYvo4etXKIypkqGNQDDoqznt7UqZYQbyACG1lnLjq2/++r/udsyMAAKL?=
 =?us-ascii?Q?JTZoDziPR14O6gbmYtva5ji361+cwG+CGTLPBoCZDsZ+9dQbJXy4+fN8qrFP?=
 =?us-ascii?Q?8V/Cg1e2XmWWiJCba8A6SNOEmLAfYuGWL3MLgabRuGXf4hiYUkXJc4fBtgw5?=
 =?us-ascii?Q?IPyxn6dm+us82xA0wWlUj0NyEfRH5jS4bYuvQCfHfzUow2crZPCs4ZDTtIrz?=
 =?us-ascii?Q?SyhA0YacXGIM/9olq0HEmZ0ORip6RrHecN44InQIwY7zsHzWsPrS6Jq/P1Ej?=
 =?us-ascii?Q?NX91taN9rXeRRf9bqoFkeoo0B8AX2kQrLYdz4wKdTpWE9V1Fl9pS+TKynvFz?=
 =?us-ascii?Q?L455qkCKwC9nj8cZIIR3CsupAX8zmPc5JN6gwR5lwVZKC1iLCcR/s3qVNusp?=
 =?us-ascii?Q?HJ2UmHOje3caQ8bZKc/fKyDrcNzBa1ohDKxGHyP5by9a00UjC/sj81bnO8IM?=
 =?us-ascii?Q?rqiW88d2u3ZJ5NviTzFJYPTw0waexlIPOyCjS8hMVpGAwrxCG5ihihCz5gd9?=
 =?us-ascii?Q?otRw2waMU3n6dyKgwYwD+gqj4aL8XALUGUc+GVEz4jbhleHS14orccl0rrxK?=
 =?us-ascii?Q?IH2NV7TbK40qRf9eOAPg999ybWBWTBEYBMbWXtylDjH10yLOzsK6SoZF+j2G?=
 =?us-ascii?Q?qJLgCh/OnTIJHSSuggFpeIzAXbU5CKakX/rJoXtDSW//235t3iCEZJveNKUX?=
 =?us-ascii?Q?fNFbyOAPvk2vluJ4xGNZc/iwO2zjVcBl34ZMgPQsBZLiAo6lUFt/V8GDyGq+?=
 =?us-ascii?Q?oiKVim/e3te2cbtlZU+ZZvJe+ZvY1tyYoyNuhiVeq2QtK/QknSAlXy9v2S0m?=
 =?us-ascii?Q?/y2IazekyhOh2U134Y41kU9BWCY+jTUj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpAx/uHivsPI+u20YRD5sXn+r7ssyLrigAcLutUEmCBK3DqKn37xru+1ERE4?=
 =?us-ascii?Q?nvd6Kk5c8STmn+Wvk5RZY1WSCYp+qCNkImJMf+FAy0Q/qvTOP+5ee3fvXYZS?=
 =?us-ascii?Q?vCbn6m+Mx+wD+DMx8JXLGwxjgoVw5tl90PCbRMJY+sRkJxxklyzWD4ZkzwTP?=
 =?us-ascii?Q?juv9gBo1cQsHo4ZSwxy5PwbF6JiYcWO+6o9E7tBUZZxN/AgehFnwFX4NB6x6?=
 =?us-ascii?Q?M7YED+vLGlXP8rOyB/N4ANcwByKxf80EGFnmhnrW13+Qn3V7DkwTZwKcCtTG?=
 =?us-ascii?Q?RG+T59UOalyy1TdwEHjjvgfDMdzNoBx35aalYbZ/ulmFJ133pXt2Xz6PH8ZC?=
 =?us-ascii?Q?O8OM5PsrOYOF11LRFi9wieviSx0EDZJrspOg4fEzBRLOXbBMFTUZ9pKJzjKb?=
 =?us-ascii?Q?tuuN6C+wOhIcWTOCflWtva+DYBv6RMuzRGnMF0gNcxPukFIe/aBygHv9L2Ol?=
 =?us-ascii?Q?vKxAvZ76iMTT1iPKvEK/12XwuVbK75jVsjbVAEjAeY+YhnCfenXsSYekgnMt?=
 =?us-ascii?Q?wwfALZsvGuuS6pjtc4E4yBWGOiRzW/alr3r6gGdMB83v0RPp8Rx3SL2MAiWi?=
 =?us-ascii?Q?O/L00XUQEAxHm+mA+vyPSXdYrf1u4CZz2P0QFf4O4eWCzwpTdpJoeBG0UBej?=
 =?us-ascii?Q?xfCQWZiaxX16C3X/TAf73PknCRZl+rPKLrGf6Z8FJmVCmFvRizOXsu3fAAh/?=
 =?us-ascii?Q?+tlS5NqJSIjT+DAlcOjGHtvqDIzYF7j0QVvqgh8YZrhMCHxaweOPXbq40YQz?=
 =?us-ascii?Q?HVFJJYqSt5HCm4839Mocc/HYHnhpRJHAlSKG5xA2CMYScGIwrHhJ0OqxmjIg?=
 =?us-ascii?Q?44w+dpqmGzanfBV2BV+yRpqWYb/LBYc+mO8EMBSeoTA+6uwKMic+VrvxBqX9?=
 =?us-ascii?Q?pEwZ+I6O+SscOfFwF2Z65YxS6Yi4LoUQ+9wXwlZYxfeyhp5mGn3cJMwmyd0D?=
 =?us-ascii?Q?4x+lSIOfSt1owSbMt/GRJ4eAasDDARcoJC/REL6cKqvMvYzp3o+otPnNbJGV?=
 =?us-ascii?Q?82+raB7PgjJlUCs4qg6jx+P7TmNu1nHKxnnKIqN5LgjDDZVIl2VxbKbK5Y4R?=
 =?us-ascii?Q?QHRBq2wPGEgzJqIgGP1d8h6WU2E/DbHnPeprzGZeu7vPo8zb07SR9GnJUHmz?=
 =?us-ascii?Q?KdUSKGiV56bvkLcNt+DpMb7Ch6EKDvX5vfJYi8csVJ7OLm1GD4EbSADTY11f?=
 =?us-ascii?Q?HoEgIpGSKeoi2F+44FII0NHi+vdXSMlwbJ5Zt0T9yHq99MXk4vzO7hV7H7uw?=
 =?us-ascii?Q?cmu1vU/p/PWJljXi83+iFsMnu8Vjb6N7aCca9Zbpu5lmn3Ki6gKhwdsHNHJ3?=
 =?us-ascii?Q?8nIeP0VYQK/tVMHqfDQUEmReFv+Nd6eq7v81xHmpCWfYVNhmh2uic/ENqiIM?=
 =?us-ascii?Q?p1MZxTCgH3ybXZTLXB2QXs9BCurxUX/5xY5tHtocWeacVd2FrFMcrjeKM2Kt?=
 =?us-ascii?Q?y69bXbzWOb8WfQYpRqGvWfFjC/u1AsOGMD5irX7TwAJ2PpbHiFnve8N4VRAJ?=
 =?us-ascii?Q?rTGkXlaXS2whL16bUG8gc2JKV0x5Suho32IgtvBih5ETNnG7/tbGUaZntv4p?=
 =?us-ascii?Q?ISdLWdSSQ80v05kIljaEqUVmdRUAM/y3Bx1f+lVpfnYxKD/wEsREuOifE8IA?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b860d3-3cd4-408c-a1bc-08de0b909b3a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:14:44.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKIm+9Lrz753rETQwYJJyuJITE7WkMVq5+U3qq3OnDHjX2LeRjEgfAmvH7cYf2FpQLKa4ovwF0zyoXsthxdNvEhkxjkJNq0LgxIqEVtZtpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7876

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add SMMU-V3 Performance Monitoring Counter Group (PMCG) nodes for
Agilex5 to support SMMU performance event monitoring.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 19f55a02bd56..633eab69e1c9 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -151,6 +151,12 @@ usbphy0: usbphy {
 		compatible = "usb-nop-xceiv";
 	};
 
+	pmu0: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		ranges = <0 0 0 0xffffffff>;
@@ -840,5 +846,61 @@ queue7 {
 				};
 			};
 		};
+
+		pmu0_tcu: pmu@16002000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x16002000 0x1000>,
+				<0x16022000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmu0_tbu0: pmu@16042000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x16042000 0x1000>,
+				<0x16052000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmu0_tbu1: pmu@16062000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x16062000 0x1000>,
+				<0x16072000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmu0_tbu2: pmu@16082000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x16082000 0x1000>,
+				<0x16092000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmu0_tbu3: pmu@160a2000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x160A2000 0x1000>,
+				<0x160B2000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmu0_tbu4: pmu@160c2000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x160C2000 0x1000>,
+				<0x160D2000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pmu0_tbu5: pmu@160e2000 {
+			compatible = "arm,smmu-v3-pmcg";
+			reg = <0x160E2000 0x1000>,
+				<0x160F2000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
-- 
2.49.GIT


