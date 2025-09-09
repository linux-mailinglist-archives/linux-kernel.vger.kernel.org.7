Return-Path: <linux-kernel+bounces-808264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B7B4FD48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0E3542D7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD14342CAF;
	Tue,  9 Sep 2025 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="R3snbw0a"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022138.outbound.protection.outlook.com [40.107.193.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7743342C89
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424668; cv=fail; b=KyzIeI+nClIrYHl2cGKBSVltEjBgydNVgOpjIKu2FGWDfGI9dpfNnhUFSLeKx4+9koeIpsHxqOIe7RWlHg50J69B+VcbGRI9YG+M7unnravCXT8U/vKkU8heDzE25JCiHwB0X08JzaB1rraQBqt8UDECDZxByXs/oJQ5CK8Ko5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424668; c=relaxed/simple;
	bh=FKjVfukByLwDTuKB99nMXvJA1l4xgYHJKfu4arGcbJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mQw4bTpUAgHxuNlStAdaLhVymxpXiywNPljJnerPEdBrjw2qd/uV++WJBZEtjSI26a6Vo7V0u24TceYOKmfHrCi53qyNSGqAsCu4atF2nRigcSKqsO1wWyUraDCGVccNVyjhhWdOLpBVV+8vpIsrcLxs8oKRd/DB0vSF90teThU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=R3snbw0a; arc=fail smtp.client-ip=40.107.193.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxFePyVEuuOq1wL/oXLKHu6rofqxXiCYYdL1Z9bpS+AsLOstw1bdbj2CwmlgsjziiXQj11DnibyvKmcvRYdi6ncAfLoRdrKJh4OsoG7qWRPtG5qD1M/inY+kjyVpXgU4DzrwUCE1CBNhff6VK6EeE7YHJhEaJk6zUEeTeRfC38dp5Czfgy/zTWaLVDwrnSMmdaCTsj4oXw6e3tCykj253LYZm5XE6D5UMtepBBJufmJtJTaNYiyLKoDj6UuuNs4rcMPiTB/tCF48JX+MaQ7vXFWVosoBas1Vg/QfLdoUScW7f6KxtWMl+hRvNCbDlD3Wdn3Sq4pLwbC6vYN9mOC4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NniEnLvm8Da/+q20MYAjfid91lkfEGHAvf0/fv2NlE=;
 b=MZBlg3+VZtLwbvw/GbHKK95Q/KpKN9WnFsyL9jMiQvQgA4Z5khcSIcULyAxvVi9Kl+tYpVKA2oH39LyBK7N6IbzLfTaw8qrx95e2+IH2dy+vh9JvPRftWs0Z8bzbeGoWWxNSLpkT4WivP7sn7JGou6sJR5iODZPfDmOYUS8A4U9bMu6hcQAIBqs7v5xUcK0Ny8DnhqWUYiXgkHIDXUdKgOs9S75QiwEQ0PPq4ucgUJNLMd++COFKctg+x8by8/rVBHptEYYBboVUyiSpU6tKebtmfF5dsZCBuMJ1SW/mZLqnW0fOzlCq1WCb15HSnJ2cqyloZXe7s5KUkERjyLWP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NniEnLvm8Da/+q20MYAjfid91lkfEGHAvf0/fv2NlE=;
 b=R3snbw0awM1yeVmvWYnb/2y4OGlK99AMcb3ITVo6QXKgRVdaTAM42BLfsjemMwTmgomjJiO81LnQbMJRgk0lb15N8RQIHMuuBtz9kvVDOpetcAR8Cc4hnx5UvItuKBgtKVuvQpAyyFIhvWNf7RKKxVILTAdiqPNOwYL11a92kKppuQbTcMClNvpUrrP/1c37cD7vdlC014T/lGG9c9DxgKzw72pechgEGUSdFvX9Ca1VP76aWqnIWVBkvuF/sZjC1N25RSeONvxaM0W0Qg9S0H7H1ivKWdXnEZ4ntvyDDu8ikY0fRmjn9uJ+/0+AouaAAoMctneOWcFbnKFAdUirFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10529.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:30:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:30:59 +0000
Message-ID: <4d653cb5-2a1a-4f11-96c4-289976ac8212@efficios.com>
Date: Tue, 9 Sep 2025 09:30:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 09/36] rseq: Introduce struct rseq_data
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212925.841373090@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212925.841373090@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e37222e-c2c8-48b5-fab7-08ddefa51cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWY4cnh3WXU4SVFkSytNVFFNVzZsblhnZ3VJQXRpSHBkd3dCRkdCZFRpT2Vv?=
 =?utf-8?B?YnVDdTJVNnZDQ0o4THNITzdWNTRHSVNWWVlxV0NmbUVNM1pmYXQ1VmNzOWlE?=
 =?utf-8?B?Q2lWVm9VOEFmL3E2Wm0rZllUK0Y4M1IrbWlPNHlZUGZHWWxVSGRVSnFkRUF4?=
 =?utf-8?B?YnlCbmoyVE1YMFRoZWJGbWxYa3dranhQTDNTT2hETkhZbjMrRi9HajBIYmJm?=
 =?utf-8?B?MUtLR2x3TFk3SENrZlhqSmVoRzNRM1JiU0tiY0p4Q3NmanNDeW5RRld6TUx3?=
 =?utf-8?B?bzI1SmhEc2dQb0pCMTIxMmVHR0ExT2dpM05jNFR6QVJ0dTQxM0FpOTZlZHRD?=
 =?utf-8?B?M3lvVHRTejlQVGR6a3pMUzRmNVZ0UVd5bnFoRTloeituM09VZDAxdlFWbjd5?=
 =?utf-8?B?ekkyYXdjZmdjK2FJZytVa1YwQm1oRlU4U2xCdlRWZEg0QUtLMkNLbHJ5dzRu?=
 =?utf-8?B?Vmh6cFZxa2FwSWJIN2NDSHZxNXJkNlFZZDVqWGkrMm9IekNhS2RBUHo5ZFlX?=
 =?utf-8?B?QkJhS3BtdmVKMzJhYkRmdjJvc2JrV2ZueEN6eUd6MHdMWlYrUU54QWFzT0dR?=
 =?utf-8?B?V2VzSGRBWGxtYlM3VUJOS2RLTmtaM2ZhQVNZQVdsN1p4a0VUOG1OTzRsRkpl?=
 =?utf-8?B?aFN2bHRQT1BDQzl4KysreURoTXBZaFZQU2VsZ3hwNjFPQUlmRnNZZVpIZnlj?=
 =?utf-8?B?ODBuNEdQK0ZNVTJPTGRBdTRHMWNDd21KUnZPMjlwYXpLU3VxdGFaY1IwL1pD?=
 =?utf-8?B?UWdaSzFaTXF1d2FDZEgvdHVzWWNzenFtWDF0OEtYQzZpZ1NVM3pqVlBhNlBh?=
 =?utf-8?B?OEhtUUcrMXVlWVhUZXJOU0VDMlJzTnN3RVMxaFVYZ0laekw4Qys1UkVoWFQx?=
 =?utf-8?B?c3BmMks5ejNWYmZTV2JFcnZUd0wzbmtGMlIvSHlJN3RyYlliVk5LaGdFU3dO?=
 =?utf-8?B?cjFxalZZYSt3eXZObnJUVjF1SElvUEJ4Nm5kOTRhOTMzUG42cnVDQ3NwTHpM?=
 =?utf-8?B?VFo5WXJ5K3BDY0oyZ1BiMlY1UnQ4bGJNQkFwMU1kWGF6ZjJZdlcrNzlEbVFu?=
 =?utf-8?B?RWoxMVdnOXk5YnRrVkpnazVKaEE2SVdHVVM4eTJYQ2w4Ukk5MytpWVFIUFUy?=
 =?utf-8?B?RmFFdFZKNDJQdXZUSHprR25qOU5xdCtMNGdLSmtDWFpsamlReFJxbS9Qdk1z?=
 =?utf-8?B?dUNTdjhwVGY3b1JLWXVKUS8ycWp1OTZUYnZnV0FnbFJkcFFOSkRpemVZYnRq?=
 =?utf-8?B?bHpzc1NJeklndGszQTFhQTNGOFlUYWVRU3B4ZnhLV2RVUlBNY0h3Rks4dmZo?=
 =?utf-8?B?WCtnMVorWVB1b0tDYm84dkR5b1M1TkhUTlhNQXV4alVNcU5GeTJuZnJQSFBQ?=
 =?utf-8?B?R1lHdW5RV1J1bGZTdm1GTU0rU2VHZGlWdlk1RGpkbVR1STRBWmVLS1VwR2Ft?=
 =?utf-8?B?TjlwLzNMUkV3dzNjT1lCenFwNjNtYyt2MmNaV3hmK2lRY2RFSzRXMk9Rc2Ri?=
 =?utf-8?B?a2grMG1ROXZuVzcvODAzb2FpajhkVWtnSlJuKzd5UUVocGdQVkZ4SURJcThL?=
 =?utf-8?B?SmJlREtkWjUvQUtQeEZwT05hMld4MjBrYm9MUG5tL3h6RVVFVUQrUWw1WVYx?=
 =?utf-8?B?cjQrbENjRjlqWU5TU1hCQVM4Wkdpd3VMWWVLb2pGKzRHeWYxOXBHbjRlVVcx?=
 =?utf-8?B?bGJaZ1NoVG5ONGU0SmtyNFpJbHJkMTRBR2dka0tzTEd4ekQzQWhTRTc2bXpL?=
 =?utf-8?B?cDNLSUN1UWtHSjd4NFN5alpZVENqS2JGOUVCQVNaTFgvUW1neHhCSEl5NGxV?=
 =?utf-8?Q?Z1qZxNFJhboSKvuJfOf2fla8gzS1ihPQa8WFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTh5TXZEZU4xazdLbUVQN05jYzF4Q0wvdFJBTHpLVk9BaUVKNmxFVlBzd0hS?=
 =?utf-8?B?bDlITk5UbFZKcTlidlJRRXVRYTRhci95aFRHMVBPOTZFdTdiRFlnMU44eDJ3?=
 =?utf-8?B?VHpSa081V2tvaHBqVEt3bHVvbWs5S3lXZzNlRUptVjZQL0k2dThkRXZBSzBu?=
 =?utf-8?B?dXZHRVVMY0k5TEtMcTd6Q0pQUlRNNEluaUJjSi9SNUdXclZXcGU4Y21qUWp1?=
 =?utf-8?B?RGtWbTNWQXUxNEVSRlovb05laktqVnhBT2xQZlo2ZzNWUDIzcWY5U3c0ajd3?=
 =?utf-8?B?ZVcydCs2UzBKazJxVWR6U1d0VU9WMFNxV01uWmcvN0ZhV08yVk9ScW03RlI0?=
 =?utf-8?B?dHBTbDFtdTNjbXR3TTA2cmVHS0pzQ3VBbXJkNGkvRW0rOVJibE9FdnREQnNh?=
 =?utf-8?B?bE1VamNaVzVtRUp3NVQ1QWVXcGp5STNuQklRVGFXelhUSEJPaFRXWDBDaXA1?=
 =?utf-8?B?YmhUemVMY0NWZk12UFlZSXFqZHJ0UUNPREhpcUJORDJpQ0RXaTgxbmRTMnBp?=
 =?utf-8?B?U0xGbkZQdlJkRVM5RWkwY21JOHZ6Mlc0T09iaHloT1NlZ3MxUmdWSkJZd1ZC?=
 =?utf-8?B?OWZkVGpFNmJEU2Jzd0FzRFJZZGUweklCSDROWGRrd3ZBV2EyZkFBUGsxMUQ3?=
 =?utf-8?B?RUtKM2xMUjJrMHFWb0M1cU9NMElaWFBpL3c4QzZXY29GRVdmc1ZGU2c5RU5v?=
 =?utf-8?B?cEcwdUUwNmFzelNiNVYyQmI5c0pubWRnTW0ra2t0V2w3eWU2NTAwajFFakEv?=
 =?utf-8?B?ZXVkUzFUTzF1N0d3MzlkVlptZlhZVUU2YlhHWmdpcFdKZDJlRjlrc0xrQnN0?=
 =?utf-8?B?WnF4cFdsUjR3VzRjeGF4RHE5YkxEdkpxbHJCaHVlME1WOFhORENXZzAzN1dx?=
 =?utf-8?B?aGRWazRaY0NCc1NZeE01Q21yVzhqU1h4Q2g4ZUFTcjdJb0FPTWZQN1pWNkI2?=
 =?utf-8?B?NnlNdXFpWE04WGFvbmNicW56U0NzZktjNmM2dmNXKzNiZ2J2Sm9IMlJuK2d0?=
 =?utf-8?B?MnBxUkFyY2dhazZXVG1POU52b0p1dnd0N2N2cUZRMVBVRnBBZHJYN0cyd2Fv?=
 =?utf-8?B?STl3Tis5ZEd3VmNnbU9oM0k1UlZIekdJR2lqaFJFVG1ENXk3T2ZGS1lubTZC?=
 =?utf-8?B?NnJlMUd4ME1ZNUdBKzNkVlZvOGpneDFLYmdmVEp3S0lQRHE4andCV3ZhOXV4?=
 =?utf-8?B?WG9OVjYwQTQxdzMzRktHMjZoSzVybjNjN0lmMTAwTkdGMm9QRDdFcGRjaVdr?=
 =?utf-8?B?Q2hydnJiQVJLMzZLQ2srOTgya1gvaHJFTTBCTVZjRk5BWFg3eW5hekpMU3hX?=
 =?utf-8?B?RlFpMFhDc2lIbk1KSWpXNUZmempnV3Vzc0FhZnU2eitTQ01rZm80bWFKdlBO?=
 =?utf-8?B?SVZTcjlNWWdJckpHRis2OHFSbHIveDlPWDczMTRSQkIva1Q3WWZ0RkpNV3dJ?=
 =?utf-8?B?SlpOVzZOclZKK2phVEtNbytDUHdPelNWeXZnOGk0YVlNdzErazIxdU5oaGky?=
 =?utf-8?B?UG0xd21vbGVTYXUwUUpJcGZXYkI5emt1ZmdNdjgyQUZoc1RZeEZVWDROalFJ?=
 =?utf-8?B?N0NyUXRpQTd6ZmJPTytSUElSR2JLQUFJa0ZWcGlhQXFIZ3VTaXhrM0RyWFBM?=
 =?utf-8?B?YUtETmxhRnZXbzc0czYrV0x5MFF6MjZtdnFoTFZJY3RvL3Z0WVE5cVc4Nks4?=
 =?utf-8?B?bE5TbXJ4NFhvZzNOSjArekVaZW1CUzRFMEZ2Qnk2Q28xLzRtNHRNYTExZ0Nq?=
 =?utf-8?B?UnYyYmJuSlBueEpLaHIxSVRWaEZQV2V1QmZRUm1nV0JobzkzYThGK3RtN1FE?=
 =?utf-8?B?N2tGNWwrLzN4ZGg2TzNJWXgwcHcwMkhSL1NDOG81VFFlZmxIY2s2dFo4ZnhE?=
 =?utf-8?B?eEZYbDExYVRMQWI5cHE3SWtscmVYaWJuYTMySTkvbHR2U3dxUi9DNkhiYUxn?=
 =?utf-8?B?TFVlZnJDTmlqRDFMcy84c3pKeGc0NnkzTE5Nb0FLZ2h5RjRuV2FicWhoMitk?=
 =?utf-8?B?M2hQbVVWUmJzUk56MGFaOURUZ2tjSWlZeThzM3V4RUZJcDN4dXFMSGRjZjEx?=
 =?utf-8?B?cGE4Tk1OTlQvdHFQSTJsWDA5VzF5WG9yakVpQ0RIMThTZTI2VXVIMk1lLzFY?=
 =?utf-8?B?Y2dYWlArcElCcU5IQU5jZ3RZNXZlUXg1S0JlWnBhdEs1RUwvMkthRGNLSlRT?=
 =?utf-8?Q?ms06CdpT23lj0H9q6KzdWO4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e37222e-c2c8-48b5-fab7-08ddefa51cf5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:30:59.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l058ryjn1HCNKLCwy0CcRi+6hqVJ/ZF+O175paPb5rnBYtYIMJqavkNsNzM/wl0EzExkK7hCekpBbvAmSAYk2dewzmb6C4qZsWgC0yX3Eu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10529

On 2025-09-08 17:31, Thomas Gleixner wrote:
> In preparation for a major rewrite of this code, provide a data structure
> for rseq management.
> 
> Put all the rseq related data into it (except for the debug part), which
> allows to simplify fork/execve by using memset() and memcpy() instead of
> adding new fields to initialize over and over.
> 
> Create a storage struct for event management as well and put the
> sched_switch event and a indicator for RSEQ on a task into it as a
> start. That uses a union, which allows to mask and clear the whole lot
> efficiently.
> 
> The indicators are explicitly not a bit field. Bit fields generate abysmal
> code.
> 
> The boolean members are defined as u8 as that actually guarantees that it
> fits. There seem to be strange architecture ABIs which need more than 8 bits

seem -> seems

Other than this nit:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> for a boolean.
> 
> The has_rseq member is redundant vs. task::rseq, but it turns out that
> boolean operations and quick checks on the union generate better code than
> fiddling with separate entities and data types.
> 
> This struct will be extended over time to carry more information.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V4: Move all rseq related data into a dedicated umbrella struct
> ---
>   include/linux/rseq.h       |   48 +++++++++++++++-------------------
>   include/linux/rseq_types.h |   51 ++++++++++++++++++++++++++++++++++++
>   include/linux/sched.h      |   14 ++--------
>   kernel/ptrace.c            |    6 ++--
>   kernel/rseq.c              |   63 ++++++++++++++++++++++-----------------------
>   5 files changed, 110 insertions(+), 72 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -9,22 +9,22 @@ void __rseq_handle_notify_resume(struct
>   
>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>   {
> -	if (current->rseq)
> +	if (current->rseq.event.has_rseq)
>   		__rseq_handle_notify_resume(NULL, regs);
>   }
>   
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
>   {
> -	if (current->rseq) {
> -		current->rseq_event_pending = true;
> +	if (current->rseq.event.has_rseq) {
> +		current->rseq.event.sched_switch = true;
>   		__rseq_handle_notify_resume(ksig, regs);
>   	}
>   }
>   
>   static inline void rseq_sched_switch_event(struct task_struct *t)
>   {
> -	if (t->rseq) {
> -		t->rseq_event_pending = true;
> +	if (t->rseq.event.has_rseq) {
> +		t->rseq.event.sched_switch = true;
>   		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
>   	}
>   }
> @@ -32,8 +32,9 @@ static inline void rseq_sched_switch_eve
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
> -			current->rseq_event_pending = false;
> +		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
> +				 current->rseq.event.events))
> +			current->rseq.event.events = 0;
>   	}
>   }
>   
> @@ -49,35 +50,30 @@ static __always_inline void rseq_exit_to
>    */
>   static inline void rseq_virt_userspace_exit(void)
>   {
> -	if (current->rseq_event_pending)
> +	if (current->rseq.event.sched_switch)
>   		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
>   }
>   
> +static inline void rseq_reset(struct task_struct *t)
> +{
> +	memset(&t->rseq, 0, sizeof(t->rseq));
> +}
> +
> +static inline void rseq_execve(struct task_struct *t)
> +{
> +	rseq_reset(t);
> +}
> +
>   /*
>    * If parent process has a registered restartable sequences area, the
>    * child inherits. Unregister rseq for a clone with CLONE_VM set.
>    */
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>   {
> -	if (clone_flags & CLONE_VM) {
> -		t->rseq = NULL;
> -		t->rseq_len = 0;
> -		t->rseq_sig = 0;
> -		t->rseq_event_pending = false;
> -	} else {
> +	if (clone_flags & CLONE_VM)
> +		rseq_reset(t);
> +	else
>   		t->rseq = current->rseq;
> -		t->rseq_len = current->rseq_len;
> -		t->rseq_sig = current->rseq_sig;
> -		t->rseq_event_pending = current->rseq_event_pending;
> -	}
> -}
> -
> -static inline void rseq_execve(struct task_struct *t)
> -{
> -	t->rseq = NULL;
> -	t->rseq_len = 0;
> -	t->rseq_sig = 0;
> -	t->rseq_event_pending = false;
>   }
>   
>   #else /* CONFIG_RSEQ */
> --- /dev/null
> +++ b/include/linux/rseq_types.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RSEQ_TYPES_H
> +#define _LINUX_RSEQ_TYPES_H
> +
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_RSEQ
> +struct rseq;
> +
> +/**
> + * struct rseq_event - Storage for rseq related event management
> + * @all:		Compound to initialize and clear the data efficiently
> + * @events:		Compound to access events with a single load/store
> + * @sched_switch:	True if the task was scheduled out
> + * @has_rseq:		True if the task has a rseq pointer installed
> + */
> +struct rseq_event {
> +	union {
> +		u32				all;
> +		struct {
> +			union {
> +				u16		events;
> +				struct {
> +					u8	sched_switch;
> +				};
> +			};
> +
> +			u8			has_rseq;
> +		};
> +	};
> +};
> +
> +/**
> + * struct rseq_data - Storage for all rseq related data
> + * @usrptr:	Pointer to the registered user space RSEQ memory
> + * @len:	Length of the RSEQ region
> + * @sig:	Signature of critial section abort IPs
> + * @event:	Storage for event management
> + */
> +struct rseq_data {
> +	struct rseq __user		*usrptr;
> +	u32				len;
> +	u32				sig;
> +	struct rseq_event		event;
> +};
> +
> +#else /* CONFIG_RSEQ */
> +struct rseq_data { };
> +#endif /* !CONFIG_RSEQ */
> +
> +#endif
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -41,6 +41,7 @@
>   #include <linux/task_io_accounting.h>
>   #include <linux/posix-timers_types.h>
>   #include <linux/restart_block.h>
> +#include <linux/rseq_types.h>
>   #include <uapi/linux/rseq.h>
>   #include <linux/seqlock_types.h>
>   #include <linux/kcsan.h>
> @@ -1400,16 +1401,8 @@ struct task_struct {
>   	unsigned long			numa_pages_migrated;
>   #endif /* CONFIG_NUMA_BALANCING */
>   
> -#ifdef CONFIG_RSEQ
> -	struct rseq __user		*rseq;
> -	u32				rseq_len;
> -	u32				rseq_sig;
> -	/*
> -	 * RmW on rseq_event_pending must be performed atomically
> -	 * with respect to preemption.
> -	 */
> -	bool				rseq_event_pending;
> -# ifdef CONFIG_DEBUG_RSEQ
> +	struct rseq_data		rseq;
> +#ifdef CONFIG_DEBUG_RSEQ
>   	/*
>   	 * This is a place holder to save a copy of the rseq fields for
>   	 * validation of read-only fields. The struct rseq has a
> @@ -1417,7 +1410,6 @@ struct task_struct {
>   	 * directly. Reserve a size large enough for the known fields.
>   	 */
>   	char				rseq_fields[sizeof(struct rseq)];
> -# endif
>   #endif
>   
>   #ifdef CONFIG_SCHED_MM_CID
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -793,9 +793,9 @@ static long ptrace_get_rseq_configuratio
>   					  unsigned long size, void __user *data)
>   {
>   	struct ptrace_rseq_configuration conf = {
> -		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> -		.rseq_abi_size = task->rseq_len,
> -		.signature = task->rseq_sig,
> +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq.usrptr,
> +		.rseq_abi_size = task->rseq.len,
> +		.signature = task->rseq.sig,
>   		.flags = 0,
>   	};
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -103,13 +103,13 @@ static int rseq_validate_ro_fields(struc
>   				      DEFAULT_RATELIMIT_INTERVAL,
>   				      DEFAULT_RATELIMIT_BURST);
>   	u32 cpu_id_start, cpu_id, node_id, mm_cid;
> -	struct rseq __user *rseq = t->rseq;
> +	struct rseq __user *rseq = t->rseq.usrptr;
>   
>   	/*
>   	 * Validate fields which are required to be read-only by
>   	 * user-space.
>   	 */
> -	if (!user_read_access_begin(rseq, t->rseq_len))
> +	if (!user_read_access_begin(rseq, t->rseq.len))
>   		goto efault;
>   	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
>   	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
> @@ -147,10 +147,10 @@ static int rseq_validate_ro_fields(struc
>    * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
>    * state.
>    */
> -#define rseq_unsafe_put_user(t, value, field, error_label)		\
> -	do {								\
> -		unsafe_put_user(value, &t->rseq->field, error_label);	\
> -		rseq_kernel_fields(t)->field = value;			\
> +#define rseq_unsafe_put_user(t, value, field, error_label)			\
> +	do {									\
> +		unsafe_put_user(value, &t->rseq.usrptr->field, error_label);	\
> +		rseq_kernel_fields(t)->field = value;				\
>   	} while (0)
>   
>   #else
> @@ -160,12 +160,12 @@ static int rseq_validate_ro_fields(struc
>   }
>   
>   #define rseq_unsafe_put_user(t, value, field, error_label)		\
> -	unsafe_put_user(value, &t->rseq->field, error_label)
> +	unsafe_put_user(value, &t->rseq.usrptr->field, error_label)
>   #endif
>   
>   static int rseq_update_cpu_node_id(struct task_struct *t)
>   {
> -	struct rseq __user *rseq = t->rseq;
> +	struct rseq __user *rseq = t->rseq.usrptr;
>   	u32 cpu_id = raw_smp_processor_id();
>   	u32 node_id = cpu_to_node(cpu_id);
>   	u32 mm_cid = task_mm_cid(t);
> @@ -176,7 +176,7 @@ static int rseq_update_cpu_node_id(struc
>   	if (rseq_validate_ro_fields(t))
>   		goto efault;
>   	WARN_ON_ONCE((int) mm_cid < 0);
> -	if (!user_write_access_begin(rseq, t->rseq_len))
> +	if (!user_write_access_begin(rseq, t->rseq.len))
>   		goto efault;
>   
>   	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
> @@ -201,7 +201,7 @@ static int rseq_update_cpu_node_id(struc
>   
>   static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
>   {
> -	struct rseq __user *rseq = t->rseq;
> +	struct rseq __user *rseq = t->rseq.usrptr;
>   	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
>   	    mm_cid = 0;
>   
> @@ -211,7 +211,7 @@ static int rseq_reset_rseq_cpu_node_id(s
>   	if (rseq_validate_ro_fields(t))
>   		goto efault;
>   
> -	if (!user_write_access_begin(rseq, t->rseq_len))
> +	if (!user_write_access_begin(rseq, t->rseq.len))
>   		goto efault;
>   
>   	/*
> @@ -272,7 +272,7 @@ static int rseq_get_rseq_cs(struct task_
>   	u32 sig;
>   	int ret;
>   
> -	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
> +	ret = rseq_get_rseq_cs_ptr_val(t->rseq.usrptr, &ptr);
>   	if (ret)
>   		return ret;
>   
> @@ -305,10 +305,10 @@ static int rseq_get_rseq_cs(struct task_
>   	if (ret)
>   		return ret;
>   
> -	if (current->rseq_sig != sig) {
> +	if (current->rseq.sig != sig) {
>   		printk_ratelimited(KERN_WARNING
>   			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> -			sig, current->rseq_sig, current->pid, usig);
> +			sig, current->rseq.sig, current->pid, usig);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -338,7 +338,7 @@ static int rseq_check_flags(struct task_
>   		return -EINVAL;
>   
>   	/* Get thread flags. */
> -	ret = get_user(flags, &t->rseq->flags);
> +	ret = get_user(flags, &t->rseq.usrptr->flags);
>   	if (ret)
>   		return ret;
>   
> @@ -392,13 +392,13 @@ static int rseq_ip_fixup(struct pt_regs
>   	 * Clear the rseq_cs pointer and return.
>   	 */
>   	if (!in_rseq_cs(ip, &rseq_cs))
> -		return clear_rseq_cs(t->rseq);
> +		return clear_rseq_cs(t->rseq.usrptr);
>   	ret = rseq_check_flags(t, rseq_cs.flags);
>   	if (ret < 0)
>   		return ret;
>   	if (!abort)
>   		return 0;
> -	ret = clear_rseq_cs(t->rseq);
> +	ret = clear_rseq_cs(t->rseq.usrptr);
>   	if (ret)
>   		return ret;
>   	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
> @@ -460,8 +460,8 @@ void __rseq_handle_notify_resume(struct
>   	 * inconsistencies.
>   	 */
>   	scoped_guard(RSEQ_EVENT_GUARD) {
> -		event = t->rseq_event_pending;
> -		t->rseq_event_pending = false;
> +		event = t->rseq.event.sched_switch;
> +		t->rseq.event.sched_switch = false;
>   	}
>   
>   	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> @@ -492,7 +492,7 @@ void rseq_syscall(struct pt_regs *regs)
>   	struct task_struct *t = current;
>   	struct rseq_cs rseq_cs;
>   
> -	if (!t->rseq)
> +	if (!t->rseq.usrptr)
>   		return;
>   	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
>   		force_sig(SIGSEGV);
> @@ -511,33 +511,31 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   		if (flags & ~RSEQ_FLAG_UNREGISTER)
>   			return -EINVAL;
>   		/* Unregister rseq for current thread. */
> -		if (current->rseq != rseq || !current->rseq)
> +		if (current->rseq.usrptr != rseq || !current->rseq.usrptr)
>   			return -EINVAL;
> -		if (rseq_len != current->rseq_len)
> +		if (rseq_len != current->rseq.len)
>   			return -EINVAL;
> -		if (current->rseq_sig != sig)
> +		if (current->rseq.sig != sig)
>   			return -EPERM;
>   		ret = rseq_reset_rseq_cpu_node_id(current);
>   		if (ret)
>   			return ret;
> -		current->rseq = NULL;
> -		current->rseq_sig = 0;
> -		current->rseq_len = 0;
> +		rseq_reset(current);
>   		return 0;
>   	}
>   
>   	if (unlikely(flags))
>   		return -EINVAL;
>   
> -	if (current->rseq) {
> +	if (current->rseq.usrptr) {
>   		/*
>   		 * If rseq is already registered, check whether
>   		 * the provided address differs from the prior
>   		 * one.
>   		 */
> -		if (current->rseq != rseq || rseq_len != current->rseq_len)
> +		if (current->rseq.usrptr != rseq || rseq_len != current->rseq.len)
>   			return -EINVAL;
> -		if (current->rseq_sig != sig)
> +		if (current->rseq.sig != sig)
>   			return -EPERM;
>   		/* Already registered. */
>   		return -EBUSY;
> @@ -586,15 +584,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	 * Activate the registration by setting the rseq area address, length
>   	 * and signature in the task struct.
>   	 */
> -	current->rseq = rseq;
> -	current->rseq_len = rseq_len;
> -	current->rseq_sig = sig;
> +	current->rseq.usrptr = rseq;
> +	current->rseq.len = rseq_len;
> +	current->rseq.sig = sig;
>   
>   	/*
>   	 * If rseq was previously inactive, and has just been
>   	 * registered, ensure the cpu_id_start and cpu_id fields
>   	 * are updated before returning to user-space.
>   	 */
> +	current->rseq.event.has_rseq = true;
>   	rseq_sched_switch_event(current);
>   
>   	return 0;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

