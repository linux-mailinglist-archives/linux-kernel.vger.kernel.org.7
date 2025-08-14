Return-Path: <linux-kernel+bounces-769716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F6B272C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF70A5E71A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93C8287505;
	Thu, 14 Aug 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mzy48dNp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6972857F0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212945; cv=fail; b=m4pPj4pMOCrwzOkfTvjNS05ZdN8a/3jrVSq1PRw6Rm/MU6px4o4DE7rK++XkH4ivSNAyV1uQu/nOjAU7eXQGHDX4lHsPSTLJlNTA9MMT0i8QupXRn+ZYekPOwyiOANBpeSTMTdBG9kZTTIeCgQLPLqMP7tN+YCCY3dYRd2yps2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212945; c=relaxed/simple;
	bh=bg1vjagk7+bmRiMYf0LvC+Ma/2JhYSDcu1NHlWTRqcA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a1vLhR+Rm5z8Qi4CUH4UgTATZFKLwy8mUe5iMgZ1gOl8Fm19f+Nq+BjIdgmBfWpsW0t7R/ZGxQqK9BZgg7YU1/MadJ7ikXD+BAWPkvr/JhyALJQmNerUAEcgO0BKWZ6P3lk1Rdjy11nN7mpSiFftNXaEc4VQOkjmW3ty7qcBGdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mzy48dNp; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212944; x=1786748944;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bg1vjagk7+bmRiMYf0LvC+Ma/2JhYSDcu1NHlWTRqcA=;
  b=Mzy48dNpCnpHffltHkgKgF5a1z9JutvjsboAlBbuPOKNMuRkd89KikAe
   2ArvTP9x3QDc0IIs9jHTFzFDjq12Jt6eZ/GNO1pys0Owx9HLmm/5VqRbp
   T369rErN9SdNbqG3Nzmgs4N3qI4UKf0whwAMnqjZk0rRnGGf6Uu+FmfHF
   1T7j+6XmofySttsupNGvL0mJ7u52JMt5+OS79ZC6lGyKALyWBNBcgS/96
   c4LxiX0QNYMNexhgkACpgRa3zPc/vN2CPgV7y6aKsGP7Zp/FvPBSk9E17
   BUHWIEm3z1j+7qYKAacH53lhsuSSUWSRxEqlt9iwjbb//FzBt3QuzJBsa
   g==;
X-CSE-ConnectionGUID: VrV4S96fSQmNtmoeoRo5+w==
X-CSE-MsgGUID: wPoe5pYGSLilysTCyaYTuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68624616"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68624616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:03 -0700
X-CSE-ConnectionGUID: s+4/WJXlTDyf9d0i9qoZ4Q==
X-CSE-MsgGUID: 0ydq02UASGuJZCU5l0CL2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167231845"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 16:09:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 16:09:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.48)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 16:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq+pwAQ1jKXo0UmqZoKkxrx7UqyuNLOgdutwCbDeSjjL2LhET3pt0x0GY2PILijKmlbaVbSp3WdBFjqUz/OSiVG3y4aCOPYCCgZJhosHNdlrSBYFIMxKIhUMbQ5VwQqPvL99dC0iOW43zVwOsprM1AJM+wS3kLfRluem06TKQBVWRPd5GKnAuwEhJAr7P9ebK9vcaMk0c/3lVpOi2bEEzZ7W5xSSUZwy3aE4HWwWuC4WDHCpWelhr29uHgHG6FE3f4sq1bCWlmAep0sNVlxP7d53iMqYQ/sa+nnCGDLOXI5pPqqRYbuzl6JDc7t3zm3bHdRCHNidOmZbOPon4B6aKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4/o4koi+OBO4BbwERu3/v1pwMHcGhg4SteO3ylaPUY=;
 b=kfYcjlsFjYTFeOYMsElwbWZ6Fjl/k6rWT1x/3xileEKYaiVv4jyQnzK1RL8vMMr/3u7mn3sl8H9EVPGcru//83fcZsA79a3vEjIcWMHW+6R8d5XQurvpMqIX8P8FKF/0Eg7Ynl1lG1tPrK0VXh2nqV5ymyIrDu1QKXttsfRKSio6Uc/WMFi1Ms+0cvnHHfyftziGagcDpKyawP4Lc5v4pFDS1+tvlAdyjmTd4xPNo6OlK0ELjEdpw6AJwD9X/mnq3gE2fCEzDik388YeBtxh2vKweu1mbe8PTGQvD3Msa8+lvkJpux4E8KJbnxHpENbvboA8biFze4Yty3oxvQa8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 23:09:00 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 23:09:00 +0000
Message-ID: <6b345bdd-d5f6-4967-9f2a-15c2d371ef1b@intel.com>
Date: Thu, 14 Aug 2025 16:08:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250809094206.28028-2-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SJ0PR11MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba26a4b-703c-4ab1-7e91-08dddb878d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHJCMHZlS1h2NlVxZjBFTlJBaG9aZ2VoMy9UNVJQU2JtY0Y0UlQwU3ZJZnlF?=
 =?utf-8?B?SmJtL3pydGdGSkRzcGdPWHA0b05jcmhDOGRmT2hYRVh4b2kwVnYxZy9sTHRM?=
 =?utf-8?B?ZE5GNmxHQ1NxWlhUMXhaOGxxSVhBa1hyQzVYam14QTdFNnhGTlhvWDBSYllR?=
 =?utf-8?B?Q0U4ekI0UVVPL1lIYVdaYTZLYkFmcVVCVG5qbnRSQXpXRk1DZVBCQmlRSEVI?=
 =?utf-8?B?cjIzM1NjRDRzWUF4MkUrd3F5QysvRmZUbWYxMEE5VmY3SUdhc056Yno4Uzll?=
 =?utf-8?B?NDZsL0RsTDVuU1l5dkVLQ0EwYmJEZ1IyTkpXdytOR2lZeWRGMWlFUEZKS0tm?=
 =?utf-8?B?UkRXUGVmenZoSTdFcCtiVFQzQklRTFBhMnZmdWI5amZZYzBpZGI4MW83aURa?=
 =?utf-8?B?ZXlPak9Cc2QxVU9ISEp1WVZyNDFLNUJvS2Evb25VOGhxbGtFcCtYKytSMjU2?=
 =?utf-8?B?Q3p5TlNWWVI0MzlCa04zSFA4QkNJdEsvN0xyTXZlVUpFd3JpNy81WnlEMGs5?=
 =?utf-8?B?WkNyYlNTWDJYQ3VDaERHNTNxK2QvOTcyTThWc3BFaFZzbWJMaEJrbWl0Unps?=
 =?utf-8?B?UlBEWGVZU29SczJnN2xHZkJZeDNwVFNwaS9BRWozQWRoMEI1bzcrZEpVV2NY?=
 =?utf-8?B?eXptTytaMlBxMldvTnFHTXczdy9WTU9MQ2JtNDZyVCtmbWxpcmpIQzdoWngr?=
 =?utf-8?B?dHMrU0tLejZBejk3QTBqblVnU3NZbXJ1dHFUOHV5NWY4MHJEUnN6TWx5MnZz?=
 =?utf-8?B?ODBLdXdCZ09JZzczVFRkWnB2cGN0eitsSXA5a0FQRzluSWNLRnB1a0FHZzhy?=
 =?utf-8?B?YWxGdjlsLzlxN2xUTTFOSWE1RUIwUmk5QU1wNzhuOUhmTDIwM0VkUDdQVzkw?=
 =?utf-8?B?UzlFaVRYd042MmM0WGVEL1ZWMnZQdmp0SGdKQXBHTTIwYXBhU1dud0QxREVB?=
 =?utf-8?B?dmtTN09nQXhLdzVSQUJXSTRoVVllbGRydmtjeWpMaU1XKzRxN0Y0NmttSWtR?=
 =?utf-8?B?eExlaFFJOTl6d3VvNE1kajlvRElPZTFIMjRtRDgwQ2tLV09IYXRLUG5xK2dr?=
 =?utf-8?B?UkR1RXB3bXNyOHdET0JPMGdjRjlCSEI3UGRCMEIwZXE4bWwrbEw1eDlVRGxp?=
 =?utf-8?B?M0JSd1R5YzBqbUhoWlV4UHdENHBGaXp2SU1nMHFXQnRNOFJ2cmFnYWgyUlpH?=
 =?utf-8?B?aDNocXJsc3R6VWRGcGpSemFqR2c2UmZRMHFnZ2VnUVV2anVrMG9valY0UERa?=
 =?utf-8?B?NmtxUkR5RWhwOUduNHR5a3hjY05sdEdVTUczcXRRQWVmYlluNzlSRWFiMkgv?=
 =?utf-8?B?aGpOR0tlai9Yalg2bnRQb0NiYlpiU1NpTmF1bFY5MExCb0RhRUFzM1RMZlMw?=
 =?utf-8?B?MDFsSUQ1aVc4T1QrS0Fyc0YrSWptNXJnSmJ0czNmWHdRcU5yeTZJYXkrS01O?=
 =?utf-8?B?NUFNdFlQUW9QUGdxUFhxS2RQNkxXNE5TZXY2dWJVSXRKMCttK3RCQmVNQXZ6?=
 =?utf-8?B?Z2ZvQS8yWnBZWGQxcGMrbFVjVUdVUjBialA3enNoM1pKR0VnQXJzNWs1dVV1?=
 =?utf-8?B?dFNySVdIOVBzUWlNQTRXL1pWVStlWE9kcTdqUDFxM1dJdlhjUnhzajFZQnZX?=
 =?utf-8?B?cXNOak5YRjJadDJ0R3k4NjlnQUx1c09lNUtMSkZNNVplMVlxdHFQckd6VHBK?=
 =?utf-8?B?RVQva09mUVBSTlNyT3RsdE5zVndHNDBFbGYvRnYvall5MTQ3dThBcDRzZGYr?=
 =?utf-8?B?Y3JrNHY2UmxoUHRKZGNlVG9PdmRURUpCMzMzUVIrVHFrU2xnVlFSMnhJNnBW?=
 =?utf-8?B?VnUvbFQyODlVTGJwa0l2M2NJVllxUlJSc09LUmxJcE81Sml5SWF2ZE1qRTFL?=
 =?utf-8?B?Z3p6OTczQWdXWndnZTFlWjFYMkk3ZVpaeVdQRlZCWVRmOTloZ1BRbmJxdG1i?=
 =?utf-8?Q?vOCrXRybIb0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk0rc1hQeUErWC9jNW05UUtHN0VPcHVrL1paMFE2aUJyWWtsdGZ2QTNkbURO?=
 =?utf-8?B?WCs0QUpQdTY4MHZKQXc2UEFKb1I3Ujc5VGIzS0xrTmVJaEV6dnhha2dLNkty?=
 =?utf-8?B?eTMza1NMU3k0TG96MTN4cmt0OEQxTmtFVis0VE9JRkNUWG5qRlp4TVdGMlB2?=
 =?utf-8?B?U3FVTUYyV0k1MEJPekZJVGJhTnlMdlJvOFZGak96R3pBOEozMnNWRllMWDVK?=
 =?utf-8?B?WFRVTEdCMFJtLzBtdVI4RHFjWUtpdVlPQWpBYWxpemxCZHAzUXBkaUVMQVc5?=
 =?utf-8?B?dC8rS01pU09EeGpSN1FWcUdwdXV6ZENEYlI4eHJBR0Ria1ZZZStZZWtIbFkv?=
 =?utf-8?B?bDRzTXZZbVJpdlI3WU9aN3ZFSU9uWGd4eWMwNGtQLzVuWEFDeWhkSXpib0Jp?=
 =?utf-8?B?RmZMaUlEdENRNEEvZjRmNkJJK2RMYTREclJvTnExZkUwSms2NXo4QjlqRVRR?=
 =?utf-8?B?UVY0MHBHV0lNdGpPbFBCcUhBbGtxUkVHdmM5S043R2NsTGJ5THZoL2hiVkUr?=
 =?utf-8?B?ZlpwZjIwZDJHWFVNTU9CS1owN0dXZTMwU3FWN2hHTzMxcHYxWENNZUYvN3JF?=
 =?utf-8?B?bTRYL2JLOGVGclljWWs4dVV5UkZzMEQ0WG5GcmJmK0duOWJuVjRHNjNFSjcy?=
 =?utf-8?B?eHN2cDRlMUZEb1pnOW1JSVBMR3d5djdCU1QyMHF3OWZlVnVJMGtXZFBwOHl1?=
 =?utf-8?B?REJadXZqYkU3cDZLT0V4WVZjM1pjL1N5SnFqOC8yNDZSekU4bFQvWWpEVk9S?=
 =?utf-8?B?dzVKMyttanptMS9ORUg2T1llenZKS29OYzF2NTBOOS9vV2YrOVpvbk1BQW5S?=
 =?utf-8?B?Q0I5elQwM2Z6VDBrdmhvNkorbEVnQVFjaWtlSUVZQm5xY0ZzNEt0NG5CcGxR?=
 =?utf-8?B?d05uVzBTUk9yTlQ1T2srSXNlRE9aL0lzQm1Nd21yNFI5U1Z3Yms2VkdPNm11?=
 =?utf-8?B?RjlyYzhxcWlsQXFpSlJKUUJvOU5Eci9GNFJoeDVNRkV0WjhXd2lBTkFVTHZH?=
 =?utf-8?B?cHhESG9aNURuZ1JrT0sydEIyNHV2TWJvaVpDcGxtaGlqanY4eG5sVlBzVzli?=
 =?utf-8?B?WGE2V2lwUmlQczNQVFFvL0FyMjFNUE1MRVFiemxNNW9nUjdTanJ0QlQwN3VJ?=
 =?utf-8?B?RW9YNVZsUzFtNGh2MkZZaGF0b2VvOTRuald4WFUwS0prWklHRDZwbWE4OVdi?=
 =?utf-8?B?aEJsMHlxb2U0dyt3SjZzOVhVdC9qRHE4bzYvSDVZSmZJaElibldncklTcGoz?=
 =?utf-8?B?dHQvN05yM0ZZcXRCK0hKN0F1b0t5OU0xdlFXNFcraGp2dFo3ckl4MmZmd0tI?=
 =?utf-8?B?VTNTUXpveEQxR1NMM0pjNFAxMTF4UVpXTHo3MFlIQmppMS9DR0w5WkdSc0lL?=
 =?utf-8?B?ZlJUQ3RIaTUvS0w1b0xwMEJsY1FVMXlhbXkwRlBIYy9zUzdhY3YwSjFualdx?=
 =?utf-8?B?QkRiejZiZ0Rmb3VMZHZuWThtaU5UcEN3TVV2NytSU05JTHpKSVcvM1hwRlgy?=
 =?utf-8?B?Ym9SWXV4Y3RZQlVVM1NtMHJORTFXZW9XdUQ4WTZmc25rZG1UeitMMWNRdXFY?=
 =?utf-8?B?Y1FTTzhHYkgrNkdiL3pvRkV0bXdFTXNudWpBd0hoUGlVMmJxMkQzNStiRTMx?=
 =?utf-8?B?SzZ0NWdCWW5xZktiYW1xMkRDbktvbXYxZWdCZUtPTjZvNlZUU0RNdlZQTW5n?=
 =?utf-8?B?bXJUMVVQcmZjRFVaRW9OUEl4ZnVmWDhxdkNhL0J0RWduYm81WXlSbFNuK1VM?=
 =?utf-8?B?a1poZUZjeGJhY3lpcnpEVVg2b1h4WXM0T1FKMDFmYm5GYVpWeGxiYzFQalpJ?=
 =?utf-8?B?QVdGQkhtN3VZTW5hSVpXMmZGVGxqektGNWE0WDlBcWtwRDh3L2NzUWIxa1VD?=
 =?utf-8?B?enhDSnBKVVkxbVAzdDhTMjVUMmZURDFmdnBDaG5EYm5JRzNYMVlQSUE2ajhQ?=
 =?utf-8?B?SzFJLzUydUVMK2QyNmhYWnYvczRFaFVvTXJhc0ZubUpaZVFrdVNJcFhONHBK?=
 =?utf-8?B?TysvTHhxSjk4SVJNOXIxYU1qbURsTUhiODFxUm5uL3krUFFISW03U1NzcDRE?=
 =?utf-8?B?b1FyWUYrOFgrNitSRmtLSU15Tzl3d0diU1orZ3UyWXVIbDZXNngxRER3QUNo?=
 =?utf-8?B?b3hhS0tobTRlZFNQWU9yMHJqWlRNbnk4ZU9qMVBhWFl1TlVJNjdLZmNoWGFQ?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba26a4b-703c-4ab1-7e91-08dddb878d8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:09:00.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqHFSqbijsz0ktHBkq10OnACfnRcq4YL0xOClp4Vp6tAHZO8agPk84NVIng1+6SsE9srBksxU4ERQ0mfylmjRfn8Hmz+SH45H2ohyGRZr+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com

On 8/9/2025 2:42 AM, Borislav Petkov wrote:
>   
> -	microcode.force_minrev=	[X86]
> -			Format: <bool>
> +	microcode=      [X86] Control the behavior of the microcode loader.
> +	                Available options, comma separated:

It looks like microcode=dis_ucode_ldr is also supported.
This could be added here:
			ldr_ucode_ldr
			Disable the microcode loader.		

> +			force_minrev
>   			Enable or disable the microcode minimal revision
> -			enforcement for the runtime microcode loader.
> + 			enforcement for the runtime microcode loader.

I also noticed in arch/x86/Kconfig:

config MICROCODE_LATE_LOADING
	bool "Late microcode loading (DANGEROUS)"
	default n
	depends on MICROCODE && SMP
	help
	  ...
	  the kernel command line with "microcode.minrev=Y".

This outdated has been there already. Perhaps, it might be better to fix 
this typo with the new one while updating the option.
> -bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
> -module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
> +bool force_minrev = false;

<snip>

> +static void early_parse_cmdline(void)
> +{
> +	char cmd_buf[64] = {};
> +	char *s, *p = cmd_buf;
> +
> +	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, 64) > 0) {

nit: s/64/sizeof(cmd_bug)/

> +		while ((s = strsep(&p, ","))) {
> +			if (IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV)) {
> +				if (!strcmp("force_minrev", s))
> +					force_minrev = true;
> +			}

I think the behavior here differs from before:

Previously, the minrev requirement could be enforced by either
   (a) Build with MICROCODE_LATE_FORCE_MINREV=y, or
   (b) microcode.force_minrev with MICROCODE_LATE=y.

Now, this requires both. I don't know this is intentional, but it’s like 
asking for more from the user.

Thanks,
Chang

