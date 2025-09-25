Return-Path: <linux-kernel+bounces-832160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D29B9E857
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE61B242B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB3286D73;
	Thu, 25 Sep 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mhtUiXmc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OC39Drss"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AED2874E4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794168; cv=fail; b=eWRIupZ3xlGOt1HeJKS9DCk77wXJ7tOM9ETUX0SiGJwt4ZF8V00YwEn62Rqg7BqY8mzBhFmhb9kCi9TLhZLCrotFPdeiQVJpSxc2Us+uBVgdI73aPatNHeQtnhWdocFLdRRCZ9yUAQ5znS45b5kbYkU/srDPa1IsZT6PVNFpbaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794168; c=relaxed/simple;
	bh=JFWtQqTr7JwdJPk87eVdsKSY7J8t28D2UMJNFjKGwzc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQ/A7SSHQNABWMzz1GAMLm1YpX5ZbEVjAQuXdZO6u59v7y8pb4YVGNiMk+KHygjtlrKMJYwJVk/n+e/6DCq6eDr7qKzJC4zoeO5iv0zdRNZ8TuMNPDuISHfqEuPRf2NH1/n6eYDcvOIUx04ai+kaQeutfBZI5XErnRwOz30XdNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mhtUiXmc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OC39Drss; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7u7F7012296;
	Thu, 25 Sep 2025 09:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IEcH2Wj5e7ZG2ON/ywA/G1IXfB9cPdW+SFbkEvaJ3+w=; b=
	mhtUiXmcNhU2m5IdIFu89Ie3dRFdENuHx3PZf369nizyA6NrET7hqO1qgmkf0ibj
	16hUoCaxwJLGR76F76thAnagYGYoAxWgfGSYMT1//+7G6v8/AhzwE/gQ10OCy59r
	3d3PP1b0gbKe2c72c2g0rrpBtptVN9t/pf879EE9wd6qHYfPYO4NkhTNIRDdggif
	IpTQ4W+WtWPGyKvVrPrVMKahqBvfC4GwZ5iQ+tYeuVLCSBvLMv1HNlyDgIla3/qV
	9/vIDUmcjAyN2qO2CLrXR75Nz4CT6i3l1MprTMDExT74ZDL6QVHdHgRW7co+5O6P
	cCjNAfu24/Gyg7OYUQsNOg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6b1k9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 09:56:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58P82Olh030379;
	Thu, 25 Sep 2025 09:56:02 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqb1xsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 09:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPmRYlFnrqEzAMmKvvQU5MX4FAYyjW1s9By1xsgFAibXC7Xm2WVoo5TFSSBGLkzUMqtgMUeieR0DzZqPB/z3XcI3RkEmIGYqLI6NmCMJo3cXyjo48h3fXBmUSf+KW0zz5Lm1jMAorpSjCtUftigLk6tz0quB5ywmSfKV6ue4tMCjx7M+OQprJnOXufnvKUUYRg7tJUpwjjFU5w6awYAFaDhyaDle1f7y8JjXBaW4tgk1hZC7YrOt4zN5sakJLIhF+WzhI+Ws7aZcUT8OOJ+9d1LbQYOe2QNV1e5IPlMFEOvS4by67LVcjVrnNmfsEZb0wx+O/5VyOv0k10V1hN/Jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEcH2Wj5e7ZG2ON/ywA/G1IXfB9cPdW+SFbkEvaJ3+w=;
 b=E6NhwKo2KwYxODorbc5JZ+shbsRr/tFNvF6VPY4Sr2tJ/6xxLOiEkFlcsZxaDQsfVrwToZnjjkrHbYd/v1cOO4oMZJGhS7fyAbqvmHmkN7qzbm9iUwP3JzJjGgqZEYLm9shCy7Jqeqovm1F3vEXq1PDZwKK6f+SqHv+brcUL000F+j9OSkcKV+5sFw9KUlPfw4rTbHbRFzimqJr5/2rjI6UCt8gV9soX1F6RAIaqO9MSRTgYiecR1RyPhoYtV0u2ps+S80wczZhOnmWSJnFJGqzdifTFKZTQy0jn7lIMKV7wdgQHMlnAt6PLyGgolmGXI98U6Metryl9xqWAWnaQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEcH2Wj5e7ZG2ON/ywA/G1IXfB9cPdW+SFbkEvaJ3+w=;
 b=OC39Drssh8Zfma6Oeg3Q4zHZbt9F4PUBd1BAmJikbNbNxrZ0v1j3Zoodw5WcUog8r6UARuO/D1P8HRPQVPBFQVlj3BxIgf/2r89HLpOK/ryHWFoSeZumE5bflsttnljqjr8u9wvXe36MYbIP18TfwLwAnXvb4+1h04sZWklxA4E=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by IA1PR10MB7287.namprd10.prod.outlook.com (2603:10b6:208:3fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:55:59 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:55:59 +0000
Message-ID: <f7ae7451-1cf3-4235-93ba-7c916838c7a2@oracle.com>
Date: Thu, 25 Sep 2025 11:55:56 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] objtool/x86: Remove 0xea hack
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org, x86@kernel.org
References: <20250924134507.288529132@infradead.org>
 <20250924134643.907226869@infradead.org>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250924134643.907226869@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::21) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|IA1PR10MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8807d423-5358-4622-190a-08ddfc19ba6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHQwT2ZyM2dPY04zV1NUN3p5eEdIZ2pXMEg0Z2Z5ZUlVaWhIYzBhbCtHTHE4?=
 =?utf-8?B?RHdURlNRVDEvd2ZqTDZ1M1hSRmY5NlliYzcxRUFUYXNlWTlxbjFJME1DV0Ro?=
 =?utf-8?B?aWhDcDR0MVBZcm9ZaGJvUkkvSURZT0hQVmpoVnk1ejlYWm8yTXAvTzBtTUQr?=
 =?utf-8?B?QlZTbW5IMy9nRmhlbzl0R2xYN3FYa3NYUm1CYmJnbm1zcjZSMURmQS9ZMXRk?=
 =?utf-8?B?OTRDZ1BUdU9sWDRkcklZUnVsbFlGWVczTnBrUnc0NzhJS0dEL3NVZlp1WDc3?=
 =?utf-8?B?SSticmJia01sbTRUTEJKZURlT3RwNkFadVJhZHpESU1FM05wZWxhY0orNFJ2?=
 =?utf-8?B?TXRaZUFoWjRLVTlCNUFSMHhIcGo0THN0L0JVd2tQOEZYVFcyQkFhWXM2RWJm?=
 =?utf-8?B?RzRmeVJVd3Y2Vm1ReDQyNTZUakxEbkI4dVJnY05MczZFMjYyU05KSnV2VWwz?=
 =?utf-8?B?TmJPUmdlRlRXdXJnT1ZocUt6WG9NTUlqRXlYRjYyZ0QybmRESExwMVlaMlV1?=
 =?utf-8?B?ZytJeVg5NnZZU1FsMGZjWmFhU1VFTWJPUGpxUTNPTVhpSkUwQXdjV3BwRis1?=
 =?utf-8?B?RkgwRDVTQjdGeHR3aEVNQlRIdkFrcDNaNmNCU2NzaFlZRm14cFFXdklxNlpn?=
 =?utf-8?B?Y1NjdTNjOGhSNHZENmVSVlBCVUkwZEF5a3pSRjdMWmc3bnlKYUxwZUdhWG1z?=
 =?utf-8?B?SkZhdmx3NW02SmthRW9aNkUvbWdYVlZLQU5CRW1xVjNzQ0RuUkwweXA2dVNP?=
 =?utf-8?B?UDNoU24ySUJ6MGZzZm94UnBWNUtHTUs4d0dDcHIzRFVqRHRhbVJuRDg2Y2lQ?=
 =?utf-8?B?aWkwbVFML01tbUw0dW1jQ1ZRa3c0WnBQUkhKQThoSWM4MHFLR05vSVJqMjdL?=
 =?utf-8?B?SkJTbjlsdFEzTUVwZlpkY0d3YnF0encyeUxlMitVaXBJWjhCczUzM1huNEpl?=
 =?utf-8?B?OHVwTFg2ZS9NZHpwSEtDeER4aFBsNUtTVmkvY3EyVGI0R3pGY3ZvOUdxWmpP?=
 =?utf-8?B?OVk0dnpac1JDU2lKRUUyZisxdVdFQldObnFmNW9pOWdpZDdHaWtFUGkwMkM3?=
 =?utf-8?B?L0NpN1JpZENzMFdFQUhWWk1JRDJuaHh6T2poQkFMY0wySUxpZ1p3V08zbGpj?=
 =?utf-8?B?ZUNreW5vU0dEc0l3TVMwd3l6Y1JucXZPMnRDZG5ZUlFuNUNGNm5KYS9vTlJQ?=
 =?utf-8?B?Z2pMZ00zWi8xYnFyK1lCMjErbVdIMEtLbXg2TENIaHpyYi9WSkF4NTZVNzl1?=
 =?utf-8?B?QlBlNmpvZWIvWGk3bWd2V1p3NkpHTmhmRVIwWjQxenk0SDc4eDU2eWJCbzRP?=
 =?utf-8?B?eTRzUHBnejNlVVl2SFZZcjE3KzFKeVN5YjRJZkZjOEdGUmV4TDNKUDQyT0dZ?=
 =?utf-8?B?YWwxenlndi9RaDlZNkhlbVVLbDlvTnNqZmFxbTFGbmlqbmtITGZaVzdQOWw4?=
 =?utf-8?B?UXpBU2pHcDVqNTFmc1VYMVFlbWFlcVB6Y0JHRk1UR2tiZmZjSEZYbHp0clE3?=
 =?utf-8?B?Q1F4Zm5wUTNGaGhrZkRHaEQwZ3B6MENyb1RSUmFtK0pzVU1WUHdCUG5jSEov?=
 =?utf-8?B?OXlmSUxpYnhFUXYwYVdjbVg4ZGorTzR0dXVjSmpPVFUyVWJ2OURwVG02VHcy?=
 =?utf-8?B?eEI2UGdHMk13cjNEZnRtaC9tajZIMWFJMkZteE1pYUpvWFhhWmI0YXFpTVlH?=
 =?utf-8?B?M0hmTGRTUzB5TUx0YlM1SllWM0o4eDZLTkVQOXQ4UWRMcytqaEIvSklNUm01?=
 =?utf-8?B?SEpRWUxxaGwvMG5qSkVkdXh6VER6YjhoNjBldGx2VUtNb3JkSjlMMGpwRjhE?=
 =?utf-8?B?MnEyblN5UTZzTm5seUdBWExXSDIwb1BiYVZKa2xET0tVY2d1OVNaam1FbTd5?=
 =?utf-8?B?L05rZXh0eUkwWFpNZlJqSVQwMEhsanNYcHJQUG9ZNk0rWjZqbGpVZStscmw5?=
 =?utf-8?Q?FdVe24HJx176emyJCS2BTBSJ8F6qrInX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCs2cm9vWGk5c0VvdFJOQTVwQTYwQzBYdFdFNGU0MEZEUTdEZzAreFROc1Bm?=
 =?utf-8?B?bmVOWFNsV3MxUUEwQVdQdit4MW9oYzdGK1lVUFdtRFh2WkJsY0NCRmUyaFY2?=
 =?utf-8?B?elJMWFNKUEhPRjBDdHhIeEg0MG1SVVNKdStJcms5MEhIS2VBeEp2OTVkKzQ2?=
 =?utf-8?B?cjVvL1YwUCs2cy9neDc1LzlRMERqNEt0ekUvODYvdU5vUEwwVmRNd0hNRWhm?=
 =?utf-8?B?TGVNeDlVUU54ZlMwRWNGRlk1UHRtQlk1MWtnMWZzOFp0c2dacHVtS3FiSXcy?=
 =?utf-8?B?aU9vQkFQekpwejd3TUgzeXlwdVNteitIUzNlWkJFN2R3MnNVcXdtcWRrN21i?=
 =?utf-8?B?aFFvangxTXg2akQrOWRXeUw2TjgraWVGZ1VzWDBNQk15eEhjS3hBQnBVbld0?=
 =?utf-8?B?d2UxOExsYldJTThPOThCanBsTHBPSDNlRW5WRjNjbUxvSW5peHlsbHVtRlVB?=
 =?utf-8?B?K2RBVGg4aUhLUWZ0YnhoMkF3Tm1LNWg3YVBsVVF2dVZnNTJvZ3JETWg1L051?=
 =?utf-8?B?RU8xQ2FvcVFuWXpDWUo5YWRkaDhSeGFRVGxqd2tlS2Z0NTVtbmhqaFAzSU93?=
 =?utf-8?B?RThTN0lkWnlkaTVIS0p2UGRlQ0IrTVliaVdnb3N4ZWw1eFNLS2ZWY0xPT2Ex?=
 =?utf-8?B?NHNyb21GK2svcXZ6cVpvTUdyakRxR0VwQzViSVUzSGliN1ZMYXRaQ1F2c0ov?=
 =?utf-8?B?L0RUZ1YvdnQvRTF2Ymd2bzJNaFVCK3ZtZEZmelVvU1lpU01XMG1JdTZWWmgx?=
 =?utf-8?B?a2M0UmxyWGVSbzZyT25oVVVvRDVCKzZRTlJPdVhGM0MxSzFPMkZtcDFjejhG?=
 =?utf-8?B?VW0wNnRPOFhSdVNVdEdQT0g0L1c3Q21yVG5yeXJRY2Y1R2NEbUdEZXZuaGx6?=
 =?utf-8?B?R1BZU1lOS0J4UmtpS09KSXdZWjZXN1hwZ1VjSktnRlVFcjVHREpRcFJSQWRh?=
 =?utf-8?B?SldndVE3R3I4Rk5kdGhVNHBWOTRQZUpoMEFkay9tejZVR3N3MVhZaDEwTXZy?=
 =?utf-8?B?NDM3aHVBTUZLcDF6SksvTVdNU1BmL1FKZVpWbmlHZHFlNzN1aEI1dDAwdHlx?=
 =?utf-8?B?emEza2dIUzl2OThmNExLc290cWR4SFY1NFNNVHB1V2IrMTJna1NBZ1NuQzVL?=
 =?utf-8?B?dTBVQW9NRU9DL1NiTmZ3Mm1WMytoR1lSRm4xLzEyZk92cEZEVzl5UVFhZ3cy?=
 =?utf-8?B?dUpwV2ZsNHdTemhGK2lSY080WTkxNkx2VG9pcnZKbmlRWWFjRUZRUmVud2M2?=
 =?utf-8?B?ODNrUWpzemU2dGVoSGVwb3JCN3U4TjRXZUQxRXNCMVhQTXNEYzR4VGZWdFFv?=
 =?utf-8?B?a1ZDLy9DbldUS3JjNHpYQlY3UHc1L282V0pxQmlzWW9rVndMKzErek81b2kw?=
 =?utf-8?B?MWxWOXZkY0xNMjhoNDBaWGZ3NGs1UkhQdUJINEdDNGVpQVVRVktoeHVrT3dt?=
 =?utf-8?B?VEVTUTZBMnZYVjRZTDIvTlZyUThzOEpEMG1tT0NidGgzakJMU0ZjN2x6bFRk?=
 =?utf-8?B?YXoxVEw4VjV3b3J3WVFTK0FKaVBsSWUxZXFCQ0xUcm9jeVVQOEZBK2ppNU04?=
 =?utf-8?B?ZmQ0NzFNc2NnenNmMDcxMFRHWTJscTlQbGUzTGpodmZUL2pXa2VEVWNFbTVx?=
 =?utf-8?B?ZTJFdy9QSDNYTG1HcU9hNXNPYlc4Vi9jTkdlVVZEejBjSkNKaHZ5SDRHaDhZ?=
 =?utf-8?B?eHp5bFZMc1YyeTltZGtLdWh0anJ6R1RsL0VPTGFTZy8zUi9nWU4vcENPcXFj?=
 =?utf-8?B?SytMUUtlWUpVeEliejRQTEwzaFdhWVg0QWxrQmJSU3A5TGFtY2RFMzN4VnRP?=
 =?utf-8?B?V2JsaElaMzY1NWN2YW1yOVNUcEdHczVmakZ4WnpTMWR2OG81aDAyQ1d6MXNM?=
 =?utf-8?B?UW1Ma09TMFIrTGZRY3I1MmNpblkzbVYwQlVXYUFKMC9vRVZwcHhnS21Jcm9U?=
 =?utf-8?B?dWhtUURCRThBWE1LVVMwYjVWUHh5NTNsU0dPMG93SDRHZHVpdTZodFR5aW5o?=
 =?utf-8?B?TG1KN0pKaXNqZUUrZ3p3cGVENkpUN3o4RkZHUi9ZM0hvVVJaMGZ2MFNvank4?=
 =?utf-8?B?TzFzcEo4ZS9zVnpucC8ybE8zOEJpbGpsK0VxZ0VZN0ZzVTc4d3hZd0NZNk03?=
 =?utf-8?B?c3l2Q2dDQUIwOTNmRXVwdDQ1NGlZYmFOeEluUzNxRXlKU3Q5MDBsL1piRGx4?=
 =?utf-8?B?STdpYWRnTmJKSHhCQ0FlM0tLRzB1UVhMdlZrd2hBQUI2WUdOZWkxWFpJakxD?=
 =?utf-8?B?enFBVkRzTTJRZzl4TE1MdHlpK3NRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TUnWKwj0lMjazt2arFUQthOq9aUd0qxnH37knMUwuf8vGMrtoUHooyBpxrpAVudGuPaVcHockAC6bv4cDpTrIMrlJe0SFYu+cTYqTzRU9sunCLDzPNVEV3IMcUAIpKw1r4jcu0ZTFfGqrTk1/HwbUgFKLzswM3bROgK0dveVjH27se3PjQHs78HZlFpshu7y5Gui11/W7t8iCB5yy9d9oYsmWVY/cIuPNHtgjvr6Mi7WhMj/zIis9UMylAMsFM5Y7C6JAe3bSm0g5Q1Idh1Ha5sn4RQhX/jKtlqSB0zsDMtjsKbVwzpi7naLLzqFjPMhpbl2Bp/UNJYSL3nvBqSzO6xj9z/Nvj2T0/lSMoFCH9mrbM2y2FnCOg3OS08RvxFavcGehKHLbSMEC/3L+893Z+OZCVWJfmTLEMivjcAvu+lGayaY2QQOsmzY3y49zDrqaF+ynpPXRM812p77X9NY8NdrHfEKQ5U0TG3jHSvIaaauCB/5Ds49mo7KHBrrB2NfjxhFzdK6AiLs5BkkOWMSLxRlmqXCpoFjqJ3kdvf/QZ7BrqNNQCVFZEgTrUAIxCIX0sHKXHLmdeCUZ40M2zaudrIqueiTfMVqvl6csxX5kCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8807d423-5358-4622-190a-08ddfc19ba6f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:55:59.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBMfwNOIwMeNxbMvBO4+QpKoV3FjAkB6kG1GuprA8N0mK6xp4Dl5ollgUE87YrNinIHscuEV6YKSw87baZf9rmRPwM2sfsiFQYb0F9jYvVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfXwEMK0n5tF0Ow
 2DVXbvBHaVvCSeVAyc2c7ZnC++iVviuiSYDTp3W/K9IW7ww5ELyMRQyHBcwjbLqzhwxRDLPWJe8
 Z8FYcr9ei2xbEF0u1z7yXp3M6SamDtjQSMPVNSipDVY6nB0FfBTNdVYvSfx+g7EQ8kBRZOkRh0w
 RKpYXhJ9gqxU65HFJKMxEphyGBlT0L09Bo3IkHTlCwQA766rAHstgR1f1S5d5fP9Yj5MvxucWKk
 ZtGKYcvaUQC0I24rzx5RZJuul2nBQdjBt1pwNwMSi/AuoDTO0GxzzgsI6t7hOsXcqITF6mdvv0e
 UV+w9VQj9jQh1MI0ikaQHI1RpznUE7Ektmfnp17GZYCwH7Vfldw8fyK3HU322zRlFaK2y92tLCF
 jwJrJFKm
X-Proofpoint-GUID: Cv7DteCgdi5RkK-l83ZJWojo1D3onY6F
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d511b2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=OIndoutni1OYuYBYa44A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Cv7DteCgdi5RkK-l83ZJWojo1D3onY6F


On 9/24/25 15:45, Peter Zijlstra wrote:
> Was properly fixed in the decoder with commit 4b626015e1bf ("x86/insn:
> Stop decoding i64 instructions in x86-64 mode at opcode")
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   tools/objtool/arch/x86/decode.c |    9 ---------
>   1 file changed, 9 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -189,15 +189,6 @@ int arch_decode_instruction(struct objto
>   	op2 = ins.opcode.bytes[1];
>   	op3 = ins.opcode.bytes[2];
>   
> -	/*
> -	 * XXX hack, decoder is buggered and thinks 0xea is 7 bytes long.
> -	 */
> -	if (op1 == 0xea) {
> -		insn->len = 1;
> -		insn->type = INSN_BUG;
> -		return 0;
> -	}
> -
>   	if (ins.rex_prefix.nbytes) {
>   		rex = ins.rex_prefix.bytes[0];
>   		rex_w = X86_REX_W(rex) >> 3;
> 
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


