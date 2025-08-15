Return-Path: <linux-kernel+bounces-771025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20961B281DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BD3BB05D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEC208AD;
	Fri, 15 Aug 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OTaQ9knk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E9hqeWo6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A87242D9E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268222; cv=fail; b=Sell599Rp86cjuOrphQToQnTmacj9cuZY+go2Wy4mK4AFlV7/EtVYoDHBH0F0CYH2V8PSHN0UFCeL4KVVyjnY+ILimDY8/TwKnMeH3YQPk+conUauT7uQJGWvtjTDvEUgctQuYupQ+riCTHaIkXjiRINjqwgr1GyoEFTqDMokrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268222; c=relaxed/simple;
	bh=S/8gInOl9BsWS7HqC3V1wrliAVssCvs/RCj/o/u+r8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHS4Y+vP/QVOQZdKDrAJHKF5WbRdSNFwPQK+q9VaUv5HQXsTZiloJiOGJc1TwO8n5Qh4/2f16gzPuP6LuJ5HsykIUhwLBfk71JTtrPwdQrmIwJXXacECnAEgQXBEF6vuCq+O+tC89HCHqUawDnHPpprUdcMn5THAcTHvbDUZ38c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OTaQ9knk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E9hqeWo6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FDNBOd017906;
	Fri, 15 Aug 2025 14:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qD8jXvgVqk+6x5mG4A
	tVXIoxoWFsVlzQ/PXw5DEO8eY=; b=OTaQ9knkbTWiI07RuLf/ORv5742Z0FDkw5
	rgS1MwOHhuvmqBvSeo8vKn+fLNkhtJ0L3JM9ENVn0HXjAhx563oTR80EO6TPCa8d
	+gwrI9nJpShLjFV6bi3sy5dc/iNK8dm9WIB0BsSxyBunBBXchUip2Vf9zU6zvgTy
	Lu2OxKdCELanmzJFMrQZrIU1rhwtwQSoMzHd9nV1hN1lUINvSKmowyq9nrqwQvP9
	s/6bomPb8jJvxsY9n1CLidlRmBnLBEq1ImD9t6udSYIaQwF+QFsC2JbY5zyyt5qa
	byvXT3koSZFLTivOl68Wuy/bp7IHreexvP2CWp77H5auoIJF830w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8em0jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:29:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FCU4Vx030439;
	Fri, 15 Aug 2025 14:29:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvse1b9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 14:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la4XBZ/yzapulD5lUd+UK1gotJ3pl+ybnE8yIYtrNddyn2NnfvEBvtDUUjivWyGP0MaIRpOLejr0Qx9jDcUO3rw1F9l5pBS6DwMmbXY8l23i96QGUPL2zOrAPj1fqWwOlmpuPiZR8LVYe1YqkSAF21tUVcCu3gto4BDYliQBV1Ht1zz06ZFegx6kNb4+dzNjStJ9w7Qe9wO9JhmFqoryne+VdkHncUAspPYISNqO5k1lAugr173/1XmDfPyorGo2jc5Z9bO6DVY0LlWX+uF1/l8NcSx01SZWUdDMJ0mzcSvDN9eZ2m0YOiSz461zHgBXuVHnI71YPnx124ZPA73CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD8jXvgVqk+6x5mG4AtVXIoxoWFsVlzQ/PXw5DEO8eY=;
 b=x21IhrbX+kS6xUrlfbiRjKiV0FL4w6R9PjNk7TbGBTBev7/BARLkZuq/VNsU33BKy9PUkwVQpnkMr5wJ3LJPblKqZC3LrjPs9HIFttQseJTAjN8cY5tZZyxEy9eVV7vAr1CKCfln9vlI7gHeXLm/O1GQKfd7q2Iphk7Azn1vbUpgJ+aOzdw207wNh3bimEgieo7X+WgV0wGZ3KPF2UZtqKgQzedCNmk+D/h6GW5v4n0H0XY/CnEHKnbED5xGPLJ/d9KV+TH5f99m1CBgLWs0Z5dRT6uR7apqSAWJ/cqoGyFKY4l3575OWeVyn8ptSTBsuwD1eYoQXHjOP3n9TTd1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD8jXvgVqk+6x5mG4AtVXIoxoWFsVlzQ/PXw5DEO8eY=;
 b=E9hqeWo6TsCuXXihHgu4Phy8yOUms8VeasLo8E9Td52BnjYqO6UbpnXPrnbeK2GEWIzpGWHmAZw4IxEbxaTdjgbLUiLfa5mJc2eAK8PTBwqIijJoZnGh2sh8YVfmKvwP8IPb8AN2gjeMKMNbRRZssjZnYQ29ZB1T4FwjY8dzQ/k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8706.namprd10.prod.outlook.com (2603:10b6:208:580::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 14:29:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 14:29:28 +0000
Date: Fri, 15 Aug 2025 15:29:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: zhongjinji@honor.com
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        rientjes@google.com, shakeel.butt@linux.dev, npache@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, liam.howlett@oracle.com, liulu.liu@honor.com,
        feng.han@honor.com
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite orders
Message-ID: <8e20a389-9733-4882-85a0-b244046b8b51@lucifer.local>
References: <20250814135555.17493-1-zhongjinji@honor.com>
 <20250814135555.17493-4-zhongjinji@honor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814135555.17493-4-zhongjinji@honor.com>
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 757fbb53-c02b-4a51-8bfe-08dddc08244f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jRkeyH9j6Dtyjp6/8lmmAFATK6Zvc5Er6F6m/D2+zjsRCUQbw2CXscCl/VnZ?=
 =?us-ascii?Q?T/S3Jhn/jY5nn7STnFCqHXdv7rSnBtUrzORtUy8n4OAnX+tM92AnUFykJUiQ?=
 =?us-ascii?Q?VKJ5RudY/8ZYQmA4c3nZJq8G7aVluNDLGOQqqZHArwAvtCgKxMhVUwMvRx4B?=
 =?us-ascii?Q?Ph3QL0L+HP2GuUSJcbI5EYJ/ZVl3QdDGI4CRRS+7iNnroL4qYebBZb/0LyN7?=
 =?us-ascii?Q?jdRqEImzyf+rZLhpisD1JCuSLdgQa/rOvHBJ8raSHIkthjUVWZp5++K5Y9RU?=
 =?us-ascii?Q?MIhbj9uSvUXQMPJAEfbrorRE9VnIQr4aD6lV5a3A6cwvZaoJq/FY9jaGJiUX?=
 =?us-ascii?Q?5lQlc0sew2QFwmv5rKVsAVbhpWU1FoCSGd2VSaKgYfu7zNWnALTKRqE+q75D?=
 =?us-ascii?Q?xSrPzgcm+Q83+XSMlIeQd5E+7Qi9AJO2V671diBkEddg4uq5qmpgRiSiZ+eD?=
 =?us-ascii?Q?3lj94ZE/HMWlc3m0fGnDKlWLVJ/Q6zjRU/8mKcFP4j0vncYCSfO16Td/IPWt?=
 =?us-ascii?Q?iYWAjVl3otOc3bul/rdPCtOGq7o4u7yukCVWOYZYpY1uyb/9rTyybhyWS3UX?=
 =?us-ascii?Q?xWQxIxIQjeMNyQdyoTjU+d9UGQFqxS9WSZ02m2TnB41bOqtRtfLshRfB75rU?=
 =?us-ascii?Q?ln70ux/ObRuzqcqAXfqqXLC88UlbSo/ZsdP7KIGVJBe8KtJQlig+rX9KWa41?=
 =?us-ascii?Q?+pxbfcrAbp6KtuVRgU8OcQWtKVTXh5JwbUc2WaQss57q/iuN6F8BNPw+yAMY?=
 =?us-ascii?Q?WfcbnyuKcevVoXfIt3NwNkRo1N/kLaH8/l86xOx8R/r/bju0gztdZ5jTo0Vc?=
 =?us-ascii?Q?bSyJPAUb21p/+jp7igOb/22DH5+6y8/o1zOsTf4yeZjUkpPShxv52b6ix5/y?=
 =?us-ascii?Q?rlMfN1aTbOszaaQ/H6/jWFf4Dpuxa8+wMXnZvgPFQ65msdbXiD42q36X3sgQ?=
 =?us-ascii?Q?EAfD8baVe6vJcgE5BglgbmGjueOSUsGt3KkR6EWQ4I0QQDuMGm5MC+eImCSW?=
 =?us-ascii?Q?oxuripbESF3loN2qCVu9yQ/K59LN8zkrJTFXiLpC2cMWlIz+T5D7SMzdC/jp?=
 =?us-ascii?Q?DoZcmEeV5EZVjfPePK3I03Y2/hZ59AHHGjsQ1eSO/4RG6E1KF2utraumk9hY?=
 =?us-ascii?Q?u8tj7S4d5qK1G8ellMH5yskOEWTArXNBJcu7u+xGe9BS1v6Kl+vStZQSOeRl?=
 =?us-ascii?Q?e2wuSn1WWpthFmVa2NlJlKdIgqDr1VIYgfQCeNr1Qb988QZ3zqWu2f3XJLso?=
 =?us-ascii?Q?d905peBEtGp4+LBp/BzHD4q7zUbMBs9d54F3XsCfM6ReqCtKkkU6rXeDquFP?=
 =?us-ascii?Q?Hx+5A2DJgs14jc+xGOsz6caaFo/AnBKWYsHGDvhLsmu/HC7bW6GTlsilPTtm?=
 =?us-ascii?Q?j6Mk9HRDctf8CuyYu/ymDnraNted4fjVZv52HhS6x0K6nJ0cD1w7HCO/JuSo?=
 =?us-ascii?Q?l/36x5veuR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQPNEdtCdjSRbMF6L5s7MHGIzFpSVlW4ff/Z3dJRvPceidKXQv/8OIXp1A2x?=
 =?us-ascii?Q?ZRAT8S0y7ElZuk7aQPQ/63QfPDUP8b863NJTrN8IC9fW7YyThHf06hpsGZf+?=
 =?us-ascii?Q?7DoSe0Sberqe+Dov1Sr71a9UNXCb2V3Sayc6cXu/bcAT5DBr0G+4VWZnmgzB?=
 =?us-ascii?Q?hk9oGTMCZmMDNs9+AI9mEQtWVUQYdSd9gVZu2L1lhINDQEMDcGYM1VFnmdPZ?=
 =?us-ascii?Q?JsndT062klfjVYZ+8hn+32IN7kM6rJXf2maobUB6dZLmrFoOmZKiVXj1meMg?=
 =?us-ascii?Q?dPSrmwtcxxXTLS2az0Jzuu8bKvrwxNck6xKyzHkSZX6fdQmWPTaGNVC04VY7?=
 =?us-ascii?Q?Y/Wy0f717vTksq2d/ZCsZuvRpMzT16BLJUhVg13Z7vJOfo6U/JOcGBikWE9j?=
 =?us-ascii?Q?abJmMJHXx5k4xgNP6jgqUs37o3P58JF93rgEmzMTz29gyYrRgMJ7T6X/On1r?=
 =?us-ascii?Q?nUxmDd5XGK9oFosnTAim00JehSTf0UDxjDUXbZoYEBfUnDw1pkv4PUQazX/w?=
 =?us-ascii?Q?TTd+kn1MyGZd74FEgs8moTCdlaioRJ0h5eETGIq1Nwi3qt07INcCyZlAY8WJ?=
 =?us-ascii?Q?I97R/o5sp2TxsVrE7EIw9gKpjEya6kYFk8y5+tKLi7f2+MulIXbApig+CHt1?=
 =?us-ascii?Q?xEvIk09uVVqdQjViU87aqlF9lQQDitaM5g3bGfTFeRsvPuNrtHq1Rg5mXt4E?=
 =?us-ascii?Q?VQ1BDZqEE7Sa3ug5+ZGP7FwpngYn+z7hvnyYpDJwxyZ9HAybXCf3CKy1IjsL?=
 =?us-ascii?Q?M6V65hk0WN1FBoO4xWi5J9lElqN2Qx2hdsebPB2EuQGQFQhxG1xQBiuIM1ed?=
 =?us-ascii?Q?XlxwwlPVPusVrW51E7hV4eCgTz9ARz9vKo1BG3vozbAZ8+cfTMMxXP4mih+g?=
 =?us-ascii?Q?o+RqKwqUArYS1ZSeMdALXzxdpuVfvSlyqT3K43n5XhpES8S+oLnxchF2F+8Y?=
 =?us-ascii?Q?CCGQaCTZvBBjOJOnxrZD0zrkygSDyXeLbP+ATAh5Gy6Ejt2v3cQbkrgQQ+wA?=
 =?us-ascii?Q?DLmOIe3gYwiCEOVRoDbFP9g6x5tw8aRtLPbYr5DLvwWck/T3+5P1EzB0zItz?=
 =?us-ascii?Q?QvYO9VH5EKeDDxx4gwCS1VmkBWQBGg7VoFdDt3mlHUhVR/v2p2oh7NhGH670?=
 =?us-ascii?Q?evDCEVJ63GjDgqq/h/097qIwL8r4XGjYSBFNmFrodb7e+2p1qyTmecT9bqtF?=
 =?us-ascii?Q?LSyZ8/5vwSgu8aKweyULx6P7yJFqa+h05QkTJIu5IAvs+44tUbYQX2pvU1EJ?=
 =?us-ascii?Q?8VyYXym+tGU7VSJNT7v/hS78lk2ZQ7ZB9Gq+4yGym5QZZFsHxXJFVd0p9Wk/?=
 =?us-ascii?Q?SMM09BdHWDC8peSL7xf7/dU9VSxQNF5616xVwQ4zz7edTZrfH1QQPb288fkJ?=
 =?us-ascii?Q?+N/UDIQS84fhCDr4koSJQWzHTiEcVfRL2wdNhkn0OYrZ4udrbQUZqbhjRvD7?=
 =?us-ascii?Q?PRJQ0Z6paAAMSu/SX4KH2TZi1LRRB5Rzl30ZtHmHelNkxYXORlItpIYuJhMO?=
 =?us-ascii?Q?JzfIk94qlMcJ1Gif1po1yr+eDf2Kilgf3c/kgbk8fx4UiSVwCZQC8lDjYi4a?=
 =?us-ascii?Q?oTaAoPxNzV8aySz6+n9hDFIZYaUWi/QLgXVHOKVC3KbTs+UdRC0r3xjQ9am0?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	apxVZxFeXa58Xn0Q7NZbt9R6wPVY6MtjLOlJTSpMENCPLs7vGExarHXoVU5/Yk89DjNvo93N5b78Krbmuwex39fC+f9gYcXGYsfuQ7zqD3tYP4B7aFcXHi58wJHp1tWs3utFDp34RE6+pV/yz7ChhzPbcvek4G0MsgA8aYHOYWaUE3YGMqVxZVSz/zV1FgMXaQD12SR19S7D2nlsKt7a15/jj5Gb1ZwL8KZQ50M1Sj0bKIeNi0ObrBAbcSJR6XVZuTFwWZVdBUuzEnfX729JQapM0yCFqAEe94Sec9ExJ1YEtDcOpbfzhtw82TqCOEK7SIBap80YuHxDsqFo66bI8wEKTz1+Exnx7RKjv+4xiRNX2KSpcauVG0C1gt+vTkGInw3i3qp5Ng4B6tMXayo3mDMpPxp4FTcsbCMzDj42Ozry7BwBBKCd7W4EBygDEdykA0M32uNSCW8iq5bMl3X3d/WDwmykZnrGJVlnNyc2l1Jh5u//L4JjcFgL4scF+Io6cbnTONhI1alv4wF2CSIr5NpHuWU/1GH6qsFnFXYFBh8aFd80cKIXBHPiW3WvBGJFzjZ37pFrd2lrnA5fNrBArZJ0ry+I6XgdNm1Bu1lT2Hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757fbb53-c02b-4a51-8bfe-08dddc08244f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 14:29:28.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeD+mkDbx02dRhPgv7qS5FtoP6yuNHIV8gISBdMI+0SU3FLfW23oQQ2VWeQuIxjW+y5RvHOzB05GC7cH8jU9Vq0D92EF0TWXbzKfglpkwwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508150118
X-Proofpoint-GUID: ldK2IVDusGL3Cxj9Oi3RTIn074OUqxpR
X-Proofpoint-ORIG-GUID: ldK2IVDusGL3Cxj9Oi3RTIn074OUqxpR
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689f4451 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=CvlTB2HrAAAA:8 a=u8PfXykuwFty4D-sT9EA:9
 a=CjuIK1q_8ugA:10 a=67QrwF-mucXG56UA-v15:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDExOCBTYWx0ZWRfX8dT60xi12uFM
 N4J94xPmYkCbK0SQLY3CqUvrGaLZ8bPhgpp7Yn/wAUcPFh73uGUtuVXsLHMuqEI7LcQdE/xZBTZ
 A/jNZdbOjmLvDfJao5fWRXbFUvCaKillF5ZUMI7lHNgkHEQAb348T4tWHi1SMFeyNM/zKVjXrVs
 UyL/6A4LzHCj8CmMYPq+yzzavBBw8CmZmpJPRc6+L0WNwvcnnv6+Bl6GyiWmqWLNpFbe+UADjK6
 nOHe7i1TftnVs3PSbsfb+h3SoenoM4Dm2nVIwzEuE8PIDZyZl9G2DM03GbumU7Pm3eSV8a3/GkY
 tuEfLzXoWQT4Nm20HsW1Wsu/Ttj/mWlHb6gRYhsf+G8pZWYuIt6SCqPXMkV/nQ6BucpVXSNVVxZ
 8UY//UCtJLDJ1aORQsG6vuNLFjNRBVr3J9N7KvOkd4WRvF0qXNemf/olxjo5ZkrNmTc90pWa

On Thu, Aug 14, 2025 at 09:55:55PM +0800, zhongjinji@honor.com wrote:
> From: zhongjinji <zhongjinji@honor.com>
>
> When a process is OOM killed, if the OOM reaper and the thread running
> exit_mmap() execute at the same time, both will traverse the vma's maple
> tree along the same path. They may easily unmap the same vma, causing them
> to compete for the pte spinlock. This increases unnecessary load, causing
> the execution time of the OOM reaper and the thread running exit_mmap() to
> increase.

You're not giving any numbers, and this seems pretty niche, you really
exiting that many processes with the reaper running at the exact same time
that this is an issue? Waiting on a spinlock also?

This commit message is very unconvincing.

>
> When a process exits, exit_mmap() traverses the vma's maple tree from low to high
> address. To reduce the chance of unmapping the same vma simultaneously,
> the OOM reaper should traverse vma's tree from high to low address. This reduces
> lock contention when unmapping the same vma.

Are they going to run through and do their work in exactly the same time,
or might one 'run past' the other and you still have an issue?

Seems very vague and timing dependent and again, not convincing.

>
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  include/linux/mm.h | 3 +++
>  mm/oom_kill.c      | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0c44bb8ce544..b665ea3c30eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -923,6 +923,9 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
>  #define for_each_vma_range(__vmi, __vma, __end)				\
>  	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
>
> +#define for_each_vma_reverse(__vmi, __vma)					\
> +	while (((__vma) = vma_prev(&(__vmi))) != NULL)

Please don't casually add an undocumented public VMA iterator hidden in a
patch doing something else :)

Won't this skip the first VMA? Not sure this is really worth having as a
general thing anyway, it's not many people who want to do this in reverse.

> +
>  #ifdef CONFIG_SHMEM
>  /*
>   * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 7ae4001e47c1..602d6836098a 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -517,7 +517,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	bool ret = true;
> -	VMA_ITERATOR(vmi, mm, 0);
> +	VMA_ITERATOR(vmi, mm, ULONG_MAX);
>
>  	/*
>  	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -527,7 +527,12 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 */
>  	set_bit(MMF_UNSTABLE, &mm->flags);
>
> -	for_each_vma(vmi, vma) {
> +	/*
> +	 * When two tasks unmap the same vma at the same time, they may contend for the
> +	 * pte spinlock. To avoid traversing the same vma as exit_mmap unmap, traverse
> +	 * the vma maple tree in reverse order.
> +	 */

Except you won't necessarily avoid anything, as if one walker is faster
than the other they'll run ahead, plus of course they'll have a cross-over
where they share the same PTE anyway.

I feel like maybe you've got a fairly specific situation that indicates an
issue elsewhere and you're maybe solving the wrong problem here?

> +	for_each_vma_reverse(vmi, vma) {
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>  			continue;
>
> --
> 2.17.1
>
>

