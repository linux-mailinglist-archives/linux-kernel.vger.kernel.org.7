Return-Path: <linux-kernel+bounces-882623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED2C2AEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0464B4EC4B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446B2FD1A1;
	Mon,  3 Nov 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nDU3Ic5O"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE02FD7D9;
	Mon,  3 Nov 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164508; cv=fail; b=agzw4HBsPnUbYf8pjLpi3TBu8RYl35fu36mFfnV0LQx4GTthrmJJC2MNCwSOeIonQ+P5MTuY27n+OP7VqjoEqLVCMoQC5ZcIvS2YAbo1B4cLPPx5NNcmpNPBxU5S/w7/HYqeso97twSSQd8aaU4FjL3BZpRbB/5sLAp5y4C1IFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164508; c=relaxed/simple;
	bh=bVdo3Xstb6tpZgBieXcsztJpXd5MUAsa6GCGRMn+UBI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=In4pTRhH10LHWJ+vS5SBQQXD6NHe5j7lcm8L4f+WogE6Mrn77YMuIec08NKH9lbAakXjLdxhmFR3bH/GsaXlCMuPTvDt6fMmfIEO+3NSd0iMeFCyTIJBlroAa54C6vdSfy+A6lo0+A9fLacJFkmWvnuUs0vK9POFRFgA5I5c3xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nDU3Ic5O; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjW6wjrs6aoSJWQk+oS1h5h7Ws3FpKFB4UYq1SKjMdZvjFRYcx2gQ7WstPPs4XnK2VugKbfGNR6mDPUMgAiqlokQ6bTJuisnKY7QvH1QHKdhjbGLW7LRTTv7PINksnd8wBswuxcPihnF3O2icmUhfoXO+WBalxwqq9nK88bC6e69AE+GrLUjJBZ79vrnUSV1rJL9femHkm0M+OfyWHppPNU/5C9SYYfmdUTsumVMTERD+2ooc+YMkIDrm1WRvLiIGY7MpraT7dmvTm4ovH0lofKSUPIjHCzt6gkOxQ6b8WoChNqrof6k90aolNoR8aBfmJfl5hrMq1CYzKyhErkjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpAHBTSkPAY4P0n1sPJGA52WPMOm9vKjD13Nn3rS/Wk=;
 b=JyWkLzdMUimbClWK45Ig/C5IcHB9yzSVygLFHSyM/V7Dn4Z3rfUMyJWDoycTCX3Vmw/mqKhFYjQwxaptQvJVrwrFefPzVFsBXDHUDmOo5Xk7AX9Ab0ON29rwjjKsV468dDqJBrR+mMNjLexoTOVZapygg8DNPihVZTNofYfo/RNmB1pPDI5vZtZm2ftNY5ORPVeevKg72zD5dWk3N8KPoQt7G/x3vzBPhqjlrSqRayBo/iycp+ZQZbh6FojEKxWrh0KdGd4en8RCxR0bYjs1UhY5pF1Hj67KXuKOaOTaw0yoHcQ0k18zWD+KCCOGycol62X0IUorkPdaz/YX4k1InQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpAHBTSkPAY4P0n1sPJGA52WPMOm9vKjD13Nn3rS/Wk=;
 b=nDU3Ic5OrxkIs4CT69iiluQzMCbv/EHR/wB/9cVPwLLx79xWNR10qCxH8CuKI5lVLufXDs3BeaL9sFVjZn02e6t947bkGw/S2jedeETEAc9WwmnmUyrS5CYBBlx1C9rQPWTohBQZXAB+2brZDEEnHKzj5WIfmqEpArPOiEmELaMPtnoNl1IDpzzRBzdqUACkfaV5t6oT5uGYW9BcQ61+dpdzsDCS9ZHdSJKIqimuUYJ6Ywn3k0aM9TkFP3uw0EdtoDK6jeaeRNHTVrvu8Yu3M8PBypgmdzpdg6wHey55yx33MZZymGAM9V3b0ePkBO46Wszdi/SM22X2C9x21ymfig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:08:23 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:08:23 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 03 Nov 2025 18:08:35 +0800
Subject: [PATCH v3 4/4] clk: imx95-blk-ctl: Add one clock mux for HSIO
 block
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-usb-phy-alt-clk-support-v3-4-18b8bd4f01b0@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762164524; l=2185;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=bVdo3Xstb6tpZgBieXcsztJpXd5MUAsa6GCGRMn+UBI=;
 b=ZDxdt+gaYhHffjSO2YpOOZgm5Uiwa2Y2PDIvGQ9dp90jKzGH7ElNFnoyESpE63YStOUZprJOw
 lzckQGqPdcRAvWyAwI13mJ+84Az/i5EEyVPQJLX7AFY6d6BU8FIQAYG
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DB8PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: f496d040-1dc9-4438-d383-08de1ac0ec39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjFoYzlGUEticjZOVzcvM0JucU1ZNDVSdnlLbGN2SmV5ZFhlQjYxNXhxb0Jp?=
 =?utf-8?B?T0RxdFFMa2VPZUFyVGJYUVNMUXljSXh2TkNMWGh0dTBqRHJ1bmRhT01CVVJ6?=
 =?utf-8?B?dldjRWlUSnQxaTBSR1lWWmN6ZERPY0ZtaEdDTXVYM3J0UjV0cEZlNmpKSzR4?=
 =?utf-8?B?VjljaW16Rkw4KzMzUUJVeHJpUEx0OTFUb3pHUHdKQ0dvY2hPOThhZ1ZwOEZy?=
 =?utf-8?B?c3hHZDV5aWhrd2pERE1RL3FhTmlSODNVY01Jb0llSExZUGZkSXo2RU5jOTl4?=
 =?utf-8?B?WTBOUFRFclEwWnRXYmNINDdGbG9TZnpBUWtpK0JCS1kxSGI1aU1NTk1HMU91?=
 =?utf-8?B?UHFjamhvT1NlTk1peG1HdENYUU9QWGVxWDhOVm5DUEZtdkFZa01RTHB1V1hR?=
 =?utf-8?B?RXZQb0xyQ1VpeXJRYnJIU1NuZXJ3dFdCalhVMVFGWFdPUDlnWi9xQWF3bnZm?=
 =?utf-8?B?Ly8xOVJyUEhKRERiYlI0RjZQc2R2b0JYTjZlOVBOMmFiQWFpUzhtcStqZ2hN?=
 =?utf-8?B?RzlQcTNhVWlQKzlCYTRMVEo1SmRDZ1VmbWZDdUJjUXdFMVc5dDNzWFYrN2Iy?=
 =?utf-8?B?eVVjb0w5QTN4TGt2Q05vZTBVdTd6dDI5M200R2JWYkkwYmI5SlBOZHhnbjZl?=
 =?utf-8?B?elU4M0x6K3g5ZHllYjhlM3UyYUUwYkl1NWtTSW8xOC9uaWZFR0xtTTZBN0Zq?=
 =?utf-8?B?ODdSUW9WbVlyYnZ2TzVRNHdVSFZmUnlrVzk2WmRMYnI0RjRFQThEbHhqdFRD?=
 =?utf-8?B?NC82NllnYks5c1RVUS94T1ViMEQ0MkV4OFo1VnZlcGJFaGRydXdueDB1RWFq?=
 =?utf-8?B?R255S2RkMXNjdFVLSHRhTEJXVDVXS0dYUHgyWEo1ZWszQ2ZYZFJzdzRIbkhU?=
 =?utf-8?B?OVJTTXZ2dlc5MS9RNitTZ3VUVktFTlpidDdLS3hpQTR5bk96RzBqSGRuS25j?=
 =?utf-8?B?dUgzY1MybktBaStOWTQwdjA5eXdERHlNdG9QRHhFN29oOEJpZTNkdk83Mll6?=
 =?utf-8?B?Q1c3ckM2Z01CWUJpU3hpeEU3UThBclc1RTJxZ2RWcnNpVyt0dCt1QnFoRzJD?=
 =?utf-8?B?NjJLRERMcWJrUlhHS1JTalRsemJwVWZ5L1JFMEEzTkdON0tKZzlZL3Y2K2Jz?=
 =?utf-8?B?VVB0aEljTmQreDN2b0dEak9TTFJXbjRSVFZHNjNuZklPKzUwalJ4OFM3TjlV?=
 =?utf-8?B?T0pjb3JwL1B3SzlFQXFrV3pjQlJjazZmMEM1RHZhODRrQ3N1U0dQaXg5TTdy?=
 =?utf-8?B?NUdaNXNEamU4MnlsL0lzTXphYXdnTUUwWTF1bno0Tm9lRnRoNGY0NUdoTlhp?=
 =?utf-8?B?amhla0JwaXBBcDNlaFJUbG5PYU9ybVRvaGF2RnBlRXUrelN0MWxzNG8xNmhR?=
 =?utf-8?B?UUpWTnhyMXl5VU5oNzZKdlpVR2hkRDh3V3BCaUZJcXBibkF6Y1NaaXRGU2Zu?=
 =?utf-8?B?YmZSVFFqVlc3M1JuenhtZWJDaGcxM3lqMDY0MTlmL0gvTUF3R1pZQ3ZKWkZL?=
 =?utf-8?B?N3ZIWlpDblhVQk9wU3ViMXl0THBOdUZZeEgyenY2MVBPWjEyZEI3WG1Mejlu?=
 =?utf-8?B?UXkrMW5pS0t2R2c5MTFKU1EwZ25ydlQyMjR4cERrS3NSSG9nMVNjR05QS0pv?=
 =?utf-8?B?YzF0MEpxUi9yMnQxa1E0ZFgvc3lXYitvcldxMDVSY2FBNktUQ2hWQ2NVSit2?=
 =?utf-8?B?YWM0OCtlQWVlMldiakVtUVNHUVhGUWxzc2JSK3cyalZKVkxmQ3NKM2F3eXFW?=
 =?utf-8?B?bTc1ZFkzVWhnUnJ5NUtrYzNTRUwxQTFFdlhpWTRTSHNNQitwbEwxMElzR292?=
 =?utf-8?B?NGZ5RnhwZjJ5WTBMUlV1MXVtL1hJRlY3UC9Xa0o1QzJIZFRSWTZjblZtZlpm?=
 =?utf-8?B?VlJXM01zeW5MYVdQQzh6VnpldE9SMW9VdmlMTDQxRVZQWUV3V0VIbWxSM2lr?=
 =?utf-8?B?S0xrWW8yUTdzQ1hkdWNLYmJGV0VDNUhjY2h3R2dTMlJ3RjZvMitTVTFZZDhI?=
 =?utf-8?B?dm1zR3Jjb2lyRXVnYW5FNUVJTUxCcitJUUNSeHFPSXF1Nk1US1VZdXBiN0Jt?=
 =?utf-8?B?eEF5VGplYWk5alpRL3RYcmM5SXNETGJySEJVdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0kzb1NiaEZzalpsdDlTZXEwZkxHN3Z6SDdzMWc3Wml0cHEybW9XNjVQUHJF?=
 =?utf-8?B?NlAvSHV1N08wYjlyM042L0gzV3oxMWJKZlFJaTlqNzkzdlcwL0o2d0NROVdW?=
 =?utf-8?B?ODh3c2hkTXgyN2ZtWWJxMkEvUnorZnhkSDl6MGxIUWNCTTNyVDRycWl2S0tm?=
 =?utf-8?B?WWhEODFlMWFFZ1BJZlRpK091OWd4MjRGenFiWUl4RWNPWjNmaTVFRXV3ZlA5?=
 =?utf-8?B?RVRFc1pjSERFb2RRaE5KVytjR2I0UExtZGkwOEFyVmdWbzEyZmlGeERRQ0lq?=
 =?utf-8?B?QnBuaXlUWWJiYTZYcW0yOUc2NTVVeXlPUmx3NVpOZkRjbmFSZ0J0YjRJZW5l?=
 =?utf-8?B?dWNCVUxDSkEzNUtVV0pTQ0Evc0Nsc3o3amE3TnVCL2dVSW83V0dNRkRScnpi?=
 =?utf-8?B?bUtrUCtrMkdUeElyWVYzaGFwaklRVDlMaDR0VWRRbWNqa0YvRFpUNTRjNHlN?=
 =?utf-8?B?Y1dRYWRxRHoyUkdCRHpLVTFGTzFWMWM2eHNwaStBa0dqUjhJdG1xVk5uZW1y?=
 =?utf-8?B?N3F0SXdubHRDeEsxYmVtN0dMSTBWYTltZDQ3dk1odWhiZ0xaSTBIRks0UVEv?=
 =?utf-8?B?R0NHYmwzMWZ5LzlRcENGMWxTWHFnWVc5VTlJb3h5Y0l0a2xpaEEyWnk3YUhQ?=
 =?utf-8?B?bTUzVXppRHQxeGVuWmk2a0VROEUxb21NSlJUOFIzYm85WUVnMDNad0dwa2RJ?=
 =?utf-8?B?U1Z4QXBnRHU4NFRUcUNEZklVai9MeFRCdTB6Y08xTnZlL2RDTTdlUXAwUVFQ?=
 =?utf-8?B?TW5ZQ0tkd3dLSDluTnhJT2xubGtmbmEvTTljWFROemZzUmE3YUpMOTVZcEM4?=
 =?utf-8?B?Uk9oRXdCTXBjNkhrc1g2TXJ4YTI1T0s5QUJrZmkvRFlBUklMT1Z6Sngra1Jn?=
 =?utf-8?B?aVJvTlRGWjBiWnhtaUl6cVpMVFQ0ZGtFY3lldjFLL1A1ckpiS1RUTFpwNTlq?=
 =?utf-8?B?SkJuY1poQVF1SmszSkdDV0grNGF1WGRkM20waDhKODdGQThNVS9wS0hHNVp1?=
 =?utf-8?B?d0RWTVRQYnF1enhNNTJIdTN5L28yR09DaFA3NTJEdWVidk84VzBweHpIY2JD?=
 =?utf-8?B?S3dndTJKbldhT2NNQ3hGV1lEMUFHTzNzSFZPeWJwdlFPek5zSkRSRlB5SFhS?=
 =?utf-8?B?WVkrNEpmL2F2cGZPMTNBcVUxRXRDUGJSMTk1RFExZUcwY1BrNEFERHR2SU9H?=
 =?utf-8?B?Q2Z4SFozeXJwdzUzTnI4THdrOWZLQ1VPMDlLMm84bGIwUFZOVUZUNWhVdUkx?=
 =?utf-8?B?d1lkamNYdSsvU29KVTJOKzVISkhxOUJ1UzhVMXB6T1RjWlpnaC9LVXBLc1Iw?=
 =?utf-8?B?ekdEdFVRd1BhWWFaSEQ5YWZ2MTNCbEhPb2NwejhkeHAzdU1CTFR0Wk51bDhE?=
 =?utf-8?B?c0taL2RkWWxnbDFCMmg5K1hLQ0RZZlJlR29tRGFMUFp6WnF1K1plQnhMcHpl?=
 =?utf-8?B?TUV0dUxSVW5DR2RKYWlYMlhkN2hhblJJTGFiNHFvdytrV0s2SzVHZS9ENzN4?=
 =?utf-8?B?R09US0tvenJRTFNTa2NxQnprelU4Q012bXVaQzQ4WFBhOFdPWFZvUWNnUng0?=
 =?utf-8?B?UWc4ck9oSTNlUy9SVnBrMnUvaFZybml5bTdobmZINHZlWmh2WTE1cUIyMFVU?=
 =?utf-8?B?ajIxYTBHM0huSXFlR005VnB6b25LQ2lISlB2TG92cHlENVNkSVNhU2dXZWJF?=
 =?utf-8?B?cDl1Q3NrTjJ2RTA0US9mTFpDdWhRR01UOEttcWZYRWErQlFrL0tKV1M4MmRO?=
 =?utf-8?B?WDVFRVZiT3I1VUNXU0NjVU5FcVhaWHpINENGK0MrN0craUpQby9CemQwM2lM?=
 =?utf-8?B?UzdZa3lpK3NXQVlkaVlpNUJJYlZmcUE3UWZZQ0RwWG9JVFhqaGN5Q3VCeXBn?=
 =?utf-8?B?OWRtTVRFMC9lMUxYMThaMERBRkhWaVljTFQ3RlJhaERBbDlGMFNNMDZZUkto?=
 =?utf-8?B?aFVpMk5MTENjWUxJVzdvMTFubVp3bnh0Zk5JNmszeHM0cnZlejdYZnJmcmhi?=
 =?utf-8?B?bTRXOC9RWGNIWTN6VmVOUXdraGU2dHFQV2kyMUR5S0xTTVh0NWNnVEp5dlU5?=
 =?utf-8?B?TitQNHpTTUtnZzZSVVJ1RDR6UVJ4aUlhNk1vK1JKN1ZPV0dtVWdZRGtjblpy?=
 =?utf-8?Q?fA6J+AP0+KxpViEJOAojhVx7B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f496d040-1dc9-4438-d383-08de1ac0ec39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:08:23.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4UJZ723w295iVvhCW70Xp6Wlo61exQHw1lHk2X/fAr1Rtpgqnf+O94dbDWJryxgNfL4arkidcMXyI6r5yT5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891

The GPR_REG0 register has an USB_PHY_REF_CLK_SEL (bit 6) to select USB 3.0
PHY reference clock.

USB_PHY_REF_CLK_SEL:
bit[6]   - 0b 24 MHz external oscillator
         - 1b 100 MHz high performance PLL

Add a clock multiplexer to support USB3.0 PHY clock selection.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Changes in v2:
 - add Rb tag
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 56bed44719954d6a644606914b61dad672cd82cf..c078b2ee28e81155ca3a93d26c2e757c8ddc91be 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -302,6 +302,24 @@ static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
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
@@ -519,6 +537,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-display-csr", .data = &imx95_dispmix_csr_dev_data },
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &imx95_lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
+	{ .compatible = "nxp,imx95-hsio-usb-blk-ctl", .data = &hsio_usb_blk_ctl_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
 	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", .data = &netcmix_dev_data},
 	{ /* Sentinel */ },

-- 
2.34.1


