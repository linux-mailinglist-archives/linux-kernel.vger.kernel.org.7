Return-Path: <linux-kernel+bounces-808236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AECB4FC3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05387AEAC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF472DFF04;
	Tue,  9 Sep 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aZLQ2a17"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020081.outbound.protection.outlook.com [52.101.189.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1129408
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423911; cv=fail; b=mUEmcDV7Zj3c3TTJfpQF+toGbwwo/MkE3kMtP5d09AbZJoc/+41CQO/iLovEA3kkbt40yMYK7/n1gDXc9EP3wkOIG1u0msSF09lDDh6sWpFG4pZb838s/uItnzz4cqbiLeAnEiB0GHF801jBAX6Fme+ioXbmQMQby3xbCZ9ibJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423911; c=relaxed/simple;
	bh=hluMLIm7+iUHohgSI9CGs0rAEN7ewnonXUtrfEDUXK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbFSPy97e0Hll7yr+7dWJuJhyp4oup0TMXROCXzSv/KAdh4AV23ZQwcw0RoidkzskdSZCQuH7LZH/5N9F8ylDE3CGq7of+46z/0yMpoCyI9T/hEjV1L6qJwRXMzab5SpiSeMfn5GfRaDowmuRLxiaVmzSZED7trrwpMzBmVB2A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aZLQ2a17; arc=fail smtp.client-ip=52.101.189.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWPWiq3ooCZSb70OJZTKWtaHmapstIZD8PrmwvMmzrHHaPp0aY+VkMEl93etdVPIWQb59VeUtkQY5WyDiuqjRWuNRSZwlxRVv2kFjR2BEfAdELYMniYBeBr0XHdUCYjrk49utUYXvrt2hWGg6pPoeqj64oL3brFNEkf/T51HXN9q+WkkheL4Ah5w/Ywrcvy2aC8b824Du4G+qgZzFgt8oqHBwZEoM8VaCfvN7yptyoaqaQqTLIq4L6b850jExLoLHJCf+g/Z9m/viEwmFCl/Epm81PH9rpfj6Ji65uzzTBqi1RwRK6AnmaqGvrUjBjyFEFatWTrM/dXlws+29igCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT7DkVMODXeKjlWc7fqES5naWynD10VInRjvTy+7P48=;
 b=XL3zDKg8SDX2FKc85iugLP9pFM4KUP8Acy5ByGeXlnJUq9c9Wv++CJlnTxBi2MOXylLsYKFIwjnTHmYX3rexNPqBoCFe1JmxJ6DOkKEkfovV9HZaRDh25n5Hu/ueOtNkwZw4oSy2Z0VH2xfachOqX1b49fY5uxMDRAOsLlvsG74ExlH9fTza5bzPoag1oIopbBBBJ6tjlnQ5Rg+MlgIo/bc71pKkgokcbgKzY63SLZWKaCfaGMeDmTXrbL1ZS4D8BaDGBTQMUEbFgY2+N3Kt0Ae82SQsjdW1YLwIC+wqQIPj9dmpGILs856AUOSOt/lYvUYsyaE6vhydyG34/Rg8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT7DkVMODXeKjlWc7fqES5naWynD10VInRjvTy+7P48=;
 b=aZLQ2a17gHEGAdl036WkTYpQJrLF0jVU25wXCMeuHxzsVcS35/l23wq+SJhDNhbt4YUpRLz8cVl3BM8sDipkKe0GPeTNHfgsEyyCxv3ng5wxZYxoQVwCx/d7bDMQpRyEjcmiIoOpnffOgi8ptq/kh4ftLwAbzeDgJUPURMJwlEqX5yY/0g7WcbB6dWdlVJifGymHJQEM3y8yoyU4EGDXs5XJSBWyf0jgSdJh494B7T5we31RSwddQtMT/3PsZ6CkWEPyVw7Qo5ZrccR++3O0FJqn8iH7PqeUyvhZCIcWsAgq4EzT1Z8fwvq1H3EDWmuLXzb2XoW0qLS9ruWRcMiSIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10923.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:18:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:18:25 +0000
Message-ID: <3440e3e1-0d0c-4c1e-9cc2-68843e9dd50f@efficios.com>
Date: Tue, 9 Sep 2025 09:18:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 06/36] rseq: Simplify the event notification
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
 <20250908212925.644800374@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212925.644800374@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10923:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6df630-13b7-4a84-2146-08ddefa35b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3Y0STJaU0JKNVhJK3NJa20xNmN0Zk9Dd240ME5aSUtZL0EweE5XbUhrYWxR?=
 =?utf-8?B?My9XeHFreVdBZms0SEUwNll6a0hnUnpza1c4SCtPVnN5QklXRVlBQmF4Qkdk?=
 =?utf-8?B?d2s2T0dmaEJQZzVXSFIyNktkRkNjREt2NEZqd0ZxN0JkOHRZS3BTbWtiS0tO?=
 =?utf-8?B?TytGTTlTeWY2Y0UrTnQzSUJRNzAvU1Znc0psRUdPQW5ES2xJTXBXcUVrSXNJ?=
 =?utf-8?B?Tk5tTTVQME1wQ01NdTZ1bW5YNDVFSDREYmdsQXNPUDVKR1c3QjlYVkdwbDVu?=
 =?utf-8?B?VmtlT0FiQUdqdUJ0S0ZFQWtrcW5rN29jMVhTS2ZmWEtSZUhQZHNja1NMZlFT?=
 =?utf-8?B?WnlWRTNkc0g5Tnk3S1J2SXFrTkoySDlVRm9wa2NWVFF5Mm5TTXg5c0VYWkNx?=
 =?utf-8?B?M0paU05Ia2JZamZHRisya2RrSGNIYXR1bnVRVHhwTnF5clF2WFoxYzEvbHZV?=
 =?utf-8?B?ekhkNTFFUGw2bUZVY2k2STE2M2pQbjdyWkVTNTJmZTZ6a3VTOGVmR3ROYkhl?=
 =?utf-8?B?VjlValdUS09PbFhnV0dJSktQU1B5MkdQN0tiMGNUcjh6Y3RIZlNYZ1JUS3JT?=
 =?utf-8?B?MUxtYUZGa0FFWml3c0NwVzAxM2kwWEhWejVmYjlRK053K1BlVlpIRStOY2dT?=
 =?utf-8?B?MnZSN0k4YkdadThRZG9mc1lzQ1dqM1Jxc2R6K1hqSnlLYVNNd2NwaHhJT2Na?=
 =?utf-8?B?aU55TlNXVTJueWZYazZtR0NJTG5IVGRVUEFaYW9qRnlsV1RZUlRuZjgzUk5H?=
 =?utf-8?B?MWUyTGJtNUlmRUdZb3NPVnFweXd0eW1pVE1EUTVrejBQZ1BOVktZS3ZpMFhF?=
 =?utf-8?B?WlU5K1k5LzBNR1JNcWRTQ2x4akpLN1pBNnUrRzQ2WnplMFhzZWptdXc3Yzl3?=
 =?utf-8?B?TVdIZmxLRTRjMFhVejNDRGRJTC9sVk5hN2hSSVA5UHdSY3RVM1Q4bkNtV0gy?=
 =?utf-8?B?MGFqZXN6MkMxVG5BS29CdldnLzZ1U3ZxcUtscTlqUC80TmVuVThBS0NUc0NE?=
 =?utf-8?B?SnVqSmZyVEJxNzR4VUUvK1JVSzdzV1VTQmlrTjl2eC85QkFoNklmOHlRME81?=
 =?utf-8?B?WjNoZnI2L0hoeW01NUZNaTRBZ2U2UjRWSDlOaDlCb2xVT0hZcW5HNThlclZz?=
 =?utf-8?B?NHRDNzN2d3dmMTJhWVFZQ0dZWlpSeEdoQzRKZmk5U0ZpN2l0S25OUmxCNVBw?=
 =?utf-8?B?OCt3K3NFM1ZYVTBYNnM5cncrWkZoTUk1MnIyUzdzelJ6WUs5T0V4QmgvSXc0?=
 =?utf-8?B?WXdlRWtrUlR3UGJFZHJHa28rd1RsRTRtZy9XKzVqcm5kdGpaVldxd1JYb1Ev?=
 =?utf-8?B?S1ZMckRvdmhuSDN6L2lZN3JKYTBJY2NWcUtuUmlVdHUra0V6VVBNbElpbkFP?=
 =?utf-8?B?K0RUQTVmZ2Vmbm1lTE4xajVCZ05LbW5iVXdHM0xhVjlOTnVub1l6ZG16L0V4?=
 =?utf-8?B?WWs4T0ptVURjSytudHBXZ1ZxUGY4VFVLb1ZXcGdqbWhGekxUT245ZS9tOFFl?=
 =?utf-8?B?dUpnby84ZlptNW00NWl6MjM2aDFOb1FXT3Y3dmJZQUJXR2haeUNoaTBRejFn?=
 =?utf-8?B?RDNKeXlyZlZRNXdIbDhtUHI4R0Q1L1doTjB6SVpZdUM4b25STjY4Tk5pREha?=
 =?utf-8?B?ZjJUbjVicDFBM1lCV3JYeHZpT292UHhVNTRjZVhodHhDeXJkZ1Z2MmdLNmsv?=
 =?utf-8?B?K2tOaUFnY2F2Znd3UEJZMUw3OFpVYkdId1dQLy9tVGg5SzlwQWhZL1Ara0gx?=
 =?utf-8?B?YnFxYlpzWTZCaG1ZRG0raWNNK2lWeXhwNTd5Q1ZWd01xRzRvWUVGakI3ZnRz?=
 =?utf-8?Q?hTodxBiAbohuPQ5LyZiJpH2BQz0N9R75Q+guU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2xHU3RZNkRyR0tMSzdpUUY4a2RFMFVWb3UrcnJkSGw2NEFzSEhIWVBkQlhS?=
 =?utf-8?B?QUxvNkIrRWI3SGxVZmo2UzFxMjMyNkJQR2RMbHNXcU1OYzhWR3JkYmNuZjhQ?=
 =?utf-8?B?VTVtKythUW5CNzk2NU5LWUxpNG9qWG1vREtFc2c0UlJ3UWxOditraUlkT0JB?=
 =?utf-8?B?OS9pN3pEcGU0RHM5TU1Eekg0bnUrMmpadDltMTJDUDBaSXhiNHNOQy9JaU11?=
 =?utf-8?B?b2t2RVRxU0hDYVFCSUlKL0xESElCT0lKclpIMzV6b0NpNjgyYXdNc2l1SHNP?=
 =?utf-8?B?bWs1MWFSbzE4RTRyTVl3UUZKd2Znam51ZmxpNE9uOFU3dVd4VmFEOTZZZmYz?=
 =?utf-8?B?UzRtaktTL0RnejBuS3U1ZVYrMVFTcjNOT2Y3WUJndFg3NHdLeVprWXllWWVl?=
 =?utf-8?B?UDNQZkxtSmtCODRGay82andCdGZHTFNCN1JxMU9rU1dMTUQzTGQ2WkMybmhK?=
 =?utf-8?B?ak5SMFFlNGplT3loczdhK0NHNmppRDh5NkI3QXBQY21SWHNkWUdBOU9vR2N4?=
 =?utf-8?B?cUtuSFlvaGpsbVkvZDJWay9NQUdaYkpHV0VQWWk1MmJheS8xZXprS2Fqajl1?=
 =?utf-8?B?RUNnYWd5dDk4QU13Mk1abi90bFlmWFVMWkIvbXZKYUdya3RaSFRTMitUYjdK?=
 =?utf-8?B?WVpaQkk4aXJZRXJNSHAwZG9ucFNXYWxDYllqdGVOTW4yTk9odDBzTVd1eGNH?=
 =?utf-8?B?aEZEdFNpbkNPQ1BWL1VOT0s2SHhCbnR6NkcxeTVhc080MXRCV2xkU05kL3o2?=
 =?utf-8?B?ek9ZSkE5M25rakMwdGd2KzhBQUErdGZYT0YzUXZpWmczWlpCakh6aEN5aUpp?=
 =?utf-8?B?M0lJaEVUMTdBNHFlYzNJRXZYQW1reit5SVh0NG5BdFNTbUk2QjFZWTFYT1Rk?=
 =?utf-8?B?TWc3YkpUNEMzWVg4RSsrMm5mLy9jdm80UTVmU29GSktTUWtWNGxHMzRKOXp1?=
 =?utf-8?B?Yk5VSllObSthdUJoaXZaSUdYT0RiV0llS0FPU01GbSs3UFZpSXpKZkp3WWhJ?=
 =?utf-8?B?MGFseEcrNmM5QzhaSUJZN282UUg2WmdCMzBjNElhc3F1NzlheXVBUTdjcUlO?=
 =?utf-8?B?Z256bVNReVY5NnBOZVhBNFBObVlpUzM4WXhGaE55ZWg4WW9BeUJJYmZWT3BX?=
 =?utf-8?B?d1FkSVpSdms3N2hOUGFXZ2R1ZXE1b211MGdWSnJHaS9vWi9IaXgvSkFaWUNE?=
 =?utf-8?B?WUE3ZjJvQnNta25vaStFOFpXMGpYV1I3ZE9IK2VCR0ZzMmdVMzd3NSs1bUhE?=
 =?utf-8?B?bEpqemVHTnBNV0xEdStQbGkwb2JUa3hIL1FCczVYZkhiVjFqbWxYYmYreGEy?=
 =?utf-8?B?b1B5VlRSYmhWd1NkczBoK2V5ekVpQWxIdEJ4aHBmNm9PSlE4ZXQ2dkMrdVAv?=
 =?utf-8?B?b3FpWjFlcWxtdVIzZGtmNDhKWnp4bFM1ZEVLUXlLanNQWHNwbGw3WnFBWVR5?=
 =?utf-8?B?aE8xUktqWS9MNjJPOU9ad0RDVk1Va3VIN3pIN0s4dmF1cStCcWh3MlVpdFZq?=
 =?utf-8?B?N3VlSFhUMnlPdjZvUG1JN2tOTEFCYWR2dU1pL1V4V3VWaXdpWnVXNzJQd210?=
 =?utf-8?B?UlJ1QjBhTnYvMjFLdmxYSHpzZGlHeW8wckVlOUpqL3oxT3RpMkJ0WjdnMFRH?=
 =?utf-8?B?dDYxOU5OdVMweWM1TjJONVdicVJxSWkrbFIzY1lJSEFsOHA4bHlhWER1b0tz?=
 =?utf-8?B?bTc3QW5BaGd3Z3p0ZmVGSzFPWXNoYjhXTDJkWStUVmlaZ3hlb0ZDc0dXTlpP?=
 =?utf-8?B?aHl6OVpFL1Fxbkx3MzlVS2ExaWxWMFpoY3dSWm5UbHkrMDJRNGVna1cvcUdl?=
 =?utf-8?B?a3RPQXQ1a2laN0IzMzY3bU9sRmtzTVRORy9KbW1Lby9mWW04NzZvMnh6V0Vn?=
 =?utf-8?B?ay9OdVJPdEs4amJ6RXJpUWJKOE1NbVlaOVltSnZwRWgwVmNXQm5LUkRERVJJ?=
 =?utf-8?B?UUZrZzlWdXcvZXZFUjFlRkZZV2tUbWM2c0NzeTREVzR5YjE1OXJPQ2lPZ0RH?=
 =?utf-8?B?bDlCMDAvSGJOUzR5T2I5d1JqMU5aTGQvd29OdzhBdGI4ZUxtMDNmOUNHdmx4?=
 =?utf-8?B?SlcrUTFLR3VMMm1MRkxEWVpiUVVac3llaUNST24xWkRLNERmSzJ3bXRsc0pX?=
 =?utf-8?B?c1NDeExWWFRnVU00UDE4U2JqeFlRRlQ1ZlI2RVI3bDhZeDhmRjBZQ3k0RDVm?=
 =?utf-8?Q?vQNKAZxuIiLzoYDf5xNLKiU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6df630-13b7-4a84-2146-08ddefa35b7e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:18:25.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWsgMH5SSBvcT2jm9ulmhG+5cMRH6LHZtHyliAFL5IP0rqwqpMi5XxZTBeStbye97CA+UWUgC2x3b/vIquWtIQtViLybLzZKK6KiglQ3omQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10923

On 2025-09-08 17:31, Thomas Gleixner wrote:
> Since commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_*
> flags") the bits in task::rseq_event_mask are meaningless and just extra
> work in terms of setting them individually.
> 
> Aside of that the only relevant point where an event has to be raised is
> context switch. Neither the CPU nor MM CID can change without going through
> a context switch.
> 
> Collapse them all into a single boolean which simplifies the code a lot and
> remove the pointless invocations which have been sprinkled all over the
> place for no value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> 
> ---
> V2: Reduce it to the sched switch event.
> ---
>   fs/exec.c                 |    2 -
>   include/linux/rseq.h      |   66 +++++++++-------------------------------------
>   include/linux/sched.h     |   10 +++---
>   include/uapi/linux/rseq.h |   21 ++++----------
>   kernel/rseq.c             |   28 +++++++++++--------
>   kernel/sched/core.c       |    5 ---
>   kernel/sched/membarrier.c |    8 ++---
>   7 files changed, 48 insertions(+), 92 deletions(-)
> ---
> 

[...]

> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -114,20 +114,13 @@ struct rseq {
>   	/*
>   	 * Restartable sequences flags field.
>   	 *
> -	 * This field should only be updated by the thread which
> -	 * registered this data structure. Read by the kernel.
> -	 * Mainly used for single-stepping through rseq critical sections
> -	 * with debuggers.
> -	 *
> -	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> -	 *     Inhibit instruction sequence block restart on preemption
> -	 *     for this thread.
> -	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> -	 *     Inhibit instruction sequence block restart on signal
> -	 *     delivery for this thread.
> -	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> -	 *     Inhibit instruction sequence block restart on migration for
> -	 *     this thread.
> +	 * This field was initialy intended to allow event masking for for

initialy -> initially

for for -> for

Other than those nits:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

