Return-Path: <linux-kernel+bounces-876153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD734C1AB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 242D0587CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C723EA9C;
	Wed, 29 Oct 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bj2JhWK6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81711548EE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744025; cv=fail; b=uBUz0U4XcKxyIxFmY867LQHpy94tTGZRbh9J3uUCV/bYf9kEO+HmaluCKnomMQ8UveLyDWHj+tI5DMkI8wGjVtOapRgwnhCPlNveRp4wMdyV+w1jroNhqxAMxlh/xaBIAHA1O9lqHP8eYDyxIiAA3SXSpCoiMdXSXot6vQkhpcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744025; c=relaxed/simple;
	bh=aG0jre300lhCI9/sGImRvPfuXdqTubvNc/wqTgCVFGI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgLvn7HBJ4OWvo1pVqu6Ju31h1svktDwpm2B0j7gdcVmx/1hOgP8NpIqn6B9S/o9ngr5tRM+xubcS6i0FPYyCnI5TaK7uhVH2vrKBgL1MbR7a9mFkm8PBWdB9y/tVkeI2Qs8MD8xqE+DLdvrzRbO7a29cxd1t0o3hyy5WJmzBaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bj2JhWK6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761744023; x=1793280023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aG0jre300lhCI9/sGImRvPfuXdqTubvNc/wqTgCVFGI=;
  b=bj2JhWK6aBt97qb3NM+TXpDmsp7X57mbpx/y1HOioHVIMpolDcVHJCze
   50gs7f1jDmteluI5A/ANLCCO0PVwwRvOG8jNRoQEe3RQELUA0P2GzMb9f
   y4yRgRi2MJQKc91dicRd4pxKxrVpg/SW+L5fcoCfHkNx2I+ie1rySinKa
   cJXRgwvHnQ27mIXFaXhucjX5AC/kGmZBpjJS8sQtRAy+PtUPsnclWHCx7
   uv0Yj1IVIZEKcghlWHXZoDuGwF+aI0pITyt3DJKpqyJJmGkAaHAF/H1f+
   j9BnceHMnecRMvSA3U40gGyZv3LYaJzrlcsczSjA8gGUXa3+E+DK5ClOa
   Q==;
X-CSE-ConnectionGUID: JUst+16zRcimr/GBYCF1Gw==
X-CSE-MsgGUID: o6WdUakaTxuvVN8Sf8haOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11596"; a="74463131"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74463131"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:20:22 -0700
X-CSE-ConnectionGUID: qYSI9GZ1QHqr2amTZgLjNw==
X-CSE-MsgGUID: J6TDKRo4RLKtjwoBQ0/mqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="222883845"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 06:20:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 06:20:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 06:20:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 06:20:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWr9VFu6CKjto1sGQIc8TjdecI2k5gtty3/HbJEyWHuEEMDX54tSJ0ZY+Kzp4rSWf2gMGe64Ekb5K52YhhJRl/B9NXHr+IPMS+5KvvHbvraYErZiX9xG0/rF1fEIXsaS/54x0MnKjT8FUs++PxLNkRSNbsBJmBRsUKWD62nsUyga8k0N7uPDuoW3t5qgvlCrWz26+Dbf13lKyesoqBkVd5TVZJUxwkuxZdQ5SpgaRxeL0kNnfp30NPWysNUCF1DI7PefC2nMaDK28EtRh3fblXuS68j/kBz79U69uppsjuOYuk+pLJhZamWZ4Yf8E9ezZc3ZCYqMoIdDwDdwFRXMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGRnini6r51jrewKwYIrpwT52oHyiIRZFkVT33gTJo0=;
 b=Dr1+nj2ax+Edn5cISqXPEmvFykhVHRJ9E3KqU6VNZKEALqgLpyWwpjy+S1VotF06c/ufbAeHF8MsRi8GNg8d1S5m6fpMMGWGK8Oput8w7+Sn+yyZHxil50QB0RlWaVAxHlzTdWDcpJtbqDa8jnDB0WCJC2DwNd00xnLqifp0kESlRufUDi7WJmiKsh/V2talFkWqw4llM/OtndQ6pp/HMDM/UgWXlnaoWA4kJQj+KBkg2iMlq5bB8TrLiQb+shjEAaiNBZQGML4uvrpIAJd3wOTJT/Ed1vewKBJxvh7p4yWVy6XLfGzF3C9Xf09oIcCeNlnt9YLKgqxtd9UIdFXixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 13:20:13 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 13:20:12 +0000
Message-ID: <253f00cc-2bea-43b6-aca3-96105014c4be@intel.com>
Date: Wed, 29 Oct 2025 21:19:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination
 LLC during balancing
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
 <20251024093258.GA1630077@bytedance>
 <cc8284e8-c8f2-4f2c-bcab-4920b80a5a87@intel.com>
 <CANCG0GdR-0Yh16nuAWq477RyWXhzbo_ppDsH9hQrbkxRqw1+-g@mail.gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <CANCG0GdR-0Yh16nuAWq477RyWXhzbo_ppDsH9hQrbkxRqw1+-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: eac1b04b-65fe-4dd6-9525-08de16ede42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3UrSkYrVCtRR1lIK3ZVdlhMOG55ZGdSazJ4SmZHODE2UUpTNTZDOEhXSDh0?=
 =?utf-8?B?b2VySnNacTVhekg3b2kxK1F3VndIQzhVeEEydUZ0RVZOVjhsQUc0MEU3VGpS?=
 =?utf-8?B?dHl4YWQwWmppeXY4UVNTSkx0djRudnRxRHRwbkZoeFpJUitDY0ZOeU9pZGdm?=
 =?utf-8?B?dGhlalg3VExlTGJSSHZoM2N6UDh3T1NkM1hOVExDN2lQTUdTc0UzK3ZFN2p4?=
 =?utf-8?B?ZnVVRWFQQUlwa2pqanVMNlVxNDcvc1NmSkZhMUN4QkovU1F2MGRtckphY1dI?=
 =?utf-8?B?UC9FOGpoYlF0SmxzUG1iSjRmVEd6bmVEcWl4eWRLeGxFSXJwUTUxdSszT1RL?=
 =?utf-8?B?NUZyNitZekNKRmhmOUdwU1JabXVrbU54T3ZYbmhNbCtnTldaai9FWHFRM2Fu?=
 =?utf-8?B?UXJsenViUlRBdzUwNFBFN3V4WmpxYTE3QXRBZ3IzTFpib09vQ2lEL1VWTkN5?=
 =?utf-8?B?cTFBSEhTdURKc3d0NFFJMnJwMU1IQjdacS9MUloxdFcyanNrK0lQOWRNRWpV?=
 =?utf-8?B?UUErdXBrc0UvckpRYURJdFZtSHh2Zm5IL3pUSUQ2UmdYbHFpWm8xR3pJakZG?=
 =?utf-8?B?cFVEWW9HNUExbVNDWlhBcjZHeTErSXU3SE41L01aNWwwUlk1MVJucG43VFFV?=
 =?utf-8?B?N3pETis1SkZhQ0UwbksxcE5oRkY5eDYydjlRY0pmL3UrL2RPcnVOYmMyUlNi?=
 =?utf-8?B?YWdtbVIwY0FMaHlablhLUnVObFlleHgycXJCTEtBOGlZQTBIYll6UFRiUVY0?=
 =?utf-8?B?WUpmbmsyaG1PVlN0QnE4dlZvSWdvSlJEREtyV2N0RHM3cDB5R25rdm9XcUZ4?=
 =?utf-8?B?ME40d3RpdFVPM1MraXBKMmZvQUN3ODRCZXNHZzRjWFJHZGtlN0ZISEhOUGp1?=
 =?utf-8?B?UlpDbGY4NFVLblg0eExpNjgwZWJKNzlPUU9mR01UUUFVSk9GdGk0K1ZzWG5o?=
 =?utf-8?B?SGh1YXhtQTFUTkJGak5FS3lIa3RVM3QxVDJ6MzlHNFRkaE1QZGExakM2MHRW?=
 =?utf-8?B?YWVDS1dEa1UydVRDRDFKU0VrVU01MWdUek5DNU5vTGdQazN0L2M2eDNZN1FY?=
 =?utf-8?B?UTFyR0hsWXpjUGJ0dGdOZ0tJZWk4WjYrdzVic29yM0VIMmtrODQ4NFh4ajJt?=
 =?utf-8?B?d1VadG5uL2NldmpTZTBUajRyMHd1YndCU0FGYVlIRVhrN21jWTdWUFEwM0Jj?=
 =?utf-8?B?UE13L0ZTOFFGc1RnMUJKelQvNngwaTBScVRiYVozaVo1TkN2aVJRQXNMVE43?=
 =?utf-8?B?ZE9KYlRkL0Q5ZVIwR2VJVmVKM0hqRTBVMVcyNzBtZEpTUjMyQS9zN1Jrbnlu?=
 =?utf-8?B?dWhoam0xMFU5Vm1RMzQ0V3p4Vi9ta09yaktEVmtZLy9maWlVQUNyRStKcm5m?=
 =?utf-8?B?NFVBNHlqQThBTEhOWmFXbWJYdWxxSjZvb0g5WEphRG9ZbjlIV3czMlpxV0dW?=
 =?utf-8?B?WTFua0VyNWQ2Z0NUSUErd1ZydlFYbkovSjlHa3hQSHFnNDhNeUFJUDZabk8w?=
 =?utf-8?B?YzNGaDR2VkQ3dWwza1kxUTU5bVZNNys2N012bU9XUjRYcEhPMTJxMDhteEZM?=
 =?utf-8?B?L3dHRzJxUmphK2VxZEllUk45QmVFTU5BenUzdDBncmpDc2txWmVOY2psM1dw?=
 =?utf-8?B?Sjc4WXZmSXV1Ky9aZ21USktTUzJydHJCVEJuM1FKVjdDQ1pNTjhJUm5GUXV5?=
 =?utf-8?B?anhTZUpFR25PWU1sKzVpZ01xUytuKzJYNVNGODByNUtiTlBvSHhudENUWFM0?=
 =?utf-8?B?YzBmS3BLbzZDMnppM3lndnY1UW5YSVN0VThxbEYxTXJNZlNlWFNLamdDblg1?=
 =?utf-8?B?NE1YN2FJcjVCMWh3WmFSbTNXVjM4bDJpdy9BRFBOc3hYQVlRTk1udU1kQ2ph?=
 =?utf-8?B?QmxtS05UYWphbHRpWDJTSC92anJ5RTd6cXMxd0ZUb3ErNkdzd01tclZKNGp5?=
 =?utf-8?Q?i6L8g+lNvRkROjYFTdDbeMgiYkRUCcsC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdBV05zYXBzOGxmNVJJSFRraXRiWm9CT2tIZGZ5RnFzRTBIOUtqOHZNZFNZ?=
 =?utf-8?B?SnliOWtpS3g5dmVCTVo5Ung4aCtrV1lwdUp5dFZEUld5U1psVWk5dENWcWNa?=
 =?utf-8?B?VmVsOUhjTUFiano4ZFluY1FLN1gxbTFDM0JGcExYYkNISmZocnlLWmhmeW9v?=
 =?utf-8?B?ZU1CcFlCOTRITEE2R1VoNkVhdllYT0lVNXJWdmNxb2NYUWJ6R1NaMGdxRHRM?=
 =?utf-8?B?L01IaHdFRVhhYmlLTDRDelZFR0RGS0g4aG5KMFJuQmRZS2ZhMGJZSFhraG14?=
 =?utf-8?B?NEZQL0I5VkNkSzUyNDhycHZSc1lpMUd0VHZNRXV2U0hKczNNN3Z4SVVYek93?=
 =?utf-8?B?Q3BQQURvbXlqd1kvcFh3NXpZdFROazVwc3o5YmhJUkEzcUJOd1VNTHlrWkkr?=
 =?utf-8?B?RHA2Q0d1NWNjRDFZak1wWEh1eGorWVY2VDJMdWtEZ3pOUFhaOUNTQlAvL01S?=
 =?utf-8?B?Qm12cVhLWlpER1NDVitSUlo2YTQ2U2JHUm1lM3BJYVovU1VSMzlQenhybGZR?=
 =?utf-8?B?Mlp4cGNrZm9jVnBEQWtublpCTm11cTZoNHhtajFrT0x4ODROOFU2d3piVDNH?=
 =?utf-8?B?bjFST0lwdUJpcjNBTy9zT21ldnI4TW5RVWZ4ak1RNEw0OTVGbHlrUVA1b2JD?=
 =?utf-8?B?cHArZitvZUlSNTVGRkJVaXV4TEx3QmlrajdSa04zaUIwc3lWWUZQK0VRODU4?=
 =?utf-8?B?OERLNWVQQVViWjhCeis3OVlHbTRPaHFPTVJDM25WdStuWm56SS9QZEtQVmNv?=
 =?utf-8?B?b0RBcUw3RHpDdFh1SmdiMFN0OHk3NnAwd1ZpUzVqekRleHluUW1xVmtvRm05?=
 =?utf-8?B?L1ptVlBoZ1pRaE5ZK24xejg4ZWxwdlZHM0hmZnpZL1NxbzRDYm1UeVN0ZmhN?=
 =?utf-8?B?K1dMS0hQTXIxY0FGMHRKK1BmMDdBdS9sSDJTMEplNlJFQ2xFS1I3ajUzVUNR?=
 =?utf-8?B?RFgyU1ZmZ3paZ3ZIQVJmbmtsaklMd0FienZ4QThvakZUOUxBTHFxbllFZU52?=
 =?utf-8?B?a04xVmRiWmFQYjlNMEJQSnJWOExzWnBKNFB1bi9HZFgwbDAyaXdMZGJQK2NG?=
 =?utf-8?B?N3VvbUZOTmF6N1lqbldnYmVCajNpclBOWmM5NGx5alpaVWFkeWNQa3BpU21J?=
 =?utf-8?B?R2paZkZMZTVvV1ppRjRONzFObG1wV2RBYzduejJGOUdNRlRGTlE5eVZXeHVK?=
 =?utf-8?B?Vm9nOUtEZS9IdnZpZDJVKy85Z0RFeGtQT3ovZHZqZGR0RGppMDFrN1BkWUY2?=
 =?utf-8?B?VS9oVVR4MmwvU2hkcHR2cDhGTVNxdkk5QUovMmpPZXdrNXVOeUUxN1hsNmlZ?=
 =?utf-8?B?OHJibU5na1hBU240RFJDRFBNaTZFd1RYRDI5eW9HUG1OTC8waDgybDQxdEZr?=
 =?utf-8?B?NmRYS0RJNkkvN05kL3pNQnZrMDVuTk1oRGtqY2pjQ3d4OG92dzNKZnhRbzZu?=
 =?utf-8?B?UGUxVHVXNVA5NDlKeWhlUW5SaVVoOFFWK1JVTEdUM2c5L28yeDhSdUlDV0tH?=
 =?utf-8?B?NTJaektnVjZrQXNRWmpBZDhUMTIreE5SMWRFQUtGbFplTGtJVzg2TERndWN5?=
 =?utf-8?B?SGM2Z0xtRzRPMzJoZzFQVmEvZ3EycWhHUFN5aEJlK3A0elphUklMVkdmMDFz?=
 =?utf-8?B?eWVhd3VNdkJyMzROckVVUSt2OUlVd0J2WTFlN0FYZmhZTTc2Q3VoTkxFTE5G?=
 =?utf-8?B?OUVpOERwOU9ONEFib2wrbm9uZEFuRGRvc2ZUNUd6UWw5Y3k1YlkyZzJsMXh5?=
 =?utf-8?B?N0l0U2F2OEc4UDBKU3NUcDJsbk9ZWUxiZ1Fhbzlkek1QcGg1NEZHUWxCWEpn?=
 =?utf-8?B?ZStNbVVwNG8zT3J1UlFNSGxiYmlqMDhlZjNOZmZEcmJZSDlleFFnamNXZ1g5?=
 =?utf-8?B?ZkgvdTluR1I0UWc1VkNYK1d6ejMrNldCakJOamZWWWZKaHBCcDRZNm55cnpp?=
 =?utf-8?B?SUx5bS9qT3NZTnFldTRZdVdPSDNUZnljMmhPVlN1cFlYeSthWFo1WEcvdmtP?=
 =?utf-8?B?R0hEN3NPY0RYeXMvTExabUsrUlFWNlZJZlBhZGhrQzFZUEtWSC9aTUFFMytx?=
 =?utf-8?B?NmFEOU1MUTdBMU9aeHhBS2Q0ZStnN3FFbXJYVlpPZVFsOGQ1dlNoMFB5NjBi?=
 =?utf-8?Q?t0M5sGZKaqJMH/d/lNhZ4sJ1/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eac1b04b-65fe-4dd6-9525-08de16ede42b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:20:12.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BJdKFOgSs8CaWqj9I+t5Nayo0FZlmj65nhm2P0XBjvPdqWJh3eMNukseZFOq9ixouEIWG+8KfR80PTLA/+7mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-OriginatorOrg: intel.com

On 10/29/2025 5:51 PM, Aaron Lu wrote:
> On Mon, Oct 27, 2025 at 10:00:52AM +0800, Chen, Yu C wrote:
>> Hi Aaron,
>>
>> On 10/24/2025 5:32 PM, Aaron Lu wrote:
>>> Hi Tim,
>>>
>>> On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
>>>> @@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env *env,
>>>>    	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
>>>>    		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
>>>>    }
>>>> +
>>>> +/*
>>>> + * Do LLC balance on sched group that contains LLC, and have tasks preferring
>>>> + * to run on LLC in idle dst_cpu.
>>>> + */
>>>> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
>>>> +			       struct sched_group *group)
>>>> +{
>>>> +	struct sched_domain *child = env->sd->child;
>>>> +	int llc;
>>>> +
>>>> +	if (!sched_cache_enabled())
>>>> +		return false;
>>>> +
>>>> +	if (env->sd->flags & SD_SHARE_LLC)
>>>> +		return false;
>>>> +
>>>> +	/* only care about task migration among LLCs */
>>>> +	if (child && !(child->flags & SD_SHARE_LLC))
>>>> +		return false;
>>>> +
>>>> +	llc = llc_idx(env->dst_cpu);
>>>> +	if (sgs->nr_pref_llc[llc] > 0 &&
>>>> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
>>>
>>> llc_balance() is called from update_sg_lb_stats() and at that time,
>>> env->src_cpu is not determined yet so should not be used here?
>>>
>>
>> You are right, I think we should check the candidate group's first
>> CPU rather than the env->src_cpu. Will fix it in the next version.
> 
> Looks like can_migrate_llc() doesn't care an exact cpu but any cpu in the
> same LLC should do, so either the candidate group's first cpu or any
> other cpus in that group should make no difference.
> 

Yes, actually the cache aware is based on LLC rather than CPU. It was
a historic reason that the original proposal was based on CPU in the
wakeup path.

> It might be more intuitive to prototype can_migrate_llc() with sd_shared
> as param than using cpu, just a thought.

I understand your concern,  will think about this.

thanks,
Chenyu


