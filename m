Return-Path: <linux-kernel+bounces-867988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 137BEC04126
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74E2435571A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424F2192F9;
	Fri, 24 Oct 2025 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcKwRdMj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JefBY7lw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74119E7D1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271452; cv=fail; b=RSAkzuRqLndMTrDJqutaFQiLli5gzpTUdDjwblyrDB0nnfyEh2Yee2h0FS2t3f1PB9zXsrOU+i/lOuNzny7552gYbC+UXClCqclCXXHtVmaNHFDkh3BDgTi/FnBgpVaN+uygYO1K2DAw4EimN/OGPwc3RF7vpHolPzHdbqP9QD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271452; c=relaxed/simple;
	bh=vzClBgVjyBIv71doNMhgu8wJgZj+xfpoLsK4ytUzzlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T4ut/U9rDw+ywy3u4if0XeM0u5fykZmWXNOPFalFuCF/ngxHx9EcQJH4r2AEfmG1uV17QmAx4fY/D0Ca5JZcQAZnAObcdgP5veeqKxQrpB6GuEcnvoQDqhzK/zJc6Q7GxbH1fmT+0iZLr4fx82NHxy5VLZJJ1TnHoShGNhwJGVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OcKwRdMj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JefBY7lw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NLNLho020091;
	Fri, 24 Oct 2025 02:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PLWgUZr7stp1KPspnd4fFHmePrppBgDXCA3V+CBDgpE=; b=
	OcKwRdMj1d4xWKJfPXrbUA8c+SdpCVu1eZoUO5/ymmri4udVHt0ZRkDEvtg2TI+0
	x/R7L/Z6SAQMqZ2LzL2c+JOQAOOfPtN91/BwyROhjdHNSlHYtk/mdGD5/zW3lMns
	tzvtXOy6F6fTenWt00Q0po5SHF79yYukE9FzEXkzUfSsNifAdIoywySL3wyxFThk
	9kauoVdNZ6iLmbf2PKfOSpD8TICdvaBkFRcWGdn5A4rcb839Yyp7IUTABmMHi3Zu
	eQIP1aA74wMhT4NWcVp3koUX/yWEonpQnoig6b8xDUi2zOyDkiWw0eN0YxFIr4QX
	tQkQpHsdRRL9+lOQ7vB1jQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcybtrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 02:03:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O1K9jv035599;
	Fri, 24 Oct 2025 02:03:40 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgbm1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 02:03:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK0jEJQSxhKvxGwPQ5yCZxkme27Q/Mligg4NVhGM63B9XoWoxnEx8vSEYvPVgbEWOznuRCA8WY9gzrtuX1Ig8xExwXguqnvU8HeR96YkKKbsmTHGwiEKqssGe9oOqqT2rlPi9ojnINKvSDQ2cci9ea6lGfd+pkTARks1ivTEvRxFBWbGc1HpY0dLiQ/0eNb2Y6r89tjNAvW4tJZ7Mfdcj6Y1gH+UEq/K/sw4RXmiKMp4vJy3Y6mGniFVXHM7DP7z9RyPx3ReQROM+5XodmKnUrIQb0gRehxMv/G8fuzulSdZfbn+csrHYpGFJ832+Albl9bdK6BcLC1VWKCL8Zm9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLWgUZr7stp1KPspnd4fFHmePrppBgDXCA3V+CBDgpE=;
 b=AIFZkIbj8QCBkeThIh+EH7Jc5HV7KdH7ER0RnNIaGgtmPpEzMzOWl9vHLK6pXfbeA/FV3Ud3N20vwuLTMOZiIxxEJk2+JK0skLUvSF9wbMD1EDEzTXOPeVKWvnt5Eq1lWzcxlJMogoSbsA8TkRz94vVvGL9tcUCkhi2hywQGc4QpOOtRJXopi2PUqb1BjMxZV+EeoG/qJukDxCv6L1eBUpEf9jGmldg8RCDmBFnRuoLFHI8lutCsAB9LjTNesYvjvpVsLA3rIpWi8tVAiDbI5R49D9CVjvqdr3vQtBMXeDDYXBkc0G58clqrecWxRk0C6WbGPIkrFD6UC6VrHewrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLWgUZr7stp1KPspnd4fFHmePrppBgDXCA3V+CBDgpE=;
 b=JefBY7lw4wuiDyyWDeR/Wha+2BznkKpUmo2fsxC//teQOCLnHAkkLepjumAY9hCXKaN4vFGNIoBY7WLzTKfYpOfZgeeRBW9umhF9tEw36VfIaa+OFUPkKQ55JpFp1oe9bDQapJBj3kYOfhEd6oE8IyWEAWuB3AoB1mZb7zIVuug=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:03:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:03:37 +0000
Date: Fri, 24 Oct 2025 11:03:29 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] slab: fix slab accounting imbalance due to
 defer_deactivate_slab()
Message-ID: <aPrecUasNUbEkLlS@hyeyoo>
References: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
 <CAADnVQJS_RUTnpCX5etS_qGD=jgHjtY_Mtc5GQqPwvyyTfghdg@mail.gmail.com>
 <aPrBp_vG_D-8qG_E@hyeyoo>
 <CAADnVQK+3GLbq4GjOYO0Q6vhURPyNyy70bZKUUwRpLuK-R8NAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK+3GLbq4GjOYO0Q6vhURPyNyy70bZKUUwRpLuK-R8NAA@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0217.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b413dc-1fb1-4ad8-2495-08de12a18b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnJYVGc2cnNOR0ZYWW5jOS84RUQwL0V6ZnZNM0R6V3JvcVJqS1BXcDU1L3U2?=
 =?utf-8?B?SnhlTnlOcG5MQ1g1MmhoMWJkckZUYkFGdnE1Z1hCY3J5ZEorZVlWTXdnQ25D?=
 =?utf-8?B?aHcwUmgycDFmQWZXRS9uUTViempjYTA1WGVINDhFUU4rVlNsNW0wNS9RSnJD?=
 =?utf-8?B?Z2VkRndTZ29icnNIUmZHQlFFWHBoQkhpcHR6VEN2OVc4Mnl6a0FXdXlKY1Az?=
 =?utf-8?B?WHZiQkhYdWVMZUw4NURSL3NLU1loUU5odndPN3c2eFpIRXFObktJUTB6U2J4?=
 =?utf-8?B?dlFNN3hudnd4M0Z6QVRscEZGZ0NEeDFQbnFhbXVOanRPTDIwTVE1WndLRTR6?=
 =?utf-8?B?bTJxWS9WT1RFUUpwa285dU1mWnh0bCt2eXJNMjBFSGVlQXBnanNnM0sxOTE5?=
 =?utf-8?B?K1VuVU85UDA3ZHhTSUNUQ3hSZlRwaTFKcitXUGRpaEZ3cVBzb1ZMeURGMmtm?=
 =?utf-8?B?N3BKS09xclFYMkRiMmIxd2hmcmlDaHZqQjdUUTZoNGtKczBOckJTY1BWNlBN?=
 =?utf-8?B?T2dlenNNdStNeXhCbk55N0IwWmxlcHdORWNVa2I5RW1aNnFUazdQVVR1T1BI?=
 =?utf-8?B?M3l3c2tuSTZoVFlqVm5zdHlGNnNFS2IraEtNY2p5TWNjVmJBa2I1L2tSK0hS?=
 =?utf-8?B?YzROdGt2MlphVExwMUZOTUlSeld4Mko4Q1M2RHlPa1V5SjEzK0FaYWtpUmpo?=
 =?utf-8?B?MmJGMHJBUnNxMGFpK1hEN0RtR2JBTllvemJtUWZPaEVHM0trdHFzc01wcDBB?=
 =?utf-8?B?UFN4bUIxTnVUUXQ4SmcybzRzSkNPM2lNc01mSFhpRzh6ODRxVitJTEhZaEor?=
 =?utf-8?B?ODFKclpyUE11WHJNckh3a1N4dFV3dmRkQ1VZcTZ6MjdRVmtFandyWmRsaTJl?=
 =?utf-8?B?dURaeU9UdHBQWElSRVN0dnEvdHRNNU14U1pLWnZuVG5NVkJLOVI4b0ZMOWhk?=
 =?utf-8?B?bGhxVWJmTWg2ejg2SDV6ZEpNVCt4SHNzUmxyeS9RdXJEdmZGK3RKcERFOXB3?=
 =?utf-8?B?Sjhsdlgwd0g0V0o2VGhuL09ub2had2syUTNza2VYZFduN3IwM1hjTkFKMThh?=
 =?utf-8?B?QU5uR2xuODhMTkZpWmhwNy81MkZ0ZnBwcDc0NnBHYW5RMFNyc21Wc1BLdXdL?=
 =?utf-8?B?eXllZlMybGlJVlEwSjBEYWxNVmpEeXZEQ09MQjhDSEV4TDY1WEZWbHNTNXh0?=
 =?utf-8?B?U1dMb25oMktZSFo3Y3VFUm5tZG1lR1JweERiYmpjU3Jzem5RTWJxbnhjdm1i?=
 =?utf-8?B?N3FQb0I3MC9IOTlnRlZLbUlqYjlUZmVpMVQ1RTUrYkJnaFdmbm5leGljMkpE?=
 =?utf-8?B?ZEpiOXcrQTJMNWsvTVQ4U0F3ZmN3VS8ydnI5THd0MitmNTR6R0VHVDNDWGNB?=
 =?utf-8?B?Z0JKR2l6eWNlTGFSUjBjcXFyUXJBd25iK0RVS1hjdllZcVR6bXdrUktzTklP?=
 =?utf-8?B?SWZWemhTeVltMjNaMlYwZ1lhTXM3T0RrN01Nd0s4RE5HMTN1aDJEeVY1dGVG?=
 =?utf-8?B?QnNUdFM0ZkZ1SUVKZkk5U0IyeEFnUTUrazI0QUdHbllKZHkvRU90aFBYekVx?=
 =?utf-8?B?MlV5OTRkeHNzZzNrZnVaY0pkRXV5R2lXVWQ2MGhzQnhaeHlUeDJCZnMzcU0x?=
 =?utf-8?B?dDF0YncxZkpxMmFlMFBEeXJYclJRS0RXTVFNVkJCSDF2S3dvS3NZZVd3SjU2?=
 =?utf-8?B?MlVPUHQ0TW9pT2hlTC82S200bWI2YnpCMWtDM2l5UUIyV09VU0E0UGtPN0V5?=
 =?utf-8?B?V0UzYURreUVGUHI4ZXlyLzczekJTR0JsdjZuaW1HdXBnVE5Ma21jRDlQSXJw?=
 =?utf-8?B?V1NDWm9IMTNMejh6Tlp2Q04xU0RaaWxjUTJodERaTnRpOS9PWEg5RCt1NGxV?=
 =?utf-8?B?aTdGYmdOQlpuNkRyb0hHZHFtdFZaaW9nRHlXbVFUV2l6cmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFNjZzJiWkFDalpDZFRsbEQ1QjRya3FBU1lPYVBzYy9ueE10WjN1U3hVdGta?=
 =?utf-8?B?THRrTVEvaWx1aHdZbjh0THNuRFBPM241cGZ6TExpb3lDUGh3WVBZaDZlelMx?=
 =?utf-8?B?YmRPQU1TQVl0SjU2RHpmTEZRakhzSjFTZUowOVRDaGM5dTdnQm9ZWjlSQmIz?=
 =?utf-8?B?S0ZCd29zNUxCR1FNKzlUL3V3S3g2VEsyVG01K1RZVjI1bTZaSCtRL3VzU0RM?=
 =?utf-8?B?ZUVKeXUzQXZEdG5xQUVBT1hhQTE4WjZoblZ2cU1RN1pFbUxpbC9lc0o4Tkcr?=
 =?utf-8?B?RE9VMGtyYUJOeW5rbmpvTWp0czlMcDhzSlV1c0EzQjBvUEtBRkZTNzdiVFFO?=
 =?utf-8?B?TWNqcjRidUFMTnlrbU1YNEgyVC9zVUs2Mitpdm9FUFhZTDlwYXFCZVl3bllo?=
 =?utf-8?B?Z3hkdlZxcURHWWVqbmpqRGp6ZkVUM252UERXZ3JZVjAvaktwTW9jd3NQaGZ3?=
 =?utf-8?B?UmZRTHllRWwyWWVBbm1WOG1PYU5JOEVYM2dqb3M4ZTFRai9lTzVPckhtSGYz?=
 =?utf-8?B?Njl5T0hPZ3REN1NnLzBEVWdUWmRUUVhPYUVpSUZ4SHQvWFFyOGZ3OWQ1eGQ4?=
 =?utf-8?B?QmdQZlhCQ3BSaWpSSm9sb3JYMjZzRmYxcE0vTHQvU3dOU1BiWG9DcUhyTXpG?=
 =?utf-8?B?Z2pVOU1yZ2k0ZUQ1MDV6amdSdzRhbHFodmVIb09ZbWNNc0VtaUNmNFBzZm80?=
 =?utf-8?B?c1FHbnRvbnBiQVJsc1Y1eEtOTU9HbGNHKzY5UVBLWVVDUmpEL0V1VzRKWTY5?=
 =?utf-8?B?bC9ManRVRGxWMVJ3MHdHRnVERjYzb1NEbGJ1TC9SNVdIdXVOL0gxU1ppQ3Y2?=
 =?utf-8?B?NTRBZ3ZmY3lLNnorbGpiM0tUbDY0ZjhWUXppRkUvOEx4R2dPbGVYcGV0NE1H?=
 =?utf-8?B?NXcxZjdFRUcyNDM2RmZEam41SjJjMWp5M1ExNjBmQkxaRnFaWDhyaUdLSzZn?=
 =?utf-8?B?MkFRc0JSaXYrKzBKWTBhdENXT2NYcjl5UmVZR1lSQit1V0dvRmNnMTRMWTRB?=
 =?utf-8?B?SThFeEE4Y3Rhc016a1pIUWlWQU56SkNlT2h4K2syQzNvYTI1VllVaHMzZTBR?=
 =?utf-8?B?aWJKZ3dRNDZGdjVjTFRFakhDUTh1T2hUczF3UWx4NnIwOTQxZUtNMHNkOUVZ?=
 =?utf-8?B?M29IWGtZR3Z4OS8xeW9rdlJhS0V0Z3hUWnBtcnJlN2FCS2lSVVJ4WitaZEFM?=
 =?utf-8?B?N3YwMElReGNrUk44eXE0bkdnekJSRzhWbWRnTGlnTWxCRzBYanpDWXJEZlE2?=
 =?utf-8?B?QTdQclptL2JabjRIbGI4QkdNZUdQbGpZRVZ5Q3dNMTYwZXkraUxUWXZpdXR5?=
 =?utf-8?B?VFVURlBQODZFcUNzL2o3Q0ZPNEV3RlJSaTF2enpvZXNVaEFnVjNWN0J0SCtk?=
 =?utf-8?B?Q2xrWkJndTlVMC81UWVHSFFmbkcySHloSWRIVWVwYnIrZTUydExybE5pN2VH?=
 =?utf-8?B?bjM5U2VBOHZWVVRIY0svdWZoSGtXK2NhVnpDRitqTkZBMXpSYm1jNmVDUEpO?=
 =?utf-8?B?MFN1VnJ0MTJqS2p6ZSszNXVRZC9STUNaY0tGcjJDZGJORDRlNEl1TUMrcU1V?=
 =?utf-8?B?bEQ3S2dnbmJvZllRdlRUaTE3czgwcjZUZFdqQkM5em5wUHZOY0VnTHZhVmNt?=
 =?utf-8?B?U0hOaVA1V2RCRG9hMUJYMFR6NTFMMGdiTVFMU2tsUDJockpDSVBXQ3lyNG5k?=
 =?utf-8?B?cnBOd3o4UGFud2o5VHFUT1JjY3oxRkhGUlN5TUJZUllHMEJ6RkxBbk9NbWR3?=
 =?utf-8?B?RTUwZVNEQWx2S1FIdjd4M3Zab2d0ZEJzSkUrd2VSQlhVRkx0Rzc5SHE4aDlU?=
 =?utf-8?B?Mks4UGlQZFg2TktRL1J3VHZHejU5eW5IUkVYRmxYQ2gyNlhPb1RpOTlHQTB6?=
 =?utf-8?B?ZHo0OVk1Y1hDcUlNRXdnMzBneml4bklPb1ZPL2d6bTJyR3dzNWJsZ2thbHdw?=
 =?utf-8?B?MXBId2NjWWJBK3ZkSEpHM0V5cm4zN1VHaWg5OFNoSXVJQjdFd3VNZUZWYVo4?=
 =?utf-8?B?bjhsV3lBc3NqV2xxKzU5Ync3REVOVWZoNWtuZHpqRXhqdGRrQ3gvY0grdmps?=
 =?utf-8?B?SXZVZSthTXhPRGplRU5jMXQzaFRwTlp2UFVRVkFTZDF0MldJaTJ6MStFSEM2?=
 =?utf-8?Q?94hs7MKRr7giGTJh7sdnTVYgY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UzKZwrSR9eSnG9hYIjErMx9bRmnLeF7dKCy7z0y7E88rihOD0hd0WHm4hw1tVtGm5Led0VPI3YwEVodjhdQr5nV8FFhi6y2HQbXt9aqzUWQivUlHU3FAfVyx3iefTloK95TGymFPZdQ1WVM5j0oq8pyFCkKbM2sETYT9IRUYkpOkG0Sj5Iw7BXb80CGQJ8ozf/Bf8qs8efglu5zakiaeOOMHwgUtYgzfaiCxayQCjEGKzXuLghn63jMMGe8kooP0hTYJs1HlTx7k9R6ukzkvAD7xdn2rYC3xI7bmxvq2ER+lu8llfTnnSjQj3P9omYAa6xpwfBYYn23ywUj1Vo94zsvrNCX/qFqBiMsT3YZ73oCsxLHKlFi1k5SO3TD7aFjcLUJmvsTyWYCwmKvB06VoBHNvKHP28FOkI2WUpuvPEhGdGb+C7Z92Mq8IJnR0alf8CdAgc7WzJZxJSFGSqq9mr3lqFmwk3PEQF/G5ZNbUInMFnaFMgSVSPtAJUNeIuWlKct7XaCR/V2ALOMjDvwITJSpnuCegKuzVPtQlCmv07FgRusZq8a8YuIIibBmtMB85AnNqsd1g/PnXrjb7/tHAc/wQACc6NrhySz1b8YvXivk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b413dc-1fb1-4ad8-2495-08de12a18b59
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:03:37.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unldJSSYdZ9qmjTCOVfzagCcJeCwxEpLPXZEvhISEX9I1K573eyJgbz1f4cGV4nYrMFJ9jkaghzgwYFww52WRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240016
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68fade7d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bC-a23v3AAAA:8 a=yPCof4ZbAAAA:8 a=E00fe8-wB-b1cTrhg9sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX0ioogGBZX48+
 CULicZGgvq5kAk//5iHiOS+/RKtQZv/Hr+kcefH45gHxf+uL8zRJ9Ax8DTEBhW6OWUFuPV0/2Sx
 1XVrvpHG8u0pV2rL+kBP0jayEFWvjBkLlU9s8Xas1Ponmbr/cz5BxcAmxX3mqf/bSh3cgvbnLEL
 /yLiGW7qL6D3YOczHjSidJmDTOUCWwTOSy0ZOXVD7tiMLgYfgqf0uP6b/WobuQRZ0j+VpfEYq/C
 Kr/VgR5RoQV7pSktbzayB/FuJM9TKrkAtaMWW2q5NKZO6jM6kuVeL2Cey26yRMQAhaeQgc0Nedc
 t0nvVsjn5KOP/KZyefwxzFlPuua7F1SQ9BQAMrkvQeYNyIWdUu1gR2owvYoQWjbFvR50ATgZdLR
 HAdMEBvKDO/RATbYelFD0/u6lTME2UGyMXN+c5wHelUrS32Ho3I=
X-Proofpoint-GUID: zb-saFg2kyjqehDGbUvPvZyePXTNxwM6
X-Proofpoint-ORIG-GUID: zb-saFg2kyjqehDGbUvPvZyePXTNxwM6

On Thu, Oct 23, 2025 at 06:17:19PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 23, 2025 at 5:00 PM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 04:13:37PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Oct 23, 2025 at 5:01 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > >
> > > > Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
> > > > kfree_nolock().") there's a possibility in alloc_single_from_new_slab()
> > > > that we discard the newly allocated slab if we can't spin and we fail to
> > > > trylock. As a result we don't perform inc_slabs_node() later in the
> > > > function. Instead we perform a deferred deactivate_slab() which can
> > > > either put the unacounted slab on partial list, or discard it
> > > > immediately while performing dec_slabs_node(). Either way will cause an
> > > > accounting imbalance.
> > > >
> > > > Fix this by not marking the slab as frozen, and using free_slab()
> > > > instead of deactivate_slab() for non-frozen slabs in
> > > > free_deferred_objects(). For CONFIG_SLUB_TINY, that's the only possible
> > > > case. By not using discard_slab() we avoid dec_slabs_node().
> > > >
> > > > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > > ---
> > > > Changes in v2:
> > > > - Fix the problem differently. Harry pointed out that we can't move
> > > >   inc_slabs_node() outside of list_lock protected regions as that would
> > > >   reintroduce issues fixed by commit c7323a5ad078
> > > > - Link to v1: https://patch.msgid.link/20251022-fix-slab-accounting-v1-1-27870ec363ce@suse.cz
> > > > ---
> > > >  mm/slub.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 23d8f54e9486..87a1d2f9de0d 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -3422,7 +3422,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
> > > >
> > > >         if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
> > > >                 /* Unlucky, discard newly allocated slab */
> > > > -               slab->frozen = 1;
> > > >                 defer_deactivate_slab(slab, NULL);
> > > >                 return NULL;
> > > >         }
> > > > @@ -6471,9 +6470,12 @@ static void free_deferred_objects(struct irq_work *work)
> > > >                 struct slab *slab = container_of(pos, struct slab, llnode);
> > > >
> > > >  #ifdef CONFIG_SLUB_TINY
> > > > -               discard_slab(slab->slab_cache, slab);
> > > > +               free_slab(slab->slab_cache, slab);
> > > >  #else
> > > > -               deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
> > > > +               if (slab->frozen)
> > > > +                       deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
> > > > +               else
> > > > +                       free_slab(slab->slab_cache, slab);
> > >
> > > A bit odd to use 'frozen' flag as such a signal.
> > > I guess I'm worried that truly !frozen slab can come here
> > > via ___slab_alloc() -> retry_load_slab: -> defer_deactivate_slab().
> > > And things will be much worse than just accounting.
> >
> > But the cpu slab must have been frozen before it's attached to
> > c->slab?
> 
> Is it?
> the path is
> c = slub_get_cpu_ptr(s->cpu_slab);
> if (unlikely(c->slab)) {
>    struct slab *flush_slab = c->slab;
>    defer_deactivate_slab(flush_slab, ...);
> 
> I don't see why it would be frozen.

Oh god. I was going to say the cpu slab is always frozen. It has been
true for very long time, but it seems it's not true after commit 90b1e56641
("mm/slub: directly load freelist from cpu partial slab in the likely case").

So I think you're right that a non-frozen slab can go through
free_slab() in free_deferred_objects()...

But fixing this should be simple. Add something like
freeze_and_get_freelist() and call it when SLUB take a slab from
per-cpu partial slab list?

> > > Maybe add
> > >   inc_slabs_node(s, nid, slab->objects);
> > > right before
> > >   defer_deactivate_slab(slab, NULL);
> > >   return NULL;
> > >
> > > I don't quite get why c7323a5ad078 is doing everything under n->list_lock.
> > > It's been 3 years since.
> >
> > When n->nr_slabs is inconsistent, validate_slab_node() might report an
> > error (false positive) when someone wrote '1' to
> > /sys/kernel/slab/<cache name>/validate
> 
> Ok. I see it now. It's the actual number of elements in n->full
> list needs to match n->nr_slabs.
> 
> But then how it's not broken already?
> I see that
> alloc_single_from_new_slab()
> unconditionally does inc_slabs_node(), but

It increments n->nr_slabs. It doesn't matter which list it's going to be
added to, because it's total number of slabs in that node.

> slab itself is added either to n->full or n->partial lists.

and then n->nr_partial is also incremented if it's added to n->partial.

> And validate_slab_node() should be complaining already.

The debug routine checks if:
- the number of slabs in n->partial == n->nr_partial
- the number of slabs in n->full + n->partial == n->nr_slabs

under n->list_lock. So it's not broken?

> Anyway, I'm not arguing. Just trying to understand.
> If you think the fix is fine, then go ahead.

-- 
Cheers,
Harry / Hyeonggon

