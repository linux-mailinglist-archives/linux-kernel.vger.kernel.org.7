Return-Path: <linux-kernel+bounces-843487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D39BBF927
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB1524F2556
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91822A4E9;
	Mon,  6 Oct 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S93aLTOH"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEA226CE0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785879; cv=fail; b=A7PTbCPecmtgeKpI/x7y4DCE+TIHGyw0X4KY8U2AXYdBCZfd01V94Sq4qDOVlbBkQ2SR0sH/XUXKQ7gI4ADoRAUJuNA7V5Nc7enV6xyodMGLf5TUyTAf3OwDw6kaHut0LNwzOlC7vGUCkmcnw2MMnYOKfVGUSqvaSDA+Il0OydI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785879; c=relaxed/simple;
	bh=ESqH1zPoO7+/eSHJWDRnMhxHPbPYu+KUSivcGHNs5/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BxHIGxcfvWSQoV3Wrt+a0OccfPRepGe2GfORPjcE+Ij1hgZg+UC127P/JFfkNd2pIFgSeCX+sjci3ZCm7J/Zz9wenPp4U9Wg8LStqJbhmOlNGrfia7DmdYPQJ3Y7Jthq8cyOfUKVfXPI+6lsmCBU/eH+yMJVD61pUXrtAA0p7g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S93aLTOH; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 596KqmrX031339;
	Mon, 6 Oct 2025 14:24:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MyQwARZ8lSLLYdkncPZjeJYAOFRiULeJnRULD5eII1Q=; b=S93aLTOH0Ui9
	PKHR6IvZE0RJWtKeszDSQ1bKD7el8/2vaWPdJww3ckKlHcUoYHk+5qBABcuoPux7
	RIzejYe7cCYUKgO71wtFAUo11nK/MctPvCsui0Pvi/hcS4kygrtiy0u1JcF14P/3
	JMEETqysdHi5yt2je+cMacK2faSWf3iwCI0nqKtHbQfnpUTr/CKmkZU1VsCESJJ6
	99jTDvkY+Lfb+RaRYjC+p4QijSy0EIXpYdtnJllIQ5wbO99XrJhLKWQvVrp3oFyq
	q9NSBeOKHeDIGTGjDDBKC+POyG6djO3lLB747NXnMPOORhJbv2HcRflx/V3Ad84+
	FMsrN65a1w==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49mg0nbp6y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Oct 2025 14:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNu8+pMrwr+cId3EEUaQgH3z2v/NKmLBcqzxR2O1mlRbxohbk54o1XPSN6PilM5wFftyf3CwV0AI9r4XLmHQfVHn3u7kyU7aYd4hWw4UwAwhM3gvFqpv2MRHiwt2imzBA8qfF1julurooa6+f3Qdw8ftd0as+qqQeq3oTST5Utlfhr3K/7eM9c9NHxZ50vm2TrMcnIqUnxey5GnVIzRSAp3Mk6usbu4T8/67HAYMO7QgiXarjNlP+eSQDcsXSYOHYXWTgybbVd1ZNiqxGT2+7PEzHiqdgMAsaAeoxEi+/FM0+Osc3ObyBGgdBA6Wg8E9YY+sVgBLyMwQrzdl6HygYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyQwARZ8lSLLYdkncPZjeJYAOFRiULeJnRULD5eII1Q=;
 b=br7cuikdkVnQ5DDjSHvPU99WaDJdl6n6qhxxx6RcgH0eozTjU5pVy9W55Bg7LZeSs4khvaJpyK4zAWpOWqiX9aghGamFYVEWYuueAGTQl+e+iur6VIOmLmGnUDkpjfu8bV5q5UVHtFjiTTiP4o06mii3vBglwslnd1ts+dNdIP0CGrYivKLAQO/4I7zKiT2oHzthOfxqPLRf1LZsWgTjYbyrj9cdldtr/88NsL86Mfwf/gKHrupG3U1bBu5M9RJbB5AFYzyOmJtpVkMxjc+WRsw/HFYt4U3NyGf/oqpXiHOEIVald3JGC+Dr64GVWHQcxr+yLCJBkp4AAkA8bfAgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH3PPFE77D02948.namprd15.prod.outlook.com (2603:10b6:518:1::4cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 6 Oct
 2025 21:24:01 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 21:24:01 +0000
Message-ID: <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
Date: Mon, 6 Oct 2025 17:23:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][v6.17-rc1]sched/fair: Bump sd->max_newidle_lb_cost
 when newidle balance fails
To: Joseph Salisbury <joseph.salisbury@oracle.com>, clm@fb.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0491.namprd03.prod.outlook.com
 (2603:10b6:408:130::16) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH3PPFE77D02948:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a61bdb-6c26-4057-33af-08de051eab57
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGY3VlIrdUw3cWYzclQyYmlScGtucC92bEZqWUFvQ213ZFRDd2l0SGw5d3lD?=
 =?utf-8?B?Uk5WWTNubjh0UVBkUGpSUjd3aXEyRWJvaythSVJHd2dCUFRCeEVMK0tBU1FP?=
 =?utf-8?B?RktEVzZ5OGZFSXNTZEx0Zm02N2ZYTGFidThhaUt5cXdNd1daRjdqZE05NHV0?=
 =?utf-8?B?UXNwazRtQ09xRlNDQVJtcjNCeWk4ZFlFc3VZN3JWZjkrdDRYOHdDRzdFSWs4?=
 =?utf-8?B?d3JXeWdWUndYemMrTU94RGdZMXdZRFNHcC83Uy9lZ3hjRmhwN09uaDZuOFZC?=
 =?utf-8?B?RUIxZnBoTEExU0JJWW1nb1cvbk51eGdKWVZqd2FuRE0xV3dPQ29CeUVxTFFp?=
 =?utf-8?B?TjVqeDRQOWNsWkdxRGllalN6TVpvdEU3QVFKcEhHaTRXVHlaTDVRNnBFeE1X?=
 =?utf-8?B?ZUd6OHpHUUNYVW8ySVVYeTNsVTJLRFQ2czFKSi9mY2YyN0NXWVJqenVRQmEv?=
 =?utf-8?B?Y1ZtbjNxT2FGSHpSMEhQUWtyRVlDTGN5TjlsTEM4bngrcERjWXRJaG5heEp3?=
 =?utf-8?B?UnUyR0F1c1d0cWxHSlRQemt3NGpuS3VhK3JyamRhVWcvenBFUitkOWpwNE5S?=
 =?utf-8?B?RkczUlNRYkp0U1B2N3A1MXVWc2lsb2NMT2R1ZTRvTnVVbkprenl0RXY1VUZu?=
 =?utf-8?B?M1VpUVdCckZEYnkrOG5TYlJNMk0yRitLM2ZHbTR4TmhHU3hXbGFQNVZFanNP?=
 =?utf-8?B?aG1JQlRsNlpQN2JzZ0h0dlZnZlRHK0dIQlZIKzBZWWxnOUV5L1lJS2NhajhI?=
 =?utf-8?B?MVdDKzEyRmtsV1RraXNNUkRhV21wUDNieGY2WFFzSUZBMnNneWovNWEyOVN6?=
 =?utf-8?B?SzlkUkdhTUl5WHVBRmdyWHQ1UG00aXFVSWYyL1EzQmlYZU0yMjZGR3gvb0xw?=
 =?utf-8?B?dE1JTlpwQXJDVkhVcTNpZmc4NFNMaVZUcHVPU2VKQkZYQ2liOXI2MEVJZDdX?=
 =?utf-8?B?OVhqMHY1SXBjTjFBQm5ySzZVemVuU1E2eG1Yck1rNkZxa3N4NmdNREppWklE?=
 =?utf-8?B?TnBFMU8wS3A0VmxOdy9QSlZ2UElkSTZ3ek5IVUVEVGpjdno1dzhGVms3OWQy?=
 =?utf-8?B?VEhYYjhEYjQ1dTlQOHcxRmt6V2FZQjFIeEhNZjU3T1Z5ZHhqc0YyclB2SGg4?=
 =?utf-8?B?eWFZdmNWdzVhcXlxaDVYZXYxaHJlTjRKQTlscDErNWVIYSt4aG1keWRiaXk2?=
 =?utf-8?B?UFJiRWtxeUw2L3lnbHFBc0lGU2tmWHVTenAyWTNiR25SV2EzTHlzT2pNZVVu?=
 =?utf-8?B?bmR3ZEpiSEx1WFIwSFFmMExJMDgvZmFiUFpzMmFHSVphbUczSXBWY0dBYXhO?=
 =?utf-8?B?K05zS3lBdEVFMUJhUlNjR1RvWFNDeGJ0bXRsaXdZcldmdS90TFlVUXFFVWRy?=
 =?utf-8?B?ZGs2RDFiL0pPdVlmVXFNdDVCY2l0SFhGUURZbTVwUm9NelZuY2p1RFNoQU1X?=
 =?utf-8?B?N0JmTkpjVkJjUDlYYTRKUFdaTlJUdHRsVktsQ3BYVUpLVEs5TmdFV3BWaFRh?=
 =?utf-8?B?NU93VTIvY09ob21veVRYY0U3VjJseG5oZUEvd1dHb3dabWVpM2E2QndsMHVQ?=
 =?utf-8?B?cnNnVW9WOUtUY045L0NLaGQ1QU5ZYWkwdmlteVF5ZlZLUERpUXl4aW53TE1P?=
 =?utf-8?B?TWYzZXRhcXZuY3dpUURSNHFHTE1kSElHcUU0K2Y4cCtIRWNkdXZxRjc4ZUVK?=
 =?utf-8?B?L0ZFWUlGV3U3M041d2hvaVlWNHVEYkJ2ZUM4VXFjN0pETnZGQnJjTTNlT1lp?=
 =?utf-8?B?ZWFPV3NhaGtaTzIzVHhXbEZmS3gwaHZQTHhYSDlLS2dWaElCRW5UMlRzbDk1?=
 =?utf-8?B?aThCV0ZZRzcySDkxMTRkR1lIVjk1STdrR3BNZE1RSlEvdXUvK3pKQWFVRVZv?=
 =?utf-8?B?ODZzSllOQUIrajB1S3J6VTdzK2hRTjZ5OFNSSVhXME9QWVFCOWFZV3B0L3Zy?=
 =?utf-8?B?THlhU0luaVZOaWhza1BmMWZKRkpucXVZandTaWY3UHFQTG9ualp2b2ZDeUpT?=
 =?utf-8?B?V2x4dUFvTkJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm0yalUyODJVYnh2TGFpL2R1MkVUcFR0cC80bjJhdXorZnd6dHh0ZzNXQVdG?=
 =?utf-8?B?VzlvdW0wVkZtTmpwWVV0YVNTU1ptbFE1Z0l2UFhaMEtVcnRjNTFLajdoazhs?=
 =?utf-8?B?aTRrVk9ySkJOd1FuNGxDN2xHaU5vQXp5R2ZhRkpFcjRJL0QwWDdUUE1DdU5I?=
 =?utf-8?B?UTh0aHNXdmplS3dXS2tXUTROZ0ZJaWdOcE9BTEFCZFpvcmxaaTFDaHJOeUFZ?=
 =?utf-8?B?MytIeGsyQ2g4QW5LSi80aHBmcyt5byswVS8yTGVMRU1jTDVkcU55SURKUzFR?=
 =?utf-8?B?andiL1BHelBCTmhqcW9kalBUYTBnOCtGK2huTzFybGdMQTRvQmxxMllRak53?=
 =?utf-8?B?bkN1MGx3QUtSU3BRbXl3d0x0OS96UDVOdk0rRW9tZ2RVd0lWM3hJQjVZdk1B?=
 =?utf-8?B?dGJpV3I0QXVlcnM3aWxCbHFsamttWUowV3NObEN0eno3UVFVWWxaRGViWXhK?=
 =?utf-8?B?dVFKMzdtb3VveFdoTFJSTXNuQWs4eUJXU3NUeGFJNy9OUmxLU0FLSzQyRGFv?=
 =?utf-8?B?RVZyR0pFcTJwcGZSMkpQVHVIUDVMZUZxaFNsVllCZTcvMjlNYnZYeEpwaWc5?=
 =?utf-8?B?VmpKdFZhaG5LeWs2Zmh5Vm5NWkROMFJoMElGYS9LZ2Z0dU5NR3VKNUIweFVa?=
 =?utf-8?B?ZkpzekFHMzFoZG1ybGF1ZUJKUlZrQXl3TU9JVTZPU0ZGa1ZjR3BaZi9nNUwr?=
 =?utf-8?B?YmFnQ2h3K2pxVlhMNVdwL1JRYnlTcGdJeXh2TEFJM0w1cmlpYVhTdUJKYUlM?=
 =?utf-8?B?NXRZOVBORDBmNGVPSVY0eWJQeE5hd2dBc2VNcFlhWXNjRVlXZk9NazJSekFY?=
 =?utf-8?B?S3hzL3RaSStMS1NTZTVESi8ydloxNkg0eVBLQUpGc3FoTmQ1YWxRNHlZWXdL?=
 =?utf-8?B?VjZmMUZMQllGM09WcWdBZWpnNEIwRXVWbi91ZjZnSVhyN2MwNUpJb0tEYU5J?=
 =?utf-8?B?cVUyU3o5b2tFN1Q5bzVhanQ2SGE4NXFNcHBWeVNUTitPZWMzL1k5blhXakc2?=
 =?utf-8?B?YndCQWlqQ2J1WVl6K3hWSnVYdEVwRHNVVUYzbVlXbGJKRUwzZEVmc05kcXlR?=
 =?utf-8?B?ZkVCdmVsNFlsdSswOHVXNWw1eWtvYmtzZSswSHR4cjgyZkxFaGhsK2c1VWlK?=
 =?utf-8?B?WkdaSW1mcmNCTWZMTjgxNldyRlJlNHcrZzFleS9idWE0YkN6U0ZpYmk4cmpm?=
 =?utf-8?B?Mjk5cWtaeXlrVk1sOVYvZ2QzS283VzdvNlppclMvby9CRm5MVllzL2c5aEV6?=
 =?utf-8?B?dXJBb2NBd0lpdDRsdkh6MGM1TnBGUTlQNUM2Lzc2bVdXdTVhdDhJZ1hjaXdi?=
 =?utf-8?B?SmVIWUovNi8yb0FRZmdvSzRkeTNVbEpod2d6elluMGd5ZDVmcjVibnRFLzlS?=
 =?utf-8?B?VGRHd1N4MXJxRzF5LytnWDlhcEtSSVpQSlBGc1J6OVZDYVQzSDg2Vi9CZDZZ?=
 =?utf-8?B?K1RQOUtHR3lCU2lVNis5MXZ5b3pTTDBjOUZHSmp4UzZGaGFneEVEQis3T0xx?=
 =?utf-8?B?L3RhRkFuRndnMHVTS2xrdDBhSUR3WmZIR0VrUDJlcy9NeitSUm9RSGVIandJ?=
 =?utf-8?B?WXRUOHU0YTB4a1pRbFY3bTRIM3NMelhWaWhYYnBwRU1YTXpReHd3Nk41cU1y?=
 =?utf-8?B?NkkwSlR3Vmg3VzA4NDBGOW5NUVB4Z1JDQm5wTFN4VHJ6cER3TCtFbTJpNkVs?=
 =?utf-8?B?ZHZrcFQ0UWwyekN5K0x2Tlo5RDkrQ2oxY09XbXZHODhiM3cxWGhnM3JNZ0lH?=
 =?utf-8?B?Qm9pZUZ6TmQxak1Ybkp0Wi9wbm4zOWV4ZVVrNWc4LzB0bmM0RGRSWTZYdkVZ?=
 =?utf-8?B?TmV4NVJCdmNJOWRObDdWbUppRXJHSGVWUFM1NndiVTRra0JHbmE0dytPWWdJ?=
 =?utf-8?B?T2lzTzh4VUdUQUxOeVBhNGhQR1dpRksxZGxxWEVBL0lSZHBYNGdiOS9yTnJT?=
 =?utf-8?B?cFVRK0pBNWVWcWJHcXFGZlYyeENtdlNXNXBkelBUSzFzQWd6VFdRaHNsVHVx?=
 =?utf-8?B?YU5hMnN5VXhRa0RWWjFxYzFGRC96blhZM1FJQmlrYjNRTGhNMDJDWkp1NzFT?=
 =?utf-8?B?RTZpY2JJcVBiaWxTWmRUM0ZqYVVHUGZjMWVSVWhVeHdmTnR4b1pFRHMvc0ds?=
 =?utf-8?Q?PW3xCprTgqEgaqFwbpdwxOgbH?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a61bdb-6c26-4057-33af-08de051eab57
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 21:24:01.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkQjFbKoT4rEHDzVB2uZi1Ml02dPq2n0G+A19s1Kf1/iEk38LJgK7jmJmkwJPqi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE77D02948
X-Proofpoint-GUID: _-hEv8Z4HXpWRzWeQ7P-ZOAAh4wfp55P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX3T/0+VmtNgf6
 chBSzeXmxc+TPc9hHnwpZfaXs5NyVx76E074J8TD9yDT1ZNoHWiIsW+ZxEoSwEFyQsxHhDsoJUT
 rANKyZx6+MoO9Si16bWH54bvYxn4oK5ReOuKzdaTfcIJayf47XRy4hA/Rwa+3OH9A88cj6e5d1G
 RRaas/3qEUAZv0704qMoPzefda90xHX7GonbZ41II7Nh4yYNqyCrRUurwtfMc3q8XXrOxYRnPV5
 0KsJB+fnShgESlvom7tl91DkD0+uZX2InTsaX/aZ1Zx+tEQ4vC8MYULPhPIAkkYeogT3PEVRFxD
 Z8dDoaYNShtw4n7fKFgN96hw85yiQ0bQ2aZ2KKavK6t6FXwQ4GmdPGJUY1Dac6XxybVJOQS4cLC
 gLiv/+FePti/U507Dib+MYGhvZ0rWQ==
X-Proofpoint-ORIG-GUID: _-hEv8Z4HXpWRzWeQ7P-ZOAAh4wfp55P
X-Authority-Analysis: v=2.4 cv=Hot72kTS c=1 sm=1 tr=0 ts=68e43377 cx=c_pps
 a=RaQOCb/jdUlFsaPmnWcrog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=xGlJ8DNMdHyzvLC7U8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01

On 10/6/25 4:23 PM, Joseph Salisbury wrote:
> Hi Chris,
> 
> During testing, we are seeing a ~6% performance regression with the 
> upstream stable v6.12.43 kernel (And Oracle UEK 
> 6.12.0-104.43.4.el9uek.x86_64 kernel) when running the Phoronix 
> pts/apache benchmark with 100 concurrent requests [0].  The regression 
> is seen with the following hardware:
> 
> PROCESSOR: Intel Xeon Platinum 8167M Core Count: 8 Thread Count: 16 
> Extensions: SSE 4.2 + AVX512CD + AVX2 + AVX + RDRAND + FSGSBASE Cache 
> Size: 16 MB Microcode: 0x1 Core Family: Cascade Lake
> 
> After performing a bisect, we found that the performance regression was 
> introduced by the following commit:
> 
> Stable v6.12.43: fc4289233e4b ("sched/fair: Bump sd->max_newidle_lb_cost 
> when newidle balance fails")
> Mainline v6.17-rc1: 155213a2aed4 ("sched/fair: Bump 
> sd->max_newidle_lb_cost when newidle balance fails")
> 
> Reverting this commit causes the performance regression to not exist.
> 
> I was hoping to get your feedback, since you are the patch author.  Do 
> you think gathering any additional data will help diagnose this issue?

Hi everyone,

Peter, we've had a collection of regression reports based on this
change, so it sounds like we need to make it less aggressive, or maybe
we need to make the degrading of the cost number more aggressive?

Joe (and everyone else who has hit this), can I talk you into trying the
drgn from
https://lore.kernel.org/lkml/2fbf24bc-e895-40de-9ff6-5c18b74b4300@meta.com/

I'm curious if it degrades at all or just gets stuck up high.

-chris

