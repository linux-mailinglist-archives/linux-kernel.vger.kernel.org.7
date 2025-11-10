Return-Path: <linux-kernel+bounces-893960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B9C48F63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1564200A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CD31B127;
	Mon, 10 Nov 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxaS6+I+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314F30FF1D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801364; cv=fail; b=u3yyDTH/KFyjR/pe3CCzvAq3OB56ywIBdvPxFbzCwOws6pIogsyjagW9dqvEldpzqkxx4MYTjDNc5SPV9wsiY0QAf58Jp0CSmj9cEcb9P+YrnF+qucr7xSyrOix/bh619DOQZjava10cJirlbrPnEmXuR91Hw8XRa1M+00eNTbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801364; c=relaxed/simple;
	bh=xxuMpH5+wcSOUw7EZpbevVfsDAuXxVb1v9bAL05mk/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=floA7VxGTBZaLrqPsKcDCRmwi7kMp4ysMQMhwZw/le4pbXrA4LkYhZRihwPJVgF6HTZeH1QvPAW3OtciLZoPt2m561OUPa51yyKMM2P5ENXNoEe0XCabyxNgfpOZL6Aips27AkyIrSqW7rHP1cRGY4EG3jtNDl2fQ2L9fCzdw8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxaS6+I+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762801363; x=1794337363;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xxuMpH5+wcSOUw7EZpbevVfsDAuXxVb1v9bAL05mk/s=;
  b=KxaS6+I+IVJQH3DtL+BJK0407hskp60h9v/Ki+r2NC8Jj17znKKEpwXL
   5Gi0+z1rDqbkJTL/8W+IHVqNFoz7Kry/fPiDle9vsqOs5obT3TTq/bseG
   1ngYcXoXdafpme/OiVizBeN9jVUvtRpJLGQaKJZ0eGQnOBJSaZewUAKEh
   TSeDvLdyYsPvgEkv6cq+8pJHsOtFfyHTlZ1vOz79QIj5/2oYezrnXagFr
   q8yW/0Te1l08cIXh99EMxSOxrI6J5IXJtztDGPgLX8Gq7UXGQlE4xOltY
   VSyagZQ0dRkvCWMIgBI0kIXOROQNDL5sMgT+VEF1EqcCE9g62yVxpChyC
   g==;
X-CSE-ConnectionGUID: B/+INRh4T1W4OQu815CyQg==
X-CSE-MsgGUID: ETcDdHmwQh6b8eQmV1g2HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64947285"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64947285"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 11:02:42 -0800
X-CSE-ConnectionGUID: qRNOXtoDRxqs1YF9nuneZg==
X-CSE-MsgGUID: Ej8tPIxKShSnVO5yaGNAog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="193935654"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 11:02:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 11:02:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 11:02:41 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 11:02:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNMtRXnyfcVDUdjHLwk2s9FKTErViozv4ANuPWhFVW0GmKD5zL35uBnX3s2qwZDRJdplRlrWaVOtdNGj8JWhWKpnWZHBNDerzI34jrmuOz5q3KSN8tLa6ADDJIocpCT1B7Z43iLo0NgBW2IFt4zM4+n0YyI22gTwK/XsplT64g3fZ5jcxFRn5wgyXsVPsEUhp1a4OvzttkrazCgdiCMdcdYlTb8GJ+Fp4icucGOsfAYOEgyT0OIAHZajJiMEJpliEIhinDFry8DYafPrL3z9FoMtmvIWxOocnvuW+THJaIaB/D7XOWTylKrfaSYUHJ0NiPvJP0l+om3Geo7Q72w06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aXQTbcr4gyP9rB5auPtGs3mrG3hkHuVt0GZJLQhTm4=;
 b=Yim3hQh1WcMys1RO44eY4CCbaIa1Iy3hZnvL4bgLIPxT/8Jwc5GD1N415gkMVlDgbqRFUk2Y2bR0t54w7/XckloS4hI0x7/Zg5MLYosKeoKmqrIAD9CQPimET7fYtEUVvQefOZZitMlow8depL5SoNbdH631Fnbtgktf9Av7wNGr7BItOrX6dPOSjRF2b1DhZDG2h5rdHmmms8ThMnAlVF4Z68kLdzG54ASL5dN2LOWE8+Bd36UGiocV4zHuFVcu0FD1I8V2WJvkcI927QoVZAYdnae3stPHM0ghZkuLOh85BQNoXdXzq5yM7a3Lx5GhNWtqdBeMY8bd2SbS5HKj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:02:33 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:02:33 +0000
Date: Mon, 10 Nov 2025 14:02:30 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
CC: <lucas.demarchi@intel.com>, <thomas.hellstrom@linux.intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "kernel
 test robot" <lkp@intel.com>
Subject: Re: [PATCH] drm/xe: fix kernel-doc function name mismatch in xe_pm.c
Message-ID: <aRI2xnMDl2h4icmr@intel.com>
References: <20251110184206.2113830-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110184206.2113830-1-kriish.sharma2006@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f67cf6d-ea48-440e-eff3-08de208bb457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/ZClTjgubOp36nMijHhvZLj9EGTiWUwcG26x//laaAeiHhnyO5dDTqZSx0w?=
 =?us-ascii?Q?hBkC9pM4gIfZ74liNBH2Stps+T97ZKejrynVfjW0q41K9bmoS8QyRRP7gdYR?=
 =?us-ascii?Q?IQUPpr14NAGnjILKCH//JM1WMz7+KnCxGjU4lK6gvAQu1w09dM/E++GLdL9l?=
 =?us-ascii?Q?beAXuXPWXZ8I1FJ/Gmfe+0LDdeWXV9IDY88HPbkqmtflgUVzIgaztlgbGSbe?=
 =?us-ascii?Q?pSIyX7K15cplp8NE5tohJoYf+5x0W5lUBcACy9VwggB661qHHWIMIQNsEzIT?=
 =?us-ascii?Q?PRfZ8WO/f3ceePSkoJSt4PDgA8BTm7geBszT93z3gbWOm5kl0Avezyh4Z2f0?=
 =?us-ascii?Q?pGPlFd4YM9wRs2ry0Ycs/tAAZ1WSdMjaRqgQSSISf1EG0izzJhF/3CNJhro0?=
 =?us-ascii?Q?bFG6OMWRhFGVrR7HRj39dKUqDVXg1qctKckE/SBf6+tVdM8gF9BSpxDPQ9aq?=
 =?us-ascii?Q?RiMTQyRfbQtVY7GEC0Fi7b89P20DDLDpAah/BZUHwdHA9xlE5MjyG0CrnlK0?=
 =?us-ascii?Q?pTmOP49/tWroPiPHGM5QL0/60+bgtfbxUiDFUn3WckXLoDtjHFxMRYXdDOtw?=
 =?us-ascii?Q?s82/uKHVpc27C7hlD48rMP9dvVmwRo0kG0EZcgQbfct2ozGnSsiC8wisoOEt?=
 =?us-ascii?Q?wTv5/zTbr81wghkQR56qf6fbTIQHh3QB3T/A+9ndpA5pfq5Ms4SQT8EIcU1E?=
 =?us-ascii?Q?9ACIAdmSn267BCl/sbYGAPnbaJ+bhWZCe97xfSsdEywGqWrkh3Ck/Ky1qC+R?=
 =?us-ascii?Q?nOrJOXWlmAj0shveTcFmNgEpsyLhMlzKf7QXtCnXZDQM9fK6JjW3hlB7JonB?=
 =?us-ascii?Q?Maclkal1/44lpS1qFInIYWocMTz5s22PSUQ5Oy0ah5RGK7PT762zvDjN8kFa?=
 =?us-ascii?Q?n5yfp47BAhLk/qnpzn2DyTKLEAvqcmsFUfYaJfgaJtJpM0L8wWkNkLX49dyU?=
 =?us-ascii?Q?LAfHQLoLdy+cfZgK9QgaCNvQIG5g2YxaNYGt7dZ9Mv5BeclKq/0+6LRVA33K?=
 =?us-ascii?Q?Dt5oV4bHARuzBbT4Pq8CJbTp4bYRvAwFalfUUam6qcx0rgDSvF2UsfE/wUBB?=
 =?us-ascii?Q?s/0mDBSC6DZF21kNAHJTu0hvuZqD9XBkCV6FNSzq2iBt3bnjAhDanf1+kNKb?=
 =?us-ascii?Q?NV6XbFrKb1gq8UtjZ1sbVsV9lL2fxOCfYxk4s+qpDN8AYDAWw6EunuuKGVga?=
 =?us-ascii?Q?HaVk2qr9il6qwA/mFGNsr0aFxnMRYhtCh9dYgKMb1FhK8CQczPVvqNpi8qYK?=
 =?us-ascii?Q?a8k3kYmDrJB331eBQooVc27gnb1EH1LvSTgyp7blk33LjLifX/dW9i8wn2RE?=
 =?us-ascii?Q?Qty95gGjDcGR9VhRCA7f+d2EIO2UTDCWEqD3uEWsnVFu9D/T/cNQrDSdFMHR?=
 =?us-ascii?Q?ZGe9gVmiYiKzYMT/ibvcl0wcxz/9KQIQW94FNooheWSliEo/EBM7PNgjMCZj?=
 =?us-ascii?Q?HKHgvEOY0cr6u0Sc+UZB7adQGxq/58yJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tcd96uCb9aEuw9PTcEAmIh5nooc0fS1vjCBXiYDl7kiuWH7Pp1m0f5mK9uE?=
 =?us-ascii?Q?pAqrtCT5U1XPYPctivySxAwM7r1+M9R+nRB5wZOqqtSwePFBNrdyBy+JjwsB?=
 =?us-ascii?Q?WbGwU7PIqHRiq+5DOpr+vkEFEbl5glYKSfZbhQ6pjdQTrdW7E/iQ4y4vHIrE?=
 =?us-ascii?Q?rQoZCIp45TSA/muaK7sJnL54UBSt1ZqjR0zpWbCBXpNks4/BFrUnEQzR8nX6?=
 =?us-ascii?Q?t2doQOS999ZXWzL+V3zr4i7GwaO437nWk8P/0l/bqMtgSa1Pn2f1C91syqeM?=
 =?us-ascii?Q?IVNiQu/hab9ww9Mr7sLZinD/KXcG3BxL9epBnlAtRTYG+hFOFDq+LWYU6x5C?=
 =?us-ascii?Q?zJYHt5zJoXU/UDNuvFsUdMYGPCGJvGsOE5sCvstsVRCUPgeXvwtruuvglVyN?=
 =?us-ascii?Q?OC4Nse2zKCmMrA1foNibX46vOaTYbeaxYgWHpsbL2dBr3gjrua5GRT2yDqb1?=
 =?us-ascii?Q?yszk5z2ewlsL8HBlQOPco3F1Hz83DENdXCX+WfjDXNoVlME3u3nKtv9Z4TMc?=
 =?us-ascii?Q?pGgqVAt9r/ZzfjYVRFhY69vLUImGZGAtOkf7JbQubOQCiXX4lFCZzqpnqwvM?=
 =?us-ascii?Q?GC3z6C5cdVRI8DIhDnF5o5o2ILjXXOjWNm+8gHxI9D1weWIOq3nri3lK3HT0?=
 =?us-ascii?Q?KPBkYzjPeUanG+zRZ3GhPGwGUBbwim0VhDC3lY0a9yDt3HWnwhk5uuBXHhBm?=
 =?us-ascii?Q?gXhqrsSCFAzj2M5+8e9S3ygh40KkrBDwAqDAW8gq6C3HY1/BrsDyeN62JMgf?=
 =?us-ascii?Q?E2PBWRVx+9Bq4pNgNTYNP5PQ/EKe76VSb/soGYDrUDKosujRxooRNpVwDRfM?=
 =?us-ascii?Q?H+eQGH5TWqv8xCEVEpvBh0mhQWCuY19zpUTA7zMdhWKQlazeGGXmGDqWa05d?=
 =?us-ascii?Q?Ii45U6VXKiQXsI1vUWW+6Wl2EBjetyY9q02XyJWZ+cfIVheQcENq0zmxMygp?=
 =?us-ascii?Q?huDm4r66OCU+9anOyvVF3nQbqnjgxCLPfiavTfUD4Dw9dt4MVIY8VAKYAV99?=
 =?us-ascii?Q?ZtHfU1QDKPqYF5hBjtxa/eCDboNF6fY+ttOTNchwepubGrgi7Ribc9V+njin?=
 =?us-ascii?Q?gMhLsYN2IO2nb5AQRpGsXG+pWN2uIiLng3k72VUZYSeTnuVlEO8icG75x/c4?=
 =?us-ascii?Q?/SLeFlI/eUnpRidgxPfUXO8cZoRvJ6Uh+/0T0zSSpHNK4HPEnmlQroDs2ast?=
 =?us-ascii?Q?P4Xwdsuc3S1Gk/vfZyWPVUpe5hQMw0wfD2El3oJbn2wpFTmtJYD4ulfGwI8m?=
 =?us-ascii?Q?LiUeRdyp3XmAaDSs58wX3uAZv0bWi82d1sdiLx0j9+9M820hnFShpSsRWVVk?=
 =?us-ascii?Q?BQyeRamz2e4HSD+h8hWOirm8Gsjk7Ce3NxAOiBpPWlYic1PJvGeyW497Y57D?=
 =?us-ascii?Q?j4vVeSRkiPwYfHzp/QyDrydxNDiuQfhw5ueYFvg3irPrX3Mv8hbAy80zyPmk?=
 =?us-ascii?Q?PNR1KjrhMz1FXAYEZg5co5jPTSWw3NcMNAdjpUNIbmBncDugpY9gpuC1IndN?=
 =?us-ascii?Q?O+59OT1FyQKjFOPhRwZSRrgwobyZflNzEsQsO2g91+GbVUNyIiHarUC+1NN6?=
 =?us-ascii?Q?lDozXRlcnpkW0CSBljrtt/YZAjiBrT5T2Z8z2fyQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67cf6d-ea48-440e-eff3-08de208bb457
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:02:33.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVh1AbYvuEZSa0kBIf8vuafox5ky9S0mjEu1miZBiVs7TGfYZt0bYkZrGiAAwEPsddp395ln1XOu1uZdn9xGzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
X-OriginatorOrg: intel.com

On Mon, Nov 10, 2025 at 06:42:06PM +0000, Kriish Sharma wrote:
> Documentation build reported:
> 
>    WARNING: ./drivers/gpu/drm/xe/xe_pm.c:131 expecting prototype for xe_pm_might_block_on_suspend(). Prototype was for xe_pm_block_on_suspend() instead
> 
> The kernel-doc comment for xe_pm_block_on_suspend() incorrectly used
> the function name xe_pm_might_block_on_suspend(). Fix the header to
> match the actual function prototype.
> 
> No functional changes.
> 
> Fixes: f73f6dd312a5 ("drm/xe/pm: Add lockdep annotation for the pm_block completion")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511061736.CiuroL7H-lkp@intel.com/
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

pushing soon to drm-xe-next

> ---
>  drivers/gpu/drm/xe/xe_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 7b089e6fb63f..44924512830f 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -112,7 +112,7 @@ void xe_pm_might_block_on_suspend(void)
>  }
>  
>  /**
> - * xe_pm_might_block_on_suspend() - Block pending suspend.
> + * xe_pm_block_on_suspend() - Block pending suspend.
>   * @xe: The xe device about to be suspended.
>   *
>   * Block if the pm notifier has start evicting bos, to avoid
> -- 
> 2.34.1
> 

