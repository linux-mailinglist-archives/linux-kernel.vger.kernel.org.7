Return-Path: <linux-kernel+bounces-739376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DCB0C584
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F1C1AA1F19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B32D9797;
	Mon, 21 Jul 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAYYLcTA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C52D9EFB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105850; cv=fail; b=ZLAEHZtSoce9pGNNhuGSHMO/CtN6ZsvZR2yOKtDRVrEVgwvZyyk9VRLbwa3ERUwTfv87chbYAgk0LU4SBtlVur+CUB9UrUkElCC+Pr8zjYUKFlTGO2WF9n9fxMsDSnuAxudIOi2Pv1unVl4YS8FZjd4se8KnLyDZm4bY6Gc8zQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105850; c=relaxed/simple;
	bh=Wf6qLgjFfnYj/JrouAErAAI9Hf+gymk4klS9JpqfkKc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lnrxn6yb7fkIHehxYtlc/kjn0xZkuFkLENerFiIvp+91WOiDmZzz+um3YhyL9HTKxKm1ETdFNEdxvSs/HGrP01TbuXs+l76ZKrn9uatfrjVutc7ox2++z3D/BtcWv74LVYagn/YAOxUjBjyXqKpau7nRasL5+QtQUTdbmI6upX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAYYLcTA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753105847; x=1784641847;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Wf6qLgjFfnYj/JrouAErAAI9Hf+gymk4klS9JpqfkKc=;
  b=TAYYLcTA5qv9PjYqcaSwZ9CHvPii6upX2VsqLqBMUNmRyN/KfLHnNgix
   K7VgqtAKn5zIEE8V6Pnl7yNGsA2GGFEqSsAwn4vpUfGCfWDmXxnSNIaAG
   VLQdmfYFZUfNRuabPOTYWG5Y5QTzuL1MeDdDUjfjbZHolIFWVoEDtWGeS
   YjcBquNhj8+/Tfsra4GkI1dhsOBJ2cvKS0PKRTwLj2tv+3FZseY+9GnNl
   KWwC/RDv2R08ruflbdJMYYVZuAwKW84y5gGAXyZSNqGCv/EQYLzVnb/eO
   VWVzDxykMXwY8CpeR2jXgf3NOr31ByPXOIe8Gp9yaSTxhjT7g5ipsK0K1
   w==;
X-CSE-ConnectionGUID: 8G95BuO9SCe2DUN7BOixVA==
X-CSE-MsgGUID: ZwrETCzYQ+yw6F5rjn5N4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59135836"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="59135836"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 06:50:46 -0700
X-CSE-ConnectionGUID: fdpAuYb9Tn6gxmt5OH0a8Q==
X-CSE-MsgGUID: 3FWymyifSvaoY0nLoXLAsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="164333969"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 06:50:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 06:50:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 06:50:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 06:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD4+Yy0f4irEnPqSedVOFGkFplU+2d+NZae6ctGVmYH0Gz5Ojv9GAhuLcaTg/2XvB8saKM7F9/fkUGiOviD1ufWcWyAkFrCN+kbRV+eBflSeZ/BwMe15zyp/qwcmaYdREGq7CWxPdgYwqxVkYP1fIy4pL0WgCbCEAyiyWvtVbd3K8FJZLB4ZwtHR9lnP3lnGRDj7GqK8jKDMstarqcEchUEQcFoe0HIhsScXQ+5XYl40fXRpNQtdvdqWt1DbqoZv+QJZtwDTImjSrVmXUGHVkQmvJurTXTMC3fpMCPszrzQxidjgTZxfmWW8s6oCO2D8uWrxDZi2RQ1UivyDvUvflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/GoE/vOpenehoAuOLj2A7rB1tYOcpkDQo/fu5gWWmw=;
 b=QvmTWwcD8jC86ZY6W3ovmsOWJMYSqiI1APDHPnID/oDBVwqlje5asd4SywuMzy9sTBxIxW7+wgubzOtPzNKU8cQH3CW8gRzUSzzf5HEpeswu1FWUXa0L3SX72f8VZDAaRAjS0epBb1zDFFeRJwisgOvwANudpgbM81zIi4mm8isbZ+SXHyB9FQaAgiGnOoxKZvcqV054vV8UIviv89Q+YaAmLsRX6VS1Me2C3VHfMgGZ9cU3yQ2sM81LVykkFXNazAJMhaE0hjGvAxWP8WzuI/cHg3DXa99w4+p5p1TZQumrFo8os5cdkZmRzYR/NXf3qDFIbPlISMZSgfetEfF6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:50:41 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::fc95:158a:24ce:885b]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::fc95:158a:24ce:885b%5]) with mapi id 15.20.8901.021; Mon, 21 Jul 2025
 13:50:41 +0000
Date: Mon, 21 Jul 2025 21:50:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [x86/mm]  1701771d30:  will-it-scale.per_thread_ops
 11.8% improvement
Message-ID: <202507211051.661da739-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9ae3eb-aa3d-46c9-2aaf-08ddc85d940d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?r8NQin2cWCJBDan2voUJptIgTWOyu2THCkyJ6AP/7E8mPCdZAoosPPcBae?=
 =?iso-8859-1?Q?zEiy6I9fmIUN7AZgYwxcuyavl6OPVrXAdRW73+u2oF+PAW10HiSsTh4vQ9?=
 =?iso-8859-1?Q?w1/CduwgEKB4MdzJk1Tksu24BPFy6YBPTHmts+2Lc4+XychaKAGvQBPpBB?=
 =?iso-8859-1?Q?hHsL/1vjtfQ0GUXA/j6a/uraUxjoMzP2UtBSsUbL3Uspy0pescnh1dtSeQ?=
 =?iso-8859-1?Q?DtZq6WU5vS/EWn2Fv1Ksm9aP3dNL6bVMEjo9P9eIKWs9BSXOkEQELllzWj?=
 =?iso-8859-1?Q?GLEfSAkig6aUR1bdP1boqiPBDY1UiNONcvPdAdUotlIf8JFC+lc2tnvKWN?=
 =?iso-8859-1?Q?QOEXYpT/uEqkhnJ1Sub+E0e0ZL90/VJ59+32HO9/fQ0ljwtMEHZsQ1Vtwd?=
 =?iso-8859-1?Q?LwgZRpy3f2zN+o6CbtkwvFCBc671r6iX9VMTgT/GO+/VtNDoF0nxsT1Kky?=
 =?iso-8859-1?Q?bkwwY66tt85mfAq1ADXWeA4ryu2Hlfc7pAjkusDdDFgLy3JzvsAufWCmw5?=
 =?iso-8859-1?Q?v4/uMVMlgxNEnB8VRVxAWPp47ojd3KlYc/acqx7ktkpayX8x4YCZQWeSt9?=
 =?iso-8859-1?Q?nfNAGfdFrOdok/GD+UHfoGfaflAZepQwjWjEpJ03znNRFlBT+D3sn12g6V?=
 =?iso-8859-1?Q?+JeMVHXXLZTJRGqLCFGsOwtCjBC9MRbq8b+p9WKSrXBVhnRF9SQ0OtYCeZ?=
 =?iso-8859-1?Q?4WrlNLLkEx53jfEeL3daHgKX78OxYTVhTylHNQpEy6ehcjpyR6hZiu9JLB?=
 =?iso-8859-1?Q?J8IumGDOOGpI1T0sx9PpFX0b8QgdG6OzsuqMTIDahpJaGIC8lzMEqbm+Pq?=
 =?iso-8859-1?Q?DuhrFlD9XWa9YbyT5rVv1uaIJaJgCe+MMJATpl1EEb84UHn9AyKN3/0hzg?=
 =?iso-8859-1?Q?ZKp1eJe3tB9I1PeCCdQHFPMihSzcNX5QJqawZJnRhFWBC2yO8POOSe7qg0?=
 =?iso-8859-1?Q?r49gT6fSKQQtmrOYMic8b9pzwjB2mlc1a8pflwnsrHBcsYiAYnfrRmTYOD?=
 =?iso-8859-1?Q?69j2v4LQItZrkEDPK+/dlg5my8dqm8ypSnJ+2Nrdpmc7WBpX44gC6tvYci?=
 =?iso-8859-1?Q?/aydNMopSEN2sqLPYiZPa5v2B+kji6V987LPTqhgrtDuCiaNTB0gyDrAdp?=
 =?iso-8859-1?Q?59wITiq2xeW5eeheCJlGgI8NQ6GyctuObeQj/4C974S2g20/wimVvtf7pA?=
 =?iso-8859-1?Q?r1DcrW8X0V/shGhHwRkFD8lqaC9PCv0fdSOihI1VO51bGroG5EqMF1dbXI?=
 =?iso-8859-1?Q?NnEkj//ElfsIicmsjMJHKbCUn0aQ2QFMX8isD8JbbHNP1FY7hpz+totD3G?=
 =?iso-8859-1?Q?27b57ruyjCwcqZnwizg6rGag9nF1WJ9n9taLwu/hHdud+j8RqEhboEKBub?=
 =?iso-8859-1?Q?xpnN2oc1m6Us0GPN2HgS7hoQkbRtlahDywFTky/rVbCatcaT5s9a1paSTF?=
 =?iso-8859-1?Q?+/llFEId4hxV3Xw8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A/0KC0x0/peoBXYl1qbqzW39FHYdxe3X76fxK2AxFp+qKmB7Me89tn5Ux3?=
 =?iso-8859-1?Q?yRBkIJCK4hzcBC+tgRtqel3dOf5agQifoOJafSy2cLzMsu8PfSoDlZyO+b?=
 =?iso-8859-1?Q?k8ArCa+cmArQcjEBhMeIIqNI0WykJ00SnaFyFUikcxl1wzU11PmYIZEY4P?=
 =?iso-8859-1?Q?lYoFfJbPJLePOdLDjbMNkgTTNWOYKR83zuOTMXfrVUqOPOpx10M0CVUvpB?=
 =?iso-8859-1?Q?2G18ZPE+1IoebFzcj9bRjToNZlXkbEXm2ufvlRBfKW7+BozxMak3SSOh0r?=
 =?iso-8859-1?Q?vegnXDScM/sJCesabsQdulPeu7wQ3R9fYPMMZdoM1hV1cz1L7upLr7wUGC?=
 =?iso-8859-1?Q?19aKdYJfrwdSJmUMigur7D38VpwxRCJfXT5fcYjA5kPnTuE1VnMwNwGbDl?=
 =?iso-8859-1?Q?7CtPNdk2uQdLOGFpP4hZhu1j3LpAOt1OsruuopPmyrf2c1hCsVQ/bDMFEC?=
 =?iso-8859-1?Q?pwZihzUgVjo3pg1+AMzq7ujsMVXF7uc3D9smuTEyUmfcvrix7DB287BMw3?=
 =?iso-8859-1?Q?Kp/+2ZcGiroNJSToHJkGZKtLW1RiWBe9Sj4Bg4eXGNRB/B5lAj3UwD9m7L?=
 =?iso-8859-1?Q?UbHwhtvL4IBHOQeUUPT7QM3BZGemQ/ZDc7diiiJ+zRIpb7rmj1ZlqX5uNQ?=
 =?iso-8859-1?Q?vhrsaE3zNV1jJOwBS1CDu/PFfdQ9WDcCmWq3NgeLBsn5PIklJjDs9iXVi8?=
 =?iso-8859-1?Q?tiR98yK3xBEpzxLxTIbUdu1PdZGtSyMsDjEiIbV73qEsBkjO0MLqLTvGv9?=
 =?iso-8859-1?Q?EXcOixV4mkFYpcqLCDcylkELXxRgrIOyNHuIQV1VbcwjqIA7TOkh/OEKxw?=
 =?iso-8859-1?Q?gjiL34KFffsUNxbi5egWKXmPW9JkHUVMXqHJWm+bRyDZhp0cinpErNckAY?=
 =?iso-8859-1?Q?YILIxUErSVlsPTI5Rsb6PEjluqnclx88qgwHTeUkne/nan23U10OshXd30?=
 =?iso-8859-1?Q?ptYJEX7HWtr2IO+09cgP+1YDF6oKgbMU6XK9462gIGhe/kHdq86pECj8uC?=
 =?iso-8859-1?Q?SjJFwNS846SrW2m93b1oHPkcZFGHQ9GGl5On60+k025wZEMfnMZ/RTmSPZ?=
 =?iso-8859-1?Q?WpW/+3pSW9NPT1xgM7oPAN6qJP40WWqEaDq6/pGt5JkVd5OtMXWh+5GIes?=
 =?iso-8859-1?Q?eZt8ow5Hxms4MMajOTPBwKzGCg3N1B+BHJKnd7l7vPUDc3UuSb8PcA4zS0?=
 =?iso-8859-1?Q?VN0R6YD5v9K08kIpwinFPug1ISilxaSk0S5VkHyEjfoqg352a5mAAGEdIR?=
 =?iso-8859-1?Q?jaSIaqx1tcSqO5YCxzaFJ01cbqkXe2SVuE34xMyetmAS81P6DR5fOV4deu?=
 =?iso-8859-1?Q?qzQeExYVmOr16AsVQBs815RX6b48GXAKGqETapgJhIN30dEQCzZRYLkK5G?=
 =?iso-8859-1?Q?Ywf/p7BOi1W7UY7i7+6eTNiUZCeD2fleNfUNJO6vr3d2a2vwYq9mSJbRJi?=
 =?iso-8859-1?Q?G2UPLwEUJShC5BnHOtFEV1w9/DfuUgeGWJesIc0yqc1/qf0fe7OLDMjGUv?=
 =?iso-8859-1?Q?zFFZU7pXfi7XNB85c5REPTxkoNxWfOiieFhiiyGaJVhSbaemmCZcAC0/wz?=
 =?iso-8859-1?Q?U08GPJ7KxrZqcLhSvTTriZKMBuMxGACmJmqo2N+c6koj/UVuzdVx9QFnf0?=
 =?iso-8859-1?Q?eflAGhWS4VsIhJoya9HRS/5aB1sTsxMJ3uTzoFJ8Zi19aXLrMHGtQUDQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9ae3eb-aa3d-46c9-2aaf-08ddc85d940d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:50:41.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UN8/WdSMEpKoXdV0S0uo4DzmisJ5mVd97CHZS8PeFxqqWn8f5l/FFGf4SHIdnpHJ+0fyOfKCcYA5SpbGTUXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.8% improvement of will-it-scale.per_thread_ops on:


commit: 1701771d3069fbee154ca48e882e227fdcfbb583 ("x86/mm: Stop prefetching current->mm->mmap_lock on page faults")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
parameters:

	nr_task: 100%
	mode: thread
	test: page_fault3
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250721/202507211051.661da739-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp2/page_fault3/will-it-scale

commit: 
  2b00d9031e ("x86/mm: Simplify the pgd_leaf() and p4d_leaf() checks a bit")
  1701771d30 ("x86/mm: Stop prefetching current->mm->mmap_lock on page faults")

2b00d9031e42eabc 1701771d3069fbee154ca48e882 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3458301           +61.7%    5593003        cpuidle..usage
   4008132           -12.9%    3491935 ± 10%  numa-vmstat.node1.nr_file_pages
      0.04            +0.0        0.04        mpstat.cpu.all.soft%
      3.73 ±  5%      -2.5        1.27        mpstat.cpu.all.usr%
     30.37 ±  7%     -24.7%      22.87 ±  7%  mpstat.max_utilization_pct
     20.83           -19.6%      16.74        vmstat.procs.r
      3915            -2.9%       3802        vmstat.system.cs
    585215           -11.2%     519834        vmstat.system.in
     85.83 ±  8%     -92.2%       6.67 ± 32%  perf-c2c.DRAM.local
    934.33 ±  4%     -36.1%     597.00 ±  3%  perf-c2c.DRAM.remote
    767.83 ±  4%     -48.1%     398.50 ±  5%  perf-c2c.HITM.local
    291.83 ±  7%     -17.1%     241.83 ±  5%  perf-c2c.HITM.remote
  15155023           +11.8%   16944179        will-it-scale.192.threads
     89.62            +2.4%      91.76        will-it-scale.192.threads_idle
     78931           +11.8%      88250        will-it-scale.per_thread_ops
  15155023           +11.8%   16944179        will-it-scale.workload
   5021395            +7.6%    5403968        proc-vmstat.nr_mapped
     12812            +5.8%      13561        proc-vmstat.nr_page_table_pages
  16783769            +6.4%   17863851        proc-vmstat.numa_hit
  16584979            +6.5%   17664879        proc-vmstat.numa_local
  16918658            +6.3%   17990367        proc-vmstat.pgalloc_normal
 4.575e+09           +11.7%  5.111e+09        proc-vmstat.pgfault
  15363556 ±  6%     +11.5%   17122943 ±  4%  proc-vmstat.pgfree
      0.05 ± 47%    +102.1%       0.10 ± 19%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.06 ± 45%     -92.4%       0.00 ±181%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.12 ±  5%     -25.3%       0.09 ± 38%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ± 38%     -94.7%       0.00 ±181%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    252.96 ±  3%     +12.5%     284.66 ±  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
    207.13 ±  7%     +14.7%     237.60 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_fault.__do_fault.do_shared_fault
    632.88 ± 21%     +26.3%     799.44        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    398.06 ±  5%     +22.5%     487.77        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    457.17 ±  3%     +13.2%     517.50 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     83.33 ± 14%     -88.2%       9.83 ±142%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    484.67 ±  4%     -49.3%     245.83 ± 10%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      2271 ±  6%     -18.8%       1845        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    562.65 ± 54%     -79.8%     113.75 ±141%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    252.90 ±  3%     +12.5%     284.59 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
    207.07 ±  7%     +14.7%     237.55 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_fault.__do_fault.do_shared_fault
    632.86 ± 21%     +26.3%     799.42        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    200.28 ± 60%     -99.9%       0.24 ±219%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    398.05 ±  5%     +22.5%     487.76        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    274.85 ± 44%     -99.9%       0.24 ±219%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    281.00 ± 44%     -61.4%     108.43 ±141%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    384703 ±  3%     -38.7%     235662 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
    686350 ±  7%     -39.0%     418910 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
    126682 ± 11%     -55.8%      55944 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.min
     96784 ±  6%     -41.2%      56932 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.10 ±  5%     -16.3%       0.09 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.10 ±  5%     -15.6%       0.09 ±  6%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      1269 ± 35%     -72.4%     350.56 ± 89%  sched_debug.cfs_rq:/.left_deadline.avg
     15668 ± 39%     -69.9%       4722 ± 89%  sched_debug.cfs_rq:/.left_deadline.stddev
      1269 ± 35%     -72.4%     350.44 ± 89%  sched_debug.cfs_rq:/.left_vruntime.avg
     15666 ± 39%     -69.9%       4721 ± 89%  sched_debug.cfs_rq:/.left_vruntime.stddev
    384703 ±  3%     -38.7%     235662 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
    686350 ±  7%     -39.0%     418910 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
    126682 ± 11%     -55.8%      55944 ± 15%  sched_debug.cfs_rq:/.min_vruntime.min
     96784 ±  6%     -41.2%      56932 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.10 ±  5%     -16.3%       0.09 ±  6%  sched_debug.cfs_rq:/.nr_queued.avg
      1269 ± 35%     -72.4%     350.44 ± 89%  sched_debug.cfs_rq:/.right_vruntime.avg
     15666 ± 39%     -69.9%       4721 ± 89%  sched_debug.cfs_rq:/.right_vruntime.stddev
    121.24 ±  2%     -15.6%     102.37 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    179.42 ±  3%     -15.7%     151.32        sched_debug.cfs_rq:/.runnable_avg.stddev
    121.17 ±  2%     -15.6%     102.24 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    179.32 ±  3%     -15.8%     151.06        sched_debug.cfs_rq:/.util_avg.stddev
     48.56 ±  5%     -31.7%      33.15 ±  8%  sched_debug.cfs_rq:/.util_est.avg
    670.36 ±  3%     -19.3%     540.96 ±  4%  sched_debug.cfs_rq:/.util_est.max
    151.23 ±  2%     -23.5%     115.65 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    584.14 ±  4%     -16.3%     489.09 ±  4%  sched_debug.cpu.curr->pid.avg
      0.09 ±  5%     -16.0%       0.08 ±  5%  sched_debug.cpu.nr_running.avg
     63155 ±  8%     -20.8%      50021 ±  9%  sched_debug.cpu.nr_switches.max
      1.09           -11.9%       0.96        perf-stat.i.MPKI
  9.54e+09           +11.2%  1.061e+10        perf-stat.i.branch-instructions
  10950306            +8.6%   11888259        perf-stat.i.branch-misses
     50.90            +9.7       60.61        perf-stat.i.cache-miss-rate%
 1.029e+08 ±  2%     -17.8%   84632049        perf-stat.i.cache-references
      3878            -3.0%       3760        perf-stat.i.context-switches
      1.56 ±  2%     -28.5%       1.11        perf-stat.i.cpi
 7.516e+10           -20.6%  5.969e+10        perf-stat.i.cpu-cycles
      1435 ±  3%     -18.5%       1170        perf-stat.i.cycles-between-cache-misses
 4.821e+10           +11.1%  5.357e+10        perf-stat.i.instructions
      0.64 ±  2%     +39.5%       0.90        perf-stat.i.ipc
    157.22           +11.7%     175.61        perf-stat.i.metric.K/sec
  15093027           +11.7%   16858863        perf-stat.i.minor-faults
  15093027           +11.7%   16858863        perf-stat.i.page-faults
      1.09           -11.8%       0.96        perf-stat.overall.MPKI
     50.84            +9.8       60.60        perf-stat.overall.cache-miss-rate%
      1.56 ±  2%     -28.5%       1.11        perf-stat.overall.cpi
      1437 ±  3%     -19.0%       1163        perf-stat.overall.cycles-between-cache-misses
      0.64 ±  2%     +39.8%       0.90        perf-stat.overall.ipc
 9.509e+09           +11.2%  1.057e+10        perf-stat.ps.branch-instructions
  10897526            +8.6%   11839951        perf-stat.ps.branch-misses
 1.026e+08 ±  2%     -17.8%   84350011        perf-stat.ps.cache-references
      3863            -3.0%       3746        perf-stat.ps.context-switches
 7.492e+10           -20.6%   5.95e+10        perf-stat.ps.cpu-cycles
 4.805e+10           +11.1%  5.339e+10        perf-stat.ps.instructions
  15043853           +11.7%   16803787        perf-stat.ps.minor-faults
  15043853           +11.7%   16803787        perf-stat.ps.page-faults
 1.461e+13           +11.1%  1.624e+13        perf-stat.total.instructions
     98.44           -31.2       67.19        perf-profile.calltrace.cycles-pp.testcase
      4.76 ±  4%      -0.8        3.98        perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.87            +0.1        1.00        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range
      0.86            +0.1        1.00        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.zap_pte_range.zap_pmd_range
      0.93            +0.1        1.07        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.58 ±  2%      +0.2        0.80        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      0.56 ±  3%      +0.2        0.79        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.62 ±  2%      +0.2        0.85        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
      0.62 ±  2%      +0.2        0.85        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.59 ±  2%      +0.2        0.82        perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range
      0.65 ±  2%      +0.2        0.90        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault.testcase
      0.57            +0.2        0.82 ±  2%  perf-profile.calltrace.cycles-pp.error_entry.testcase
      0.64 ±  2%      +0.3        0.90        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.fault_dirty_shared_page.do_shared_fault.do_pte_missing
      0.57 ±  2%      +0.3        0.84 ±  2%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.64 ±  3%      +0.3        0.93        perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.44 ± 44%      +0.3        0.74        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault.exc_page_fault
      0.68 ±  2%      +0.3        0.99        perf-profile.calltrace.cycles-pp.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.43 ± 44%      +0.3        0.74        perf-profile.calltrace.cycles-pp.___perf_sw_event.__perf_sw_event.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.80 ±  2%      +0.3        1.12        perf-profile.calltrace.cycles-pp.file_update_time.fault_dirty_shared_page.do_shared_fault.do_pte_missing.__handle_mm_fault
      1.67            +0.3        2.01        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.80            +0.4        1.16        perf-profile.calltrace.cycles-pp.__perf_sw_event.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.94 ±  2%      +0.4        1.31        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_shared_fault.do_pte_missing.__handle_mm_fault
      1.44 ±  3%      +0.4        1.82 ±  3%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.70 ±  2%      +0.4        1.09 ±  5%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_add_file_rmap_ptes.set_pte_range.finish_fault.do_shared_fault
      1.04            +0.4        1.44        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range.zap_pmd_range
      0.73 ±  2%      +0.4        1.15 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
      1.15 ±  2%      +0.4        1.58        perf-profile.calltrace.cycles-pp.tlb_flush_rmap_batch.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
      1.17 ±  2%      +0.4        1.61        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      3.32 ±  2%      +0.5        3.84 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_fault.__do_fault.do_shared_fault
      1.06 ±  2%      +0.5        1.60 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_file_rmap_ptes.set_pte_range.finish_fault.do_shared_fault.do_pte_missing
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.08 ±223%      +0.6        0.66        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.do_user_addr_fault
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.59 ±  6%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__lruvec_stat_mod_folio.folio_add_file_rmap_ptes.set_pte_range.finish_fault
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_shared_fault.do_pte_missing
      1.57 ±  9%      +0.6        2.19 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.59 ±  2%      +0.6        2.22        perf-profile.calltrace.cycles-pp.fault_dirty_shared_page.do_shared_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.current_time.inode_needs_update_time.file_update_time.fault_dirty_shared_page.do_shared_fault
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.down_read_trylock.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.pte_offset_map_rw_nolock.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.55 ±  2%      +0.7        2.28 ±  2%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_shared_fault.do_pte_missing.__handle_mm_fault
      4.56 ±  2%      +1.0        5.59 ±  2%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_shared_fault.do_pte_missing
      4.90 ±  2%      +1.2        6.10 ±  2%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_shared_fault.do_pte_missing.__handle_mm_fault
      5.11            +1.2        6.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.11            +1.2        6.31        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.96            +1.2        6.16        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      4.97            +1.2        6.17        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      4.97            +1.2        6.18        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.94            +1.2        6.15        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.03            +1.2        6.24        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.03            +1.2        6.24        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.98 ±  9%      +1.2        6.22        perf-profile.calltrace.cycles-pp.finish_fault.do_shared_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      4.71            +1.3        5.98        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      4.73            +1.3        6.01        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      4.73            +1.3        6.01        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      4.73            +1.3        6.01        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      5.19 ±  2%      +1.3        6.52        perf-profile.calltrace.cycles-pp.__do_fault.do_shared_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      7.24            +2.8       10.05        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.testcase
     12.18 ±  3%      +3.4       15.57        perf-profile.calltrace.cycles-pp.do_shared_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     12.38 ±  3%      +3.5       15.88        perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     14.75 ±  3%      +4.7       19.47        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     17.41 ±  2%      +5.1       22.53        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     26.13 ±  2%      +5.4       31.56        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     25.28 ±  2%      +5.6       30.83        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     85.39           +27.2      112.59        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
     30.32 ±  3%     -20.3       10.03        perf-profile.children.cycles-pp.native_irq_return_iret
     93.95            -1.7       92.29        perf-profile.children.cycles-pp.testcase
      4.86 ±  4%      -0.8        4.08        perf-profile.children.cycles-pp.lock_vma_under_rcu
      2.45            -0.3        2.19        perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.kthread
      0.06 ±  7%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.schedule
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      0.06 ± 11%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.27 ±  2%      +0.0        0.29        perf-profile.children.cycles-pp.tick_nohz_handler
      0.29 ±  2%      +0.0        0.31        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.04 ± 45%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__pick_next_task
      0.04 ± 44%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.clockevents_program_event
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.07            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.vma_is_anon_shmem
      0.09 ±  6%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ktime_get
      0.07 ± 10%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.08 ±  4%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.sched_balance_domains
      0.07 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.pte_mkwrite
      0.10 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.free_swap_cache
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.irqentry_enter
      0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      0.24 ±  3%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.native_flush_tlb_local
      0.09 ±  6%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.05 ±  8%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.06 ± 13%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.alloc_pages_noprof
      0.02 ± 99%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.error_return
      0.02 ± 99%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.arch_check_zapped_pte
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.idle_cpu
      0.07 ±  9%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.11 ±  5%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.35 ±  2%      +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      0.11 ±  5%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.pte_alloc_one
      0.10 ±  3%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.irqentry_exit
      0.15 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.11 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.vm_normal_page
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.queued_spin_unlock
      0.28            +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.intel_idle
      0.36 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.13 ±  8%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.p4d_offset
      0.28 ±  3%      +0.1        0.35 ±  3%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.35 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__x2apic_send_IPI_mask
      0.46 ±  2%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
      0.22 ±  3%      +0.1        0.29 ±  7%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.36            +0.1        0.43        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.17 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.__irqentry_text_end
      0.16 ±  3%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.16 ±  3%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.xas_start
      0.19 ±  5%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.19 ±  3%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.do_softirq
      0.22 ±  3%      +0.1        0.30        perf-profile.children.cycles-pp.folio_mapping
      0.20 ±  4%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.23 ±  2%      +0.1        0.32        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.34 ±  4%      +0.1        0.43 ±  6%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.27 ±  2%      +0.1        0.38        perf-profile.children.cycles-pp.perf_exclude_event
      0.34 ±  9%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.rest_init
      0.34 ±  9%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.start_kernel
      0.34 ±  9%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.34 ±  9%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.28 ±  3%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.perf_swevent_event
      1.02            +0.1        1.14 ±  2%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      1.02            +0.1        1.14 ±  2%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.31 ±  4%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.32 ±  4%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.up_read
      0.55 ±  2%      +0.1        0.68        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.08            +0.1        1.21        perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.51 ±  2%      +0.1        0.64        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.38 ±  2%      +0.1        0.52        perf-profile.children.cycles-pp.folio_unlock
      0.40 ±  3%      +0.1        0.54 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.32            +0.1        0.46        perf-profile.children.cycles-pp.__mod_node_page_state
      0.34 ±  4%      +0.1        0.48        perf-profile.children.cycles-pp.access_error
      1.20            +0.1        1.35        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.39 ±  5%      +0.2        0.54 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      0.40 ±  3%      +0.2        0.56        perf-profile.children.cycles-pp.folio_mark_dirty
      0.44 ±  2%      +0.2        0.61        perf-profile.children.cycles-pp.folios_put_refs
      1.32            +0.2        1.49        perf-profile.children.cycles-pp.__sysvec_call_function
      1.43            +0.2        1.62        perf-profile.children.cycles-pp.sysvec_call_function
      0.50 ±  2%      +0.2        0.71        perf-profile.children.cycles-pp.current_time
      0.50 ±  2%      +0.2        0.71        perf-profile.children.cycles-pp.down_read_trylock
      0.57 ±  2%      +0.2        0.79 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.53 ±  2%      +0.2        0.76        perf-profile.children.cycles-pp.pte_offset_map_rw_nolock
      0.62 ±  2%      +0.2        0.85        perf-profile.children.cycles-pp.tlb_flush_mmu
      0.62 ±  2%      +0.2        0.85        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.62 ±  2%      +0.2        0.85        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.58 ±  2%      +0.2        0.82        perf-profile.children.cycles-pp.___pte_offset_map
      0.68            +0.2        0.93        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.69 ±  2%      +0.3        0.96        perf-profile.children.cycles-pp.inode_needs_update_time
      0.45            +0.3        0.75 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      0.45            +0.3        0.75 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.39 ±  5%      +0.3        0.70 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.71 ±  2%      +0.3        1.02        perf-profile.children.cycles-pp.handle_pte_fault
      0.48 ±  2%      +0.3        0.81 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.84 ±  2%      +0.3        1.17        perf-profile.children.cycles-pp.file_update_time
      0.83            +0.4        1.19        perf-profile.children.cycles-pp.error_entry
      1.76            +0.4        2.13        perf-profile.children.cycles-pp.zap_present_ptes
      0.81            +0.4        1.19 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.52 ±  2%      +0.4        1.92 ±  3%  perf-profile.children.cycles-pp.xas_load
      1.04 ±  2%      +0.4        1.45        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.08 ±  2%      +0.4        1.50        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.73 ±  2%      +0.4        1.15 ±  2%  perf-profile.children.cycles-pp.common_startup_64
      0.73 ±  2%      +0.4        1.15 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.73 ±  2%      +0.4        1.15 ±  2%  perf-profile.children.cycles-pp.do_idle
      1.17 ±  2%      +0.4        1.61        perf-profile.children.cycles-pp.tlb_flush_rmap_batch
      1.17 ±  2%      +0.4        1.61        perf-profile.children.cycles-pp.tlb_flush_rmaps
      3.39 ±  2%      +0.5        3.93 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      1.10 ±  2%      +0.6        1.66 ±  4%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      1.27 ±  2%      +0.6        1.84        perf-profile.children.cycles-pp.___perf_sw_event
      1.62 ±  9%      +0.6        2.23 ±  2%  perf-profile.children.cycles-pp.mas_walk
      1.70 ±  2%      +0.7        2.38        perf-profile.children.cycles-pp.fault_dirty_shared_page
      1.43 ±  2%      +0.7        2.11 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.56 ±  2%      +0.7        2.26        perf-profile.children.cycles-pp.__perf_sw_event
      1.61 ±  2%      +0.8        2.36 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      4.66 ±  2%      +1.1        5.72 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      4.96            +1.2        6.16        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      4.97            +1.2        6.17        perf-profile.children.cycles-pp.do_vmi_align_munmap
      5.03            +1.2        6.24        perf-profile.children.cycles-pp.__vm_munmap
      4.97            +1.2        6.18        perf-profile.children.cycles-pp.do_vmi_munmap
      4.94            +1.2        6.15        perf-profile.children.cycles-pp.vms_clear_ptes
      5.03            +1.2        6.24        perf-profile.children.cycles-pp.__x64_sys_munmap
      5.22            +1.2        6.44        perf-profile.children.cycles-pp.do_syscall_64
      5.22            +1.2        6.44        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.97 ±  2%      +1.2        6.19        perf-profile.children.cycles-pp.shmem_fault
      4.74            +1.3        6.01        perf-profile.children.cycles-pp.zap_pte_range
      4.74            +1.3        6.01        perf-profile.children.cycles-pp.unmap_vmas
      4.74            +1.3        6.01        perf-profile.children.cycles-pp.unmap_page_range
      4.74            +1.3        6.01        perf-profile.children.cycles-pp.zap_pmd_range
      5.13 ±  9%      +1.3        6.42        perf-profile.children.cycles-pp.finish_fault
      5.26 ±  2%      +1.4        6.62        perf-profile.children.cycles-pp.__do_fault
      7.34            +2.8       10.13        perf-profile.children.cycles-pp.sync_regs
     12.28 ±  3%      +3.4       15.71        perf-profile.children.cycles-pp.do_shared_fault
     12.44 ±  3%      +3.5       15.98        perf-profile.children.cycles-pp.do_pte_missing
     14.86 ±  3%      +4.7       19.60        perf-profile.children.cycles-pp.__handle_mm_fault
     17.54 ±  2%      +5.1       22.68        perf-profile.children.cycles-pp.handle_mm_fault
     25.91 ±  2%      +5.3       31.26        perf-profile.children.cycles-pp.do_user_addr_fault
     26.20 ±  2%      +5.4       31.64        perf-profile.children.cycles-pp.exc_page_fault
     60.17           +18.0       78.20        perf-profile.children.cycles-pp.asm_exc_page_fault
     30.32 ±  3%     -20.3       10.03        perf-profile.self.cycles-pp.native_irq_return_iret
      2.69 ±  5%      -1.5        1.14        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.native_sched_clock
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.irqentry_enter
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.vma_is_anon_shmem
      0.22 ±  5%      +0.0        0.25 ±  4%  perf-profile.self.cycles-pp.flush_tlb_func
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.11 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.tlb_flush_rmap_batch
      0.02 ± 99%      +0.0        0.06        perf-profile.self.cycles-pp.free_swap_cache
      0.23 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.13            +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.02 ± 99%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.pte_mkwrite
      0.10 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.vm_normal_page
      0.35 ±  2%      +0.0        0.39 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      0.10 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.41            +0.0        0.46 ±  2%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.02 ± 99%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.ktime_get
      0.13 ±  2%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.09 ± 14%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.p4d_offset
      0.12 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.xas_start
      0.14 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.file_update_time
      0.18 ±  3%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.intel_idle
      0.15 ±  3%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.28 ±  3%      +0.1        0.35 ±  3%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.18 ±  6%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.21 ±  3%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.exc_page_fault
      0.22 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.zap_pte_range
      0.18 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.folio_mapping
      0.18 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.perf_exclude_event
      0.16 ±  2%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.intel_idle_xstate
      0.21 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64_mg
      0.21 ±  2%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.pte_offset_map_rw_nolock
      0.24 ±  2%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.perf_swevent_event
      0.18 ±  2%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.do_pte_missing
      0.24 ±  2%      +0.1        0.34 ±  3%  perf-profile.self.cycles-pp.fault_dirty_shared_page
      0.20 ±  4%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.handle_pte_fault
      0.27 ±  4%      +0.1        0.37 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.29 ±  5%      +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.up_read
      0.27 ±  3%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp.current_time
      0.22 ±  3%      +0.1        0.33        perf-profile.self.cycles-pp.__do_fault
      0.32 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.folio_unlock
      0.27 ±  6%      +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
      0.28 ±  2%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.__perf_sw_event
      0.23 ±  4%      +0.1        0.35        perf-profile.self.cycles-pp.do_shared_fault
      0.32 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.31 ±  5%      +0.1        0.43        perf-profile.self.cycles-pp.access_error
      0.29            +0.1        0.42        perf-profile.self.cycles-pp.__mod_node_page_state
      0.34 ±  2%      +0.1        0.48        perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.42 ±  2%      +0.2        0.57        perf-profile.self.cycles-pp.set_pte_range
      0.31 ±  2%      +0.2        0.47        perf-profile.self.cycles-pp.shmem_fault
      0.31 ±  3%      +0.2        0.47 ±  7%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.44 ±  2%      +0.2        0.60        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.44 ±  2%      +0.2        0.60        perf-profile.self.cycles-pp.folios_put_refs
      0.47 ±  2%      +0.2        0.66        perf-profile.self.cycles-pp.down_read_trylock
      0.51 ±  3%      +0.2        0.71 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.24            +0.2        1.45        perf-profile.self.cycles-pp.zap_present_ptes
      0.53 ±  2%      +0.2        0.74        perf-profile.self.cycles-pp.___pte_offset_map
      0.56 ±  2%      +0.2        0.80        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.66            +0.2        0.90        perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.60            +0.3        0.89 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.73            +0.3        1.05        perf-profile.self.cycles-pp.error_entry
      1.33 ±  3%      +0.3        1.65 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.80 ±  3%      +0.4        1.18        perf-profile.self.cycles-pp.___perf_sw_event
      0.99            +0.4        1.38        perf-profile.self.cycles-pp.finish_fault
      1.08 ±  2%      +0.4        1.51        perf-profile.self.cycles-pp.shmem_get_folio_gfp
      1.55 ± 10%      +0.6        2.14 ±  2%  perf-profile.self.cycles-pp.mas_walk
      1.57 ±  5%      +0.8        2.39 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      7.32            +2.8       10.09        perf-profile.self.cycles-pp.sync_regs
     27.69            +9.9       37.60        perf-profile.self.cycles-pp.testcase




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


