Return-Path: <linux-kernel+bounces-722535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36306AFDBC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394A7544084
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DFC12CD8B;
	Tue,  8 Jul 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boFigN0X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Bvobe7O"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000C33993
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016555; cv=fail; b=D5CgTR94/uw1z0ZmQwr/WOb+kmiSmqW5hJ18amUuEwn0Bgugqk/pEDN6hM7t6yvpmtteNzAairy4tQLiivcUZWvVDMdNF76bnE6In2psjpadNCnDSz497RQSRCx9VpszHpX8sqXZrxb7/CVrF7uLfZZ4zSqCd8eytGu/I6RSMzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016555; c=relaxed/simple;
	bh=ZmKgXQZuxQ7NPqZg0S162ZR6P2K0lV9KEmkq6WLSwlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IUylhUjpZVURKByGPxchQo4BXe760s7ebClfQIaQD1/0qu3a43Z8S20lIPI5o3cyQaiTq2uQ50Qd6qns9FdGulXwgBsc7Sw3tYqbIMBkSKtcFr3c9ObOMgcDoblq7rZEwE60myKoQQuW867sk1xZfAHsBfl2TCP8DqShq4QU4vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=boFigN0X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Bvobe7O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568N87o1002371;
	Tue, 8 Jul 2025 23:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3tG21UHIRP9XQzk2vfQdto7EQReODqJRNzOBe3SLZmE=; b=
	boFigN0XUc6GUeBZm3gdpsoiue2Na3dyVPSp3MWA3xQNWCCWoLWFmRovc0qoGGOQ
	rE0cXmQKkQ00+OXESOkouwvGAkwkqGAAXtoqF8SL6/9pGYjNs6f+hupfvwcWN0pb
	fX6/UOisaYEqIJvbD6a15sAXK8UoGBQw62/LDmkZwSZtRxITi5L9mMHM4fjv7no1
	UL9jPRbY9bWxGXq8y+1t9o36mxD4Ut+MVtsddSWgVmsiwtWh4wQxnHSo+RLwyk4k
	LKlrDLero1wpkqzyDziFsoHlUsgMx9RMZ8yYOI9kdhsqSlMfcdYxaNwEQBOhwA97
	2+hSkbShzJ6XZAOO/mJDzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47scqp807g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 23:15:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568Lpfji040441;
	Tue, 8 Jul 2025 23:15:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgag20d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 23:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC04IkxFYlMXebIktlpEGS+7CUL9aDgkpFpO3mQ/XQ3i/oE9YcgJLLovGBOvOVT8drGUboIHNLmYXNY3R8DDSGNqZITayPQB9ulIPpzXW+FT/mx1eAUmwmYRx3KUmhcKRyGxVFw5b+r3RxPYD1/YYRJZTh5eOA377KautBsF6jY3iKknw5tMHbuI28dNYsvTz7tDB30gXdaOBV8HdWDe/ehUuSoQhRIe/O1MvSPi6KwvMklneNF00tZXmjsSmBljZ+npZIVOJwgRQ614WMjtZeX5tUV5wh2LwGjVej1L+la4d37Pwc3+F2Or9amO15a5g1Pm/XN7HIhd1ipM/XYmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tG21UHIRP9XQzk2vfQdto7EQReODqJRNzOBe3SLZmE=;
 b=pXxKbclDF6z8FytT48xt2px7+dUosh6VnrzSCS9i5HkeXxptW5OKFQ3S/7zq2uW/I3oDEFiR5j8Veuf1zu5KoAuuD6GbryQfOHLYDXsQP41yqdUD2xSTyqLRp8itnz5af3TklKf6YxV0rXouzAkhUCgNGT+pIEL3f8jMWlur+n6OLCEeHlmIuC+wCxg6Ave4MAsFuLfgq+Qh0B7wkm4KgoA2Hk2AanwLH/UMfhsqauXvPf5NEjhU1XpfowFL7OKEhSldh7RrBychdHkID+e7BgeOvLkNcTk0cCPndfteZU6fPDPTzekGV9ILQg0Yhib4KYVJo7vSot/pOWTQFtAPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tG21UHIRP9XQzk2vfQdto7EQReODqJRNzOBe3SLZmE=;
 b=0Bvobe7Og83f+9HQkfF664az6aMhj5GO9AFFVT9WSOYcuoLTyjFJY9Em07uKVL3dXn5y/b52yzW84WFVociKO4/YdiVcalB2Ihj4RBvpDxKXejJLAEp3nlV6g7rCgV+7/O3yIMKLdWEDDjxIkCku26KlX6PRn1SQWz6hTFbWFiI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7212.namprd10.prod.outlook.com (2603:10b6:610:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 23:15:36 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Tue, 8 Jul 2025
 23:15:35 +0000
Date: Tue, 8 Jul 2025 19:15:13 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com, shakeel.butt@linux.dev,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space
 in lock_next_vma
Message-ID: <6mw4p4shg6myw5a677hkvhzytsnfa2e5zb7zpe6kcqlfjglmol@pzwcbowwy2v5>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
 <CAJuCfpFjLmDRE=3E91279A+diisTgz24+a5D6c+sH8Oh7PzP6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFjLmDRE=3E91279A+diisTgz24+a5D6c+sH8Oh7PzP6g@mail.gmail.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b604d0c-8a33-4c25-337a-08ddbe755828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHJQZEdGSDRBMmtQWHVwdUhlaEVYdkhRdWJqbXNDUlVzdG5zMkJlS0hxSTVL?=
 =?utf-8?B?Vk1QL0VkRUFMaDNqajRXbGJoa05Ya01VaEphcjIvRjB5aXlZV0ZYSW5LaXE3?=
 =?utf-8?B?RWxrbWFQUXpPOEpkWmtoNmlTSzF3cnc1cmhiZjlOZFBtY3g2WEZuT0pQOWo3?=
 =?utf-8?B?NEdtaDZmY0llUmh1L2RnVWR5U0NjbGFhbnFYNm1YVjM1WjBxMlBidTBuSk9G?=
 =?utf-8?B?ZWNwd01XK2VZbXhsNEtLT09PNkdFb0R0QktuQ2puRXNCY2t1N1g3aU9zMTgw?=
 =?utf-8?B?N1RPNUxJdDdiSC8vWnpJdGdkVnJyaVBodkNOZlRlNndVNjRtTXVqdzFqN0g0?=
 =?utf-8?B?T0YyKzJQSEpFQzA5UmZHVzhzWGNlMEZLKzM5ZGIwTlExOGRzYmkwMktUM2tj?=
 =?utf-8?B?TXdyQkhyUkV4cURVeGhiS2RPRnZzQ3k1NExleHhscEh6bnNJQmo5bjA2di82?=
 =?utf-8?B?bTlYaGV6UDdVUWVvQlUyWm51bTRMdzFnVGpRVWRsZWppSFRLQjhOZjhYUkh1?=
 =?utf-8?B?OHZmNkFCaXlqZEk5c3luaXFHRnN1YWQ3cnNka05VR29ONjN0dVNlQmUwOXV1?=
 =?utf-8?B?TVJjeUNtRzRzUGVVT0hZYlA1cjZQWTB0WXN4aGFUWFI2eEowL2Z4R0tTVnFs?=
 =?utf-8?B?Z2lId2RMN3RSTHJtM2U2Mzh3VnZLWkZqWjlqc2JBWEhIbzZaSzBkQlM2Tm0x?=
 =?utf-8?B?U3VJOG02WnJ0YnNlMzVyUHdYSUxMUHowdmxwall3cDdZRmdISjRoY1pSZnEv?=
 =?utf-8?B?aldwVlI3T2FOWE1tOGtEdWZaY0oyS0RwTm9aQWdheFgwZW1xZXY3NlJDNk93?=
 =?utf-8?B?YXNZYkVyejh2UHdhZmkzcUlzL0JrOEkyV3h4YVVIdzdLMWVIK3NZaEdpL3dS?=
 =?utf-8?B?VDVTaWZRbm84S1lUQWJNZ21jS0QyWEl1R2tOVlNEL3ZyLzJHOGdhOXloVTNh?=
 =?utf-8?B?NXlBcWYrQVJ2ekZWS2V4SXVDYUJsNHBRenlReWkyOW5FaWxJcHQ1OXQ1N0FP?=
 =?utf-8?B?QkpYaGJoejJ4cThpZUxZejIyMDVkL3RqK3JkK1k1azF2Q28raGlRU29yUHhN?=
 =?utf-8?B?NVpmMzdxbnh4S0pvQ0RLN29WQ3ZJdHZsL1VsbG9rQUFqYjFPdElVWCtndkZ1?=
 =?utf-8?B?NEQ0SVhWd0tta0ZuNnlDcURnOFVEeEk4UzhqWmJnVkQyZmw0U1Z6YUJMOTBk?=
 =?utf-8?B?ZFVqNkVkRU50TVd6L2R4ak1HYXowUCtFbXl2QWhPQVpOb0tzZWpzVXoxYlZF?=
 =?utf-8?B?SDZxRW84bnBGQjBVeEhTVVU4SzU4T0hjZHRxWXB1cThFc21PZGlSU2RiaUV1?=
 =?utf-8?B?d0J5Q09lRFdaZUVVUTQxTlU3R3M1Q2VpT1RZV0ZJeS9rVm1NTVN3V1pRQm96?=
 =?utf-8?B?WFBKeERJS05IZkJLQ0laYm5ncnZ4ZlNXSlZhK0FrSTFoRFA2TzFzRm9SZFB1?=
 =?utf-8?B?RVZ4ekZtOVVpRTMveTRuSkxEZjhCQlJ3YVRSQStPU0pJRDhRUmkraGtrck0v?=
 =?utf-8?B?eXY2ZG14SFlUdzkxOVdnc0RRVXN3Nm1IbEc5U0YyYThxT2h5SkNpNmVnTC91?=
 =?utf-8?B?cG8weEpLWDBXWlBTR0U2OWFZY1V6SEZCOExQT3ZMdWxSSnBXRmRjbmM2R3d2?=
 =?utf-8?B?ckZvOVFFWHNhcVFBTFJ3S0ZvcW55WXh1S2k0SFljOEk0L0VsUnV1d0lMWlBV?=
 =?utf-8?B?VFpSTW9hNmp4NlRldE5ndm9OK1FyYmJ2bkl4UnJpZFMwN1MxR3FWQWdyZERV?=
 =?utf-8?B?Wm1OaVNwQm1wNXhxdmlVMFA3WlJGUmorWnZKWTYyTXg2aGNpV3E4V3hCbVFu?=
 =?utf-8?B?S2FUT1EwWVFGLy9ZYVV4NjNmSGlSTkw1UVJXVXRlMDUyUnFHbWpubmV2YWwv?=
 =?utf-8?Q?Obug76qgsTLOr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRVY1Zib0xiYVRzdnB2WUxTN3dBRGlET0huczJHeWZYSUtQaHhnQTdNT0xV?=
 =?utf-8?B?VFdGekJwTU5pUUk5ekVNd2ZHMFJZUFZZTEQ2bStaQ0MyalJkV283SXJVSzl6?=
 =?utf-8?B?Z3k3djJqKzNLYUhDTTdqQzJMalNmL2t5eXgvSldoUGRzWFp5elc5eVh6TzBr?=
 =?utf-8?B?L2UxQk00MTZ4ejJnZ3Vpb0VSWjA2eFQ5V3BCNk1mUWl4L3lVV2Q1QU9uZkNF?=
 =?utf-8?B?a0MvNFF6NlRXRnllRUdEOFRnMlZnb1pKWDYzQUVaclhuSXg1N0NsdkJXU1I3?=
 =?utf-8?B?QWtydkdLVTBZV3FuL2s5RVU1eDBIUEc4ZjFaclc2N001TnJhZVlEc3ExdEpa?=
 =?utf-8?B?bjBPVHpFTjl1TmZhTTQ5Q3F2cFZ6MmE4UHlmcVI4ak1MR0lUMEowdkxGODJ4?=
 =?utf-8?B?cVpDcUhwSGk4cmNRWUUwazN3ZFRIaFAwOHRBc09pVWN0cDRCdC9sM2dNM0dZ?=
 =?utf-8?B?UkE4ekxaR1RpaTJZczB6cjk5aS9ESEt5Y0VZZTRzWTlkbTlwNXdKaHRkY2tY?=
 =?utf-8?B?RDJNNnpmczZhaXpZUkJjWW9GcW1HZVNMUWowYmJUZDVucDBScm1CUGp1bWIv?=
 =?utf-8?B?eUZ3ZGdVc3E3aFkvb1QzanUrV2N5aG1WdXNmYW1wWnpBYTdGd1BieVdyTWZs?=
 =?utf-8?B?UlB2b2hmdjhIcTRyOHYwNkZsNzVaZFY4U2JVd2prWDdYNXFmSEk3YjZiajNW?=
 =?utf-8?B?K2tGVFBCTTd2RXlBdmhoTHM3KzRFM1VtdjVUSVptMkN5TzFvVTg0VUVGVEJl?=
 =?utf-8?B?Qkg0TTNJbEd6Znp5OXVjSHBIbVorL2tEUW9xTzRFY1BzdVp3a2lCOGV6aEsz?=
 =?utf-8?B?a0lTczdqamhVUTFMYU82OHhmcnJOY2Y3blZPcUdvemJaYmpUVkNxbHB4YXl1?=
 =?utf-8?B?YklRL2lNVEZwcjlZcEsydFhlUUNtTCtHbkF1bSsrc3RGUnJHYWlFRkI0Z3pT?=
 =?utf-8?B?TERVRWZmZWFWRUdTYkRYNUJRY3YxNndGSHp4RXY3UXdGb3ZBWWx5eUdnYi8v?=
 =?utf-8?B?UGNuM2xiOUVIR0dkbjhEWGd2V0dPRlhFUFh2cXNXRnBNUDNjVys4bHREUExB?=
 =?utf-8?B?bk5BV2YyYkJaR2NSQVgvaEhTUktBOUNZNURrZFp0NkFXT0o1WmkwOWJueHdz?=
 =?utf-8?B?NEJLZlo4anVVM21FNkhMdHU5TjI1MXRmcEhsRGJ5VGNaNWc3QjYzSVdWSFRp?=
 =?utf-8?B?YnQ1ZjlybGtTWkNMUm5hTmlZSllseTlHNkFFM21xWlJhdnJyTm5YVnk5dDQ3?=
 =?utf-8?B?U3dPWEV6ak03REpTSlZIKzNLRU5VWUdNdDdBVUhMemFkZVRpNk1ZNGlQODJI?=
 =?utf-8?B?WWZFVS9BRkZ2SU1kY0VzdkJ0ZHFab05mUXV0MXIxbkVCWWd2UDU0dEFVNnJs?=
 =?utf-8?B?aXJMamNPS2tQQXljM3ZKRm4vWUdSNTRxaDFhMnBrNDl3TFpFSktMRnRwaEM5?=
 =?utf-8?B?UXZpVGc0dFZNSWMrUUhKLzhnWU1GQ1EyQ0xNOVIvWWd1c0ovb2syN1QxaFg1?=
 =?utf-8?B?Ykk2Y3M0ZU0rNE5Kb3ZNMUhMTFd3TE02M2orRG4rRDFBdWt6cXNmaHpWYlJK?=
 =?utf-8?B?enZ2YUdEWncwYUJyclBDRGJzNmd2Nlh1ak0zS1cvSzU2cHREL25GeHk5Mnlo?=
 =?utf-8?B?amI0U2JKOTJ4MWYrMkpvS1BBa2d2STI2Z3JxdUVjT3N4d1ZJRG9oQjFTYjlG?=
 =?utf-8?B?UkR3QXVtL0FKUnh6QXBibjcxSkhHQ21JeVFxRXFORVQ5Nm5Na0c4ZHpFQkw5?=
 =?utf-8?B?ZnZRdCtoVTV5cy84NmIrWWcyc2tQREU5Nmp5ZmQ5dkV3aHhiWGVRVkJZSnJy?=
 =?utf-8?B?ZTR4VlI1NGRUdVBPZGVsci9TYnNCbFpOb3pqeENUelVuZnVBQ2Vna1ROM1gv?=
 =?utf-8?B?cnl2MVFLbFlLYVk2czdUTWlnVS9YMWtjRWt0RTg2dmFjL1M4TEJrYkdRMkVD?=
 =?utf-8?B?dGdEOXFiVjBYdGJwdEl2WHdoTjhBOVNNR3V3YW5ic1FuSVlLbll5b2MyTGw2?=
 =?utf-8?B?N3Jsb0ErUUkvdWwxVWxjTzYwVXVPS0FtQUN4ZHQzK3lrOFlTeVMyWTdIODcr?=
 =?utf-8?B?YnVsUEhZWWNqaGZLOW9CUW50SVBnemJlL05zTVhSM3FoRnBkR3hMTjhIRWY2?=
 =?utf-8?Q?QO2sZi/wFhr1a+wQ70w2NyKBa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TupfmonPLv2fEaU4Q1maFWZl3AFGwZiMOkcNdLnUmiANJsmi8CUlxO1jrYGs2aTr/nz2XjxuEll8m0PtaVJvlk7Fw1PgFEeNWG8+Fv5qLyyuCdaEoTT4gt2HujX/fSajbXhcGNNxNQPx/bIbL1csmRJNkX261NW2kr/UqiIDADXdWAv3GdKJGax+GdYo4LG7jNbJJnapyL9PWuX/4UT0MZyuZsKxRhrmi1V1GFtnuAYjfR6TNRQXAY+IPch6Gv0V8d0bCXjvm6idyoqq5WlJm687zC9SEPkJZtGVfQy6/fRVkMTJQWyJq3NAYyRoTfJQbf2jdUTT5pkomPFx37oi2RBGIfY5Vg0hy4T7CoQu17MSFrGqPF2mepFFm1BEdwkmk8g8ZTS9ss7cQ0GD+ll/GfEgbn/aZbPUNMDLQDEtRwZx4xe/8bXlcH2rSrmw57UE0RohM1tIxILrjcnaSE/6c7dL5g+g6R5kfrJ+PmRL/W+vm+l/fMwlCwa29cGsFT/4anPSVbvz2G1agtHPpcvlYMkoqhqiR7NLMl+6nMABdDJYrmWDCcU65B4I/IHjd+h3w+QDzQYXn6qZUT50KdntpRj5VIqSqDisPEvWfPCwGzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b604d0c-8a33-4c25-337a-08ddbe755828
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 23:15:35.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Wn6yqTZIppwIuCVg9UuHwGwAcpvpw5yvWuC4Nf3fD77JzkK0iRTa2Nc7tvZyHsAtkPKRLAjpE0LGIUkudtxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_07,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080198
X-Authority-Analysis: v=2.4 cv=PJMP+eqC c=1 sm=1 tr=0 ts=686da69d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=BbufcsMnDPzxLeqtstAA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=QEXdDO2ut3YA:10
 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5OCBTYWx0ZWRfX9o5jmOt64DKW X4MIvplG/hfzXzKUN/SAwuixxLcqTnnqVs6o0fV4n/qc+ladWu0ptN51VlK/kw3wruqGFERfZhO Y6iP1L/PBmLYWBaJh0JAJRsUfxb7WVZ+fC/M71Kkkdu9/aQNnCrghtr3nlyIgS1lrdDORX3WIoT
 AM0SBROd+8rdwoIeeJjs+Jm+0nlg6Qej4dFh5XvG1+aOCvGBsMSyiVYYY3Sk2bMAw4jepQwEYxw inACNDXYWhdiW4t1i0nphh5Q3Qqxq69x6CkhyJ+Uu8lYPKh10hzecmW9U2BfXGqDNfs6AZV/gXM bkOuIcK/iiDUeGPvzQ8IuAFz360r1Qe1JNtHH+tM7ZgL4grYoiEQ+agf3JdQK0cq6mTQ3PF1Zu3
 H+6PhhZwyOOMIt44dVjICE3rik4IqlJEKSNErcbh3DE1ENy6Ldyih+XzGPZSjLBqyZSzMKAA
X-Proofpoint-GUID: _s0zKqmWLXb9EKZxno4TIXK8fS8rUyvQ
X-Proofpoint-ORIG-GUID: _s0zKqmWLXb9EKZxno4TIXK8fS8rUyvQ

* Suren Baghdasaryan <surenb@google.com> [250708 18:19]:
> On Tue, Jul 8, 2025 at 10:52=E2=80=AFAM syzbot
> <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1719df70580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e4f88512ae=
53408
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D80011ad33eec3=
9e6ce42
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6=
049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1124abd45=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1099df70580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/d=
isk-26ffb3d6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmli=
nux-26ffb3d6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1=
/bzImage-26ffb3d6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: lock held when returning to user space!
> > 6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
> > ------------------------------------------------
> > syz.0.22/6068 is leaving the kernel with locks still held!
> > 1 lock held by syz.0.22/6068:
> >  #0: ffff8880792a3588 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0x=
dc0 mm/mmap_lock.c:220
>=20
> Hmm. I must be missing an unlock_vma() somewhere but I don't see it
> yet. Will try the reproducer.

The last one was against v5 patches, is this v6?

