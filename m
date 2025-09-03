Return-Path: <linux-kernel+bounces-799384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE8B42AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9A1C22A88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074D37427D;
	Wed,  3 Sep 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXRGVGwg"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0D3728B4;
	Wed,  3 Sep 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930853; cv=fail; b=YG3SgoBCYafmo24YoAIyYDNqy5zq7dHacF+NnYdrUY4QFKR11Ztp5iveF4qkAIP+KTeaBOSFEQgsgETJzRgw6NRinpeMm/DU5qQaYPBzyNZWT7TOKaicF2kOhN1Qs90LMTjBxQeajAcmrSUagJXm0pjwlHaQV6eA5jlDcoH25mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930853; c=relaxed/simple;
	bh=1TCMpoWArWrcasNqGJrzMEGO/LoXMVN/a2DHXkKIKvo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=urAMnXnWUME3N4kSZepzKYTyNsARrjYefZeRRG/8Hc7j+AZ8bdQTs74uzxFxph/reBB8OdG6O5WM6pzvgelT7GWbK7Lwlb74iIHuFvdT80lWke/coqyePN8cAjcZW4eKyPVgujnEaHIVOy8si3yiFqYouV+kP1haBgQc9FhZwmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXRGVGwg; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyjLHn3xS40xubxgQcd6oo8Rg/ZoQUEoloJvnMrY/yiJfA90GR4mor8wSQPnLJxaXrpcDIhhN2B+o0gtY9rV4J4lru9+97OQIxgUGBd6Ad7t/yLIDsAJL0TvXecXTtvP2TRW7adovcCvHpeGxQ6vWJVnfcdAywYgWv/tb9pjPRBzY1x7RlDv//59WEyhtvJKTLyxEQHZbGGkvKSPkSuvxzIuuBJSWLwF+p9Z1IV35p0Jez3eCooKJScCsx0LQ15y9P8Zm8m5/745nem8ELv4Kg1YlFP2voSjjqU8Dn8d0/MLyYEd2KRHOjMNS050bGorwhz4S24OI7eykyEc9g5Nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBidgIA1e6ZK/rOklKZoFYHw1llcH85KaEVdn7UV4Qg=;
 b=Eizw3JYlR2jAVOe2eEp+PTeBrGh2CNLTxygXR2s8ftcwiYCB/1LTyAGXvzgvDG5Nfz+5saEStRj5YTXHRw/RZtK76xUhRjX2clzEfYc7+KH2RnW0Pz/Ud6wRCL6YPjAYjR4NVDMuG9mfg+nuqDAwT+8w4BHRsVTsg95vXBIoQrWYuJHzloxxJcL/MKU0aeGs34gb0nQwx0Jg80Y9b9hhbcMSWLJmKwKYcvSWPOgyPCQ2YDgLSJMcV6XyFnximCkGzlWfqxugenweFB3w1068G6LgnAZ352UJMv8hVyJnX5NvDosyXpuTx3wDd3mutB6c1HCvmkKBjY4X+006qTQLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBidgIA1e6ZK/rOklKZoFYHw1llcH85KaEVdn7UV4Qg=;
 b=lXRGVGwg3wdJTZcmWApFDzHHJu1nTvLp9Q2FK+3xCLlMJuS93LYRutEyX4JBqRr0oKqlOlfPRNE9MdHXVMyKAExki0TlWZLPznDOEKSGjXlLx39Zv7frYlZ3Iw9nl6wcbHOsEf7fmonZ1QFBNF4Q2vfDT7HOOGxqJlwRQ2Pc0Rqr+Hp7JkIrKyJckhtDg0nJDfFgsvYDveuef2+I3LxkaNAzWhiaxMlTp9MhraDlqvbrKK5uUHShkxmbfbme0VtM/eo9zx23K4ezdD5F1Td4Ho/Vw3yFlVeJ4O4LutVUy3qxV75BNssETbDLLh6dHhghyxVz8lmfBYjd5JmqcW/irw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:46 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:08 -0400
Subject: [PATCH 15/16] ARM: dts: imx6: remove undefined
 linux,default-trigger source
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-15-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=5494;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1TCMpoWArWrcasNqGJrzMEGO/LoXMVN/a2DHXkKIKvo=;
 b=ESkVlP1c8MkbBye0GLGa4qQdh7NT/mYJ5bMnlW/2JaVNkMJ95ihvdjm36F+WXZpJlpgvUTcR4
 SPry38Wlba0Cw4nzGwkll7AC/Y5JUlHiqmuHVBr2yWtkrlQxysyaxam
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dae08c4-bee1-473c-eb10-08ddeb275dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHZZeVd3Ry9FMUh4azRXbzk1WGtvVHVwNUpNdG9zVzlydWxpZWJKOWpOemUw?=
 =?utf-8?B?RGQ4ckdWL3E1cHVpS2FvZ3YyMWZmM1pyYTRqeEtqWGIwdFd5cnp4S3FJT2Zz?=
 =?utf-8?B?VnRNeVM1Z2kzcUlSUU9wZGV5NExPSW54d3cvSXZaS29pV2ppMERqbFZsWitM?=
 =?utf-8?B?NVJ6K3N0MTllcVVSazR4TXhsQ2l5VTQ5K2V3eGxFdWRhZFNhbmNIMU5NYVZ5?=
 =?utf-8?B?R3E5T3ByZVVOWjFvMU1OL0ZlcDdTaHNnb0l2czhMWDZ4ZmhCaE9zMjFFTnRl?=
 =?utf-8?B?cnh5aEdYblNpL1R4Y0RmOUhMUlAwMlFBUWRLN204VGo5QlVFUW0vS3V2ZFZJ?=
 =?utf-8?B?azZwbW9aalE5MTFnRFNTNmFhR0Iwa1cwb0NZbDRma1FSbDQ2bE40OERPS0Q2?=
 =?utf-8?B?bEg1akRyeDVvdHJVNHhjYXpZeGtQR08wSUtHeWJEelk1YWZaalZmNi9QckxY?=
 =?utf-8?B?RXVUQzRXRUZya3JJWURScVBvaGVaLzRZZU1CTXdwM3hGMjEvRG82OU1YRmc0?=
 =?utf-8?B?a2QwWWNmNGluUFFSZGxrQk1vVUVvdWlyNmlyMnBWT1JkaGRvd3NmWWg2OFl2?=
 =?utf-8?B?ekFWVTZGN3dUNlU4RjVhUkhzaS9KQlUrbTF2SC9tM2RaV0wyZ2x6NXRmUDEz?=
 =?utf-8?B?QmxzL08xcm55VUlhUStCc25qYUR4bWwwalpsZXZ5M1R4dkdtdFMvOWgwSDNV?=
 =?utf-8?B?bVAwbFdDMndTN2hrOVZwY0lwNEQ4dDZZZ2lySkNCZVlVMmtKdFFhS0IwQmpM?=
 =?utf-8?B?RlZodHREMEpPSHRTTVAwdXZFS3RIMTVEd042VENhdGI4cFhlWkk4bE5UaU9U?=
 =?utf-8?B?V3N2U0tkaUpFZTE3dDRWTU9GVXR1MXRPVHRMQjJhQW95K2p6eFBPU1RVTUNQ?=
 =?utf-8?B?TVZiWEJmb2U1TlJ1NnBUdE1qcGF3bkZ3MjBHbGpSSmtxOS80Y1YzQXZHNkNO?=
 =?utf-8?B?bnR6MTJWbTgxMVBHTTJQbVhhZVpuczFoWUdjR1dmVHkwbjhxdm5xelN4eHRP?=
 =?utf-8?B?OXNZMkRmVGFmTGh6R2hFdjJaYm90WndEQWprOExVdWdyK2RFaitjMTdjYkUv?=
 =?utf-8?B?OGFlQXZKR1JoNEpobnkwaVpwTUVlRUFhOXJrTzBwMEpsaElUZnAxL0NnWTR0?=
 =?utf-8?B?V1FET0lLeW1WbHdvdGZZVEp6MDR0L05sNmFTbkZHY0Y5OVdmM21CQzNsRDNo?=
 =?utf-8?B?bnJlWFQ3S1Jva1JVUjkwYnlZQWVxbkwxeFlwaTdIQzhIWnE5eklPelppaTUr?=
 =?utf-8?B?Y0ZNVTQxZXQwTzZVUi96dmlmYzJyODREajR4YnZGbDFkNTJkSHJLQWw1a0ph?=
 =?utf-8?B?NkJ0YTlPb2xpbWxLNkw0MEtBeUFFYXFtQ2xaaDE0SzMwNFJzOHNZd2MyOGJ6?=
 =?utf-8?B?TXowWUxVTlRSemJnb1VzbUFNSG9VTG01L3J5b1owd21IMTdSTXE5MTdHOS9Y?=
 =?utf-8?B?SkprRnBHWDgwcHcxRExVbXFWVUlvSHlrUjZNQ2RmNEVkbG5NNW5rZ05ibE1t?=
 =?utf-8?B?ZWNFOGVyUXVNWk1rZXJZK1o1RDkrM2JwdnBNTVJzWGNqcGM2d2xUTEFFRlJz?=
 =?utf-8?B?cDNjelp6dGpURDZMbktVanFXNjIrU1NDaDJHeWZ2SStZUTZ1cXk1YW9nS1JY?=
 =?utf-8?B?RWhibXMrWkxSaXlJN1JOYzlKdUlYcVV2T05LcWR4eHFaQWYrSGRsNUo2MVB1?=
 =?utf-8?B?NEZ3Z216cUxCTk5JRm9ENTFoQ0tET1dtUkhXdmVGeXdUWVZ1cUFpdGE0T2RS?=
 =?utf-8?B?VDZ5NXZ0ZTFON1QxL0xqNWF1ajQ3NStaU1ZueFE2TkY2c0NEV1k0TC9mZ3Ns?=
 =?utf-8?B?aVB2VGFjV1l4WmlFMnE0VXpqZTJXZHVRQ2Rac0NkaC9BUUVrWlpEOVcrb0dk?=
 =?utf-8?B?US9xdVNIWVU2dWl1ZXZQc29pbUVYZXBUQ0FCT0hHMHZVR3hhZ3BHNUlvR0JG?=
 =?utf-8?B?VnZOWUZla0pQUU02SFFHMFJFVnhZNzk3T2l3ajF6NmNqUmR1bmZVanQrN0l0?=
 =?utf-8?B?a2o2N2JBQWx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3pURUkranRRTkZyNGFYamFJcE5TallUckVCZ2ZGQmZlYW9zQXNmUFh3azVh?=
 =?utf-8?B?VFM2UUhDK05HYXFGeTVhZlppbHV1TnllTHM1ekM0OW5YVFBOMjRvb2Vacmgx?=
 =?utf-8?B?REJWWDlPalE0OW4yNjNkamppd2pBc3UyOGxKL0w2azl1VVVGRk55VkxpMGwx?=
 =?utf-8?B?THpXQnNBOVRJNjd1RGFmdGE3OE1jb0ErdTBiNUg5MmNSaXpVNmZkQmNwVzlB?=
 =?utf-8?B?NzN3a1hSZ0UxVEdlSHVpNjY1b2FTc3BJS1pBcWZIWW1BOWlOVS9xZVRWNThF?=
 =?utf-8?B?Vm9reHFWak11ZTM2d1ppUXh3QkZMMVp1S29nL1VPWXkwSHg1cEU1eHQ4cHZV?=
 =?utf-8?B?WEZLazhsWmJqQzdRR2kxZUlEUXhIVUxsV2IzLzhrNVZkVWZtU1NVTlNaKzBI?=
 =?utf-8?B?R2NSd0dlQWZMSXdvMytPM09jNUlZcHl6MlhGdHk3azQ5YzN1a1hSbWJqc0F6?=
 =?utf-8?B?ZC9hamcxdlRaNkNnaHU3NTk2ckNoajJQY1VqWDN3aWZCYUQzQXdYcHpZLzYy?=
 =?utf-8?B?ZERaZjM1YTFVOG5BdE5adlgxNDN1TE9DTTZQQVNDS3FjMHQxamtNRFlzL0NH?=
 =?utf-8?B?Yko1ZjlaSlFpZzcyOXVtRGlWZ2VEL2gyK04xVG44c3V2ajYxUXNGdnJlbTZN?=
 =?utf-8?B?bzNxWWIxL0FQT283SElZcUlxTWxpcFQvdHFrdi9HaFZZb0Q3WXVXS3BkY04r?=
 =?utf-8?B?NTI3dm1NUndvSWZsSHBYN3VHWmZlRmFTcHBHVEphaThncEwzYU80R0F5eHRn?=
 =?utf-8?B?VUpTUFNxYi9aVkpPalJJWjNhVVUzRDhhVm95Rm9IQit3MzhxQTFWK1FtSkxN?=
 =?utf-8?B?clY1ZjZueDJuMElDajF1WUtObVUxT2srbkVjRCtLWXpZT293ZTRkWUEvWllu?=
 =?utf-8?B?UWcxTVRBeHZITFlSc0xKNUNZckJjQk1RcmU1Y3RxNjFrUm11RVhhcVRiR29H?=
 =?utf-8?B?WlhFbmZoWmJvMUJFQlhoZisrZEw2VUFmYkVucFhNMHZmdFpyc1hkalo4c3k3?=
 =?utf-8?B?czdKNFBLT3FiT0hIT2tCWmM5ajkwaUZ3VWlaR1E0OFNFNWxnZnlrMmFmMm5a?=
 =?utf-8?B?dE5tNUtVWDNnNm5KUWZLRHIyRDJmWEZHak9HdVhjZnlXZktFakpBQTEySlZM?=
 =?utf-8?B?RmhYdFNraGk1bzY1emovVWhFNkcxcy9mSG83L0NUblE2cnA0UzVkSmtHRUZ4?=
 =?utf-8?B?QjZ3TXUzYmNSKy9taVZ5OCtUU2tkYWFjN3BaSWNSb3NxTnJQVVpvQTR0QWRK?=
 =?utf-8?B?S2dyb0tMMmtUcmN5ZlVvTVozWGlVK0JVakM0YlVyNVRCemxlbU5mSkNJTEdG?=
 =?utf-8?B?QlR1TTg0bmw0WlFaR2lRMTVlN1dJSGdPQS9OUTFVbE1LYUpsVWtJeUZ4K0Fm?=
 =?utf-8?B?YWYzL0xEV21PTlRVR0l6RnRreXJRZHl4eGxVYU9mWFM5VEptQzJtd1dBaTFQ?=
 =?utf-8?B?V0NQOVUrUmdWbm5JTVI4SVgwUmJBbjhtaVlkbzBrc00wQzFtN0hqb0xCaVM0?=
 =?utf-8?B?TjRoRjhKNWwyN3RIMEg4MldWTkVhckhKQkt0YjIzRUUyUVM0dTJsSE94a1la?=
 =?utf-8?B?b2ZWY01Yb0hZRDBRNHU4MEpqVjZXWjhZOFB5ZUxHanNxZjYwdVdmN3NiVTlO?=
 =?utf-8?B?cW5XbG5CdjJPS3haa0RMbFVaZDdPR3JmWEMrZFJHOEFmS3RNci9iV09QL2Zr?=
 =?utf-8?B?TDBYcWRXN3Z3ZTdoYTd3dUtyUWpBRzFUSzVHYUJxQ1REVDlmY202d1FhZDBH?=
 =?utf-8?B?aUxacFZBckxQeTlJRUQ2L1pGN29NVmVKSHlaV0FwdWpDUW8vREliZzVLeTJl?=
 =?utf-8?B?NWxLM00xUXlSUXQwRk43Wnp1M1hiTWpmamJsaWx2RlNiOTdqQ1JMUWtvSXJU?=
 =?utf-8?B?eXhON3ZvRzNRYWM3bE5HM09YeDYyaTU0My8wbyszZFdVaWdiLzZVMlFDemJn?=
 =?utf-8?B?ZFF6dVVsVDUxS1gvVkx2NWNQV1I0K01XYi9JM2VRRlpNM0hOT1F1c2pLeCtC?=
 =?utf-8?B?eStVVkliRDJRUFg1SUdkS3NZcHNSQ2FUZ0ZGYldiZ01LR3FoaGtWa1JnZldk?=
 =?utf-8?B?WUVuQ1hCZ3RKL1VoTkk2VGhRc09uVko1TGZuRDdHcUp2R1ZFMkJDY3NiZ1dw?=
 =?utf-8?Q?8aXQqBzm+C5jSdihgTRRKSu08?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dae08c4-bee1-473c-eb10-08ddeb275dd6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:46.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nejxQk8xcRrVIpwUcTJNYa2Ujx8233r66LY1ZRSg0TEgX0ctHDrDnrLl3tz8sh0/MU3+0/xpwqAWm+ZNS2MeBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

Set gpio/off to none for linux,default-trigger.
Fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-phytec-mira-rdk-nand.dtb: user-leds (gpio-leds): user-led1:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
        'gpio' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'netdev', 'none', 'rc-feedback', 'torch', 'usb-gadget', 'usb-host', 'usbport']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi                        | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi                        | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi | 6 +++---
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi            | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
index ebbd4d93e46065f16bb367c449918bbdffa2a4cc..543cf723008fd138e0baddaf3ec55d16ef1dfc17 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
@@ -42,14 +42,14 @@ leds {
 		led-bus {
 			label = "bus";
 			gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "off";
 		};
 
 		led-error {
 			label = "error";
 			gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "off";
 		};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi
index c425d427663d0624646dc55c38a596ba78f6ce04..d6deb8c22b8c34f450ed5d9f9aea6872fc9fac6a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi
@@ -69,14 +69,14 @@ leds {
 		led-green {
 			label = "led1";
 			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "off";
 		};
 
 		led-red {
 			label = "led0";
 			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "off";
 		};
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
index 060d2aeb1baf750c1b134ac716d9948fb64e5f10..fc78acc9f5c5ffe4cbc24a9aae07bc946b651050 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
@@ -35,19 +35,19 @@ user_leds: user-leds {
 
 		user-led1 {
 			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
 		user-led2 {
 			gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
 		user-led3 {
 			gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "on";
 		};
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
index 56040da0bd25d162823536af1210a3fe8be7d314..b6c336e3079e3c8da7736fb1638beda2027bc7fb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts
@@ -84,7 +84,7 @@ led-0 {
 		led-1 {
 			label = "tolinoshine2hd:white:backlightboost";
 			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "off";
+			linux,default-trigger = "none";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
index 24c48cdd1797e43fb364ce6680b4f09bb526e788..113485e3397aae8941fcd12c4518b72d757a6b25 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
@@ -29,13 +29,13 @@ user_leds: user-leds {
 
 		user-led1 {
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "on";
 		};
 
 		user-led2 {
 			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "gpio";
+			linux,default-trigger = "none";
 			default-state = "on";
 		};
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
index 8ad09fd334f74cf7e1711a57885564eb9a549902..7ee25b14162760effd4a402470f814f021a607da 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
@@ -79,13 +79,13 @@ user_leds: user-leds {
 		user-led1 {
 			label = "yellow";
 			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "off";
+			linux,default-trigger = "none";
 		};
 
 		user-led2 {
 			label = "red";
 			gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "off";
+			linux,default-trigger = "none";
 		};
 	};
 };

-- 
2.34.1


