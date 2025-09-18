Return-Path: <linux-kernel+bounces-792236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC52B3C1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D346A7B3671
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780432039E;
	Fri, 29 Aug 2025 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c34AAxb+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qYCq3Kgp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BA201033
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488684; cv=fail; b=sXvpa+YC/o4usaOeUaXcynFpk65J3w7ng2DhCxx2qlhNMWlnVFalAOnb9TBZ+yIpXgxD8e38e0l62A7rS51osaUcXwP7YYN6r/tm6mHg3HWEPEh+CgXpgOdhgAxje8q4dAcAv3XaRDkFDPSGMJc989P2JHnvqu5yZ+u8SAKCdY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488684; c=relaxed/simple;
	bh=9f+4BOdzQndmrJT4NCBeOmFBsXryOJWHqyUj/NmVo40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wm2pcAELbkKcxY9u83qwcRODALbd7hez/7oaoG87BzVA2xHyc5UV6wlV8voOSMCfBhy/NhShcpFFXUD2T7wlTSwhs8ODIsQTr9K8N9GDTBHYkNoRo4H+DXggSUjyeTg+NGUuomQAqgvd8jjky45titobBq5ngb6VWd47dlMNC6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c34AAxb+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qYCq3Kgp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGfkxW013377;
	Fri, 29 Aug 2025 17:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E5u46uHzR7DHu3kr32
	1/kYzHRimGmjFDJEm66iPPo2s=; b=c34AAxb+vB/PuVU7JqJj2u8b0YBNP5Nquu
	N8HEbsF1npiBMqQgI1Gbexh5woyOdb9mq7B/sfk/F6a9HjCSXbkoH5WjNNmO0336
	8+C7bZSVsqTBozEY42a68U8AQxSkTLfjWorYI3xQAs1nQh/WbcX4R5C6HEmKiEMI
	1MakZd7/AhAVAsXw0mIxTqaRa7AEI6dgeF352pr77dzNTybv913tTQ4KQ9nEuCJb
	UEphxR5idF7P1L+fuN7nN7ifp01l14lsqi3E8Yb6kTL3l+64i5V+J5nZm6Xy1rpN
	EIsQOkB/lGWQ5KGH7UE4ZxZr30p6/Wyl+GM6hukoMQAQgFbmQ++g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jatxwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 17:30:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TH0KS8018996;
	Fri, 29 Aug 2025 17:30:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43dg3tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 17:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0tV8MkCdURW9QleasPUlXNmIcbbvf3a8MilzIB1b7Fe7SMWoz/sH33vrEQ7q+q9L/VKAbjsZv3gR/71pnfd9bQt0m1+HyIo9G/sbzL531yzDODhMSlEGlRsMdHwjxaY4vINdnHH/mpAelDa+dOlhx8wB4zuqpW3AYam32ghM9JUYGLLWP8uQHkVrpjcx78jGGLIEySP0Ahx1l7AxadWN3SSoCDIgfY5cADPrFCXbZeodUkAChcPERv6ftmgPXYHMuKwiNHqMQudDpB2v6p9KpmOkuV26OAxzg5ZFSbAo10v0nyuKedje2Q/ZVCOZTLwk+FhQKcLMOZJqu3kJ8SCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5u46uHzR7DHu3kr321/kYzHRimGmjFDJEm66iPPo2s=;
 b=q79xYLTLghfBAwwl6pFcIdO6xTporE3EBoA86IusHLiFfcNonw6O8lMKPMUnH4N23PuzenGLVJIT2YDTIuA/EAHHYHHXFZFG7PH+KNU6e6ULdYPK9c5S/xz2vTacmlj6SjScLXX5yWT6/ug9DAek5oSPQXX9haXJwVwFtFKfHsnjenoa0+6sm5lppj3oWyAncsgkPbKlNGcJJri46iKym4Hcl13RvVfhSf6FPVQ4XzKxqeJ/UT+ep65eYu/jcdHrfahlpwAzye04uRqWiddDy2laiTv6ol25pK3VQpnBr/U1DWvJ8d4BLoHVBO9bk6MkS0PuxTMfgKdxMr8c6n/BMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5u46uHzR7DHu3kr321/kYzHRimGmjFDJEm66iPPo2s=;
 b=qYCq3KgpuCyUG1wQ6nX6r4fwztgt6XaNIfsbCNmoYKnvTXSsO/BZL4P+bl4sB8CiZ8kHgDzUQ8myvNk4dZxxTLiKEkv/iZ6RomsF1s+pyE0E3XA1HvyLUAmRxqnJMs9QcuC8tEJgcIaYnGUqDE9INKDJyLE6vjy5FV1XSsR4tiE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:30:46 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 17:30:46 +0000
Date: Fri, 29 Aug 2025 13:30:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        lorenzo.stoakes@oracle.com, surenb@google.com, liulu.liu@honor.com,
        feng.han@honor.com, tianxiaobin@honor.com, fengbaopeng@honor.com
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <brzxqxiwpxwjr22mknh54mn3efrgd77w7mfnf3ojm7qm633gh5@gngras6lj57q>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	zhongjinji <zhongjinji@honor.com>, mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, lorenzo.stoakes@oracle.com, surenb@google.com, 
	liulu.liu@honor.com, feng.han@honor.com, tianxiaobin@honor.com, fengbaopeng@honor.com
References: <20250829065550.29571-1-zhongjinji@honor.com>
 <20250829065550.29571-2-zhongjinji@honor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829065550.29571-2-zhongjinji@honor.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fe4144-9023-40e1-a88b-08dde721c979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FG/MfzsFBowLo1fNnU/snfCFzVJtOTbYabqB9ipuU+XAmCMR/dj9YdPNFxyt?=
 =?us-ascii?Q?W+tY22IQm6SniG3QNxyfmwGI8vMa7FhsgfzSNy3kawoEtTzcU99S9JGtD7Ct?=
 =?us-ascii?Q?94jCs45O951ViPkbbn2zYkYJlS8nF9RKX4XTGUBXvYqzTLw3YSG4IR7ECkqL?=
 =?us-ascii?Q?B6vD+mdsZ9LswcxSWOry8RxHrLIiU1S1N28OT3Cyt41XdCkf7oNlJ1WBTJgM?=
 =?us-ascii?Q?6f4nnkz/ZNHhuPVUC9QS0H8YJGqSqjtm0KwpZii1HGqZoPoBcoH78AVgvNZ7?=
 =?us-ascii?Q?vUDCJMiVtNDGDCdQcSBqEGBAYSKj6ZQwY1tDNKTaY5GMqGIbdA8nVQljWxJG?=
 =?us-ascii?Q?SCX8ACngkTFCaSSERc5umUnbcV2O9QYFPg5U+3wskUZwbTP/ClgmQGhVxtNS?=
 =?us-ascii?Q?cdVcNti1MbWG3O85kfupQCVOPsLkRXSf3qPZ9Mh+Mrv7Uk0wy3rceD9oJwWk?=
 =?us-ascii?Q?AI66QgL9IclFLakGjpM3bfdcA9Tc0S9s01dWm+Ctphw/bJqNacZMeHJDp3yn?=
 =?us-ascii?Q?APz+j/ILJZ7P4kVSWXDR4g7BnJplQbp51Zny+CR9c9fw3z0+1hb2UbyZOSI4?=
 =?us-ascii?Q?GyGlFRKiQx7cSnsf39mR1W0a5yXrmN3cMb1XTxBQpO0sVSpJF1TvlcFpGeUT?=
 =?us-ascii?Q?hqcsl4mu3zkC5JfVJjKjXxTBWkWXvVdx7nBt5f5e+mtsk5saMDbJuaeepmwH?=
 =?us-ascii?Q?78laKWaRoF68KVia0sqtzG72zuchqA36r1yTOp6F/HhFmbNwA/15Xx09fhkR?=
 =?us-ascii?Q?p3BL60Qi0pjDVRtRjcGWd3UtNHMhuq2Gqtz0ewYVWLPaEqnzgCXeFs5WkzVc?=
 =?us-ascii?Q?KDF9AXtPzEIwd/PehCVCDooweB8uUHr56N4TuIOtOKNwwyvHQpHY/eYAiCrx?=
 =?us-ascii?Q?qp4CIFNVfGay+5FRD0X9A36KxlgZbmZVzxhjVqXwt4vY/7H6Pj/Y292R5C7K?=
 =?us-ascii?Q?v/Vrt0hhwsJUzzvHww02GaB02oXjzmVwzDX/whZeIt3LLEgJzeSjw55bbol6?=
 =?us-ascii?Q?WqIIea9+VlBhQlPZLM6mNic/yv3wJX7s8SmUQ1atpv03zvAFFx8Al5zCAqZu?=
 =?us-ascii?Q?yaVlnVuw3htKEc/ytt1YHgRZ8GbWOV620XAuc7Jvz03iHUCzpDfdkSubRq/8?=
 =?us-ascii?Q?UEOWA/UnfyJhIpRwKcPm48C/0BqjeTsXD+h//HPVeMlpP7FXnw3CwsKH43WD?=
 =?us-ascii?Q?dGElMnibuisMOJmwwKaOcR3NS6DJqkC4JljcEGO8zCzpsAT9bHvDP+GoBA4y?=
 =?us-ascii?Q?EgpEkQ+YW2xhbHtOoandGAXwiIKXCXwch90GR2badapKsnCLiPmHZeokvQO9?=
 =?us-ascii?Q?pm3wva/auYTG8OMO8t45EZqo+6I3kABfXMWHDWD5REj5fPoMTEmdB326mtAI?=
 =?us-ascii?Q?TFRSGy9XEeS/FVnnWY+DP2Cm+rXPO5KHWOgV6GxYsEtE9xDeGWRJJrJj29Pb?=
 =?us-ascii?Q?zpliUAGyFTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmPKTR2KRfSgIYf4BkDpEiVjsmxeq38XbCTd7cd23N9yaBQyr0HYktbmBVIn?=
 =?us-ascii?Q?r9By/Q7SmWNU7lpe1dviSCfsAJ9B5NzzaTaPY45knhSc1b8L0Qn2W5QXodqn?=
 =?us-ascii?Q?zFfF6Vgm3/ti/T4FiOwyuYzgZL+BHDgfyl7VlJkQ1VqTFZ2j7uzPCNZO3Hs3?=
 =?us-ascii?Q?jogBLHF5N2WCoV28GRI9KAr0nxqBkPUMliz97tXfP8jWPUhLpcTyIrfKlP4y?=
 =?us-ascii?Q?PsBP60sIv/4lSnGDJd2bmsMhaxRPLr5Xs55nhDEr3U3u9b7hAhnfeASkEu4j?=
 =?us-ascii?Q?i/AdXrfcfBeoEde+WBh6+OGaVVs6V7MVbLuvFSsaIqW9TXNZaUwlV1KcGXu5?=
 =?us-ascii?Q?Yd7SyVm+HO9m5mvvVUY35qPEus22ou/N/x7igMHgW6p1oFYF8YeJNC4iu8E2?=
 =?us-ascii?Q?v5PVrFg4EetodJi/d6qMzhpzb9rhCouLYnGe1Sme5YqmOGuoYnzLer+tGqCO?=
 =?us-ascii?Q?xS9/JHlQEYeHKh0B289NiYJ4CaeH8FpQGljMrbwen8F6GrOkKRNMZbOHCXoO?=
 =?us-ascii?Q?Uihojmnp2VAsi4sp6TbiL6fHBX90KGRmAo7FT2qsdWoK3uha3CCnX6tssKl+?=
 =?us-ascii?Q?MrWTH6+OclYUjdXXz7VlaaOtVaBDMUUw8wBURT5MWMdlk4BzMNqMRBHvVSBd?=
 =?us-ascii?Q?wQNJplvenxuXZy7Im+TOzFoINDKUYw6ojrLHDa7i3xEdxW7TdXvVhMUeRhwy?=
 =?us-ascii?Q?IcABlpW+NxSM7PAsaJhfDPSdO272eSamXX6d7P+X8cCwQJVxhMVDZ+kA1BF2?=
 =?us-ascii?Q?wQwUczZ5hBTY4EIjctBe4kBtBKqB6bxUPiLlP9bprSnI/K0ClibtGfcw4fv6?=
 =?us-ascii?Q?OU1dG3PEXL73xOb8S6f5lglqbhWzOHdFT+U2QxWZYTOrWk1/tF6grkpDLTx0?=
 =?us-ascii?Q?Zkg58Vw7R4yp8l7ejBZfUNqUaCbKmWsTXlh2YZRLnQYuu2m6ABjQs+5RpYRD?=
 =?us-ascii?Q?BOj82BOKDQrTJsZhATsGvPT3hdTEGZsAaRzZ+wcD3CYwXTRkhbvqM1qf2hXM?=
 =?us-ascii?Q?OW37ivcUmExenXUm1rALYfU8NkUIlln3yxMkQPGVq9y2LbRNOrWGclOoKhFC?=
 =?us-ascii?Q?+GiFgul2BlG7UvoOvmxOiPYqRujtnvWYB+cjaslCmXYVL/UX9HXpdBRXKDXX?=
 =?us-ascii?Q?EgHZx42p/1fCRI/ZU89OubVBhI7Oo7257Glyb/1ddZ95tZwQ6UZIrKYiwHWD?=
 =?us-ascii?Q?KVkKW6hhkZ+KugQknxTE4WGXO+U8jJAHPDdoPYSU4Vub+cjVPHl/o4w8J2P6?=
 =?us-ascii?Q?ZYF00KCVZr29h0dYSMZApbkc4dTecMDDkYxautSlKDTno65IvtrstFmIKoPR?=
 =?us-ascii?Q?puRLHnLIBhECkezZm9LEdv0xghYy/8FPNlS2jmSwGb3aT1Pjgr9sYEOlOAKN?=
 =?us-ascii?Q?oqPGDPH2u3T0aO3tMGO0NfLTCJwsODb0dihGEnTC4KGXf2m0eNKFD8+pfTE9?=
 =?us-ascii?Q?PwsgB0sLcjkwx1xl+c7f6DfRTX8p6tz2bY1b9PRnrcdL1RZRNGKKj1SejaO/?=
 =?us-ascii?Q?/wwJnGFQcRnveDNNozk5fVD6rLxjUhCyf50Ti9EC7GsFInyg74nrHo1V1KDI?=
 =?us-ascii?Q?lkDdamwuwLLxrJZbVd4OfCllQzBeMNrr/lbP5lHrDlu7/Ug/1yBOBkki8kEK?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ETl7r3qhdQDqgVmJB6MwynX7DOOJIS9gTtD4NJf6lTOFLj00FI4jtMc3WYFQc2eSUtFY3DcUjZ6WwLp08tWyBEIO38GiK2JtdBAOD2hrRBNdMnmmnTZYtWH/S2+whyaWCuDZ4bVjfZqVpH+uvsIWTM8Dy35zx1AcASfQWQ4mbsMraXLuS8QFY2+j40/SgJowRaKyA62Y9cTvDBP+6eQQ3jgBr1RLVR4Si4RTv7OeLYHi+T6ZiChtDPVooYfFDcH4dG15yRsk47rh2T8yLJbAHMCdHfu6SnOPNWHQor2yCiMkI8Wplj7KdQ3bwIW6ANtyMV0IpdRBcag0cJamE96Sebz/hWTfl9GdU+lRzVQsUuRx4tZ1DesOImzYLuFaEPsYpWJV7GTySic7T+cPihyj4lNiw4o7oxX/TQ8wX3AUu2OPLNFBzI5a7p1LgNDVYNJcvRY8hboAQ32vUBA2N3Bhw0XCu+1C7vRKP0G5L41ipOkhsqy9xmVOCg81+VDNezDQ3cxV8q1L7fFCtLiRD6Q0r8cAnLiRzPIAaQO6d7f4d8kIPmrxYPFbq91oWVsrLbrDfORNshdnBGYoPBnMVMgdAJVlg3BZKzFnEuVddypc8Bc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fe4144-9023-40e1-a88b-08dde721c979
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:30:45.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Cg3kyX1wIA9KE3qhqx/oUP6cZLMQrkdCtXegRL47mMUYI36jJajJnrLddAB8nXm+WZrsssobKdpCWuMhehRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX0C9Hkv4rc0kM
 pdNTXehWB1CBcGXrIfass9uwE0Id6mp9Vn/vpsFnqflCtCtKOoJ2hWIbA6cvHtFehAsgBgsGL1m
 tP80pN5eozyfN/nIP0Z9blwRxQ0X4Q1U9Da6UNEp0TMkJDKwSC5gF6InDHygobC9FkBIC1L49c5
 QU9BGTiW2YFbkgBrDHqOpuLWf7dFaRw8QjJpNtAZUST0lgdxFfLp8BWHomlnjZHFbCHfHoU1ZrF
 pTdQXQM0u83aj2cXc+TtW/Vyj5rUIkgd0mm2X2sHu+E19eXnPj0vMFScIvXc9C5UoaZH4F0WtFp
 IEoNCDGk9OxV7e18E17XGoKEl/eSysdyzennCo8iArpcg1jleiRxPj2ivJh6P/mish9yEplMDVp
 +iTgZ3W+
X-Proofpoint-GUID: aXNhpNxKV8HHgXl_--oOFi-ANETSvV3P
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b1e3c9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=lgicOfLSj8L8v3xg:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=CvlTB2HrAAAA:8 a=yPCof4ZbAAAA:8 a=2Rs-FFxIi-3bGJUbILcA:9
 a=CjuIK1q_8ugA:10 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-ORIG-GUID: aXNhpNxKV8HHgXl_--oOFi-ANETSvV3P

* zhongjinji <zhongjinji@honor.com> [250829 02:56]:
> The oom reaper is a mechanism to guarantee a forward process during OOM
> situation when the oom victim cannot terminate on its own (e.g. being
> blocked in uninterruptible state or frozen by cgroup freezer). In order
> to give the victim some time to terminate properly the oom reaper is
> delayed in its invocation. This is particularly beneficial when the oom
> victim is holding robust futex resources as the anonymous memory tear
> down can break those. [1]
> 
> On the other hand deliberately frozen tasks by the freezer cgroup will
> not wake up until they are thawed in the userspace and delay is
> effectively pointless. Therefore opt out from the delay for cgroup
> frozen oom victims.
> 
> Reference:
> [1] https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/oom_kill.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..a5e9074896a1 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -700,7 +700,14 @@ static void queue_oom_reaper(struct task_struct *tsk)
>  
>  	get_task_struct(tsk);
>  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	tsk->oom_reaper_timer.expires = jiffies;
> +
> +	/*
> +	 * If the task is frozen by the cgroup freezer, the delay is unnecessary
> +	 * because it cannot exit until thawed. Skip the delay for frozen victims.
> +	 */
> +	if (!frozen(tsk))
> +		tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
>  	add_timer(&tsk->oom_reaper_timer);
>  }
>  
> -- 
> 2.17.1
> 
> 

