Return-Path: <linux-kernel+bounces-786717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90616B36531
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072371BC6486
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E9928750C;
	Tue, 26 Aug 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGFCHP/i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mroZFHrN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603C393DF2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215471; cv=fail; b=a+VYGw1ZxZYbhCv3FuhWwDHCyt+dbaYCUPKtSOAlYRLhQIqWzliA9W1cBOUr0FjMwPdigUqz8+8znj8UwMAQ+Cf7tkR1/1viiApqKuo5CB2UBLFGk9of4jVMmxUnvtvI4Fq7+y1jCffFcD4wgXRpOPVe/4MCP54nQ1labXNxssc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215471; c=relaxed/simple;
	bh=2VGZDphl3vDbr7pFEhhLdhqDNquIroIjpn+CaO0NMzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t24iO2Iyw7eedJmSsWOdGX1fcJYh/P/YBigzYwRxnDurVFibx6hzEU+ZPIsAWKK4ShkwqNoPRZm+Qmlc0fc8a1zWHdCmRTRJrXI7xFF7R65S85pSfu0MQPEPKNELT5KWadefx1LSDWwB4JYEEfhhysBaSea2v3KGBZpIXUu2N9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HGFCHP/i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mroZFHrN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCHxcJ009009;
	Tue, 26 Aug 2025 13:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Lguc3Hhk2KuFEAB1nH
	ggWY15RdPsQN/nDq6mMT0VWdU=; b=HGFCHP/iKHVy3o0zorvOhTqhDY2uSfvE/m
	fxKGrNlKygcQoi0u0n4e2zLxhIETJdwUv2bIKEykHVytecQ0zmGIBpEdzxuyG+Mx
	/9A52ewp7bpgUGmVQVWPb6aNJ3Pxd2+pSsr8YqJW5ywwnGucDK6/FT/ElqixLsr0
	Snpm0egDkAxRylxgyxw1/vqTQwbsS4RCtn1uhgtu6G4/AW3TFn+JfV7HFJrqUqBU
	dzp4lYBEqcqKktbNhr6Gwt7IPG0cMRYWkz4zbAAf86uRNUz0Q2WVEXSv8VlCrnut
	sBdJgiTT6+3z0eQk9SQfyrRT6uGhu0kR2f69MnJvhjYMEQpTEgTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s4e4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:37:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QC5ltv004994;
	Tue, 26 Aug 2025 13:37:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439qrhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hd1r8qjhK+7ZmRnE9QnmFZNKs+oaGvS+qT7TKB01YmPxLJPnMV7kJHA9Gyb+TvDnAszAljqFQ11YkkY92+0PYz5PC60+IoFcYyKHKI+eqPt6LALRh8A/wBeeFxjA+EfMq1aSD1+4fPp5y1p/07Gn0uN4MQao5L/2i6NXDIg7sIzC5UPSZySH5TlFp4+kqmcF4OR/iBPXNq+EcV1vSeU9Jbwiz2er/aAPzz5N7/ITu4Zc1eyJKcDCc9B34bcWYfomODx2MqJFXqr94ky4AOMrSuCTghMpOfnmCq06t0pUhIo95vr76WcJNf1yNbQqcMDeemJAI5fgtEuvucFi720IOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lguc3Hhk2KuFEAB1nHggWY15RdPsQN/nDq6mMT0VWdU=;
 b=F7tl/mUxjI4SpnQwhvYME6d9GxIIyV97A1a42DMoE64n2Zqyu3EL9fjDX21CjMPKPOpqjGn8JCjkb8GnGOa35/7gQgTPWR9gW5IRTBEQ8p3/n3mLz9jpHHHR5e2p1YigjTbxGXD7CCxkppCBWIEhdc3pJibKpfNgbaSTrMFw9oxwfGreKylLW9yEB+7hpz8I3UxX4ZR27jbmxPDrdTUya3OzXMxZ6+vH6kZdp9MPcFVGys+Z6ck0RksiMgxUVP5r9EpMW5Gx21kIa8NJCbJZY13ZueQE1k9QJ3DKPGcHf810YCpl++4Peaj8MbvX9/Yc3C9K3PooLqWER8x761CwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lguc3Hhk2KuFEAB1nHggWY15RdPsQN/nDq6mMT0VWdU=;
 b=mroZFHrNImOQJYR/vaVmHkAU+hw3eAaVKMzJe0WqjLaHWRJAfJJk6aYmjCVtPS2FHpNOcSTo5hhE9zkB7iTN8Q92nN2QkCLzc+5ZIioN4kaODmKvVM77mFkC/wruqCVH8cR3NITUx2YssjhVo9Z9kUztVX7U2lyDFYL+G7OYllk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ5PPF77807A52D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 13:37:25 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:37:25 +0000
Date: Tue, 26 Aug 2025 09:37:22 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: zhongjinji <zhongjinji@honor.com>, mhocko@suse.com, rientjes@google.com,
        shakeel.butt@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, liulu.liu@honor.com,
        feng.han@honor.com
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
Message-ID: <nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, zhongjinji <zhongjinji@honor.com>, mhocko@suse.com, 
	rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	liulu.liu@honor.com, feng.han@honor.com
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-3-zhongjinji@honor.com>
 <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ5PPF77807A52D:EE_
X-MS-Office365-Filtering-Correlation-Id: 21234f6c-9dad-4910-df23-08dde4a5b137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?be1P9U2ymE+n5xawlkXe5k7iFD0gmvjAsxo/JyZZU8jc5IIE6VKaDgfqQ07j?=
 =?us-ascii?Q?RBcKqm/R1eMqf3T7OPkT4swREdrLmB9hCkvvBS/e8xJ66rtW6//GNOswD1Jk?=
 =?us-ascii?Q?KUEvt2fd1iw2UrWMLbZlLVJi29T+7irnb1C+DogQAFRHpVeL6iyA7xMWlgzS?=
 =?us-ascii?Q?kGoENCr+ErHHVnLh8eUHILsvZ9+yIJjkzKIit2IV2lHvZWA4VVEJ49nb3/Zy?=
 =?us-ascii?Q?9+F6otHseUarW7C8iRDRpPhPuRGd5cTrNVHYxaegX5Vb4laQdXDgEUPHNlbm?=
 =?us-ascii?Q?dfRJA9rb8vi591n/js6cW+AV+2FsTzWJ3B6eDrIFZ03JWrN5fG711bthhkyk?=
 =?us-ascii?Q?dBaw7QCfxkxi4QadPOG2s325B1yLH0+VcCX25wS7+1CbMEk4agSbqUwOII8n?=
 =?us-ascii?Q?eYWsN5NY+gLldY1u1/vY9uaDboZo5yrsTsURWSpGlIeV6nPQJmRaldP6kuNz?=
 =?us-ascii?Q?UCWaTXxDErzjFUwrDH+BBrm6rEMft+7kGMKtecgwJECgle9grxtilbT75CTS?=
 =?us-ascii?Q?i5UD8wLmwscLLx66VeNVq1aBdI1gNpQ5BxtCQB83Kbnca0avePmFG7xbOezs?=
 =?us-ascii?Q?ZD4ZxaWW5qjQfJ23PyRnPO9oUcNxhS/S6ny7Uyu5XrSPfvGGYPq+tpb33Imy?=
 =?us-ascii?Q?7AVnUvovBlHCVsVC17EeLt3/VYvKBDrT2bEtOqTevlI4h2Kk5gqYHMQSQBAs?=
 =?us-ascii?Q?zz6a3sQzGv1npk6uMToXP79y3+53O34s2QBTrArD0dO6fXfVhB3WI9gT+WVC?=
 =?us-ascii?Q?C8M/IgeopYbVdLZs9XA3oy8DOJvyK5vwja8nQm0H2phsCLl8JgadjFY2KL0T?=
 =?us-ascii?Q?BNiW+eBQdtlhTSs8Gu2sFvQJo87Q4VMrkkh5lnhPGiHHSnUN6+7mRBG8hnOX?=
 =?us-ascii?Q?sUF2aKB0tmNfgguiS8Fcd33kVeAfpKfSYITN2XCh/ggbxH0ZMhU5IXEOLyB/?=
 =?us-ascii?Q?VNrKcq46nk6JA37y2FsIZaqwloKaP+TBDhimfCNzGxFqUCjOEojnefu10SeT?=
 =?us-ascii?Q?NvIIzc+p79Rgq10rDKV6VFg2llYTjZIpjYmP1wxtKTjDYDiYaSJ/HRSV7jQ+?=
 =?us-ascii?Q?tH77U/rNZJefcMe6IMPnKD6UbFLgisMAgQUyaarFuFNO0dH55skKN95NHfVv?=
 =?us-ascii?Q?UjShAtScCAbwgNrKeHhr6Bd6nHOZXBUykOUFLYS7H9v4j3AHgwTNyPlqPfe5?=
 =?us-ascii?Q?9uxYy0pM0gtULwwRPfVyncGzkukicCMUucH8L6GZkSoc8gq8ce3Nnsw9nEpP?=
 =?us-ascii?Q?A92DZGpw4T3My+FbodCb017+kR9il6Q7uNcM26tIlzSR9exzbuP39kVC2Yoj?=
 =?us-ascii?Q?J181R3Q5aw59EfpI+Sgfor4Y/3GX73SsfSx86Qap1viu3jKnuZXAopnO6T2u?=
 =?us-ascii?Q?1VYSMi5qs2aXELswMqf8q7GAcrzAwpzNfttsmu7XLZf4O7gThPjjHbVfot2B?=
 =?us-ascii?Q?k+vBnHG8R6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kOQLIhRJsLDPQepgSqefWfDMTEsh7sfHJjdnNj4xAMxjr0T6Hq0kF2qhHD0?=
 =?us-ascii?Q?VyaRsC6l4gzLrlMrCiS2mrzU2P7NSVHQReaA1FWPTLuJyGW7FC/YQlbEdc8d?=
 =?us-ascii?Q?lv2zVw6W+/e/i24VWWPgztgWKFBzV+lm4U6d08gUj7JqCkT0YqJXw5saL5X4?=
 =?us-ascii?Q?we3VsekJJ0QfUSWK/c0sd8Pjoru8emkg+X0a0nGhBwpwHj4Iz4oviN9ci8rb?=
 =?us-ascii?Q?hig8pd/t4EggCkppk35tDDXsmSDWvzQrnkKOxuEEuevnggsLpFvf+hlLqbuS?=
 =?us-ascii?Q?+GUSJBvU1GpHHvv+tuyziKmjtLpq2Md39IYCW2uDsZ1yTBu6uNIzTgbqf2bZ?=
 =?us-ascii?Q?dqGo+MFM2iPvADclKXaHNdJsa4UYygn5Or9Umk5UpEQNIXO8aR3cA4LWn3Cj?=
 =?us-ascii?Q?RNQxw6sKNTu2F0CjnD63jbfKBnKSGPNWz7Z80f/piKdmqn3Qb/9jm1wsSPvX?=
 =?us-ascii?Q?F2QHfk+sAWWAYT2QlhkHubk6kwmT0iqqY8lNz6TlUga15HuTiYYQhbDJE12v?=
 =?us-ascii?Q?E2133vMKbnVfintgnBEolS2tGthu0glxzEDgNFhsjxpQZmMy8bxkF8TOacKH?=
 =?us-ascii?Q?1ZIBmRwqFOGUygfDGBYeyY4JOL1PNqZ2AECnWw3dTa56XL5tk/z6hmmyf9w/?=
 =?us-ascii?Q?V7mUA52kFakIy8Mg7szxZQpQlR1LTZx2rZ8e7O1EAGptfaF9KvZUO/JkSI75?=
 =?us-ascii?Q?27ZNqGiiGlf412LBqO3MGyoUWhTHjP5kfxHD/oeLsu5SphjjOuLuhmix3rcD?=
 =?us-ascii?Q?+SSai94EbhxqgIkangeZPh+s81nqLO+P9GtYqMqjkKcFrx/cVtYcTOhRa8z6?=
 =?us-ascii?Q?+OA11L5vKXhEtM8cuQJS2aKt3CSULL/IjA+jtiH9cihS8Zu73Qu/azDzps2y?=
 =?us-ascii?Q?qPWHJWM7XTW/CM6qu7W1Tj/Kb90ehPcPbgSLeaqCEwZKEKdrYy6BUk3oGg0w?=
 =?us-ascii?Q?d67MuFAInVkjuqVvtvQ/WUUbPn2wSOmr1XxM8ztFcMwfGeEuQ6xPNmpewl/i?=
 =?us-ascii?Q?+JFGMhnQnUsskrRkD46FXIJMi9zunucQ3X8fymSR4MhB+fjNKQGcLJVS/yQe?=
 =?us-ascii?Q?L2Eda5uqVPZJoXbaCyDmo8I8P2lnBwSfqfy9QavjSzDggSsi/eauPrrdR7s7?=
 =?us-ascii?Q?61SyPjMhs7pE5X+qtIXG+4O2ZM5TLwcZVxX8aJcZWI7iSIghClzB2h58k0yZ?=
 =?us-ascii?Q?+Lv1HMwojJzOjFuUjua3TtN2sFmaG+C/WwGmVjP4QqC6CNueUApXXKehVaYJ?=
 =?us-ascii?Q?BfitVWIEgXcqmbGoSpxKL6XtdjPNqU/p+uuSLvHuUyFMDTsCMGpdrxGiXzgm?=
 =?us-ascii?Q?AYHlcotSK2N5g6SNpzjKeAJDLkUpIcYfu+VtAcrPho4maV46GFE34Dnbl+Ab?=
 =?us-ascii?Q?S5ng/2aPmJxH5cST3riqLaoJyjarlGFMqXbosMquudqgn1zJ+XzuPT5c1Aj7?=
 =?us-ascii?Q?BB4sr4krfjbx0/N+KqVpLtLUq4XmKuSVXuU+a4USKAqTgy8BoiX/EqBxbIwi?=
 =?us-ascii?Q?3r46R4D+osCKjC1zifirnE91BXB+sGs2OgqkcWEznyxpBlKyGBB5jFXbsk9R?=
 =?us-ascii?Q?wAbwKrOKHODHt8gnW79mCamDGLnzLdChaDIHl+UV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6IZcppim5Nk/FcdCjz1YGZZ2PEh132lETpQ4+NP/m9tVqhDgdd+v8lgH4wSuDOgixiNuUchPLB3fOO36uZNrnS3HrAZ3414clra5PpO6fJv48qt6Ztcqch37wHP6AhC2+m4an/Q5cIN0hUQYiI7ja90orl2F65JUlNOvn8QOupH8aGa6SrSPNFZwFBSf18mgKO+jReHCrjbio6J5m+Xlkb0pT4dmLGowG4zZMvgZwxSaal7NUUwjSbdCIDGXYc7sUzr9B2VY9xnS1m7RUJ7q6uGPGh9qljrcwSUDMBVgfjqZc4ocMDdrK6k6lT6JJEz+BqXVfVtZo1sjlNFJXpC8FpigSddibZ5eWiQBLqgXc387q+NSAZAr2PXenTUL5AG/46PieWP4jofE0syp/8kajMnqsFkr1RnjlzNf3OdBqK3TlP4pleVu+2Dpo3BO9XtLj/m6KXlwoyy2sEKRFNEOvdhxUK4WdLqIsM+EY/IoUBt7gUL3YKR0FvrV01kV6FyfSuOrF9QGuWoi/fUtOiJMn3Bq+erffCxcAtSGIAl3+qV5INKRTSjP52YjIYcoONzGHV2/bBS2zY2NWQd+VLVADp6bzG4dHqw0t2ZVjMitEM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21234f6c-9dad-4910-df23-08dde4a5b137
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:37:25.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb7pZGeUMZ7OnbEymvP9bo6AUVACf2t+wA6jfw5Ckz3AEfnvOqnnNblyQ0EHq5m/9LUvbDnDJXKzIkMxoM38lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF77807A52D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260119
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68adb899 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CvlTB2HrAAAA:8
 a=-4O7c_3X0SIA_F1Vdw8A:9 a=CjuIK1q_8ugA:10 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-GUID: u7b69HSQee4rFNwGz6PoeVjVSxZ89lOT
X-Proofpoint-ORIG-GUID: u7b69HSQee4rFNwGz6PoeVjVSxZ89lOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXwpKHRDxN3GGv
 1QC2Wr3W7FnTvyatwWKq3v3I8jEsCFKnKijVFcBnQFlOGdY8PQEd08HE281vOc2icS1lA4NvWiz
 AEK9KeJony1OC0fqz2ij6z5b/x91ulNY3S9TF6k6yhWB+q1aHBNSW1/l2j7/FDiYvWqJ5bKO7O3
 TrcRyDZpKud2JpFnavYG5nREqrW9WT/whAy6EYqgIzHu8G0A4+2j4RD8sqPL3u91OnjUsycL4VU
 IjvS57CT+HYp+er7R25ZGqIbiytYuGwgFO6+KRQ/90I5NBUGC6HvsUC9h8tRilW9dHf93Tu9rI1
 l/kbrBfTvOG9GkgJXkqPS1Xjxk7tCX/7Re5XbnxMiqHBW45sxT2Z3ea5XYCLirUsdWNjAMTov4o
 W4irE7Xs

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250826 08:53]:
> On Mon, Aug 25, 2025 at 09:38:55PM +0800, zhongjinji wrote:
> > When a process is OOM killed without reaper delay, the oom reaper and the
> > exit_mmap() thread likely run simultaneously. They traverse the vma's maple
> > tree along the same path and may easily unmap the same vma, causing them to
> > compete for the pte spinlock.
> >
> > When a process exits, exit_mmap() traverses the vma's maple tree from low
> > to high addresses. To reduce the chance of unmapping the same vma
> > simultaneously, the OOM reaper should traverse the vma's tree from high to
> > low address.
> >
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> I will leave it to Liam to confirm the maple tree bit is ok, but I guess
> I'm softening to the idea of doing this - because it should have no impact
> on most users, so even if it's some rare edge case that triggers the
> situation, then it's worth doing it in reverse just to help you guys out :)
> 

I really don't think this is worth doing.  We're avoiding a race between
oom and a task unmap - the MMF bits should be used to avoid this race -
or at least mitigate it.

They are probably both under the read lock, but considering how rare it
would be, would a racy flag check be enough - it is hardly critical to
get right.  Either would reduce the probability.

> Liam - please confirm this is good from your side, and then I can add a tag!
> 
> Cheers, Lorenzo
> 
> > ---
> >  mm/oom_kill.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 4b4d73b1e00d..a0650da9ec9c 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  {
> >  	struct vm_area_struct *vma;
> >  	bool ret = true;
> > -	VMA_ITERATOR(vmi, mm, 0);
> > +	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, 0);
                                  ^^^^^^^^^  ^^
You have set the index larger than the last.  It (probably?) works, but
isn't correct and may stop working, so let's fix it.

MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);


> >
> >  	/*
> >  	 * Tell all users of get_user/copy_from_user etc... that the content
> > @@ -526,7 +526,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  	 */
> >  	set_bit(MMF_UNSTABLE, &mm->flags);
> >
> > -	for_each_vma(vmi, vma) {
> > +	/*
> > +	 * When two tasks unmap the same vma at the same time, they may contend for the
> > +	 * pte spinlock. To reduce the probability of them unmapping the same vma, the
> > +	 * oom reaper traverse the vma maple tree in reverse order.
> > +	 */
> > +	while ((vma = mas_find_rev(&mas, 0)) != NULL) {
> 
> It's a pity there isn't a nicer formulation of this but this is probably
> the least worst way of doing it.
> 

mas_for_each_rev() exists for this use case.

You will find that the implementation is very close to what you see
here. :)

> >  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> >  			continue;
> >
> > --
> > 2.17.1
> >

