Return-Path: <linux-kernel+bounces-753799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299AB18819
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECE61C83246
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535A21ADA2;
	Fri,  1 Aug 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nnF2CINA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nnF2CINA"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F5214A93
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079921; cv=fail; b=EfcBuxictQl3sz9JmsWmX6ksA6dfeGoWsS+ApE1I+5226DaUZu/wMbtXB8VU/fNeqz764bZDxBmETo+FrwIQ4psYcaVGJ0kNmDx4B7RVUDDt+D95LB+QhlLmWhgum6m6ow01x68Lft+KmBvygtxw1XOtv12WF6pGfosN2UDVuoU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079921; c=relaxed/simple;
	bh=VoAFHVSIPRagMjkckwZkUJ/qoNAbyO/w5hF7wqQ3NYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SIKnrFwqotKWcLNlOVEDv54cBgHkH9VIibOPcvlTgXkHgK1a3ZOifjVsNXFQOOncaFgTP+ZfAqeR2x0yMxEAcriRbWxQS9goTGdUBrCroN7l2Tetku6MSDUQDbVvhNl1JWmFGKst+d1pzSWQk5mR1sNjUUC4kfIrfVUGsssKnco=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nnF2CINA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nnF2CINA; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Mv30PB4YMTGJmdFF/k5vtuCYeOe7SM4qZ6LOIS1iowE5cews2EUvgfji/+Z1lHdwCONI2ns9eRZzyRpvA8mswxHz9sxg7upC8H5s7Lp3l+RQAL1TiAGUXhlwac+o9+fjn60RjRCMH6IoFuArMvR28bpMkNrpJAci2c7AqFRr9uxhlrymOgVVlqx9GIXWb3BwBjiHqqQ+5LPWn7gjgN9mFq7DfqXKWbN5HM7q1wftemabezkDpjqhu7OvZSjCg1JaKVeonKciWlV2vJqPXJKqOJpQLDcDmef6Y4cp12e04FsbUiwhHtO3AVgT19ZrKZGjQSEblq9Pyv9GUIlLCDB2oA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCssUiag4/GGfNeV2+HZ54KE8qE/7uCnWmcENsIuhYc=;
 b=inVXcb5VIVm74YnUImoFNUSD8XdneY8BFuEKRfGTjFgDjedViF+I4aDZYQwyAjtcggItccxgRiYqgFfYBOUrej+QHwW9osiQ5pLM30LPAPdQHDPexwDfP7O5a5rKp+Ey9rGUzRzcERsMnG6YwuN0MuVthty7PQV3g33GhiMv8FXUTA8U7Sl0ZOrDz6B7viklgtevVEhsKklQqlk0QecgqUeO0TIMihdS8I/j95aAgKDx4891ZacZYMeTlJSheWyQtavuJnTdgO9rZZOhFJIgBpf0VXOclvhBvxK8zs1RuSy2gEK1A+D/YDXVjqpVij/UX1uJTe5QlELvSNnplzWEGA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCssUiag4/GGfNeV2+HZ54KE8qE/7uCnWmcENsIuhYc=;
 b=nnF2CINAvMu9GYQ1B4D8lhPywV4A3jqjkySh4MDd9qIaxtv/lowiXQ4LZxSo5gOZ/rm5R0I3yjdb+f2YYPkaKZhfKzpAkzeG0ToP2FJJXEDppPxopHDfhQi3qr13+VdIwFNdChTTYTt8Gdm1zNOM4dR/WtSR0Uox5inpZsRXPpg=
Received: from CWLP265CA0488.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::11)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 20:25:12 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::cd) by CWLP265CA0488.outlook.office365.com
 (2603:10a6:400:18a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 20:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 1 Aug 2025 20:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5w9QJJUcYw5bis+gIm5llMGkElwIRT3YwawDN7LzSi/mGBnNCcPfWxQ4PCpuRZ3yImxGWyDEk94jV0fI4KSFO5xN2NZB+32NRsgbz/rZfiWZK09NoZtVDZGMIuhxyjZGb2NpCBT+Ss3vTfhZvcBpcC5OifEHfoDqj/Xc00iqG/DYxEhdeQVF5rg5n9MTtLror0JGzIHX2j2QHQtKhLHuO/lI6rFpot4L2X6lvymiWk5Aoy1TIYejefZzsWQDFzNDiY+/N0JOEe7HM9XWOVb0GPYmxuPTe0iZX0csm6IR/ZYSxZ75+ZTP+xWsu5nnPwbn/NYpvt3uwdbBNskyuBDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCssUiag4/GGfNeV2+HZ54KE8qE/7uCnWmcENsIuhYc=;
 b=oi9LgwIy4W7/4sL1sH697kuSXP29l1OUwRZBVMZNY0Ibq06Bgj2vFXL3NCD2BJzV8B987009Tc3dmVGclkKVwnLthyHpNfzZ7F2yEJ7HNZ5n5psk2qs1E3SMJ6hp0w7lmSFdVb/4X8AKOchGkk5eHnrGuI+LyHV+d7zkTSEz5bUiOR5RyvjdvfU3mwM2+49TpkxUDj+NhH9v5RxNWXe/4Mqlql1/tPwskG4hcNG8v9U3BUzaA5CWNOTEJ+d8kFzPGdCLsRpS55aMbsNbfSB2ZlmUqxWErNrbwXuR6GB1/jrS8bQhwEqw1hVy9rhJGwWn5LEbK9r2J0D6bBYDhavLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCssUiag4/GGfNeV2+HZ54KE8qE/7uCnWmcENsIuhYc=;
 b=nnF2CINAvMu9GYQ1B4D8lhPywV4A3jqjkySh4MDd9qIaxtv/lowiXQ4LZxSo5gOZ/rm5R0I3yjdb+f2YYPkaKZhfKzpAkzeG0ToP2FJJXEDppPxopHDfhQi3qr13+VdIwFNdChTTYTt8Gdm1zNOM4dR/WtSR0Uox5inpZsRXPpg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI0PR08MB10711.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 20:24:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 20:24:37 +0000
Date: Fri, 1 Aug 2025 21:24:34 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: thomas.weissschuh@linutronix.de, ryabinin.a.a@gmail.com,
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kunit: kasan_test: disable fortify string checker on
 kasan_strings() test
Message-ID: <aI0igs82mj5Qowxl@e129823.arm.com>
References: <20250801120236.2962642-1-yeoreum.yun@arm.com>
 <20250801131327.8627459bf3d94895d42b95b2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801131327.8627459bf3d94895d42b95b2@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI0PR08MB10711:EE_|AM4PEPF00027A5E:EE_|AM7PR08MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 22acd63b-cb25-4cf5-68aa-08ddd1398463
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SmxKK013Zk40VnpqM0VOVG9QSUZHVDNiMDBIeVR2T1h2QWp6WkluR0hscWNY?=
 =?utf-8?B?akM4L1VkV3Mzbyt4TkdPOHExYjJ6UW85KzJTRU11TXhrSkd1bWZUcHZPU2Nw?=
 =?utf-8?B?KytMTkJMaDdBRW15MG0zUU5wNXV2S1JhbnAvU0hnQ3NHUjlrNkxiZGRTUC9j?=
 =?utf-8?B?VFROZStTdzZzOHh2bVdyQThiVitEL0xnUFVRRnZUT2ZQWlF3S215VG42anBK?=
 =?utf-8?B?ZUtBRWNhV09aYm9MYmNaeDJqVnJ3dmloSGRpMklYN3VJekUzRjczMld1MGZx?=
 =?utf-8?B?OW9CaHRlMjJRMGpna1ZidXU3U1g0aXFKVENaWTdFNU9wV3RpY1MyeTZpaTh3?=
 =?utf-8?B?Y1JTb3Z3TitqR0Q4U0hDbXBHRncwSHBLVVpKKys2WG83SzkzSjNYOHlWc3Az?=
 =?utf-8?B?ZEFrQXZxTHlITVNLODQ4MVIrL21VVnJUWnRScUtwRFVHM0Rra1Z1QUpHblpN?=
 =?utf-8?B?M3JQSXRQdXRoRVE2dkY0RXZ2eVFBMEtaQzVCbVdoUzFjVnZYYXJYYUgvY2hi?=
 =?utf-8?B?ZlA5eDBiT3JzY3hiVE83UkM1MjlwWVpRUWduUWVtVXQrY281ajVza25xdjRH?=
 =?utf-8?B?RmpvaS94RGlzY3Z3Ykd2aFFqNmVUOHF5TUJrUFpTaWFTZzNpODFTN1F4ZXJ5?=
 =?utf-8?B?MnljQ3lscWFTT2pWK0lDQk1sYmEyaEpmaWZYUHlTaldxMlF0bmowS0MrVlpj?=
 =?utf-8?B?TmhUMWp4REdnYnVuNG5Tc0tqeXNNaGlLTWZYTlo4a2xTQVAzR3F6akoyUzRH?=
 =?utf-8?B?ZEd1UkFLOTJrMFg4OXFPV2p0TlVObnhnQ0prNytpdEVWMVpqaXJ6bkgvdG1h?=
 =?utf-8?B?WDFQWmE4eXowQzcydGVaMmV3Y3Fkb1NwVmN4aU9tdGNPcjU3T1VHeExuVTAy?=
 =?utf-8?B?cW9ZeDZkQWtKOHhPZW1jblU3UUt3VmxSVzRMYlptdXp1ZlBUL3ErV3d0ZFNo?=
 =?utf-8?B?NVBJdXFXU3FUUUhwQktRRFpxTk5XbTdwL3BvbHVYNitTeW1rQm52a3BXWTY0?=
 =?utf-8?B?bWEzcEFZczNJSTR0RUthL3NuWnpJUEo1VTgwQW8rSVFZeHNwNk9oRTIzdHRo?=
 =?utf-8?B?TUg2ZDhFVGQ1ckQ3OWRsRGg4SlI5SjJiV1VrenE3UWJSOElxZVBVWnVQZ1VI?=
 =?utf-8?B?UmpERWxGNG5mQ2NPSzhkWWJGSXgrV3FGaGxFQTJHckFmUWpqN28xa21NenJO?=
 =?utf-8?B?cGduRUc4czJTR2twdkZPSTdOdHFDWGdLQVpSUHNybjlCV3phbzhpTW1lQ1V2?=
 =?utf-8?B?bGtpNXZkZXh1bFJ3OEQ4YnRJRUlQUFhwZTNDN1BTMWFDeDByamxBR0dvdkhM?=
 =?utf-8?B?QW54OHdjUi8raUZKSkdUdmZVMzgyQmk4YXJJZDNGRHNzd2xwWDFvTEdSWEd1?=
 =?utf-8?B?WURMbDI2US9KNlFBbng2cW1jaVArUVF4UzZFQi9wbi9MU3g0K1lHRm5KbjJC?=
 =?utf-8?B?dnJmV0VQU3dNVEQzc203YWhrZkJuUEI2TVNHTzA5eU42R2VWRS9Vb1U2dndY?=
 =?utf-8?B?V2ZXUDVmZU5zTWIxaThyRVFLNGxPSFAraFF6MlVCblJjZVFHUmNqR3cxOG1U?=
 =?utf-8?B?UnhQVVdJQ0k0QjZwRVNEQnk0bDFIZGF1VkpnMTdNbWJYTU9ndFBIamtDYzNE?=
 =?utf-8?B?ZnBNWVFXb2V6QTA3RTNFbXNwK2FGRW16emp1V1FpK1lGaWQ3MERaWFMzdkQv?=
 =?utf-8?B?TjN4aWZ3Z1BLNE1sZ2I5NEs2eHlBdGRDRXVmY2RuOXVQUUF3S2EyR2VtZFVl?=
 =?utf-8?B?MVRXMzNYMk5pcGFsVHNVR2tIWjgvUERGUExpeU1IY3RKcHUzZGFhQjNwY3Nl?=
 =?utf-8?B?OWswUjJhWlhrdTdSRGVxUk5qQm5zOGw5MnA0NWdxT0VxdTluRDZYSnRPWEkr?=
 =?utf-8?B?QzMxM1VUd2JjZnlNRG5GbDdlTC9NWXdsNnhsZ0dyNHZzNS8xODFwTkp5M0VV?=
 =?utf-8?Q?ktmVgmxRrKA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	62da765e-6a22-4e0d-8d49-08ddd1396fbc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|36860700013|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJRc09OWlpiWVRFY0tHVkNhYWxhNmZCVmFLWDFrd1ZIaGFhSGg3ZWZYclh5?=
 =?utf-8?B?OUpGbTZMZ0srMUxZdUVLRVBiRDRqYTNCWnNCelVkcFlWWTE1NEszZFprMks5?=
 =?utf-8?B?OHpLMjNxQ014TmRGK2Q0dVluTVMwbVVTYlR0bXk3aU1udnpqQ25NSDhZa1d4?=
 =?utf-8?B?UDZmM3dLdnJqNjg5U0kwWHE0ems3WWxMSmZYYlRtaGkzdEh4aEhDempMckdI?=
 =?utf-8?B?RUk5djE0ZGhtbW9hNUd3ODNOa0lrbldVaFpTYlpwQTlhNEl0bWZYS0VkRGZu?=
 =?utf-8?B?ZzVzSTB1YUNxSlZOUVBhSk9yUjdycVhIbkJqVmc3RUVkamxxcm9QQklndUdo?=
 =?utf-8?B?QmttcFlHTVFhS0lscmM4aXlUOE1BeHF5QzVYVS9MYkZCSk5wMXB6OUVHTThs?=
 =?utf-8?B?aFJQUW50RDQyYVY0MVZkUWJET3JoVUtyRmZGTVdoS3BUT1FtZmNPMzJJRCta?=
 =?utf-8?B?R2pGRGxxR01ZaEZHeFQzSlVGU3BBSWM3THRxNXEwN3Y0U2VDb2xQeFo4V1Vv?=
 =?utf-8?B?bmJTcWRMYkU4V0E4NjVNMTBXbHRYTHJPeFJQK25RZEFmdmJOaE9Sd1ZReU05?=
 =?utf-8?B?bGRtbWoxbkJoQ3g1VjE3UDRkamhTcXVJNGQyNWxLTGp6dkJybFZ4VkZWbHRl?=
 =?utf-8?B?dTlvc1gvZG9mbXdGR3RFdUYzMEJ6ODZaQjZvSjVwNEhycGpObmNtOGxwV1lF?=
 =?utf-8?B?YVI5blBmUENpVXNMbWhIMWFPTGVna0dHbVFzbGZNZDlwN1lHV2hodk15WDl5?=
 =?utf-8?B?ZnU2NkFyaThLeDFlQkZlSkQyRDlhUTlCRDJWODU1aHM2Q0h4dUdLVUdJYVdk?=
 =?utf-8?B?cEtkeFpoaEJsaWFWbnVpVjdNeVVCaXRzdXRCTDFQTG9VMW9VTnV4UDFrYk9V?=
 =?utf-8?B?YVdlNS9nRFdSVzNqamNORm4zaGlsc0pMb21uOXJqZnRDK1hOZThyR0RBTWpz?=
 =?utf-8?B?K0IzNGF6S1pSN2dzVWVqTkZNUXk3cEptTmgwdlM5MGttWk0rRUQraTZNTm1D?=
 =?utf-8?B?NTFBZG1jaXhjYm55M0w0NUlVVXpmSWpzVjQwbDR3VFVZNHVHdVgrZTNlSDhM?=
 =?utf-8?B?RU9Ma2NOQm1nL1lGdUpBSTlmWG90eENvNndNU0RrR1FuOWp2dzQ4TktTQWtR?=
 =?utf-8?B?TkMzT2piNDVKekl3SGcyM2xVOXZ4OGhnUzYrQUZ1Vzh4aU5COHFrdXdyK3BJ?=
 =?utf-8?B?NHoxR0NuZnV4WllzTkZYWkU2eStNZUcwaWg2ZHdQUVdiSFltUldnSFREVTYr?=
 =?utf-8?B?MXlYK01YMk1xMnZodXgxZENidWVXaGcva0J3aTJsSU5YanpqYnRWOXhTb3g5?=
 =?utf-8?B?Uk1xaW5qSEc2U1VZQnRYZjNKdUJiTGlCSnFWOCtodjY3TE8ra1VlZm4waWxy?=
 =?utf-8?B?U1Q4V1VreWR0bXhFbDBpZHdFUzNKM3Nhc0pweXN6REg5N1JjZlAvSFdJQjBX?=
 =?utf-8?B?WGpESWoxMnczUHdvRDZsOGljRXhzNjU4Q2NSRURGRythakdCVjlxN2dZWE9H?=
 =?utf-8?B?RXJrcXMxNFpRbXdYWlVQTnI1Vy9CbkoyNXhRQTJhcEE0NTFqSXJ1SXBEaDZU?=
 =?utf-8?B?bWt1VURxaXNsUktSZDZNMTVDR0dxQktVQ1liZS9iY1lLOGpyQWtKR3pTT00w?=
 =?utf-8?B?WDgwLzJ6ZjBtaFV4b0NhMFdRdTJyemF2SVIwV3NJRjNtZ2ExSFpwVFYya0No?=
 =?utf-8?B?N2xWNmRoZmZuVnk0QXF3T0Y0emN4OE1yTVpaakNOWEd0TnE1WkVDZ29sL3hQ?=
 =?utf-8?B?WGVLU3RRZU11SEdsVmJ3dlViR1hXZ20yNDJJWjQ3M20xS3RCNzBnZGE0Z0tk?=
 =?utf-8?B?dEJnYk5NTWFJcUx5bjV6OU5GWGV3clZFMXJyYVFMQ0g3VFFhOU9PQk5pRU9J?=
 =?utf-8?B?cTJZTEVVVmR0RjhwL3FuRzUzamg4NGNjWjlKUWFLRWRHWVdzRG4yTmsvUGZH?=
 =?utf-8?B?YU1td1c0ekorb1Rkem10T1RCRjd3SlhpQ2xMS1RBdXhrVEI3clBjWVZFVXpQ?=
 =?utf-8?B?RGUzRDRIaWFINHhyWGVnY3lWZnJCekxWWTEzRzZxcldPc1VDTnlXV3ZHSDV6?=
 =?utf-8?Q?3OC9rQ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(36860700013)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 20:25:12.0045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22acd63b-cb25-4cf5-68aa-08ddd1398463
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302

Hi Andrew,

> > Similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
> > FORTIFY_SOURCE") the kernel is panicing in kasan_string().
> >
> > This is due to the `src` and `ptr` not being hidden from the optimizer
> > which would disable the runtime fortify string checker.
> >
> > Call trace:
> >   __fortify_panic+0x10/0x20 (P)
> >   kasan_strings+0x980/0x9b0
> >   kunit_try_run_case+0x68/0x190
> >   kunit_generic_run_threadfn_adapter+0x34/0x68
> >   kthread+0x1c4/0x228
> >   ret_from_fork+0x10/0x20
> >  Code: d503233f a9bf7bfd 910003fd 9424b243 (d4210000)
> >  ---[ end trace 0000000000000000 ]---
> >  note: kunit_try_catch[128] exited with irqs disabled
> >  note: kunit_try_catch[128] exited with preempt_count 1
> >      # kasan_strings: try faulted: last
> > ** replaying previous printk message **
> >      # kasan_strings: try faulted: last line seen mm/kasan/kasan_test_c.c:1600
> >      # kasan_strings: internal error occurred preventing test case from running: -4
> >
>
> We don't want -stable kernels to panic either.  I'm thinking
>
> Fixes: 73228c7ecc5e ("KASAN: port KASAN Tests to KUnit")
> Cc: <stable@vger.kernel.org>
>
> What do you think?
>
> We could perhaps go back earlier in time, but 73228c7ecc5e is 5 years
> old.

Unless others feel differently, your suggestion works for me.
I had considered including it earlier, but wasn’t entirely sure.

Thanks

--
Sincerely,
Yeoreum Yun

