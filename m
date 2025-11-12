Return-Path: <linux-kernel+bounces-898244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A1C54AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A36D54E136C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5F2E6CD3;
	Wed, 12 Nov 2025 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VHG0GvZ4"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA62D8762
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984825; cv=fail; b=qRo1DDnIXX/hCIsD4IjPRWnVutYPbYUiU/nY0Y6pZu+EKl2FWJ2sV0tpSU0/4zCxQvBc6XeXM/OZ7kEn7TGR3OezcS4ZfPbNuz/J2SIx6Qe+fLAKE3TNmQ3grsE+wnhEAWZcY1ZuIpDl39dZiXRDPHCz4zl4hiNRbW+8AKNRUdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984825; c=relaxed/simple;
	bh=KNHIDYLr/dTOKXrdCid/ipUSn0eYN0kN49q3s62XOvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCTfziW6pt8L5GSWDD13Z+wlbEYpaYQqQloFH26/KNfuG4cBJGObmP7DoJ3Vd1nx8OV2Iz03k+HZ22XuHGkjmHRW5AtWq9xfXlm49Hr1PigQGs7u2HqXi9VJwOCzcmLxRHvX7BEfjIopj0Dt3UPGIzo1AkdQQhu7Z6MxXiU4odM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VHG0GvZ4; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACLTS3j2426473;
	Wed, 12 Nov 2025 14:00:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bVvSIbvCH2f0qohv2FUhBX7jrTD/eRznz2pzVcuPn+w=; b=VHG0GvZ4iPmc
	4hyGerzV7iKfaOjL1OqJEbvYgPZLW0LbtfawsVIu/Lb6QSMruNv7TsXDTkht4JFl
	x22xtM/brcejKdvDu+x2VUmD1j6pEvKb+AqPsPq/TONELT01eGZ3/2rdbdWM9MJp
	lxH2h9Fi6JY9DtO02EH3zuwEqx57FjTMB4LAHgJXgJHtIm5ErJoS6z8Kv0ZsU/Z1
	f+uYEjyfkKEyrykg+uOabrHJ1EDfvG2GUkQ/FJPNzD+JrYR1A/oRBl8DkOzlhvyG
	qqpz6p+QGLJTut7+PyNSkHRUyQyfMhSgikPWX89LeB2CTTHWumaY509G+ZwMsRxh
	ezrBHGntZQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ad26w87cp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 14:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmOQitNa14A4IB8tJMw5zgu/P+FSaXOg+3Wj/L1QdLPC+ie3Bd2+x3W1pdUlRfxuaFnzUoUPbgNGzYA3eeaEnFucWL9jt55m+QxfXjHVNDm4C+ZHTNjocJ1cWETjbdMNsHK//+lL3EJiy2whUlp+jcy2t+gGF36gaXnorOPzG6KnSsGfHpiLwTY2L5GsDcUnMr6DRHw4cKfNdZfJ4qebmIT5B0bd9Ge5OFFL4w8et+WC0RtT/29Y+hp566Mr3rUbaH7iFfwUo4coJ9ZEFeP/v2Bz85+F/eaFW/m3J/OaS3HHOVixtz/1oodhYWLdKnZy/InmgbPu4U1DNv3SlM1l6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVvSIbvCH2f0qohv2FUhBX7jrTD/eRznz2pzVcuPn+w=;
 b=vho75Y23pQowMJnxsCBFVKFE1iIjXK1DXlzDXSLmb8M2uxhUr7wFGn0FYzlEzMA2XNHU8b3EgPAtpW80guBb7dPdPq5ij4Rb6fzV0ZiOyBBXZos+dnLOCs/KVpt5RGZL1LfaDmN7EUzPM4DF9SY0UpvyVigQYtwKI55uFwvWnz+4w/GqgdCkzj569Vcwvc0YzUevTJdhFoELXuEccwP+Ylo3U7RMWdHShDjSXIe53u8Kmegr+8qUtmoJKV5licaRgPd0kT4bsjqCFwIQGDACeGc9oI5eUsQySrHNyhyb2u1d8+vnP1XtRmLpfMWugWNIpuZU8yS1ERr23Wazj3v+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV3PR15MB6522.namprd15.prod.outlook.com (2603:10b6:408:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 21:59:59 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9298.007; Wed, 12 Nov 2025
 21:59:59 +0000
Message-ID: <6825c50d-7fa7-45d8-9b81-c6e7e25738e2@meta.com>
Date: Wed, 12 Nov 2025 16:59:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] sched: The newidle balance regression
To: Peter Zijlstra <peterz@infradead.org>,
        Joseph Salisbury <joseph.salisbury@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
        Josh Don <joshdon@google.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20251107160645.929564468@infradead.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251107160645.929564468@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:52f::31) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV3PR15MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b05b4d-0f10-4923-3a2f-08de2236d283
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdlalBMcnNMYWV5cnN6UVpPaFV4Q2xRUmRQalFmOTlHM1MrcDNIM05VK0NZ?=
 =?utf-8?B?c0dXRnJ6aERMTGg1YXdMUEZpWHBFb2NkVzU1eWRGZ2M2aWIrME9kOWd5ZktG?=
 =?utf-8?B?RHlLNFBtSTl4Um1ZcTcrN2Q1WndjN01QZis3UVVwaSt0dld1dXBUQXRDT3hs?=
 =?utf-8?B?QTd3UXovSWw4WGVLejZuUEpxa2JyNTJOc0ppRTRKZFR1NS8rQVROVFIvTGhR?=
 =?utf-8?B?YmFLMUV2ZzV4UHhvcjNKc3dBNU5jWE9JeEFBQlp5Sk5CUU1NWWtKMzNrYlg3?=
 =?utf-8?B?UW9BZUhleW03ZE1pSkZhOG11RExCSXZIY01KS21kRkZmTXh5bHhMR2swaFph?=
 =?utf-8?B?T0hMWk51Q2liR1g4NlR5dkR2SXJ6V1hTNkxEeWRtZ0g5Y0p2aWJYTGs1eG1t?=
 =?utf-8?B?YitQWXF1R2IxQUI1YW1taHVyeW1jSldrTjRNTjd3RStxUFQwaEVwb1MzQ1ZW?=
 =?utf-8?B?VEpCbU5seHRlQkNadHFrSVZZck0zbmZad0ExY1FBTUhKa3lOVVJMbWJnd3dj?=
 =?utf-8?B?c2RJZ1kzUVRqUXdQVXZISFdadlB6ZWpIRUZOalFQUEVqVXlSM1NDVERwTGRL?=
 =?utf-8?B?aXErZGtPVzZtSm5SNElVeVNUOWp4UEZxRUpFVVQ1WGZOemtPcVFrQUx6WTV3?=
 =?utf-8?B?RU01eW5JaEt3RnpySmM2eXlnRjBPd2pCWFRCUHJOY2xIbnc0MDRGcUN2ZFlG?=
 =?utf-8?B?Ry9sZUFDZ3dKRlFxUDdjcENCY21hRlpzT3NWcElnK0dpUE9PU3lrdldROUlZ?=
 =?utf-8?B?M0s3a0RsMXFtb1dja3BiNWFaM3dmMmlBOUxrUUZnS2JFR3R4OGh5bk5weGly?=
 =?utf-8?B?Lzl5RnNOWWd5bVU0NE1sbnFJeWozVHR6azFndkxId2lta3pDUzBocU9kOXRt?=
 =?utf-8?B?SVpGZ2xxYjd4ZVc2dFRsTkZvM29XeHRBMUM5VTZrNHZ5N1JMNWVFODhKbXR6?=
 =?utf-8?B?S3ZFNmNwcUlkZnRqNHRuOE1kOXQyWG1LcTlUbHJGVHpLZjUvMyt0Q2xpZWJp?=
 =?utf-8?B?SnpBNjQ2eW5zMnFXd3hGSDJOc0krRmwvdjlwZVhWVmk4N3RsTDd3VkMxdkYx?=
 =?utf-8?B?NU8zRk5EQnRJdmNoN1ZERXhKQlZrdnNzSVo2QnRJQ3pmb3E0T08xcEVQUHQ2?=
 =?utf-8?B?RVdMSnQxalAvZGVpQVdNN0JZUndJV1pvaWFabC82QyttUGhuUTlQSmFqNTUv?=
 =?utf-8?B?RWlGdWZBdnFJYmZpYzMrV09jVVRQcUhueHl4ZkdOT2pwOWVhVFNOWmtILy9T?=
 =?utf-8?B?bkw3RVlxUmlRTUt0VGVJZUxabUY2ZldyK2xSSG9PazE5SGVncVNLWFRjaGdZ?=
 =?utf-8?B?blVHMmtHMmU1alZDN2VlTzNaQXo5T2JZQXlTMW4rZi9GWUhyY0FDazM5Zy9H?=
 =?utf-8?B?Ny8xUkF0dTFmTmRiTHp3OXhqQXluTy9yK0o2Vk5MNlJZOXpFRjFuSDR5REhN?=
 =?utf-8?B?VG1CVUhDYXFtVjRCV3pCU01ZTHcyNlB6K0t1R0oyUVkyd2hreEY4WGFOOXF2?=
 =?utf-8?B?UlZTQlA1eTY1NFVlREJYNG5MZEtBbDkxelVyUmlUZ0E5MCtSdlNtd1E2eG9n?=
 =?utf-8?B?dXdTQ2J1MWJCbVNzckw2T0M1UlRuZ3BSZm43ODhsUzRjek43VEJIRzc5TUJH?=
 =?utf-8?B?Vi84Y3dTNThMNWlmNjc4QzRzMTYvSWlYUW40eEhvNEZHdlo4LzF2NXU4Smxw?=
 =?utf-8?B?SkNzQXdBaE5IQXBTS2pnTjZyZm50dVN3QTJ0YmFXSWc1YVVsQzcxdHVuUWZn?=
 =?utf-8?B?L3hpZ1RnbWNTYmVrNEptM3h5ckhNOXhRTTU1VlVBNWlGSSs1TVBkZk5XMHdk?=
 =?utf-8?B?Q1FvUTBLblE0dGF3SlRVQlptdXJyOGtMMVRaLzU4bWtNcXp2Q0l4NGNJcFF2?=
 =?utf-8?B?QlI5SFQwR3I4bVZTUFR4RlI0UENlRUh2N2RzcUNCT1Y1akp3QjAydzFuQzZK?=
 =?utf-8?B?N3FnQjRYVTJES0FNQmQ4V3Z1TG1ZN3FoaWFQN3NWUHlhUk9adld2YnFkK01E?=
 =?utf-8?B?QkZUN29ZZXZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU1uMEpBd2k5RFZDTTBFMUdISW51Q1ZweXQwaGJUR2pzQU1sUEhndjBlcTJz?=
 =?utf-8?B?dDd5aDdidUNKNHZ0R3EybW9zb0puc0ZzYWpMYkxkbEhvN20wdWVacFBaeGhz?=
 =?utf-8?B?cktqc0pkdDIzRXY2NmU3dElWV1M1aE9rNTRITWlWQ3VKUlRPeHI3eE5RQm4z?=
 =?utf-8?B?anpBb1JVTG96d0Vab08wdHQvc2NNd3ZVQk0ybmFsWTRvQjNOQnJhNjdiTmZX?=
 =?utf-8?B?NUQ4SVNwTkxtcUVOTngxWmRTMTAzaE1vYkJqbjR1R3pUcmcrcU11R295bkJZ?=
 =?utf-8?B?Y1RadmlrS1ppa3dPdjhCNjI2NGlMdTNpQ3hZcFliME5nSjlZQzdTODRDNlc1?=
 =?utf-8?B?bENkREdTSkZCTUl3aFV3bEE5QU1JVnpVdW9Cb3gzcithL1pURnZPRVZOcXor?=
 =?utf-8?B?Zk1xWElhdTJjY1RrbjJBZG5yRnJVWWhxNmFLbWJ3a3JvbzJ5WjU5bFl3ekQv?=
 =?utf-8?B?bjYzNG1XbEdLS3d2TjFnSHJJSmdrenBFZUVPQlRSWTZaeHJ6YVE3eTk1L0c4?=
 =?utf-8?B?NlJYZkZ5ZDVON1BmcGtWMnNFcFg1Z04vQnpsMTA2MlVZYzk5STgycGlyTTBH?=
 =?utf-8?B?aEVVMHQzKzk0dTNPdGV2TGk2LzBUdFcxTUJHNjdUQldmcEJxU3pnYjFSaHAy?=
 =?utf-8?B?ODRMeGNVdTNTQWh5UlpTbk90WXE5UUJ3RkZqYjV1dDVINE5ON2hiSDVFdENr?=
 =?utf-8?B?cDNqTGhMS1NjUUZMZDFTVUlTVXNwV1Q1R0lPdkVvay95K3NVNk50VnNLeldN?=
 =?utf-8?B?eVBGNkJNenZRV3NZYll6eUJFdEMxTlp6a2x3am1yRmJsdngvZUJmRlhUa3BV?=
 =?utf-8?B?N2hHeDBWVmdlREFOZTY2eVA5TmNVU01uWWVja3BXUVp6M2dwMnJ5Z21UQUtW?=
 =?utf-8?B?cU9MdlpSWFhxQVJKWXNqYitpRzRuZ3Fvc0lac2pZcVltYjVkU3NMYmpWYndW?=
 =?utf-8?B?TEpwWGM5TnlVTzhFVzBsUjZ1SlgzcmhPdDM3THRzWGJKVFR0WmJTcHFYQlhL?=
 =?utf-8?B?QmhLdkZqUktPR3RaQTNBNUR0RjlGSlNsUGxxckp6Qzh3bFVNckZqUVpZNjZz?=
 =?utf-8?B?NlZJVnVhdTFHNm9BUVZmRzBPSi9JYlhRTXM0Y25NdUoyUjFqdFNhazRiTXNY?=
 =?utf-8?B?RVUyY3dwaklqTFM2ZktpSDdIV1lSS29XQWpPOEJVNEJmVjZkOUlBS1BsL3Vq?=
 =?utf-8?B?c2tWZFczc2lWSVJCQS9tRW44NmRudkFpOVdnMnJLYmk0YjcyN01vQkI2L3Ju?=
 =?utf-8?B?azVuQjl1UjIwTWN4WUUxZk9VWGYxV1pYcUVKYmdobkhzSXl2Nm9yK3ZUSTh3?=
 =?utf-8?B?ZXJLS04xeVNTbld6b28rcjk0dFRHeWVrOGpGeEtrQytKRFgvMytnTG1QZSt4?=
 =?utf-8?B?bG11cG0rR1JQdkxoejhSZ1NyemJjdVRTbjRlNG1TWWVIWExsclhxdUVVQzZY?=
 =?utf-8?B?NHNmbVV6NWNqdzhXeGpKajIzL1pXY0VIS2QzbkIzbW9KZWd6UDlxT2dYQXBT?=
 =?utf-8?B?b1hoYlFtS05KV01BQTVlaTkwWUhQUXQyMFRMeEQyU0lsRFUzTzlkUmpTTlBi?=
 =?utf-8?B?TFExMjd4dEY1ZER0b3FPR2RKUVk1Nkw0VmtRbzcrSEFwUS9wT2l0MW5iR0l2?=
 =?utf-8?B?bXpCSExHb1B0NHhGSFF4OEV5a3h3T2FpY0tseUpTMkNmV2Q5cGpqTjN6VW9N?=
 =?utf-8?B?dTdkM09mU2F1V0k1bFYvM1llRTh4YnpVMGFWUzR1b1c4TG5iM2FKYVpxN3JR?=
 =?utf-8?B?ZS9Td29ZOFY3a3pnN0UyUUFjOFRwb29abERTY2xZTjk0NlN4RDUrSVJjRnI0?=
 =?utf-8?B?dEV3SkFxNFc4YkNYVGx5bTdDZUhTNlNUeGRwb0RaYjRKUGlCMmNMclJ3U050?=
 =?utf-8?B?Rm5reGdEVjhwRHJMVFpiMjY1VGp1eVNkdGMrN0pWc0RuR1lkWUpZMGptRXV6?=
 =?utf-8?B?WGVnTnAvd2JFVEFBREI5ZmRsQjJVQmpjVEJaNXgzUy9vTG03c0Q2V1BQM01t?=
 =?utf-8?B?MGJ1Y1hUSHRTRVBKR0NuanIyZmVxcWpET3lZZUxBR2JOUzVhL1dMSER4VWxz?=
 =?utf-8?B?QWM2VEgrRmI0cGdERmZCcmY5RU45ajZyTmFHWVJPZnJ4K1Nic01qYmM3Tklt?=
 =?utf-8?B?d3IrcEtkSklNWU8waTlLWXdTd0VvS1d5RDFFSnNiazRKbmlEZUU5NldqQU9Q?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b05b4d-0f10-4923-3a2f-08de2236d283
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 21:59:59.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DMTMYmqRY0S7of9dGAHg1GQ6cXVXhjMvtdLPq0d5tcfOOGnrtl5TDB82ejC3MTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6522
X-Authority-Analysis: v=2.4 cv=XIM9iAhE c=1 sm=1 tr=0 ts=69150360 cx=c_pps
 a=5k1muW5XIJfqWNzrwyhXkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ye1CeaUIr-sTw7TKWFYA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 96FZfSpEB0ueR81q3CT7AKQi4IPob-Vz
X-Proofpoint-GUID: 96FZfSpEB0ueR81q3CT7AKQi4IPob-Vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3OCBTYWx0ZWRfX4w5Bvfc56I3t
 sqFhpOjwO60h+uUirGONjOo128vGOHokg4pKA/yKRE/AF1DwBhCPBmdbudJh3MhqOtOd97aDHW4
 yl4foig1hIv5eEm1OKtzivkYez6Z8lwd8is0MVHcqscoj/dTd6zli7YjNx5l7VNosDR4kQhQTYo
 LOtrO2DHBvlmQ4357Nq0adWs5DkdxW5TbsohnXzXzqit8OSikBjgUsIQPpTfBciiwpubNB7DQJa
 RAtW3Xvv5f56YC4OwRrGdaBrVXtWzkGi+TM2OK4MsS5ePl3zxLy2iyX90tIPpG+odTWLe97uUk2
 NcPfD/1yVfxZDYbaFK4Jow/VYFg7/yR5qm7JuDbBYLd1ILk2K6sVJafEZfoGTDHBW0oklVJqiFU
 cTTaADOdTh1bLDX+NPMYPRnWORUHcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01

On 11/7/25 11:06 AM, Peter Zijlstra wrote:
> Hi!
> 
> So most of you ran into Chris' commit 155213a2aed4 ("sched/fair: Bump
> sd->max_newidle_lb_cost when newidle balance fails") [*]
> 
> And I posted a patch with a few alternative options. And while I've heard back
> from a number of you, indicating that NI_TARGET (the effective revert) works
> for you. Not many tested TARGET+RANDOM (thanks Adam!).
> 
> In my limited schbench testing that combination isn't horrible, and per Adam
> that combination also doesn't suck for him. Chris, could you please see what
> this does for your machines with your actual workload?
> 
> Anyway, here are a few patches that basically do the revert and introduce the
> proportional newidle balance -- the NI_TARGET+NI_RANDOM equivalent.
> 
> Also at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/newidle
> 
> Please all, give it a whirl. Hopefully I didn't wreck it, its Friday after all :-)
> 
> [*] https://lkml.kernel.org/r/006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com 

This is working well for my original benchmark.  Focusing on newidle
balance schedstat counters (10 second interval):

Linus:
lb_balance_newly_idle              22854

Mason-revert:
lb_balance_newly_idle            2334059

Peter:
lb_balance_newly_idle              75271

The rest of the schbench numbers look good too.

Thanks everyone,
Chris


