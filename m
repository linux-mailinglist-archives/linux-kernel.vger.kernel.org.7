Return-Path: <linux-kernel+bounces-723672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E399AFE9C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB7C560E70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A9A2DEA7C;
	Wed,  9 Jul 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsuTBrpb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B01FF1A1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066860; cv=fail; b=KKg4vtoE8hoDR2gbOxgjRWanTUPilI2xm3/VKRUl5JPZZABZ5mSWOipTMq6OwyywMEypXb/KRg7nuPnqxMA+5yegasnNzVicHeEli8OvaqYqWUQNAhybYmh3R8qtPkLVJQnTj04Y370Y1rvI/pCFiATf3jTqu20L3+R581OpWf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066860; c=relaxed/simple;
	bh=tf5uUyQ95emWr6M8F/JmhkGNx93xcFz9y06/m/oKOHI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhSIfLmd0xCEnuhQW4OM/LEkGI9UL3gYBS8HZ24F1W7uSlUsf9jPAnUd0Dxrhjh52ST793RFila1oqsGRYBqmVrvxcJB5vxO22YvTf98noF2pBWqznr8vD+WsnUbVExIebJ1W2DtVT0UcumEM/67J4xaM/P7EYebRSI4RVpf+Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsuTBrpb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752066860; x=1783602860;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=tf5uUyQ95emWr6M8F/JmhkGNx93xcFz9y06/m/oKOHI=;
  b=DsuTBrpbqTBl3ZEG/Fw9Rieozpb99qy0GHVxZHsCsEReCymr3E8FooOe
   LSw6RNXT+f6C5ap3zDCiBXZeTrvE4Wgba8dLuDSgLZq09W34jrhBp0HpG
   Xlm12EET8yfn4Up1eJb1XKmVJOWPaWJ7pU3cCsjVPRjgpsR721qprlTCF
   tpYY1ypcgUlAbbg2fzIlH2hMUQmLMulVNb4fHGxyMO5n8xZjh+P5KlM+0
   W/IdrsbIltdWX8Xly9OfL04d2YnyTINYolUysCPjw9LQDI6MO+GTuo5mv
   DwiyYK+FznpbEyqGMIG6hhTcVM3Wr5EMy28DKehjdKmME9H2HIACi/AND
   g==;
X-CSE-ConnectionGUID: vm9nFvlPS8WxkZ39Xu5nLQ==
X-CSE-MsgGUID: gI4G42dmRRWXRbe5Fvk03Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64583005"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64583005"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 06:14:19 -0700
X-CSE-ConnectionGUID: 5xN6+hkFRSOQaGtG+ZxwVA==
X-CSE-MsgGUID: JuuMySTiTjO1bOm9IQ2Qtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161428882"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 06:14:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 06:14:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 06:14:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.87) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 06:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hti+kJnMFmwOtLLMEG491B1NWA2+OM7jh5c3HUOuq3Vq0R9QRhzfDWPjzqJwbQoV25SUvgvdtiK1Oz/qfOMpqzwWf0yUN7OLCYjxw/tfBI6CrPyFyLmerawcNYJoEtU7Jrv/yFlFFznHLMeC7mi+q56TwsmI6U8klGJayD7xqt6LJvJKd2THsLOsUiYVcXz2Kx0dyEuMW0z/2+J+9+DxX86hHh4ZM/3eG6idhdnn+O7ZnLOz2QZRN8jpfyo3Xq3xsMqSFnriqA39l/M2KdARhWNLO6YIBPIr0rBo9hwmWBlO7UM5McrRZsH7sulhfeaHpzHrQOj/Dxp9kKt81Su1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep0KQcmyHxdIx3yQKNxq1PCW3eCu1aI45oWuZQojGZg=;
 b=KbCGE9DpHX5GO2JJcSUGj1IJLQoms1LmUG2nBykziRFnEveyq4hPWkWGTM8D8/fGEmnPwYJQ2ywi4h2lVsLHCQ3BJiK46IqFb4vPACVnXjM3gSl6gefClCLbud/mqVP7lU72WX+rWpktMmZWAEFwGQ1tJHm1ziIxewlYjBnGiN2ayhhzNUI/DYwwx1tiLA/zCsDrHC+EytW4kvBi/SKyrNXsoWqTKAnIcuVydaPBqOhJmQ2h2bZ8wRMRPP+eL+yf0Nyam0af5oZ+VmjIt5XYbLWfauwqONMcPUTzmei46xKjLYaHBUQpNOqOvmzDYndrcr/1PlcIiHwbXL/cqjWZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 9 Jul
 2025 13:14:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Wed, 9 Jul 2025
 13:14:15 +0000
Date: Wed, 9 Jul 2025 21:14:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Dirk VanDerMerwe" <dirk.vandermerwe@sophos.com>, Vimal Agrawal
	<vimal.agrawal@sophos.com>, <kernel-dev@igalia.com>, "Thadeu Lima de Souza
 Cascardo" <cascardo@igalia.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5] char: misc: add test cases
Message-ID: <202507091056.5d48c1a2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: c34c8959-0e19-43d9-7669-08ddbeea80db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bzXkSKAen8yZLPaqZzR6j3IxxDXJNFdhb6Y8/CecDPMNXXNY7gZolUTKvRj6?=
 =?us-ascii?Q?3a3f/VSTFATOZKcLvqJzPWTa7ykzq2GSMXDqUo8KoS0YfequVCxqR/fZyPTw?=
 =?us-ascii?Q?3KnL2vCFpyhf0KcqfrkjqBT8sYY+OId5QyEsRFwKu5cyj0ZoHPhTnOlOAXpN?=
 =?us-ascii?Q?vlYdppyWX98SJMxVh/vKR3t36MXEjD0IdUHiBYIOtABG3XuT22FugFcFHvSW?=
 =?us-ascii?Q?ZWAnvay6yQ3gZFnwJTNesee0zqg1YmRnsKnNuonlrzaNPedhXvu9XbqcoI/I?=
 =?us-ascii?Q?MhdeXL/tizWimY9QCLmjjKfIN+/gz0z7HTUXzy7LkyHkNpLGMQfsmwPCOcS1?=
 =?us-ascii?Q?lloCBoFLnMJfMaBCoov2gSLL/8xHwWXdKUhnVAJCtcDjJMpuSYypoWTWICWx?=
 =?us-ascii?Q?sVPgHb9NbWl344BTVPRnKFU4fBWjrdV65ClrBG6BQTapGtK53gqWChWDBza6?=
 =?us-ascii?Q?nZhGohVBi3PhGaANawFCMWa5yCdSwIMt7EIp6Eyr8vt/3pYbfY7JI/seDnWD?=
 =?us-ascii?Q?AehzoVHkuM691quxYmTAisi1NwMWr2roQtg2SQvI1lVYcbbRkF9bjW3P5gYK?=
 =?us-ascii?Q?/+y7KLkknlyoi+XHJ3WSgF6LN8k8t3mx58LDznh6mA7Mw3TJO+irJiZolNce?=
 =?us-ascii?Q?DJfPAGuWkZpsjr/1X3hg+p+38i+t028XHZ7CPEEgtlIGquKPFef6wAw2wSjb?=
 =?us-ascii?Q?LbQFFJNniSZpRjd9bRpZrHDzcnf3f70DxtPwrH2hw/lVQsOeis704ctUrSSJ?=
 =?us-ascii?Q?rP+XlhZofyq7Jsf7EmVxK4mNt1rgz5pKhFL3E0+Ie9l1lEcdqSDTUgvFslFK?=
 =?us-ascii?Q?f6PnzYJUed8OIIHyjN+RpxcX9JbWWcWzQWJ4f06pw44PzeLVYrMBG55vi16L?=
 =?us-ascii?Q?cbkZibjpdCN6he56eRPiyyvsWBnEfFFDsJA/J6CdITxE09m54iLcHsAuo4wT?=
 =?us-ascii?Q?EkhmYahuc9/sy/gX+4fwGu4q3uyg0c9cM0XInRv31gPI1Algsfz1ZReMUHlI?=
 =?us-ascii?Q?EugxzGQHfVBTBeAkJirwWUu7wJqNwcZbIYICI436fkLcLpHXTmmIt9hvmOZn?=
 =?us-ascii?Q?VHGT0I1b03o8ig7FdC4i0KRcK+gKVYtvZxxxgKEoTh4hTl8hg0ik1wzDMadP?=
 =?us-ascii?Q?0T0thJuGClasARxmiZkjMET7S4H30JFUVTV0hWvIbh913dHEvYwNZooWKDkF?=
 =?us-ascii?Q?axbOMjU3T0bnos+1GVb5knSCLanV3gYOk37v5M76arFZkB+QsGMzFQgjgoxc?=
 =?us-ascii?Q?di1zV7ab5vlEJ4radD/2ogcee+9+VeHA6pcPHxtxe/UoClaEv9fDSUhum8vR?=
 =?us-ascii?Q?HynFZUPfQYORQ6L43OdfOM+cxR9rIYxhcq31KGpSuZOQcIz7Ckg5p/l9DRvR?=
 =?us-ascii?Q?y4sjhGaeoR8fSO2pDl5WzRlTBqG0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zf7wMig9ZYWYoVqyxmvyvMThrpf8YFV1wli070fTk+Gjh1rPDnKz9lTq+88P?=
 =?us-ascii?Q?3XyOcInV3uwka+1caJn0GxL9YBN/Ra90e9/8RNfUYNETg8KexZQCja9TryBS?=
 =?us-ascii?Q?QjnXv2+TKhOqGjmCNsi622/DftwpGVDpyCeAIp8+S+ifO/ESBh4Ra1rcuRqx?=
 =?us-ascii?Q?hkNtM20vTjuWJd4DB6N/dmKDlaLmHVr5IgKr2utvwkbnIO6AdBxW+Sp/Fx8U?=
 =?us-ascii?Q?liruxuVaaOSKlf6aeef8Yg6LoCGY2xc5h9EUXnlDgbhfb9/quRzFjU9iU2zc?=
 =?us-ascii?Q?jyqa+S2+X3cONluR/jWk/Sh7CfNvwNj4IRIa23R10+UQ2MnlxeN6vhZ2TfXi?=
 =?us-ascii?Q?uaYXOPOCvhnbh5jWOKmda6AP3AZmH7E02Kueeg7ZxN2bbL5xG46hhHV8sUYx?=
 =?us-ascii?Q?UuQfN9qzjVVPY0BnsB+PBgbUji12lLRuNSPAdIdFPM8LHAIlfOZFU5ZMIcDL?=
 =?us-ascii?Q?40d1RvK3IE8V8Wk1cjALHhvSRzKLhrB0dIyK07KisCviIjPqnEJa3Qa9MUte?=
 =?us-ascii?Q?ILESRY/FztuNVTPDotRWplu7epPCQ4PP8hU27bRAXUzlM4oS3ADhecrY+0UZ?=
 =?us-ascii?Q?wCnTvjwyXfFky5Z0V0NEM58VUp6jx4/V9gZ9cGi3ouzmrIMk/2sRDYzUpabc?=
 =?us-ascii?Q?CcK9iYq5T904exFSnYyhEp/Wlcq+STG6AuXaeQp+NC0H/O5y20mnQiV4AvIX?=
 =?us-ascii?Q?gWlacjOcjJR+sXdHVldStwdORbvIIWDwevVbhhoAM18BuJhtyqEjxklnnrWk?=
 =?us-ascii?Q?vnMYDI9rcU6zeEdbcHm61PPIU4UecPzFfCpMeJ2JgPy8vzN8/O/YMSN1+uQ7?=
 =?us-ascii?Q?xCUOkVgf8VfKRgCRAZdxOyiFxKpDHhhJJjBKNFV+SIvDMGoJMHvQrLRFIZJB?=
 =?us-ascii?Q?Xedg5+iy+GDL9SjKH9qs0A1aSovmfTSdYksoeAZ/qJ2+tN1V3QQ/GglLjqP3?=
 =?us-ascii?Q?Ux7xPmdQVcb0eHaZFzmnbs06Sn/Og6me4ZhBV5+yz3HxvZhJ2LHNirVnbKKO?=
 =?us-ascii?Q?xGcYTrJReV3IkUBTRv9GQFYcm5EMC9xgk6IKpPkvhir2lTwnYzJc3HPqV02k?=
 =?us-ascii?Q?o72ZCO/1eIpNndvo+bzSgYN5bSUXA5lQ9G6h9ajMBXxuA3jn2RfZs9sSsVHJ?=
 =?us-ascii?Q?jFzDDgoNQTQowVqXgGmhmP9bkkS+ObSNGL53Ge7VwMajJ9FN5sR377x82oEm?=
 =?us-ascii?Q?0dhsgqTIZe+TgXvGMTTr06zQ3pzNJda4n3PORsd2n0Q4n0m9iqTeGtUz3RUJ?=
 =?us-ascii?Q?HQrvNG5njvISqLc+KfqdUlAnOkzkHzh4+nDn6LzQhyEQymQPvjE0mj0/WeYw?=
 =?us-ascii?Q?D8REDfLUG6qvFP7eniEN6BSCybl6hI2xH9ycpsIfPaUyrA/YExwbFWJAGvMP?=
 =?us-ascii?Q?zOj3DDxkgCNFNe8BdjIpoV3sCWJZvEelz8D9MU63VQJTDtNv4GxKD78J2mIE?=
 =?us-ascii?Q?A12GKKvmaAmhbIVKfu8FsHxG+oTtHZjjRXNyD3S5sJh6kk4iFEQG0nJAgI0X?=
 =?us-ascii?Q?jlacrgm+Mf1RLRUr/0zSdkU4n+JausKrtuP3U5nJQvG2io8MRxQKCjzTvVKW?=
 =?us-ascii?Q?/dbM9BOoBEQm3w6c5Czwe4Y6i0X+tYbtBEX/XzePlFCZTTRXzDxHYC0OD8c4?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c34c8959-0e19-43d9-7669-08ddbeea80db
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:14:15.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPBl3Hyub6QV1TLv/fR/So22SUbKJ/o3h157D80u+p7pdZzoVlFRIwHIC9ifAGJyiaxFFuw6v/1Ba2ZuAw46XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:

commit: 127b049d35f10765f429aa2a97aa649ea9ac0b2f ("[PATCH v5] char: misc: add test cases")
url: https://github.com/intel-lab-lkp/linux/commits/Thadeu-Lima-de-Souza-Cascardo/char-misc-add-test-cases/20250613-013440
patch link: https://lore.kernel.org/all/20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com/
patch subject: [PATCH v5] char: misc: add test cases

in testcase: kunit
version: 
with following parameters:

	group: group-00



config: x86_64-rhel-9.4-kunit
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507091056.5d48c1a2-lkp@intel.com


[  112.908177][    T1]         ok 2 upper static range, bottom
[  112.914070][    T1]         ok 3 lower static range, bottom
[  112.920216][    T1]         ok 4 upper static range, top
[  112.925861][    T1]     # miscdev_test_duplicate_minor: pass:4 fail:0 skip:0 total:4
[  112.931240][    T1]     ok 5 miscdev_test_duplicate_minor
[  112.939321][ T2928] sysfs: cannot create duplicate filename '/devices/virtual/misc/misc1'
[  112.953103][ T2928] CPU: 0 UID: 0 PID: 2928 Comm: kunit_try_catch Tainted: G S               N  6.16.0-rc1-00001-g127b049d35f1 #1 PREEMPT(voluntary)
[  112.953110][ T2928] Tainted: [S]=CPU_OUT_OF_SPEC, [N]=TEST
[  112.953111][ T2928] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[  112.953113][ T2928] Call Trace:
[  112.953115][ T2928]  <TASK>
[ 112.953117][ T2928] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123 (discriminator 1)) 
[ 112.953124][ T2928] sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32 (discriminator 1)) 
[ 112.953129][ T2928] sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:63) 
[ 112.953133][ T2928] ? __pfx_sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:41) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250709/202507091056.5d48c1a2-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


