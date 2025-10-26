Return-Path: <linux-kernel+bounces-870373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82637C0A8A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C003AC55B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5582DF144;
	Sun, 26 Oct 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSvohfF3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474761DFDE
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761486280; cv=fail; b=u5S37WwolO4fBhtyN4LzKJoTUM2j9IN+d5I7i2fquekvySQU+97ll0ZwGhOEoUoIEiNWS4Cb6iVy1czsCnfwYchDcJ/SJPQWQxSjyagQKrhhFlLsyUGaXCh5YoTX/P5emLoqJHyD8XyF+YKqgqsY5OZc+JkOcV2OJyCQzxIYNvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761486280; c=relaxed/simple;
	bh=KO34wGbxiD+ftvHDHmAwmdQrSAZ/6cVWAg6gsFTVM28=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qpjx5MMIkRI27QA1JdbVgMZJ9z48tvez5/c5hvIyLYc7UtJNXv+hw/6T/tWU/z9R+zCP5QdaDSDoZVaB+lqrtOtPFXpCKGboh6lHz6pTewptAKjIfcFDYf9MTku3tCvylH0/eM+Pa9eBxWirUaqv322ecAFH36F0mx8UclbMnoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSvohfF3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761486278; x=1793022278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KO34wGbxiD+ftvHDHmAwmdQrSAZ/6cVWAg6gsFTVM28=;
  b=YSvohfF3vlMXSOv81w6Ky4gGnC2QJKL7uJjMiqAoFWDYIdJzZlHlz5ft
   T7zIfj/vL6yGgnhxBYXWLPeUA2uollgHhkmB1diCtJ21TpUx8LrQDEh3h
   Hc2jXYvT2NrMNCT1tY6vc75mDw3B0YBLFf6U1DlF1T6SR/58xx/ICtLaS
   2B38iKY5xD/yQ74eIXvMz9Gz+u/7SY5UH/cMmACGAe+f0CG3OcH5S9SWl
   8uleEtajOJq2neT4ST0ijKvumf2F+ANz2QCLAn9Ih30huIKjg7GAVjZP1
   zUeW7KTTGdmEX2JThdldXRr7Wt7mNKGdZ/bv2HJCZMfl5/a/lGjk3pqKN
   g==;
X-CSE-ConnectionGUID: A+KtKanLSsSkSHlNkJeaoQ==
X-CSE-MsgGUID: xbz4TxssS9Wpgr/9hHjbBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63623278"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="63623278"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 06:44:38 -0700
X-CSE-ConnectionGUID: fIdMd8jQSciyWtXQYdB70Q==
X-CSE-MsgGUID: RjaRFPvjRpezDHRptFCcmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="189959182"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 06:44:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 06:44:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 06:44:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 06:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+JBEl57SVvc4ISvASkDgfXbb3VVA7Vs1O8kz5sBux/7uXnFx7pd/V1qo33korDSfnA8/JuMDwRETtVjC3gtGzhKD1SHcFtAqH+wdKMhDZfO7QsAgpoJXJzPuydoBLJEjAHIu82AHHZs+2bBvbVU/E1s2boFr7NZP0oKi3TttYSB0QN2twWLtiP8LzhBoV9m+nHrTKJGqErBOA9SGD5WjBXYQkFDwt36qJdHUaIJjByQ1qyqudNh18ocfZnuVmtd3OuAthAP9CztVs1YVBXVbtKh3R5sU9w6R8rPwrOjRDbULDvKEijPCTptlabS32Ps72wpq8mpIX6YiMsBvllcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoHNdUyc13u3evIEftTUoPxqRp5iq/+FfsS9s4H/sH4=;
 b=wiLOQIp6R6zEVd2n++LK154G2JbWd/q1l4kTWVrkGUBnFGWfbjD9INg7k+YrIjRWksF6ZvrMWlEPKKfT5Pb3oBFRh9k4rDggPClnMOV7JuvL1gZiZj9XjL0FtK8qFDCq7JDQ60ilrSpOdXolNCFAH+uOfFTt7Ue2dtaKeGmThfxu/RLG0R5dvHbxtgHyse5ToEYzCqi1L9ceUYa5jqnbWKRmCJqcBopJtMM8cJDnrPzGxPsT+FnmtKUFex/VBt/fWznLc0u7cx4JcD87PcIRRs+EXWYBKXKp35dCLqkE6CKAFZ0QI/00O8zrBGs3AIYAaW9JAse9mnWS8poSkOCZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 13:44:29 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sun, 26 Oct 2025
 13:44:29 +0000
Date: Sun, 26 Oct 2025 21:44:21 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>
Subject: iommufd_utils.h:804:37: warning: array subscript 'struct
 iommu_test_hw_info[0]' is partly outside array bounds of 'struct
 iommu_test_hw_info_buffer_smaller[1]'
Message-ID: <aP4lte2sKP7ekvt+@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4eb573-5926-4659-55d2-08de1495c94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8j1jwwrupBOgE10BCq0bmyZSKs/3XrPzQw0VEsFykzPGZupg9gui7VDsWy6v?=
 =?us-ascii?Q?GVG+CjelQtf17nFUboyXjyOEPq++ukA7FXD6d9PKmsdoZRNduMS5unyOiJXi?=
 =?us-ascii?Q?rbOrIlpEMRz/AyIujErF91R3fPsar2slUuufnf7zgkDYDuFPVodxILVPszWb?=
 =?us-ascii?Q?R3fQp9NuixUVUQHWjBJrtrvOOEjTnqVKi7jQyibhyKWH1xILUED5EpzBPlkD?=
 =?us-ascii?Q?fz66coTP9hjCWh7mZcxh4miQTQqSyv/sWgNHXPghy5XeBExwHAZqD+IO/Frd?=
 =?us-ascii?Q?1C/9F/75Soo+tZzMUsQIkw8ymeFfwcs5keiDtqHNAbr+wpE2ENbAoW1D9Wqy?=
 =?us-ascii?Q?5O5cUCRi25yTUV+SB8HvHqyKPXVT1DijYdJcw5WUTAkyd7d2C/unq+t0J7e8?=
 =?us-ascii?Q?CtOs0HhZBhnWzeAmVAKAgyvYF7wi/+Y1UlpUY2GDAtRMKU6XehSvkGAeZKqY?=
 =?us-ascii?Q?9296Jq5a5MMr/Y80jxZ3gBPITZ7BCczhZx1ZVfnOFGS6IU5tJLGAUjd/Klgm?=
 =?us-ascii?Q?N8g6+iBofB4fp4kfiCMtXgQ37JZiZ2u5hZCmfC7aB2J/Db0BeFSYN/kQ9W5f?=
 =?us-ascii?Q?Shrr9JYVMeOlpsrB3tFuEDjGFwDHLzTC7IGub7hzzCDBNKO3dcjCjSStsncv?=
 =?us-ascii?Q?roOWSDbAhqYcSL6FO2N5HsDQyCZMC4vfIHiX7TApB0A91/hLUZVw7GPBdMvx?=
 =?us-ascii?Q?LxLghBqNF0AWklUNMOXy3q8Zz2bl/hGmOFdfCIT5MU8tPbFK3s34XioFD971?=
 =?us-ascii?Q?sEVueyNNSka3tHXYN+1UIEfeHznmn59pj+fmUFN/FRKQaY2YJC8Q6A1pnOln?=
 =?us-ascii?Q?ZeyvDdF1pDSEASx0l5vfrKLDttX9RBgraT9EpuxlvIblyqq4sjdyfugLyd6L?=
 =?us-ascii?Q?KJbyQDOwcB9M5qC/EogyS9g9gjU1dMwiOeOlStiy3sQx8ctHcs0Hja47h78U?=
 =?us-ascii?Q?/u3HspRr5IpIGrZlkd3ElQuBLmpOtr/jbH5LRR+CjisbysqVg+6I3dMjJsSa?=
 =?us-ascii?Q?uN/Q1536eneab45bK9bkz+gj+sDw+qG7tIhsnUvIJPfJWtXCvy/qF+AKG2qW?=
 =?us-ascii?Q?bDdGoHrg0lx7yaWVRTp/HZgV7HT2cNUlAv3nFruIWIpnMY5AzFaeHZZ+Bl33?=
 =?us-ascii?Q?SiV28mc5FuGWrhcsUFGwnRS0Rl2A7LdpID8wwMOPy7UKr+DLVpulpbgl6Z8F?=
 =?us-ascii?Q?gCWvXjzJ3sThv6cH8r+0vTU9bJWuAeUc1arNSI06e0LXEqotTuk4Bytg/SDz?=
 =?us-ascii?Q?TuZYUOVpREu95ENlGzgK4WdZyY+/QhS5wQpEXFbypVMWgOrAchqIk/9LZzVr?=
 =?us-ascii?Q?45rHibKXAEwNTiGhY9v+LzEYHsev6FflCfa6KIlmf7S2nLGHo1SLOfEQaASw?=
 =?us-ascii?Q?y/O1u5THZRsx/+LYyc5NbO771U4+2IIdctiPM/tCQzP5tGZPzr3WqA9jwjGO?=
 =?us-ascii?Q?VxL1Hu9YL06KgOqf3VS/V7AJz/6KAwI0MjDR/VDLQch+CYgeKFSDfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ozFV/PmnVzlHTjmWQ0yKA9Bw+iUZPLO6cEe/cSRb1hbF4YCX6y/OUehlvJEU?=
 =?us-ascii?Q?UR6AS6kr0lZ1EuMwSru9iC5xqfXx1TGZG0/sK/hjDvK/Zly43xdEwHNXCmxM?=
 =?us-ascii?Q?JKHlPuuSRLwFqbGgwi7WxV8Gz5xc0bX283Jbj5v6fHFtUof6ai8K/3p/Qgzx?=
 =?us-ascii?Q?djs3kzF9KIanwqZaiVflqxyFBwGaEfAtezA2AhyasqrrO5UfkGeIspb9z3IL?=
 =?us-ascii?Q?mOcA4CtoZ289WSUWGjRYNovW5KenWXZtJEGwA0DANVf+ujIKpK/z7fBFgBXs?=
 =?us-ascii?Q?kRsTyXHw45EFX4KFtWAFhG/XttMlPs1l/sFvQdW47L2WuJE8iYgTD2TbJuWn?=
 =?us-ascii?Q?6LkKA/ooTaEg2/01j+Ik0SOwsNSclXu+uW+olf9OSSbwA1ZXXcvNSJan8Hm6?=
 =?us-ascii?Q?yTrSNwDdVmNuzh9NGFTErkv81o/6Rr02ls1RHdW8Lr/euDrHTgwr3h1A007K?=
 =?us-ascii?Q?ff84yiO9iYpV2YrmWJIkWyXyLd8K4o0opaZxGv+xexavjbGMdF0w0nwmoEMt?=
 =?us-ascii?Q?FfdhcYkY8lMcd0r8GsT5ovXakmna9XWioiobXscTG/2vzuIQA0xM1pVQ3igm?=
 =?us-ascii?Q?RBs0I6doxsh6mmLVrY1i/vPE4XnOKdCzpiaPdH21gfOLg9PIeogFBkTY4xkK?=
 =?us-ascii?Q?zmszsTzNfm+NIh4r0V7iTEVaFA+lrVlKGAozj2wWQxxLWHbqYkPoV1/0PPVQ?=
 =?us-ascii?Q?nwFf8D8wIqRzP9VFAHW/G+pR3LBwSWTBZG/RsGZHny6OdMsF0V4ttAQXa/pi?=
 =?us-ascii?Q?f0HOrqtpIG8PAT9UYMXx2BBFs/Gdzi+qrHz8RLu+UyiIAVd3hvToN3DicSJA?=
 =?us-ascii?Q?4TTSQtijM3ZwQ1eBS9Kq46blRMgXtrkQP+tl+OKy4H8Oc/1Qaf7saInaRAJ2?=
 =?us-ascii?Q?KRt4MXSawEC41BCSiwHD6BvXTQdtVIQXQ3jFTqMa+/OrU+CSiljtgphFESox?=
 =?us-ascii?Q?A+sVdwFR9XGdj4IPWJPbHueU6tU6aNrwxYnwA1+Y/2DbwjHyRscHkXZKnbSk?=
 =?us-ascii?Q?+nYL3YiWgr4lSLcDLwpjbybTMWmqCNQa8+LmqUtgm3+zlJ+/izAO/9Pe+iXE?=
 =?us-ascii?Q?y0Rj9mVe9Zool5DPNHWVx7jz+s3sdlDPtNR3IKtHz2VQNN0GkMYNx1cv0yBc?=
 =?us-ascii?Q?NHTw74IBzy77MJ8CjZOTXivI6HBw5ldUvrec7n/4+8Sb249VKfdsX5Zk6p36?=
 =?us-ascii?Q?rFe7+mxoSXIOFIzNdChCBhDxKPMwW5IqmvBkvoARqLctcelJdpLPrAH7q1q2?=
 =?us-ascii?Q?MJoZK7S1eEqVAo2h3AwdBJZ/IAtv4f6aiZap3SlrUUQMt+Lq3/PSU0TgTdSV?=
 =?us-ascii?Q?oIXd/jtEdVpcUGvyGMEP429BxDKMr9wGOddsp7lQaYudBHeQn1Y0twQciQ+0?=
 =?us-ascii?Q?UeDGUIMayuYr40ybU9bZQx7q/MSiNRtZgPvU22PBK9b+V3TEkMHUjBmbmjMR?=
 =?us-ascii?Q?/hH7Nu9gXrintL/kR0wPosNibB/1/+UMjnLQSv6IetxdDJ3qIhbf10X3gB46?=
 =?us-ascii?Q?usCw4h6luUirX8GiOKs3b8QcediNQHDcw1iOoHr3KKk8Yh8L93v39MKZmcJI?=
 =?us-ascii?Q?PbgpHVXlWYStpeuZxsX1E8M3OAX9UoIIok+0gwKH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4eb573-5926-4659-55d2-08de1495c94f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 13:44:29.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtAUtrcGMrQUwMefxJk190dzxb2vHki1QdvEl/Kkid/96XSXSzFSCU2RbhA5oHrj2/EmU+J6OeNuE5rQTOhtNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72761a7e31225971d0b29d9195e0ffa986b77867
commit: 6d9500bb1ff8c7f9c3ce199521c41aa41e8fd994 iommufd/selftest: Add coverage for reporting max_pasid_log2 via IOMMU_HW_INFO
date:   7 months ago
:::::: branch date: 14 hours ago
:::::: commit date: 7 months ago
config: x86_64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251026/202510261537.q8PGKcsW-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510261537.q8PGKcsW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510261537.q8PGKcsW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from iommufd_utils.h:11,
                    from iommufd.c:12:
   In function '_test_cmd_get_hw_info',
       inlined from 'iommufd_ioas_get_hw_info' at iommufd.c:779:3,
       inlined from 'wrapper_iommufd_ioas_get_hw_info' at iommufd.c:752:1:
>> iommufd_utils.h:804:37: warning: array subscript 'struct iommu_test_hw_info[0]' is partly outside array bounds of 'struct iommu_test_hw_info_buffer_smaller[1]' [-Warray-bounds=]
     804 |                         assert(!info->flags);
         |                                 ~~~~^~~~~~~
   iommufd.c: In function 'wrapper_iommufd_ioas_get_hw_info':
   iommufd.c:761:11: note: object 'buffer_smaller' of size 4
     761 |         } buffer_smaller;
         |           ^~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


