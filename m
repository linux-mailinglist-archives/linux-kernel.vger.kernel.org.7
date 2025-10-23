Return-Path: <linux-kernel+bounces-866974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09184C013CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3CE19A2981
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD230E0E9;
	Thu, 23 Oct 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihLNMn0j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CbCVXP8m"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B17146585
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224229; cv=fail; b=f086Xol0L6ZpF6P3GTBra9v7CHBKprcN1FBoqQ8yinyNkbNa/9T/IXfihiZawYS5cHG2sEbCwx/daNwQ2dqVyfaGUmtsDubLfL6LSVcZvjrkehU6yCNNr8zn+lG8WNeOAfvCYP0cMQMaqi7f17WA78T8JPHnCR9Yiu3nTfHNQnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224229; c=relaxed/simple;
	bh=X2FSuwBCttI9BqJ7UP6XhZ2vPj3wGm+OxjI8ZLvnqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4S47a2CM9xjf9cYHnqjRShJ16W3YsXEEaD2Ht/CgLAdqf5PtZRfrVSDlY6PDp/spY4gwb/zuUnOTjtf8J7pmEPDM6jF8dBScuR8IgeHDW7g+iWHtJFXAv3FLRRNwuFJuc3HnMwpsmu5AeuaHBESHV/mIUE/C5Y9c5skho69hwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihLNMn0j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CbCVXP8m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBF4lX004475;
	Thu, 23 Oct 2025 12:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TME/ckKZQmad5uT5f7
	PC7LVjKjuH+GPv0ukANy6sbag=; b=ihLNMn0jHqTyKRxZfu7KG8olnEN/xLis5K
	YjpkvVDxKQMkvvX4ilXoD6n73D9rTIlwJCloTpsvs5ei0i6Zg3a5dV3UnnRK+2n+
	Ig6ddiSBdkfLisjIJVBi/UukAVwSr0Z+W6w1zM76d5Li3vKFBS1hcTsloNuh3JSj
	T9v6Qq0Kd9CpXAmrADIuuwzkCnh81e4B/i3Tj3vFp/yJqtI/9FI0g/Klu1yBsW8M
	FeyWqnX6GqLxbQXheuPXnPsRidLAvk90uuFCFO5JvKniO9wbO89vkVJekGPC0+kY
	qo1/3R0VaPi7sROW+7mYk9FvscRTZRM3/ObwCjFbhTKO7ltKziJA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah058x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 12:56:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NBH0B3025255;
	Thu, 23 Oct 2025 12:56:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwk91dj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 12:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHQ1kUJu6igDeNGEPywwGknWFBC5DaCqV+jSDokcAgLNc7EiG8L6ZuhcFuNcJLxINTs0P7dm/B66djYJL+CBWOf3wFT0vdxdPGZ3jmmhwK5D7E5dbcb0Mjyx4pJHHp6OOYztgXvpHXVT9AE/9JAz894akUPaVUrL1ylJ720HCOpAT+pulivJf5cMzKcmfFDwtL4nVxBfO93AIz70h6lL6+uE6zVuDuwGonpZWDzSJteZbm6013eFVxpCKhrxBpNzsPgV+JvOuq16BN0j5SDkm3rosyL5fxUGN41SP7CpjhgI1nygb9v3ExDi/3I/FDpn6HBalalZ0KWNiQ3WAgg9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TME/ckKZQmad5uT5f7PC7LVjKjuH+GPv0ukANy6sbag=;
 b=JA45lWU71vhGkTMWeh8s0bJl7mLpIL/oiHEujfUG7W+Jf0l4lU5jOON7yy8wXSyPd8Spp3W+SeF1aao1kaxUDlPxTjC7M5K/1bceip9NIxW8IEZkr8HahbRMmXwP2+DLRjT73xPEz9j5VlCojZSb8+IXVVzqE8V1ziE++cob/ajuGAeF9YZxKn48lFafFXwWJopeeSKwIW3FLVm+Ztorhlt9mrbCymJxEFW6FYn9KvPcW7jF3eHMd9xFPverLCxlZpGpScnEZBYXWf4QX/V/cCtiFgAev4w6dK4PNqW/rmJ3lyHBFWB0SMjJOdPt1eSH6fUIMBeo/xrrGfLHxVOlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TME/ckKZQmad5uT5f7PC7LVjKjuH+GPv0ukANy6sbag=;
 b=CbCVXP8m8/EH8CuUdZlPx6TuQ3nUuWZatggWmgKO0UcKvYEJVF0NngyGd28K1eLBPhIhEvZIkZEqbJZT+iPDjSdky1bTkB9Ua+nRJ7Tmik0PMQTUfSsUSHEUsCBx7XwLTE5xvfNdHR9xNhDJJvhbnodzI3jA5YD8LhftwbJumr4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4979.namprd10.prod.outlook.com (2603:10b6:208:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 12:56:44 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 12:56:44 +0000
Date: Thu, 23 Oct 2025 21:56:35 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slab: fix slab accounting imbalance due to
 defer_deactivate_slab()
Message-ID: <aPomAwgmrHSqOAb5@hyeyoo>
References: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
X-ClientProxiedBy: SEWP216CA0147.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 607b89a5-9902-40c4-a891-08de12339e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oy8sbKOo11eDN2+la4m1EEb1FXpKrAq0skrm3p1HlqtbSITh5YEEBx/ssmnY?=
 =?us-ascii?Q?sRhbHIHrR8pi/AIyoOHQUUHp+6aoFSazXDZx1LWiLct7JZDRBBB0z/QwOei1?=
 =?us-ascii?Q?w/affZLNJfyf1+iBJw5iZ+8VtElvE5NC0dL3MATbp0rjnn5peLrJUgI9Q/VC?=
 =?us-ascii?Q?kLB8T6iR5l9miARFz3J6ds4En2PvkQ0Jo1n5qA/ZuugTfzniXsoSwN+MMxdB?=
 =?us-ascii?Q?6Ma+wccifNcL0GKgXEJoZYUouotuISWTMS56nqTpvtg3sJZH01Wgnbd+E7/8?=
 =?us-ascii?Q?22pZOCgtiNMDy67FerVUlGH/BgFnaMedbvcvF8a2IqgEF0FzYJdYgWKyXXnr?=
 =?us-ascii?Q?76qz+PtG6OZhn501L3X6jX59Mp45JFvk7nwq95BQ5V9pyEu/3LDeg0bz5LGF?=
 =?us-ascii?Q?CpY5OeqOWld+43nYO8myDgipDwz9MnD3z7wDr8rWpmKFRyejGYHGHddivF6V?=
 =?us-ascii?Q?WbQveVBHbiKaxM4kKbXPLBAPfDT6R5qyc4XKvpBt5Mf7bzj9ASDXJ132MbXA?=
 =?us-ascii?Q?9E0+fkMNZKmyIl16t9QwfV9frf363SaEPfgm87sihKREVDyyGwjJ1g2VB5bW?=
 =?us-ascii?Q?J+EXVMs9C30yCuV6qeHArDgA2t6N5+zX/VUW3uUr3FBHVZ/gHmOvuVZ+ajpi?=
 =?us-ascii?Q?cTdyHE31pBU0ygZYMoHLofItXh6dfA66ssjvszaHZTuj3/9jvrDilbzGZ9el?=
 =?us-ascii?Q?lryhH39IW3qNDFQq+7WpKF8XT3ZulZp12xtYx/sgWdQxZpjXVDgNzgFt+8zH?=
 =?us-ascii?Q?WtdTsM8amhcWe/RMKPuDmJMxjOBUKHIteuexM0pNDxg/Tgwem5P8rc/xNKF+?=
 =?us-ascii?Q?EGQY+5v+aJDlKlxi+c+50KQvLKSm6Tl297OTDyaMQwSk5pgMxCVsgFsdOkbD?=
 =?us-ascii?Q?UwCEki174vmQODDUfwR3QcugCynk5F5+J17SZCe0homMzxQQc6PlSq7//jpT?=
 =?us-ascii?Q?UkfebwDZHDSNVpp9yFdfzTPyiWuG/dtD5eXleVwz3Eih1ZuYSOPxwYZt4/uh?=
 =?us-ascii?Q?jcv965HzWNymLWlvD95GZK17N/GdI8Ep8nyprdUeYIAHKBL/oaDx0ZvMW2xv?=
 =?us-ascii?Q?jUCShUh5LSDhLaSv2lmR6AwGEFChqbMYrChPdVkDj9ajr+HDpEIpttKRmR2t?=
 =?us-ascii?Q?g6zgvb3mWy8SR2qOh6rBQ2AOTHDc8/L1uUS/qjWZVPO4HzwbeleG2XJPqgMR?=
 =?us-ascii?Q?x0TnqAiR53VBH/JdVYGFQX3wDFst5ivM8TT6Zg68GLFf4CpQBydmnADnu/wf?=
 =?us-ascii?Q?RjBGjUyVk50+pbmMJUoszHkTH2RCVJcXza49lcGLeJOez9D1Yu1qTae2x6zS?=
 =?us-ascii?Q?phRNhxgqo1CooI9neOAIYEJkva3tvn58k3RYBBEi05S4ebPrkLJ25M5IqqXR?=
 =?us-ascii?Q?0WzK72Dy2QFWA2Mz240bvRFO2wVH4y8ad/qhh0OnffMPkTWdCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9Ov/X7OmgVD6A/9rgs/9pohViUSTPmpyu6pMhT20ws7wnfTLBuJcujGjKLf?=
 =?us-ascii?Q?1BIRbJ34HxyJvTV3rtytk0Fg2SxCLXHNMydO7V/mNJ4tpGz8l6zrEHJdt8j/?=
 =?us-ascii?Q?ho2sDq9ee9wJ14soget+xB+x+VFWH0InfJsECCog6WXuLUcbgbK9AQtWj3HM?=
 =?us-ascii?Q?CCzwKBZGMNyzq7V8JoJedTYZsbHagmsi9XwY2hPt8wY6NJN0Jm6/Mmdctwoj?=
 =?us-ascii?Q?AMv3iBB8Y+NaqT/LVhqeJUWawN8YurNJGttzfsQZhbue9GPwbSwxOxOZltJH?=
 =?us-ascii?Q?QX4b9vbPczb9g5f/4aPwDUmjIb49JQlkLnCHv+pon3Pibuqkk/cMqQkMpW4G?=
 =?us-ascii?Q?YyT6HzcQ76PUtY0kyl7jZLC4Uf/wQXCbFKe2HCnAVPAZt2F3+1lO8hdJ1vI0?=
 =?us-ascii?Q?kuw7er9dQVbt7+OR3LjAA6DdcYsXgmLB7SXQJhVC7Og2s7Pl+H8JckP3Cg6B?=
 =?us-ascii?Q?PPyz5B6WNg0oMz12hg93qQo8hgQmaNsn2vx757ZvDQ+fkZYqlB3AHN32h+/L?=
 =?us-ascii?Q?ctnbu6IJ9j2znkQC3p8plmV2pFCmBLJayG1TtvgWIVsjHyp2A7PkrGi8gSdU?=
 =?us-ascii?Q?tiUyxOt1rxDUQBNkNN67J5mQsHvQYF7XL5CwEi7TRlPkVfSgXB94faeqEmuN?=
 =?us-ascii?Q?OiuwpFknZ+58uzXqdQFsTEKUCzkxQ30vfgGa0CpZh9MhhfTFslZsHSSCGHqe?=
 =?us-ascii?Q?jGtaPA4llj3FiEJNCUC360/WMmSNlOodrZNKtyz/q2A/b3zMY3h330Kcyl2T?=
 =?us-ascii?Q?mlZCieH3cD7eHavnCD9Ws8GMvmTekb5SrzGgbIUZ4zW8B4ndDoJDP/e8W38W?=
 =?us-ascii?Q?Nv0naidTo+s5+sezLmpCKtJwlIx5GEOjCF3j7QrK+na3akUvLFjgggTX5FyQ?=
 =?us-ascii?Q?r3nupbmxIXH5u02uo/uhn6FT3qTP/OymqTob29O1myA+STaelbOzv8CuKSI+?=
 =?us-ascii?Q?32KPqCGYq6s4DsCHvQoy0nVN3rg+mYIaopkLRY0D8ICRB7EPahCobrL1yQKi?=
 =?us-ascii?Q?VUp44PY3RqD/LGm2H3iqYKGnSW+Gdjavx0jOIe1SR5FoMBOYL3jUV85ubvz+?=
 =?us-ascii?Q?GvkRi/jVi3eVL0zelDAvQJ7pd1eOV8c1B0WteutO0wD5ov9gQiO4yG4XWsln?=
 =?us-ascii?Q?53DAldfwKK5X3JI+lRKkCHAX6jdc453vLSGj0OcOvXTFKUyKfaz8SAlLQqiq?=
 =?us-ascii?Q?eKshAlcuglp7Wiadw8J2pESD52o8eoYpJ1jJcF8VG7t9QksjLbDCdwuqfDYi?=
 =?us-ascii?Q?npH7sZ4IPnuGyrLp00Fep6AOmgfE0Wc7BXc3WVddn32KQFYHMrTbtB8JcS+o?=
 =?us-ascii?Q?hbQvMhfaTjRvn01jXpE1loGwvlk3/3gwKv9gD3j6roAJ6VXMOQC5AHO3c5W+?=
 =?us-ascii?Q?xy0vsAt7zVs2kH4EwmjDnF5XKqBBcsp8yNX/Uul0CYZWpgIgk0Or8upxas6z?=
 =?us-ascii?Q?LsIheZtHrukX+/eibqgXeAvqpWTCMLWD6n3Lkjm6zkZrZx33SBPlndRV5sHI?=
 =?us-ascii?Q?9VjGZe4lc9/V8KMOw+wqyHHRxPo9tm+B9QgzvDWVUGQLGRm7lB2tzlX1MxEE?=
 =?us-ascii?Q?OTj7nlDI2XnFziQ43Hgnbe0apO8TlvcRs5qhMeVO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0E5lNsSedGJFczwkMh0SEmnqRI/62PtrGhhIPl2VKGMU5AOhdTZ73OxzVashy+lCyKq1jVF/FPwdHBajoMteav8z8BzFYcQAClug9UXJ47q7wo4fYj3xa+Hhzjvhw6HUtkef8XKaEkfbSJdyEoKuxQXHejftWb4ZZgILyXbjiLenBAlds/MQhy6KppSGd+AzY12kIlHJ3ct0qAv4CSsI8nXxyYJUrmg4SUaD42srjhFUKocVqRhGqGJV4mIa3U7Lvw5GwAmLza72gZu7cYjgDbiKdvEvZ2lJHrwKwsiVjg+BcoYRREJL4vHV+45An/iF+Zh1IqG8MYR7BD9+uyc/Sqsqb/JM/gOc/F51BZxgHttNyeEMucST25mgQC3Y51pK8LpbivBoHQHQyR3ioUQqnXEXj7fwyPJzAcKw7ODRfx5nm7dIkbqYuhxOBIb+kYHEZwjwOQeUBkxjRyKfNApzmZh80QiHjTMn/LuLjdXcQyJz5alO3aCjZ2XmmVC+GQaDuF2vJdHFGKjPd4t5cxX6GwnJX8FPMrledps6gl8AoPwoKIkBhAY0qwNKcJAB0nSKSfht44SepZ80eY7cdRSgeDe2cowU+6XI62/8jzfZhk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607b89a5-9902-40c4-a891-08de12339e53
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 12:56:44.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc9j6PVL3+ltAuuQO+HZW5ahwZEUeHPgWN9Yvu7L/+zlEhYAjOKscpddKyeDe8Jkg5boAbHBUFjfjnLqiqfjcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=750
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230118
X-Proofpoint-ORIG-GUID: -xvSHDtlTZfwii5_QKE_ws8ON5sAMCEd
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fa2610 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bC-a23v3AAAA:8 a=yPCof4ZbAAAA:8 a=dRTxrT3n2Klp3RRdNfcA:9 a=CjuIK1q_8ugA:10
 a=FO4_E8m0qiDe52t0p3_H:22 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfX+ycjWYZ8FVLh
 bUtcctGEYcxvaWrMP2aPveA8ZkI5DqTEFt9LQl/O2qZXUURVKRvwp2U9lfmWGOQTlWFoKtSC0s9
 ufr4rrgrq7bii7aSICvR/O6REOWatKfeN35NvLl6omvFNIHe/NnPPS/eakzZqzVHKM4Af82EK7i
 4B3SQNOKQNjXX773Mk8s/lpsvQCgAZh/ii3ECSOjoIv6CwkvTKgHJrT/baywJAX1aR+spqs2Qk0
 Uii2VRr58Mju2AfxKgZO0E+ydut/GCrplrmzFqZAShUHrsUc2IMIhZt2PsB/Y3+6t6emoJ9Cfh1
 XUzHeX7WP/agSdc0BEfJaTnG8UmZwhxW9GMXH+x3tVDF4S7I4nhzjh+e3yP8zOkbAGlGFnd2ie+
 frjaA15czXFIQglYRSGnFgC8b7XQ9WiXDICFRh4ELx17dV3ry/o=
X-Proofpoint-GUID: -xvSHDtlTZfwii5_QKE_ws8ON5sAMCEd

On Thu, Oct 23, 2025 at 02:01:07PM +0200, Vlastimil Babka wrote:
> Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
> kfree_nolock().") there's a possibility in alloc_single_from_new_slab()
> that we discard the newly allocated slab if we can't spin and we fail to
> trylock. As a result we don't perform inc_slabs_node() later in the
> function. Instead we perform a deferred deactivate_slab() which can
> either put the unacounted slab on partial list, or discard it
> immediately while performing dec_slabs_node(). Either way will cause an
> accounting imbalance.
> 
> Fix this by not marking the slab as frozen, and using free_slab()
> instead of deactivate_slab() for non-frozen slabs in
> free_deferred_objects(). For CONFIG_SLUB_TINY, that's the only possible
> case. By not using discard_slab() we avoid dec_slabs_node().
> 
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Changes in v2:
> - Fix the problem differently. Harry pointed out that we can't move
>   inc_slabs_node() outside of list_lock protected regions as that would
>   reintroduce issues fixed by commit c7323a5ad078
> - Link to v1: https://patch.msgid.link/20251022-fix-slab-accounting-v1-1-27870ec363ce@suse.cz
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

