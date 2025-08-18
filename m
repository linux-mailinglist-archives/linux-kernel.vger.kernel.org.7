Return-Path: <linux-kernel+bounces-774181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42569B2AF95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082192A101B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6C26F2AE;
	Mon, 18 Aug 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ae5EnNLV"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2124.outbound.protection.outlook.com [40.107.115.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215FC2472B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538722; cv=fail; b=UHp56rNQm7DrO3fF6SlmTTkzQ2PPr0AiI/Nts6o8/mYHNLHZAVhX+/L0oCfIcWeXcvpPEZjforX5Mh3pgRtyABChha7qz0I291Hybs6GqmhKDNr+c0g489HeT8nEs9gD6prEzNwPBwQpnK4UUUuKvd1B9M8yoMOCx8+lZgx9pxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538722; c=relaxed/simple;
	bh=6pmcSy0BAWHLY+uMpgBPyVusjnL5+/Q+jB6O0XlAIdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ByHSNLy8PLI10KRd5ogiZV4bVvxwwGEerQneQV0ETM2SlI3Z/4cdwP1A9yu7Oqn0/N6aRhVLg2koPWrF3/DaRp2pLPqIf091XnQK4OwPbxnd33gPh6zcP/GCFly7P2IZubwMx1pAkWnaSkqWkkcdZltULdssapmVNwORO2ZM9aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ae5EnNLV; arc=fail smtp.client-ip=40.107.115.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQH7Iejo2nSL+5AZFqhu84eWXLUCTWyaxJsM3729CwxNo0eTma6Vg7+9ZXJbSGmF+odbhucACqoc+dYIqcjb1xkhBo+JseMe7mtpp2UB36yVojZTGhMOdmW1to9yyRtWDhrFIQNc9fLbXKPjbgSQ9T9TXA0rWX1ETfzZC8+6xWTs2rwhQmf954aqj/Cd+QYMgEFSi3oJ9BOdEDO9OZGv2Z91vEkFGCO4qBMau/ETm4+kiC1LN4rJ5hMAFjtHhqvAv6xffZirWEfHhN8MK5tE2BzP0liSjmgl6rjAhgov23jhfZr1qNRkDfqbfmbG726hp8nXSfIhvVO/Hzpooedp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6xRD0N1n3aG7zLuA4i03yL2/dBdeYRYn5LXbhrIZv0=;
 b=vHLvkalA9qaMKOR3F6oANbclqfiLUaibkfLBLNuhPdq2caOXZVrTXQjp8uReSfjAZpGDq4D/X92zYBK/410sbI6FJaLt2e7aFbpib2kl+4MH/KBe8MojN88EdZPluMWc0R4jLOA+DftY+Vuuw8+toHXTkUuZkIsLtDt0NL3FXfS5JYLieZFYCUsDozVKZQbY4RBYfBRVHPje5GaOxq6ZAo3tt4giD+HHsimD4ZU4n7vwD6i6UqfequuUHmrMUKo+yI5NKswTPGYKdVhxnbq+dpEdaqHfzB/ePQmMEJmyQEZWHoHJ0gvuyloIyikvF9NvVhooDETUayVA7MEe8TdvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6xRD0N1n3aG7zLuA4i03yL2/dBdeYRYn5LXbhrIZv0=;
 b=ae5EnNLVLiSNIE6uQEepN/hmYxBZjqqs4+ZStultCjn1XYTayAhd4RBrq5gPywsyukKpaYCXzi3V2GNF9uXkrR8CIhSEmDOT/DHt6CJxHWYRbimY3GIUdp+5TEQ8fZSXqTjRU2gtTPEYreD2gTra1zaoWOxqsOGwf+mKAW6yRb83DxHJ0eV07BGFzrxrdVWAZ1RqqkNU5qyi0f4PVT2GsENt7NGwvCP49KPmma6YcZSJ8coleR3K5lqGdwzyyfKbkNNUdTLilKLOl3sDThDJu732ogTukcjCtCQo4ENz86+w2O1oN/7MiMUI0cjs548k9SbGqQtzfBC7RkT6suOK+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB8856.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:38:36 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:38:36 +0000
Message-ID: <e6906764-66bb-437d-8082-b1d6a48ffa55@efficios.com>
Date: Mon, 18 Aug 2025 13:38:34 -0400
User-Agent: Betterbird (Linux)
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
 <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk> <877bz67u3j.ffs@tglx>
 <87y0rh63t0.ffs@tglx>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <87y0rh63t0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::26) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 123f8d8b-62d1-4129-fe4d-08ddde7e0f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhuYlF5K3lWYi83THFRZEZJSUdRdDJzUUNsV3pUc296b1ZLZ25uTWNnWUFh?=
 =?utf-8?B?K1ljZFpuWENveE1vYXhNMzlBTFhKRDRRQmJuMGJYZzBic2ErVDNHTTdJNUpB?=
 =?utf-8?B?cWw1eElHQzJGa3NpdElMcXdOQVRJa0NQTnc4OXkyZDdrYTQrTi9HK2x0YUx3?=
 =?utf-8?B?TEdSVjhoTmdTVUUxSzRLMXU5Tk9DZmJJM3dFK1dFY0VCTC9LVXlzZTB1S20w?=
 =?utf-8?B?cW1TbGdLckpYeFFPYnZpdysxdkltMFJ6amVDOEdpanYzemlucitvTllaaDBw?=
 =?utf-8?B?endaMXduL0Q0RFhzM2NZU3ovNTZoczN1dUVIQzMrbmVPUDZZSS94aDBycGwx?=
 =?utf-8?B?STJXa1lwanAvTVQ4V0xpRnkxeCtpbWtBQmx4TUZ2M0NpR3d3SzExRmNTWVZB?=
 =?utf-8?B?eUtjWWhCKzMvbks0U01nVDU3RWpPM2lnSmxBVUFWWGZMMFlQZ2xEUFBGRjFM?=
 =?utf-8?B?Rk1PN0xUOHhvOGU0UU9hWnhDdGp0WnJzM1ZZaXZYZ2FpcnRwRXFnYjNYTFpp?=
 =?utf-8?B?MlBnYjlleVFoc1VkYmNYZ0lXTENEZWFUSENlRDR4aEszclBFRThCWDUrc0Qr?=
 =?utf-8?B?QmMvdGJaamxSNDh6LzJQRThRZHZGYVNYMWtBM3pWVER5WURZYzJBdE9oSVB1?=
 =?utf-8?B?Y09HOHhNMTJBSCtvOEptaTc1aitPYUU3WFd2UEhJUCtDc2NMOFh1aGMzaXZE?=
 =?utf-8?B?R2NWNmgwV25IMnBPZGlKcUtFZVpDWHJ5M01Qakl5N1NNNUt2WjdpeTYwdW80?=
 =?utf-8?B?enpDOU1tS2JCd1VEaGRUb1RWNDdSQU9yOWJYUEdRc2tGKzhkZWU0Y3lmSDZi?=
 =?utf-8?B?Y0R4QkhnekdhS2RQblpyS3c1WmN3L3lrTXRuTjlUUzBERHhxN0dIOGd4MlJM?=
 =?utf-8?B?Z0VveE9lSEhEU2FjVWpFeUNmS3dKQ1NBNk1iUW8zZ2xxYU01UnIvOTJncUJY?=
 =?utf-8?B?VWVieVJhQVpPQnlwdzR3Zk1rTDRBM1h6UWJDbUgyUlZzS1RGR1pFUHczbEl2?=
 =?utf-8?B?Y3NnU0J0TktXOGRFZHhzd3l2YytXUFo3Smk0TGN4TjJKeGd0MGgzM01WVU9v?=
 =?utf-8?B?aldKcUFIaDlMRkY5K0dxaTYvRksxbW1WM2g5RXBOOWZiellPa0R3TFFzOVpS?=
 =?utf-8?B?QndLRm9NUzg5cnc4RWlvdjRadU11bkZydVlpL3UrdlJRdmtOSlhRaEVjWm1l?=
 =?utf-8?B?MnZrMlNDTlA4blRSTCsyL0kzTVZ5RWJ4d3lwdDhhdnl3VGtNVit2eS96WGlI?=
 =?utf-8?B?Q0JQSWlrRUc0eTJpSG5NWlNhOGJFK1IxdW5YemY1bklFNytIZVB2SUhNella?=
 =?utf-8?B?VTdRUXZqaldSMXUyWlhtaGwxZG1haFhPNmp2WmZZWG16R3ZoYWdHdnk4QzRV?=
 =?utf-8?B?ekZMV21QOHA2SmF6bFNKdEhTRUlTb0pyMjg1L0RHVFJ2NUp5QmhRczRLS251?=
 =?utf-8?B?bHlDYjJsUXB6TzNSd3BsSXNJRVFOU2F0eEU0empXbnRlaTJaWDVWSUd4Z3hO?=
 =?utf-8?B?bHE1aEZDNXNPenRrS1p4TjZ6c3ZtMXgwR1d3aC9NdzZJYW5hNm5oWCtxMHU1?=
 =?utf-8?B?MVFobEc2ajFRYm5KQS83eXNRZVV6N3NIa01RdnZFeXZyZmhDSi82NE1HODhE?=
 =?utf-8?B?cTRIMTYvNnp0bVpiQWJneUp4Y04xcWhvcVdYUDZWT3Jsb2dwT1lWdkJvMFo4?=
 =?utf-8?B?cFBBZFJMOENjRnh4ZjkrcEtETWpaaFBsOWoxSytSeTFnbVd6Q0ZmeXJkUWU3?=
 =?utf-8?B?ekNxWjdsdVV4RzRXNHJONHdHT1BCU2tUaGVEcHpFZk0yNklDMTNDSUlVejNI?=
 =?utf-8?B?Ynd6d0EyMDJLRWwvNmlIamFkNG1rNk1WRjJRM1cvaUxJZHJxc0hSbFVYelU0?=
 =?utf-8?B?SGFBdVRlaE1xNVJDVks1NkdGV3d4dWgzNlQ2WHdoQ0JRSlRLM2tEdlY2S0JQ?=
 =?utf-8?Q?ZEPli3WDwpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3V4MWhqSjcwV0hiRVZCYmF2ekM2QzlTa2UyVUdVbU1EeWttd1RWeEs2WW9p?=
 =?utf-8?B?S21iUFZBTWp5ZzRZT3J2TytZUnNXclBZR3JZODFjSFVTWDZoWUMxQkhRQ2wz?=
 =?utf-8?B?eG1vYWFVK05YSFB6WUFGdEpJaDhqY1lYNTJYZnppMThsNU5JM2lnejFCekJQ?=
 =?utf-8?B?MFFjeW1HYUpVR0dJSTgyMVVqMHRwOGlhc3JJa0lKSklpUHJoMUUvTU5jdnRu?=
 =?utf-8?B?UnpTRnYvb1NZRG8zWnR2RnRWTTBIeUN6eS9KUmJmUm9sVHNVM2RpNjFhMkFP?=
 =?utf-8?B?WEU0d3lQY2hXN3BDaTJaQmdXSFNhOHRtZWhWbnVIZjBYLzJjOXYvMnh1QWJy?=
 =?utf-8?B?N01mUUk3TDloZDdUUGI1ODVzRzVPc2NYU0dvRkNsdVdRY3pVYmNVRG5mdC9p?=
 =?utf-8?B?cFpHYW5KTUIvd3N2dExSTEFUcFEycWdJMnp6a0NkWGN1RllDc2xJZ2lnZGFy?=
 =?utf-8?B?eUhsOXRONStPQXFUNDdCVldCcW40WWFUM0g2UWRlbDNjam9mQzhITUt1bU5r?=
 =?utf-8?B?US8waENUWW02dUIxanQvZE9uZ2xRRWV1N09HTXJ3VElGVkZwZ2ZRdERYMkFN?=
 =?utf-8?B?ZU9CdjdFY3JoSjBrRmd4VnlSWnpKUnV2THM2a3hjOXZYYTZVaHlhVG5OaUdv?=
 =?utf-8?B?eUFDNHJQa25Vd1hWTUd1TzM3dFVBc0JpYThyS21qNWgyQ0lDUklUeGRMUFpN?=
 =?utf-8?B?TFY1c1pKOW9TUEkwUFVsYXFMY0l3c2I1ZER0UldLdVFxQUsvd1RIY25ZVjBH?=
 =?utf-8?B?UXBaa0E2QTZjOVFxbVVrQ0c4Z3F1QTV0TVpwQ2FBQlRmUW9pamhGK0p1bHN4?=
 =?utf-8?B?ZlFqY1U1WnpYY2ZweDZ6a1lMSy9QU1cvNFd3Nkpwc0NvNytrVms2R2o1Y3RV?=
 =?utf-8?B?SzZzQS92TWhKeUpvSGIyZm9XY1BmOXB6V2k0NTFVQnhWRXRuam5TaUg5dDBY?=
 =?utf-8?B?MkxOcDAzVDlZMk5IMEg0aVFvT0I1VDl2TGwwYlorZkJmK3YzdVh6SXBvT3VP?=
 =?utf-8?B?VmZLZHlrMUJXZXYvZTdybDkvcWFJZDBpYjI5anAvMmRST1FpWXBoa1NyU205?=
 =?utf-8?B?eU9PWmtBVitqMUovOWsxdkxwMXltNHlPVXdGZmpSeGFiQjN2blArNWl2aHpJ?=
 =?utf-8?B?Y2MyTXlTZGs5UGFIeXlOd0xyVkxWRWUyMUgyOEY1eUhqcGhCempnamZOd3h2?=
 =?utf-8?B?NVZKUk9SZmFCVHpoVWxrb2prK215WXprbnk5NkZabVZicDdzKzE2ZTBlZ1pG?=
 =?utf-8?B?TWw1UXV2Q05FNmpYTUNSR2FHeHB6amZyVEtBMitJVWsyNXA3QnpKTWJkTGJy?=
 =?utf-8?B?Z00wWXdLR3UrbVZVaHoxRGpKV2I2YTlIKzA0TzZHZmxWMnVnbUg1eUNKQzBt?=
 =?utf-8?B?UU9DUGVsQzhveUtvS3BIQXVkYUFNNVVjWVNrQTBuaktocnNubWlHM1JXTFcw?=
 =?utf-8?B?VHhad3FQUGN3OFhxc3dMbWdDS2h2alJnQ0pQUE40Nmd5YWwveDJJanlLRTgw?=
 =?utf-8?B?UnJ4Qko1L1ZnMmc5a0tJOGU1WUtuSzBPK0xhN29tZXdhRjVCSGtUWjBZNXl4?=
 =?utf-8?B?VHI1WGFweTJQUXpHc2pXWEQ1d2xQVjNTOWFHS0hBc0QrUGN2Z3k4cnQ3VUFL?=
 =?utf-8?B?d1h4cjc2U0dCM0NIL0R2T09PTVYrUFJaeUdqaW1XbWVVRytCTDl2WkhJVkdF?=
 =?utf-8?B?bW1sRFlXenhML21ja09GRTBrcXJ4c0l0U1NaaXRWTC96T2ppc1NqRkdNUHB5?=
 =?utf-8?B?eCswOHlldXYvWEdrRzNvS3o5Wk4wNG9ZZm4wU1drMm9nMjFud05BUFRuS0VF?=
 =?utf-8?B?U1ZITW1qc3EyUUNrbk9lc0tza05aRUw0TEdyaUtwa1hnWllySmYreFNWeHRa?=
 =?utf-8?B?dnpoOUg4T1R6aXJOSXUyOTEyUGpxRmExSHZ3amNvUzhLYTYwUjQ1NEdWQlRI?=
 =?utf-8?B?b0duT2NVRmE1RW1rWUY1NXlmWWRXaUNNRjhnc0w0NGpPczg0Ulc1bEMwU1lO?=
 =?utf-8?B?RDNFYStXc0trRkpOT3c1OHBVRXFjQWREaXU5eFNObmpTYlZVWmlPUnVsUVZD?=
 =?utf-8?B?Ykw1Ykc5aGEwL0NiRVI1cnZDVDgwT1UxV2NxMDZ3TksyRmVlZkg0VkFXVUZC?=
 =?utf-8?Q?IjS2o0ld1Uk4+j/mDNeEBLryd?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123f8d8b-62d1-4129-fe4d-08ddde7e0f06
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:38:36.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnykiLn9qQvW6HGUehcPB5KHsVTKgDhOwn0li9hbjkflrFIPiXTMsMBrnWhpB2dMLcnulkVraCNB43V5Q5qt9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8856

On 2025-08-17 17:23, Thomas Gleixner wrote:
> Michael, can you please run your librseq tests against that too? They
> have the same segfault problem as the kernel and they lack a run script,
> so I couldn't be bothered to test against them. See commit 2bff3a0e5998
> in that branch. I'll send out a patch with a proper change log later.

I ran the librseq test suite on the new branch on a Debian Trixie amd64 
system and it succeeds, here are the rseq stats before and after.

Before:

exit:             746809
signal:                3
slowp:                99
ids:                1053
cs:                    0
clear:                 0
fixup:                 0

After:

exit:          229294046
signal:               11
slowp:              4570
ids:              615950
cs:              2493682
clear:            194637
fixup:           2299044


And I also ran the same test suite in a 32bit chroot on the same system 
which also succeeds with the following rseq stats.

Before:

exit:             717945
signal:                1
slowp:               102
ids:                1039
cs:                    0
clear:                 0
fixup:                 0

After:

exit:          201051038
signal:                9
slowp:              4909
ids:              793551
cs:                28887
clear:             12871
fixup:             16016


If you want to run the librseq tests on your system, just do the regular 
autotools dance and then run 'make check'.

Regards,

Michael

