Return-Path: <linux-kernel+bounces-770549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2AB27C54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1736621D02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9561D79BE;
	Fri, 15 Aug 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YnfUgTfD"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7723A9A0;
	Fri, 15 Aug 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248667; cv=fail; b=Qf07m4iFy1zOgdWz1WYNep5y6seKl7nJnUVbYJfzwRG2vgs4c9lvw9cgYo3rhCWVcNSBmMwEpFQ/CCOBafMckyOHT7YXjVBVMKfxkNeOihJsIcH6J4HUMLhfOElU7A/oSbLkUX3PmQONaXyWyHIlimMMSbpmebcJKQeD04wi6x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248667; c=relaxed/simple;
	bh=nhWbxoA1zV97y/kKCwoQ5wL9Nmfbu23OObqgtC6fpH0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=g7/uJfrHUbxQhnSQAK2E6aQyoA7uAfQImVUQurEEnQw/+B/ukzWnAhdj7zOo+U5a++mpMhfkM3XMkxzp4ApmKe63E78W+4Uc2jWiHoB6U99y6kLVOhMm4POzdI6cCoBRHHVeqE1Drf6UcBA3l7b3ZNZeIcn0K7Wl8ruUd4eiG90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YnfUgTfD; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bl194yukv+Xl75WS/gZr8Stta6yw/RPIHOxIElJci7O348FhZdA37LNY9jyIrJSBZt0NIfyEHU0oeOVc9TIXcyXkGjzgD7efhqzZ5nQOE9OJoFIrHTLRdxVq+EOdssYpEq1aWie39YxQFx1HQNnJ7GvixGkM7NEpnfK7XgvH4bUsLrpg3RZhOQ7YCuRGEztyyKrKrNHN+JaHUeFJNHALMitV6oQC8oY4cJBEHriZC/xeGH4ULcpm1XdeQMlN9klEY5WntoQ+31sOkWffZNUIhv9JnGnJazyXjAcDu0TA/NoUUJKe7CLzFU1kk2pup/IoVXJ1O9JDO1qbmIuSorPS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVkwq4pF1KwXbmp8cIgmuw0ow1WcuA5aJPtXhItaWa4=;
 b=wtQM+Obf3PnUQdo6gqC8N5d061MX/ZGr7yPiFqGWkCZqL3KX6UM0NmmwcuMAWG/l+8y69lu8JvZU/qhNZipiWtpLJBvjFeJwuIJdWU385CfnnvRt+4Qa21rnArR3OYUALpXU5Cep0IlrXl5UCu5Pl0Ygw8NZeZd0bDoF/cPWas0ucIGTQirj02cOGT6gS2NlBtCnqY/CD3FOEFGyTWhHtFMnScOdyPKUDeSlBdW8UZVvKAmBVEHtQfmkUzwKkjSNVYI2Bhqg8CS7cr2OTxkRGXFWPq0jhS8DdNrhbHFAkzvuFJWW9N90E138vZ2E72+pI54S7uxVN8x5taFDOiURag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVkwq4pF1KwXbmp8cIgmuw0ow1WcuA5aJPtXhItaWa4=;
 b=YnfUgTfDndQdb2Mpuapt13HORKhTTzf1FtXYfVM2vqgNP3kNt6HuLZFizYdDTQk49Y8vuqwB4jmKURlzyYCcogJIuIKcWvWG9DG4Mup5qMQHR/Q9UeYyaCbNyFE80c3P2rB/1Cb9UgSdEASvaEq8UhB4nk+rh9cy6avypceyg1YQ7SJW/4x7MTpQPUIfn8fbRjuYH01SN04LPvRGcMhUXaDhH3bFGEtU4JsUKfSDTjbd7+VsM9C11EpsnJeYnleH7/VugRTreaygAjvAOkGsLaab5SVxMroIlno0MF97jOEePc5c2lllyJTkfhc+o9fsC25laBWK05wMGjCqfWWVhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:22 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 00/13] arm64: dts: imx95: various updates
Date: Fri, 15 Aug 2025 17:03:46 +0800
Message-Id: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPL3nmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3czcCkvdlJJiXTMzkzTzpEQzs8RUcyWg8oKi1LTMCrBR0bG1tQC
 Flol/WgAAAA==
X-Change-ID: 20250813-imx9-dts-664f7ba66ae7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1630;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nhWbxoA1zV97y/kKCwoQ5wL9Nmfbu23OObqgtC6fpH0=;
 b=ZFgGbcWs9/jr2Lni7CiZgxfQPqFt8KOSgisrolj9OLwwBh3pb35fmmP/dtf7/994FYKRjp/cF
 3/gY7T47Do+BuzXMivJNlsLD/jLuWCRO3Q4cJiWeq8L1njdiSl0JDtS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 723b960e-b380-4c06-f2da-08dddbdab9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmx1cXNhdEliUzB6amhBbVVXODVaT2NWSzhSNHdRN0VOalA2QlhmZUNLVTMw?=
 =?utf-8?B?ZyswY1FlWHFWRERKZTlHSXVSVVEyMHZLV0thRndrU2ZuS1A3eWY4RjZJWXBE?=
 =?utf-8?B?ZFhYaEk5d1ZYOUpDNk5vaXZWWnVOMXRtMThOMDJONWxENnZjQWdnUnhwRUVL?=
 =?utf-8?B?VkFkTGYrTDdNZmh4Zy9XNDFlS1h0d0tuK0FwWkZVR2JLenBMdWxkYUVVaGxY?=
 =?utf-8?B?RWQ2TmlxeE84YkhQeTl1UFB0bm14cXA0SUc5OW14VGp1MmJxOU5FNnh1NFEz?=
 =?utf-8?B?SDR1NDN0UEFpb2dRWDNHbHJxUXNab1pyeFJSb21zZmFqMWw4OHRucnltWWtH?=
 =?utf-8?B?ZjhMeHh0YXRKc3hpTWN0TmxCdmhHRjBoQXR2T0lNcnM1V0E4TGR6SmpuZHRT?=
 =?utf-8?B?WStMeUpCSE5HRTFqNmsyS0RtZ2hKWnh3MGJRN2lqOTJiTDF3WW1OaVp1YnZr?=
 =?utf-8?B?cCtlTzVwVUp3TWpBYUsyNUp4ek90RXFHUlg2Z3V0eXM3QS8vb2RqSTZWMWM2?=
 =?utf-8?B?WmZXNzFVVXdIOEo3bHJwNVZ5S05RTmxBOWdGd3hOVk1SaXZINzc2SG1iVDNW?=
 =?utf-8?B?QUxORnd1VnBqbFRxYjVSTmxSNEp4d1ByZGVEbUNnYmtNalJpRU1NVExtbGI3?=
 =?utf-8?B?cjVRSmJFbGIzUDZZWld5Ti9WRFNpOUxQRzduYjk4QWl6WkE5WkZRVzlnVTYx?=
 =?utf-8?B?OXM5K2FQM1ZZVWVwbkt3THN2ZTRDMUlGdnV1Rmo3UE9PYnF0Vks1ZHBKLzdC?=
 =?utf-8?B?WEdaTVFyQnV0N0g4c1dmMkFZMEptNm42OTBneXFHNTJJOFVELzhGdFpUbmdD?=
 =?utf-8?B?UGIxL0FvU1JwcnhIc28rNHh3TGlJUzVzWEgzOTd2ODk0SzUrT0ZRY1I3a3ZG?=
 =?utf-8?B?b2ZwTVNhaVE2L3o2TmhwZVl5dDJ5RkdjS1dQaGtIZldWK3RQUFNQcTZQWC9F?=
 =?utf-8?B?eWN0MFhpWFJBclczdS9iNHlhVUNKVGlEMWpYcHlQOVMvMCt5N2tJS000OXBl?=
 =?utf-8?B?VUdzTWZ1M0RoVzVtMlBrWGZDMGRsYUlHNWRUUjdLbkJHQVZ6cHk2dmJ1dWsv?=
 =?utf-8?B?SnFqQVMrcXo3aUdzamtqS052eUR0bEhFL3dReTJvTExlL2h1TnFVMnRiR1hn?=
 =?utf-8?B?VHZLb1RRd1NVbWErenhYQzlIOG9tVXZUYkUwZFFJczFHTXpvTFFjYUxLNXVp?=
 =?utf-8?B?NlRnWE9Hd3dUUUdFZDN5SUNXRWNQTHJCV3JyV0RZUHI2ekRkNWtHdks3N05h?=
 =?utf-8?B?cW90U2dsUW9pRXFEdk1pVHdGOFQ4dGxwcFA2V2oxcS9ZOHBaRzhXbXZ2ODRa?=
 =?utf-8?B?eGRmcmlnS21yWnU4M011OGtmdjRYcjBGWnc1M1U5UmZUazFZWjJSRldXRnJX?=
 =?utf-8?B?akJIRUlXeDhpRGtKMUlnUWJVK2UyVWN1VDNuOWp0K1BDekFyMzBFbkpINUFU?=
 =?utf-8?B?a205T2FpdGxUUFRjTk9FMWlLeVM2MHdHcEc3L2c3a01ZeG5SY3NSeWRVZG4r?=
 =?utf-8?B?VGg0dldrTHV3dTB1Z092UWFwZXV6YTF5V011R3hoSktVeWw2RTh4aEJtNFlW?=
 =?utf-8?B?b1YxSU5rMlpyWHpmQlMzYmNpamZCcVo0QW0za0FnVDVhcThRckNpN0Qyamx0?=
 =?utf-8?B?eVhvTHUydTdYa2U0OE1UU0F2em13VlVxV2hhT05GUVgzb2lqcmMySmVVMVhD?=
 =?utf-8?B?VUdaVjhCRVNLTTIwSnNmb0Zabll2dmhwTGJ0VkI3MTRWTjJYMTQ3TzhKRHJl?=
 =?utf-8?B?b0wyTVNkdWltT1p3SU5DQ0xHMFdHbFQ0dXV2Y25nemlrY0haZ3N2cDczTWZW?=
 =?utf-8?B?UUZKZ0FYWVhpOTZXNjhGYXJPbERTRkhQK2VhTWoyTXc0dGg4ZDJlbXZ5bEZx?=
 =?utf-8?B?SlJIeVN5dm1UOGxqNzNHTVExcWtmMHFqbFZCS1FHUXdZRGhLRGlWUFZvR1hJ?=
 =?utf-8?B?MmdVOWl4eVJZRldjRCtMN1Z1Q1VKdktReXdIWnVrUTBTdkZaOU9hOGUrK2tL?=
 =?utf-8?B?ME9kc051TVZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LytQbUZGWit1UTl0M0k1VWJwakJmc2FHZnpYRFA1MldjSHBEbFpyeUpWL0x0?=
 =?utf-8?B?U2NhTURPcis1eTBjcWFsbVI0cDJMbDUxcG04bTEvVFpPNDcyTHRFajgyTnBa?=
 =?utf-8?B?Rkw5VEVrMjA3NmMwUytna1c4ZVFZL0hXL3hhRy91dUNYSFlKSUNJTkJOQzFW?=
 =?utf-8?B?Z0dCZWtqZ1pLVDZoek9oQ1Avb1V2c09EeFZISzNCRTlGS29vci9aT0JkQWlE?=
 =?utf-8?B?emNOMG5HYkE5Nm53bXUvd2cyeGFndE14NUEvNjFoRWRvcmUwNkppcDFiZTJN?=
 =?utf-8?B?Q3JsZVlhNTBZSlBNNTZRMk4rUk0xbUpmNW0xK1daNXF6UVUyWFZBL2FBOE1O?=
 =?utf-8?B?VzJzZjhwN29tTURrdnNaQXQraTIyeXE4MVN6aWpyOVZOaytZc1dLMEhDNWVm?=
 =?utf-8?B?VTJpMEJxWk1HVTRGVlo3QlZRdWVkWEhNdkZtMTNVMHpQZ2h5V3lxQVVtMCth?=
 =?utf-8?B?aExMdHdwODIxMGhhMHFwcVdOdG5Ya3hyR1FIOGpwRE1xUGlrZE05NWdEMmRO?=
 =?utf-8?B?QW1UckRnM3F4UDNCV0V1azVNTWtTZU01MWpDeG53d0JkSHBnZGphbnpqS0VH?=
 =?utf-8?B?cEpuRHp0M1YxYldOeUtzRXRqbWJ3NHdqUkJkMmo0SXppa29OUnpyT2dpTzMv?=
 =?utf-8?B?cWhROTN1eVRhRGNzV2drMFpHb0txN3h6VlVmS0ltNEI2MDJLUGx5YTBRSzU3?=
 =?utf-8?B?SEVQams5dVA3UDVpQ0VGSStxMzQrK2VoeVFXdE5aZnhJTUVOeUNwZnNBaElu?=
 =?utf-8?B?Y05sWHBBcGRBZWR0UWVwcFovbmlTUnRqUG8xWXNZaFpvTTl4K0VyRjhsWERF?=
 =?utf-8?B?K0JzT296RnhlTTdFMkJSR0tSVzNpL25DQlplU0dnRjIwUDhHRGkwMUtOTSsy?=
 =?utf-8?B?cUJSTEFxREM3UHlpYWdXNVJna1B2aWRVaHlxbkxPZmxnakh2K0JVdEdVUU5j?=
 =?utf-8?B?ZWJmeUc0K1dDUnlJVTMxWXhGVFU3NmkvMW5NOVRlTnB2YXJxMmlYdnpPMk5a?=
 =?utf-8?B?TjhHRHlOQ2VVc1JqZ2NBWjFrMHZCWUVQSmhBNjgyQmRnSUpVMmtXS3c5TWFz?=
 =?utf-8?B?djFQMHRpdjBscDdIZlhGQlJuZTJ4ZzhUdFBxTjdzK0tLY2hwMm5ua0pOL1Bl?=
 =?utf-8?B?bVNtN1ZpNXlKMm1nY0psRFFSWHhVR0pSTlU0R255TkUrc1VYWnJVTnVBSFdE?=
 =?utf-8?B?UGthK3lOc1pOWVZVb2lVVVVhV3VQK0hmN3hmS0xkSk0yT2NrTWVrbGw1dTc5?=
 =?utf-8?B?VFlmZUxMT245dStSMlNnY2tDaTZPcExpVkhHZkJpTWtkcm1tUDg2K0ZWejBW?=
 =?utf-8?B?c3RWcHVrYWpXMTdtaC9BWkVwcFJQZDlwUmpWNXpOejY2N3FtRG0wZGJFaHcy?=
 =?utf-8?B?ZWdjVE0xQmZLRkVUUmtnaUF4b2dHMklkVUI0YUR6UUNiT1FldVFhTWVuc1V2?=
 =?utf-8?B?bHlCbzNaVGFRRGFveU1Mb1NRNXROVUpCc1NsL0ROZWJMMzcxWDAvWmlCS2d0?=
 =?utf-8?B?NTZ1T1hnV3dNU0JGZEp4a2llYTBjMWlKUDdMNDlVdnFCZ2lIM3pLdjN0aEln?=
 =?utf-8?B?ZlU5WmcrZGFqRWg4VGxnN3pDR3lPc0ZDeUFnVkRWZzJ6cFE2S3puU0tUTDlq?=
 =?utf-8?B?UEkra3FYZDd4U0ZkVmhQUURFOGh1VEt6N0owc3BYd3M3THBvbHF1NXF5NEIv?=
 =?utf-8?B?TmdBQ0hOUFNWS2VtR2JWZUNpSWF3VGExMjhMcDUxQkUxQjJzT0JMaHFmUCtB?=
 =?utf-8?B?MXlOemEzS0R6MUx4bkVZVjgvMU85YnFWSjdLeTlVUnRMaFVoU1NFSWVSK09H?=
 =?utf-8?B?K3pQWUJQMklEVkVhL242Q0xuN3VaNkkzVmdBcnFOaXdMTENvSzZIQ1kzTEpQ?=
 =?utf-8?B?a29hNktTUzFnZlc0WFpjdDIvRmhsbmNCUVBwbmlEa0JYdUZlZHZhSitadlNy?=
 =?utf-8?B?QVdMbTBCVE1nQlNlMzBSQkNzSlZWVFcrVE8xNlNDOUtzN0NuT3BmaGlrNVhZ?=
 =?utf-8?B?dnV3UHJUU1VCOTNFVW1jTEcvSzNBT0hQOE5mTEFhUnRTUk5ZRWZGVThPYjNI?=
 =?utf-8?B?ZVBlK0RkYyszaXlGYlN2Ym5USTBQSHJUcDdVamUzK1psWSsxa2RVY0g2NDlM?=
 =?utf-8?Q?y4ecgApmsFhGPw266neKvTPAM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723b960e-b380-4c06-f2da-08dddbdab9d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:22.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ue3rBoInj3JJuMjADqyMyOntd9N285M7TH/IkQTUCm73FRY40e8AWBcqekbGRHYfzd5KyUK2izwoIQ6+uOCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

This patchset is to upstream various downstream changes.
- Correct edma channel for lpuart7/8
- Add System Counter, SCMI LMM/CPU, V2X MU, coresight nodes
- Update alias
- Add phy supply for netc, pca9632, pf09/pf53 thermal, spidev, cma nodes
  and etc.

dtbs_check will report a few failures, such as linux,code, db suffix.
The failures are not related to this patchset.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Joy Zou (1):
      arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid

Luke Wang (1):
      arm64: dts: imx95-15x15-evk: Change pinctrl settings for usdhc2

Peng Fan (10):
      arm64: dts: imx95: Add System Counter node
      arm64: dts: imx95: Add LMM/CPU nodes
      arm64: dts: imx95: Add more V2X MUs
      arm64: dts: imx95: Add OCOTP node
      arm64: dts: imx95: Add coresight nodes
      arm64: dts: imx95-evk: Update alias
      arm64: dts: imx95-19x19-evk: Add phy supply for netc
      arm64: dts: imx95-19x19-evk: Add pca9632 node
      arm64: dts: imx95-19x19-evk: Add pf09 and pf53 thermal zones
      arm64: dts: imx95-19x19-evk: Add spidev0

Richard Zhu (1):
      arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2 regulator

 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts |  29 +++-
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 120 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 165 +++++++++++++++++++++-
 3 files changed, 306 insertions(+), 8 deletions(-)
---
base-commit: ff837884a4642382a24d10fd503acf2c3a472f10
change-id: 20250813-imx9-dts-664f7ba66ae7

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


