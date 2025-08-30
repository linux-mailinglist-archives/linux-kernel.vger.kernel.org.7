Return-Path: <linux-kernel+bounces-792758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1665B3C88E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B27C7A50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0A265CC0;
	Sat, 30 Aug 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrfofNMp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D4279DA9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756537024; cv=fail; b=ZZq+v+zlTleQPwtX/SPoWSZVA8DMJZakbt61CGRbk5Ip1eCncWgTJiqkuP9hJ5YNewH/S6bXmk8KCc9cKzHgJW7r6GBeIM6SbzR87pIVhm8ycSPT63HqEtZz7mnEQON9Tc7ITY9DUjOpKRZnMl0OqW9QZjbYopu4h8odwPcbXzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756537024; c=relaxed/simple;
	bh=NT3hnR+oH3HTL2iQ16vVYcccIJAgUF1RxvSSRslklI8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfLtSUUrfIgaPIyQA8VC2dPghHIMKvdc1mwkXb5Rjx6PHo/fgQk+De37hTyaQJu+fkA/DwUCmw0hPvWOuyuJ/uZsa/Su1VMvbFdQgfjYBnDzOpYWkf6kYHqROFhp749IJAvK1YS8/J7irYtEpfWF1nP71qMQlRH/GYet62uKK3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrfofNMp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756537022; x=1788073022;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=NT3hnR+oH3HTL2iQ16vVYcccIJAgUF1RxvSSRslklI8=;
  b=NrfofNMpP6oDPYRlcEIVtFqLilFuf8GizoIAROAdE4zyM/53cq4QoIBa
   s0Unzp8t5oORhwCjte9GytrGDtN+Tb/qhKmCVEyMg+Ns7IG+4j6kYJhL8
   gg0Jg0+WmwS85ndMpX6vMTbcxezT1n4NJ1zELZOEr8zII55GEUUtAhLzl
   +Lo9ncSF4CSMsJADAsAjp6Yp/XLfQSwQ+jRKi4+Six7XXpd0J7HDogI6+
   ICJWYa7gqMe/Vp/IyjUrwlIrbh+4gAXkgcSgPG/H35WzFjBhm8oVL6eho
   h2k1b0R6LtLkqdXvNoZPA+NeiP/9ndifL+BAtFOQXeDVCXL8DsnHRMYi4
   Q==;
X-CSE-ConnectionGUID: BbtY7s1BR0C8SHPdea4lGQ==
X-CSE-MsgGUID: 9HB2gw9BTCq70chbZm8MVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="46387614"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="46387614"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 23:57:01 -0700
X-CSE-ConnectionGUID: M5GxVbmpQcOvw6AWNUTfFw==
X-CSE-MsgGUID: NW9mVUJfQayz6IkXo1cXQA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 23:57:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 23:57:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 23:57:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 23:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPKsbZZT/14jN0usghuc9+OmIo6lvciAPwJYin/Lw05bKYIK4bFUNVQNLhXct3jhJRHCmc7bvmP1+ULmhA5GRTfJdO2Z+4ZCGwEYCi7bB74VvT7AnFmUbEMMymrBHpNoaSLBH9M5VqHw9QHBRnnHceK9fipPpwchVAFHnKOezoKFHDQng5AwsLyW2+RkTk58m4jccDofI0s38ASlPy9BTQRKQFor7PtBmI/P13LgMgVFKoMpUKJXBvcYLKy605OYelIh5QTybrkNCm09zrsglIo6ojaWuM2en0HcwBfljcST96Z30SpDZtLufBRKEF54wha5XC6Ffo1YRqbIPp9uSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I56N651xixX/1rL8DD3JhgrrPL5JfFr4AEcpb0A+gBc=;
 b=TzivpygXIvzvhG6PU5IDBdV31ofgekUTwCrH/NV+3yzOpGDhGXDWOdu8v5W+ZQc/rp/1B0kQsaWCXDXOBJBzL5tPxzg9gLplFEtkB6Ol3+lWeKpgHJrOGvrCqI0iTGNEkOK47B6rmXW7Rq/p8rHQK0G9NRc0B2McLabjs/TW9Hm6tt86L9S2b/UBaOI/CSLNjqX6mtjhHoAzSzMGIN5McqPo5kmjXbl9ydP6hjTAWt2NKYfpDnchyXOCV+7VwsryzVbSQ13DmlNTR/2fR9X2CWkLnUgz12aAEkRg4zIy6wcumvxoDK5eUZEf0u2WA1nQCCxyVOaWRMevGCT2a8kOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sat, 30 Aug
 2025 06:56:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Sat, 30 Aug 2025
 06:56:43 +0000
Date: Sat, 30 Aug 2025 14:56:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Marcos Del Sol Vives <marcos@orca.pet>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<marcos@orca.pet>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
	<kees@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov
	<snovitoll@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
Message-ID: <202508291620.bcfb3924-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820110437.560107-1-marcos@orca.pet>
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: a288adf3-76f7-4b3a-10c3-08dde792608f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kIFFA4v28w7jQgaPjAx6zTXE0bsIU1vyI8VXz4sIP+EO+kg4ORmHZ24NipFn?=
 =?us-ascii?Q?YoyR1iFg6CQRUNd+twJ+u9ACxuzPX+99PGHpw9sgp0RwNqc+j+mK1Ku6sp5I?=
 =?us-ascii?Q?cGXQGXAxPlkNtPgbwKMsLM4Sm8fPHu7jT25dw5+DX9H1lgAPWn7NdoO5S/fH?=
 =?us-ascii?Q?v/ohgBjKl4nIq34TNNW1lEemcknfxQO2ER/LX7IHREX8B9PAlAaJmoUCmu+Z?=
 =?us-ascii?Q?sgrZ4WDKRE/R8Dcr5iXn/SlRhFPRcrtyTDc7qciekiz1imP+jW3cdCMNyaOr?=
 =?us-ascii?Q?GmOQxb/51TBPYr94BsAFcbCNCneLfkuQMqVWU7LohPUQXdQXH+D0uuR7Mc+w?=
 =?us-ascii?Q?75FLTY529BCCo2TaklF6iIsTkRxQluvgGbfCEaCjg+azLvpbq+PRQLKlf0w0?=
 =?us-ascii?Q?XtB3cUJYWg+yPLu8uPlJiOv3cfl5u3JfbQgQvcsKym+GE1hubZViPYPwmOpO?=
 =?us-ascii?Q?hffBEkYYWLMOntyWP3SSm+tlhHJjp1IElj38GsL6OD+03hHxgCtbJOFXPach?=
 =?us-ascii?Q?SaI4/PPvAP9iFYI7qutaLLQ+6GqWRC+k3XrJT0pVQM5W6sb91zGE60g2acqZ?=
 =?us-ascii?Q?dX0UTcKSaUdZonzjSZ1QYEVc50tJ6sZck3ePn8snGPSiQx1sNpKQCRzpU5vA?=
 =?us-ascii?Q?5AqgcY4dbtx9JERijADdhMpmmaDyq80Y2YsvnSIvwLsIT5PsP0HsRQLuqtLl?=
 =?us-ascii?Q?4/Ak/DItTo4KCMQptdDqIf/1CxVhNlRWcBYh1G8rdKR3JBb2EtGf5R/5viag?=
 =?us-ascii?Q?Kh4eGC74vNI03XuAxAqoFbpNdYT5wuelqVZymfbL3J0zWgtqgafXrUUwCJgh?=
 =?us-ascii?Q?e6DhEXcz4iK8kbr1pssIWUXCkbtfVFfIu73tl9eMB4OqukR6tLN7bEeO6yoi?=
 =?us-ascii?Q?fywZ86iWsTeJ3HbvApI485RyElnhwyh7tSomD9vPuOu+ea/3Dg7h3Z+cKavc?=
 =?us-ascii?Q?rRNnHcaOT6OVyw0H8x22JdBMCJRI0Ceo+rCZuehivyERlZqNKGakI+INx2pT?=
 =?us-ascii?Q?Kg8vWchCjX3LOjJ8sil0cUKK7vLAdoux8ebjTyt1Lt+8RKTA2ifQHaw2Uk+Y?=
 =?us-ascii?Q?+Q2vnD6cwjAtp/A9342z9YqSTNnMfOeotggPtswUnURyH7vYDnqnG5nZeuhb?=
 =?us-ascii?Q?cFxnAz8iTTx9GhHMyXvI+WLfpHG2ujHQlAJXnAX2UmaakT+v6rNz4pPu7fZv?=
 =?us-ascii?Q?FkHHAPCOOGz1S9PtQm9T5r/y1rpuBoka+03/eQUBssijJlvLFm6cNjCpNBHG?=
 =?us-ascii?Q?DtjHqBdajOuC/42Wz4Sc6czjMVr5eHgOvZZHv1IcSmD3gP4q4HEf8QIQOmU1?=
 =?us-ascii?Q?v0SbUeR/XMPLEhi9K6MEuvvGufe6he1ELi1NR5CScPmHCJvzy1+zIoAlo/Qu?=
 =?us-ascii?Q?SwaPc1M2i8pOk1sK4zsCOPf9dSMR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rox4kFd4ISLtx0k9da4mAcKEpT80FP58D7Aw4yWawfZEmTF4UJ3RLfOgP4/o?=
 =?us-ascii?Q?au/E/8CkmeIsL8IMWyv6qZfEyie+8zEk0oH93XLgn0NWHEICMmW2YlL2sUA1?=
 =?us-ascii?Q?Ce5vQdrruLnzq2vKzSZIVWBcJED5qJzs84xfBj3QQl6BBTjncrZgBlNbhrVZ?=
 =?us-ascii?Q?NG4ArriafMYEb9rltnwkbWuCRrL8vcDUgC6wM9kpNyw15H+4wkn8+OkBYISy?=
 =?us-ascii?Q?w9ePRpyYqBwoaGVqUenVYUJe1KRKFpZ14U5DlggHEW9bV6sfWqycqMEghxcz?=
 =?us-ascii?Q?xWYav5HDjovOleEcAbEQ/CAjJmJTealaqbbBXB1QFE7/vwHAK9nC4M/O05jH?=
 =?us-ascii?Q?ydfTeoxLMgLAfBbcZvoenNTIAus2KNvnWUpRrBdELW+MypPW7TY4g6XTLbmi?=
 =?us-ascii?Q?pBcL0YtJphOaGLxAn1/RNQ/3nl6unsmpwaNQhJ7soMc173d0BpI+0YmbnWLc?=
 =?us-ascii?Q?Z1QEtGWMAenCicLBUshmN0HWQKHslW74ajb0rXucpiFBQS/KfGwqL84YYGbC?=
 =?us-ascii?Q?XZT76iUK3p7TATXcj9E0jP+/iCgphiuTjPSYczviCQKFovTK1sXAM6LF2AvE?=
 =?us-ascii?Q?FVRIxpB4peMkZmEFQtvC1uDzcPuYMld3NlxG7KHrGLiCegBZh4qcDyDNElEj?=
 =?us-ascii?Q?JbccETW0GUfXCN02QIe42meRxm+Ee/BglqsOtiYy11pVp4oSKZFwQXmajxqa?=
 =?us-ascii?Q?bzK+CNN+9XRaIgWO2e4lvxnUn7zzLl8VsqhLrUeoiiCDK8/7vioMstWky88e?=
 =?us-ascii?Q?8e4lGhj+KYCh9l51x9wG9Rp1fPrNgkdo1i5OSbI/39lx7npO2T+bhgu7y4US?=
 =?us-ascii?Q?XCmzvjyZ2a1r5Jo9VKwjvaBwacytHR96dJ4Hb+Wg4n85ngtujzXA72ATkE2j?=
 =?us-ascii?Q?jPGWpeeWVd2q9Ppxx+lVuzPIt0cImsbTrt1PgeB3JzJHmOy9hGK1Y9jdR1jL?=
 =?us-ascii?Q?d25PUN/K4s97VplT1FY6i4kirCQwOP0B15vyB07M42MkBOrly8PJpzeea/dZ?=
 =?us-ascii?Q?7GO9FTAOBgDaW7rrxSmHiL7qXjNtS43J4YSj35omOCekwOdX3+kgh4JZgZXJ?=
 =?us-ascii?Q?p+50Z0BbFz6xpt8KqqJeNedBOuwhFdA0qGRjIoBtRoAjXOU5ARAs1H062dng?=
 =?us-ascii?Q?8ToT9XX4lb2sU68LMBHlssm7To81V7/0rT/Psvlwk75fWF/LAe7V7dySQgSc?=
 =?us-ascii?Q?gLex30CA4SU1+p9AoQ4xnzOGDBtffNS8+MSP4Pbd9WG+V656jMbzgUaZm/fu?=
 =?us-ascii?Q?zx9cVhezwDM1fhCbuF6jeYv81fBILfC7KDyq6wEnSzT76VNJ5rADhIoRffFs?=
 =?us-ascii?Q?20Umck2pFH79M0+uZ3gtwHLHFx9XGf3a2rKYtKueQMA/nmwkvl/vhJ8hmrbn?=
 =?us-ascii?Q?58cXOtD1CkdmhEHL4GbwsuFdUzEed0iAUCI5wQUD44Pe3nI/JBoAwn77dO2/?=
 =?us-ascii?Q?PcaIgcjruMy15upoNs4hAhhwgSSp4eLL0Fs5lEBMhTsez9FaiD6h+Hs8etuT?=
 =?us-ascii?Q?L8+oxJg7GMCdNwuXsGZCQmUI1DnBbr3i1LhnK5dPqVIJDAVeu4raEJ0IcSjf?=
 =?us-ascii?Q?+SMjjsRALbOgfvU5Xw32il5lIVJMdY8ZbSOKi40wLWNCdc4+SbCVrI1KHcKz?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a288adf3-76f7-4b3a-10c3-08dde792608f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 06:56:42.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjSaJUwAMI1eL/6VRYlgFt11aeC5gQgRgLaHoqlI8EOO9EyPXIyQdsw6fHrb2lGf0G0NNd7oFStS8zyUdKFRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/uaccess.h" on:

commit: 09c737e0df5a3dbf40e8da1d6e168bd6d7fd19f0 ("[PATCH v2] x86: add hintable NOPs emulation")
url: https://github.com/intel-lab-lkp/linux/commits/Marcos-Del-Sol-Vives/x86-add-hintable-NOPs-emulation/20250820-190618
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 894af4a1cde61c3401f237184fb770f72ff12df8
patch link: https://lore.kernel.org/all/20250820110437.560107-1-marcos@orca.pet/
patch subject: [PATCH v2] x86: add hintable NOPs emulation

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s



config: i386-randconfig-004-20250827
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508291620.bcfb3924-lkp@intel.com


[   24.176151][ T2696] BUG: sleeping function called from invalid context at include/linux/uaccess.h:162
[   24.176703][ T2696] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2696, name: trinity-c4
[   24.177213][ T2696] preempt_count: 0, expected: 0
[   24.177492][ T2696] no locks held by trinity-c4/2696.
[   24.177788][ T2696] irq event stamp: 335112
[ 24.178030][ T2696] hardirqs last enabled at (335111): irqentry_exit (kernel/entry/common.c:210) 
[ 24.178521][ T2696] hardirqs last disabled at (335112): irqentry_enter (kernel/entry/common.c:?) 
[ 24.179004][ T2696] softirqs last enabled at (332212): __do_softirq (kernel/softirq.c:614) 
[ 24.179473][ T2696] softirqs last disabled at (332207): __do_softirq (kernel/softirq.c:614) 
[   24.179948][ T2696] CPU: 1 UID: 65534 PID: 2696 Comm: trinity-c4 Tainted: G                T   6.17.0-rc2-00017-g09c737e0df5a #1 VOLUNTARY
[   24.179952][ T2696] Tainted: [T]=RANDSTRUCT
[   24.179954][ T2696] Call Trace:
[ 24.179956][ T2696] __dump_stack (lib/dump_stack.c:95) 
[ 24.179961][ T2696] dump_stack_lvl (lib/dump_stack.c:123) 
[ 24.179963][ T2696] ? nbcon_get_cpu_emergency_nesting (kernel/printk/nbcon.c:1375) 
[ 24.179967][ T2696] dump_stack (lib/dump_stack.c:129) 
[ 24.179969][ T2696] __might_resched (kernel/sched/core.c:8958) 
[ 24.179976][ T2696] __might_sleep (kernel/sched/core.c:8887) 
[ 24.179979][ T2696] __might_fault (mm/memory.c:6957) 
[ 24.179983][ T2696] _copy_from_user (include/linux/uaccess.h:?) 
[ 24.179991][ T2696] insn_fetch_from_user (include/linux/uaccess.h:212 arch/x86/lib/insn-eval.c:1516) 
[ 24.179995][ T2696] handle_invalid_op (arch/x86/kernel/traps.c:308) 
[ 24.180010][ T2696] ? exc_overflow (arch/x86/kernel/traps.c:417) 
[ 24.180012][ T2696] exc_invalid_op (arch/x86/kernel/traps.c:432) 
[ 24.180014][ T2696] handle_exception (arch/x86/entry/entry_32.S:1055) 
[   24.180017][ T2696] EIP: 0x434433
[ 24.180025][ T2696] Code: d8 ba 3b ab 45 74 a5 5b 8a ef a2 59 f6 b5 0c b9 82 33 c3 f1 23 2e da 6f 60 f0 65 13 13 44 c5 b7 3a 06 f6 a2 3c 53 db 3b 28 30 <f0> ce 36 c2 77 c0 2b 9b fd 83 f2 04 89 08 45 5d 8b 0b c3 d0 8a 38
All code
========
   0:	d8 ba 3b ab 45 74    	fdivrs 0x7445ab3b(%rdx)
   6:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   7:	5b                   	pop    %rbx
   8:	8a ef                	mov    %bh,%ch
   a:	a2 59 f6 b5 0c b9 82 	movabs %al,0xc33382b90cb5f659
  11:	33 c3 
  13:	f1                   	int1
  14:	23 2e                	and    (%rsi),%ebp
  16:	da 6f 60             	fisubrl 0x60(%rdi)
  19:	f0 65 13 13          	lock adc %gs:(%rbx),%edx
  1d:	44 c5 b7 3a          	(bad)
  21:	06                   	(bad)
  22:	f6 a2 3c 53 db 3b    	mulb   0x3bdb533c(%rdx)
  28:	28 30                	sub    %dh,(%rax)
  2a:*	f0 ce                	lock (bad)		<-- trapping instruction
  2c:	36 c2 77 c0          	ss ret $0xc077
  30:	2b 9b fd 83 f2 04    	sub    0x4f283fd(%rbx),%ebx
  36:	89 08                	mov    %ecx,(%rax)
  38:	45 5d                	rex.RB pop %r13
  3a:	8b 0b                	mov    (%rbx),%ecx
  3c:	c3                   	ret
  3d:	d0                   	.byte 0xd0
  3e:	8a 38                	mov    (%rax),%bh

Code starting with the faulting instruction
===========================================
   0:	f0 ce                	lock (bad)
   2:	36 c2 77 c0          	ss ret $0xc077
   6:	2b 9b fd 83 f2 04    	sub    0x4f283fd(%rbx),%ebx
   c:	89 08                	mov    %ecx,(%rax)
   e:	45 5d                	rex.RB pop %r13
  10:	8b 0b                	mov    (%rbx),%ecx
  12:	c3                   	ret
  13:	d0                   	.byte 0xd0
  14:	8a 38                	mov    (%rax),%bh
[   24.180028][ T2696] EAX: 00400000 EBX: 00465000 ECX: 00058000 EDX: 00100000
[   24.180030][ T2696] ESI: b72df000 EDI: b7f53234 EBP: b72df030 ESP: bfd7948c
[   24.180031][ T2696] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
[ 24.180036][ T2696] ? exc_overflow (arch/x86/kernel/traps.c:417) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250829/202508291620.bcfb3924-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


