Return-Path: <linux-kernel+bounces-874652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E477AC16C95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2AF3A41CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D4350A27;
	Tue, 28 Oct 2025 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="alJpLoOa"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AF34FF6C;
	Tue, 28 Oct 2025 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683472; cv=fail; b=U1v8q3bgvj4Eh5lFvwlXE5Ha1DlLQq9peff37hdDkO9zX2uY6fmyl6W0Eop/bag2aQiD+17S59or0iH5t5q4vCmKdQNRYZYk4DMZvjgazYDwjXIV4VtRNeings5t7O+IfKN1wznI5LrFQyOrn87F04NSqC5HLlOcsZ2gJNFw93E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683472; c=relaxed/simple;
	bh=Ch6tGae97YrIa0v9do0XUoa48YQi5aWQLbJNIGhMSSM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cHDY8dKLac4Xp6YnQM+PSOnxn76PqVnbI4uAkI4BoGKOMx53GMH+6kHgyc9BEZEY8Qqw/UxziaHzbGf6Jfv7WjivRQRwUbx9A70cPMAeOiMyEFjQ8z/0aIn05lD8CQByXyxmzXxuJsGFOpdcLF76XL7mFrjwvJMmiZm/REWWgus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=alJpLoOa; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMSeIznRZjum4XYiBHV22KM1Dp9RZANAJAY2NEEWYceI/Hjkje39ymd8dq5IwsYbz1awlm8b8kMBnrjWt+kuuVgs08gmN4O1374N5UqI/DaIydKoN0jtBDK0Bs/jW7s0UVAChRfbFHKmNaHWTMsZrJXSggQV/E7cuG7eqQVhfJlFyHb4padziuYWPMw0Ds7YT0uJD6ePUFChBn+x3q6h8VdF8S3D+t8ftrgZvGyJvch5qyS82ltPlEALUQbmep9Vy+1GesRJmtojfNdrT8EBidD+GF2ABWExeH0QkQ9FsFIlJ34mkntDRay0afcyn7kqIExkPZEV8GcZL+efXKMtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KFo0C+DFPIgKvKd16MnwsUszMu1kVIkPzVk19ZRxCQ=;
 b=t+PaeLuEe9MSZbkbsBM9TtWeOJmXfDJaLfZ7vIueJ0x4+u8Yo2040EzyRDNNdP1p1waDYbx7vkXQvPwUi41I/9vFdvbCSBkfsSNKLIgyGxM9hOOoDuzXGEP0uA52i4u2tmqE6SwcuFXq/vPxIp9eoKr1vAin7bFaNAzcmREwwx/l+Rdtf1gH0K95s9cdDl/JmI2ApriOgVRuILfQDC57zpKXS4rY5pxrUdQVvbP+kLu+OHUNkgnUFIoAFEjyjdsDtV6qP8Wg1wOrXZ1OcmqoueHECjqRXINZ1WvwTmIygfmT8z0eZ9jMV88DjXl9RvCzs8Mc1+AvDL1nzVnwo2wL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KFo0C+DFPIgKvKd16MnwsUszMu1kVIkPzVk19ZRxCQ=;
 b=alJpLoOaOw4EnxDkBeADYb11HE+w9LTl7kq/b855d+6XqlQnuunIcQqWDWzu4/vMEMVuitbql0N+k3WxVnqr8Evau5SX85C3OAxxojzUC7P8v7JwDwzr+x4ByeSTrvdHepmLV1FfUFBlfNMnvADl/YP0yQ6VPFha6UF3Y9PZE+CXQvGP3Bp7iXHXrB6drPX8PW6UCbCWzgiB2zVVILQJaYF9L/cuJ1s0e6vaunh5pSOSzLUHOEMfVr4gfMxIRiBkB6XlSSm++d4CJb/vPHUGFf27nitO698JOutS/vtc5ikQEbQ49dEqkZRDvI1U1agULUZdiM/M66mJ1HVSQpx7AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:45 -0400
Subject: [PATCH 4/8] arm64: dts: imx8qm: add label thermal_zones
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-4-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=707;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ch6tGae97YrIa0v9do0XUoa48YQi5aWQLbJNIGhMSSM=;
 b=n93IvFQXlJbidQ2f6nJim3jtT/j5JYNn17M/xwc0/jQ/9xV5yWzQGufamL9r6K/y8t4nHy1ZO
 QouYH6tJt96CohW996VL6OZKfE6+h9oGTS00guZUZsvd9iwKFf2WBUb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 793a189c-429d-45ee-3d3c-08de1660ecce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2lwMVBwcURkWS9CTThwenAzTkZyYmcyUGJLZEp5a1VpMWJ5VHVvWkdNTW5y?=
 =?utf-8?B?K2ZIUkN0L2pOdzBKT3NzMStTd1FLWTcyZ2ExSmIvTStnb254aVJMWC80Vy9p?=
 =?utf-8?B?Zzcra2JTUzZ4Zm1hVWE1cVV6blpVRGRJNDhzaEhGeVViczRNWEdSZjV6TS9M?=
 =?utf-8?B?TzZDeSt4bDdwK2hQUTVZZ3JQLzBrR0J6WjBwWVdJWFBScjBQTCtLQVhkcndJ?=
 =?utf-8?B?WGw4ei9lN3VVd0FYWWlSS3NvdjQ0djBDM1VCVWN0Wlp2Tm5lSjFTeXNMNjkx?=
 =?utf-8?B?RnRsbWhEZjVHSjBtTHE4S0JsNmlUWStORXdLbURUd3NBalMrM3BKQ2pibW1i?=
 =?utf-8?B?WktpSkEybG42cVZvOUgvb2w5UzBNSCtldk9rUm5LcTY2KzF4L0JVVnFONUcr?=
 =?utf-8?B?VE5wTHhYZVhkUDkyM0grZkY5S1VibGRRcGQvT1EvdDFhK001YUplMnNzbWlj?=
 =?utf-8?B?aUw5dkhDSU4rZi9JdUhIcDByY3lXSXh2ZXFqV0xuL3docVZQYnl3VnFvOXhQ?=
 =?utf-8?B?Z0hhODl6eWhOWXd3ZlNKamhMb1pZa3lGaWwwbjhnNnZ5eHo5TWw5bzZMaFBV?=
 =?utf-8?B?OU9oWjVOQ1JCaS83N1drQkg5YUNvMnQ5NmkzM1dyTWhqOUY5WGJOMTdvVk1B?=
 =?utf-8?B?OVJmdlVQLzhyZ2dJUWZtaXpjN2loTUVuZEl4WUY3SzR0M2hxWk03K3ZHU1FF?=
 =?utf-8?B?NWVITVQwVTllVWFEMXpYUVZSTTlzUnNVN3M3OWRXNW5iTi9TZkxnRk9CTDh0?=
 =?utf-8?B?Wm5SQ0hDckNxSmUyZnFXMVVDVUxRK3hEVEtGV3o1UXB2U1Nvb2lDK1BRcms2?=
 =?utf-8?B?Wml3OHZyZTBHTWlJaXNLSS9rcDZieHJMWWFCOW92SEYrN0lUUEI2TnI0czN0?=
 =?utf-8?B?bG8reGJSN2pudFhROXRDQ09LQlFjYXQyWXBHVHEzQXpEM2tQWGVKSEJVL1Nt?=
 =?utf-8?B?T1pIZjJkRW5COVhKakRZdjAzZVlDWlhZV3R5VWVvRHd0c0VZS25uT044OGZJ?=
 =?utf-8?B?RzVSeEp3OXJ6MkxURVY3QkFiMFN1Tk5JUC9iZVpyL2RkQXVEcU1jdC9KMDgz?=
 =?utf-8?B?dW9FRnJhaExKN3JwaXBpUDg2MUdYcGVxSmpQSGx2MmpnS2dMYVhiTjh1bERZ?=
 =?utf-8?B?OUV0VlN1TVRBWkgxdHFMbU1BSDZndE5zd3dKUXRVUDYyM0s1TCtTbk8yS24x?=
 =?utf-8?B?M0Y5QVVuNE9PZ2p2Q1RkSWN6bnNlOGIrNFhINU4yNHJ3L3dod3dVOE1NenBu?=
 =?utf-8?B?Mzd6Z3hGZUo5ZEFEWTQvUjViUVhEY3A3d3hyVGZoT3ZVT0xqVlR2Y2ZPNE1m?=
 =?utf-8?B?REU5a2loYXZZV1cweWRXZzVtd0tjVDhDLzR4SXJWUHVFRXJMZnM1Mzh2VSsw?=
 =?utf-8?B?czNCWnhLMVlVNStObTZjVXVyV2lpdWprcGZXa0ZPQS9KNmxkbFUzWTZuSWkz?=
 =?utf-8?B?eEsvVCtZRXVwb0FhVEJNUG5HUHFJSXJqenFIZ2duWjVFeXB4cUVqMUF0U0dr?=
 =?utf-8?B?UzUrZFZndjY1TWxyT1d6WllSbDBHOU1KRkVzdU9JQlJiSHNyWXRXRkhYMkpW?=
 =?utf-8?B?UVdTUEtOQWFyK3ZRQ1pyMGxpaXZ0Z0phT3RHQTJUaGtONDhVeGxZMzUzUjZl?=
 =?utf-8?B?SXRGM2lxQmZFREcvVjlwRTJLd1RjQXFqb2h6ekp5U092dHV5ZDFuaktZaDhv?=
 =?utf-8?B?RXBkUG9MYURRU25RT3dNT0MwdnBaWk16dDF4bU5ONE1rZ3oyYk5hY1hld212?=
 =?utf-8?B?dkUwSkFHZC90Kzc4dno0RDZWQ2svQzRSVk1kUE5BeEVYanUzbVZDWWFYcWh5?=
 =?utf-8?B?UWlFSitUbVBxbzg5SEwwMnFvMGNxczhLNW9QeDIrenNlY0NMU3JsaTkvMjgr?=
 =?utf-8?B?QzFHTnMrOXlId2ZmTmliS05odzB1dEE4OERvMDNLUXE0eElpb0g0Q1NRU3Nz?=
 =?utf-8?B?bE04bi85ek9KZUhrNTM0d0VQM1I2Slh2L2Zqa2RqS2Y1THhvTWVtZ1QvVHY0?=
 =?utf-8?B?bXNvU1dlcEVzR05RZnZBMnRaSlIrNUdQWGo3Z2d6dXM0VURrYWNmWlBHYW5L?=
 =?utf-8?Q?lbNzmF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZVQnNlU2lSdVhweThJVEczMlZDVHdwNkt5c2V0RHJXd1BqRUcwOXFGaFlo?=
 =?utf-8?B?S1N0RU94VmZLakdSRzBrT3A5MWUySkRjVXpQbWtxYVhZYi9vdGUwVSt6V05x?=
 =?utf-8?B?cGRKMmtqUU5KWWtvTncxZUEyams1WndwaFlvV2xQYnVaKy8velpqR1N4Myt2?=
 =?utf-8?B?RHlqcXNFcVMzYWFXaUV4RWdHdjJqSUtkdVREQkVLak96NDBZeW1ET09rWmll?=
 =?utf-8?B?R2JXQy9tNHYwUGJLKzZJQnpjMTN4dzlSVHdHbHJ4MTZEQStWaWtqL2htazlx?=
 =?utf-8?B?ZnVUT1BOSUFGemxkSmprRG40aUp1UHRsMHBab3pnS1JRWHJ3VGRkYUlUd2Nz?=
 =?utf-8?B?R0RCL2grZ084d1o2NHN1VU9Na29nVmJoVFJhU2JpSEMzS0lNTzQzRW9yM3V2?=
 =?utf-8?B?VVVYVEtXWUxTZ2VMRlFxdjRicUNOWUVQY2pCY2hwRFo1WHJQZXB1YzRHbnZZ?=
 =?utf-8?B?K1Qzdk5VS3dJbjZWaEpoNkRySTdrR2x1TVFGclQrOXlXWCtpc3hFMEJ5Wk1a?=
 =?utf-8?B?RmVxTEc0VG5LNzE5anVvNFpWcXMxNjBpNWpNdnM2aHlKR09sQU9LNnc0TFIx?=
 =?utf-8?B?Z1JwOFF3QTZzSGQ0RERqQzFkSEtCL0VDWG9tUkdhMzhIQkt1b0dBUWpkNE10?=
 =?utf-8?B?YTRqdkVZRDRyOS8rR2pGMnk1LzZNQ1hYditnMUVDZmlKMEZ2TVJRamY3ZWFx?=
 =?utf-8?B?VnNxRGZlSTdnMVpJYlUrYWcyWWw0ZWdUNHF3em9PWlp5V2ZlQWhkZHJxa1gx?=
 =?utf-8?B?YW9hTnVkOGNpdjdZNFVPWWhaRTlnMWtqc3JXTi9QVVRxcGd5Rm53VW5sRDEv?=
 =?utf-8?B?OTlmZTdhTWpidU1idVFZbWg4MHVhOTU1dElFd0hSRkpzRjR2NW5UcEdHaVVY?=
 =?utf-8?B?TUFQOTBGOGFOdldmR0V6emtSdXNTNXF4RTJlNzkvMmx0cCtRNXY4djZ2b3ZU?=
 =?utf-8?B?dTBWekJYYkMzMnFJM2l2TjUvbjhZZzh2RVFOZmNDb0JBaE9kMk9oVmNySDN3?=
 =?utf-8?B?VXJrRGVYaHBsOXhzbWlkaXMxWUdWdlNuaHdRUmh5Uk5ManczMjljM0NjbWdp?=
 =?utf-8?B?ZGJqd0pvQWxxa3BoODlOZVN0bXRwSStJQWZ5eGtiaUF4NFMreUNMelFTangx?=
 =?utf-8?B?ZldwYlNuT0JXM084ZlpKa3ZnbTB3dEFmN1hnK2dBQUYyaVJqQURwM3ZxZVBN?=
 =?utf-8?B?THRqWTlhUWR6bm9nYjJnR1FDTkpkMWl3N2pSeGdSaFRJZDFDRGEvRUNJbnBD?=
 =?utf-8?B?R0M4eG5pNUJEWEJTZWpIb0ZuV3kvMkUveCtlbU4xYzRRU2VtZGNpYlh4K1lq?=
 =?utf-8?B?SDQ1NURtOUUvY0puY1lOS1R3MmdJSlFZTjM5VysxMlBPSVpxUThyYm9OTEJT?=
 =?utf-8?B?WU4rVlN4dXQ2YWhEMmFGR2Q2WXNLaDdGZlE4WG1qQk1pa2VWOXFXL0gyZ2xX?=
 =?utf-8?B?QmlhM3Z5S1RQaGZKRW9RbldLSFAvalpCTDhWTklWY3J0NVFJK3kvVWxFVGhy?=
 =?utf-8?B?NVRseWNHMUdTU3N3aG9QeXZFQUo2dkpSTjJtdzI1TUlEcWY5RmNQRkVzQ1dy?=
 =?utf-8?B?dUhnOTJnT0x4blJUMGw4a0I2UWlXVzAyajQ5ai84cDhjdHhSdkxqdEdidmRl?=
 =?utf-8?B?MXIyUTFNbTBlNVRJb1Y4cngyRlFXUnNFSk1TS3lmNlRhNlJZRkdRdWV3bnVS?=
 =?utf-8?B?QmxHVVBFQlYvUS8xa3hySTE2K3ZEcS9NRGFQWE0yaTRuOTExZmdCb0syNEFa?=
 =?utf-8?B?L3F6TzBIcUdZS3B3d3pKYVpiMWQwOVVCWmkzQmNaWjJnOXVCOWJ6Ym9wMUJ1?=
 =?utf-8?B?ZkdvVG5ZUjZhSGdnUVNaLzNtZ3F4Q2htUjE0MmFkNDZLbjhwKzFLN2RibzJq?=
 =?utf-8?B?MlBiSWFOVmhwYnhJbzVMRUpCSU1MWnVQb1l2WEIydmUrNThrRUcrSlQ0b2Zj?=
 =?utf-8?B?TjFmM3ZESlBSMjNyZmNxdHdYYXdNTldVUG82VS81eE5mT1U5ZjNWWlZvWEdu?=
 =?utf-8?B?MVIweEpaQU1wVGNNTzc0ODRLTGlhYnpLd2pjSU5pQ1Y4Z0ZiVUlncVZtcW9V?=
 =?utf-8?B?b1NyZVVoTU5CbWxUcWRvcFdCYUFHTUpqalBRUGZsNU5MVVVEczA2YkY3eXdh?=
 =?utf-8?Q?lQ8g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793a189c-429d-45ee-3d3c-08de1660ecce
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:08.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fslck1F95uPBUbIRkYSjcGU4RSTks4ImAA3fGXEL2eqEM99DGE//7M8QfSUNaogxRyfdCqCRYBJS5d3WuFc/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Add label thermal_zones to prepare add pmic thermal zones.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 2508a07832810831d019f81d47a8f7042a77d709..39df74dd29b006b11dfe5828677fa8940cf428c2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -376,7 +376,7 @@ watchdog {
 		};
 	};
 
-	thermal-zones {
+	thermal_zones: thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;

-- 
2.34.1


