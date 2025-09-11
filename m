Return-Path: <linux-kernel+bounces-812559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B6B539C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3420189A5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA435CED5;
	Thu, 11 Sep 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKR6jUis";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cpP+ToBW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492ED32A3C3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609849; cv=fail; b=YuJ4c2xBxx2QuIJBpBSia3NCtaIMJwIPfVVKp/hoP3EsOUHE2VZdo+s+ijP9H6Bl40eqBK28zs4XtZyesQuW/dDOwVMR9RyRF09eWmrt2gzTnC5gcx9zzDP2ikOT8vYK810/A5E17qgltyJqlgKMUUpHzjeNipNpBBu3ciEaqD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609849; c=relaxed/simple;
	bh=zvbaVewxgylZtoVfkowdBwcyqHtzzWtjVn9yhY5bZSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ta3C+7zlA9DLV034yDEnh8KjZv9BfJadSfNujkdoYZAA9TWjkU+riBxLeNt5n7T6GJW1WOtIpKoQgctX1wvCAbyrMsX6+5qq75b5AmSefg+o7+Kdeull1zEV5Ps1REOEEQ0s/L3AXvqdJtduVD+9Ffe/3jH7oTRq5XXwdvCKDdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKR6jUis; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cpP+ToBW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFto2a006015;
	Thu, 11 Sep 2025 16:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fXszz9JiTr783qrCsXAaNr4B3fqvpsIWk3gbuClBbEo=; b=
	hKR6jUisRcm9gqOw0m11FN0kDzuLLv+SlTZ6TD12ZnXBFQR2BfYZLsr2E3RhOrtL
	mnqLtNcwIzmL6yz7e/CD3xiRFiTmy1imeJSY9czS1Kai0JKn5JasCVlAnMysV4D3
	HzMDDBfV+NBdGfuybOUmIzm6P3Zo6mNj2aCdyg3mANeQF9SWX14EqczRdJQ7A15z
	+Ot8HUV+OF8J3NsOX1lx4k/Uw3xRsYdl/hjT2jDWFBv9NUeh+snMqpUavLMDzKAc
	iZcX9INZdeEM60O3G8UV/tr3akbYKqiofPfzw/c+1g6EvHfZEHKVLfra0YngQBkq
	elMJ7WIX8nWVdwdq3H/yJA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxqby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:56:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGW7XG012872;
	Thu, 11 Sep 2025 16:56:42 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcw2dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB2pLkqM9NpYdyx7y097CJyxiSZnvvSB65xQTXRmwDqPxC0xNAWW0kuLLo7mo93aTz5nTjDUJflP13GmD5tx64FTVGVua5Dgp1MTdmGvVpo82FEL0D7SYT2T4mCNmyRLkEQcVko1vEIiWtMcU5/SK7xuAd64LTBvoJ895MJMrOD6sXZn7kgu48jYXL+/Rp51dIpy8ZYte4TfOwHJdZR41hbq4mMp1f/Rou6tq6A++SrvXNUk1dnicE6G2vpPaxTVYqykxfcdGtvn68hqJc42Qv+oEJNspMmo5H5KTMza9ptH0i/gHCGxMVOXj//pKllk2Hh0PmXp+8qQbj3KdkqzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXszz9JiTr783qrCsXAaNr4B3fqvpsIWk3gbuClBbEo=;
 b=xmLS8TyyIFsvUJNm+eHvBcYvvjBxkHmrg22Enjh+GlpSAIj/cNdryco+FgiovN7tzsj4/lTthnfDsvTbt+0WceCpqyJ7YdIPfuHVHGOMXdnYnWtpjoQR0TLrFpZkFi0Fq6pWNL8KpB+hy5kV1KYKXVQ8KMglqLE0umX7Xwc4VT9yozr/ZQGhgduZODGyezKDX+OiGt5zc0PIQGeckqwO4j++azWf2SgoIqLAu6kON15P1iyWx0vvKfJ1DOkTy3yux6+5wUhy4n+fvoKnRi4R6bdd43BFLsi0t0RTMjvbZPf4WD/6p0PZuXNqhdOt3tawWgKtskMeXurNUNdRNorfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXszz9JiTr783qrCsXAaNr4B3fqvpsIWk3gbuClBbEo=;
 b=cpP+ToBWXcs9k8QN1duuZVds1N341eNc2ZTOMxmlNUcQWTZjbChSqzZZV36mOXP5+BSF9j3KvRMFFdeSa8WApST80xr39qPpcs4P8XU2wGd3zS14A6KYNBp+l1fwIAmjwlGHKWxfaJ3uAeWxHR2SJT88oYC0KlxmIoiqClZqnVo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA3PR10MB8516.namprd10.prod.outlook.com (2603:10b6:208:57d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:56:34 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:56:34 +0000
Date: Thu, 11 Sep 2025 12:56:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 7/9] mm: Introduce unmap_desc struct to reduce
 function arguments
Message-ID: <aw6vbshqvskf6lwql354dc7xn4dh445uaadbqoydzai3rnbbc7@j2lm7ryywi4o>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, 
	baohua@kernel.org, chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-8-Liam.Howlett@oracle.com>
 <CAJuCfpG4D4ikZO1c8zN7HNgLTAco1ggk21rg9AUFwoztA95qSA@mail.gmail.com>
 <dfd8b8c6-d697-4032-be2a-569b9629c564@lucifer.local>
 <CAJuCfpGFXbSFnqQtikNq0RoMfc93cLLnqrApq8211H+FpZpJ1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpGFXbSFnqQtikNq0RoMfc93cLLnqrApq8211H+FpZpJ1Q@mail.gmail.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:303:b9::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA3PR10MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 38174564-edf2-4480-9181-08ddf1542a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGl4L013RzNpNk4rOVJiajlGbTcxNjdjSWtXdnFCR0ZGOGlScjVWazdLVGJo?=
 =?utf-8?B?RTZDZzRDd0JJclRvbUdUTGVRbFd1V1RCM0JqbkNjR3BIRE45MEJjK3ArT0l4?=
 =?utf-8?B?emVOVGYxKy9Ta3VPVmRVeDVGazN1dGRQdWxoOFRJcmc3cDhpaHNIa0pzUzRX?=
 =?utf-8?B?RnZGM3QrVjQvWTBWaVBMUXpwQTNPYmpjZ1hrQjc0emdUaHpiUWpkZTNwTXh6?=
 =?utf-8?B?Ym9YYXNRK1l4Q1I5ZzZhWlNLM0RDOG1aQ0Q2ekRhbkNmY1NoWDVhcXFGKzB0?=
 =?utf-8?B?OGNnNnRjT3lydnFNZEEzZTRaM3VmYkNhUVlOYzNsZDM2WWF0cHQvMCsrQ0tv?=
 =?utf-8?B?MVowZGIzSlhvdTZFQkZKQjJNc3pWY3B4dkhCS0hjMnNyUDZ3UXJNaVRpTVB6?=
 =?utf-8?B?aVFNNTVINjZkMWk3UGtsTjdnK1hUWlJObWc5bXRqTmg1UUFQMGRPdzZyWWtn?=
 =?utf-8?B?UUNJTUdlSEhXV1hoYVhRZ3FwVERJS3lOZDhtZDZTSTlOL1FJVDhCZXB6YStM?=
 =?utf-8?B?eGM1dFpkMDJjVTcyK25jWEZjQjdNTE1IZGpneGF5RS9KbVZ5WEtZd1JjWE96?=
 =?utf-8?B?dlF6bkZka0VaMUJSa2hFeXJJSzVPT1Fna0RUbzBGUUU1RWNoN0hOaDFJcllq?=
 =?utf-8?B?bFFPVFRWWGhWRFR5UUhBUVh3bS9kV2VYNzRrUjBXMlJRbXpKWGZpRXJrOTZ6?=
 =?utf-8?B?QVJZQ1V4UjdwbGVYVkxoTVJGcGs2V1p4YWh3b2wzaENGRlRIdkk2SGkzNlI4?=
 =?utf-8?B?eDg2ZVhPWTU4UkcwSjRtWEJNR21NK2FiYnM3LzlRdW5PVWNheWdlRGljU3Vt?=
 =?utf-8?B?K1lzZTBKR09oQVRnZ3Fha2xYYkJpaVpxNkZtellOTlFDVHNkd0gvREo2aGdK?=
 =?utf-8?B?OXY4ak1rYzMzdi9wamRlZUR4K284QWhYSUpvT0lUR2lrQ0pTZWtpMHNwWDZ2?=
 =?utf-8?B?ek5pOUNaaWdXZHZYcC8vL2FjcFhzTENVbVRuY09SdFIyWFB6UnNwYmJFb2Ex?=
 =?utf-8?B?TTBBNWI0bFhiTUhXbkRRaGVkMHAvVVpyVEp4RndmUFI0Ym1FeXpMMDJ5ZjIy?=
 =?utf-8?B?WnE3bEJORjJpM1lkc2dJSmlxa0FBVGJHanBxTVJCN0dYN3hEbHZSZlg4ODIv?=
 =?utf-8?B?L2gwQnZWNWJRZ2FGZFZBZmhKRks3NXpndlJwRVdycklIRzZLT2JJOE5ja0dr?=
 =?utf-8?B?TFdGaUFVZURiTW9YQ1ppRjNucE5DUHNUZzNHUWVhK0ZnVEFzMXptc0NnbEFz?=
 =?utf-8?B?b0M5MlJ6cmhVNnVtUkxuUU9QTHlsZmFqaWsxdExRREdLRXBBTE94RStPRG9X?=
 =?utf-8?B?aUNkeVVHYm1VQjFMcy8yYWs4YjFISTUvRzBZdkZYN1JCeXBOQTExdVRSQWYx?=
 =?utf-8?B?bUxxT1BMaSsxWG1oaG5HSTkrd2hwaXJPOFQxQXFpWE1seDRsRUdtc2hJRVVW?=
 =?utf-8?B?Tk4rSi94WHFSTEZXK2RhK0JnU2RkcEM3QVZYRkEwTi9SMUdSNDBkWGFVYXY5?=
 =?utf-8?B?VTFQRTRhUXRSQmk1RmMzSTF3SnhHT0VMajV1WnBBRUI1TSsvTzdPOFJGaGZ2?=
 =?utf-8?B?Uld6eXlqai9JL2VncFJ1V1RJOFluMzgyL2QwbGt3cVZPMFBwcnMvazV5ZDc0?=
 =?utf-8?B?U2JOcklwand3TWJWSk81bjFCeThueXhaWkNtdHRHRTN0dEM2SnZGWEFWQVFX?=
 =?utf-8?B?bGMramhJMlhTMDNxY09TZkRpVWlQdkt0RjkwcUs0MlNiU3hhdmFJZ2txSG1O?=
 =?utf-8?B?VkQ1VUdFdEZTWUhEV2NQK3hIYnN6RytDTlhVakxSTit2RzJMdWpIUVVMek9D?=
 =?utf-8?B?OHl3M0UwbUF4dm9wMlJVa3RMNXEwTWF5ZWxpRWYwTWlhUzhPNHZmMG9WTDkz?=
 =?utf-8?B?c3d3Ny9DUWd3dUZsc1ZOWTBxa3F4aVZxUENEOUE0OWw1OWgvWUxyYXhLV3RT?=
 =?utf-8?Q?MHMmnN7nWwo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNTbXlsQWdtNElBTElrUVl6bU5EaTRFWHVLVmZtaWJWRDgzSTNwbG5Wb1U4?=
 =?utf-8?B?RHo4U0pHRHJZSTc1UkhVMlNrVDZGWnJCWTd1YmtWdGlab3pTR1loc28rK1Rk?=
 =?utf-8?B?TnNDdFRQOWI1Y3Ivc1IvdEJWZmtFclJhVXJ6RjdkNFV3eUtMKzlvZmNabUNx?=
 =?utf-8?B?Z1NVSno4TEdQSm9NV1RIakJuem1DZTBVeWlzdlUyaFVESVJYeitMOWZkamla?=
 =?utf-8?B?Wi9kVzgwMDdlSzE1bENQVDRFWmJUR01uWmQrOUZoMzRtNEg1a1puQ1lXbDN2?=
 =?utf-8?B?WXh6UUE3blRrNTRFcThadzhQVnNzZTlVVmFHMUdSdjRJd1BrZkpnMzYvaWdj?=
 =?utf-8?B?Z1pwNHQzWHdMdTdTNjB5bC80WVdaclVkL2JSRW1IMDVnZTYrekIwNkM1bWw4?=
 =?utf-8?B?bTF6QTBUMXd6cG5NQVVKdkxLb3V3b0E4REFBQ1J2UmV4d3gvYkdIU0oxaVhm?=
 =?utf-8?B?ajJHeHJOcXA4enVsRitrRldmTmIwOTlZRllhV0lFSHhwY0RTa2Z0MEErYUtq?=
 =?utf-8?B?Ky9vSE5zeERZL201V21JNUhxN0FZWURqcXBQK3cwWldGVmRLMFo1T2VKUi9K?=
 =?utf-8?B?WEc1NkltM3NldVF3bERYS0hPUFVaTnR4T28wWG15ajh3Q3B1R1RXZWhnbHll?=
 =?utf-8?B?Q09vSTlpWVVYbEtiOWJka25KSVBid2VHbUxHUzlQRVBpTEpTMWhzblA5RTQ0?=
 =?utf-8?B?dUhrdUQ4ZVdHN1FpbHVRdXlLenFKMFJPRzBJSGs0c2lxUW10akMzenpqQ2RP?=
 =?utf-8?B?Qzc2OXk1Q1k4bysxeEJaSW0yZkZyclppL1N1U0lveWV3MlZPY0dhQThQN1JD?=
 =?utf-8?B?b2FONjJiSnFsQ29JdEFrSXIvK0dTd0EyVVZtMWZDaTB4VkQ5NVRwdU9iOG9X?=
 =?utf-8?B?bmJMTWlkY1ZyRS9xcUN4a29vaHpDUmg4TEE0c01nY1BDdE5seXNBMzdvbjJN?=
 =?utf-8?B?a3doNGVmcE12U0lFbWEvV3hCUkNIdXlOTzVHZmg4SjIzTis2SlBlWjFITVJt?=
 =?utf-8?B?V0pmMlZVN3QrckQxQXNiNnJUcmMvUmJMV2tjOC9sTWFFTDlWcVBiVkJJaUQz?=
 =?utf-8?B?ZUtId0hya3dQMHc1OWREYStLYjR2dkJ4RlY4dkhOSjRKWVBrTUtQNFM3bkpy?=
 =?utf-8?B?K0JMdStpam92S3B6WDIvQnBiRTRnU1BlTmFwNER5UmVxR3RUSkhSampra2RS?=
 =?utf-8?B?RVl5QWF3bm5ibTVLT0E1Y0VMRU1PSHFxS2hKbFRTWm5SYU9kUm11aiswQXJZ?=
 =?utf-8?B?aC9JTHVDdVZXeS9rZ3U3Vkh3WjNrSkRodDEvSEJuTGJOUk1qZ1pKVEc0dDUr?=
 =?utf-8?B?QXNoLzMzOVl2cFJISUlyblpEU1VDazZDS1haV0ZydHFvZHUyMXZnemJOZlRC?=
 =?utf-8?B?RjNWUlpMcjg1dWszcHljVGc0NzkrNmVBLzNXNkJQTG1BdkdLODE3Q0ZGd0RC?=
 =?utf-8?B?R0U2RWt0aEszdWs3MmJxci9TVDA4SjcrSi9jRm9LUlBONlBtWkU2YWxneC9W?=
 =?utf-8?B?emdEdC9YYWZJSThFZzhBbm1Lb3NrOGdJZWg5OTlzK0dPeTV4SStyTmFMTFpu?=
 =?utf-8?B?ckpZZHF2U2RhZFRUaUpkci9qdUpwU3MvZW1ML1V6TkcyZjZoRHhvWFpkRGNN?=
 =?utf-8?B?RnBXczVwelROY2pQVmIyYjQ1d1I1cmw1MnFOUVRQdXJQb1ExcnlHTS90R1RB?=
 =?utf-8?B?OG9PZm9JZWdLOFZWZ1lINmVQemgvMDVwZytOQlZPVUVGeWIrMndhLzJ1Zm1m?=
 =?utf-8?B?a0RwZkZ4UEZYZk11bm93ak5aZXJZd09zam9jMVhieGltOGxKaGNmOGFIRFdj?=
 =?utf-8?B?ZTVORGFxTGQ3cWJ5ZGtLdEVJanlsck5QWGs1Q1ZPaEY3SExqUTlnUU85Tjkv?=
 =?utf-8?B?cnNzWmcxZUo2LzIvaFJRR1orb1lmWEJvOVFtZ3Y3SVB3ZWtHT1lTbnN2RHVl?=
 =?utf-8?B?WmZZbW52YUlrcjJPbWlqQ3czakkzb1V6VHFLMHZ5d2N2MFRrcWRpQmpxNDVk?=
 =?utf-8?B?ci95RTZJVnZ0QWYxNHluZkhLUFRSUUFjZTZYYi9scXRrNEN3TENPaEpiMXl0?=
 =?utf-8?B?bTNRbVE2K0UzQlkxZEJnbExPc0JiQkcyRzljbktyUCtqZEpqTm5odXFDZHI3?=
 =?utf-8?Q?T1D2Zi8B6IzV8sf1x63aFRukk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FpQwQ/XX9V3xTkDj9DjMDoU0W/HyP8k5QMfZcjsxI68kKFoLeYHLzuI98pKLbBwOOO/8Z58X15VGnP78YTIE7RBG8YJkH5BT9TpFZvqP3aHqTTrpoGnTj1+Dehya1U7wnpuvSrc4kvBG+Z+CESVCPpb2BMpRozBDL8v069hVVgl87AbOYKjHBmfhyL54TWDvxeieFphswMJLrJ3fgIyXzvj+Ebxvw4VOtC+xer4WyURp2NPIDUCOmn8BXhbkMYVSF2Baut8SiDGssLIkqZeLX/PWRVE7WDI1/g25tOiX6YDApeMaKDXL+UYNFhagGnYr3Q44JL9p5FVb8fZqgSJP4J6tsetoWKd4hxg8CB/N/u/EAqcjQhX+TyBaoAUEGzLsuyYGuVGFRt2WXv7KrJdu2wvQapRR1xBWzZWHtFqB9H4k8tzVrCFzs/NKL+KKiRuiYkuhqVdbVZV8pmjGdeeV4Kvgtp3dQlSmjwPFqxWjzjmrJW/oTOG8gK0o8NRBkwVqfEwMLMTWZ57+JkhD2s8zD/PRMMWU8wDGUgELRDNTKsGILH3F+jEXfCJZiwQ+uDJVRNFze76LGt4ZdlQrKJCIgiZXq1p86GzofOi6S6E+Sg4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38174564-edf2-4480-9181-08ddf1542a2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:56:34.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dyCNxQGB3bpxmosFU9zFISXULAlgwpv9U7Hb2jFhSmJkdzu5vI6nGOc9zrszNKFDXoCRXTW06vSYewYyXaN4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110151
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c2ff4b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=EAlW-bju04SoOorWpwoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XXMr5IOq-NE64knmaV9nSrah0r3ykZrK
X-Proofpoint-GUID: XXMr5IOq-NE64knmaV9nSrah0r3ykZrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX4BMzGMtVTLm5
 nG43BOvs13rWBxI0wWwRB333NXPkKmY0zCEHG3KpM/9mAd/bdmEk59hu6Z54z42kIIw3XS7oGhF
 uQdCffEC/JydP/ECOoyO4TTaF/kS8ERpSU3tK7YHpX6X4QtBNiCMpJAjThJmcOo6t6jfsyvMRlz
 eT+iZnBsAAAT+hVKF9SUG1zOoT+aRtLTYGvSxiki18KN0m/s4dBJMCltETPpQq/El6KJrxTl4Yx
 rS1xy8KEH3lWFIhzX8axQ2dmFG8RPfaLXTTH69austyhIHi3+bx+BNJTpiOAs8ire9Y9ylkaLZh
 aOR+hd/8pHJdDgP9/QYRr93fjThfm8rcdrSt9pJDaJ8UrN73LSfCK7TjU6MXn1CRg7sJZVrJAum
 Gl5FnW4d

* Suren Baghdasaryan <surenb@google.com> [250911 12:51]:
> On Thu, Sep 11, 2025 at 2:22=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Sep 09, 2025 at 02:44:05PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Sep 9, 2025 at 12:11=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > > +struct unmap_desc {
> > > > +       struct  ma_state *mas;        /* the maple state point to t=
he first vma */
> > > > +       struct vm_area_struct *first; /* The first vma */
> > > > +       unsigned long first_pgaddr;   /* The first pagetable addres=
s to free */
> > > > +       unsigned long last_pgaddr;    /* The last pagetable address=
 to free */
> > > > +       unsigned long vma_min;        /* The min vma address */
> > > > +       unsigned long vma_max;        /* The max vma address */
> > > > +       unsigned long tree_max;       /* Maximum for the vma tree s=
earch */
> > > > +       unsigned long tree_reset;     /* Where to reset the vma tre=
e walk */
> > > > +       bool mm_wr_locked;            /* If the mmap write lock is =
held */
> > > > +};
> > > > +
> > > > +#define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev, =
_next)      \
> > >
> > > Maybe DEFINE_UNMAP_REGION() similar to DEFINE_PER_CPU() or DEFINE_SPI=
NLOCK()?
> >
> > Look at MMAP_STATE(), VMG_MMAP_STATE() for precedent in vma.c
>=20
> Yeah but UNMAP_REGION() sounds like an action while MMAP_STATE(),
> VMG_MMAP_STATE() do not. Anyway, whatever works I guess.

Is UNMAP_STATE() okay?

