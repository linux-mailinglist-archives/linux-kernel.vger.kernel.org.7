Return-Path: <linux-kernel+bounces-878428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33583C20908
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CB34EC08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335A54918;
	Thu, 30 Oct 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="h6kVViKL"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022093.outbound.protection.outlook.com [40.107.193.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E0207A20
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834196; cv=fail; b=TkgCE6HINBcXWe4wWVeJMxuqMpSm9vpYOz8Ys0wnE7dqfc/OwFf3ZMqlmis/Y/D/7/5NRa55KMfZQncx2dk/6Hjz3WxsBNeSqM5TJjOqOfwiD1vFVEv1CRQzGOvDndax9SsnnE16b/CCxPrj8tvds41bQt1RaRIsBSYQc7RcjzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834196; c=relaxed/simple;
	bh=6gA0bOXx/rP8v4be9k/g1XmZVz7gq3cOCIq/Qq2D5AU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O0kxV+yUwiCm9jh2LFDDLmtwVSokP09mbnE7VYjJ9yGjYdVuHf6BhmsO+gkcRW87RzGTnIY5zS3NfZmbpXfBA6Oq8MIOdVn5sPOkSmvESIpnITlTmi4Xr9/Z6Y/EIGjiiIMJWwaLA3Csa1n+18Z1ru8LUAu4gxyErb618WwoyJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=h6kVViKL; arc=fail smtp.client-ip=40.107.193.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzG9jlrfdj7ifzxwBK1QHGaOJ/ZPGIBBAN4MCj2cE2gneMj5m9cSX3jEO4BpFU52FC7rUvyvH5zwHQxJ4OU3NhczQ258MCfVZw7VvlsdBD0lKSWc4RQgI6qBbePuIL5U/2ntoYn+zrpomTX2yRaYiYCRfOKCgZIyqp+T/GNyB99ZI1ijBVVi+9rZtWI/tFslnaKgRSG2eYN6+69YXpp7909kqsjxi574yEFdQ95qm0UWhAx7Pn9yzhLYpBYn/bmkHjAPUV4tr6wpZoagG6k1Pc3KPQNvsDeve/OjyAo331XanjicaE/RMGgEk/WAEmaSg11n74AcSVkCH/iYkGacZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S34iB8juvVlKIMIgzlJBzVSGU3NmiAmRx3nyYjE9K3M=;
 b=chhJ0QHq+3BzUicnML2hWNiDE4rDaV8sj766Nsl+1si7ElWVxWF9CaM4H/l0g+/XZJUUC6c9br83mQDVvUjSlDUH9EiU3YsbIbbdx14HiXhAPNvoYnxTeTVz4esRmRX9Y0NN2tw3RR/Y38aV37JylTVtWNvbtSqZQWy/I2veSROGMSMjcSv7iU9MXDsCq2vnBudItc/2h4JCvYNeaFHAerlCnyQ5i4hxqFSn7esmY7s6f/jvF/0PWjS20V2v9JIm9YGEWhFnGBW0LGsbhvS/n1yVd4S0zWEYBz/iSRvSTqeG1BctDvpO7vLTLopZCZM6X9uedtpyz0kknZ2u2Zd0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S34iB8juvVlKIMIgzlJBzVSGU3NmiAmRx3nyYjE9K3M=;
 b=h6kVViKL7uwXeVIivdGM6px8qh3ZRQcvig0yR8RcfRMDbTjNYvlm3oCP3+hUVZLnh97jg7T6CJXC/PzyGgjYbbq5gnjEPg3pYQhU5eNs40P3hEk1oPDFYj9u3hETWrMQBQR4z8uN5SbqZj2HtfZRncNQv4vKV86wwoCSZ8Y0TwXyd/hf8xr4DPmrilb/Z3D580NeprjY95FnbXBmUKfFqflz2IuSB+20nc4dBp59tbA4FNmscLnxv2MMyBAC65dkOTb1MIqAvvzvYSUZxN0XLQsrj+mRRR91EItP4x8DYzn8WQn1yEu//MYFH1WOZTyfnlmGqPxIzd5a5gxc0bgYwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9845.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:23:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:23:11 +0000
Message-ID: <36caa866-1f22-4825-aaf5-6e4d2629a4e2@efficios.com>
Date: Thu, 30 Oct 2025 10:23:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 13/20] sched/mmcid: Provide precomputed maximal value
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.098047550@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.098047550@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: efbb14f1-c04d-4174-17d1-08de17bfda9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm1kRmFqa0gvaWJrTjJHcWVIdFdqUll0L29XRTR1QXlNQWluRDlRNnJhNWRG?=
 =?utf-8?B?SEJZbUZ3bmNBRE5lZzJ4ZXFKeU9ZYTFRWXBQa0ZFVXg5MlBpM0Z6clpRSmdZ?=
 =?utf-8?B?Wk8yMjZsWHJUbEZQU1dzOVFLN1loQnhYY1liZm1IODQ5Z09LaU1KcFpEQUIy?=
 =?utf-8?B?dFJFaTVYdHYyY2pLOXFCMTJEdnJaMlRLdm9VZ1hxalhER3U5MW5jM3lkWkhR?=
 =?utf-8?B?bldJU2YxTElJK1hOOU5yZ0xIclhMem95WFM0RGRuMlZ4czJHbjl4YXBhWGhk?=
 =?utf-8?B?bHJWMUUweDlpSzNBYUF0Q2cyMTY1bUZEMFRtKytUek8zUU1MbnI0aDRGRDZO?=
 =?utf-8?B?M2pMUzJSamhjWVFPeFkvVHJaS05zWjJxM0ZLSEpuVHpKZ1Znd0JNU0ZpUU53?=
 =?utf-8?B?bmFMZzR3Mi9Bd1RleStPcHRQWFMvQmhTZ2twTTZibTVFVk5xdlJYZ3BrRkgy?=
 =?utf-8?B?SDBnWjd3QkVDTWgzd1BlWVA1SDFIdnZKSnludnBIVDBodTM2allLN1ZPUGZk?=
 =?utf-8?B?Qk0yS0twbG5QYXRES2FraWRCMTlqRXFtbDc4Vi9hbFN6b3ZrRitTK3d4MFl4?=
 =?utf-8?B?cVpENXFGSlhhcnBSSklMZUt1ZnJQOFUyTEhIS3N6cWo5SUJBR0s1Rzh4Y0lU?=
 =?utf-8?B?b1l5WUd1R2JYNWdJWmczenB5WVBkWDJzNy9HMHUxMnFnaVo3YjRacFdHTWJB?=
 =?utf-8?B?N1NMTm1nUWFqUUpZUEo4UnFlNmRianBHOVZ0T0FLTVNtYksyakpNeUt2My84?=
 =?utf-8?B?anMvSmFiUVNodmkwb3pma29RVUV4OUROVHRUcDNHZFNMdGNZLzZwc3piZmFJ?=
 =?utf-8?B?T1RzRzFVaGZ0eFVtU09aV0V4bVhMVzUwVldtY3JXdFlleVRpdDIwc3dRNVZk?=
 =?utf-8?B?R3VvK2dzbU53UU9COW8xdDNzajh2eFNQYTFJQ3FxcE1KYnE5ajdFajNrR0Nk?=
 =?utf-8?B?clNna280QWtSbEgzVC9udG1HdVhVR1FmdzY5YTAxU0tnNnRKN2xuaDlFeEN4?=
 =?utf-8?B?UUlLbHFoOW9rNk95dFRyNWQyOVkwVjhrOEVzYW1Cd05ZNVBVL1FoWklKcmQ1?=
 =?utf-8?B?NTlzODkvdnBWQzBDNnZNcjFLM2tiZEpMeG5VbWRxWWRiK01yOHNTOExoQVZ4?=
 =?utf-8?B?T3ZMcys4L01vdnZHQTFDd1N0WkZ0VS9TczBpbWQ5OFNKSXlzbXBNcDNBZG1D?=
 =?utf-8?B?VHRmenVEZFkyeXRacTVzUjlVa3JObDJzSEdhVllYdWRBVTloSE5xZlo3alNV?=
 =?utf-8?B?QmRhSnVMQ1lZdGNjTENGbkhKb3hNVy85T1BXYS9TUTJtSVNUaXJwaUFHOUN5?=
 =?utf-8?B?MDRRT3BsR3lQN0xiTUlHV2haYkRIYVg5STRzZ0VVczdnVDdJNGZsRS9UeWJM?=
 =?utf-8?B?aXRic0ZuWVdzb2xUcnNCUXdKc2NndTQ0bEVSQkNlaDhTaFJMa2Q4MVJSZS9u?=
 =?utf-8?B?cnhZZk1meU92TlpYZUM3d2dxNkFsM1AxcU51bWM4N1pMZDBRV3BWMmJaUWl5?=
 =?utf-8?B?d09nSmlkRVk2c3RTanRtbFRxY2o2dkswU2NIMy9WM3BQK1dKWE9OLzdzRzRT?=
 =?utf-8?B?SG1oakV0NFRxQTFwcXdWYURTOEdUck1xakRiQW5rVGExZy80My94Zkd1cDYx?=
 =?utf-8?B?KzJkUWM0WnZFcDdxOGJ0dGxzQ3lSOVE2OS91cFhNS2NWeVBjRDFxV0ZvZVd3?=
 =?utf-8?B?RG8zTU1XM2RGUjR5cnA0VEFpT2dlUHZhbzhoQUFHNEpzc1g5d3RMZDdKQkFL?=
 =?utf-8?B?ZENzOU9Zc0pXajZTQ3dYY1V6WVZBUmprbWg1RVNpMnNCT0ZHT0o1d0RXU0tV?=
 =?utf-8?B?L0p4MHQ4cWdPUjdGeTJlSTdBbUp1WlprakxlZ0VVaERHbzVVZ2JXS2p2K05X?=
 =?utf-8?B?TlhqWkpWQXJ0Ukl5bFFTc0tqY3BDMkhudndtMlh3c2Y3V1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHZpRTJNcENqaGgxSm1weFg0TytTSktQVkZrT1RUckxNRndGOGVSN2lyNDNq?=
 =?utf-8?B?WUpJNDQ0VjVuL2diTm5UTGtHQ0MwTi9KNnJrYTE3S0FWbEl0cExobWxQbEYv?=
 =?utf-8?B?elB3TFhRWDdWTG41alVZaWRzb3R3TUd2WUliM0tWakZ4Mzk2QVRBNmtjVkw1?=
 =?utf-8?B?bHM5NmJTWjZyd0JKZlc4aGFJZk5HcmJta3hyUDczeXA5M1VveGpOTmlSNXVw?=
 =?utf-8?B?RzU2ZVBHK3l1cHRQNHA5a2V4YWsxRENDQ2N3TzgwU29VN0hJMWNiTjhUOVl5?=
 =?utf-8?B?TWt4Rjd5ZlQxWDV6Y1VxYkVHSDFDWHNXbG5iSVFidHJzL01uWDk2aFdyVzVQ?=
 =?utf-8?B?VENET3psR0xoeEtwR3Fja0ZZSG9yR2l4RVF0cDZrcm9nMkRTL05IT0d4MEF4?=
 =?utf-8?B?Sy96YjNMSSs0bFUrc1RnaHV0ekROdzYvbnVYRDIzVVhENWVPT2ZzRGREeTlk?=
 =?utf-8?B?djNRR281SHhKQ0p1Y3JoWkNQQnVCTUs4OFlIaFNHd2Nsak1PMm82a0RVV1pl?=
 =?utf-8?B?Yi9jUTZYZHFzMWxwTlRIS2IxQmtKRFViWGc4dHpYZHV2QjB1V2NZKzBHczZG?=
 =?utf-8?B?dk1WckZ4TnJHd2d2SG1JUVFJMU8xbFlMc2F0MW04M3BoV2U4K3N4MVkzNGpy?=
 =?utf-8?B?VWl2Nk00TW92UjJpQUdEZTZmN1FRM3FtRHV2SlVPTlBhNVk2VmJLL3Zsa2pX?=
 =?utf-8?B?aXlwd1l5M3gzNzg1QmlIYVRaT09FSzBweW5EWERrekV2QThrUlI1Z2VyMjBj?=
 =?utf-8?B?VUEvbDlidkplOFF1V1V4MjVZY2p2VTJadjdrcEZVbDh5aVJLSkhHS0RLbmpG?=
 =?utf-8?B?YjhldGFnbkJUZHVOWU5LQVFhendjUzhEL3BuVW43enVLVURrYm15N3pJSEFI?=
 =?utf-8?B?dVpCWjZyZjVQT2hTNGJUeEZGNVBsYkljZndhTUJZSFEwWkplSVpYK1NwaUdx?=
 =?utf-8?B?bjZhdXFkUEN6eTRTdTN3K3N3MnVWOW50emV3emJ2ZXZaT25kMEVGV1Y5WFhz?=
 =?utf-8?B?SFF3RHRuZFVwUGVKU3ZubktNQllLRXlIemJEZitBak8weVhjYTlFTHNRbU5S?=
 =?utf-8?B?VzNVUTMzOG1Tcy9kSE1WZ29IMDkxem1RbjZSTk4zR1F0NkVkTGNFeUtPUHpt?=
 =?utf-8?B?c3g2OUhoMWNuL3lnR0w1bnNZbTVZMlpoMDNpcSs3MTQ3eFo5VVR2V3V0RTFF?=
 =?utf-8?B?bVpML09aUHBhY3dNVWtRUTJyYlZvSmo1WjgxNWNHa0NEK0NGWnZ5ektyWUt3?=
 =?utf-8?B?ODNsSGNtOHBkdFBGTlhSekZZdzhYU1YyUWhXVExKZGJpbkJsOWNraWpGak50?=
 =?utf-8?B?RkJSNlhNQXhjR21Ud3psVmw0SkRuY2cvQURZWXMzSWR5YmJFYzdNbjZnZTdn?=
 =?utf-8?B?TEVXRVU1bDdOVDhVSUZJcXhEYzE0ajZjazBnTjZLZ0t1S0o4NlNlVER5VEdG?=
 =?utf-8?B?bFhEUDZxTVNwVUlremsxL2pLNkdHSlpOZURnQ3dXL1RBVjdGbVp2MmZCTkN6?=
 =?utf-8?B?SE5JLzFwdGQyOTNFVG9xK01IYTkraUlyZ2Y4eXZsckdFQ0NBY1pRYWtmdUVL?=
 =?utf-8?B?LzRBVHlFbzZGWEZsWGZBUUtHYTVWNVRCMmJGUm9Xd1Rvb2o2bjRwVU1VRHJL?=
 =?utf-8?B?Z2NPWGQ2bjVnODlnZEVWbzNkYkNSSm1OejE5UEw2ck5qNHBJVzFRR1ltTklx?=
 =?utf-8?B?YnhKM1MzWjJWME1Md2V0OWdHOGxVWmt2YkEzMjlHWDB1VDM1c1YvdHpQcW1j?=
 =?utf-8?B?VDJISXNaVzJxeGd3UmQ5U2VvNDcvMFpmS1BHZEVwUTdpZDZOenpVUklqUlFl?=
 =?utf-8?B?QzdBNHMvL3BrTUxPdGY1cW8wRHpsZk5QUEowaVMwdXdmZHdhR1YyVE9BeGVt?=
 =?utf-8?B?cXB2UEt3MlcrS3g3cFRGNmVaajVZaU15eVFCRXJKSWNlZnlXQXBZQmFYTGFk?=
 =?utf-8?B?U1VBVXhpUEJHdkRjUHlpczROemRBcGFBWW1ZdUEzRWthclRyNWlENnB1N0dZ?=
 =?utf-8?B?SUlmc09uL1JOT2J6cHJRRXJKN09lc0dSUjR1YzdtQnZnNUw2Y3VCaTdLN0sx?=
 =?utf-8?B?VEx1aHMxYXBmb1JvdE52VDJUZFpnVHJ4ZU5RSXVyV2FodXlyTjdaQzBnMW1o?=
 =?utf-8?B?RDR0S3hrcTl2QTZnQXNMT05hZ2k0cWhZYnM4MXM0bXVKaDRDbDN6cERJTHR6?=
 =?utf-8?Q?Xa7Bz80DaueNxQ5eLj8cmLE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb14f1-c04d-4174-17d1-08de17bfda9b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:23:11.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSnY/Gk8k/pfM8bQ6d6pv5F/dZC+q+HIqkR77y12n5cvf4yqxXWIZsJWHbZuH3GWxfuf1sIDRHdrQiuUHP3KTXFHpSTqAhWVO7iEBDwozkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9845

On 2025-10-29 09:09, Thomas Gleixner wrote:
> Reading mm::mm_users and mm:::mm_cid::nr_cpus_allowed everytime to compute

every time

> + * @max_cids:		The exclusive maximum CID value for allocation and convergance

convergence

> + * @users:		The number of tasks sharing this MM. Seperate from mm::mm_users

Separate

> + *			as that is modified by mmget()/mm_put() by other entities which
> + *			do not actually share the MM.
>    * @lock:		Spinlock to protect all fields except @pcpu. It also protects
>    *			the MM cid cpumask and the MM cidmask bitmap.
>    */
>   struct mm_mm_cid {
>   	struct mm_cid_pcpu	__percpu *pcpu;
> +	unsigned int		max_cids;
>   	unsigned int		nr_cpus_allowed;
> +	unsigned int		users;

I suspect this reintroduces false-sharing between the "users"
and "lock" fields (updated every time a thread is forked/exits)
and load of the pcpu pointer which is pretty much immutable.
This will slow down accesses to the percpu data in the scheduler
fast path.

>   	raw_spinlock_t		lock;
>   }____cacheline_aligned_in_smp;
>   #else /* CONFIG_SCHED_MM_CID */

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

