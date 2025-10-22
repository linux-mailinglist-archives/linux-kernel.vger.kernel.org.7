Return-Path: <linux-kernel+bounces-863960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B21BF999C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E041F18C4F98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9238B1DE4E1;
	Wed, 22 Oct 2025 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5B3IwpF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51B156C6A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096152; cv=fail; b=hSyjGfV3KJtmH5pf/kZY7vbVZkRikugoRJ9x075qkXSvHBNsPgyTe38FLhbIxke6OGLt+KMmZB3KWG7+jNRsESPrgoVCoxhOcKmLF0azniYLPcXkLXZQG5XNPsd8EXwtl84+zkIvtx6YbvvKXIqkXTpFOvrscaWSwkKVSt4Qjrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096152; c=relaxed/simple;
	bh=Z8Q52oIPVzkTLq/pKl9sqwSzPrTUuRygjU40/5cCVOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o75S0osWA+ymUrcRhIJIA3eu0+X/NqdSxgbQV9BTfH3u1R+VHikrnnAJjXIOOFWTylUns+ZNfcDggaLOXBAeR07sTEIPfFF3AOXarCPMMFdmhkYVhVQLtLNV+yhwuCnUlVaLTzbkJ8Dd2z0AUC/a8npfebQ1VPZBV8jgni2W0DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5B3IwpF; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761096151; x=1792632151;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z8Q52oIPVzkTLq/pKl9sqwSzPrTUuRygjU40/5cCVOM=;
  b=X5B3IwpFdxRYmiLQYwSAz7QJ1jqMdqObDui+KlDh6WSvMvqnalAzbjWz
   xIyM+GEudDT9rVNuhj0+r7EZ86BLMLfo6mIQEi12qodLZR7oqc1EbCjk+
   m3foBUpgju1yG8kr164hsmaK7J7tr4IKsFy9+ldlfZ/RkSuRWsleEC20i
   trJsEHChE5rG/1G3vzXCX1knZnfr/HCgj9UjVVRzsx1Blc2u9thgfaVaW
   TyZnv+PElvcTPyCKpXcFjvZx/BDJfrkgFcI2zyzEOMKsR7xVJXCY11O6Z
   GUWtEIUAz8LC+fg6f2dLvK+JJKFDtQMSC4/2jHWeyDdxDPXoO4Dqk+2Gk
   Q==;
X-CSE-ConnectionGUID: MMywOouXRSGabNnaFxCbrw==
X-CSE-MsgGUID: BJtIYZg/ST2xfUyLwZopDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80857991"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="80857991"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:22:30 -0700
X-CSE-ConnectionGUID: xPuHijFDQgitCyqOJQFF0g==
X-CSE-MsgGUID: RvDH4qxaSfezULXfXYM3tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="187775991"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:22:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 18:22:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 18:22:29 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 18:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT2lLfB7S3lvlzC2I5fz3WvTR/+kLMXW5wBEWT3J5h4hxL8+WAVaiAOsgwRi4TjY7FBAiBvLb6ilIOxYDB7rjFY+9oOQ9H/xEBMjWOVgR6j0DivmeKxuSD5bl9bp2zwOcRq9WRG9txoLBgP6IrREcsLeqcCIX5NH6szksU+aQAdE+6E1CTX7Abrs/S7Aq4vT/tjGpsxPv/+2/rEEfScPBRu39lJ88Fb+IEGwMhSiieFZgtBHTlAwDeJWcFRDhOnN4g37GxzJPWJk3UAwif9iKwyRLeN8Ja4JwzNguTis0jnixJvL2DxlzcDRt50vk6QD1J+9lf442fccL0TWV7XZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87DBOlQQ7mUWv7LubzlMEBS30cfod6XYXpv5DPKFCvw=;
 b=QC6LAMrIqbFVP3A+e3rWWcjJno8l4D3yUCPpJYQAoiOmdH2heH7eaMHu3XbdKGK6q70fwk3dVwH1zsiFKnJfMxrDDxFkax1yWVsTJLElCSCVh5jOLAHV8jjJIYjYS2T7YOaqIecdC30kxTIRFeO7U/lMn0nld4n5b5UP+V3LJV791dNnHs7s4iupxHuP/9pXQtsf+HFOOPYcv067UwcCyE7V+MX5uYlc4xybU9V6nrXMYCTaBSE7qau/ZY/O2XHPzBb5k5ZLaPd5xSj+xazcinGwaKEwcMn9J3ZSGIlxXAuttBOsR4GLubaWPgJbH7gLo9aCym2Q8nT3K/rGlqeJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM4PR11MB5311.namprd11.prod.outlook.com (2603:10b6:5:392::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 01:22:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 01:22:21 +0000
Date: Tue, 21 Oct 2025 18:22:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <jiangshanlai@gmail.com>,
	<simona.vetter@ffwll.ch>, <christian.koenig@amd.com>, <pstanner@redhat.com>,
	<dakr@kernel.org>
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aPgxy3lIqW1rUGsx@lstrano-desk.jf.intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <aPgBjmIm6n9H-R_u@slm.duckdns.org>
 <aPgDXsQY5qAfU0Tv@lstrano-desk.jf.intel.com>
 <aPgXH_JjkmKO5_a_@slm.duckdns.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPgXH_JjkmKO5_a_@slm.duckdns.org>
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM4PR11MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8824f650-6408-4790-05f8-08de11097320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTA5MHArMFpNUjE0Q2VxU2x0WTE3TFMxTnV1SG5YWGM1VlI4c0RLUVJTeWdI?=
 =?utf-8?B?MVI1SHY3YmtpTHEvVWJCdlJnRkxVMFJpV0ZzT2lEOGtaVmNJWEZvUTdZbWlM?=
 =?utf-8?B?SmFQOGJ3dkJuZ2RvZnFKMzRCNnA5QlBkQkhVOVNPMDh0ZHZhNDlsdTQ4N1JD?=
 =?utf-8?B?a2sybCtkUERkVU5Tbkpwd3BIaTM3WlozbnJ2Y3Y3RFZBVnhNRG5UUEY1MEtv?=
 =?utf-8?B?bUR1VXpmZDMvbnQ5MVlVQ0hZS0pIbmQrQUNENzVkWmx0ajl6UHp1MFpJdUpT?=
 =?utf-8?B?ZlgyTUQvNWJWbkpySUZDNmV2VlpqZ05ucklHZ2orOHl2aEhCeWxmaG03dWg2?=
 =?utf-8?B?d2RqbEgrMFJEbnk2S2NLcHkxODNJSGY4a0syM05wVEJpUGpwYlU5c2dMZFJq?=
 =?utf-8?B?ZTNhWlN0S3pyUzR5cEc3UjVxakVuZ2NzdWxwRGlCVHk0K0FYMnZEWkFBcW81?=
 =?utf-8?B?R3ZCYm42N3NVdUVPYmdaYkJablc5TmxxYU96WDNxTXZlUUpvMEY4NWxjRXBt?=
 =?utf-8?B?NHE4SXZySGE1OUd5a2lXMmptaWxYNHBTNkhGUTZ2OEdWRTNCQ21PYnJQNTFF?=
 =?utf-8?B?ajIvVWhiWFFlSVplREhvcFVCTjM5V1JZRTBIdCtVUU9rWjJBMG1nbDhwVTdr?=
 =?utf-8?B?ZjVqbzFVTmNNLzl3UkNhVHNJSXFBYm5iVXdmNkFtd1owRzV2RUt6TDloOUpG?=
 =?utf-8?B?RjlnYVNsc2ZxZGN3RDdSS2tQd2RMTWJ1KzVNbUpJNFRPZXZza2pCczhwWnJn?=
 =?utf-8?B?bGl6c2t1NnYwZEd6cGlqc2t0SnFnQ3Rjc092UUpOY2ZQSG1pUmY0NGlyRGo2?=
 =?utf-8?B?VjhiYWZpcGFBczVweHJUTFBEemUwTTNidE1OUWExQS9QU2ZWVnhSMVhUZk5j?=
 =?utf-8?B?aCtSTlZPbmFmNDhSbWRTRGtlN3ZNckpaVkN4ODJ1WjdqbFFlOXc1TkJNdHl2?=
 =?utf-8?B?UDZLV3FwMCtXclk4Z29CVUlQU04vYjFzNTUzT1JyVEVqODJvY3I0R3Vjaklo?=
 =?utf-8?B?N0xCUkduQzUrVVFHVm1pN2hkTDhCa25CVG4zdWhZSjZ5NSthVndZMjIwcHVF?=
 =?utf-8?B?SDVNb0NjRlJMRGVpaU9JOC9CSDNWMDluQnVDNWIxeUdRNi9QWDZKWUdUc0px?=
 =?utf-8?B?OFQrdVR6WGxOeHpxR2ZaUHhVdGJOeFhSeWtrSVZwNUZ6ajlZa2pPdHdiVW45?=
 =?utf-8?B?am5ta3lrcTJ4QTZLZUdrN1p3dDQ1bnNiS0U2VnZlbSsvUVFtM3dqemRwZjVC?=
 =?utf-8?B?UFl1Y3NPQjY4aGdha1ZiajE0SDc0OXJSSDFYdU9Rb3cxYTdHQkdZbGNIczdY?=
 =?utf-8?B?ckgwdmV3OG00VVdSaDVPU3AvWlI4cFBNYU15Zm5PV0dJMDZLRkVndGkzeldK?=
 =?utf-8?B?aGFjSWJDeU5USG9OWlBycklPaHZaY2lxZDF2OWpDYlhyWS80UjdKVWdqVDY5?=
 =?utf-8?B?WGlRa24zKytsSCs5a3luMzEzWmRBblEzUDJPNXZCdklhMWo5Yjl5dEdUREIv?=
 =?utf-8?B?VDkyeDV0Nmh0VmhSQjgweE14dXZicUNhY3FQcjd4VnJqbmFtVmczSDBUbnk2?=
 =?utf-8?B?UEpqbWs0UjVCT0ozWVhYb3psMDZVUUZzamN0R1BrYi9ld0l5cThoanpDa3dR?=
 =?utf-8?B?TWQ4Vk1qdmVJQkE3SXlGNDFZdW1RVWlXNFJPOCt1WFNnZXo5YXdvOUZnNG9u?=
 =?utf-8?B?dFc0WnVpZnJpUHhrYjJQV1pnU3dDcVlIWmtFb2RGN2NuSjlucVp0d05NWnhD?=
 =?utf-8?B?d1pmZ1ZaQm51Q0t1dURkM1Jlb0pjazNNcUwrSUNGeTlBWmpRSG9HZ01jMStp?=
 =?utf-8?B?dzFmbEVkZFAvRXpURE1KU08wd1dUY0ZNZDBOcllMZTU1V1E4a2tqa25yWmNP?=
 =?utf-8?B?MU5QQWJrT1JiK0pjekpmNmhaZjF3VzczODFBQ3JYWWpYL3NEMEg3YVVvNUwx?=
 =?utf-8?Q?N+dd6qxmXXjENOeLhoqxU6OIYTW0khHg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTBmcGw1YUU1V1k2cERqeGJaNG9VWVRuaGhnOHFLV0Y2NVR0cU00em5qbkNn?=
 =?utf-8?B?OFZPV2J2OFUyY0o2blU1dmRZN2kvLzJUZHppZFpxbzFlcUlwTGNBMytoNVRt?=
 =?utf-8?B?UFBreE8xU3NpMGRvbk9lWVZtY2ZQWFZXWHpWd2JjZ3B1b0ZHN1VjcXgxaUdN?=
 =?utf-8?B?eVFXRXRsV2xIa1RNbElobUM2Wkh1dUwrQ1VoZ1cxYUo3aFplUWtaVXZkb29H?=
 =?utf-8?B?TGRMMEt5N0VaQVg4ektmRjVhU05lSTdYaTU2NEc5dnRKc0hIUFFaK1NGVm1a?=
 =?utf-8?B?Y3ZOUVNDRDE5STNOYUxxME54STIyVWl0T0lMeld0bGJrTG9uM3kwL2VzcUt5?=
 =?utf-8?B?Skp0RE9lSEtPS3lYVEdBRW8wOE8vNVpYTUthWTZEVkVhV2V6NDZmSk9FeXo5?=
 =?utf-8?B?RGFkWHJyLzlqZlQvRE9mamxjV0RudVprZG4wSzdjbjVsR3ZZM0NuUXZqelZW?=
 =?utf-8?B?OVBqOWNKZDNrOGVlOGJ5NzNTZnc3OWZRVmluQWtzY1JweGNKOGd0M3FMblZG?=
 =?utf-8?B?Z21EeHgzK1ErVXNtNHZJTk4wQXlPV01MY1I5VkV3cGNQc0VkVnN0YzJud2tz?=
 =?utf-8?B?WEpiUG50M3llUUcxYlVXWnJJRXNDVkpEQkdYSEl5dm12NEJKNXlwVUV0TTdi?=
 =?utf-8?B?TDl0RERDV0xsQUZyb3c4VDNSdlhyakNVQWNxeXBuQ0EyeHFLSG05dXRxeFRW?=
 =?utf-8?B?Y0ZJZXVLa1QwVUF6NTA3TUNJb01VS1lFc0R4T0RUS2NDaXpydWw3T1BLRDli?=
 =?utf-8?B?YUFQTTdvTnNzc05KcWtCVHg0Sit1d25GVjVOYVFyMldBUWtCS1FQRWMzNkxT?=
 =?utf-8?B?YVRSU3ZUQ2FnNHVBMUVpeEREdmlMNmpwOXdYbG5YRGNzWlVYM1ZGRFE4NnQy?=
 =?utf-8?B?OXY2bnR0YmVKcnZ4NDhhQ2tSZjlZQ2N4RUVrWk9kQTE3RDFOeE16bGdvKzZt?=
 =?utf-8?B?a3hFUzNrOE5sRCt1QzNuaGUwMEdRNDFVOXBwY3dlbFFsWG5FTkNzZWI0dkxT?=
 =?utf-8?B?aVV1OWRRU3NHTGh3dE1LMng2VkpOR1lUQ3pPSU9wUm1ua3NsVlluTE8vNXNP?=
 =?utf-8?B?SWVEOFcrVEYxRXlZVTlTSUNCR1BnWC90eUdHT2ZySkxaZDNIdER5dUVBUklq?=
 =?utf-8?B?aCtiYVhQVDFpOGZ5WWJuMVR1V2tVTnF2RHBQRWdxemgxdk92TE9aakU5Mkhk?=
 =?utf-8?B?azdhWWJEZkNWQllNSkxjZFRpaHRjRjBUanNlUDU0SFRmK0R1UzFVLzZrVjJv?=
 =?utf-8?B?d09IZGs0aW41eVR1dHVyQ1AxWXNXNW9GUnc2Tkl2d3ZYc0VxcVBzNVR4V3VU?=
 =?utf-8?B?SnpPZ3A3RFo3ZEQ4OW1KZkhqbVU1dFMxRm13VXJWZllNWksvbnhERncycnI1?=
 =?utf-8?B?YVo3Qi8wYkd3QU9CVEdJYkZiMCtvVVVPQkxSeDFEMkluZXRvMmFIRjRVMGhV?=
 =?utf-8?B?cWwvakpLbTRLaHBoM2NmelNweE12bVJFQ1liT0hvd2hvcXdKazdrNjJtK3h5?=
 =?utf-8?B?RFFEcnVQcFBLQjFIRXlTYTFnS1B5NDVlcTFRVkxPVUZCQ3hLWmRIMzFOWTBH?=
 =?utf-8?B?RnhIRmhObVFXME9nRWN0eEpKZmdrNXdYQU8yTE0ySStRM3Q5RElPK2Z2VUdl?=
 =?utf-8?B?SzF4dUIxb1VTaWk0NmUwcUhyOERWL09PN25pUnRkNHBoY0ZIelU4NldhU3Zq?=
 =?utf-8?B?dDlZVU00QXRuT3M1QWRGNEZqaXZ2VnlSYWcyOVpFaFhHQjBSRG45NVNjZ1VJ?=
 =?utf-8?B?VXJVMTduT0kxVzZvNlVQcHViSnFSMThQWUxvOEVZY1ZRMjY0c2RxeFFkVS9v?=
 =?utf-8?B?V0xkcExoSWxoTkxDT2Zxd0VMM0xwSGdLOGhwbFZONGs0bjhZLzNFQ1dvSG81?=
 =?utf-8?B?dDdPdWtoWmNNVEZqMzRoSWpyL1lkWVVkWDZrL1BmVFRnTm5qR2l5Mm5tZ1ky?=
 =?utf-8?B?RGFobldmdmhiMzRTTytyVHlTS05PZUlVVzF6TkhpU2NDd21HRC9McHVOTWlH?=
 =?utf-8?B?NVB5YWRVQzJqd0xiNHdySE5WQmJTaWxkNUg1WmxORUxVRXJLeXk4VW1WOWth?=
 =?utf-8?B?Qk0rM0tXamt0alJiSlVIaDlvSkxmY3BISWtyam5jMU0yNmJIMjhxQzZEQytl?=
 =?utf-8?B?RUc5TDc4Wjg4NERHclp1TXlSb2NMQlkzQ1BzbmliUDNQbGRodWFBWmZIdm1U?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8824f650-6408-4790-05f8-08de11097320
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 01:22:21.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K65LLrSymEEJQfUEXxiqrMpMBINZvs5NoJb/NKT3fNNodYGy9pTPsgCT1avuTlte5fIITFyQCNTmQPKBphhu/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
X-OriginatorOrg: intel.com

On Tue, Oct 21, 2025 at 01:28:31PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 21, 2025 at 03:04:14PM -0700, Matthew Brost wrote:
> > > Hmm... would it make sense to tie this to WQ_MEM_RECLAIM - ie. enable it
> > > implicitly on workqueues w/ the flag set?
> > 
> > I had considered this, and for a while I thought WQ_MEM_RECLAIM already
> > did what I'm suggesting—especially since I’ve spotted bugs in drivers
> > where I would have expected lockdep to catch them.
> > 
> > In my opinion, this approach is better, but it has a broader kernel-wide
> > scope and could potentially break some things. My subsequent patches
> > will likely break one or two DRM drivers, so it might not be a concern
> > to fix everything that breaks across the kernel. It's up to you which
> > route we want to take here.
> 
> Yeah, it is bothersome that WQ_MEM_RECLAIM doesn't currently have a way to
> ensure compliance. I just didn't know about the lockdep mechanism. Can you

I agree this is the best route to ensure compliance.

> please update the patch so that WQ_MEM_RECLAIM implicitly enables the
> checking?
> 

Sure, but a bunch of things immediately break—including a convoluted
case in my driver. I can fix the kernel to the extent that my CI catches
issues, and fix any obvious cases through manual inspection. However,
I suspect that if we merge this, we'll be dealing with fallout
throughout a kernel RC cycle.

Matt

> Thanks.
> 
> -- 
> tejun

