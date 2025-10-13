Return-Path: <linux-kernel+bounces-850331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAFEBD288B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F12A3B768F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6622FF150;
	Mon, 13 Oct 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pXKXH7CM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ow7zRYmT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441D2FBDEB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350871; cv=fail; b=t4H1F0xww+eElH0E78QfN2l1JDNZSikBw0D+hdLYvgHC0KJbC5TUwidN5Z7gXwsFVs14r0vldpb5sG5znubUAswmVaTUUHSrF9K9qmomN/paA96qx8v1skE8jXnR/Ir90ZKtqgYb+4j3CUH4OxKTT4g3xSrYdle32fB0h74IcJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350871; c=relaxed/simple;
	bh=EANJkaK6AwIZdP+EZWKvOHcNp/Vx8ZT/+6Vz56k+Bpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4scwR2SBZzeQdtDcPVeVmFe6DOD074VRAtZAGNSeAGwitRD+/GzZ/BEdsmi8KmFJV3t6gcR1vrhvYtyoyCFXFNhhf6vhxZN1Fwe2RT6mZrb9SNfVaLbf7plFxDhfhGMT8JSGdYC4AESSxlNNVcrDa3eZ7J/9NOVuguw+6ibUdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pXKXH7CM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ow7zRYmT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D7u819030832;
	Mon, 13 Oct 2025 10:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LF796cRzqM6gPdlmk1
	zuDVFF0c1ZQ/jTnj5C7BqHHFU=; b=pXKXH7CMhhyGo6luuWUnMvS48mfF1UjEYE
	OUu2T6sVuYjOppHwMKQcCzdOQcLZDU/azLszuhNXwsyo17zbfF2ng1VIBUgyHXhL
	cXhuU6/UEFbpzlTfVBkt4bjtrB5ZThdU1H21GSaCpi/jR5XYJW11jKmUd8juheC+
	0BJbtN/nxIIlnl0+LKjy2R5xFbw6nDDcjlvhkSN9tglyuyKoG1/MMypiM1Y4bvq2
	58OOTsnMIxvaawD0u6DP9Mcqu/QpGKTRYNkdItEBxyWiwi4KXvpzzMeGlX2dFWyO
	55F+8JyhqzVyih3YK7T4pH+cmX1p7LCvuA6Rse5vI2lHxai0FAww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47hxsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 10:20:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59D8nO96009896;
	Mon, 13 Oct 2025 10:20:35 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpdbsbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 10:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlBVyuYnchMZXBoiqqCge4lfrmF3nZP9a6iOm8fJGkgyXGTrkA/v2YYODF5eQ31ZS5RleimD1GLMpio05v4zFymVlWeKLRWPlfBagM6dXAXwTHajmLMJnyaYlzd019KyM+gIuMP4qC5GqhJTL2BC2J+24K7LjsQvOWoBRoscvaP3tPxjtZvLrqNRySamIhl0ApN56jkjuhY84LufaJuY0bHn1f4YKR3RpZT9+564C1aS+Qgzq4ZkTtfUvaRX3/piDBWbvqHZ739q4ZVdmVIB6rOvW9rdQDSRX9rXrnLpjL4afkS4Ul6zcnO71xe+/vgTBe4WcZB6A9hoPtK9JVKreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF796cRzqM6gPdlmk1zuDVFF0c1ZQ/jTnj5C7BqHHFU=;
 b=Jx9iRr27QF29zuZKQWn+0fkNDHEffxXhp4rgeVsn98CGk3AKPXIpheABxqy611SXfw65LUnHV+nzZv5mNPRZTzJjDj+cHrAQZHLzreenSem9HWa6LNoeQLpC/+vm3GVkjq385w/FAJkFuLz11SbzjQLdqQVyzDeegTORKskhnOWAdSbdgiPfzJ9r5koVx7HIoLJKhckxvB9/dz36do0SeaecpFE62C+IkAGfJGRjxu4FSYOD50+PFatmmdiAGoib/z4CYrPRBGkVPrN9lHtaZKarxTjqwkZkZ8KT7cD64Qad4/8CdJDYl6lNV5cPFkMZMI+Xo18jzZfpq3btR4TGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF796cRzqM6gPdlmk1zuDVFF0c1ZQ/jTnj5C7BqHHFU=;
 b=Ow7zRYmToDsYNSBzZ7TyoEHmwWnG1OBfkjYHzPVaQvAr0TTmc5ysfPRt9B02AdlwnntPS/hD5n8uiTcBTA9NNm7OZnH6a8xBALUy0/F6pGJD3WUkRjrwKMMiJqOdBOR6uoMVEFHtJ/H+MNKoAoQOZp3Rhd4f2tptKq2kyccSPrY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6142.namprd10.prod.outlook.com (2603:10b6:930:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 10:20:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 10:20:32 +0000
Date: Mon, 13 Oct 2025 11:20:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, elver@google.com, Liam.Howlett@oracle.com,
        david@redhat.com, harry.yoo@oracle.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: silence data-race in update_hiwater_rss
Message-ID: <aaf68971-2a06-4be7-aeb0-1f100d628cea@lucifer.local>
References: <20250926092426.43312-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926092426.43312-1-lance.yang@linux.dev>
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e57a5dc-820d-41d6-f7e1-08de0a422419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkNEWTmxy//ioJ39w68hqEH0I1TsYM0bX6hrJLkafoQFDTsmDoRlGOrG/kj8?=
 =?us-ascii?Q?WJT6JYUtNpdGJjnh8qJHYciarvPjQ1YnyyfW1MWmp5UljpE3NA9s1wmXM+gI?=
 =?us-ascii?Q?NVvaQEu0snFXHxS0G7/yS7JO1EK+7AI4+yADHUOFI6ZhwxCJ4ycGflTs34nF?=
 =?us-ascii?Q?RHkcvKX5tQf+TnzeBuqhEPlutbsOqqI2mm8UGA1AjM3vb+JmSxh6PT7Zr9Wf?=
 =?us-ascii?Q?Tuy/LYbvDtXSk5nrAdrv7tvlbMYhbLnhrsdweyCm2kBtF1FcyqzRQlhWIIhy?=
 =?us-ascii?Q?DaGRhxsLZ1yipxplxmNFhB9zHe4avnXJT5QSYRHrofu6dHLmq0Kw4mUHKCA0?=
 =?us-ascii?Q?Xi7WsXsF5HTba2ZMZj3debpn0XQqITvtDLPGSjhRbISM79guIeUNfuRrv+Ml?=
 =?us-ascii?Q?kgOy8uyn7KYnkY15qTGnQJvsmwA9iDK++en+MR4GaL566HsEtvky/AcpBO9M?=
 =?us-ascii?Q?TySaWQ48R0Pqbrrrr3ksHk4yes05uk6EHX741ltjtJWXBHui3JCywwoBH8yf?=
 =?us-ascii?Q?M5zVzWyQFl3O9K8Ua8txJbAh2sq3c9MaXOAVEPvWEK2UM/s6JvqFFE0SPtrV?=
 =?us-ascii?Q?U79X5iAdAXln4nthy2JXxhtiBfA+2heUhciUB3psJT8elpiC6NtDFhFUmwwg?=
 =?us-ascii?Q?yRNfFiVCTcPcl6FeyH+FwKGgeLNsx4GH9oM33YaB6Fb6etqAy8hzdcvpvR/O?=
 =?us-ascii?Q?ePMo/1sXyctfXxdK3LBtWn00wwOw4nsSWV//Lyxz1bpbEldmVJLaDyAWRZfR?=
 =?us-ascii?Q?M1M/1Lweep/kSoK5P2ugcOhV+ow5k++pLmsEgc8ZQs+ROoavqS8iQXXy7TyO?=
 =?us-ascii?Q?xpKSd8PwF3IVSfYiym6L5yxLHUjhthRsv80a21woakzchnmhAJTNZpB06+7l?=
 =?us-ascii?Q?AbBwOVJSQo/8Ww5sH5WKqtonMYHNiu/dycxJ2qrjg7avKMzhsU7ZTn2JDavS?=
 =?us-ascii?Q?9LXGxBoFOqdn17ejC8fji4pQecm42/7dVtNAydTtRFVd1fu2v77zMty3/yiK?=
 =?us-ascii?Q?b1rg9PB4HJ8IcjGM3zNNCoLDJKGpJxh4i2fb+VlyQvKEHRsOBMLeVjRNQdFw?=
 =?us-ascii?Q?C555J6Tkfa/KmZ8WK4B3bpr6TAaV9o2d/Y2XgxTtLirjQ6ffBVaQhKildNQE?=
 =?us-ascii?Q?V/LRUbC/eNtmsoHaww8bAIgHKSCrmn7aAjf0DN9UW3QPIrMIuo4rQxmgzani?=
 =?us-ascii?Q?0tOcpObI8YkRaqZ75rQWserUlwajl+zeVq15XwHJKPOuNxEtRcl/tcaj47e4?=
 =?us-ascii?Q?1JldhogZ9zvDkIuJpOJDqaxxZQUu0J3FzOSeBaxG42tfsrsty6rfdys037Qg?=
 =?us-ascii?Q?Y9i5JxMasozdmeeIMQUYEp0FNFgx58+xySikqZHXCTUk+lt9ggia38a3A6IJ?=
 =?us-ascii?Q?iGagHMkQs0V9k/b2panHSGg7SuBhsWGky7X0pKzMA0EgVXqHThr3IxUob4R9?=
 =?us-ascii?Q?nCy2M1hMxPSQrstARUODODKSk0FV4wA5Dih/HSawO8nSiUQkzvHafw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TRAth6FsPhWJYjSDpIaxZlSvH28hMEvBnN+deuAPEr5xH5z0uLwgo54/jZPg?=
 =?us-ascii?Q?F57AzlXSPd59NXLPzVuUEX45EDzwr/3Bv995naw706Wt/AoWuDHzEQT0jkH3?=
 =?us-ascii?Q?Ofe63A9aaXKjFRHjqx2kRQ/m11rwxcMqjwBaMopvPM+Uv29xrVdfQS5kpIxk?=
 =?us-ascii?Q?JZuusMU7rbSS3X6DO4SaFFMKPwViFzeIApZtzKwUcidjldVyfatxtO9m+52E?=
 =?us-ascii?Q?HnWIfdY++51jygDP3WmPcZ2LbNPDk/D74nX3FrZ50T5mwegoTFue2USdeikO?=
 =?us-ascii?Q?BgXbJMQHYNzP8yStowDGZRwX3YU+jpMJwx3kyZ13waLKDeFvbNz6VsedAhX+?=
 =?us-ascii?Q?b/r8UYyoUnc91z/Dcqm3qVgeYX/2zULnXXU7z8TUkrUHxDGcgvlY8z+mNOU6?=
 =?us-ascii?Q?pwVceJm4r6gOcxnnu0stkvyYxtLrgueKP63/+3rfcj1fNg5A5mWDDs+E1qO0?=
 =?us-ascii?Q?icHapgA5skKZITYIkEJK2XSzp/dEETiUcXgu05Wo5D+bo+FTtrKsxmVlYEzq?=
 =?us-ascii?Q?NDSUM+jO4Nw5Is8DyfP1SuP6oOBVwRuIY+FTguZoKyOioG+hdxGOkPJhQhGi?=
 =?us-ascii?Q?bcKbY2CeF1aJTGJKN7xH3TvhghfIYbeyOA0nGUnJ3E1oIU8XTnWoERsIQstN?=
 =?us-ascii?Q?QOjUINe/0IHM5R3kLLZ28LkfblnPTQ/1dMbGyoMgYjbvPmn9u6YERgO33k6e?=
 =?us-ascii?Q?s+7CrxZ3Ewo6alzJaT+R5CbXsndgVOTyoX13IOKhbdk88MTAtvfD34ipC/q5?=
 =?us-ascii?Q?T71O5KK+tb9qm6ANLsKio9kTap+pFEMdiQVJqe2HS9CARSRp6jKzUw27qoDS?=
 =?us-ascii?Q?r7MlFWu539U6SgziuRqQi4RlVy1VUmVigohXYkW166ngv1v2JSzsO27OFV74?=
 =?us-ascii?Q?P7y4dYHyNk4I/E52LiAv5h2mPEiRKaEy0kVtG5bgi6aX+PpZgRAFbqHXlKB7?=
 =?us-ascii?Q?tQDY9gKQP7put2QGb3YgigFh7xblv29cHBvB2zf/9ZUwaCbMR1XJ7C3S5wKT?=
 =?us-ascii?Q?uYoX8TbGVxzl/swMInl4CgkhWLsRfNBn1bRecAfuGTasmar4PIY8Unxwkv2P?=
 =?us-ascii?Q?A/u/67YHA4EIyseYKRH/k2ihBXOC+c5AfsEs1ZHQ1mqLhibm96COkBqnGV62?=
 =?us-ascii?Q?j2UNMWR+1CZ5Rd2rE6Gf0uZxPBNRHonXHr8tl+nRb35Gcy0ikGmXh9j8TjyD?=
 =?us-ascii?Q?+tkLXE2WuZ6JVAL0s0db3gPoxPQXLJnU0i+EUggQeMotgp6Aj/3+1efupqai?=
 =?us-ascii?Q?8UKk48nidLdVdHb3K2qdchg5EwACCFGM2X65Oap+6pREx/1LXl8pjNTfZhrc?=
 =?us-ascii?Q?l4gyWJnjYiwKrDBPJA8n5LgGZVYm1O1U9clTe1272Jhg38LBuQ8LI+aro/ql?=
 =?us-ascii?Q?yPWS5eig0Q7iZgLTZvPxfpthl5pwYDVDvyZgt/ch4cyZTerA1z2cIF8DNPsn?=
 =?us-ascii?Q?Ll/WQo8SuSKWwxpjQ9fqClFJyUMztLf1alcin/NAeDdKGgzYn8GV0PeTdzVY?=
 =?us-ascii?Q?+6P4WQ5OyPJ22kEV3wn/7w5NKUMrqyQr79+Icz2Jqo6KXATRNm/Z/L2ocA4f?=
 =?us-ascii?Q?6hbVmN+0BvV+xFZA2Z8k/J2jBYFcmneZcaQ3J/p8dSm7oqcUgQ4SMoIkay3l?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9zfJXRQJtwgV1qGOpZ8dPplR2mefdGNIoua7uaIDGQlSHFOt5BjeqR+Wkt8QoFW5V3G9VV/OEv1/LdzU8lXmtaoLGME54HeFUmqxmeIK8yQXnewIiia6sbxkvccBUa4KlZy4Txi3NZjt9lATNvboIwDy6FeWZ6hXDYDFv3NyJvY95QCr97I50VoufapIf3hq+ogNaQchdBOfJwqRWgbjrYEBLdyR/POTe4uZwfQAR3NO7xSwXhBAyvVlsZ2TqPTOOpFOGEVThW4MRf2FWIaLoLHEZ2+3puDZnJQx7baqEEzt34iEJPfEXvG3H/oKpTdP8kwFvzn4u354C+Q5yvsYtHbuOQUW1ZTeYw3+f0cvfup343avXxo4EAj+Dm3VT1HsUPWjFSQu9Y4DoZqMOcfq/7Lra1y84GEqOjAKZc1P3GQnNAmbK+ZiUmulwbdOF0jLFFP5yVSFUzL2PxqLgnhOPP124zg3BEWyyeauXBy+IQNnQi7P52w3KzYCpqTsdDeXfP3dYlO4QHERf0oX+/NctPXb8pIAxdF8nD4ZhsaBxZ9KZbv955YMdX3CEA79TYrc9ifXRMd1yva7iwI9CYbzptmiGo6RSzoQMoB4iPg9jMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e57a5dc-820d-41d6-f7e1-08de0a422419
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 10:20:32.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdxyXQBbAEMQMYWHhcmIKzfZvxvvfIDZ3J2BPvHEjWZ4eUO2WEF1Zhgz0DKxInJs0Heq1pR+llSbidl0HKbGwia4crO/lVv/bYuoe1JMc1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130048
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ecd274 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=7Mec65fYDvbdfntlDE8A:9 a=CjuIK1q_8ugA:10
 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:12092
X-Proofpoint-GUID: pvKyDKp6SPWo1-TWWsR9MAVM6EjsvXiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX+jzCWlBlrwUM
 gKikWNpZiUtbM8LWIzndLu+0ZKcG2XgET2MEQbNCzceBDKou4iUJEj+MCUCI3ehpFX9aO2z4mgD
 +7b3LTkYk9nikUfYRDoY0zL1hLLv13NYBg4SZ0oDgu835qVXwvcaZ4eP2FlPHPvNtK3f39TEGYs
 55S14hgOAMkDE5gVyyrA5lBiqQB8Fo01OGYOcJnGQv8htuHWbHvol2C35GB9r0yPpSS/Zzap2Jw
 suiUJsAG681uonWUwXhGrg4SEdMjEhcNg+kYO1nlgjcHnfM0vS0OHv+58Dh4VAbOLHRZdsUNIC0
 sjj1fTGEU1yULO8rAr49h7tsHi8jdp1xGAE/l8G36hqA9Tnf1TVXrHkzMVg/q58qVM7UrLnavti
 g37Qw3epvwHHKGt25gGCGiNHLtr/b84uDCnzAgoCRmeBLsQNB18=
X-Proofpoint-ORIG-GUID: pvKyDKp6SPWo1-TWWsR9MAVM6EjsvXiG

On Fri, Sep 26, 2025 at 05:24:26PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> KCSAN reports a data race on mm_cluster.hiwater_rss, which can be accessed
> concurrently from various paths like page migration and memory unmapping
> without synchronization.
>
> Since hiwater_rss is a statistical field for accounting purposes, this data
> race is benign. Annotate both the read and write accesses with data_race()
> to make KCSAN happy.
>
> Reported-by: syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/68d6364e.050a0220.3390a8.000d.GAE@google.com
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6b6c6980f46c..dd93335e3a13 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2757,7 +2757,7 @@ static inline void update_hiwater_rss(struct mm_struct *mm)
>  	unsigned long _rss = get_mm_rss(mm);
>
>  	if (data_race(mm->hiwater_rss) < _rss)
> -		(mm)->hiwater_rss = _rss;
> +		data_race(mm->hiwater_rss = _rss);
>  }
>
>  static inline void update_hiwater_vm(struct mm_struct *mm)
> --
> 2.49.0
>
>

