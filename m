Return-Path: <linux-kernel+bounces-826173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE95B8DBD5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A787A5F94
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939F2D6E73;
	Sun, 21 Sep 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id+do7dk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869AE2D130B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461395; cv=fail; b=c+a9P9YHhkVeIXgLfECOUW5Uzv13SJzPb1BjJpKJNmpjr01MyJS6jn9HjTBAQdYb6JRQRRbe6bdmqxcVru5emLC76HuIxISVMb6YG8Hq9fWYKGQp1Wv5M63R1gNH8n2n9Oraq3kFsh10p9EaLlSz5uQWFVdYi8XjWrX5CcGt7GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461395; c=relaxed/simple;
	bh=dJHd5eUFWoV4gKiXw3B/RJYTHXOmxrC7IpyO3qbsBrM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Izdl8sGGyaqSx8lBGO1zwwI2ImdHoxK7g1w0FucB4cI3IaTAYvzA5iGcriE5QWbL1NOsr4RB8ugeF14+b3MXUbm8GYdMs+KDvxsFyOuo0Fzn2UlZS5P6N3mP94w1QLRGFZJEAAZGa5y6l9j1f6AidbMe1v3VsnXHBziIEabvs0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id+do7dk; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758461394; x=1789997394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dJHd5eUFWoV4gKiXw3B/RJYTHXOmxrC7IpyO3qbsBrM=;
  b=Id+do7dkyotzWDfUbQakxU/FYqtONJcciPnQNSNuj0m7nQ+NiC8DzDq7
   LQLNyxs48SXOOLIIorGII8Ani6bC3d1FJh+0g5H7X0A0OrvXANzZiWRad
   TdQbIbkF23MSdXQAEit/bPZz6eOHMevnm5wFm4XADORS2wwf4PQ5OBfqk
   QEHIy/5WINOJfgNBIH3LDr+MK3TFFr3qwRua6bZUyk6AChO51t4NxqVEW
   9JjznCrjRCXZlGoyGwueOD5hhnrguWdThU6HLd/jrox98SOxP1vL+ymnR
   p5Swh2/mCvEiyKtfdPYi78aG0k0BZN1YNID4dmFEL4faPAgkHfcgZTW0d
   Q==;
X-CSE-ConnectionGUID: ZPQPpzazS9OGy7CdVSS+nQ==
X-CSE-MsgGUID: KQlmfa3kRG+I/wFtwSYJhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60685938"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60685938"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 06:29:53 -0700
X-CSE-ConnectionGUID: 6lfAbDY2RZqtUetM8UUZ7Q==
X-CSE-MsgGUID: xEoIOhJwTGyLBSBTNBRzjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="175390367"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 06:29:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 06:29:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 21 Sep 2025 06:29:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 06:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY9hPM/H6fZFyQRNZqHjHfxpDdxXKKPcq+asJKLEdlBfBhAE73VQgeQrwdHwY/l1dDDWoNzNl4iVs9s4wDV8OKcxnoQcwIjS6DVEUU+IJl/23qm4xBnAGg59Pzo0Gmkiepy7Rs1ehsMJFQqzZKCVSUH3HmVVn7CBf4bmFhzaafXaxdfcNfYn6jvJSIn1pIh0bIBzBgzXnmSKb9bAlU8oUHwOEtCURTBMLfq13iJXgckLcMbiQi1//BmwtFThpvxIWf6iPN0EynejLZfwNbUvTtsAoXj99J9547CF2fK8un+gxTD0Qc7+XmDnJ2KABiyc0vhSOj071dOfClCKLkRvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1DRWT+SwQqiIc9imBiTdp90wkN/mdyIkekV94dS9FA=;
 b=cbIcWopZVP8v7OwwBZU+nFIe6cYt7fGtl4HhtKQGpht1+ImoLxS9TbVCOGEx3quR1wYfvIAmXAFz9qfVFoG4BebIgx0uUe39mVhukEFuF4H9b31AWx6ppDWX8iQ3wqrlyzV2p1pknfUtEPDMXrZ6NfxOSjKGvhumq5+hO2DCqydXhaz6KCsu+ACHxXShLVDyptn0h6hgCXUTWpkuT5zGeO6XaQKN5qAJ1ofpXKz4bAIiNV7apX9sVDKjtCYOAVa21BEILhNsbFKzqbRM1XjWZ2adgIlqzKakybtV+sby4cRkN01k5niVJSpFpiKBihMp10GgM/AO3bdhmbmRYis2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 13:29:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 13:29:44 +0000
Date: Sun, 21 Sep 2025 21:29:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [peterz-queue:sched/cleanup] [sched]  cfcabf4524:
 WARNING:possible_recursive_locking_detected
Message-ID: <202509212119.eab661a8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 545d1b21-a7b1-4e3d-dd03-08ddf912ed1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3U/FEVCEodKm8Htc0zbaXWQ/A6Ewmq14wKdC9IfyjqLBD3HrGSSuSDWipzKN?=
 =?us-ascii?Q?jW/arY0H9WibFW8A9J7OLvtBvQKX/MwxoZrQK9xUWwWzGyMuz3DgB1o+5jQh?=
 =?us-ascii?Q?BtutvBttu5rztM76gA//XQmD40V9Qxe+6r+OlWzffjfa5dOavHg3bAB2W3DY?=
 =?us-ascii?Q?pygKV0Xw7ec8dSKwk5n5nS/rBhozsnkWBXrmFsHk/1C+dDKed+9shsc41aUx?=
 =?us-ascii?Q?+DwjAf2SsHSocdRYkwJUU9fL1z+iKEXoiKc/SsOtohIwpLI0WuOJrBJucBmE?=
 =?us-ascii?Q?JkoJybPKJHXmMrX7wFAkTIyjQUIcMBRwuWMtfDMgMYXPvZv4XsZS/ZB7AmkO?=
 =?us-ascii?Q?FTeiveY9jFejDefEP8bgg+mTZ7amaIiO6xWJz5OuGuJHOl2L2T3fUMGlQITu?=
 =?us-ascii?Q?yzwAATHcQKvyIKGYmyEDJxACTI6e52Mf6Sj2ldaJTbg3wGnqifwGLADYvAvv?=
 =?us-ascii?Q?4kgPgskGCbtWG2p4bHjRAB+GrQ1O09+oK5c/vbfd5tR3wj8EO9w7UkH4LrnY?=
 =?us-ascii?Q?ZDrtzraD3Zz1tVvG12kNZr97NQxY1PybFfr0dDbcs/qDc7ijYHt5XzgHKs06?=
 =?us-ascii?Q?Gevf203lfo6mIkvBGlWBJ6msfaOmTIJSe+YKauml98K0kWkBnbbC/BBGAjAc?=
 =?us-ascii?Q?UuMLT9fmNn2tGjt8nM7ZZT9LLaKqt0NJjK3fxpQYMheSjibNdwK587cgd7p/?=
 =?us-ascii?Q?PLrtZvM/5sPMzPCILkkfaPxmOzuhk386C8Phg8S5kUQ0GVPSHsxn/QGgZD5j?=
 =?us-ascii?Q?EgEmPyMSLqsUG5asPLkCM5mC7QmR21JviptAXQU4UHFIi/DAl5O5QgrflEa+?=
 =?us-ascii?Q?lKrhpFoObCB3ILTT1ZAZn1JqOKe9ysX5e0wlgpTqwk5n9krcq9w3oMmzLs2I?=
 =?us-ascii?Q?lv42xP47nw9fQOf+fE0iYSjlgN2S1BNe9TEX830woBSw9UrEZ3yP2SkIDUel?=
 =?us-ascii?Q?bSxD1vsJqKpmySnDeZ9HH+I2SMb0+YWj+dTEJH7KfOBJTjRlzp9M5X8cXgr9?=
 =?us-ascii?Q?hPWNfIPr4XXWFmn93A+m8FbjWDfeLPepbKY3a7KTWcOpk0l7/twPE+Zmb/A5?=
 =?us-ascii?Q?T8Z52PDxqKT8ncD8mxqb7lHldkrHnYqFbyTUkfgX/J2iW3WHixgP+TbQ28w3?=
 =?us-ascii?Q?bdxzMPxl4fiaVkFliC2UUuV8BT6bhbE46maNQdFTkYx6X2oL1YP/dw6esShz?=
 =?us-ascii?Q?gOiC3nEvt6Q55l+joIjXXm+Gyt+d7alNnuSeBJTwnI2F9zxrGNzrbBqM2hph?=
 =?us-ascii?Q?Q5jczapxe+nhwBN78K5da6meiY+l2d6pCX+1wRkhTJFhaX1D08xEhu8KfKsM?=
 =?us-ascii?Q?pIkOuttfouptXLteaLBY9FLbVwXPyNeJVdmOgEqaG9ZMbibUUKhNnZOpvGTD?=
 =?us-ascii?Q?90HR1AFWSTNV8OKuKoRE1dgSeTJQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOAc2xNfQ1GyMff7dLkmk4IW6xUd+ZOt5GfujdM8WxtF2EXBcyDy2BpThX6C?=
 =?us-ascii?Q?qKbHsE9L+2dSPhVwyGmIP0y2JINgmNme1b0KNlTB3ZMRKo0A1+3xmz+zXGQR?=
 =?us-ascii?Q?+LZjMWaw5Y3IKfsDkCDJNOOqhMBsOHzxrT80Hr2PSmMwYJekc+wsTAVqwPiM?=
 =?us-ascii?Q?MonKo+iuUjhNdG/+v8x9PRZ+8chZUT/15sliMJZLiWlrhuCg4vlsbuhQZgKk?=
 =?us-ascii?Q?/iZcxX+dlqgkfc6AOdBB2bE7qIjPpcmNYEvts+5MM9RfJBZ/jXQ6GoulFtIF?=
 =?us-ascii?Q?E0hlATe/EIvxiUKriaB4NO5iFrgJH3GfhdfHe7O7iKh74ra3Cu7RDMGLBn8h?=
 =?us-ascii?Q?uYUWTReOPh7LMqC7W74N4erLrCKQMfMLsdOYnl1C9NmFAOc+rnXXMqAVdtL7?=
 =?us-ascii?Q?Uxk3k9Ilmz1TaNRSDGCB9V28TohC5fr85mxaWoP5dOavQVlD0eHpS0lFGta6?=
 =?us-ascii?Q?51K3tNCwfyZ+UhL95dcuIK41HyJ2Ev2Wxw8K+rJWqrkOIem7ebT+v+LnMzLu?=
 =?us-ascii?Q?lT1Tdoqc9Rd/qkcqZRCfBCVOeQ2OoiZ6MU9XO57H/yjAc5zv0jI+SFK9F+kK?=
 =?us-ascii?Q?+qi3kCP3pVeNKtBqfgGsDqke7WVYNklS2piOFD1FZgheiGOV0ERsH7JieOUq?=
 =?us-ascii?Q?COeYnJHdSiZJzz+1BUUByU+NlWgx37tT8zZeaYtYUskDda2Rd9Y0JpFvw375?=
 =?us-ascii?Q?aLxhNyKR9AtAlSEe6MWogRp8QcGS5eL5V0ZEplIOrEDlM7wQJelltFF5OTwH?=
 =?us-ascii?Q?zynWzReTNCP8YAyy/RAMwju/2bkyJHeXXqKSM/NEE+C3hfv90UD/tY8a2FGR?=
 =?us-ascii?Q?TdHeCOJTEtYKUpe7GUJiSIqrHHH1QXWdyIMmAFrEsCnDsKIMfwusaG4JAbGu?=
 =?us-ascii?Q?s26UMrsM0KjOs/XyOLfyMNux8IPp2Q7TNVP9/U68SU6ym1DEgcLBz5uoRHvy?=
 =?us-ascii?Q?1ac00Epl+AsmpmP96q44mG/hWTQbsH4ez/CfTgfR4qZjhh2cfWgRDHCZc7Pn?=
 =?us-ascii?Q?7MHVxp+d974/Alk+JQaTDLbuogaZPIjqLEWTBZzAPfI4zqmiZbReOt5gzSq8?=
 =?us-ascii?Q?+RPQSoFTZliGRQawpyv7mSmbQpvyhrdN2Iw9T5LsR6t3CURL/5gh0p+U6hoS?=
 =?us-ascii?Q?U5tbPoCf35Qj00Xdp9OBFsv4jG32aBzNFABNCEP805Ruw3Cae8pZGykIwnUA?=
 =?us-ascii?Q?Y8gRPfLUzMH3aw4m1LbMKfMoBxECcB0a7FiFWzDYgfLFpwBeB+y5ysMPWzMh?=
 =?us-ascii?Q?L6kmsAGoSyAxBlG9X9oplKuYWNTYk68vhbBtzEWvBzhIouVd3vP7ZXNoPJta?=
 =?us-ascii?Q?lpPwz5F8mfZeuJBq/A8niucu96qQU/wxhd448yaKo2Etsn4s1xuTLdWJ661F?=
 =?us-ascii?Q?CfbnsALrnjd/QDIuqlqhR+WT4HZPE8M0zGHlCiT6YjGFHiE+qQEUA7SYXO8O?=
 =?us-ascii?Q?nk5yNrHX4VAXZITCZtlbrWtB4RFJxTQ7CH28ghziTByhcIYY+DOyia2nG005?=
 =?us-ascii?Q?bwEEjPEW7+VYxSbBkwouhWtYIb+bd4dfQ5xne/xvGnda1GA6r1qCGkwciDWB?=
 =?us-ascii?Q?GIzLW2zg3vVsUH3DlPpUEi0zERJ3TXv+y5u1ssobV+zW50MfHe4wWMg5fL8o?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 545d1b21-a7b1-4e3d-dd03-08ddf912ed1d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 13:29:44.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjQ9OgdNbUKWyc2PeIoFckiBe+EYwJ99IqgvOwHq/hiMXEF76vxo3L6fxDeyekcwYYufGS60kjuPfrnDm6Lifw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: cfcabf45249df741fa733f41f7dbf98534e31b6b ("sched: Fix do_set_cpus_allowed() locking")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/cleanup

in testcase: locktorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug



config: x86_64-randconfig-076-20250917
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509212119.eab661a8-lkp@intel.com


[   95.960389][   T23]
[   95.961013][   T23] ============================================
[   95.961890][   T23] WARNING: possible recursive locking detected
[   95.962817][   T23] 6.17.0-rc4-00016-gcfcabf45249d #1 Tainted: G                T
[   95.967338][   T23] --------------------------------------------
[   95.976369][   T23] migration/1/23 is trying to acquire lock:
[ 95.977282][ T23] ffff8883a9dfa198 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[   95.978743][   T23]
[   95.978743][   T23] but task is already holding lock:
[ 95.979934][ T23] ffff8883a9dfa198 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[   95.981409][   T23]
[   95.981409][   T23] other info that might help us debug this:
[   95.982674][   T23]  Possible unsafe locking scenario:
[   95.982674][   T23]
[   95.984064][   T23]        CPU0
[   95.984613][   T23]        ----
[   95.985206][   T23]   lock(&rq->__lock);
[   95.985896][   T23]   lock(&rq->__lock);
[   95.986590][   T23]
[   95.986590][   T23]  *** DEADLOCK ***
[   95.986590][   T23]
[   95.988030][   T23]  May be due to missing lock nesting notation
[   95.988030][   T23]
[   95.989277][   T23] 3 locks held by migration/1/23:
[ 95.990078][ T23] #0: ffff888175d905b8 (&p->pi_lock){-.-.}-{2:2}, at: __balance_push_cpu_stop (kernel/sched/sched.h:1520 kernel/sched/sched.h:1847 kernel/sched/core.c:8098) 
[ 95.991598][ T23] #1: ffff8883a9dfa198 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[ 95.993052][ T23] #2: ffffffff8cd48ba0 (rcu_read_lock){....}-{1:3}, at: cpuset_cpus_allowed_fallback (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 kernel/cgroup/cpuset.c:4122) 
[   95.996014][   T23]
[   95.996014][   T23] stack backtrace:
[   95.996988][   T23] CPU: 1 UID: 0 PID: 23 Comm: migration/1 Tainted: G                T   6.17.0-rc4-00016-gcfcabf45249d #1 PREEMPT
[   95.996998][   T23] Tainted: [T]=RANDSTRUCT
[   95.997001][   T23] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 95.997005][ T23] Stopper: __balance_push_cpu_stop+0x0/0x320 <- balance_push (kernel/sched/core.c:8177) 
[   95.997018][   T23] Call Trace:
[   95.997022][   T23]  <TASK>
[ 95.997027][ T23] __dump_stack (lib/dump_stack.c:95) 
[ 95.997034][ T23] dump_stack_lvl (lib/dump_stack.c:123) 
[ 95.997041][ T23] dump_stack (lib/dump_stack.c:130) 
[ 95.997046][ T23] print_deadlock_bug (kernel/locking/lockdep.c:3043) 
[ 95.997054][ T23] __lock_acquire (kernel/locking/lockdep.c:?) 
[ 95.997062][ T23] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 95.997070][ T23] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271) 
[ 95.997080][ T23] lock_acquire (kernel/locking/lockdep.c:5868) 
[ 95.997085][ T23] ? raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[ 95.997091][ T23] ? __lock_acquire (kernel/locking/lockdep.c:?) 
[ 95.997096][ T23] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 95.997102][ T23] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271) 
[ 95.997109][ T23] ? raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[ 95.997114][ T23] _raw_spin_lock_nested (kernel/locking/spinlock.c:378) 
[ 95.997121][ T23] ? raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[ 95.997127][ T23] raw_spin_rq_lock_nested (kernel/sched/core.c:638) 
[ 95.997133][ T23] __task_rq_lock (include/linux/sched.h:2226) 
[ 95.997141][ T23] do_set_cpus_allowed (kernel/sched/sched.h:1825 kernel/sched/core.c:2742) 
[ 95.997149][ T23] ? cpuset_cpus_allowed_fallback (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 kernel/cgroup/cpuset.c:4122) 
[ 95.997157][ T23] cpuset_cpus_allowed_fallback (kernel/cgroup/cpuset.c:?) 
[ 95.997164][ T23] select_fallback_rq (kernel/sched/core.c:?) 
[ 95.997171][ T23] __balance_push_cpu_stop (kernel/sched/core.c:8103) 
[ 95.997178][ T23] ? __do_trace_sched_move_numa (kernel/sched/core.c:8091) 
[ 95.997183][ T23] cpu_stopper_thread (kernel/stop_machine.c:513) 
[ 95.997192][ T23] ? cpu_stop_should_run (kernel/stop_machine.c:488) 
[ 95.997200][ T23] smpboot_thread_fn (kernel/smpboot.c:?) 
[ 95.997210][ T23] ? smpboot_thread_fn (kernel/smpboot.c:?) 
[ 95.997218][ T23] kthread (kernel/kthread.c:465) 
[ 95.997225][ T23] ? smpboot_unregister_percpu_thread (kernel/smpboot.c:103) 
[ 95.997233][ T23] ? __do_trace_sched_kthread_stop_ret (kernel/kthread.c:412) 
[ 95.997240][ T23] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 95.997247][ T23] ? __do_trace_sched_kthread_stop_ret (kernel/kthread.c:412) 
[ 95.997254][ T23] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   95.997263][   T23]  </TASK>
[  155.023652][    C0] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!
[  155.059744][    C0] Showing busy workqueues and worker pools:
[  155.064892][    C0] workqueue events: flags=0x0
[  155.065729][    C0]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=3 refcnt=5
[  155.065748][    C0]     in-flight: 9:work_for_cpu_fn BAR(476) ,10:vmstat_shepherd
[  155.065802][    C0]     pending: e1000_watchdog
[  155.065820][    C0] workqueue events_unbound: flags=0x2
[  155.069920][    C0]   pwq 10: cpus=0-1 node=0 flags=0x4 nice=0 active=1 refcnt=2
[  155.069941][    C0]     pending: crng_reseed
[  155.069956][    C0] workqueue events_power_efficient: flags=0x82
[  155.072924][    C0]   pwq 9: cpus=0-1 node=0 flags=0x4 nice=0 active=4 refcnt=5
[  155.072944][    C0]     pending: do_cache_clean, 2*neigh_periodic_work, check_lifetime
[  155.072972][    C0]   pwq 10: cpus=0-1 node=0 flags=0x4 nice=0 active=2 refcnt=3
[  155.072984][    C0]     pending: 2*neigh_managed_work
[  155.072996][    C0] workqueue mm_percpu_wq: flags=0x8
[  155.078563][    C0]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
[  155.078581][    C0]     pending: vmstat_update
[  155.078679][    C0] workqueue ipv6_addrconf: flags=0x6000a
[  155.081392][    C0]   pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=4
[  155.081409][    C0]     pending: addrconf_verify_work
[  155.081427][    C0] pool 2: cpus=0 node=0 flags=0x0 nice=0 hung=57s workers=4 idle: 223 94
[  155.081475][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250921/202509212119.eab661a8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


