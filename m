Return-Path: <linux-kernel+bounces-721792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BAAFCDF2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B267B4087
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5A2E0918;
	Tue,  8 Jul 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hegGazpa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PT9U0f61"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE62D8DA8;
	Tue,  8 Jul 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985613; cv=fail; b=qKDVUkyLTcP0Erz46zqx0MxQQLKoiHoHKtxg0nB0OSmCp5n8rhZpg+KzitTox+otBjbvyEChs2DUDmFAzCZiaVI7jTGbSs/WT67E7JXQDH/cQ6EpNNnAEOFBRWC39eMcoe9W7+/esex/9aRAx8X/KK0jFdN10KGH6dVQOO1UJwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985613; c=relaxed/simple;
	bh=ryGoK8TDH2xXefio6lsff4/KqqLj0NSCzspVkqDaiyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZSVPWghqkFTeU3h27k4Fw5L2m/JgePVWYDHtCXcecmwaMU0TnyQZ+tCFDOTBtxxRMBVZC27zxfl7vqwupK+w513XlmM08e7dyr7+Fzc7Nr/n4/d/YdE0tnpgfgQcnq12tx8iq6nd3fn1YPfP3TTpLVTfaHzpdUR77Qu11EYh/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hegGazpa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PT9U0f61; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568DZQYD012660;
	Tue, 8 Jul 2025 14:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=R3VxbGV4ouacuiAjb+
	kXP7lYDvwm9JM5yiTy+VhBPJI=; b=hegGazpa0/WjANUOlFRRH2kJeM9lPvjmGW
	1OavjLGyebW3/dQOVZHndT90M1zjVulqrj/Up63wEuXocZCdhobzIGxFrvwDkJBQ
	oLQABoc3wMV1wf929T8iWl5PKvCqjIPFRfG7iMUBRmElUz+tm4ZZuMb7sieTIDfI
	DnwhadC0Iuq1fvEpCcJU8tyoITzQra8YDtq7hx5MjlO74kVv6DllH/Z/rva5AX3D
	CVHLNU0EVV+dGPeo9AIadPaNRoNnjDFKYYSRI5spaq20pvuvu72GygxO1qiRg4xl
	Vs4f73WmYnr9UDFbm7fZcR2OQ3sjnDsJKT5pZWDWyg4r2TJbnXAw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s3uwr7xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:39:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568DqFvb024309;
	Tue, 8 Jul 2025 14:39:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9ybwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOr5YS56rHVvmXUfSdKeGqKslAvJ07VL+boklCeVVKK8cIz3gYACq0ae72gPLYLWDsn7UMDhrUbPNlFhxgH8S29Ra/iEWDFm+n+/SYWk+CQn/DmUoJMfeCTprOrO00OthXuzPtLHZe47H2xHzYc6zaSPidCqK2NJIa24xcqpErl8ap9IXIJFO2F8zcJc7zjlRHMAGPeDGJAWxQiRdV2CD435P5rygmlnavEEQkfVKPGVU0njxNWx1N0cKkpGmXmyzkYiSbOa244AC6dHakJLq7O84gONzK5fJEv8xwhT+WRzgR9XSdqylbJ1juzfUo2mGewZn09tdL3POfYYkLuLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3VxbGV4ouacuiAjb+kXP7lYDvwm9JM5yiTy+VhBPJI=;
 b=fftf0QthmGVn/X2BGWIvba6Z8AViwtlcM8+7UVUkHKbut1cpnC6eJB1FuwHyXsWnPzX5tnpOVW7d4kVVypQdKFkEleVIN3+/CnNiq3fMQPyYnQ/WZL9Oh/ok7bp0bHsiZJLyPIts+MaYBCKGNfd71+jc2/48Nfa7jQ8uzFlf+ENix5zgpwCAOVEXoExTT1zvn6ch8iLcuiLqNsBUCaKvMhW5FhWHDXdLlQPLZ9xKXpVr1haN1RKI+0MsGv2hENr2/xLsAlleXfEmlaa1/Jw6EU8wF1UsxPCs6eolC4BkXwG5CPPDkN+quSyVj1Wn6oTmDoKlxbdv9UV5K5W9NxXzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3VxbGV4ouacuiAjb+kXP7lYDvwm9JM5yiTy+VhBPJI=;
 b=PT9U0f61q4n19oGWyZurFHc2sT1dKaqdBdCCVpMxg/K6dT48KvU5885Ew1VvuKq/rl5DB7y7Hxj8TyM9nVnSJ/2ra61J0PgqRZilnQiSEmCBPWQ8HfLDr+2yYJe7DDB26zeRbf3OI48AXAxTG4HJjQc7LxbPZ4lxtYpL2QXMkMc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7858.namprd10.prod.outlook.com (2603:10b6:a03:578::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:39:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:39:46 +0000
Date: Tue, 8 Jul 2025 15:39:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <4c122436-db58-4ca5-bc64-5ca596f03952@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
 <DB6QKIHD2VGS.AHEOXL25SSXW@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6QKIHD2VGS.AHEOXL25SSXW@kernel.org>
X-ClientProxiedBy: LO2P265CA0341.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: aef3605f-5136-416c-ef38-08ddbe2d493f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+8cJmI4DoH9rU388G3/TYnD23u0U/p3jm48QX3pXZNdXl3Fxa5/hmVncleO?=
 =?us-ascii?Q?APLsbZ6c6+3I4r/iV3CwWH08tPoyBWDmkC/gx38I+Nq9BWATB0EExwCQL3AY?=
 =?us-ascii?Q?JN84WDk3oOzDgFSnDsZDO4kYuUtg9wZNjMNNllRV+I2C+XyqtiVIBXBuSTXe?=
 =?us-ascii?Q?lwb/x25PLH5RUvwubHFIbo/wED6ohPfbC2OacsIUhP3MJYTCkhIqzTohLL55?=
 =?us-ascii?Q?JjmFqAcsCR6vou2q0Klc+CSKmecZBHCejtkgJDcux0Ywnki8DQtZoAdubZQG?=
 =?us-ascii?Q?ukD2vUzMY7JBol6BuV3Eoxkw7Rrt4m/TT0M9HQzfcqd2dMZ5Zvue+vXg9DaN?=
 =?us-ascii?Q?IetfjL18bo0WjTSufAsoozA0MFEaVbY6e3PDtyaFeQasmaaKrvxxDjStGS5U?=
 =?us-ascii?Q?GPrOtlit+vOAgjvdUkyIUUKvphHPLOOGExPnNoSsRvO0Vk1tUI0YsG2SbWUU?=
 =?us-ascii?Q?VXLrWvPUOx3W8WnmVy++iKN8cGJkOjZ5SCGzXVVTtqijc7gJTGKOKm6aAwU5?=
 =?us-ascii?Q?+X0KyLvT8enzOCDQvkTbNxxyiDcoPp+GiGvdc4eMx3l0IprJ645MzUtPrqkV?=
 =?us-ascii?Q?E2euiNgdg5enO3c937F6F+i+JeaoFyuWrpcHGQXojxg34A7qluwh/muQR0RK?=
 =?us-ascii?Q?tdQpXu0xq5iJk1ibGUJUDtLquAXOjSQ3gxzqYi8kF+kshaMnYQmKuOfvjFHq?=
 =?us-ascii?Q?+FhgJIhUrZqgp9JYlIH6lQlc5bjwwCg0KlyUAHoWIFThtt/qM7zZkd4y9q7E?=
 =?us-ascii?Q?smyTd734VrOJ2nnDd7X9uJxnx6TQhFAQKJjEixCgemI8kNjPYe/GH6hbQr8H?=
 =?us-ascii?Q?guYtMdmTWY9NZWIMoGc8i26I0LX5hiLFbtB1xJIw7lqD00oHiHJtMmDPBQat?=
 =?us-ascii?Q?Je9XP2O9bXabLeMm9cGc9os5Z4BCx9W/VFiFVba3wVSklNRDd8pKfp9YaA86?=
 =?us-ascii?Q?KwfZEPqw2VB1qY6Hx90Xb5ZWRXEjAeH9yiKy4c3eqeAFlofPf9eT2Ov1E4kH?=
 =?us-ascii?Q?jmd5H+enbtBwJAVlRMACq1YzoWiH0vihhZ/kRuSuxNiSg6chzddv0LV2D5hh?=
 =?us-ascii?Q?300X9DeMz4i/0EJ0E3PJr296YP9BNdtYRZoH5kOIntAm6PqxpheNZTItPo1r?=
 =?us-ascii?Q?JPgotdnupvWWG8jjz2C9IANQw30F0jxyY7pfJvrNlJcIiuPNZSpz4At0iuJe?=
 =?us-ascii?Q?bj5hsWpDEwNaIRUN2guTSf4CSiEy84AcPhfqorxhzxU+UDDMjjPXwUHJE+Gz?=
 =?us-ascii?Q?QaqrBYdD2TE/DisWPYEatx+gC4EN+G3jPhXufFw2i4AP6TwLIEVgDgW/pH7q?=
 =?us-ascii?Q?yEhRokS9q+avNU7YF18Qq45Z/YzjlgFATIc3QWIfLKoG3qRHrVMPe1KXVj+w?=
 =?us-ascii?Q?HNCcEqC1RElVmjlRaMk3Blgo+gAy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBqooTJiSr4+ZT0wVe7HnkfTSKeY2wvB0poqDzpbacl/GT0co7DBp3dN8yso?=
 =?us-ascii?Q?ZnnHbookCNJqrINJVhC8Fzoe6D/xTelzUCnerjMZNtvncpt9GtuI3bFsDhjY?=
 =?us-ascii?Q?HnnRFbOL1zp4pcGxpbz0kcLOrVoM9RceSfhBoszKinSC8zciu3A6z74+yQX/?=
 =?us-ascii?Q?cZaNA1oQNqx8EB3/yObBY1BL/tIGNTRhA/noit1QfXeiHEqEdY1Ex8n+x4V4?=
 =?us-ascii?Q?Z0mlzmttX0lhqcr7c/pGXPoYXl2imRKlIPAbqDbA5+/cc9D8yQbEnwZgGXv9?=
 =?us-ascii?Q?klADMtya+t1Ki7PreEpAbl/4eAJyZFS59fqrtBinZQkZK2CJsT4RA39RvITU?=
 =?us-ascii?Q?pqQIn0XQFTfiEAvWcVm/BZZ4KSOfZ5SNkS09ak6nE2NdefXBGG9itTowy1U9?=
 =?us-ascii?Q?RyQHy6unPoaxub+pwkX4jgh2JEjqZW5LTwhzfaMC1OuOOfIsEoY/Sv1lpbo/?=
 =?us-ascii?Q?KleCnsBw8E6r1bOSX3sLCZKuEWt9o4JgGgZiusoaZIUlD7fUdzBqaWAJMKE9?=
 =?us-ascii?Q?5mqDA/omkVOxrcfnk8qUS/euZPg2Vr3zgq5Fh5fkYnEYBBqoi6jarMgpiTmb?=
 =?us-ascii?Q?BxmjKVeQdkPfQ0rhnu90mMnuaD6vZ0SJZIvEgLg59lzt3L1MBhN5UUvf/qSA?=
 =?us-ascii?Q?q1xKb7Tz+5yYIom7YZCmX6gmgawtV3HLNP/56m4N1G9m2bvNHVx1OO4r2rXu?=
 =?us-ascii?Q?V/CZ+BUSiUh0eX9tm7y6X9LkeDHqETRyHMnyoMIjIZ4kYdyN5IjXHFVj0ThY?=
 =?us-ascii?Q?9Pj9JJ5Wm9pMWALq7bnKMxAVNfaUpwx5Y+s08SbA3yY5Uqm+8OmfwwF/pTbH?=
 =?us-ascii?Q?SG0DrhFM7waTSftZavr6abAzd2GvRT03HjCd9lnUaqMHMp4mh2Y3Rki7giqt?=
 =?us-ascii?Q?X+o02cLNkTHe+9Xg3KeznpqQuD9rqtvjuWhDaF6+A+Gl4t8mlrK4LphjwIxn?=
 =?us-ascii?Q?rbSBUFWjDXaRhFJqBqQ4PSolDdJQawnNvtQPTnDryxcohJVZIYINEflOtOaP?=
 =?us-ascii?Q?4XeOZWqJ8J+1sTSiNDr0czB4z686yKM4jK7SpDATdcTmldqEzWCNbUGTu4iU?=
 =?us-ascii?Q?UUYUonS6xIKuRWhgrnkGylFfXFVlQec4MkrvCWDE3fzFlNdgP2axbQA+5h8M?=
 =?us-ascii?Q?Yv7Haf7vhhlhnZgi/RjfwvC0fBp2wqa1PlxyyHHfJ26UZRdqPEQAAoYmnJ7S?=
 =?us-ascii?Q?P3P47w/TV7G4I8kbbcDdJA2lh22TxjIOR4avNnLIyLbyMumS/kvmjpVENsos?=
 =?us-ascii?Q?bo0Ih6dQaQc84SxudqHrNi1KFuvV2BdhblZWoW6kCi0nW2UL/4U7GsEIyIu5?=
 =?us-ascii?Q?ySyyjcoJNbJ/JT6DOy1BRXpScJc4NL1e+hHzxXgT1W9bVd7rau9bmj0wHo18?=
 =?us-ascii?Q?RI3jnmvOkvpPpAT8Lg8bdO3HQl0WKaYWuO97+WJHa8wq73azXE75OI3qnp/6?=
 =?us-ascii?Q?sNUQ1qP2rnNcnGBl/r3YDOgG5t+2R5Oz/bVfoQWA8HNwRTsJyQ7kkudRCHSL?=
 =?us-ascii?Q?kT619hF6ScijdaWoXlVOmMguaon4KArwszJbf6gwNwPzkyRcq6LKAFmOmaRZ?=
 =?us-ascii?Q?egzvPidxuDgpivGVvay5c8mCf2oNqlARiM6pDrZncLyN6PQsArjZCFUAud6M?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uKvUn1vLiNP5+Q5L0e2aNk5lTXWTwaxe3SpqLnpRtcu016gL2MnnSIYGeDdF6RPCwsD2pFXWRUkVYw4ii3MW2RTZmnH6iN9Wtav3bQ8LsTBCgnRB14qGORh/hqFyN2KrlTYXXfO14WPZGh68Mem/ifmaXJNFnLrfEV0LwTlKvw5hUOIF3EmrqN3WJsyo+SHysOvsZfoMy2WVuC64Y3bY52ycq4KJs/gyi6u8eYTZrbL2ps4Hr0HLd/T+33OV8sLu/soMRV3hhFgJiTdeDsTToQoZXU+Lbtd+dawRUVMZNJ8XWelPIZuCG64EdqnbW+pjumHxYTgGcYki2IwsXd/cDuDcf8UjcmKkoQeUkuEqolqtsmIU+YU/VLj/jVCS8Kuwsahq3Ww2N0cUt2IQdFT4n4AcZTFfWZj6/sJnn6nsq4mGvG0dIACkM3sVM24wd/I6+vqy5B2qbvywsuGXr+Hi5xJx7VITTWvuTYPIxO97cJ9GEvfEFJCTt7Oob1oAAtRTGgOtROjjisiZkLqoVuf1c7I+3wRgLdWNBIByFd0svDt2CxNYqwFl9FWVER9G7h8XVuYJJZileOg5juXF4J/xhWxt16NKpwGnebDk4cC2g2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef3605f-5136-416c-ef38-08ddbe2d493f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:39:46.9174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzto+b3gRkZHyS7nDJkJtdJ6r1b2ikJddDxwCBcx2ckWimdGIHZ1RfqbXjiD2hOMZJV2m9CnumDGtPxBEQffN0f8JjUtG+tDuhTjwJw8i3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyMiBTYWx0ZWRfX+pKjoOLUqFQI XFer4qydZaqjAanBzRv45cEb7Bm2K+MbUzILQqInCJFN9ncXbVIbMkjcthbgc9pWGQNzckcMMo2 WsxEnVzj2Gec55pcuUMlwi0t334dRYHbUT+44lAkx0f28jOA/llsYnbSthMkF5fasPS6AyLNgo2
 LZ9dtG/mXMB0N0pUuJ545SKkOUXUfcWHKAQqwwZfPNEhK0nUBslBuSahR+e81Rzn06drmqYlqRg XdjgU7ccFDwJbOUsIqv8uLQv7+PTiAcGOnryzDNtUgswBMeHrm9gWbomEc7tE4j/dSQneglJCkI 2QbOcz3NDrhabwQtnopYUssrN+Qpkqf2qf0hUHTbRzh0jfFRQuVzDd6iVH+3AgZeHi9MtDbSa0N
 MT9zPyTnAnT6bDYDi/ak8f+MD4RZZqorMevddZlPmW6lTH4zxmf4FaGApBJUrW8ScyTd3o/b
X-Proofpoint-GUID: r1KwPHzkRmOl-RVvBeM8jbn4xgwpWHuX
X-Authority-Analysis: v=2.4 cv=aathnQot c=1 sm=1 tr=0 ts=686d2db6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Uxnxe2e8inOeyF-35W4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: r1KwPHzkRmOl-RVvBeM8jbn4xgwpWHuX

On Tue, Jul 08, 2025 at 04:16:48PM +0200, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 3:19 PM CEST, Lorenzo Stoakes wrote:
> > On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
> >> On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> >> > +cc Liam
> >> >
> >> > Hi guys,
> >> >
> >> > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> >> > it's slightly concerning to find a series (at v11!) like this that changes
> >> > mm-related stuff and it involves files not listed there and nobody bothered
> >> > to cc- the people listed there.
> >>
> >> What files are you referring to? Are you referring to:
> >>
> >> 	rust/kernel/alloc.rs
> >> 	rust/kernel/alloc/*
> >>
> >> If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, which
> >> so far seems correct.
> >
> > Looking at these, they seem to be intended to be the primary means by which
> > slab/vmalloc allocations will be managed in rust kernel code correct?
> >
> > There's also stuff relating to NUMA etc.
> >
> > I really do wonder where the line between this and the mm stuff is. Because
> > if the idea is 'well this is just a wrapper around slab/vmalloc' surely the
> > same can be said of what's in rust/kernel/mm.rs re: VMAs?
> >
> > So if this is the rust equivalent of include/linux/slab.h and mm/slub.c
> > then that does seem to me to suggest this should be considered an mm/rust
> > thing right?
> >
> > It'd be good to know exactly what is considered mm rust and should go
> > through the mm tree and what isn't.
>
> (Please also see the explanation in [1].)
>
> There's a thin abstraction layer for allocators in Rust, represented by the
> kernel's Allocator trait [2] (which has a few differences to the Allocator trait in
> upstream Rust, which, for instance, can't deal with GFP flags).
>
> This allocator trait is implemented by three backends, one for each of
> krealloc(), vrealloc() and kvrealloc() [3].
>
> Otherwise, the alloc module implements Rust's core allocation primitives Box and
> Vec, which each of them have a type alias for allocator backends. For instance,
> there is KBox, VBox and KVBox [4].
>
> This was also mentioned in the mm rework in [5] and in the subsequent patch
> series reworking the Rust allocator module [6].
>
> Before [6], the Rust allocator module only covered the kmalloc allocator (i.e.
> krealloc()) and was maintained under the "RUST" entry.
>
> Since [6], this is maintained under the "RUST [ALLOC]" entry by me.
>
> Given that, there is a clear and documented responsibility, which also Andrew is
> aware of.
>
> To me the current setup looks reasonable, but feel free to take a look at the
> code and its relationship to mm and Rust core infrastructure and let me know
> what you think -- I'm happy to discuss other proposals.

Thanks for the explanation.

To me this is clearly mm rust code. This is an abstraction over mm bits to
provide slab or vmalloc allocations for rust bits.

To be clear - I'm not suggesting anything dramatic here, nor in any way
suggesting you ought not maintain this (apologies if this wasn't clear :)

It's really a couple points:

1. Purely pragmatically - how can we make sure relevant people are pinged?

2. Having clarity on what does/does not constitute 'MEMORY MANAGEMENT - RUST'
   (again, perhaps Alice best placed to give some input here from her point of
   view).

We could solve 1 very simply by just using the fact we can have files in
multiple sections in MAINTAINERS.

Doing a scripts/get_maintainers.pl invocation will very clearly tell you
who's in charge of what so there'd be no lack of clarity on this.

It's a bit messy, obviously. But it'd solve the issue of mm people not
getting notified when things change.

However, at this stage you might want to just limit this to people who have
_opted in_ to look at mm/rust stuff. In which case then it'd make sense to
add only to the "MEMORY MANAGEMENT - RUST" section (but here we need to
address point 2 obviously).

Alternatively we could just add reviewers to the rust alloc bit.

>
> [1] https://lore.kernel.org/all/aG0HJte0Xw55z_y4@pollux/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/alloc.rs#n139
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/alloc/allocator.rs#n130
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/alloc/kbox.rs
> [5] https://lore.kernel.org/all/20240722163111.4766-1-dakr@kernel.org/
> [6] https://lore.kernel.org/all/20241004154149.93856-1-dakr@kernel.org/


I feel it's really important to not separate rust _too much_ from the
subsystems it utilises - if we intend to have rust be used more and more
and integrated further in the kernel (something I'd like to see, more so
when I learn it :P) - the only practical way forward is for the rust stuff
to be considered a first class citizen and managed hand-in-glove with the
not-rust stuff.

Cheers, Lorenzo

