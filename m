Return-Path: <linux-kernel+bounces-829409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78DB97060
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E53B18A6441
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51A280004;
	Tue, 23 Sep 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UORnEZBK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CB25DAFF;
	Tue, 23 Sep 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648470; cv=fail; b=VuB8ib5m6tVz/KGc2VnOBVzY7JXIG+5yfaQpB89noee+IdhoNx75jy21Az8XYPQhT+pyZdfbXoXJsMOlchOhEK8WdmRSzteP7rQ6lWUKdlMMFdCmKf1MJXOG4Yr85JBSDbyYJ8ghvkYIs0JccyLR/v/WbIl7+pvX4lgaTi73JJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648470; c=relaxed/simple;
	bh=N1pCkqsLh/FiGmli4zpAdMZpZnInrhVf8mMJX7ZZBOM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4HAjTiHqbCkvX88m+rkITeZ44VDyxL8zzc5TlqXx9v4khNTQIgQcO0rrk/7TpnkHfI287JEHyf88A04I5ErIeFNx+trk7R/+00C0LWZo0VJI/ZsfbrtAsDNpUs7ZW4tKW1DJllJKL3DNzBfcxiRZP10NlgONdppu78wvmWg6xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UORnEZBK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758648469; x=1790184469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N1pCkqsLh/FiGmli4zpAdMZpZnInrhVf8mMJX7ZZBOM=;
  b=UORnEZBKI/OLBuf+2ikHoEX6hdZsuHOBSNGHh7kaVOSNiCu/zUyKyniC
   tSjFW5Gd4PTvVDV1CcJww3E+ODmWliK7SL2PLHyBZ67prqprjC942lMeE
   mFz0o5Dh2pA+tSJB9Z9oCZmNU5fZHmHu+jGDJZpCv0vPwcBrvcg5e49kJ
   B6urFyn29tqX8HP/9z73K9ofpmc1F+z1jEblIwocve8QD0A9bKax36+r2
   NfyVXdQr6UmmJRwzlNWyh7dgFy2DR1Jwjwr7VVWMc6wmAMBF/lc2jKyMm
   XLvIi1wJfGwWputwyINhLDZDeJwE1Go9NUCTAk9PPHojDQGxmD9VqDfFE
   g==;
X-CSE-ConnectionGUID: t+BKfE4ZSq2aWSNUdZMW9w==
X-CSE-MsgGUID: rc1W5iLETeKqHwtw2u1s+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63564483"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="63564483"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 10:27:48 -0700
X-CSE-ConnectionGUID: 2e1eHVbTSNehCWkWvmiJmA==
X-CSE-MsgGUID: KoVOitaISkOze89L07CtOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="213962187"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 10:27:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 10:27:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 10:27:45 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 10:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU4zzQhAMfj8OChs8LS2xsFO0J0ldderlwS8yZPSZLNprH+iD0DBIwB5QFlfFoYTN+i+ChTn+xG9jM/Zm3hDE5PS90Wt6kNWcacoaazdyF8YlfnwqlAkVS+jhP7s5/m1kfQzfMBis8NkDxTZTltoUcahOOuxB17RwVQatDsTIjO0sOBkVJQlbvIl9X8XLN1uIFdogQh59MsVywyexqanLR92/KpwiagC3AUIGw9LaLE5Qsfmaw3LM6ZgxkVD55fwtg0XFKyEdLKE3tmY2SLWlF2gxe9kL1ZJ3vikco7CAwFvETD7SBnQPFf+v62XfSN0LjAmnhNZae5/vuyldz0dEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSSUoiqtjn9THK4e78wkgitabmg8VAYHuQS7PASo6fU=;
 b=FZ/zLHSeSZs36txyrSdLc1vhcg80EGEnPmzrMk6ciuL2KYn44lDPSPo5i73xvlI9Xaww/U2DI3GzqU2SlIhvzAuDTVb8usK0LPD6613yFtkRHTH+84cniPlMpXbs+zaWziZLYsiO5gBTbkroeKAIoAwAWkBjUvlVku1mBULKl+pPiKZlzk0avZVbKNZhagfjcqBUk2krYT9rCSVnrK5xlQGpVKMTCF68ktWfodxHfW6S33ZcrqiCstszxXyYN6rY17U0DGNZ6p6hcjTgjZaAedFIq8VoP/1NL1WldPJReRbIA9DmwLCxVzXnKP6e3dRWQSyZ5WW+bN9uRWcpgpFA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:27:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 17:27:42 +0000
Message-ID: <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
Date: Tue, 23 Sep 2025 10:27:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aNFfs43UBp6tjqPM@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: c398edb0-ef87-4f5d-6a33-08ddfac6805d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFkwODVsdXRkdzltaWlHVVFWWHRZM0hWR0d4QitaNzhBeUE5SFV5Y0VNS0Zl?=
 =?utf-8?B?RFhZazYxc0hlWDNzaHBmamdBUzJ2TlZPbHVyVjYxQTR6WG9ZbExIczc5cXoz?=
 =?utf-8?B?V29nL3BoUWJjQS9uN3RoY3VKTjJ0Yk1WVVlRMU9kdjFFNGNnQjZjSTN4eDJq?=
 =?utf-8?B?SkdqTlZPOHh6amExM1k4Qy9BU0UrRE1MS3FjZng3aFJwT081KzdrYUpjRTZC?=
 =?utf-8?B?bkdBMGtUaWNDY1hDdk5HWkw5UFVBMVFTREg5NmNjbURLRUEzVFQvY2d5RzN5?=
 =?utf-8?B?eG1ab1g4ZUZKTGxxcWpPR2JUaERidE10cUtFbzBoZ3lORVpHZnhCbzNaRzJT?=
 =?utf-8?B?OEFZWlorTkYrVmlpTEUrT2NIZURNSFJ3VzNZZ1JsR0U2NWd6WFV0dUJkdU1C?=
 =?utf-8?B?TzJwMDJab3BLa1o0RUpYT0NQbXJ0S3RtaEpGaTBmOGhjNVF5UjNac0ZBWDFp?=
 =?utf-8?B?b0FoWE5tK2pIUFZTMmptREtFTGprTi9WVjFDSlI4TUQ5amtEUFNmRmtXeEJ0?=
 =?utf-8?B?SHlUcy8zMms3WXZycUZnUEpKREU4ZWdlalhldzRsdzE1WWR5S1c1N2p2b3RE?=
 =?utf-8?B?aERkNk55dUNOdi9ZZzZHOFN1bVRJN3Q5T09xeGRFb3dIalUwcEIyU244dnZF?=
 =?utf-8?B?Z1loaGUzWjcwT0FSQ1d5cm5GT3l2RWFJNFVHRjRBdm1CSU9qbis1YUpsWk1U?=
 =?utf-8?B?VHA1K2JmU1ZJN0tXUlVuWWxDQkxYUWkzUGpwWTFKZG93cFJTbGZnekxzZ0s0?=
 =?utf-8?B?dHlkR04yL1JhdEJhQmNZYXp1UW1GWHMrRGlyNGZJWklxazZ6QVlXNEZmSjZq?=
 =?utf-8?B?ZXd6MnFnYjlzdlRFRFY2MktvM3hkLzZQem9LUVcxMVk0YVRvYVNOVWNoUFBo?=
 =?utf-8?B?aXJlRkUyb1JycDQzZUFpUnU2QVJqWkpNc05jVUxjZ0trYlVBVUFmaGI5U2Zm?=
 =?utf-8?B?L1pJR2xTVlEveFlkTnBhdDB4Ky9VNy9FWElyYm9CQ1Fwd1VNQnB6Z3dGdGMx?=
 =?utf-8?B?dVZFVU02d2pjakhnWWJKVERObFV1S1p5ZldpZERieTNLNnBuWGk3Mkxzd1hF?=
 =?utf-8?B?KzJvTk5RbEYxRVlET1RGR1lNenJqRWJiblZmTFBocU9zRzVFWUl0QzVWOGVS?=
 =?utf-8?B?SGxwNWRWNTFaVW9TcFBmUXBuRk9yek9pNzZDTWxqMlhoaW9Gd0x4Nzc0M25z?=
 =?utf-8?B?ZndKWjBlb1J4Q0RDVUJXZW9FeDVyRC9BYllERU1CVVhINlNTdlFkZkUrRExI?=
 =?utf-8?B?eXR5bUwwYkpIUmFrRkhUajBvVGhyak0rU0taWHlzMGxLZVBPalNvTmdmeDhL?=
 =?utf-8?B?WWRQNThvbWZ2QnRVbTA5TzY2WW9QUlFERlBKbS82Z3o4cE5jV1hWR2hiQy9H?=
 =?utf-8?B?SlRNeXRuVHk1a2F2cHdzbEQvNjhaSW13K05LQ28ybFRoWHBOY1B2Qng4Mmlj?=
 =?utf-8?B?R2lxdkdyWW9QelVHZXE3MWZRN0hFRlVITC9kdGtldXUzYzMrR3AweG0vZ2Qx?=
 =?utf-8?B?M1E4cnFTb3JOM1NFTk1pQURONTI1cG93dTNNM3hiS3M3bUo3a2lLZVNncmlH?=
 =?utf-8?B?RHMxU05JcDRTanFmY040Z2RTUk5PVFNicG0wRlhhTGJQbEJwaExpMFpFWkVQ?=
 =?utf-8?B?L2ZzdlZwTzJFaHVHWXVxZE1Za3FZNEk1T1JmSnUrUzBBOUJ2OGZzeVdOWEwx?=
 =?utf-8?B?OFJKTjFGUGZMRnBPQkhFTmFzdEFBR2NrRDRoM2EvVGw2R0V2Qy9aZHFvazVN?=
 =?utf-8?B?UTMxQUZ1TmhZTUp2TjJyT1pITHlZQ1FSbU1Lb0dZZUdBSVQrTVYvejczWHYw?=
 =?utf-8?B?dzRqcGZCYWZuQ2JXV0VXak5TaGRuSXpDOG1TUUtQMkRSdGVJNzllQW1NOThl?=
 =?utf-8?B?U2tFSmVWazFTcGxlVXV0VDdhcGpvV0EzQ21SaGViODhkbFg5K1dPbHdJSERR?=
 =?utf-8?Q?JgszoncxXyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdCZmFDUnovV0l0bHd4aHRXYkFGSHg3RUtmK0R0K082SndxTTRCUnlZbGJV?=
 =?utf-8?B?d0d6SzBMcGw5ZUpTQ2dwRTdWa2huS1JEdWJHQ1hXc1JzcmlvQVlNaUc1bjd6?=
 =?utf-8?B?REZBb1FmNEcrd3AwbzR3R2d4NmVJb3hwY29NS1o2cncwaHIrV3NsNWwwN0Nz?=
 =?utf-8?B?M0VVOW9zc3FRTHY0aFdVdTVnTHVnYTNZc1VIVlZoT01tdW16RTdHbG5jb21j?=
 =?utf-8?B?MVZPNnhKSkFxUFY3bkhSNmFRTjhsTlZ4SWsrdG13aS9nc0hON0RsUkhhSWhW?=
 =?utf-8?B?SFJkbWZpaitGM2l4WDk4aFo3Tll3Mzc4UXd2cFZyNHZQMXgxQUFlc1h0NjZS?=
 =?utf-8?B?NnhqTFpXWVFteTMzZFRRK2ExUWZZQm5jcFU5dWZMTHUxRkZYWnJlNENOWEVu?=
 =?utf-8?B?d0ptRi8rS1pSMUR0ak0vdHhLQ3NWVzZjSEtCbVpPYWUxdFJwOVpJbllzTkVD?=
 =?utf-8?B?RDQyMnd6amNYanZSSzhJaVh3QlRoNkdvWlhzRkczRWhQWGgxenZzYXlNQ3ZK?=
 =?utf-8?B?R3F0dklTbzlQVnNKMHRBK1cyNDV2d3M3cDZjQ1RWb28waDhITGFhNkpscnZF?=
 =?utf-8?B?TmVETm9tcE0yajN0S2pibFA3UUFteE83SnRPL2gwSVVPWC9Wc1hsWXpRS2tW?=
 =?utf-8?B?b0NxS0x0M3BkUGFzYWJ5N3hRbTljQmJRQTFVSkVBZGZzeGd1Yktqc3dQSnBz?=
 =?utf-8?B?UCthRUhNY0dOWkhqUVBGZzJuanNSVzhnVW1YZWUwYnp5dlZRSWlHdGp3azAr?=
 =?utf-8?B?OWRZaHdMekNtUVI0MGovM1BiVXozdDk2RmlQeFl2ZVlDN3dmNFcyUGNwb1hZ?=
 =?utf-8?B?YkNJM2p1NXZVOVhHdmJ4M0xqZUVyRUVDc1hTcW5oNG9yQXNGS3JqNU5BM3pZ?=
 =?utf-8?B?blBqc0p3M3I3dGFzbkdtYXJ5ZWl5dHVxRnFhKy85U21lL1NROFY3c2dXazR0?=
 =?utf-8?B?Ny9la01tc2ZpMExPVDlJRmRQeVNHMkJodEV6b1M0eW5mM0JBQUJVbzM0VFJG?=
 =?utf-8?B?ekhVSDJoUk0yM1JpU2ZGSStJT1RRRUxaZTlndm5zR21RWm5ORDRqT0ZxRG4w?=
 =?utf-8?B?OUdRdDlUVXJxQVdMaXpSaTQybXhVSk5Hb21PdEZjenN0ZE9GOWNZeUs4dUFB?=
 =?utf-8?B?cnV1SzRSWjR4MUROZStVNmd6SGdsUFA1Y0ZINE5jMHI0QjBKZUorNUNNZXlY?=
 =?utf-8?B?eUdCc1UwRDJXUnM1aWxrSVBBVUY5MHlvOWdwcllWU1FmelBFZDRIWDRKMkw0?=
 =?utf-8?B?dHp2dU1wNXJPQ280QUlORXhrMUpZdzZENE13NitPY3B2V25vOEp0b29Dak9H?=
 =?utf-8?B?M01OOWlpU0NoRjFkd2U3VjUxYWdKZkxXcU1vT3MraWpMOWpjM2k5c0RxYld4?=
 =?utf-8?B?N1U3UzJPUlhqdmRvZlY2YTQ1UnVMc2NGZEcxV0prZFFUeUpTOStzdFJ2OTJt?=
 =?utf-8?B?MTlKbDMwRC9sRkVJQkFGS0diS1ZkYlI1RVFGMVNxS2lkZTZ2ZUlySU9jYnRj?=
 =?utf-8?B?cXFYZ3FMdGdaNDZnVWNXSGZGbFd1M0liaWltT3dKQ1JBVmE3WENqTGdWY3VV?=
 =?utf-8?B?YWxRMU8rTFdwaU1xRENqSjRlaUsycldQTmZmOGxsQmx3Y1BFWTg4dURoSTM0?=
 =?utf-8?B?NmZWTnBpOFRBQXJFMjVhdjA2MmxQMUVTQVZmdmV1N2wzdUlkaG5pNlpETEpL?=
 =?utf-8?B?Z0xUc3lLNGp4T0pqazBkdmtYaTFYUFRueGQxeVcrUmhGS1ZMWTYrYWlZbDF1?=
 =?utf-8?B?bjJUZ1hCOGNPSVVQYmZ5ZS90dHNITWdLT2V4T1pLQmNNOGczdnVCUE01Znhx?=
 =?utf-8?B?cjJTZDdEZUs2UkY1SWVQOTNjVDlvVjBlTDAyWjBSMzBLSnZIaGl5Ym1UMksz?=
 =?utf-8?B?NTl1RFd0SjVSalpYM09veU5WRmRoa1RuTUl0eGxkc0tOV1czTEYya2EyUHZL?=
 =?utf-8?B?NHJCNVJkTlZwV1FDL0tVc1YxVVFQSEx4dk8wU1I3WlRiNW80MzFMcDdhMDJl?=
 =?utf-8?B?K1hHdm5QbEx1TkJVZnZpaUlrK0JrbWc3eXJrMENrMDVVZm5qVHBnYUo5K1VX?=
 =?utf-8?B?M3FjMnNPQUtFaFovL0lHZ0Y4WXlyVzl0bzdUR25CeFZoeHZDZzE2RDEyNXNH?=
 =?utf-8?B?Q1ZnOE02ZUhmQjk2RkFIOUNoQ0VZQ1AvbUJRT1l5QkZRdkZqRG5DeDZBTUVq?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c398edb0-ef87-4f5d-6a33-08ddfac6805d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:27:42.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0TbUc7QKY2zQZjAwl2gNEvz8ydaYXUbBwuosuoXDckQVeF6yIIM0YNUO35thHp3gibhwn/QiJ59XFDhyFQkJkZLv4zgDfMk1ZLEqoPI/EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-OriginatorOrg: intel.com

Hi Dave,

On 9/22/25 7:39 AM, Dave Martin wrote:
> Hi Reinette,
> 
> Thanks for the review.
> 
> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> nits:
>> Please use the subject prefix "x86,fs/resctrl" to be consistent with other
>> resctrl code (and was established by Arm :)).
>> Also please use upper case for acronym mba->MBA.
> 
> Ack (the local custom in the MPAM code is to use "mba", but arguably,
> the meaning is not quite the same -- I'll change it.)

I am curious what the motivation is for the custom? Knowing this will help
me to keep things consistent when the two worlds meet.

> 
>> On 9/2/25 9:24 AM, Dave Martin wrote:
>>> The control value parser for the MB resource currently coerces the
>>> memory bandwidth percentage value from userspace to be an exact
>>> multiple of the bw_gran parameter.
>>
>> (to help be specific)
>> "the bw_gran parameter" -> "rdt_resource::resctrl_membw::bw_gran"?
> 
> "bw_gran" was intended as an informal shorthand for the abstract
> parameter (exposed both in the field you mention and through the
> bandiwidth_gran file in resctrl).

I do not see a need for being abstract since the bandwidth_gran file exposes
the field verbatim.

> 
> I can rewrite it as per your suggestion, but this could be read as
> excluding the bandwidth_gran file.  Would it make sense just to write
> it out longhand?  For now, I've rewritten it as follows:

Since the bandwidth_gran file exposes rdt_resource::resctrl_membw::bw_gran
it is not clear to me how being specific excludes the bandwidth_gran file. 

> 
>  | The control value parser for the MB resource currently coerces the
>  | memory bandwidth percentage value from userspace to be an exact
>  | multiple of the bandwidth granularity parameter.

If you want to include the bandwidth_gran file then the above could be
something like:

	The control value parser for the MB resource coerces the memory
	bandwidth percentage value from userspace to be an exact multiple
	of the bandwidth granularity parameter that is exposed by the
	bandwidth_gran resctrl file.

I still think that replacing "the bandwidth granularity parameter" with
"rdt_resource::resctrl_membw::bw_gran" will help to be more specific.

>  |
>  | On MPAM systems, this results in somewhat worse-than-worst-case
>  | rounding, since the bandwidth granularity advertised to resctrl by the
>  | MPAM driver is in general only an approximation [...]
> 
> (I'm happy to go with your suggestion if you're not keen on this,
> though.)
> 
>>> On MPAM systems, this results in somewhat worse-than-worst-case
>>> rounding, since bw_gran is in general only an approximation to the
>>> actual hardware granularity on these systems, and the hardware
>>> bandwidth allocation control value is not natively a percentage --
>>> necessitating a further conversion in the resctrl_arch_update_domains()
>>> path, regardless of the conversion done at parse time.
>>>
>>> Allow the arch to provide its own parse-time conversion that is
>>> appropriate for the hardware, and move the existing conversion to x86.
>>> This will avoid accumulated error from rounding the value twice on MPAM
>>> systems.
>>>
>>> Clarify the documentation, but avoid overly exact promises.
>>>
>>> Clamping to bw_min and bw_max still feels generic: leave it in the core
>>> code, for now.
>>
>> Sounds like MPAM may be ready to start the schema parsing discussion again?
>> I understand that MPAM has a few more ways to describe memory bandwidth as
>> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
>> schema format to user space, which seems like a good idea for new schema.
> 
> My own ideas in this area are a little different, though I agree with
> the general idea.

Should we expect a separate proposal from James?

> 
> I'll respond separately on that, to avoid this thread getting off-topic.

Much appreciated.

> 
> For this patch, my aim was to avoid changing anything unnecessarily.

Understood. More below as I try to understand the details but it does not
really sound as though the current interface works that great for MPAM. If I
understand correctly this patch enables MPAM to use existing interface for
its memory bandwidth allocations but doing so does not enable users to 
obtain benefit of hardware capabilities. For that users would want to use
the new interface?

>>> Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
>>> the other tests except for the NONCONT_CAT tests, which do not seem to
>>> be supported in my configuration -- and have nothing to do with the
>>> code touched by this patch).
>>
>> Is the NONCONT_CAT test failing (i.e printing "not ok")?
>>
>> The NONCONT_CAT tests may print error messages as debug information as part of
>> running, but these errors are expected as part of the test. The test should accurately
>> state whether it passed or failed though. For example, below attempts to write
>> a non-contiguous CBM to a system that does not support non-contiguous masks.
>> This fails as expected, error messages printed as debugging and thus the test passes
>> with an "ok".
>>
>> # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
>> # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
>> ok 5 L3_NONCONT_CAT: test                             
> 
> I don't think that this was anything to do with my changes, but I don't
> still seem to have the test output.  (Since this test has to do with
> bitmap schemata (?), it seemed unlikely to be affected by changes to
> bw_validate().)

I agree that this should not have anything to do with this patch. My concern
is that I understood that the test failed for a feature that is not supported.
If this is the case then there may be a problem with the test. The test should
not fail if the feature is not supported but instead skip the test.

> 
>>> Notes:
>>>
>>> I put the x86 version out of line in order to avoid having to move
>>> struct rdt_resource and its dependencies into resctrl_types.h -- which
>>> would create a lot of diff noise.  Schemata writes from userspace have
>>> a high overhead in any case.
>>
>> Sounds good, I expect compiler will inline.
> 
> The function and caller are in separate translation units, so unless
> LTO is used, I don't think the function will be inlined.

Thanks, yes, indeed.

> 
>>>
>>> For MPAM the conversion will be a no-op, because the incoming
>>> percentage from the core resctrl code needs to be converted to hardware
>>> representation in the driver anyway.
>>
>> (addressed below)
>>
>>>
>>> Perhaps _all_ the types should move to resctrl_types.h.
>>
>> Can surely consider when there is a good motivation.
>>
>>>
>>> For now, I went for the smallest diffstat...
> 
> I'll assume the motivation is not strong enough for now, but shout if
> you disagree.

I agree.

> 
> [...]
> 
>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>> index c7949dd44f2f..a1d0469d6dfb 100644
>>> --- a/Documentation/filesystems/resctrl.rst
>>> +++ b/Documentation/filesystems/resctrl.rst
>>> @@ -143,12 +143,11 @@ with respect to allocation:
>>>  		user can request.
>>>  
>>>  "bandwidth_gran":
>>> -		The granularity in which the memory bandwidth
>>> +		The approximate granularity in which the memory bandwidth
>>>  		percentage is allocated. The allocated
>>>  		b/w percentage is rounded off to the next
>>> -		control step available on the hardware. The
>>> -		available bandwidth control steps are:
>>> -		min_bandwidth + N * bandwidth_gran.
>>> +		control step available on the hardware. The available
>>> +		steps are at least as small as this value.
>>
>> A bit difficult to parse for me. 
>> Is "at least as small as" same as "at least"?
> 
> It was supposed to mean: "The available steps are no larger than this
> value."

This is clear to me, especially when compared with the planned addition to
"Memory bandwidth Allocation and monitoring" ... but I do find it contradicting
the paragraph below (more below).

> 
> Formally My expectation is that this value is the smallest integer
> number of percent which is not smaller than the apparent size of any
> individual rounding step.  Equivalently, this is the smallest number g

Considering the two statements:
- "The available steps are no larger than this value."
- "this value ... is not smaller than the apparent size of any individual rounding step"

The "not larger" and "not smaller" sounds like all these words just end up saying that
this is the step size?

> for which writing "MB: 0=x" and "MB: 0=y" yield different
> configurations for every in-range x and where y = x + g and y is also
> in-range.
> 
> That's a bit of a mouthful, though.  If you can think of a more
> succinct way of putting it, I'm open to suggestions!
> 
>> Please note that the documentation has a section "Memory bandwidth Allocation
>> and monitoring" that also contains these exact promises.
> 
> Hmmm, somehow I completely missed that.
> 
> Does the following make sense?  Ideally, there would be a simpler way
> to describe the discrepancy between the reported and actual values of
> bw_gran...
> 
>  |  Memory bandwidth Allocation and monitoring
>  |  ==========================================
>  |
>  |  [...]
>  |
>  |  The minimum bandwidth percentage value for each cpu model is predefined
>  |  and can be looked up through "info/MB/min_bandwidth". The bandwidth
>  |  granularity that is allocated is also dependent on the cpu model and can
>  |  be looked up at "info/MB/bandwidth_gran". The available bandwidth
>  | -control steps are: min_bw + N * bw_gran. Intermediate values are rounded
>  | -to the next control step available on the hardware.
>  | +control steps are: min_bw + N * (bw_gran - e), where e is a
>  | +non-negative, hardware-defined real constant that is less than 1.
>  | +Intermediate values are rounded to the next control step available on
>  | +the hardware.
>  | +
>  | +At the time of writing, the constant e referred to in the preceding
>  | +paragraph is always zero on Intel and AMD platforms (i.e., bw_gran
>  | +describes the step size exactly), but this may not be the case on other
>  | +hardware when the actual granularity is not an exact divisor of 100.

Have you considered how to share the value of "e" with users?

>>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>>> index d98e0d2de09f..c5e73b75aaa0 100644
>>> --- a/fs/resctrl/ctrlmondata.c
>>> +++ b/fs/resctrl/ctrlmondata.c
>>> @@ -69,7 +69,7 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>>>  		return false;
>>>  	}
>>>  
>>> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
>>> +	*data = resctrl_arch_round_bw(bw, r);
>>
>> Please check that function comments remain accurate after changes (specifically
>> if making the conversion more generic as proposed below).
> 
> I hoped that the comment for this function was still applicable, though
> it can probably be improved.  How about the following?
> 
>  | - * hardware. The allocated bandwidth percentage is rounded to the next
>  | - * control step available on the hardware.
>  | + * hardware. The allocated bandwidth percentage is converted as
>  | + * appropriate for consumption by the specific hardware driver.
>  
> [...]

Looks good to me.

> 
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 6fb4894b8cfd..5b2a555cf2dd 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -416,6 +416,12 @@ static inline u32 resctrl_get_config_index(u32 closid,
>>>  bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
>>>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>>>  
>>> +/*
>>> + * Round a bandwidth control value to the nearest value acceptable to
>>> + * the arch code for resource r:
>>> + */
>>> +u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r);
>>> +
>>
>> I do not think that resctrl should make any assumptions on what the
>> architecture's conversion does (i.e "round"). That architecture needs to be
>> asked to "round a bandwidth control value" also sounds strange since resctrl really
>> should be able to do something like rounding itself. As I understand from
>> the notes this will be a no-op for MPAM making this even more confusing.
>>
>> How about naming the helper something like resctrl_arch_convert_bw()?
>> (Open to other ideas of course).
>>
>> If you make such a change, please check that subject of patch still fits.
> 
> I struggled a bit with the name.  Really, this is converting the value
> to an intermediate form (which might or might not involve rounding).
> For historical reasons, this is a value suitable for writing directly
> to the relevant x86 MSR without any further interpretation.
> 
> For MPAM, it is convenient to do this conversion later, rather than
> during parsing of the value.
> 
> 
> Would a name like resctrl_arch_preconvert_bw() be acceptable?

Yes.

> 
> This isn't more informative than your suggestion regarding what the
> conversion is expected to do, but may convey the expectation that the
> output value may still not be in its final (i.e., hardware) form.

Sounds good, yes. 

> 
>> I think that using const to pass data to architecture is great, thanks.
>>
>> Reinette
> 
> I try to constify by default when straightforward to do so, since the
> compiler can then find which cases need to change; the reverse
> direction is harder to automate...

Could you please elaborate what you mean with "reverse direction"?


Thank you

Reinette



