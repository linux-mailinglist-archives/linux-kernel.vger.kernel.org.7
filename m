Return-Path: <linux-kernel+bounces-783081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6013B32927
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43731BC0246
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0324168D;
	Sat, 23 Aug 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ppuUxWB6";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ppuUxWB6"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023075.outbound.protection.outlook.com [52.101.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23752586DA;
	Sat, 23 Aug 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.75
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959338; cv=fail; b=kwfo9QZZin3MDrW/3nVo0zRgdaRqOcewunJAXSv7x4EFLIC4kJPnyPAzPcq+/2vuhWQ9xk63TilXWfJxRHdm2U4cxTpVqOMyN75CGwU/PDSDBiEtp8AxRLWJEmrFNSYqt35377Vw0uw3PJYGllN7ATjFgE34muJ4HRcdzHIOfuk=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959338; c=relaxed/simple;
	bh=QCvjG1NzHbhCAt+BrtLXSgKLtioijGk53EmFJntmyHw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fl6XA0agGWJriTCNwP8+Akj+pdnRjiyUFXglIB6Hup9PeLyOG+z9wpshu97ZXTdbdVMjF0YWmjo4/j/+ZwTpbH0o6AUiEzNw4ra25rYGWdqDYoHlz5TWMcFGKnUDLWNmKP74f7sR/U1WEQIEe4AYNsc+AfHwYg5gs95F8ldDLLY=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ppuUxWB6; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ppuUxWB6; arc=fail smtp.client-ip=52.101.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RRGqbnW0MjMfY66VdQJA5Lj0oCQwxAH53XSsAyYah+NkdBCFLLbdTH4Ib7huGI4aSfmqU/bR5aCSdOMjT89POiQ9SgJcFB7yRNoBTIZBG8V00sy211kCz3fkDdphj+6PmpFjrfCwSnN7zZFYbXiKwNlcugTAA8Z4fM9e+idp4KUIzFp13yyr1X0qrRMOoYyPpKeSZTV9mJFg2Y6Ri8BmPyveXSYqjD2TXA5BNVNmMN4xIWP5dWCBvKcObChl1tqi0VzvVOnopk4xQo1t01dVtIObKzizDnat+/vCnZ8Jf2p/eToIKShQQ1FJfvMQqJ8C3waRprSXkBSMN/8Koj4Iuw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1oueR60hAxeMFxMf6NUdBIxyhVIwUGAYBkxgHQ3Q6A=;
 b=HieOXgbLlxJIXWqVsLNWJOe9TZK2ge53lR33BB/eZdrhalILMuBP4dtpEx8aqYYQjySdWuK97fyCUlWBBLR3p+kGGrutZhKkvPsaCkAH+lgzj8OXS7DHnBjUNSocaG3NKCKUJt7Vf2gcvFPI4RqoKf18KOQyyILxKigZ3NkOMa2adnwsT5345tM3nHq6MGB3esTSaGHWpRHydCvEN121Wj9PX/WR2cR03slibvJ8lW0IOlrGQdiju9wvyxYPr/fdMPdri4thlerK6+ZGAP1+fUesDlfqgklkru2I2uG3BqQBnt6oaI6UlBSs+gcRSeYGAA82M6ga82ZcNBEhqSI1Fw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1oueR60hAxeMFxMf6NUdBIxyhVIwUGAYBkxgHQ3Q6A=;
 b=ppuUxWB6Q7KBF/PWlkPasv4dclArSqIS8SDWNfzBhVwPkq7IbJB2fabhYgfnJA7t9EMPxRTpIbq0rYAW/MvFX+vTA9c0ONESKMthWyqfrWQ9oRpH2GY+DApkBt3aJ/iUq1OMZ264b3tCwhTtXtLaymcVxX6kz0D8mFB7/uu5lF0=
Received: from DUZPR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::18) by DBBPR04MB7658.eurprd04.prod.outlook.com
 (2603:10a6:10:20d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Sat, 23 Aug
 2025 14:28:52 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::14) by DUZPR01CA0120.outlook.office365.com
 (2603:10a6:10:4bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 14:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Sat, 23 Aug 2025 14:28:49 +0000
Received: from emails-9206919-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E13127FFBD;
	Sat, 23 Aug 2025 14:28:48 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1755959328; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=U1oueR60hAxeMFxMf6NUdBIxyhVIwUGAYBkxgHQ3Q6A=;
 b=ESBJFBQAGXc+iXu53HX5ME2XZhBpUn014em+Ba1PA23HAq0NvGRXU9ik43OnlJ2I+eTqs
 lCxhdbZqXL1h2dSkehpZd27SDzHlMhD9dW27vT/Ltkv5t2bmHm5BQejBgpv14Vw6FociSLg
 nUl8WJMTw3A789cSpDmzEuEG9HPacwk=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1755959328;
 b=V0vtN4md4gjt02WVRZmKGnhLZazTxlSaYc6/5LC67bC1AIX2U1VZ1pOnhZDL0gW6FFy6m
 B+F899K9hOI/gCxcgZQR9OV0V26XMOh8ssAC1ctVlsrHrzOR8G8K6QN15Y63+3bGmGCbT6a
 Iun6zBPdqMwij7/4lIUlFiRXLmz7Sd8=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1ZJ8j82iJAaS0d21iTOYLn3tdDNbFZqOC/AnUokcbJBaEWd2RP0ZOlYocNWQfF1ZjHGg8FIDmz9BL2U8aUcd4RltREVmUqiHN1yOsCP7pFdBZXQURv9MqGsZ1vpHUUF2jgAlB9jtNNN6BlCFA+BzMsUV6TDwW3/2HYvW5vboILrQcEDkEq9AHQqa43O/YFQWnRqxX48SRlsPqIwld8ghW95sMOpeBc0re2q0H5zw5DzeqwyO3saO+krKas+04wcN7jKEBN87kVAkUfYfnL1VSAXNro4CukstGGhg64LXQgU8gX25wvj7vcINvumMxvg2GSQoFjHHIb6u4NUC0ISHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1oueR60hAxeMFxMf6NUdBIxyhVIwUGAYBkxgHQ3Q6A=;
 b=HC8aZ8Nh6swOsxzfqxsIei+l+54jdPBompco7lLkaSEHs64rft0Q0MtbnU2UAbckq+UitFMeexQzVQ5cIFrzmrBpJDyGVDFbjYnm1vkLtKxR9x4RaUa23WTkJExM8KAM3D7H8i+P4b7QEeR6eB2B98+yMqA3IuzrlbtfcLH0EgDrcVi0EtHloHQoV17KkiG27M+ERTZy7c388SU/gY8YpYe38XJ4hOeiffN5BpB1kg6jSNg9c4ZeeVpTRjf/mrFjV8DzMX3i8X6eLZvBGN4I7Vzwm1cmo405ysF+y7Kl167fvnbUrLWbe3uXnTcVH5yg+OlQNY40Tg3SMATE1CatxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1oueR60hAxeMFxMf6NUdBIxyhVIwUGAYBkxgHQ3Q6A=;
 b=ppuUxWB6Q7KBF/PWlkPasv4dclArSqIS8SDWNfzBhVwPkq7IbJB2fabhYgfnJA7t9EMPxRTpIbq0rYAW/MvFX+vTA9c0ONESKMthWyqfrWQ9oRpH2GY+DApkBt3aJ/iUq1OMZ264b3tCwhTtXtLaymcVxX6kz0D8mFB7/uu5lF0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB11146.eurprd04.prod.outlook.com (2603:10a6:800:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 14:28:36 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 14:28:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 23 Aug 2025 17:28:22 +0300
Subject: [PATCH v3 2/3] arm64: dts: add description for solidrun imx8mp som
 and cubox-m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-imx8mp-sr-som-v3-2-a18a21fbebf0@solid-run.com>
References: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
In-Reply-To: <20250823-imx8mp-sr-som-v3-0-a18a21fbebf0@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB11146:EE_|DU2PEPF00028D08:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ddb7fa-3bc5-4260-0352-08dde251603c
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?T3FmSkVOYjZ5RCs4K3NuZ0ZSeUswZnVhVVhyaHJ0T3BwOVhyRm8yMzBhajlz?=
 =?utf-8?B?SmtCZXZJZ3luVkZJV2h4U0xKVnJpdDRpV3hpU0h4UEdyUnZ4TzNQWWdJd1F1?=
 =?utf-8?B?SUl2cGlQWXpPUEJ4bTkzT2V4V1hJam5FakpaQlN4czhmMm5mcmtLMGMzSjdn?=
 =?utf-8?B?RldlLzhsV29EdHhMRCtFejdHVHNmazM3a1FBQVk1OGJoSHRlTFBzVWt4R0F2?=
 =?utf-8?B?SFo5K2tiRnZRYUNxUWxRdzBKWXJWY0szS2N5cE9WUGpFbjB1akxtZGlxTi9r?=
 =?utf-8?B?VXJJWERvUFFzenlJTGRyUGNhYjc2dmxPWG5GbGt4dkROc1RqaFJuSVJWbk1F?=
 =?utf-8?B?eDZGUy9wcWViYlprbmV1cmhJaWQ4UDYrWnhNUzE3YkREWjFVTS8yUFR0Y2VM?=
 =?utf-8?B?T2daRG5CUmtyTVhBcVVNQzlPL3NsSlROZi9qbXNiTkZRS1h4YVVybC9TVStK?=
 =?utf-8?B?WlNHQU9YQ2pBVWF4QUtyVWR5VnlrNG52eVFGU0Mra3JUeFZmQXNRcEx0QmNY?=
 =?utf-8?B?OFBJTFBNaVY2d0ZIbzFmL0RHYVVkSCthR0JURHlHbVhZV0d1WVlPUTg5TGVI?=
 =?utf-8?B?QmVGMnJOb1BOTXJ4YmhBOXpnVHhRSXZtSFZLUjdDMHNES2EzSGdTSFZ3Nk9R?=
 =?utf-8?B?MmdHWlJ2cGJFNFo4ZGZWR0xyMWRibFZGZkU2cTdZdzV3dlpaaGZoNnJjVlcx?=
 =?utf-8?B?TjcvQmJvR0I2VUFQVnk2M2RLa3VjdlYwd3llWi9aV2pKbDZob05YbU52cXJL?=
 =?utf-8?B?Q1lnOGxJallSdk1DcVc0ZHdUT0FmVVdFbUt3SEZxMnN0d3ZmbXdZbHhBditk?=
 =?utf-8?B?RVk5MjVqOXRlVkdJdit4Qmd6M1pXU0xEUzFWZFpsU1JMakppNTdLdzB1VjVx?=
 =?utf-8?B?c0ZMMzFCRldjVHJaZ3FnMTUrd0xpRzZTdXVyeHJvQm55bURTUFU1cyszVmhR?=
 =?utf-8?B?U0E5OE1YVEM3M1l2RlpiTEpBSG1BNzBtM090aW13VXNXL2pmM3pMbGNTL3Qx?=
 =?utf-8?B?cmdSVVk1U1ZMbDU4ZTZ4Vi9MTG1LMGVURTZHVElpYnlaanYxYjNRSzB2dlZx?=
 =?utf-8?B?cUtaY0lHVERSQVBkaFVTMERLUVBvMTVUNU04M0pDK2JYelZGZzgyUDErdGRI?=
 =?utf-8?B?ZlNsRXNKRzY2VU9pTVhQZHpTUUl2d0lGcSs1Z0RyeG9ONjh2NWhiM3NJSi94?=
 =?utf-8?B?NnhXV1pBajJRZHZncGtLeWxWWTM3a25uR2R2Zmh2R0Fabm02QkNIR3FxdHRX?=
 =?utf-8?B?TGI2YVdGcFZJMk1yS3JtbmhPVFBxcXZDWVF2bmNrMmVUYTFGVXRKWW5WdWNN?=
 =?utf-8?B?NHNPbG1YUTVJektzVHdBWDZ3M3orVGxkNTdNS1l3Z0kvOUltVWtlcDkxVU1Q?=
 =?utf-8?B?YlMzdzhlL3FUdEtJV0w1Z0JKMHVNSGRSQ1VmV0U4NzlSdGhCNXRLWWtpTWor?=
 =?utf-8?B?OUVkRnZzYlBEbmNlamJwdHpnUTUyUzVyY210MXRLcldwdG9PaGo2SEJCK2J2?=
 =?utf-8?B?MG03bmN0Q016b2RrWkkzM3V6OE9vYjN5aVp2YzdTQy9UZVphWVlKb1EvL1Ri?=
 =?utf-8?B?SmY1ZlBacmJEQURKZU41UGhqcGNRQ0QybTZxYlhkRzVEU1VTSDBVWHBzWUlO?=
 =?utf-8?B?NEVJMTJNU3ZZV2FJSjErbXlrRU9ycmZIcXZnRGdRbkpSVXdXVkorUTJVMkdH?=
 =?utf-8?B?V3pyMDFLbk9lSGhlNzhyM2VHMENsbk5VSnMzdG96UnNEb2ZlYnpSSEJvSVhI?=
 =?utf-8?B?QzAxdjlWZ3pQUzZtRHBMdy9nTmhrQTBHRmI1eTAwb0MyNFVPdlFwNWVsK3JF?=
 =?utf-8?B?OWNEVEIrTXNvR0hxMnc3U3lLVVFrdFFKcjFCN1J4Vll3dGovSTJXVTNEQW5y?=
 =?utf-8?B?QklnSllqRzRxU0s4WXozWUk3Qi9TL3dMb3JoWjY1YXJRMFErS25lTUhTMnJE?=
 =?utf-8?B?MmJlc0NDd3pHYklSM2JKSjRGQ1JQMlVGRHJIWWFMeXUzcUF0QmlnbWtJWS90?=
 =?utf-8?B?STdKUFh4TFVBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11146
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b4ff019328ca46d5be20e574c6cc499b:solidrun,office365_emails,sent,inline:a9cfcf818f3381afc2c17a6361a4db5e
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0fe730fa-dc60-402e-8da6-08dde2515861
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|14060799003|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlJoNWsyelkxZWh3Wk45MWQxbm9UMTlzeWwyd3pBMzNTSTg3OUkrL3J3ZXdz?=
 =?utf-8?B?dHRaaWVCSTY4K2NjK1UxWXJZM0ZKZWZCZTFlWVlaMmJod2FEYVRCSXNjRHp2?=
 =?utf-8?B?NDRrVTd6VzBDcmozemppSjEwRXYrck9DcEgxUVFhczJ3NjkveTQxRnNJSXZx?=
 =?utf-8?B?NS9yQXRzck42UUgySFlnYVhtVXV5aUI2M2hPOHNUV1VxYkNFTHdQVllySTMw?=
 =?utf-8?B?UDVjb01HKzJHSzhHM3dPZUxRd1M1cktudlo0cStIM3duT0Nja2U0ODhPaDEx?=
 =?utf-8?B?aHlhT0hYeVIvY1czODE4VWN3dGR6SGw4eFo5ZGgvVEtOdVZJYnlhZXdlSEs2?=
 =?utf-8?B?YUcwVjlIT2xIVXNtYTNZd0tRcFRPM2padkNhcEYrcjhmYUVxNDIySForb2hD?=
 =?utf-8?B?eDVld1BTTXZoQzJja29DN2N6QkxpU092bnFlUzhVeGR2WHBtSmVqZ05pQ21J?=
 =?utf-8?B?UnR0eGZCNkpCcFV5QUdyblZTQ0NkcWkzc1FhUXpyTSsvaGNpYy9zak4vcUVW?=
 =?utf-8?B?MzFQdFc5Z24vbGxIb1NmSmhuQUpLTWRMc3FEWittdEp2VWpsanc1cGQ4ci9a?=
 =?utf-8?B?eTFKRVdrajhWdDV1UytGa0tvRVJ2WGUzNUtNYlA5TWJFRVo5R1M3STdNNGJ3?=
 =?utf-8?B?U1BjTE1UZVN3MERhR2xrdXFqWnNkSWkyU1RGd2F6UHZkVm4vNnpHZVltUmc0?=
 =?utf-8?B?d1NWZDFiVkdMU1Y0bzdJVVRVTzArd3ltcElDZDBpaHhOeXJ1SzF1d09XZmZj?=
 =?utf-8?B?cTZVNTl1NnNOMFZzcFd5eE5YNUZ3eS9CdjZBdWs4M202R1d6MllrcmlDMkJp?=
 =?utf-8?B?Ynp2NzN6ZDBGUTFWL1M4RisrZXB4WEZSUnVSaHRUL2Jzb3cyU0s2aXpFdUxL?=
 =?utf-8?B?UkNaUm1RazU1Y2g1eTloTGJTUE9Lc0g2TklaQm1EdEJyM0x4VkhZWm9YMFdW?=
 =?utf-8?B?NDNLSCtua2tCbEpCNHlNTENPLy9QV3pZL2lCK1FDV3o1K2Y1RDNuK2Fjakgw?=
 =?utf-8?B?ZFJ5Ty8zQTVCU0p0eGhGU3FBNmpFVk1SdFVnT2pNV29KeGpxT3Mrb1ZLeXBw?=
 =?utf-8?B?SmRYZC8rZ0VISVNQWlpVZXd6Sk5DbVFNTk5zejVmNXNtTFVscVdSTzlvTWda?=
 =?utf-8?B?NytNdUxOL0tzQnY1MDB5R3doQjBHV2RReGQ0R1h3MUdQMU1KbS9NTkpvbmp6?=
 =?utf-8?B?NGpmQnowTXVIaHpISjVKZEVIUUVKQlFIR0tJbWdEekplbUZ0ZlNydVNjUzVy?=
 =?utf-8?B?QldHeG0xWXNYZk1TZnpqd1hMdzJrOUQxRVJjc1o2OVFJTTY3dUZBcEl1bXpR?=
 =?utf-8?B?elZaQXJ3anBCbjNrUmd2ZGM0RWpXZFVLZjYwUjZTekdkQnVQbDU3L3NSbUp5?=
 =?utf-8?B?SU42bEFtZ0JGZm5xcFl4Z0pVc0JQME5FMHV4dFJ2Q2RVOUlGeTliTjRtQjVx?=
 =?utf-8?B?RDFLUlV4L2QvOGQ0SVZnTDhVTEdzN1FQbmczUkxpYUZHLzlVVWFTa0djcWRv?=
 =?utf-8?B?WE9INjMvZkVBTGFzdDExQzdpY3hTaTRIS3dubm1zVzErSWdKRCt3NitvYVVq?=
 =?utf-8?B?WngrcUVmb1ZzWXUzZDluSVdVOGlXTkUxa1gyY0diclVRT1h2SU5xWmcyQi9Q?=
 =?utf-8?B?Q1o4VG0xZ2FlYktHV0p2VW5wOG8rblBiTzI3S1Q2Nm5NUndCdStUelRvN0tC?=
 =?utf-8?B?dDRmM3ZVUU9lR2ZERVExK1d2R0xWbDNRK2JPTzZDc0V6SVhRWEIwek1nMHc2?=
 =?utf-8?B?dnFLQ0V3UklqT3l2cGJwbFBNd2lLUWh6VlN5eFJBTjExek9Na21wTjlCMWVP?=
 =?utf-8?B?N3ZOaHQrUkloOGw0RGtDUHR1ZW9kUGcvL20vNlp6UDNBOUFOeUg4ckJIYjlD?=
 =?utf-8?B?MWhBakd4cC9uMnFHRGFIUDFiZ1lndi9xS20xSVpaQllFV0t4MnBQVGJFZFJN?=
 =?utf-8?B?aVRvUmdrNGpPNWI1ejlObUVxRVpteFkrYVlqTC8vQ2ZtM1hOZlh5T3dwb0t0?=
 =?utf-8?B?ZU1rdTFKNjhxQXRNM2k0cXhrYktzWjFrbklpOW82bVk3N2Q4UGNWakFnYUI3?=
 =?utf-8?Q?8Zm+6M?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(376014)(36860700013)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:28:49.0792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ddb7fa-3bc5-4260-0352-08dde251603c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658

Add description for the SolidRun i.MX8M Plus based System on Module, and
the CuBox-M.

The SoM features:
- 2x 1Gbps Ethernet with PHY
- eMMC
- 1/2/3/8GB DDR
- MIPI-CSI Camera Connector (not described without specific camera)

The CuBox-M is a complete product with enclosure featuring:
- 1x 1Gbps RJ45 Ethernet Port
- 2x USB-3.0 Type A
- HDMI connector
- microSD connector
- microUSB connector for console (using fdtdi chip)
- IR receiver
- RTC with backup battery

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile           |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts | 223 +++++++++
 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi | 591 +++++++++++++++++++++++
 3 files changed, 815 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631ca8f9db65bec5c07b6a7a7e36525..a2c59c4308164e6be66402a8e2a181227ad6bd3f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -194,6 +194,7 @@ imx8mp-aristainetos3-helios-lvds-dtbs += imx8mp-aristainetos3-helios.dtb imx8mp-
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-helios-lvds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-proton2s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-cubox-m.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-som-a-bmb-08.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
new file mode 100644
index 0000000000000000000000000000000000000000..8290f187b79fd2b58fd7743c43cb7bb59426b083
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+
+#include "imx8mp-sr-som.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP CuBox-M";
+	compatible = "solidrun,imx8mp-cubox-m",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+		rtc0 = &carrier_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_pins>;
+		linux,autosuspend-period = <125>;
+		wakeup-source;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		status {
+			label = "status";
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+	};
+
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+	};
+
+	vbus: regulator-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus";
+		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vmmc: regulator-mmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc_pins>;
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <250>;
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c3 {
+	carrier_rtc: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	hdmi_pins: pinctrl-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
+		>;
+	};
+
+	ir_pins: pinctrl-ir-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x4f
+		>;
+	};
+
+	led_pins: pinctrl-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x0
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_100mhz_pins: pinctrl-usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_200mhz_pins: pinctrl-usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	vbus_pins: pinctrl-vbus-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x100
+		>;
+	};
+
+	vmmc_pins: pinctrl-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x0
+		>;
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc2_pins>;
+	pinctrl-1 = <&usdhc2_100mhz_pins>;
+	pinctrl-2 = <&usdhc2_200mhz_pins>;
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	cap-power-off-card;
+	full-pwr-cycle;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..4e6629f940bfade5d4da5bc4fc844c9a6ca2e98c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+#include "imx8mp.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP SoM";
+	compatible = "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	chosen {
+		bootargs = "earlycon=ec_imx6q,0x30890000,115200";
+		stdout-path = &uart2;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0xc0000000>;
+	};
+
+	usdhc1_pwrseq: usdhc1-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	v_3_3: regulator-3-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+/*
+ * Reserve all physical memory from within the first 1GB of DDR address
+ * space to avoid panic on low memory systems.
+ */
+&dsp_reserved {
+	reg = <0 0x6f000000 0 0x1000000>;
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqos_pins>, <&phy0_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy0>;
+	snps,force_thresh_dma_mode;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			reset-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <5>;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <5>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+			snps,map-to-dma-channel = <0>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+			snps,map-to-dma-channel = <1>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+			snps,map-to-dma-channel = <2>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+			snps,map-to-dma-channel = <3>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+			snps,map-to-dma-channel = <4>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fec_pins>, <&phy1_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0x1>;
+			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-1 = <&i2c1_gpio_pins>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-0 = <&pmic_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 GPIO_ACTIVE_LOW>;
+		nxp,i2c-lt-enable;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	som_eeprom: eeprom@50{
+		compatible = "st,24c01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-1 = <&i2c3_gpio_pins>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	/* routed to basler camera connector */
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&i2c4_gpio_pins>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&iomuxc {
+	eqos_pins: pinctrl-eqos-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+		>;
+	};
+
+	fec_pins: pinctrl-fec-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
+		>;
+	};
+
+	i2c1_pins: pinctrl-i2c1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA			0x400001c3
+		>;
+	};
+
+	i2c1_gpio_pins: pinctrl-i2c1-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x400001c3
+		>;
+	};
+
+	i2c2_pins: pinctrl-i2c2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA			0x400001c3
+		>;
+	};
+
+	i2c2_gpio_pins: pinctrl-i2c2-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16		0x400001c3
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0x400001c3
+		>;
+	};
+
+	i2c3_pins: pinctrl-i2c3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x400001c3
+		>;
+	};
+
+	i2c3_gpio_pins: pinctrl-i2c3-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0x400001c3
+		>;
+	};
+
+	i2c4_pins: pinctrl-i2c4-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA			0x400001c3
+		>;
+	};
+
+	i2c4_gpio_pins: pinctrl-i2c4-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20			0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21			0x400001c3
+		>;
+	};
+
+	phy0_pins: pinctrl-phy0-grp {
+		fsl,pins = <
+			/* RESET_N: weak i/o, open drain, external 1k pull-up */
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x20
+			/* INT_N: weak i/o, open drain, internal pull-up */
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x160
+		>;
+	};
+
+	phy1_pins: pinctrl-phy-1-grp {
+		fsl,pins = <
+			/* RESET_N: weak i/o, open drain, external 1k pull-up */
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x20
+			/* INT_N: weak i/o, open drain, internal pull-up */
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x160
+		>;
+	};
+
+	pmic_pins: pinctrl-pmic-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x41
+		>;
+	};
+
+	uart1_pins: pinctrl-uart1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX		0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX		0x140
+			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS		0x140
+			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS		0x140
+			/* BT_REG_ON */
+			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x0
+			/* BT_WAKE_DEV */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07		0x0
+			/* BT_WAKE_HOST */
+			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x100
+		>;
+	};
+
+	uart2_pins: pinctrl-uart2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x49
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x49
+		>;
+	};
+
+	usdhc1_pins: pinctrl-usdhc1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d0
+			/* WL_REG_ON */
+			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x0
+			/* WL_WAKE_HOST */
+			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x100
+		>;
+	};
+
+	usdhc1_100mhz_pins: pinctrl-usdhc1g-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d4
+		>;
+	};
+
+	usdhc1_200mhz_pins: pinctrl-usdhc1-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d6
+		>;
+	};
+
+	usdhc3_pins: pinctrl-usdhc3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
+		>;
+	};
+
+	usdhc3_100mhz_pins: pinctrl-usdhc3-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
+		>;
+	};
+
+	usdhc3_200mhz_pins: pinctrl-usdhc3-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196
+		>;
+	};
+
+	wdog1_pins: pinctrl-wdog1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0x140
+		>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	uart-has-rtscts;
+	/* select 80MHz parent clock to support maximum baudrate 4Mbps */
+	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		device-wakeup-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		/* Murata 1MW module supports max. 3M baud */
+		max-speed = <3000000>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usdhc1_pins>;
+	pinctrl-1 = <&usdhc1_100mhz_pins>;
+	pinctrl-2 = <&usdhc1_200mhz_pins>;
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	bus-width = <4>;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc3_pins>;
+	pinctrl-1 = <&usdhc3_100mhz_pins>;
+	pinctrl-2 = <&usdhc3_200mhz_pins>;
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wdog1_pins>;
+	status = "okay";
+};

-- 
2.43.0


