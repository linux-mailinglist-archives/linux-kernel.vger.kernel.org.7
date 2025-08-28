Return-Path: <linux-kernel+bounces-789859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36477B39B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EC33AEBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CD27E05A;
	Thu, 28 Aug 2025 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVM0Q+3x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KYuPPNqT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F630CD9D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380767; cv=fail; b=LTumDrn8DuK8XHtlA0OyNGSUCl/dVbuoLyFflntSfvkkecwff7/auuP5O5619Z+kshGDQI8ISetRn9/GBMHjI4lLemzyVc0Sqz2x/vCfyzxTXilpAe3cZi2dwwLEW1Dz60TI58uFGs+VNekghJjdCew9SDzsmfs+T02UB9u+tz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380767; c=relaxed/simple;
	bh=jXuWj2RnDc3vS2WWBYQqA36L85Gjqp4XQbCsZFZzVBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTEs8+IJDaXRwmqJbDFjxmUaUoXKG+dUiSvZj5NwJ0iUHjULrT3FcVdXRRyJTIEjnMkPG/XicjHmO7jUOziAZUL1q5wyJmG1/dQbNSpZBet4FP9zPxV922t5F9m/Fea2eUWvksjP+84KKy5x2Hido2BRlzpUmnnghf93OjFunzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dVM0Q+3x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KYuPPNqT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8u4UW014282;
	Thu, 28 Aug 2025 11:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jXuWj2RnDc3vS2WWBY
	QqA36L85Gjqp4XQbCsZFZzVBM=; b=dVM0Q+3xUXMo3ASSRpg8Nxye9VDgD8uDWj
	OtahInu9j3/bLHUTehF/Ov5iVzxCnmxBViHFGpPG/Q3ppjooBdTsQKAcKHeGpS+2
	/re5nW6oDqMYWoOSsHm9asOm7v5RYM8lYcPjjPb+HjEwXT6R3lW3AunGXhbDp/Vb
	Rl4qrXuPPj6gDkxsOfQglyVMRY3z1B8AYL7fZkNxSzm+5LHqbrhsBoSW/B2b8Wcq
	SvYi0jZUtnAZMyjSZcmXHvGPs5RMNUsQZuFm0ev3HUXFniWu6zQr2QqoeFrGeEeN
	H3NH8+JiQYb0ZvBP9Bt1bfxu5Zb9g3ZyplhH7rtWH2Y/5cmvEjuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jaratb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:32:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SA93ff027115;
	Thu, 28 Aug 2025 11:32:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bn5n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeebBBEGxdCGQwuHnM1AIsi8msAmZIQ3XNAfAeEZ/RrnOUW5kmljkX4v9N1zuOrPgWmJqdia0CD2JgQfIoZLLpGjRUjX1LP/ZqbqWeixXBwBITClo893+qag80V7BVxuT5GkJlhpxSmUeR5i9+ri2iCA8ZvGClGzwEizqJ8dQxs8sGtPGdXYldHpz7fzLsQKqS6L/IxPhGhChrbsrvMVbL0pqTgHS9+4+OyvUaFJOCLMQU105/3n70oeL2tNkY4UxG6VYoKpCbr+NDxbnp0D0hl8XIw3uDIU0W6tQlhOg5Xz/E12DI+dGH+wXARed3V+GGJBhHNlkzJESqLAQflKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXuWj2RnDc3vS2WWBYQqA36L85Gjqp4XQbCsZFZzVBM=;
 b=ETYhA1rNYMYYo0g9GusA9gn+6xuQUg+p3eZBFfyfAfLUA7BjdtHaaKRm3y952joDBJIT7Zolpfh3ODVnpp9NAqmG5F3DLJhGIWFYbSl73yd0P4cuuTpwXjfZ3XT3d4qAKMz75uVvoQRaWJmyzFDDMfKjU9v7ETsP0iLhErDbMUXzLf7fB2QIvyRaJoaxjg+aVgt1bYYRbThNQ9G4nr5mXRK7Fz5BZBb4Mrh9hswH5ntwiy6jFpyiRs1WrbjK5MjzMVZVCTw3r1ODPdAD/G2g/wILTECMPWqeMOBbuvUWBW5DJUAmEHF/LC6gwHKJDdFhLWJ75KnpCtYZsvKSxhXU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXuWj2RnDc3vS2WWBYQqA36L85Gjqp4XQbCsZFZzVBM=;
 b=KYuPPNqTutd6FevbTGTciVGiBMW2jpl0kRlMQrYT3reok2EQ7B0m2CLTAjXUWxGClVVhgmqWsjsAxpfROD6y2pKfWGefMA7jXAOyC6kfji33cBLAK6tQsDfQ/UQApqOzCrVjtsxjgU7RaZBnujY3C5UeBwKyjhsnJgia2SzTOE8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 28 Aug
 2025 11:32:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:32:15 +0000
Date: Thu, 28 Aug 2025 12:32:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        android-mm <android-mm@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
Message-ID: <cc185893-dd85-4571-9d0f-23ca3b8762df@lucifer.local>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <CA+EESO7j4dY3KjBWybTG6uQmXJ8kyhBrid3rTk5XAP7poZOhYQ@mail.gmail.com>
 <aKqjWqn8lrITKI7P@hyeyoo>
 <CA+EESO6PFJ9A0kbRWd-ARBLmQ9pwNOF=GBuAzMCOyFvps4euGA@mail.gmail.com>
 <aKxAWqvTxctPoumF@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxAWqvTxctPoumF@hyeyoo>
X-ClientProxiedBy: GV3P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce58340-f3d6-4555-fcd0-08dde6268a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBpeHtdgKRZY1GT3qEx+ep7CBE7hCnFTy5C2gpeBRQLZmIeLQA7JyRtnDcmW?=
 =?us-ascii?Q?bLmxgzH0robParzLoxgErQ9mph4qCB//GmebsG3g+OqU/EGiqFNsrmXPD5nw?=
 =?us-ascii?Q?I0/Dwc0K/HxQZ20l8h1tfD9ZSIWM/8F5lBQgQ+g45AhgcE9LBMoZWcylEFxJ?=
 =?us-ascii?Q?jJJ03k1Q+7HeqWV4k3uFGI+ua0oHjYW7NXRnYY30oDO7YsH4l8q9QQwUrK0Y?=
 =?us-ascii?Q?HSx579heZA4a+Hh12HjBnzrlr5WqKIw+PMwsniYsO6chBw+HEI1lwc9+LTB6?=
 =?us-ascii?Q?ZBUGy2VhrwOVXOzfrePgzEJlt8fUHUSN0gKoNshYgCLVJLrlQrbBcMEm38Fk?=
 =?us-ascii?Q?kNApapBixq4E5LVOVPiwCni+7smzX1yzA4tXl2gChLllP/VXEds8y4A4yIbs?=
 =?us-ascii?Q?3oa+bc9ECdyp31JOJKNVMERDc5nRYZv0zTRAMYyBL8DvoN1tYodGg0loQI8s?=
 =?us-ascii?Q?kFMVKtAg2DQFNXelf1E+Bc7mt4HbPMIOT3XvOkrGMatx9CLlfUuVAMdwBkxs?=
 =?us-ascii?Q?8XlI5/oBpGbxzD4znu7ueg3aEhCgGp89so2jPoiyDmdCRz23wrkT/c9zA5Hz?=
 =?us-ascii?Q?VY/BVOo2eDDdl3H7ILydRkGMkPVMb924dEjwxlffULjomFqTP9nTgvH5fCe+?=
 =?us-ascii?Q?f01mjCftV+xFWxZlU+U+Nbkqgp3FsaTf19Dp2o5S1kfzGLkugp5vUgKs01VN?=
 =?us-ascii?Q?DnwHWqn6Q9lKZ9EzgywkOKiwJwCkpN/p110JtVJ2kpR1moluOeH35NRLO15C?=
 =?us-ascii?Q?FFH/+158MVLWog3ecltsNgP9Ie2gfQkgFYEg/4ANJ8j3WLDwjbY0tGqVvo92?=
 =?us-ascii?Q?Sy2ka37Kfb4xYRZwlW2ttYCZojXmj4yD/bq9ybmiThp0q2mSvLnens32F8Tz?=
 =?us-ascii?Q?Te5vCZ5IcdwkuOXcPLG95h2wahgznOfB30whTyDmqRl+plmJBclnRgnICnl9?=
 =?us-ascii?Q?EXrQY4LXO/s+68UmF4HwPo43hUG2zj5rcr07z36yCWWu22np9dGRz0l8n7yw?=
 =?us-ascii?Q?tIg4oH+86/iR0ovS04Ry2vXotkiiNdbAAlbBLk/SmTIKsOnXPjJP1tTjNVGb?=
 =?us-ascii?Q?V0jBr6an5V5VW5KE+yxnWzQL6Lp0wscSFwGe56pjh4NMWrbwBtyTs5hbKj6r?=
 =?us-ascii?Q?BNtjINghHpOSb3kOT5TAqzhACz73StuVSCam6TY/MfRB7gE9BV6M3qmXHPWg?=
 =?us-ascii?Q?neIHYPaa6ybeM3yvGVDYqx+V99sfENvmDHiR0wFmRbl+3QeeeYmLr3Zrvxof?=
 =?us-ascii?Q?oCUh1YTZfcNcvc0c2QDxqKAOt24jj7gxsl2DQ4SgKm/EtsKmwhKC1yZWiexV?=
 =?us-ascii?Q?bTJk9I40BgzAfmrFpsyUTsWlkDfFBMzpgQFHjCt68uJi5TC+KGD5tLJVzY/0?=
 =?us-ascii?Q?7/5DL21yMuwOfJsjqyvdMfbc75Ze14VEY9mY8MwsT7QzwbbDjg1dk0raE2dZ?=
 =?us-ascii?Q?JGUX85DW/eksm8z3jt4Fcowp/DDRmaYj2RG3qqAUOIk7jXtqcl1d50q+Qyd+?=
 =?us-ascii?Q?e1iUjDMSXACcNbKHV1fgjtTaOUVBHrfL/zzfXuKOzl6DwpWNhvs1wNbRq7aL?=
 =?us-ascii?Q?av5/v8vIqswsUHH+SfOyiNNplrLMgNpcWxRPOF73E2/f5mNzXVbuKk0xmHkW?=
 =?us-ascii?Q?SPiUz/1vVbxxPKTUnishyQf3snQUPx37vOWmGkJfmo+n3+vRdpebiib1sjch?=
 =?us-ascii?Q?olRmpyObSCXzA4socNhM/Mo9lMZR/Qy94ZHuDz8CrGcs8mxI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6EjHbdvaFPj6/v2FeVc1RAceQr68fl9C5OpaJj6GtZ2cwp+aGzeFEQt3JaVd?=
 =?us-ascii?Q?5Ot3TrxncGZHMti58nj/NW2mV8nshksg4H6BZC9KR83hYK6szaN24MndxVrH?=
 =?us-ascii?Q?RAxJM5j40dqw5OmE06TKeIuQQDmTDGnzUiiVQ+/L7h1Aj8a98KqKcCm0UJoL?=
 =?us-ascii?Q?IBMN6GQyQw5bkMdyCgHEt/7alsAfUwrVgT2kPd83BVqrHe+VpB5in/07ANdi?=
 =?us-ascii?Q?Qw+qtaykMdln/ZjwAcw8xTOBl9D31TwmgSutwZj1+nQSbrpcjMIjsvte5fGM?=
 =?us-ascii?Q?cqKdqF6rRTIKNUDVG8eIhj8MzbNZ+TpzKtVt1/QbfklsX9NQ/tOJzaWl2prG?=
 =?us-ascii?Q?9zTmuxCUGRU4+48poAORrj+il63rKF2bJEKjScMM2ydYMTkMAfp3558paJoF?=
 =?us-ascii?Q?dHYTaBuoNKYW7Z0HuaNTRqHHTG6R97p4RnxAq0D69DaArTXZbfUs1X0Xtnix?=
 =?us-ascii?Q?Cf2bxqwnD9CoHjkvTpjh91DnpK7/0HsPhyqjz+26O1BsAeJbTQmeMk/QFIRZ?=
 =?us-ascii?Q?ILFXxkTbvyByJfZaR5nGl9oCnv6Y+PdPuiNKdwxX3E1du0UEDCUXzbooYOG+?=
 =?us-ascii?Q?fAbfFedW0u9mXhqHs0ktNTPEPGWZnDbYXOevks5yzWwX1CrsnNodi7o9x8ej?=
 =?us-ascii?Q?U9ART9YuwtF+IeVA/QAXxNmvcrHTBQTRpM6wLs9Z+7jZ1W5cV9YCUQp5WaEv?=
 =?us-ascii?Q?3cBzwgj6rSMVCAV+t/l8yxnm/IJQU3YxvOE/a7mBBYJvDlIbuJ66CtDqZL1E?=
 =?us-ascii?Q?kQlWbBtSg70RE52SM+g+mpHMwoAaBsBNc7p+2mTB38pm8Mt2B3V0OP5LnPa3?=
 =?us-ascii?Q?iFW+bDVY7KZPdRuGSizAYjdmLL4ZEt2qvvPxDTNN5QtH7QsNJXaBfdGtHGgu?=
 =?us-ascii?Q?HszfKe9lZhRXnw95LwaarfKGuRmPPn44+pYKQc59h21pQqKilz8y/4HFEnp0?=
 =?us-ascii?Q?FoNu27Wr9xuVljUijexFQK6ch2MQ4cGjEhjM8buYL5tokQvJVbLHBFI23rK3?=
 =?us-ascii?Q?Jq0H7aDKJztfElUhIwU8SjYNZ9fcbEN7wjnhKE8/dggAkn4zytC5lvtPXgY/?=
 =?us-ascii?Q?bmrj7vsPgv4FusRYZXHHewO8L1dzs6a9RdBKAHQ/7lKEMs5VGYnv1VTCRxcT?=
 =?us-ascii?Q?Mmm8cN/N92bfJto5uU6lUzBJZ0I3kK5vQVJ6FItePm45suKnPukiDemEmvJh?=
 =?us-ascii?Q?F3fW9sVb5NYxOIg8Ve+QNAgoOeyqvaby6coI/U/RkF3bKDq7mZfXm0GYLrLm?=
 =?us-ascii?Q?3nf8mx8qsfxMCuL9pa5kW8lqEyRDEdi4b8s7DGmjpOWbCqRHJdVotKAg0EIO?=
 =?us-ascii?Q?98ZWFyyJsJNnPP7i4N7bAioFcp9BGvEDiprUe3uM7tQ44nTPreT7x/ZE89C9?=
 =?us-ascii?Q?Zcs/oP5CXKQvl2Hroef+n+c6rmUzBSZ/fgzsWuOYYz9QzLuG8qPMUqClXgD/?=
 =?us-ascii?Q?2Lok7hxabne9qFJ8WrYAZulHJuqKErrhraCRVfPysiHSFUmxg/uX17vIH2eK?=
 =?us-ascii?Q?jV/copCvwgRIhEs+H2B+Uf5lcZiuXa62YI/hOG0x1A/fyHxugmxrCpEwueFl?=
 =?us-ascii?Q?71EpqX8YNDDY8jbTxhQN707FGBXnrwc9HUrKwaSBMaGj8IHDTSvZxrsz3WHh?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	59PMVFfX04dNJtoKyMvHRCXFk/vRqdI1ax30K5kAikzbYFneqX5Ir8xEmHEFGrzU97bo+mbvk2htnZTWGnBiDK9TG0Go1cUK1yl4R+D0uvawDtlR4yrFcye63iszL+GZgM4nbQtj/TXjd9OPp5oKp6NUSG+VrcbRtBFnx6fteQydZi87mi1XmAIdDk/nVbopSSF3quVmMTfwj1GF1C0yR+70xX7tET3fmiwqfKzMlna+hb2x6wsstwR2fv15JV5mibURe1tCNyRi4IGCpcEooH8HWs9+qwSJu9JWE2B1dedViBCKvBFRWJ8OKPWjRtyrZ0juqMDDdlR8Aaa0gj8TbMgSE8vOFVRoI2FnnUvbkR2IXg4fXoN9j+EH0FYOfXvaGqYY3mzDIo7hWZU4ez+KLcqYMc7UjqaQU3Qkg0k4W3pQqyOsV9yRUe3DozE8P8T3xZxEOyUuPy5JqZdv+Gpny0EkgzDUPAvCQJc1FBx4Vw0rSN75Q9n+cqQS0fLc2c9C8N1yCZe+GE7Alc/gCJZ0s4DJ/Kt0PODtFFjwm0pqguiAPVO4+Cik+wr4GG3EN8fOi5W4oDr7FR0+S0KfSquBgcfdF6nAo/0Os1Z/QST7wLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce58340-f3d6-4555-fcd0-08dde6268a26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:32:15.8030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quYcXGiNCpd5b6jYl5EorGaJ0BKHZL6dJeXtrEgGlnwxLPtfKRG3OhDcIh8s6lWrxqm0slAvOHxctYoVG48LhwHGRmv3D6BUhN/kGrfQpfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX7lFlIOqtc76i
 3GNfZYLsWUMSFCG/RlbujgrWKOTBVEFg3B65qYV4/eGRTvrWkcBx/wc+eYtePS2cVXRAbaWLYzh
 E07m0I4C/yDw1rH3W/tGI3GOcTEqqZ2q5FKNUgzNXh5y9Q6Rkx1NBV8Y/LApNMe4qN265ALgf7/
 lkMENJJCJN8cFDFN894QYoMLrP/wS7Ej2QSgZIEWtx4DKJ4eHEqUUMSoLOXmUJV32KIEh3Lbv7f
 ejodNJ58sKqxvE674PnIIgOXiqTpNssKJrqtfqmaeXaye1JiEkVNwi4s3CmygpcPymHEADh1TLv
 v9E5QEsqDtnyfXg+PqkA6wM117yaGsV+fUcOsciBrWEH7o7s8ynJdBsnbwPQoQjGNgJca1qmBW2
 NYdkXURw
X-Proofpoint-GUID: J_-l_AcuEsEsIllKLZVYqaE4cWhQetCj
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b03e47 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=xoyz07IAmwPdV2KO5dcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: J_-l_AcuEsEsIllKLZVYqaE4cWhQetCj

On Mon, Aug 25, 2025 at 07:52:10PM +0900, Harry Yoo wrote:
> Adding folio_lock/unlock in folio_referenced() is likely to affect
> reclamation performance. How bad is it? I don't know, need data.
>
> And adding cost only for the uffd case might not be justifiable...

Exactly.

