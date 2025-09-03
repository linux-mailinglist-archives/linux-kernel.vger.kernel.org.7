Return-Path: <linux-kernel+bounces-799485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D46B42C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3530D206CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EFE2EDD5B;
	Wed,  3 Sep 2025 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSKnF2gJ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691B2E62B3;
	Wed,  3 Sep 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936998; cv=fail; b=oDK8IvaK6ghhQuiSUBGn5jiszyR43u04i9I1ECMDDvrcT9iK8j+ie9W0i1t7WP88VpJkhrcnHKcJde6Llkobc3GWXCrFMMQy2pb1yi7UFu3h9+zOo7Y/sZvkMdk0yWwQs0ZWzAzHuP3XK0yYBigEVWb9B5GfgFt+rSuSE/jqugw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936998; c=relaxed/simple;
	bh=4F489xRr3F6C10Vkb21HKkMk/9MqQrCbkyRYm3SO4jk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4yGlrPSoQBSs84V021TPag66rUMRPdrBTxsOK4S7VL5pPx2a7p44iiRRMePsG+geD3qaEo1TccIDd76WqE00kFBYY+P6eOw5qpC6+OItKwJYKRwKN2ZHl32gv9X+oSNIdt+r5sjbB3xwU4vLeABFBPpyvW5njPCRe0fJoKrdGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSKnF2gJ; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8Cw0QP4nLXndvoIW5ZKc8mlFL/Fr+X1/yVkNeIaHrDhwYNLLJVoxWkDzhd3LfS8kLA5ncomLgsgBrZPjCVfqOC25pdQt+9Ti4T7USZaQRdJIQG/IuNuuQJhxFKEHar3lR4uNJN2QP8H2KbeyUpZyet0sVfLj6scFoq83AYofFDHkaTZGGTvNCRZSvzOxgYjUGC8iOAgw9xpLdQoq8H6CmV+dK0vO/D/x0gvfOD4r0HZc80PO1emy14IHNIK+I9d+/khbpUTqPrsjSe9kSnxPmTTAf/N/lXNcHQ15/uI09c+0DVU6jL6RRqmK2EZRheLcBL/P4xaYKZnMNacJaeqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8ix0ftXKSosGafnwgQ4Sz1HtccFmbGtQ6dAa0H/DBg=;
 b=xim+yqftPihA2xgcLU39ejommb1oQuYcQHIT4hdIZlsPhXfMS29NaD+OycsmGCFb5rPXqhJKUxufCvHq41nIiEy4ZpbEQWGEhOEJCChueUOptuOJZXoZJvXXvgm00LcRJXHKcfIaWJ0V8kivDnrWgjYkUawS7r4Y84K5PAbgQD1eKKPeXZ/CGiHT2qCRiYSk4kYOMMFFUHcqcP8uh5NPzFnc6Uua1TKXsKy6fT4qut7N36T18G5Ncp5F7NJE649jLjncYlzUfLXZErX+EJAVqJuZ9JjuB3XyGnU6KRnViJsvbdQP9LphCEshjKQc+wL6xFinzKuj2tPY/k5freve+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8ix0ftXKSosGafnwgQ4Sz1HtccFmbGtQ6dAa0H/DBg=;
 b=VSKnF2gJWK7+EwOd5gT8GuopYClRDZxBSyTe/eBeAQ3SssBDI1YyaaX7CUNv/xIULoUE6WzwYIxebghzosahEn5jCKljcgmKXPCtsOI+nBpOeraTRqIydO0vuE6cO46yw+w/xuCByOLoE5nNbXiRTOGQUhjb5910s7N+SVfMJi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CY8PR12MB7415.namprd12.prod.outlook.com
 (2603:10b6:930:5d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Wed, 3 Sep
 2025 22:03:11 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 22:03:10 +0000
Message-ID: <e2ce443e-f26c-498b-a539-4c907d12a905@amd.com>
Date: Wed, 3 Sep 2025 17:03:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 25/33] fs/resctrl: Provide interface to update the
 event configurations
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
 <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
 <dfc629d3-08d8-4443-9a8d-61e4612dfbd6@amd.com>
 <c6c1df22-e3df-4acd-a93a-f2972cac9793@intel.com>
 <ec5e1f6d-f662-4932-81a4-dc917c6afac9@amd.com>
 <8524e71b-2261-42e7-a4a7-648f9e7d7240@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8524e71b-2261-42e7-a4a7-648f9e7d7240@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:802:21::16) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da4242-f133-499c-ccb7-08ddeb35abb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGNwT1U3RDliMlhuK0RWellacFN0b1FhWWtzL3FhWk10WExncHZVbzkxeTRa?=
 =?utf-8?B?ekg1NmEvSjhyWkpzYW53OVlHaDR2K3RSaHJxenNoZm1UT3FHU24rak5pZzI5?=
 =?utf-8?B?ZkZRa1BKM1VtSE1WbXFtb1dqMHhVZnlDZnM4QW5BSE16S1NtbHg0OFAxek4v?=
 =?utf-8?B?bzl3OHRpdktSa3o0YXFOdFlVMUk1OE5pNmVpZWo5dmZMS2xiWVptZzdSbEZz?=
 =?utf-8?B?cHJ5OTJpcHZncHUyeUJzVXZSQ0pZY0ZDTzdudU1ONjh0Y1NHWjByODRNaTFS?=
 =?utf-8?B?MDNNSVFnRVVtazgvM1gvYmZrZWFrRnBoNWJlMFBDVEhqcnFQTnBJQ2cvUk4x?=
 =?utf-8?B?WU9xdXgrMk1aa2NpZnQyQ0U2dWRzYkZyTDhXWFhsdHlwa0NFMXVacWZSUjJy?=
 =?utf-8?B?WjJtTDhwcDg4R0lLaFZuczZoR3RCaHl2eEdxNUVlNHlWMVMzRTl0THNKSGRS?=
 =?utf-8?B?eXRueEk4T0N0NExUSTNBcjlxZXFkeXRiK3FrYjkvcHd4ZXJyUG5hdjh4WkRC?=
 =?utf-8?B?KzJMUlNmTmxJRlVCS1J5V3V6aUhPSm1zYkY2R1pjclFrajJlTm1XQU1ybFBO?=
 =?utf-8?B?YkFCNEV6V0tSb2g5ZTIrYjRHT2t1YXVTeUVzbVE3UUR1RENLREM4WUR3bDdr?=
 =?utf-8?B?SUs4T2FqNGgwNElESWVZZlFLbHM5ejlOOEEzRTVtbXhXdEo1eWhvRzJqVzd3?=
 =?utf-8?B?bmQrVEU2cGN2dTJjMlc2ak1LUjZsai8yamdtNnhmZERRdU1DS0o4azBlUjNX?=
 =?utf-8?B?cGRSVWhsQnU4Z1I2S0U5NUxsVnJCWmFsQVpjQ2lPaXpwTGo3TGYvazdmK2FN?=
 =?utf-8?B?TExtYVp3dU9Od3podEU3aFFtSzFaUk9Nemt0TythOGlocFRBcmZ1VCtWQU1D?=
 =?utf-8?B?WDQ0TjNGY0pCSW0veVI2S3pWRVh4TndkVTVtS0FYRVRoWVErVGZyR2VzUG1R?=
 =?utf-8?B?VmtvclBGVGFqRmRYKzROc3FBaHVFcWxnWkFibUdhemIvZ3hkOVN1TmtWOVlC?=
 =?utf-8?B?aWlkM3U1THVXb0Z4QzJRUUgzUEc3ZHJac3VIZlJNMXhHS251bU1LOEZxa0t6?=
 =?utf-8?B?aXoxQ2JOelR6VWs0bFhyRnNJeFdMZ3I3eXhrSnhRMW1ObXlHUmdPSmV6YzNo?=
 =?utf-8?B?Nksvb2taRjNGQk1SYVlwTmRFYUE3MVNzdVkzVi9iNU12SUFjY1VFU3FXZ1hh?=
 =?utf-8?B?WkVKdG02WmFRS0ZkMFgwSjA1bEExc1RiUlREalgxL1N2YmNqS0FseDRKT1Ur?=
 =?utf-8?B?ajFNRE9kc1lwZHN6bVN1N21aQ2FSaUp4VldYakJMTDRydjRwRDdmYWpCVWZt?=
 =?utf-8?B?NDBpRi9wZW5yZnVVYVBaQjZCbEpJWk1vUjF1aWduZWRmWjRBSFhlanZYZ0FR?=
 =?utf-8?B?VE95bjJNVXVNUWg5NFdZeE5qNnI1SmtSY0ZXVzFKMGNha1N4UDF4dTBFcytp?=
 =?utf-8?B?S0NtakU3QmtNY0x0V0krT0g1aWFXNzd1WFNNOWVKekFXU2VRZy9CNzUwc29U?=
 =?utf-8?B?MWpEYjFZRWlZaFFHTzNaai81eXk4T2JPejRQK1dPcVkvSUVabHN0TUEzc0cy?=
 =?utf-8?B?MkJZZ0N3SHluUWNPMUVSSm9qR0xhdEQrbnNJdkhXdHJUclZ5anZ4NHhMMDJh?=
 =?utf-8?B?NHREMlJkOUlpWkVhZXpFa1B6MjVtTW5lWDgrdlNBUFpvclBmRTV4dXF3aExp?=
 =?utf-8?B?NUtudnIyRG9lZUVpeFR4YXp0WFg1NEEzWmJLendhWTJOTXBuRnBWL29XTjJU?=
 =?utf-8?B?UkVTL0hhcWdrdU45SDN1YUErS05RTTl1RVU0T1NoSkFXOXQyK0JBSk9mMDho?=
 =?utf-8?B?VWNLRXRXK2RQVzFEYktQNzFPRVlMTkZXS05vcm5KdExRenZnTzFHczN5RTU1?=
 =?utf-8?B?UUpHUHV4cjdpdDRYb3h6MkF6OFRmdklIYTNTei9hRkYrSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVpOVS9SbzFEZjdaMkhyY1VGeEJ0eUNGVExsbWRvL1pxY3JJbzRrU2xSNmhN?=
 =?utf-8?B?eEFVY3MxS3NSQzc1QURyUEM1UkFQM1NGcDBNVmE0enBlbW1yTXAycUVIa21X?=
 =?utf-8?B?UGx4SXNMRmNtVDk0R3RwNHdUQkxsVmVlSTFNeklnOGd6eGtSdWNyU1BlWmt3?=
 =?utf-8?B?NnhtUFFTQUI5bmJ4WG55RWc3L3F4UkJ1ZXhaQndmZ2F1MisvYmpNNXd1a0xW?=
 =?utf-8?B?N05ZNUZOa0NWb2xJbURleUxTdW0wWTIzVFdEYXYzL09UejV4ZDJIbVI1MEFx?=
 =?utf-8?B?Q1VzeVo1Y2VyNWpXbXYyc0lhRTJjNmVLUFZ3MGR2a1V0YUUzaCt5ZWNablhm?=
 =?utf-8?B?K1FNQ2NSV0JjcFF3RXAxREltWjh6cktKNXRVQWUzZG1rVVdXRWJaSVpjQXlk?=
 =?utf-8?B?cTc2bVBHZEhQWmh2UjFzMHVuVWtsWmFiODJpZ0F1bXprN2syNUpDVStxVVpn?=
 =?utf-8?B?eWNRYUdzY2MrWkovV0dXNHVhL1RHak5BdnROWm8yeGxJbDAxTUw5T0NlT040?=
 =?utf-8?B?LzFzNGQ3RnJmTEtlUDFYdE45eXNSS2I1OThFWStybGhFSXQvczIyczRHNm01?=
 =?utf-8?B?bTZZbGtlT1hBcElrdG1zOE5HeXlLcnp1Q1owSzFWSnQ2cmFDWWoveUxPNXlq?=
 =?utf-8?B?aFZJNHhlQzJIYnduQzFGS1ROQjIvOFVpcXlZVnZBajBoQVRBbzdkdlhEakV0?=
 =?utf-8?B?TEgvY2s3NW5JSVVmZ1kzem54QnBON0E5NDRlbmFOQ3lTTlg5Z3Uyeld5M1ps?=
 =?utf-8?B?RVhPZ1ZCb1l3V1IyVE8rc01vaVcydTRyVEhlRnpLcENkdjYvWGxqUi82L0Ey?=
 =?utf-8?B?U2ZZSkFxUHVUbzFnbDkwZFBPWmFvdmNqYXZZQnBRNkFZeXREQUUrWm1ScGth?=
 =?utf-8?B?MnRqYzBQK2hTVUFSd2g4K1lLWUE5MUtrN2xwYlpVaGI2QXIwZWw1ZURrdHBm?=
 =?utf-8?B?Q2xxVTJTQVYrMm1sdHpTbk5ISlQxcVlLRDNLYmxwMnkwU3UwMU5zc0NBU3gx?=
 =?utf-8?B?M291TC8xamM3QklpYUNYdS9zYzNmNGFTejBZYVFnU3Q3NFJIZllGQVNKSVZU?=
 =?utf-8?B?Q3FnV2Y1VFJoaW9OTFdrWkxEd2tSMWxMNkhxNDh0VDVwbW1kcHBhUGxGa2J0?=
 =?utf-8?B?NlVJTXVINklPZ24xY25FcWpFUlpPbGIvMU9uNDNhZHY2b2N2b0NwR3BobjUz?=
 =?utf-8?B?K0ZQWHcwcldEY29nTEhMUnhKN05MVkMvbnJJcFBOV29ZUklWdE9CMmJqbUhF?=
 =?utf-8?B?eExCWXg0Y1ZWK0VNb2JGQjZnQmlKeFRmaVZ0S1hoTEpJa1BsamJCTVRPWS9i?=
 =?utf-8?B?Ym9kMjAxa1NqQzlYemtXU0RMWUpoU05hLysvTHd3b2hJMzlBRUt6cHFqa25C?=
 =?utf-8?B?N1JSblgwcVRFV3BDTlNaVSt4bHg2THVxWUpvZEpEWTF1NTMwVC95dVR4T25R?=
 =?utf-8?B?VFdyU3h2TVBWcXBjNVVaKzVCNG1hUG8zTmsxczl6aVg3MXFPZ2JIcTVQRmJC?=
 =?utf-8?B?WDcweU90K3Y5ZGdLWDc3VDVmNVFwUXBHT0VodlNKaUNwa003UThiL1BXazlD?=
 =?utf-8?B?ZEovZDFXNEh3c3k0YWxpR3hMczdwUG5Vbkh2VXNsRzYwZ0dSUGxEMHlaWDJx?=
 =?utf-8?B?TE1mSlRITXZjU2hBS09ITFR6MXpqNXp4d0hzQmZ6L010ODBGdWNoRmRialJ4?=
 =?utf-8?B?SmVocUIwNUdtajV3dU1vaEhGUy9pRm1RU0dJNjNhZ2lIR1NLdXUwbXZtWGln?=
 =?utf-8?B?N0RPWm1idDVFWGZsdlJDYmxCSlhQc0NwVzdlYXFEaXB2ZGR5aVNNaUJqNzBj?=
 =?utf-8?B?Sm5VbzNYR1NKV0x1YmFUSVlYeVZ3WFJPVDM2aGdPNDN4TnBWQVY1ODRYYTF5?=
 =?utf-8?B?VHdmRWtpbi9EV20vS2orRmFBVS8yVmVNS1cycFA3VVlFMXl3S2RrckdWQkJz?=
 =?utf-8?B?QnNqRW9IcitkY1g3blZFYVZSUmhOTkdYQytLbU5RQVp2YnVaclNXdHROeUo4?=
 =?utf-8?B?MEM0VFVjZ2JtcHcrYUZDdGNNNDYyWGN0d1dqVWxNdEcxaUdmRXdOcXlzOGZ2?=
 =?utf-8?B?QmpFRjMrcXFiSjJldHpqdVNmeDR4MmZOUWpWQk10dHZFL29BOHJvelZoOGta?=
 =?utf-8?Q?2Ekg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da4242-f133-499c-ccb7-08ddeb35abb4
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 22:03:10.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmHmZzfDz8gkCckwOyZtytulgcBEnMmVJU8vI0Srw49rXT02WxXxzLz+ETJD8xbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

Hi Reinette,

On 9/3/2025 3:52 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/3/25 11:32 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/3/25 12:55, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/3/25 10:38 AM, Moger, Babu wrote:
>>>> On 9/2/25 21:41, Reinette Chatre wrote:
>>>>> On 8/14/25 7:25 PM, Babu Moger wrote:
>>>>>> +
>>>>>> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>>>>>> +			   loff_t off)
>>>>>> +{
>>>>>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>>>> +	struct rdt_resource *r;
>>>>>> +	u32 evt_cfg = 0;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	/* Valid input requires a trailing newline */
>>>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	buf[nbytes - 1] = '\0';
>>>>>> +
>>>>>> +	cpus_read_lock();
>>>>>> +	mutex_lock(&rdtgroup_mutex);
>>>>>> +
>>>>>> +	rdt_last_cmd_clear();
>>>>>> +
>>>>>> +	r = resctrl_arch_get_resource(mevt->rid);
>>>>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>>>>> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
>>>>>> +		ret = -EINVAL;
>>>>>> +		goto out_unlock;
>>>>>> +	}
>>>>>> +
>>>>>> +	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
>>>>>> +	if (!ret && mevt->evt_cfg != evt_cfg) {
>>>>> ... is evt_cfg of 0 (a) a valid value (that will not cause hardware to fault) and
>>>>> (b) a reasonable value to allow?
>>>>>
>>>> The value evt_cfg = 0 is valid and permitted for both ABMC and BMEC. I
>>>> have confirmed here through verification and testing. In that case, the
>>>> event counter will not be monitoring anything.
>>> Thank you for checking.
>>>
>>> I do not know what a use case for this would be but I also do not see why kernel
>>> should prevent user space from doing this. Looks like event_filter_show() will then
>>> just print a '\n' that is expected. Are counters expected to always return 0 in this
>>> case or will they return an error? I am not clear on what qualifies as "invalid counter
>>> configuration" for ABMC that results in RMID_VAL_ERROR.
>> The event counters return 0 in this case. I would not think this as an
>> invalid event configuration.
>>
>> One option is to add a text in last_cmd_status from event_filter_show().
>>
>> rdt_last_cmd_printf("Event %s is not configured to monitor any memory
>> transactions\n", mevt->name);
>
> event_filter_show() does not return an error in this case so a user may not
> check last_cmd_status since the doc specifies that "If the command was successful,
> it will read as "ok"." Since the write() succeeded we should not fail the associated
> show() to prompt the user to check last_cmd_status though.
>
> Even so, an additional message does not seem necessary to me because as I understand
> event_filter_show() returns an empty (just a '\n') file that I think
> already reflects that no memory transactions are configured. It remains an awkward
> use case to me but from what you stated this is valid for the hardware, it is what the
> user requested, and the user can use interface to confirm the state. It does not seem
> like changes are needed for this scenario.

Sure.  Sounds good.

Thanks

Babu




