Return-Path: <linux-kernel+bounces-876597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC3C1C009
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B16995C8DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D79D34EF0F;
	Wed, 29 Oct 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t72ryDcC"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022085.outbound.protection.outlook.com [40.107.193.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79F347FF5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753080; cv=fail; b=PQvA7Vb2Zcu8h0n7bsdnBbRjZ5MIeqCz1DZhS/kbpjtSQ5oAL0LzpwrV5PRAatZrRUipJdPuDil3SE6sncQpvbXtU3pmbcWWTJ6xSCNYZ8FKK/uSo4qL/wGz7lQLjRlhbWIQen6drJhhED6hYfbhIGM6JGo6dRa0l4WqnB8thaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753080; c=relaxed/simple;
	bh=o3whEthzxDgOuVCQWDrUDFWTkyc+X3VglE3P0rIqeYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bhdqVW0nkM4hwvNr4XT7J2zFoK6ECIELcM4HMBvYqGY0tIvJQPTuzC9d6PooJfnEBPJoUcEFquxjhq/PyDdTFvvQ+ftqqNBqs+I2+Hv6UrvVsUWaqjy7YvpkksMB7ZgpwMtoR3XYYBS8u9f1yZKbpT9vQ34f1Z7Et1Vxzf0EcPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t72ryDcC; arc=fail smtp.client-ip=40.107.193.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBDtHYTY1mO4jWeRirICokVuJSIQj9MNCfao4SH+luJeTOZKKBHyTzD8wcxwgA7Na0QlAGuFrS1+rKT09hI2fi+wmxrxNCnAIz3mBI5V1YY+XfNUMELWeGIckrOF0VTw5ar47zlNTjVfLxMcAnANTjgHCNhZKM49Ihcr/C3WZNG/V86TldJOBGzZELZbNyZstQrD5C5VJPnmVLU2jn9lOTj7pv+cWKHZ+zZauaN2kLrmfCAA7WoNriTpAsiGsWy8MXAJi3p/EE/zvEQl8oM2BFouGGg2HZAyF4l9QNTKtY5bQd83OBObukMp6U34hTytWJENk5h/qofHRWvFdbSQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frmQDXb9x2NCCWZD8LY04AoJAYV7dXKjSm44YhgzbDI=;
 b=Bkf8swFQeMtmI1TKGCYJc8bT5mr0q2GQkSuDilRVYKfSA0Or5Q9k6zTxyUMlGnxONy+ZG72ViVwFgtIjSSxzoP6aZcBSxvoyHN25j0PpbZZ5vGvz/FniQFbEimJljtulrlOtq+sv8JMXW855Ab2IK7gsQEiQcxniXahxpWWKfZG5ZsvjHeeLg+UymdKs4b3XcD91ZjR9HQVwYlVakdDogSs85YAGhZooLv4xTcNkJOdSCEjlMu+pSiP3dKLFaZYuO53wpprN9W9LlZS73OvLxDLIShN9SHDmYskE4bEDkYD4e7AuiwhuvFQx5+JPRySsarJ+qssSruUjFl5FEMie8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frmQDXb9x2NCCWZD8LY04AoJAYV7dXKjSm44YhgzbDI=;
 b=t72ryDcCgq655x7lGi0gj6jAa7idaDsWdbcpK8jMBkJDctvuB0VO+d5hUc71bohZ0gbqdAfO+hGf+VHHiWG+V4+wf1m5Gw2aXGQAdaEKeM8Vz6ZwA7b9FG75rIs50DwHN/PEaanUvUD85tgRP8pwk337ivZ0hHswtk2IsCMew5fQKE7AqJ2aGp41VN0vs1X08lmazninRXizPsNibBo0G0FYy4KLdnqHIstRICGkHCjWvQaQFVt1e76LjLvi/IFC8tHY/GKlvVz0vhw8FibDL11a8oEmc/5yj3hlqIXGrOBpOPOg7kZqC9R46XAtm3A21ZOmi+7a4RYwVuEXekD4NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5583.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 15:49:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:49:55 +0000
Message-ID: <86110d51-814d-4cbe-92e7-e77888f67047@efficios.com>
Date: Wed, 29 Oct 2025 11:49:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 07/20] cpumask: Introduce cpumask_weighted_or()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.717519165@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.717519165@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaca6ce-ea4f-4145-339c-08de1702ce18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OHF3a2VLaFdIR1BJYTVjQzVrcHcrVUVXQVF3OFRTcjN0S2s4ZmIxRUFHZ1Jq?=
 =?utf-8?B?SFNxbEhMV1A3cElQOHVibUs0M2s5ajNqbktVMlM2K0NZNFMzY3k0OWsvZFhH?=
 =?utf-8?B?VlorbERRNmdHN21QZzNVK2ZNc1BPT1F6UHNwc1FWMGE4OW9DWkZyVm1DbUov?=
 =?utf-8?B?UUVMdVpPbVJrMW9EQjB3UnRZSzBNYXJYVHdaVFViNmJWR3J1ZVpDcm00RndM?=
 =?utf-8?B?QkNwbE1PeENHdmExRjBQcDFZaHpLMkJWZURuajJMalJHdVluNFgxMXRlZ29V?=
 =?utf-8?B?Y2ZRbFhZbnNjbFFnQXVDbkUyNkJ2cHYzdEVHcmd4dGt1ZnRmUFZaV0xLTDRC?=
 =?utf-8?B?VXRab0NZTW50bE5LaTVyREdmWnZCZmgyWGk0MEh6NDg1aHBGR0VyVFhXcFlB?=
 =?utf-8?B?dEhtaWZkbEhOTXdtQUpYVE1maDlrK1FER0s1dTkxUFlGNWk1UXAxY2RMSGt3?=
 =?utf-8?B?YXR5bWJaWXRJVm9nWWw3cFJwaXA3N3J4enl2dDNlVEwvbDgrT05uYmVQRE92?=
 =?utf-8?B?cXZXV0RBdE9IdGFBVnh5SXVhV3RSR0NhV1o0RXJraU83cnZhZW1mS1JCQ21D?=
 =?utf-8?B?SnFrVDBnaXUrTXVQamliaTkxeEhwVXl1UzJGU0xUNk9XbC81UlpBeEc2RUJs?=
 =?utf-8?B?czEvK1p6cU1GT1Q3eVRnd1Exd0dkSk1qNnlXdENCZmtFTjk1aEdzdklYcEZJ?=
 =?utf-8?B?RGdSRG9WaGhNU1hvSlk3c0VGbTVvWlZEYVhoeFl5ZTVENUQrektBWFArQ3ZX?=
 =?utf-8?B?S0pWZTVzeUd4U3NxaEYzbmFOa3k5SWUrYzk5RmhPcjF0aVlWWjM3RjRsdGs1?=
 =?utf-8?B?alJYY0dUWDk3UXlyU0VFdHFzVUZTVDdqbXZLT3o2OE1qZ2VBMTR0cTJGZHJG?=
 =?utf-8?B?c1dOeUpiTys3RklaUjNpb0JHMEc4Rmp1R3JCTVNzVUo0SkFBL2JoT0dlMC9E?=
 =?utf-8?B?aEU4c3JiTnlzekdaUlNoeUxnNWc3a25XVFQ2TjIzOWVFbDdDVjhvdWJlSGtV?=
 =?utf-8?B?NEVWemdaS1k1UDdEdkNsR2d3NU5ubVM0QjJvYkhZSmFvZ2tHTTFEdFJ0MGpY?=
 =?utf-8?B?Rmg4STZZR1YyeWlNWG0yRVdHcER3NWsxb1ZsK3RIOXhmZHFnaDRFWG9IV2F3?=
 =?utf-8?B?Vm5ObkhKWk04TnNxcXh3dGdZL0NqeW9ibU82S1d3WlhkZUdjOVhraEJvTW9H?=
 =?utf-8?B?K3o0S3hrenVMU29mdTdqL3Uvd0FycHRJamk1Rms3ME9EYjFEdjR2NTFmUit1?=
 =?utf-8?B?UnJHLzJoc3RrbW1WVW82YUVaM0ljOTJMZXpIRjNlZFFXUi9YZE10eGFuUmxO?=
 =?utf-8?B?S1ZaWUJMcVdTWlh1QVZqeEdJaTcyYUxrYkpIam0rNEQ1SWZqeHNadTRhRVJq?=
 =?utf-8?B?Tm44bEtNNTk5ZVhjbE5KRG12S3p5eWMyWWN4SUlMdHJpYzJZTXp4WTRpbytn?=
 =?utf-8?B?blJKT0VTUDZHVVduWVovbDJMMDFUbWM0aVhRellnZlcvNmgvaVpyeXJjZW45?=
 =?utf-8?B?OFBxUHo3WTFZZm1nM25nYjVLUjVVUzRDQ1hWOU9mNFNlL21aQWwzRjFsOEU2?=
 =?utf-8?B?eXdwcUQrb1dBZHdGd2p5U2RyUEZvaXR6VHNYcGhqRmlUdzhRYTlHOGc2OWIx?=
 =?utf-8?B?YTBobEJDRU9BK2dPMWRWVEdRSDlaZDFLMHYwT3pyUEZBSm52T0w0UEJERlVn?=
 =?utf-8?B?ZWZucmswTUVjaWR1alRxVURxaUhqUS9VZ2JiRXpnSFdTMlEyVFFTZm1OM3F1?=
 =?utf-8?B?Y1ZrOGRRVTYxMExuRzVaa2pMci8xemEwc1A1NHc2cGpEbWJsMzVEUHcwemRh?=
 =?utf-8?B?NHhrdHUxRDllRkl0Y1lNWU9CVHF1UERFKzh1UXpSTlQ1Y3dKcm9hODhLR3A1?=
 =?utf-8?B?TU1qQUErYStoYjZaSjJ6eFExbW5MQVB2N3ZHVlkxbnNsenc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RGVJLzZkRlFOVUNRZjZ5YWhBbDRkZjVvRlR1OEhBVE16RW5NT21KdTVxRER2?=
 =?utf-8?B?RTAvQTh6QWFvVnRwbTVoVTF0KzVlRE9kcFYvQ2RsQTRQYlA2R1d0ZVM3Szlk?=
 =?utf-8?B?NGtLUmd6MEd2MG1DQW9wWG9NMDNnS1F6ZFUzdmxKMDRsNHorUFBwOVgwTnkv?=
 =?utf-8?B?ZHdkaitjaXBka1Z6ZUFSYmRITUQ4dCtUSSs2YlZmazROYU9zekJmNUZ6WURm?=
 =?utf-8?B?MGZBZHlPMGo2KzZ4bFlubG0xajNhR0kxUlFrRzh3S1VFSWNOTGxGaS93dW13?=
 =?utf-8?B?ZWM5TG5yc0I1VzhVd2VMSjdUdUlXUHhZekJWZkNXNlNZTXAzNHZ6YWdYK1lM?=
 =?utf-8?B?cTgrRVNGKytOeldGQnBHd2lwSDc0R3orYzYvc0FkdG13SEZBYWgyNmVKQ0E0?=
 =?utf-8?B?eTFtNjNvTFpQUVR5N1J3Ymg0Q005ZTFKVUd5TElyM0NtYjUrbGpxRVJrdEph?=
 =?utf-8?B?d2xKa3NsVFNrSzl0N0IzanFCamY1eFY5WEpHVjVCNVJOc3NLT1dDS2d3OGRZ?=
 =?utf-8?B?MnFTVG9WMGZHMXlHRVNWSHlOdXlwTWJpbTBzTGdSdGRUVkJrbTM4bUN6ZTdu?=
 =?utf-8?B?cTd6ZCtWY2JvSmdDdVBDNDJsdll3c1BUQ0pXQ1c2alhkSHFaTTljd1V1QXhU?=
 =?utf-8?B?L0ZhU2pUTHZMVWhBaVlMLzI1b3NSdW1ydnJ6cjN3MFkrVHVPWm1jYTBYbEhK?=
 =?utf-8?B?TUVpT0g1SmdNelB6UlJxeTdOekVmUzNlMy9SQU9tcFFLRnh5cC9jTTFPdkFp?=
 =?utf-8?B?UW1XWGJRUnBGVTF6aktxeHRhZWd0d3JpRTJyQXJJR0lMc0lkZVUraFhHb0k5?=
 =?utf-8?B?MmYrSW5HeWZiVFk5S2Y5eWhJUVl1NWNwWStadENLbEJ5VHhzSkl6MlRWWFE4?=
 =?utf-8?B?YktCbW0weTRIN2k2NTRabFZjdVEybzRUcGxicWZSaE5DdzlkRGpXZms2dWhj?=
 =?utf-8?B?ZW5iNTBZWjcwbVlCRDJUSVl6ZlJmS1pRRElDZlFnOFpQWE04aUNtMmhnQVQr?=
 =?utf-8?B?L21td1BOMy9TL2hVQk92MEdiSFdjWVpiUkVhM2RPaDBGY2FpbWNDdWdyUTht?=
 =?utf-8?B?WDRFdU55NEtSNXlTQlh6REhBeDdSeFQ5TVdkN0RyNjk3MVg3YW9nNmhHb1kz?=
 =?utf-8?B?SEd4TVFteTdTVnZhRXF6cG1wMVNvbStjdTk0NjFXNUxEWTJad1lXaVU0K3NH?=
 =?utf-8?B?SnpVY041OEJHRHdJTXg5UmJkU2dXMy9FcFo5WVEvc0VDVjJocUJZY1ZVZGUv?=
 =?utf-8?B?cmZRMm9PcVdUZ0N6RUhQZjhJT1pIN0dpVTJ5TTlxMDBhaHhmOTJSb3BFekxU?=
 =?utf-8?B?VXp0b3h1eFB4ODhhc1VyRkRHM1A1LzhmL2VYM21yUjNBSTlWdytPOGVtS0pz?=
 =?utf-8?B?VFlDQXpLY1JFOWxoZVh4VjVoOGVmalhGTXk0WmJPZ0hsN0gvUllJekt3WU5j?=
 =?utf-8?B?L29nVFRHejhIKzZFa1Q1ZFp0M004VzR6aTZuVTJTSFlubXdBMExkREdSekpX?=
 =?utf-8?B?TUpLV0pBM2ZIdUJkUlRjVk1aUmpkS1hIcnppd1pJMEhvSEhXOEZ4a1pId0ls?=
 =?utf-8?B?eGJUaW1yOVh0VG1kZjVZbzFtTUlnVlF5TzlrZU9BRno1dWFmanFLQ2tJbmZp?=
 =?utf-8?B?dnNmei9LbFhwZlJGNlQxL3RJcnNoejZkV2hMaWsyVHBIcTBuR0x2Wk5ndEJ2?=
 =?utf-8?B?aHoza1ZJa2VQZTkrK0Z4K0dST1B6WWVaeGFiZmozeTUrZ1RCeVNFbi9rZ1g5?=
 =?utf-8?B?K1pGUVB3NHB6VmhvMTJTUHdqQ1plbzgyUzB3dDc3cVVjaXF5VTFUTXlhWml6?=
 =?utf-8?B?KzdteXdmNXhzTHZKU0JtbnBNK1p0ZzRoZ0dJdHhoYjFuOUM4THloVVYvYlFE?=
 =?utf-8?B?a2ZSdEhNbm12am9YaUxscjVzTVdKd1hZd1JkdzBPQm56OENUS2NtNytkMnR0?=
 =?utf-8?B?WTUrMGlpUlhUcDhYbWdVTXdwNGZUZWdsZ0RQK3AxcTJMUDBMbXNJZWx4dWwx?=
 =?utf-8?B?dVlBUVg4RGVIVVkwd1NSNmxpUnhZYUJPTXk2YWU1Sk9lWFpMNWVkYkpvNjRS?=
 =?utf-8?B?OUhCVEUzdnhFZmVlQVRIYUU5dXJ6UnA4WmxsZnphVHNqUXFOU045QU9FSUZG?=
 =?utf-8?B?OW9WbExYMGlqTWY3STBHVFdSd1dseFNQT05TTkFWZHdmTlJUWGZuUng4QlJw?=
 =?utf-8?Q?QcgjVDTmBr1PfFyez7cxTTY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaca6ce-ea4f-4145-339c-08de1702ce18
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:49:55.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib5mjeZH8jXdEnYTCzNv4wQ1c9EHyqmUEB4gqBPrgZl2BX7L0CsjBCZkilrzUf0OWBVhWDH9A6NKrUfOiQSwSxY6Fjq2dCjhrIcPZhxRPjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5583

On 2025-10-29 09:09, Thomas Gleixner wrote:
[...]
> Provide cpumask_weighted_or() and the corresponding bitmap functions which
> return the weight of the OR result right away.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

