Return-Path: <linux-kernel+bounces-748497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2291B141E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B931684C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1D27702D;
	Mon, 28 Jul 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg/mnT+m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4A224FA;
	Mon, 28 Jul 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726836; cv=fail; b=WZ1aDjcqjYLSRW0NC7X3mH6TSVOzGecMeVB7TxQyvexISCN5Cbp1pFlq7RTK00Ay0M0M4LDcZuAICCqA8dj5qJ0hIYvH54OyxL4ou2kU1CzY+1GbVmsdnaj2yKiS1QCw0+WytOJ/NafE6B9wWrazSgPjGRXMDnJHn6iwDnVhcdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726836; c=relaxed/simple;
	bh=FrPefwjqP4zr/YccJ8zeia0OL7H1Dd9tv5pUH7vDyvE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dVkHLlRqkftm0DP/LKNOfCjv/Ra9xdnNlbw4phJfRbanvShmuG4L0/MiFEafoq8ZQuBGyS6ac9iqBCmj+0AyUSTjTa9t+ZR1+OBoA5eghlz3ndRO5U7130HY1g56K1eUMYWTYilXW+lkG3FWh//KZ41gIpfdkJGnKIbeqrnGHUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg/mnT+m; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753726834; x=1785262834;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=FrPefwjqP4zr/YccJ8zeia0OL7H1Dd9tv5pUH7vDyvE=;
  b=Eg/mnT+mWG3Uo/JaxefxT73p+pOLfrt+FCmDeD5spevUhTvCphSjZaSy
   guhPUyKQs765mMGRL726i59s2EIYzKaym9V3HI++RmJWyY7Gw/QokxLZ7
   +msZAa3qeQSdp1gjwKIeRj7EZuaMd5VA7d/52DRggBFpEkRkMnSkDsZ+k
   VyoeVreyQnXrrd2o5UAZ6SouXlM6trhyLOhSEXL6E41Mu92IfxZlqVofE
   AwSpShMWl+rOO9F0cwuwXR01QPtil7opnUi7arm9HbSjR0QaerGKOHwko
   Agw5GU8PyiLwd9CHoOeFH2KpdbVqOOhHyD+0TSlMC8F95NBNdkuO3US+m
   A==;
X-CSE-ConnectionGUID: ExMFNK/aRsWN+JnChwGM4w==
X-CSE-MsgGUID: XJm0C5NHRku7RWcMQzElMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67066485"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="67066485"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 11:20:33 -0700
X-CSE-ConnectionGUID: 70LcewCIQu69/nxpj8+0zw==
X-CSE-MsgGUID: IJ7Jzzh4Q8GUORIIRMwnpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166967983"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 11:20:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 11:20:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 11:20:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.54)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 11:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlnuqC6zUAFgTZCk8yVxmgwjSztmngVpp3j8qXRrQpHjGHaNyMZhTsXSGpnT3+uiFAUDhOUGF7eZykRR6a9Lri4g1uEXU7gNNhaf31WfgtaeNyTqX92j8vMl+rBvw0g2/gv3pufE//dDzrfjRltNvS99apaeMfpvaVx3G4i+Ew9t/zNkrdoDB8Gohbjt1jMeAn5ePxY1VwCO1UKN4LCg22bu/iVGUpM5MXxn3qngmDUNJ90Uq4bBfDF4pogCRS13RRbO3tOJD1WBvkgS8Pufa0IoCXFG84jeFWrBz7qm57cnRmEoy82Ww30MOOddCwl8JJyiP80Ftz99dgGNOB9+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpuK3UkB4wzvyq8GVVavBTD31WQGAl04hFoLz5JWXzE=;
 b=GyhlcFURayWQYgkfbpG/3Z8Qv58s6PM9jz8VjUQVLRKg8aIO8TQt6zVN2xg/9ZUSk9mRSFz3UwXBLRDHMWevDFSUQy5+8Wsi1OHSqq96cyFawikzRINatKVHCIIJRtofJQuZbdB94/YPQ6jeXDkpVsmwpRFqYKN3GietLo5vLeSowshCrvGYgRxJJkuQHp0Zs4LXNphBWoZT0U9ZN4UP0ywoDkwWgkziPtayFMpkSDS67+W5OJItnuR03PFpHunqdh4RH1OEsfNloGKhUQ7zHWRk51/2FeaDcbCk1L64RyPY+joYC+CbybK3xbpEqiQw/LJRgaNwf60QmaUTWFDQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 18:20:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 18:20:28 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 28 Jul 2025 11:20:27 -0700
To: Steven Rostedt <rostedt@goodmis.org>, <dan.j.williams@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	<workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>,
	<konstantin@linuxfoundation.org>, <corbet@lwn.net>, <josh@joshtriplett.org>
Message-ID: <6887bf6b6de3f_1196810021@dwillia2-mobl4.notmuch>
In-Reply-To: <20250728134653.635a9dc5@batman.local.home>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725114114.3b13e7b1@kernel.org>
 <20250725150046.3adb556c@gandalf.local.home>
 <20250725125906.1db40a7f@kernel.org>
 <6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250728134653.635a9dc5@batman.local.home>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d2e4f3-a7ea-4f30-c4d5-08ddce036e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjJPcDRaa3B3SjRhTjAzSGg0bzM5Yk0ybjlNWC95dnJsUkRVOFVQdDBUT0RO?=
 =?utf-8?B?MDRHVHN2VCtqSytxejV1aUt5aXhLT0JiTDRqRm5zVStCWTAwei9EUDBiazlX?=
 =?utf-8?B?dFl0eG5HWVJIcTdNZG83bDl6SEJLR0lTYnNVajIzS2wrZTY5NERtMHFmamVB?=
 =?utf-8?B?RjBwakhGamJxQzVJcFFpdVNwWHZHdkptcnczaUI1amRzakdzSGNkQ2svVkJL?=
 =?utf-8?B?ZS94QVl6cGJMRmkwR2E4Ky91RUlHR3FReVdxcDlJNjBUMXhYOUxrMnNPYjVM?=
 =?utf-8?B?akhCU1lyUkRzNXFPOWxlaVN5M1M3ZVl3UTlnaVFtMTdQYnJjY1AyaDEwM2Nr?=
 =?utf-8?B?MVUyUmcrbnUrdFJ6UGpCUmlmVzJzczlqdDB5cE1LK3Y2eXUvRWI4NWNCS0Uy?=
 =?utf-8?B?T0RSTVdzamhlcFhPWUpHNTdLaFl3Zm1iNEZFd2RNVk5INTlQU3oyb2FtRkJH?=
 =?utf-8?B?VjFCQS9Fb3VFM1N3bFRJQ2kvdVA3dEp4VE40WG02N2ZiWnhQOTBZazN5ajFo?=
 =?utf-8?B?UzlXNUlvMU1jMlNtN3JabkNpbDhZMHJhaFVVUkNuWVNscys3L0RhcnZxSGtV?=
 =?utf-8?B?Z2RnNTBncFJicVhpUEpUWEVjU0VTb1hoN2ozZERGSnRCdEhvQ3JQT1kvd2J3?=
 =?utf-8?B?MFB6QmZuS0ZDdE1rLzIzSUhla3R4a0dEZXVZQ3YvNXdteGJUREFIOXE3THox?=
 =?utf-8?B?cjkvQStQSmczRWo3bHJQUGRRb1pqdmRUQ2JSN1VUeFpFMG1Qd1BlaXE1Y282?=
 =?utf-8?B?MGZwS1k4TlFZWERvSlRlUDBRNmZKeXVCR00wenZ4SlptRVZvM3Q2M2xaaHNw?=
 =?utf-8?B?Y1BmdFVteGtpeXJFdHBEKzlFb2gxTDdKd240akZBK3p3bFRRRlo1ZTNPYzJF?=
 =?utf-8?B?eXBWalFBcG95aWNFMXUrdTAvT2ZJZkNETjRtckQ3TkZvN0dYMzUzSjNVaDVu?=
 =?utf-8?B?cE5xL1VuRWZWbGd5dVNiME5JUkdRRGMvTXBweSsxN0NhTjRHUTB4Mk9Zclk2?=
 =?utf-8?B?OXFRSDRDRWZhemlBNXVoa0JyVDgrd0ZmYkVEZWFUOU9NSGlUNUhLVlB6Qi9B?=
 =?utf-8?B?cnI5bGhFSUxvUFBmakZKQWRXOGRCMkU4Z28rejJ5Wmp4ajQwclNUNFZjWU95?=
 =?utf-8?B?N2xKYWxFdUpsL2RZcjZWNGZXMy9OaW45Z3FqbzMwdlErK0JxVjZBcTFidTNF?=
 =?utf-8?B?VlA4WGNTUG5XRk5pd1lUS21teWYxQVJuZEJCWFZQV2dtSTg5dktpcnVGMGFu?=
 =?utf-8?B?dkxLWklHK1N1L20rcW5QVElPNHoxNlg0aVZEZlFxU1hOTHRYSGQ1MjFxVUZD?=
 =?utf-8?B?OXdNMFp1di9yelJRQUJLaWZXekc1Zml1VXlNbXd2bUs2VFp5bmIrdnc2cy91?=
 =?utf-8?B?Nzc4REpxTS9HTnhpeVhlcHY1WXJkc0NtWVE0SGFTamp6dkRjVVlhRkQ5aUpG?=
 =?utf-8?B?emw2RVkrT3VOdVpoZDg5N283UGUxZzFINCtaNWJzbGNPZDcvQ1YvZVVzcWRq?=
 =?utf-8?B?RjFIQmxZRFZ0T2hpQVl3RW5jMDlCaldlazBGcTErWFdCYjlzaEpXZE1oWkNu?=
 =?utf-8?B?Zm1od0s3V2RlbFBFTiswRk1zSHd3OXJDVFlUTVlqajZqa0tqbnBHWm1BZTdS?=
 =?utf-8?B?L1M0L25JSkYyckNqUnpveTZUemJIQzFoZjltWXJSclRYWTVmZUY3ZElHd1Ax?=
 =?utf-8?B?ZkVESWdTbmFUR1VCRGRLb3RPZzBBcHhNT2ZnTEh0c1Mrb0xkQjUvQTduNmpq?=
 =?utf-8?B?bFlSUkhoNEZaaXV6RkkxQzV6WHM4d0JvU2JBK2lCYllGK0NBWlhibmlYQU1L?=
 =?utf-8?B?S25MMmhjaXUyWHU5ZG1VT1cvSndwZkREK2VlekJGRUQxTHoxWENna1R2Vzhy?=
 =?utf-8?B?TndYcmNIWGZNZEREQkpEb0lJYzAyTDJRanNSK3Ayc3VETE45RDJPT3IrV24y?=
 =?utf-8?Q?uNvb4ksoAYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JlTWgwWkcrWG0zTzdiWGZ2VmJIZ0FxYmtiOWFDeXRwRkNEQkFVWTRjNWZ2?=
 =?utf-8?B?OXVIM0ttdmxYT3VaTjEyS01aaDBleWZPMnZQOXF2TXJ5QlA4emFweUlsZE9j?=
 =?utf-8?B?WFY0WGVHdW8zeUJwT1NkNWhYYnE0aSs2aWlhQVhtb0g5ZWNrZWRzZFg5dFJT?=
 =?utf-8?B?NFZjeXVKTktyeDVVQkc5K2FLcm5LRDlwRnVxbU9sRmdCRE1PRE1PMTkxakxz?=
 =?utf-8?B?ZWR3RSthS0dBak55TWloekdzem9UMkNsMWt5Ty84WXYvSEpHd0I0TWI3Z2Fl?=
 =?utf-8?B?SGtUaS90cVVWMFZTM1Njd2FFVUw2ZkJ2bWhaZzNIWExKdUR2S29oZ0U4S1FL?=
 =?utf-8?B?L0xBemQrak9ISlZ3bGxxU1JYQmVzYVVTcUpqYW9rL29lYXp5WHhmR21lU1Bp?=
 =?utf-8?B?ZTlkTjFtRURKRi9lOUJ2cWFkdlJUZmZDZk5wYlAyMCtpQXNSdnR0QlcrNitl?=
 =?utf-8?B?MW9NZFhURVpyMzVRWXM5NVdpcmdnMVB2VmU1SHN0YXNmc1RDa2hyd3ZlVWRF?=
 =?utf-8?B?N1VXemlPZVM2aHU4OGdCR2gxU1BTNkN4VzFXZ0Fmc2cwZUlYaFMwcHNPVnBS?=
 =?utf-8?B?dWRENG0vMVQ4dHdFai9uaWZTY1NxL2tyYUhMUHh0YnFia2xyQ1RTcExVVzZN?=
 =?utf-8?B?UnBkbmJ0MnIwWG5NbS9lbFFMNENGZVo5bUhSWm1Vemk2MFR4NXJmbFVxRWww?=
 =?utf-8?B?TjNHeEZrd0J6U1BYbDhsMU9mU3NlbVZtWC9EOGlCSWlTbUxSemhuaWxtMk9Y?=
 =?utf-8?B?eEMwZUxyaldKeHJnZWlKaS9KcjNlSkxNRVZ0VTJ4cDYrQjlaU20wSmZUck9K?=
 =?utf-8?B?UVRBTmdaTkdBdENDcVRZbnc1OFJCaFVhRDhpaVByekUrWVc3eXhFSmxQZmln?=
 =?utf-8?B?ZmljVTRzSklvTE83aXBlWndrdVlxbnJtY2NaTjFJeEkxU3RVTUtjUER3NDJS?=
 =?utf-8?B?OVQ3KzhXSm1qeEhOak1iZllzUGdwUStQbm0yQUozS0hVZkIvVVdHTTFQOWZ4?=
 =?utf-8?B?cm9wT3VEamlRYmwvbVhENmpheDBKZWI4OXlnZy9UNmpaa3BHZTRQbHhoT3JJ?=
 =?utf-8?B?eHV1REwreEhHQ1ZOQmR1WVArL05zU2h4Zkw4TzB0VzV5ekJPdHpjRUhsVnhH?=
 =?utf-8?B?UUhTRXdWMVdKRGtPcnBvRy8xa2xuY011N1V4d3JybG9ZUit5cUhjVi80SnhI?=
 =?utf-8?B?UnlwL0xkWDBuSjNiMzhueFluLzJiV0J4RXNhYzliL3RJbG0rSGhoRzU2VVRQ?=
 =?utf-8?B?a0hicmp4WHJNSTJITTNiWlBJcS84blBrRHRzUStibUxBRWR3R1l4T1NrbkNH?=
 =?utf-8?B?ZEluejR1ZFI2R1c0UjRmL0ZMbmVCVlRVRDA3Z0IrVld0R1hXQm1FbkZBSW5D?=
 =?utf-8?B?YzZkdTJ0amdyRG9YVkFKY0F1dmdMRHhHVmowSHlDVzNDNWdVZlFVeUVrOGx6?=
 =?utf-8?B?T0tFeGlmbFJNVi9Tbi9qd1JseTQzMFNRM0tna1lRTGpNVHdJc2ljR04xSisv?=
 =?utf-8?B?aUJ0bXJCd0tDRnlqRndnc20zODczdmJmUDUzUUJYaWpucXg2SE03MGxLQ2NE?=
 =?utf-8?B?ZnU1ZkdBWUFQVEMwRnpMcTRGQ0VINkFrOXBEUnZPUlg5a0tjaGlHN3dITTF4?=
 =?utf-8?B?K0ExY1BsUjVLc3YrcFVrbWt1UjBheFljQjJpaUtibm1jMGtINGFYaWwvNm5s?=
 =?utf-8?B?ZVFFcENjMUYwMTFoSVRaZFRsRVRDZG1uZ3MyTlhSL3NxQXpJY1RwcnlOZy9j?=
 =?utf-8?B?SzBEQlFiRXVCR0RIcm9UUDBQcDlRN3gyazJWMTZmTFZuR3ExWWJtWTJOZFlJ?=
 =?utf-8?B?b2VnWk9jR2JuYkJqK3RxR3Y3N294UVBjYzZ6QmxqbThUT1pLb3pNQXBvZTRO?=
 =?utf-8?B?WmlWYVpqT01Ua3BFZTZ4Y2VUMzlqY3ljVGsraTRJR0t4SUFzWDlRaUc5aEdw?=
 =?utf-8?B?QjdlYTRXTUdGVlNYNi9DekZCdnQzTTA3YlZDY0ZneFdvTjV3ZWwwYjA5bWhN?=
 =?utf-8?B?S3VXV0lqZXlnQ2g1end0Tk9vM2R0aEN3YTdHQy9qM05xVTFFbTBWcWh6dC9r?=
 =?utf-8?B?NWZ0RjlrOEJZU3VHTnI4amRlR2theFlQK2NOVEF0bDFieHdXY1RDbzBGNFJ5?=
 =?utf-8?B?cjBwOERnNEtFTVVVQ2FDQnN2MlF2K05PeVVTZTRCMWsyK012bmR2R2h1blhB?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d2e4f3-a7ea-4f30-c4d5-08ddce036e32
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 18:20:28.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WfG76Dq3cjtpF9nunagVRsdFS+dvLHarQQTN/gBVmEpP1yaQfg4oSgpDjPQAHjuGvwhWw0M4J+KFDMRzd4w5nO62OE1J2x1Q3c6WijOa54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com

Steven Rostedt wrote:
> On Fri, 25 Jul 2025 13:34:32 -0700
> <dan.j.williams@intel.com> wrote:
> 
> > > This touches on explainability of AI. Perhaps the metadata would be
> > > interesting for XAI research... not sure that's enough to be lugging
> > > those tags in git history.  
> > 
> > Agree. The "who to blame" is "Author:". They signed DCO they are
> > responsible for debugging what went wrong in any stage of the
> > development of a patch per usual. We have a long history of debugging
> > tool problems without tracking tool versions in git history.
> 
> My point of the "who to blame" was not about the author of said code,
> but if two or more developers are using the same AI agent and then some
> patter of bugs appears that is only with that AI agent, then we know
> that the AI agent is likely the culprit and to look for code by other
> developers that used that same AI agent.
> 
> It's a way to track down a bug in a tool that is creating code, not
> about moving blame from a developer to the agent itself.

Between fine tuning, the process of doing local training to emphasize /
de-emphasize some weights in the model, and prompt variability, the
signal from a patch trailer is diluted.

If maintainers care about commit text conciseness for humans and
traceability for AI, those competing concerns will conflict above the
"---" line in patches.

