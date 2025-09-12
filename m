Return-Path: <linux-kernel+bounces-813137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD85B5410F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E771B28157
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E025F97D;
	Fri, 12 Sep 2025 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g9WFt7sg"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4C25F798;
	Fri, 12 Sep 2025 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648185; cv=fail; b=cRpTRSmw5etV71OhIgLaD2+ewFg+kjPeTUBltBy5WQ/Qo2G3m29DX9cs1Y4BacQRHDG4lwAI7690Ip7/ePPLY/vqbayKyFf/go/0y5VgB9+ovLswBxsmsoQWPcXC9qa9muF4rW6sUczNSev5UyIveiCNVa8sm0OpY0CIkgWjmNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648185; c=relaxed/simple;
	bh=PeRl5P3IHKJMf909jjQ/u7GR9jCDfliupm8kEswxFCg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ktM1pANNOV+7Ag5rx10n4fTpgloSOZ68zFbYV4yWrM4y2VV8wqrWbCpCXoM4p9rA5bUqLO7XdXKn+f8t0cwrgJVa07gvngzzbf91gp/NKsVxcnQqI2a+mXsB9/5ufZ0gAvq59tKlZiSIH2rC8YaHxfJZlZSJERspiWUul+H0ZpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g9WFt7sg; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U339lnnkLxjZ/93wokE4UKnD8IFRiOOuy1qiCau4PkvAHe9D+rMKI7VkRpcGoCKDx7189H3qzxYxw69ufkDikuv+kGEVI21hh5XkL7lELfFX/30pPDWJeiZf9zCJC3otWhLZRS8OkSt0lIv6bDfJxh9lLF3JTDu6Iq7X7ehrTs8QtNsLwH01mxRVG/HPCBbaqBgxP4Svnp7D1EDJxau1eDrLE5eBu8MsfD96xDMckGenMKvFfsGeRuuEn9fJl30UTf6vsnVad5f+DNCHDIvNnDXjQ8keW9I4trcICQdPRs7qi5AGVGLiWt/tn625R6Diy+4bTpzoagOzygEH/dcIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RxnQJJTFP/qar4FBocvrDx36TKm9SbCky48kLKdZUQ=;
 b=LElaie30am/clwXl7UsRxSxeQWw8BSL69nglME+PNuTm4q1rWZygAZrPSf8ZeV/IA0UP8HaQNS24UuBBYFdCjkck0UHlOYG8cpBTqNe5OaxgBdpAZm19+K1IMGbo+P2nJ5IEKH1JjOowzh9csp+XTyyGFjYPcBjwo8RwzObzrBiekbS7HlKmpJ8/dneLvmwvdZdi30UFA8cou8T8Yzzi4LvnVSgEOI7XAnjKNgEaX6hLPxZLNgzs5VIcCNvVai+21FYVXWQlBJcvEmOOXGeE454r3RcYQgxiCPjb0k2hSZWMNgEiVVxTT51IlAUK3+1nxPUVdrfSn+oIKubtR3h4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RxnQJJTFP/qar4FBocvrDx36TKm9SbCky48kLKdZUQ=;
 b=g9WFt7sgQ2j2qIqwHRQotdzFY4TUXEU96faO58wKE6LVBKcjuTE4zNB6Vli2Vl9/4nvCsBNRc0ONJDa3QKGk8gh8MOiH9QbSA7JiD0BTsEhuEpwkbtet8Z/MsT5xAq8/4RlbFwrUCYUYqnaLIuD6gmf6AQOYfEVGJqCobzQ1pHKK+rZdi3fBUqtZ0s8CnZgAwrf8+W/Ugnzn3klJFLalIkyu+UdBpko98Zctv7MG2B7az25WX5LtX50MUCSHqN0urlmrPFyrx3JaOaSbFqqCPlgBWvpxL3p+qfeUFqr6tLh5GnjPADZJqNBVxWv8XbaLb/rKizsm9M0UMfTv8NArmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 03:36:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 03:36:20 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 12 Sep 2025 11:35:52 +0800
Subject: [PATCH v3 3/5] clk: conf: Support assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-clk-ssc-version1-v3-3-fd1e07476ba1@nxp.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
In-Reply-To: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648158; l=2996;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=PeRl5P3IHKJMf909jjQ/u7GR9jCDfliupm8kEswxFCg=;
 b=lBVA4hut+3a4jdhoiDzhNbSrinwuj3VN8qqvE9uT9caO6Gf2VCrm4sNExmPcJa5JDWuJR9ZNS
 v6ECKpXtS/pCFplY8usYRBg2EsoZSNvxr0NQrQ/JpAHpkt35WN0wbMr
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6191559c-fe79-4b8e-a0aa-08ddf1ad8972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDBubTdnUnZOV2xhNG4xYnlMOWdqT2ZjZ1Z1WkNjek1TOFFhUnIwbUJnbG9E?=
 =?utf-8?B?S0lNZ3M1cWlFekliYnFPQUR1UkNSVWZEZ053eWE3S1g3MUpMVy9EQ2EvSUtP?=
 =?utf-8?B?UlJ4NmxxMktPaXhvZGFPdFFPbC9mcjNvYzlFY0J2MzYwVWJZWlFWRVMyZ0I0?=
 =?utf-8?B?Y01XRTZYVjZzY1NpemR0TU1XcHpsTjV3RUgwMm1KMUxsVmorTU9qWDlibWxq?=
 =?utf-8?B?Ky9BM0ovdmNjZFZ3RTZvVVduMThXc1oyOVZxRy9JUkxuaDFJbThFSk5JY2JQ?=
 =?utf-8?B?VHJKd0RYc01GelM3VENHWFlTTHdISzlIb1A3WHdvcE5hNWJ6V2NWRjk1TTFj?=
 =?utf-8?B?bXRYMHVMSWNTSGpkZGJiYlBlekJjc3A2ME5lalAxLzV1Z0NxSTduUUV4U1k5?=
 =?utf-8?B?eUVLVnJSRDVVZGZMYzlOd01La1YrL01aMWJqRGdjMVNPazNObU5scHlybnNl?=
 =?utf-8?B?YUJkMmpFMWZRd3BLbkxQRWNTbHVubkcyaUVSK3N5U3Y3WVJEamlid1luVWdN?=
 =?utf-8?B?N2FXSzJJcjNtVU5LMHRWa2pwSEpycFowdkpXS09uVjZSUVFmcGlxZ1lYZkls?=
 =?utf-8?B?TXk0a3RNK0VXcEhwa1I4c2pjWVdoL3ZadlJML0F4WUk5TnR6MEttZjNxSkJL?=
 =?utf-8?B?bjExQVEzdXpBanYxSmpiL2VIa2Z5eVBXR3k1UHorRjVvQ3RYeUZacVBJN2Ew?=
 =?utf-8?B?allKNGgwOGg3bW5NWGwxQ3ovLzRRTmZNQ00rd3I5N3hWUEwxQVdTazIvNlda?=
 =?utf-8?B?RUcydlJPZnVrSTh3M01lcVhNYW9aMDFxZUxzcWNqd20xN2ZXYnNWT2o1MXB4?=
 =?utf-8?B?YlJQck53b3hoNVBCUlkzclhCQjc3OE9KaWhOYzJOZ0xXbEJKRnNCRUxVbGJ6?=
 =?utf-8?B?RE9mYXFMbDRaVkpDaG5FaE1aNWtFaEdtWFFoN2ViTm1qcUxFNjBSYnVSWHN0?=
 =?utf-8?B?a1lVS3c5d08xMUR4QlIxMUFORGptQVF3TEtOLzhTZVljazFzZlhtUS9QWURY?=
 =?utf-8?B?NlV1QUkzRjM5eG9rVC93QmhRUW5lTitPdzk0bGhZdTJsQkwwWDhVTnMxbUhG?=
 =?utf-8?B?eGpwZE1sWXBiTWZCeGU2NXVPcXNNNDlocVByQ29tQmZ2TTNDSCs3a0NiUFpL?=
 =?utf-8?B?eWpRN2FPTzJzTGlOS1VOSVp1TTBaUWtNUDlscG9kalFGT0FvUzRPaWwvTGs2?=
 =?utf-8?B?UFp5NEJxVW1adm8xUGZYYm53S2REQTZyWnZmS1pZYWREd3dDTFQxU01uQk5r?=
 =?utf-8?B?Z2Z2aXZDb0owNWdKaG12U2YxVEFGVnJWKzAzalpGL2RwbEViZ1RtWmlwS3dE?=
 =?utf-8?B?UlR2NVFmbDRjWk13SFZTdzArK2xBVENxTWtHaWdob1k4Qm1jK2lvTkZEbzIr?=
 =?utf-8?B?eTJCcXVva3pUWGs3YUgzYVpQcEV4dlQ1TWsyNTM4MEYyZUxvSHdjZEIwc3di?=
 =?utf-8?B?eTNnV21ncFhZOWV0cUdPem01RVh5WmE2eEpaT0VuVDF3UnNPL24zNDhpMDJ2?=
 =?utf-8?B?aGNOUzdMdmRCb0dCUnh0WHNKMGpqQm5wd1BxMk9NUFdMM3gzZ1RZZGp4NUFT?=
 =?utf-8?B?V3Z4M0Z1OU5OaDU0ZTRsQ2tEYWlySDVJR3YrU0NjeVdHTEJFM2VNU3NHc0dh?=
 =?utf-8?B?RXk3VHVvQ3dGVDRMaFhWZlhOa3A3NUExVVFQZllneVFRZWdlZ1BmY1hLWGJz?=
 =?utf-8?B?UnZRNS9lZ2UxYjllUUFBSHAzaWFkVzhtZDljRjZHcXZjc0hMSHVqRzF4aHN3?=
 =?utf-8?B?Rjd6dlpsQ2FxUkJ3UjAxMFo4UGRURXBxaDZnOWhLQkFwMWJHKzU0eC9EUlFk?=
 =?utf-8?B?WG45VzlyV3h6Z3U4dUYrRENTMERYMHRLV0dnbDF0MWpjbXFDaWR1NDRoZmUr?=
 =?utf-8?B?dlZnY3FjRFIwZ2JxY3BHQzBSZ1VBcGJIQVU5cHNvdEY5NHZlQjlIZ0wzRzRO?=
 =?utf-8?B?SThDQ3c4SmU5OE9QNDFFOTNyOGJzOWhvckpNenBYQUxJTnh6TDF0OXhlK2FU?=
 =?utf-8?B?VWxqOVNlaVlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm55bDRhVnRaRkJuRHAwbzUwS1lFNG55Mm1pTzE2S1Urc3RZcDVicDFJMUUv?=
 =?utf-8?B?aWkzK0dYdzhHeG4zMTdIaHdiYWticjVMbVlmNG4yTDVUb2FPSk42NG1Mc2pD?=
 =?utf-8?B?S3BoTnFqa1VJZkovOU1QN0pzYmp0bnRYc0FvOEdTeDBkUkkxVHpFVUJ2cjds?=
 =?utf-8?B?OEFESXNyTkJKekVud0JqNG9HcU95ZGtwVUhXZzk2OGNmSnVkK2t6OTR5aTc3?=
 =?utf-8?B?R29lRnE4Vzd6RTJjMDlXR3B2UDZxQllocGlMWDkwNDVtM1VmME1nSU0ra3Uv?=
 =?utf-8?B?cE8zTi9DQTF4dXpzenM1ZmpjWXBBdXlncm4zZ29vNy8wdSsvMTIxcVFlV1g5?=
 =?utf-8?B?Uy9tYUFxc0llQTIvcWdkZHE3Sy9DcG8xYTV0YWJXNkhUZVFPM0hqV3FKY1lJ?=
 =?utf-8?B?K20rVWVucVRiZlJDbzF1dDlMeFhFcmJuZWEwSTUyN0JNWENrR0dFN1lRZUZH?=
 =?utf-8?B?b3NmbVludldWT3VLK3dEalEvcDJ2MHlMU0Z0bW5SYnBCT1Q5eTlTY2xIQ0U4?=
 =?utf-8?B?K3RDd2xXeGNKTVpCRTZwZlk1WjF4MC9BQldBdHQyV2tEaHdjS3pFMVlPMTg2?=
 =?utf-8?B?MmlmekpLZmZIUWU5dncrYTA3Y0trd3IyUzRkL3ZZbVFPMHhSUDJ1N2lEczB3?=
 =?utf-8?B?QkUvQ05uemRWQ00zZWZ4bzZVN0doVlEraDZuWi9KTmdqNUpSZlFtNHAxc3NS?=
 =?utf-8?B?ZXNJcWJYVFhQd1pma1o5cXRTQ29vY25PZmlBeVRjRHNUZU5XTkJ0bHhWaWs3?=
 =?utf-8?B?TVNnUmc1Q0VVSXFNWjV0Yjlmc0lRRmFRc2hod3JXUHhhY0J4OXhMdUM2eWp3?=
 =?utf-8?B?bTF3Q3FMajdqM2diSHRDOGhGZGV2VzdNd1RYTFBRMEl5TThOSXR1aWtRZ0dK?=
 =?utf-8?B?NVFjRG9SV0l0Q2N0Zmx1cm0zTVVIdmRPSEZDSDlCWGNJUE00b1lSV0Mwck9h?=
 =?utf-8?B?US9WVmw4bkVUdzRjYUJnYXRwc1JkVmJXZHN1VUtMS0xnL0paeEtUT3g0QjJu?=
 =?utf-8?B?U3FGbVo4K3A4M3lTaStwdVhqeFU0alFHM0Y4QW11K21lRDBkTFloNnV6dUNV?=
 =?utf-8?B?ZDNOZmdZTEFZV3NHSEpRaFJybktuZGtPU0tOcFk3eGw4RjlTeTg2NXozcWc1?=
 =?utf-8?B?VkI1V1ZSMU82enlzUE50L0RxL0l1YWRHVDE2UTUrWUpHK3AxNnZYQ1ZOcXVl?=
 =?utf-8?B?Mm5TYU5WVE56SWVjbXFRVUFXOGQzZ2MyZE9SZkl4SUxYOXJkQVB3RlRjWFVP?=
 =?utf-8?B?L3hreHlEQnZXUXBjWStTOVMvSDlMakN5YmQrc1BjN1lEMzJaQ05kcWNZdFhT?=
 =?utf-8?B?bXNCNEFSajd6anhMQVUwS3l6cEl0RnZyWnVpTlNic0FHMUhzbGtXZkhRM1Jr?=
 =?utf-8?B?bGVPaVNMSXdFOEh1WEtxTkdXemhLNkNLTEpnMUtsM3VIL2NZQVJKejV3STR2?=
 =?utf-8?B?SjV1aFg5cERZNVdOYVF2TTJ6NUhxejFHa1N4dUNJSnRCMUkvdVVickh3Nkkr?=
 =?utf-8?B?QXN6dGFyQmFQSU96VDhBdFRRUm1ycmY3ek54c1B4RUJ6NjBKNVd5b0pwbUxu?=
 =?utf-8?B?cUo3K0RMZFE1a1V1S3Roa0NBZlVSUldFa2UxbEhDMFJWRTBGYzdId2w1NnBu?=
 =?utf-8?B?a2VzcWszUWhpLzlHUkZTa21RUFN6Ylk5ZHpnQXQ1L1RrWWcxWlBwVUpsUXRn?=
 =?utf-8?B?VFZkd3dhMC9YS3ByU012M1E0Vk51VXlJYW9yUlRaek9VRWo4T24xMnpCdlp0?=
 =?utf-8?B?NU1NakhuaFI4VGg3RFZHeFFWcDJseXRkMXpJYUF2QzZVaWwyK1Rqd0NmaXZB?=
 =?utf-8?B?QUZTOGJTK1BJV2xpbDBWTGY5NkZEV2IwN2RsdFZZd21HakZGTXB6RHBjYktr?=
 =?utf-8?B?RkFBZHpGSmdVN3hGVDdHOEdOT3RDV0xwWEZMditPL2IzOVlkc0JjUGtGVlJO?=
 =?utf-8?B?TzZGMnkvSnZKa2dDNEpkK1o1b0x6blVLOFMvZnpwTzYvNTBtYnNnODJteWVF?=
 =?utf-8?B?d3JHK0RtTjIvUm83TTBxUG1QUU9wQnE4cG5oQmxudVU2T08ycXFrM2lUSlFM?=
 =?utf-8?B?MElrRXN0UVMwbkFuckxOZG54VUxRclVTYjZEVnNtNk16TEkxRGlEZEVxbUND?=
 =?utf-8?Q?AIlX3SSRVfHHqtkaTQOIQR9Xf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6191559c-fe79-4b8e-a0aa-08ddf1ad8972
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:36:20.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7mrYDs9NXetIKT89Cd2/1fOM3nea0Ci2lQegbMOrsQDaHxxSrBuX+tJ2bdpULpkp8+N6qVIYzAr8qhUK3CDlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788

Parse the Spread Spectrum Configuration(SSC) from device tree and configure
them before using the clock.

Each SSC is three u32 elements which means '<modfreq spreaddepth
modmethod>', so assigned-clock-sscs is an array of multiple three u32
elements.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..dd6083597db3f8f27d86abf5640dfc3fb39a9b88 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -155,6 +155,71 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
+{
+	struct clk_spread_spectrum *sscs __free(kfree) = NULL;
+	u32 elem_size = sizeof(struct clk_spread_spectrum);
+	struct of_phandle_args clkspec;
+	int rc, count, index;
+	struct clk *clk;
+
+	/* modfreq, spreadPercent, modmethod */
+	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
+	if (count <= 0)
+		return 0;
+
+	sscs = kcalloc(count, elem_size, GFP_KERNEL);
+	if (!sscs)
+		return -ENOMEM;
+
+	rc = of_property_read_u32_array(node, "assigned-clock-sscs", (u32 *)sscs,
+					count * 3);
+	if (rc)
+		return rc;
+
+	for (index = 0; index < count; index++) {
+		struct clk_spread_spectrum *conf = &sscs[index];
+		struct clk_hw *hw;
+
+		if (!conf->modfreq_hz && !conf->spread_bp && !conf->method)
+			continue;
+
+		rc = of_parse_phandle_with_args(node, "assigned-clocks", "#clock-cells",
+						index, &clkspec);
+		if (rc < 0) {
+			/* skip empty (null) phandles */
+			if (rc == -ENOENT)
+				continue;
+			else
+				return rc;
+		}
+
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
+			return 0;
+		}
+
+		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EPROBE_DEFER)
+				pr_warn("clk: couldn't get clock %d for %pOF\n",
+					index, node);
+			return PTR_ERR(clk);
+		}
+
+		hw = __clk_get_hw(clk);
+		rc = clk_hw_set_spread_spectrum(hw, conf);
+		if (rc < 0)
+			pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
+			       __clk_get_name(clk), conf->modfreq_hz, conf->spread_bp,
+			       conf->method, rc);
+		clk_put(clk);
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -174,6 +239,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (!node)
 		return 0;
 
+	rc = __set_clk_spread_spectrum(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
 		return rc;

-- 
2.37.1


