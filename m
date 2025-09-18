Return-Path: <linux-kernel+bounces-747428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8DB133B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF89175415
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF95215F72;
	Mon, 28 Jul 2025 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+OyJ+7t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VALYoOCh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE61E5B91
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753677260; cv=fail; b=o15fvsAD/I0IWjZrSnvEPa2TWzW4aV6av/4Su3U6d4GyuqMgbHi2qY3XJk5DkgG24bigLwj2qfwEFmjfelt2631exSoc4vuwnj/zjwIHRpdug5ayKhP8MFfFusuaBJX9i1lVrvhGGAbXYlHNtKMKgW0LFhJzqOilFKuxmMf5zco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753677260; c=relaxed/simple;
	bh=nMYiEGCG9nbxwqDNqtTCWAmWXmkYYIj8L+aMjzWOMP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OK3F6xUdVuJlD7g2TUgfJwZ28d5oQD1nzPrAfWV3vJzpVUEVT5jVbMjyAyfze9SdhH+5ibJ9CNeCuFJrgpt3fvVDbqjaj9dN1LjWli4QAdU8R9I1Ct7r2+nH4/6ntbITdbPRMG3mvVThCzn/unECtFxSVD4XG7+q2MyLvyjLdXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+OyJ+7t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VALYoOCh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RKvJJg016417;
	Mon, 28 Jul 2025 04:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nMYiEGCG9nbxwqDNqt
	TCWAmWXmkYYIj8L+aMjzWOMP0=; b=S+OyJ+7tL/bCOFyuOQ/U6/rjPrU9+Gq43F
	SESCO9+Je40QP93Ea1KOMlVbyUCWwW1yFa7DY1SS9OrTO5OqCyvZ20nwHG53rSeu
	vlu7XLUXgwOsPaFA6wtDtfVLe783MvmV0ga09V/ibDvaogAGlL0z8bfA1E9QCwa3
	BJB7EdN1nq0k9xnrZqC78gjL3FmRutkyNzALPE9MrSxUPlWlhWfe2z20iokSXzla
	GHH/5fWs7CzcUvXrdNxlIffd82X8yrDESxR12xdzW9yBYHHErVGbQMyTDUC6zGq6
	cxd04F0Jcl3RQSM7OkhbA6axPMa6BlWitR++9yPxJ+W9PfU0uNOw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wtbe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 04:33:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56S2mKGa011302;
	Mon, 28 Jul 2025 04:33:43 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nf7sre7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 04:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGu2yIKlZFHwbaSErLeLZrc50vHA57cnjZJsRpC005ld4qJ6nnmBraKl0ayGrpdxnQzLJir4CAt57bib794dk29HD/72OpGzg02BLHBmaCVOTZcwuF4ncyEDex4ahKHDd+ORMsOUFH2hQQfqDL8Hw6m12njNmJfQu14S9FMOlA2J2BcUICEeC+JdvfcpYCnMKHUIstRSTT8JPp72DE3SISCK70qFP8PGRlkRgMc4h5yUzVXt3/4G6xMcVZJSHrwSJnMsuKMf4S4TX50Z5FzG+Ow8Miv3JVqXAyPFNf6Rr1+qL611McGUBz4Hp73c2x0s8ZR+IUsotncxfcBUci7ZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMYiEGCG9nbxwqDNqtTCWAmWXmkYYIj8L+aMjzWOMP0=;
 b=HqwNphdrtq7qzt1ontG5AaqF8sKHgKZ2/9ZyHTaannjTsCvpduP1XbDo7vvnQlS2bRXgjTB1+q9bBKsmP9cG2Nm4xQzlu642Drq4chrJcC3vj6wkzMg27NHC4tmy5ivks1v6HKSsZDAqUF8KBhdorhspGS0svLt31jPg1aiFS6SzwLKFgQWhO8yUtQDWzuVA//dzbKWRyvbD+fhL3Ax0/DlfOuE0I2glzYluKxOvuC7RhiQqKgdslX/GTxtZsqjF8CUlAmpUPBpkXnp3+JDUR4x6AXJxi3WnWwUVA4OcVA5WKQKWICLBXQFW8opKJy4k0qfhE1bzkHA4FvDe3/y16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMYiEGCG9nbxwqDNqtTCWAmWXmkYYIj8L+aMjzWOMP0=;
 b=VALYoOChXDCpE5PKICs/h/Z3rc996RhnPnRP4rGnRtNLvBKHtQ1rQSS+CwZSCyRiFLxUlqFJkyLAUoOc2SiXE3fYBM4T22nRGlJmuUZ0MAN0hQV6ZpRxupsalKwjExAOzYtfan9LaL7PVNlrSMFDy7iu6L0bgXstCkvTK/4de18=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4136.namprd10.prod.outlook.com (2603:10b6:610:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 04:33:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 04:33:39 +0000
Date: Mon, 28 Jul 2025 05:33:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
Message-ID: <23b583fc-e98e-48f8-bc8d-fbf7b47a188c@lucifer.local>
References: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com>
 <aIb3In3G7XygrXNT@harry>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIb3In3G7XygrXNT@harry>
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b18a88a-df40-4fcc-234d-08ddcd8fecd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTju50iv3/b5ESsn08kHDbwuLlCeRQ0BvvCN2sf278gTs/R1+hVwGoYB7N0K?=
 =?us-ascii?Q?KlYfzMLgge15KnLV+1HD6ytsZoqufIo3Yzv4doLeZvCyHnqrMYV0iAT4siIp?=
 =?us-ascii?Q?3xiJ5ZJHVlskEHkpubVTKFBfoJ6EBHV8LPqJqB4M1yk2ZyFGk60A+kLAX0uu?=
 =?us-ascii?Q?MvqiZRm9odiX2SUqDH0puxmyshPnE4TYENqB1KGlX6rXarGmhEU18e2eO7G2?=
 =?us-ascii?Q?Vf0Gci+xxRabJ4IrzUexud1lrCPHZtbIivWqpWBAMSmKMszhRZCNw5FOKPAc?=
 =?us-ascii?Q?qYAkeeCTBSLkhRL3GVNegooZePDt3fQARV3JE7O+eT9D3UGLDsirgPeWXOwU?=
 =?us-ascii?Q?3JsEBR7LNwc4vWdyolBgMJTtGy1015ADswrRjiRG5Fa3n2cZ8k4KoZBwxtXy?=
 =?us-ascii?Q?tVirN3hJPAdemYu3co8HpnoqqwAwD6+3taZsVKBW8LPx6nkjYa9vdf4HQw8/?=
 =?us-ascii?Q?Lbq1ZSmu3KbuAgSgDDHEBtG0d3Dyr6cy6t8YKRzqWLoau4ECIukRPIU5QFGP?=
 =?us-ascii?Q?fcnBL2BMhlRMpREH028mQseoGkz9pl+KFAkDq3Zv0TG0/jTY6qu23xlG6pLG?=
 =?us-ascii?Q?M0WKw8ZdkDaqkU/ajrGcBhmYCQ4DTTtq6XgFfKyxfNIIAEd4xi+ypeOG57MB?=
 =?us-ascii?Q?Z7JUDShm0t4wDkTMof0wvZXdlDF80QR3mv+uijz9eMEr2iF2EXiUys0DOPoU?=
 =?us-ascii?Q?jVpeNE1b18c/cf9fgh0K0h9JaW4OXXRKKdVT4iVIiQOemSo1uxWNLTmKM0Mt?=
 =?us-ascii?Q?tGu8TJRp25borGM1MObq17ReeQgJ5hqsygtIFVA22tBCmozuGToB0vEgcLLb?=
 =?us-ascii?Q?tABWlW8pjXb420PKWdSoBxC78Y8uLWd2yAKa2iY4VWYuJcfzif51rTmH3SQK?=
 =?us-ascii?Q?TlaK0INPp8OrE8uC4YkWyDbSGG9GBmEICqEce76EKfGx4WmhsdVpyhbxAgzO?=
 =?us-ascii?Q?GuVGBRXmnnUROO9hI8xX9XOuF1QSZjBouEwHhCTPCz7P9z4uSPhnxNnJv3Rb?=
 =?us-ascii?Q?Hyve6YgiskZUVhfLNuhVJs7vj2Biy62vd4tf/jN3b9Km86RaZqu/eDQQNukg?=
 =?us-ascii?Q?RZ2P3bobEr504UsPCccz2yK+VOjVFQY5OOJ0NLPyz7ppnZgNb7raPrnMbqXW?=
 =?us-ascii?Q?7ZeiscRTcdk+cNReZ2vVNVEXN7WLHeYfkI8SvuTIFwQYW85rhA40kFYpq3Uu?=
 =?us-ascii?Q?5xZo5hdstK+Tp/ItyLG5NBtwQ/Mm87ZKfGHuaHVdq/YY2WvFoECyonONsICW?=
 =?us-ascii?Q?bl81ff7uKvnmyXKae4sN+AXEb28V2mGTcW6m3HeUrJCZQ5DvDuj2zOA8qv6G?=
 =?us-ascii?Q?97BslhBX5cPUUxLnA5bEeyUUAxxF/xKc3PwSH4MPrxWhjlNTnbaoiouHf5xY?=
 =?us-ascii?Q?CNKowsxNV/56QNuVaoSTzr11npAGBpNJ23YyRY9rnmvpIM3DqJveKlFH2OE7?=
 =?us-ascii?Q?cfBWNNPsr7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?liq6Jr3ItL+eykU5BJkJzZTuiBDAAxdEFCA6W3xckDb57JLOok9hSEc93WSf?=
 =?us-ascii?Q?Khsg6TFjXAxN1HMVCdrNf2uKjv7TYKfEllYS+3URQia/w959atXaNycZ2acD?=
 =?us-ascii?Q?dN/GawDxcXDyt5IGqah3rUC4sCwA14QtMGWMepKhM8Gyt30TJvfRS7Jee0oa?=
 =?us-ascii?Q?UEYxS3o3XPqCIE65tbGmIkL4gjn12IKrI6WCC3W4teF0CNUawIm/it5Th8IM?=
 =?us-ascii?Q?1j8YH/1+xWjWrkYLbGxnRrW6411zbak/Nbgkis9EJDAhZL0oNHSp9lr1QA29?=
 =?us-ascii?Q?9Qvuebago8uySIalOLMqSYNDl2/9K7wtVWL1lJKnNoiMFBarAQIKzc//iB2W?=
 =?us-ascii?Q?eQk6RYq1Vs5CEYYpuS9w55Y9BPp9zgnLTgRWQ54Aja7LWgHliuo89dnsPAql?=
 =?us-ascii?Q?Ewd8F1sCoTRQ6Vjja8d8mMj4zi+lflsgxsCbWoK4PTQ71lbzfBkHBfi0zpxd?=
 =?us-ascii?Q?r2XksZM2LZrT1namCR54LpXnBHK/V/MjFtAuLZ76FH7hUxbj3HqrJvBfplgR?=
 =?us-ascii?Q?Z+cr/Km1Waiejv53StFWO746Zr1nmPSOCHXR5xbzssMAbzUrUS3fTm/dEGut?=
 =?us-ascii?Q?DzDoXQVkd5jWFjvThFF+Tpi8ugSBOM8k0gqXLiGpORe0aOZh82wpRP3THntA?=
 =?us-ascii?Q?1H4AtBG3VWqx/4dePQ61El+pNymuXfG8zZpSmm+56mH/wbZqCvnqWHneJOcy?=
 =?us-ascii?Q?ZUHnfWzXmLV54PXBYy+o0vDMzbUN8TXR2P4ArV4q2Ts9iOYQ4+FYM3XjFpgg?=
 =?us-ascii?Q?sOpfTgLNTUKo+QSYsvJ0YBmEqUb+CYcWplKCp2zhV+Yup9L6E0h9LzaCOKcP?=
 =?us-ascii?Q?ydIhtdqg9etq8gOoFdgwN8WDeBrz7qVOxUxTnWnOn3cyzPlR9vkhQd2lGV1p?=
 =?us-ascii?Q?HMF7PStZsxukSoCfHWvUARCA9pXPTrNeQJRhuOTGWBNsV8Bva8dqMiKwXVIm?=
 =?us-ascii?Q?EoH4y5r0VdAYTzt32vS3fLv7FLaoAlE6b6Fp0IebAh40pZzB9ere/SB0Q9Zh?=
 =?us-ascii?Q?Sl63wjcwquISAIN0Labi6GnCeFTL47mOBC3Rk1aP7bFN4rRPc5n3cHiecb7U?=
 =?us-ascii?Q?DA+E0vctBs3JbU2jfH1jAdLRFhTaMfKvCWyLFyYm4xJgZP01DHNWFTlyxYaP?=
 =?us-ascii?Q?bY/ZwPqNxhgvSswfR5frMN7c+BSl0PHtknUrEnowcUfbSha0D2shyrOMPhhn?=
 =?us-ascii?Q?E04tstqageBeQ4YlhIvL/y9u6Z0rNOR1x0vEvsoGWhDrKebZ6/pDwTe5zZqx?=
 =?us-ascii?Q?IuVrxNY8QxwWGM6ClnK3o5QhRRrYvl8ppcXqaTe+yjaL35g6fwsuYnNnGHI6?=
 =?us-ascii?Q?lp9VgJG6fbUI2EiXjti+Ilm9YsPe5lzIWSUW8th31bRmcV61y54kIvxnKpjD?=
 =?us-ascii?Q?fF1kyuPP8Kg3gZnu0r+TY+L/bON1fZbvpXJuYKNoAhc+8kh0BGDNA0MWfM+q?=
 =?us-ascii?Q?YOFiLMbmlQpvw4xKxDqvl//bTBsBbyCqGpf6qTLCh30TbeWnRYBCFi0O3Lvk?=
 =?us-ascii?Q?sdh+hRsjD3QHIxBO5BIqwJq9N+880f56be3yW9IpHYmVAmXDqjsChfbE5kMi?=
 =?us-ascii?Q?S7BLGucfbe5crnPco9OA/cN9FrKOZlD1Nh36w0skrotsHvsL8zzPM0g02lkm?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3rztR2pJKA153tyEiymTp2pAQ39WccbaqVi1S1CQLqGySEDbIDCTE9zG61d96sPnD3MNyGArBi4WLJoVwZgQYiHqySil6cgRTVszveRm4W41JCiDzwd57wS4fk/ZmzHtaPGwzsENWZAVzZWHfPYOyZDowwldYLGg30FKVmnuNeWfWIhRShXa811TuVMTWUuqEprDcxJz82orjb4q+6BQ85UBVEu0szC9ecDRODVApaZp+h57WNiQ9yzOilKgNjUs8KjPWON2Zoj3q7zNARhLedufYm3bMC77H7J9DRS+gbGUryTT8RE+HNV8aF9vobOqQrE95F+UQoCPacSNhUcY99lIvhj232YRuoCxDZsl6T154WhEWVowflFqYMssd63DP/Xrr4HWeD/aw/J2dBbotl6Y5Qd6ivc5URlJLnwDz0NGMF1gIGT9elGPS6l5TXl32XE+/wCqqpMMM7N5icaUCBjwMuCZu7yFTjitYB1FS8Bh2sqyn70mhGtIwttgObid554iXuCKCBkhIcbg3DeGUwFL9o16eyv8pNiNLh/93OqR16s4JU6akCt6Nc9JjhBBt+12iI27B/yx4mfBei4m+k8Vit9/G+z+ypTQVEKtgXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b18a88a-df40-4fcc-234d-08ddcd8fecd4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 04:33:39.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRqA8kORhbdoe/fKUvg7s76sVvPBLCsITcmYmDw89zoUzuDJ50bbgbRDrdIKM0LQAjbtaGrsKsO1FfyWzk/+mQRTVuOfRV4ItEbx+OPNGDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280032
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=6886fda8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=QGZEjZo6HYsJTHoNFGgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: N8EiCyOxiV-0eQTkvk16AbPNr7jKm49z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAzMiBTYWx0ZWRfXyawAIUe30elS
 NPaWb7TEnc66mDpQV7nzlFe9EC9qXhT4QPR7u+/bvnRLC2x/V6Ylpz38nWA0PePa3+PGishxIJf
 TBH3L/I0A0WbswVhu0Zmf5q0xGdOwYBMWLQvd59KEObE3iV8Zkm5pasJN1LYix+peq1x0Y/jcay
 aeHnJiRmo122lv6WUJhNbzG+hISVi6Ju1AzRdsOrvGIuwudirQfMzmsWPw1yYQsq/oTZ57jSyB0
 3VXmqE+n6dQtN/YzEeTUaaGXLXcr+DK+Z3dS+AsI2b9uIw1/bYcbRNZsepbAmGXjjzH36604z7F
 bq6I1PsqR6g99IZv9RyzGuaWDAkVUw74fIbMYMXmABIarrj3pki/A/Qpi6bg0JJhRkOGzTNKFc6
 ryrlaw5feTw1X7ivjWLkaXI/CdvEIufXKKADJkihCSzMV38BSaCIv4NGkwKHa2AFPnnzDpnB
X-Proofpoint-ORIG-GUID: N8EiCyOxiV-0eQTkvk16AbPNr7jKm49z

On Mon, Jul 28, 2025 at 01:05:54PM +0900, Harry Yoo wrote:
> On Fri, Jul 25, 2025 at 02:16:24PM +0200, Jann Horn wrote:
> > If an anon folio is mapped into userspace, its anon_vma must be alive,
> > otherwise rmap walks can hit UAF.
> >
> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
> > walks that seems to indicate that there can be pages with elevated mapcount
> > whose anon_vma has already been freed, but I think we never figured out
> > what the cause is; and syzkaller only hit these UAFs when memory pressure
> > randomly caused reclaim to rmap-walk the affected pages, so it of course
> > didn't manage to create a reproducer.
> >
> > Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous folios to
> > hopefully catch such issues more reliably.
> >
> > [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
> > [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > Changes in v2:
> > - applied akpm's fixup (use FOLIO_MAPPING_ANON, ...)
> > - remove CONFIG_DEBUG_VM check and use folio_test_* helpers (David)
> > - more verbose comment (Lorenzo)
> > - replaced "page" mentions with "folio" in commit message
> > - Link to v1: https://lore.kernel.org/r/20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com
> > ---
>
> Oops, I'm late to the party.

Isn't this the fashionable time to turn up? :P

>
> A question; does it make sense to disable reuse of anon_vmas during
> anon_vma_clone() to increase chances of detecting this? (of course,
> for debugging-purpose only)

This won't impact this issue that much AFAICT, as we only reuse an anon_vma
if it has a refcount == 1 and for that to be the case it has to be have
children >= 1.

We'd then have to rely on this bug triggering by this firing when the child
no longer references it but then it is dereffed, but we're seeing the bug
now so presumably it's not required.

On the other hand, it would obviously cause more anon_vma's to get to
refcount 0, so maybe it'd increase the prevelance of it.

However, we might actually be seeing the bug _because_ of anon_vma reuse :)
at which point obviously it would not help increase prevelance... so we
should keep behaviour as close to 'reality' as possible IMO.

Finally, I'm not in favour of introducing some special debug mode for this
or changing this code to be arbitrarily disabled in existing debug modes -
let's keep this change simple.

Cheers, Lorenzo

