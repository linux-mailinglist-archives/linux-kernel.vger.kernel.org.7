Return-Path: <linux-kernel+bounces-751173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A904CB16607
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB5C58161C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630932E2675;
	Wed, 30 Jul 2025 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l19BGMYy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YXH+dnSl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BC2D839C;
	Wed, 30 Jul 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898696; cv=fail; b=qmn7YKqwh2NrS/QXGZU33N7SnIj8H4jvlnJZijK4AXB1GckOppM99K7i9Wupc3/fEDskxMzJCsDjNsS5m/vIkhGh8PDcTLPL6dUaM6JGp3yw5ZpnijBmDZa8yqvPXcFsIP3ZLgXEh61hz6TZGlkBXzvUzfz1bWH0PaLmU/mf7eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898696; c=relaxed/simple;
	bh=763IKNuA60QDX+ihpS/hmIYV0ftHR3mxeoex3DUmcnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H9zTG5js2tflvDzvV+Y9V+Pdsdgy9rJuPjDAER1bth/Tgir+396i8URZgn0XCLtwacbt5jxyklA4SBuJapH7WWbs1TbXzgYdZkcsI48oGPtmBMQl0wleqz5YVnYc1WD7Z5IDxsZi/V5YreeJT4yXklenFc4SgESjpI05UhV9Eo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l19BGMYy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YXH+dnSl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHMx5Q002347;
	Wed, 30 Jul 2025 18:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=763IKNuA60QDX+ihpS
	/hmIYV0ftHR3mxeoex3DUmcnQ=; b=l19BGMYy53qq8ZHRNHmX1BjFwULpXQO9WK
	RsA/zSt8cmdR4F7e8xeUiYqiM4PXFmxhTnVQzkYwVMAQSEssceZnTUF8GTehmrB7
	MdjCSj7lDhrAE/G2VyXR68OzCPU8UgfAvQhiCxoPZe5Xay/3B2fFGgBd/dSaBXF9
	y/+Q1ae6IUizRqOywWuZhiQdWNcTmz0Ahr5hQLKp3YDkPDLn/Yrrp4Wd03EcrM3u
	umu/D/SmDxRPLUkZk03X9CIjA9NEvv5KAQwqCS2fZcs3smFNOakmgug3VPfMPvgc
	G8pZ8E9+i4vEmMCfyhOeNqLkk/4BgWUh7j+xgMEyRe4kgVsDtwFA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q732hs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 18:04:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGh1g6010421;
	Wed, 30 Jul 2025 18:04:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbbc58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 18:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcXHVejWcLNl4aUA8FDGl11vzWssyIyrE224LEZpt+pGYWgn2+KdmraDmyrJTl7PZS1KurEbKwMoNV+yBlG7pUr7bu146yLlPW+lagkfftZZCbuNS94UDndsGybjVx3SE/FhclPlUw2APnVWbObYEKJxJwLXZKoD1/4UBHgyQqiEAnHJ8kga3PuHbJfppSarMpD3bLg0/xdldVCQu6v4otTH//Ukl47v0Guni3sx//Dq6E5cfi55vamiwKFrur8bSn0MahYmrDCnkRcOj6USAtPzlYEfWX30wF70jqIoHKdfOx8RUpGX9nBWUY7XXF4JeiYodLghWexfOUGEr+Mr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=763IKNuA60QDX+ihpS/hmIYV0ftHR3mxeoex3DUmcnQ=;
 b=QUJb1Fy8Tbs8Ug7FSHLA5OCIacLSVklerWLhx5m1dDHZXTgFihw+kJiKLj+qc04BfKg9gl9+k+CJFc21b0iqVgX92imhqQqhlvQ0aqDo8C5ozWMhcbL8YtfnwfhzZWfoHpFQ79ytNZezO27DqwLkp2UVZXlnkUwjOvUdU04bph1u6kBsq5m/P0ypYfnV278gMOfgfrB0FuFDRVNQodkUJsLJ8udZyQgqETafv/oWblA4Yu2bNNUQZhN6sh05+MM4fvN6YHboe8S7CGLl0jFgWTjaAF2xEYACDWEmIrYccclf4Xr8pGpq4Sz0S9jgDW13JWzmOysaSc97+8sSQaZQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=763IKNuA60QDX+ihpS/hmIYV0ftHR3mxeoex3DUmcnQ=;
 b=YXH+dnSlij9/J+EdGrksvQ+qU869GjqewUdGIreSJ7unkWO4HkDAAWRyWQ7IH/e432Y5G1p07yAkQKUj+h8Y8oaAODXwzbeJP0N/WXXOSRhbyqKztGO7NxbLMJCG5mRfUBeP0nEHESKWRZBgM8O93suGQTeLxllSKJdDFiPpWaM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 18:04:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 18:04:17 +0000
Date: Wed, 30 Jul 2025 19:04:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <sashal@kernel.org>, Greg KH <greg@kroah.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <eafe2f1f-c8f4-41d4-b590-94509093eca3@lucifer.local>
References: <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
 <aIpSlhPTC9G1AqvO@lappy>
 <eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
 <20250730133220.6e7e9370@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730133220.6e7e9370@gandalf.local.home>
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2291425e-30d9-439d-67cb-08ddcf937ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcWy+BPItI1YXjIMzc+NUv2WNCRjstYFi4918Sniy+mxlxBGgN3moaZwwsQn?=
 =?us-ascii?Q?++CYdpdvlakVlXJ3GY6dyFajCzFGtX6UEswT8zNMT1rnBclXgsnDFhwHjU9K?=
 =?us-ascii?Q?tHRpI4thypVsrdiRUaMC5KFn+Ayjl5fBfgCuDt0PiEFZ1Y8RAMBPdP0zBG5j?=
 =?us-ascii?Q?7peKFMg4kth9TmywZOh1Pu+MX89GoRRSkuAYuZHZr1AQNDLADs5dbio1vnbh?=
 =?us-ascii?Q?Cjsf1evptH6+BOwjAgRwlqp5LQzgNdru6laWxWlNdjiP8yOtYX8NWHYYNlYG?=
 =?us-ascii?Q?KpBVUw+hO/DvX8MwD1Hdto5c31AHO4ikjaz8rvbjBX49MT08DjjCvaWydgRK?=
 =?us-ascii?Q?cy+qD3hIrQcKVydadioJncmAXruMKGSd/PpiMixbtpoF84VUjgESyVVs+ofp?=
 =?us-ascii?Q?nL04JY/CBueqHAx5bNZuB/y+yARdQ1UJXMGVGbRXn4qmYxTzEVuTld5lrSqd?=
 =?us-ascii?Q?GCZc+l6cGC0hw13zzu4PvrutgVKkeTo6mXlb8bEo8EfBckXKapjHZ5yxvBDT?=
 =?us-ascii?Q?QLe/8tzdNuui/B+J6E2J62EjNiyRJiRgkgryfFjVNA40w6t6/99clynAuJLr?=
 =?us-ascii?Q?YZf9wxFqdBFTB+scOcZ/4JRdVozxn7AJ0cnG5SFKEYCX8vRcu1t+Wh4fBFbj?=
 =?us-ascii?Q?oNBtU1qLtQSgEdm3INUK4s/xu5W/FXrlXrdyThhAyaEKxVPMzqxxeWUP+6P8?=
 =?us-ascii?Q?AtWYkTBmjv95c07NgVadpfQiIhno47kYJ/y+ro7vxlcm4qQhjTx9X4FFsqdS?=
 =?us-ascii?Q?eq+pTmxBRjM8TAle3zzim9TCDuI8OpNMeUJByP7J8r/RI03yAXSBswnWJ65j?=
 =?us-ascii?Q?ifC7UWzhGCmvERwhjhBgku0d5Kvc9bp5iM8sAwkgMteQJQSzlHfUiORR7Usj?=
 =?us-ascii?Q?UWvd5V+S4xNqeyAC4uakDX/Ebx/hNyRoNHuPjROC0JXE9cBNiHLs4k++N7yk?=
 =?us-ascii?Q?JKF4wTaVa7ZB5Is97t2Hf/swu2imOuXYnrdTZ8svtHc+z5lm5En5LCsCgTPa?=
 =?us-ascii?Q?UFc8Oj4Pis1wcER9vQQN583LKqFaYLZOxu3YgYGY56k//AzeEgg1Z/+C+P4v?=
 =?us-ascii?Q?D/WvMngxA0cKMfNdNK1ZZ7eSFSrEW/hQZmR+lhr7U+HMQfief/cgZAWnOmqN?=
 =?us-ascii?Q?6AhF2P5fuPmZ8USYLilI0JCAVmzsk4yDrjF5t4tmK4WVuhg3hCG8bgjnXVzM?=
 =?us-ascii?Q?7IXxcokBORNVYeRuVBBzi+Z6H8dWnCa72mEjIN4RdBgzTy1EHBiAQRpZT9Nr?=
 =?us-ascii?Q?THYGySRQ2eZ1bPI6AN6btkriSdvU5+FH+2eZyCf3fnTsr9ltM6WURuDmBT28?=
 =?us-ascii?Q?wqXlf+yl6pf1llsnLU7x4TYRcp2eO56JNLYkbvKxIh/8gDVLJP+4cY7SGeQ+?=
 =?us-ascii?Q?DaXBgEcamhKz/On6E4C4p77RMSTv1qJAwrEse9+XSrqFp9qgCCEOFADXHixi?=
 =?us-ascii?Q?a+1HyQ3PuQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wk0/cEBB0ZwSnFTaj3TxKSgXUWgRYf7HbRo3vHgEaiwsrCB3N3GVySbsCTU9?=
 =?us-ascii?Q?ma0Fg3vIplVsiFYeful+BQQ+05Mksw1ui19gJZKg4a3AZxZ1QHzLCDt/1FmH?=
 =?us-ascii?Q?GlbSBjUH6yJ8sKVtMyEVpEOkDclxn/sXX6sC7xJDkP/mEXi2PTseLc5Ki7EC?=
 =?us-ascii?Q?KeIDXOH8Il9+2Q/Km5/DPS+8Cf/cWFH6W4Y8fiArsiHLdie+VLCQUvB8exar?=
 =?us-ascii?Q?HM0jFAETtgZWEcUFtThRGWaKwFd+/znbxX14cK5riW+mNz0HwjvOj1uxOd6L?=
 =?us-ascii?Q?NVTyQcK/BIrK1xlqW/TjlxRA0yYcbkVarUlczRctTa9xF5WiZNWpwj3cUpZe?=
 =?us-ascii?Q?43X5UJ8156Xu7qXnRFBQY6GC6bBdLr5a7QbMgAD7FCDP9Kwv6C5PXVLJff43?=
 =?us-ascii?Q?vVPyBIF3n4k/Fqqwwgk7HREq9siKBwC2K3hr+1oArfV3T4ZWUAdMRmmV6ye2?=
 =?us-ascii?Q?LIAvc+59C2kwu0Z14P2XtgvYyc6NxyPkAIGURpJBWHnlKwdE6C3GE2MJ/PrD?=
 =?us-ascii?Q?x5EE5BjCrgBUTO/9zMjjtguAUtZ+ak4GlO6KbLIHb15YS1ZtDE9m/HRJHAL3?=
 =?us-ascii?Q?an7uYYpnOLj7ssSxTskvI3DEkPDzKZJPzC94vWkRsZKneTvnk3kJOhcZTDBr?=
 =?us-ascii?Q?yQs/rb6vXBlyMcO2REQkow8+tjyKQWTrf9M/VQg1njQXxEXPI5nMtPyuUhTN?=
 =?us-ascii?Q?PfqzgbwdrBE7OtYiCusQZUhXu2LBM1oLAyOnL4IsnfufWNgcAb+3tU9eC02K?=
 =?us-ascii?Q?pw/6WW2fM5TPFOXoJ5mCAe0QFiAysLley2B7zvuiumqHI1f7qfvo0ORo8gY0?=
 =?us-ascii?Q?DxfCCEWZavfJPWnyMBknbihZvbGbilv3UgLx0jqvsO/b7alQjGkpUAJG0SBZ?=
 =?us-ascii?Q?LmoMO1iSmuMYC5R5Fy3P/vAsUNoCHJf/q8KxLMCX2uSeWk/4a3tCyDfhhvY9?=
 =?us-ascii?Q?ZxARrjjtPNb/fL3mZWBQuK0VYzyGV77n08kk/zAn1LJAqXWgW88bA6tz/oc4?=
 =?us-ascii?Q?24I6K5/iJAdcEoE+DM7hEIaFyw8GZ4u4zce/jR/xLkOWa32h0EHVkBcLr5Q/?=
 =?us-ascii?Q?j2f9eBzkZJY/UXr9pK1OEiL5Uc75K9Lsiy3AU7In50fSADu9j4pZyU6hfeJZ?=
 =?us-ascii?Q?yC/HEbIme6pSkxusTFzeiz6zekc0gorG36zpeUnRKSzwznMAgovCNJ2GUz0e?=
 =?us-ascii?Q?khhd99PJ20mEaQuJrj6xOKz76gF/tm2ye2TvF0j9kzSlNCjpJmbPSJI50+vs?=
 =?us-ascii?Q?8i9k57BILu/VL2aZKL4+AY8BPQ3QyGDjS8AuKKCoeWw0Qy0isMpH9m/O5sSB?=
 =?us-ascii?Q?v04J2pw/r9vq2UdMeOmu8LfZIHf9S4RsoPP8FJSqRhG2c5uwQcExlQM/mr/e?=
 =?us-ascii?Q?eGsvH03xR0xEyBivyAwO1GoYATD4EVMql22+BA/rE9+SN5esqrEvhNNlQ+vA?=
 =?us-ascii?Q?CUCQT3woYZA5N3dusF+QI9IHg9EZDuIK4vCt7yna+sklFbGzA6uFa4OZVPsA?=
 =?us-ascii?Q?TAg0ti+ZGNbeIvhHRTlKG1QrfkcPFT9oPgbxqETMQvYhKW9hiGQA8WbxvNEy?=
 =?us-ascii?Q?BoTrxj6AqA91zxynTj489GAKTrlMqw73MnsMsJIJwWWfwXMv2OEQvnFNs6Yd?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F7DVV8im00d/l+jceQmxDgq74lTD7v71ilZYM/g/m6406uZ3XD68MJtfBIa6/qysrgSxGgOUFLrHiOsCr02Bkzgm/tzLDS4Fx7yxoucj9R5WkJNZlvzKO/uJ+MJC/oHNrlJU9At9fMEFJ9k+k/l4x/O6aA3dvtUmOvUM1HK98UuTpibR0oObCw8eBvmOm/LTH1qJeQrG5pSJrGrIOyCwjsQ76ygHUuQVlAhJhdkOUC46L9D1UMWyJ20prL4XrjctMo7KkxzAvnGt6/MthOQ2M/VctSDq7Fm+vq3uuZcY6of9OVOIL/TW9nL2laHRDh+tXJRaw6hfeQaV91KTUCsn/u0IlSTCJsc7IOw+qJGx+UDcFPeLYaHnYpVAneWlDNcJSnHZvalt9U/B5gsENYC3MSEAIcjAyVVBVzXWW2Ql6rvfcT0QiLZemaJUtaJL6XoA3QcYV1zHQj7JtmTfJJ7V3BbZD17jendZomiO8gYycP6O8fSSkfe+xbNuRzsqAzIau1ipdsa++fKE5SWtCMUi/L493uaea52QSRhCV5dI5tCC0QRiK2KZ5gmfnPo46wd7KLHGQZ+XBh1mJbqVsNiCeOpNPUFxQoicrmVfUjuIEgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2291425e-30d9-439d-67cb-08ddcf937ffa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 18:04:17.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro87BxIMnGmvazhfLnUnT0paddhm6KDFKHmrJ5P095leKt6YRstHOHGSKcb3BUFHQmsBrf6ttp/ceJeYm1J7b+UKGVRLZlXYNwOKMurxq7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzMiBTYWx0ZWRfXyp+E+04nR4tb
 mnDKdH9K34yktmDUnHKejZNeNH6IHLj9S2kUr+Ln12gVOCWgMGS8Syha9LWyHrTJFNY8St+wx1Y
 Me1airiJKhzO4a1Hfw+332yNfwk3mxdsxWBxJ6l1d81hoOaUVMQwHONdCXrUqJkPhHR5N+iswYQ
 SVSlHbylvxllXESsR1kM1hNWIdBdOjxp3n+C8u4ybcNpEvEM6cOmAq5rVBVqkU5VFAmbI+l7yg5
 ROPbtlmoQ0R7vJBLMaH0/pA7ksmPvfxIut1qQ9xDzvDP4JQsmBVRKiSjsvwzbL3wc0kYX58tWNi
 aXN6fDh3Haq+xvTrmxxsbHzOl4golisieWNowrdtfXRV7Bv2F0QxEhSKSXS9FNNnvGVCtV2fS4z
 o+EkJXFVC8yZsu3cLZg0RLjBWtd4dr64y1ljoLUfhE6rhB5QFLMCOfYLPxIaY9q4BaxMRiJU
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688a5ea4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=PxQgCdHISfNXxvFpDJ8A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13604
X-Proofpoint-GUID: F0x6XhrP-jpYw_cCA4R3hgMakHA_hp0j
X-Proofpoint-ORIG-GUID: F0x6XhrP-jpYw_cCA4R3hgMakHA_hp0j

On Wed, Jul 30, 2025 at 01:32:20PM -0400, Steven Rostedt wrote:
>
> >
> > Assuming every maintainer accepts AI patches unless explicitly opted out is
> > very clearly not something that will be acceptable to people.
>
> You can opt out when you receive your first AI patch ;-)

Yeah, there's just no way maintainers are going to be fine with this.

But this is why mediating this via the maintainers summit is a great idea -
let's get that feedback there.

And if I'm wrong and everybody's cool with it I will happily eat copious
humble pie :)

>
> >
> > Assuming an LF policy most maintainers won't be aware of applies with the
> > kind of ramifications this will inevitably have seems very unreasonable to
> > me.
>
> This is why the policy should just be "It's up to the maintainer to decide
> if they will take the patch or not".

Isn't this just what review is? :)

I mean having a tag makes life easier on this front, but I think we should
be as conservative as possible, and in my view that position is to default
to not accepting.


>
> If the maintainer starts getting too many submissions, then they can update
> the MAINTAINERS file to say "stop all AI patches to me!". Just like we have
> an opt-in for to not be part of the get_maintainer.pl "touched this file"
> with the .get_maintainer.ignore script.

Again I really don't think this aligns with what maintainers will want.

But again I think that is better settled or at least addressed at the
maintainers summit.

>
>
> >
> > You might suggest presuming a policy for maintainers is inappropriate, but
> > you are doing so wrt the LF policy on the assumption everybody is aware and
> > agrees with it.
> >
> > That same document says individual projects can _override_ this as they
> > please. So the introduction of this document can very well override that.
> >
> > We at the very least need this to be raised at the maintainers summit with
> > a very clear decision on opt-in vs. opt-out, with the decision being
> > communicated clearly.
>
> Agreed.
>
> >
> > It's maintainers like me that'll have to deal with the consequences of
> > this.
>
> And you may be the first to opt-in ;-)

Well I'm taking no position on the issue at hand, more so how we do the
_policy_ bits, so who knows ;)

Cheers, Lorenzo

