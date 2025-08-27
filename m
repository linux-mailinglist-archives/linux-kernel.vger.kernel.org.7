Return-Path: <linux-kernel+bounces-787672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9C9B37978
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C231B366796
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504D330DEC4;
	Wed, 27 Aug 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IbtubK/n"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF730BBB7;
	Wed, 27 Aug 2025 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270780; cv=fail; b=sOVAIUib0cAPSK4iBbJLEvwINUqlO77qYv++ypYQnDFFHL8HABalJdJQDcAZ/Zu9U5PdmdTnBb2mqS6Mi4eAc0/HE7Ch0TzN/G2pM5iUpqhDjKyA/RxLPVLWeW6U8ZkxcVrB6zjp9nX0xQhtj/ssXoHx7SOFbIhcEmKw3ssYUGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270780; c=relaxed/simple;
	bh=37ex7TSAzMOXcON96mGBAM7S8ODTvQSe1OU0Kfvfp30=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Q1S2qnogLGIr/+oClWf8OKLGUH5h8DiblozQVuV/QzpuWO4W09wDO79bbkMZDyQzf+TfwKCgzOLzJo6eU1FVeWyAZ6RkWUBBKm+Yb3Yua31gyfEJvaSaOWE46+HOk1k1aEPgDcEUdkzJNo6hm7DspydUSH5rLYnfEQVMN1nZ5H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IbtubK/n; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHMkpKSSOZ3+mtPRLJpUnRcop2gawoiSxj4pRoRz1clmbszlvSBk06iIkJS+1j3BWF1hr5V8mAC5nQ9KVWg7pnTIxu9NKQM6QTNHE3quMchaXT0yHMbX6dYQQdbUkHM4u3o0NPkLxxHnFW3aUv8V4aHdKG72DHnJj3w4OdSb7BbiBdIfKNWaxX5bjf2jz1b0oZKlIYIsw0o7yyE33J7DNQPN5xiOQXUxM9W7eE6p5xcY7vhqI8FTQ9mjITBfQVgMQdb9l7LLcaFVC+qXBrWglPWkRJc2bl4c2tRIViN7Va6CFZML+4OMtQ9+I1u39pOpJZBXj2ZKgaztiNvngTfWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIdsmer+S5Hu+dy6qELC55WpumZrXPmBQJbAKeDslZ0=;
 b=AcW4Xqv0Sng11PCoPMxzZuy0XET5RKhQf3TRJmwgthWhn6+XwG8ig6qhcyBQ1imlMCpc7Vz+3xDfnWlZI6SF//JGOIPZsWHIqRjtDXFvonPZoYTMRFw/7f/pJs/D3d7kG+ud4V9FIro7/g39bCmENT0vej11PtCvs0GW/RDK3O7r3OCqr4i/YBgMjvec+gijtbckMc3vTjwNTpR8uqxUScfCDrDfNYW3Zy6f4VnU1ljhJ7E7YaZa/S2+drLMXjmwpNUBB92vDi6GG5QdMgvbZZnAEPzvicFOyCPXQwbTYRM2kTdk+7Rs9luqzCA6sYZnc04mmQpOO/1u7H2mSbkJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIdsmer+S5Hu+dy6qELC55WpumZrXPmBQJbAKeDslZ0=;
 b=IbtubK/n2W3eucPUp1ZnJyv/qapQoXZbmvv4SSmLHB/sTfBGk11fNA/4qdmZyHEkeDkvYdTdv4Qbsl2Ac0HQjz1F6Q8tPSRZz05WkfBk+Gtnl7Wing5ykq/mTAzQF2q2Sr0HG3j4Mw4CliKnPO6B5BSDyn6hltYK6IuR4jajfKAHCBKItyHH4kZ70ad3n437r7sd9/QEI3QTYAUHIOVjBXL3p2gWtitoTkBgLRnDPrq5SbmfeXidLF6y3/lWfkRB9lHfhCRWqgk6sZO3+DkRTfdCBdt075rxUzUN8H5DeodxSTAhAD4LggJMm1k0qsrl6PQ7iFpJtcTc0FddtPe4kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6899.eurprd04.prod.outlook.com (2603:10a6:208:183::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 04:59:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:33 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Date: Wed, 27 Aug 2025 12:59:12 +0800
Message-Id: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCQrmgC/3WMuw7CMAxFf6XyTFDiNH0w8R+IgQaXeuhDCYqKq
 v47bpcOCMkezpXOWSBSYIpwyRYIlDjyOAjYUwa+ewwvUvwUBtTodIGlir3qOXr1mFgloyrntdW
 +KOVBpClQy/MevN2FO47vMXz2fjLb+jclpxU2dZ1XpqUK3XWYp7Mfe9hCCQ+5NPpHRpG9pdpZs
 nlDxSGv6/oFQO2CvecAAAA=
X-Change-ID: 20250627-sm-misc-api-v1-85c030c670c6
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=1999;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=37ex7TSAzMOXcON96mGBAM7S8ODTvQSe1OU0Kfvfp30=;
 b=tMu4Jl7BwPTk9W5SUDzFU98/ozIe03ekZLFkuuzmWutceT5koQlbLDHNWsPyfXeaapz/7cyc+
 Vb2krcUCvpVA9Z1c8TgrqDne/ne9XMUHBc26p78BMc4MNYrxjjvR2wl
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5ff2ac-2628-45be-a5ff-08dde5268341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkowU2RtQzk3SGprNit4Nnl2VUtna0doRkY3MmpQeGZPQTc3Uno5b21WdVBO?=
 =?utf-8?B?Wnh2bmJWbWVFQ1NtRGJqUjZ5SGl6c3hrcUdkL20wNXBRZFQ2dThrcnNkV3BI?=
 =?utf-8?B?VHVNRi9uWWRSV2I3S29zMkZMeFJjTzNLRnZsL0gwWmFrOVRFbmtmOEdPcGMw?=
 =?utf-8?B?Rmw5aHBvTVhLNWdWSUNyRzNjSkUwWEs4ODkzOUd6QUwvaTIrREJEWi90R2NR?=
 =?utf-8?B?d2NjQ3RFSDBhd3kwNHJEWmlScjhnR1phMCtTQWRibDNvc1FkK2FhTkZ1aE1B?=
 =?utf-8?B?Um1rR1loRTJTR09ubUNPQjdEVDIzR2xFbkxpdlZUcnJILzBtSEUyUnI4cTdy?=
 =?utf-8?B?WkNvYkh6S3hnVkFuMmxUNFI2dXhlT2Z6UWFyM1JBREh3Si9rNTlrZUdJTWZ5?=
 =?utf-8?B?MEJseXFidXd2ZmxkRFp6cUplUGNQUTkxZnkzZC9mQWx4RThhL2IxYkk3c0pS?=
 =?utf-8?B?SjhYeUx2dkNtNXFaK3pOeFgzaUJsR3RwekxsMU44MGpJOEZkdE9vK1cxRDVV?=
 =?utf-8?B?SmdNSlBmTjFOeFZvMHBEbGVIaURrMFVGK3FrRTl2Z1NJRkFmK0JYM2JFNFBx?=
 =?utf-8?B?YTVyQWNUeEEvcmhJRTlGUmd3OEhKOWxBODc1NDJBZmdNOUVCTWVETFEzTGl0?=
 =?utf-8?B?N3UzeFlEL1dNbDJucklCSHJqTnRHa1JKM05aTUw3NURwbEtwZWZ6Z0xMU1Zp?=
 =?utf-8?B?ekVtakI0djVWemRsb24xVjNwOGJ4Zk9RaDZLb3R5QUNDcjB2RElFREk2WUNo?=
 =?utf-8?B?d3k3R2lycG00ZlVQWFZUdzFWOGt2dzI4bmFrcG1DNlZ6SlRVOEFtbG5NK2xT?=
 =?utf-8?B?T2NCdU5weUdHRDN0Y0xORzMyR3BnMUtSQ2VrWWI5Nk1qUm1aVlZVK0pkUzdM?=
 =?utf-8?B?OWVVU2J6YzU4c1U5dkZIU3I3dWgwVmV0dmJpSHFQOXdIazBzdW95SkV4OTNR?=
 =?utf-8?B?WWtGclBLZEhlQXhFSUlKVDdSQXBGcXpmZGdFaFZNSmtMYnpHYUo4RGtIRzVB?=
 =?utf-8?B?ZzNUb0R1eVRkSm0xVUhLNWM5bTE3bWVkN25VeDdDVXlsUWVLQU84aWtpQllw?=
 =?utf-8?B?M0tRcHBRYisxMjlFQnJ3MkwvdHlVcFNSVU5MaVBTc2dYVHhZTDFRZ3A4OUND?=
 =?utf-8?B?NWQzWXdMM0RXUXlJaWQ3ZXN1WWs1SEJNVTVRdWJyeHEzektQdi9UelVSWjln?=
 =?utf-8?B?WWt5L0NabzU2bE1KT1ZwQlBmOVVKMFkvWExseFF6cHJKOGdBS09DclEzeFVO?=
 =?utf-8?B?VEdwVUp1MWNabkhvUmtyL2VuOWNQa2svWmR5eGFoSkhQVzFVaDgwZHc5N2RN?=
 =?utf-8?B?VnE2akt1U2V2RWRzbHYvTUI2QjBBdzFDd1BPdmR2YTMrNWdKNmpCYWMxeDN4?=
 =?utf-8?B?SnJ4bTBVZjJabHhnaFJpdVF3bjUzeW8vc0U0THRITzNWcmJuUEtjbStVYjFP?=
 =?utf-8?B?bTNOcm9CRHE0OFZKblJEVDNnbUFGTHFWalV6eGFocittK2pORElSRVRJSjJa?=
 =?utf-8?B?cWp6VEJ2Y2VaTkJ0eUpIOUlXQUd3ZkllOC9TUlRpMFpSM2FaL3prQi9GODFv?=
 =?utf-8?B?cEJWV1EzZ3JsTGdRcTM5VFRvSzYyNVRlNUppb0Z2a2xobWJKeWlyaWZqTjdL?=
 =?utf-8?B?ME5rL2JoaFFXNTRDbjRtNU5tbWJmZi91ZVQvSmlOYk5BREt0UXRXZkhhbTlw?=
 =?utf-8?B?UDRkck9DNmRWT1ZiMmt4RjBRZk1Pb2liWDJZYU9XYVRVOTVjU1Erak1LUk1B?=
 =?utf-8?B?T2pPRkp2Zk1xT25BQXdtTm9BUmtYbEJTNS9SV21NWE5VZ3B4STZqRlNvTjhy?=
 =?utf-8?B?N2g0TnAyN0tRT3VLdzd5WFMxUTVkVldaOXFBUERSZThFSFZwaWd1NEtwZEp1?=
 =?utf-8?B?TTdoRDFXR2pwL1FwaXN2QzJMR1RDQXVpTkU5QXNybUdyT2k5K0djdWl2Zm1B?=
 =?utf-8?B?Mmg0a2RvL1VxejA4NHpKV2pqZlRPQ1BEMWtaS2ozMmF2dVhJRndJbkdJeUJl?=
 =?utf-8?Q?Nn5U1VCdqQcrNqCCtqDFVR5aI55XSA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjRFRDVkelZ5cVcrcG8zbGppUjlqOS9Xbm8vdC9sKzdZa1hjR25tWW1PMGRS?=
 =?utf-8?B?MXpiS0I1U3dWTWo2aHlPZHBxT3FJbWNRWWZJTVZPYjRVZVFzdVlSb3FZVnVF?=
 =?utf-8?B?Z2kxWHRKL2Y5aW4yN2NWMGJGVzRJME11THEwLzhBNTJ0UjZVcHpWNUZzSnhn?=
 =?utf-8?B?R2t6MUQ4MFJZN2cwdUxFVkFUY3ZQYnhSRitlbmNVNklLaFhlTkVERDE5Wm5K?=
 =?utf-8?B?NnMrbGcwRXJXZmxPOGZXUHg1azMzejErM2RjTkJQRGtwTThDdzl4ZVo0V20r?=
 =?utf-8?B?T0t6UGNmNUxpTHRQRHlUUmZsZUNEK1ZqcENVTDVQMmh0REJ6Z0hIR1p4Ujkz?=
 =?utf-8?B?Uk4wRHFvU1hyYVhuUElGSkU5bDB0Z0owa1lnUm1kSFFEWVNDUENabklaWUZK?=
 =?utf-8?B?eVh6ZzJWKzB0QjN5eUFyb1BPb0dRTE4yZ2Myc3FHWlBrRFdZTHU1SGxTYTB6?=
 =?utf-8?B?dDVJb29kYTMwaFpZVFBqbkFEYy9SOHlSQVZ1M1dWSnY5a1E0N2djUEhHN29s?=
 =?utf-8?B?VWpiVFpHcDFtaGtZV2lVOXNWYXNsY2hjd2FUWXJzeE1tYm5JT1hnaHd4NFZN?=
 =?utf-8?B?WE41ZkhPanIyZE85M0RUaEFUMmpMWHBYS3NWWFd4aDBtOWswbHh5bXNTMnNl?=
 =?utf-8?B?MHZHNGY2cmZkUzJDMjZoUFlvdEJjR05sTW9taW16VGdybmVqOWg2eUw2aHRu?=
 =?utf-8?B?aVQwNThkVFJ4VVQ1Z252YlNuUmFENDRTTXZrdHhYVkxSdGliS2MyN0ZNaU1T?=
 =?utf-8?B?UjJMdXhaUnU5amxmcndOaXVZQzZKazI0N0ZTb1dYaUJNall3dEpqVG4reEdR?=
 =?utf-8?B?RFROOER6dHMwbXFSemZWdW9Id1RIU0pZMG5JR1Q0aVVaL3Z5SUczdGlRMjQx?=
 =?utf-8?B?a3ZDdUF2MkZBbjdabkZSeEZVYXRsdTh5Rnl0czhsbWExSTVOcGhtd3JWMFhP?=
 =?utf-8?B?b1pUVVhZTkpJZ0JRUEJLaHVvVlBTSnljYlpPRm00emtQczgvbFBTSlFaUkdm?=
 =?utf-8?B?Z0Z2WFowRUV2QnRjQjhaMlZ3UkRGdFFaeEJhL09hOVRZS2dSRVA2b0ltRjli?=
 =?utf-8?B?R1QvWjBoMXJxSlVIUHVpYUljWktCSDlpMXREcjVsWU1TNDIxWHVnUUtTMSta?=
 =?utf-8?B?UGdNWHJPUFJXbzdIbGFGUXFQK2VhR095U1VkN3RuQ3Y4ZE8wbTFXRjd4UzFs?=
 =?utf-8?B?dVVHWUZ4YUo1aVNPbUtlZzFYenZzNlp3dGJyNWZBcVJiZWVISm1vUnBxcVA4?=
 =?utf-8?B?OFBmejc0RUtmZnJqdXF2ZFpWSVlRZUpQektLNlkrMTkvS1RSNVl3bXhTVUpj?=
 =?utf-8?B?KzVSTDFpbTlLWjlhQ3krTk05ZlJtVGM3eHR0RXlFOTJ1VVJYeS9qWHpSOC95?=
 =?utf-8?B?cW9wR29VUTNRU1ZEMkRKVjZrU1BrZGxQZkRBbGd5WTJqWXpkRjVNZ0E1ZWVM?=
 =?utf-8?B?OUJoSnRxNVFNbjdyTmJGcmR5dWQ2TTFIdURLL0FOTE4veWtuZCthOC9zMFZk?=
 =?utf-8?B?T2tXencvMDhNeVFEb0FUTVhGTGo1YnR3T253NGR5NmJsK21DS0o2K29jVU5O?=
 =?utf-8?B?MEVDZjZqMFlWSGY0R0tpdXo1dnRYMnVOdDNxTHBPRGJ2OEVxdFNsYXAzeEF0?=
 =?utf-8?B?YkJTRUpvcGY1OUxzckFQZWkyTzkzKzVlR2RXQnJtSWdNU01BWnlOV1ZxeUFo?=
 =?utf-8?B?bkszakpoMmxHdFA4eDRnVjhuMGp3S2ZNQ2lZNVl2S0krS1M2TG1wQUVZb1Jk?=
 =?utf-8?B?UEdGNmFWVi9GN2RKa1VHam1nQlF6YXgwbFdHRjE4VG1lVG5OQStvY09OR0o1?=
 =?utf-8?B?anFSSWNmS0dIWVZDUjZCd0o5dVdxUldZSHRLVUxkYk9OeStBaWhJK1A0R1FC?=
 =?utf-8?B?My9WT1NqK2ZCSTdobjQxaGplLzMrZ3FwV0VCMXJ2MldaZWdDMGhKWFpkOGdW?=
 =?utf-8?B?emJDMFIvTkd0bjY3cTZwTzBsZWFkNmdoWXAwendNUXhXWVhxbEkvTURuOTcy?=
 =?utf-8?B?Y0JNOXhDSUFjK2hybUcvaG9oOThMVTFlVlBTQjIyNVZ4UHNVNlZWY1czSDh5?=
 =?utf-8?B?SFVjN0Z4VldTa2xsYzNESGRTeUpqZjRCc2g5QVNmRGJlcDFSVmZ0dUp4VTYr?=
 =?utf-8?Q?LaPZLyGZWD4znLqSXySalrPHP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5ff2ac-2628-45be-a5ff-08dde5268341
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:33.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0t2NWKesRZw145ec8fotGk/xK9KpUcBrLzx2HtoIEwetlwc/DX8auet3tjBbIURbuQD8e9IMncvArZgs3QKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899

System Manager firmware provides API to dump board, silicon, firmware
information. It also provides API to dump system sleep, wakeup
information. So add the interface for Linux to retrieve the information:

patch 1 is to add doc for board information which was missed before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Add R-b from Cristian
- Store size, per Cristian's comments in patch 5: "*(ipriv->size) =
st->num_returned + st->num_remaining"
- Minor change in patch 6 to add size check
- Rebased to next-20250826
- Link to v2: https://lore.kernel.org/r/20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com

Changes in v2:
- Add more info in patch 1 for documentation(attribute is reserved for
  future use, boardname may not align with the board name in device tree)
- Drop dump silicon revision API
- Update discover build info, cfg info, board info API to be only used in probe phase
- Update to use single sysfs single value for syslog.
- Link to v1: https://lore.kernel.org/r/20250627-sm-misc-api-v1-v1-0-2b99481fe825@nxp.com

---
Peng Fan (6):
      firmware: arm_scmi: imx: Add documentation for MISC_BOARD_INFO
      firmware: arm_scmi: imx: Support discovering buildinfo of MISC protocol
      firmware: arm_scmi: imx: Support getting cfg info of MISC protocol
      firmware: arm_scmi: imx: Support getting board info of MISC protocol
      firmware: arm_scmi: imx: Support getting syslog of MISC protocol
      firmware: imx: sm-misc: Dump syslog info

 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 193 +++++++++++++++++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    |  22 ++
 drivers/firmware/imx/sm-misc.c                     | 232 +++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  19 ++
 4 files changed, 466 insertions(+)
---
base-commit: 6180c21371050f261dd253947057bf46955548f7
change-id: 20250627-sm-misc-api-v1-85c030c670c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


