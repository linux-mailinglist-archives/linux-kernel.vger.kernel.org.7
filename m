Return-Path: <linux-kernel+bounces-836382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3EABA9887
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D0E3AF192
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006430AACE;
	Mon, 29 Sep 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zgq3nyC6"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60A309DA1;
	Mon, 29 Sep 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155877; cv=fail; b=gZst9Pn/B8HbH9b8o1kTCfU/g8Sddv1IBMrN4g+5MB3rfs2V6wE2h/um2jJ3K6g+vHlXEEjJGRIpQg7ttaZoL2ezp+BmBaCkIMd1iqYxylpLhPIv+ptTo6G1cK7n48SESZSnca/P078f3LpPWSGk6wdxVZKmVT0bfFdN/oZXpqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155877; c=relaxed/simple;
	bh=xECP3rJgzFVmUgwO2Q0SoMn/hJcv7uPuVA3P1+7dxKA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZDkTfMwhfT17/a3ZDoJuTeM8fF1xHWVrqLXR/u/MJRKasJKdV5sjvGnsPwVqCuW2HpSOAg4NEfs3t5v8GwLUyB5ox+AD/b60HUQWdZygbzvmdaffmUkGLWfts6N9ovJQsLQvAA4R4mY9vpyn3158XQn/T2M/8z/03mWjvF8h+IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zgq3nyC6; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAh9ghOZy7IqE6u/wF4ZIgoCCT5/LxlwfcqCGNQ54JNcBy+mqBZn8eCX1hwmJ4M4QYesJvWSd2Zgh7VL0qS97LsxQYal4XQNdWGhio/qLSX+5Nx6M4jupdAa0EnO3Cz9fAnUAmic45UeYY01xfO3RotuJ8RPB39sJNUyMf6083mPx1PSsfDmXdEAsMGPWQknp6rVkDULOuGM6A4SjS3RhZZnzQgo8Q7SQDC7D2JAXpMgabTYWWkXx6rhlG+6GCiJDgD0CTCdpyAQ9DMjgcaiwOAhrMjIAKuZR1VXy9mU6WBqZxHHPLxOB3gocnB7IN4R4Cs/ELbwzIeol8X2slBxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/7c6QeaaBsZHSyTdcLsVPEzPuPsEopgWd5tUeWHZ1E=;
 b=OAjvF4H32BvqGj501CxcDiQJkS1h7YaokT6CjUBAfBBfLksvveiueDciXK1eDKTyiQQlHY5vA6R2nr36kXkHB3R9Sei3t0WVou05bebS4b0WNpWZ/ez5FmoTqH9/217539qd1dajRwhvHqyTumvjIpuUBs3SekmY68NFVHVwaZ6lkJ3EIV/1kqcg+v/HSW4Gi5Q/Q3Dz2j2hZbsWDT6fAAorhrTVQPP7yr9nzXgA510JDrMrVBXWa8YQ70pwuO95L8QTFV5CV6C6OslV/HtoRG2gCfkpYpU4beSou8o+PhFj7EC9z9yVmM05mE+1Vqgen5DUYMCfReUhseSsqgHvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/7c6QeaaBsZHSyTdcLsVPEzPuPsEopgWd5tUeWHZ1E=;
 b=Zgq3nyC6v9ff3G973aQ0gR58il04aNTpBnvPHky6VQpFv+alpIZXaJbe7bdCQeX8XjPYXXMtcZdmFNTF6RLOxyNybkmUM88CvyioKji6x4xDIXltWu3NtLNBmHRSBCy4rAZPDhc4ia15AJHcPl8GCl+f8q3DzieOZcX3Le+cY0G/rSOovWqrgBTHY3ZLAx2l1v8fCAL2CJCfe9HVH3qr6ULp9TJNN9MyxP+EjAYmvdLqp+qcB1IujqvdlXDK1k12dODmBeI6EjdZXnZFayXww9kpbKyH9dsFT7sGAG8o4OZYw0x2gdwh2PsDjd5kWBABLsDNUcdSO/1O6DZrqTeWww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:24:32 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 14:24:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Sep 2025 10:24:14 -0400
Subject: [PATCH v5 1/4] dt-bindings: usb: add missed compatible string for
 arm64 layerscape
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ls_dma_coherence-v5-1-2ebee578eb7e@nxp.com>
References: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
In-Reply-To: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155863; l=2369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xECP3rJgzFVmUgwO2Q0SoMn/hJcv7uPuVA3P1+7dxKA=;
 b=z0RLXGfhmdUNJsSAkrccw30/IbxUdHEz6gAmGfRFKctU6JK4ZdwZ64IsHQHvxE/jhpXc54E9l
 qy5kF+LdP7qBOqyjN+AXZOhJcT3p0q4/rOmsxvhL7xYKgt6/7aSdKaA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: d11e7037-885e-4851-b27c-08ddff63e7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUFZV0M3VGk5SW04Qi9YR01NZURIb21qYSsrWWpYVFJJcTJVYXdSZHp2OFpV?=
 =?utf-8?B?Tyt3dHZPTmhEZUREZURteFpCMFc4bGNoSUp4cm9UUndRTWRFck1YcVVNNitU?=
 =?utf-8?B?b0hJUUlLZnNYYXUya09KNDVEanZzZ2IyNDN1VTZ5M3VGUWxFeDFHbzRCVzY2?=
 =?utf-8?B?bHNCV2pZbmpLYVRjVmZHa0xpQ3AxN1VlZEF0V3VlSThHczlHcXZGdFZ4UVZo?=
 =?utf-8?B?bmtpRWFyMmVOS0oxOHptejlPUGc1cFNGTzJ5MWdRak13THpXU1VsS0twRy9S?=
 =?utf-8?B?UHA0RmQ3WjRDNlpQVkpMcjVZWHI1WHRjVWJTTE1YYWlDR1pZc1BiUnVmSVgr?=
 =?utf-8?B?RE5RRTVpdWZHcjJoNDcyV0trdUE0TFVDVFlFdndwUU11WFh0K3NPL0NTaGd3?=
 =?utf-8?B?enpNQ2lnZHlUUUlLSjFVek13QmtzVEZsc01acmdEWTFGbnc3V3V5OWRhdWxO?=
 =?utf-8?B?VGhTSHBibUhYejREenJHcVVxRzI2NVg5L2dSWjVBanBHNkJITUt6WVJnWExT?=
 =?utf-8?B?SnpTRWFlMW9JaXZzTkFqekxaZHdTTlVML2c5T3J6ZDlGSUhqRml2SjJ2cVEy?=
 =?utf-8?B?QzVXcHpiVnp1dnB4TE9nR2IrN1l0ZlFURTZjTXJDZG5EajV2cGFGVGZEUVFR?=
 =?utf-8?B?Y1J0d1VvNVUxS2IycWNCU20xck94b0tpc3NyKzBVb3pkcFl3Z3V6STlOTkdZ?=
 =?utf-8?B?eXgyLzNEVE4rSmhYK0pLL1M0VGNva3lPMVppMWZKM3lKb1hwTnZJYTNLbWp0?=
 =?utf-8?B?VEdwK08vNGtOT2VVV0NZeUhGS0lBNG9xZXZqbldRQ3lib2RESVladUI2M1li?=
 =?utf-8?B?KzgzUytzaGhJNE1xU3ZENkNPck16ZmRFUmNobldnUjEycGs2bFl5QkE1K1Vo?=
 =?utf-8?B?SnM5aVpJWkhtc0VvYW9TaHd6M0k3YTJleEVsVDJqY2xjeHJqSXRkQkN6L1BG?=
 =?utf-8?B?MlhWVnR6WFkyeHMwU2x3R3FZcDNtVmxrSVdCb1hZU2hLdHNObzVLeFZsSmpj?=
 =?utf-8?B?SVZjbHZxanIvc2FPbGgvN3V3L0FRbnY5OUp3NmFQQjVPS0RFRWp3ZkJXdWs2?=
 =?utf-8?B?UkhrU2JTdWFJNEFIMXNiNlBMMEN3bkYxMlYxMVZaQVdFazB1WTFpR2hyaEFD?=
 =?utf-8?B?ckVuMWdxdnZETG9ENHdWKzd4dUNnL0locmVHOGV4bGs3bnZnbVBMVXJWMDZv?=
 =?utf-8?B?UzRzK2ZEQjNKbktWQm5WZkVTeHpoeDB5bkI0NnRLUVF5NUlWb3JSaHhRYjVN?=
 =?utf-8?B?bUlob2FaNmtxdVdCTHlhUUFua0JtcmVSNnhWVDVUQjV2MFB2Yy93V05GUnFt?=
 =?utf-8?B?dm1IQ1J5SFZIdzhLcFJjVm90Q280YU9jZzFnTjdCTDNvTEYrUkJqOXdFWjRQ?=
 =?utf-8?B?WVU4Vzd3aE0wQThybzFNandJN0lnQzVqMk5aTlk5VDVxYnB0Qy9JQnlXSmtx?=
 =?utf-8?B?S2ZWcERoM0VsTjhsNVNheTRVTU43Y28rUWZCV2J6SGYzQUdyNHlVWnNrUG0w?=
 =?utf-8?B?RTMzenBEVXQrWmdTMW5uVGs2SGkvOEFDdHlwdktwZmwxbUtlbGRyNWJWWnJk?=
 =?utf-8?B?ekU3bGNlbkRqQmRxLzhyb2tuTFVHYkU1R2tOK2hKTEFpTCtaRlFncEw4UnN5?=
 =?utf-8?B?RldsNkpHMEg3NVFFRHdOYURmR3RwaEFlbERITTZ6eGxKWmdzVXdBZzFEcTdH?=
 =?utf-8?B?MERPbkpFTWE2Wit2eW1MaDdhM2h2azVzdlJ1cHpDa0FEVFI2WHQxUTRFK3RV?=
 =?utf-8?B?SnpzUVhHci9ZczRwYWZwc3hIclplS2xza1NKWGRYZlZES0ZkSDlLbEZLRlVq?=
 =?utf-8?B?dGRQWHd1SUVadGNuc2Y0bFR0c2xDMm15b0xsTzNDakhTOFhZWit6UzR0ODBR?=
 =?utf-8?B?TUxSdXBzNFFaRlBGS2xWTHk0b2tPS3daYUZBdzdkYmNlenR0bEZ5eWhSczU5?=
 =?utf-8?B?YmNxUGtDVDNONXlaWUJOd2pnL3hkeVE4Qm8wZDBHWUFqbGZIMkRtM2FJRW1R?=
 =?utf-8?B?VVlVeTBqNmdBZnBFcUlqSnJvSXhZbVMxM1JrcG5TZUNYaVdSL2VYWXZpSzdm?=
 =?utf-8?Q?Jtjxc1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGFUN2pzL1NTdlZIUzN0QTRJZTF1YzRCczlOTVdlcUNiWnFyMzNZbVR2ZTFh?=
 =?utf-8?B?d2RaN0RKL1d3VUlaa0FBdkc3elNxamY3b3FlRkE3WExJSGJkUWpTV2dDaHhH?=
 =?utf-8?B?RVJkNjF6anhsT1ZsYkJtQUVGYzhTSXNubklMUHFRZ1ZzSEJ6SjVTT1dya0ls?=
 =?utf-8?B?NGhvckw1c1ZuUG9RZWYwcVNJSnlXZXRQd0V1bVVUa0JLZmlzeDJOaENwNmM3?=
 =?utf-8?B?eC95dkdaSnp6cFZVdkFuMVFlU3pIbEFrWlRGYmtXelZWSGlZMi9IVTQvSUow?=
 =?utf-8?B?bkFKRUxEeTdmdUJtOEtSNVhhdXBvTmtxUElTeEg2cmc4V1FTQU1sUDhjNHc3?=
 =?utf-8?B?YTN1bExqQllrbmhDNmVCVnhraEFKeEMwTXhIM0JKUkkySU92VFgveHBEaG5B?=
 =?utf-8?B?MmdsZDQyWVRZbThwOWYzaUY4eXVKdHVGbUw4S0kzbU9CdnFMQkRSTVVVbHJi?=
 =?utf-8?B?dDR6MWFwdkNUblVPZTVJUjZ0QlcrYzhkeUV1VlV0Mi9wME4rZ3NZM2x4Tmp1?=
 =?utf-8?B?QjhXeEJFMFphbDlGSjVDNlFlUWppWTVlNTlhN0pJVktUUE1ScnFGTm9NeE5B?=
 =?utf-8?B?QS9VVzlubkx2Sjg1b0xuK29OTElqdzIxT096bjc4UlAvTVVybzZRNzg0VUxI?=
 =?utf-8?B?YUVNNVhQNU5UYjBTeVppNDQzYTFyMy9DdWlQOHY3aEV2ZFZURXltZ0FxMFRo?=
 =?utf-8?B?Wjc2TWZOVlpkYjBLUmE2WDZGZElrOFcyQUhQOGN6YUpZQk9LMnpHZ3JsaG9I?=
 =?utf-8?B?SzhEVnM4eFVLdzhURFpId0trUkpvbmhwN1QyZUJ3L2Q0K1U0c2JJemtoSVc5?=
 =?utf-8?B?QmdPMWF6QWsxVTRFZDhjSERrMU82TUdtOUV2MHdCYjBKNmVXV25uUzY4eThZ?=
 =?utf-8?B?a2hyWkpZUUVtNndVREFUdmo2MUU0aDZmOXBNYWI2ZmVlcTR6QVlRQm8wUXdO?=
 =?utf-8?B?SmdUNFZlTCtyTzdjYUIzYytsUmZtMzVoQ2VkVDBiZTRMRmhscFVXQzVUdTFD?=
 =?utf-8?B?SWNuUDJDS2plWjQvQlJjaU8reHNGcGJJMUxncWpUY3lPK01vSVpqWEpNZk4y?=
 =?utf-8?B?TmQ5WVZSU3lnTCsvREN0dXo4eEVHWjJaMEF5QmpEYm0yTSs0c0U3N0RGRjZO?=
 =?utf-8?B?UWJPZ3V4dHVka2pEWkZ6ZzdXMDBMS0JvdkdWcks0aEpnQkdualh5WE5rdXp4?=
 =?utf-8?B?bGhtREZDdWp0WXoxcmhqSys1Slg2U1N2R2k0ZnBUcTh4Smh1SG1KdjRWQ1Bw?=
 =?utf-8?B?enNpdUNETzVYSGhpZy9ZUkFMcVM2Yit4WkR6d21KRGR3ejZiYzVsK1ZkdmV6?=
 =?utf-8?B?dzRDMVVQYWJqR200NDNjNkY2dEx5dnM1cWhTTkRVMDhGWVgzV0NkaXdkYUx0?=
 =?utf-8?B?U3ZiUHBZZmkrV2hQckZpQURac1BsK3ErNjJuUUJZZm5RVzR4VmZoVXE0bk14?=
 =?utf-8?B?emRaSk1WaHRNWEJPeGhzQk1BWHpaZHNISXJ2cHhxN3V0ODlRYS93cUE3aUo0?=
 =?utf-8?B?LytYR2tTcUc2VXd1dEVha1ZQMWFhenBFTFp4Z3N6eUJUeGZ2eDlQc3BWenZI?=
 =?utf-8?B?MTNNNld2NlVxNHhMUFFSUkxLOUoxQlppeW1lM1AzRjJYNTVQUXROeTlMNUJN?=
 =?utf-8?B?aUx1dW44b04yMVdUVS9yYkZtdmZVbkdyOSs0cm9Dd2FZTUdtODJKT0JpTjRp?=
 =?utf-8?B?QWRQMnlha1E5dTZYMTdtR2xnUVp5L3JjSU9qSHFmSXRSdll4K3FiRjlzSFNz?=
 =?utf-8?B?Wmx2bmhQcjNqSFB1RHE5OCtBQnM4cElVTDVwejJqUGJtamFCbGMwZW5ZRUR2?=
 =?utf-8?B?VWM3QmFHSjRFeEtHTC9MNUpLVWIwcGs0bnkvS2FyQkl1NCtLRUc2bzhZYnBy?=
 =?utf-8?B?UzY3bzZ1ZDVKWDBQWWhaSjBrdUN5MU5GZUhLN3JxM3M0OURoZHNiejdSWTg4?=
 =?utf-8?B?a1liWm9EQXQvMW9CR3dNdGcvTVRwaTdqKzhSZi9sK095TEFZR1ZLaUhTQTdE?=
 =?utf-8?B?UDh3WkQySklwZndzdno0UXYxN0djcUxwOS9ES3JXRDhwNHYva1IrQllocTRO?=
 =?utf-8?B?NTNaN0lCdTRrUmF2Zlp4dlU5ME5YNk5lM216dXRDeG11MGZYekVwcEYzQ2t0?=
 =?utf-8?Q?ZGes=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e7037-885e-4851-b27c-08ddff63e7de
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:24:32.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QthxaWMDgRe0qj1T7c//oFl0lZcMclFR1Hu5F0r/k5YSiwqdHL7Wk30x7Fy54Jamh6hJLbPBTSlOO+32g9Lo3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

Add missed compatible string for arm64 layerscape platform. Allow these
fallback to fsl,ls1028a-dwc3.

Remove fallback snps,dwc3 because layerscape dwc3 is not full compatible
with common snps,dwc3 device, a special value gsburstcfg0 need be set when
dma coherence enabled.

Allow iommus property.

Change ref to snps,dwc3-common.yaml to use dwc3 flatten library.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2-v4
- none
---
 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
index a44bdf391887f9c7d565c01d2c3aede99c4a9fc3..4784f057264ac7b18cbc8b41a405f9c9268605bb 100644
--- a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
@@ -9,21 +9,19 @@ title: Freescale layerscape SuperSpeed DWC3 USB SoC controller
 maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
-select:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - fsl,ls1028a-dwc3
-  required:
-    - compatible
-
 properties:
   compatible:
-    items:
-      - enum:
-          - fsl,ls1028a-dwc3
-      - const: snps,dwc3
+    oneOf:
+      - items:
+          - enum:
+              - fsl,ls1012a-dwc3
+              - fsl,ls1043a-dwc3
+              - fsl,ls1046a-dwc3
+              - fsl,ls1088a-dwc3
+              - fsl,ls208xa-dwc3
+              - fsl,lx2160a-dwc3
+          - const: fsl,ls1028a-dwc3
+      - const: fsl,ls1028a-dwc3
 
   reg:
     maxItems: 1
@@ -31,6 +29,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
 unevaluatedProperties: false
 
 required:
@@ -39,14 +42,14 @@ required:
   - interrupts
 
 allOf:
-  - $ref: snps,dwc3.yaml#
+  - $ref: snps,dwc3-common.yaml#
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     usb@fe800000 {
-        compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+        compatible = "fsl,ls1028a-dwc3";
         reg = <0xfe800000 0x100000>;
         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
     };

-- 
2.34.1


