Return-Path: <linux-kernel+bounces-756300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14671B1B26E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1D3189FF83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B95256C6C;
	Tue,  5 Aug 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4La4M3L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ARlkQTq2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4224678C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392259; cv=fail; b=UhtBkDeFY3IG744kbIKyYsfFNhGHHM1vy55NHF0eXAXT4zrpP4LTiLummyoBVlx7BwjlIzj3M+Yo5zvtdrydr0/Bnq9u49sewOSXX84R70PFotj7KbIzVNwUWobaQhK7eenDiKW5Ve8cCUmTvsRF95ZUa20xUhOKZNSC5dDEpoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392259; c=relaxed/simple;
	bh=cCaQonYHhSjekjxe7hY2joeFXqyOzUrZE9P39ndykfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gh+uoj50YtXo0zr0jGKR0GNAsDjkG2O8BVFUjHVvaaDYaGT73vgWZlvU1TI4vLtwPbGaMXZBT4oaAogcpINQ2RLZVO9neceppU0rry7tGsw0OF25Y/DAoI4lcgFmBeo4IAPt6s0FfNxKl622UhUetxWluE/82Yw8uvgxvUv/ayg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o4La4M3L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ARlkQTq2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759H02r026521;
	Tue, 5 Aug 2025 11:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZNtKpiI4R04DEb6kHLoFLjvU5HxMWzCt1iv4DEZ1xVs=; b=
	o4La4M3LajWycQJ+gtwfcaqQ/6lytyRw3mC7wuIVIUIm7dZZVBUdBLKMILwHDuzs
	CfnwsEUgeitroOli6TxhjZVJNCxU+hfEBhumb+qC6MRuHkLm1ebnbIPpaieEX0Zv
	9eqp3pxHqFZdaEb9iYDi8ZchEp6XywMWPVmdalaBUcLBc1OoSHsS2etucB4Cux9v
	B+irg+CN55QHuu14ixRDZ9Ud4iX33eiSkor2FuTQveT/lHKn41wWQVHmA3cO4ANz
	+dvQoZrfCXMKc4U3LpNNPXJ5CQd79QQ5vylLrpD2p8dRDoUvnDTNTc5VKXeX+Q9Q
	fRXs+dXdIiMx8J7M23uTeA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vvfc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 11:10:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575AH1OA032089;
	Tue, 5 Aug 2025 11:10:35 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jvsmeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 11:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm78bsuaNiFKr8kz1kTBSpIRZ3Kvsng/1dMFoB8ifl4Q8AbR9YwEMNl+LFXU8O64CuAPsJjq8K+dz0WSRe1/cRBZL33CqsGQta96kMqD6t8ci9bsJgIHDvmFcC2SiuFL4yIbrvvKWSkcO2U5t5Ehdjjpn3yjxuNk7eybKYeoIrsoBnnE7nUsyH4H+0DZsCQOnueIRei1LbIUcG/dms3MWBfr8y5Vk+5ujVnOfp29x/SvhaKV+FAjANZUVtbOygUunIM0eyXPntE00DemtH4VNIVDAc5epCeVZ/itYQ8WL6PZnGkvTlslbTe3KD3i5IHek3cAY8rH/toq3vk7mCZDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNtKpiI4R04DEb6kHLoFLjvU5HxMWzCt1iv4DEZ1xVs=;
 b=G2xl7VJ8IeJCErp1sDduBeY8fgCgO3x820CWyxJXb+nqYytMt9n1dXwGkgMOO8g+Vq32zJ3FJsIrLtVOSKgJFl/s8cDjyqbyUrP+N6RvEtHr9JR5Cv6D00bEZajjS8C2ljxAcG5rocyx0jVZkT3R2ThrVaZsI4gYwYh8ufI4MbrHWiibl/Sn8GVcZ4xdXk1wXeXXyFQst6vjOD7gg+6Mg729JigN7kBqur5WQGuoLDF7FdebywFKHS+vG2xIM7iGdTU8In4eUdrDu9mGQ8V5PjUBQzL1MXNOGSehvHXLd5Ycu+DjMgUlybT6p5QlNNtBbny3ec9oUR3fMRtyW8mXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNtKpiI4R04DEb6kHLoFLjvU5HxMWzCt1iv4DEZ1xVs=;
 b=ARlkQTq2BQvY1pJOmIXC6dR6Qsgvvx3bZKEm1IdDdu40rnKzwdrtZ56fNdBev3C/rsydeO0EA3CecAyAJyMKjqfy0voSal1GH15dTN4GdcKX4ep8ns8/bupZt7r7z03AfRTpWH6fmhN2czV8aRfFer3/4dcWyEsfc62VZCaC4/Y=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7862.namprd10.prod.outlook.com (2603:10b6:610:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 11:10:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 11:10:32 +0000
Date: Tue, 5 Aug 2025 20:10:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ben Copeland <benjamin.copeland@linaro.org>,
        kunit-dev@googlegroups.com
Subject: Re: next-20250729: PREEMPT_RT: rock Pi 4b Internal error Oops
 kmem_cache_alloc_bulk_noprof - kernel locking rtmutex.c at
 __rt_mutex_slowlock_locked
Message-ID: <aJHmm9WXEJqVkyTD@hyeyoo>
References: <CA+G9fYumD2MGjECCv0wx2V_96_FKNtFQpT63qVNrrCmomoPYVQ@mail.gmail.com>
 <aJBnf738fPEmVqGo@hyeyoo>
 <CA+G9fYtJENPx+vxd+J3Zw5LwXceTS-dEsp74ZrH9cDe4DKfvsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtJENPx+vxd+J3Zw5LwXceTS-dEsp74ZrH9cDe4DKfvsA@mail.gmail.com>
X-ClientProxiedBy: SL2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:100:2d::25) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e34fdb-43fd-4f00-48ba-08ddd410b190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJXTEFNUy8wSkM5TU0wNEhjN21jQVJPNjY0K2hCSTRoSWc0R0x1Qlg5b242?=
 =?utf-8?B?TG81Zi9FN3IzK1hXNitnYjZ6QmJ1akxyT1dkMHlsc0UzNzlITVBlWG1WZ2c5?=
 =?utf-8?B?UVNFSnpHK0lRWnVNVXRsQ251WnVyUkZMUnZJZm0wN2VsTk8ycm5vRkxDc2px?=
 =?utf-8?B?aC9qTm5BZ2I5elN0RXQ5YXNHTW9aUVMxWHJSc2R1UU5pVDVHZTAxdW1rcmdJ?=
 =?utf-8?B?VHZ2UGxmOFQzNk55QWxkTmUzdGllYUhDbHkrUlRDTGVNWEU1b3o3bGxKcW9V?=
 =?utf-8?B?d0FpVG5kbVpBNWkwMmo5R01EMm5ZR3hjQXVOdFFWL1ZOOWIwNG9GMnlydTgy?=
 =?utf-8?B?cXBkZFpqejJKcXB0YXBCY1pGaGxHZVpHSWxOSmhuNE8vVnpnVFFZRGVCZytx?=
 =?utf-8?B?NDRXc2QrN1dxUGZ4U3BMR0VmNEh2d00xOVVBZk1POW4zUVR3aVg5dEJRNWk2?=
 =?utf-8?B?cmQ3Z29iNWpRbFd4WWtRR0ViaS90Qlh4UWxnYXFCbjVRQnlCOFZQNVdHZU02?=
 =?utf-8?B?TitRUEpEcW04Ynk1d2xCdHYzeWdzTXM1ZE0xR0xaTExyQzFJaWxZT1U3YzE0?=
 =?utf-8?B?VUhkWmxRckZDZWFSSmpvOHVxZkFhTFdUYlFFazdIbXpPZFh0bVVHMUVsUnZy?=
 =?utf-8?B?TyttS1dQbGEwUHZ0cm9HbS9uMGhSZzBPc1U3ZnZoaUtTN3lVdHk5OVhKUnVo?=
 =?utf-8?B?SDhRM2dOVDJVVmhKbVkrR2svMCtGNWNmZ0xzQ1kyZEJNZzgwNjZHbWpmenhB?=
 =?utf-8?B?QStZaWxTamt4WEw5cmZkRDBOK1BOTytWN0JPRm9FSkx1Y0FTUW0yNFRIcFNL?=
 =?utf-8?B?dStMNlU5RExrMTZqUHF1L0x6UE9BZFE4YTJSaUZCYXF5bStBcTgrMGtValdq?=
 =?utf-8?B?QlZQS2NWOXdPdUhtL2pSMEpsZzNTb05JVW9OdG45d01ESHdIS2FzeVo4dnl2?=
 =?utf-8?B?MjFvTmZoeXA4eG8yMTU5a3VrZSs5VkhmclVQSzVPYjVEQksxUllPUDUzL01O?=
 =?utf-8?B?MlJscTVtSkRRMy9wY2x1WEtsNGhWMVpMQXROR0NlNTdwZnFQUUoyZFJZSFJl?=
 =?utf-8?B?OXBPam5uMGRKRTcvc3Jxa0pGd0NneVFwM2hZWHYyQTNXaThwS3EwMHFBU0pO?=
 =?utf-8?B?MW1ZSDRiaEN2Z3pGa3B3RzZ3YndRU2FtQi9EbzBjbHFrTmwyQWVQNzMxM1Qz?=
 =?utf-8?B?NnVMbTdhNEYwOWRScXFpMStLRktBZHlpakxINUUyK0pNWkM5SFQ5QUcyTHYz?=
 =?utf-8?B?WmtDNnFUVWdkeTAvQ2JaUzJRR3pGNVBpUDgvc21vdWMwaVVXV2NtVEc4RmFw?=
 =?utf-8?B?RldoeFNEMXBoYVZxU3A5WjkwQWFlbC9EMVQrOHY2cGpIZmo0VzhQOGEvVU15?=
 =?utf-8?B?MCtFSGRtbWs4SHlmT0JDc2k4U0tneTEwQjJrRTNraUlhQkZXOExvRzZ4VEl4?=
 =?utf-8?B?YU4yWWpSejJUUkhFaFpvWFlpZFBjRndaWndKKzR4MTdiZFoyZ0o4UkVzV3d3?=
 =?utf-8?B?eXk1eEZ1M1lyQTc0c2YvNjlzMlZrb1R2WkhsZVlrQ3FrVElSc3RHRXI1Nk1k?=
 =?utf-8?B?azJFOEViTDFrV04vbndlL21nZ0dhcjRGT2FoMDkwL3d3VGhKNlpQdmNHTndW?=
 =?utf-8?B?d05HNFhEQnlCQmVJaFZJTjczL1A3aEtsQzMxK0ZiajJnNFFDQ2VEaGxVQWxj?=
 =?utf-8?B?MTlEa1dJTWRyMWllQ1ZVRzIwMUJlV3cyQVVJcE1wcHEvU0Y0QkphSUNwcWgz?=
 =?utf-8?B?elNlNGVubHZPUTZWYTFTSDVaY1N4aUhpb1NWWDBIaXNpME1mTWRwcVl4TXhi?=
 =?utf-8?B?NWlPajFlbWVMOU1RYWRHNGhEL21mUFlnVDR6LzdEVGwxZE9sZC90Ym42NnIz?=
 =?utf-8?B?cHNwWTVuTmJ3L2VBRVpqZUJhYm4rR2JSZXFORm5PZ09wTEdNeWdITWQ5QVFo?=
 =?utf-8?Q?+ffQsEcGkRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ZhM1ZWMXRHb2JWUWFTNHBBd25hc3l1Nyt0WHM2VkhaTGpra2hSVkhWV2ox?=
 =?utf-8?B?N241UmtqaWZjaHJUTDk0R1g4bXJSVUloeVpUWnJsblo1OFBOMi8vZ0U3UExz?=
 =?utf-8?B?UTFvRXV4OVpsMzVNdjJ0YnZqbzA3amg4WDZVMnpCam5OYVNoNzJHZnNRSUVO?=
 =?utf-8?B?blFmSytBS1YwU3p5emtJalEwQ0xYeTN1NXFaa1RkRkpiRGRGRHlxajlhWGZw?=
 =?utf-8?B?N216VUFSK0U3REZiTXcrWGhKUzFYNi9VSEJwZjF4WEUrdGF4UnlLbDZUTzJh?=
 =?utf-8?B?ZUIxOUgweTFlRGUvaTdDNElkVmZ1ZHJYa1dGdm0zazduSTk2azVBMUNwV0Za?=
 =?utf-8?B?S05vdDdpTjJBZzVicGgrTFo1Mnc0R3ppN2lhekFFb1orZERtY1VKWERPcVVL?=
 =?utf-8?B?Y2RCVVk2QnY2RkJGU0N2NFRaVmZxdVVFeGZLZkFPSjJYTFFueld3cWVJK0Ix?=
 =?utf-8?B?NHFLZkhZLzkxaXlFcjhRNXdtVWNPQ05WZlgxWVowT0VTaGNVYTZxaWoxTS9l?=
 =?utf-8?B?TWhrVytsNEplakg1aE1uTEk2allUT2RqdHlqSkdxcW1aM2YzNFRIVWlqNEdZ?=
 =?utf-8?B?dFZsbVdFME1iRXRLL2ZjeGxFREFtMUpYNFYvY1QwZm9nNytnRUQ5U0hlcXQ1?=
 =?utf-8?B?M2Q4M1Jld3R3TWNPNCtPZWRJZlBpMm9OTjRrS2xjRkpPcWZZM0tjVzFVeFND?=
 =?utf-8?B?Qnp1alFZK0pqQU1YVDhpblhBR1ZZUFpyelU5bnA0bHQ2MmpiNFZZc29NNito?=
 =?utf-8?B?cjIxbjdraTJ5elRsNVErNlVwSkh3RVZBR3dkdU13TFhDSEo5U2tEeWNmaXA5?=
 =?utf-8?B?eWxKZU5YSmQyVnpWQ2VTTG1sQTZWVXFEWW1oL3FuNHVvVDZTbjEvVFAyb3FF?=
 =?utf-8?B?cFdOTXJMZ1JQbmx5UHRQWEJMcDI0VHZtcndkdXg3OHJQOGJUc3JaSTB6Qlhj?=
 =?utf-8?B?NC9HV1N2cldhd2dRUUlORnJGZi9NZ3F1L2prVVAwcWFQczBUSFk5clFSRXdZ?=
 =?utf-8?B?eTVFbmhjWW9keVMxVFRHTEt5Z0FCT0RjeXZGWVdqUWI0ckdGRE1TdWJNWXA3?=
 =?utf-8?B?dEk4RGNIZmtMRTJUTjRKVGpMZDl0OUxYZmdQZUR5RmlNeFVMVmtvdFl4UUha?=
 =?utf-8?B?S215bXJ6cmNKQzk0Y3NWcGE3SVJWK2Rmb3llcnNLUE1PdlFzNVFBc2JzRGxV?=
 =?utf-8?B?UDNyOXkyQkZJUXZLclJmUFJYZnQvaElRMGJ1bnZuU3NmVlZUcklzSCs1eXZP?=
 =?utf-8?B?OXlwOWdjYUlaaE5tc01ISFhMVW8rNG9KLzQ0MFlMclJyNk1oZkxLSUZSUkJt?=
 =?utf-8?B?Rng2a3VRRlhtdlpSM3NBZGh2WXhlT25hazBVT2RkQWxPM3g1RmtMbHBJNERu?=
 =?utf-8?B?VzNsL0E1Y0owL0hUamNITm5BN1BaeTZwcFNBREFhKzJYRkR4a0xlUFl0U3Fl?=
 =?utf-8?B?TXpYZE1Ka1FPd2JrU0VUbTRBUDVESzc4amNhcUNIRE1LcTcrUElGRUlyelI2?=
 =?utf-8?B?ajZHVVRYRDRhdDFkZm4vK1JvbUhKVy82TExVY0txaHlIWDE4QlNYTVF4dXI4?=
 =?utf-8?B?c3BpbkJpeU1SSEVTdjErWVE1MVFDZFY2ZmlnQjhBWUtLUUJvaGw2UmVmKzEw?=
 =?utf-8?B?djZlc01tUThpR0w0Vld1ZldaZFlxK0ZmcGhlaCtCbHFQS2NQOGUyKzhMQnVz?=
 =?utf-8?B?OXF6Mk5CSHI2azdpMjhjSmxiSVBrdzgwY1hZa0NmbzBrdjhNTzNoc1FTWU15?=
 =?utf-8?B?ODd0d25tUHVIZWw4Z00wSWNCSjRtWW5FcHZQdUdpYzZpOVoyZXdZNkNKaDB1?=
 =?utf-8?B?N0tzanl4K1JwSjZEMXhsNHY0VFVYa2x0dmF1RGNzTCtZNkZQTzBRaEVpSUdZ?=
 =?utf-8?B?Z0RibVNZQ1pZaVF5YmZYbXN1Z2VIM0d3RHhIa25mKzk5YXprU2tpVFJVN1hv?=
 =?utf-8?B?eEpHUlJ3TkxaaWZKSE8yc3B3bXZsQ2hhdzh4QXlpQkJkc2t6T0JrY0NGeUcr?=
 =?utf-8?B?aFhVbUNZaTB1ZTlwOWJtcFI1cmpMdjBObTFhd0V4WGR5ZmNUc2FaQUxvZStK?=
 =?utf-8?B?YzYzMFV2RnBxQ2lBY0JoNThjSnk3Qmx0R1lwMUhreUR2MnQzUFBFZ0o5UTRC?=
 =?utf-8?Q?xueltgNzAEUwgsj3Wf/bpmKmU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L5Ri8f3vki1vu0dlXWWzBmqB8Pst9bt/Gke6DN6ygtYMmGIB8OZ9Bkp7c39SBPLCQ8iCehnto9TZoYLV4bXjiS/vPCnr4Y2xPoq1W78GbeyJHBDrRvLlnNELi/4oFG5E6AcgQLMKcrTyIKhTT14LL/BlLukHkk7Jiji6zdK0UqVd+ppf+2QmVCSzDpBlfqB43duuMsKDr7co+m/9BbMzVlreEvLlQ5BuxfmsE/hQ4xnJr5VrdX6rY95ZAVpet8RhxzrZIG5yLKRlm5B0f7XN5TZ5sbIsIvotywJtRept8Au2NSn1uPJRw6780IplMvXh8YP+ZrB6dhVVgYTHH7N3EOd4qisvqI4ofZDb1PDew5s2D5axqIoUilvoSnT1elJRKjtlRAVN7Ph4vC2ZaL/7u2dSlzMocFcxj+Zk0eA8O+ADYgDSlImSehpdJfonyvmd6fSL8Uv1CDkcWVGqQF9PpUImXI1ioT8QkQhYNGFmPK2H5HFVPzEsDz22UXzLMB4fFYmIynJWDGCckkZ+n4c/7i7NQHl98VsDlWbjNME2ye8h+Ep+nbvjNlvH4syzs+rZ53t6LFir+zlQs8QAFbYICEl6QWedZ1TmS2QgNgDHLW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e34fdb-43fd-4f00-48ba-08ddd410b190
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 11:10:32.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/Q09uRwepHheLDTbV4l0CQNvuF/ILeaX54Dws69+wn05XkqxmGKz8g6zo60UlwXI4t3qxaQdtC3WMOBsOaPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4MSBTYWx0ZWRfX+3ezSf486xRR
 JxRTNIVYNX36aymA0H61UMKeeRkCABd3ODugd0HNuC9aVd3SXxDi9veIMSOtXcSRhb/j2EvzPiA
 /j9Puouwnn2sht3cuOMZXPcVTJzo2JR+m+mEvisXgYFnKzELBFuXLje+R7qpAwYexHldhU0Log+
 P9gRzjP5aJL8U1IRHWmdGV0C2w65IL4VE0Fi/HPaEU5jKuZBz8xWOztDUt4ckZsPLJaT81DWNuu
 yU4qFFAFSXTtSANFfrHuphNxeBcKqde0JL5h+5Z6zeIDaH71zWc57oTnOpr3ab6P2dFq2Xhc8Qk
 VtHyVkaSN3m9RPdEVyAJ9OiSXoNgIk4HGrmlJRQpZCkJH8XI+2A3I7ND7klsoygQIVIdD9LCT/r
 4lkkFgsPQc/9xrFyaSRiGEGmFeYnJ4qNWU4YbCayPAtIz5nevWBUhRXsVFPKx+wzbt8zbb+G
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=6891e6ac b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=9qK-uXwyltp2T4LCbSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: g5VGCtt5YnQGY9yYe_oLmPWSQakZe8BH
X-Proofpoint-ORIG-GUID: g5VGCtt5YnQGY9yYe_oLmPWSQakZe8BH

On Tue, Aug 05, 2025 at 03:37:38PM +0530, Naresh Kamboju wrote:
> On Mon, 4 Aug 2025 at 13:26, Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Sat, Aug 02, 2025 at 03:45:51PM +0530, Naresh Kamboju wrote:
> > > Regressions found while validating Linux next on the Radxa Rock Pi 4B
> > > platform, we observed kernel crashes and deadlock warnings when running LTP
> > > syscall and controller tests under specific PREEMPT_RT configurations.
> > > These issues appear to be regressions introduced in next-20250729.
> > >
> > > * CONFIG_EXPERT=y
> > > * CONFIG_PREEMPT_RT=y
> > > * CONFIG_LAZY_PREEMPT=y
> > >
> > > Regression Analysis:
> > > - New regression? Yes
> > > - Reproducibility? Intermittent
> > >
> > > First seen on the next-20250729
> > > Good: next-20250728
> > > Bad: next-20250729 and next-20250801
> > >
> > > Test regression: next-20250729 rock Pi 4b Internal error Oops
> > > kmem_cache_alloc_bulk_noprof
> > > Test regression: next-20250729 rock Pi 4b WARNING kernel locking
> > > rtmutex.c at __rt_mutex_slowlock_locked
> > > Test regression: next-20250729 rock Pi 4b WARNING kernel rcu
> > > tree_plugin.h at rcu_note_context_switch
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Thanks for the report, Naresh!
> >
> > based on the stack trace, I think there might be a use-after-free or
> > buffer overflow bug that could trigger this.
> >
> > Could you please try to reproduce it with KASAN enabled to confirm that
> > it is the case?
> 
> I have recompiled the kernel with KASAN enabled and rerun the KUNIT tests,
> along with the LTP syscall tests, in an effort to reproduce the previously
> reported issue.
> 
> While the LTP syscall tests did not reproduce the problem,

Thanks for checking it!
It is unfortunate that the error is not reproduced with KASAN :(

We can still try slab_debug=FPU or slab_debug=FPUZ boot parameter.
If we're lucky, that may help narrow down who corrupted the freelist.
Could you please give it a try if it’s not too much trouble?
It won't require rebuilding the kernel as SLUB_DEBUG is already enabled.

...and a few questions to help investigate it further:

- Is it something that is triggered only on (rock PI 4B) AND (PREEMPT_RT=y)
  AND (LAZY_PREEMPT=y), but not on other boards or the same board with
  different preemption models?

- With given infrastructure you're using, would it be reasonable to do
  bisection?

Unfortunately if the freelist chain is corrupted when we allocate objects,
it's hard to tell who it is, without further information. 

> I consistently
> observed a null pointer dereference during KUNIT testing, specifically in
> the kunit_fault test, as shown in the log below.
>
> I’ve seen this same crash across several kernel versions, and it is always
> reproducible when running KUNIT tests.
> 
> Could you please confirm if this behavior is expected from the
> kunit_fault test, or if it indicates an issue that requires further
> investigation?

I can confirm that this is an expected behavior. The test case
voluntarily dereference a NULL pointer and checks if the task was
killed because of it. The test case was added recently (since v6.10)

Thanks for your assistance!

-- 
Cheers,
Harry / Hyeonggon

> ## Boot log
> [   69.507629]     KTAP version 1
> [   69.507638]     # Subtest: kunit_fault
> [   69.507651]     # module: kunit_test
> [   69.507677]     1..1
> [   69.508631] Unable to handle kernel paging request at virtual
> address dfff800000000000
> [   69.508661] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [   69.508676] Mem abort info:
> [   69.508684]   ESR = 0x0000000096000005
> [   69.508695]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   69.508709]   SET = 0, FnV = 0
> [   69.508719]   EA = 0, S1PTW = 0
> [   69.508730]   FSC = 0x05: level 1 translation fault
> [   69.508742] Data abort info:
> [   69.508750]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [   69.508761]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   69.508774]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   69.508787] [dfff800000000000] address between user and kernel address ranges
> [   69.508804] Internal error: Oops: 0000000096000005 [#1]  SMP
> [   69.508819] Modules linked in:
> [   69.508846] CPU: 3 UID: 0 PID: 683 Comm: kunit_try_catch Tainted: G
>    B            N  6.16.0-next-20250801 #1 PREEMPT_RT
> [   69.508873] Tainted: [B]=BAD_PAGE, [N]=TEST
> [   69.508881] Hardware name: Radxa ROCK Pi 4B (DT)
> [   69.508891] pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   69.508907] pc : kunit_test_null_dereference+0x70/0x170
> [   69.508940] lr : kunit_generic_run_threadfn_adapter+0x88/0x100
> [   69.508959] sp : ffff80008a867d30
> [   69.508967] x29: ffff80008a867d90 x28: 0000000000000000 x27: 0000000000000000
> [   69.508992] x26: 0000000000000000 x25: 1fffe00001777601 x24: 0000000000000004
> [   69.509017] x23: ffff00000bbbb00c x22: ffff800081203028 x21: ffff00000201aa08
> [   69.509042] x20: 1ffff0001150cfa6 x19: ffff800088077970 x18: ffff800089386ed0
> [   69.509067] x17: 0000000000000001 x16: ffff0000d1660de8 x15: 0000000000000000
> [   69.509091] x14: 1fffe0001a2cc0c0 x13: 0002000000000000 x12: ffff6000022f7620
> [   69.509116] x11: 1fffe000022f761f x10: ffff6000022f761f x9 : ffff8000811fa7b8
> [   69.509141] x8 : ffff80008a867c18 x7 : 0000000000000000 x6 : 0000000041b58ab3
> [   69.509165] x5 : ffff70001150cfa6 x4 : 00000000f1f1f1f1 x3 : 0000000000000003
> [   69.509189] x2 : dfff800000000000 x1 : ffff0000117ba800 x0 : ffff800088077970
> [   69.509214] Call trace:
> [   69.509223]  kunit_test_null_dereference+0x70/0x170 (P)
> [   69.509246]  kunit_generic_run_threadfn_adapter+0x88/0x100
> [   69.509267]  kthread+0x328/0x648
> [   69.509286]  ret_from_fork+0x10/0x20
> [   69.509316] Code: b90004a3 d5384101 52800063 aa0003f3 (39c00042)
> [   69.509330] ---[ end trace 0000000000000000 ]---

