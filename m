Return-Path: <linux-kernel+bounces-828683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A851DB95302
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912DC1893BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513231FEC5;
	Tue, 23 Sep 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JUlSIIiX"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588026738C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618834; cv=fail; b=JF3DVVtUlUMPT9FQkXw5yTzCit7k0rX909i42GPkuEh+H9VWl04VPOz/O90a631EPR+PHK1oeRnKnUHHy9cz6bBIf/+8jQslgofPxesKI16psXdrVQwOpWu8y5YvWyCXbDNrrYAoCoa339ykQsKwiSaGG8JSA9u68aE0w+UToxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618834; c=relaxed/simple;
	bh=kPemT+8tKwEpBxb8TH7L2X7CvhYmOF/X9q2c9J6w0yQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DueZwXv3j5ocIADPNpyjrTO9sM3IplJ9IfOAogBBYgBoSkoi+4X7LgAGX1UhpwPeY2Yi9fewwKoUnNcQjNY+X6zPrxUpLtV+QwaSmtINvaCIxPFjE8jVUFegeq8gLleM0VH9rDjJYfsSiQUYKg1EIHuhsyCzsWyDZoUvUtFgVfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JUlSIIiX; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucfyZBPdi8a9N7BSYVsgByC080ME4UnrXJaNMyTYX+zCsyiqm0E5e7vNow5M6HFaGysOvH/3gbsfK+sA98r/VgGya4mNWgYiUD1s7b0nUUDdcWE+R0H++Cws7o+koA3+BhXrioZKlHPFxaNzEiqYhV+ZfCq3Zts9IEdgHW3XpYjTZ0XvvYHrUl6I2mGGGXUkPjd7Qyp5wM0faf9E9jlQRxCquU86niav4fodpycXqJFOr8NC4QlmdWcKa3M93dYW3pFjMO+eUteQ8g1WhUxxGzQOnd4F0VupVLcrzIme4h3Fh0TmUD5VtAOAZ88mz6iMph02AWDVuxWUOVLuwnfJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeksD3g/oFcW4irEoZhbSc0RdB6Zj473qZj7Uq1LQ3k=;
 b=xAKQcVre9ZnSq6G55Rb2LkHzfJCVSfTRpqQCn+XbXeQ95jB7pW+fFQH8uMWr2T34VzElcMZE3ZG4g9Gkmk+V2lnvkQc5lqvVG6BMrzkfbnBiO/6Lf9NT95XqxTLZsYaTvLBRPa2jiJU8m9AfVjg1s2HhUNeTjLYqa/JkDrM3WVoGwiXBodVZ548GtnNlfr5H1wZt0J5jcxALRrg1sAUSOXzRSVu3+VyOGFtVa4fqlfsV2OBsnHXfiRKd0hWNSuDufwqmzJPzvx36Is23lGK1UwjaeE/5j1jyA605GzjC3lr5NNa7gMpVgigTP1gMLxXxvYa2wpqd84pWviMgJX7OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeksD3g/oFcW4irEoZhbSc0RdB6Zj473qZj7Uq1LQ3k=;
 b=JUlSIIiXI2JQ0+kDVKctc4uuBijsxQeT01f8m7TSGDexFRt24nY+B0iK1XKPZZXScUbcYuK6R7jOH2xXI7om6DdShg9BeWWA8Rlf1mh2f0V0/KSkNm6j/rLASxcm57CruUi+pZ6LTvWWnG6bis0i842HLEqr8oE8n7xmf6antrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 09:13:48 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 09:13:47 +0000
Message-ID: <d3c0edba-10e0-4335-8b62-0a2f35b686e5@amd.com>
Date: Tue, 23 Sep 2025 14:43:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/16] mm: memory: support clearing page ranges
To: Raghavendra K T <rkodsara@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 willy@infradead.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-14-ankur.a.arora@oracle.com>
 <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
 <02da5912-b77e-42fa-be1c-d10c915730d2@amd.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <02da5912-b77e-42fa-be1c-d10c915730d2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0112.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::7) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c0c128-49ee-4f45-e59f-08ddfa81805e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGhlTXFueW1MeDFyWUVWRE5OTXpmanpJenZ5UzVSRldPbHU1bUFEQWtwRjkw?=
 =?utf-8?B?bHZKT25vK3A1ckVJYWc2QXRtMDdreHZiZ1hqUEp1OEY2RkprcmpGMDRoRGxZ?=
 =?utf-8?B?K0ZPRWFmbFlRTVgwbFd5MUtXbVVTTTBTYkFqZUZ4S1FzM0Z2WG42czYyK3dP?=
 =?utf-8?B?czg1aVo3WXV1TUNYTUl5YlNad09Md2VmVncxWDZYN0kwT0NxTkIwbFQxem8x?=
 =?utf-8?B?cFZwclNFeTJwUEFnOElSbTJFMC9qd2FzWG01MUJCcUNNOFJiN01VekNVZ01o?=
 =?utf-8?B?Q3YzUlM0cW9jNjBYZTUxeFBpYTA4T0pWMDRGcndQdlVNcndsRFRJOFhUNVdt?=
 =?utf-8?B?L2JGRTNmUTVyWmlUVHJFQVdaaUNlQkcrMUFoM0lpY2lsQTZvZGZDTWdqTGcv?=
 =?utf-8?B?ZThsTXZ4R045MUJCREZjeG1BYTRVZzlLVnF2eVM1eW0zY1R0bnFaTGYrSDRS?=
 =?utf-8?B?bVpTdXp1dFhOMUVhTHVpN0dWUjBmSUFIMTFyKzh0amJFd0R5NHdSVG9VSTVi?=
 =?utf-8?B?OVdmQjRmVzlqSVFYWEUvMGRTd24wd2ZQaVFmdnJuaVo2a2pmL0xpOEowcitD?=
 =?utf-8?B?REZNV1owMmN5VUNXR0FZYU5DRG5LbkYzQ2tqdDN2b3RhUjhId2x1eFVpYU1a?=
 =?utf-8?B?NlJvc3dsa1BjbktKTVRycTM5VlM5b3VVMGJqazdOekttY0xsd2tPV3kwazhY?=
 =?utf-8?B?b1BCeURIeC9PK0w5QVdOVGpKWXVpNHJac0ZQUUFCZG50MUtWcXBvRXJudXJy?=
 =?utf-8?B?Z0w2U2EvYWJKMmgrMjZHaWNWVzZ3MXJTMHlQN0s2NTcrcjNHdlp0TGxOQllM?=
 =?utf-8?B?cm9KNSt5N05ScWU0NG40eHJDaExYMVgzQjVxQmVYMSs1TUhNelpTOWFNRkIx?=
 =?utf-8?B?eXI2cHdYVEFWTzd0R1NneGd6U29sTisvdFlRcFJqUEJ1SU5lZjNtNDhWdTlC?=
 =?utf-8?B?UVphQmhPbGpRNmNhVlZFT1Y1eHJjTkFWZk5iTGljTDh2UmFvM0ZKaHpaaGJE?=
 =?utf-8?B?T2pJVVNyNDVGaVE1QXZJUjg0L05vZkJ1YXQvVmUyRTcrWTRtRi9rSkFrbnpX?=
 =?utf-8?B?eWJTWVRwQWlvUE43b1Mrb2hsdEMxdlhhY1FSYkpnc2NtYVRxOVM4S3BjRGJh?=
 =?utf-8?B?NlNJamdMbkJFUm1ydmt6blNjYzNBWmtYZDdjT0lRVytUVWJ0UXF5Z0FJMFJ0?=
 =?utf-8?B?TDZ2d3c1L0E3RVhReUdxVlNRMU4rMzhaQm82Y3UyQVErVkUydENXbWRpU3kz?=
 =?utf-8?B?NCt6ZmNBQWhMSDdPV3J2SHVtYUVmS1FmdTd4TW5FUEtzUDAyYVB1ZDNLTUZi?=
 =?utf-8?B?QlBzRjNRYlBITFlyVUJEV2pEci91VHlvY3BTRGdEN2FnL2JnY0J2dVNCZmcv?=
 =?utf-8?B?c1RlQ01mcHg1RE1OQlFIWlNvYTRQcERNbStrRXlacHpSZFZwQUNhcGFSTWFu?=
 =?utf-8?B?NmtOaGJ2TzFpSnNYWUJ2Yy9rcHlhYzU1bFBxaXhpQXozRlpaSUp5bzJvWGpz?=
 =?utf-8?B?cVJ5TlQ1Rlg3OCt6UnhReHJCTCtxVXBlS1BUemtOUVVJZzV2ay9uSDYxYVA5?=
 =?utf-8?B?WFhGWUZvdHR3VkxuZkRpT2NPbEJ4UHlPaEhhOXNzTGFOOGU0aWl6T04wZEdK?=
 =?utf-8?B?Z1dpd1ZSeHNOaUJBTy91WENLTU9MUmZoekZqQWFiYy8xcEY0VTBIYnpQT0gz?=
 =?utf-8?B?OVVqSlN3dmI2WmUwbUkyMnhNZWh1UVluRGR4Nm9Kd2hsM1Vtb3RUdE9jcjBn?=
 =?utf-8?B?TGQyMVMzek8zNTZqSGRra2c2RDdEOUpVT1NOeWtEb2JrRUdURFdTSTZXSkxT?=
 =?utf-8?B?NVh4elVqWlpLdHpyVUtNYW4zaTRWM0ZMZGlUM0RyZmtoNGpSQmdyamZ6d0Vp?=
 =?utf-8?B?NDZjRU4yZVhjYWpRODhmSFRiT2RyT2p6aGttMEFXMDBtSkxMZ1dZNFNlcG9j?=
 =?utf-8?Q?ekdpt7qe1yY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnJZL3FmQk9VbGZFdWdZSm1sNG9SYXNSNlpKcDZsT0FPeko0a3dzQldYMFJl?=
 =?utf-8?B?elNUMDREbjUvQjkzaFpSYWNCcEEwSHovbE5Hc05Pam8zM0hJT3d0b2ZKWGkw?=
 =?utf-8?B?RWo4RkJ4WHVQSFFZZ0VZRGZPL2hvM1NjNGhHOFlsVVJ0dzJPNHh2SEV0VlRQ?=
 =?utf-8?B?eExUMGYwVHlKMnpNY0lUaXozQ0szUStTY3JlZUVRNFZFWUcwZjNPNXpPZ0NU?=
 =?utf-8?B?WThoK0liQVNoS1daZzNNcVFNRmtvVnBLVXNyWUM3b3cxYmh2cGNER1djRWZ2?=
 =?utf-8?B?NCtvRDFGVFRlYndnMUp0ZFlIMHRVM3FxUFpObVZHUFArazA0Q0Y1K3ZKRFZp?=
 =?utf-8?B?UlFtL1BsSEFEVDdxb0hTc2R1QzgwNEJoZXczS2FPeFI3ZzQyNlBqMFRaODFr?=
 =?utf-8?B?WXlENjdlUDhKYlJZVnM5TVRSRWViNTJBZi83NmRtaitXVjdISGdvdTRwTElT?=
 =?utf-8?B?QVR4TWJBL3BqSVgwU2xROTVyZVJUTVU3bHUrT0JFby90cHNRbEdxc2xkSGZy?=
 =?utf-8?B?WjJBWWxhWWhQbkxnTVhPdU1zZm0rYjMxRkNtY28zaTk1VzBpUzNyWmlraGli?=
 =?utf-8?B?cjg4SkRRYzkvR2lHRFNYYjdyRFJpSmtKL0FyaW84VkFrZFNpSS9SN2pZbkgx?=
 =?utf-8?B?NzFGdkVYTlRWWSsra2hPMEJ0a3orWU1aRlBseTU4N1pkdmZLNDlPa1l4L0tL?=
 =?utf-8?B?ckxHeThHclQyYjlRSTJkcW43LzFFT21rdFA0V1B6NHNrczc2NXJDS0JrcVlQ?=
 =?utf-8?B?RTZaMlI5YmR4Z2NIVFlFR0JiL2tIMUkyelZNK3Z6UWVjV09zcnM0V0tGS2Zn?=
 =?utf-8?B?Um9jUnZXTXd6TlVLZmp0TlpSSVpMYlcra2oraGU3Z1FvTUkwcjZvSVMyaS9M?=
 =?utf-8?B?dGtKUXJrZVErNml6TS81RE90UWNCem0yTkdLM1BLZkwyR3JxKzZPTXlDMDBy?=
 =?utf-8?B?Qng1Q3o0OW1URXg3RDc1OHBJdzQ4empVZEZ4dEp0ZFl0dWNweFdaTlFTSGdD?=
 =?utf-8?B?SjEzaFIxaGlmVFkzNW1PWGdSdmR5aGZnZnlDTmMxMlN6bVZRVjFFMFNqQ0pI?=
 =?utf-8?B?bWNKcWNWYUdBK0ZMQ0xoTnhqYXQvQ1duRnNPaGo5Q0FSVkRMdnR0MVR1Qll4?=
 =?utf-8?B?clJUcmlXbHJTR2JqbjFSR09jSXFaSDJwckc3T0EvSExwNDVBU3dhbk1zZ0pE?=
 =?utf-8?B?OVFtME1Udk95cE5Uay93YXYzWHorNkJsOVlhVVIvdG5FblpKTG5UcVJGSnVm?=
 =?utf-8?B?RDNuZ0RNaWk1VUxvM2Q2UTluQWlKYTR5cVJPMGI1YjNxNTRwRUZZL1g4Vnox?=
 =?utf-8?B?MUN0ZXFuNzlyM29HMWZDU1liYTNrUDRxZFlQNnlkRDY4MGpPZTlPN3Z2MExY?=
 =?utf-8?B?WEI5YXprV2Z6RGJiclAzZ1NPcDEwVlBjSUh5eTF3RUdweGpVeVFCZjVaMjha?=
 =?utf-8?B?c3U5bVpsaW1Ic3RTYzN3QzlkYWZCamI5TDg2c3hSMHFmM1h5VkxhQ1NBY3ZX?=
 =?utf-8?B?Z3pNcmZXQXRDYWprN29ZcFVDdmtveGhtbE82OTRIWW5tdDE5amlScnhHaUVi?=
 =?utf-8?B?dUNPMVhkZ2hTY2NkeTNRTVBaaUhPVFpsK0Z3U2xkeUN5c0hMYkxYbkJLQTZ1?=
 =?utf-8?B?ckFTditOaFJJdW1Fbk1Fc21PRXJ0WWRoaTZWRGY1UlJBbDAyOU9yOXMxSW5s?=
 =?utf-8?B?YmhWMWRlZDQ3NmhRVGFxSmVKMXJQT3oza29GWkxMUXRWUEthdjJtOXZxSEt2?=
 =?utf-8?B?b3pQRTJCMGpTTEdUUnNKcjI5UzI5ckpPYWo5Ymp4WmMzWXBrY1dvem5iVG8x?=
 =?utf-8?B?Yno3RVpUS3p4RS8vNkNBaHJXUVFjV3NHQm9CNWVtQS91emlYdk5pdkZWa0pG?=
 =?utf-8?B?T2I3UjJuaXNpRTREOGFrejhBS1EvbXZWVHhYT09VYUdxNnJVT3JkZVBOS2pW?=
 =?utf-8?B?dHhYaTRXMlFDYXFDMjdvSklQZC9vVHpOREhldFVqZzNRQzRnSHhNeWU1QTBB?=
 =?utf-8?B?SGhUcis5ZVQrWHIvMGtWY0tBQlUzdmdaaGVUSmIxaWdaVFh5UFFhMnpIQjRN?=
 =?utf-8?B?TmJNc1VQcEk5bGJ0MjhtMEFpTi9QdWNMSlRoaXhQR2hCWG13eElmZVFwQVdP?=
 =?utf-8?Q?XO5fV59actl+9rzAX4TBqJF1d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c0c128-49ee-4f45-e59f-08ddfa81805e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:13:47.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqnqXDs8WGIb2zlzEDaFpLN01KdM3emW+cWvGRfdFcernw1tdeGcbony5vtrDpjwloYC6deOb+20IsnlYt/lEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151

On 9/23/2025 2:06 PM, Raghavendra K T wrote:
> 
> 
> On 9/18/2025 3:14 AM, Andrew Morton wrote:
>> On Wed, 17 Sep 2025 08:24:15 -0700 Ankur Arora 
>> <ankur.a.arora@oracle.com> wrote:
>>
>>> Change folio_zero_user() to clear contiguous page ranges instead of
>>> clearing using the current page-at-a-time approach. Exposing the largest
>>> feasible length can be useful in enabling processors to optimize based
>>> on extent.
>>
>> This patch is something which MM developers might care to take a closer
>> look at.
>>
>>> However, clearing in large chunks can have two problems:
>>>
>>>   - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>>     (larger folios don't have any expectation of cache locality).
>>>
>>>   - preemption latency when clearing large folios.
>>>
>>> Handle the first by splitting the clearing in three parts: the
>>> faulting page and its immediate locality, its left and right
>>> regions; with the local neighbourhood cleared last.
>>
>> Has this optimization been shown to be beneficial?
>>
>> If so, are you able to share some measurements?
>>
>> If not, maybe it should be removed?
>>
> 
> I reverted the effect of this patch by hard coding
> 
> #define PAGE_CONTIG_NR 1
> 
> I see that benefit for voluntary kernel is lost without this change
> 
> (for rep stosb)
> 
> with PAGE_CONTIG_NR equivalent to 8MB
> 
> Preempt mode: voluntary
> 
> # Running 'mem/mmap' benchmark:
> # function 'demand' (Demand loaded mmap())
> # Copying 64GB bytes ...
> 
>        34.533414 GB/sec
> 
> 
> with PAGE_CONTIG_NR equivalent to 4KB
> 
> # Running 'mem/mmap' benchmark:
> # function 'demand' (Demand loaded mmap())
> # Copying 64GB bytes ...
> 
>        20.766059 GB/sec
> 
> For now (barring David's recommendations),
> feel free to add
> 
> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
> 
> 

My reply was more towards the benefits of clearing multiple pages
for non-preempt and voluntary kernel, than the effect of clearing
neighborhood range at the end.

Sorry if that was confusing :)


