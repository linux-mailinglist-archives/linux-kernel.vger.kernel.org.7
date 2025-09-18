Return-Path: <linux-kernel+bounces-823404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E08B86548
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5823B61096
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85010283124;
	Thu, 18 Sep 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mmGzv6/Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oSTlFPTc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7D280A29
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218112; cv=fail; b=XU5L4JUL/E6d+bqrCYmoJ9WklrLLbnhsSw440Ts5fqSaxiF9NZ+0658nZ6Dv6jUHYEkaOC1tZ7Qz7tTJqr5N7QQ5H1dn0Rf6mR9RIiOvjs06BqkWVLUzxH59NBeeOAPXAAAXZnaNHCWsWaMBDshxRdTnRmy0uGDrIPAks1KL5lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218112; c=relaxed/simple;
	bh=hSlpJZQYLZqD9cfSuHZpV/FEsmyM3FBVEvGcy6IamlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=THOxmrHmJiEsoVTnc+/kU4jQlhHkdb04T7KQRnekZc1cXWjLs8KEQJYkb5dl79D0UAtnCTh4nK3qZbw+JH2J6bT9veKtJ0vNwTh4mJg0HqI5U2bNyPPmsH0iF9a295YeaGT81UjZkn7XlXt37RMFoBqveAECpRdbGgcuuWAHMQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mmGzv6/Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oSTlFPTc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IG8dIo019426;
	Thu, 18 Sep 2025 17:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iNiyqBnl2cgKTwjYMF
	695o+DAxelV7fBi7lM+63o3rE=; b=mmGzv6/Z91KJ6nO3P5+J2Atfg31asfTrnz
	Evo87H8uZ9zvMadz7gzyLmExOvbkHbbc04w+h7tdTydayFW/ScvNQMFdhLJKztDF
	v7auFu7a76gRS+KTE7xRZlisFrkDNdJ3TletrN/+ONmtYqko/QDDsk8JsKQrdczT
	tKQ9/TuXgCU1VE8AmFS+mh6UhNQUP7XFzMSWEpP2eHuiGXDNttJN8bvX00JtKDvi
	EKgsZVc9IcLeAWsUjruiDlzTt+ux2HaTGZalFklMYwbFlzZU5EhHbnnaYQKn4V9h
	4TL05BAl0SqTfYKR2SGUtgNkBbj1MAVLBCAi799cJ6102AMiWlfw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6m20q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:54:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IHqKIP033730;
	Thu, 18 Sep 2025 17:54:41 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fehpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 17:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmmeUibnSCqi+hX2W78hGZ1Jlimq+cQYkCPUAj2oRn+waiwDuxli9FClpDPSgAY4wwb+zwNOtDwbhAJX/e4kKFmItA+rPGnTzoKslOGPkpg4H3Iaw8ycN4+MmIzySQ4bDD/OwUIKPn4VU5zlhK5PNK0hu823d9PTbT0QLXIj2KKt8kUiOt548gHo4CHhutY+yZIcjOH7osBFR24Z3JW1VswV0E1CylJLoUPl73bepueqK6oPq1Qp6lTmlhE90fX2zcGvpgEYh8YOyLvSs7FI//OwdopKvlMqPnoz22iBJtVyAphyg3LgBurJZHo5rFWf1yQgXuFV9/C0d9Li29Gupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNiyqBnl2cgKTwjYMF695o+DAxelV7fBi7lM+63o3rE=;
 b=bM8MQAkRLincUCTQvK8QqYeaZpDG64RsdthFWIFnHJKhkDUQAWJDD9/HZiSyDr4BnflZ7pJXt61eD5/mOy5vAgasoxKAcn6OrII+IwHz9vBppudXNKdkdDxXMyuRpriYDiV2jrhpBM09oGar5OepjFoSzOU3G67JhBVO0/ZPGeb/mnsVVgHK6EBZxR5IjgaY/FE5s6d042bZBumn1h/h5WJBaqSaafGa4EHxyozUX22oKtLuWcRzokFp7/qditmfgtnlmRlPfVKItptI8tDMkcitoZZXWE/6BViacLAGjorjaNKfzhV5j8cwtFBrsERaBxkYPbNgA9Vl8VvBYgzGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNiyqBnl2cgKTwjYMF695o+DAxelV7fBi7lM+63o3rE=;
 b=oSTlFPTcnl7EAEJ2OAEJm0xpeXfrD2wVpyXHO8CA/wOIDzPRxwQUvq/9p1JLeXXgyu/cljdPbPBZNfw7uVjbYhKaqGJy+20hmZ/zDRacMePW3uLH7j1VaRoGUoT/O4scKaYXHWD/zQod8Rw13YwgX1GvqTQCyIYYiD1NH47kJKQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 17:54:37 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 17:54:37 +0000
Date: Thu, 18 Sep 2025 13:54:33 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <i77haarh7xnf322rywrcomptj5eydm33xjwmozt7lvxw6n4rpu@datftmvx47or>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, James Houghton <jthoughton@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>
References: <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0094.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 41923738-3656-4e32-fb54-08ddf6dc6ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ps0JZSH9ZUDX3THB7TLPaz8cOe75pdfolBn+m85oIONCox5FATVvzIqF/MYV?=
 =?us-ascii?Q?XRU2aliQpOrPn2N/whRi7MemrhtEQd39mel+6+7QaZWSCZsch/dIayk56bja?=
 =?us-ascii?Q?83T+m/E6vGCr7uHSSNjff62IdtQjUVE/4aCDsOBlaz+LoHqn+E4LLHJ94X9J?=
 =?us-ascii?Q?n44dA12ED5W6Qkh8sFOuEf7mnWbrE+qRq0xEZxeVCiFQgOKX/Ek0dto6wsP0?=
 =?us-ascii?Q?KgqWUyUiXzwRDzTAAMxaDMG2tXSVaqOmkSsBnUow6uUVvmLJA2GFYP3q/Bru?=
 =?us-ascii?Q?VPZ+IDiFMlTRQqIBOy2q1LoQbNKR+8+3G/muS/zMBQ5RIU67PpQ8W49ZUKf0?=
 =?us-ascii?Q?YUQNbN4x7LL9/9hHDUVegTr9ouGRDCE85MBJ8oetCVVJaOQBbg9EKVMWmijb?=
 =?us-ascii?Q?ZjcH66LKB3i4FXoobkk6xgLfy5MzQYJiO7x8mIWqJEFWLM+fs6t4yD8CCGcl?=
 =?us-ascii?Q?tL+EbdKVzZNu2+9nMXsq8pf7/aMCPlIjcLU2AiAjRLMv4N4RvjqmVN6X4LzI?=
 =?us-ascii?Q?cpfip2snXBv2gvxWvXI2rKm5nNBe5K+uBbNCBxUm+vZUrrv8AzqkGP49Wmcs?=
 =?us-ascii?Q?gbqD4Hbv1kePWDVYUwpdzhht3oF9qQDF9s1IzO3tr6zH6yNB5oUxZESgV5fQ?=
 =?us-ascii?Q?kVS4Nu2LQTQqJCb38yZeMKynDAOCuWWG/3z3Ead1bVuJ29nEEPe0UzfweFJi?=
 =?us-ascii?Q?SjT/cTHXpc9x6OHxYRw9lArYkJwx3/TSlqpA6mVTxGvMFRXfN+xDelE7fjTY?=
 =?us-ascii?Q?Vw0TnP02zRSVfVJz6l9Yg6KDxakzz1ruIhjwjfh1qU8+0TqhZbm8ubwnFZek?=
 =?us-ascii?Q?vzHcz1x3fZnT4xJ2J35w60bRYZ4GYt04JmGj8kYy7BsLi+l67spJcU0mEGp1?=
 =?us-ascii?Q?plMOm12I+W1FA1KW4hKNcwixgScMhvg2XlDcJWVcQcxmkg3Y4UD6hvM5IEFm?=
 =?us-ascii?Q?YI226hv97nMVXd9Z2eD7Y8lctWl/fB2VswK9XeRHrZ5/1HfiJprPIGPiGdAG?=
 =?us-ascii?Q?ZGIaWr+xPRrrtHjEpnbjwQE5wRGYmv/vfKvjed0/lZ3nFi1QeMjmQ+/N2A8Q?=
 =?us-ascii?Q?JWIFh4bZ0bDszEPCWrk9kMw1RXXA5pF1QcE2VqC6drO504cjTVKkgkXvVfjU?=
 =?us-ascii?Q?121hM2SQQ6I1TSMABfFdC/zWHnneS37NzkcAQW8KJS96g7r4xudQO7gAM/3j?=
 =?us-ascii?Q?SftnzBCMg9gsa7INr+8KD+2tmCIODdemNCiiv/Vd01C1i0ZO3kIb13MumAwK?=
 =?us-ascii?Q?VM1jmU0wUuUqChnZhU4+KdSR02gBu3c+gdoIW7g/gEVj6nzPv1dmLg9FNppM?=
 =?us-ascii?Q?SzV/9RXBZDmGi3vKKPqYiD/GOrkbE4ff99+3NAPdK9iXSzPUrLFhwkO/nWeF?=
 =?us-ascii?Q?MAMi40Hlpwh4HYzo/DdlcV6s7p+fHdbkaq1kseTTP0ZlLhk/e9A7c4hvcvX1?=
 =?us-ascii?Q?Z2AJnWOAjoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbgz+uJlQz+VWkGi+RkCstLsrar31ubMekIXElOMnG3rbn8ul6vhbBeqUWt3?=
 =?us-ascii?Q?iUb35MaHR/ejeMa1IycjyOxg0RtMjufKweU5DfL+jUU6zFDj6G0xLq/UZ00a?=
 =?us-ascii?Q?8GGdNlgb9mvAl7nDXopu6sy9zokYJzVfd9hkvDKqVcdwCN09RHJKZZhosl87?=
 =?us-ascii?Q?V7ts8AM8kNdP1fvGC/Ki2G1sdzrtKkxEgIXFPnUmgDdnVN1qnUVfaR4SgYrx?=
 =?us-ascii?Q?4jOdqq8auMN7wzvLHFXPYAbqVMKUaJOtjgHdGEHqwKI8ASlIXnJudHdRE2vA?=
 =?us-ascii?Q?2PXIUehQI6bkUYWn9Mh2U+AYKKzovWij4QvZdRky30I8VtFFzRtA3pnK2gwh?=
 =?us-ascii?Q?9zEG39qnjvpurhXAUv7a+XOEAYAH1A3wqGYRskS9PBmF2J8nzB/LGwv+kLcI?=
 =?us-ascii?Q?wOafBdkuKx/skb84c+Ch3cRs6TQ3RpkV6IEP1swJmLd71t8aJJ5L7jdrSkAd?=
 =?us-ascii?Q?wfbXRdp06DDciDrFdbO47mkQH+9Oz57IuDlYQZ/mUhzeGC4rp5FGYNOrGE9X?=
 =?us-ascii?Q?TrbaeEh5LltL3eqEB5BoOd4h8QAHEvD9udIi8/SC7ncijSqUQabF1tdrz7S9?=
 =?us-ascii?Q?fuyQqRurviWn7HSlFcPctecpg26hj0bS3fQOja4EEfP87MaIXfECVg9zeErv?=
 =?us-ascii?Q?ZLZ5Sv7sNwIh09TwSjelDUGh+OP0iiG5vcVKsaiW2lvCqHlkZ5oLwFZcfaAp?=
 =?us-ascii?Q?D6EX8reZO8V29Q/+Uzs9r7+esuubUsUHQi6GMhyQYDkiDanoZ50ipKqznhm2?=
 =?us-ascii?Q?lv6kFJ4rTkzZUF/GlDkVZdhVoZJtZ6wVi3SdIdGzC6YqkDwMV3X8smdOETEA?=
 =?us-ascii?Q?VEZP3B6k6KphnTpcX+FuzIJitjyJougSS2zMpbzBrlz289a+hwe9dEiQzbzD?=
 =?us-ascii?Q?7cJIPtfQBd6Rh4gD6QhNuIeS40kNqCBtrN5gBWn3fGEx1aIBObGoKl7C6Qrv?=
 =?us-ascii?Q?QFzEM5sURZwZJ6OLuj8y+h5GaWQivks2K+L2bnCZiEa0OKl/2JHRWW/BMBgF?=
 =?us-ascii?Q?oMlT8/62392i5TG06vbC+qNoWrclI6NpO18k4KcO3b38Qxd8DSqIfxZg4GmD?=
 =?us-ascii?Q?YziAZVRCQu6Q5HW/ruxH4AYLCnmM5nUSUpx5j3ccoD7h9BjbXS7wGD8ffh+d?=
 =?us-ascii?Q?N3On+BnY54/HJVxoSNR6QY0r0xSHMgwQhjZPS+x5xFJM0JOF0dWtxLyNrohA?=
 =?us-ascii?Q?EoxaUqSS9ZGh2gLfkKN5vfspShfhzSooS0ysNL6RBrmvxHMkU8+GJsLRVzgX?=
 =?us-ascii?Q?qvLJzYGHB9jqpCPNiCd2dnA92qAbFVdjyKwVdU3DILRcBzoB9jI7dWtUjZwO?=
 =?us-ascii?Q?ihMMyrLRx7m1YAMOn4ithHF2W6rVSD7QyH7kEP4KgU5lLOqNH4HGPCY+POqQ?=
 =?us-ascii?Q?FBgqISq4veUQu/ttoYBd3X+R75p1Os/ezWxdJxQSOH72LzOSCunVQzCJKJWI?=
 =?us-ascii?Q?acWsaedMw4Xmm68WMg8GQL5BrFlqoc58sBs+9KX4baDC4JYK1qeI8tZ0PpTz?=
 =?us-ascii?Q?YPxrN5IuqrQi4ZKitpYpoyjjmsUlSfX3Fo8cvPNJ3i50Adkiaf/ApxOMrtZD?=
 =?us-ascii?Q?3TscbJp2cf6jhcXpPQfZg3IFw9jCuDxTckw/M4Zl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VfK6Ycvv4Ev02gnm2wokhtvitqhym3APMcn/+UEflxs61bLJEepLe4aOFddJQxZXVI6WL9725q98ZqZBuZIYd13d8H5WGHCvi/3PfXvr3Pwmtb/8aCdDJzuBHyZDJKFB9p2rdxGFaPmZS916oQnqXpcG6LRjncGJ4zB8YN4fMaOA4jtvbmOPKogwc9egx0/H4FNFKjO51TRHB2lzLUeUP8PNINGjQ+6AmVHfQbR/R86msFQb/Of2qMsODF6PEMw3MMPZEIQ2yjGjxjXeEF67oEHcROzvpZ4bGZHWX/LVNnV4BezeJF/+1JkuLiYkOI6cvEaLW46haOe1+sagsz0zENComb1Zsx06zSvvB2rloQ2WTziwSfH/nAvS/wqwBnQ6FUbUz7nByk2WeTWUYhJsdYJysIc4RQpoYGmUvvDANewdRzqu6rAEmqD6A13yFYx843HexYgvagJQb4jetZxPhrGtaEfAnKUOH6HgEQK263mFdOhBmGfPYPG9z8l+HkpP1tDIEr3vhFUAaEkOG43qjfp+5eZFOqIQkXKlB0WxiPzelNxdJ52G88ByWc8ffwpnNM0ThphN8bA+yJ2jXdvSbMG5wkDysR4KNJHiwymxiP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41923738-3656-4e32-fb54-08ddf6dc6ef2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:54:37.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUMRpkHjAMo8dUUPAuIHBkIUByYIMR3qLdFW65pnn9E8A95U66yzKVxIWvK9ADPTnYmoffVOQ9+MOkyybk1KJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180158
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cc4762 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=vggBfdFIAAAA:8 a=RLX45CE-8YziD9JLk9kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: JoToePhELhI6VlXv_ziL3XU6nA2bnkOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX63cu00KvzZhq
 /Pb9tAdk8XupDCRMimVGqVbN04SQ4IH0ZV7Nl8xH0HxgmvVmiS0xWJ18UOyAI+p1F0UphBM2bf6
 vfgTJ9ex7A91RkbFXydPjEYr3uzzGvKITKYMf2dG7KguSzQIBOKnoOQJmfan1wJmonO8J20VBlD
 tx3yAuutvhAgbQFc1GGI/j6EmD8i9JnzElbbl9Us5FIGE4Sp5viMwHdjRMF07sEPxB21gcD9lsE
 7r/IQtOiOUG9/OZmxazNtkp7UZrxyBF0JeuN64NF0fzmCNq/BRDYtV92XSG+5WXEbR6y/7DnXXd
 u8BzFLQGZbldEYTeTaJpfUfe6czxocSD03ZijvIzZhb7TmhYFiLbfhUxQVR8UQG3Cq/8J1n4bhv
 UYzHTbM2
X-Proofpoint-ORIG-GUID: JoToePhELhI6VlXv_ziL3XU6nA2bnkOX

* Nikita Kalyazin <kalyazin@amazon.com> [250918 13:16]:

...
> > > 
> > > Nevertheless, let's step back for a second and instead focus on the problem
> > > these patches are trying to solve, which is to allow guest_memfd implement
> > > UFFD_CONTINUE (or minor fault in other terminology).
> > 
> > Well, this is about modularizing memory types, but the first user is
> > supposed to be the guest-memfd support.
> > 
> > > 
> > > This means uffd should be able to map a folio that's already in
> > > guest_memfd page cache to the faulted address. Obviously, the page table
> > > update happens in uffd. But it still has to find what to map and we need
> > > some way to let guest_memfd tell that to uffd.
> > > 
> > > So we need a hook somewhere that will return a folio matching pgoff in
> > > vma->file->inode.
> > > 
> > > Do you see a way to implement it otherwise?
> > 
> > I must be missing something.
> > 
> > UFFDIO_CONTINUE currently enters through an ioctl that calls
> > userfaultfd_continue() -> mfill_atomic_continue()... mfill_atomic() gets
> > and uses the folio to actually do the work.  Right now, we don't hand
> > out the folio, so what is different here?
> > 
> > I am under the impression that we don't need to return the folio, but
> > may need to do work on it.  That is, we can give the mm side what it
> > needs to call the related memory type functions to service the request.
> > 
> > For example, one could pass in the inode, pgoff, and memory type and the
> > mm code could then call the fault handler for that memory type?
> > 
> > I didn't think Nikita had a folio returned in his first three patches
> > [1], but then they built on other patches and it was difficult to follow
> > along.  Is it because that interface was agreed on in a call on 23 Jan
> > 2025 [2], as somewhat unclearly stated in [1]?
> 
> I believe you can safely ignore what was discussed in [2] as it is
> irrelevant to this discussion.  That was just reasoning why it was possible
> to use UserfaultFD for guest_memfd as opposed to inventing an alternative
> solution to handling faults in userspace.
> 
> Regarding returning a folio, [1] was calling vm_ops->fault() in UserfaultFD
> code.  The fault() itself gets a folio (at least in guest_memfd
> implementation [3]).  Does it look like a preferable solution to you?

I think this answers my question.. but I want to be sure.  Does that
mean you were getting the folio and doing the work in uffd without
returning the uffd?  I tried to get those patches, but they didn't apply
for me.

What I want to do is limit the "memory type" that we support by
restricting what is done to service the fault, and handle that in mm
code (mm/uffd.c or whatever).

What we get is more people using the same fault handler and thus more
eyes and testing.  Less code duplication.

Unless there is a technical reason we need more flexibility?

> 
> The other patches it I was building on top were mmap support in guest_memfd
> [4], which is currently merged in kvm/next, and also part of [3].


Can we process it in the mm without returning the folio like the ioctl
does today, or is there a technical reason that won't work?

Thanks,
Liam

