Return-Path: <linux-kernel+bounces-747989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D81B13B13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2A4172387
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1EB267732;
	Mon, 28 Jul 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U/X0g7hg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J8zuNuw6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C12673BD;
	Mon, 28 Jul 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708399; cv=fail; b=UTEmlNiFB85AlOLCRACholRJlsYNRqo2u5hM36CN9n3fcuLjAC1pZ5nY5gSHC0dBeDwiR1aKC05fFElslXP1FEmNZCvIhDCWM1aCde14re7Jj3rmK225hqubV3GYGHCqGhTO4gT/w4uUert/hZQMH6SewvPPWE33z02os7qMpAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708399; c=relaxed/simple;
	bh=+dIavm9uldr/xQEYzJUjXxRiW4eE4S84SixzSkC5dNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cf7sIIuSW/vg+9Yr/lmvSJ4/3HTER+1GVNuv+baCNE/KCwRz2uEuzJ8PrEJW1IQl7OsWY21hJQpzyk3tVQ9DB7iHq/2MwM/lHwY9zyJIynm/KTbQe29aQXm8llygy1C7khkQeOaMyqkr6lpwVXwzgttN3H8bsfp54EvxHDDi+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U/X0g7hg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J8zuNuw6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDC9di009674;
	Mon, 28 Jul 2025 13:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+dIavm9uldr/xQEYzJ
	UjXxRiW4eE4S84SixzSkC5dNM=; b=U/X0g7hgjZO5UeG1+feYvNZ8JSN2Jew77B
	KMq7WiG6NjOsIzkthizIPfpqAIg9hEk3M3PAxhJPo34YAl4y4M/AC+FT9yviaokP
	qJQqWRKJbe0gZ5vtOZrAQe2+WA6UA1R7+5ViO1K2SHhEj2NiusZLc6NgG6VYWr9k
	XgLd4Hg6WvdgxLcIjQGtiwwjuKGQRoivZMdkdmq4jd1oJoyHTIjwS577bcaouJmk
	cMOMEZG3oNDycvVl00LZCA5AO5CAim/ie64llqoaLqDPEgC23oSaddQv/s7OmVk5
	mWNBShK/3yCHADNsphaBEN4y4Vkzc2I5gJJVb077ByxdNfvGEnrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q72ukk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:13:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SCmqkq034558;
	Mon, 28 Jul 2025 13:13:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8rw98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLivkg8/MkWQs77KHcKsM166PqAMV4owUHQleXAp6Nah8tUu5gPcyw0b5kPlnUCuTahGTPjn7l61qu1fKYIq+9vtRouzscOyhNlFhc7r9N8N77BrYRrTWzPQSwcvHECUFqtvNrBIUTmhIYC+80UBItaGQ2+FyZCQWzd+AF3/pDh/g3JAgZ8PHp8JrotPWXe1qa3bI4YUhNizTOAoX8AZXFuipiaz02aG++K0dlG+8EGH358OL9ca9pT2I/SqYFtUHLIQJjnS7W87Ne7mn+OjV705PH0KosQGe86DfV8Pf5cyh4zucwj87Ieoa9OWCvLInudrYSl9oDSiPfr+ByhzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dIavm9uldr/xQEYzJUjXxRiW4eE4S84SixzSkC5dNM=;
 b=JCy+SuU1YnE11NRiVx2K50SZ2AH7yUQNTY2JwX2uRAhF9/0GPfQ8XUlkZXpYK7Oxp938T7aiVWx7x0xdvyZUz91eowzvPCGy/1JDw2IRfOmbCrzC30rgFkMIUd/UPEQCLKUxgv7fl+UrgSXjv4bP7kypDn5T+izaX8zt+oQkdd0C2hlvOzRcETBX9YZydixqj1s82ZeVr6foxqtBEyASGFtbS5TWUPTa/QXvoUec1v6+o5/7Pz8lzWbiurr5Di4KzWMZRZYMKQRJbFDHauSylRWqPSHeaapwd8T1K9EtHLZR3XLu3Us+iFGz7AneHIvk9az17W5KT+jc4l4rEBDGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dIavm9uldr/xQEYzJUjXxRiW4eE4S84SixzSkC5dNM=;
 b=J8zuNuw6nVdbCEG6zJRJMI3a/6JU75Nm0S2SdffOHhGdeOxwDh8EWGZb83LkhZQBOhsIpoiQsm0KcSk0LWMfItA1LZnC0sIsgQYRrb2APMczEalPsO4d9uofw5gfKrWVVDBe1qR5fv+Mi4gzO12Axri5YaB1K+kzfpZJyFQeLMg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:13:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:13:05 +0000
Date: Mon, 28 Jul 2025 14:13:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
        konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <c4974be6-6076-4833-bada-3012d3660a8c@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <aIdw3-G04QQPvJtU@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIdw3-G04QQPvJtU@lappy>
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 93583ae2-8032-4fed-aef1-08ddcdd87d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OijBPFzFKhB/ZCmDDoJt2rYDvT10DrNKXqUcP1ZlCGqUUDPcbo2EH/RS6kI9?=
 =?us-ascii?Q?5UkkD9n53uzR9ZFHnYLeg/BwYiqcjumwF5xbnCrCEZ0Nec5miCDmNuUBiQoo?=
 =?us-ascii?Q?wQU6koVpGZxvJZZvxhsHesJxq4sk9DOHkU9IVCfmqK3G5PvAaXTab8LkORgK?=
 =?us-ascii?Q?2gKmTVkB8MlyGU+5DRBCU3ilpgWR0RTLq2kDq5bXmQ2haO7u6BLR7neEU377?=
 =?us-ascii?Q?YS14IHASZIlHfy2fqmuRvVnYTzQypF8irPqqWLWs2Ja798pBgNe+bgikHsop?=
 =?us-ascii?Q?gW96eP5e4Lh1Uq0MGmFoCBNWvqUAVEi1BIKo8pvgU8y+jQEBO3iRn5m+eGIk?=
 =?us-ascii?Q?nxvAvvHavv8W5+9j+sc5l63DbEF7L014EQB+xB/AzWX7lle13+VXNvyaDa84?=
 =?us-ascii?Q?wLgA3Auh5Omou4ZmbqiGslanD/Y3SAEkKaK4wJxkN2Z2xsCuLS35zJTr2dCy?=
 =?us-ascii?Q?fEuz6EW7jA34bXvYYZEwoHP+X4w8sPuRWMKM1ut6pef+salG6YJqFoVzJDlV?=
 =?us-ascii?Q?nUt+6cKjJzbQFHGEDv/VwRUKrt33zi08+0CbcRs9aw7t2yejTbMm4qRrpGPn?=
 =?us-ascii?Q?2hsbsxHXrEJUz8+9kAlf6RNEfxF/602kkh5025+KPB8VUVBvoG7/LmnDkfgQ?=
 =?us-ascii?Q?c6wwNBw5BBdVu3A4SmX66Gz+qifzCgJ0uOL2cP7rWNbM6ETY1xQjCqEWVd1b?=
 =?us-ascii?Q?tZWAwrELIdPKfsD0AadQDHh/zItfsAzCEYuApFEU7n76i8KjKymyLg5RPQry?=
 =?us-ascii?Q?X862khWwLYHxp+yS/FcE6sf6A63ub+ZrSwQjpkcc4po/Ow59bBrlqv2hNy9N?=
 =?us-ascii?Q?ECiBefUGy8R//NC6ZgPJ58QXgu41eMu/qXHvp0lWrcXS0f7U/20L9QOho82h?=
 =?us-ascii?Q?6tUtkh//KDpd2Bb064GIRiFNQBSEuoIUzAyqoKuJMq8bFtJkEMpyu7Ao6Jyb?=
 =?us-ascii?Q?8KLSaGNrZf4VgScu+8zZs52Yw5TR70X3hgqDkLd/tvF7nzcOJBrL9w9jebF1?=
 =?us-ascii?Q?Th7mjme77ZQMDQf2t7AVArlsdsAstPHp/N43yXJASRWueuJ73i/Utj2Mr9NB?=
 =?us-ascii?Q?CIxRaxZfCR92egUL9aE38dTno1hBWtpvRv7+D4eOgno4H5DQUuWr81OjaMnD?=
 =?us-ascii?Q?wXKgWNJ95a1WL/+DXH+MBmtU/aWEKP/2eqCei2EWA9csWTSNiTk0yXZ7OuO1?=
 =?us-ascii?Q?PnvsFYlWOsie2voCXgwnwzu3lKfC++/lMw/PdQ7A5qKF9hMqUOjRUS/md2zT?=
 =?us-ascii?Q?H1Jq5Qigm6hAjf01Xesgq8yH3Fl7e9Ad0J16BfsuRCHwGlQKBV90q5sakTTq?=
 =?us-ascii?Q?AFcNsd+Dm8QTXrcJOevKhVB0G7i7xg3juLZ+zUglpJt6xC4U6uKENmUq2lr2?=
 =?us-ascii?Q?j3rb67Bz0biw88W5eIWl6AsZe8eitNEQ9vGnr899XhKvnW4Fcth45I7D/rRl?=
 =?us-ascii?Q?z4aCbaovfNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p7CFBGItB4a759lYhu8yuZxxgyDm6H2XIXyXn5uOCZAKQlflzMvD7KLRXAKU?=
 =?us-ascii?Q?CSs0ct5CZdrlPobe3uHno886rZRxuou5XOD9NeFNdUZVcx/H/8BfdilE7DkN?=
 =?us-ascii?Q?dlUu89EH8j9zMUoKAlvTQo6FkjRG2nRC78XHnKH/h7QRm88DkXTXDCX81a+Y?=
 =?us-ascii?Q?GZCPTZ0C8wfBuASzWoCNn01ruxXBhAJW4PeI2Dnj5B/cbCol1Z1cOQuaIYe3?=
 =?us-ascii?Q?r7v0a4RxrbnjURETqNbNXIG3827h/ePD5jlCQK5osDSZT4BuR3kDPZ2KRizB?=
 =?us-ascii?Q?RcATWGg9WZAn5DK60PX77f5NtS7bLXrNxXrL3rL3gYxbTOg6RozQOv7SRHdz?=
 =?us-ascii?Q?Ur/iWr8vB08d7P0b1wAQobpzq3iuqsYi4rm306/BOVcwK6+/JNsavXaW59sE?=
 =?us-ascii?Q?k0f9P242p95xwbpJJLjWLR4AmgqcnfY0db1Z7SgAAnNtQgkqruKFmg4znme/?=
 =?us-ascii?Q?z7Zs7v2+l6+khFj6REWbn81w7dY46CSH8FriTgtcdLZf5QegVebRRPwUTOd1?=
 =?us-ascii?Q?xfVQVhdnsYS30sYDnt8o1pnO1t3/0RL5J/3PPUE8R179tUro34DHN3cz1ERW?=
 =?us-ascii?Q?ceOXPiWupsaH2ie+QdJckUXkWHiAR1pavodeJ50eiG5VALfPI/p+5RXmrgwQ?=
 =?us-ascii?Q?u/gVokvnacz8cwTP2XRTy7iSr+xP3uQBeS8fz6ML/NmT5K6ifnn5vxhuRFVR?=
 =?us-ascii?Q?1T64MdGswfs7zq+59LEBnVxWqBJ3VvqTJQKd3Fdvv6Yft6IaXf/+llc9vPSy?=
 =?us-ascii?Q?jSduS/dWcxPj3VXMIxZ3sIJ9vSO1KtX5/mAvtlr0bsWFxOExbIw+gt5QNKFl?=
 =?us-ascii?Q?lf6XbXdF76dmG/uHE+Hg9mE9Z7Nc3Re3wsZd61bE3JPvRGadFKmA6qYgAt3i?=
 =?us-ascii?Q?FcugC+x8nafUCErR0fjPctF3SObZnrqLShlas07DY705HQLtHyhpzKxSqi04?=
 =?us-ascii?Q?yoE/RukkkYysS0H98JtSmXdAiyJbljqawsu0HQNd8Rtkbn61MkghCTrFzc/L?=
 =?us-ascii?Q?hwTOiCxU6tnfIQBMp4k/4ehYjuUpD20SCUxJ1WMc3/Dn6WqWL2IqjoxS2tMC?=
 =?us-ascii?Q?scg4dFdPytATDJX5xOG1o6JnwmQeMyTb0/VYTkYdEymfbGhtGePNpcWqlZiU?=
 =?us-ascii?Q?hc2vW+whjni7QkaYrQWqYqIFmBp100hDASkd14o2W4eki67WF1iQtDKyPv0u?=
 =?us-ascii?Q?q9kJrZGoDjQMImtfTeTgdiMttb3vScQuvmwuEqK/bhA8s/e6DsBtBXxjpqV9?=
 =?us-ascii?Q?rZpHukbGMLjoUUkDz/+E2F7GMROfWEStekFp7/MZL8QzRdgmSd7MRuGB4LJe?=
 =?us-ascii?Q?irYsWAR8vLzXFaj/OnlHqJolZUWH/QfP6MKd+Nv+po1Z3WrAfGzmp3KhlNPn?=
 =?us-ascii?Q?ypiFll7mLSxSXXDeTpdW3wyePhS4r08DscliqDZJ6cnTXp5J5vQPQO1xde9L?=
 =?us-ascii?Q?MRQQZNMEGug3qWGcQZMtjvXbEOBCl5u08n7xUiXfpIM/mwfsOyRclXPYdkne?=
 =?us-ascii?Q?p7pvZ/kxU+C/Dvqm9S56QHGfV98lrm3BHd6z0JTn6i7W+qdRpp4j3Hdka8Xg?=
 =?us-ascii?Q?nPk3/v6EM5Mlhj1CJWip7nHKJALp2dWIU4V48uE/qut4Fh5TY0Bd0Nbmo5R4?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXUFWH8iDleUx3zAF88AXfZnD4GMVZX/xrZbR997jbBJg5ldWNOpWOQm+tM4r6qk8HTEZ9LnQeK9UjiuJ3X0vfUiSI2G3heARZxYEqnKTVOKE/S1Hv8XojWsV1zuiWP/3Yt9N/FlvSyjxIlKmslDUdFHnSfMamT9DzvBfbPCalrjz1w8o/PRk2z42G5yfVZo984SKAcOnZlon3ykIcuJ03UvTjeDg7x3RuiQJnYRtmteiDxT1F7BMSjUcGrpBk5gZUTRfII6ECf5tcVhzYH8o261WP6PWPII9iOEt9NVc7HUoSMfTOlw6PUYD+lG2AcmRrD1bqBoHbXlBILL3AWr05eClSfkPcjT7sjeE6Zoj2SQxisds7hTQKexku6ozU6moc3A1JR6//BY4+we9ViWCEsZMUUmjteFyEmyUeP2KBP8R/ZXgR/wqrQJ4xEtbDBBitBNQjHcDYYl2MvIcCd5aU0U6VMY97NqSAxI8hMp4gEzWX5oy0EccE/RqmIM1XfPqDV7O2TuDS6WYFf7m9JILdW8+vWwU6bqOmKG/UVXUXV8ddWqytsNTo1HuIvKGl07o9AceMDZdbJDXToIi9JrIlNJIeN0olBmOatnTUFJmi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93583ae2-8032-4fed-aef1-08ddcdd87d27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:13:05.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tX+1gyhnR7F5SqyNHe50pXPPgEgUgR2iyxYPttO3wOI2OnJ5At+22trzkpRD9WHn1ALp4h2W/JXXl0udgCrvbUsnzNRgz+l7moggBwaVIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5NyBTYWx0ZWRfXx31WLiLVwf1u
 4hMHt8sp+1NPuXsUZMuQ3HmzxrlOPYSSAXt3GH77uHNSVG/0QglFR7TS6EwoWTn94CARSIwBJMa
 Y5gXFxIkQWqmL00wy33TFBRvvv3kMmn3+qKEhoDP5ZctTp6cKZ6kLSyouruCdWGtyDFYd3sv8uN
 v6047Y908sY4C5R9cRqG/Z7DhN8cBIARdnH9QNv/7axT+zs9FhCEYAKI7qYW8dozXB7Wpry3Zj4
 S20ExHTkIRPhnFPDl1ACKCOlOkJexB/I184lvgJinXIBW0uNsh6Ip5bDYP/qFs84kCsvPAKiIb1
 Uv5FI6AHnmW2Ub7IRuB8GgDDG1gy6NUCxu3WFGP86IDTlwsdzxtA/1hVAVvO3LCEnaZegtgwWxM
 uaXP2mMMLWzKJFsOXni8jtYpVruA4Mo2WS2zFNAxMABAqrNcVs+eCDbVzKi/Ehi55oS6RikI
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=68877765 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Pvswb_KX_hapZqTZfj8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EjO0LzpA68xsUHqbca3OrXH_miBr98vB
X-Proofpoint-ORIG-GUID: EjO0LzpA68xsUHqbca3OrXH_miBr98vB

On Mon, Jul 28, 2025 at 08:45:19AM -0400, Sasha Levin wrote:
> On Mon, Jul 28, 2025 at 11:52:47AM +0100, Lorenzo Stoakes wrote:
> > One thing to note is that I struggled to get an LLM to read MAINTAINERS
> > properly recently (it assured me, with absolute confidence, that the SLAB
> > ALLOCATOR section was in fact 'SLAB ALLOCATORS' + provided me with
> > completely incorrect contents, and told me that if I didn't believe it I
> > should go check :)
>
> Heh, I wouldn't trust LLM with anything more than mechanical
> transformations or test writing at this point :)

I'm glad we are aligned on this :)

>
> > So at all times I think ensuring the human element is aware that they need
> > to do some kind of checking/filtering is key.
> >
> > But that can be handled by a carefully worded policy document.
>
> Right. The prupose of this series is not to create a new LLM policy but
> rather try and enforce our existing set of policies on LLMs.

I get that, but as you can see from my original reply, my concern is more
as to the non-technical consequences of this series.

I retain my view that we need an explicit AI policy doc first, and ideally
this would be tempered by input at the maintainer's summit before any of
this proceeds.

I think adding anything like this before that would have unfortunate
unintended consequences.

And as a maintainer who does a fair bit of review, I'm likely to be on the
front lines to that :)

>
> Right now the "official" policy of our project is that we accept agent
> generated contributions without any requirements beyond what applies to
> regular humans, which most LLMs promptly skip reading and go do their
> own thing...

Well, that's rather implicit. I'm not sure there's _many_ who read the LF
page on this and saying 'aha! I will go and send some AI-generated stuff to
the kernel'.

I think people are probably wary of what kind of response they'll get.

Merging changes like this will inevitably result in people thinking we're
all good with taking whatever.

It's silly, it's not logical, but it's a human psychology thing. And I'm
_very sure_ you're aware of just how... 'delightful' some of the press
coverage of the kernel can be, and just how 'accurate' :)

Sadly we do need to account for this.

>
> So I wanted to at least force LLMs to go RTFM before writing code.

Right, and important to get their authors to too!

>
> > >
> > > > In addition, it's concerning that we're explicitly adding configs for
> > > > specific, commercial, products. This might be seen as an endorsement
> > > > whether intended or not.
> > >
> > > Don't we already have that for a few things already, like .editorconfig?
> >
> > Right, but I think it's a whole other level when it's a subscription
> > service. I realise we have to be practical, but it's just something to be
> > aware of.
> >
> > Perhaps an entry in the AI doc along the lines of 'provision of
> > configuration for a service is not advocating for that service, it is
> > simply provided for convenience' or similar might help.
>
> It also gives us the option of dropping some of these if we find them to
> be either horrible at their job or just being abused.

By implication this is saying that not dropping is a sign we're ok wtih
it... this is the issue here, policy can be perceived to exist implicitly.

I mean as I said to Greg, we have to be practical here.

It's tricky, I guess simply saying in the policy doc it's not an
_endorsement_ per se, but rather provided for tooling that isn't
egregiously broken, maybe something like this.

Cheers, Lorenzo

