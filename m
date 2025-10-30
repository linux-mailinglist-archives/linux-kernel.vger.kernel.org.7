Return-Path: <linux-kernel+bounces-878382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D8C20718
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F80D4EF14E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FE2566F7;
	Thu, 30 Oct 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WpVJ6mC6"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022080.outbound.protection.outlook.com [40.107.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6E239072
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832757; cv=fail; b=Yk7X7YsFkrA3umks77D7A3ydz7Uj/2QfTLb7WDkxwPSkWSn7iEQ09TBNa4/Hu5MwAj1Se8pnZIoNrrq2AMRpvq3EXiPGRqoLCrGD9dhorXKLWa2ciLMUaYlAQAtBY/CaaHY6yD1knJ+uYeNx4Wg2USuhJPQqCMco4PMysDQxwMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832757; c=relaxed/simple;
	bh=TaFojXWk9ybnUckEtpF+vOHZ69ZHfnJcbV1FL7ejSSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjCFOeacoUqR6p/jH9ibynsFnOzDODYLGqjfoz8LQ76ATDpqzlXqAynNQMiyrt+OVyUAbfNLm6EBDtC+zD2zj1msCvtwscgcinJEVB70gRt2WtKdFe7RXLPRFGqhhhdmpHXVjJDAXtDAc0A+Sq0FBIiq6q6C/vQiLw0GcCbJlcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WpVJ6mC6; arc=fail smtp.client-ip=40.107.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC3d2I1LvR0wt4/zKMq2moB00X6LV5PaV/+SWn/rgC+faea24GcFpvmdJd+z1R2ZtO3oFrOsKAnsVA1XVIjsIE3pFCDYpwSp+st1wI1wcMxPHlBF5cepQ72ARmpOocsFW1TlxYfXDLnb/mUwH4gk85/IQPaNwFA2X9MKA+NNgYc7oQMSqr+jChprgGqXY8oOaS1w817wv94PiwA2EQa74YVQDbU+wrOWNMpBh4l5BkEAj9DLkEB9sBiMLmgeoq37b2GWJ5sjXxkyn46lxgrxX32cX4EbHaMN31ygW8GLPcjBefR+7dCos2nsEf3T18MEzmp//SeIDZCDWLg7OXSRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kius1bSU0r1kRm5zCdvahJXPDtRK2Zj6MjVE7lD+fvk=;
 b=TCZddz4m9SKeG5DUalHFG5aUHHCJ90xHpWami8qITtlV+KNumIEQ1JlLOO//OUdqkE2vWIDtK/JHgmQ3yC8UaY/hRj7+zyL0Op7Ne603D4KrDlnPzs6Oho+qN5vlehmSxjI+obg9orC8v/SzWHlpCuThHgxldmTDLdTuKny4duroQTlSaMf6+lt+ZxAW0o8SifB0rTFV1PAjMgwW/CgdyoXE4HZCKnxvfHYX4mxgJ3zMiAD0j9dhprnABcMOCrpH/LyomRC5FoXkrom65iTvIfr96ELoGTZooVAO6t2DK/l7kvtNaJ/b2VSuXRrGsTYBEIOl5LW04Yw7HGKJExGD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kius1bSU0r1kRm5zCdvahJXPDtRK2Zj6MjVE7lD+fvk=;
 b=WpVJ6mC6r0Glvz4kgzCBT1mlT+xe8iJJbEf0ySQDNNYAaSUhbYGfY0ZL8SSDxU+XfR5S/OhLY6IvUtYEPsTZ/n+CY4z6KOY5QPiklg+NRtO66HDSE9rDUuQh3l7EXF7CTfJTLR42HjIbBN0r9Ag6VErqTA0y82pEyJrTp6WS45GE5AM7Y2OXLLQUcBXG9QV7lAK4Ji3ZG73+adsYqzL4/jnPWPv/QEnWgXfbNgVsunnhzamG+hxIj4ENcKpGEUYN6P9HvwS7QtKqu7CeAWKCvX9rJbebV4lwPreQdq+9uf1IwjSJcJn8tZoTdkLCMBPwFQx1DnXiagTTajiiUBQQzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10950.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:59:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 13:59:11 +0000
Message-ID: <f0f2bf69-4554-40f9-9d0b-478d1ad5bdb1@efficios.com>
Date: Thu, 30 Oct 2025 09:59:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 10/20] sched/mmcid: Convert mm CID mask to a bitmap
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.909894811@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.909894811@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10950:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ca47d8-4eb0-46de-8ab5-08de17bc8070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlNJclJxN2ZEN2M1MFBtODZOUGtYNEp4TmpEaEw5VGpSN1I2MXBIS0lNbExr?=
 =?utf-8?B?QWlLb0xabjRIeDZXN3dnWElKWkZndmtGN0RjclNhdXdHbitVYkJBWEdJeFVW?=
 =?utf-8?B?QWdjSzcxZkYxMVpyN0RHRlRsNVU3YWhFdVY3QXFkangwNUsvdGk3Z2ZORGpo?=
 =?utf-8?B?OE5rUnp3K2NlT01xT2dVdElVOFgxSi9zb2ZwZFY0V2pZcWFQaS9kSnBtU01B?=
 =?utf-8?B?b0thSGk2WTBTWHFhSzkwek9YTUptSmtXYzYrdVM2UFZRcklrdVNFb3NYQlQ2?=
 =?utf-8?B?Q2xUZUNxVnM4OFo5eWRMZEJCZ3NJSU04ZitRblQxRW1oaXc4Y1JpakcvWnBa?=
 =?utf-8?B?L0lkdkordVNRN1dpMWtxMC85NVdaTzhlZkRrOXA3Tlk0eHF2d05sS2wzNysx?=
 =?utf-8?B?c2lRalJ1cVVzRWZsS0tieWtoMG5lLzV6NW0xTUYvMkRUNnBqemdqQURXU3FC?=
 =?utf-8?B?U1h1U0RkMDE2Y1FBV09pYzRHOXBVSkF1c1Y1VU9IT09hdTExb1NxQXhydzZm?=
 =?utf-8?B?TmY4Qk4zQ0lIWVk2OVhDR3R4SS9Ja3pWeHZaUGZGVVNzS2hOaTF0QUtFbUxT?=
 =?utf-8?B?OWxTcHY5aSt3ajQxK3JxSGFDSVZ3MXZkNUQ0TDJHL0srQjVadkVlRWEzZGJQ?=
 =?utf-8?B?R1RDOHNqTVZWMjZYaG9oS3lOelBhTVVUMGxmWjlCa1hxL01UaFV1dTF3eGFW?=
 =?utf-8?B?UkU1T0NiOEo5WGljSUFmVERIRzEzelJZdzcybVZDbk5KNjBwV2hwOUV0aFpG?=
 =?utf-8?B?dThVMzY0RXp0L0hZVTdubXhxdEFMWFl3b1Nub3BGcVFpMjF0K05oUmZmckVN?=
 =?utf-8?B?Z3dpQWVHVGsrMXJCMzNybWZ5bFZBazE0QkdvOWpRQ3pGaGpIRjFHekFHRlFM?=
 =?utf-8?B?MmgzRWN6cVN5b0ZUUjRBWGFRYlJWOUY1QWlpamVLZ09DeXZPY20xaTJoejV5?=
 =?utf-8?B?dXp6T0xiUE1XWWdjd3BMWmd3RTk5Q1VDUnBEaTZGYk41MHpWdHVGd2VOamd5?=
 =?utf-8?B?YzVLbGo1ZHowODNOcEppZ1RiYk9CUVpjVEtIMFdTUkp3c0k1RFF3WU1WbW14?=
 =?utf-8?B?Y2l6dzc0dmdkZmREdnB6d2paMUdRN015OU56Q1FGMDBJZUEvSUNTamdCVCtw?=
 =?utf-8?B?akY4YkZkUjA5T001WTlTMnROY3R0akMyQ1FKeGNBQmgzVm40b29UOGlib01L?=
 =?utf-8?B?a2x6QUhjdHd4Qjhwd05pTzl0M0dpZkN6bmRBRlhKbUtHSlU0bGY2WXFJTm5L?=
 =?utf-8?B?eHdORktKd0dxdDRXZTBvVGlLUmJLUE5hMjF4YUVEVWNyc0UwMnJFTkVUWlFM?=
 =?utf-8?B?M3Q0bEswYXBvVnVXVzNmWEV3ZTlRSHR4VjJBc2wxNGcvblpJZWtuRVlzUlpH?=
 =?utf-8?B?OVVYZEhYYVZlTExZSUwzTHloQUJRUHE4QlE4RCtUL3UwUlZoQnhrT1NOdWRJ?=
 =?utf-8?B?aWE2MEVYZEJRR3BjRHdUcjdoeGh3RmdqVHF0N0dwU2Ric3FmRTFXMGYwVUYr?=
 =?utf-8?B?bmkvNHkrNEhpUUVNbmVaUnQvMUoweDM2UlBWY3ZLSnVSVEZCaktLMEpuYm5a?=
 =?utf-8?B?YXhmSHMxWEhhRUd4K2ltSjVmQUVXdjZ4UGFieHN5NFZua0lzVzVTUGNFT2pj?=
 =?utf-8?B?Q29VK2czaGJJKzNXdzFwbTN2ZmFSUWJBZDhiRklqemJ3MDBuWVAvWnEzdC9V?=
 =?utf-8?B?MURMbm5sQlNDSDhMQUdlMUZ1OC92OTZxQjBiblJpVm1qeFZuR05EblJGYTdi?=
 =?utf-8?B?d3p3YjI3SEpLMWM2cURGOWpJaWFDYWRHR0FTRmczOWRlNUxGSW9IcnZoZWI2?=
 =?utf-8?B?dm5ZQXZBODVEbkpHSG9uRHRRZHBBU2RNZSswbHBtcUdIMDBEVFZaYUx4ck1C?=
 =?utf-8?B?dEQ0azNvbFlQQmdsVTgvMTJ2dHk2VlAwcFcvbzdJNE5NakE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGJXSGtnQXZnQVVjMTM1WklrK1c4cEVFU0tqK2dMNStNZTJPL0pKdElNMTJr?=
 =?utf-8?B?MTJkVWl1VUZPR2FQTzdYL2FaT2xmUHVuUVNDb0k3d21rU2hUT21adkFqUUdy?=
 =?utf-8?B?c2tNUEpCbXlaWkhDTk14eEk4aEs4a3dhWjV1NGdrT1p3R0E4RVR5dW9xd0Jt?=
 =?utf-8?B?NzM4MkxkM3FjQStoSGxTVFExUjZVVkhGTkFPOFVtREo5SGNwWlJ3NzZvWGFu?=
 =?utf-8?B?alNUTzZYMm5aeW94ZVVYbUdFVmgxUWR3K3VwL0NqRVdVMjBwMFgyK1Ntajg0?=
 =?utf-8?B?S2F2YUtjS3NkaXQwTUI1TllCNUZOa3Z1ZGVPa2tRZGd6Q3hoUkYrQ3BDRndI?=
 =?utf-8?B?bU5DR3BHanozMFpoRWxuc0UrTEwxWi9nYXZ4Tmp6UEtNUndpVllLalhRYU9Z?=
 =?utf-8?B?U2oxUXJTdGsrVnUzQUV2SDh1dE9TSFcvTWNwK0ZYRE12Tm1MSVRyZDhzRnlu?=
 =?utf-8?B?QUVPeWNoMXd3MlQ3d1ZPLyswYnNFbjczSUZFOVBEaEZDcG9vckhucTVVZUM5?=
 =?utf-8?B?ZHhQRFBCR2o0ZllGRW1hRUg1SERyS3o0dnZocWFycThzYUxtTTY2UXBKa2FR?=
 =?utf-8?B?cjNNVTdmY0dBVG05WUZwSm9wQVV0N0FwU2N6OWNhV0xaZVJIL1VoaHJhdDR0?=
 =?utf-8?B?cVJtakJVMnpXaUJJdHNyNktzKzhXbit3VDl0VWVrRU9MNnJzNWJKM0E5c2xp?=
 =?utf-8?B?bVVONlM3eVpJU05qWTI1cldCTGJveFBVZ09FSlJIRzFoQ0sxdUVYRC9Za2s5?=
 =?utf-8?B?N0pyTms5ak9kcFZsQUdoYzF1eWtrWS9OL2xZKzF4a0NIcjloUWlvQXhBY3gr?=
 =?utf-8?B?RHZWVGZJTExCWE9qN2NPZ2pwa0R6Q1JFTmFRemJaNS9teFV3NjYxamw2OVVQ?=
 =?utf-8?B?eVM2NEgwUE9xcDhhNUxXL1Y5VDRIS0RGUmN0VXpPb2VSejJYbjZzdUdVMS9B?=
 =?utf-8?B?MzhnSHZJMTBoWWp5eU1tVUFqNThoMWJkd001b3hQYTMzQTE0TGVwczhXNmtp?=
 =?utf-8?B?S01LdmZsSHBnTHprQUc4dEtRRWZ3OGczdjNsU2J5UHB4UHFwSFhab09kV3d3?=
 =?utf-8?B?bURRMGh3SlZGalY5NWdkZUcrWG1YVjZwZ3ROTlUwVmZVVCt3Z3BISVVhL2t5?=
 =?utf-8?B?cVhQcEJFZDBWOCthN0ZHWElXRGxHV3JMNnFkYWpoZlRGRUpSaWNsWHFETjcw?=
 =?utf-8?B?V2g5WlpRL3NIZnlUdklDVVFUcUpBVXEveTNkdHVycUx1ZDZVUmc4YklNaTVH?=
 =?utf-8?B?T0N5ZDBSZHVmdlpsczY3azZsczhoa094RWZ1ejVtM2VvdXdOVE5HZ1RnODhG?=
 =?utf-8?B?ZlVRQTR4Q3lpZE14eUErVC9QMmxYamFQeXNwRzNwcUtlN3VGRXAweHZwSkNa?=
 =?utf-8?B?cWY1VE94SlFiWE8xNmdIVmxnOWpQdzFWcytaS1cxMUErUEl0UUJJajlBblkw?=
 =?utf-8?B?aEhkT3d1ZnduVVNhT1hIdTVMWTVsNnlTdGtsV1p6WVg0RUE2ZDBxdm5FNHV0?=
 =?utf-8?B?M3p2ZzB4dXlUQ1YyanQvSzJDVzAzck1QQzhxNEhRSFhUdjNrKy9GZ3IwY29h?=
 =?utf-8?B?cFJrWVJ0ZFdmNGQ2MXFMcGZhU1pvRDgyT3d0ajI3akFaS0RMUjUxbjJyUy93?=
 =?utf-8?B?WGlDbkNQRDNJdkptUkZkMEg4NXRrQnIraWR2RGZka3ZOUU9wdSszM1J0eWZY?=
 =?utf-8?B?TGlvMFBSUzFRT3RlVGRReXQxc3o4K09MSDV4WXJrbjVoOURCT2E2V3pqem0z?=
 =?utf-8?B?TllHQXpTTWF5Zit5SStiZXRIK2xROGZGWTdDMGJoUU1OZzlKUC9KUGtDaDUw?=
 =?utf-8?B?YkNrbTZHc3dGRWpHanRhNmpaWEZmV3FuekVhUUtmQ0ttcXhWUWJQdEU5cUgx?=
 =?utf-8?B?cjM1WkJycHNNWGlFSTB6eHh3UC9XYStBQXNINGtKNENPNEdXNDJUSlBxOWZ3?=
 =?utf-8?B?azNseDNXcHRYdkdOSEFTdzlqaGhGa2ZCbG5jNUNXZWR0bmdiYitOdGU4a20y?=
 =?utf-8?B?Q3RoNjk5VTM2NlQ5Ny8ya01mUUhNaFoxcnVGQ3lQR1l1NU1iN2hsYTBaUTUw?=
 =?utf-8?B?RERpZi9VNDdVVUM4VTdlVXVBa0EwUkNJMHBuRW9BMGJZdkpONzhZTHJYOWxs?=
 =?utf-8?B?cjVrMmduVTNEdGx1cG9NZWpURTJCZHR3VEI2cG1KTk9nMGNLL3hjajVEY29C?=
 =?utf-8?Q?WshQuaeAUlG4KWi5QbIoKQI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ca47d8-4eb0-46de-8ab5-08de17bc8070
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:59:11.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4Jpj0Yha1ng2Mhskq3GyM2ykDd7ScBXwr//npPtJpkoc5el/1Tl6wv3w39xFOH9O5FnGCOOcYSZledpVgc+oT4m2xfQsvvbOb5LtBBijO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10950

On 2025-10-29 09:09, Thomas Gleixner wrote:
[...]
> @@ -1363,7 +1363,7 @@ static inline void mm_init_cid(struct mm
>   	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
>   	raw_spin_lock_init(&mm->mm_cid.lock);
>   	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
> -	cpumask_clear(mm_cidmask(mm));
> +	bitmap_zero(mm_cidmask(mm), bitmap_size(num_possible_cpus()));

Then perhaps you'll also want to update mm_cid_size() to:

     return cpumask_size() + bitmap_size(num_possible_cpus());      /* mm_cpus_allowed(), mm_cidmask(). */

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

