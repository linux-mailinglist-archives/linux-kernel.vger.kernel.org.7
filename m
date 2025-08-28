Return-Path: <linux-kernel+bounces-789882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D64B39C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DC63B7D23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551830E83A;
	Thu, 28 Aug 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o+pKGnmZ"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E530CDA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382442; cv=fail; b=EGM6BHnWQl3PXj6/7HUiLObFd7OF5c/N1RJlkvCvlffHAOtQYddge4Bxg1BF42MRjiXU99cR66MsBlilY6Un7G5wqd19B1WUBIVwy1aeQ1JddX+XOk98ksCTVaF7F8vJ/e1NMH2IM6x9Qv2HYXl5SHzy3/+gYCuh+PR9H2CfiHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382442; c=relaxed/simple;
	bh=ItvB9IwG3qFDbhzmrNc5inFqqVgEox3dfXO/YSS5/Dw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDsDtBdAoTPqxYTT+ioksh6ONvf1tMqj4oXKTnf4iUq/tpPZAUobzuLlYxmj4VvWId/XJFeDm0PYbuHOiIryrjqIUk+dOqtxACfyB9lZ0p4luBLzm1duMqMgl4t8HuAH36+hn8CtcXT2UHI2AlKCPzivPR08B0Unyd2aWzvbtMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=o+pKGnmZ; arc=fail smtp.client-ip=52.101.126.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGwyHDF7w1EyQYcWHUyWZbWVTnRD9ep0DeK/s3AGQKg2oLAuFk1I8RRSEdpQgzp9K3ufz2nvOW9F80xKNXzYzCqrqppTuVNxupMez/SwqC19ZewhtNPIW+vfrxRRpQedeOJmY1i3WjF6B0YMePoV9WAWpijYIbosIT04dm9ByxjaFpCdEYG8cq28NDQ6uVTph2aDYKJUUNw80tkddDMZIsq7Gpr+o96myWmja2QXJPDqju0ky9mv01tUzTKpIwxV1KNDZMAPt7xaZGKHMCZijgL6GIOL+PHsc+ZyJr1jeQH1CaaCKiunrL3VxcZJEgE3ZKcuqf/S8Q2ogf1lGgbZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK5hneeNQDujMKdBoB8hATm71e62I7jYadQ9YgX6/7o=;
 b=bg9F+s2cNo2qzvU9z4mMbRVHZxrstjz47chdyklRZoBYIyPNuYy4Vt/8F8KtXd7QTtOuvKQhMf3riYmRvot/ZmKK/i5+jn0orrGeN8rdhLh7Rrdokcpiz6W9fFVfppiEqKVa8CSmPMBCcaT3KlsOSqT/EoXoQdspgZYI3GH5EXMVN4tZykQWyz0Z7IIE1lCB7RWd9ijhiqRZZD3FztTonfnj1RWT6YJV4UjCs2AK6ln5OzrKFwhYxo9g3WjsD7kdJ67Y/wI/Y78F7lSAmMi+7bHQRJYFyywklcYFg4qWeeNzS0dzwIMZ6bsLdbarLXIaMJbnlDoM6NFhmLS5G8D+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK5hneeNQDujMKdBoB8hATm71e62I7jYadQ9YgX6/7o=;
 b=o+pKGnmZsyFufOYaONOs9YXkpI5noWrzcTF4/X/qJL7N/sEzN6hadbqRI2SgKbtAr0Dxud2o9kPkV2tFAhe5U3+5iPHl4MZhHpAqGV9Jm/zQoTiQpOuxt65bIy/q+VA211G/D+GG90SIqVgVWdHF/RsU6fVAH6/HuyWTz11o5yw5glPaqvat51wOqVGR/9/q6DCaLGIjIBXGR/MNOcW9jbr/xMegoNTPPWA0twX35ZD8XbBC0vkSBddrdGDtwsxUXUZc3FW7881EgDfNS/mb7VRcYhI/X6BsHtm4afHBySGLMCacOurxiESrPe79QaUQkopyhD9R/lfXT9pxmX2xzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5420.apcprd06.prod.outlook.com (2603:1096:400:200::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 28 Aug 2025 12:00:38 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 12:00:38 +0000
Message-ID: <bb6835e1-d6a7-4dd9-9c0e-f3d7794ac0a6@vivo.com>
Date: Thu, 28 Aug 2025 20:00:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/topology: Use kcalloc() in sched_init_numa()
Content-Language: en-US
To: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
References: <20250821140833.24791-1-rongqianfeng@vivo.com>
 <xhsmhcy8fln00.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <xhsmhcy8fln00.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e4c460-4824-4ee3-0389-08dde62a80ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGhDeFJ6WDZUR0dXR2NVV1RGcnIxRVBrakgwNk96K1ZoSUFucHpTRzVFNUJ2?=
 =?utf-8?B?VEpSb1Q4Q3NwRHMwRmFTeUkvVmVYQUMzVjNBOGlOcjBxQjNEWFJwci9lYm0x?=
 =?utf-8?B?NnZGRDdmSGlEdkFjbUQzSTRPQjZwWHdzcEdOejJMOERqQ1BHa0x3NXRCMGF1?=
 =?utf-8?B?aUhsK1F0d2dOMkZTM0ZGN3BHR2s1UTU5di9NTUZrQVkrZ2Q0eHF4c083bWV2?=
 =?utf-8?B?d2o4NWJLclJOZWxkSVY4Y0RGS09BL0FYeEJtM3FkaklZV2lUU2ZRV0I3Ump1?=
 =?utf-8?B?bDE1WFZ1NldXNi9DaVcvdEZ1V3RlQXl3bHYxVWJ4azdFbHNZSEhtd2NPVzAv?=
 =?utf-8?B?enYzMHpvUU1tYmtDRWl3dWZya05lVklSSjJSZUQ0VFZRQytmNXlZaUw0M2lQ?=
 =?utf-8?B?OSswQVl4aVZnYi9IUy9jdTBsakF0ZzJBWlViZmhQaTQ4NG5YVXE2OE5la3Yy?=
 =?utf-8?B?QW1WTjFuNDZldk9pdFhmTnhwbXgweUUwVWpxQWtrNG5DN3B0TFEwMzRJNTVJ?=
 =?utf-8?B?YUNDcjBDNlFJbUU3OWVzOU15c1U1dDhzVk0rOThMN280Q0NpMDArbk5XYXVN?=
 =?utf-8?B?NXRwNUIvQ1ZTaDJnUjUyalgySFdPSG8wUHRaU3IrVFR6WEg5L2xheFYvMGg3?=
 =?utf-8?B?ZkFMUVhSZlhteFVyUng1TTJUWFloV29BaDhOdkhQUnNVS0dpUnpUTkVHcUFB?=
 =?utf-8?B?bXZieExtdStsT29XYUFFN0xQMTJpbUlKaXJiSklFNEdnMDJMbmY4clFyS2ZL?=
 =?utf-8?B?RXlKYXAwVzM0VW9lYjhnM1JlcXZscUI4RXpMTXMyMnJFb2ZQRG91NEUrVzhk?=
 =?utf-8?B?d0pIMk9OYjJoQmZVbDVQbllxWHBMdzVxcDNyY2JVWDNYWVZWZDlheU12c3BI?=
 =?utf-8?B?WmlSVmxzSFR6Kzg3YllFcHJFV1pCSHpNb084ZG1TOWxLVWw1NDdZcFRrK0RK?=
 =?utf-8?B?VnRCV3RhWGJXVEdQNlRITGx6dnNmeFV2azJXMTVKZ2U3YmVXZml6a204a2Vs?=
 =?utf-8?B?YWdSMkZkcGFQTXJVeFBoR1JRaDBIRWkwMGdsWmNYVkJTVzZRU2lsT0x3TG1a?=
 =?utf-8?B?THBLaUZqM2hEZVpXdTl5d1ZtZlBjb0x5K1dOcnErRHhDSHdoVXRpUFAvYnlo?=
 =?utf-8?B?ODlYaG0wa1dhOXppeEpjSi9iOTEzU1k2b0dybHJ5ZkVQbTB6aFY1MHM5SGRO?=
 =?utf-8?B?cFZ2b3FKdDd2WkpGczRmaDVRVVB4am1wUzRrZnVyY1UzenBWRUtuWVQyUThE?=
 =?utf-8?B?Uy83a0U3c0dpVnZWT25rQjJkTjVNTFBGaU13Y0g5MjVaazQzeDBHanZoS3JI?=
 =?utf-8?B?eUFhZ2FETWk0NzNsa1hYdlJkYTZyakFKc1J5dTVHeUhOVWtCaDRaemt1R25P?=
 =?utf-8?B?blZmeGdPZ2paeCtwZFFHRng2ZEpNbXE5UzFhcENJR2VFS01OT2JtYy9NTEtt?=
 =?utf-8?B?RS8ycVM4MTYrNUZTWklFMXdxbkNpRmRqcHJqNnVIU0RScnI3N2JKV09ieE9U?=
 =?utf-8?B?K0tEazNtTnhpOExWZFVwMG56eEdLaEhKY1ZuOGNLcmVaVmxBZGM5KzZzMkp3?=
 =?utf-8?B?U1hHdGZaMmhuelpBRmd3SEYvUTEvTjhKQnYwSHhXUnRsWG1VdDkvUTJML1g3?=
 =?utf-8?B?WnlNTC93OVhhMk85KzlUYUZnZ3ZOTHdlQ0EwSCt2MlRrOXlFRWpObDlWVWJw?=
 =?utf-8?B?ekNwck5IUElhNHZ6b1pHcW1JQTBHbW9lNk00aFg2NDJ6ajZJdjRoS3VtOE1D?=
 =?utf-8?B?Q2hsV3gzU1ByVUt2T0xZOTVzSjJGOEJrZDZxaks2S045YzA3eU9zbjJjMWNm?=
 =?utf-8?B?bGRpRmZtSVJubWVyWlVWTkF5cHIzMzE1R0RYQnJCak1LckFjdTg2Wm96VEJ0?=
 =?utf-8?B?RThjdkhvUGdUWFhEeWlPYzdrK0VZL1hvdEFGZzVoQUcycDdjaUFRbThVYXRK?=
 =?utf-8?B?UFJOS1d3ZTVya3V1QWpNTnRFNmhzMjFPeDJKTTBPOXI1L1UzenFTUTA5Yk9L?=
 =?utf-8?B?bHdQcExpYWdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0hIbzVpblFvMmtEUkpySVhJNkR3NTVNL0xpczRaelNQTXNoYkQrbUxDeW5L?=
 =?utf-8?B?UnlrTkpuTzFqSzIrRFJvSnBTMFlOdmd1ZzNnR05odC8yeGVYNCtUb1lTbEdO?=
 =?utf-8?B?d1l1dThodFFiUzNKdVF6TWEyaFBLTHAyYnZMQzN6enhTeUdwREl1MzBhK0Vk?=
 =?utf-8?B?V2VVY0luMlAvS1VySlg5bm9uTDFFS0ZGaVpvYXV6cmYwM0NrbUxtdnpzeWNH?=
 =?utf-8?B?a2VBZ2xlSUdzMGFQNktOdDlNNVZnN0prUitUK3NDUWg2SVVvV0VKUDVxeTdw?=
 =?utf-8?B?ZHgwZStqclZUdTZjNXZrVFovOGtmZU4wSlRvMTY0Z2VzRTJ4R2NNc0liZGFx?=
 =?utf-8?B?eTUrM1V4bUFjYUg3bWh5dktrRmQxaWlkUWZCa1RQYWt6UXdLZ2F6NWloMXda?=
 =?utf-8?B?WEhQdmRMYTZ2bjNYT0J5cmtCR0ZseDVKb3JSNWFFRStNMW5DaUlnMzJGeEpR?=
 =?utf-8?B?SzdkY2hwMmNXSnVnSHJWeXQ4ZjRVeS82dzhOdFVacXR1RmFvVnovTi9KSStv?=
 =?utf-8?B?UHpFdXhXdWEyYUNDMEk3SW82KzFXajQ1T08rTExEbHhEaXpxMURSTkZoWVd4?=
 =?utf-8?B?Q0RHYy9MZmhJYUxHVnF2elZPNVdDUGRJU1EwZ2RodUdmZGlYRWRjSXgydk9T?=
 =?utf-8?B?Y1RNOWtpck92dW5pOE1Tc29aNXk4MHU3dXozQWhXTHNtQ2ZIWDhaaElaRWw5?=
 =?utf-8?B?QjUwTEhKYkh0NTI4dGdXZy9VeWdmanpHdDQxUEJBUUJQcXRUUHMwTHprQkpX?=
 =?utf-8?B?ZXZjbm5hbFgwYzJRQVEzU2NYa1kxYk56OEpyYUplWUtMMHBHSlJIV1dOeUll?=
 =?utf-8?B?SjcrcVZRa3owR2pmaUN4cW9aV3pucUppZ1ZZQWI5dVBKOGd1R1JtejNrWkZ2?=
 =?utf-8?B?K3AxUTg2eFZRM3BUQ2xzbHJFV2lvdGJIQ1hNc1RrYUdUVXQwNWpVRzk5d08x?=
 =?utf-8?B?aEN0WFpEeG5kMUhhL1BHeU5YNkozWTJlTURDREdSTjdtUHovVFdyL25ZeUJJ?=
 =?utf-8?B?LzVlQ2dRNzNJdnRGaFdKR0lUQlA2d0MwN3Y0eUpJb0R1THByWXZ0Q1FZSndM?=
 =?utf-8?B?clJJNklXdDByNFNHS1IzNEJ3MTFKRjA4djU0RVMwVnM3Wkk1Z2sxYUhXcDMz?=
 =?utf-8?B?bDNyRVFlb3BTV2ZwTkxrekNFeXBLNTd5MlUwSElvRmNXRHNXSnpYeHN6dDhP?=
 =?utf-8?B?Vzg1UW9VRXcyUC93YVYvazFuam53MS85MWwvaVorWXZGMGhhaktUOUZKdnlU?=
 =?utf-8?B?UHhNOUdTc0hwSS9VRnM0bkJwNnJOOUdUYXVrcXF1SEdNc1RlSnl0TmkwNm1I?=
 =?utf-8?B?Ujk5ZENOSnIwSFB4Mk1HcWMzMjdoR2UxSHFYbjJrSEI2Z3BzMkJzc08vb3Vx?=
 =?utf-8?B?U3M0Qyt6T2dMTTJPWlVXVm9DQi82a2h3QWk4MFU4OW14eTVSdUE5VmVhTHdT?=
 =?utf-8?B?dFNvbzBzbVZ6WXFlNkpUWXVKN3NacldhZlNtaGNCeTlWZVZnK2pFbkg4cmZK?=
 =?utf-8?B?UlExN1RQUFcrYkJjWWtkaW1aaDBabE1Kc3NlYitqWHd4MjVaeWNNM0NGZDJm?=
 =?utf-8?B?ODdvWmM0dTJWeEYveXlPWmVua0dkMWgvdjArWmxsWlpidkY2WXNwMmwzbWRi?=
 =?utf-8?B?Wm0vMGo1S2lvVG9NWllUaG5PV3FMZkxkMmZyN0Z2dFExK1Z3VTJWNk82QStQ?=
 =?utf-8?B?RTd6MFc4am1HeVRSK1JHTldKSDNyZWFqdXBma3dTNXdmZllMd1ZLUmFXRlhF?=
 =?utf-8?B?djVTbnh2by9iaGV6TUlKZmd0amFoOXc5QTB4dnlVemdhOU13MGxkNXhzL2x1?=
 =?utf-8?B?eWRsZVpETktFTlQ5aWpCSVF4NTlxOXRWVjhFaGhSM0RkSWlOZitsbGcyb2Jr?=
 =?utf-8?B?ZjY0c0oza0x0c0dtYVpuY21SZjA0WTZ3eVZuRnhOZGZEWHZtd2xFTkpBYlI0?=
 =?utf-8?B?TnZYZ1VGblpVbHE4VXlOM0tIdllaSUxGRnc1SGRJNW51UklOT204K0lROGlh?=
 =?utf-8?B?TzExOGl6aXRXbHI4ZW1FbWpjOGFodkVMbVVJbEhnQ3pXeUZkZ1pqbldIL0dE?=
 =?utf-8?B?RjJ4UmN2Zk13NmxZU3pSeG8zVkZBRVJhYWd4TFhMY0ZSa2k2bXRLbDJLVzJD?=
 =?utf-8?Q?UEYY52D8JdD6DXgd2sn2iR+bs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e4c460-4824-4ee3-0389-08dde62a80ab
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:00:38.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToHgGsw8Y/UR9oTV5GTVeyHEBmhfS5hp1tJTxnb83EOa7VRh4hF5hMiigtPYsoxZtjRT3Bvl2SThirV3ehy6wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5420


在 2025/8/28 19:11, Valentin Schneider 写道:
> On 21/08/25 22:08, Qianfeng Rong wrote:
>> Replace kzalloc() with kcalloc() in sched_init_numa().  As noted in
>> the kernel documentation [1], open-coded multiplication in allocator
>> arguments is discouraged because it can lead to integer overflow.
>>
> Hm, checkpatch does warn about these.
>
>> Use kcalloc() to gain built-in overflow protection, making memory
>> allocation safer when calculating allocation size compared to explicit
>> multiplication. Similarly, use size_add() instead of explicit addition
>> for 'i + nr_levels + 1'.
>>
>> Link:
>> https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>> #1
> This document is actually in the kernel sources, it would be better to
> reference it as:
>
>    Documentation/process/deprecated.rst
I didn't notice this, thank you for the reminder.
>
>> @@ -1994,8 +1994,8 @@ void sched_init_numa(int offline_node)
>>        /* Compute default topology size */
>>        for (i = 0; sched_domain_topology[i].mask; i++);
>>
>> -	tl = kzalloc((i + nr_levels + 1) *
>> -			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
>> +	tl = kcalloc(size_add(size_add(i, nr_levels), 1),
>> +		     sizeof(struct sched_domain_topology_level), GFP_KERNEL);
> @nr_levels is at most 256 (including illegal values between 0 and 9); @i is
> going to be the size of sched_domain_topology[]; is the double size_add()
> really warranted here?


You're right that the maximum value of nr_levels is fixed, and the double
size_add() to size_add() here are indeed unnecessary. I will submit the v2
version.

Best regards,
Qianfeng


