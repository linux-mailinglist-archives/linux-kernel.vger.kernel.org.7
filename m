Return-Path: <linux-kernel+bounces-745322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D2B11864
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FC91CC51D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E228507B;
	Fri, 25 Jul 2025 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DbQS/Ei1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rYTns7yM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7502283FDD;
	Fri, 25 Jul 2025 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424301; cv=fail; b=uHpMhr/ntB+spwaCoIDIRAsDOsMtmkp1OoP9Q2o7wQbDAnefR73w+NjgmoWSPcJUnmaxEOadQd6J1LBSealkv2c9LiDdQX7MxsqvU7vUwRWKPX+hwYXs0uuIDTikgNcmU5Zo0CF1TWFo2u1laDC4sVP/mw5pd09XZV/9gxbXcPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424301; c=relaxed/simple;
	bh=qOxyhm7yIyzH6mHXYP4G5+2O3gBCCDz/ICLuh4KltHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UPTqb8uHDFuy9o0jrcSGLhKE4pdEz4Jh8YnrzXFsjMVi+J1zikgMHHzA2WSERAGufaEt2AoFnOlxzQUuWIQQUp8EjD9JESJbiw3+FZCIDocGb/0DToQcsJbln9MrwAUcYcQOHcn20ONyjtUN2Cyd2qbUEuBv9AUuDJ8p4mY6QOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DbQS/Ei1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rYTns7yM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLji2L004419;
	Fri, 25 Jul 2025 06:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qOxyhm7yIyzH6mHXYP
	4G5+2O3gBCCDz/ICLuh4KltHs=; b=DbQS/Ei1xi/JDuxfTFKwQBhH3qBWd7i6zX
	AUWH/KrpMdxoAHLyqIREu8hMd3wkXlytEK+RUGn/XJgFCqpfqmBVkCrEq/K0Vun/
	7n9q0FeKAlTJhSlTa2E6evkufzmQ5YH3ZJgCveNwnUtO+kaYouIyZbqKhtfVDb55
	JttABQ/wHIbz7y5lHovBRXeV51M2HSXez6ACeTp+GXsKUyuVewax0Ed/B2KOBNt7
	P1XAe0V9RLlo7NCLEysiUTReYwqOgWtGAbmHX7EwQuA5lanvJM6og4o2aTFISKnN
	F1+GG9eJerMxm2DVyavqnG6IQPLEYQ+Rzw49HxzsrQzEoQZQGPrw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1h0dgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 06:18:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P60qqQ014457;
	Fri, 25 Jul 2025 06:18:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tk1vhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 06:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQSmBIhT6Irux4DGEXE0M8kOXDd6BcPtdD9zmHx91rpUjkw2chDHcSjeanhq/I11c0gMc35Ltdji6keQKmOd6WenA4GEiDftdK67NpLYGC0TF6lv9cV0dJhi0bz+NaeyfZ6BxUahWS1ckSlCUfP65MRVZDb9nu6YCIwf8dCpz7hBXvjg5rseNgWTgtohSY3cDeRp4pndBk6idNQ4Q5J0ADbGo+ptJfO6zTVzgJXuqj6GnqyY1WQOSMQeozy0itgwYHoS+hWtEHt9bKVdik58UXaxq+fCVKDSOjfuMMNyIO/t3H1oTJU1cJdcXS62WWSdoYbj2Ekz3RarxLY4TCRaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOxyhm7yIyzH6mHXYP4G5+2O3gBCCDz/ICLuh4KltHs=;
 b=NEXB9Hc0pBPJ781ZxlfFzEO9WF7u4HcTMXDMzZp9qIkFFu2f1+D3t5QErT8c4qav32tJnuvt4AidSZhbVVxGZPNxuc05PntFo/ZE1xIQIHC0c9sgwIrFjlh+jU/Hhb20sp5YDdJ8MispF6MZA9AALONvePzK7CJVVAy6WFPD7bK5vOQlZHcrNW/IlY1Hn0SjTxVRQMngxUNl2b0VS9wJNcDFR7eFCbZLUY6o2CRoGzeil+Fg05bMxwRfp9yR4nlwqKbw1Tn8Ux5fxoVlKIGxtJNxyW7oEHQ1pxdV5NsofbD6Nnr9wHUD8ajt0MKSgn4/nUJLvPgGJC9MwjsO5IlMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOxyhm7yIyzH6mHXYP4G5+2O3gBCCDz/ICLuh4KltHs=;
 b=rYTns7yM/oKpK/SlSDeIAhxrMqnsGM/JmHi5eGS8bPcoGljMnzp0yScojEo93ilpa9kPQVox02FnK+Z16E4ZA9LoqpovBZAYvl8VwnrjN2hDpxgEiOgs4uzemIquhWbLXmhFICIbPI7zqS/i+alfy2eR1xoT/NgCoNXN4ZHgbX8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF3AA48E9FD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 06:17:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 06:17:58 +0000
Date: Fri, 25 Jul 2025 07:17:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
Message-ID: <b1b5470a-358d-42ea-81e2-28b7684dc172@lucifer.local>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
 <38ed372a-4b27-498e-bb3b-f95792bbbe27@lucifer.local>
 <9c861191-ac9e-4d26-b2a2-1facfa45de44@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c861191-ac9e-4d26-b2a2-1facfa45de44@redhat.com>
X-ClientProxiedBy: LO4P123CA0412.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF3AA48E9FD:EE_
X-MS-Office365-Filtering-Correlation-Id: a65abf63-9bee-4a96-44fd-08ddcb430078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7Sd+pAqDauHSDFlo9TC2HJNAZUm2vp9O97ICGbCzCwiXBNSEGGszwL40Kp2?=
 =?us-ascii?Q?8hbepxPvHlruMcEIaXzmmcYgAiaMh47Jos0iEY3QkI8NFFKb5fQkNo30/E0p?=
 =?us-ascii?Q?WaeTcDTd5hcmhU+/Iiub6fFhD6xrdwJ/R7Ag3CrJrML8eM31rusamWPanbJ2?=
 =?us-ascii?Q?q8lwMGxYlvp0YC9xTRz6pHDEeU1oW4mp59jJW0NCqxJzIGOfwU4Cqen4lnOh?=
 =?us-ascii?Q?TfQa8ptNzwTtvaNXAYx83U+tRqwMJo7q0Csf4VAR42UMnD+yRMGon9dct4UB?=
 =?us-ascii?Q?RdN5LBXsXp+qyM7MSMNoYWOdvPl0Tqyj4wSlymF5UUPE+ZUo89D6egBQOQXz?=
 =?us-ascii?Q?PPXe5vyV9BIYEE9crNouefzwkg8wbWk9PgCdutOTONdtEVMG3JXI4v7hS/dO?=
 =?us-ascii?Q?6vB2Dws0WhLZc7QV+gXowrApQXROF3ZItqnmd0LjmcaueeLKp5RTHhoBaT85?=
 =?us-ascii?Q?hfw9fNgeDF0FX1fEZVB6lpU7vJePCqxhvY7fRVgy28CG1E2qaN4LDqsKPjTK?=
 =?us-ascii?Q?9/FMKLiPeDqDHWAccUvz5lwL/pspJcJpWC+GqljqShVy874qiu77gTZfxUJx?=
 =?us-ascii?Q?9DYALXqS3YLWmaOJlOHVuAzmq/9zDBzZBsZzGI5jJ8LL3lISrVPNLRJHlVeC?=
 =?us-ascii?Q?5FMJ2gsBcOCCa3Ieu5eI9viatPUAGqDYxIp3IU4OCCBM9JBsh28so2bV3Yqp?=
 =?us-ascii?Q?4pY0bcYKoHAGYqU7Pg0ZdtWrE0qhuj2CxU0lW3rOdQDRWph+GP8dtht+Z+ne?=
 =?us-ascii?Q?6Xlr2lTApETmmrQ35pIyQxLmRzQh/LuTDGp53XNCfcPcsp3gw/HYQZi8B23f?=
 =?us-ascii?Q?5OKtDcvn/0JfdfkacE3fJDki13GVP/VzYW/sudNioGKVHEkEmFQN1fJKuIcO?=
 =?us-ascii?Q?vu1185ZivvHoULvyQvyfF2qxJnzJiDrNScyP8KiaqtVrU5DM+UgmW0KYDkkJ?=
 =?us-ascii?Q?8sqwDr8mWC3/wTiwqeow8JbP7lxvxq9coO6fkGyszv3uligmPHuwvNZ+roIZ?=
 =?us-ascii?Q?zqziea/vYPn0svmEIVoGDHYirOf+ga4B5YQjFbKmZxAI7xgvAeiYLQ6dUOg8?=
 =?us-ascii?Q?CEDEoy5Uuf7OSZei2WsPPmjxiSOQBHm4oU8gBPwnLZFkR9RtMnfYoE4sGxkQ?=
 =?us-ascii?Q?wZRsgbR3u6k6+vdDR3i1WScpAsl4kHZsMzjEi3fR0J+yu+c3SZZ/V64+Cu6j?=
 =?us-ascii?Q?U090GPcsj6dcK8SLMA1WnsZpQtqXkzsVDRBnMK1JROC2/BuPRKq+nDRY5APs?=
 =?us-ascii?Q?C5o08BiEfSMk8U37M7vEYxBXYKBnN+9zeLH7vlAzH+sYs9Ws+r3StUDXFgux?=
 =?us-ascii?Q?ifn6kEzlvBy2jIMLk8jDp56db50FOv5mo8N9nZVR/Oj6FhmMtmrWKiyeP/Dd?=
 =?us-ascii?Q?d3G/EI0UztIbXA7GOc8Ga70KT2d6rOQXa6ieAtkYH6KilF2xMHOWGO1xFRhA?=
 =?us-ascii?Q?fRTcB03mdbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eeyZXlg7JQb246OEDtFn7t9UEP5OMk3FAJZiWnC8a9gv0nc0S9TWxtvKFaNi?=
 =?us-ascii?Q?IcTvv3ul7s08asx0M537RKVf+RPOl5t7zK3Dq6agEiX4oicBd8UWezdXFfB/?=
 =?us-ascii?Q?eHQNvKDp71gOMbohvGYmhpLDpgjvoNlNynlA2v8r1ZqnujM7Wqn090zp7Bof?=
 =?us-ascii?Q?jPKDbwHPYf7a7BkQOgSl7rmaKj32kDT7El9i/tk15zkE6RHvBjyfWtbKJghl?=
 =?us-ascii?Q?rLhE671a2tpAk69XkXJxOdaapaD7Rm0s+3J7Imsp53t6t6VZrSwbcHcKv8bB?=
 =?us-ascii?Q?U74UU+O9LYo1xT8lK392QRWCZZ8VlMsDFS0Bh6tZrVRKf9h70Z6GbpLoO3D8?=
 =?us-ascii?Q?Tao0PrsSByq3IDdX5x3FofCkB1j1Tjj+GPOB6KW/NJKBDlGepxsS9VV7brDP?=
 =?us-ascii?Q?WYQKRmo6mTKUPUJWt6dsPjdoR3OD1bWhY4kabnqeTjmayrMOLkscpegJjvy0?=
 =?us-ascii?Q?0iugwysxgJkR5umwQh69OFk5qgHQQ9icutHTMdJmzgF7brImlsJiApQcKPup?=
 =?us-ascii?Q?iWYt3i2Q2Luo6rSQ8ZS1Sc8oyASvgNeDasTb7g2vtftks+CP8dnBR6uGJxV+?=
 =?us-ascii?Q?MPhji68eTObf/a/0AKs7VMWT83lAh8m2xOeSrVXYCyKxCDBUzT+ROETEte95?=
 =?us-ascii?Q?BILQPEGlDIIkp4Q6ROMwL4sPShoBivyH+yR7A2HPz8hJG6MZ5n26q/SHddbu?=
 =?us-ascii?Q?jHzH9QB9d45ufKaU4aUjXzkKIluuVSfned2bOlW8yrTBmkJqHppNpmnO+Bai?=
 =?us-ascii?Q?HEUjgVLnxDcdae988NV/0kxKdYC5YJOGe/AATmqwxohBr3HBtiK3WWIsblLD?=
 =?us-ascii?Q?AS3C3RzLPsJjWblHSzD6lfl9kNyCInmkYKncy0TOsNJp+0OUi65Ktv0yhPuH?=
 =?us-ascii?Q?07qcROQ4pcLJGRRakwmdchBVw/TCJHrIA43fI+72Pw+/uJ1Y061m5HGbCWHM?=
 =?us-ascii?Q?/fDY/O4fHjkZX0xbDlxpqNu5U/klBtGas6tfIaHCCdBmJ7UAh3lEFrEhB66/?=
 =?us-ascii?Q?XBPP7xHcOqRwKw9d+lhCSZdRMJJw1io3KQCLvZLVXCWrJjMMZ+4e0S2vq3/e?=
 =?us-ascii?Q?GsZSTjxP/Ij7vdNLDWeClpqlVwYSCZ3aQ5YK++EjfGZ3hpzLAWpXuIQT+Gqj?=
 =?us-ascii?Q?kDkn3pprGolb0Bws2UW0IRS6lg8a8AxnJO3SoZNF+NRYaP9h7Bm8NP3pTnH/?=
 =?us-ascii?Q?+3/X1s9zu3ZGHdXwGB/Jl7SPDhI8LuPQZY5lSKke9G1mJmMc2lvtMxHyPFiI?=
 =?us-ascii?Q?vwWsR78OLmlXvIfWjG2dlcFrjgFK8rlwRa3jWX4IJAWhjbnWqK2aHth82ZWh?=
 =?us-ascii?Q?cxmYPddqhE/la8A1Eiptn9wF9ektHdPLYGV5Xc1WXELFIXO3l28fn9W+J/yf?=
 =?us-ascii?Q?vpBpxjrGYQhqhAn+x9z7zrrouz6ku4DMVXpkpOVuQPtGDufAtRw2VIlsGvjA?=
 =?us-ascii?Q?VlvgeDtJUzH6ON+OqnWXy8zuLDYBxaocSbCNPeTSWAV9rPKi/qEsKn+wzcjV?=
 =?us-ascii?Q?9HvdCPoSRQ/e5LQLg4xLx/CawMb+9fT4Qcu7fzyigCxuPs7kw4zkT8LuaFlP?=
 =?us-ascii?Q?axPtvZDSJ+EG5ENp59FOwxtk61b8PA0iWFdkr96K9xmevreU4Vz3lMp2ImPL?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vWtr2+cuyBD3PPSbxqy/VkawWQcw2TwtWUsid/QKPKEY9HcZXPe5/UmtiARY1bA4G8cA1eyAIrOXBmOGpJR2HJePF3Ud+HmhAZ1bJqdCFMRFxK5Nel9gxdT6f5b7Iq6EPIkINaszM8OsHkyzZYwf73LYkVIzPZgR0WjkmjayDaPjEQFfr0oSfh0OmUQdmN5XVggxinnYAu3yQFXnvpfp/XKuabuU62BVc7jUMkHC6jUM0QwmPBF1M/96G1FjByUHQFXLMij6RwUhMWukPmjgDQVuog1qoaLcryNWXf5B9nhF6uqy3kY1k7aTDhUJmtC3x5hTcyUxXvCCP67ubF+RvZ8S7FO1pKXllo+E31IYj9eCcZOZTGvcGMGevpAk7PxLZ/NdAE9SSa7KwC0+UrfBCqUfbxYC4pqKItbJEru2u2/wjsPhKZpRahLqdWPyw/VS9eMy1NqLTNhyJSgyiC5vDwn9Xz5MdbooH5FxL3patiDBx1VLDe9VjYXJd0VWBqMoeMRMJTIo627zpQyg1MQuMLSHBPFnCla7azP9E3z5JYPIuzNKFiRxN19LsHrQirJ9L4IzqR3uZTubGp5viCIHpCfCkEBC6ARsewTz0968jm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65abf63-9bee-4a96-44fd-08ddcb430078
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 06:17:58.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3QHRvRPmpCKhKIOpySsVqC25TdyXcPnT1tSZDdLutB2wJz86fQ05HUMosLne+m05USln64MMbOPj7O1JsHEZDzcwyYK5wnJ8yczrWSwGRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3AA48E9FD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=803 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250051
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA1MCBTYWx0ZWRfX1NohxPJaj4Jz
 a0YNb3Vh+ozG3cXhPy+Z99Z3crPs9loloCTjZTzPs1wHq3irdRz5EtxJyDJJiVprgEyrQpeNsJl
 aZundzG+8bJL3mCv3slQiFqDZXoco38L9HdNstbQlCbaTXmc/FyvCLzt8fTeAJZSgO+EYQggLoC
 d7obAakL0bnKGzK+piiuUk3fq58KgGNol8peZe06Ca1QxIoc01EkWyHXvA3yk0jDG5aXQY0UlOj
 OUfsVscyYtjhZhsqw85pG0FfL3Qc98IMbcfsLILQVHS5o6QRpj2Q/szcryt2uno2oilrcW3awE7
 1teypIx70MRDKUr6GPZujFHSgpaXL+ZYgrQEScfyyEuEVIk172PwZDnLYBLV5tbnv6zcp5XTrNU
 R9Fj225IRJw5sJl2p1X8KIglwO+FD9cgQBbaIrW1isvsaE3W1Yr6CJ4PVU3F3YoiIn+4lcSr
X-Proofpoint-GUID: uI-SfoUfKk5U3QcDVeOQLNZ4K_VxSK2F
X-Authority-Analysis: v=2.4 cv=RIGzH5i+ c=1 sm=1 tr=0 ts=6883219c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=e5mBPEI0AzEBwLqayWEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: uI-SfoUfKk5U3QcDVeOQLNZ4K_VxSK2F

On Thu, Jul 24, 2025 at 11:53:52PM +0200, David Hildenbrand wrote:
> >
> > > 4. We could ask applications to switch to non-destructive madvise,
> > > like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
> > > switch the kernel to use non-destructive madvise implicitly for
> > > destructive madvise in suitable situations.
> >
> > Umm what? I don't understand your point.
> >
> > > 5. We could investigate more based on vma->anon_vma
> >
> > I have no idea what you mean by this. I am an rmap maintainer and have
> > worked extensively with anon_vma, what's the point exactly?
>
> I think, the idea would be to add an additional anon_vma check: so if you
> have a MAP_PRIVATE file mapping, you could still allow for MADV_DONTNEED if
> you are sure that there are no anon folios in there.

OK this is a more coherent explanation of what this means, thanks.

In no other case are we checking if there is data there that is different from
post-discard, so this would be inconsistent with other disallowed madvise()
modes.

Equally, to me setting mprotect(PROT_READ) then mseal()'ing is a contract, and
adding a 'but we let you discard if we go check and it's fine' feels like really
inconsistent semantics.

We're dealing with a real edge-case scenario here of a MAP_PRIVATE mapping
(which means you are essentially asking for anon) being intentionally marked
read-only then sealed.

I think it's _better_ to be clearer on this.

>
> If there is an anon_vma, the only way to find out is actually looking at the
> page tables.
>
> To be completely precise, one would have to enlighten the zap logic to
> refuse to zap if there is any anon folio there, and bail out.

Yeah absolutely not this would be crazy, especially for such an edge case.

I'm sure you agree :)

>
> --
> Cheers,
>
> David / dhildenb
>

