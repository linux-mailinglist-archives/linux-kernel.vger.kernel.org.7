Return-Path: <linux-kernel+bounces-862275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50DBF4D64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 093D14FEFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65427587D;
	Tue, 21 Oct 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KE31frfh"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830971369B4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030511; cv=fail; b=ZpvlUwJKCsDwaqfWUVF7C7sqKs9PVu/OhmJVUObwmnksRiQR9ZbPo4ZE92P8ORv9sXg82GGhEyXXIiphke7knG/7ttSeXFld+8fPcBly/fo/8zK8nx1eQcd/GxGhGfHqOHqni47aKZd02tlyusasIaHrOrdKU8pzERHF6yxHkEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030511; c=relaxed/simple;
	bh=nCaIkV6dJe9eKouwRrQaaIxHc1xCLM4Ntxeqtf1rjuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cOLE7e4d8VYk4ICbg2D+ZsJ3tySVcQqkFPEgYMujiYALex3JTp+fYiAtIrgYiavzCnk9ekg4rg06zbqCzNXOMMY9b65szaek7KvPZeaYlIAjzaOoBlnc9hEVjK7QLkq5jONRmssEc++yoUsGAHaQVs+CMe3ptmPs7poZgGw4T/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KE31frfh; arc=fail smtp.client-ip=52.101.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL/+FBciHbmID5X/tXqgqOhL9IGvvZj1mShIzUEM0FRY5mD/f3mfgteYOOCWW0A5mJhJyLzsucHHGoFqP5/ipiy7r1mZG7nPeZEDbIcem2zOy8B7WTNMowR0XkCrKA4/DiCsux+Uh/VdgQ+9UPoxYHsoLs+yQoTf//CpZ/1EvebMcDnJUR+8uZnHLkmEXxQwcDvZga16YsmZaFQWNudQL00VvRoy/cBBWL1OAbU6BFE4tIlVrkwIoAxD000UdAhd9mFLU31ELgDWOAZjzXWL2UJj+kWV/BGfyZOFg0DtySRo8zyc24XRmGuzkhIj5oJdz83xy0pq6w0tFkg2aLEs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VYwp8Xw8hyM1+Hy+o7vihcpADvOXoTzAl123uEuqU4=;
 b=hFrUAEEtWT8ltNipsNrijiUVWdwPEIek+hzzRitKOmMVZB+njNvHkOoNYJ4RpJ5uZ8VipnTaj3VZ0kk4Ut4QWt2MbFuHVYm+17XdDU+O23U5SmbvBfM90W8BLra3kYahwgvNm/bOZotZapAjeA85CrfddFeHx9DiLiKC1UaR5ajGcwcj8DEzgDW4/wxoDhy15HGH9aHmnLMDmfdMsQDl+SoGHjTP22nQXqwgOeB6MMoF9bkQeWG4mvOgeSDWMrrFPDGe/sBLSWMUBx2tdgLZUJxe/RfDv1dY/wkx3ZHWHaRWHkg9X/i/UMGMoiIKbTJZjUZXm+y9IQsLXLB2n/IB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VYwp8Xw8hyM1+Hy+o7vihcpADvOXoTzAl123uEuqU4=;
 b=KE31frfhTZje0mPhoos2IHIX/tJFzXeYU6plQTaYwy2LgJN/VDaaA5tFtpjwOoZM8FxFEanUkUARGWGuGstYDwQ0Qufq6yFpjCaVh6lJAgb8ngAe7kw//lTthsMLBkoQU/klfEL23OwewPIJwIDT90178sw7UTW6pnqoWcXwFJ0=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 07:08:24 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::d7) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 07:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 07:08:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 21 Oct
 2025 00:08:23 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Oct
 2025 02:08:22 -0500
Received: from [10.136.37.175] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Oct 2025 00:08:18 -0700
Message-ID: <c10f6fda-aa8c-4d8e-a315-3c084af08862@amd.com>
Date: Tue, 21 Oct 2025 12:38:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sched: update_entity_lag does not handle corner case with task in
 PI chain
To: Peter Zijlstra <peterz@infradead.org>, "Luis Claudio R. Goncalves"
	<lgoncalv@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Phil
 Auld" <pauld@redhat.com>, Valentin Schneider <vschneid@redhat.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Shizhao Chen <shichen@redhat.com>,
	<linux-kernel@vger.kernel.org>, Omar Sandoval <osandov@fb.com>, Xuewen Yan
	<xuewen.yan@unisoc.com>
References: <aPN7XBJbGhdWJDb2@uudg.org>
 <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 83056d11-6295-49ad-dfe1-08de10709fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkJCclNqdGw3bWk3OFZpZFdydFBxTUoxenRTeWQxV3k2RW94SGlNMm0rZHBv?=
 =?utf-8?B?T2M5UC92OHRlbzRnem5VQWM2RkZiZ0dNM05LZnpOeUNqWWJ2SHEvY211L3hQ?=
 =?utf-8?B?a0dhRTZIVXFpMXFOWHZaejZPczh5L3VZdCtwRmxLcW1QSUNJQ3cvRXdPQTR5?=
 =?utf-8?B?NWRaU0xyb24zR3JNSDg5aElNMEJlQUJaNGpWOXM0dVZLRGg3Vzg2NHlKMk12?=
 =?utf-8?B?c0pjRk5TR3hia3N5SXRtUHhiRWJhVGJPbnJBdnJRUWcyY0YzYXNHSkZZbUow?=
 =?utf-8?B?U3RraWxZTHhDMDdDQUVLWjhFWHFJOXRsTmFLekN0cXpqZk1zZlMxaXY0djJH?=
 =?utf-8?B?eTh4WXhVZURXYUxVNGRnNnQwOVZ5ZWx6Rjl4NmRweG1MdWxSNW04NGR6STkz?=
 =?utf-8?B?TG5zbGs1K2J2OEdxdnFOQXJ3YXpkemNUYmVoR3dvN0pWSE4wZkF1OU1ZUE1u?=
 =?utf-8?B?OXBXZXVmM0FqVkNEMDF0T0dEZ3llNTBGbVNZelJJZjBuUHFpRTl3RDVvZ00x?=
 =?utf-8?B?K2NMVmRUVzgyczRYOXo3VjZTRTI5bCtPNlBhTzRWRzlOWDR5SGZmQzJVREdP?=
 =?utf-8?B?NFlrbk5hYmdMa29UUVVDNmh2VnhkeU1xUjFXMUV3dlpwTnBqRU4ybHZlcm02?=
 =?utf-8?B?OFhLQS9BZ3dMVCtQWUJ0UU10MzR1SHNtZ2cxa3hLNUZMUk1DRnFlS2FhWHpM?=
 =?utf-8?B?czhsWWErcWZxQng3d09wRU9CekFDVTVWTHRTSVg5Z3diVlp5cXBYeGNYNmdu?=
 =?utf-8?B?dVZWNHFSd0gwVGpHUHM3U1Mwenh3cGdTTWtBSGVhTWRHdUVYbjl4QVVHZDEw?=
 =?utf-8?B?WkMwWWxXTmxDMVhlNUpJLzFZVXdLYjhYQTNZbXUxQXpFZ3hNc0dqaGYrVFVK?=
 =?utf-8?B?N1pTSTFFLzE3SlY3SG5FZXR5dFltbm9BT3VoS2xaWDMzR2x0cEViUExvNVFE?=
 =?utf-8?B?S2FESFdza1E0VWhoUStGdHlZaCt1cEF2bVJUT1VnZmkyQTVXeFJwNU1SbHlu?=
 =?utf-8?B?MW5BM0Z4UklCNTFFQ211anpmNXc2eDN6TjJOK1EyRk5xaXNTTmkxUVA1aExW?=
 =?utf-8?B?b0xqZHF4aHh4em9sbkxVc0RmbC9pVVN0NFlyN1VCa2xFaU4wUEJhOXdFZmF6?=
 =?utf-8?B?ZlB4L0N6aVNnd3lQbnBNMHVzbHdHVmF2ZmlKaEhaTTVyandoaTdlYktJd2pl?=
 =?utf-8?B?UlY4VFdxNFM0b3lFMWM4ZUFmWGhqTlRUZ0ZKWDEwSS9UTVl6QzZUSFhTN1pK?=
 =?utf-8?B?L0tUa3pibzdvS2t2SmFYTTA5N0RyQ0N5aStmd2JtTmM2WlYycHhyaXd6S1Fn?=
 =?utf-8?B?RWxLRWVRZnp0UElDODU0UldkOFk3bWRDOVhBci9JK1ppbzNoVUhHZ00xMS9W?=
 =?utf-8?B?NzRlNzMraFBydGRMNXU1T0hVQkVzVkdNM3VRWDY4WlZ4UEJWUDI4c0YxOXV2?=
 =?utf-8?B?RzBHUWpWOXNIT0Z1ZHBITGVzNlk2RC83a2YyUzRtQkJzRWMyUXR2czNTOTA3?=
 =?utf-8?B?ZXVHdElHOUFtc1lkOVVhck1nYkpRUkIzdlRLV242My9pTnpIbUZKT3VndkJP?=
 =?utf-8?B?Vm5MVGp4dkJUVkNDa1RpTWpMNGY1OHBuVXpYb3VZN3U5dzhYN3NxNWFyT0gv?=
 =?utf-8?B?alBRRGZPMHRJS2NxOGxNWExQd0VKLzVyZ1QzeUxCVEtXUUhzM0tDY3hkWjE5?=
 =?utf-8?B?REFmM1g3Rmk2SUJzOG00Y0VHYUlUSmlyT0xmS3F6WTFZUkg5MmszTW1xaGdH?=
 =?utf-8?B?SFRzaTVpSFVzWEs3bHp4cFpBMjBRaTZLWGFLUXlEWDF0d0tPRnd5a1BiaFRF?=
 =?utf-8?B?ZHpKT3BQSGVaVEdnQ3h0UDh3cEREM3p2RjBwd2g3c3dKTU01R1BtNDM5K0wx?=
 =?utf-8?B?MWEvTjRqQjJFYWM5bnZrWUhGYzhZeWxkZzZKM2M3UzVSL1BGWEJiN0hmQVdT?=
 =?utf-8?B?eE95TkpwU2c4VkJYbHVZVE9Cb09SemJJWHRoMDFVOUtobkdsR0I0NHlTc1h4?=
 =?utf-8?B?SU12MVNSQjJvRUJVZGFqNXFJMFRKOEcrWVBxMi9ncnFxTTFJVjNmWDZnR1Nr?=
 =?utf-8?B?MlBrRzZHM1dMb3EwMHFjYmYrRkFSN2J5eHFRdU9BbVlGS2xUcnFPNDFBb3Jl?=
 =?utf-8?Q?xmoc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 07:08:23.6342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83056d11-6295-49ad-dfe1-08de10709fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

Hello Peter, Luis,

On 10/19/2025 1:27 AM, Peter Zijlstra wrote:
>> [ 1805.450470] ------------[ cut here ]------------
>> [ 1805.450474] WARNING: CPU: 2 PID: 19 at kernel/sched/fair.c:697 update_entity_lag+0x5b/0x70
>> [ 1805.463366] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_th
>> ermal intel_powerclamp coretemp kvm_intel kvm platform_profile dell_wmi sparse_keymap rfkill irqbypass iTCO_wdt video mgag200 rapl iTCO_vendor_support dell_smbios ipmi_ssif in
>> tel_cstate vfat dcdbas wmi_bmof intel_uncore dell_wmi_descriptor pcspkr fat i2c_algo_bit lpc_ich mei_me i2c_i801 i2c_smbus mei intel_pch_thermal ipmi_si acpi_power_meter acpi_
>> ipmi ipmi_devintf ipmi_msghandler sg fuse loop xfs sd_mod i40e ghash_clmulni_intel libie libie_adminq ahci libahci tg3 libata wmi sunrpc dm_mirror dm_region_hash dm_log dm_mod
>>  nfnetlink
>> [ 1805.525160] CPU: 2 UID: 0 PID: 19 Comm: rcub/0 Kdump: loaded Not tainted 6.17.1-rt5 #1 PREEMPT_RT 
>> [ 1805.534113] Hardware name: Dell Inc. PowerEdge R440/0WKGTH, BIOS 2.21.1 03/07/2024
>> [ 1805.541678] RIP: 0010:update_entity_lag+0x5b/0x70
>> [ 1805.546385] Code: 42 f8 48 81 3b 00 00 10 00 75 23 48 89 fa 48 f7 da 48 39 ea 48 0f 4c d5 48 39 fd 48 0f 4d d7 48 89 53 78 5b 5d c3 cc cc cc cc <0f> 0b eb b1 48 89 de e8 b9
>>  8c ff ff 48 89 c7 eb d0 0f 1f 40 00 90
>> [ 1805.565130] RSP: 0000:ffffcc9e802f7b90 EFLAGS: 00010046
>> [ 1805.570358] RAX: 0000000000000000 RBX: ffff8959080c0080 RCX: 0000000000000000
>> [ 1805.577488] RDX: 0000000000000000 RSI: ffff8959080c0080 RDI: ffff895592cc1c00
>> [ 1805.584622] RBP: ffff895592cc1c00 R08: 0000000000008800 R09: 0000000000000000
>> [ 1805.591756] R10: 0000000000000001 R11: 0000000000200b20 R12: 000000000000000e
>> [ 1805.598886] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [ 1805.606020] FS:  0000000000000000(0000) GS:ffff895947da2000(0000) knlGS:0000000000000000
>> [ 1805.614107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1805.619853] CR2: 00007f655816ed40 CR3: 00000004ab854006 CR4: 00000000007726f0
>> [ 1805.626985] PKRU: 55555554
>> [ 1805.629696] Call Trace:
>> [ 1805.632150]  <TASK>
>> [ 1805.634258]  dequeue_entity+0x90/0x4f0
>> [ 1805.638012]  dequeue_entities+0xc9/0x6b0
>> [ 1805.641935]  dequeue_task_fair+0x8a/0x190
>> [ 1805.645949]  ? sched_clock+0x10/0x30
>> [ 1805.649527]  rt_mutex_setprio+0x318/0x4b0
> 
> So we have:
> 
> rt_mutex_setprio()
> 
>   rq = __task_rq_lock(p, ..); // this asserts p->pi_lock is held
> 
>   ...
> 
>   queued = task_on_rq_queued(rq); // basically reads p->on_rq
>   running = task_current_donor()
>   if (queued)
>     dequeue_task(rq, p, queue_flags);
>       dequeue_task_fair()
>         dequeue_entities()
> 	  dequeue_entity()
> 	    update_entity_lag()
> 	      WARN_ON_ONCE(se->on_rq);
> 
> So the only way to get here is if: rq->on_rq is in fact !0 *and*
> se->on_rq is zero.
> 
> And I'm not at all sure how one would get into such a state.

This looks like something that can happen when a delayed task is
dequeued from a throttled hierarchy. Matt had reported similar
problem with wait_task_inactive() in
https://lore.kernel.org/all/20250925133310.1843863-1-matt@readmodwrite.com/

rt_mutex_setprio()
  ...
  if (prev_class != next_class && p->se.sched_delayed)
    dequeue_task(rq, p, DEQUEUE_DELAYED)
      dequeue_entities(se = &p->se)
        dequeue_entity(se)
          se->on_rq = 0; /* se->on_rq turns 0 here */
        ...
        if (cfs_rq_throttled(cfs_rq))
          return 0; /* Early return brfore __block_task() */
  ...

  /* __block_task() not called; task_on_rq_queued() returns true. */
  queued = task_on_rq_queued(p);
  ...

  if (queued)
    dequeue_task(rq, p, queue_flag)
      dequeue_entities(se = &p->se)
        dequeue_entity(se)
          update_entity_lag(se)
            WARN_ON_ONCE(!se->on_rq)


v6.18 kernels will get rid of this issue as a part of per-task throttle
feature and stable should pick up the fix for same on the thread soon. 

-- 
Thanks and Regards,
Prateek


