Return-Path: <linux-kernel+bounces-874066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D0C1576B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3726E5045F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E75332EC6;
	Tue, 28 Oct 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LWaKlekw"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020122.outbound.protection.outlook.com [52.101.189.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EF257841
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665179; cv=fail; b=pqb+S+tlTOqLucZgqlgYzNfFMs6JaEl9TLWfXDVAoeY2zcXCLlD0rxRssiG/ksSsSkSxXIQfNVJcQ4BVIoNlIxlvWcBtgIUA10U+KI9C/hJ4dO3+nrvcFZ/IuIGNrgLSM6fo7aBQGyh7nVA57RGzZOAhWCJ3cPspeChNfo1cbHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665179; c=relaxed/simple;
	bh=l13S//0Z3E6UI2mEEq0779xQbQM5XiXNKll49X54n2U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1SZhFDO0L1k7qjyrVD576vT5ca0P6gXPKiszs8XVH2ntxnJtITpfTxIelc9Tz9wv5cZCHw3ZcdC9k6yEHyxqDQ2gGYOF3ijxkWw3Kugu/pDaPZuIVQUDdnm9uuij+M7bSEAJBewfYEXkPRkth6vltUTUpUGqJtc56xrnawWL6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LWaKlekw; arc=fail smtp.client-ip=52.101.189.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4fQ0mNrjsaJl3D2eB0jfKw8G+94JpCHR3ii35s3h/wfR4zSBp8F6Pw/UhNy7jCrfNJSKG8OxYW9qcWfPEfITpdN7zqiofkGXV1wW2gMagq3MWprpSaH86nRQ02hBhh+tfh+IIbAquek8+MCfvTZ4mgSid1mKf4yQkpdhTvmZaMEvnw3l0C4HJW18M1a7YK4cZlmL0AHWWoD2JwcDSbA4kcobxEPX44XBxxupM3hPDsGrXU3uq5VL3X53BhU3v1qNmbFIH5SaYAhQ+s+F9t1StgIPFwzgnAF9+MxoG83z+M1TfzZ6dY+Wy6AVQ4d9ODyHixXUQlk+dDr4U4cxuXmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOhlF4Y+LrJNnXGFNF1aoTV4/NIDwk8R73ilhvgLfmg=;
 b=GidKSrQ6L15hiLPFBiJMAmvvAyJhylOeZGwZtqoCSdWPqGOFkXrWG6FXheBmwFECSOsMi4u+6nqAz2aCUe8PWcqI4kCL73fvfF2yd4DrF4toq5+ansYvQ5twj4zZc2giexYDXG8y5ABJUpCNVj4iX548GVzrK+Obn1TdEX6p4r2gEqmJyj2n58F4xcEcWSV6MqjXMxK552dao/qrf+5Y7zVlfP7fBfnIyNg8D/fnwMp2BiYATVKQoKjvscZkhQznZAYQ41kocG72brlGNMAVPiBEsPGrmk68PluVXkFHaX6FraIa7w4uaSGCzhtAuI8oiLSbM6s0YErl7NkxJDFScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOhlF4Y+LrJNnXGFNF1aoTV4/NIDwk8R73ilhvgLfmg=;
 b=LWaKlekw2Q88+k1+fE5s8pY+3WEVhzcEcbPArIcewwmx95skL2F2JZtsrWDIUHSX138Li89gWaOE3yupnYoyu+A9uvP8GU48wx5xVpcRiJLu+1Fe47AFGD09CLkHMmRefDhgs+AYYZyCXdnG994h+58cqwkz83ovc4xG0RAK9u9gRbDqpJ91/FjalVviIMEFsda6YnzI83HHcrs44CbKr3hQveguEf17VSWI5Y192o+hQzQrvfm1zNlrCRKzydNHXh6vXsAsvGXOYfX9i7mnnO5c28Bm4G/2JIMHMJWM1adNaHlAMyA9h/WFMi5xMJEIy6nmfwWkc2GjoS/KORz4Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFE8D3DE690.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::59e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:26:13 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:26:13 +0000
Message-ID: <05d439ae-8f25-4b23-bb0c-3a3ce04eebbe@efficios.com>
Date: Tue, 28 Oct 2025 11:26:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 15/31] rseq: Record interrupt from user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084306.905067101@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084306.905067101@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFE8D3DE690:EE_
X-MS-Office365-Filtering-Correlation-Id: b80013f9-a182-404b-1491-08de16365407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFJsYWN0OU5HMGtVaUIzMGJrckZoSlpGVDhXRVdqOUtOcEkyc3dRZjk2VEhB?=
 =?utf-8?B?ZDRlNlhoK0k1T1JhSnZzVXMzZWdGdWM3ODdiRGx2b2FJYk1FTWV0NWlDaTdw?=
 =?utf-8?B?TCtFaDVPRllKdmtmSzRsNDRFTkFnak0zeFZEdG52SUJQc1dGM0N3aWJ4Sm00?=
 =?utf-8?B?c284cS9tSkZtYXVsYmJkaUF1emoxaTdPWDVzdVYvMjYxa1lpc2k5bHQzK2lZ?=
 =?utf-8?B?cWhEZVY2NFRNTVNwQ2hsSlVmLzdCMlZOMG4zSzFzNFd2RlhBSnNWdW95R01w?=
 =?utf-8?B?bDRMdHlaQ3ZBdHZvL2dxQ3AvemdhT3RvczA0aDgxbGpsL3ptdmo2R2dINmdP?=
 =?utf-8?B?RDNRazYycGpQc3J0RGFUMWNubVdaWWFNUG1xWWRTcS9mSy9yYkR6UjgzUWlm?=
 =?utf-8?B?SG9QNEcwdFFCbUh4UndtaVVzb1dmWE14a1l3eVJ0Rnp3dDlFWkdxWElJV0lF?=
 =?utf-8?B?SnErUzhWV0FNcGVabWJBN0luWXVhOStBUDN1MUlWWXFuKzZQMXIvOSt3RC9a?=
 =?utf-8?B?Y0hSTEU0TlQzdEVEWTA1MkNpWUR6RHZpTXZxYWJ4bVdDM00zbUVTYUw2eFRB?=
 =?utf-8?B?aFhYYno0TytybVVPZkFQK3Y2RTVyaDJSajJxV2lxZjA2eWl5QzcxK2Z4MjVr?=
 =?utf-8?B?NjZ2UW1TaWZxdkM4SFdrTUNKcGJ6WVNMaVI5Tis4ZGduNFhoTHVoRmFQS0xU?=
 =?utf-8?B?TVFaTTVQNnM1WHpiMVZ4Ty81N1RSbUc3UlF1RW9XbkpJMlljQ3dRVUpVUVI3?=
 =?utf-8?B?dWVKNmdKNDJqUCtqZjZxditIL1UyL2RiQmZqODc1elp4RkZKaDdOSjN6R3Yv?=
 =?utf-8?B?VGhCUENUNTlwWnpnb1dYMlgxWVd6SXd6aStWdmcyZk5JN25hQmphMytLbzFa?=
 =?utf-8?B?N1RnWCtDV0FYdEdPOGRydXVCL3FTKytHUGZpcHgyRDB4R0ZFYjRzNU9SMHpC?=
 =?utf-8?B?QVhuZ2Z0ekROcGtnSDJnbmhjSzgvQkR2dGpMUXM4RTJ2cGxTeWtCa2JLeXRh?=
 =?utf-8?B?VXFRZGRyTnNMN0JsZjAvV3hTeWQrOXN2MVVFY2tBdUZzOUdDdVgyOTZMaU1y?=
 =?utf-8?B?djVlOHNPbzRKM1Q5VCttOGR5emhUbG11UStsM0NMYWMrSXI5c1dMWlUwQWQ5?=
 =?utf-8?B?Q0gvMFpVcHJQSXBrRUYrSFZSTGxMZHJzcU9BWXVDK1RqUEFKYXRMQXBpN3Ry?=
 =?utf-8?B?SURwQXdqcTE4dUhCQzk5VHVKV0U5eUJ5eGx5aGI3andENDZmSlh5UFlwd2Q2?=
 =?utf-8?B?RUR4bGtSZUJ0Q3poZFB3bkZkMEVPSEtjK3IzOUV2ZnZWUE5OUTkvWXlmWlZu?=
 =?utf-8?B?UGhieUFSWmxYbDFxV0xWV0tEWHV2RHZHRWI4WjcrVnFzNHdnR3UxWVEyQVF0?=
 =?utf-8?B?QTZhQ3NjMllKYlZrYUl6QWlYU2dia1RQUit1K3Evb1R0ZmY1NTBjejJORWF2?=
 =?utf-8?B?eFBWWDRQU0NoZG5uejBvdUkxUFV1QUFtK3NhcHZrdmlyUmt3Unp1aVdCbGo0?=
 =?utf-8?B?RXpWaFVhTjEzcTUzcncxaWkzMlNOa0Z1TDVES1NyZEkxUzNFSlZOSzNibHlQ?=
 =?utf-8?B?b0tnckZ5TTc3a3FXVkd0Q2E5S29kV1JLNzgxeWhxazBMeWNBYi9uNFM3V3o1?=
 =?utf-8?B?RHYwQ1FwdDJoN0JkRGRBNnJoUGRlbGkzYTlYaTVFOWR4UCtQVjE2b0JYZlFF?=
 =?utf-8?B?L28vMGMwZmMvT1g1dWwxR1llYyt1R2xlb00rQ1VyQTZXWkdCcmgrMTRFM29k?=
 =?utf-8?B?VTAyMDVUSldkdi9PU09zelhyV0YrRDl0RHRaLytEeFJDSWhFcmUzYXZtcGlP?=
 =?utf-8?B?RDFkdGJ2aVNTeSt4cnN3NHlNYjZyZlZxVjV3QUYwUkNPaUZ6RHlrNVFWTHRR?=
 =?utf-8?Q?Hn+vgqFel0J8j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHdhK3BobGVEaURaUWo2TmFFeFRrUkIwUUh5Rlp6ZGZrUzZJSE1IT3JKWEll?=
 =?utf-8?B?WWpybEl0YitUVmZxSFJWK0lWRkhGTzlRTUtOYjhIQWZTclRVVndtMHNoNHph?=
 =?utf-8?B?RXBRWnBKMTNwNzVyVEh1YzhDWWJZdXJXdzR0MVBzMEtGK3Vhd2NVd2F2WUda?=
 =?utf-8?B?SXR1STArZXN2NHFzOXk3MFJtcnUwZGZtOVhEaFh3d0xqcXJYMFNieGhIUHR0?=
 =?utf-8?B?TTUwY0dmdDNOd0xTTXQxSW9oS0N4YnpTd2FJV2JzcDFRL2FFUG1wZVZnZnZY?=
 =?utf-8?B?VXUrdUJ0U1hRSEtZeEVzNXpHUXM1eHR3dWRFbEpXaEs5QWphTXFEeDdwaytt?=
 =?utf-8?B?VDBUVXpHZ3VIOFFrNW1mMWdmQStRdTMrVlpTc2t5S2k1RUduQ3RzeUJvajAx?=
 =?utf-8?B?QytrL2VsTnNjOGdoRk5zbEZvVHM4Q2V2M1BxLzZEQ2pHa3dVRG51Z21xOTlJ?=
 =?utf-8?B?SlgvQUs3WlBERmJUZlArb25OWHBZcm5FNGZtcUpYeDlKYVorTE5XSTVrckhp?=
 =?utf-8?B?ajFLOHh6UUJVQzRhYm1qQnMzTXlreXlxQkJkK1NDYkZzM0dlRThWRGpTMWRn?=
 =?utf-8?B?aGJrVjBJb2Y4cStMUm5PNGZPY2RUSXJYOXkwMGFOYmZEbE1MWWtUN3NRd3hl?=
 =?utf-8?B?TFRYUlJuTGM4djQyNm82cE5WY0I0U1RvalNOVU51Wi9UR1BLWndXZ1ZFS2cw?=
 =?utf-8?B?eU9MZTk0TUN2T0dSWDNGM1NnaEw4emRYZ1BhSlZFZ0JTQ2xmWkU4NGJYaUxv?=
 =?utf-8?B?MS9xVkZNaTB5cURZdXZuVGVzNFppOGhQZHZtbmcvNkFmR3ozdXNCNUxISUZZ?=
 =?utf-8?B?RmVVa3NZVVRiV1hFZnppb2tHZ080aUxOb0VkSm9hdzFBY29zQ09ma1hMaWRQ?=
 =?utf-8?B?dTk4TXA4Zm0zc2QvMzNwZ1ZWZzE2N2xnZ2RONkRJUytnNEFvak40NGZDM3JM?=
 =?utf-8?B?K1p1dEJNeHIydEd3RHY5VFcrUXo3Qk5zdjZJVHVJNGl1empicXVpZEZzbmsv?=
 =?utf-8?B?Yy9oaGxNQzZIMi9ZMVRseHNXdGYzWDU3cU5kYWVTaE9NVjBLM0lCU3c0WGxP?=
 =?utf-8?B?emNHL3ZqengwUmNuTXNnTXMzQmlaTmJlUXE3WWxYTlpPTW5aOHY0MWh3UnQ1?=
 =?utf-8?B?UlM1cEVHditzVFRSWTU5a0p5eUtROHlaZCtKRUNFaDhBbUpnNjR5VklyWERu?=
 =?utf-8?B?NS9ESGpJTldYeHlZYU96MTdaSllTSDhveGtyK2c4ME9TWURUcm55NUVRdUww?=
 =?utf-8?B?cVR4NDc3YjFCRlRPNFdMSWU2dU50cHJ5NXZVMUpqWjFvRU8zdWNGdEVXYlU1?=
 =?utf-8?B?MS9JVmJ5bS9uVytJVW80NTRlTVBUdTQ1V1BSTzd2QzhNMDlZSzN2VzZVbjNK?=
 =?utf-8?B?aWtXSXdYV2VEcTE5MGNJQjJqOTduMGRlUVRwOG9EK25PNjltM2JpS0tsSlR4?=
 =?utf-8?B?VVNHOGhKTVR5QXNJTVR3WG5zQUNRdUQzYUVzWmRNYmlzQzEycFJOa3pWOVJW?=
 =?utf-8?B?OXNTcDBod29pYWIyamgrbXlYMFhWaFMvM1hnWTdVaC9remloRHN4eDVJeGlE?=
 =?utf-8?B?cVVqeC9JNk9PVG95bG1XUUNKdG5TV2FQT1FXNnI4U2xtT0F1K1p6eEp0azBu?=
 =?utf-8?B?eUpCWEl3cG9PZ2VCcVZpNmkzai92VkpScWg1U3l5T01QWW9Id3Y4OFVoWUZV?=
 =?utf-8?B?aXo4Uk5kMHVzUW5SK2l1NC81c3VDYmxUaUM2eTVWZ2FLMW5DcTlWclV5WHd0?=
 =?utf-8?B?LzJ5ekZDTEpwU0xpVnMyYUZwRElmWmxZNmtmNkV3ZHVPcndxOWplRFB1dXht?=
 =?utf-8?B?bGJOVXdPS0xMeXYxOVJhY0ZQRUU5VW5xb3ZjU2tiVnJBdk5zRHNUUmJJWU11?=
 =?utf-8?B?KzRnNkJKSzFELzNUM1NGT0g3SCtOak1VelNZVE5xMEhPaGNLalJvbXVkNEhx?=
 =?utf-8?B?UTU0RG9Bd211YnYrMm9QcmZCV20zZEtaN2FHN3ROeHJ2ODUrcFkrUW1VV2h4?=
 =?utf-8?B?L08yaDc0WU1uaFBKcWVTdE5heDJCSS9YYitURlhhUnpXSEg1SFRtQWpkT0M1?=
 =?utf-8?B?VU9TVHhrOE9TeUd5bjZWQ3FpVnJoVi9HZ3dHZklYdjNmMlFXNmxUN1Q1Uy95?=
 =?utf-8?B?SVhxM0tJRWJpWGNUUHduNjhLbVFZTkpBYWVPNVVvdkhOZnZDeE10bVhmUWsx?=
 =?utf-8?Q?qGPzskLW5Pwdcv/DiJGOnZE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80013f9-a182-404b-1491-08de16365407
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:26:12.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xtW80qelA78nLjIGtmWlGJBeAn6rdAviGyDZV0rOdIsIT44ev8g+aG0ZwT7PktMuPIqzMeU3kzv4RtNpPsXM9u0agSw8uHiO/TxWc9dMUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFE8D3DE690

On 2025-10-27 04:44, Thomas Gleixner wrote:
[...]
> @@ -281,6 +281,7 @@ static __always_inline void exit_to_user
>   static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
>   {
>   	enter_from_user_mode(regs);
> +	rseq_note_user_irq_entry();
>   }
>   
Looking at x86, both exc_debug_user() and exc_int3() invoke
irqentry_enter_from_user_mode(), but there are various
other traps that can come from userspace (e.g. math_error,
exc_general_protection, ...). Some of those traps don't
necessarily end with a signal delivery to the offending
process. And some of those traps enable interrupts.

So what happens if such a trap is triggered from userspace,
and then scheduling happens on top of this trap ? Is this
skipping rseq ip fixup and rseq fields updates ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

