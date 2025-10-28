Return-Path: <linux-kernel+bounces-874155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7ADC15A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FE6403CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785E34321D;
	Tue, 28 Oct 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BiXrT6nQ"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020134.outbound.protection.outlook.com [52.101.191.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB442367B0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666706; cv=fail; b=fobw4vUpMhcm0NJwr10vKu8d8U64kFO/GdRXcKf0FHO7vxP5vhfGXl/YpWIxP8WnI4XQbBfGt4PBSy0yfE3vINYDaIoSlFORyCxrweu5iANCJjbw/2HmUjFb5lqPG9n+nmPwawRh8jgX4snXa+my0p1kSY6TTLGl9Yua+pIVK38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666706; c=relaxed/simple;
	bh=O18qkEdPolBnDRfzC42EO9L9cXZtLA+is63N1Mv1PEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2L+TgS5SUNCkGZadkpsnKDRBSmX2bgobPiqNNO48W7xoUsYEJHHC5sERiHIAIpVQ9vt9P8Kn8uTabn1WVRs5RYh2KHgHQC6pxzJ3goMTfVMgPDP+PmAMnFh8DFRkVHgfGssZPaGJVbkT4sPQpdkH4QMo9+b3QFiJLfY3Pp0vrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BiXrT6nQ; arc=fail smtp.client-ip=52.101.191.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/harn8afu0fEeYavIBTemEt+hBSmceC5lXYZYJ/4JGw25qjbgmeWgkvapBfoqZ2BH2+avpRPACifGB44l/b3+xF4AmCvpobSYpMfk7y1hjRjiuxKWi7jE1RUh9P4u1S46Pfde4+omf1dxavccNYmxgyT1NVGVhweENSsTz5C/tnsn1+eWjz7qfcC9JmRvt7GOwmJ5ORjaUyjllcohros1K8NTu5FwtCqWpOzpEMzsvb/U5RlU9VZTtXdrXMeo7bi9JHsPQDMzx9USiOEXkh6hqTx209tLpJft6XPcS9igpvRWICyT7upUWAN97k9mPwLBzYi2vSWTfz6DN5Hei1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dGKfUmylyX8pucpn1d1t8bMvv8mDeRwLvywxLla3/o=;
 b=eM/l9DtrcIw/3Yt/v1kkJal91kK3o1bvg/CjkyiwzJeu23k1oYEWXmEwG+37ei8VMzHnm8shg7iG5WbxQO7d+U8PJokoSNrfot8OdWq7QOdteRO98WkeKhcGOImaRaLWD61qPLKhdW/fZjhVeeSkCXHF1mS7n/Dxa6Ar9YZW41BNl2pVcXaeLhOJTXd1Ec2Ezf7xT8OAeLERP32EdFoG50eyW/1G6R4RZWqxk1CEhaEjfIB/RKiOyPRmdeaW4eWJjTOtDPO3ZDpHnCnpSwVm6t1wRmP4H3dqioBiSJXhFzqNVOimZY6o/FVCwuPOLOeuTImjCIpRKy2cNC9xM6vBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dGKfUmylyX8pucpn1d1t8bMvv8mDeRwLvywxLla3/o=;
 b=BiXrT6nQTFOtjJVQ2sjTnNT1mFREjt8ZBjMi7cCPGD+1avo3IoKolgKOtMXPcXOA6OtLK5I4+EE8Cfno8URiCOqbsBOAFVPqxUU4DvOCdJFcbcHniC4E7t1eU/oNj7/R+uXODR0Vbu4Dpeho0hrKCsZsLiKUaGzMKqnZkEIoaP8YDE7Pq74PJiOoiI6VHwgwKCCpAPIctl2owts4Rl9VjyLSiuS05ra0IIUBkqyfoIVfB/DXrBxLuOGZZzwZpZc89k3/ivN03Mqi2x7OVIR+swCxaK207IthnyxgFuQEygMr9NdcwbyieBi1RyuKwT/qeealnhrUo14x/zpduIEcVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10568.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 15:51:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:51:39 +0000
Message-ID: <626e9ac4-e59d-4d88-8428-e215b9c34e51@efficios.com>
Date: Tue, 28 Oct 2025 11:51:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 24/31] rseq: Separate the signal delivery path
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.455429038@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084307.455429038@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10568:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4a3fda-8787-4a82-aeb8-08de1639e1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG12c1dNZlVhYjkyQWRLeURlU2xlL0dvYm9NTk9HU21ONU4vMkxqaUdRQVBX?=
 =?utf-8?B?UFFHSjhoS04rQkFmZzJScWlQTWU4SWhtcDdHOThUcldaeEZIQ0NkOXRPN2Q5?=
 =?utf-8?B?ZDFwbnFkQnpCaGJ5cy9PcGxTdkRYU1hPYnQyVFFRZ3hlT3NHUVR4ZmhCaFZz?=
 =?utf-8?B?WlVKcTZmT0tCTnd4VnZyZitYYlFJTzBBUlArSVFETm80aFpadjk0ZkkvTFV3?=
 =?utf-8?B?SUJRaXIyK1c2V3IwZWd3WktiNWRRQW1WQ3F2RzhtV0dCVzJwN1hqZUczTW1u?=
 =?utf-8?B?V3JQL01SV2RyWXFSTTczR2ttWkw0VGFNVXFYQmg5bWpyUVJMUU9RcXZSTkMv?=
 =?utf-8?B?Uk9RZkh0VjJwaVgxSmZ6YW1TME42NDBWV0IzdUM1NUxWRXk2LzVTN2dROXNr?=
 =?utf-8?B?RHdvc0RJQjc4VDU3QTBtMDZ2MW93bXN3a2ZLcjA2NC9sRVBNa1FDdVVzS0dU?=
 =?utf-8?B?SEVyc1Z4TGc4SFhpKzZqSmhkYXFaYU9GdHRCQ3FRUk9xSG9oTmJKNGY2ZGFn?=
 =?utf-8?B?WmZ2UVQrY1pYVzJkREJ4S0l3ZGVlKzlzcU5Za2VBbGpaT3VLT1pGcEQ1REQ2?=
 =?utf-8?B?TmxsS0ZvZC9KMmM4TGZQSU9pSWdTYnEvOEtyT0pZS2RkUnlQUEZsUEpJbEwr?=
 =?utf-8?B?RjA4NFhUekJiRCtQYjFpUmZCK2hvbkEyTnA0MWprUlp5QVVUaHVFWGxFdFZ0?=
 =?utf-8?B?bG4zNFE2UHorbytYTkhkelJ0cjI2RDY1MGJJRWZ1RXBzWkxkaTFtWGZ1YXVa?=
 =?utf-8?B?QWVlZDlZaFVmK1htR0c4UUsxZ3lCNjZlbjF4cnRlVllCdTYvZGt5S2IwSEkx?=
 =?utf-8?B?M3BibGVYdWJUZUh5WGh1NVozaTNTZGEvbVpVN3BOa1VKM25yVDdUbGZpZ0F4?=
 =?utf-8?B?Q21wTmhPN1RwVmQ5Z3g3aVZFeVgvbXExWnJFWW1ENExZSDhvdTNOSkp2d01w?=
 =?utf-8?B?MlFYaDBNMHRjQlhLTGtBY3RPWFlwWGxqQjlCT0xhNWJRU2NpdDV6em1STUNK?=
 =?utf-8?B?ZHNUYVdBeVhCeUkwU3dYRGhTeUJzZUxyNkt4c3p0NEE2cG5CS2Y1enZVb1ZR?=
 =?utf-8?B?QjdGby9qMy9ZWHFTOGhOK3k1RHJmV2h1NmdaM1p4SzRSVGl2SEkyWkorazNM?=
 =?utf-8?B?TUtVMVE3SG5ET2Z5RW1mTmFMRERyRjc0V3RLSW9JeXpBSUtuaXA1M1JLdDky?=
 =?utf-8?B?UkJrL2M1RzNEbE9GeWdtN1duRTdwZzBRdXB5b0pDZGh5aGpWc0xkdTZzS3kz?=
 =?utf-8?B?ZXJ6c2tqWEplT1JxS2dFZlZoQmRaSUNWZ1ZxTG93bzV6QXE4cTN1dVlJcFBn?=
 =?utf-8?B?RGZMenhwUUpZa0lWZjRoMjZUYjB1dEd5eG9rKzd5dTEvdkd4T2M1R0dBdmZq?=
 =?utf-8?B?c3YzRVVwVTdwSlEyaDZyMUNnM0c4UXAya015MmlMVUZaaHZteHc0Zk81SW1p?=
 =?utf-8?B?VFY1MjUxTDdvREcvNEFhT0t3eG1xT0lYanU4eFAxYWdCQTRadHdrTGg4RThx?=
 =?utf-8?B?cGI5V0tVaTZGVkppb2k2bW55dkVOeU1GWU91a3FlQUJjL3VzQ0VpdWV1WlB3?=
 =?utf-8?B?dHFMUTN2dy80d2tlcDA5Qk0yVGNsY0NHeStEc0pZNUlWTlBLeEFZd1BjbVZn?=
 =?utf-8?B?c0pFRXZTK2xjTmFxSC9GczVoc3llZjhnVzd2TG1FOFJFYnFuci94LzhUVU0y?=
 =?utf-8?B?YW9LeCt2VEJwcGM1azFGT3ZxdUVDQlBnRW5VWUliSm90UGsxaXZvVnNubG4y?=
 =?utf-8?B?RTdoWUFnWWlJNzdENGM1UkdydXZScnNTM2FQTEV3Y25YcGVEbXBCalhadWNN?=
 =?utf-8?B?d1J0UkJiVzVHeHY3d1VKYmNPMzVxdGc1TkppNEYvWmFrN1ZHbnRrajZhcG5x?=
 =?utf-8?B?ZHFYSExFRVdXbjdzZEkxZEJpOEVHV0RWenlqbHV2aHlvcGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWx2cEVyYnlpNkt4QmJxZ2piWHBHUmJRTENjTU16c1lMczlmVFJpVUVrclFW?=
 =?utf-8?B?cnZBWldHMGhoY3pubFdZZkRzYUJOTzBaeWx5UUdZY0lSbWx2SDl5TkFrSVRo?=
 =?utf-8?B?T1RjMThxMDhza1FZYStQK0d1dGVoVytiend1WXM3NFl0VU8vL3NROUpoc2Zi?=
 =?utf-8?B?YWpQWWhBcEtVTUphWDFJVkJqT2k2dS8wS3MyekVrSUNLNUtzTzYvaWxNYW9J?=
 =?utf-8?B?VnUra21KQjU4TUZjSk9IdmNoMWNOU1dBZ0pIVFBKajRIdmhIL0lJMWExTjFr?=
 =?utf-8?B?MUhuRG5uN3RFeFFqMHZ4S0lZUXRsS0xHempIRXdOanVlbTZxcUp6UUxpcDll?=
 =?utf-8?B?QUtYQUdLeVk5RWdURGhkK1E4Kzg5KzNMcWtQdjJjeUkycEFIVWppTTJIVGQ2?=
 =?utf-8?B?cUg1V3pzZkcwNDlLWlcrUmtpTDRVRGxNTUFndGFiNGVQdFlCT0pTb2VRRzdH?=
 =?utf-8?B?dENEOE1uYTNyRDE4a0Z1T215L0FkK2pSNjd1RzNYR3l6Sm1EdzBBSjRhWFhy?=
 =?utf-8?B?UkdaSjhraEFMKzdnb2lJNFN4dnhpM2NIanRvQU81RWxtbTBNUDVvVGlaZGRZ?=
 =?utf-8?B?TmlGL09rUm4xWnFlRjk4V09Xc0Rmc1JzcndrSllhdWdvZGNHdUUyL0NWNjRV?=
 =?utf-8?B?a1luZTI3SFVIb3Q2ekQreGVXN2hEVGk3cW9rMDAwNzlBRlpDa2NSRUpjUllu?=
 =?utf-8?B?YmFpOGdsQWt2aytUU09ycDU0cXJZd0Z3QVR0UUdCeS9mTGlLOXVQays1c1p4?=
 =?utf-8?B?OXJlRTluUmM1S3l0TURxcjJ3SGd0b3FiZ1Q3c0Z6MFBjMTlVZ3RVWjIrbE94?=
 =?utf-8?B?ZXc4YTdkSC82Z1hnMlYxTEJUc0R3OHFvWEJadWl1a3dXK2NFeFlKZ21pTGN1?=
 =?utf-8?B?RkZDMS94b3Axc2NpYXZzbEZqTnZ5bXM3YjBvd2JwcTdhYmlkeEFkWlFWLys1?=
 =?utf-8?B?dDRkTS9CY0lSMXJFZWltM2NESThnS0sxODJMMFEzVkRqUzV2SDNwTXBGWGJB?=
 =?utf-8?B?OHJnbGovWDdReHNkUGlMRUMvMlU5azFkS0RyVjVUdlRnWmdKeXppakJpYnVY?=
 =?utf-8?B?K0l6Q05yVmI4alB5WjV3NUxKbS85WkxTc0MyeUphOEc1VXM4MnNTRGVRYjRz?=
 =?utf-8?B?SDFIYzBISUdqWG9aQVZnbGxTZDRQb1dYME9TajZOZmhwTEU0S0tTeGZXT3BO?=
 =?utf-8?B?K09qWUo2Y291eVpDQ0dDUmF5TXFWN3hwamt1YS9xREhHdkxOcStISC9zMTRC?=
 =?utf-8?B?bG1Ha3BxUUVCYXVEcWVzQkgrQnd1NFlFYndOWEV0VUhiS29ZTXliaDVnbVJn?=
 =?utf-8?B?MU5jditWRnBRNXg2dFYyd3JRK2c0eHpWWnNSNFRvM0VHRnd1eXQ5RFQ1M29M?=
 =?utf-8?B?T3NPdGFLQUhZM2lpY0xGMmtUQStwS0xNRnhCNjNZSHR1Tk5JSlpYRzkxbW1m?=
 =?utf-8?B?bnhXcm1kRnpZQkhKQ2E2dmY4bTBZYjFwbWh3S2RiSnJHVVFGdFZ1cTJmbGdL?=
 =?utf-8?B?QUZ1eSt1aTkxWU9oZWlkcWROdlo3WFNsRTYxRFJBSlJkeGI0WStLTTFhMDlJ?=
 =?utf-8?B?TTZqSG9PZEN1YnlmcWlBQ2hqbFVlZDJVY1dmbDFxOStCdWNYR3JCQ3d1U2FK?=
 =?utf-8?B?dEU0dUhTM2NTVTBwTW4ycXBwbFRueTN4UFNUZjNBVGs0dm9PWVdlU0JFN0Mz?=
 =?utf-8?B?M2o3ajQ1MmZNckRPVDhnWW0reFh6OWxWOWhuajg4ZW94bmxEOC9jVDZvaWVR?=
 =?utf-8?B?bENGdkE5MEkzNWJ5NUZNSC8xRndtWmV3S0lZQVphWktremQyQ2N6bEEvWHdQ?=
 =?utf-8?B?ZXo1SGZ3LzhaR3VHTXNCQUZDU1Bsd0l6TFIwazBCcE0vdGpZMy9nWkkrMkYz?=
 =?utf-8?B?TkhvMldTbzlvbE9lQjc5V1JFRm9GUkU1QW1rRlYwdE0yQVBGblM0Y1MyUjFX?=
 =?utf-8?B?TDh0aVNkK09LZm9yMTJLR3JITXpsT21HN3MyNWtKSHVleGZMakVXZmpKWDI2?=
 =?utf-8?B?RTdVdHJZWXlCaWc3dkpGOVZNWGc4eTZQWmlGTzNXaUVJdEFwN2Z6N0F6empK?=
 =?utf-8?B?NndWQThWUDVtdFdsWTR5YkQrTzBCWi9FYktiOWxHWFBkeTcxb3ZaUnA5bjRD?=
 =?utf-8?B?a3k0RFZlemJtcWw4MUtHaTRCUVZkTnowekNnd1hzMmhBZ2JYMlpockRJT2pO?=
 =?utf-8?Q?s3I9wtla0Y6gLHWRTgkDgyM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4a3fda-8787-4a82-aeb8-08de1639e1a3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:51:38.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T0FKXyqHZeD1E80jVT0mlEfhqzXHCU5NdSHCecKS/u9sNFftxZ8oZuv7ZnceNKIPc8CywmHNGalAEbnLG3E2CwEzMnkylET9twf2JmP0uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10568

On 2025-10-27 04:45, Thomas Gleixner wrote:
> Completely separate the signal delivery path from the notify handler as
> they have different semantics versus the event handling.
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

