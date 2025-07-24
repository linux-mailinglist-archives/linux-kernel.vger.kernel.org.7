Return-Path: <linux-kernel+bounces-744088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A9B107E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787564E82DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66F2676C2;
	Thu, 24 Jul 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSMc76bA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DB2673B0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353409; cv=fail; b=q8TUmPyXLLVzYQXuX8n7YzVaSY4c0C2B6u38lrGZxFw3uJMk0fPt8p/upEt+kqONFyYHODu9zigYi1CF29J8n4JxO2z4S4N7b+EI3kmTQvgFIDTL3vamWBW9qGrH7HQpffT1Hgm1DJpi4Mri4ZxnlUVCESvHuXFxOIwnE2WVvVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353409; c=relaxed/simple;
	bh=6bcJxIEgFMYZ72j+yNo/1I4cXT09J/z3yYAq0Hpk4go=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aAreq3blOMqG1Kmf5nc+k3kcOWG7/uc9fFZmwqUhMRFABBO4nW5Oq+millrRGDlNOulBF5kp+NARa3uZbEGyWCWNxjCOFQ99Qx0rKy/EVtVrXmBKvoC03wJYH6LUre0xE8q93ByEgEjcfGEzs7mPuByWBIMhfg1Nu5089FCH8eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSMc76bA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753353408; x=1784889408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6bcJxIEgFMYZ72j+yNo/1I4cXT09J/z3yYAq0Hpk4go=;
  b=OSMc76bAzuw/B5NsWHREiiANjBxq7LuArgcbE9BAAReI0DaYWvs13XFh
   tetEXUz2cyAggBv8IbCj+aLRQW2lUp0MSYvGDfJ9XmdET2XbdljN1lkh9
   rcqZ81XMGbtIYzW6fe3H1Ih0zOK/3JdxL5kDq+NMKoAkFnfGsQO59PPMs
   p5fqYF70xKGg55YPjvnjRRvb2gNVUKxD9Gugo6fdka/ZYJoAaqmacdUGt
   Sc9/YRUWKu+O++6lXzU4II0cCWiLKQLcQgNEE5ncPF+d0IgwPFEtBh1xy
   B+QJzDDbu2OQzpge4Lk+x5xGPH5K98/SGc38H3H3/I23YAYjlBH8IZhNx
   g==;
X-CSE-ConnectionGUID: detyd2HCRXy/5GeGq7Eq6Q==
X-CSE-MsgGUID: tSmA5+FCR6ucgt5YaBWpVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="78204558"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="78204558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:36:48 -0700
X-CSE-ConnectionGUID: TYK0VvhmQsqO2mfTbXNlbg==
X-CSE-MsgGUID: ZhSyWQ4QTh+CZRcY8120VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159360645"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 03:36:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:36:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 03:36:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 03:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U51m5hK4+2n7tPzz3pmFLwxPppfNZpTGrXnzlXLpGu/wW7G7clf6ls93V1Bq/p3vZJBOXCz7vBRR4sDUHL6TBOb90GCV74FsuaBm3QhT1Od1t/MLK/A1RstN5SYMI35Iq4k6QkeAlCoJkY7bPzpP4LRPbc44P/rJP0rSvs4PK8dy9vRkb4z4hpPeh+dDxKlXP83ygfSDi8na2c1B0KUgCvC1uwd+JfqDdk6jBnrtt6MuzyYDOb6w0LdMcQ8C1OrQQQkCEyrhUnUMi+WfoNH0mHMBUk6e5I1Anr9ZiAT0nq13YtunWNzhjEDUD1LrMxlk2VrTJIqpvWzv38qFWJPTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+rZOKTxPP9dXCl2mgy6p+ElzqeSrCwKUFZz+vexJ2c=;
 b=y2OJ+dFjRfREllSz6zaa2svxzYkOy+XSFuBU3rIFr9Oh+RUZKAPuHz10WPkF9m3+QhlzsXVe1aQkPfo3fAparehL0M0j63C2oYtdrUcypfwkBie+CG1y32ZvvCG++HH83S/xupto/2AtrSP9h3UKmZV7zE2ZiZv67FzAtU2brNlfhUAaCYQo7Y0raEMVhhl/Jtkf1TgSfCH9kOUUlnzcsvI+erow7n2cr/0G/TV/dm8MgFjSsNpbH/RF7ctQAvZ95mJmASykSf6LaWuBICjVbus9/Zn0PkOE21l6Rq3A/Eeep9nEr3ZoUoV7P9ypNu2wDgrNholgV414z2/oxdaA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 10:36:44 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 10:36:44 +0000
Date: Thu, 24 Jul 2025 18:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>
Subject: vmlinux.o: warning: objtool: pqi_pci_probe+0x734: machine_restart()
 missing __noreturn in .c/.h or NORETURN() in noreturns.h
Message-ID: <aIIMtB33QFebm4xO@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcb6b25-7566-4767-e6bd-08ddca9dfbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MrMYjTaHa4i+NyIBLkvGOXbQ+MP1XxmlSYwvmpLiNPsSQnNy8Q4tm/98hltI?=
 =?us-ascii?Q?JpPNGjNJwAsjdpM84kAX/cmreBBTQqZrARrpjmydry9oJ0YMeKbeLzdCsnD+?=
 =?us-ascii?Q?eljblx3dLYyrQ/wo+fSgOpJRrwSH5mtGluuU1wvPfR6pynG20BiDaMhkwfwO?=
 =?us-ascii?Q?JivZ9YzN4svZurQfR0SWbdfWeWazKGm5GkFuKXMLTK/tsm7ZARISp21SVIXG?=
 =?us-ascii?Q?ifF1Aaly7JNsQAv4WqJvrSUBl3TclQ1v2kQxn1w4ZmEkfUavj8qIFQ+arNaK?=
 =?us-ascii?Q?jUnB7h97bGDZ2PutqalkGTfZRmzAa7f77urkPaNF4Djp45z5HDlY9Y7yhrT1?=
 =?us-ascii?Q?SOK9S2tlZ7uK1F13+/32BAAqMfdfIcOgqVcYr8tX8IzSjnystXyuo6y5zCDi?=
 =?us-ascii?Q?5Y1gkV6ECoEGFU60Y2Ah7EBVeaz1r/jKv+OPEYwYvTudIlAv9UPWfWEjl5tD?=
 =?us-ascii?Q?VEYkGHG0NgtPjDNhIYvySJg1iqy+l61kFjL6fZm7bGE/b1fai7SqmZqnM6Y/?=
 =?us-ascii?Q?QfHIP771q5gHsmT6SNbdh+FDxao0wUl3cWoKpb75RIH4E2lLNOBty5/L/oOV?=
 =?us-ascii?Q?7TVUkto4rX1dOmOTgV2uMiqVLGG6QhxMMMWjcKFoTWSgFO0jrZw4DXv/mfm7?=
 =?us-ascii?Q?Ndu/65ooA/+fssDXx17E5D7G26TfXVTVKmwGbXavaWJdFHf/GF8ClCy+m7ZL?=
 =?us-ascii?Q?nM0aCSqGobebKYPG5m4aqOlQTjQy2A8f51E4wzqem1BFOkyXIexuLVvHr1Oz?=
 =?us-ascii?Q?X5Dv7A1/u3X0Gn24gNm0I5RCfSO0Gniz7xIKK1FPnDKXhM8BZwfM5qJQ+3xm?=
 =?us-ascii?Q?R7MTVHkjDqDjq9VNQOUpbKfRGkgUSNqjiNsj/Dj2tPGE97zHqLFn45/sEs3L?=
 =?us-ascii?Q?3lC1TgVfoUwlUS7tyoXDP7ReBgShBQVYE5oTxuuR+M/Iukd7YaYxpk2o+MXo?=
 =?us-ascii?Q?F4nN44KWm5dS+9U/xDgY+2x0pfH6t3U8E0M7bsvNDPXNCqtrow/jzXCHNRve?=
 =?us-ascii?Q?Iyvlmzrcci6YY2alCtnIQnhvdNzAgytIogc4vn6LJgAAtrHiNWeic6HX0uZp?=
 =?us-ascii?Q?OUagPOzo6wyPHXep41ZhoVmkdMJw8TRhf+0FF3qGyzwkjzfEF2s0TGmqOVbq?=
 =?us-ascii?Q?UVm+qrsRCXJ/MgJ/RhGkQQ3aExN22Y8P5VsdZ6zTIUJSsptvoFtLJCOsyu5q?=
 =?us-ascii?Q?z3JYXvOv9/F9nKOEsBZlHUA7YY33X6IHz9Ntjfp5ab8tBo7ezbVC0Gn4QJKp?=
 =?us-ascii?Q?Q1fpD/FMrvA8PsUfkHRTgaDKq5+zE2odx9t3W98g7sDss6cgJWPMq53tzwA2?=
 =?us-ascii?Q?TGImdtOeNrbV0j7UB55eBXvRrVN7Jhk0040z1PMpsgtittGp3307Qq47/c3j?=
 =?us-ascii?Q?pPY6sP+uoVoQXc21CWZGYNwMDUQN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkNi1iLj22duAGGJii0UiH5sV1ckvypunYzFcbt4I2waqpiR5zW9f8X+HjSC?=
 =?us-ascii?Q?rtqHU5AygcvSaUvlMsqjLAkL3PRFs0kvANjGxaDzLMrICfik2C+OLpXMD4s1?=
 =?us-ascii?Q?KkIbdtMqVZ3HsWuMnCuzxPaMipXxt5BZO40FG0KotXFBVQr4Wz2ytb0ss661?=
 =?us-ascii?Q?Typ/UZH+4rNVQ/noBVQiSsLItEL65/xeGZ1nX2RBO40yLkclqG88cocNwEU9?=
 =?us-ascii?Q?kuOWmUHRcXjKQrwg/LJ0mdxJsksFdnwdR2kKIBtjBG3lPW3FnidatPv9tLwq?=
 =?us-ascii?Q?zs8uomKJ7AccfywL8pwUfla0JuACZjOCEeSRykKLjQ84GxLdhE/1Tnl9A+yU?=
 =?us-ascii?Q?YAF3PoN1ubr5Gf3olhhdOqDr5KBHDk3cvmqs3RrgYTOwXTqlQIgz5EBiBkoS?=
 =?us-ascii?Q?nacON5sF60SO9ARItxcW9Qm4baavPX47zMEOImM32x3FDSA0y0gG2h0CDJvf?=
 =?us-ascii?Q?pT4PAYaz+u+yDWiNz6zDerQQ7pwUPAqL0VFLqzBOEjf98R4rfIXAyRqg1WNz?=
 =?us-ascii?Q?j3PPUHwKE8xpvvF08ypc7+I+HK+4wz7OkjeuDRG9MNLyz5A9ityY/A8PM8Ax?=
 =?us-ascii?Q?m4woYyjlQ6TRVxIF0J3fA3yTopF5hcF+GeQz4WJaO5i96JXUgQfNXtAhNqmJ?=
 =?us-ascii?Q?yZF1keo75aIBeOFdf8EhEhgtXkrsNBsAIonAX+rGkozlD5I5eECjtilXZuvt?=
 =?us-ascii?Q?o+87ueVzFbFSXahxF4XmSxVzx0hxF5EKwv9FHeTDcZvQc8Yu3OKxNdXND8J4?=
 =?us-ascii?Q?q995Bbrfa+3GwST8qNbBFwbSU4cIo8eyA0W72pCKhhftGQUT0nR/hTfqQoGz?=
 =?us-ascii?Q?F8zUMGxirS8ROEWQ3NHpEw4Hj0SOtzYTqwrVBsgQ6GFvwYtL1T1B/nqBLFWx?=
 =?us-ascii?Q?G9TNABCO9JElEbC0DRyRblcf0xww8g4ej9itmE9RFrkOdxrUz+wi5vP1t+Vy?=
 =?us-ascii?Q?Q9VrpB/6O1q8CP/XcRXR00DQcHTqQSwPCWS3DMo+k9r2HgQiuDK+vhcxyVlF?=
 =?us-ascii?Q?A+eotdJ+sK2SXhjndjVok8k7vJLjjCYHATqVcspdO/cn+wxq7Au4AUDqpoWF?=
 =?us-ascii?Q?wt9JonrTrKmRQn+zNwaNq5mkcj9jTvuTMdoPA3iUPyw7kMhWk2xXe/vGgOoK?=
 =?us-ascii?Q?FCe669loFYQIv/SDff4W6DBefYbmKoogJmcQOo2m+UTltCIavLnnGpenJCUE?=
 =?us-ascii?Q?FLWOabgNl4FupeMOhR/9uPbszY1j/8F2mlts8IIKEiUXZ/gW7FhDNHbQvFg+?=
 =?us-ascii?Q?Yb+krHRfAb11T1C0uvcHh8r1Hi7o0CW87rUsb+9Wj80JWedTciSfKkB1B6lw?=
 =?us-ascii?Q?VsU0vU7OxOo3lFXAkyZ8slwXjM1Kvk/fOobbp00gbUzjf7BrUrpaKTSjWk5B?=
 =?us-ascii?Q?LbtSim/uVENAz20doi/BIoZL5PYrv4MTOQj3cdKKifrsmQl9bErdAgIKfkXi?=
 =?us-ascii?Q?/dPJvaBrwIFOE7pe0exRgvMUHqZiz9VyH2j3GvMl8VTEyXOk0J3SRRfvpQlr?=
 =?us-ascii?Q?yiIq+t+hbqmjfCPxMbRNJDgoMSJGrw+LsO0Ayq0kkuaaMhdg+TXhEAY2lUac?=
 =?us-ascii?Q?VePtzmCHs8IqZ2y1fQrHJc7aluDYAOpea/HX/XO8i55/QUVL2eHSkT44QEfp?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcb6b25-7566-4767-e6bd-08ddca9dfbd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:36:44.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZTVtM+Evu1s88nNec4HpqW4cm6Jm+dkXVaeL4pDBm2hOC4hQeMyk39hLs0OM08EzdGHMt0xtcbrdVTWAYyLxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89be9a83ccf1f88522317ce02f854f30d6115c41
commit: acae6b5bfffedc0440837c52584696dadb2fa334 objtool: Improve __noreturn annotation warning
date:   4 months ago
:::::: branch date: 2 days ago
:::::: commit date: 4 months ago
config: loongarch-randconfig-r053-20250723 (https://download.01.org/0day-ci/archive/20250723/202507231254.1nzhKlbv-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507231254.1nzhKlbv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202507231254.1nzhKlbv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
   vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction
   vmlinux.o: warning: objtool: kernel_kexec+0x94: machine_kexec() missing __noreturn in .c/.h or NORETURN() in noreturns.h
>> vmlinux.o: warning: objtool: pqi_pci_probe+0x734: machine_restart() missing __noreturn in .c/.h or NORETURN() in noreturns.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


