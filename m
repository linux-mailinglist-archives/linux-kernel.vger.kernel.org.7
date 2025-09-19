Return-Path: <linux-kernel+bounces-824088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692BB88172
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 398C14E1733
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421102D028A;
	Fri, 19 Sep 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PM8HruNR"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF92D0C64;
	Fri, 19 Sep 2025 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265412; cv=fail; b=FxBEpMcyJS7TgvCaBGm710ijD4eM3em53UvHPnKWpoggZi7hN+mCd9DBHQNZJzuR38HJixf8Izk51QOotszyYhFA12hV1Q/gHuJKNjLr61ByA/6jQUozGORMC9uStCg5HdC6ym0hiYa3CBRjqhtV+8S6iyS8Hqi6286OQlfTQSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265412; c=relaxed/simple;
	bh=StPeBLLE96wSL3HV1iZbGDa+Xnv48zge1buSViV5PoA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ROfU+5ECCipI6uxj7CinXtugOZ/oDgI5zyssWzmgBrpj6knxJi8W90aL8oYnMgn9ytObxSliA37N/yLpybS2XouVhRLlXPzRQ3uhxXRqewZCRwg0svbOFGaxrCE09b6R4rAnh5xyBBiCM/gUeFuf+xESJnG8wUfE3lmTVRcThzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PM8HruNR; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8ZJfIqDxzls9jkfdV6+UKKXtEEpWJNtXFKdHxH/o/NxvwctU6PieKNdEfsoWZKoFqLFCLum0azG6L212SA6sDgrESEWgAue8meWk1S266uUnbf0zC/+W+lqEWxbAj3CDWmhEHjIGO1/5QEp1JvXHQMWdYz9Rs67CHaX1x7k2yUr2GcqzYRaSzZvrgKsM085RP9MKFdA/o46WEgQQNEvotUV/IDYSFS17rDkPEZnAaCD3kdHihxKX6UfZnRe754CnXDm7tqFJl/rNF/KP3LSxc1QtTHi22lQrEBlwEiNmHwlmypaOV7zo45FmZ1ztQ5pka1EYEnhZoU/sNDDbu9oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE40jSXNBdvvzWaUH64Bho2Nvp8oyD3bY1xs/cz4ehs=;
 b=cmfkgz1zCACBixf1tP4zINopjsPaoliIi7qyZS2KX5p+OnqUtCqME4LV1Tvnrz367L0gMT97Z+sgAgPveGcBv/CWmAMutVSx7YAT5buD9xOavu5JBGvjNFf6SnYmABIx/YCYg1Au2dEbkIP70VN4/39AHINQ8U4vWhc+w26x61c5WsUuNIhOVtbIn0n3Wq5os8cWgBNUVQ6Utl6delB1k3bEzrQ0YyUqMjvMoZoqUdUctzw5Qp7fZLX/z5HseGQjlpb7PjxcUTu/1cpZzdY/Tdu80memAR/VbuLrRRd08FkZl1o5Mp0azozNJ/LRn0Yve/mHdZ4LtfuAwfIvZ2o+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE40jSXNBdvvzWaUH64Bho2Nvp8oyD3bY1xs/cz4ehs=;
 b=PM8HruNR1IGUenxtOZgExW+qJUT1fhARnt0PjKQIOGPz5FeBUFTQj1JodyfTSHQEo+NPQMOe9+L/a08rLIlgfcCgm7Z0QlTEiiQ3BIiqSokwx6N3t5iV8mrG5qis62VvT36kIh1lNm53YblGuBt7TX2Fsa/SOOae8WU/OFvvWJDeMhDtgElPxtEKFr4Sum+ddk5QB1xcUYk/ALe+kP66h4QQzHKVV09VtJXPMf0qCpmQKLxBwlJWssMtaflwHu+vMni1MvX5i1VlW34tpcfLYhANBAQJL3z6UiE31yIKgR8UJFeyeIASvpaRygPFLLfyoumPMfjGKrRQADDm5Msagg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV4PR04MB11452.eurprd04.prod.outlook.com (2603:10a6:150:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 07:03:27 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:03:27 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 19 Sep 2025 15:03:00 +0800
Subject: [PATCH 4/4] clk: imx95-blk-ctl: Add one clock mux for HSIO block
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-usb-phy-alt-clk-support-v1-4-57c2a13eea1c@nxp.com>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758265397; l=2065;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=StPeBLLE96wSL3HV1iZbGDa+Xnv48zge1buSViV5PoA=;
 b=Ar9AWJfTzTdKgEhCelzpLr8ypuPEGoq5jNVw1L3Ok9a3SU3UKnObhA0fXvdQxQ3i2ARFdtxjN
 OdBi7V8RnNlChVRZ8USf2/iIC4+icalm+L0a87UhcXyZWGr3pHp2HM2
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV4PR04MB11452:EE_
X-MS-Office365-Filtering-Correlation-Id: aba32e1b-a588-4438-a36f-08ddf74aa1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZ4YmRiVVhJOU9FbHQ1b1R6MjdwVEpaMG5rYWtJVWtEV29oQTEvYmJ4N0Zv?=
 =?utf-8?B?Yi9hdnF5NDNDM20xcHBKamptb3BsT2lreWdRc1N3OGFNQ3J2K2svejJPd2Vv?=
 =?utf-8?B?dVJsWERYMVdEY25MTHB5TDZ2WENta096WWcvWGp3elhFYTJVNHV4YVJrVTR5?=
 =?utf-8?B?cGpnUXcyZnVUV0lBeWxoNWJTU0M1WGhhNTJlL2ExMDIweHlQaTZ3UEZVeTl4?=
 =?utf-8?B?R29EZzcvWDdJZ2dkeDRRNkhoaVVwSGNFUHdWaHhZTFNScEJ4OHRlNVVub2lM?=
 =?utf-8?B?NXA0Z2lEeU5RQlJ2MEVHeWlTZHVZVXU5NUlOSXZXcFhJaGNFQlRva2RySlJP?=
 =?utf-8?B?eG5wL1B5enhCWHNCRDg2SnlTN2I5aU13QldwK1BtQmRBcCtucGoyWURMU2Vl?=
 =?utf-8?B?Nk01NzVZL1dXaXBuOHpaNTRTUUx5ekMrcno1cHByQkY4Ty9TWXpaUHp5K1R0?=
 =?utf-8?B?djBvUENiN0V1SSsvV1BkVStQL0tmRGdrUUpBbGs2ZnMxS3NHK3ZDQmh6QlRX?=
 =?utf-8?B?Zm1oNFRTQkhzVmRBUzRaUzZZT282aC9BdG1CWDlNOVZRc2RuOEc0MFFTL0tX?=
 =?utf-8?B?bWlzTWMwZ05aWTBnZ2RYY3RoVG12ZS9lREVuZWU5WmM4UUx1ajRTcDFLdkNw?=
 =?utf-8?B?c0wrZTlnbUl0MjFWUHZWd29lYytCM1pJSjFseEJDOVBQd2J1K2szOGFuWXZQ?=
 =?utf-8?B?RzNIcGYxbE40ekF2a05TbmtJMmVuUDRwcnIyU2grRXV0SUN5eTJSZXFLUHZN?=
 =?utf-8?B?dlI2Q2d1Sld5c3dmNGtCcHdRTHJicFBPNDFoNkhSZXZVSnlocy9hY1M5dWJK?=
 =?utf-8?B?SUVCSjJFRDRnclJ2T1VRSERza1dpWk1lMkp4R3BiVWdvdyszNjhuaGMvNVJm?=
 =?utf-8?B?Wk9yNXVOeGpQc3U5VnJsanJRU3RuUHIzWnVscEw3eTFkazhsellDS1hUbTJr?=
 =?utf-8?B?VGFGSVYwOWhOZE5UYnhRaktuVFlSbjZ6emdyazhGRGdTMHpiU0x6Ri81KzVm?=
 =?utf-8?B?NFovMVQzajZiblNkYWI0bGpreDhLNm9vcWdXTlZJemVsamloaUk5cUxScUd5?=
 =?utf-8?B?a3FHTHFkdjBndHFhZ0RhQWwwUVNLRlN0QXdQYlVLODB0TEgrWmhPYStrQk9J?=
 =?utf-8?B?RXdIMWhwSkdnOFE1ODZnTkJ3cFpuSFl4R0pRUjhaYS95cEFDb3ZrVGRNcmN5?=
 =?utf-8?B?aW52QnlRR3lwMGhiNmJ3NWJhYTQ5YkZlWEFpbUJyU3Z1bERuK0ZjcjVVRTc5?=
 =?utf-8?B?VnZKQnF5YWM1NW14WTgyb3g4dmZwMFdWR3JrR3NpTXphc3padE9FdzBDa0ln?=
 =?utf-8?B?M0lwbTkyQWxELzNNdi9Rdkl6MG5SZ1hmcVhLcXBMbWR3a3B2ZEttVVppSEU4?=
 =?utf-8?B?TkxjZHFXb1d1a292YTk0RlRNT0xmRkxxYWMvSldkeVZ2bUhwbS96MVNwdmRD?=
 =?utf-8?B?SXdtTnJDSkl5UjU0Q3MrZUovTlpkS1lxMFBsWlpyZUJzN3FabDRaY3pONmZH?=
 =?utf-8?B?YU9IRHU5eDVXL2VmZ2hUMEYydnlocTZzc2U4N2Z4UHEwTGpPVWtMeGlCZVVF?=
 =?utf-8?B?QjRoQ0VHVWc3c256ejQvekY3RWt4TzliQWxCK3BjNFNuQmRxVjVlNUdXNEtQ?=
 =?utf-8?B?c01xd29EVml5OHFTN0JvN2pTYmY5OW5kcmhSTUJIOGlpb1VkaU9JVzFKaDU4?=
 =?utf-8?B?QSsxc2YxV2NLMytjNDQ1L1pMaUJxcGJNNzA4MGs1dGFJejNhNm1RWnlsakh2?=
 =?utf-8?B?blJJREwwTml2YnZsWTk1ZTN4TGd5QVU5NVBwcUhNdWdHQnVqRXFvT0NSTERt?=
 =?utf-8?B?aEx5dGRvVXFCVlVtTUhFVTREd2RCN2xLTkVYb0JQamhwdllZZFRjR3lHSW9n?=
 =?utf-8?B?aHY2eS9aNXovNFB2TTJoWnhITVZTYzREMy9mYm5YeFBySWJYdjdvU1kvbHVx?=
 =?utf-8?B?Y282dU85TFdKZWNZMEdrZTlFZ2Rjc0V1R2tkTjQxYUtwdHFLdlFCeEkwMFpo?=
 =?utf-8?Q?CrZpnUs30BTsaXzANI8Cbid32Llg6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdFczlGRjlYeE1PckJJMGlRcmVubnlzNGRpQUhrSUxnVk5nNVd5M09mb0Fw?=
 =?utf-8?B?NEhPeWhqU2UxVHBuejVZL3pMdzQvZzAwVEZOeVdUclN6VDVOVVpyMzA1UzhL?=
 =?utf-8?B?NFFnblFRV2VuZVRHcGJ5QzYzL1VRTlZPdmZZQVBJZTJLUHYzMTN3QmQyTmt2?=
 =?utf-8?B?TWZEeUZZdU5rWHhqWUxvZExjdkp2MlR0TmsvTitRNk9YRDFWMytSREdXeXV0?=
 =?utf-8?B?NEZXandWa2dHREN1UDBHUG1YZHBXZVhrdytJSXN3TG9DYjZucHdrbUExNWg4?=
 =?utf-8?B?UVB4bzUwWFcxb25LSitPNkpidHJWaVhDZjM3bWdUc1pSNjBvR0VObzBndHh6?=
 =?utf-8?B?bUgwWUpnUWJ6REF4bXY4V2NFZzVZODlqOVpNK3paYnFwWDExMEdTMmU0SURS?=
 =?utf-8?B?UGZLVDJXU2s5clUvNVlZYUUvZjlZTGdnSFV2NUZkWk5EUytUdnpUQjJVZ09S?=
 =?utf-8?B?dC93cHp0d3cveUZpN3lud0dDYkZtbVdLM2Q1cE5Ib1N4Mi95dGVRRDljbFh4?=
 =?utf-8?B?T2NvWTVRWWEyYm1GOFNOSHpRejFlTUQ2ZTZRdVpxb2RBaFlsRnRCZkFLbExB?=
 =?utf-8?B?VDFjMVZuMHVQeEdReU9tbXV1b3dLS3NsRFhFdER1OCtWNFdESXRLMEI4by8r?=
 =?utf-8?B?Q3NTQ3pESUVSYlJCYytRTHUzZk5Jck1JQXBJaDhQYk9FaXpDbEl3aGRKcmla?=
 =?utf-8?B?V1U2VkR1OTA5dWpjYnZRQm95UHVrVmh4akZtYkVVYzNBUnJDZklJSjJ6SG5L?=
 =?utf-8?B?Ylh4UElSV1Y1U1p3cWJPM1RPK3JBcWdUZ01FNXppMGJweEpydTBFQndzNjg4?=
 =?utf-8?B?MDJxZUd4YmZtSis0UmN5dUw2bDd5aWFxMnBOaXFIeDBqOXdqZWVXNjI3YWJI?=
 =?utf-8?B?SktCQ3FETnB4Yi9RNW1rQ1AwVzR4eUs0dVdEc0FhMFdsOGJYMHhReUIrSHM0?=
 =?utf-8?B?aE5uZ0lrZ25jVXVoTW9hdERWbUV3bnpSYnJweDhTMFJzTWcvMWQrLy9JUXJp?=
 =?utf-8?B?RjdoSER1ZjdKSGg4ZTJIQVhtUU1wdnBhYUh2aGcyRHFUTy8wL2tNblVlamhp?=
 =?utf-8?B?THJBdXl3Mzh5OE1Lbmo5eEtLWU5qb0I3TUNxWmNQbWQyTk55VE5DRGRyK2lH?=
 =?utf-8?B?eFg3RWs0aTBpejF1cVVQUWtnN3dwQ3VXMzFvNGc4Q1JZeUtadXZKOTRKQTRt?=
 =?utf-8?B?QTZHUVVQUVAzZWJSVUtwZzQycVdsM1BhMXZVTC84VUkrZmZmSDRxOTBtd1dO?=
 =?utf-8?B?ZEpvQlNsQm1lamJKUnN2ajdoNmRVZklXYTVhbEFqaFlLMGlKOGZFWWtJZWI1?=
 =?utf-8?B?Z056M1hWeGtFbUlLSXZyZDBjVEZpQjNxWVFvWEFwWS9TK0NYbFI3VkdyYUxh?=
 =?utf-8?B?RHFuSGJjMW9QbnFtQUN4NG9YVkh6NjY3UURUZGxJTUlNMitUUGNzWjAyQ1dr?=
 =?utf-8?B?aTdqMVFvMFFYa3FNZDU1QnI1ZFpJbFluSkg2OFlabFo2NzE4NXU1ZzBUYnZt?=
 =?utf-8?B?cmhROHRsRjJ5bDhPWXNiNE15N2dDOU51bXkyM3lKS254UFBXVUkxWHVDK2hD?=
 =?utf-8?B?VUhUYjRqc2d5WkNnSCtHbkQ3WHczVWUvL2RpUDUyTkxUeVdwYzBwZWNRZDYw?=
 =?utf-8?B?UTRwRVV6dlYrdmhxb3h0TW5QMUxYWDVoaWVkMHNvT3RabEJuMXJLMytDSFcx?=
 =?utf-8?B?dmdHN29ackR0azRtNW0xdlNTVDhUS1dZUk1sc1RJZ2lSbm5ScjNYUFNMQTkv?=
 =?utf-8?B?VWx5T0F3d1hUdkxkRHJGejFsejFUYVRLa1p6aHJQejREQWhseVEzTC81VFNo?=
 =?utf-8?B?Qm1vSFpBRnkrd0ZIWWVkeG1JeTB4d3A5RzlIYWYyUThIS2RkYnlrWHdTeUY3?=
 =?utf-8?B?d1VYcWIxVDZGaUwyUzVZcE1tNzJtWnJ0WVMvcURoZ3NPWEFlL2lFME5BNGpa?=
 =?utf-8?B?aWhaWE5tU0xZQktIdHJIeWRrZlhyQmxYUEhPZVJDbG1GR0hsdTZieTN3cVZv?=
 =?utf-8?B?ckw5VG0yU3NmZys3NHNWUWVCR0ozeWg2TFYraWkrNUx5dDh1c2tSYjRDWFpO?=
 =?utf-8?B?dlpCdDYvZnl1SloxVEszd05aZDlpYWdoSkxGWXJOSEhtUVVEamI5N3A1NXow?=
 =?utf-8?Q?awyKIj65CecEoCMPbnF0r7cED?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba32e1b-a588-4438-a36f-08ddf74aa1fb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:03:27.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjazLJDB/e/h8SczSu1+B6/YyzsH+3sznKYT5XO0H4TPYs9G278nj98WuD5+seCEYlT/tboo+PEl4KmpQx1Zow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11452

The GPR_REG0 register has an USB_PHY_REF_CLK_SEL (bit 6) to select USB 3.0
PHY reference clock.

USB_PHY_REF_CLK_SEL:
bit[6]   - 0b 24 MHz external oscillator
         - 1b 100 MHz high performance PLL

Add a clock multiplexer to support USB3.0 PHY clock selection.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 7e88877a624518cc679cfb3bf673418207a1bc74..a87af0dff46fe6583f59d8584e1208c1d8f24417 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -301,6 +301,24 @@ static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
 	.clk_reg_offset = 0,
 };
 
+static const struct imx95_blk_ctl_clk_dev_data hsio_usb_blk_ctl_clk_dev_data[] = {
+	[0] = {
+		.name = "usb_phy_ref_clk_sel",
+		.parent_names = (const char *[]){"osc24m", "hsiopll"},
+		.num_parents = 2,
+		.reg = 0,
+		.bit_idx = 6,
+		.bit_width = 1,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data hsio_usb_blk_ctl_dev_data = {
+	.num_clks = 1,
+	.clk_dev_data = hsio_usb_blk_ctl_clk_dev_data,
+};
+
 static const struct imx95_blk_ctl_clk_dev_data imx94_lvds_clk_dev_data[] = {
 	[IMX94_CLK_DISPMIX_LVDS_CLK_GATE] = {
 		.name = "lvds_clk_gate",
@@ -520,6 +538,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-display-csr", .data = &imx95_dispmix_csr_dev_data },
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &imx95_lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
+	{ .compatible = "nxp,imx95-hsio-usb-blk-ctl", .data = &hsio_usb_blk_ctl_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
 	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", .data = &netcmix_dev_data},
 	{ /* Sentinel */ },

-- 
2.34.1


