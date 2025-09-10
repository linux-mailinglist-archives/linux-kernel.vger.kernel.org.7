Return-Path: <linux-kernel+bounces-810428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755CB51AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FCA16CF98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BB23A9BD;
	Wed, 10 Sep 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tNtUEY5/"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022078.outbound.protection.outlook.com [40.107.193.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123E23CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515541; cv=fail; b=JLg5Lfj8D9IC4SXLo2MXR/BsSaUrbkCTuh0z0UPLGly4T4LcqEHPyfdODXBo1vwyU7SjM3UXeChPmacP42Hk5dEgMWBwDZH29IFFFKteS6oV2JfdS60MJ3koQcUSLUI+YKVENMkLrfJs+J2Mevqr4fbB/Tko1eWjCUGD0h6eI3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515541; c=relaxed/simple;
	bh=bNNhriW1juNw5Kv/qfNq3NivhUZRNAo+Ko+JwJeSeoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLC6NLhKAEYrcIxzIX1zoNBjH6welTOHL/axjE4j+T2nmviodPVdAy3FaxSYdNfiXOvbcwKrDkHS7nGXYbE1svmhNDHWxKlvN/1XrSxzP3nPaAHTNyblbulg7DFCZYtQVSs6pm3XOZEMNiMCoyTdJDLmHVQeic1XFPJcZf2hTtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tNtUEY5/; arc=fail smtp.client-ip=40.107.193.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgMdkzkLRrVMONvffPNl8q+DQRiQAHWjxo4XX0VQ5443Jc7qW9P2HncnFTGMC5Xrunyc+vloFes2x+yQM6uA10v9KX1KnnqB8ilaXJPV/c1YCpd6asBKyTRYp0Jmf02UDP3DOj4F87/YSGLXymzUAY6liGN2hfmiKVFyduoepQrZ87DxvlP+ef30Kd5P+01IXHJsUPduqokWshpuu+PVUM9wx3YQMa1DksiwxfffZaijBrbBsVy6OO1l5C6XSLqypUWJpn9l0cIgHTlGULTp0P4lk2nWkQh8C5ymlmjmRRA+4g53kXZVJtRPYBCN0pkbBMj2NKrSYOAmAGcFh0yJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0aWsRO7L5EKg7E3X44OHOTHSiJU5YSALB01z83Jd4c=;
 b=lK4npz+Nc3+XYCMxwPLT1B/5+K4zri5uFC/V90e9OJy1k6+JXhv6b3UsJD7Z3lAhvXH4ZO9Ljbhvk477gHOPrvlxQ0ChVwPYALdRMQXHtG0pLKiGfXZe3J7o3gn420YaG+KX10aeNJ29qAAeEv0RPW1cme8jcBmThFr+IQpQCQAaOsXtF2isTO9qCqq8vEsOKxkW4r0KbTHAfvZU9sWfG7XuMHJ+o0rgJScdPtvOrOlrLkU3bYj0W/zINBAKK0Du1aNhjwUtsXsabdbtnLx7DqSPJLuTgxKMoTdgGUZOXZFnnI1DTHmSRLUDsIXxtDv8oY3jLkNpWE3D+LI3+onB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0aWsRO7L5EKg7E3X44OHOTHSiJU5YSALB01z83Jd4c=;
 b=tNtUEY5/U/38N/jx2B+kRhR9SSsY8etEv8Lr6LHZahadD5Ezd7ju6AVGIjHNwfUcjvV3MbBtD8HjF6XArikYnoKchAhBq2kM8tvzXZ62xOEYerBgsG4vDqpQYszG2JTOalR2wgFjdg498C9jZZvVdCa+KqbomrsmwaDTUGxIjUTVYDfPoI/+z8JrpNUj1zC3FqqPatt5IpesAMLYDJNkgIc7KhTyuh1TK07EpocuXEnnjz7ilJCQROw8+TgH3tQUl4K3wNML8i+1ZiTVgeWoDzLvZxQ7Cwxa5tYlOqL1Uvze/q3OJzKaWjlDiVR4v/JjKl+OKP0OONQcMG6VU8eM0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT3PR01MB11104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:142::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:45:35 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:45:34 +0000
Message-ID: <86b0eb6a-9a16-44f5-8ff0-5003624f107e@efficios.com>
Date: Wed, 10 Sep 2025 10:45:33 -0400
User-Agent: Betterbird (Linux)
Subject: Re: [patch V4 00/36] rseq: Optimize exit to user space
To: Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <4029c2d2-7a0c-4531-aa1e-b35be9098bb1@kernel.dk>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <4029c2d2-7a0c-4531-aa1e-b35be9098bb1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::12) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT3PR01MB11104:EE_
X-MS-Office365-Filtering-Correlation-Id: 899aa737-b0ed-4304-e3dc-08ddf078b2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2svQmdwTnMvSWZoK25LclI0ODVZSEt3azdyZTB0RGdVYVluR3hLZHJac0hQ?=
 =?utf-8?B?Mno4azg4azRWa09CVEt3NzJlK2tCdnc0NzJLMVdlZk04bG1rZnJ5T0dEa09h?=
 =?utf-8?B?REV0S3d0YVpvbnA4enc4Nzh2Z1F0cnRSRkFwaVhUMTZYUGRhbk94cGVVVUhC?=
 =?utf-8?B?K0luQWZ5U3ZybGJoTVFQUWRUNEhJUUhEZEJuNFpVR0M3TG1YQ0R4aFllVUx5?=
 =?utf-8?B?UGlQSllzK240amNiNUFUUDFycnhFejFQTmxHaThIRkdoRVNSbVVkOEVlOG01?=
 =?utf-8?B?cEpoVTFZQmdXRHdqdVNMbnhiUkdmbzI5SzAwZDNaUG5zN0dnV0hrcHBhdXVL?=
 =?utf-8?B?QUVCUm9KbGdLRkJZeEFtRWQvWTl5Z052ZlEyVW9uWDNBY04vNUZnU2h3aEg5?=
 =?utf-8?B?UzJLQkVhVU0yS3doeFArUFBWUllyTjhHczRzbHJqVks4VHJUUkQ5Y0RPMWFn?=
 =?utf-8?B?VGg1aGZBdUtpd2xGZHZ4cDUyTk9TRHNWTGJ6WWpwNVJlOW56YVRDNnpRTHY2?=
 =?utf-8?B?N1FlR1c5OFRLc1B0dm9xR1pPclZKM082VFR5MW5vY3d1Z2tBS1h1YVdIK1F5?=
 =?utf-8?B?REdMQk1OTFBaZnVQQlFjSXdhc3RaV0hTOTJoYm11WDl6dkp5K0QwdHNDQXRz?=
 =?utf-8?B?NVZ5azN4cjQ5KzhwWTlpVFF5LzBCQ0tVZFFXdWNzOVd0VkRVaUViaDVvdmRH?=
 =?utf-8?B?a0ZJaldhN25abDRmais3THdZOVBVemI2Q2lxMUpMbXBnbFNvVUNBYmhvT2Fu?=
 =?utf-8?B?S3ViS2dFNDJwaTRmQWFvZFk1VW0reVdvbVhZV3grLzE5VVVmT0Qwamoycjh6?=
 =?utf-8?B?cnk5cjQ3bEtWOVRCMldsb1N2SGxGVnJsazkrNGQwZkMwdEpieUdqWDB6eXRZ?=
 =?utf-8?B?amVFMDNlYjlHZ243R0JDZG91bDZSRWVpWlYrOGJGbTBnQ1JBSTBVaFpvcnJ0?=
 =?utf-8?B?aEl2c0EwNnYxVTVQMm5YbE56Smx4ZDNSQWJtUnk3ZE9sNFZ2bGV0eGs5WnYw?=
 =?utf-8?B?ODRZVnVHSGoxWDJ3bmYyNEFQTHlhaG5kQk1FYk1IenV6cDdSSjBrd1N1a0oz?=
 =?utf-8?B?ZUgrcStEZlphTXh0dERoSy9lcVpuMkFYd3FWMUxuNjJPc0h0c2w0dndVWVEz?=
 =?utf-8?B?V1dZMTd4WGNPOTBtdUxhblFoVEVVdkgxM3VZUnpmQzNzTHVJL3ZWYUw1ckxn?=
 =?utf-8?B?QkVOMitwYkNUVDNIVFJFOXBRaTl1VFdGbU5hbXFoQnM5Q01KUUhuS2d2cHBs?=
 =?utf-8?B?VlE4UWd1WEVkOURYTXQzSU8xSy9Sa2tkQ1lWTWV0ZitqYlppNGFSc3dTaGhT?=
 =?utf-8?B?WDJWU2h1L0tZaWlWaDN2QXdBVlRWdjBMbHpOaVdXMW1zZW1xU2VISlhaK3kv?=
 =?utf-8?B?M1N6NXNRcGpNbVZZcUdwV3RiZ293dlBBTThITDRpWUdGeHZ5SnNTck5sYTYv?=
 =?utf-8?B?M0JwRHZSM0ZCUFphREpXaGkyYXgyL2Q3dWt3OU9kT2JQbW9zeitaQXJtUHBF?=
 =?utf-8?B?M3NqVy80a0duWkplSUNoY1VxOGQ1Z3d2M0FjdjBuWXRYdzZTNmkyaVFyWWho?=
 =?utf-8?B?MDFnSXppeTlMalRIVDMraWo3YmYzY2o0V2U3UmprNnR2S0oxdTdBbEl0SGFl?=
 =?utf-8?B?anhSY2YwOE5RTjlJRmNnb2dGSmUvcUVIV2R0bHQ4K1BDVnIxbWdqZmUrNW4w?=
 =?utf-8?B?TWludnY2emlCTU1JeHF2U3BWbndXZzMxVkNjcW5ySW5iOFJGK0djSnlEOEhE?=
 =?utf-8?B?NVFYYk9sUFFLTWNkTXNENElxZXc5ellwVStDbGlnMUNidldZL2ZqRk1CTXR6?=
 =?utf-8?B?WkF0dFgzSkhLMXV3dGVpSDZIWjkxU2d3MW41cUZBQWZNUlU2WjNiTzRaWDBE?=
 =?utf-8?B?WFBxWWRwS2pvc1pQVkszbUNzMisyMm9GNmhaN1ViVkpGR2pveWJtTlJXZkVs?=
 =?utf-8?Q?gCbZK9kyuK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpTOHk3TDIycUJac2J5OEhDckNkaStHcEs3MXBsY1A5Uy8yL2tVRnY2MDVk?=
 =?utf-8?B?UWRHM2JPYWl5Mitmc0pYbC9xUzd2T1c3Q2E4M1ZJNHpOK1h2V0paeEdxUCt5?=
 =?utf-8?B?TkQ0R21Gek5SdDZ5SUNRcUZlbTJnQnpGQXBlanpCMXZIK1JraGs0VCtxUGx4?=
 =?utf-8?B?R0JocXVCbzZkRVhhTmRoVGlaM0dnZGoxYWZaY3oyVE1vVjVwcVo3N0tlLzRp?=
 =?utf-8?B?aGsvNUZudkVHT3ZlcWl6UjdETVQyYzQ3REE1azg4eHEvcndNQUhVR2pzN0tX?=
 =?utf-8?B?MUpEVWducFNHWWdSZ1MrM0svYXBCT2F3SEJRZmFlcTFUNVl1V2ZGaDRSOVla?=
 =?utf-8?B?MzcwbnMweTN3N0VCeHFhdEdUMFBjczFsNHF1Z3JibzVkL3JDbzVRK3dYcTRt?=
 =?utf-8?B?bmxpcUZ3S0pVQWZEVElwUm5IUHNNN3ErMVpYSEFsamxYZUhpR3pZSzkwRFU5?=
 =?utf-8?B?V1RZUmMvQXljS0s1QW53ZC9CN1ZnQXFJVVZyZjlGdGpMSWQxV3BZenBYSnhF?=
 =?utf-8?B?b1hvaGVQTHE4TEFZUDdkVlZrQ2JUYW04WUhCQVVzTEV4ZzM2RVowWjA3alg1?=
 =?utf-8?B?TVN1TGI5ZlFGVkpSUEdaZ2NKSDVTM3k3V1c0VFBjNWtNMkpoZFZ6UzVmWWE4?=
 =?utf-8?B?RlE4K0hsVnFIQnB3dXlCNG45RmF5SU8vbzdYMkVoY09ScW1EY2tHZ3NNOGlu?=
 =?utf-8?B?RGdmcVlKNnRpKzBab21Xc2NSc3hRdlpFUStST3pWVXVXSllLNm9wNlAyUHA0?=
 =?utf-8?B?QTN4S3lYU201TjJxZFdOZjU2WnhmdklQU2ZVWitrQkRESFRmcXpCTTAvTS94?=
 =?utf-8?B?aGNhbXkyei9pdnByMmk5RVFsWitYSitQWEhUL2xtZmZzS2FrSGxIM1NOdkVO?=
 =?utf-8?B?YXdNTUdxZi8yR0tNUkhsdFlBOWVCTGd3emtudW1vYVd1QlVlRHhUbXJvL2t4?=
 =?utf-8?B?S1pOVmpQRDVJaitoM1hjTzRpd2NpSjV2bjRvWE1iRC90Sm9seGdQQjhoUHE0?=
 =?utf-8?B?VEpjY2JuVEhsMFI0d1RidlJ6cnR2dk5aRE5Pb0hQcUp2bmNWR1Y3QzhLakFR?=
 =?utf-8?B?MTNJTEJNZElibmtDTk5aQ3E5Yk93bWFPaEFheFkwTENpalV1VWRZVmg0TWtw?=
 =?utf-8?B?NGlkeU1tUVkrWWswR0VpaWFwaXJ1ZWRFUUgwVmdqSExjVENXV1dhbXRkSzNp?=
 =?utf-8?B?dXBCeWo3SkZTZkprVDBzUzJDUHY5cFJIbzk2TnoveGdCR0x3SzlDNWoxMU9Y?=
 =?utf-8?B?bkExc1cxaDRvdlVpWmFncU92bmtsN0dSakxyUUNRSXNCRmtkb3JSWmJGTjEw?=
 =?utf-8?B?bWc0NXB2TUk1bzFoSm1rMFBLakdoanBwY0VCWUJJc3ZTSnZ5OVh4MExIaU1k?=
 =?utf-8?B?dVh3NlBuTXV1QWdkQ294U3A4SStQSmljR1E4ZUlnVXVVU2U2LzhWV0ZsUU4x?=
 =?utf-8?B?SnVLNXV1MlZHVzVReGM1bVNUNVVZWWNUUFBkb2pKR1NjYWp1V25sS05iOHhQ?=
 =?utf-8?B?SnZUaHF3QVh1K3g0LzJBSWV4WjdOS0ZMRERvbkxUeERoSTRKM1RTVjAzVkJC?=
 =?utf-8?B?cGVjVnNXZ2dPZDM5bDRSNEdGY3FyejRuVC9OMjNpTHcxSlB4WTM2OEJhMUpq?=
 =?utf-8?B?TjdrTTZOQzc1d3BERzFselpnZ1E4UkhNQ0ZVS2ZFS2xYcnQyUUVOSjJKeVVE?=
 =?utf-8?B?ckRoMlFtSXhVNjM5d2N4V3hUeUpuZDFuSlhZRWZxL3NLSUZ6R1FtSVVSaEly?=
 =?utf-8?B?YW1uOEhhQUdCTmRaT1NLczFVT1o3cTBUK1l6RFZ2TGVFSVNmcnl0cGRjYm5w?=
 =?utf-8?B?a2RxcFRyTERIeEtYRWRDdkdwNFF0dGhuQVpLdUpVcFVXTTNzM0tiL0N6c0lt?=
 =?utf-8?B?ODBBUnFlWU1oMzNPRmpnOGZhd05YSklYYjkrOTI0VUFTeUFZM1oyKzNEZFlR?=
 =?utf-8?B?ZHdSaXIrUUxBRmtFRHVsMUlKZC9GdWYvVTZOc25zRTZYQmVyTnJPYk1rQkl2?=
 =?utf-8?B?bVdWWWlLOFJQaUE5clhvQ0xKbzFwcDA0b2NwclY1YTYyUUNPbHBJbWg4UWtU?=
 =?utf-8?B?WVJTc0ZQR29MSWhMNndsNGdVRkhjSFA2T09FbTZ2ZkFCbGp6bGZWSllrUnA5?=
 =?utf-8?Q?Zjd3StWaa9r/8V/+n36kQgUsk?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899aa737-b0ed-4304-e3dc-08ddf078b2da
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:45:34.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI4b/kFmYCL4SsTAJy8kZLTWLE1WG5wuqLDfrDLkhohiduto3+Mj+qk1xJEBqve+XvzeAsATmHsLliU3TYyOWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11104

On 2025-09-10 09:55, Jens Axboe wrote:
> On 9/8/25 3:31 PM, Thomas Gleixner wrote:
>> For your convenience all of it is also available as a conglomerate from
>> git:
>>
>>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf
> 
> I used this branch for some quick testing. Since I last looked at the
> rseq performance overhead, glibc must have improved a few things. FWIW,
> box is running libc 2.41 at the moment. Test box is on debian unstable,
> so gets frequent updates. In any case, for one of my usual kernel
> overhead runs of checking running a basic IOPS based test, I see the
> following on the stock (-rc5 + 6.18 targeted changes) kernel running
> that test:
> 
> +    0.89%  io_uring  [kernel.kallsyms]  [k] __get_user_8
> +    0.58%  io_uring  [kernel.kallsyms]  [k] __put_user_8
> +    1.13%  io_uring  [kernel.kallsyms]  [k] __rseq_handle_notify_resume
> 
> which is about 2.6% of purely rseq related overhead. Pulling in the
> above branch and running the exact same test, all of the above are gone
> and perusing the profile has nothing jump out at me in terms of shifting
> those cycles to other bookkeeping.
> 
> So yes, this work does make a very noticeable difference!

If you have time, could you also run the same test on this branch with 
glibc rseq registration disabled, just to see of there is some noticable 
differences.

To disable glibc automatic registration, just export this variable:

   GLIBC_TUNABLES="glibc.pthread.rseq=0"
Thanks!

