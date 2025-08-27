Return-Path: <linux-kernel+bounces-787676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D02B3797F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416C67B062A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C730F927;
	Wed, 27 Aug 2025 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JqKTrNX6"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2F30F55B;
	Wed, 27 Aug 2025 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270792; cv=fail; b=HYTx/LGsMvUzRKk+QnXK2t+m0iqjMZanc64htiprmhjCFVnXMZNa6ifYjrr1CC3ML6uHbsm+LpH2fnXVl1uTT2S7mfnmXeOSxq7VWj550CpJTZE04ZkwDUyqIToQ0lSfeL++sAqq7Qu4SLdvFH4x1kOknOSkN6IDyKSjRnibMoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270792; c=relaxed/simple;
	bh=AUgQOZsdsMq0QpbnXbXCTEAe1f5ZAQ7gp7hoDv8f/xE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uIio7ClXbAvjV0rbwm390Z0jAHUZUXYNwC9QxAhjxNTob4KabWA9sbo/KV6a8sOq+84kk8fUiOyUm2rGqf0W78MCEqWULMlMLm1ClErHuVJX9V161bFzOlH0rB8VPk+3yqGXDo3Od0u0MNxvTQ1asvgcxymHX6wFiCv0IqYG4tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JqKTrNX6; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1RczYNJKvFP8KFprWiAGbiBmegJ6E+U0xw0uTrqIrmgOgYEkIa24bycLPhVKiydTg0rDIUciJJfcNOSVBUUPFCOoZZuaxqU5lDqdEZ+/JFkh1ojKtGIqNN/x9WabM4gIpV6N6C5VFPLbQhaT5U1V6Zb1NHWbicuDQSTQZmiISOQvKBDpQ+FbTqarG/yD4UQbpiDdud1FeKeCEeoNpxGS63J+8NWEWU6m10XK6MBYuMEuB/TGehsZNq7dIJfXSjIqVtOFTDtaKj9jWg5toICxM6SVGhR1EmsmWr29pE7bYcgPy6CRnPmB59VpKBD+D7qmthCCxeXDrJsVpDGdf9EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9TQRYR5/zHxZvAE5lSiSSvfM7YWOWUd3ho7q2990c0=;
 b=cfV3Q5MGfT4U8gaPD8Tu1U4n+1AXQ6mITwWMSfLKNyU4bxrMZYlPBCogdQAarBPkyS+IEzFi82Z4/aI5HMSYwL+kZ0NRGy4lTp47TSPr43KPSEKPRJxnULvKP2KjHv5omxRmD7eu+Swpj/8XdpEeVIQyA1V3I8nwpbSO+ZT35Vj1xMAkrnb4LYy7ToxUzI6rCsySOBXrNxyVh7tt8aybY2fkHGeffIlYvUnfasr8IWsxu5mu6CrRp+QOe5nWBV0r+n8jzrefFtwfinbW33abJbDryalNoLs9EdDvuw5aNf1JMD5w/yobhVz9XckD1RqCBN64pcY+YPHEyg5jc9kuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9TQRYR5/zHxZvAE5lSiSSvfM7YWOWUd3ho7q2990c0=;
 b=JqKTrNX6Iv36P+tsc/D92aARAJaUYN/XvnVxYWj2GLKREpqtepZQVkOOU7bpDZqLFePZD59Y3xpQ/3aev2qXHfCyYjCdR5EXjFICLZdi3IHl8WBDUj32+bxX9vBDdybJWT+OBZ279OLCJ/ToH+zDcgdTQX7PpCsBPAJ6h0nEY/xgSIgtzjLCZqwSSfrLwZ2Zd7AxhvQWrfeSsfgmhueww5HkPwlTBMAA8hDKPmixz7tVoO03sT1ThrtmMmjfquBRFpN0CoTtI/YfSOYtS9BLUyMEG/Z4IPUijYlQpz3rhk5iKenXPtloWuiqcB14wQ/9XZALCfMXDL5pcqxnrxYYZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Wed, 27 Aug
 2025 04:59:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:46 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 Aug 2025 12:59:16 +0800
Subject: [PATCH v3 4/6] firmware: arm_scmi: imx: Support getting board info
 of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sm-misc-api-v1-v3-4-82c982c1815a@nxp.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
In-Reply-To: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=2331;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=AUgQOZsdsMq0QpbnXbXCTEAe1f5ZAQ7gp7hoDv8f/xE=;
 b=wdf1/2Slz59aA/0CVZXR2rGJP4IGBQ3wVrgM6g+QG+buG/oH/B1gDxS4gHqAGZ8JmQzhErdo5
 Op66aw3AQocAtefM+so05sf9K8PnxAq72/M5F1HzurJquGptBk5jarj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 44450f3f-41f1-4b03-3122-08dde5268b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2lzTlBvdUhBNXIzMGI2NzAwMWxGVnF6d1hvcy8yNEk4bllCQmxlejNYejVp?=
 =?utf-8?B?RWwvTDdoNGpFNndzREZ4RnlZWlY0UkQ5SzV5YVRBNW93cGY4SjdlQ2hpUmlL?=
 =?utf-8?B?VDZ3QmtTU2cxMkhMRzJZNDMrOTA5TDkzWDc4RU9XUVpLSi9nSUhEa0VSUERL?=
 =?utf-8?B?bTBiVUtHN0p3UllXV245SjJtd0hHTS9DQTFneE1DYXhlbEdjd2gxNHRoYncv?=
 =?utf-8?B?WHlNQlg4dnh4Z0ZsbUZkZkdpL0p5cmRWSkRvdDYrWTZNaEpzL1lSNTc5VDdZ?=
 =?utf-8?B?MWhiT1pCTC9tWkNoRGJVdXdmSnJVQ3hGWldjODVmdHlpbUFRWHUxNWpGUUd6?=
 =?utf-8?B?a2xwZE9XQk04WmJwK0FhVmVZL1VtVlFHWW5oMnpyZXlrNXFDSk45cG5vL1dT?=
 =?utf-8?B?MmllYTZNTUd6RUU5T2JKbG1kRGFVemxjNzBoL1NGME9haW4zWExveWdnMWZa?=
 =?utf-8?B?Um45VjI5VWlkY1cyM2NoRXhuK3VQNi9UdXI3SlN1SmdxL05OM0NBek9uS2dI?=
 =?utf-8?B?L2o5K0VHNFZHbEFHeXJldFZEem1pcEplR1JvelJlTFhVUTE2QWY0LzB4NmtC?=
 =?utf-8?B?blpnOU1abTYybVo5YnJwWHQ0U3ZzMHRSb1FnV0NlTXVqU2lTT2Ewc3FCUkNZ?=
 =?utf-8?B?MUVrNzVxUkZybm5YYkFHTisxdkpwV0QxQkRpK1MwSFB1YkRoYnVSalh0eDla?=
 =?utf-8?B?Q3FaZHhrOEJjc2ZMUHErODg5WlBZOXk5ckhwdndwZkNPQWRkdHorQ2ZJSi9N?=
 =?utf-8?B?UStLeGJtVmdNU1ptTlplVEJjMHZkWkN6V2RtZUd3UGVXTmVURlQ5VHQyOERQ?=
 =?utf-8?B?ckkyb0U5SEFDMEowbEdVd00vaEFzR0MzNjlwSHVPVm43eS9DeUpBOVlua1JX?=
 =?utf-8?B?dnVLMk04bzFLcmdrODhTZkFVdnlaNmRGOHI1QVdNb0p3UUd0NDhJMTMxYlE3?=
 =?utf-8?B?d2w4bkhuenhpaTJyZnhabWRDMlhYd2lvWlhmVVEzME5JVTFuMzRPYW1WWjlv?=
 =?utf-8?B?dlUvaWN2UnNtOHlibkxPTzZtSU1jUWFwc0ZVaHRIcE80ZlBkOVZOUVA2ZWlt?=
 =?utf-8?B?VWU1TG5TTTVqUXpyNGVkcmVnazZxcExJVkxvTmhML2wzaERsdFM5UFBGNVQ2?=
 =?utf-8?B?UFVSR0pDRWUvQTFPeDdpUnNuajN0UHhFTkkyRUxrRzlqRHJPejYwRTBWcmJN?=
 =?utf-8?B?MkZoRk1mb3dPSzg2dWxJd3l3SHp6dDhHVHQ4NnV2VlNFV2k0dG44WWtpUVA0?=
 =?utf-8?B?Y2hHamRpeTVYdktoSVRabzBxcFNtM3dFMkRwOEp5S2hNMVR5K3N3bHZnRDhL?=
 =?utf-8?B?VElHd2x1RHRPbHJxalhmZ2dwY1BtcG5Dci9POTZtRjRWOWs0aCtJNnB3RGVD?=
 =?utf-8?B?eWl5RDY4U0pUZjdjZS9wKytmV0pNV1R3TlAvUkdEYmh1dGFCQW53Y0wxSXZv?=
 =?utf-8?B?YVhHZVNab1lBRTVtaDhqQ3dXYmVsTFpoRExza3p6VGVHWC9KNlBMWHdvdS9M?=
 =?utf-8?B?bGFQMy85Q3BWSzAwWEgyUnJGWGFucDNQMjFVbGREZzZsQVVDRTdiSzhMT0FO?=
 =?utf-8?B?aFRGZE1yVXBDWFlwd21rTGZqdXpqVUk2N05qemN2QVdubzMzb1BWaE1ia3lR?=
 =?utf-8?B?RFZvMjZyMEtnRHJNeTA5NHI2UElGZnQwTVRQY2lJNzE3NENkME1uRmoxRTNr?=
 =?utf-8?B?U2RSQXozQ1lhR1hqQk5ZdlBaWUU5cm5yWWQ1elNIS0pDc1o3UGVYejdVcFBL?=
 =?utf-8?B?dlNTbFVScEovRWUva1R6OGRZNmp3WGF6aFFWVFhKdUhZcUd3bi9wT29ZdXZD?=
 =?utf-8?B?NzZLcytaMkVMeWRPWUJPd3ZWOHQwUmVrS21US0h5YXhBQUhjQ0MyZFQ1VEYx?=
 =?utf-8?B?cHdIbWtPN09xMXpKL2E2cEMra0c4NnZTMUxiclVVZ1NtQUVXeGcvRHZBeVBy?=
 =?utf-8?B?RndWbGdxcmwzVURpOWJvTEwwZjBQN1BHRllvMXJBWVFYYWYxSEhoSjBsVjB2?=
 =?utf-8?B?R3pZQjV4OFNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0VmZjJwdFdxUTZOdW1GcDd4N0tkTEJSemlqZHp0cENHUmd5UVJVSTROSEk2?=
 =?utf-8?B?Y21CbWdBNjVTaUk0Z00ybHQyRGVqQTBNQ210S0VZYVRUZFRPdklSTk1tRVBr?=
 =?utf-8?B?SWwzbFFkOGVnWVAzQ0Zxd0NPa09lWUxyRnYwQWVjUzJ6a09kZzhGeFVzc2pp?=
 =?utf-8?B?dCtZV0dkNlB2OUl3OWhIcTNHUllDZzVYd0NSOHUxTWRWZ3NlRlRGemk3Kzh1?=
 =?utf-8?B?OStXdkNoQW5LaEhrRnBPVFVjS1daQXNJSVZTeFhOY29XaC9iMUVlcnE5VTE0?=
 =?utf-8?B?M2pQZTdvR0JNVm85ZHpWVS9sTEN6RlhrYzBocXQ1Y2dvano1VUM0R2FnT2VR?=
 =?utf-8?B?elo2TVBBSFU4S0tyQzU5QkRpeGRRaGRHV3lKRkpYc0xJWjN3V3QzQVl1VkVX?=
 =?utf-8?B?YloyR0V6RDk0bk9ERjQ5MmxjanlZcmdnaW1UVVVpZmFKMkRLVEtJZzZydEYw?=
 =?utf-8?B?S2hzMlpiV3RHQ2RRaXE1NVFtdTRxMFFja3VscnAwVkc3NnNKNDBpUDZCQ0J3?=
 =?utf-8?B?MTVvSnBpMzhZWENzMWxsRDJHK0w4S2tmRUptRG5ramtMbElCaWRiV0tLcGRk?=
 =?utf-8?B?VWFQdERTL1phSndtRTJ1UXBRMGF5bXdOYU1uTC9ZakhBNGNBNGduUGJpOTJU?=
 =?utf-8?B?cFN6RTUwUURKaXY3RTg5aW4wbVJIcE5jTjYzdTBJbFNaY0gyWElGdTk1eXZt?=
 =?utf-8?B?c1V5RnZSNnBTV3FWUUppRjJnQkQrTlZUZDFITFI1RkRLNkxwWkFKQlFoQy9F?=
 =?utf-8?B?UUhmLy9GcmpMVytNdkN1UjFBbDI5Q0s0N0RkWWdsMnBDd1RxUzdLUTN3eEdq?=
 =?utf-8?B?K2RIdDBqclBaMDFZN1l1T01TcFJyTFkvdlpXalM4QXB2VTdjRmxaSVpkUDZH?=
 =?utf-8?B?ZHk0VVFGdTdFbEN2R3Y5RFhvVkkwaVJhTFBIdm9NNkZpYWM2d2lXM2FBY0tp?=
 =?utf-8?B?UXl1UW5MbTU1T2Y3MFNudnRlZis3S2ZDUmdUenEzTmZYS2luOWU2Y0JvNHlq?=
 =?utf-8?B?U05wTGlKVndQVTdwWHhOSUtiS0lCYWg4VlFxZHBNd2tJcHdFM1diR05Zak00?=
 =?utf-8?B?aGlmUzErV0JLMmlqdndZSTY4UlBXeE40bUFLODZhMkhhWnlpTjJsOHhvQytL?=
 =?utf-8?B?eDNENlQxckxieSs0dDVpUEx5OEF6YzFDT2JwTDlQSXdFZ1RSVVFNNTNFazdy?=
 =?utf-8?B?TklHM3l0ZndIUlpkWGdmSGkyVzdLaGsrOHFDYUExYy84UXpyQTVNbm45b0hs?=
 =?utf-8?B?bk5ZcG01RUk4OHZobndadVBKOXdqREpPMFR3aXYzRGNrWEVHVHIwSU8yY3Nq?=
 =?utf-8?B?ek9rY2NOdHR0WGdWRmMwV1kweHVxZEZFamdYTGhHb2xwYWxwUEtneGo5VS8v?=
 =?utf-8?B?OHdVcWY4SnJIZHllTnpKaTRkQlN1NjNZc0JDcU45Y3lKckFXRWZ1eFU0TVd1?=
 =?utf-8?B?T0dMTjM1Z282dStWbkVoOW9NQ1ZoTnBwRHN2YTVjc291cGtaTnBrdy9qQnRY?=
 =?utf-8?B?elhSVUkxcEp2ZThlS2lCb2ZSbTNLMnV3akpTZ2gwRFZOWlZ1eDRISjBMWlMw?=
 =?utf-8?B?ck5PdmxJN05qWXNPaEh2VE93SDU1a1J1OFFDZjVwMU9JemJtR2R0OGNtdVdP?=
 =?utf-8?B?ZHhOcjlIRFlhUUZveFBPa0xWUWdJWVNreU9TaHZBOVFCN1pLTmhaQXZDL0tE?=
 =?utf-8?B?bFlQVFBqSjZwODJuWEY2MWh3SE91TTZNcjB4ZlFJbGw2TVVReUlTYzJqMWR1?=
 =?utf-8?B?ZnNPdnNKVXM0cnhMU3dzdklpMlg4NHRkTjhuN1FFNFlEKzVCazhoWUdscnBF?=
 =?utf-8?B?TGEyOGpvREJINlh2aE5hV2pCSzZMQ1V5RlQxS21lM2ZEbDN1TFpjdXhqeDN5?=
 =?utf-8?B?YkNOeDRTa2dvdkRpZU54RHVXWWdCcisvUjFVNG1HMjl5YXVNOXVMYkRkL2NI?=
 =?utf-8?B?ZjljQm1ZZkppK2wxS3RyNDZJSzVsa3BZWVlGUGtTNzBOZEk5ejB1NmxNdjhi?=
 =?utf-8?B?YlNoajYxdFBnZEFRTUFSMUc0YlZXME5MQnhlTDJub1FSMktnYnNpb1dxMllN?=
 =?utf-8?B?TmtxVWZncFJrNUIrQWxZSkh5aTNVTlh4L3p3OG4vOGhqYTJYK1JzYnBLVHdq?=
 =?utf-8?Q?NMgX6RhCkqx0xA/s/Fwsh+5yk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44450f3f-41f1-4b03-3122-08dde5268b59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:46.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2E3o/vDKHkPK5XXMApOU41bUMP5kSx6Y++BBGfh9s3rXMWNAwywofiAVK4Fk9O2wpQrDRT1E0ciAYuYmL3UfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355

MISC protocol supports getting board information. Retrieve the information
from SM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 220b9369fb537306f9e1a105930ad4d65e6b10aa..f934b4fbc6ec9f1e6b24d1c6c8cd07b45ce548e3 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CFG_INFO = 0xC,
+	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -76,6 +77,12 @@ struct scmi_imx_misc_buildinfo_out {
 	u8 buildtime[MISC_MAX_BUILDTIME];
 };
 
+struct scmi_imx_misc_board_info_out {
+	__le32 attributes;
+#define MISC_MAX_BRDNAME	16
+	u8 brdname[MISC_MAX_BRDNAME];
+};
+
 struct scmi_imx_misc_cfg_info_out {
 	__le32 msel;
 #define MISC_MAX_CFGNAME	16
@@ -316,6 +323,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
 	return ret;
 }
 
+static int scmi_imx_misc_board_info(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_board_info_out *out;
+	char name[MISC_MAX_BRDNAME];
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_BOARD_INFO, 0, sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->brdname, MISC_MAX_BRDNAME);
+		dev_info(ph->dev, "Board\t\t= %s, attr=0x%08x\n",
+			 name, le32_to_cpu(out->attributes));
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
 {
 	struct scmi_imx_misc_cfg_info_out *out;
@@ -371,6 +402,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_board_info(ph);
+	if (ret)
+		return ret;
+
 	ret = scmi_imx_misc_cfg_info(ph);
 	if (ret)
 		return ret;

-- 
2.37.1


