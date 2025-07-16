Return-Path: <linux-kernel+bounces-732943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BEB06DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9373AAD82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E862857F1;
	Wed, 16 Jul 2025 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="Atd4gqpN"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0A2877EF;
	Wed, 16 Jul 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647336; cv=fail; b=qmBtlWgBv64EeHLH863dPEpY2TfS4lPz6j4FqkxQGKqUEFfXbxjgLtLEcM3O9bGYyGAkdCtfF42Ugi723xG6FNgPDYge5iAwaVxP+HWb0Z25NdNsa2YquZZ3HnUdFtnUkcYNp3FohwwFDQfL8yeArL0JF2UAYMIw0K8nfK6PvL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647336; c=relaxed/simple;
	bh=AbZ4ZfWV2WihvVt2bRAk0GKictwJ5oecmtZGA8KVp34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IL3/03CYAzXGzFcKAb/hO32/gpZd0lAT9nuUctMQGafZgPDocRbZP8vQs+jWHoRQIoxpW2dR/9YDRb0jkBJd65egfwZjtoN7xLJqj8iga9oC62ovvGWONKTOqPkliBJptM+hHaYPRglJgMV3QjlQhoqHOmncq9wlMOGKjp1OIyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=Atd4gqpN; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEVu/6eVriDhlQ13SB28UriqKEMPwUrcnHYOVAcuCh9wQL1mQadwLte0jP9j0phosPPbo2j45eaxXjjAmGzvIS44T1k3x7LPyWBK9Gc2P6THT/EDCQd4tLBJeFc93CT1wlpTTN+r8/62UczkQcviu71MEXeqd/6/CNTGmP8T7ikoMJggAC9TsOvMr8sFk5cKUhE0RzckPj3GQkOUN+TxA/56nRNID8Uz+yVpourniwwmMQrSyD2gs7inCoe1h1yqtISWqOLpnI82Fu66gRfQDMszwb/o2qcJwt+uIxiSlla7FgYZ9OgWXx9kai84XjD3wNTpeafE3c1gUnhqClz6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAXlT70bqDPC4tm7EcTmntMhUu5eqv5WgWGupdcDBY8=;
 b=d3lTCU1fTGOCFl+L9WGxdJ84rSZoo2OPaRu/3cPuUCZVgneWMGWPDV584GGQ3M0RgpZRM3oSbUdCikyEU4U/H+qK9ECb3qWAVSnEX+G3iZfWu0d2FpLFFB3m8/+Hdmh3z3veAlU+CuU82N7TE+d6AXr6lgybTwtpZhdFcULAFRI1mw1YL0sZHFVvW1tzCcCgzKEhQTVwfM5euhgb8RApWqqmuTiq7KQznkf9I/4I3U/rvrx7rmg7Di4c6DnSF5BvypK0hHPvjO6a0KofY7a9TyRbAsxtlR2JG5Ghq62wn7aNi9FItp5JYugX6zD4bNz8fM63D0eBjOKsca+1dapZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAXlT70bqDPC4tm7EcTmntMhUu5eqv5WgWGupdcDBY8=;
 b=Atd4gqpNS8+WAQDmixJQRWbWzg/y3TaHX2A6h9uolHai9VZDAb+obWVG6vQESfSbjuwdQD1PdVuuZa9y+CB9pzwiqeNENxWF3W5tIfTTGrEALrXl42jxla08zrR8PPiXWLtGzrnlEbtppnR1Ts3/ttG/accbrralTtiKdmYf+SzCgJLRxNbDSl1OLRwr2VuEgQq6O9SifscqO0DlBX6wTdr2fpMbN6lYAxH4HLK9QC65eptB/vXmIWElTYAG8Qxq23LM7bxWvnhUOuDVhK96tXwoMy/SM3Xmaqm5SzELlmHTa0ET4JZcsVPZMzXZoXdMOlIXUFtvDojtkangK+5H9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB5858.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:28:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 06:28:50 +0000
Message-ID: <691c5adc-9c0f-49dc-a51b-08cca38bf572@kontron.de>
Date: Wed, 16 Jul 2025 08:28:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] arm64: dts: imx93-kontron: Add RTC interrupt signal
To: Primoz Fiser <primoz.fiser@norik.com>, Frieder Schrempf
 <frieder@fris.de>, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20250714141852.116455-1-frieder@fris.de>
 <20250714141852.116455-11-frieder@fris.de>
 <b32ebf83-0c4f-4321-94b3-1efcbb811073@norik.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <b32ebf83-0c4f-4321-94b3-1efcbb811073@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 82139c75-4e4f-4fb1-2bad-08ddc4320701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG1POSthUm9qMFdocURNTU4wcWoySmxJSVVpMGE5N2FHRUxwdkRHUVB6L254?=
 =?utf-8?B?SWorL3MzbU40RHBYckVYei9RcXBkRFpPZkpBQWlmaG80MjdidGZQaFU3cnpu?=
 =?utf-8?B?WlFPSEI0TklPbkNrR2pVV096N3NQVjlDNmhjd0pwL3k5eWxWQlNadEVFQ0FT?=
 =?utf-8?B?bmZTalJrcDRRNXN5QXM1N2xRRTZSamRpTnlMVklzQVFxTmVTeVE1bDNsejVt?=
 =?utf-8?B?Uk0yQXhFbWtnZFV5NE0wbThQL1BqYUoyYWgvQVU1c05ZY0Y4Tm9NK0ZZZG54?=
 =?utf-8?B?UUc1K3kyTjF0VTdUQTNDaExhWk81R042VkExVXBwd0lMSit3ZktINXh5OS9R?=
 =?utf-8?B?SEM5KzJndUttaU1UK01lTndrdVZudXVENlZnQ1FPWkJQdXc0UmNob3hqcFpw?=
 =?utf-8?B?Q2NlQlZEczloNnFpNC9LVW5HakR6SW9mNHcrM3JlaGZVdGJKZjgvRkhIcEk4?=
 =?utf-8?B?T2x5UkFsZmVQSTc5S05FeS91RFh2dDd1ODlHaURJaTBWQ3N6Sk1lUFpCQnJD?=
 =?utf-8?B?QWg5M0ZMdnNhR2Fja2RSZEp0WlY1ekIwTUpuZ3U5b2ZRcjBtdjdYZTRacXUv?=
 =?utf-8?B?alVQa1ZGNmpPRTZia3NzWHNlNjVuQ09hVUZsZXJMV1FmWFpEUStvVmxWcCs5?=
 =?utf-8?B?MWVPc0ZRYitwVEpqNEt4VlQ1cFRyNDFabEZxZmR5UEtlSXBiNXNYSE5zU00r?=
 =?utf-8?B?QVI1WnROTkpwKzFRSVlMKzU2azZNY3hwZDN0M2p6dHhsU0pGWFBrSjVkUEU3?=
 =?utf-8?B?bHdzNGNqdmRJU0lKb2NCV0xVcldva3NtQmpGSjkxQ0dDVVZpdTdCWUpIUEhD?=
 =?utf-8?B?WUpuWGZCbjN4cGphWnRSRXdyeGo0VHh4VVR2NFd5VXNLbi9DVVg1M3NjQjhF?=
 =?utf-8?B?WUxrNVhqUFFseWRxQW5VQnZ5N0lxUEh2b2srRlM5dkcvd0l4dlkyQzFhQ3oz?=
 =?utf-8?B?K3QyQ25DYjFKbnhENG1LWDVvczdsSC9PM3pKeE5vTG5TZ2dUV0REMmJ0eGMv?=
 =?utf-8?B?SW5CY0dGWjkxTTdmOENtQ2laTWM3aUdFcDRpUlZGTjQwYWRmeEVGQnozVWxQ?=
 =?utf-8?B?cHdsY0JUend4bE1rNkVLYlJ2MkhlcXp5cFZzZnZINmY4OS9MeVY2OHZHK1pq?=
 =?utf-8?B?RldHbHMxeEVDaW9ReWZaMEVnNFVYV1o5Q3ZMVGc2ODVrT3BPSzl5ZVdydlZx?=
 =?utf-8?B?d0VUL2I0cmxLRjBhMVBHbDZua0EvZFBsZTRWaHM0QmVkME9MRlJEMkRTWkNn?=
 =?utf-8?B?WG9LU0Z2NXNBTmJMRUJiSEVFQWpIdDhUUk0rQzJKTFRKYjd5eFp2b1JoNmVN?=
 =?utf-8?B?TTNrS0R0YlZ2US9PMlZVL2FVbFFzZ2dpMEZyUnd5VWlLWGx4NW1ScTNVbk1G?=
 =?utf-8?B?WFZKVjVYelY0UmxZQi90dFhOSTF4QlRQR1dQcnQ1NjZueGoxeEZvYWJIN1dh?=
 =?utf-8?B?dDJrdTIyaXZkcDhyNi85NGZ0ZjN0VjRZbnpuZ29XYVk2cHlONk5OcWwxOWI0?=
 =?utf-8?B?eVg4QVlNTWF0RXZrRldxcEpSNlJtNHAraitLVWV1alFuams2WktrclA1VStG?=
 =?utf-8?B?cmx3ZWZtZXE2c0dwR1ZudUhQZmFxZTBLTk4vTU1EUTJTQnlBM0ZaVGl2T3Ux?=
 =?utf-8?B?RVVKbXpUV0RBYStCemN5OCtjMVhPbS83RVZ5VnI2V1AyNjlrKzlHVEFFODFO?=
 =?utf-8?B?aEx2N1htWU1qWUlQL3MybzlSSTYrUG1LU1ZiaU1HMzVPVk14TXJPQkljWDA2?=
 =?utf-8?B?L212alpUUFRVdC9UZGo4RHVVQUN5aEhzcDVCSG5ZTjFhQW1SZ1I3Mnh5L0h3?=
 =?utf-8?B?dVdwTTBpbDJXN09BN1BzRGcvcUJSV3BHWEJLNnRjZG9VRTlSSUNjempVRWUx?=
 =?utf-8?B?YUpKeTVuWU5yOTJNaDRLYlhNNVk0U1NqeHE4V0dvYVlqeE1yU0lnMWlhbnR3?=
 =?utf-8?B?OUtKaTc0RkFGaUp2R2Frbm55UzVER0tRREJieFc1c1F5K3VicjlXbWd4ZlBZ?=
 =?utf-8?B?WjRMdkdDZllnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0tCOXp3RW03S0VkOHNHSW1VOGNrdVU0RzNneE0wYUkzWGhOZ1hrSFhxN254?=
 =?utf-8?B?eW9tZ0x0L3ZXQ0FuREY0aDdQMWJrYld3eTZ4bjdORHlzbkp4c0NITnZkWVYx?=
 =?utf-8?B?STV0YXBRdWJKMmJvOHYwQTd6eVRLNUp2QWMwbTR0TUNSM0pVeWpBTHVOb2VC?=
 =?utf-8?B?SlJQZDgrajVtbkE0RWoxNVk4Nm1vdHZiLzU1czd2dDM3WFJZZkg1ajNMN2dM?=
 =?utf-8?B?QlM2ZzdZRUlyLzlOTE85SFU2aFFlWk5yWnZJRTFuakJGSEwyaERuaWQ5bHYr?=
 =?utf-8?B?d1VLQ2huM3NwY01PTUsyNWRta1JtTVpFMmxTRVg4NnNFRzZJeVI5TnE1QkZn?=
 =?utf-8?B?UlhZYlRQS0l6MHppTDhLbTFMenh3WklXV285d29pUk1rRy9WNHcyaWMva2s5?=
 =?utf-8?B?ZVowcDlrQ3BWRWN4WHRMN041N1YzOFQ5R3J5Zm1najhrbnpHVmM3elh6OS9a?=
 =?utf-8?B?R2x6TExmdkZiUzd0Y2VWb0k1M0NaM1V3dmFacWdWdkJybG03TEtzSmIrcWlq?=
 =?utf-8?B?ei9SakpFdUt4eGI2QlRNVkk5WmhnenhBKzVycXdObmZHcGxLMnlGbE51ZzZ2?=
 =?utf-8?B?RnUyMVRCTitrcE9kUTQrbTJjdzYrTWZxYlFWV1J5eHphWElRU0xJSWd1RFkz?=
 =?utf-8?B?UHd5ZkFkUmFnaHNGRkwrejEvQnBiVWpaOG11UFJmUXpFWkcyMm5TUERtcEov?=
 =?utf-8?B?Rk1RVW5pSWNXbUhoMDR4UjBQNWJIa0RWV3NUaENJbEs0MnJISkNxSTJMRDNB?=
 =?utf-8?B?S0Zidi9YRTJXWUZIajhvbWFLWXI0VjlBUUt0VmVLSENUV0kvWWRoVmU2aENj?=
 =?utf-8?B?T1ZmZVJxVEw0RjZPMzAxb1c4UWx0b1dacXFFbjdJeUNpMHYrY0VYV0RqUFRX?=
 =?utf-8?B?YU9uaWpldjhpVjV3ckViLzNteXZYUldQeVJMVXI5TW1vbzBpMGRmcHdPYUp6?=
 =?utf-8?B?Mk1NUlgyZlp5VUNnWDNMdlJZQ3BJVXNSTFhUU1gzRC9NbDZJSEk5N09XZVBh?=
 =?utf-8?B?cDZKazdJYjhwejgvbnJSakRJcHNZQUpQeSs4WjhvamhtcDgzZFpETzhiWEtJ?=
 =?utf-8?B?VXVWU25jVTQ3dmIyOWhNKzJHK3RVQmRTSTdUT0NqQTJqOGlCNG9qQVc2Nld5?=
 =?utf-8?B?eHVxTGVGYkZLdVErNEJTK1p2QXgzVWRSZnpDS2pVa1AvSU5PL0dqVVhmNXBV?=
 =?utf-8?B?bkhoVlpKYUk2SVplZXBYWmFaUzRjVGxLM3gwWVZxRTBzVmUwSC9wNmRkZ1o0?=
 =?utf-8?B?SVpuRDFvMUFMV0VuL0M5WGdKMExLR1lTa3ROeWJnUS9MaURGRGh2a1ZzN21G?=
 =?utf-8?B?SFJrY3VBZ2dZNWZHTmxYVlhueSsvdkVSYmc2bmJZWDNPOC9RWjdrMDVQK3h5?=
 =?utf-8?B?TjAxQTY4dzg1ZjBlRmZ4ejNCY2JrVW1MMzM0ejNXaVoyWXkzdnVUUFJBMjdx?=
 =?utf-8?B?RXN4S1hJUWdoQW9rUkZISTNheG8yQ2dQNXd4OUtRcnJvU0ZmS1pReTMrc1dO?=
 =?utf-8?B?dDBWNk9ya2tjd0w2Y2ZwenVYVTR0VDlER3I3UmY3d0tYVHMvTXU5YjFVS21O?=
 =?utf-8?B?Q0VWMFNkTXlIQWhDRmdLclVETXplQ1ZNdnpCY2k0ZGhoVjhIZ2FuY0xZalJ6?=
 =?utf-8?B?NUw1VEtBOFl3RWw0a3QxQXVxcWhjMmJBSTBJWUlyLzl6ZW9pSldJZzU4bWdD?=
 =?utf-8?B?aTRWYTd5SjBNTXozUFQzbHV4Qm1oVTBuUlMvZ3BmL1VzWDI3ZGJvVHdFa2RU?=
 =?utf-8?B?MVo1Sk9ONDdDMGs1dVJybURnZXAyeEVuNjY4M0tDa0VFS2xDaDhFZkpybWdE?=
 =?utf-8?B?empjeGNmSlBaKzNISW94bjF3NnBrc1ZkYlR5RWNCYnRsRHphSmQvM2pCWVhN?=
 =?utf-8?B?ZGRBMDhFanMvVURmd2QzSDZuQkZjMHUrN0NPcmx0Sm1TSklpWDNsbmJaSita?=
 =?utf-8?B?ZmNDMGx6UjE0WWhTWldkcGVXTXI5cXZrWC9sWHJtODBycVpjeU5MU051N29y?=
 =?utf-8?B?QTg4cUNITXJmejU2d2pFcUdUeVJ0di82QXQ2V1ZVaEpwdTQ5TnZmalBvWFlU?=
 =?utf-8?B?RHNhSUcyMWt5eEZ1ZDBqWnJONmZjZ295ZHNZeWsyZjNJNzloeE5xdXZxcnpp?=
 =?utf-8?B?RjYza2JIc2hMS2VETHV6WUN3bGhWSXQ4TytSQlYrVmk2ZlhrWnh4ZllKbjY1?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 82139c75-4e4f-4fb1-2bad-08ddc4320701
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:28:50.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKjxuouIdI3IbIT155BZpfCSveaC1KC9QlQKk/j3X2ezjutOMDIhaLF9p90kBTHVnA9/KK/sDCyX7z8Z/J3GUrnm0Fal8hXAXYk1cFtlUoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5858

Hi Primoz,

Am 16.07.25 um 08:21 schrieb Primoz Fiser:
> Hi Frieder,
> 
> On 14. 07. 25 16:17, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The RTC EVI ouptut is connected to a GPIO. Add the interrupt
>> so it can be used by the RTC driver.
> 
> AFAIK, RV3028's EVI is an input pin (EVent Input).
> 
> Please check.

Thanks for noticing! It seems like the commit message is wrong here. The
patch is about the INT signal which is an output on the RTC. I will fix
the description in v2.

Thanks
Frieder

>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
>> index 119a162070596..c79b1df339db1 100644
>> --- a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
>> @@ -205,6 +205,9 @@ eeprom@50 {
>>  	rv3028: rtc@52 {
>>  		compatible = "microcrystal,rv3028";
>>  		reg = <0x52>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_rtc>;
>> +		interrupts-extended = <&gpio3 19 IRQ_TYPE_LEVEL_LOW>;
>>  	};
>>  };
>>  
>> @@ -468,6 +471,12 @@ MX93_PAD_CCM_CLKO4__GPIO4_IO29			0x31e /* CARRIER_PWR_EN */
>>  		>;
>>  	};
>>  
>> +	pinctrl_rtc: rtcgrp {
>> +		fsl,pins = <
>> +			MX93_PAD_SD2_VSELECT__GPIO3_IO19		0x31e
>> +		>;
>> +	};
>> +
>>  	pinctrl_sai3: sai3grp {
>>  		fsl,pins = <
>>  			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e /* I2S_A_DATA_IN */
> 
> 


