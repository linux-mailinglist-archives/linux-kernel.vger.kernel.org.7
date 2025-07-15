Return-Path: <linux-kernel+bounces-731715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C584B0588A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF981895FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF82D8778;
	Tue, 15 Jul 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rdi3fGuF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y5Ob9s17"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34D1FC0ED
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578027; cv=fail; b=h/N/nykYC4Y39JvTn5qmDf8bluKbQmUYPaX4dZTurOO7R/ujyPDP3PV0wPhy1ncQGU7n81DcvlJrMYrQswhwIw+3BqqoqktUP6NS8Sot2wJSIt7E7ojtDrnS7ynn50hmueVIWeSkjq5G0+6t1jn/Ymudke4nNEHCC59v9cX4zEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578027; c=relaxed/simple;
	bh=Z4oQfJMIbC11hP3T6UZ8vTFLipEraCSVqd7OuLqRXpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nip7hWJHAKaDQtJoMe7DgVyd3h56x0T40LTHU9nc4ASPtsR2w9g/zTOoY/VwKIiwd5fiyw5eV5jPuAM/OwusTDAtgPGYa/rYz4RapeanyLEZ/z1LwpDLjY/YGxumRCJagbKsjkAo657yS7I59+AiB8ViwLlkUc2MEzj4TMO82WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rdi3fGuF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y5Ob9s17; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9YphN020478;
	Tue, 15 Jul 2025 11:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=T4C/lDuV+wRtK/+VRU
	G/xXTP2gTvDA40IHK3PMZNDS4=; b=Rdi3fGuFLmU8ZNLG9AF10mNG1FrPR8Mvs/
	13UbSWyHB7+ZNIdd+w/pvwl7DlzR/Hw3quwirKP3RFRvBUFBHYbs6WADLD0ASDgy
	Eb0detPFhpHT7zKScNOF2s/50Xd0Y7SqFXpe5bHrIJc+o7w+tZeJUshlubiMJPak
	FdjqN5ffG6XFu3Rl7K62hAoFnuSpg0QfZcu/MyCRaN0agbAvbWsog7QqQ6LpGOSr
	krWGiIVqmlsyfQgdTjTiow3ikyw1atp8/IVtftVNBzsoDpgu6CLkKeAKtO/xoDfd
	hsMH3Ng8BNyqeebTHPPWM4bbTVx/PQs3XC8C8bIwInChZrcdYJHQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1axdrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 11:13:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FA8GjV012988;
	Tue, 15 Jul 2025 11:13:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59b2yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 11:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdeJCOnoUc4M/PBjTiOCjrrm6N6pobSJULFVWUd9DQAXPrJAnhDtcM6AyyG8bKeQVL9kjPVEPk3W/5VPjk3JJyxw/Xo+Rerr2bU6SUK65TxULWHlEgQNffeRvwFAxB+1ThnkV/LW8AaawHeShrW5uH7pQfevhU6i5T7h96TUzC43VZxZH3X9HI5djjwsMllVdYvDMBSEPuw20Xi62hg8K4HzhOsCqoTZHSAWXvF8x1TlJSo73xWMI7vAamTSq54qC6gqigFWS8h9RN/f6KPshJ0bTShCvgRuFIKHtwQHQMNncS3KKzf8hyNHK5HUf56cFGvUs6ZAlkK7GdhHGhGh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4C/lDuV+wRtK/+VRUG/xXTP2gTvDA40IHK3PMZNDS4=;
 b=VmPYH+Khsavl4l7EZ9/z26ce5M9oxjlDozfzFR16qvvCVsBvojmktmcVgacQzZp0t+iu+v3Dkcbn53GLLUjvgOb/quT5YmBMxwffiXkXiUGiCyny2t8tpuCwCIfzr74F7hx2le/b3hz/cO9XphKE/SUw7Nm3lcbHYbiwtB3dg7MRGL9JtsW6qZAIlLp48yGg2SSjfSBWNX+m5DKErjOE2dMuzLKh1oji4WcjYy1kYPJlqabKLJvlNGo2E9wcVqzlto9d4tW/8HOFEsm4zBVQCUw7LpiWkSXvi+cUQr5RHSITwLFARS0LacKF7ujHZbXFlvyOz4kJu2hm8Gc66BxQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4C/lDuV+wRtK/+VRUG/xXTP2gTvDA40IHK3PMZNDS4=;
 b=Y5Ob9s17lmRvc3PhoGT1bY1t+6ajD7E1QSbdf9K1REybVnMhZJmS4M2QQOevCGSaVpQcNLTG5YDIO7398ujgfSzb85ejysqXjQQo3IM00I47VkOjgWHrzQHPEgXqX5RHBAfF1h8ftHni/jg2zOCvHuDK10wwZ/73LoG8T8t3wzo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8399.namprd10.prod.outlook.com (2603:10b6:208:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 11:13:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 11:13:08 +0000
Date: Tue, 15 Jul 2025 12:13:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] khugepaged: Optimize collapse_pte_mapped_thp()
 for large folios by PTE batching
Message-ID: <20ff4546-db78-49e2-8121-48d1bda429d5@lucifer.local>
References: <20250625055806.82645-1-dev.jain@arm.com>
 <20250625055806.82645-3-dev.jain@arm.com>
 <71350398-b5d8-45b9-b05c-d2b63030f766@lucifer.local>
 <8109236a-9288-4935-8321-dbff361dc529@arm.com>
 <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
 <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
 <b82b860c-8ad9-409a-8668-e3db11b9f7a5@lucifer.local>
 <adf4fba6-f246-4bf5-ba90-ac1357024dac@redhat.com>
 <7ce82695-f2f6-4a9b-a512-422e9efa902c@lucifer.local>
 <2d0c061c-df01-42dc-ba04-69d47d7516ce@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0c061c-df01-42dc-ba04-69d47d7516ce@arm.com>
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: 005ff75d-3ee6-4a3b-7907-08ddc3909455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oAK5F26b8Aawo+vPvaQQRPvbLk0kj94GkQ7ISbJ851bXsqKWMTsV6dJDmQ4W?=
 =?us-ascii?Q?yFRp+W8ow+nbm79SzKvBg+KULN0eHQOO4Z3TL+wGcGuH4hnLD8g3g0W17JQ1?=
 =?us-ascii?Q?ltj7Ljh0lZtPKMEvihEeIKLTSw54Q28DyJvIpz2jagzpci36piOdBAN0dvB8?=
 =?us-ascii?Q?otL/I7btMgtszBStCtXYWXnA9SaWxZLwNQadT2uPbrkZXun9zAcq7el6EgX8?=
 =?us-ascii?Q?NRfJawQRsu9ZE9+J4uGvsv7mebt0ZAzHFNtOvsHMuJhCuSotoj8oTQe9wUSk?=
 =?us-ascii?Q?rJCqbr+bnfVQ0mYQXb3QOb/lohxzEgc8W+nF3HSvhE4ZURi3+RPFOv7Z6rAX?=
 =?us-ascii?Q?sJhZdGgaVYjqgjqRevfpLhmjertWxJUbNC2JuUWnqa9nkNwPl5EfvLZKWPPi?=
 =?us-ascii?Q?cdlOtZCYWsHuLaK0E1NpWUykWdTc+0yE4te/YHvBxdEilJ+xBJX5IXsiwmgn?=
 =?us-ascii?Q?5f9CRwTbC8nSDDpIHm2+0lzveYsHBjr/QjccqUQmXM6EpmLgWv+s2cDSF8/U?=
 =?us-ascii?Q?VJB7MghBNW8DjJYY+4af8rxLv2MLSA4sAgNSKVzUatAQ2j964q1xdK48NU+p?=
 =?us-ascii?Q?f6UpAHyNeyOD/qKhTJBw97tD1hCClZe3FVR158TYj8BZ8ApZr3wuk51SKufg?=
 =?us-ascii?Q?F9Q3gnkK9pPIOw2GEDzenUVqdmiLfvcXICLvfZGtHQl0Yks9mrYLYYwg3cGl?=
 =?us-ascii?Q?bzfjA/wzNA5GdtkK8IiBiDQYPwlLw8GFZufdCTGNL3ROnKl2AI9JMnkLuupJ?=
 =?us-ascii?Q?+PU59NAiqNyEFJdQ1bjwxZ2EUBkI/621XGEHHAd9d9LaS9Ze1UAN/wWVW7zM?=
 =?us-ascii?Q?cjPGBS4+JBFNGAk0jS166cJhUCIhDMZau+jfskFXxElzxB11GpofcLNR1FZy?=
 =?us-ascii?Q?9YntTgX3UDGRZDmLQCNmLYd7pk5VKG/wW42luWib2poMQgsK2fSptCkqv+F1?=
 =?us-ascii?Q?5g+qv/RVGMJEZlGxKRt8mGrfJe+VY7QHhgyWbZQ2rkETZaCgZyiNtkUQMMhm?=
 =?us-ascii?Q?uSnkJUimXo3tqn5a3ZGMh6h9ZaSO5z8loHh1zQsWmcLMtWODBr6SaCUGfv1C?=
 =?us-ascii?Q?VECxeSNaAJYwlqPTIpstIE7AUhRoqtTqnHcDQZpEdFRY3ZJHGuXzOorsRERQ?=
 =?us-ascii?Q?VJAoCnDA5B3NEykNVxylQQg92ZJA4DecNWatfLixgmhtUzfwnIW6Cb9SBFEr?=
 =?us-ascii?Q?4gFgFYG3cLFqXExflvTA2/Ja2TSC0noHqB7vDIByaN5nTI+xheAO7DAWZ+Tw?=
 =?us-ascii?Q?vS8gwj8cjVXUQQpFKxfOT0Ti90bMDzDgoAjoXLMkSh6svjX+KadHd76dxCRs?=
 =?us-ascii?Q?2JEjQ5hGV9OfgvJBzMaDzUR2ZTrHMaiIHpwv6ZRMbn75CfeXHjiPlZIvQMZZ?=
 =?us-ascii?Q?juzCRAkWjg9tQr341Ne8JDSbWmdP09CiuJSSM577kL+AVvQJHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7/01xZmEG5WEUgZdE1ByQj6+E3r5Qd5Vg3eY/+vhvm1m8mkizWjB0mGbp5P?=
 =?us-ascii?Q?nAor42jjyxa7L8IwgJ/OHpyr/pCYPoMaJK9cVy8WIu2TSGqax2k5423Rn9ow?=
 =?us-ascii?Q?lbgWXEoiMQtfqLOu/W3z9s1Q4Go4yJXJICKJv7oksOAEnlmrywAd4XR8v2f3?=
 =?us-ascii?Q?h0Jg4WajkZ/Dj7JfsNnIoYmflp9qBoW7RjwHKlkn8EVE0BGcWwkzNIBHjWzM?=
 =?us-ascii?Q?4D4qvJ5dXBs24w18wR1TFzQm+9xPJ7m8I8MWUdoCuFXFE5+loYLBTd2m5U41?=
 =?us-ascii?Q?cq3UvQJiXtSVW+CEtMhj3Y6UuOtpC3dTE5nuGnSDv3cASaeZ8mHFKSV1R0i4?=
 =?us-ascii?Q?G1GxrLdTc2a9pnNKXrk9y5hd2lM2N6sorhDtyEOqoz8IyLcUSyhusohA3y3P?=
 =?us-ascii?Q?RquHeW0FIMl9BxWQh75tapIXBvGvi6sYq/O0kn1lVXHKzPOoQ7OMPVjEia22?=
 =?us-ascii?Q?rfGvAFFTof2NxHJ4eUzCWcA9UEDka+Bo0gBwQ7bRb5TQNp84yz0lYVgPan5x?=
 =?us-ascii?Q?Mbyxtoyw2ye8vmlKjMvQiuXl170hf7rijvaUlPj+iut5nK73mhcHUao/NrZ/?=
 =?us-ascii?Q?YvJeeGzrKy4OnrfiMzkHZ25vkkV0T5tmAiROBSWUT2e0U5LJT+xMYLRiv1fw?=
 =?us-ascii?Q?JxLj8OA5mqEeBb5nKT2gT5QnoHYQq/zX+dN1edXgKw6rV0n7r7kMHoh6P58C?=
 =?us-ascii?Q?1HXVguCu5RezPV16IAVsTXcy1tbmzvOcmfd1em5ZvqK5HQn3UJVM6UFWk031?=
 =?us-ascii?Q?NUlVrcjLz9aIJQORJk6OjWaDFUNSthP4mVUUTHAKLjli8LOmUSyGbEsEVpHi?=
 =?us-ascii?Q?3zsMDvIL0vprVtuP3bIn3CZKfSlECsd7rwgX4cJaIZJriLRYC5TgD3XtxAFX?=
 =?us-ascii?Q?5p5f5QbWDD8f6rrNAJNznifa3M7NkIXzId6dtgQrZwU7so1h3unaDZ49UBW0?=
 =?us-ascii?Q?AyE39P8D9f5ZCi+uDwIjwxrOZ0IMDpRxscoMySAKcZM67X9GxSsyG/IQ6eRU?=
 =?us-ascii?Q?jpiNpYAIIDJsB/brnlxKn5oeKQXstKtSegdukrrfa4KrbxPw0UdrnGosEyPQ?=
 =?us-ascii?Q?Gbv6LcWTGU5GhVtK3WioNqBmIJ/p8ZxCU9ox7ssmXIivIu4BE+/FBUrY8sNp?=
 =?us-ascii?Q?2Sm8VXoaJQDZHJYasBRDEObbzTc8CC5bKTNjJZyoDbZNjk6QPQbstB9ArWcS?=
 =?us-ascii?Q?KCVQyxd/3cYdn1uR5YXexMr3bmAmFYuoemyQGaQE1tIRZpxraaUN/YXIwsde?=
 =?us-ascii?Q?V44pr2JtgRIpQXOpHDSQA83iyDScU9x5JVf8xupmQCGn54dmndrEk4i+l5ke?=
 =?us-ascii?Q?dc+FwPqcCYPR+FT2bF7Koivdyt8U3+AHnQBDv4ZMW2QQeckiA8uQNB1V0+1H?=
 =?us-ascii?Q?016ODZQvz5Z5fdF/W/B8uW3AssNYJ9QB08JkjeX1tRiU4iQY8bpWtBPM3rKr?=
 =?us-ascii?Q?vn/lMNAxUqn2dXyDX0StczskkkieeDLMSgYg9bsH3oOmMSoi/He2DbC9f9v3?=
 =?us-ascii?Q?26xjoQSLmTPl3FvXQN7yw/IfXdPI7ONHeHBeSi/o/F5BLrmRmvbctTmOaz0G?=
 =?us-ascii?Q?ds7zGgPH9gCJeA+BmAbqufNksWIvP3dD8gpSSHa7E7AjOeQkh2wbAi/iQ3Sa?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UnyFVMZ/x+GUWgboL8GDzbKC9CCwt3S1wpELMiKXUipmgAyu6iSVYZGuP3EJHQ+V576uOL0t7iFvASwX8z4SxwyV0WFgWIaZ5vZdCU6dQ6nvV4PxgM8m9Cw3eLyWRGRhyRi2YIngdgFRLtMwfPFYP3qGd3JBCipPngJYAEYD+2buqtuIaAGoPMoTVLmbmmxg1mKK0Ns5GLEyiqh1Z2TpyrpB9iykMGUqhzZfJZIZDQSQAM9YdNecErU8gF1c5f+mo0xvAsG3TXEKoS+/mKnArgfE1Zkrq/kJO7yMlAdpkfBjFarCtFp/NWikYnhqFcbLwGBswabpsqDRXpDPlzBLBaiz5dOC+2lRu1Hx+QjaUJUvDzTXAkDE95lfq0AnLyloXFyEqCyoBN0GdKZtD+2sDX2nkxqvAS8ds7KgMPRZwFuq+p+/4iP/mxPN2/p7vPYRN+KebwGVIEvIfOjKuIyncpK9la9H3KWY9Ismm5ypCbQjLyScXSYlb75ocv48jo8Y7/9XYx0K8JAk3ZRV65iYGhKPPUteZjkXmxZFfkSWhc0BUEJ1MLKcBRNtfxZAAtnkIo/Mj6hlEB2bzlfbvJLXfMLuIJKtvnK/WfS6ixZ3eqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005ff75d-3ee6-4a3b-7907-08ddc3909455
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:13:08.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3ZyPXs8r9/k2O27bJqPBa9JCidIXdjgW1CUiJiIn+fFcyfQLG+X0/1FVQ6/93Q82mVYycraJKkbuWcK8r4qEgyxuP9kD5ebNSg4Les0oFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=982 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwMiBTYWx0ZWRfX5SC147WyusUq tOFHu9DY3iLRGJaMUAnM4gQHXy5dTbegs2aEaKeq0upgEaSr46nFkcbyvnDVzRbznzcZ8YR2VGM xP3XQ2wnOvg+F+gdm9NRNyJUxVwGR74fDsuHMALxgSkP7SDkLhXnWQxaQD/jFu+vOHLlPI/DHtS
 agdLKFy9MiF1ImbgBmqc9u1m7LA+6RCmaTjJCJjluyNJyRgnzWHGQh6j6R8OxMQRqG73hed0Tgt j0J6eYsmd95y2kLaltKhgYhK3K49OxDvudDyMMY4kuX3a68wLOX7+Nukvp7L+u5UVIo29VO7RSj m1zUQZIjHThvd+md3qqqhXc27PAsFkMnhgllCFmIVX3iJRDuebt3GA3/4jOo3e5STO1ZBXtvY4e
 7sNQkK7cuoVoLFUGYEGx2azN0LSe2gESwBK724+Kh631RwzJui+eF7Pusgwh+RSBbh3n9TuH
X-Proofpoint-GUID: FpntuaaQeApt8cjYCU_jzio4jZaZRbUz
X-Proofpoint-ORIG-GUID: FpntuaaQeApt8cjYCU_jzio4jZaZRbUz
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687637da b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QE8Y9K1hWt45VwaNHRgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061

On Tue, Jul 15, 2025 at 04:10:11PM +0530, Dev Jain wrote:
>
> On 15/07/25 3:32 pm, Lorenzo Stoakes wrote:
> > On Tue, Jul 15, 2025 at 11:56:26AM +0200, David Hildenbrand wrote:
> > > > > > > > > -	if (nr_ptes) {
> > > > > > > > > +	if (nr_mapped_ptes) {
> > > > > > > > I know it's ironic coming from me :P but I'm not sure why we need to churn this
> > > > > > > > up by renaming?
> > > > > > > Because nr_ptes is an existing variable and I need a new variable to make
> > > > > > > the jump at the end of the PTE batch.
> > > > > > I thought you eliminated nr_ptes as a variable here? Where else is it used?
> > > > > >
> > > > > > Oh how this code needs refactoring...
> > > > > If we retain nr_ptes, then the two variables will be nr_ptes and nr_mapped_ptes,
> > > > > which is confusing since the former is plain and the latter has a _mapped_ thingy
> > > > > in it, so instead now we call them nr_batch_ptes and nr_mapped_ptes.
> > > > >
> > > > Sigh, this is still awful. But probably just existing awfulness. This whole
> > > > thing needs a tent thrown over it and fumigation... but again not your fault :)
> > > >
> > > > I mean fine, this is fine then.
> > > Probably best to be pragmatic here: as long as the educated reader
> > > understands the code, all good. I hope I'll never have to explain it to my
> > > daughters.
> > :)
> >
> > To be crystal clear here - Dev - I am not asking you to refactor the existing
> > mess, and obviously I concede your point on the issue raised here.
> >
> > Did you need to respin other things here? If not I can relook and give tags.
>
>
> Yes, I will have to respin because of folio_pte_batch() changes from David and
> have to add a simplification patch to this series authored by David, I was just
> doing that and was reading the email thread to see if I didn't miss any review
> comment and then I noticed I forgot to reply to the above point.

Cool thanks :)

Will have a look on respin!

>
>
> >
> > > I know, I'm a perfectionist myself ;)
> > I mean if I wanted perfection I'd have run screaming from the kernel right at
> > the start :P
> >
> > But in general on the refactoring point - I think this code is hard to
> > understand even for the informed, the endless nesting and nesting and levels of
> > 'you just have to know what's happening' make it really easy to miss details
> > here.
> >
> > What I'm saying is - we can improve on this, and really all I'm doing is
> > todo++. Possibly even dave_todo++?? ;) Or could even be $<name here>_todo++ :P
> >
> > I find it impossible to not mention this when it seems apparent to me... force
> > of habit :)
>
> I personally suck at refactoring code - it is something I have been trying to get
> better at. Now that I understand khugepaged a code a lot better, I have been
> thinking for a long time to clean this file up, maybe someday I will gather
> the courage to do that : )

:))

>
> >
> > Cheers, Lorenzo

