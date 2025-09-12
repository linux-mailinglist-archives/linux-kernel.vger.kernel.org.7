Return-Path: <linux-kernel+bounces-814767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7124DB5586A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C5B168CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203AB26E161;
	Fri, 12 Sep 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FFtXFmb8"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022141.outbound.protection.outlook.com [40.107.193.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAD2BAF4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712789; cv=fail; b=MG0WBy3iDDHfSqFt03cbQPkum8H+iQG6w2rWGzBCcrOP/ulxnBlv1Nshb37ENuulfYFumXbfEg/e8k508k32PXiFEvM04OsUZAQIh7N2cB/7ooT+Nofv8ABdZCbvpDvNFx/2nFg0LnrQnZzp+sXKr6UWTYpy8XYUcbC3bB1U4Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712789; c=relaxed/simple;
	bh=kv0roAbGJJO+jENLurL98A42wBv5Xl9f9uULntq4CI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tTEajv08AGWFbmUSa8xky8T4Q9J/qaMWcryHLvtCZx6ex6MDR/6KIef/TDkhLvsIbgGY1iPaZ3TRvD7jhdHA2F+Xe/iLgMNeF04fq8S8cw6GCJQptcXKIpr07ErKYgl4+wZ2GUTymbniO9hpyihCUMoHGXXGz1NqK4tuzWz4ECo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FFtXFmb8; arc=fail smtp.client-ip=40.107.193.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRGrVgxJm7HlpMt9M0aXy6tz66f5ujdsZzMM/8ejpyhMHc8L4v5AdmjmohB9IPbL34rtJgK3ooQ0RO9arSawYZkp5tYATfKtjttCnYnPFBPzfaEcD9rBdOMzjGqBjPsh3D4xa5j0meOMoJj+IpVV2ZqrmKeZTRdxcD7hYKhtnKEzgMSnoPdwb4tRI7UMjO1/THk6wAFIVv3qwemUX1Pgaq1nSS4IvBVAR++rDyPuOVoS8rgIckQbA5fAmo9RQb9EA7HYZZJtckMaWdRUUlVyvjhlbop9MJc0Mc/hnj0Rj3ln0cB+29nPTOrFxYFX+qVD+9+OSOkaDA6qAFql2G0b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdul8x/DOfxdp3VYm2Ph3t+R42DYO7Ji9KeoSlzGsp8=;
 b=lff8d/uqq4OzrO/EDM+Me+rN6Z+8NH8NGdIPenQUmH8NWSHh8Pp/yVfiasHjMoZC+I398suTUMuW/18hd7tVC+blE4kD7EhD4fMlcoDmE/0xI/a8N1j16zUEgYxISXGxITJH/HgJc9jfmItOSOslqBtC2UlWo1uyg6gd4G2ygqQn6EeoaZhuFOB8+14oaSndusftwgxsQnNmCbhgArepgy+C8Vj72hPHmIACBL652bA9ViodFjuzfwIWNy9/WFUEVQ8wzcB7dHvVMjrD5GdutCdo6tuptSGV3k4410nsl1NsAq+udjeLIgNy09pPZst7kYmFe8ZUtB4nkrxEax5t3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdul8x/DOfxdp3VYm2Ph3t+R42DYO7Ji9KeoSlzGsp8=;
 b=FFtXFmb8cGcGofjVGm7HE3MS0Sj87zZZSWEsFUqgoPwPrnHvhQL1upL2sMXUe87iVGJTSKtJpDpESQadLxt7fQzXmioi/RBRqR/WlfLZYNZBH78AH5Hx8trd40etsJ4J0N+zVsf0R9oq7YaPZ916T2HdsXho66dNKkrh6HibFdxx2QUcFUx6xbGFzsk/6RU4gBLI+mgIIgiJOUZmQ6sFgtCrXHGlXIZpet2pNRpNuVy+C3rsRrb4tWQbh+n1dAEohklGMk6XbVGzRuuCJy382oCn0Yi/kRII/Mu9anuB5RAg/us39mUqtNrx5bSBsYiPeVQ5F1vHuu4VjAz/6afdxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT2PR01MB6514.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 21:33:03 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 21:33:03 +0000
Message-ID: <493ebce3-dce9-48ce-8aab-9fadfb215ff4@efficios.com>
Date: Fri, 12 Sep 2025 17:33:00 -0400
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
 <4d653cb5-2a1a-4f11-96c4-289976ac8212@efficios.com> <877by3qu2c.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <877by3qu2c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::27) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT2PR01MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c1640b-953c-4e99-4a22-08ddf243f369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnJLL05sYzVEWGVpNlAxZGExTWdJcGVZU3REV21URlV3LzlGaEs5cHlUeDM5?=
 =?utf-8?B?ZUNzWHRFU2RBZzc1dWlCYmxIWFVQWGNmYlJ4TVAyakpwbHI2QS8zcVNKd2lo?=
 =?utf-8?B?bkpPaWZzeTRkRk4ySkkwMnJudlJGK0ZnUm9nT1dzZTZ1dTh2YnRhcG1WdlFD?=
 =?utf-8?B?TFdSYVZkc3ZuSXFlNFFobVFONGJFTDBnK2hqNHpjYlhETHlUd3M1N2lhRGk1?=
 =?utf-8?B?OHV6VkhoSU92aTE2S2piWjVGeitaS3BJaTF0REY4M3g2WXFaZU9hY1JXMnlJ?=
 =?utf-8?B?dUhBcGFIMURDMFg2NnVDWC9YVitzWTc3dVJVZzFMUThNdGhNQUtsOG04Tjcy?=
 =?utf-8?B?ZXZOdHVYdHA0OUlMT0oreS9mYjdyZjlHdEZvSUlXeVQ3K003NkljSDRCZHhH?=
 =?utf-8?B?Zmo4SDhPK2M0OS9CVzg4SmhUcW5zdEYySlI2VHgwdDg5dE5kRytXK1NDSEF2?=
 =?utf-8?B?RW80ZElGM3dpQkNOMHEvbVM2alVTYmtTL283b2pUR0VmeUIvQTVhUTB4dDY4?=
 =?utf-8?B?YVN3ZkJ3cjIyZkZSU1dyaDdCWTNaNTFIOG1UM0lEa3hGaHRrNnRjUDBUdFJX?=
 =?utf-8?B?SGRMZW9pcnM3OGxzU2VBbmZBcWtYWHZ6VFFOODBpbEJObzdnRERadWE1ZDRU?=
 =?utf-8?B?RGdTZnZvY1B1ZHBGY1dOWWQ0UFgycXMxd09oWlJlY0U1U3AwdmJwR2JpUDBB?=
 =?utf-8?B?QVB3cFZ6K29RcnZtMjcrQnl0eXMrTjRQdEcxT0ZUQmpvQWN5NHlvdlBlbzFN?=
 =?utf-8?B?ZEN4WTUya3ZmVDZuTUVkQmp4ZGxocXFwOGxTdVIyU1JzTFVGYTNFaUVpTWpS?=
 =?utf-8?B?Z2Y4bG5FMjRGSEJIdkNnbW4yYjZTS3hKQ0UyRUdNeURLTWI5NnNzakwzdVFJ?=
 =?utf-8?B?WXk1WGc5TS82SVZZd1BLR2g0d1Z6Rm9Icnh0NnZSYmJCL2FhWERnSHAyVkFr?=
 =?utf-8?B?TC92VXhBYUxsOUpDZVIweEsxUWNZSkx6NUVacjhPeko3NVhkaDRFUENCVVM3?=
 =?utf-8?B?VTk1VW92ZWxXNjZGWWIxcUlGc01DQUptU0t3ZTk4NWtQZDhCWjFXUG4rMGU2?=
 =?utf-8?B?azhiTGRWcjdiZWVMVmdmUjBVd29vL3B0ZFN6OG1WMzZkVllRQ1BJN0Q5eDJD?=
 =?utf-8?B?L3RRSmJmTWw4cGd6MUFXQ05JYVZuYU81aUV3cmNDQjdsem1MU0tYUWJuM00x?=
 =?utf-8?B?NnRsS1V4WW12eUVQU3NOcXZNTHFJWnFlM3FCeS9hS29XT0NOTTIvS2lEWGpu?=
 =?utf-8?B?ci9IWDhxT3pLNGFMSjl2cVNhcnR4YmgwR2JuQ0pkZVlkZFE2YWpKMzg0eXRw?=
 =?utf-8?B?OUluRzViM25rVmpRRHhWakxzQmlmZ0lmcnUxdm5OWjVMby85c0d2cDVQUVRj?=
 =?utf-8?B?cWx0WmFyZEk1dHZCZ1dobjgvUTBaaTJla1JLWE1iQnVTcXgvSTJJNy9HS28v?=
 =?utf-8?B?NHZ1QjFGUWxJYy9KK0dnbkp6c2NDdmFOUFZjSjRUcmFxMW43aHQ2K1J0U2Er?=
 =?utf-8?B?Z0hjeitkWjRyOXRkRkJEaFN6dnFXQU16QklINXlIQjdWeHVYRjF1aWoyMVB3?=
 =?utf-8?B?NDJ3czBsQ3IwenRrcFhxMkdYWlM0TXIxUWhhbWZjOG5MZzlNSXdQVHE1dk12?=
 =?utf-8?B?TTNiczczMFRkcDBwMTJyaHVtbW5ZZkNoUlh2SnBzQnhoeFAwaGlJdjhHMUZF?=
 =?utf-8?B?bzdrMDB1aVAySlJPWDF6eVovVDdERVZKbVRONThJbmVwT2VXRGNDVnFPcW81?=
 =?utf-8?B?Q3hSemU2S1QvYzFBMFZtNU5IM2xucWE5R1lTcmR5NVhZSExlWEZ4cjhwbUhQ?=
 =?utf-8?Q?1S1by/pPAHNi88OOyxX8ak5uuizbFDT0t1i04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjRSd1d6cElmZ2Zjb3dudldMMzU2eFhtd1ZrNmNmQWdpUkxmQ1NmNm9ZN1N2?=
 =?utf-8?B?N0lPSkxvMmdRVWFhRWRiWXdQZlNSYXYxSTRBQ1hpQkxIcjlBM0x4WVVsNHpC?=
 =?utf-8?B?OCt5ZDNZN3JLTzdqWkh1M0ZEQUFMcXFhR3N3ckdCK3VtcVRtd1FUMW9vcHFZ?=
 =?utf-8?B?UkkyVWVUejNmSnpnc2hSdmoreFk4dURTOGdGME4vTFFPcGNZRmJHMjM2KzE2?=
 =?utf-8?B?Mm13NkVRcGQrKzBKY3JPTXBVcFAwWTNmSmJ6TnFOeW5PYnM3MTExbFpzWG1Y?=
 =?utf-8?B?dVdlVkFKbXN3N2s2ZkRhSmRaeHdXT25HejdJZWYzM1ZqV3ovYkFmaGcxeTZT?=
 =?utf-8?B?YnVjS2twdlVwNE4yekR6aVZOVkFjUXNKZ2t5TmpVbERNRXhrdDhFRE1EZGtk?=
 =?utf-8?B?bHFGM3FqUWo4cmw1M3E3TFRPVG01UWc5TDlPdDVVS0hkM1JPTEY2NzVzVUNU?=
 =?utf-8?B?UjdQbFVIejM1bExGYWtEUWg2azRTVmhlb2h4U212bk9xcVFmVTBISjkyckx5?=
 =?utf-8?B?VHVUR2VtbkRPSXl6amhUcXE2WkJ5QkZqZU9DV0hISDF3Y0czaUtLbHpoNVI0?=
 =?utf-8?B?dHFCQ1Jqb096b3AyZEY5dHBjNm56ODVmR3U0MWtRQllIdU9HejY2NWRXRmhl?=
 =?utf-8?B?OTdERmNDa0lDVkdGM01Gd2tBbXcxL3lkQ3NQK1FMcmJyTExMVDR1OE9IVkRL?=
 =?utf-8?B?Rk9BRlEwajhDQnhYbUFFTldiQWhZSU9mRUhLV0lWdG45UlFIUGhZSExiVk5W?=
 =?utf-8?B?TnBnV3J4amJkV3BVQk5vb2g3SFB0dWUvdXBPZTM0dVlHSWZhZ1c5S0xoajdj?=
 =?utf-8?B?ZzkvdldyeHEzbGFsdGM1bzc0VU41NWhPMVNQMUVNT3lxVlRCVW9rd3oydlhk?=
 =?utf-8?B?NkhWQzBGaVR1VlZGVmhrU3VaWDk3QlVDNEx0b05UYlo2OGZDRVpVRXdIQVZE?=
 =?utf-8?B?SGZCY2c0bGRQcUQwWEdoSWxhakR5RXRCRnZEeW0xUXZ4LzFRbUNRVExxaEhn?=
 =?utf-8?B?Z1lHMTVLekZEVFR4c1lvaWpUVDJBd0JLKzlDM1VGZGRJY0ZxTGx6cFFVSlc1?=
 =?utf-8?B?QllZYk91cHhWSjBLZzNjd3o3T0UxVUNSZC9HV2M4eFovZi9keFpaN1FHM21B?=
 =?utf-8?B?ajVZTUhscVNGTWdPcUNhY2FMdUdzbDRDOU1Pb0ZzRFMxazNIVVRVcjExRCtW?=
 =?utf-8?B?YTg5eGFTRTN0bkxIK1NUM3FLZ2hxYnpTVUc0OVFiSzRhaDE5L3VlY0cwRitZ?=
 =?utf-8?B?SE90V2drcGZ5OHk4S3VRaktZNFV0Yk1CdUhhR3RHaGp1TEtwYVVZQnN1dHQ1?=
 =?utf-8?B?UnRsTjk1NXNCa21IVHNmbDFpTEFOWnh2cERsRHdpYmZRKy9uNUpnOVg4Lytp?=
 =?utf-8?B?UVR6OG9vbEVmZGpiYXB4WjR4bnVvTXJScExiTDFJN25rUzltVWVFUVVzWW54?=
 =?utf-8?B?cUh0OHZXd2V3eUVjclVlaklCMHpSZzJSTzdXV0FPbTd4Z2Q2UTdGVVRqMytj?=
 =?utf-8?B?RVJHdThrOUR6SUZ2clpxSE8wakI4TmtWeGpZUjlXTndrMnlPRFRwMDladnN0?=
 =?utf-8?B?bGlncVNFaE1XQTN5dnd4V0RlaHBaNkptZWpXNmhBVEN6TzBTMnVPQXhvM3hH?=
 =?utf-8?B?RkhhT2g0bDBsOHRSQjE1ZlhMWmd0R1VEaUpoK2tHeWNjQktRaU5Fczk0a0kv?=
 =?utf-8?B?RzE3R1lKVkJzMzRYQjVkV2RMVG1ZNXdpajNabFBoLzZjMFU4VnZjWHQ3aEUy?=
 =?utf-8?B?a1NwL0tMejNpaHVGNWcrTzJ0R3dvSjBNdGtKc3lxSnVWb2hMTXpZd3lSMWQw?=
 =?utf-8?B?WUtaQWVtZG5aaHd4THZDYW5wb085T1JISmN2QUtiVGRBeVBLZmhVMlBoamxJ?=
 =?utf-8?B?c1cyS2xaeXBLajNBdC8zMkp6NFVaenhJLzNaMDlKeFlsaXpEK0hZTlQ3c3JY?=
 =?utf-8?B?b1JFRjYyOFpGNEhSdGZlNlFXSEdUL2MrU09rRmNiYTdZUFM3eUNPYUVKc21F?=
 =?utf-8?B?MUVPNVZrQmEvT0wwLzE0Qmdaak5vR0lrYW13VWphVWlrblRlMTd1YnYrNFU0?=
 =?utf-8?B?aUo4ZDhKcXRqcVI0M0paa3JHUk1INnB1SlllSmprL25lY1ZnSEdpV0ZxTXJU?=
 =?utf-8?B?RGh0U0lPRWc2U2VOKysrQUhxdjhQSmhXM0R4TGJNOXA3TXh4Q0wxQ2JueHRr?=
 =?utf-8?B?WDF5MDhtRlFBSlpvNy93L2tYeE5IYm1nWnlaYVdWMXJ5SFlXOXdYU21YSlAy?=
 =?utf-8?Q?82dbkPGmpRgaq9AAx+8azTH9fvUucyL6JQsRI+c0wE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c1640b-953c-4e99-4a22-08ddf243f369
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:33:01.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov5eN22h7sf7AyhTpCJWwFBEg8I6t4Jvq0s8C/KledZUX9BEYAJ48squvEd0Lc5oKr1MMQMUYH97gUYpQRdNOx8qTbTBjhN/wjCo52io4rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6514

On 2025-09-12 16:44, Thomas Gleixner wrote:
> On Tue, Sep 09 2025 at 09:30, Mathieu Desnoyers wrote:
>> On 2025-09-08 17:31, Thomas Gleixner wrote:
>>> The boolean members are defined as u8 as that actually guarantees that it
>>> fits. There seem to be strange architecture ABIs which need more than 8 bits
>>
>> seem -> seems
> 
> This is an inverted sentence, i.e. the subject is after the verb. Let me
> rephrase it in the regular sentence order:
> 
>    Strange architecture ABIs seem to require more than 8 bits ...
> 
> The subject is 'ABIs' which is plural. Therefore it requires the plural
> form of the verb 'seem', i.e. no 's' at the end.

You're right, I mistakenly thought the subject was "architecture". My
bad.

> I'm not a native speaker, but basic grammar rules are exactly the same
> for native and non-native speakers as far as I know.

Neither am I. ;)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

