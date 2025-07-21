Return-Path: <linux-kernel+bounces-739981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B3B0CE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FFB17D36E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D8239E9D;
	Mon, 21 Jul 2025 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWVuXiVn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EB1B87F2;
	Mon, 21 Jul 2025 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140576; cv=fail; b=UdKROxvjvyvbiLijWLVIBjeUxjJ3iS2l0LbYMrFLcG95TmICQmfKCZwKIoV9czcXHZTBrHDfdJm8eNHju/eTd0kARs7cPogSqRDQZwxa7w+4ZJCgYvEu9bLLV9K1azcO/W9J859f8suKwZc+ajn8mkYecQcjYU5SADghG2puY5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140576; c=relaxed/simple;
	bh=vt6w5hgCeHAD1Wwgm8KPjuhGmzoHe+vK1GWimsE51VM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wa/tLPEqQB1YoXfDjSoDen6EnFqV1aLEMttTkZ7bOSsGNesxB0FlknuSuk3CiCm5hWXe1xsfaYe6X3y2CFfmfe1TBt0HUI53HGi9s3ZQ7QBDcA0paPT+sTyJ2D6JZuzd8X/j59lErE81ZaEMHydUhKzsPSFWQnJul6AOiObE2Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWVuXiVn; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140575; x=1784676575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vt6w5hgCeHAD1Wwgm8KPjuhGmzoHe+vK1GWimsE51VM=;
  b=FWVuXiVnnzXDWtnU70P/XdTIgqjTFeQ32dn5CdmiOujyChxFnvD63GLS
   PqzVbe8Zd22/+dJGUDT0NPukg9E4YvEdkFPYRQY/p7CooCfEPbvfIF9z0
   ClsXycxf1bH7k7i4bgqmfyf7ez0JoVFNpmhOmJaMeZKmQTYyWr+3j1PqI
   4P/T6ckufa5uPkF2g6itWMvPJgeClIdSD+DFhUlGHB2Ce3zGch97csjec
   Qhypw80H/V+x1i9bb5aBzRWhpSWeCvmce7XWGXeW5/EDQ8zC09XWpNMSR
   zJedeGqyDQ9X1s4FwrHQgxfC0pVWcr0VXpU3v9cWPFSqraNxBSBDfPerB
   w==;
X-CSE-ConnectionGUID: dqyLIbFXQOWg41CA6cCNWw==
X-CSE-MsgGUID: S9TW4HVoT6OhWJY6Op9i9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59033328"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="59033328"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:29:35 -0700
X-CSE-ConnectionGUID: qQH101boS9etaLtl3ss+qw==
X-CSE-MsgGUID: NMgUs7fJQOyTl2hXkSgZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="164636191"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:29:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:29:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:29:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAL1UxMBE8xhZ92IH5CuIzmKkxUa2hlVF3IUOsix7r7vJq9g6WIxygz76rlYjT2PjA3rWjyZhltqvhYFfDgShZjtQGY/30/zqMB8XkzdALJYNjplMZ7N2wTz4XBdYZEXX7MnMGjBqQqNVx+XN7yw5QxUkwrNmBJk/qR8Eslp45ilErely34K52zLU1Hvc4mvNLvxZczdYyEdvwmYGmatcqJAY1qB2Vp74fx/9qn3sg4hoGWBCN5fsQ7jyrcFtGrIfPxNEV6Oo+P5s9TzWc5ZGnRHSvGnFdMbWiyIq1aaR+LMDZBhaGNFzfcCQn3pRzWVlos4X+7n+1Bd7E7Ho7aAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up1QuF9F8zTJCJ/1qDokAc1Hk8sO8IwkJHzpEA3PeGw=;
 b=PUMNlLtHO7QlA+RhkW4vPwm9xvHopa7zKRfdu8EP79pEaHeH5k7JxCGUs3/O8nbBffWucs13o9svLAc3VFKPedFZoMtS5q+Y6lPreiL9RQvnBFI3+btteXsQE0rMqJ3VJP2FUvzxSxcSsmY7FzNuxTe7YUwrGHitdybjQ85OMGvatb89D8iiOlnwVpQ/pO08UMeVjT4jyhzXeIw709xe9dYAJTif2kLJS/a32UEsOUcZQ+p+9SwpCwBBxBnfhrOcgxNzljfKl02Kv+0gstro9rFY9CsMAj41LGMUHX6OnmVg8tvf4BFsxZbZq7LtqxKibxHHCU4QnVfl2abfRKH1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:29:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:29:31 +0000
Message-ID: <d66b3b66-82fb-49a9-930f-b933024c7fe1@intel.com>
Date: Mon, 21 Jul 2025 16:29:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] x86,fs/resctrl: Detect io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <998f42d5c92cce9d7d83bcd54d25761242839b4a.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <998f42d5c92cce9d7d83bcd54d25761242839b4a.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0336.namprd04.prod.outlook.com
 (2603:10b6:303:8a::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 517801d5-b97d-4d45-e2cc-08ddc8ae718d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjlYYW1TNDdGV3lBNys4Z0ZCMExZYWRnQUJxN1pMZXVQSW94M1RJU3ZINENm?=
 =?utf-8?B?ZHVMV1dRVXBCMElpNEZlbDJHZ3I0YmdzbkRKSUtCM0ZkaUIrQjVqWENCUlg5?=
 =?utf-8?B?bGlXcHdvWkx4UGJLRDZISzU0UXNsQ2FRbUVybmN2VTlZQnBFbHU0aGF2Vi9G?=
 =?utf-8?B?enVFNDRTYXd2Q3dyZjhjTmVBOXFjcUNBVTgyYkNwNnBwVG1oTDQrakt4cTJp?=
 =?utf-8?B?a1Y5RU56VHBOck1HYW01STV3L2cyWmtReVFnR0pVbW9iTm1FVTBqOCs5cmg1?=
 =?utf-8?B?NGkrQVFVNTdRQldDbG15QTkvYXljcGRJU1F2YytBaWtIYjk0aDVVWk1MN1k5?=
 =?utf-8?B?bE13MmJoS0p5RFdTa1NSQkZEblRMUURkVGJKOURuMmg2LytoMXpZZWI1eDlV?=
 =?utf-8?B?d0J1bk5weGl1UytUb0MxeFBWOVhKL0ZmUlhZbmhhTEZ5WHJuTjhJRkxSQmdi?=
 =?utf-8?B?ZkttY3JFVXc5N2RXQjcvY3RqTjAxMWE4bmFVaTlGelQrWHV4UWVsQjFpSGNV?=
 =?utf-8?B?elF0SGZCcFdFeHZta2lBZElxcG5VanM1eFovTzlEcjRIdHp5bC93a1hOWmI1?=
 =?utf-8?B?WjQ3cEY4ZWNzRWs2RDBkSE9JSHkrQURlNy83NUJUa3RqaWw1dHFicmNHSTRv?=
 =?utf-8?B?WFhWcnhzQVlJRUE4KzluOUt2T1ZYM1JPYXJiNGRVZ01TR0V2SXozME1xSmJW?=
 =?utf-8?B?aUxuL0xhV3I2UElUNjR1MEpXUG5rMGgxdHdJTENXdlM2cDhhNk1FdE1VS3Nz?=
 =?utf-8?B?N3JMRmx0QkFmazhmbXpzNXNNMnFjcVRvaEJvTHRwWFhuSnF5ZnBWenQ5ZFFx?=
 =?utf-8?B?ZEVyc3lZMnBuV2Q5ZmsyS2RmUFZ6VnJtYUkyVUpKck9kdytQaUgwVVZtV2Fp?=
 =?utf-8?B?SHRHQWhWSkVaaWUva015WnNCSjNzK0lTc2RqV2M1RmJJYzNYWWE5cDJuSi9B?=
 =?utf-8?B?TnR3NmxtUDJaSDhOREhac2FXY3JRVVJDUFVyTnZWcVBUVFBFYmRsVzh3Nmth?=
 =?utf-8?B?VnRMbkZQVHJLbnZNay9sQzNkTFNnM3JDQ1Iwcmo0NVpGV2hhbi9aTi9uakh2?=
 =?utf-8?B?WEVqZ3ZnUWJ6MTdrSkpGTTJjd0w5b205MlUrcGx6Z2lrZUtqamsyWnJURkR4?=
 =?utf-8?B?VEoxZG9UWk42UjYvbm9pQ3Z2QVA1Zzd1TEs0anE5VXo3UHJvbW5uL2VTYVl6?=
 =?utf-8?B?OEsxZDd6dDlVRUVqM21FeE51MkxnNWJiU2p4V1V2RGltU0VTRzg2THVlZVNi?=
 =?utf-8?B?Nzcvb0FCczdyMEJvU2RJSDRjZW44MGFuRXg4d2pwZHo5VllGa1I3MDBVeWFq?=
 =?utf-8?B?YjlxWU5sYStSVGhNMVRFMUZFNmlKZk95SnBmQitsZitpNmZqMk5nWEpjazlr?=
 =?utf-8?B?b1VDMXllckpTWXFDc3hkczFZY0JoeHZsajVIbmFwOGxHUzJNeEdnZldIVWJu?=
 =?utf-8?B?bHV4U09FWlZhdXlwWmFiZ09WeXBIanQyUDl1dWhGa09uUndnMUtBOXdYRUNa?=
 =?utf-8?B?c1ZyamsvUk1FUDV3eEZhTFZoeVFuYVFORnZHTlIxa3NGQW1ZbnhRd3Q1eEdQ?=
 =?utf-8?B?eSt6UzBvcEZZOVN0NWtVSDdZS3Q3SUp3QjVibDAvSmNDRWpWdlJlcS9UUDBY?=
 =?utf-8?B?eVNUUVp3SFRuYzBHbFhlL0RvVTErNk5ET1BSRlZoVW4xYW5qandQVnZidjRr?=
 =?utf-8?B?SUpYWFYwd09lRFZzMXNFc2pMMitHR0N5Y0JtSVg5aFBlUHBaN3VZeGMxNjZR?=
 =?utf-8?B?ZFQvRytXdkhpWWlHa1c1ajE2U3dSRXh6NmN2MExQL0toZ0Q5dHREWEZZYmlL?=
 =?utf-8?B?eTN6dEI1Y1l2OWtGOU5NU04zR09sYzBDa1ZjUnRXRk4wL01ia1VYNjM2VCtE?=
 =?utf-8?B?cTNwditMQ1d1bzBhUmNZOFJ5UTA5bTFIeUhhVXllUUNIYVRPOEsvRk9MZHpU?=
 =?utf-8?Q?fqksnjLxA/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODEvTElmQU9kSS84YUZSMHFOb2pnTyttbDB6N1pSeE9HL1RLMmpnTkdXUCto?=
 =?utf-8?B?YXg0cGxXMGFIQjVlNWtFa3A5T1BhRkEyRmZldUs1MXMxRDFsNVgwNjgwOCtS?=
 =?utf-8?B?aGN5Y1NHQk95UTE0d280dUMxdEZtQTUxaVJZbFh2UElIbDEvZjJ6Mk9TWmw5?=
 =?utf-8?B?TzRaaTUyMVd6Z0dESjdWc0FMaE15K0pHODJWd3lLZVVjWjhhMUhCZTJFU1dW?=
 =?utf-8?B?aTM1Z29DOWVxSHJ2bFhmMGZYVVZXYmN1N1VuakNQNVNZMmVieVFhM3kxQ2Rl?=
 =?utf-8?B?NEdaQTl0Y1BwOTBXbUNzVWZSQVcrNTRBcjFaQWZBQmxxUCs4eFBNK3RBckV6?=
 =?utf-8?B?ZTZ2U2cvS0FuZW1mcFNnVTVUTmdmQkc0cDNSZVRNL2V0SEI0V3NNL0orbzZi?=
 =?utf-8?B?dHdEZUdZMHJuaU9ubDJBZ1RkQmJHMVcrR1lScUx0S0pxRWVHUTIzOUdCYks0?=
 =?utf-8?B?am54UHBVVTR0SlllYityKzgwVUdjTE9Sczl5NHdRSmYwUUs4VG9CUnEzWG5O?=
 =?utf-8?B?QVlHSm9PZkhVY3YxOGZycGd5LzN1eWtiVkt6SVVjMXNzOWdxaXdjK2hnUnJY?=
 =?utf-8?B?WDZCQ2ljenhlNytqcS9wRzFhaUI3R2NORHExd3M2dDhsUm15Y002MjFJZGJM?=
 =?utf-8?B?eGpEa0I3WlFEM2NkUnl0c1E0dDRFQmViV29VWFNUV0MyTCs2WW5CNTdMMWsw?=
 =?utf-8?B?THdTdHMvWGdEbHN0Vit4Mno3QVcvR25qRkhLQ1F1SkJHVFphOTV4MXhZQzJ0?=
 =?utf-8?B?ZjdvNFVuYW81cm9HSEMways1Y3pOU21GQ05obGhZdE1zOE5LRWVER1VEWE9z?=
 =?utf-8?B?RkwrcUx5Z2RMNVBkTzJBWnJZbVBHeUlYTC9zdVV1WFg5TVYyanpDQkVrOGVh?=
 =?utf-8?B?Wm4rcFhwNzA3ZEpHczFySnJuV0IvbFArTTJ6bkJBaVZEejN5eHByMjc4VzZZ?=
 =?utf-8?B?bTlpSHFZdGN2RW53cDZkQ29pTUZ6UTRzZ1RGVFJETlBCYVhKQkk1V3NCVy80?=
 =?utf-8?B?ai9WblZ3Y1ROTUJTa2kxRUVpL3BrN0hVOXg1MldLQU81dXJ3cjc3aTQ0U2wx?=
 =?utf-8?B?ZWdGWk5HVTBxbHpFL2xxSGRDdDRVR3FPWHJkY3ZpNlpDeTJTMmttaU1XSS9s?=
 =?utf-8?B?amNYNzZQcVNVVGpPaFdMSVRKclNseUNjcXc1VGxYRnpURGo3RWhFNm5sUDd2?=
 =?utf-8?B?UlRXTDVHSTJWVTdQM1BNWU9YL1FJQWh1cjQ2bDFRclFUd3RSUHhBd0sxNHhQ?=
 =?utf-8?B?WGh1WTZVZkFlM2c1S29jTkxyY3ZLbFFkS2ViVHVReXphaWhaT0pxQ2tNNU1x?=
 =?utf-8?B?K29pNCtsa3NONElOTmxUVmcyS0t5ZGo3WlVibExNNTZMK1dMOU1zQ0czcGpa?=
 =?utf-8?B?ajZwT3lCeEoxZEdOMW50UTJ5V20wR2grYTlIU2lHWFlRM2I2dFdoeC9Campj?=
 =?utf-8?B?UWpEdUtBSVNzYVA0dXJqQ2JVd1pTTDZuVUxLdnc0b1hCbFV0OGJoREQ3L0FT?=
 =?utf-8?B?b0ZIOTM4aWNUWGxQTUdtWk9SWnpUaVd4YktDNXFCZWt0RWNVcU5vZ2hrUXVv?=
 =?utf-8?B?eXN1YmhLOEdoZVFWNlBDc09xNWxBL2NYRzU3c2tkTXpwS2lWQ0kvU3p0Wk5q?=
 =?utf-8?B?YUg4ZTRXRWlLUmJJZTlFditDbWVkMSsvNmNBYVhTazhSMS9STnVvSHBnMEJv?=
 =?utf-8?B?Y3JzWE1hc0xORTlTamo2V3hUdDN0ZUFUb0IyUFJxajNyQjlGMVlqa3B5by9n?=
 =?utf-8?B?WitNZXkyTXNWOTJVc1hrUWFIZDNhcHEwcXRhZFlSVW5RZy83dlQ1cGhWdjBW?=
 =?utf-8?B?NmtlNVFvUWdKR2JVdXZTNW54QmhocHluN0pTNzRxekdzYk5hMXlrNjE2aTVz?=
 =?utf-8?B?U3M4OUoyc3VkaHdHOHQ5WFhYenBoeTAxWTltNHhUMGM1MVBKSVhhUWFGaUZv?=
 =?utf-8?B?bitsV3NYcUd5YTE5Qi8reDFyekpzMHM1V2ZRQTE0cGVNbEJPdkpIVjFkSkh1?=
 =?utf-8?B?blVXVHk2aWhqUlFLbmtEaHJuRTY4K1dlOTdlaWduYy9aMXljRXQrZFRQdHhl?=
 =?utf-8?B?UGgvM3FpaGtlZ2xqbFNPS1FyQ0VVZmtIdW9UOVZuUnhEQ3FYZHRvdytwYXVB?=
 =?utf-8?B?MTI4c1BNVE92Wm5SVHBQbkdQWkUrRWh5ZnN6OElNa0gvZy9TUG9lRC9IakdD?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 517801d5-b97d-4d45-e2cc-08ddc8ae718d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:29:31.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gptPWyPlRxjSn0gEpRWdqCjKR60neSo1jMP5zqOeDxOl5ryYrJ1u1GWqS6l67Ps3s1JNRWKHhmGkWIte+IEw9tIP63enijwmqZPFANEv7yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache. It can reduce the
> demands on DRAM bandwidth and reduces latency to the processor consuming
> the I/O data.
> 
> Introduce cache resource property "io_alloc_capable" that an architecture
> can set if a portion of the cache can be allocated for I/O traffic.
> 
> Set this property on x86 systems that support SDCIAE (L3 Smart Data Cache
> Injection Allocation Enforcement). This property is set only for the L3
> cache resource on systems that support SDCIAE.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


