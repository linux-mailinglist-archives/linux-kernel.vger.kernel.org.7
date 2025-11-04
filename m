Return-Path: <linux-kernel+bounces-884125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847AAC2F6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C921A18961B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863FC259C92;
	Tue,  4 Nov 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLpLwVer"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BCEEBB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762236283; cv=fail; b=LFuScJOjBTNaPBy2MYZWBkkfEh3HjECzqxTotAls99xmy40WWWoOoiAt5dlRF7kDvCmifMM1DSUs++fBrsNCoRqmgqwbxb7byTqXys3PrxprU65TpLN8nSbCqBnDpUVvA3n/Q50b9ZMbK69fwogyU3ApxESvZqsWhD+mTrnai0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762236283; c=relaxed/simple;
	bh=Hrq1vwtotCcfCM4FAd2ew2ABcw+rpnG0LZLrWmr/Tp0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kEczJjTHeJRp1jDVpFdPU2sjt8C/FdXXy9J78cHI/11mNCm3uEb/WnNCSXAs3B1fhT19Jxz9xf2T67hhtX4zOCpRhZQFSj68hAzT/Zcu5Roq1WmjmBTaBRay6tgKKnCGIoTdt+wpv2EERhusH5VtD53GLPVz5zu6ySRsYPZ8id8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLpLwVer; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762236281; x=1793772281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hrq1vwtotCcfCM4FAd2ew2ABcw+rpnG0LZLrWmr/Tp0=;
  b=hLpLwVertOHZNVe7c5kI4kM3tG8DMw/tNeL94GtQoooFSp8MBskd7xz8
   2DdluYdLf7Psm2OP1KxxsWQnTxBZCQavm+3zG1V4aD4EAOzZGhCb19yY+
   keCudlpKFOA+/mwbK5DmsZ7+w3eJfERfHhCgLWYUOZMUNclHldcPOJ+k/
   L4QyLqqtAh5DVBk/gs/F03OjVieRYtbDrdXC+xPvqPUIrrSnbhr9B74fo
   hezCk553h3TLcRuNSgukWscrw8v22grnyFbWdBbmk1N6eCTLKTvYTZSts
   FKYcyLB0apABKgQ5IqpxxdG8YVw+UFFWYhoiTtk0WnKORW/yUYhw8FSZZ
   g==;
X-CSE-ConnectionGUID: nGssFOGiQtOy1RfuOssm/Q==
X-CSE-MsgGUID: 8reB/GJRQbWNfMnahRy9EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75673751"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="75673751"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 22:04:40 -0800
X-CSE-ConnectionGUID: EC2pCWwlRpKyRAIY/c4WTw==
X-CSE-MsgGUID: kKsBFGt9SOOfsKesYJselA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="187517409"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 22:04:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 22:04:39 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 22:04:39 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 22:04:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROq6rlRdoS+pzNcTaTrSvmq23qHjFPWMd0WNhwADlktSBbtjhzLmsLvnkfGJ4JSQ90JuONCCKJbegl+YjWq0CVu+rz84HQjqCJ2mXjqvJBuVfDufhYASlNYG6SxBammVkqpcC0+f+0ox/AzUI5JLcN0hpaHMyn7+FcX9UzPxUz47t7pgyEvS+vrRzwDRb2vrMnY28RKqZMQ8qmm2L4MteeoJMGzwiAbojIBUZEqN8FST0c0BwliVelG/Fysyu36yRQy0x2WmXicml33q6PG3epLRd1I1WATgY2oRPNkVOhZCtChH8yBAeLl/SYgWkJqhUTWE3A67cwDNgzON8Mv/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocULqrymhtCimYsHmSv7T7Pf1ZVdycPCXk1HnxKgtBs=;
 b=G0lKpeN+FAOHS0xes/EGK+qKF4qYitanT+EykmkcUL+d0WB3rt60Hemi0Fni1HjmkkO5PchlHEIuBx4ymT6mb+lT4OmtROu08MgSK/vS84bAg/LrkX58hb19W9UfJ0sAh3VVshpxIdqKNviH2m37UtANCyhWann4soAJ9bJKDNmAIohGsIbD5R1J5nqZ/K0nDi1G7O3Tg6zSabaiRaSqIaiPql1lZZ9+oaiFwVaSokdeaKcZHGJ12N3nsNlTK7g6bBndzxADroN2RwUV1k346c+zLgxYGj1f0KHjmKME9Ucxx0eWTGdz8EHrep5qLul/t4sySlsYHEU4aFUY5XNAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 06:04:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 06:04:32 +0000
Date: Tue, 4 Nov 2025 14:04:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2025.10.30a] [rcutorture]  ab3482dc2a:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]KASAN
Message-ID: <202511041306.c42f7162-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d1574e-cdb9-49ef-d2db-08de1b68060b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YT3FpIKc8rS23WPeDK7DDhMWKsmsDla+i/RwnwEW3GNlqhI8YDMTfszCmQuT?=
 =?us-ascii?Q?AcM/CK8qRiP9y3heQscPSeprRGVuRACy9g5lSLa9LkwT5SH/cGAYuA6pst8S?=
 =?us-ascii?Q?F4tWAJKlvRqBQtTIVIAUbyiV7DZWyY9c6hmMJ3En1GbKnBNeUhzrkD1FGYF5?=
 =?us-ascii?Q?Om0MAuNrw9D4oL+CPhdL+VwU5CpyE19SBYqoiSEz8ZdHcKH2GXyyGt9Ur7ze?=
 =?us-ascii?Q?opnA0dGkc+nZX0t/g9VRhe3i/16RhLZAJhaEss5aOuB/dGJkcNcv3ygPop/y?=
 =?us-ascii?Q?jZVzEwxxklNTUwZe/h79ooo5hhLjieK8dDKJ5W1+gldjqXImZRYTewFPAMk4?=
 =?us-ascii?Q?XmuV+wTOrvW/ksib1eUpBgQCWPLeIKEhs4hfJljd4hijtiNcPPbPvAWhTpha?=
 =?us-ascii?Q?tw726bvuuky9ICDDnMcBh3dj5iqwnyOJ0ImaNKjM2g7/qo5BfC76jJb7Zghq?=
 =?us-ascii?Q?LTlgZYQuZKE7qzegQkxjx/IlNeZSyc+FnRJyU5mNQxIVAvZ0JoD9f9wuJjkt?=
 =?us-ascii?Q?p8S6QxSkbwTjkbZmpwyGrjf+a/0rYepFnuhiOUXHDG/3SmHgnxoRRHhli4N/?=
 =?us-ascii?Q?qGkUx94GTlq8vVOd4u6VlyXvaeIOyYUivSXAjCoH/LFFMArV6S71UkRvpPeQ?=
 =?us-ascii?Q?Wh7IuLfGSP0K99CZEDYVt19iWU3XomMQb/CPoUOkT/osoO5iZl/jRSvOYClR?=
 =?us-ascii?Q?p8yY3F/WJW/TSPlOJ4yvz07mJ4La6dz82LoPwke2HUIx5qR4sa6SQqLEUQqa?=
 =?us-ascii?Q?LO7HEh3JmHpgMAg3u9zkAq4a6y+RvIuvEGjAxXWHFl3m8iDb/KwYGCrE85Z6?=
 =?us-ascii?Q?CBTUPMSPYsNpJyNnxMu7HhoZLiTBcuzGIksfsRuTOeD36ufcNdbLfgSadFT1?=
 =?us-ascii?Q?sJCMffg/rYFjokJVmB2fjNtNKtT22gFmV/TcZ9a0b9bozW+i41dZHc+mlniR?=
 =?us-ascii?Q?eI6oKRkCRV7cciK4gMK/wbAiQf3AinMptYA01yqRFSTtE95hezleUli2biB5?=
 =?us-ascii?Q?n7BXd4Q712s8nPn8thgusiIuu7PWf/4AbH67b2p+weqeyNhtP0eTFr22JVGk?=
 =?us-ascii?Q?FUUVf4n91wQHs9QSxx/fyXzjaolavrn14SNmeJcDcPvni6RpKyxmq1SC8Uis?=
 =?us-ascii?Q?YnaI5WAPcJBPL18FDul/zguMqZZbhFgIgDOXf8pM1WOhkpFW8qXAyUOLMySo?=
 =?us-ascii?Q?TOpdzI0uhL45UayWkINRONpUy++ja2dgoji6FCxSKM8IhQJohK5NiPaJqT2o?=
 =?us-ascii?Q?dfyLhhQZ5oUfvLjmwVYA/J+huxs6quPc6/QYQjaBVbiqDT/PtKLuj+aiutYe?=
 =?us-ascii?Q?rmH91Y5YgxepijjOKaO8hm7xhnHgLyeHgNVhyqJGVNjKOADhhM8k8E9Dn9oO?=
 =?us-ascii?Q?Zz384cPxRDbLW3jCeF93VcjbEtJkWyekuvPnFFMlwRcQByLQQ/uiu8Wl5qJz?=
 =?us-ascii?Q?7ErcBWV4ZbkMl1P9nY6mzGBT11q79wZKXTOOyMjmicaVvNGj8YN+sQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZguphP2wu0mBOCla4b4z/BukBuGPJioMdUYcNSo09yMcxJxcNW69W2lnvuMC?=
 =?us-ascii?Q?C+Q+PIQc5ZASlG2jCLNwWPpyd1vzBHm6vZjffNsVG7g7QvqE6ZAd7nNRNM3l?=
 =?us-ascii?Q?XKHaQiKfO19vR11LgaNtl/xHSCJGUcM4/3OUj9GcTeYaONVRyAnRq8Ier6KV?=
 =?us-ascii?Q?tSFLYvu6iptsa4Uag9HnlaSUzsC3bcJ/LsUJreYdyPoDkwWoC6sADsfZt0Qh?=
 =?us-ascii?Q?Ztxir/2iTNHb9uA5fqSYK8jZ7gQo3aEokBbqIT7cW9MvXIA5b2jgjEKze6tV?=
 =?us-ascii?Q?LEUXdiWtndTsvVPKrUnxSzd/rjZ5esacLXMWuasmMlHfYi1/BR+FVwVP5pNu?=
 =?us-ascii?Q?aeXXtYeiecxC9Wjc3XVZHX7Oym0qWCt0wXOkRNKx2HARVbJ5Bnx+ubCac0PU?=
 =?us-ascii?Q?ffJ2Z9M60SGZPePSqIM44EI3/kEAkqSpr/Nldp+TBeqsvwJPgvGcxzJQRMVQ?=
 =?us-ascii?Q?IfpfURkCEq+ryCLI3SzqtYeMv67jx2KMfxUd6QuhE86lgOqSU6IFFDQVbDkH?=
 =?us-ascii?Q?/IAC5CY23dJQlKRkpwZ1+7q/23bpzBQfrEN2uE/7XHesMSVkjMVjrqZqkLZr?=
 =?us-ascii?Q?KMUAsW1F8gABhFn/ro299SzpSPcD9/zuDKQFkCPLs+mAHO/YSB+bIDu2pQAs?=
 =?us-ascii?Q?B8EVG816T1UG1HrG3tyOQRzmYBGBLiZFBDvN5M0tC4Ve+SXglJtctkGueKkv?=
 =?us-ascii?Q?RiR8hwSh+e7XCbNMugABdPOKZylbqz79RxplF/PhqJG5nZ6ubcLxcwm5MiNy?=
 =?us-ascii?Q?paH3GGrc6nSn74O11us7aUWMMsVg44vX/li9VVM9QkahF+SrNQhjLiX1iDDU?=
 =?us-ascii?Q?WeuBcmRsj+1A9ccRwPCnGXJ5l/isQHJ6Ebjy2ur6t/41J3i5Zur649BWdVXN?=
 =?us-ascii?Q?JoL4pqYm6soChyXHR+Xu50GhjFJPEciEMv5vAKQOUmZOPuozaiyy3dc4E/J0?=
 =?us-ascii?Q?Fyl4YLO7jNc/yYvB0wrd/N7uMEbTCVGiHICiCwRokuT6ReqDfijml/Wv62hn?=
 =?us-ascii?Q?3heOH2rhFerW4ySbq8kzAEwDjiZWeQp1/61TcSkrbXOC5jN4ovl0PhObyuuc?=
 =?us-ascii?Q?fHLuDVplAoEfiwMWJTbqMTpImgGb9FSvs5DCKx8jXwjjXtDQxs81YRM4fIoc?=
 =?us-ascii?Q?qMFuM5nfxIjABC06+R7pnJug4B+23wWdher6Ssnykjk2bQJGi6UV2ay06R+5?=
 =?us-ascii?Q?cedWpqmWIhkKPLIs4C88XelITkt3oVm9c+9rHEEIFHWj5Ao90bzBgNUS+jet?=
 =?us-ascii?Q?h2RYVsSkALp/Wx4CMe0lX0yYn4ayGugalwXh4K9fBB4CH1UYWE5SS+ZGGVEd?=
 =?us-ascii?Q?JRWsh2Qi4UHE9Jqwf8we2u+8gK9thoVpRtZe84cvlfaFC3Dgv2agtSfIxUca?=
 =?us-ascii?Q?SYVWPhWbIpo2CzFL5+kGPdGs2J/PMQ1AvWKCLidIg69T4GPtlfZ2uYybtE4O?=
 =?us-ascii?Q?MzUX3h7H8CyUC2ReBoWxvUmB4AXHxYK/nz0TQbxm90F9NzNHcilnGBd4Zz21?=
 =?us-ascii?Q?secYC9DmlrxxpMSJOmchfNE4GRh5wHaMnEY0BbBlGJT+jALuIAcRpNVPJoPN?=
 =?us-ascii?Q?6yuO3hH+l8y0+O24kttZFfqf+IVz2vNphpluEIAcOd4Kf2TmFX81odPmESKs?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d1574e-cdb9-49ef-d2db-08de1b68060b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:04:32.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHYFitEiJsou8Mc66rEYO+gg+Kn60AMSvvxFLer06EUvi+OpPc5NcA2293vkY589cVh5B+xVeAkjeNHau9JH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com


hi, Paul,

we noticed there are fixup! commit for this change in newer branches
"dev.2025.10.31a" and "dev.2025.11.01a".

if issue in below report is already captured and fixed, please just ignore this
report. thanks!


Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]KASAN" on:

commit: ab3482dc2af45fa97143131e0e03e73e18e8fffa ("rcutorture: Make srcu{,d}_torture_init() announce the SRCU type")
https://github.com/paulmckrcu/linux dev.2025.10.30a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: srcud



config: x86_64-randconfig-101-20251101
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511041306.c42f7162-lkp@intel.com


[   85.244843][  T376] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] KASAN
[   85.245696][  T376] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   85.246346][  T376] CPU: 0 UID: 0 PID: 376 Comm: rcu_torture_fak Tainted: G                T   6.17.0-rc1-00079-gab3482dc2af4 #1 PREEMPT(voluntary)  5c143d583914383a8f9ea9c18b817a947366c659
[   85.247433][  T376] Tainted: [T]=RANDSTRUCT
[   85.247685][  T376] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   85.248336][  T376] RIP: 0010:call_srcu (kbuild/src/consumer/kernel/rcu/srcutiny.c:211 (discriminator 1792))
[   85.248645][  T376] Code: 43 e8 c1 4d 13 00 4d 8d 7c 24 70 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 87 54 2d 00 4d 8b 27 4c 89 e0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 e7 e8 0f 55 2d 00 4d 89 34 24 4d 89 37 e8
All code
========
   0:	43 e8 c1 4d 13 00    	rex.XB call 0x134dc7
   6:	4d 8d 7c 24 70       	lea    0x70(%r12),%r15
   b:	4c 89 f8             	mov    %r15,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  16:	74 08                	je     0x20
  18:	4c 89 ff             	mov    %r15,%rdi
  1b:	e8 87 54 2d 00       	call   0x2d54a7
  20:	4d 8b 27             	mov    (%r15),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)		<-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 0f 55 2d 00       	call   0x2d5547
  38:	4d 89 34 24          	mov    %r14,(%r12)
  3c:	4d 89 37             	mov    %r14,(%r15)
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   4:	74 08                	je     0xe
   6:	4c 89 e7             	mov    %r12,%rdi
   9:	e8 0f 55 2d 00       	call   0x2d551d
   e:	4d 89 34 24          	mov    %r14,(%r12)
  12:	4d 89 37             	mov    %r14,(%r15)
  15:	e8                   	.byte 0xe8
[   85.249962][  T376] RSP: 0000:ffff88813023fd28 EFLAGS: 00010046
[   85.250399][  T376] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: dffffc0000000000
[   85.250914][  T376] RDX: ffffffff852cf470 RSI: ffffffff852d613b RDI: ffffffff852d5d8f
[   85.251426][  T376] RBP: ffff88813023fd68 R08: 0000000000000002 R09: 0000000000000000
[   85.251888][  T376] R10: 00000000a56728a8 R11: 000000005e2747a1 R12: 0000000000000000
[   85.252406][  T376] R13: 0000000000000246 R14: ffff88813023fd78 R15: ffffffffc0183310
[   85.252874][  T376] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[   85.253484][  T376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   85.253976][  T376] CR2: 0000562ce1691468 CR3: 000000014ad8a000 CR4: 00000000000406b0
[   85.254529][  T376] Call Trace:
[   85.254754][  T376]  <TASK>
[   85.254937][  T376]  synchronize_srcu (kbuild/src/consumer/kernel/rcu/srcutiny.c:241)
[   85.255283][  T376]  ? rcu_read_lock_any_held (kbuild/src/consumer/kernel/rcu/update.c:403)
[   85.255601][  T376] srcu_torture_synchronize_expedited (kbuild/src/consumer/kernel/rcu/rcutorture.c:889) rcutorture
[   85.256310][  T376] rcu_torture_fakewriter (kbuild/src/consumer/kernel/rcu/rcutorture.c:1903) rcutorture


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251104/202511041306.c42f7162-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


