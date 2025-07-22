Return-Path: <linux-kernel+bounces-741173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59DB0E0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9FA1C254DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2E279DBC;
	Tue, 22 Jul 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0I59Zkcf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A4D156228;
	Tue, 22 Jul 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199521; cv=fail; b=G/KJ0n6Sb0hk1OSmugwngcerwU5/CUEqkULttNfQc8AHnIqrcveo/WbFgUgolADR+aKXuVWZw5DlH2S04E6m7VCo42CFD52FKbZyVyvUCuoeHfzakpnnOirg6Y+kZG5Jz4Npb1PeNGEuefmAkR2WHsvhfaPTI6bRDshv99p5r3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199521; c=relaxed/simple;
	bh=LvY/FkM172o83R//2wzaho71ThQCYQt9u0WuoQWl88s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qg2uOrtr4dvLH1vAelkfMo/hPfqDj4nHm2RMQm5Kq0uzd2QO7uy1cV6mYaheQlFSW4t4dPQ1tudylHnUAEpZRVzqYQihIIG9c9q3xoWExLqvfH26BXxZljcIWJFQc0C78UAI5OXNQkp4HgZyJ7uh/F30stixZF8F6pqvAYpd33M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0I59Zkcf; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDVPDM1hiK2jKLRqTkT/9PkG329BirOVd8WFxcvcWky3QnseywvQqhWXgcSVXE1Xo3BwzL17TgT4T9PoOqNlt7mkDOseIg/hBh6IXj9KM46n2vX1nCsHEvYw15KKvuB7DtnKmz5/6L8cjJCU+SEwjf0/YXk3BK8fQDFJemp625UCFneHIUehq/wlJB5oOVxrzYXvgITK9IPXY87E0bVQsG8j3Ei0fZWQQTRkQrPOmJliUFes2yUID7FPIcKLW2nw0QQ0shMrdFqLwJkUod4sk1Hql6NWhEyr4g2rg3OPdUDhAtaipX5GjIa3wuZc2syIWWR7YrWJaNiyWs97g2fe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYzxIbILrDI/KhoiNwYQyx7h0/ZFPyE5VlXurmGWKlY=;
 b=EUqesA6H0EZP+/IpkgC+AyqjNZ0BnLpIMf7KBNyAUvW/rW3gmjLRPUL/AivL6VDmydi7n9H7Hi9lwt9fAsqW0p7bz8/gH2t2haNXbGFkXsYrMia2M9fx/AHgDBoDAjm7CO3jFahX5pTw9NnoWeUPtYL7KTVASqH3iXHoQCzSQERei7rnZJ2CDuKKuh0j5dZVr5W7/zBSqJijXMhCLwtzMp5+hbFeQUAWki2YBfYcSXYLc62Be4UVqhrcKB30mlidrCPpnDPMw8jzntLgiZ28Cx9wz0jDh2pURHPcA+QviDfQiNDktHr+iDDK5q8915zg7N1Vvc2ZdmYIJKga57bFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYzxIbILrDI/KhoiNwYQyx7h0/ZFPyE5VlXurmGWKlY=;
 b=0I59ZkcfOQkBFReN1EGtwhZsXK7v7hZ38wNXH1UEbNtOkObTBPUlESnOClJ7PjbOtK2v5ulwbEoGjjv0G4DSXj+z+YLZP7OjgKibXOIfi/KdWN4ezQ4+0CTfmScwr2i8hpg5TyMkQkQfK4xbeE8zZaTmY7Hnjj+QjVOmO8cGLOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:51:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 15:51:57 +0000
Message-ID: <1e8b0a20-d12c-4f1b-9fc5-c4dfafb7c1dd@amd.com>
Date: Tue, 22 Jul 2025 10:51:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 22/34] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
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
 <d31ab6c51a57591423d3aa7b8e741972cd66eb91.1752013061.git.babu.moger@amd.com>
 <272dc6d5-eb63-4dde-8201-880acc9a3846@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <272dc6d5-eb63-4dde-8201-880acc9a3846@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:806:24::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2924c301-8509-4821-7f17-08ddc937b03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2NxNllnMW44U01FUEV3cTNvZ2pQZ3E1cHZPdk9FdUxNT1JHZUJVR0M1aUYr?=
 =?utf-8?B?MzczUHE5U2RxQU5mTXpmK045MGxRU3FGaHdkZCs1Ym8ra0ZpeG5lUnlhYk04?=
 =?utf-8?B?UFk0eWpmV3QzbE1pVzQrNEpYdmg0Z0hzaTZuRDhOb0lmWmt5bmJuNVRhT2FJ?=
 =?utf-8?B?bGw0ejRxR3o0eklOanpnVW1kb3A0SmlEcFVJUzhtYkRUa0xocGJ2YTFxQUJF?=
 =?utf-8?B?cXlaRmN3eXMvRlhRcW5MVUYrZk5KNDdoa2xVOENnQmhMOVB4dUU2L2lmWGhL?=
 =?utf-8?B?cllxZmxyV1pmVElxSDhIaVIwMG4vWG9LUEI2QTdmdFEzSW9ENmREMURVNHhk?=
 =?utf-8?B?NG5sUVNPSjVDWFlmWVpCczk5RHQ1UE5HL2pwZWdTckVMK2VVdmVXdHZNMEt2?=
 =?utf-8?B?Z2J2RGQ4Z0RxYU5XWEtLdFJySlhENzBCTVUrWW9NUXNVNFNvdE52UHpISTZK?=
 =?utf-8?B?b1F3eWVWREFveG5LbGZadDQ1TjFlaUROeXY2cHowWXhXNW9DV2dtaHY1SGpm?=
 =?utf-8?B?L0c0eTcvUlVCRktOdE5sbnZNVk9ZMTJEQU5xTThwSEl4M3N6QVBsR2toMHJV?=
 =?utf-8?B?TTl5YURwaU1UZ2lVRzR3dm5jUEpKWjFuUVRzZjVRQTh4MnZDVjlXVTlDd0xk?=
 =?utf-8?B?N3c3QkEzQ0dRd3FUQ1o2V05WYVJvTVRHSWVBa3EwMHNPUDExOHhkUUYybVNP?=
 =?utf-8?B?Y3Z3dWgvWnBwT3JOMVZYWExYT0lBRXpGZHNva2VJbkJuT0lrbUkzQzhHUkcw?=
 =?utf-8?B?dXlnV0tGTzZvdUpyQ1dVdmgvc3FYajRCVWt5UkduNHVEOTlWL2kxVUxQMkps?=
 =?utf-8?B?Y28wVVZUWUxYb24yUEI4OSsrOC9OenJIcnpWRDFQRVRUOHF1RGxKZmdycGVY?=
 =?utf-8?B?UmdyMkhsL3liR09ZZjBEUmpFZklxNVNySG1ISm9maGpmVTl2QTZ4SGx1OC9P?=
 =?utf-8?B?QnUwQytpU1NJcE5NZnd5emcyTHZldStVSERYaFdVSlpEV2RkdnUzVmxRWVl2?=
 =?utf-8?B?NTFuVldMRC9CNnMwN1k4aG9PdUViMHphbFN1SXQxcGUwMkxteUFhWnZiU0Rs?=
 =?utf-8?B?M1VjdHoxelFCU3A2RnZ5MXc1QVI5YVByTEIzTmVZK2hpY1gxNWdaRWk1R1ZN?=
 =?utf-8?B?ZjFKaksyZ1FUa1ZuNFBnL01ueUNUQ2NpRFBGVzRwWWk5NnhKbjBhNW85YzFR?=
 =?utf-8?B?SmQwa1NkMnp6R2VOcWgya3NSaU42aFBVMXN2cE1YNkE3RXZVNm5jZkEvenEr?=
 =?utf-8?B?aG9zU1NnWEVXcFNCaEd6NDFyeE9CazlMRXJpb1EwdWhQWVJlY1FBeEc2Unc4?=
 =?utf-8?B?NW1ybzZDNGcvelNJQVdGcjNkZjI2RmU0UGFWRHRvOWNmK2NsL3pRUlpKN1px?=
 =?utf-8?B?RitSUHVOc2duMG9IeFZlUnhidFJRWDNEYjA1d0hteGVGL0ZwbEdDcTR1WnVB?=
 =?utf-8?B?dThpUzRoT1JVRm9rRG5tdmRPMlFuc3BMcUpaRnpHckg0eGtFbEtvQXpoWEdG?=
 =?utf-8?B?d0s0dVE1eDZFL0NWd1pzTnMzdnluL1pWZjViOE9lRlhqa2Q2SXd1QkpHdm5T?=
 =?utf-8?B?Qmg2Zzh0US90SjFCcDFtRVpxeStPbTMxdnFCOWtpZ1dHdVNhY21IK2NoZndT?=
 =?utf-8?B?VUxkVjF5WmxOZTJxa1Rncld1SGpXZHViSlhiV0RFL3o1Q01RbGxxTTNJMy9u?=
 =?utf-8?B?N2cyRk1KRDZVMzhBS2lOU2huazkwbkRxNjJndjlFemorS2xEa3J6L1hOVUpZ?=
 =?utf-8?B?ZkhhWnoza212aEpiVVJBTXl0dVVYdXQ0WXR5MSszN2FJTkUxdUZnVjlMZGZY?=
 =?utf-8?B?RDlJaWVBOE5GcGlhQlFoWTQxbHZweFdKK09Dd1lKZlpGUTIraTVTL3d6NXFw?=
 =?utf-8?B?Vk1obHM0dUtic0hOMkJtUTdaNS9SREpKR2tad2kwZHhBaDVncThKTHRSelFH?=
 =?utf-8?Q?lUzpZK+1heM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzlsTXdaYzVLUWoxR21HaE4rK0k2cFI0TkMrZEdKMzliV2RlckxWQjJXOVlp?=
 =?utf-8?B?OHdVbEJLaGpXLzIxMXk4UUliNGN1UWNMOUVvVmFFcG1YNk5HSUU5RWsza0N6?=
 =?utf-8?B?QmlvY1lFbjUxUTlDL2c4anFoL3gvRy9tWER1TU5DVFZSeWEzRGJqNDdKZEVw?=
 =?utf-8?B?cUV4OEVqZ0ZxcW9DcHN4ZzZJT1RpSlVoNXZEY3g3YVhrRE1UdUMwU2gzVzdR?=
 =?utf-8?B?Y3YxaXg5SS9iSkhHQnRNOE1GeG0xb3lVcnYwbFNKS1dLK3YwcWZKNGNxMEUr?=
 =?utf-8?B?WU01Ry9QYnArbmhIc3pnZTNlcXJMYU9kWW40MGRFOGZYQzZVWVNGMnRNSnhi?=
 =?utf-8?B?V2ZvR0dKcVh3aW80MCt2Uk0wWEI3dVVkSjdrKzZpL2h5QmMwTHRYZTFBYm5O?=
 =?utf-8?B?NmpqbFhFK3BGbVJyRlBQYlNYWGNvWStwQkdiZTdYWlZlWWNVdi9LS0tRaVBt?=
 =?utf-8?B?cnNXOVBpZElTL1VnL3djS255U1l3dWtTRHB5NUE1QUhVRjFDRjZTVTZ5RFZY?=
 =?utf-8?B?Um14NkdSY0R2eW5SSXJDZjZaMHVwYllxSzJ4cVlKNyt3L0l6TGdvd1g2dko3?=
 =?utf-8?B?Q2NZUVZuNHN3bjlRejI5bDZjaElIc3FGank0U3dRRUk0bWVZT1U5ZnE0NTQ3?=
 =?utf-8?B?aERkUnBhM2JkVmQ3dnVsdW8vZ2lGVE1LaXZsYmtCQ3BtREY3TTNXSGxaNmg5?=
 =?utf-8?B?SklrSURWT3RDOXJTWWNiMjgrS1hyVUp3Nkg5MnJVYTl1UGVMek1WRFhIcFlh?=
 =?utf-8?B?VFhFeEtGL1Q0T3hqazBNb0xzaDY5OWQ2MExyclFDRDZZNm9HTzJ3ZmNxbFZT?=
 =?utf-8?B?eXBESUl1cndLalE4M2FqeWpXWWg0K2hZMm1VN0ZRQmhaS1IrZ05EeFhwVFla?=
 =?utf-8?B?NVN1dHp5cEdmaUt5WnFhRVFPZWlpeUZKdlBFWkhzWWh1RSs5UVBrNjYwdFpz?=
 =?utf-8?B?ZDUxS0dNWXBjRjQreFRpMmUyaWk3bDFmRUhMV0RwOGd1OVZUKzlVVWh2Wkdu?=
 =?utf-8?B?S1hHbkhoSlFqVzV1RGZnc00valdxWlg3UDlGZnErb2JmeHVUR0dNMzFIZk03?=
 =?utf-8?B?dTFtSmxtYUZnU1pFSldkZWxkUTI5T2ordmlQZzQ1VzhRVjdFUlA3eHRxcmRF?=
 =?utf-8?B?MlFSTHF3R3dtTE4zYW1iRmdPTHZ5M3ZMb3pTcjlBdVlzMTFNbjdGc01zdHo3?=
 =?utf-8?B?YTc3cWMzQmlSczBveDFicUZWYkIrdGRra3dsMHRBYk1BMG1TYzBka3FKZFRI?=
 =?utf-8?B?ZU05dUZCWm5MR1lzbXZURU9oc092T3Y5M3dnRnJXWkdNZkVJRDNMSjZoQWFZ?=
 =?utf-8?B?L1RHUVRxK0x6VWlFcFBhTzFVV1VDbFRRWWxFSzRNT2tSR0x4czZhM2xoYnZ1?=
 =?utf-8?B?Z2tNSnN2REUzVTBCaks0Wk1iTHA1L2p4aXZhV1hTc0dKdXphSVR4WHNOQS95?=
 =?utf-8?B?YVlYbWxwaWVibWxvQTdHSzdVSGNoWDg3QnBoT3V2dnM4SVcvQUJ2MTFkMXBl?=
 =?utf-8?B?bjN4TVovWitzMEloMnNnV3RPVFM1THhaK1JPS0dCdTBVQnVmaWNxRkFwLytp?=
 =?utf-8?B?aVVuaUtLb3QrK21iMlB5d2E2YWRqMXM0N1lYbXExN3I4Nlc5YXFtaTlkNWRJ?=
 =?utf-8?B?Ny9pbURTcXZMY1RCMnpQMFBaSituY1czL2owZDF0cU9vK1UvTFlXV1VIc0J6?=
 =?utf-8?B?VlAvUXJ4RDJjaDYzRWVEd1ZVcisyL3A2T3UvNzhWbUxiWDlIRHEzRzJ5cisy?=
 =?utf-8?B?Q1RPV2RmU0lhTlVValYwK0xjc1A1QXU2RmoxTFlkbmprcnhwekxMRTVuTjA1?=
 =?utf-8?B?MGF2QzlCSUNRZFFhZTYrS2hRU2piSVFwa0dWYzdJWjJTaUc5WG04dG83YXlV?=
 =?utf-8?B?ZjdTeFp6K1ZhVldKMUhTZWVYaituUzEvU1BiRUtGbmt3dzl1VmJhM0ZOL240?=
 =?utf-8?B?dHRGUG1mdzBaT0RmWFNuV2R0N0VNTktRMG9CRldiTE9GTUM5SDlvSG1XRUVB?=
 =?utf-8?B?MURkbloxY25DQnRZS2V2enVKWVpDcjVtdEV3MUFkQlMwL1ZIdWpHM0RnUE9T?=
 =?utf-8?B?VTRuSmg2NTFWalcyTFpSSjJjeTZ1cXBFVVVuRVRVcDhoakRveXlYajJSbUVk?=
 =?utf-8?Q?hcRA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2924c301-8509-4821-7f17-08ddc937b03c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:51:57.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++cZGzGNmI7BrUXx2ExrE9P/teUjYXmYTcwgQ21l1wMbOQ/NzvvkAjzbny0aZt+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Reinette,

On 7/17/25 22:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> System software can read resctrl event data for a particular resource by
>> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register
>> and then reading the event data from the QM_CTR register.
>>
>> In ABMC mode, the event data of a specific counter ID can be read by
>> setting the following fields in QM_EVTSEL.ExtendedEvtID = 1,
> 
> Seems easier to parse when "fields in" -> "fields:".
> 

Sure.


>> QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the desired
>> counter ID. Reading QM_CTR will then return the contents of the specified
>> counter ID. The E bit will be set if the counter configuration was invalid,
> 
> Where is "the E bit" defined?

QM_CTR MSRS bits

Bits        Mnemonic    Description.
63		E       Error on access to counter
62		U       Count for this event is currently unavailable
61-CNT_LEN   	_       Reserved, read as zero
CNT_LEN-1:0  	CNT	Count of monitored resource or event


The bit 63 is "E bit"  -> RMID_VAL_ERROR
the bit 62 is "U bit"  -> RMID_VAL_UNAVAIL

How about?

The RMID_VAL_ERROR bit will be set if the counter configuration
was invalid, or if an invalid counter ID was set in the QM_EVTSEL[RMID] field



>> or if an invalid counter ID was set in the QM_EVTSEL[RMID] field.
>>
>> Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to read
>> event data for a specific counter.
> 
> hmmm ... they cannot both be used to read the event data? 
> 

Yes. Corrected it.

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  6 +++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 70 ++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6bf6042f11b6..ae4003d44df4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -40,6 +40,12 @@ struct arch_mbm_state {
>>  /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>>  #define ABMC_ENABLE_BIT			0
>>  
>> +/*
>> + * Qos Event Identifiers.
>> + */
>> +#define ABMC_EXTENDED_EVT_ID		BIT(31)
>> +#define ABMC_EVT_ID			BIT(0)
>> +
>>  /**
>>   * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
>>   *			       a resource for a control function
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index a230d98e9d73..026c2e2d19d3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -259,6 +259,76 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  	return 0;
>>  }
>>  
>> +static int __cntr_id_read(u32 cntr_id, u64 *val)
>> +{
>> +	u64 msr_val;
>> +
>> +	/*
>> +	 * QM_EVTSEL Register definition:
>> +	 * =======================================================
>> +	 * Bits    Mnemonic        Description
>> +	 * =======================================================
>> +	 * 63:44   --              Reserved
>> +	 * 43:32   RMID            Resource Monitoring Identifier
>> +	 * 31      ExtEvtID        Extended Event Identifier
>> +	 * 30:8    --              Reserved
>> +	 * 7:0     EvtID           Event Identifier
>> +	 * =======================================================
>> +	 * The contents of a specific counter can be read by setting the
>> +	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
>> +	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
>> +	 * desired counter ID. Reading QM_CTR will then return the
>> +	 * contents of the specified counter. The E bit will be set if the
>> +	 * counter configuration was invalid, or if an invalid counter ID
>> +	 * was set in the QM_EVTSEL[RMID] field.
> 
> (same comments as changelog)

"The E bit" -> "The RMID_VAL_ERROR bit"

> 
>> +	 */
>> +	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
>> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>> +
>> +	if (msr_val & RMID_VAL_ERROR)
>> +		return -EIO;
>> +	if (msr_val & RMID_VAL_UNAVAIL)
>> +		return -EINVAL;
> 
> One of these must be the "E bit" (unclear which), leaving other undefined?
> 
>> +
>> +	*val = msr_val;
>> +	return 0;
>> +}
>> +
>> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     u32 unused, u32 rmid, int cntr_id,
>> +			     enum resctrl_event_id eventid)
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	struct arch_mbm_state *am;
>> +
>> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> +	if (am) {
>> +		memset(am, 0, sizeof(*am));
>> +
>> +		/* Record any initial, non-zero count value. */
>> +		__cntr_id_read(cntr_id, &am->prev_msr);
>> +	}
>> +}
>> +
>> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			   u32 unused, u32 rmid, int cntr_id,
>> +			   enum resctrl_event_id eventid,
>> +			   u64 *val, void *ignored)
>> +{
>> +	u64 msr_val;
>> +	int ret;
>> +
>> +	resctrl_arch_rmid_read_context_check();
> 
> Is this needed? I see this context check as related to the MPAM cache occupancy
> counters that need to be allocated when a counter is read (see comments of
> resctrl_arch_rmid_read() in include/linux/resctrl.h). To me this does not seem
> relevant to this work since all allocations should already have been done
> when the counter was allocated, no?

Yes. No required. Removed it.

> 
>> +
>> +	ret = __cntr_id_read(cntr_id, &msr_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = mbm_corrected_val(r, d, rmid, eventid, msr_val);
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
>>   * which indicates that RMIDs are configured in legacy mode.
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

