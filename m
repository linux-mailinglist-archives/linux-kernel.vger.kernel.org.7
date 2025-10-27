Return-Path: <linux-kernel+bounces-872186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A4C0F826
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D8A401EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE16314A61;
	Mon, 27 Oct 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaBXSTUF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4E30FC05
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584173; cv=fail; b=LnaMSWHHjWeTwMMfuHD0lGRmz/4YFG/KJeZzzTi5aYJbh7QEAXpltTUsTYwkNNfUlzdNObFitJF9TAJ8nz5ybK5+5X0n9L29gZCCxQwpYgL7taf+T+2gjm+eEOjMWGyBbFHpEZE2SGvqOvsoXEU0fDcUSrkZm9ds5QNBkeqRVGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584173; c=relaxed/simple;
	bh=Tw8x03f5/1DFFzMmypBx887FNL6pZ4cg583PNDSz0iE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NGiQBj1EMa4pVt2EGRExJbMZPb+QjRLuhQuI9FKJazYUzjTtx7uQBAxC0mVDR4iAV7n2PMvJGSBZi6PRbsxiXVToDpk6PED9mkH52O4PfZqWeQFhvuqrpAr5m5ms8lGN4U8ZhQzoicB3J/RU+QgriPiMulSMhWP1C83TmOllmp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaBXSTUF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761584172; x=1793120172;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Tw8x03f5/1DFFzMmypBx887FNL6pZ4cg583PNDSz0iE=;
  b=KaBXSTUFkG1PuVYdWFXyPdA1H9cRS04F69it7jdP1x/erz/qZB4Dloc7
   TTR0VDTypaU3fojhpAzHPM3NrMYbYsVIpWpy/orCugtCuY/OSmEQxkzZI
   FYR4ilQyH8kN2j9C/+H+VIfsOKdHQ6nSWedCsxJraG93zqV/PVhVL8wcu
   y6O9GryX/Wpb+zkxViNnWsMeTUY9orsM+j51a6nA5M2IwncY/sGnEOYeW
   dzZrZy3CB/KuNgK/zoAycYbVtF/m3ZVt/OuoZXjEED4zVnMsKTguXROqR
   6C2tcbHmQewv8YNH5It65JsDcN5cxxY2lKyS82k4GzIgZCFPuytPVlf2F
   g==;
X-CSE-ConnectionGUID: DaYbXZBJTsCZ7vsyPBCp6Q==
X-CSE-MsgGUID: c01R6U/iQOSQGLZ9iBz76g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63707380"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63707380"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 09:56:11 -0700
X-CSE-ConnectionGUID: 6tmEVRhHQzKMXem97Pmmqw==
X-CSE-MsgGUID: kd7YPz3/TO+RCJGC2fPjfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="184794794"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 09:56:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 09:56:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 09:56:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 09:56:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMi8ovgFGrI8BA3sCEdEZcxcNFk2U2QazjlHsjmb4ELvhRPAUKMYfvhk+QrS54NnDhNNN9YkBHBGudlIAGMNlw8PxLPmeprfJusplEkhbMys9lKfQmrpROAmhAfnnR+ArOkhspsBQwSE5NgziUhk1cwly78csehnsaWfB6wjBOce7cvlsMoZskAUKx8YxRSppr2fo8+EUnAtegnbvGi2qJkE+EwPo6am/xq9YpcEZWI4wS7yxAxY2B+b7bQvOtIOc0tEgX1vU9fBJRHUHiaHZQLVuUkEzuMzznwXgF41gBWmFWpdrkfp+fTQiLSoME7EQ0donrzrgeDuykpelqPqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOQf/xG2nxbSuqeS0iN6nCqMiqf+coOxJLTpVePK9Ow=;
 b=xq3tL0bf1ErYGySQuS2pa2QyP7TZjTyMaZoiyzfOQ4CYqofKVIr8i36e2GdtubityeIYT5ZukRtibEASUXXqAyaygumBmyPm3ck3qwKC12a687AYwcGbds5KZdKSyklum+l5QsQOaz4ML/SE6oHlbuwO3pykAtDuF6T2MsDoRzqySWCB0HiK0eh8xJ6fR6oI9tj1R7z9uRDL1fclyrz6YPSSbJEgdQmZ2yLml3RKllN8xTO1rT5Hzsm5K0h4wi1qs75Z6hBX2HMeOsBVVWA5CcED0lqXoGMjXDQ1/rq44oWcfdCt6Dll+IsU/CdmqQI4+QordUW3N1uTrX89sGcGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPF551321A38.namprd11.prod.outlook.com (2603:10b6:f:fc02::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 16:56:08 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 16:56:08 +0000
Date: Mon, 27 Oct 2025 09:56:05 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <jiangshanlai@gmail.com>, <tj@kernel.org>,
	<simona.vetter@ffwll.ch>, <christian.koenig@amd.com>, <dakr@kernel.org>
Subject: Re: [RFC PATCH 3/3] drm/sched: Prevent adding dependencies to an
 armed job
Message-ID: <aP+kJeOEghD+sEsg@lstrano-desk.jf.intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-4-matthew.brost@intel.com>
 <537bdebf2112a080ae92526ecfa41d63668d90a3.camel@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <537bdebf2112a080ae92526ecfa41d63668d90a3.camel@redhat.com>
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPF551321A38:EE_
X-MS-Office365-Filtering-Correlation-Id: c3aa7cf0-e79c-4f00-ec58-08de1579b9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9ukINraRFTJ+F10kFI73e6ITLv+nRmuE97G0XsHmlLwiXCsUR2/JI06MNV?=
 =?iso-8859-1?Q?lsy/ksEUpo83vZRXP+rbc4fJqLeyvgkz0YiTCJJxlvO1FpZNy8JSvRSbIk?=
 =?iso-8859-1?Q?z/n5unbAcbRVMzJQ1IcfCu9dZA87xLLtVV5qo0u0b2Ii60ouQc0xQvuWR2?=
 =?iso-8859-1?Q?5ppS7nkqZ4zflqsneD1e6Bm9+9IzeIlV/1mvMt9fQKo/uGuISvR3JShRSD?=
 =?iso-8859-1?Q?Objhdis5EYi9Juw0xb7zhsjqbtxQ0tEpIvo6BCilnBw/n7IThirT9sFZQh?=
 =?iso-8859-1?Q?yDb5/iidIMjulQrEc0AY/O6SyCUN2rKn+fja5001w72g7vOWq+W47CBbxV?=
 =?iso-8859-1?Q?zSafLUDLbe6ll8sfZlxdIPMw52bLgE9tiXM1psraeh4uPfPxj14QRUSbRH?=
 =?iso-8859-1?Q?BJSgJb2njYVY2bjdD00GxRMF1olmQ9Qf0VhyVwqfrftnTDqOAFjOGYtNed?=
 =?iso-8859-1?Q?+rhi+9U2gByZVIuORlJcUn2eHUfpGIWxO5OhgEpUlHh0JlhXismiu4Cuwv?=
 =?iso-8859-1?Q?znb36XG4vJ/6/I1n3kBcIWeJz9CYJodANma2BpTaHul7YN6bCcCWDTBaF1?=
 =?iso-8859-1?Q?fOB6yU5s4VPxiz9fVEwPXg8UsDX91CGsxs+oQz+Np+nPehE+vGz507oPoj?=
 =?iso-8859-1?Q?nqFOv0vw0bNuGIDvQNHmLXN5toWoYq6TDS9pd46/NWHNpgb5VXpLSX3v22?=
 =?iso-8859-1?Q?7aD5EMLZTDxPWiEbw95564mJEnxiy7wC8EfrOzm66c1G0jHuJIMkQZXeGZ?=
 =?iso-8859-1?Q?oc8ybTpjZx5DQ0O1xETXGmv4fjFLDO/dr2nOE/dIH95d2gpYucGXthCz0N?=
 =?iso-8859-1?Q?vi4vEQ2/rH176J0bLAwjPKTHr1Faza9qlP9n6gHqoWBBhgxJlzHZ4kLrIR?=
 =?iso-8859-1?Q?wmPiUk6zyUjktjjhHoCHTAFbWZ82CkWwZCJ1EWzFk7TIf1a5LgXoJAzWcN?=
 =?iso-8859-1?Q?hWokfzoWxZxONgO9GfGndCG0lacvQfBjAhNQ0noBLCqWBsitz6dDh9bJqH?=
 =?iso-8859-1?Q?Kp4h+iX6lD3OzA6eN31x6xX40OUZxJMUOjoNAftoHBkm9cQaYTlvMZJY0r?=
 =?iso-8859-1?Q?gWL7IjHLjXlb61+TlpA22QJZpgBPq/B+dVhymYtUK56QdIEVzyz1/LfQ23?=
 =?iso-8859-1?Q?o6MOyaBfSQXWWB6CRqRLAiXH0Y3QVztbmeDNjilXyl2jp9nL/8XWFKpnih?=
 =?iso-8859-1?Q?iRmE5BHZI3dgrbmuJEmfgsKGx5kMeE5bPS30ScNsgEPmcIP6uKWM2Fuako?=
 =?iso-8859-1?Q?7kNI4Hvt+jLb6JjKDZ5Jz/paMbsxWSeFb7ef0dBg5q+yXB6IRR8jZ7uMAf?=
 =?iso-8859-1?Q?MkEmEWOLBDrdJVaA2Sz+wtuO/lPOK8RX91AxeSkbLJnM3uWDLaOjzbx9ty?=
 =?iso-8859-1?Q?q2F2ftCJdg6EwlDq/ie2K8T2Bfjnx2mf5+N44keQ3j1gdTH4aYnebJyEAp?=
 =?iso-8859-1?Q?5W2hpiX16fY3mvGWT79ivIAFKeOOc56o7Pd2zRbCCPCUt+UnrKuv/OHXDF?=
 =?iso-8859-1?Q?swZrWY+EhdUr7htuCMK5co?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bQB6WdEXkyK9qidmVZhkdN3p6MKi7pURLLNiFpSA7I/wS40hdUVvsPgpUS?=
 =?iso-8859-1?Q?tIn1gL50kP3URei9akn9OkgB7H51oQGAaJ+2MdjZGGBImX7CpbOA1lYDtr?=
 =?iso-8859-1?Q?lP4xKRJsBWQ+RqO8WDHx87ARDrCuC1qMs2xYUg77qSoKj+LD2xERdeeyWn?=
 =?iso-8859-1?Q?XOwVia33b601IYM6nTc3RXsih9aT5qIBSeTpdPM4Sy/Bn45aYFbbtOx+Qk?=
 =?iso-8859-1?Q?j0Ms08lODC+rhYLArP6m06l0iCFv3/AqEgiVVASVsbGiTUDqEKG4/y2EPY?=
 =?iso-8859-1?Q?1SCRtHp11AAZsMYWc4lfg1SkreqTl9O01aGIv7Bvkqd1ssQFgBDFVxzHs3?=
 =?iso-8859-1?Q?JA9KYVnUKqC7DlSYjbmaaOny2AOzf8VfSR3dt/0DqtgzRwN31LY8l2IfrG?=
 =?iso-8859-1?Q?29KWgBeT0YhAMnay6nQGnPVxh9/4YVSWhgxesR27+33No5bD/tD9Yep2aN?=
 =?iso-8859-1?Q?OEngNH7YgF3NooFu26/zxYjqKfNFzTnshxwxs3GD/NUkTi/1UO0Y4KUg3A?=
 =?iso-8859-1?Q?mG6zttB1ACjpGspCMMT4fLqDhaAs3nVZWPVm1w0obOsldEH23jchnEd4Z6?=
 =?iso-8859-1?Q?sbE/U4oiTG3tIIAasvz2EUCRqha6UQmH+1zjQ9W6XCcuOzYQgoKxLtoZIq?=
 =?iso-8859-1?Q?DkQDvEF2xXC0R+k4FnPQ7WNL3lW2bj/mcut4fPPFVTzEdrNYQY6tvDbenM?=
 =?iso-8859-1?Q?CTw1O3Dx5U6QtMUsHrTGjFnt4ETU1XGTVsl1APpGClNX8xKBxhZbTy+7Rp?=
 =?iso-8859-1?Q?LLsZsJZhtBA7AMscx3j1V1+TtHklSi3pLaOjqq0BDGX5e/OuB7ExEV2WZf?=
 =?iso-8859-1?Q?Mpte0AM+S1yS/z/ePO1TGShhNLgLfffZNnpEPsbAx0RWlRllR+GnfhUDjf?=
 =?iso-8859-1?Q?6HyV5qh7xIjKJUYf6AGoCIW77KPwCd8xZ05rec/io+G/yDjANL5Wp55Nnv?=
 =?iso-8859-1?Q?vUgWy70pF/1NvqdQwq9N1bi+XESituSHhx3Frs4tng4F1nlv287ItdDRUl?=
 =?iso-8859-1?Q?5S+cyOyBIIildK8EOWiIGA/kFo3QRBYpGuBV3cRV1WTpkSbwwDKD8FJOb2?=
 =?iso-8859-1?Q?bBq2OIqx2Y2ciw3ghD4j5GDFpKbhnypRiRCGY8KNw0BgcsF0ePpj31gO2K?=
 =?iso-8859-1?Q?XFkNysji6bEnTWRylhv2iEih6F+Mv38WWRl8FzGkWVqw9vChuxQpJpSZs/?=
 =?iso-8859-1?Q?IiUF02YdTCX50OkNgsf3+B+hHTr2faHedWHVX07i9iWhZUXOSRVwXEON1/?=
 =?iso-8859-1?Q?d2ATU66C95EBFTyo3ONfq8Masy5YKsdW9h1rNRodjVvXVayD7kdqbuzUhk?=
 =?iso-8859-1?Q?eWDr3tmoGMDsf4HupKEHI7kPqObEhD5g6PeswMzRhhlx9wag8b9l/xi9hb?=
 =?iso-8859-1?Q?3VPwZK5/mieTOWEJWpljQ0uMW93Dla5KrEgxK8JAh1YV+hOEnyWbEtjZ0n?=
 =?iso-8859-1?Q?IM1yZExTLKiOt58bvhXnpGlwkT/RCne7cCkHkfm2KSOqX8dlbEmH0eXxss?=
 =?iso-8859-1?Q?j273rSjjLlWcSGnke8BGCmSU72u7ZP3I/hlJipF4c/WMAnIJThtXfVSkjX?=
 =?iso-8859-1?Q?CQaRmwEz7NShpLdoTpM4tyghQRbkH5VlK1g0G4irUXEJYgzvVw0+TOfrpQ?=
 =?iso-8859-1?Q?czSKf22Wiby+hyUtQvzaA15QvgVbkhycIxHXEgqJ4Ydi3hAH0Df5fFNg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aa7cf0-e79c-4f00-ec58-08de1579b9a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:56:08.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDjoHpHoZc4cBj8jyELBPZPRwlAe16+QZ3FoXDH8mC+rUcSLOSfdOzM+08GsAPBOJYDb4XsOliFLxHfQMNbjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF551321A38
X-OriginatorOrg: intel.com

On Mon, Oct 27, 2025 at 12:13:58PM +0100, Philipp Stanner wrote:
> I've got a kernel.org addr by now by the way
> 
> On Tue, 2025-10-21 at 14:39 -0700, Matthew Brost wrote:
> > According to the DMA scheduler documentation, once a job is armed, it
> > must be pushed. Drivers should avoid calling the failing code path that
> > attempts to add dependencies after a job has been armed.
> > 
> 
> Why is that a "failing code path"?
> 

I noticed this after I sent - it should something like:

'avoid calling a possible failing code path, which allocates memory.'

I can make this a bit more clear.

> The issue with adding callbacks is that adding them to an already
> signaled fence is a bad idea. I'm not sure if it's illegal, though.
> dma_fence_add_cb() merely returns an error then, but the driver could
> in priniciple then execute its cb code itself.
> 
> And even if we agree that this is a hard rule that must be followed,
> then drm_sched_job_arm() *might* not be the right place, because just
> because a job is armed doesn't mean that its fence is about to get
> signaled. drm_sched_entity_push_job() would be the critical place.
>

I think this break our rule once arm is called, push must be called as
adding dependencies can possibly fail. This rule is called out in your
documentation patch too. I've seen 2 driver posted in the past year add
dependencies after arming, so I figured lets catch this misuse in the
scheduler.

Matt

> 
> >  This change
> > enforces that rule.
> > 
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Philipp Stanner <phasta@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/scheduler/sched_main.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > index 676484dd3ea3..436cb2844161 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -873,7 +873,8 @@ EXPORT_SYMBOL(drm_sched_job_arm);
> >   * @job: scheduler job to add the dependencies to
> >   * @fence: the dma_fence to add to the list of dependencies.
> >   *
> > - * Note that @fence is consumed in both the success and error cases.
> > + * Note that @fence is consumed in both the success and error cases. This
> > + * function cannot be called if the job is armed.
> >   *
> >   * Returns:
> >   * 0 on success, or an error on failing to expand the array.
> > @@ -886,6 +887,10 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
> >  	u32 id = 0;
> >  	int ret;
> >  
> > +	/* Do not allow additional dependencies when job is armed */
> > +	if (WARN_ON_ONCE(job->sched))
> 
> One would probably want an 'armed' boolean for that. At the very least
> one wants to document in the struct's docstring that job->sched has
> this semantic meaning. Otherwise it's only obvious for people who have
> been hacking on the scheduler for years.
> 
> 
> By the way I think that we use WARN_ON*() too much in DRM. It generates
> difficult to read, non-descriptive error messages compared to
> dev_warn() and similar helpers, and it's often a bit overkill. I would
> only use it when there is no other choice, such as in an interrupt-
> handler or widely used void func() where you cannot simply add a return
> code.
> 
> 
> P.
> 
> > +		return -EINVAL;
> 
> 
> > +
> >  	if (!fence)
> >  		return 0;
> >  
> 

