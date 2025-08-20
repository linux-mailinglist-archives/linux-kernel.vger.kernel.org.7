Return-Path: <linux-kernel+bounces-777947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5BB2DF79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E63A06D92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B731DDA7;
	Wed, 20 Aug 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="roTDcDRu"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022087.outbound.protection.outlook.com [40.107.193.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92A31CA68
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700048; cv=fail; b=Ua868QEMNxgFLdvuzaD5mFM9uL6SZwqSyQt556EhumuwT4TzHKlHN+bPNnFjt2gveN2p2yEp47yFUsl85c0p/ky9+APo2fB7CX9NSMuLR/yKUw2dIF+76vckUUGl40NzqdecRhywMKgBB6qTcvi2qhPJpAqsM44n6HiSc2l1Shs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700048; c=relaxed/simple;
	bh=bQ4lY9Y05TP2Dp5xfPwVx7nx+lpaIMxkCE5Jf7pU1Gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qM+TJ80LKsqd7JAZjBw47zfzteuXIdpkXiH1pPcMZUqAiPMfZdCED4ls7kQt8DiD9F8RU3Icv0ikXVH3D74uIej+s5PdU1318gRDwUz0JNy3XFN2nUWXjeAZeeOVoOxvpwsurZh6P6AYPPccGfPmCpdm84ks9D11d4cnW//53yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=roTDcDRu; arc=fail smtp.client-ip=40.107.193.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUNJs5LtN8m28kHKc6EIsY1sQy/oYd0bZSeWTT8mOEdfnDv5QPE/VmAOUkiV8qN7ZcW6Qi9UIPSsU2slsBElbsGTfW9ZTcdujGZzoCuAAf3H4eccArdPBdbPHjsoV/zcBR5EHFoXqimWgdGSrqD1PXjUhKJECIWX85ZR6TlYNvoPRYAlAOCb4iy/1kqcNxEvGxKeUEnnWPZXUuvImwWPeZLW57m1CXzlcpal4ClsvQgxJPdGZxoSsJZYSfCm21srU7Cjit6Q6NU18mpdx7yh5IBJhzkaicfCKwxfiJ/BzEGgrLFnlZYS7S/vQe9Mj3OutRft01/+kMbZHFvr57+e3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AitEwntjMmb4y7H8vm+xOc4vQjiKtYNbnKbg9nkUd9A=;
 b=oySYVVROJZ8dBu3BwGC8yQIf3GWohRONAmt5DbcKYAFJ5sYdkiCqucrSG+3DsS5eUg6OpHFr07HUA7TXNi4k9OCnfQIkX3RH2fcdYni353VRGbQ4kTbxV8gkYcvwqhXWQK8sBMQ185d4i/O8CNIh2sDXbmC06ymgNHnWp0xbK7vzPZbaAekoTroJBHvcU8K//lXdBdg5MW2cUDXVHKME9UB23oYvLNq8FVOQA1rpLjkmVlvrX2pyYqBToqqoVI4ziyD5Kok6NA5BtBrZSapyfxEwyAOaJ1iBRf43lkKc5ITgG8OyZ8RxOQwUhk61MNSmGGvEAAbONG/4N8bM0vQOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AitEwntjMmb4y7H8vm+xOc4vQjiKtYNbnKbg9nkUd9A=;
 b=roTDcDRu9M18l61ooN4QwUSshlhQcIGAsdx9dmKscX8YjVPpKpNaHx8y5CAEfCd662Nurbn+KjsCAaJyLL2GjBhHx/gmzxE9XiVUTrtmwfALoW+6b+Q/FQVbrQr0A3P5UzJJpIQt7nK1BLWl4LTURrMd0tnVrx3hPXIqwkGirD6BDEN6tORdYO+RjM4DL2tuuy0rZeYEA/dAUoNDRCbWs7+r4V2R1+auX3xeLevE7VNsWqLt9FgHYzO7ODbL11b97rPTVajAu5ecG+GEFexgHQCY7F/7se5afOKbc+mqrY8hCntt3VrpkhrM8SP0VBvX4fqO8I+pt8a2fjl00eA2eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9132.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:27:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 14:27:24 +0000
Message-ID: <aa3b8329-59d1-4d6e-bccb-eb75a03762e9@efficios.com>
Date: Wed, 20 Aug 2025 10:27:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
 <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk> <877bz67u3j.ffs@tglx>
 <87y0rh63t0.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87y0rh63t0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0230.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::34) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: c17fa925-be06-438f-323c-08dddff5ae3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlhqYVlqVS92enVTUDdTcE0vYU1YbDNpeHRtdUJ6MkhCQmM4bHllUjM4R1Ni?=
 =?utf-8?B?NjhUVk9VWGpDazRKK09QSnFHR3dzV2FZeDl1WmZZWGlDR3plaVFhTVFPMWxT?=
 =?utf-8?B?dXN5Z3gxamxlUFVKM2dZYWVMcnRWTWllU3d3THh0QUJKWFpQbFRBQ0RTUVZh?=
 =?utf-8?B?SDZnck9weHBva2tuajVWYTRrU3RwaWw4VDl5cTdHRmlPd2t0UUZJMXZTYk4v?=
 =?utf-8?B?REQ4SGIzdUJlUFlwMG4xbHdBeDZ1MXNwL2ZRSnFvWjd6dTJQMFZpRG81ZGRU?=
 =?utf-8?B?TDNjVVE0WWR5U0RsYmVsRlhIN0cxYUdNNlRIWGN0b1kzaWwzK0xOVTBQMFl1?=
 =?utf-8?B?S1pGaWk3c2ZEZWxzRVNGTFVPb3k5WDB4bWZyeUI1MnVKbWlaaTYvc29MYmJE?=
 =?utf-8?B?b2VKYXBTSVpLeXBPL1JES1o3NGJyazBYMy9tdjVkbTNLZ0VsaWxjVElmbXpW?=
 =?utf-8?B?NWpxZU9CZkRLSUhjL3d0MVRwV1VqSzZtZE10Ui9UM3ZldU5TcHdmNHpwOW1S?=
 =?utf-8?B?YlRKakJkNGRvR2FwcUduazVVTmZUbFJlMTNFSXRBWUxaT05IMVo3Wk55eXlO?=
 =?utf-8?B?bS9SUm0vanNIVkhFcHpkbkY5NUlrRzhQK2dnWW8vOFBuR1VzWjRDN2MyUFQ1?=
 =?utf-8?B?YnZQQUp6b1pvVTRyWmVvNWZLYXFkT1VoblBXZTMzbWRFZjgvNXdlSDd6UFBa?=
 =?utf-8?B?TWJRcDBpeHdDN3VVdytwaHhlOWxxRC9Ra2JyUFhMcXJLeGNETFNWUE9sSGVP?=
 =?utf-8?B?VmYyd1pkM2g4aVpUL2V1a2x5OWx0QlVubmpEb0hKNTJCajJnUEpmM1hGSUFE?=
 =?utf-8?B?b2w3NElzbUNKZEdQU1FJRS8ydFRyazVKZzZhWXJQZUJiMUN0ckF4Mm9WVWNG?=
 =?utf-8?B?UHpZVHgrbjFLL0lmRXVIU1JRb0RNQ0tGeUQ4eUFOdDA4NEI3dUYxMnloaUJK?=
 =?utf-8?B?ZVhZbkRibWVoaXhTMENmVlhKazF5TG9IUVdvaUVNM1dEakdnNGNlMmE2RndV?=
 =?utf-8?B?Z3U1RXpNSytRTVAzdm8yMFBMQTAxbEhCV2lWUkI0Y0FrRGNVTUNiSHgzMU9p?=
 =?utf-8?B?VW1LZ3F3aklkMHlySzZiQmNtNmswTDNYMnUvY0ZGemJHQnNJbTZlY2ZmNHJr?=
 =?utf-8?B?ZWVBekZaK3A1T1BCOGY3MktjUVVSQzFtUHNNNjlSS2FOQUhyZDV1VW80ZDFC?=
 =?utf-8?B?TW1XL2ZUZkpJTytNTUdmbjJsUWVRVGV2MHJLb1JlVlBFOVlWQTB1dFA5L05z?=
 =?utf-8?B?eFMwajNDNEhTNDlMcHhJMzVkdzJUTkdLdFNXSlFQaWdMUHNwZG9ZaWxrb2w5?=
 =?utf-8?B?aEMrOFcxZ0NoTE8raW9MdDFobEZPVmE4SHNVZlNvdVZLeDdLVmZYREhDeERk?=
 =?utf-8?B?VWQ3WUhqcHR4cG14Vm1mbnlMRUs5aHFhREN0VCtFUmZGWmM1Y2hzVWNsQWFi?=
 =?utf-8?B?WFg4ZXByRld3VUtiUGJlZW1YM2pBaks3dEtlUGwraVA1eFpuekNQVGhDdjNI?=
 =?utf-8?B?QmZmb1RNK2p5dVNUQnVTTXdrT3hocm1CODFSKzc5dGk4bjVrL05ZQWtlV0pz?=
 =?utf-8?B?TG00UENlQ3lKYXp0R3lvVU5rUkUwbHA0SkRHdDRrUGl1VURSaGFYREpRNjNO?=
 =?utf-8?B?MnoxSXNTTGN3b2EvY0psVi81eFYyVFFiM3gxbE93Ulh3ZjNIaXR0WDVTMitr?=
 =?utf-8?B?cytJTFUwZlBHODFIcWpnQ3QxTUJSTFRVVk51YVJKVFlxM2tKUC8zdWRZRGpl?=
 =?utf-8?B?Y2hXM0N5OVdhZmd2dnhBWG9KU05GN205NUdUY1JHRzBkNjBVcVpRSk1IdWwr?=
 =?utf-8?Q?tQQ/TwSJ5cSy8eCbZBjhsZSIuLcYBkhoyngiU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG9MWTZZSkdxN0VaYTBPZytCR2NyVzUrcGgyZUl4akRwNDhVbjNsY1J2Tnh4?=
 =?utf-8?B?ZkF2K2NKQXY0YThIY2FWWnhLN1B3aGZxcll4WEhTUnNRSi9LVHhadmp6MzlD?=
 =?utf-8?B?N002cTBWWlo2MnZtQmoxNU51VzlpVUZaZWQyZ2RDTVpqZTlKYW1oSXBtNDhy?=
 =?utf-8?B?WlZwcGc3dnhGMVl3TVJsK25XV1JNakxIUVE1OStzT21jWmZCSG1RZk1sT1Fy?=
 =?utf-8?B?cXdmcGpUMW1oYWVDcG1yQjBVNXNzVHV5TzdXVk9WdHhtR0dSYzhCQ2tPcEZN?=
 =?utf-8?B?eWZPMDFNYUtsR2pFVTE5RkZlZHRxaFgyNlBZeXEyV3dTcDJ1VFRpbEtzcFpx?=
 =?utf-8?B?azU4d3RoYStDdGlpWDA2aExWWnBJTzVXWXdQTmlIeTVDQzduc08rcGVyZGdQ?=
 =?utf-8?B?RWQwQkUvcDNtN0tiMXNEOGU3QjIxd3pNQmRWanlzZyt1bmpzTm9WMWdobEFN?=
 =?utf-8?B?clc4OHAwUE00R014KzdsVkZOREg4Q0huRXY3QTVMWkU4aU80ZEs0ekM2bjN6?=
 =?utf-8?B?WHpxOGIzNlY1cVoveGMzQmJhbnJZRWtDYldWYmcvZ01PN3RnUWhGMEFUQXZw?=
 =?utf-8?B?UjUwZVNtdDJLcGRTRU9pbEhOeWNNZ0FRMHlVcGJYVUszZmdSSVZ0Z3F4Q2ls?=
 =?utf-8?B?TU5oTFdGRzZEZlYxRVBkQXlwOFV0czZYM1AzVzRIdnJhMnpVeUUzZURPOEE3?=
 =?utf-8?B?L1duUG9XYStnVzM3alY1dklzL2lmZnl0RzhiM1BwbE9sSkhsTDI3K0lpOHhH?=
 =?utf-8?B?VDdhR1VjcCs2bjlZYTBJOVhGTDFQYzhlM1JBUnhmNnpSQlZkL0pCeFpEQjNj?=
 =?utf-8?B?TkxuMktMaEF5eDlnOXduVXpsWVpxUVBWM3puTU9zZTZKSE84NFFxZ0V1ZCsx?=
 =?utf-8?B?QWdQZ3I1TDVSRjdhQkxyaGozdGpZakRtQjUrVStxcnRBY2tXZ1BraTR5QjB6?=
 =?utf-8?B?NkpPVUt3WTdQMzdVM1dZNEJ5TWNJaGxkcTBsT1pxOTJrREZyYzZwZlo5Z0w1?=
 =?utf-8?B?cXZBSWpJSy9ESGIwM0hob3V3Wnpkc1ZVcmkxSlNRT0dzc0t3M29ETnhlREln?=
 =?utf-8?B?VnhhWVZYY2gxQkdma1BRWkNEQk1ZUUNXanpoV09zN1VBTW04NkVLVUtGSnVn?=
 =?utf-8?B?d3FjeVZqdXU0WnFoaXdkd1ErS2ZNSzh1bGswSzdVdkJXOVpBM0tMWGwzL0Rt?=
 =?utf-8?B?RS9Pb3lhL3lyWVhEQUZ6UDZtYlZRcTY2MjZUZElMeEFWK21lQ2xseHN2Qk9x?=
 =?utf-8?B?UFIvYnh4aS9XK2NuNU9ENU85azZzREcxemRkRkF4NlQ0eTE0cW51aG5ZK2ZG?=
 =?utf-8?B?NktSTzNDd1ptdzU3dUZVSHNqMDNHNjgrY2EzYUl3MHN3aVg0ckpGQnZHaGlP?=
 =?utf-8?B?Vi9PS09LVGhxT1lPTWlqVzBla283ZUZpcHp2MEU3Vmo1eU44Ulk4a3Q0NVEr?=
 =?utf-8?B?M21IN3pNUDk3M0U3eXczMmVmZE5tRkhtQUVManJpNmgwcDRtWExCZ3JNRkRQ?=
 =?utf-8?B?Rnc4WUpzZnhHOC9KL0xRaU9jdFZnU2RyYktSdDRRaG82c1hud1RrZ3pFVVBZ?=
 =?utf-8?B?NG90NTZBNzhDR0ptRnljVElxT0NKZGpjc0RuZENhYU5tOHFTaHIvR28yNGJ5?=
 =?utf-8?B?TzV4KzNraHZKOFIvVXprMmk0VlVVMVpZY1VOcy9CU3o5U0NPaGhiYnU1WHBF?=
 =?utf-8?B?UXU2UDVlWk1IbC9BL3l6QVVjOWVTTkdxOU1Ob2Y4dXNYSnJ2MHMwMlkwczRF?=
 =?utf-8?B?dENMY0FhcTJ2TEVsa0hMWUQrcERTd2RvMHhIVXdUNGlpK25HbkE2R0Z0emht?=
 =?utf-8?B?ZnFuUVpPa2pUR2RLR2Q0K3k5U0tZL3FkcXc4UnA4aW5XZnVrQkZYaDZ0NWxI?=
 =?utf-8?B?RU9lak4ySjVvS1VtRnVYVFoyWFpaaUx4MVByRnU0NFFOWnl5a0tvOGg4WUJV?=
 =?utf-8?B?MVhXT3F3aWpaOW5EaGQrSmkvbDNIQWFZVzFZMjBpNjM0L3FGL3FKeFJoazlZ?=
 =?utf-8?B?UHhKbnhUck1JYXZRTjhlaFFTTExqVjRwbk5ySTNjM0xsYitJeHNLK1pvNzF1?=
 =?utf-8?B?Wkd3QytDOEpnTUkzak1QRGJKcHBnbmZQU2FFWWxJVkdxdFBxRGRrVVRQYUNx?=
 =?utf-8?B?SkN6RUpOWmkvdkF6Q0N2eWZJTFFGL1owTkhMUitNSFQwTmFjeTJGSjBKTThO?=
 =?utf-8?Q?Cxl3aycC1l//E6+c+9PvGzg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17fa925-be06-438f-323c-08dddff5ae3c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:27:24.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX6icyZrkyKRNfnP2n9p6PxPerwuAWfcxTfxXVt8UAKHVxXD3HzL4N4gq7v18j+BnSbv1QFn1whIqPZL7q/gwdemTRtKvhF5hXlpNOEE9KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9132

On 2025-08-17 17:23, Thomas Gleixner wrote:
> On Thu, Aug 14 2025 at 00:08, Thomas Gleixner wrote:
>> On Wed, Aug 13 2025 at 15:36, Jens Axboe wrote:
>>> On 8/13/25 3:32 PM, Thomas Gleixner wrote:
>>>> Could you give it a test ride to see whether this makes a difference in
>>>> your environment?
>>>
>>> Yep, I'll give a spin.
>>
>> Appreciated.
> 
> Please do not use the git branch I had in the cover letter. I did some
> more analysis of this and it's even worse than I thought. Use
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/wip
> 
> instead.
> 
> I've rewritten the whole pile by now and made it a real fast path
> without the TIF_NOTIFY horror show, unless the fast path, which runs
> _after_ the TIF work loop faults. So far that happens once for each
> fork() as that has to fault in the copy of the user space rseq region.
> 

OK. I'll stop reviewing this version of the series and wait for an
updated version.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

