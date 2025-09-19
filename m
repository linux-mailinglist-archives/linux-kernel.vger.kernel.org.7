Return-Path: <linux-kernel+bounces-824642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B7B89BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F655A2992
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDB31281B;
	Fri, 19 Sep 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tozoa6Kc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14368312805
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290222; cv=fail; b=X+uLiUjd/Fk0xMCggZ/StNQUpbHjWiGtnyaA/NyOUL10E3VzVtd9LCzOaWnkKr2l6eG1Un4dZ3+PG+TS6FcpkKBMoODQBkP+i/Z3mMC86tnEWTw1tG6gDvJipShwZFvLokRUTmFZnG/An4QTml801nETcHQqpeVgGUnG/N2ib70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290222; c=relaxed/simple;
	bh=ieTfqJvD4pzIZ+IwryfkeNBzgfmKm/97V6uUtsk1sY8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hoEMX/l9fE/zryE68A/5XxMKFWomlm/yOMwq0lIlJ8x+PhzKadtxPDLSwZN1M434zFuPJTU7JNwY7f39dLCFHOT/QpM9wDOR28SNRnZixk3O6XWUdYGNjlIxZM8eJQuvTom3MLVsl7GdVk4dkG6OzM06SZ/xdZtfAObX1IfoNdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tozoa6Kc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758290220; x=1789826220;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ieTfqJvD4pzIZ+IwryfkeNBzgfmKm/97V6uUtsk1sY8=;
  b=Tozoa6KcGpE7F4fKtdfYc2xl9Aj/9cP34JPsV3vSWwjApiGCZeADHE32
   /eYSeaPud4jnKsmXMSIAlCbEYyCvAc5qi4pl84KNMDqMizN9MeJCevYy1
   Qa83SpOKsDRG9DYf2RHc/1X5ZFIlYcz9vnVYBHvDtBWsSSTeGR0jE40wC
   WJI5MkEArIB1uecgBHKS2/A760NX5s7XXmjuKreeFLJukAj+3Gj58CDZN
   RS0ARZnSNRGQTZjUxs0LuWsqzMSI3AoqFj4kcQV/p9A10hV4syrYyAWmp
   aMeG9IV8A6I+sCDJ8UY6jHvwzX1CUfuYSo7n1qIxRjYb8Ug9GgKy0w+VA
   w==;
X-CSE-ConnectionGUID: IgrvRw39TdyEfF/6L9Wk9A==
X-CSE-MsgGUID: 0GzHmqfIRKSk9C2PvE+foA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71317162"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="xz'341?scan'341,208,341";a="71317162"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 06:56:58 -0700
X-CSE-ConnectionGUID: Vi2+hy4LQFyWdimLckeJHg==
X-CSE-MsgGUID: 7rHnSYJ4QjCdT8MFpZjOLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="xz'341?scan'341,208,341";a="176651107"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 06:56:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:56:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 06:56:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:56:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2qdeApRKZl2HxoQytKE8AD0yL7jEQsdZQdny96Z5MxwoM3TvcAZARJDdhjfc1K6bFeGwc0IqExQpc0hIP0aSfj51SJY63v82K1+OF+ihZMVN1Tlfh1xR4ffmoqwnUnb4BkWb8xoBpbpYkoow2eWj7J0kVF0j18OvOfCZs/zqmYF14lYgjykyOd+Zv7xRZGjZFzQEfO25bO+xHlUNAVzMbQvlz4Jd17BROsYNRGoEp/b73u+cIuqyU7CkWfJKT4IQkzmXk0Oh6hMKdrGNw0Eh6ICF4ia7sX8IOMUtvXSjEi6yYA2rDds/yszaWW56j7U1hkZ1ZQgl1WvdGa7jV8Tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VExfJtgFiLBBNkSe63q6dwJo5muqXKfNgggO/a/rqL8=;
 b=Gcj7jxo3htIvvayf346BlvE8GHoN+eud/2tuFe0eKDWBaMBwcd9yF1TTBQjaJMMjRmP0hW1az+H6YrzHrbfHlz77+Ijyg+Xc7PjULB4dwkwygVBslKXL1UsqtmS96FfyetYgiW9SrQwjVP1bkxXzDh61ESjOXeYoKJuFJpFZ1KPgqxYJREOqCnrUwU4EOZf4wdC8QNoK5Ui1HSs/sCQNWnihcypN0WUspt/lEIZjRhYiqojeXp0nOCXbij5al99jx0DO94UHYOWX68BLyJjhpTBpV2w7vJDA3/AY9926MUdTilAYRgK4P6cPeNKTGbglgotV/nCz0Gbyx/X4bgq9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 13:56:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 13:56:47 +0000
Date: Fri, 19 Sep 2025 21:56:38 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yury Norov <yury.norov@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, <oliver.sang@intel.com>
Subject: Re: [PATCH 3/3] group_cpus: optimize grp_spread_init_one()
Message-ID: <202509192101.5d4e0282-lkp@intel.com>
Content-Type: multipart/mixed; boundary="zvtqtaYu8iHNx3qG"
Content-Disposition: inline
In-Reply-To: <20250910210850.404834-4-yury.norov@gmail.com>
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 73874019-6224-407e-ef7f-08ddf7845f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4053099003|4013099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1bVlkwWAlrT+SvnC0R9nJHq3XjiI2NKHp7Z3FGbp2hOFIhGsoCZVJ077lrrc?=
 =?us-ascii?Q?amAOqxLu8s6HQxKzyOaehycQjqR5s4wxclLcgfrlnHLGxTa+1cYsGwkNqdNU?=
 =?us-ascii?Q?SGil+/yg0V5jnI0LqnTNVUkX9PEvZISHkLt1Yk3pMYSabf4tr9pUj+uUj6SV?=
 =?us-ascii?Q?QEzoIzuj7qU4K7D29FnBlKBzuBPO1bYGRzr6PLw2q+6ddpjhxuml7rIdO6bD?=
 =?us-ascii?Q?QbTIebMDVBgXyQbFfXSc9uB2fvp27TocprHSOPavy1Ld4woUvuqsEecVA2wI?=
 =?us-ascii?Q?H6/FI6SgKSe0Q+68NfeSXHfjzfb1URK6bePFq2uer3+mqBJ+QiV3dClTUeV0?=
 =?us-ascii?Q?zdNcBlM0o0G5H+T6tLgpQZmnlzfNZEO2Tk1B3idRwt7ljgXjVICUsdTO+7Ln?=
 =?us-ascii?Q?xVtFyPZ5zIV4Tu9Y5xdOor62JK2XRka5iaDivkmEk76910X9Ei9ifZsNILEO?=
 =?us-ascii?Q?v6EQsTfsIHgTgmW3S2AH/gCSeFm/b8m4ud6V8zPXsH2QQRRpCtX5/2ap8uQz?=
 =?us-ascii?Q?9IeZabmVdUZRcs9W6u+0Kiwm8WrsIwycXjfW+GsOzli8ENVGsn0jE8JonuYB?=
 =?us-ascii?Q?i2wLCea2V0JduX7YmmBt6zLSvxnDdxjCBSrZPx2QD6wWlvVr9nAhUnR13+eD?=
 =?us-ascii?Q?LqLtgQMxDD4hFzmcDA9ChxmNhRngy0yBzHo3WkF/15W7chEwMIdJACHHzssf?=
 =?us-ascii?Q?aN8VTfkwXcuiwCrmsZsFsr4zk4RoG4uQym/A+as156Ja1nevwHJQJ6bBZPM9?=
 =?us-ascii?Q?1rx+82aTOjaW/j6eltJtamkbqiNYdgHZsqFVH6T33gkIgGHc1WiV2E80DAPN?=
 =?us-ascii?Q?Ph7pABfepQXX0bgoRKqWvEvSKr0neLkWrSwTEopioEGlNGTG4Okqbn/OPCDJ?=
 =?us-ascii?Q?2OpN+kk96EgoCoLlIyTP6lAKVK3DfYHikSA+6bQSZNbF0fHSuuafr9rY2x6v?=
 =?us-ascii?Q?GosKPy7StK0zrRSQkfc2P9gLUxUr2njwvSnFFRUP7CPERqDGD+r3SrGjz/3c?=
 =?us-ascii?Q?4OtetSF6RGCskKuDdWcQmUWQv7qpnkxDyR1mXcM8aB6gpkaD24Q7tv5SxNLj?=
 =?us-ascii?Q?wB7ghNztQIMnYDiNID7+9WA8jpyr7lC1jFKe6NP/S55FKkzm4Rj8+lKXj/18?=
 =?us-ascii?Q?CwnZyMpfWOFF74YiwGkQTru8+ZveLh92YCFu2F3oWri2Y2j7khCk0buSQmcV?=
 =?us-ascii?Q?/FoALolQdRtJjEvsmvJFoGG++9O302PB6jCJo1n1HjQaGFa8Dmi/oBegN31k?=
 =?us-ascii?Q?GW0tOg7ypnygUvZ0ogLpxz6BFPw6qUx1qce16RCKdxXfW8i3z8R/fF0icejO?=
 =?us-ascii?Q?McOG2pryfkdb3wO8K1aExvYawyq4AUQrr+kZm2J1uAA5YmVKGts0x3tqAOTR?=
 =?us-ascii?Q?SdhKqKeN3Px/69sJNvDQ/P00HhXz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4053099003)(4013099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOWyTBM+7e/OO0n+Y2UzBaP1dyTZvJQV9ci7tqT5ybMXfazWV3Oe0FqkAx8a?=
 =?us-ascii?Q?P06d9qWsTuQfwCCBMjT38JX3AI3/cCrDdvDQ+3jUKGa1+NrHcfER7dWlOOg5?=
 =?us-ascii?Q?503kSiaguyPm8ZV5KXzysZfNblSdrViasQOjt1LSnsAvU77JYcaXPgVQ1e6x?=
 =?us-ascii?Q?f4KZd62ghQ8wIGGHsHqNcLuylOG7G2t4z5Et3a4VoZuBX7dev7wf3m8pCPTc?=
 =?us-ascii?Q?CQrlUizXKxY3saexqWEpSE6pDu3IxBNWv0+bUbX85nWQTnhZFNiHokwSzyUM?=
 =?us-ascii?Q?AB6G1hWYCedo0FRzmcHngBNaSjcpV/OZAunptt3epUNgzNwzclCOVKkAKBuk?=
 =?us-ascii?Q?B55Z90Bl8npI3bVJ/duKTEV9pKn7UU2DV6f6fSgJe3uNsCaIqapJswmBobRd?=
 =?us-ascii?Q?156JCiWiFrym2LB9eqxENv0V95u3WfkIDUGETGsgTSkCNynziBpvNzjQhySi?=
 =?us-ascii?Q?Jf3R7Eigb8u5gVUk1SsLLlt7vvfzKlh4BH5jjVc2/H+noQpiv5sYtAOu57J1?=
 =?us-ascii?Q?lzFNg9fc2aNqmL+rXMGmVqVOLqUhM4yeRyN9H/dQrPUy5JfLJzDRyKv2hg5H?=
 =?us-ascii?Q?W0/TwiE33oD/Vo3deAaOSBSp9xvuS+bONi8WsnelvClZjII2OwBDpa4G1y9Q?=
 =?us-ascii?Q?67/LmRyuggqwZnI9PZU7ilv2UeOn+pib/GxwY47f7Q3AEgws7oRa2LjY8YS4?=
 =?us-ascii?Q?3C0YtHN0kXQIZinVZAtmz/gOZki7bCggIAj6rUKayWDcJ6C0C9n9KdctQ7sV?=
 =?us-ascii?Q?l9CaaewDUYcfW6KhrH1FNx+MDFz1uzEYyr0CdsjjyVggSO9YGsJZHp1mX5L6?=
 =?us-ascii?Q?uuIcxf1IkarRW5So8gxpnyDy8NHgaKGdaqgLPdV8T84V2bggK9xGXQ1u4/aU?=
 =?us-ascii?Q?IxCz3sTkBiQwwMj1YnrQe9C+nT+e3ma4OhUIdOLf2YlO7Vdz2HlgH9UfLPcT?=
 =?us-ascii?Q?6CXsuAnyUX3a/+bE0f1DqK1PtMU/qlq4SsC/2QxUKRU+IeBVXMP8uyjAY9I7?=
 =?us-ascii?Q?7ZgSMmwN6n8vJMAFT4yIqmSYY4JXUtPVDz+1dt44FQE9i6BxQqPgW6Z+GU5e?=
 =?us-ascii?Q?vw3AiQjlRdoM5tUxsQvkxHCppF+d9c49BFVJrm2Q9Wr1Juy1dJXtKJUQ2Kxj?=
 =?us-ascii?Q?gz5gwWaft74J7lBFxZ95lbphy1/aiMBe728EUnU2ktZ5AM46ibl/V0iIUiX/?=
 =?us-ascii?Q?NNBEPgIfGpT9QtvK6SGK0cv9UyElEibAx+N8QURtFgGKQ2fYKk+HBFAXfsvd?=
 =?us-ascii?Q?cRZEmHynDr6f9ByjQN8g7fuM0laMgr0TRM92wvsxCSRpx1w+P5NcgIeA4kRg?=
 =?us-ascii?Q?Xwg5OM6iesIEiqTArhm0/944USV4XvzX1Cd+szEovAaRf3HVtjGr0nfWzop2?=
 =?us-ascii?Q?nHb6LiEcqGqCW6aqPRnCkvwjAMuFEK5fg1inB5EiF9hkqdfkW3isEZRUwf1O?=
 =?us-ascii?Q?tJLkxRmMWJzZIJ4UFuqFE+E4v8ngTbV4AoY85utbVuSyjcbNRqQ6yDnUNIrN?=
 =?us-ascii?Q?GmReJxkPBjAEBA+jmpFy177CHmKBTBS18R/R7+CUXAQpwnbU0LusL5jmYN0T?=
 =?us-ascii?Q?tGbgFaelEiDCboxKEBIIk+Wfh3Ozqho6HfhMO+lXm+qRe0VUBrutJ5c1lwCz?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73874019-6224-407e-ef7f-08ddf7845f7c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:56:46.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+1THk7pwNwWW60iPyRuI8JYdtXKKsBDuguX/0lESG8+N+iv6dV4VFsxKBbpkDb0S5LS5iv0djcez3ZOE5bytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com

--zvtqtaYu8iHNx3qG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 5df2998b7baa3fd4cb66272d1ea5625573b4a63f ("[PATCH 3/3] group_cpus: optimize grp_spread_init_one()")
url: https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/bitmap-cpumask-introduce-and_andnot-search-helper-and-iterator/20250911-051023
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 8ad25ebfa70e86860559b306bbc923c7db4fcac6
patch link: https://lore.kernel.org/all/20250910210850.404834-4-yury.norov@gmail.com/
patch subject: [PATCH 3/3] group_cpus: optimize grp_spread_init_one()

in testcase: stress-ng
version: stress-ng-x86_64-665b4465f-1_20250912
with following parameters:

	nr_threads: 100%
	testtime: 60s
	test: cpu-online
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 104 threads 2 sockets (Skylake) with 192G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509192101.5d4e0282-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250919/202509192101.5d4e0282-lkp@intel.com [1]


we observed the issue happens randomly in our tests.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/testtime/test/cpufreq_governor:
  lkp-skl-fpga01/stress-ng/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4/gcc-14/100%/60s/cpu-online/performance

commit:
  6ade57f62d272 ("group_cpus: don't call cpumask_weight() prematurely")
  5df2998b7baa3 ("group_cpus: optimize grp_spread_init_one()")

6ade57f62d272d3e 5df2998b7baa3fd4cb66272d1ea
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          43%          13:30    dmesg.BUG:kernel_NULL_pointer_dereference,address
           :30          43%          13:30    dmesg.Kernel_panic-not_syncing:Fatal_exception
           :30          43%          13:30    dmesg.Oops
           :30          43%          13:30    dmesg.RIP:blk_mq_all_tag_iter

and sorry our bot failed to upload correct dmesg in above link [1]
attached one FYI.


[   43.544050][  T130] BUG: kernel NULL pointer dereference, address: 0000000000000004
[   43.552056][  T130] #PF: supervisor read access in kernel mode
[   43.558218][  T130] #PF: error_code(0x0000) - not-present page
[   43.564340][  T130] PGD 0 P4D 0 
[   43.567866][  T130] Oops: Oops: 0000 [#1] SMP PTI
[   43.572855][  T130] CPU: 19 UID: 0 PID: 130 Comm: cpuhp/19 Not tainted 6.17.0-rc1-00014-g5df2998b7baa #1 VOLUNTARY 
[   43.583575][  T130] Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.1D.01.0147.121320181755 12/13/2018
[   43.594817][  T130] RIP: 0010:blk_mq_all_tag_iter+0x1a/0x230
[   43.600779][  T130] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41 55 41 54 49 89 fc 55 53 48 83 ec 50 <8b> 4f 04 48 89 34 24 48 89 54 24 08 65 48 8b 05 8a b4 48 02 48 89
[   43.620822][  T130] RSP: 0018:ffffc9000ce5fda0 EFLAGS: 00010286
[   43.627048][  T130] RAX: 0000604fe9627758 RBX: ffffc9000ce5fe28 RCX: 0000000000000068
[   43.635176][  T130] RDX: ffffc9000ce5fe28 RSI: ffffffff8199e310 RDI: 0000000000000000
[   43.643294][  T130] RBP: ffff88810dd98600 R08: ffffffff833d72a0 R09: ffff8881003c8710
[   43.651410][  T130] R10: ffffc9000ce5fdb0 R11: ffffc9000ce5fdb8 R12: 0000000000000000
[   43.659516][  T130] R13: 0000000000000013 R14: ffff88810dd98760 R15: ffff8897e08dbde8
[   43.667621][  T130] FS:  0000000000000000(0000) GS:ffff88985caa3000(0000) knlGS:0000000000000000
[   43.676681][  T130] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.683393][  T130] CR2: 0000000000000004 CR3: 000000303de24004 CR4: 00000000007726f0
[   43.691491][  T130] PKRU: 55555554
[   43.695175][  T130] Call Trace:
[   43.698593][  T130]  <TASK>
[   43.701657][  T130]  ? __call_rcu_common+0xb0/0x2f0
[   43.707850][  T130]  ? xas_load+0xd/0xf0
[   43.712054][  T130]  ? xa_load+0x58/0xb0
[   43.716259][  T130]  blk_mq_hctx_notify_offline+0xd1/0x170
[   43.722025][  T130]  ? __pfx_blk_mq_hctx_notify_offline+0x10/0x10
[   43.728390][  T130]  cpuhp_invoke_callback+0x1c7/0x370
[   43.733805][  T130]  ? __pfx_smpboot_thread_fn+0x10/0x10
[   43.739386][  T130]  cpuhp_thread_fun+0x98/0x170
[   43.744273][  T130]  smpboot_thread_fn+0xc8/0x1b0
[   43.749254][  T130]  kthread+0xe5/0x1f0
[   43.753363][  T130]  ? __pfx_kthread+0x10/0x10
[   43.758082][  T130]  ret_from_fork+0x132/0x170
[   43.762799][  T130]  ? __pfx_kthread+0x10/0x10
[   43.767513][  T130]  ret_from_fork_asm+0x1a/0x30
[   43.772398][  T130]  </TASK>
[   43.775532][  T130] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common btrfs blake2b_generic xor raid6_pq skx_edac skx_edac_common nfit libnvdimm sd_mod sg x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel irdma kvm irqbypass ice snd_pcm ghash_clmulni_intel ahci snd_timer rapl gnss snd ast ib_uverbs nvme intel_cstate libahci ipmi_ssif drm_client_lib soundcore binfmt_misc acpi_power_meter mei_me drm_shmem_helper i2c_i801 ib_core ioatdma pcspkr nvme_core libata ipmi_si intel_uncore acpi_ipmi drm_kms_helper mei i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad joydev drm fuse nfnetlink
[   43.836729][  T130] CR2: 0000000000000004
[   43.841005][  T130] ---[ end trace 0000000000000000 ]---
[   43.855607][  T130] pstore: backend (erst) writing error (-28)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--zvtqtaYu8iHNx3qG
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--zvtqtaYu8iHNx3qG--

