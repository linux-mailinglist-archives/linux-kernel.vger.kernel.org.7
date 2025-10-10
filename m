Return-Path: <linux-kernel+bounces-848142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA9BCCAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF6407BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69E2EF651;
	Fri, 10 Oct 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yw2JLbbJ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9A2EE5FD;
	Fri, 10 Oct 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094063; cv=fail; b=gcnWeEecHq5NL7mVY7dscxXQil/obtbrM/awg3U4/L0481oTTjFRPJfsuB79DZ2BdMB3vbfRATM+cal0MaItWgieH5YCKJcxa8iWNbR34zhKqiOGC31uqscHFxnDDKcGOJYS+Rcidl46cTV7zXN6AqYMTCacN52jf6ydzGXksV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094063; c=relaxed/simple;
	bh=RZiP2Vfo6tqcC6z+2mc/tQaTSR98Bq4FbCxjtwK4O40=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GAx/+EgkKJ9whAOEYP4Oxw0uQanmvnX13fXcRz+9pKucmRZPgj29i7MAyTOshOvSRhXFCt+Uwl/gkCs+g+R/g21cgf5NmvJDrdRdVnJKN0YbTbnXu5sm3wUjXS0z9TNpwwIaDhIk5OKjXhKdmyMzEK/SCKA+ohMba1fUc1009y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yw2JLbbJ; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPdIuF82kUBTpY7n2+edF17iX7q6EloRnqfXKfJXC5ZGnw3obYvI7LbJlFipc7xerH5S8/YXlfcKYfb2vEybFNTyubr6eDjwBDr+EqBKbmIhDvJrQb40bRCWZ9ATaHv6mEynaZsgdSrrtm6wSTXKXDjgpjZQyfIAqBYYpCAhqDCUNByPlFKwqjE/kwhU9hMS2UWF2ptrBaOCf1SKH1EVLVT8M604omUfzSE3iwSvj87euj6dLLoocG7SFaOHL9FQ7mTWz8GXxmbERHfNX+LEBqvW3pLvG0yNgAxzEOIzhLiD9bXMcbuYfs7htXyBwKSqhRvlbz8P98nQ2PswHaTsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WJvUiPCL4Qiqbf2gNrMoR0RUK2VSoIL2I6eZBxD9WI=;
 b=SW0zHC8dIGeT2sqs4AbZExwcv2yie3HxJOgnEnIOpW9vp/KMxV2Hv8n0fa2cCxK4aXSgRCSKUXxUNSt/fh6izW9T8xgj6aTeDgCsJ994kxcqV/1KVQYMYW38PfWRh2X/w9gz8YfJojbacwXXkLnP+4PgT3Nll2opr8MvVnmcQycaYc1EeJeBYPV0983EQIS15/GnUgt6ux6g0IBEvX2w3DZff9fssjarPAHOSz99q5uD/ucTuOoHR2Q0/3nxX49M5iL1KkmI2whYoKxzOauANqKM0iFumT7glzl3JJZocUNBJGyP5zJHdoId0kwQrGH5acwbJ0RAKyKfEDPzFMD0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WJvUiPCL4Qiqbf2gNrMoR0RUK2VSoIL2I6eZBxD9WI=;
 b=Yw2JLbbJ47gfvMvyOQp/hVdTF2X00AGtfRwxoolZPMuUOpmFGfhjr1P1esvAp3f1px0rSZgtfdxBS2QPoyama08zzbbKUqM2LjKcOqTg9/vcn4uW0Lob4EllnP/pd4OCYTUUwa0JOdpsPRcxjRN5Rn1JOH3Zo146pO4CG+70/mU3PM6jQs/XL9jPZ6iLVl+5Oh96cKIuHGh5P1MX2JbXyTJVS+f+VkHSXXlU4L+Z2L9kWyMWtoaxpsC+7Ks89Rqi1mz0PhJvV1ZgbEwBaE635xkpqyt4W+ZEg4HxU3ZWui1Cm6EuCeSFjy0Xlxf0Y4p6ubZDGwLBRtgjZ0vVNViIdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 11:00:57 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:00:57 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 10 Oct 2025 19:01:10 +0800
Subject: [PATCH v2 1/4] dt-bindings: phy: imx8mq-usb: add alternate
 reference clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-usb-phy-alt-clk-support-v2-1-af4b78bb4ae8@nxp.com>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760094078; l=1085;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=RZiP2Vfo6tqcC6z+2mc/tQaTSR98Bq4FbCxjtwK4O40=;
 b=PZ73a1bfFyPox6P/fO/MxoQtWuq9DE07TWCVE+DEDiO8pZ1219ctBP7W8fSzkf9W/Kv5BaEQA
 DreWxNP/egYAZQ3BIaDUjNRntDiWviRBGLX8pyax9ZvJsQfTYsaTT6p
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 90885882-5a56-4b6b-8ee6-08de07ec4a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2pzOEVqcVR0SVlBWG5GbHNWQnNmOW1YclJFcXl0VzJWd2VHaTR3SFE5TEEw?=
 =?utf-8?B?WXB2d1hyT04vS3I5ZFo1Y0RMeG85dEJRVVE3b1RCZ2pxM0dxNmxhQU5jbmll?=
 =?utf-8?B?cDlBZ3RHNUxwVjFhOUxRaHFGZmZYVXhzNW9rK0pBMU5OcWVCeDhxbTZxeDBG?=
 =?utf-8?B?YXV6Zi9kalJIL3dZWGZ2dXFOMFVOYS8xMFRqSzhheVhTV3ZOd3VwbWVPZlJU?=
 =?utf-8?B?djZocnZTcDA1WUU0UzdaTHlpcng4ZGtSWi9BTnloSFcvNEJDZnBnOStpY0xU?=
 =?utf-8?B?QWhxVmR3aXJzZ2ZyMFJ4V3VMNFd6b3pKdHpZaVB3dmYyK1hKQ2xuVzJ3UnN6?=
 =?utf-8?B?MWhEUGwvaWRKWGRIR1h3N09aOS9vUDNpMzZqclZwWTBSMHd0OC9TT1ZFeHMx?=
 =?utf-8?B?VFcyZWVVa09LTkMzZTI0VHBpNytqa2ltRXY2cjV3UTdJWjhaQkZYeXhjbHNz?=
 =?utf-8?B?aXU1VjhjR2FCcEdBdHFUTVJuK0NBZUszQUFRdTMxalA2UXpyK2haRU9JTmY4?=
 =?utf-8?B?VWZkVlNiWWZ3TnVRU0YrcnBRNWpPKzNoWEtjSXoxZWlRTW9vWDVkQURkU3Yr?=
 =?utf-8?B?V0JFZzFYWENrYWFwUktBY2FXdllMNjlVZHBBZC9XakRpeVRFM0wwR3hWNUxt?=
 =?utf-8?B?Z2g2TFFxVGIwb2RXZzdxcXVqV2t3aWQ0TXFTNDV1aHN1MzVWWmRmRUhONmhu?=
 =?utf-8?B?QXpoWVl2bHlTb3NpSFVRbDlYcldCZ3NITXFjbk1DMGovUjJyMVV4T0FPdFh3?=
 =?utf-8?B?ZWxUdnB3UkhRR2QrejlaeGQwN2NaRHZsbW1qRzlzQ09CWlczdldLemZESTlB?=
 =?utf-8?B?Z2RKazRCMkpTSWdmcmxNZHNlYkJqbEZqNEg0L0ZlZEwxaitKc210ZHBGNFJH?=
 =?utf-8?B?bmg0a2Y3a2gwcGVLWUdrYWhsUFF3RXlOSFBsUHpwRzBqbXk3Z1A0MjBJVEdR?=
 =?utf-8?B?bGxuSVhrMEVURkM0MDY2OVlSelVQRlh2TnU4YUJUZEZzUHlJL2hXNUVxUnF3?=
 =?utf-8?B?bXFkSkY2MTN4dnMwSzFpNStockkvcytkNXh6R0N0YjFJd0h1eStpcGNpb2hO?=
 =?utf-8?B?ZjhMSHNuenllQUJERFNaMW0rZ0M3RzdiUTNxV2xmUG9FbzVlckdTZmtRR1ZM?=
 =?utf-8?B?MjFnS1hiVWJDSUZBOU9FdkxwSXptWEUvMFlZK2QvZDZIdXRHQXlFUHowL2tF?=
 =?utf-8?B?RDkxSlpOYTlHd3NZWEdDNVIxbVBibmZyK1Nnd2swdGcxS3Q5enAwTm9kVUdm?=
 =?utf-8?B?OEhFdk5MbGNaYkZja1VuM0NpTHRQUFRtNjArSm5mazFDVFlFam93ME8zTWpu?=
 =?utf-8?B?cU9RempmZUFHSHVpY0VteWZCZk1zOEJkeHZNNGtUTVMwY3hhZWx4S3I2Qndy?=
 =?utf-8?B?blFZUkVOZ2w5STVLSURBeHA2dGNYNEV6T3l2SGhsdlFHbi8vRUU5aCtTbGkz?=
 =?utf-8?B?d2ZWcE5zbTIvSEtsWnFrYnVqd01aMzVVNW1iYStxTGErNVQrV2FCUFd1RHNH?=
 =?utf-8?B?SUtlTnIxdkp2MW5oQzRHdnlEUlBUeXg5NDVPNTVlVXZtMStmOHZ1M3ZBSFdh?=
 =?utf-8?B?WjNndERaNnVZd1VXSTNhaFdhS0NnOWVlRXRhWDZQd05xbElxZzlNc0w1L1JS?=
 =?utf-8?B?OHVVZnc2TjdTVGlKa05ZOUwwcDFNS1BwenluSStQU0FMdzJqWlMyanAvVFl4?=
 =?utf-8?B?elRLNUE0Ynk0UTM4U0ZGcGRuRnF5MFBCcWZId3VNaHlValJYTE5VSWI2Tm91?=
 =?utf-8?B?RWVieE5oWXlBZ2Y5d0sxdmhtMGtUN0Vabk14YnZsK0JFbktyYUhISm82eGRZ?=
 =?utf-8?B?NEhWM2h4MDdkQ1BEb1MrYlBETi9lSklucUpkWm5lZHdNemJPM0R1SitTVkdl?=
 =?utf-8?B?bkpVTlQveXUrRWp1azd2MjljS2hSUS9teWYwTlZjcEw0ZWxjZmQ5YU02M05u?=
 =?utf-8?B?RGdjTms0cUgwa1Z2V0YrcHF0YTZPdmlCMTlaY1ZhcFdGbU9WQktLcTFhN1lU?=
 =?utf-8?B?WjVWMWdkSUdLNGlMaktkbTVwTVY1TFFDM1RBdyszZnJ4Yk9HTXpvd3dseTBp?=
 =?utf-8?B?QzNMdncrNTI4MFlsZGpNMExGNTZKdFNMNmNadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVZaZ2tFMlV0d2tyc2c5bGM3Z0d1bUszUzdHVWc2QkxsM1JzT3JsWEVlMHg5?=
 =?utf-8?B?a29DL0VTaU5vNlBsVmNkblZ4aEtCVDcramdJTXdYMFl5am02YWtsK2pHTG5D?=
 =?utf-8?B?M2RiYVF6TXRIZVh2Z2lHS0xSUEVGKzJKUU1sSkdJSWlaUGlJM3VndlZmTGZQ?=
 =?utf-8?B?VVZObzZvUktjd3lNVHpSTlZwMnFMdEhHbDVVN2tlaC9vc3ZxUUQvNWNjRkpJ?=
 =?utf-8?B?UW94SlJzenZPQUNaR2dwTUZ0djFlSmlYaXhLSCtMU0xzM0tGSTdhUWtCem5B?=
 =?utf-8?B?ZTNrd2s3ZWFQcjRwMVIzeVBVMlpRNkJ0S3NYUE9JSCs5eFZYUG1TV3VRZ09w?=
 =?utf-8?B?R0Y3T3hnd1QrK0hteVp2blZBVEpEbm5DcWJzN2hLQkJ6bWNoYjhFV0dONEVY?=
 =?utf-8?B?V1VvU2dpTGVCZ2llNHhnbjBmZEc3dEYvWEZRM0tOckp4SWsrNEkybDNTMzh0?=
 =?utf-8?B?b2luL00zQS9BV3dWVmhaMVJGYW9qUjdkU1hMcnpycU12UW1uUjUrc1g1Q0Fx?=
 =?utf-8?B?UlVPaVlIbEcyUnhPazlhbzZJaFUzZDZwNXVWRGRsU2RZSUFOU2ptY0pVNkhB?=
 =?utf-8?B?VWxuaVRjZy9jT00zaFFkUUxmVHRIa2htT053MTZDZDhlZG11dEFyVENBWFZU?=
 =?utf-8?B?dGE5L1pvaWFtQXE2YVlPYjJOdHA4RWd5bjh6eUVqSVVqSGp2U0kxS1dqYzJ0?=
 =?utf-8?B?NjNFMDVBOHFLSnRyeExSZHdHTFIzdklkQkdpRGNJYi9UL2l0ZEhmMGFOcFVG?=
 =?utf-8?B?YVZHYStla21Tc29iZ2ZLSEFoaE56S25xSTc5RG1SaTJRdEdZbmRzWlYwQVJ5?=
 =?utf-8?B?WmJha21YWk5VdFRsREM0MHV6eW1mQkFrMjQrci9NcStPWmVjeUU1RHlXN0Rh?=
 =?utf-8?B?OWNnOVF5cUdKT0Y3WXMvZ3B3OCtLeHZlMzZDWGdUcWl0K0dTZC9xc2ZPcklJ?=
 =?utf-8?B?WXU2anNOOTR5ZWVueVFrTTRhRUxybjl2R3RMMEc4TEwrQlAvZ3I3WTJmWG4z?=
 =?utf-8?B?NjFTVmNiWVltTmJQZEhhZjZtQzFPOHBCaU9VOSs2ZWwvOHlMWDA2a0RZcHZE?=
 =?utf-8?B?cWVMWWJFUjJZbDdEZ3hoN0tkcHdzMXRyQ3ZQdWNyZ2w0dUR3Ry9udUp2MTBZ?=
 =?utf-8?B?Q2I4enpCenJ1WVFITzNvNG4xbGMzY0tVWEhjWHRBeXdwbjZCWGt2NTB6UnBl?=
 =?utf-8?B?NTJyZU01NnluelcwVTN5T3N3SnNFNnZwanNMT3FOQXBDYURpbEpLdzJNNWhZ?=
 =?utf-8?B?cUdZcFNqL0c0UXN6bVM1NGdlZGJtVUk2aldMbUExekVXM2xvRHJ4RUhMKzQ5?=
 =?utf-8?B?aURqRmdCdzNXT2NSL3JORlFGamZSWmVpcGdxZ3dWRG0xUVJ1TktnK3lIbGFW?=
 =?utf-8?B?Ri9KcVVRRmhwYzNkSHNKd1ZCb1YwS3Q3ZkROdFVpOFV1K0pPekdPRkp4Wk9L?=
 =?utf-8?B?TTgrS3VwckdLOWZFTzNHdUN3Y21pd1MwK21vV3RMV1VTQWhDZEUySm9tSjRR?=
 =?utf-8?B?OWx6aTlzMFpxOW4vT3dBRWVtV2VkMmdLR25RVnl0Q0ZSQ1hjQW1vc0FDM3ls?=
 =?utf-8?B?aVB3ZXV4Wklrd0IyS3JZVFN4NEd0RnVMODdDU1JBckxEWUMrM2hsNENQOTc4?=
 =?utf-8?B?dzUyY2RoQ1dJVFNCZm1taG42aUdza1p5em5iUmtxeFFQUmJmZFBOa0R1QkpY?=
 =?utf-8?B?Q3o4ZmhVTmdGL0JVd3ZpMFZSaVVzdkt0bHRCamhJanJHTEQ0ZUtqMVhWMDB5?=
 =?utf-8?B?ekI4eCtFR3NSYlM1N2pmekVDaUNKR1JpNExqeDR5ODdzSG9xdWlwZUl2eGJI?=
 =?utf-8?B?blZoZGlPYjJVMjFjckV4TmdhZlFOLzZuQWFBRGJocktGYjRCaTJsaW9SV3do?=
 =?utf-8?B?c2s1Q0wvT1FLOHo5cGNTWjZIZTV1VUtwQVdwU2dscnVCMWhnOG5wNm1iYWF0?=
 =?utf-8?B?ZlN4MDFOeEhjd3RSa2cvTWdXT1Ivekt1N0NXbVY1Y3dGZzZWdVVUVS81QWFy?=
 =?utf-8?B?OElOWmU2dWNvMkMyT2w1N3lodTA2a1I0ZCt3QnZIU1k0RWNDTU1Ha3Qwc2d0?=
 =?utf-8?B?akxOUlF4SDZYUm1sNnd5Umh3NC9IU3M5NnI1R3YvNVBpVGtsQ0xQU3dLMmh4?=
 =?utf-8?Q?8OWDlFdjl++lqtZaTPeJppOHm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90885882-5a56-4b6b-8ee6-08de07ec4a0b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:00:57.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbYaSmONQOKTWKqWAN/OiGAr4MmqYxfkxFPyeUdizzPMnMIK7xBBdfcGIhaYokIPJAXd2tb81SGhCdyS1NTPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871

Beside default 24MHz clock input, there is an optional additional 100Mhz
clock input 'alt' for USB PHY reference clock.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - improve commit message
---
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index 6a47e08e0e97b286538798190225ca2966a7ab34..081deb502e21308970a9495528bd745b9085f2f0 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -27,11 +27,16 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: PHY configuration clock
+      - description: Alternate PHY reference clock
 
   clock-names:
+    minItems: 1
     items:
       - const: phy
+      - const: alt
 
   power-domains:
     maxItems: 1

-- 
2.34.1


