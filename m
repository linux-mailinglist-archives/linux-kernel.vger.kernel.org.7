Return-Path: <linux-kernel+bounces-875131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29CC18493
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA17B4E6CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEB2F6929;
	Wed, 29 Oct 2025 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WibV/oel"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B102F7454
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715523; cv=fail; b=b9ZUWpdcWYn3U/hdbKZL8fXLLlGT0MX6nGVC+dImxujQT5MyEkkEeLme1mGkHllVPUCD9FP3c6tG3t/jkKPWCSjofBi3q+AB9101Fc1W1JYksBfbSwueEM41nZbf5wbc83EOnYJQkOOuulEbASnbASG1Zd8pcEvwBtlAHT/asV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715523; c=relaxed/simple;
	bh=DMMzpa0I+K6ecEFt6zkL4X5Aa3Y2auuHTHXX0/oEDfA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ap5AF7ynvPvx32tM0JgWS7YMMj5LfvlD6sR8TeqTAu3BdQfSt9sJlKPr76d4yfXrGTKYijxepXKgPWzRHBJQbE1XtKL1PqAWyMVSVfJLBrwpj+jg/NizaBdvkeu6IxcpODV3S0PswJ3ny6khta+UqP3f7ozI+VA5AyxOi865ozs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WibV/oel; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761715521; x=1793251521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DMMzpa0I+K6ecEFt6zkL4X5Aa3Y2auuHTHXX0/oEDfA=;
  b=WibV/oellP8MEPXr/M1Pl5o9VIeqY9xTsmsybJTC/6uFVxSkvfF8njqu
   7ymNnnhQnqRaCgnVf9wL0Mqhlew8KsLg2XH8OzHjizSMGzGyosOt95Dir
   SLxaYV4kCkro8m1b0dQcfy/g+X0njRD9+B2WXvA00DcnWwAgp5EsbhoIp
   vR6nMjmIFMo+MJPX7qs/5eSdgTos0iX14Nu+Zf7tm27ic6RlstCgt8FQI
   6Wa9dTFxCkU5XiFhljfoaJfQbH/ps3tXRPCo0vNGGsrII/Vtwo4EtnPPE
   vF7Jt7jS9+mSIUAEmfFzj0UdXoDOdUDsidiRKh18+WH47Uk/zDlzsNjkN
   A==;
X-CSE-ConnectionGUID: ecBOTNi3RfqD2S04xHsILg==
X-CSE-MsgGUID: CNePEYlQQ76R1x8GGwUQ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62855158"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="62855158"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:20 -0700
X-CSE-ConnectionGUID: fg55rePzQhqlGem1DCB7Bw==
X-CSE-MsgGUID: Z3k1WU2sT/quFm/Z+Y6p6A==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 22:25:20 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.39)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9Nwb0sQwhYGlHJT9M8A0BzAsjsvoUWg7xfNgzu+JcsEUjtM4KzNBQYzyGKoHxEgqtngtmnEBv6rZnKcqMSla14VtDt6eyqHjh+BP53jgM+8an+f5H4dQwIIpLqJ9o/k5UZaImrQ5oPdI1mjRzwFExNpZluwfcUyY6KHcS6h1wPOxSgXPnIEcq2fmrvgdJ/zKpdetKSAFW8tneqONgVk3tkRqzLxA5NJJpYsFZHE6ECwCULwERYIHq+VDTIrbT3wwn6kk0viykRnsnvUuAGa7TRfKffK+ht+klCkQ1pSYcFrwt8rmPUbCJhBBtbGacV7N0L5To9QYHM4xcxvMG2gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVct3d3thv+4VTZk7RDlzVO/DzNqSXllRwskHBFGKMU=;
 b=bcDea0uL2RSpOaMiXDtdP4RC/nHLK3tU8l2+I4t6UKM8gckdZC7r/rSMugGZDm/HNPhHAO2gfLH80CHoA8ja0sAAqxx3oZ0zqO5hWk7G+TJTyNjyf1tmca5etelo589Qg8FRmWNfuyi09tQjbsgn015EiqLA1X9jIjQ3qij4/uNpiY4rlleKcQOfVM2Ds6z3z5yVMxFoQHkSE52dolgtlor+1x71p4ymP2ar8W8UYjlDi4rm5qLxPipHWRMEa/PeNbKp7uU9s/vr534p/kK+FL9mlDKnwAgsY5KstwzVDknv9sv9sUqmFLM6WZbBw//jkWinyxGTTpc3K/s0FCNljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 05:25:18 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 05:25:18 +0000
Date: Wed, 29 Oct 2025 13:25:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: arch/nios2/boot/dts/10m50_devboard.dtb: serial@18001530
 (altr,juart-1.0): 'interrupt-parent', 'interrupts', 'reg' do not match any
 of the regexes: '^pinctrl-[0-9]+$'
Message-ID: <aQGlNs2JVp3sIsOO@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b31f220-52cc-47fc-3833-08de16ab8c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/+XgQMgWKqnCVm6lVi29DHiEGpEb13d2uXrg7FEM5AMoK/YHwtjepV2d7miy?=
 =?us-ascii?Q?0ukE5nKwnTFzJjyIcv3ZQcDjQ+unGxAtETuTemOIVkdy4OC/X01OAhg2DNUP?=
 =?us-ascii?Q?BRakMvQ96/HJcmZTSa/bziNA0RAJwyQpHa/E2HTN2rfPvCImzUBUNQiw/3Wg?=
 =?us-ascii?Q?3QwRv9hPWVLz5iSzmr6T3t1AiAQYFXTjaXCyyeQin9lB2R+1J9UQ2SJNn7pV?=
 =?us-ascii?Q?afg16B2KKy2TxGbWb4PV16pwszl22eI6ZNQQzjGK6WzxfT5Pny13XsiorJry?=
 =?us-ascii?Q?q/2OUH6ZlAbXZR3e7ljwq3Jimq5YOpyQ6ELBE5y9VJjGd4ylAnn8MePxlGwr?=
 =?us-ascii?Q?yITEtZP3tXZDrU1EzLc7mnflbXE7b4ZX5FV13JbPg5S/Xa6dUQnoiFH/Pfvq?=
 =?us-ascii?Q?DW71tojTxwTFdG25vRezwCj+eAZCvpB/aDYezbG8x7JcQsOZFG4TwAxA5nF8?=
 =?us-ascii?Q?SUarbTR65X9E8/JXzT0mj5MY8fopd+KR0443AVONvacZ16dSUrL4veGFKLar?=
 =?us-ascii?Q?+DM00XEo97T22utL7V5vGN8lLJq9fmxIn7QUtYvueCs81tP5Z27DFu/J1icM?=
 =?us-ascii?Q?yN/ERrhVG8PSb7aQ3x8Vj9tZ0Hog68oWK7JH54FfseFzoF5J5sF/6pgD8+Xb?=
 =?us-ascii?Q?9P+AUmB0YTuMjfnicAaUVUwfGcqIpdIdJeXHPc9J1iwlMg81gE4LFBuJhfZ5?=
 =?us-ascii?Q?bKJJzFPzg6WrxTBGAPw3pMwzXXbaxKc2RoyjhS4oLTPAyOtAUnu+d/zCo69I?=
 =?us-ascii?Q?r/Te+2xI1Ul/mqDN+HT6iSFefRpxVEruT9gawzmwCGzouJQFGt45ud9IlY3B?=
 =?us-ascii?Q?o/U26m8PJGWbq4m3QT1kzdr3xXGTLQ6GkKY10V0dg5QmM51p7sum5edJI/bF?=
 =?us-ascii?Q?XJP/OqBXaPOi2u3bUcTpGEBF0ecsqvhzGkKsd3ahNILYX8pBLNFIzg17bBBu?=
 =?us-ascii?Q?h33NOAqMRJYKd4y2mjRqcKyFXz2HUOqjnK0b5ZxNI4gmrm+w9l+tGG8Dy4t8?=
 =?us-ascii?Q?kY1ExDCHVqhDmPaVFetpz8xip3KLt080RNMb/Og55pcPx+pSn3SY2RWBUaIV?=
 =?us-ascii?Q?iwO27u/lJrMKuEkjduhFMqGYgTEKa/wlppm3T/+Bj5ONH8jPOnjRnNYacnUK?=
 =?us-ascii?Q?eoH9JSri27t6LCIny2AZrMwpPLEImcolK4KZ7kj2bGiFyRFddGAHXjz+a6ti?=
 =?us-ascii?Q?npWCzbF9rlLS02ghTanvqb+fH2XQX8M3ckYbZwiwMmKDg/XiZZNdhh9XSDrC?=
 =?us-ascii?Q?sFTFstQQwdhNVIktQR4BWXgtzfvSf9QXf2Ercrk9eDtoBPlcFgo+1IYd7A3p?=
 =?us-ascii?Q?NS3+JM/2iEjDfs40LViYilvu2QNNLwQ2iPcB0GvhrLCpVU1m3YhIZA6ZmhTG?=
 =?us-ascii?Q?dQzLPt6VS2/TCiB9LdtEKuMUFvItGpketa6WF2WpHAhykLuUQVZTNpYqOeJ7?=
 =?us-ascii?Q?wyuJrC085FFp2/DvwjHi93oX58o22MEERm7W6dIIf1Ou429vraOu2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcxeIYEfaHTI5LEzLBYReI470Je0fADWLEKmXRUT/l7loKSV0VfBjLLPkS8A?=
 =?us-ascii?Q?/qEYjG/yhAyB8hdiBYB0ffHAIt475RY/cVgp4kRZXDhoh0rzIHLgDhpdAq0c?=
 =?us-ascii?Q?1kQaowQ7d6Q4+SkHWURhVTD+RSkIv1y9Z6IYArci2t0Ze0X/O9ATCOgeiiy4?=
 =?us-ascii?Q?vFQbgemx+0Bb6x3pZDBKNL+/yEwEPfhsk8TLvHhk5Xhf4aiP4nLPpxkPouR+?=
 =?us-ascii?Q?OnxN0LVa6h2HdEtCL+8cdQ0I9OVplc9V8Iwy1kpHlhlrWQ+U2Hl+Q4xCC7B+?=
 =?us-ascii?Q?2SvmprTCFgb3QNdKZai6HDSzmw/yWSj4+ofxSPXWbPc9RPgUY2Plh/SCMAzZ?=
 =?us-ascii?Q?x/4svGGX1Zx/b9+V1rSrRosEHU0Y8uTFEuWrgTWH7Lk9eGnaaL1a02/7L9O5?=
 =?us-ascii?Q?38FWd/Sy+mOHYIBQvpJy0VQjfPSyLonpX8NP7QhShz5ZnGtY9WVoD/lvpRRL?=
 =?us-ascii?Q?840GAKWQSaj87cuRO+XR/eqAtl4UMw6zlUs4BStNtSGkAQfx0uQfPYQybETg?=
 =?us-ascii?Q?jEXdYpPuAge2oVufCLwMC+HGrH0szSl/53MB784uP4O3UdXxFNGitanXs0ZG?=
 =?us-ascii?Q?UPoTKg4xWHv5E8s8J7psnvRTQE/LtB2lW06mQC7/uwPD0MHxgn3o/GQmEOol?=
 =?us-ascii?Q?LNCZGTlAdVBGur1Zf9qXmUOdeTF1cfS5xnYKHKR0uCqzXHyI85BWN18WmwH+?=
 =?us-ascii?Q?B7JvaY2xbDPj0qCDUFIgzybiSOGeSc8EvEBPyuL6qqZD4VTfsyC8YZmtDSNp?=
 =?us-ascii?Q?P0yIIjBCJ014T9dHGWw1MhAmS+mL71452uh/2vWHbZv39TSCT9dfiUETsna/?=
 =?us-ascii?Q?D3J+uf6j6rs5fivwm5a/u7wYCidOYH5OnRC0wRXG7Nr7l9c3brhSdaBsNNSy?=
 =?us-ascii?Q?dpUnf9QLn9ExzVKdi83TjwFseoxT5+qQFf2bMhq5YcoUhLbLndbIK0+8AAhy?=
 =?us-ascii?Q?gzzw+Hq/McplSTuvR3JVE1eR4R23cv5rLG6dN28jxb/VECqIEsX0hB8xluQ8?=
 =?us-ascii?Q?N+CWLap+OEGqIROp5uNvR/0bKBZ9PFwa4SBmBMkUsi1XPApiJyb0VLNmia4f?=
 =?us-ascii?Q?Let0aAQYVhOkcD61O5Iz9LDfuZAR3xbgqgwzdTwD6aywIKZpWn63S4pJp+dW?=
 =?us-ascii?Q?mg+Y+36mfVram2maDpxpXcKu+6M9D9WkrKWPYcZ51a+LSWJjQth3EGHUtrJ6?=
 =?us-ascii?Q?XJPcHSKbG0h4lcCJkPnR2UU7Sx9ja/M1ltHebUcGqCkhgVVBqxSU49NYI7kI?=
 =?us-ascii?Q?C815LwyuoWYaClnJgdSu/fQgGGSMnYt7SB3U9zTuGFAwpH5R/5iyg/EC9lZZ?=
 =?us-ascii?Q?IP1oWLRXCFBneKkxlmN5MOO7P03sGCceTvIA9qV68sa6yepvXLidVne5jVOx?=
 =?us-ascii?Q?GFcZNHBUdaiNppSYxQu8cgaTBeCGSLCEeMGssG009jeRENcVQ+HZfWKZ4t+N?=
 =?us-ascii?Q?hj/3I/hE4vKUYroB+JebyK7g0qTFuxi9bfEeRQgh4jIrkBD8Q4pd84gUSUpp?=
 =?us-ascii?Q?Jys1JN0Avi89HggIuj/jTsqJYUYOtyeIa1Sq6fezhpcybODuDMufzj6la3Zv?=
 =?us-ascii?Q?8z7FavHNkB2szMdulRES8SX1/4kriXhUH4Wl25/0KeciXEKb1FuNf3DMad5i?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b31f220-52cc-47fc-3833-08de16ab8c09
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 05:25:18.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ty25ch90gfnJBqp7o5nO+Wn2JzWU7iA9iWtS2l6CBNKjKmEFnURDWXeEYGx7we+a11X2izVNN4HBLXu84p/HyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
commit: ed2a6ff0234e21cd5e56b63d8bff80120bbe5f15 dt-bindings: serial: Convert altr,juart-1.0 to DT schema
date:   5 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 5 months ago
config: nios2-randconfig-2052-20251024 (https://download.01.org/0day-ci/archive/20251029/202510290450.DOXoUh4w-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
dtschema version: 2025.9.dev12+gd6be03029
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510290450.DOXoUh4w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510290450.DOXoUh4w-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   	'reg' is a required property
   	'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: sopc@0 (altr,avalon): clock@1: 'anyOf' conditional failed, one must be fixed:
   	'reg' is a required property
   	'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: sopc@0 (altr,avalon): $nodename:0: 'sopc@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0: failed to match any schema with compatible: ['altr,avalon', 'simple-bus']
>> arch/nios2/boot/dts/10m50_devboard.dtb: serial@18001530 (altr,juart-1.0): 'interrupt-parent', 'interrupts', 'reg' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/serial/altr,juart-1.0.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: serial@18001600 (altr,16550-FIFO32): auto-flow-control: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/serial/8250.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/sysid@18001528: failed to match any schema with compatible: ['altr,sysid-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:2: 'tx_csr' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:3: 's1' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names: ['control_port', 'rx_csr', 'rx_desc', 'rx_resp', 'tx_csr', 'tx_desc'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
--
   arch/nios2/boot/dts/3c120_devboard.dts:46.11-50.4: Warning (unique_unit_address_if_enabled): /memory@0: duplicate unit-address (also used in node /sopc@0)
   arch/nios2/boot/dts/3c120_devboard.dtb: /: failed to match any schema with compatible: ['altr,qsys_ghrd_3c120']
   arch/nios2/boot/dts/3c120_devboard.dtb: /cpus/cpu@0: failed to match any schema with compatible: ['altr,nios2-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: sopc@0 (altr,avalon): $nodename:0: 'sopc@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0: failed to match any schema with compatible: ['altr,avalon', 'simple-bus']
   arch/nios2/boot/dts/3c120_devboard.dtb: bridge@8000000 (simple-bus): $nodename:0: 'bridge@8000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/timer@400000: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/timer@8000: failed to match any schema with compatible: ['altr,timer-1.0']
>> arch/nios2/boot/dts/3c120_devboard.dtb: serial@4d50 (altr,juart-1.0): 'interrupt-parent', 'interrupts', 'reg' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/serial/altr,juart-1.0.yaml
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/serial@4c80: failed to match any schema with compatible: ['altr,uart-1.0']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


