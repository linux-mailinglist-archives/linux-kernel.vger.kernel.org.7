Return-Path: <linux-kernel+bounces-745960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D519B120F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50283B2CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0B2EE980;
	Fri, 25 Jul 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UvqW0i9c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9/NBWrO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FC2EE61D;
	Fri, 25 Jul 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457402; cv=fail; b=iVfKR3pUE8S9lsYOCWD52bvtfkOm5ATIblrT6LvTNdQ0ONNxdO8mFa9RDrxWA0d9ZAR9WrioRpJlNe0WFY/fnaxNAAwGMjauHQp1lxSraqZ7+uca47n5c2rfRaWe81yBt80UbgErGqpmhxgzvMUDqA3WJITRmd1vO4EbkuQ+XJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457402; c=relaxed/simple;
	bh=DHMi55TnChT1+f7/RPR/PWABxeBM6/HowlaC4JG584w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kz0FB5VFSH9v98TvLaj1LhfO3/sIsx4F1BPIA0XnqMhE9zgfpNlUmCKSrQSiREA/+viVXBPiLzr462IWJtsCCXDFYoywybXwgaZFhlsan97lGIsbJW4voufUJHNQWCnlwxlfzmW+yPoM5N6yExk7IUunRAvZZGLacX0Dq/UsrNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UvqW0i9c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9/NBWrO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEJ2d5032490;
	Fri, 25 Jul 2025 15:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3wWCFdtPg3fH0TmN7cIhdkWfdzAKppI3vPqAxqFi27k=; b=
	UvqW0i9czZ6aeZfdnPpQOMsuw9fXIHyOCtGpnXqxEsuWU8BqrzHYUyiRrTwDyuRC
	jmohQcAXSdqRuvdGKxcaCR2Sq9yjd0wChlZct3Bm4lstBPCPZ2P4bRXzXh1DxAGd
	/WKtUCxj5IAHSFyV7rJOSSL4NNfmyqWhj5RmG524Mwx3dPssnTC2EJSyBVW9jkzb
	JJhvSRoVYeNyYP4Zm3c+MzR+zNMsxitbzDckoE0pVG05PcHwMzA2+ax32+H+FWGi
	xSSoEHpbF3cMnIeuRvQO2XzKrwT0SywJZq3efMaRI+9Gjl0dgYTJg60MK64ws4KU
	A282wJZbGpZyxh8TUY4dYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wh9ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:29:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PDp4FJ037690;
	Fri, 25 Jul 2025 15:29:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801td8e9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 15:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leoffxxOkHkLX16oav58nlsSi9h4HuIU6sK/CIr5EZzVX3eoAOZN+ds4hQNEqbvW/OCM6MKsL5UnSxiHRirG0bn0SZn0gZ/I/MBO9/o+3OlVHZreheW1RDZDkuRZWYlRkgnSo3o/1bOhq2ddiK3zce35/86ESNyBMIqtDYhoVLRJ1zqltEbgeyaYKrzzmJN5q47YuW0wVp2AHY0ua9E50lCVdu17N+UjzbvFsU7Jq++IY3P44iEJ9PepnSaNgxP1iZeCKYRSdfl3feFTN5IxJh2CmlN+y6/pZFZaqa2/EP3Z7JDuU4vRaLZKOa9jyJ1WbST6tDEjSOHPTRG6sTW0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wWCFdtPg3fH0TmN7cIhdkWfdzAKppI3vPqAxqFi27k=;
 b=RX5dsOtRpPqrC0nKQ9eeHDuHlqqHEvi4m+VjpC+j29fs/krbxipIjMAJzH7v3eSlQKUwcjczCGSuki0SKdNJWTnAwv0L6AEIkQxZorQnGDrEhTUBxkVJ0SySmh44sJK0WaHtQllm1eUHEv76ycd3rrJnWgcGFzwKTZJvxecGlitAZOsXzg4Zydg6ImCkqmwVvjPv6IMLVsQ6MYZdcWpz54XcR/g6qKlZU7XQy+wrQehGCbhhjk+yaFROgfbpj8QgO3TNnhgPni4K0ITxD3Cc03F1Vo6MNFD5V81v6iTnTqsOVHmkm3vjAst7TBXWjmD08/zwIUBg4VC2KYwXhDSlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wWCFdtPg3fH0TmN7cIhdkWfdzAKppI3vPqAxqFi27k=;
 b=g9/NBWrOdfxeM3re2zuMuQPrAzvVrk6SQ07aAxE+T+DGyqx056L7idovYaIxPJLsnyhaZP91Z3pazvntD/uwtNOxJpESNDNb8ktC+kvMbwiyfkFKebF7iqfkViywcYwEU1ojHqWMNzu0ZdmHKYkwvbWtHkIjlmYettkWcbE83J0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 15:29:32 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:29:32 +0000
Message-ID: <c093effa-a21c-4fef-b3c8-a445a57ba0cc@oracle.com>
Date: Fri, 25 Jul 2025 20:59:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
 <20250725004533.63537-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250725004533.63537-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: affbe3b6-72ed-437f-9a00-08ddcb900dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K05naGd1TENMeDdpVnZQc0FNR0RKRDkrcEIraHFWT01GUmJLOUlWN0w4SVhY?=
 =?utf-8?B?QkdEYTFreUwzUytjT1cyQmtiRDN3K2pLTmlrRHRubC85MEpGeWF6Yk9BcEtN?=
 =?utf-8?B?bUZMcTRRN2JJdytLWWZiTFZoM1FIZk1Idzhla0pVRUZQL0dsdExPamdlNW5T?=
 =?utf-8?B?UVA4VWZudEJUNHZKY3g2TjdEWDE4b0FMRDlndzBmSzhyWDNhZXpDU2k4M3Ra?=
 =?utf-8?B?QTJsOVptK0ZMRjN1alU0RmJRZHNFS0swM2FMQ2NUQXAvdGgvVDZQM1F2ejZY?=
 =?utf-8?B?eEd6akJGRWViLzNqNTAvUXVtU20wYk9NRG1zUnFyYnNyWDYyVnJEckJZVVlQ?=
 =?utf-8?B?ZEhnazJuVkpUZzNIM3hPVmFKWW95SXlJR0cwc1B3Rm01TjJWbzJFbkhlaElZ?=
 =?utf-8?B?by91OVVVWXhCaDFLNVBGdWowTnFGK3RVK0NOTmh0TC9xeDFvOVcvazBJbnh2?=
 =?utf-8?B?ZTB5SHpBK2Njc1pUMUtJRTBEUFN3NGhKQjlmRWIzOXVhNllydm0yQ1V1Tjlr?=
 =?utf-8?B?SEVGaVpKNVFJSzJUUThILzN3OXNCSml1S2RGWGpKL3FySjkvVkNsVVMzUTV2?=
 =?utf-8?B?alR2OWtqY0xtZGlySmFXcXIrS25OQWlGTjlWQ0NXb2k1QmRQNDg2VmMzb1dj?=
 =?utf-8?B?MDJvZ1R1SW4yWTl4cjRaV3BXSVdZa3BYT0RYR1BlcWJwbkQxaVNvMldNWnF1?=
 =?utf-8?B?bnpiM3luQUN2MmJHVkVid25XL2R1MC91NmxRK21LUFkyMEdvK0FQK1l6NUwv?=
 =?utf-8?B?em92aitJTms5WUxmdFM3VFFmSEFWUk9WVkc2SG1mbFBXYmZsM0g0UDM4UklO?=
 =?utf-8?B?MUVTanJGMXJ6ejA3UldnbWdhK1pYRXZhYUJXZk43TURWaHBVZlRrUVRNNkdY?=
 =?utf-8?B?NytoY2ZKdzhUektXeTd0eUZ6a2tPeStpVTdmNEloM0RFSTZiQ0tYWlpCZFkv?=
 =?utf-8?B?NnJuYVpUZkdJNHdBS0hYMHd2ZWlxbHcvWS9uWlNSQU50bndZVmpuRW0vQTNz?=
 =?utf-8?B?eHlFQ2JVbnR4bDFZVDNsNTZ1U0xuQ01YcE1OT1ozRkM4OSs3amYzMWdORDZx?=
 =?utf-8?B?aWJRUzhEclVSY3NSVHoyUjkxcHZaSlU0ZFlsbVVpSklWKzc2eEUyays1Z3pW?=
 =?utf-8?B?MkJQcEwyaXlMSnFRZVFwVkI1Wm8rMS9OdXlQK1JqLzlUUWc0enFIcEdRS0JC?=
 =?utf-8?B?TGcxS0hZUkFjMkNVVDN4U3NreFJiR3ArS0xEUWhwdnByWVcvZ2dmKzAzOEkx?=
 =?utf-8?B?MC9ydHZ3RzNacVh1RDhScXhLb2VMRXUyT1c0UUU0Tk5laW14TU0yc2JuUm5l?=
 =?utf-8?B?bDBqa1lnajhOMDJhVUtOOENScnFkSXZvdG1SaytWM2JGaVNEODJtMmVBNjAv?=
 =?utf-8?B?cGI0cXZ3NFhSa2ZyRmpldURFeTkvd1JLK3RZQUt6VndiSFVPWk12WnBLdmpF?=
 =?utf-8?B?Zit1RGVuSzNRNEFYSHhYWHpTUWRNdXFVcmRBYkl5RDVpc0JHNzRpYlhDK3J2?=
 =?utf-8?B?dWx3YWpVQ0hmUzRuSmlaS203eXhhbHU4Y0Mzcmg2OWRCbXQwcHE2OHBRZ0xX?=
 =?utf-8?B?M1gxR2ZhdWg2MWsva3FBcnhLRVJPVTFlM3R5WnlWV1lzWkxkVWNkUlpGNjR3?=
 =?utf-8?B?VStWMTVqQTUrOG5hWk8vdEJpTVFGdEs5NVFSd1V1d1hpUGNRZ214ci9obm5S?=
 =?utf-8?B?cWUzeHJrelplVkUzUC8rMkIyMkk4TnMwMGJvemNubHVzVXpuWEpIbFBHOWlh?=
 =?utf-8?B?b3NiL2lNMU1MUGNCRGV4aDEzRFphZ2VDdGZraUdReDZyWEZMNzZOSGQ1cE85?=
 =?utf-8?B?ZUdxYU5BeXpFemJneElERzU5bTVOUGZva2NZSDRPQTlHaUQxMCtKMnVWNFl0?=
 =?utf-8?B?U2dSVk9EdmZPZ0tDVHM1a05CRUx4ZW5SN0Z6d01rbUZvWTB2cHpqbHpZQk00?=
 =?utf-8?Q?n88D6/EdHdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXlnTk5MN3owa2pXRkRpVGgyZFg0M3ZtOW8wUVdzaWJCaXFYNWZYbzRxYVA5?=
 =?utf-8?B?bXBuMjVBMFVXc01tZmZLdWt4Zk1RZ0RtMTM4S0M0bk1ieGxjc1lEYzBHZW1Q?=
 =?utf-8?B?bVVWUnJPT0ZtUVY2bmlhd0RJY2d1bnVWTkxDUXBVK1UrYWVmWkxGanV1c3Uw?=
 =?utf-8?B?SVAvQUpBT0Z3Yk9BMElCb2o3dUlqY28xSnpQY3dPSU8wNGJyRU45eERnekJn?=
 =?utf-8?B?SjVrVUpVcXFRcEwzM24zQXhkdzREWEhuRFpNUVgrbzBGc2RQNGlhK3lEbklV?=
 =?utf-8?B?ajBvcjcwUHFPbDVQaTg3djFJL1dTSkZLUWd5YmRtZk1wWkVCZDdKZWM1UVk1?=
 =?utf-8?B?VjBoQlhqU3JjNzlYTjE0RzNLa1FVeGhLMUlmZ3A1aW9SN0FuSUxWSC9CVm1p?=
 =?utf-8?B?QXJ5dWRPb1pNY2FYNzhoR0RsdEgxdE1jbWF3THJLTTJJdVlrK3RVV0dEMmZ6?=
 =?utf-8?B?VFpOS241OTd5NmZXM1paZm9jYVg2TWlmVUdMYkREcUdnZ3h3TUZxNEZ5a3JB?=
 =?utf-8?B?U0p6Q1FNakMrellJNlpKVUtvREdiMlNmQmNKTmRCUzA4eFgxQWU1Vjd3eVF2?=
 =?utf-8?B?ZnhwOFZtZFk5cmlyYVRxOUJTbkpyNjArWW9zNFhWNWh0eDB6cWNxUkF6M3cz?=
 =?utf-8?B?MTBIckFhSEZBMGZWdUxkUmt6V1ZlS1BVWDJQaHFZM2FHR3lFZjhncXlMaEl3?=
 =?utf-8?B?aGE1c2NrSlJSTmtJRGNyS0k2bHl5MkRvSFR5WW5ENG10Ny9ySEZFVGNSOGRD?=
 =?utf-8?B?ZWJJRDIxQ3gvNlRDWmN1Ukt1eDVYWGovczlhNC9QaXNxeGhCcE0vZ3k0U1dQ?=
 =?utf-8?B?M3dQSW9RSjBwMy9ZZmhTTGlSNVh5dkZmSFhlNFljeTQ1bDlTcHllU3dwSGNi?=
 =?utf-8?B?MHdlMHhaQlJIQlNzZnZMWkZKS216YkhhR3duN1hhZHFGY3V1YlBFRzc1dXVR?=
 =?utf-8?B?Nlk0WnZTS3J3QzVaRWtvTDQ1a1VuTGNBenJpd3NIMktQTVIzdGUxU2IvbzB6?=
 =?utf-8?B?eCtSdUxmTUNQN0QxeTd6WGxwdldVT0lCYWp0RU10Smc4R0MxMHVqVURTZHh4?=
 =?utf-8?B?aWJyR3dFanhHYzJ0ZDVJQUlyS2oySmRIS1luNnNQTE14Zm5Pa2syclBQcGJv?=
 =?utf-8?B?Yyt4QUljUWFWdjlScGRtSFBBeVgvdEEvV3RJbE9EckxUb1pFbms2RDNXalpq?=
 =?utf-8?B?VmQ1cW8rUUV1T1l6YVcrakMzcDE1WWRzVlloZGp1VTBtT202U1VDZXVFWmFy?=
 =?utf-8?B?TkhXWGhld0Z6UDI2cnZ1aTBvengxSnFvM3BmOFY1TjVqTHgxS1NoSFM2eVZ2?=
 =?utf-8?B?dkpZOGFZbWN5ZlNZWkpxYVBYY3RyeENObktMbG4vejFCN1FoWHBGUWxNdlZq?=
 =?utf-8?B?RzdQcXJoWmk1VUJrMXVod1VnV01GOE94U0t4d2ZaQlJra0o5VmRBQXFjcVBr?=
 =?utf-8?B?VytZVnZGY214RSs1cThMaXE2NmdxSXN5MnFUMWpybHp3dDgreEdXSGdhVjh5?=
 =?utf-8?B?WDAwaDN0aURnOXh0L2pKc2JSRWwyYmp4MDh6Uit6NldXc1Q5dDR3NFNJSTVr?=
 =?utf-8?B?ZmV5V2JnQU5RNjgrN1BicHcyV0RKcGdES3Iwd0syR0ZpNVBmbFNNcHlqZW4y?=
 =?utf-8?B?aFBLc2tSOEFlTXJSSG1rcWx0MFZnaVkvMUxhK1A5U1cwSG5xdWNndnRSMG5T?=
 =?utf-8?B?aGp0cWNMRzd1TkhvU2QrVjJsNmJHTHg5eGlrNnM2STN1TE9DN0MzZHRPUWFl?=
 =?utf-8?B?dlRnVVU4WEc0ODU2Y2dSdkdmN3oxZkV1ZnFIa0RJT055SXJ0cTV2L1NLN00w?=
 =?utf-8?B?Y2dEZFpQbVJ2dzV6eWloU3ZaQ0EyeU5nV0l4aG9RcGdSUHYwSHJrd242WEEz?=
 =?utf-8?B?MXU1Z2cyTDA3bUVkRUxyeG5DNzZzNnBxS3FZWXFWTW5GU0lyRGlBWVpWWjV4?=
 =?utf-8?B?QmFsZkZBQnVmdzlsZGVEQ0ttTWNHZkxZekhVT2YrMEZXNUZycysvWGRSVmhi?=
 =?utf-8?B?NDVtbzVhWHN4U2tyOWE4Uk96VDUyUy9WSGNQdlBhZ3lwZWJNamVGMVJwc0hq?=
 =?utf-8?B?UTZIbWRDR1Z5aFVyWHYzSXo2Q0JkTzFuL0EweUNVbXhiWWtFbE1XV1U3czhG?=
 =?utf-8?B?dWlvN3prUmdocFNuMHoxNmxPWlJwaGdVQnNxSEMzZTZkUmhlZ0JreWt2aXRa?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ExmQI63hH7IFGW+GTiKN9Lx9TBZGz7zAWa1d64t9Aks2+zkDgVjB1Unk4teA/UirO00fpcvKOM4skgYejUPwDn5IAw48JiNZKPoRDvvqr2vpwB7414/lPQ2ok1jXSdordG5atDG97Ten3Z+Elz1rsC2ylMeB6vMr8dgmSEA0a1gPNFs8Vbri0uIWhI7l+X9pGe5SZZK5Xk24/e5tmUEYj0tmyyvrCd5XnvPPvLb186Sxre88WNR9PlS1JDGoBwSK8bAKSa5f35qUXJCkRMLHmg1o0XnxAJC3bd1oGGqHO7k3sCFwu+T0H6ix+zlavlL7gagHkCEaliHooGZJFZgHSHXCqo2GlK6RVDWvnZsCOLUlnUN6PUVcUFAVtyZ3TQNyOnF/8WArpxG3jgT4s6yU4v6AEJcRQH0LObLAVtWgGkR6Umt1QLQ0GrxxV/xYOktYckplcs7vH41WhW8m9gxt3aMfiQB2B0TlGIAo6hVQlkX1s8tg8Eg/RF+R2crPYpBVNYw5n3pOOxeZoxfRtTQLRu8oW33g2l464LU/3+Af08M6Y7tUVz3qbm2lFTU2/WGN1j9ZGKtA1zFNcsWtZ5SQXfVSdHTtdby8HxDma3M2Yo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affbe3b6-72ed-437f-9a00-08ddcb900dd2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:29:32.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwjyglr/gdrE/9YOugJZ6I4oKYsJlhVdsyFbWryhreKAJn9/l5GPTm1KEXVjxUi1GIGkpf2PQlYoQFjWLXx2IUcidjQMxW/5M14FW3xX2WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250133
X-Proofpoint-ORIG-GUID: GXNlWKptqArYArhtFVArrtSoAuTrUOzu
X-Proofpoint-GUID: GXNlWKptqArYArhtFVArrtSoAuTrUOzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzMiBTYWx0ZWRfX9QMiRkCvWrPc
 +jtyasr1qZa+dykv3AQ5QHxD7tyo95K0pJcSStc0cBo48tG6E8MFBQM7LmkskgV8rDasdcoymKP
 9Qk+p9cifbLjSH/pUOUY7h3RXVaBdVKoeMgFg/LxPFEgSMqgCmPEaKHGCGha3LskrI+NOi9C85R
 epwGv5mhKciLhaAnK992PXhgJgCvKTSG1xCOJd7wuYxqzuwaZu6Im0DhoCEZXe0hmtPa9+dVgXy
 dOQomNogRaNcVnw6hsG3r4wv0fwDW2DFvcshOpnJ/KMZKHUnB55mK2pS2KEItDkXXqVpgAXn2w7
 LGdnWIPOJniIQqzpjwJ4GQI7WQtN2DH0r1vPKj27uYHFMFJj9HCnqytXJ6ywj6IN8ER8Bj76FrA
 cky39bFV9QaizeKvfoXubHxoALucfJY2vUwGIYwwcoS//SbC4cScof7BCdckvvCr5dCeozLw
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6883a2e3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=pGLkceISAAAA:8 a=9LD0AG3-p6ra_FVAFkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12062



On 7/25/2025 6:15 AM, Derek J. Clark wrote:
> Adds temperature sensors to the ayn-ec hwmon interface. These read-only
> values include Battery, Motherboard, Charger IC, vCore, and CPU Core, as
> well as labels for each entry. The temperature values provided by the EC
> are whole numbers in degrees Celsius. As hwmon expects millidegrees, we
> scale the raw value up.
> 
> `sensors` output after this patch is applied:
> aynec-isa-0000
> Adapter: ISA adapter
> fan1:        1876 RPM
> Battery:      +29.0°C
> Motherboard:  +30.0°C
> Charger IC:   +30.0°C
> vCore:        +36.0°C
> CPU Core:     +48.0°C
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   drivers/platform/x86/ayn-ec.c | 89 +++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
> index 06f232bd10fa..b2054dc2358a 100644
> --- a/drivers/platform/x86/ayn-ec.c
> +++ b/drivers/platform/x86/ayn-ec.c
> @@ -50,8 +50,16 @@
>   #define AYN_SENSOR_PWM_FAN_TEMP_4_REG	0x19
>   #define AYN_SENSOR_PWM_FAN_TEMP_5_REG	0x1B
>   
> +/* EC Teperature Sensors */

typo Teperature

> +#define AYN_SENSOR_BAT_TEMP_REG		0x04 /* Battery */
> +#define AYN_SENSOR_CHARGE_TEMP_REG	0x07 /* Charger IC */
> +#define AYN_SENSOR_MB_TEMP_REG		0x05 /* Motherboard */
> +#define AYN_SENSOR_PROC_TEMP_REG	0x09 /* CPU Core */
> +#define AYN_SENSOR_VCORE_TEMP_REG	0x08 /* vCore */
> +
>   /* Handle ACPI lock mechanism */
>   #define ACPI_LOCK_DELAY_MS 500
> +
>   enum ayn_model {
>   	ayn_loki_max = 1,
>   	ayn_loki_minipro,
> @@ -63,6 +71,20 @@ struct ayn_device {
>   	u32 ayn_lock; /* ACPI EC Lock */
>   } drvdata;
>   
> +struct thermal_sensor {
> +	char *name;
> +	int reg;
> +};
> +
> +static struct thermal_sensor thermal_sensors[] = {
> +	{ "Battery", AYN_SENSOR_BAT_TEMP_REG },
> +	{ "Motherboard", AYN_SENSOR_MB_TEMP_REG },
> +	{ "Charger IC", AYN_SENSOR_CHARGE_TEMP_REG },
> +	{ "vCore", AYN_SENSOR_VCORE_TEMP_REG },
> +	{ "CPU Core", AYN_SENSOR_PROC_TEMP_REG },
> +	{}
> +};
> +
>   /* Handle ACPI lock mechanism */
>   #define ACPI_LOCK_DELAY_MS 500
>   
> @@ -503,6 +525,63 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
>   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
>   static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
>   
> +/**
> + * thermal_sensor_show() - Read a thermal sensor attribute value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.

@buf: Buffer to write the result into.

> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t thermal_sensor_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	long ret, val;
> +	int i;
> +
> +	i = to_sensor_dev_attr(attr)->index;
> +
> +	ret = read_from_ec(thermal_sensors[i].reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = val * 1000L;
> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +/**
> + * thermal_sensor_label_show() - Read a thermal sensor attribute label.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t thermal_sensor_label_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int i;
> +
> +	i = to_sensor_dev_attr(attr)->index;

int i = to_sensor_dev_attr(attr)->index;

> +
> +	return sysfs_emit(buf, "%s\n", thermal_sensors[i].name);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(temp1_input, thermal_sensor, 0);
> +static SENSOR_DEVICE_ATTR_RO(temp2_input, thermal_sensor, 1);
> +static SENSOR_DEVICE_ATTR_RO(temp3_input, thermal_sensor, 2);
> +static SENSOR_DEVICE_ATTR_RO(temp4_input, thermal_sensor, 3);
> +static SENSOR_DEVICE_ATTR_RO(temp5_input, thermal_sensor, 4);
> +static SENSOR_DEVICE_ATTR_RO(temp1_label, thermal_sensor_label, 0);
> +static SENSOR_DEVICE_ATTR_RO(temp2_label, thermal_sensor_label, 1);
> +static SENSOR_DEVICE_ATTR_RO(temp3_label, thermal_sensor_label, 2);
> +static SENSOR_DEVICE_ATTR_RO(temp4_label, thermal_sensor_label, 3);
> +static SENSOR_DEVICE_ATTR_RO(temp5_label, thermal_sensor_label, 4);
> +
>   static struct attribute *ayn_sensors_attrs[] = {
>   	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> @@ -514,6 +593,16 @@ static struct attribute *ayn_sensors_attrs[] = {
>   	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
>   	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,
>   	NULL,
>   };
>   

Thanks,
Alok


