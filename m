Return-Path: <linux-kernel+bounces-721931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECECAFCF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0541F48103C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29442E03FE;
	Tue,  8 Jul 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsDHN3mM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LA7T0Lls"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8572E040C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989688; cv=fail; b=QY/ittmj/aWxzRBOJ0v3kRoDJgOXxmS8X6o9gK64CYibdg1cS7JaEaf8uruiGBymoadB86H0U7fxqJn5bw6A8cj87loVnl6TKytByYpFXOxUqkOPfEGH8Dbotnq7+8alopGuO9enhNgDiwZtGL7l8RAaeMCmzqddyf0X7KQ2mTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989688; c=relaxed/simple;
	bh=mW/kwUr+EAA82Bk2h96tAGz5TvZBu+rilh3R3Fhoq6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IEUukSj9cwzRmB0i9RoQAJr+IzrMuF7CljMj2i3LHild4jRPf8ABl/FhypbO6LLiF0yaPoZT122StR8HwpG4QjDOb6gGXKyx/mlHbmPdLjRWf+zFoHSdWmC37Pa0dcqsexwys5GqfTCmPIMGVjmy8ukBqEPyKCp4rZSGGzW5tQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JsDHN3mM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LA7T0Lls; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568FCKbK001753;
	Tue, 8 Jul 2025 15:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=252yKSuIQAA9RTnBxSEbnbCglIrj0rBRNQNuJdJWMvA=; b=
	JsDHN3mM+Ym7jGQqoWRwF4r3bCT+cvwW6BdlGLzjlH3CUtH22FpQYyNerVLO+CF0
	FUpwqR/0CfRfN8TFLsy3urq31MNSV+u6VKGR1avOaf0g+iHMRH0k7y1XN5/21Sum
	JKq4ZpXDVYsT+3k/fJmZN6eV0rLbwDaELPxhTfwn7UtWd+vkQW/gDMleCE4K4Jcz
	c9ukRs9N2YKLoyQrEY84P86p20/ThYKvUoU0s6zy9TAGOsol2Wt32zKFb/Uf3dNN
	YLN7Fkwejc7vyWTHkAE1cTh3YW5P60SzS5BGeCUc/er009KWp0gBWI8rCl5teiaR
	mdZGcWz0PJQhO35KixwxVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s5rtg2ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 15:47:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ew1qo023665;
	Tue, 8 Jul 2025 15:47:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga2129-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 15:47:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbeHHvB9AT+ADeisLUZQnDkOhS/Ghz1jI+8gp2VgvY/agjMBaNwOWlHu5Gtgb4dwAUOhe1pUmvig3ukBqUirvjNwHan7BlCmZ1QQJiPrpfb15Ptas4my/fNKgkWi74E7bmKcV63MKxxZBOZlrgZyQZ8s6IGJSOKMJAfTYXfV1B8aV06xC0mGG6MNKTVLME+RS+fbQOI8kL30JQgs2OXFV2+eTaHeieWqxWsDARaMw2kp+dViloxu3EStDJi924RcLC9uUoNUdmXqukNfz2hC15uuagsL/dDEJePdvMl/gBKWHgxhMtZ+73fAHy3LXrZIe5CdxUiWlv8O684SQqueuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=252yKSuIQAA9RTnBxSEbnbCglIrj0rBRNQNuJdJWMvA=;
 b=rOZr0dFWepnEuKAqifBwlj8AKZCI7/sj15Tp3pAenFWI9RrJF3Z06Ugginfr2YKpxVgWODOkUUPa6dWkR/L4woY77jhHiXywh+l/7Tql9HcuHjBK3xLkOZgpmIsU1akMY4t4mLm0rudOJ8x5hjJ9RU56UbUcxieJBCF7W7rveRP6/9eAtUo5My9GwBgu/K5bWmY64xbJOJwihCq6myQdV+qIsG6gE39mEuF8TrLqaJ5f0z8fABZz+09IFYu3FWg0TL64RhcsK5FyXCRKZXokzA3ahMzFf9YVZOg1/G7jpLXCT0l4YwHar2xy07AbOAsbBxr9g6GB5BwaGq1Z1AAgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=252yKSuIQAA9RTnBxSEbnbCglIrj0rBRNQNuJdJWMvA=;
 b=LA7T0LlsI65j+l8jtSe6ag3u/AmMC1JSmpjNMskTW6dDDq7moceTXKYTYePlSwetuzfqbLEgfFK8lKUrQjjskbZn1m2AZ55AhsvWSqcyAzvw3w9jlCX9WKfbW785umMQLwX32/HJCECJyI+pVSeC+aK9/8JeyLoWAfCgrC81x7g=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by LV8PR10MB7749.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 15:47:40 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:47:40 +0000
Message-ID: <7aff826a-87b4-43e8-9b15-19ea5f043d16@oracle.com>
Date: Tue, 8 Jul 2025 08:47:37 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC patch v3 02/20] sched: Several fixes for cache aware
 scheduling
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
        Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <d73418022de76dab9f60c0c5432d783b3b2833dc.1750268218.git.tim.c.chen@linux.intel.com>
 <60a01353-c1f4-41ea-99b7-a300aee35bb1@oracle.com>
 <4942856d-ad2f-4922-aad9-20a902dae41b@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <4942856d-ad2f-4922-aad9-20a902dae41b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|LV8PR10MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8932b26d-98db-4a50-64fa-08ddbe36c50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek9odVhJNWhDcDRrdkVTam9yU2NoQVkvdzBtOW1pZnBHZzg0M2xxR0x5NkI4?=
 =?utf-8?B?Y3RGclNKZVcxNm9IY1R0WVRFMy9wQXZtZUZyb01vUGtReFNpbGhNRWpzU2l2?=
 =?utf-8?B?MnBmdUgzc0lYOWhabW14bnZZYXo2REgvUW5YNW5MMEJvRXd0b3dsbXIzREtE?=
 =?utf-8?B?MG51eS9XeUNXNzZDSm91NUJIZGRuei9SRGVhZU5kUExDTHFWWWpLeHpXOUxZ?=
 =?utf-8?B?OC9sejAydjh0V2dKd1VCU3hPMzM0aUpVZGpVUGwyYzhkU3FSSGlPejEzU2NU?=
 =?utf-8?B?Y3pQQ1owU0VtUHU5ZjJLVVZoQ082aVo4WkQ0WFdjYnRnWVl0bkVURnRzU0wr?=
 =?utf-8?B?UGF0c05SVUE0QmVzeDQwNzQrbHFzdFp1YnVVSFNZenpSZGJiQlY4dXo3K2di?=
 =?utf-8?B?VWFWR0J1N3VPR3F2MUQ5bUVUQ2NMbWM3TVhyL2FuT1kremRLMTlsdytjYTVy?=
 =?utf-8?B?WWVDVkxWMFZNTUNNTU1wb3dNaEFMem9lSE9teFNtZUNDMnJMTkFkT3diOWZj?=
 =?utf-8?B?Sk1hTExENFFJQlYxbThoaTduWWpTSnY4elBhL2RMUjR6TnVobEt6RWJ2b1NB?=
 =?utf-8?B?S2loekpLWjJkMmJkT3p6bGxTZ3FLbklTNzZhN3plc2c1Vnd5RThLamJmM3Rl?=
 =?utf-8?B?YjZydFppeFJNY3pGUXk0NmhqdENSOHVSc1lxY0xxZUxWVHRBdHg1MTFUdkto?=
 =?utf-8?B?SHRnVzBsTCtZZ0lLbFBqa3QwajA2T290aGlzN2VtOVdYbmJhY0dwZkF3dngv?=
 =?utf-8?B?RkhxOG1kcm9jc2FRdWkyMCt0VzFaSTl2YzU3d0UzZ1I3S2dMazBBMWhla3o2?=
 =?utf-8?B?Q0ZkbHUrQTJzTU1WRmdNMzJIOXo2bzlPSkMybXlKdHFMc25TeDJZOGNLa09s?=
 =?utf-8?B?UCtEZnNKNVlRSmJndjIxQUtuMExMVy9iTEZvQzFQT0tDOFNlaERyVysvaW9i?=
 =?utf-8?B?aUVxeU1ndisxdVBuK1ZDQzhJa0hjYTFoWGV4ZjNWRFNPSmJTQU8zNVlkSzNu?=
 =?utf-8?B?SXpXUUo4Mllxa1NqTm8wQzNjTytpdENmS0Eyc1J0cnZGeVFodnIxdExVd0ZY?=
 =?utf-8?B?R0g3NS9XRnVxTnl0aytmZFZ2Zkt2dS9SRExJbC96ZjdVd2E5QnFvdkd1OWx5?=
 =?utf-8?B?QWl4RDJqanluNUphT0EvTyt3UHVaY05UeWFleld1cUVQZXY1S21nQ1dRQnZa?=
 =?utf-8?B?Q05jTGdZZDFtT1FPUmxYRkxkRE45NENzSHpPYVhsMjFNTTVUYTBVRHhMUTZO?=
 =?utf-8?B?N3kvYkJCdVI5Y2MzZkZOeXpkRzhUaWg4MDZwclFPdmhhcnQvQnlQMGRqWFl2?=
 =?utf-8?B?Y2FVYmdIVzI3RFF6WU5DNmZkWitHNzlCNnhmSkMyaEVibGRUcVJjOHpSYjdh?=
 =?utf-8?B?Yy8xWHpIbUpEVlJWVDUrcDY3ejZIWkd6UkFxM2ZXMjQrczVkcUlFYmVqV3cv?=
 =?utf-8?B?VWRNN0I3SG5lTGd2K2t4SzQwcUNnUWhMSWk5YXlmRlRkcHVxUHFQT3RCU0Nh?=
 =?utf-8?B?YjdkTGxPQ0tHSDlkdVFOMFZnckdKbCtJeVJvTDk1MCtUdzdBTnh1cGlhbmdK?=
 =?utf-8?B?bTVucTE5c01LTHowVUNRZ2UrRXRsVWgvd3ZTbFo1b1BLSGx0WC9XRU5GeHRM?=
 =?utf-8?B?R2NwMVhydTROMFBtVVFYTDBUYVpYYkszRkdNdlpURFF0bG53QU80VVhFQnh1?=
 =?utf-8?B?V3BsenVEdnRFYURlNmorN0U2THU2V1BjalYrdVRUcisrL2NOYXM3ZnR2aENT?=
 =?utf-8?B?RVZKK2F4M041ZVc2YVVWRnlQdUVZM3lnUXc3VlNycWliK1JyNjNsb2ZyRjF5?=
 =?utf-8?B?Rk5GRmkvdlM3czhHOUcwRHJxZi9GZ00rVGtTZE53RWtpU2N5S1V3RU9RZ0xG?=
 =?utf-8?B?S3puNzVLVzFjdVJyeWxraXVvNHFaUU5BUUlkYjBOUlNadjVtSlFxQUJBUWc5?=
 =?utf-8?Q?kkRWaNK/OxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1phSzVtcGFHQ0p4eWtFU1VEdzdCN0sxZVVwaG5wd0pWVzhRSXdVQ3Z6MGw0?=
 =?utf-8?B?M0R0NXBrQ2ZVZWtPREFHYjNwVlhMQm1PMTE3RE1mVFJEaGV4RmpVYmdCSEdh?=
 =?utf-8?B?a29IcWF5S2d5YTRmWS92VUJpVkNMb09McXRsVGNWdzMyRmErVDJJNk01dW8r?=
 =?utf-8?B?KzRmeXk0UXBGdDNaREZsUEptQitGSjJQMVJGclUyQkV0NGo3V2QveE5qbURM?=
 =?utf-8?B?bHJsOHNpOWRYU1dHUzlBMzhLdzlzTGF4QkRJY3BuL2d0NE9OdzUrYVlVNGhH?=
 =?utf-8?B?UGp5Z3VLYThNcmZ1ODYvaHM1dEpZMnBkbHBBR25BZWpxWHhFVEZIM1VWY1hW?=
 =?utf-8?B?NkdMZEdneTFNMW02emMwUVdzdVFwMHNnT2ZWdGxIdlBIWGxOblRvOG1ma3N0?=
 =?utf-8?B?cGJBOVdFWnFiSDhLUWNpcVFRVVFneTZEdUFpdzJkYzg4bDNXVDc1TFYyNDVH?=
 =?utf-8?B?U3R1Y2JpenJSU05xYlZvZVhReFo2emREU3ArL3c4dzlwU0N0aTFWbWgzVjE5?=
 =?utf-8?B?a3M2dlFOSDhLRWVZNHhJc2syTy9jWkxMTU84L0kyUFhOQ0hBK2lQdVZVV3lP?=
 =?utf-8?B?a0x5Nk1lV01UZTVFMS9rQVBqWC82UDVqRFVrQmNIL3dRTlRZbVJrK1RjZDlO?=
 =?utf-8?B?eE5iRkdaOFRHR1o0d1lLT0tYenJjQU1yejJGUHJoak1qV1Vvb01mbnU3QVhF?=
 =?utf-8?B?NTZ6ak1TWi9lak4zR3JxRk5PUnpkMHB1TnVRd1JSY2FFSEt4K0NzYjNjQjcx?=
 =?utf-8?B?d2QzYndHbFd1ZTIwYUc0OEJjb3piUUdVek5CakRTa0tpd2ROSlJDcTg1VE9L?=
 =?utf-8?B?NzNvQTlSbktQbGoxT0RySWJFbk1ONzBmeFE5TzNrZVovcDRTRFNBT3lINkdt?=
 =?utf-8?B?MHlHTVlUeHdGOVlxT0JBQWlNZGE3S1ZTOW5QZFpwclRINUs4cGFKVUtGTUVi?=
 =?utf-8?B?Y2dPU0Q5Nzh0c3ZDeGxNaFhvTUR4a2llbWRrakx1RldVTE8vZXFhMXVaZ0k2?=
 =?utf-8?B?d09RekJ4RkxhVk5MNGtpVjY4YWlYZ1YvUnMvdVZJdUJ6L1pkdTgrbU9MSkVC?=
 =?utf-8?B?NkZzNWxxRCtaa0E0MVpYQ0Jyd254UGZIU1BHa3FFY3FEcXZzaHVSbzJtUHpj?=
 =?utf-8?B?QnhlYUl5TFVibXIrSnVDdU1pN1VpM1lGZll3TTFLMFcrVDlzbHF3aTBJazR4?=
 =?utf-8?B?NGNqRk52Z1pPdTJlSzRTOUg5dG1oQ2pRU0tCNFRHbmNDRWVnU3VyTGNsU3Rk?=
 =?utf-8?B?UFdmV0tBRkF6WUVqaVJNSjBmOUl3ZVhEcmVqSXUrd1B4eTU2WS9Wd2M5UTY1?=
 =?utf-8?B?R00zTmdlSVVWUDd6K0Fob0NDNktudGJteUhyQldMV3MyMXBYb2U1ckRQSnl2?=
 =?utf-8?B?ZXdVS1FjSzg0Z04zalE4bUkyRzhmK2Q0dWp0aUpmNHMrL0p3MjFrZC94cDNi?=
 =?utf-8?B?R0VhRyt3bllwdzFhajBocDJzUXJxbjhzN2VGNGYzbERJM1EwOUlTWURFT2xW?=
 =?utf-8?B?UlMyUDhWeFpRTEY2MEk5MDBBUDF6QmNNK3MxWDRJWUpxUlFtMlBXekluWG96?=
 =?utf-8?B?NkxnMERONkovQ0t2NGdUa0ZlbUltQ3JtbkRzc1E0ZmJubzhLeFRGR1F6S3V2?=
 =?utf-8?B?dGJSQ2dRZE9xZFpFMVU1TGtWOHFBa1ZjRERSWWdjVmF6dUFXS1A5VnYzMDlm?=
 =?utf-8?B?WGVPUG5EcWRUNVhYOVl4aTdWOURuZCtjSndDWUlnSm4vWXRLYVAzMVRiYU1W?=
 =?utf-8?B?OThVTjJIUThEM2xPeVpOdXBsajJYOGw5QVFoNFc3ZFFTcWpjVUsxL0F3MzNp?=
 =?utf-8?B?eTMxbkxCZE40RnVDRElkRFE0RDJXZ2dna1JPa3hyS0xXaE81RGdhMlpFMCs4?=
 =?utf-8?B?WTRYZTR2aHlldDNWZnArNjEyRjU2UnkzVnY1dUdEbXlYcjYzUjlCRDI2VFB3?=
 =?utf-8?B?c3VHd2Q1VDg5YUhQalVXenVoQ1B3dm8rUUFqZ1J0TENjdHNvRWpOT3VvZ0dn?=
 =?utf-8?B?YmIrYXZGVHFiZVNFMmpsUjUvZlNLdWYxeGI0OGJBeWVpa3RZR3hZQ2NCWkhh?=
 =?utf-8?B?M1hMOTJqN09DWUR3alIrS3hPRXpQMzQxb1BEQzRSSlBEczhYcG0xRmJ2VmlJ?=
 =?utf-8?Q?A/Qou5Ky0Uacm7MoYhLu+fBCk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1+Ml26TGfBbCfVKIVpw7BORDt0RAND3Yg0WcfgBuMSXJYJoQVBz+pcax++p2w6+YG4azpHLyB7M2/kJV94LztnxUWwG7ttiKY6v4H5Y0FK04kHknDnhyoEmLr4ZhQAS60tXg2D8mdAOX2ZFFc5GHa77mpHS6Jj7cZ4/ZXkeeGI99etuf0m0aJNPwi17bXFzKNDCJWPsynG/QLk1aghsqrGRpzPXg2CqFKDcIv/IZasjxPpTHuZH6xZVEa+7RZqKpguDrQqHbbGKPIMXeEXBRjSp7G2YbvBw45GqwXNmiF3whOq50gZrbRIPgAnyeGYxds+rCf1ZVqhF4DYv2dL/uEauo8z4V+oCnuyTlc03gYXs82C37hs8bXTPBeJsTM9oq+RzIhYCvVSdEqnUbrjdAUhLtYT4Ji3XyxLPLEGE69SZm3QNYPD2Ry8OJPDys2R+sdRpPHzqGoQhDV2Y8xZu07/kiJAC4qXoMROyidn8Mskk390/G8H6ALMskIpjnlp6r0VpL821syyrVSAjrQxju4IXzkspCGAnyoshQdVmrz9Eog8uAR0p9wDzQXQxX39RSnShqjLCZ7zeRSJlUzhf0Gz37CsWpBQoLug1PxxFfICE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932b26d-98db-4a50-64fa-08ddbe36c50c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:47:40.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IauDwiKmeK1aWdHPBR+NtFYwoYjE3xTaYtF022p0ojbdOmbS5nxBnVHYZDO4kj+8v6uT17ylkMZRUPzwFLhmPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzMiBTYWx0ZWRfXxpgk7DrpJlSe 2NwKUGd5HXUdnpmwrbGxX/DcUu4zn4O1jul/jYcHM0KhU8AAPN2f7xVc265qBnmX3OwBRpLqCO2 A86c/5r4ROZyl18nNJdiuFf1iOSUfXO9MSlCWw7HhHndmnglfgyWWHQ7XR3UnYodaVq+dlCNBDu
 cjEot+Fp4KfA/GF2jFQxk0x0sYuyXYJBKtwuXL+DvFbiwYZz61mWBYqSz4HB+y1s5QU0Fu36tXM t5wMovCZNxutfnFHx9BKGpH/LFyp1HTgtKrs7UNw2ZoizoguAXn09mZSMfnZQyGDewRcXVfbUpC rdfBZJ7wZ5y7iqjf0qPSHbtaUwZbtuOX/UdPuQ7cUqRcVDPyEbY3inMJqijS3OAYtagk2r+GKIP
 BRBiyFfN/IrwjsZ8Z2wKWNv7sr5r0Ai8LwtWEdy3wczyqbpuWAQ0ELrLK6/GxCKS3d4YQb51
X-Authority-Analysis: v=2.4 cv=ScT3duRu c=1 sm=1 tr=0 ts=686d3d9f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=c71Ja5t8CFRXceOv2-4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8uZ6CGv2SVsij0-6C3KZGugwpDSEh0SC
X-Proofpoint-ORIG-GUID: 8uZ6CGv2SVsij0-6C3KZGugwpDSEh0SC



On 7/8/25 00:54, Chen, Yu C wrote:
> On 7/8/2025 9:15 AM, Libo Chen wrote:
>> Hi Chenyu
>>
>> On 6/18/25 11:27, Tim Chen wrote:
>>> From: Chen Yu <yu.c.chen@intel.com>
>>>
>>> 1. Fix compile error on percpu allocation.
>>> 2. Enqueue to the target CPU rather than the current CPU.
>>> 3. NULL LLC sched domain check(Libo Chen).
>>
>> Can I suggest we completely disable cache-aware scheduling
>> for systems without any LLC in the next version? No more added
>> fields, function code for them. This info should be easily
>> determinable during bootup while building up the topology,
>> and cannot be modified during runtime. Sometimes it's not
>> possible for distros to disable it in kconfig just for one
>> particular CPU, and SCHED_CACHE_LB isn't enough for removing
>> the added fields and users can turn it back on anyway.
>>
> 
> Good point, my understanding is that we should introduce
> a static key similar to sched_smt_present to get rid of the
Exactly!
> cache-aware scheduling code path if either LLC is not present
> or there is only 1 LLC within the Node.
> 
> Thanks,
> Chenyu
> 
>> Thanks,
>> Libo
>>
>>
> 


