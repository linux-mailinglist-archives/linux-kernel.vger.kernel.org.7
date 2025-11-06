Return-Path: <linux-kernel+bounces-887560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D960DC3884A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 758FC4E808B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289661C5D6A;
	Thu,  6 Nov 2025 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUfTF3uf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAC19DF66;
	Thu,  6 Nov 2025 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390149; cv=fail; b=C/uzyOsAM8mKaf6OfCekYo3RB+WaBbQwOnSTFzqYOreTMGXqFkT+2RtX3+taAphlELsTqOSJcvsRFcUXErs1My+nCwohJJZN5tTTUphJhwRKKUcwWRu/yfluTpdyAxc+3Vmj5/27rCOHR40BlgHn6HekfbUQcamcua7efEQ47Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390149; c=relaxed/simple;
	bh=UMuz0j2mNYtkCj+uN3LScpQlVEMpMObItBlPSNwU1/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0vDP5D5pXvbzAPMAtJpw3yzUd/sx7ykrCugiEza59LtsvtuZwOrQS3MaVWkURB2HB+5QNTiZB1pVYvDtlswaHGfgij6ik9Jmc396y0fwiT0SygyktmxKEN8oJyRJuvIgc3tPrpnJZ0XNL7N3xMudn0bh3B1NiN0XkVusmYETNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUfTF3uf; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762390147; x=1793926147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UMuz0j2mNYtkCj+uN3LScpQlVEMpMObItBlPSNwU1/Q=;
  b=cUfTF3ufWdKUsJ6wEjkB3uVbuB1KsIR0JJzg9IZmBuKX4J9x0om2o21V
   NtRKrJrPqp/Ac1/yhRWZQ7X+qjoT0kD5dP9NdcjINFmBhwU/Bt6dAC7AV
   wmKA0d7y90WcCGwCyPX2dnVr9IydNpuMsvUfWE2SR+9H3LAZ1/1Rn3jtg
   bM+V76UiuONfys0jZwWWg+pbeRNqS25Gygk+ytfQs705Y82zedy93/CIG
   xOnVLL+NYB3Zzx2J9KUtmWRKirM/Wb3b2OM3G8aNvKeM5GLpH8ix42i21
   13oEe+kAnEiM/P8Jwp415lyqrTiV6LwwgZSgaYHp8tg0T/3xQvWUopffN
   A==;
X-CSE-ConnectionGUID: pXJN2vC8TdyqGbqiIHDwfA==
X-CSE-MsgGUID: gPxu4Bl8QRC1QFXmrDm5rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64434470"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="64434470"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 16:49:05 -0800
X-CSE-ConnectionGUID: Ec9kOlwORWGM0NMcbU4/+g==
X-CSE-MsgGUID: TvYFp2lsQWmLReQ8KEX74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="187894493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 16:49:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 16:49:04 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 16:49:04 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 16:49:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxOWbP9AnuSuiUhRA4nReH8YcqRnn2i6g47dk/NR8GNwdWucLz35NnNXqZiSSFnlNm4d+SqqqRSOMjOSAIMeBhVk1GCmEh6ZZQonIlto+rrdte6H+SGC5tmGQfwngJiErJCw9pA6R4pZ+ojIZNUjTSsWFicsrDNS6wVtVv60UTiH9/zWGSh7bmErMq4K5w4QHknSjFx3S57nX5EJpVwKjuVAprnpOchkaEV9Qdr6lKrrcq0GDN96c+h6NdKgonZvU/nV7CzA+yd231rEsV7ISunAQdYODWN4qCVuVcKs62E/8DfxYRrEGF/uhSHMW3Rb14qPRdS0hs6nxyt5qiFYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgVMjNhPK13j0wu46MWqfqsMg8ZdERnwldX7DVl0uAQ=;
 b=eY4un+x3+Irys6nznijK9qo+1w3qlBSNLMAi7DkPTbZDEk62JS/MmwM6uTIWwjBpRCXkvCI6DxJ8MGsoU22WO8ua0If/HpnYWI/HdTTpzQ6hs9XMIfcBVDvcazAzjCixg/bbRu/dPTaJENIl4pSGm2JitxPfH3w79TBaHaVysuP3a7JsZ5btWckajshbXqRpKBfbKksZiyCuna6xQp+FjB1oipOeFuyS8n2lKGG8C+7xF9/KLue412yCTdjpXKMM2yVVlptxNhed7tnb0QGiCUv3ZcOWTzfhyo40KzNWSiG1aYaGdnlMjsq1Vid6oqGHk13p1WxP+eWRfxRmameijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 00:48:57 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 00:48:57 +0000
Message-ID: <5bf8e5f6-d515-4cd0-a2d7-c0eb9a305c5d@intel.com>
Date: Wed, 5 Nov 2025 16:48:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
To: "Luck, Tony" <tony.luck@intel.com>, "Moger, Babu" <bmoger@amd.com>, "Dave
 Martin" <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "james.morse@arm.com" <james.morse@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"pmladek@suse.com" <pmladek@suse.com>, "kees@kernel.org" <kees@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "fvdl@google.com" <fvdl@google.com>,
	"seanjc@google.com" <seanjc@google.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "xin@zytor.com" <xin@zytor.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "Bae, Chang
 Seok" <chang.seok.bae@intel.com>, "ebiggers@google.com"
	<ebiggers@google.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peternewman@google.com" <peternewman@google.com>,
	"feng.tang@linux.alibaba.com" <feng.tang@linux.alibaba.com>
References: <cover.1761844489.git.babu.moger@amd.com>
 <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
 <aQt/dSRgtQNfJPCj@e133380.arm.com>
 <4a120a9b-b84e-4cfe-af46-1b4d721c2995@amd.com>
 <SJ1PR11MB608391142B594331922876EFFCC5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB608391142B594331922876EFFCC5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7fe5c2-ad95-41ef-e69e-08de1cce446c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJBdjJlTDBmZ1JMMko0L0llMk5nOVNuNkZuSjlNU3VGY0lSUnJBVXZod08v?=
 =?utf-8?B?dHpkTDBkVENtOFY0U3ZHSERSM1BrT3B3OVoyTHhaZmU3N2R1ejkrMm1hQ1o5?=
 =?utf-8?B?eEtEZHJwVTRNMUUxK09JamE2OGpwSkJXUTNSbk11Zy9SOC9TRktza2tqYVZi?=
 =?utf-8?B?VkpiTUY4Z21CNWEvQVdvNjhna0xkNEhCZTdwU0ZwdnlTL1hPR052UHpydDZv?=
 =?utf-8?B?MWU3bzJGY0JaL2EvZjdydkZDS2psVk5LMWpIbG9RbzkwU01PblpWSVREbG1V?=
 =?utf-8?B?czhWMTdTWk83V2NnczRRSlFuTWZzUnFoZ0tIWldHd2tvNHk4eWZXM3A2RjM1?=
 =?utf-8?B?aXM2Z2NGL0tRSk8vTkZXMm13N3VEZmxKWGRkUGNxbGZ1YjlhK1I5K01TUGJz?=
 =?utf-8?B?dklPc2pUTVdhYU1XOXdNN3BNU296WTJVT3RXQUh2MVU0WGphcXJISW95QS9D?=
 =?utf-8?B?anFYcUtyUGVOaXZZbGpIVXVKRDdyU0t3UFI5aEM2R0FvcnVrQkdyMnVFVkNG?=
 =?utf-8?B?Tyt0amptZEd3QzJiY1J3NmtSVDJJZHlKeDBvbjZuam9SejRkUUdoRk9lV20x?=
 =?utf-8?B?QWZvQkRpZXRaWnBMRUJFZzF6UlhsbldIbXhDVHFKUTFyRCtnckIxTWMrS25T?=
 =?utf-8?B?Vnkwa3Y0M05URklKYmpTdTRnZWxodlA1aHRydEg4NTArSk9hbWw0Z3dNWjMr?=
 =?utf-8?B?NWxmUlNzMndoQVhLcldOemN2ZGZVMW1tNWM3cTFNWnBBNWtXOWtYYkRYVGZB?=
 =?utf-8?B?bVd0MVZzRTEreVo1VkJZeW1LOTI5bnRUcC9Bc3Q2OVZxZjNjYmpBaWF0L1F2?=
 =?utf-8?B?RnZNNzN2SHVaSkVYSmJBZmttVGVvaTlZaG4wTHcwRXp6cGF1Z0VDVk1Yc3pw?=
 =?utf-8?B?ZVp6MzFSWFhzOENKcWFFQjJla0hua0E2THdsdkU4a1BLWFozTE81VkRmc2hJ?=
 =?utf-8?B?WUU1enpPRm9lbEJjNU41QldJUU1kQ3V5ZzBJSm8rYTRuOWt4Sm1vcjAwaTNW?=
 =?utf-8?B?endEKzlFSFVHRkJqMnoveVl3dUFOVFcwUFBYeU1Ib1FDNk9qZVBJRjhnN1U1?=
 =?utf-8?B?eCsvaW50emYveHJUYXlNY2tJWnNYd2w0SDFXZ1FxVXgxUUhvdjZVd3ZkT2s3?=
 =?utf-8?B?aHAwSU9EWS8weVFSRllCM1dJNndZVFlwZGxua1BPaEJJeVgwc05rUjAwNHMy?=
 =?utf-8?B?b0RZZFNGNkl6QnVyY1VxQUNvVTVEMk9yUG1DN0dvZWp5QllFMmFRdFJ0Vk1H?=
 =?utf-8?B?L2prVGdnK2dtWS9vSm80S3RVak00aTFmZzdvR1dSU09tS3RHcmU4Q1BIZlNJ?=
 =?utf-8?B?ZVRhc2hLdlc5VHFkVlhOTUJxZ1FraGVVSk9KV1FaSWhLa2psQXB3ZFRaSXpx?=
 =?utf-8?B?WkhpeFZQdk8yT0lkRkREVmhFVGVTSmtRTHlkb1NCaXY2TFB5NlpGZ0cyMndP?=
 =?utf-8?B?SUQwZ2M5YjNRY014T1JBODhrR256dW1tVlV6SjdyaXlwSEwrSmVFMjhYejZ1?=
 =?utf-8?B?MXJpRVBhcFViVUhaMUhsUDFZRnZEeisrQ2NiKzUxSzZWVkJUMXQ1cCtqQzBx?=
 =?utf-8?B?anF3OFBvelFHRXUvc1kxdFJWRUlCaGZTb2wrc0wrOG5HWStpWHpwNGNndm1j?=
 =?utf-8?B?cGpaTEJoMFZsYWlMeFNZbjViRXNVdE1MSklQZlVFaWFzU2YxdC9VckZ2ZXJN?=
 =?utf-8?B?VWN4Z0FoQUNnQmc0aVNRL3lpcmZNSE5oSFdwdVFCVWhOOERaM3N5SHJETlMy?=
 =?utf-8?B?NGtuS21xWFljZE9ObklYalFtSzJRMWo0VWFFRjE4a0JCWWwyTTk3TlFtSFNK?=
 =?utf-8?B?VktnbHloeFR2RmZFNjlCV242M1huUFdVeFk0WEhsZ01sS2d2UWdHa053YTVW?=
 =?utf-8?B?cDhmdFQ5VWVGNTZFVDlTMjF2K0Z0Nnl0UXR2bnBWRCt3S1k5WktUZ3pkdnRq?=
 =?utf-8?Q?DB94AVyoiIzQ3+PQNaiNc6SoIe/gnyE3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZzd3VIL29Wd1hTdndGU3Zxajc2Rlp1eTRhZWJyY3E5QVZtaDZVemxoZlhn?=
 =?utf-8?B?TEdlYkFBNVZlbE9zakFLcTJybHFnUUVvMlFqK3ByV2IwdzE2WFc2ZEZRcVFi?=
 =?utf-8?B?cFU2V3I3amlhd3ZtRVBwbjlaUG5vbVlJV2hoMmN0b0NjWURNQmJMUVJoZGY5?=
 =?utf-8?B?QnQybGxJNFVMUXMwNlN1bWZBZUh5NmY3U1F1OUNkb2lJcDhNaGtFU0Y2bGIv?=
 =?utf-8?B?SHptaFNaaTB1RkZGRTZJVHJNNGdMTFYyOWw3VzZsb1RFWDh2cmI4ZUhQd2R2?=
 =?utf-8?B?NXY0dVhsWGpqRE5YY1pHMlJUTXg3NmNyQVpkQzJranU4cnBEY0xmWm5vaU1J?=
 =?utf-8?B?NXJHQnliVXoyeXZyS2FrdEdXd3JZQWZQVTE2RUxId2tkSy90M1dqdDdWNDdM?=
 =?utf-8?B?WkJaTWxQYWh5MG1SODFOY1BkVE51WGFPQUEyc1M2OFZxR0oxckV3WFdEdEha?=
 =?utf-8?B?cXd0Y1lYSE8vM3JVWXd4b0hTZWdpTW1yREVQU08vc2R0emtxT1d2OWYrVkhv?=
 =?utf-8?B?YTRGSGppSmNOVDMxRk5XVlhTVTZjWjlGVURTUG5odVl2d1Bpa3E3MWhhTXhI?=
 =?utf-8?B?dlQwR2lEZXR4d0xhTVpLdERiZ3FRbUxIWks5cmUrVTNPNC9udnY0T3E3a2Fp?=
 =?utf-8?B?U2pZbnFYclRnaU8wWk9XT21mV3dxbEZzZUhic0JQQUtZWjRXa1NpOW5BS2pP?=
 =?utf-8?B?eWFMZlNxTjkzZXhFWGVaQlhIZVRPRS9zcHpDZXNCQkdDa1RmNzRGK05XeFh3?=
 =?utf-8?B?cEJ5VFZuM0JhUmg1TVNZVjhXQlZpNjhOOEhmSm1BOHJSdExmUVFlWnYzQXAv?=
 =?utf-8?B?OGJRRjVFYktDZS9nWUp1VVRWTlRROHlVdDh4OUd4MGxsc0dLM2RZK2x3dVBi?=
 =?utf-8?B?SkdPRkJqc1FRRGNIaEFxbjFHS0l2MUZ0elZ1TExkNTRBTUtoTDdoQ3VwdU5G?=
 =?utf-8?B?TDdvY1hPMEU5YWNFTlE0N1NiSmlIOUloMnBBNWdLRk9FVFBUNitLMlVwZ0I2?=
 =?utf-8?B?WXZpNHhFUkc2Ui8rMHJPQ0tWakc0dTZSM2dBUWM0VGhxam00bytYWlZVU2lt?=
 =?utf-8?B?M1RYNVVxWVRFU1BsQk9EUHpKM0RNYlM0eXNFcnVLaDcvamZlYVQrQ3F2Y2xC?=
 =?utf-8?B?QmlaQWFDRERTZThaZjdOSHBoZW5lWmw0Q1l3OEk3SmFBNzl1ajhyenVXWFFy?=
 =?utf-8?B?TXlKYVJOSXFMeDVUT2dydjBsak95L1J0aGMrdkFIMTJQYzhkNVlRSWJLT0pC?=
 =?utf-8?B?UjMrZS9Wb3A1S1AxUlVSelJUMVdST0hRNk9aT21hcnpDa2pGd0MzNEJpTXpu?=
 =?utf-8?B?c3RsYU4xMWx5cEt6M09sWDBjcVdiY2t4OExsTjRUNmFMaVhhMjF4YmJaQTZ0?=
 =?utf-8?B?NjNYSDVrdzlNWjJtdjkzU1REU3NTUmV5b3BHLzVsZE96WUoyNkF5NFNtanQ4?=
 =?utf-8?B?eUJzNEgyUGxtcW13dlI0VEFSRHRuMmdMcDlWU3Y4Mm8vS29XQldoZVVPNjBw?=
 =?utf-8?B?UHhGUWZRMWM1Nis2VTJ0L3ZnUnZyNGN1cHNxSW1pMUxNQ3JxWElBclAyU0RB?=
 =?utf-8?B?WXBXdS9mNCtYSjhtUjEyaXhtaHdSMmdMeHVieVIyZlBCVnJZZFA3NmtoN0tC?=
 =?utf-8?B?QnJTd052TERjS3U3ZGo2RVFOM25tSmN5Q21yT1ZZM29zYjlSTzk5N3padmh2?=
 =?utf-8?B?cmRvMDgxbG01S0VnZDErZy80T0lrMnNNQkdnNlVJeWRrSEdtMmZCaXBvd2JV?=
 =?utf-8?B?R0ZZNkpHaHpNNk8rSGx6WnAyL0lqQjdnRnFWOG5FZHY0WVEyNU5kK3ovcWd1?=
 =?utf-8?B?b2NMa0I1TlNyTzQ3ZnNoNDl2NHdEcWRCNy9JKzNVUlhJUlhFZ2JOdWlvQjJY?=
 =?utf-8?B?ZkRCcVAwZWdWWklrZFdRejZ4Zk5waVZQSDgwMTVtc3ZFN1UvS01aTGV2TkNZ?=
 =?utf-8?B?bEdUalZhVGNzaC96UXFXOThVZjVGS2hvcHlvaWJ0MzlWWXk5OWRuV0p5eHI3?=
 =?utf-8?B?SnE2THlGRFZXOEVnY2dkUTFRMng1S2lXRTdCejgyRHo0aENPOGhaVkxlK3hV?=
 =?utf-8?B?bjdXUFZtS1dwckV0UDMzcEp3ZHNHVUFWTjVXa042OFpwS0FiN3RKWnY3ZGo3?=
 =?utf-8?B?cWhqYnFmMk5vWEdsbDZCZlVHNldWWU1yVnlHeW1oWW85Um13VGVORDEwaldL?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7fe5c2-ad95-41ef-e69e-08de1cce446c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 00:48:57.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOg2BXRIQ3H8gaktyIgITcS5H0AeJxi+zHMQOvuqNaMB4YJ9CjIvfT5cHY6IHYmop+fz0203AhmIFwPUzyvw/NTbW8aK9X/H2k5m5C4uCtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
X-OriginatorOrg: intel.com

Hi Dave and Tony,

On 11/5/25 10:25 AM, Luck, Tony wrote:
>> But in AMD systems its the highest CLOSID (15). Also, this CLOSID usage 
>> in not visible to user. There is no update of PQR_ASSOC register during 
>> the context switch. Hardware internally routes the traffic using the 
>> CLOSID's(15) limits.
> 
> Things are even more complex for Intel IO as described in the RDT architecture
> specification. There can be separate IO caches from the CPU caches. When
> this happens the RMIDs and CLOSIDs for IO are in a separate space from
> those for CPU. I.e. you can assign RMID=1 CLOSID=1 to some tasks and
> those will measure and control traffic from a CPU L3 cache instance.
> IO devices may also use RMID=1, CLOSID=1 ... but those measure and
> control traffic from an IO cache instance.
> 
> This looks like the multi-socket case where RMID=1 on
> socket 0 (and thus L3 cache 0) is independent from RMID=1 on
> socket 1.  But resctrl partially hides this by making RMID allocation
> global and just providing separate event files for each L3 cache
> instance.
> 
> I don't think this maps to CPU vs IO. As Babu notes above, there's
> no update for IO CLOSID/RMID on process context switch. So it
> makes no sense to allocate IO RMIDs from the same pool as CPU
> RMIDs.
> 
> I haven't come up with any concrete plans for how to implement this
> version of IO RDT into resctrl. The earlier implementation on Granite Rapids
> didn't have IO caches independent from CPU caches.

It seems to common now that we need to build support for new features and ideally
any new interface can be designed with some gateway to enable future enhancements. SDCIAE/io_alloc
is a global IO alloc feature while the ones mentioned here for Arm and Intel seem to be a better
match to be managed per resource group. I did try to think how to "keep the door open" for
future enhancements, hypothetically "/sys/fs/resctrl/info/L3/io_alloc" could in the future
return a new value that implies "managed_in_resource_group" that opens door to create
new interfaces in the resource groups to manage IO alloc there. The "io_alloc" documentation
does seem high level enough to support such an enhancement.

Do you see any additional changes we can add to the interface or documentation to
set resctrl up for success to support these features in the future?

Reinette
   

