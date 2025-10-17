Return-Path: <linux-kernel+bounces-858012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69138BE891A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C57404ED2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589792C11F5;
	Fri, 17 Oct 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="v5VKNJjU";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="lV630X8v"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601F332EB4;
	Fri, 17 Oct 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703708; cv=fail; b=e4H+8reb4DaXcqLvhq6SdURnn83tfLmbMY0aaJfPoCaknzksh2hTVWDFTINA+M0p0iW7AoZhH9zApfiZd2F3nSWCD6yXxcINC9oPizpssSaR7wgb55WjaDE9QNXp6ob0ekarXTTrrNjUNZbPOc8U60jES8WgqF6qrJbBYBBf+qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703708; c=relaxed/simple;
	bh=XcV4Vnu6TzEg/uX7MkBvzydAYDy4LP+p9XXeNN2xiLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMqX0M+oJAIatunvclxKH8LwckvvFYOWGbeytUflsXKjt/Hn21cpSps5RNCIdTSjMkq9lC15QgYRjZDyG/XiWxm7nM83z6Lk0m9YOgZ2yxyU3ir/2kscy73fGdzl2q25iqxi2DimPs+urqTZOpK3IK2OPHVL3lJCfSacOruYav8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=v5VKNJjU; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=lV630X8v; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H3PcOA3705879;
	Fri, 17 Oct 2025 05:21:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=XcV4Vnu6TzEg/uX7MkBvzydAYDy4LP+p9XXeNN2xi
	LU=; b=v5VKNJjUMGiuDO/wczIfk/Uv14789+oOpd4r59CP6YnDm1nbEEnRGfnKx
	E0mlNkjgsVSybQ5BWSAuSQoAx4w7tGInPTN4aQXZhyYzqm5NIEn2olHp8HUuXFj/
	iQi/fQEUFjdpvRlud4fR6mVCKOkS3S7ZqIFBx7v3IthCHsOclT+0I0YYp4gMdmLY
	BWPyppD+RvU1HTgmH0lViVoTU7+kS/PmC/Vkr+X3AHLezwrfA5tLicVPc0fOUbho
	6I1M/fdQQ5qSthyhmDfnR7Rhmp4Xe/e8GI+qHNYBvq6ssUExi9L/1OvrozQhupmv
	ahLot+Xbs9+qFxig8cbiDSgkg7lbQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020097.outbound.protection.outlook.com [52.101.85.97])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49u3umjb3x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 05:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6iqLB9zTBHIV9tgSzVoZkCz1BzgNBN6Y/Jtrvur7uRL81m7WjY3MRsGjbPMAw+RwwiCpAiQe+T7mkUExWNQwiQvfdaoLrKgQf0YL3gb2lD61N4esiMENGKoVaEbo2LYuUPeeqR6ZSDAtBRUDz5fwukIPW4t9LLZIzwtcZaET0RmVlAVSTP/P2JG108ky7Megn2bW0mq60JmOeApTjcTLDiqAJKJHnalBVyfnWCMWxC444c7h5gi7ViDTAD39Awu4IYonZNl8RFJno9w9SlKNxOS6HIRYzbLuRutzE8nnS4+9CyDTZaiQG9MjyU15kZUwysyr1Oe3xOBVxXfCMXuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcV4Vnu6TzEg/uX7MkBvzydAYDy4LP+p9XXeNN2xiLU=;
 b=Q+bGQs+rJCLOrCqYZmMOc5yOayjYaoRZ7LlUe+wBGGjY9BhhfHf3AFydholJabUFIeIA8CoaAQuZWXWrTOckkk/gwu//CTDZMhPnaKpyJ7nrwjLc+mzAT9smf8NkZnO1OPiUU4iSEYqRj/51EM3fjE1No8wDSFEXfqNsw6YJf16Fo5FOrSbkahNyeXLTT7CFWk4WrP1lymF+GMz2xsi/qDSBu7aRrq2QDXsOM8aR16xVGXlckRHRAWzFaR7TxvUB4irhD/BJ3WOFkFLV4EKqniu1w/39ELB2V5ike5OO4xrSuy36YpsHa9E9Jl2HEdhfe+Phq7oY/RELIsQLnbd9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcV4Vnu6TzEg/uX7MkBvzydAYDy4LP+p9XXeNN2xiLU=;
 b=lV630X8vngap4exa01fMgdHDBXn3ZSPppGxWYal3uMrJrk+IBVIIj9OT8eVelyobRzkQ1vJeq2mvGXz8bLYsL5K/8tL9FsP57ZdF3UDu6DYPdWfPwBPYdJLledQ17sZGRGyYMU2/iraMWyQaeWbVPie9NGv/hMIJflg+MDz/aoaDP+vCwAzeJVqFEmlsX6nTNTo5asZwwm0s/96eXahCI3GeV+jMgOrM4pFrQzKPHvfbPJ1r20lz2zCWOQlqrIFkhwMjM/cyjngV0SsThsJ5ahYjQgwmaMWc/TrkjEy1IW9wzxEgRK8/b9wkTHZqsqf3hAPCFTDH5729gP5pfAS0Ow==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB10910.namprd02.prod.outlook.com
 (2603:10b6:208:59c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 12:21:12 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 12:21:11 +0000
From: Jon Kohler <jon@nutanix.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman
	<jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre
 Chartre <alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH v2] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index: AQHcPv5fEvwBfNfs8061y/ytPB2UDrTFupgAgACIZwA=
Date: Fri, 17 Oct 2025 12:21:08 +0000
Message-ID: <C2A57B61-8E6A-4236-9F50-B0662C39272D@nutanix.com>
References: <20251017011834.2941358-1-jon@nutanix.com>
 <9cf0e05b-00e6-4954-96d5-fafeb6e6397a@intel.com>
In-Reply-To: <9cf0e05b-00e6-4954-96d5-fafeb6e6397a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|IA1PR02MB10910:EE_
x-ms-office365-filtering-correlation-id: 78a86d8b-79e6-4850-7632-08de0d77a712
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHpYS0VxSjNOQXRobnJoVWJaeFlCMUlpUlRacnRXREs1U0pMVXlvY25pRzNR?=
 =?utf-8?B?V1FPcjIzbmZGenkyZ204STJodUcwZnRudENTZ0VxVlcyVDZjWm4vWGMvaUtn?=
 =?utf-8?B?NGFIYkR5SG1PL0ZBNDlGazBOZ0RvY2F6SFMrbXVLMzFZbEREN1o1ZzdGdndj?=
 =?utf-8?B?eXdVdUNwOXQ4YUI2eWhOR0plb1gyRS9yeE9ITUFtNDAvT2czOFhNRVFpYkhk?=
 =?utf-8?B?a2dha1NQNnFjRDlIRThFL29xN0g3aS84emlWK1ZndFRvR3RrZmRDN3ZjWm92?=
 =?utf-8?B?bWJaNjRZWXB3Y1ZYdWlDZlMzeFZwZ1hDSXR1elMwWmJGMHBWaGtGT24rMHhQ?=
 =?utf-8?B?WVlhMDU3ZVRPT0F3UGVkTUJuSHNYcnRKV1Ixb3N2TStJc0VjUVVEQnlwaG01?=
 =?utf-8?B?R0w2UnM1UDZUY1NscVc1WHlJOEVzYjhCbCt6VkdISVMyc3FnakhEOCsxVjRy?=
 =?utf-8?B?dHYvSHNqTlhOanN6Nnk5YzM2SW1PWlBjZHg0ZE1JWEIzVjBBeU1wR1lEazlx?=
 =?utf-8?B?Sm9EVUttcCtPbWJBN09mckxPQk9NYnpMSW81dnpiWDA4TERuOGpCWG9mN2pW?=
 =?utf-8?B?dTA3SmFwbjVpVVRjYzVQWHYwTkxiSlp1elNsMkhSREtNRThNVlJ2ZS9LTG5M?=
 =?utf-8?B?N0plNm4ySmY1UnF3MHBqRGlGbUZ5c0JBLzNPSzRkUzNBTnE1Vm0zWUFmLzFv?=
 =?utf-8?B?Uml6VUNNTkt1M3A0UEhBQUN6T2NGZktiOXpXTElpL0FUZE1WQTFGc0FTQy9I?=
 =?utf-8?B?VjRxNXllcjdYVDYzajJHSHNUbjFRSE00UW1BOWpDMVZOVVJIVGY3QjB5OEsx?=
 =?utf-8?B?YkdwSkR2WnRnbU8wc1piQmt4LzZWYTVBYmNSbEl5aXVMT1NWTlFXWUN4K3hQ?=
 =?utf-8?B?MkFGL1NrazNSYll1RVc4cTdJcFY5Z2IrRWxXWTRWc2pkMTFEYk8zdVo1ajJp?=
 =?utf-8?B?TkN5b3dwZTZCbDkrR2xwNytMalpELzMvcFZ2REhXSlQvamFlYzI5ZTNKSFht?=
 =?utf-8?B?ZFRUd0tVOFRsRi9XMDZWZ3BWN1BxekdEUkZ2N0JXTE1WZ1hwVHI4eXRjeEpY?=
 =?utf-8?B?M2FNcWF0S3dDRVRDSmpZdTR5VHh0akdhekYrWEdjTTNBWVdMZ3piWkgwdDJU?=
 =?utf-8?B?YjhWUVhKVjBoMGQzVzNyM0NNQTVLaHMwU00xb0hoWGRUUzFyaENKZlZNZGFV?=
 =?utf-8?B?UjNBVVVDYSszbHlROXFFUzhiTGxYRDRYMUg1TEF2cWRCMW42RVRYcldaVWUr?=
 =?utf-8?B?NDRBbkF5NFZPZ3hlY1V1MVIzdnJzUEVEMkJvZEJBOWtkK3BSYTZKU1J2MTlB?=
 =?utf-8?B?M2MramtDSGVvTmtPKzJxa0x1RnZiejhwM21ySHpNOEwyZTVSWWxvWFJmSXV5?=
 =?utf-8?B?N1JqQVZaZnRFQXJvcjVOQmU0SGNiT3E4UnVzMXFjQndyRzJRdWtRYll2V0Fj?=
 =?utf-8?B?MUVhNzVmYnlHU1IzeDZtc3VkU1pwKzg5RWJnVzNvbDhPWENRVmppeFE3UE94?=
 =?utf-8?B?dS9yQVYycUxqRG1lY1ZldVN3eWlRTER2d2poMjFBNFFHemY1OHBnVm52dlVD?=
 =?utf-8?B?V0dUeXVYL3NEWi9RanZ4MVpob2ZuTTh4aWo2ZmpFS2FhbmRFNFhQL1ZrU1Bu?=
 =?utf-8?B?MmZCZzN5R3lTeUtlSGRuNktlY0NucnV6R01STWh6aXdGcDhod2RLUjRWby9S?=
 =?utf-8?B?Z1hUWUxoZGhmc3VKQXNUOUNsZ01aODRYTnNCa0dyUjZkTXBCWUxkcW9LU1Jo?=
 =?utf-8?B?OU8zVFFOakJQMnBTYkt4Z3haZTNRck5TbWtBcE1yVU5rVm1CdUtpRmM2V0Y5?=
 =?utf-8?B?UzZ5SFc5QVExbklrVmJ6cUZzSWxoQ3gxUHB3ZUNzN2NPQVpSdkJHdW1rdGJp?=
 =?utf-8?B?SGUrekdvZnpNK1UvQkdnOVVFcVR6R3BnektKcjJmVkp5bGp2UWdvTHhvQncw?=
 =?utf-8?B?dkxOUVRJQS9kaXJWaE13NnFscWRoaVkyYnJhYjlZUUZLZXZrUkhiTHcrcFJp?=
 =?utf-8?B?QXV1ZHByS1BuR1dPZ0h0aGZWODRaa3lzSmczZi9YcU9Ud1FpWlo3SVBDR2to?=
 =?utf-8?Q?OxlPrT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGdHdHlHdVRGYllSeThuQjJTbE1oNU04cExaekgvanJrV0lMSnNpQ1drVFU2?=
 =?utf-8?B?KzlWV2M3ZzFFcDAxOCsxeGNDaHpyRmJhNkRNQ1ZkcTFnV0lZTVkvYXR3cFR0?=
 =?utf-8?B?YW5XME01cDJqRTAvcVRrWVVXMXFYVC9OQjZNZE5WUlgwTTI3UTIwdFVZaTU3?=
 =?utf-8?B?aWc5bkczblhZYTNQdkFlNWdCbVU1L09MWW51TWhuSEQ4aGUrN1F3VEJUMHdo?=
 =?utf-8?B?eU9qeGVzUk5ydEVRNCtCcTNQZnZWVEE1c280WnVsS1FlcHFoWGF3RkdqeTls?=
 =?utf-8?B?ajQ4VWpKcTQ3S0tDM083YVlvenVOYktoMS9UbjMvaUpPbXNkdjI0T1U5Y2t2?=
 =?utf-8?B?MDRwUHl6M1RLcUVWc0ZNWnpQMVZJbythTzNVbHhnbkNGb2hGMVBLTWNKUEtr?=
 =?utf-8?B?Sm1uVHh0U05FNTQ3OENwei9rdFBVL2lGUjlEMWtHQ3g1SFZnazk2ZkFaWUVO?=
 =?utf-8?B?Q25BenI4dXk5YnR2SXBhTWdaSExqMVlRVHN0QTkyeVZqOGQzQ25qQjd0LzhO?=
 =?utf-8?B?NmlucUVTd05tRTVtVWtsU3VHcTJlVVlvSUFhd2EvV3k3R2JWL09JTW4zbkNx?=
 =?utf-8?B?emJRK20wWUh0R3dNNkRvN1A5OHEzQ01jZGZKQmQ2US93V3ZMWjYwU1FxQkV2?=
 =?utf-8?B?RUVOblNGbEkrOUIzYmJhTWNiVHpJVmo1QnBnV2oyRTFHbFVKWGJVdFUranFN?=
 =?utf-8?B?QXlsTk1oSkpDQlB3cGgwWG13WllmeS8xTURZTDltY1QrbG4rYzhmd21TVWNQ?=
 =?utf-8?B?RHI2QnlKN0hhajc4MWgvWFJaUW5PeXd6K0dhSlpkZWFGb1hYeVpPdjdWT0Nz?=
 =?utf-8?B?NEdYMDdTSnVaZ21UdXZIaE9hRXgwMWUxWnF0QjF4NVV5QkRNQW01WGh0VDJ5?=
 =?utf-8?B?VXFtT2l1ckI4azBXbk9CU0doNU1ZUG1POFYrZ1FIdkx6YmhsRGh6cmhidDFi?=
 =?utf-8?B?SHIwcXlpb2poK0dPaTFyS0RQYjBsYVIwVnVtVzNSYjZsR05jRkorVXAzYnZX?=
 =?utf-8?B?K0dwbkhCUFArc2RNRWlaR2I1WEFKZlpDbElwU0M3WjRjc2l0OUdlRDlaaEpN?=
 =?utf-8?B?SWRXY0pIZlNpMmU5RzlSQ09rdVltVEpBZEdCVW11dmxyNms2Y0dPMEdvTGpq?=
 =?utf-8?B?R0JxK2c2Q2VlOGl1RkZlRkJGd2F1MllBbXpqUG9mWlkzdTJJZmZLSVZ2RHRs?=
 =?utf-8?B?aHYyOW13YlNYVnR6MkxuUjhEUE5PaU9xU3FXR2ZYbEZMZ1JSS3Bpb1BETWQ0?=
 =?utf-8?B?bitVRVU5SlA0QW1OWE9Sby9lSkd6bEhYeENnRHQzaVVEa0JWNll1cWpjZEF0?=
 =?utf-8?B?N1BxVkhUTTAvcTBNaWd5Y2lRWWVITHQ5MlFoUGVkeHZjU2ZpT3BjV0Q2aXlO?=
 =?utf-8?B?ZngzRG5BTmwwQlNsTklvb0QrVXl5ZkhySnAwbFd4TnhZN2NpSlpVbzRyTi8r?=
 =?utf-8?B?RnU5VGhrMmxrbDJBZVVQQnNIbmJUT3IwUmpJRldYbVRCVUNVRnFjaHpxeEI2?=
 =?utf-8?B?VHFPY2JUWG5xYWIrLzI0MGZaT3hTN3pSSU56QzFaWHhnMVJRZE9SQUFINWJQ?=
 =?utf-8?B?ZFA1TGlHcW1kWUZBUUdVUGs5dXdNYTNwYXdXd1djRnp1Y0VPeGlCeVRJT0Er?=
 =?utf-8?B?OFhndUlFZ25QTGI0ZE12QWlLNUFSd1hrQW1LT3dWdkR2Qlh0bFhkdWlZLy9k?=
 =?utf-8?B?aWhIRER6SytaT3E3aGVMeERkaUROanUyUmRraUZrUjRvRWhWYTBYZGhZcXR0?=
 =?utf-8?B?QlhUNWxuTTh0Q283ZURPOUVkOS95cS9tMVZrRjQ5eGg1ZnRjRE9BVTJDZWov?=
 =?utf-8?B?eUhVQ2VPY2xadnFwdk5YZVU1T08xYU9XOHY1VlRLK2NBM1VTczRTUDI2cm5R?=
 =?utf-8?B?USsrRkxWODN6Tk1lbjZrOExHUktvNHBiVXRLbGlRaGZ2TURMazUxNk5TTGVz?=
 =?utf-8?B?SzVkSHdaNXdpQU8rWlpFSUUyYVJSUDJoWk85b29FT2lRQ3Ztc25jb3d3Ly95?=
 =?utf-8?B?OVExWHhISW1jbUZid3pBMWNnWVNvamY5TXNKc1l5am1TSmN2djdjaGdSWGhs?=
 =?utf-8?B?UWpsQnRRcDdzSENMdXNpRnN2ZmhSWHVxSmRZekVSY3FjOThHaFB5WTIwNUlN?=
 =?utf-8?B?WjhOR0x1OGNra1VVbkRSSUR1TnAyVzVpS29kbVZid2FSdVhtWWRUalk1SGxI?=
 =?utf-8?B?bzZrS2RtY2NwY2pTNENVeGVtczVocnhRbVd5V3FncG9aOFhTVVJOdWZOYzdp?=
 =?utf-8?B?QTVad3JHSFRSYUUzbU1wWnBDM3BnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDF341B5C05C1B42B0F73CA4ABD3AD44@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a86d8b-79e6-4850-7632-08de0d77a712
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 12:21:08.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSHtbq5TzTp6Kb0kIyY4CGjYvUY/O8lA2QgOP/aj8BYwy0EIN1RDgpV9bDkPNZbQkpeNAuZujnvJGiWgzTravNB5Nea28w/zxI0USRpp8Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB10910
X-Authority-Analysis: v=2.4 cv=foDRpV4f c=1 sm=1 tr=0 ts=68f234b9 cx=c_pps
 a=WbwzdlnB7+o+U6PX47Rpew==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=XtGoufa9yYzQQCPStKYA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: BZtHp4DCgCCqsj8XvZ9GkvMTH1k85R0t
X-Proofpoint-ORIG-GUID: BZtHp4DCgCCqsj8XvZ9GkvMTH1k85R0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDA5MSBTYWx0ZWRfX2aAN7Vsvp3jS
 r3+cZIqX+TZsVXuqCrWJgNPC4tJrC4a72mF8rUvk+RC01jttP4PrpZpS8QSYasMkcS0UVWCVl2N
 bl44geXZOT8ZNNaUkkkdk7Oj4sZRw/47kZSBRSDNf6IYAs40EzE36fOnb1aB1BPW92bOmJXEruL
 eEVYNr9UrRvWeUHrl/LiEfOMomVgYDS12JhJjrl4U3NXNpNUd9wXiznBsnL5XyQVZji88x9cjEC
 mWU5Fu3t3LImanepyAQw5fnoHCFQG6nq1AtfX4AojJ4E8d+GwWR+1aGeDzwEQ/jKGEucjwiKcUS
 6Ve0rhqlYkhuAywTbhGzW2T3dnSd6CnVXTpFToOYpS0+LULGuQKE7o4V14dak/UQY1CWaAXceiL
 O+zt/CVzwjvGjN8k0RY/eKdvgOuuCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDE3LCAyMDI1LCBhdCAxMjoxMuKAr0FNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gMTAvMTYvMjUgMTg6
MTgsIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiArICogaGFyZHdhcmUsIGV4Y2VwdCBpbiB0aGUgc2l0
dWF0aW9uIHdoZXJlIHRoZSBndWVzdCBpcyBwcmVzZW50ZWQNCj4+ICsgKiB3aXRoIGEgZmVhdHVy
ZSB0aGF0IG9ubHkgZXhpc3RzIGluIG5vbi12dWxuZXJhYmxlIGhhcmR3YXJlLg0KPj4gKi8NCj4+
IC0gaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IWVBFUlZJU09SKSkNCj4+ICsgaWYgKGJv
b3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IWVBFUlZJU09SKSAmJg0KPj4gKyAgICAhYm9vdF9jcHVf
aGFzKFg4Nl9GRUFUVVJFX0JVU19MT0NLX0RFVEVDVCkpDQo+PiByZXR1cm4gdHJ1ZTsNCj4gDQo+
IFRoaXMgc2VlbXMgbGlrZSBhIGhhY2sgaW4gaXRzIHB1cmVzdCBmb3JtLiBFdmVuIHdvcnNlLCBp
dCdzIGFuDQo+IF91bmNvbW1lbnRlZF8gaGFjay4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFu
ZCBjb21tZW50cywgRGF2ZS4NCg0KWWVzLCBpdCBpcyBhIGhhY2ssIEkgY291bGQgZG8gYSBiZXR0
ZXIgam9iIG9uIHRoaXMsIEnigJl2ZSBwcm9wb3NlZA0KYW5vdGhlciBwYXNzIGF0IHRoZSBib3R0
b20uIFNlZSBiZWxvdyBmb3IgbW9yZSBkZXRhaWwuIEnigJltDQpob3Bpbmcgd2UgY2FuIHdvcmsg
b24gc29tZXRoaW5nIGJldHRlciBiZWZvcmUgd2UNCmNvbXBsZXRlbHkgcHV0IHRoaXMgb3V0IHRv
IHBhc3R1cmUuDQoNCj4gVGhpcyBpcyBfbGl0ZXJhbGx5XyB3aGF0IElUU19OTyBpcyBmb3IuDQoN
Ck5vdCBxdWl0ZSwgYXMgSVRTX05PIGlzIGZvciB0aGUgVk1NIHRvIGRyaXZlIHRoZSBvcHRfb3V0
IHdvcmtmbG93Lg0KU2FtZSB3aXRoIEJISV9DVFJMOyBob3dldmVyLCBJ4oCZbGwgZXhwbGFpbiBi
ZWxvdyB3aHkgdGhpcyBpcyBhIHByb2JsZW0NCmZvciBkaXN0cmlidXRpb25zIGFuZCBndWVzdHMu
DQoNCj4gU28gaXQncyBhIHByZXR0eSBzdHJvbmcgTkFLIGZyb20gbWUgb24gdGhpcyBvbmUuIE5v
IHRoYW5rcy4gSWYgeW91IHRoaW5rDQo+IHRoaXMgaXMgdXNlZnVsLCBpdCdzIGEgZ3JlYXQgdGhp
bmcgdG8gY2FycnkgaW4gYSBsb2NhbCBrZXJuZWwgZm9yaywgYnV0DQo+IGl0IGhhcyBubyBwbGFj
ZSBpbiBtYWlubGluZS4NCg0KSSB1bmRlcnN0YW5kIHdoeSB5b3XigJlkIE5BSyB0aGlzIHJldmlz
aW9uIG9mIHRoZSBwYXRjaCwgYnV0IEnigJlkIGxvdmUNCnRvIGhhdmUgYSBzbGlnaHRseSBsb25n
ZXIgZGlzY3Vzc2lvbiBvbiB3aGF0IHdlIGNvdWxkIGRvIHRvIHNvbHZlDQp0aGUgcHJvYmxlbSBk
cml2aW5nIHRoaXMgY29tbWl0Lg0KDQpUaGlzIGlzbuKAmXQgZm9yIG91ciBwcm9kdWN0cy9rZXJu
ZWxzLCBidXQgcmF0aGVyIGd1ZXN0IGtlcm5lbHMNCmZyb20gZGlzdHJpYnV0aW9ucyB0aGF0IHJ1
biBvbiBvdXIgKG9yIGFueW9uZSBlbHNl4oCZcykgdmlydHVhbGl6YXRpb24NCnByb2R1Y3RzLiBJ
4oCZbGwgYWRtaXQgSSBjb3VsZCBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZSB0byByZWZsZWN0
DQp0aGUgZHJpdmVyIGZvciB0aGlzLCB0aGF04oCZcyB3aGF0IEkgZ2V0IGZvciB3b3JraW5nIGxh
dGUgOikgbXkgYXBvbG9naWVzDQoNCkhlcmXigJlzIHRoZSBkZWFsOg0KV2l0aCBJVFMgb24gU1BS
LCB3ZSBzZWUgdXAgdG8gYSB+M3ggcmVncmVzc2lvbiBpbiBTQVDigJlzDQpQQk9mZmxpbmUgYmVu
Y2htYXJrIHRvb2wgaW4gYSBtZXRyaWMgdGhhdCB0aGV5IGNhbGwg4oCYY3B1dGltZeKAmS4gRnJv
bQ0KdGhlIGVuZC11c2VycyBwZXJzcGVjdGl2ZSwgdGhpcyBoYXBwZW5zIG91dCBvZiBub3doZXJl
IHdoZW4gdGhleQ0KdXBkYXRlIHRvIHRoZSBJVFMtZW5hYmxlZCB2ZXJzaW9uIG9mIFNMRVMga2Vy
bmVsLg0KDQpJbiB0aGF0IGJlbmNobWFyaywgaXQgdHJhY2tzIGFsbCBzb3J0cyBvZiBzdHVmZiwg
aW5jbHVkaW5nIHRoZSBjdW11bGF0aXZlDQp0aW1lIHNwZW50IG9mIGFsbCBjYWxscyBpbiB0aGVp
ciDigJhpbmRleHNlcnZlcuKAmSBwcm9jZXNzLiBUaGUgaWRlYSBiZWluZw0KdGhhdCB0aGV5IHdh
bnQgdG8gdHJhY2sgYm90aCBkYXRhYmFzZSAvIGFwcCByZXNwb25zZSB0aW1lIGFzIHdlbGwNCmFz
IHRoZSBhc3NvY2lhdGVkIGNvc3Qgb24gdGhlIHN5c3RlbS4NCg0KVGhlIHByb2JsZW0gaXMgdGhh
dCBhIGd1ZXN0IGtlcm5lbCBjYW4gbm90IGNvbnRyb2wgd2hhdCB0aGUgVk1NDQpjb25maWd1cmF0
aW9uIGlzLCB3aGljaCBpcyB3aGF0IHRoZSBvcmlnaW5hbCBJVFMgY29tbWl0IHBvaW50cyBvdXQs
DQphbmQgdGhlIGVuZCB1c2VyIHdpbGwgYXV0b21hdGljYWxseSBzZWUgdGhpcyByZWdyZXNzaW9u
IHdoZW4gdGhleQ0KZGVwbG95L3VwZGF0ZSB0aGVpciBrZXJuZWwgb24gYSBWTU0gdGhhdCBtYXkg
bm90IGhhdmUgSVRTX05PDQoNCkkgYW0gZ29pbmcgdG8gc2VuZCBwYXRjaGVzIGZvciBRRU1VIHRv
IGFkZCBJVFNfTk8gdG9kYXksIGJ1dA0KdGhhdCBkb2VzbuKAmXQgaGVscCBhbnlvbmUgaW4gdGhp
cyBzaXR1YXRpb24sIHdobyB3aWxsIGhpdCB0aGlzIHJlZ3Jlc3Npb24NCm9uIGhhcmR3YXJlIHRo
YXQgSW50ZWwgaGFzIGRvY3VtZW50ZWQgYXMgdW5pbXBhY3RlZC4NCg0KTm93LCB0aGUgY291bnRl
ciBmb3IgdGhhdCBpcyB0aGF0IHdl4oCZcmUgYWxzbyBsb29raW5nIGF0IEJISV9DVFJMDQppbiB0
aGUga2VybmVsIGNvZGUsIGJ1dCBhcyB0aGUgY29tbWl0IG1zZyBub3RlZCwgdGhhdCBkaWRu4oCZ
dCBhcHBlYXINCmluIFFFTVUgYXQgbGVhc3QgdW50aWwgOS4yLCB3aGljaCBpcyBzdGlsbCBmYWly
bHkgcmVjZW50IGNvZGUuIEV2ZW4NCnRoZW4sIGl0IHdvdWxkIHN0aWxsIGhhdmUgdG8gYmUgY29u
ZmlndXJlZCBhcyBwYXJ0IG9mIHRoZSB2aXJ0IHN0YWNrDQphbmQgaXNu4oCZdCBhbiDigJxhdXRv
bWF0aWPigJ0gZ2l2ZW4ganVzdCBib290aW5nIGEgU1BSIG1vZGVsIFZNIG9uIGENClNQUisrIGhv
c3Qgd2l0aCB0aGUgZml4ZWQgdXAgUUVNVS4NCg0KVGhlIGVudGlyZSBwb2ludCAoYXQgbGVhc3Qg
dGhhdCBJIGNhbiBmaWd1cmUgZnJvbSB0aGUgZG9jcyBhbmQgb3JpZ2luYWwNCmNvbW1pdCkgb2Yg
aGF2aW5nIHRoZSBkZWZhdWx0IGVuYWJsZW1lbnQgaXMgdGhhdCBpbiB0aGUgbWlncmF0aW9uDQpw
b29sIHNjZW5hcmlvIHRoYXQgSW50ZWwgaGFzIGRvY3VtZW50ZWQsIHdoZXJlIGp1c3QgbG9va2lu
ZyBhdA0KZUlCUlMgZW5hYmxlbWVudCB3b3VsZG7igJl0IGJlIHN1ZmZpY2llbnQgYmVjYXVzZSBp
dCB3b3VsZCBiZQ0KcG9zc2libGUgYSBndWVzdCB3aXRoICpvbmx5KiBlSUJSUywgZXZlbiB3aGVu
IHN0YXJ0ZWQgb24gU1BSLA0KdG8gYmUgY29uZmlndXJlZCBpbiBzdWNoIGEgd2F5IHdoZXJlIGl0
IGRpZG7igJl0IGhhdmUgYW55IFNQUisrDQpmZWF0dXJlcywgYW5kIHRoZW4gYmUgbWlncmF0ZWQg
dG8gYW4gaW1wYWN0ZWQgKGUuZy4gSUNYKSBob3N0DQphdCBhIGxhdGVyIHBvaW50Lg0KDQpEaXN0
cm9zIGNhbiBhY2NvbXBsaXNoIHRoZSBleGFjdCBzYW1lIHRoaW5nIGluIHRoZSBndWVzdCwgd2l0
aG91dA0KVk1NIG1vZGlmaWNhdGlvbnMgYnkgc2ltcGx5IGxvb2tpbmcgYXQgc29tZXRoaW5nIHRo
YXQgaXMgZXhjbHVzaXZlIHRvDQpTUFIrKywgYW5kIGtub3cgdGhhdCBhbnkgc2FuZSBWTU0gd291
bGQgbm90IChvciBjb3VsZCBub3QpDQphbGxvdyBhIGd1ZXN0IHdpdGggaGlnaGVyIGxldmVsIGZl
YXR1cmVzIGFjdGl2ZSB0byBtaWdyYXRlIHRvIGEgbG93ZXINCmxldmVsIGhvc3QuDQoNClRoYXQg
YWxsIHNhaWQsIHRoYXQgaXMgbm90IHdoYXQgaW5kaXJlY3QtdGFyZ2V0LXNlbGVjdGlvbi5yc3Qg
c2F5cy4NClRoZSBkb2NzIHNheXMgdGhhdCB0aGUgcmVhc29uIHdoeSB0aGlzIGlzIG9uIGJ5IGRl
ZmF1bHQgaXM6DQoJQWxsIGd1ZXN0cyBkZXBsb3kgSVRTIG1pdGlnYXRpb24gYnkgZGVmYXVsdCwg
aXJyZXNwZWN0aXZlIG9mDQoJZUlCUlMgZW51bWVyYXRpb24gYW5kIEZhbWlseS9Nb2RlbCBvZiB0
aGUgZ3Vlc3QuIFRoaXMgaXMNCgliZWNhdXNlIGVJQlJTIGZlYXR1cmUgY291bGQgYmUgaGlkZGVu
IGZyb20gYSBndWVzdC4NCg0KVXNpbmcgdGhhdCBkb2N1bWVudGF0aW9uIHRvIGltcHJvdmUgbXkg
YXBwcm9hY2gsIGhvdyBhYm91dA0KdGhpcyBpbnN0ZWFkLCB3aGVyZSBBKSB3ZSBoYXZlIGJldHRl
ciBjb2RlIGNvbW1lbnRzIGFuZCBCKSB3ZQ0KYWxzbyBjaGVjayBlSUJSUyBlbmFibGVtZW50PyAN
Cg0Kc3RhdGljIGJvb2wgX19pbml0IHZ1bG5lcmFibGVfdG9faXRzKHU2NCB4ODZfYXJjaF9jYXBf
bXNyKQ0Kew0KLi4uDQoJLyoNCgkgKiBTb21lIGh5cGVydmlzb3JzIGRvIG5vdCBleHBvc2UgSVRT
X05PIG9yIEJISV9DVFJMIHRvIGd1ZXN0cy4NCgkgKiBXZSBjYW4gbmV2ZXJ0aGVsZXNzIGluZmVy
IHRoYXQgdGhlIHVuZGVybHlpbmcgQ1BVIGlzIHVuYWZmZWN0ZWQNCgkgKiBieSBjaGVja2luZyBm
b3Igb3RoZXIgZmVhdHVyZXMgdGhhdCBvbmx5IGV4aXN0IG9uIHVuYWZmZWN0ZWQNCgkgKiBoYXJk
d2FyZSBhbmQgYnkgcmVxdWlyaW5nIHRoYXQgZUlCUlMgaXMgcHJlc2VudGVkIHRvIHRoZSBndWVz
dC4NCgkgKiBJZiB0aGVzZSBjb25kaXRpb25zIGFyZSBtZXQsIHRoZSBoeXBlcnZpc29yIGNhbm5v
dCBtaWdyYXRlIHRoZQ0KCSAqIGd1ZXN0IHRvIHZ1bG5lcmFibGUgaGFyZHdhcmUgd2l0aG91dCBj
aGFuZ2luZyB0aGUgYWR2ZXJ0aXNlZA0KCSAqIGZlYXR1cmUgc2V0LiBVc2UgYnVzIGxvY2sgZGV0
ZWN0aW9uIChpbnRyb2R1Y2VkIG9uIFNhcHBoaXJlDQoJICogUmFwaWRzKSBhcyBzdWNoIGEgcHJv
eHkgZmVhdHVyZS4gVGhpcyBpcyBhbiBpbnRlbnRpb25hbA0KCSAqIHdvcmthcm91bmQgZm9yIG5v
bi11cGdyYWRlZCBoeXBlcnZpc29ycyB0byBhdm9pZCB1bm5lY2Vzc2FyeQ0KCSAqIHBlcmZvcm1h
bmNlIHJlZ3Jlc3Npb25zIG9uIHN5c3RlbXMgdGhhdCBhcmUgbm90IHZ1bG5lcmFibGUuDQoJICov
DQoJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IWVBFUlZJU09SKSAmJg0KCQl4ODZfYXJj
aF9jYXBfbXNyICYgQVJDSF9DQVBfSUJSU19BTEwgJiYNCgkJIWJvb3RfY3B1X2hhcyhYODZfRkVB
VFVSRV9CVVNfTE9DS19ERVRFQ1QpKQ0KCQlyZXR1cm4gZmFsc2U7DQoJDQoJLyoNCgkgKiBJZiBh
IFZNTSBkaWQgbm90IGV4cG9zZSBJVFNfTk8gYW5kIGRvZXMgbm90IGV4cG9zZSBlSUJSUyBvcg0K
CSAqIG90aGVyIGltbXVuaXR5IGJpdHMsIGFzc3VtZSB0aGF0IGEgZ3Vlc3QgY291bGQgYmUgcnVu
bmluZyBvbg0KCSAqIGEgdnVsbmVyYWJsZSBoYXJkd2FyZSBvciBtYXkgbWlncmF0ZSB0byBzdWNo
IGhhcmR3YXJlLg0KCSAqLw0KCWlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNP
UikpDQoJCXJldHVybiB0cnVlOw0KLi4uDQp9

