Return-Path: <linux-kernel+bounces-774473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A1B2B2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CA6628170
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98321885A;
	Mon, 18 Aug 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/elJCd8"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F617A318;
	Mon, 18 Aug 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550113; cv=fail; b=plgDS16ErUv77FhLLvlnb90zvfz2pohOYG+oIXtvxTLdMliQ3sy30RtnHfmfYLubX+ansMjyS/YqdCus1+rs4p7BYzgf7vWSGG9mfHrWYHk20NpFkdUtr8w7lo9zgO3rxIIoRvnKezgOLYh0PwwDlXAeasbdDuf9X7gHpMd+isM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550113; c=relaxed/simple;
	bh=vHc5MnY6LuxMwIPS2sP+EGm/J6SUcbG18rdiyySGu8w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GRsWfcGAuXm8tFluB8HJaCij+fiC+Jug8cjbgEbCUaiJuh/4cu9eR3ywRrVA5KnuLian3wMCOvFR9jYZMvb/4imqFp/7G58fzfPxxW1CHy15PttBcQcuOBWMGNZ2nC4JK1FxBGoZmyIRHcvUS9ak/3E/NnJTRtEibieD3pDasM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m/elJCd8; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijzTrm/ZA6ccT3scblgfGQhvFvQYc9cLpEUVVf4tbsd0/eZPWpKLxtDrjtz/1HCGET6gasi/gvDYVemDIhOfrIhsK0ZNgRd9MqKrYx7oQGj4XFFkK5EA+xZXYJu5cuXRLXg/1SDVxBlFsCe8bADJSRlDxZrd2VaNsX0bxH52BqMu4+8nUcBj7J/QKK3LyRCbZ3N6gBxPfExwi7vwXKEFz1EcaxOkjTug6HMcxn5QJSjrbrnXdLOaP+x9wsAqKBdV7x0ZCbDwOQMGNow6MMbi4SUfPXfkfED0y9Koiso/KoEMJh69W4gADnoAlUJut6RauIfh4H0giM+G4TB1uSwWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS22NGJquno2Sa3Ig+bAN3T/E2uDoMHcsuI6WlpjdzE=;
 b=JOG92T/6T5NKDFYZhhxz+w0A4ysW8w93Ft3AMeK1sTD6yqqv4Dy5V/Ex+R+/87nAPAf25D9xTo9UBEy9YiaEtV+oya4m6lRdnkH8wpdTWXO1aVPA5wYPutRrHCJEQ+zzs8cm0sW8UEBgnHo7HPljIqjhV7QaBcWiPx8TH73ZY1xWR0TYcwSom5WObC2DJhW2w0BMi6OR4g4nW2YZI0liBolrSg2VvzH61M/6AVxFtvi9JqWYXBoBZrsnHQld/xUskiGegSiejwx8xgLTo8A04KDVffqH3VKsheue5Kgn757hchMat1vUCwpysnGSXMVKepKajAzzA0vHw/eqoBQLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS22NGJquno2Sa3Ig+bAN3T/E2uDoMHcsuI6WlpjdzE=;
 b=m/elJCd8a1UW0/h6FN1ZMGWUFTqnVH5DiNMe51VTr4lpMEcUv7Qi5VILwzenacHIpwDt17yBOrmlovQXZiDD2VPHfHE2L42da4zdLMME/5MMrwZSj0eTRFXP9KUtVFbofN/SUvABx1vEv97xjeUbKlq5q3UkFITZCBYcMF2VmIoS66pKTbZbvARAKsuRekaAdzsGBf4ZkF8YVhss/4LIJIyfmAq2gjIAQEPakNfAiT/kKTQbVslgPs26YKOjG9DbSJ5Qv3m+BFg+n7GRUJ57yEKVjntYb/9ZRA+2HEcuJ6dbwbR/Z1DdoPSfWv2SOG9tMKJuVo6vr2j3WI/3IGzMOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/15] ARM: dts: clean up most ls1021a CHECK_DTB warning
Date: Mon, 18 Aug 2025 16:48:11 -0400
Message-Id: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIuRo2gC/x3MTQqAIBBA4avErBP8IbCuEhGWow2EhRMVRHdPW
 n6L9x5gzIQMXfVAxpOYtlSg6grmxaWIgnwxaKkbaZUVKyuplRv9wePlcqIURQihNWby1ngHpdw
 zBrr/az+87wd5stVGZQAAAA==
X-Change-ID: 20250818-ls1021a_dts_warning-fff933bd83da
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1846;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vHc5MnY6LuxMwIPS2sP+EGm/J6SUcbG18rdiyySGu8w=;
 b=84RYG1Galsy+jgRunLNb8moKdvvMeTDKuW/CZlUukXjHaqPKtfm7vAC6tLoNvKoxrvbjkcA43
 PE+WNDr0MZTBFcl0Fo/xltZqZGhwa3XCGeF599NFLfPjWcOY1fPlnwD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba67f3a-7f2b-40e8-988e-08ddde989579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck5iSzVTQ2JNQzFObm13Z1ZzQWRUZjFyNk5NbWo1c2tQdHVCTWtVME16aXdp?=
 =?utf-8?B?d3NhM2lFbFRMNG80QlFWaVhSZVJvVklwZWtVVStRakU0MnZvbzZCV1Y0ZUhh?=
 =?utf-8?B?ZDhrMjNMd0MzMFJHTC92ZzVqZjdwU1hsSXp2WjlQbWxDQjFhL2tjNFVWak1h?=
 =?utf-8?B?aFVlWTRaRDhBNzBRcytnejRnbGY3NVA2UVdNaDlOcTZlSFR3dHpiYVoyOHZZ?=
 =?utf-8?B?TnRQOXFLRVRJK3o4N0JhR0VPMEwzNXZ1WkY0ZDRnMG5VdFNGUFVjbzk4TWw0?=
 =?utf-8?B?QWdNSWJvV0xWd1FWVjZGZ0p5QWJFRURkdGdQRFQ1aHZ6RCtDODVoVHRoRUJx?=
 =?utf-8?B?UUNPU3dETmR0Y3g5RDVNV2IwRTFSTHF1bTROeitBTHBXQjJ4Z2ZhdTN2UU55?=
 =?utf-8?B?bmJVV0V0UGlmNGo5N1JtU1RJZEJNdlFNS3FmWWxyYW5EVU5OdDRBREczbFFp?=
 =?utf-8?B?cGQ1U0lKaldaRDhRMDFkUUtaUC9ndEtaUUhvQWgrUXl6K09BZUpyK3luMWtE?=
 =?utf-8?B?RW9Uc2RFd0ZJUlpmYmgzTm54c1JldEdWaW8xeVFKbnBtSmVJRnVYUUdYcS9O?=
 =?utf-8?B?ditvSTNOYjM2WFpXczdpZE5sZGtSYUVocks0ZkYxYU9UKzhHVHZLTktQZlRZ?=
 =?utf-8?B?RnFKcitqa1kyY2xRREVIenkydzBCOUVuUmx0dDhRRXJ6SlpXU3BRY3RuNnNT?=
 =?utf-8?B?R284Vk96dk5DTmlNVTFmWnNIbElIVytlQU45S3RDdFFYdFFCaFpqUHVuKzZC?=
 =?utf-8?B?Sm9ackRpRzRQQTE1YlpkQS9hYjJWZHZvbGJ6UGlnVzVKYkZ1YXcya0RJZXdV?=
 =?utf-8?B?aG8rLzZFekwzc2RnaG1UdEFkUjA1dUJoWjRKMnJ3c1k2WnZkVWhWRlVTS2t4?=
 =?utf-8?B?OCt2NFUrdDcrYW1aWmx3S01XRXJMbVpNZ0hrdmZZczBGd3RwOSs1cEFvTUVl?=
 =?utf-8?B?ZmhvMzUrNW9qK2cxQU1EN0t0QUlKeHVISFBDTEtOY21JSUpSQ3pkejhLb1Vq?=
 =?utf-8?B?TDNuc2RjcTFacW5YdlkvWXpxZmpFbVBsR0pVK0UrNGNvTmQ1WGN6a2tjNUVK?=
 =?utf-8?B?cnFpZ3hXak1YWlF0S3JVOEthYysvTGI5eUMwR01NNy9hcEN1QWlEK1RYTkNm?=
 =?utf-8?B?bERTMEVmaEZBV1hSQ3dhaVVJQ0Y2ekxFWFdvbHlieUJoQmI4NGx1RHpmZlM1?=
 =?utf-8?B?aFByeS9oaGYvWDhZZWlTaXY1SUZhOE1GaDJTc3N3QmtXajJXWHV0cU5aSDBa?=
 =?utf-8?B?QkhRWHVTbGdURGkvRFRieEdoQnRmTzBOTWJjdndGU2lpVkxFMnVISXJXWGN0?=
 =?utf-8?B?QWFZczJJZFVtN2hCV3phQWF4TlFxcVNVQUpHWGNhUE1jN1dOK052REM3cEhn?=
 =?utf-8?B?MFR3R0JDWDZwMUE5WnI5djRhTjdHTGtWbzEzR20rc1VtQ0JheDZ3amxRSFNu?=
 =?utf-8?B?ZnFncHlWeW4zSlYzY00rcU9wZGpmK2hqVzFOTjcvL2ZiN05tMUpYMUYrYlJs?=
 =?utf-8?B?VEc3NjlsTUhXc0VtNFdQVTNwMmZzNCsvQXhvNG5oelNXRW5HWXJSYTRvdmdW?=
 =?utf-8?B?ZXVUNEJzOVVnVHB6WTRZUXZWZFJMTm80MzN3ek9mL3ZtRjBDcTFqblhRY3VO?=
 =?utf-8?B?SzlkdGxGNG4zdlZ2Q1NidmtIOC9wWldGL0ErbTRKQlpBbUNNajZOeXJhMVh1?=
 =?utf-8?B?STNJT3BETENVTDdacnI1MGdSVncvUEM2bmVEWjNUMk9Ic3VVaVhUMjd2Vmh5?=
 =?utf-8?B?aUJpZDdkeUVsc25vSTBUL0lWcDZvUVNBdE5XWkdWbGlzOFhHRlZ1a1RuNDF3?=
 =?utf-8?B?QnkvN2RCNnVnSkpVdXJrdVlFV1pLdEhpVUc5WFVBVjVVZUVhNGtEdVNYRG1n?=
 =?utf-8?B?dVdvc0NSMmFocmdac0xjdEYxZWJQR2QxcEhSSVZqdEFkTTJuZzZCbC91eHA2?=
 =?utf-8?B?RWxncVVWdWdWTlJsdEJLWG1JOGMyQkh1aTJhV1hSeWh2c1BudW5xQUlOKzQv?=
 =?utf-8?B?SDBjTWNrRDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZBWldqaVJGQ0FTMzROUVhjcGp5M2NRYlNwbGFMWFFtMWNTWUpucUppUzdB?=
 =?utf-8?B?T2ZVRGp4SjZHTjhjODM2UTMrQWFTL2FjQ2NXcDVQdjRKZ2Y3TWlVN2Y3Sm5L?=
 =?utf-8?B?REZwazd5eWhoQXJldlVPRWRmNG1YYWp6eUdXNllGSFRSQlhXUURlWUxrUmZ2?=
 =?utf-8?B?UWRCVXdsazgrMVhya2lqK3pNMnVZYnBQcFVOMHBvWjVIaDZFbENoN053dFRD?=
 =?utf-8?B?bmJEVDYwbEpJMWE3RWZ3azkvY2h2VGI4YlBVcVpzSjcxcXZUMzRiVjhRYjRZ?=
 =?utf-8?B?RXhLZVFCKzJKa0cvbDdjMjJ2dEpBWWYrU09lOGhHSktBc2I4cUpaZWhkN2Nl?=
 =?utf-8?B?TkJzcnJuVUJHN2s5MFBRVlJRQlZOQUFSK3o2MVNCN0NUVGhRSm1VWUk0cFln?=
 =?utf-8?B?dFZMNllSdm5OaUgybDk1UWo1eEl1MzBuM1NMRjU0VkJVd1JlS3k1c3pCM0Vj?=
 =?utf-8?B?T0NyY2Z6Z3htcjFWSkp4ejI1MW5QOSt3ZWpZcUg3R1R2bEd2OGY1UEJHVGlt?=
 =?utf-8?B?NzY4d0R6WHl5aUQ3TjlMU21KTDBMMWlkQTdkcldQeEw4TEUzYjAzUGNPd0F2?=
 =?utf-8?B?WjNDQ2ZIYTRCSWVwZmZ4T3JEYjR0Z0FiVG44UlRQa3AwUmdyZ2JGQ3VDdkth?=
 =?utf-8?B?dUM4OEt1VTV3Q2pCV2lUbHZnRFFMYWF5NHg2OTkyRERrRGZmMGdVRytzWXVu?=
 =?utf-8?B?cEMrbk5wNW9KWkczak43TGIzOTZkUlF3RFkzSHVxUldUc0hrYlZwOVJEQ1Nh?=
 =?utf-8?B?L2lvb3FCWjRGN0VLdEg1SHNFMTdCWGoxdkQ4V3BDNWdEclBuT3hBV05mUGlB?=
 =?utf-8?B?ZlJzRi91UDBlTCtsSE03cksrQTUyNkNBYm83MnZVWlkvNmNYemdCQ1VySVda?=
 =?utf-8?B?cXYyUTFDTWtPNU5vS3FKb25wRVVPdjVCVy9saE8vMUMwOGtTUERQYlBieWdP?=
 =?utf-8?B?MXlWRndFNktmZFdNMTV2TTgrR1p5ak5vR004UU5iSS92UGxlTzFjT2g1ZDJn?=
 =?utf-8?B?ZXFRUU1mdmRWdVNYMzA0dW1GRm5wdFM1eitIQ0kyQWgwMlUxbDVlU0t5aWYv?=
 =?utf-8?B?OWYzWSs4UjYwV0ZQeGw5WXEweGQ5eTAvdUFVbWgvSVEySDAzR2FrQ01oVWgr?=
 =?utf-8?B?aHNlcnhmdDVQQ0VvcHl1ejBuM0NSR3k3eDRHSE5NQUIxNC9wSzY4M2xIVFJX?=
 =?utf-8?B?Q2xyMVl2aTg5V0N5WWgrS0kzYS9YK293WFB0anRhRGFpWldlSEhUeFRxS21Y?=
 =?utf-8?B?RzRXejVMNHFldVpDQUZkbUJvb3RFRTZPVzVFd3RkeDlzWkMxdkFGZ1VTS1dX?=
 =?utf-8?B?N2FJd2xjMHcwNmFjYmZQWUdld3h3OGlqQ2R2eDVrSERpc3RaL1ZLSVZCRHVm?=
 =?utf-8?B?NXVwUXphU3BITW9jeXBiKzVoRGlWWGdveW10bjlmWjFKZDdlQi9ONGEvaUFM?=
 =?utf-8?B?WXRETFRmL1VkN0dtNkcyMzRjb3c1S0piZ1FYQWdMWEo4bkhHZGNLSXpWaExR?=
 =?utf-8?B?SlZwZ29zcTFNZ2t1Snk2NFV0MG5uaUxGN2J1OWp5UkpITEpFWEhpNTRFZGc4?=
 =?utf-8?B?dVVaZmNSeEVhYkxMcGowRG5FQWNaTjZrRnZHeDVHRTlsWld6RUlxYmZZMGgr?=
 =?utf-8?B?ZXZYSXNEYStUQWFlcjZjbEM2NDh1dVdPT01TbklnV1FCdXpyMnpEVGdmN0Zy?=
 =?utf-8?B?azBKTEhER1AxMmtUaGtIeVZYaG11MVVybE5iUzBkdEhNcmtWQjZXM1BvRjM3?=
 =?utf-8?B?YzZUL3R4bGhlMjBYeEpuWUg2WTJQb0VFVjFDNXFIK2hIcVk2R21Qb0R0SGpu?=
 =?utf-8?B?SWF4TlpIOUs2a0VEaE0zY2UwS0pjSlJ1UzF6MDIvWU91RWNDcllud2tOLzJU?=
 =?utf-8?B?YTgySkNxMzhXT2xvZ1BrMTdjZzhTODd4NEpzYnl5WUtMbkJaQW5qQThlWFhM?=
 =?utf-8?B?NGxpb0pXYlJYL2t5MUMwelVWZjJ4b2FISnV4THhWQjIrRnpnMjUrRTRKeFpk?=
 =?utf-8?B?K202Nm8yeUpndWIzWHJoTHNGU2pNVlp3UEZTczMwdDNBY0puN0lQT1ZzTW1E?=
 =?utf-8?B?M3pQV3o1YUs0Qmg5TjdtOStvTUx2ZmZZbVdrOFFNV3NZSTdqNUlZYmRJY2cr?=
 =?utf-8?Q?HIJ67KOKfP0Dg0vAzW+4Gs/2h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba67f3a-7f2b-40e8-988e-08ddde989579
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:28.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Kn+LuofoVRttdqmJBBKcSawEcDtPTgivJ/GIJ9WJWnAexWvznsp1nQMwJEiMdQL9AkEDoOLnhw1TwZ38PGi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

clean up most ls1021a CHECK_DTB warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (15):
      ARM: dts: ls1021a: swap dma tx/rx channel to fix DTB_CHECK warning
      ARM: dts: ls1021a: correct node name "timer0" to 'rtc' and remove reg-names
      ARM: dts: ls1021a: remove redundant snps,host-vbus-glitches
      ARM: dts: ls1021a: remove big-endian for memory-controller node
      ARM: dts: ls1021a: Rename node name nor to flash
      ARM: dts: ls1021a: Remove redundant #address-cells for queue-group@* of fsl,etsec2
      ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
      ARM: dts: ls1021a: Rename node name power-controler to wakeup-controller
      ARM: dts: ls1021a-qds: Rename node name at45db021d@0 to flash@0
      ARM: dts: ls1021a: remove big-endian for mmc modes
      ARM: dts: ls1021a: add fsl,ls1021a-wdt for watchdog node
      ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet-switch@1
      ARM: dts: ls1021a-tqmls1021a-mbls1021a-rgb-cdtech: Remove fallback compatible string edt,edt-ft5x06
      ARM: dts: ls1021a-qads: Add fallback compatible string mdio-mux
      ARM: dts: ls1021a-qds: rename 'nor' to 'flash' and 'mdio-mux-emi1' to 'mdio-mux@54'

 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts           |  8 ++---
 ...1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso |  2 +-
 ...1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso |  2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts           |  2 --
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts           |  2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi              | 38 ++++++----------------
 6 files changed, 17 insertions(+), 37 deletions(-)
---
base-commit: 3ede6e44fad31f1c80dd01188683f0caa0f19247
change-id: 20250818-ls1021a_dts_warning-fff933bd83da

Best regards,
--
Frank Li <Frank.Li@nxp.com>


