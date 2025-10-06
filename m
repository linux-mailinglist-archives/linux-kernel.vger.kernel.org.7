Return-Path: <linux-kernel+bounces-843439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1984BBF2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CBE189B398
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B2F25B1D2;
	Mon,  6 Oct 2025 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeghVndg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yZySqKyC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4701DB12E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782227; cv=fail; b=pOaPRLKPZq4qgrcjUhUVoVJYzupmIjzAR0E7FXFPx1ISAGzS4a1CB5AddYzKxd3dlEatwkOiFuxb2rtGl6uVzlf0LRYYds9jpf0lVlzHs2lMjgiIbYE2LyHUTnNsVTaJp0zMW5oC/9an462tabR7X2zpvZSKcFrlD+XL4mZBG+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782227; c=relaxed/simple;
	bh=Xaj3suuneDGtOpynvIjHjiqoZnWVCyXCHiiy2TU+JaM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=KyN79JmoDe9stpsSqlfoRw3jz1RC6DSYIsQlM7v4/VhwpObjGN8SIAsni6O4h7XKdKbwPSZlps/x1C60Lwb24rDNZUdtNa82HywKGgNMb2XsDxZHqNBbboJuylQaenzAU9ovJEhgDbAvdU8JPMRHeY5v3q4etUjOkCT3F/W13Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jeghVndg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yZySqKyC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596Jg9sB002487;
	Mon, 6 Oct 2025 20:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=I8QTjZpX0Qq2QDvM
	RrKyHfsrs1kX+gIOhZ/qNnsaPbo=; b=jeghVndgB9EqrwHpySmspBKygmlUckdK
	+COh7aF6ed3BOsMGIn6WUkaJNwgr6+wzQpTaGLOYWG+CG5FNSVlFSjd20KZE4xMF
	BBaDRhUezwdhBNiSoNSVf3EddKsol0EwKNbc30ZcYWGIo7yWOZaLRMJMW//4NcC4
	yGmEaV06xu8xZ4ltwiKHFa2Vf10XdRYCPLWu/wGgGNM9DKPl3CV86j4O6JqFHz0R
	HyHGPtlvIP0XEdwe2dytz6urAGt1T/siIiV/RQQzvJvkisu0g29isX9rgBnn0kzG
	gx2u0p2XQsAIMdFrL1A5qeGEqP8k++CcGAeQOlHz8FXuDO2lMVfi1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mk6s86mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 20:23:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 596KDLCA035791;
	Mon, 6 Oct 2025 20:23:24 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49kdp3yqha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 20:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYHqPCNXz1pj2jiNkjoIEKqSdjXo9xzIRxQGRIBhNoPJkkhfYL6Dy+TAZMHdNJdtnF6wIJ+HTyabvkoTSSwEu54lZKGXhumSyL/XbHwb7DbMSAzkA3zzzR7+mTszANcPkTE14AtzoZpWHO3nXOomsvIv/LcTJUGEnGU/8mGjeWUZc4ghB5D4EgUSURWBZKCdiIxjFU2Z5cFvN05j3tuVco2OagMRa2K8TL4HIo/ywAN1nYBpISd7RHqCF2xiFKuEVLJHr5OMl9kuSrwKmg42tQi/fO+uK+FlGo2lPRe3e+epG516JCxA/P3aAtG6aH0cX5jfk57vWt58xm/cq4H/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8QTjZpX0Qq2QDvMRrKyHfsrs1kX+gIOhZ/qNnsaPbo=;
 b=H7M6VREChHwnxaGgbDO0PNksKYpWRv5zcCi/BwohT2MOuCDYPB1LIFvnCF3xp0XCnOkcCeAKy76gmk2dNIzbarCGL+XKTbDDtzxDO2uIENRICG6LyS3yFG4gBD/ukFvgla96R+NLHnVgzCfzK+34dbOcjWUU0bYt/wQti8iqHh7NZYJMQcMujDSS++jrwThEAyY/YTwKl8KZDWbM7Z/qfbhvEqd4r5calt0Qcw0NOSfJYC48enZf7UIPS+zGGQzeFaT5ToZijxn+ttrfRweR/fclXg6aIml58lJCCWzN82ekK0O2S0mibInGYwYI7jx59/z/97MlHES4CFAN+8BV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8QTjZpX0Qq2QDvMRrKyHfsrs1kX+gIOhZ/qNnsaPbo=;
 b=yZySqKyCexyAufq95SjVqL9j7VSyUV0Sn9H4uQPnGI/SZ25JkWLEUTJ9SxHM1cwY4/KoGIoJi2nUuObTwn8YwAv6nt22FyJyO0r5S8IdN3cT4y06qQmn9sjHxSShTJmMtaYq9mRTRR2O8DKcMjIvdYCERUaTdHIQArCnKwG8PxY=
Received: from PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5)
 by DM3PPF612E8E8B0.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 6 Oct
 2025 20:23:22 +0000
Received: from PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf]) by PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 20:23:22 +0000
Message-ID: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
Date: Mon, 6 Oct 2025 16:23:19 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-AG
To: clm@fb.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [REGRESSION][v6.17-rc1]sched/fair: Bump sd->max_newidle_lb_cost when
 newidle balance fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:510:339::26) To PH7PR10MB6988.namprd10.prod.outlook.com
 (2603:10b6:510:27d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6988:EE_|DM3PPF612E8E8B0:EE_
X-MS-Office365-Filtering-Correlation-Id: f226da5e-0254-4edf-3a24-08de051631dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1hxSTJ2UlZJQjdRWWN6SGxtb21iZUpaVWtFdnc4QTgrczlWeW5ZZE15UVZr?=
 =?utf-8?B?UVR1ZnJtYW0vSDhoN1RxZTQ3d1F5S2pjZ2x5dUdjY2oweUlRUEphR09JdkpI?=
 =?utf-8?B?T1Y3N2NqOTYyL21hWnlBalNoUUMveXVWMERoZG1rUmwyY242RDEzYjh2dXNE?=
 =?utf-8?B?MVdBRndvT3RYVVNDWmQwMjg5Unp0aVQ2NHJMUWw1NFNFWFN5T0VkdWpSODlM?=
 =?utf-8?B?eGZFYTdQdG44U2RJWmRmTmhzcTlRQUIzVGkydWtPOHhZUVhCKzc1cXBlQmFi?=
 =?utf-8?B?TktLYk9ZQVpKZUw3N096MFdMeHR2L3hTQURJLzViM0JWUHpzZkkvYytsaHRG?=
 =?utf-8?B?TnFJbWRGUStHRS9qRmw1OEdwVmZZZnVzN0s5NzhBQWhROEhBSXJUc08zWFJH?=
 =?utf-8?B?bXJVbVROVlorTjRKVFFmM1JTZUZLMkE0ajlWNFJUSmNxR2dwR1ovcjJpV3lM?=
 =?utf-8?B?K3pZRkF0TFdnREZSMDdvOUxwT1o3U3VGaU9XRlhwVGpjY0pXcnZCWlBDUVMv?=
 =?utf-8?B?dzBuQU5aVTRJOTlUekdyaWhEcW91R1NFMTJrSXFEYnA2QlNHREFuWlRibGZm?=
 =?utf-8?B?VnQyTXlnd3luZnZ3MjRzZnkyb3YrU0lBa0FpYTh3SEZldlpSYXl4V21QM1E4?=
 =?utf-8?B?NG9kQkVnV1RPclgvV2JSTS9RSFNFQXV1MUlhK3EwbEdaalpvZmlnUi9OWm94?=
 =?utf-8?B?cllTVklRdldCeUdrdERRL3R4Z0tkM0s4azZEWVpCaUthS090dkIwRHhzdTN0?=
 =?utf-8?B?Ym9IczNzamhpN0dqaFNzY3NkV0V3UWgwZXBXZG1HUkZyTnNsVjF6M0lCZlF6?=
 =?utf-8?B?N3ZTQzJJUk80VjVCSlNKRnBiTFhjWkRoamt2RURFYXJ5cmdnb2xtZVJEWGZh?=
 =?utf-8?B?VEZxdE4yeS9ydGNKbU9pNHRjQ1U4Ynp4bkREMXg1VU1SMStoR3JHMFovRXcr?=
 =?utf-8?B?Y1o5U2Z5clV6SzlqZEdaWFhNQko0MFFkMXNsbVJjRkxPbnRRMDA0UFdKRm11?=
 =?utf-8?B?YkVENVVyK0twZE9VSmpSN0ZaS2JtN2FUMjg3TkxLOXdMT1J1cm5PdTNIZThi?=
 =?utf-8?B?Tm9NTGE1VnJKZ2F3dXBlQzRobTd6Vk1LdUF5VjV2akpqc254UlJtL3NaVGdN?=
 =?utf-8?B?UmR3OVJqNTQybmpYVm1qajZBUW9iL01EaHU1Z3BPUXFEajBpYi92NDhqYWJF?=
 =?utf-8?B?aUIxR1NwdW1lZXNSV0NSSUErTWMvbUFwbDBXYUlSWjNoazBuM3VjQ0k1Z1RD?=
 =?utf-8?B?RDlLaXYvdXJSckxTYWRoQWV4dkpYbDNESkZWOFNvaWRxaU1sdjI1VnJHbG1z?=
 =?utf-8?B?UUxIcWU4Sk02elNhOXJoNW8zb3F3MnZIbFU1YUNKVzUwS0J5Um5oVlRMWjNo?=
 =?utf-8?B?Vm9hL2sxVG82R0VnelhRMm1NekdZeitFZ2t4RDlYejAxRHo0TVNIbGlSZnNr?=
 =?utf-8?B?QVExMEtXblZFNVdSdVpVWFYyWnRYQ2VReDc5Zkx1YTVNSzMrRm9icUVmMlVt?=
 =?utf-8?B?TWl2WFl1UVNwUVEwdzkyNUVweHgrb3NyNTc1ZkhabWU0Uy9seUt1RDZsUVBL?=
 =?utf-8?B?QnBUbFdNcFhwVVM5VHYyRmkvQlYxeGRSMjJYK3BUak1Va0ZFT1E5Z05hVG1a?=
 =?utf-8?B?UTVTV1dXY1lhU29ZRnZ5QXlWWUo2V04wZHpWanpOb3hNMDdtbWxoK2lYbGRE?=
 =?utf-8?B?R2ZFb241aUlPY1htcTBlajNCRXZ3ZEVTRXVzL216L2JFOExOU3FQTFRqSExU?=
 =?utf-8?B?b0YyK21pU3RGTGpWNmU2RHIyanV2RUJqWm9TVy9Sb2pBSmkzM0JZRW5FLy9o?=
 =?utf-8?B?L2twWDA1S0krWUtTT0phYlNmUmNhbkNRalUveHArLzVpTE1nMURsMG9FS0M0?=
 =?utf-8?B?YnY5WnErWDRtM1hpeXBzZlpSK1N1VGpNQlNNdDVmb1dINEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6988.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlI3YzVhdi82V2VQSm0rKzA3WFJMNXhjVnNPd2tBMW14bzVrS1BNUThqWEJ1?=
 =?utf-8?B?UmZyK1haQ3lhelRvY213ZHBuR1FPQ0o3MFNMZXE3SkpKQ3JyeERoTm9GN05J?=
 =?utf-8?B?OWUxVlVlbUxoUGRudVFmOFh0bk5NUzhhOWNNc3VBS1RmQWoralpHOWdYSEFp?=
 =?utf-8?B?dFZXVlFZeTd3ODBiMGUwMld6V2VlKzE1aDlQYjVNNDdoNjVyREYwWTQ4SHBq?=
 =?utf-8?B?NGZtNm00U0xtRGgvRkVhOFY0V0RZd01NcUVnQVQ1MlhVR21xSEVpMUpWVjIy?=
 =?utf-8?B?OE90dzEzcnhwRWdYSmxhRm15U3hFdXo0TFpWNmVvNGxnM0dtT1NOdjVmTm1K?=
 =?utf-8?B?akMwR00wdXIvUklKVm9WbFFDTEoyVHpZc1l3ZmxhanR6T3k3a29xSjMxNzJB?=
 =?utf-8?B?QkJ5TGRyMXVZM0lrWjh3S3NWemZnb3JuS3JHd1ZtZmgzb2ZJWkV6NWRPZURs?=
 =?utf-8?B?Y2ltU0Y5L29IWjIwWi9HOFdyNzJvKzRMK21oZ1YxNkhYQnB5Y0pNQXZCYXA4?=
 =?utf-8?B?THlSaFg2cjFIdFZraHRpQnU4VStvSEZKYUpBcWNVcCt0TmQ5dVhLVEd6bTFY?=
 =?utf-8?B?T0YybjdUUVQ0UmJoaHM2Y0VCRnJjSy9BN0ZJRGY1Rkd0aDkxUWY1ajd5S0N1?=
 =?utf-8?B?VE9UTHhnenpmekp5bnRpZ2RpVkJTalNYNExlQW12RHh5cUtlTld6U2tJK2ZB?=
 =?utf-8?B?WHZUTEw2M3ZlY1NNTnI1b1dTa0haN3J4VUN0RlZvZnVOcDlUY1h5Vkp3dU15?=
 =?utf-8?B?L3BzUVpSVG5Lclp5RGNnamVCc2FuSFI1QzlwOTREZjd5RWZ5MUhXL1l2bDY0?=
 =?utf-8?B?TldqVkthSG10VGhIUXRqdzlneG0xZG5rTnpOTlhqTFgvaWdNRHQ2cVVvY3RW?=
 =?utf-8?B?dnh5TVlwQVBPUFkzTTcrVlRrV2V0VjVRVlVubU1CWFNJdDN4d1N2bFFGS2Q3?=
 =?utf-8?B?VGVpUU9ZNDlqaTVsS1UwY1FDKzRna3NQV0NPengwOVZtMjZpSWtSUUVyRENG?=
 =?utf-8?B?RlpkcHlWKzZMV3RtZFFTYlIzYmlJN2tNSVpHaHdpU3BOUHZ1NTBTR1gwN0M0?=
 =?utf-8?B?U0o5T1lzTitnNkJVaVB5SkpVVGEvWEYwM0JJeXF5bEtma2c2RWExWUFqMmJP?=
 =?utf-8?B?dERBZWhMRjMrdnp3TjIwTHdiYXlVNGhXeWxpOGpPNjhRYzJ2OEltWFcvZXFT?=
 =?utf-8?B?b21CelFnVm5lTXh6NGIrTmY3cUhGQ1M4NkdQZDRBVXY0cmUxaksra2pvWlJl?=
 =?utf-8?B?OHdZcWl5WkNLTDlZVWI1QWp0WFhYRVBqeUg2WWZ1TUthb052NHZ6UjFCbXZh?=
 =?utf-8?B?OWZZdHhxYnhicXU4M1ROU29QZnpxbW5CdEFwNXRyaldVeVFaN3BseS9EcnVS?=
 =?utf-8?B?T2ZTa1N6RWRZM3pkdFRIc0VCOEVNbWdPZWNTVTIybHg0c3pRMXZ6T0F3cjkr?=
 =?utf-8?B?OWFnbWRoeWhLM01Td1hQazFmc1F4by9rMjVKWGJNdlhMNlRJeEhqUkVhM3hR?=
 =?utf-8?B?QmxQSU1LZHhJWFVHK3JUTWphMlFQZjZFTGQzSU9LalRmbFpxd2wxS0NHZm5T?=
 =?utf-8?B?alFYNUxjdnFoSmdSdmdhRmRjYVVLd1pnMmhqWHVNZ0g2TTVSTnZ4TmRwcnEr?=
 =?utf-8?B?cTFzVEoxUDNjWCtuM0g0diswWXh6VzV5OTJOVVFXeHJ0OVMxZCtqM2w1QjlC?=
 =?utf-8?B?Y1h0U2lXZmYxWDdNQ3ozYUlTZldGdGN6Mks3QmIxTUJ1dnRUWjdZVkFKSHNV?=
 =?utf-8?B?VWQrZjh6NjF2b1A4QVh6bC9YK3FrL1gxWThKRHl1NU83WXJiTU8yaHh6cHFh?=
 =?utf-8?B?N0NaV2ZzdzR2Yk1LS2VGeGF0MzdONGJyUmh1dVdmZkR4Mk5mdzJmVGkvL1hF?=
 =?utf-8?B?Q0U3U1Awd1M3UE9ER1lTTlduKzEwaXZsS1VkdVNPdUxBcWdoTDhVREFTWllV?=
 =?utf-8?B?WjJvK01vamZMcFFxYkdKMWVjdGpidms1ZHZZRGhZSFZsMDFzNG9SNFVoTXR2?=
 =?utf-8?B?RFFQRkpxZGc3SFNkdjNDYURRb0RveVAvRTY4bC9CQ3p1a0puYmk3ak5VcE8v?=
 =?utf-8?B?YSt0R0VsSGhyOWJVMnUwRzR1eWxPTkZ0anhiVTVoYWQvVDZrRFlESkk5OXZP?=
 =?utf-8?B?Rzl2VmorZ1hOYUZhS2pjazltWjBMYXJxbWp6VllXdU85MFphWThHeWU2QXpi?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	18ZnbIB2OY+8ZnrD4si4o/j5AJo0kKR/dWQAG7lTDUbRgbGHnj1GUAHMqDObZCSMyU1smrqo854ZtVOE7kd3Sf8HsfnlBd7/AcBBatJ3nnsENW3+9E4ubCsxrUY+PbO/iUMafrzYYTHGMVw/zqJCcgxAyaOfaYmLH3ZrtA8aNjz1db9aZm5fKLvyFEUp2sOOap64AN+nNNr4MpqClKW/Y09PzVi7FXJ3XbQcik1YiNySIyTatWPPh2RWHXbjoecQ0/RWprHoM27vBgeUHx3swulav4JepAnw4Wxci6EmMjTz/gm1i0A45FfbeZ8vinXhNyfDvpU/2ep5ZwCKPaevMFABbxZSod2Sz4BOT3OBWp0EguXXwwaSaSWJV/0lfNtVG1JqI3eHwJnqYoJJwgpnJ2oM28WXieWr+HYCaNmO3WfxzLCwVDPICUumQv1gW8wS/nYWfoJK+vCxAdYZnlDSXjEjnwLef+5nTkAmwT8xzEB92xc+/RIEt6sVfHT8OVxXeCgVfvQ0JxlcwERk+X68tgrFTx3NZxnKPlxkxrU4a1TpxSv5Pu7p4NcAi0rZCcsYjgGa+hWHh1yWS4SWtm9phk3XPsQjZjr+tRtGGMImTu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f226da5e-0254-4edf-3a24-08de051631dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6988.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 20:23:21.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDl6JZDXIiYX2WOon1XnZSld0HCUs8ruW/HtadwPXNo/7OebPqnucP2/9EiBK/MeIW+FSohIB78uknnDRou2oFR681kXoo2diW9owd4rdcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF612E8E8B0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510060159
X-Authority-Analysis: v=2.4 cv=S87UAYsP c=1 sm=1 tr=0 ts=68e4253e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=Ca5vOa3nAAAA:8 a=bUAiWMVtPjSZOJQ9xj0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=K53y-bB3sb5EEqPC0X0Q:22 cc=ntf
 awl=host:12092
X-Proofpoint-GUID: g5YBpETsdHo2By080Ka7csis2_y8KhxB
X-Proofpoint-ORIG-GUID: g5YBpETsdHo2By080Ka7csis2_y8KhxB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE0NiBTYWx0ZWRfX1dFSZaJRVbOF
 KfVWjjos3FB913uHBHJZxxfYFDHG0BoJjAVE4v5LysAeAjywN6xHpn+Z6/ZkhMp2WE0Z8z29jMX
 z3RtpibbX1pUhY8V6RFenzltRiHwp9eDWRMpsl64RtI9tD5A7QuninfmiU6kDQy9s9bhADm/adF
 iSt556MbQVSlk5vOdsj/2qfQmVd/+jTkXIect3BbkKOPgW91prf7AwOmtDBrCtkq7W2/TQH5bcN
 gPeCHnQDSPltxFXal8DQKYpj9b6BU0eJOtGDuKeoJCHAhakkeaCyEBklOmQWjUrciPenqbinapN
 QTF4WJlwM79mQ/Iy94uJ1Ff62si6vQwGEsmPACPZveYpsy+qCuxzMZJRquTGa+8cPQ4IqeqPikQ
 uXoro0CBAdFKz9/GCiZaCis6EsUXwkKAz4gg5beaDy5RcbL4Nc4=

Hi Chris,

During testing, we are seeing a ~6% performance regression with the 
upstream stable v6.12.43 kernel (And Oracle UEK 
6.12.0-104.43.4.el9uek.x86_64 kernel) when running the Phoronix 
pts/apache benchmark with 100 concurrent requests [0].  The regression 
is seen with the following hardware:

PROCESSOR: Intel Xeon Platinum 8167M Core Count: 8 Thread Count: 16 
Extensions: SSE 4.2 + AVX512CD + AVX2 + AVX + RDRAND + FSGSBASE Cache 
Size: 16 MB Microcode: 0x1 Core Family: Cascade Lake

After performing a bisect, we found that the performance regression was 
introduced by the following commit:

Stable v6.12.43: fc4289233e4b ("sched/fair: Bump sd->max_newidle_lb_cost 
when newidle balance fails")
Mainline v6.17-rc1: 155213a2aed4 ("sched/fair: Bump 
sd->max_newidle_lb_cost when newidle balance fails")

Reverting this commit causes the performance regression to not exist.

I was hoping to get your feedback, since you are the patch author.  Do 
you think gathering any additional data will help diagnose this issue?

Thanks,

Joe


[0]https://openbenchmarking.org/test/pts/apache-3.0.0


