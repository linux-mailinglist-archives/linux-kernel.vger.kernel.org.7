Return-Path: <linux-kernel+bounces-758830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFFB1D44D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3731895325
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB42248F7C;
	Thu,  7 Aug 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nv+cLX1W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08C1F09A8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555679; cv=fail; b=u+qbnPVaK4/0cwsXHL2Pv+4RYOfOkLTkBD0vOfbNhG2Soj+DgtlM9UJPpNp2dfOJ2oSVfM5X02DbgijB/Uohj90CpMLWWaqCmk+9yIkfUOptiePaSycQwMSLk+VFsFaIBfzC3+DfCvH/N99Ri9qmkwmvaYLJLsA7aZhfBq04VYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555679; c=relaxed/simple;
	bh=YzbRjgInJCVKpGyVYSEfiwzOiDBnYViKxhs0e6fdXQw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SvMuk5Ofq7NcmSkAoh04976TrfOZLZ/2dsAcRwwWiWlPmz3XXIadCPZNKaqV4uWfI+M1RZdyVjWiQSTA2TsKRiQZapAL1EkN5hD17gPpoaGinsD1NDs1Bv3cFkJcUKdzHyylwdEQbUAtHgaPhiXa2M1jC59yy5RQlS+mdtGQmEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nv+cLX1W; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754555676; x=1786091676;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=YzbRjgInJCVKpGyVYSEfiwzOiDBnYViKxhs0e6fdXQw=;
  b=nv+cLX1WaKiRWW3uhi8+RlWGSUYz7/brzYCkETuau+NQG4JBtiBCQdVh
   z+o0LV1WWBz4iEsSE4a4yFFGigH7YQC0YMkCYhazeRCUZJKKXY4bDhL8q
   8VtcECMc9c5EoEAXVSx0Qsb0oxo8A4J5fY/bNfRqgUhE+P4h75WZk6TNq
   8qPXmUBxTYCguyCZpzTzHvbDh40+k8U2aPGs1yxlR0HdTVkG+RW2DTi3q
   zxJgutYK7oa1nw307JrD7PYah1euTkNTyc2ewkla75CCWmM0YEzgUuCeD
   EQebhJQvwlOIEmDE59KNi6zm0N441ljskmMsm+xkK2hW2nuqDmDvqZU61
   A==;
X-CSE-ConnectionGUID: ElMOtiQmQienQJjWN5qogQ==
X-CSE-MsgGUID: X7Y0GXlKSme5eQ8iRy5rYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="82330130"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="82330130"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 01:34:35 -0700
X-CSE-ConnectionGUID: I+EMgVj7Ro2W5owBfJppWQ==
X-CSE-MsgGUID: RLHety4jTrqjSbOybXVIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165366424"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 01:34:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 01:34:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 01:34:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 01:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyrryZLLpZEjwgwSwINCfDBZI61JTd5yGK3Oj7b1tfbcOSwxmY6m6D5cYmagMLVd9oQZziW2rIq3jLzI8tqZMVHkuSZ/UBoaGvgz+S0l1Bw6H6idT5pwQUD2YGpTARO72pss7dMjRgDTfybQj9bVXEC26Cfys5Q33v4KL1b4vbgnHtpkd4PLFWXuWxx96ZC9y0RvU1SBCZlxVVzKr7e5yJ1xjf8Lypfq5P4ZzXMH0y7QtDZF3rG4754wJ689/mBxaIYGrBTtdiTIix7rPjvkwAnxyRXAZnwiDoJo7PlJegYrbbapCvRvaPhCw3ACZp8Q4uPom4yQepD8QTEYoWS3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54g6PnhcZPnrQGa0R+UDsqmb15eakpF5vxa3kh7tTKE=;
 b=FPe4vci6y/xG6QPbvtkL28J77qqBhHKHPW9XqjPHsGBjQ8drS9dc9JT1XKXOAAe6roO2gvT6Bn3G1GwhQieLmemDlS38xXUcaESXe1uPH1eGhG7FtL+qSaOJnBeKM63uxRFy44RPfI0rJGB8k842lStpyZ8RzzdRwkUcqr/t/dRHch38/p8LSS7HDtApP5k4CWb4RD/buasMnzF5BHH1Mz04ONi0wN0IHA22uC93tLY0RCIhLTR1t7MLjFyorheXx9YDrEWVQkXB23RIIWj3+VHxEZ5DxS2NiW/rgiZONZyM71/sfl/CvKo+J+wbAmwllaKTFrR+x2Kl1AooZMapPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 08:34:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 08:34:31 +0000
Date: Thu, 7 Aug 2025 16:34:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Chris Mason <clm@meta.com>, Juri Lelli <juri.lelli@redhat.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/deadline]  cccb45d7c4:
 stress-ng.netdev.ops_per_sec 61.6% regression
Message-ID: <202508071007.7b2e45c0-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 727ecd6b-b7c4-4755-61e0-08ddd58d3aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hVbG0PLZD0NB/r8Fq3FGHmKqw02a4+T5nHHYElXIshkM2AQoxFDeevCogN?=
 =?iso-8859-1?Q?JI0J93xOKQp5UhRDaoSKv8gDuMr3eC751argIfVPk0kt0Hf1tPVZnLFVJS?=
 =?iso-8859-1?Q?jGCjl37bP+xfYeGCghC4FU5yNF3cpSukcpLSjdvcIjdsdA106wWvcCuM1v?=
 =?iso-8859-1?Q?QphckJs3rxsHuqaWT4MIHkrk3o0mAZwdWhKQ5QH4g4hSb7sY7D7o8Vwhna?=
 =?iso-8859-1?Q?GT3fillE/yQENVnZQDkn0aLjLD8IdUWEeU6dWEukTUOWXkpBY6KHLGXsK8?=
 =?iso-8859-1?Q?fvxdK+mprHdSptPvjcQDQz9IQOBpr5b9V2tqSUbngDJAPWh4cYC/piR/6H?=
 =?iso-8859-1?Q?HPqNnm3uffT+leWQSNtevLPTo0rahnvY13NDby2nzivfEYa90L6EUYCP0a?=
 =?iso-8859-1?Q?58HjzeKf6WHtPpwt9lZ4one6l9TXopGIyo+WpUQTw4vN6KOfCENL6myvQN?=
 =?iso-8859-1?Q?C0rjUUyhfw1sPRICgZv7oRnY6ChUrc7cdrBPeQDNMe3V8BowyDXmRlf3hl?=
 =?iso-8859-1?Q?791AZLTl/6EM85c/0Tzx9nYqAAyV6k+r4TYSA7oZWrMXtml+aTzhAWv/Ma?=
 =?iso-8859-1?Q?eXmKHjtPFCkPSyuoDOmCGJjhUE6gJ8aG45p+eb1f9CsZ+FqScKB6wB1zH9?=
 =?iso-8859-1?Q?VQ+nJj42RTVIMwlO5RLO2zexx9emdmNilXfNyhIIuhSABhdD/xSUx0nMqo?=
 =?iso-8859-1?Q?hOb+lrE/C8aBTncFv1eflqsAd6TZpzICk817TA3o92egxs7q7TrpT4HnwZ?=
 =?iso-8859-1?Q?CLG5kI59mGDkP1TTTkEiuNZ5wdkT/fozYLKLJu7s69LO4nPMCFYbQwpKJa?=
 =?iso-8859-1?Q?wkZqVRe3yoaUab/wkVPMm1nfcSPP4snRzcLMZ4UhyS0hdIS0iH3AkYUax/?=
 =?iso-8859-1?Q?UeBSv7ZLrP8sc4CFB5Y1NUZTGjYaLK+ow48Ug4/aMeAbNdqA0+ptF+xfKH?=
 =?iso-8859-1?Q?RAhnkE140euCwiZ9pRj4D6HXw4jVJSmOG2vtgDQLekoGrj6V9reE1Lyvei?=
 =?iso-8859-1?Q?p3a66QEGgkZ2LIQABHZOeI2FB40pHeUcc6iTGTSwAreDWUXxu7lay6dr+o?=
 =?iso-8859-1?Q?FYNQxhfYS3kQuZuQWmtZGSZ4RaXsfrb9YE/HNU4lD8wIaYJAp3Wdds+s8r?=
 =?iso-8859-1?Q?1la0Jrd9xVepVpnAMMLcqjviGdb2NJo6I6uYbFdeVYOaZ3PgwiPjF4l3RT?=
 =?iso-8859-1?Q?AO4R+lYo/sAIKyoCiTdHWH9B3quezAnn8LuTsGk3Vv/u+RowvMeoV5goJE?=
 =?iso-8859-1?Q?Dkk2IoAqoBHz+utjuh4hpZzyPQfaGJrCJ1ZLiSThbdBSPBTvhpiJj8DYtU?=
 =?iso-8859-1?Q?oLgEmuLlXJzYfyqUfB+nWQZVswhkB4olPLDGi5q/QAFZCMFVEpKaHAAzLo?=
 =?iso-8859-1?Q?7I4+yM+fPwW5m8XZBMhajo0+d/CwRA2f9aDSLyhCL660a+ZJS5CQQYmhnp?=
 =?iso-8859-1?Q?J+j1JUQ2MY4vscri?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FkKWx1tN/WUoa2JPsTIvCy27R8oXDNwYk32s8qBEnxbEuix9dAIKJr0SBG?=
 =?iso-8859-1?Q?ocultFKfIHXqszFewLOQeAWr03ZiWfN2+sJ6dW9OTjbLJIO+OwMaOG7bvh?=
 =?iso-8859-1?Q?0x8n4kkKsWvz8AvVEclkTzhRohkzgm8DZrUrmKXN44XyK8k0M0d8Ye79fj?=
 =?iso-8859-1?Q?pMNTuyhB4G8bJfQlG5zfIPjxaekZgYG9BcAlMDdx/1QBHKNUPi4ZwqPMrx?=
 =?iso-8859-1?Q?6u9s5WAaDMIbPB77ciTCDay5Cn/MQZqkbPpOBLsdYqYQXy94h0v5LScSp3?=
 =?iso-8859-1?Q?d1LpdGMrZsqXucyTwq3fjkL3Lp3yKZys27ZLGjrLASjvR7n1j9Mi64CNK9?=
 =?iso-8859-1?Q?VUHKodiyv49FFH1qNyXXnT/WQ/Bgtqab637YFuC0iogYgU0YB3kIypb+bY?=
 =?iso-8859-1?Q?3yLvyIOUvQ9nlV0+XJb7a9uxwaRWUwzvI0CDlKb29kYLZOF9hBpw79GFP8?=
 =?iso-8859-1?Q?/DC86HKqIjbrKHVHuEHsJf5L6Ic2Ywtw5lDKw4GLsburfTEzouRUdPxaWX?=
 =?iso-8859-1?Q?SbNtaG9D1Ht6Zr5UjI9VxigMNoWDGpojfAYDaGU8ocxHgCRVtujgtBGiN3?=
 =?iso-8859-1?Q?G/Jy4GRaoDx0+1nmKuzYcjJGFASHN9Zc/g8bHSeDNlGgcr89Zf0eYWEkxe?=
 =?iso-8859-1?Q?wboUj1OHdLVuy1NBiXxKLw12CwVjV9GzjX3b9AY2v5yfL29jokxfJKABmf?=
 =?iso-8859-1?Q?efsfDddh+q+d6SKMOG799PsSDP5TwUBOykvAYlVDL1cEyfKIAW/giu0wAS?=
 =?iso-8859-1?Q?gSWF1CmAbq98aicmItDI4AoUhiLJLuvO4Wq7BNX1JWPzgNc2jK9HraVDuk?=
 =?iso-8859-1?Q?6fPO2ZpOscvTRLBAvFxcNd2XPDyVWZGVHKosy9TSX/ePk5opAETKUasb2W?=
 =?iso-8859-1?Q?aaE9wuipJN9RHJ6dzMYZwdRUHn1M3T/K5yoSuhA+T+X9FvOwyfDRpE2VJf?=
 =?iso-8859-1?Q?hEAlrW/q24dq1mV4ZvkKYnX48m+ubJ8yV9pHb1i3OLXA6NhFUfU+jKGShT?=
 =?iso-8859-1?Q?kSG4pejWjOQ1anfVrzSk18D1INBG/rlh9s1S+AuPPyHDmvvKfUg+gGTzM+?=
 =?iso-8859-1?Q?LcDRrTOAYr2gL+2VwN68OyftX8C8QqAY3MlYzz7zMagpLjXeyplLcuVoz3?=
 =?iso-8859-1?Q?etrbpBjhzfM1R6c3SBtT+pyO3MXQemZCkDMBxlMuqGjfNMR+bNgp2xJr9E?=
 =?iso-8859-1?Q?RIZrRa/Sfnye0reEKtUZEFGb7Pzh9yy3WYbWzQtpjvm3r/WgG6tl1DvfAa?=
 =?iso-8859-1?Q?vTEyL9lLKztjWT4r2q0DsvtM5WM0hWcVTQpju7rUJUrL4chg8+WTDg/1il?=
 =?iso-8859-1?Q?dAOYVVwzZpE1S4FfuSLfnpcpSafaO5N0K0OwJINS8W2dkwtF0T4sxAf4WZ?=
 =?iso-8859-1?Q?RBIZBD1PEiyhynNB/LVh/rjkYGZ9AvtpYd7sZt0522pKKFs5eATdrkVtdE?=
 =?iso-8859-1?Q?OlfMVeGkk+rFQVSN2SSJ16A+Ovd5PkKfxgp8Qvld9NUbTmrDlqbawIzIHi?=
 =?iso-8859-1?Q?fJXG0EmCiPSNZchfS8mOVRuJjztaeX46NG0Q2yxyw7ev6kGyn87V6bOpsi?=
 =?iso-8859-1?Q?nAtwKkg1EfyHAO/NprgR55Rln77GmCAMwYRp8YGExrfs2zVwUkMcg+yBqS?=
 =?iso-8859-1?Q?/YJGmPMtIE7mTeAVQjUOVDWt6eZZX0b0k2XHQkjoiUJI0Lxo68wutmkg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 727ecd6b-b7c4-4755-61e0-08ddd58d3aa3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 08:34:31.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FUD6/xB1s/tB2PiE3rNyHu4daDntT92ZSSwfjoyV+xn8KldfFWu+LKjSRB6Zbb6yQ5i3IMjWaIJmRd9MTEzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com



Hello,

besides the regressions (and improvements) we reported as
"[tip:sched/core] [sched/deadline]  cccb45d7c4: will-it-scale.per_thread_ops 36.7% regression"
in
https://lore.kernel.org/all/202507230755.5fe8e03e-lkp@intel.com/

now we captured 2 more regressions when this commit is in mainline. just FYI



kernel test robot noticed a 61.6% regression of stress-ng.netdev.ops_per_sec on:


commit: cccb45d7c4295bbfeba616582d0249f2d21e6df5 ("sched/deadline: Less agressive dl_server handling")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master 7e161a991ea71e6ec526abc8f40c6852ebe3d946]
[still regression on linux-next/master afec768a6a8fe7fb02a08ffce5f2f556f51d4b52]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: netdev
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -2.2% regression                                            |
| test machine     | 20 threads 1 sockets (Commet Lake) with 16G memory                                           |
| test parameters  | cluster=cs-localhost                                                                         |
|                  | cpufreq_governor=performance                                                                 |
|                  | ip=ipv4                                                                                      |
|                  | nr_threads=200%                                                                              |
|                  | runtime=900s                                                                                 |
|                  | test=TCP_STREAM                                                                              |
+------------------+----------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508071007.7b2e45c0-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250807/202508071007.7b2e45c0-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp3/netdev/stress-ng/60s

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  3.63e+08          +643.3%  2.698e+09 ± 13%  cpuidle..time
    204743 ±  3%   +1975.4%    4249334 ± 10%  cpuidle..usage
      4.97          +341.0%      21.93 ± 10%  vmstat.cpu.id
    184.63           -22.2%     143.65 ±  4%  vmstat.procs.r
      3473         +3085.4%     110658 ±  8%  vmstat.system.cs
    408964            +2.0%     417266        vmstat.system.in
   1113721           +17.7%    1310862        meminfo.Active
   1113721           +17.7%    1310862        meminfo.Active(anon)
    177366 ±  2%     +11.0%     196822 ±  4%  meminfo.DirectMap4k
    298665           +19.2%     355990 ±  2%  meminfo.Mapped
    420393           +45.3%     610884 ±  2%  meminfo.Shmem
      2.96 ± 20%     +16.7       19.66 ± 14%  mpstat.cpu.all.idle%
      0.26            +0.3        0.61 ±  3%  mpstat.cpu.all.irq%
      0.00 ± 20%      +0.0        0.03 ±  5%  mpstat.cpu.all.soft%
     96.53           -17.1       79.47 ±  3%  mpstat.cpu.all.sys%
     14.83 ± 61%    +238.2%      50.17 ± 20%  mpstat.max_utilization.seconds
    100.00           -14.6%      85.36 ±  3%  mpstat.max_utilization_pct
   9547602           -61.6%    3667923 ±  4%  stress-ng.netdev.ops
    159180           -61.6%      61151 ±  4%  stress-ng.netdev.ops_per_sec
     67355            +2.8%      69256        stress-ng.time.minor_page_faults
     19016           -21.0%      15021 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
     11432           -21.0%       9033 ±  4%  stress-ng.time.system_time
     35368 ±  2%   +9542.0%    3410177 ±  8%  stress-ng.time.voluntary_context_switches
    278515           +17.5%     327222        proc-vmstat.nr_active_anon
    995358            +4.7%    1042520        proc-vmstat.nr_file_pages
     74999           +18.3%      88740 ±  2%  proc-vmstat.nr_mapped
    105146           +44.9%     152305 ±  2%  proc-vmstat.nr_shmem
    278515           +17.5%     327222        proc-vmstat.nr_zone_active_anon
    826913            +7.7%     890858        proc-vmstat.numa_hit
    629070           +10.1%     692863        proc-vmstat.numa_local
    873883            +7.2%     936679        proc-vmstat.pgalloc_normal
    418067            +2.9%     430228        proc-vmstat.pgfault
      0.10 ±  3%     +37.8%       0.14 ±  2%  perf-stat.i.MPKI
 2.248e+10           -22.9%  1.733e+10 ±  4%  perf-stat.i.branch-instructions
      0.10 ±  2%      +0.0        0.15 ±  4%  perf-stat.i.branch-miss-rate%
  18947128           +20.6%   22857416        perf-stat.i.branch-misses
     35.42           -17.1       18.35 ±  9%  perf-stat.i.cache-miss-rate%
   9364646           +11.9%   10482390 ±  2%  perf-stat.i.cache-misses
  27205535          +125.0%   61210467 ± 11%  perf-stat.i.cache-references
      3273 ±  2%   +3392.2%     114320 ±  8%  perf-stat.i.context-switches
      5.35            +3.8%       5.56        perf-stat.i.cpi
 6.028e+11           -20.1%  4.818e+11 ±  4%  perf-stat.i.cpu-cycles
    327.85          +343.1%       1452 ±  9%  perf-stat.i.cpu-migrations
     68905           -27.8%      49741 ±  2%  perf-stat.i.cycles-between-cache-misses
  1.12e+11           -23.0%  8.626e+10 ±  4%  perf-stat.i.instructions
      0.19            -3.5%       0.18        perf-stat.i.ipc
      4316 ±  2%      +6.1%       4578        perf-stat.i.minor-faults
      4316 ±  2%      +6.1%       4578        perf-stat.i.page-faults
      0.08           +45.3%       0.12 ±  2%  perf-stat.overall.MPKI
      0.08            +0.0        0.13 ±  5%  perf-stat.overall.branch-miss-rate%
     34.42           -17.1       17.28 ±  9%  perf-stat.overall.cache-miss-rate%
      5.38            +3.8%       5.59        perf-stat.overall.cpi
     64384           -28.5%      46017 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.19            -3.7%       0.18        perf-stat.overall.ipc
 2.211e+10           -22.9%  1.705e+10 ±  4%  perf-stat.ps.branch-instructions
  18642811           +20.5%   22455956        perf-stat.ps.branch-misses
   9210208           +11.8%   10296398 ±  2%  perf-stat.ps.cache-misses
  26761745          +124.9%   60190009 ± 11%  perf-stat.ps.cache-references
      3220 ±  2%   +3391.4%     112425 ±  8%  perf-stat.ps.context-switches
  5.93e+11           -20.1%  4.739e+11 ±  4%  perf-stat.ps.cpu-cycles
    322.54          +343.0%       1428 ±  9%  perf-stat.ps.cpu-migrations
 1.102e+11           -23.0%  8.484e+10 ±  4%  perf-stat.ps.instructions
      4239 ±  2%      +5.3%       4464        perf-stat.ps.minor-faults
      4239 ±  2%      +5.3%       4464        perf-stat.ps.page-faults
 6.771e+12           -23.7%  5.169e+12 ±  4%  perf-stat.total.instructions
   5992277           -35.8%    3846765 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
   6049811           -19.2%    4888185 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
   5847973           -63.4%    2140155 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
     30248 ± 13%   +3774.5%    1171963 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.53           -21.2%       0.42 ±  4%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_queued.min
      0.17 ± 10%     +99.4%       0.34 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.53           -21.3%       0.42 ±  4%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_runnable.min
      0.17 ± 10%     +98.9%       0.34 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      2696          -100.0%       0.00        sched_debug.cfs_rq:/.load.min
      2.50           -83.3%       0.42 ±107%  sched_debug.cfs_rq:/.load_avg.min
   5992277           -35.8%    3846765 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
   6049811           -19.2%    4888185 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
   5847973           -63.4%    2140155 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
     30248 ± 13%   +3774.5%    1171963 ±  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.53           -21.2%       0.42 ±  4%  sched_debug.cfs_rq:/.nr_queued.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.nr_queued.min
      0.12 ±  8%    +185.0%       0.33 ±  4%  sched_debug.cfs_rq:/.nr_queued.stddev
    588.21           -17.7%     484.36 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    489.25 ±  6%     -95.0%      24.25 ±141%  sched_debug.cfs_rq:/.runnable_avg.min
    136.65 ±  9%     +70.5%     233.00 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    585.65           -17.5%     482.95 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    410.58 ± 29%     -94.4%      23.00 ±141%  sched_debug.cfs_rq:/.util_avg.min
    117.24 ±  7%     +99.4%     233.84 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
    520.05           -32.1%     353.31 ±  6%  sched_debug.cfs_rq:/.util_est.avg
      1139 ± 14%     -19.1%     921.17 ± 11%  sched_debug.cfs_rq:/.util_est.max
    387.58 ± 45%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est.min
     67.01 ± 18%    +283.1%     256.74 ±  2%  sched_debug.cfs_rq:/.util_est.stddev
    669274 ± 19%     +60.4%    1073556 ±  6%  sched_debug.cpu.avg_idle.avg
   1885708 ± 21%     +44.0%    2714848 ±  7%  sched_debug.cpu.avg_idle.max
      7213 ± 87%    +597.3%      50301 ±  5%  sched_debug.cpu.avg_idle.min
     16.82 ± 12%     -35.5%      10.86 ±  8%  sched_debug.cpu.clock.stddev
      2573           -21.9%       2010 ±  4%  sched_debug.cpu.curr->pid.avg
      2303 ± 12%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    448.26 ±  8%    +220.4%       1436 ±  4%  sched_debug.cpu.curr->pid.stddev
    235851 ± 10%     +17.7%     277484 ±  9%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.53           -21.5%       0.42 ±  4%  sched_debug.cpu.nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.16 ± 11%    +108.2%       0.33 ±  3%  sched_debug.cpu.nr_running.stddev
      1673 ± 16%   +1028.2%      18878 ±  7%  sched_debug.cpu.nr_switches.avg
      2564 ± 67%    +752.3%      21858 ±  4%  sched_debug.cpu.nr_switches.stddev
      0.00 ±111%   +6575.0%       0.12 ± 14%  sched_debug.cpu.nr_uninterruptible.avg
    -31.42          +179.6%     -87.83        sched_debug.cpu.nr_uninterruptible.min
      0.03 ±  7%    +349.1%       0.12 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 99%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.08 ±107%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ±  8%     +78.1%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.79 ± 29%     -99.2%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.60 ± 65%     -92.2%       0.05 ±192%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 70%     -71.0%       0.01 ± 36%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.23 ± 26%     -90.3%       0.02 ± 36%  perf-sched.sch_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.50 ± 42%     -86.5%       0.07 ±120%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.05 ± 45%     -83.5%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ± 28%     -73.9%       0.02 ± 35%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 10%    +136.7%       0.02 ± 46%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.26 ± 29%     -96.0%       0.01 ± 85%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.30 ± 40%     -95.2%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      0.31 ± 41%     -95.3%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      0.20 ± 39%     -96.3%       0.01 ± 25%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01           +73.3%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 32%     -39.7%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.21 ± 22%     -96.2%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.27 ±139%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.58 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ± 21%    +204.2%       0.02 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.39 ±  8%     -99.7%       0.01 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.08 ± 55%     -92.1%       0.16 ±210%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.41 ±  7%     -90.9%       0.31 ± 97%  perf-sched.sch_delay.max.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      6.55 ± 39%     -91.8%       0.54 ± 56%  perf-sched.sch_delay.max.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      2.46 ± 39%     -98.1%       0.05 ± 73%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.88 ± 49%     -92.6%       0.44 ± 88%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 21%    +433.9%       0.06 ± 78%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      6.90 ± 37%    +311.9%      28.44 ±  8%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      9.31 ± 16%    +223.8%      30.16 ± 11%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      3.20 ±  6%     -97.0%       0.10 ± 75%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  8%    +174.5%       0.02 ± 47%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.83 ± 20%     -95.6%       0.08 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.67 ± 38%     -98.4%       0.04 ± 82%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.18 ± 37%     -91.7%       0.01 ± 18%  perf-sched.total_sch_delay.average.ms
     10.22          +205.5%      31.22 ±  9%  perf-sched.total_sch_delay.max.ms
    108.64 ±  6%     -93.1%       7.50 ±  3%  perf-sched.total_wait_and_delay.average.ms
     12100 ±  7%   +1924.9%     245027 ±  4%  perf-sched.total_wait_and_delay.count.ms
      4980           -18.5%       4056 ±  8%  perf-sched.total_wait_and_delay.max.ms
    108.47 ±  6%     -93.1%       7.48 ±  3%  perf-sched.total_wait_time.average.ms
      4980           -18.5%       4056 ±  8%  perf-sched.total_wait_time.max.ms
      7.85           -92.1%       0.62 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    589.78 ±  7%     +28.3%     756.97        perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      1.16 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    500.89           -74.7%     126.73 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      1.20 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.80 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     47.83 ±  7%     -22.6%      37.00        perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
    109.67 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    602.00 ± 48%     -93.8%      37.33 ±223%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     24.00          +438.9%     129.33 ± 15%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      3099 ±  8%   +3753.2%     119435 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      3170 ±  8%   +3674.8%     119693 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
     86.33          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    712.00 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1707 ±  2%     +48.8%       2540 ± 19%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    449.67 ±  4%     +20.9%     543.67 ±  5%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4980           -96.7%     166.80 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5.85 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.96 ± 35%    +145.9%      34.34 ± 34%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
     18.63 ± 16%     +81.2%      33.75 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      7.17 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    479.50 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.82           -50.2%       3.90 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.25 ±140%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.06 ±147%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
    589.55 ±  7%     +28.4%     756.94        perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.20 ±151%    +304.7%       0.82 ± 29%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.10 ± 31%     -70.5%       0.33 ±  9%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    500.62           -74.7%     126.72 ± 19%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.39 ± 43%    +156.4%       1.00 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_ifconf
      0.40 ± 39%    +150.1%       1.01 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.devinet_ioctl
      1.00 ±  8%     -41.3%       0.58 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.21 ± 24%     -98.1%       0.00 ± 38%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4980           -79.9%       1000        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.15 ±108%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.44 ± 96%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.41 ±152%    +306.1%       1.65 ± 29%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.88 ±  7%     -66.4%       1.30 ± 27%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.36 ±  5%     -61.1%       2.09 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.67 ± 38%     -98.7%       0.03 ± 71%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open



***************************************************************************************************
lkp-cml-d02: 20 threads 1 sockets (Commet Lake) with 16G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86_64-20240206.cgz/900s/lkp-cml-d02/TCP_STREAM/netperf

commit: 
  570c8efd5e ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
  cccb45d7c4 ("sched/deadline: Less agressive dl_server handling")

570c8efd5eb79c37 cccb45d7c4295bbfeba616582d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8399           +29.1%      10840 ± 13%  vmstat.system.cs
    974775 ±  5%     +12.9%    1100703 ± 12%  sched_debug.cpu.avg_idle.max
      8.99 ±  3%      +8.1%       9.72 ±  6%  sched_debug.cpu.clock.stddev
    208144           +24.9%     260012 ± 12%  sched_debug.cpu.nr_switches.avg
    166255           +16.0%     192901 ± 11%  sched_debug.cpu.nr_switches.stddev
     31290            +3.7%      32458 ±  2%  proc-vmstat.nr_shmem
 2.324e+08            -2.1%  2.274e+08        proc-vmstat.numa_hit
 2.324e+08            -2.1%  2.274e+08        proc-vmstat.numa_local
 1.851e+09            -2.1%  1.812e+09        proc-vmstat.pgalloc_normal
 1.851e+09            -2.1%  1.812e+09        proc-vmstat.pgfree
      1683            -2.2%       1647        netperf.ThroughputBoth_Mbps
     67336            -2.2%      65887        netperf.ThroughputBoth_total_Mbps
      1683            -2.2%       1647        netperf.Throughput_Mbps
     67336            -2.2%      65887        netperf.Throughput_total_Mbps
   2006974           +41.4%    2838711 ± 16%  netperf.time.involuntary_context_switches
 4.624e+08            -2.2%  4.524e+08        netperf.workload
    117.25            +1.7%     119.19        perf-stat.i.MPKI
 6.963e+08            -1.5%  6.858e+08        perf-stat.i.branch-instructions
      8356           +29.1%      10785 ± 13%  perf-stat.i.context-switches
     25.44            +1.5%      25.82        perf-stat.i.cpi
    117.06            +2.5%     119.93        perf-stat.i.cpu-migrations
  3.35e+09            -1.5%    3.3e+09        perf-stat.i.instructions
      0.04            -1.5%       0.04        perf-stat.i.ipc
    115.09            +1.7%     117.03        perf-stat.overall.MPKI
     24.97            +1.5%      25.35        perf-stat.overall.cpi
      0.04            -1.5%       0.04        perf-stat.overall.ipc
 6.954e+08            -1.5%  6.849e+08        perf-stat.ps.branch-instructions
      8346           +29.1%      10773 ± 13%  perf-stat.ps.context-switches
    116.93            +2.5%     119.85        perf-stat.ps.cpu-migrations
 3.346e+09            -1.5%  3.296e+09        perf-stat.ps.instructions
 3.021e+12            -1.5%  2.976e+12        perf-stat.total.instructions
      7.77 ±  4%     -24.0%       5.91 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      5.10 ± 14%     -19.5%       4.11 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      6.21 ±  6%     -21.0%       4.91 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      6.78 ± 12%     -23.9%       5.16 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      6.41 ±  3%     -21.6%       5.03 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      1.14 ±119%    +155.9%       2.90 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.91           -21.7%       5.41 ± 13%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.82 ± 18%     -35.7%       3.10 ± 17%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.39 ±  4%     -25.4%       5.51 ± 13%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      1.65 ± 24%     +33.5%       2.21 ± 16%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      5.41           -17.6%       4.46 ± 11%  perf-sched.total_sch_delay.average.ms
     18.99           -16.5%      15.86 ± 11%  perf-sched.total_wait_and_delay.average.ms
     48294           +23.0%      59391 ± 12%  perf-sched.total_wait_and_delay.count.ms
     13.58           -16.0%      11.40 ± 10%  perf-sched.total_wait_time.average.ms
     15.56 ±  4%     -24.0%      11.83 ± 16%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
    102.17 ±  8%     -28.6%      72.96 ± 30%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     13.81 ±  5%     -20.3%      11.01 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
     14.64           -21.1%      11.55 ± 13%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    641.16 ±  6%      +7.6%     689.79 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4579 ±  6%     +44.6%       6622 ± 25%  perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
    101.80 ±  3%     +12.0%     114.00 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     35.20 ± 15%     +35.4%      47.67 ± 29%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     23823           +31.1%      31228 ± 15%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1456 ±  3%     +28.9%       1878 ± 18%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    764.24 ± 18%     -40.2%     457.29 ± 29%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.79 ±  4%     -24.0%       5.92 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      7.60 ±  5%     -19.7%       6.10 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      6.81 ± 12%     -23.3%       5.22 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      8.41 ±  3%     -22.1%       6.55 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      7.73           -20.6%       6.14 ± 12%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.04 ± 17%     -28.6%       7.17 ±  9%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    641.09 ±  6%      +7.5%     689.00 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    764.17 ± 18%     -40.2%     457.17 ± 29%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     41.85            -0.3       41.58        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      0.64 ±  8%      -0.3        0.38 ± 71%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
      0.62 ±  3%      -0.2        0.38 ± 70%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist
      0.60 ±  3%      -0.2        0.37 ± 70%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.__rmqueue_pcplist.rmqueue
     34.37            -0.2       34.15        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     33.61            -0.2       33.39        perf-profile.calltrace.cycles-pp.rep_movs_alternative._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg
     34.89            -0.2       34.74        perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      0.76 ±  7%      -0.1        0.64 ± 12%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     99.42            -0.1       99.36        perf-profile.calltrace.cycles-pp.main
      2.42 ±  2%      +0.1        2.49        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.43 ±  2%      +0.1        2.50        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      3.86 ±  2%      +0.1        3.96        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      3.88            +0.1        3.98        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      3.88            +0.1        3.98        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      3.99 ±  2%      +0.1        4.10        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      4.02 ±  2%      +0.1        4.13        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      4.02 ±  2%      +0.1        4.13        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     54.53            +0.2       54.68        perf-profile.calltrace.cycles-pp.recv.recv_omni.process_requests.spawn_child.accept_connection
     54.44            +0.2       54.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.recv_omni.process_requests
     54.44            +0.2       54.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.recv_omni.process_requests.spawn_child
     54.77            +0.2       54.94        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     54.77            +0.2       54.94        perf-profile.calltrace.cycles-pp.accept_connections.main
     54.77            +0.2       54.94        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     54.77            +0.2       54.94        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     54.77            +0.2       54.94        perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     41.87            -0.3       41.60        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     34.39            -0.2       34.16        perf-profile.children.cycles-pp._copy_from_iter
     34.91            -0.2       34.76        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      1.38 ±  4%      -0.1        1.25 ±  4%  perf-profile.children.cycles-pp.napi_consume_skb
      0.86 ±  3%      -0.1        0.74 ± 12%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.55            -0.1        3.43 ±  2%  perf-profile.children.cycles-pp.skb_release_data
     99.55            -0.1       99.50        perf-profile.children.cycles-pp.main
     98.61            -0.0       98.56        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.06 ±  6%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.switch_fpu_return
      0.33 ±  3%      +0.1        0.38 ±  8%  perf-profile.children.cycles-pp.schedule
      0.35 ±  2%      +0.1        0.41 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.39 ±  4%      +0.1        0.46 ± 11%  perf-profile.children.cycles-pp.__schedule
     54.77            +0.2       54.94        perf-profile.children.cycles-pp.accept_connection
     54.77            +0.2       54.94        perf-profile.children.cycles-pp.accept_connections
     54.77            +0.2       54.94        perf-profile.children.cycles-pp.process_requests
     54.77            +0.2       54.94        perf-profile.children.cycles-pp.spawn_child
     54.77            +0.2       54.94        perf-profile.children.cycles-pp.recv_omni
     54.63            +0.2       54.80        perf-profile.children.cycles-pp.recv
      0.86 ±  3%      -0.1        0.74 ± 12%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.12            -0.0        1.09        perf-profile.self.cycles-pp.__free_frozen_pages
      0.15 ±  2%      +0.0        0.18 ± 12%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.22 ± 11%      +0.0        0.27 ±  6%  perf-profile.self.cycles-pp.__check_object_size



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


