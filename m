Return-Path: <linux-kernel+bounces-727007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79328B013DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C1B5A292B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6F1DACB1;
	Fri, 11 Jul 2025 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIgVKfag"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C72110E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216432; cv=fail; b=Vu15DpQZptOJ3qh7XzZ1UdRDEWqdPqYuj3eG8RdvBTRHRLsbkd7axf6cgeekl07qADtGIdDSO6iIHx6ywM+ZXgA0UfD6bJkqJIwzXLUjfnqsBjkwS4UDs/RZ88+DjADRtazR9XJ8Icv7wnbUlz03Oom9TYDz88dJgNPk197oN6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216432; c=relaxed/simple;
	bh=YIqFEv+suAW9WtszKrhbdj7n7tjj0g40KOxCd4FPQWk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MBkMvKReA/yt6ovyjqId4iwBdNvQh12/l6UO9xNkZE9jziwLgYlvkqwwE1S5cB3Ert8ewLDOTva5eH8UM3JzHdfC55wqmfZE+NiHsgPlm+TTte/aNYFZ3Fms5ZmWbSvAxTO6lp4FKDXnEjcWAW/ns8QXRSh6PARY8vtohdzD1P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIgVKfag; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752216430; x=1783752430;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YIqFEv+suAW9WtszKrhbdj7n7tjj0g40KOxCd4FPQWk=;
  b=jIgVKfagoQLVuNdRzAtr2GPN734XPyAcaH4Iq4f/8WBbqglT7ZHy1+Zf
   w8HD4LmWkP5OWkkl2NG4J4zlY6pSDRe3fJ8wmugN6WvLSfpfwEF622zdv
   3gaek+AA1OSjM8cOfn7zapNTghrtOVg+sOqIkHujBaURlBW94U+TzgebK
   rEsDs2+fDSowGQvihXQsLA3kr4e4qw7UlFVVr8kxOG2VDFssdrl45sMXv
   Gi6VdHc8ErjArOMSRcHKXstllGB5tQiwFqJcJ4t8ER5Eej9XdVYLfy835
   jadFOHWQQr4xbU7dmKClV6UPqE27+UnZnQW8tuJ6X+SGEkvBewp3UGvtm
   Q==;
X-CSE-ConnectionGUID: V5h6srRfQzaCb89MzUEXGg==
X-CSE-MsgGUID: 5C6TkvO6RiaoMPoMYei2rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54640736"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54640736"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:47:10 -0700
X-CSE-ConnectionGUID: Z3uMxPfaSVCya5uES6JR2Q==
X-CSE-MsgGUID: w4jdVXkMTfiPHpF5DtgBtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="161857722"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:47:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 23:47:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 23:47:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.78) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 23:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pf8n1mFwkR32hWadsdPrzeqjVuGT0l3qtyb1uNtSe4Ftmd04kIVQ6rSQ1fe6j8zdf0vST/OINCh3Ty4y9LtR8nJUy8QJn5zoiZOhAuI6nH1IGBhnD7vY+ALLitazxLGcwNPxkxLyJa1wHHJxHaq7wAY9J3GMaZVNWj+wWSVdVzyUfABP5G/6IvVZK+JoMK555GLMgC1ZxBntP3Tz6PLVIV601G3iUIpswPUVze6lEFumhU6o3VXcaO6R1XBKj/IbLCvISoCqJ63zc9Q66vApeCZlIMRNU/aK4H3f2LgMJUSijVT/uhkkejBmMBCUnWeHlRl/UP1ToaHj2iPDwJ4Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWuxliafuAlBktlMsnj2Y7/Cbuc2enICo4mtjnqiLYY=;
 b=furdX6vsAAsHaxNLxqrWR4adqISykyJYRU9au+MqEEtBTABifMh2K8oCdsm+MjJ3CCwblLmQaIoawMdHo9lZwl4E22vBctmBVxYkGPmw+Fobar5fhn2CI8sIQz+VBMMOKok78kuOcyiB3cgoBn94QCzp2IXOHK4w8PtDMU7apfV8K4vhOF9SPfAIFx+rUKVnZf2wVhd3cx+yBWWlbUp5mJxUvdK4GDLMMBnlVUWLMktCgeKuZFpf0tozd863F5guryOlHuMi/vpmECeKBqqeIxAPYcoHkAgGeJ/yqUrGOHd5IZzSqSUz9MDJMBYorg8+R3j/AYEU2Plvf1pY3QvhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 06:47:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 06:47:06 +0000
Date: Fri, 11 Jul 2025 14:46:55 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Dirk VanDerMerwe" <dirk.vandermerwe@sophos.com>, Vimal Agrawal
	<vimal.agrawal@sophos.com>, <kernel-dev@igalia.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5] char: misc: add test cases
Message-ID: <aHCzX46E+RcXuqWU@xsang-OptiPlex-9020>
References: <20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com>
 <202507091056.5d48c1a2-lkp@intel.com>
 <aG5tWs2rm1b8hE3f@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aG5tWs2rm1b8hE3f@quatroqueijos.cascardo.eti.br>
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: e177d692-ee4b-4294-96ec-08ddc046bff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yupU70p63YetxBCi6WDrF3qWWQzGZiP35s1wRDDMdGW7VnKqfGvGZrSH3WJ6?=
 =?us-ascii?Q?k5IAyxdbJ5h+vyT+OFDH2JlGWXMEfHMM2vNwsv9rxeL4cAZCC/YFGSyK/+bO?=
 =?us-ascii?Q?z4y6iwjzmO/D6Wrrd4SXGaMwR/4dnFSyu+fcXL326s+fT5wuKRhYESLGSpQQ?=
 =?us-ascii?Q?SN3pVClDnJM20rv7guhITXRM1CaxpOwWy40sUn+pYOy8ayfxO6uyvtycW/ro?=
 =?us-ascii?Q?s4GWI8IZbeminVaVOrpayi6WbFgIVloCf5ETvBDbOPcUPzukE8HxhWD8bb11?=
 =?us-ascii?Q?uHUI2YWV5q2Q+5GrPyJGREwb1eyqypSVd05HiXFjlPxroNkLOxTX8NckFRyS?=
 =?us-ascii?Q?6KaiKmBJUr96ZDVMDWKOZY9XN02RHhywHp6rEXL25043l9Y9JfQaFejF0BdA?=
 =?us-ascii?Q?MTLkXEscpSxfP3258IkDhZYYxKzmvT9FzzPmAt9rgHb6Fy7jQ3eOsF8/IULo?=
 =?us-ascii?Q?CiKV8Aal/jKGywGmNYkwK1amztvj+gHjqpKQBsh/Wyr32DBmYMbh2kz42/av?=
 =?us-ascii?Q?gvN+MLWK9k56+g/WoS9x7nrlLzSu8XIya8T1d8lm5KROZDwl/dOmcVMx2UFA?=
 =?us-ascii?Q?YG/DVFAzSgOJEr7K+L6TvkIHuS1Gqr0APg1dqvPyHXo+GugmPJyI1gI4fXkA?=
 =?us-ascii?Q?LX2jEotzvjSc3oCWsj2EYP+GvZsaoreOHLd4B64vT/D42qgXr7j8nBmROKXs?=
 =?us-ascii?Q?tCN+MiXVQGUIqU+f85jNROPs/UEsR1V9DyJUbzI9/Y2Ve5WdmHrzsAD/SNKV?=
 =?us-ascii?Q?8a6AMHv6XOHkghlNhZFEWMEfjT8XB95SrfEDGooH9l49O96NBxZDkfiBqaeI?=
 =?us-ascii?Q?3eOBKKktUOifJxEem77E5Yk4V0OaVk5RjUlYaj5Y499JdAuzbXF1vU6bMDSh?=
 =?us-ascii?Q?gGiioPIidcuPXET3M4Md4+GnrQc/GijXyqY+t4WkE4/ozC8NZyEkF3d832Ve?=
 =?us-ascii?Q?4w2c+5guxot3fPLN2HDoRm2bwMDw8NTrqHjDvAgZGksuv+Y5tlJB6rF7z/rE?=
 =?us-ascii?Q?WQy/ANRopZc5OnOTGySqxsXGLfQVp2uDguLsip1NxlnN0XjK9ejqeQUF8+NH?=
 =?us-ascii?Q?ggopIm2YsqyqFtNhEV3dcUB6us+L1ycpKn0s7585Ihu6DZyBsndNSz+z0Nr6?=
 =?us-ascii?Q?SIdnNJCLzAw1NwsEOx0M4QkLCnfjQjK/vXqXELAH3maLxzGMcpzdHXmmWDwy?=
 =?us-ascii?Q?boD016LkPjO7N6DQADZ9lNbsB9dTZFpmRzNBYo+q+N7tWhEnbrlvVrVQ1sL2?=
 =?us-ascii?Q?r8Am/VoiKPA/2X24v3O0HcbD69veMRYbJEU4qIE9+MuyopMHDFR1M3v9KUrz?=
 =?us-ascii?Q?8q4SniPXjjpr4hRTzDUBP9fGpQzIjN2dRF+Jmg90wkrG6OYe+CSBam2cgonW?=
 =?us-ascii?Q?GDOppKbC7QQdB+JtHXPZw+swKRSd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XF3yVNDvFt6xwBTS4iSFJIuHE6T7hzzLRZWSC1V5A1eKCQWT2Ku0dJsKuPLt?=
 =?us-ascii?Q?z+CVVo+laK2BFFPewWIdpcZMGFDgBGpo9wQFyARbOpWz+qslW9On2SjIa1Gr?=
 =?us-ascii?Q?N86SEt143OOty7LXgTUTh/D3ZGahp7U9lxWtENQ6bRw1dT4b3ZOCrmiNJnvc?=
 =?us-ascii?Q?y5sx1qI4O3I2ALPLNONjtUbMTCpwZkrOhzVtmK1lI5VctI07Lc8Jnyiqo+YZ?=
 =?us-ascii?Q?qoHZia7RNM50k8ikfstYzsmc6FChyUpvClyhZ4sh4KNmIAXP2Q8pL1CJH/6S?=
 =?us-ascii?Q?7G+ENrsvXGpl4lh/UX4gw2PM2WyCq9wkBvvK4qN7C+fXChnxChG+1ewkgUih?=
 =?us-ascii?Q?BAfJMXgI/JUTidy71Pqyiee9Utt3vnrkhPb7spVYsquJUceINqXo9JGYEvHL?=
 =?us-ascii?Q?9qcpmxeQezTQigMW2jNAnA/+ZoeMNp3i7gonba6R4VDcaUgkJZqU0cpnlGY6?=
 =?us-ascii?Q?AydZgBUvH4u69YlhSAgOm8whn+x3U3IoBMikc16e6JjvG1VmZc+ChzdCSn0I?=
 =?us-ascii?Q?MOPmeKZuM2vrmaPb3CoZmEHFHzTZ1C1VUdB/eTPKvRYadq5qiROZ6Po8GoJp?=
 =?us-ascii?Q?IVY9onYB86SiEvLtDogNJgKAav06D7a1moZjS3POeoWhRYB7XybC8dxzEpBb?=
 =?us-ascii?Q?wSJxZT9bU+3MbyV5HKflblwSZ4g9ihVI3dDPmW14pJ1+d2u0/QtTOivbScGw?=
 =?us-ascii?Q?DigjNwKZbcvF/BkXceUkKH5BZcHzQGx5sAkoesDFF+j83ebDOdqK2gLkzYby?=
 =?us-ascii?Q?RIGG7Ij5Kh8VAjHCScowV8D8al/oTwVzsfmsNaELHDoND7iJKxrzethQX4T0?=
 =?us-ascii?Q?G6He/XInsw1YABZnwo3XIF9YaTrKwhEbnhvRRXHqck8K0DbwFfOzPJWUhEiq?=
 =?us-ascii?Q?QpxDwthgt3mUZWPV2TpA5DHoDDIRbMdlapd+cN5+jCe+MMYRmmQNkBJg564T?=
 =?us-ascii?Q?DiLomg/Y+weUWmMZaJm8FwSsDb1OuYi/w7vua4kc3KV0hmsTilZ3DCmRZWCG?=
 =?us-ascii?Q?bAPJ4NMhrH3kBuIjfhG9XZKIiH7Ohq1lUtgfb7CrIxNrPnWLGXyGSOn4xsKC?=
 =?us-ascii?Q?Fw0eJKYcrzE0rqAsMiCzJzjZ5sxz1xVpwLJTt2lIhlsf6puMu7YBO22yCfLK?=
 =?us-ascii?Q?PRE8rR2VMp1Ny871PHZyRrnpqBp7OJPu+RLI6J1laG4BDn8MY8Tegb+SmBUE?=
 =?us-ascii?Q?CfW68MhIlBJPVpzI3IDqNPOZlqa0d9SzLZZJD6aW2ltiV5hL/5dDGD4goPht?=
 =?us-ascii?Q?zctTtZNYj/nvS79lwW+MYXTQbEgYkDwV7gnp65s15DfGcJPfVJuzxrHkVTIC?=
 =?us-ascii?Q?v+ASrnF05TNFYvSFuCKXj/e1ut8E7gGTOei9kpSDRgL2nhVDNHaqYaOQRI2f?=
 =?us-ascii?Q?w4hs1s6atnNYEKHeQ+zVFH69BhMKPN5c9rL2Nzad/RxotFJNGmfqBOHvNTgA?=
 =?us-ascii?Q?1VP48MhSjHuipWG9oQVHwYbDafmbkkFz8csh1Ocd0fKDzPhWuvUExiX1pdK+?=
 =?us-ascii?Q?oO2RZWgVE2DHmChnJ7AK+5Xrqlb4F8ARt0AGz27zNlRaC+fy59JQF0u3NRCJ?=
 =?us-ascii?Q?zl1A9chBXJvou6WO7E4XOEFP6I2Gu5qa2YSuWnwtw3tPuivhHPSgcDn3Hszu?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e177d692-ee4b-4294-96ec-08ddc046bff2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 06:47:05.9842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j1Otj7P0qfeTjuElJOkSg1ETYqNBcbkpg+nfOCS9i2YQCVpW4TbLRrp9ZXmOQwwxG/DrNE4hlHVcNjrGtrBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407
X-OriginatorOrg: intel.com

hi, Cascardo,

On Wed, Jul 09, 2025 at 10:23:38AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Wed, Jul 09, 2025 at 09:14:04PM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:
> > 
> > commit: 127b049d35f10765f429aa2a97aa649ea9ac0b2f ("[PATCH v5] char: misc: add test cases")
> > url: https://github.com/intel-lab-lkp/linux/commits/Thadeu-Lima-de-Souza-Cascardo/char-misc-add-test-cases/20250613-013440
> > patch link: https://lore.kernel.org/all/20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com/
> > patch subject: [PATCH v5] char: misc: add test cases
> > 
> > in testcase: kunit
> > version: 
> > with following parameters:
> > 
> > 	group: group-00
> > 
> > 
> > 
> > config: x86_64-rhel-9.4-kunit
> > compiler: gcc-12
> > test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202507091056.5d48c1a2-lkp@intel.com
> > 
> > 
> > [  112.908177][    T1]         ok 2 upper static range, bottom
> > [  112.914070][    T1]         ok 3 lower static range, bottom
> > [  112.920216][    T1]         ok 4 upper static range, top
> > [  112.925861][    T1]     # miscdev_test_duplicate_minor: pass:4 fail:0 skip:0 total:4
> > [  112.931240][    T1]     ok 5 miscdev_test_duplicate_minor
> > [  112.939321][ T2928] sysfs: cannot create duplicate filename '/devices/virtual/misc/misc1'
> > [  112.953103][ T2928] CPU: 0 UID: 0 PID: 2928 Comm: kunit_try_catch Tainted: G S               N  6.16.0-rc1-00001-g127b049d35f1 #1 PREEMPT(voluntary)
> > [  112.953110][ T2928] Tainted: [S]=CPU_OUT_OF_SPEC, [N]=TEST
> > [  112.953111][ T2928] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
> > [  112.953113][ T2928] Call Trace:
> > [  112.953115][ T2928]  <TASK>
> > [ 112.953117][ T2928] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123 (discriminator 1)) 
> > [ 112.953124][ T2928] sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32 (discriminator 1)) 
> > [ 112.953129][ T2928] sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:63) 
> > [ 112.953133][ T2928] ? __pfx_sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:41) 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250709/202507091056.5d48c1a2-lkp@intel.com
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> This failure is intentional, it is part of the test. How can we make the
> robot ignore it in this specific instance?

got it, we will avoid the report for this specific instance in the future.

> 
> Regards.
> Cascardo.

