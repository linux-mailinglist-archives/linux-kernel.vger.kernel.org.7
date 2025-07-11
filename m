Return-Path: <linux-kernel+bounces-728210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D2B024A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332741CA7F93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8A1DF25C;
	Fri, 11 Jul 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M0JBk/pS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pEHgQmMT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4A469D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262533; cv=fail; b=oekBUzNc7WBOI38tvuJ32MB5a8a0XK8WQeHojb9tEK9Fg1Mf8PSFTupzBztrq8t6HIri80q3ytq3rEO8OYDAchijkmFLyrG4qmX7cAsMNz57xtYY9ddpIe57/wloWo2iOhCFebMhO7/3rAlN6stPHhhoUIfyxVE25QK/VSWq6G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262533; c=relaxed/simple;
	bh=+bP3i8Pa8Hlvm2qSqqVy+glOIx8ithlJ9OGrDPVLaUo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=o8Ur/Mhlz90IF5JsCL3z08aYKauVshixH+r4XtTV62X98fTVe3/5TboOdUz8KABuiij4OBH9YXkSEWKe2q3o1j4Ti023ejL+Ciev4q3+2MAf6Z79pdJXAeSpMHktdb+WKbB+aO7O8UQkNZAHvhRh+g6ELg7jbaOXEUGPTL6TvG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M0JBk/pS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pEHgQmMT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIqilN005126;
	Fri, 11 Jul 2025 19:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5ZWW6pc9v7ZrmCcfC4
	CBBtUNwhLpoLYFvgxVmcjhCPk=; b=M0JBk/pSHfRYsYSd8fvTkThECrdn3Tcq8q
	ma0nSs46wRqEjr3IQTq5J2C8E+MhCTWIKu95Ruxa3eMBisdZwbbqiCS5kuxAjCeI
	Qbe3dK7XyrCUIacrfPjCdSuwlDP154pST4UAtwz3IQwDob9eVCCMZloJrJFF/nrg
	TRK1QWBVSorIWNe0i8/A0IGky6uv4ruxVtLW642c/o1I0hBN55WsPxCU7aPjzfwv
	NrCLkoKRB9Bmzz1cWykTaEwVFTbRE8OsMEmjaAmyuLy39QvksL4+pnYcNL/JHVnh
	IfOmG4ZIGKg5KPv2RnGti/aOFjVXLuLocFoms3mv5eGebhu1mBHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u88x02bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:35:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIcniH014045;
	Fri, 11 Jul 2025 19:35:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgerauy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbsIl4FUc3hlieRHF3RRNXwr2DTZ61bJ4fTLuJtVXrmLNqdg1RKO4IG8nNOED3GRY4wgVZN5NfgPhNRI2DYIOfMG72y4lt3oZke/26P067g3zzQggkvHoTjcBmcG701U0SnquuuyLkH5s9ahOpXsPrLmp01nn91/3CFNj4h0VIREzRmIrMlPiFU1NwJ7hf4eptxVml09w7PFbafFvGRaSGcyP7twQc5ngI+raUmuV2bKBJF7OZT9AbOSYD62wAqaVh/w+D6Y/Mss6Ovv43hMihO3dZ1zGrb+eX09oILjNynGFtDBt1fOkvjoBr86mk5Bhx0HwUqmroCTBMo6plotJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZWW6pc9v7ZrmCcfC4CBBtUNwhLpoLYFvgxVmcjhCPk=;
 b=MX2bmEvO05HOuLNSh861FSTbeKsPnf5Giib15kMcY5TXnaEf+eYDidpOxZvvTUTJw5RN86aBbihiikBulCsRRZVP9Kz9y+xhMW5KHY/wTBcCb14jxuVsYPzMMFSWtKhvggY4qpeejOZa5HjvIAt2cWihg3VNOdelLNcvkFqAO4yjW4eE3VB+a8ezesYYaRsxa6EYznqv9JSkLW3tTFHHwnbxW5THaVP2Bl4JxBAAnvcmSjzA2jPwq8F6p7b0NvjuQP2rPUNrS/m/3VKfiYkJmktU9n/cx+3gX2cMSbJ84VfeBOp+E0qwbaCmdECPiRXFix4wdKG0i32OlQQoV1WHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZWW6pc9v7ZrmCcfC4CBBtUNwhLpoLYFvgxVmcjhCPk=;
 b=pEHgQmMT4W2F95tGqm3ZfrxezjM+/OhpVLmHQCFhN9bZMoaxB1MYB1ioXOlC8Tovaf2kWxsQknB1mkgRncM8PT6BZHt2huXny0VGzSXz2ZT54c5WZ4wd4tRpzRgxHSMDXvnGReYVD59arJMX1/z/PQgKQAbcJlNAa1KbRrLyfNE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA4PR10MB8730.namprd10.prod.outlook.com (2603:10b6:208:562::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 19:35:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 19:35:05 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <a1575434-77eb-4358-896a-6d0e62feef4c@redhat.com>
 <878qkuprku.fsf@oracle.com>
 <2c6db237-3d64-43f5-8a20-168be5b248c8@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
In-reply-to: <2c6db237-3d64-43f5-8a20-168be5b248c8@redhat.com>
Date: Fri, 11 Jul 2025 12:35:04 -0700
Message-ID: <87ldoumsgn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA4PR10MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: f9445053-d2e3-49f0-e3ad-08ddc0b209a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzGOUJJTlQgrJkjlR4ppj3CutK0b9UrhP7Y0cMHSljEFS6Y3/7hjtmvH+y9e?=
 =?us-ascii?Q?9dTg6iQ7bfAHhwiHI53tOt1P8icjA+RqNPSXow1JN6SYGDdOht83l/yu9jvv?=
 =?us-ascii?Q?qitb5GkGFm+sC90yVtlcpb4hAi07u9UPnzNwmZnYtdtNHmRoe1Zfig7yQfn8?=
 =?us-ascii?Q?dhk1rPd9CqNHsH9pLi2Mom+vYARbiDipvWApQvjyAG+ewaThfrSjXFdmh+zG?=
 =?us-ascii?Q?ksVAfFzGmlj1f5crObOMxAkTM3Uoho/VGqydQ3zKaQODcsVRGZ9heHfj0zCr?=
 =?us-ascii?Q?rKhadMBFMke+HvIR/vMbvwFmZJIJwQnxOtfSKi/3syZnOwCCBblxW7lb9FTv?=
 =?us-ascii?Q?WuVKL1VxRYtX1Zbp+JYh9P/54jYY78teUUehRXH7+QWZmixHr69HQLwMAUfu?=
 =?us-ascii?Q?XMs+OHMxn2iC6M9MrvJgM1W77J/nfAD13r1o0Yh1YVwX1ZMLQeAAXBdUlNbh?=
 =?us-ascii?Q?i0UPgIljw3YFn/JY3AsNwdxER0vCaDAtmC5D+13DNsjq4YQM5GVdkuGtIJkw?=
 =?us-ascii?Q?rxmP7QQIl1/jEvusZogkENtZ9RyiAJb9ZLzikrJEGtdhlWvZtgjXkH6zCi1a?=
 =?us-ascii?Q?4HkI19VQwdoSrMzMMgO9wowJTUCXaLrS23GUsjm3KzX9IqqdHm6TEkSFotoN?=
 =?us-ascii?Q?vH54vg50ArktdiH8z+yeNQBkmcoFUHYxjKwoqVTc8gxpSOkvZ2mhkePYQUm4?=
 =?us-ascii?Q?k1Cph76aw47glavWwXu/gvbF90p+3po9oS1vOGc6mNWrpXrWVVxh+VSOa00j?=
 =?us-ascii?Q?xO+05XXo+2YH+hSwzY8jtXY7bcC/EwlR2SbeJ5ZZoGAbsPm1ezp0qpTGFA5l?=
 =?us-ascii?Q?YznaLA2cKk1yU1Kq/DbiwH9BV6R2Z0GZlXkGfkA/gtMcba/b+kMPhAFWkoaI?=
 =?us-ascii?Q?2ZtBWd1nAHYFD75zvF/LmCBtJ+Iml1KiPYEbPQbWYRC3+S1xWMA+ihwInT2m?=
 =?us-ascii?Q?vIZZDe3AjfrYvyA9J85tqghsU8o9kac0ixeGP/cWYb9mXFK4y46kltYNFF3v?=
 =?us-ascii?Q?OBdy3FFZ59d7wV+rX5ClBCsCwmdRX6M1Ath8LICaYkKWXwixz2KdYFG/X7qO?=
 =?us-ascii?Q?9Svh3P1XEeHrZALGB290DfIefuce0aRiGsPPXGQ6TePDI1b3q1FgEjkSlwZi?=
 =?us-ascii?Q?2UwapLEoFP9IZm4S6aiFK66tJ+pa+777cZob5cO5tP1m+guu+9Ym1uOaug3y?=
 =?us-ascii?Q?fJbwGhAYbvsOgYWm43UO9oU1Bxn5HrBjOJsPNXPP/BYa+Nwu80U8cJ4ARhaA?=
 =?us-ascii?Q?MYqkjYcok2/x4gcb3q2yazGsgpgibyzx47jhHNXkkesxPR6h0UF2ibiDN++P?=
 =?us-ascii?Q?lckmNX72F6tXXT+ShyURs/6gWxES4bPvHmfahCe1x8YD2aoQp0XM34jlhwsD?=
 =?us-ascii?Q?OMwRBncb1gxsGXTINrnH5BSjzcOwrkPa8GjJd9ulxb0klGI68yKiH90p44QE?=
 =?us-ascii?Q?e+w+XXa8/tg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IgLCpNVpUCPXur2QX8eZfrd3wChOhLccCJ1XiHIbyrRz6wQPsQZoIGMu0HF4?=
 =?us-ascii?Q?XGhXms3GIGgo0B5f3sX+bNS6Ho+EA4rJnX+/TjnCGnspHYv5lHFybmgNNnGc?=
 =?us-ascii?Q?JjKAx32A76WGNxpojOq4qja3lueC2lc/HVCs9I6zWY/2eq2Gmbr4fhkGctRS?=
 =?us-ascii?Q?BfhrInvcGOySyW2pyA9GbwG7PewvRLHFVXEpdRPpMp/PeM8Wz0PnzDyrdjBs?=
 =?us-ascii?Q?fb8EQ+GV1grT2I194jld5kXT4ObovF7JNPMXS89mexAanE87QQ96mRDpTzyq?=
 =?us-ascii?Q?53pkBCRfiuPF87yC6hjzB55qhWauzCCszqRWrP5RdOapgvRM8ZOcWD8yrZRe?=
 =?us-ascii?Q?yv+PiHYplEDxVHNylb9pO4O1EAGThzcOuTnEZJ/M0jE49+jjZkn4mG5ykk33?=
 =?us-ascii?Q?aChWLUWcpLpUAYf71tNKVVm9lQF9KDgyuOzbHoFYieoBa9/su8dm2mi+OAQf?=
 =?us-ascii?Q?zSdRRmJDpjhqwC5VysMDcR4ijtooheVaXzcChcxVxVeNQo5EeB0Hs64tvI5+?=
 =?us-ascii?Q?VyOLFje06v6ShLqfvhcMBKRFgDV0kqY7aIZCghSHMYVScqZjnFrLk8ok8y5c?=
 =?us-ascii?Q?iMrkpRuFb9Wm7lflwb1kF/IYWPY0mXnA4HKoPutboNDVaLwCC0+Un4OzAq5M?=
 =?us-ascii?Q?yudAU5gcSF0NPcAWfkulK+uWeADAwTt8YdvBaBC8TG9ZVZGrehSBaiRibDa2?=
 =?us-ascii?Q?TbWh6ZtlTWsCysHeu0qtrsM1BNk4ZVaFPfVU/PZi42/PlpTLIq9ARHePtE9z?=
 =?us-ascii?Q?SW2uvD2wdv68cMvwjfuvvbO6NdL3zcsS7cFIKW5jfO590bJ9b6MWJD3in5f0?=
 =?us-ascii?Q?WXj98zC5Ijx/t0hBD04HqnZTGHv2D0BiTPFkYsYdl27xNGsHXGFgqNeeEa1q?=
 =?us-ascii?Q?s8j0OMrmHXITKzeYbC6ZJiigLh4GQI52Olx697nb3WyAMcToFP5qVGQhd1Su?=
 =?us-ascii?Q?fo8vH79JOQy/NghCoZqdiY/nekwUIuwsD6eB2/o3AQnd5uMJrxq0HyPct2rf?=
 =?us-ascii?Q?O9g0ZogA7nUA/+J5g5kSJ71dhYH4z+56E3j3ItvqHj2KHUCRGLcyUxrb/hQW?=
 =?us-ascii?Q?k9SmCb241NHnJwOlNLThyCXstcvYnO0uBBu61d7jNPzkQsU99bi2dKhpQ9XI?=
 =?us-ascii?Q?HK5zMkht1pVVXG6V9TI3dztvPbn+U0DzEXQgIr4SyjBBDIFSLgF+F+ECTAHx?=
 =?us-ascii?Q?9YF7IsagKDPNkvuJ6ZQenYUWvskyHbXF/xNk9OAvG96utPga9gKhKfBGEt8p?=
 =?us-ascii?Q?MJ6bSHRZvIwKLRKtDA3zn7UsxCSknswHjwKhOSnmUXy1rIh9qfR5EJablmdC?=
 =?us-ascii?Q?rs9TQaYQRsgFAMiZaEDNYan2UXGo0f7LJPrShH5Upmy8KEodqhqz5lnFhmfU?=
 =?us-ascii?Q?9nUQkItBGGhs8w3J8FnJYzuzRMKawZRiNfJxCf2TV/5/DFjOeTOjK9K007Zn?=
 =?us-ascii?Q?8jDliD6rX0oFKL00TV9IXrsKqhIaMQG262Mn3o2IFOyxcXxAkEumpMjUDqjT?=
 =?us-ascii?Q?StHyT5Smymf/anSOTaF1cfhWOAMuq3yUuixfj+kNH5XEGLGrxCquxKPomNur?=
 =?us-ascii?Q?5GZCZojTVB3uDnWOIkLCkh5KPJFC/hFVzKaSyC+n5/GTbIGPPZNczKIlYf/5?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KoHZuAossTGk5RCKyvdf+bs0iziD8NOKYhk67UslZNmDs07u7+6qivd3Eq5Ih0SBOQgnO15GBgxZS+ABY30/Xh2D/zmUfpyuF8Bv2ySliBdPHQVIXzh4GUKHXklHIxXvSplRphlTUJuW2KAWpMLclEnTJlLttUJhPUCo3Jg0/kDsKdWF3WJOs9e5PZWMGRB9sAjQH2o64Hfa6aBlCbc9CxLLfCaHh9XR5HhKp1zxdUHK+je4GyA+nkpBezxyXKQB2grK+JFG1okW0PQi4j7eqJOiiRc6Ct2a6yuCcDYJIgOadauFPac3Ak1MvdE07ewQ3Jqfd4nSVp5uT4drs7DYWkze7VbvW1wenPaoVNHbqFGgJh5AP/Cs5eTZxIa1BvtwuOkXM0t9sG011SR29XPUJzB1QPmywIdpKTj+ElG1nMtW6Z7cK6NATZ6SljDg+e6k7j+H3rO1MozbGGxnODNQO41rXiaxLf/jMxZvBnTil4UBhELybMmZxGJhjqbxxJmqmloraH+SfNESHsFdMedJyuVt97DD9/hgEz3QhAVtxCmAw0fS0uZFs1mgESqo6mr9AxCPzbKxnPCPriTpNP0I8G6rN+yc1mieDYbTAIOAkhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9445053-d2e3-49f0-e3ad-08ddc0b209a6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:35:05.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI6wOYhz4csERuHommt+LMLQXWC6RoDhj880BaGYFxC2aDyN/YgAXR/JTVGzC9tQ1H4zDxphk8x11hCZK46keQLaPYSOjOH3qGWep5lPkCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110146
X-Authority-Analysis: v=2.4 cv=BYbY0qt2 c=1 sm=1 tr=0 ts=6871676e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=xdULd-7wYXAVvBIq_qsA:9 cc=ntf awl=host:13600
X-Proofpoint-GUID: 0A9kMukGlW96eTZ7bMFxbHW-husC0G6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE0NSBTYWx0ZWRfX+BJPdGm9hBdc LxxdJ7J5zQJpSKBzI3Z6oEjLD/kAHOXL7YBXW9YrpcSOsUqqZ4HBd8r18C4INbAHe3Ed7OhbW2c badGD0ujai5l65KV/RAgzx751t+RkmtW+jyhOpP9HpmMds8fCTbZL8kraGOIopEHhaMW/TTtWWr
 fewMwYNxlTuAgh/9MA8MQzn9ATT3X6zWxw8+DJbFNPH7h1/h4+70OLjTzHwMuBa8kiAA6r0fzcS MGdV4kXyF2P+0vH+65aJkDbdsg+R6XBdnA16AzHa1KQgGwr00dj2//XgYEaQuOE846y+AYct3RN kw/NNukHFXueViy81gne0EFjNmdr7kqRnXsRWbEhR2wQzY8DZtzkPyLbRai9GFMgdgx3BWUJR4M
 xcDdzGiXmdXjqBEfoTMpWAhSpDrnIoaVjAg9b/Mdd8x0czXopwqIm//WerJJNI7bnX+2lcgZ
X-Proofpoint-ORIG-GUID: 0A9kMukGlW96eTZ7bMFxbHW-husC0G6U


David Hildenbrand <david@redhat.com> writes:

> On 11.07.25 19:25, Ankur Arora wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>>>> where architecturally supported.
>>>> This is only available with !CONFIG_HIGHMEM because the intent is to
>>>> use architecture support to clear contiguous extents in a single
>>>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>>>> which excludes any possibility of interspersing kmap()/kunmap().
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>    mm/Kconfig | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 781be3240e21..a74a5e02de28 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -910,6 +910,15 @@ config NO_PAGE_MAPCOUNT
>>>>      endif # TRANSPARENT_HUGEPAGE
>>>>    +config CLEAR_PAGE_EXTENT
>>>> +	def_bool y
>>>> +	depends on !HIGHMEM && ARCH_HAS_CLEAR_PAGES
>>>> +	depends on TRANSPARENT_HUGEPAGE || HUGETLBFS
>>>> +
>>>> +	help
>>>> +	  Use architectural support for clear_pages() to zero page-extents.
>>>> +	  This is likely to be faster than zeroing page-at-a-time.
>>>> +
>>>
>>> IIRC, adding a help text will make this option be configurable by the user, no?
>> I tried changing the value in the generated .config by hand and that
>> reverted back to the computed value. So, I think this isn't configurable
>> by the user.
>
> Yes, I misremembered and the help text confused me.
>
> So yes, the help text in that case (internal entries) is uncommon (no need to
> guide the user when there are no options :) ), but feel free to keep it for
> documentation purposes.
>
> (e.g., HAVE_64BIT_ALIGNED_ACCESS does that)
>
> Maybe we should call it similarly HAVE_... to make it clearer that there are
> really no options.

Actually a prefix is a good idea.

Btw, the natural follow-up (to me anyway) to this series would be to
also do this for the copy path.

From some quick tests on x86, the performance improvement was similar.

So, maybe it could just be something like: USE_CONTIG_PAGES.

But that needs a verb somewhere.

> But I'm bad at #kconfig, so whatever you prefer.

Not much better, as you can see.

--
ankur

