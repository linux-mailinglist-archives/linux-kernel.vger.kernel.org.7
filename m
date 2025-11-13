Return-Path: <linux-kernel+bounces-899388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89180C57A07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147033B8111
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8D350A1B;
	Thu, 13 Nov 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaRoZT2S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B6350A00;
	Thu, 13 Nov 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039498; cv=fail; b=b1Uu/9irjRVjZzVCp+Ho+zQmcC44jitRJUSZCCkZmwpi5GyDWP/HV7USa7yEH9sNTFFFpDU6rCZbhd6VAmF/bnIU/N+baSQTfAjrSGvL0IEAkbQGjEMxyghBOQOcBEi6i0+bGSHXdZqJK9sZyEES9BPtMGuQddZ03YNzAWcwhis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039498; c=relaxed/simple;
	bh=FKoLoTVC9G4z2JHnQ1exARY50zN1vhhJrihvbQUX7O0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eweDwe/a4ixLtAMLmSgriX7GNA42XDuFI7PWlNE6Rdx+d1SrZd6bth8kTMH8sMEMTKJM/rKq2uOZ+PywYMRmaZUnhdGrXw6qruFjkwDD9fhgnxkhzBlaPXKTqp8J7xo/Dext18WRanVXaQEz2wAvNUK8NnO16y5yyonfSOWjZKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaRoZT2S; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763039496; x=1794575496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FKoLoTVC9G4z2JHnQ1exARY50zN1vhhJrihvbQUX7O0=;
  b=gaRoZT2SwvxlCHmssS/pvlu5QB4XQn7UuEt2NLAEvI2bYsjY9RsmZy5W
   Gc8FYXj8WdXQkMIYO3reZOUkqD5cpzlRABMlEBMIn49jVJxVXGx/4R7Q+
   p9MNw/vMju2S/4dTI4/EGUgsvXf7QuO4t7gqkrsWfl2Zx9jB0LBrgyhxS
   IOLjoZ408Tt14D9R0gViuC1YcjY5kkRq8NsMKtgOeYLl57e5WqxWuLsgQ
   FM8xVaB4GbahltpzexJ7w59r3FqR2OqGDu2e4pU4o0zpdYqZi7Q7Zj34z
   NwEZ+i+oTlEeHYALyo5+m9WD4p9WoZXYAkhTRgHbYZu3E3hiciiQ7Yslt
   w==;
X-CSE-ConnectionGUID: 2PKo6rewSPeiqRIFVdExsA==
X-CSE-MsgGUID: lx2DGBvfQ1qD1g4iQdM3hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65023815"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="65023815"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 05:11:35 -0800
X-CSE-ConnectionGUID: NpzG5EtoQOuK7ZPDlxCaCg==
X-CSE-MsgGUID: ncn4ja05S+m2C94oQUAvPw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 05:11:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 05:11:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 05:11:35 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 05:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNlfKZ1VtS+dYmxIi+gg1Z9ViwosuxnWODhJp1uLUg/E7FaDv3NHqpDemQP8A2dLMXf8u4nGvebNkRUAiF7Xcsp962EI7G8VFm4Cg6P6vIGDIYzgsq5Kgv0HIW7NkA68PaiFrO/i9r70PeHT0GcBxtVfF56Kn2aTol1XIPXu3q4i5ddv0UyOHy8B0UeGZ7nl5qnpmKdwiuB7HYeq7fUe8mFUMSshGkWCAEk/uskhgd2Icgty33yQIQPi4F8DJnCf8D52hKjIon8k7OKYmXMMXB7QENN+3ZkU7wG5DCKpnEpKUIGC7QxlOrS5PkR5WAzw0jWFSpsSMyvzmtsSX24/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBFVUrVpoZXcYIa0CTNo3bPCMnGW+2NvNCnvpjhcLKs=;
 b=P64vmFrQcocA80ti+81vHG+I8SqOItcT48kX3jBwkUIjK0xa++Ypb7Pv3+jNZmVdDM8XTB0Tkz9VTf2tfLyH0qFnkVgLVcLYU7OvCc8AqCRI2AYHpwy/RTfVgEHoonfm5nNZLmK5exbdnbcQARyJ8mFQaLT36YqV40mm2ojsWvAW/mi8UEzmdJ+rQmF/9SsPg2R/LXm2aUas13ov+3eJLdPk473UYhZCDjtII23aO07R/9XjHej22JWBs+a4GXL9HjK/WNRRvYzsptRmUwThiNr+iWu+MLW5IBEm1dsyP+9BVYzbPu5NF5cGaLWfdWDsY51P3xjC3FkcRt/nerP+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 13:11:27 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 13:11:25 +0000
Message-ID: <24e5abed-9084-4f3d-b620-e272164f687e@intel.com>
Date: Thu, 13 Nov 2025 14:11:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: intel: avs: Fix potential memory leak in
 avs_pci_probe()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: <liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251113120447.86911-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251113120447.86911-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 366a6a21-5dca-479d-d05c-08de22b62644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFowODFpVktwRnFIQ1BkTC9PNU1CeE5DcjB2NmEyRzZLczY2TmxlSVlzN3VK?=
 =?utf-8?B?MG11SzN2U0kyanNXYkdZWUdQcjZVdVI0UGlXdmltY2RmMmRqcC9BcHNLd21H?=
 =?utf-8?B?TVRBSnR1YnFoWXJGcUFrb0wraVIwVW9NdkVLVUE4MmUreFE0TjcvZVU0MzA5?=
 =?utf-8?B?ekdkMUFUOEtFVmExNVVvQWpCYVNSMG4wRm1xRHNzSTcxUVFNUTNtYUQ3OStU?=
 =?utf-8?B?ckYrWnlGb1RCN3R5akszbm1EbjVzV202VVNpWlNiYnNyeS9vTXJGVVNhQjJp?=
 =?utf-8?B?ZDBIVC9MbDAxaGZBellpYll3NjJCZ1plaFZZc0w3MmVVQXFXalhvUjE1WEY5?=
 =?utf-8?B?ckhhcjU0ZEtKbm0xanNDcHZqSG42YUxUS0dvTVYvbFNQUml3cGoxa05ydUFW?=
 =?utf-8?B?YXBMMVFyVWNHRmFZQTdUWGNSNHpYdE4zcG9WWlpVNWRFVnpWb083aEU2cEdY?=
 =?utf-8?B?Q3NUYmx3ODBjeEhLaFlJc3JmanFBeVVEWnRGL1dhUHVVWGZxQ3lSc2dERkFW?=
 =?utf-8?B?bUN6QXdHWDNMd3o1MGJTUitDNmRiN1YxMFZaREdNZFhZaGJ1NFk3RXhKdGh0?=
 =?utf-8?B?U3BCajV5QWFjdFA2VFpBRkI3d1RIVHpKNldjRFNycFNGQ21UUklnZ0VnRng0?=
 =?utf-8?B?YVVsd056R3B6VHhHQXVFRnhXbG1mVjBXRUFBYmtEY2owVnJ4S0REaERMKzF4?=
 =?utf-8?B?cHVWQjk5NHVWTGtGK2J2a1M4WGgvNjJqbkF0VEk2RzBaWjF4bmtCVFpHMHJQ?=
 =?utf-8?B?bm1ZM2l6VHpmY3Z2Y040V2hZbkw1RzBvbFhyL25saDJpOGc1SjQ0U3BsclBw?=
 =?utf-8?B?dnVwdzNlQk5QVkVyanc3U0h2SmlMNVpFQ2xoQ1UreURuSGQrRFNoSm5mSjdu?=
 =?utf-8?B?WWcyWVJ3S01yZ2RrM010dU9MazJjTklLQlFkZVRRcTRrTUhZancySE9LcFFk?=
 =?utf-8?B?WlZtSkg5MHAreG5YbmcxWHVoV3h2U1B3NUt2TG1tNGw2dndrQlVKbG8vbTBH?=
 =?utf-8?B?Y3BYMG8xQjhQSjIxQXovaC9HSXA0R0drZ3ZHampmdE9qdkRoMFZPektMd0J3?=
 =?utf-8?B?TTVqbnFBTStkQnp1NVZSUkZVdGIvMnJ0emVudGtBUXBFMmhCSk1aMklYdFVH?=
 =?utf-8?B?R0swUzNaTDZrVHdGUGNocDRZWGJlbThCelRrVXhQSytaODlsSjBXSlpUc2dQ?=
 =?utf-8?B?c2ErbEdtTjM0alJ2Ty83WlhFQzF0c0w2UHlNZnRDRHE2ODFNN0gyQ1JBTm5j?=
 =?utf-8?B?SFdnRS9JczM5YjFiOEdwWEluenJSbENMV05JaWV1UVpMVm9OUnF3dEN5UkhL?=
 =?utf-8?B?cTUwV1FlaCtGcHFmZlRKVlpXMkM1dGVKT0I1QkZSaW1aNXYvWVhFNEM1OWd3?=
 =?utf-8?B?Z3ljZG9GaEFUZTM1Znp6cXVCWi84c0RLYVpVYUtzL1lGZ25TZVlFMmxmZldq?=
 =?utf-8?B?eWtNeUtUeGY1dkg5dzg1NURNSmJBZ3VpM3MwMGpoOEwxNlFWNndXNkcvV1JM?=
 =?utf-8?B?K2s0UEdhK2lhMExjUjNJQTVuQ1FWUHBsTmRTNC9YUEVPb01xbnl1d2pOUXJq?=
 =?utf-8?B?SVhHL2JaRlFHd01YYjBQekUwcFltZmdMbjBsUU9GdHYreHk4R2RMc1VEM0tW?=
 =?utf-8?B?R29GbWtveWp2cGZ3Vk5xTkt2dm1RWVJMTXpLY3Q1R0JNODVncllwSEIxNEt4?=
 =?utf-8?B?TFNZK0JTQTE0WkdZODg5d3Z0eFk4cWVjSVgrREE5YlJLVnJjcWFEQ3pHREpK?=
 =?utf-8?B?ZUlxNDA2WHJSSHBYeHZoTXgrcUFUSThadkw5aVpyN0JXNGFsSks4dUN0OXVB?=
 =?utf-8?B?VEJCKy95WVB6VWlYTGM3SEd5S3RYdStiSUpVdjdwRlFTRk5FK2RQbTNsS0Za?=
 =?utf-8?B?T2VEZzZ2M3NMYnlaazBSSm1GZStnVytnVUd1U2N3d1pEdFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0c4L1RkUnJUbnk2SnA3SVB0akVaZXBwYWVmaE13M0wxVDZoZW05SmZzcE92?=
 =?utf-8?B?TGJJUUNQYjc4akl6SUQvUng2OFNWTnd1T0xpZlpxZU44N3JYWXNWcElGZ1dU?=
 =?utf-8?B?VVVwTjVjbEpmWVhZWkVxK21qYWJxN0RIVWRWa0pKZFZJUWZGaTR3OHo5U1dy?=
 =?utf-8?B?c0w1dzdSOXg5MmNxTU1tejl6UHpXZHdINGY0S2xaOFJOU2Y2VTNuSFlzd2dB?=
 =?utf-8?B?amJEYnIzejlmTWYxd0hWdVNZRkV0WnZHa0hTTTJxYnFROEh4ZWVac0M0eGxu?=
 =?utf-8?B?Mm9lN0F0ZVdONXMyMWN4b0NzbHU2bjloZnc4cXFDcWZsbUxnZ2dXNEgrZ3Z4?=
 =?utf-8?B?MVVGNkhUWFNpREdCRyszMDhSTkRrb0dlRHM0VlBZci84M0dLeDZhY2tSZ09s?=
 =?utf-8?B?WkFxbDlmcU5wWGpCMVd2Wm1JVlVjU0ZhSnZHU3FzVU1KOU43elpDc2ZZQlJI?=
 =?utf-8?B?N2ppWkJydTdOazFyaHRhOE42ZVh3bzVzVDA4cVh3ajRkQUJSZ3A4S0I2dzRX?=
 =?utf-8?B?NUJrN3JpVGVvN3ErUmNYSi9yemEwdkRNbjlkY2xqUzBCeW5hdE1DYlJROGZl?=
 =?utf-8?B?Q3lEdU93WS9Eam41d3pnT3lXOUpjSFNFOVJCeW1Mbit0b1o5d2QrcDgzYnhJ?=
 =?utf-8?B?dUpZNXlhbDRrKzROcmtaZlBnMzJiSHBtZGw2SFdXN2VoMFhyQnJ0eHdDVmpJ?=
 =?utf-8?B?dUNHbkdDUm9kUmRUTHpnU204VnpaTTJ2R0tFcFJOVGZNWVQ5VkFGS2pNdEkz?=
 =?utf-8?B?SCtBUGRIRktrSFFwWU1rdXI0Qjkybi9QWGluN2FOcG9rdDFqK2FkSFZrVGZE?=
 =?utf-8?B?b1VsYU9OVHBENkQ5Y1JQT3FudkFzdDVSWTR4ZERpc0t1SVUyNjZJK1p4QzZx?=
 =?utf-8?B?OXR2ZDZIYUxQSnFoWEMxakxXMjBYL3B4cDU0eGhtQlh5QUlTeXVTSXBiUEJL?=
 =?utf-8?B?amFHN1FSeTdnZ1JvTG9FN2Z4a2ZGRE0xM2FpMjBIcTdaMngza3lnNUtNVDNM?=
 =?utf-8?B?VFVHaitrMEdGNlNYcVhML1FpTXBpNFpnaU9QTEZzd21pWWUva2prMlp3S1Bs?=
 =?utf-8?B?djVMMG5uQmkyWElkemt1OWdTZ05yQUMrTHdjNmVRWGZjNnp3VXpVRFF0aXJj?=
 =?utf-8?B?UGwySWFublVMRmlJejNRT2tWd0JIZXU1TFNvcGsrNzlDenVTakcvWGs2RDhG?=
 =?utf-8?B?MzJFamw2UmdJbDA2M0RXQWtnNTYvSmQ1TUFVYXJxazdnS01LWlpPU1FDZWQ1?=
 =?utf-8?B?YTIrTHBNa3JwUDkvSmRRS095bU1qNEhpL2xIRFNnN00wWjErTmtLWW9lMzdO?=
 =?utf-8?B?bDhvVFFkVittVk92aXBUOVFtMmhpeUdUM0F5YWlyVHNUSkxEOG9UMmRsTGRN?=
 =?utf-8?B?UWEwV1VjS1AzVUF6amRZMGxxY21vcjVSc2wyNjF4ZFR3Q2V5YnpkYlBTQmM2?=
 =?utf-8?B?TkY3RGpMK3lSdnZHWlFPV2JzSENaZ0lVeTl6ZERSOHI2S1MydEZqMHZHQm50?=
 =?utf-8?B?Z0dhb3hNaFFaYnNnK1hDOHl0Q05PZ0IzZk5GYU1oRTJCWTRXcHRMVDQyMHdK?=
 =?utf-8?B?akowVEFxTlUybTVnQkVacE1xKytOeW55MnNqVkcxKzdaUkRrcERzaGpwSCtp?=
 =?utf-8?B?ZGwyQmc3ZWJtaVFSc2lmd05NKzJtUitmWnZqWElGQjZPWWRUVDVUa09QVFg0?=
 =?utf-8?B?Z0ZVT3hJcEtKTFJycjJYNHpoS0Z0VTVXVG9vdkRJcFlDWUM1NmxUbFBRSVoy?=
 =?utf-8?B?d2tYeXhoU0xjWnZiSU9mRU1NRGNvVFl3djhRTlVYT3pBM2pIVDVrZlBUWVh0?=
 =?utf-8?B?UTc0anJBdlV6dmVTUjJydUpsK05aaVlrSFNZWmJ2eUJ5T0dZN1lPWFJIS0lM?=
 =?utf-8?B?VHhhR2FEZjlGdnRhbkJzL3diS1hlVUFnZk9BMWtOV051aWQyRXhHSVpyaWZo?=
 =?utf-8?B?K1BYays5ZkVERlUxcGlHRFJjc1Mzb1hKY1MxbldsNHVZTDFkV1cvTENlc2Fx?=
 =?utf-8?B?dmxVVVFvaDV1VHY0RjJmTERsSjdvMVY0M2pod0Rta0RqTDNwR0JkRDBtMU5o?=
 =?utf-8?B?VmhuaE15NEE0Y3I2eEZLUVp1dHhueW0ybGVrelhXSVBsTkZJRXFnMXZoK3ZH?=
 =?utf-8?B?dkNBY1lCZHllS2lsSVg3c3ZVMzZOdzR4ckRhTGhWSzh1OVJ3NUNVd1dmUGdx?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 366a6a21-5dca-479d-d05c-08de22b62644
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 13:11:25.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CE1hek0yU4+di3wYBExY881O1UiYRJypc/JUuVh0VBzhSwCYabL3YlWs51g5IpYbxawXjtE8tmpnA206Ex8jKfj9ZjpeUo0VdprP7DMsB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com

On 2025-11-13 1:04 PM, Abdun Nihaal wrote:
> The link resources allocated in snd_hdac_ext_bus_get_ml_capabilities()
> are not freed on subsequent error paths in avs_pci_probe().
> 
> Fixes: 1affc44ea5dd ("ASoC: Intel: avs: PCI driver implementation")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
> 
> v1->v2:
> - Shorten commit message
> - Handle the case when some of the links are allocated, as pointed out
>    by Cezary Rojewski
> 
> Link to V1:
> https://lore.kernel.org/all/20251113104121.79484-1-nihaal@cse.iitm.ac.in/T/#u
> 
>   sound/soc/intel/avs/core.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index 6e0e65584c7f..f0d77f3f3a28 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -473,8 +473,13 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	}
>   
>   	snd_hdac_bus_parse_capabilities(bus);
> -	if (bus->mlcap)
> -		snd_hdac_ext_bus_get_ml_capabilities(bus);
> +	if (bus->mlcap) {
> +		ret = snd_hdac_ext_bus_get_ml_capabilities(bus);

After giving this a second thought, I believe 
snd_hdac_ext_bus_get_ml_capabilities() is the offender here - the 
function should have freed whatever its already allocated before 
returning an error, not count on the caller to free the resources 
instead. In other words, the fix should update the callee too.

However, one may say that it's a separate issue. I'm fine with existing 
patch landing as-is. Can prepare separate a change that covers problem 
mentioned by me above. The cons is: additional 1-2 LOC traffic for the 
avs-driver code.

I leave the decision to Mark, I'm OK with both approaches.

> +		if (ret) {
> +			dev_err(dev, "failed to get multilink capabilities: %d\n", ret);
> +			goto err_ml_capabilities;
> +		}
> +	}
>   
>   	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
>   		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> @@ -483,7 +488,7 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	ret = avs_hdac_bus_init_streams(bus);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to init streams: %d\n", ret);
> -		goto err_init_streams;
> +		goto err_ml_capabilities;
>   	}
>   
>   	ret = avs_hdac_acquire_irq(adev);
> @@ -515,7 +520,8 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   err_acquire_irq:
>   	snd_hdac_bus_free_stream_pages(bus);
>   	snd_hdac_ext_stream_free_all(bus);
> -err_init_streams:
> +err_ml_capabilities:
> +	snd_hdac_ext_link_free_all(bus);
>   	iounmap(adev->dsp_ba);
>   err_remap_bar4:
>   	iounmap(bus->remap_addr);


