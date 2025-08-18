Return-Path: <linux-kernel+bounces-773923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122CB2AC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D721168AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637CD1D5150;
	Mon, 18 Aug 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KM0gG+gg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JvJnLE/u"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BA433C4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530040; cv=fail; b=q620L6CHw1qoNgtmS7vOj5HaIDBqHElrq9sRVcI5gOIJBccQWC996MSy5iBkeTS/agQnj4t+U2+QVE1pojRRa/7T2QLgay64u7a6DjvLCMv+AhP+Kj1GbkVqjpgN7EE36VmjEqxYAps98bXN8eHkZDNT6BFPnu2ReNuLUFVk074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530040; c=relaxed/simple;
	bh=3Q13jPEA2DR88CCoDllQRTiKtmVLuSRtMMU4xjyl0P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QW+T4XWvYlYT97ta9jzTaI6snp70fF4/Eow4zj3IEmXIGVpt3AuEdJj5Df8ARHRkA5rdmMu9v4ApSy4LUVKoGxYGq0NBLB/qCt8HmX2K52c3g5rUWMOnI7UVIDVV6t2y40ONpdObnUveLy0OVlch5HjLr5Tsxn9lz25w8lZV/fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KM0gG+gg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JvJnLE/u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEtoqk026642;
	Mon, 18 Aug 2025 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3Q13jPEA2DR88CCoDl
	lQRTiKtmVLuSRtMMU4xjyl0P8=; b=KM0gG+ggbGicDtTRW7fEKPx6G/jBWHZP7i
	52iH2NDkuQ4M/sNG8bfhX14Ufuj50uI1XppRZmgSxn+YzyNUnLcY46aiXkqFq0um
	4wyXX4emkl15UJ+ev4TYiv5cJbKsMmMk6s8BWzgDrc5uigxP4+NzEyUzyFAHGT8V
	gOjSTU5MKess1fSWLuZFr0c/Tjh0EtALtzL1nsrkZPOOU8FuuUZlKNWF25mDsv+A
	P/9zPWJJTh2KKHpvl2QMXV5Hn61CniK+K4PHY/mEclx0SdSbsqKd1ALs5UpoL499
	f4EoT+PEhD2fgEBhRvHsl3vzpBhaS4UsfPdtagwgT7vEPPTzSxIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwua1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 15:13:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEuFmv013309;
	Mon, 18 Aug 2025 15:13:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge956qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 15:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE0VhyGeliiY7puGp9GONHdOdwa4Em1t8ZpvQIEMk29bbtKDbklsADPIPt23RL8PbvipD+DHSwr1e/8faq9z372fLXRfVObLYiUQY6DA47FCkd/iyUGFzmTQBRonNwytf+LBlZAcCNe1KLZ/0ERX2RcMBvLGqtfERjXaJqBDv2hsTqayg2tIow6W8uYs2P06BGz3VEzTQh+gC305tWlx7PQS7xii3FIoR0c6AYLEWyAd8yGTlfg0ZaxiPKtmkpT0MCSkQs/cD5EZMjcAGbPHgOzK+r2hp3gSyMaVeK4PJkcZiLzBmwg2xjElNnRAu/RieHxmBqauCELcchBxHPO53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q13jPEA2DR88CCoDllQRTiKtmVLuSRtMMU4xjyl0P8=;
 b=dEzY8UVKcnvBPg+s489ZcSlLtwVMRrO39Pup1K7+fWDzNPXI6Ra6OJrxNMHMYpMss4PnHc8BNegRCazGEgXVPPabqvpQ2bSJBDFmz0Xyy2trV8dSgphkAIG+j7V3xBJLPAxIdzYQqMFSrih5vm+CjVTRQRhV6D46o5M5Hk24zqX5BADPS3LSmF4lBQSBiavV4ybTrHGghheO9K+yacdCkGl26HbYKVJGD1Ei5Q3h8GZs6M1CHd4zZnGtGWxTy8W1naJ1WqWoQtqjPRqaTpeknfCKKU9fHePZU2Ay02MKRQjHb5PAzK/zdKWagBf4PBFl92YXhlmB4vxDW8Qph+c1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q13jPEA2DR88CCoDllQRTiKtmVLuSRtMMU4xjyl0P8=;
 b=JvJnLE/uVm1rnsXdtYOiI86kij7FbeMkkU5dkmo6t+e9SmV3jXr/lyWJ5Wch11jeI3rv6vRA8vpdcX9ZiiWKh9oLfxeGIDGOcscsw6Y/2V5D5CVgxVjBnosmSr5fbZLOpoWD33k4gU+ngmZZxZs3iWqhgk4r/0tEU93TMlFMQHo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6330.namprd10.prod.outlook.com (2603:10b6:806:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 15:13:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 15:13:01 +0000
Date: Mon, 18 Aug 2025 16:12:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 6/6] mm: Change dup_mmap() recovery
Message-ID: <02d9e99a-d941-4ad0-b75a-ef8251fffeae@lucifer.local>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-7-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815191031.3769540-7-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d67994-76b5-4326-6ee8-08ddde69b924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWAAu+3tzlyPhRaPviCBsqEZE5s+TfbiCQVKqdjJwjwZ1JNevjplqupy10go?=
 =?us-ascii?Q?p6N80M2onlNYhGVe+MQ6pAxAs7W/kxtDaCcDNEBhMzhN19jfBHFYMJWOci7k?=
 =?us-ascii?Q?JrWz5roD9rY9SzCKYMxgN1RpFl77EYJ4lTfkm1z6Q3RLkW93Thf/TIr1/9Zs?=
 =?us-ascii?Q?hBgqDYzLwH3xc/3TKb8nFRYEHvsxWyov/81zK53uECBBBpdjB/714Ht21ZoE?=
 =?us-ascii?Q?il+MJvgFu4hf0GlcaeYrm7mWy/L/x+it08Hjh9VZwdUr+8A9HJoC1ucqUeO/?=
 =?us-ascii?Q?oHYZt2KUnIBGdlm1govBJbSL3oQG/lg5u4CrwLnOtuGhhippRgjSH6pVCyEy?=
 =?us-ascii?Q?qOXgeGOZsg3I4yhFObCu9zevIVaWEYSNL5k5x73vN/VuIb7v9LC8t4uV7Bsh?=
 =?us-ascii?Q?b2J7F0yybeV/KUawyEY91v+HU/21xqhP7H4H98ZMsoc1yGBdHGWej6QV0/BB?=
 =?us-ascii?Q?XE4vC/uTd4MNzlan8TiK98DFEx3yZM6HabyDu2NM6byqgEhPhFNp4HBAIWJb?=
 =?us-ascii?Q?oN8fgeXk1n3VsryK7pRjhLpcVnC1/m1CxXPqBVCxAI9SqMclBsckUME0ZlY5?=
 =?us-ascii?Q?4sZG0UDQR1hfXcR5nzuB1pB4Metkbea0Opjd5rt6PpMu+sVKTNWvT8ZC8Y4J?=
 =?us-ascii?Q?uNzGddbp9iX+6EfiaaPuo7/lAidU4032kqh4fqD2501ic7YFpZ2ihTbwh+vj?=
 =?us-ascii?Q?25ShsWwWdo6e45k/fhGCq3G7s55Z4/tNHDEzmQxzPm6p5yGHYCMfjcwxkqS+?=
 =?us-ascii?Q?7Zj+RnHHvcJQaGRi7jsg1MdLYqb9peK+uKRlQji9oFD3WtIVCyS6weTBKPEB?=
 =?us-ascii?Q?5hcp+KAfQlwhy0c1mtZvtODluMGmltPpSo/tPEoEc5JdPy3BDK/WcDI6NMMm?=
 =?us-ascii?Q?xoqTxgQBkCDeODjN5hktn5fuZWi2ez/Jgf7z17rUPT78JWNZwO6DdBfAQnIs?=
 =?us-ascii?Q?0m5dBR9dS4/dHGPkqg7gN8ZYkTSXNs4qP0sltPrsQboYqdSjbCPab9rgqnNm?=
 =?us-ascii?Q?PBtp8H6pnLOeI42czTWnOKB34z/VdV78TL2RpwaGlgrg2YpLElhiTiIhcaW1?=
 =?us-ascii?Q?N0et3Egb+XgCovtDh+X3bfineqOhx+1ykZTEz7nYSHHad17bprkxBrimL6SB?=
 =?us-ascii?Q?Hfh9HC/6Ya6uzbiz6WgGGXIuOyraztkiI3D08iGj/jHrcaBziJJRiJnLGKws?=
 =?us-ascii?Q?udABMjYIIa1F6AT4odPV/R71bZhFNkm98+zZQJxIRZrDUuKUmM/OMdNt7/72?=
 =?us-ascii?Q?bF2Gw+5z5CwJpbtw6nuK0jS58fhvNuQHHFhKCZTJGtp7gmaxAJyT0aSn1iJK?=
 =?us-ascii?Q?SSK3sRC+PHznj/VCJauvOWF5oFG0+fBfGdT1CV9CwUeIp+zzLyso6/IVEZjV?=
 =?us-ascii?Q?wn9etcOItgLDTgzNT+gQT0GmvJYTZRyc3qCY2fsQdYJAznj3UD94RUjRuVNh?=
 =?us-ascii?Q?jpZ9xCFw4JI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLl67S7uYx2M5cnieJn7oYnP8FqdrISEiqAr3P5xZS3WQ3iGha7qy6REWIiG?=
 =?us-ascii?Q?d5gkH09eaxc5cPiOeLxtbwP/jJqH74OO0OmiOOhVi+qLtTRU3KqCdEHyJhi7?=
 =?us-ascii?Q?z138nLPPNH8HbWs//TKPyixBxQ3rpvf+rmA+TbD0DbhvWyfTHiJqAal49jss?=
 =?us-ascii?Q?R4Y1XJcgKd1H+AF27rXF0p6s5wCAF/L5ZDzcT6+FIci1Yyr0S/gqR+LWQ91T?=
 =?us-ascii?Q?yT7SFte3dHz4HUUtRCcFB/BNnFwFDpC4lwf1WTHSbl7a2Kpzt/cYWiKz/jhP?=
 =?us-ascii?Q?C+YFqxc2KFrqqtP19E+k4tY3kdMAV1sibbDGccLoy3zaX0zCW2AqUJQ76a5i?=
 =?us-ascii?Q?blGGak3oyRbgTWYw4vV80Ud5TRRUYBjGNSDA8iVzDG/k+jGC70wYyib35L7L?=
 =?us-ascii?Q?WOIubYBFxbsz8nNNvhxNqX7+DnSQHhtNBDogByl5CnuyTj/XmnkLG99XKa6V?=
 =?us-ascii?Q?9eix1j/vAn/ABGIcJDC/XYoaZoHb0ULv5gNYxitBhUeYZdL4jZBal9tP5mEL?=
 =?us-ascii?Q?0SDJvwCzgY+AfIj22DCIysYTrPiLakPdU5lZea8wHOSa195LWGVe7i6DoiBZ?=
 =?us-ascii?Q?GGAxTzGmrAO7y72L47vZJIT6he0PqyaS6SiVCrS7AR2y9vhFAz2PQ9nSoqJI?=
 =?us-ascii?Q?XViBKRuVNIeCCH2KoKk7pIcqX2vugZn15/KvOu5pfYnd/VDTvVZBeEGunDk9?=
 =?us-ascii?Q?6ZYOoRfm4a3GRHlcwtU50kicGRuhksjdDQWwChFrLz4+J7D2V5N4T6amIJxW?=
 =?us-ascii?Q?ymZ1X8hw9R3ndtNTn4FCepEhf6LS0uvYEVfRAIywBgTiXJTW2zdKSRA+/sq9?=
 =?us-ascii?Q?Ln0/fYIzZZlW3+YPvHwvJ0QKMbg0ZMqBDt7GBSaoFAAJLlEld5UMSWV69UVv?=
 =?us-ascii?Q?RoUq5X7+tOQ1Z/MRrufTE6gykE5qr3qvAsRIaEf0XHMmBsQkXEgD2j3kBTtF?=
 =?us-ascii?Q?PkP8JjftAeNb/87qta4tiCHfAbLQwtZPuUm/cVGVtwDMG7fMkwkiRfz+VHV4?=
 =?us-ascii?Q?AeJdU6aXxAUwTZBceyIxp+B9z9zh1V6FfcF5Qrc6NkO6fAs4ehgyVpt62IWZ?=
 =?us-ascii?Q?gDVMkukUeil1ICdw3MhDGUY2I17K4ANkuPwSO2IqEiYmeOycWeiIvYWqSccU?=
 =?us-ascii?Q?wpFr+xmwisk1xQa3moz7G76luTLoL4vAEj075ikAWDl8RMsoASLjF9z4TKL2?=
 =?us-ascii?Q?gqTuH5F+AQBBz248D+wYSRaNc92IvllwkCVlH3ijAo9ugESxhn5E/Q/XuwN0?=
 =?us-ascii?Q?oJEquRuH8UalYhZiYjK+KEdBvz4WnXFKjNwQsCA+NZ3TpJOd5DI9w88HFISC?=
 =?us-ascii?Q?W9N0cEfCiRaenK55SyCE1qu9JlUvWB1TacDFgCfwrDpmRGLo/sS0ND9dPP6F?=
 =?us-ascii?Q?9nNSraFEfPEfqJ+c2IoANLUVmWoUrlp0lLqathTUZpW2NQLYgvgHPjfx06Zk?=
 =?us-ascii?Q?FuHnl2J9PIStk3MJ9bj+KCVipLpf8soHnRrs4FlcBw02DKECL5L9ZQrwi8kX?=
 =?us-ascii?Q?peIfNylwguCHfC011fpYv0EPyO5FiH4ADnoQvFAS9BpbJjXdxrBKWPAfH89h?=
 =?us-ascii?Q?BUOJipgjyKvCPTChd/56NdHyFHSmRF0tQfar80Xkw+pkOvvG2zyZ3khMxccQ?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HdWZrm7cUlfYsKCLBUr+JZ+xbixH9j883NAwUA0co9eOc4UkUB2jdAiIEBRAkLUY29lt+WPnSbbhUZuVBa60lvi/y1/8FOPyQpwqFQL/L8m8nYhf9o1sbwe4LIYv4J0gNz1wXPBVGWV2F4I//EhU63xppSY7pac+CPI/+3HUCIqK94sY68AUwvZx9hsOG+OrLJxopkIpKeC865Rj7EvErBc0omh9t29q3IK6r1DCeeQzninzDqHo6K5xQCjjpS1mva++kxjOjUjY0K+nmjHS9A5qrwm7GNso6DR7kDWsUIXJCjKvK/e/2vahVuHYaIASksr7MG6QDrzj1ZT2fsiyCgMQoqJz5YVba08T7zDjqhEBK6JQUB6eOOjXWmP06Xh+zfcgu0y5CA5YnIaiCCM0/1vTVfiqPuLAezRszytQIKQnHMiMWCmboQwKJ3dCF51E5eSrI84RhVxM7PetpC8WLLr9+JMMwJeK5YfKl2X43ZFEeTtlQ12EbEWcc5WSuTA9pJnKGAT/pexcbxS82qrhYeK6ff+Ff2hVYj5AXG4LvZqJ94MdtORGGmPwov19A3dxjg2LalW/De0kqlnG/bTrFr1BUlb3EFNUGgrRn12Pf+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d67994-76b5-4326-6ee8-08ddde69b924
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:13:01.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv/kQoPBwHS8/JGgNJvBd9Sz3KnDtHbz5Q/tossvQjpU0Lsa/1lx5WEkkMT6OeiTFiDB3IXkWsbPdylkSj/ja6LfwUTW3l9C67hpaekJXUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=597
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180142
X-Proofpoint-GUID: 3Xalu05zmMD-h9bGoMz5jikRS4slXfR7
X-Proofpoint-ORIG-GUID: 3Xalu05zmMD-h9bGoMz5jikRS4slXfR7
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a34302 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=DdfZAK1HVTkwGQy1bjYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0MiBTYWx0ZWRfX1r8grAX3+WFG
 3tIE4yeYWawhI5aJBHHHVWSuN3Gj1aT80M01tyOhfIE49tHbTt5EEB/4/ayVNqbwnzk1U5WtTDY
 4WGb3NTzpj/mMCzYSN/Fp36+OjswKxgvWt1jMIejLR7ZLEhbs6MYX+uGa32Inu0g98Ke5aOKqVZ
 tHHevofwQbzzVOl3Bo5L0CNl1PeIz+eoU+9OwUjp/5tA4tq8H5xjBOaYMCug7ohxO9ftKuYq+nV
 GaV+STTWHcAk1nMtwF0TkPoJ1X6JlioySyZozD8bkPmPwZVs60WZX1xXLbDO6wacpdKfGDmbS7q
 XmgBEvmucLhQc2dAc9KFzVbP0JHsgYKvP4IxB5rpLEapOQQ0yytKHM2k/O2i670V90uvoyxjXLq
 OzeaMMXmXxAJQy5Zqb55p5UuoaDsLhamtc8vf691tZlpocGiTa5/dQwn6MXWKM8VFJQO59as

It seems your series clashes with my mm flags change, and this patch is a
victim, it won't apply against mm-new at all :(

