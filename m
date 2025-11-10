Return-Path: <linux-kernel+bounces-894036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E9C49211
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC53A44F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD933BBAF;
	Mon, 10 Nov 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D2W7Seiw"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555533B6DC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804083; cv=fail; b=DWcStUccKZv1XDThmPQ25TzcL13n3GsBCOZzP2zk/7MZ42Hhd7vcGJK0+8Rx3PS5jWKGHZJLJY7q0f6o7LBqqGJ1D0Es84Nzb57DK7RubuhecRRwC48j0C17QsS8DQzX/rVSBG5hyfiHbmQu1fMlka7984qp9pjcvLKmEYS3AV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804083; c=relaxed/simple;
	bh=iGj2fmSlTlsy8mVSE+fiaXwFIRQit3fySSa1sosjm24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HmxPnezjvmBXFaO0EQC9AnhwBSyDhu1rdnqUh3n2Q3ZCQVUtOCoqgAdhzEUJgmt08sbB/1y/w+lX2zfRCfMxhN8s25jMHz+n6bR4UaaEsPrmxGBSaOaHWcHPlmiveQLqWjsH3wPclCJFmANOkZAEmpU3wID5TaL+VqU16eOixMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D2W7Seiw; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAH2vmc848517;
	Mon, 10 Nov 2025 11:47:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bC+IP3Mov86HcOyPn0T+GDc/lPa6SZ8IONp4ZKEOF6I=; b=D2W7SeiwIhtQ
	gFx5bt0l/sepkf2JDyS1ix6n914erQAMKs4FIFkdwQJvXDec++oRi/vjDjHzjOjd
	yapOtV4urNHGYDnm4hH2uHdSlNTxgobTMMHod08JdU8UyCNlH0x2l+YX1sE2auim
	xkBYAPDAITqVM9VVLxWGTjFVy/tzduBrmvgj1XAP3qOjPfytLElrTwJ86HTTZar0
	R/E0FSPt4TFqYngmEy6W/ot2UqhJzYsRNTmSMne+0I41mBdbYu9b0Y102hNLItHf
	ACD2Z+NGblTi2cgK6G1V3LRV9Tftz+Wsoo6K9gLw8agsch/HG5IVBiNfyFriOH+E
	iem7uTtWNw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4abehd4tym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 11:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZi5SMbxej0LysT7O5NlrP813iXTwhFFmiU9+oVVB8MFHueRdd1SJD0GFuTFGPZJWbsbdx90uhzYIsqeltYcdunmBUVDV06PO8uavX+1FWYdn+3nEsXCK99nEYfdKW2kRE21D6EDXC7a2RICE4RZOxEeZJsx6X2CQTk5DFHluuFLFP+qfZeqdVKr6MkwU6HE3iQv32rYN7kfb10E2Sg9MZ1nQ3zOaKNE+KaSPR8OBHUfFHbeT6fDJf4OjlxoGxOaQm4bqexwYoolKbHfF70jAFmsFH9UTJy49AYdpYM2ov30yvg7hYmqbl8tVAC28RP9Rvr9E5m5a5wEllJ7/zN9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC+IP3Mov86HcOyPn0T+GDc/lPa6SZ8IONp4ZKEOF6I=;
 b=mvbWBvIDeIwuj9VI7A+IU7mJ8kWOYOrhbv8zy1Fj/cIKu9IEU6xreIrsNdWWc+zl97l8Y0DDLQllXiSaC7HNoVnvB/qaoYs5R/BMLt1q+pclC7AqHaM/qpyn2RmYMFYf+jGKeqj6F5Xm4I6BV1GN4FaS6ofStQQ1bgosQW8hkRLRfA58I12rUT4MnwDYxtD6Js6BgH7DL+zVS6YmAeq9tYVLJhPbQlH8hVIvQYKhYH4qDEUVtMXBnoxl6v3jHX4AO0menMb4CsGAifdz9pnUtXcnI8kqak5nXmyaoscFk++3VdPExh32NX52YMnKmevGAAiw00N43h+CfGBvWPW0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH0PR15MB4213.namprd15.prod.outlook.com (2603:10b6:510:29::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:47:36 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9298.007; Mon, 10 Nov 2025
 19:47:36 +0000
Message-ID: <b37457e3-3f7c-4a8d-bcff-00e64ce10007@meta.com>
Date: Mon, 10 Nov 2025 14:47:27 -0500
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
X-ClientProxiedBy: BN9PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:408:f8::17) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH0PR15MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a4e49e-bb58-47cb-6801-08de2091ff81
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1loSlFKRlNod3JUWXJsZFoxK1MvRFNvRGNQaVNteElYTFFRekhjcmVjeC9B?=
 =?utf-8?B?VFpVTWxNcnNaZ1dXUkRhc1R4cXkzUjUyM291azUyaExJV0FlNUpJOVlHZ050?=
 =?utf-8?B?bjR5Z0ZhT3dVUS9KUzBZYkdEMTRzQlVDQzhCM1ROREJSOXZJRlRreGlwT2ZP?=
 =?utf-8?B?dk5BNnRmUlNzZHVZNEh6aCt4ck5lZ2Z3M3dsNGZqOHlydG5PVkFuMmVwZGl1?=
 =?utf-8?B?c0w3Q1ZkdmVRSUphMER4R01iK0NYeTZqSTJnbEtGcWtLZkYvajg2SWJ6Mi9V?=
 =?utf-8?B?S1NhcHl3VmNZZzBGS2dJbE02ajBwOVk2RVFJaTRNKzFlakZWWGl3NVo5enRR?=
 =?utf-8?B?dEtlMkFNaUt5N0VkS2NLN1FyRGFBNEpDUkpMRkxkdTN2VHVKSkdVQVpNb05W?=
 =?utf-8?B?MHlyZGk3MTRuSExYdFNvaUx2b3NteHA5NnhkSEFudXdRdFpoN1Bwd2gwRzdT?=
 =?utf-8?B?UmtPeDVTVnBtZVNSeEpGVVdnUWZNNUROcDFkUmdvNEtZbXJRbEpoaUMzdEtL?=
 =?utf-8?B?a0hkTjdnaldsZTlpSmIzQ01YTDRwWUNwc3hTUGpMcXRLSjhmNHRWUm9kNUR6?=
 =?utf-8?B?Z05saUY5STM0aFFvSHhEM0l3WFZsSzNkaDBEeEp4QzFHZForYmlxNjV5N1RE?=
 =?utf-8?B?RzRaVCswUFBpT1BFZlNONmFMQy9TWEJ4aDJZM0QxNTVOcS9pdGdlclRrWkVU?=
 =?utf-8?B?bWZhbnBvUjZLZy9IM0VFU3FmdG8wcmhMSVM4NVFCRHBxYm5FQnMrcXBJQXRE?=
 =?utf-8?B?U1hKeFBDNDE0ZW01Y2laUUl6ZHFWOWUwNWFEeGJacmpNZ0JUcEVPVDZnNXNI?=
 =?utf-8?B?TUx4UmUrdGwvcE9iZEtMWEFaeEQxVlBSUWIycEJxWWx3M1grMDBoSW5US1FB?=
 =?utf-8?B?OG8wUDU3TlhsQU1VV0FGZ1JUTXRaQ1FPVDJDSFdpaVVxUHBwSTdRVnovdVZt?=
 =?utf-8?B?U2NhMlZjeC9IWVlacG1sUWNsUlM5eVprUGZNaWFNSVFzYm4wcWh0VlBiSmp1?=
 =?utf-8?B?eEpMV0ptRk13alNxeUhqRHAzU2lwU0kyNTg3Wi9zbmJQVThLcU9SL3BqUk5z?=
 =?utf-8?B?NlJsV2ZmL0tVdTBIc0lIZCtoSXBYU2hRVmZiSWVXT29RY3JxWDZaR2NXUUxt?=
 =?utf-8?B?aitLQTVuMDhHSlUzdWFsQXJvRDgybHpwQUVLZnhTYXByYm5zZVRSTjVSS0VL?=
 =?utf-8?B?L3hwRlo3M1JKdFZOd0I1OEhpeDZ2c3ZyaXZKaGJPR0QrY2V5dG1YbWNGNlVk?=
 =?utf-8?B?T2JTdU1LemdWN3RxMzF3VTJXbzNNcjRpa3dYL2JiQnduSmtUZ29KTzlpVFN1?=
 =?utf-8?B?S3RsVEVwSVJrMVFPREZUOXp6ZUMrM08yaDdIMXVLWnpSNlZ2cGc0ZEZyZGVn?=
 =?utf-8?B?VEs4ZVJBamhxYk1jR3MvV2pDdXVFckM5WWRiNjZHWWJBQXp2SWxaRnczWkNS?=
 =?utf-8?B?R2ErWmptQzVTcCtOR3ZSWXZSMi9QYnJhWFBVSFYvc1Z0c3R0bTFXWGI4U2tI?=
 =?utf-8?B?c213UjA1UlNiWE1UTmtud2orYzAwUE9EZEppL3U4K2VNZ0QzamNLRW53OUky?=
 =?utf-8?B?cU1GWHViTjlXRFNpZ092Ukxtak1jV0pCYlNMbnJLcndKTndpRnh0Zk5EL1V0?=
 =?utf-8?B?akNwR1VneWNyZTN2SjJVR2RRdjZOaHQxdHNtNktHT0dhNmVzSWkvOURXSkFF?=
 =?utf-8?B?YURpZnNGT0Z0c0tHOUlxMndrVmJuYU51U1FDQytPeTRMMDZsM2hsVnMwcXhl?=
 =?utf-8?B?cUM0R3FhaHplY3hVRnhtTFhiak1SSndBSEQrQWp4aE9Ybngxc3lJWTU0Tm5v?=
 =?utf-8?B?bXdvaHNMZ1BXOEkxT0wrTWtES1VycTNOQkpPdW83ckVCUHpkOERHelFVSFYv?=
 =?utf-8?B?S2s4cVA3dHdvTFl2Y3VVMHNGdVZYRGxjanEzZTRSN2c0elgyZGFlMTl5R0Rp?=
 =?utf-8?Q?nIwoLg298kE/W1E5UhnfkfksCP/VCaMP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWZxc2d3YUZTeGdTU0FsRmV0WWRVRkdKNHhIWlAxODRYcXpEK1c3VHhQMmY2?=
 =?utf-8?B?andaMUMrQzU5M0dSc3p3Z2VSVGZQTVhBdkRVS3hrQy9xbE56YXRUREwwYXk5?=
 =?utf-8?B?RUNMdmhUWWpSSkwzYzcvSnBtWDFjVFJmQVdaRVBoZFh6TU1vSVFEK0diTFAy?=
 =?utf-8?B?UkVzblAzQnFJWElOckZYcDVUY0hVb3BaR0lweFF3MFk2eEVvQm4ybkszRjA0?=
 =?utf-8?B?VEJRYXpqZjdGcjdLMkV6c2UyOUtPSkZvZTJ6VnZITXJmUTU3aDM4NEt2Y0V2?=
 =?utf-8?B?WjJ0TENSWEI1Z3NNc3J4UndRazhybHZtd2JQRGxCaVZYZ29Odmsxdlc1WE5u?=
 =?utf-8?B?S3piandsN0tKdndsalNNQ2xuSDlYdnl6QmRvQTF5dG5aZUh4T3o1ako2VGRU?=
 =?utf-8?B?TlczSXErcjh0VG1XdVJvSkp1U0JyV3ErbGpjdHUxRllyb0J1RFFTL3ZpaGY5?=
 =?utf-8?B?b2hkNzFIS2RyTk0wRUI5bE5KVVdudGY2L1IzQUtlbzcwZm1NNlU0aFpjVFlB?=
 =?utf-8?B?ejZMQnY1MnM0WVEzQ1NwV2dBOWErcnpvdWd0bzZBZllHM1dOcVY0SHByRmph?=
 =?utf-8?B?NFRTWXNrZU5CLzNZOCtnTXBvMGRURENOcWxNQXRqTGNZRU9Zb2VLY3hSMCth?=
 =?utf-8?B?TXN4RjRvTCsxNFRiRzZjaXhkc05iOGVad1gyMVVhcWFHcm1LZUxEdXRoTTh2?=
 =?utf-8?B?d3RiZmcyYVlkVmJWMDF2cjlMNmpZcUh0eVhyaUNxWnRSTDlTTk9NM0ZjbVZj?=
 =?utf-8?B?Y0VXWjZIS0NkZDhHRGZHS3JJemVsUXppYkZidlVlb3VVS1c4bkpOdFdRYXVR?=
 =?utf-8?B?WExaVFdKNGpKOENyV0ZUMmN4b1l2NUQ5SzQ2Y3Q0VjE1ck9hd01OZzhYc2xh?=
 =?utf-8?B?Q3dQUmZNcGNuMWZDaENPc0hxQlFyL2o1V2VBMUlNL2F6K0QxNEVrOFRBeXRK?=
 =?utf-8?B?R21lZldpMHBIeVo2aEJNTDlNZm9Xc0FUYWo1aWRTWEFsWkVhOExIYzdrU2x0?=
 =?utf-8?B?RDBOeGdiR3hWeXdjelZPYms4b3BaNkVSOWJiMzF1OVhPUE5EQW9CUXRqTFdG?=
 =?utf-8?B?ZXBNdkhzUWRFdXlTY0c5UnlKbW9qUmdvSVNQYTYrUzhTRlloNTdURGhBeXlC?=
 =?utf-8?B?VE5zRDRZVG80cmxUcFFyS2U4M0N5K2srSzJ6cm9LWHd1WkpFdHhoZkJxbzJr?=
 =?utf-8?B?OUhlQ3hLdDE4QlVRQWZ5WlBLRDlxUjJjYVl4WVFyWlBpNDA2MkZ0RVdGVEd1?=
 =?utf-8?B?cng2T040alZhZWRTMFFNa3hNa0c2VTVTbXgyWUh0YWpybXUvQnRralFzUzdT?=
 =?utf-8?B?eW9paWlMUDdTaGtBL1RqRlJvNjkxSDFWZXJ2aU9MWEdleUh4YnhJZ3lvYm1w?=
 =?utf-8?B?M3VkM2YxM0RNY1cxZ1UxUGR4OC9Xdi9hSjZlT25USjVYcHNXejlJa3F1RkpB?=
 =?utf-8?B?N0NwM05UUFV6bTFMNkJsTk9GTFI0ZXFJSXd5ZkQwVXBzUWljb3dVNWRBdU02?=
 =?utf-8?B?K3FkUGQxOEQ3cFhhR2NVUUF4enIxVDJZVzhRazFLUWpyUSsvVVdNN1lYSlMw?=
 =?utf-8?B?Nkw4dHhYOXY5UUVzYVpXVFRIZlIvNEMwbEJzMFE0SFZWRFMyUUYzYTJEUzFL?=
 =?utf-8?B?Z094TDJ2SVFTUTVzMmQ3QzRBMEFwVkg0RUowUEdqYWFZZ1lNaDhwR1pVQXI4?=
 =?utf-8?B?bFNsc1FYSDhPa1RhektZZG55ZUdnc2JLVlM4bERKZy9NcWtTOGN4VktjUUJW?=
 =?utf-8?B?cDAvVFZPdS9Ka1A4VjFIckZaMVJ4WDNHWk1pMWVDY25kMU1FN2t4YjJOd21Z?=
 =?utf-8?B?UzFsemVQR1hlbVJLL0hyLzRGNWVER20zbG51Y2Y0S0hVMnRLWExmYTluVGxm?=
 =?utf-8?B?RENaZ0tVK1p0QzZjcytmZEdzRnFjY1FzektURzRxSk4zbFhrOVJxQk96RzRL?=
 =?utf-8?B?TW9oUUZrcitVa0tkbjNKQ0p5dk1tTG9zZHZocG5wZ2REcHYxVm1sTk9NV01Q?=
 =?utf-8?B?b0RvRTFXVlFXbVVoQTVRR21uVjJReUkzVjdEMG11dGZ2NG9LZTVuNUxaTHNK?=
 =?utf-8?B?aXNFaEhweDFnUW1xaUk5Y1IwQkxsSVZxSlg4bDc3L1lGemhXc2VJV1M4V2xQ?=
 =?utf-8?B?Tmxjb2MrbFVGZlNjelVTV2ZIR2l2Y21EZkQvSzlocVR4UFMrdXB1eW5UR1dt?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a4e49e-bb58-47cb-6801-08de2091ff81
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:47:36.3693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdEo0HxJKauQsqtfRXKw1TnLmHklkGcyWCvjxUB00gm8smWaNYNNnvtWfaOFxQFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE2OCBTYWx0ZWRfXxwQBcgt44umO
 XHcUNmTXETY9wrS8mwDpYomTH9MdYnxvEFj9FXS28uJCk8plb0co+3KtBZnNUcxm5n9qpDbjyjP
 ebjyHUOmrjqJ+u9JbWPsnqjFpQYijDMdBTQrzUxPSwvqJYlSDNaFV7eM4OMfLAavyLsT/TD4qjJ
 Cn86Rw5V1UnHWRFHhrKCwKAq4WWVsJ4SdDi1PJbWQBof5CrzSOx1dd4Yf1S5mbsp7bnRA4sW5QD
 K+sbaNw86nzVG/pTgmMg2RSOUG3XK+oRTDtPqfGjV/mZ+qjkr8N/a5LnOxxVQqa4ZCKRpT9TDrx
 QJGd5A9o/rr04Fa/yKIuQGzb5WH8yR2i8Zyciz0YvU2WMt0WpnKR39O7jeAM0u09gXjF0ovUzTS
 gOMamhYXiktB50pQEFeu/KU/lxT5hg==
X-Proofpoint-ORIG-GUID: LHhLe7YfJF9xJJPlh9I1SHBKeV_BZN9v
X-Proofpoint-GUID: LHhLe7YfJF9xJJPlh9I1SHBKeV_BZN9v
X-Authority-Analysis: v=2.4 cv=Hq572kTS c=1 sm=1 tr=0 ts=6912415a cx=c_pps
 a=KmUIp0grITFNz0c0ipdWMg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9F13rRslqh2CSx_1HMMA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01

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

Thanks Peter, I've got a big machine setup now and I'll get some numbers
this week.

-chris

