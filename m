Return-Path: <linux-kernel+bounces-830245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6DB992F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988D81B2359F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC072D877D;
	Wed, 24 Sep 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WHMAL2QZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AFRoOmdz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1C280018
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706679; cv=fail; b=TPWAi8tM20QkEIJ+RzGyJElaiIh5cPrjw6hdjdRPF6qnuqITCtCyA0zmEcnX++trBU0hYkFfpxV5FLFVr5DbdH2L2D66IsV3NdXhpfHhud3S1z0KXQrmIUWgNwO5LMFBoWf8W/prynq/3dB5kLPptx2cYPJt5XmGR12DQ/m96Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706679; c=relaxed/simple;
	bh=BDDXLUkuE7uUETTPFUa0w+lYZpZu+x2npjCFHCZaI/Q=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2s1vrUZhV8mLAlbUeox3nAKztWJyDxA5a7WNMufwoaOPNzpXa0yaWUZidH+1VTnwToeaOwZI9CohqqVNCevjvu/LuFbnMQ09YP7jO4X1fwHzlWWP0bsQ/VgsOHJpaBNgp1G/bnvVb1H0kNGc0//9dF/Lqy4d8BFp2XbGiQsbbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WHMAL2QZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AFRoOmdz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MrSo023399;
	Wed, 24 Sep 2025 09:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dJPgvW5fDq0qnboxe2KuzkkbGfpQNwtqf/nRKiCtUqs=; b=
	WHMAL2QZbkkSi7YvgmElS02KWyocX37gWpgMMgJHxYMW8I0fhnDnhz7L260EKL0f
	88nRIkz2KzNfxelBFi6yq5dn2GXGXGbNP7InTDLUfhQhZpLWNF0N8wNlUtfhB0K9
	riQ2qTfco3/bfc+54G1fp+66zHeP8R2hOBEJflqkLTIwUbRq5bTuyVRUrpYWhK2Q
	LTJ7Xr5DBNL9E8CzPeHsI2lfBxZXY7TAdx4Kuf9fMOIDz7+m3OAykW72PRg7l8M+
	yq8+C01j5JNA///YNR2gpmX2DKSrPRvYUoVnSsuN6X9k3+0Cn8RnDwWVOmp5RQvz
	TK5IxdB8SmB3oYa7YTY1/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499m59fc9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:37:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9bYUM036338;
	Wed, 24 Sep 2025 09:37:44 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9ckh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISebV/bRG8zx4fZoeFAQf6YZqImqcX4WZvnjd4KaIBQLc+9a6H574uz+teeOCRREURd+HGKpNOU4WeotJMOA9oG9jOsqiJoTPM0euw5q6c6Tyr74yeNUrqjR46nj7fupQ03a83g2H0QFSWDXbbIKCyQq+kf2OO93yrdp7g7eOwk+M+FzhFES40HkmwiQDRZT0IWcCZ11JM/DifpbDkOJTnf8l+rWCypssisqoaaXTw0RhaJPy39InKit9ZCyZncxFT8lQ3J46EEDLBtqv4dHrGvxMl/hazOquycaMWbRSlChxTeVFSBYhfDEI7how8PbU6O3xr1/ge75clmfVZm8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJPgvW5fDq0qnboxe2KuzkkbGfpQNwtqf/nRKiCtUqs=;
 b=WccccVkM1YuIHlEWnLUkNjnzVSD5G1bRmzaGMvvhWM7hQy/Mb0v3wX4fYlAEUSW15OaDPCUYGx4KWsMxYdCS7gQu6B46yXIjq6wxmRWjQha+p1hjySLoJIKqcBRds11nSYkfqrXlQmI0MrX1FBUZMziD+5dD65RxYOJJj3Jpp4xkaoqeNDorMyLjXYuiHeuCAg31F5bbfRBjJSYpA6DLiEYgGi+KBGZKI3Zbm+AlBUdZp3VKkfVAL88CS+21xpo/0jm4y3OPWGNR/gLcE/R+sZqazoCCvaxkZz7Gy8MYjl8N7OV3LmrAQiwS/WenlrTFbyUpao7xR4NDKJQxDI4KKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJPgvW5fDq0qnboxe2KuzkkbGfpQNwtqf/nRKiCtUqs=;
 b=AFRoOmdzX9MBelNjSqG777fwbwPGOnLUe4ugGjuQ1Ny72iL1meFJKBNP6UCQXDGsSA6mud7O3X81psrXMHe/BHRbfRMIqyzguPDSCW04P3dRC2/jsgtV50LwwCdX2d1lneOKcmnWY/+BO7VBAiAX8uPnj8mDpHu/lsFQcvfFJdw=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by IA1PR10MB6709.namprd10.prod.outlook.com (2603:10b6:208:41a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 09:37:41 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:37:41 +0000
Message-ID: <7017ead1-677f-4318-b12a-4c0269358065@oracle.com>
Date: Wed, 24 Sep 2025 11:37:37 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
To: Peter Zijlstra <peterz@infradead.org>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0525.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::8) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|IA1PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: af781fb6-326c-42fa-ec39-08ddfb4e0164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0t0S3RCc1drNno3bnlnN2VWQnVuSm52ZWF4QUp0OE9aMVpqQWJsL004S1RD?=
 =?utf-8?B?dmdVL3I1czgrc1AvZUlhdTVnS2Nzeml1dWpYQ2IyOGJUamVkOFpoV1cvZ0FV?=
 =?utf-8?B?K2FEM3piQXZTc2hHSW5OOXZ5dGhHd3dwNEp2MUp5bTlYeHo2djZaQ1BydDJC?=
 =?utf-8?B?YjVQbG51N2oyUXMrMzBGOTl5OXZxdDYrSzN6RjVtMVJwa2ZCUlAySFJVbE96?=
 =?utf-8?B?QU4rVnVQL2Fib0pqUHhUUFRwMFdwc2hwWjlkaWUvbHlpQ09iMHNWbE9PNUp0?=
 =?utf-8?B?Z3BEN1JTUkJCUXhpQ2JDTFR0QW05Tk9NTEpUVWxFdW5IcGt0ZGZZd3ZFM2R2?=
 =?utf-8?B?S0ZibXllZ2pFZXlWdytHazFQSW5ROWZMY0FZYTh5cy9LT3dndDcrSmVqR2ZN?=
 =?utf-8?B?aGxlL2ZMYXdmVDI1b01qazV6VjVCUEtyZm5KS21QK2hFWlh5a3lzcDJpcTVZ?=
 =?utf-8?B?RHZGRXlMTGhpK05iYTU4d05tMGVYNkJhcUF4blVzRWRONDhTUXQzaTNIZFVZ?=
 =?utf-8?B?NHdpQ2RYc3Y0Q2M4T2ErT2JQVkV4b3VGVjNpRTNWUnRqVk5kd1FNdUJGZ3U0?=
 =?utf-8?B?ZjhWY1M5R2Y2NEdTWlM3Y0N5MXc5N0l3Y3IyU2FDKzhsc0RTMllFZld6bGox?=
 =?utf-8?B?WFRhZVRrZ2hqR0IzWUZSa2pLektKK0pKUDlJTW5OOXFpMHdvZkRRam8zRkpN?=
 =?utf-8?B?WlF6UnNKZDUzUmNEV0pxL1c5NkhRWEk5L1dwdCt5Z1RNZlRwUG5yb3VRNEQy?=
 =?utf-8?B?L2tzcytDRmJtcmlJSVEvTUMzb3krYnpxclpyckcyZkdHOCtlWE9TelJNakYv?=
 =?utf-8?B?TEtRZmE5S3VwTGsrZzJaWS83MWFPY3BLUVZ3MXhsTTQ5bk1DcE1WRXgwbXZv?=
 =?utf-8?B?ZFMxdTZLZjB1U3FPZDFkaTVzVmZ6RkNyczgxYUN0Q1h6QjRONFRjdFBzSlRX?=
 =?utf-8?B?OWRKNXFMRU5LWlZHcjRFeFFhNUJTcDYra1MrMkxlZ1hIUTBUamFVWTNGSkRF?=
 =?utf-8?B?czF4UnRjK3gyTHRQWURhTHUvZDl5S2E4WTFZNEs2cFhUK0J6Z1FDMG1vOElG?=
 =?utf-8?B?SDJ4SnJtVXluajA5b3hEMzhMY21GR3NDNDFRVklIVE56RFNiYnRFSEhrN1gx?=
 =?utf-8?B?bGZtMkhVcndqbHZsRGRqUXl6bHNvZ2dKNHN1V0hYZnhzWVBDQlJaRVJhNXgy?=
 =?utf-8?B?bWdxaWhMU3BQeDNWSHpzc3h0WXVSV05kdmZNZjM0cUJFdTlhRVNVQzZMZS82?=
 =?utf-8?B?WGtoRDRvVGxkeFpmbC9CZHhVelZkTGpSNU10SHFJTXlhZEFscmg3ZkswWW4y?=
 =?utf-8?B?b3Z5NlBvcE9RTGhwNzNVb0RCS1h4TWljK1pvbkhzWDVBclh0bVo3cjI3aTJT?=
 =?utf-8?B?S2tuMzRQRW9FK0VFcTJFNnlqNWFmcUZEODdaM2NGU3RzNk1YMXlqWCtWZ2d1?=
 =?utf-8?B?eDFyU1NDUFhNSlpUeXpTZ3c2TEV3cWRHdmt5em5xZUVkdkFNZU1UblZsUHA1?=
 =?utf-8?B?OHJiTUxKZ0lXL1o5ODdRSUVoL0F1ZitteFBSTzMvRmNhTEx1d0xVcUlNNVNZ?=
 =?utf-8?B?aXlmckt0eTF4R1FTbTc4Tjh4dnJNN3o1SVJRWTR0S2JVY2lrZnpYcXc0NHJn?=
 =?utf-8?B?YmxYbU9jUU5MVExTcC84SDdYZzlrdDAyK0w1bDlKaThYU0xlYkVuV1RKeGxy?=
 =?utf-8?B?NGRGSmlJblNCTXpzaXpwdWlwdHB5c3RzUVRXd0xidGZNcW42cUcvdmppK0th?=
 =?utf-8?B?SWdUcFQ3WXZ2L21FYlN0VWwrZUFxb0ROUEh0RmRZTStyaXU3d1NZaUpkQWpr?=
 =?utf-8?B?T0RDbkpIcnJpeFRPc203VTIvM0N1QjVUQWNOL0lwSFoxaVFTcktLa0J1R0pY?=
 =?utf-8?B?OFhyck1lekdFVEtFYmx5ZC83aGRLRnhpN21OYkpGbGdQN0ltWkZBK294S3hF?=
 =?utf-8?Q?YBYQAVt3+v0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlhKUjNwMGp2OHd5b0tXMkZlTTFuRDJ0V1BhcGhWUmhYbEtTd1pzRnVaR1Rq?=
 =?utf-8?B?Mmx0RVVpNk1hWDA2UXdMYmhDOFkrMGVmRmhKRzQ1N0hvaXpVaGpDMTlpbHFp?=
 =?utf-8?B?OFk3VHh6bjdPVmpDYkdnVkptK0RhWGlQZUZ2TVNvcUFFM2dVdjZQWnpoeUVV?=
 =?utf-8?B?UXh0Ykd1TUNBb0RPOWpFZnhidG9WS3RNbkVHTUd3dDd0dkxPR045bkE2SEV3?=
 =?utf-8?B?blkwSFY4azdDK1BIVlNGdC9LSUM3anordDk5ZzUzaEVOSEs3bUJNazV6NXpD?=
 =?utf-8?B?TytoMVRSTExFd3J4QXlVc3paQXhoMXFSU3BOekQrME1GemV5YzN1MXdrc2cy?=
 =?utf-8?B?N2Y3OXBGcjNtTUVERDREc1NQbEwySFNmOVlXM3JLdldCdEpWb3lZYXhub3ls?=
 =?utf-8?B?STBqZ1JHTjNOZHdEczJHOTVWeTFkOXJHMjZzcHBZWDlnYXJWVmdrRTNSQVps?=
 =?utf-8?B?NU9OUWV2QnZ1YkdvWnRaRkFTQnpvT2tkTHd2ZzkyUHUzOXlMNERPT0UraENm?=
 =?utf-8?B?d0xYMkhPQXZKS1d0S2lidFNxSlViZ0FPR3Q4V2E1bDd0alNSbGM2RkhJa01K?=
 =?utf-8?B?S2RxZUp3OEZlTkJRNENNNFZsZEVpTHJ0L05HeU1pMFZJWXUxbUc3M3NKTWJk?=
 =?utf-8?B?a0dKRktEUTlaTGZMVk12YkpYQjg3T2hBQnZyTm8vQVhnVnJqQVFDUytwMGRI?=
 =?utf-8?B?TzFQdnM5eWk0MGFFQVVUd0ZRUEd1OUUwTVZmRXJCWk1STkFRSkFlcEx1Z01o?=
 =?utf-8?B?MjU3UFUzUVJLSUhSOTd1dHJINlFrK1RVaUNhZUd4a2NxK2lLdmVLMGUvSHlV?=
 =?utf-8?B?YjQzZ1FFcEhGTFJrMHBjOUVQQXVhc29WYm1LNlFGLzRTUmUxMTd0OW41M3Ry?=
 =?utf-8?B?VWRwS0lpSFlvbmIxOEhoY3EwVmVTRDhiWm9nbXB4ZHNyVzVTVlRQQkJxY21Y?=
 =?utf-8?B?MFdlYk45NXVLMFRZMW5aemdGL3ArcFlDOC9GT3pRSmFac2pKMEY3N1dYNWtG?=
 =?utf-8?B?b3Z0ZEo4SHRuWmxQUUZ2dklxdHcrWGQ5RmhZMDJnN3h1OGZGVDAvbWV4c0lw?=
 =?utf-8?B?QkdZL0hnQjJONTlUdzdRQWxFT0x3UG1lTEI1RitlZkZhUXJBQnlwbUJxT0hW?=
 =?utf-8?B?MWp3OXc0VXpzU3VTS3ZEQ2NJVUtZQ2F4MGZEZDdYc0tJeGFSSE84MG9UWXJ1?=
 =?utf-8?B?eTFvNnhnUldTdXFzZlZ4Y1RBOFB6WTlpMW12Tk45aElPeHZSQ292WkpiR3lH?=
 =?utf-8?B?c3pFMndKREJ6QVV6b3ZaVE5xaDYwOHRqRWZqdFZrRFQrWnE1YTZIUWxkUVdH?=
 =?utf-8?B?WjhHNXZnNy9jZ1pkaXFkOHd5bUhUeStzK0pvNWVCRUs2MEZ6ZG53eG8zWTFK?=
 =?utf-8?B?R25sb0RhK2ZoQXQrelFPWWovRGg1M1FsUnNNUXJKWjM1SnNqazBwNU9hZXBS?=
 =?utf-8?B?NnFqL1FjaDhSUVY3ek9xZjhZcEdzWGJDSlA5VHliS2lxb3VuTVNtVzJDSFE3?=
 =?utf-8?B?bDlCanhzNDZndEtGOTBqWkM4LzE0U3hXREhkdFFSOVE3bUxFK2RNNGxjYUVI?=
 =?utf-8?B?STV2SWkwNUFyNjhBMEdtWnVmbXozMmFnaGxRdWRmVUtucmlNTUZidm1IaFhN?=
 =?utf-8?B?cXVnRWhnUllmYW1rbmJuUWgrVXF1aUlrQVZiKzV3RUlZM1pZNGg5a0pub2JQ?=
 =?utf-8?B?bmo4S3A2MDlydTh5N1lHWXkxdjZiMjBzVHJ0c1Z4OHQ1aTlVWWJWSUZwUFpz?=
 =?utf-8?B?akpENEdFVFZ6cENwYkd1MllrcUJLSDlkZ2UzZGhJQXArcmhCTWw3WkhDQVhP?=
 =?utf-8?B?bUs2bHU2TEtoWENZQzVvZU5CcndNbGFoT29LTjJ1M25WSnc2azlxc2QvcUpS?=
 =?utf-8?B?L0I2eExXOHA3SlM3bGhoa0NyeG1PRmFQVHk2dE5oemRqNmtvYnJlTmRQa01p?=
 =?utf-8?B?eWpvUDQwTE9rU2VhVDNWSDdPNGtXb1hXaEEvTjdud1BWZWwrbjVXNVlFWnZt?=
 =?utf-8?B?WmkyQTJYWHNibTZ5MTY2QTVyQytsbzdxRm80S3J0a043M1dieVNPWjN5dnRt?=
 =?utf-8?B?aEViU3ZFc29jRzZ4eHIxZlluTi9vaUdrVE1WTVVQUm0zNEVzaXVOQ0xVcWNT?=
 =?utf-8?B?emFkTW05QktHbml0allkUzQ3K2pNQUF0OVdNRXhWL3FmSmhPMXFxYVJiZXZO?=
 =?utf-8?B?MXVERGdkSFZWdkhLWjh1OGJlcDVYOGE0aThUbEx5Y1VVMUpFdmlIbU9WR0hy?=
 =?utf-8?B?Z2pMY094Uk5LYk41dDc2QUlCS1ZRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SVauh93BWq3aJdwS2ET1tbs64Qhk4dePM17JsT5HOkZk5w4fuzqD3P2FZHLNUpF+Ev6L2Z/EBkl325aV92KKKNC0UbyUnVgmN/6IJS/SGqKEOx6tzLavE4jLFRi1BS5jjmhS9Cm64l3TftBTYbpM4PqViYLCTVQzsVtOlz2p9ImkTgnuRCNQ+8dK0CNxIkSCHPSYI6HIl7jQ1IHL2+G+tSH5FjFJVIprgz1AenHwpYFNvjyRSBrHMOnLcA1cNu+YyKWZD+oxIBxXlfZBvl0wEy7bjopzMhE6o0uGo+eDrQORt7poKyyHna4nfHES9DYdmPdC/cI3ZLIhDdsCS8rv2ICowP9QTvHzIJ8TGxStjcL1sivd6i7FRFZS0JN87+VVqdiXpQYhkEtKaj+UTX8lguDVcbDd1X9vzTfIE7BBQVuUuC5bP7WyauowFpdYu57MhAhovAvTTvQYYRPrpfuzBVu/L28FLpiabgA2A3XVQk05sJ6TaevTtIVcK+lnCtdd0ZgEM3KO9tWPt2J45eiYQJDpE4ZbIimCormpYwmOoF7NlaYGEfaFUGpjtp3pZ/9y4svc5mCUrc9Kh7Z0XUdIM5az3IGQtQ16xo6Z7B19+yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af781fb6-326c-42fa-ec39-08ddfb4e0164
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:37:40.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE0A2ZDuZCZerQ4AkveAYSpVbe5VJ+bX5WZvRx3AZfrA6W0ggRFAThQ82W9hh0IiUPTIu94wzw7rJm9hNL2wolh6evURxtxHngc4lNiueoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240082
X-Proofpoint-ORIG-GUID: 6bq8QeaTcENvx3Axtt3sF5ADJM27l2aQ
X-Proofpoint-GUID: 6bq8QeaTcENvx3Axtt3sF5ADJM27l2aQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOCBTYWx0ZWRfX/IVsc92kt59Y
 TZCabMiqIclLI3QAdc54D+e1sXZyLIMIeivvARNb7DLKjUXvmnn3+hUx0M8hxrzs2mdtlTBs3H8
 SMSlh8k5eMYcX8PkRWExjxW14S1axLag5sEmMuobZ3zEyGXkKlWrYxM2vj5ETw+qD8mZFVsi7mR
 5x3cf7RENTNS6ffaWi6/v1MGbKTP2fq/nwyi31Nrys2OtXFx3CjW8w/iVeKLJxEHwqC2ovW+vwe
 osAJ3S6DmIKWSEkU+ipn+zz30xdyIKFUU0LprpLTOY1KlBBGEgZHXUcwlNVfuoh3ZxeloOR0HU3
 T/+7mHzkX52ECrWOLbSYToIU8oPxHvhkkaP1Jq2y2AzE8ibZvCvXTwttJwin48CDxtO1rIyVUs8
 w6xL/Lq6
X-Authority-Analysis: v=2.4 cv=HJrDFptv c=1 sm=1 tr=0 ts=68d3bbe8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=PRkf8TWIDrJVpBlybB8A:9
 a=QEXdDO2ut3YA:10


On 9/24/25 09:36, Peter Zijlstra wrote:
> 
> Sorry, but I hadn't seen these patches until Josh replied to them just
> now :/
> 
> In general I really like the direction this is taking; I agree with Josh
> on the +0 thing, in general foo and foo+0 are not the same. Where foo
> can be the entire function, foo+0 is always the first instruction.

Ok, I will use this rule.


> Furthermore I have some nits about the output, but I don't think we
> should hold up merging these patches for that; it could just be me
> needing to rewire my brain or something ;-)
> 
>> Example 1 (--trace option): Trace the validation of the os_save() function
>> --------------------------------------------------------------------------
>>
>> $ ./tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --orc --retpoline --rethunk --sls --static-call --uaccess --prefix=16 --link --trace os_xsave -v vmlinux.o
>> os_xsave: validation begin
>>   65c20: os_xsave+0x0  push %r12				- state: cfa=rsp+16 r12=(cfa-16) stack_size=16
>>   65c22: os_xsave+0x2  mov 0x0(%rip),%eax # alternatives_patched
>>   65c28: os_xsave+0x8  push %rbp 			- state: cfa=rsp+24 rbp=(cfa-24) stack_size=24
>>   65c29: os_xsave+0x9  mov %rdi,%rbp
>>   65c2c: os_xsave+0xc  push %rbx 			- state: cfa=rsp+32 rbx=(cfa-32) stack_size=32
>>   65c2d: os_xsave+0xd  mov 0x8(%rdi),%rbx
>>   65c31: os_xsave+0x11 mov %rbx,%r12
>>   65c34: os_xsave+0x14 shr $0x20,%r12
>>   65c38: os_xsave+0x18 test %eax,%eax
>>   65c3a: os_xsave+0x1a je 65c6a <os_xsave+0x4a> 		- jump taken
>>   65c6a: os_xsave+0x4a | ud2
>>   65c6c: os_xsave+0x4c | jmp 65c3c <os_xsave+0x1c> 	- unconditional jump
>>   65c3c: os_xsave+0x1c | xor %edx,%edx
>>   65c3e: os_xsave+0x1e | mov %rbx,%rsi
>>   65c41: os_xsave+0x21 | mov %rbp,%rdi
>>   65c44: os_xsave+0x24 | callq xfd_validate_state 	- call
>>   65c49: os_xsave+0x29 | mov %ebx,%eax
>>   65c4b: os_xsave+0x2b | mov %r12d,%edx
>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 1/4 begin
>>   65c55: os_xsave+0x35 | | test %ebx,%ebx
>>   65c57: os_xsave+0x37 | | jne 65c6e <os_xsave+0x4e> 	- jump taken
>>   65c6e: os_xsave+0x4e | | | ud2
>>   65c70: os_xsave+0x50 | | | pop %rbx 			- state: cfa=rsp+24 rbx=<undef> stack_size=24
>>   65c71: os_xsave+0x51 | | | pop %rbp 			- state: cfa=rsp+16 rbp=<undef> stack_size=16
>>   65c72: os_xsave+0x52 | | | pop %r12 			- state: cfa=rsp+8 r12=<undef> stack_size=8
>>   65c74: os_xsave+0x54 | | | xor %eax,%eax
>>   65c76: os_xsave+0x56 | | | xor %edx,%edx
>>   65c78: os_xsave+0x58 | | | xor %esi,%esi
>>   65c7a: os_xsave+0x5a | | | xor %edi,%edi
>>   65c7c: os_xsave+0x5c | | | jmpq __x86_return_thunk 	- return
>>   65c57: os_xsave+0x37 | | jne 65c6e <os_xsave+0x4e> 	- jump not taken
>>   65c59: os_xsave+0x39 | | pop %rbx 			- state: cfa=rsp+24 rbx=<undef> stack_size=24
>>   65c5a: os_xsave+0x3a | | pop %rbp 			- state: cfa=rsp+16 rbp=<undef> stack_size=16
>>   65c5b: os_xsave+0x3b | | pop %r12 			- state: cfa=rsp+8 r12=<undef> stack_size=8
>>   65c5d: os_xsave+0x3d | | xor %eax,%eax
>>   65c5f: os_xsave+0x3f | | xor %edx,%edx
>>   65c61: os_xsave+0x41 | | xor %esi,%esi
>>   65c63: os_xsave+0x43 | | xor %edi,%edi
>>   65c65: os_xsave+0x45 | | jmpq __x86_return_thunk - return
> 
>>                        | <alternative.65c4e> alt 1/4 end
>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 2/4 begin
>>   1c3d: .altinstr_replacement+0x1c3d | | xsaves64 0x40(%rbp)
>>   65c53: os_xsave+0x33 | | xor %ebx,%ebx
>>   65c55: os_xsave+0x35 | | test %ebx,%ebx - already visited
>>                        | <alternative.65c4e> alt 2/4 end
>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 3/4 begin
>>   1c38: .altinstr_replacement+0x1c38 | | xsavec64 0x40(%rbp)
>>   65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
>>                        | <alternative.65c4e> alt 3/4 end
>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt 4/4 begin
>>   1c33: .altinstr_replacement+0x1c33 | | xsaveopt64 0x40(%rbp)
>>   65c53: os_xsave+0x33 | | xor %ebx,%ebx - already visited
>>                        | <alternative.65c4e> alt 4/4 end
>>   65c4e: os_xsave+0x2e | <alternative.65c4e> alt default
>>   65c4e: os_xsave+0x2e | xsave64 0x40(%rbp)
>>   65c53: os_xsave+0x33 | xor %ebx,%ebx - already visited
> 
> I find it *very* hard to read these alternatives. If at all possible, I
> think something like:
> 
>     65c4e: os_xsave+0x2e | xsave64	| xsaveopt64	| xsavec64	| xsaves64
>     65c53: os_xsave+0x33 | xor %ebx,%ebx
> 
> Would be *much* easier to follow
> 

Ok, I can try. It will certainly works well when the alternative has a very small
number of instructions (in particular for single instructions). I am not sure it
will display nicely with more instructions, especially when instructions are not
aligned on the same addresses.

But it's worth trying, and maybe have options for different formatting.


>>   65c3a: os_xsave+0x1a je 65c6a <os_xsave+0x4a> - jump not taken
>>   65c3c: os_xsave+0x1c xor %edx,%edx - already visited
>> os_xsave: validation end
>>
>>
>> Example 2 (--disas option): Disassemble perf_get_x86_pmu_capability()
>> ---------------------------------------------------------------------
>>
>> $ ./tools/objtool/objtool --disas=perf_get_x86_pmu_capability --link vmlinux.o
>> perf_get_x86_pmu_capability:
>>    d000:  perf_get_x86_pmu_capability         endbr64
>>    d004:  perf_get_x86_pmu_capability+0x4     callq  __fentry__
>>    d009:  perf_get_x86_pmu_capability+0x9     mov    %rdi,%rdx
>>                                               <alternative.d00c> default - begin
>>    d00c:  perf_get_x86_pmu_capability+0xc     | jmpq   .altinstr_aux+0x90
> 
> (you probably need to relocate the target -- we never jump into alinstr)
> 

Right. I probably doesn't resolve reloc in alternatives; I will check that.

>>                                               <alternative.d00c> default - end
>>                                               <alternative.d00c> 1/2 - begin
>>                                               | <fake nop> (5 bytes)
>>                                               <alternative.d00c> 1/2 end
>>                                               <alternative.d00c> 2/2 - begin
>>     5e5:  .altinstr_replacement+0x5e5         | jmpq   perf_get_x86_pmu_capability+0x3f
>>                                               <alternative.d00c> 2/2 end
> 
> Idem; the above is *really* hard to decipher.
> 
>    d00c:  perf_get_x86_pmu_capability+0xc | jmpq   .altinstr_aux+0x90 | nop5 | jmpq   perf_get_x86_pmu_capability+0x3f
> 
>>    d011:  perf_get_x86_pmu_capability+0x11    ud2
>>    d013:  perf_get_x86_pmu_capability+0x13    movq   $0x0,(%rdx)
>>    d01a:  perf_get_x86_pmu_capability+0x1a    movq   $0x0,0x8(%rdx)
>>    d022:  perf_get_x86_pmu_capability+0x22    movq   $0x0,0x10(%rdx)
>>    d02a:  perf_get_x86_pmu_capability+0x2a    movq   $0x0,0x18(%rdx)
>>    d032:  perf_get_x86_pmu_capability+0x32    xor    %eax,%eax
>>    d034:  perf_get_x86_pmu_capability+0x34    xor    %edx,%edx
>>    d036:  perf_get_x86_pmu_capability+0x36    xor    %ecx,%ecx
>>    d038:  perf_get_x86_pmu_capability+0x38    xor    %edi,%edi
>>    d03a:  perf_get_x86_pmu_capability+0x3a    jmpq   __x86_return_thunk
>>    d03f:  perf_get_x86_pmu_capability+0x3f    cmpq   $0x0,0x0(%rip)        # x86_pmu+0x10
>>    d047:  perf_get_x86_pmu_capability+0x47    je     d013 <perf_get_x86_pmu_capability+0x13>
>>    d049:  perf_get_x86_pmu_capability+0x49    mov    0x0(%rip),%eax        # x86_pmu+0x8
>>    d04f:  perf_get_x86_pmu_capability+0x4f    mov    %eax,(%rdi)
>>                                               <jump alternative.d051> default
>>    d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax
>>                                               <jump alternative.d051> else
>>    d051:  perf_get_x86_pmu_capability+0x51    | jmp    d053 <perf_get_x86_pmu_capability+0x53>
>>                                               <jump alternative.d051> end
> 
> this is a jump_label; if we would retain the whole 'key' reloc, and
> not only the key_addend, you could make it something like:
> 
>    d051:  perf_get_x86_pmu_capability+0x51      [ jmp.d8 d053 <perf_get_x86_pmu_capability+0x53> ] * perf_is_hybrid
> 
> (also, this here reads like it is either nop2 or jmp.d8 +0, which is
> 'weird')
> 

I will try to improve this.

Thanks for feedback.

alex.

> 
>>    d053:  perf_get_x86_pmu_capability+0x53    mov    0x0(%rip),%rdi        # x86_pmu+0xd8
>>                                               <alternative.d05a> default - begin
>>    d05a:  perf_get_x86_pmu_capability+0x5a    | callq  __sw_hweight64
>>                                               <alternative.d05a> default - end
>>                                               <alternative.d05a> 1/1 - begin
>>     5ea:  .altinstr_replacement+0x5ea         | popcnt %rdi,%rax
>>                                               <alternative.d05a> 1/1 end
> 
>    d05a:  perf_get_x86_pmu_capability+0x5a      | callq  __sw_hweight64 | popcnt %rdi,%rax
> 
> 
>>    d05f:  perf_get_x86_pmu_capability+0x5f    mov    %eax,0x4(%rdx)
> 
>>                                               <jump alternative.d062> default
>>    d062:  perf_get_x86_pmu_capability+0x62    | xchg   %ax,%ax
>>                                               <jump alternative.d062> else
>>    d062:  perf_get_x86_pmu_capability+0x62    | jmp    d064 <perf_get_x86_pmu_capability+0x64>
>>                                               <jump alternative.d062> end
> 
> Same jump_label again, with the same problem, the target seems 'wrong'
> 
>>    d064:  perf_get_x86_pmu_capability+0x64    mov    0x0(%rip),%rdi        # x86_pmu+0xe0
>>                                               <alternative.d06b> default - begin
>>    d06b:  perf_get_x86_pmu_capability+0x6b    | callq  __sw_hweight64
>>                                               <alternative.d06b> default - end
>>                                               <alternative.d06b> 1/1 - begin
>>     5ef:  .altinstr_replacement+0x5ef         | popcnt %rdi,%rax
>>                                               <alternative.d06b> 1/1 end
>>    d070:  perf_get_x86_pmu_capability+0x70    mov    %eax,0x8(%rdx)
>>    d073:  perf_get_x86_pmu_capability+0x73    mov    0x0(%rip),%eax        # x86_pmu+0xf8
>>    d079:  perf_get_x86_pmu_capability+0x79    mov    %eax,0xc(%rdx)
>>    d07c:  perf_get_x86_pmu_capability+0x7c    mov    %eax,0x10(%rdx)
>>    d07f:  perf_get_x86_pmu_capability+0x7f    mov    0x0(%rip),%rax        # x86_pmu+0x108
>>    d086:  perf_get_x86_pmu_capability+0x86    mov    %eax,0x14(%rdx)
>>    d089:  perf_get_x86_pmu_capability+0x89    mov    0x0(%rip),%eax        # x86_pmu+0x110
>>    d08f:  perf_get_x86_pmu_capability+0x8f    mov    %eax,0x18(%rdx)
>>    d092:  perf_get_x86_pmu_capability+0x92    movzbl 0x0(%rip),%ecx        # x86_pmu+0x1d1
>>    d099:  perf_get_x86_pmu_capability+0x99    movzbl 0x1c(%rdx),%eax
>>    d09d:  perf_get_x86_pmu_capability+0x9d    shr    %cl
>>    d09f:  perf_get_x86_pmu_capability+0x9f    and    $0x1,%ecx
>>    d0a2:  perf_get_x86_pmu_capability+0xa2    and    $0xfffffffe,%eax
>>    d0a5:  perf_get_x86_pmu_capability+0xa5    or     %ecx,%eax
>>    d0a7:  perf_get_x86_pmu_capability+0xa7    mov    %al,0x1c(%rdx)
>>    d0aa:  perf_get_x86_pmu_capability+0xaa    xor    %eax,%eax
>>    d0ac:  perf_get_x86_pmu_capability+0xac    xor    %edx,%edx
>>    d0ae:  perf_get_x86_pmu_capability+0xae    xor    %ecx,%ecx
>>    d0b0:  perf_get_x86_pmu_capability+0xb0    xor    %edi,%edi
>>    d0b2:  perf_get_x86_pmu_capability+0xb2    jmpq   __x86_return_thunk


