Return-Path: <linux-kernel+bounces-742897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DDB0F7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1AF3BB9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CE41C1AAA;
	Wed, 23 Jul 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i4/ELOj3"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935B6F06B;
	Wed, 23 Jul 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287604; cv=fail; b=fcOAID+8UYnZRYFC7TR+tOCQ3is0y+hMCEtYwETWIYMHmyw9vTueHrWDDoG6Apvu+fvu9NsQrGQVKI1DEKyhnAb30sNcYAVqxkpZDusCqd7ylCjDbAYzbPgtVk3gomT13JqKK49e1/XYPGL1pRcwnlmXbZmGcUusJ8WspPH84j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287604; c=relaxed/simple;
	bh=kuGNRLs7Sye30sxUgtUYmBznmjR4lDsrPTYfFo5h6wY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNyQsjJz+ty3BSFI+ULLK5A0U+0d4fcr6OM6qFeQ2wgaL+i3GF3bZB5At7K+tZNYGC0RK1dE16sF6fZHAYKZaqBaayauun41jxHsPjuCoH2ifpGgdxvww4/NyXS5wyka/v5U1YGyQ8PhTgd4gC1LXDZYOzpQsMUy3x1BW9GJ26I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i4/ELOj3; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpmCMYLVgst1Wi02QrVdMvC/LXuXtMv5YQPNVsT0nyNxP/Qn4C+kzq0XAfs/+OpJNTfTKmpbA2wLlI51Nqyqcm8NUzmER96c+Wbg8lTGhpLEClADoCcqPO9XmeDlJGQd0ArsjWX5NTZ0ChuQEE1esw9Wcx6jT7QHXA9UulPYhmUhraY6/S982m08urfe/pv7IR7uwT5RBLRiPRfs4dKtjppZODzitdIPgBz57U6m8Ve7/kGVgZwpWE+mjkOI/zyzJ678NvAIvNGuogilUTsPjSPibtS46DLhP99hCEg5Rd++CyYxxyjdHYEh7wmC1ghLlblS8rh3ibvR5izotDFqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7dWinx4hcnyVe+uybDtYR8SgqqDdpkT4LYvUTPuJzA=;
 b=Ww68IR5+Qwb/JB6m1NK00XZ/B25x81ARQA6xSSDIOHHhFTEl17u8+8Eut5zOnJcxG66zqo4q21moZc7GkiamkOtLdnzj0NQTLls29PyTzU74GZ2LnI35jSY3BJpJcW9IvF3Z+1rI+CmcKWLc14tcwYwgxPJsL/FwLECXJzSfJaEuNI1vYaBzvvHvisxLmkPg0tq8nFrX1+rytF5/ygdZ/G6wBHFC+J1mq5mhR2ByC7IdweNIiP2GCGQpA65L7IPfkP67hsF7Izp6Tto+/AbqlQLGyDJ9nF8YBRerKa7oL9+ZJLYGpMzDQmIkyqQSFXWubp4WKFn8VpbxDOSKDhMaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7dWinx4hcnyVe+uybDtYR8SgqqDdpkT4LYvUTPuJzA=;
 b=i4/ELOj3CM1TRUEKQiLnP1zT9V5+HB+Fpscltz9GqJt6GXCNLu33Pp8+s8BWXOKyL77ekhvB/n62ZULI796PbXE9BBoA4+7Ka1uhiUTkf/7o6yoGxwCwzWJyqH5Ch3aLSllXveItBu1/vN/BYVHTRoryGhVXfxb1QkaUIIkl4wU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 16:20:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 16:20:00 +0000
Message-ID: <36ad7d6a-827d-4e79-825b-0d3b92e5dae0@amd.com>
Date: Wed, 23 Jul 2025 11:19:55 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 31/34] fs/resctrl: Introduce the interface to modify
 assignments in a group
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <0a646cf184a9113c54518b14a5c94984b36cee2a.1752013061.git.babu.moger@amd.com>
 <de20ecd6-8cb2-4b3b-ba5f-b38f33fe128b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <de20ecd6-8cb2-4b3b-ba5f-b38f33fe128b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:21::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5bf09c-65dc-44b0-16ab-08ddca04c598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WExMY20wWW5BS09VdjEzNlVSMk80cWt5WUhCbFFSUmFDdmZuRkt0RnVyb3F3?=
 =?utf-8?B?UGZDQkZpeE5EVGlTL1YyL3RsZjlrbUd1cW0zRlNDVFplRktkaUVobVdhb2lx?=
 =?utf-8?B?akVHbHhwaFpFbkJ5L1FmaE9ob1BJaHkyODRpNTlvY2lVTXlTdkM0WndJNDlw?=
 =?utf-8?B?eHZ3Y3JUM0Y4a0dibGU3YWZ3RWVOOXpyNTNrUlk2STBQRFFkYzhZNnVFNmxw?=
 =?utf-8?B?V0dheXdPRDY0WXRPWTlSSVhIdmFSY1BZZWlidWRHMXkwbGVvSHMxOG04c1E1?=
 =?utf-8?B?K2NjMnRDdHhDUHVTSGt6UHhTYUk3aG1OV0t2MnVxRzBCamtUcWVDQUtaQm13?=
 =?utf-8?B?ZW5MTFlnZVJlZkpxcmhJQW4wT3Fpb0d6bW9Uc0xMclNoZzVjSGJrVHNZVWJw?=
 =?utf-8?B?Z2hndnVZeCtNRTAxY0lQTzUycklvaFBMWXU4Z3dyMkFzMlg3SlNvRUU2OXJL?=
 =?utf-8?B?eEVUbStOQlBFOUxXYTYyQUlrUGJ3Qnd0VnAwSHFXRHdsdHNVVEo1dGRBL2Fn?=
 =?utf-8?B?Nld2RWcxcDY2QVlhN09pQ2ttNjFLRjNkSkQvcXNVNTFrZ0E5NGNzU2t1RFgz?=
 =?utf-8?B?Z0U3c08zaDNxR1pMVEIvUi9uMzE3bk8zU3k5aFNJUzcvWlk5TkVGSTFzd0ZS?=
 =?utf-8?B?OUpxdTJUZzlHN1Z1Qm1XUk9MMVhVVGREQUg3ano5dS9yYjFta0dMZG1hN3FY?=
 =?utf-8?B?U1I1NVJ4R1BVMktnb1hVeEZqMTN4RXExbENNVDFBeGlxSjdnZGRoaTZPaVJU?=
 =?utf-8?B?eVpxdTNQbnkrQkNMMlVQcnpIdzNHbFhkamprVEd2K2pyMjdZdVNabkVXZ3lO?=
 =?utf-8?B?QlY0aWVZSkUyMjhBNlkzVkRGTHZKMit4eGJYT3YyM1hKRUJRZjBCam9EelJ4?=
 =?utf-8?B?VlI0WDUvS1FHRTdkV2JUNGhyUDk2U0VMVXExN0hFM3p6TkRXbTVFOHJZTWtw?=
 =?utf-8?B?SGdQV2ZDMktTMTVVZHgxQTlkS3lkdmtlUWlrYmFGanAvakRNQlQreU9ZYUd1?=
 =?utf-8?B?aFYzRzd3MmpVdDM2M2Z2aXY4VlhvaFlnL3FFcjJMNkZrNDg3eG5xL0ordXR2?=
 =?utf-8?B?SUZOMENsazBBeHp4ZXhzKzJrNjlSdXdIbitLSHMzQStKS09zV3kweWNTM0lH?=
 =?utf-8?B?NmFoOE50bnNXTzQ2eWlWeEZHUVp6bFlvSEVteVE1YmwyYytCY0xSYlA2akp4?=
 =?utf-8?B?eWZDQ1RXclRmUHRSYmtvcEJMR0NyTzZ3SnFEM09DKy96cjRnOHhOYkdETnJV?=
 =?utf-8?B?YjJCV2NDdnZZY0dQS0JBY0sxWm1Zd0NaQXREc25MajBaU0pZNGpsRnQ3aUZ2?=
 =?utf-8?B?RW9HbWxYQyt4NWc5V2l3L0tOcUxCY1NmRUd6SkRXQksvVndvYjFXSFZnYXhL?=
 =?utf-8?B?M3IrWElUWFRtZGpiQjh4K2NWaWRlSUhVMUVrUzNRRlF6RlhYbVJiTFEwT1hh?=
 =?utf-8?B?bWowU25rbHVmNVVvcUgvL3ZGZ254cU90RlNUZkZsRjVFWVl6OXdRbXlzV0kv?=
 =?utf-8?B?dDV6R1FOT084UmJlQTl3RjQ2dTRLSStmbVRXK1FUaWJLU21mbGw2STBuQ2hM?=
 =?utf-8?B?V2Y5UGEvV3h0bkRRallDbWhMTktFbjRHbHNNczZLVXo5bGlscE5XUjVKSS9D?=
 =?utf-8?B?MWcrQUYvUE9NWUxSZ1l4amNtSXhkMmhpVU13c2FDUXJmSEcxMnd5WDI2bXFE?=
 =?utf-8?B?TTZZYXo4dllXK3dINWpqUDllTGY1SjZKeVRuUFFCOXJHUnh5Q21PM0V0ekxS?=
 =?utf-8?B?OWFzckFZOXd1Ly9XVmxsSjc2d3plZ1gyY3pOZ0Q4V21Qd2I2YkUyVWJiWjZ6?=
 =?utf-8?B?ZllHL2hhYzFKU0xRc2EyNGpOY0FsZXNTMlJubEVBaWVCVUxFcE51V0tCTG5P?=
 =?utf-8?B?bmJycEdhaUV1bWRXNEdyTlMyMkh4MytSelNqRVZ6RzBZR0tzUkV0NVBPZUNO?=
 =?utf-8?Q?P0Ka+iLrAbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTM4c0hNLy80ZFF2ckdjdmQ2Slg4aGM3SFFyUGtzSzVkK3Q5Y25xZ2F2cVF6?=
 =?utf-8?B?b0o0cnZqdnRTazRhbURySU5Gei9WZVlLTzkxR2xibG9wR0NBZ3hkZSthMjh5?=
 =?utf-8?B?QngxVlZtSmpkdm1RSzVoR3ZxYjVjSG42VTluRWxGcWxYRXIzWk51a1BOQ3VS?=
 =?utf-8?B?YXJyM2ZFQy9RQlM2SG9WNjl2UlNXVnZFVURoeTc1dkpndGV3UUNrVC80T05q?=
 =?utf-8?B?V3NFeVA5UlZ5NCtGUmFOQllOcUIraUppSWZnMVNlRFozWGhJS2hzY0w3VnFT?=
 =?utf-8?B?OGo3Z3Q0Qm9YTGFFTXdCOGRtWXpaUVY2Vk9MdUhRZ2djVGJXZG52MDFHMjUv?=
 =?utf-8?B?RkZ5TXcxc1FaSmozdCtqeUZ6NThiUHRoaUZ4Q1BZOVUvUkhiSHRBUksrYysw?=
 =?utf-8?B?SzRxTGhlTFhWaW9lTEI5ZUs0cmNHQlNrbWhORW9XaUhYU2dMcDBLb3hZaDVt?=
 =?utf-8?B?QjU4ME1Ibkl2ZXp0S2FUdTJzVW9XbGtsWUpjOWx4VERuZXl4cTJMLzZab2E0?=
 =?utf-8?B?MUc1NXBTdzBDTHdWTUhnNjIzUnBNbXdDejFHUjMxdzArYXQzUlpQcUF3R1E2?=
 =?utf-8?B?SGMyVkRZUVorZ05uSXR5NlNiTnBERGxZU01OMHlFV3ZrYmhzbVo5SXhENnNT?=
 =?utf-8?B?NThhMWN1bDVCUG8weGE5Wk9WQXhGam5yaHZEU09vc0VlT1hxMURIWnVIRUhX?=
 =?utf-8?B?T2huRjExcU5CcW1VY0xjb2ZNd21BdmVSTkgyY3d5NU8vY2xBbmcwdnhFVzd3?=
 =?utf-8?B?RUZKbGhqZmdLcHNRTGJuNFpDdVVoWWpyb0FBaTBzc0pwaTFXTXptZlJKeHJG?=
 =?utf-8?B?bFRsTW0rc3B5SGVRY3VWRzNLWlA4ZWt1S2VTc01Va2RNdC9IcWhqbHYxZlBI?=
 =?utf-8?B?THVkZkJmTittbW9yMmpyU3l4M2tUQkJ5M1N0eXpGOWEyM2V5S0paUFFPeEl2?=
 =?utf-8?B?NVBQOFpPeVV6UnNnQVRoRmNWYWFoYUFxd0lleERCVTZoWjVuQVVCMUtiMDln?=
 =?utf-8?B?aXNIQjBMeDZMWGVPR0MrMjNJWlVYWGc4UUkzR3dFZ1RSUDlBaHRPeDFPMGdz?=
 =?utf-8?B?UjB4c0JSSWFvMDkybjd6VkRvQ25vK3lyYUw4ZXBuNmsvbE53VE5nN2FvMmZC?=
 =?utf-8?B?Y21SUXVDL09sUmhSbkJTYkV4aHlyZHVPWnF0aEg5V1FKRm5JTVV6TG5QWndT?=
 =?utf-8?B?QXVGZVdxTEYyYlZyUDRvY20yOWlmdjV5SXQ2K2tHV1B0UVdWSy9FeXh6R0xk?=
 =?utf-8?B?NVd3YTMzayt4OUpvNGxVQjkycDRBbHFyZUIzODVzbWlUd2twQ2NrZ1dtV2R4?=
 =?utf-8?B?TjVyaElqdG83UkY3ODBDU2g0QUNPV1NyT3VNdEtzU3dhaTBnUnoxZTlBY3dI?=
 =?utf-8?B?RUU0ZHN1RFZNWFVSMjkwS1k5UXNoK2J0V0FqbEZmUHdPVTlrN2t3NnNtTStB?=
 =?utf-8?B?Q2Z0UEdiWWJxampFY1djZHFSUGtNZXB6ejFIK3c3djZTbEs0ZFc0eDhhQWxL?=
 =?utf-8?B?bmZYaFF3T3Y1V1RXWkJwVllsTC9XNzNpdTFtRCtzVXhhUWVBZ0RGOHQvL2ln?=
 =?utf-8?B?Z3R1V0lYaHhzL2VYUmNnb3FYdSsvNkwxVUVFeUlsRjEwallJYVdEZnZ0Q1h5?=
 =?utf-8?B?dFZ6Q1NXdm84Mk9ISVFTYjZDcGxNS0huM3Jrc2xxendxemVIOFVVR3o4SjdZ?=
 =?utf-8?B?ZEgyRUFRTFdTdGIrODlua25rNDc0SlVPWFJUMFZkUC9RVE13L3Z4SWt4eTlB?=
 =?utf-8?B?aDBhV3I5Z08xQVRadDIwdkV1bzJMWHJmN0RQWVpGc2tMZmdUQ3BWZVM5SElW?=
 =?utf-8?B?YUFLOGxPTUJZOVhKSzRxdFZmdWpBU0xpN1pGcUUxeW5LcHh4ZWpZTHNGaXgy?=
 =?utf-8?B?U0I1VS9BYW5NUHZBVHNITzh5Y1hDaU1KbUlNUUREdUxxdXZrSFlsVEgzNWly?=
 =?utf-8?B?TkhtNVI4Uk02ZlBHL1dzdGdjRllPNzllSE8zZlpMeFlaTzBEZTlWMm9BSmpG?=
 =?utf-8?B?YWZoWHBNVHlHNDg4ei9LREFhRmhMaEorMXpVOG8yWnMzQXNuSjdjSUtqOWRE?=
 =?utf-8?B?Y3B4TXhjWWdtcU54QlZJdFBlVDlEZWppMEpWc1dPYklhcmE4WDhYRHhkZ28r?=
 =?utf-8?Q?EYTJA5noZEPi2BLcSD1LKRQ65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5bf09c-65dc-44b0-16ab-08ddca04c598
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:20:00.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtQr08WcaHeiUITTEn/ee0NCjexPUikbPJDtUhFsYj3SJYjyyH376xtq7XZQPlG0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216

Hi Reinette,

On 7/17/25 23:01, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> Enable the mbm_l3_assignments resctrl file to be used to modify counter
>> assignments of CTRL_MON and MON groups when the "mbm_event" counter
>> assignment mode is enabled.
>>
>> The assignment modifications are done in the following format:
>> <Event>:<Domain id>=<Assignment state>
>>
>> Event: A valid MBM event in the
>>        /sys/fs/resctrl/info/L3_MON/event_configs directory.
>>
>> Domain ID: A valid domain ID. When writing, '*' applies the changes
>> 	   to all domains.
>>
>> Assignment states:
>>
>>     _ : Unassign the counter.
> 
> "the counter" -> "a counter" (user cannot control which counter is assigned)

Sure.

> 
>>
>>     e : Assign the counter exclusively.
> 
> "the counter" -> "a counter"

Sure.

> 
>>
>> Examples:
>>
>> $ cd /sys/fs/resctrl
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>>   mbm_total_bytes:0=e;1=e
>>   mbm_local_bytes:0=e;1=e
>>
>> To unassign the counter associated with the mbm_total_bytes event on
>> domain 0:
>>
>> $ echo "mbm_total_bytes:0=_" > mbm_L3_assignments
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>>   mbm_total_bytes:0=_;1=e
>>   mbm_local_bytes:0=e;1=e
>>
>> To unassign the counter associated with the mbm_total_bytes event on
>> all the domains:
>>
>> $ echo "mbm_total_bytes:*=_" > mbm_L3_assignments
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>>   mbm_total_bytes:0=_;1=_
>>   mbm_local_bytes:0=e;1=e
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  Documentation/filesystems/resctrl.rst | 146 +++++++++++++++++++++++++-
>>  fs/resctrl/internal.h                 |   2 +
>>  fs/resctrl/monitor.c                  |  18 ++++
>>  fs/resctrl/rdtgroup.c                 | 123 +++++++++++++++++++++-
>>  4 files changed, 287 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 4dd1d605d6ad..2b2acb55d8b1 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -527,7 +527,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>>  	Event: A valid MBM event in the
>>  	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
>>  
>> -	Domain ID: A valid domain ID.
>> +	Domain ID: A valid domain ID. When writing, '*' applies the changes
>> +		   to all the domains.
>>  
>>  	Assignment states:
>>  
>> @@ -544,6 +545,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>>  	   mbm_total_bytes:0=e;1=e
>>  	   mbm_local_bytes:0=e;1=e
>>  
>> +	Assignments can be modified by writing to the interface.
>> +
>> +	Example:
>> +	To unassign the counter associated with the mbm_total_bytes event on domain 0:
>> +	::
>> +
>> +	 # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
>> +	   mbm_total_bytes:0=_;1=e
>> +	   mbm_local_bytes:0=e;1=e
>> +
>> +	To unassign the counter associated with the mbm_total_bytes event on all the domains:
>> +	::
>> +
>> +	 # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
>> +	   mbm_total_bytes:0=_;1=_
>> +	   mbm_local_bytes:0=e;1=e
>> +
>> +	To assign the counter associated with the mbm_total_bytes event on all domains in
> 
> "the counter" -> "a counter" (motivation: user space cannot control which counter is assigned)

Sure.

> 
>> +	exclusive mode:
>> +	::
>> +
>> +	 # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
>> +	   mbm_total_bytes:0=e;1=e
>> +	   mbm_local_bytes:0=e;1=e
>> +
>>  Resource allocation rules
>>  -------------------------
>>  
>> @@ -1579,6 +1608,121 @@ View the llc occupancy snapshot::
>>    # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
>>    11234000
>>  
>> +
>> +Examples on working with mbm_assign_mode
>> +========================================
>> +
>> +a. Check if MBM counter assignment mode is supported.
>> +::
>> +
>> +  #mount -t resctrl resctrl /sys/fs/resctrl/
> 
> "#mount" -> "# mount" (please build htmldocs to confirm everything
> looks consistent)

Sure.

> 
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  [mbm_event]
>> +  default
>> +
>> +The "mbm_event" mode is detected and enabled.
>> +
>> +b. Check how many assignable counters are supported.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>> +  0=32;1=32
>> +
>> +c. Check how many assignable counters are available for assignment in each domain.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
>> +  0=30;1=30
>> +
>> +d. To list the default group's assign states:
> 
> Please note that these steps are inconsistent. Some end with "." and some end with ":"

Fixed it.

> 
>> +::
>> +
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>> +  mbm_total_bytes:0=e;1=e
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +e.  To unassign the counter associated with the mbm_total_bytes event on domain 0:
>> +::
>> +
>> +  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>> +  mbm_total_bytes:0=_;1=e
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +f. To unassign the counter associated with the mbm_total_bytes event on all domains:
>> +::
>> +
>> +  # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # cat /sys/fs/resctrl/mbm_L3_assignment
>> +  mbm_total_bytes:0=_;1=_
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +g. To assign a counter associated with the mbm_total_bytes event on all domains in
> 
> ah ... here "a counter" is used.
> 
>> +exclusive mode:
>> +::
>> +
>> +  # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>> +  mbm_total_bytes:0=e;1=e
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>> +no change in reading the events with the assignment.  If the event is unassigned when
>> +reading, then the read will come back as "Unassigned".
> 
> Since returning "Unassigned" can be complicated, the associated description should
> probably just be done once in the doc. I expect this will be in the "mon_data" section.

Addressed with
https://lore.kernel.org/lkml/2c107793-1258-4276-8b29-03359fa605f2@amd.com/

> 
>> +::
>> +
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> +  779247936
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> +  765207488
>> +
>> +i. Check the default event configurations.
> 
> Drop "default" (there are only these event configurations)
> 

Sure.

>> +::
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>> +  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
>> +  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>> +  local_reads,local_non_temporal_writes,local_reads_slow_memory
>> +
>> +j. Change the event configuration for mbm_local_bytes.
>> +::
>> +
>> +  # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
>> +  /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> "counter_configs" -> "event_configs" (this was also an issue in previous series, please
> use grep to ensure all are fixed)

Fixed.

> 
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> 
> "counter_configs" -> "event_configs"
> 
Sure.

>> +  local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
>> +
>> +This will update all (across all domains of all monitor groups) counter assignments
>> +associated with the mbm_local_bytes event.
>> +
>> +k. Now read the local event again. The first read may come back with "Unavailable"
>> +status. The subsequent read of mbm_local_bytes will display the current value.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> +  Unavailable
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> +  314101
>> +
>> +l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
>> +done using the following command. Note that switching the mbm_assign_mode may reset all
>> +the MBM counters (and thus all MBM events) of all the resctrl groups.
>> +::
>> +
>> +  # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  mbm_event
>> +  [default]
>> +
>> +m. Unmount the resctrl
> 
> "Unmount the resctrl" -> "Unmount resctrl" or "Unmount the resctrl filesystem"?

Changed to "Unmount the resctrl filesystem."
> 
>> +::
>> +
>> +  #umount /sys/fs/resctrl/
> 
> "#umount" -> "# umount"
> 

Sure.

>> +
>>  Intel RDT Errata
>>  ================
>>  
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index b42890fd937a..9881674909f2 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -403,6 +403,8 @@ bool closid_allocated(unsigned int closid);
>>  
>>  int resctrl_find_cleanest_closid(void);
>>  
>> +struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name);
>> +
>>  int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>>  			       struct mon_evt *mevt);
>>  void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index e30a867c00bb..61419849b257 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1220,3 +1220,21 @@ void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
>>  			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
>>  	}
>>  }
>> +
>> +/*
>> + * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
>> + * event name.
>> + */
>> +struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name)
>> +{
>> +	struct mon_evt *mevt;
>> +
>> +	for_each_mon_event(mevt) {
>> +		if (mevt->rid == r->rid && mevt->enabled &&
>> +		    resctrl_is_mbm_event(mevt->evtid) &&
>> +		    !strcmp(mevt->name, name))
>> +			return mevt;
>> +	}
>> +
>> +	return NULL;
>> +}
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index dc108c5db298..b26baca389bb 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -2071,6 +2071,126 @@ static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file
>>  	return ret;
>>  }
>>  
>> +static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain *d,
> 
> Please move to monitor.c

Sure.

> 
>> +					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!assign || strlen(assign) != 1)
>> +		return -EINVAL;
>> +
>> +	switch (*assign) {
>> +	case 'e':
>> +		ret = rdtgroup_assign_cntr_event(d, rdtgrp, mevt);
> 
> This patch enables the user to assign counters to multiple events in a
> single write. Looking at this flow:
> rdtgroup_assign_cntr_event()->rdtgroup_alloc_config_cntr() may thus
> be called on the same domain but for different events in a single write from
> user space.
> I thus think that the error message in rdtgroup_alloc_config_cntr()
> should not just contain the domain ID, but also the event *name*
> (not the ID since user space cannot be expect to understand if).
> considering this it seems that @mevt can be passed through
> to rdtgroup_alloc_config_cntr() instead of just the event ID to support
> this?

Yes. Taken care.

> 
>> +		break;
>> +	case '_':
>> +		rdtgroup_unassign_cntr_event(d, rdtgrp, mevt);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
> 
> Please add a "break".
> 

Sure.

>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int resctrl_process_assign(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> 
> Please move to monitor.c and rename to be more specific. For example, 
> resctrl_parse_mbm_assignment()? Open to ideas.

Sure. Fine with resctrl_parse_mbm_assignment().

> 
>> +				  char *event, char *tok)
>> +{
>> +	struct rdt_mon_domain *d;
>> +	unsigned long dom_id = 0;
>> +	char *dom_str, *id_str;
>> +	struct mon_evt *mevt;
>> +	int ret;
>> +
>> +	mevt = mbm_get_mon_event_by_name(r, event);
>> +	if (!mevt) {
>> +		rdt_last_cmd_printf("Invalid event %s\n", event);
>> +		return  -ENOENT;
>> +	}
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +
>> +	id_str = strsep(&dom_str, "=");
>> +
>> +	/* Check for domain id '*' which means all domains */
>> +	if (id_str && *id_str == '*') {
>> +		ret = rdtgroup_modify_assign_state(dom_str, NULL, rdtgrp, mevt);
>> +		if (ret)
>> +			rdt_last_cmd_printf("Assign operation '%s:*=%s' failed\n",
>> +					    event, dom_str);
>> +		return ret;
>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Verify if the dom_id is valid */
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			ret = rdtgroup_modify_assign_state(dom_str, d, rdtgrp, mevt);
>> +			if (ret) {
>> +				rdt_last_cmd_printf("Assign operation '%s:%ld=%s' failed\n",
>> +						    event, dom_id, dom_str);
>> +				return ret;
>> +			}
>> +			goto next;
>> +		}
>> +	}
>> +
>> +	rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +	return -EINVAL;
>> +}
>> +
> Reinette
> 

-- 
Thanks
Babu Moger

