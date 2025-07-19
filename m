Return-Path: <linux-kernel+bounces-737900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331FB0B1B5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FCC189DBE5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D63222566;
	Sat, 19 Jul 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJ62HZWK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3E8F66
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752955525; cv=fail; b=d29kfkK76rDSKlqzUIh3lfPfRQPlip+IEDSfhFPaJ0PAyOltun2MPRiZTO0qh/yU5RE24OB8mMk83gxVIKTc9FWwCGZoRFv1D7Jj7NX7PqESqm6ytFJAJMEu5UMYZWwXUOJQBUFmnMB1EbS3Y0mpzt89t6NRfCNAZMuvEPKmigI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752955525; c=relaxed/simple;
	bh=9FyIl1usdgRO6TYSEqTwa3u1/Sy1/8KD3NvEwR8Hi9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EsawOqxFLsEo3oexl6yO6dOAeblwOGUcyuJ40V2/1rtVUu6GdRxQOdPnLkjI4cgcGA2vWsY7S5G5XqjwM+/ktgev0wehJwRIBTaNaK5n0UJJkik5x8dd874MjU6u69wO2l7np61FkiqdqBdmZZqMtzzEcjLG0vsrii0OjRjlfHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJ62HZWK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752955523; x=1784491523;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9FyIl1usdgRO6TYSEqTwa3u1/Sy1/8KD3NvEwR8Hi9k=;
  b=VJ62HZWK8OUoe/IAoDYLt8qqcibVUTbQHPkvRdod21taMaqYxi7re/B5
   lVBegfmetI7f0RfQnZwhRuW3QfRGcRFYtfPEU/VoePtmapqqbZ76VegW8
   DKO6+emqJncMTP3BjJ3Mha2IE4Exn685u8wjoeq8aER+QLFSTafDVmfSF
   1RK9DYjtvbC/uo1bQHSfs36KelEFNrO1yTBmY2dZ5OBWOGPMty0ApbYcO
   +XxWyr3wAS1PNdzbMh0pkYxVyRBBsrQC/8eB/1HeiSSFTrIiMALXBeGYX
   5JiHdHNfiTTPsEqqWScY7+WK56v1xXhL3n5v3T2giR/PYKHS0iGZFmn2C
   Q==;
X-CSE-ConnectionGUID: XYcuG2tmRGyaHwRz673HYQ==
X-CSE-MsgGUID: oNsm2bC4T2qv/wlb6B0Jog==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55340060"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="55340060"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 13:05:22 -0700
X-CSE-ConnectionGUID: ilHzNnU2QmekCa0qaYtnpw==
X-CSE-MsgGUID: XgkpWU8CTv2sQDtibLD9Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="182197897"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 13:05:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 19 Jul 2025 13:05:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 19 Jul 2025 13:05:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 19 Jul 2025 13:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkUDwgOJAj4Kch8jmD+gwNnLtBW0pdy+14I3N/cFZxWWXaFeaB5Shqfun+ClYGcJ1eYOoGfANJgBOxSX22xdMPNiELrW3kJHPvc3gI2zsBIJSdXbsVVqHIV1V8L53xH8iqyGI3m5eR8T83/y6D8ZJCd0INRw4z2xzW2W3dkv30GGoZbPq97ooF3/IJy0ZgJJcm3Ywm5qfWi3r2W6PpxRHv3Q+Nd+FynQqAjfQDWRX3CPZoGZOy/fUPqd8Y3npySHkEInb5IkZ+5M3EeCIVURA7Pbi+IaLTnXMmwPELtRxCm1GszHEm1QwRLGykeQXusH/eLM0jHgBqrn4HeXkPZesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYqoZfMNWnC5sbrBp1ta2zg+h4LTnCHyUQwpTbcyzw4=;
 b=XwS2c297GOdfGwU9sET7kMXmNsRbBpUVRt9GzZjBFUo3Chh6vpLWKT8Ve+4TfrPWOVYU/P99gbJvjjF+cps73pJb4Tk1Cm/4EH0U7cTUfXMhEZieIvw3Nk8+S5tiSBzrrmom7ObdryNVO3+waQVcX9KqKEau3xW9QnsYFdEbxhBM8IWRbgMRmVCapUhdxjV/TOBrYgp2Q6FH//OyFOKdevebMYCfmZpL8zlnuMQdmXT/NEH1emm9pYKzBE0mS/JmpmyxztsTNwTk2W+7RKJCM/6knUuvr0u1nKdx1mSe5+5o6C+FiabHcLY8P/9liJMFcQiN3Fp0/07JXX0+8uTuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sat, 19 Jul
 2025 20:04:37 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Sat, 19 Jul 2025
 20:04:37 +0000
Date: Sat, 19 Jul 2025 13:06:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Donet Tom
	<donettom@linux.ibm.com>
Subject: Re: [v1 resend 02/12] mm/migrate_device: flags for selecting device
 private THP pages
Message-ID: <aHv6veBV7TumQA6f@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-3-balbirs@nvidia.com>
 <ln75hcgtiuutmlbamc4yd2sbwcada35daz5zufrrz3ad5ids3x@vtq2kntpg74s>
 <6eba6c3e-a579-44ca-af59-b8adc7dfffe1@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eba6c3e-a579-44ca-af59-b8adc7dfffe1@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2928c128-bae5-4091-4a20-08ddc6ff7cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FYUMZbmNvTwuRd7DlSU0nbomTy97He696SeDq7i/Rvcb4VF7jxjAXww1Jm?=
 =?iso-8859-1?Q?SDhO1yZoP9GVSWdWfg53h28Jg+6wMBl8ELQvV0jv6pz4aHHTh9gVjCDpBX?=
 =?iso-8859-1?Q?TT/GdbB6RppD+nQob7kLj/96zzQ1VnXrTLRMY7wDNHtXfuA+2ojmSBy00m?=
 =?iso-8859-1?Q?c+p3AZWM9oDlyF1RIDepT8ZcjS50dPJz5sDBSkB9915Ezm5jchBA1k10CJ?=
 =?iso-8859-1?Q?DIfC4gvNs3OwaQJEbyNztTZ3d0qpd5WDvlmL45i+/VHr+99hf8FAC83vez?=
 =?iso-8859-1?Q?aryYhUolbywTqDiCdLDaIpEZkWQNAp/yvi+RNfSiuorS2uH8bgKdSFt4K4?=
 =?iso-8859-1?Q?m/SYr84ElmiMyJzG0hqGJG+gaYAd78MWaPC0MbSEMcInb6T6/JvhYwmgpk?=
 =?iso-8859-1?Q?w7yfkQiExVvyp4oST7e/p8jhb02KF2IRKif/M0wHaY70eLPM4Kq/uvuhcQ?=
 =?iso-8859-1?Q?+PtIbxMORTDT5dkrcgrPmrTC6yvOtRNxJqv62VrTh/fmILttNNm6fqFigm?=
 =?iso-8859-1?Q?ZjVASs6d9pemEzyM/fJ9SvO0lUmBNATgA7MQ9eCY7Zjik5OX37lnl7G4j+?=
 =?iso-8859-1?Q?QGc9SMjwQ0wP5sblhZF0i7yB3rWs8Cce20H3LPtlKaOJDKViKASCTTzRv8?=
 =?iso-8859-1?Q?PBsdkzHlMKgZUmHrlV7i+52SDvX0/8kL61kyO29tYI7tJYLmemnrLTLMXO?=
 =?iso-8859-1?Q?W9Pyo62fhU5zimH5nSOoJ5br/Qxn2GEYoTSy5+kHEMd4esriYCh7VP3LSj?=
 =?iso-8859-1?Q?m76S8hnFcNZglQv/w47seCAXlCimDiTQ/RkKIvKlLk0g+43jdy5HPOEn3W?=
 =?iso-8859-1?Q?ENhpt2g1F8XJbLbgXg4eCvs93938Gn+KpvZKeU25nXsPn0tGNogkZMTJwm?=
 =?iso-8859-1?Q?ms8Ivb5FAHZGjm/Ifm6WiXaHEB42AKnOpy5Ed7u1CFXtw85g5bCvnyRAf5?=
 =?iso-8859-1?Q?gK6K583B+h1mLQM7ZtVzLfdCb07V4QOOeK+UxW+BDegNDNbmIWD6Tv6wGs?=
 =?iso-8859-1?Q?+wYYxsTIyAb2Ic43GBvMUUkvjqW4S8jno1vdLRrNVmQvOFwBDPyRUGiA0Y?=
 =?iso-8859-1?Q?Ky3nqB1MHtHjAi+pT3WqCowVpZGbRSI55RCWGQgMnYZtN9rTGtAly6+3qV?=
 =?iso-8859-1?Q?rpOXjScZxWL9XWNfYoFL16O5mCTHcPMCeI0p2zj59zYDP7O1ZZzkZE5/5O?=
 =?iso-8859-1?Q?Mr9szl5HdzqfGyGiqp4HAd85Tg1Aznss89pJ5UZGu+0Bibw0clXQmjPwN4?=
 =?iso-8859-1?Q?MhWycs352Ae+SuRLRHR5PEZKfQqLSGl6qRVOOiaMO67SuEQ0oQOnmv+IpD?=
 =?iso-8859-1?Q?HjVINz0Bvq4QrLxp6MfQTuWCKh+pKOOpOHa7hBudFp/c12guBmywcSc2hV?=
 =?iso-8859-1?Q?vWM36P7JJwChlKV3PpO0FFLAYThMnfI2138QYDdrho8noBKSNGSb+hVgNx?=
 =?iso-8859-1?Q?BsDdwUbbH3sNlFER/gGSxqHYRO1RTuav1ikG8LmVUYNzXwoR+z170aKRXq?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?apZ0kGn35hzC/L0Eoqh3RPPfWSJXPCcvgMttMap9hE4fyQXF6ZE+u4h0DQ?=
 =?iso-8859-1?Q?I5Jcvz8P0Jeppd/BNsdxQdsEwitfORkLP2QOWIaenXomMDfkohC2QRmFDV?=
 =?iso-8859-1?Q?Q9Pm2WP4wsXhrGprC7wUp+JJHOxbBpdfWC9jWVrwALo5huTy5+HI7jtHjO?=
 =?iso-8859-1?Q?XmUw2kh/E0whjptTGCUYuwp3bGJsCMyWv3Yfqxxq9gLbNp8W7+PNguVf39?=
 =?iso-8859-1?Q?UbJxF3HRprZ84LOTMqQj5wrwpyBpMivLb7ZuEO/21S57h9BMZUIOW2Y7wP?=
 =?iso-8859-1?Q?Hb5c7OVAy0ojaBG6hXVdnviwW1CastqDlLf8Oy9z595cAJqnYruQzXenIn?=
 =?iso-8859-1?Q?DPvbmiMjaHFBUe2cVq9RSxkmMKvaDpGvMdaSB79RYCYqfx6E2yUblggBp8?=
 =?iso-8859-1?Q?c2zWOfaTbGBFpFO7nIFBSZMhevn+BxgiQTETliGZJ9oQJ7QECrRDuR5GIc?=
 =?iso-8859-1?Q?f2sFCP6/FH397N+waCWpgXAS1nxlesKJgZRpw9Y2AuUqaIhVzJXb4V9WIp?=
 =?iso-8859-1?Q?enrxORRX8aHIW64zyNqAqVMHpPV3xPH8UfktsIiMUoeXYr8vYASlDMlc1z?=
 =?iso-8859-1?Q?PBkpHDqU74KmUN53Hmd4lFuGukTowAjxMnt7XxsJQ/2Vs0xu+lXpySB1FE?=
 =?iso-8859-1?Q?2beRQvAG/HPQJFJb+y6AFr9cSX9w7N+UM3GZtKNl1OpUALGtH7uSmvQH1X?=
 =?iso-8859-1?Q?t6cqclbaNbwjiPDN64UWUbbuM2f6rSgq/d0mC4NhDIhUcCSJetN9SZnMga?=
 =?iso-8859-1?Q?KacIXz+Zs2MfAn7hDSt4SYHriwxgeK6PdgOZYpQDA1sc0wzqgGXsJsdZi7?=
 =?iso-8859-1?Q?rHWvL5FoHxhL91mZWuJBNfyjjR7P0DrdXgKI1pS3KHL4UsAmZ3ATegX1wo?=
 =?iso-8859-1?Q?kwv0gwGl/YSmv1bG+K1qDWXC7ZgUMueFsjZN8Oxoe/9z+BGNnIQ9wxV/o9?=
 =?iso-8859-1?Q?MakqZ4WfHR1SHVlY4w3V3NsB2SKVvWPZr4Xp0WDmrQ3wZm2eOmLkI6YeVc?=
 =?iso-8859-1?Q?Sy4f0iyCdU4pxU1+wUSiVmOo6mfL60FqOKNk5ZHWF26azGEdjOV1vXGLf3?=
 =?iso-8859-1?Q?GL6VUlAm6y6WNq+qWMjulixZEJsO/vR0F2ApyqdcIskOT2GcD+yaz/zsBR?=
 =?iso-8859-1?Q?U4r5jtlxyihUJiy4AIxVxWn2hvA83/pXooIs6MsxKKpUkHo9nQzlJ/qOVe?=
 =?iso-8859-1?Q?c1Mh463eFp1GEDxg77VTNfnyWlUGTEWHkhqWgKmyV/6RPzOwgQOzcmf+tr?=
 =?iso-8859-1?Q?4MQMwTeSNewivwii2BgyKSF7UdaCt14WdzuzznLP8GL6e3X0eki/chGy49?=
 =?iso-8859-1?Q?dpWnunKWeh4Fn81zDaMGOg384fP07XweIyQsfcLWk6/v+ORiUmIIpL2AKc?=
 =?iso-8859-1?Q?HUCF1ELYfkxXipzWKjZfuib48M6wAPidEnGkdBVNXozxGeEIAlZzDKjNVi?=
 =?iso-8859-1?Q?YmtLje+s4HQC8CjbDiDzh3QkUCBfQpM0UCj293Z41d7x7IwQHLIA9ZA36H?=
 =?iso-8859-1?Q?PbnQYvuCvxqhqrNKHI5PW158AZ44kWWFQmZHx7qLcde4S11f0qwmlQjH16?=
 =?iso-8859-1?Q?YJwXGw3pVlrn2E8CuAdaf5YmsWnAwaAQa+laeIIcacqR9sCJ6PGNbOPEYX?=
 =?iso-8859-1?Q?V50JMVyHbRGqckAbxSTuBUkW9cN2j/eWkaIRBS9jC+KR7y7gDoh3qXKw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2928c128-bae5-4091-4a20-08ddc6ff7cc6
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:04:37.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dMHlHAmARwX40BHso784nWHCdtbGQ7WmY/0CjMkCXur7c4Rcs43f2oSoTSgszegMvvOGrk56RjeZCCu6KuoUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
X-OriginatorOrg: intel.com

On Tue, Jul 08, 2025 at 05:31:49PM +1000, Balbir Singh wrote:
> On 7/7/25 15:31, Alistair Popple wrote:
> > On Fri, Jul 04, 2025 at 09:35:01AM +1000, Balbir Singh wrote:
> >> Add flags to mark zone device migration pages.
> >>
> >> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
> >> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
> >> device pages as compound pages during device pfn migration.
> >>
> >> Cc: Karol Herbst <kherbst@redhat.com>
> >> Cc: Lyude Paul <lyude@redhat.com>
> >> Cc: Danilo Krummrich <dakr@kernel.org>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Barry Song <baohua@kernel.org>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> Cc: Jane Chu <jane.chu@oracle.com>
> >> Cc: Alistair Popple <apopple@nvidia.com>
> >> Cc: Donet Tom <donettom@linux.ibm.com>
> >>
> >> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> >> ---
> >>  include/linux/migrate.h | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> >> index aaa2114498d6..1661e2d5479a 100644
> >> --- a/include/linux/migrate.h
> >> +++ b/include/linux/migrate.h
> >> @@ -167,6 +167,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
> >>  #define MIGRATE_PFN_VALID	(1UL << 0)
> >>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
> >>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> >> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
> > 
> > Why is this necessary? Couldn't migrate_vma just use folio_order() to figure out
> > if it's a compound page or not?
> > 
> 
> I can definitely explore that angle. As we move towards mTHP, we'll need additional bits for the various order sizes as well.
> 

I agree you probably could get away without having an explict mpfn flag
for compound pages and rely on the folio order everywhere.

Matt

> Balbir Singh

