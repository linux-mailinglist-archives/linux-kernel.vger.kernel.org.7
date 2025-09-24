Return-Path: <linux-kernel+bounces-830132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE791B98E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6784A318C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F8285C84;
	Wed, 24 Sep 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSdN0GMC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13C28489A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702336; cv=fail; b=cGmeorXQiWhG6RLeoE+qPDOdmLdVLP2C+d7HNpD+sCdVkBsOfauSB7sktpv16NdZrvh/3tF6NMSmmjaX/fIfvlfDLy2jxcrDAXXpAofxo/4kz+M7BmEON0U/RKXWNc9KOs1bzM5Ss16sbpGQ5FZlMd6IeQCjQ/8ePzY5QDONxTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702336; c=relaxed/simple;
	bh=L1HgHcZsX2mCe0+rAkFYDqHligFI1zzITc8StF/3V28=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WpBcrvMp5TUwCJsCYQKlgfXprgTFP8jbMsbCfKRj5VjZNrKza+fVeg9X8TSWCQEubWapU4iTyMXNfA40Rq9BJHkRP8oh0fdmuCzyzGwVl5bw0AnmEYD7dHFHWlJIBcM1Y37Q5PgCG9So7d94AX7TcAoES4akZli78891U/ZKTxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSdN0GMC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758702334; x=1790238334;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L1HgHcZsX2mCe0+rAkFYDqHligFI1zzITc8StF/3V28=;
  b=XSdN0GMCqkhgLs5d9KHEb10iUFljIMTGfj5yBViR3UuGXRAsUtzBev4O
   JXFHNp9ifFlbFRubokFA5ToMVSjZs/dM3qaddBuLXOFhOLFQcAgRWZuv6
   iBOicOlg3c3gsXuWGP2yYM3nGD/RzGPlR3KBLXsDLqON9VnD1S1CK5Ej7
   KKzTkOI9/32qurlX2FKObVbNfW81ZhQRlMg+M1/tSy3xlXiK5iBqJWQqC
   ddLbIKcq9daA6E1l++PX6l727qS17txTDE6uwzuvm2wTfRZG94tuM1ZWO
   QvtQIbSqaqYgwoxALWDE5jyYEC3h1WcUEl3KEE3amiY1K0fM05bkpmcLb
   A==;
X-CSE-ConnectionGUID: x9QGF2UXRs22ikOr3ruEfg==
X-CSE-MsgGUID: qdW2VNNtQzuylbSjS3B+cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="83596542"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="83596542"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 01:25:33 -0700
X-CSE-ConnectionGUID: DX1fMFmwS7SdCYJ8fvAiKQ==
X-CSE-MsgGUID: AdFKk9IgTSaXEeVabw1+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177055107"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 01:25:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 01:25:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 01:25:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 01:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPeSN75643ZdYp3ZyS2n/vgz3aqtPyiQ+sD4/hZFSoSBUPLg3iNowU10z0frO4pj0UbAO8nBPsu37cgl1IELioS549heiFRpgjBi53E+gTYfZVulKRijMOMxFb3dCPSfwfTel93mqjwZvVW1dpHMRhcKFTMlvghRaIrz+01MjSXxvUHnTk1e7FypO8/xAsYasH0uVik0CMkaMGPh8fuF+9AcNimZHqukbVsZZb4R5ky4gzh4Ix9aJ3bRZz8EEGW6XRYX3w9GzqCnOkVkeMzvb2i//mVkDjDiHIvH6rzQ9XuYuD3VA43ndLopW/83no+bPawADSMn4AFvrVETa8X1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc7Xl1JWD8a5oWAaryFyexa+JjvT4K3Ddrh65DS1awM=;
 b=Wg4zLn9xRxr6A7N+gEF/crQB+/jxJ66FwlHO1SUOMSyklvMX9koCmAObskc6cCa1bChhuljuKQtwUVPmvcbEXyKfMe4siiENYkfthV0U5XgeJGVlxF86p9xq5cuoNn8wn5AnGwGvuMZEJBYPEZFy4ySlhsvDkeAAwBXSKqBN+WPF5kKE+YptPpS2Sr38VBxOCkp0sI05SKUmtS9qziJobzxQ9Guagopy7FtY6qofWNFfFcLTEaZ4mlDwfvMAioh7KLJl3yICM7A7XHOXceodJdO2L26W01/Hwgo9//4tJKJ5MChf5oZS9jyX0LYelpNHbKW7k9IdISu7Pw7KIwAg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.22; Wed, 24 Sep
 2025 08:25:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:25:28 +0000
Date: Wed, 24 Sep 2025 16:25:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Fernand Sieber <sieberf@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <peterz@infradead.org>,
	<bsegall@google.com>, <dietmar.eggemann@arm.com>, <dwmw@amazon.co.uk>,
	<graf@amazon.com>, <jschoenh@amazon.de>, <juri.lelli@redhat.com>,
	<mingo@redhat.com>, <sieberf@amazon.com>, <tanghui20@huawei.com>,
	<vincent.guittot@linaro.org>, <vineethr@linux.ibm.com>,
	<wangtao554@huawei.com>, <zhangqiao22@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3] sched/fair: Forfeit vruntime on yield
Message-ID: <202509241501.f14b210a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918150528.292620-1-sieberf@amazon.com>
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: af99ba85-3466-4f76-2c84-08ddfb43eb64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8qFmWVHeGlh0hH/17VRq3ECVHq644x78xhiwyWLzhEHdsF4Gt5A2rQIW57?=
 =?iso-8859-1?Q?7lSH1228y4Y/7U/N32tVSNJG1NW8qpQ7PF/gmYSlJXiIslvBTdshoOeoli?=
 =?iso-8859-1?Q?RCicmSSTvtAfTAbmVUzH1iIE0rmVXF2rHsRKhYI4AJEMTLnJqVQGB6huS3?=
 =?iso-8859-1?Q?+qIlALcVOGsRaWwqHAI5KP0++1TuOhEh0pXI54zVJW3xQ0Nlm1ADdR6T+2?=
 =?iso-8859-1?Q?7DVvZwKx89emVMZUuKWJq1oI77lBbjUT1j7NcKZ36MkarqgM5YfYcW9cPD?=
 =?iso-8859-1?Q?uZbdTB3Em+L+ndK1wDHP6SZ0B0pLTfHkhzIT4iomZIA8IbERgOeyl31r0X?=
 =?iso-8859-1?Q?PkLiRk/ZMvZKBcAUqseqxKV0NmqyBbKt1xUEWuV2sBA3TIaL3AEPqNEoPo?=
 =?iso-8859-1?Q?jSDWxv2dIgAr4/IAv++3lyrhU8ZpneMS48dsrZNoKFCunreCTjOJg4uf91?=
 =?iso-8859-1?Q?XdePnkSeR9qqhSLegil6sFuL39UAAOCs5SKXhXGXDNgMx0D+6Vujg5BEXA?=
 =?iso-8859-1?Q?dAGjV/0GNPSd6qxx6OwDBgPIZlvbN7EWhjUvYZNlcU7I5GEUojXXAfqIXs?=
 =?iso-8859-1?Q?e0OjPfbhkbUXgxb6uCbkbosK1M5wy8T+tMuKtsNlnyaSRODWuofzSsJX8o?=
 =?iso-8859-1?Q?QEKL4y76IH8l81qdxE4XiGVviSnKPmODQDi5qXiM3X9unZKomL0mzkAnmG?=
 =?iso-8859-1?Q?8rgkqJT7NoOMEtFIVcOxv8QV45LiepKH2aKcxzhVQn6DZdZWx25c5GvDo+?=
 =?iso-8859-1?Q?TYWVotzHKAjGmRvlPdkWQTYqDaxpMi6BTS631F2+l7+Iuc+XtrA3AlzNDH?=
 =?iso-8859-1?Q?An3Z/XKPrtgE5rBhKHsedL+iXbsLLuOy8Fr3DnitMLo/Am7SkLudJjosPY?=
 =?iso-8859-1?Q?Yr55gduEMGcOdcwUUd3+alWYho2kSCGuSnAMvxAtB7WiWhpV/5zbK1ZvwA?=
 =?iso-8859-1?Q?qF2b/qI7qOHF4U0CQK181VLa2bdnErVqtLSpltpM5AV6QbLKxLH4+KMBhy?=
 =?iso-8859-1?Q?A2GoZ4uIGRPXd/xRiX/gxz/ABaZHu89a0gkbkhjDvOaw4JCWL2XX8JUGLe?=
 =?iso-8859-1?Q?2eHTg03GsApP4R75SF1R459UmfJEiwrpWUy3gCKCCU0KQNJdB77p+tCJFQ?=
 =?iso-8859-1?Q?7k1BR12Eo3TeJ0hRcFIQH1QT5ALN5fe+KuOQA9YI6U276JUKsesJM9ztiN?=
 =?iso-8859-1?Q?VvvA0aVsuPXYia6A7ue9GhOnLVMfaGj33lZCcBnSyklfI17AkKLpzPe99w?=
 =?iso-8859-1?Q?S5q5jiX5BVSBXuGunKIPWgFiZzsQIbqP4+U+PFn0TwtZzSCyVmvfcvFtiP?=
 =?iso-8859-1?Q?hBK0s/8wI5rTCNkXUdNoW6j5mGT7I5dgjXDnq9rsWEkqLG9RsmCYSak+i5?=
 =?iso-8859-1?Q?zCAqoPBpiFXGm1+hGEisJk2+6UGgYg3GPhhnF/XGlBZCINHXKEenkGJwlT?=
 =?iso-8859-1?Q?hSV2in27+B+Dsj5H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LsSEo60QcfKmMWSkmQpU4OCqmoVel5fDX9PUJOCJfxHW0LTaDi4405eXrR?=
 =?iso-8859-1?Q?gDbAfydK5ZbOQV93xsjEoqk62hcSYfCa7oKRIPoDkaEEu/wl4laq4Nhlj6?=
 =?iso-8859-1?Q?7gvUA9d/NzWoAyKGHbA5Wvbf0eS5tPcoe6wy9C9ZPiwa7CivC0tEbxy6+8?=
 =?iso-8859-1?Q?pNi/wCTYtdd5MEvSIyQgJeNPWRDhUIEHFktb3HuaCAcvoz2XOoIxJqQk7A?=
 =?iso-8859-1?Q?+aNHfflLvSWQRx22wDkPMJPPn6B9kcNFAQTutbT8Th8oS/JRFBgSVBDRvO?=
 =?iso-8859-1?Q?MvIWY7nUVU+zEB4eCy+NTmfg9fVqBYo+1j6LjbitOAVhtosztAOpKAIzgV?=
 =?iso-8859-1?Q?BV/fSwzcn1WT8KAhAZX1wxdMC4yFDlbNi46ExRp393WyEXJeOwFnc43MXl?=
 =?iso-8859-1?Q?XRUtW7f8mwaUJrV49LyldY4FnNnLdJO2wGvHTLrUrF1NQ+tIZ2Yukgdjgf?=
 =?iso-8859-1?Q?7hs7L32CluzWmAQK/rQ4xSDKUtcuf8Qb19DCaQSlVGJyOr577is3UC9zY3?=
 =?iso-8859-1?Q?buSrSYz641rcj2PuJ1/fdUQ/kOrd5ALHy7yActuG/60PWTyyunuvfJCTNV?=
 =?iso-8859-1?Q?65hlQHBa5GsUmM2aOdG61vd+uVxNyeyvFA+PHxsroVslIDHWH6aJpSdLkd?=
 =?iso-8859-1?Q?QXOsZ4ibljz+LTGPzUdjnSM3rU52ikOAWbV/51HqtgQXYwyX6zn1yBq8QP?=
 =?iso-8859-1?Q?OGiOYUlXgLHgFpY0nW1C01qMXzWwLSBC/OWMDSGGXxjYVW60L1IvEzqzQD?=
 =?iso-8859-1?Q?TMxqfmpg6I5ZzNkmn5x0Mr8U+N7cuZHrkJ7Pv8U2GnbdOLTx0ooe2PcWU+?=
 =?iso-8859-1?Q?XMHy60De4V6cHrLfmpxLhu+nroIsx8kYHtXjL3Qm1BsYiNnKCA9Ize+oEt?=
 =?iso-8859-1?Q?ULYy1WqP35xNbAH3qQ5lsQwqNVGp+axRrNGnU41hLa1vVnwLfLhVXbrKRu?=
 =?iso-8859-1?Q?Ckih4QrAukLTJejtn0pJelDrIuD7q5t/9VL38uNb0BR51zaoe12JpkQrO2?=
 =?iso-8859-1?Q?urwEKwn14ShNTuZWhuCBg25Nvbfw961jk/T/6WosE2l+iYFTIf+toGJVOq?=
 =?iso-8859-1?Q?phAD/5EKOrYFf1q8kJ+B4wJMfn8S7X3KjPFJ2dbxVDV/Lhfy3lm1aY4YDG?=
 =?iso-8859-1?Q?ytKsnb1BcOq6N3WapbtFANKxtyG1tdiDeubXNoWWXpdWf9qfmH3fEOXwlZ?=
 =?iso-8859-1?Q?n+sG9jhGaU4rC5bYIAobcqZjWIKcDbcqQq3CiSz7To/6f7uW+of+1twqYR?=
 =?iso-8859-1?Q?OGaMLfGZImVaZqSF1xe52Cwco/xCdwnjtjDVZeb/3n1q7qZRcXSM+oP54z?=
 =?iso-8859-1?Q?cClKiWmEAjlQBREuklRKAWwFHc6sDh0LWxyayBjMNWZwEYzkxzXnu0XLD9?=
 =?iso-8859-1?Q?ot6nmQu8Loall38BbgcTwuLoolRazzZD0F9fL7rQaGsascEn4HauF7J5ZV?=
 =?iso-8859-1?Q?/jkdHeNF5QYG+BbxNtYD5fxrvkHh7IC6yb9qh77l3ab2pyFQ/uUYR8mNNq?=
 =?iso-8859-1?Q?4CI8/kaZ3XEuw/P1N9uFu6QdBYwPNsu+Hkcay0sYu+luqbrCZvpg9hLUSU?=
 =?iso-8859-1?Q?1aKsrt7lBYA5uXnFpZGe3AcBQP+V7DknW449SBJjF/UIiQwo6MY3uXCzpo?=
 =?iso-8859-1?Q?TDzMkN6EPVi1q+Y4jkgy2PDWCIKMdThG5o6dwW/qFR2kyCKuFuJ3OORA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af99ba85-3466-4f76-2c84-08ddfb43eb64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:25:28.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciCABEYp3DFwkUbkH1Y6berAD4Uuxsqu97jMWt06ng+1zrNuP+2nM72C1m4eWmKBDu4I9io7DedszSVs5GwyxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 55.9% improvement of stress-ng.wait.ops_per_sec on:


commit: 15bf8c7b35e31295b26241425c0a61102e92109f ("[PATCH v3] sched/fair: Forfeit vruntime on yield")
url: https://github.com/intel-lab-lkp/linux/commits/Fernand-Sieber/sched-fair-Forfeit-vruntime-on-yield/20250918-231320
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 0d4eaf8caf8cd633b23e949e2996b420052c2d45
patch link: https://lore.kernel.org/all/20250918150528.292620-1-sieberf@amazon.com/
patch subject: [PATCH v3] sched/fair: Forfeit vruntime on yield

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: wait
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.alarm.ops_per_sec 1.3% improvement |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory        |
| test parameters  | cpufreq_governor=performance                            |
|                  | nr_threads=100%                                         |
|                  | test=alarm                                              |
|                  | testtime=60s                                            |
+------------------+---------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250924/202509241501.f14b210a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/wait/stress-ng/60s

commit: 
  0d4eaf8caf ("sched/fair: Do not balance task to a throttled cfs_rq")
  15bf8c7b35 ("sched/fair: Forfeit vruntime on yield")

0d4eaf8caf8cd633 15bf8c7b35e31295b26241425c0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  20935372 ± 13%     -74.1%    5416590 ± 38%  cpuidle..usage
      0.22 ±  6%      -0.1        0.15 ±  6%  mpstat.cpu.all.irq%
      1.56 ±  3%      +0.6        2.16 ±  4%  mpstat.cpu.all.usr%
   2928651 ± 48%     +63.3%    4781087 ±  7%  numa-numastat.node1.local_node
   2986407 ± 47%     +63.0%    4867647 ±  8%  numa-numastat.node1.numa_hit
  65592344 ± 22%    +408.5%  3.335e+08 ±  6%  stress-ng.time.involuntary_context_switches
     64507 ±  3%     -10.6%      57643 ±  5%  stress-ng.time.minor_page_faults
    268.43           +58.0%     424.24        stress-ng.time.user_time
  94660203 ±  3%     +32.0%   1.25e+08        stress-ng.time.voluntary_context_switches
   8733656 ±  3%     +55.9%   13619248        stress-ng.wait.ops
    145711 ±  3%     +55.9%     227211        stress-ng.wait.ops_per_sec
   9901871 ± 23%     +33.6%   13230903 ±  9%  meminfo.Active
   9901855 ± 23%     +33.6%   13230887 ±  9%  meminfo.Active(anon)
  12749041 ± 18%     +26.5%   16122685 ±  7%  meminfo.Cached
  14843475 ± 15%     +22.4%   18175107 ±  5%  meminfo.Committed_AS
  16718698 ± 13%     +19.8%   20027386 ±  5%  meminfo.Memused
   9098551 ± 25%     +37.1%   12472304 ±  9%  meminfo.Shmem
  16772967 ± 13%     +19.8%   20096231 ±  6%  meminfo.max_used_kB
   7828333 ± 51%     +66.6%   13041791 ±  9%  numa-meminfo.node1.Active
   7828325 ± 51%     +66.6%   13041784 ±  9%  numa-meminfo.node1.Active(anon)
   7314210 ± 52%     +85.0%   13533714 ± 10%  numa-meminfo.node1.FilePages
     61743 ± 26%     +43.3%      88498 ± 20%  numa-meminfo.node1.KReclaimable
   9385294 ± 42%     +66.0%   15578695 ±  9%  numa-meminfo.node1.MemUsed
     61743 ± 26%     +43.3%      88498 ± 20%  numa-meminfo.node1.SReclaimable
   7219596 ± 53%     +72.1%   12426234 ±  9%  numa-meminfo.node1.Shmem
   1958162 ± 51%     +66.6%    3262251 ±  9%  numa-vmstat.node1.nr_active_anon
   1829587 ± 52%     +85.0%    3385199 ± 10%  numa-vmstat.node1.nr_file_pages
   1805933 ± 53%     +72.1%    3108329 ±  9%  numa-vmstat.node1.nr_shmem
     15439 ± 26%     +43.4%      22139 ± 20%  numa-vmstat.node1.nr_slab_reclaimable
   1958158 ± 51%     +66.6%    3262247 ±  9%  numa-vmstat.node1.nr_zone_active_anon
   2985336 ± 47%     +63.0%    4867285 ±  8%  numa-vmstat.node1.numa_hit
   2927581 ± 48%     +63.3%    4780725 ±  7%  numa-vmstat.node1.numa_local
   2475878 ± 23%     +33.7%    3310125 ±  9%  proc-vmstat.nr_active_anon
    201955 ±  2%      -5.5%     190887 ±  3%  proc-vmstat.nr_anon_pages
   3187672 ± 18%     +26.5%    4033035 ±  7%  proc-vmstat.nr_file_pages
   2275048 ± 25%     +37.2%    3120439 ±  9%  proc-vmstat.nr_shmem
     43269 ±  3%      +4.5%      45201        proc-vmstat.nr_slab_reclaimable
   2475878 ± 23%     +33.7%    3310125 ±  9%  proc-vmstat.nr_zone_active_anon
   4045331 ± 20%     +29.0%    5218368 ±  7%  proc-vmstat.numa_hit
   3847426 ± 21%     +30.5%    5020327 ±  7%  proc-vmstat.numa_local
   4094249 ± 19%     +28.8%    5274030 ±  7%  proc-vmstat.pgalloc_normal
   9011996 ±  5%     +23.4%   11121508 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
   3236082 ±  2%     +19.6%    3869616        sched_debug.cfs_rq:/.avg_vruntime.min
   1260971 ±  4%     +25.1%    1577635 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.53 ±  5%      -8.9%       0.49 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.54 ±  4%      -8.7%       0.49 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
   9011996 ±  5%     +23.4%   11121508 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
   3236082 ±  2%     +19.6%    3869616        sched_debug.cfs_rq:/.min_vruntime.min
   1260972 ±  4%     +25.1%    1577635 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1261 ±  4%     -16.4%       1054 ±  6%  sched_debug.cfs_rq:/.util_avg.max
    170.04 ±  4%     -30.0%     119.10 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
    390.34 ±  2%     +34.0%     523.00 ±  2%  sched_debug.cfs_rq:/.util_est.avg
    219.06 ±  5%     +22.5%     268.29 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    765966 ±  3%     -13.1%     665650 ±  3%  sched_debug.cpu.max_idle_balance_cost.avg
    296999 ±  5%     -22.6%     229736 ±  5%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.53 ±  6%     -10.2%       0.48 ±  3%  sched_debug.cpu.nr_running.stddev
    467856 ±  5%    +154.2%    1189068 ±  4%  sched_debug.cpu.nr_switches.avg
   1091334 ± 35%    +458.8%    6098488 ± 11%  sched_debug.cpu.nr_switches.max
    156457 ± 39%    +579.7%    1063429 ± 12%  sched_debug.cpu.nr_switches.stddev
 1.522e+10 ±  2%     +33.0%  2.025e+10 ±  4%  perf-stat.i.branch-instructions
  26461017 ±  8%     +25.3%   33152871 ±  4%  perf-stat.i.branch-misses
  80419215 ±  6%     +22.5%   98514949        perf-stat.i.cache-references
   2950621 ±  6%    +154.2%    7499768 ±  4%  perf-stat.i.context-switches
      8.86           -23.8%       6.75        perf-stat.i.cpi
      4890 ± 16%     -56.2%       2140 ± 15%  perf-stat.i.cpu-migrations
     44725 ±  7%     -16.0%      37555 ±  3%  perf-stat.i.cycles-between-cache-misses
 7.212e+10 ±  2%     +31.4%   9.48e+10 ±  4%  perf-stat.i.instructions
      0.12 ±  3%     +32.7%       0.17 ±  7%  perf-stat.i.ipc
     15.37 ±  6%    +154.2%      39.06 ±  4%  perf-stat.i.metric.K/sec
      8.17           -23.4%       6.26        perf-stat.overall.cpi
      0.12           +30.5%       0.16        perf-stat.overall.ipc
 1.498e+10 ±  2%     +33.0%  1.993e+10 ±  4%  perf-stat.ps.branch-instructions
  26034509 ±  8%     +25.3%   32622824 ±  4%  perf-stat.ps.branch-misses
  79145687 ±  6%     +22.5%   96950950        perf-stat.ps.cache-references
   2903516 ±  6%    +154.2%    7379460 ±  4%  perf-stat.ps.context-switches
      4802 ± 16%     -56.3%       2099 ± 15%  perf-stat.ps.cpu-migrations
 7.098e+10 ±  2%     +31.4%   9.33e+10 ±  4%  perf-stat.ps.instructions
  4.42e+12           +30.9%  5.787e+12        perf-stat.total.instructions


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-skl-fpga01/alarm/stress-ng/60s

commit: 
  0d4eaf8caf ("sched/fair: Do not balance task to a throttled cfs_rq")
  15bf8c7b35 ("sched/fair: Forfeit vruntime on yield")

0d4eaf8caf8cd633 15bf8c7b35e31295b26241425c0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     13051 ± 26%     +40.8%      18378 ±  6%  numa-meminfo.node1.PageTables
    230411 ± 15%     -24.0%     175131 ± 19%  numa-numastat.node0.local_node
    122.83 ± 10%     +24.6%     153.00 ±  9%  sched_debug.cfs_rq:/.runnable_avg.min
    229700 ± 15%     -24.0%     174608 ± 19%  numa-vmstat.node0.numa_local
      3264 ± 26%     +40.4%       4584 ±  6%  numa-vmstat.node1.nr_page_table_pages
     34.64            -0.5       34.15        turbostat.C1%
      1.25 ±  2%      -0.3        0.92 ±  6%  turbostat.C1E%
 1.227e+08            +1.3%  1.243e+08        stress-ng.alarm.ops
   2044889            +1.3%    2071190        stress-ng.alarm.ops_per_sec
  17839864           +33.4%   23790385        stress-ng.time.involuntary_context_switches
      5045            +1.6%       5127        stress-ng.time.percent_of_cpu_this_job_got
      1938            +1.8%       1972        stress-ng.time.system_time
      1094            +1.4%       1109        stress-ng.time.user_time
 1.402e+10            +1.2%  1.419e+10        perf-stat.i.branch-instructions
 9.466e+08            +2.1%  9.661e+08        perf-stat.i.cache-references
   6720093            +2.3%    6874753        perf-stat.i.context-switches
  2.01e+11            +1.4%  2.038e+11        perf-stat.i.cpu-cycles
   2173629            +3.4%    2247122        perf-stat.i.cpu-migrations
 6.961e+10            +1.2%  7.047e+10        perf-stat.i.instructions
     85.51            +2.6%      87.75        perf-stat.i.metric.K/sec
 1.373e+10            +1.2%   1.39e+10        perf-stat.ps.branch-instructions
 9.333e+08            +2.1%   9.53e+08        perf-stat.ps.cache-references
   6626920            +2.3%    6780505        perf-stat.ps.context-switches
 1.979e+11            +1.4%  2.007e+11        perf-stat.ps.cpu-cycles
   2146232            +3.4%    2219100        perf-stat.ps.cpu-migrations
  6.82e+10            +1.2%  6.905e+10        perf-stat.ps.instructions
     16.99            -0.7       16.30        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.63            -0.4        0.25 ±100%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.do_nanosleep
      0.76 ± 15%      -0.3        0.43 ± 73%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     33.81            -0.3       33.51        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     32.55            -0.3       32.25        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     32.48            -0.3       32.19        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.06            -0.1        0.93        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      5.84            -0.1        5.74        perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      5.66            -0.1        5.56        perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      8.87            -0.1        8.79        perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.02            -0.1        7.94        perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      8.38            -0.1        8.31        perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.42            -0.1        8.35        perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92            +0.0        1.95        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule
      1.40            +0.0        1.44        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending
      1.18            +0.0        1.22        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      0.68            +0.0        0.72        perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.complete_signal
      2.48            +0.0        2.52        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      2.10            +0.0        2.14        perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info_type
      2.38            +0.0        2.42        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.do_nanosleep
      0.99            +0.0        1.03        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.complete_signal.__send_signal_locked
      2.32            +0.0        2.36        perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info_type.kill_something_info
      2.24            +0.0        2.28        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      3.46            +0.0        3.50        perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.kill_pid_info_type.kill_something_info.__x64_sys_kill
      1.79            +0.0        1.84        perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      1.73            +0.1        1.78        perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.06            +0.1        1.11        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info
      2.36            +0.1        2.41        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
      4.26            +0.1        4.32        perf-profile.calltrace.cycles-pp.kill_pid_info_type.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.72            +0.1        6.78        perf-profile.calltrace.cycles-pp.alarm
      0.73            +0.1        0.80        perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule.schedule
      2.86            +0.1        2.92        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      3.26            +0.1        3.33        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.72            +0.1        3.80        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.85            +0.1        0.94        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.__x64_sys_sched_yield
      0.88            +0.1        0.97        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      2.02            +0.1        2.15        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.54            +0.1        1.67        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57            +0.1        1.71        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.88            +0.2        3.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.34            +0.2        2.51        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      5.50            +0.2        5.68        perf-profile.calltrace.cycles-pp.__sched_yield
      0.52            +0.5        1.04        perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
     34.13            -0.3       33.82        perf-profile.children.cycles-pp.cpuidle_idle_call
     32.84            -0.3       32.54        perf-profile.children.cycles-pp.cpuidle_enter
     32.79            -0.3       32.50        perf-profile.children.cycles-pp.cpuidle_enter_state
     13.10            -0.3       12.81        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.78 ± 13%      -0.2        0.58 ± 20%  perf-profile.children.cycles-pp.intel_idle
      8.88            -0.1        8.80        perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      8.05            -0.1        7.97        perf-profile.children.cycles-pp.do_nanosleep
      8.39            -0.1        8.31        perf-profile.children.cycles-pp.hrtimer_nanosleep
      8.46            -0.1        8.39        perf-profile.children.cycles-pp.common_nsleep
      1.22            -0.1        1.17        perf-profile.children.cycles-pp.pick_task_fair
      3.10            -0.0        3.06        perf-profile.children.cycles-pp.__pick_next_task
      2.60            -0.0        2.56        perf-profile.children.cycles-pp.pick_next_task_fair
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sigprocmask
      0.91            +0.0        0.94        perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.85            +0.0        1.89        perf-profile.children.cycles-pp.enqueue_entity
      2.41            +0.0        2.45        perf-profile.children.cycles-pp.enqueue_task
      2.39            +0.0        2.43        perf-profile.children.cycles-pp.dequeue_task_fair
      2.48            +0.0        2.52        perf-profile.children.cycles-pp.try_to_block_task
      1.42            +0.0        1.46        perf-profile.children.cycles-pp.available_idle_cpu
      2.32            +0.0        2.37        perf-profile.children.cycles-pp.complete_signal
      2.32            +0.0        2.36        perf-profile.children.cycles-pp.enqueue_task_fair
      3.46            +0.0        3.51        perf-profile.children.cycles-pp.__send_signal_locked
      4.27            +0.1        4.32        perf-profile.children.cycles-pp.kill_pid_info_type
      4.03            +0.1        4.08        perf-profile.children.cycles-pp.do_send_sig_info
      6.84            +0.1        6.90        perf-profile.children.cycles-pp.alarm
      3.09            +0.1        3.15        perf-profile.children.cycles-pp.ttwu_do_activate
      1.95            +0.1        2.02        perf-profile.children.cycles-pp.select_idle_core
      2.23            +0.1        2.30        perf-profile.children.cycles-pp.select_idle_cpu
      3.12            +0.1        3.19        perf-profile.children.cycles-pp.sched_ttwu_pending
      3.58            +0.1        3.65        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.62            +0.1        2.70        perf-profile.children.cycles-pp.select_idle_sibling
      6.14            +0.1        6.22        perf-profile.children.cycles-pp.try_to_wake_up
      3.78            +0.1        3.86        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.05            +0.1        3.14        perf-profile.children.cycles-pp.select_task_rq_fair
      3.17            +0.1        3.26        perf-profile.children.cycles-pp.select_task_rq
      2.03            +0.1        2.17        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      5.56            +0.2        5.75        perf-profile.children.cycles-pp.__sched_yield
      0.78 ± 13%      -0.2        0.58 ± 20%  perf-profile.self.cycles-pp.intel_idle
      0.22 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.80            +0.0        0.83        perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.40            +0.0        1.45        perf-profile.self.cycles-pp.available_idle_cpu





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


