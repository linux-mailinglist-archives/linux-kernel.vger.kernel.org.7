Return-Path: <linux-kernel+bounces-785418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637DDB34A57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D8188E286
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D693090FB;
	Mon, 25 Aug 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HAmp7dV0"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2092.outbound.protection.outlook.com [40.107.116.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA93002CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146602; cv=fail; b=kg+3pBvshkMwTljeOq4wsG9xFgiogOd88HrvUCdnm968Z2fs+wLQhjQwNm1NpKvPAbPDndpU+n7SGdvz0Ts4LiCX8Vzj3+3vUBdHd4iYhNzziOLSLyaX04VhVU0iUNwskPqD1yiOEhYMmtgk7HR5MBbv1bvaz766uMmmhWZMftw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146602; c=relaxed/simple;
	bh=7Ic4/jLRlmDxLAV5213tD9zvj/7ugUtjpJ6kLx0B82E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ucpKvyGvL4FwdWLWxOe/AOZoS4AZpNyLPfod8XdxAXvOhTAcyNDk9OzXz1zoh2lOnnughFAhNy5y8vKzBKLgC6oquBQ20sjpQts1qy8XrxHpxbPQAZQumKFmF7vZXWTN9QFWcE3hGo2biHPJNenTJo2/eYJQXDzfK1tCozYTP/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HAmp7dV0; arc=fail smtp.client-ip=40.107.116.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2ItW7z4eI4/zteMHn/s0ZNGrmwkw1cg0P1IhWhTbAfsDCGfDn308JuqYLoWCNgkDp54M4K9/6o+dyMB98yIW7cytPq5xRAACNepCMZCm7sFtTfUtOmx2Z1MKeqBn4O7tW/VgeSPkt0OTMyT4T5ZeBTU/FICriC2VduroXl7bBCpR0dg2sK3Xl1BYT0jGaiTwmwGTA3ZMf3mBgopu3yoh0klkOQn/DQotNOZEEExo8P9Wv1Mis4/MZkMOS7yTTB3uyP65QRjXPiF0oYYOeU/dLu/MDg7vQgS8J0FynwJd036/aGPwmwdBHFvcDjRnNzb6r/Z+jicyiO2fWwYokf2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx3ezBiBNucMhfCN9FkCAfLzH9JK8HtsFLwc0xYZ9eM=;
 b=w/vKpIaiAykMkRqz3iBrjiFpAto2YaFr3ovnKkmm7fx+673vu20S4GOgwWvR4Yi+jQEbogbyWV7sqEewPyJkSxg+tRbh3b04H/ys8Sre/HKPncfXW5RTJXOjkGoWDJ6uJASmBPIOUkPmYn+iBbbN02BgKtrtmjCDvrFyB9c6WfHhNHBFMpAHKW7sQ8WYD/f+t2vNqAv/FeEgKkJHNHfgKzWnRajYKqkhsNQQufmrKnDGCYSEX8KvWzVjentOQ/nyGTIff3mxQhSW1C6iLqG59ulIBkUoM7L0AOZxpvreatqvhX5w028+hHPq9ygJp9qY9td5HVvQ+BQFP61+wjXKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx3ezBiBNucMhfCN9FkCAfLzH9JK8HtsFLwc0xYZ9eM=;
 b=HAmp7dV0UJAHHkj8YuOlqEbDWT+YLhKoepv0nkVEljuZfnK1RoDRgsRrHv+weg5dDyBFmnQ8RxnXXpbaecK53Vdn8WFLX/ble97Q0mVHj5i0lWDhEogkxO6E60PhbW4NCRAfW28HIdLk7H+MzoccRPCWO58gkKQU6BtCZd2Lo26UZlQjxk6pSmjLcmBBQ7csQZRCXARYZPqfKMhvciwavxf6dE2DZ1IIc66zwkXIsK4FcbuXA8gh/f4RcpdwzkW3xzNBY25o7FX8zTz09UmFmCP+sY9S4r2ectSHI1926CZkOFulQafwgpakAjKZcvPt+NQTY1EMwmuNHIobm3P74w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9478.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 18:29:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:29:56 +0000
Message-ID: <775c7f2e-975d-4262-964f-7d2ed0554fad@efficios.com>
Date: Mon, 25 Aug 2025 14:29:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 15/37] rseq: Record interrupt from user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.228227253@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.228227253@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0299.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf1a9d0-8b0c-4a9b-8587-08dde405645b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTh0RyttNWdTNTFwUGR6ZTg1RXlOMDVKSmNTNjNSWTBkd0tudzBaYUFpZTZK?=
 =?utf-8?B?TmM3amVtVmtxV1prUmlrMm0wclNZK25YOFY5Z1hicEx6VmZCY0NabUhGeDJX?=
 =?utf-8?B?WEE0eTdOWUZGTGVVZzFzbVRwWUxkS0RxTm1vb2VPZ2FYUExkNHBvbGtOUmgy?=
 =?utf-8?B?Ujh6TG15ZEZsVTE0Q2dlbFVLb1MxODhQSW9aZGIzQUVJMVRJNkZJK2xQWWdr?=
 =?utf-8?B?bFMrME5tMk1RYWFGMkFHUXlqMjdGUytLaTZ1eUV4bUVQUG5lYUZsZUFqVUNZ?=
 =?utf-8?B?ZG50RG0zR0lYOEdzZDRpaldkaGRQK1VESWJoV2FVOG1EcjJVc1FrN201c3hK?=
 =?utf-8?B?eGFLdERORVBBQTR4NDBoVlRHVWw4bEVMVmxRT1ZNZ3lwNytmVnQrWmNCVmZl?=
 =?utf-8?B?VForY3hjTFNza20xS3RveWp0NElmSzg0K25MNzM2Rm93NUo1SFRKM3dZWExE?=
 =?utf-8?B?ZjlXY0RLN0tMbEV6Wms5dytHRGNLRUdCUkp5bGE3cmhjcUMxZWZ1dGJabmVv?=
 =?utf-8?B?L3R4UWVHbVMreStWZ1YwekRJbit0Wmp2dEE4dk9QR1pnT1g3c1IwdXdOR25a?=
 =?utf-8?B?NGJjczlIMzc2NDZuMGlBWlB6MGYxVWV5SURPeFVEV1VwM3BCeFB3dk5ycGRS?=
 =?utf-8?B?VjdJYnhlb1B6djczRjhDeFNHemg5UzVUYnJuSzErUCtXM3FyMTVwcVVvd0pG?=
 =?utf-8?B?N3hxVFRjMWhKc29WSXJxSGNqKzFSWm9hUU5Ic1R5SXBnWVdQdks0QTF1ZVlW?=
 =?utf-8?B?WU0zcnpLeGhvTUlaRVdhRGlKQndRZ0EzbDZGU3IrNVAwU1orQ3NjaTVGbFFQ?=
 =?utf-8?B?QVlIelc0V2Z5UXNZRk5uZGI1Y2dJM3VicysrN3R2OFgvT0ZGSEpDeVZkcHhT?=
 =?utf-8?B?T0dwMGhzK1RoV28zc3IrUEFSWmdXWktVWGczbWY3TVZOZW5GbldpZmh6VGlH?=
 =?utf-8?B?WUFRSmtFZTFpUk1GL0d5ZUFXYW9oM0FLSjd1U3dKSkU4WHlabytSRHp2WUQ5?=
 =?utf-8?B?dUNkc3Y1UUFpTkVRb09DTUtmZGVQdERHZmE0OXhTNW93M2E1TGwyY3MvWG91?=
 =?utf-8?B?V2RMdlVGbHN3YjZMbjV1Rk1NbnJKaktoSkhtT3hsaFJxbnhieEFLN283RlQr?=
 =?utf-8?B?blNvY2MyWmYzSFBHa1JJcDMvRlVaNVdsMGFLQ2NZbVNOTnhWZGRlcmRLNnls?=
 =?utf-8?B?dzV2RHF5V3dwT1ExZmRCdUVGSWRKWHVNY3c5bDBwZ0pHVXpManZyMnBoN21Y?=
 =?utf-8?B?cDE2WXpTdXYvMUExR00rU0FOM0RWQklvM2JyT3haUjkyalVSQ1NraFBFVDNt?=
 =?utf-8?B?VndlMjVTTHFFY3BlODd5TnQrWlo5TThSdTJoSjVUYUVwc2haUklmdlNJbHhq?=
 =?utf-8?B?dzVKTXZxSUd0Y2xXSXFHa3FwZ2NvazZSN1RQRkZBVDhBM2E1c3BQdUJxclNS?=
 =?utf-8?B?a3RCc3dVUnBjVjd1UWZHSmZ2a0U5WnBPRDhwaTlWbWwyaHhMUk5UUXYzcDJi?=
 =?utf-8?B?WnhtcTgwZ3p6M29iUGxHakN2VC9kbkFqK1ZxQVZNR3Brdzc5REo2KzFBN3pz?=
 =?utf-8?B?Q3lTNGFFWk1SM3g2ZVBsd1ltbUU5MTJhZ3VZNlVoQVMrS09hVGV4ZjZGYVFL?=
 =?utf-8?B?cE5TTjFiM0hPanJtZmhiTXZJV2RCOW5xY1ZRUWdsOVMzQ1J2YUxGMkxzTk13?=
 =?utf-8?B?TS8xa2tmSWlPaEdQZy96OEQwd1VHVzFOcUgwaUhkUDhiRFAwSHNrRlR0YmZj?=
 =?utf-8?B?QlJRRHNXZjFXVnVNNzAzbk84TUd3V21wSk80WWJ4aWMxVDVrckwzRmdEVVFr?=
 =?utf-8?Q?unnTS1QziR25bjKb6ZujNkmZViWp2rz+uLPXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzZMZ0VaZFVRQ09QZGRpL25sckdOUk1GUjJxd3RoWjVTcVNuVGJpcXZGbWdQ?=
 =?utf-8?B?clZMd2Q3ajRmVlB6c2pOSzF0ZjhwZEY2Z3p6U2QrOXBtM1FNc05Scjdtem0r?=
 =?utf-8?B?TFcvWmNJRzFIcG10bmlISE5DdHZzcG0vSGV2bG1zM0hwM0NKcmJoREppVVRn?=
 =?utf-8?B?YmY5S0RqSndlK01DcHNlSEMyeGoyWlZzS2o1R0xvMnJoVlpqY2pMeVNJSVc1?=
 =?utf-8?B?Rk9PMXFoT3FidGJ1TndpTk1xUi9jNDZ5WmVZQ295ejhGKzNKUllJbXpqRnVm?=
 =?utf-8?B?TENxdXdoQjVxS2xZKy9heHJacWdxQjQrZUV0MDFWaWdyMXRqZEE0QU1xWExI?=
 =?utf-8?B?dS96TmJKa0RWNHJqMzJHNXRyaklSZTdsV2VOM1Bxdk1iWFcyeDNUelVsS3lZ?=
 =?utf-8?B?T0tLbW1zN2lJV1YrL1RDb0VXZnc3RnM3a1RBWnNLVDBmeUxyVEVxZkt0cWc4?=
 =?utf-8?B?YWF0OC90Y2lUbVVLZGo4UmJZZS8vSjNoczV0bFhxMUo2M1RncFJHV2RINXFP?=
 =?utf-8?B?dERhMjM5cHBJbHozQ3ZxNHZWN0ZTdmRqMVc0dFpXc2ZIYUhUL3lZVkROd1FJ?=
 =?utf-8?B?YzBObUVlTUN5SjQ2eEFrS2F4aHl0VnJYMTVVY3Z4c3hPQUNPbGhXaW91NWxT?=
 =?utf-8?B?N0JFTDhRdEdOZytyWU9uQkdiL2VkdHNGRFVCWENUZlZIQXNlcUoybU5sY1B2?=
 =?utf-8?B?WEtqQXFJMlU5a0dHbXRuZFpXV0R6alFEVHEzaVhtcUdxRXh6b2kwcWgweTNI?=
 =?utf-8?B?TkNMSENIN3RGcGUrTnFzTjJoL3UrVm5VdEg5ZE14alhMRkpZY212Vkx5amE4?=
 =?utf-8?B?ZzhNbDUrdkhHMUEzak5oOEpvSmdBSkNEZzQ4WitVT1dvaGFUNUJxdUhTdVZF?=
 =?utf-8?B?bUxKWjZBVnVsRnhPNzhBdFI0cGsydkVCRGFiSTNOSGxSVmxFaHpUWXhWSllx?=
 =?utf-8?B?QTZKdGVaU1Q5UDgrZS8yOVdvV3dEazRrSHFuWkxIQkdjWVM3TTZxSXF2K09G?=
 =?utf-8?B?cUF6OG5lUUVBajNENFNJWEZXNSszdHh2WHB0eWpyZHo4MXIyMldjNnRsZnc5?=
 =?utf-8?B?S0Zwb05aNHJWTWt0OUcrV09Jc3pEbVVPQTVmVkE2alZiMFBVUG1wN0ptcDZO?=
 =?utf-8?B?TGJrVTNOVFhlQUdyMGZvN2pNM05Kb0pBaWJHcWFUZXNFeGxHRVh0YkJYc0hx?=
 =?utf-8?B?RGlWTi9wZzVTS1ovOVE2WUhBWmZ3RWxBbVJYUldFM2xOOVAvRnN4SCtKZ29D?=
 =?utf-8?B?WEdpeDh3UTVBRVd2SVhWTE1ud0RIRTdqQWVJNklGUG12TENNOEdXMVYyY3Ft?=
 =?utf-8?B?RUxYUXc4YVQ0TnUxeDRzRTRLaGNLNEJIeGVHd0RCSEwwcGo3Skc0ZEZIZjFF?=
 =?utf-8?B?OTZtWDFXRHpmWlFOdGs0VUdnSG5qRk9YVlVhWVkrYTVKaGJSVzhsdUo3TEpG?=
 =?utf-8?B?Mm5sd21XVGtLckdlL0FBT21zOUF5SmZXY3hxUyt1alBXSXIxSlJSM2xyMFdJ?=
 =?utf-8?B?YVQ0ejRvWTIxcHl4ek9HeGdOb2hYcitzZXluOHdoM3prUCtSZkVZVEV6ZXpw?=
 =?utf-8?B?ZUVqNGorbVU3LzVWNzFjR05ZMnFRUytLT0FyWWlNZEdaR004YTRTejVFMExM?=
 =?utf-8?B?ckZyc08rZUt5VjI0bzR5KzNZeGZUczBQKzZXdmxGa3RnTDFhaStaNkErVzJO?=
 =?utf-8?B?WEw5cFpFczdaOUx6N1NUakIvWXYzWmpieFhMeVMwaHJCMGNsVitZYXFObTVT?=
 =?utf-8?B?aGZ5NjJBTXNlekdQRWZLcThmTDAwNHVjMFNoeUszQTBKZXRtdHVRdTgyTTFY?=
 =?utf-8?B?Nk9YSklGc1ladmxuVG40RElOUUNHTitHckNCaWRjZW1wUk1lSE9jWDA3Ylpa?=
 =?utf-8?B?bk1NRTExeXpqY0labm5oVmhRU0xiUnF2Vm9sMlh5eG1SbVM3WVo2U1JwSEdp?=
 =?utf-8?B?WHFvcmszamtNZ1NnY1lZZ1p1a1Z4SG9pUXJaZ3FkamtnSjk4MjlVT1JYS3Fs?=
 =?utf-8?B?clVtL2k2bVpJRDJ2eGIvVEdFQUNUVnprM1IyaGJ2TFppVmFYa1AyaWdkYmUw?=
 =?utf-8?B?LzA0SmxiOXJBbVVoUW9NN0tad0NJa3d4UldudmF4VVpOejZwWGNONnd0OEtS?=
 =?utf-8?B?WFVmNTdnV3hQZzltU1VZekU4SWJ0cEsxMDFRSjZ5eWlKV05zM3FQeDNxZGJh?=
 =?utf-8?Q?q+7IkK4MMDxU2wVxOvoIkF8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf1a9d0-8b0c-4a9b-8587-08dde405645b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:29:56.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hmAk2ZUlaXrZRHmWX00uy/iGIpT9Zw3Z5ye5tGpXMBKMLQJvdTavxRccJv4y/gHw/yRXeKCNkxxeNdLvN8k3gD2yIUEjN5OGb9lcwo0i44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9478

On 2025-08-23 12:39, Thomas Gleixner wrote:
> For RSEQ the only relevant reason to inspect and eventually fixup (abort)
> user space critical sections is when user space was interrupted and the
> task was scheduled out.
> 
> If the user to kernel entry was from a syscall no fixup is required. If
> user space invokes a syscall from a critical section it can keep the
> pieces as documented.
> 
> This is only supported on architectures, which utilize the generic entry

no comma between "architectures" and "which".

> code. If your architecture does not use it, bad luck.
> 

Should we eventually add a "depends on GENERIC_IRQ_ENTRY" to RSEQ then ?

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/irq-entry-common.h |    3 ++-
>   include/linux/rseq.h             |   16 +++++++++++-----
>   include/linux/rseq_entry.h       |   18 ++++++++++++++++++
>   include/linux/rseq_types.h       |    2 ++
>   4 files changed, 33 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -4,7 +4,7 @@
>   
>   #include <linux/context_tracking.h>
>   #include <linux/kmsan.h>
> -#include <linux/rseq.h>
> +#include <linux/rseq_entry.h>
>   #include <linux/static_call_types.h>
>   #include <linux/syscalls.h>
>   #include <linux/tick.h>
> @@ -281,6 +281,7 @@ static __always_inline void exit_to_user
>   static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
>   {
>   	enter_from_user_mode(regs);
> +	rseq_note_user_irq_entry();

As long as this also covers the following scenarios I'm ok with this:

- trap/exception from an rseq critical section,
- NMI over an rseq critical section.

Thanks,

Mathieu

>   }
>   
>   /**
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -31,11 +31,17 @@ static inline void rseq_sched_switch_eve
>   
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		if (WARN_ON_ONCE(current->rseq_event.has_rseq &&
> -				 current->rseq_event.events))
> -			current->rseq_event.events = 0;
> -	}
> +	struct rseq_event *ev = &current->rseq_event;
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
> +		WARN_ON_ONCE(ev->sched_switch);
> +
> +	/*
> +	 * Ensure that event (especially user_irq) is cleared when the
> +	 * interrupt did not result in a schedule and therefore the
> +	 * rseq processing did not clear it.
> +	 */
> +	ev->events = 0;
>   }
>   
>   /*
> --- /dev/null
> +++ b/include/linux/rseq_entry.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RSEQ_ENTRY_H
> +#define _LINUX_RSEQ_ENTRY_H
> +
> +#ifdef CONFIG_RSEQ
> +#include <linux/rseq.h>
> +
> +static __always_inline void rseq_note_user_irq_entry(void)
> +{
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
> +		current->rseq_event.user_irq = true;
> +}
> +
> +#else /* CONFIG_RSEQ */
> +static inline void rseq_note_user_irq_entry(void) { }
> +#endif /* !CONFIG_RSEQ */
> +
> +#endif /* _LINUX_RSEQ_ENTRY_H */
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -9,6 +9,7 @@
>    * @all:		Compound to initialize and clear the data efficiently
>    * @events:		Compund to access events with a single load/store
>    * @sched_switch:	True if the task was scheduled out
> + * @user_irq:		True on interrupt entry from user mode
>    * @has_rseq:		True if the task has a rseq pointer installed
>    */
>   struct rseq_event {
> @@ -19,6 +20,7 @@ struct rseq_event {
>   				u16		events;
>   				struct {
>   					u8	sched_switch;
> +					u8	user_irq;
>   				};
>   			};
>   
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

