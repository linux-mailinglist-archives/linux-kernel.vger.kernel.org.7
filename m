Return-Path: <linux-kernel+bounces-800152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2808B43413
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C902585B01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C91ADC97;
	Thu,  4 Sep 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J0KrpBVs"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1629E0E6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971191; cv=fail; b=Vo1qjqmMtf7cNd7gW6fjV30V2p1HKxDXxKEK0HId8T7BFWo5aiurAiU/0K8anOt27zjFsgYLl68Vri3eK3MErNaEhhekjLqGIMepOGhBaQlPgsUjQfSfq9nEUiwgJBCW/Cac6pp98D2efw9Q3YfmyybSp1hiv7+JHLyAaDzzNj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971191; c=relaxed/simple;
	bh=92csHEJ4urn3lulxpEhJmj6S0i3C/hPG4pS/7B+0xuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+W4dX3+1YF+kGWl/102oZZWcaaHYWppFLcO13w6bz/HKV3w33kG2gZYx7qU9uAJ+ovhK9yzfMrMhzVi6F+k0/QplShxApEQcyHEZbfmAHzKHzuAgxl8PmZTwxzdOoyalvXjAmSxVV1GBeXs49eyvfg6rt1c2jYgLQ7dKPqvkAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=J0KrpBVs; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB5L3Fk092qBkNBSa9uYCjDjf58BhWLwNJMIxSAbJTAldvk94FvTRpSRlvS8RebBrxw+y4v+QgNtgewVI6lLaeoKkVcsaiGsPNrh8F5OHQTp968nbVLFdgMHPHNy9V1bvBijIJ0M3gPmhzdhQhSx5uk5f5TV2/UWwbKt49tPmEWHH1k275qhXqoLo26UG2EA8TWga1BNnKDHIFcfKHcCBu5J5Lp5z6FG5r5pAYXIU23vuikrDAr/Y7Tl07imTCo5Wp304zZbozTGVPuMaCWyTru3VOJ0zZn5UpTp16VyLCT6jGoMsS8iK8++H1un1yl6ZI5IJpmthvTSQYP5zi/i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92csHEJ4urn3lulxpEhJmj6S0i3C/hPG4pS/7B+0xuk=;
 b=d56uZZuH2PzxdmiGmAi4Tj6zZSOOHtlMs1eiTnkeO5KXiBYYT69nn/56fIHI04NOo1x+M8IuGXIFAmC6KfeSM77N1axLSVkFn4YxPx0IMhlPMi+98B4Y3cdkMjxnAg+RhnUfUb00Kx35mSrYFG6pwYJlGEJ4P23xVkvs/qwzVbt8g7gN8OLqWmOTjB7CwLIrobbveYYFUtrNrnI/qqNUs/M71Gi3z2h8jh4tnRqd2/Ed+untS7Or/4uyjpIG3AQYFdvueTmjgOvcSrv/4wux/NoOzrBMizTHt19ystjYu/txSQIpO8ppAKZ2eR1SfnTIJdH7iOJMKL3OEy+/ZI488A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92csHEJ4urn3lulxpEhJmj6S0i3C/hPG4pS/7B+0xuk=;
 b=J0KrpBVseP/CumNatZX8Q+p/Ew6acHGwnYopVy0HeWH+ytUXiRtnRNUqhwYEHP+2Xtk//K0dCKjQqLlXpOLH2sD7MmgDz3AuGmMwFjSyFJzJhq6bvhLYYca9xveXrcyikYLZHfYdFVXyGuPZVEVPSqZb1Y7l78vGWL+wEO7fuG+jBSQf++100085KOlvd7o/XSBQOIf98U4q5F9F9QAl3aAeQ2THNwVt9DoY8/3VeFy25BsXXRZRkuhsxcwhEB45hqgO/hNxu4AgInBcJw7APxX0IxW0WjDs52sjmbx5Qj76Y/yR891CEGTA/tS29i0oNjsRykkn0+UjDKcfQ5jjLA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 4 Sep
 2025 07:33:04 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504%7]) with mapi id 15.20.9052.014; Thu, 4 Sep 2025
 07:33:03 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "ziqianlu@bytedance.com" <ziqianlu@bytedance.com>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>
CC: "liusongtang@bytedance.com" <liusongtang@bytedance.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"zhouchuyi@bytedance.com" <zhouchuyi@bytedance.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "mgorman@suse.de" <mgorman@suse.de>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "joshdon@google.com"
	<joshdon@google.com>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"xii@google.com" <xii@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Thread-Topic: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Thread-Index:
 AQHb9ViQ/6iiv7NpUUuDMUkY6xOLgbRYnoYAgAAQ9gCAABmdgIAGF/QAgAObtwCAASbsAIALG2OAgBKa6wCAACDmgIAAEIUAgAAFl4CAABIbgIABTn4A
Date: Thu, 4 Sep 2025 07:33:03 +0000
Message-ID: <bb0f7d900a7e50d173ad462c6ed9f64a4b567785.camel@siemens.com>
References: <20250808101330.GA75@bytedance>
	 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	 <20250812084828.GA52@bytedance>
	 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	 <20250815092910.GA33@bytedance> <20250822110701.GB289@bytedance>
	 <20250903071410.GA42@bytedance>
	 <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
	 <20250903101102.GB42@bytedance>
	 <13467b08-96a6-478d-bb97-060b7d8887e4@amd.com>
	 <20250903113551.GC42@bytedance>
In-Reply-To: <20250903113551.GC42@bytedance>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-1.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DU0PR10MB7436:EE_
x-ms-office365-filtering-correlation-id: 46042926-ac32-4e62-5f16-08ddeb85487a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDBYeThVTVpNMitXN1hkdU5UNmdPYUtIM2xUVTIxNit4ZDJWOFRlTE1iWkxW?=
 =?utf-8?B?YWEwTGRpYkJQQmtTUlYwcDAybmpscjZEUm54bjA2cVpJMG9zYWZaWm4zYit1?=
 =?utf-8?B?UVF4YldlM3dmL1R6cFFqMzFIdkxLOWdqb2hLUUtCTEdvdWN6RDliUk1YUWNw?=
 =?utf-8?B?Wkx5RDltWFNHUlAwTEluNWo0S0c3ZFN5OFo5SkZHbnBKMTBQMXg2Si9tZlRC?=
 =?utf-8?B?dHFrdFFoVTVFejh2c3YzL21uRWNZU1AxdW5vSjdPMC81SEYzTXdUKzhiSVIz?=
 =?utf-8?B?MkFPVEUyb01HUmtidkoyY1FUbU1aMXB0SDUvcE1pVXBNVjhzSGFVV0FXNXpz?=
 =?utf-8?B?RW1pMWs4TmF6eHhPbmppR0ZCSkw3QTcwZGhSRk9WU0RHVHpBWE13NUpRYkZC?=
 =?utf-8?B?dTlabE01NjdXUEtFOW5JeUxoSGFoQmsyc2hjTzNQMXRaSVdTYWJndDJkZ1Jm?=
 =?utf-8?B?VHU5Z3p1QUFPZ2NzZlYxM0MwbGlXODJ4TVN2emVlRlRzTGQ0cTZvNDh6TEdo?=
 =?utf-8?B?cy9lSWZWOGNrQVQ3NU04ejlyNlZUNjdqREROMWhORzZjSCt5c0hpcjZvanU5?=
 =?utf-8?B?RVNKQ3VXUVdXR1BjUXovTnZ4ZGkzbnRHSk54ckNzUnRJNzg2b3A3U1pMSHhu?=
 =?utf-8?B?RjBiYnBLMGR3eTJoR3hFQVRidWx0TVMyYnovYXhFWlhvblRMVHVvTi9HTHRW?=
 =?utf-8?B?Sm40SE9wdmpJa29nQVBTYkpxQllaZW9aVlluRG1SOGc1Z1NrT2syZnNQRXdN?=
 =?utf-8?B?QitlQ1lGZFJkbXhIbllIM0hrYkRIRmJsRElySG9iS3dHNnN6ZVVlbnZaLytn?=
 =?utf-8?B?NUlVNDAvc21OVWhFWHFmaFJGVnlJNCtxR2lySVREMGdIaHhMWThkNm5DOFVU?=
 =?utf-8?B?ZVRmdGJld1QxRDJjbHFJZ1c5Q01UMFRVRjhQNUlVK3FNMjE1NU8wd1VBWXQ4?=
 =?utf-8?B?MktiYTY1Q091ODZlRGU4TnRYV0FNQ0dJbGZ1WVAwZGpicjc5QjhWT0V2K1pk?=
 =?utf-8?B?Wjk3SE9TSFBYMjJMNVNSRTVUckFKL05WaWFLSUU4ZEtJajd2eW90QThkTk5U?=
 =?utf-8?B?ZWNDWEtiQ2pXOTNxN3ExZXU0MjFubWhHaG1HdTcvaVNYTFdIRzcycW5PZ1J4?=
 =?utf-8?B?S2lJbGFYVTJ0bnFuUjIxRTVIeGhyTHdVYk5hL0FxYml5Ly9mT1FzajZBUzBs?=
 =?utf-8?B?aU5RcXJ1NlFtTC9mck5CcTV0WTZBNWRsYXNhQTBuYzBiZzBsL245U1Z5akVM?=
 =?utf-8?B?dmhzVFFKNExMOFg4MGlMWmJ1RzlxYUQzOEp1OUJUU3BlL3RXNkM0MEhpUEFl?=
 =?utf-8?B?TlRmbmZjUmVLeUY5Z01TeEduRFVVVVJ6blNmRjVIWHBvOFpYRGdyNGQ3OTNm?=
 =?utf-8?B?VVFHSVBlb3NGMWNRUU53dWh0OHdHRTZnY0UzRHZkOGVWZmY2RkdnK3dFdVk4?=
 =?utf-8?B?eUJHQjEybUd5bk1BNmQrN3F3U1FsaVBhZVJoWkRpS0xRQnZqbzNPYjRiY3Jr?=
 =?utf-8?B?N2FRd1Zuc2V5QStXTUtzQ3dBSmljUmhDd0wxeTNIMVJJbHM1c0RFVm1mQkN6?=
 =?utf-8?B?Mzk4UG54RnlQaWtmcTlwQ0dYT016SnBZQ3RKQ0xJMW5kZnFvazI5dHJ6cSto?=
 =?utf-8?B?YzFoSTNZbnJTcGFrc09HSXB1SUY2aHhRMnp1eGxoMWFTMTlmYXJoYmRYUDVU?=
 =?utf-8?B?UkhKeUZ4SWRGR2xiNTFSeVlsOVIvMGFNbDFTOXEvYVFGS3R0VHpZalg3Q09U?=
 =?utf-8?B?SmsxeDFZeWhtYjN0Wk1aRUFEVDJlbGNMRm15b203Uk4zRjBTYmtlUUtnNCty?=
 =?utf-8?B?ZEFCVVhKOGQzdGtqNWFZV3lQdlE5eXZOdGw0TDA5R1ZBb29MVTZvUWs4cGtO?=
 =?utf-8?B?Z3lHWGNsWUx5bXFFQVRDeDZFZzMrakVDSmV1eXpNRURTZCt0QkM1SUE1azZH?=
 =?utf-8?Q?YrOWI3eBl+c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXNCeXlZTm16V1FUK1NOYm5wdWlqOUN1aVJnWk5ESTZ0WUNXaS9QTjI4Vzg2?=
 =?utf-8?B?REg1K0gvNHFMNTZsZlFDc3VwL0plQU83SDhlR0lscnM1dnpMV1o4MSs4Rm0r?=
 =?utf-8?B?OEU3bTVMYTg1bFYyRXNIM1dPd1VLV01CQk82YThnM3ZJZUlrVmZvcHlGRXNK?=
 =?utf-8?B?OTJQMVlib0JBeFYrUVFSQjV1NHZiUkt2YmlLZVhCL2RiQ3BXenM5Qy9aMURo?=
 =?utf-8?B?TllSU3B1SmUySmg2M1ZDNDZyRnVQNUh0dzJMbnFlR0VOY1F2Ti9KMUFQeC9K?=
 =?utf-8?B?TlN5VzJaekczSmg2dVFXSTZlYW0yTDluR3FXenFIQTJybFZaMXQySU1PaUxk?=
 =?utf-8?B?ZjBTWlFRLzRpT0NGcm9wRitSa29ETHBGYjZRYzlZOE55Q3F0RFlFOXBWWW1V?=
 =?utf-8?B?N0JNWmhhUi9yQnUvNnJKdHd1SmxOSUhFRTBsa3dLSVYrTEZtVE5KSTY1QmRW?=
 =?utf-8?B?T0ttOWhWQkpQQ0p2bzkyN3pGY0dzcnIydlFybk9jUTMvbmhjb25nYzRSS3lz?=
 =?utf-8?B?clpReEJEbXZFQXd3emRKVkFNb01GdU4zQ1I3SnJBTTdnN0d1Y3VxTVdxcG9Q?=
 =?utf-8?B?bWUxdE9RcWg0aGpsYmp4K1d1VUxSREg1bzlXeDdsN0ZiZXljalMycjNvdFVi?=
 =?utf-8?B?YkVQV3Vub0c2V2IzUjFJUnhiT216Q2RoYVVmRjZOdndLU3BHbmxxMmxEZVVv?=
 =?utf-8?B?RHRLY3hJTjNTL0JvWjNFZEdlK0hCYS81dUh3czRTZlo2VlEwNzJScVR2bzhN?=
 =?utf-8?B?TzJZVkFXa0xPcUJvdVRqS1VhY3UyL3FPNXc4SnhUWnJMZmRKWURGZGpJVjly?=
 =?utf-8?B?cnA2aXh2b3ZkOGlrbm1SMnRVRDU4d0RvRGk0NmVYNVNoNThvUVNsc01kRTda?=
 =?utf-8?B?ZkU3NG5pQzFQTGZGK0FKT05YbFQ3STM4bXF6ellUbVh0Q3V6N0U3bzY3Qm55?=
 =?utf-8?B?V0toMWFnNXdKdStDRzRmM1l6d1gzS1g2dE1KS2VPVjJFUkNIV2Y3ZGVMbWpW?=
 =?utf-8?B?TWN5dGw1NmFzSlN3QTRLZEk4d0RwcURVbFQzZ3U2SFRNWEx5bS81ZWFxcmpC?=
 =?utf-8?B?UGNOZVRnWTJQZWRYOGVQNUQ4YmhYekdsVTU1SFhtemR2Y2FwRXU5YmYxUTJt?=
 =?utf-8?B?MTRVN2NWNEMybDJxT2pyTFJzZE13cjhzVVJDK2FqdkpmWnhVQjg5TGVLVCtz?=
 =?utf-8?B?WVljV1lLdFRrSUpSdnptZWlUNTcrRUVqOEJJNUtXSTdmTzBxWUpPcEZzc3dF?=
 =?utf-8?B?ZlMzb3ZyWUJCTkpiUVBhMWRqL3M5Qk9LbkpwMnhubFhEeWpCZmxyckFRc0Qx?=
 =?utf-8?B?cVhNTVpGK3RnNUkrbWtlbDMzay9tVXFtQzJtYTJJSS9ia0VpOHJ5eVpLdVpz?=
 =?utf-8?B?K01oakoyR2tGU1RZSkxjR29yODBiOGdOeEszalAzL0dpS2hYVUlBYWUvd0xx?=
 =?utf-8?B?Rno0c2laMi9yQ3ZmMXRoUk83elp3NStUc3c4clBxVFAzSlZTSW1yVVZxK3dk?=
 =?utf-8?B?VnZ6bGJhUFVlYW53MUt2cEZiK2NvSWJBYlFaOGJ2Q0h0TjNJNk5VR01rWFZE?=
 =?utf-8?B?Z1JYSC9vZkZrMmdYb2tEOGhaMTlYdDBZa0Q0MU5rZWN6VWdZaXFValM0blBP?=
 =?utf-8?B?Ulo1Y0syRU51K2I1ckNLaXg0QzUrT2lpcmxud2FTSjNodStKRy9EczMzdytJ?=
 =?utf-8?B?eGNLOFpCVENZc1pyY2J4REFPQVFWaHVZNGc2ZVd5ZURkNWE3QzdKbExVV0Ft?=
 =?utf-8?B?TmdGL0FGamdIOEJFd05HclJSWGFtT281Zk5ncHNiWlpmS2ltYXo5dndQUG5j?=
 =?utf-8?B?TzJVQXgvMmtPZUo2SFFuMWczNm5lQUozY3lObGFkSGhtZnVpa2VPQURiSHNG?=
 =?utf-8?B?aDlwbUlqRTRLc0xIWUg5VGxDaG1DcUluMXNyenFUYjgvdTJvYWJQdXN1QWky?=
 =?utf-8?B?WXAzc3p5aitRSnZyQ3ZnTFFBZGF1dGtJWmZ6V3ZIMjJkOWkwaUYvdHoxQ3JQ?=
 =?utf-8?B?QTc2MDZBMjVEcURZR1M5WUtKL3Y3T2taUkRYcmNRZmt2aVlhRkRoZHJva3Ew?=
 =?utf-8?B?Nk5BRG51UGI1dy9BNFNDVmlVV3h0L0o1b3o0OGhoRlk3bllFU1kvald5NDd0?=
 =?utf-8?B?aFhyQVYyeXhEWURnWGxjT21YUy9ZOTRCMHN1VzhaWWIrc0lYa3hQd3lOTjBy?=
 =?utf-8?B?QnhuK1VSdllSQ0l0S0tjUUkvNkFvQS8rSU41eTgxcEk5QytjcGErVDJ0ejFJ?=
 =?utf-8?B?bjVxd0xHQXlEUEpzeC85VEVGbHdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F03117050CD2C946BDC2988EAB142939@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46042926-ac32-4e62-5f16-08ddeb85487a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 07:33:03.5549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pwqyva1mViAtf2W6O6Q+keU3L1UE0w1PIhjGVvb4VS9kKLbai58kXathUvK/d9C9FdvfvPPW3Hlk67q6O4iKPSZHP/9Z+VTwEh+lUGKsSME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7436

SGkgQWFyb24sDQoNCk9uIFdlZCwgMjAyNS0wOS0wMyBhdCAxOTozNSArMDgwMCwgQWFyb24gTHUg
d3JvdGU6DQo+IA0KPiA+IFsuLnNuaXAuLl0NCj4gPiA+IA0KPiANCj4gSnVzdCB3YW50IHRvIGFk
ZCB0aGF0IHdpdGggdGhlIGFib3ZlIGRpZmYgYXBwbGllZCwgSSBhbHNvIHRlc3RlZA0KPiBzb25n
dGFuZydzIHN0cmVzcyB0ZXN0WzBdIGFuZCBKYW4ncyBydCBkZWFkbG9jayByZXByb2R1Y2VyWzFd
IGFuZCBkaWRuJ3QNCj4gc2VlIGFueSBwcm9ibGVtLg0KDQpUaGFua3MgYSBsb3QgZm9yIHRha2lu
ZyB0aGUgcmVwcm9kdWNlciBpbnRvIGFjY291bnQuIEJ1dDogVG8gdHJpZ2dlcg0KUFJFRU1QVF9S
VCBuZWVkcyB0byBiZSBlbmFibGVkLCBvdGhlcndpc2UgdGhlIHJ3bG9jayBpbiB0aGUgZXBvbGwN
CmluZnJhc3RydWN0dXJlICh0aGF0IHdlIGhpZ2hseSBzdHJlc3MpIHdvbid0IHNsZWVwLiBKdXN0
IHRvIGJlIHN1cmU6DQpQUkVFTVBUX1JUIHdhcyBlbmFibGVkIG9uIHlvdXIgZW5kPw0KDQo+IA0K
PiBbMF06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA3MTUwNzIyMTguR0EzMDRA
Ynl0ZWRhbmNlLw0KPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC83NDgzZDNhZS01
ODQ2LTQwNjctYjlmNy0zOTBhNjE0YmE0MDhAc2llbWVucy5jb20vDQo=

