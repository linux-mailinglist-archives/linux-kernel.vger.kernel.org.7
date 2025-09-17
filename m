Return-Path: <linux-kernel+bounces-820264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20265B7D247
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C552E487FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715B263F36;
	Wed, 17 Sep 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Seav8+bN"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B630BBB3;
	Wed, 17 Sep 2025 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098564; cv=fail; b=I9ijfaOwBPA6l8N3IAIruGL9BKiktLPWosttV3aizn+eVd5Q8voKBk8cEb5M1K0TIKZlVyyn68+JJ1C14ECVwV63UVIDrw2IYn2gt+S2XLR6qmyNtdHMPWpJponc5ckujSCRrzSHypQNkzpKWJds94qfQKOEjqwvAEodmr0SNOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098564; c=relaxed/simple;
	bh=QDWF2O8A18c/bDzSjYQTLioDKVhNTq/87UKCcQYyfGo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DKP7dH8gbCfSUAPdn1Kx6lm9TUFx2KC8rkex00FWjYE4nlnPYBFUWmACN6RHUROPKhwM238d+ZAOD7k+dvx3Pw9PPGW40wd/u/U0wDRy/g8k1QGtnQtTFy1+PEdafrpT87+DY0/DADEcFBgSvSvGNcoziicq/Lpvn7SFkVzaIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Seav8+bN; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCPOBSVvGEbd/vMsf0ZR2d0KASp3GcgAKd4Wi14zBRWqn3eVfdud2crv9q2f9D5vKVVFNUb15k09RZGl8kzp/kQGtIpUiswO/iamyEn2WWHJvoWDzwGnhnuxlG/0xVkkatKIRxFOb4Olu4/YtYhh8vnXPMMMl1g4aFn6bro7VuwzGft9sjTw8idQnCtDq15RJt/S53th2HKakkJ2ItB2pxnQpMDFH+AYrOII8V3nX78XXtNOSJyA2RUyyyoMn9PCK2BXBtQGmsgil/eLEjYORoy0ALie4arp8fx86FrG19W79zgu4CifLlHxGYZ5J+HydnbmrQ5PechaKPbdMKkO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=senCAB36EC/A1a5U5QBmTVc64hzR9U0brS2lEOiK+cs=;
 b=GRG+gxaY0FwBtAEZ8n1Xv4FG0rtMtNoWmUdOxttyPOI2HFDTfOlo5y5IlbgzuJAuf0PBlNmCb8m+U1DY1BpcWhBL4/oGnojA8hgwrZpRlYeyeFDRB0wbBFACGt+EXr7DQaSPplbm9MVKFJxfrR9EVPz30Y1UuXifFJlR7+Ma8SrhrQgGYd9L+gnFbcD8SQLJK9TR4Ri7qd/anJV7Z5ODR9mMfzrsETZgMe8Sulc5yMCRsP+qyRdRahvW4ZbplQ9uE/rTP3LfFALNvKWliIfOfJBH+Ab3TTxoXrF91bxOWOOL0grOvgO/vTUl7k5JeUXVijzuf/Hz+BGHhPlUTFIc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=senCAB36EC/A1a5U5QBmTVc64hzR9U0brS2lEOiK+cs=;
 b=Seav8+bNk+U0fHz0HGjOwIuHP3/xLGDWNl3d0RFCWRQexc2IEzEjCMij2Y+4xaOIreO5YjjAbWgZjBG/nHVEH2KC5vXee/RBguA5yK8mLqeeJOxGz8/z8nIfmFr7MkV0pkYzDSrqqWiulm4nfqG1SAWOaYW4fB4Djl1df6R1JDTt5YWwzZVKGtPpj1M0HcxzTKUDrdVMN0Knt25T6E8dTeVELVMhKj9NmLKqKKkbCfHFcUhjvCGSbq87rHE3cGykvvgCTyKdIl5NTkt9sL32E+3el7TtZyLFZZXb1ebISM46OCDI1ti/g1a6sNzhPWRBT0p2mT9L+/IHbK9+GCGLlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 08:42:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 08:42:38 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 16:42:28 +0800
Subject: [PATCH v2 2/4] arm64: dts: imx8mn-evk: limit the max frequency of
 spi nor chip
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-dts-v2-2-7e2a95e3cf4d@nxp.com>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
In-Reply-To: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michael Walle <michael@walle.cc>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758098561; l=1174;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=QDWF2O8A18c/bDzSjYQTLioDKVhNTq/87UKCcQYyfGo=;
 b=u9sLSraTY2Esr9f+xIXE/LO6uGezKKKd/ozGFTJzrqjIXbwypZNi9eQZBf+jntNi10v/nx1bm
 6qQV4GWhXv5DN9LCnocygBOoc8JoCQShZ9Y1qdYmHSODCMgheH21F1c
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ceecce-7e46-4c63-fa66-08ddf5c6282a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWFiREZKbEoxbFlKaVNWTm1pUlE1QnpPZEhpV3kvRzlTWE9DR0xLVG4xTVhM?=
 =?utf-8?B?TTlCeXAxYXIxQ1NLeWVEZnhwMkVsRHBETUE3VlB3OWRrenc4bWV2YmU3eUxy?=
 =?utf-8?B?dFVnZlREdlB4aUl6WmpmRnlZMGJJN2ZxOGxPNFZCM1poMjlzUXRNcnlBOVRG?=
 =?utf-8?B?K1Yyb1FKOHFUQ05Pcm4ybWpCNUJuRmJvVzVOZWxjeWhFd3Y0U2dmRERLVW5T?=
 =?utf-8?B?VHlhR01FaE85d1hlN29OUG5PVjc5bzNzbWhIcnpSMDFsUlFDVGxaMFdkYW5C?=
 =?utf-8?B?SlUyMFUyazZ4dXZUcU00WHBYK2VCcHd2VzhlTERPUnRTUzNOb0FjcWdEcWhC?=
 =?utf-8?B?ZElaTmFid1NrNXdjNmcyMTVsTjEyMkxJbkcvWkRWZ1lkdDNUSCtwbDlqVzR6?=
 =?utf-8?B?QytneTRibGVYLzhsL0NpMzJsRVlwNWl3a1daVHVRMkRIK3dnZmpZTm5LbUp0?=
 =?utf-8?B?b3dRdHd0ZnRPZ0ZlMGRrZ2VzMjUrTzJINnF0aXVMcUc4ZUtIbHVVMGNIYURN?=
 =?utf-8?B?NEQ3dkVRZnN4QVBCVm8wMFQ1Sm9KRFR6Tkh1b082N2JTSjlwZFEzWWhnN2l6?=
 =?utf-8?B?dWtMV1pQSUdCUkpLUkVRQlgySmJhQm1aYVF3dFU5ZW1DVTM3UU4vUXk5c2ht?=
 =?utf-8?B?cVYrZ2ROMVdqcEtCdTJqMzFkRnc0MjBDQ05ManJlclhxNTAzb043bTFMUW9U?=
 =?utf-8?B?TXJhQXlFUlAzTUZvQkdZWFQ1TFFVRzRDRVBnK0pUbnJ5VjJtLzVOeWY5b2dW?=
 =?utf-8?B?cFRTUlJxa1BwUHhKbmJPK2hCN0s0WW4vM3lDVjFQaFQ2Y0dZRlkybUxqQTJj?=
 =?utf-8?B?anRlWmM0NzBIckQwb3BaTjJNQ25CdTNyejMzVkRMWkp6UWFvdzF1Q2NnSHF5?=
 =?utf-8?B?UHpxOER2dE9QZzZwUmJzaVVGak5aVFV1WjZHT3NrT2hOL0lUaDR3Tk1PbWtZ?=
 =?utf-8?B?WU9ic0F1NjlFNjQ4QnprMHVPVHk2QzQzdDFTV3B5ck16TzVISWxMUHplYWNP?=
 =?utf-8?B?ZGwzQTRvQkZ3RWJGMGc3cUlLN1NYNXN4aklRY3J5REcvNGdvZW5BMU1GU3lw?=
 =?utf-8?B?NDFuc2FEUEVQWkhXTjAxWEZzTVRjdGJYdUJFUlduTkU3OWZKSWRIMTJzTk91?=
 =?utf-8?B?V1FKSU15Uk0zUGNWMDQxM2M1U3BjMW9DWk8yQ1BDNjlRZksvdjN1TlJqajJn?=
 =?utf-8?B?L01rR3dLdE43M1ExTzhJazRvTDFDUHR1bDRYRTQrT2x5Z1R0c3Z3LzM4bm5M?=
 =?utf-8?B?QXQvOWMxckVxK1ZXMVJrSGtyYXdYaVVsbnVuM3p5T0Y2Q3F2WVExelN2Z3F6?=
 =?utf-8?B?NWRxWE1YSnpRMHB3WHFBY0prRmxkVko0VlRvbndpWE9HQUQrNlpWUnNRaHUr?=
 =?utf-8?B?VlFrUHZ3UEdlOVZtMDZ0YjJ6YjZpc25BNVZoMHVyMEZobU4wZ2hmY01pd2xq?=
 =?utf-8?B?Y29CY2MwRzVMZmdKNEk1aE41bjU4cTMxK1VLSExBcE8wYjFCcE5PSGh3Mnhz?=
 =?utf-8?B?WGx1WTg0OGNadGlQSGgwK215UUpnbHE2WFpicHk0aXQ3d2l4QTJUaHN5YnY1?=
 =?utf-8?B?THFFb24yS0JqS0l3VVE1TDRoOHJrbTBISzhIRkhESWpRMUh2dXUvMEJLS0lQ?=
 =?utf-8?B?OWpBYkpnczVlVmdWYk1EbEJBaGEzc1lRN3ZoRHUyWUNOMlVwK01ZSW9QejlJ?=
 =?utf-8?B?RUZ5ZEJnekJRclJDVHo4OGlDL3hMM1JJOEtzME5LZnNGNWdEcHA1d244V25Q?=
 =?utf-8?B?bFBGa0Q5OGVXT2RQZVM1MG1vV1N0MlFucGd3TkdyUkRCcE1iWSs4WlRkWlBN?=
 =?utf-8?B?NGI0Q1R5ZlJCMVFUZWtoWEZkaWRnWW9ONFp3TkRvcXJtZXJDNzVkdGJxTU1H?=
 =?utf-8?B?ZnZBeTJyaVYrY0FkYWJ5UjM0N3hROUtESjJXSlM1SUQ3K281K3JjbUR5UUk4?=
 =?utf-8?Q?T/YTp4d++ddlqZ53HnFTzXfXnyKuuxto?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmNKVDh5UHRNYzhIVndNQVJBMzZ6VzFSM2htV3BEV0ZtZll3Z0t5ck9yNEZR?=
 =?utf-8?B?YXR6N2swYTBQYWJNekpmSUI3bTRWUmwyb0ZndFZnakNDQW9CeUppUDNCWEly?=
 =?utf-8?B?elFja0FTTFpaL3pqTkxyaCt0OGtIcTY2MmdCRUF1SVVoQ3RYQVIzT2lpRzF4?=
 =?utf-8?B?Ny9VNElNT1ZqMGtnc2NnaDlJSjBuT2tGUWJQWmtrc1p4c2Jyc3h2czl3RThE?=
 =?utf-8?B?YmpuclpLTVdERDc1emJYV0hqdm5odG1XSTUvd1lCUzJYVzR1U1BlNlgyeWpR?=
 =?utf-8?B?djVZcGJMN2FGM0ttMmxLWDlkdXc4b3Q2bWJKNm8wZ2I4TUdha0JkaWQ0eXI3?=
 =?utf-8?B?bWt5cnlCSzhFdG0zS3JsQ25lamZmcmJLZkhxYUg4KzkwamVYc0x0NjRFVHV1?=
 =?utf-8?B?VmRSM0ptY3k5cjVCY0dYdUNkUWtMU2pteTdGUlBVWjJlMFBuNTJlN0IxVDN2?=
 =?utf-8?B?YVBxZnpyRkF3MUFzek1mVGpsNFVZVWd2R01lYitwMWZWa3Z4MVZzTk1LK1JJ?=
 =?utf-8?B?K1QzRDVrMmlsZEMvb2xXQTN1UVlwQ1BtMUVEa2FDVVpaSUdORTM1c1NBNEV4?=
 =?utf-8?B?N0kyTTJ0NU5UTmxZckJhcnVEWENtcmNvNk4xY0xmVFJ1YWRQeUZiMEZrZUk4?=
 =?utf-8?B?V2l0TmNHWkNYdkppVk5LZ0xEVk5PaU5rdEZxZ2p4by80L0VQS1lSNlRJN0tm?=
 =?utf-8?B?WjJxZ2NZN1h3VmU3b3psczluNGZQaU9jVXJ4ZW5peUpBaTFkRWx6VG0wbWNI?=
 =?utf-8?B?UG5oOEdTeGUzamxmR2JhUEpkWlhuRnRmRWFITHM1SGZHVGNWekl3N0FKR3pa?=
 =?utf-8?B?QW5tQm1DdEdQR01KRWNrb3NBTHkwcTY4R1ZXcnk0NHlHNDZRVG9OclduZHRM?=
 =?utf-8?B?dys5SGt5U1JBYXg0RStiSkFHb1Z0cTBzVG8wcGxmZ0xPejdrb2djSHFHQWZ4?=
 =?utf-8?B?NjM2aVc4WkNBTG4xbVo0NS9VSlJmSWhzMCtvYlV3L0VQWFJUUnIwV2hCaU11?=
 =?utf-8?B?NWpiNWJFSmJVN1JLOFZHUFdHUGN5N0dlQWFIV2xoRkFrTTJhUC94eGZoSnJa?=
 =?utf-8?B?Wmw3ZjB3cjlVMUowNFNqVzFhYjZqYnAxWVJyYkJmNW1FaVpCN1Y3djUvSVQr?=
 =?utf-8?B?bWUrSCtCY0I3d29yYk9aR1BZZmMrL1F5YXc3Y2taWG5DeHRQS0FjT1Myb1dT?=
 =?utf-8?B?U1g1eFdpYnVaYUZaSUhFRzJyT1QrbCtWR25CYnJnbTlMMVZtVnlhdVNvbGFo?=
 =?utf-8?B?Y2NHUzNybkVPTXhqOGxIU2VjN1pLTWxqamtkdkVVdXNka0VTL2tDZUhiLzV0?=
 =?utf-8?B?cWo5TXZJTlprT0F2THZLQ01WR1YyeXJDODFZcWdqR21HZnIzb3c5YWk1RUZx?=
 =?utf-8?B?N1VMSEh3dERwQ3Y4YWZoMUcvaUdMQzVvV1ZlODYxYkJDZTZqSkFNd2ZrbWxm?=
 =?utf-8?B?aHdMR3QwTlFGRGRRczdwUnhTMjJhNXpqQ2VKSGg4NGJCL2RyTGJRS3piQzFQ?=
 =?utf-8?B?Ukx6QWpqQVlzQ3N6VjlMVjJ1d2U1WGFVU09GalkzZWtrbGFWYXRWNjF4eVJ3?=
 =?utf-8?B?NG44RTI0eTJuNURRL1ZPeXhpOE15RzJVYzE1MUlHWk1DYkFiM3RTZnVxRTgx?=
 =?utf-8?B?bURKZ2VOYlp5Z1VKcGkzMjBsOUc5dFVOMUt1bkVmZHNOQzBhb0ZJQWNod3Ft?=
 =?utf-8?B?VWZ2TTV1LytmUEdFazV6K29oVjMzeDJRZjdGUENaSkFmOWdUb3JILzNybGln?=
 =?utf-8?B?amFjYjFzbjFOWDg4QTBIaXpwVGJtZUtCbGkxaFB3RE9Kc1EzSGRHNERpUnpZ?=
 =?utf-8?B?QkZScFppYnFDSFRUTzJzSUxHRGJ5THQvWno2RHJORFpDQUZQQUhwckEyR1hL?=
 =?utf-8?B?YXM1bDhJZ2U1b1FKVnFzYzhqVUNuN3Z0SERzOW5yOGNrVmgxWEZRaDdoZ2JV?=
 =?utf-8?B?V20xSUQ4R1pjb0ZTR0ZrMUx6anFlTnNDdm1PSHp5KzFVOFpveTVWZkh3Nk95?=
 =?utf-8?B?Smw2ZXY4UEF4cXRQUUVrNTAyS2wwRUxzdHVQbDhJcmo1THhFaDhNY2JrTmdv?=
 =?utf-8?B?Y3V6bmJaOEZWTFBWRFNLclJBWVlzV1Yyc0hYZktZT1F6bVd0K2V5RDcvVXVD?=
 =?utf-8?Q?Jj6Ni4etgqLDIR9MTuD4u8cY9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ceecce-7e46-4c63-fa66-08ddf5c6282a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:42:38.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXfKVmlAimfqQ4JZlLiyG9gP9TgZ3mufjvlSmhflBjUlRJJ6ghl9MOZJmbDi39a2qjGThyFs4nhzSl7EeoUanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

The spi nor on imx8mn evk board works under SDR mode, and
driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
According to the datasheet, there is IO limitation on this chip,
the max frequency of such case is 66MHz, so add the limitation
here to align with datasheet.

Refer to 3.9.9 FlexSPI timing parameters on page 65.
https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf

Fixes: 579df4288896 ("arm64: dts: imx8mn-evk: add QSPI flash")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 145355ff91b454795478b504eb403b0590848d46..fa43238e7b917a5b5f0bd9af96bd900f6dbacb8d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -199,7 +199,7 @@ flash0: flash@0 {
 		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		spi-max-frequency = <166000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 	};

-- 
2.34.1


