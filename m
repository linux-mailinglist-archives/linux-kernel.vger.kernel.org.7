Return-Path: <linux-kernel+bounces-877938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41230C1F63E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 693A54E933D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9228342CAC;
	Thu, 30 Oct 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owKlYmRJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hMzT+jL1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460B34DB4C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817890; cv=fail; b=lwc/1dyivwJMyBSj5NuSn7xWEvhOMJaAWdvQjNyXW81UlBGJY8xIwdAndN339YqIfZ6mz/Gn0Z5tJvQ8aOyj9FlRnNM2BxHEwHGCzMFUIUHmqdClziCRY/8Ze6xxCaM7fMTwSGnsJZDc3s1XMWh0IWZndMQt1Kc/1fBZhBhlswc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817890; c=relaxed/simple;
	bh=eFnAlrf2QCyegG3f+NORUUzHjrXYbNUL+wzOaomBGGM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uf9JfD8xI/ZE51VVpqUXSw+qnPhf2Ma19h6GIAL3x0Fe66NlIXVX1PnIM6Um3UqDwdisHjJp9K5aM1sSAjrSLy/O/0Owij+FX228Q66k7DPmZYsX/EVbVBRkbM8D1ULDk8ntWLr3NlKXszWqnD4OHCDYWdBXgoojjDWElByioJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owKlYmRJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hMzT+jL1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U9NPZv023567;
	Thu, 30 Oct 2025 09:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tLsEJrH8o7f1dnyQ6rGM5gnCd5mAVD6f84wOStZyGzI=; b=
	owKlYmRJOdMZ31WWhhl9Hz8U35NzvS9DGv8qKiLi3C6TJxN9KwvvdSKXN1uIVnXt
	ZocNg8MqwVdkA7vxmT/yonllqrVkNaSsmr3r2j/uOm0iChiTrmJeyCDNyupXjUFO
	+YYlRZkWjHq+pUsWlqvMDV1kJ6eJCh9DgRFJFYtCUN6j+VSpyDepIN1yMNSWpU0t
	rhFo69Vih/hdJ0wpH88bpYflpfWRabKX5hUJC2CUPjgeJFbm3++pDCJ94jE0yHYl
	wrcDL5hmMtZvUiGinlRV4NtqvQPwiaPfU+ww3jPcPsFsQmidA+Ugu3Nus7sdhYVR
	0ykgIGjAg7kxbjj9PoK3yw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a44j6g6bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 09:51:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U87xhR031461;
	Thu, 30 Oct 2025 09:51:06 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34ed4rmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 09:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrBnxJCiBiqwQfLIn0EpMPTP1lCP2J5I7g+dVLZV/Rvz1gJTlNP0yAFslNjYVaXQqO/WCLH5VMgCQM4iGyciU4C6ktRJBqbvVoTC3tr4vpqP66Vaob2LEo2Rt2srF8ZETBUHI0vE1M3gSDDCaZ9WA/XAAqS3NqN8UbssjwXHk9p+9t0atYFHQgx0D5KlQK0cREFb92Zr8Dk3lQmMlNyyc3RiAWM7PwyATfWj6321mHraTGijzaNyRcvGGMHm/9/StXwscyMwk75UKGwP3DteViiPnoCVk7rYvb+797vbONgvgWcaL7epRD7HMPQB3d39A5llAxa3LGksfDkHepCasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLsEJrH8o7f1dnyQ6rGM5gnCd5mAVD6f84wOStZyGzI=;
 b=QX7GfT7I3JNys8NA0E2XGnNexx3WYLRKt6cs3OElBR1fkktarSU4lpsXakXe34m+KbHvxfsD0qWKGoXMmsVz4jlEKxA3IFYebaiy6LKwVHIbOetPO+1aqMS9LwueerXdrxY8JxtuotPiAHy/gBvLQ1blW4vihfrZZTuoxRHn+Iy7rBZuCsEPP7CDE1PaeUSt4SpBA4DkMoZld8AiMl9ztSHjif4/z1DlfVSG0a6ZqNMH6K7zSMTd55Pk5pNft0OuFNQjn94hWaQTyh6LUxvjGe4sPK0KrM0ItkzNjk96pgkAuZBLEIEHnd/noGSi46sL0+x0sNy8S6+A2M4Een9aQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLsEJrH8o7f1dnyQ6rGM5gnCd5mAVD6f84wOStZyGzI=;
 b=hMzT+jL1Iz2tndrtIrSSIlXdMTUy8CFDs0aqhm7niT+qJFzC+m0O2CXD8n0PR2ev5hLUI12bR8+lkaaSEMyUhYKu4bE72t/5ZkiH9DqdNCnl2YUPL5yLQBA3sFRloGVGHwq54mmcZxgkyDtaYHrVTaQBq6ySoeFIarJ/CAThGdE=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by BY5PR10MB4372.namprd10.prod.outlook.com (2603:10b6:a03:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 09:51:03 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 09:51:03 +0000
Message-ID: <194ad779-f41f-46a5-9973-e886f483b60a@oracle.com>
Date: Thu, 30 Oct 2025 10:51:00 +0100
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: odd objtool 'unreachable instruction' warning
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
 <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>
 <es4awalt6i63cy5kkrbz7f22cxpt4zbmq6zsbol3yafek2375e@6b6stnc6k6h2>
 <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0394.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399::28) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|BY5PR10MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: efd38e4f-8730-422f-6ab7-08de1799d662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEgveVdUeUU1eVZSd1ZadkorU1BjNTFnNmxrazI1d3kzVnNyc0ZuM09Yd3VE?=
 =?utf-8?B?VVByQTdUZU4wZU8yTEVDd3lXWGQrd3hUV0tGVWtrUDVMM0lLQTdrT2JwTTdi?=
 =?utf-8?B?K3NPbnpWZ0ZLVTF1enVRclJYbXA2ZW04Uks2K3oxcklVd05GNkpNeG9NVjFY?=
 =?utf-8?B?R1hWUTFLa2VwU2pFLy9pdnVMdEtkelM3U2pwVm1yMGhkK2pUaGw4Z0pKZjFy?=
 =?utf-8?B?YWMzMkpLeGZsZ0x2b1pkY3RFSGZUL2JONVFnS3N1RGRQRzNzNVVtK05iZlRn?=
 =?utf-8?B?aWdCVzdjaG5ZS3M2T0JQcXNQaVAwVExKMDVXYVFjWjFQZVFEZVZXTWNCNDRZ?=
 =?utf-8?B?TjFBVXlKZ3lQcnNyT0dYWFMyaFp3a1JEaUpZSjR2eU0vWi9pd1U5M0E0cVQ0?=
 =?utf-8?B?V0xIQzROdkJYRm1sZnZQbDEvVlJvODJjVEJIK0ZxcWRkbnF6Wm1EajgvZWdJ?=
 =?utf-8?B?eStWTUJlZStVa3VkMFl1RXFaRDdGSzFzWVRheTFNU0JzdHo3SkxWNXJPNW5I?=
 =?utf-8?B?c2F1UU1aVU9KZkNGeUFyZTJLblhsQU9uSG5wNmF6dFQvM21LSjlQZTVydDZT?=
 =?utf-8?B?WERwQ3lIL05Ya1VLbnpNRXNvN2cyUkZQTzFwNWQ2VE15ZkkyU0VvUUdvZVRX?=
 =?utf-8?B?bnowR1dCS2FkY2dONDhvRVJqVGVhS2c4STYrMkRnVTNiZGpWTWVPcHMrUm9p?=
 =?utf-8?B?cnl1L1ZhMEFrT2xqaDAzOVd4NjUwK1RvVVZUb0ppdG1HL0NXemtJS3BhRW5k?=
 =?utf-8?B?NTM5blcvMUlzS0FRZ2ZZdTYya3I1TmFoakcyWWJJNlVjakFsYjRmckh4N0di?=
 =?utf-8?B?TjlURzFlekFhQVg5aGJERm5iU3hRd1pyYnlYRkFDU3BtWWVBbnBWQWRhOEVF?=
 =?utf-8?B?YjQ2STVKd2JxdzZxUXQ0NXVnd3dYRTBHZlRDeDNTdFNoNFlya1o1OTZSY0g4?=
 =?utf-8?B?ZVJoRGJSbEVyejhvTko1ZTNIMmtJQ3pSMnRMU29YQ01CT0VsNzZ0MndwL1Br?=
 =?utf-8?B?ZzlqY08yeWJaZ2M4Zk5hdjJlNVVVRUI1YkFWeWVsTW1Tamc1UjhKb3Uwa093?=
 =?utf-8?B?RHJ4ajEvOGJvcmZSajNZVkxtWnFuUjVrdzdEY1dYdWVsdHRRREpuSUd6dmkr?=
 =?utf-8?B?Y2hzL2VEMTUveng1bHVTcGlJOHE1aDVsMzNzWTl0eHUwZzhnUnE3SDZjaUp1?=
 =?utf-8?B?OHQxUWxFdjFqWVl0VDhjMjMwUFBWQ1RBRXRBZEZNMndBV2o5TWozYmRBbWUz?=
 =?utf-8?B?VDJzdll1NlJnM3M0NVBGQ0xnblFWcXRvalpQVEs1WGxwaTFIQmZpQ0hpM2o2?=
 =?utf-8?B?QTdITGV2Yml1MTZGK2hodUhqR2VrYlpJVmRVdW5UZXNiUEhOZXYyVFpoaC9p?=
 =?utf-8?B?b0NIaGpRWVI5Q2FkZ0JOR3Q4T1JMNGVCaGczL0hxOFJ2aTJLVnV5NmFxUDgr?=
 =?utf-8?B?Qm12RnFuMTFlMjBqU1NoTERCTFNOVXEwTlNlaVBJeVdyL1Q0a0dXdU8vamdn?=
 =?utf-8?B?ayt4WEl5YjB1Tmk3WjAvVlNFcFgzd1UxOFIrNm53SjFmT0h2ZGlTVk5FcnNu?=
 =?utf-8?B?NkxKMDZJSlVDRVJKdHZzNmRXWFlNNXpmSEdhUTI0SzVWNlRmK2dPUHRPaU5T?=
 =?utf-8?B?SFR3czF0dWNoaFhGTm9USGV2MHRQbDJwSXVWTEJzY3F2RzlkU3BtSEVCTnU3?=
 =?utf-8?B?bDNvak50Y1J5WEtsNGthLzA2QzVBdzBrQVYxaXF4c3BUTlRtQ3BWL0E4ODNJ?=
 =?utf-8?B?TTc3S1V4Zm0zOTZuZGt4L3JlN3poOURXeUpkc3docExzQVM4L2lJc3BzS1l4?=
 =?utf-8?B?eGcyYUs1dy9EQXhVYzJrTUlMUk9xOE56MTVJbGFHWlNzK0R1TUZtOGhXZ0xh?=
 =?utf-8?B?TWRSd1UxaWJxRnhVOFk3SmhBWmxwc2VJRFY3Y3ZJUlRZYVhtU1hCY0FRTml6?=
 =?utf-8?Q?+allzrETahS12hvjufMvTDg4miFpR8f+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGZVdlZ4VDFpRHlXcmc2T3VESGYzUm55SllSYnZIVUY1c3lOdWtqdkhSaUNZ?=
 =?utf-8?B?N2NNb3FLdG01cm1Bam05SVI1eDdVeVdla2xIL1gxUDBtNkljcnltWk93UTZw?=
 =?utf-8?B?OTRTMEt6bXBmQmdMK3BjN1gwdmZFUmJUc3B6bUVOOG9BRzI2ekRrNHhobURo?=
 =?utf-8?B?ZEF4RmVNZzc2UWRMamV4bmpCMW8xZU5McjA4QnpSVEwwaE1TTStoYkE4KzVr?=
 =?utf-8?B?MGo4ZGd5MWtnbzIzY0xJRS9BZ09jL0FmNnUrWTl0eFZuNWYwbFhXcHJDNE5B?=
 =?utf-8?B?TjZDN3ZQSTB5d2hPcXZVUHByb2EreFNyU0xLekNWUk5uVXkxL1F6cmM1YVRV?=
 =?utf-8?B?RkJlTkhIVWNCSjVXQ045UVpjckxWaDU1aUhPR0hBalJwV3lBemJFMElWOE52?=
 =?utf-8?B?cllwT0h4cWg2QjJ4Y1BSdFpuc3F5Ly9BV0JtalBaN05KTSt2a004QVI3a04w?=
 =?utf-8?B?KytPTFYxajdJMVZyb2JCVXQ4ckNmcEZ0cytRR05UZUpDdi8wclVwSVpMbkkv?=
 =?utf-8?B?S2pJa29XYzNCR0xxMkZEYndiUmZmbzRpUkNyYUZ0NzBRaklLOXJnNVY3QjRp?=
 =?utf-8?B?dGUzWkJNVEc2dis3Sk5FcXlLRW1vSjc1cFdJb1lMR21BMXZWNjVhcW5CQ0dp?=
 =?utf-8?B?K2loNGxJVmRQdkNuTjc4VGNYK2lzRVd6VEg3QXNVRjNIS3Z2V24xSXJlelFB?=
 =?utf-8?B?NUliOUJTN3J3WGd0UU5IaTg2ZGRpdnA3QkJXZG1DdnFnV01PcnNhbnJmZEcy?=
 =?utf-8?B?N3pIMmo4NTlVbXNuUFp6OEVsRWZMWjBSU2RvM1dZN3FOTnZveG9OeCs1Mmw1?=
 =?utf-8?B?UHU5K2FqcDJTbkdRZVVhZThtdXJvd3hpVko5YndDcStjOG9nZERSUG1WSTdJ?=
 =?utf-8?B?UU95WWo3MGxkZTIzcUwwaktITjZIZ2x4UzZUR0x2VUpnOTNXRG51bXJtTVh3?=
 =?utf-8?B?WkZoVVYyTUJSL05hNDhzdE5Ca3lPNmwwcnJ3b2puOEd4QkhVMzZGQWVUaVFw?=
 =?utf-8?B?c2U4VlRMTFlHd0JIQ08wenEycEZqQWVaV2t1bzFPdmNMNU5pQTJKZUNBM2N2?=
 =?utf-8?B?K2xBcVloNkIvdXJvbVQrUkdMZy94L1MzOWM3cW1BN3dTK3h1ZDl4Qm1qamRC?=
 =?utf-8?B?TkFsTFg3d0srSWlMWWNVWEQ4Q2NLcGpvZFBDL3NPRm5CLzRpL0h2NFRRV2Zm?=
 =?utf-8?B?L1VPR25RbWlIaVk5cE44eElxM1RSTmV4bURtNnB4MVpCWXlwNG1RWE1jMmgw?=
 =?utf-8?B?dDBFVGxuRGI2MGdUQ3cxdDZtaEo4dHp5WmNwaGt3Wmxxb3laVnM4ejZnTDNP?=
 =?utf-8?B?QnlEaXp2dXU0V3lvV3RpYVEzUkFGUzJHeEZObzlrTjk3QmU4NjhIRW5USVhi?=
 =?utf-8?B?WXNMTDhzMWRUR25HYWUyNG9tSUJ3Z3BwWlNHbU41TE9WUzQ5dzZyTGFsR3FL?=
 =?utf-8?B?T1JrNDN5cTNBVGExVW5LaHRtcWlTWk93OTJtekJtTEVUWmtzQzhENjNQTm5U?=
 =?utf-8?B?U1ZIZjJHOFdRSUxCcXlQSUljdU5QSEIvYkhKNkpPN3pwU3duK2g2cVBsU3ZR?=
 =?utf-8?B?T2t4Q2RINWQ3WVJ6eWQxMmR0TndpY28yTS9LOWExYy9LQUNUTFZLOC9ZMkxE?=
 =?utf-8?B?WVZEeXUwdy9MYkJISkNPVzJIcnUvem9ITVdKYUY3eEdzendvRW5uQlk4bzJr?=
 =?utf-8?B?MHBlNUlzQW5SaVYrQ0N6MHlNZ1JzbWZ5M0JxK0VDWjNRUDQydGlsOURGNjVS?=
 =?utf-8?B?eDZ4cmw1WDEyYStGaXFlYWtUcXo1TEVVWlBXM2FFd3AvVjloSENOOWlQQ1hR?=
 =?utf-8?B?VXVQcUZNbXB3S2hBaU9HM2RFWDd4YW1KMG03bmJFN3FXcVA5RjJ4Wi9kbyts?=
 =?utf-8?B?WnR1dUJ0M082cEFRWGxHNTU2bEk4OVdyMkxVU3NzWTNVeG1Vamtxd3pwMnlX?=
 =?utf-8?B?Vkt1NkRkakhhaVorZVhPdjkrdEtIOWE4QU8wcC9VUER6amVSdHVtNXdWZGl3?=
 =?utf-8?B?SElFendqY1VaT3pEQURqQ2xKaXFkRVVWQWJ0YzJONytnWUppbkEyV1IrVUU5?=
 =?utf-8?B?czYrcUt5T0Q5Y0RuOWJHMjA2LytnUzRONkhmV2xTM1REcUpRVnZnaERiYWpZ?=
 =?utf-8?B?dGlna0lMMGdiWUNNb2xwem1Jd1ZvSkt3Nk1qQmh2Qmd1MDIrVW5acE42ZmJh?=
 =?utf-8?B?dGc0eGkrUmR5QlRHT2t1Ri93OXl2TDFSY09HZ1Jtc1MxNFpQcVViSnQ3N2gz?=
 =?utf-8?B?K1ZlNFd1QlZ4Uk1pNE9KMTY0MC9RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qwms2RD7X+G+tdOENJxKTq7XH6U9fE+eugreJMq/WPZKfSn6RNwpy8+7rt0ANxVmw35uNVzyBqHxds3bFEfSugYM/O0pdzMT84mAFJWXVjZwTICpZ0wLkIKh3rRI8X/kdBb/vZWqGA/I6u53DTXSbSTCS3+KP2RTIt3kGIHc44TW4J36vKyjY6Zg7JihgSi+kjXeMsRlyPacS/ISWucQpo+LpCyUKOJaqKCJAPUR4Fw4PBmViWVVgB+g3qei6ish+lydvoGOPJAlFEbJRXAov5P7WRjOcF/ljuXEVPgNKqv+z1JuRXCIw73HPqCa0eF7ToPsJQbBmID8lAxDQ/O6GZhrjxEIXcwiJtPa/iPBLH2j9USjxDsfKmkEqanD7cPxLp6miQqd+gGXySJx0MLnh4w7V4EVDtA3B4rRYK3/jdbxMAb5qFD8Yed1StN+SVvjNiORVhjLbwkyWKCmfx0jrzUAj88yZYWUt3MjY+IjYzzTRSIJRTuRwXB7UjAn4zkzK9B+XKFB3iQNatBnMr8rIGgaOXeMYJA7dUNbwFt1U0Tay3g3cQc7KxvX8dYKhPRukv/7es21gARmj7T0qAKtBbj7ydPtewSOgU/b7YU5+EI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd38e4f-8730-422f-6ab7-08de1799d662
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:51:03.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J4QcdKcDJ35Hr5xv6UKZRVhkqBN/KaJ4Md5FojepsgnK5xHlYizdmYeYnlDet1A1ogJgFQR4vxCufZiDGUjl0+KgtdKu9NS5AKcr+yJzXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300080
X-Authority-Analysis: v=2.4 cv=JJI2csKb c=1 sm=1 tr=0 ts=6903350b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=BDMOG8plukeRFKzP_ccA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13657
X-Proofpoint-ORIG-GUID: dBmXKvF_jTmXLbmO5u8HgcOfVCJ_9fTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2OCBTYWx0ZWRfX3szMQ3IaiuS+
 SCydkSEbisAsVfa445Jh7iL7OWQCIpJFv1Zn1o4P6p4nT/V+s6QC688K0tIPeZHquJ+zLE8OJxC
 jAdYSNTE86QaC0/oqlWfWvLkb1W0Ysl1I52skurvBATvvDhP+GTWalASqNi8Bg3gppZt1TgyVRu
 AiXHO8XJmDmBU1nCvdU2hrCxGwaF31wHeY1YgHfU1LMvSNKZpaS4zWy6xDFfwy5FRtyUOqwILq8
 xOSJvp5CGQSHywK9N9iHLFvKzGVR/nom8mygJh9gsfZLKIP2A3+l1C0hQwvYvWzCWjDSX4EW4Ax
 MIs8Ebv5gr80+lgfTl+oAaohxqbgVGQmSV63moziNeP24qYrMkNZqWDaXCrFT8vEsgHfsM2d1CW
 0MxOioc/K2r/eW1eiBMD42mlWQBh6QGzu0kc4g1SmTpGThYvA3I=
X-Proofpoint-GUID: dBmXKvF_jTmXLbmO5u8HgcOfVCJ_9fTg


On 10/29/25 17:17, Linus Torvalds wrote:
> On Tue, 28 Oct 2025 at 18:50, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> Just to clarify, Alexandre is working on objTOOL, not objDUMP :-)
> 
> Bah. Not the first time I misread - or miswrite - one for the other.
> 
> I actually have a stupid alias for disassembly, because I can't ever
> remember the long argument names:
> 
>     alias disassemble='objdump --disassemble --no-show-raw-insn --no-addresses'
> 
> so one day when somebody has an improved script around this, I'll just
> change the alias.
> 
> (Those flags, btw, are really bad flags in general, because you can't
> figure out where the jumps go when you don't see addresses. But my
> use-case is generally to look at the compiler-generated asm for
> "details", and then I use that objdump disassembly to get a filtered
> view of what the code looks like without all the section annotations
> and without all the other noise. So that alias is more about my
> workflow than about any kind of sane use).
> 
> Now, if objtool disassembly ever gives the kind of good disassembly
> that 'perf report' does - with branches turned into arrows etc - that
> would be lovely, and I'd replace my hacky alias in a heartbeat.
>> FWIW, this can be slightly improved by adding '-w' (objdump -drw) which
>> at least puts the function name on the same line:
>>
>>       call   34d <delayed_put_task_struct+0x1d>       349: R_X86_64_PLT32     rethook_flush_task-0x4
> 
> Yeah, that's better, and I think I could massage it with some
> scripting even more.
> 
> But I've thought about writing some simple scripting to make objdump
> output clearer many times, and I never really end up caring enough.
> 
> So I think I'll wait for Alexandre to do that for me ;)
> 

I am currently working on a new version (V3) which is mostly done.
Alternatives are now disassemble side-by-side and reloc is handled.
I am finishing cleaning up patches and I will hopefully send them
soon.

Here are some examples:

Example with stac/clac:

  4e6b6:  read_ldt+0xb6      test   %rsi,%rsi
  4e6b9:  read_ldt+0xb9      jne    0x4e6e6 <read_ldt+0xe6>
  4e6bb:  read_ldt+0xbb    | <alternative.4e6bb> | X86_FEATURE_SMAP
  4e6bb:  read_ldt+0xbb	  | NOP1                | stac
  4e6bc:  read_ldt+0xbc	  | NOP1                |
  4e6bd:  read_ldt+0xbd	  | NOP1                |
  4e6be:  read_ldt+0xbe	    xor    %eax,%eax
  4e6c0:  read_ldt+0xc0    | <alternative.4e6c0>     | EXCEPTION                    | !X86_FEATURE_FSRS
  4e6c0:  read_ldt+0xc0    | rep stos %al,%es:(%rdi) | jmp    4e6c5 <read_ldt+0xc5> | callq  0x1707 <rep_stos_alternative>
  4e6c2:  read_ldt+0xc2    | NOP1                    |                              |
  4e6c3:  read_ldt+0xc3    | NOP1                    |                              |
  4e6c4:  read_ldt+0xc4    | NOP1                    |                              |
  4e6c5:  read_ldt+0xc5	  | <alternative.4e6c5> | X86_FEATURE_SMAP
  4e6c5:  read_ldt+0xc5	  | NOP1                | clac
  4e6c6:  read_ldt+0xc6	  | NOP1                |
  4e6c7:  read_ldt+0xc7	  | NOP1                |
  4e6c8:  read_ldt+0xc8	    test   %rcx,%rcx
  4e6cb:  read_ldt+0xcb	    jne    0x4e6e6 <read_ldt+0xe6>
  4e6cd:  read_ldt+0xcd	    mov    %rbp,%rdi
  4e6d0:  read_ldt+0xd0	    callq  0x4e6d5 <up_read>

__switch_to_asm disassembly:

$ ./tools/objtool/objtool --disas=__switch_to_asm --link vmlinux.o
__switch_to_asm:
   82c0:  __switch_to_asm          push   %rbp
   82c1:  __switch_to_asm+0x1      push   %rbx
   82c2:  __switch_to_asm+0x2	  push   %r12
   82c4:  __switch_to_asm+0x4	  push   %r13
   82c6:  __switch_to_asm+0x6	  push   %r14
   82c8:  __switch_to_asm+0x8	  push   %r15
   82ca:  __switch_to_asm+0xa	  mov    %rsp,0x1670(%rdi)
   82d1:  __switch_to_asm+0x11	  mov    0x1670(%rsi),%rsp
   82d8:  __switch_to_asm+0x18	  mov    0xad8(%rsi),%rbx
   82df:  __switch_to_asm+0x1f	  mov    %rbx,%gs:0x0(%rip)        # 0x82e7 <__stack_chk_guard>
   82e7:  __switch_to_asm+0x27	| <alternative.82e7>                   | !X86_FEATURE_ALWAYS                  | X86_FEATURE_RSB_CTXSW
   82e7:  __switch_to_asm+0x27	| jmp    0x8312 <__switch_to_asm+0x52> | NOP1                                 | mov    $0x10,%r12
   82e8:  __switch_to_asm+0x28	|                                      | NOP1                                 |
   82e9:  __switch_to_asm+0x29	| NOP1                                 | callq  0x82ef <__switch_to_asm+0x2f> |
   82ea:  __switch_to_asm+0x2a	| NOP1                                 |                                      |
   82eb:  __switch_to_asm+0x2b	| NOP1                                 |                                      |
   82ec:  __switch_to_asm+0x2c	| NOP1                                 |                                      |
   82ed:  __switch_to_asm+0x2d	| NOP1                                 |                                      |
   82ee:  __switch_to_asm+0x2e	| NOP1                                 | int3                                 | callq  0x82f4 <__switch_to_asm+0x34>
   82ef:  __switch_to_asm+0x2f	| NOP1                                 | add    $0x8,%rsp                     |
   82f0:  __switch_to_asm+0x30	| NOP1                                 |                                      |
   82f1:  __switch_to_asm+0x31	| NOP1                                 |                                      |
   82f2:  __switch_to_asm+0x32	| NOP1                                 |                                      |
   82f3:  __switch_to_asm+0x33	| NOP1                                 | lfence                               | int3
   82f4:  __switch_to_asm+0x34	| NOP1                                 |                                      | callq  0x82fa <__switch_to_asm+0x3a>
   82f5:  __switch_to_asm+0x35	| NOP1                                 |                                      |
   82f6:  __switch_to_asm+0x36	| NOP1                                 |                                      |
   82f7:  __switch_to_asm+0x37	| NOP1                                 |                                      |
   82f8:  __switch_to_asm+0x38	| NOP1                                 |                                      |
   82f9:  __switch_to_asm+0x39	| NOP1                                 |                                      | int3
   82fa:  __switch_to_asm+0x3a	| NOP1                                 |                                      | add    $0x10,%rsp
   82fb:  __switch_to_asm+0x3b	| NOP1                                 |                                      |
   82fc:  __switch_to_asm+0x3c	| NOP1                                 |                                      |
   82fd:  __switch_to_asm+0x3d	| NOP1                                 |                                      |
   82fe:  __switch_to_asm+0x3e	| NOP1                                 |                                      | dec    %r12
   82ff:  __switch_to_asm+0x3f	| NOP1                                 |                                      |
   8300:  __switch_to_asm+0x40	| NOP1                                 |                                      |
   8301:  __switch_to_asm+0x41	| NOP1                                 |                                      | jne    0x82ee <__switch_to_asm+0x2e>
   8302:  __switch_to_asm+0x42	| NOP1                                 |                                      |
   8303:  __switch_to_asm+0x43	| NOP1                                 |                                      | lfence
   8304:  __switch_to_asm+0x44	| NOP1                                 |                                      |
   8305:  __switch_to_asm+0x45	| NOP1                                 |                                      |
   8306:  __switch_to_asm+0x46	| NOP1                                 |                                      | movq   $0xffffffffffffffff,%gs:0x0(%rip)  # 0x20b <__x86_call_depth>
   8307:  __switch_to_asm+0x47	| NOP1                                 |                                      |
   8308:  __switch_to_asm+0x48	| NOP1                                 |                                      |
   8309:  __switch_to_asm+0x49	| NOP1                                 |                                      |
   830a:  __switch_to_asm+0x4a	| NOP1                                 |                                      |
   830b:  __switch_to_asm+0x4b	| NOP1                                 |                                      |
   830c:  __switch_to_asm+0x4c	| NOP1                                 |                                      |
   830d:  __switch_to_asm+0x4d	| NOP1                                 |                                      |
   830e:  __switch_to_asm+0x4e	| NOP1                                 |                                      |
   830f:  __switch_to_asm+0x4f	| NOP1                                 |                                      |
   8310:  __switch_to_asm+0x50	| NOP1                                 |                                      |
   8311:  __switch_to_asm+0x51	| NOP1                                 |                                      |
   8312:  __switch_to_asm+0x52	  pop    %r15
   8314:  __switch_to_asm+0x54	  pop    %r14
   8316:  __switch_to_asm+0x56	  pop    %r13
   8318:  __switch_to_asm+0x58	  pop    %r12
   831a:  __switch_to_asm+0x5a	  pop    %rbx
   831b:  __switch_to_asm+0x5b	  pop    %rbp
   831c:  __switch_to_asm+0x5c	  jmpq   0x8321 <__switch_to>

alex.


