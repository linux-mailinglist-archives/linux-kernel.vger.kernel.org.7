Return-Path: <linux-kernel+bounces-874202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98234C15C14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E1A3BE86B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87151345CAC;
	Tue, 28 Oct 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qouoAfNW"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022086.outbound.protection.outlook.com [40.107.193.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8233A024
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668053; cv=fail; b=pe71JJZw4p99JPxKWPMP/Bs9Q1WZFJpDAsjDDTydPBM8MRkOL0nzI2Mb1OL7kU+ahrDdHQfdhnwmYC/oUTBlR+TpW9ynoNSLSWLtrSyqSiw1O7o7GRIjqSiOGqxbtI0jKI9UT4mGt58J/CYH88Nz06IC2AAPYkCKfZ3OryUwGhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668053; c=relaxed/simple;
	bh=47b3v2tqWJ2LEiwoLMVq3eErD8s3Jx/gAYKrr5pnI0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0t5jveRENwuKEbMIJ/LmUdsBn6hVZhaO4rI9eUF4Tpz6BJi6XRYSd88oIjCiz+3kqgPfMe87hzQ+VLs9Yi91vKjh2AAcxMIfig+nBFNTCGlGKAWH+ftiDGBwivugyh3A8YWm2+5ky2qyU4X615mImN+tbfDri1LfHO8WfyMos8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qouoAfNW; arc=fail smtp.client-ip=40.107.193.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUMcA3W8usG1PFRQvsB0HNJSW/rlfEsgn6hPknFn/44d18/JK8YkkO55zbENaWTdwZ/7uyRGtotbC+hsJg0dykuhIzLDxpkzZYcBCor2YOaRZ7jCX8Ew0HTJY3uu3mUevKUQRaZ9cl2GlvFkNFcygXti67wgw+mX3kU5ufw5xUyhL3S3IMv0M+0t2QLMowx3fIAsnOIoADCNsbG53/0XNzix/SYflRUzwa0caTpT4TXbb31WgLel9uJXQdsqeEc/eff3TNu9uizlq/QsPc/boSjoYye7VOASA+p/W706efTisgRY78vcMGGYCeqDfBNFIXp2gn0c6hZT27WSLG6Bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxOeVLFtqedJI9ndHyyAZA/XqMwRg6VRPs++u2BLYKE=;
 b=FJJSyeI0WYPCDbJrnzhi30HDF8V5Jr+fIrlfyMiw9WgoRtMd/n8pbSWYMwV7kqakFuZmL3fgcLl7hxuMce90dUJvXwPT37G12xhWIRRrili0VmAdUPpM7RZMajD0lFJPVvdqcdOUiGp/RH4wvjaze7Kc3/5OfdF3crCgL8bHb6nSUayvOeaKbujJBAF1Xmia3DhV9798w3mwOh1VHxLrH3h7scyyFXJmtRt2RDxwrqJd0YAbRJE3QI6vbuFU57H/bW9xTKASIPCAvkdMlqKLKvgi9PqkeXWjDdW4LCFdStoaHM/HA9NROpUe1kWXSlpdwEBS2KpXIOW8d/m1rN6UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxOeVLFtqedJI9ndHyyAZA/XqMwRg6VRPs++u2BLYKE=;
 b=qouoAfNWyo/Pg82NnbRnlo5L6YuqbiXhKv3UhmWL/55/erYrAqsV7UPrlgnQb7KTmk5GeQqjjNCvHMV8ZA+CnckzpvpVHXjD7P28UF/AjiSHAsOcW4vqgF/z+16KCGwj2r9n4Xc9UIBSciP60f8M5VEIUDgm3yTxlov3gHYNsNnMjd8lMb6rNPB9778tZV+sPvsRDoeSf/46QwNOftc/CioGZGHdpypy+gyVkVl9L+ZYedE8bBtrl+2ydgwJOFUi1Dsiva0vYWpIVsM8njHBY57wBLt3K4c5fCUpcuNHFOQMGNdxh/awzRh8lLQEniapEP2LrJ8LwX7ol3e0eaEHnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8356.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:14:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 16:14:08 +0000
Message-ID: <e0ce68df-1ca3-416a-839c-8f4d8981707c@efficios.com>
Date: Tue, 28 Oct 2025 12:14:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 28/31] rseq: Switch to fast path processing on exit to
 user
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.701201365@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084307.701201365@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::21)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 053c006c-7739-42ac-53e9-08de163d0584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mnl4TjNXS1JKbFRrMnpURjRlOVYrZ0Y4eDJJMk9IQW91OUJuMmtmK3VmZ05V?=
 =?utf-8?B?bG43T2R1SEVndjFjTWc5ZjVkeUQ0L0w5Wm90OXVxTGx5Rk5yWG80VTd3dHZy?=
 =?utf-8?B?V3h4eWdHTXZ2dDY5bVlMT0Fpak1JRUpUZCtJWHhFdGF4RlUxaXRJK2t3UGNX?=
 =?utf-8?B?NGFGNEM4bnRjaWFPblRFcVFQcUxYTUFkb3J2cXVycVdIVTZoTE01SUxoeHA2?=
 =?utf-8?B?NFNadUtmZDN2N09LcnpVcEk3UjN5ajB6Y2FsVnV5RE92ZlhKMk9vTUZ1b2x6?=
 =?utf-8?B?SHNLcy9yK3JjdmNRcDVqT2p4UkxYTDFLVFVXaFo0ZUQvcjBaR2FUTzJoQWNC?=
 =?utf-8?B?RlBSOFQ1M21ZK0RTek42R2JmczlVZVNyaFd0Y0lrbDNqVHd6eHdIbVFPMVJ4?=
 =?utf-8?B?VzdXcStlNXVXYW96MEhBN0JMK2tmM20vZHRlb2IzQjEyYWR3eGZtYWhvQ1ZX?=
 =?utf-8?B?dlpmblR6dGczNUlOQmNkS1AzdUNRdUVzY3R1TG45b0pGOTErOTFkSlFYK0ZI?=
 =?utf-8?B?aTNRWGNnNFRqVHhDcFpvczgxSStBcm5HZWV0TnhrcG5xWDZyYVUxMDJNd2to?=
 =?utf-8?B?KzU1U1hSdUhSYkRtZmtFbVArU0ZyMUZadFRiOTZSVzNzVWlIdHFuclZET3M2?=
 =?utf-8?B?dXE0OVBZa25IYzdOTkgwNmlNUUNKSkg5K3ZQanI2VXh2TlI3ZHNGYndIL2Vi?=
 =?utf-8?B?RDBwSFJkTjBJdjJlYTZwcFk4bVVWbGZwc1F3d01MKzZHa3ZoaEk2cFpaV0Zq?=
 =?utf-8?B?MnFWc1BLaFpQUkpqcUZUMlIzRHNRejZEUjROSUd1YklVMXkwU0VSRXhRWllw?=
 =?utf-8?B?YnNmRFFGSTV4QWhuQXZWVGRESGRrRU8rR3hwcnBaaU4wT29uT0szYnpLYjhW?=
 =?utf-8?B?SDJZWDFzUS9LRjNUek9QNUoyYWpobEZnYTNGMGlQd08zbGdvSXB1ZlFObXJv?=
 =?utf-8?B?Skl4UVp2MDhlWnJmanJmcDU3NlJxMTFXallJTC9FUUcyNk5QbWdNeDc2clU3?=
 =?utf-8?B?MHZOZ3J6VkxqeU1MQUxEOXlDdnBNR0dBZmhwS2NXbkI5cHJJeVRpSk5IRGx2?=
 =?utf-8?B?MmNzRVJSN0M3NHhIS3g1SWFYYVZFaW1BM2xFSXpFTTJNV2xpUFFua2xTMlht?=
 =?utf-8?B?YzZpUFVmTTBSWFMwYUYrL1hHQ0JodmxKRHdzQzJTcjhvZk1jLzJVZk00ZTA2?=
 =?utf-8?B?dTQ0bG1DcExvWFhoUGthcDQ3Mmh2cWdva2pNVmg0TlRFR2VJUzIzK0E3eFRv?=
 =?utf-8?B?WWM5LzAwOS9BeW9mNnNOOFhSUEZRWG1XMmtYRmtSamJRUExGQXJIeks4VlYz?=
 =?utf-8?B?N0FpdGxRSlNuL3FUNGRGN1ptTkZUKzMweXpkWTJ1ZW5VT0JEYmlyNFVWaTRk?=
 =?utf-8?B?VnV1RVJodFgyZjh3elpZT0g3RmZ1U3pUU2dFWXpkeU9PUnBKd1Z4emNibHF5?=
 =?utf-8?B?RkFJVmUvUFlML0FhcVhlZEdhc1N1U2xmcSsvdkQvK0ttZHNCZjZnd1lYbVZY?=
 =?utf-8?B?MldFWlVRbTl3dzVleEYxQkFlaWhHZGVQQzUzRGhIZ2VYSGdEbkUyMGhHMkZL?=
 =?utf-8?B?NDVhdDN1ODZLTTFKWWFIMjJXZWdsRWdWTXFQM2F3L0FWY1JYd1ZkWEc3djN6?=
 =?utf-8?B?dnVGTHZhdnpJeFZ1QWNDQzFIbTl3TlBnYlVZbTVueDJ6ZmxJemZIejBYK0JM?=
 =?utf-8?B?TVFNVm9aSjcxNWtJQTFYZVJ4T3hma01ucHJhUE52dzFjbWFhQkxraENCK25F?=
 =?utf-8?B?UVNsQlA0MDFyTmdxcmtySU9MY1VrS0kwZmNFVWx5clpicE0wMmUwRUQ0K2lG?=
 =?utf-8?B?QVBabjN3NFBJWnZwcHppSmM4NjlOYld4cUdWQ2VpQXlISENPR1ZzekpTTWFV?=
 =?utf-8?B?dEdSVm40SmRHVFArakkyS2lpdFVib25SVWtzTmRmQzBDQlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2lianFFNWkrUVNaMUh4TllpRnZETjBNbDBNcGF1RHZpRXZ3ajV1NzZ2TWFN?=
 =?utf-8?B?M2t0SkNZcTJrb1R5RTJoMVBVNFo0TUdLdnptWVhNcWJGVTI5dTEyblkyc1Bt?=
 =?utf-8?B?TS83ekVsbmRzeWJDajZ2ajZ3Q2prcXJCcDl1azYvOURFTkt6OXdJTmk1OXJF?=
 =?utf-8?B?MDhlNzdYVEpiL2lRRkxoVVBPVXhEWmQxSTRKWU5kK0Q1NG4xTDhKM2ZVcGpz?=
 =?utf-8?B?Zktha3N2VVBiZmZNNkUxRmRZU1NrV3FMeUhuZ1JuUnlnTDg2R1EySUdHVEFQ?=
 =?utf-8?B?M29TN3Vudm4zOVVQY2pRUDB6NFArRTVpM0s0MzVXaHl1VW9FZWtwR09jQW9P?=
 =?utf-8?B?dU5uTlh4K1U0RlJOSHlFTE4vUVZzcENLNFA3MTVCR0ZSdnZYYXlEZjNtMTBn?=
 =?utf-8?B?UFVURFg0VXZuUUdNajJxalUrSW9MSVk2bHVwT0NVYlhUSmVIU1Z2TGt5Z2Zv?=
 =?utf-8?B?dVV3QzBSSU51Q1lqeXNrSEdiOGx1cTU1NzNpNzVJMHRXMlpvNkt5U2RNYldO?=
 =?utf-8?B?M0JLVGJlczJ3SmxPZ282T2htc3ZJdU4zUHBHZTI1dWlyWGtCaUJxVCtmTm84?=
 =?utf-8?B?VFhab1E2eGVScU1BdWZZVFVIaUhCbzhQMzd5cHQ2RXlibURzMkwzN2Ftdk9k?=
 =?utf-8?B?UUt5Zkl5MDlQM1ZIcXFQbEhkSlE0c0dIOTg5Y2hPMXJub2hGVWZLTmpJeW41?=
 =?utf-8?B?NVlJanVCb0ZlMEovRTByc3MwRFQvcE9mTlJuMmJaZ1RXdlo4Q0JycWp5YXh0?=
 =?utf-8?B?RnpMMFhNZlZhMDlNMHlCQ0dqUCtvQ2dPSDltN2VhckIvaWdPTThtTDFZTmhh?=
 =?utf-8?B?d0RCV0lkbCtuZS9zbE5GYU10SmtLWWNWeG9yamJXRDVZelRFaHFsY2hwNzQ5?=
 =?utf-8?B?bUpLajQycmJDanhBYnE0VHJNNTZ4WUV4YysyTTJyeGxTR25oRE1kOStNYkZI?=
 =?utf-8?B?ZlZJamwvdU9FQysvZ3E2U09FaVROWVpBZUwxbXdmaDNuVVQzYmNEakduZmxo?=
 =?utf-8?B?bnREM0tRcVFDRng1ci9Gb3dsWWNtc3Z3cUpWc25rcE5MOUVpQ2QvZ3QyMDE0?=
 =?utf-8?B?cVg5ei9aeTh6TW5GVmdIYnQyM0ZzQ0NDTG9SRGlQN1loMml1NmdMVHQ0ZTlQ?=
 =?utf-8?B?d2d4R2Y3TTZrZ3c0b3hYL1RmcDYzcDM4dFRvWVYraG8xNmErN3VsR3IyR2xw?=
 =?utf-8?B?Y3lNUVl4SFFOV25CTFhiZHNCOERjN2ZMc3dnb1pueE0xRENOT2ErdjZKNlo1?=
 =?utf-8?B?Q243eEt4dUtTMzg1bk5pWE1uam5FVm81SFRFNlhBUGZVTzI0MEdpK0pRNlRr?=
 =?utf-8?B?aSsySUxQWnJHa0w5akdZcmtmejJSZmdUdXV6UDFtamZMd1g4YkIyZy9pVlRw?=
 =?utf-8?B?cDc4dVlQMjdBaUw1Q1Fab21NQktjTmMzQXNDakszck5EUXhnZ3JPZHVmUDV0?=
 =?utf-8?B?dU5oM2pudTd0WUN6TklnMTFqU0IxUkhtbXdtQ25jeFdVMXI4NnRPeWxLRGxp?=
 =?utf-8?B?V1RTdi9DK3MrSkNna0hpbkRsVHJ2bXVkbVBlWFdVYTVoVVR5UUY3V0RzcXRZ?=
 =?utf-8?B?UVBZYWkvVFlhU3h1bTR1N2ZEbHF2N2M3Zm8rYUtMSmY2ck5Zbksvc2IvSEpJ?=
 =?utf-8?B?TmRmNzZubnBaYjMrYnRFQmpqNnFGaU1mUnVtTDlvQ3hYbUZKMTRuNlhYdnBj?=
 =?utf-8?B?ZzZiMXc2M09rZ1M2QWpTdXFFOEU1emhkSE85d1ZRY0J4NEJtaVVYdythUVpr?=
 =?utf-8?B?bEIrNUJxbGhPRy93M25YZ0twUFVEMnZ4aGZjaUVlWENXeWZkMW1icm9RdTVa?=
 =?utf-8?B?S2NqK2lOMkdTUFJDMnI2U0RQVWp6eTg1a2J3bnArRHQyNUgwdXhDSkxvNnFW?=
 =?utf-8?B?MXZERlVoOUlrUzBxZTJwbUQrSFU4aEFCSmt5TjFuMzR0S1QzVVRhLzNZU2dF?=
 =?utf-8?B?UjVxZks5emxha3lTZHQ5Yk1PREhVUFdQc3d4aEM0d0l1ZU9uR2d5MGVsRUZL?=
 =?utf-8?B?TUxGTHI3RnN4WXZRaE8yWXFGT3dPV1R3NHpZamhtUUpKOWEyU25KSjYzOFBL?=
 =?utf-8?B?cUFJWFEzbnNHMjZBUElFQTJXbTMydE9QZHRJWUxod25JNC9iRHd5MzNOMXAw?=
 =?utf-8?B?bWFuOVQrSDgwQ0d3eVVqeXI3cDRVeG9FU2tsNTlCL3hIZlNHWVJ0VEd5TDMr?=
 =?utf-8?Q?IKf6ShuPJF4vEeUDh2bH35A=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053c006c-7739-42ac-53e9-08de163d0584
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:14:08.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IESJqEeyjTLXK2xkPcDOo9Un0mHIwYS2Xq0akuGzxw8O35jePEpb9B5p8jg0E5iJPWd3RlZwTHsidnuc3yMz7I2DB1+mzpB4cptImXxnB/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8356

On 2025-10-27 04:45, Thomas Gleixner wrote:
> This results in the following improvements:

Awesome! :-)

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

