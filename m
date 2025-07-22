Return-Path: <linux-kernel+bounces-741138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568BDB0E080
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBB97A43C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027B277C88;
	Tue, 22 Jul 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsB201h8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB8275B08
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198274; cv=fail; b=YaobrTToHubZH7/rO77YRKjy5uotuQ8YY3OxOB7bgCSVVFJXkBUj5mgxMR8mt5Bh4wvhCF3bkWcGoC4TwtdPbJmV4kcruJI4nMlyb/oh60xxTeClulP11PGGW2a7t8NozpPL5PrL/x0lQTr0c9o0RsInR6XD2aF7KUJmKaZ3ls0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198274; c=relaxed/simple;
	bh=z7gsl+GvBbxLRd7Rfimv8zH/f67js5qQ+1/jb6YmoBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uIwTIdNmdtCv6YeC2TeLk24pDQ5zkSCd5w8LTgzHnTm7UalRnzMuCopl6/5P/y9a8yGRWwruDnAU26izN7eb4u2c5yE/xa1dfrxUZETsXyR0n8lJujN8+YhdZtL4IhRZrsxb5jdslA7w+ZftLfXUfI7enuwM5xYFdSOKI7SYwdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsB201h8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753198274; x=1784734274;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=z7gsl+GvBbxLRd7Rfimv8zH/f67js5qQ+1/jb6YmoBU=;
  b=TsB201h8JAfZ/ezsf/R87zSR3bhLA5fmokFcFgecAyUuFTORqGtxLxyO
   vWw4VDjCdCesZrAqe4FLLnRPcJaeAcokm3hRlaVZkCuYzR/zcZWpfeiTs
   NtY/+vVab6pOpkaNqTgvn+02+fACmiQTiztwfwZ6eW4IKW0nelfXaOWRU
   61LU5txfKVWspiApJqvIiaq7P/MB072aX1nmTqyoDfwwpKMx6VakaQYQM
   +DKX+z7reoLwcTDCqaMO8G4uLxqUkwO6nC090d3QNN8iUsztK/4p8He5k
   YaJ9OpmejFJhMHBmuITlssV6xc/CxMR42s82a8okhEDZo/ieMx+HXn8KR
   g==;
X-CSE-ConnectionGUID: cuGIYsSmQmy/sqqOgQ3kDQ==
X-CSE-MsgGUID: a/4ea7+6Rve91kzrJUPWpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59113276"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59113276"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:31:13 -0700
X-CSE-ConnectionGUID: OA8hvk0zSWKrMai0PCkqtg==
X-CSE-MsgGUID: WSX8zBUzQ2qqNOYOQME69Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="158846705"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:31:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:31:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 08:31:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.65)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 08:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clD9mfz13YHBzsVQC04VkQ8C4DEDdlQyNl7hXJTi15ATdYzvrU65k5pDL29FYx3pfQ0iVz88KAcOVMcuOgzmkYHhCmedmNh6S8tl3Rl+z56X/3OJL5+/SRebXCKiTOQvn21zeJKcKnfTgtluV2O7WGZEN4A59jATCbA5xohcbMGrcS9kqlwYpwFtkxpvgpI9/IXFRP/Y5jnwFOzH/Hz06dmkInG/kKBZrWz+eJiAwb1x+cUAGExsh0sxO9BQXoVsfMb4UUD2BvsaPdwlocLOw2/I15WBz8IHwsCwLKH3Iia2ScZ8byJo4NdAyED38Q3S+WeRvhh4FFjJ4wg+c2InBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knijsq+12WKsIseQIZ1210oQI6A+e7/+N1vft0OOdSw=;
 b=qufGmLHgnIqWP1bGybfPD7jh1ywVuW43DfZ6EfHISuKsfyeuEWl/DMHkKxSNxiPF3eEtZU4Xn3obnfbiU2cwWPNTPMMjciGsTpBnFvtmixgQrDtC2zKF+14NuksQrs2gJY0YrucBagVHG2L2SgAdZRZBqLbM4AOws8pVhsZFA4RW5BzGGcE/hi+YMhz32BtVWPwKm40NIrRXcSseJyxZvJYBe3ejThLikoPpY+RjC/mGQ4kNOe2NKQqKM6Ee5oE9aI1AKCbyhcDYevTmvpVE1SKWgOWpsRxiTyGXEftyWkyPgOeddJzojFvCcuTAncndLI6tAseNZJL1SxE63b7BgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by PH3PPF6CF64E2E6.namprd11.prod.outlook.com (2603:10b6:518:1::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Tue, 22 Jul
 2025 15:31:10 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 15:31:10 +0000
Date: Tue, 22 Jul 2025 17:31:04 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Xin Li <xin@zytor.com>
CC: Gleixner Thomas <tglx@linutronix.de>, Molnar Ingo <mingo@redhat.com>,
	Petkov Borislav <bp@alien8.de>, Hansen Dave <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "Anvin H. Peter" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
Message-ID: <qvnda66iujv53bhjnhdtnkb2w6aq5fh4shmqmrxq7aaqjmdcx4@yav323c4bcns>
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
 <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|PH3PPF6CF64E2E6:EE_
X-MS-Office365-Filtering-Correlation-Id: fea5372b-24d2-4602-3181-08ddc934c8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlNUL2NncVJxRmJmSXVIbi9wWEltMVhsUk1obTJPR1JDR1EyMjFQMkRSWXZH?=
 =?utf-8?B?QnJySE40SEQ4VndjM0IraDdvSlNhUGZMNlllTHkyckxBalFNTDhqSHU2dmVL?=
 =?utf-8?B?MiswRXlSZWxWV0RoSEZOS3QvL00zZC92QS8xWXFtTnpqVXB0Z3RWT2lEZEtw?=
 =?utf-8?B?a0JSaDBnb2kwOVhLZ3pWUEJmSVpjSGZYazVReWFFSFlIdDR4VVJUalBudGpm?=
 =?utf-8?B?OXlzOVFrV0VuelQ1LzViSktLbjhpOEJ0bUdmQ0lOWFY4QmdkYkhkRDJ3RUo2?=
 =?utf-8?B?aEQwMFhQallib2FCMFJmblBXZDcvY3JBWVI0MUs4bnRnYyt6SkpCOWorWS9S?=
 =?utf-8?B?b3BVdHFDTU5DeTNRakk3NEFtSHBSc0VJSDI0eldrb2JhZmtxblZic2hBcnRl?=
 =?utf-8?B?YWVzOUg3eDc4ZnZ2dWZFT0dGUlMyN3lKWjluaVNyU0VBT0JyNXBXb1RnalVO?=
 =?utf-8?B?cG5CbFplOUYwd1lkcXpyT2dLUDNhUkpYWWRGNUU3MVRSWWliTU1GK0RhNFZE?=
 =?utf-8?B?OWJUUVRmdVdvU0JaVkhvQkwxN0VqNTJHL3pQMklBbVpjcWdTK015RGp5VVoz?=
 =?utf-8?B?Nk92SFJOQXBBTU53UmxqTXhvc2VzbUVUL2piM1NhZHI0TmZPUnNWSlprcFVR?=
 =?utf-8?B?OUVadzJDM0p4VHMxZGRyQVh6K2RjWk9ZaENUNy9ObTdPVHl5dzdKU1NnYVJY?=
 =?utf-8?B?UUUzSk52OUc4UEY3T0N0a2VVd0ZnRi9iaUltNVozdW1MdWNsVkw4dFl6NHBj?=
 =?utf-8?B?b2tjZTlicXdQR0lDRGJRRE9zdEM4WStJSjNsay94QmVacUc3RG93TXFYcGJu?=
 =?utf-8?B?a1lwWmJhRyszTVUrRlloNmpndmVrTUpFaVJSZVpmOUNORFloYkFiL3Vpd1dz?=
 =?utf-8?B?NlplaW9UWlRiQzZaZWtJTXl5U25CRVlwWVlNZkNPQ3BkWEJlbWRwYm1kNUJC?=
 =?utf-8?B?cUxPQ2JOUE5XeCtjbGlzaW1XTDBTUUc2REM4b3pWU25uRTlTKzBBSGl1eitC?=
 =?utf-8?B?VjJzZ0R4aXhjVVFzUzJOR0J0L1NuNVpmSU1CV1lpQ2N5dmw0SjI5eXNKOW9O?=
 =?utf-8?B?bC9PUElZZ3N1cWVrU3NHUXM3Lyt0UVlGd0VpOHhpQkZELytWTDNiVkQ5SU5v?=
 =?utf-8?B?N0JyaHpPOERrL0ZqbEYwdnFEWTNzdFdDZTZoa3NESWx6VWt2dklKcE5PUWY4?=
 =?utf-8?B?L2NLNWxIV1RTVDFRQ0xVY0tLU3RiMGNvN05HVnlOZ25LOVVISUN4NkVrL2Z2?=
 =?utf-8?B?cFNwQy9ZaWtaL3V4M1YvTmJETVR4VVJNOXFkMDdXZWhSb0hpMWV0alZYR1o1?=
 =?utf-8?B?a1FYSDNQaWdlOWJqQnEzM2JwNDRKL3BrRk94blppMG52WlMxendSblRsWFEx?=
 =?utf-8?B?bTF2S1BYSWhqb3VqaXIzL3dpbVFtMEtzallHYUF2Nzg4UnVPY1dFMG84aE5Y?=
 =?utf-8?B?dHloUmsvS1J0N1hkdFp2VFJ6a3g5enZ5UzJKaUw2ZmNIL21Ga1BnZ0hUYUp1?=
 =?utf-8?B?RWczMk10ZWVWUGdiaGh1RTBJVjBTSFAySElZYU5NRTBoTGRoUHZjdTV0ZUI4?=
 =?utf-8?B?ajhxcDlSTHpQeE5CaUNBRGN3QklTTWZwdmxoK0l0Y1BZRTlWRWgxNmVLVmdh?=
 =?utf-8?B?OTZQWG1XQ1c2NEhPK0xuRE56anVYckZSdTY4b0Zjd1ByQzAzWFlKb21kKzd6?=
 =?utf-8?B?eUpyeW1jOWFRSUZmVHM2ZVhsb1VmY1l4dlNCWnJRZ3JkWjlQVHd4eXlUYVB2?=
 =?utf-8?B?MnVDWTkrZStaSzdFdjVqTG5tY0lERFAzU0s1WGpiZzg4NDNjKytoVXp0aEtB?=
 =?utf-8?B?YTFtcE5GMG15NVB0TDZjUStBV2hzK1BKNHJaOXY2M3crb29PalgrMjRKSDhR?=
 =?utf-8?B?VnlRUnVSZU10MERSNmxiT2xvUDNISFlDdmhoNTFuVFhQVy9XVHBCdnFTUHp5?=
 =?utf-8?Q?GuMX38uR0qM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09uSkdVVmtuWmNSa3haakZEZ1dkQUV4T3d2MEErVHpKLzNhR0dwOFRCTmds?=
 =?utf-8?B?THArb2UyMzNuOVE1dkRpYkFDVll1bDVqeTJVdHRMYUhsZC9PUlQ4dE84WERV?=
 =?utf-8?B?aW5OWWQ0c01tS1ZTMHJpR1F2ckdPU2JqaHQ2ZGxMZDd3UHUwNnJPTkNmUFNi?=
 =?utf-8?B?Z0VtMGordG5FbGNuZUI2NXF6aFIxL1J1TVdIUlZhQk5zLzZ4alpMVW9KQzRo?=
 =?utf-8?B?S0RKczBCYXFPekpNS3prSUxHemU4NXVBNHV1dXdwUlM1Z2xFUlpRSi9XTVdZ?=
 =?utf-8?B?TnlGNXhrTmZYbm9NRlFRMG1KTFYwcWJad2UySzZwbzhUSytOeFpDUzg2TTdS?=
 =?utf-8?B?M0k4bkp5ZUhRNHFoRy8rN2pTUFBja1BuN28zV1pHa2prMm1oc29FQnZVaVUy?=
 =?utf-8?B?aUpzQWJuSjVSUk1Qek4rUXZWSFFDeGhodGFKNU1jdlFFUWpOWFp0bjZ2MmFq?=
 =?utf-8?B?Lzl4NzdRdWl2bjF4V2V4cmQ0TlJtMnNRTWpOa1Z1eTdPSGJMZ3JiYjhONzQx?=
 =?utf-8?B?dDcydi9tL095OUZwbWRDNFhpVzhqQlZPUy95VHR4MWE4S3o0N3p5WkV0Ym5F?=
 =?utf-8?B?K1k0UzRCWkdXVFgrSHo1Vnl0S2lqL29aQUM1ckZ0VnVTVVJ6Q0xlVDYxUGZU?=
 =?utf-8?B?U1V1dGtnUmFmbTZSM29CaHNueUo2MEFwMUJ6UEsvMVptVm93eUlDODRqaEhl?=
 =?utf-8?B?UDc2N0FQcE1RV1laekFVRzdIRm9hcEJLV2VqZDJTTXpGenVJNXFpUzhScTF6?=
 =?utf-8?B?STdoTHA4dDlSSXdzeXZQcEEwRzllekNpaFl0L242TXc5cnIvdWVoTVgvczM2?=
 =?utf-8?B?ZU9iNlpFcUhoSmliSFhSM2NlaDNOSi9YK294TU9acTZFTW5oaDN0MTFTbWpj?=
 =?utf-8?B?enRhOW02cHh4OEpoeHRxOTZ2cHJzeEZQMEw2NzRpRmtRbExXSm5GM1FzQTRM?=
 =?utf-8?B?aGRUQ2lCcm9TK0hlLysydXhQMlM5V25qUEY4bk5zN0RUKytmb2NPQmdrQzIw?=
 =?utf-8?B?WHR1bEFMY3V4cHpxaU5ZK3ZadmNDMENyeVRReTVuNFF1dnV1NGxsQTBuWUwz?=
 =?utf-8?B?alRyZzZSbmhpckt6Y0ZwUWgxcGNKUk1GRjAwZ1BKZ2lONDJXM0YvUmxwNjZj?=
 =?utf-8?B?eUNsaDA2KzhQdHVoVSt1WDFzSmZzN1RCS3h0QXh6bHR5Rld0RGU0MHVkOHVr?=
 =?utf-8?B?WnBOL0FmOTg3SlRkTjlUejRGV2J0a1Y4dzlhR095VHFyK2g3U2ZRZHVoUlFv?=
 =?utf-8?B?OXFhWHVMK1RjYXJhVHhOTGNyUytmSjZlYkpVaEZnY1ZaVEZVY2VhTlJIYWE2?=
 =?utf-8?B?bU5wbUYvVWtYVkNWelZyZWdXS2RscXhWSUpYRFZJczFlcjVTS1A1V1pCcnJI?=
 =?utf-8?B?cm1FRG1GL003QUVUdEkxNi9DS0c5aWQyd1plNGpKTmJPRU40L0FGVlREMmhT?=
 =?utf-8?B?Zy93aURyRG9LcXlvUlMzNFplSmxNb2lkWVFSak1tVDZXUzcraFpjSXBjK2NQ?=
 =?utf-8?B?RTZ5WjVxektFSWxpQUkyMHYvRDZsb3pqeVBBbW5IS1lwQnlXTHUwdG5lSXFW?=
 =?utf-8?B?OTBadDRNQWtKZ29IVUE2bFpsT1AvcGhOb3hub252elY5ZFFVcGtDT2hZR1cv?=
 =?utf-8?B?dndLMlE3bWw1SXVMRGhuZUM2elFhcFhXeG9wNEh6RlJGS1ZNbnMzVkZIeVhq?=
 =?utf-8?B?UC9ZZVJEQ2h0MGhqNy8wYm5xVVZjTnlVU3gwa3hjdVVaODdCeXluK1pSazBK?=
 =?utf-8?B?aWVpSnZ5UlNzS1dVYWJsMDcraU9CZTZBN0FFNTRtS0MzY2l2SXdkYWovZzNr?=
 =?utf-8?B?cW40T0hkQWJCbU9rcjI4MEZPb2lTQUNIVmVDUnhTMEZ6c09kYVFWYzZ3Wnpw?=
 =?utf-8?B?bWVLT0NNT0tGeXJrVnJOak1HRTVZMXR5amdxMGdBVDhzRFFzc3UydXFPb3lQ?=
 =?utf-8?B?M3UrdWZzU3NteTNiTGhLVXZiOFFtS09JY3J2aU5HK0Q1L2tPUytKZUFpby9v?=
 =?utf-8?B?WFlrYi9lSk1jdXBqQkZtL1V6L2ltbksrcytiV2IxaGVuVDhaclovdmV1ckh6?=
 =?utf-8?B?b0I1bXhoSmtJb2hldHNWeU9ONEZGVnE1dmtuajNKaDdqUzdGOU9vd3lNMGhI?=
 =?utf-8?B?S2lyZ2dWeFlTeXpsZ2RMWmJDNUNoSEtHV1oxWG9OZjQwMk9sM2orTEIwbDNT?=
 =?utf-8?Q?cAE1Ur7E9z90MZUjy0HKN3g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fea5372b-24d2-4602-3181-08ddc934c8ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:31:10.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2E6FVNy+Y4uZb8m+uzHpyqwUtaDX+pn7xs2ZULtRGk1LleOpgTGLa20i83n8q+Uwdt24UCHak8g1jw89PhEoWHIdnLUUgIReBWYvzBjpEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6CF64E2E6
X-OriginatorOrg: intel.com

On 2025-07-22 at 02:08:28 -0700, Xin Li wrote:
>
>> On Jul 22, 2025, at 12:54 AM, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com> wrote:
>> 
>> ﻿If LAM (CONFIG_ADDRESS_MASKING) or FRED (CONFIG_X86_FRED) are disabled
>> during compile time, they still are enumerated in macros such as
>> cpu_has() or this_cpu_has() that use the x86_capability bitmask. The
>> features are also visible in /proc/cpuinfo even though they are not
>> enabled - which is contrary to what the documentation states about the
>> file.
>
>I'm curious how this bug is introduced with my patch set that adds the
>AWK script which automatically generates the CPU feature mask header.

While your patch works great in setting up the DISABLED_MASKs, there is no place
that would read that mask and clear x86_capability bitmask. Most other features
seem to have a call to setup_clear_cpu_cap() somewhere, or they're in the
required bitmask. LAM doesn't have one at all, and FRED only has a kernel
command line check - so no compile-time support is checked anywhere.

>
>> 
>> The documentation for x86/cpuinfo.rst also states how to handle features
>> disabled at compile time:
>> 
>>    The kernel disabled support for it at compile-time
>>    --------------------------------------------------
>> 
>>    For example, if Linear Address Masking (LAM) is not enabled when
>>    building (i.e., CONFIG_ADDRESS_MASKING is not selected) the flag
>>    "lam" will not show up. Even though the feature will still be
>>    detected via CPUID, the kernel disables it by clearing via
>>    setup_clear_cpu_cap(X86_FEATURE_LAM).
>> 
>> Clear feature bits if they are present in the DISABLED_MASK.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
>And we need a Fixes tag and CC stable.

Ah, thank you for reminding me :)

>
>> ---
>> arch/x86/kernel/cpu/common.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 77afca95cced..1c5af795cedc 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -1782,6 +1782,16 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>>    if (!pgtable_l5_enabled())
>>        setup_clear_cpu_cap(X86_FEATURE_LA57);
>> 
>> +    /*
>> +     * If a feature is disabled during compile time clear its feature
>> +     * bit to prevent it from showing up in the x86_capability bitmask.
>> +     */
>> +    if (!cpu_feature_enabled(X86_FEATURE_LAM))
>> +        setup_clear_cpu_cap(X86_FEATURE_LAM);
>> +
>> +    if (!cpu_feature_enabled(X86_FEATURE_FRED))
>> +        setup_clear_cpu_cap(X86_FEATURE_FRED);
>> +
>
>The following code will work as a generic fix:
>
>	c->x86_capability[i] &= ~DISABLED_MASK(i);
>
>And DISABLED_MASK(x) needs to be defined like DISABLED_MASK_BIT_SET(x).

Thanks, I'll add a helper for that and put the call in the same place this patch
changes are. Seems like a good place with a lot of other setup_clear_cpu_cap()
calls.

>
>Thanks!
>    Xin

-- 
Kind regards
Maciej Wieczór-Retman

