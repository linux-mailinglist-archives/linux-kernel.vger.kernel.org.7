Return-Path: <linux-kernel+bounces-778200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57808B2E27F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE965C640A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B5334715;
	Wed, 20 Aug 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6cStBbq"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0A32779F;
	Wed, 20 Aug 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707850; cv=fail; b=f/IY+K4jogPNRLWREIMxoPUCuRKAJ5ePn/RemExuu8wIRPKv92gmoWZ0sIxW+z9TbWiaw2lIOir5r5FZKSwxSnZscpjhYdNM/kDas2OhKg5/9NWYpRKp/0i7i1nUeigs/kbUpoUBfmZal9AD2MSRqpJ+Tayn/N6zkWC+D3yXTOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707850; c=relaxed/simple;
	bh=fsqp2zfoi4rgtj5CGAr8UOEM7L9AXlqT+eadafu8CVU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r+0ck+QDPelLUG6Ia97Tg9T6qiJiOka+Fju3wL/8ueGioSfqM8jb1+LT93/cUbYznxYQXxrEKQ7A8jg2YkYb8s2YoZPBAlDymmps+dDWYf3cOiZ8K3W9hay8tasaT1mUsSpwkmHTw41aIC7CtyespqTxKSr8tazZgTa83jfHhig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M6cStBbq; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/jnH4bYiPdp81s5iVa2sOWq1fa/BPnVLzY6QRJAxYc7kaw3CPJ9mtxWGop0eUepIZmAq4WZ8AOkfz8mcwrqtEsKp0NyNKJkd2uWUp8QMMUdtP/dWM1oDfxUq9K7SKGWsEkykArZNH1sqoI+CF6ntDx40CGz4+SIJeHv2ICyGCZ2icL8zfDvFmL5NnEYNmR9qLmfNBvicXoJ7ROJm2r0nNrqNYC091ek8cD+QdS5l9GSrA+LjXSdtTClf1PaPZueB3vy5ZCiu9pSkXNgtT28H25HkrI4iJ3rs8w4V7YtGffqyz9prxslutvwmNUw165G0eROetfE7b35ecRo+5zM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuWpUytnOuFoUiWTQaxxathb05a8I7N7p1d8cADy3u0=;
 b=Taw/LPwghR1BKnGwRBQ2eI5CgteeGde/I2P21wh+59HMk3xz78z/GgbCUBsgzgctlVZPkVIi+hnOE3hJj3rutM1NUzNgZOWBw2Rt4fj6maAbGVArbdpO/8sIQJ/33u3RIEzMlzLpM0HzSj54DACOQ8QLapxs9xSQ8YjVfUNUZOGI+KJ1H8Tjy05DatQpB/ZD6dEtaa2qezD7qUsZW9vzeFUkQHZXNS+zobWvKVMzWETpHbyDkrfEYSRBVXFzxOIzWecjV33ZOGmvqU3FzCKtOff75Rr/p8+71Oov/q13MKls3c1SrSu5/vixwMndbHlz+o96u3DheFFj5RB8V4YOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuWpUytnOuFoUiWTQaxxathb05a8I7N7p1d8cADy3u0=;
 b=M6cStBbqJi/j2TVBmtuV3h52SEUMb4olRyv7FZ/PafQY4SdjX/GdRUUoxfc+f3sMiOLu/Q/cz9Gz8UJkJUz3rJYbH7QNLTfdo1lFMIF8ikzI0UZqG1s/ucD0WGsFZn1baoIcZ87YAPoLaLaOhGqfzIgX4FOkX85hHXaYzM3yVgMFfNKlyf+01ABQjIj/i75b4hDRuiKpjcO1PuGUTltxs3JaK67NDNIyjA8QPtph7nckk340Dv0NTY3+dHT4UN+N+U9Y5zzCFFRMKRx5prK0QEdsSynNH7uCyQ4VBbz3gHZlQnH5lFAGZHlQ7b8s2rlaC2f/sHD90Axzpb7y3yklVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:53 -0400
Subject: [PATCH v2 3/7] ARM: dts: ls1021a: Rename esdhc@1560000 to
 mmc@1560000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-3-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=1037;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fsqp2zfoi4rgtj5CGAr8UOEM7L9AXlqT+eadafu8CVU=;
 b=AtoW9FVn86OKaRAO3MyK7uY+jbOO9sM7Cijurs9+/wGggFOPwu9TzAluPTCR5FgfXHLAGYyGO
 ae7eNHA8GEiDLYRDncpgdBsZ4QKY1Dad2wstwtEaVbbw8K0Sl2m9UWu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 21381446-1893-4577-8e17-08dde007d59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGEyUEI0ZWNCY3lBVmxJdDRlOVpONzJZNW4wb3V6SDZ2RUJXODloajJxNEgr?=
 =?utf-8?B?a3ZNVHRWNTlxZjVncFM1VlplU2JJR2cxbjU3a1VuM2swdDBWUmpKNzhpMStK?=
 =?utf-8?B?K0VBZXNVdEJ1bEdYenlqOGtHdStnd3ZzcUM2UUdCaUZqSWduUlgwa1l5MEp2?=
 =?utf-8?B?RFhkaUNZRk9PUlZxbUw2cE9XcUg2ZHdrWnZMVkwydG5DYm1KRDgvQU5QTnJF?=
 =?utf-8?B?THdUNnFCcGZFTWVsZzJ0eHU1a0I3L0hML2xmTkV6bjJ3R2twczFwQ1YxazlE?=
 =?utf-8?B?THVPNTBaRi94NFZHOWx4VzBjb0dEczZKTWs3ZnZBaEF0bUthaXdzSUk4OFhJ?=
 =?utf-8?B?Y0JnT1FON1JseXM4TjRMVG4rNmtoR1hKWThiV2xSbDNHaVBUS29IbXVxZEIz?=
 =?utf-8?B?UTlieFNLRGh4Z1pZdGlkKzJDK1Z6RXJVQzNjY3dJZndJeUdHTUxYdUxsZnlY?=
 =?utf-8?B?TVZESFlJQWVCY20vSysxTERqUCtlcGN3QWkzOWVtN3RxZFpnbFExRDNTeGhP?=
 =?utf-8?B?LzlkSzRWeTRqaGQwcGZtMDMxTWZpMjZWaDZnM0ViOFlzZVFOUzY3UzJDVzMy?=
 =?utf-8?B?WmUzV0xCdFVKNVoyZEJXcmhSRStjdnJrVFJyQXpzZ2ljVlA0c1gzQlVjRCtv?=
 =?utf-8?B?QS9pdEJibDRVNjIwazVKWTIxUnQ1UVN5UlRjNXJuUHo0WmJ2OTlEcmxYUitz?=
 =?utf-8?B?elVRSms0OTlmdEpmZDU1bExwQUdOTm9MTmRTcVZGODU1RTFGOWRQSk5oSDdP?=
 =?utf-8?B?MlJvT1dWYlpMZVp4aEN3cDQ1UGdYV2wvSzFWUi8wSGNQdFJKL1BISVJXV1Yx?=
 =?utf-8?B?amhVSzVSa1pPUFBUekRHcXJSVW02NWhZdFR2WU5HOVg1T0pFL3U4L0dCRzRQ?=
 =?utf-8?B?OFJ1THVPY3YwdnJBa1dBMVg5UW9ORFpYNmdJU2E4bXpoTHJ2UHJML0sxSjRZ?=
 =?utf-8?B?TWpZYllqU2FKK01Za1Mrb0t2Mk9TZmx6NjFYTHp1T3ZQclArU1QxaG1EanUz?=
 =?utf-8?B?UmV1T2JsaHpKUTNydmp2Wkh5azVpUHZ5ZTlvRXJ6ekZtZmJVaVpsWm5mVk1w?=
 =?utf-8?B?ZEdjbXJhUm9ucWlvT0F1a3dyOG1KNGhCQW5EK3Z3ellvd2pSM2QvK3VRb0xs?=
 =?utf-8?B?OVg1NXNmSkQxNlQrWTQwcGNnWXc4bmttcktMZ1JYRW1zYjd5bWw3QTJ6Yy9S?=
 =?utf-8?B?cTMvVVZ0WUYwclY1RU1PUWpBU3M3L0E1U29TYytNMmJkdHowU1RscDlXY1J2?=
 =?utf-8?B?S0JTNy9ZSnJzOTdGQW5VR2lMdkMweFphUENidXY3Y0ZnTEdQN0RWd3NRcTFm?=
 =?utf-8?B?b1hwMWdYY1VUd3hXMGV2Q2g3WlBZODlXb1h6YjBhbGtSYk02c291ZkFtMXJI?=
 =?utf-8?B?WTRob0V6L1BqVUZjbGx5YzRIL21UWEZ6ZzhXNEU5SXF3OHFjbXpuek84SEx6?=
 =?utf-8?B?TEt2Y1kxVDNaR0NCT1VZdkRhUDdqeWdPSEIwQ0YzM3lKQk1UcUNEODVuOVZO?=
 =?utf-8?B?bytpZkVuQ2l4U2VuNXdKTGRmTnVyNGdoNDVVeWFEWFdoZmx1R0V0bTBCdGJo?=
 =?utf-8?B?MUkzdGY0RU9vUVNKT0xIR2lSUitrUEhPZHpjNWVSOXR0c01aR28zaWFLK0pV?=
 =?utf-8?B?V0c2bEhCbUhLSHBkaVcvZ2VVT2ZUTjRSTkRkSGFCZWNRRDhObFhzY0E4b2dQ?=
 =?utf-8?B?SWdvc3o3K2VCRTQ1MEdZOVNOY05nblM2MVorcVpLN2xCc1dNS29HT2lXV3pK?=
 =?utf-8?B?QlBYc1Z3LzJ5clVvRkpjdkpVQU13MklBVnlXV3cvclM5ZzYzenNieStkeWpO?=
 =?utf-8?B?UEYzTCtXeTFENC9GR09zdDBKYk9kMDUyV21BSkxaNndURUk2cWtNTURLT0Rp?=
 =?utf-8?B?NjQxRVdVblFXZTBCYXI0MXdEMmVEZjlpcDVXMGVpcmQxUFJ4UnRtZWtoaWZ6?=
 =?utf-8?Q?SJoTImips1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFBzcWZOZ3lMWGppUmVndE5CZkZYZEt4RDNwdXdzc2wyRG8xNjBrWWxlUk9E?=
 =?utf-8?B?d2FOaml1M0pVL0xNUEZGbTVnVm44NlNFYjRVNUhQd2RoVWVnTkZJMXBiZkZH?=
 =?utf-8?B?aGQ2U0RBZXBwTW9idVVxeXA3QW85ck56Wm1hUHJ1Wk5XZWllWFhGNjhERXE4?=
 =?utf-8?B?NWRORGJNQWl2VTMwUVFIWDVRZjd5cis2bG9ob3lUakJSbjJkQXZQQThGeFhT?=
 =?utf-8?B?dzMvSWI1VkF3T2pHRVJFZ0ZqcnBvek42RitJcTA3UzZXYXJNOG14cytTTjh0?=
 =?utf-8?B?QnFyRzdvYlUzV3VpcU85VW9YSXpLcVBYeVdsb09EZkpEWE5uM2grUk5vRzVP?=
 =?utf-8?B?dUNsMVNXbmVkb0FONHVXTVpiQkE5MW9SM0hIN2luTXBibnFEZlRWaC9pUHlZ?=
 =?utf-8?B?Nm91Z05XTi80OFcxT21zRTJBQ1lLREtlUHRvV0l5QitQRTdPa29nZWJxYS9G?=
 =?utf-8?B?K1ZpRWcyK0VKcEI3RU1ENjhPRUNYclBxN2J4Q2wxREhVOTAvMzQxemhOSDY3?=
 =?utf-8?B?eVQ4UzNXRnh4VCt0REFQd2lCSHArVm5oSTVPdU5VL1Vua2ZqeS8zY0NvQmFG?=
 =?utf-8?B?TldGckRxcitCejBKSjdUL2plUEtML2Z3alJnRzNaQ2ZRSXRXYWhWWWVvUkRD?=
 =?utf-8?B?bjVHUzdJaGdIZzl4U2tLNHRFVkxTeWl0VDlPdk9Ja0x6TUVvb0NzSWVKWVJo?=
 =?utf-8?B?Wll3VXMxOGc4eEprNklLUkgrS3MzckN5bWRSZGgyaGs0QURoenRxUUVuTHFJ?=
 =?utf-8?B?RVd3eVIzeW9ZOFB5Mkd5SFU0Tk04T1NDa3NuNXBSQ0dPT0s5N3R3TzZWWklT?=
 =?utf-8?B?bE9pZHBYc0FZTFZxaWc4TndCcGxCV3lqMDdHMWpyc1RXYUV6aVNsRjB5SFhV?=
 =?utf-8?B?R2NTQTVyNmdNVmNLQjduYkdzZDAycWhJelN5dG9pNEJSRER2ZGZEcVlzNW93?=
 =?utf-8?B?WFNRcnVoTnZNcUFuK3RzSjU4MGJFeCtTY2lJZW5NVStzWmZiMFFGSS9HMlJu?=
 =?utf-8?B?eTZmL3dOTkhzNW9xYnRBYWFvWmNIeU8xRFprZFQ5QUQyTEs5ZTRQRDdHTmF2?=
 =?utf-8?B?dTZibWRRYkI5TmxtVnY4djR0amFFWEVWZ1pMeUFrRjdWWEFkT3RoSFlpSWov?=
 =?utf-8?B?MUMxNERPK2xZb1dORzhndnVqR2w0SzJFWHc0ZHU1RFpFSW1HR1E0UzVZV2lM?=
 =?utf-8?B?c1g5RGRFRytlVXdKQ24waEJnNjFSWEQ4dHBaMVpDWlczTkM5eklPSGZJL2Jl?=
 =?utf-8?B?L3lmdm91R25RSEI4RHNtZm5vVmIyd25YamRzbnMvSlg0QnIrTnJ6T0tLRzFJ?=
 =?utf-8?B?eHlsK2FFWGw0K01FbjZ5QUNTSmdQVitOWlN1UHhLTlRMdHYzZ2lrbWlKcHFM?=
 =?utf-8?B?QjV4ekczRVRCc1U0b3dxaFd4dVhXQUcwR1p0NndqNHhibStrSjcyc0pvNU1k?=
 =?utf-8?B?aThScmZzRVVmTVJJekJ6WjhvangrWndReUlsUkNrcG1JOE1PaEtzbDM4YzRX?=
 =?utf-8?B?RzFxei9ueTF6aU1CNndFSlpOSWFtci9YWSt0MDl3SFlGV1JoMnlpcGszNXlT?=
 =?utf-8?B?dG5VeEFaUGdBdzZ5eGNTZFJvbGVNKzQzMS9Lc0cvZG54YzNISW4xTkIvcElM?=
 =?utf-8?B?Zm05cXFoNjNZYit1YTdnVlFXdTRiT1E2MWFmaGkxcXhxNzM1UFhTWktsSlA5?=
 =?utf-8?B?VVNjRUlURXZJcUMrM1hvcnRtRHYxQ2NvbzJudzh1S0F0dTZSckhHazlWRmdi?=
 =?utf-8?B?WUc2N2R5NU9VT2ZKRHEwdmFvazhTaHdkRkJLYkRpbHgzSWlZV01iNVIvV2Zs?=
 =?utf-8?B?UWp5QTFycFY1WEZIanNxTUVnV203OUhVaDBnTVVQd2JrTWQwQ2JNUmJNSThx?=
 =?utf-8?B?djRqMlRrenRqVmtDMFdHamh3RWZVWGE2bzJpZWtRRmtBdDFCbkU3Y29KWERw?=
 =?utf-8?B?Qkd6bzM5Z0Yxbk9nVVZUZFBFZXltNFdVeFhFam8xQ3QvSmZZck5wdnRGSmZ6?=
 =?utf-8?B?TjdManAxcmZsOHpiTkhNZmFKOUM0TFE4NUlpdHJ4cWpoRmRlZlA4WWp5ZW9J?=
 =?utf-8?B?dTZ6OGZPckNERG8rOTRIVWRSUlRPb1NacThUOVMzNW56bFpCZ3RwNmtMNFdK?=
 =?utf-8?Q?/4cPbatwHA23T0hTl6amxxM6+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21381446-1893-4577-8e17-08dde007d59c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:21.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo6CccGXfEvgmgwDvxNyS6eQdIgW6hxPwrUwSScJAyGEBTGOIF1qOLoERzFbebri32IU7vcGftGDIMBh9nj4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Rename node name esdhc@1560000 to mmc@1560000 to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtb: esdhc@1560000 (fsl,ls1021a-esdhc): $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index e86998ca77d6ef03dcf196bf6d8271c0ee50cf4c..6cce734b7ba336d2a4e4a1631333cd4232814d0f 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -155,7 +155,7 @@ qspi: spi@1550000 {
 			status = "disabled";
 		};
 
-		esdhc: esdhc@1560000 {
+		esdhc: mmc@1560000 {
 			compatible = "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1


