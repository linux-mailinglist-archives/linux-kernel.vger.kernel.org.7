Return-Path: <linux-kernel+bounces-852966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D736DBDA50B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175E318918E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CF2D29D0;
	Tue, 14 Oct 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="quCUDsCe"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010017.outbound.protection.outlook.com [52.103.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8B293B75;
	Tue, 14 Oct 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455203; cv=fail; b=DSA09Zkc3TNQyzPww3NzjLYFIPb2mj3mSk5J0hbvuf8KJKc+Kaq8pSnZSrDg0lbm+z4PQGFNc9Cvmk4yAW+e01Se9DI9U+W+kDbiWCUZeFRkMTzyatqBv7AXrkXEURiWXXhcn4q72NEvaYmXdlbD0MIAakg4keVKAFeRhM6PYf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455203; c=relaxed/simple;
	bh=fOnW23Yt9g/jmmw/uRmiJfaxisHBeRV1JV9J4/XPjWo=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=QmLvZOv5k40Os9NdEXvaFWyUDHmrtV3FWjmyuHQFGlEl4PNkjaQKpyss4zyS4p4avUjI7DInJh2HoKHv5FVorqJ1gFo49aylLFaJ0QmJRrjlcwaLcLd4dQUrIEhIBvvBPgdiBepjJ7a9yRrpBu8Vab0w7fY4e734lnrlstJFwFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=quCUDsCe; arc=fail smtp.client-ip=52.103.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yavLYatMFEbzrI7GLFzN1wjS46N3+1Tv307S8+czje8crB28trtMonNTfmwQmja6WxrJs57n3o4jyi+NoGEyW6xVYokQu3yYbnOqCSyc1ys1PPieegWrwuuQyja3blj0VKD1L5mg6dZUGfi0gimrsehmmxfcUTOz4NbiLIYgURQVPv1iI5JGv5TBCwne2MH9ikqR4ShX06LhevMDLS+ZguRtIlpt1R42dcTFY9jZ3ttyYe9773Nr6tABY5dR1IQqs9TYTTni0wFwgLPTtwYbfhKb+z7EZ+UOuuLXVstYBsMOSprkmiV8nXjp7CQJabdp80VZveqkdUdRbKNkQWgcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYw8GcKroSYA8kItcyHD+NDoRaxvcgGsFmazXfkUeAY=;
 b=rF3J3YpuW5qrFa1jSmDRCEli9/wPZ0yAJlslOF7XqAbe7/mfwc2BNmsWYMDih8HXwm+um50lLtbkX2cGVInVWm6uebvv6izaozrGce5gqKoZqGmGfrKTeafjzcixZGBcfLWDrgp4o7XYxZl97moTLKnOaOGHN67gRGqFR3NvB6WlMpmVBh6gx4BEm+ZQj5NH59EVUtrWmW+6MqN6hhl+ZW8evMSvds1EylvoN4Vwsw73rd4S4yiWhVj3CXj3MFkq1l45axWj5tLZfsk9nBEgsFuQFgBAx7e769x1ph+wWLo/JNb34Aw195F/Rxst65AzhXB7rtzpFdPcZn3smRNFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYw8GcKroSYA8kItcyHD+NDoRaxvcgGsFmazXfkUeAY=;
 b=quCUDsCeJk01XiQcMRX0AzBC2ddttDhbeKnP+GvH++aBlOqadGz7oQ2aZptfWk2Qy5x2Yx4LE+DR9IhaX5Qeq6OeSSmQcuatlteqJaquJOR/KnpDprnZoAoNDSMeiA4N2LR6a+Ks46/g7zURDGhsIo7kQvSYmbru4Z2TN5PqzWTb3Hday8vM4pQvPO9Em+eh9LkLzrdbSQzRIW/aHEvD5LkYncc90ZLg5UA3tBqx2GdQ77eF8hTqK/1SZqXEnd8cO3FhG+iUNHVPMWKDZ/jR/VUxNiWBS8IsW4kgY3o8cFrgTpC6vBGpPc2YvvKFH5xafhyp1d208RT1Dry3hQMTuA==
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 (2603:1096:604:22e::13) by TYWPR01MB10067.jpnprd01.prod.outlook.com
 (2603:1096:400:1e4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 15:19:59 +0000
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc]) by OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 15:19:59 +0000
Message-ID:
 <OSRPR01MB11808FC73C557CED90DDD839996EBA@OSRPR01MB11808.jpnprd01.prod.outlook.com>
Date: Tue, 14 Oct 2025 23:19:36 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: ston <ston.jia@outlook.com>
To: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: huawei-wmi: add keys for HONOR models
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To OSRPR01MB11808.jpnprd01.prod.outlook.com
 (2603:1096:604:22e::13)
X-Microsoft-Original-Message-ID:
 <7ad2c8d0-89a3-418e-9844-8c37ea48c9fc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSRPR01MB11808:EE_|TYWPR01MB10067:EE_
X-MS-Office365-Filtering-Correlation-Id: efc530d3-13d1-4969-ca44-08de0b35223d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|461199028|8022599003|41001999006|5062599005|19110799012|8060799015|5072599009|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3o4YStVTHZMMDVwc1NubTUwU1JwOVYwbmRTM2pNTkY4RTlWOFg0S3padEhG?=
 =?utf-8?B?UVhueEFUdVJueUFhZndpUWczU3RtWWFNQ215SGc5cWRaN1JxSWlhVE52TEJy?=
 =?utf-8?B?RmJoWXo3M1BPdWl4L0ZVdjBWRHdqYzR6WXM0RVpHeGxqcDVkUEZUbzVXQVVv?=
 =?utf-8?B?TE5JaFQrQ2lzWmtCdklrdC93a3VaWVpTL1hVTC8zb1RSUHkrd0R0ODk4M3l6?=
 =?utf-8?B?bUdaakg5RDgxdmNlQjQrV1prQURka2lxd0d2WVhBWXlJUmpnNXp1R0NSemor?=
 =?utf-8?B?ZC9sREo5aEtiUXlzTnNDbFkyTDlyRGYvT0xUdytNUkgvU2ZITEZqNXhvSVE5?=
 =?utf-8?B?VHdDS1BmckZkY3lJanFvb2dhYVZVbjlQUGQzMWpnK3RnZXZoRUNMZGlXQWh0?=
 =?utf-8?B?bkdwREFpcm9RTXNXaVZrQU9xSGZ6OWd3aVhYRk5jZDZDRGpDaURzdUVPakZx?=
 =?utf-8?B?NmhPU0dUdXpEVzFwMHdrdERMRU8wakRsdzJmY3llSzIzdjRLaHFGOFo2a0NY?=
 =?utf-8?B?bFpOUmRXczZidjU3OFVsUFRyRm83Z1V2dENVcE52QVlhOUVrY2ZGYWVJcHU3?=
 =?utf-8?B?L1hCelJVbnV1QmVYSUZITEh0Y2RpVlJWSHA3bHVqb0ZwZ1d2TUJUMFpOTjNK?=
 =?utf-8?B?TSthUGVqOVpGVG50TFF5NzJSOE9VNUNQWDZKZW0rVThUd1ZCdk1PRkFmQ0NX?=
 =?utf-8?B?WGVhaGdVdVJ6N1VRZ2Y1MkQyQmEvL1dSK3c1SHFxSFEya0ZONXpNbDF1emNC?=
 =?utf-8?B?dCtMWFNRZnVJVXQwcWQrcm1kUkY4a0xxWTRZQVJVS2lqTGZucDZLUytBVjZt?=
 =?utf-8?B?MTgrK2VYcnMrQlNlNVd6ZVRsMHJkWjQwdEM1VW95QUVzTzFZZVluUFBGK2ZY?=
 =?utf-8?B?cTlKV0pGMmNobG1VNEJYeGZWdC9XcFYySitSTDdFSmpFUys3dHlEWjljWEdv?=
 =?utf-8?B?ODhFSGFNTStBUlhYZmlhNEZQRk9wTWhxclhmUzRwcnVsSEcySFozU21GT0xm?=
 =?utf-8?B?c215NjUwZE1xT1U0V0pxclVVT2VaeTFtKzhmMXRucENzVTV5UFRxSGI0cVgx?=
 =?utf-8?B?bmh5K3RBUEwvM1hKQzhwUjZ0cmZtSi9Oc3RkbkFJQjZJaGVuSkx0VjJoZ0Q5?=
 =?utf-8?B?VnBlaUhnZFByV2ZDNFM1dU12MjJISkVPWlZhSGxxQ2JzS0ZMZlhPR1o5a3ho?=
 =?utf-8?B?SG1lbVB2QjlDZzU2dkltdUt1RjRCUkk0MldPR1prcXJUODJDcERsUFlsZjVH?=
 =?utf-8?B?QU13dDZTZVlQYTEwRjM1eUd0N2ZqY0pWNGtOd0xGSndDajAzbUY1T3RucEEy?=
 =?utf-8?B?dEdhaWEyMmRCYW5NYUNkSjE1ZktadExtMVkwSk9MSks5MTdmNnUxZHdiQkxu?=
 =?utf-8?B?Y0U0VU81MDA3elFabFZ4TkgxMnN3S3V3N0hIWWRyejFhYmxoM2YvajdIelUr?=
 =?utf-8?B?Y2dzZHRzWFpmek5DRG1zcDlqdUxpMG9NTjVWYytCbEE0b0dLbWE0RWpkWHcv?=
 =?utf-8?B?VS9xNUM2Smhad3BlKzRHRmxTd3k5V1dNWUR4Vm5zWEhHY1M5dGUxSXNBTWht?=
 =?utf-8?B?YmwzNzA3dlJ3WG45ZzlzOUxPTS9HWFNVQzJTUEdhcWtvTWwzQXRVWDVtU1ZO?=
 =?utf-8?Q?lRQhRkWe+xugcWvXmWsUuclSlBR6MzHSCnIT6ZGCDggc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVRXSy84MURmaHQrUzd6WjY1ZHlyR0JPc0R4NmVEK2lLSmpZcWFaa09WVmdP?=
 =?utf-8?B?WEdOU0ljYTJBTGRad2hYVW9OZTBxaHJGZWt6YUxxSWpSdXViRDN4a1dwQktm?=
 =?utf-8?B?dXg4WlpwQkNuT0tmUVdtYUFIVk42R2hxZVBDMVJYSEYrWElHOFVtMk14Kzdx?=
 =?utf-8?B?dk1jQ3R0dVFhQ2NhejREK3NMNVY0aUFwdVdITGZaNDhwYndXZytuOXVkbkp6?=
 =?utf-8?B?MGVDYVpzVUQ5L2YrTUVUSzJJdUN2ZW5MTTMzaFV6REFwdHE5akNrYnhsR2xU?=
 =?utf-8?B?WVdpNWczRnVlR1d1N2lyeEdWZHRXR0h2OEFod1YxU1VmcFlwZHRNQU9sRWRv?=
 =?utf-8?B?SDZKeStMTzdCbTJ5Y1BJazZoL1hvTEFaUHJ2WnI1ejd6TS84ZEk3MDhtMjJr?=
 =?utf-8?B?T0R6OGhxeENpRW1Zd3dObjdCRFlnN2EwWUdUTnRQMURTUGt3S3ZESkRBOG94?=
 =?utf-8?B?bjJVWkZDNDJPZlFxNDVoaVhxTnIrTk9yYktyU0FGbGVNL2wxV3dvYStOUEh6?=
 =?utf-8?B?YTlCQ1dxOTQwM0J3VmpmQVQzMmJxN2xMSkZNN21vdHFWUzE2dFFld0tsTkhz?=
 =?utf-8?B?dkxpaDR2VlJTT2IxUHVWNC92MGE3akIrVUJyV290SHBlek16dW1CaHh1KzZO?=
 =?utf-8?B?dVFhUVNxSTZJSm5vVzhEQmFWUUpLYVhadGttYU5mVFV0b2xrQ1ZiTUUycWRX?=
 =?utf-8?B?RDIxaGx2aytObHQ3cTBvTEFNN0F6bEN5ZXd2UkpvSklYdHM3dnJSR0tsSWha?=
 =?utf-8?B?dzVLMThHMEdyVGEySlZYbzBEdjFiNFdVM1VjL0dhNzlQQUZUZHhXa0xZMGdQ?=
 =?utf-8?B?Yk9wWUVSQXE0OE5KM21PWk55YWdtc3lBYWZjMWNMRWNsK3FjeTRUczEwUDl5?=
 =?utf-8?B?bGQvVnMvSUt2bmJmbDk1Rjhpdzhqdjd0WVRiNFA5RzNyem01Y1RnWUFrdUgr?=
 =?utf-8?B?RXFSUFNzTUUrVG1ubFNGaVBkV1l6UGdVMlNlZ3RSUVdydXk4K29YLzMvUjlI?=
 =?utf-8?B?Rjk0Nkh1ZVNQVnZjU2QxalVPSHpUa1luR0FsSXl1ZDlJTTZFanlqZGVIQjVW?=
 =?utf-8?B?NW53N2RQeEJJc0V3K0poY2pnOTR2OWc4V0RCako2OFpkTlpibVl1TlN1RERL?=
 =?utf-8?B?Nm8xREhOSG55WTBubkZ1Umd1RG1NSVM5NmVqTnhUY2IwOXpwc05qTTNkVzdK?=
 =?utf-8?B?TTRaRVUwNGcvbkQ0SXArNXIwUzZFOTZJY3RkVWRFOUUzdWtlR0VHUkI1dkha?=
 =?utf-8?B?d3owZE15UWgySzg5aGFsUFI4amxaejRuRkhrSmhuOVE1RTJsRXNZWWdUaHJX?=
 =?utf-8?B?Q3Nwbk5tMk9nTnZGdGtOc0dzbituYURpU0ZYUkh2cGtqSXp4WVN4M3VCdjYx?=
 =?utf-8?B?bC93VGdBZS9jMm5LbUxPaHI0anhjYVhxeTlrakZCMEEzbDl3eTl2K0k3SHBa?=
 =?utf-8?B?QkFQV2QrWWZmUXBpRUJkSDNodlZKVklablN2MVpjSFA4dndWdWdqSGdaU3lH?=
 =?utf-8?B?SVcwYWQwNzRrNkw2QjU1SkhOM0lKMzRrN0hMMjhnVWdvY2x1SEVlYzRmME1D?=
 =?utf-8?B?c3JqUDA1RU9WOHRZeVB3M0lUUExlU2h4T3lpVDRrdGtHNmJLdVlRVWFFRG9X?=
 =?utf-8?Q?o7WRM5gXN1CK22GgVLLY5GNCi9VQxnZu2sf0m5KsDzD8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc530d3-13d1-4969-ca44-08de0b35223d
X-MS-Exchange-CrossTenant-AuthSource: OSRPR01MB11808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:19:59.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10067

HONOR MagicBook X16/X14 models-
produced in 2025 cannot use the print key properly.
  (input input25: Unknown key pressed, code: 0x028b)

This patch fixes this function.

Signed-off-by: ston <ston.jia@outlook.com>
---
 drivers/platform/x86/huawei-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index c3772df34..d3b7b673d 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -81,6 +81,9 @@ static const struct key_entry huawei_wmi_keymap[] = {
        { KE_KEY,    0x289, { KEY_WLAN } },
        // Huawei |M| key
        { KE_KEY,    0x28a, { KEY_CONFIG } },
+       // HONOR keys
+       { KE_KEY,    0x28b, { KEY_NOTIFICATION_CENTER } },
+       { KE_KEY,    0x28e, { KEY_PRINT } },
        // Keyboard backlit
        { KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
        { KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
-- 
2.51.0

