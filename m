Return-Path: <linux-kernel+bounces-874163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840FC15A69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8887A3BA91D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285F342CB0;
	Tue, 28 Oct 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cknRZfDl"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021088.outbound.protection.outlook.com [40.107.192.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FC340A6D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667061; cv=fail; b=kPzkz57GJUUCerZRT2878OcWe5KdqAUsfPPPMilER68AMEzo81LEWc29F42tejPnx2Z8WEUUmJDuLFTOusP3aWiTkwO+jLWD3a08N8pd+3dCG8MqxUDxRmBFBfHOpaxm2vuoF68Wfl9ZygInCCfpckcKovRnKiROp5vYlgYh1LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667061; c=relaxed/simple;
	bh=8ZZrclI9tTMHYZ2DWm9/rluHMsBS51dBlBKp2M2BNQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hKvceZvTSYuN4qBtR2TgZAsGPO/2g+nYEICYqHj8MSGWJxWL4QIANLTsQ/HBc82wiVLSneJE+0LDyi2qhkX1wSm7nMSewpjnkP2aj/yaqwfnPNsCuqcsPcMx0rWvYPWF8dLadGN//ymYjrtyb3RdMQYXeL8Juqi+MqbawN8gnhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cknRZfDl; arc=fail smtp.client-ip=40.107.192.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ9wOYo9gGj2vu+vqZI7V/ER3DlrnPffTtmonHSUt2y2RfTm7scneTO/bwrslceiwRfkvzdr70K9HInp9U5hbvBLM3kiqVzLOe1U6Kdvsl40gaZaOb+bJr9/Uf9+DvxB7AIM4wE+TtagXHRqPX3VK/jqlNQWU2z0yfRNKJxoZV+CtlVe/mlGRpQ+y1UhCucv8jKSzPus210JHYJ4YLeLJXnlanx9kuaxsjrejwcjhTrh7GOrboGZxzexIu3byOc0AF11Z3OFDxjgu/F6kCFteuLlG3nTK2xcgwPjXWmjQRuZKxbvRwJjY66p7kbSv+4cYUDf0/saucGv7GV3a5fNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6EqojRNLNo0Z8jH59kgAndEk0WuiVxcmh/szM2uosg=;
 b=TN6xb338MuNf/msL5OPsC3V4aFqmBAX1hW7txTIXyUfEvxS5C6+FiffIwShshS89MfLCf03JpLZAnioeaB2oCt8GnPww8Bp8mOKRxSoI7syX0D7Z7jFv2z7IGYVQ/wwcEyYi+cnXO+mQwI3H5c/pByKuNwIaR3pEB+vKk5E1VqoqPZu6PM9nk1LuOEtYEYJ1gaLHRklpywlvj+pe+wyBzeWs+hP17iiD72CvgAsynS4CE5f+D8xb0Fnd14fa3CO/C9XluIrBsbRcgY4N/bi1TdkQHGEhLP3jyDSAZ7u9VSBbTbKrfwxP4YAzV7Fu9YbkObeu0kQRBG69qZhLWuv2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6EqojRNLNo0Z8jH59kgAndEk0WuiVxcmh/szM2uosg=;
 b=cknRZfDla3aL27T0z6lnsgnuOZSkr3DBKkHFKdsb9KPoT7gzrn5TF4a1tNzriwLSV15EqIMSfqt2zT0bwJs/IBimNa9nOf5sO6k57/ZzhGvX9l9fmWVmW7v6pmHUYo3BduiM4OGa54tXxtiQVMd+3PbbjBnKdfUMhMEARwD3KEYeAkbKpmJJBRX3uHLkbDquc9M+kyIu8Qcse06hjOm8uavW6Ib8mR69KF/tKOVcoD682r3H9qYfJ+XvWYUcgxjlj8/8/BGJvTSyFI4G4mmB96VBKUoS0LjUOArnPk9pmiRksUAzeDChMM08CgDthBE93jlAFPZPIgnefYyWmkWn1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11271.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 15:57:35 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:57:35 +0000
Message-ID: <097af80d-a05f-4178-a73e-d59a56ad672a@efficios.com>
Date: Tue, 28 Oct 2025 11:57:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 26/31] rseq: Optimize event setting
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.578058898@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084307.578058898@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0417.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d44109-61a2-425f-baa4-08de163ab5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxuTG9zb3V2YnRheVJtMFd6VUF0S3UyMk5QMHFpdHVEQmFQc2lQMXBMKzdz?=
 =?utf-8?B?QkVqMTZYVkcwUCtnQWZQZzJPNGplOVV6Q29CSkJNVlpQaEFNeklseERUTzJK?=
 =?utf-8?B?UHJLT294SWNrTS9uWC9ZanlXRjhKQUFTT2U5VTNScVVjZ3hBYVJpOHU3b0Zu?=
 =?utf-8?B?ZzYzOW5IUG92M0VsVFpYTWVaWDFkSng0RysrVlBXZWQrMEpZanQxL2N1VkVh?=
 =?utf-8?B?Q0MwZW9MRVZ0dkgrVlpqbnlKeXMzbkx1QXRWc3hTZW50Q1pjK0RkN21vbWY3?=
 =?utf-8?B?QmFhZHk3RDdvQVNmTzE3L1hEUzhuSVpQemM2eUh1MXJmRWFNWmFqWjNLMDJQ?=
 =?utf-8?B?TnZPSlhIeDJSb1AwbFFXVkVVczNwTUd3eUJKZlpSSnNXNWY3VU9uVFE0YWdE?=
 =?utf-8?B?RXpwVjRjVHRHWVJ4VEFsZnpVdkFFZk9GMjN6KzUxYkJMMGJySHRhd21MWlRE?=
 =?utf-8?B?Rnc2Y2dxUm0raUhiRG1DOElQNXYyMXhpTVBXdW9jZU5ueksyZGM1TFZYaUEx?=
 =?utf-8?B?NEk4dElIU0xwcXZYSDBIMUN1Z25yTEZTRG12RWJES3ozUVNsaWFEQStOSWp1?=
 =?utf-8?B?WnpiaHZzb3N2dXpPb2d0UVNBdk9DNWY4ZkswbE11WFRZL2hBSWM2QktrSzBi?=
 =?utf-8?B?MWQzZTR0OVdKb0xnRS82alh6SnZROTd3NU9NVGZGK0JsNDdoK0VNanZMdFRn?=
 =?utf-8?B?S0FXaUtBd0VaZjgrUzFLV01OMXVKZkpheHRqUWNPN3RiWGtVRFJKRjYzdUpD?=
 =?utf-8?B?RkJPL25aNWtpcG1qWHcrYTA5MHlPSjF3TysxR1ppeEdqekdZUmN1dGcwTFp3?=
 =?utf-8?B?eEpvRElmY0tPUUJwOEp0cElIZVNaV0RMMGVhWVgxWTVoa2paVUJDM1dDVGJE?=
 =?utf-8?B?Y1B6OWhlSlN0YmNzdVdKTERXMVpDc2xhdit6M0lKd1RyMk05NUFPbWFrMFpN?=
 =?utf-8?B?NkRibkRzYzQvOCtObzV2bWMyelZEcEQwS2FmVWFJTGwxZ2VWdFVqc2ozMWFV?=
 =?utf-8?B?RjY0d0RXSER2N0NpbGtzZit3bS8zd0pQME45d09ZL1piWnJJeWhWNlRMVGFD?=
 =?utf-8?B?cU5MVUZidnZQS1ZRbXAyNGxKTmNmbm1xRHBEQkpUTWE5Wit6MDFHWm1RRXNZ?=
 =?utf-8?B?cVZ6M1RaV0xwamJzaXd4dk9KUk9nbHVqbFNkaGtEZDNnUEFXZERHcTdMenFJ?=
 =?utf-8?B?RiswanFYUEFlTG1zb1oxTjlJbjR5REdONkUwVmtwa2ZQL294ckVEVlJHaVdU?=
 =?utf-8?B?cmF0WjkzYitpdFFHWWtGLzBYQk9DYkRPaytaUk5FTWV1bU9Kb0xNY3IzTURs?=
 =?utf-8?B?SVladnJPYVFSenY3WC8wakpSRGd3WFYrOUxOZDBqRGxBVFN0NG93OElwbE40?=
 =?utf-8?B?OHFudlF1bjdSUVBEdHRzbU1UMGE4UjJLOGxKOGJ4S1IxR0dNb2VYQ01Ld1Qv?=
 =?utf-8?B?c29haHIzdzYzYkVTWVVLM0tuKzVNWVBSZDI1M1V0TllWMXZvZUF1TEpjNDhW?=
 =?utf-8?B?aDcwWW92bWpJUmFzMnR2QytsbmZhQk43LytIZkVQQ1RkbWd2Ry9BOTRtY285?=
 =?utf-8?B?UzZUWGcrOWZFNWZJN0FYV2Vkak92ZGowakllcDNPTEVnMXZQc3hQbGFJWFZ2?=
 =?utf-8?B?Y3B1RS9OcVdDNlFFWkVlVnplSXoyNGtqWFN4T2NRS2RpRk80WDhqVkJHK01R?=
 =?utf-8?B?OUxoRGR2YU1NOGx5OFZnbkFtNWozQzdhcFM5ZjJYSUQza29ac0dFUDZ1WXpH?=
 =?utf-8?B?KzQ3Vm9YQmJLMi9rck1EQ3BHTVpZaFhTczhHS0VleS9jMUpQY0NRNEx3SWxz?=
 =?utf-8?B?K3RDMG1TQ1JHRC9iZ0FlMmEyNlRia2lKSks2cWFFa245MjdWejJMeGI1ZTZr?=
 =?utf-8?B?czhDL3c3US9McDJKelhZbzdlaVcyNFV3MjJwNVoxSTZKa2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWtLZG53MUZLSC9oV28wMEJpVWpVUENQemNOeXE0MGtENDdERW8yTXFJb0hX?=
 =?utf-8?B?bzBqTU11bWZla0dYYUlzWmZRcjM1OVFUZEQrM1FMaHlIdzJ1emdtL2E5OXJH?=
 =?utf-8?B?L3RqV3NtZGY0aUlYQlNEYXhsaUE5ZTlMUC9xWW9SOXNZbEJLWHdnNDQyWTdi?=
 =?utf-8?B?U09GVldLM0hJUFJrNWZITUUrK29veDJ0V0RJNUdmM3ovei82NjB1RktiNjBx?=
 =?utf-8?B?TmNtWnl5QzVZT21GRWlsVE44bEcvOUxpZzRjR2FVNXpOdTIzOGJSeFR3UUIw?=
 =?utf-8?B?dUhGSldTa0VkTTMzYm1PTXZ2c25FVXlRQWZ5U2lYdmx3cmlXaUpUbUFRTkF0?=
 =?utf-8?B?dVViL3NvbHN5VUthdDJxdy95MCtERFhTdlA3OVJ4cUlYaEZYRDBsVXBEd3Nx?=
 =?utf-8?B?SVpLRk1MOXBHeW5RVWIxM3Mza081aVNEVkZLQkxWK0ltZHRVdlBKZUNWbzJs?=
 =?utf-8?B?R1hsRDJ4T2JrMU5aTUpPalJqN1lROGttZzBMWGkzc0xzQnNaWXFLUllPUWRK?=
 =?utf-8?B?a2huN1JnVUR2RXpQWnhmSkJMeFRaOUMzU0FjNC9qaVVsbDZYZU5JbnMwZ05J?=
 =?utf-8?B?cThpa1ZmZVc1cFVlWlFaS29OdzI0UEtYR3hXd1FJcmcrS3h3UGhVdU0zY3pT?=
 =?utf-8?B?WThmUmRaaUtMT0N3NnphVEdNc2ROcGx2YVUwc2VpTVRiaEFjQ2cvaHByS0V4?=
 =?utf-8?B?ek94SWN2N3lsbEF6SW45Q3A2cWFBS0tUR2htVUZHajVUNTVtdVBMVmFURDhW?=
 =?utf-8?B?R3g4TTQ5MnJydm80NzRha3Q5TVVqMEZFblVLR2pQM25IRWlPdWlPUldpenhp?=
 =?utf-8?B?dE1lN29GNHVZNUhlTytQT2RqempJRFlwWG1UUWc0dDRUYmRqWGl5d0p3OVJt?=
 =?utf-8?B?a2l1bmNlWlhiYkpDZ0VxNlRnbDhaRmZwR1cvMndsY2xBeHV3K3JzdDF5UE00?=
 =?utf-8?B?RlVaU0l5bjBWbmdFU1grNDBaK2ZneVdCNXh6eXNHQnRCVzYva3R5L3NuSWwz?=
 =?utf-8?B?YkZFUEpycUxWZnRFMzFIUjVyRERwT3VnNXpSamtDaW9haHBJUG5ZVHdDQ04z?=
 =?utf-8?B?VGoyMjBFb2hPMVBkSWUzRHhoeW5pV21yQVF6TGUvRVBkd3kyQkFqY00ydCtC?=
 =?utf-8?B?bUVPSVdHQ2V0QTREQXhaSDMwZ1VFL3FMWVI4Y2w1WHVYdEY5bWkxRnJxRVZ2?=
 =?utf-8?B?K2RaekEwMmNSSmJYV2grY3NhOW9yb3hoWFBzdlhia05oUkhwQkpEcGRMOW9O?=
 =?utf-8?B?TXNQL1BSTUF6eWdpRGdJbXBRdXZETFhzbjlyaTFONklQaEgyc0V2dlM4bVVQ?=
 =?utf-8?B?b3IxZTdrdW9QRWNLUzRaeTRQcXhtTVRKdkNndmNnZEpqNS9ZaXRsRTJmTCtI?=
 =?utf-8?B?V3h0MGRnTlZUVzVZdjlnaU5LaUttZFI5TXZWQnJUWDZjVkF4S2Q2OHRnbEll?=
 =?utf-8?B?OGdOZy9ob0gvUDE2c051eUJGU2hiQnZTMFczT2NpSkFMSDlxLzVDNmVDUlVk?=
 =?utf-8?B?WlFJVTU3ZE11dGwxTjlaUjJsOWVLY0xOeWozQnE1SXpaZVZXVlFVSnJROU12?=
 =?utf-8?B?TWJCM0UxM1QvN3pYSDZoT3JuYVk0dEpxNDd5L010dEtwUGFDMzJVRTVKM0RE?=
 =?utf-8?B?OEtuUGoraUt4cDdKb3A2T2VNTEY4R0lYNTNHbElNSkpKZVVFZ0FKUmIxN05y?=
 =?utf-8?B?MDVyc2V1SEpVdWthb0doY2d5RkJUNGFzejB0amFmY2xIN3FiNWlFQ2dwRkk1?=
 =?utf-8?B?VTJtaVdwamM2OVRCaENrNnkvU2NkMmZQNzZabGowUlo0OUFPdjR4WEFWNC9H?=
 =?utf-8?B?S0xtVnVXRFpwQnVxMGtzRjB0MzZib0hXYXFid21HdFcybmhqMjBicGlPQkhU?=
 =?utf-8?B?cEtvTUVkd00wb2RMVjkyeG9nMDFnb0RJNWlIeXM5SjRERmdTVlpWQXl6ZjZH?=
 =?utf-8?B?dXowZG1KYm1Xd3BYYkVrWmpWSDRwZUpvNi9Oc1NGV0k4OWdDS2xiN09lVG5O?=
 =?utf-8?B?UnhDU2RlVFpVNnhrdmpqNzRwem9WUnN1Z3ZBYWphMU5rUTZaWHFES2Z5a1lF?=
 =?utf-8?B?YytzTnA1L2Z3M1d4ZExLUHc3THRXb3dmU0lBQVdSdHJwZExWWUZFRmw5T3hw?=
 =?utf-8?B?OWFzUlgwMHdSd0xaaExpN3RvOEZHanJBd0ozL3g2WGJyUFllbmxRYzZvQkQv?=
 =?utf-8?Q?//oaEDDCg6ZqoT0cPTvH5po=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d44109-61a2-425f-baa4-08de163ab5da
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:57:35.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgE0pr4fxawq9WVwH4YjBvJttoKao0vmKijaN/Jn1/sGXPCM6mYsPJtnc2JPw8zEoVDuJzeWGlT7rUZhUTqf+7tfWkwhwgaAUh99Ck4RTNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11271

On 2025-10-27 04:45, Thomas Gleixner wrote:
[...]
> Add a event flag, which is set when the CPU or MM CID or both change.

"Add an event flag...".

Other than this nit:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

