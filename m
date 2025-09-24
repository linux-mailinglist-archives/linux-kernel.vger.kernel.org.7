Return-Path: <linux-kernel+bounces-830268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243FFB99407
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CA63B21EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA572DA77E;
	Wed, 24 Sep 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WC9YC7Qc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zB+CBSvf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132082D8777
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707452; cv=fail; b=TCgVp7DE8fi5rB9l2LH9vSDzEWNcY5uHgMcuPnG7SxGrUzPbDop2dOGM+YiTEHU5h2b/2JwyMTjknGdTs5cd8hNsEhJ7kwj6oqWEIV2X3qyrRF2u+6vkdIQfURrdFj0JRHXaIhvM7uWq/tModtr87JbvNredex1vKu+J+HGpA2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707452; c=relaxed/simple;
	bh=DqV5NtWcGehz5CP5rhwf5rzOTdeFCcCmiM8duey7+PE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJ1Fm/ZQhfOm3Tyodg5ZW7kfDMFE89XCfaTMHhVDZiTq+Ip7+jDQUyXv8Oj/34Rs5pBRTPCJlnNVCLuln6PKrWPYbBZtSz0PwLXRlqPn3VU/8e/a0VAbuSh9GkwQlk2EhOPTdtai5PTnqk6mX22eMVSyrBaDCkjJ3vMItgAXrpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WC9YC7Qc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zB+CBSvf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9NOax011449;
	Wed, 24 Sep 2025 09:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0SUMYzX4BNqTuzAjqGPnW/1Ki3cHl34J8XTW54SasbQ=; b=
	WC9YC7Qc+13BOtMWnJ7J7CHV9gsZtm4iwLjWOs5Iqujs37uOI+ibWIdtcIUx4dgN
	e+vUmcveYuaZhZlEGm5ES15CO21Im0K5E2YpJflT9J1s1akjS3QlBLMlS2A037qf
	eNIYxwzEumHsZ+dRpReKRNtC5JdjUT8h63jkNNFGlI/qNUDdkPSKDY6Eyz4u1eJb
	q2rlQ9IoFTlrVoffUfaHIM/14MI/gVm83zwQkhPJ4NCK79VqTL6lDKV+yPZOxO5G
	qVcg79BOq51VN5DN9FD1wFIrglMUhaSI1f3HJ4EBd4opqJ8So7XHmNlHPLDjl6Mi
	C68SNrsErEUrzdw/hTkfXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdq941-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:50:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9cEKA000509;
	Wed, 24 Sep 2025 09:50:31 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9e5hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwQdw6WETjXV5skSgyzdaIONUgNOc5HOBER7BS+eqTCMsXn5jmda/nhKY3JF/PLhovmNN7zWyd0ktQw5+lj0brslotK9NiJhjod+D/p3zfxDGvUJFAXqnt37uBlq2ZlfxuC61pQ8tpBlJL6xNdr0ls1JhW1xG3u0FXx78a0LTFtYqUKY8TPt5+gCPF6IXaHOegLTlvHe8aW1QDq8HMt2Dolqg1F+W8PMzi76dZzCTEP1hhFOTw+TWSiVwh27yWmNxXVJwFD1x84Ph0UqlQ0Ldr71MWsY22EVTybfL5+6WRRGx6XVTBH8Z4z7BrwrLaUvWrn6immxqfZlIfVV+U6zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SUMYzX4BNqTuzAjqGPnW/1Ki3cHl34J8XTW54SasbQ=;
 b=R4XYf1noYcmrBAClJBGi8N4WL6heuAWA3moAqRLHXpqtEJOjz8a8cyXNA5EArTr9rwgarH2Vm0jpdeCjnczuGVgEV6DdL6AdhVFJ96OHEDq3yUGFqIQImieUB29VfchOl5C1Cyty2dQKpB89LtjHCtvKKmKt0Vv++qwvCyXBCDtZdj9l54x6X8aZrdYoDO/7iZcKDFCBC8Tqk0dD8P2yuuGuUl2HVHSsVYr48KD10Z+EM+3f+TyeO7egYQnXci60Ixi4C7pb+4hSkPwNp/X5WzrXPvoChXj4TIAl+jj3U+4NYZPvt3Eotao681p1z/oLgSWfegB6rdJLyjOAgUNtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SUMYzX4BNqTuzAjqGPnW/1Ki3cHl34J8XTW54SasbQ=;
 b=zB+CBSvfRm7kBEdXl1WbHlE66VQxnRCAvq/sqG6oiLhhEkiP4fGl98s3zwPy2gHQEZlnumR79vHBy8CD2M7h+r1AsccYAnvmWYNHlOF2HMbTD8CMwtDL3wcX9iZ8S0L7hkYOflyTLXGxQctEmbENqVfGNIHWPyDHTvbqI5thgxE=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:50:28 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:50:28 +0000
Message-ID: <4c4afe3e-ac24-4891-9acd-1d493ea88eca@oracle.com>
Date: Wed, 24 Sep 2025 11:50:25 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
To: Peter Zijlstra <peterz@infradead.org>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924091751.GX4068168@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250924091751.GX4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::8) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: f63ac2df-16f4-4278-f388-08ddfb4fcaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlZTeTg2RE1hdzBFTXU4djZEM09HQ0w2RWYvb3lGNUdhN0JQVTNYbVhhSWt1?=
 =?utf-8?B?cVJKWEdYUEN5a2M3NVA0NFcxUnpWM3hEanRyRWNCU2lPTysvbXBrVThQOFdT?=
 =?utf-8?B?aUd1SGVLWnRyUlRPV2RVNnN5TFhMcXVRcS9tMmd2VHF1MDJoVkZJdnhGSXho?=
 =?utf-8?B?cHNnSGQ5Z0J5R0dZKzVEaXFxNFhJVjEvdExNN3IybHZ0aVY1ZFdxSjNLOVVX?=
 =?utf-8?B?VThaTW95em0ycjRIZWc5UjFXTk1VQ1ZMQ0J4SnJEZjkzU3dmdTBuQmlhekRh?=
 =?utf-8?B?N2pIdzJnYlQ4NFAxVlYxTDhWcmRtZmFzbWJCK05HZFQ4QTVhckYva1ZyaW5z?=
 =?utf-8?B?aWxYdkdHOHhHMytUWUNYcGwyNHU2MWpDbjJzbkJmMjgwMUE2ODJZUGxaSWRh?=
 =?utf-8?B?aDh3dFNTTXZTVER1WjZGZVA2M1E4bk1Db3BodXczcm85VXluTi94NEF4N1pw?=
 =?utf-8?B?UFhlY2VIdHlTMXQ5Y24vbjVKOFAzUVlIZmFrVksrV2RHU0RuVEZTMmQ2TUJ1?=
 =?utf-8?B?bDlBbGd0d1dMcElOQjRpOVpwZTcwT2h0UG9md2YzR1hJYTZyRjMwZ09JaG5t?=
 =?utf-8?B?bzFtMktHWkd5bXVLbXh5MHdkTyt5NGducDBpTXdud2UzeXNuVHV3WUtmT0tF?=
 =?utf-8?B?UE1MZ1EzUklROWVsaHp2dnQ2aW9Dak96bmRINTVoOXFIT1RSb1BVcURYb2NT?=
 =?utf-8?B?UU5lZXVFdzZVa1pDUzd3WTh4emRWcXdBNlEwM3NpMUNZa3o5NW5NcDdKbytj?=
 =?utf-8?B?TGV0cXVNYUFxSjI2U3E1OG5saEx6QkY5TjVQNE83UGl4aWxQR0licGVoeXp6?=
 =?utf-8?B?TjZJOTU2bFEwN3N3MkFsOElLbUhLbUNOUGlKNkMxOWt5elE5M1JsL0dBQzIw?=
 =?utf-8?B?alZQUmRWeWUvZlMvMkYvcDMyUHVHRkV4RDFkZllnVWc0bFp6OEptanlYZ1Fn?=
 =?utf-8?B?QVROK2tsNkFSdjJZSm1WK1hNNjh2WkZZS2tTRWIxb3NLZkRreVFxV04zOVhT?=
 =?utf-8?B?SGxzeHJzYVhSMlJLenJJSStjaGwrV3hJa0RtMFhqYjg3Sm10djhaa1BoeGVU?=
 =?utf-8?B?ZFB3b29sL3RSRUUzejZwa1VDbEpCYmFFaVdkNG5DNWorb1ZuOGVtT2x2dGdK?=
 =?utf-8?B?QWVoZ1JFWkl0YTF0RXVzWWVtenpRenBUWVd2SHg2MElPMGNVQXJJVnhMVEp6?=
 =?utf-8?B?bU9QMTdHWU50MmdOdGZYUDZzK3RHQm15RmMxZ0EyeWM4SVdjOUxDYXdWTkkx?=
 =?utf-8?B?S0VHT0RraDdXNUkzUnBwZnVRNWhYVzBwdGF1YzZjUVA4bWxnaXV2cDNGUEsw?=
 =?utf-8?B?clVaem50TzZtakswWkVqaGd3WWtIazVZc2ZpQlBLWlNWbHNHZkNqSDZwbG5X?=
 =?utf-8?B?cDV0SWVmUnA5YXJoYUQ2dUgvdCtuQklpdUxPS2RsR1g0SURab2ZLa1NNRnZH?=
 =?utf-8?B?dGxSY0dKaVd6cUs0NHdCaU9pVVdxdUlCRDFueGhjUmZDL3czVkRSWTJuRWd6?=
 =?utf-8?B?OGdYR2VBOHJBRUhZeDIrRHdJOGdBbFUvempFOXJIUytBY090dUZHd0srbDZJ?=
 =?utf-8?B?eTVoUVFBdlNSc01jNGlrd1FRUWxqRGwwSzFwVzBBRFBDeDBJd2MxNTQ2VTdr?=
 =?utf-8?B?UjhqU2xoWEROTmdSQnB4ZXpKSzQwSzFSMVdBR1Fab0Q4MGNCdHd3QklMSEVm?=
 =?utf-8?B?eDJ2ZXh4MWdxT1ErY1F0NXk4ZVFxVkFDb2duMjBQTFRZVGpFcWJ5eERGeGZF?=
 =?utf-8?B?OTBIRW1zQUJ6U0JQUWpVS1hNUm54RGxWN05pQ1o0Ym4zMzdUMWxqa04vYmdS?=
 =?utf-8?B?OStFenZhSEdWQmdxYmV1Uk5RRk1wdFdsbFBrU3E2d0Fid3VnTU5kdzAxUkJ0?=
 =?utf-8?B?d21YTmc5QjdxR2MxYjF3bWx6VjJaandwcW0ybUZHWXFTSldPb3hCY1dpNU9H?=
 =?utf-8?Q?ZJ55e5ZpTN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3RkY05sWWI1aDh6RzVFc3psbmdvTFVoU1dGVUhwRFhXUElZdkFnR1IyaEJO?=
 =?utf-8?B?RjgzTTY3a3MvNHZoSmoxR2c4emtCdG5JMzNsRW5HdVlTNWVqTnNqbXZMakVw?=
 =?utf-8?B?SDlza20rNU1VM2M5eEhEeG9LWkl3VWJuc1NNdWtyYTRhT0J5WVpwbVRvWmZT?=
 =?utf-8?B?SzdLUStTVUhGZVdaUjJJN0ExaVZyYklVTXkrMFVZUkFHeFcyREVtVVZCVlY0?=
 =?utf-8?B?Z1VJK3JTczROZ2VxWUdMMFdQNDgyQ0EyMTFDQi9HVGxSc0tCamZrTkVaRzZE?=
 =?utf-8?B?UXo1WWtJYTZHdUhYU051K0NhSVBQcU55ZTd0eXVNU3FrUWNzNG1NdUNRWG0w?=
 =?utf-8?B?YW1zSElVRlcybWJlVnM2aG1YeUxzMkNsNFRtaXRMRVBGSjJUb3k3SW9ITnNG?=
 =?utf-8?B?MzNnT2pGbDV0TTgwSjNLNlRjRTgzWFZKSm5pNlc2SG5hOG05d08rTGpGTlV2?=
 =?utf-8?B?RitOMVUzWDkzMm4rbkZFQllvMHVkOWJ2dC9KMG1tSFlWYmxJZjd6R2lJdDQv?=
 =?utf-8?B?b3BCK3V3Rkl1cC9ERTlYbU1WVzZWY2tQemlkQ1dXczdOeE9YUFUzMjU0aTJL?=
 =?utf-8?B?Rks1c09NcEFvQkhpZ1M2V3hwd055OEZhbE90bFFDakZIM0pvTVNad1prcHht?=
 =?utf-8?B?cFVzWlRiMGhhcGtmUlVqdVAydS9Ea2tkWWMzblVpaThKMXlTOWJCeS9IRXdT?=
 =?utf-8?B?T0crOGt4V2tMamVWVXJrQjlDdFN0ZERNTFgvWmFuMzJ1eEpUc093bzRXWWF4?=
 =?utf-8?B?SkgxckZ2OGNTYmJlbU9jNmlnZFZTaGNpZHZKUjJ2VzB2TG82OUlDMnFLRUdw?=
 =?utf-8?B?NTRHS2VveFdRQWNsbHFwTkVlTVYvYjJNdDh6dFJ3WStaRXdBTWxNSHFKZzJX?=
 =?utf-8?B?SmFhclVmRlpoL3lTMzZmaWE1MUszRmhFWnNCUzMxUUFsckFacXEreE1DdFZt?=
 =?utf-8?B?RVBpcnRrM0N6bzFKRkV4M2FrOGM1ZzZvbWRocWpwSmRrc3dkNE40RUl5SytB?=
 =?utf-8?B?Y3lhdXdJemxPb3lKL2VoSGtTTGI2bDdObjRxbXJ0WndWUFhFVWxqcGpiSkwy?=
 =?utf-8?B?ZzNGYzhFWk5KaFBPZ3JPeDdGa3Q5Tmt2QllxZ1hudVdqbktoRDF3elV0SHZ4?=
 =?utf-8?B?T0M0eDE5V2Izc2ttbEEvblVnNE11ZzNjT2s2ZS9tVVZ0SWxEdE1GTzJybUp0?=
 =?utf-8?B?MFVLWlJuYUhPbm9uRWxIMGNrSjZFdW5GWXRZZGx3cyticFVWbzhMWVpPSEk4?=
 =?utf-8?B?Sm55bk1samFoeGtTNEZmc3F0ekNIamFZbDlFOXdhRVZweHJ6VU8zM2dKQkJP?=
 =?utf-8?B?MGtraUhSM3JNMCt0UWtOYk9qdktFQ2p5ZU9BM2Y5cXFUUFR3ZVMydlpsc3lh?=
 =?utf-8?B?S2k3Q3kxeXRyKy85dFdUaGVTcG9VR1F5N1V5dlZqSzdXS2lBd1RmMjl4N0No?=
 =?utf-8?B?OEdiblErWGlONkJ1bDVpSkdobTlrMUg5bEdtK2FhOEFqZUFTd05taDNsY09V?=
 =?utf-8?B?bHZ0bGJzUndaVW1FS1pISCtmbEpUYXYyczd1SS9qdVNLNm82ODFxRFVnS3VC?=
 =?utf-8?B?V0Q3dWszNENnYkIwK0t4RnQzOEVMZ2tDaGtRanhRZHI0WVR0c1FRWUZSNTNQ?=
 =?utf-8?B?ZTUxYkp1K3Jram1pb3YwTHYvaVZ3ZUlpakJFZTQ0VzUxZHBsTUczbkZHL1Z5?=
 =?utf-8?B?dytMczI5RStTeGlJQVFtaWNyVDh4TkQyZzBRM2F6QUl4VHhZbUl5S2x1TkQz?=
 =?utf-8?B?Zk5PcDloWTRBVFhMYU1FVGt3a0UyL0pQSm9MaUI5dGp0Nm9XUVZsM041cVh3?=
 =?utf-8?B?am1Jc3FDVU1GYmJnZXpzRXF1ZHFoWm9aQ3RyekVsRTZ1Nm42Q2ZoNWZOOXZl?=
 =?utf-8?B?MnRMN0liRXRlU1YvV2RLRUVMR21YUTRQRHlkSnVNNEVrcGRsVGNoR0JtbVhG?=
 =?utf-8?B?akJEZlZmdGdyWWV5cW4yUUVlTmxRUjQyR3pXNmk0TzA3WHB3M2loZU1zem52?=
 =?utf-8?B?d3lqRi9LRDJXZUtNRks1MXhRa2gyeVVLUFFOeVlIMFUxT1U2bEN6RDByek1V?=
 =?utf-8?B?dHVBV0FmUXRTMFU3T0FGUWtaNzVVZEdQdzd5VXhlbTBTNjRqSWEvY2htUzdJ?=
 =?utf-8?B?K00wMTR4RjhKZ0NjQnA1T05RcG5wYTNzSFFXOXpCblViY2FoMnU1bHRxYmda?=
 =?utf-8?B?alhMMVZ3U0pRbG1wMFMxT2VRaWYzbnFVUlM5WTJ2T3NZZXVLcWpad2NKVUE5?=
 =?utf-8?B?elZCcERUUkMyS0JEM0JJcVZtb0JnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LyhQqhygSlpgHf9gpViLRTaBkA1+hjutv/PfB7W34dg42Twixyy4GplV0pNwfP9T6kcual13dxc9FlNTOH8sZl5u3EiaqTi1VBkJHnSqvxrfeKVtfnJGNxRMLGKmaN4uHH333FTkjAar4qUP3PSFn7AxH+asSuTg7CXiub3vk1JphB+yRFtQsx68scQEwpZXM9KLeRpJzxNofiBxoSMePOxZjyf1Kg5JtWrpgIQZDDo9fOp9UaAI80bQZ9ahZXgxkhxf0HdDEveMAmAucM1VHxsVQ3mTgTUi6AWXLkBbewPU+03d69huDBzgL4qlFtkjIX5HtQ6T3KbqOmk1B1BfobaxROhYT+nYk/JBaTerGwv9VyQcMRk6KnVTiRHWINV/eNx3M15Ljr5DpU/0HWmIdhFFEhSaea5RVmyqaZW1tOsS/1bkMpXGra9Nv/DAEqKWWkZnGfJrA8TtXS5EE5zL8eFqPJjVcwcu/cNJG+IbF/eupkiD7P3ecg4PxKALUCX9wsM8A2gSOS7134q3cI+Y8RatXGk3zjwyhtrrheSBVBJO8M0kDjK64n43uJ+zySJETJMG1TEFH1hOBs48lKrKdV4rW1m0ivY+/IgQRcxE5fI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63ac2df-16f4-4278-f388-08ddfb4fcaee
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:50:28.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s+ox3UH0UyRFeDkZTD55IYEoE2EIOSb9PIJX9Dcf4AGHWlJO5NuJQ1df79/7POMLiZ1Uig6EyMxr8omRm0T3vZS1kgA769LQNWh3KGKS0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240084
X-Proofpoint-GUID: x8OAAgDlKOOmjQXWTMfva0kCCWIhtXGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX8aOADvQs5ixc
 m6sQhbi8G2vHXOdvc3Xf7grXfyXFNGBoIX+gX2hq/SYr1cxdTua9t28q8Y6NpeTqKCymZ446Bfw
 4dK0uLw0s0xmf4WueNy6L6sOiQ2PHmJwLE8kZHh2x+bhcbHcscVgwRo/+NjDgjAdND9TioGywrc
 DXv3N2yT20MTkmO6rdHgmQ/A+VTd3gjnJwtvVO5xXiO/oKwK6mQNCJy3ucxx2JZhlcR95YWG7FF
 PmaFJXdt9dT39/6AZbuivCqzJU/LK1zW8ROplw2TcElxbwL7rssNKSm/nsTxt0AOhTSs85uGQKw
 7j0qFsgefxfrvWmvb44PfQ/Oe8iqVbbpgsnSl/8viQeULn3itDtF3EBOmCnlGoYLk4c15RQQ6fu
 BjUg5uziNXXRSZL+r50U9KcBkLmLEw==
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d3bee7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=vX1S4ZeTEkdaR-BCfhUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12085
X-Proofpoint-ORIG-GUID: x8OAAgDlKOOmjQXWTMfva0kCCWIhtXGr


On 9/24/25 11:17, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 09:36:49AM +0200, Peter Zijlstra wrote:
> 
>>>                        | <alternative.65c4e> alt 1/4 end
>>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 2/4 begin
>>>   1c3d: .altinstr_replacement+0x1c3d | | xsaves64 0x40(%rbp)
>>>   65c53: os_xsave+0x33 | | xor %ebx,%ebx
>>>   65c55: os_xsave+0x35 | | test %ebx,%ebx - already visited
>>>                        | <alternative.65c4e> alt 2/4 end
>>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 3/4 begin
>>>   1c38: .altinstr_replacement+0x1c38 | | xsavec64 0x40(%rbp)
>>>   65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
>>>                        | <alternative.65c4e> alt 3/4 end
>>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 4/4 begin
>>>   1c33: .altinstr_replacement+0x1c33 | | xsaveopt64 0x40(%rbp)
>>>   65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
>>>                        | <alternative.65c4e> alt 4/4 end
>>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt default
>>>   65c4e: os_xsave+0x2e | xsave64 0x40(%rbp)
>>>   65c53: os_xsave+0x33 | xor %ebx,%ebx - already visited
>>
>> I find it *very* hard to read these alternatives. If at all possible, I
>> think something like:
>>
>>     65c4e: os_xsave+0x2e | xsave64	| xsaveopt64	| xsavec64	| xsaves64
>>     65c53: os_xsave+0x33 | xor %ebx,%ebx
>>
>> Would be *much* easier to follow
> 
> Another option is to write it source-like:
> 
>    65c4e: os_xsave+0x2e | ALTERNATIVE("xsave64",
>                                       "xsaveopt64", X86_FEATURE_XSAVEOPT,
> 				     "xsavec64", X86_FEATURE_XSAVEC,
> 				     "xsaves64", X86_FEATURE_XSAVES);
>    65c53: os_xsave+0x33 | xor %ebx,%ebx
> 
> 
> We have the 'feature' bit, we'd just have to 'borrow' the feature
> strings from the kernel I suppose.

Yes, that would be very useful. But I will probably look at it for a next
set of patches.

alex.


