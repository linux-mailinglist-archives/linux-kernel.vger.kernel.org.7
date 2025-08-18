Return-Path: <linux-kernel+bounces-772757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A9B29729
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE607A89CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2425A2AE;
	Mon, 18 Aug 2025 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGvfw+Qt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E1257AF0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485680; cv=fail; b=qaCwrJijeHMEu/TQEY9DDcHHlRD3Tn8C4pCNTeK9OkCG+3Iyjj6+luTJN/sqjomNOZXs6z5CGJOJ8bRqxgob2wuig5qVz9j+XBr2BbGfJiXBQ1sS9MtYyxkBNREFvJnRBI6nA6R2KGdXiLNsaYmWemeFBBJ7rdvlp931ZBnY8ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485680; c=relaxed/simple;
	bh=43cAbScdxvBWweIQNPcrvtHhjOzxzuzqCh5CVdLC1YQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shAR8Lax/LzX8b7zUaJpwzL38zrn18tMsLIsKS8WyrRMRL6tjCUnzGorVYf0LTAVfrS+ZcB0etWBhD1vECi7AcEdp6pCWbJrRAwkfx8cosq6Yp92YG8rSAMcyYFGhw9F4HzsuSEN1j7+3I5sYXK/K+xckvNR7lnrCXy3ltqhy38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGvfw+Qt; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755485678; x=1787021678;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=43cAbScdxvBWweIQNPcrvtHhjOzxzuzqCh5CVdLC1YQ=;
  b=jGvfw+QtzDKT3jeIDXZbO4CiZjriy8YxlW7UjbJyj+2IOpIvf7UiOmaC
   tQzd9KZ+mRtkei7nLN8alvpSvpCXlaA1zckY08p9n6tna769ebptPQ6qi
   8GevDxl5HfehpxXTxm27U99YCIWa4dPsQxdT7Ukg+EOBjKBv012+u3O7O
   NJwx4naeZq5tO2p8j/8cgDSyQ71o18h2zocvHo4uCh8jGvwdj2P7qveDL
   LhAKk+zAe3cVJoG4kxr3TWxqrnx1HEUhFP63AqM/B5e7wmQQwF+0gD7ej
   V9z1X3/b1o4uD7kSbSdPPvyWkBLN+QSIjsd+VlEhMmZcG4yBVaZWVaGWl
   A==;
X-CSE-ConnectionGUID: 0uJXKPwnSYSNbTqt3FGnVg==
X-CSE-MsgGUID: ox3o7iGDS7SgKcCPgHbJVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83133436"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="83133436"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:54:37 -0700
X-CSE-ConnectionGUID: sTB8hZLUTImGtrj/TzdiQw==
X-CSE-MsgGUID: JTxgJxD2QdieP7cFCbk6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167380088"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:54:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:54:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 19:54:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1/swtRRXEovVZyt+boIW56kgYT0OP6tiDw9rlGFUmTyDOWU/vuLv3nXQy5XB4rUexcj5kQHH7i01O3QuRDBdqfO8QTX5jkBFU+WOgdcVhO2WBE9CuBDv0P/C73wztYRNJcdA5T9Rg0s49+G48EpOEMoCOvImsboT4Bq7J5g+dHcLtLU9RdXXvCMblo+t8vqvUX2SWzLpOud7OfRS/EitWgu3zsXKPCx4DXsK41KmOGS84WQr/nI+eturr7ag60iPuiBt3dXXptvktcy9DvjE04HK31aLwbsPc2256j2Tdyd7/7mX7PLLWS+NqXAX91d0UxROc/BYU7fPRgIDMog/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSPxdQfAb6cbONOqryXLPVl/GLVAkRZO6ud00+ZpVGw=;
 b=CiX/Z2DIW1U+OHGHf2Z/ofULgzMNKZBlV6SK11/DF7ppQE/03ojssG23KD9x0hQXjG6qV5q1fOH8h2ycF0zZ47T97ZRo3NRPx7Hns2oiznbZvEJJxZvsQgqwQ9OOSu1sAHN38NHovH3XjL904yTVdv9j6DVQhc1kBkQRagV7TwyOyjZRFliH8KSlIzuw//RFEu/n8QaZBTwDr19JFtPfFXHJE5KwuN2VQFHE4rrBA3xi6gfVrwkXbJCxiXMEL6J1AsDJxCYabnqkcuArxrVu+E2md6spUaVTxZGpOSkO++WhdEFuUrqUjlrdzGhTkJxP3fnjQI0V57AjG2LqdEtpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 02:54:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 02:54:33 +0000
Date: Mon, 18 Aug 2025 10:54:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Andrew
 Cooper" <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, "David
 Woodhouse" <dwmw2@infradead.org>, Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, <x86@kernel.org>,
	<x86-cpuid@lists.linux.dev>, "Ahmed S. Darwish" <darwi@linutronix.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v4 29/34] x86/amd_nb: Trickle down 'struct cpuinfo_x86'
 reference
Message-ID: <202508180405.3e28d0dd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250815070227.19981-30-darwi@linutronix.de>
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 6123cf3b-2a64-4de8-7605-08ddde028f54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vYqkuxNTuR8ny6WS4H1w47dbcF4OSqyRvb2wegHEvioTv3Ovdj2az1ibhQu8?=
 =?us-ascii?Q?verEhE7pQ9qGhvlEXSYPTq47lMQEGt4qQgrvENqGK5dlO3ES93TH7tqXkg76?=
 =?us-ascii?Q?cA0gspccND1h75Et6WGFuhdR6MQZkuJjNZqJWV3aFP36PovPeA9fkcN5WxxT?=
 =?us-ascii?Q?4x+zOFIDc5ot6nE4iqtMpG/5nzlgiSX3nLJmVam68NBXifCLanrePtPcq2ve?=
 =?us-ascii?Q?WPwMM3gvgvCnasbHSGiHjZwOrCbi+NUQTw/nLhTQFDO1CEJsoMwUjE6vIbPd?=
 =?us-ascii?Q?rKRrNU208d5birXCzuRfhVczIL6lF3e5Y3oScFH4eBnFkBar/MWyoex9yDVG?=
 =?us-ascii?Q?Aip22REgjkZLxym8BAb1Z2WiBbscdVvH3QnWAOjwPkrlDCGURgOSVr/uxtCU?=
 =?us-ascii?Q?fcAjWcEjfeiLpu8wPHSUyCHofKP/e4/H/ORwSyFcLXQZ8EQRXxkT1M1vQ3Z1?=
 =?us-ascii?Q?f3ufhGYlsMm47vRjs1b9p623h8QeOHgkj/x4g6MLHsKuy607pvsO81tJgNs1?=
 =?us-ascii?Q?W81nlFzmF6bKML8bDe85lX1rgtVQ6jua9A8fThLdyRG8C8GxWGr5Yp3x5XuN?=
 =?us-ascii?Q?pVzMQTO9hVCJyPZ66a7VNKD0xEOOTeDJkfCFF3f11VCjkIMXJ8WjlYSAKE+x?=
 =?us-ascii?Q?oJLMGbznChiUXwMJGetHT3ujcgNSoxjJtMcG3DyQedmh8fV80Rk1jx2SZq2+?=
 =?us-ascii?Q?TMr2cvYXQ1Kcqiw9oF9PkfoKMwyae0l3a2xNxTGu1Kg1mpiEg7KYKZbN5cwT?=
 =?us-ascii?Q?58AX/2jhQKEylX9yhQA7YPE0YgohxuoFAYqMAeugZqfR70MfjGSDgurHtCkj?=
 =?us-ascii?Q?+6RX0p7DOfQVP1l7rOTMBNHQvWoWXaDpHZN9KktgBeqCmjHLtI4dLHKHsDsN?=
 =?us-ascii?Q?//RBNEc6yDU7wZI9mh5uiQiCpy/oToctxlUBkq6VJ75IFopmrs3sAJZvVGcz?=
 =?us-ascii?Q?0CKZrrbZ4VMNMMY+jlmKFbcdgSaM5EBu8Xjpk3cDEt0dZ0UWNkLc3btsuHh9?=
 =?us-ascii?Q?c9v6+joYlnTY6hc8g9mkYtE+MGNDHaGAkVv0z4ZLfSorVZsqH1YCRtuG1geb?=
 =?us-ascii?Q?59eS+gEKKku9zNN3ksXwA9y8+qdCXP+r19b7zgCANVMLo+uAWz39siiMZRyX?=
 =?us-ascii?Q?+DNacI4P1DOxT/RlNzRWFUgZKfin1bL6io+TOCFJhN6gK7s726Ck6QesA1TU?=
 =?us-ascii?Q?+24zp5n9RpNiiuJV9eJFDSCPAEFmg7pdeuzJpMI8usBCses143bjOMehBOxr?=
 =?us-ascii?Q?pv63QGv6SU6POVnKLLcLvhaxWwByuQP1Up8coUZ1gcM/QdA8UldX3Blh5tos?=
 =?us-ascii?Q?36fiRhwc2p8zya0cKhRjRq/FIYlfL7Vwt162yErzDoR4Sf9tKFmu7w/240+v?=
 =?us-ascii?Q?ChzD0947PS3xqnR+AP5QX6T3nxj9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzGxAlVO24D9XZB/2E0movHOHr+ZZ4ZzFhCBeFfAO4uLMCAyvBvlOzrkogS6?=
 =?us-ascii?Q?AP3kzz2rPJ2/mdyijy05gIHirtP/P7LYhzR7nx1Abirzueu5PhVQbjScGktM?=
 =?us-ascii?Q?sxJUABCzdDm+caWINWonfZwSeZfeN7gbigGlpyQ/4fW+MZFZhNDYqcXxElEH?=
 =?us-ascii?Q?WRbhQXRD7RqMzdJpS5TN8i2UH/fXT8FdiMJK3Vnm8YVBZmtFywHYxPak+Fgc?=
 =?us-ascii?Q?0Ch0248svOrJvQLzNUAFGT8S/4WhXbscOrvg9OHhpOuvVa1/5doR9EYJMxik?=
 =?us-ascii?Q?JppHBmUdYFa9HeTk5x1CyF8DQ1KsE+ypid9nEofzraUA2lgb2UlKHVwdf1O7?=
 =?us-ascii?Q?twrUqIgELVyGuYjtQIes6s4q4cK/fwZ71GpRy1AiJfTRh6Iwn3dEYME5/8K7?=
 =?us-ascii?Q?8+BACP7T5LewGWiGaRv0qfyMSpuEcon61XDyQKjs+g5mz4MnFjTq94tg0nTp?=
 =?us-ascii?Q?FDjYkkmJiHUtFoaKuB/9zQxHongwkagiD1/GBl8SL+1RZnEYeUaN479LyAIv?=
 =?us-ascii?Q?qedneC4R/pF4ube6681QUwGPS3nrIuHQOHfoHVWi1ArjmG6IhH/WxwdL1GdK?=
 =?us-ascii?Q?vNgVdjBcCNgrSVU+yvBdYILq1DZN3XlW2c/V5FgfSJNB1vIdgALj+W5sJA5x?=
 =?us-ascii?Q?P0De2crylDpjMd/7SxRg8gkv+Ak7xFxZrec2isRUqTltS5HWzi2jrr3BWzD0?=
 =?us-ascii?Q?NjCgWdAfdyzqJDgfyasxO+bl9lYH2G889dJNa1hXehcLrKNcb/fosugJbdi/?=
 =?us-ascii?Q?rF/31fzHDdCVvWFNhVm4YPVPtdD5Nfcb8fPlikbAuS7KQStr9LktbqI4Hbvb?=
 =?us-ascii?Q?gFK3c+pY9m2xFmLNsiyReBU6COmZ7jf65bsODwJt1E4Z+FRHYJJACSFSlvV9?=
 =?us-ascii?Q?2XpzDkPWgnGVuhZa+ikWObKVpXqaJI9wJvbvmfDElWXG/szpNuH45YlLcprf?=
 =?us-ascii?Q?47w/DsLsuSBtCrrUbOaSdxyhifQSFGIN/Z7c82EnyCAV/OTkabc1l8WPBKlZ?=
 =?us-ascii?Q?EKfg3qekUW9CLqYHZ7QFNX7k7G2fAwy8T2BumYBBu0YncFp5hRoPaeyLPqL8?=
 =?us-ascii?Q?oDIXSjQ1ivEPUhFD2bsYPn9Mk0WndluFJg7Woi201AxIHjSZdYJYecmiSGWm?=
 =?us-ascii?Q?7H/c3AcogpCWFi5TAeZsbRpUeNd+2JMXbyBOVnHFxgSq2mFFwaY/6BQ2X80q?=
 =?us-ascii?Q?U5wYzoA7+JQYGzdRRXqSg1sNa+i4iWzcBXRASYqkEg8EA/49J0ucdZu7hqqn?=
 =?us-ascii?Q?u7b0QjK271ISKkW6ArPHBuJEaIT7s4FjQva0Bz5D4fAMLeWfrvXMd/UzH4vB?=
 =?us-ascii?Q?o8+LIAPlJ9Su8KH8DbwHcwyfU9KfOF2O8GLuaw+UY6TNBl7O+hnaEpK+cuIg?=
 =?us-ascii?Q?3Yg/i2Ic1NtS2QM5L+FmqFVPsgr2RTc6xklRZm4pzsY0HPfZDK1dx8zO6DbX?=
 =?us-ascii?Q?WUqCTtNxCLOWwz4sYQ2+Z4jCF6vhenZ59DqYZOdQMTRoZxHIlflzTiOwTv9W?=
 =?us-ascii?Q?7svwRBE++dz1lVL+iJira+wE1qJKZRhjbMM/fq1uJLV0ydhPJbAQE65QJsgX?=
 =?us-ascii?Q?QllbmyeMG+c0+8GLDLFqRQR2o6U6JdlzYrywJ8d577/gsqxhCEREX5Qyh4nY?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6123cf3b-2a64-4de8-7605-08ddde028f54
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:54:33.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jisieFnMg4gou7V+8yGCUY3xvoyklMOU+lXGAKdEeeHwdFJR+narIL5OanMVamUi4+q8R1rPr/JU5rc7d8aDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 038e81b1617c57babe0381d3660234db5e84fb93 ("[PATCH v4 29/34] x86/amd_nb: Trickle down 'struct cpuinfo_x86' reference")
url: https://github.com/intel-lab-lkp/linux/commits/Ahmed-S-Darwish/x86-cpuid-Remove-transitional-asm-cpuid-h-header/20250815-152019
patch link: https://lore.kernel.org/all/20250815070227.19981-30-darwi@linutronix.de/
patch subject: [PATCH v4 29/34] x86/amd_nb: Trickle down 'struct cpuinfo_x86' reference

in testcase: boot

config: x86_64-randconfig-078-20250816
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | 2b4adf7848 | 038e81b161 |
+--------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508180405.3e28d0dd-lkp@intel.com


[    1.202568][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[ 1.202670][ T1] caller is init_amd_nbs (arch/x86/kernel/amd_nb.c:319) 
[    1.203596][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc1-00029-g038e81b1617c #1 PREEMPT(full)
[    1.203603][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.203606][    T1] Call Trace:
[    1.203608][    T1]  <TASK>
[ 1.203612][ T1] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 4)) 
[ 1.203619][ T1] check_preemption_disabled (lib/smp_processor_id.c:51) 
[ 1.203627][ T1] ? hpet_late_init (arch/x86/kernel/amd_nb.c:318) 
[ 1.203633][ T1] init_amd_nbs (arch/x86/kernel/amd_nb.c:319) 
[ 1.203638][ T1] ? hpet_late_init (arch/x86/kernel/amd_nb.c:318) 
[ 1.203644][ T1] ? hpet_late_init (arch/x86/kernel/amd_nb.c:318) 
[ 1.203648][ T1] do_one_initcall (init/main.c:1269) 
[ 1.203655][ T1] ? rdinit_setup (init/main.c:1315) 
[ 1.203661][ T1] ? rcu_is_watching (include/linux/context_tracking.h:128 kernel/rcu/tree.c:751) 
[ 1.203670][ T1] do_initcalls (init/main.c:1330 init/main.c:1347) 
[ 1.203677][ T1] kernel_init_freeable (init/main.c:1583) 
[ 1.203682][ T1] ? rest_init (init/main.c:1461) 
[ 1.203689][ T1] kernel_init (init/main.c:1471) 
[ 1.203696][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 1.203704][ T1] ? rest_init (init/main.c:1461) 
[ 1.203712][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[    1.203725][    T1]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508180405.3e28d0dd-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


