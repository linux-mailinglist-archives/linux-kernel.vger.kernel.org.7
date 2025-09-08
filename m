Return-Path: <linux-kernel+bounces-806119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27FB4921D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9106917B3B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE630ACF8;
	Mon,  8 Sep 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="arVWVPur"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B5F4F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343300; cv=fail; b=unzanIUtY5s6VIh0TswDFES5x/REnnMI0Y4S0fc/3VbAdVq2b17Mz3sNqLbwU+T7dxmxI7hM+A8UMYwoEnAxUPRXSR0Bd9eyeLWVKA5c8/80Lb+XC9iWf9IftEmeKeZsc9+e7+2ihyjljcSCGTFdpsqWzRqOuwV7YSwP09LfW+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343300; c=relaxed/simple;
	bh=WG0ZlG2qL0yqhyNW8K6ojF1tx4DSob+WacdTnkMehik=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=gdiW0YraF7oeM/0iNh7O6N+Ut+xwaBUxwre3QTynECkmbO9+1sy13MwY0HrFbi4cgTAq6VhyWPY9O4f6X/lUmYV+px32z8n+QZSm2BgBKLR7HPcbC3ZYRFsJKCZXtJsXc8oh9oU7qHi99HPkUi6sVVHWIEUQQxm7GvjdF8jnQGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=arVWVPur; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXn4ilNi8f3GT5WnfIK529mczL2YVbW2Y/ciuDo80V7qArfQr299Hj8U9fEihJRzy73lr3mychYLhU7LZcuVKWUB0/cA02PoxzkJlkasGsw1m6t5Z86Cf5S7mZZWmdZVpSkY+3ozegcrv+M/TJgoQaVXGxbqBXlKAhRMIlPRKFuTGEwd9+JnkLGyBiuw2EauU6ZnbopFGJ8VYO6yKAixzNoUZdqAFOwdc0KuF7o7f/Isf9yBl/Bq3OeELb58KCSN6Sswk8Zp1GUyLSpUUAMb8XIfI3bx9pB8gVchg5HL27euXsZXmWZQt+SqMKLiYWPW7FWRZEXjJSH9Ml5/LKAXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5cBq6oihgnCWr0Z0X718mqFBbGvCHFQ85soH1F4ESI=;
 b=d2qwPx4pglRNGTOf33YHY1iTYzGcXLB4bZ4QEk2Tccqu6kM+VkmmUUFyTdhIvzSOhz0E6v5ZI37cyv5sOIYxizyF9cDG/42pDDQi10xZwRtpj3vJ7QraMacXp+Rde60TpXgAoQpkelchRZ3E27WbiiheB00n4U1I7PKbLACGzFAalKbAc37DK3dy8pDc19MT5UEgGjn7+JorMGi7PVgvXAgZjofk9plm/lIHHO63UEFI4wJLJ0EDdlFBXaeK68VH1FUHUpbyol5Uvx39SEgZAB4MaIj+ztoH/ZZK0OxWZWg8JVhMUxamEWNA8Ja/gtf9Nn9NC4C/0zThoWkYV80U2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5cBq6oihgnCWr0Z0X718mqFBbGvCHFQ85soH1F4ESI=;
 b=arVWVPurJvDU4VBUpmA5PlgUbFsAxDOy1Spq8hOtrt4b+B2Bgtj8VbdqorBdEmmkFwIuiAw69wMXmde1aVd2wTGjw4m0Vke6YziB7ffUOSZxDy3kkexbV6J3Tt7CkzkHHwVMHmXv4lGlNGYArZvHwDOWxqCKj1WABnLAUpQ9hVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
Received: from AMBPR10MB9319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6af::10)
 by GV1PR10MB5988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 8 Sep
 2025 14:54:51 +0000
Received: from AMBPR10MB9319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e931:a4ae:91cc:ea1c]) by AMBPR10MB9319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e931:a4ae:91cc:ea1c%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:54:51 +0000
Subject: Re: user->nr_msgs going negative in ipmi_msghandler.c
To: corey@minyard.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
References: <5cc48305-d88d-ac15-ce0d-55306a60a0dd@kontron.com>
 <aLrPbzfho1d2kMsn@mail.minyard.net> <aLrRlQZdeToIgPBG@mail.minyard.net>
 <c3c0cba1-a45d-8619-06c0-64046d8ecd76@kontron.com>
 <f14bd1ca-c47a-13b3-fd5f-5f5ad0c89fad@kontron.com>
 <aLsw6G0GyqfpKs2S@mail.minyard.net>
From: Gilles BULOZ <gilles.buloz@kontron.com>
Organization: Kontron Modular Computers SA
Message-ID: <5c0d8998-6cb2-5ce5-e3a5-67237a51049f@kontron.com>
Date: Mon, 8 Sep 2025 16:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <aLsw6G0GyqfpKs2S@mail.minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PA7P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::20) To AMBPR10MB9319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6af::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR10MB9319:EE_|GV1PR10MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 945bd7e6-386b-461e-21be-08ddeee7aa03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVh1MmRUOXN6eEtsSDV2cS9PN3Vna011cWp4eWJDais5am43blUyd0ozTVJQ?=
 =?utf-8?B?b0ptWlZkalpheWg4MHNvbityMWJDYkZoaXRwR1k2djV6VUQ4dWZCWnlwMUdG?=
 =?utf-8?B?TC9TeU8xQVVOREZrcnVpbmNiTjA5SjZ5Y2ZWM2g3R0tXd3kxazI4bE14N0du?=
 =?utf-8?B?WHFVc3htdEZGM2FwcGgzenEyZ1RMTDFGTUc1a3FCenRDdSt0ODQyNWUvODBm?=
 =?utf-8?B?T1NlU1NSQWgrL0RwY3Z2OGdnZ3lYVWxFMWxLSUJ2MkhpbUlSVFIyS3FjSk5Y?=
 =?utf-8?B?UlVRS05qWkluUXlkNTJIY2Q2RzNoL2ZxUC80UURkc3lnZTNaTnNVZTNCYXVj?=
 =?utf-8?B?dU0vZWpnSEp1VzFyTng2Mkt6UXBTSWU5dEtvcjJCcXNZa20zQ3RuSFZqRUVo?=
 =?utf-8?B?SGdhaUNGY0ljUHZrNlZKR04xODFEZy9XenlMb0JBNnJsazlaNzZNamV1THAx?=
 =?utf-8?B?eVJUR1p1d0txT3d4ZXhudWQxTi9HN1NraEVTSEMwQjBiTXBDU1lmellGbE9k?=
 =?utf-8?B?MzRVbmhRM2I2N01OOS9lb1h0SVVWRjZjbGZzbzJ3cWhKQSt6SUcxOHVqQ3J4?=
 =?utf-8?B?YUJpQ2pLc1BadHIwWEgwOTRRaElCRUQ0bzNwekpRQlBWM0JrWTAzN3ZYbFNI?=
 =?utf-8?B?UlFJL203RjFLWDMwSCtIWVh3a2p6UThJVFFLTDVwRnhqK0kweGRXZjgvbzVR?=
 =?utf-8?B?SnRWL1k2dTF3UlA0ZGhud2tnMXhLZDFFQ09LMklpY0RoelBiei9GbW9BWmJ0?=
 =?utf-8?B?NVhER041OGhtTEJWMW5vbXFXSEIzL2Q2Q09PMG84cFI2czcyQnYwZ3M5eWNw?=
 =?utf-8?B?NHRKWjE0bjMrbk51WkhVTEdVWVpKOUlKK0RsVXdUaVVwankyT2VtV1ZIcVNp?=
 =?utf-8?B?RW14d2Z3akZrWFBCN2VXMGUxOXlPRlVreEgvL0pXcks3UTQvNlo3ckdpZFBG?=
 =?utf-8?B?cVpRUDlaTDRYenlPTW5WTTRONGZQcHBtcDdWdGh5TC9Fa2dYcGwwbXozeDF1?=
 =?utf-8?B?L2V4NFN3NmthdlVBdlJ2V2grTUJOK2VjMExHZCtYWFZnRWp5d1hpbm5pSXkx?=
 =?utf-8?B?WVI1d0Zsc0lMaHo4YmZZOFNpSUc5VG12YThoRWZHT1ZOL0Zod2RUakxuOFpE?=
 =?utf-8?B?WC82Y2toRlFYVHB2TW1SaWxsTUdvelduQmRWZ0ZTTEZ4R1ZqUVcyY25BckxM?=
 =?utf-8?B?aEpQTldlOEpWejRZeFZCZHRCbGF0TnhZcFdkKzVqQTNnYlNlY0o0WVB0dzFs?=
 =?utf-8?B?TyttVE90ZVVlWng4OGNoaytETGFwbFQvWnVnTFovM3oxYU1mdkxWV3pkbjdx?=
 =?utf-8?B?UStEMktxSlJxVUxwT1dHTUNsSi9DYVRwcCtaQzAzTlFkeXhkU3cxY3grb1c1?=
 =?utf-8?B?aWdjbHo5bFVEby9JY3VFSmdSOWhBTGF5S1FsdGgyNTRHWUZsUFIwUndna1Rk?=
 =?utf-8?B?UEVDUUdGOThnTVgvd0xySzFlM0QyVWdoNmhJTGdJNWlyN2lWQ2FuTnZTV0FM?=
 =?utf-8?B?NG9SZmlmaGVXVVhFa0JuUFd4U1drWk5xVXVhMjZWd0VWeUZxcU12SDFCYW1Q?=
 =?utf-8?B?aklkaE1Sc3dQY1FOaEF4RzE0MWo2Lzk5elhIOG1zRjdXTVVMQkV1Mm16SVpK?=
 =?utf-8?B?eENobjdod1J1c0ZHVG8yUmZZcmNnNW5BRld0L0dZeGtmeEwxaTdrY1dERFNr?=
 =?utf-8?B?L0drNGw5bXg2TXZqU2N3SmM0M3V5Nk5LaDJhTGFOcExGdkE5alJ6ZDNHWERQ?=
 =?utf-8?B?akhXcHQ4d0hLY0JZdmg2NUpTMFg5SGcwWjl2bXZHZXA0TUZ1azdvek8vUkNm?=
 =?utf-8?B?b0VqdTZSdG5uTkNjbHBmQXlnQ0ZPazMvRDRnZjNxTUVYZlJNdlFNWm93eEJR?=
 =?utf-8?B?ZVdCakJVYnhuS3RKZUlta0cxUVFDNUlYbTZLZldhVnkzd2dMRG1NdjdGdDRL?=
 =?utf-8?Q?RXnKI0uAfRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR10MB9319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3pqL0lHOHNOQjFSVFlvNEczWGwwalVId3ZreU9Sd0JpM3Nnb0t3RSsvZXRs?=
 =?utf-8?B?WUVBalorRnhIb3RsN0dHeWJOV0p5dkI2b0RPTW00cGx2MU9WVFk2N1VJL2I5?=
 =?utf-8?B?S0ZqdEU4Rjh5WkhOTHQvM0RUZ3g1WnN1bmhPMWdraW04Z25wUDJ5QnhFV050?=
 =?utf-8?B?d1hQcWdESXZUK3VIVDRRaGltNjVKcGRaaVJ2VE5rSGVFQmpGcDlkQlN3d1pU?=
 =?utf-8?B?bHQ5SnVJREhNM1FMRjRGUXZibW1OdGtZZWUxdUFhTHY1cHAwdHFON0VDbi9u?=
 =?utf-8?B?b1lRaCtyQTJjK1puQlNCMlBpQ20zdFplNEswa2NvWlQ4elRTU3pxS2pVbldL?=
 =?utf-8?B?N3V5MHExKzFHU3E5d1FRdkNDVFFhUG9QWml3WndWYzI0THc2MlNKQ2lHU0Iy?=
 =?utf-8?B?aU5QenMvWnFNU09TSURuTG8yR0ZGSVVCclBwWGs3UXE0YXh4dnRhWVdiakRk?=
 =?utf-8?B?V0ZHT2ttZWZ3M095VnhZWjlGblJjQVUvNnp0U3IzMHNjLzhwOFJJc1Q3OXZ1?=
 =?utf-8?B?a2o0YllueTRCNmFoUS9Oc2FoMDlNL2JITmt3b3dLV2k4L0RHd3JaUVhNNU9D?=
 =?utf-8?B?U0Z5aHEzYmVkeldjWlBLMXAvZUhUd2duUUxBNWJDRXMxQzVtTTI5anp6cERq?=
 =?utf-8?B?RTZtNjdod0RiUzVGOW9KZVlvVVR4cWVPb3Y2Y2FZVENGbHd5aTd2eityY0o4?=
 =?utf-8?B?SkZwTzBRQ2lTYXlJNmE3OXBxUS9vUmJ1MlAybE9qQ0ErOTkzbVlpSVh6OTA5?=
 =?utf-8?B?SDlycWwyNzFES05ibXV4b0FDZlBLdmR3VjE3ZGd3eXZLdEJlbHljaG44Z1lx?=
 =?utf-8?B?RE9JUEY5dkFMZU1SeEJ1LzZoTks1TE5xNVRGUjVwRUF4TlhRd1l6bXhCWTBu?=
 =?utf-8?B?bXIzSml2M3BLakpOOWZDVm81Z01Ua0dyaHU2dkJRbmZqZFRYaWhtZVpQNWgr?=
 =?utf-8?B?dDMyUEhOa2lwZFY1d1NLTFByRndhbXhjNGZJOTFSRmV0UHY0QjZJbHFWT21p?=
 =?utf-8?B?WjFpaVZrV2FsUHd1ME1HeWtHVmp5amtWbDNQeTlCOW1zdnhRMVpSTkpWU1FM?=
 =?utf-8?B?UFhQcGkwcEEvb0JsL1FrRENsdTBjMGM3V1hROVpHd0FqMGhQV2JESzJoUkdj?=
 =?utf-8?B?akczOEVTZHU5MlFkaks4cTJKUHZTY2xSTWNKZTJUekV0QUY3M1ZLbVNBWjda?=
 =?utf-8?B?T200M2hVWDBYVm5YSkkyU2tMbVA1aE9XL2YycEdRTCtVMVAyZUVTK0FzRFE4?=
 =?utf-8?B?dWJHZklJMWdHS1lpZDhCank3NWQ0NklLM0czN2pTVzFqWlBKOEhnYk1aVmdF?=
 =?utf-8?B?anNFcWZ2Z1FvWkxiYnEvSkJFalJZZ1dSY0JDR1J6VEN5djQvVXZhOFRWMEU4?=
 =?utf-8?B?WUhrY3N4T0ZSN0dhZW5nMW04aDZmekNsNGVhZExqYjR6Z2RhclpvaFFwc3ZM?=
 =?utf-8?B?QUdVdXQrRER1czBoYnpJeU5kZWc4U2pBalA5OXBhWXBXK1dQcHN4V1RIdjBR?=
 =?utf-8?B?VVNEdmdIUUQvUlZlNFhHcTk1UFJmeE53ZGFzR013ZnRucVllTnVKaWNYbWtH?=
 =?utf-8?B?ZnBqaTN4WWd0ZS9mb3dqdGpNWURUcDA5RmdEY3l6dkxyNnhuQ2NLUUpJK2Uz?=
 =?utf-8?B?ZzFiTi8ybmpMYU5BbDJDSWNYNmxkemZtSEptMUxPd3Fqam5yMEtVZ0tKV3BZ?=
 =?utf-8?B?eFUxcDk1bTdCRk51bUR4ZEtOMHRBQ0k5RlFDUkRON0lUZTV6Y2ovbkJXQkhY?=
 =?utf-8?B?K21vNFV3WVY1bzhWdjBkOGt5QkZLSW9CU0dFZG1HVkZQaHgwWnIxRi9SRlAr?=
 =?utf-8?B?Qnd2TmxnekVhTGFzWStWMjZ5N05HNVpnQnhBRGp5Q21aTFZqKyt4TlNhSzBO?=
 =?utf-8?B?YzRsbFJ6R003TGhobmUwVG9kWTUyalc3QnF6VGFZVkNJUC8wRStrUUlwUnAv?=
 =?utf-8?B?KzRYd21MK1haSUgzeFN1OG1CMzBYVWduY2dXclYvR1ZWbWhubHNNcWc0YWd2?=
 =?utf-8?B?cm9meDA0THFlZDNMZU5YNTNLMTRhYmVUcVdzbkIycDh6RGtmTkRlN2I4Q0lH?=
 =?utf-8?B?V2lRdEtsdi9FZEIrSEowRWRLd0txdGdJQTdTWEQwbDdHY3IrNlRLRTZlTW81?=
 =?utf-8?B?aG0rb3d6Rmo1YXI0S3ZhL09uQU1LSEJyY1lhMGVsaTF1ZUNyMVpzVGcrbkc4?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945bd7e6-386b-461e-21be-08ddeee7aa03
X-MS-Exchange-CrossTenant-AuthSource: AMBPR10MB9319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:54:51.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hf1PRt3AjPBrRDMvFinUjYSKzs6yaSCMJ6DWFhIsm28aLDISjol9dTfFBIiOUUy25z1U2LLQoxhKeX7DDQvIZEp7XnjEHxej66LhFBdvvAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5988

Le 05/09/2025 à 20:50, Corey Minyard a écrit :
> I'm adding the OpenIPMI mailing list and the LKML.
>
> On Fri, Sep 05, 2025 at 05:04:28PM +0200, Gilles BULOZ wrote:
>> Le 05/09/2025 à 15:15, Gilles BULOZ a écrit :
>>> Le 05/09/2025 à 14:03, Corey Minyard a écrit :
>>>> On Fri, Sep 05, 2025 at 06:54:23AM -0500, Corey Minyard wrote:
>>>>> On Fri, Sep 05, 2025 at 10:16:19AM +0200, Gilles BULOZ wrote:
>>>>>> Hi Corey,
>>>>>>
>>>>>> I'm HW/SW developer at Kontron (computer manufacturer) and don't know what to
>>>>>> think about an issue with user->nr_msgs going negative in ipmi_msghandler.c.
>>>>>> Not sure if it's a weakness in ipmi_msghandler.c or a bug in the IPMC software
>>>>>> of our computer board (satellite) with event messages.
>>>>> I worked with people from Kontron a long time ago.  Those were good
>>>>> times :).
>>>>>
>>>>>> I see this when I run ipmitool on this board while some event messages already
>>>>>> available. In this case deliver_response() is processing the messages and is
>>>>>> decreasing user->nr_msgs below 0. Then when ipmitool calls
>>>>>> ioctl(IPMICTL_SEND_COMMAND) it gets an error with errno=EBUSY because in
>>>>>> i_ipmi_request() user->nr_msgs is incremented but still negative, casted to
>>>>>> unsigned int so becomes huge, and found greater than max_msgs_per_user (100).
>>>>> Thanks for the detailed description.  The fix for the bug is:
>>>>>
>>>>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
>>>>> index e12b531f5c2f..ba33070622b1 100644
>>>>> --- a/drivers/char/ipmi/ipmi_msghandler.c
>>>>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
>>>>> @@ -1634,6 +1634,7 @@ int ipmi_set_gets_events(struct ipmi_user *user, bool val)
>>>>>
>>>>>                 list_for_each_entry_safe(msg, msg2, &msgs, link) {
>>>>>                         msg->user = user;
>>>>> +                       atomic_add(1, &usr->nr_msgs);
>>>> Sorry, that should obviously be user->nr_msgs
>>> Thanks very much !
>>> I've tried it with kernel 6.11.8 and it's better but still not enough.
>>> Running "ipmitool sensor" with some debug in ipmi_msghandler.c shows that I always have nr_msgs=1 right after the atomic_add (called
>>> 9 times), then when in i_ipmi_request() I reach line "rv = -EBUSY;" with nr_msgs=-2 (twice).
>> My understanding is that ipmitool calls ioctl(IPMICTL_SET_GETS_EVENTS_CMD) calling ipmi_set_gets_events() and thanks to your patch
>> for each event available the nr_msgs is incremented here and decremented in deliver_response(). So your patch is OK for that.
>> But after that if other events are coming, deliver_response() is called and nr_msgs gets decremented. So when ipmitool calls
>> ioctl(IPMICTL_SEND_COMMAND), this calls i_ipmi_request() with nr_msgs < 0 and that returns -EBUSY
>
> Yeah, after I sent my email I started looking through the driver for
> other issues around this, and there were several.  That change wasn't
> well thought through.
>
> So, I've added some tests around this in my test suite, and I've
> reworked this to be a much better implementation that's harder to get
> wrong.
>
> I'm going to send the fix in a separate email.
>
> Thanks,
>
> -corey
>
Thanks Corey
I confirm your fix (separate email) is working for me. Applied on kernel 6.17-rc5 sources, with few changes under drivers/char/ipmi/
to build the kernel modules there for kernel 6.11.8, and then using these modules.
Another simple fix that worked for me on 6.11.8 was to replace atomic_dec() with atomic_dec_if_positive() in deliver_response), in
addition to your suggested change to add an atomic_add() to ipmi_set_gets_events().
>>>>>                         kref_get(&user->refcount);
>>>>>                         deliver_local_response(intf, msg);
>>>>>                 }
>>>>>
>>>>>
>>>>> Can you try that out?
>>>>>
>>>>> I'll forward port this to current kernel (if appropriate, this has all
>>>>> been rewritten) and required a backport.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> -corey
>>>>>
>>>>>> As workaround I set module parameter max_msgs_per_user to 0xffffffff so that
>>>>>> user->nr_msgs is never greater than this value.
>>>>>> I was using kernel 6.11.8 but updated to 6.16.3 and get the same issue.
>>>>>> I'm also not sure if our board is supposed to receive such event messages as
>>>>>> it is not Shelf Manager, even if these events come from the local sensors of
>>>>>> the board.
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> Gilles Buloz
>>>>>> Kontron Modular Computers France
>>>>>> R&D SW/HW senior developer
>>>>>>
>>>> .
> .


