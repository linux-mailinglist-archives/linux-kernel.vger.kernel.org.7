Return-Path: <linux-kernel+bounces-852420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B0BD8F15
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0EB192567B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3948302750;
	Tue, 14 Oct 2025 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jy7udbGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a9bWiWTM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E22FF145
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440154; cv=fail; b=e1znKScOhe4uOl1E1VuEFKXp/5anZeTMLOqdBAhATQbEHM64WGYYFT9/1y4wGe7BN/nSLfOq6JQH6M26PpfOrnvtaRKzZtVAPStMKsQ3NPtGE3VQFZuq7Y+xgeeJabroe/BYBxrDTl1bHAN7cnAfpLQ4f6Jzo58caDu868QL7tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440154; c=relaxed/simple;
	bh=5LL1dYmbtmz9v4et8VOFGCICSZKt8e/E2SYc3QblScw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jcfH+Wi7uc9tHTl/9b7sQztp79Tfjhg7qLGja5kb98iKVOS9PNZTnTNxzjzZK5k5OMkV3Etel44yr8cctpv9JsCd/rfIprxxs9kgNsHCOtZAMmRRHKWDvYjOm2WKiAguiY9gjJzQ+tJQOBIxDsqcr8EOfdUDmw8XZTnpVgy8wKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jy7udbGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a9bWiWTM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E9uJ1c009304;
	Tue, 14 Oct 2025 11:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=roSSVGdjy8sgIJajA0
	mvmmjSMsmXu3Tsd1CjE8+XMhk=; b=Jy7udbGQXWnbFMlTtzlSpS/75qcfxkqze7
	UI3goy88IUr1hPrFIKf4ihj/af8ThORpmoxolLqqxU3w2ClIzSXZRdA1WsYctMwR
	4SmFrYXdFdHsWG5haUnIWqh57dXSrN0UtTkDAwHqV5t3P6aQll9pCNMEufvduHog
	cnWyICArjORyvdb42UFaIETJZhYlnpG1U8UzT2lGrQq/aDCfSEMeQmWWh+CLOAJy
	mJnC2EIpZ/o160vsVSjBZCAfMialm+a9PtpL49XihZaE/XVwyZspLuOWDg4n4RFX
	nfIEl+8CzCqx7mn3PMobdmTA3HLzRNbfKwO/4U+W8ilJRLWK9Z6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrv1u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 11:08:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E97gKX037734;
	Tue, 14 Oct 2025 11:08:29 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8t8un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 11:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdNBET48qz7AY5TaRwCdvOx9jf796XzI7tb7nGyHWw6of5oneTerpUqb8gs80wLFnpGOQfDgoP8WR0HdTePD6sjwTy2UVVTOt0sjisojHaasaj5/+WuzHDrarTXb1yTMaddSq8q8uG01L0r+GqeZj2L9p8vBE7BkDv04EVysWnD6hHddjOSx7FjyZJYcoGwuSTqXHKtAyxTIWxGz1rR11Bny67Ez+BiL8pIDL7MQdsO7tsyePewKVDRUY040CZfb2X0sEmFV251RSJXr59xzXHkx1F4l/OYhnALloirBzpTzZD0UeD1SRAObKwsi5l85yuur5FzQ5vWYnuntLLfRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roSSVGdjy8sgIJajA0mvmmjSMsmXu3Tsd1CjE8+XMhk=;
 b=WbIszAgZHKipttzwY5xiHIuVux4WipPQIpZ07ABnykFtVxVXOso37CKBpw+dyvClMELrFwfAk/stI9CEs+KKgW3R7LItUKqIrxwJ79y+wz3HqeWArvdCBOB9oGq1rXKEDdkjYFhiL7dLCpqXSvaOPIageEoGaefvk0ZsRNQLpPz7DqNjFbJmFxHuHp/PElIYToRmdipadBBd5HlIXTN3cT5YIaJTknq5z7ZC+vj5vGb5m7+2S+fTLKtDDgNQRNucJx0yr/fZ4HlC5QUKWMmI7Z10JfEldMghLgEjM3cEI8W7ctEKF6onzfxtXweF/Nw4A+o+7nN0AiE3V3TZ3BUoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roSSVGdjy8sgIJajA0mvmmjSMsmXu3Tsd1CjE8+XMhk=;
 b=a9bWiWTM4eRBmgOFFFUveeiEVrCcTq9NsBNhSaUYDBeb/iJ5jP7lUQ6u/DhzqEsQZurMJR/1OElMwQay+HYLZ9H+w+4ZhCqFBfq61OsEz+TIzQ9mZKBvrUsqIxhs38KjD9H2fp9QtDKA2AVQHjrdhKG4CQAqhC/s/3EogbUyfYM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6209.namprd10.prod.outlook.com (2603:10b6:208:3bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 11:08:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:08:26 +0000
Date: Tue, 14 Oct 2025 12:08:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, Liam.Howlett@oracle.com,
        baohua@kernel.org, baolin.wang@linux.alibaba.com, dev.jain@arm.com,
        hughd@google.com, ioworker0@gmail.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
        npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
References: <20251008032657.72406-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008032657.72406-1-lance.yang@linux.dev>
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 50341284-d2f4-404d-b79d-08de0b11ffb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rv4huXWOpHZI101P3iwtQMyzYxo6YC6wHK7woGBw3vavrH/lJpli3cbDuc03?=
 =?us-ascii?Q?kGGhMsDa7LD38nZD6aIiToi/g315H4twRBAn7T3qZU3byC+QKDGHVj2fJI7Q?=
 =?us-ascii?Q?8Svd+iDTs8KzwwN4zW3z0ow8AOmbDPe/b2P2AC5ESxeoZ+WcsaHGcQIn+vs+?=
 =?us-ascii?Q?Q5RZWMh9Xvr51n0b7Qut3NnXfyTYWSJD3eRWPkEiQIAF4A/0OqJzdDeNqoh4?=
 =?us-ascii?Q?6Sdr2NfN925oqWUUTa9TzJa0Lxujd+M3n6FrMirkLRbI1KJb+/wMwQAD86hx?=
 =?us-ascii?Q?nBKr9dhBG9Y/iBa8yuaysqT8RzROgCCquj5S+h5kv8BAi0rWARVviFE27Dfx?=
 =?us-ascii?Q?968+H2rq/rMvNXgQgkQCIh+jD5iYcKlwxgtfO8tHZKKBzrceqNFT5iCMds/U?=
 =?us-ascii?Q?sh195f8ATzR85LEsEOVvefTG8feUtgzQ7H2BCMeMxDuZX8XudiEseDIHgLEf?=
 =?us-ascii?Q?5hfUqSpABRMWVWMss9TDd89JsY3AS6DGyEUmK3Dbyl/DR6R29W4L52ZWpuO5?=
 =?us-ascii?Q?E34LPLiriEHlWIyEtQZ+ItSm1820EYkSX/0QtwuP67aG3iPLmFwRha87CAiY?=
 =?us-ascii?Q?gwXurw7L2LIleRUCd3rgMixUFvNHLcv7wHvvCsl9hxBfNo6ffr7BvVSig1jI?=
 =?us-ascii?Q?eXlnwTLt1WX3MAFz9Dfq1i9mfL/w7vPOa+0lX6UkioBdzX4bFDPeh/SoFLTA?=
 =?us-ascii?Q?n4R6XyblNQw0iVj9C8eV3thJWmOgjzmy8wL/lpYojz+VlwyWZ/I0N+USgCuT?=
 =?us-ascii?Q?uNwmSU/f1/Dobz5MpbkFGEB1Do9ysK0IDZeSx2UAFTZsb1to0PgbgfpqFpSc?=
 =?us-ascii?Q?8RvrOv5NNspXYmFvvSOYICjcihOhW3U9GsqdTDQwWy50Nk6SMIn3/nYr2FrO?=
 =?us-ascii?Q?HydrwlVX00s+MTbZpOwzDAzBTZx3P3Zh0RA0S/2WcmD/JkIDUGuVts2kz8Bv?=
 =?us-ascii?Q?Aj9NDF+u8K/w9ka6lcdniyC+SGPOPHm4pwCkjeGqSt8n+d9sEKNZ4p4ZQSsA?=
 =?us-ascii?Q?KOHwUd010hvnz9GOhrLKZvg1WfBd26Tomr9+Vx5Y3FI5f963BJ2XmlaCYMH0?=
 =?us-ascii?Q?YB0YD8AhDj7pC/BfnsTMzdmhEYgzh/bQivgUVRNfssk5ndxEYe4bVMFmatp3?=
 =?us-ascii?Q?Z1vLFtFaffZk8tqvpFwJkBZevUE3McVPNF9Do3rnHCC9RTBR34fznOjUv7Ji?=
 =?us-ascii?Q?Z0AAL9op6uRVcJk5+BVbYvVskduKuon7S5ujbQ3uy8EAqk+OhCoLUDgWPW0X?=
 =?us-ascii?Q?fOFp7xg4I4TJsUo4Oov4DAs7NeWa7m/nQTODNyZpdvErNbIka6Km75gHbHR2?=
 =?us-ascii?Q?0QeRrOzDldTWv6VLHMpbGsyahl41GjcwXU27tzea6lsD+j/RQGzfg0L5CDmp?=
 =?us-ascii?Q?PKA6iK9+kv9McAKhHICo9XX8FOi8AvDGaiiBOJowFrj0oNX91mBHaRlNyt1j?=
 =?us-ascii?Q?OuroeA2XkOUITlOfBqwZGYTT58ae2Xwk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cq2DBZKXB0sgcJtxuir5q3FiusMxXlroE0Jin6OPHzDkefpCNZUF3pEtyDd8?=
 =?us-ascii?Q?2estD+yjGOJezoNrDHe++GQTdkglVEugogdatMQgMFDt3Vke+6Fuiefgbtxl?=
 =?us-ascii?Q?QXRU07BUbTMdg5liv2I4uS4ORgwH9mkyLzYggarDNTKAKl46fuLSrUzHbwa2?=
 =?us-ascii?Q?WPUCUhG3S1CQ3HWjZyIiF/YBXLk4ZHGjDOv6PhOvYnp2QP0dvs58eDq5OvMY?=
 =?us-ascii?Q?dT9LweOyUggx8M0gDD2QIbA3J+uCAG5nxtpEJNaCUw7WgXcynMFAc1FosCTm?=
 =?us-ascii?Q?CRKlwHv9w1VONN7VTrkoru5V8EUeScvMfPhutBBDHUn4NQSZzHX69tiboXWr?=
 =?us-ascii?Q?tL42qfpzJOT9O80GJoy83dso45MRxbPPNVhjex0wp3Hb25yPIf394MNdHoDq?=
 =?us-ascii?Q?s5PU6LPf8fswsRT8CVZPGrq3zNih81Q4KNSTivTLp2QG6Tlh59H4PPjpo9Sz?=
 =?us-ascii?Q?qIN6ziei1WKphxdstSUOpndRWd29oFwCU1MaDIrNx5cTjl9fDsOjR1fV6I6c?=
 =?us-ascii?Q?NtO53iDQR6W/gy4GetTxZepKIj+zYhc7iKdH9CHNssW4CZKIUKRgVur5CfY5?=
 =?us-ascii?Q?atjXBvPgPamncsPdBXfgUklsLQ+a0gh3kNxBnrG9BgW/+6gIERH0hd9/bQuF?=
 =?us-ascii?Q?Bd5IES8Kyv0bQavKbfyVyrZdBtU+U+XjV6Syy2PMOLSbWB7nzVCPCsaRU15c?=
 =?us-ascii?Q?8IYBGoYCRCuhpJ66G8MrCClh0U4Mqr2yIJTX1xJC7aGJ9nTuXef/1xkhdosv?=
 =?us-ascii?Q?v3gf4STW5pbNk8K3QEp/iay5uNo+682iiGuZiI8Xq90zYLcWKdGbLw1wH97Y?=
 =?us-ascii?Q?F9qlC5WN+JlnUfPhnaZvm1YZDMaL7Xzjdr4g3o0ix4tNtqTnW/SzlAwmcED5?=
 =?us-ascii?Q?G3qPKT7GqVNW4pnXkG8foc3L+h1ap4BZJDfOLo7406vFSIMMhBb0lGdZoMZS?=
 =?us-ascii?Q?6eE1rlTq6HxuMK7bNG3BHYwqTKh7Isc0Tx8pZ5lJb1jeKtj6SfpTJStRAJ/a?=
 =?us-ascii?Q?7m/s1yW+KTY6YLkS6XIJzEXgCFBFPvFos32+DBXXvDVj5+dYm6ws2F1ASo5x?=
 =?us-ascii?Q?IFzuYxfFbUfhZfjYm0Ki0PcTJVSb0zgRkZkvLm98rWFnVssouCMT/NG+J/P4?=
 =?us-ascii?Q?plUbqmzLd762+Pck9wYsGESBatvbMhrBpFJsU3xo3Zdx9WS+MG/mi1PhlLSb?=
 =?us-ascii?Q?wlgLbtfDl9h1DYTtGG3Yt90aCGPgaigeOYpcTtxbSD102iqLzptn2vxCzrBC?=
 =?us-ascii?Q?n+Xy5zEcZeoi1dvVAwe7Yv+REV8e7WX0HOP5Ge6xgxP2SjYjClj0rnEVhosY?=
 =?us-ascii?Q?wF+H4mrofHXaFeP+CeQaB4M01nd/3EIhKRYeS3cuOyDLc+rf7gtOnymmf8pz?=
 =?us-ascii?Q?jSKwX1ZZrZtQtht96uA7cuODaqXZTOWWWcVK7mJabRtPTZXMl9FJvv9gH+6g?=
 =?us-ascii?Q?+lfhIbvqyDhPz6XuxnaslfRofHp6wyEhq/E6a9NZ7by5JpARstICQZcIYi/C?=
 =?us-ascii?Q?Z/jIg0k98aiCztocP2yzV+p/OOZjv1fVEvKZtv+R3fIT8Yh0smO0wHBEl4k6?=
 =?us-ascii?Q?YQZ73axfFAa99EC3y/bUWuxsepR+WXkC/mR1u7ipVgmlPqt5C6EUAr4CcZaW?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gqjBZjdW5Rr5rtACwnweKKLK96EIuHtdF5nS5Mwk5lL1+ZCdSlMUryq56RwaZEV2IrkwiGrxp/tk/nMwo8WdO9Ol/qjPbqGFyuJprnuDkPdzA+1pt+bAzVKt50PrfJ78GSsmdiuRT6Fi8NP0dfdqdUB+bN/Fv0O+Q7hCzfo6kyl3eSk16lfxgZjN0qGJ5rAfpS/TOhwr3rwnoe8eQKUJwJ8KFVyqdPgrp3X06KxKsQNAzMBnqN2Yy0RI47wJ7ZPnau/pzjkMeNfiHCT/Mdnecs4jlXaSYJwJXI8Yfb2+3bqA+FExPc7aoTYpMjLGgUvpPCXiO4qzwTYxbufuzQFgCbSQTjNJrCs4/dU7cJyy1Pdd0a+CDWmbt3J7qiTTBFhizKn4Z73bIG3ex93tANTMs3M3xHkCvQ8DdaRrPES56zqTAr/HsT5yvm7eg9uiL2sZFLuKPT4p5t2KMqzZXipW8MtsJMoJkkFAykCRTLbuTlsFcwPvXRq97zNVTRiVrj2iR/bi7GhiQ8HAr15CQFkQYd6LrBW3GJHACyadBx8zUQ4ARyP3f+ooJ4o0Skp+WKRZClPqQpJxRg+LOVYbsRue85BDXs2IjBZ7kjPjX2GvgoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50341284-d2f4-404d-b79d-08de0b11ffb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:08:26.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yADIvnVXEFsLWMu8K2f7qrc7LPsrCtPr4ex/ANVzo2R8Gx4oRtTsDAAwbVOosaQL+hCQPsxfoOOlG9Omnss8MOT/S32VaJbNp4pLN9YF+u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140087
X-Proofpoint-GUID: izGI1L48sEp9MP5cHrexlkAwoFWy8bsU
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ee2f32 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hQx1I665hcG68W8KKEIA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX53QVoQizeroz
 ORxE6K7hvvzO1ImYKx0nu0zD5xtReq539ujsAPJ4EbEDYP3pVcevzXoPJfO/RaOzIplq0UD9U57
 1AsedQlD+v5eg6WUSsEP1avI5QnrZYO7pJlVu+ZXjQn6M7mOs4jL5CL4ZIMRsa+V+ASw+EVkw7P
 qIy/o99sto5Tk45t9oBKX6TNyyAmTzg47M4EeE6CwKVRDDm6ORzQTerSNM0YvgDQn7GhNKQjlqV
 sVbS9+4TJMcOAZoEY0wtwhwFJ4f7LBgsKtTKHdd3OZosWI8da90pFu/FRc7HjxL/QhBNt1bPrOL
 teWyqk7J6XWWNaw37VvH57HghPH7uS6yqsjJW8Tf5JWypB5S1OEUUw1pAe2RYjd9y/beC2g5MN+
 SseV0r9CiQkOmWupBrauxTxSBKyNZQ==
X-Proofpoint-ORIG-GUID: izGI1L48sEp9MP5cHrexlkAwoFWy8bsU

On Wed, Oct 08, 2025 at 11:26:57AM +0800, Lance Yang wrote:
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index abe54f0043c7..bec3e268dc76 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>  		if (!is_swap_pte(vmf.orig_pte))
>  			continue;
>
> +		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
> +			result = SCAN_PTE_NON_PRESENT;
> +			goto out;
> +		}

OK seems in line with what we were discussing before...

> +
>  		vmf.pte = pte;
>  		vmf.ptl = ptl;
>  		ret = do_swap_page(&vmf);
> @@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>  	     _pte++, addr += PAGE_SIZE) {
>  		pte_t pteval = ptep_get(_pte);
> -		if (is_swap_pte(pteval)) {
> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +			++none_or_zero;
> +			if (!userfaultfd_armed(vma) &&
> +			    (!cc->is_khugepaged ||
> +			     none_or_zero <= khugepaged_max_ptes_none)) {
> +				continue;
> +			} else {
> +				result = SCAN_EXCEED_NONE_PTE;
> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> +				goto out_unmap;
> +			}
> +		} else if (!pte_present(pteval)) {
> +			if (non_swap_entry(pte_to_swp_entry(pteval))) {

Hm but can't this be pte_protnone() at this stage (or something else)? And then
we're just assuming pte_to_swp_entry() is operating on a swap entry when it in
fact might not be?

Couldn't we end up with false positives here?

> +				result = SCAN_PTE_NON_PRESENT;
> +				goto out_unmap;
> +			}
> +
>  			++unmapped;
>  			if (!cc->is_khugepaged ||
>  			    unmapped <= khugepaged_max_ptes_swap) {
> @@ -1290,7 +1311,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  				 * enabled swap entries.  Please see
>  				 * comment below for pte_uffd_wp().
>  				 */
> -				if (pte_swp_uffd_wp_any(pteval)) {
> +				if (pte_swp_uffd_wp(pteval)) {

Again you're assuming it's a swap entry but you're not asserting this is a swap
entry in this branch?

Also an aside - I hate, hate, hate how this uffd wp stuff has infiltrated all
kinds of open-coded stuff. It's so gross (not your fault, just a general
comment...)

>  					result = SCAN_PTE_UFFD_WP;
>  					goto out_unmap;
>  				}
> @@ -1301,18 +1322,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  				goto out_unmap;
>  			}
>  		}
> -		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> -			++none_or_zero;
> -			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> -				continue;
> -			} else {
> -				result = SCAN_EXCEED_NONE_PTE;
> -				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
> -				goto out_unmap;
> -			}
> -		}
>  		if (pte_uffd_wp(pteval)) {
>  			/*
>  			 * Don't collapse the page if any of the small
> --
> 2.49.0
>

Cheers, Lorenzo

