Return-Path: <linux-kernel+bounces-744098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33769B107FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253E47A87B2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E3C26A091;
	Thu, 24 Jul 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uX/IWNrb"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97E26981C;
	Thu, 24 Jul 2025 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353726; cv=fail; b=geKc4EEOc4cZRGLOGnE6wQyTC62i62nvzEA3LClDwBzPSU/nGDBfJ63s8ri8Xx0bY4XwPtaKwH+86OZ9j0W4lwQMH3kvqWPgxCp3x8paHdNjmB1nICuEoFfb7aTCiJt778BnIe2hGDJ5HrFBT1W+iS/dLXRO9oBaRaiHO0iwBXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353726; c=relaxed/simple;
	bh=MdYcJbOV9e2idYGCYs4nNzOrp02NQfVs2OfhuOrCshM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMDi7jvSr8tJiWlni9INxPkUALvR1+SVIUvtSuRAcToIBBXS1OEo4G9m8FJNH+/2UxcqrrKluDUveYe1Qjco3ELdtAzFNRia6Gmid6Qj9NKBsaW0VQZ76zVYa9mA5kR8JppVF/qxH9bWSGiT/011z2K+gDe4+MDgriwA7mxZJw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uX/IWNrb; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPp1rDdgWgSDW+8p7YxgjaoiWPbmvnBieVDuMGmSfLjHFqe86e3Gxr33Yg1ZNLfkZ5DF1gYbG9qrSDRMvLdSamSJEQZQJGk8f+GI0y/rKvWxqBSruLc1SxrC81yPMPR/bOukOwmzfftnvpN89Sek/2dJmMOkG/HL44CCTPzTRVNlASJFCxDJ+e3pqido27/ZMp+/u/Iz2lTOtYVrWZFw7AQ7kQol7OLlRK1BF7RH+eqFhPTiNZGVDg+1L4+9t6DIjx+Smrq8996+yokDd8ljLmV98tb7DtqMRzLZCa4GhTA4d7f4vMuAUPQp+BINXGvIUmffS5BBtXWDD5beD8qooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWFHGfTVIReQhrsA+7zoWDbwMC/rVLU2MQ6NT3LOg2g=;
 b=dWUk2cuoztLMbdWNu0Q+z0Ja22ZA3ljnQTBFRjB34kLCU0d7U4gv5Vf8oWHB7tRDQM2zSvuiK6AbeU8zfhYYOeqMAS8sOkdwyMgbRtP2KIVA970RA57CDgviDFcffYGs7A4/gtvRgu+18tAGmkX1E0LJNTCA5yVNt9NYkxK+n57yDJc1jLSdpfHUG1WYoPtr0BS3wcV8/j3bQLuSDwDTHSM9uxPVfs7iQwTOmlKpkWHSeZg8CVKNRZIeh9Tv+7HnVRkBQA+Qk/nC+mJN0HEaqUxw4BisUZIB0BoA622oBd12MfcoCivLlgtCKOGEffRuEZVTaI41Q9lt7e42w56SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWFHGfTVIReQhrsA+7zoWDbwMC/rVLU2MQ6NT3LOg2g=;
 b=uX/IWNrbT8JL8PEYfhX8mvc3j9DRMLfCsVwpSsuhx304qkH8PEtNFFjjHfKxZgCs3URzvIMF5m1/lYFj5BfLqZOo7VXKm3Z93px6/CQHQ/bIlN0b6bb0zkobnangxhR+nCsY/RxfRa6vA/Kv/CcgmMx4pKCNuLNUtUzvCye4gPfr1f47aPe8M/3WJS8MW9OsucnqWa83t2juJNFsd5yt+p8JE1cnPE+6L3ghFkJwpfHFaRjMPsD5Xo8VsVNUllnKp17v9O1YGklKXwvGCjALytukN0aMvhtfGMQa0WbjgL0ZbVd0hqWQ8rv+v+7payYdGPUwybMhv7iMQ8CAMzI8mQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB7607.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 10:42:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 10:42:00 +0000
Message-ID:
 <PN3PR01MB95978770C2DC8D5CDB28426FB85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Jul 2025 16:11:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: mention MIT license as a compatible license with
 GPLv2
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <PN3PR01MB95977C87764A556FFD49FB72B85EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025072459-tweezers-dingbat-b748@gregkh>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <2025072459-tweezers-dingbat-b748@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <6af1eb1e-8b9d-4402-a67d-0fd5a2834664@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a04172-dede-4adb-00b8-08ddca9eb876
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799012|15080799012|8060799015|461199028|5072599009|440099028|51005399003|40105399003|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3hNemxWT0RtZFRESGlncktQQ3B2YU9GNzVMcXJDeFphTnU0ZkZkN09QQ1RI?=
 =?utf-8?B?WjlRU2NlMnJ5ZGNEZDREZFB5SDdsTzRIajFxWExpZnFjeVRLZVkyR1FYeFFu?=
 =?utf-8?B?R2lzUklOd3c5ZUZ5cXhUNGk3eVhlRFNBMXdRcUJWQnV0cHJRWW5tNzJGSStZ?=
 =?utf-8?B?Y1FuK3FSVjdPZmg1UTUxRk5SeVpDUXNlcThQUmlRU1hTWUhkaFlRQWp2Q1po?=
 =?utf-8?B?MUhBUTd5dnRIMW0rRHcxV0ZFSWRyYVBOM0hiK2FEUzZpOXNGVUxBV2NEY3Bm?=
 =?utf-8?B?TVlncDk3VHlIamR1QS9TMFpqd2E3V3RmUC8zTkNuZ1RsMGpaN1c1bDAyRyty?=
 =?utf-8?B?RTVZd29GK0ZuWmdPb0g4ZUMxSEp4RXBSSzBOWmVJKzFyRFI0N1R2SlVlODVI?=
 =?utf-8?B?ZENOd2dlbXFZbzErMURWMFczWm9QejBKUG5QajVtSjlmTWtERGJnelRQenFp?=
 =?utf-8?B?QjIza3VxS3NyUG5ocTIwL0g4NHR3UWdpdUNPMllSOFpkR29RZ0I2OFRBV0tS?=
 =?utf-8?B?cERKN3ZtbEE0YkdPYzN3MmxJUSs4QTk4WFE4RU8yVGsrMU8wWTlydmRML1Vr?=
 =?utf-8?B?dmE5TmlBS2JWR29kVnRIOU5PVGtYZ2h0ZEpOdnp0bEhWOXVNUmRMb2cyMGJk?=
 =?utf-8?B?MThvWnhCUlE0cUZEZkZXYVRBTVJOTDVmT0ZLRExzaFIyOHZQWnNvK0N4M1JE?=
 =?utf-8?B?UUR6Y20rdlY4YVEvTmpBckdDL2JsYnd6QWRUSGhpRXF1V0N3a2dMWXNTc1Rm?=
 =?utf-8?B?TDBKREViZVE1UG1nRExjZko5MXdLTGYrdWllRytJaEVQNXEvS2pjd3g1cmR5?=
 =?utf-8?B?QVVVdXM2TWJLMGVQRkpmT05ubkRITUR1dVV4N0pNY0ppcG9US0VYRTZYb2Ix?=
 =?utf-8?B?dVpwYmdpUiszQUNCOHBRamV4ZFpabnhHNlk2U3U1RSsrei8wSG45K201RVor?=
 =?utf-8?B?T2hReGMzcktxcGhseEpXdnQxclZsNHRGdzBUOWd5SFZxOFkyZC84UW85M3pE?=
 =?utf-8?B?V1FYb3BLVUVLaER6eEpYa0k4VVQxbERxQVlDM0pHdjNONG9QVjBES3I1OXVx?=
 =?utf-8?B?Uk9GeFg2aTc1VnlwTS9sQkhyVmcyQnpsMUNKYVRaNElaUEIyRkpDdGtzT3Mz?=
 =?utf-8?B?TzdNcVF5U0tock02VDdjdWRjY1FFZ2J5Z2N5TGQyUlFERnBPUjhFUnFIRzJt?=
 =?utf-8?B?M2I3YUlnblRLbDVCaWxaYmI5NHV2YjgyZ1NEcjY1QzJGSTlYUWJhbTF1TXZH?=
 =?utf-8?B?WkJlbUZkSlp4SXEwNzYrZ1BpMVpzbU5qa0NmV0JTNUtrWUVHcTlleEt4WXk5?=
 =?utf-8?B?WjlMcm5RVmtOa2NIa1Nma3VXNFdkcnlYYXpkQ1Bia2p2alNyUW9XTHBNdVBI?=
 =?utf-8?B?WFRBWjVZUisvM0s2L3Nmazdmc1cydmZtSnRtcGJHVVBZUms3dGtzVElvaFN4?=
 =?utf-8?B?bSs3bG1TTWU5Q0dQVVQvMHNuNTk0NGlrVzJ6Q1Q1YysrbVZpTDFHNnZFMU5W?=
 =?utf-8?B?aXVycHpZNzBHbHptd2x4Rzl0YUpDeFZJRnBCY0RMVUxEZ0RFeHQxODhXQ1lv?=
 =?utf-8?B?VmFLM3U5VVVwdVNGSVA2bVIrTjM5aDFhWkRBcHBXOUd0REY1VFIvS2NpQkNT?=
 =?utf-8?B?ZE5BbXpOQ3Z3YzhTM3ZXM1dLYXNXMFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDVlN3FWYU1xSUNiWlU1Uk1lbUFFalNHOTlkRnIreE9mWGpqclJJVkpCTFVY?=
 =?utf-8?B?b05HSUFYT1NxWWkxVWxZL2x6VisyZjBwS3hxbStPME5SVm5ydUQxL3M4K2Qv?=
 =?utf-8?B?VFlCeTF5MEt0MURHa1pJbVBERHMrNit6YnB0YU1aYThDUW9BbGVtY3RDM3Nv?=
 =?utf-8?B?cmVHRUJ1K3NHVFZYcmZMY2tYRVBLZWdRZGxUU2JzL0s3WGZ6ak5JaGNGYm8v?=
 =?utf-8?B?VXpKa0hoSUVySVFiVTdQUFZhUWNXMmd5UUxVRGVKWnRCTG5ZMndyZnM4NWkz?=
 =?utf-8?B?cS8xYXlXR3hvM1pVQm04cHd4MjY4dDJ4OWQyQ01pN2NodHhiTDdSR1cxTlFI?=
 =?utf-8?B?UDVKZTNrY1ByaWNDL3BQY2hXVHlMR25ERHpOMmlGL1pyb1VhS2thb2paOVEr?=
 =?utf-8?B?cVNjeE5NY25WcDhSZ0VwS3RsL2d6RmZNVklxTXFIREQ5QW5MbVVIOG5RVFVi?=
 =?utf-8?B?RjgzSTZwbkFsd2NIbHoxckRraUtxWFhXd0RZOSthWC8yQ20vb0ZUQXpvbTZR?=
 =?utf-8?B?RnRZbk5hMVUxZkhoclI4UWpWbnE3VUtISEVEL3BxUTN5QnBZRm5TVGEzRlVK?=
 =?utf-8?B?TFV0d2ZVanFGR3Q1Rm5oWHZlc09zcm1TbGwySHYyVllZREU2UW0rMTNPY1VJ?=
 =?utf-8?B?R1ZpNmswdXF2VGVicENnNkFjelFnZHlMSlU3RXhqZlRkNkt0S0h3ZkM5dUE5?=
 =?utf-8?B?aWFGODJscHRIdGpXc29TSUIvOXh4L0paU01qUThHSCt2TlNlQ29DZTA5d040?=
 =?utf-8?B?SjdtbitFVVZ1bzVLMTl3U3BPeVRqYVpweVBnQWUrWDUwdktVVWNiZ0RXVHBY?=
 =?utf-8?B?aDRPTDA3a2lTdkkybHZVbEczQ2N0QytYaklEYWRBOFUvdG5aRmVyTkJUUTFF?=
 =?utf-8?B?SmFjZUx3VGx3WElPQmxBSkwyZXhNMHJoNGFVcjdTN0NPTHk5MjU0SWhjRzJo?=
 =?utf-8?B?UU1iWGpIYVIxbjFzTDc0OEJ4QkcxWlNBN0hPaHhPQXV4R1FDU3U1WjNWSm5Z?=
 =?utf-8?B?bnRWN2FYUTM0VjhPUy9QNFRQUmVsM09lRDlZSnF1SFJuRGM3STRSVFRVVU5n?=
 =?utf-8?B?Y3VwVVFxVHE1NkpLQzBndnJhVDVVNjhyY2g2c0VxR1h3WmNLa09OZFR3QUE2?=
 =?utf-8?B?UE9wRTlnb3F3emhQUVRMZlQweFlWMnNzdnVkdVhvVGViOGVEaE4vQmxmL3Vy?=
 =?utf-8?B?c2lKWXNtazU5OFJLdll0Ym93Mk9DRFdBS0lmT2hHZDFacVZyeDRub2xvVXVO?=
 =?utf-8?B?Sm1Jdk1RM2swZ0dsZkowSURJcHkzU2ZlQ3VMOXFzREF2Q1FlOGhVTDZaeXdn?=
 =?utf-8?B?Y1VZUXloY2Vjdkk5TnNCdzZKUDkzRWFtaXViTVpmdGppYmt3Q1ZmdjVJVnlu?=
 =?utf-8?B?QXdRRmlTRGtOcGlpMDJlbjNoV3pYa1BTWFNnSTVQSTNLelIzMmtZcWY4Y0Rt?=
 =?utf-8?B?Rk1zeTU1VHhFVmNXekc2UEFWczZqZ0xEMkdqS2R4NmxmM0NoeHY4Z3pHZDNH?=
 =?utf-8?B?aERHeC9pelhjcHlTTXlnK3IrSWZuUEhCM29XMDllbjRmWlhrek5aYXJCTnNx?=
 =?utf-8?B?amhCM3NMNFNQZUFWcnJIQUJoOVpqbGY4NHFjTkRyWURLRUtPQnJNUGlidnlx?=
 =?utf-8?B?RGpjYU5kSjZOUWFDWXVBbVNpZVRMdkRnaGJNZFA1elRGZHFwMkp2RmRKdFU2?=
 =?utf-8?B?TjRHd25WNHk3eHZsOU5KUUV3eEt3U3JlVllJTFhDUXJnY2gycDdPRXZpdTNp?=
 =?utf-8?Q?O2iPpdiFzDqbZH/57Lpeerr85jQQPbwHkfQtj/u?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a04172-dede-4adb-00b8-08ddca9eb876
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:42:00.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7607



On 24/07/25 4:08 pm, Greg KH wrote:
> On Thu, Jul 24, 2025 at 10:03:41AM +0000, Aditya Garg wrote:
>> MIT is a widely used permissive free software license that is compatible
>> with the GPLv2 license. This change adds it to the list of compatible
>> licenses with GPLv2 in the kernel documentation.
> 
> No, please don't.  This isn't a proper place for talking about the
> different license interactions.

Ohk

> 
>>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>>  Documentation/process/1.Intro.rst | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/process/1.Intro.rst b/Documentation/process/1.Intro.rst
>> index 25ca49f7a..c3465e3aa 100644
>> --- a/Documentation/process/1.Intro.rst
>> +++ b/Documentation/process/1.Intro.rst
>> @@ -235,9 +235,9 @@ code must be compatible with version 2 of the GNU General Public License
>>  (GPLv2), which is the license covering the kernel distribution as a whole.
>>  In practice, that means that all code contributions are covered either by
>>  GPLv2 (with, optionally, language allowing distribution under later
>> -versions of the GPL) or the three-clause BSD license.  Any contributions
>> -which are not covered by a compatible license will not be accepted into the
>> -kernel.
>> +versions of the GPL), the three-clause BSD license or the MIT license.
> 
> You forgot a ',' anyway :(

While it is no longer relevant, I wonder where you wanted the comma. Maybe you meant "the three-clause BSD license, or the MIT license"?

