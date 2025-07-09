Return-Path: <linux-kernel+bounces-723133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2748AFE352
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B3E3B37E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3CB280A52;
	Wed,  9 Jul 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp+kFQ9c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FD27FD75
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051420; cv=fail; b=KuWjVLbBSZhjpLBdWRK4vlOiLGpKUGOWF74nFX6yEsBJwo3238jcZq5HuQLAUUJ7cwWzQnWGpDGZLpgovNWW+PoqWMtXBlBCxPeKSeJUjr1a4e7m9hFU1jeugMjTcTHAQgss8+M/rQqlHqKgN5Mf1b7SubBohtYIDDX+vk785Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051420; c=relaxed/simple;
	bh=vgzXE8afF7A0rhn4JrORtM51y6H0GGu9GEkNW/LBh2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rVzPAc1H01THc5IU3zT9EMxkSVbzlko6naX7AnSHKIxGxEXvG5ylNTRDjaaLLBMMvOAJgh0Jw5BOQas7sIZvVY5Prm+Ng86zHDrV85p0SoHujduYccVOniMi+OeJsoqTFVz/evzpWpk5fx3rb8RO/jycANkoVFd7LdZVv7t+w6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp+kFQ9c; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752051419; x=1783587419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vgzXE8afF7A0rhn4JrORtM51y6H0GGu9GEkNW/LBh2I=;
  b=fp+kFQ9cO5hwenyWgkv17eSHgRLyjdQKsvAk52fCqyAoGVIFKhJzsBUV
   rjl+tQfmQS+fnH5/HXiTi9QNWYOHy3zqadTx5nxKFLJxWVj34oh5xs5q/
   WFsItULQ/fz0jWj7yQUTIjSuCWv2oKb1Y+9eP3A8wYTpiKO7ik5aXExuG
   Rn4Fv4r43uXyRcYr8IjU+iap5S/3mj6v6knGEr90IjIIPfNO9+109nYHo
   v1fDjbVD8aWn1KdbEbSda9fSVFsdHzlvCa0Y4LQF9q3jxp3lVqPWnUG2n
   Q91bDt8SRHVKiUh9GRVF68t9yOD9HkDwoXkteddgOrCwxOW911LIfFdYJ
   A==;
X-CSE-ConnectionGUID: vpSjNAw+QuqZSLN1H3eGKA==
X-CSE-MsgGUID: ZeszxU77SvGb5ZtEbwXDoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54447880"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54447880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:56:58 -0700
X-CSE-ConnectionGUID: 56IB/oMWShmPSqNilWuX7w==
X-CSE-MsgGUID: sr2r9vtrQeWxm3inZ2moDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186724781"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:56:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 01:56:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 01:56:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 01:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPj/PAGRQx6ra6f4RCGOv7gu4SAO970J9AHK3wyPVsrwfsdkgeLN58OS3k7PvEs7NvkAMqS/r0wLQi7UA8ib/VDRNvVtC3H1oJ32pqTia0e+SgNiKtDzx3O7YEKo6h8Jg5QpLil44XLoA5OCn2JjDPbPhGdUn0jTFl3JjrHTZJA+TuDinsI1sfbHrC0Rao1jUpSDivHJIW9IjsaKZ9cm88leaoKPx20LEHQI9Lz7y+RtLvv7bW21j16XxPesAww8A90quVyT4b/Zd2+TFqSFCXXG+aAqHCDhhH5b1lYSqiT8E284Xgl2dD12cwT/DywP1wcFuML7PBALImlhFELrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5nw/bcF4oXPTUeCWbVyPpHsrtC/DPm0a1RgdJ45jzE=;
 b=dv85FVdndweidkAph0hRbSAcqlKc7MLsL1knA/aL+VGg+OvE2iw4p9pnAwtBIgGJAo2UlWbusqfnI146xSN8rS+u6cFjXiQMYCI2jqEXhVruTeJmLbhGxkMpscAg45t9F9NFlb6Slvj1zCAaTp33/1VWom5rD46lcxsohxhjmLDy7XLgIaLtncw2MtPX8yeMeFMiB4TpN1NO45fEiWI46ylC3VLVMq3IUQHDgL4nIN4oNIeImjAyMmvjIFtjeMEG+HJKKDdtuFUXf09IqiguZTQ+KvygcfqmUN4dsnCsvxf3E4XDZb8FHJwozxFfu9vMJSzIN5MbWUDnzggNxkTXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 08:56:43 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%6]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 08:56:42 +0000
From: "Li, Philip" <philip.li@intel.com>
To: "Deng, Pan" <pan.deng@intel.com>, lkp <lkp@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org"
	<mingo@kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Tianyou"
	<tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 3/4] sched/rt: Split root_domain->rto_count to
 per-NUMA-node counters
Thread-Topic: [PATCH 3/4] sched/rt: Split root_domain->rto_count to
 per-NUMA-node counters
Thread-Index: AQHb78nbO9mVovvEEUe6nrCYlBc7+bQoQm+AgAE8G8A=
Date: Wed, 9 Jul 2025 08:56:42 +0000
Message-ID: <PH0PR11MB56746CA201023FEE6D47B244E049A@PH0PR11MB5674.namprd11.prod.outlook.com>
References: <2c1e1dbacaddd881f3cca340ece1f9268029b620.1751852370.git.pan.deng@intel.com>
 <202507081317.4IdE2euZ-lkp@intel.com>
 <BL1PR11MB6003439ECD3790035E99E5AF964EA@BL1PR11MB6003.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB6003439ECD3790035E99E5AF964EA@BL1PR11MB6003.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5674:EE_|PH7PR11MB7516:EE_
x-ms-office365-filtering-correlation-id: 3a2f0d5c-990b-4eea-373f-08ddbec686a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dgRqh3TZzuZg2FwNqA8PWt7fh5woL9nEmryqaan76LI5QbQ3oVJucUVoYhmF?=
 =?us-ascii?Q?zmMYMvKy7O8/IEz0l0Dh1GEN45nN3MsK6kAbvtsiRF68dKMLk3V7Apf7CQlV?=
 =?us-ascii?Q?16izIdFcJBg9N3amy7tHL5Sz/ipK2kv8Z08WjtqPVEcSJFMseuCBjzLu6TkQ?=
 =?us-ascii?Q?j7pVIM/f8UnBAdVozWpWsTGtUV+ZDCDCkJGigX+WcS4E180KKuUvEBLLPvMc?=
 =?us-ascii?Q?Oa7mbQd3T74GAVxZZHM/QEiRg4afIXkN0Jse2fS7HgbS0XB1m/xGId2ZYe0b?=
 =?us-ascii?Q?i54ZYxzJDxisdAMoziJyzfXiBqRr/f5LbE+WLQZFbfeBwlgBByhfGrnQKnWA?=
 =?us-ascii?Q?lQJhE4/GcvBrHn/svjkuNsblQe+PDmbHsP7uW0WVSHWM3ldsZejakydGOaX8?=
 =?us-ascii?Q?FncrctTdfExtQSIdO6zkiel6UiCAR/luxwSh+39nZ1VTtyn796comC0fbpYZ?=
 =?us-ascii?Q?2u5uxKAnUKEVMxG84Q/ue/JcaYGwcpWcsTW7vab/iY4Tt33KagvpLl14u6mL?=
 =?us-ascii?Q?upgCUmK+mfIqlEdUnywp6svXyI7B90eMCf30Rah1i3rfSIj7+t2UiZTq/ecQ?=
 =?us-ascii?Q?pLP6da8H5fJeFajtKBrQc7IjUQPyJOQnatRfDjkQBkF9DzJxAkWKyan+XW6T?=
 =?us-ascii?Q?7ZIazdTuiy1r1WiRSO2eScmtx/bCoIVGBQbfNTKjHSjka3FjdO9np+9Wi5pd?=
 =?us-ascii?Q?uwk7zxixZRHgqGj0s10tShVTzF3nKllUGilDsGLbm7EOi3cXGVCJC4lbS0b6?=
 =?us-ascii?Q?T5tsefB3+1EiKopk1jS9PEDjWhCulJ4Q7cBY32+d2ZBlbGkg3MvnrypMjsqg?=
 =?us-ascii?Q?1qVno8+1rY6hufhWnyBDZoyVgEhWnvbK/7HXBJGc9gNVhq314clra4d+YyCn?=
 =?us-ascii?Q?LdXGlZnuzPqnEvwUPuNHpkrbYjkX6fdGFARG8jftUX1CrXoi5N3Rq6vtr+4L?=
 =?us-ascii?Q?A/8aqa5qOHsG6dziSKUFT8FPDOTBc2QLhLyfu5CqJJiBLt2DMwvNX/tDMzZ/?=
 =?us-ascii?Q?cf839ZemDCpbtFLsqbO3eWooLefJdXwOFLLqzUWHYri+GbaBhAHykZyfPByv?=
 =?us-ascii?Q?gmgy83SF/B2sKujCanVBA9g95dLdNRqc98mr9NNkqSnYYAAGvFmTnehltk8d?=
 =?us-ascii?Q?wOD8GmL6MXmrMvbF+cMWuXnrnT/Tlq6DUX91UIxvu/dV388F2GdtP+2eV9dC?=
 =?us-ascii?Q?VuhKGoW233hnLYMnTgstbewCq/PU+45HqoxaEVelFiJUpdqO+qxQFH/17/4W?=
 =?us-ascii?Q?5Q6xWgHbJkybQU7xzqWkVo1JBL+wm2naUmlztlIWY6V1Jc2qLa/9TQ1nqJzT?=
 =?us-ascii?Q?EYrRqcqZ8TbP1+nOW+VLK/7aXqU5Y0M7GPzZjPsSnbgzRUbt+2mn7vkZUGqK?=
 =?us-ascii?Q?oRvWkXX8jpqgRalEyycSmC+1PosABNe/EwMQ6Gd3ZgTpC9ds/rSgOkKQLmLQ?=
 =?us-ascii?Q?mFSNPUORKO42uK15Co1EYaSXcrPDQoyuu3tu7IROZtawxbG3+K243A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+gBOC4PZOhqLBkKDv4zeRNiKlclY63QTds2Tki21Mvg/1cMLfzG1GHuwOg2U?=
 =?us-ascii?Q?o5e7OPA9v/yorxr4oaS7hvtkTybRm0HZG5kpHqVPpxljJC2kjpEu7Lsb5kkZ?=
 =?us-ascii?Q?iAHvv1PDOhViVv3m2Zs4Ew9fZGILrWk9dPLT6lTXtmftgfl591yUhSomK7Hr?=
 =?us-ascii?Q?orvWjG/9cpaPSCAnvcxBPwRO1M57a8IIjK1M8GvGJjeIh3UN/tCCys/wWUwg?=
 =?us-ascii?Q?hNB3YdNUSuPZTqRQwuFxdJT3Lqul86IMp5Rl8xyLtLEr1j9qD3gUBy48CUjA?=
 =?us-ascii?Q?szqipS0AwTHKEx0uJpTebwKva84K2Fud8KzHViroY8x/ErGvpiD7GLn/QbZL?=
 =?us-ascii?Q?NOkfk/rfDDjCpP+zjM1rc6EenCDd6JLdKrqSsyjPQXqOF9B71FJ8vLgVikyI?=
 =?us-ascii?Q?enoM093JPjlw4i+fQYqCIuvz8MKisnj51MUBzQrR2r/AFDR+l79n1Ioz5Klq?=
 =?us-ascii?Q?IdqRX0QF2BXKNP4btHhpXoOhPkwS5Vi1YE9Em/6VPQNIqKCLVoFCStwO8fXA?=
 =?us-ascii?Q?FR9kadmtNV+Mfp04hvTW1kPGcc4xOJ/RkBnn3d4dIBdzabSe5bQGLxo0Nber?=
 =?us-ascii?Q?G32ZZ7nDE4jmEIZk0OkWvvawDByxYwxTAyDVsTIuEcFsevlQFjVz4z//O3U4?=
 =?us-ascii?Q?S/EcfpzB1fYbVzeC4cmsKkM7d8mA6LWmLKkfvfa/Ao/qtNK84zAcTK6GKkiI?=
 =?us-ascii?Q?m+1y0k7W0GVb7FD6ubAV8gEPykxAR4lEe68JX7hJQvFpkiug3e9A8MjEGARg?=
 =?us-ascii?Q?hsYEwgdPNLsUuFkIeuMUlLNYTrUIWSuz+EFnbc6W706+3TDZYJjWXK7hH1q/?=
 =?us-ascii?Q?kpV8HZs0/ZMCfu3uv65jWKPytZRY8+mNR1WxWtUsyux6GwpLrwL6vLpjit2x?=
 =?us-ascii?Q?ZKanVEmQ8t/YhfffezAuh7iNoHJ7Pg+rgwcM8gylrcVkxgFNSd20Ow0H07KP?=
 =?us-ascii?Q?XLcGAEMGL+V0mw2eNJBNPAwc8aAghEJpuzR6P/XaIcGVtFbGyLwj6+DwhxLn?=
 =?us-ascii?Q?AEpGAWnRTSqb4ZAdjN7MdVrfUZNFJLSa+Rd8AInsmtpR0SL54e7cIuvEDSrJ?=
 =?us-ascii?Q?9kYUfzuZ2jtGe1qNAj8s0otj1RuPT81XbHqToMaD28Rb+/PuGl+a0lCraIIv?=
 =?us-ascii?Q?bc8AoGqk767RRnlimbqgmrxtq2TDGbolxtejLFxPiADdHLq0dbLclqcKLKsU?=
 =?us-ascii?Q?VgxX1p8R4UyO9Q4TyTjjzxXjMA8ZCv/9FMEmY3vxD1rgM1X4YXZ8GiL2Kvyy?=
 =?us-ascii?Q?MWS8B/TsqeQa1cM2zsj7P/PWJlykhMUGbymvY7OLmFduUkHOCN2xXIZ42Jd4?=
 =?us-ascii?Q?wxrKF9Oe8OM8W9/y97PTRi/JhV7/WFbOATw5HoCub7FlTFfaiEoLaxeNHdBd?=
 =?us-ascii?Q?X2+okA6h2VN/rKjQh9wjOfs+zg6CV5KU5edoSpUM0W7WSE5nLVeQrXMeJ1YM?=
 =?us-ascii?Q?vNzKGIdymfaNuK/r5ClCHU8MtM7yg57ZVcW3atmiZVqgDng9DWlzEzp5455F?=
 =?us-ascii?Q?G40KhTOBMmLViq1T2dtIhd+eroclZ4huUL7jCQkI92XcXglPRwdUD/CS5esB?=
 =?us-ascii?Q?dO49HykpZBDOiIFBBlwFR5m7Zf2yMB3E1vwbUrJA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f0d5c-990b-4eea-373f-08ddbec686a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 08:56:42.7834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoxaTeCpzAwek4oKMTf1y1EktS3fcigOkXohsoD/45niKgCyJZxMpb+dm1o90XGduuJzDQZfOUsMI3VHH6FrAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com

> > comparison expression (different address spaces):
> >    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef=
] __rcu *
> >    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
> >    kernel/sched/sched.h:2276:25: sparse: sparse: incompatible types in
> > comparison expression (different address spaces):
> >    kernel/sched/sched.h:2276:25: sparse:    struct task_struct [noderef=
] __rcu *
> >    kernel/sched/sched.h:2276:25: sparse:    struct task_struct *
> >    kernel/sched/sched.h:2287:26: sparse: sparse: incompatible types in
> > comparison expression (different address spaces):
> >    kernel/sched/sched.h:2287:26: sparse:    struct task_struct [noderef=
] __rcu *
> >    kernel/sched/sched.h:2287:26: sparse:    struct task_struct *
> >    kernel/sched/build_policy.c: note: in included file:
> >    kernel/sched/rt.c:2413:45: sparse: sparse: dereference of noderef ex=
pression
> >    kernel/sched/build_policy.c: note: in included file:
> > >> kernel/sched/sched.h:2627:35: sparse: sparse: incorrect type in init=
ializer
> This warning is not about the change we made, @lkp, could you please chec=
k it?

Sorry for this false report, it should not be related to your changes. We w=
ill follow
up to figure out what is wrong during the bisections. Sorry for wasting you=
r time.

