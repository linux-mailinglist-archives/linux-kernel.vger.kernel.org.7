Return-Path: <linux-kernel+bounces-753004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63EBB17DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426BA1AA5644
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3C1D95A3;
	Fri,  1 Aug 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rwoZljgq"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71E5680
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033688; cv=fail; b=aiq59dpIGK/EmVBTm87NUbL+OsxfI24miaBKUWpCgK6BWnpzGrd9z7gqh0pV9/T12hvqWTrMi+evl3WR1zwp8/AHYsi/VPe0gdO1JNfnVo9W9cJKbUyvdTcvGm1NXh7GrEVVRuT3gWB3GJRXMrO6ZLcuEfLiAlJSYAGHJbg/n3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033688; c=relaxed/simple;
	bh=ZoiUtAx+f8OAcVpa3IZPQt0D3puWykjK0q2LDEQgx8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EJfbNEjW1hmjMAjBvBMnkuYqjwtJlK836NGzAa5++ApFaC1ZHN9uHbe7hwueWbZvBdOL/CO6Rf1BkHQgctHf8zjzMqjucHx/4bqC+MJ2FVDnSFE23GEDEVRq9gXi/3MGJ/5Wa/o0SJJALvV/mRTuEHve1NZ4511NdYvjCAY8U0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rwoZljgq; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgtRuUheWKB/lBTnc8eonWpCgq83dgjje3Gd41j6hpGHJ98aKQAy5IBong84mjmUNRaUH9vXtaP/GZ5qmfOOGHaedJrsGIiixXED1MD1Id3q1q2U2b8iJCdypx+LVO+TMQHxdJS5GQF77fwKwNeXaXWOo1Kdfo6Tpiq1OK87gJz63DM04lw+ShYVCM8tC7VMv0Nlr4rhW3GcRurzZK+X5CrmwF7zRk2uRGNth34d+UHdsmQgAPacRw3o2zJXFu3z4J68OtKl5JuevDVOWToXRb28+qKgJ9SpKu2D9c4ugZ+wzxZSD6Q5z70MCN8GRccgfs8NdJbnG4NTFA9SgdM49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHYc0PE+qMOj0sy9CzhUknOdfVmMWL0YOmnRS1vvEno=;
 b=EWyYDMN1diMSJx2OdsqQK+6onAMMXS/4qlWMkYXdiu3yWevTX20r37+5LviG8sqKrpN5jjVfQqdJRvq0lx51Shtg339cBf4QD2eDxjxo2Xf970wMP7GDMl35vO1fkpZnIafCt6UM6YxylEjwJSoipIPsJ8tb7QB2ZzTPnXe+u7ykT/G98zzP2wLoA/acO5o4jewFwQAGV42zCIBVskcALfcd4H7m/KbH82nJYD6vpV/2e6XgOtJHhillK0TaBeG7ThvgfbCtLmIxz9GnWmk1SWMLFyOdrzaUIyx9tKVLJGYSP+7dUxhK6QwUA8Sb121eaqHuUAvuHboQJziBt5mydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHYc0PE+qMOj0sy9CzhUknOdfVmMWL0YOmnRS1vvEno=;
 b=rwoZljgqBt+UGGuLTMVQRksSVGjaf8naZjHd9MISOPB9XyMnUi1aCJ7eagoYcBtmpTbkvrXemREIreCgABStTe58zFW/WotHentW0j9tevbEAR+xe6S+E2SRzBWzJCPndoyQnhFXv3LSsf/3XHRZyL9LJBRolZe/nW+UPEWrVLqbwm2mLaAQrhR/YX26+CW/09v+fTsmFuHEpfuYZXRDoeI9iZux1oDtC6keEtehe3k4ypm0inD6wf3eFeaEZFeUT58hxpp5TNQ1JpAXieigoUpTy8mGCrKd499MGBUvmnSGaugFwOfpXdsbEEHfVJ+PJJqOamlipzB42sI7hv4Zcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 07:34:43 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:34:43 +0000
Message-ID: <e50e5e01-0b73-403c-8119-8f202c488bb9@oss.nxp.com>
Date: Fri, 1 Aug 2025 10:34:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] clocksource/drivers/vf-pit: Encapsulate the
 PTLCVAL macro
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-12-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250730082725.183133-12-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::24) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec29122-83cd-4e03-0a2d-08ddd0cde20f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW01RDJ0Y3NNRXBnVVpLTUxCNU9rRks4a1d4K3BIeTZWUFBCVnZKbTBmdk5i?=
 =?utf-8?B?UmNld3RyeWI5K3hzT3U4N3lYL0srQjl0ZUxRNzRwVURKYlpYaVN3VFdsR0Nn?=
 =?utf-8?B?NmRSNE5ib1hWcExRM3QxOFo5WGtib1ZNMVJKbUdLM0dpVm5sbHBWdS81VkJS?=
 =?utf-8?B?bG05TDB2M0JsekkrWWVCQzJmT3ZERDZRVVNVc1padTMwUTJ1VGdVMWRSSUpV?=
 =?utf-8?B?Z1c3REZ1eUhNTEVHdU83SVBoRHdCdmxBSTZsdlZyUzVsaFpDS3Fsc2xIRDkw?=
 =?utf-8?B?enVRZjM2YjZYZkFWMHRQekpKVWY1Zm5PR0haVkxYUEkrQ3FoUS92cE9WRU92?=
 =?utf-8?B?c2dWQklSakwvV0ZVK0dHVUJCS3U1cHAxeEp6VnF5L3NGbG9sSFc4R0Njb20x?=
 =?utf-8?B?U0U2WW93ekNndXFyamh6Z2RMK3RKUUZTUnBQNTMwMkF1eEFldXRQY3FNeE1q?=
 =?utf-8?B?VHcxY0tFRVJDbFg3dUtMZUUwT0lYeDVEOGM5SHNuTjl6bXkwRmN4WFovVDJl?=
 =?utf-8?B?aHBiTVFuYzMvYnJOc0JEelM1cHJ3VHRpNDFpYytMNzV3UGhVTmZHdlhGZ2Nx?=
 =?utf-8?B?YUNER1hZd2Rpc1Vob0Yyem5QWmx0R2o2cXpqWnF5RnBmQnJCaHQxYVFxU1lM?=
 =?utf-8?B?aVVxYkJGSThrK1pZSGpYMHRLeU5rb1Zxbi9kVlJVZ1g5Q0ZLdmdUQUxOYXo1?=
 =?utf-8?B?M1V1NTk2R2N6TjNkU3phbmEvdGYyVVRMZk9tbGRLVXVEcnVEYmVWZ2Y2SGgx?=
 =?utf-8?B?cWVVcElxTlhQNllGY0FyeC9LU2NvZjRTMEd3Z29RZzdDRDNQeERlOEZGZUNi?=
 =?utf-8?B?R2ZZMnB5aDd3cE5XYngwcEpxVmJabHkzcGJheldJMkJwTkVja28xRy9hdW5R?=
 =?utf-8?B?eDZYcE1jeDNPRmx4WjhXQjkxZytSakdJQ3Y5RXdIK2cweFdSMmJEL3BhT21D?=
 =?utf-8?B?NkV0ZWZ1eXFSTHZvYU1CWkJ5OWt1c3VtS3lWa0ljS1JMdkt6RVNyZHJxZ2JM?=
 =?utf-8?B?dHg3VWZJNFZuQ1ZYU3BIS0ZiNjFBb1UrVmhSTTRBcXpNZXozNHIwTi9FeEF1?=
 =?utf-8?B?VGZheExWM093NWE1bHJHSUY0b0V4Qm00WE9RQVZ3NmxxRU9PQkNrOFNCY2ZS?=
 =?utf-8?B?M0tsNithZWpSdXoxUjlBMGx2QXlBYWlUeUVZOGhpMFQ4RkNNektpblhpKzE1?=
 =?utf-8?B?KzZLZ0ladkNDZldyQTA3VkRTbC9rc1MrVVlkUi9oUlRybFl4RTlXZFFjK3ZZ?=
 =?utf-8?B?SkFQRGxVWi84bWtZUlppSHRBbHlRNDIyKzJFcXc5S3dNOEk2blhib0ROWXp4?=
 =?utf-8?B?NjFLNzRva0Z6T3diUVcxWjlSUzRTckhibmNWY2lZVlg4KzJjUlRoNU5Nd2Nu?=
 =?utf-8?B?cHVnQWMzU3JDa3RncGxkTUxxQlBsZlRmb1l6cDdoaytZVktlREc5QXdhekt2?=
 =?utf-8?B?VFJWNTdSTEYvMXJ3WEI3dXlYbThlS0xhSkJhcklYTXBzeFV1VXJDdTBsM1FF?=
 =?utf-8?B?TlZtL096TVFYSUxNS08zbm5pL0g4VEVMaFBoeEhsYVVoa1Voc3g0TDF6QUZB?=
 =?utf-8?B?N1U1YzJ0RDNGeEExaTZqMEM5emNac3dMb2FEU2s4WHo1SEltRzlUWkNnR1FO?=
 =?utf-8?B?cjl3aDdVSzc2RWVVakJxdTJqcUc2SGdmQTZiQ0g4NGprZFNNelhjWVdVUmpP?=
 =?utf-8?B?MFpvWDBwSG9oSkI0bDEzZEU0OUprTkQyL1dFM1lnSjljeVlneW1BdTJqa1p1?=
 =?utf-8?B?cG5aSkpNaW90WlI5OG1zNFdZK2NuVTFlT3ErNDczQVphczVvNXhEbmx2eHRq?=
 =?utf-8?B?T1BTUmRHYmN6WWIwRkwxVE9oem5TckoxVjR5L0tidzBYcUFlaGF6U1NSeFNL?=
 =?utf-8?B?UFpzMmZIQ0M3RzY1emJKUCtkczdQSkdyU3hVUEp0SFZYeUFYV2sxaGJtbzBm?=
 =?utf-8?Q?2xz99sci+pU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDZTdjNsMWJQbXZZSGh2aWRFOFdHQ0wrRnpQR2NscG1iRHdsRFE3MVV2b01w?=
 =?utf-8?B?NWRPZW5xL0J2MC9YOUpxcXhtL2RBT0ZUZ21WajkyOTA1TDVuTzBQTGhaZHFR?=
 =?utf-8?B?TFhlS1l5WExqVmZMa2hnUk9ydnArd2JvQ3RkSnZGNW5PZ1FkTlZlU1duaTVp?=
 =?utf-8?B?OG5aWDRlK2VJRHFEQ0tTeG5vODE3UlpnY1JhSjJrNkJSWmZITUozdmtzVmsz?=
 =?utf-8?B?SnVuVzNaVXJRbytzT2N4TkN2U3RVcFJrM0o3c0k0ZytRR2k2MnhSTE1tNzFz?=
 =?utf-8?B?Q3hST2tRRGhLTFpmTmt3SzFEcHFxRDhLdlVMTkJ0U2psa1RuVUlqL0xCM2hO?=
 =?utf-8?B?SDhYQUhWSG9zTnNmQWNteEdoVkI4Yi9WczNSV2s2OUp4WXkwVHAxQnhVUkpr?=
 =?utf-8?B?Y0xzTG9WZlBObk9hOTM3ZVF5TlVleUJkYTAzVHNtN0ZueWxkTWZvQkpidHF0?=
 =?utf-8?B?Q3ZadmtHa0VWTnRKMmNEMnN3VVFtSWtQZkFSY0RWQm8zMHhBdkpVKzNxWW1v?=
 =?utf-8?B?TjE3Qkc2V3RGWm8wVTQxSHMwUjVnNkNWTDJ5elZVV3l6ZVRqOXZ6MzdzdjV1?=
 =?utf-8?B?c25vRE5tTndvTnJUOFFOMHMxbVBmTm1QQ0ZLMFlmdVZvLzIwdVJCZk1jRjVk?=
 =?utf-8?B?NG1DVVB5ZkVpb1F0Y1NKN0syTXlIZUdBT0tZTHZwWHR1TjJqVVV6bzJKNCs2?=
 =?utf-8?B?b2w5cWFZeGVVYXZiUFgzSDMzZDAwOFo3RngxVGZjdVc2dkxpb21rYllLTGxE?=
 =?utf-8?B?YVlMTzdKLzhISGNIUGZrL2psSGtNZ1dZOWdBMDgrZWdEYnF5Z0Jrd2lyTFRR?=
 =?utf-8?B?czJpVWpSNk9rU1EzSVNnM1pYMUc1RzFEL1dsemxNNFExQW9xUGFmd3B3bWFi?=
 =?utf-8?B?MGNVcG9BRTFqYnFnd2FvT2ZEUGtvdTRqMmZLeFFOeU56NTd0NWdUcVZsOUFp?=
 =?utf-8?B?TWUzZm56Q1dQaitkVFJiNkM3Z2ZkNnJpUXdQTnFiNGI3QktRRUJ4UVkrTHBC?=
 =?utf-8?B?c1NNbERha1lQcUt5cXFrNHkyY1hFdU9CZVZKaWp5SERBTDZ0TXBHbmlXengx?=
 =?utf-8?B?OEJGc25Lanhiak5MZHhqT2JmRk1EZVdBekVGcGN0ZXRTRXFlVVRjOEdzQy9i?=
 =?utf-8?B?WlplV3BZRWlGaENuYVpBaERDaGlCWmJmWHBvOWRtRkQwTW9iK1ZqYzA2L3JT?=
 =?utf-8?B?eGliV1ZpRHNJWjBxd05WMkZZYXYrM2pSUGdlS09ITFpEb3VrM1lUYktZRkNz?=
 =?utf-8?B?TXF3ZDlFOWdrZ2VjdFdFK2l3SFlsa0E2UnlKMkdzNGpUV0lsdzNSQ0t3aFJJ?=
 =?utf-8?B?RU1GTW90dkovOWsrelpDc3ExZi9PNmVXcWw2UnhPemRURWJiSDlEWEd4c2xQ?=
 =?utf-8?B?QjVrcEZPSkZFRDJ4ZlVTMGFoeVJhUE90Rkw0bGZWUG00RjBrK3ZRWThZK0dS?=
 =?utf-8?B?ZXJHaEo1T04xQXpncC81S2EzbzQzZkFTUlRML09qUXRrZTBlb09pdkQrOEMx?=
 =?utf-8?B?Q0dhZVF5QTR2aVcwRDVWK0JFWFZTU3B2OGpTZzVhVVZXTWFsOTd3TWdseUFs?=
 =?utf-8?B?Zkc1bWs5MkhmeTdBMlBzSS9qMTlpc0hiK3RKakhxanhZeHdtZlBjTFdHY3E2?=
 =?utf-8?B?ektFVFpVbHZlcGZOQ1VycHYyMzRCZ3pwWHV6dnVNcHhLYVpnRmJnY0xQMEo1?=
 =?utf-8?B?a2xidjFPUFZ3d3hxNkZ1RnJYSG92RDZYNE1MVlA5eWJ2SnJMVEI3NjZnZko5?=
 =?utf-8?B?cVhieVNJUUo5QkEyNE9qZE9Ecy9zcnRpVmJmaldvQ1VmSEQyNWdBZkhkcTJZ?=
 =?utf-8?B?ekNoZTdGNWxYbi93cEVkdjU3Rkg0aDF4SUYrSXUxSVBuMGVFdmRiajZISklF?=
 =?utf-8?B?d2dTVmFPUm9HOWJMVkxhN2x3WkZUb1dOVW5OUTQxWXRheEZJUzY3YlUrVVkx?=
 =?utf-8?B?NWI3QXVNUDY2Y3BBV3kybFpSRmQxVEd4Zy9HaGs1ekNwdy9MdEY5SWduSk0v?=
 =?utf-8?B?eVF4dm5LeW93ZDRwcWY2d1EyWkFUUnduYm5ITEtiSU8rMzVNcEp6T3hZRjRV?=
 =?utf-8?B?UFhzUXdVdUFrUkxiSjVBNDhjeFkvREIzdk53am1YcmR5aWJ6LzQzbDV3NU1L?=
 =?utf-8?B?TlpjMkN3VlRhUmROK2FOVXhSRmNOMFd3R3ZGdVIvZzBiRitNWWlPUWRBanIy?=
 =?utf-8?Q?jrKJTaBxeXZXXQThfQwd6nw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec29122-83cd-4e03-0a2d-08ddd0cde20f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:34:43.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkSgPUQaAmQqanPmFP7oJJZ7QBaLFI7lJ1Q72h1WBN826PIu5QwTo0vN0uchnLUN7RFHPBTJvJFQDi55EL32Xsi9XIgmIZRpsjr4JFrcXL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
[...]
 >  static inline struct pit_timer *ced_to_pit(struct clock_event_device
*ced)
>  {
> @@ -69,14 +69,14 @@ static inline void pit_irq_acknowledge(struct pit_timer *pit)
>  
>  static u64 notrace pit_read_sched_clock(void)
>  {
> -	return ~readl(clksrc_base + PITCVAL);
> +	return ~readl(sched_clock_base);

This appears asymmetric compared to 'pit_timer_clocksource_read', where
an explicit cast is present but seems to be missing here.

>  }
>  
>  static u64 pit_timer_clocksource_read(struct clocksource *cs)
>  {
>  	struct pit_timer *pit = cs_to_pit(cs);
>  
> -	return (u64)~readl(pit->clksrc_base + PITCVAL);
> +	return (u64)~readl(PITCVAL(pit->clksrc_base));
>  }
>  
>  static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base,
> @@ -99,8 +99,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
>  	writel(~0, PITLDVAL(pit->clksrc_base));
>  	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
>  
> -	clksrc_base = pit->clksrc_base;
> -
> +	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
>  	sched_clock_register(pit_read_sched_clock, 32, rate);
>  
>  	return clocksource_register_hz(&pit->cs, rate);

-- 
Regards,
Ghennadi

