Return-Path: <linux-kernel+bounces-861776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B04BF3A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119F918C4248
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE22E2E8882;
	Mon, 20 Oct 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cjz0ILoa"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DE2E03EC;
	Mon, 20 Oct 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994421; cv=fail; b=QfunINOv6bg0SEEBmejWl3aklN1LsKp+XHoUWOn9pxc2Q1fp4EUai/nv45w8EKE/d0agTWRZwN6aBu53zkHPAxmoip+zCAmS2fwDiLGOJ2F/9XYP33JUZrqCKNi0Jpuv5NtKQFXfbT1zcacCju6OveV7LQt62Jj/i/cumPK7TC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994421; c=relaxed/simple;
	bh=+xOdlJAgwJvOzpR/Wrw4OHd0WKzgdgrwViYyZLGu5O4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SDYeGncUE2NG3zZbcMP4OSyCL1WpVnsx3G1CgDfh6nlBFtFE1DUMIweVp+zgSuyi8aQLeNoHGmjUFIn1hNDS4k+Dt6YMidZgCDAcEuGZknOn8bnuZrViYJzMBs9Di5aUkHDN0P+aXRdEcGP7sLTQObNKB6J/VMfI1lfxLX2Fw0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cjz0ILoa; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3GqIqjtooQxGkhRnBttrSTJ47Z2HbXrDF8YPGkMGrME3RWhbrYy/Vu5mKqDkXkYMWksh57S2Jk/djfBmIxqbLU5PhbeCfutVblWXAq1GFhlfSPN3E58UivytxLQG24Cf6x2JETsxoVnGQj95nWue8/2+BrXFSCepBwyGSVOdvx7eB/dV7VCCnVnpyA+Myg00ts+Wn3cBtrYZG34LglHkw4WWx9dgXk8AvJBsGXx+hh0Pa1eT19N2HyeYPIw+ied0xTYLQ20Ix59gIHQHM9rdhsAkEQtqjDw5JzGSTQw0zOT9HwITgcv+ddahWOwsgWnN8kq6I0B8fTkEqBeIEhSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKhCueyb8/VUqP0v0xka7eH0hoqyIRxI/4Q501thA2Y=;
 b=cd2CrY69rVPMTFvcewD+QKWaSD1+u1uwM/up6Q+coWXUJxPAB5mJP5IvBoNkyEgWSbekJiNS7pshElda07lqwfYzoMGHYFlGc+SdveMytotdqavuVbwjEwv5Q8zwYYdRKDjHdHT3ZUi3LI7q3CAOhuLfeTT8LQvwuGdRgNpC4S8o6LyzGVlvTBhwjUUKIcQ4jpKszLkp639UeGjdhrEkJ63VSXMik+ARzH7npWV7tuzoEb75eloKN4eLBp1x9CI09dkAHDgjDWsjSIYkiDv6MgqEfGbADSEX8W23zKEUZRTmzca8K0/BKKf7IBxToqsUoj1W0EnB28eTI6S/fPAIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKhCueyb8/VUqP0v0xka7eH0hoqyIRxI/4Q501thA2Y=;
 b=cjz0ILoauX3ASxaN0Wp4q1kjL0SHfkN+lwHxPtfqwMRGdyCGNagV6MSQuEQVdn0LP3zQkeLd1agsiHrpPx2wCuqdhKcz+UNRzj5d1NDun3b3GPaV0gjn2+napZwbRJO/tLoE31rbyTLUypvLFrMpP9qKGBdNXgMmsHNe0TqGJvTiHyu2YdxoNG+Y6ITD6b7abOXFHcbwg3aN92nUNFV0q6hpMhtprZ+0c7ifr/V74vf1BkzT9OAEZdXWLlw1LYk5V+L2IY/HNpmhFoRGhKRBykWud+sbSJ2AaT8DBjrzdfCaS2P9YckspJqzfSmCDVRyxhuAMI0lNQbrXffEt/kzkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:06:54 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:06:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:35 -0400
Subject: [PATCH v2 1/9] ARM: dts: imx: add power-supply for lcd panel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-1-3c12ead5094c@nxp.com>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994407; l=14072;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+xOdlJAgwJvOzpR/Wrw4OHd0WKzgdgrwViYyZLGu5O4=;
 b=zFWVTZVfTeyroBUvSSQiCu92GRk3iQOOe0yoKeYdNmihZtZS/QUU1pbZtzxPS/qiamHBfLyZP
 BwtcvY7DSIDAyTUwv9oXK/+F3aR1pdkGHpsEy4mfk9dkx8VWF0RRdU2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: c56c1a42-d397-411f-7a5e-08de101c98f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0kyR1Z5eGxJWjAyRUJKb1dpckNoN0Fsc3hwQndQUFRaRDYxN3lMczZXUm5O?=
 =?utf-8?B?RC8rWDIxLzdVS1QzSkMzSUVMZ0M4R1hvLzM5N1lKYSt3MmZzMWduYXNSRjY3?=
 =?utf-8?B?WDhVcHBqSDNob1NkQkFZaDFsN1VKWWJWYW1jYXo0SnJUNXpJaEZraUF5TDFp?=
 =?utf-8?B?eGZrRFZxa1hTb3RjalltRzdnc25xaTl6WHdZa09TcXg4UFRxMlU2eDc5U0Vn?=
 =?utf-8?B?TENMQ3pJSHRrVGl1c3ZHcnpCL0p0VkRZbm5ob0M1cmN2WmJWSkRXbFZWTUVi?=
 =?utf-8?B?czE3UkhNd1NjNEgyVVVXRFBWVkxNWVh3VEVzcWY5OEFqRjhqSVVFWVRYUTVI?=
 =?utf-8?B?MU5NcWFvSWFWZ2E4SWZRR3BiYy82VlV4ZUZyNXZXdE54VCswcXgvVzRGbmh1?=
 =?utf-8?B?MkdXM0owZlZORjhITDlnQ3ZBWENXaFRlVjd2S2ZnUlNXaTRQT1dSeFJTY2VM?=
 =?utf-8?B?VHVqalA4bGJNZFBPc3ozb2RJZE5aSDZxN0FKUzgrRHNJRU5GUVpFY2IrSUdP?=
 =?utf-8?B?cXlwVURqTUVEMHhjTkNMYXdxMitjWjhwUUNqYWV0QjljL3BZVnNsQ0FXZ2dk?=
 =?utf-8?B?dHJHYjB4RHhKbE9EYzNtSER2ZE5jQnNzRlg4SGtiRFhNQWpQUEZjU0N4ay81?=
 =?utf-8?B?ZSsvZkc3Nk1XWW1sUU5tVC90YzNQVCtMZ256ZFlwTlNHOHZtOTJqSUs4WC9G?=
 =?utf-8?B?bFl4SlFEZWJSOE5lNEdhR3l0T3dvVWRMa1p5Rk50VXRmUHNndERNMmFPR2Rj?=
 =?utf-8?B?ZUl4Z0hoMUtBS1EvQzdpRW5FUXNBeS9KL2c2K2sxellWRHVFS3MyS3FLczcr?=
 =?utf-8?B?TVRqKzFlajg0ZmpydWtJTUMwK1dTOFV2Nk5rREJFVzJJYTVPaHh6SWZ1UjZm?=
 =?utf-8?B?ZmhKZ2xKdC8xQ1lHcGIxVFRGZGFVdDNMajBjVllMaDIwTE9Oc3F2c1ZSSE5j?=
 =?utf-8?B?cWhBazJTRmtKZjUzUFJ5SHkyK241Z1ArUjhJSko3YXIwZFFZU3pZUjhFUDBI?=
 =?utf-8?B?ajlucXZQVFFYMjdpQkNWL05tQVdmanIyK1lrNkpBSDZ3MnpCZnE1QjZUSURY?=
 =?utf-8?B?YXJ5REZicGxRN0U2azlJd2JXejAwaW5ZL01IYlZFei9uVTB5QWxaNWUrRS9m?=
 =?utf-8?B?Z3pNVnVaQm0xV1FRVUQyL0VsWURSU0ZlaC9KNVo1cEZGSHdOMjVmbFNEb0M2?=
 =?utf-8?B?b21GVlllUHVUbzk5NTZmdjFjNG96d2R4MEd2MWRONWdEdDZIY1lFVklUUlRM?=
 =?utf-8?B?WDE5ak4rVG9iNEF2cmJkL2h3dk5DV21wdjBXZ0lCY3FWN0x3TGQxQ3lmSWVM?=
 =?utf-8?B?d0hoWHVwRHpTZWFFZFY3d2hPRUxMZjB2eWVwcElMR21UZ2t0OFdIWkhVUzkv?=
 =?utf-8?B?NEdFVW1wMzRvK3dnbzdoQ1BnaW12Z01oMGgreHhlWlNpYjcyK1RnUXQrVzZJ?=
 =?utf-8?B?WlV2ZWJIMDhqRFdUV0pHV1NJT0JOOFFuYko5V240dC94WGZnbVB3QS9vZGZ4?=
 =?utf-8?B?V21Obzl0dUlwK3BvSlFQNGFJMFBUeHdXMHhHMDdYd1dXV2svaVNpdUw1NDAx?=
 =?utf-8?B?UzB4MDJuUWtOczNlWmZMOGFhdVJwS1ZTdHFGUGpSOVFjMHdwRS9PV1NQS1Vp?=
 =?utf-8?B?QldTZjZvaktHSjc0V2RBUFhvckJRQTAyN0JmUnlrblNEaExacFdvaVRHQ3E2?=
 =?utf-8?B?cXRTb2I4MXRQSFdacmJ6TTNoYUNhTUNiU0VMWGtKRHM2U2oyclc5WnZIUEJV?=
 =?utf-8?B?dEJoUmRya094ZGZyaTRuMnBmVXhoQ28yWGt2UVVUTDFFNVdoOUFwMVA4RVFy?=
 =?utf-8?B?MGNyMUE1NkNWQlAvWTcrRFlvcFN5NGU2YXhPREdjMFdaNU80dngyWE9nbFZF?=
 =?utf-8?B?cEplK2xkQ1IyRXpMM1RZMmUweTQvMngvRUZIanJ0VkZac2dtNm9WTGdVVVJR?=
 =?utf-8?B?ZWFLVVJXZXBaSThob01Ma1hOdWttYUJGU0Y1Sm9rTFp0QjYrNnc5MS9uU09F?=
 =?utf-8?B?RlIzUmUyVHVYdkhxMEVscTZwVnU5cnVQR2VNTjV2MmtYc0k3b3Z4UFVlTGUz?=
 =?utf-8?Q?m/MgmE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MndzcnpLQlNud1hKZHptWGJKZnlpSGdJN1Z6QUx0SHlQNGVKUGxzajNBcWx3?=
 =?utf-8?B?aUtvUnFUcnY5UW5URjM4N09LN0w0b1VmTW1OQ05BZ2dNSEc4WmtSbHlGblBq?=
 =?utf-8?B?NzlnTGd5Ymc0R2hSYldISEdtVjg5YzY2dlg2TWhmTDZ4L211MVZpelZSdHlW?=
 =?utf-8?B?RmhWUnZmRHd6TFRpUnZvUXRzSWREakdEUUd3K3ZFQTRyKzNOa1FXS2dxYmpL?=
 =?utf-8?B?T2drZkVBc1dkSEpmL0hoemcxODhzVDBXTUE1OU9xZFpRMHpqOGF5bWoxTGMw?=
 =?utf-8?B?YTRGUnFrdDFodCt3TlBkZmlEZUg5MjBXRDJ1K1E1ZlVJTmszSFRBU2ZmMjhQ?=
 =?utf-8?B?bWVITUdXOGdMT1p4YVlCYjUzM0ZjYVd4aEkzbHRWY3RKU3RIM3VhcFpsSkw4?=
 =?utf-8?B?aGE3NEdFT25CUitiV0JQM0RTS1BIQ25NRE8zYkVQc2ZnQ0NST3RlUUM4endj?=
 =?utf-8?B?amVQcldrNWp3cGFnM2pZdVQrYkJIdmQwUjU5eTIwY1JDYlNlaHNKL3c3azU0?=
 =?utf-8?B?eDNoQnpRVTFvMkVaYzhvbFAwMUhpWUc1SDlmMXlWNUc4WTZRYlBqZWNGcUFP?=
 =?utf-8?B?enNRRGQvVlp0OEorUEdNQnZNaWNpTllDc0dCNXQ2WVVHckFNWmtqaDZoT2xp?=
 =?utf-8?B?aGtROFBSTkpxcy9HVVAxSWticVgySTJOVC94M2JreWFZbm45dUkzS3FmWS8z?=
 =?utf-8?B?cWw0dnYrczZURmtFdjI4KzM3L1NCeExOMnlleXhadDZLM3IvZHFkRWUrL01G?=
 =?utf-8?B?NlJRQWgxK1hndTdMa05RWkhOWXNHWFJYSWxkWkdMV0tvb1hoVWN1aEgyaUVo?=
 =?utf-8?B?V21CM0lLaGZ2VHVySjBKc1FpWkNkL3cyUVkwNlNMM0JWcHFwSEdkNWF0aXdw?=
 =?utf-8?B?ODl1bDRMUEs2QUprZkg1TWlkVGZhY05OSzlEN2o1WFJxdWxWTzVIUHdsdDMz?=
 =?utf-8?B?ZE1jYVk3ZXpNbHJ2QlYydldmZ2Zya0hVV3BaZ09VYmp6YXBNUFJkZGRqZWJ5?=
 =?utf-8?B?S0x1eTZzWWRpOVYxZkpaM0F4cS9Ha2NpWDQ1emtldCtVQ25LSi9CNlJJQ2RJ?=
 =?utf-8?B?V2NZemt3N0dRWnBWcDdyRTQxYm5TeDlDQzl5aENpZ0l4bUNLa3BKQk1WdXUx?=
 =?utf-8?B?aldOZWlFbW1CcDRPYlJ5VWFmUDFjR25lVytTSzY1cEJRUGE0cDFTYTFIb3pj?=
 =?utf-8?B?SHIzUG9qcytGRk5rRnFxZ1BvcWFwdVJBdTg4Y01Qek13ZVNQUWpwMUFPenUy?=
 =?utf-8?B?VG5yOHRSZFo2TGVUMFJJdTVOUHViZDR2NDhjZ2ZoWENuUmM0Y3kwYkIzK1VU?=
 =?utf-8?B?bDcvVnpxT2xSeE1FdVpFMmd4Qkh6L08rVXMvb3J0VVVtQTBMMWdKbjA1ZWRm?=
 =?utf-8?B?YS9laGZqZ3FhRGwwMVd3VWNlUUl6Z09LaEllbVU5T1ZCNCtHTHVZUHc5NjdV?=
 =?utf-8?B?QmFFSlczc3lEOFFpY1RWVVR6R3AxcTVsVFNscERYZlRXT0ZjTEpmQTNRTGtu?=
 =?utf-8?B?b0dMdjl4eVZRU1hXU2d3cDRIWGFUUDRoWnY3dTZhdjBGbUdMZUlKMks2UzR0?=
 =?utf-8?B?TGZldWQ1MnBzclN6Z0FmVi8wRWZZTTFJR1hpMXd1NENRVDQ2eDQvL2srRUdt?=
 =?utf-8?B?dE5LcWJwVTlKS3EzSlkyTlJnb2FQSXF4VWU1N2o4RlhYQmRxajA3eHdsaUMy?=
 =?utf-8?B?ZHBmMHBTYTZ4K1VDOXgyM2JMa0VXWFlaMlNBWFNybGNKb3NtVzRRNXliTDAx?=
 =?utf-8?B?R011ZTRFWmdoT2JEUU9PMEhXTERmeTNyMW9SV2lJRWxWeXZjclVWVERzcmgx?=
 =?utf-8?B?YjdyVmN3ZFM2bHNxL09ZZ0RYR0tqQUVvaHJOUFk4c0ZBZ2llclVYM0xsSmMv?=
 =?utf-8?B?a2lWK0JBdXlFZ0tVVXJqVlAwNFVCa2o1ajc0RDErdmc0cXRZZW1ydStaQ0dD?=
 =?utf-8?B?WUpNaXdHeUg2Y0tRUUVmTXJRN2FPNkhnY2pOK2JWK2xMTXMvU09PcnRnWkxz?=
 =?utf-8?B?KzB2blRnbVNLaHBEMXE3TWJjVTlLODJIVGdUSTNCWjEvcnd1Wi9PaXY3cVQ3?=
 =?utf-8?B?QjJzalpQeDdBVzhkTHAzY21xTW9GR0UxTHBFU1lSN2Y2NUczeTZ5SXRFOGJT?=
 =?utf-8?Q?xUzhIEIi2ATsp/aCj0bVQ/Te8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56c1a42-d397-411f-7a5e-08de101c98f6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:06:54.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxflZrEfaqf7rE58CNp+Dgsxt8FLJFyHW9mjYv17Npr1hStlQMMqeJ67Z5On1hOJLoOLWPmLqWtye3JhIjgOYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Add power-supply for lcd panel to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: panel (sharp,lq101k1ly04): 'power-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts  | 1 +
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts           | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts         | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts               | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts     | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts     | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts         | 1 +
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts            | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi      | 1 +
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi  | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi     | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi      | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi        | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi        | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi       | 8 ++++++++
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts         | 8 ++++++++
 17 files changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
index a7400d42475b49928d0b3d376516e58cb8b656a3..bf8e07f971435da537e2b8a64be7bcfc01f21955 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts
@@ -20,6 +20,7 @@ memory@10000000 {
 	panel: panel {
 		compatible = "lg,lb070wv8";
 		backlight = <&backlight>;
+		power-supply = <&reg_3p3v>;
 		enable-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
 
 		port {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
index 7c62db91173b78659372b3095a2676fec4eaea0f..47a6d63c8e04cf28795310aafcdd3b2b05740830 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
@@ -72,6 +72,7 @@ led-0 {
 	panel {
 		compatible = "edt,etm0700g0bdh6";
 		backlight = <&backlight>;
+		power-supply = <&reg_panel>;
 
 		port {
 			panel_in: endpoint {
@@ -89,6 +90,13 @@ reg_otg_vbus: regulator-otg-vbus {
 		enable-active-high;
 	};
 
+	reg_panel: regulator-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "panel";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	usdhc2_wifi_pwrseq: usdhc2-wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
index d3f14b4d3b51e19a5bdf52f9d99da4b314da7811..929def2bb35ebbd40455133e7b0cfbbd34d7f61d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
@@ -46,6 +46,7 @@ backlight_lvds: backlight-lvds {
 	panel {
 		compatible = "dataimage,fg1001l0dsswmg01";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_lcd>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5dfb288c69d702ed190150caa92ba7a..c764634cdb2bc6145590ebd1636c51b6d02be1f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -55,6 +55,13 @@ memory@10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usbh1_vbus: regulator-usbhubreset {
 		compatible = "regulator-fixed";
 		regulator-name = "usbh1_vbus";
@@ -81,6 +88,7 @@ reg_usb_otg_vbus: regulator-usbotgvbus {
 
 	panel {
 		compatible = "sharp,lq101k1ly04";
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
index 02aca1e28ce3feeecebb737b09ea4f8208974e43..1ad3bdcea4a3497dd5bf1c6ad0dc32cfa8af9522 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts
@@ -16,6 +16,7 @@ / {
 	panel {
 		compatible = "ampire,am-1280800n3tzqw-t00h";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
index 241811c52b624625c7a44cbd46558b78d5f5b154..9e1c64da0b30adf371958505614cd47a0c451053 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts
@@ -16,6 +16,7 @@ / {
 	panel {
 		compatible = "koe,tx31d200vm0baa";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
index 56b77cc0af2be51d8eb6a9b0931d977e1f267670..b821873aa52639c912d05e0694ce6a55da248cc5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
@@ -145,6 +145,7 @@ backlight_lvds: backlight-lvds {
 	panel {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
index fb81bd8ba035165525337a35acfe67f155bb7e46..73ed40ae5a7bc25ca13683d907dd762f7a8ca52e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
@@ -57,6 +57,7 @@ led-debug1 {
 	panel {
 		compatible = "kyo,tcg121xglp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
@@ -72,6 +73,13 @@ reg_1v8: regulator-1v8 {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_wifi: regulator-wifi {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
index 8d471450d5c5c76131ab9677986228c1615f584e..610b2a72fe82557c51fbad1bfff65154540e2279 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
@@ -127,6 +127,7 @@ backlight_lvds0: backlight-lvds0 {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds0: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index c727aac257f9c3a1f16dc357fce355ad46a3f699..ca29933302c6b9b19eb5daced48cab2b458d85c0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -237,6 +237,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -248,6 +249,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -259,6 +261,7 @@ panel_in_lvds0: endpoint {
 	panel-lvds1 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds1>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds1: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
index 806af7f60419e7e81c8373cdbaca36453abbbba6..03fe053880ca6e0e9870cb13f932a3b5afc8fc79 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
@@ -114,6 +114,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -125,6 +126,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -136,6 +138,7 @@ panel_in_lvds0: endpoint {
 	panel-lvds1 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds1>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in_lvds1: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
index c71aa7498acf4a0b1cc8f74c325c8944ed1a781c..6a353a99e13daa2f13ba91d7311f60c88b40695b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
@@ -179,6 +179,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -190,6 +191,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index f7abc17c7c93a7016854d7beb7d041dc90301514..8323be1bfb769fda5c21ea9d4790786654e996a8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -207,6 +207,7 @@ lcd_display_out: endpoint {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -218,6 +219,7 @@ lcd_panel_in: endpoint {
 	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3p3v>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index e8368c6b27ef3be2bae1d1dadc7c29672db0e5df..cc2a7b61a293a0d8919a74a0ea28ae83390dd68b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -17,6 +17,13 @@ memory@10000000 {
 		reg = <0x10000000 0x40000000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "reg-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg_vbus";
@@ -139,6 +146,7 @@ led-red {
 	panel {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
index dd4e5bce4a55dca44ee70d5485017ddba1e186d2..8232f4ea27526584b52654d7d3940eb5b104794e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi
@@ -16,16 +16,19 @@ backlight1 {
 
 	lcd-panel {
 		compatible = "edt,et057090dhu";
+		power-supply = <&reg_lcd1_pwr>;
 		pixelclk-active = <0>;
 	};
 
 	lvds0-panel {
 		compatible = "edt,etml1010g0dka";
+		power-supply = <&reg_lcd1_pwr>;
 		pixelclk-active = <0>;
 	};
 
 	lvds1-panel {
 		compatible = "edt,etml1010g0dka";
+		power-supply = <&reg_lcd1_pwr>;
 		pixelclk-active = <0>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 73c9cfbdba621c1cf42f56ef2e9d31574c4f8311..3d147b160ecf150f2f3b6afa8b5873fabc2ba96f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -43,6 +43,13 @@ reg_2v8: regulator-2v8 {
 		regulator-max-microvolt = <2800000>;
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -157,6 +164,7 @@ gpio_spi: gpio@0 {
 	panel {
 		compatible = "innolux,at043tn24";
 		backlight = <&backlight_display>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
index 7acd28658e6ffa3bc649c93c19d2f0b8e5a9f51e..2192f105ec81cb488f1c3634cf0ecda21492eea4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts
@@ -35,6 +35,7 @@ backlight_lcd: backlight-j20 {
 	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
+		power-supply = <&reg_3v3>;
 
 		port {
 			panel_in: endpoint {
@@ -61,6 +62,13 @@ reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 		enable-active-high;
 	};
 
+	reg_3v3: regulator-3v3 {
+		  compatible = "regulator-fixed";
+		  regulator-name = "reg-3v3";
+		  regulator-min-microvolt = <3300000>;
+		  regulator-max-microvolt = <3300000>;
+	 };
+
 	reg_can2_3v3: regulator-can2-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "can2-3v3";

-- 
2.34.1


