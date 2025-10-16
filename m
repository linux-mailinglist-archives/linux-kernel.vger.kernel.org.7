Return-Path: <linux-kernel+bounces-856336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0CBE3E81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E043A6A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73933EB17;
	Thu, 16 Oct 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N400lGJy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N400lGJy"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848132D7F4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624854; cv=fail; b=ojjznkkal+TmGmLHOl6i61JBoncozp3ExXa78X1T1e6Sr4yHSg32ReNQhLihXnKLJ3RoO3jCuHLOjUn92XwTF3SXYpNs262H8IZL9JHt2USKidnBsBkncL/hF4uGGHXSpBOTprASLiyHclCS7khBEY4B1+rVSWDsqYVTPJxVGKU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624854; c=relaxed/simple;
	bh=jgW3kPCO4h9rKJVcI75aojI3rnIuuOlMCpIF7SWEnjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pKvgXilHGkgXhPFpp1OSartFF7k+dhLq3/VYWH1BpbA/tma/IFUzPc26yGKd8+IPnBhOMAc54Za6UiOTK/cZ/oBkWM3EGIWAp5pCkMjONPULcDGOjyw+orL/Yy3DGg0yazo+s3Dl5jx8C2yZKJzgIG/nZGbQoHk7vO9e8HfXST0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N400lGJy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N400lGJy; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gKcGDsXrnsLj8tk3W6E92YZ/AQKZRuhtiwd1F8aFpJANGg2VXiON1ARH6r77v9d5oknMTP76/Ls1E+zfD4yoOvE+pqzZ2SDH5hg7McjDYNd6qKVbO7BYXuUuLZNmqXdJNs/Jl0rctBRsXhkX9UaoOnQlAgA4Nqm19Zi81HRYrOtlkpQhHfEAuHAZBz7dHO4ZY5bHZTRo8N57r2Wgn4grgXDypvwI27A4UoJyYBKrOmFiZoMoxJX2ejULScWvPzPj1mMtzi3EVP8AMbe3rOG/S5m0P9wY2udU34j9FLHRXpY3gwDK8EjlP6w21YW6m7O3MDrPaJZ8NX41KVCOoKz9WA==
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
Received: from DB9PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:10:1da::24)
 by DB9PR08MB8338.eurprd08.prod.outlook.com (2603:10a6:10:3dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 14:27:28 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::ea) by DB9PR05CA0019.outlook.office365.com
 (2603:10a6:10:1da::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 14:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 14:27:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGozmk2NgqoWpQrObPeoBhGn3IpKpMjpmGsgKQEkLZHMV6lpSHSu0O7otNxYk3GA1YTAS5/K/UQsC7Nbx2q5JJuJU/uxWfOzMSznKR2+tsoRKvVRicICTn7v/wU22RoYjkAxsb0qwS8+HjecVAIyIKMO8k63zo7q1ebkweklfCzZ/v5PNdjeQEvvjKIHqQ9KDxy2de/X3J72zJSuugDUhbMOH/kl1BdYWJUDR0wfiKbnElT/5MgsDqUXVjtJ5NUlazsduwE1TLWMaN69rwwJg9gJVt71AW82GHIjqEmqQcRgb4/Ke3rVXd0ahkmv1/o/b09KJfa4bmDIdIzrOQGI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT+6FTOj8BC8qC0n352KLY2xJisbjUrB5GqDQamlQdA=;
 b=ETO6uvQV55HK2PMqKlpJMiB0ml93cFpOeWPRePhIu14bYEEXrC9YWb4ACma8A4nYoNVs3UCeI4WHnxh78r6YaQFM3h8OqvlJK5d1ozUKNVRG0JrfUSyg7D2oRwxXCT4LI7t20ZCDAr82XNoTkFZA+D9l/Ayko8vkY6bUjKjTufOAyUOf7XDh+dgNAa6wHRVEctD5TPOe3rNLHeUEHq4dvsYx7QSb0sQmiHuHDk5nd3dXsOSA04gdlYRvocoe8DhfR6nVQtynqg14nay0eymmR/M/rXnIMCesKayPKgo9Cyz4FFIG60V+mu3bbzZ9ai3e9ShDa991JXeH4Ei48QGDyQ==
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
 by AS8PR08MB6565.eurprd08.prod.outlook.com (2603:10a6:20b:33c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 14:26:54 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 14:26:54 +0000
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
	VI0PR08MB10391:EE_|AS8PR08MB6565:EE_|DU6PEPF0000B620:EE_|DB9PR08MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 359beec0-9b71-40c0-2294-08de0cc02253
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MmtpbzhGVmVyb1drTDJqdHlwdHE5WFBKSHUwVml3MWxabngyYS9zdzF0bFdF?=
 =?utf-8?B?SnFkUnpFVkowMkNuMmJCNWt1SEJ6ZWc0S2pzNThrbEtpYzFFR0IrZGJGZ2Rh?=
 =?utf-8?B?djlFVnhobExnZGpEVUlDVFpaYjFyWE1UR0JlK2ZCWS93OXhmZXp2YUk3TEZQ?=
 =?utf-8?B?RUlwckxKeUMxakdqN01NRy9acktEb2tpdXNkMU5IbUJFeVhScmVoblV4bTVQ?=
 =?utf-8?B?cjRBTzBJM3BDWXdNaVZoUTJLZ2V4OTloZVoyQ2p2NU9tQ3dkaWhSWHVMeVYy?=
 =?utf-8?B?dDlKSkE2RENIR2ttN0N4RncwQ0gzbXZoQlBTQVNXT1RBZThqTUpLbzJaQlc1?=
 =?utf-8?B?UUZWN0tGUlVYWGl5VHJaelZ4c2c3c0dSN2d2S1ZUbDRrNjZxVmo0OXRwdEk1?=
 =?utf-8?B?UjZidDBYM0crRHdwNEJ0YUdMYUR1NGR1N281bDVJWm5FWUY5bmdRaGFhbHdR?=
 =?utf-8?B?V2lRVTVSdWNzSkdKdmVuekVoTlNIMkZKcVBuekV5ajJRcU5jT1FIemtnUmNx?=
 =?utf-8?B?dXo2VFFqcEVOYlljcVhPUWlBdUliVVNMU3BHdXVsbXR0UnNhSnVnbWFlWHpG?=
 =?utf-8?B?UWUzcEtENnVSMkdDbkhPNUlmcmd3OThpZ3g0cmhJNlVZWU03VWM1WUFHSUc3?=
 =?utf-8?B?TjRNMzN0QmxGWXBaZDJ0dEdZMFFGb0VwdFRzcEpNN3BVU2JPb0wrY0tnMS9F?=
 =?utf-8?B?VUZYdzd6dWs3NDNxbUxBWWRhUENzNVd0UitnVFo5VGlzcDlMVjc4SENDQk5G?=
 =?utf-8?B?YzdYMUN3SlFGWEYzSkhuQ2ZDYlJ4cnBBSFhTN3cvbXdxSFZaamlld0VYTmZa?=
 =?utf-8?B?NU81dzJ6cmlYbmtzb3EwYXFhVDVNT3pXNXJlTTdQczFOS3NwMWs3dWdvTFhp?=
 =?utf-8?B?TEFpY0tpcGxBb2EyeDhjcDRiQ0MrcjRnbzVQRjBReVZNZnhxRmRWQkM4UnBG?=
 =?utf-8?B?MmpEMkQvT2lEbldMZlArVTU2V3cwVmdQSXhPZUY4RG5GYmJtTTc5K3JWTSs5?=
 =?utf-8?B?aGNQWCtQOTJld0tZT24xSmwrTzE5WWErT09nWGNMWjJiNVlTVnZyYzMzTUh2?=
 =?utf-8?B?OE9kTlZqdWcvU0JvR1c5bHcyNGdkRU5KdHNOb0FKV1o5cUQ2MnpGZFBCYUg1?=
 =?utf-8?B?QnpZQzYzajV5V3JtTjhWOHN0OUsrNmlnU1JZYjVPZjBQeXB4ekdnekk4SEtw?=
 =?utf-8?B?VzRyMXk3UlJKdG8rWER6bG1IRTFoS21MNzg3K2oyRGJhZFNKc2dKRWpzcm9G?=
 =?utf-8?B?SlFHZ1gvMXVZT2FER0lkbXdpaUg0ZENwSmttMEUzS1NPaks3Z0E0STBubkF6?=
 =?utf-8?B?ZXR0NTFmU1d0Y0RWVW9KQXZNdjFCbW85Y0E1Q1lpbHNpcTBTWHRoNCtJWk9y?=
 =?utf-8?B?VTBRU3JnaENtTE9kVGttVW52Y3YweWh2d016QzB0YjY5YTZvVDdodGVsQ0ZE?=
 =?utf-8?B?Nm1jZkNmMVBodnAvTG92UTE1ZHU2cWlKNkI0Y3R1SkdCWmcreCt1dWhqZEF6?=
 =?utf-8?B?Q3h1WjR4Z1Q5R2JrZHJxUk5tWkxGUkkyZVlpTnZQcmR4WnV0Q0dtTk1XMTE0?=
 =?utf-8?B?TmdtYmpkaVcyRUUvbTZTWnBEY2JHdmEzMmdBcGpHRVFablpEV2h1aWxTZ29m?=
 =?utf-8?B?THdnbnp6bE40VUlWd0ZhRWk0dkRxaFdkVEVKQzFmNDZPUDNlUmdUUk81dDNx?=
 =?utf-8?B?N3RFQTgrc3YyNzd5OGFxRUpLUmNqWDA4TDhkRlNEaWg1alFFa3Q5Qk1IUGZa?=
 =?utf-8?B?SmJ5dDEvUDhORWxTM0ZpWWVnYzBWNXhFcmJPM1JCbVRqTnliSlN3OUdzTitv?=
 =?utf-8?B?aW5heERCeDBQTlpKb0grZU5kYXh6YlFVckoxaXhHcGhVd1dOYUdSUHViU04w?=
 =?utf-8?B?TE00VUtiMllWSXJxdlQzenBjU1ZuNWJNRTFYVnV4MTRWRnd3R2V1NVY4MUlk?=
 =?utf-8?Q?w4p/ahZcolU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6565
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	38ebae17-6e55-4f87-8b2b-08de0cc00de5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|7416014|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEpkS1ZxSEdOZVNSZXlLYVNtL2tFVThkeHBpWDA5cGtoRXlqM0VJN3VrMGV5?=
 =?utf-8?B?c1h5a2xyaUVLQU95UWRlcTJ5NGxYcmZpdzZGTndoMmpVRzQ4QU9GNEovMGdL?=
 =?utf-8?B?VmlYNHRDUUU1Mmt4blYvMVlqa3pRZGZNZnltVlR3akd1QTUrSWlzNktUbE5G?=
 =?utf-8?B?Tk43NForNWRmL0lzNmU1bzlRWTc3cHRBd3I2QnlITmUydnk4RTRCWXpCaVB2?=
 =?utf-8?B?aGcxQVBCTmNUM1JNb00zbmJiNDB0VG9RR2VjeS9ES1NGQWI5VytFZkQrLzBG?=
 =?utf-8?B?MWhWME0rUUdEdHNyVnVWVDdwNGtvdnQvMGNpbjNxUGxSZ3V5b1BlK0ozN1lW?=
 =?utf-8?B?NjQ1VTJkOHV0TTZVNUFZcUdTTTROTkZGbHN3UDNMUXJzeVF0RjQ1c3BkYjlw?=
 =?utf-8?B?MFArY0RYVUxCMlNhaWNtRU84NHZtdjgzV1gwb1hwS0RpdTl0NmpsQzU0NTRr?=
 =?utf-8?B?NXFObi96KytSY09NTXZjbGk3OG1rWC9HMzVTUnBLWHdhZE9NYkd1NnlrUjZC?=
 =?utf-8?B?VjZ1NHBkaFR5SENFWjRJUXFJL1ZGbHZFZnlpejU4dStWc1pEU3BYbVhad3Vi?=
 =?utf-8?B?ZzdVbFJFbnlKaU1lL21ZZmZkaDE0MUdKN3EvSnpOdUZrU0FYZTB0TnFwQ3Vm?=
 =?utf-8?B?enpvMFdDTWlOaWUrZjlCTmhpU1o1dnhRS3VyRkhrS0I3RGJ4S1RGR0FuY1p4?=
 =?utf-8?B?N0lHTVRGRWpVbWxJWlpGMlVmOGFXVEtScWlDMDdIcTJ1V1J6NnhnTndsd0tZ?=
 =?utf-8?B?TEJOUDRDWThDUzgvcENLZnVKSHhFUk9vaDNpMUR6YktET21JSExObVIzUlpT?=
 =?utf-8?B?Y1dacUNkRWJ5c1J1RHJPTGtKZ2tXVjk5eUxvSDlRZkQ4dUFEYXQxYzRpT1hN?=
 =?utf-8?B?ejFXQzE5RWNPaW1iMERYSmZvUHlUQ0JzRXFtdkNjbHM1VktvaG9PR25lZkxx?=
 =?utf-8?B?dkRFTC9CU21zdUlSRXZLTDJwUXc3RzhETFdvZGlFK2FIOTExaDd6anpSQlE4?=
 =?utf-8?B?ZjZFa1NvZFBlNGovbXNPUE9YNWs4emFBRVhyOVNJRkUwU2IyeGIrYWdjeTBR?=
 =?utf-8?B?YU9ZeVZNWHhZWitQTm0wam1RTnJKVkswK0FhcFA0dVIwQWxEVkZyU3dMRk5F?=
 =?utf-8?B?SkhlNXlkQWt5SXRWRGF0ZFlvcm1nQ1Bwb1IzUzVGUjhqNnlXWjRjMk9jTFdl?=
 =?utf-8?B?Y0lOMDMrQUN0NmlYN2hsbjc3eEdTYkk3Z0F4N3pHZ05PVnhXZ1dCMmJKMGxu?=
 =?utf-8?B?a0Z5N2tkemV2QVg0ZUpFclJ0SEhLNFRkWkdNMldIcXBvMEl2T0FQS2NHK0lr?=
 =?utf-8?B?UU1pYzRseFBBdVhiOVFqYnRDR3hHYlppYWFhTFRDWGJLMkdUQ21YT2hUWmJT?=
 =?utf-8?B?clpwcDJZVlZ2TjVXMURIa0Z5RWVTR005clNINmJxQjVDaENlMWVWWTc2aTF3?=
 =?utf-8?B?UDNWM0dlRVQ1S2hJdTV5bnM4MkxIeDZQL3Z2WDVhN0xiM1FINGJWcytwbFhQ?=
 =?utf-8?B?RTR5L1ZXZmtKVW9KS2JSdTdGdlFxSlJOM2lFMWRtQnBvNlBJT1dSK3l5K3dH?=
 =?utf-8?B?TUZnY28wT1cxYnc0aWZWME9mbEFoWHd4VEZEUXFhUTRIUVZTVUkrZW5jaTFU?=
 =?utf-8?B?cGlGUkh4OTQ3SE1VR205alkyNVRFWDdxYmNPK3ZGMStyNm4xN2dCR3A3WGtw?=
 =?utf-8?B?OWNTS1pUZmc3MHp2K2V4WXN5Mm9GRXlISXF3Nmd5NmtwdWJNK2Vwd2F6aW1O?=
 =?utf-8?B?S09WZThaeVdsWlNpNXJSQlZjQnA1TWtsbm5MeEFYMkdaRS9Zb0o5UzJGRTBR?=
 =?utf-8?B?ZmZsWUpDa0JodStrLzNJeHFRVXJzQUNBMFJYNnArUm5PdTI0VEcvcnc5Y0w4?=
 =?utf-8?B?SDBJQVQreDQzMjNwTGp6SUsrdkZ1Mm9aRDRDY3Zqakc5dFRpbXpJbG56RGUr?=
 =?utf-8?B?OEdnOGt2VS9qemhyYU8rRTRQbHhudjFVdXNxZGNyVlBFWHVqRWlUNG84NkJC?=
 =?utf-8?B?d3IvTXJmdHByN01uK1NlYjE2TnRsalNLckR1K01WL01Lc1FJTVAxWHRqbFRa?=
 =?utf-8?Q?kQsWvD?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(7416014)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:27:28.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359beec0-9b71-40c0-2294-08de0cc02253
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8338


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

