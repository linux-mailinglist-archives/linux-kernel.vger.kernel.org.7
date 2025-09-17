Return-Path: <linux-kernel+bounces-821207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B7B80BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355E917CAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFD3090EC;
	Wed, 17 Sep 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wIiwHUWQ"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2634137C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123982; cv=fail; b=pRwDzzNR/4YrqgAKcFxffyL1fMeGSnEr+K/sL+hwN8QnxOdH8RsBmHm7fwfJBmqS7MKVcG2TdowwosVvpNUzIwTzfQ6/0LCrs0fBCQftcaJ79aB0yS7jMf6YlpUx3Euper92JwJ/0KxrbA/tn9esQAYgKARtJDmcfuQKxmXoI44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123982; c=relaxed/simple;
	bh=FvCxmh0z+BIFHQdp7Cx7Kkv9W5VHL0ncsD8Ic/kNUuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P9XXJxdwtJPGUDUiUQUxhlQr4jzP/Rbhgd1k/sLGyL+DYl48w+HtlNr7/OEYkSxFwTamdoKUx02UnSt3y4k/EC4PaxoPn/3n5GYjHIMLHh/NM9/vInPBPsZzcH/f0KzKaufm4Z+4nx11VV9fe2VBpsB+9lTDcNRpAv0FWdj3Pfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wIiwHUWQ; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeCtE92JyHBgf8LJZmQggCnxxXbsHPzwPuZzMHNh+O6KDouIbjfRqYjvU7SukhSvkfhV8BCiNb4mvcUm1rcnrEwKdWv1pgZAD1sgB8ZLZ5cBUpjzC6p4Gx/3HzExz5RURUVgVh0Vt1KtIIYP4h0Ac9d3cQP7lm57j9TqsbsgWqZYVmPtNotJYXrvo9w3+ZJJnHDd9lEZquuMzHyPHo20l8OtcEOVgaDk8bGH2BYTqVSga0hDlPMkadpjtVk0tNyd252CzLH8w1BOuQ9+IIW5ruPpyTfOEGbd/TcdDnhWLJZuMKaoTRAOHU9xhOn5v42CP7uPGD8XE8Coco/c9L7IIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SfvoezLiwe8KWUzROFcxKRD0yH3lENnqg2fHzCXwfM=;
 b=ZaTLxHyg2LmXKN6/bCFxyuJeTgEknSA70aACQ3uJQDt8QEeGTJ4R05p3RciDQsQCpfDN4cphavdhyHaG/yg6W+DJCIeZd7wGXwyOlM6rR6hmjP+UrePrHDqOqL5Ws1Eox0OkI2wCV9Jz7Zs9t1ewd1Y7xh9FvDJPjMbjB7xRMpq1q4DpyQtf9u6EmIrTc7SWvtfIua/dwn8q5jxn7LSAeqdyI7Jm+nD9nj5a8npnJfHo0zvkrPz+YRj9HkodRlsxkXbYhArZosMF0LNwU5neutd+b9gMwOKUlQYbBozrz/cFHEC8htzSOtyAIvGqvkIGPCyZR+Z5ApJ4Css4Hr64+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SfvoezLiwe8KWUzROFcxKRD0yH3lENnqg2fHzCXwfM=;
 b=wIiwHUWQ6vwkpDlg2GcCtPUwUViiGibefTjfCX3xQnZ9D0KJ2KdonqIJpSMNi/9eef2pFp7rMQ74Cx4qunYVHASFC9mgXCzargHMf5E2VB7/15nVBrt6gW+Pq7MjD7MKZLcvtNgA7QXnOs/AVZMPSDF/9tJe/VYUDK5WQcCq/yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 15:46:17 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 15:46:16 +0000
Message-ID: <fdf330e2-c47d-480f-8a8f-09e73d454d83@amd.com>
Date: Wed, 17 Sep 2025 08:46:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_fwctl: Replace kzalloc + copy_from_user with
 memdup_user in pdsfc_fw_rpc
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Brett Creeley <brett.creeley@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org
References: <20250917150941.168887-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250917150941.168887-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 930adeeb-94c5-427c-2bb6-08ddf60156b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0YzbVgwbEVXQy9YK0xJSUlTZ0V0bjBVZnExNjBWdzE3MVIvUmY5Q3ZrV2Vr?=
 =?utf-8?B?OHRTSSthemwvU2xVK25YMlV4NExYK1VYc2JpVVg4TWwxQ0MxV3NnU2puWXJr?=
 =?utf-8?B?K2NVWloxb1g3QW45ajBaNC9Od3VWS09pU1A1YVJXaWFFbjc4OCsxZllvbFN5?=
 =?utf-8?B?YUVtVm5nUnY2Um1Jb1N3RXVJODdYbFBxU0dpTDJVcDdFWSszbGoyaW5IQnZs?=
 =?utf-8?B?NWl5TTJiREMwZGJwMW5qN3VjTGZjeW5qczc2c0k1TzIrTUtQTHZVbG8xZ2Fz?=
 =?utf-8?B?ZStvSlQwSVFiVHRyL3ZJZ3BDMTRtMzJpcjVGM0VQeThxL0R4bHFsZkMxN1ZL?=
 =?utf-8?B?cWNlbU9nQXVJSUdaS29IUDhFbVB3Qk1EZXdwWDk4ZTZsbWNYVlBBQk5XOWNY?=
 =?utf-8?B?K0djYTNKV2EvLzA0Q3FzU2tZNjRQQWJvRUpHM3JBNCtZbllsSlBjMVlySW9D?=
 =?utf-8?B?aDk3S2wvNDkzMXlQS3A3WEh0RXcrb215ZHk3K3FaWHBCU2ZnVkRtak1LTVNn?=
 =?utf-8?B?cmhHMjBsYmlxNGRrNHo0VUNjekhRWnQ1cTR6elhHTnc2eTg2Yzk5NW9PZ1V6?=
 =?utf-8?B?MXF4ZmY3N0t1akZFeDlNS0I1ZkxjakVRYXMvTlVaME9nVjFOT2VUem1hRTQw?=
 =?utf-8?B?SjMxcHIwbzc4ekJ2ekxkejJmVG1KUDF1MExSVkIrM1dYMjhoaUNyQjdJcHI4?=
 =?utf-8?B?VDIrdW5vdU82WXdLRkJGRzB2YUUwQ1Via1VibC9tdmNXY1BBbElpaWFrOWtZ?=
 =?utf-8?B?Y2Y5U1lTQlIxSmR6QVk1TTdZYkZIYmRwRW9DOCswZ2c4OHdLN2N6eUNxSzBC?=
 =?utf-8?B?REVyMHNVazNNV2ttSGdpTkQwWWZNTW5rZG9WbGlBdm9IWFVNTkt0cW11bVI5?=
 =?utf-8?B?TWNqcVgzK0VJdUx2MFliWG9nY2JRZUpLN1A2alRqNnJCWnE3V3BTcG9qNmRv?=
 =?utf-8?B?TkhQUDdWeTYwK0NvQTYwVXpyamsvbHNuZnhJczB6eDh0eTBWYmQ1VndpZVNE?=
 =?utf-8?B?bHZsWTA0eFR2SmpPbGNPZWFsTFVZT0VFdDdIMHhraG5UVU5RQlJHcDV2bEdV?=
 =?utf-8?B?b1FLTFZCYzBzZXNVQ09XWll2S3ZUc09HbFFTbXVjZ0FWK2l1U1ZvYUlneHF6?=
 =?utf-8?B?b0NQd0Z6QmN5eStWdTgwM0dSYXZ1YkRERE9KK09USVFaWXBLTDZqUWdlWXlv?=
 =?utf-8?B?UytUb2w1VUE0Qzh4dDJodEFxTG9BUHBnYnZDQUZXNmxaNGNLc0pscXIyN0tY?=
 =?utf-8?B?ZlZYRXVqOUMzWjg4eVEvbS9pVU9aNXNGMXZPYjdTdE1WNmxtSjVUNlU1WWlu?=
 =?utf-8?B?VXFTM0N0V0N1blUzLytPWGlhZVZOLzNvM0h2NE1pUEkzMFc0anBDQjZjMzFE?=
 =?utf-8?B?STd4L21vSFJIMzNPVUxsK2ZOS1NiWm9CQU9BTUhjV25QV3h4MGdwUlNlSi9y?=
 =?utf-8?B?VFdFZGJHSzdYN3M5OVJhcDhmdmNDZ005QlJnWHcrUVdBdWJhNDFkTWlVd1J1?=
 =?utf-8?B?ZU5hVUY3aXhnMXFiTXBPNHptNHBPVFRTeENzTGdlQ082REc5TXRxeFdqeDk5?=
 =?utf-8?B?bXZYaXBPbVNzaW1UNjFrNXVBbjhLVDRiRmo3MGZhWXZYdUtUR2EvZktMSDRS?=
 =?utf-8?B?dUtOTm1kcTV1SDRzQWN6bzU3SHNBQWJZYXhKbFN2dHpLb2JvbGJEY043WlNi?=
 =?utf-8?B?QjAxK3VqTU9BaWZYTGpGMVZZMWE4aVRES1N0V21zeW8xVVpzK2tzSlVNNVFs?=
 =?utf-8?B?bWF4K3g4OWpZOTVHQS9QcE1mWVViV2E0Q0o5Ti9ia05Qayt5bTJwZGppWjVV?=
 =?utf-8?B?M0xUZUtvOWlEWXNoWWJONlJMbkJlRi96MWQ2S0tKNXdSdGpjUVlkUnlwdTEx?=
 =?utf-8?B?b3ZhZzBMWmh5N1JweWZHYVM1b0tSVFpIOVlSdTFqV1dmakNHQUJQbHFRVjBW?=
 =?utf-8?Q?9x9c2YViO+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9lMHQrdnlDaVBJbnIrYXM2Z1VxL3lwa3RpSFBZYkV4UnZTSkN6ZDAvbkEz?=
 =?utf-8?B?SzVSVGRRbWdFOTVMYUtGMU1rOUVkVjY0bVRlKzFpS20rbERKblZJQjFQYXJT?=
 =?utf-8?B?NkxtMVVHV0liekNIa0I5TkkxWlRLRDltRUtTYWJCL25zR1M0Tm1hZ0M5T3Fy?=
 =?utf-8?B?OVlIRmdFOWZpejZ3Qy9UNklHZDlzNU4zeXY5RmxRR2pQVnhTWGpwSlRCR2Vq?=
 =?utf-8?B?SFoyTUtUMlNQOHp0VEg4V3B5TE1BTUlpSVdOblloaGtxWGJsODVjYkJVVEVh?=
 =?utf-8?B?VmVGMzJXeWVtZEFCbkF2bmR0RDFJb0tGcDYveE5OZ1NxdFZjY2FqSDVyMm5u?=
 =?utf-8?B?NnhKTXZTa1ZUeUx6YzhZaTNwSWZXa283QkJucFMrekhqZGluUzRSVlZSd0Zw?=
 =?utf-8?B?bUZOUHNOK3Q1VDFyUldyNHVRN2Vib3YzeTVicU5oaEdJai9CbHZFc3J2RmhJ?=
 =?utf-8?B?cmo5SGY5VGVuYit2LzF4VjdaT2NpT2Jjc29rSGx6aFJiR2hvM1E5NUIrbmtV?=
 =?utf-8?B?TEFHTnRiWGlxamhTc0NXYjJjdGJhRHNGQ1BwM1drTFVyQnNsN3MzdjlRdk1D?=
 =?utf-8?B?dXJhbzdzUkk1b2wwWldBcWNmMDdiSmF1QXZ4RmFhNGE1UDFlbFpJcHljV0VQ?=
 =?utf-8?B?Z2lFNTNHV2RSVXh1V0I4ZUVobkhVWXdjUFg5VXI3VmNVdExBYTBEWVZYN0lX?=
 =?utf-8?B?M3dhQ0JVeVZaSGJ6RXNzZkptSThjUk9xQjJDTkhqWVZLMmp1bFQ3OGFwSEU2?=
 =?utf-8?B?eFQ1WU5YL1RvcC9rU3BHUGlZTFBhYVByYUpYNXJPL3pxRXh0OXdvVzhoN3lQ?=
 =?utf-8?B?NkRxTmtxV1FZK0hyLzFvN1Z3WWFIV3JsbDhUald5QVpDZy9yb3p0UjUxTjEx?=
 =?utf-8?B?N09KalhocXdnZjNieGt0TkZVbjZFRmlOdDdXc2xTU1prU1R0SFZ1ajBKbU91?=
 =?utf-8?B?Rjg3YkNtb0d0UzEyUUxNcmdlN0E3cDhXZDlqQ3RLcWVsK21VRCtiK0IwL2xq?=
 =?utf-8?B?NDdka0Jpa0dIY2syYVdSeWVSR01ZajVCMWRyalpXSlFPbTBMS0RBM2p3UGJS?=
 =?utf-8?B?Sm1OY0FOem15TUR6NWJHYTRYRUZqOGhwM3M2SDBoVG9zamlldmZ5VHZDeE1H?=
 =?utf-8?B?RGs4VEpBYm1FaTVVUFYwZTF6TEhWczVvalJ2NjdqaVdFb2ZwTDhLMlRrL0pU?=
 =?utf-8?B?dmJmRWJyaTh0TFJqelBtcExkQXNVNXFmRDM1TjVnQWw2TGNEVGVnOVdWZFFl?=
 =?utf-8?B?RzNQOFF1d1ZIRWhUd3NCV2kxc1U4L0FpWTZOVlhmVzRMa21mcytUTzJ2Wklv?=
 =?utf-8?B?dTJHa3JoSG0zQmxFQlJ0NnhXaGxZcEpWQmZJZXUyY25sK2JHNS9ZYnRoa0pw?=
 =?utf-8?B?cXM2K21iK2pRVGxpM2ZrRkpiZ3FZd2lxYUJBMk5uZFFCL1VHR3JBVWhETFZW?=
 =?utf-8?B?VnJCZkdmVit6UXJiekJVMDBVT0g0YjI4dndoRzdkcTNEZUxCTFBqczhNZDFL?=
 =?utf-8?B?MDFVUHQ0WXVza256Q0hKK095dWxscWV2OEpkSXVSMlhEcm5ndlpEZ0dFSUdm?=
 =?utf-8?B?MjlYUnBiMWUzYzV6M3NJS25HUHJkWklRcE02VC9WN25uajNTbnhEdzdoZHBX?=
 =?utf-8?B?aHQ2cSszTm1GZTYyL01UODNycWlHNzJyS043bDRSVURPaisxemI1YzZtT0k4?=
 =?utf-8?B?NzZpd0lXS2o5ZFJLMTBJR1R1RVcyYUpaYWo4emczQ01hcy85SWkxV0p5czhL?=
 =?utf-8?B?TGxONTJXS0tiZDVEYkZwUTVxOG1BdS9xU05mMVQyM0dpUW5hZ1QzMHBpaytk?=
 =?utf-8?B?Ny9Lc2JPc2tGTkpVcER0OHZDVjZjcW5tM29tbkx5RGEyL1JYbDNabWtjbGZh?=
 =?utf-8?B?YjdFaDg4Ly9iR3VwMGJ6d1ZFN1BrUmNLTW5aclRVcm96dHF2b0tvTzlSaTUz?=
 =?utf-8?B?VmRCMjhzaU52SzFxZElsK0lHcmFVT29QbWc0UXRISmdNMXo4T2JaeUc5U2NY?=
 =?utf-8?B?aGExVzdyLzJtWVowOTdHdmJFWGxMalFDcWFOeFNPNzJ3MTkrbkZNOTJ1OVNR?=
 =?utf-8?B?aXdUYlFVbUlJZnVPell2UXg3cCt1WDZuN25DRHY3SlJ6RkJSWUYvWG5xTmZh?=
 =?utf-8?Q?Jiitb0vVuOFdjRpX3xE9NLuMB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930adeeb-94c5-427c-2bb6-08ddf60156b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:46:16.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO2/iHPzkIsp/3wEpO9A9ORvVYT/CR6K9RwZ1RO3VuWsf1PtxT2Pcwjh/pfh7qSs1EBZDqBmoovadaWzGF9iYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

On 9/17/2025 8:09 AM, Thorsten Blum wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify pdsfc_fw_rpc().
> 
> Return early if an error occurs and remove the obsolete 'err_out' label.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/fwctl/pds/main.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

Thanks for the patch.

Tested-by: Brett Creeley <brett.creeley@amd.com>

> 
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 9b9d1f6b5556..04d84f892fb8 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -6,6 +6,7 @@
>   #include <linux/pci.h>
>   #include <linux/vmalloc.h>
>   #include <linux/bitfield.h>
> +#include <linux/string.h>
> 
>   #include <uapi/fwctl/fwctl.h>
>   #include <uapi/fwctl/pds.h>
> @@ -366,18 +367,10 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>                  return ERR_PTR(err);
> 
>          if (rpc->in.len > 0) {
> -               in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
> -               if (!in_payload) {
> -                       dev_err(dev, "Failed to allocate in_payload\n");
> -                       err = -ENOMEM;
> -                       goto err_out;
> -               }
> -
> -               if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
> -                                  rpc->in.len)) {
> +               in_payload = memdup_user(u64_to_user_ptr(rpc->in.payload), rpc->in.len);
> +               if (IS_ERR(in_payload)) {
>                          dev_dbg(dev, "Failed to copy in_payload from user\n");
> -                       err = -EFAULT;
> -                       goto err_in_payload;
> +                       return in_payload;
>                  }
> 
>                  in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
> @@ -453,7 +446,6 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>                                   rpc->in.len, DMA_TO_DEVICE);
>   err_in_payload:
>          kfree(in_payload);
> -err_out:
>          if (err)
>                  return ERR_PTR(err);
> 
> --
> 2.51.0
> 

