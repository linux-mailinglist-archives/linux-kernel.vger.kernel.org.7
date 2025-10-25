Return-Path: <linux-kernel+bounces-869662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A331C08740
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B18A3A84D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871D1A9F83;
	Sat, 25 Oct 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grK2tK7F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4F4A1E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761352460; cv=fail; b=nf+adCYe9mOPAL3at5dnIsCmvDoiO1jCla8aGYA86vbtxf3Li5v3IARMwc4zKBPS1M3IdpQ993b5Xb6UeyGTvuiqQmo0rBcjqsUvo01mWZ3G4jNrUIotZhGHLIbz/Ivxz3fiaAbNUTAMrMTHukjbWqUGxSomFw2KmRiTwBDY0e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761352460; c=relaxed/simple;
	bh=u7zqWHQOfoJsebVPoXuTe8X6odHEMMeeguCZoH5I8kQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=J/HiSlmCY8ru0Kp5wBzqtNJb2RnDcWOaBhMNV7SjIl0EIlxAeqZKHFFYXIrGNOKF6Ev7/oI7yfGIE2X+aF6oA4UfpU0PuaVqw6s0mR5aiJUFFMNqk4gkdtESgcwYOaG5V64CRQCHzjcW4Pmr+86lg5CHcPWOQD9eSVCHLHljo5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grK2tK7F; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761352459; x=1792888459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u7zqWHQOfoJsebVPoXuTe8X6odHEMMeeguCZoH5I8kQ=;
  b=grK2tK7FWA2aGTPngPqYG7VK7xsTNjk4qLXQXvf6r2PabOPnOIsLESFO
   rTooVujEGe3eh/KM7heYRFj+RY9b6SyPrsG0fErKHMFHJUwULPkMLhlse
   llMxDUJSrGoJlgzbADsk4T6CPXcoDkCku7CR5Jzq/MLO5vC8w0ZONq98n
   6lD4Jhybwc6JnW931mJHX9uoN9tcWNon30P79zU53JODnUEKSyqs7omsk
   wkXee1Kn3hDOlNMd1Llk8Z8PmjBUYxz6b71utLuQRu5WQkg4yl1lIqyrZ
   R3+GYGhoCmT/j3Wyri+vC3ugy+rb6iRjlkvqbBjWZvL/tHzmjL8kZv4qC
   Q==;
X-CSE-ConnectionGUID: abAdOWqaRbuWYxFc/6ohhQ==
X-CSE-MsgGUID: tvWO3/87TYuM5ZD4iYs9Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63426522"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="63426522"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:34:18 -0700
X-CSE-ConnectionGUID: ruIhc0gcSjmZ+cGZwZSrcA==
X-CSE-MsgGUID: dT2+oKjJQ/GGMKdjQit6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="184458403"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:34:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:34:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 17:34:17 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:34:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny5+V+mzwJ3V1OJYFQFTO/F5Xg1QjSNIO0zcXMqqrhIwOabhXnUmGIBmJbrdEc1AtkITcXAbGcdfmPgPjwAE6iXwKSNjsexquu5psjO4w2inr/BnX8wgGq0CrTnbt/SDM3qZoAKrOkAp+00fjHkUdKdHK1oa70FfzQCn8d5tED6XnIp4uP/w4iOfAV1y4icRFnHLE8CSVWb7lo1ZyV5cv8YH6wyJpCEwvAo7aUdI34ulxPyAgY7yZZNpNrzTKyH0MjpBabv7um8kslrG35Axh11OnWA479V7GbXsTZiyMQD12RTDcxjr+4xTGAYphJzlSljsHlsFjqMgIAsfdnTEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDkTH1Iy+U3tfI79bInaCdjt8g1jC51D9bx6kXv0KTs=;
 b=tVpn0tbZxVWvRKWS0/9lJoXQR7xb42LUTExKHWTOQATIixXjEnSBgzjyYwH4d+OFVeyUJq2xBsyPfhVNjltaZzFTxaHeH/mUsV3CdRiLcKXnHD4iy+oBmTtL35B82D8iJM6cxD/ps/Ph6Lux5K5eh75SZy0hBa64zR60250Z8iz3bJKKeywt6S3JYOPYF4oVCqtnkE1V3lglI28rouon/bpHwA6NNSxItYo1n7Cbjclm+YR3axwytiddplw1ES1cj49Z/iNFBnrSC14ty9hOnkbArEpwn4hamS2KbDzhwNOok6f5QmHjXPfVWSioVExGonU9ajb+HiaRzcREXhuP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by IA3PR11MB9159.namprd11.prod.outlook.com (2603:10b6:208:57e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 00:34:15 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 00:34:15 +0000
Date: Sat, 25 Oct 2025 08:34:07 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: arch/xtensa/boot/dts/virt.dtb: pic (cdns,xtensa-pic):
 '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
Message-ID: <aPwa/wW2XnDSzYWL@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|IA3PR11MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebb9458-cb7f-45f7-1f4d-08de135e39ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rDIOa8GS+1AtXSH+lYI/XwOJbUN7pbb10tFcSIOepo/SddSBM0SN4C54XBf/?=
 =?us-ascii?Q?8oltpSdqB8OWusH/xoQlUXNn460jEAnVt3pSCSF2mB8WwZx/vM0NG/OpmhLe?=
 =?us-ascii?Q?nODEA79FVvHkECM1dNJh9PcRM2FED0y/Nk6+xAwvBxjPZG31hnWuRBkfUBzr?=
 =?us-ascii?Q?S/Rgk9uK3qWfJZAwwEbTOwbCgOqB1iVW5vEwyVcdGW6Crax7inwxkCPU4gZ2?=
 =?us-ascii?Q?tkqCi6MifjTKouz+FTzvAEUs8PLBsqz+EjNHTIbFIUQpMg+Dhrq+XaIzSp1x?=
 =?us-ascii?Q?TRONSIhroncfceizZpy5yJ3FZFzu/BEpasgxXsefHyxapslBwyjrQxZrFS+H?=
 =?us-ascii?Q?mnhP93/1pkC6siFVOXqLZSgu14JZcjW34CLzNucQhql1l6CjizCXQ/gHb6Ua?=
 =?us-ascii?Q?U3nE3gPkuNKi2B7KZWeh6KBITWPoB1NzuRJQVbG9uDh7WrkjVMI8rdg20z4/?=
 =?us-ascii?Q?MTMkI9nz8W/GNMfHAbJcwy4zPczbVwy9tE0CJv0opm7YZ2+y3+hS2XvNCznY?=
 =?us-ascii?Q?EvX9gy3ymxFbKvP9q3roanKhK845xOOKnBHbSdqkE/qSPPaTFIhjdEfJ04qs?=
 =?us-ascii?Q?5/Z29bRTMLUgWiNqrGmT81qL19IYAL7BRpqf7GBsppxMrXoszRihdvFp7P2n?=
 =?us-ascii?Q?GeCVxZasfnj+PVMz2ETUTwujDYikAcBkCVm0YyAgYIyQgYY6l44nxc2A139o?=
 =?us-ascii?Q?+triYFXf0wYlyzp6PV5M7bCYh0FQjBgRCWuVccaI/PneARnRsAWEOlGlOQK6?=
 =?us-ascii?Q?sEl8WHR1kBkYhD51Yby5a7U7NPyNbS3ED3qWsVBiE4JkIpaMBdR2pOa8lxR4?=
 =?us-ascii?Q?rshnGQNTCe5mcz1q1Y0+ovxuf/TaZwLj4/yxUIbioHh0g9exMYfayfkNY0Iu?=
 =?us-ascii?Q?+2b1MZoNgD01p1dhgC6aetBB5IzUM7UD+HOcmBrWHzUMltrXIl7lnqKgnZHg?=
 =?us-ascii?Q?YW7G8UUMxOF/ZdoW6aCQ88O3wGzoq+TR8HFjWtOJDCPQP28d8Ak67+XzztJH?=
 =?us-ascii?Q?n3sPsew6WQ4SFeWluEL16wnZcq5kw5YPbIp6C0FFWVPhGm5LQKUcqXlP6RX2?=
 =?us-ascii?Q?c/Aeopy52bYtQLYs/2TkPk2hU5/7FjLjCUToqCl1eGwbVzzTKi4Ff4MRXKjN?=
 =?us-ascii?Q?/5K95WjltJiJRoWZ3SGTfJfq5HWSVY/Un1jqfex2HOFIyCwHFSi9dWMnfn6z?=
 =?us-ascii?Q?2tMUlF5Ou4SahgrayfC6ZU42PRYQNs6it/T99sinqLTe5X2okMoRywzefBM6?=
 =?us-ascii?Q?KFsP3S5/CROFehJYPI9khGGvL2awVf1cSkIK3vw8Uumqn9nQA6S78bccMDjS?=
 =?us-ascii?Q?sUOqJsxn+PKBRORNOa+t9UUu3Rle2vy2amAeECudTot7rh6keT+rRgc6IND9?=
 =?us-ascii?Q?L5FABqPx2nIPaUuNkIoW9LGG5OQs7U1o6sr5vX3i1ANM+geUdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRUixDAjPN5pN5VfcR46GFFIUbiatMKd291XyWy8Q0qdmKZaSbcsCa4srbgy?=
 =?us-ascii?Q?btU2gbjr4TbeswYqCe86tpE8/zAwRCjKh9XhRybNh0pG/iXCNacKHCP2hN+n?=
 =?us-ascii?Q?DIGZqe4S0OxD3X623+TKiFXw6emisW5vj2zfQETjo+rZ0RLyTqZQMrzOj9X4?=
 =?us-ascii?Q?g9jVmfpoEzPXX+2oM0z4o4Sws9TGqdy//R3MVwoyUuOMNR7RkCNpY3EEJ6gG?=
 =?us-ascii?Q?4O6wsCCu5jGHzEfJ4opuDwnxW30ykv+Y6JNonVoGn9dHTE0m7Sk0WdhX9w21?=
 =?us-ascii?Q?NQTwMtUeLY3V6GjLzEF9Pg82Rp4iTHVBfX9v5TZwIL2kPvO+5CR6dtxeNji7?=
 =?us-ascii?Q?LlPI7e3kInagAtwWFDo/c3Txwh0XH9xPNISDXh2/DC56QYEMID1wpczWFHPP?=
 =?us-ascii?Q?8UEMxysdRUScWeKZnqRc6FOuHnErJMQYRjXDnbz04Dz4PBtDPZ+3XnoX1Q+Q?=
 =?us-ascii?Q?ytpiSBZAvOYY6OaaO46sSFfQSiASs/gnHmdFN8DKJwbmX347jVxK2a2e9HSv?=
 =?us-ascii?Q?8F325rLLCv2de74naMwcQ8muc1kwlv65L2JHFkm5RqcTzRN7mFFLsiOmb6W6?=
 =?us-ascii?Q?D5lviaASfkko/OMqclo564Qxa0R7ZeVTUTx7uaO4C1ep06/O5g/4oAQ70356?=
 =?us-ascii?Q?fP3fBSxRHdT6F2EJK9UKMViFdM4Yc8AJbg+2dSu4k8KV7Kiks9+Gg65biAXG?=
 =?us-ascii?Q?oCbefkMM4eEvFxwxhnhS32EUcpeYjbEGfygkEXwHzg/vN+60NQWjv6lbPZrx?=
 =?us-ascii?Q?40wYRGu4bvMjKFYM+Wxhqs8MUFhLZ2euOL5ZD+7ORe8W4+Q8d4K9Dv151l2Y?=
 =?us-ascii?Q?XaeY73q9WUBHQ2el8M2HRu2YzXLTshb64M4A8RBqWDD4R3aOsVst2P5Ax9Ml?=
 =?us-ascii?Q?VJWENqnMH0ztJI2fjytM150YvXgU4eQ/M6Sr3cExGVtC31uyqpp72mCprD7y?=
 =?us-ascii?Q?3JDDeHN0W/0efwtx/O8sb0Whz0u5aRQomzGSkND64O8qFP3lRzNeenBjYGbR?=
 =?us-ascii?Q?BsnueknjxiBZAF5kmRQcJ93U06RHzHLhLrpov6RuA5lv1uWwLVKdcF5YQKpP?=
 =?us-ascii?Q?u75RTu4IYmavyruGne7h2QyIhqkhGq7n1YLEzKNjvOSuePVGU1L5El63w2vF?=
 =?us-ascii?Q?IKtJlEtZuspwv27G/UfTs6mDkStwsyKD0ftznIzkMitanlVHBkbaXczpQqSF?=
 =?us-ascii?Q?LWnFR+Gjr2QiFacaARMU/y5IBYKcMgH1XSQUk11lyJOhKq1EmwrKWFoorffE?=
 =?us-ascii?Q?Gb6G8z8+f3lZAfd5xpOQTtsdah021kL8UPX8mrhtp46Yk1n/heu8pSkVoXeO?=
 =?us-ascii?Q?C9p+UYO46Jc7B7Kkru5Q3ksHlGaTiXczsZcuU/g2tQJ9X7geXZK5p3iQ1s6w?=
 =?us-ascii?Q?IMtO6IkylUzhssiIIqq1bfSppYHExTANdR8X+SXu7T+IXPrCiaQVeIMI5+oi?=
 =?us-ascii?Q?vQJRIJNSQL7daQDJBDCI+m+yLMcKObs0xrUpMx2OyUO/RHMFCNb8QUmE0spA?=
 =?us-ascii?Q?cBeS30el9tfwdHCiFdLV0zm9cA8ngPKvNkGs9rCe5nOdvSyEyk23jbnk13vw?=
 =?us-ascii?Q?xzerYmhbqW6DTt1i90i1cN6WOvQyiBn3JRIaHRiS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebb9458-cb7f-45f7-1f4d-08de135e39ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 00:34:15.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afnNNAej3PiFGsDX9qvTwsFxgGQxvc9Vcel810L5zFyvfppiQmwQoUa1O7Yk/eESzqlwBh10F3J3Hbt0x6ZN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9159
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2818517e3486d11c9bd55aca3e14059e4c69886
commit: 1ee0fd43803bf82b5388db9b406c1b5e1a08cac8 dt-bindings: interrupt-controller: Convert cdns,xtensa-{mx,pic} to DT schema
date:   5 months ago
:::::: branch date: 4 hours ago
:::::: commit date: 5 months ago
config: xtensa-randconfig-2051-20251024 (https://download.01.org/0day-ci/archive/20251025/202510250232.fQdykjEp-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.1.0
dtschema version: 2025.9.dev7+g3b6fdac89
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250232.fQdykjEp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510250232.fQdykjEp-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/xtensa/boot/dts/virt.dts:48.6-71.4: Warning (unit_address_vs_reg): /pci: node has a reg or ranges property, but no unit name
   arch/xtensa/boot/dts/virt.dtb: /: failed to match any schema with compatible: ['cdns,xtensa-iss']
   arch/xtensa/boot/dts/virt.dtb: / (cdns,xtensa-iss): 'model' is a required property
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/xtensa/boot/dts/virt.dtb: cpus: cpu@0: 'cache-level' is a required property
   	from schema $id: http://devicetree.org/schemas/cpus.yaml#
   arch/xtensa/boot/dts/virt.dtb: /cpus/cpu@0: failed to match any schema with compatible: ['cdns,xtensa-cpu']
>> arch/xtensa/boot/dts/virt.dtb: pic (cdns,xtensa-pic): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/interrupt-controller/cdns,xtensa-pic.yaml#
   arch/xtensa/boot/dts/virt.dtb: pci (pci-host-ecam-generic): $nodename:0: 'pci' does not match '^pcie?@'
   	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#
   arch/xtensa/boot/dts/virt.dtb: pci (pci-host-ecam-generic): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask' were unexpected)
   	from schema $id: http://devicetree.org/schemas/pci/host-generic-pci.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


