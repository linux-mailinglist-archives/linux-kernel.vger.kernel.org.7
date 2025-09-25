Return-Path: <linux-kernel+bounces-833292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC1BA19A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075681665E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF632E2D4;
	Thu, 25 Sep 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GEBwQYO1"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013081.outbound.protection.outlook.com [52.103.33.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53A32E2CF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836026; cv=fail; b=eyMCBTquXy4bF3KXasXFirXf5fSB4YaRbd6NkzuZpIm+wTnUzMROSQ/6g1+cEhAoiY6EIpEs7c7i9HqhCFbnHhiBzYSQJs3utyui82g8+dVC+WG59+zkn422vFq3GDehh+iiCX7+fkpJg78SvHxstqgI97M59DsPqt5dP01x4jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836026; c=relaxed/simple;
	bh=VUPyqpMJcBZQOD+EOdeYBAvGfzpNjpd1oQYxdqqH1zo=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=bSM85Jih5dmicCuAVOVZ8ONCgklcP5Rz6BGJuBpBM0mT3lK0u/fd2yQAryDESNWqWOC0226SgpfXfXzI/n/mzsiBxPSN2/JopohW/N/BO8KLmEsL0zFUPDzWOIZXGy15sf9xJ3CNFC+79lJVnlk1bFxyG2pOIaHRqHcpexMFFo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GEBwQYO1; arc=fail smtp.client-ip=52.103.33.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4GEjAQx6f0IObfpYo9IzlTNouVx/0UlXlm8y3cfVcskKVgpFzrqy43JhAmZiNCJClePof7e4fWR9DK031ZDJPXZC5JB9MrHrALn0+vQwsizcdAro4OVkSbmaWVhVx+Dr72Fx8VtcuvsaFYXb/KjIXG0OdtURHLWb8MSi8OhBgjsQrDBCpxphi7lo5P6Xnl5EKWBnVdMx0CuZlfjyg9xQkSYPo3Ay+iD7OGhL10dsnDMeH2hmKbD5GDXHcZqI/jrh0lIQf5tkMuaNdww2opDdrBl95fx61raGlEXLqeiVdfz/buhlu94fb7BY42jLvhZOD82sf2fWstFhF975H5qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBupO4OCluvTfnWtrL/y7QTqJyP1ehUFZIshUHqYlOo=;
 b=pShOrwnqQ2F/Oynl1AfH8oL4VA5dIfIlWbOXg+li8VrjHAdb4UjrryHSZ6vXU0G2SYG2bQuop90eO3DB72a+FP9cEHUa35mv2/lRgIlKmSvGg947DjM2eXB7ac68bSAuqWWfzhNyJZKr6byXQFnbPpfLW/xR3dgdjFmg8QMNF9N99fTs1S2M56lS5g6cz8Ayt6fJ+k0hmu71h4p9uyuKxmRPi++yODH6WUsP4Qknh25E1Q+0ySk944Wvn09ZfKMXlagvSnGUAZOdnCEAggL7T15CCrhB2DBNsT82IMF3S5undP7MAFRouMKBeIBm9sc1fAvGp3bzRwfoXa3IzZzcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBupO4OCluvTfnWtrL/y7QTqJyP1ehUFZIshUHqYlOo=;
 b=GEBwQYO1g8ImPidIj+EuSS/MMEczThgKyapsTDE9yiWu1tHk7o+x0Zxgu5QO81S6uWSI8PtJoyfQ3qgVadnZ19LFzBpE/CbD5/0EBqosF4DrDcq1HZeaugatDAAnKSwLsWQQqycHSVloWez/nPEN+l60ZGYaW/bc/1C2bxIYAZ/vI/ll1dC83AgzMNZJAYkvJbw/iluYFGkMVfqLZu9j/bQYjRiVxh+cJFwGN5Jz1MR56wYaksxE9SuBmq9HZREBA/Jtd+yjjLDi3/XSWta6ojhCvhW1oZ07RSGz7E1MR2xbR0O6RJ7zyTu5pirzGgJb+ydHNfT1kgoIlu+1GyGDIQ==
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2c4::5)
 by PR3P195MB1069.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 21:33:41 +0000
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc]) by VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:33:41 +0000
Message-ID:
 <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 26 Sep 2025 00:33:54 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux@armlinux.org.uk
Cc: ardb@kernel.org, rmk+kernel@armlinux.org.uk, ebiggers@kernel.org,
 nathan@kernel.org, linus.walleij@linaro.org, rostedt@goodmis.org,
 kees@kernel.org, dave@vasilevsky.ca, fj.haider@outlook.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org
From: Franz-Josef Haider <fj.haider@outlook.com>
Subject: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00014AE5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::310) To VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2c4::5)
X-Microsoft-Original-Message-ID:
 <363470c1-fb10-4873-80ee-b25a23be9971@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2739:EE_|PR3P195MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ede4d7-8a9b-4d19-9dad-08ddfc7b326d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|6090799003|5062599005|15080799012|23021999003|461199028|5072599009|53005399003|440099028|40105399003|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlFSK1NNSFdtQnVIOFBjdTR4eEs3cVZCRDJUcVdESWNHSFRud2V1T0t4R0tt?=
 =?utf-8?B?ZkxTM2U5U0g0N0haVjQwcklGYThUTXhVa2IydFBLRTAzdnZzZTF3MFlLZDFS?=
 =?utf-8?B?L3ZVOEpSWjFrK3B3cjV2ZDEzZDk4S1QrZy94VVpiWlo0UTdKdnNPWGtVUWo1?=
 =?utf-8?B?NXRTb2ZHR1ZhZDJJYWNRS3VPVTVaVXZ4ZEY2RmVTaDR5VXJaMmJjY0NaMTR6?=
 =?utf-8?B?WFpCckRKNzRiQ3ovbGJqZVgvQStiTmVKNGM3VVlvUlB4U05Id0NKdy9Sc2pn?=
 =?utf-8?B?R3pKQWhQZGRRdTNLR2x6ZU5RY1UvVGZiMFFKQmcxeTBHemFVbTQrS2JDQkNN?=
 =?utf-8?B?UkMyblY1U0dDNlduQUI3elRYczZuVnBNRDdEb1dNaEM2NFBxckExeHNKQjFU?=
 =?utf-8?B?RnorQW1lRjVOT1NnS0tPUGtlWXRiM2V0V3hCeUhmZDhwcXVyVlVQVC9JMy9S?=
 =?utf-8?B?ZnJEOFZJMnVPSlZaSXdZV2prRXkvNFBHQkE0aGhLSlFabkUrTzYwb21oL2g1?=
 =?utf-8?B?cGJLQ2lucmNEcFFzVWtNNWp6MlltVWEvUlMxV1ZLSU9SaTJWbEN2dVVQZjNS?=
 =?utf-8?B?ZFZTa1FFMWo3N0ZCMkZpQUJMOWVTQVFrQk50b1FMUHB6MWJJTXYvbUtuTDRo?=
 =?utf-8?B?YzdhOEErM0ZlZFhmQzcvbS9jNnlERlBoNnhMWDhDV21BeUlSYTFWSkxVTWoz?=
 =?utf-8?B?U1BHV2lYdk53RWpiSnFVazhiRzkra044YjVwM3dEV3lSMFRlR2hwZjdqOWZK?=
 =?utf-8?B?U1UwMWdyV05JQ1JndndVUEZ1SXpldUxaeGIvNVZxY3NjVnZrNER3UjJKSEh6?=
 =?utf-8?B?YloxRUo1MWR1WERjRFUwS016cEkvaGdvVW9iL3F2L3hHUGZSTUc2RzJjSUJC?=
 =?utf-8?B?WkFpbUEvOXhZU3V4c1gwNnBJclNJdVIya1kvQXFmM0k2T1hMN2lJNmNqMG9O?=
 =?utf-8?B?dDZJRzBBalJZN3JLYi9oKzd2VDc2Wktkenk5Uit3MndnU2VpNHBvUXowRGVQ?=
 =?utf-8?B?VitCSHZnd0RvWmVubElHUFdzaFUrWVJPc2kvQ1FRQ0pMTDUrWit6TStEcklt?=
 =?utf-8?B?d3BQNnd3VGFrQVhmUlJYSCtMZzJxMmZZSFJ2VGR4b2FUdVlMbUg3QTZMNEFo?=
 =?utf-8?B?TlpaWWlmNEFRSEl2eG5wRFJkN2ltdEFsZDNyNVgwNVJ2ZWNKOEZpVU12YW56?=
 =?utf-8?B?dk5Sb1gwRS9QNFNzQ1FpZmV3akJGdjRMOHZpUitrTURBSzZsQ1NJK1pTKzVI?=
 =?utf-8?B?MWQxZ3B6UGlXVVM1bnl3Q0dXZUczdDZuVDdBQ3JJQUdEMW00RkV3WVFRaGQv?=
 =?utf-8?B?ZjZ3UVlocm5ray96THR2ZUdsdUdGc2djcHl5aVNoU21Ka1hhb29GM3Jpb0R5?=
 =?utf-8?B?SmVqbTlZNmxYbml6STlLQzRydUo5VnZ1clFQWXE1MTl4Rlo0dDlRbVJ4QlhM?=
 =?utf-8?B?aDBhODZLcm84bzcyMkQ2ZFJoOWNoVi8zd3M2UUtXQkd6YzkvWk0xQWdYZWxw?=
 =?utf-8?B?ZzJoLzQ5a0pPa0lWOHAzNTJVdzQ4VXBZUGdaQWZaS05DMjZOVWVxVEd5SEFM?=
 =?utf-8?B?Z0ZEcVpmYzVSbjJsczUvdmdCSXJYbi9EeWtoRURGTklLMEYxTW1mV1JueUg5?=
 =?utf-8?B?S2JFc0RSNlNaRituODlKRjVrcmlyaUxiNTRnNVJrSERNa05ZbW9QQ2tUNkVW?=
 =?utf-8?B?WGMwVldueG1tekxFdE5oRmxRU2lQVVFoUEhUakcxS2xCS2szSi9mQ0lRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUFVUGNJWTI0TGZKVCtiR1JEMW4vWWN0SkxSU1lNVm5MV2NNbmhqSW9oY08w?=
 =?utf-8?B?ZU9iTWlLb0dkOWk0WTdHdjdzcEdIUE9zVThqTktmY015TEN1Z01UT2VBSllx?=
 =?utf-8?B?bi9IRlVUc0RzMFM0Zlk4OHp3M1NrMS90S3FMaVZPSndVSGhkSFB4ZEt6dlVs?=
 =?utf-8?B?RGtuVGdmQWtUTFZPZ1ZDZ3BlTi9raXRadUFxeWx3TTIvSVdzc0dXbmpYWEpl?=
 =?utf-8?B?UDhKcWF5ODVHNmxjamRWU1lGOTFmdXZNd2hSZDNNdTJtNVN2Q0luTm0xU2hw?=
 =?utf-8?B?Nm5tWFY1SWVxZmNOdUFsRWdYWmlIR3BERXBnNFFHQ0NWQjI4UHhoRFZ3MlJF?=
 =?utf-8?B?cTFzbkkyam1nRkhjTU9KZkZwaUdhZUR0Q3lGYWRqRm94KzVQUFQzMENtdHQ4?=
 =?utf-8?B?RnJJWCtSUk12QTlLZ0p1eSt5SnR1b3NpV0VvL0EzeElEY05wdmErNUZDbHZL?=
 =?utf-8?B?NCt1QzVQczRoSXBLQldlL2VVRTM2eUhva3dtS0wrcDhnL1dkbTBnekJtWUtw?=
 =?utf-8?B?QVY3OWpPWnk3bHowa1RVdUlSUFJTNVBrWCtROU9OSWhqbzBEUWwyaWhoMys0?=
 =?utf-8?B?VjlFdVJVU1dYeTNjWkV5bVQyZTNKdXdjbFZiUXZobFM3R1dlZFQxZXRiVy9t?=
 =?utf-8?B?MWdQN3I0Q00zSnk4NGJjRzJCNGt0ckJRZVlCMHlJTGJUa3llczdqUjJOTDJM?=
 =?utf-8?B?SGxvM2xIVFRhMmptN1ZTVGNEMHBSOE5ROGRiNHUwS3JxVVZnci9GMllZdlFN?=
 =?utf-8?B?a0JRVmNZZi9Welp2ZVg0N21NcnYvMUdRMnlwSzZmbk1SQit0R08vK3R3elJq?=
 =?utf-8?B?bFhsYXZ5bUpHMjhzNlVZc1RUNWFYSFRWN3R5S3h6NzVaRTA3cHZhUEdGMjFn?=
 =?utf-8?B?QU13ZHFUVVpVdThQdUJmdzNLNmYvYktFeFBSTXZTL3c4VmxTMmcxOGtTdWtn?=
 =?utf-8?B?S1g5ZTlxOUJ6ZGZOZUZkcXY4UUo4SkdGU0k2Qjc4SEJBclR0cmdOeWZ2a3BI?=
 =?utf-8?B?QVJuY1JMSlZrRE93MEZxY1FKQ1k0VGZVdDBuaGdXbHdwYWNBaXhkMEtmSUY5?=
 =?utf-8?B?ZTZZdjVtZC9ReG14RWRWNnRkRi9nbVJsU1lZalZqZitpU3BUZ3hKV3Y2NVNx?=
 =?utf-8?B?aERjckJ5TXZnV3pBSVJOaEVaSUYwd3MzcHdabTZKekxLQk5tRnlKK3Y1WDhK?=
 =?utf-8?B?Nm9nb3NNVW8xcnRTZWlCRVBuNzY1a051MWhlOWNvVXNXVjdKbTFSMlhoMWcx?=
 =?utf-8?B?bThYdXU3UkxZMGQwbGZFVkNvMllvTWVKTG9oYi8zakF5cHJZd05vbEZ0bVYz?=
 =?utf-8?B?VEZrazI2QkxlVG5qR1VqeXk2RkhtTFh3NzNWQ1NwRlVDTXVPQm9iLzFVR2dE?=
 =?utf-8?B?UE1TdUVkVUN2bVk2eWdMSDZxVml1WllTSG83eFhmODNNTzZiT2JtemM3YUpy?=
 =?utf-8?B?Yno2KytEeTNPdXlsVmNJTCtCUTZWRHRoL3FqWDhnRDYxMXRKYTliTUtmQ1V3?=
 =?utf-8?B?aHJXOVBkV2hFeU1UZ0g5S2pnbDZRK0c0ZGhxWkJRZXdLM1k1eVk0Z1Eza1Ro?=
 =?utf-8?B?WWRvcHVIYlc1NXFLai81ekZncnBmUGhYOGdSbGZrUlJtOUtaVmtQWGI3K2ly?=
 =?utf-8?Q?wMvD3BcsV0dyxSwiMxRo4a04EBNMj0HX0wXLSC8cfBPQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ede4d7-8a9b-4d19-9dad-08ddfc7b326d
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:33:41.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1069

From 33ce5a26ef08199625bc5bb01a176047bfacff91 Mon Sep 17 00:00:00 2001
From: Franz-Josef Haider <fj.haider@outlook.com>
Date: Thu, 25 Sep 2025 22:14:07 +0300
Subject: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.

Fixes build for this cpu type.

Signed-off-by: Franz-Josef Haider <fj.haider@outlook.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1f3df39ed40..a498c9aae50e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -322,7 +322,7 @@ config MMU
 	  support by paged memory management. If unsure, say 'Y'.
 
 config ARM_SINGLE_ARMV7M
-	def_bool !MMU
+	def_bool !MMU && !CPU_ARM940T
 	select ARM_NVIC
 	select CPU_V7M
 	select NO_IOPORT_MAP
-- 
2.51.0

