Return-Path: <linux-kernel+bounces-777889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9443B2DEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBBD3B71C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DF264F85;
	Wed, 20 Aug 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EqL4svYe"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2097.outbound.protection.outlook.com [40.107.116.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF44237172
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699046; cv=fail; b=T/E714kGQrWoLby2BErdKlnmWkOdrlImU2RQYzty0v9CG0IHD/Zwx6SxG4NxMxKDTLwoyxKt/6yAaaQKeX9l7+gq1xNOPRqrCYvMZQ3n/9nJpndHbiQykNLiaYbJPxOetMAsKKgaJYRmJn5IZgECrY52KFbr/JSKOEnfXXaCTEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699046; c=relaxed/simple;
	bh=s7N4bbel/d2QmJIQMpJ3pRQv/G9JJBuENU8Pp3e4O+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPGJoG6Say7/60R0Vvr9Ei9zVh4T1Eog/qLh9MzVW2rOm2OfWt/+mJgt/3Xc+lL9nk08KEJtpwmb0oqv/I4tag1XPBwtP38VuO/0fJaMy2UtLDgtJbTu1Zglnef0oul1p9BMAs2NQ/NeCwBUe2B3HQHwf0VUz+k9y7Wz+8M1w+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EqL4svYe; arc=fail smtp.client-ip=40.107.116.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zj1YLQ2K5ErnPEfHQRJ+q/3qDi5RtMVl4DAiGgCmd3golw4FhFq4f30UtY2P9NgoxXHNY37C92bl21j74xMG16jSsQEjzEzGZxLQSPC4zRDSsQ1Vbp3Q88K5/vvWUqryfzzFpaau7JITlrke+lMTgGg97INUoGNY35QWbsF7p6qJYlY/WS43ZWUcHe9wLtTJUNLcL4RjTyo3nL39a7KcaW/nCtQ0eNNa/0eSP3+KimYC45PR+ibaVu3damd3ZnK2ISMNBFnJc0bnxOJemFy/c1SpjvWZqMrfTx9RA9qzScL10Ub7qvGl0gXslJAe/+ImeBvu3vVxWsV9T49vPiimiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTKhbKv/+S0kvU847sWcwUmhKIqSpaqzW1bq4zbuiIA=;
 b=knD4vlqgJRMkvMbCARZ05mYCnaUnC8VT8GvqeZiujh1jjK7un6vlYOoB1EUWO3eiEGyDrU3lYjd3ER9rur1/WvDAMGSUn3+gUGBqdC2V4AM3zSqezDUIKoB9WmOY+pFzpzopYP6ttUJWMciciscq1VjnAu5x7YwU85yekIL8KIVPh9aML61mMAZkrnrLDCGHKwXoF87YtXn8tBd548FfFaoCowypaj2dlt4Wkkj8EEBEc1F0GQU6K+IrAsV96akOizOHXUtvCxMDvYMpULlgDFodCF7WPiAO69ndAeFvV50/unnpRu72zcyB06emJagIOjsJUHGTBWk0NA8DzF3AcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTKhbKv/+S0kvU847sWcwUmhKIqSpaqzW1bq4zbuiIA=;
 b=EqL4svYeF1hY9ChLHQcnsCTvalGLKWoysFjt2XyaBpgkRQiMVhVbfYJpo9sUkReUihAUdy1h0lFGgCWv0myOT6hJIm0DcrkBYFkC9pupWIaHAH5tGkV9bYBhbIcP/3C3JL3xZ+DPJGqAk+z7uDqrha/k8q5EIF8cbdc0f86hvD0GmjyqAGAPaIfHpY5AFY/tlIVYf048tkH5m5zCMQeMChtJGEO84Y9+j7ldhhIeXjlYGbVdDjR+VHg+q+7uspWID6QM97pJ5L7+u8HoCDnwfd0GlOElhMVsuvHBtogWTad29/2woQIdbUZfuxfUmRVLPD5BCNfIEZ2uKtZT5rjt+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10756.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:10:33 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 14:10:33 +0000
Message-ID: <486e8f79-4836-4971-8876-45aee31ffda9@efficios.com>
Date: Wed, 20 Aug 2025 10:10:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20250813155941.014821755@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250813155941.014821755@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: 71adbd62-36dd-475b-fca2-08dddff353aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFFDbVI5VEdKVHQ4eG9PR2p6NVhjU0ZsSXlDa0pBV2hYb2F5VW5wZGxpSFVS?=
 =?utf-8?B?ZEZUUlQrMlBhVE4wdkRNRDJlN3FGQnp3RU45SDE3K2VIL1g5UnhFaDZSRmZL?=
 =?utf-8?B?Q0Z2cHU3MFRiMlovcS9mbjJXdjhIZ2RBY2VOZ0VBQzJPOTlvUEtwcG9BeWhQ?=
 =?utf-8?B?RUFjd1NObWdXeGFvUzJNL0ZaYkMyajJnK2dTUm9lL05yUEU3ZjJobVVhcFcz?=
 =?utf-8?B?Sm85Rmd4dkV0Vm5tR1hmcDBhcENobWYzSDhGR2hnbjdpSTFOU1dycDNpNkpX?=
 =?utf-8?B?RWQ4ck9pcWZkOEdSZUg3R2ErOEVVcUorOUZXeHVYNXgxejc5N0hxUHNVcFNy?=
 =?utf-8?B?ZVkwak9KN0hxVmVvVEd3TkdCS2RIVU9ZRDFuNnh6NkdvMDlkQnlTSDFLbDFl?=
 =?utf-8?B?dTl5QzRLTE5MTWtDK3puWnY2RjdyWnFtcXd6d3M3Wk9pZ1R3WWxVWDlBb01P?=
 =?utf-8?B?YlY5bFBURlNERmdrYUdIb0NDcmVEKyt2TUs1Nk1OZ0tEMDB4Y2dhTkNsL2xi?=
 =?utf-8?B?WjUwQkZHcXdxc0p4ZmtFN2ZEbnpBam16NkMzNGJHZmxvdStEdzhqQ09pWXFx?=
 =?utf-8?B?UEVzQ05PNTFQYTNicHdJdVdTSVJNc1ZuUDIvZ2FzdmVCTnBpYXN5YkFlNnh1?=
 =?utf-8?B?SHpZNjNaTUdUU1lZZnlkTGd1OHVxM3QxOXpIN2VpanVsQ29FZzJmc3lXYVF0?=
 =?utf-8?B?Y0pEMWUzVHRxWEdDTXNVVTJ0cFNnWUhEOUtneSt0aFdCa2JrWERnVkFoRkxm?=
 =?utf-8?B?c2x5cUs3OUIvK29hVm5RdWVCN0I4WDU1eUJZVWpneE4wTkMvYWZHNXE0bzNs?=
 =?utf-8?B?OWNWZURWQkRvMXh3bmJ1dTFVT3MzZ0thYllJTVdvVG9mQWdQUnRVRk5jMjJm?=
 =?utf-8?B?NFA5ZmUzYXNPcUtnYnlJTWZwSEFuR3p3SVlkWXlsSnRoTkxZNk5IYTJSTFVy?=
 =?utf-8?B?cTluN0VCakF5VituSHo4eXJyb2wyNDB0ait1VXdqTld1SEZnUlRHQWliemFR?=
 =?utf-8?B?V3RhZFl2UjQvL2dHaGpadDhuc2o2S1dobExLVHJrckpmTkl1bkZ5ZXJMQWVB?=
 =?utf-8?B?Z1Nva1NUQXNuWlhib2svcmlhcVBqcm9oSmJMcDVuMjlRSFZKSi8ySEF1Z1pS?=
 =?utf-8?B?eExGOGVuNVAxdjVSZFR0eVVaOEdmemsvYmJ5bWpNVDhTb1JEQ3JzRlJ6NFVj?=
 =?utf-8?B?MThxVXNOcVFlQkdhTHZScTAzS3V3VTJCanFSWk1HK3h0eU9CcjlWWGFzRFJz?=
 =?utf-8?B?SldoRVNoZGpmOWxpU1ZSM2tpcTZKSk1aSGhoWGtUTkFXYkw5bFREdnIwOWRj?=
 =?utf-8?B?bGRRaHl5d2Zoa285K3l3bjJYdTNMNXFjcE5DUVZtZlZSRFk3bWxKUmlrblds?=
 =?utf-8?B?dThoRkZ4QnlvN0RzVi9xUlpVOVBKYklGU1h5c1E4T1ZFNlVoY043bE0zRm5j?=
 =?utf-8?B?VlpmYlorcFRlMkFTRDlDZlVNTGJJUUFBQ0wrZXRaN1A4YyszTFVtL3M3d0ZZ?=
 =?utf-8?B?NFNsTmxpaEJlSjVyNEZJKzE3UHZlK1YyTTVGWEZyd3prQlk3bkRSaDJEek5n?=
 =?utf-8?B?VXJlUWpQM01Zby9ZOXVtWWN4KzhlZGdWZlVXN0FlKzRiN1FKWkdHZFFPWGZr?=
 =?utf-8?B?UjYrdGVndm1jdEpySVpGMmxsWEVoc01UNE5mc0NXcExZaU5XVkVqYmdRMlg4?=
 =?utf-8?B?RVRKNGdEWkZ0SzJyOXpJckpjbDZSdHIvQTExOEhwZ3VPcFpPL3BaYTFTL3Vj?=
 =?utf-8?B?Y2FCR3BTVVFyeml0emNMZGdweU9MU0hET3JzSjJJUXc5YllxYURWUXFmdHBV?=
 =?utf-8?Q?gBvK97zAP/wkxo/Jo950jD0+kY7W5KrJf42nM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M213amVrSWNFejdqYjViZERxZEhibzR4TUh5cytFVUkrSGNEN1ZQYlJDdzJw?=
 =?utf-8?B?a3FWcTh6MDFrN3F2SER3bHR6Tzg3THJITlFwcXhRSUdWQzRVT091M3VtdEE5?=
 =?utf-8?B?Yi80ZUdOcmRXcTlQR0xWUGdDVE44U2wxSGd0M0NOVjEvWDEzV3dZVlY1VzNO?=
 =?utf-8?B?NC96dURzRHZ5OFl1QUJBZllUbjE4RGd3cTJZYmZEdXY2VW1pZG1ST2V5Rnkz?=
 =?utf-8?B?b01hMk5ZOE54SUFDaE5Sem82N0RDL2k5YTFSbkRLVWlsWHN5VnFPSWVUTi9o?=
 =?utf-8?B?OWVlTm84UjZZMjRncTFhUGk1ak53Q3E4SkNlRUo4R0EwUTFtR3gwR2FPQjk0?=
 =?utf-8?B?Q2ZQZDc5aWRjZytiZzhaQzJCYU85S1NJS3hDNWVta2tjVjBnNml0U0FwQUQw?=
 =?utf-8?B?ME8vbmYvdUtPNG9RUlRGYjVFNFZkTFVHMjJzL2tNSFA1d0htQlJZS2MvZS9B?=
 =?utf-8?B?Qm42THRlMDlhcy94UWYyYmlyMW1mbnFFTS83MXg4M093WjBtNDZQcW1MY1Zv?=
 =?utf-8?B?S0ZPeXp2NHZjMnZJeVZ2WXphUzY4ckN0elBjWmg1WjlBZ1Q0N2VEUXFkdmth?=
 =?utf-8?B?VUVTNzEzQS9YRTI0WUJ1c1krVFVjdVhIb0hYa2VDeGFwTlJMaGtiWlFLZ2tx?=
 =?utf-8?B?MWNUK1F5ajBOZFZwemFKOW9Fb3UxdmhjalZVUGlaY2llK0lLOUtPSE43c28r?=
 =?utf-8?B?OVlaRE16dVlVaks5VjRacFJWanNqNkx0UUZpY2pIMXMyVHo1N0VBNkF0YTlr?=
 =?utf-8?B?cUM4WndWYXRiRUkwcjBZUHIyMUdVdjBHL2ZmOXVWRlFsdHVlZi9TTWlXNnlO?=
 =?utf-8?B?cHFzdmZ5OUdNcEt2dVBVSGtKWEdxeUdRTDZUbGZBYjFUQmh1ZkRERVBycVZF?=
 =?utf-8?B?ZFJ1TS82L0o0TkJMOEF3MXBEdEhNYThzRFJ3Zjg2cnI4S3N6eENQNHlFUmI3?=
 =?utf-8?B?YUYxd1VUT0pTN29GZVQ0VlB0Wk1aanhNZFJNL2orL3YxZ3ZxWFhwUVlSbWo2?=
 =?utf-8?B?eE5xbnhsNmhDak1xczlhcEZFU2lndDdQeitHMHNBYmw2WUpGdzFkeFBKK1pj?=
 =?utf-8?B?b3JhbFhmSWJiRWhSMGtvdUU3VzNocERJZ1lCMWZxSE8vRXdBd2Z0azRiNjh3?=
 =?utf-8?B?RnBoTm1IMlcrMzNaSy9lNWx6MGFHWHZZQXhUV3ZOeFdaN2ExZHkzdWI2dHRl?=
 =?utf-8?B?WWNqcmdNSnB5d3RQM21YSGdsVWFOZ3VWeUp6aWU2RUVaWUlZdTlUVUZlMGxK?=
 =?utf-8?B?U0pEZm9LTm53eFNndzZzd0FPc05TaUxkclRVMFBTQkNFZTJMTFZTSHlPdEx1?=
 =?utf-8?B?TDNBYnNsdHk3SDZyZGthbFEvaGxRd0tsalpmQzJxRk44amlrdlNzL3R5ZnVw?=
 =?utf-8?B?b3h1REdLV25vT0ZKSk50ODNrQ3MrNEhOK0FGRmFOLzhOUExIQTRydlc5djRi?=
 =?utf-8?B?TFRVNFE1VVpjajNEVU9QUjF0WmY2YmVKM3MxbVFaRkZmOTBJS1l5aHJSdXBi?=
 =?utf-8?B?N1FWUnVTbFZ1bFBWdzkzS2JGd1lObUk0Wm9uMG02eU5mRWt5SmhrZzVLUXc3?=
 =?utf-8?B?ZlZiWFV4VzhPOUdoaEl2K2kwdzhsQndsNEI2aEhiaVBSMURoMUtCY2Y5bFY5?=
 =?utf-8?B?T2RrcWJyak4xb1lHRmhnWEVFZHJmb3FnWUloVy9mNFpqWDZDSUlnSWpzZ2sv?=
 =?utf-8?B?UGdaSTJFeXk4UkhkRWtYSE12cjFVRGNPa2F4TmtsWHI4dU1FVlRHZmxzaVR4?=
 =?utf-8?B?eG5xemlVd2pRdkFZVlZON24zZ2VNMzFXWkVhQ2x3UUFNMW1mZVJTWEFwUW1t?=
 =?utf-8?B?ZXNLNlRPSXM0aTkvMEIyS0NGOWJwcWN0enNSbERuM1ZEK3RqaGZ2NnVmWnZx?=
 =?utf-8?B?T2QwSFdoZmJQVkkxeHh6YXBWcnRQNHFFZTVlZXJJZm9ZUS9oTjdhRjNWMkdj?=
 =?utf-8?B?RnU1eVVhNndQRUN6emFLZlplVXJPM0tFYmVjbURTb1B5c1FSYS9ULzliM3hx?=
 =?utf-8?B?cHNNRnZKREl2VEhhYUtZaDlUU0xEeWRhTjBtSzY4VnRyenF2VlA5TjB5Mmpa?=
 =?utf-8?B?dlJyWllnazNGNzB0c2dXNDU2RWZscERPNVc2TzVOWjg2WGFsU3I3dmZSckxY?=
 =?utf-8?B?RCs5K1N6MTdWeUZ0TXg0ZWd1MkZuMEpxNmlHU0k3eUJWc2N1SlNpU0twdlJ5?=
 =?utf-8?Q?LGvlHm0x0fQj9bZmqEUZvgc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71adbd62-36dd-475b-fca2-08dddff353aa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:10:33.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLKAncnte3wRASGfgiwKXGZ03UxJ+kRuFpvR4KQiwKLQok3+7qt7K8CAc4xtQqFuzxATC4H7nf8cumHuIUXWFfTmohzGFgOGTMRaSr8n7sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10756

On 2025-08-13 12:29, Thomas Gleixner wrote:
> With the more wide spread usage of rseq in glibc, rseq is not longer a
> niche use case for special applications.
> 
> While working on a sane implementation of a rseq based time slice extension
> mechanism, I noticed several shortcomings of the current rseq code:
> 
>    1) task::rseq_event_mask is a pointless bitfield despite the fact that
>       the ABI flags it was meant to support have been deprecated and
>       functionally disabled three years ago.

Correct. We could replace this mask by a single flag, set when the
events happen, test-and-cleared on return to userspace. This would
lessen the synchronization requirements because bitops are not needed
anymore.

> 
>    2) task::rseq_event_mask is accumulating bits unless there is a critical
>       section discovered in the user space rseq memory. This results in
>       pointless invocations of the rseq user space exit handler even if
>       there had nothing changed. As a matter of correctness these bits have
>       to be clear when exiting to user space and therefore pristine when
>       coming back into the kernel. Aside of correctness, this also avoids
>       pointless evaluation of the user space memory, which is a performance
>       benefit.

Ouch. Yes. The intent here is indeed to clear those bits in all cases,
whether there is an rseq critical section ongoing or not. Good catch!

> 
>    3) The evaluation of critical sections does not differentiate between
>       syscall and interrupt/exception exits. The current implementation
>       silently fixes up critical sections which invoked a syscall unless
>       CONFIG_DEBUG_RSEQ is enabled.
> 
>       That's just wrong. If user space does that on a production kernel it
>       can keep the pieces. The kernel is not there to proliferate mindless
>       user space programming and letting everyone pay the performance
>       penalty.

Agreed. There is no need to fixup the rseq critical section, however we
still need to update other rseq fields (e.g. current CPU number) when
returning from a system call.

> 
> This series addresses these issues and on top converts parts of the user
> space access over to the new masked access model, which lowers the overhead
> of Spectre-V1 mitigations significantly on architectures which support it
> (x86 as of today). This is especially noticable in the access to the
> rseq_cs field in struct rseq, which is the first quick check to figure out
> whether a critical section is installed or not.

Nice!

I'll try to have a closer look at the series soon.

Thanks,

Mathieu

> 
> It survives the kernels rseq selftests, but I did not any performance tests
> vs. rseq because I have no idea how to use the gazillion of undocumented
> command line parameters of the benchmark. I leave that to people who are so
> familiar with them, that they assume everyone else is too :)
> 
> The performance gain on regular workloads is clearly measurable and the
> consistent event flag state allows now to build the time slice extension
> mechanism on top. The first POC I implemented:
> 
>     https://lore.kernel.org/lkml/87o6smb3a0.ffs@tglx/
> 
> suffered badly from the stale eventmask bits and the cleaned up version
> brought a whopping 25+% performance gain.
> 
> The series depends on the seperately posted rseq bugfix:
> 
>     https://lore.kernel.org/lkml/87o6sj6z95.ffs@tglx/
> 
> and the uaccess generic helper series:
> 
>     https://lore.kernel.org/lkml/20250813150610.521355442@linutronix.de/
> 
> and a related futex fix in
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
> 
> For your conveniance it is also available as a conglomorate from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf
> 
> Thanks,
> 
> 	tglx
> ---
>   drivers/hv/mshv_common.c         |    2
>   include/linux/entry-common.h     |   12 +--
>   include/linux/irq-entry-common.h |   31 ++++++--
>   include/linux/resume_user_mode.h |   40 +++++++---
>   include/linux/rseq.h             |  115 +++++++++----------------------
>   include/linux/sched.h            |   10 +-
>   include/uapi/linux/rseq.h        |   21 +----
>   io_uring/io_uring.h              |    2
>   kernel/entry/common.c            |    9 +-
>   kernel/entry/kvm.c               |    2
>   kernel/rseq.c                    |  142 +++++++++++++++++++++++++--------------
>   kernel/sched/core.c              |    8 +-
>   kernel/sched/membarrier.c        |    8 +-
>   13 files changed, 213 insertions(+), 189 deletions(-)
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

