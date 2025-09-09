Return-Path: <linux-kernel+bounces-808493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD2AB50082
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67392360903
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AA322DB4;
	Tue,  9 Sep 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="k476o9i+"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020136.outbound.protection.outlook.com [52.101.191.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C92191493
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430072; cv=fail; b=F8eaIxwJgefPVHK2sNNYPBfcgncH6f4tYADL+SROkXKWSt15QVDJr9idwlccFWYpC7a1uwpVZep5QJk/LZ8r9TTCGBiJxNmRc0meS8qn+fzJU384pbzAdG+B3K3POLN9JtIKqAa0fC0VA3HOz/BMrt2s7zxpSlQpoFAA67nxbj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430072; c=relaxed/simple;
	bh=ELTZmge6SRAo9RdyiDgNjId8U3tQlqSN7hLYdKTSo2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tkHyAJ7NRGXdSRRfrMSLRJ24tmH1+HLJT2DehZAYC3DEqtESZoqbYFQVS6I55GQRN9K6lK/vYB+tRD2Pb0RH4u/QO0cgmFId119KhfhkJjlqTtbZL8jpQLJHGMhMDOzhzSfbskZbkZ98K5t/5bNA4NfHA1BiAD/x6T9mrTCVHbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=k476o9i+; arc=fail smtp.client-ip=52.101.191.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aosn2lsOW1G+jq0Xi9RQwJWgPf9P6UweU3yqkSgiwQoyHE/HLZsxe8wKPf+ZVQrt+LL6W45EKZ2tMlpsFRoSCqJewjtJuh10Nz27p0nlugxulWbLrsB9KjE9YtfxaSiLP30qFSMxvxJs3r+X/325tsHuEs/z5Qho1OVpPrnuOAxQFCCUzESbSCxZjNyYM4iC8YwsxzpHDqcbHOYeZeRqKD0KV9V/ofJT2GM9DQ9DQFCnv7vePrriv7589baHqNS6YIWyJXJnU7GZkNmirhHi//49FRkCyngiSkVYRW9EtyuWNedy8K8a8xlni0tdMGnhSzZQJTOLCJENayJRZMXEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MAGpHNc20V7rAoMOWdg320KwwKgxaDc4/bBxwPV9so=;
 b=Gvrhp4b+u37MNf6GOt4JsoVGwEjmcxrF23yHTLRzpIYSXJgD9iCiw9HjVde0DxIoYheYhFfEh3Xxzb4H+FgnAF9G5cIcHKThdUUKnox9L5aXjFNBz8H6G9sCdDZ2D/tJVLfSc2SsYlAufuUW0un0h76NcQ0U+Iv7xjVa4IX2KBgkhc5ZTad0afBkJBCZFkTW2F3A96m6yOOSizGLtTIA1nc3/yQIU9IYdcokOEtkWEABhqqj7sBhout+yvsqNTbZuGvbIRHcbKHlekdE+gbP2cO9Vt316PnteffMDiTaq06KZTJ+SlEWAX+7q937SFt+VsilQL0v7lviyiGhE+Xwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MAGpHNc20V7rAoMOWdg320KwwKgxaDc4/bBxwPV9so=;
 b=k476o9i+A8geK3W6dvGFySwRDo2HCKfUvxg1fHRa85SqxHhHceXQwxvQAgC0HGa2DjhF7+4UwDqn0KB5suLWwcC5DG7AipnSLn4mW2S6WoKeauPVq4ye9YY0DoAch1901wYeqqsihz5S0Hacdzk150xt3NF76sGajHGjifvFE0QrMfe4ZaeGsm/vv4aQc48RRQCrVLDQiXQ+YASY86c2SnRqD+VB50ZvI/p9fpEvkJoz8hkuJ+HYAbLNLYqN3bwaNf00YCsfHpqFy/3XoRvS+k3qe7xLMH3pzMu64rdzz4qUGx1nHQPI4hutLSyLKKMmZdr4JBGgUcy64MasXD13lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9586.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:01:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:01:06 +0000
Message-ID: <61366e2d-b323-4127-8347-7222fb661670@efficios.com>
Date: Tue, 9 Sep 2025 11:01:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 14/36] rseq: Cache CPU ID and MM CID values
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
 <20250908212926.161186107@linutronix.de>
 <ac375e1e-87a6-43ab-8f2c-7d9ab4f2f34d@efficios.com> <87h5xbvhmd.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87h5xbvhmd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d0516e-10f1-4341-d9ee-08ddefb1b3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUcrQ2x3Tk1xQ3YzQnlTV09sWlFOSXFiODZ4RzZramtTT09jM2VDeGRzTk5M?=
 =?utf-8?B?c2pCVDd1b1ZkM0JVcXBHcFRJVjZXMUNjZ1lpekIxSWo0ZkFlV3dDWmk3aG54?=
 =?utf-8?B?RUJmNmZsY3k5bDB6MzZYZzZRejZOaVJVNkd2QklrVDZ6NytJL1JmeTI1eVQ2?=
 =?utf-8?B?WXoyUXo2eFhXb09lZHB0RXZVbzJQeXVFK1Z1SkR6T2QvVHpwbE9ncEY2eDBW?=
 =?utf-8?B?Vk5YOUxuM0JySVZFTWtmenQ2QUszdWxFSVlKYTVaV3pPeDBsV0NDb0tmZWsx?=
 =?utf-8?B?QWlwOGEydHN4bm1QelJvN3plak5NSG1WcUVqSGxZbDBWeVV3bngySU1zTmRI?=
 =?utf-8?B?dFB2ZVNWRi9RVFVaZHRiQXM1UTl2eVpSaFJOQVFSNUg1MU90ejk1RGVSUjhw?=
 =?utf-8?B?L0oxSzFEeVhVUjBQRSszOVdqYmhGRDdyOUZhRGZJVis5QVp4SHp0UGtJU1Rh?=
 =?utf-8?B?WkM2bVFoQTZ4eDNUL1labWJsUjZ4anhadWZjdGxvbW9NZ242NXhXZFl5a0lT?=
 =?utf-8?B?WlFCanNhTkxFc0pCblpUUXR0Tm03dFZ5M1VtTmdTR1hYVUQ0ZmJKOUk3TGVt?=
 =?utf-8?B?YnRWbHhjUC9Ea3hoaENzNDRiL203Umhsdk9FYSszQ3gwZVorUXJBZFBoRkRi?=
 =?utf-8?B?L3pTcC80cXg1dDlqRXdHdzJiSytLUUN1N29uZTBOR2lscnRsT2xWdSs1SEZZ?=
 =?utf-8?B?eVB1eHZ5eWhIWlU2NzNQUDd2bUxTa2hOMVl3aU1IVGNnTHRVRkE3TU0rQUJn?=
 =?utf-8?B?L2M1L08zL2NKbElpRUpqL3dyelcxS2dja3RVQ1RwanRTYnMzcXljanVqUitr?=
 =?utf-8?B?OVZrRExBdlBGRWQ4UlZsaVBwYytHZ3FZNUU2ZkxZcnBpN0k0U05jcDBJSEVY?=
 =?utf-8?B?OW1HYjlvUmdOTTlOZEszdDJPNjBjcHJkRlJveEtCVWdjVlZtb1dzbTBzZk1s?=
 =?utf-8?B?citGZnd4cTVmWC84S3VjTm5jS0UvZVNGdlRlWGwyZTVWUG9KY1JxN09WWTVj?=
 =?utf-8?B?R1NSMzd1WVhNclBYOUlCajVOalBqN0taelZqZUJQL0pBYlE1bGFIU2pmZGZ6?=
 =?utf-8?B?bU1HMkNyYVI0eUR6dXd2UzQxZUlqRnlvczJYYi9QaXBHUTh5VVpwYTZ6c0lN?=
 =?utf-8?B?NzNmOVNPd0thbnUzUFlKVEhBN2F6b0k2Z3RmWFlLSHU4VjdiMXA5aG9lZFBS?=
 =?utf-8?B?aUR6Q1FkMzBCVWJoZGdqaXZ0ZGxZbWdxYnA3MGczV0NIaDhFWFZTS2ZoWDFE?=
 =?utf-8?B?MGRXTTZQWnp0eE1HZ2lVVi9JOGJjNmRRV09QY0h0MTI3OVp3amJQamsxbmc0?=
 =?utf-8?B?L0V5aGx1SndmV0J1L1BnQ2M2SFZ2aUVtYURibE4wbGhGTzVMYldveXY0bXVq?=
 =?utf-8?B?MXFkRkVNNDRhbUdIVTNmWjJPajFmSzByQ2dqSExqdTdIUmlxZUtjakViRkpo?=
 =?utf-8?B?ekhVVFRVRTU2THI5V1J6RDRhUGMyNG5Qa2ZBdnEvaVF5VVJ4SXhwTWhqOTdY?=
 =?utf-8?B?c0drZjhGLzI0bmV0azlxMzFZRlNPR2I3Z0dqd09Ydno0VmxoUVBUTlNRUEJn?=
 =?utf-8?B?VzQ0ajlDNTByb281T0p5a0VTdGQwQVdYcGYwUTJSQzFESDgzNEl2cGxzYnNG?=
 =?utf-8?B?TDhTNStRb0ZwbTNjTWhrZVVnSE4yK3YyLy8zdkhxeTV5QXF3QWcyditNTXg0?=
 =?utf-8?B?SE40WlphVE1TdVZqM3Rtc2ZINDVLMndkTjUxZ2ZqbERsOEtBMlVaU2JOY1NH?=
 =?utf-8?B?ZDQ0RkYvb3RjejlsSzI3RFprc2x0OE9YNG9wb2xQa3o2ZzhTN1ZRZTlsWTFN?=
 =?utf-8?Q?vinvQpCZlT5E0D6znphqcdvWwdsVhfGDOeJTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b01JTnVidkhyVUZTb2taU0RRNWFXTkxlbURobmw1NkFOUHpiUStSTGRmZVVD?=
 =?utf-8?B?bHBneEhuSk56Qi95ZlNaZy9jVHFFQ2xrSTUzQWFNQkpZQW5YWSsyVlhRV3hP?=
 =?utf-8?B?cjg5UjZnZVljWXRiQzBVS1JUWVliL0p4a1c3dHdFZTR2SHZYUytUWEdydVNw?=
 =?utf-8?B?UVdNSWxYZ0t5T2RVc3c5ZDd5RlM2WVI0ZXhWdU8yRXVsZ1VibWFkbXp2QkJl?=
 =?utf-8?B?TU9vcCtpTzhpZGNUMnlubGVRcWY5QUlad3lINDdkcEhMMyswN3pDU1plaU00?=
 =?utf-8?B?dHZHMWU3OVEvVC9ZeWc4MXp0VFIzd1pMclBXTU9YaU5sRm5NaGtrVjBtS2I3?=
 =?utf-8?B?cFdTUFROeTFOVjc1blYxbWtrWjBkdUdITVQ4aDVuU1lmSkJmTmxMbGE1anpm?=
 =?utf-8?B?TUFqYWlTNnBCeDB2eElmZXRWNUFrMlZlQk12OHZDbklmcmFxRkZkckxmOWs0?=
 =?utf-8?B?SFpYN3ZFQzJBcERNd2hKZG9hVXBRVFhRdVRtTEJLay9KRTlQdXV5NkQ1MmND?=
 =?utf-8?B?bWdZUmQvK2Q3RHdtU25UQmIxazB1cDlmTU03ckI1SmZHdTUzcmN1cWxaRXg5?=
 =?utf-8?B?OTRKeE92QkRoQ2tNMlh0cGd5cWlOOUhlUW0rWTUzK3dOQmJ2YmJVbFk3R21V?=
 =?utf-8?B?NXdRNm1kSW5jVnFVcTdOcHozMDJDU1krbVFkb2lxWVV0cHduSUZubWRmN21t?=
 =?utf-8?B?c2VFL2tJSWpyc0lncWUyS2FzeWRLN3ltdUk0WWlmNE12SXRYcm9lWkt6TkVN?=
 =?utf-8?B?czdIOGptc21lam1VaE5MTkxYM2cwQWQ5UXlaTXArbTdqOERrYWtHam5nbkxy?=
 =?utf-8?B?azZMNnFRcEdWbU1aRVdjU0R3dWdJRnpJQUoyNkNoTlNmWk9NQ1RGSEU0Z01W?=
 =?utf-8?B?bTYzQi9Gb0dCTFRMY3AyV0hqRTJNVGErT2xqSVNFZ1lQeTNIOUFQa1NaM0hy?=
 =?utf-8?B?alNCVHZGZ0JsK253MndiQXBvSHY0Ym9Nand2U2p1TWdHVDRkVTJnTHlweTlX?=
 =?utf-8?B?SVB0UldDd2dwMUYxdjMrUkZVUjZUZWJLUGVwRVpyWDROYllPVHVDU3FWZ2s4?=
 =?utf-8?B?Q3lYckdCYkZDRDZ5REpqcXNGOXg0R0FQMHVPRUgrU3hsSDBmd0VYc2FJTEZ0?=
 =?utf-8?B?ZWhmQks2eVNvMXo2K0tZTFFCdVdkaisydFVFSGdjT3lBRHUxNWZsTGhORUw5?=
 =?utf-8?B?V2IzbVNxYm1JV2VMWG1mWFR4dFR1RkY2UjdjZEdyRGhhOHY3R1I5N3dSeURP?=
 =?utf-8?B?MXdPZ3ZhMDJpQUM5NTlXQ0NOckI1QXcvYXlORksrdUcvSU5qeERIdGpocFVE?=
 =?utf-8?B?TUZ5aVBTV2VEN3FKNlRidjhHbE9Jb0hCQ0RzMHpPc2JneXpWVmVNS3NaV3Rl?=
 =?utf-8?B?Ty9HVkgyamY1enFkdnU1Ykt3d2VLVkVicnpRenpZRzNoOU8zOEVheGphUy9O?=
 =?utf-8?B?ZWdOWXlPQ3c0eitzaElBTGR3MVczamloZ01iNkZCVHJhYTZVT0x1by9XZ1hp?=
 =?utf-8?B?UGhvS2hPRnFGQ0k4WmFGejcrdDFlb1lJanRuMkpKWjdUbzhtTEQyL29XazVY?=
 =?utf-8?B?SnlvR2xvaDY5UkUwNTBjUENJV0NpSjJOdDhCUURBTHlKSEM3eUpmNmVwaitH?=
 =?utf-8?B?bkdnekZVYXB5aEh4NmFOTWtvelE3NGp6ZzF0SGtMd0FnRUVRcFVrY1FtVEJO?=
 =?utf-8?B?ckZORGF1UnplVko0V1BVTDRaVDRGNkxsdSs3UmRnSDcvVmRFYmVTN25RTG5w?=
 =?utf-8?B?dWkwcjg1OHhqazBwTTdUd2VNZ1JTNmxKdHpWRnYxMWxrY2pvLzdqNTViR1BM?=
 =?utf-8?B?N0NRc3JFREhGdDZLMWRXNWFOTnovWFVzKzJKRy9jeHZwZ1c0VTlxTGErcFhi?=
 =?utf-8?B?MVFNeHdsSGk2U2ZmRjRTbFd0YzZMRGlaR1NYR2hqaktzSU9FbWw0U0lXSmUz?=
 =?utf-8?B?dm5vcEtsUFVTTkFzOWFnZ282aVcwM3dFbDByclR3VlUyRFVWZGFXRFBtZkt4?=
 =?utf-8?B?REFqTVVLck1tZU5wRmRaRXRLSUR1TVRmK3MxN0hEamYvNFIzSGdKeXZ6Tm1a?=
 =?utf-8?B?ZEUrYXFnMDkvM3M0N0wrRGJ1MDNwcXJVTGZobmVoQThIMWVJY2xEbVZUakVn?=
 =?utf-8?B?SG84ZDNOUzlSdEJQdFY4YzV0MEhGRTVTVno3d0JiT3cwR2RlT0h5a1VuazR1?=
 =?utf-8?Q?EfEqfbqpvb+eP6l3Il91oxI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d0516e-10f1-4341-d9ee-08ddefb1b3fc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:01:06.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxswVhgSHeIrgXVlsYmF44rj8pw3cqMsylC0cj+9GTv5G/jSOJOrhWeqx+2QhatKijgQgrn6pp09EkrCSK57Ticlric2jXyk9jFPTxB4Xl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9586

On 2025-09-09 10:13, Thomas Gleixner wrote:
> On Tue, Sep 09 2025 at 09:43, Mathieu Desnoyers wrote:
>> On 2025-09-08 17:31, Thomas Gleixner wrote:
>>>    /**
>>> + * struct rseq_ids - Cache for ids, which need to be updated
>>
>> need -> needs
> 
> ids is plural, so 'need' is correct, no?

It's the cache that needs to be updated (cache for ids). So
technically the verb conjugates with "cache" (singular) and not
"ids".

> 
>>> + * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
>>> + *		compiler emit a single compare on 64-bit
>>> + * @cpu_id:	The CPU ID which was written last to user space
>>> + * @mm_cid:	The MM CID which was written last to user space
>>> + *
>>> + * @cpu_id and @mm_cid are updated when the data is written to user space.
>>> + */
>>> +struct rseq_ids {
>>> +	union {
>>> +		u64		cpu_cid;
>>> +		struct {
>>> +			u32	cpu_id;
>>> +			u32	mm_cid;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +/**
>>>     * struct rseq_data - Storage for all rseq related data
>>>     * @usrptr:	Pointer to the registered user space RSEQ memory
>>>     * @len:	Length of the RSEQ region
>>>     * @sig:	Signature of critial section abort IPs
>>>     * @event:	Storage for event management
>>> + * @ids:	Storage for cached CPU ID and MM CID
>>
>> It's far from clear from the diff, but is there a missing space at the
>> beginning of the line above ?
> 
> No. The actual diff is:
> 
>    * @event:	Storage for event management
> + * @ids:	Storage for cached CPU ID and MM CID
>    */
> 
> It's just the reply quoting which makes it ugly.

Sounds good.

Thanks,

Mathieu

> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

