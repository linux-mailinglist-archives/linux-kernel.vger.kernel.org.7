Return-Path: <linux-kernel+bounces-744781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F3B110D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA291C241BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1A2ECD0A;
	Thu, 24 Jul 2025 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jbotIA6I"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32A54723
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381458; cv=fail; b=J2rlqymjD3SyoG3z7RJGozHtp5bPZ2guKCeKR+9sM/COFnmP5nOYwo7nPWT4losJMI/vShbuH+rh9N4w71bC6nohMXoVtdysc1SbqeXK5gmHx2sN2DoNLU2SaRfA2GW5t8AzpVPkzDxcVf0/rWOwyqZA0mngl9utijPvrx2wiW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381458; c=relaxed/simple;
	bh=jaOGobG1I0FXHbHiIJ1pROz3+VP4HMVwYtw638PEwwc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQPb7OS/oI88FDw++pzBNL7zLFVCqLNswSugWG+QwjNvJTVVKdNZhZImgHoKehtsTygTTIsmnIivgyTUe5f/0tdXC5uean4Jk7q1ykETQnPpGEntQErcoUy2na8glLJIQ8g99I17Eh7ocO3Gs9rM9O9dJ76qDIt2CIt9+KQ3+yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jbotIA6I; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OIKoaY026636;
	Thu, 24 Jul 2025 11:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZVI3H7Ko3dCKYriJfKHO/yUr52vFibp4Mgabv6INddk=; b=jbotIA6IeGTh
	Od/x+U6avXWU8HkfeyqTFXjuv0J80KVsEdFINIBUzUGDfyq8sxxq6EbwXb+Qp2wS
	kbuGU0eobZUB2j19u08BsZ9sFqRRrK9y4Zaw+fsF3RsJs2oMf9TQvE0Qm1aToXTh
	no9GPzDWdmi3JNJsn5hb3Ur85IGbOzaPElfmXTIHmeCVQp9EVpDbFQPHF8sdL9t3
	HnuptkiezcZixvmhpljf4Bv7f5i/FcSJZASUDwHcENYWzBhwCHysjn/JwESVlWeX
	4Nri0GHwnMBclbC3GUOhLMMqIivH0yYPBnoP3iGgn+Uj0uSteAfgKyGu9WMkCHgM
	DpZ70dzHKQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 483s3x0n10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 11:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSGvaJcjXhRPCon+nOb/8sLPt6QwOc+RXTboRDKf/8c44upURtBvIXhapRUXsamk7FqPShBPi+K9HdEcNysJHjUHtHzb+6ucXmWJFa0Zcpb7PqStcEfu9aokgSCUOqaGN8gB/QcU6Y/uoSqpgXk8c/waSNCkY2Ii89fZ3ctq9dkTeDaK64nuUANxNTc1kF5pWm8NqHTPlPai6MPjDuwnxu3GzJ9sJffmr7tyCQpuqcEBSOPLOHMoUumAfUraJy8J5i72wywP1rRymQ9s8tJI32AC2T+uzxV4oWOi/MmD6c1mvd+abQ+ruz4k6tnGoNo2z7rH+URGI7BmYu61q8rtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVI3H7Ko3dCKYriJfKHO/yUr52vFibp4Mgabv6INddk=;
 b=beE7C88O4VLbt82Qqr7MCCgpa2qFUbgliy7gja/KMkE1aRpsK5W2hSbwm7ud3SSJWSlon83pXWbs1Vy8AM0U/JO9HWMDtFqDfosFkA0odhHGGcEMSvkAoRtOhKdhgZ+O/SBJMI5Eyf0PPqO23uwR92qPDKYVw2rdbmnsnEwZ1v3Xu1TkjJ9ysWPtVttzrj06q1psZn6pH9LCogsXAbc03vfSpyu2exvJh+JMgiLagpdzo+tx+bLJ2f157ltp00FC8WeUvJ+fa+weZcfWMJmbVigY7jdGfvVNjvUjtQ8a8ijTf+zm6NaDH6odK/KX+E7dQzSdC5CJnSsbP+T7YbjEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by IA0PPF72C0AA731.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 18:23:55 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 18:23:55 +0000
Message-ID: <b9ef3469-1042-43b8-884d-57064b79bbe7@meta.com>
Date: Thu, 24 Jul 2025 14:23:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
From: Chris Mason <clm@meta.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>
 <20250708190201.GE477119@noisy.programming.kicks-ass.net>
 <cc582ddb-2f16-4c0b-be27-b9a1dedb646a@linux.ibm.com>
 <8c6b7753-02ec-44d5-9b32-5c8fbfa2e7da@meta.com>
Content-Language: en-US
In-Reply-To: <8c6b7753-02ec-44d5-9b32-5c8fbfa2e7da@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::12) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|IA0PPF72C0AA731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b06a7f2-fdcd-43ac-b06c-08ddcadf3fe1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDc3QlRwNGMyQW1OaFNkanZYaWJscUxzaFZCM29CYWppSTRxSEJBb0J5dzVv?=
 =?utf-8?B?ZHZrWEp3M3A3L0dXWXdQRVhCWW10MHZkbGhWSFYvQ0RXWmhwK1c2SmNhbmx0?=
 =?utf-8?B?QjFxbnh6b0lRY0JKK0wxOWU2TlBlUDNQRDJYWmNmek1TRHViZTRST1lKTGd6?=
 =?utf-8?B?UDg0c3VPckZoSVNQeFZXb3FTZzFjTTF6WDZvZnBLd3gvd0ZlSjNLTlVPcXd2?=
 =?utf-8?B?eFJOMFBKODJvUGhzWXZNNmVEQzA0MkpZWExSQ1M3dkcwYVJRTktxV0R5Zndw?=
 =?utf-8?B?V24xMGsydDRwVytLcTgycEdZbHhheXQ5cWRHVVV2OTUrM2thK1JCdkIwMjhC?=
 =?utf-8?B?cldqeGt5ZERjL3BsUUozZkprdVFaOTJkRytKdTU4eVBsRU1xVzFJYlhNK0tJ?=
 =?utf-8?B?cmJEL3BDQm1jNUkrYmIxTjMyN3kydUxZbUxrUGlLNDVGT0FVdm81ajhoSGdE?=
 =?utf-8?B?UTVEOUFFNVJVOE43VlJWYS85cFBpYjJLR3NhUzN0TTd2SHNMTlpobzdMUGxL?=
 =?utf-8?B?Tkx0dVpDUGhnd29UczBpWWQyNFBwY0gyS3pqSUV0cVlFYWFwS2VPdjZsa2Nu?=
 =?utf-8?B?ZmRoMzhsNXFDdTJKaGtuYlB6b2t3a0VlTWFhTlZOeHRtUlJ6YlBzNzUvdXNW?=
 =?utf-8?B?VnJtWkZCSjB5T1Y5UDlLNmRaU0lkWEtobnNVRlZxZXdDSFV3TDBjS1N0YzNo?=
 =?utf-8?B?N3Q1Ly9oSVg3Uk9RRk5RQXl0by9TUDAveFV1b2FVc01OMVVoMEhIOGJzRnR5?=
 =?utf-8?B?SjFJbWtDZytnMVBvMVpvZ3pkZ3RoOVBqTE5xL2pHZVkzQk13eUswS0hLYjFL?=
 =?utf-8?B?K3NWZm9neXJIa2x2Q3dMd1pRM091aFF5dVVpM1I3dEJHblY3eUt4MnpTWk40?=
 =?utf-8?B?bUM3cHVMS29xK2Z1UzhNUVVFSittclBzNEV3TEFkOFQyL0lzUXRXcU5oQURN?=
 =?utf-8?B?M29RYXYvZkZYRHRIMU5sWlorOWxWZkxqZzYzQkRLNmNYM1hINWZLcndQNzVa?=
 =?utf-8?B?bWpnNEV2dHNiUGp1TFdNcHp0a0V6b3VTRWRTMUhKMUJRSUJpdGZnSFRxOXdH?=
 =?utf-8?B?V1p6RUhpb21ZRVVyQnRCOG1uZ0RqVmcvaHFuWDEySnFiTDRZMkp1eFRsSlZu?=
 =?utf-8?B?ck1pTXYrYnl0NmtVc2YxQWV0SG52T1BKSUtFTTI2cko4TE55Tjg3UXYzb2Vy?=
 =?utf-8?B?K1hzQ1c0Y2JkaElDeFRqY3JuU2ZrN0Y2VVY2OXVpQklZNmlLRDdncXUxamN5?=
 =?utf-8?B?b0xsTzUvK2I4TVpjYW9VRDAxeEJzRS94RDViUmZzN2ZKbnpNblJwOU90bVd0?=
 =?utf-8?B?OGpteFo5RkNhK2luQzlId1JWS2tLTlZhT3JGcUtBcmdzTFhOR01ZWTYxMXJV?=
 =?utf-8?B?bVZhS1pWSExveEc3Uk15bm5qUFE5aWhzbWMwZE9lUEJsYlphd2dwWFZrVGlw?=
 =?utf-8?B?d0J4VzkzSEtEbTlSblNteDIzUVRLMkJrazE5YmowdEdBakl5REQ2YUZDbXFC?=
 =?utf-8?B?K05YdklDcExyU2tXckhWN2R4MGY0OWJUUXZTVjdmTjhlSCt4NDFVN0V4dUl1?=
 =?utf-8?B?TVBhV0pQc2pUMWdPZXFDZ3hXRnhnZW5QaW4zbVdQbEFpVUpSZy81WUtnRk5z?=
 =?utf-8?B?TEVtWnloRlAxeU1lVVB1ajhUQ0xJdWlCaEtrM05LbkpLeWNKK2dHQ3pNZ21O?=
 =?utf-8?B?ZS9yNnZ0dnp4KzRpZGpxdlBHYVdYRzF5aXRpUXd4NkNZR1JrdGV0THk2dmdP?=
 =?utf-8?B?Q2dKMHU4c0VzbURWMklHL0phWWFGaC9kRGJOVU5DQTFhSTR3ZmVYNWFaWTZt?=
 =?utf-8?B?S0RCUXU4dVFuNWxySktqYVNQQkZxNDlzcVJLMEdOMjI2NEtEWXErZGVFeHJT?=
 =?utf-8?B?WVhFc1hYbWljTUMya2daZGRzdzlJa2gxSllwcGhyUXFZMmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2N4RTlWcDdqWjZPcGl0SS9zbHRlWTJCQ2lyT2plOEdZdDB1SjhCRlBpdXdl?=
 =?utf-8?B?aloraTM3cnlyK0I0cG52OHpBQldPL2tpMVNwb3NKMTUxYU9uTTAvdzZCMUZJ?=
 =?utf-8?B?V2EySEhvbElUYlZwSHZYeGU2S2k3RmRkTmVzaGtVUWF2QWkraHp2ei8xWXQ3?=
 =?utf-8?B?b0MzNjdhZ3F1b1F3NXpSb0VVSWZNN0lCd1VieVgwUmhQVFBzUzgyeVN0VzdG?=
 =?utf-8?B?ODRFay9nTFdKV0Q3VEdpbk1wdkZTdkwvalpqeG1BTEFmcDZEbi9MSDhncFZj?=
 =?utf-8?B?bUQ0WldXYzRxYlR6M2NtalJCVi9ybEtIb0FEczFzVWlJRHMzRDk3dVZxZURS?=
 =?utf-8?B?NWIrQTZZUWlsTEN0TzlCc0lNZjd3NXZZd2tQWG1KQkd1dWF0blMzd3YxeTBa?=
 =?utf-8?B?VUhSVUVpOE42RnE0eVdic0RPZTRSK1hUWjR3K28xa0FXT1FsQ3J4K3JuTDho?=
 =?utf-8?B?aE53Z3VMRU9lZlhzdVltREhqRnZFN1A3bS9kYmVwR3BuaFFaRFpmMEFGQXd3?=
 =?utf-8?B?RXV1eXZudFpCbHJLT1MvbEd5QXkzY2xkTWtmNm5VZHlLK2ZCamZzaU1LK2Qz?=
 =?utf-8?B?S0pQRjkxTEVqWlV1cUZvOUoxd2FSNWhMOUs5cVJmemVOa1IvN1FZaUFtNjlv?=
 =?utf-8?B?VXBqY25SMWxDaVhQTGE5dzY0TnpzOHpkRjMzeGNXbW5hamlaQnNtVEpWNm5o?=
 =?utf-8?B?dTBSWDVsSkliRU9xQ0N2dng5TFBhN09HUXVEMzJBMnB4bDRyb3lQV1VwVHhs?=
 =?utf-8?B?V0xxZ1R1L1hUa2VraEJnTE5FRDNVc1llR3pNN054aXVGNFNjVkJhZ1V2VWpV?=
 =?utf-8?B?N0U5d2JvMndMR3pqVVJqeEN2N05MeEl5dDAyMUdidDNPRm9saFNDM1VORkN5?=
 =?utf-8?B?aGpqSjQ3QjBhOVM1N1JrWlpTaTFwUllNSlBRdm5OYXJVdnorR1R3c2hLM3Qy?=
 =?utf-8?B?ZCtCeXY3azU0bENTMUpFTUtFVkVZb1E0UzJvWmV5SUZFQjNqM1ZSdzVsQzVU?=
 =?utf-8?B?V1BKRG5aYnR5UGZUVTJaUnVJUDNDa2ZpNWtSaDRHdzQyaTVtK3hza2ZMSEcw?=
 =?utf-8?B?SmFQOG41bzQrZzdOU0pTbDNNa2t5SkNrYjNFdExRQjlKbjdEeVZUbkVTQlQ5?=
 =?utf-8?B?ek9rQkNqZHlqVyt2V2hDa2ppZmdJbVEzTjFRZzJsOW5jVmtYdXdZdjc0aDNI?=
 =?utf-8?B?bVJQWVFsd0prOENJTVdwNUdXd3N2QzRlWVlVS1dMM0pZT0VObmZzbjN4MS9J?=
 =?utf-8?B?MHdrSFhUd0hreGRuRVRlRXhUSml4ejBsYUhad3g2eDh0R3ZEbmdDQXFEWU5G?=
 =?utf-8?B?R0huVVhvMVZyYm9ibUhrT1BvSy9iZzhsbFdOZGlnd1NqZHZCem5VNmxvMlNQ?=
 =?utf-8?B?SVUvcHdGcTFvMDZPQS9GbUNtdG9IcVpqd2tGS2RQQk9SUkdKaTBJbXNqVzVo?=
 =?utf-8?B?VTRQSyswbXh5TTlFWjMvYiszSUxVa0s0ek1iQlJNR0dnVHdHTFd6TnVrRkN4?=
 =?utf-8?B?M3hnNWY0QmVDU1lvVmtKaCtNWTVTbVBWMFBOMm1MbmllZ3RaLzhZbmRSRG1h?=
 =?utf-8?B?dklFaU9MOUtoeS9BbFVHSitaT1FMZmxWVjQ1ZnU0cVFTRFZKQkljRnVNMDda?=
 =?utf-8?B?dW5DZVQ5MkdBNnRZdUdieHBPQVFzeWhhTnhxcUt3Y055QjFTRjJIb3lBRmxH?=
 =?utf-8?B?cERVcVNlSXpwUjZYUU9nN3ZGdkdXUy9nZHVHNVo1UnF6a3hOR3JyR1p6MGJN?=
 =?utf-8?B?Q0haNklyT21Nb25NcXdEVGNidDVmVW9aUk5ZcHo5RjJJWXY3UzF2UlJsd3cy?=
 =?utf-8?B?dzltdnhtSzdZTjdCb1BhUkc5R0NwU3R1Smp0NTh0Q2hKTWNiQXNVZGI3aE13?=
 =?utf-8?B?bFVCeE11ZkRYR21vWVhjTm9wVWllQ0UyYWVMelpmQnJtcGFtVmNrR1pZNzBn?=
 =?utf-8?B?QzJkL0Jwa2ZnNVpUcGxQMFNWYzRRUEJpWVl1SFhyb0MvdUE4a3dodnppa1dl?=
 =?utf-8?B?MVBNckpiZUN6MEdKZEZ3NG5TeDBvNkpianpSYWcwRG53Mk1pVVlXR2h4TFNR?=
 =?utf-8?B?MmNndkg1OVNSbm1CZjdiNk92dW1oWEdvTGZ3aUEyMm5Dd2c1NE1SdDdjSHZK?=
 =?utf-8?Q?kiu8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b06a7f2-fdcd-43ac-b06c-08ddcadf3fe1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 18:23:55.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W9znUSGh4wNCSt+TX1BgV8Pp6bUsN16ofc/RMN3szqah6TF0Uh+ToHTqMtX7Vt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF72C0AA731
X-Proofpoint-GUID: Eu4FJKeK4FGPLAgHeTIACcHVYp36C3He
X-Proofpoint-ORIG-GUID: Eu4FJKeK4FGPLAgHeTIACcHVYp36C3He
X-Authority-Analysis: v=2.4 cv=Y/j4sgeN c=1 sm=1 tr=0 ts=68827a3d cx=c_pps a=xMIE5RCmi4zid/p+q/zqlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0BpIH8p8aN-gR1wCjNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE0MSBTYWx0ZWRfXwPhBQBeFnXZb gw6c8wVCqu2JkKYKuLcs51Yf5TlDO0tV90otj/CkF+kOIRWiNRzZR1BjAKyEQdqfh/dbJwJw2un IPnp0TFszA1iKeplUitRkgvkOmyzFREXZPadagoDqeCoi8jJhcmKhXUTnj0LIeKE4TMWXzm7/BL
 bma6ZXaCt7LZt5LZmejDJL91TTqlV6oAIPfb5Y7Q/3DW43sf0mpyoj1WmLdp5CsZvKoce3o5oNE IuXzbPSi+dkiJ2ZO8Dcux3uSYdKmaVS+MLyMNct50pVUNz0Aje+IUzKD9PaqQpEG78L4/R7UHWE xVHi1FJ4wQ7Y0k+2DOz9rLZTd9Z10T7IwgB2yxqZCk+p5HpffhO6E7MCbUaxcateWNbcCovAgZk
 /fToM1EVkqMvYT503EvUPfClru3xfuOjrvpn9wy+n8Zdpqj4to1GpbGWgllCTKZGfCgGd67+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01

On 7/22/25 1:20 PM, Chris Mason wrote:
> On 7/21/25 12:37 PM, Shrikanth Hegde wrote:
> 
>> *** issues/observations in schbench.
>>
>> Chris,
>>
>> When one does -W auto or -M auto i think code is meant to run, n message
>> threads on first n CPUs and worker threads
>> on remaining CPUs?
>> I don't see that happening.  above behavior can be achieved only with -M
>> <cpus> -W <cpus>
>>
>>         int i = 0;
>>         CPU_ZERO(m_cpus);
>>         for (int i = 0; i < m_threads; ++i) {
>>                 CPU_SET(i, m_cpus);
>>                 CPU_CLR(i, w_cpus);
>>         }
>>         for (; i < CPU_SETSIZE; i++) {             << here i refers to
>> the one in scope. which is 0. Hence w_cpus is set for all cpus.
>>                                                       And hence workers
>> end up running on all CPUs even with -W auto
>>                 CPU_SET(i, w_cpus);
>>         }
> 
> Oh, you're exactly right.  Fixing this up, thanks.  I'll do some runs to
> see if this changes things on my test boxes as well.

Fixing this makes it substantially slower (5.2M RPS -> 3.8M RPS), with
more time spent in select_task_rq().  I need to trace a bit to
understand if the message thread CPUs are actually getting used that
often for workers, or if the exclusion makes our idle CPU hunt slower
somehow.

-chris


