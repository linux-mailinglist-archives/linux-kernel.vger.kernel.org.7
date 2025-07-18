Return-Path: <linux-kernel+bounces-736235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76FCB09A52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4990B7B8C10
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6231D63D8;
	Fri, 18 Jul 2025 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiJSCMj9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438171C861E;
	Fri, 18 Jul 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810876; cv=fail; b=H8bTpBrnyI/GlMuATh869BC15ZmKsqbsVYYEYaTLRLeq9uSp/gOxWaBM4iIHES01/1Xe6awe9U77RDSYf54fxDcJkSA5NkmoQucigfVZVrnUVGy9qSrNJ6OBMhyqr2nE127l/hQVlhkg+VQzpToSZyIJAK02sB4aGH/JqD/soh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810876; c=relaxed/simple;
	bh=eiY18m3zfCpQSipALMJ43ilmGc0ZW7uBJy+HgG7/m3o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bcWN/A6x0jqrVVjoCdeRdu3viWpyWOpV1JmJ0sPt6dfbz3DgbX0WnntBl4dteObur9gyOI3GuChq+tY2IlEeGu+x6ZsTWbya0ZVTs8Z/zIx7VJ8wumA+fqfaj/DLv/H/593NFOgTICLITdr2y6efzW9hwIYoPTe1psKLBANgpsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiJSCMj9; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810875; x=1784346875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eiY18m3zfCpQSipALMJ43ilmGc0ZW7uBJy+HgG7/m3o=;
  b=UiJSCMj9swbnrU0ijOqWNHNPU+9cbEj180xO0VwYG6/8gl847aLfFMKc
   mjdO8FTwjzSC/B94Kt38MYVt3rFlM473taISmjcLAETFLyfG7pmAjai/+
   +erPJBvdJx7Z/3HE/2O4QSi1pIexsBuvBsd29AHdcXlsqhRLLs0j19H3i
   I3iCaEc4X2DnhKviCs4bvE7H3j4OnBaESqYhjmAEU+xv5pW3NSjCDIGRF
   rX6+sgEwBZlrSKdkaRRu3dOuJfZRTj09GhTExS3mIm3lBpwTauX17lzD4
   VOdy9MbAJttfWXgsDlp2umO23Oopbx3E4awyVbnoK2vTPwz6339mXw0Cb
   w==;
X-CSE-ConnectionGUID: UoATKkX/QweVv5IHE++WAA==
X-CSE-MsgGUID: OlOKFXLuRHy1wtNzC665pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55040626"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55040626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:54:26 -0700
X-CSE-ConnectionGUID: eK385gTpQsmj061oDnuGlg==
X-CSE-MsgGUID: ZcAZRFKkTGm0Q8d5O7pyzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188941004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:54:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:54:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:54:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpVjkAcgQHvPQFCRXiIhZUcqkTCzyjKkxogVxwPgAxgKg1uihzUXAAVlVxyBqMg+qshAxzSyJe7T5bpHOaZTSArjxfGgh+w6lJopGgU7Rvy0N8idPvUhn/cK5VUttKxzkxq3Wd9AQtkZ/0dvyZkyRyohAg0EGnTyJbgA5LSTu+Y5JpQ4iyZhA6/k5qqy/aqOZ6cXw3yBegO0GDvEXuH67kLal2YCSbQtMxIaaiPKFisQ6O+ucYUCoiG/dX0YaM6ZXkRy3ARCs0o8UvYEWlRyxqKSaVlnhC7rLimRbrPuZ1syR1y+NtOBUolULorbC8g4MBuLUxwfR8MnKNrvzjUoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KbKpralAGzsp6S3b7Qwl9XWyieAXj9Sjh1y9Wxx/tw=;
 b=Wvhd+KXemQmAS1AnnumvgKhz9tgMQwVCWk9qDnR3DnbaUd2UWxf+iyNSip0RJUNgTOO/KaqWKZXbUdq4bO8RVmA5nprjFnKB45x9hZznw7vJTtFVgXOMQc2LV6VyZBvE8zHSWlE0yVEfDyp9lJKuQXulZKKwFNuh3PGTFTOCfrRFIf3rikyZfb+/RyBP8SGL11RG1rK9CBj24ddn+gdAAJiC91aUKkFDCfAHxgtJUB4FeiCEzonw0aJd5PLEdl2Ed5CcAeTQC6/QnyyQTw/0cKT0jfZTNr7W/tdaz5qE7UAEQldz/+EOKzBONmVKrWlVq63cJDOZ1LeygIW1HZVisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:53:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:53:52 +0000
Message-ID: <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
Date: Thu, 17 Jul 2025 20:53:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events
 in mbm_event mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: e944d255-3c40-488d-091f-08ddc5aeb5cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czBPaUViZnA5Vjc1ZGNTcEtPdFF5eTZxSVAwbzdyTmlXYnQ0alZieS90VnJy?=
 =?utf-8?B?SlBjSUhqMGtzYzZiSTllSWZXdXkxUjNuMWVWZXIyVElLMmMwNzNKc09JbE5Y?=
 =?utf-8?B?blRIbDFlZEsvOWkvWCt4dGcrd2ZSUk5QQ2Y2aWlTYzJOMGI3QitRSks0dThU?=
 =?utf-8?B?NFF0K2ZoU0VHaVNlMWt5VEQwWTBkWDNLZVFhdGhyOHkzN2todkdXdE1PaXFp?=
 =?utf-8?B?RGtRbERtRGFSWm5MSWJ1Y0I5K1hFejZQSHFkcHY3RXd4TXpjR0tJNE9yWC95?=
 =?utf-8?B?aDNpWGtKeUY3KysxSEdERGtydnhVdFlGUDVoVldHOXpaU1RSaXdqd0pacUtP?=
 =?utf-8?B?Qmw2aU9hZDRnaThPbVMvOGlsYlBVd3NJclR3RVJKK3RKTW1EclorWkd2MzdW?=
 =?utf-8?B?N3cyaFJ5cncyS2pIQVlBRmV4N2w3QnZYY2k4Z016N3hGZGgwSHo5L1p4T3Nx?=
 =?utf-8?B?cHhRSkxSZFF1Ni9uMUR6YjNBL1lBU0pNNlBRMitaUkhUNkVydWl1RGh6TVpk?=
 =?utf-8?B?bEJ5L29rVkdacEc5a0ZEelZiYm5TR2VSWHpjMEplUEVkL2w5MHo3RXluZkMv?=
 =?utf-8?B?UzVESUdJZFkrbXV3enhwdnlRdHg0RlgvUXdMaDBMODM5VTczYW5Xekh6bTRU?=
 =?utf-8?B?YWlQekpyZEZJQXZBMjN6NFcrKzNlVnZOa3FiYmNZdXdmbVFKL2tSSUNkOHhL?=
 =?utf-8?B?U0wzQ2YxYXorOHBhQ2UwcE5lV2dxeEZ1L3Vpa2gzakhYNUtCdjh0VjRwVE9Y?=
 =?utf-8?B?cXVFOVNTb3JnL0thZTlETnpqcUlGUlpPT1l1TFlIVVVjVkRMM0JIQ1JDTnph?=
 =?utf-8?B?c0JpTEFrd0tPYWk2dVpadk1QUHJiaG1jU0dsS2FSbk8zOWthbDUreitlb1lF?=
 =?utf-8?B?QS9WZSs4K0JRU3Q1ZkxtZVBpOS8ydDA0cUhTTzZuM1lISGdNeHVBQVY5RWRt?=
 =?utf-8?B?NUQ3eUZ4QVh6WjVCQnl0SmY4emdDVlREdTkzS1JITlhwc0NlZi9BWjRrb0xa?=
 =?utf-8?B?SHQzZlRIcGVQOFJPYytHeTlLRWpOd21ScFlpeG5IV3NJYU1OMURIS3c5SVA0?=
 =?utf-8?B?MXpQNzJ1aDVZQW5JYVRhWGdNV2dXUUNMZ0JOc3pMWkZzYzRjMHdlUC9rc1V0?=
 =?utf-8?B?c3Rwc0NqTkxYczcrSEZLVkhBbjJGNnZyaVdmU3VxRytaMHF2akl4NVNHaFFa?=
 =?utf-8?B?K1hPMWpVUnRoK2xrM2xJeVhqQVdsVzZWYjZjcEFNRnV6TTFzVVlUdlZ2RTNv?=
 =?utf-8?B?djluTDNHRWR2RWI5RU45YlBwcFhNa2srZGtWaVprYmJOYUk4SVptb3p0Mzht?=
 =?utf-8?B?ejN5a3RjVkhRd1k5eTJYdmFOU1NHYlRwMU5pMnU5cmpiYURBaDJMNGRYWTdF?=
 =?utf-8?B?SHcxRW1uVmdvRDZIcU1vZTI1OWw1azFqWnRrKzZXM2FVWDFNOFlpd3dkZWNx?=
 =?utf-8?B?VHJLS3RjVk44WHAvR2Z6SW0xMklxZkxhRzNOdXoveUN2WWtWZjdqbEpERTlx?=
 =?utf-8?B?QmI2bjlJcEdURjZUQVdFV205MVpaekJYRlYxV2l0aWt4SlE0U0FYZGtIaEd4?=
 =?utf-8?B?dXZIZkJna0l2a245K0xRK2N0OHZJU1lMY2E2WlZpVFFPc1BoUGFxY0ZzL0hP?=
 =?utf-8?B?Umxkc0lma2diaVQ4Rjk5eTlhSlFWUTZpOEVDWEhhVENzRVhkS01aY0gwNzhk?=
 =?utf-8?B?WmVpaFhxSHBtSmc2WkdGMzl6RDFBTGg4ejVPOEY0TEZ3eklaY2U3WjJLSDIy?=
 =?utf-8?B?d0ZDZEI5OXlFQmMrYmloR1NEa1Z5dTZWcUVFYU1QMHRRMWlBaTBHYmdwTUFX?=
 =?utf-8?B?cGV0MytrZjVFN3gwSGVtK0RTaTZqUE5aREJ6RmJETEpTaU8wa2YxN2k3ZnlI?=
 =?utf-8?B?K0ZiM3FudStObE1aeXpCOE0vMld1WGkwM0gra092K0tETmhKSDN5a25TUEMz?=
 =?utf-8?Q?rrMqkfBN7Qo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xZZGNESTI2VjUrUjJUMHYyWjlieURHcjFkcDFPTFNiS3hrZFBNejE5VFpV?=
 =?utf-8?B?clEra2ZPb09SeUtSMXdtSm0rdUlweGhDeVNBQXB5bXZRdUhEcGU3QzVqTmFy?=
 =?utf-8?B?amQzaW01Qi9YVld4Wm8wd05oSERRWXNWRWFlSHhETWljQjVEWHQ1ajBHTm0x?=
 =?utf-8?B?Nkw2WGRzV0RQKzF1YXJ3ZTVFRDh1OTZ1RE9nWStRMHdCcjBnR20xOHJCVUxr?=
 =?utf-8?B?MWhjY3VyVnB1bFVkOU1ZVklpZmpISmI4VnI4U2cyMk1UeGpVSnVTOGdPTElG?=
 =?utf-8?B?VTBKbGZvK1VoOVVLSHBMcW1ZQ0Y1V0pVVmEyLzRWdmFQUGpzc2poODVwMGxj?=
 =?utf-8?B?YWl6Y0pyNkliT29Hb1NuNTAwMjNOK1A0N1NsbytBRVFCYkxERUJLQW4renNZ?=
 =?utf-8?B?V2lKUnU0Nzd1dGdndGdESXlaUC9FdDFoRFl0bkJtS3puWmt0VzJRTEZidjVu?=
 =?utf-8?B?QWI5NWplTTJ5N0sxUG5iTFNGUVl1VUlvdTE1MWE0KzQ5OTI5Rm8rWjNzcmI5?=
 =?utf-8?B?dGNSbE5GOFo3UHNyQ0p4QmMzUVVVb2ZQOUdjSnF3WXRVSWxSZDRvaUJGOG9x?=
 =?utf-8?B?WU4xcGdhbmlpTFhUVW1oVjZDODNwSXJIZFVETWthN3dKUjdad1d5aTRWei9B?=
 =?utf-8?B?UWVCRVdQRm9xamlCRUdDLytYeW1ZNCswWWk0dkxhYnR5V1JqSlYveDlUVEV6?=
 =?utf-8?B?VFdhWDNqelF2ejNGc2FVUVhqcHIvQ0lzaHE5dnpxZkdBWG9jekxMQlozQTNU?=
 =?utf-8?B?K1JaaTgxNXR5TExFMy95cXR2VUZmRzNMdUVZcmFkMzlWK1kvYWIxWGZrR2RC?=
 =?utf-8?B?RWpTa2RmTTNIb1N4c3hqMmRKTWNkWWtWaEFzc0dBWWpIOENteG0yMDlDdXV6?=
 =?utf-8?B?cGVlUnRLaXozajAwVGV0WnlPM0N4NURNcnhrMW5xMStSZkxkdEhYMTIrekdM?=
 =?utf-8?B?QitlSlZTUHE2RC95M0lJbFNXcGRSSEg4WENGbkd4SEQwRGpxamZBUkFxNzNh?=
 =?utf-8?B?TW1hYmZvdGZGTFFJeFdBRGVwOVlBTU93ZWJ5Vm1yOW9CeUdJckRuQmpiSTVJ?=
 =?utf-8?B?YzdRaTRuL2tlRmtNSE1DMXJuZ2VYUXN5VUZ1c3p5Rjd4T3IzS2k3bTdhSERS?=
 =?utf-8?B?U3BmNkVOTWRjbDVBV2dxMzZ1WnJCWlVJVURqVWNPYjJVbUcxZjA5RXUxaDFL?=
 =?utf-8?B?Q0FoUGJPYWd2SkFJVk9qUnRyWUpBalI2ZVdab0JNMitjRkRCZjBCbnkxMm9I?=
 =?utf-8?B?NEZzUUdjVWtwaXNycGVpNW5rOTkzQ0tjSDZDMFdGaDZlUVh1bU9Bc2psL3Vi?=
 =?utf-8?B?ZnlKRWx4dXUrbEo5aEdBTDdqYlN1UVZTaGtaWVpzS2tEeTVJcTgwMHRkUW5L?=
 =?utf-8?B?ZCthK2taYU5IdUZ4Ry9XWnFzWWVHcER6SDQ4R29abkZXMWJXeVRxMXA4dnRL?=
 =?utf-8?B?bzZrcTNCb3o4SFZZeHF2ZktJNkczOWJvUFNnYTYyTlpCMnE1MklrZHg3Q0JL?=
 =?utf-8?B?Nmw2K251RlpJUXhMWWRQQXVLb1lrVkw2aXdjWTJ0eDNZNGNRQjlVd0hzUENr?=
 =?utf-8?B?Ujl4RERqcG52aStreHBSNjFjcGlOUG9ZR05wVzg2NFhGVGpuZytpUDRrVkl5?=
 =?utf-8?B?ZmhLWW1LSnFBS2RUWVdNNUIrM3NaVDRVOXZBMVBEcGc1MVovUlpCODlTN1ly?=
 =?utf-8?B?cUQxZlZZODNMR0hjRE9rYWNMZDV6NEsxNExTV016cDY1K2RLa2JLUVczMVQv?=
 =?utf-8?B?elVuTjQrQnp5b0NqYVV2UUgzWFRXaU5KbFh5dnhHMlROUjI0VjBIR0ZsdURm?=
 =?utf-8?B?eExNY2MvRitEM2x5dGh4VlR0eUVlblM1SzZkeldack1kNm0zcTJzNk41b204?=
 =?utf-8?B?ZDJGODN2YmdoWUkvc2cyd0RxcUN4MTc4a3NsQTFPcDFzSUs2VnBFUlZNQ1Fy?=
 =?utf-8?B?bjYrOTZOdW03SmllWVprUTFteERYRGNLSXIrRGcvMnk4MUd3L0R0bzYwcEIr?=
 =?utf-8?B?VHQ4eEFuRHl0TTRnWnI2RUNxQUFNRTUwWlFSMDlZNXVmWm81Q1duU3RpVUdy?=
 =?utf-8?B?dE83VnVWdGFGNTBhd2xTbnRhT2xtTldWN3RLMVBsWjNQa3BTNlY2a0cvUGNX?=
 =?utf-8?B?eWl3Rmx5YWh1Szl2QmFmK3A1QUFuWThablJXdXpzVDU4alFrdFl6MVVhQjkv?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e944d255-3c40-488d-091f-08ddc5aeb5cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:53:52.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUTmo3n/kaiR/W2roQaZ/ABE7NwoL0RZUGzTsbcDeEYWH/SBdTd3gcdDp7CFtiP/KG9GR5WlP7jQdvB92osiqjG4nGK5S8qMKTTIvfy65jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> When the "mbm_event" counter assignment mode is enabled, a hardware counter
> must be assigned to read the event.
> 
> Report 'Unassigned' in case the user attempts to read the event without
> assigning a hardware counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---



> ---
>  Documentation/filesystems/resctrl.rst | 8 ++++++++
>  fs/resctrl/ctrlmondata.c              | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 446736dbd97f..4f5eb5bbd4b5 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -434,6 +434,14 @@ When monitoring is enabled all MON groups will also contain:
>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>  	where "YY" is the node number.
>  
> +	The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
> +	counters and allows users to assign counters to mon_hw_id, event pairs
> +	enabling bandwidth monitoring for as long as the counter remains assigned.
> +	The hardware will continue tracking the assigned counter until the user
> +	manually unassigns it, ensuring that event data is not reset during this
> +	period. An MBM event returns 'Unassigned' when the event does not have
> +	a hardware counter assigned.

Most of this duplicates the "mbm_event" description added in patch #10. It should just
be sufficient to mention that this applies to "mbm_event" counter assignment mode
and then user can look up the main description in the doc.

The last sentence is related to this section and need an update to reflect behavior
when a CTRL_MON event is read and it or some of the MON groups do not have
counters assigned. The paragraph that precedes this does describe how the sum
works so this can tie into that.


> +
>  "mon_hw_id":
>  	Available only with debug option. The identifier used by hardware
>  	for the monitor group. On x86 this is the RMID.
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index ce766b2cdfc1..45351673e4ee 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -661,10 +661,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  
>  checkresult:
>  
> +	/*
> +	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
> +	 * mode is enabled and no counter has been assigned.
> +	 */
>  	if (rr.err == -EIO)
>  		seq_puts(m, "Error\n");
>  	else if (rr.err == -EINVAL)
>  		seq_puts(m, "Unavailable\n");
> +	else if (rr.err == -ENOENT)
> +		seq_puts(m, "Unassigned\n");
>  	else
>  		seq_printf(m, "%llu\n", rr.val);
>  

As mentioned in previous patch, please squash with previous patch.

Reinette


