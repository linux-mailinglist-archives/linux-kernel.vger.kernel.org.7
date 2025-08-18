Return-Path: <linux-kernel+bounces-772690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF19B2961C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47373A4814
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32823C4FA;
	Mon, 18 Aug 2025 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlMHaWz3"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3923A9AD;
	Mon, 18 Aug 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480377; cv=fail; b=qz3WfAh53lXCBUkf3NUitevweb0ITbsU0uqszNoFFWPhGMfxe1MvNJORlA8i9vNgVDDKQzffGdeyQy5+IVNuoXha5lDz8TkctoDLMJxklYvN0dQKagygOu+0EKtR3ERzY1MEE2XpzpaF6YHOGwbdc4Bn3Lif0vMjf5BVFWuH7oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480377; c=relaxed/simple;
	bh=LRIkYgeahRrQ5MDGvVlmKJD9ac/LmIGd4LdE0X0xVXw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UufxBSoLGHeNf9ljZ9GHZfIV7wlUD/m8zFMsaBYIMNvziqA6R6MNIZEoYNc0C9aTmZLbXmNAMJ2vJtJEBKtc6DGG7mLA4mI9W8K71Us4PdLFoCIzCU3K/lhsLZBGeXtTQDBQDVDUzdSygoZGlVBIxkIEu+uPOj5GIIugEWamGsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LlMHaWz3; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsqWQMghoG+6qmf6kz5iRByCkRPS6N83szbucn1Zm+MCvon7RFWtN5YW9Sjt8mNfiUOQUUJcm+2f0erOboGNsAOWkPS1hsMJCH0J06bYkrQS1ivQCw2rZzY6BdGE3OazI0r5DtzplrLKCPzKFcSabUhJ+Yi4LS8AHXkCa2uaMorkp+86tCqke/0GI1PimfzAf7J0NeplSYu/Kx+4dQoQ+vJc99PZ1AORCksJWkxG/2np92P9C6OM4tPUAjATi1VloaYESRShhCxY0QqGmqMwLI5Cg7wJbEShgue+RqkDQQsT2ajkYu1Lm/w/3UMm09FreArvllvEYk5PyrtdIjiSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGgMW87f2zECfBQUVWlPoIMRHH9cwGhrPvN3m9AuJTE=;
 b=Nw/lc6DHHhjfF1bcrDfk2xVV/Cad2C5UtnpIJjvdaom2nnciDZTo8DWooTAxYLmj3u4A3ih8VL+d0KIo3/2bYMP+6OfIoB7i5wliNaCT3qKRZF5+FcQ8d6gQItG+tf+1Za4Bh8m0Arsb3mdxCMsSkMkirB+3rEkvyRCllAzJGaahC48hNINYP8amDiIBG1jYs9blKKeM1G6uErMMbIrcfseb9pZ9uejySwNixCpjx+CtUV6r5PL0P9uc3Rv+Si9PKmhJCoFLoZz3Zydujn1bZ06q97aVY6YBky0rJyIb+sRRrq7gRYpNxuBsA4v+0G34TEd5FTBFRVyRjgFTYKcj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGgMW87f2zECfBQUVWlPoIMRHH9cwGhrPvN3m9AuJTE=;
 b=LlMHaWz3PzdHSvHHC94t6f02aqPCEQpw+vcRrw3lB7ftbqKTY3pkkMItDDdyUBIYew9BTewjWQtMFh/n2AklQYi4e3GMYmYroZp40poqQA6V0zwfO9ckAWtpG1GStId3l/xd7R+fvLD/af+OGBScCv+0ML6Yx0yOesIBUfVZMDDzjW8IQAcpjgchmNKA9NXz0nLqobqk7FaVyGdPOW9+4gEwOWnEXhQsvjpiEyOdbIIKxQTJcuQXaPTvse7Y9Bsl9A+ozd0eDfY8XH+ZCZ5RCqcnYY8XWOiqW0pvzmrB0gW+cdDiGngScj/wVrqmGEPijJm5sPV90FIVaSxqpqHYOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:26:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:13 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:36 +0800
Subject: [PATCH v2 06/11] arm64: dts: imx95: Add coresight nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-6-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480344; l=2956;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LRIkYgeahRrQ5MDGvVlmKJD9ac/LmIGd4LdE0X0xVXw=;
 b=AMmfuzBxzIo+1qQMSQ5aSuNywUTHBlLXIyWOFikfdaK3KWzKQZ/h8mBedA1Fy909E564O6Yzz
 jSMgn6aal51BGaIkk5vP9F8vWBv25qNW+Tnu44bP3686pngjU7beYqp
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0998d2-d153-4221-2b6d-08ddddf6389e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEJUOHVMWHhieGZRQ0w1RGs0cEZSelREMTlOT3NhUjBpM21KU2JOUUFvV3ln?=
 =?utf-8?B?SUJpUDFxWUN1cVVET1hWM0FFL1NUZjRsbnRmcGFXUXJ5c2NWeDVIbFhscGZN?=
 =?utf-8?B?RyswWkFHWHl3Rm52enQxaWZ3TFVFYmFaVXpPNGNQWXNPaXRCNmRhcVBvaTZw?=
 =?utf-8?B?ZHN0QWszOXh0YW15Y2VEcGVuMkt3Y2oxZCtOOThJVk5QQlgwNWF5blAyWkdX?=
 =?utf-8?B?bWdaRnB0U2hTazg4TXViM3NkNW1pdkc3ZGF2V0JNWXhMamNpVG9LeVN0VlFR?=
 =?utf-8?B?KzhvMnY5Z1B5cGgvUjFZV280U1psQWtBekR1TDlSWTZZN0ZZamoxQW9GMU5T?=
 =?utf-8?B?K0c0eDdoeWkxd3E4eDY0eWZqeEVTb1pwVGxZdUhGZGhtVFlXcDNsMldsemVW?=
 =?utf-8?B?VlM3Ym1NbU8ySU0zMmVXeGx2S2FDSTV0N2k3TTJjL0JsWUhiWlZKOFBTaGw1?=
 =?utf-8?B?MFh5WVZCaWhlSEs5SWFVSDMxVUd5cm1Fb1hVdnZqTmtmb3BBMHNjQ0xqakFF?=
 =?utf-8?B?dWtka1dLRFVHN2hrOVpVTU9qaDdnS2FXbjZQZWdENnlMMkxDbnhLVE1pU2VL?=
 =?utf-8?B?L0pWaWpZZ1E0NW8zRmZWYWUyb0RZc1RCZk9ZRFluM3NSTzd1VjRBbUh5andz?=
 =?utf-8?B?VDZJNkl3UTRKT1cvV1lqSzZpMHZOTDZ0NmNSN0hsb2xYZHMyTnYvM2tWbjBL?=
 =?utf-8?B?T3NybDU5WnM0Tis5Qkx5TU5Eb1lMY1hyK1ZFZ1NsY3R4VWtwbW5ndnA5OFVn?=
 =?utf-8?B?UGdkRWhpMjNEQnFpU0NxSnkyZFU0TGZzRWpqZThBV1BtY3lHZjdNMlRnRXNT?=
 =?utf-8?B?cm1BU0hLSExMeUtFT3B4Z0Q3eCs1cVU3WFppR3MxUWEyUTl2cGZ5TGx4ZHlG?=
 =?utf-8?B?OFpKVTRTYjhCWUdETXN3bzAzbnpTRUNRL3BMZ2tkbXg5VGgvZWljbXhaUkJE?=
 =?utf-8?B?dlJTeEF1YTMyUXozcE5PRlM1ZE9CWlJoSW5hUGZLcmozMDFFdmwvUFAveXl4?=
 =?utf-8?B?bU1QcTZ1UTlWRnVsaEpSc2g5TGZ3WGRBdk56ZkFIWlcxNVZXd3Fva2RKRlpl?=
 =?utf-8?B?Y3JnL1RLN2hOM2plclFDaHJuRzd0NUptaFhISXNqaHRHSWlEZkpVTnBSRWt1?=
 =?utf-8?B?eXVHdkRoejZCcFdIamdsR1BIektvTXN6MkFkR2ZCNllvYnNyTmdGMFU3NTFr?=
 =?utf-8?B?Z3dFQnpKZjdwUXArZ0tWeGV5YWUweXlnalhYa1ppeU9vSHdCOCtxSUVuVFo1?=
 =?utf-8?B?RnJiZm42NlZUd1lYM3BPa3R1N29wL1E4b3YzVytFckpLSVN2NzI2Y1BrV0lu?=
 =?utf-8?B?THh1NnVZcVYyb05UTTRBTVh1SVJ2ZXpnQ3lzRXhET3ExM3NCaVpWV2I3TTVN?=
 =?utf-8?B?NndYNGZibENtNEx0RWpDczhQVUNZekI2ZTZOVVh4TGpYcEpkcjM3am11dHFy?=
 =?utf-8?B?YUYwTEU5VytIS0FKN1RHMW5NMGY5K1ZCQldmYzM4eGQyYjE5WTRadURYNmRr?=
 =?utf-8?B?Q2lVSGRraTJFVGlkYkg4Rmc0N1dzYkZaT1A4cXZZWVdrWDJUZTlYODRBNS8z?=
 =?utf-8?B?R1Z1eEMybEw5TzNVNUNmditLbXZtVHpidkhVdTl6cU5HS3lpcHNaaTBpNXRH?=
 =?utf-8?B?OGd5ZEFLR08xcHQzT05aZzlHREt5NXJEZ1pPbTV4ZmVlZFU3Uk5tS3kyTFRy?=
 =?utf-8?B?Y09kRGNSMmlRUkdiV2NvN3dFeHFGWXRtRlJZM2pkRXdNWEp6YVdmbkNKQUw2?=
 =?utf-8?B?cmxvVlJqRElNOXduaTVOWEtQSzA5S3c1MVhzSGxzQ3NLazBxSEZGcDBsK3k4?=
 =?utf-8?B?NVdtODV0Rmcyc0VWRm54UkFJSis3dWN5S25mUFlZZ2QvdVJRVThqaU5WTHc0?=
 =?utf-8?B?dzlTM2tNVC8xN0t0Y0cvNXVqeXFjREdzaWljcTVhY3V6YW9LKzJ3NEZNdDZH?=
 =?utf-8?B?bVFDZCtBVGNsNkRKbnpibWNTZ3NXNFBNK3ZtVzU0djBMQVNTNG8vbmZkbzhF?=
 =?utf-8?B?TnFUdWh0Vi9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBiNFhBM1Bla2YwcENRMC9xKzNBdy90eU83RUsyY09YSStuaUlnblhoNWU1?=
 =?utf-8?B?ZjBpSTN0TzU2ZVZENnFCWkhIejBpVFAycTg1Nk9rOHJoUGI4VVRzbFZlWWRq?=
 =?utf-8?B?Y1Q2WkxIVThza1dwUjZFSXo5alNtaHFyTWhUWkF0dENpVGpIUml5a0FFaHM1?=
 =?utf-8?B?QmtzbXdobFZ3S2IvcnRKNEIrTEp4VHRWWUR1eUdkYTFmWmJGUXNSUWF6TVhW?=
 =?utf-8?B?NEdMRXlDL29VOVBISnY5WFE4VkRoNGluOFlSa2ZjbWRGdnNMVllXZTduUEUy?=
 =?utf-8?B?OVFHckF4TVVDQWN1Y2s3UHJ0RVJvRFZ1T1h4NU9jZ3crZHRQMEVDbWtVUU42?=
 =?utf-8?B?V0JSUXdPWHlpcEpmN2dJaEs3Vks0WWN4VTM1YU8zNGVGRlZEQndRQnNremd3?=
 =?utf-8?B?Tkl1SEhTcUZvaWpvRm5PaXB4ZENNandZS0dHYzZML3p4c3NNRWhZbUR2OVhE?=
 =?utf-8?B?UUlPUXF3ZTVDSmhSeC9MczVzMjNhZWp1cmUvZlN2SWt4QThaZVVEQ0lmcGQy?=
 =?utf-8?B?Ry9MZHNSMm03MnBNWE5nK0R3bjcrRVFVTlpHOFJDT3NtVUlwMEpTT2JxVzlD?=
 =?utf-8?B?NVVKa0dYTkNDeDNmYzJDcmQ2d0k4cVZsa3VmYjNZYWhZN1NaTVVsa1p0QVh6?=
 =?utf-8?B?RnVsUEZUcHBqOW4wMUlaRHc2SmRIR2dQR2Y2TFFWQlFRKzlpMDUvRlVKM3d6?=
 =?utf-8?B?WlVaejBoZWlWWFBYd0NVeVhLMUpNdkhjdDR4QlV1ZURtMjRuL1RiZnl3ZUtT?=
 =?utf-8?B?Rkt4UzQrME1qZmNpemhtM1JrYjh2eUpuZEwzSDN5alRXWjFwZjdJM282d09l?=
 =?utf-8?B?TlJvYnVZb3ZOZDY5U0Q3WUVTQVlyYUZmRWE5WUtoQUhpSkRyU1MvaFlHbFBQ?=
 =?utf-8?B?S015QnJiSmc2T0xmQnNsWHZVTTNwNlRtakcwRWMxWnVVaEc3TEhUUytVYWdL?=
 =?utf-8?B?Y0FWaEppbm5pU1VsRk5rbXQwMjVFRmYxN2xvTGJSQ0FzS0VNa0RRT0NjSVVY?=
 =?utf-8?B?azBXQlI0S0hrckg5U0ZocEsveWMrait0QWdNWS9VNGJ3Z29ySzRxVFQxNnNR?=
 =?utf-8?B?OU5HSmRBaXY0RHlpa1B5RjRPMGFPZFIweUFjTlhIc01acXROYnFzYzRMMEJX?=
 =?utf-8?B?RERMNkFHaGJ6Qmx4S1ovTFoza0hXQVdtd2dKU0tHbVpIU3ZOVHFjRm5LcWVh?=
 =?utf-8?B?UWkwUmpWY2tzMXJqMWJRT2oyNTNBRTN2NGF1L2psSjY1NXhXN1M5T2Q3WUhI?=
 =?utf-8?B?aFp6NDhPMnRQamVqYVRpZHpUb0puWFR6c2I3bFlGUlZPdWI5SS8ydDdCQ3No?=
 =?utf-8?B?cWtySFpJOGZZQ3FaVlVUbkpxWmV3MjNRczF3R21MbWowUFVXZFpsMlIxS2ZC?=
 =?utf-8?B?U1AzVE1IbkhxYUpUN2lJWWwzUWE1MUlSZFRPdlQ0WlRDMG1YMk1rdktBcU9M?=
 =?utf-8?B?WWlnUGY3YlVPSG1kR1QxMUhSaUcyTmdwN1pET1J5KzVWMGI3RkVqVlVJQlFn?=
 =?utf-8?B?Zm9wZk5lQmNrSXJDL3JCV1huYy9samZIWTRKMVU4aHhBbkpiWjBQeHo0VlNW?=
 =?utf-8?B?WkhBeURCbHlEQVc1R1c2UnhPZ092V0d5dHJPSWxCTVZ4bU9udDBDTHhwOFV5?=
 =?utf-8?B?SVdaWWFKeGw0MDFTelo1T2JpdHNPSUhKMTRrcHdGYlI3WEZZUWd3Vy9JNEJt?=
 =?utf-8?B?dnlscnlJRXdiY3RwVmw1RlBKbGo0SUp5OFo4TURXb1VMMVlIa2pROFNqUThW?=
 =?utf-8?B?WmFkUkN4emI1OTdQc09tWUJta0tCVXg0dU16b2JNUExuRmNiQkNYU2Y0Zi9i?=
 =?utf-8?B?eWxHMDhSbEtJUExadEVQdzNTc240Yzc2d1FSb1dWajBvMUdvd20zZXJzT1Fs?=
 =?utf-8?B?S2RxSlZNR0xGcXVwZTJudEVxZytPRjU4VWhuSFd5dVU1U0pKWDdCT0FxYitt?=
 =?utf-8?B?d2ZvMStndjNBN1NxU2pQQTlLNE1Vdlo3ZndFcWh0MU5JK3AwYWszbHRnZjF1?=
 =?utf-8?B?eVFUaEphUUV6QzFNT3BpRkgrTlhqd3VDb09uVG96RlM3MDVyNGRQMDkvQkRP?=
 =?utf-8?B?bUxSOTkyQnFXR2g5NFJMQlV2ZnQ1MHp0WFQ5S3VtU2Z2OVJ1ajRCWm1rNmZR?=
 =?utf-8?Q?GyGE9GJP3LMuK5DFgoc1QckkQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0998d2-d153-4221-2b6d-08ddddf6389e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:13.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDqnfpUKDqpObPIS+mv77wkQ6+HqJdElPWR8SfGiub/eIjEJMc8oR9rdIsmIeD7YE6eVbGzuhY7v9A5oy9VILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

Add etf, etm, etr, funnel nodes for coresight.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 104 +++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index adc63448aa15b148ca0eb8499ff5bc217fe8208e..56d782f423bbba6b38bc51369ab9535e8da2eae4 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -492,6 +492,110 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		etm0: etm@40840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x0 0x40840000 0x0 0x10000>;
+			arm,primecell-periphid = <0xbb95d>;
+			cpu = <&A55_0>;
+			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm0_out_port: endpoint {
+						remote-endpoint = <&ca_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		funnel0: funnel {
+			/*
+			 * non-configurable funnel don't show up on the AMBA
+			 * bus.  As such no need to add "arm,primecell".
+			 */
+			compatible = "arm,coresight-static-funnel";
+			status = "disabled";
+
+			in-ports {
+				port {
+					ca_funnel_in_port0: endpoint {
+						remote-endpoint = <&etm0_out_port>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					ca_funnel_out_port0: endpoint {
+						remote-endpoint = <&hugo_funnel_in_port0>;
+					};
+				};
+			};
+		};
+
+		funnel1: funnel-sys {
+			compatible = "arm,coresight-static-funnel";
+			status = "disabled";
+
+			in-ports {
+				port {
+					hugo_funnel_in_port0: endpoint {
+						remote-endpoint = <&ca_funnel_out_port0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					hugo_funnel_out_port0: endpoint {
+						remote-endpoint = <&etf_in_port>;
+					};
+				};
+			};
+		};
+
+		etf: etf@41030000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x41030000 0x0 0x1000>;
+			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+
+			in-ports {
+				port {
+					etf_in_port: endpoint {
+						remote-endpoint = <&hugo_funnel_out_port0>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out_port: endpoint {
+						remote-endpoint = <&etr_in_port>;
+					};
+				};
+			};
+		};
+
+		etr: etr@41040000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x41040000 0x0 0x1000>;
+			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+
+			in-ports {
+				port {
+					etr_in_port: endpoint {
+						remote-endpoint = <&etf_out_port>;
+					};
+				};
+			};
+		};
+
 		aips2: bus@42000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x0 0x42000000 0x0 0x800000>;

-- 
2.37.1


