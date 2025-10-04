Return-Path: <linux-kernel+bounces-842029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6FFBB8CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD112189E4E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5DE26E719;
	Sat,  4 Oct 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXG56Lfk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R0zXY76l"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8F1DE8BB;
	Sat,  4 Oct 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578211; cv=fail; b=CeBJjJp21OErNXnpeOncmzA1LQn8rUSBeTuODOSo9q5zjZBvjPcKaePCOWxuIxzpDTfS3nYn97FQtE17sZQ+m1wjHxa17C9r0autm97z/5nIrh61mLEe+itCWMOyhqchRwY2PnJx9bdZH1fzQwez9kX4DsWE97nOuP3+cjSbJUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578211; c=relaxed/simple;
	bh=bg362xnz+CzOeKaoIjIWBZgRO/UOBgzrAPG4p+cUSoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ry8B3sHWRfJiYioSjc52coOOxSIzWjrcxHJWdvUr4RqYbBFaeO7FHhsIsJ2PpLJg8/vk/dRD3Bc9gOprHrDiHhqFXHjlJJ0M0E278aYc/5vTeUj1WoJ/yRtapsyALdo0VV2RYjhgztDrwcB1LErTvcja0ub+LyjK4I9Uz6vZwrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZXG56Lfk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R0zXY76l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 594BTRvu001136;
	Sat, 4 Oct 2025 11:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FaLpjhxanfcNbzXtpyKDK3u2vkP/s2uad5/PYbF4WRE=; b=
	ZXG56Lfkq7nNdEyM1XPJHP0B461sN8YseI13df7DjsKet9o0ZTy23idz8RdI1rgq
	xvHDiuPG2vo2L6jhSMFVgcTofllbX+RFWuSPn/oKtDc8yB0M7jwEOJ2Xf2X7+uw+
	P5cozajzq70H3OQe8LUqI5oXbcXfUpAqs2+ZqtlclemMElfSWTBNB89PMTkuTxtP
	aaLjfauwLVJmnsUU7I/kVzcR3BOny57WNcri6NyHTbw3GQO/qwUHtf0VuuQlutH5
	LkWjbzAY1EUkSxG/eYqySBCawiZrJIp4ktqlZBIdKCTLGjWLudtuSbtELW1rZ9z5
	1+nSA0TECkAfrfYIEFCKJw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49k2rh8082-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 11:43:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 594719eP001769;
	Sat, 4 Oct 2025 11:43:16 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt15h77t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 11:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg1u0xcFCmy/lGp9FJPlE4L0cHEuJ4jtYfHEgXQ3uTa1Os9DcMw/xKHHS04SjrUaUXVInzUIKfg522XmY27GEUXFpsB2ccUrbNlJM71mmgUrQNXeEN9owwe7FSJriZbz7lgxUuMCEn7q19AWH/vpe98tK9olxjCnxxB7vMaR/NtV1f83r9wCtLIR128ZxkT+baOVWW8R/OA4h6szXTm5vwUk44PCMF+GMZ33+exvISTZ2G/FnLNnQfE8zK/BLt/vb5KRpJDSEzi6BTQgrCbHm1p6rPaSU2c/hWIxO2IaKcl85iifwIznFxY9LHN07V8sFM3gb1hZrM2G8fIpsLSV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaLpjhxanfcNbzXtpyKDK3u2vkP/s2uad5/PYbF4WRE=;
 b=b+HFxOq0Ovb2e/Ox+edIM5KP2YuS6Og2WIMyhAoazWY4AEKi9Y1vf9xiWVgMXrODGM+pVXLzMd1u/lHCMgCC1RDnFyoGlntJlq5xNVcg2gTq4GThWpgO4tPdpMk4iQCj9oDE65qi3ZGQnEb8rAkWiyw9E9tQHEIeY+t9OdoYSI8syxkOmROkw9qxgCWLPJ7WS7AqNaEeez8tABULM+l05eFEEbNMJEO85sSvKK0o+SmUr6bRD7IRTO/wAT4zG0/rLuEn0OI2cxhbeFBoOQxW4jWrD+jNFKPwJcRuk1Au/j/iCa4twkUPt/Q7HVoN7ZK7t6fH3PxOLSXeEqFsIzgVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaLpjhxanfcNbzXtpyKDK3u2vkP/s2uad5/PYbF4WRE=;
 b=R0zXY76lOymmHhm3KvKFgw+YxVGaFiHZH+QYYOj6NGkDn8y4pbqFTwwm7jjPAUziXPkZHg7apOOE7W4V9p2JGpzMZV6C/x6pS/meZXhy/WhxXQWPJx8NryVckKbJMezU153nuH92c2WjAPLSr2I6NTRK1m4AHobo1Kbqg4IdOWo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPFD379E651F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sat, 4 Oct
 2025 11:42:51 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 11:42:49 +0000
Message-ID: <86282444-f489-49e8-892f-46ce655030b5@oracle.com>
Date: Sat, 4 Oct 2025 17:12:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v12 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Luke D . Jones" <luke@ljones.dev>,
        Derek John Clark <derekjohn.clark@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
 <20251003185520.1083875-9-benato.denis96@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251003185520.1083875-9-benato.denis96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPFD379E651F:EE_
X-MS-Office365-Filtering-Correlation-Id: 1889e4f1-5aba-411b-93a9-08de033b2513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3A4U2tJUndWNjJPWG5MelNCQi95M0J1anJxRVUrVjF5d2Y1bXd5eXVRdEgv?=
 =?utf-8?B?aG8wTUQzY2ZnTHVsbGhoUlV6M3hqUjRROXZFc1pPWWllT00rZFM4d0d5MVBi?=
 =?utf-8?B?ZnAwVDdUaC9vMXh4RnAzQ2xWRXRtTHR2bjMzS01ZdkthbVNMd0M1OGVvSFN6?=
 =?utf-8?B?c2dkSnNQb1RZQlZ1V2ZYdmNsaWFMRXlENWRXWjl3YXlyMmh3VnRRSzkrbWRD?=
 =?utf-8?B?K2xJUW1Gako0dmJvaWtvTDREYWRSWVNXNGpmZGJzY1ZQNGpLNzNxelhIbGY4?=
 =?utf-8?B?NUJDVjB5czlXKzJ6enQzWWNuT040YU5WeXgza0hxL1U4ZGhBQWluODNCbEQw?=
 =?utf-8?B?NnJtR1ZyTk84THR1TFI2VjJsSHh1OGRkZlFzZytDU1ZkZThrdkxYZnErRkpx?=
 =?utf-8?B?bW9ZeG1IN0l3WVVBdGdaQTJ6ajA2Nm5QZWhJWWgwczZpVFdoZTR6a0FqSkFT?=
 =?utf-8?B?b0pldVJrOUFCajlwMVhobkxXTzRIS2tRaHV5cFhiS2drZDJWejFDeC9SUmx1?=
 =?utf-8?B?c1YvWkh5N1A3b291czU0bWtDWStoYkpYMWtCaDBwRERYK0ozNHQvc21UY0pl?=
 =?utf-8?B?Tzl2cklrRUhNaXN2cFFHMURjemt4R1k4MWVLNm9kVUZjZUwycHVFRG1qRU0w?=
 =?utf-8?B?ZFE3QjR6NG9MMjhkaEtvdXJDaWFBT1A0QVVneFNBZTJvc1BMZjRqc0lkVTg2?=
 =?utf-8?B?NlVwY29pRWptbTNMZEdzRW5KcjcvU1RsTWdtM0l6VERkVERBelBtTlF0aEdZ?=
 =?utf-8?B?aWdoZCtkNloyOGJmSWkwV2Fqa3ZiQ2VzKzdnZzNvaE9VdWVPa3p1ZEpMb3Bx?=
 =?utf-8?B?TkVmT3MwbEdVOHJuYjlnZW0xT1E0bWhOSDkzUjErME9LQWxsVnV5L2dId3Fn?=
 =?utf-8?B?aUpJc3ltc3hXMFJnTi9tMW1qM0FaM0ZFemtjVm5tMXBDaWlXbFpvNnA1b3FJ?=
 =?utf-8?B?dEpDTWs1VnBVNkk1ZXJaVndkTFJRd1Y2TUN1d2tkMTNrTWdwdWY3ZWdCcFdk?=
 =?utf-8?B?V2tyVGJOSkFIWlJnblVocjFraWloSmRkNmhlRlpqaFlJRWtHUGxYUzBpTEV0?=
 =?utf-8?B?bGRodUhtZWwzZnk5bDNJWkVSSmNFUFFSNDdnam9HaHYxSmwwSjBEWWlSQVJJ?=
 =?utf-8?B?VWhIcVVNckpQVCtJQXFnRklVbXQyWWovQ2Y3aEk2QlZ1TG9xUFRWbitzWElL?=
 =?utf-8?B?QkNFTHdPWS9HaFlLM0NzSGlncTZqd3k3eTc1QlNscCtvclcwQ21yY3NhaWZv?=
 =?utf-8?B?SkhhVVgxNDZJRG1YVndycEg3My9DTk9Iem0vUHNST2tWMURYWThhTnBCL01V?=
 =?utf-8?B?aThrVHphVC9EZDl0WWpBNDAzQlcxZFdTMVNqOTdBeTMvWWFQZFVxWi92L0tq?=
 =?utf-8?B?N0tDc29JQ0Mwa0tndCtJbFk5ZmVRRWVDbGlhSGpCb0xsa2FYcXR5bE1hZzdN?=
 =?utf-8?B?Zk1hSnhRRVhkUCtxaHY5a0hBWXdBR0hCUVhEMnR3bEZtbmVyWTNtL3B5Rm81?=
 =?utf-8?B?Sk43T2FoSkhDcE8vaHgycU5zWTFVWjhZUlA5MFlkY2NVaWR1YWZ1TDVCdmtF?=
 =?utf-8?B?MUdEb0U5TDdSSCtwYXN4OWliUDR3NVprbWNaRmZxMzR6RGlFdW5zdnJJZTFF?=
 =?utf-8?B?Vkd0LzNTajFkZEs5YTlEcUV4bkFQQ3NTaXdRbGI0UmtKbGZwTEljV202bXEx?=
 =?utf-8?B?ZzJWZThzSENZQ3pMZnJwU0VPbXphQVIxWm5rVThrRGs2NDJHU1NJcldaVFRQ?=
 =?utf-8?B?YUZINEZCK1AzRmtzSFFMNG51N3ZMSDdTNnh6dXMydThhTlk0OFJZUGJ2N0t6?=
 =?utf-8?B?dGNZU3lmVTMrSVkwREdiUDVUUno3UmNCc2J6QlpKS3Y5Mmp1RUlzR2RjVmZX?=
 =?utf-8?B?VGlCdzJZb05QanpCZnk2ak8yVitXQUlrSjJjdFJFTlgxMCsvQWlQbkYzeXBp?=
 =?utf-8?Q?r13GiYpDIxPG7zIIVKzOHLnt6vTnRggP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDFQZEJYWDJVU3luNEpCUUxvajZkN2JRSmVCRFNzWFNhbCtlNm5ZWnRMZUFC?=
 =?utf-8?B?Z21zdTVlMzVPV2IrbzRrZnVsMXFuQ1B2bUljODZCZG83NkNjM1NNYjFUa3Zl?=
 =?utf-8?B?a3pjWjhkWW1ZaHAyaGxuRjZiSi9xRmNMU2dLU0RHZldvbHMxbENtdnpiaFhL?=
 =?utf-8?B?bUlBSWoxU3BSZmNpQ2RWMFFnR3MxanF2ZlJVQVNyazFGOUVYZnBnS1FabDNh?=
 =?utf-8?B?azMyOXFwYW9WOXNKSjJHYVFmRVppaUhiMHo0ekxwcGdoU1J1eUtZdE5TZ1p6?=
 =?utf-8?B?bUJRcEoxbzFHTWZreVNSQnhPQjBlaDNSZmtPdVFXSElaZFg5Q2IvRFFkV3JH?=
 =?utf-8?B?OWluOVZTZVZlaEU0R25Qb3V0SjNLQXh6M0FQYXV5aFdHN25YNGo1ZUFwVC94?=
 =?utf-8?B?aU53TUY0WTlBWlBjZ3JwY1R0OGZhdTlYL0ZXNk9kQnBGNjY3ampVUjFwMlJP?=
 =?utf-8?B?YTc5RVFrMDlaY1ZRR1hUbzUrQnd4YitGQlRnVE90TWJrQ1FpT1ozQzIzYTgx?=
 =?utf-8?B?TDR2VTVGNUtrdjRJczNtdnR6cGQvUFhLdlR3MUpRUC9XMUVJT0dUc0NKWnJF?=
 =?utf-8?B?cWxUR1gxYUF5WHNlNFVRV2tjVE9YdVJicW5HZzhmeXJzcjRsQ3k1ZS9UZjZN?=
 =?utf-8?B?K2VGcTAyYUxWYmhTR3gya2ZuNEpUY1JpbVE5bGpGMjNXSU5aM0JTOTNTVGtN?=
 =?utf-8?B?R2s1T3pjRzBsR1VwSmRKakdhSDJvYXA3MytES2lJcUpxb1ZCeXRTTXU1Smdm?=
 =?utf-8?B?RHVBYlVhQXhtTnFvbjVnbDZjRHJtYnREL1R4TCtzbUZ4ZkU0RUd6dnhmN1d5?=
 =?utf-8?B?SHhpcmR4S3FndUFGS2RNc0UxWkMxQ2h4SmV0UUNiSTZpeXpxUUFKSXBBTnha?=
 =?utf-8?B?bkpLQWoyT2NkK09uYVJBaFNta2htSzZiWUIybXdnRGNGbU1ZZnhwbWh4MEN4?=
 =?utf-8?B?Vk9XcmxsWEhTVEt0NDY1dDVCdHZ4MWFSc1ZjUENVR0UzeFM3WEFJeXp0YXhj?=
 =?utf-8?B?WUhiaHR3bTQ5Y2FzLzFtc0dJZWtpRmVFcGxpdnNobW5HVllpbkFWcHVWVUdH?=
 =?utf-8?B?dm4rQTJqTlMrdXJIdGRTY3pMcDhVWHlrYitOdS80Yk56djFhNGR1NldzVlZF?=
 =?utf-8?B?bVl6MkhyZHptOWpOSGZ2Smh3dWYvMWYxRkZpbWZaL0dlcStlVzJobGRtNWRD?=
 =?utf-8?B?QkNMUENqYVVkRmVxcEJyMmFIdTF2RFlrMmNWMERTZmw4dmtJS1JEOVpQR0Fm?=
 =?utf-8?B?WnltZjNxV3p0cHVUYVM4cWI4Z0lsNE42T3Q4aEozSm5TcFlXdG11VDFlZm9E?=
 =?utf-8?B?RDdXNlhVcVhGZGVGSkh1Zkk0bVZ2Mnc1YWtiSmE4NUM4R3BOcGpNMnV4bkFV?=
 =?utf-8?B?VjdZR0pXa2VxaXFIYTcrNXRKc05Ed1F3dlh6ZkJwckhTRU5FTWdYY2hhRnM5?=
 =?utf-8?B?VFA0UTJ6MWdHS3dKSjlKVkhVWW81Y3crRUovVG9iVHdVM0t3NFhnZ1JBYzVt?=
 =?utf-8?B?SnJBWFJMSStkay9wUEFFc0RDM1FHNW5ER1poVzhrKzY4VTF0QWdEZlVCRmRi?=
 =?utf-8?B?L3ZNRnp4WEw1aGJyNDJDUVR4TGJqNW0rRU9qTEgvVWE3NXRxTkZCeU9uUkhF?=
 =?utf-8?B?d1dmdG1UNW4rOU1WV1JEd1pTWjdjUXRwS0tyUDEyeFJIdFBVWGtUQzJGeUQv?=
 =?utf-8?B?c3RIVDhKcDM4RWZOMWkzZU5VU2JlZ08zeXFHc25XTDFaY2NSOHdhaDJrME1Y?=
 =?utf-8?B?WWxaVzhhMjN0bTlpN2lLRU12TWVoYzcxMS9NcWRjcCs4QW54d1FNTWVnekZR?=
 =?utf-8?B?Y3ZwNzR3aEROSllsY3BwN2U3R1EwbzI1aVNESFVRREZ6Y3ZibFF2cWxWNTJX?=
 =?utf-8?B?eCtIVGg1KzhJaGg5VytVemg2em45VVBSSGx0b1JhQytZbGQ1cDl2UEt5MzV2?=
 =?utf-8?B?cDFEMmxyekY4L2ZBalVodmJvT3Q4Y3pEdmVnejM4OE55SUlITmZ0T3ZZc0tB?=
 =?utf-8?B?L3hOWGw4c1A3aTBTRTRVR2JJbFhtVG44SG9aYjg4UDI3cWdxSVhGYU8zTU5V?=
 =?utf-8?B?OTkveTdMeHRmaDdRQmNpRC8weFNwZmtHaEM0R3VKcFRnMFEvbUd5S3ZLVjMx?=
 =?utf-8?B?T1NkQWM3M1dyZVU1SWZUWVl5cCtOT2VicVdUODE1TEN4a1Rid0xXZ2xFUlRB?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	851uv+vCXuJkhDLH+2lBnZTlExYQdK7F7iygCJqwJhz/KTs6JIsa1FRu249KMuFA6UvcZfT7iOdQdLfLHjAitNCj35VBr9ZyIxUuRGT9+u+NuovEDrZMOrs+kRsRzNrpbi68ejScyGb7/zvb4P5MOJyBg79Umx6Bjuz1M7vM03opPxyzHO+jL1iVWGaD611OcMRfJ4ZVpEwLPjnBjp6DxQJfCTbFZxQ9mctMep3Ust0L4w+CW5tkTpoqf6O7sqxBg1dpcQNOFzE/rGtPTn7NPCcl6QNZeWCl6118DAR1FzaHclI+BNiF/LPkvTAxZxfudiCfcDqRzQtwiGZQnXsT7dLr5MFh6e7G5AHMGV+Aev3UtoJMS1pG6sHsjIZpeR+nECT4WoUK55B0WTa7bKadFSKwh9C4ZDAFSSoIwHK/hnusWWfcqorpGhecNzSuUq0zbNIx2/e0/y0Jn38mA+MPfNiyq8/RUAxPwI6B17ggopWbp6gME3xzZewoLZ9/IWL7z2g/itbXwkaE3E8O7bZYSc2EJtWYVvNdZro3UomR2u1afloSMfMzsD5q36ohO2eT1bXIgAn1Qwf8LVE3iD7I+6bqa258IBP6SnhYt18MSro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1889e4f1-5aba-411b-93a9-08de033b2513
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 11:42:49.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr7MYkHCu+oJD1UYBZ7LygRyWg5tTZFSwbCR53eQ+XGVPgVvdJ9Eq9NppZ91Sg12JOS5yItjucBBfNq4fjNikabgEwxH6kjiNzq3u9cKaQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD379E651F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510040103
X-Authority-Analysis: v=2.4 cv=QphTHFyd c=1 sm=1 tr=0 ts=68e10855 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=FyTrvsKcy_XeF2lg9hcA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 51Clyw_wDINhUpIgb58cJrrwMZo34X_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDEwMSBTYWx0ZWRfX8DuuEio25XNi
 BLMbRBpxbDF9LF3WtuX0gbI9SssJjQ/M10oW/A19Y4KlvulZoMZzk4A6QJ5UlL9CSDhn3obVN08
 5vHgVquKmjMXvdCnoPIgcwD2/d/o/EQe/3FnOfLIEzh0VsMuwoWetFQCCd3hVMX3mAkPXSuaiWx
 +nhk3VR7a85mynLnsDAGpji7QfrnxaWYRs7iSPeL0MdOHZUR5/7abjUjynjxti+2lWC7pi/Iwj2
 2bK4TwQHDAGOyuJjGbhQ3bfi1pAe/rKfXTdC0q4IUq7SBLOUvgapPwHnADAkzynZcz2hXKw+pFY
 /fk79e6t6EqQIM/6RL6VkpIiL0r2/AzLA8dmYjNc5DlTSnVDGUOgp4tIp5U3wtS1w/8WKZwwNlV
 ad5G7V1JfEjB+iTeN1NAT7yCh7c/Vw==
X-Proofpoint-ORIG-GUID: 51Clyw_wDINhUpIgb58cJrrwMZo34X_D



On 10/4/2025 12:25 AM, Denis Benato wrote:
> +struct power_data {
> +		const struct power_limits *ac_data;
> +		const struct power_limits *dc_data;
> +		bool requires_fan_curve;
> +};
> +
> +/*
> + * For each avilable attribute there must be a min and a max.

typo  avilable > + * _def is not required and will be assumed to be 
default == max if missing.
> + */

Thanks,
Alok

