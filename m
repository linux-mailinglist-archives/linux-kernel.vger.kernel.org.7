Return-Path: <linux-kernel+bounces-856337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B2BE3E78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6981506D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BD33EB0B;
	Thu, 16 Oct 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N400lGJy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N400lGJy"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FD33EAFD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624857; cv=fail; b=Ev3WoDzl/MiyKax5dsib2q8kat+LPZ/6fWS7SszZEeU7J0fZpQXUmcQTBC06r1QpXL+3flLW/XPfv76aiGVa02QqKnilqHP47LJKi7aG5jXGUP4MFPvImKUhbLD4BwB9iyZyPc69gQkoSqrTf7KC8rfUx023aUfWNmlBZhipaT8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624857; c=relaxed/simple;
	bh=jgW3kPCO4h9rKJVcI75aojI3rnIuuOlMCpIF7SWEnjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AX8ptMnYk4g66NWcGD5iC15u3D8eNkNefYHn319eg9G9OsThgZST6DXKc0eJKyd/iK1pUWc4upd65oVRRhSRZ9lN5EWrjQb6eEgD0Z77gX8qGlsnLLW1ga7RLSF1K0G6Ma3US7dTCfWiGroZGpiaGDn0eNgp+HmJMBxVCPxLQ44=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N400lGJy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N400lGJy; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XZOsPdg4WEpwO5NHyBfI8zkvsUh4LC5Ll73HxheckZUq3e6TyVc/aVRsxIz4eBuo1guNURJo2wgXJFRsry+QpqgXlhmRLKas54uEdangbezUxwUyulB9eWlDys2pAORvpo3kBY1cO8jMYj8yBmGG9KpY3zm8sKmxj0jBZhmna3OM7PnvIuFk+8xZTBuFAXuAMe0NjyevZg4ZwkJAZIKj5xCRXroTrm+ARtNYv9Ubi2cIQm6OfzDyv/s6ObGnxr9puZPkpZSZvUpOVgCxzfDM28u3oB874SdSUflMyf/B7xk6mwx5iuqARO5E93E1KymUHGJP7/qFmVR9Cc11ABZYng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT+6FTOj8BC8qC0n352KLY2xJisbjUrB5GqDQamlQdA=;
 b=pFdUt0u6P9f7U4nL9HshVSJFm6U5sjrP+uOXDmLvWpOSS0LUUWnB+cQoXsLd4aS4d+cguDSwJJArsSD2WTZdQ6EqmGIY09V1FtTtEEmU65X7xFNcIuSm4DXDVLwb2h9SFyEWW+fuLGV6248yOmwXOxeBTLMr/WE4VXCAX7+QGzf86zJE4Khz21WKvn/f/hmX5Pdqe0V7FMeaNAdupu1AfA9dyR8w0yc2wZyt1uyDalNswMZepxRK/ZJhkz8XbNCedNtMrwFURDCl4uHZtqhu5ddYzLjmF7Kl+2kaTyZNFTn9JDJW//OD97+I+uvDPGNax3OyHgNW8VVfnFw7cH/RTg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT+6FTOj8BC8qC0n352KLY2xJisbjUrB5GqDQamlQdA=;
 b=N400lGJy2yxdx9Rm2lxJ4MgFcG7liQHMOJ3dWwptUQxb64xpBa5U21mowGA5d8PqrmD9CdrpH5ocD2eCcY5KBg8erQk2gJ0o7KJ4GG+5uA/aS4opzYXtudrY/lq74EgS/JDDWnHVgSbjYpqc2XnlenSQ4rs8DrIwsEKnn6ACuMs=
Received: from AM7PR03CA0001.eurprd03.prod.outlook.com (2603:10a6:20b:130::11)
 by DU0PR08MB9249.eurprd08.prod.outlook.com (2603:10a6:10:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 14:27:30 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:130:cafe::31) by AM7PR03CA0001.outlook.office365.com
 (2603:10a6:20b:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 14:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 14:27:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7bjWdXRy3rL0Si+XopavfVSgr1ZYxoHUvOj9PmDfzJdqZN31n1VEv4aTB/hGF5K/pE1AohXUENolVvemB+mCZym7Rfy8IRoWDBvW0X6+SRPXn8gIn976FTHJhzv/U2Au36pNhmI4dl4+f2t0wnI5GpV6ZZZdu+8YsNdP3cEsssn3s6fA78fb3G8w7VGObmaAOKoO7Ew0TX7cCIqKN/H8RjsP2WGufchhHJnamuJO+JReJWm5+bakEn69P4a+c3UDeHDfx1OQmDV1A2b/LtK3l52RWOmbae4YgE+B+G9oxslWQdMYVW/lSbtYc75xwE5c0Jag0YxAzArhZCpYJmNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT+6FTOj8BC8qC0n352KLY2xJisbjUrB5GqDQamlQdA=;
 b=Sd9DhTq3+D6ap6qJ2xcVZpN9JoNafSoBeZlCdSw0vBZ3AVrizynXWbpp55IVb+BLX81ePN+BFgi9kuvWcdigW6f0pSll6QleJtaDetFHRuVXkNUz/VrBNRyCiIx1HvA1dAc9hwWo+prNssFpp+5Eg62eFluuQRQscMIYHKXudkMekNDA3m+E350pR3K8Z2WFtKlXT5LG9C4EvjMUGSiwQ/hKrlbrnVsQtT9FJ/OM57Br4mQ65ZYdx2KWSussssR8AiMhKqhts8wbotTVl2ASstCtMYXnSvSPDjW77e2ijLw+9rvRC/Qnxd5bo2ymP81meV6TDVOcDira0cEdadBoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT+6FTOj8BC8qC0n352KLY2xJisbjUrB5GqDQamlQdA=;
 b=N400lGJy2yxdx9Rm2lxJ4MgFcG7liQHMOJ3dWwptUQxb64xpBa5U21mowGA5d8PqrmD9CdrpH5ocD2eCcY5KBg8erQk2gJ0o7KJ4GG+5uA/aS4opzYXtudrY/lq74EgS/JDDWnHVgSbjYpqc2XnlenSQ4rs8DrIwsEKnn6ACuMs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS8PR08MB9265.eurprd08.prod.outlook.com (2603:10a6:20b:5a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 14:26:55 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 14:26:55 +0000
Message-ID: <a0f65eab-0091-4590-9037-c00bd5d0060c@arm.com>
Date: Thu, 16 Oct 2025 16:26:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Pingfan Liu <piliu@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
 <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com>
 <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
 <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com>
 <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>
 <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb>
 <454c61fc-0771-4800-b075-02591bab79b1@arm.com>
 <CAF+s44TT3f0Tp_bXttx-Uwf-QdDUi47Lb7PDqJ9iUg-AUSwPxQ@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAF+s44TT3f0Tp_bXttx-Uwf-QdDUi47Lb7PDqJ9iUg-AUSwPxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS8PR08MB9265:EE_|AMS0EPF000001B3:EE_|DU0PR08MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 0909c8c2-e523-4b12-b766-08de0cc02385
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WHlENVJJMHErbEFXeDV4a3JxWE40NUEyTDNmV2tTcFEwTENPaWVldVNuQ2ts?=
 =?utf-8?B?U200Q1hhMDgxak1uQWdBSVh0cXFFMTV1VU9nSGROZ2NacnNucjd0OXJPYlQr?=
 =?utf-8?B?ZGNlSG4wWE0xalRDL3NKb2J6QTBVSytYM1dNR0l2bkRVdmdDOGdyVkY1YnAw?=
 =?utf-8?B?YUp0OGRkRVRqanQ1Q3VEMU9NZmYwZGttemhMQ2NTV2ZhRnlaV0RpVzVPM2hI?=
 =?utf-8?B?bEJhS29lZE9jUGkreU1xZlQvNFFXbXVLbVc2SDVFbk5Wdmk1Y2lxelNGZ3l6?=
 =?utf-8?B?VlhLRDdrcGROZ1Q0QkdOZHBjWnhPYy80eUIxd2dteFlzdDU3amFqYUwvR1dv?=
 =?utf-8?B?UktWb2lQY2hHc2VwMTd2NkI3SDNHVU5uN3luWFhvY3VGZ09WOWJzSUVBNmxx?=
 =?utf-8?B?MWFpV3JrSXFkd1FmdmU4VGUybkhDNjRJMnZzRFQ5RU8yM1pxbnBqK1dVY25V?=
 =?utf-8?B?MG1xYURRajcrRVoySm1NL3JZRjJvaG5Lb0VWdlV1N3dpeWZsd2ovdFpoZ0RS?=
 =?utf-8?B?Z1pYQlQ2MzhzbHNDcnN3MnhJdHlYQU9uWmRBT0d4QUFydFhFa3E4S0Q5TEsw?=
 =?utf-8?B?cXpiL2RmVWRYRGdsNzU2aFR0TWFzY2RSOHhSb0cvNXN3cDczTGcwank3UEdq?=
 =?utf-8?B?eWFnK3NFNDhESWtDYm5oN0JlS2E4WEF2OE5jODVBM0tuQ1pIalcweGxxRWZJ?=
 =?utf-8?B?ZFBJM1hHYjl1T2w2OS9qeVdqc3NUa3QyZ2hXa2l5RUJnU0tpL3RWVVFtdFdN?=
 =?utf-8?B?WEdkaHcyQUx5N01ySUhyQkxOSWpjb3VSMnlzYlM1VFlBOXBIZjhDTGRWc3Ix?=
 =?utf-8?B?ckQrTmpCaHJ6bzh5TWhsYW5hb0VjK2NZSzlFc2VQRWdiVlpySUgzNzhvR1pY?=
 =?utf-8?B?MXJkUlVwcVhRM3BMcVVQUmFNejFTTGxES2hidDNEdk5mUFhiY0c5cUtvZysx?=
 =?utf-8?B?SW55dno2WE9HZEJBV1ZLajE1cEZVMWJsOFNyZ2VxR3ZPNFJmYnZWZ2NYcG1j?=
 =?utf-8?B?RDlVQ2VuMXBaSTZFRXlvTGhybjU1MDEvZFgvQTVkOW8yZnJnZVdqbm0xZHd5?=
 =?utf-8?B?M3pXV3p0b0hEY1BLOVBtZmJDMGUrN0swT0gwblpnQm1TM1NPNmNlM3RoWEc4?=
 =?utf-8?B?YlBMY2FjdXFyS1YydlV3SkpzYm1wMkxORXdGemxuMTA3OGkyU1VnUjFJNFBw?=
 =?utf-8?B?ZmZOSzFncU4zNGRyaDZzbnVFdTZzeWpHTUVLaEpWRW5qQjFkWVJqeE5GeFNr?=
 =?utf-8?B?QXdLUUc3ZU9uUHpRRDlIQTZEVGxKcnk1YWhiQ2gxRHBTTjJNcXlCbVV6dCtY?=
 =?utf-8?B?dEdTTmo5NGVnTGNBTmlqZGp2aGZQQkdxczRxQ0lPcFRNcVUwRE0yWnJaeUFS?=
 =?utf-8?B?NUVUVlRvU1VyZVZyZ0ZleFQ1QW04c2dVNXpEak5UZnhLVm5ySWlDVDJ6c1Rz?=
 =?utf-8?B?aUlMZ3A5cTRCK0Z5Ni9KVUJSQXUzWW5uZllPenhhUjI3WC95bGhZM2pBeXhL?=
 =?utf-8?B?Nk5rS2tVV2JEMUFlZnRJK0N2NnFEYm5MMTBnQnFjYUpuL1VZTkpGU09oa2po?=
 =?utf-8?B?Q2ZHcnM4cFZERGNzdmxPTEllejE5a25FWlhXQmxWNDRxMmZNZFZrclpVZXE5?=
 =?utf-8?B?NWM0SDBMVk1UVXorb2RaR3dpaXZpeXAwSkZ0RGdINzhOekZNc1RFbWhOamZV?=
 =?utf-8?B?R3hJN3YvKzZic1NYemprcFZRd1lnaUt6bDg5SVpmNEpxRVdJSXhsZWRMRUoz?=
 =?utf-8?B?SVFlcWExMmsxa29weFBNdVVlNkF3WnMzOU5iblR1ZjFMR2FyVW9CK1BZVmVC?=
 =?utf-8?B?QndGM1QzaUovMWdCbTdpbHVDTndJT3lsaUIyMDFMM3l1RTZJeXBRbjRpd0tm?=
 =?utf-8?B?RUJCdHNERWdKMEkwcC9oZmpoQ0tlQ01mdzkxcWFnTGFROHd4dTlIUVMzaCtS?=
 =?utf-8?Q?wgrh5N+e5SA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9265
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	baf5ddd8-5b8b-4b1b-a09f-08de0cc00eac
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|14060799003|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1BBNy84SjFaREtENUZhYkt5dzZISlJxNmZaY3RtTERhZzgvdGZ1V1FVZWM4?=
 =?utf-8?B?VzRjTUhJcUk5L2VOWE9nSkVFVUFxMWNxSWtDdEZpUUlob3BPenBjZmJGT0tq?=
 =?utf-8?B?NnZRdDlCQldpT0d4MFgveEgzV3ZzSTg4UHJLajB3dkg3THBSQzRLSDNlT244?=
 =?utf-8?B?VFVtNTd0TjViNDVlTmZ6QnZRb1VqRENERzBsckp1NkovamtvOXV1YVozV09q?=
 =?utf-8?B?QS94VEhvZTBtN2FmSjhRa0ZrbVpJR0k1VTdmRmh2Qk4xNjZxRitHVGE1dTJR?=
 =?utf-8?B?YllCa3JsRTB6R3lMVXpvT201T0FxOW9BWjJMTHR4dDV2Q2xQTStEQVZGbmVr?=
 =?utf-8?B?UnMwOXY4bkwybWVjNU80R0lZSWNoS0kzWWtIMW9nN0hXZVRuYVZhT0RWSys5?=
 =?utf-8?B?ejNNVlB1MjJJMGR3NkpIaTBQeEl3TXFiZDAyWjQ2alVRbWQwMCtwazZJVERU?=
 =?utf-8?B?VVM2Q0tqdjE4L3MwazZUTHFORW1aSUVoYmJpN01RaTFOYkF5RnczOWZUZWFE?=
 =?utf-8?B?QWtxM1lhR0J3empVT2pCZkg1cm5ldHMrY1ZKNUpuN1YxOXVPZi9ZMjlNcDlh?=
 =?utf-8?B?dEw4TXhqQU1lUXZEZm4xa3R5eHJTTE1JZE53VGp4QUVuRWY4d3NHa3p3Wnov?=
 =?utf-8?B?bXVHTDhJSk9FMlJBQklwUGR4Um44Mm5FWUZKbWl5Um4zMXhEcXkxazdXZHNh?=
 =?utf-8?B?V01jY25jMlpFSnRmbmdpME1pM0xIY1daV0UyVVpVSUNHcEd6bzlKUkdnR09Q?=
 =?utf-8?B?cWlXVi9id2s4Mkw3Ukl4NUNIazJOL1RzSTgvZ0hqQUFJNWJoTUYxRmJtOGtt?=
 =?utf-8?B?RlY2aXgwMXFiWjV0V1ZlVDMxQ2NmYWlENXNZNm1qNXFpY1pWQ3ZjeThvdGhs?=
 =?utf-8?B?azdEbjJMTmRmWHlXZTl2bjBoQVc0dzZJMWFEZzBuc3dWdVlyeVVaNFJ6eE50?=
 =?utf-8?B?MkppejB2bWdOMEtpdEtlck5MTG9MWjUyekFYUCtxWmhJOU1FbHhGMnhOUlFo?=
 =?utf-8?B?ZlZ4a0svSkE5YnVrYzlpek95K1cxOEtlOWtZeCtteVZocEpzVlhxU3RlWU50?=
 =?utf-8?B?OE1LL1llSXkrVkNKWG5qcDhsQy9nb3VJSzRLemtrQWdOS0YyRWxIYUNiam5O?=
 =?utf-8?B?NThYUzU3Ylc5Y0RLVkNOM05PWStLU0RpUXVZZE1nVzB1VCtHd0lQWE5Za05o?=
 =?utf-8?B?bjdSdnhCZkN6eUMrQmxFYTBCWCtWazIyZTZES1dNd2phbXFYRHdDL0VTZ2pm?=
 =?utf-8?B?MEpKbjVabEtlZU42T0pQRkpCT0VnTUhkUG1Ic2M5cTd6MXh6UTdqVHg2bHJm?=
 =?utf-8?B?S3l4bEZ3eC95czNXVk9kL3R6djRYMklYL0E2cnVtUWc0ZlU2c0tYcnZTbWs5?=
 =?utf-8?B?MjY5QVVMZzZmVEdzSGNPOVUvRkxxV2FYZnFTZEIxdXVZa1pRdW85UjNSVTBL?=
 =?utf-8?B?WWxwWTdiTmxHUngrTU9UVk9YUTlzR1dWRDdscmdZbmFXWmRWYmx2bjVYQ01J?=
 =?utf-8?B?WG9VVE4wNktjbFVlcFk2aHpJTVVIWGxzaGNGQTByZDhaZ0tVUjZvQVhWbEF2?=
 =?utf-8?B?Q3BCN21FczdoYW9TWEZ6YWZ4OEZjMWU3UTZ1VEZkSHBKR0JCRHpZNk5nRXJh?=
 =?utf-8?B?R3JiZVpTOEtCRS9jeWlSNzFrZ08wNnlZeDZmUUx5azR3L21VQUlCaFlSSXhH?=
 =?utf-8?B?aXA3L2haRUl2RGFVL0IxNjF2OWg3aUNyalR5ODV1YTlXb0wrbEkzNUNWVkti?=
 =?utf-8?B?b0RZWDhRdkw3elB6WnJmK3JyQkYyaXJtR0F6VWRnRnlCWHhPa0FnK0ErUGhz?=
 =?utf-8?B?SXRPMitZbTE5Q240S3p2N3BwRjRRL2xQcm5NcDVXOU1nMWI1NTNGU0FRZnh2?=
 =?utf-8?B?UndYVmxWUGJYbVZ4K0hzV0h1NlJVcUUvNHJVeWhab2F4NnpSYXZ2dSsvYzhq?=
 =?utf-8?B?azhUL0RGdjNhK3p2d0ZDR3VTOHpONlRHNC8zV3NPNWNpWjgzOEcveWw1cU90?=
 =?utf-8?B?MVZwODhNR3RwZ3RyeW9jdlNFaGladjI0M2tGeG0zdzlneHVDd1dnRDVSNFpw?=
 =?utf-8?Q?C0rfel?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(14060799003)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:27:30.1310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0909c8c2-e523-4b12-b766-08de0cc02385
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9249


On 10/16/25 14:17, Pingfan Liu wrote:
> On Thu, Oct 16, 2025 at 7:38 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> On 10/15/25 11:35, Juri Lelli wrote:
>>> On 14/10/25 21:09, Pingfan Liu wrote:
>>>> Hi Pierre,
>>>>
>>>> Thanks for sharing your perspective.
>>>>
>>>> On Sat, Oct 11, 2025 at 12:26 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>> On 10/6/25 14:12, Juri Lelli wrote:
>>>>>> On 06/10/25 12:13, Pierre Gondois wrote:
>>>>>>> On 9/30/25 11:04, Peter Zijlstra wrote:
>>>>>>>> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
>>>>>>>>
>>>>>>>>> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
>>>>>>>>> tasks (like schedutil [1]). IIUC that is how it is thought to behave
>>>>>>>>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
>>>>>>>>> it is not "transparent" from a bandwidth tracking point of view.
>>>>>>>>>
>>>>>>>>> 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
>>>>>>>>> 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198
>>>>>>>> Right, I remember that hack. Bit sad its spreading, but this CPPC thing
>>>>>>>> is very much like the schedutil one, so might as well do that I suppose.
>>>>>>> IIUC, the sugov thread was switched to deadline to allow frequency updates
>>>>>>> when deadline tasks start to run. I.e. there should be no point updating the
>>>>>>> freq. after the deadline task finished running, cf [1] and [2]
>>>>>>>
>>>>>>> The CPPC FIE worker should not require to run that quickly as it seems to be
>>>>>>> more like a freq. maintenance work (the call comes from the sched tick)
>>>>>>>
>>>>>>> sched_tick()
>>>>>>> \-arch_scale_freq_tick() / topology_scale_freq_tick()
>>>>>>>      \-set_freq_scale() / cppc_scale_freq_tick()
>>>>>>>        \-irq_work_queue()
>>>>>> OK, but how much bandwidth is enough for it (on different platforms)?
>>>>>> Also, I am not sure the worker follows cpusets/root domain changes.
>>>>>>
>>>>>>
>>>>> To share some additional information, I could to reproduce the issue by
>>>>> creating as many deadline tasks with a huge bandwidth that the platform
>>>>> allows it:
>>>>> chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
>>>>>
>>>>> Then kexec to another kernel. The available bandwidth of the root domain
>>>>> gradually decreases with the number of CPUs unplugged.
>>>>> At some point, there is not enough bandwidth and an overflow is detected.
>>>>> (Same call stack as in the original message).
>>> I seem to agree with Pingfan below, kexec (kernel crash?) is a case
>>> where all guarantees are out of the window anyway, so really no point in
>>> keeping track of bandwidth and failing hotplug. Guess we should be
>>> adding an ad-hoc check/bail for this case.
>> Yes right
>>
>>>>> So I'm not sure this is really related to the cppc_fie thread.
>>>>> I think it's more related to checking the available bandwidth in a context
>>>>> which is not appropriate. The deadline bandwidth might lack when the
>>>>> platform
>>>>> is reset, but this should not be that important.
>>>>>
>>>> I think there are two independent issues.
>>>>
>>>> In your experiment, as CPUs are hot-removed one by one, at some point
>>>> the hot-removal will fail due to insufficient DL bandwidth. There
>>>> should be a warning message to inform users about what's happening,
>>>> and users can then remove some DL tasks to continue the CPU
>>>> hot-removal.
>>>>
>>>> Meanwhile, in the kexec case, this checking can be skipped since the
>>>> system cannot roll back to a working state anyway
>> Yes right, I meant that:
>> -
>> when using kexec, the kernel crashes
>> -
>> when manually unplugging CPUs with:
>> `echo 0 > /sys/devices/system/cpu/cpuX/online`
>> The kernel returns `write error: Device or resource busy` at some point
>> to prevent
>> from reducing the DL bandwidth too much.
>>
>> ------
>>
>> I  could not reproduce the issue you reported initially. I am using
>> a radxa orion o6
>> which has a cppc_fie worker.
>>
> I speculate that you miss something like
> "isolcpus=managed_irq,domain,1-71,73-143" in the kernel command line.
> That is critical to reproduce the bug. In that case, cpus
> [1,71],[73,143] are in def_root_domain, while cpu0 and 72 are in the
> other new root_domain. The bug is triggered if cppc_fie worker is
> scheduled on cpu72.

I could finally reproduce the same issue.

The orion o6 has only 12 CPUs. I use:
   isolcpus=managed_irq,domain,1-9,11
Just before kexec, I check that the cppc_fie worker is on CPU10.

During kexec, I can see what you signal:

Upon unplugging CPU10, in this order:
- dl_bw_manage() is called and no overflow is detected as the 
non-default root domain is used - def_root_domain is attached to CPU10 - 
dl_add_task_root_domain(CPU10) is called for cppc_fie
- the resulting root domain for CPU10 is def_root_domain
- dl_clear_root_domain_cpu is called and a new bandwidth
is computed for the CPUs that are part of def_root_domain, i.e. CPU11.
(I don't know how correct this is to do that).

Upon unplugging CPU11:
- dl_bw_manage() is called, but now that there is only one CPU left in 
def_root_domain, an overflow is detected. - dl_bw_deactivate() returns 
an error code and the platform crashes

I could not see the issue previously as the cppc_fie worker was not on
the penultimate CPU (say CPU7). When unplugging CPU7:
- there is enough bandwidth on the CPUs that are part of def_root_domain,
i.e. CPU8,9, 10,11, so there is no overflow
- I assume the cppc_fie worker had the time to wake-up or be migrated
to CPU0 before reaching the last isolated CPU ...

Even by reducing the frequency at which the worker is used it seems to
only be triggered when the CPUs 1-9,11 are isolated...


>
>> AFAIU it should not be possible to add/remove bandwidth to the
>> def_root_domain.
>> During kexec, the following is happening to all CPUs:
>> \-dl_bw_manage(dl_bw_req_deactivate, cpu)
>>     \- // Check if there is enough bandwidth
>> \-dl_clear_root_domain_cpu(cpu)
>>     \- // Recompute the available bandwidth based on the remaining CPUs
>>
>> So I'm not sure to understand why accounting some bandwidth to the
>> def_root_domain
>> is problematic in practice as the def_root_domain seems to have some DL
>> bandwidth.
>>
>> IIUC the problem seems to be that for some reason there is not enough
>> bandwidth in the
>> def_root_domain aswell, which triggers the bandwidth overflow detection.
>>
> The problem is caused by accounting the blocked-state DL task's
> bandwidth to a wrong root_domain. Let me refer to the previous
> example.  cpus [1,71],[73,143] belong to def_root_domain, cpu0,72
> belong to root_domainA. In the kernel, the root_domain is traced in
> cpu_rq(cpu)->rd. But for an offline rq, rq->rd points to
> def_root_domain. Hence the reserved bandwidth of cppc_fie is wrongly
> accounted into the  def_root_domain instead of root_domainA. So
> finally, cpu143 refuses to be offlined since def_root_domain
> demonstrates there should be reserved DL bandwidth.

Yes right, I think we agree on what is happening

>
>
> Thanks,
>
> Pingfan
>>>> Thanks,
>>>>
>>>> Pingfan
>>>>> ---
>>>>>
>>>>> Question:
>>>>> Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
>>>>> is this comment actually correct ?
>>>>> /*
>>>>>     * Fake (unused) bandwidth; workaround to "fix"
>>>>>     * priority inheritance.
>>>>>     */
>>>>>
>>>>> ---
>>>>>
>>>>> On a non-deadline related topic, the CPPC drivers creates a cppc_fie
>>>>> worker in
>>>>> case the CPPC counters to estimate the current frequency are in PCC
>>>>> channels.
>>>>> Accessing these channels requires to go through sleeping sections,
>>>>> that's why a worker is used.
>>>>>
>>>>> However, CPPC counters might be accessed through FFH, which doesn't go
>>>>> through
>>>>> sleeping sections. In such case, the cppc_fie worker is never used and never
>>>>> removed, so it would be nice to remote it.
>>>>>
>

