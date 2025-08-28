Return-Path: <linux-kernel+bounces-789865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D7B39BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DC81C22B91
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4130E825;
	Thu, 28 Aug 2025 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="o+tPRZjB"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201619ADBA;
	Thu, 28 Aug 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381339; cv=fail; b=INt6YOOIG9zzOoeQ8Cqdy+UBG2hVGrDHMoy6PF9v9q+bgS/X5BQwVUvqWdAxQRROgP3kXe4ep/FZbGYBCX4vkiwaThwl0t3GXKEgjWIK9LNtL+1B9EJk4Z34EMdi5qc/YeiMTBfrDsWivQrGHGAjMOV2VJfL4bsFSd0niOXtPMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381339; c=relaxed/simple;
	bh=WKi668MqLIo7ap0wd3u0h7+SCSjM5O9Y5H+CyVwnN3s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CkhJ3B8g2ruxlBB63qY0dqLdsQpUf70ngrPsBUffm7MxIbYl+MSrwTXZ5CrTdlrLuwMrl53sVe91Zz5Mu+AdLyb73TAdTiJPoqC+E1TdcnhFRbzOMXzb6pqD2xB4EVcFkEye8qlBibv7ltPO1c2PXuDyG5WXMV8D2CK8Lbdsn8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=o+tPRZjB; arc=fail smtp.client-ip=40.107.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdaifAxjzxrAeJPgyvGRyxc7shqP0ykpnM2ybnR9PW3rz1iyQoiijwb1+QmNvX/KhBcGyleQxP/PXls1ov83VlGBYw40K9Nlqh15WQplSUjXnk1iCmodMC67tPGiQ1Fd938am5hhKspvrQ7MfzSEgJSeuG/Ya1Hxokb+DWBJXXUwpEWOSYxXOJfS7YsGYP1AqhWGhgX5ZfpRcSSHM637fU9YolGfUcSgqosAxaAUDjVCjoRM3cTjMi+lHBp8XsHt6vFJOT0DiJ11YeqZAYeuK71IrNp0qN1+aNyzsnS7LIsm1YUi61blCYvc5hwHJudgRnjKJ5HjAiz73IVNBxZDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L97oVJYBYDqouiRl0f4Vrh8PsYEpcHFztwVgWD5pIUg=;
 b=gM7GkmgmSb9GyUoVME4yT1AWS3WDUqBgDz/fI90z5jff6MiikP9Jk+tMcK8+thybekLboEDkpGSyz+75sELrHvSnaVVvfFhDY94Uorg736tZZT4QIMLm86VIP9JAy87ao9L/BsXC1d+3mpMe6iFzoKn1nVWvj8K5aHqfHjXVfSmZNmtPQU+H6VcjJV069HMsOoq0CChcfulmjiwyyFYIL3LhxBg84RmXi+YLVL9JaPtDr9zETovAjZ0AL95amP2YnPwos3H4HlkHybUZ1WzwqyxkLgArakFPqvdZhyeppOWzzif9wH6U/sMtXQgawV+e8O43WaRVn4vwPWg7nyoHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L97oVJYBYDqouiRl0f4Vrh8PsYEpcHFztwVgWD5pIUg=;
 b=o+tPRZjBqod30kk95EAyEMUnO4rj5iW2OoTZ+8nsruMNcw96epU4wLHEozDgRm8iBfKqm5jvCCHRaBcvx2dtEhtS9Q3N4M2kVB7Abh+Rz4alpfJwKFZmiN+1f7r1OD+GauipkscsJT/bFl90uQOAnF2+l4mylUs1fGrSvooHMFd/k3+wru303DNDnVkopRye3M/834Gx3TEpewZnqjQ86X41HZBvR2h/bZjA2sNgZIOklxWBq5uW5yFnV52mE4pU2GrkJ2Dv4SCHpMnmmuWA4qDHyLTmeFYZOYG+lAcVnm3Rb6t2zvnAScL7mSmXZNAYpdLEB8zm8uiinMiceXUuBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by FRZP195MB2680.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Thu, 28 Aug
 2025 11:42:12 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 11:42:12 +0000
Message-ID: <b745deb3-b625-472b-b55a-468eebbdfb16@phytec.de>
Date: Thu, 28 Aug 2025 14:42:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/33] arm64: dts: ti: k3-am64-phycore-som: Add missing
 cfg for TI IPC Firmware
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Matt McKee <mmckee@phytec.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Nathan Morrisson <nmorrisson@phytec.com>, John Ma <jma@phytec.com>,
 Logan Bristol <logan.bristol@utexas.edu>
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-19-b-padhi@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250823160901.2177841-19-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::36) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|FRZP195MB2680:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f9263c-17d8-45c0-a547-08dde627ed7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHBTWVNOdGdPZ09IUmJIL2dMWXRybnF3dVY3a2FlTVNWOFEveEpyS3VIWEhk?=
 =?utf-8?B?MUNMMkcxUXNQOTJESjNETkIrbFdYdWRYRnZGbXo5T2NvZlhpTjlrS0poVEdH?=
 =?utf-8?B?U2FsVE9malp4ZHJudkdqSDN6eTZzUHJiRnBHVEF0dE1CN2NFb3NKUk4wUFh6?=
 =?utf-8?B?YWZtSUNtK3hTbjJ1dmJPWjh5c3lWZnZjMWdOVjZsMTVTUUg4QkkvTkVKcVlD?=
 =?utf-8?B?MHRFOTFrSUxpRHhxWEJsT0s2ME9sb1FuUGh5djhnVjVlUzMyTnpJNDNSQlFz?=
 =?utf-8?B?Y0p5WmdrVmxTZDU4cVgyWUptcnE1Zmo3azVnSENtU1FEeUFEbmI2SHMxTzFu?=
 =?utf-8?B?L1RXMUs4RVRRQWNVdHU4dkl2RkRxNVVXVTg0Tmpyamo2a2o2TUMwU2g3alJp?=
 =?utf-8?B?NzB1MDkwZEk3SG5seGpsZ1V2R1RZQlhqNzNkMHpWVXc1TzRqVWFCdlE0VjFq?=
 =?utf-8?B?Y0Q0OWxWbmU3cFppVWNYRkNTVEFPRjFNWG5LUUtZSmFkbVBwU05sZXI4Vk5r?=
 =?utf-8?B?TjA3djRmLzVxM1h2UnFWUlV4L2RiRTVJQ2c4d0NJcTc5NC9QaFJVOUxWaHl6?=
 =?utf-8?B?N25xdjloVDdCbnZZUlQxa2FBR3planoxTTM2UElzL1pKNThKTTFMVzdSMktU?=
 =?utf-8?B?cnFyVXphRDlwdmNMcU15bnQwcEFBVWF0UzllR3dMN3g4OEhhM0hoejJmTFhl?=
 =?utf-8?B?NjNDcjYwOERycWoycHBKejkzV0xIOC9CY1VnL3R5SDdqeDN6N21SdkovbkVl?=
 =?utf-8?B?U05JN1VCeUtlM0JOY01uVTA5UVZvUE9sQVJTNVJrNkFwc2lNV05KSlNSeGU2?=
 =?utf-8?B?VDkzQTJycm9RbzFiYXBERDd3R0w2OHZxRlI5VWpIS3FnaU5xZ3FiVElIUlZ3?=
 =?utf-8?B?QWc3YXF6UGk5RXNNMXBFSWVuaHVjdFhhbEx3TUNXaFNjSVBnRjFodGJQcTNu?=
 =?utf-8?B?VFZSVWRPWjhWdENvUlY4M01sckxCaXRZV0g4Q2ZRK2lyMUUvQ21vSWRxaCtl?=
 =?utf-8?B?bkFJTEpPY0t1QkMrZm80RzBnbFBoa21rMTB3Z1FLWndFVmFFRU90cXhDWFpo?=
 =?utf-8?B?VDRsT2FBVWl4UmRWR2RrVFJqanlsOU5QMk0rV2wwSHVnM2luZHoxcTNZK0hL?=
 =?utf-8?B?cEtteWlCY0ZObzdaaDcxa3k2eWFRMXNITGMwMnFHaTZxZnNRWEpUbkUxRWRa?=
 =?utf-8?B?REhqNEwvRTFXQXFKdGdMZVpPcU1kblJWRWp5eW1UV0d3MGV1M0lFdHBFRW5J?=
 =?utf-8?B?UnBxWC9jdm10S2hmWVAvZ0JnOFQzQzR5d3pGK1hxQkJFbFdsQ3hpYi8zZ3BH?=
 =?utf-8?B?WCtzTFR1eWRxZTBTQ3dBdFVaQWNDSktBclV2SEU3Y0x6UGJrcjRYd1NPQWhl?=
 =?utf-8?B?M3RHcm4vRzh4K3JxemxEQVZGMkIvME15NVB1VkhwYy9ZdURLaDdPdStUM0Jh?=
 =?utf-8?B?VVI1ckRKNFhYUGZRVDRhOUtVTHdhVlQ0Rzg0Z0JjQTJnZE9Zb0ZDZjhUWGRh?=
 =?utf-8?B?SzZOd3llWEY2OStxN3F0WDJqY3JibXBTOUtwckE0bGdQSkM0MnN6akFNazFw?=
 =?utf-8?B?OE8xUHBFNVQ4VWRSbStMcDR5N0tqQmRLR2JmV0dkQTY5OC92eC81bytpVmZR?=
 =?utf-8?B?ZmZ1ZEI3ZGhBNVBLR0VIdU5lZHN2WFA2RDA1TkZ0ck1uNTNNVVFFT2RMNzcw?=
 =?utf-8?B?NEM0Zm50VGJrYU9xTjJ4ZCtNQWdpcXhuL2VyNitrTGRVdmdMTDFabkFxUWor?=
 =?utf-8?B?NmFrN3p0ZEFHWHVpUWpmNXdJNGJQL2lXVnVVYUpkdExlRmYrRkV2ZGh4T3c5?=
 =?utf-8?B?UjhwcUVidGdqbWZ1Y1JoQk0zVDJhUVM1Nnd1b25hZkppUU9YODh2d3FIRlps?=
 =?utf-8?B?TDFqOW1GbTdDQ0JnVTcyQ2s3RGtQU3g4RG5MZ0Z1dHZIcEZLSS9IUWVWSFRm?=
 =?utf-8?Q?AjUoZ31Ri/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFpyRUtlaCsvZUJmZjl0YnJxQ1E5SWtIeUl0NExIY1FCM1pHaEp2YVJWUkUw?=
 =?utf-8?B?U0dMK0xpOStSQWJjbkVrZGdiaUdjRVEwbHhEc3hBaWU5N1VYM1dBbHB4VFhP?=
 =?utf-8?B?QVlnZllYLzNJZnJIeDBuY2dOVjhxQnZQYUd1UitkR3NsZlkrRW9tRDFuTTFN?=
 =?utf-8?B?MEpqSjJma3orcHJQMVZzdnZlRDBpclBiR29IdFo4TWtsSjdNbm12WHlEcHY5?=
 =?utf-8?B?WTFPcHpPNnJtVC9mRlVOVzJzYjdnUWFXek1pOWsrTHFZTnEwNEs3a0wwOWpR?=
 =?utf-8?B?b2RCZElKc0JJZ29UOHYzSzZmWWtDWXRWc3BZMUJJR0JJTUl4bU01cldrSFA5?=
 =?utf-8?B?N2s3TjFBdExhZjdUN1E5c05Rdmo0WkVIUWJmbGJqd2RBV3BaY3ExbkpRcG5S?=
 =?utf-8?B?ajlmd3RlclZLWFdZeTRrSEJUZ0JmeUF4WFUrTEcrSGlkLzhHY3J0bE85Y2JC?=
 =?utf-8?B?ZW4rQkxzV1lMaGszcU0yMFNlV2J2NkhaaTdkR3FyY3Z1YXlLU2kxWGtQcUFJ?=
 =?utf-8?B?MkZ5eEJPS1VPTE5CT3pSSEwrMzMyWU9iVXVvWlhYNmpheEUrNENwY1QxT0NX?=
 =?utf-8?B?TzYwSDJ6SXZFa0ZwbzVCcEN2ZEY5RkxzbEdJUC9OUlRXaFZ0Z1gwYUZ2eVp3?=
 =?utf-8?B?UEs5RHZmZHdJeHh3cG1pQXNPa1FxcWtIcnYwSWpqYU9BbWZ3dlJ4MHZrdTBm?=
 =?utf-8?B?RjJ4V2RWZEE4OWRnNi9UVmxXWkJFZUtDTjY4WVJYQ24xdmtlTUFqMHJkTWl0?=
 =?utf-8?B?NVljUUpWRlhZN09mOXl5SnAzK3hxcWdIS2FLekpwYjJJNkhJUDZNODZxT2Fq?=
 =?utf-8?B?dGZ5WkRXR0hiYlRnYzNYclRqMTNiOHh0Tk1CYjlyYkhNZW14c1VzWm84QW9x?=
 =?utf-8?B?U0VtTHphdHFCdU5VN25IbjNWT1FnaThkMjMyTGdpUVFFVG45WSt6OTcrM0dE?=
 =?utf-8?B?Sk9hdUxzKzkxRWw4b0U1RzRaUll3NGU2QW9wTU5MclFYdUpqOGovTzRERkF1?=
 =?utf-8?B?WVVueUpodDZGaGI1QTNCbXBnU3NCcXJnNko2QU1hYkJMQW5KUC9HRUI0YzYz?=
 =?utf-8?B?elpxb0ZOYWlZbU5xSFM1STlJRkdKZmNGaVNjMkdVK2JMYlBhSE5iSTRsYllX?=
 =?utf-8?B?ejBUdlFMMTVUL3hHbXZEN3M2cUY3cVp6U2FER1cySlFSRGxLbXBlSEJkQW1M?=
 =?utf-8?B?dGV1SnI1RnNHS09LZTRjMW1sSDVoMUtPWVJ0bXBjcGJRaHJ4Qm5RbTRBbHlX?=
 =?utf-8?B?amFQN1RJRGJkREJ1WVlsL2wrYXRGdjN0cnkxZ3RmczYrbTJsTVJXZHRhaDhU?=
 =?utf-8?B?azRzZHpRT2lUc0FvNWVzaDViVUpQcUtOUDJkcGdxOWNKOE01THp6RjgvMi9J?=
 =?utf-8?B?QkkzRUh6ODNBSDMzYXcwUmNHcG40OVZVOGhYL0pWQ0ZSaHVrOWRMclVSNkNl?=
 =?utf-8?B?c2pna0hlK3hPaUVNSllUMmh3MldlRDUwc0dBTVNXczI5d3FUdml3amR3Z3JX?=
 =?utf-8?B?aldVU2kzNGhJMUhHVk9GVlhMNGhKZFFZdUwxL1JOYjJoQldPUnZUS3ZkL2hR?=
 =?utf-8?B?c3dheEZXdjllcm16TmxhdTBWSHBhVkw5RG12S1gwUFhkc1pyTXZ3N2hyTXVP?=
 =?utf-8?B?OWRQa3p4M3R0anprdU1vNVBLOE83OVlJVmhUQ3JKWkk5SEdMZ3VKeU9BdnNC?=
 =?utf-8?B?a056YzVOTkE2azJlRkZGc2Q3UTlqcnJnVVd4OG43OWtreHpPdFhBTFAyUDJN?=
 =?utf-8?B?ZkI0MkN4NEtwU0hGRmQwRE9SbllteFU4dmNQaGxYR3JMOS85K0tvbnhIcTk3?=
 =?utf-8?B?SkFQSlFraW1jNlFQdzhvaU83SEpadWVKM3VuNFlFMG9XNFlUNURqSFF6ZU1j?=
 =?utf-8?B?eFBIZWdxYkhWMm5WTGZoV0RLdFIvOXMvWStDWkxhMGhwRUxNcG56RDNwRGV3?=
 =?utf-8?B?clJJaDIzQ1lkTTV4Q1FoWDZyZkdBSzA2aVN5YnN2UzdBTGVLTTdSdklacVdU?=
 =?utf-8?B?amo5UTFzd1pXZ1FuZ3JKVjNWMldFNEhvQklJbnVrU3RENGdjWU9jSXMvVWhF?=
 =?utf-8?B?RDluUVAzVmRPVjVrRTVHakxsZ0RGeEF0NEdxTklUR3NUb01YTm5QWS9mazlW?=
 =?utf-8?Q?b63wq6kFgPEhqIq57UQ3zgcUR?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f9263c-17d8-45c0-a547-08dde627ed7e
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:42:12.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+CFzCLC6ZdcV6u84QQD7g+P/oUvDXI02F5AYzcf72YbU9MyH2Rq8KXV2bC4XJrgOqf7oTDUW3t5guoUsLcIkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP195MB2680



On 8/23/25 7:08 PM, Beleswar Padhi wrote:
> The k3-am64-phycore SoM enables all R5F and M4F remote processors.
> Reserve the MAIN domain timers that are used by R5F remote
> processors for ticks to avoid rproc crashes. This config aligns with
> other AM64 boards and can be refactored out later.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

I am not sure you need this patch, because you are deleting everything 
you add in patch 32. But I tested the series on our hardware, so

Tested-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Cc: Wadim Egorov <w.egorov@phytec.de>
> Cc: Matt McKee <mmckee@phytec.com>
> Cc: Garrett Giordano <ggiordano@phytec.com>
> Cc: Nathan Morrisson <nmorrisson@phytec.com>
> Cc: John Ma <jma@phytec.com>
> Cc: Logan Bristol <logan.bristol@utexas.edu>
> Requesting for review/test of this patch.
> 
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 28/33] to [PATCH v2 18/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-29-b-padhi@ti.com/
> 
>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 24 +++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 03c46d74ebb5..1efd547b2ba6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -275,6 +275,30 @@ mbox_m4_0: mbox-m4-0 {
>   	};
>   };
>   
> +/* main_timer8 is used by r5f0-0 */
> +&main_timer8 {
> +	status = "reserved";
> +};
> +
> +/* main_timer9 is used by r5f0-1 */
> +&main_timer9 {
> +	status = "reserved";
> +};
> +
> +/* main_timer10 is used by r5f1-0 */
> +&main_timer10 {
> +	status = "reserved";
> +};
> +
> +/* main_timer11 is used by r5f1-1 */
> +&main_timer11 {
> +	status = "reserved";
> +};
> +
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
>   &main_i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_i2c0_pins_default>;


