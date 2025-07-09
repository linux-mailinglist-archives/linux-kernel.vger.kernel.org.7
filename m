Return-Path: <linux-kernel+bounces-722836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF1CAFDF98
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAED175B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76126B752;
	Wed,  9 Jul 2025 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="UgAyBTgE"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022124.outbound.protection.outlook.com [52.101.126.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53E26AAB5;
	Wed,  9 Jul 2025 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040185; cv=fail; b=ex7gxvQsXezA1jgrlcNjdrLz3iLbnAXgFvrqXWX6yeaR4BZBQB7ktk3FWoak8tHHwqN+4FbnFkNHSKQEa84MIGOkeohMNvHkCOmMTexL0R3YYKNiS/Ms5KD08iazGftrfAYMbkMucKKVxBDMdsPZPlSS/XFo9T7w7E/rEFNEfHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040185; c=relaxed/simple;
	bh=sswk/Vl0b6DAS7po+6S9s1kisfrAqm8CrzMTYdQ4Hb4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=GevRDGMM6ca/0KpmD9T9+p2aYKmCmOrE+Znn7W+y9ax/wRghYi8Re66w/Tqu1ENG2z+3MFiWU8mbK0t1afqYtaDYcMqLOgFTS553lvk+ckV5tWvJZaBld+aWde3W8DbFjIr3ITwc5K8npGqCQHAh0VSXUK6VNyMiJAmIxJX0z7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=UgAyBTgE; arc=fail smtp.client-ip=52.101.126.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibhOI0q3tBsMW7vCKtab26b6gO961mDoqw66lpwJJ4N2+s+Tae1dhkLyjHEkiNrd3JwKAYbImm+T0yCZS3RDHkcgZtUbSDYG1/l7a6wQzIIUK9A/EZNLxBrLVniLfxLXHyOOXTKz2Us/KaOIkNXJ2re+Xv5QenIHarLELtfp3USTdaMW6ne6GdfoUtcmLRCmHersSzJ3yJiQSSzio5ZIbBYfX4XOir2Q910d4E3VB41TijGYjnhe1GtLuNpyM/oj+wuLzjZtHG6ZtqKaZDHHw0lGC/MqEWltUFFiXxRYbqOT7+fKxg+GTYQKuIrLwv7QXqdi7nO4dJgwuTb8uNjRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFlptxPLELnmgBYEEzEi8iXn5/0yLwCpD0tz5srSAic=;
 b=Ntigoe6r24TwyetHHDA/7JEiU+2sPbsy/MmVCwCMZPtuXRFRP/1P12XSunbvytZvJTDKTZePZDqqGfpgVlWNfBaWk2Jx39ejk4DKGjeoiO2eWLlKKOrVp4TXXMkgyhAdv1YIpe+f7PHHbD4wz58L4yfR8Gw8YMN9tqaIeaHGOngKOhbY5Hkeojya54RDL/Ukl9lbkYsI8W5y7dvkdpFPBpwgZq9N7jrMDYHtnyKCgg1QZuZBVpW5lom76/nYSbr+i6NNnSVx5a8IZM3rJWC/Ovpdsj/Fi22WnVMPS5GrdUATxfME41klwO3v8qEcusYMTWfk96wrbrvDbkxKZAjKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFlptxPLELnmgBYEEzEi8iXn5/0yLwCpD0tz5srSAic=;
 b=UgAyBTgE/jRheDhk5gV9OHE8KzDKhCMdcW8O39HXkcU6KOCIPnYy6nj/emeXkfAqYJrzqLZr6kwiW4qihMY1XiPzLfOOu366ogvZCwfOv4b9T0CkRVGrIGjwkBIUskRrtAH4cb2rBGO/YvhgPQda03x17wHVVAJHegEnFxmqAnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7)
 by JH0PR03MB7493.apcprd03.prod.outlook.com (2603:1096:990:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 05:49:34 +0000
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94]) by KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:49:34 +0000
From: Richard Hu <richard.hu@technexion.com>
Subject: [PATCH v3 0/2] Add TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
 carrier board support
Date: Wed, 09 Jul 2025 13:47:43 +0800
Message-Id: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-0-721d198ce20b@technexion.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH8CbmgC/42NzQqDMBCEX0X23C0hatWe+h7FQ35WXWiMJFYs4
 rs3FUqvPX7DzDcbRApMEa7ZBoEWjuzHBPkpAzOosSdkmxikkKW4iAKVtTiTGUZaUxXJOuyR3Vo
 7nB7PiNE7rBplO6HzpiINyTQF6ng9Xu5t4oHj7MPrOF3kJ/36y7/8i0SBVpeq0ppyUxe33+Jsv
 IN23/c3ca+l+tsAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Richard Hu <richard.hu@technexion.com>, 
 Ray Chang <ray.chang@technexion.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752040173; l=2347;
 i=richard.hu@technexion.com; s=20250604; h=from:subject:message-id;
 bh=sswk/Vl0b6DAS7po+6S9s1kisfrAqm8CrzMTYdQ4Hb4=;
 b=AMrycexd3FaRaTlmioDxLAUEWWicf3V5jXnQMEP/v3cu5+l1HNOMPZhvvnYAOFRY8MFJxhdWG
 5Pex3xskXgGCHM9tqjfS4vynunA5ODzBdaIfq471ftMdFJpKmETuc5v
X-Developer-Key: i=richard.hu@technexion.com; a=ed25519;
 pk=MKoW0/U0r4MjJdRNaq37Tb25KE1fzJUdMN0pa8XBJSA=
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7454:EE_|JH0PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a7762d-5635-462e-7d70-08ddbeac622b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzdhbCtGV0xFRHNpQThQVkcxMllLdnpvT3llRFNSWDlVSmJndlhHREZmZXFT?=
 =?utf-8?B?Nms3QTdKTXJFOTh3cWZ2ZG1aNnNrSVB1b1JzbFJTS1U1TllRYWVFQmxBMmxN?=
 =?utf-8?B?c3RtbUFTZnd5ZURVNGhETjk0SXg4emhISWVtWmZTT2JleHpLNHJaL0liVkhr?=
 =?utf-8?B?WlJkV2JNd1pLTWg2NWMyZFd6UXFwNFVndXgvZi9nbk9aTVhVeXEyc2F5Y2s2?=
 =?utf-8?B?RXllZEkzbVBXcW1TQUluWVBIS2M1SkdQTXgwTU5ZblV5cExSKzMzK3RCb2d6?=
 =?utf-8?B?RTRZSWRTMWpqbVU4c1pvbzI3dXdNL2F5Z2REcjFaaHBsTExyOHhkOUFmamFB?=
 =?utf-8?B?Z3g3T1VrLzYwa1RvNytna0E4R2xjbW5YT2U4VDNrbDVpT0llQ0t5dHpYaWE5?=
 =?utf-8?B?SkhmaGlzbm1lT041em1jeEd5NXU4b3BkYmh0aXRGb2Rlb2VDK1R1VzFWVnJw?=
 =?utf-8?B?d3FBbkZkdkhRNENsbGozd3dEZDZudGFONmoyQ1hSRkVFQmpPc1dnY2ptYm54?=
 =?utf-8?B?c2s5UEdCU3htYVVDeDJaNTErejRVRGRZZDNocnlGZEwreG9hVUVhVW5INURi?=
 =?utf-8?B?Y3ZxbmkzZ2NwbnVQNTRFSThINDdKcWNydmJjTGs3SFQ0cnZOM2RucHJiVEpM?=
 =?utf-8?B?ZlBmbDVvdHFtUmx2TG1yZ0VWdTNIR2NnNnBBZE9oTGNxN1VLSFk0eXNaU3pL?=
 =?utf-8?B?ajFNQjl5dGhuYWNaU2tRS2RDYVZjT2FJd0IyZUJ6cW5ibnNJNTZXK2k1NlE3?=
 =?utf-8?B?RS9UcHFlWU9jUGxXRXc1OHNSVk9BUjN0YVQwZ0ZwbjNOeE1veitWdUpCb011?=
 =?utf-8?B?ZVRhWFNsaU5PRlVmZE5UbTJLWjZsTnpaQXZhWE1GQjBDeEx3NS9ldE1YNjlO?=
 =?utf-8?B?NmVucHRkd2JYRS9yd0ZLUUw5bXFGdk5Rd2FVdFFyTWIrRzJ5MkFUc3ZxZXV0?=
 =?utf-8?B?bXNLZytSUmNXS0JPdG1uMHk5ekhLKzB0VVdRUGRTOGgvaVRETkRJaVIzM2lz?=
 =?utf-8?B?dU5kcWpFRG5EbmhWUzRhSDZBNjV0QnZVMzVvRFRNNXl3UXo0eEIzU01RNjVD?=
 =?utf-8?B?SjZHeWpSU3AzRWQ3RlRhRTZjdjEyb3V4RVhyUzdiVEw4b3hVc0xyUzUwOWdm?=
 =?utf-8?B?MEt5YkwwMHdVM2dPYUJBUmNUTmlpQ2NRcE1KVVZJUGJWbTVaUXlFZEZSSEo1?=
 =?utf-8?B?cGxodUxDeDJvR2dDajB1QTVuc1Nxa0Y0RG5jYkNiTUpsMUdMRmZUZ0RaS0NT?=
 =?utf-8?B?aDE3L3dUNGNmNnd0UU15Tm1IaFRuWmJZSlV1VHk5eC8yazNzbG0rNHZpSGZN?=
 =?utf-8?B?Y1BqN05jVkdWdXJCeTRSUUxDK0diOVR1YlE3WjVLMmRHRFFlcFowTjJlQmxH?=
 =?utf-8?B?enNaWWEyTU5BVGtrWVZaMWZsU3J4NFMweVUyakJxVElpc0hud0ZNVGlkS3J5?=
 =?utf-8?B?dkJSd3VVVU9VUW9ObnRYN0s5R0NvZUNKcW9pSUNwUmFnMzF2RjZwaE1xK0ts?=
 =?utf-8?B?d0lWYThURWdvNllFSHJtSlRIZzU0TzI5ckxnd2xvRW95Uk9BN3NPRHZYSEcx?=
 =?utf-8?B?TkNqR3RpUHdBaTJzNnd6OFJRcXUrUGhqQkZCaGl5OFZIZlFjaHVYUG03T3FU?=
 =?utf-8?B?cisyeGFyWG0wd0VIQ21HSXFLU3hsZlFGRnFlYWk2ZElPTmtnYWJPamY2Um1M?=
 =?utf-8?B?djZDa1h4WjlWY296RGdRUkFpbW9EV2pyM21IU09VRHZhTjhJNERLTm1ReGpM?=
 =?utf-8?B?V3NvazJ2NXg1cTFpVysyUlF4Z0RLcEVaNHFZeUZoYm41VlplbHZXaGFHRE94?=
 =?utf-8?B?bVNpbGo1Tng0c2lPNVovUGE5MUIrbEtjdldWK1RobjUvSm5WbzVNNytHcGlv?=
 =?utf-8?B?MnlFenpNcjJZRmE2eFBHYnlFV2N2dktLOVNOcVRudEtVbkQ0TkRhb0NIeHB3?=
 =?utf-8?B?MmFSQm5sdmo4bXJSYjlROU9KRVJDaGhMeU56c1VaZGQxSHdwZlpxNXVUVkZl?=
 =?utf-8?B?Zm9VMktSODl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7454.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzJlaUdWOHI1N1IrUm40U3YweWZrM3RtUThyZDBmZjBWeVI5NXFmVkhYdWNB?=
 =?utf-8?B?VzJ6T0tpcnhlRmszeUlZcHNUVEN3M2Q5TDVwWjNWalFvTmNEK2hvN01OWFN5?=
 =?utf-8?B?NEpyOXlMcU9lUXZLdER2VUM5M2VrSmhoZDNqaHZuTE9zZGE2RGp0RWZIWXo2?=
 =?utf-8?B?b0p0OFQzNnd4RmxjcCtKdXNkR0xYbnh0OW54Znl1MUxaSy95OFNGd3lYR3dn?=
 =?utf-8?B?N3BjRmJpNHh2Q3RKV1RDNktJL3htK0xZU2ZiTy9vdkUwQXlpanRmQnpTZldL?=
 =?utf-8?B?aG0xRzNBZWFOUzU3VkxuTk9Ja2I1ZVR2ZHdrWnNXcWRpZHZGditxMVI5SkZK?=
 =?utf-8?B?aGZPZ1BwSDRPbnowcmVHaWlyL0ZnbkVTVWtOdmdhUTQ3Y1ZJdUdsRDFkblBn?=
 =?utf-8?B?UEFUMmhrMFpzQ3k2cXVDb3VqTklNMUhOWVZWVDA1RUZJOWVDQXdjNnNoa1hL?=
 =?utf-8?B?Y3NVcGFKSHQ5MnJhOVJBZjJ6WnFkTGVhbDg3dDNYaWFxNi9KcDFXdTBwSlFX?=
 =?utf-8?B?NDFiYmszdkpDeDN3SHpZNGxXTG1GQ1U4SnQ3U3p4V2tsTHBDZElOWXFDVHor?=
 =?utf-8?B?V01GMUJuTWtGQnpxcjRaQ0crUW5IQkdNVUsvWFIxaFpvSzRZU3Bja1hLMnZw?=
 =?utf-8?B?cGhPMERsM0M4MXlzQWxxditDblZTL21zbzRDbnUwN2FNVlIvWWZVZlhGaHhE?=
 =?utf-8?B?QjllV2tpSHBSS3Znb0loRU02UmZyNkJQOTA3b0QyZ3ZyY1NubGZuVGQzankr?=
 =?utf-8?B?RjlhMldaeWRSNVdOMk5KUmlHQk43by9rcE9weENzRjhLamhsRk9mWlhpWlgy?=
 =?utf-8?B?dXNYM0NYK1N2V1lYcUlqc2xTWWY5a2tWMkc3NUg3eXdSVDc0NDJaN0ZHajNS?=
 =?utf-8?B?RFBSTGRCTityeEhHN3k3bUthZDBJSnlkUnp6dEpPaVpVOCsxcmxueDMwelVV?=
 =?utf-8?B?blFmdHlHMlNmWk9pZjQ5V2RSbDVjQ2s4eWhTSEU3Q0NqZUYvZXFZRjZzekFz?=
 =?utf-8?B?WFFSSDdqZkVhR3lSSlJpV29xVityRzlDaWpFWVowTUgyaVBVTG9rOUJiQ3BH?=
 =?utf-8?B?MjF0NEY5SGpRZjJvU0tFUno5NEkvQlU1aG81M3diWGhvQjNvbnJob2xUZ2pS?=
 =?utf-8?B?WitpR2FYN0xBKzR6Z0lvZ0V6aXlTNDVYdi9MbkxXeGJQNHRiV0pMSDBGYUJi?=
 =?utf-8?B?K0VIam5kMVdkT3pWeEZRNHM4bTBSMjg2RVNpelhlMmx5ckova1hMTFZHMFdS?=
 =?utf-8?B?NnBmQ0RodTBBV0RsVURwblhxb3lrL0dhaUVOeGo2Uk1yQlp4SXlzYTdPc0tq?=
 =?utf-8?B?OXZMQzZ2NUcya1EydVJFWHBvZU1qcmZNQ1BTWGFyaEMyTTRYUk10RldjUTRj?=
 =?utf-8?B?WTBKMWdiMTlHc2VjaTBBeEordjRJNTI0MXp4NmtyQW1JNTFDU05MbjIvWCtE?=
 =?utf-8?B?S0FRVyszTkx5STlmeUVzOVVEYlQ1RlBiejdDb25wUmpQQktGODFpWlNPdHF6?=
 =?utf-8?B?Wkp1UnlPMzZtcUFEdmtTVjZmTXFIdkZ5bGFpMVIzT3NwZjZIdnFCZ3RnOGdz?=
 =?utf-8?B?Y25FT0tuR3QzRCs5a3NNNDM5ZElWdlNaMUw4aGhmZlo4bmZiYldWL3c0by91?=
 =?utf-8?B?eUFIYkMrSTRRNE1WUHAxVjZFKzUyeWp6bjZRN2xMWnZkYk5mNWxsQ0FXT055?=
 =?utf-8?B?WTdmWDMwSlVSS0FtS1A5akhlQjZwYWdaeUlXb1VMakl1ais3OVg4QVEwNVFm?=
 =?utf-8?B?bUxtSm1HeHpKWTBTNVZ0WXRiWG5HdEt1V1dvWk1CNEZTTWZzRkdCaXBtSEdk?=
 =?utf-8?B?N0hJazUwRTBDUHdMWW5LSENSbTE1V2h2bDNheXRCaGcvbXNpczNwbE83QzYv?=
 =?utf-8?B?NzROallFU3RLU2pacUFTZ2FZd3NCWnhVcDVVKy85eTMwdUdZdVZmR2ErVGNz?=
 =?utf-8?B?K2dqRWYwZEVhZHlhWlovYUgvNXBySVZMSU5JcG5Cc2hIaVVzOXIxUGpLcFFw?=
 =?utf-8?B?bGtrM1hqY2FDTVpHTmtRckoyb2NhWXN3cWthOTl2UTYwUTRUZVRRZ0JnYTBK?=
 =?utf-8?B?elBhRWdOampWTUVwdnByMlhhSys0dVdneTZJUjl5Z2ZmOHJVdWlsRThLYk1y?=
 =?utf-8?B?bjRJcWRsaktiSldFbFpJUG4vcnRwKzZsL1JCMFUrTVpHZE9DMnlwbnQwWjRM?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a7762d-5635-462e-7d70-08ddbeac622b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7454.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:49:34.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpLdlGPUwix//+9V+qAvdpr5+V2uhKy/QhqT8RkxOOLa7rax4XAoUXNERKnOfTrLd6+iGxfK4Xlgzxt9qh2z3OW5e5SQHrcRt0/OV6z2LC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7493

Add initial support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
carrier board.

Changes in v3:
- The changes address DT schema warnings, remove unused regulators, and 
  improve the overall structure.

in patch 2/2:
       - Fixed DT Schema Warnings: Renamed the i2c-gpio node to i2c-0 to 
         resolve a naming convention warning reported by Rob's checker.

       - Removed Unused Regulators: Removed several unused regulator-fixed
         nodes for LVDS, backlight, ethernet power, and the OTG VBUS, as 
         pointed out by Peng Fan.
   
       - Added EEPROM Nodes: Added device tree nodes for the EEPROMs 
         present on both the SOM and the baseboard.   
    
       - Node Reorganization: Relocated the iomuxc node to the end of the 
         device tree files for better readability.

Change in V2:
- Ensured accurate `To:` and `Cc:` addresses by utilizing
  `b4 prep --auto-to-cc`. (Thanks to Krzysztof Kozlowski for the
  tip on this command and helpful suggestion from Rob Herring)

in patch 1/2:
        - Add Acked-by tag

in patch 2/2:
        - Generic Node Naming: Refactored device tree node names for I2C
          GPIO expanders, the USB Type-C controller, and the PMIC to adhere
          to generic naming conventions (e.g., `gpio@21`, `usb-typec@67`,
          `pmic@25`).

        - Removed Unused SPI Node: Eliminated the `spidev1` node due to an
          incorrect and non-existent compatible string (`rohm,dh2228fv`).

        - Minor formatting improvements (e.g., whitespace, indentation).

Signed-off-by: Richard Hu <richard.hu@technexion.com>
---
Ray Chang (1):
      dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board

Richard Hu (1):
      arm64: dts: imx8mp: Add TechNexion EDM-G-IMX8M-PLUS SOM on WB-EDM-G carrier board

 Documentation/devicetree/bindings/arm/fsl.yaml    |   7 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts | 373 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi   | 806 ++++++++++++++++++++++
 4 files changed, 1187 insertions(+)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250604-add-technexion-edm-g-imx8m-plus-som-79adf0b397eb

Best regards,
-- 
Richard Hu <richard.hu@technexion.com>


