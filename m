Return-Path: <linux-kernel+bounces-882621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D80C2AEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65E31348DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7332FD662;
	Mon,  3 Nov 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/v+M4ax"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E142FC00C;
	Mon,  3 Nov 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164497; cv=fail; b=lXJKMwUehjCFq0avZuuiFi7AUh6fcqZDm1oW2E5IqC99n1dQ9Se1LFayZ22asFKTsc6aJ4yFgc/E3w7heSV3JxayvV86eQnhOiGKTlsOmDRFDbQI7nqHjDLOZCcu8Tpd8Mt7Jgso5LjL/SiBHYDelEVJKevcRJXxfY1Zl6XGdKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164497; c=relaxed/simple;
	bh=DJTvgoshGuMomu/7k2xNBQFUIDko3PuQPfk22nzJ6KQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MEjJENr1RnpAe7plNy/priem7drkzZuuIV3dTm2hbcE/3kiSEPoKAhGJ4+PqFWwqv8dQ9214tdvgJ5vnGzGy9CZJfZ+V1oD/EKTT0BjmdSBOo9SkiQc40ESEIYAG91nWWpCKMoDACDLb6Q0aI68VB6SaKS6X3iitmAEqQBtAg/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J/v+M4ax; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU8WetroJjE4R00GVuGMRGENAYBj7KrI2KM8m88aqk08qDPNOuiPYMQgULGcb4QAS8C8INEneo2iK/Dm88f/alqwxxp3Ud1inSQ1sNpiXiO5AoY+08LpNLTQcKARNOWEVTrwXIdSPmFBGkvkSQeEbidunn9J1J4a0Q9Nitz3VVRcxMAUOy53xf7Nyk/fSxo3gKmhNebsRrx/ltpMEWunXLgHWaATa2QX/Kknn6f29Q8p+4ntP/lccfNxvI6pzPo2mGj/radyxligaXTymCalFGW6hYrEVRzbszK7NzT/99dkgKJPP0nyxKU9DE7iJvQn5bVvk+d3/P7lpqlh5pkJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsJaCdNT+EdUmKQmalX9OVP3XRIe2XxrY2DQwRvMPmk=;
 b=PtyWneBu8AXX9haz3RUXtpN3qYlJXQfgkAJU6wUAhPGB39TZ3gRnifqARgMffL4Y/igUPEcH6T9UwCEkAl3jkXVPqujETrpTBcXU0AifTVyg0kkedZwguaDreeoMmWgcRm6dgkbyOUonKb/kB5L2dIYrjDpGHIT6ENjuRFoCCraoGD6VfW8E0D53O/wDdiM4uUtuSlIoMR83OlRQL1F0zNbx2etKNpMF6cYpltEtVpHBCV/6DeWrY50y8bdEhtEx1aZji1yS3cb1yH6gTks1qD9AGK0kgvDOV0KjL/RBiRS3X64bOVPPXDWVMNyUhYOI2KWT+20bbR8tmkXamUAouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsJaCdNT+EdUmKQmalX9OVP3XRIe2XxrY2DQwRvMPmk=;
 b=J/v+M4axguK2/R7EXlrWdb25sEa6ZbBLOt37v3duB83OCyYJ7YfRVQ3MyU3D+8whuNMwV6/jOA5vE6NYHfpUM4PfMOjdtfTg29sFdl3KulFXqLrxTe9mjkoHTtsccvx/g28bBwGE/485d+jlB0MQNU0dQv3SQpDH6YdTsnTORv4rD9Btvp6vPfNE1rA4uQRa2YXCtQZi3Zkgj40UhePFmMX1DBR1h9ZMtV6eiZnKUq9Wg4fRZwikm0+KvCJPMguCo4uidcfK71bMfbuI1+rOU8ErDI1RJib6e3hm/OLXFPB/+CSuHVHBqq5YZ0+A9B9TlF9Dac6wp+nP7GGBgvG0FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DU4PR04MB11077.eurprd04.prod.outlook.com (2603:10a6:10:58a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 10:08:11 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:08:11 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 03 Nov 2025 18:08:33 +0800
Subject: [PATCH v3 2/4] dt-bindings: clock: nxp,imx95-blk-ctl: add support
 for USB in HSIO Block Control
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-usb-phy-alt-clk-support-v3-2-18b8bd4f01b0@nxp.com>
References: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
In-Reply-To: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
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
 Conor Dooley <conor.dooley@microchip.com>, Frank Li <Frank.Li@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762164524; l=1076;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=DJTvgoshGuMomu/7k2xNBQFUIDko3PuQPfk22nzJ6KQ=;
 b=O02x03W5kK/Y19K6BXxz6gxo11H9Nk/aoKc163smsyma8hd5jElIHCbCGOo2UDIxmuKbPA0OB
 eeBo4Fi+KBtBZej0S2XSN9KqlhBl3514EQKKv0jbeLMwoplzLgdKSfM
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DU4PR04MB11077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1a2060-da66-4d8b-2eb5-08de1ac0e515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGdJM0xkWnkvSVloMHFGM2s5a2t4RWFFM2l2T0RxYXlPZC8yL0dsRTdCMlRZ?=
 =?utf-8?B?NUpYLzcreW1KU3l2RC96Ny9qNXFXa3hBUHJKSGRqSlo3YzBhbmh2aWlyMDZl?=
 =?utf-8?B?VzdJOThoTGZnTVNHRnlFRzRHUFduNzNFTTBHaG9DQ0swZ3lPYXI1SzBaMlU4?=
 =?utf-8?B?WDF2aG4rTEFMU0FUMms1OFp2NlhidVpGYkg0Tm45V0RDeVpqQzRpWWlCWDlk?=
 =?utf-8?B?OGUrR0hNRDBpSXJoVGlYdVhWL1lESU9BMkY4N1kycE1kZGpTZFJCb2lOZnlV?=
 =?utf-8?B?SVNob0IwR2JOQ3cwYkREbFZLN0hNQkIzOWgrKzF0OFllakpVZVFKVm54ODhM?=
 =?utf-8?B?TWxSNWxUUXl4cGFmS2w5V1RleWlEaXRONUZPWmtWZElWQjY3UXZleklUa1hm?=
 =?utf-8?B?TWUvZ0ZNTk1YaWN0VWpDcnlpSlJ3ODB3MW90WE5ISS9Oc1ZmTDd1dmZLWUVo?=
 =?utf-8?B?aDJ3SUlsaDRpT2lFOG9TTldMblYyVVhzUDVNdFRrdW55YkkwZ01WQkxRTzk0?=
 =?utf-8?B?a0cyZ2NQcE9VVW5iellyRm9xMjh1NThpS2F0ZzV1Si9pMVoxZkJaUmtQVHJr?=
 =?utf-8?B?VDZ6NkU3R1V2UFY2anZSMEhFdlV3dGdhUDJGZTV5Q3ZBcGY3OC83UVhORTVL?=
 =?utf-8?B?ZEtOaER0TnBBd1grdllJZHZmUVRKbUtQUGxCQ0xNVjh5bXRJMjBDdnMxQTF5?=
 =?utf-8?B?NTBya0MyTThTN01nckx6U1dId20zOEdDZ2ZKUDl4dUgrNkh6NnE1V28zM01W?=
 =?utf-8?B?UVZoZGhmNFNxMXRXS3Fmd0EwL0xTMGxIeUt0OGRCcVFyYWZONlliNXdjbzRX?=
 =?utf-8?B?WGNsTEJQdWZWY0FYTkN4R2ZKRVdQZVhPbThOL3pScnNHcjRwaUgwTlgyOTdX?=
 =?utf-8?B?RWs4Nmc5d3hWMlV5dnF0NnArcmg0VTJ2a2xXRXlkV2pJVGdKMEhmVXA2aVUx?=
 =?utf-8?B?dEtuKzJFa20ybTZob25MZkN3amNGc052RVNKWnl1ditQVXZIZlBsb2pGRWxo?=
 =?utf-8?B?QXVOTFEzajZLYXdTZVVkUldiaUtJRVRpWEVVZGthSGdsOE9zMzVQSFhDOHEr?=
 =?utf-8?B?b3BoR2p4ekdZbE5HbXN4YnF3akYySFh3RTVsOTJ4TnE1RkNNQWV1R29xejgr?=
 =?utf-8?B?VklhN2lJRllhcUt5eDV6aE9GM2hhQ01Za3FwVk55Y0dTM1d6bjZKSkZDbzFq?=
 =?utf-8?B?V1NJViszV1ltT2ltL3RiaVAvbjVaYS9WNXZtbzZMS2J6YkVJc05aKzdOQlM5?=
 =?utf-8?B?bEJOTG51dWl0di9aY0tTcDQrcENKNEZvbFV3bEdqMG5XNHNFVG9qVmtVOUhw?=
 =?utf-8?B?Y2ljakVZRzIzaFNrc1c2OXN5eHJlN3JXTkU1TTF4VkIwdTRVSnc1NnhoYkxs?=
 =?utf-8?B?RzlQclhncjRFL3BqMThBNUg5ejMzd2hlY1VtZG5CMDRhSStZNzIrSW83cnJF?=
 =?utf-8?B?R1d4SEc2Q3ZqMkc3U29LL280R21RSnZDUC9BMi9xbCtTVGxEYjIrR2doU2VZ?=
 =?utf-8?B?eG5FYzhjdXZ1RFRhNTlES1BPOU0vT3FMemM2ZTJkYWY5bDI3dFNNS05WbXU2?=
 =?utf-8?B?VmdudW9uZTBiRi9jRTZWcndDdlNHcjYreVplVjVncHRIcEVEMWgwUmZQRVRY?=
 =?utf-8?B?UEVBTnBCT1Q1ckJzdXhDQTNiYzYyVjJ0SVNJV2ZHQzV2S3ZlNnBkWDlzVWt6?=
 =?utf-8?B?T0xNWGRUS1Z6Mk1LZ2oxbjdOVlcyVmdob1VsWUw3QXgzSnFQKzEzSml3Mjlv?=
 =?utf-8?B?N1BkajNCYWwydjNjL2VINW9UQ3c3Uk55TkNESE1qb29HeGw5c2U2NmpMNk5T?=
 =?utf-8?B?KzhHWWZUWGdtTmVJZWcxS05UbGozN0p0NWcwYlN0Z1J3cFhKZzBzZWRmRG0v?=
 =?utf-8?B?TVVJWXVPS3lEaHd6RXBZV3NoWXVIVW8xNWxsRXNVb0ZIMjFqclRka29qYmxO?=
 =?utf-8?B?NnZJQ055RnZHVDR5YUowUUV6bVN4b0NyRVR1MU9QMExna0FzWGtEWHQ1SURU?=
 =?utf-8?B?cGNLZ09NN1hYdDVhUm5mSnVYWTdtczFpZk02T1U4K3F6TlJ3UTQ1RUljMjNP?=
 =?utf-8?B?TVZPc2VHdURtNVVPdUhGdUlYQ2FmUi9IbCtyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2w5amQ5Nk43OGtBMVNiQ1J1dy9Ob24xZ2YxNE9nUnkrZzhIR1ArSncwdlJV?=
 =?utf-8?B?MThISHpLcitQN0dQK0lzcWVVUDVJdjBjcy9LanpnWnhyWkxRdnBwZ3BSQXpU?=
 =?utf-8?B?ZE5FOG10K2tQQmVmUnFTZXJPZ3NteWloV0I2MkN6RTdhdy9XZFRkeVNScjQ1?=
 =?utf-8?B?WEdvaUUzZStJWmRGb3ZGQ0JxM0JxWllrYjY3YWkwRFRteTJlZ2htR2YrNXB4?=
 =?utf-8?B?WjR1VlJXRVpDOUNOQ29mOUkyRmRYd08vMnhFWlQzTXk4UDU0aG1yM3BvalN4?=
 =?utf-8?B?b21Xa3dFUTBzWFBFTnVkTS9rZkU1TlJVMDJ3amVPSHNjdEVFNEZBclBGenhB?=
 =?utf-8?B?TUVQRTlOdVM3TlhWMnlwaXVucnZsWW9FdWlQdHJiQjltTXFQMFMvTHYyeER3?=
 =?utf-8?B?dGR4NU0xRFUwYTd4ZUx4SnpFclFPTzU3YTRTcUhWMEMrNjk2Y2Z5bFhXaDJS?=
 =?utf-8?B?S0lPbG9ETEczZHJrM0o3TVNvTjB0bjQwbnY4RDF4Qmpzczg2dEZzMW1yUkxL?=
 =?utf-8?B?UFVCRG14cjEzWGhxVWprZE4yYVpDUzZ3SkRhYlM1ckwxK1BwZzFDRDZSeUEz?=
 =?utf-8?B?YXNyWUw3ZVo5UnlCTjdEeC83b1lCczhWUmkvWFRFSkJIVk5meWtsVmo4Wm5k?=
 =?utf-8?B?NTVMeng0ek1BbVJ3cllVak1hZkFSckFKUXpXcW5PTzBrU2hRbm1EWG45U2Qx?=
 =?utf-8?B?VHd2RWFZeEVUTEtqOEs0YnhwdmpRT3pibFNrUG0xaWxtUWNPQUZpMUpVVHVt?=
 =?utf-8?B?SXI5alV5djdIc1J5MFpkVlcranZXUTNESFBNQUxnOU9zcEovQnpHOUtvanU4?=
 =?utf-8?B?a1lrMkN1Q2hsMUhlWnNhSno4RHJsekhyaWdlMHA1eE1KWmphaHJndjNONTd4?=
 =?utf-8?B?cjZ2WFpPb3hwM3hHUGFrTzBhWmZXMGFzR2hDRXBjbFVteGo0bGdBVnZhZVdX?=
 =?utf-8?B?c1UzRStxcldMdUpEMHI3aCsvakZTY2dqOFhUUDY1UXJkZnRjL0l2T3BvQ2dE?=
 =?utf-8?B?TzNiZ3BadDhXelo4b1VFK3J2Q0pJZXhya3I2U1BWMDNYSXdicVZLQzZ0YWFi?=
 =?utf-8?B?b2ZIaUkxQVd0RjJoMTFnQmdBVzJxZFZ0a2V0bVRRaHdwYjA1M3FDMzh6elZS?=
 =?utf-8?B?TkYxZ1l0bG5RNitqNTEvMHFLbndVSWxJck9WSXdQWEVwN1NaSHNZZkpHYVRU?=
 =?utf-8?B?a0d0VGtMREdmSWlhOEV1Qkg0Vy9pSnVtYzJPbmQ4amhwcEllV0NWYnE4dTlY?=
 =?utf-8?B?eW83eENtRndJSkV5Y3NhaERweEtuU2VtSVNoZ2JEeWN4V2o0YkdtRzdFaFZP?=
 =?utf-8?B?Um5GZXB6Y3kyYzFuNm1KQU9LYXRKQzNvUHRSWTFya3NpK2pVT0FSVFk2cXd2?=
 =?utf-8?B?MDY2eUNlTitDL1NMODVKWkxvbVVkeG9hSVQvQkM2QkZwSWNQN09iMXJnRm94?=
 =?utf-8?B?VW9tOTd3aEs2Z1NNbXVQYUNHT0NJdEdZamdRdTVvc21yT3hSTUFDRzRRU2E1?=
 =?utf-8?B?dmlpU1pXZm14SSs5WEV1aFU2UXNZUFpEc2JveXlpWU5jYkZmZzlub0R1RGph?=
 =?utf-8?B?UmQzeTdwdlRzUWNFYXUzejd3Z1FCNEF6STVnSEZIZ1ZzNG92WGtjb3h5SnBj?=
 =?utf-8?B?Tmk2SHFhRHZGc2o4SFV6M0JhRDFhTzc2TG9iNmNOREtLV2tCM0pJV1hiaGRW?=
 =?utf-8?B?OUE5cFAvUmJQVXpMcW1Qb2hQYzlEMlhZR05BRnRnYzJLQlRDZVRYQTgxd0dk?=
 =?utf-8?B?d1FwMm9Fc21YVVdqbW5TZDZXODgxVnppMmljcG9rcTF0cEFndkZTdUFXMjRH?=
 =?utf-8?B?N1FRTEVwZHhkUUlpZWJoYnpQeGZtM3RENEgzWmVidW9GaXFUM1JlbnZzT1BJ?=
 =?utf-8?B?ei9ja3ZPQVQvQ0E4Zmt4L09Fdkk0SVBUQmNob0RlOWJ1RGp0aVhPaU4wYit2?=
 =?utf-8?B?SkxIbTFFcys1R29lMzNEZ3pEajl4SWFQamtPbkpsMHJtVFIwbENLNzg2SVBC?=
 =?utf-8?B?VWx5eE1IcUF4b0ZaM1UremtDK3JTNGVBQmV1OTRjOWFLZndrTDNieHZRc2k1?=
 =?utf-8?B?NmorKy9RQWdnWnQ5VEdaOWs3SitSWTdKVzE2aFFRcVZ4UUVSSFc1OHVNa1Zy?=
 =?utf-8?Q?+tWL5JOcK/gmDQ+Aci/D2hu24?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1a2060-da66-4d8b-2eb5-08de1ac0e515
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:08:11.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHlN53LN6acRTXYkYXmipOJ5qLlzPRrfPelJ1SWYFuNOJ2U/Yhmh7m//iHHQbxZDYQJxD7rqXzPyCu0rbioszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11077

Add compatible string "nxp,imx95-hsio-usb-blk-ctl" to support USB
setting in HSIO Block Control.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb and Ab tag
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 27403b4c52d6219d31649d75539af93edae0f17d..aa452fb438a9cd5b9a8ad3eff6249abffe576a01 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -18,6 +18,7 @@ properties:
           - nxp,imx95-camera-csr
           - nxp,imx95-display-csr
           - nxp,imx95-hsio-blk-ctl
+          - nxp,imx95-hsio-usb-blk-ctl
           - nxp,imx95-lvds-csr
           - nxp,imx95-netcmix-blk-ctrl
           - nxp,imx95-vpu-csr

-- 
2.34.1


