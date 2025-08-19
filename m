Return-Path: <linux-kernel+bounces-774767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF08B2B72A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0595C7A8592
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38945287274;
	Tue, 19 Aug 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="exFV632q"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365E1DF24F;
	Tue, 19 Aug 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571472; cv=fail; b=laesyHoWuDokJQScum/zycEsA/4aLekKHWHKuqNLJGiEAidzHKU2WqGDmxqE0CmSyRsPKpot9x/aWOKNgdKaXEnDHq1jqcSQOZAGwz28RvtZ53H5tdpgFlVC/5KnJRcwRBEGI9g3loDaW802Yl2/koz0BTK3i+/Y364yABQpzNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571472; c=relaxed/simple;
	bh=4KEaenTgp5Q4DcMA1B5h9RCFCH0FVk83wkg92Z/nT5k=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=nfAkdrLxBCcCSSl9/LjIStKX5/7q6NtMUZgiUGud2niv4Z7DVKQuAZUz11VZtKELLmrOe3l1dN2mOUzCfy+sqcfaYzLGg8DWLVIxCtzcHKpxTZqtzsrW/iTmLAGzQL2hIQ5KCejvOBDPOZ0Rq6d2ANaY+bCRcHrfaGS1+9IyvNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=exFV632q; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag4Cj9m9fdASZE0/DEiM718c9JWfzqDh9W2NrZb0ErrvpNEi03c9En42nzPSoZa732mA8fsTzOyhXY+u7ROZDBPqn4dyfN0UtfsN5Kljq2bLGnJNEuKbHavPNU9DYzfZ0RL6BLqI5kqIda9DJyPTE07YHK8SIQkd92j5mVgAZDV+08RCc9xI4yq/gNq4Zv2wOYAE9qhCIFq6DF6rXL2q8AyqyzC/1Mt11EFZVDTeqWDeCtFGGFtS2DTBlz0AYGHTHgqVzF5WSMyMvoI3iIZBIoLgPAHt+rkgO4d9MkMVldqLW1XNbokQUQ8QOV+9PX95CUVLyAHNMyC2zH1acpimww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgk5QBe6f5+F6fgwEEnnU1EWp0uUfrXZglnNnJf7E2k=;
 b=DGtzaJaA8FCMCQJQvy1JFHFlex8we7tZEEKOg90cSxHsUdkSRGJ6xOETNJ4kYNv+lQXcP70zb+JfOvI3utgYVi9xBjtzcdbS1ABq1dPiin8uDJVbSwB6Uc6kQaLiex+C4lyAB3tCHNyF5vi4VrEBYliVS2oZkzJxSWHIOoD4XIdQKDI3Dp4GYP/ZuVwf8EN+1wIpsOk5Nb3zfR/TriEcndDKOajtbXNoollDz7H9Zt4x6ceOgxuz9+EG7ZvC+nSMQCB7ToZJiG9wjo8iKiaGVztxe4PbzxkgJxjRIYM6HT7vzVs5ma2uD+paoEc/V3uAeOJuLuAEIJVd0KRpXtuGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgk5QBe6f5+F6fgwEEnnU1EWp0uUfrXZglnNnJf7E2k=;
 b=exFV632qIamdC/sr+np4YQRmlwCQ1q4a85AthbKfuUi+1uHJEn1IGNxryR6wIxfkPQ0Dk577kkEgzkudgWkjich1H/PIfY1pd1Bter/u/3C4Kz3VBzjp2TMHsbcl/CFaa4JygUmZdoj6syFttcHDM4QZb3QG9mkfV96gs4qZwfZfCz2IOqagUm3dqm+WQttbCuHTnfU+n32Wul/OfhYn27yo4rFKrIGUStDDzWmNNjJTTZ0Lav4fgrjWS8mQaRLqpmjl04FGgUD3R2tniGyRK7ql8q7gLbeSxze9NWBtVq0ueVFDydFWq/YbSU44eJs6d7ANV/zB4W/6YR3sPsTmiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9885.eurprd04.prod.outlook.com (2603:10a6:102:391::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 02:44:26 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 02:44:26 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 19 Aug 2025 10:43:37 +0800
Subject: [PATCH] arm64: dts: imx95-19x19-evk: correct the phy setting for
 flexcan1/2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-can-dts-fix-v1-1-e43e7d98a544@nxp.com>
X-B4-Tracking: v=1; b=H4sIANjko2gC/x2MSQqAMAwAv1JyNpAWXL8iHkobNZcqjYgg/bvF4
 wzMvKCchRUm80LmW1SOVME2BsLu08YosTI4ci0NdsTgE8ZLcZUHO+eDjeQCUQ+1ODNX/d/mpZQ
 PR+Wwgl0AAAA=
X-Change-ID: 20250819-can-dts-fix-62ac1d02c007
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755571460; l=1826;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=4KEaenTgp5Q4DcMA1B5h9RCFCH0FVk83wkg92Z/nT5k=;
 b=o2OPELMnL6YOQxQ4fRI9eiZqUlcjqsX5AexiBjbazbb+mul0fNQzuIasKqYCp3Rr4dsWm4cX9
 GMSyZ/yy+PHAG6PRImBJ5uFI21GW1jqspIa14ENWK65MU9Yrok4cE+o
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9885:EE_
X-MS-Office365-Filtering-Correlation-Id: def3fd08-9db0-4637-ab29-08dddeca4fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjhuM3c3UExKWUxRZXVwREN5RFBqK1dOWUh0NkRLOHpSMzZhTExhTE1XODl0?=
 =?utf-8?B?M28yRHkreXo1T0JwcmlkdDQwbTZoSWpxNERZTHhLSnFkRkpzY28yd3dLTk8v?=
 =?utf-8?B?ZEQxNGN0VjNoNEtBQkhwSkRQSUREaXhNdmprVEV4NnVpckw2bjg5cGZ3REZY?=
 =?utf-8?B?NXlZVlRkeXVqVmtwN3AwdmlNMEVRSDVQVmVzY01iY2NVeHNhdm1tV1dYZlVL?=
 =?utf-8?B?eWJjL1pwaUhHNXpjZW44OE9aZjZtRzdYeDhxbytiYW1vNm5DSmVZbThiSFht?=
 =?utf-8?B?bVFBSFhaMFhybWF0UDFuOU1GMWp6cjkrcnV3cG9vWHptL0JpNnptL2c1cHV2?=
 =?utf-8?B?ZCtYa005UW5MTm9yVVdGNWZFSG4vMmlrUTFzcWRjMnk3RE1FL2IwNnBPVEdE?=
 =?utf-8?B?K2FjMEphYW5WUVBwclJ1SllybW1VMnkrSWREdnAwK0EzMFNKbFNYaS9VLzVK?=
 =?utf-8?B?SEk5OEs1b1NMM2orYk1tQm9ETHBaK21uYnFVcTlqZEdBbnhWSVd6UG8wbW1X?=
 =?utf-8?B?UG1XVkVYd3lJUkgwY2E0OWdQenVtYW56QVdmUFViS0VVUXpSSFNiaFZKQWFk?=
 =?utf-8?B?SDgxNlNzamhkV3FsSVZJTWc0OURXaGU3YW96WldhZzdRRWRKc1pLRG9Qd1VR?=
 =?utf-8?B?MnQxTjBYcFI5V1M4RkVUY1hyZG1NVVRPd1RzVHBEUFV5QUZnQjlYWXZTN3pY?=
 =?utf-8?B?VE03bnBPMFBhOWNrdnhSY1BVblFYemVTUTh0ZzZTWjI1Q09oRU1nNWJibGJK?=
 =?utf-8?B?ems1bkdWN1VVazhoRGUydzFEV2tBcFd5L1Buck1sSjNIenNzZHRMVXRaTmlR?=
 =?utf-8?B?dTBuK21SN3NhblVPSW1Ob2hna0ZDZnFZWCt5dUVoTjRnU29pOUdnRkg5eDRl?=
 =?utf-8?B?SEJEVEl0aGZ3WUE2WEhiR0ZKYWQ4K01ydkdFODlBUk9kZ3V2L3VldklKQzM1?=
 =?utf-8?B?VXVwYWxWYkhUb3p0b2JCMUgxRE1iVDVtQ3NJNi9wdnlITUN4TzZnZDlHQWVF?=
 =?utf-8?B?UXc4M1NwS3o4czVzMUlDRnYvZGM4R25rSGNXTW1hUHoyTVc1VXZ0NXBpVzlw?=
 =?utf-8?B?bXRUd2U0SkJQc1VyQ01UV0ZYNFZUaFdjSERtemNIK3JEZ1lPU01EeVJhRWxD?=
 =?utf-8?B?Q0tmY0pTLzJWcmJMSzBDRHhvVHgwM0c4MnVhZUJ2SkVhK0haK29PU3huN0Y5?=
 =?utf-8?B?dk53TkJ5Qi9NOTNYeEovU2VBcysycDZvbWF3MnZRQ3ZSei9vMkg4cXdmYjlr?=
 =?utf-8?B?QXdoZzR2ZXV6NEVnQTlpYndxTDcxWlF6U0N5N1J2MWgrbDNXTGFnUnpCOGFH?=
 =?utf-8?B?czVwR01YVGtFTHJublVTU3BaQVR0ZVpjRzNyem0rOXUyNy9pSmt1MWwvalBO?=
 =?utf-8?B?ekdhMHVMTGJTeG42MThlczRIeGI5Z1NwSEo4djQzcnJRVEZmbkNzTEt2YlVE?=
 =?utf-8?B?WEtiUEJRK0ZZY0FIZ0paU3ByeHl2dzkzUHVENmI1WERvWTJINnNXMDQ5NUJz?=
 =?utf-8?B?QmgralNIa1RUblBWYnA4c1RLcmc5aGk1UDFlWkhYNjBNNW9Sc3pvQk96eHdG?=
 =?utf-8?B?c0hsY2lVSmdhRzlnUDZaVlpWbTJxdEl3VkdCRzluSDk4SnducXY3a0VYenk0?=
 =?utf-8?B?Q0hnVXJNYnYyVHUxY24xSDFlL0hGVGROWHZ3OHFMOWVVdlRIVEptMU5YcFF4?=
 =?utf-8?B?OTZWRU1xMVBxbUlSNm5Ud2hBNGVzWWVKQmE3RUwvQWxvZ0pJVjkxZGtKNE5j?=
 =?utf-8?B?ak1FS1M5aXlaRXRTYWlpRktzVnhOMEtiYnJMSmc2eDhlSTkxS0NzaU9VNFhR?=
 =?utf-8?B?WGl5MnhEQ1lsckNlampzTVlTd0szYklpWU5IV3FWbGNkUkQ5eFlEaThIV1Z0?=
 =?utf-8?B?V3JTdHlwWmJ5MXNmcEhLbVRWMU5Na0RRaE5YNkljaFpaNlBaTjhCRVJENm1K?=
 =?utf-8?B?MzliaXlobG15RlBmenIzNS94TXVtdlB0d3hIYVFidjFERmV0MitSaGF6ZHVP?=
 =?utf-8?Q?mDRLkDwIbzz9Yu+9bZ04SvzMvxaT7U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVkMzRYMzlrSnZkcmF3SGEvVFAweU1QVk9xZWs0OGQ3OWJDdGVxK3d5S1JP?=
 =?utf-8?B?ZS9aWkdOTXI4Ly84UEpTcGc0OE9Jb1cwVTFhQis1VEtVZEdhKy95ekJxUXhm?=
 =?utf-8?B?cnFyZWRWbG9Fb0JsTk9Sa1JzT3duclFYQXN1UHMxanIvNDdGYWpMWkV4R3N3?=
 =?utf-8?B?TFRPalBXWFBCcEs5c1BxcmlOd2V3K0NEZ2MvWHNuMmUzNXVzWWc5aVNQYnlC?=
 =?utf-8?B?VXRpaDh4dE1zTHB5NkNhbWZjV05tUVl0Nzk4VGtTM2o5Wll2c2dvSGJTWXRH?=
 =?utf-8?B?c25HNTMxcWFMZFRocVdVRnNYSmc5ZURMREdHRGlyOEZST2VxTWJBQ1ZKWTVS?=
 =?utf-8?B?RkkxTVRmMnJqcUVUOGNHRG1kKzBMRStwbGwxUmR0ZmRxQkpmR0pqY2dPYTVy?=
 =?utf-8?B?K0U5SnFtR1YzZDMxR0dBVjQ0bFcwWnZKZUtmQll1ZWF5WXo2TTZQMlVtcFlq?=
 =?utf-8?B?WlZ6SjBNNWlZekVvQTRxNWl6d1R2aWhmcS9hLy9jL1lSalc0S0FuQkozdjRR?=
 =?utf-8?B?aU5HS1VhSEdHNWNkUmx0dHZ4dno3YjFLeG02eXFoZVR0MFM3RVVuYVdEVWJK?=
 =?utf-8?B?T2VZZW1SZGtYc2RERSt2MjNwQTNnT1RTNUFwTVRuWVYwVUlocCtQRElmaEVv?=
 =?utf-8?B?SjVEemtndnlhWWpOekhjUzFXTEpJbkZ1RDBlWFl6ek9Da0dEbUVwNEpQa0d0?=
 =?utf-8?B?M0lsZ241RmZmUGROWEYvNHY2K1c0L3dDSTR5Q2FGM0tqdTNmYzZJOUxGNWpS?=
 =?utf-8?B?dEZTVklvbkliVndzWWJTZUpPQk5iMVBxT2RKSUU2SEN6R2RLMGk2VER6MTlQ?=
 =?utf-8?B?WmlqeXhLbXNDNkJHQ0N5MjJOV2RVaEtSQmp4SmF0ZXBMRGpEdDU5SFlwL0l4?=
 =?utf-8?B?UU44Zm5qVmozanZWVy9ZYTlJQ3AweFlRR2tZS0FxR0ViVkZndU1wNmVZV2tI?=
 =?utf-8?B?ZjU3UWl0c25xdngzZm9FakRWMEp5R2hyZ0d3NVJGVjJYc2wydzg2Z3dYMTgr?=
 =?utf-8?B?MmtaVUVnYmIvbk9VRmhWZ2J6dFUwMkF0Z1Fpc3BmVmJPQzVkWUpEb09adWgz?=
 =?utf-8?B?bkRzMnZSTEMvMnR6WVNKOS8xTnlpeEZIWXlqM3FKWHhQUWtLR1Z5SHk0M21L?=
 =?utf-8?B?WWZuQ254dU5PQ0oxL04zVjZqczhobkM2TDE5VzU5SlZ5NW9IYW1oRHRsdUhj?=
 =?utf-8?B?VnhycnJZd1RsRm1VQWNoVGNiMWpsWCtudHorbEw1RHJnTjZrRk94eUpCc1Qz?=
 =?utf-8?B?WEd2eG9zVklxalNWVHhSaDFKWndWVmFMbWZBelQyM0lEeS9Pb050UThtV3Y3?=
 =?utf-8?B?ckF1UzUvQXhyaGMwTTQxc1M5ZTVZVE84eGphckt5S3F6a1Rhbk5YUlMzVWp4?=
 =?utf-8?B?b3VuMGVHZGRKNVJDblZVbmRyVnZ4VHJsSlJMdVI3RzFpTHl6bFR4WitNWStu?=
 =?utf-8?B?WlZTd3lmNHdPL0hlVUp3SkhLM0VWM1VUNkRhWnU0REtiSExuY05VWnFnVjdj?=
 =?utf-8?B?OUUzTnYxdkp0a3lvc0J4cGJkOHRzVmR1MExrTy9tRHhSOEVWR3I2alpZQXhZ?=
 =?utf-8?B?anlJQTlmMmFuTGlkT29rRWhHb2crakRuVHh3dC80MFFQa1BxTCtsV09DVkVy?=
 =?utf-8?B?cENNak13TW55K1R6c3puSWRRL3I5K3I2a3hLYm1xVm9YVitLU0FXTHZSQzJI?=
 =?utf-8?B?K25ocVVLR1hxMmdpMWxMSFB5ZFpZZEhvRDRvaCtHMW83dmh2c0NUMFJYTVJz?=
 =?utf-8?B?NnBCbDhhN3hMNzk5VTJKdWNSbFlTMzhsbkk5bWp4TkRJMldET3hFMWs0eUJR?=
 =?utf-8?B?STdaeGd5MEZqSVkwVkwvbTQzWk1XQkYyalUrVG1WcWxOSHBVSVR2MWczN01V?=
 =?utf-8?B?anF6VlJ1UzhEajRJeEZOTE12WFZnNlVWTUsySGRONGZ4R1lkbnloaTZYWnkw?=
 =?utf-8?B?UjNhUWczV0FGUXR5aWdvcktrRWV6cllKckNxaU1rQ0lrZzZKbnpZd1h2TExZ?=
 =?utf-8?B?SG1rdDBMWWY2ZVpCWEQ1YWxnNStGVEh4WUlpZ1lseDRQYUpHbHA5dlRtKzlh?=
 =?utf-8?B?aCt4UHYzelo1U1VrcGp4KytzdXBMK3V5Y0VxbzM1bzZMQ0ZWVEdCOG5UVy9i?=
 =?utf-8?Q?PLLvOAj/8C+07DZ5fm39dk1fB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def3fd08-9db0-4637-ab29-08dddeca4fd2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 02:44:26.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siGreJ5cf03woZlbk5V0nXev7kmmnWZ2ZrRfZF65QJMD3ciPparSqEuAEErMEk+rznmmJgZOQuAa8ZemTcIVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9885

1, the phy support up to 8Mbit/s databitrate for CAN FD.
   refer to product data sheet:
     https://www.nxp.com/docs/en/data-sheet/TJA1463.pdf
2, the standby pin of the phy is ACTIVE_LOW.
3, the phy of flexcan2 connect the standby/en pin to PCAL6408 on i2c4 bus.

Fixes: 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0 flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 2f949a0d48d2d8066388884703c3b3cd678f16e1..9d034275c847606919af8ee4a80a00599abf4d8b 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -80,17 +80,17 @@ linux_cma: linux,cma {
 	flexcan1_phy: can-phy0 {
 		compatible = "nxp,tjr1443";
 		#phy-cells = <0>;
-		max-bitrate = <1000000>;
+		max-bitrate = <8000000>;
 		enable-gpios = <&i2c6_pcal6416 6 GPIO_ACTIVE_HIGH>;
-		standby-gpios = <&i2c6_pcal6416 5 GPIO_ACTIVE_HIGH>;
+		standby-gpios = <&i2c6_pcal6416 5 GPIO_ACTIVE_LOW>;
 	};
 
 	flexcan2_phy: can-phy1 {
 		compatible = "nxp,tjr1443";
 		#phy-cells = <0>;
-		max-bitrate = <1000000>;
-		enable-gpios = <&i2c6_pcal6416 4 GPIO_ACTIVE_HIGH>;
-		standby-gpios = <&i2c6_pcal6416 3 GPIO_ACTIVE_HIGH>;
+		max-bitrate = <8000000>;
+		enable-gpios = <&i2c4_gpio_expander_21 4 GPIO_ACTIVE_HIGH>;
+		standby-gpios = <&i2c4_gpio_expander_21 3 GPIO_ACTIVE_LOW>;
 	};
 
 	reg_vref_1v8: regulator-1p8v {

---
base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
change-id: 20250819-can-dts-fix-62ac1d02c007

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


