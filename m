Return-Path: <linux-kernel+bounces-891931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62EC43D77
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B9473472D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734152EC09D;
	Sun,  9 Nov 2025 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH4LM9aj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823092EC09E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691235; cv=fail; b=coRsJfdHAXVgXXXPtEyBdDOlbl/wy01gQzeLPK56Txf7uwZa/pUIr3a0ejH4Gp0icFaaud8MrmC/0xeb9ENGmOQxJdo4zsPlhEyJYXyv/960gS9fvX24J+ZprpicImbSDFxAN6r45IDK9TojF08/4Jjk/nDFVzTglKgcZA+jNyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691235; c=relaxed/simple;
	bh=xNqafeIiWm9KfNSjJmVNOmBHIs/vG6TTTp0kQWkbw1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKp4MmVi2E9dELhFWWNOdLQRARD66hbPuUed8fuKlNieO02FHWVfC093eynL9mG0XqNt4LSnYQ18ZbuLTsxPpPHTJLVzIOXPIN3Rt1SxQKP1/c1tCMwrwg2qKQlMJxlVzbfhd/qxW0OgKlQq6AWguoCm2J7tImS5GXJAggWzcUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH4LM9aj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762691231; x=1794227231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xNqafeIiWm9KfNSjJmVNOmBHIs/vG6TTTp0kQWkbw1Q=;
  b=JH4LM9ajn+P9XXXUsoJE5ltCp6fDUVPdsKiFggs1rYcFw+71EZWthf6C
   mosjxSdGH0nyDl+kF5FsVn5vMLYyHeSzf4d36CDYP6sOhfIDnNrhfOQGf
   5h7yMvq/5SonAjg/zGwX7QRqRX0fLnsgFOHAuTA0PaMY+Sr9GpLHMXLPD
   GAKd4b8OGTCTv8E2YAGZIb8U2+WmkIj4s44TPEc9KLNJxnALJFWKX3q7N
   5Cez3OU8u79bgu7e3JtXKd+0yzvxAzEEbvmgl8Vs4RJZQPUXKIAHp3Jmk
   fe9fUw+vV/Vu3UcJ+gy+Dwk9sj5rnGSCHTutQ7pFZQEDceL/WTR/JFfOY
   g==;
X-CSE-ConnectionGUID: U2gf7QsRRY2LDiP+zWHS8g==
X-CSE-MsgGUID: yVt3aYciSK+dMAAVkPpz0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64676125"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64676125"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 04:27:10 -0800
X-CSE-ConnectionGUID: 0GUoU/PxT7ecxBs91oGVOw==
X-CSE-MsgGUID: rAqYKOGlTOy7OXMQTtmV/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="187750251"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 04:27:10 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 04:27:09 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 04:27:09 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 04:27:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+2NNM7WWrJGT732INjM2eqYA4WR3aSYDRyjTWGsBPL/cKYdvHBFqznhTDnLhueVaSCE7OcIZhO5g5kqrtrVBHpRGdnfvymmfNqkuYf8rOkHyRNRtty1XZmjY3yS+Dog4UBlldJMyAmUPSN/3Z/i2irZkdvzaahTSusN8ULsMlCvEw3iKblZqliQUr3qMesWYYXyrSS1hEYQ3jjTNU16mRK6eYsSMdhSFPFOYkhoQFXzGVliD4Ljws1ChIXeF2e/P6vTW/SstTryXpePuvRMa0HVNC8k1awWW9NhOc5ZJJ+9jfkz3p9G1xIgEYSYxeoZ5BIWbQHzm9YxHUR3ahhw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScOhzdtn98j1Qj7DuwIKiGktmkvY5MHirJ7U1n9kiNM=;
 b=SNU0h1FcvPIL9LkpFH9OqxYj7tT6iWexLjW5i5QhWpAUcCzgxVq7cnrSQm4QgtXjowqac1EqKY0Vfy0yVuwJX+ANBWVI+LuBnlqgyFxJwaSq6OSlQMJgTdn9pNWHxpeRmJ7XmDzdLnJSWsrF9ULV43uU/EC+tmYpzl0jJ5A3+TNVySmd3gtkkLKITFmTSScoHLBxm0zREw217hAcD3y5a8MG6xYtVP7nqnMBJ74l0qCiuHK3Cext6TsvfFqusboCOGwrDbWoD+tDWbkWAsctXfmqPO2SFdbN71scqRLz57UHadDr6vTxMYku9QZZOi8q9MwB5SmX6ZoeVaS6A1gb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 12:27:06 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Sun, 9 Nov 2025
 12:27:06 +0000
Date: Sun, 9 Nov 2025 20:26:58 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common
 delegation retry
Message-ID: <aRCIklO8pj8dkp/2@rli9-mobl>
References: <691059ff.a70a0220.22f260.00a6.GAE@google.com>
 <202511091831.tPcsumuB-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202511091831.tPcsumuB-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|CH3PR11MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a6fd7b-86e2-436c-680b-08de1f8b4bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fRw81qY0ooTzcSqGeGIQQedYQwUy5uueHEGDV5TNf5UmpuF24x8GFeAy4SPn?=
 =?us-ascii?Q?Nnork2feNIV9V1EkQSz9EX3WPniex0P3bnPz8d0u+SIswi604oeqjALMHcBg?=
 =?us-ascii?Q?biCyEd0YkapoVLdVPi5BITvOCmx1xwPIq9Rq/YDtvJ/wxNGVEZedbHBS5qiV?=
 =?us-ascii?Q?mEKUQkxyKBhIs5sZQQxGEmA9jBUQ6zJ7RF76BwmyANHB6JXs79gnnLC9GDha?=
 =?us-ascii?Q?NCEOkgJ6pHcKmLQXFGHJWvkeU1Gn9axaNUsd2NzCyHaM2yyWVpa5U4UEWmXa?=
 =?us-ascii?Q?8yLam9roQTxaY/iRUfv3Q5Yi4SwnZR5r33Nb9LegF6PGN+bh0r6aZ44YYWm7?=
 =?us-ascii?Q?aoovYugr68yGjQcVdHPf3JmJ7qr+rItMa8oOsvmhig5UqQVELnDhUZEACdXE?=
 =?us-ascii?Q?0UnPD8NRulekMhpQw/q8U7G/04+t/fbDZ/lA6C++GQY8Aln3tgoBSV1//G9I?=
 =?us-ascii?Q?MsDiR5HHrL3qtIDleRNgLNiTaGH5bf9J2LUDqnwsALJnGMlGrfzT7w/JzfQt?=
 =?us-ascii?Q?8xzFVesvTkcb4iSYEynPwiBC2BxnP7ruDqgMyfPC+65mfxmcdBn5MlpJ4OdW?=
 =?us-ascii?Q?3K6bMV7Wp18ORXjvhRxWamrNsJflIR2NVqkKLk6WCW+8JhhLmvZ5dh8rrbHj?=
 =?us-ascii?Q?QKIK7e9frass1YLIbzaONPqEqtIh4nylKMAYRZuP1c8XNK7iIgI8vkw0c4xi?=
 =?us-ascii?Q?NIiyNPWwP8vNid7G7uPAhYe6iwGTFDNWEcCF5UejwXx+dlcX48k1Inoan/WS?=
 =?us-ascii?Q?f1RTKq1r1fiOyV+Z8TXBiYZZ7lxxuHayYK6wSnXrYNyGilmtsI7Yix4QhLg4?=
 =?us-ascii?Q?/GK4rG4/OEsYw/QaYSJGVHw2iFn5I4179dOU/kiVh+eOOwgwMwRzbpRibR+M?=
 =?us-ascii?Q?//gzn+G7O3UutkgNGib0/XoVd6gI+9p0BI1F6Vg3yKGW1RWXw/CqiuFSTYcf?=
 =?us-ascii?Q?vnR1fvemdQLMvKiEYOWD/azlc0676swpQuqiwA1fnQMUr49flzcrK71WGm3F?=
 =?us-ascii?Q?pKJoK6KTBL+cieLzgcIi/mEZJsk0+b+aD9NrgpEfkRdMr9VjGF4RQD1dROxg?=
 =?us-ascii?Q?ziZQ2M0dL8D3UXGhXGBPt9kwsDq/+WsjfLszweeI1270Ujw9WkmKBbEPXv/8?=
 =?us-ascii?Q?TqXNQVPuGI2qvyqe7hK98LQI/QperuZet7csto/htfLD92ldzjnEmeBPX9rt?=
 =?us-ascii?Q?xKNaHFuQ0oknGah4pM9ItfsUBEJ24SmCMEMhEl/7VJjIkI/Uh1T+3CAzH3ak?=
 =?us-ascii?Q?Mfjl90OKcIE5d/G+6G4y9eZ3WV5dIXSVhwpzVdtdd8fI26czI3wNdvNtst4w?=
 =?us-ascii?Q?6d7IVTBQSVa1B2XNo1QDv150y9VEtrh3opa4spwAygB66JFl/OQUkAyykuGZ?=
 =?us-ascii?Q?jnNBcXBqHdl3et1+ja2tAMurveMvvZfH4g765xjcJf4sjMVS4t3ekBhIExHx?=
 =?us-ascii?Q?vIlU5xLD3GQtxyEpvKa9wcxblAba4xPIPibo03vWGvwJbIM5kZxREQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmErHjIHuAThKxJu2WW/DS8WDJRUr2b5hv8D9P8cgRBpbeakR42ly5kocuIv?=
 =?us-ascii?Q?eZJNeJpmjGGYJydacXhBiqSN0OB/JZi8+J4yMNlvO66wECYurlOU8Cl5tT+W?=
 =?us-ascii?Q?n/xpV0B9oxYWN1VeVBN7fDFuSygahf3GbutqL9zHGq4p+1xosYq0F3T/cpkm?=
 =?us-ascii?Q?ItOMf29jwELdlPkZBBFwc+IBrbcUVbdxSqG1YqffCUR7fgPwid8VXXpOpt45?=
 =?us-ascii?Q?CwABn5SjekLaqBkJksPyQmg+5oTonR46bbchaPS5Wd/f/d69K9whmbhwdI80?=
 =?us-ascii?Q?nqGSmqGbT4FkANfMrrism8gBT3Xki2KtrLetZrZa0zPAQwvXa18ff5EODI0P?=
 =?us-ascii?Q?5yz+gtiuEiZToRtdeglArz7546618rRNdcOQ1/Hso06o+vksKIodA/FMILNs?=
 =?us-ascii?Q?B/NyYUxUmax7up6zrl+qhDWXpqDvTGY3E/2r83Af/+bBiJMfGsiiOeCKWqhJ?=
 =?us-ascii?Q?8MpzzVq8IQXQ/pMYlu/5lzfMmOdgItu6aVJWq1E6/nQiUZWHU1WvYPaBrnSM?=
 =?us-ascii?Q?nIkU+akkObb3mzEZIbUDRKR2S16kCwnIdIO5Pq0JeepoEDSTXwDRow7jByKO?=
 =?us-ascii?Q?2PlPMfcvvaRs3WX6mEmgaOakZheze0UFGmIGRxSzt+5gHV0ZNZKNpU7BWnM+?=
 =?us-ascii?Q?L3P0X0X8+VkUlbnaHJNn3g9puUaVQP0xKL/AHXGgGTSDrDxGbqUQT8xP9P1+?=
 =?us-ascii?Q?vbCiMjr80Tlf4JQalNyXMODuYRNQMhsnLilc3fGfC+klSA9OR2PiD8uJoHPH?=
 =?us-ascii?Q?kDXdy2MKbd2iBRQk/MfDkmkp2aHQPAvqvMs7HqkaLZzQV1gG9JxkOpyJmZOE?=
 =?us-ascii?Q?CvJahniII3zsDwBpQXwnR9wRlfZX5VyouJI1ffNH81iazaM2BAju0CP0sAdy?=
 =?us-ascii?Q?pQjzCYKZz79TZsdMbFeqcDVqRMzNweZLMbqpcZvb5EAnOZ/UZP4GQZ5QfOgp?=
 =?us-ascii?Q?yvH5Nkrw6nm6QOgd8U6q68vhTiWn+6+pqd7Xprp/UKMTIODj6haudu9XS3a7?=
 =?us-ascii?Q?fZc2kr4gNyFSp6O5xjg1JZCM3FGBiQP67XKFgBC/BnmFRt2dWq0lPQjLwims?=
 =?us-ascii?Q?lMvvRI3QsqnhpV2ILe/Ax9CL44lco+8ANKin0a0aqmbMsTvJxGlSUhdPQh/h?=
 =?us-ascii?Q?tCs+FrKDGErQ/P5mQib5kUwBnVfcOu1SNprTawrLR2vKwrXtd6kRKyHzjQpd?=
 =?us-ascii?Q?ovrMZy3JfWH2kIQywodMgwAkHmtpwn2rLhdjI3bSQUz714IccRbyNJuKatpu?=
 =?us-ascii?Q?w6oTKqRn7Zq42sOwK7xtXiiMGwmL5qEbs+DOilbJax6jf7jAeU2XE5uaJeO4?=
 =?us-ascii?Q?h7SLW2iCAF/dRUdhoXKnPcqtNT2nYaRO2fIMiIu7QIZa769B2ux6VdiNctD2?=
 =?us-ascii?Q?SEcfDpQodWHLWdSbHs4CZkabxv7TndKdCF9oMTbsicRAVdj4mqM09dZp3ESv?=
 =?us-ascii?Q?NvqfRTmINTrWYH9nLTJq+2BD6qax/sfNJSmopJ9Z4jk0NEQBZYGVnV9VfM/e?=
 =?us-ascii?Q?xvAMGS++3pHM/8+CBxEkPz4/iLzvSTeTM4wYDVArk17ngf4FHc5Fe7Ir1m6H?=
 =?us-ascii?Q?OzJ5EzJLBtybppG05jj14xpspNsKm4j6I0x/63st?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a6fd7b-86e2-436c-680b-08de1f8b4bbd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 12:27:06.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgpelmTYuTwCCGxTvwvwCMy08tskdmz69w8aic+UV8x/8uqQscL1cpj5AWKnGmQmZtqXGL7pNFwecZzyUQRSBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com

On Sun, Nov 09, 2025 at 08:17:42PM +0800, kernel test robot wrote:
> Hi syzbot,

Sorry, kindly ignore this report.

> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on brauner-vfs/vfs.all]
> [also build test WARNING on linus/master v6.18-rc4 next-20251107]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/Forwarded-PATCH-fs-fix-inode-use-after-free-in-chown_common-delegation-retry/20251109-171000
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/691059ff.a70a0220.22f260.00a6.GAE%40google.com
> patch subject: Forwarded: [PATCH] fs: fix inode use-after-free in chown_common delegation retry
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20251109/202511091831.tPcsumuB-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091831.tPcsumuB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511091831.tPcsumuB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/bug.h:22,
>                     from arch/x86/include/asm/bug.h:108,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/mm.h:6,
>                     from fs/open.c:9:
>    fs/open.c: In function 'chown_common':
> >> fs/open.c:769:16: warning: format '%p' expects argument of type 'void *', but argument 5 has type 'long int' [-Wformat=]
>      769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      770 |                current->comm, inode, atomic_read(&inode->i_count),
>      771 |                atomic_long_read(&inode->i_rwsem.owner));
>          |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                |
>          |                long int
>    include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ^~~~
>    fs/open.c:769:9: note: in expansion of macro 'printk'
>      769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
>          |         ^~~~~~
>    fs/open.c:769:79: note: format string is defined here
>      769 |         printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
>          |                                                                              ~^
>          |                                                                               |
>          |                                                                               void *
>          |                                                                              %ld
>    fs/open.c:784:16: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
>      784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      785 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
>          |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                      |
>          |                                      long int
>    include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ^~~~
>    fs/open.c:784:9: note: in expansion of macro 'printk'
>      784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
>          |         ^~~~~~
>    fs/open.c:784:72: note: format string is defined here
>      784 |         printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
>          |                                                                       ~^
>          |                                                                        |
>          |                                                                        void *
>          |                                                                       %ld
>    fs/open.c:797:16: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
>      797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      798 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
>          |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                      |
>          |                                      long int
>    include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ^~~~
>    fs/open.c:797:9: note: in expansion of macro 'printk'
>      797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
>          |         ^~~~~~
>    fs/open.c:797:75: note: format string is defined here
>      797 |         printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
>          |                                                                          ~^
>          |                                                                           |
>          |                                                                           void *
>          |                                                                          %ld
>    fs/open.c:800:16: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'long int' [-Wformat=]
>      800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      801 |                current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
>          |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                      |
>          |                                      long int
>    include/linux/printk.h:484:25: note: in definition of macro 'printk_index_wrap'
>      484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                         ^~~~
>    fs/open.c:800:9: note: in expansion of macro 'printk'
>      800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
>          |         ^~~~~~
>    fs/open.c:800:74: note: format string is defined here
>      800 |         printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
>          |                                                                         ~^
>          |                                                                          |
>          |                                                                          void *
>          |                                                                         %ld
> 
> 
> vim +769 fs/open.c
> 
>    750	
>    751	int chown_common(const struct path *path, uid_t user, gid_t group)
>    752	{
>    753		struct mnt_idmap *idmap;
>    754		struct user_namespace *fs_userns;
>    755		struct inode *inode = path->dentry->d_inode;
>    756		struct inode *delegated_inode = NULL;
>    757		int error;
>    758		struct iattr newattrs;
>    759		kuid_t uid;
>    760		kgid_t gid;
>    761	
>    762		uid = make_kuid(current_user_ns(), user);
>    763		gid = make_kgid(current_user_ns(), group);
>    764	
>    765		idmap = mnt_idmap(path->mnt);
>    766		fs_userns = i_user_ns(inode);
>    767	
>    768	retry_deleg:
>  > 769		printk("DEBUG: [%s] retry_deleg: inode=%p, i_count=%d, i_rwsem.owner=%px\n",
>    770		       current->comm, inode, atomic_read(&inode->i_count),
>    771		       atomic_long_read(&inode->i_rwsem.owner));
>    772		newattrs.ia_vfsuid = INVALID_VFSUID;
>    773		newattrs.ia_vfsgid = INVALID_VFSGID;
>    774		newattrs.ia_valid =  ATTR_CTIME;
>    775		if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
>    776			return -EINVAL;
>    777		if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
>    778			return -EINVAL;
>    779		printk("DEBUG: [%s] before inode_lock: inode=%p, i_count=%d\n",
>    780		       current->comm, inode, atomic_read(&inode->i_count));
>    781		error = inode_lock_killable(inode);
>    782		if (error)
>    783			return error;
>    784		printk("DEBUG: [%s] after inode_lock: inode=%p, i_rwsem.owner=%px (current=%px)\n",
>    785		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), current);
>    786		if (!S_ISDIR(inode->i_mode))
>    787			newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
>    788					     setattr_should_drop_sgid(idmap, inode);
>    789		/* Continue to send actual fs values, not the mount values. */
>    790		error = security_path_chown(
>    791			path,
>    792			from_vfsuid(idmap, fs_userns, newattrs.ia_vfsuid),
>    793			from_vfsgid(idmap, fs_userns, newattrs.ia_vfsgid));
>    794		if (!error)
>    795			error = notify_change(idmap, path->dentry, &newattrs,
>    796					      &delegated_inode);
>    797		printk("DEBUG: [%s] before inode_unlock: inode=%p, i_rwsem.owner=%px, delegated_inode=%p\n",
>    798		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner), delegated_inode);
>    799		inode_unlock(inode);
>    800		printk("DEBUG: [%s] after inode_unlock: inode=%p, i_rwsem.owner=%px\n",
>    801		       current->comm, inode, atomic_long_read(&inode->i_rwsem.owner));
>    802		if (delegated_inode) {
>    803			printk("DEBUG: [%s] calling break_deleg_wait: inode=%p, i_count=%d, delegated_inode=%p\n",
>    804			       current->comm, inode, atomic_read(&inode->i_count), delegated_inode);
>    805			error = break_deleg_wait(&delegated_inode);
>    806			printk("DEBUG: [%s] after break_deleg_wait: inode=%p, i_count=%d, error=%d\n",
>    807			       current->comm, inode, atomic_read(&inode->i_count), error);
>    808			if (!error)
>    809				goto retry_deleg;
>    810		}
>    811		return error;
>    812	}
>    813	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

