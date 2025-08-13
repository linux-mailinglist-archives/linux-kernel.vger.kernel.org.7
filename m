Return-Path: <linux-kernel+bounces-766996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1136B24D97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990581AA21BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB5267714;
	Wed, 13 Aug 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/0xHC+P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D896237A3B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099194; cv=fail; b=kG8Xc73xQ5xgh5/EXXVHhjziDTpJtM0/y+u/k2+OSthug56izCtzutimL2LnW8AUPQbsHbOLJGn3kzaBgmO+8gLuJH3Qftpu828m0+2aJ1GjiHIxWukY9jwjMA1uaYmOlBHTZVD/y9gtTreLYbWTaYoX7XsQIh6sGMX6EAtjlTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099194; c=relaxed/simple;
	bh=9KiFKJ+j5D9glIqxqY0dPwL+2gqK8JySZDex90Px8B8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sS6JKH5VE3WbeeKuzO3Grdo5sySsmWrCns/GyfsCWogQejuVsvLRBIAs3A92H5e4ThwNVq/drlocNTpilwe3g/mPbEi5rNwaUK2EtQkw1lY2NoDCfiI1eXn4v3QZdByJV1Gx70owd/ZCYPHFsqc20FyuC6oFk+QJAbTmg/rbzb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/0xHC+P; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755099193; x=1786635193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9KiFKJ+j5D9glIqxqY0dPwL+2gqK8JySZDex90Px8B8=;
  b=g/0xHC+Pub0w+9wZ8+QbbsNHz3HZGhfNXLF45DmiYDCkaX6CNk66/PXi
   BDi3VCubLjStnhwwKi/+Lqpe9RxNwMRR2PdWvk78wTP4DZSZCnCGIZOig
   vlxRde5+IL37T2sk58cqDwk+0Tq3Rr8MQvjK7m4K59nh0oxe0dJx+iJH/
   2Ne+nQTTMIsNIm6LJggdAy+V0ljTWo79JAbAD4GWfEqbwXd9QwKHO7hPK
   1UN4ZW7Ioi2ydA386ZL8vbF+u9vdug4smefj80YZhO2/HLUy7u3F0/XIk
   sdrAOw2ZDwS00lNczp5IMYOryi6kRnYT+Kr/j/4JciHGOaRBMtuzdyNXb
   Q==;
X-CSE-ConnectionGUID: W9xLD2FDRh2w2NA5X+M2YA==
X-CSE-MsgGUID: Dd+9s5hrQwSev0a7mtOGkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57302881"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57302881"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:33:00 -0700
X-CSE-ConnectionGUID: 6qtRVKT2TAqwQ/KknP7ydg==
X-CSE-MsgGUID: Mjg9jZrBQJq4JAR8osBxgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166873042"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 08:32:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 08:32:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 08:32:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 08:32:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfkQb2L8fEiSUOkLz11K1P0cbb7tsO6u8ucKKne3HIOhgTjBVUF45d9T+gq7wWlGs9lxHcvZElWEWDWR8ROE6CbfKC7TMD7QP7QjNsBeVHj16icAgi6wZL8CfHwowd8YVBe5Gd/pMlMiYv6fn9UM3MFNy42JreXnkhhHhX8RFsrBem87cqZPmn3mYO1vX4Dsspq/WRin+R53geNV314jc8YAuCzXzGKji0imQdkH87otyRKuE7IMGqNgHUbC+7sIvJBN9sDaqLeyi+yU1uvHz/3y7NDPMDFMGkuDZmF0O590CLOWKAml8uMOE9TSH0ODgTsxDMJG4tOvbnMi4+1C6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPHeEWH7pavM8QU7g53pEOdp3yUu2jZeH0CQt2HSfVo=;
 b=aZ6HuhUmprDnCDgEsOPseEXCgYjxPP3e+wximTaGmaqP5g9ojRGXat15Hwrjmb5W12eWg9KDfxx+XZVUAQr52GF+m3LJDmrTrT5dIbTxD+YPs2PcEPWZlGhagfQGqr8L4a7WIgV24+mskAJeNb3SRMHYVkv3vzrjsQacjbtzKq3M1YEs0352snLEBb/mkWe8mNhpmdJrUQywTBcSR+dVepUsMVAYE1/uFg+97AGhACNUQlUqJXTUfayAte8nsJ6GpQ/BUDpOwBBllFsQWW0E0XitupdvQC3gC5MwMwyRNZEN+95DWgKMctVoY2iJwDKU5SoXIbuTeBqZpbI6JEhPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) by
 MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Wed, 13 Aug 2025 15:32:55 +0000
Received: from DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::31fd:4de2:2775:396f]) by DM4PR11MB6141.namprd11.prod.outlook.com
 ([fe80::31fd:4de2:2775:396f%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 15:32:55 +0000
Date: Wed, 13 Aug 2025 12:32:45 -0300
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>
CC: <linux-kernel@vger.kernel.org>, <john.c.harrison@intel.com>
Subject: RFC: configfs attribute description
Message-ID: <otrtabbmkoutnvku7mmoecw3f7bjqwhxwuxuu4ewhoseixxgpt@fn3dt5tgrnf3>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To DM4PR11MB6141.namprd11.prod.outlook.com
 (2603:10b6:8:b3::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6141:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ccc318-a00c-47c5-bea5-08ddda7eac3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hzg6g0JCDxn92XPrAzX+L4o8gGnfbTfGGeIH2jVtMorNgxCiS/rxlQMAmUSL?=
 =?us-ascii?Q?8cB0nuof777OqV+kL/0a2sPOG4st96ifs7SEG2LRm0ULyyy9w4pfAcO/iqro?=
 =?us-ascii?Q?IxHn1xI0wT3HHxqOWw92XGa+A2t/ENq/k6/FWHyezTxuOgx83iHxtxd1T7kS?=
 =?us-ascii?Q?4+rIcQCXvOX66NxMujcb8Vj5kovmZGQehk/2xyi1Fyj74NqIu2nIS5kOmICY?=
 =?us-ascii?Q?JW+IGQOUVN/3eO3BhfAjdIvU2TOrnuIHN0ZR+uOQWaoJM/UYHuTWecHOboev?=
 =?us-ascii?Q?01ie+oHxjqBngLPbUx2BmkM85NIHxUsU6KwFdhgsB4kuM4dnOtyjUE03LHev?=
 =?us-ascii?Q?ePkz85gSDnHdldmhr2pdqYK2U2UmbbatDXwuvYwG8swDt4cPCNTJS3tbrpyD?=
 =?us-ascii?Q?PswahgWmN/8r7z6HIp10y4UndlHeRt3/nQwEoi2OWfqD4ZpUzcsIvCscEm+S?=
 =?us-ascii?Q?1P32B/ystiTcIcESfbkRJH7Pe0RVKhlOoLLOi/zmwrWKmqnaLnkjU7j67kFX?=
 =?us-ascii?Q?3s5ZWB9Pe76eJmRWIBHa+CkUw3N4cZAnliEJur/G4qhY8KC11/McHOOaHATu?=
 =?us-ascii?Q?lDCo7ODiMWzycSPy3eDAyUcJiJc+K7s4aD0B7W0qCqmHZPlwwSAfLMhdHmnK?=
 =?us-ascii?Q?mhu7KqUZHFPlk+AjKQlkUWHsiZj2+7BomBGk+PTV7K67ABw5uU04sguYsVcK?=
 =?us-ascii?Q?WUfOvvIPkYO5RIKDf5nXPyaZz4iofViDqQz9S+d+TCyk0cceAWvB2AfapFyf?=
 =?us-ascii?Q?UW6S6Q4AHQ3jH/8T8nOwDpB+hklipu8nBPJ6k9N0oXn2S9aEP4C6hHHNT1pE?=
 =?us-ascii?Q?3rpvRS/8h8lTMM6crZNKbVXbMSVbiP/R68C5I//5QksP3OrbhDS3t5hH/Xh3?=
 =?us-ascii?Q?RQn91SXNlb5VKsTskGZMEPDkdMivh55cXmF7Z34adQkqoemypQuSrP72riJI?=
 =?us-ascii?Q?Om+gHTJtF32xg8wsZHD197WBhTBLASkWRV4EW8JXKTlBOTmpIdR6NhzovAKl?=
 =?us-ascii?Q?cH37hLi1Q9gCxVrWhZ+2I/4xeekmIODx8tcG9DMduJZyLtKvF2wE27UGvu1P?=
 =?us-ascii?Q?cZQK1L43nfpMRaGSrU5O2IbXiWOPd6RfFTpMlBuRdxyFtRP329oK94iCI9H1?=
 =?us-ascii?Q?CgkNiN1TOC76xz7S6YfiEEePlFTcU2DPSo/Uto+TRn+5wl27T947tNtfVqGr?=
 =?us-ascii?Q?Wt5WY6b/DWKwFfKSHuPkJvTAphZEhUAL5iTsUB5LF/eXtW8YVywKwmhkoEnp?=
 =?us-ascii?Q?4XmVLk922GPcEhIkjqbE62cKZnPbgAURnBUVQ53axeEDa3QY5lyV/x8YEgxv?=
 =?us-ascii?Q?dgVXUmV6XjmYcQ4W8DENvqb8N2890dcMMEKQb5kdttSo0ZX1JhW8Fq9UvyWx?=
 =?us-ascii?Q?o93Mm6D1JTBdkqNhbQrHBvOU8CKARedQTvSftuF0Bn3/WCtlp6x4NhgGog4o?=
 =?us-ascii?Q?OpgdGp4CHE4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEi+fCvG2XrY06x8fNRziaDTfQhQ9J0gecLXTgTVLzEqASHkYDBQxLJ69Anz?=
 =?us-ascii?Q?PQSP3iGXo0HF0eWIGoArYc7QEneL4HHKY6RCuMJz1MyfCKNrEgrsXsa/Y29d?=
 =?us-ascii?Q?VcMsivmMRahKMlF0o+1od96s8eHSrq24o/BsM3UcKpT0gKweemRRujANZiU6?=
 =?us-ascii?Q?+mLtkAZuuXgj9jHjRofeEmCBMwVnPGNR4q4BTM4i2gDo2SxDUgHbpsG1gOia?=
 =?us-ascii?Q?YWzyv6BG93HILMWzX727ol1kpi3GCH92YMi5sFnya9FR2fhLmwGHsQKMcdV9?=
 =?us-ascii?Q?uIp8YIpaEG6FyPd/UH34Xy86T6AKQG8mOLrvnnHgGhLokJLO6KEVdZjTSvTw?=
 =?us-ascii?Q?g1gD5xkNmyCSqHxT7Opo3uv9oxxuItVCU57DfHtRa933Y/b4jfhu2DNXd9SL?=
 =?us-ascii?Q?FwnKeFsErloEGUxK/3aZ+G5zPSQLQIVqm5+9e9fJxnIDP6x3JGyYLd6wvdeN?=
 =?us-ascii?Q?cGPyuIf99FgAvCiPoU4pd2ENAWG0/zpQ1ZHAmCo1+4jcK0ZZad7ymLXc2nTA?=
 =?us-ascii?Q?xvK/oc58vfcvZtw+/nzLbFoU1sITHCjqbww/tU+M4jvs7AhTJVuuiLDwzHgb?=
 =?us-ascii?Q?Rus8sgloXMDT9sZv8/ebV0nHB/dzaQfZfXsL9Kvs/ul4sK7h9PNblYDhLa7T?=
 =?us-ascii?Q?1odOapGAeXqAekuXFBGYZx6WiXc4OUmjGQ9HFhdyWeerADxRFXGSixoie7Zg?=
 =?us-ascii?Q?0Io5IO2LG8h6nBcdYEFf0ypHKezUlI0g4Z+g0JEj6W1cvaHRT57fkEpHKxDD?=
 =?us-ascii?Q?JUYv9us9LG03o7gqIA4TDRB2i/DFpfMWawXyk9tn5t9qc6cx0dAY8UQAhN8X?=
 =?us-ascii?Q?aovRsGU6YPHsFG/xgXe9QFa0GSElocqcXLrfkj1AuhoYW0xPNqnVsgctBYeI?=
 =?us-ascii?Q?pFqasoiGP0U0Hse45/wzcqRuaZYdefjzHmL60D91B/DA01/saL1N2JwySR48?=
 =?us-ascii?Q?fuIJZZU4pJwV9ZbHbP8HJcZZA+UJGNuT4z1L9JBlsJyRbE1p6Ca3r4Im+iju?=
 =?us-ascii?Q?QPoGdlyxMOHtD7MQMf4jDknUwyeK2hnw1F4Q/x6Ob6QslLEHSXoJ5Fdm4XRX?=
 =?us-ascii?Q?iUU9Ws/jJVKTJkHAMhiwIVJUSgoISXDHHlGFbwlOYfgvC90ul1pqxKZvdUgY?=
 =?us-ascii?Q?OddZUgSPAB6N5GKLshFb0rKQEre/I+TjySsf7yVPOgk6on3N4ASJk0Y82kB3?=
 =?us-ascii?Q?24ipDztv5vg/RDKS+czLRkhoY8412UPqX1yGbnpNgwPVqVQQ7+ABxJev4aco?=
 =?us-ascii?Q?pbSz8BErTA/WxENYkrLivssVyvRWErbqTNREN8vZrxFQHfdCqMTQVWJy/Qv1?=
 =?us-ascii?Q?Vku5F31/QlVWCV5I8ar8FTlKEYNOuCW1oMpD0z+c6uCgPIsS9b8f2B5GA2zb?=
 =?us-ascii?Q?Iyn1X39aLpzl0QPMp4OPjGF9x4YgFVow1KLdl9rOAEjpCNqrcAnXDv2Vk4VS?=
 =?us-ascii?Q?N4JUcBojGopobIWvXPofErUvTZu6DDzBhux4OzYOf/jTbArKDzS7YwwSWR21?=
 =?us-ascii?Q?VkBTU9hkwJHbXClBmmt28IOTpdo0gGPpYvyBdZ933Z/s0ZOngoukSOLd//IL?=
 =?us-ascii?Q?2Pm4iul1PUmXIP3WxLvXiRmLJ7AIxlBcNC7R+MzMPwXBtYYOhqkwVCKM3y4o?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ccc318-a00c-47c5-bea5-08ddda7eac3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:32:54.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wCHPxVaahH43i8Dgaxc+cig/GPfMUQ4XIt8Ppafub4eXwNBZoD45T7jqeRCQpp4eI31GwsvmpeRBBzPpOJazlT3hZwHCdhGyp/xn9O+73k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
X-OriginatorOrg: intel.com

Hi,

In the drm/xe drivers we recently started to use configfs for a few
things that would be added as module parameters in the past. Configfs
seems a much better fit for us in these cases.

One thing we are missing from module parameters is the description.
I can point people to https://docs.kernel.org/gpu/xe/xe_configfs.html,
but having a short description somewhere of each config at runtime would
be good. I thought of 2 alternatives and would like to know your opinion
or if there's a different way you envision for this.

1) Add description to a module info. This would allow to show "all
configfs attributes this module implements":

configfs.h:
#define CONFIGFS_ATTR_DESC(_name, _desc) \
	MODULE_INFO(configfs_attr_ ## _name, _desc)

xe_configfs.c:
#define XE_CONFIGFS_ATTR(_name, _desc) \
	CONFIGFS_ATTR(, survivability_mode); \
	CONFIGFS_ATTR_DESC(survivability_mode, \
			   "Bind device in a survivability mode useful to unbrick it")

Or provide a single macro in configfs itself. This would "standardize"
module info to contain configfs_attr_xxxxx to describe each entry a
module implements. Main benefit here is that I can take a module and run

2) Add description in the fs tree itself, similarly to how perf adds a
.unit: 2 attributes are created, with the second being RO:

ls /sys/kernel/config/xe/0000:03:00.0/
...
survivability_mode
survivability_mode.description
...

This could be done all inside xe itself, but I think it would be better
if there's a common way across the kernel for that, hence my RFC here.

thanks
Lucas De Marchi

