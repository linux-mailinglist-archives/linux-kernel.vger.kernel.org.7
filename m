Return-Path: <linux-kernel+bounces-894298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE1C49B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DAA188B81E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C422F60DD;
	Mon, 10 Nov 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="S/iemYyu"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023086.outbound.protection.outlook.com [40.93.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82871B0413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816129; cv=fail; b=UP+cCjMkpOs2pac4DCjOUbdJFVfDzFWKt1AroGKFhqbkT+KIToAK+2piweMaLSzRmenNzIXz7f0opXt3aVaI4OQWf0B+qoe4/2mK+Ux7hVi8CdnejINZc4Z2+GZUmrS2iF7BMUvTBMiZJGa1lGYIOpNyvpqUtqd3V7LtWGhWasE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816129; c=relaxed/simple;
	bh=kW2C0z+LzzxvzjXtNalg4SZ1SEhMzUe62i3MeONDa98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KYaXYh7wANALzojev2ocpUOkL3DeLDOhme6d35Nap11wF2AVOD8FYV2vR6X6cB1gT2OqMqbFgYtWBSQ+PgUM8wqshobQvhvkDqswOb0N4ms3YZPr5dqIauvRvxwLy9g2kBhBhzNIhhDvJReKAJ7a0xoOm1zk79EAnDaFeREiRkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=S/iemYyu; arc=fail smtp.client-ip=40.93.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVei4v8LXvkEfR9YdGDFhJBgggXSOQ8wpdVJQop9A7UXmdrm5dfK+WrGd/TAQjojna6DJPJG+XxLGBdo2s+ILT5ipRXjMmg65wU26OQ/JkM8IwJnZdl4iqZQsFY2GD7/yjjJfTyfWVG91qgN2Y26Pm3fll+UrdYU5QEbMCAhbQwAqEmA+OyCALKFQCFRvEdNUVL23rnTgKBWu2P1191fy0Ve/vB7l7EpgP5j7zGCzlNGb9/IqVWyfLnC/5pUonPTtlW1cB6jxe43vpDZdRPfqI5bjAffkwoqgKBQxg9WN3stw9h/fsr0qLe6htCMGU0URqVBHp7CMJCnX+pytUi34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddxOGaP0mzqWGvixmT0SQSsnyuG4hEj2GapP6bY9neU=;
 b=cVwDhxSVVoMwal2WwMPEPwu2yvpDn6xvZsX/z/vDnWtSaOv03RyoZClxgyJXgHcK5/Pg8m1XBoiXxwGZK1YiUDwBc0taPLA8lYYWg9ui4p/YgblxLqlPc6mKUvULpJTsBNluxKPgKE6r+6zmvUUf1Bhn3Y3KVeHaQcOkYRs0UwIwh91RMdcmL+E2OPxYhwp2qD5XFLOfqjrNOlpmNl9BAt/K1Yy1ESGJiuEkWNk6koNtiNVPVjd6whov2kkwu1F+ELq6DJ9ibwH7YL0PGmYL/9zLumxhvqWP2+xlth1PGPwaS8Bc2wtV+ozMs+RMHBIzasz2F58SbHUTGqAyo/7GFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddxOGaP0mzqWGvixmT0SQSsnyuG4hEj2GapP6bY9neU=;
 b=S/iemYyu6PPV7740EpxNeOFhdqDWsqM7nVPxyBRcd0ENJ7gcMAONqwf1AJOyWgYI6Nrp115wVmKrQ7bTF1hjX9X+kiqV8qmoLoPC7pB2Lnjfjydgxk7kKMoYvkfkjbtaTl8bHWJ2RPJDS8+Mb6iA+hGvqUQNCVbld39OMwRC6E4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6293.prod.exchangelabs.com (2603:10b6:510:13::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Mon, 10 Nov 2025 23:08:43 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 23:08:43 +0000
Message-ID: <a6d3d2d3-32b5-4784-98d9-1b42a0ef4616@os.amperecomputing.com>
Date: Mon, 10 Nov 2025 15:08:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: make linear mapping permission update more
 robust for patial range
To: ryan.roberts@arm.com, dev.jain@arm.com, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251023204428.477531-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251023204428.477531-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR22CA0074.namprd22.prod.outlook.com
 (2603:10b6:930:80::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 37efae60-bf55-48b4-fbbb-08de20ae1825
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW0vbS81RVp1dVdwYnIza01JSVBSUWFoM1N5c1BWWVczdGd6d2FTYis3bnlX?=
 =?utf-8?B?TlJ5ZC9lQXRrTkt3eEw3Yjk5aEpaMlNraFN2SzRPOFBzMG5Cc2xYYVVjOWx4?=
 =?utf-8?B?T25nYmdwdUhrSFczbTJid3V0dEFsTElIQkdTeTBRT0Q3VTlmT2l6ZG9lMTlF?=
 =?utf-8?B?bzU2Sjl2Vlo5ODllWUhCOXZENHNxRXQ2QWZ5MmNiQlNMVUFUbE82UTRGaVhJ?=
 =?utf-8?B?eVlhQU9pb0xydXBxYmpoT1prUjdkajNadWRJV1JIQnloOTVJVWcraXV0aC9C?=
 =?utf-8?B?SVZJMWNDL2k3dmd4MFJWWFBnV1RTSXEzbW4xV3k1N1BiTVM1NmVrWnRTK3NC?=
 =?utf-8?B?KzhvZTVrUmZ5Nmw4TmQvWUZzLzlOVTVUbk9COHcyMUFXRnhPTm02TWZkZjlh?=
 =?utf-8?B?aDdTeC9ZQzZQUUk5bzZDQllUUVlnN0YrT3RnbFNqdU4yM3Z1L1d5UDVRWi9k?=
 =?utf-8?B?c21KQmNhbm9xd0hza3l2eGFWdlhESXBhRjdCYmd1UDJldkdOWW5zZmZMMUZP?=
 =?utf-8?B?VXlHcnpFbk0zaitpMU01UE11eXRsd1Y1bGU3bEM3OUFrNE9OM0h1WDN4cXgx?=
 =?utf-8?B?UVBNeitubmMwSmtyRGtPcmk1MWMzakxyWFg3OWxFU2pUdEc3WFR3dytMNUVX?=
 =?utf-8?B?d3J4YlFPQmxmOXFjV0lFMG5lMkNqSUxpM1d6WnJEMk0wWlVsaUpUL3Awdzlo?=
 =?utf-8?B?MHRXc0QweGJCbTgvMmxFSEJRaHBtcno4VnVDc1k1SVRYWktIaStCTTBWd3Vh?=
 =?utf-8?B?ZzdHZkU1Yi9mT1g1TTV1R0FvUnJ6ckY5UUhRTWsvRDNtMTNwK3Qva090YXdS?=
 =?utf-8?B?blpZR2IvTE9tNHlQSjFEOG0xYUJrZWpBVFZyWnUxUjFJTlgwV0poWVVJR09U?=
 =?utf-8?B?dlIxTEpRUTdJRVU2QzBFL3lzMkpiaXAzWjdNZG83Q0JPdjl5VkJtQXpza1g4?=
 =?utf-8?B?dGE1RHg1YnNTZDdDZjZHZFdPek1hTFdqdE5mLzB4UGlpNVk0b29wRGQxeDI4?=
 =?utf-8?B?bWZjZW4wMXNWcW5jZmlQRGtyc0lTa1hTN1VRaGxKbEFHVE1LajJHNFlHT2ls?=
 =?utf-8?B?Z0pSK2ZWaGFzbm9FeTZmYkd6QW1OT3NmbmdWVDhTOG03U1h3aGxRaUtvT09H?=
 =?utf-8?B?UjE4WDRRN0NtKzNHejdzSWlFamhhQ0pMUTNGVTYzRzQ3QlBrSlVuVjQxRHVN?=
 =?utf-8?B?SHdSTEN0RzhjMHJsbXRaRG40U3ZIWVZ4Z0NIYytSRkZCNGpRenVYUytRY05F?=
 =?utf-8?B?QWRpa1p3WUVZZ1FpNXVlZWtJMTM4bllCTnBkcFJaOENoZUErbXJGWkJ2RW9M?=
 =?utf-8?B?NzZIdnplNEJzdHc4MnpidFFiZEZFTnBzTzZ1RnFqdUdoNWlwZjFtR1hwZU9I?=
 =?utf-8?B?aUdtUmpsMy9VM0JsOHlaeVZZZXNRR05QVEUxZkQ5aUNoQUR0aTNqRnZxR280?=
 =?utf-8?B?SzA4ZnBxeXUzNkdTeUQyRnd6eTk0VlF2WlRxYWx4bFExZi83MHBSeUplc3px?=
 =?utf-8?B?ZmZ1dFp3c2pQaDZwY0xSVzFzdi9yZUpxZ2twVTNnYzExdnFFNEw1TDN5UDRx?=
 =?utf-8?B?N3FEUkZOek94NGgyMERPYWFHQ1BTT0lpY2EydHpna0l3VEZkRFVGWUt2cVc1?=
 =?utf-8?B?dDZNdW9ybm1PbjVQL3BRUzlrdnBZNTBuUGVIQ0llTnJibm1yRkJTeURXKzlM?=
 =?utf-8?B?YlU1UVJVN0JPOGZmVmJsc1d1anNWNldZWUsrdUhuOUh4aWxmNUtaU01rQWlL?=
 =?utf-8?B?dk40bTY3M3c0UGlYekNDV1VMYXAvVngyd0dLeTc3NW1pOEdYMTg5QTVJUjUy?=
 =?utf-8?B?ZWppSjl3ZWdpZERHbXF3cHNRWXJPNW94TEcwRU1GcW5vUzZwMUhTNzEwZkNx?=
 =?utf-8?B?Q0IzUjBVR0hHOE15RmpVVHNZYncydjd5MnNETHRPRUp3UnR4eGQyNmZXbng4?=
 =?utf-8?Q?e03dCEYZTWBOfEeWJvTJhAsRdkzRCz8z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlZjcEYzd3NDcC9XTytZQmhCMEhVUms5bzZSWWVUQm9ONGgzWXFmSjVoaWZa?=
 =?utf-8?B?MEFnUDY3ZXFUZDA2S1FqQ1BpY2Z2d2xCZ0Nyc1p0T1BIa0tYVG5UR1MrOTFX?=
 =?utf-8?B?U2MzUUV4bG80bDJEU2NmT01PU3p6Qktva3JrS1JScXlUWVEvTnozdlVMU3dT?=
 =?utf-8?B?RXBDMUFGM2lqOUdEenAza1RyNnZNaUtHZlJlQnE4SlRNbGlGb05aTlFOR3lv?=
 =?utf-8?B?aG12cmtOSXQxSVFjNVJ4ZzREL1VYRDY0VjhEZzlZd1QvbFFCdlpmc0JSOVc3?=
 =?utf-8?B?em9CRlphbndmNndWSHJsUGJmYXo0bUtleTU1NWgydWFkUEV4U3hFQjlZMlY0?=
 =?utf-8?B?ZXRRSHNoODAvTUp3T1ZEU1ovcStGemk1eHAzb3BndXhBcFo3NFBVYnh0d2FL?=
 =?utf-8?B?RHRtZ1AvekpGcjFhQlVXTE1CZUhScXY5RHZ0R2RONmRXRjQ4WlpKR2FyYWFW?=
 =?utf-8?B?T2dDYWhoWkNKYm5jVmd5b1k0dlVTNGU3cmZ1VGFjK252K2FRbzVENkxXL2ZT?=
 =?utf-8?B?eWFNbUdWQWRaOWJlc3Y5N1VCejFXd3p1VHM4eUd5cXZaZ0Y4OFYyLzhFRUZj?=
 =?utf-8?B?S0R5VVdySElVNnlhN0M3T3hLTENQOXBmd05wNjJhbUU3am4xRVZTUGprQU4w?=
 =?utf-8?B?TTZidGR6V3FsckJsSE5qZXFRdGxERkV6bzB5Kzd6Ylh3SFR3eER5djFrZU1z?=
 =?utf-8?B?SXJDNmxtY2pqRFNXK3hoaTZZT29oYTF4U3g4Vm0wclVPU0Q2VzYzNGZCRERJ?=
 =?utf-8?B?dzh3cmpVQ1o0WjJVd3RuZ1B4MFhXREtMeXE0Tkp4dXEySDV5TFhUVTdPeFlI?=
 =?utf-8?B?OTFjb3R5QU10eENaTkVpZWxWRWNacDNTL2hoZ2Q2MkJlMjdxZDc2WWNGUDFC?=
 =?utf-8?B?WWtOb1F2SXNobEVzZ25qbTVsZlU0YnNpdkN0M0FVMUE5cmo0aXp1VHN6VGtF?=
 =?utf-8?B?T1AvQnYwS2xKa1hkT0FNZG1VR3c5czh6NU1CZzh2NURWVllJL1FZTG95UURj?=
 =?utf-8?B?bDljc0dWY1NwZ2NscHpqcytnS2QvUGJjNnBqSWJqSXFNdHhCYUh0YVQzRnFF?=
 =?utf-8?B?eXdWZ09JT0E5ZnpzdU9rTmVjNkp3R0hzQThub1o4SkRKVG9xUlFkbC9Qd0VO?=
 =?utf-8?B?MW9IUU5ja09KMnhFOVNCM2dGU0kzOUtJWjdSYituaUpHM2luMUk3ZTduc3NG?=
 =?utf-8?B?K1lIYU11c2Q3dGV4WXhJWnk0cFVDZUxRZkhpNlUwTVptU0xvMEtDWTlmUWZS?=
 =?utf-8?B?cmM5YmV6eTc1VHBuUEIvcGdQMlBmeWY3WE52S0VPVXU3NjR0a2hycC9NaGFn?=
 =?utf-8?B?T3hGajMrSjUySUlVUnRTeWNoZlhkdG8wdFAwNFdTMnBlTzAyejQ5Wis3Y2hY?=
 =?utf-8?B?RWRvcDdMbzBPU2NqcmxtdjdvMXo2TkI4OHFXMGJRSk5ZeHpQcmFwMnorQTdt?=
 =?utf-8?B?ZlJpdDE4aWFVaVFOckJkL3pKVUoyS2dPeFloSzZpUXl5a1JGamdkRGdERzd1?=
 =?utf-8?B?d2JFdFhoT2VTOGhjUGRCQjBxc0c3Ykhxak1OTFlzMklSdGJMaVZ4aSswUURR?=
 =?utf-8?B?UE04QzM5NVQ5S0EvZ2drTU1TdHBib3R3TnlsZ0NKcUV3UHZjNm9UMDl0M3Rk?=
 =?utf-8?B?cjc0YTBGTWZlM1RwSHNZRU40dmtLMnRsSDZVRVJ2QWw5dDQ4dXQ4MmlsZFBo?=
 =?utf-8?B?K3JOc3lYdlFzWXcvVWprNDBYVnJza0VIUmw2YjBqRkx3a0p2bnR4TFhrT1RB?=
 =?utf-8?B?Wmp6L1ZMRVVpL1Z6SXZGVEtKalEvNjVoLzZralZKVXVwQ0t5Q2NLc01kc3gr?=
 =?utf-8?B?MEVLUFhFL0VwaTJEV0lqbDgrVFdPNUlYRDJlaFl6KzN6dEtlS2xkVldFakdp?=
 =?utf-8?B?dDFjUzNkT0YrWVUxSWJabnRJQXgyU2VRSkV3bDVndUcrWnJiRG9vMzNVaDVj?=
 =?utf-8?B?R3hld2NLck9EOXZyMHFvS01YQ0d4UHJDV016dU5ob0sxTGFueHZaeVJBWVMy?=
 =?utf-8?B?Ri8wV2tybVJGU2NJdUQ2UXkrOGVLSDFkVDJyQXV0RVFhSUNHRWRSaUZ5eGl0?=
 =?utf-8?B?VEFJUnM1aUp3Q0RRVXZPaG1Xanptc3d3U1hLV2dBQUFRZmo0UVRORnRTVVpw?=
 =?utf-8?B?MDBlVUZkYmdtblF2U0tZZFY0V1p6SVF1aC9XRDMzMmJEdmhCeVU2anZIVHVh?=
 =?utf-8?Q?IdLw1LTyK+glyWSHEDsa0+A=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37efae60-bf55-48b4-fbbb-08de20ae1825
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 23:08:43.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGptYHARJVwT6X4s0k66glr4HL+NIf7Z5QBler2f8pqk1RXKAX5JOSc9pJv/rEI5iSTXS6R+g3quDG0btQZIUFiK1pj4xvoZbCS4Lsdbl/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6293

Hi folks,

Gently ping...

It is not an urgent fix, either 6.18 or 6.19 is fine.

Thanks,
Yang


On 10/23/25 1:44 PM, Yang Shi wrote:
> The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing
> permissions for vmalloc_huge mappings") made permission update for
> partial range more robust. But the linear mapping permission update
> still assumes update the whole range by iterating from the first page
> all the way to the last page of the area.
>
> Make it more robust by updating the linear mapping permission from the
> page mapped by start address, and update the number of numpages.
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
> v2: * Dropped the fixes tag per Ryan and Dev
>      * Simplified the loop per Dev
>      * Collected R-bs
>
>   arch/arm64/mm/pageattr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 5135f2d66958..08ac96b9f846 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -148,7 +148,6 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	unsigned long size = PAGE_SIZE * numpages;
>   	unsigned long end = start + size;
>   	struct vm_struct *area;
> -	int i;
>   
>   	if (!PAGE_ALIGNED(addr)) {
>   		start &= PAGE_MASK;
> @@ -184,8 +183,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	 */
>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
> -		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +		unsigned long idx = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
> +		for (; numpages; idx++, numpages--) {
> +			__change_memory_common((u64)page_address(area->pages[idx]),
>   					       PAGE_SIZE, set_mask, clear_mask);
>   		}
>   	}


