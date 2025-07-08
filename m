Return-Path: <linux-kernel+bounces-721847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792CAFCE96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D50175D28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86F2DFF3F;
	Tue,  8 Jul 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AuPuVKHV"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543214883F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987379; cv=fail; b=gPd9QU3Kq6QhCGWbYT9JuaXJfVf6Xp1k/uwZWWVUhjaLgei4t7zR6moZRVz+/K0xPzWfyjZbB4+GFEBS5nJm4GtoFjkmGuYCMVShBAW12rKiB3o74MzQFyumqfbgfhUvG13/yXXgtrUY2RTGA1oTr5qyq42SixMq1mAvYKQjLGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987379; c=relaxed/simple;
	bh=HCv4UQz9aJX7I6GvjayG/VOKaSJrNlC7JmjbZPuaUoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzUEmHld2pLGRTbgK7ILi9VHzpm3ypSAMWCWmJbB682eystf70KeDuh5V8IXNvxEQtyF7VUmd2L6Mm09N6gLiaxGLvCopa4PzubCDunkUq0YGpXepGEXjSdU4MplRSnhgLZTn9WZttpTbJ54QQoZqeAa6caRHFq10xEsLjFtbVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AuPuVKHV; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 568EU0g8007184;
	Tue, 8 Jul 2025 08:09:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UdHJlGUBLSggD5/MogdjUqyn2UBeA3pUb6wmQEzBKVM=; b=AuPuVKHVDE5L
	+lqDtR5mfpED/bTQlxDw9htE6dhmHj/hNUnEcJ+k/64Sc2cJzFQzr9UDBvRP8DOY
	r7lTynykLGjF+dAXxq+Kz6tU5rhxVMPS4mfnHAMgvTo3lllW5HdqyTwXFW79Vdc/
	Jg8khSrTXtViEmtBcBJ/b7e+V/eTGD2RWZK1xGDJH/yq0sW9qyxmX+jD90hl6qMd
	amU0kJr0EbFSqfjBAI7gvje/sblBS8OHPtaitot6/uyP1rhu5YDQrZZiKu8ri+Mx
	e4nuY18QtwlTCFO0B7+4Vi4K16EPQ3m5AS6usxmNXm/CR4xQvHUoCuUPEu3Q24JN
	c/f2s60nOQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	by m0089730.ppops.net (PPS) with ESMTPS id 47s556gb3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 08:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbVU8WIBcXV6EOFLbtMtcES97PzZhPUCvC231oEbpp3a2ZZbqzUPuEIm7D7m0vpfFkOlompmVeb5pmLck9eNVcOG9FvK8aZ87UxC/5DDA581H1LqFCGrxJG5P3n0WWICa5LEKcUrw5R6P7wftyZiNgQGdTvA3ylz4ZAs/t0bmU117UiC14PRCAGfWCkHqD6hgsPl0amOCvgev2mDZax/S+smHXzdNRsGo7qHynIAKft+85nmLpLh73RkwtUvPzxIZOySysbh0E41IZskkj6VFDoDTn/a42hRj+ps9ClkpryREgldaB6ReAUII3vtIziHacKTV6E8HagMCLMj7IPZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdHJlGUBLSggD5/MogdjUqyn2UBeA3pUb6wmQEzBKVM=;
 b=DCD+WLXEDP/2ZxsumYSTKOVXjwctF72om051k8lhvl40tnUtypEp9gaT8DY+ZhX0aSKbrK0/uy0SFGomw0k+Zj+ikufTRj4DH/dbumFxKxQKN5wHIiDlenWvu4/LyLegdDSKlVg6IhAJBJCRvPuWfYyv4U8rbbL3ymdEBZtBZ1tCbrMEGa4z/nVyUYqTRnqfiA7TGXW5lDvQfFxhqpBfv+BZb+4P7kqxgOkc0Bn4Wp+APogCC2NG1c4vg/E54IQwkrEfd+PvwMRfEsVbk5nsC4MztR8tKVI6OU/kgydxqO7iq7OYJnCdSgkGsjreoBvtlEuRmyEgmF2Wo4B/ivTe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by IA0PPFDA375B65E.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b4a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 8 Jul
 2025 15:09:15 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:09:15 +0000
Message-ID: <21eb2e07-7ac9-42ef-a8f7-15a01a3c1629@meta.com>
Date: Tue, 8 Jul 2025 11:09:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|IA0PPFDA375B65E:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a8ac1f-a411-4eb0-11c3-08ddbe316768
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anh2NmRrdDhsVTlvTnNpTEJHYXg1K1hKbGJ3NTZ2UC9Xa3dCZThuWkVrY3Bz?=
 =?utf-8?B?Z3NnU3BNU2NXNEhRS01jTy8rY1cvTEJVcWJSeVBZc21JNFdveDI2OFZETzQv?=
 =?utf-8?B?NzA2V3hKV2xSUFp6VmIxazVmRDA0cDFuSGIxT2dKdVRCT21NOXFJL3pwYi8w?=
 =?utf-8?B?RVJ1NlRraURGNXY2ZWNFMWtNOWo0anNCYURvYlRydmFjYTZ5VnFTb3huRmdF?=
 =?utf-8?B?cFErQjY0WWI2V3FJUE5sZXZ2YmFtQmNWZzdId0VtUDZxdFpjS09TMnE2NUQ0?=
 =?utf-8?B?TUN1WGxtc09xY1J5UzN6ZUp3Q0QvdG1VMHJVcmtKWFFnK1FGbVhld0hVOFdt?=
 =?utf-8?B?VVQ1ckFTL2M5OEYxN3MvVmFVdFNMdmxxZnN2OFA0ZlZRK3Nsdm9GOVJHUGlR?=
 =?utf-8?B?SXB6RU5hcDRKMzhid1ZKOHlTUDh5dXVaNTZabmNGQml6Q0k1L3IwMmhaNDhr?=
 =?utf-8?B?TkhCaUk5NzBScnhYd09HRlhBdWNTcmxCMzhVaVhyeFlleDAzR01UYk5KM3pV?=
 =?utf-8?B?YWtNbW1XVSsxVitpTXB5alJGTE1rWFJsbTU2SkF0c0VTZm1lVE1UNFZjK1l4?=
 =?utf-8?B?c0xQbFZrNnZJNmN6WjlwUnJzc2hURWpnK3l6K09lSTlkaDBxSURxTEFMNlNV?=
 =?utf-8?B?cm9pclcrdXpyRkpYWlhQNDUvSEZqR1ZIRHVpRk45WThNNy9VbFZMTmpQWm43?=
 =?utf-8?B?L2prNUhHaFVIaGJzVFAzNzVDeTExdXRwS0wxc2tMR29BY0hoTFBPWXFPWWdH?=
 =?utf-8?B?RTkxWTVGSEcyQW44K1p4S2k0WEIzNEZ1YWY3MkU5UnlaKytyV0xEbEt2dUFi?=
 =?utf-8?B?TFBBM0R3RmxROGhRckl1SzNPK0MzQytLeWhRRUJKRGVRTEpmVjA2RXdpa0xH?=
 =?utf-8?B?eXBWZnQrbG8vVzZkWndGWTVkRHhVU1BLSDd2cE9CQzF2czROckJTTkJscFM5?=
 =?utf-8?B?VXYxc2Y1R3BaODAwQXhHR0w4SGt6Wjl0K2JaY2RHKzJCNU9BQi91VjlHZTVH?=
 =?utf-8?B?WnFkMlQ2Mis0cEttMlduYnpCS1FWeU52S2c1eTM2bjBUUGRycG1OR213SmVR?=
 =?utf-8?B?QVNIVGFBclhtWGpiSDhGck5ubVEvR09VbDNDSS80emEyRi80b2I0MGN0c09j?=
 =?utf-8?B?eEh3b1VhcXJuS3VBamhoMHl3bE9VMXEzQW9Gc0FTM2dXcmg3ZkVoRFhTK0gz?=
 =?utf-8?B?K1JDRFN5WDdYWW9sWGJtTWVDMDRaekJyZjVCOVo1MXJZWnJtR3MvaDhYN041?=
 =?utf-8?B?N29wWHNhY3FNNXJzQmZ2WnA2VzA1SDVuR1FlbUJQbStkUTl3MlM3aWJZQStp?=
 =?utf-8?B?dDdsV3FTZUxSNm5xM0s2UmdXQmlEYzlFT0hRSnpXN1dtZEx4dE1qb0o3K0E3?=
 =?utf-8?B?SVpJYi94NU1wZ3p5a0lHQjA4MVlkVFBRVFpwQWlRYnhZUXJMVGM2UVlDOEFD?=
 =?utf-8?B?R3dvdmhuSzkyZGpodDdUS291NFF3dVZuNzRtVlRhczhDV040dGs4Y2w1cGRy?=
 =?utf-8?B?YThXV3RUcFJma1RibWpOMG0vbnlJR0doRyt2V0RHaGRZSWg0QmQrcWRMZFNy?=
 =?utf-8?B?dDJxcjZjYnRJY1daTHBpOXk2NWxMdUNxWlRlL2tFVHFEVEdETzhNWlgxMjRB?=
 =?utf-8?B?OFZVcW9LVFFXQmQ3U0Fha2haY1NhdjIwbHJrci9DVjAvNVhhT0o5ejZrVzNi?=
 =?utf-8?B?Q0tXN2FUVFBlRFlFUWh4UmpNdnNxbUNQa01wQW5OdldmZ0F6VzFJQlphbnJD?=
 =?utf-8?B?NjRCL1JUNnAvQWVsY1MzazFPM2dFNkh0dHR6MDhsendSMUhPcjB1UFlsY2lt?=
 =?utf-8?B?cFN4WXI5WGlpYjdsbVFuN0xzVHR0NTZkdDJzMGFhamVKVnkxdFVqQnVhWWU0?=
 =?utf-8?B?czA4ak03bW85TklmTW5CdFBmOHhXZVRNakFCR2QvR2JsT083SFRNZ3c4UFhj?=
 =?utf-8?Q?JcNss+E1Kyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC9lNW5KcUZxcDBXejhIL25vVWhCUHJNZ1lmYmM1eWEyTi8yQklhRHJZM2ww?=
 =?utf-8?B?UXErL0dlVkpCdzdnZEdEYkt4RG1JSm4vdGwwQ1dPd1FHNSthaG9uUVJZUWNV?=
 =?utf-8?B?Z1ovazV1S1grZC81TnF5SE5NMDdiV1FjRWtXSUd6SFFkdW9jZDhoeHlUNmpk?=
 =?utf-8?B?T0JkQkxqOU43OWRrbWYwMFZodkJVV2F5QWk4Z3BwcHhCYlc2cTNaREZBZStV?=
 =?utf-8?B?OWE3bGtQRHd6YWFqUlI2SllLU1RrNXBTdXZ4aEcyNFErQzRTamQ2Q05OZUJp?=
 =?utf-8?B?Q2FUT3FVUExheXphMlpMZ1Z6UFhMNGhHczV2SGdXMlJRbHJ5WlZnckd0TWRy?=
 =?utf-8?B?Zm8rNWtpaW0xL1hSb29SZE41YmZpZmYySktuSmdJZ3ZkVVdLaVZxZ3l0Y3d0?=
 =?utf-8?B?MHQzV2lHcUtkeDlTSmE3M2M2aGxZMU9UQnlpZ3RCR0RzRWpiVGwvS25yTVdq?=
 =?utf-8?B?OC81VVFMUzNsTFFpRHl2bTRZOG0xUGNFaXAyK2RKbFVwc2lHRlQ0d1pKYitx?=
 =?utf-8?B?ZVhtWlBPd3ZRR3FyRjNDQkxiZms2UldXaHdpK040L1I3T0lLcEN0U3J6eVJy?=
 =?utf-8?B?clR2M1YxU1hJSnB2M1FTcWdlSkFPU3c1dHpXVURpbDFPM2dFblNpaDJWQ1pj?=
 =?utf-8?B?SGhKaHM3SERrYkZRUGhxZ1ZiT2FodzhtNFFuTXozYWtEM2c5VGlqYW9FaWR1?=
 =?utf-8?B?U084c1YvREx4QnpyeW94U09nb09WejFxUnV1Qjd1c09CNmNLMjhrVGgyc1Ev?=
 =?utf-8?B?UStsT0RORmFrelRuR3AwOTJpaUhhZzF0WkU5QmVmVUVlaDdvSUczK09mQWdr?=
 =?utf-8?B?c0xTSjBGTE9FSFlTZkM2ckNWcDJmRFBJWmxLZ0lCZlkvK200YUZBVXBIWS9O?=
 =?utf-8?B?QlUreEhaUldEZmJhNzFVOFF2SDZ2aWhVaUQ2THUvcG9QblNoYXVyTXlLQlJr?=
 =?utf-8?B?aWc3blNIbkVMeFNHQ0hsMHV6L3RoTnIvOGhmNDI1R0NEdWZlZlQ0K1V0YWx2?=
 =?utf-8?B?NUJtNmF5UngwVjU3VVNmVXNBU2ZhbmxUYTEzN3I0d0IzRXBxa1VSbXllZjlO?=
 =?utf-8?B?UVRPU3lIS0NuTEl5RW9GcVA2K2xPUFUwUS9qM21GTWRvYkUxSmhFcEdQaFJt?=
 =?utf-8?B?WVc1bEFOSHpyMmczTEYyeDE2S1creDAwWmZVMVNpM3FmUEhNaE1zbEU4NjNt?=
 =?utf-8?B?alhkTWFwci9nQjVNTXQzMDllT3lUaHozUmRWZGZHaFFkVWVqckxzSDllS1NV?=
 =?utf-8?B?NW5yZXczTlYrK1dGYnNKYTd5SzZHQ2V1eWg1dUo5L080SXFkaTM5VFFaSmtF?=
 =?utf-8?B?L1lqcUUyWXdHUENKOHFNVHQvZU9CWFVBMTRjNktxUCt1UjRrc0JyVzEyakRC?=
 =?utf-8?B?Z1R5UldoQ1M3NjhtTHNWckVJd1VuVE01RjR3aXpRbExpeVY2a0JKQ2hycGpM?=
 =?utf-8?B?VG5PZHpBU0hQK2JYdlFZQitTZWJNL2ZmVUFpL3d3TWZyQTJlL0xZTFkvN0hB?=
 =?utf-8?B?RGxQTmJrN0ZMd2NVbGJ2eVZpWEVXYmlJRGJ0SEF6NWYvdkRlV3g1Q1EvWTgr?=
 =?utf-8?B?bUtZRVJ2QTJxdmNoa0RDNXFMQzJWSk9QWkIzeko3OEVrdjV3cjRwRStYTW54?=
 =?utf-8?B?eTVXcUI5S3B2b3IyYlgxc2xETTFzWXg4S2dWOElEUHNvRHp3UDFXRWNmblNP?=
 =?utf-8?B?U2hLSTV5bzlhOWFvU3lWbC9OODIrOGtBMGRweG1wSWl3OEVTaEpBakUyNENW?=
 =?utf-8?B?U2t6VGtTSVJSeGNaMjlIWFdMcG5IUEJRNFNIbGVhTGw2Qk83ZE9YY0lCWjZI?=
 =?utf-8?B?aGNBS2pFbGxXczNnSWg0UjdZMUYyWkIxV2x0NWR1Z05XWWgrQ0hhWTZTOXFR?=
 =?utf-8?B?RXR5cktWdWZuMXFmOWg4MzNFS3ZjUjcwcEVkYWRLU0dKUVZwcDJGK0wwZXpD?=
 =?utf-8?B?V1I4dVg5TGhoWjB2cEx1YXRiOG03T2kybUx6Uk5LMGRoU2xXTEVmMThXQnBD?=
 =?utf-8?B?YmRhd1lDNFRWOVhrNVptdlkxZC9lVXpPbzVFNUZqMk1TYkZYZVFpbHJpOUlF?=
 =?utf-8?B?NTE2NUZmNWhqanRweUxCMGxJZlZwR1Q0RHgveWNUVDhIVVRTWlpGc21KcGNs?=
 =?utf-8?Q?5w88=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a8ac1f-a411-4eb0-11c3-08ddbe316768
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:09:15.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WsQZHKpRTPSLdhnuxVxceDEaXpdqcHtTpjY6pngPWFmo1jIJAhYIQAcn5VZ73WJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDA375B65E
X-Authority-Analysis: v=2.4 cv=H9Dbw/Yi c=1 sm=1 tr=0 ts=686d349e cx=c_pps a=Ubn8NgXdbfquypQWsLw3nQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=FOH2dFAWAAAA:8 a=SaN47QdHtsy52Zws26kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: d31zkpgxqE7oEiV3Vs8kA3iTeMg4NDwH
X-Proofpoint-ORIG-GUID: d31zkpgxqE7oEiV3Vs8kA3iTeMg4NDwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyNyBTYWx0ZWRfX4zcUoitqe2AA UCWdRioc6ECLnsmLrLmeRGLIZwVKzuiofMnqlrHtrB0GBmrVuLfpwFO+FLEH/zFz9QZZuKNhC0/ RXRpwntg4WO3Jz0yQwv6oKHWoHxYOf2wPr9M5FD+UMK/4d0d0hAm8LfXfTrGcDeHYKM3Uqpz8bI
 sbbon9aeQI8WjtASzMiGuKagAgfCJ2mquDzbTrWr0ENF0kc2KBizpSZbnUr8KE7xKFMBiJJLLzo Ry1hJiTHht+RoikbKMtYLwsk7o7cFEIvnZk59RSTwWpdapK06kpx0v82ryzU8Rz4E0BWg5J4Y+D PPiPh7YyChFSS/gIdEX08M0ufE/vivV3IKW26s1bNySu1kYXCdwsw5ZI94mH0fKVmJfNYfIw9Fm
 T94F+VKpBCW0yCFTEWf0hwGL/D4FjEi46EuTgSsgwkowahIrWdntkZhabgrEG8wgrDS0+LEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01

On 7/7/25 5:05 AM, Shrikanth Hegde wrote:
> 
> 
> On 7/2/25 17:19, Peter Zijlstra wrote:
>> Hi!
>>
>> Previous version:
>>
>>    https://lkml.kernel.org/r/20250520094538.086709102@infradead.org
>>
>> Changes:
>>   - keep dl_server_stop(), just remove the 'normal' usage of it (juril)
>>   - have the sched_delayed wake list IPIs do select_task_rq() (vingu)
>>   - fixed lockdep splat (dietmar)
>>   - added a few preperatory patches
>>
>>
>> Patches apply on top of tip/master (which includes the disabling of
>> private futex)
>> and clm's newidle balance patch (which I'm awaiting vingu's ack on).
>>
>> Performance is similar to the last version; as tested on my SPR on
>> v6.15 base:
>>
> 
> 
> Hi Peter,
> Gave this a spin on a machine with 5 cores (SMT8) PowerPC system.
> 
> I see significant regression in schbench. let me know if i have to test
> different
> number of threads based on the system size.
> Will go through the series and will try a bisect meanwhile.

Not questioning the git bisect results you had later in this thread, but
double checking that you had the newidle balance patch in place that
Peter mentioned?

https://lore.kernel.org/lkml/20250626144017.1510594-2-clm@fb.com/

The newidle balance frequency changes the cost of everything else, so I
wanted to make sure we were measuring the same things.

Thanks!

-chris


