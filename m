Return-Path: <linux-kernel+bounces-727061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D85B01484
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C291755A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837A71F239B;
	Fri, 11 Jul 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="dDwm8N/7"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2118.outbound.protection.outlook.com [40.107.241.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63331E834C;
	Fri, 11 Jul 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218710; cv=fail; b=g8krzo5Va4QaYyJVotta8kV/iqV15jiTjE5sLuD9I6RUIQmSI0UCvpxNkzSdVMbRSlYweMp4RIemy43LkYKJVJVaVAMW4ZyQtJNACFxmBO3t9NoFi+Paus3AUaDqX50iJj6V8cFjvD10Q3l/H8g/+DcP25VFON7oawyjSLT7F2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218710; c=relaxed/simple;
	bh=zTjPcDIzXUPqElJtRU0G5W2+WS0HrizGme+i98uuQuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=koDYspeXdb362/M+yHFVfgbASTg6LGwTjVy2EYMArx5xmwVpPS66nsoH2lcC3UWkwbxIltH3Goj86kiiZLw/qUaTK/dDsB6XExDgIgrUiIC/vD4Irvq/j28kLUH3KKsvN9ukmnMiZS/+kXs5URtC9DIEQcs34+u+sFGy4Ti4TT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=dDwm8N/7; arc=fail smtp.client-ip=40.107.241.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSgF90AK9ESX0x1GRoj2SoB+WThbiCbinah8eREc5NK1lg3KfSoycmptWa5OLKEeDiIv+Wx2kARtId4fDJByT95dgRgbfxd2TxrVy3Zj1Hfs4aakB6HpEJjzcGNZY6pU+knouaOhe+5N6yX0A1iur2V4LI794YXeMR2Dtn0JQgqpxGoqKRzjHecDd/jZUU1uVM4twz7QqTtOmv/D1iCZFJ6aDaXLsrwghAouhVci87gRzGH34oDW+Ff43gLB/zhDIr5mxD+En8SEjFvTsbvnmc+zc1bVjmX5MgZeD+wyEIQy4SBwuSPYNG1dMy9mgASTL9n+u+6mrknaLcZTrYp3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTjPcDIzXUPqElJtRU0G5W2+WS0HrizGme+i98uuQuc=;
 b=fPk/ymqwsQvO2SrAiv5OsGDbQx8aRPmT6SNk3y7oVeq1Z8fJq3vg6a4IYcIt1NGJQ/lyVXawit9LDn8dp93+CAoQ3itfCSjylgdladzcj2IaLKEyPM1mBUs/WkB1y1pw6gUCylr+Mc3H40/3HrSmWzITpXFARvGOMpPvi1oNqA8KU+vZEZN5DU029/7Su51w1s4lxd94RLCJdTwe3Axh/SwVN6zXu6Xb4Uy7Vs8e5JR7ousZMeLQRVb+/d6vGwVs26BAyYCNFQjlq/V+A2eB4PcB+EodCgRinacuHtLBWfVIScg9kjyutJl1T/TOvK72kt3BvfhJy5Yt7StPFxydjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.fr; dmarc=pass action=none header.from=phytec.fr;
 dkim=pass header.d=phytec.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTjPcDIzXUPqElJtRU0G5W2+WS0HrizGme+i98uuQuc=;
 b=dDwm8N/7ioFjSqzPiz7nNDkXep1C5NQfhZZwy0lSaayPKQeJqLkQa/9MO4+w1OFFegO0Y1h6P9UD6QsvcxPVRq++KgPBqsNa2Q1+opnzETLJmlIFFitIHe7+80/z8OOB718OkIxVGMQEqGaoJ4K5y1+ko0+hRFP7JLmSUS+clDk=
Received: from DU0P195MB2197.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:472::20)
 by AS4P195MB1573.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 07:25:01 +0000
Received: from DU0P195MB2197.EURP195.PROD.OUTLOOK.COM
 ([fe80::59ab:3743:c2e2:6e2d]) by DU0P195MB2197.EURP195.PROD.OUTLOOK.COM
 ([fe80::59ab:3743:c2e2:6e2d%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 07:25:01 +0000
From: Christophe Parant <C.Parant@phytec.fr>
To: "robh@kernel.org" <robh@kernel.org>
CC: "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: arm: stm32: Modify STM32MP15x
 Phytec board items types
Thread-Topic: [PATCH v2 03/11] dt-bindings: arm: stm32: Modify STM32MP15x
 Phytec board items types
Thread-Index: AQHb8emQFwnxYW5KDUWWiAmG1WfyVbQshf8A
Date: Fri, 11 Jul 2025 07:25:00 +0000
Message-ID: <576c1a468539b89f99c0fb33b7b7dbf9b27fa1cb.camel@phytec.fr>
References: <20250709151011.366537-1-c.parant@phytec.fr>
	 <20250709151011.366537-4-c.parant@phytec.fr>
	 <20250710222527.GA4171977-robh@kernel.org>
In-Reply-To: <20250710222527.GA4171977-robh@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P195MB2197:EE_|AS4P195MB1573:EE_
x-ms-office365-filtering-correlation-id: 5bde1762-fdc1-4e41-5da8-08ddc04c0c2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODNUK3lLM2lkSmRzc3M3UjVDbHFETHg5QnpucUFDMTNMMG9iWmtDblo2Rkpm?=
 =?utf-8?B?ZU5VclI1QWtMOGFOY05HS3Y5bVV0VldkN3B2NStDaTJIak80VTNtUkJMQnZ6?=
 =?utf-8?B?cGYrRTVTbU1CZTdySTFINXpEZWJrNXhFeC94WDJ0bWZNUmlEWjJvZ09ZbnFU?=
 =?utf-8?B?dk9TRkdibkZYQ095d2tqSmFiTHdLRlFER09zUGduSVNJZWRKOUxFNDYxYTJK?=
 =?utf-8?B?dGowWEl4WEpaNEowSmR5Q1pZeE8xVEdGVTUrVm1EU3JXb1Y5VlpWK05tdTBO?=
 =?utf-8?B?ZHhHVTBxL0h2TUVVMmpOaFRTNXR1Z2wzODE0WE4xSGtac01IbVVsSkJYVGor?=
 =?utf-8?B?MGN4STI2a1hJNTFsV2dQWFdZT3Y1TzV1d05xaXpWTTJac01EbUliL0JjYTBz?=
 =?utf-8?B?SVRrWExMRGJXdmRtSFVZUjlBaFpxSHZ0UTFBSjBxMGdtMXZjUFdCWHRvVGMr?=
 =?utf-8?B?RVViL2NzZVFmWnp0QWRaOXNPd2NGQ2toT3ZrTW1zUmpUdlo4QjJIKzRjM2VP?=
 =?utf-8?B?dGxVVnVXOFNneDZwbGYyUXFJNmlZWHVQNDluMGxQRFErZ2pqSWFuYVVVZmll?=
 =?utf-8?B?ams5YjJSNUdVWG1xYXN2WnMzUG1DTXhEellzUmRxL2hRSUIwY2RGbWFpTGEv?=
 =?utf-8?B?SFAvTm5JUjlYNEgrNUw1UEh0K21kN2w3T3ZhWEcwYk9RbCtnM0JKaGJtWWlI?=
 =?utf-8?B?VklXSUN3UkM5OXdFeGdNbUFFeElqOHhGUGkzQVFVL2w4THRoOWs1ZjBwRHF0?=
 =?utf-8?B?L3o4d2VBdEY1UVJpa2MwNGZGRmNJcUtJdFYwVmNlc3l0UjNMZXZuS3Z4ZW9P?=
 =?utf-8?B?Vms2K0M0bTNWQzhuWTgzY0Y2WUUvRS9WaDZ4OVU1R0NTUEExZ3lqNVY1QmRx?=
 =?utf-8?B?N3RjNWloL2J2TkxQamFUMlJVTmMvbVpMdnJUaGhKb21nQldlUUhmdVNPWE9z?=
 =?utf-8?B?MmgvMy9HeWlOZ1RDeVNCaUZON1pYbWpCdFZPQy8zRnRGdkFUSFZtUGdNY0oy?=
 =?utf-8?B?Q3dHSi9aMXF6Y1dhUHMyZjRUM0JNYVV1dUk0dnAwelNhUDhCT3VacWd0aDBG?=
 =?utf-8?B?STIxS1pLdWwzOFZ1blhuUVVFcS9aTnAya3FHdnJDUHBLTEhPbHAzdW52bmlP?=
 =?utf-8?B?QmtXK3ZTOU1Mekcwd3ZkOTJjNjZyYS9DcWtrdEZHbFBVQ3lGSDRVZFJWUDkv?=
 =?utf-8?B?NitUN24wd1REUm12YWVkU0JNZVl4U1FTbks1THE3ZitjanlaSVFWakp3WU82?=
 =?utf-8?B?Zk40NWphQ0NNamc2TWh4Qkl6ZXBTbWg3bTljWU9DYks3ZXRqZ085ZVhJWmdk?=
 =?utf-8?B?Q250bDBOU21GT1RMekszelVRM0RjdVg1NWdoblVzeFFHL09YVmJuQUhwMUhW?=
 =?utf-8?B?WjFDV3U2S2cyL1RCcWtTeWQ0SXJ5RVpLcmlnL2pFNlN6amt3UERadW5OY0VY?=
 =?utf-8?B?bTVmNDZyRFE5alBwUUdjUUJ0dDFWMkJSbEhRbmtWUFJLQ1pZOVlwanZsN09j?=
 =?utf-8?B?V05JcGdXTTE0d0dYbVMwdTQwT3NZVFpSN3FUNDRUcWhRWjRKZmNWY0VpUFhR?=
 =?utf-8?B?dDk5ZjUvNUx4RTVtT0ZheGxuL0VPWmd3NGlXc2p2c2ZycDkraVd6M0RzSU04?=
 =?utf-8?B?ZGZHTUI2NDU0bDhMQ0tiNTR1VE1lazVVTFo3T0s2K0RtUjF0cGV4alVqc1Fl?=
 =?utf-8?B?UTUxREc3Y2R6djQ2b3MxbGZoY2NyaDhib2phTVFwVXg2aTgrajlQczV0WEE4?=
 =?utf-8?B?b3RwczhOKzF1VFhOckRicVFrcW05K0pVcFppLy9MWEZ3UGU5RXg0OFFWeEYv?=
 =?utf-8?B?R2h0Y3hmMGQ2clhFNEFvM2JBekI0cXZMQ2VjSGFSc3k1bEMwZjIwTTBPYVNq?=
 =?utf-8?B?OTJTcXpwcnNxZlpDMk9zZ0VlR1Y3RU1QSTljOWs1QzNZUFVDUjZEb24zRWE5?=
 =?utf-8?B?clMwREQ1MWZIeXZuWHA4N2UyNEdTN0dlZHY0UUlPUWZSL29GSGk0TlVxVERL?=
 =?utf-8?Q?0eQDkFD2VXIYXVKUhKUIfhcVGWQxHw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P195MB2197.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTlTZHZBd28rUzgxYytWL1IwM0ljaHVDR1FZSFlKdG9YakpINnQ3VHJ6YlNh?=
 =?utf-8?B?WUNqVlNKak9ieGpVVHFNNzIwY29nREplS2ZHOVdjWTJEZGxaaG1HTkRJdmZQ?=
 =?utf-8?B?RmJhc1JnS0ZKNDhHNGtIRlBTSmsrQ0xzSTNFZ3kwdWV3T2hrT0w5aU1DM2NC?=
 =?utf-8?B?VGlVZHROaXpMNlI4RHpLd0Q4NnRBNGJQU1IyaXVaVzQ2OG5Pb0lIc1NCU2FE?=
 =?utf-8?B?OFBCZlQrdDhtYXVFY0VkeS9yeENVYXNqRVpPYWc2MDFCajhDQzJkMVpPOXVW?=
 =?utf-8?B?c0JucmV5YXZwWDZhd3R3V1dYZTd1eG53S0NQK1NSZnpoOVdnT2NRWVhPeWlZ?=
 =?utf-8?B?SmZuQloyZFpCVVo0K0k4aWFBczVhcWlUcTZSakNTSzJYeWpHcDdBUWM2dGc5?=
 =?utf-8?B?Qm0xSFNpa0k5dTV5Mlh2Q0FNazIvemZKY1F4czkwcVpYM2s4Wm5Pcmw5OXlZ?=
 =?utf-8?B?dThCc3FsYW9kSGFHaVpZd3BwMGNOV0gvWitvRFV5eEgzLzh2ZnI1Zk9HNDJq?=
 =?utf-8?B?QTd4YzZvNHU5cVc5SGpGbTR6bUF0c3BGb1FCYXBwOGJmVVB4TXhJTlE0dTds?=
 =?utf-8?B?N0lCUUgwa0w2UlU3Y2RhSDcrQmxKRVR6MXBSYmVvN2hjQThIeHhPK0hkTlp3?=
 =?utf-8?B?UUVuU3lkUGNabnZ5WkVCMTIyVGpkWXZ1ZzFYNXoxVFBmOUFsK251Mi9wYjl5?=
 =?utf-8?B?MDVBYlZzdVRCakxEUENURGc5N1lXTFhyNmMyamtyakJNaFV0UHl5VEV6L0t4?=
 =?utf-8?B?U2FPU0tJOXFDVGRuWGhjZEdUZzFsbDlzajlDQ1lrT1F0UUp1bEd5SEd1bzRr?=
 =?utf-8?B?ZGl3d2ZiNXR0VVhXdms1b3NIK0tPMTNqNG8rc3VENWk0R2x4UE9kUUhoZVJs?=
 =?utf-8?B?d1NHWlM2S3k5N2ZWdFl6NEMvYWV6cGs4NFd1WG9FZ1JNYkVoVXBFaStSY2o0?=
 =?utf-8?B?WDM0RzNSS2ZxSURxeHI1MDZ4MFhVbFpQNy9ZYmZBeHJBNEhWL09YSXlYaW1R?=
 =?utf-8?B?dzFra1lFc0EyZndScmZQNG5xY25TbGRNL1pCdDhBVGNVODQxdW1lUFU5dSs0?=
 =?utf-8?B?OVhyOHdwbmhkbytwRWt1Smo1cHVocGRxNE9XSXZYTlovMjJmRFpMb29UUVJC?=
 =?utf-8?B?UjhuUzhTaTZEeHY2SktmKzBiNFI5ZGd0MTRHMFFNNE9QSWNyZFdzaFBwZDFN?=
 =?utf-8?B?Y2RVSWd1c0RvRThTa0xHYWswSmMrWkdlTmtMSk91N1JCdVBtZVJkeHh5MzBI?=
 =?utf-8?B?Y0dRMlZMVzVGZDh5S1lqQ3g2SmgwT2xpazhKcWg3YkVmRE9hcGZ3c2d5RUs3?=
 =?utf-8?B?N3UwZ0MwTkdvSE9kSyticnBaOElhVWErcHFDR2xzampwNUZoYjU4L01vTU5j?=
 =?utf-8?B?aG1jNXY0T3V6bmU0QmdJbkdQRXpjdndXL1hqSWpoajAzWlJEUnE4S2ZzYTRr?=
 =?utf-8?B?VU85eFpCbmEvbkt4RjEvc3VPbWdBTy9NaE1aVEV2RGlldHU4T01ueWNsTVk4?=
 =?utf-8?B?VVliRlIvbTJTT280Y1ZxVXdqUHd3RmZ3c1V0YUVibUpHWTV0Q1RIdjRrRWVW?=
 =?utf-8?B?VG5QN3hJNEw2czlDSVAvcjdBdUM2Tnc3VXRTWFE5ekR5dWdkZjZLU1B3QkNZ?=
 =?utf-8?B?RjRhWjFRQVpESnZicExNbU1YbHQ5dVV4UStXeW51R0JMcEFNZ2dEUzVZZkx3?=
 =?utf-8?B?MnpLZWdJZ3lzYXhDREgyV0c0Tzg0OS9SNXRwL0FwSFRkemw3bnVndENyY2ZX?=
 =?utf-8?B?eSsvZW1vLys5U0czSFpYcmxaZXM5RU92NFZCU2lDcUFqOUhuMHVkcEpHYjcv?=
 =?utf-8?B?U2JSaUpCVXZoNEdpaW0vQlFEdUxma1BYN3lia0ErbXhnWHQxSm9QOWk4VDM3?=
 =?utf-8?B?VE1kN25IT1d0NVBlV25ySytTenRMbytrSXpQNTZqWlFWNGxRdm1hV29iNzJl?=
 =?utf-8?B?L1lqMjRuRjc4WEJmTWNieTBseGNxSmJyc00rK1U4Z0ZDVXNobU91b05vaVJU?=
 =?utf-8?B?RE8zWGFybHZEV2h2RVJvS3Jod0c0bmdYenVNbWpWeGdqZWpvaVc4YnRvWGNp?=
 =?utf-8?B?LzBteWdkQkl1QWJlVTZEd1JPUHhBU0FlTVloTncxdklPWVBoQzNOK0Z3dVZp?=
 =?utf-8?B?Q0p3Q24ydjhFd0JBV2Z4dVJ0SDBKcndqcEpCWm1jVTkrSjV3di80NFFFNnJ0?=
 =?utf-8?Q?p9bgVA2qDAPhwdQzrZZRHXjRKrH5Zj/kYtN6YSNUyeuS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A84B5118EB444744B4003F47D35A850C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P195MB2197.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bde1762-fdc1-4e41-5da8-08ddc04c0c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 07:25:01.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBmsNEw5MwfHo99UafFInSnCmQ2Q63thbtxhHPSkTw3AOTLVm1QFY35qvxEdtXMiFyoJo8j8n0famxFqI0l8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1573

SGVsbG8gUm9iLA0KDQpMZSBqZXVkaSAxMCBqdWlsbGV0IDIwMjUgw6AgMTc6MjUgLTA1MDAsIFJv
YiBIZXJyaW5nIGEgw6ljcml0wqA6DQo+IE9uIFdlZCwgSnVsIDA5LCAyMDI1IGF0IDA1OjEwOjAz
UE0gKzAyMDAsIENocmlzdG9waGUgUGFyYW50IHdyb3RlOg0KPiA+IEFzIFBoeXRlYyBtYW5hZ2Vz
IGRpZmZlcmVudCBTb00gY29uZmlndXJhdGlvbnMgd2l0aCBkaWZmZXJlbnQNCj4gPiBTVE0zMk1Q
MTUNCj4gPiBTb0MgdmVyc2lvbnMsIG1vZGlmeSB0aGUgcGh5Qk9BUkQgYW5kIFNvTSBjb21wYXRp
YmxlIGl0ZW1zIHRvDQo+ID4gImVudW0iDQo+ID4gaW5zdGVhZCBvZiAiY29uc3QiLg0KPiA+IFRo
ZSBkZXNjcmlwdGlvbiBjb25jZXJucyBQSFlURUMgU29NIGVxdWlwcGVkIHdpdGggU1RNMzJNUDE1
Nw0KPiA+ICgic3Qsc3RtMzJtcDE1NyIgaXMgImNvbnN0IikuDQo+ID4gQWxzbyBhZGQgY29tbWVu
dHMgaW4gZnJvbnQgb2YgdGhlIGVudW0gaXRlbXMgdG8gYmUgYWJsZSB0byBpZGVudGlmeQ0KPiA+
IHRoZQ0KPiA+IGNvbXBhdGlibGUgc3RyaW5nIHdpdGggdGhlIHBoeUJPQVJEL3BoeUNPUkUgbmFt
ZXMuDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHBvaW50IG9mIHRoaXMgcGF0Y2guDQo+
IA0KVGhhbmsgeW91ciBmb3IgeW91ciBmZWVkYmFjay4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waGUgUGFyYW50IDxjLnBhcmFudEBwaHl0ZWMuZnI+DQo+ID4gLS0tDQo+ID4gwqBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0bTMyL3N0bTMyLnlhbWwgfCA4ICsr
KysrLS0NCj4gPiAtDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL3N0bTMyL3N0bTMyLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vc3RtMzIvc3RtMzIueWFtbA0KPiA+IGluZGV4IDQwODUzMjUw
NGEyNC4uZmJkM2QzNjRjMWY3IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vc3RtMzIvc3RtMzIueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vc3RtMzIvc3RtMzIueWFtbA0KPiA+IEBAIC0xODIs
MTAgKzE4MiwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29u
c3Q6IHNlZWVkLHN0bTMybXAxNTdjLW9keXNzZXktc29tDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLSBjb25zdDogc3Qsc3RtMzJtcDE1Nw0KPiA+IMKgDQo+ID4gLcKgwqDCoMKgwqAgLSBkZXNj
cmlwdGlvbjogUGh5dGVjIFNUTTMyTVAxIFNvTSBiYXNlZCBCb2FyZHMNCj4gPiArwqDCoMKgwqDC
oCAtIGRlc2NyaXB0aW9uOiBQaHl0ZWMgU1RNMzJNUDE1NyBTb00gYmFzZWQgQm9hcmRzDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoCBpdGVtczoNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6
IHBoeXRlYyxwaHljb3JlLXN0bTMybXAxLTMNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29u
c3Q6IHBoeXRlYyxwaHljb3JlLXN0bTMybXAxNTdjLXNvbQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgLSBlbnVtOg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHBoeXRlYyxwaHlj
b3JlLXN0bTMybXAxLTMgIyBwaHlCT0FSRC1TYXJnYXMgd2l0aA0KPiA+IHBoeUNPUkUtU1RNMzJN
UDE1N0MgU29NDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCAtIGVudW06DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC0gcGh5dGVjLHBoeWNvcmUtc3RtMzJtcDE1N2Mtc29tICMgcGh5
Q09SRS0NCj4gPiBTVE0zMk1QMTU3QyBTb00NCj4gDQo+IEFyZSB5b3UgZ29pbmcgdG8gYWRkIG1v
cmUgZW50cmllcyB0byB0aGUgZW51bXM/IFdvdWxkbid0IHRob3NlIGJlIGEgDQo+IGRpZmZlcmVu
dCBTb0MgYW5kIGEgd2hvbGUgb3RoZXIgJ2l0ZW1zJyBsaXN0IGJlY2F1c2UgaXQgd291bGRuJ3Qg
YmUNCj4gdGhlIA0KPiAxNTcgU29DPw0KPiANClllcywgaGVyZSB3ZSB3b3VsZCBhbHNvIGxpa2Ug
dG8gYWRkIG91ciAicGh5Y29yZS1zdG0zMm1wMS00IiB3aGljaCBpcw0KZXF1aXBwZWQgd2l0aCB0
aGUgIkYiIHZlcnNpb24gb2Ygc3RtMzJtcDE1NzogInN0bTMybXAxNTdmIiAod2hpY2ggaXMNCmFu
b3RoZXIgYm9hcmQgZGV2aWNlIHRyZWUpLg0KQnV0IGRpZG4ndCB3YW50IHRvIGFkZCBpdCBub3cg
aW4gdGhpcyBwYXRjaCBzZXJpZXMuDQpXZSBhbHNvIGhhdmUgInBoeWNvcmUtc3RtMzJtcDEtNiIg
d2hpY2ggaXMgZXF1aXBwZWQgd2l0aCAic3RtMzJtcDE1M2EiLg0KVGhlIGlkZWEgd2FzIHRvIGtl
ZXAgdGhpcyBEZXNjcmlwdGlvbiBzZWN0aW9uIGZvciB0aGUgInN0LHN0bTMybXAxNTciDQooY29u
c3QgaXRlbXMpIGFuZCB3b3VsZCBuZWVkIGFub3RoZXIgc2VjdGlvbiBmb3IgdGhlICJzdCxzdG0z
Mm1wMTNhIi4NCg0KQmVzdCBSZWdhcmRzLA0KQ2hyaXN0b3BoZQ0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC0gY29uc3Q6IHN0LHN0bTMybXAxNTcNCj4gPiDCoA0KPiA+IMKgwqDCoMKgwqDCoCAt
IGRlc2NyaXB0aW9uOiBVbHRyYXRyb25payBTVE0zMk1QMSBTQkMgYmFzZWQgQm9hcmRzDQo+ID4g
LS0gDQo+ID4gMi4zNC4xDQo+ID4gDQo=

