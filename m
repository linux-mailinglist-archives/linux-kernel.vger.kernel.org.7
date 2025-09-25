Return-Path: <linux-kernel+bounces-833229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11714BA178F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FDB16B1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C23043BD;
	Thu, 25 Sep 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A2qzKhnl"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644C27467B;
	Thu, 25 Sep 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834849; cv=fail; b=mRqPC9vpzuer2sXyrjfk5pBc8Orm3eMxHyaV/E4gzg5JDvytxn2RIKFCRxNoNWcRIoByk3BgUAMpb81MfjiwfZck57pSA7NpkI8JTxajT/cm2PkvMOyx6ubhDXt90WzC2HBokgHMcPs+EwAQGNlREHkOgHIuwuiVKrdv6sAczjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834849; c=relaxed/simple;
	bh=RmK1M6K28/4NLlJsau/A+EJYlQ2J0Y8DRQxMi1XLmHs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BmvPv1mzpASxoBXebuuBhGXA+hd7dG2xhFkgdev+xCq6/FBOUdeeUXBoAAkGkTSWrOHPNhdbLym/yA7olybaes//0TnUpEOZ0mAC+LM+s2d5H40kmNO9uQl/p4jP3ZszIOcupex/Wt9j+hjKCKAOe9QgbdBA/j74698Mh1Shdsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A2qzKhnl; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+qQEbXW8OS7fAajPI/QPRagFGniqqtZAZugBTTmPgyH9kUEOLhdRr/MvFRtjSAzC62f/rVVedyUOUOblWYWXp0yzNCs83xJGZVvzSs0ZByv6l5NDYnWL3hc5SVuU7Sz+8BnzT8+ko4JwmfkCzqG6tW0buK0OGkH6jwt1FRXCfQ5GpUlJ1EmsHGhvoASyNkgNJfJOzh6vAa8KY1BV+jsuP6/ZMmEsbhshvbXVTWP1pVsUbsbjCRmlvPOlMYp+0JXFtLqOFYgCVII1Y0Uovfdcy6tACJ1MHuyGrbUvQnbR+uEhuOevjIzfSLoEWFRER9qHpHmRwJC2/IhcQhXh47Hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0+z0oYlk9jDvjJRl4USuz7KcqjFw06Xc8LlhssibZ8=;
 b=gRreakTZngwTX2iAlZzcQJeTrR3zH4/Zl/HYZJpjIJZIKj7GO3Y6nk11zFChfTEo0qSCw47OAvxAdFPM2IDjTjQffgNOucVmVuH7QByI/v3Tt6INthED5JJDVeMjPTxoevihZM2a9Dz+6X6OsYHgo4RAZiXRPlQgTeKUTRy0JjGMp918kH4KVR+PNaPdepsQEIh23ZcaGHOIzNlgKUSSquc4rEbRoyIuTzf4+2UVgHuLnsN98Q8ywJHo0rn4Pk7kAGpaNKoGMOpfvz8iivu7reotamdkBNwgy293UdCBYPArxQ5FMijJRoNZhunhDZSXtdpakrxmPBX/MQrch4mOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0+z0oYlk9jDvjJRl4USuz7KcqjFw06Xc8LlhssibZ8=;
 b=A2qzKhnlMXnGvgsbEuosanKJOlLTH8fXBjohW88bkIY15IDX/Y3yawVvOlElIqY4crebNEX0JR3be+Hi4WCiXQukM19uD2/2B8WvRen9FzocvYc5DfOM7eltuEIjNTe8F10DdqHnUby1s8bQ2XL/J9dz8KIYk6yBAJapoBugwb4e0Y/WB2h6XxHGbRGsQut1tK8zoD9RLSwQzs3tZwvVrwrJWxA4Z4htvvll2UxhrfAGbuC0vesVs5Tw17bqU1WYs76RF9cc5H6D55hFZ57zmjcuN7iSOsXGQceAinnOjCSOkcWxQWKL6FHgqCizvLIKhB9CjDdGLf12qSCoCyPYvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/11] ARM: dts: imx6: trivial change to clean up some DTB
 warnings.
Date: Thu, 25 Sep 2025 17:13:44 -0400
Message-Id: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIiw1WgC/x3MQQqAIBBA0avErBPMUKirRIToVANlohWCePek5
 Vv8nyFiIIwwNhkCvhTpchVd24DZtduQka0GwYXkg5CMzqQWe8fFHKjd45lCu8oe+WCUgJr5gCu
 lfznNpXy3np8qYgAAAA==
X-Change-ID: 20250925-imx6_dts_cleanup-6edf53e09c62
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=2058;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RmK1M6K28/4NLlJsau/A+EJYlQ2J0Y8DRQxMi1XLmHs=;
 b=72YFrJZHbE5Km2VC4irkXRqPTOGxaINADqapuGl0DHHTkgnby+IWGc9SgJ5B6r382OFbA57ck
 LUTLSGEbrEeCoeAT/ihHaVfcHa+X97SeZiY9pkwELe2zX05IaGwFGfq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: b13d6523-7b52-4b48-1ba2-08ddfc7873b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjZ5cko3SlY0WkxQZ2ZhWGU0NTdtYkEwbXJPaXliTlRnTVRPNmwwbFJiR1dE?=
 =?utf-8?B?WWZ0TmtQYjBpUlNCSW5VS0x6UTBMb2I2QnRhZ0czS0RvR1VrL093WjJNWENM?=
 =?utf-8?B?WkNLSE1Bb0V6YVpHUUd3MlIrell3clIxUEw5eE9jbVR4OGtJSDBIaDBiVWJh?=
 =?utf-8?B?L2VSeUdLVHRvUHNSZkV3WXdIeHlzVm1kMEJpWFBHUEJOdVlFclhPdFVWcUhq?=
 =?utf-8?B?RkI2TVAwOTN2c2hFMVBjTHlJUXFpeVhVdkROWlhrdHRCcW9KRGRNVFB0OVJu?=
 =?utf-8?B?WWFFZW12WkViYVZFSGQwVzAyV25PdjA4elVOVWJCV1l6aythbFNrTEtXa2k0?=
 =?utf-8?B?Y2kxSW5qT2Z5VGxacFI4ZDVnaGYyZ2ZvSmhWdk91aHhvQkQyV2wwTmNnRG5r?=
 =?utf-8?B?YkRJdk9kc1V4NkZpeHV6cjlDbFN6OVZMYXVpb1pCVTJwVy9xQ0JrWUZHRW9z?=
 =?utf-8?B?Q2U2cG1mR3pwc21WK3VodFUwZC8vVllHeEZKSHZLMitENGtUNDJqUVMycEhD?=
 =?utf-8?B?TGlPRWdMajJRNEUvVGR0dVo2WDh5S210Vmkvb1hIOFJ1U0RBVExmMTRLbGNX?=
 =?utf-8?B?UDRHM3ZsZDlWQWtJeXRDOEZRNGY5enhBMGgrQkMzcDVOdUtWYXJuamVveUhW?=
 =?utf-8?B?TThmR2k2UHoycnFhZlEwb0NpVlZFakZDYXZKb2MrM091cjc0MW1zK3BXa2pH?=
 =?utf-8?B?cWQ5anZPYTlINmpZdk9YMHpseW5EV2M0d3VtZXZrZExBbDNRbjRZRUEwVmFD?=
 =?utf-8?B?WU9jWmFoRmZlZ1ZkZ051VG81MVBzMUJ4R1R2bWNGVm9BaS82V0ZuRm9jbkd1?=
 =?utf-8?B?cUVQd0N4RkFXNE56eTB5aE55L29uUm02MzFhQXNuNE5DY21iaS9RRzBOTHVl?=
 =?utf-8?B?QkNKUWZiSkhjNVRTL2Y2bHhXbVppOHg1UFAvM2E0MGM2Uk44WVVMQWtSdG13?=
 =?utf-8?B?enlWZHBJNExaWkJ3a0JUcVp6ZXA3UElBbGtpUCsyMU9kYVh2UjJ0T25ZUHZo?=
 =?utf-8?B?eUZsVVRBUHhzbGthMFBUa0FycTJrWDNsSEJYVzk3a0pxdmNHRWNGUndrbzNM?=
 =?utf-8?B?d08yVjAvOXA2eGEyV3pTQU5zNDZhQ0JlbmJldkE2dDBZcEJGdzY5MXlRem45?=
 =?utf-8?B?N2hJWGNnWFBDTjdESEszZDE0cVdTYU1JR3g5S2dlMm1nTk1IYTE3YUVMblRK?=
 =?utf-8?B?aENaUjFLUzEvWUNXdXpFWjk2MFcwYWdESzNRSktnV3c2ZEZzSy8zM1hMTWlB?=
 =?utf-8?B?OTlBLzdzOFVtZ0VzK2JQZVAwMUcyYXRWVnJSa2x2QmU4Y1EwRkNzMmsyVUIv?=
 =?utf-8?B?NlJtY1I0WUQ0eGtwSXJ6YmVXWUpZNEhVclpUMWUvMk5TSDJ4K3UvTUczYURx?=
 =?utf-8?B?dzhKY0xYN25qOERPNWQ3dmRBOE9xYVlHbUtSOFFIU0ZkZ1IxeTVIZVRQaHkv?=
 =?utf-8?B?cXJRMjNxMmc2Y0FmQ1pFbjdwcGl5eEtaeXdkTWw3WCt6R0F3a3JEamVyWDl0?=
 =?utf-8?B?VWpXK1lJaFNYdHZQdDNrNFg0MVQ2eEc3VFBySmxRbGxjVFNCYzZBTm5lVzd5?=
 =?utf-8?B?RTRUODA1a1ZyWThZS2ExOGVXZGNxOUt1Z2VGWGF2Z1NyZ2pQOEV2Z2QzekJl?=
 =?utf-8?B?My9zNEVrczNQb2xKSTVuUzV0Qi9ldENreTVHRDhwUDZaVEVKY0NRTFRzVDlF?=
 =?utf-8?B?MG1uckJGUVU5UUp5ZXJiVnFCbU1sTG5Bb1VaTTg4Nnd1TGNpMCt5SHVQM09B?=
 =?utf-8?B?RTlNZU5hVnI4K3V2dzd5ZldsenpNRXlrSWgyMGZIWWRaTjN6aXRKeGxQSVc1?=
 =?utf-8?B?ZE1mdGN6U1pFeTFWaFhZZlpESSs5N1U2VnlraGpxVGw4dFZUMXRBY0dOSXho?=
 =?utf-8?B?TmVhaGlnbFdaR2xvSEpHSGNKZEl5SmxNZThESy8xUXZhWEo1QTJtK0dWb1NE?=
 =?utf-8?B?emE2aHovaWR0MzdqOVdZNmZNcmo4MXNBUndsL3QySTRsVmRvcUFDeTdEMHpG?=
 =?utf-8?B?WXdKd0VWc013PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZTKzQ0SlNBbmQvODRNSlY1V2lzdkVpMzlLbHQyZm5vUEJ6UEtHeFlWdGFa?=
 =?utf-8?B?QjJNaTdCd1VSaFJZTlJrLzRmakk4OTFWOE01Qm54TlZkVmtmL1Z3ekt0THRk?=
 =?utf-8?B?ck1YeWF4Y0FOVDZkeUl6ZUYrbFVQaTNEeUo1OEk1aXVrMXA1T0YyclFPcS85?=
 =?utf-8?B?ZEg4dkFCaTBsS3g1b1RZUXhlTVF5eFVCK2JVV2xuMCt2WWtSRHhLQVEwbEl3?=
 =?utf-8?B?ZmFLTm9nZi90Qit6aSttQkZnZEdmd3R2RHBpUFpnWWF3amRmZkl6UGZKeDRS?=
 =?utf-8?B?WWNvZTFtaC9xWnFSTzdFYVNDMG1FMHZyaGJ2L254QmlDSjBHNGpSMDQybkRa?=
 =?utf-8?B?SEhpeXNpUGhPdEVKR2tkZ2FlWlBQSk1nay9ob0c3YlFVZ0x3R3NHQTVMRnpl?=
 =?utf-8?B?Z1hSR0FweXgrTk9XOFBKaitRZUxQWFlOWW90UDRvd1VyUGl2akUxYXhYUEgv?=
 =?utf-8?B?cTdVb0lPeWd4ZS9mTi9SSjVQZ0hEb2xTN1VPM1poZDZKSWZ3VWxHU0lYL09N?=
 =?utf-8?B?WUIzSDcwdFVSTzRkRHdmUFRUOE0wN3oyMWVaTnFXV2I0ZE1ySmo2dzBiVm90?=
 =?utf-8?B?Q094ZWxPYWNONjhXLzY1bDFGdysxRnE0WS9OT3RYb2syQkRNMFFETzBMUEtC?=
 =?utf-8?B?cS9aNm9zaXVnZDRkMFo4ZG5yS0VZcktJWnRJM2FIcUJ3WEFCaGxVdmdxOWdw?=
 =?utf-8?B?cUZ1OUpDU0doUHI1NmpFaFpZeGVKUXZTa2JpaE43UURCSkNjVWNlZndEdTc3?=
 =?utf-8?B?UUNJZDQvbTlpZEhsb0lSc1pDMUlsb0VIZGcxdTR4dEsxd0ZFV0s4UjByYytW?=
 =?utf-8?B?UmExSzU5V3RTTDQzVFR4UDIrWG1LK3prRU5vcU5BaWo1OGNqQThabEdUZ2tD?=
 =?utf-8?B?RG1aa09sa2IyczVSek56Z1ltT1VidkJ0TkxnZ2xQOXhmZDhBM0FCRmc3ZTlU?=
 =?utf-8?B?QzI1NnNzYU9OeWFzNC84TnlFbzlMVjJqUFo5eTRKV2x1eTU5VHI3SjRaQXVa?=
 =?utf-8?B?b2VsSGZkYll4cEJ0aTJManAwN1lDb00yNlVaRm1BUmZ5a2ptRm9hVlY2aU1Y?=
 =?utf-8?B?Wk1USUVhUzFzd3hQMHh2ZURGVUZpNnhhblZiZW9TUWt0U0VBQjFneHFWaEFH?=
 =?utf-8?B?TXNhVjMvZnBwRWFJYzNabVdaQVUvV0NWSTNLZGJVVDkvZjFaYngwdGhwT0Rj?=
 =?utf-8?B?SUZIRCtFcUYvL2V1b2grV0pXeTJLOXQ1eVhWcnZYZVZyWUI0YytkRmo3SXhq?=
 =?utf-8?B?SXhmN3I1YWVML3ZUbjdDWnRSTi9waExlK0pDMDZQVkt0TGNkeFZLT2w2S0ZK?=
 =?utf-8?B?RTJBYlVEMVNWUVNRZ0VJRzlNVnZhd0ZLbmNnZzEzOVhScGNLQ1E3SzFZakpn?=
 =?utf-8?B?VGcrVzZhcWxHV3R4QWJ1NVdPa3luVGN1b0F1MVR6aXB5dzRrVGJVTG5yaHRI?=
 =?utf-8?B?RFdKZkNDWGl5ZHFjQldSRGNQbE5UZjJLUnFKRW9pMzN1emhJTEM3UGliMHFS?=
 =?utf-8?B?NForS3ZMazZrYzM3MFBTY0dqdGFRSXFLdXhlc3RpYVphVFlqSnlaTjd0YUt1?=
 =?utf-8?B?QVFyWis4a0Z6b3ZQSStIdDN2cStYRmgzYkhTeWtWZEt1b29DWFBtakVsbVVp?=
 =?utf-8?B?WGJ0eSt3UEdubUxRK29BQit2Y0JhQTNmMlVoWUJMRkFMS1pMcVBxdm1FSWRH?=
 =?utf-8?B?WkMxWFlERTRWN0ZjUUI4SUNTVjJCVnc1RC8yQVM0aGIwcmNsUGc2SzdiMngr?=
 =?utf-8?B?bHMwZ0Ivc04wQ2FPeVhqamVyMUU4YVBOVTRlSEg4TTFQQXk0WVJrUFE5Z09o?=
 =?utf-8?B?Tm5FbjZxVkMzZDJidEQ5d0xiYkFrSXRxMEkwRzJ1bi9NMEtJMnVzWEUxR0hL?=
 =?utf-8?B?UTREQ0dScU1pa0ZiYVBWTXRuVlhuSWM1b0dDYmtWRE5Nekw4L2VoZFBKdFFz?=
 =?utf-8?B?NnA2L2VWSjBPWFdyQXlTYllJdXBUb3FZTkdkY1RXS2tKbWFIZkw4VGpUUGQw?=
 =?utf-8?B?OE04T2d3SFJXK1hQeisxeFNMbVVIQVJSckJGanZiQ2xJN3JUUmZhZXRHZDVO?=
 =?utf-8?B?SUx4MmhjanREN0FhWHVramE4VlJsbUlLdHJ0VkNiSDVZVzJaeCsrZU4yZ25G?=
 =?utf-8?Q?tgvUxildAdVzyfBxh7V1xJAW3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13d6523-7b52-4b48-1ba2-08ddfc7873b8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:02.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+50houxX4OWTh6oBKVud3dG6rJCcAAfrFo0vrNoo+6p0Uwy86cBLWQZFwl6wjeatWj7VFHtIrDicYJ/ce0i2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Trivial change to clean up some DTB warnings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (11):
      ARM: dts: imx6: rename stmpgpio to gpio
      ARM: dts: imx6: rename touch-thermal0 to touch-0-thermal
      ARM: dts: imx6: rename m95m02 to eeprom
      ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
      ARM: dts: imx6: remove gpio suffix for regulator
      ARM: dts: imx6: change voltage-divider's io-channel-cells to 1
      ARM: dts: imx6: remove pinctrl-name if pinctrl-0 doesn't exist
      ARM: dts: imx6-tbs2910: rename ir_recv to ir
      ARM: dts: imx6q-utilite-pro: add missing required property for pci
      ARM: dts: imx6ull-phytec-tauri: remove extra space before jedec,spi-nor
      ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux to i2c

 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts          |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts          |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts          | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts      | 10 ++++++++--
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts              |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts        |  2 --
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts          |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts      |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi        |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts   |  1 -
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi            |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi          | 12 +++++++++---
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi  |  2 +-
 16 files changed, 42 insertions(+), 30 deletions(-)
---
base-commit: 4cf7dfd6c51e0292521a92eabcf687c8b82f8df2
change-id: 20250925-imx6_dts_cleanup-6edf53e09c62

Best regards,
--
Frank Li <Frank.Li@nxp.com>


