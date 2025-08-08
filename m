Return-Path: <linux-kernel+bounces-759932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E4B1E49A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6125F18C4128
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627FD2641F9;
	Fri,  8 Aug 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r8l6uuyO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r8l6uuyO"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCA1990C7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642693; cv=fail; b=RwdnDAdaDk0GpMdp7rp73UBBw4CAAoucFqBozRkvRmHFfaWUmWHRqhN2rjPGywyfhOMXBpWdXGueaYu6iFAE7kXX6mknRkTR5ohN4cuOXQvdHl+ENGvLNP+X4fnJt5eoO1+l+L/gc4m/F2tPHVjsRSNQwoMz4eaAxGehM14tbq0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642693; c=relaxed/simple;
	bh=aQW+xPswOfGXnLMgk5uoOuirh0cbhKV9EyYjwTXNeBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OVYYLcIu94sGuN45MU55ACt6bV9AVgsUhiRJvZRhY9GkiPNKt2WWIyEGQqpnuC05PyGtiRD8cdaOJ3Q0gzTFOTxHzQL239vC0/w1gZ913v8NWfmFBA9UjXAz1ouqQ0YbbcN3YcTzMCJBJHpxCdTWJ4nz508IQsqiLxgGXUsUbhU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r8l6uuyO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r8l6uuyO; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gfSYreD4VkojAwNP9XGvCrd94VgCd1haz1yxvsJ7BIJmls9sifMAPqUopMVqCERmiZz/nv9gYg1BboXYNm/utpPmVv4wcxgzP5Q7FHXEv2n8wYJ4iJCtYeHOxf0OlRFJkUSSR7PmQYv50wHmGXrc0/mD7KgCdIAylN4j/J375jv5GLGpcGgZhhS2zKuRkpabsMiJsVbGZVYVmbaqGzZp5Qwg826KUPK1hdocBa8lcRharQyOS3hOFuAGpdccHWo+zSGl33xYfIQj6w6ImOkS2Qa7i/6O9Z6VIXo6/4b5DXpaDilnQHkSQ/wChXBEFpbizSmNt3ZS6y4hYr3CesjukA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuwqhncL38IxlkEHC3kClQ4MBn1b3V5pl++lOzPSGlA=;
 b=fEWVFn+1L1x4EyMBYAIE2wqUdJgUb+oP1KU9IAXoQ/oW6fn1m5J5C/MVJi1DFVQ4ngZw2h3ZFubwYMps0sFQzMl9mZWA4drhLcv9RgRPV7NiEhvhfl924I6l7E7Eo0pFcTl5UBFZcdX3W07D2EBlk8jXLs5BjHhNaRnVmrSF5+iBqq7ZZ0k4wyLywARgJBmd55WrFAGFjoziRTOsoNBqx0FwNFSsGbAR/xF56qPJUIzF6EHxfkRKaHBtg9UdL4qW63if60EZhy6faQSeadZtSrqbVt3svzuYcON6P55EOz62m76HJGLCrMprn06+GVvJCzKOAfMerSl11G3uFBVZGw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuwqhncL38IxlkEHC3kClQ4MBn1b3V5pl++lOzPSGlA=;
 b=r8l6uuyOx5J214j4a3/aU69uAmXxpUacjTLg6xeRKvzluuj2cBpKqSzGeCD/7VaBYTCP7y0hXZFZ5nPEMrUl2gett4qIZwePBbHe615Do9nd/Es4DedCM5gGiH28sc0S1zr+GUvQM8HpeAF+xNCR65C1La5g4IVHKHh3O+XMpYY=
Received: from AM0PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:208:3e::32)
 by FRZPR08MB11071.eurprd08.prod.outlook.com (2603:10a6:d10:13c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 08:44:47 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:208:3e:cafe::73) by AM0PR02CA0019.outlook.office365.com
 (2603:10a6:208:3e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 08:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 8 Aug 2025 08:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6qEttvCxaSjtY/Djx9eNM1y9rppNHqqMWrbMUBDcm7DZqZxmKanbabYxTxctYNkPHWQGRS1yk41i1D2VBo8aC1Fr2/3VYIUsPNkmKuLpSNf8lrJlZcbsHeMeWZYKwKP9rTtfjnVhfWTjgYE8wLswhtkcS4XVOsxxE9jOUsgw+T94YbXfBJjMFLcRnZ7JChjnboqwtLO98K0dsUMv6Gd8Q4RO6IQoqSiiXQKnqE/86ZP0Xde1tRDS8rIhz2pXbdhLQlIcv6d4PfCbopQVA+O+F+xsMwCnlfrO3grkE+/qmGHGg3DZ3jcPa/sf4fOEvct4aqayoPTN1iV/+2VzPS9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuwqhncL38IxlkEHC3kClQ4MBn1b3V5pl++lOzPSGlA=;
 b=RlTa43LoFbqDJIU8tKHHNE9pbxMzQgR5EdEx/I/VD7FwMVc2ksROn5OPvoNg+F7f2RGdH6P9L4qdTKZ4imAQ3PjBddB/OpmzusA/l9TaXvK69jgsRT4idowljlesBJYwqwQFQd3qfPZ4lRHuhf5IBsn+kM67PUUWoK5Yul8dl9UkTs+DqWBFKM/V4CAR+rXXoRfKq77QhFwzHvNOFFNpX88fa/WH5SpHTnWe0dZCEqvN3J3LOvUO0W/7L/uPxxdWlbYT+eKqnvrwBwosQ2Fq38HpNix/aPSl2Y5YGHQkGIoRD2o/hhQ09kk0f4LL6Vk08ZYqIwGTEvNRPwNvn8o5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuwqhncL38IxlkEHC3kClQ4MBn1b3V5pl++lOzPSGlA=;
 b=r8l6uuyOx5J214j4a3/aU69uAmXxpUacjTLg6xeRKvzluuj2cBpKqSzGeCD/7VaBYTCP7y0hXZFZ5nPEMrUl2gett4qIZwePBbHe615Do9nd/Es4DedCM5gGiH28sc0S1zr+GUvQM8HpeAF+xNCR65C1La5g4IVHKHh3O+XMpYY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB8430.eurprd08.prod.outlook.com (2603:10a6:20b:559::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 08:44:14 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:44:14 +0000
Message-ID: <20cc4429-58a2-43f9-87e5-959980d7ba5e@arm.com>
Date: Fri, 8 Aug 2025 14:14:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
 <6870e24f-dda6-421c-8df8-58294927b62d@arm.com>
 <ae01c6bc-019a-4263-8083-8ab073e72729@lucifer.local>
 <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
 <b0d257a4-a37d-41da-92f9-4d1c0a11c30c@redhat.com>
 <8391c672-1123-4499-8d28-a731f2d88a9e@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8391c672-1123-4499-8d28-a731f2d88a9e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB8430:EE_|AM4PEPF00027A60:EE_|FRZPR08MB11071:EE_
X-MS-Office365-Filtering-Correlation-Id: b5386c9a-732b-4bf6-4a61-08ddd657d480
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S0V4ZDZHbzdTUEgwVmE0Wjd0NTNsN2dKcjVJaFJ2TUIrbk55QktvT1VlbXBN?=
 =?utf-8?B?V0NOdEU4c0g5YTFvZ3JXUjVudFhJaVZkdzVCS0dqNk5EZVBvTDFFeUpJM2Uw?=
 =?utf-8?B?SGMwZkIzM0lGcUFEK1R5OW9aRXVqaVRUMWt5a2RwNlBHQ2xrU2dCVHY0bzRV?=
 =?utf-8?B?aENlMVRxOVk0RDM3SHord3ptdDlDU1JJdmVqa0tjbTNzTE13SVY5b21CbytV?=
 =?utf-8?B?enYxK0t1dHUyVHp4dXAwaXlpcXZPalE1cWNXYlUyZHgwSnpqeVZ6Yk91MExN?=
 =?utf-8?B?SzRPMWFTNGVoUU81VUNIR0ttdk80ZzJYcWpYbUhNaGxTV09Jc0xlZDRYZDJC?=
 =?utf-8?B?VWtFRHJwSHo3eWdTZG9qQis1SnBBMUlENEhwWllSL0REcW5HOFpoUXdvTnpQ?=
 =?utf-8?B?WmNxWThiVmhVdjg5N1QybTQ0bnQ4TlJtRWhuQzJKaGVDSFF4clNEa3lwZ3pH?=
 =?utf-8?B?TFVjZjhva3p1WElrdW1xTEVBWExTbWd3WXJMVElVUFlkc0ZCcVZibHkrT3VG?=
 =?utf-8?B?VjBjaE80NmNJZkxEdDRNY2VaY0Y3U01iT3RDYVBzRVE1OGo0RUJqZVJSRkQ0?=
 =?utf-8?B?aEpWRVNUT3BXYTROK3NwL294UVFTTGZoOHpLb1U2KzJQdlQ2b2lKbjNwL1RF?=
 =?utf-8?B?V2ZRMEtMdGphcVJ2T1Q2UjBEU1NiaEZhWE9RVnNxNVJhc2FKUDFmMCtFU0ZH?=
 =?utf-8?B?eVJGRFdaSDdJdEFCajZUdzRyTUdTY2dVT2Q4ME1hV3lNazU3Tk5tdnRza0xt?=
 =?utf-8?B?L0JmaDBPZFdzYzgrWlNISFBGbW1sWHl4R0V4T2xiWTRmSVg1UGxvV0UxNEUr?=
 =?utf-8?B?Wjc3d0tQQTBGeEZSMGlTV1hIcmhxMFJmSVg4NUxHVCtWYyt2M0RpU3ZHaGhk?=
 =?utf-8?B?dWh1ZDFHaGhCWW8zSkRONWcwQUFZbHoxWXhRZWoxb3BjY2VubzM1aFNYZytz?=
 =?utf-8?B?VzgxQVNXU1JIMXY1WnkzZ0ZOU25Zd3pGUGYyS0ZpN2tjQVJpOFNWNWZWL2p2?=
 =?utf-8?B?UURhQnY2b3AxM1E2bjB6cTRxaVJVdTNMdUxQNDB2ZXRPbk5kbS9oOVVucEo1?=
 =?utf-8?B?RkY2NmxucDJqM2hXWDZFU0VrWmVkODk2OEtIdWM2WTdQajB1dW9nU282bEty?=
 =?utf-8?B?bXdJQlE2SU9SMDRlbDBpOGZJU1EyTFdvRUdQVzFrVFc0MDMxZHVxTlpMR2V4?=
 =?utf-8?B?MTFNMi9UNmpsdkFvUzdUMkVMZ3JvTTc0dnE0ZnlmYnloc1IxMWZwRWl5dGNJ?=
 =?utf-8?B?MGJXZzdwWCtYbzVlVkIvMFZVc0p0UjE2NVEvTmhCZ2pqMkFmaEtOVncyNEV5?=
 =?utf-8?B?QitCc3JFVVY1Y0FQTFhxblcram5LTUQzaGVMTHVKN3pmcnNyY2dzZXZHb3ow?=
 =?utf-8?B?OWNrNmliOGNOZFlVTHByZTJLbyt0Q3hsTWlpYW8rY1lLR1R5eWlVcisrcXJ0?=
 =?utf-8?B?dVFPL3VGK0RnM2ZONWp0U1Y3YVh3dTUyYUhFSzJpVC9jSVhXN2NNQkNiSlhC?=
 =?utf-8?B?SXdFcEszUmsxM3VBbFN1Yjl3TVRaY2VHWncwZWJpZk4zT0hTNkdQZHk1RFdk?=
 =?utf-8?B?YmNjd3lxNVhIK0VWcDJudVZGU1htanVmY0NMU2l2OG9zUE5pVmJ3YnhkSUtK?=
 =?utf-8?B?NFlMKzNLa2FmdnZBSnp5MmJqTVF1WXRoK3l4RVAzVkZ4WnJVbXAvb0p6RlNi?=
 =?utf-8?B?VEJhZERwN2lFcEwxVGNYbDM5YUVaZm94K09IVFZlcVVKemVQd3c5Rk5GcEpk?=
 =?utf-8?B?VXFBeVdmMkFTS0tHSkZRZDZTLzNXS2hvRk0vNEZFbVBLRVZyQm14UkxGM2x5?=
 =?utf-8?B?d1krMlBaZmdWcktZUkxzemQ0K01mbExvbmdrQnZkQVRuTG11TGRQTE1zTDU2?=
 =?utf-8?B?YllMdG1sczNoYkJyK094cytWLys4U0wyYzVSWHN0NHFHdnc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8430
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cdb77d05-253b-40bf-9148-08ddd657c086
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|35042699022|7416014|14060799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFdlSkl1Y3ZwaldtZ3ArVTNnUlhBRzFZMTlPNGZsaE5JUDRqcUNXM2krZ1Ra?=
 =?utf-8?B?WmhrMDhrSHNBZ1RPTXV4d1BUZnhmUmplSjBVTDNMZExkdFk5d2pzbUkzem5y?=
 =?utf-8?B?ZVExMFlPTDZPSDJkbTgyMVUxZExrb1k4MFVQWlYyM2RuV2pxeU0wSnVPRktT?=
 =?utf-8?B?cWlCR3pGdkhMeUtVOXVjdkFqYWRNd3dLV05TWk13aUsyRHhsNFVVbTJibk02?=
 =?utf-8?B?UThTUlVHTUtkZEpjSFY0dEI1TGxZQzlMRmRobWZGQzJWTm83SFJlRXY3VlNz?=
 =?utf-8?B?SVZNS3RyVnZFOGpKOHkwNGMwMlhtT3pXQTBQR2x5dWZIOTBsaHdEdkQ0Y3Aw?=
 =?utf-8?B?YnMxbHUvUGJzR05jeXNTQlA5ZVg5TjFLWUc2OUpvMmJpYW5OaVFZQ2NiVlFF?=
 =?utf-8?B?V0hKa3ZIc0JGKzh0TDcxY29vLzhXaUxFTEs5bnZQVGtoY0JYUFB5TTNyMkFO?=
 =?utf-8?B?cFlJU1JLcG1BTEkxRUhGQWIyVnB3ZWVubTZqZXppWWl1dWV3QUl5YW9HTEpP?=
 =?utf-8?B?bnNNQlRQbTRUYWtwcUlqblZWb0ZlcmRBOXNOdUQ1S3RnZWpOZndrSEVhckUr?=
 =?utf-8?B?aUpvNUNoU3gvMXdVNG16cFEzb1N3THNGSGhzM1BzZkZmeDg4ei9SRWh4YzJZ?=
 =?utf-8?B?ZG9KN2hEcFIvS1pJSVl5RXJFQ2xEb1VtS3AwanNSZllZcjBTZXFHY3d0ank2?=
 =?utf-8?B?VmUyY3RxYVpsbkt1eHRZMmVNZjB3MjM3YzhzRExrckwxSWxtTDdCb1VJUmho?=
 =?utf-8?B?dzQyY1BKeU5aM1hjUXJlWGZRd0hJc0hFT0RSYUtaYTNCcGZrVlhoelh6SnRY?=
 =?utf-8?B?dDg1Q2N1VFRFRTFLdkNoZGRrVVNxczQ3c1l0d0h6K3pSZUV1SWE5SVZ5cWls?=
 =?utf-8?B?Z04yRVpQZjU4WFQ0WjZqRUJ5U2tZVGJHZFRRTnB6Z1NoakNtTGc5eUpjdkRP?=
 =?utf-8?B?SDEwcHQ2VXJLUTV2V3VNZlR3cVQzbVBIa2Rrek1Hdmk5ZXlPZ0NPVytNS0JM?=
 =?utf-8?B?TFEwYldIOVZ0Q0oxTWdoK1lvOUtNdGk5SlhWM1BweHA0M1NVVDBxSTN4N21N?=
 =?utf-8?B?ZHVBT2pNQlRoQTY1QzcyZVZzNVI2aytkQWw5MTZyeWFpaDl6ZFhQdUNVR2E1?=
 =?utf-8?B?Zm1jbmRRWDFSM2pIaVBUK1dESnNDOW1jKy95NjJ2VVEvR0g3bTVJaEx0a3B4?=
 =?utf-8?B?WnBpc1RaSE9rdkZOdEJsdy9pTGRaS0k3VkZVSVdpS0VvKzhrUTNFWGJsN2pJ?=
 =?utf-8?B?ekgrVExRWjZZRE5RZXMyMHdPV1NQdGNUUVNsU0FCSVFYeUhNMFVLVm9pSVFF?=
 =?utf-8?B?YnppU2Z2RUtzNGZKYzRTYUdRMUxPaEFldlhubm9HUFBRNC9BYVZXd2E4M2tT?=
 =?utf-8?B?RFV2bHNrUFh5bER5WGN3ell3NVk0aUFtajR1YkhGMmZVa0V1Y211bG8wc1VD?=
 =?utf-8?B?bnQzVHJVdU5GcmpyUGxHS0YrQVE2OEFOUEpDWHYyU3padUFLcjg5dm5RcWNG?=
 =?utf-8?B?VEFaaHJ2L2JON3JqeWdna1FJOWVEY3dzYzBLa3F2WStHcWo4REo5K09SU01t?=
 =?utf-8?B?dGZ3YURGQWg3cEExZHZsSHVQTGtLSkJWbFI2NFJFMTJNZW91SVNUbkp0a0NQ?=
 =?utf-8?B?dWQyelB6WVFkeElSSDgvZkNCTTRraWNpT014eGs0SVJjVlBqOXNIR2FZYndX?=
 =?utf-8?B?anJEZjQ3K0ZrWmlWNHlkN1VEaU5Ed2pteHNETUgreExaUG5MZ2hKNWZQeFZm?=
 =?utf-8?B?NzZDOFU2Q1htby9wQnNncWdYOEhyeTJMN0RZckpIeUdjVk43OUlUUGtMVjR3?=
 =?utf-8?B?NldqQjFJV1R3KzVXZkJiOWlURWNwWDk5aG1DZURIZ1h3aUdsN2xGWi9zSDBS?=
 =?utf-8?B?RnUxcmZoUnZ1ZjF3S2lYVTBQZDhHb2MySmxxOHZkWnNnMThFcjhEMTVGUkxR?=
 =?utf-8?B?cmR2Ung5NDVPVHlKTmpYSzVtdEFudmdvbFZxNDFEM2Y3akwwRUk3MU4yUncy?=
 =?utf-8?B?T29MYVlXRjhXenRiQTBNZjQ1TWtXVkhsZTBGdkJhaytBQ0ZQbEpGaXBiVDFC?=
 =?utf-8?Q?lbrDZC?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(35042699022)(7416014)(14060799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:44:47.1106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5386c9a-732b-4bf6-4a61-08ddd657d480
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11071


On 08/08/25 1:26 pm, Ryan Roberts wrote:
> On 08/08/2025 08:45, David Hildenbrand wrote:
>>> Not sure if some sleep has changed your mind on what "hint" means? I'm pretty
>>> sure David named this function, but for me the name makes sense. The arch is
>>> saying "I know that the pte batch is at least N ptes. It's up to you if you use
>>> that information. I'll still work correctly if you ignore it".
>> The last one is the important bit I think.
>>
>>> For me, your interpretation of 'the most number of PTEs that _might_ coalesce'
>>> would be a guess, not a hint.
>> I'm not a native speaker, so I'll let both of you figure that out. To me it
>> makes sense as well ... but well, I was involved when creating that function. :)
>>
>>>> I understand the con PTE bit is a 'hint' but as I recall you saying at
>>>> LSF/MM 'modern CPUs take the hint'. Which presumably is where this comes
>>>> from, but that's kinda deceptive.
>>>>
>>>> Anyway the reason I was emphatic here is on the basis that I believe I had
>>>> this explained to met his way, which obviously I or whoever it was (don't
>>>> recall) must have misunderstood. Or perhaps I hallucinated it... :)
>>> FWIW, this is the documentation for the function:
>>>
>>> /**
>>>    * pte_batch_hint - Number of pages that can be added to batch without scanning.
>>>    * @ptep: Page table pointer for the entry.
>>>    * @pte: Page table entry.
>>>    *
>>>    * Some architectures know that a set of contiguous ptes all map the same
>>>    * contiguous memory with the same permissions. In this case, it can provide a
>>>    * hint to aid pte batching without the core code needing to scan every pte.
>>>    *
>>>    * An architecture implementation may ignore the PTE accessed state. Further,
>>>    * the dirty state must apply atomically to all the PTEs described by the hint.
>>>    *
>>>    * May be overridden by the architecture, else pte_batch_hint is always 1.
>>>    */
>> It's actually ... surprisingly good after reading it again after at least a year.
>>
>>>> I see that folio_pte_batch() can get _more_, is this on the basis of there
>>>> being adjacent, physically contiguous contPTE entries that can also be
>>>> batched up?
>> [...]
>>
>>>>>>>
>>>>>>> Not sure if that was discussed at some point before we went into the
>>>>>>> direction of using folios. But there really doesn't seem to be anything
>>>>>>> gained for other architectures here (as raised by Jann).
>>>>>> Yup... I wonder about the other instances of this... ruh roh.
>>>>> IIRC prior to Dev's mprotect and mremap optimizations, I believe all sites
>>>>> already needed the folio. I haven't actually looked at how mprotect ended up,
>>>>> but maybe worth checking to see if it should protect with pte_batch_hint() too.
>>>> mprotect didn't? I mean let's check.
>>> I think for mprotect, the folio was only previously needed for the numa case. I
>>> have a vague memory that either Dev of I proposed wrapping folio_pte_batch() to
>>> only get the folio and call it if the next PTE had an adjacent PFN (or something
>>> like that). But it was deemed to complex. I might be misremembering... could
>>> have been an internal conversation. I'll chat with Dev about it and revisit.
>>>
>> I am probably to blame here, because I think I rejected early to have arm64-only
>> optimization, assuming other arch could benefit here as well with batching. But
>> as it seems, batching in mremap() code really only serves the cont-pte managing
>> code, and the folio_pte_batch() is really entirely unnecessary.
>>
>> In case of mprotect(), I think really only (a) NUMA and (b) anon-folio write-
>> upgrade required the folio. So it's a bit more tricky than mremap() here
>> where ... the folio is entirely irrelevant.
>>
>> One could detect the "anon write-upgrade possible" case early as well, and only
>> lookup the folio in that case, otherwise use the straight pte hint.
>>
>> So I think there is some room for further improvement.
> ACK; Dev, perhaps you can take another look at this and work up a patch to more
> agressively avoid vm_normal_folio() for mprotect?

Yup I'll investigate this in a few weeks time perhaps - try to use pte_batch_hint(),
and when we have to unconditionally retrieve the folio, then use that instead.

I'll also look into whether even for arm64, there is any use in retrieving
the folio at all - the only benefit we get is to batch across contig blocks, but I don't
think there are any atomic operations (refcount/mapcount manipulation) which will be saved.
By batching across a single contig block we save on ptep_get calls and TLBIs, which was
our objective.

>
> Thanks,
> Ryan
>
>

