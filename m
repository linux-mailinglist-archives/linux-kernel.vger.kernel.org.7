Return-Path: <linux-kernel+bounces-739351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97485B0C51C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BC817ED18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB992D94AE;
	Mon, 21 Jul 2025 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ibj58/KW"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2117.outbound.protection.outlook.com [40.107.115.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08D2D879B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104326; cv=fail; b=CK6UGrAVIayTcjoBoGvH6IGI9y/FhpG26VSoucC+ukCYuyYZ6yAX4hgBS1oQhL7GNhvDFL2ghPs09ckrNbgSUAqIsbys+rLq3GzqLzDl4DBI82cKOEYE6GxMW7u8fraKN+8qFIjswMKG2B3nsr4zzx402jhQpMVcY3mwbyD3Hyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104326; c=relaxed/simple;
	bh=qIpvh6ymfeueM77Pm5pOrDX4SjmJ3QP3vdsYgEJZsvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdRYzVb9zCUPMfAvAyA84Tg3LPnb7gOZ6vMCRNBALH6v0IWpNK5eQxvAPmuot4refEajhXNKsi0qrz3Yk2HJEnnXK1XE0hXlyYuQNcyYDqW13bJD3j9UFppmFLhTpEp1SnUUue5eXkmLjNHH4TaaW8WB9y7X2AkAMJa+uJHS4ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ibj58/KW; arc=fail smtp.client-ip=40.107.115.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf/UDg4pbhLDIV3Dg9CB499+ZBtuSI+KDJBOijJZ4cFXw3cXPbYMd7e//IYq++wM3YxzB8R0TEF3BGoFb8AxIroJ6g5fj1FWmQxwX+/hU0DiryhphRGvNXd0amNNyumoj2oUaKXGUz+g/lJUo560bSMLwip0gJ3F8dgep81cwi99jLeqlHrRixK1lRB118i7I3euI81dKZ4ESEbD+4fJCTaJX6Tf3xyaPdUY/ly/BLdKHmJJiFpeMpKPYKcmmPq1K4etcfk6SAjhYJQ9lZzhvi16n5cDdJgflNYA+vuH1PZyFnPY4vAqz0+P/XO2U5JDCowxNIwNEtRSPXjz4tbS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zT2ia124LtF4SXT/nwyh2OFu01AsCgs53vbarTUffQ=;
 b=thjdCAwUDjxAz5vY4q/WJcfiYhh8TBU2yv+3kcMWImrSkGZNwtMIXemxwyMVypovBlo7XzJxuN7qAJgpR5P534LaxxFsKkbZskBq32cN3/6JO2ov5k1i/DrGstPTGXwD0YQuuRS224WTGVMA75KWpU8a6OWnBBmxhu7XbXuVFsY48ODJJ7mC7oON3Jhp9EOL9mvswsC78BzcilMQx8TJ3Zuvj1+XN81Qsv293WJf3aBQdcL3eeqQVqhkVOmhx9NHi9QxZZG1Fn/vZZNXJFadvIDFE+fbOXKbmd5WbJl2UOQzNWuId5LM1XseGcXP7TfIe1j9myK8EjhREvw6qR+qZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zT2ia124LtF4SXT/nwyh2OFu01AsCgs53vbarTUffQ=;
 b=ibj58/KWe9w4KJJePQopMJMSXwCf3uzoPe8MsqsTV2FRO0BQhYi9698Jwqm/IiVHwKA64WcvLtqPauUe4Ogekh+2e/lwHFw2yM0xiML2YX+KoEeR+SD7S16Yi7rb1n6aC1Qxf91nkVsGBw4Gf/Hwx208Vy+pPfPjM8LNDYqTPaK445T8TFz+bDU1gVx24g1trEXuQvPSlCIHt5rlYplil7j2WE+93kRS+d5dlJnb9AfX7o3HukP8hJpnQqT0i9jYidtu5AsCTYBRUnDwpnBJcmF9k2Z/IstP4lv86l7KA06zGl0dpNs2DqAu4GSRDELKeV4Pl1ZBs3HDyE1Y/5ncMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF9A4BD32AB.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::26a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:25:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 13:25:18 +0000
Message-ID: <6e737bd5-1167-4cc8-96c3-abc3d3598d2d@efficios.com>
Date: Mon, 21 Jul 2025 09:25:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, dave.hansen@linux.intel.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
References: <cover.1747817128.git.dvyukov@google.com>
 <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
 <CACT4Y+ZcQV3JWEaeh7BXNwXUsoH6RcVRyG2iNUA+_mrOBOHfNA@mail.gmail.com>
 <CACT4Y+anDdNU9rh1xsDRs7vZRfXbbvjFS3RRBu1zVejrp11Scw@mail.gmail.com>
 <CACT4Y+b0cdGZwqmZSikxam+ASp9LXMuT9f8iifnmNed+PjamVg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+b0cdGZwqmZSikxam+ASp9LXMuT9f8iifnmNed+PjamVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF9A4BD32AB:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a872e2c-e764-45cc-3d18-08ddc85a0923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlnMzVMZnFoOHNjR3JtL1RRNjBiYVM3Q0RyYU0rNlZtVktEZVo1WlRMczlJ?=
 =?utf-8?B?TloyRGJkL1hpUVpNekZNbmVvZGNQdkVPZTBMWXFZa1QwekFidFBzYUFzRDBK?=
 =?utf-8?B?Znh2QXhIUHcvbXViQkc3RDdaZTZzM0hjL3dXN3hZaGduREgyMW1xU21JSG9l?=
 =?utf-8?B?SkFEbzFNWHAwcHRSdFNDSXV6QTl4VWpMUldtU003NzN3cGlIUGJhQVZJSlUw?=
 =?utf-8?B?UVFRd3RGSG5tWjZLbmxhOFNieTA3a3R1ZWFTN1JvQWx6dG9yN2Yra2htRHpF?=
 =?utf-8?B?OEpQRk1sSzdDakFna1FESGxCRi9DOE1ZVDN6R0ZPY08yVDhzaCtOalV5aHJn?=
 =?utf-8?B?TjBMTThWL09qbkFnR095djY0WHZ0N00zT2lJaDdta1p2MVVGSUxSZEYybU5W?=
 =?utf-8?B?VzhvQTBVUTlURk4yQjB3NGFlMWx2OUNPbFdSanpKVHFsUHNUL3Q5VnJPV1J2?=
 =?utf-8?B?T24rbHFITllyTk9BNEZXem4yaGxvemdrdW5vZmU3Q1BiRmlIei9vKzNVd1dr?=
 =?utf-8?B?QjRldTV6NzZaR0szMTBPVXdIZHZ1K25nOUtiR2Y4UkV3M2RLb2h6MDAvdlg0?=
 =?utf-8?B?NksxSkNzLzNhOElQdUZLazB6ODREdUpFQmh5M1hNc1l4REFNdExFZ3d3NHFB?=
 =?utf-8?B?b214WXNDeXZPTWR1VWMvV3lhUURqQ1BjRi9UK21HakhGd0JBUWdhQWdWUFUv?=
 =?utf-8?B?cHZudUJGQzBkcERhNzZZejh5bG8xck51K05BMVk5dEZDWGFvbmRnbkVtT3A1?=
 =?utf-8?B?Q05RZUZnNHZhQ3NpY2V0WkpNNFhRcDdiK1htRExFbmNPdUhoV1NGK1dOZlN2?=
 =?utf-8?B?TEx3aVhIekZQQVpHcWZPbDdDUVl3YmpIQW8rMC95ZW5iUUh4OU8yUjhQcWhL?=
 =?utf-8?B?SXF6SDk0b3pXdnFwYkJwUXZOSXdqQzY3bEhROUVmZTdWVnBWcWFUMnhmWU8v?=
 =?utf-8?B?d2daZjg1QUpaN0NvY2tvUE50eGdBNk1ZdDl3WlpidDFVSDFkcWdneW5uZU16?=
 =?utf-8?B?T2wxbDlTZW13NFBITCtxdDdIcDNwbnpaZ25mbHl3alhBYmVqd2NWa2RWdnVH?=
 =?utf-8?B?NHZuZ0dMcFRVVWxlRlJZT1BKaDhjK3ZpWjRFSC9kcGQvMTJ4b1Uva09JMExJ?=
 =?utf-8?B?MFBkY2hzU1pjQ3R1czJJRE82RG5jL2ZlQUh5YWozU2xFUUJ5ZWh2Qk8rUkVT?=
 =?utf-8?B?OGZhdmJTbk50WndpUjcrcnI1THRNTk5KeWg3ek1XblFvaG5qRDFrcDF1dElu?=
 =?utf-8?B?QmhSQU9pNEQxS1hHZ1lMcXFtV01ubk1XcjhPL3VVaVpVQUdOU2QvQmx1eHFO?=
 =?utf-8?B?enQ2WllUVGZGNjRUL2dsMUkxZDFiQmhZK0NOYmdaRFVudE5RNk5LVHZHTnNh?=
 =?utf-8?B?aVpCbUpqa083dmhXM0ZocWdMaEM3dUQxRTJhNVk0aDhWaDd5ZEpiYTN4Vlhr?=
 =?utf-8?B?RXgrbnpZd29wVjNYMkwyOWluQytaR3dGd0ZMTHg2Y0prTXdkcXBQWjBPemth?=
 =?utf-8?B?bTI3OEF1WERmUGlTVUJxbzNJRnAvUndTRGkzS0p2V3pkbEJLdmVPRCt0ejZM?=
 =?utf-8?B?ZThPWXYwcDJpOVFWWEtkcVBZaExtckZ2L29ZUXVTYkxUZ3VLYVdrUlhaSDVH?=
 =?utf-8?B?clIzN241VHh6M0xWR3phTCtmc2taR1pBeFZkTUlURmVEcE8vNi9GWmNvK0VT?=
 =?utf-8?B?NUhTUFFBSkFrUitRcFI3eWIxNkduTG5WUnU1eGNHam52MGIzVmRIdm10eEZU?=
 =?utf-8?B?WUs4UGExVXZFa3VTMTh1cHY4VC9PUHpqcnE4cXRtZTRxRXFnaFh6dGJMV213?=
 =?utf-8?Q?AajVh8POGl+KGdDMZErE3Hj4z6vAiYiZGW87g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkdNVmVGVjhGdXR4d0QxbkpQbkxMYmpUc3hNTWtLVHpIRCt2VVd1cTNuYlZU?=
 =?utf-8?B?c1FKVUlLaHZQMTd6aE5rNzFPdjM1ZldBeEtDMXBpckpjNW02QzZZUTJubVha?=
 =?utf-8?B?aDZYQzEvaEUrV3owa3lXTGR0b1l3Q2ZLRjVaZDRHMXp4NDVtNS9zbXNqZi9W?=
 =?utf-8?B?RG8wL05RdlFEQ0w4enBRaG1MZ29wUkZnU3lOTmM4OEowU1FZNUM1blB3dDZh?=
 =?utf-8?B?UWhaVlRoWk1FSTdKc080NVVIcnJwa3g3RVZUNXMvQ09zenQ3aTBENllEUDY2?=
 =?utf-8?B?YUR3WVp5OXcxcHhPL0x0UHRmYjFPdHlNRHAwYVBwK2JRT3ArLzFkUnJOSWMz?=
 =?utf-8?B?T2E3NnVsSXVzclhiVUZNWE1vN1BwaEg4VklacFpBV0hUaFFRakpwVTZVL0tr?=
 =?utf-8?B?MGlIQ2hjL0pqREQrVzNMMFdndHkreGtDK09rRlYwdTJkSmFESHZqSm1vMGF1?=
 =?utf-8?B?bmZFQ1ZwWFhlOGY1WVZnWVlBaVpZYWlxUC9OT09SdGNTL1o2U2hLNVpacXRM?=
 =?utf-8?B?dkJsbWhianpjZ0I3Y1o2UUxyRzNaOWZwM2dQUnB2NFlzUmRmT0wrbjhhbEFi?=
 =?utf-8?B?ZHhmMkNwSGpzMDk5VHlLSnpyREtoT1BPek9hVHEvSkJoRFk4NjNpR1Z3Vkk0?=
 =?utf-8?B?REFzbmFjZksra0wwbmkzYlIxem5DR0g4UnZBQ1g2bHBkeE1SMnlMWTFsejQy?=
 =?utf-8?B?RXQrVFpxMnFodXdCZk9DWFJtQVoxZlZ0YTN6RmJHOTZ1NncrODI1c2p2eWlh?=
 =?utf-8?B?VmFmNWdvWENjMzJhd3dIUWk2SVJVOWx4YmpaV1dpSERlczlkZGRRL3VOR3JQ?=
 =?utf-8?B?SkFzTzZNbk0rWHN0YlVLWHZrSGQ5S0Z6ejgyM094VnRvSVBRdTRzNGtvUTRu?=
 =?utf-8?B?WCtNRmRtY2lmajZWcFhFeWs2SDFJYUVxaXhVWGFpeWdrdHVYcFlRMHo1SWhj?=
 =?utf-8?B?N1cvZUg0V3hVcnErS2lEOSs0K2QweXRWd21aV3IzSlJkUU4yVnc0K1lESE9C?=
 =?utf-8?B?QW1XQ1R5bmlHUVRxWHZYd1ZOUkt2eVNldUpITHNMN3NEdHlld0lNWUhBVy85?=
 =?utf-8?B?UVdrbGR1bktSemRXRVV0U0I3c243V01OWmZKN0k4SXZ3bUN6QWxhdzJzbmpJ?=
 =?utf-8?B?MVEwRzM4NUxwWnpVYUdIUENZYU1BUHhGTUxsNHFkMU1GWjVwQWdRUm1ZbHkz?=
 =?utf-8?B?T21wMjFTUzdhTmxiSmw4NGYzVzR6RGErRnpEZk5LZUUyNkVBV3pqUk95TXdt?=
 =?utf-8?B?NTlmWnhCSG9XRnBlRXlUb09RTmVTM1FHcFFKU0hwMERDd2tMUmU4dFRSNWxW?=
 =?utf-8?B?a3lKT21BbmY0NVRnNWxxTUV3WTJXcE5yY2NpZlBKc1BXRGR1U003cllhV3gr?=
 =?utf-8?B?MjhTeWdvU3Y2RnhXd3VQUGlKemFWQjRPZXNQWVpMWWtaaWc4YjlBbXp1bng4?=
 =?utf-8?B?Z1RySm1jREd2SGdjLzZUWG5qK3RyWWg5VHZxSG9SdmI4a0tRR1VyWm1kYzl6?=
 =?utf-8?B?RFQ1OXNleWh2d0F4UzB3SVpEQmt3SktGL0drWnJUK0RWeTlNV3FUcHByejBi?=
 =?utf-8?B?MnV5UVcxZlZjOWE2WHAySktNWW5CVk9HbzE3RG5NcG5YbVlmdmw0N3VvWTg4?=
 =?utf-8?B?OW04QW1wbGhibjJwcXJhUFRVUm9YNmZ5Mk80bERMRWEvTmRjTWdhZ2JoZ0ph?=
 =?utf-8?B?S01XRDZ2c2dXYXpwKzIwcVZEUTMvRmJsQnJGNUlDY1hIODVUU0haVGdmNnBw?=
 =?utf-8?B?a0YrZUNPZDA1S3hNeld5QzNBQ0IvdE8ySVVHTjhCQjhiNElTdHZwN1lZOTFU?=
 =?utf-8?B?MXVlaXY0b3dZbk50ckk4NFFyclAyeXJwK3dKeDFScU1XSGtFbUZveldRUE0v?=
 =?utf-8?B?L2VkRWI2cCtYU05lNmtYSEdJcFJ5T21ZUlZzUVFiVG5HeHJvY2xUN3lvS3M0?=
 =?utf-8?B?YnFmU1BuclZ1a1JGcm1JOTdSSFkwd05DaWRISGd5alEwS3l1dDdyMlNnSXo2?=
 =?utf-8?B?emVjVWdvaERiSVl5b0tsT2tMdFppQTFiSWg5ZG5mbzB4cXVuTGpYVkFGN3RB?=
 =?utf-8?B?K3RYdUdDU3JUbDBDcWJBdEJXU28vV1l5QXJ0cG5XV3BRZEtEVHJsQTkrbFR6?=
 =?utf-8?B?U2VrY1phVnY3RHgvcWE4dFpwUWlWQWpYaFFEN2VlUzBWMS9oYjlHa29jWFBJ?=
 =?utf-8?Q?aiCWZYAjV+x4g5+ZDpyJKXs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a872e2c-e764-45cc-3d18-08ddc85a0923
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:25:18.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXRz16jZr1FldxbqQDg6A5RkVD5aM+sUE930zxaSUF4ucHkrigdxxtecSunZTa0PZ9e8HwxO4XNVSqkGF3VT4a8ophz8S8Tyssd6J5q0tmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF9A4BD32AB

On 2025-07-18 05:01, Dmitry Vyukov wrote:
> On Tue, 24 Jun 2025 at 11:17, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>> If an application registers rseq, and ever switches to another pkey
>>>> protection (such that the rseq becomes inaccessible), then any
>>>> context switch will cause failure in __rseq_handle_notify_resume()
>>>> attempting to read/write struct rseq and/or rseq_cs. Since context
>>>> switches are asynchronous and are outside of the application control
>>>> (not part of the restricted code scope), temporarily switch to
>>>> pkey value that allows access to the 0 (default) PKEY.
>>>>
>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>>> Cc: x86@kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>>>
>>> Dave, can you please ack this patch? Ingo said he was waiting for your
>>> review before taking this to -tip.
>>
>> Are there any remaining concerns with this series? If not, Thomas,
>> Ingo, can you please take this to -tip tree?
> 
> Gentle ping. What needs to happen for this series to be merged?

This series looks OK from my perspective. I think the last piece that
was missing was to get a review from Dave Hansen.

Dave ?

Thanks,

Mathieu

> 
> 
>>>> ---
>>>> Changes in v7:
>>>>   - Added Mathieu's Reviewed-by
>>>>
>>>> Changes in v6:
>>>>   - Added a comment to struct rseq with MPK rules
>>>>
>>>> Changes in v4:
>>>>   - Added Fixes tag
>>>>
>>>> Changes in v3:
>>>>   - simplify control flow to always enable access to 0 pkey
>>>>
>>>> Changes in v2:
>>>>   - fixed typos and reworded the comment
>>>> ---
>>>>   include/uapi/linux/rseq.h |  4 ++++
>>>>   kernel/rseq.c             | 11 +++++++++++
>>>>   2 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
>>>> index c233aae5eac90..019fd248cf749 100644
>>>> --- a/include/uapi/linux/rseq.h
>>>> +++ b/include/uapi/linux/rseq.h
>>>> @@ -58,6 +58,10 @@ struct rseq_cs {
>>>>    * contained within a single cache-line.
>>>>    *
>>>>    * A single struct rseq per thread is allowed.
>>>> + *
>>>> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
>>>> + * then the assigned pkey should either be accessible whenever these structs
>>>> + * are registered/installed, or they should be protected with pkey 0.
>>>>    */
>>>>   struct rseq {
>>>>          /*
>>>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>>>> index b7a1ec327e811..88fc8cb789b3b 100644
>>>> --- a/kernel/rseq.c
>>>> +++ b/kernel/rseq.c
>>>> @@ -10,6 +10,7 @@
>>>>
>>>>   #include <linux/sched.h>
>>>>   #include <linux/uaccess.h>
>>>> +#include <linux/pkeys.h>
>>>>   #include <linux/syscalls.h>
>>>>   #include <linux/rseq.h>
>>>>   #include <linux/types.h>
>>>> @@ -424,11 +425,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>>>>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>>>   {
>>>>          struct task_struct *t = current;
>>>> +       pkey_reg_t saved_pkey;
>>>>          int ret, sig;
>>>>
>>>>          if (unlikely(t->flags & PF_EXITING))
>>>>                  return;
>>>>
>>>> +       /*
>>>> +        * Enable access to the default (0) pkey in case the thread has
>>>> +        * currently disabled access to it and struct rseq/rseq_cs has
>>>> +        * 0 pkey assigned (the only supported value for now).
>>>> +        */
>>>> +       saved_pkey = enable_zero_pkey_val();
>>>> +
>>>>          /*
>>>>           * regs is NULL if and only if the caller is in a syscall path.  Skip
>>>>           * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
>>>> @@ -441,9 +450,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>>>>          }
>>>>          if (unlikely(rseq_update_cpu_node_id(t)))
>>>>                  goto error;
>>>> +       write_pkey_val(saved_pkey);
>>>>          return;
>>>>
>>>>   error:
>>>> +       write_pkey_val(saved_pkey);
>>>>          sig = ksig ? ksig->sig : 0;
>>>>          force_sigsegv(sig);
>>>>   }
>>>> --
>>>> 2.49.0.1143.g0be31eac6b-goog
>>>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

