Return-Path: <linux-kernel+bounces-889328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA6C3D4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F644E760F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C99351FAC;
	Thu,  6 Nov 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aUq8yt7o"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859142DF700;
	Thu,  6 Nov 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459064; cv=fail; b=Q2YUs1nAu/mRYw40PuGIR/Omompz4NNtXfIW2RCoR5zjeXMffzpOZ1s5lqIs3KbY9Mx8MbgmjZ20AyVAjaFBDaS0rXs767BR/256iPL9kDEIsICTxTNZTWcMuge1kXcDItnOt7p2NeB9rm3GXFusstwh//gDEeX2AnDeoXzd7h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459064; c=relaxed/simple;
	bh=jowDWW8+NMiAGOTptg3rUb1TRYl8P0g15bn2e83Vwc0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CUYal3+4+TczDwCk3L51SbQNs0O6GuAGWxlf2MVMBNENiZASWoi+dgy6GwWK4312XAKh63kYseWqQW+TxRclTfmw5DGIo3YzUiELZh+Hh+EUamJxqkXO/QdlucIhPdb8NITP9MWkcoXvPyXDpcasgkLe5jE0sgG4P6Gmko/LiCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aUq8yt7o; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duB+NHcKKxMS1KST8JM0UU5UFujsQ0Sp5+GrV8H0R/4SwcNUtsHlpey3U7YlisZCTFx0QPcCgNtULHiRAKrnljq4Z5DZRLcg0m9bT3Kaf8uGqUhhWN5cgqcnHacg7nTHwoQgaASfOfhoVgAOWWOIGnkJWk9pUKiczQZ1m2SYlqihsR4XRzacB2GdANwGiY5jsfi3fZ/1Rp3YYRhbL2rgAEbPZmFPMzVIudVXuhnkkOqjSNPqG8hdIiG8OBLs3THE9pTdaQntV5jviIEt9TMm9kgJjFWDZ9ME9Qd10xQ0gCM5EHYp/Pnekw2FHWtmikMCdHCdyxaJ34PNVfdQD4HwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajfrwKeK6DWALIsJMBn1XIqy9mQAvV71m7pexcDY0/M=;
 b=SWQ5ZUXzBCwJX1ai/7l0muTvno3YGOqmccbzVT2iNwYLJYpcAUIm7FZajhCgyGqR2ybu1VykPOyGf8bbRp47o5OAXrGPOwWU9DdbcL/I6Yl9iUfUjKbyFPJMRLACZzf6ffMSH78Ajt+QBsxM+QAT5DF3pSKyxLXTp0IvI5UWt7meQ6eG5Kp5dQNJwYFvlNYq+1C0cu99804LHX7iqgn7NSq5po1ZYPpLPV4TA9RZaR2RQ4Apblrb/JU91YfhKoAbvnQxGJsDQQa+K3gUrQIlFEiGl2QYj/1SRHCgYKzkMeajDO2DLx0r7uRjN+L8bdbw6vJs5lU68aJ7JYICKDCsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajfrwKeK6DWALIsJMBn1XIqy9mQAvV71m7pexcDY0/M=;
 b=aUq8yt7o7BEqkV+hWc60aVWV5wyBNa67v9n7ZvAkKaAQhO1Sva2HjZsHKCg7TLFjG31v1oKkGfa4aLnA4cGLYw7Hh8IgUEh6QinfDZJ084/DIH4qV6UxDK8lquRqUDmXltgB3PNU3SCzDPLD0KVjkRE/fENAC0Vrn6i3OFqUm6Wmb6lSyhFZucO7k6WXXYaUMNB4eNmwJFcn+hTP2TJ730Gp3kijb1qt5JM98RCPeXf8LDhn7voLcm8qfWt8Pw7QZGoAxqkRmKfH9H97ELfpjiyEFWUhOdoFSWXL94JtFCRz9iK04PLreY08qnUV/4+sxC+mHVqYFQ6wL18P4DGZ+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 19:57:39 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:57:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] ARM: dts: imx6: cleanup imx6/7 CCM related
 CHECK_DTBS warnings
Date: Thu, 06 Nov 2025 14:57:20 -0500
Message-Id: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKD9DGkC/z3MywrDIBCF4VcJs65FJfa26nuUUMw4aWYRDRokJ
 fjutYF2+R8O3waJIlOCW7NBpMyJg6+hDw3gaP2LBLvaoKU2SslWIE5PtyRhZEvWSFXnHup7jjT
 wukuPrvbIaQnxvcNZfdefYf5GVkKKk7UO3XA9Y3+5+3U+YpigK6V8AO5OABWcAAAA
X-Change-ID: 20251104-ccm_dts-504ea501251b
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762459054; l=1582;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jowDWW8+NMiAGOTptg3rUb1TRYl8P0g15bn2e83Vwc0=;
 b=6cuj7i917VhuS2aGLKqNQVrFbaSzCkZMSBpuo6My/kH3A4EqjZ7GPXG9K7FXdh7696mE5hC3W
 YA87H3ob1LdBUovjdZLYLlZ3jh/2sKwvndqkff0x2fJXHvNChp+B+A2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adfac75-3417-48ef-27b0-08de1d6ebd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnF1V3B2L21McTVwUGxZd3BGd0VIa0lZWXhjd2JiL2x0bVlzMVlWdlJDemZa?=
 =?utf-8?B?WTVKRlVxQzE1eElkdHlxWjRGRVNaR1hOL083RDdvajRFcU9jb0VoS0xNVVhr?=
 =?utf-8?B?THh4SG5Cc2Y3TWlWTFNhMlFRUFVxZERrUFRLL0thOWZtM083SEN2QXNrVWh4?=
 =?utf-8?B?eW4zWWZzc05TSW5wRGk2Qy9ZbitJcDQ0SFRyWXlxanZsa0JxTXp1MmQvK0Fm?=
 =?utf-8?B?TkxwYllCM05nN2pseXM5WmlZeitsc3pzZGhyTEVRTVJCWVNyMXJRNzRTVDUz?=
 =?utf-8?B?TDhiT0lRbm9LdGpuN2RrRWZUZSt5SUlCaDFsZkJBcG5KdFZ0MGV4aHIzSlRY?=
 =?utf-8?B?Sm4xTENkSUhTUXB6ZDF0dDR3eU1NVk1wYVNyMW5KTHdPRGYrbWNuZDZreE10?=
 =?utf-8?B?d2NPdTVicHlqRDQxSGhPcnc3V1cwMGRRbDRVOVljYVNkaVk5SjlCeUhWTjNz?=
 =?utf-8?B?Q0x4QmRST1htYXpLb016Y0R6YStsR0dKaXJXWXVkUTh1NEpUSjhrQUpqRWcx?=
 =?utf-8?B?S01pb1Z2MUlNSU9xVlFoNEx4eWVqc2pyaUZhVTJxaTE0bmR1WVN4NnBkVGZj?=
 =?utf-8?B?ZHJLTGJnWjFheXFnYWc5eUNxMXR3eHlFaGVxSW9kSnVJZ2hNa0pmSTVla3Jl?=
 =?utf-8?B?aXp0cDlmWHpEL0RLWWdRNkRVaFFSRG1MWmNxckw3b21JWGtRV0puY1ZsTUZI?=
 =?utf-8?B?bHdmMGhkV0FyMEtwdmowYXlUSEJIZG9EdENLcVhWekFDS2lndzZaK0lmbkc5?=
 =?utf-8?B?YXhmMHVZc1FlZnpxMzBzODExNE5QejYxa3EwNE9sMEZFNXBacE1mOXBid29E?=
 =?utf-8?B?c1ZsQUpRNU1CVVc2VU1JeHdpUGxIM1U0QU5IMldob3pFclNmUWdzMHgxbFRI?=
 =?utf-8?B?blFXK0pnVndmVGdLOWhwSFJMdTY1MEpUbC90cFZGcjNCeGFXZ1lZTFJnMG9r?=
 =?utf-8?B?SjdTVGlBdS8vL2ZFb0lPMkdtQzkza290dmdUTDY3V2R1WWkybDlrTk4yejFa?=
 =?utf-8?B?bVI5Umc5WTFsc21pUzd4dWM4LzMrV3VpMjNGWEtMYlkzcUhkYUE5MzRPTS9G?=
 =?utf-8?B?VUFiWW5YejZ1bzVWWnN0ME9Rbk1hMGRkRk52ZkhsSE43NUJkbG9ra2w2Z3lP?=
 =?utf-8?B?dnRvZW8yS3lycWRMUHRYLzFadCtOMjZscXAzc281VDBORkQxeFpXUlQvdmtt?=
 =?utf-8?B?bGkrVHhYby9kMTE3Y1V3RnFnTDBJejN3Q0cyNVRCWWM4K2hLR28vekY2OVQz?=
 =?utf-8?B?S0hJdXZHNzNyVlVYWEJPVm9TQi9IV1RZYTk0V1IzdFhRT2hZd0xhQjdMYktu?=
 =?utf-8?B?cFdYcU8weHVSYmdSRndvY2l4VGZlUmsxNmhoUFZTeWlQNFFqZFhEbEtEWEI3?=
 =?utf-8?B?bndHR2RMZVMzZk9KdGhhT2wyaElsZlplUVZnb0ZhN2YwZlE1NENiOTNRT3Nv?=
 =?utf-8?B?OWVmbEVTNzhPVmFwMkYrREgxWGQxUUlOakp5VFdkcXRkUDRqUGIreUkxZVp1?=
 =?utf-8?B?dWRmTXd3b01jVVNYcTIzaUlZcUFWMHBac0NOSUtYeDJMMi8yMlRVRmVQeDUw?=
 =?utf-8?B?QUU5NmROTnBVZzlyUEdpNzI3Q3F1VzR2dHFNVFZxYm05K1VvbUdsTHk3bmJV?=
 =?utf-8?B?SGpVTUw0V3ZQRnJkdVZJZTNreXEzdUdiZ3hySktjWnJtVyttazVQSHlkTlc0?=
 =?utf-8?B?UzlpMGNacVhYeVp5RUtteHd1QzJoQkJmd2xDV3ZRQmxCejU4Q1NMUUxDbWlq?=
 =?utf-8?B?MFllamxwMDYySkptTnFOaWJSM3JzWENIRFFHczk5Sm5uN2E4Rlp5a1RXOUpi?=
 =?utf-8?B?RG5VNDZrcGdCVWhWMXhwbWxjblBtY09wVlpKdyt4VnZWWGp5S2MyUWdrN0px?=
 =?utf-8?B?VmtTbUlaRFZyVUVOTFNwaFFkMnVSSUNaaERnRHNOSUo1OE1TZ0pyV2EzcUNM?=
 =?utf-8?B?ZWxWZG1BcTVzU0ZJd0xmV2ErYmtUS3FHNDg0WEpKeUU5YkNtV0gwTm5GN3dr?=
 =?utf-8?B?eWpGRlMzMlhuOW1ZRGowRFZCV3pNdHN4YW9QdVRqWnJxRDJ1VUFDb1JsZVBU?=
 =?utf-8?B?R2QyRFZIKzZ4UUhpbUFRbWFHeEpYV216Mjd2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y254UmhNMnM5bUs0L1YwdTRQZEhtRm9mY1RnanJweVh6WTc4QS9HQWFkQWlM?=
 =?utf-8?B?RUk0ZG1uOFd4QXZCQlFZYlR4LytkMEdWRXFDWGR1UnBRRnBFQ2QyOTRROG1O?=
 =?utf-8?B?amlnbUJ3blJhVXUyUkRGclFFQXpxQTZQQkN3bW1jWWNVODhuMXFZNjdDSW5K?=
 =?utf-8?B?VDg4dml6UVpDT3FFdXdMS3ZhbFJwQmx5YVcreURwejAxYS9rc2JPV1V1bk1K?=
 =?utf-8?B?MlM3clpPZW1LSkhCRlNtVzBlbUtrQzBvbjcyUlBMTnVlZUsrQjgvcUJUaWZG?=
 =?utf-8?B?TU1IQkRyVGJSN3huWVY4eHpQTGNKRG1PMjMvOWFwRmpLY2tyZTIvRk91NGlN?=
 =?utf-8?B?ZUpyU3plTUxzRG5pQUs4VzE4U0JnMTE4MG5jZnFxVC8zVnJzSGQ0OTFoWDYx?=
 =?utf-8?B?UjNnNHU5MXg1UlJyYzZkbTZIQ2c0bm9YaEVSckRIdHY5UU1QZlU0Y05OcjVh?=
 =?utf-8?B?ZnFtajJsSVgxcVIzMEU0Z3pOU0FmWTJTRmJCazRMTlVwS3ZiWkczM1NTS2Np?=
 =?utf-8?B?a1dyVVZMMEtRcHJtbStHZXhwL1YwQXlJNytJVWpVNk11cjlTOWplaWVBUTlP?=
 =?utf-8?B?ckJkOExsYm80UmExQm5UMGFGWnJYNElHSmpINHdFbWV6bU40UjdxOWREOCtu?=
 =?utf-8?B?SXA5Nk9vNVV3UE1WeFNSUjVtRW5obThLNytWd1gwa1dGNC82RXdLK1lQZHN5?=
 =?utf-8?B?TERRM0VYdDd3Z0txNVZsaW5QbFNJSGRtbWVnWE1URmhyU3FTR2FRRjZockNJ?=
 =?utf-8?B?R3hrN0MzeUJSUS93UzVaY1lXdjhpa0krQkxtWGNlcW53dmp3UGlpRkF2eVhn?=
 =?utf-8?B?U0lDNXEyQVozSDlZQmt6aVhUVmZZVGVqTm9zTEJjWXlXN2xCZVlHbFhJc3lk?=
 =?utf-8?B?SDNYS3hDNnlpa1pCVkhkQThENTlPSG5Zd2Q0TkI3MHpiZ2VlQS9SV05yVVdj?=
 =?utf-8?B?MGFjRFBXRnE4ZWQ2SkZ2N09OYWNnNWZQVktCalZTMmV3QnVIYStJbUxCNTh6?=
 =?utf-8?B?VmdoRHQrbkV1UllwZzhaTjgxNVFhNy9Ta1AxbmJFTC9Yc2haYXJtWUs2V0F0?=
 =?utf-8?B?NElJdzNZWWVhTUhWRnRyQzdmQXl1U01uOHlMNW1vZmc1aU1SQ2dzdm1sTnJF?=
 =?utf-8?B?bXEwa21lckhsOGwrOENkTTljdzlKWnhwVlZlUUhHZWVVb0VlTmpYU3FmS0VP?=
 =?utf-8?B?RVVUYTRtKzhndUxnQTUrSXZGSWtmYkJ6NVFMeHVtYmRBY3habk5LRzY0UWpx?=
 =?utf-8?B?b21OTGZGNkJSR1pSUktkSXBXME5zYUZMVTJnL3VwZWpwOHNzTXFIdmpRQmty?=
 =?utf-8?B?dzFuNlRXczVSa3hDNXQ5eVlGOW9OVG1nLzhOa2RsRWNXNnlZWGdBNkhNQkRy?=
 =?utf-8?B?MlFzcGl1Ym9GQ29aNzVNUXVINlQvRmZjelZ0NVhCVzZ3RG9yUmxQckVPMlBY?=
 =?utf-8?B?NTVQdzhXZ25qdzhiN2hsYmpuQm9RbHFYZU13bTF6cEtsNEMyLytIaGhrQ05G?=
 =?utf-8?B?ZDl5Mkc4ZG9EOTdxcG9FY3VzdmxGZUdCUXM1NEZlYVY0SUtJdkNVWVNGU1Ny?=
 =?utf-8?B?WmRqZHpLMnNyL3cxSE1PK1NJbGRNRi9Vd2RhOWE2b1JEM1oyWGg0SUdNQSs3?=
 =?utf-8?B?TS8ySXBNM3VUL3I3allvelBDcHlJVFordVFYdk9nc0h2Zjl3SkpyMnhoczhY?=
 =?utf-8?B?d1lWUXFtT01iMlVXU1Fvbmx4ZGI1bTJHRFRwVVBNMXVsVnNPMEZta2p3VWNG?=
 =?utf-8?B?a2xUQVZlcVFYdE5UNm1ZdDNDRjB4cEVjVk9TSWNHYTlIWFlKMUlwNy9jMHhu?=
 =?utf-8?B?aEdRMldobVpjRHBPTUJJUkpoZlZya1V5clpLYkJhTHhLaE1ISml2ZWhkR3pk?=
 =?utf-8?B?TXVzRGFSWk5Tc0xTUG1pWEZURDNBM1dYSFZaVkxpWWIwclNrMkhUY0RFcmFs?=
 =?utf-8?B?djJWZlVzNjA4NzRyd0dyL0JMRUxDczg3bmxEM0JTN1Bhd2x5ZGRsYWFoU1Vl?=
 =?utf-8?B?UjcrQTRkYVJRd1RUVWZDVGxEdU9JejNlcFNaWXlrSGF0TElsYndENHBIZHFJ?=
 =?utf-8?B?clc0Wk9zeFhudEp3WUt3My9xOFQzM3JwUStrSUt6MmZZQjN5SlVjZU5YRHdT?=
 =?utf-8?Q?YvzG74frg094NGBG99fmIEOEs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adfac75-3417-48ef-27b0-08de1d6ebd2b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:57:39.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrawAdIuqUgniqPOsx96POinOPLKj99swsUygELx2QvCFvMV/LPTIRyoyUQuvewZowqlN1U7Oj5/JifPAdeEnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756

cleanup imx6/7 CCM related CHECK_DTBS warnings

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- rename enet_ref_pad from enet1_ref_pad (only 6ul use this name).
- Link to v1: https://lore.kernel.org/r/20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com

---
Frank Li (3):
      dt-bindings: clock: imx6q[ul]-clock: add optional clock enet[1]_ref_pad
      ARM: dts: imx6qdl: add label for system clocks
      ARM: dts: imx: add required clocks and clock-names for ccm

 .../devicetree/bindings/clock/imx6q-clock.yaml         |  4 ++++
 .../devicetree/bindings/clock/imx6ul-clock.yaml        |  4 ++++
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts  |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi             |  5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts             |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                 | 18 +++++++++++++++---
 13 files changed, 44 insertions(+), 23 deletions(-)
---
base-commit: d1d799fccb5002df8cd355c0a849cf4efcda4ac1
change-id: 20251104-ccm_dts-504ea501251b

Best regards,
--
Frank Li <Frank.Li@nxp.com>


