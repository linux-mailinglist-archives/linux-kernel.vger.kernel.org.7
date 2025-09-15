Return-Path: <linux-kernel+bounces-816370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D2B572ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB11898955
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B212E5418;
	Mon, 15 Sep 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9y3LOBt"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A52F0C64;
	Mon, 15 Sep 2025 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925039; cv=fail; b=XrO3pk3TRI4Kn7qzSB0up3rua2mn91vBVkj8E/qwGsfZqqoxFjnfsb1EDqEZBdTO4rFLjJEGbKiTBk+aBjpHHC3vXle99cJymdi/2uf7lHI5RKQYyZN6h+eB/TAmCAG8aoKSStILA+XXKYgNduzcI6i7AuZuD9WKRZ+LozR4uzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925039; c=relaxed/simple;
	bh=/f/t/uvptCFsPsDbOruMFADsd8OrSPUdYLFUpJTxZ8M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cah6SKlnqGon3aB3LQUhNybRO1s30RLOQEQvucOxikvDZABrOP/cnxvf9U85z0T7v1IfT/j/pu7OSbxLewa1aEN8V6FA5BLBCSmm4d43XrVnfVSEbhhe5ZsPo8GDCneVlTREiY7R4v97CNeBiG2mUigH8p7fCVKJ00r6EyrYcD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E9y3LOBt; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiogRlaRGPH9IPxUhNZS8QKeqXboA4nxBT0nhFXADhGnatt6LjywcmT/PAgQJDwVaRHqyjxIpL6JcIfaHX0Z0GWAafxIURSkYF+U04+WlLZkKLkxLShFSppdpch/b2CMolzDnoL464pab6ED47ASilGtts/RX1mifa1P/TxAutPEwAXN8x6nPoGwIq40002Z8nUX2i592gNnfdVJiRB+h1l6lsCalRGW+nKxsIsGZbOy97MoSaPR8+8xYbl2TaRthZhXOWzjNZlvMbh9ruTHIojmEjIDLWwev500JEh0oOz/PHDi2gn3YlEmQ3uOWCDDDxKnqqIhBwaqiW4PRnP5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIJfCg4N2oQGUDEPTId1k3KrZRqXxJU5TwK1ZfHn4bY=;
 b=zPze5HJHX7nLOqtjGr+kcXBskQcbPfP+oJDXZ+leMrYidsCbSl8uicfzVoa1SqSW4CxbY4K43TGkENffThiBRr74HfQ1aEnFqq5OAO6tcl4SxhoANQHDWvDGOAuqprST0kv+75PpWswNh3uWM+Vh+UsOvuVd/BQXeBBUdTHTimaCs7UAWybdfQKlSTWWEknNfDLDLkUmz9yjcq+A9ZHfwgPRXcZJfHEbbUoupg6RL5ATeDEPR0Nus7NWzf6sQ6XITZxm1d6NvKZQohrXE/quay8uFRw+6wlnp6TaQMvRbuttzn1QpMWRuQZTacX3wFy5lnRX5oU6WCf4NZLjbdEoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIJfCg4N2oQGUDEPTId1k3KrZRqXxJU5TwK1ZfHn4bY=;
 b=E9y3LOBtsok/TLpr9sFx84rCC7ut0InbNS7cF5a3eC+TwBavWeKlmAfVD2xTDHNG8O1aqSSM8pk51H+vsA4fPrkfo+27tpsCMqslVR4Kbn5pWlgApMe9eao2ikaKQCS9FkxbB+9Yjfs+v61hTmmTx+KVVqEZxajyR1j0JcoUEa5v9/+T3MQH/KLmu6hwM+n9sz9vkjdH3FZz8aTT4qmUVrlgwa+GH+DvCL+NtMW6eJ2/AEmXX7jg2KaMUPgdsYQ509GkenGrS+33taeVaE7FCI9wm5QMFmNE1XRmIl9gtiJvBSNXzSBACJ/DsGELV16/kiReVAT2NQVoO4FfbacdDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 08:30:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:30:35 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 15 Sep 2025 16:29:39 +0800
Subject: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757925004; l=6023;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/f/t/uvptCFsPsDbOruMFADsd8OrSPUdYLFUpJTxZ8M=;
 b=gIXahYYYynJk3KpjZj+JqdZuxsiIzKms0S5QI7cjes9KG5LBE/CL+EAHbooqJDt95kTlwwPnA
 yQQ6Uvkxsb1Bak7ETAnE9cirD2Pd1BAZvEEkWLO/kRaOMxpyojxAkFl
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d15b8ee-bdcb-4026-98c3-08ddf43224a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTZZUWh0cGF2UUZTdTRGZVFVWHBYNGg4UWtFd05CbVRURDdSQ29abTFSWTFH?=
 =?utf-8?B?Zm54U2o0MlBjMnpYQ2FYNnhHd3FpUXlpOXNobG1pU0N2ckZsZENLQUNpK3Ro?=
 =?utf-8?B?Q1lCWHIwaXdoL25OZmJ6L2RobVVrMXQzYUUvK1YxeGpCcXRYckhwT0dkS0Vp?=
 =?utf-8?B?VGdvTDNoWStCLzVWQXdKL0RwdkhubWJXMzl6ZDdkczFaaGZOTGZuMjVLNk5w?=
 =?utf-8?B?QlRZdXBsaHg0YnkvNnh0eEQ1MFQzM3JqZlBYanNSVkMzbVFsbk5yMTVCa3hL?=
 =?utf-8?B?L1Y0a1BXS0szYlNVRForTHNJOTdTK2F3MEE2c1dldUpBampJZnF4K2RKQkRo?=
 =?utf-8?B?a1loTzlkams4RVRVbUF3bmNsV2dES3JpSDluT2Zqb3JYbmRkTkpoQ2hRcFRY?=
 =?utf-8?B?VjUzeUc5RVovZW9Xa1NXYWNsOXBtblV5ZGg3WElSUU5aWWR0MHVyekRmLzBr?=
 =?utf-8?B?QUxTYVBtOUppVGJlRFg2OTV5RFJ1ejUveUNBcXpVTmFiNWdOV2FGNW42UUll?=
 =?utf-8?B?RStjdlJyTXdySWY0UEFGMmtyb0dQVXExemVFZDhiUzAxSDRkTVpoYnRwdUJB?=
 =?utf-8?B?RkdNRG9pM3BkRmJyVUhab0grM3NyZnhvR05BRVNzMExBOUg0UTFtUktoTVVW?=
 =?utf-8?B?L1NSUGJ5QmJvb2k1eEFocjVFTUxnaXAvSGNrSjllRnQ0djgxMlNIWjZadnVq?=
 =?utf-8?B?R0Fha1Fpb2trVFhwd1ZOVlNxblhpRHFIY3dYZXByOVNVMjZEclVIR0M3Ni9w?=
 =?utf-8?B?TExEbDg2Z2Zoam12M3VSZTY0SUoweVJHVldvQzAra0FzNURMbllwc3dKVWF1?=
 =?utf-8?B?Yk15YWZySXNzKzVMVFUxSEJlSzcrT29mS0kvTFNEVkFiaHZSTEFXVHhlTjYy?=
 =?utf-8?B?T3pwMG9wcWVUZ05RQ1F4ODhzcWdVYW5kd3I5UjNoQzFiclk3bVVKVFpJVjE4?=
 =?utf-8?B?elJBWEYvMW5lQkJKTFd0cFYvSEhEUHdVVmdFcXNFZyt0WWNZTEE3ZC9qV1Bz?=
 =?utf-8?B?THRjSkw5K2R5ODAxVm1pNEFGS1ZJNzZBUHZ2SkpLdDhQNDJGWFg1dGZQSEww?=
 =?utf-8?B?MmUrYm93QVlDNzNxaklBNzNZZExKZjFJMStRTTFWQU1CL0dHL1lzUUNjUjF1?=
 =?utf-8?B?b0xjZ09vaGZ3WDh1Z0o5N1JwcTZiS3BlcDJIZWx2NWV1Si9wdTZZeXY5L211?=
 =?utf-8?B?WVQya3JHcXcwNjFWbVNDV0FHUWluNWRkTlo3MjV4TmtnYkd0WTh2dThxQ3V6?=
 =?utf-8?B?bUxjRTl6WXZPZmp4UlZlOE13dzlWb3JxWDVyTVlDY3VzMERkeSt1dWw2THZC?=
 =?utf-8?B?eVU3ZTN4NWhicENmbi9XOVpPZnVISkFGY0VVUlBTbkhWS1NySVlyOGk5akJV?=
 =?utf-8?B?S054U0FFdmJrNExvbFlSTkoyY3hKYkVPNXR0UEdRNXlKSXkyRTRvandGV05V?=
 =?utf-8?B?NUE1YWQ0QXdsclJQY0lYeEMzZ0JGOWk1RHIzV05DVVgyVlBLSWdUak1kVkp5?=
 =?utf-8?B?ck8vSXhNNlhBSitITkNlSkVwNDFQem9Qb0xveXVXaWNMT25hM1FTUFlUMzBz?=
 =?utf-8?B?NEhmTDkyYmVwOFE5VW90RElwK1M4WWxpRW1LOXU3Umx6WWM1NHZDZ3h5U1VN?=
 =?utf-8?B?M2V6SFhsMytpczJxU2FWd2llVVQ4cjJNWnI4NGpPMUY2ZVdNWXlLNzdqWjVj?=
 =?utf-8?B?ckh5czNXbGQ2ZEU3MWV3NG1FYlFZaWtkeWVKRE1HYXlWc2JMeEtWR2RNQ1RM?=
 =?utf-8?B?c2lTZ0gzN0JlVVZ4V05XZDdtYnFkemNQdGs3UE9KZGV5SDMxS2oyblhLeTJx?=
 =?utf-8?B?Q1NoQWRkSGxqWGhjQ2xsRko2Mk5ZSEpqOERPOVlkZXlXRW5pZzBNUG5ndnVH?=
 =?utf-8?B?R1EyWkRzSmZ1WU40R3VRWHZ0SkpPVjhWTURyOHRIVEQxbWEvclpwQ3IzYXRa?=
 =?utf-8?B?RVZlS0gyZEFoMlBheW5hbHZXRlljZlJLTExMaEs3TitEa3RIck9iWXpkZWFK?=
 =?utf-8?B?WUZvaUNqY053PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RrWkRMckcyNUQzaVh4Y0cwSnF2dmtWUU9nSkxNRjJVUDZxZ3doYkJKR0VC?=
 =?utf-8?B?akNPTnY2N1VIZWJ1aWVNLzNNcG5PVkRnWVExYlhwWXlRV2wzTTRIMmpEb1Vr?=
 =?utf-8?B?T1lFRUY1bG9vb0xMRkEyZVN3VHZyUXNESElOZFNiOXc3OUtWd2oyTUQ3VmlU?=
 =?utf-8?B?K0tHU1VtcmYrUGhpYWJpSjFHV1l6eENpdE90VDBNTy9aWHFHbW5IQ3R3UEFN?=
 =?utf-8?B?R3BzcFZHQmRpZVB4bXQ5VGVLVTZKaHhvTUFYU1ZkbWtvZ1B2N3R2SXBKb3ZB?=
 =?utf-8?B?VUxwZjZHSytLT3MxSmt3VkxRbGdPcTJjb0I5YUtjdUlTUnpaUkhzMlF2aStP?=
 =?utf-8?B?NnJHc1E2aitBUk5jTWdMcUdYNVYvZzdVOUQ3cDhWUVJxb0V6dEZTMjJMZ21C?=
 =?utf-8?B?VG92b3NmK1hNUUErRnU2em9YbFV4WHNyWFRSMzRXeVkvVVpLTVF6VUoyelFS?=
 =?utf-8?B?K0Q1bnFQQ0JzZThEeDJ5bllUeHZid2hhT205NUhaT1RNaVI3VjBuYllJSkVm?=
 =?utf-8?B?VGp4Q3crMkROR3Ird0gwYnRnazlKUDRZUW1iMm1nUWdOSzF1TWdpODJJME5O?=
 =?utf-8?B?N3JLcGltTm9qVDNSUXNqN0hoaGV1YjVYRWRYTHg2SkVBSzZZYjdIRGVudU9W?=
 =?utf-8?B?aGNrOXo0U1o2Q05jUzZmL0pQdTNkQm80Y2MreFczbkIvSWhSSHhpRkZmT0F5?=
 =?utf-8?B?U3B1VDFtQkYzcFFjR0hZY0FCcFYwOVExTUNiR1Rxa2pnYzFvWlpMZ3pXT1dJ?=
 =?utf-8?B?eG1kQktncG85RlVBbCtZTnBEUDhXS2hzR3pFY0JtYkJYdnNRbWxaZGZNa1ZW?=
 =?utf-8?B?Y21PM0N3TVZDWWJRWFdqcm1ERXd6Qi8wVGNCUUxPZCtRYUhYRnhaakdMcWpo?=
 =?utf-8?B?YnFiaHdzaHJFRUJGSmxjQnhsWnJ3aGtTS1ZOVE52YlhDY2FNSGNtWWNFdVYz?=
 =?utf-8?B?cE9IcSs1dDRtd0FwZncrZkZUNEcwbWJWZEFMWDJiRzdUaTNZRHFJOXllOGpn?=
 =?utf-8?B?a3N5UWhBMXpjT0o5QVpEakZoWGdzVDNrYlJyNHlPbm1UQWFYemlBZlFvaTln?=
 =?utf-8?B?QXptM21Xa3BjYm1TaTl3VVlsYTA4UmJFMFpWeXk2dTdnbnBsVGtHYlAyRitP?=
 =?utf-8?B?dmZvOXVPQ1ZhenZWVURjSkVTbWIyQUtrekVHN0cvYXh2NVFpVVV6WnZwTUN4?=
 =?utf-8?B?eDhYcTJUUTlJUHo4QmhWOEJFWVJMNmI5UDQ0Z25QYmVoWlZUTkxZQTBmSWNH?=
 =?utf-8?B?bnZxRisrdnhMcWJzRTdIWG9ZNmxTcy9rOGlyTzJPTjZYeXU0V2Mvd2RMc1JD?=
 =?utf-8?B?ZUdkUCs4U212MXNVa255WlhsMVUyUm9NUzNxOGllbnNNR2xkcHJVTkxHU3or?=
 =?utf-8?B?Vk03NEIzNzExeW5FWXQwRmlvVC9jRng4THk2bkROSDNNWUdncWlhVk1lUS9w?=
 =?utf-8?B?WGo4OGwxTGlFSUFQOVA1TXdkU2NvWDA5QUx0NjdjenV5S2thQ0VPdmJJNTlJ?=
 =?utf-8?B?RHU1djhFTGVjRE9jcGp0MmVHS2pXTE9BN1N5MXVLNGh2MmdVdkdpVmNSMWIw?=
 =?utf-8?B?bjlYcCtBQzh3R3drMVM0cllMZ2MxNUYxaFROZjQwWFJKdEZwZTFlYmgxK0hy?=
 =?utf-8?B?Qk9wNmh0RVpSUitOanRlVko3SkU4UFJndDc3NVJDU2VWQy9RWGRxSGlzY21q?=
 =?utf-8?B?dXFjQS9hblAyWUs5cmRJL0g4Y0Q3M1paeDVrVm1SWThsdXlPSFUxVnh4Z215?=
 =?utf-8?B?bHNQZjYzZ2UxWGxLUTlKTDRBT09oQzI0VFpNczJJNy9zY3dPOU1kQThJMlFx?=
 =?utf-8?B?RE9sRlE3VFp1cmJWcUZhT2hndDliZkxRM0VITHdhQWQ0Y2xrTmdqT1BLMldt?=
 =?utf-8?B?SVVjTHZkeWFxQzludENvYkZ4RzdiZnV2bVNqQWFoUkl5QkZaY011UlpiSnMx?=
 =?utf-8?B?ZE44eGhvaUZxS29rMzZXUStNZmcrTERXUXI3S1FiQ0RKSTk1NkNlUEQ4UWs4?=
 =?utf-8?B?aHJFT2JaWWpHRnIyT1Z4ZU1JazgrWGJKR2t0Wjk2NzJLZVBLNjAwR25FVU8v?=
 =?utf-8?B?dnNIWFZNNGs0bDRodGdZTTFsdThNWTQ4N1pLZkUwb3VMelRkeWZnbTI3VHFE?=
 =?utf-8?Q?H+wAu+M408yINbtgyooKt78rJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d15b8ee-bdcb-4026-98c3-08ddf43224a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:30:35.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zclcZ5km4SW1ciS7j2a1Rxv4N5XK/jkSOC4qm+HXFHDD8onpBLX2hZYNvKPAte8swL/EEdsn/WkudUHz36Hemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

The PLL clocks on NXP i.MX95 SoCs support Spread Spectrum (SS).
This patch introduces scmi_clk_imx_set_spread_spectrum to pass SS
configuration to the SCMI firmware, which handles the actual
implementation.

To ensure this feature is only enabled on NXP platforms,
scmi_clk_imx_extended_config_oem is added. Since SS is only applicable
to PLL clocks, config_oem_get is used to verify SS support for a given
clock.

i.MX95 SCMI firmware Spread Spectrum extConfigValue definition is as
below, no modulation method because firmware forces to use down spread.
	 extConfigValue[7:0]   - spread percentage (%)
	 extConfigValue[23:8]  - Modulation Frequency (KHz)
	 extConfigValue[24]    - Enable/Disable
	 extConfigValue[31:25] - Reserved

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c        | 64 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/scmi_protocol.h |  5 ++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d2408403283fc72f0cf902e65f4c08bcbc7b4b0b..bb5e20dab18e92932ab4b99192b496e0c4d96417 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
 #include <asm/div64.h>
 
 #define NOT_ATOMIC	false
@@ -23,6 +24,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_RATE_CTRL_SUPPORTED,
 	SCMI_CLK_PARENT_CTRL_SUPPORTED,
 	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
+	SCMI_CLK_IMX_SSC_SUPPORTED,
 	SCMI_CLK_FEATS_COUNT
 };
 
@@ -98,6 +100,35 @@ static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
 	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
 }
 
+static int scmi_clk_imx_set_spread_spectrum(struct clk_hw *hw,
+					    struct clk_spread_spectrum *clk_ss)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+	u32 val;
+
+	/*
+	 * extConfigValue[7:0]   - spread percentage (%)
+	 * extConfigValue[23:8]  - Modulation Frequency
+	 * extConfigValue[24]    - Enable/Disable
+	 * extConfigValue[31:25] - Reserved
+	 */
+	val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, clk_ss->spread_bp / 10000);
+	val |= FIELD_PREP(SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK, clk_ss->modfreq_hz);
+	if (clk_ss->method != CLK_SSC_NO_SPREAD)
+		val |= SCMI_CLOCK_IMX_SS_ENABLE_MASK;
+	ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 val, false);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to set spread spectrum(%u,%u,%u) for clock ID %d\n",
+			 clk_ss->modfreq_hz, clk_ss->spread_bp, clk_ss->method,
+			 clk->id);
+
+	return ret;
+}
+
 static u8 scmi_clk_get_parent(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -316,11 +347,33 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
 	}
 
+	if (feats_key & BIT(SCMI_CLK_IMX_SSC_SUPPORTED))
+		ops->set_spread_spectrum = scmi_clk_imx_set_spread_spectrum;
+
 	return ops;
 }
 
+static void scmi_clk_imx_extended_config_oem(const struct scmi_handle *handle,
+					     struct scmi_clk *sclk,
+					     unsigned int *feats_key)
+{
+	int ret;
+	u32 val;
+
+	if (strcmp(handle->version->vendor_id, SCMI_IMX_VENDOR) ||
+	    strcmp(handle->version->sub_vendor_id, SCMI_IMX_SUBVENDOR))
+		return;
+
+	ret = scmi_proto_clk_ops->config_oem_get(sclk->ph, sclk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 &val, NULL, false);
+	if (!ret)
+		*feats_key |= BIT(SCMI_CLK_IMX_SSC_SUPPORTED);
+}
+
 /**
  * scmi_clk_ops_select() - Select a proper set of clock operations
+ * @handle: A reference to an SCMI entity
  * @sclk: A reference to an SCMI clock descriptor
  * @atomic_capable: A flag to indicate if atomic mode is supported by the
  *		    transport
@@ -345,8 +398,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
  *	   NULL otherwise.
  */
 static const struct clk_ops *
-scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
-		    unsigned int atomic_threshold_us,
+scmi_clk_ops_select(const struct scmi_handle *handle, struct scmi_clk *sclk,
+		    bool atomic_capable, unsigned int atomic_threshold_us,
 		    const struct clk_ops **clk_ops_db, size_t db_size)
 {
 	const struct scmi_clock_info *ci = sclk->info;
@@ -370,9 +423,12 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (!ci->parent_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_SUPPORTED);
 
-	if (ci->extended_config)
+	if (ci->extended_config) {
 		feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
 
+		scmi_clk_imx_extended_config_oem(handle, sclk, &feats_key);
+	}
+
 	if (WARN_ON(feats_key >= db_size))
 		return NULL;
 
@@ -459,7 +515,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		 * to avoid sharing the devm_ allocated clk_ops between multiple
 		 * SCMI clk driver instances.
 		 */
-		scmi_ops = scmi_clk_ops_select(sclk, transport_is_atomic,
+		scmi_ops = scmi_clk_ops_select(handle, sclk, transport_is_atomic,
 					       atomic_threshold_us,
 					       scmi_clk_ops_db,
 					       ARRAY_SIZE(scmi_clk_ops_db));
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index aafaac1496b06a6e4f0ca32eee58a9edf7d4a70f..37f422b4b1ef2af2b4231a1677161aa24e07d0e2 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -80,9 +80,14 @@ enum scmi_clock_oem_config {
 	SCMI_CLOCK_CFG_DUTY_CYCLE = 0x1,
 	SCMI_CLOCK_CFG_PHASE,
 	SCMI_CLOCK_CFG_OEM_START = 0x80,
+	SCMI_CLOCK_CFG_IMX_SSC = 0x80,
 	SCMI_CLOCK_CFG_OEM_END = 0xFF,
 };
 
+#define SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK	GENMASK(7, 0)
+#define SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK		GENMASK(23, 8)
+#define SCMI_CLOCK_IMX_SS_ENABLE_MASK		BIT(24)
+
 /**
  * struct scmi_clk_proto_ops - represents the various operations provided
  *	by SCMI Clock Protocol

-- 
2.37.1


