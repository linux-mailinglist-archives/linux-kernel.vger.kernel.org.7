Return-Path: <linux-kernel+bounces-777930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17987B2DF59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ED04E7A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11FB275AFF;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B+ldflq8"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2136.outbound.protection.outlook.com [40.107.115.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2D224AFC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699884; cv=fail; b=mAcNadtAGSnsAgnrmEvb5h3Zztl6VQLzthyhPKgDz7f763F4QvWYw+IfPtu1VEyNUOFVObwMtSzQAbwENNY9RU43pNPo70yCHQ2lJLzv20qC/cXQCUPL7yneMPlJ7fICh0tancSmwCKjvWqfS3xHGzRFR5CNXMoDmr+gXTUB52E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699884; c=relaxed/simple;
	bh=RaH9/lbOvzB2rwFHS3N8Cz2FhJSuaHBBmC3tfbAbkLk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oM0MuLZfgdDlme4PfD9bajfwlSnBSjVMlU4tlVqoS21D0u/xz1pQAf9z0dgDwjHh9x4Oi4mErLp4C1nHo46j+pMfdcQsAkvuMGkd1GOjNos6uaGIX2sGgSbzFmtIIW4Al5ysldkYyOTHGvg2iWXyDAHXu283Er6HwuesKSp1B08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B+ldflq8; arc=fail smtp.client-ip=40.107.115.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEMOcEJG/AsETtqYWh+P5SfEqvYRDMdd+nWnCC5G9/vgecG6K5cZnGax2s+HdtaUXpc5paU5Dh1tJRdgMc7BIeqd0k5M/es3uFNnzmPqBqgB8Y914lUfKW4G33XXt8N1Qze2Agu/eV3umykWfY71qEWbVTY9i5atpJfA3xadT3f5Csb2823vSaByHGkCl9AnTQF7bM5RSParXPe3O+bz58C2K5sFWey0N/ZVVJQ/Z7RJM2l8nWikIGr9DNlVt4zybnSWbmx7ST5VeUBMh3tGWYHepcY4RL2MzfhQhUaRvAQYzpUMMDlxFZ9mLj9s8UnJ1OfJqqYGdfBdOzCOmbCzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e/aAAlSyl7BTYjNnFxJ7AGPHBKAaLevqOuAwj/SHrg=;
 b=oknq9w+Xna6rJ2aStjLEKm+B4GgS7NwJ6S0sdDlTLN3WbLiVDjkB4aNk420TmLCH0SavvNtMu368MxljgAKJkDtBxEljtToLIkFVDQvwa9vo9TlGu+qT75Bo+CjmD+SVQYXSgfeCFfdCKiS18bG6GMHtWw57d4Qyc2vLzdobIXkcsh1ZML1Zsjs0fGM+ZAXQclWXVr8iAQWKJ1xto7u81WT+BD0zGREFXYv//2Pj3c6DXm78/GlX5NpQolLub6mnspkRf6pVIrVjL8zRrFyHdvxTfPZJ4+giZNMQL5dE3ejSaR5fu/uUZ1BOTpO7VU6EOYZfhIZBmUe5OFFZQJC+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e/aAAlSyl7BTYjNnFxJ7AGPHBKAaLevqOuAwj/SHrg=;
 b=B+ldflq88As7yUGI0Ub+UtCOLaiFQQsECQS2NB6+9U4VJTIkm/u5LpqiuwBwFBZoAjMn9NxigAqkIcdrn9MXk9m2yZlvXGdJKCMSRQ/C9KYkZYjp5xL8yvz3vBiXhQxeY93L6Wi7SE39D5auK1L2TFyza7qvSwSkTAjwDNpu9GdBa8fCEX4wX/JtDYkKf6MZKwLFoH3iJD1RN1HTXmZg5oN6Khed7BIpykRad+Ucv9bnX+LVGPDL9cbBFgerlUvR5vhpzFJrv1+Aal0w1fXUvJLq3CLv/DLDPYGagq5Vhv+yMhe28fpYlYXzd98iou1map6KGbK+1LMOdskGTHWIIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF6D21D4F3B.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::549) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:24:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 14:24:32 +0000
Message-ID: <61551e6e-fc51-4b1f-b2a2-2014a7d37901@efficios.com>
Date: Wed, 20 Aug 2025 10:24:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/11] rseq: Condense the inline stubs
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20250813155941.014821755@linutronix.de>
 <20250813162823.909295085@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250813162823.909295085@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF6D21D4F3B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af8f18e-8a65-4113-b80a-08dddff54800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9JMkhubCswL2xpQVlGK3J6RXhERFZ5ZlVDS1dUMjlvUEhndkNwWTEvaU1G?=
 =?utf-8?B?REhtREx0L29JVytNUkg5eWtPdUJ0elR0djRjQmhsd0x6NUdSVzIxSnFJU1Q1?=
 =?utf-8?B?WElRcHBEOVJBWm1CdkxscjUzcGxCQTJIdGRYNzhhVUt5OUN6QVYxRVgzRDVU?=
 =?utf-8?B?ZzlOQWxDOW5NZkhCL0J2anh1a3g1THl0U01sY3dKbU0xS3NhaGk0bzM1YnE4?=
 =?utf-8?B?dmhrS3NoSFBDM0NpdjdHdVpmQVVQWmlRaWRFMUV6Z0RZQ01lQXd1SkZ5MmJ2?=
 =?utf-8?B?Y3MwRFhjTFJXbTdKNUE3NU5EanZyK2pjK3NSOVQ1RmF2MktqRUltaXEzRDZT?=
 =?utf-8?B?MEUybVhmREd4NmdHT0NoRVVvbWp2ZWtqdlYzcldiNVNvRmpid3RrZHdUMTVQ?=
 =?utf-8?B?Y2lsTWxETkZ1Unp1cUhyUWtzWjlLcDhlUE9lTU91TStMcnJJRUkrR2tDN0JX?=
 =?utf-8?B?OVk4VHJMd0dpb3o2dDdLcUh1VkVtcWNMbVZnOVJKM24xSTNDVTNSVHBDYU44?=
 =?utf-8?B?M3dmUWZvRmgyNnl5LzZJa1lPeXJZcFZYV0JvNEQxeXNZWHE1Y2NPdlJsYXRl?=
 =?utf-8?B?R3hrSnhYcDFaTk40MjlPTVVCck8rT3pkUks4aEVYMkFSd0lEbTUzc25TcWo5?=
 =?utf-8?B?a1dJSzJEYzVHdkVadGpaUkxiWXBzMXNBdXVPTVcrQ0JsUTNTVWZybUE0bGsr?=
 =?utf-8?B?SGRiK00yZGhLc2x5aGhsK2tPWDBraXhNSEEwbEZyakFIRiszZkUxazAzdmtI?=
 =?utf-8?B?RzMzV2tyb2tpZHMyaHJKUHd2M083d2RHTGpjSkhHcDZxcFh6c0xIeEMxQ0V2?=
 =?utf-8?B?Um5acHgzN3Bud09PT0ZZZmwvZFplSTU3QmFxQXlUeWc5VXpvTmhqcEQ3alNM?=
 =?utf-8?B?TUJEUElKV2lSc1d3MkZFVWNvZHpLZWpUWVJYNGRoMkkyN3hIMFNiZ3VTTG5x?=
 =?utf-8?B?MjBqSEZpUFBQN0Myc3Y2QU1wVEgrZWljUTk4SnovbHArOW1kdjY2U1NoeVc2?=
 =?utf-8?B?ODJOMi8zaFRSL3JJZmR6QXgva3pQUklPS3ozZkFCOVlBaWphVTYzRVhiRkVN?=
 =?utf-8?B?SUZDZENZVWR4MlBYMy9aZis5b0tsa2dmK004WXhkRkEwQy95ZXRYamcvdGp6?=
 =?utf-8?B?YjJpb2puN2JzMVBxcVZXSmpjYytyREZTMWM2OUorVGZZUEtZcGxNVWxhRmhO?=
 =?utf-8?B?QmdsczZITHU3RHdIRGtHK2FNa01aTzhJdExjcXZMZEJjbmRXWlZ3YmhYWEVK?=
 =?utf-8?B?bWlINU5rc0U1dEkzcm51M2MzdnFkdENsdTlZemdtbXlFUllhS1ZDOG1KNVBi?=
 =?utf-8?B?cGs0eUxCb0dIcGsveUFjYzhmS2ZRQ0haNWFDTFdtQ0xjdmRVbUtvc2FINlo5?=
 =?utf-8?B?OGkzTXpHVndvaHM3VVNDbHA4T01rQVd4Qll5M0x6RHFibElEUGx4ekdVV1Ay?=
 =?utf-8?B?S3lCanJDRWJzajg0WUxBL05QZW9TNHkxWDg1c3h0TGZIRDZmNnNTTWJlU0d2?=
 =?utf-8?B?dm9aUG1kVnBwODF6Yjd0Nmh1ODEyTUNNWmg1bEFiWWtOczBFSXp5WlE0dDdD?=
 =?utf-8?B?akd4MEpWR3pseVZTNjVhSUlZc2MxY1pHUHA4WmozSEFyQUlBcUs5UktlQmJj?=
 =?utf-8?B?WW50d0xYdEpPWG1EaEZXM1hlMjJtYkEwM3J0YjA0R0J6aHNrd1I0SEJYYmNK?=
 =?utf-8?B?QlpmZ0ljQzRvdmNBRVptOUcrV3hjZ0JBdkRBNTN4SnFQZDREaEd1MVNLRXUx?=
 =?utf-8?B?cExDcVBYZ3B4Y3JCSzIrQWkwYmczYlg4MFcrbmdnM2g1aThIOThIT1EyeHhi?=
 =?utf-8?Q?LYhvB7BAAmC+h1qEKOHKD5GTPEOX32RDH/4zQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFYb0laSnZxM0xFSXNZaDBwMVlvOHMybG5oemUvNndZaE5sLzhZWmMyUW1G?=
 =?utf-8?B?a3kwaHYydCs0MXJwdDZpd0pzejlqRW5EUFkreWgvQjNINW9aY1AzTnYwTW4z?=
 =?utf-8?B?VFBxN3FiTi9ZRWZpdi9ORUZJTE9zSmJ2eG1rcmRtV3VCdjlLZjNOS2RuOWQw?=
 =?utf-8?B?OWl6ZGVGTDd6YlRRTW9MbGdBN2tuaVRHb0lFQ3lPWFJ1Y2lHKzA3dVNGRHFP?=
 =?utf-8?B?dFB1Qlk3eUkrYVZYQnVDaytGdFJWL1dhN0JMbG9uWXNkMEZ3L2c2ZXBWdFBp?=
 =?utf-8?B?VWFMbTRld0tCL1E4RU00Sk9nTnM4aWxQRFNlSVBQK05ubmY3a1NReEhwdUc4?=
 =?utf-8?B?akRyRkV6UUV3a1BMajRwWXN4cWpZUkhnQ2ZSM1VPbUlqNUNhTm02b2ROcFNp?=
 =?utf-8?B?ZlFtbDRaUzRCUWNaR09Ncy9iV2VCOS8xSXY3UG53Ky9ENGI0V1hrWU03d3lw?=
 =?utf-8?B?WXg0VDNKVDhwbmlOTVZ0c3hmalFSUThoRkdZeHFHZCtwTmFhNWZmR2l0SGxR?=
 =?utf-8?B?QWJJaFBYd1orcERYQ3phMi9waXpKcHhrZFgyUUc3b1EvZWpXN0hxMzI4K0lh?=
 =?utf-8?B?d20rc2dsU09FdGdnQ1RURjVoeG9VZElXczBqWFdtd0ZoQ0dXbGJyYTVua05a?=
 =?utf-8?B?NzdmWlV3cDd6MStQSEI3UXRySEFQSm5oeGpKWUxlZCtqTGM1OHk0TTdpclJv?=
 =?utf-8?B?bzE3VWoxeVlQUm9lQUN4a0llaS9OQUlVT1dodWljejBKUDEzdW9Vam9rd3hB?=
 =?utf-8?B?cUl0Y1Vrc0xld2ZlTlZ1aXlhNjlYTk5QTzVwclovRWtVVVVPdEh0dFRzWjBs?=
 =?utf-8?B?Z2JvdXUvSG1aNW5NYmVxVmh1cGtWTElWNDIyS0xZV2c3dGlVcjl5NWxvWFdk?=
 =?utf-8?B?RXNnKzRMZUtUNEhucTREc1g2MFFRSGp5SG0yZTUrUkV1L3VkWjE5K3NUSnNh?=
 =?utf-8?B?RHdIb0V0OWhEOWlrWTFKU3VWcXRvZnBqcURPaWdhVWZvZDJOY3NXYzlUa3JM?=
 =?utf-8?B?N0lpTDliajNSZ21DNDRySWJlODB5RU9zc1NBTGI3SGUyUW0wYm12VmpqVXBJ?=
 =?utf-8?B?dXJ3bDRRQW93bWZDa1h2OGZ1NGZjMm9vZ3JVcU9EVVc4RkI0MSt5OG0wQnBs?=
 =?utf-8?B?NHdjOVZQSHdMaGJIcVdLN1RhdExEMTN0RUYzMW45NVFleW53aFhMVnBWM1ZN?=
 =?utf-8?B?ZHl2UlZYUWt5TXJPUTR0S1ppNW5NYkFzWlhIelFCeGlyV3RFMVBtald1WUJQ?=
 =?utf-8?B?dS9UdGNFQy9na21DSElER2FyekpVSDJHNjREaG5TUVBuUjdIK3o1ck5MWkt6?=
 =?utf-8?B?dnZLaFBBNVFVc3F6TmFNZlp6RDREYlIvWm9sVndLc0VSNGpzL0ZQNERxSEVH?=
 =?utf-8?B?YkJXeUZyTHBYcUdwWWo2cmY2R1pwTVc4U01pYnc2eEJKb1Q5QmtnU0JSdXBz?=
 =?utf-8?B?eGJ4YldLbVJTaS9FUGw2S1VJekk0VTBpRElKeWN3U1grOU5tRFVkb0VtbkQ1?=
 =?utf-8?B?SEZwemFWNXVhTk9pZXRyajBmMlBER1JoZ253M3RkNVc2N25QV09CbzR2NmEr?=
 =?utf-8?B?RWMxM29oUmJVM2xGQzNwbXJqc0Qyc0RMNjUrUFo3N0FRVmdWblZRZVZObGJB?=
 =?utf-8?B?WlovUnhOT0ZvSUtETDdHY1J1UStRak00TzlPNk1Md243UkNkY25pVFVTbGl0?=
 =?utf-8?B?WXJVU0o0ZjRzMnArdGVsT3hEbTNDck9Wci9SUVRndVZQdnJEb3dGTkxNQ0Ft?=
 =?utf-8?B?UnFjWmFJSXl3bTdRWTN0T1VITFMrTXBhN0NmdVN1L3BPdEh1VXZLUngxOGE3?=
 =?utf-8?B?d2NhN3loRUZRZlBxeFN0N0hnK2IvcGt1bllXVktVSUk4NWtVaWZoN1FST3dJ?=
 =?utf-8?B?ZXRoTzZtWjI4TWFaeGl4WURUMmhVQXBYbGt5UnVpZGxIMEJwSVdoYXlNZjRF?=
 =?utf-8?B?Q3N5b3c4UGRaSHFwSWI0VVdHOXh4bE1Oei84Q2wzTmJYd1QvVk5PaU1raHhY?=
 =?utf-8?B?LzRFK2xNdHVtK0lFZ3kzNmhMM1ZoUGtzSmxTNE5GM1ljUjB5Um9TNnNsQzJG?=
 =?utf-8?B?M0VDNE1QVG1CZ1J2S0p1MW9kaDFQOFA3c0hNQ0dzMDNUMGR2Vit6MXh6bmlT?=
 =?utf-8?B?WE4xR3Z3RXRiR2c1TFBMQmc5QXJUNm5KTU1ubUJaM2RlclY3K0tLcThYMWtX?=
 =?utf-8?Q?KSeDYkbLIBiXmCnxKm05d10=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af8f18e-8a65-4113-b80a-08dddff54800
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:24:32.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RdZ46Mn3PZfvjHlAMwvxLGI/ujxprBOrLHOHpsA6plqzujMYGwH84Y5od0gLP05rTvGwheVjGValt0tyrqMT9PEJyy86/7jnXx1WEoxRng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF6D21D4F3B

On 2025-08-13 12:29, Thomas Gleixner wrote:
> Scrolling over tons of pointless
> 
> {
> }
> 
> lines to find the actual code is annoying at best.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/rseq.h |   47 ++++++++++++-----------------------------------
>   1 file changed, 12 insertions(+), 35 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -101,44 +101,21 @@ static inline void rseq_execve(struct ta
>   	t->rseq_event_mask = 0;
>   }
>   
> -#else
> -
> -static inline void rseq_set_notify_resume(struct task_struct *t)
> -{
> -}
> -static inline void rseq_handle_notify_resume(struct ksignal *ksig,
> -					     struct pt_regs *regs)
> -{
> -}
> -static inline void rseq_signal_deliver(struct ksignal *ksig,
> -				       struct pt_regs *regs)
> -{
> -}
> -static inline void rseq_preempt(struct task_struct *t)
> -{
> -}
> -static inline void rseq_migrate(struct task_struct *t)
> -{
> -}
> -static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
> -{
> -}
> -static inline void rseq_execve(struct task_struct *t)
> -{
> -}
> +#else /* CONFIG_RSEQ */
> +static inline void rseq_set_notify_resume(struct task_struct *t) { }
> +static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
> +static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
> +static inline void rseq_preempt(struct task_struct *t) { }
> +static inline void rseq_migrate(struct task_struct *t) { }
> +static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
> +static inline void rseq_execve(struct task_struct *t) { }
>   static inline void rseq_exit_to_user_mode(void) { }
> -#endif
> +#endif  /* !CONFIG_RSEQ */
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> -
>   void rseq_syscall(struct pt_regs *regs);
> -
> -#else
> -
> -static inline void rseq_syscall(struct pt_regs *regs)
> -{
> -}
> -
> -#endif
> +#else /* CONFIG_DEBUG_RSEQ */
> +static inline void rseq_syscall(struct pt_regs *regs) { }
> +#endif /* !CONFIG_DEBUG_RSEQ */
>   
>   #endif /* _LINUX_RSEQ_H */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

