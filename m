Return-Path: <linux-kernel+bounces-830230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48DB991EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C231B21468
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4421D2DA75A;
	Wed, 24 Sep 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jkq2xNYw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gUr6HJsT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E42D879E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705977; cv=fail; b=DpVGyyMq/25mWJ8P7QgkrQZM+TsfcsbNo9RZZVi7nH9NoM1y/h1u/TkLg3MlUUMjsi338B72kQlvvQ5CXXQwXGbbsK3qWLMhnVGcquzgRlMWZf7UimoRpnI02KhSFEdjlUZLE1pC15IXdzLTBz4zsVepOXGzQpUXwwipfLTnGWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705977; c=relaxed/simple;
	bh=s284CDUziCEqoJdBqMv6I0XrvgwzrXkb/SYN1+tcT+k=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXqsEEBEU1MB7Ddtx2hdG5aCLDuQKDQ4/xgIIRhnca6SbprkaPVQqth7pcVi0wFugjVgembsCYRAC8CYVutM+9Nk8je1J/zLgWkOefmweQn9HzDvdJgYKf0EAIHKT6neospV/RKmQYyd8vdm+jFRaeRewUEsTuqe74hnZCayHbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jkq2xNYw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gUr6HJsT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MtUm020732;
	Wed, 24 Sep 2025 09:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lH9PP+XHcmJi+NV/eqNlN+OVx7wZXZ4FyIRDbCMkfgE=; b=
	Jkq2xNYwp9jlJLBDLMaedKEC/foWXNnfkbp4WUnGpiXob7tNJAS/2A/Z5ZvMJ8x0
	PdNPbLEyBpm0cDKsFYOIsWK0SDPK7CxmODL28U4llORpLw+Amc8EBAkbke1OxrCX
	DDD+DgjDanA5kqoqekMTxVBIJoiXMnwXhqwq9IeUT+hRfZlCkozODZDyqhyAwBzJ
	6UkAqzgsoCMHhcBovl3eYkFYJB235xrRRsdbc7Ht3Ay54cz3WyQJAzDUDg0LaaY8
	JrCMc6daGI8459I7r/VWVaDdcQMoZfvl9tcCmGwEa9AWx/C/E/4BdW2Y7L5mvbpc
	dQLslTVTRDZe+wM2P8jGKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6aya5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:25:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MsZF027698;
	Wed, 24 Sep 2025 09:25:40 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9pjpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 09:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpDqi8wSqI5H2MbWzGtXVY+IhAOGFiOhLquuul6/74o29Cp6V/rbuvdRLqAONw5G8IDCNQWtqnTi6By1f/WOICukDiK8ljevh0eTAPqVEVFFtqRCDb7JURJe3585xQ7wjRVWnGJiw4Adp9e+LcH2h7rXcYlBi8TmKkkEbcKN2X95mw224zSAN/3y2EfXw33pOZwTdpkUQPmxQ+aefPIeG0h4CF3hnf83n4GwGBQ0RHVsGeuiuycZ5xju8bsGeGsQtHGv14fOoqBJJwAIYjF1SXTJYx8VvPmjW/b47ch8LsE+uX2MLPgS1qHFJDkUT6InsLHR57Dj+3lNSWozfwZwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH9PP+XHcmJi+NV/eqNlN+OVx7wZXZ4FyIRDbCMkfgE=;
 b=sXvI/KtyCh6TxBDzjWH3x7fnSugkjAwcAup2IXvQczFV5D2scWhcx0mEdAN2Er7ljGHSFILBtHnAEW7rrIdQCVtbEhHzwBdUV2qW7gtR4N45vvimpSv6Tco7D/mHpgJ8S0lFKmZEo7WC+W8f9jG+pvG7ty8437qoXipnawMjroFgt49wPNc+7RvJntBP5CGHUb/dw+OM9Ec+jYht8PdVSxQ1l2x2LEldnrJk9bGGSXYRPOdfDPwUl3koj9A601fI7osVFdGuiBJiivX+Wlvs5GSXpvbOBNzuWgJRqnIMA0sFr5RJRnEtna0ySwETLuNkvPyjGf1dTA2/CkLXGhpVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH9PP+XHcmJi+NV/eqNlN+OVx7wZXZ4FyIRDbCMkfgE=;
 b=gUr6HJsTYBlauZPBWkD6cNPDpfvmMfyHmTLiCMGmdvWJ44HdhdHKA356XdMwHM7BtZgMTqw5MUa9fGnMTLt+dZ4IFQiD6Cggt1m0KsILGWk7zhPyZV2CTis0RT/0VF+mWFkjbfuqjMjZIzQChPY8AklfEyeSUdcLh5lIdRAoLPA=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:25:38 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:25:38 +0000
Message-ID: <e60c22fd-3e91-4a93-a90c-53cda227800d@oracle.com>
Date: Wed, 24 Sep 2025 11:25:35 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <jxvtccnmr35xtevd7kjd5tn4n4bpwvfo2baajidwv5yfsvqcvb@mj7t4zfpllm7>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <jxvtccnmr35xtevd7kjd5tn4n4bpwvfo2baajidwv5yfsvqcvb@mj7t4zfpllm7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::17) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|BN0PR10MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a7b744-077e-4c6f-0818-08ddfb4c52a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WURROUhZNEJ3dlczbzNwYTBmNG9LMzl3YTQzR1liM0IyRnd5a1JMd2RRNCti?=
 =?utf-8?B?OHN5RmdKL3pNc0JPa1o4MitNQ005MWdBTEdMSDU5NkVNbjU0cTlvbWg3amlU?=
 =?utf-8?B?NDZJTjNNN093N2xTc1dXZjFra2Q0ajhxRzMwMk9yN2xLcG1rWE9TTmpKOS9u?=
 =?utf-8?B?R3lPOE9pOCtiYUE5OWZ4ZE5lM2NkSFNhcTBWbGNpVUVYL01xbGMzNjVyYnN4?=
 =?utf-8?B?V25PdzBELzBMQktZMVhEUXIzc09JSVRsZFVuQmdSZTIyanFvcVBjUk50R0k1?=
 =?utf-8?B?cEd3ejNUU0tQWkVUTWhSU2xKRU5rSzBITEV5NGJqMVFwOVA3V0NlZ1hhOGEx?=
 =?utf-8?B?VUVGTXoxSmxJSlFiaDUxaC9ySXlMTmZtVUlTN3ZuV3RTWldlbnZNc2lZaEhj?=
 =?utf-8?B?QjEzZWxidldzMlJRbEs1SHRsNUFRbFEvZksxdDh4aDFNeXZleU05Q0UydlhM?=
 =?utf-8?B?RTJGeHZlRmpDeWt6MGNBWXFDSlFTTjRyTzhxbHdrbVRaL0xhZEFhRmVlajVm?=
 =?utf-8?B?T1d2MGNyS280QzA0d3Fqa0s1ODlpY0Q0QnZ1NmlSTE1uYWg5c2djTTRqRE5S?=
 =?utf-8?B?MERBT1JDNlhVRHp6bWtFVHFXVW96aW8zalNXQSs4V1ZESHVHb014eXJua2hR?=
 =?utf-8?B?bkg0cHZORm53c3F6MHFMT1d5T3V2STd5eUk5SnE4eithWHkwWVpleTF5RXB0?=
 =?utf-8?B?emI1RGd6LzFoaVFybkxIblFsWklmRjZDeExIRmtnMy9CUkRKeC9XTGNsNklz?=
 =?utf-8?B?RlpmM05vZHR0aVBOcWtmZXY1eEFaV0JzQUYyNm9UMkRwdXJrYm9xalNHUjBR?=
 =?utf-8?B?R284MStEVW9UeG1WSWtKeVdPOFRnZ21MVFJPT0E0a21jS05vM2grbVFzRFAy?=
 =?utf-8?B?K1F6V3F1dmM4bVZRdUltWWlRenlIZHpHWVlxRUYvREZSeThIMVJRTk1CTllx?=
 =?utf-8?B?U05ncDhGR3NNcllIMDFyZDF5Y2dTU1VNektLKzB1K0pwU1ZldUlocERmY202?=
 =?utf-8?B?MXR5bk5DU2pJSnJvbWZCY3MrVk1zemJ1dGlydzN2NTdMQUU4akY2NmF4ZHFS?=
 =?utf-8?B?UG5MVGZkOHh1cXFzUXZ4ZklhUDlhZmJpVVFDdnI1T2ZCR1VxYUpYblZ5U2lG?=
 =?utf-8?B?MXd1WkRYc29iaEpBK3VwRTMzT2UwNGFiRm5BcVo3TmtKOUIxdW81MG1OUnpZ?=
 =?utf-8?B?aERzQVF5em9ML0Z5ZEpnZUdhdjZ1NnR2dzY4enNLUDZIbzBPSlN5L1U2ckdY?=
 =?utf-8?B?UytaQitvYU9lcExHQkFYTVhCTzI2Njl2MGdLd2psM1pvWDdDbmlxYjdBZTd0?=
 =?utf-8?B?cHZsc3FnSDNJK01WMHpsbVE5RkZwU2FOTzdUekRweDlxQ0IvNzM2bEpBbWpB?=
 =?utf-8?B?K0RkZXFING53QVQ3WE5GS1J3aEVBUTJjdlRHUU4vMHZSNkdrVUxIaHUzTFUr?=
 =?utf-8?B?QlF6bXJzRGQvK0g0VG1qd3NWclQ3SWg3aUljdDNEaXcrWExaUUNRS2Y1aURO?=
 =?utf-8?B?SHZOS25hQUZrSXJlbHlpZktqdjMxNnRSMURxUTBJNzdYbDZhMEU2dGoxcEVw?=
 =?utf-8?B?OWhUeUpuVDRza2F3TEtZZ3ZKcytkTDFidHpVV0hsQUVtZGx3c0ljeHkvemVI?=
 =?utf-8?B?Q3Q0dDV0Q2NHMWllNDVIQnVCOTBTbVVtUkliVWRBd0ZxZjcvZTd0b3lxaVhL?=
 =?utf-8?B?Z1VjRU1DNHZtNU54SlA0cmhuSXJYTlVJaG1Qc3EwUnVTNFFMczQwL3doS3p3?=
 =?utf-8?B?MFM4RnkvMFFxek5zcEpDWnZwYXg3Z0ZNM3p3RWk0VnlEdkcwL09HSlJXdUU5?=
 =?utf-8?B?d01UNU44YWpmbWp2MmtrVUVCMXJuTGFmRitUN0FHT0VFcTFNcFIrTCtPTVRr?=
 =?utf-8?B?R1FRYlBwWkVZV2VId1h4Y2NNRGh0VW9GOGlQR0xLcXBra1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjYrR0hjbnc3dkhSMnpTNTJHaUdTemJOZm83TzVvUzcrVFo1MHg3Q0ljNldN?=
 =?utf-8?B?b0xwSFJlcmZSZHNVdjhCNnN2U2t4ODhuZTJkMEFXdWU4ekdrSU1SMEwxZTFl?=
 =?utf-8?B?ZzVYWmVPYkxxUWJYem9pRCtSVi93dGRBWGRzaG5EcDlZK29ZOVRsZHV0aUYx?=
 =?utf-8?B?b0NqTmIwbCtTRHRqcFpGd1ZUR2grRmhZMk9ST1k0N01pd3pyN0dWWTBlVjVJ?=
 =?utf-8?B?U3Y2UlA1QmptT1U3OW52Ui9pYnEwRzR2YUtBT25nbGYxSWhMMkI3TjEwSHFF?=
 =?utf-8?B?amhMb0hWK05WYkp5bWZwYkcyM1FqMk9jckx3TjYzOXl5YkYxN0dnd3MySjkx?=
 =?utf-8?B?RjhYaGxMaXNTZFBMcVBoYXc0VjF5SVZlbVBmbVhIRVNCQ3VVRi9DZDA3VnNH?=
 =?utf-8?B?TDROc2hkVTJzaUk5OFkzQmlaeUNCTElXaUdRT3BHZTRzaWd3SWZUQ0p0alVZ?=
 =?utf-8?B?NDZXZ28vMUVoN0F6Z3NDMTgycUoydHJ1UnRGOHMrd29hTzFILzNaL0d2c1Fx?=
 =?utf-8?B?blB0dG5LTHplTVdMOEN0ekhHWUJLbVcreHliZkxaUjNkQThxWGIvY0grQTdo?=
 =?utf-8?B?NXZiUm1taS9sSDlVVjR3Z3d6bFJZZ0N2bFBTZnZXUGo5dWRLSEhZUHNFZVBC?=
 =?utf-8?B?UGgrS2VKL3pTZlR4SXpnTHcvRlJEcDlIeWxrYnlkVHhkcG5TdnRIMEhnUDdk?=
 =?utf-8?B?VVRHS3hzK000NG9xYkVYZGtCeU5MOXJqYisrU2x2OFYyZm9rQ3hzRE43WEQw?=
 =?utf-8?B?Vm9vc1VkSEFkYVZXUFhEaVM3dFlhdUhxY3FXeUZnTDBLTE5VcWJST0t3RVps?=
 =?utf-8?B?K0tTNjI5Q1Fvc3JGWEt1Rjh1WVowazNOVHppUjBaa0hsVW1PWEwzQTJwYXJO?=
 =?utf-8?B?c1p3QVVxcVUvTjBqNzliRDVPa1oxTVZTbU1kNmQraVk0bWFyVXV3Snc2d0Yv?=
 =?utf-8?B?T2IwT1NzL3lzdzRrYWtoTVM5ZUQvdExEMk1VZFpiSDVzYXo3cXhXK0U5Z2RB?=
 =?utf-8?B?TlpLdGVHdlhlQ3cyMzhyNUgvRE9MdjdDZHM2b1lCUkl4L2JJbGhmVnNmYkZk?=
 =?utf-8?B?TEF3aEhLaDRCSEpESFZTVXVJT2dmRkVpQTJTUkNNeFc1a1Y3VmtGSjZHNTN4?=
 =?utf-8?B?dzhiYjJ4Z21BYkFlVmUwZjgzOG96dmpWMnhtYWhGTWJJcnpPS3hxaHQyNTQ2?=
 =?utf-8?B?eUhjbHM4TmwrWm5XMUl2WnJ1MTFYcTJnM2p2RHQ4TGR3NzBWRXJ3MkVrb1Qy?=
 =?utf-8?B?UU5FZVdmdFRhOG95TTVqZTIyVjdnK0tXSDIvRHR1MzFUeHpIYmphUEpBQTNQ?=
 =?utf-8?B?SUY3ejRHRHNMMDRVc3cyaFJyY1lLVlIreGZpeU53T21KQ2VSZlJDa2prbEdl?=
 =?utf-8?B?MTJsZ2ZDVC9QZzBscnhOWnA1Y3NJNkgydktZR1RhN053cUg2NzdwV1hqeFhQ?=
 =?utf-8?B?ditwTWF1SUVPb1NEZS9vYjRDb3RQUVhjQzN3YzZUQlY2eXhycEpIdk1aWXN4?=
 =?utf-8?B?d0dtVE9WNndmVi9hV2xiWXNNOEdwRWN4aGNRWllubHRBd3NCRkxPazYzRHZ5?=
 =?utf-8?B?cXVKT20xVHROdm42eUVVUTAxcmI4UDJ1RytHTEM3bElJNVZ5T0JLVG1adzJv?=
 =?utf-8?B?azlHN2cxb21TSWJpWU10cG1yeDBrMGtqWSt5T0dRM1FISisvN016ZXhhdkxs?=
 =?utf-8?B?ZXFxY2xob1lFaDg3RVcycDh1OGhDOXFtNS9yZ0psbzNBNXVwS3kxSi9TM2d1?=
 =?utf-8?B?c1NYVlVHTVZHNXFrZEk0SEoyNy80YysyampFVDUxNTFkWVVCM1JNTTBrZzFG?=
 =?utf-8?B?UitDeVV6VHl4VjE0TkhFVUFpM1Q2ZVYySUpnK1h1M1p5Z0Z1N1hsS0tKcWxE?=
 =?utf-8?B?ZDE4N095QTBmNExGQklYamZzNTQ2VEZJSnlWVVgyYnYrMng1NEhFa1hCNWR4?=
 =?utf-8?B?bHpCWHc2Qnp5MzhMS1VDSzVHMkV4aFRNT3JSeUUwN3BnNGQ1ZEdNcUxCUU9F?=
 =?utf-8?B?TWozcWJ1eWtxR1duN2txakJ0K0dhR1lCSXZCSVVRVm5zUjF5RkxVN0I0KzZ2?=
 =?utf-8?B?aHF0cWMrTTFXdFo4M20ydVZxME50cG1yMnowdXpJM3NqR24zRE5UdmV3VEpp?=
 =?utf-8?B?YzMzZWp1SU9HKzVJaXlhWFZQRm4wQzBCeE1MdjNRL3VsRXNQYnQzeFlGZTcw?=
 =?utf-8?B?eTh3alVtaEZPbHV6c3FRaUFyNDl2VU5kSjRDUnVwV3BFWjBEZURYazJtOFRG?=
 =?utf-8?B?dFVxSFJzUGlrSVFZeTdwRGRpdVVnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KIY7NmABaiT+SYJw4dAAGUpYD/12D6Ps7aUxkrqF6iOy0AGuPnIUeOnWSmHfq+PP2OqHm9iAxmaOCdQVCXOjM/YLBhPBTWXUHuB36vPkl1HXqYL448zj6Mu6yLI2hhejAgt0Yew/2ixAYWU7uuik3mgq8DVB3kHwhq2PTcC1pup4OjUn1nnfhWZn89PBGxRLlVVtKEum3XJI4Uhmr7hkQJI0lFjhRz90/QpP/jrK3p9nNUWH1N+7yYm9kd8F3S+STaIw+LYNLzXHeOllZe6Qq+YcATYplh/BTfX23fn+6yZxmizv6dXJnXcVmiO/6iOD7sbuW89ZaxSA4fl17uV6oc0sZdoUpetFhap2/dWKdGjchuUg4utcTWvX6Fbo1lA61sX3E8xOQuaoSmUm7XQGN/Ww3NaDdRufUbEujnCn/98HVUVjG/Dt09PvWFKVhi1Q1CDG7mJ3P2I7x86j8kc0wydQ9Jq8NAflOZbDHj0hnn+awczdZejHVMlULYOvVYRGGfXktAdVTXz20pomsbkDpkVNveR6CgwN8YNfOEyaW/PgDNQ/SbLyYUACVqqYtrVHd41rvmL8QX0maGzfuv/Lx3gw68NZK/l2rY5aMQcxut8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a7b744-077e-4c6f-0818-08ddfb4c52a1
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:25:38.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYl3K6ikAEduFEtZ43NLKWWESeCeSPoYqtzsLT6wMlOXECoOU602329F2S/8Qsana1+XWbmdMwHaj5CHNc599iocJesNSfp6/f0vscVxGiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfX6GXZjqIYE9GW
 M8XNJ2R78FwkKjZsjKUloq7Lybky90T1hF4Ow1OiRZDJI9KVpnpZ0bcuoj0+7BRhtbVyOIUX4Ta
 v3XS8drjRNcryHEreWMVHcPS9C2F/4P0j5yW/MIz0HtBkEWTKyoMdrn/Ts3IxErlrLuv6SGsBwl
 fPlxoQMfOuBbz/D1DXTp6XJ8G0sH2bnlQWaRcDjFPqBivFZp1IrXDI3feRpQLNDET7lkdhKmOU9
 ZSOSRzi8fkzmpyUHMtLTBu0NoO4ZHw+VVfSAjTqcNj6W/+/gObUnLJ58oxO1v9R9AsHBg88vhAv
 zzDe0CzSOr4DeKQlbXpy7H3va8G3i6EdbWXHyMDaA6lNpSVp5K1mavKAd3DDxBG+PsE42o2kao5
 4htwQGVi
X-Proofpoint-GUID: W8NaqqPb19SluMgSVjtTLtfBHe4Chnp_
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d3b915 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=32Eic0gj8lIV9VG1u2QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W8NaqqPb19SluMgSVjtTLtfBHe4Chnp_



On 9/24/25 00:33, Josh Poimboeuf wrote:
> On Thu, Jun 19, 2025 at 04:56:42PM +0200, Alexandre Chartre wrote:
>> Hi,
>>
>> Version v2 of this RFC addresses all comments from Josh and Peter,
>> in particular:
>>
>> - add --disas option to disassemble functions
>> - do not fail the build if libopcodes is not available. Instead objtool
>>    is then built without disassembly support. In that case, objtool prints
>>    a warning message if trying to use disassembly.
>>
>>    Example:
>>    $ ./tools/objtool/objtool --disas --link vmlinux.o
>>    vmlinux.o: warning: objtool: Rebuild with libopcodes for disassembly support
>>    
>> - remove dbuffer
>> - rename VTRACE* to TRACE*
>> - add trace.[ch] for trace-related functions and macros
> 
> Sorry for the delay... this is looking really good.  A few nits I saw
> when testing:
> 
> 1) With "make -s" I see
> 
>    Auto-detecting system features:
>    ...                                  libbfd: [ on  ]
>    ...                disassembler-init-styled: [ on  ]
> 
> but I'm thinking that should be completely silent?
> 
>
> 2) Also seeing an oddity with --trace:
> 
>    $ OBJTOOL_ARGS='--trace=shrink_node' make -s -j12 mm/vmscan.o
>    shrink_node: validation begin
>     12440:  shrink_node                                                 push   %rbp                                                -  - statecfa=rsp+16 rbp=(cfa-16) stack_size=16
>     12440:  shrink_node                                                 push   %rbp
>     12441:  shrink_node+0x1                                             mov    %rsp,%rbp                                           -  - statecfa=rbp+16
>     12441:  shrink_node+0x1                                             mov    %rsp,%rbp
> 
> For the instructions which have unwinding state changes, it's printing
> them twice.  Also the formatting looks a little off (two dashes;
> "statecfa").
> 

Thanks for all comments, I will address them and also resync the code.

alex.


