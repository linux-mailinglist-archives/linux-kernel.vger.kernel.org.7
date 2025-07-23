Return-Path: <linux-kernel+bounces-743089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646DB0FA62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAF7547C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74468221268;
	Wed, 23 Jul 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="VF4vyFrw"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EC155C97;
	Wed, 23 Jul 2025 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295960; cv=fail; b=m+X2wdWqloQV0d0UFArJVWAngv+qFKD8ALs23xlIHahBHuRPpqZMEMMbwu+FqgL+plg4SxQW0rqCVzLCjtxsqQ16//mF5aapfmjmL+2mYgDxtKAhfyqIdGbwb7odtRugMpYnsMuzFM3B9vh8EaJWxypiCsnjncq4SZHSYe2gm9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295960; c=relaxed/simple;
	bh=BtJdZo0FN8jbD4yUazhI9v53ztPUAKuxY3wZBUHAu8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qAgDd0/wiUaM4lPQnsr+wmNF8iaynqDAaayRQbzmHhNyEg9Ctq/zs305obpEEKfBdgx/yiFyR+jCb+S74IZyvenjRGQ7EjdsEd/bU9tkx7nKUnff7e99K4vjl6gSn8yA1gnHh3Xo4TytIdyROYdNbY0gg4triQh2DWUS9X6A3Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=VF4vyFrw; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFIu3/AA6lX8pQ/1cZiVW+oJx76kZU/x/TaGPdTrqNeCh5HlQ2xJB//8fWDSmXdR5wj2I9QvjVEt4/OcMVSvz0H/heU/eWjXGmw5nDWmtxPgMG0kNZtaV1QO/wOpYO/St00p9bjPeOh6tTg6FTytCOTRgHuRiDURtaqsYk1TmLUDnWBWADfUpp8XQ+osV69rEvuaWcSmbWr3epv9CFb6r5YRCKxr6SFLO50o7xInL2PinNoJukXxIh6v4xLyWOeRKB1WWSUEvBnIbXFoasWDQRj7B2KDa+OLgOHiQea7y0dge3YSgjdTqVcY90wNV+4yOmJ9pzAMqub+0PfHa2xDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIbJdMh+Bdcz2EcWjJ+uu4Uk99LZXIVOSioInxepx+4=;
 b=mqqedM8lMMLaPmYNCh9AZTOdTpzZfJDms8oHnKccIl483gECUJTW5OFzz3WT9sb1bfesh8cFUTbw/rZ180AW5lnayTF4ecB+lFhiTbc30Hi7eFqhj1sLl5WxbwTPFq3HaxAL5TEvQWg/qDu5NebmminNXo2sX0V5F2JveV7YtjqPq0p5XOsnJ5bZ1JZlhFqWv+XOQaWISIzzL9w6E31tv3gD6P5RWunpAiLXYOn8SEExZsEzFyzkbI+OBMxpr71w+r2ze8er4KUOevdQo67aFA2tmwYn7qMpdgZUGnQx1nPm5rp9WTfuxtWRKmy3zZqTJNqoZKKneRqlgMVyzI9GRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIbJdMh+Bdcz2EcWjJ+uu4Uk99LZXIVOSioInxepx+4=;
 b=VF4vyFrwwIMjBhO6ShGKXA86KzUUqZHbHNHbyZb8z8h/c2R1FFhZKHrzzg/rG7iJ1/FIsmoy1Hb11vzmkvo3ECh3MPLISoQHH6ObY4kwjZsdrMvhxU04he0JylIE41B64KMyejqIQd/S2DTe3NPZv7ivKFRRlTCKd9Adr/qNcONDUdlWtBmtS7b/hlfVVz4l4DAMfSaq1+/WtlZNJQbCW1Ezp4o8NVeWAeWAW3e8OgIwLnP+/690RRs0sHzzkdIXXZRdz4RqNjiLee83x3iKKS0V9bNycOKcRf0ah7neLJOgsN+bujrHR3uYqwuan3tIaiW9FMuhEjwmMsvFIrsIdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by AS5PR07MB9865.eurprd07.prod.outlook.com (2603:10a6:20b:67d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 18:39:16 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 18:39:15 +0000
Message-ID: <44675637-8783-4731-b29b-02dd3e504d98@nokia.com>
Date: Wed, 23 Jul 2025 20:39:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] genirq: add support for warning on long-running IRQ
 handlers
To: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org
References: <20250714084209.918-1-wladislav.wiebe@nokia.com>
 <877c05w798.ffs@tglx>
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
In-Reply-To: <877c05w798.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|AS5PR07MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1a70d7-40de-4341-e3c9-08ddca1839b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXdDQlo2WE95RFlnU2VxVjBWcVZxVVlyL2pMK2drTFB2dlA5blRTR28wNlkw?=
 =?utf-8?B?OW4vRVdkSmZqdkFvN2ovSGMxVFVVT3RPZUZ0NWM1TWliWGRjbGZ5dE5FMGZy?=
 =?utf-8?B?dmc4Sld6Nm1FSzAxeXQ1OXVsYytOdWZzb044aXArNXUwMFB3QUJHTmFwS2JX?=
 =?utf-8?B?cEtNK3VKK2d0N0s5YjNBM2lQcmQwWlpGMlpaS1BsVTA3QUpiWHZpMjFjL0Jj?=
 =?utf-8?B?RWtiL2t2RjFyMnY3MFd1WmhyRlZsMlg2UzNHYWRqMkpMeHJ4Z0VhMHI1ZFJn?=
 =?utf-8?B?WWhWbzBXd1V0TXlaRHdCaGR1WkJ5WlZLSHRJQzd5ZUxWV1lyWnk3Qmx4R1lO?=
 =?utf-8?B?d25STFl5SUdIUjkrQ0Q0dWNpcExXbEYvRWhaajRxYnNpZDh2Z1NSMitud0RX?=
 =?utf-8?B?dnB5Q2VEMnBiS3NxTTFDdmdHanhKTlRESHEvK3RkUEs0ZlZBblRMcFFTWHNi?=
 =?utf-8?B?NnBlSWptdnh2M0FuNEpOU2x5cVgxL1ArdnNjOGJ2NVgzRjJVUjVaRVlkMzl1?=
 =?utf-8?B?bEVtVFZvcmhVaXZua0V0OGpndnlLc2hFZ0xoZGhka3pnWU9iT1NTeG5BOHJC?=
 =?utf-8?B?Y0V1RDFJMUJBV292bXE3bUhqRFBmT1d5QkNlRDVKQmRnTXBMNGM2aUlFWlF2?=
 =?utf-8?B?SStjcUZNb2xBcFBPd2VEU2xpQndJamZGRjRWQURUZWY1L2xNNnFvVHBXVXQ0?=
 =?utf-8?B?Z2Z4ZGJPTE5rUGoxU0dTZ2pqUE5OemJMbFBpMHZycUpZdVIyaHp1WWlOSmU3?=
 =?utf-8?B?ZzI4NkNiQ2o3L0xiei9ZRmNteXVYNUVZOFNrcjg1c1ZLZWhzUjh6Z1h2akkw?=
 =?utf-8?B?cWVuakNKUVJtVGRGMnRXMWkxNXNCai9NNG1weEtvbmhCaU54VkZwMGV6d0ZY?=
 =?utf-8?B?T0NJL2Exd1h5K0tSU0UwQTFpRGNzT2RrTjBEdXhLcVlWbkFWdE9kamRMNkNm?=
 =?utf-8?B?ZUxnMHNoUzJKMFBOTUJLYm5WL01IaVVORmt5Rnk5YWgvZTBDOWFGZDRYSit2?=
 =?utf-8?B?eEpCNTJwckdGVmNsQzU0OVIrNVZvbWtxMitydXY1RHAxNjBMc25heVN6WXUw?=
 =?utf-8?B?WFhjc1l3dG1PQ28rSWt0V1lWSlBlWTBDRFg2N1JyMmY3VTB1aFdlRHAydFQ0?=
 =?utf-8?B?dGxZSjJtODhvOTBVRW1RNkt2clVUdTg4YTBrVGs2L3pTMzNQdE9vRzdWMTNG?=
 =?utf-8?B?bFBOSXJVOVFLckIvRWtNYXVDcHhzWlVLNHBtMm9WN1A1Mjdiakd4K1pxeVJh?=
 =?utf-8?B?TTdTZzMzelAzbnl6dVE0eGVVWTZIV25uYW1xREE2NC9pKy8vVE5DamJuK3JD?=
 =?utf-8?B?SkpkZkQzblo3M2l1YTVaY25GdmFrak1yWEw5cXRFUHZ6eGtXTFA1SzIyQ21J?=
 =?utf-8?B?ZmlGTmlSRUlUVDdGams2ZDhHZFhEWVhtaFpUNWkxZ3Facm9uV3dYbEJmMjBJ?=
 =?utf-8?B?dWdKQkM2bFlLWFQ3UTdnS01EaEZtZUY2K2R1UURRTTVYcE5wZWh5cU1ySWFk?=
 =?utf-8?B?NkRWbk9nN1ZrcEVuSlUxaE1ybVdKZW9aTEl6RFhYMkhORDVmdlFpQ0h0a3Nx?=
 =?utf-8?B?bnBLK1ltRGUvU1ZBaTVXbVZraTkyZ29WZFBtSk0rOVY3WnBtVEFISlY5bDlQ?=
 =?utf-8?B?aHJ0aysvQytWdFBGZDZyRkRKWWZyc1AzU2Z1ZHUwR1ZJWWQ4Syt2WWFmMlNC?=
 =?utf-8?B?bzN3NElocXZxVDY0c2hibnZ6MXFQU202cXJOQ0VJcU14QTYrRHF0NUNabE9H?=
 =?utf-8?B?NHhxTE9KMWZ3bzhpWDRnU2pHYSs5eHRYYVhUdUgrQmtBVVhmVzFqajI2RDYy?=
 =?utf-8?B?YjlVTnRpckIwNEFWUEVEbEtUdktPdEpBSUpUWHhNSUpDQllpMDRIQlB6ZnVk?=
 =?utf-8?B?REIxZGdOMGlCdEJYNWNQTUxHeXJvZDdvYnVZRi93eFJnQnU1NVRVeExzK0p1?=
 =?utf-8?Q?RBLkOi6uqLs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzRqT2RTeEhwRUEzWWxVVWlGOFZPdlFuUFdvbWwvTGUxOEo2dUM3T2hTdjJH?=
 =?utf-8?B?MGZLK3VFLzhXbGkrUm1WSWhWcTZ1MUZLRFNGQm1QdFR3Ryt6T2xQd0NKWUVj?=
 =?utf-8?B?OWFSZGJzZ1pueGhTN3dVVHMwTFg3ZXhzS21RZkp6Ky9XdzJzQ0srTkhpT3h2?=
 =?utf-8?B?aGg1TnBuZnhUbFVxaWJvNVBqa2tjVlFtRTNrOGVxSEhlbjRpR0hUMnR4QlpE?=
 =?utf-8?B?VCsrR2VtZ1NLejNudjh1Yk1YdXMzLzBZaDM3b2pIQmZXSkFLWlp1RnhSbFpF?=
 =?utf-8?B?NTBwQ1BsQWRPTHBZcXNyMFNiWVQyS3B5TUVqaDBqQURSZm1FMFBCemtqRlhE?=
 =?utf-8?B?bVYrajNvR1pwUEZ1WmtRcGVuS3NsR2RDTEtjSnlCQlpady9NNXFKenoyTEhI?=
 =?utf-8?B?NTlxbHFTSGJ5NXZlTjNTK1RJNDVQQ0ZCSUR4eCs0NmtEckJaVUVrdVJPdXRE?=
 =?utf-8?B?L2dYY0hndDRNMURCQmMwMFBmS2N6ays2enpJL2ttUDFJT2hXNHIvWlN4Rktj?=
 =?utf-8?B?MDFrMTJYUGRWVFVvTTNnb1BVMXNiSnlLS3pUQ2xXVkM5MHVSY1YwMlpIN1o5?=
 =?utf-8?B?QnVkOGJPaDAxcjVTTlZkd3RZeU02Yk91eTB6c3R4a1I3cmd4RWFVVFo5cnc3?=
 =?utf-8?B?SUMxRU5ZM2RvVW9mcjlCMHZUWkJGSVFvQTlvdmdxUjNvQ0l5QWkvWEFPMnFk?=
 =?utf-8?B?Qlo4QS9HWUtOamN4dStnUERNRzRxazNBejh4WEo1VkhGRHA3SHVzQTB0L2tZ?=
 =?utf-8?B?YjlYbGlFbFp2NWRKdkUrWVlXWVlLaWJIZkJIYkFQMGZUTzdRVnJ6ZVdabmpm?=
 =?utf-8?B?aVhrdHAvc1ptTGFnUVFKZUlRN05qV1dRRFY1ajVUTjZEbU94VWFLcDNrVjFS?=
 =?utf-8?B?NkRyMGZGRytNZCtiNUFNeGhjamxIckM4SmxXSXp2cTdIcmEySGNFVnZxVXdt?=
 =?utf-8?B?RVNzUkJLci9QckhwMHZGTm0vSVBLMTN3VWxKQkxmMW11VXFsWUpmbm1DTUZU?=
 =?utf-8?B?dmtQQUFaS2E1MWlYTnZwTjF0V3ZQeXpRUjJlRUlrb3lxblo0N2NEZ2VVeCs5?=
 =?utf-8?B?b1EzdXdvMXoxait4SmFIU2hHTVUwSi9kaTc5TVF6NThCUERla0RmclEzaDdw?=
 =?utf-8?B?U0FmMEhkVm5JZWJLQnpIeStJNmFKY2xpNS9jNmY1QkVYeE96S1lGTVQ5dUMr?=
 =?utf-8?B?SlBiWFNxRFhSU21MZUdZQ1JxRFpPYVBTMll1RnRpd3A4cmpLbHdlcVJJTktT?=
 =?utf-8?B?TzVhcGVlSm1ObEMvMnozN2F0ampIdHNScWhwMjdkdEJ3dEdXOE5JV2RCcjE0?=
 =?utf-8?B?SG04YlBnWVdhUHdKb2pIZUxMbmdpcHZ6dHNFVU5PUXBDRHB2U01reXByWXBt?=
 =?utf-8?B?TU9qNTl5T3NwcEpjMTNZS1B5RDk1RXNEMWFONFB2a01WZTZUNVZSc0VvajYw?=
 =?utf-8?B?czZCeDg1ZkJSRHlNa1h1NVBWdDZuVXhMbTBHa1IrZHBxb2tRYkp6bWh6ZkQ3?=
 =?utf-8?B?QmZyZytpTlBWeUxEN0dwQy9OakxVTXZUR1hMam04ZDFDR3lRRUtpNkp1bTVv?=
 =?utf-8?B?N1hKcmpEcTU0U08zdW0vcEFjbDNJQysvaGRoVWx6bWlJRldSSmZUZVUxajVr?=
 =?utf-8?B?TjJoZ0Rvak13ajFiZ0tCYkRENDVmVm1YQVhwcUtMM0FKRzUzTjM1NFdQanVO?=
 =?utf-8?B?cEZxckN0Z2k4RnJmQ3hHTWx5bFNDckt5Rkx3THpuaGVucVV3TWRzbjBrT1ZM?=
 =?utf-8?B?VXBseTlLaFhPTDQ3cEY0cG1ncTZRdkFqd2QxaytwNHVPWUpYZlVwUXZBbExO?=
 =?utf-8?B?Z01TM3FhbVMrSG9Uck85aThoV1RvMDZwc0VjdUpKV2t5cXBQUWJoV1c5U0pL?=
 =?utf-8?B?akEyaVV3T0d5MjFvYW53TTFGVEVNRnFvd1k5dlRsVjAyeGRoUWVENEJKQlBz?=
 =?utf-8?B?ajZxUE03YlM1UlIzL1EzczZScmRDemJCQlA4SW15c21EOUJiMUJidVlPVGg0?=
 =?utf-8?B?ckhaWHA5K2hLbTFaTjN4cncydkZEbXVQRkQ5QlViMStCVHhKNUVhbnZMemtW?=
 =?utf-8?B?czUyaWwrdmpMOGdkbHJsYmFtb2VjUXY1THhQMkpOUXk4dUFsMDZPaGEyVXBu?=
 =?utf-8?B?WEo0YW5LOUFybGlLZFREelR6Z1ZVL05yVnAvSWlJUi92NVFWRDZYSkhpVGdM?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1a70d7-40de-4341-e3c9-08ddca1839b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:39:15.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YouhN7s2+9a5jr5s9Ap1HLsfQlANo9VhVgd7KotpFe+MZGD2e0RZiQHvWckrffKT2AOxwGRpYUB+KMJmjdNmBsDvnZhUwtZhdnNt5rwLVDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9865


On 18/07/2025 22:53, Thomas Gleixner wrote:
> On Mon, Jul 14 2025 at 10:41, Wladislav Wiebe wrote:
>> This patch adds a mechanism to detect and warn about long-running IRQ
> # git grep 'This patch' Documentation/process/
>
> Also please read:
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
>
>> +static int __init irqhandler_duration_check_setup(char *arg)
>> +{
>> +     unsigned long val;
>> +     int ret;
>> +
>> +     if (!arg)
>> +             return 0;
>> +
>> +     ret = kstrtoul(arg, 0, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (val > 0) {
>> +             irqhandler_duration_threshold_us = val;
>> +             static_branch_enable(&irqhandler_duration_check_enabled);
>> +     } else {
>> +             pr_err("Invalid irqhandler.duration_warn_us setting (%lu)\n", val);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0;
>> +}
>> +early_param("irqhandler.duration_warn_us", irqhandler_duration_check_setup);
> Why early_param? Nothing cares about this during early boot.
>
>> +static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
>> +                                           struct irqaction *action)
>> +{
>> +     u64 delta_us = (local_clock() - ts_start) >> 10;
> Lacks a comment that this is an intentional approximation.
>
>> +     if (unlikely(delta_us > irqhandler_duration_threshold_us)) {
>> +             pr_warn_ratelimited("[CPU%d] long duration on IRQ[%u:%ps], took: %llu us\n",
>> +                     smp_processor_id(), irq, action->handler, delta_us);
> Please align the arguments in the second line properly.
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#line-breaks
>
>> +     }
>> +}
>> +
>>  irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>>  {
>>       irqreturn_t retval = IRQ_NONE;
>> @@ -146,6 +184,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>>
>>       for_each_action_of_desc(desc, action) {
>>               irqreturn_t res;
>> +             u64 ts_start;
> This wants to be in the if() branch where it is actually used.
>
>>               /*
>>                * If this IRQ would be threaded under force_irqthreads, mark it so.
>> @@ -155,7 +194,14 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
>>                       lockdep_hardirq_threaded();
>>
>>               trace_irq_handler_entry(irq, action);
>> -             res = action->handler(irq, action->dev_id);
>> +
>> +             if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
>> +                     ts_start = local_clock();
>> +                     res = action->handler(irq, action->dev_id);
>> +                     irqhandler_duration_check(ts_start, irq, action);
>> +             } else
>> +                     res = action->handler(irq, action->dev_id);
>> +
> Even if not required by C, the else clause wants brackets too for
> symmetry.
>
>         if (foo)
>                 bar();
>         else
>                 baz();
>
> parses perfectly fine.
>
>         if (foo) {
>                 do_stuff();
>                 bar();
>         } else
>                 baz();
>
> is asymmetrical and disturbs the reading flow, which is pattern
> based. The extra brackets just make it easier to parse:
>
>         if (foo) {
>                 do_stuff();
>                 bar();
>         } else {
>                 baz();
>         }
>
> See?
>
> Thanks,
>
>         tglx

Thanks for further comments, I've addressed them in v3:
https://lore.kernel.org/lkml/20250723182836.1177-1-wladislav.wiebe@nokia.com/
- W.W.


