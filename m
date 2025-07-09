Return-Path: <linux-kernel+bounces-724522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C53AFF3EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5DC5807FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02524226D1F;
	Wed,  9 Jul 2025 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UGn6dq0J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MVEIkTJH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62688E55B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096743; cv=fail; b=R5NE3U1p2VvblueE3dSlyrqGttJV0N3t/AQf/ltucnRQrGis0PiobVlpuoGK5C4KcRY4+aYDMQreyyr8I0XXE3Ki2MUoXfCpDdXS56rgg/XkRVdHfo37TCuV+KpvJCRgql6bXbnZShG+OgkFi3zpFYiRtOyKsPAB1GVpjn2u7PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096743; c=relaxed/simple;
	bh=ismmYtH4mmbVuYGETzuXHmNZ9AOl0f30H6AUqq7qswI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SF6NzhI2CJ+MM7qUD2jQ5d3EgGoGD4wciLETweobVoR+0vvf3Ct6yd7O894fH34Wv5fdYJEDPy8QQGrFMOwz8+zNiS+9/eMU+z4xLefZGPSwrUYMtqFu2X89vQIptAGGTM8ZhgqPKJ1QUdO4LAojGUm/EZWPYI+g+yMaOxGjnfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UGn6dq0J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MVEIkTJH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569KWQQs000357;
	Wed, 9 Jul 2025 21:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0bRGajaKpOJJFyPb+JQmeuFLgSzYw6e9cZltFBOZ024=; b=
	UGn6dq0JhVeDx0+WWrkWhBUBWJf3yI7jy5hV5NunMuadbbXuKZ5jc4DMVBR/WTUz
	pHT9F5sGeEEo51ytC46CN2qbBIRkRLJssxu0D82iW776gltsEB8QgPozyh5CHz+J
	BvGWgzpNKODOJKFyfLd0eWlGYXx+9CvXYwCt7ChfuDTMunyyff8Pr83bbrui4riV
	R+UM9vuju2eXPsTjvSWdSOg+qQ7W7dtwL0jTeodp64ysYqAaafshaxnOmz0CM0W9
	nenokiJgJU/jVNlAlcyNWjbRWvCg0DxfeHd/nmBBYjUUUW3wuQ1z10hKnzELDFmZ
	gUqrV8hfQ2LAb+HzONJqBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47syhsg2ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 21:31:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569JYYO2014034;
	Wed, 9 Jul 2025 21:31:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbgqrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 21:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALXwelrTMD9QQuIw13uA8UXSQFTSu+lYuEg8gjvYUYB892KnAz4aCx5tTHDEU+emAnHXXf+SHw3n3QdCUXG+zMtlSmzT7PuO8y/3rvT4sBp4KHrvf75MX5eHoW/eWtwNHAcQ66kLRtECi8TnpXQQBZMw+svbYJ0/SqooA51ooZYRrD/T8KBP1wZXZubWmDUPifLxKhntl+o/VHAXoGtDYOk34IqfcAm1b5H/HRVPFqEpJSrw9Oaomux5BfZiDqHlH24u15TwtORheh55pFVUf0DrrhMhxR//DRlDORdyWV2SgPFE+wURLRtk7Ou2SWAbPFsOIzpRqwbrtPpFL8zXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bRGajaKpOJJFyPb+JQmeuFLgSzYw6e9cZltFBOZ024=;
 b=hrQxSoeekuob1OfP2r1h/+FKVYqK2fiyL5QJD/5nue1KNIM2Pi7GuRu5tO+AwmtRDNx2DSPOW8SqP3rxbUQCxS8IMZstbQXDq3Y9Jr8S349AgZYRgwUUYWRL5t8+d2p05dGev0jWQ6/lal3lQ4WhqQgthvoYIryKpWYWY39+Ju8WxLxJ4B0LEd9xS88wPvT/JOY5Bokj0vWGXn07t0utNimjemL718iy20hIHplQflmmQt0m8ZOy9Ie6pCbpWK+LjYUTCr9QEGjw+cXdnUJ3rlSkhpompwvSkvgtH3J9I0BFTBUUxulPndClhUONwEy6AZaEk9NIfNj/IWUreO9W8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bRGajaKpOJJFyPb+JQmeuFLgSzYw6e9cZltFBOZ024=;
 b=MVEIkTJHqmp1TFAv/AOzIorjB8babl+9yYCbgZepW8t+w1XqDwlcXEIIPX7qgrKgRW7DdclON1yD4mmKFvW213xkeKM91l5oKRtyW3XrwU0onEotaXHDaEwdkOFTuznQf3w5/dXlwJ3kHPwW0WgNE/X8bJ453biiiPU+JCn3hRQ=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by SJ0PR10MB4416.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 21:31:46 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 21:31:46 +0000
Message-ID: <f102210a-66b1-45da-b553-f68a33360736@oracle.com>
Date: Wed, 9 Jul 2025 14:31:43 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
 <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
 <6a36eae1-7d1c-4c23-aec3-056d641e3edd@intel.com>
 <9e78f54c-f993-4505-814d-b8815f5c6bf0@oracle.com>
 <0c0bd184-6926-424b-9ef2-f3910be18073@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <0c0bd184-6926-424b-9ef2-f3910be18073@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::26) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa34797-b875-4db5-b45b-08ddbf30019a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzNSdFFrSkVCM1crMXNHMjRhOC85dk54R0FRZk9vZllLTmNYS0duMG9nUVpL?=
 =?utf-8?B?WWRZWjBwcVl2N3BTWjBUd0RRKy9mUlRlc0xuVW53cldqVDY2NFhVaDBkbUpW?=
 =?utf-8?B?MTdTSUxac3JkZWRNOEluQTA0RFpvUDBlSHV1Q05CbVNlZklYdXRnaWRzODBU?=
 =?utf-8?B?a0ZwZU9CcVdVTWJYZmNua1dZYWdiYmxjbVBUR1ZoRDBDaWRlamhFNXNCeS8r?=
 =?utf-8?B?czVDVi9paTQ5VkhnZ0cwUm9RNWJtaGtyNHpZdlFEMHRtWnFaQ1g2SGhqTFgz?=
 =?utf-8?B?ZGRUUXp5QkZnczZlV0ZiYnZoR3JmbGFDWmJibU5XRWVNUTJXOXhOdXdUaGo5?=
 =?utf-8?B?ZnU1NkZKSUZub1VvenNKS1RoL0JuU3dVZUxVNDFpTFZNbjZGMStGWXNncEk5?=
 =?utf-8?B?RTdQbHhrZS9CWEh4NzhiZExLbllWQ0UwbGl6VTNHMU9xRXpmT1NsLzdGTzlY?=
 =?utf-8?B?aXpHa29aWEVmNEpSVzA5THYyNXYwSG00SEZ4MjlzeGRqc0h5OFUrZEwxQis5?=
 =?utf-8?B?bnNwOEVlazIyT1cwNWt0M3BUNWxYcklXd1Y3TkxpN1ZSM1Y4VmhGWWVvYlFu?=
 =?utf-8?B?L0c2QkVONHp5NXFMaVdiTUUxaEcrSmdVQW14MTRTYVNnRFVZNmFvM042WEJh?=
 =?utf-8?B?Tmh1YWtCaCtIc05sZm9VY0gyaG1VbUloU01VcHYyb0hjUjBvZk9JNG9LSklO?=
 =?utf-8?B?T2R4VVM0dnhaYkZQQTZFbnd4WWFxTHdjV3RJcUR2UHpGUHU3R0FjUEhJbDZx?=
 =?utf-8?B?VVQwM3hid0hRWEZKaENzVmUrdE1OQkRKeGROeVhrOHYrU3ZhNXMxa1ZxL1RI?=
 =?utf-8?B?MHZyVDM5RHZMQTdIeElyR0FtSDQ2akFIYmRydDJIL282cDhOd1BsMXQvWUdS?=
 =?utf-8?B?bURwc1h6eXlpNkhEUEI2UDM0NHkzdXRzNFNUY2xFUDNpQzhLOFphSDh4ajFT?=
 =?utf-8?B?Sm9MMFhTQ1ZMMEhZQmY1M3JjdzhsbDdwU0dCcGFKYTd6QmdEOXZqcFhrM0Rn?=
 =?utf-8?B?eS9ReHBOQWV6bVczSG9WejQ5bEFzTnZNWTBlcXVUcEN2UGVsMDM1M01OSDgw?=
 =?utf-8?B?d1EvTGZPRUhteXRIbzliaUpqNDhzeUxjRkpPSE5tdXVZQ01zaGRBR3hSOW9o?=
 =?utf-8?B?UEZHL0ZncmJKOXVMa1Q0VG4yMlRiTlJkeWFvSnJqRmJlTXQxaHFFbCtkeHJn?=
 =?utf-8?B?azZjd2hkOTdwNGJxb2hwazA4d2dDeW1oME03bmxacnQ1YU1ZNDQ5cHhTb1Bp?=
 =?utf-8?B?UjRycGswZTkxcTUrdjhoRjVVRzhHczhqRzREalNMdnZuTGhZK0VuWXl2QmhK?=
 =?utf-8?B?bGJ2MTQ0eXU0OXBnZk1YUnl6L2dyb284eFowNW90YWh6L2p6dXZDM0tWRHVU?=
 =?utf-8?B?ZG1EOTFCTzEwWHVIanplc1gxSENML0NlOVFmVVZVeStFbmRpa0RPQktiR09j?=
 =?utf-8?B?Tm03VVlXNmVleDZ0ZXNyT29ady9ONEgwcmYvaFhDS3ptRmVzSDZmS3lCMlRz?=
 =?utf-8?B?T2VqOUF1R0daUFpzaDNqaGdmSXVPSkdaejBBd1A2dlN4SElpR255c002a1Vp?=
 =?utf-8?B?bHVSRXA1VzFnWWpIRTNWL3ZiMnB2RllRYTlpVlNidlBFaWxwR1N1UTQvYm50?=
 =?utf-8?B?UmVrOHA0OEZiNG92SzR1T1k5djR6Wk54RmNLamljbFJyU0VscG80S2VNUkYv?=
 =?utf-8?B?NUg1TDBqQnQwSStMWUYxeWR5S2JUSnNaTmlubUQ2QXVFYmRBU3FpM2s3K3Z3?=
 =?utf-8?B?ZTdmcmIvUVlWU0JjMW5EV3FoSTBWTjA2MXlGYWM3L09pMVpKV2o2RGl2TmNz?=
 =?utf-8?B?eWZuS25DOWxMU1RjdFJuWW1lZWN4TlNvQUExaEtGVzlmcm9EdmR5SzloQ1BU?=
 =?utf-8?B?THl0ZFM1WEdUVjF5R1ZVSnhoYjQyTXJiOVlWc0JpOVZsMmRTeEppOEZNeTFZ?=
 =?utf-8?Q?FG21SiXrM3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2R1ZXJJSDlSekJHcitabFY5TkZxVE13bDY1eWNqZHRta0FwakloQndSU1pu?=
 =?utf-8?B?OHhVM3JBbWhHTm1EaXFWbHNaS0hUV3I5UFNEUHRxMTJZRjN1OEJYcURiY0wy?=
 =?utf-8?B?QmhIdVc1Nm5EaVM0QW5BVC9QNGxITTRXUGpWTHlNZzQxUDcrUk9jT1JuejE2?=
 =?utf-8?B?cWdKaG54WlFtNGtYbVBOVjRJQVBhVTc5MGJqbTZXNUZzRi96d3RNbmpQTjgr?=
 =?utf-8?B?TElrZEFwNW5NSnpOQmR5Yno3Qy9kMnlHeGd1SXZuVEhiVytaUHRaSjNGMVIz?=
 =?utf-8?B?TTVaTjJjWkZGWm9seHZyYVp6UDYvT2JlY2sza09qUm1OMXZUZGkwaC8rODBs?=
 =?utf-8?B?ZU5VVVZHcUJQdEVuTkN5cjNIR2FRYWhESXYxZjIvT0IyNzhlUDk2V210WFpJ?=
 =?utf-8?B?QndUQU9GVjhqbzBGT2lpTlNrVlYvemZXSjN2bWIwaEN1RzdrN0I4dmFnNVF2?=
 =?utf-8?B?L2pNQlNxS01LbEl2K0MvUWRIMTh2MnFOUGd3Z0NWdWdrc0Z2T3ZoclQ1K2N0?=
 =?utf-8?B?QlJwSTlZQmk0RTlvZHVpa3VCMjB1YmpLajZJOHZEcTF0SzFiMXBjTFBhOEpL?=
 =?utf-8?B?MUxaQ1dpTWJnMWlkNVhSTUpOQ1B3S09ZUXpZdzlISHRFOUp5NlhZV24zeDE4?=
 =?utf-8?B?RUU4anRCVU0vY21nVzdLM25YNnFrekkycHg5M0JjbGMzdm5pcGpYWmY5VVJT?=
 =?utf-8?B?TEMzYjlFeGV5Y2tqNjVTSUptek5VdklYMWpzY3k1WS9XQWozSXQ1WnRSOTc2?=
 =?utf-8?B?ZTNTUWdUcVBsRXdPMnJXUzQydWNYWE9oQkJ1TXhKMUhHT3pjQkxBVXlPbWpW?=
 =?utf-8?B?SGxsQSszUEppcjRsM0ZSNGtPYjZvdTVzbW1ETElMVlJKMHg0aTdDbzBEZzRw?=
 =?utf-8?B?a1RCTEZVQ1VrZ1AwTGNCbWI3c0RrZmo2MGxITlJtdms0a1BaekxkZ291RDAr?=
 =?utf-8?B?czNTR3FCU3IyajkreVZYZlJ3R1NNSzhsdDRBOVQwbGJzMVYzNXhJbUpqaHhX?=
 =?utf-8?B?M2VGaVM4WndJUU9Nc0xiTzBZZm5hK3VaeDlSOVZua3pZdzVFS29jZjljR21r?=
 =?utf-8?B?cG5CSCt1RkJOd3owL05aYWRKY2J1QXZhMlNWTGNPdFFDbDdCb1lKeVVWRS9s?=
 =?utf-8?B?NFJBcDcwRXB5RVl5ZGpqdnF1M1E2M1dweG1YblFtc0lKeVdjRXRmTngwbjlx?=
 =?utf-8?B?ZTdrWllLOVRZZFliNWZWM0VEYU9uZG45dGlPUTBNeW9sSXVBK2Nuc0VoMUdJ?=
 =?utf-8?B?VUh5TVpSVDcyZisxL2pyWmxJVEpqQjA2T2lzVWVDRjF1MXpoc3VBSkttdXNR?=
 =?utf-8?B?SmNYVHJ0V09qRndOMkNhakZxS3dIZnpZNVpyL3ZLYTgzR1NWTWZvMVBPVTJI?=
 =?utf-8?B?U01UMmcrZ0MvSndNZWFyMDRpekx0Mm9WcWVTTTJMQnFUOU0wdDNMZGdhVTJJ?=
 =?utf-8?B?VzJKdTQ1SGNVdGY4VTMyWlU4MjFBWDBiajZXaENtNzNYYnpxQ25MWXZaWWxE?=
 =?utf-8?B?TTdXc1QzV1lvbEtyaXBtVGhacEp0Z0xGdmw1eTJvSEUzQ3I5K3l2b0xEbldT?=
 =?utf-8?B?WjAyNFIwVkV3d2tkb3ZQV2hYc01CME02bXFBY2JvU1pST1NrbEZaRzNJSk5X?=
 =?utf-8?B?Y0dYVnhMRFNucGp6UHIyOUV5dUVsWlVrdURpNVlpNFJNV056YlhoWWhSM0py?=
 =?utf-8?B?WElqSGRDL21xMUtJbTE3cHFkUklQaGZyek9YN1A4anh5Z2h3dTYxdjVoN0N0?=
 =?utf-8?B?aVFpQTF4RmVXZXlUaVlWRGJaRlBLQ01SZHFuMUtOWFVnSXhsSVpydlFiR3RB?=
 =?utf-8?B?dFFtSTNOckc5TzdxNktYTHE3M1VnNGdTL3dWaWZJNHVJdVVqZjBwL0tvck93?=
 =?utf-8?B?SmRQTGZ0cnJVcmJ4MGpRaE9Mb2JNa2hZUUU3Y3JQNmdoVCtMR214ekw1cUtC?=
 =?utf-8?B?RzFyc1hOT0FxamJSY2F4d1dUcjVtcVoweFgxeWtrU2oxYk12MzlCVlZlS3dZ?=
 =?utf-8?B?VTRmM1c0UXovMnhOaGpGY3l5S3JqMC9acktWSEUwbFlGSW5ka0IyYjhJK2hs?=
 =?utf-8?B?SEdTa3VYbHl2UXB3bHZFRTExNytYY3NUbXlhQ2dGaFFTbGZsY0Yzd1JyTDd2?=
 =?utf-8?Q?4gKxMX9uRGiNVjw337ExBfA/r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uy+VwlltslSp6hnzQJhOdrjL4Fp2iilZGaD3WSVLYg0hvI5U6Q9mTXafHJsEduPZo7V8orqmmP+p2bYKLWqWCCz0ljDGrI9GRiYISJ5JIkGVlMFxcUzitMZwxkfzFvj0wrcTnfVPWMYXMR60FHKRgZNaYzrIyF0YmxUjNcPA95+tvE8OegORaUBVC+C2GvxNEbD8a5e55Qq14XOxZKrir5F4KV6y0b2Z+MMRY/h7gO4OH1aiLSktICLkIKUHdqtxxVdC/DDC1Q1tGMA2O0gAjl+Z22uepn4ipHFK3L0qd4PNIEKcEuMT3hOO2mWo7yUo0uvEtGfqfQwWL32KRJ0I+sv1ta5m5W7hfLCFnmNbLZWcNMOikDd5wwusNR6NQMdVm1saKQYGYAZUqO8HHwnNZ85ZJcLHFfagesJicGKAyggUyMaV7NF/e1yJ09wPTAoQujtxRNP13RJrscQ1WJgUlC7TXCB7QFH1ehNkvvjzoNTbo72KllCoFb1/tylYsG1Zb5wZllE0Vy8tEZ/QHegvAd+jnKPVBRtdh2wK92JqKwJqkIEH7G50IpGefDQmgaPiEm8HN/6C863Qq0bg87yh8qKC3rXJCahnDKxVGbI4xZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa34797-b875-4db5-b45b-08ddbf30019a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 21:31:46.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leWLYMQSrUckMf44a8YC8pJ/ySNJNNqdMWcF5vclBgVCkYMV9MuQJj5fxWbwTuM6krrzBbMoHwzT2zOFg2pD8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507090193
X-Authority-Analysis: v=2.4 cv=VMrdn8PX c=1 sm=1 tr=0 ts=686edfc8 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=MhvsFGaLoAUefMQ1SOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058
X-Proofpoint-GUID: E3FuRsGQHXLNBTbJLfT1SZO2Q5bccMlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE5MyBTYWx0ZWRfX30TnhztPlXi2 i1pu+YUifZaIyUK4W3oZ+0sUfzP9EP8DpLadhJMUquFimvtmWwnz6QWViqnahIilbtfx10GTxvJ bUm/1RWNOwHgLHUrwWO2PH1LgfbnRO8Dktnsn8z2KoJHvdiXV69sh6QCvHYKxdy2U+dxN7fa2va
 M72ulebHBUMyipfKjqZBG18nciDf9KWahOBUzwz7lTe8UrNZvHBUvhcehP4inzEGVi16nsAbFJf 5OqUq70A3p5YaSMSXSzk713gCk8oY9Sw+h2YRaiIiVBeIDY80p/XJ4H3Umb6yedOtpzb3FWE3t3 itC6aMXuDmHQ5C+T9a67yA5TnBJwfT1ZAekZBbEML/3DA6VZAMt+eI9/4rQD2b0w1mgdc6ABSoe
 LmCxr4M8lPdjWaB/paB/7+6JoR3QmHlMD6hmBMklzIKB9r+r9uTBOA3Ia10DddXW/AH0MP/N
X-Proofpoint-ORIG-GUID: E3FuRsGQHXLNBTbJLfT1SZO2Q5bccMlX



On 7/9/25 07:41, Chen, Yu C wrote:
> On 7/9/2025 1:22 AM, Libo Chen wrote:
>>
>>
>> On 7/8/25 01:29, Chen, Yu C wrote:
>>> On 7/8/2025 8:41 AM, Libo Chen wrote:
>>>> Hi Tim and Chenyu,
>>>>
>>>>
>>>> On 6/18/25 11:27, Tim Chen wrote:
>>>>> Cache-aware scheduling is designed to aggregate threads into their
>>>>> preferred LLC, either via the task wake up path or the load balancing
>>>>> path. One side effect is that when the preferred LLC is saturated,
>>>>> more threads will continue to be stacked on it, degrading the workload's
>>>>> latency. A strategy is needed to prevent this aggregation from going too
>>>>> far such that the preferred LLC is too overloaded.
>>>>>
>>>>> Introduce helper function _get_migrate_hint() to implement the LLC
>>>>> migration policy:
>>>>>
>>>>> 1) A task is aggregated to its preferred LLC if both source/dest LLC
>>>>>      are not too busy (<50% utilization, tunable), or the preferred
>>>>>      LLC will not be too out of balanced from the non preferred LLC
>>>>>      (>20% utilization, tunable, close to imbalance_pct of the LLC
>>>>>      domain).
>>>>> 2) Allow a task to be moved from the preferred LLC to the
>>>>>      non-preferred one if the non-preferred LLC will not be too out
>>>>>      of balanced from the preferred prompting an aggregation task
>>>>>      migration later.  We are still experimenting with the aggregation
>>>>>      and migration policy. Some other possibilities are policy based
>>>>>      on LLC's load or average number of tasks running.  Those could
>>>>>      be tried out by tweaking _get_migrate_hint().
>>>>>
>>>>> The function _get_migrate_hint() returns migration suggestions for the upper-le
>>>>> +__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
>>>>> +__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
>>>>> +
>>>>
>>>>
>>>> I think this patch has a great potential.
>>>>
>>>> Since _get_migrate_hint() is tied to an individual task anyway, why not add a
>>>> per-task llc_aggr_imb which defaults to the sysctl one? Tasks have different
>>>> preferences for llc stacking, they can all be running in the same system at the
>>>> same time. This way you can offer a greater deal of optimization without much
>>>> burden to others.
>>>
>>> Yes, this doable. It can be evaluated after the global generic strategy
>>> has been verified to work, like NUMA balancing :)
>>>
>>
>> I will run some real-world workloads and get back to you (may take some time)
>>
> 
> Thanks. It seems that there are pros and cons for different
> workloads and we are evaluating adding the RSS/active nr_running
> per process to deal with different type of workloads.
> 
>>>>
>>>> Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE?
>>>
>>> Do you mean the SCHED_CACHE_WAKE or SCHED_CACHE_LB?
>>>
>>
>> Ah I was thinking sysctl_llc_aggr_imb alone can help reduce overstacking on
>> target LLC from a few hyperactive wakees (may consider to ratelimit those
>> wakees as a solution), but just realize this can affect lb as well and doesn't
>> really reduce overheads from frequent wakeups (no good idea on top of my head
>> but we should find a better solution than sched_feat to address the overhead issue).
>>
btw just for correction, I meant wakers here not wakees 
>>
>>
>>>> Does setting sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?
>>>>
>>>
>>> My understanding is that, if sysctl_llc_aggr_imb is 0, the task aggregation
>>> might still consider other aspects, like if that target LLC's utilization has
>>> exceeded 50% or not.
>>>
>>
>> which can be controlled by sysctl_llc_aggr_cap, right? Okay so if both LLCs have
>> <$(sysctl_llc_aggr_cap)% utilization, should sysctl_llc_aggr_cap be the only
>> determining factor here barring NUMA balancing?
>>
> 
> If both LLC are under (sysctl_llc_aggr_cap)%, then the strategy is still to allow
> task to be aggregated to its preferred LLC, by either asking the task to not be
> pulled out of its preferred LLC, or migrate task to its preferred LLC,
> in _get_migrate_hint().
> 
Ok, got it. It looks to me sysctl_llc_aggr_imb and sysctl_llc_aggr_cap can have quite
an impact on perf. I will play around with different values a bit.

Libo


> Thanks,
> Chenyu


