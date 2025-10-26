Return-Path: <linux-kernel+bounces-870212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F64C0A320
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3900C3B0D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C21F1513;
	Sun, 26 Oct 2025 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hONadNlj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A692AE8E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457686; cv=fail; b=QJsllBMh+ZWHVvwImSma6ez5pAbKpDNkIdHan5sZLo58a11IeDofmmNu60eIr3QeNsaICWu1FPvJv9XXn3B0hG1PDfnGXImpNhFTm7JnPv34eC5N9yf3MzH0qJ8hoX3d0lv/958ZQN3/KghFA+j6zwAoJPFqTUQGmoWcRUmSV5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457686; c=relaxed/simple;
	bh=CLYeWPAkTAsfY+XZ/cjCmKFBW8APcleCR0PhPlPPn9g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=f9ex/hmNRS7gLq3dIWirQiI3I1easZRQQSh9w/MNAmk5fvgb91m6OJVt80iUDu4XNgYjSYTcmMaCiqRUK5SSSuz0nZnXsNMOEYMq3qvGwhRGO+1V9AFFLo7AzydY6bRzSgpxZdT60aL5TyvcVCogf4I1fAfKkck6tJuhQ8j0Ong=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hONadNlj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761457684; x=1792993684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CLYeWPAkTAsfY+XZ/cjCmKFBW8APcleCR0PhPlPPn9g=;
  b=hONadNljkLms6GUrbjkdwyweL9VRV42fpWNn3zlYVHU/4oS4f5NfNtVy
   0FbkE8MFYoov/QkKdCo24/pptMmmSTzaj/tYG0Iwi08HEWc1NtEQM06v5
   5Qn43a5LHFZtzCQqWUwxAtfGtuq3MnYId2BfKScd8Ho2VK+BtVMWBxhjy
   stuk/FeP8/a6g27fnHui41uUIBMmS9WcgFxknRvpBUrWauMGRrKxkSCln
   TO7RU5dxIogGHx7iwQC2DXrCfXQZcSvt1vJMFsYGELU8Ow0wvaNR6BLNN
   UlaBqznwlBxwWeBRyb4jOQYnTECW1EeArzO4oea+oknAHai1vkKDUbCFu
   Q==;
X-CSE-ConnectionGUID: 7iDrpEIcQFKYqMxoqMwOLA==
X-CSE-MsgGUID: 5LkSktjTR3SKKynC5Cii2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75018362"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="75018362"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:48:04 -0700
X-CSE-ConnectionGUID: UX0HJW/aTx+7YQTfbm0Qgw==
X-CSE-MsgGUID: DJzZzIR1Qliac8jAVhEN5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="183976472"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:48:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:48:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 25 Oct 2025 22:48:03 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKt3afMUJMJ4S6APhpc9JoyBRPKoPUDzPH443CsRCvZa0/bnW2fPTCzbW8/lBLcEcdtUHw5GllRQC4M2lz4HpS1XnK7nXlJl3ibdVI+qo7GMTi8K9eGvLVlM7mJbNHSii2zbC4aQg+Ql85jRarwDsGkdjVL5C3zZC94Em2mu8w4t1sVTb3n12lBWOcCTMtzp8f4P/rPKNRC7HjlfYd+GzcdaG9t2V9Fs5hopi+eCwwiIb1CRMwZc+9fNB+GgELwPhuefip7a1rCNhazuAvhOidTBpfjjgbbsNwdB3yqLhQcuZNIc56rZJkV9hJb6K31TQ9H0cjQVAc9AbClhxy2a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h/UYKJEcWukzN2+9OoUjhX3y7Svyj7SpHt/dGGlgCE=;
 b=ExEimJHHOAsrhYa32pPVaDeQDHjc1km3MfiHgKIyMY2KepiztY/WlMJ1MBsh8Dk06so45lk7zDYM7wSNjgLikEe73ipXhLGAV3n+jYOhqkSIIvmeCtw4wO3sTpLzstC8Yv9yCymlR1ccC/1Rs/avEtWOWLWW5mz0Dw6c6MkPjN5WQO83Fehj+EHIBBYhKHY8wmOANVdEmUe5nszHE+T3t3nq6ZgOiWdb/mWK1NWjuhzYSBNWiuMLRXO+jgZl8soTLUBCDA6vcdEyYwQbjgZvlN7caKvJdckRCyNfHh999/3NozwS5KHryUDh5cbZ/H0mFs0ahH7XtOHD+PnB16kdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 05:48:01 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sun, 26 Oct 2025
 05:48:00 +0000
Date: Sun, 26 Oct 2025 13:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Quan Zhou <zhouquan@iscas.ac.cn>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Anup
 Patel" <anup@brainfault.org>, Dong Yang <dayss1224@gmail.com>, Andrew Jones
	<ajones@ventanamicro.com>
Subject: ../rseq/rseq-riscv-bits.h:8:15: warning: duplicate 'inline'
 declaration specifier
Message-ID: <aP22CJcg9UUdNVjj@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f23f80-c327-4b1b-a385-08de14533925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrAgQ1E/I24vbwRbMH16EQ6nE9AyL27Tnt5s2ToqeaxTVbpmL0XyOOQGmBm5?=
 =?us-ascii?Q?e7so9cDngNcuUh4cQKKbP+dqWqRiDuiop9Vnca39Dix7lWoAOGB5pIDe/fmX?=
 =?us-ascii?Q?s4soo6xBNNcCgf/MF31Cm9KzCL3p1MgdfxY3csXO8iItcA4SKlhDvv7Hd1bR?=
 =?us-ascii?Q?PIvXZUT/tv9Xt8GPs140LzRE77J7COQP+n4wtgLmjZKYv1uJkO1D2tVRlsoO?=
 =?us-ascii?Q?LwUeqmcJby2SyjFccxUFBTIswZUa27zhYaVQqqkxHc+7JGTmT1tNlAfqvdHJ?=
 =?us-ascii?Q?N4iZ37QT4kIRrj1WlASWFQ+Ge0CCt+a8RezFL8cuvWe+dmRJKmUKh7bTlmwE?=
 =?us-ascii?Q?ZaKzlHaFcJ1lENZ/ZT3KR7/CUEd25CwEYF39N4Dy4EHg/ioHuv1sNkZ8oHox?=
 =?us-ascii?Q?jONKS9GOx5ZkMx11PEzJxOgksF8ODl5y0P/gTVPaNNvyO0/uJYk7jpVVqfCe?=
 =?us-ascii?Q?nWbBElmxdm1JGPrmUSgiEabbOBCWvANn60rSoRs+d9V5sE6Quxcfz40RfdZN?=
 =?us-ascii?Q?eDCm36A5PO3Y9x8WtMmIiXJlOZSBhfDM1SJQFpqe+ma16dPmwHZw9iZGPl6B?=
 =?us-ascii?Q?W2QDX8ln0v/WSv0Ch5XKR8qCUN5KdIQ5q8AD3XoLkj7LHsQKatwn4dlBMy7B?=
 =?us-ascii?Q?wHqla4kfLMIOgXlaxIu1eRNL181vxtIs955rAkSdLzl9lW1pwgQIeZL/lGB0?=
 =?us-ascii?Q?wZMFZAaLydZb9Tg6WnBVrQDKvbwCZtahxs0NX+V/A7yd66hYBzB2DIVh3XpS?=
 =?us-ascii?Q?JZPlSKZHNbpWDGIxGdo6v9ISfwtjhFVVktJu6ckfMKZNVYPJLquOGAfMP8A+?=
 =?us-ascii?Q?M4f3tTjVKRkdd42we2Y+iZWhRp+VXF61f2K5DWhEmORH2dR9knkF6rpCifwp?=
 =?us-ascii?Q?txNeKLNwAcTp1wDj5KV2sB5tQtqzJy1LzywxscfxOZmz4Jp+7xrxDEsGzdCU?=
 =?us-ascii?Q?GBYNlWZ9Eq79ql9zoDsIwtGnT5s0folzLRbShjsUXQpMjlLkLtMelLuoAJuO?=
 =?us-ascii?Q?hprRiHYzRF5rpGrywjIl4HEEuAbBRiirqRYdGeaK3/ISuTUzlpkMJhYup00o?=
 =?us-ascii?Q?Nfnw5Rh1Ntlv8J/o+gNI1iA6W62aKSEyn4MiCkCqrrM4kDN5I5OP9DYDKjL9?=
 =?us-ascii?Q?gAXMfvXIRG8V/jGwu9yHYZQ0AgX3KC8kebVWM0AfvPjvTMIZdhCBukE2AhHj?=
 =?us-ascii?Q?C0pelW054wU271CvKCedx7Uf5OiUdMpKoSmNYMQ0LkDYpFko5ED+dSXEDrKw?=
 =?us-ascii?Q?e57bCAP51y8bjNQTfwF3ciM0/64xc6gXKMDad08SeS6TF0brmF5HIrmw5hXx?=
 =?us-ascii?Q?+qadvOBSvQGKV9XrTxgz4rJ6p8KYVdCt4psrFgnF9CQJxUdooPJxz7h3nZr5?=
 =?us-ascii?Q?zQLfeA9GbnaVU3dYhT7RBe0OxsxUQFQArASeyD7fjFZ4sTnj1JRhNpfFzB0y?=
 =?us-ascii?Q?C2dvlTI/F3rAn7x7KoCov2MH8ugioEyg8bvFRNIhDT5wxaO4tUvTOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o19DzFzMKAKEXD92NczNrIY9ygSmaMTegCVyN5PZeEXV3sfRiX83df9EJiJs?=
 =?us-ascii?Q?6ZHGlPSQaNcBN+5wfm4ExS81mVAnxQ4qunfqTrJYCi5YKDAGeFlcOLlp1BV/?=
 =?us-ascii?Q?wN9OCozIf6s4wtIt+JseFNJ/asMEmHV9/1+gN0Ow/XBT7ZwtEvzAs9nwzN0P?=
 =?us-ascii?Q?o/zeCIZoMDSOPIuMPxv4GlUtxQpzDlZn9uz3l3peFQjh3Vn1JtRHIrAYIiFD?=
 =?us-ascii?Q?UTGUQc5rHGeKFoUAsGfPwWr2BZVzAZlCY51lB5JsvZ/PlSx0HwndOXq3T42e?=
 =?us-ascii?Q?ZLQEpKpKWiLBU6XmMOps/AxEBrctQRfbHuVZmcTx5FM7p5dUCciR2/Xi1hnX?=
 =?us-ascii?Q?Ps5l9085UbJ2fimjYQ/ewtLMD+FIHOMZ2OzFm/pBcnejnmh0Ey50s7PrXsEu?=
 =?us-ascii?Q?NulF/8iPi2R6oHQn34gHfqHG6ozAION8IPbM+9qD9qL6nJ6sAAG/Q8yHIPp2?=
 =?us-ascii?Q?W1V+Yy6rjYoIzc2KjXEkCF4eafoCOZ58/28fUR+ptplvnYl6G3Z/8aezJRT+?=
 =?us-ascii?Q?GsTAIo1/CfCVJptmoCvSuJIphTBHwDl94Znk0LPcPCZMGaHrURtBmblj4624?=
 =?us-ascii?Q?yfS8reM2YBqpUWMdtFBpxYaXKtBR9ONjGzCk5rmM+4SR5nMfCwxM3Tp9ShGW?=
 =?us-ascii?Q?cXTmpLvqdg4jhK7zwCzLrTKjWLKq4f1xAr8PGmZU12JA4WgSJegVSF+xsMyx?=
 =?us-ascii?Q?Lu2bkJYYbwfTYhvJrqC5M77U0s7tHzkHA355YbUKImDSbFSNXMzhkoBc+YGE?=
 =?us-ascii?Q?zuCi8fk+hw4gxwlAVqGyicgBJVFCh2Q+5ayJvzVHxi5FI1RyZHEoNs0mesb4?=
 =?us-ascii?Q?0CdzwdekS1i57YIUl9KE/bWtRfkwQ707yQgUaZRAjTYvWJZHo7WauUMd/1Jt?=
 =?us-ascii?Q?N1FiUhFIxViq53k/v3SLDZAr12SdOegYhXi6igE64fFHQZfmy5tTfGgRlGdY?=
 =?us-ascii?Q?2BarjW6Lixew7/ODTuf/kKFOUgNStwdoZzKl9n+7iaRuWrYtpGwBJrb5OI2N?=
 =?us-ascii?Q?oymo0ltdrPQ9N3k0nsuwF9FGXFQlf0sqeWZZOQ52OmM1OqsgMyvM0n6yrzMq?=
 =?us-ascii?Q?VsDQHct9ZZXdT8qJ8nrOiLBL2iRwNkuDILXMGWaIrYeGaNK+sJpRyu9BfIQb?=
 =?us-ascii?Q?X+PRi/T2z08cQkccw1xjU2y+onh2SGrTio7Lmr31BBOdiornAMQ1NWwbykNb?=
 =?us-ascii?Q?YI+CihGqMhcZ0UYy9ZdabXeA71LSn7ouUbhYbIkztXRztwRHiq4ymx7UynBR?=
 =?us-ascii?Q?CjPrp9RuRHyGLySNJ55plbdzNg/tBGEZV7EZ/tnY5CWMutV93AlqHn3VKaxZ?=
 =?us-ascii?Q?LzdklGu0Wxl7uXtvj3PgqurdZqhLi43B3sYZjS/5U8MyPZizUAOg72S8auIK?=
 =?us-ascii?Q?48NFgzR+1mtYgi6z32juCkfhcRTY9pbNtXR57i9sZdeaLzHkMli084k9ycXb?=
 =?us-ascii?Q?y1KNCahNxW2UDSuYD8Nd3/TgzEynJ8qCvo3syRTihQhDHd7ALhSJBgXvk5Yc?=
 =?us-ascii?Q?3tgf8vfApUI17paRhJcaivgAgFMVfByKLfTrfl/iiFXAdghZK7Q+WLGP5aTe?=
 =?us-ascii?Q?ZannEjMMbiNA7ntoEDC59h6cb9UojLiLddboJmHW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f23f80-c327-4b1b-a385-08de14533925
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 05:48:00.9187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYPc6AQRPtviH8xMyKEgI9JDW36EdhSCib8cQMQI48qzjA8NJ6tPFpnL0BhL9kkQNuJJjNTA/ChM8GAMR18NmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72761a7e31225971d0b29d9195e0ffa986b77867
commit: dbe3d1d1609e171bd26de077abba6ae142de86af KVM: riscv: selftests: Add common supported test cases
date:   6 weeks ago
:::::: branch date: 5 hours ago
:::::: commit date: 6 weeks ago
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251026/202510260727.DNCWXWNO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510260727.DNCWXWNO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510260727.DNCWXWNO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
>> ../rseq/rseq-riscv-bits.h:8:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
       8 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
   ../rseq/rseq-riscv-bits.h:61:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
      61 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
   ../rseq/rseq-riscv-bits.h:118:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     118 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
   ../rseq/rseq-riscv-bits.h:162:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     162 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
   ../rseq/rseq-riscv-bits.h:231:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     231 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
   ../rseq/rseq-riscv-bits.h:280:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     280 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:171:
   ../rseq/rseq-riscv-bits.h:343:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     343 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:175:
   ../rseq/rseq-riscv-bits.h:280:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     280 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:175:
   ../rseq/rseq-riscv-bits.h:343:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     343 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
>> ../rseq/rseq-riscv-bits.h:8:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
       8 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
   ../rseq/rseq-riscv-bits.h:61:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
      61 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
   ../rseq/rseq-riscv-bits.h:118:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     118 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
   ../rseq/rseq-riscv-bits.h:162:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     162 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
   ../rseq/rseq-riscv-bits.h:231:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     231 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
   ../rseq/rseq-riscv-bits.h:280:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     280 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:183:
   ../rseq/rseq-riscv-bits.h:343:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     343 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:187:
   ../rseq/rseq-riscv-bits.h:280:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     280 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   In file included from rseq_test.c:8:
   In file included from ./../rseq/rseq.c:37:
   In file included from ./../rseq/rseq.h:131:
   In file included from ../rseq/rseq-riscv.h:187:
   ../rseq/rseq-riscv-bits.h:343:15: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
     343 | static inline __always_inline
         |               ^
   /usr/include/riscv64-linux-gnu/sys/cdefs.h:595:26: note: expanded from macro '__always_inline'
     595 | # define __always_inline __inline __attribute__ ((__always_inline__))
         |                          ^
   18 warnings generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


