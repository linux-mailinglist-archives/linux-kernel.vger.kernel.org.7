Return-Path: <linux-kernel+bounces-770552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A7B27C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2840F3B8328
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3227147D;
	Fri, 15 Aug 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TlFjziD0"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E29270EA3;
	Fri, 15 Aug 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248678; cv=fail; b=BoFA8sLE19rmCUtsNEkgRQjT15ELIJgkALe1PsAaerkvS/3HKrfgHK1rXzz0BcwNFgXpL5hI7SbCjJIeRviXXLeuXYFwkd200QfDn3Q8ow91BMq0fNsoJWXLNdpbWyRUeyDKtgWAmI8fDtZToOBg1ylgxojGQmEfxHSvjDmuo3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248678; c=relaxed/simple;
	bh=Spu1A62zcmFVaAjIS7wf/2jxuUlcbLvSoWrERnDv5jE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l0ZaOzWhYRmqH1Rmia+oJbkd1BYdHamAVXfwWgk+juLJHgkuLCsXMzwcHnHiOGoft74BldAlJa6EFfTj98C89/9GBQWJFgPjDuf9J5jRTUIx+XfZCroHlYffR7quw2C2rkg55eP6gafUQ+WpxmPEm4D9fSUR44kSfLF8zUNay3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TlFjziD0; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWd+q1s1dyoVyvE/fOWDukWvtFFcN/RQ4gWJHlyeGru55AMfmOOWZwjGvJUS4upA4pdL1ol7crAMI+au4gKb4gKavv9OijWFdtDDMhHIvKeRjP5fHCntrMaScKTZpKRZlYXnjJMeRY/Qccgp2Sb3tzC/Y7cSp061BAmek0FcI/Q2kOb+iweB7X7KBrh6bx6vpt67a1N0aaKA/VPy0vPybGPVAA+NtL5f51NHqo/oI8B8M0Pt3MM2+vobdzPYQ4VTjqtKu92eB5VRIFZtx2sdORV7z5Lz5Dt46t3NeiHc2hZnOnUdhcvS0rbPibpjbhE82kn8VYogUp5TZ2pUR41jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuNFUUocYbuMFvC3pj7CnEQFfxhAJ8kGa/3GARn/3bk=;
 b=KsQv4OTCQyUdBNOHtJ5ENb1prGou3cmiYNV4AoEbCQFcrMVzTasCTgrCFb8ORIWMQSRM1dL768NXvRc0idQAOhqrW56qBjAu04EWg6M83uZLgZ0Gc6WWiltwoR+Zm3/xUCZTW/DRh0QnJ1B12TPa71jmeabEYEkRfiD8ItLgI2fZzK7N+pLrJiWNSgmPZo7+SdQTSHuaHxE7G3SjvWuVmbdj07xVx8sG7bNqiz5szPGHPQkJ12ugFc1eq4O7/YqPc/LFcG3vTIG6L0Us6D5K4zRuVw/kMjNJbSSP6ZVvOFgiTW4q6rti6FZHy40mS7vZdu7W9JIX11cYWgaL66ySMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuNFUUocYbuMFvC3pj7CnEQFfxhAJ8kGa/3GARn/3bk=;
 b=TlFjziD0BdjDjtkasN7lBzRpjhKtGnX6r5jQf2Om4v+kso0kAUfkVrfs7LAfcAwRTkcpAPBzW0zPbu9HtfY3EETxHoQKPpCRMPrNI72r9Eb1Le63ny1ET/923CwlRhVEE9uY2PpmPf7cyCVAyBvMDmAkjxU1zE5YU8iB2+wy9WHgEhuynOgwuYKa3oNZNEGo4/rrEV7JNgWkuIwvc9amCULNbKkLfLU79xOQzCjSBUQFecGZHzY5Pa6EWi3fQazkntgMFZOE8GB7vK/wrwBapaUtSdzNK02GhG5cyFwkLp3NiDEjqrvxL4n3iYRvXGI8/Y+ZDdCZQdlgB4XbQKgiBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:04:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:04:35 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:49 +0800
Subject: [PATCH 03/13] arm64: dts: imx95: Add LMM/CPU nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-3-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=834;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Spu1A62zcmFVaAjIS7wf/2jxuUlcbLvSoWrERnDv5jE=;
 b=PNIQdj6inui76xncKj+q3iQfY4Rx/BfplQo8IiIy4wy/OV/EyG66AYQYXlLo//zVbF3jr3BdH
 HRZDsKGupoEAG7WKC1d/CasFK0RbARU02n8JPwjm55uiCok7AXwIfSz
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
X-MS-Office365-Filtering-Correlation-Id: ed826621-f3a6-4995-2885-08dddbdac154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mys4RStVYjd5UEdpYW1zcFI1SFFEZFc1NzAvVDhFUWovYWpwR2pvNHdRdHF3?=
 =?utf-8?B?TzBiMVlVQm0vN0NWL2tid1h5UGkrbEtuQUFkZmxFZjk4aTBrUHZtT3pqOUIx?=
 =?utf-8?B?aHgxVnVKZmIyaldhMlJBSmFxcWhZMTRkU3lxRDgxbVNpdTl6RzZLOG5tNDRq?=
 =?utf-8?B?b0pXVUY0OERpR2hoNE92bWlEVENOMEtYVVYzdWFDdE16VXM5eEhNVC9IblBq?=
 =?utf-8?B?ZWtQU1VKTjBUQ2VTV2I0M2psYnk4aTFGcnpzLzZQNmtpL3loUUJWWWhCc1pC?=
 =?utf-8?B?SnQyc2hkS3ZiMUp5Qk51QXNDd211VUFHbWZ2bmVLZWZuVFhGbjNqb3JUcDZz?=
 =?utf-8?B?MDdKY25QdG1wVVFyTVU5OG5vOHNDL3ZPakdDd0VvZno3ZytSMVFpNFNZUkdF?=
 =?utf-8?B?R1dPMFd4eW1OL3N0NDQzS0JsWmFKZmtiblZUMTlOMXBwUlhMbCtxYnpBeUpr?=
 =?utf-8?B?N2o4dnNaMXk3YjF5ejQyVG8rZ0xPcUlMQ2djVG0zTEl6YjcxTVFtRDVnemZw?=
 =?utf-8?B?aXRoM2laa0xPRGl6TEkybFZQaFRSY0g5ZjVqZjY0UHQrbEM4b1FnT3JncVhY?=
 =?utf-8?B?TGtRbmx1RHRFZzAxMEx3T0tsVGVVUWpLL2YwdWEreDVNTFdra2lVVnYwaG9R?=
 =?utf-8?B?VzdKQjNweWxyYkg5MTBEWkE1bXlTRittWWpBRWRoZUJZSDVsUHFMWEcyWmRL?=
 =?utf-8?B?UENZbG9UNk9nZEViOVNoOFN6RkVuakNXUm1ZUFo4cFF4Z1NFNVdBdndvekZM?=
 =?utf-8?B?ZWxPYWRYL3Nac0Z5SDRVWGVYTUZ4MExvM09lWUdvbi9yeTlqMVVnRUtDRGFK?=
 =?utf-8?B?aGREUlBiM0NqQVIzaDJJSmZQMWFMV3JOUm5OdFVsTTRLa3ZiU1R5cVIvY1ZO?=
 =?utf-8?B?UVpieFBnb3ZJS1RYL2ptb1VEUVNBbVJ6TVJMUVF6M0dpUXhVTG1sa3owVEV4?=
 =?utf-8?B?V3FGWVZSZTFHUlZWc0NrU1EwcktoeVJJV3F5V3IxcXJ1c21uSjhGWitWUWZ4?=
 =?utf-8?B?SzlqOTNnOHZ6YXFIcGFmWXlObXdQU3ZndGNkdk1Oc296YnN3Ykoyd3F0MGJv?=
 =?utf-8?B?NTlQbXB4WFh3V1VwcSsyd0VmSnFYcFpZYnpSaUppSG0valJYMks3OEg3ZFBw?=
 =?utf-8?B?NDFpczVtTmlzQnFmd1RyVGNLQm5ib1ZabkJoUmpTbVkwRGppL0N1dGY2Mzlw?=
 =?utf-8?B?Z3FKRGVxRlB5d0FSSmdOQW03RFNmdUtoYWpIa0EwMVFQTjYwbFNqYnJhaVBG?=
 =?utf-8?B?T3RtczE3S3Q4c2tiVzVPZWkvU2Y2clhtVjZSMkhkYktWWW5SN3dzMmcyVGoz?=
 =?utf-8?B?YVZrQVBMVFhVb014dGJLa01RbjFoOHI0QzE2aktJdk5lZnRrZGZOUnNNd2Fs?=
 =?utf-8?B?S2hsQStBQlErYm5lNFg3dk9Sb2QrbkFSSk1BWDJRWS9TNWhQWDg2YzVFdHcx?=
 =?utf-8?B?QmtsazBrK1NqN2F4KzYvQStqL1NubStJeUN4ejdJRDg1eitRS2lUS056b0NN?=
 =?utf-8?B?Q1BRT3hqTkNFeXZTckp0RDR6cWw0bmlmdmtNUVIwS3VKWlRST1FCeDY0ZS9w?=
 =?utf-8?B?WHFRYng4cnR3Njc2ZDVucWJrL3pQdVBCUVFNWVZKdlVvUVJCUE82bGptV3hy?=
 =?utf-8?B?djZNYTIxbkJLWHhTNDJvNWtJaUFBaFFGNzNKRkUzQ1pRa0QxeGg0K1JoekNy?=
 =?utf-8?B?MWJkd2hWb3A4bVNEYnY5S0RqUlluLzVlT1l5R1IwTW9ldzJuK1UzQzJ3dzI2?=
 =?utf-8?B?SXJCdEpuTDJ3TkkvV2xQb1lXVllPTldzNFIzbG8xUmhWYThXUFhQazA3UmVt?=
 =?utf-8?B?ZnkzaXRFK0FhRUZOSUhpRURGM1orc3RRZDJmc0ZnckdjcktraWV0L2FyQTBC?=
 =?utf-8?B?WVlVbDFEdFNuSmFIZjNBdmVURTc5enNsWEh1ZHc1WFkzdlVrVEI4VWI2QjBi?=
 =?utf-8?B?VTdWQ0hwdXNVVU1QbDY0K3VVWWk0K0VHNVFCb0QvSElwNEZ1ZEIvM2lUUVN4?=
 =?utf-8?B?Zi9zTEhWMzNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkhpNEVpUzhPV2ZuQTYycnUrWFRLdEQ4WDlQLzhqWUtUMlFvcVVPSWFyZWJq?=
 =?utf-8?B?SkZ2QlNDYndWS0RicFpKL0VlTUY0OUh1L3RwK0JkUlZBaTBPWmg2Vk55cUk0?=
 =?utf-8?B?c1E0OVMzcllPcWtFOEI3V3JqQ29BaVdOVSttM3ppODdYa0hEcEVOenFUdkF4?=
 =?utf-8?B?Y3FtdFhCUGtTdEpGRkRGWkFoM1dONEowdTR5c1EzdU4zeEFaR1JSc25NUHpX?=
 =?utf-8?B?TUU4dlNhM1kwdld5NzJKNDFaS01wV3FsZUVzN2QwcUh0dVV0THRoZ056OS9h?=
 =?utf-8?B?amZrQlpMM1VPVGRNK3A1anJHQ3F6UC9VRnBSUzBsYzNBVHdzYzloa21WWUtC?=
 =?utf-8?B?aEdHK3pzNjRlbWNsRTJYcEMxa1lFMW5ndDIybkJVSTNPUEhqYjFVRThLL0ww?=
 =?utf-8?B?RS9vei8zRUNUWEJhanVGQk5rVWs2cTJiSXFyV2xNSHhnalJwSnZzWXliaVEw?=
 =?utf-8?B?cDBPeFVtUDc5QTBJVjF4MzZJMVFBZk95Y0FFNE0yMjh5UTJHVVZjMkxRQnlH?=
 =?utf-8?B?TkxpSlkwblpWVFJMWDNMVlNaRkpFSHNSU01USFBiZk1zRDkyc2RVMHpOTzM4?=
 =?utf-8?B?M2t4d1dBZEQ4Z1BONGNTQ2xJdGVJRjlEaUQwZUk5azBMbUF2eTNwMDEvSHow?=
 =?utf-8?B?MmY1WFF1QUYzLy9Zb1M0N2lCRG9OeFFtUjBDUWdGeVU5Q0oxVHZiR1d4ZzNV?=
 =?utf-8?B?SS93MHQyM21NQUtqNU01YUxISUxmckdLMCtVNlNqckRna1FyZVBuT1d3OFRL?=
 =?utf-8?B?M1E4WEQ1cDViSTdadDFoai9qaHhNQ3NjRzl2QWNMY3RPeURtSGgza1ZSUVpx?=
 =?utf-8?B?bXUwdEtSQlVNNFZXMDlOMXZuNjFYcGRwbTgwWVpobHE1YWJWMHArelBQRGpo?=
 =?utf-8?B?eGZCUnpZcHRFMHdGUUI3enlVajdXRE1QaHh3RGNLMzdSZHZUMDVMQzIyNGxu?=
 =?utf-8?B?Vzl3SlArQ293dGR2V2dHLy9xS29wcS82Y2w5cDB6SUpWU3VQMGFveDNOekpE?=
 =?utf-8?B?bWFOSVNpRWFjOVdqK21DeVVNejVHVEErUUIvbDlodHVSUzNlSXBUa2NrZzBp?=
 =?utf-8?B?ZlAwRC8xSFNDNUFGY1hFM1hFZE43bnJvN1VRL044RFczSHRGSnM1OERIam5i?=
 =?utf-8?B?QTAxdk4xbGlYTzdBVUxhdzBJcS9tWGl2NEVSUklyRG9lWWFuOTBkVEkvTDVN?=
 =?utf-8?B?VDQ1Y013MTlvUzdwSTVremNKTlZWMUNBaDFMazZ4bmV6Z2NnYnZBYUs4S1NY?=
 =?utf-8?B?UUdwNmFBNzNKaDU1aHQzK1lMQU9jWHRZaDBrbWJNWkJtcHlOZndTZC9YYmJm?=
 =?utf-8?B?Szl3ZVB5dWZUZWFiemJ1Ly9MOWpTRE1iN21VZjg0OE5Rc3lTWnlya21BL3Yy?=
 =?utf-8?B?TkZOLzRJTTJXelhWR3VCQjhsV1ByMy9JUmJoQUI0ckFIMHJ4MSs1L3JKdnhW?=
 =?utf-8?B?a1IrNk1OSjh3Y0FpcnE0Y1p4NUNYYjZRNFpqcVVlU25jZUkraDhaekVzVlNM?=
 =?utf-8?B?eEhHb21lRVZOd2xvK0xxL0owclZNMllzVEpEVm5GS2NFaU9DRlJUeVAxeE9K?=
 =?utf-8?B?RVhESmp3MTUyTy9aRDFjdXFHZ1N6UHZ4ZkF1K2RHMEg3ODF4Q2tLRGY5eUtT?=
 =?utf-8?B?bjNJb0ZSZ1YzTzVncW9QTVk3b2pDcTY3ajNyL2syS1B4Z2J6ZUFYcmNmSjBB?=
 =?utf-8?B?emVqbWNZQ25GTEhEczVYN0RDcms5SXBNNmlGMUhkZVgzbkxMN2h6ZTl6MkJw?=
 =?utf-8?B?MUlTR2V5Mys3VkdrT2ZxWTFFajQ5SmlBUWlNUlRyZDlBVkIxdDA0RVJZc0N6?=
 =?utf-8?B?TmkzdStoRjdGV1k4VGZmdDlERDUyQXpKT0hNc21ISC9pV1Bnblh3bHZkQXBZ?=
 =?utf-8?B?THBlcnI1Zmk5MWR1UCtzYXZJMkxNV1dISzM4bldDaCtvcjVzQnB0Sys5T2x3?=
 =?utf-8?B?RktSTk9sNDdpeGd4VVhMelloNXVScFRJRTgzaGF4dmV0ZE9CV1pRZHdSZ0pJ?=
 =?utf-8?B?bUNjWndzTmlBVi9hQ0ZTeEkwQU11ak8wSk1HS0pENndKcHBIRVBaOFV3WUVX?=
 =?utf-8?B?a0hXUG9oTFh0RVN0TXhGRkE4dzNiazdXOGxoei8zUGpHaUJqTnFHK2Y4M1dW?=
 =?utf-8?Q?qEEjGjJEw7oIek5RZ7MXgXbsy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed826621-f3a6-4995-2885-08dddbdac154
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:35.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMt8vuLcRvWKNJ+cBxejdK1ML12pQN6nHtUKNrlgDTzR3Ql974gh53FlKN5mTzzzBYtM9uU8X5ho/yq2d8jLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add SCMI LMM and CPU nodes for managing Logical Machine and CPU.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 642dc4b7a4770be50960f53a73db965ea4374e24..e20feb1bcec6088949e7dd1ab2fc1c108393fb81 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -351,10 +351,18 @@ scmi_iomuxc: protocol@19 {
 				reg = <0x19>;
 			};
 
+			scmi_lmm: protocol@80 {
+				reg = <0x80>;
+			};
+
 			scmi_bbm: protocol@81 {
 				reg = <0x81>;
 			};
 
+			scmi_cpu: protocol@82 {
+				reg = <0x82>;
+			};
+
 			scmi_misc: protocol@84 {
 				reg = <0x84>;
 			};

-- 
2.37.1


