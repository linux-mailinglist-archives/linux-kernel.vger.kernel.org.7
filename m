Return-Path: <linux-kernel+bounces-763897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0131B21B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099701A276C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887C2E62A4;
	Tue, 12 Aug 2025 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAVUMaYI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC22E612D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967907; cv=fail; b=RMBu3KslGTE0VMPpg1Jzi92nx4uAjIjIB6/ClKMkUris4WA6GKCJUYtgZh/37VsjvBMQ5PDGEJxYsRNJVbyfpflFlpC3pmMuO8iw3KH15Es4UzeS2kZdG2FAnwbFKuChP/9as8x0DTfjTnxoJUkCsTGivtE/HPaY0mpBJ6xkyJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967907; c=relaxed/simple;
	bh=1Yyr9Xqa7cL1Y4kjfXsHujsfcUbjdl2YtM67Lu6gSGI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hu6x8m1R8186piNz1uMnQnr1cVlcAs1xv/i0zR8bJhtacQSxXl/9Oekq/D+lBHYY4XuxXyEFUEZJbHkFuAMTRZxkp6TN+/KGcKP54Htkvu41FG+WczSmAHW71aeZg+j1KOR/ZjaSRfVXyVb7EMD4IEGy+l7xiUKl7+A5CZgJBTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAVUMaYI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754967906; x=1786503906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Yyr9Xqa7cL1Y4kjfXsHujsfcUbjdl2YtM67Lu6gSGI=;
  b=iAVUMaYIEz9pD2g9sAAGbJscmyodYbEgddrh19FRA3nGPbtyNMKsu1hC
   pIBfNswzh8iNTVF3fl9yxPTSNRQOonGt7p48e+3cGdXWO0rQwCxqerjeT
   tOCeH1HSHOWGeeohkYiwN5gsMWLNiKP3VMxd/GKjHZMPLZ/KRg5b6IdWR
   sBNAPFIxL8Z3VtUsithLeEgB6gs+39kftvFsIhOB8FNNBsSRTCRxkVdVl
   9qXygVe7S7yN1otEtux4MePP03PvH56c/8f3FVJNsh8NDnOPeKXlyOG2p
   HqYSF2M7ebsiXnMdTwmMfUFkCu8FjpzLaF9E5djzrBaIopSrrS+WZX0mz
   Q==;
X-CSE-ConnectionGUID: 1fa8rwKVSxG9wsCVpFNvWQ==
X-CSE-MsgGUID: 0Gz9osM2TyC+l+3ASgCLKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67939891"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="67939891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 20:05:05 -0700
X-CSE-ConnectionGUID: 123ODeMJRrOBKuz182cdyA==
X-CSE-MsgGUID: WDuhdDrXTNmGImSiqGYAiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170520288"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 20:05:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 20:05:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 20:05:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.74)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 20:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGDyqNzA+rGFibL+QmAXZgu5rv0Exe0xO+UP2FdydA2eqCtrqUnN24Vokbc2ruehe2GzFp5F0D7Cwej5B4ICn9TXl3gxgbB7jvQn9OUSX2pJsnjIk7OoMuyh0Mg+o+MrzjzAi1AKhz8I9xxhxrzZ4kz8VS9jpvRY2WjHEWA5A7PTjJ2zXJ4G8zZyKDL6qBzctUb9cri8yczICRjbnvZviqeBOgpYqzDfVGY4ns5cydRe/jtRzIquXlNaMFVdwqDFB81ULymg1Uy0wjOUl3nGAMFQbf/l62S+qA3dOMLnlHXm6w4GzEUhlvT3ro8qctXrcAGXyGSCtWc1LqoT1ACkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thrkny7zsaCtalZxXC9cMrCnvBRdGaBZMw3ufBri0m0=;
 b=qIpse+binnY/dWMZoOCmSZPfRR2EiF1Y+SKDXpfFi/NKXwAn4yo7VoV5bwypyasmFOCWkIKT8s3ukHDiBazckio/+oBSddxVl646dP+/MqEHMNaWb31I5F48qopnxfPnQzVTmsLfub/8cW4shYApuysGAqy/JDfQrgkdI4H2EEI6CPu9mwL8qYPrNDmS5ASaSotpRsvYW3d3pnpzD3aWKVGP21oVSbs6Nk/mvxlWBQYBff28K52ktd6z154uNKC/VA4kc7DH878cM7l8ZLG+vf1dA4K4RIoNDCsAXlfGPPM6lludUoHC4FOkDlukymZONDYP8nZRt3GwGtmBpOW7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SN7PR11MB7466.namprd11.prod.outlook.com (2603:10b6:806:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 03:05:00 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 03:05:00 +0000
Message-ID: <82cdc358-3551-4c8b-a387-0e9da4668b44@intel.com>
Date: Mon, 11 Aug 2025 20:04:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/microcode: Add microcode loader debugging
 functionality
Content-Language: en-US
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-3-bp@kernel.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250809094206.28028-3-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SN7PR11MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b20a0a-d228-4de2-fa22-08ddd94d06a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW5ZaEZzbnFFMnJSVmhzczFjK1NzakdNU0hZM0FZK2JEa0JCbDNhb0FjWVVK?=
 =?utf-8?B?VGg2NTJQQ1BOVDlvMlFQRkNHeXZQcjQ2a2crUnk3ZEo5bjBsRlRadkp2OHRN?=
 =?utf-8?B?ZSthS1BTQnorbDdLRi93bnZCeFJjOEdaZkd1ZDc4VVRLSStZRk5CV0MweVE3?=
 =?utf-8?B?Y3BtejU0OGdGQXhDYWl6Qlc4YVR1ZFJVc2JUeCt0TFVwbzBNd2JNUWx1STlI?=
 =?utf-8?B?OTZWOENXT04raWNySGJLZk01TXMxc05LL1RjaG9GN05MVXY3bEVQOVdrL21R?=
 =?utf-8?B?aTlwYlVIVjFiWU9saDUyUWtpY2grMGJvNy9aRzZhMXhWemdDdDc5eTd0UTdr?=
 =?utf-8?B?SFV2dnRESVFSdFQ3VEpRNVdnZmhhdEprakRod1JwU2d6VVNyajZxR3BpSE1q?=
 =?utf-8?B?MHRaYktFL0pZL05hUmMyeDhqQnl0R3FHQStKUGtCYzZHc2d6TkptcjBMRC9X?=
 =?utf-8?B?M1J0TjNQSEZ1N3FxeTNCbnFSalA4NndyZHBLMFJQZTc4dGZURjZSYUIzaTZE?=
 =?utf-8?B?VEN5UStSMk1JeG1FWThpK1J5YjE0eW9ZMkI0dmg3WTNHcWE4OG1nbktxc1VO?=
 =?utf-8?B?V1RwT0ErRncrTUR6dnhDa2hUUk1vRDRObmg1QkxuQ2xXbW9HSXI1RjNZbE9C?=
 =?utf-8?B?TlRHWGtFWkRvVWdXV2NvQWpWeDhFdzE5KzVnR01DMFZYVzRsZ3VGVjdpYmNj?=
 =?utf-8?B?WGc0MTdHelcyV3NyY09oYXY3VDVlcy82QVcwVllERmpIaVJteEtNYVFNQkN5?=
 =?utf-8?B?ZzRjWVZRTlp6bzJyL0RLUDljTDZOUmdRdzE1UXYxQm1lSWtMdG4zYzVFamRk?=
 =?utf-8?B?OEJSenNMQ2VWcnVsSlZsOFhYTEZPZzRxNXZIMFZTSC9VUTUzNEIrdmhmZ2xS?=
 =?utf-8?B?TkVTaGtvcE4vNVg3ekFwaUo5eHNhdCtFanlVYUc1M09NT1hNd2NEbVRhRm1X?=
 =?utf-8?B?K0Zyb2R4K2wzZTFQZDFZeGdSRDBEN2J3TEhSUlVxVVREYlhMRkpLdnIzZFh2?=
 =?utf-8?B?SGVOSnowQUV2Q3ZUQVRCYUdobHIzd2IxZUdCVFhUWjFFWjAxUWRSTUthS0dY?=
 =?utf-8?B?TGd2Vm9rUEhLZFByRTdUZzg3NlEvNWN5NXlHc2tud21kSkVxUFlWTWREbmdB?=
 =?utf-8?B?OVp1RUdvaGxnOHpoRzlaYTNOQXN3NTg5azVnTTZmSW5JSUttbUFhejExSzJh?=
 =?utf-8?B?b3BQdmtTTU9Xa2F3bnFGVzRVVXhkc3lFNjBqZlFCdVV4YzdDeEJyRkxMK2RM?=
 =?utf-8?B?TFpINGtWY3k1Vnh3dkZKYk4rV3poM2VDS2U2UVVhcWs2aWNtL2o1N3EyWGVB?=
 =?utf-8?B?MmpZRk5INnhlTmt3T2xJK0ZiejQvMGFEcm9ibEJiZk1PMU51MWtobEowUnlr?=
 =?utf-8?B?ZXJITHArZ1htT0Q5M0Q4MEpaT2NYMHZhK3FqMUZxTjNpczgrSzZndFBJTzVN?=
 =?utf-8?B?ZDRGSEdrYmNOc2NMdjRaUHZYUTFLSWlQZStlWXdTSXhvWlNYYXRsTDlEOWZB?=
 =?utf-8?B?b2tJekFWcUExZUM5L2o1UFVRd3o0NmFXK0dhMUlzaG9DejhHSm4vMWZ5VjlG?=
 =?utf-8?B?a1c2UEdPUjJrQVYyaGUvaTcrdjF4YUJhdmk5OU9qTUVKUy9rZWlicS92cDhp?=
 =?utf-8?B?eUtuYzJtc0w2cWJsRk5mZVdQUVlkRGd1YUFCUUEwNXdLM21rQzQ5dnMvaHFN?=
 =?utf-8?B?bEkwRWptOWduR0MxVG9wVzExbTQxWGJiNUJpcjVHaU5GZU9zUVBOVUxPS1VG?=
 =?utf-8?B?dzhLa1NoaXJMZGJpWUpCTGM4UTRaR3BuMkl1M05vTW1zNVB4U3pDcERzTTJk?=
 =?utf-8?B?SzVNWEc1QnBvRUc1aDRhUHh2T0dNRGJTMjk1cUNTekVWR24velNlVHJNeVVT?=
 =?utf-8?B?TE5Cd0NIcnhQeEthQWNHSXlCMENyOG56Unh2V1FSdGpoMklBT2t0VjMzOFhS?=
 =?utf-8?Q?W7mie29edJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2g2b0w2bWtaSGlycm16VjhoUm11NG5YS2FEbzMwWGQ3RHo1eVRJS0xUUnRl?=
 =?utf-8?B?NDVFNDhVUHZ0dk1vVUVZSXJ4UmhuUi9VN3RITHBTRmxma1ZxdzV4bEk0MEpp?=
 =?utf-8?B?T3NoV3NVeHBBUWwwNkMySk84NDdMVFBxMVZCMWh2YU9uOXhjRTUrSFVEY0Mz?=
 =?utf-8?B?aVVSYjZKby8wYVNDNkZDVVZjcXNpWTlkb21KNkZibkRjR0FSbzZ1ZVhrTEpT?=
 =?utf-8?B?bGlITWp4dVVBRkZqU3RRWjdKMTVZNjZtYUZlT2FkdUtZQzVJWDh4N21hNFNt?=
 =?utf-8?B?QW9SMCt5SWtNUURSc05lRm1Yay9jb1AvTW9ySFFKL1hHeHdTTTdsT295WjEz?=
 =?utf-8?B?K1ZhYm1yYVV0K002enhwYmVCUmQ3a1dNNk1KWjdMTUZDUjAyVE5TNDlkYUx5?=
 =?utf-8?B?QWIvbFcrSUd0WGNIMmhZVURkTTB1YkZWeFlGSDhQL1JqSDBpK3pCYThlVlo1?=
 =?utf-8?B?cUNhRHUyZHRsbW9pY3ZuK3FMRUN6N0c4Y0xjV0FyVk8yOVZTQWdUNld0SzdZ?=
 =?utf-8?B?QVhGYlo0anRDVm1Pck9IYkd5SGphN3dwUGdQOGNNMXRpVnRxODBmTXUvbVln?=
 =?utf-8?B?dXRpOEtpbElCMGs0TTNVb0ZqVmFiWENJam9TWTJWaGg0UDdRTlRmMHpqSlRX?=
 =?utf-8?B?N2FjbVhQTkxtSnZRQm9vMExUNGJadlh2cmpvRHJONW1PblZ2ZXh4OTFnZUc4?=
 =?utf-8?B?b1dJM0lyc0pyV3lLeGRvSzFxZXpaa0lYMVBzSFpIakpDVTJHQ05FUGVuZnFI?=
 =?utf-8?B?a1FWa0NGMkYwK29jWFJ3Vm9FUW80bEVaMlR2KytObUJScERpNElsTUV1NjVE?=
 =?utf-8?B?RnFtNXVJaGVCdW9OajlmNVhvT0xhenlKU3hlNCttZG9LRG1LNitGVStFUmNW?=
 =?utf-8?B?c1ZSbFBWaVBPdzZHSzNPQlBZb21QNGJLdmRlZEx6T3l3YUNWeEJBZ28ydmhB?=
 =?utf-8?B?RzJ0cERPN0ZZNlU0NzhkUDdQMUlmNmdmaUtsdGJCQmQvTGxLczdUL2ozcE1K?=
 =?utf-8?B?cjhqRWZBWDFodUZhSmphbEVrMkFaMTV1UEZ3RkIyQ0had3BXemJWb2wycm5s?=
 =?utf-8?B?c2s5RmNaeTBJZHVOSUdmNEx2eXVUQmtYdittNmNXaWRIQS9GOStQaURvUHor?=
 =?utf-8?B?aGNJS3dnUER5YjVYVUxSb1VXbXlYQnN2QVBXWU84UjVDRFlrTWNjY2FrdVVr?=
 =?utf-8?B?R3hPa3kxR2NLdG52dkxrUFIvOVdzM1dKTldINVlHTjUxem5pQTJOUTNZdXNt?=
 =?utf-8?B?enJrenNSYm5lbGVJSTc3VDM1U1l0a0VrYzRvVnc2dlAzWDBWY3lQd3lMRVFk?=
 =?utf-8?B?WHp0NnF6M3dHWmVCZDBlR0pEc1FOaUZ4RGxxTXl4MjR6bTg4S21UcVF4cEJk?=
 =?utf-8?B?ZVcwN3U2T1JIY0RkTlQweEtrRmM2NVhySFZMTms3aExMSm1XenVyRGFtV0hD?=
 =?utf-8?B?aHNlZEszeHkyS2JGY2ZFRzF5S09WNVN4WVptR0JuaUdheVdJM0ZteUhKdmZ4?=
 =?utf-8?B?cmNDTnA3aFNYMitVUEZwbzFWNG1LV0JMZnZwZDR1b2RTRWZJcU1NL2pxSWZk?=
 =?utf-8?B?aVVRaldqZ09qY3MxNE1rWlNvUlliQUZBV25LdzBUMXh0VkFreEt6WjNWQ2RE?=
 =?utf-8?B?SXZOeUgxL3hQU2Viay9DWkxHQTVPdUVYMWxPZ2FMdG43QzZ6cUNiamRSdVFt?=
 =?utf-8?B?U3RyeG42MDhFUTh5eEZpS3JHN3Q5STc5K1I4eEY5OHlSVVE2WWQyUVk5ZnZ6?=
 =?utf-8?B?RXZTMlF3Smpja3FHK0lpMTdwVEdxbHF1Y0VKZWJzZERMUDA1OGNtdzRESVFm?=
 =?utf-8?B?TWJ0eDJlVEJUeENsbWc1KzJTT0s4VU9HVUlEWThjeitEM2hadzRycDA3c0ZH?=
 =?utf-8?B?WmxwQ3M4SWpjVXRuZWg2eUpWRXZrSWpJbnBJTHNXUWhxWTJ6K204eUVEWG91?=
 =?utf-8?B?bUVmcXpzRUtUUGZ4eVVHcU5wc2h0TUtjL2s3ZTg2YXFuYktqV1lpQ3BMTmhu?=
 =?utf-8?B?UzVGRlhpRlBpY2RnWkxHbVM4ODEyQWZlSk9RV2Z1eFFnTWF6d2VIUmdWT1VT?=
 =?utf-8?B?T3J2UzN3R3R6L2J1ZnlJdE43NTc5bkMyZkZpbEhMOHc1a213ODAwSTJ1cDBy?=
 =?utf-8?Q?AQN2ADKbV4xh5uwhhWGmmhrJ5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b20a0a-d228-4de2-fa22-08ddd94d06a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:05:00.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cxWtCI6m/xuBNxcpA8qK1h9yrBPG416SJq1r5vYzYz+171kNuKSkeTysNdFefFgOJUUdyeaaBKYu+T37Xs9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7466
X-OriginatorOrg: intel.com

On 8/9/2025 2:42 AM, Borislav Petkov wrote:

> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7c095177da85..fc002b1a9f57 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3770,6 +3770,13 @@
>  	microcode=      [X86] Control the behavior of the microcode loader.
>  	                Available options, comma separated:
>  
> +			dbg - Format: <bool>

Since this is all new code, would it be better to use the expanded form
of dbg everywhere?

s/dbg/debug/
s/MICROCODE_DBG/MICROCODE_DEBUG
s/ucode_dbg/ucode_debug

Also, I didn't understand the "Format: <bool>".

Isn't the usage similar to force_minrev? So microcode=debug should be
enough, right?

> +			enable debugging mode when run in a guest
> +
> +			base_rev=X - with <X> with format: <u32>
> +			Set the base microcode revision of each thread when in
> +			debug mode.
> +
>  			force_minrev
>  			Enable or disable the microcode minimal revision
>   			enforcement for the runtime microcode loader.


Slight preference for a tabbed description:

	debug
		enable debugging mode when run in a guest

	base_rev=X - with <X> with format: <u32>
		Set the base microcode revision of each thread when in
		debug mode.

	force_minrev
		Enable or disable the microcode minimal revision
		enforcement for the runtime microcode loader.


> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 58d890fe2100..462bf03aeda5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1360,6 +1360,18 @@ config MICROCODE_LATE_FORCE_MINREV
>  
>  	  If unsure say Y.
>  
> +config MICROCODE_DBG
> +	bool "Enable microcode loader debugging"
> +	default n

Isn't default n redundant? I am fine with keeping it to make it obvious.

> +	depends on MICROCODE

Should we also include a dependency on DEBUG_KERNEL?

> +	help
> +	  Enable code which allows for debugging the microcode loader in
> +	  a guest. Meaning the patch loading is simulated but everything else
> +	  related to patch parsing and handling is done as on baremetal with
> +	  the purpose of debugging solely the software side of things.
> +
> +	  You almost certainly want to say n here.
> +





