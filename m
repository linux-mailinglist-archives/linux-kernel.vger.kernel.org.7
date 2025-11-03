Return-Path: <linux-kernel+bounces-883506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03486C2DA02
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCED3B2CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE7288C2D;
	Mon,  3 Nov 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oD41zT3n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4B191F92;
	Mon,  3 Nov 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193843; cv=fail; b=sTBkcsQHE5TSwF2+i4XAZzNylluW0U9JGl3iLG4+szdrZMW10IQ7NaH/Mbuq2ZkxKnUv5YaRBdht7my9twC3+06hcH7xU94Ujcp/H6maPpHDSKnUIz0vIXhpMJ2m4uoKJxlAbWW7HVV0cNR6WMw9QHjJPQSje5WoafBP3JzXoeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193843; c=relaxed/simple;
	bh=PH8P7oNrY1X2jmQd8+eQHnaHCt9/CqR+VGPJNswUC70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oUWCSl4XuThdXb1a3JKTguuc9AdlOyBA3YRavj+7pyAh4zBY8+yCVt7Xx6KtsYJEYKgwH3kqSHJngH/1737gX/lMeiE4vC05QsP6gL6/DrIXpu81ca2QJhO1rMxSRHp3kUEJLkEZ5gZ4EKgiM82rm29XqeURL5sUlkbzfXgC1SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oD41zT3n; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762193842; x=1793729842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PH8P7oNrY1X2jmQd8+eQHnaHCt9/CqR+VGPJNswUC70=;
  b=oD41zT3nlbST1S2d1vsgM3mpxRhwOluB/Wdwp0ALZUERmjgea0Og47Gx
   CbodpzJEICWVNhSA+/5a7YLEWf3G05alcv+AbH+HGttKYoqV0bOlEJLzw
   KZ8Wi8v5mOeHm1ioh2ywqIqtT+NeqDF06k1/oCsGvwggtW0KifZbA12yQ
   4v9JZuwisI5ZB8OJK+kMQIckTW1FI0I+3PbaYw3pCcX6vzFn3ExomYJ9E
   j12q7BUKnYqc89NHSN0BRXiKGblzNlda28qOTAKIapzHXGmvwiQW/jHKR
   HGB/mmrytUzRNocUHlutKbbUVw7EDHY8u/P92oFRpYkZZpTUZutAmkDis
   Q==;
X-CSE-ConnectionGUID: gxSYkT4lSKavoU9qdYkaSA==
X-CSE-MsgGUID: d9Nw7H3eTX2fIsgVTLRyQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89737957"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="89737957"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:17:21 -0800
X-CSE-ConnectionGUID: xmbCUs4rSXWHlcrMf8RlpQ==
X-CSE-MsgGUID: UB9wQYSpSpyRfOcrzlx+pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186173366"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:17:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 10:17:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 10:17:20 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 10:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYQTMsnRO8VcwuCvlNKakBvhvSFrLL9A5z+0tDE2Jh8EQimSEOgqxaHpPbqzsahc04SgDDJKZR35ql6iDT0HH+q08qJh3r6YI6L+HrKQ+7I0aGSudPXo3fWoSa/xMueRZTj2SXobY15JxIUogMN9QhoqQIp0Ng0qetftAUd4+MRW2YoNIId3DlHhY0A6jDla7JBgLPync3ft0ewbj6SI50VnQidgX7pzHXHrE3rNcLmFppTXOp8aZ3VIQXe3YPwH43UusctQ1OA+wBjoHoFyQyS5OtL95YwCa3CIs18/sHXJksjo6HzcB4BYog+c0tX0CbmKOUHDTI+ZVYAqbdmRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK1WhtDkXj5XETgc1BLfd3v6Z5uOmPBqrZdGvD+xN0w=;
 b=ofWANcnsX6RrS05xJSfmVkRyMCUhWy+ZJvDEvyRx0ZCn0BDSmJ3NtdBX1wshds2XV9YlNptDBId0p44y20pUNitTB+ktV7k1aty5dVFgkREx/hW20OBZhS6iRum8qjTZf7M78h6jmS+sNxb2eDX5mezTKMevMTWeXctURMVADFko8p18U7r1jS1xl2UPx+LGlV09L7remMpBDBI4Jpnj1KOaqLysCf/TvIbI1+uIzEjBBgYhDCWJ0K/0EIQ2yM5vOILMkO6wTQ0K3UBGms7p2HX8ktDnMLfB3jlRMxATZIYpbroji47R7CNJGWVUZ8YhYWSUig8dAEG7+j0XEUqZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 18:17:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:17:18 +0000
Date: Mon, 3 Nov 2025 10:17:16 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Reinette Chatre
	<reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, Babu Moger
	<babu.moger@amd.com>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
Message-ID: <aQjxrCa8t0TDc_pM@agluck-desk3>
References: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
 <aP9a9ZtigAWCWSWk@e133380.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aP9a9ZtigAWCWSWk@e133380.arm.com>
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f4e9a9-a2a7-487f-9192-08de1b05391c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ln6YE0gKfaPI8wHUhl2w2MWbsaGQPrTz+pGj+VlltUBi66HAObn3U+ZngoQ1?=
 =?us-ascii?Q?uQ2dBBeRxMRmo7t4yvmae80kS/Peb0oo/3KnJZA60OCH/P0Y1671J/5yPU5u?=
 =?us-ascii?Q?tsW4SgpXJvIkY4vWKCvIq+3XXSfDZiTP5FHvOSNFz1PPjKU+AMrpIGZbJTTI?=
 =?us-ascii?Q?Tv5c48peG1qnVqWRNAmHIuzAoHIr6psY+xs1zMDvbbe7LdDsBzXY3brUg2F8?=
 =?us-ascii?Q?YUCwv9gUnObH470Z1My1eS6VyznZcw2VOfHemy9hpyAviomRyvfH30R1UGaI?=
 =?us-ascii?Q?rM2LUXXS0ByEYEkSQpFregd6YNXHlgnDTs2wuOF/S/Z54CFQLtcAIp6rk3ye?=
 =?us-ascii?Q?5OW1NiFk4G9yFBPS6yMXsDWg60PnNDtio+uCYxJ9e2nEn3j3cFOOWYPpvky7?=
 =?us-ascii?Q?XZitkeJGZ3ssa3gtMkp1d61R7tDXSihrgzTVNi/lbbkklhgcsjPQDwCMK/+s?=
 =?us-ascii?Q?TFwdvj7WbspgVOfKNiicNkwLqMMmn7QQfvzprAs1A2cHai13+C1kaKtAjuCA?=
 =?us-ascii?Q?AaDLioQH88pfRzw8jwdyGq0j3yK5WurRzIYPdXOiq66YrX1RPpqD+YK5WI5W?=
 =?us-ascii?Q?nPJ/GtjOtcdh7wtfIOh8SZwfok44zA+/sFcNNHHoyi1jabneGGAZ/F0XpTf4?=
 =?us-ascii?Q?AFtV/yxNiB0+6oS9jlni0zgbFkRo4qqQCnjRFjTrWer8z5PSdMtQ8zXqj1+a?=
 =?us-ascii?Q?YK5eofgIUkLM1bEJJIRdY+jLNut9DisXlYrkZP7mxI9J4mJTQbLl2OPOW5c3?=
 =?us-ascii?Q?sOf7B1jGTs+BoXn3TOy6zQMNrfjyPqV6FgKYAFsw3DbGoeREJxDa51SaHjr8?=
 =?us-ascii?Q?ziOD0fxb9dIEoZBHkCH0AhlXQgjC0mcdhyyXFEyvoq9PesugM8mG3z1URtVS?=
 =?us-ascii?Q?V9YVptCWrTsIs+MGrT3kNJzY2WUlMF2nZsZ6H64U1vpZ7DudsyCURgR1ZSg4?=
 =?us-ascii?Q?JztawchaEmg701QnnxQiHLd4mm9WRkqBzZH4MXz3V85KqRbLNBnq100wJzpP?=
 =?us-ascii?Q?xQGUST6Msztjxi33wE43RvO/evtT+NfXdKnjKS6w0bCT+DrDn5s09RnpjrVE?=
 =?us-ascii?Q?TbC4zFyO3JMHjAD1rHkrqVwBBxSfgn4Rpcfq/qQwNDolTwhXy8AJxgMYkBdI?=
 =?us-ascii?Q?XtKZS7PlxyfPc0nPxEevwEP/UUZWsJb6DUUHUikN0yJBTN9AWNtmhft7UNaM?=
 =?us-ascii?Q?3GFpnIsxTplAIOGYgIOZKHipgAgeI/j5BrUtE2kxI2iAsSiRtGwzwQV5zLrf?=
 =?us-ascii?Q?rnivZ7iQ5S+eP2A+vkEbm+naNn13HwvY/LFRC7rWPrQe9mKopiVmXWEXB9bg?=
 =?us-ascii?Q?Wk5BwsJlptHeJv3V/3zja/ji3AQCqmHJ2Jwfz3h16/iTV3JtPMpbWklSO/nL?=
 =?us-ascii?Q?OmvXZnE/i0MP2siR3g/SJgifzeaEu1deg5w/gHpWwpSHoTlL/p1KJvcYPpGs?=
 =?us-ascii?Q?hsqiQGb/ff0ZjYOvqpUO+6E5nn0vfghz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVTfXqnNnA7h5A9+6FMAW+lh/rEG5kEjq00PTvSDRHUGd98vVkkO+QQBtvUX?=
 =?us-ascii?Q?eMmF87b9qaEXKvcCs1TeYc3uVz3K2SAnYnAqcpl03Wf6H8+yIwhFe8ZxDJXN?=
 =?us-ascii?Q?cDeSMu+oUNKa8SshPVw1IAIr+BCkNvLbAjOsD1woeabFrB2gaQk38GAuDKZ4?=
 =?us-ascii?Q?dctFmfIdr7A3rfHcUqXOlThSF4/zlSGqhV05h+iueCKd446VEp09OkkM5Gw0?=
 =?us-ascii?Q?h1c3Apk2dgIHtLuolqvel26e8DXWK8h3V/ZWUairPX9BiorrUHBJE9oZLTeL?=
 =?us-ascii?Q?7m4cMFuAYBYua821LyX678KkNMJiMMUHKzHKiA6OVMvBtnAYlh0CqUnVoEvT?=
 =?us-ascii?Q?iQnUf6nPGF+LVaYqnRrgWRXSch8j5/oFgOMu7QpvHRU60p+vu8mwIW8ghCk5?=
 =?us-ascii?Q?Q/FWAI5wtuE9EAEEDQu8Qu7CYL76nXiUF9Ps4DPmGHcD/RDId0b9C8/4+yAy?=
 =?us-ascii?Q?aHl9YIYNxOgSaWI/ngYEHOwi1HCDf9zu8xXJtKYV/twrVL3egLYcStUgdfem?=
 =?us-ascii?Q?BZ8qSUoypSX7xCT+e3VcC08RGHJo9XYs+QPsm98erybHXnt8pRxyqgrfacNy?=
 =?us-ascii?Q?1giNLm/YCVXauZB/PdzO9CdT9Z6GvcjeSPF5RBe77kvfK+IEWPc4MBLAONAp?=
 =?us-ascii?Q?rWsm2cVYjXVVOSR3tX6fUNvjYLRbb+a6KverLKv+RV9BrgdXZ1DB5a/NDJew?=
 =?us-ascii?Q?ZqZ7RDMpGqfLzODojivN8oy8lpa33E3eHXvBPqubZ5DAEJATXPCMRidEMFKM?=
 =?us-ascii?Q?j3JAsbB80vDfVJL0zs7oMocNlBUzf239ibY05r2ruxMXkg6V8204amLtq/JO?=
 =?us-ascii?Q?NxEX7MbKiY1AJptTd6kJ47uwNCbN+ktasncRJ6dDK3sE9ij1OTYM7Z0tiw6S?=
 =?us-ascii?Q?PDSO8rmBPGXpuwj58aAWLNdLVuFzwg61yg0onkCEKzow4140VwK+9tGSCrgQ?=
 =?us-ascii?Q?4qhqjntylENkdKdAg+q91E+t4LMs/j1pOhhwfMAAk8rYoayBZRkcW7jI7v6o?=
 =?us-ascii?Q?S2HjeuHT7f+0ZzeZtYbxTB5tsYVwI2mK9DVjp5FuK6F1J3hgkGpbKf9phDZj?=
 =?us-ascii?Q?1X518/09+17zgQ9JBTcv2lzm6Srb7M7vEFRszXpRj9f+64sTUQ8M8pHhR33i?=
 =?us-ascii?Q?/YAuy8wezLjG2lXaskuQrsnosNsHCia9dlhLGCCntO70b9boyAVCuKrbZOa7?=
 =?us-ascii?Q?p4s4F69iXo9k7o+HLd0GNT8OgyJqlyFd5w5WRbFFIe6rrVRu65ayAQ8ApgRu?=
 =?us-ascii?Q?d6uemYpB8af5lGPZHaYppFUNdKUEMxbfeMQQrIEKRVR/mq5ZIPrFSYJoeqtO?=
 =?us-ascii?Q?7ujAJvY1E0ksDYBg3OBnSvMa4qNM7gQeGjhNZMm3ag5xzfsFO+koFExzO+AX?=
 =?us-ascii?Q?t0dfjg41b07fMcbJPWtydPZS9XRIn+QLVVzyQOagu8LG8c9guV99DrWePEKV?=
 =?us-ascii?Q?eu3BEBZ+1iWM/QLzx1CNfQrQtH3fVCpg4v907gviNQdryD+muOWH9cKIMayE?=
 =?us-ascii?Q?kdFW74nbc8U/GHoMM9yiEzNKjMPGb2ye3kbGzCd2xoJRKPnWri7qo+PUoJst?=
 =?us-ascii?Q?K70Jqc3tuz9M0fFhpx7BTbqJaDfJLQdM1kzOdBxY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f4e9a9-a2a7-487f-9192-08de1b05391c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:17:18.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCSzI/WNXZLl6RFsXHYSMNBAIvz0OaCJwaBFuKshZazdG1c9ihqgIggx3jDrVBe3WgLSXxfFGYZSnTLK0+svew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-OriginatorOrg: intel.com

On Mon, Oct 27, 2025 at 11:43:49AM +0000, Dave Martin wrote:
> Hi,
> 
> [Tony, I have a side question on min_cbm_bits -- see below.]
> [...]
> 
> <aside>
> 
> Also, not directly related to this patch, but, looking at the final if
> statement:
> 
> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> 	        rdt_last_cmd_printf("Need at least %d bits in the mask\n",
> 	                            r->cache.min_cbm_bits);
> 	        return false;
> 	}
> 
> If min_cbm_bits is two or greater, this can fail if the bitmap has
> enough contiguous set bits but not in the first block of set bits,
> and it can succeed if there are blocks of set bits beyond the first
> block, that have fewer than min_cbm_bits.
> 
> Is that intended?  Do we ever expect arch_has_sparse_bitmasks alongside
> min_cbm_bits > 1, or should these be mutually exclusive?
> 
> </aside>

There's no enumeration for the minimium number of bits in a CBM mask.
Haswell (first to implemenent L3 cache allocation) got a quirk to
to set it to "2". I don't expect that we'd do that again.

So safe to assume that resctrl doesn't have to handle the combination
of min_cbm_bits > 1 with arch_has_sparse_bitmasks.

-Tony

