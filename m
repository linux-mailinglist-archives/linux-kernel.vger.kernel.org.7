Return-Path: <linux-kernel+bounces-835220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4692BA6866
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C086F1895678
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EEF298CA4;
	Sun, 28 Sep 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da27X4CX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D922773DE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759037824; cv=fail; b=LYEdVQtK9ZOGL8BXRrYXvi3gnf+DBd0Di8V9U2C8GQpVYu0c2pwJNKm/SkHqBxsIj1wAjPuxvyvUssUPEXPXJnemrhk74QqFD3CuPmSQ+REiZrKfkjFxLsdrUdLmUYETUTc5lRX3MroubFU3xvR/5Hwfn0jYlePXFvey9/2pLL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759037824; c=relaxed/simple;
	bh=xU47763XDjjDFeuEfS4LlDd/f8Ckis8Pr6RleYzEFyE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TjnAP3uZXMUTZvHMd77ckkcWqGrAs5CbNAqgRtvsiWaH5lB/7CwzVV7+kg+sco1xh6mv/5KS+EYUhqHR+x/8oiW0QmAu58eu4UG+gXxiXHMzfWsw66xE7gDWsqWbLSsB/9jVilt21YtkKKTo6iNfLKiuKSRPhNgaM/T5RMsovSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da27X4CX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759037822; x=1790573822;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=xU47763XDjjDFeuEfS4LlDd/f8Ckis8Pr6RleYzEFyE=;
  b=da27X4CXSMDb6GQLCyXjq6mI924/70l28UvGbsoJ551kToTiTkFDvp3h
   nDI/8+65kFX/7qeHhZAzUcygYMrhwWVTJ1zQO0QSL/pTiZhG4EVm1iIZ6
   MbPgOeGrs2UdXete8lAmLX6risLiWjqe5RscHNp1a5mImXYWcgDnpVKyv
   yJUEyzGNxd8BqWw8VfZ+BTWPWNhk0fdeVQcSyodQ9O75uKRmwPJHo6y/7
   FbZz0XRaapVScNuZ2M0byeaJyr8bOvR8fGoZ0bEkvUcTFkuwJ6g8uD/cn
   FhNJ7GTNBVhDrpG8H6HO+vjFCWYIhWQrnZdGYUGGYGSXJtvoi07imXfr5
   A==;
X-CSE-ConnectionGUID: 844DlFEDTCCtmOodYasEgw==
X-CSE-MsgGUID: 51e0fv3xTK2sNvcGJkeelA==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="78742298"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="78742298"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 22:36:59 -0700
X-CSE-ConnectionGUID: VUIcY1UjSsmbOFys2Bj/DQ==
X-CSE-MsgGUID: uIDO0DJSSO6a4uozE9pQIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="182243746"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 22:36:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 27 Sep 2025 22:36:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 27 Sep 2025 22:36:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 27 Sep 2025 22:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngNNwXUmZ2LsDf9knmO5L5Wu/kQ/Y4/WK+aTx/YTS68DyMm5eB0lrDHcDQwyN9S87UuI79YKcv//n5pbJ/1hJcX0UiPP8LDmygGq6r9moxlGf6cj5ehh/OoyYLQ1TExC4l/vLk+fo2W16kbCcHDBd6Ug//0WsPpKYuL8gzwZbs82LWxEt9AQLLZJMkL3I1Z+lQe8Vh+eX2v4pRg5FzsR0zRLPoaN/X1qc7Dd10IC+bWo8R+qxVul6D0UUPAtbmcu1ZaIDI+LC9AarRmnww/06rFQhLVjJv3NaayOgZmlJxm+1j24dpFhzq7CyqlH5MlzOaemjTJjHBPXXU/6GwZ3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zOOZkesY4g2H7q+m43jZ0R68M7004gEasa0tDeiYeU=;
 b=Ky+UGwz8gPq/ADBqyjyGGffK9efQe4GGHz/I8lusKtJzdN5D8HiQXa47iAUwUlvXy39TunzB6cKW5o/iK1wbEiPCZkgt9NNp2Xq5IkO5WTxZucnOH2tolhJfTvlFEbbkQ5SvhhP0ZOQ9jksej5DpThi8QPWY32kzzfXKmI+kuVVFYINNh5R1MEfqMP6XKalBkpyJIt216fwHDRK+HlLn9sN8aL9/VHgWwATtTXB7IcHubytPWwkyWZIoh6LIxURFruhud0I5JWMo/dr7fyf5ii69Yu2X+VGAcyU+qNWXOObnjRf2+ZId3em6Od2hK0Dr43drEtfLMy1sVMSWu4B9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8679.namprd11.prod.outlook.com (2603:10b6:408:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 05:36:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 05:36:49 +0000
Date: Sun, 28 Sep 2025 13:36:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Qilong <zhangqilong3@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [/dev/zero]  849d5cff4d:
 vm-scalability.throughput 4.0% improvement
Message-ID: <202509281337.d1edd7ab-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: 831a7d37-4122-49d3-1099-08ddfe51056f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/NnvYPjb02HX+MS9E58BOlTua+3H2HYsYl9CH7yJR1jIsUFl5U7tKGDUFM?=
 =?iso-8859-1?Q?1buNXnxhDCel2+Qzva8KiLsDPpTHavUVgVK/lwMUwEbH+ddlVp+wetzzRE?=
 =?iso-8859-1?Q?qi1N0rgYrrC7JR0it1s+41h+kwVwpHgymPrfFOPBuoTxn++Eek6h4RNnhT?=
 =?iso-8859-1?Q?76XPdrp3dB0Ypa/drpHLCosDculV9qdHDNRRj+A9UGoTbKkAmcmCcJJzFd?=
 =?iso-8859-1?Q?T8iTqxSRSph/bqyDJ3tP/ou2PfwLYR4qbUkbjJjwsbozCZJX3fpYNkHOAz?=
 =?iso-8859-1?Q?VivEfATJ3PtzFYEJAy1aHhBPLjC1PCRcGAAqXf4J+u3UkHdoXFhRnG88z7?=
 =?iso-8859-1?Q?lgeFaihbN2IU+DWjujh25sEZZW7eeNUJT3DzDboXO3GDb+MPsXYlgdwePu?=
 =?iso-8859-1?Q?KjAdhAe8r/1WNtJkoeZZ9ebFmx2fdJhSqPK7YnY2rfy4eGa38PxL8QK9nh?=
 =?iso-8859-1?Q?1jdN2XR23pG8asNZCrYN3nKUIRTtTwZtGit1e/iR5Egd6FIGmGuMxD41n0?=
 =?iso-8859-1?Q?jK3hb1LVfsgWxzqdfihoEbAw/rXh1aA7sBEVRUVEEHGvh6qIwj4NbPozSW?=
 =?iso-8859-1?Q?QKs19GYtRCbXLIeac2EeIMJtvfvIG/1RlVYXUNdFV7JSFwe2xwPMgNDfKv?=
 =?iso-8859-1?Q?T5fKGWHrJrD4HPn4RL//Z98O33lysaqCUf2IkdbIvIG1rPWTNhB6fvrx35?=
 =?iso-8859-1?Q?ddR4XrMZvwryv8Qja35x9GzIojbkyP3odIFyZUhmzb9I8zOX8lCeZcUyE4?=
 =?iso-8859-1?Q?km4DwpmTji5hGaicaJ2peB6DLeqtGQ7TDAGznZtyBcu3RKkwesDUyVjuER?=
 =?iso-8859-1?Q?YtIsQSCgUH6NYHKQ/JihuKaFTAPVshrLENzROhS3BpRdHBMRkoBFDYby6K?=
 =?iso-8859-1?Q?e8t8BvWFuFF/d53LS5dmzLuerd5iQzF+sHvOW16nRiVWNshg6vrUnuUXJn?=
 =?iso-8859-1?Q?3kk5/Yae9YzSlQQdl1SS8M34xRZmTx55qgO2dcpA4euCdyv9Fv973rFCT9?=
 =?iso-8859-1?Q?s2dxAG9AcKvgFkXDpExd086uuZ9qYY6e3J/YvQyVZYKTRiYnB88zepfEju?=
 =?iso-8859-1?Q?BIClET8ER3pC4oneg6ZSEozwySGVb32YwMGM331A2hHZtajwd0nuWdtRtR?=
 =?iso-8859-1?Q?lUz6avGWG1Z5UbX4ORMWEIwjCe+rvrQay+95sSs0FEHszwsSqRPDepo0mu?=
 =?iso-8859-1?Q?+JBnaIM6mx7r1U/Spr202d/vYxfvrQTBYGSGedpizpLlCRS4yJ+s0kp3Vb?=
 =?iso-8859-1?Q?Rflj1s3Xq9Gw0lZayV2OMKuk2wBIxqvjtL4+h9vwImxztdlT/a30XJd3el?=
 =?iso-8859-1?Q?dZhlfhZfCUIK1akn/juekQ/OmLsdC7OhHv1/GhvNfMNj6IyMU5DwXh7Wvo?=
 =?iso-8859-1?Q?Lz9q8ylj2zfg6hVdcPqnrOrVjYqHHQW+Y7F7NS3PCxonU7AXVZYDePcbaF?=
 =?iso-8859-1?Q?SPpOULFWfS76tdPnNMsLzsfWZgS18/ioRXLDXjUiFbhbvpQQJHmcP0TUqn?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KwaNrnO3cF4/WionLrhv4p7Ed0DkpuZpifsfUDdCo0EB8qXvOSCiMc1PiF?=
 =?iso-8859-1?Q?xB31gtCCENbj5KIxdyN3zE8x98BIQ3d4sm5MGHk8mwKcgrajv5SRAmnuOS?=
 =?iso-8859-1?Q?I6vSXnqerFLqya101jIGqk7YVNPhwEChvwvArmX894P8aeHI0zQhToMmL+?=
 =?iso-8859-1?Q?ZquatxVsYlB0A782GKcoIn7iuV5/NdfYhOeL64rxCM6JciN0/kDroetkHu?=
 =?iso-8859-1?Q?xeCLwbd3azTwo6D/S69xj+FKc3wpssGnEQDIpa53Dea3C0jx4my+mdweE+?=
 =?iso-8859-1?Q?GvLEgSMCPdjRbHF7hciqRl6bpGgZFVDdeNkT/4VFH4ITLWjT4O4TwW+dGX?=
 =?iso-8859-1?Q?owEsZFtEWsWStkFxML6uBYha3z/3/8bccJy99NaJ7necdqnrgQuxwO1SI5?=
 =?iso-8859-1?Q?uOIZyZOpmdbhyss4FQvanWLS+J3CZTlYp/1YpIGrP7LGBGliGwrRY3r66P?=
 =?iso-8859-1?Q?NRtrZI0HoCmxSP0sAG+4vweJLdyGT/fyE1OfJOI8YMYRCOfegfPKlynUFX?=
 =?iso-8859-1?Q?mfkeuJ7x5tKeRyosPsdeO5KuWOYvHNoiM7Q7WPA9Vh+pKSPvAct/FPyx64?=
 =?iso-8859-1?Q?nkYRVrKSQWZ3noPrVHdepN8MTa9RbS8pVR9ORLQFlY0S3C/xcbnUOa7j0d?=
 =?iso-8859-1?Q?WYRaF6XNG17YdtjBVIJbTZ3KXKBjSurAu9QVwuSYHEBh3cUF2Lt2dbftjP?=
 =?iso-8859-1?Q?HgHMJAlumTXolBRl7o/oF87SLQyQE94fklL8KbVCKmW5DxO+3tDQYqopOj?=
 =?iso-8859-1?Q?IKv6epcgHgPDBK2ORk6iZ4WzbGQlhIGorx2ZKdPMXiGb2pq6Jf7iFhHhSv?=
 =?iso-8859-1?Q?dgCMK2cYvcDKvvkNC6gnZFwsFZtClNiyFQXbQAfw9dzd8VVu0U41puKOgR?=
 =?iso-8859-1?Q?ysb6jXb9+K+YJT5pi3VrhyQ+2ywQ6kDORKeevQ4Rdo2zVmLvSYj50flUKy?=
 =?iso-8859-1?Q?wW13pjY34BaV9JAxN0hJNsT9VZwY6LjgUSdmYKWfan02/F7zf674iOKTEZ?=
 =?iso-8859-1?Q?YStCVL0C3VgT8s8JlIpUwW25QT+MA+Pwdem/fL/7LctAAsTFKjhzWJE0ty?=
 =?iso-8859-1?Q?paNx907C+5Xyid0yYy9DMhUYfQoV9pvVcWDXiNkwDJ/9HYLictxSR6jn6D?=
 =?iso-8859-1?Q?ZjVN6y0A3au1SvIMVlyulF6lc1cteTt3mGbkBgc1LH6OJHA0TTZVb7c4dG?=
 =?iso-8859-1?Q?Q2yXcGEVpf0KPz9Qvz8rXUzTUTTShbVxGlXoXwKtYQ2emwG0T703mf6XFa?=
 =?iso-8859-1?Q?mO4XvTMoGoj4uq1tzTTHrlBuQNP93UQh4UFrBx8wTrF0vmsKGOzluQujhk?=
 =?iso-8859-1?Q?TfHZOTW2Xn55eTmaOD/s/+xO/BN7g3sW7d8VZWuPoR6X5/SWKjPwOarJup?=
 =?iso-8859-1?Q?PtAQjWE0ot+mHJfI4NUA0fYU1ZvzE+gOFbrB9zeVo2U2dr/JGcjagFi6tH?=
 =?iso-8859-1?Q?pVxR1I8tVxE2AMlJ/RRes9ztz1B9oNNtVUBYmlre3fRLwg4diPjFCRyXEm?=
 =?iso-8859-1?Q?N39RLO5Gz4a+Crc5/DB9NEJdKeg5rZ9DBg9Qzdz6/vMNFKKql1CblhA/2O?=
 =?iso-8859-1?Q?FQU1XbTJoiw7/3pka8SAeLNjsLRF1M1j1VMQ4zUkJN9q9QhcC4TtipMf7T?=
 =?iso-8859-1?Q?0TX/DYEHm4HAUbqfAT07Ixa5Laj9gYmPVTprQbMmmHp+gQ8XMckYCzig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 831a7d37-4122-49d3-1099-08ddfe51056f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 05:36:49.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ4x6bWjbYPkmlpdEzwRFpc/0Oke6V8xJkiF5bL81UC6fpnakmx+Ru6jKlMccwx05EvSqOkiWHG0Ex4/YQoHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8679
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 4.0% improvement of vm-scalability.throughput on:


commit: 849d5cff4d48be9146c2bf3c492fc7f434b5ffaa ("/dev/zero: try to align PMD_SIZE for private mapping")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: vm-scalability
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	size: 8T
	test: anon-w-seq-mt
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250928/202509281337.d1edd7ab-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/debian-13-x86_64-20250902.cgz/300s/8T/lkp-cpl-4sp2/anon-w-seq-mt/vm-scalability

commit: 
  337135e612 ("mm: memory-tiering: fix PGPROMOTE_CANDIDATE counting")
  849d5cff4d ("/dev/zero: try to align PMD_SIZE for private mapping")

337135e6124b6d37 849d5cff4d48be9146c2bf3c492 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     26257           +27.2%      33395        uptime.idle
 1.655e+10           +44.1%  2.385e+10        cpuidle..time
  18164696           +40.9%   25599251        cpuidle..usage
     24.01 ±  2%     +10.7       34.74        mpstat.cpu.all.idle%
      0.01 ± 18%      -0.0        0.01 ± 42%  mpstat.cpu.all.iowait%
     34.04            -4.6       29.41        mpstat.cpu.all.sys%
     39.34            -5.9       33.45        mpstat.cpu.all.usr%
   9993182 ± 18%     -41.8%    5815149 ±  5%  numa-numastat.node0.local_node
  10067051 ± 18%     -41.5%    5889995 ±  5%  numa-numastat.node0.numa_hit
  10411741 ± 19%     -43.9%    5835928 ±  3%  numa-numastat.node1.local_node
  10498702 ± 19%     -43.6%    5917927 ±  3%  numa-numastat.node1.numa_hit
   9969246 ± 11%     -40.7%    5915645 ±  5%  numa-numastat.node2.local_node
  10059661 ± 11%     -40.3%    6009851 ±  4%  numa-numastat.node2.numa_hit
   9150835 ±  8%     -36.6%    5799588 ±  4%  numa-numastat.node3.local_node
   9247258 ±  8%     -36.2%    5896057 ±  4%  numa-numastat.node3.numa_hit
      1.50 ± 25%     -54.8%       0.68 ± 64%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      1.50 ± 25%     -54.8%       0.68 ± 64%  perf-sched.total_sch_delay.average.ms
     69.56 ± 10%     +34.3%      93.42 ±  7%  perf-sched.total_wait_and_delay.average.ms
     35646 ± 13%     -31.8%      24313 ±  7%  perf-sched.total_wait_and_delay.count.ms
     68.06 ± 10%     +36.3%      92.74 ±  8%  perf-sched.total_wait_time.average.ms
     69.56 ± 10%     +34.3%      93.42 ±  7%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
     35646 ± 13%     -31.8%      24313 ±  7%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
     68.06 ± 10%     +36.3%      92.74 ±  8%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      2882           -13.9%       2480        turbostat.Avg_MHz
     76.02           -10.6       65.45        turbostat.Busy%
     24.31 ±  2%     +10.7       35.06        turbostat.C1%
     23.98 ±  2%     +44.1%      34.55        turbostat.CPU%c1
      0.16           +12.5%       0.18        turbostat.IPC
   4332164 ±  2%     -13.0%    3766894 ±  2%  turbostat.NMI
    835.40            -4.6%     796.86        turbostat.PkgWatt
     42.68            -4.0%      40.99        turbostat.RAMWatt
  41564180           -14.0%   35736390        meminfo.Active
  41564164           -14.0%   35736374        meminfo.Active(anon)
  40272237           -13.9%   34694186        meminfo.AnonHugePages
  40974856           -14.2%   35170235        meminfo.AnonPages
  85486107           -13.4%   73993462        meminfo.Committed_AS
    107210 ±  3%     -10.6%      95800 ±  2%  meminfo.Mapped
  53937539            -9.4%   48865764        meminfo.Memused
     86016           -15.3%      72857        meminfo.PageTables
    520391 ±  2%     -10.5%     465924 ±  2%  meminfo.Shmem
  91818032           -10.0%   82610731 ±  2%  meminfo.max_used_kB
  24674489 ±  7%     -30.5%   17148972 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.avg
  26875075 ±  8%     -28.3%   19262624 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
  21346887 ±  9%     -32.7%   14374999 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.min
  24674491 ±  7%     -30.5%   17148973 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
  26875075 ±  8%     -28.3%   19262624 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
  21346887 ±  9%     -32.7%   14374999 ± 12%  sched_debug.cfs_rq:/.min_vruntime.min
    119986 ± 49%    +171.7%     326012 ± 28%  sched_debug.cpu.avg_idle.min
    534962 ±  6%     -30.0%     374477 ±  5%  sched_debug.cpu.avg_idle.stddev
     23399 ± 12%     -21.7%      18326 ± 17%  sched_debug.cpu.curr->pid.avg
    -46.12           +74.2%     -80.32        sched_debug.cpu.nr_uninterruptible.min
     22259 ±  7%     -13.8%      19190 ±  9%  numa-meminfo.node0.PageTables
  10527574 ±  8%     -18.3%    8597626 ±  6%  numa-meminfo.node1.Active
  10527573 ±  8%     -18.3%    8597622 ±  6%  numa-meminfo.node1.Active(anon)
  10308896 ±  8%     -18.4%    8415882 ±  6%  numa-meminfo.node1.AnonHugePages
  10425153 ±  8%     -18.5%    8495895 ±  6%  numa-meminfo.node1.AnonPages
     21597 ±  8%     -18.6%      17586 ±  6%  numa-meminfo.node1.PageTables
  10243708 ±  4%     -14.8%    8723183 ±  8%  numa-meminfo.node3.Active
  10243705 ±  4%     -14.8%    8723181 ±  8%  numa-meminfo.node3.Active(anon)
   9679927 ±  4%     -14.3%    8300148 ±  8%  numa-meminfo.node3.AnonHugePages
   9856097 ±  4%     -14.9%    8383987 ±  9%  numa-meminfo.node3.AnonPages
     20743 ±  6%     -17.0%      17207 ±  8%  numa-meminfo.node3.PageTables
    365018 ±  6%     -14.5%     312256 ± 11%  numa-meminfo.node3.Shmem
      0.08            +8.5%       0.08        vm-scalability.free_time
    350533            -1.8%     344223        vm-scalability.median
      6.76 ±  7%      +1.0        7.73 ±  5%  vm-scalability.stddev%
  83567389            +4.0%   86902230        vm-scalability.throughput
    834014 ±  3%     -63.2%     306812        vm-scalability.time.involuntary_context_switches
  90255412           -10.9%   80393120 ±  3%  vm-scalability.time.maximum_resident_set_size
  29416548           -53.8%   13599393        vm-scalability.time.minor_page_faults
     16282           -14.5%      13923        vm-scalability.time.percent_of_cpu_this_job_got
     22682           -13.9%      19518        vm-scalability.time.system_time
     26489           -15.0%      22518        vm-scalability.time.user_time
    282466            -2.2%     276340        vm-scalability.time.voluntary_context_switches
 1.983e+10            -3.8%  1.907e+10        vm-scalability.workload
      5523 ±  7%     -14.0%       4750 ±  9%  numa-vmstat.node0.nr_page_table_pages
  10065144 ± 18%     -41.5%    5891437 ±  5%  numa-vmstat.node0.numa_hit
   9991275 ± 18%     -41.8%    5816591 ±  5%  numa-vmstat.node0.numa_local
   2637715 ±  8%     -17.7%    2170883 ±  6%  numa-vmstat.node1.nr_active_anon
   2611881 ±  8%     -17.9%    2144613 ±  6%  numa-vmstat.node1.nr_anon_pages
      5044 ±  8%     -17.7%       4149 ±  6%  numa-vmstat.node1.nr_anon_transparent_hugepages
      5386 ±  8%     -17.9%       4420 ±  5%  numa-vmstat.node1.nr_page_table_pages
   2635825 ±  8%     -17.7%    2169762 ±  6%  numa-vmstat.node1.nr_zone_active_anon
  10498075 ± 19%     -43.6%    5917099 ±  3%  numa-vmstat.node1.numa_hit
  10411114 ± 19%     -44.0%    5835100 ±  3%  numa-vmstat.node1.numa_local
  10055965 ± 11%     -40.2%    6009627 ±  4%  numa-vmstat.node2.numa_hit
   9965551 ± 11%     -40.6%    5915421 ±  5%  numa-vmstat.node2.numa_local
   2591872 ±  4%     -15.4%    2192261 ±  9%  numa-vmstat.node3.nr_active_anon
   2495697 ±  4%     -15.5%    2107722 ±  9%  numa-vmstat.node3.nr_anon_pages
      4788 ±  4%     -14.9%       4075 ±  9%  numa-vmstat.node3.nr_anon_transparent_hugepages
      5184 ±  5%     -16.7%       4320 ±  9%  numa-vmstat.node3.nr_page_table_pages
     91128 ±  6%     -14.3%      78122 ± 11%  numa-vmstat.node3.nr_shmem
   2589695 ±  4%     -15.4%    2191057 ±  9%  numa-vmstat.node3.nr_zone_active_anon
   9245976 ±  8%     -36.2%    5895181 ±  4%  numa-vmstat.node3.numa_hit
   9149554 ±  8%     -36.6%    5798712 ±  4%  numa-vmstat.node3.numa_local
  10404886           -14.1%    8933816        proc-vmstat.nr_active_anon
  10256454           -14.3%    8792592        proc-vmstat.nr_anon_pages
     19688           -14.0%      16940        proc-vmstat.nr_anon_transparent_hugepages
   3539789            +3.6%    3668211        proc-vmstat.nr_dirty_background_threshold
   7088233            +3.6%    7345391        proc-vmstat.nr_dirty_threshold
   1036780            -1.3%    1023061        proc-vmstat.nr_file_pages
  35651440            +3.6%   36925397        proc-vmstat.nr_free_pages
  35387145            +3.7%   36698529        proc-vmstat.nr_free_pages_blocks
     27022 ±  3%     -10.4%      24203        proc-vmstat.nr_mapped
     21520           -15.1%      18262        proc-vmstat.nr_page_table_pages
    130154 ±  2%     -10.5%     116430 ±  2%  proc-vmstat.nr_shmem
  10404867           -14.1%    8933804        proc-vmstat.nr_zone_active_anon
  39880029           -40.5%   23722220        proc-vmstat.numa_hit
     17240 ±  3%     -38.6%      10591 ±  3%  proc-vmstat.numa_huge_pte_updates
  39532388           -40.9%   23374683        proc-vmstat.numa_local
   8959515 ±  3%     -38.3%    5528550 ±  2%  proc-vmstat.numa_pte_updates
 4.418e+09            -3.8%   4.25e+09        proc-vmstat.pgalloc_normal
  30619908           -51.7%   14801549        proc-vmstat.pgfault
 4.418e+09            -3.8%   4.25e+09        proc-vmstat.pgfree
   8566630            -3.5%    8268960        proc-vmstat.thp_fault_alloc
     17393           +14.0%      19837        proc-vmstat.unevictable_pgs_culled
      3.66            -5.0%       3.48        perf-stat.i.MPKI
 7.052e+10            -4.1%  6.762e+10        perf-stat.i.branch-instructions
     72.05            -3.8       68.21        perf-stat.i.cache-miss-rate%
 8.114e+08            -9.0%  7.386e+08        perf-stat.i.cache-misses
 1.122e+09            -3.7%   1.08e+09        perf-stat.i.cache-references
      9741           -14.1%       8368        perf-stat.i.context-switches
      2.98           -10.9%       2.65        perf-stat.i.cpi
  6.62e+11           -14.7%  5.646e+11        perf-stat.i.cpu-cycles
    813.26            -6.2%     762.62        perf-stat.i.cycles-between-cache-misses
 2.209e+11            -4.1%  2.118e+11        perf-stat.i.instructions
      0.34           +12.3%       0.38        perf-stat.i.ipc
    103638           -51.9%      49830        perf-stat.i.minor-faults
    103640           -51.9%      49833        perf-stat.i.page-faults
      3.67            -4.8%       3.49        perf-stat.overall.MPKI
      0.02            +0.0        0.02        perf-stat.overall.branch-miss-rate%
     72.21            -3.7       68.49        perf-stat.overall.cache-miss-rate%
      2.99           -10.6%       2.67        perf-stat.overall.cpi
    813.80            -6.0%     764.59        perf-stat.overall.cycles-between-cache-misses
      0.33           +11.8%       0.37        perf-stat.overall.ipc
 6.797e+10            -3.9%  6.532e+10        perf-stat.ps.branch-instructions
 7.811e+08            -8.5%  7.146e+08        perf-stat.ps.cache-misses
 1.082e+09            -3.6%  1.043e+09        perf-stat.ps.cache-references
      9507           -14.6%       8121        perf-stat.ps.context-switches
 6.357e+11           -14.0%  5.464e+11        perf-stat.ps.cpu-cycles
 2.129e+11            -3.9%  2.046e+11        perf-stat.ps.instructions
    100387           -51.9%      48314        perf-stat.ps.minor-faults
    100387           -51.9%      48314        perf-stat.ps.page-faults
 6.452e+13            -4.1%   6.19e+13        perf-stat.total.instructions
     71.91            -2.3       69.61        perf-profile.calltrace.cycles-pp.do_access
     44.42            -0.7       43.70        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     44.22            -0.7       43.52        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     44.38            -0.7       43.67        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     44.38            -0.7       43.67        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     44.15            -0.7       43.46        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     43.91            -0.6       43.35        perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     43.32            -0.5       42.77        perf-profile.calltrace.cycles-pp.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     39.76            -0.5       39.25        perf-profile.calltrace.cycles-pp.clear_page_erms.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault
     41.64            -0.5       41.17        perf-profile.calltrace.cycles-pp.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.80            -0.0        0.78        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.72            -0.0        0.70        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.vma_alloc_anon_folio_pmd
      0.77            +0.0        0.80        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clear_page_erms.folio_zero_user.vma_alloc_anon_folio_pmd.__do_huge_pmd_anonymous_page
      0.56            +0.0        0.58 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clear_page_erms.folio_zero_user.vma_alloc_anon_folio_pmd
      0.52            +0.0        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clear_page_erms.folio_zero_user
      0.52            +0.0        0.55 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clear_page_erms
      0.27 ±100%      +0.4        0.65 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.27 ±100%      +0.4        0.65 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.27 ±100%      +0.4        0.65 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.09 ±223%      +0.5        0.58 ±  6%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty
      0.09 ±223%      +0.5        0.58 ±  6%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.09 ±223%      +0.5        0.58 ±  6%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work
      0.09 ±223%      +0.5        0.58 ±  6%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.09 ±223%      +0.5        0.58 ±  6%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.09 ±223%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.09 ±223%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.09 ±223%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.drm_fbdev_shmem_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.09 ±223%      +0.5        0.62 ±  6%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ±223%      +0.5        0.62 ±  6%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.59 ± 23%      +1.8        3.37 ±  8%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.59 ± 23%      +1.8        3.36 ±  8%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.59 ± 23%      +1.8        3.37 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.59 ± 23%      +1.8        3.37 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.59 ± 23%      +1.8        3.37 ±  8%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.62 ± 23%      +1.8        3.42 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.62 ± 23%      +1.8        3.43 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.62 ± 23%      +1.8        3.43 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.62 ± 23%      +1.8        3.43 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.63 ± 23%      +1.8        3.45 ±  8%  perf-profile.calltrace.cycles-pp.common_startup_64
      2.93 ± 24%      +3.4        6.36 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
     64.19            -1.5       62.66        perf-profile.children.cycles-pp.do_access
     42.58            -0.8       41.75        perf-profile.children.cycles-pp.do_rw_once
     44.46            -0.7       43.74        perf-profile.children.cycles-pp.asm_exc_page_fault
     44.40            -0.7       43.69        perf-profile.children.cycles-pp.exc_page_fault
     44.40            -0.7       43.69        perf-profile.children.cycles-pp.do_user_addr_fault
     44.24            -0.7       43.54        perf-profile.children.cycles-pp.handle_mm_fault
     44.17            -0.7       43.47        perf-profile.children.cycles-pp.__handle_mm_fault
     40.18            -0.6       39.62        perf-profile.children.cycles-pp.clear_page_erms
     43.91            -0.6       43.35        perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
     43.32            -0.5       42.78        perf-profile.children.cycles-pp.vma_alloc_anon_folio_pmd
     42.40            -0.5       41.88        perf-profile.children.cycles-pp.folio_zero_user
      0.18 ±  3%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.do_anonymous_page
      1.06            -0.1        0.97        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      1.07            -0.1        0.98        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.91            -0.1        0.82        perf-profile.children.cycles-pp.get_page_from_freelist
      0.88            -0.1        0.80        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.71            -0.1        0.64        perf-profile.children.cycles-pp.prep_new_page
      0.16 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.11 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.charge_memcg
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.11 ±  3%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.try_charge_memcg
      0.17 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.rmqueue_pcplist
      0.17 ±  3%      -0.0        0.15        perf-profile.children.cycles-pp.rmqueue
      0.13 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.folio_add_lru
      0.12            -0.0        0.11        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.lru_add
      0.06 ± 11%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.06 ± 11%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.schedule
      0.36            +0.0        0.38        perf-profile.children.cycles-pp.task_tick_fair
      0.58            +0.0        0.60        perf-profile.children.cycles-pp.sched_tick
      0.06 ± 11%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.sched_balance_rq
      0.03 ± 70%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.04 ± 71%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__pick_next_task
      0.02 ± 99%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.02 ±141%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.01 ±223%      +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.91            +0.1        0.97 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.16 ± 14%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.wait_for_lsr
      0.18 ± 14%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.serial8250_console_write
      0.16 ± 14%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.free_unref_folios
      0.29 ± 11%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.vprintk_emit
      0.28 ± 11%      +0.1        0.36 ±  8%  perf-profile.children.cycles-pp.devkmsg_emit
      0.18 ± 12%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.folios_put_refs
      0.18 ± 14%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.18 ± 14%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.28 ± 11%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.console_flush_all
      0.28 ± 11%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.console_unlock
      0.28 ± 11%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.21 ± 13%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.21 ± 13%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.21 ± 13%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.20 ± 12%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.19 ± 12%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.21 ± 11%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__munmap
      0.21 ± 11%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__vm_munmap
      0.21 ± 11%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.48 ±  9%      +0.1        0.62 ±  6%  perf-profile.children.cycles-pp.process_one_work
      0.49 ± 10%      +0.1        0.62 ±  6%  perf-profile.children.cycles-pp.worker_thread
      0.44 ± 11%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.44 ± 11%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.44 ± 11%      +0.1        0.58 ±  7%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.44 ± 11%      +0.1        0.58 ±  7%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.44 ± 11%      +0.1        0.58 ±  7%  perf-profile.children.cycles-pp.memcpy_toio
      0.44 ± 11%      +0.1        0.59 ±  6%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.44 ± 11%      +0.1        0.59 ±  6%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.44 ± 11%      +0.1        0.59 ±  6%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
      0.44 ± 11%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.commit_tail
      0.44 ± 11%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.44 ± 11%      +0.1        0.58 ±  6%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.50 ±  9%      +0.1        0.65 ±  5%  perf-profile.children.cycles-pp.kthread
      0.50 ±  9%      +0.1        0.65 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.50 ±  9%      +0.1        0.65 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
      3.52 ± 10%      +1.8        5.28 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.60 ± 23%      +1.8        3.38 ±  8%  perf-profile.children.cycles-pp.pv_native_safe_halt
      1.60 ± 23%      +1.8        3.39 ±  8%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      1.60 ± 23%      +1.8        3.39 ±  8%  perf-profile.children.cycles-pp.acpi_safe_halt
      1.60 ± 23%      +1.8        3.39 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.60 ± 23%      +1.8        3.39 ±  8%  perf-profile.children.cycles-pp.acpi_idle_enter
      1.60 ± 23%      +1.8        3.40 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
      1.62 ± 23%      +1.8        3.43 ±  8%  perf-profile.children.cycles-pp.start_secondary
      1.62 ± 23%      +1.8        3.44 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.63 ± 23%      +1.8        3.45 ±  8%  perf-profile.children.cycles-pp.do_idle
      1.63 ± 23%      +1.8        3.45 ±  8%  perf-profile.children.cycles-pp.common_startup_64
      1.63 ± 23%      +1.8        3.45 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
     40.75            -1.1       39.66        perf-profile.self.cycles-pp.do_rw_once
     39.20            -0.6       38.63        perf-profile.self.cycles-pp.clear_page_erms
     10.50            -0.3       10.24        perf-profile.self.cycles-pp.do_access
      0.98            -0.1        0.92        perf-profile.self.cycles-pp.folio_zero_user
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.14 ± 13%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.free_unref_folios
      0.43 ± 12%      +0.1        0.57 ±  6%  perf-profile.self.cycles-pp.memcpy_toio
      1.47 ± 24%      +1.7        3.19 ±  8%  perf-profile.self.cycles-pp.pv_native_safe_halt




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


