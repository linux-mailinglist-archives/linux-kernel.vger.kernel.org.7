Return-Path: <linux-kernel+bounces-741167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECBB0E0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BEC1C83C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF092798F3;
	Tue, 22 Jul 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/I441Pd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4357277C81
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199007; cv=fail; b=KunVkUjQOLfTbqZHqeNPYS16pfJuXtuNBu0g95HMoZsuC+VMOJ6Pz9KUGS9bvY1y5hLRgnVAz6HnR+I9D8fvv9W3JqM6wadQN/rD92+Bynkf9CwBkx9fz/OpZwkS/uvIcG/pYxUYG1GVv8usuHPz1OqKpYxZMtBNMxFDNfLhwXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199007; c=relaxed/simple;
	bh=8zFQQQ1U+XSLm4F0Nje+82X+xhDTFf0Gsh8e3R6WdSw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NA6Zs76YLhNZZQney5ZuJp2LTGxC6z7iZ0JxXrBebMIB+a6FqNBWWJVRgufa31RKO5jHn5QWZ0h5euUMF2Y5oKdtDXHgXpW1wlbIxGy84/R2VlxkmA4BLjc9NBXTueF1l7uj8z2W9BvDnqoliwZExN2tYaD+pRVic3KYLo2l154=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/I441Pd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753199006; x=1784735006;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8zFQQQ1U+XSLm4F0Nje+82X+xhDTFf0Gsh8e3R6WdSw=;
  b=R/I441Pd2qfqSWHx5cZaf2pErI26vkA6pZJ528Z86Cj5kT5EParTUBlN
   j9++LzXKPl8TPO8JcfFUyImiaovfAIp+LxknC9x6i81P7i97Z/INtTgXF
   pi8qYTkFB8+Vz60QNaZ/NDaUZMMWO421n8WOXXPubeSiUcUTU/2p/KioE
   n1tj/GVeMMJwhTPs2VG/hyQQYVEoe/l1D1L8JaieJnFlvx3OEnW66/2NX
   XF/vPgrnF79y+dJxTxGEPbQ8Gl9EM2KpZGXbL5mlrPvNu8xilmdYE9P3Y
   jgujGAQRdkaMI44rcWvjCb77rJXaEHxywAG52fRAjcqiE0ymd49nqJixt
   g==;
X-CSE-ConnectionGUID: mtc1b+ftRB6tgnTaQbNpOQ==
X-CSE-MsgGUID: g7RnsPILTtOfd/QHVxzjBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55613710"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55613710"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:43:25 -0700
X-CSE-ConnectionGUID: +i5TWzqyRd6bugKoVid/xg==
X-CSE-MsgGUID: 43b+rTRHRJ2BxTo4UefRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="164645887"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:43:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:43:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:43:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPfPCNh1s6oG9pIK42Bhnz5SZy+L6MZQrTQhCkXPJ3vbeEd/FQzjy2XnxMfgFx1rpKlEm849+Cka/sk4IGKfrHozy12thGmlxb1vrbPZz8jti4ec1FE9O5zcAGnuc6tCUIJnF9V7g1nvZs9TIPcKb5PEik23VViqLrJ/eMhYOAdwR4dR7rYEpvjswhlMTwFd7u1q9r1vcu8Hs+IjFgNbcN78tFeKPNfcElRqgFeiXvIsRnuiNz+KRN6VKqj8RmTjCxPWgRdeGvuPT29lrwQmvys6OtKh2/L8wRhblHJJBXdfQVFdBaSHBwa0P6/YEjRiqUhWaHxtIB+jm3NyE3+7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdt6CNc+8vJYreVf4QvKLgV0h2R1eXbPoCa2+dEB1so=;
 b=q1wkDWrH0ySnQrBryZent+Ntc1jwYqWZyNJDT1zanjNv/ihwHti/dEjOu3zc99Gg42DrUxb5hMOwODdPjQGbjd9w711/+YeMY7i4J/vpYxVsv5dSjVgcsrGVITjwV9ZCIaMY3r0WuANuBVAQeH9/9hCWIyL+7AsfqEGWTIYBw6yzAjjdJZplSG27aOUhx6BXoaXED41lRKfdS3P+6bOSIyM0zO6WCfVw2y1NZobJPK8p13YteWXxqj534FxjMNEeM5MgH0fScLqI35ePaweU5dxiScA0jnepRFbuDpm50qRnBNzo2rDUG6EsOIxTdJMP4IruuWFOcTv+MY+NtX39/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by IA4PR11MB8916.namprd11.prod.outlook.com (2603:10b6:208:55e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 15:43:21 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:43:21 +0000
Date: Tue, 22 Jul 2025 17:43:15 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Xin Li <xin@zytor.com>, Gleixner Thomas <tglx@linutronix.de>, Molnar Ingo
	<mingo@redhat.com>, Petkov Borislav <bp@alien8.de>, Hansen Dave
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "Anvin H. Peter"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
Message-ID: <lvhvludvyuf2xj77qtso7lcyu4ksjigme7xuui3uuqzy2rseyp@dkgerndofq2l>
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
 <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
 <0390b5e0-f32d-400b-b2e3-b1c9cf162c69@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0390b5e0-f32d-400b-b2e3-b1c9cf162c69@intel.com>
X-ClientProxiedBy: DB3PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:8:1::49)
 To MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|IA4PR11MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: bf527c34-4e5e-4dac-a8b2-08ddc9367c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?R4i0MmiyB/u0olOGoti8UTUydU9+0yzGJfltYz15hsXygprRN24bX2GTCH?=
 =?iso-8859-1?Q?kRHAAKIH71b33Iu6WRgM8FS087+CD8+f0c05m4Q93sWj148azNw/Xt+PYa?=
 =?iso-8859-1?Q?+3Iw2e5SvKwvpRBkDk2EZ4zbmZUpf/dHB7G/Q7IK8efXqhkh3zMwZIcHZh?=
 =?iso-8859-1?Q?IlW6aoz1Zb7zL/CPtqk0GUOpkdgvMoS3btDN9fUbjcKcKvTS/ExBtBDfVA?=
 =?iso-8859-1?Q?cRQDG01rweoYuwxD5OaYHVonjhw3bW1kn/gzuiVQRDKbRK/GXp6wLwcZyM?=
 =?iso-8859-1?Q?DSkc1JXvJAJwkywTqNPEPWyJUX+KGvl8t3rFazkIdW24pobssj7CQCFzYG?=
 =?iso-8859-1?Q?8js7MfpLlcw4ajkVKh3AYP4TqV7wnsTQUsDCJHMV9yvJgm/M6oGj7vqKT6?=
 =?iso-8859-1?Q?FWXZfVpTKlw8nHKeAsLNAqXsK6AQMp1FIJ0FtZYW9EkZVd3FviaP+jIrkc?=
 =?iso-8859-1?Q?zoPJc/rm/R8/+HzL2bqUh6UJy4VCe5blbhD4lPWtyukkq4V9o6iEa62MIM?=
 =?iso-8859-1?Q?cIcTeKQEvdq+z3QFoNAmXajB90qLYTvds6cMrBlpuxJF6V15qoUofbuCOg?=
 =?iso-8859-1?Q?b6kvIMpFS3U06s0A987y6SOd/hFfoK7MoScrhTgK8Q5uTSxEGndBr8i9uM?=
 =?iso-8859-1?Q?3g9pjr8s8ND6FU5+p3CKLUlp6ll+0OqtM/vZdgc6DDyOu6Ok1Ee5ilI9oG?=
 =?iso-8859-1?Q?8PFtCE0gX4jUsipsVbwi+ZHDMfEyfrOR9L3fmyt0XlTUkjn/pxtVd37jTr?=
 =?iso-8859-1?Q?h/qUiPLNmHLQh80PP5qpi1xUOrM2vEsnmarjs6UFROiV/Lhyxk9ULkxQ5f?=
 =?iso-8859-1?Q?0W+HDQfkw+Pym9ZXSJqOYXebmkuNmiB2S6z1c5giB0f/uJOPJQXOENV6Ww?=
 =?iso-8859-1?Q?Xs8jDPWcOUW3jZVy0tVB43l7kmJhhPl+iWrozMuzOtar4h1sTU5FjiE3wA?=
 =?iso-8859-1?Q?nI9PzHfgzJajauv1LusW9ILSyBy8+DNw0U4AZ65CcuOrgP2t9UrTiomAcN?=
 =?iso-8859-1?Q?xcAbCZkVu7Sdb5ZG8qIJQxhGn0i4hOykDxDKLgCEj4Spl5G+YC742yOPxm?=
 =?iso-8859-1?Q?ByHz76Df6wT8vODc9WuFsZk0tXN2roopjdyJump0asTUcQ1EzuVSk1arCZ?=
 =?iso-8859-1?Q?UmxK5mhJMAtDdN7WUuqiEVZqKJlD7kUCE76yV2am6TgQwhNY3YDM/Pd1yq?=
 =?iso-8859-1?Q?bDe8APMRVmWu2W0c+ljfA8TTRl22WQvK2JQ3w4nYTEiEPaBchEwuS+QaC7?=
 =?iso-8859-1?Q?atlE6BpUulNU+9EFTQMHpK9/xvs5aqtH00WXPc+u4+cVBww+XrnBVRqkpX?=
 =?iso-8859-1?Q?TvMPZm6CLCua8LyYRw3nLTUzzgicFnbXo+qZGOs+6ZSvUkthx5n2XYGXzl?=
 =?iso-8859-1?Q?y50LY2d0HNoJmYO7l/KqP+w1DW7z29FfqllML06OvHRNtcrNq96RupT198?=
 =?iso-8859-1?Q?WGSO6ld0NIhU8zBKuU4EqKvI6zh/uwSyiG7Y73/oIt51+p8jVgx0DSX989?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o61B8FHU/ED5lEmpRNrSv8QjaMuFGQ5bo+Ivj2lNBmfRDNzd39lWbpOfia?=
 =?iso-8859-1?Q?MEIE7pdnvsHdfCAs+ufeNDXLQfBwHPHriP6ao6FBVix58RD7MpCS08upMz?=
 =?iso-8859-1?Q?qlMMc3wXpce2XIctO8428w133hW23pd/gvvS4z8JsjHROOdk1nxlUudlxx?=
 =?iso-8859-1?Q?QVH84RefrH2LmcfY6QBhFA4CcSei/pLxXPv5AQfTEnqsz59E6IAQqZFZSb?=
 =?iso-8859-1?Q?rDVT6n6exFNQWJKrm9Cirpe8nxGINCpuJ8VDs1ZzxZM7zFcbn1/UtUns1p?=
 =?iso-8859-1?Q?FrJTf5umKo4frvPdyXwe2dA+jIJmQH3SQ5IO9x9QvU2qfaczAa+DGqpBld?=
 =?iso-8859-1?Q?br2QMA82DelQhZK4HTkSiwKYDy6nLk3CJIbmwNq+yTK4IwpzyTxA045VUI?=
 =?iso-8859-1?Q?8CjMQDCSiDrIoAUoLyrI4HNSpwl0dSF/kbCvM6CwCe+mNfTOKlrPBC3OSz?=
 =?iso-8859-1?Q?VGzOqpuTLqwPHoIqQUieqNA29nscQuScQX3minVJS4w3PMj2AxK6q5uZ9g?=
 =?iso-8859-1?Q?EAoXt1jSbAnVBR6GNxCBkSUHx3f8G2gC0vSPiVV5NPI/F/Cx3EA/tXSOEU?=
 =?iso-8859-1?Q?MK/aBq2/8sJwj4FM4IiIXOuRa1/kLxE0GN4fdLU9Yb9Gbi/iZqK5Rox7X5?=
 =?iso-8859-1?Q?x/TgA2ACPolcuithWf+ikPKY3RMDP4tsVPXMCadCXBgQMQxMUarNTi8dsm?=
 =?iso-8859-1?Q?3N9a1w6wHyQ9ym/waQGSFTnqp/8VbCR6tsBfv74RlP4pr5TfnamJgPI2sW?=
 =?iso-8859-1?Q?FlswbJ3Ljfo4s360WZH0UXo9/9NLKQUs3KmWle987fKCYmwZ9+ZxuV1CYY?=
 =?iso-8859-1?Q?3SSRNHJ/HRmfwD01TyUN0EAitbATCr6aTy2aSiKjMwPcZsfGiifth3CU92?=
 =?iso-8859-1?Q?qWz2c/trfmIva/ohARKDLm8OHrPnHtEgga5c33Alg+tHnhqWG46a1vXfyc?=
 =?iso-8859-1?Q?M3Ix8j72Dm5KLu2UFAP7ruD1ebqKZaTnqNEWGhO/pr/INVOgxYqQ35sRnU?=
 =?iso-8859-1?Q?bbIdruWoUnl/PKFcRuv6ygsbn+lFJWry02aZZv2Gc5bZAuLE2/C1cpOVCE?=
 =?iso-8859-1?Q?MnVcz3JRdnMNSEiHLlhmsx6CsB4KSgeC0DZi6zGIbzAdXvyQmPO83HyAqa?=
 =?iso-8859-1?Q?YLiQbtd6Gd/GWzH9D7+tdvgey1/dhmMpHGQA/YVobEzF8xxrjq5Ritq3sb?=
 =?iso-8859-1?Q?ILo+qnH6vX0EyVOmneCMMLqFIQ3D3655CuQNm8JDk8I3QWDLpErKri7M+N?=
 =?iso-8859-1?Q?tlIdVIKfdxq+iysz0wUeSktaeTf00iRetsVhiVejhplrDQhfDEXBI202Xv?=
 =?iso-8859-1?Q?zgI/wlHNQiIimayMpiY8trWIR21Yo2rgMNBhIQc8fIeEHPa/pUCXdjGLzr?=
 =?iso-8859-1?Q?sb+QDUJhBK3uQ8/y1trtZWCaSgipPcKgXS9jls9xNC5h06q53lMQGex/8F?=
 =?iso-8859-1?Q?x0lAJFBmejI0Hh//JvLCEwO47vwxlEY2NOf7PRwaFq5nlrYwvqBjhbbx+T?=
 =?iso-8859-1?Q?s4z/453i6Jr0i2EBHfA+d22FjR0qdFS25fM2y6eLDiyaZ7XbyRqqSTJdmV?=
 =?iso-8859-1?Q?SYJLAYvU8BgFFBcOmNWhtT1Eq+39nA9N3MORsYe5FWac4ho3Nj8dUB5Aew?=
 =?iso-8859-1?Q?3VO2Jz2/WO8Iwfgrq/2f4bR59rJAKgPGf0y1bfjp5legORmKsulq9H/RTZ?=
 =?iso-8859-1?Q?NmZVdM7o2/uCG3iu3Y4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf527c34-4e5e-4dac-a8b2-08ddc9367c9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:43:21.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icjrQqA+AW+yCZ+zE4D/PGc/BXgurPraLk4E8Q2OmjnAOnT9Ih7qzsL10cYaDTEg2yQ51ALd1MKuJx+wogGhu2TyV7vTTVlgiE1EU0l9Jqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8916
X-OriginatorOrg: intel.com

On 2025-07-22 at 07:11:47 -0700, Dave Hansen wrote:
>On 7/22/25 02:08, Xin Li wrote:
>>> +    /*
>>> +     * If a feature is disabled during compile time clear its feature
>>> +     * bit to prevent it from showing up in the x86_capability bitmask.
>>> +     */
>>> +    if (!cpu_feature_enabled(X86_FEATURE_LAM))
>>> +        setup_clear_cpu_cap(X86_FEATURE_LAM);
>>> +
>>> +    if (!cpu_feature_enabled(X86_FEATURE_FRED))
>>> +        setup_clear_cpu_cap(X86_FEATURE_FRED);
>>> +
>> 
>> The following code will work as a generic fix:
>> 
>>     c->x86_capability[i] &= ~DISABLED_MASK(i);
>> 
>> And DISABLED_MASK(x) needs to be defined like DISABLED_MASK_BIT_SET(x).
>
>Maciej, I would much rather have a generic fix than force everyone to
>remember to open-code this for every new feature that gets disabled.

I'll apply Xin's suggestions, test and resend.

-- 
Kind regards
Maciej Wieczór-Retman

