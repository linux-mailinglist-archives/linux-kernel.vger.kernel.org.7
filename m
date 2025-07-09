Return-Path: <linux-kernel+bounces-724048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFCBAFEDF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31A51C41094
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397E2E8DF9;
	Wed,  9 Jul 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="k0wTunZC"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885001F5858
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075934; cv=fail; b=nb9e7kVx5jOTmRd3VmYUuw1KAt9fwp3W7MZqlUO0HWXlj3hfBSFL36lkOVw1o4BZPOBSGBkOt3/8SIVIzaQgiuH7VFS5F9u0iEt3TQOcj6uvVyfjehpzs0/tvCIUuyuBkAPTPPXroVuQ+hEtMKkQX3QLOdejsjHvhndETyxgoLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075934; c=relaxed/simple;
	bh=KiWVl8GDzNOQoIH3ZUizuw07eLihVo6URCFSAVene0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q7Jz2ORD6MzQMwRYC4+klL/srIcVMCLPf5vM3C1UGj6yI3ycCVi2/pz/UXY6tTU6d8cAx8ZzsnFQyswTEVqGDDreTC8IastQKPbe7cmgHSpvhT/AeHRVdtwb6OLyJCv7feyoTQQG3IC6Bd2N2zFtj1osr1vBqs+d+LubLawIRrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=k0wTunZC; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2kskRiIo9ZYjGTr+B/fB3Bcxj5aMGoW9IpjvyvxRSyV6g7RSZMsKvjofwLBSNZpuVC9FkzQBICo/xQfowePUowDBqXtCEfcYhQXTaYUiIy4dksd+V/lIF8huToqukapkBm4rngpLEp9rwk3Pn1EYCq9AS2eCYk7eHH7TBVvk4ZPq40aTQhjVsI0vTXQm58+44jQ322XdYJP3JyMOQAned9IdMXiSaAIszTsF/fmawuT4NFtJ5AGs1PVnaEoRXd539USyrKOLa9k38WKVXaLR9C8gcb4uezuhcUWI82SMgftG2K+lHqs3J8IJm8x/KTpsC5vcfw/YPGJ9BlCKMGEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amdz9h5wc0ZWGcCGvwp5nXVtolDoa5ogJrJPw9zpfzk=;
 b=oKc3PHwwo/CkHRdqtv+HqWkWgwrhAaPqZ18FShyTuf+mSOGZEhceiYuZL7B6WKCUkK+kRc0XXS7Z3CoW9hCPwyyOzCD8IQ6cdDCddtK+G7bxscpjDt9guoKsWWzHfRs0TcH++7iIvvADfxzTcWEcVbntMHeP6PfSB4qSwMkpgC82I93MCCzxSKDnnYUKTdwOW3ptd57OqeeJf+JkMcOYtUNdp/oawVs9hRQ5n6K2g29dLCvRyd5UpdTp2oPU43zsXY1ZjFtee1d9XK8jqZg69itSpErchstkvDpDR8muY4dobxazddwqAYZfs3isOXy6dm4J+bN+t+YNUfTL7C0elg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amdz9h5wc0ZWGcCGvwp5nXVtolDoa5ogJrJPw9zpfzk=;
 b=k0wTunZCCfFaYPRL6kEX3HNIAhFX/Ii1ExeNmRSdjepB6VBqDX2SaueX3JnmlLobluHDx6Sekuzd+iBsV0D1B+1gPzWyZNOKEn7fVH35GRFWQRAxjarTUtU+HAZbXs2C8iC4V8AkhpS4WsrcXtgKt8UzVEdEyjg35VmoZ7DAwZKSOPdUpPxmnYkIJpz4LhjY1cE6WVbuP9kHH4/rdEv1RsSf4McIczaZKJaPM7UF2qDRqRkF4lWgT+8NyrKJSORAXA2eR4XxyOa+4fGZYO+FBhEYo81PPkceU0irLsqsKEX3JWJoMXWGh/8cvsrtV8YaqpwiBApaEPa9DfJdsMMM3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5610.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 9 Jul
 2025 15:45:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 15:45:29 +0000
Message-ID: <a6e7aed9-ecf1-4715-a422-962a720f4cb7@siemens.com>
Date: Wed, 9 Jul 2025 17:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scripts/gdb/symbols: make lx-symbols skip the s390
 decompressor
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kieran Bingham
 <kbingham@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250625154220.75300-1-iii@linux.ibm.com>
 <20250625154220.75300-3-iii@linux.ibm.com>
 <3a87aa8d-ce40-4909-be36-24c8ea75af8b@siemens.com>
 <6a2524c66c6462c94237058c8ab8aa43f2192c87.camel@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <6a2524c66c6462c94237058c8ab8aa43f2192c87.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f9afbc-b3a2-40c3-fe2a-08ddbeffa172
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmtWYlpvVkd6V2lBdDR3Z1B6eHgxeis5UDQ0QWtFbEFnSk0zMFFON3RRS0ds?=
 =?utf-8?B?d2dmM2thaVF2cDRmdFh6cnQ1Rnh4THRvZjZkRmJ3Rm1ZekxlcGt1VDNCTk1T?=
 =?utf-8?B?YmVhT0t6SzNCcmhVQjlENS8rd1hybTFnTnFZRjAvL00wcFRJdGFwSlZWRkF3?=
 =?utf-8?B?NU45STZVU2dsNHRUeUtXYmxDSVFidCsrNUZsTWcxM2pKV0dMMVR0S1pNRS9R?=
 =?utf-8?B?dWRIdDBNcGgwc1M4V3haOC9nNXFaRThUbkdENlhXSUVJUld2QWxPWEUrQ3ps?=
 =?utf-8?B?bVJWWlNUU3NBNkpQUWxvbmliV21BVzFieGN6VFo4T3VmZDQzMzdlYjBlZms5?=
 =?utf-8?B?OENMQ3lUeVhNaW0wWFpEZnRuNmE2cWtkWitMUENBN1hUOVhyQVRoQWg3cllp?=
 =?utf-8?B?OHJMdVlSQmE1OWs3Qjd1WXRSRW1NKy9rU2gvQVZsNTdoWWFGUkhqYTRkTFB4?=
 =?utf-8?B?Nml5eElvd2pFMXIzaWpvdnVxa0hlc0FyMmh2MVN4MngrSStYakJEVmlYNWIr?=
 =?utf-8?B?K0NKZHc4OHJvVXgvTGZJTUNrd2NhS1hDdUtTbThPTml1WEhUanJocXMvQUlE?=
 =?utf-8?B?QUdjS1NNVWkzaU5DNzd1aGtXUEhZNUN4dVBqLzRreENBazFYVG9OSEtDZ0t2?=
 =?utf-8?B?NFFxYlIxWVpwbWV3ZVhCNVFEUkpkTFR2Z2hORHRIRlpZVVNnRTdXT2dlN25O?=
 =?utf-8?B?dXBvNFdFeWc5eWZ0R3QyZVNxUUhvNmRuZDlYOWRxR2V0YzA1WlltcUxJdEFR?=
 =?utf-8?B?M1VONXh3UVdaTjZKWFN2NmhGZWpPSGwySFRHaHh3bXY3ZUZzTUxuTng2NG5P?=
 =?utf-8?B?eEE5cDdkaVJSOTN1VlJEbEpBSGdZYkVEU05UZmZHUmYwczNtWk1QcmtvVk1q?=
 =?utf-8?B?N0RvaFhxZXJBZFFDZWZISUJyZEFYSDdNM21kRWROeUsyVjUraVZ5UG8yb3po?=
 =?utf-8?B?ckMyaGcxbzBESTVvZU9GWnBOWXUvZGV1WDJmWjhYU3lOZ095aXcrRU1tbFNX?=
 =?utf-8?B?amJ6ZmlYNFlsZDl2bU9UZGxUYVBBcjVWdGZtUVk0LzczTHl4bTRBNlVVYm9a?=
 =?utf-8?B?aHNWWk0zZk5mcEN5ZGd5ZzFiWkF0UWNKNmlQMXljc2s0VHIvSTgybmtoT0Vk?=
 =?utf-8?B?WFd6eUlmSytkQjRvekVidlpvd3JudmNvKzBpYmRDNlBFM2VMYVRGT1QzOFRp?=
 =?utf-8?B?MGJteDkrUE1PRlpNUmNDd0V5ZHY0Y3puRVRCYkhUa1pJS1ZuME5kZllLQnhk?=
 =?utf-8?B?ZEZTMU80K2pPV21rRUFYWFZBZ3BOZTJQL3J1cEtSOTFuQ1FoVW1IM2dsMURM?=
 =?utf-8?B?WjZEaXhZdXpMcFpHU2srV2xWbXpWTHZJY3RFM0U2a2YzUTEzeEV5SitrYWlR?=
 =?utf-8?B?eFpJR20yWnhMd2ZMR2NPRkRzMFAxcS9BU0diWEEvMVBzYTliVWtQZXUwZk54?=
 =?utf-8?B?RTNweldSRkpDcmRMNFQxc2d4MGE1SGFwbHpsUlBvRUtnWU5tUnhFZjZXdTJn?=
 =?utf-8?B?blFjWmdSK2l4bWNyOHVmU2FMU3oxVXJSaGJkOWR5dmp1KytaVXQ4aEw5U0JO?=
 =?utf-8?B?NkRaV1hyVi9mcW10dmQxajNUZDJXcGRQeDhLTmc1TmlBelhoeE5OTlNvamlX?=
 =?utf-8?B?azh5b2tOZjFxTS9TZy9sT09RYnk4ZksrNE92T25xdkFIaHk1UFZPWU9Pdkd2?=
 =?utf-8?B?VEdyUzZmaTNxQnVUSmlIOWd6MXhLRXlHNWcwWVhYSlZSMDhsR0JsT0l1UjFR?=
 =?utf-8?B?TkdDd0dlS0R1dzdVVERnaThjWDdTdTNiU0tmb3NQRTBQVnVFa0FMaGl0ZnNO?=
 =?utf-8?B?dkY0bXF6Y2VhZXhPYmFKN0plelRCeWdGTEVDOTQ3WDNsN3RhclA0YWFaY3I0?=
 =?utf-8?B?OCtJbmJxaG91ZGRMc0ZaemRKSU54RnJzUitXZjhkSkdNTkkvRUR6L1lVeTVS?=
 =?utf-8?Q?zDH2s7YJ+R0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTV2RGI3ejFHK2FWbEUyTjRNOGFqdHRrdTVOQmV1SXNoZ0I2SGRZSmhJMjM4?=
 =?utf-8?B?VkdzQUQrZ2pvZmVZMlBUQXJoSGxvMDQrTEhkWktZcEFLTUVJcXVnTVdka2k2?=
 =?utf-8?B?SUVmZVVvQTl5NmlIMlE0RE5lK0Y2bldWaDF0YjFkamdiamJBNmtqdEJLYWl3?=
 =?utf-8?B?QzRpeUIxWTlTRU1UMUxIT3RPK2Y2dThWUFFXM2diQnB0TGxFSzNNOU1aVTh0?=
 =?utf-8?B?aVl5TVJ1L3YyeWI0TEl4WUpydDNabkFWMWxKZUxNS2JQZ0g1ZCtvZkhpZHFk?=
 =?utf-8?B?TlFZV2JoQXFia1NWdUFzaXVzUFQzNi9kc0ZpS3NKN21oWnFSUHRUMEFiVVlL?=
 =?utf-8?B?YUlpekV5MWZIVnlmZkpUYnpDcHJNM0xFSVA0NU1WNzV0WVIzNzNLaTg2cUNr?=
 =?utf-8?B?YVAxNm1oZnFnNjhPOFVEcFpZSkZ0b3VZbmUrSEI2M1pqZVF0UWphVHVtdjMv?=
 =?utf-8?B?T2g3NVFTSzh1c2NPUVczUlREVXk1ZXU3ZjJDR1dNdFNYZ3pvdm9tU2JXdHcw?=
 =?utf-8?B?R1p6b2hlQW00OXcweTRERVhic3MxQy8za1RRZ240aldYOWpWeHJyVUpwUnFJ?=
 =?utf-8?B?eEIvM3lMWmJybEs0U2gwc0JJQSt1S1FWWHFlS2VJMGFLMHpJQ3BOaEV6VWlU?=
 =?utf-8?B?a3k4OWozdC9RK0pJZ2lQN1NDcUJFajVCR2ljT0FsdVIycU5rSVhTSzBOalJB?=
 =?utf-8?B?TEFFRDJLdGVpRU5NZ2N2NXBNWk0wZjdmdnNqSmx5M0k5eDdNaU9nWDBkYUxG?=
 =?utf-8?B?WkNHQ0xzaUZtdjd1VjBmeWVTUUEvTWpkazI5Sk0wTVZraG1jblVoUnd2Q3B2?=
 =?utf-8?B?cnhuREJneTJ0OFFrcEozY2Vwd09PT2Z1MUJlYlVCMXVxTXlxakM4WVE4Y3NO?=
 =?utf-8?B?ektTc2hOcGN5Njh6OVNSbFhJMWIrdE53TjRSeDFidTNXN21tekpCWkJQRlph?=
 =?utf-8?B?SHA0OHFPOFFHa216VnMwUURDbGh4eS9lbnJzTEdIN2xEbXlMdzZGbE1wNm1x?=
 =?utf-8?B?dVhXdmQ3U1h3SXRsUkF2cHNVUU05UlhxTXFlYzdlZklvUnB0ZHplakFsVzB6?=
 =?utf-8?B?QzRGelUrMXZEbzRyMUU5M0cyTXVTOElyc09FVTBNc3BIOFNNcEZ6VlhjdmxE?=
 =?utf-8?B?U1FJRzh6YTdFRFJZcWl1bkhZRTZ2UGdYQUkxam1YRnMzcDJWaXBjUEhTODA4?=
 =?utf-8?B?S3VET1M1akZZWlpwVEFOc3c4YnpYT1RKU0NObGFyYW5kUWVJTzdCWnZ6Q3lI?=
 =?utf-8?B?cG96cG1QdmlHZkpmRm9DSEdqanBXRTRwU24rVy9JRG5XcHQvMEJWQ21iV3dF?=
 =?utf-8?B?Nk1TcGhyR3hpQ1dOemkzM3R1M0g4RFFqTVVoQkRaUUFraFhaR3BycWN6V1Az?=
 =?utf-8?B?ajJlMTNuMmxVSEpvLzZuMnY0T0tpWWRYR2d4T09vS1ZVeFdRemZMV1pDRko5?=
 =?utf-8?B?aHJiL1l4WDFEeEN5Y3FrdmFERFVkY1k0OWxhUEkwS3dHWVhKeUgyNjhGczJI?=
 =?utf-8?B?cW8zaGwwNjMrdnV2bnVyUmd6bmdES1ZKUzd4M2RsNlQ4TXVlOFpSK3dFM3F5?=
 =?utf-8?B?UndxRFoyVmFsWlBtZG1JK0JhWFg0UW1JMWtKUk9OanRrWW5icVV3RTZlV3lk?=
 =?utf-8?B?QW9GbGErNkVhOVhnRC8vbDJjdms1eUJhRllucmVDMC9BNkNaNmp5alk4ZktF?=
 =?utf-8?B?M2s4RTR6Mm5EZzZoaURiYmR2aS9XcjlQNmZ6dCtlU0xoMWIvZE5nMlRVWjNO?=
 =?utf-8?B?WGdsRkpwUFdOS0ZLK0NlY1FBNHc3eDN2SDFYSWFYWTliRkVJMmt4cE90dEF0?=
 =?utf-8?B?WjIreE8zSUNRMkgzZy9JYmFPUzZkVXZVVi9TbnlGVmpqK2RuWXJIbStrVVM3?=
 =?utf-8?B?RFUrUUttUHFFaDR3cnpWd0d1a25WWCtNSzN4TVl2YWRWZThnS0c1Mm1DQkpr?=
 =?utf-8?B?OEV0TEI1Ym4reDJmb2Jac1o1NEpiTjZWWHdzZldtc0oydUd6emlZajVPWEx1?=
 =?utf-8?B?N0pqUS9qVjRDSGZmd2lVaXNueHpuTWlQamZiL2RsQ3hudm1DYjFJL1diSWMw?=
 =?utf-8?B?bElGY294dHJwNEpUcnB0RlRrbGUwOU5uZndwSG5WVU9FTXJaT1o5MExBeGQx?=
 =?utf-8?B?Z1BiZVJGV0VEYjR3ZzN2QUhqZnZBRUFhSzd4MUlpOXdaQTNvMndLdm10d0hY?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f9afbc-b3a2-40c3-fe2a-08ddbeffa172
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:45:29.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA9L6M0GDjUIaaIQ1k/IjU2n9QmCfJlE+RJ7ruk/E92xNEfJkGvM2TW4csKB8Ycef2DXqdWZcFokiICJxc1XzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5610

On 09.07.25 16:37, Ilya Leoshkevich wrote:
> On Wed, 2025-07-09 at 13:40 +0200, Jan Kiszka wrote:
>> On 25.06.25 17:36, Ilya Leoshkevich wrote:
>>> When one starts QEMU with the -S flag and attaches GDB, the kernel
>>> is
>>> not yet loaded, and the current instruction is an entry point to
>>> the
>>> decompressor. In case the intention is to debug the early kernel
>>> boot,
>>> and not the decompressor, e.g., put a breakpoint on some kernel
>>> function and see all the invocations, one has to skip the
>>> decompressor.
>>>
>>> There are many ways to do this, and so far people wrote private
>>> scripts
>>> or memorized certain command sequences.
>>>
>>> Make it work out of the box like this:
>>>
>>>     $ gdb -ex 'target remote :6812' -ex 'source vmlinux-gdb.py'
>>> vmlinux
>>>     Remote debugging using :6812
>>>     0x0000000000010000 in ?? ()
>>>     (gdb) lx-symbols
>>>     loading vmlinux
>>>     (gdb) x/i $pc
>>>     => 0x3ffe0100000 <startup_continue>:    lghi    %r2,0
>>>
>>> Implement this by reading the address of the jump_to_kernel()
>>> function
>>> from the lowcore, and step until DAT is turned on.
>>
>> Why do you need to stepi until there? SW breakpoint will likely need
>> to
>> output of the decompressor first. No HW breakpoint available? Or
>> missing
>> <end-of-decompressor> address?
> 
> jump_to_kernel is <end-of-decompressor>; the code from this patch puts
> an SW breakpoint there, and this works fine.
> 
> However, the problem is that once jump_to_kernel is reached, even
> though the kernel is already in place, paging is still off.
> 
> jump_to_kernel contains a single "lpswe" instruction, which both jumps
> to kernel and enables paging, therefore, we must "stepi" over it. The
> loop is there just for future-proofing. Everything happens very
> quickly, there are no thousands of "stepi"s.
> 

OK, makes sense to me now.

>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>  scripts/gdb/linux/symbols.py | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/scripts/gdb/linux/symbols.py
>>> b/scripts/gdb/linux/symbols.py
>>> index 2332bd8eddf1..6edb99221675 100644
>>> --- a/scripts/gdb/linux/symbols.py
>>> +++ b/scripts/gdb/linux/symbols.py
>>> @@ -84,6 +84,30 @@ def get_kerneloffset():
>>>      return None
>>>  
>>>  
>>> +def is_in_s390_decompressor():
>>> +    # DAT is always off in decompressor. Use this as an indicator.
>>> +    # Note that in the kernel, DAT can be off during kexec() or
>>> restart.
>>> +    # Accept this imprecision in order to avoid complicating
>>> things.
>>> +    # It is unlikely that someone will run lx-symbols at these
>>> points.
>>> +    pswm = int(gdb.parse_and_eval("$pswm"))
>>> +    return (pswm & 0x0400000000000000) == 0
>>> +
>>> +
>>> +def skip_decompressor():
>>> +    if utils.is_target_arch("s390"):
>>> +        if is_in_s390_decompressor():
>>> +            # The address of the jump_to_kernel function is
>>> statically placed
>>> +            # into svc_old_psw.addr (see ipl_data.c); read it from
>>> there. DAT
>>> +            # is off, so we do not need to care about lowcore
>>> relocation.
>>> +            svc_old_pswa = 0x148
>>> +            jump_to_kernel = int(gdb.parse_and_eval("*(unsigned
>>> long long *)" +
>>> +                                                   
>>> hex(svc_old_pswa)))
>>> +            gdb.execute("tbreak *" + hex(jump_to_kernel))
>>> +            gdb.execute("continue")
>>> +            while is_in_s390_decompressor():
>>> +                gdb.execute("stepi")
>>> +
>>> +
>>>  class LxSymbols(gdb.Command):
>>>      """(Re-)load symbols of Linux kernel and currently loaded
>>> modules.
>>>  
>>> @@ -204,6 +228,8 @@ lx-symbols command."""
>>>              saved_state['breakpoint'].enabled =
>>> saved_state['enabled']
>>>  
>>>      def invoke(self, arg, from_tty):
>>> +        skip_decompressor()
>>> +
>>>          self.module_paths =
>>> [os.path.abspath(os.path.expanduser(p))
>>>                               for p in arg.split()]
>>>          self.module_paths.append(os.getcwd())
>>
>> Otherwise, this series looks good to me and could be picked up if
>> there
>> is no better way to reach the end of the decompressor.
> 
> Could you please ack this patch if the explanation above is
> satisfactory? We would like to take this series via the s390 tree,
> if possible.
> 

Sorry, should have also read your cover letter:

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

