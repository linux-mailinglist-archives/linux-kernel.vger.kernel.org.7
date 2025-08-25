Return-Path: <linux-kernel+bounces-785404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBAB34A21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DE817C3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37BF31280B;
	Mon, 25 Aug 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SVgS4jiO"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2092.outbound.protection.outlook.com [40.107.115.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AE3126CC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145981; cv=fail; b=iD7Rnrir7dVBRrwmgUGvszirVLe+67eWXN4M+PwjA0jn1spzyBPfFeqiRhtqk7bncYF8tVFK1b6WQ0zs54z3Mc3xhFZdr7e6N0M/xANF7COFdJLI6M2LKOSfZKvCaHpst86P6X7jXdT/tb73Z85zRLy6SbCFcsIIN52KZoNK8Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145981; c=relaxed/simple;
	bh=6JIyR4PjONvgH2rYoN+fTE8PUNRMYmGV5XVnZLSHxkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mza717qVNYLG6C0J/0yIABYiQRwI4Ywu4fW4YVFjcyhZ+MaVOSLmFUBVW0m2JY4Jn/puGas/pp8oaPTkT6QQBUVOX10G7g8w3oMQllfwX6TqWvTI9fGNYx3XrXGX3L6712tuKuCILFBcbHFe6oMfWyptRwd/YEAI17LtzFbiO2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SVgS4jiO; arc=fail smtp.client-ip=40.107.115.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szFhV/MwmeQsHr8VmgmhzWwFy3VrNwjGYEGUZhIvGbcwvWX8xHnZoYImT6/0n1POvYF2Wq1TvkqAoRekS+NmDK8i37Qbyb6M+M+WX1h+9HPtf9t7h/G7cghVahww45jwyZbJiF96Zokfhln8eXNg2J9823KkmXh5uA5HFuY7X8i0+y9O7jUJ7rsUgGhWF3Qt7jW9dwb0RYub+Qxb87N1UBX7YcPXDT8+t89A8usqT2Ro1JT5jL+YPQ24Y20xI3wkOCkCf2ovHELC45qMXvax9Cb/VQKXuo/0kq18duI5HYM95kSkhRN9Qc4ZMBbG+rcobHEW1tddZgT9N31CzQzsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxf+j84a9i1NQIEEYNtGGL5+bRRJDzgoGrnoD2rMsTI=;
 b=E+LgmByZyMvtvGhKoF7pkwP+LiAMzpF+cQc3iXq1I8dI27iBqKkvyHCoQgiU8XVyb0iTUiS0BGviZuZRqo6jLZxf2JB3aWc2IOADBB4u4XXGyd48eycwOqXEueKsjDyRNVliO2xYxL7KunRYWFBUoYelau8g6Vav81eTXd9HGodmDx/h/N0xv+Ud/1p9bQjCvS27H10+bzI+jz+1h421IRjXXUB2WZMt2cOsM4LcG/bmgXfriuCU6FDxm1dlChrciYg2gDNNqEaW4SeR2nb+zZUi2xN3I6cJk10V+gPPKtZ47WIJBJpLTkixlsuPD64J0mNbfus79NuIQminorfwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxf+j84a9i1NQIEEYNtGGL5+bRRJDzgoGrnoD2rMsTI=;
 b=SVgS4jiOCWpFZlgnFQF9TEuRnB0WSsgSXrdsOV8lGRUAg/pHy9E3AaVwhYRKXl92bPp4iksrSfNhqw2wJStfiYcIwI4WOjKLqf1//gdYpY5YParFHi1DuJKWDAiDGb2cy5qVam6Sp+g2FTfj7OU+83WDtY9enEIstha1T5jdwrTYHs0f7RwX87LAVa17HIqK8jO2jUY4wHBXv/PzFnzhw1UDAUZDp1hSh5iO3LUrxO3VvwzQDk8aBO+Ttt1QsXeNy8hXUR9OVufS2SpJ0FyJXvgfW88lNDseNulj2JjKppmrZOZuT0KVCUWgs2JBXwEECSDpW3rIJjTdZfU5jImtTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT6PR01MB11089.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 18:19:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:19:35 +0000
Message-ID: <130e2d99-6c8f-471e-9a72-d858431741ee@efficios.com>
Date: Mon, 25 Aug 2025 14:19:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 14/37] rseq: Cache CPU ID and MM CID values
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
 <20250823161654.164761547@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.164761547@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT6PR01MB11089:EE_
X-MS-Office365-Filtering-Correlation-Id: 19949030-99e7-46de-05e5-08dde403f20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUZvclJvcStVQm9yNUlPRFdsRGk2SVIxNmpNeGYzN2RwNTg5ODRLVlBYZzkx?=
 =?utf-8?B?dDExaHh3dGJoZE9qVjRZR0UwWCt2aW9nZWdpN3BHaW5YTUNCRmEzN05sL3VI?=
 =?utf-8?B?VjBXa2tZNFhQM3hxdWZveGtvKzRWSWE5Zi8zUWkwblF3aExsKytCWXlGdWo2?=
 =?utf-8?B?ZTdnUWtNK0tUdzYyTnhxdVRUTUN2c3ZhNm5LWVZmMW9jVEhsVlY2TGREMTFL?=
 =?utf-8?B?MzhidzIyT2xrUEVtN0ZTUFNoTXR3RmNqakNYQjhacTd3Vlk0RjBUZVBCOVJJ?=
 =?utf-8?B?ZWx3NGdxYlVDdXZCWHVIcHRHOGZHcEFKaStsYS9HTmJESWhOT2dwY00wWWdR?=
 =?utf-8?B?S0FQckpMVTEzaW9XQUF6ZG94UnpVUFFwaWFvaDk3RW9icy9Ob2loUTlicDNF?=
 =?utf-8?B?Rkw5NkpTelZST2xaVlZWZVk3Nlo3T0JrYkFIdHdUS2JQVFVGNHp4SlVrVFlW?=
 =?utf-8?B?dmU4RFY1SVNWYmZkME1qc2lRTVBxRTdFZkNxSmlCZnNLREJDZnc5ZHNjc0tN?=
 =?utf-8?B?WTNSSzhQRWNYaVdJeGFMenJqb2VXSERUT252azZOKytpelBiRUdLaldDVnpR?=
 =?utf-8?B?aXBRQjZRVzJUWmpseW44TGwrUUpHclJqTCtPTUIzMS9YQzZrN0paM0k5Z3pu?=
 =?utf-8?B?T2Fzd3dTdTRUZmRZTnRsWmViUC9zM0V3T3lBTXhjUWpNbE11UFNkOHY2NGVW?=
 =?utf-8?B?c015QUFLVnhqZFgvRlpwNHl4QWtwSVJRR1JONlFxcTIwVEhJWnJyWGlJSDdV?=
 =?utf-8?B?eE13ZHlJcU1JTFVJbjlaNjBQWHpGSng5VldzcE1sbnRaRThFSmZEZVNxamJS?=
 =?utf-8?B?R1ZUUlBIV3krTHRDS2dSSm81TU1VaTBUU1NUNmFDMHJJWjNVL25kcTlNMm16?=
 =?utf-8?B?RXdseUZyUERNRDg2WXZXK1lFR1ZrTHJmd2RyWkY0U3VKVG15cFBCbjN2WlBR?=
 =?utf-8?B?QkFNelpRVHd2QTRqQW8vTElNNCtyZnEyT1ZqV1JabGN2ZnBtcnBPL2xYbWto?=
 =?utf-8?B?bnR5SFN4S05YalpFazZ5Mk1EWlZ5WUkvc0ZLeXRBdC9QZzNuYldpejJFNUN5?=
 =?utf-8?B?MFhGS0d3WEtoRlZTT281NHRiVzNVYjRVdU5wUlNWWm16ZnpVbDhpdlJyYUZu?=
 =?utf-8?B?ckJqWFQ2ZTgwZm11UlNrSS81OWx2RGdSblJVbXptZzJuY0lBZTBpbmxaemlz?=
 =?utf-8?B?S2JLMkh1eTM0OGtldjRSTStHRzVuZDFudmp5SlNuakFtNW52R0Uyems5S2JH?=
 =?utf-8?B?WGxSQVRsWGRTcEczcXdTWk9QWXQzbDlwWGd1ZG5QNWcvWUxWTWVyQmZESEhB?=
 =?utf-8?B?NDhnZm5sdGdwR3MvOFBscWdabHRCK3hPOGJCcmF4ZlBqM25keDZJbU9MY3A0?=
 =?utf-8?B?dGtYWFVsS0RNWTFHY2pJNXVaUDkwbEdueWdMRlR6a0E3Si9zbGtqNDZKN1pM?=
 =?utf-8?B?Z2w4Z0ljUGw2RG1wUUJEYytPTE5UaTVCMGI2TzZNdzdINm8xcFdMWDhLaFhy?=
 =?utf-8?B?NnNZZGNtWmI0WUxPY3kyU1hSc2hzbHgwaWZUdnFyWEp1M3R3NkJDMjR4S2xi?=
 =?utf-8?B?VVFEY1h4bWhkbWN0Qm4zK1dzeUUyQnE5T2RtOHFVWmF5dTNoUkUrR3lwNTZr?=
 =?utf-8?B?SHhQYjU0bGJZZWVKNmZrSHZlKzE1ek1HOGVpQkNSY0VHL3V3V2xwUElCUlNV?=
 =?utf-8?B?ZWVTTUU4Q1BHTkkzOE9mQWQvZ2JhNjBwZjJEVm0wYm9JcFJFV2tYejFMM0tN?=
 =?utf-8?B?b2hhdlF1TXdzRU1TbXkvc3pQdjJmTGU0dkJGN1BQL3pXNGhDMldjM1M1NnR2?=
 =?utf-8?Q?enXaRlHt4GdPrL/NtF5M6QvMS0RP0yxC8Nq04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vnl5aU0yUVZySjl4T01sa2RsekRZZW9jbmYrME03T2dZU25ZRXRBZmpPQjdC?=
 =?utf-8?B?RG15M3BTMTV4N3lGQ3hGU1pTTHFJMU9RbWdxK1l3SDBzd2pKdjJDV2FmQWRp?=
 =?utf-8?B?ZUpjbzduTlFxdlRkSTdzZEdHaTlXYStaMzNZZWR6ZDZjbkZVMW5zV1hTTkN0?=
 =?utf-8?B?NzVOTVJ0MlU3MncvTmxPQmd1Z3RudjZRYlIzanNGMU4wZm1nYjJuVVJCUEt1?=
 =?utf-8?B?cVZ2VUxlQUZhNUtKWTNoNUl0blJtd2ZvYjRvSXN0ZnZVdHhLVmhCZGZjZitS?=
 =?utf-8?B?eTlEMU9BcE9qaE9wU2pnckpsdnJObG1icEYzZHNvRVNiZ3NudDJoTm9GVjVR?=
 =?utf-8?B?SjNCNkZsak5mR0lmSEtRZXRSQUF2cmROVHQyUkhIWUlyZDVkWTZITC9qVnF2?=
 =?utf-8?B?amVwMXFpMWpJNS9LQmxaeXB5bS95OTQzMEU0dTZndHpSVW5jMW85SEVpdk9V?=
 =?utf-8?B?akoxeXZRSGp6QTF6SXZTc2wyRkZvVEVzK3pja0hhbTA5NVlvSjVQQkoxclB0?=
 =?utf-8?B?WC9xbk5ObkRYdVd2N2s3TVNGblpmOVMzWXN1YTV4K3VqWStMMy9tbndUcDhF?=
 =?utf-8?B?SHVJUXRReWY1Y2J0WU4yU0tCY0dRSEV0Qm5ud2pHYXBkSEZZOTZDbGtwaGJh?=
 =?utf-8?B?eDZnTjVSKy9SdDBXWkNsNTBBM1d5L3E2TytJOUV1MHlObDBSQ0tIR2NXZkdK?=
 =?utf-8?B?cndqQkxhbGZXMkNqMS8wUENGNHpRYkppZENhZkhGTEVHT3JVUUwxY3pHTU9D?=
 =?utf-8?B?SFNKSVRscGwvS0o0Z2JGeEoxRGh3Y3BPTUgvV3ZpelQyejR0c0lmdGtSck1l?=
 =?utf-8?B?VSszLytNeG5xSmxMMExtaW9BU0dhWDFtSlM3aktuWG0yaG5SeWEzLzYrbDh5?=
 =?utf-8?B?U1JXQm8xU1IrUVp4RDVSREd0M3pLWXJwZk83NjRjZGtOK0JKaGl6ZEFUcWtK?=
 =?utf-8?B?L1pIcnEyNkxYUWo4MTlpWi91NzRualI1OVBmL1BQYjJ0Y2lSQkVLMHpReGJR?=
 =?utf-8?B?c1BIMytjNHVOMTlXMnRFQzBuZndycTBIdmpDc29JaVNLV2IzOU5xT09UTFUv?=
 =?utf-8?B?bVFrWUtrOWRhNU50bnViVVorUDFEdzIzSkM3MGRoeS9xVFJIRVBMekZrc3kw?=
 =?utf-8?B?V01HUlZGclFLTnBaZHo3NTcyc2VadVNFZ0w1SzNjQU5NYTlVOFhEa29BOE1s?=
 =?utf-8?B?THREZWNKWEdrb3VJWVlCMk9qY2lBdVVRU095ZlNEdmRuTnF3TUIwQUJzZVhY?=
 =?utf-8?B?Tk9UN3BXcEtKdXkyVzlKWVFwZXJVZ010dUNaaFJ2M0x4bTlXU1pJRUUxa3Fq?=
 =?utf-8?B?MzhOVFQxNTBzUkNldXAza3dKMUVJSHI1Smc2Q0t6V1dYd0Z0eDg3eEpCcjVy?=
 =?utf-8?B?QUI4dlZFMUJ4U0tYTXZEOEowc2RHckdnRlV3cndPbGFxaTR0YXF6eFhmUS9J?=
 =?utf-8?B?ZjIwY2V4eVhjci9KSlczcHBIamRVT2JnL0VuNDJPMlYxNGVFYlJzRFBUeXZ2?=
 =?utf-8?B?cDZMdC9YcnlIMk8vc3AyNUpmV01ZMHRUS0NUblpES3RkT3QrT1VZeVIzODBi?=
 =?utf-8?B?RFhNVHFIQWpsNENRVjlxcUZhWHVhRkV3MHE1TDZmUmZmZ2RmYmRJc3RGcG4z?=
 =?utf-8?B?K3FOMkVUeW5vQmlxVXdMTlVvYzNNaVhQeDEyV3FBWEUyUU5rSkNMeDZTWjRh?=
 =?utf-8?B?T0ltQklYaTRhUi8rblJrQTdITFozc0JOWUpsZUZCaGNidExSTjNIZlBDMmFU?=
 =?utf-8?B?Q1ArTWo3MElvQU9RYitJNG5zSHY2RzJnaksyYzExS1pzTUdZc0cyU0RGby9F?=
 =?utf-8?B?VVZDSzZLSHoxT3AvRmpzeHZSVUVZUW41cVhOM1djSnJsOFc3WmVodklOdTZB?=
 =?utf-8?B?TlNyTHJiRXNLa09uT1g1dFNzODh1K09BSlFJUUZ5MHdKN0ZmdHRMUjZlaCtl?=
 =?utf-8?B?N3pZcDBHUHQ3SEZObVYwRGdUMjJKYjI0bWh0WmhJb0YwZ0F5MEt1Z2ptNXBm?=
 =?utf-8?B?WUhWZnl4NUFjVVpvZ1BWSE0vWDJVNWdFaXdPTzZSemJyUGFRMHU4TkpMYWdW?=
 =?utf-8?B?WEpoK2ovaFBXTFZxY2dHTU9GTVRlVDZuQlZaVnJmdG4xcDJUY1YyVWVlR1RK?=
 =?utf-8?B?V1c3d1Nwb3FCRzYvZ1pUcXI1WTBaSitqMlRFM1lKVTBza0FlOGNmcUVHeE14?=
 =?utf-8?Q?JWpD707XqwO8ViXErK/PB7Y=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19949030-99e7-46de-05e5-08dde403f20c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:19:35.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XGBSHdky7ZRKA8pcULV6mtom2M8E0J3Zn1ymf26KSOcCyzowvDUJatJQRP+NFv+U553eKcvd/c8n80gZdmap5471awE/wKv1fZqwJAzjvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11089

On 2025-08-23 12:39, Thomas Gleixner wrote:
> In preparation for rewriting RSEQ exit to user space handling provide
> storage to cache the CPU ID and MM CID values which were written to user
> space. That prepares for a quick check, which avoids the update when
> nothing changed.

What should we do about the numa node_id field ?

On pretty much all arch except powerpc (AFAIK) it's invariant for
the topology, so derived from cpu_id.

On powerpc, we could perhaps reset the cached cpu_id to ~0U for
each thread to trigger an update ? Or just don't care about this ?

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq.h        |    3 +++
>   include/linux/rseq_types.h  |   19 +++++++++++++++++++
>   include/linux/sched.h       |    1 +
>   include/trace/events/rseq.h |    4 ++--
>   kernel/rseq.c               |    4 ++++
>   5 files changed, 29 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -64,11 +64,13 @@ static inline void rseq_fork(struct task
>   		t->rseq = NULL;
>   		t->rseq_len = 0;
>   		t->rseq_sig = 0;
> +		t->rseq_ids.cpu_cid = ~0ULL;
>   		t->rseq_event.all = 0;
>   	} else {
>   		t->rseq = current->rseq;
>   		t->rseq_len = current->rseq_len;
>   		t->rseq_sig = current->rseq_sig;
> +		t->rseq_ids.cpu_cid = ~0ULL;
>   		t->rseq_event = current->rseq_event;
>   	}
>   }
> @@ -78,6 +80,7 @@ static inline void rseq_execve(struct ta
>   	t->rseq = NULL;
>   	t->rseq_len = 0;
>   	t->rseq_sig = 0;
> +	t->rseq_ids.cpu_cid = ~0ULL;
>   	t->rseq_event.all = 0;
>   }
>   
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -27,4 +27,23 @@ struct rseq_event {
>   	};
>   };
>   
> +/*
> + * struct rseq_ids - Cache for ids, which need to be updated
> + * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
> + *		compiler emit a single compare on 64-bit
> + * @cpu_id:	The CPU ID which was written last to user space
> + * @mm_cid:	The MM CID which was written last to user space
> + *
> + * @cpu_id and @mm_cid are updated when the data is written to user space.
> + */
> +struct rseq_ids {
> +	union {
> +		u64		cpu_cid;
> +		struct {
> +			u32	cpu_id;
> +			u32	mm_cid;
> +		};
> +	};
> +};
> +
>   #endif
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1406,6 +1406,7 @@ struct task_struct {
>   	u32				rseq_len;
>   	u32				rseq_sig;
>   	struct rseq_event		rseq_event;
> +	struct rseq_ids			rseq_ids;
>   # ifdef CONFIG_DEBUG_RSEQ
>   	/*
>   	 * This is a place holder to save a copy of the rseq fields for
> --- a/include/trace/events/rseq.h
> +++ b/include/trace/events/rseq.h
> @@ -21,9 +21,9 @@ TRACE_EVENT(rseq_update,
>   	),
>   
>   	TP_fast_assign(
> -		__entry->cpu_id = raw_smp_processor_id();
> +		__entry->cpu_id = t->rseq_ids.cpu_id;
>   		__entry->node_id = cpu_to_node(__entry->cpu_id);
> -		__entry->mm_cid = task_mm_cid(t);
> +		__entry->mm_cid = t->rseq_ids.mm_cid;
>   	),
>   
>   	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -184,6 +184,10 @@ static int rseq_update_cpu_node_id(struc
>   	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
>   	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
>   
> +	/* Cache the user space values */
> +	t->rseq_ids.cpu_id = cpu_id;
> +	t->rseq_ids.mm_cid = mm_cid;
> +
>   	/*
>   	 * Additional feature fields added after ORIG_RSEQ_SIZE
>   	 * need to be conditionally updated only if
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

