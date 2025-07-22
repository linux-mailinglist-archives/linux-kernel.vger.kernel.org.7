Return-Path: <linux-kernel+bounces-741663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A16B0E76A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2369C565FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44628C5B0;
	Wed, 23 Jul 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgs24NHn"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B14288C0F;
	Wed, 23 Jul 2025 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228802; cv=fail; b=p3QS50kdFjZJlz020tqkaMXN89nyHktDT/r74Eeqnjh9IoiAdxcttI29183x6/qwzFWN7BRoqUmuZlGduQHlryjDpazR2SRVq6Qwy13+XjNnwyC1QaqD+au1Fq7oOxczzvS6XbxOVXoi+yNIRtllqxUxny3jiR71wH1CleBUzPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228802; c=relaxed/simple;
	bh=YX+w4WZsZzwetfkNZeNKhspfMdzgm+ZocEwnRN2FMUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l61bqufArMXp66d6IJrrOdiZwnHY/0LjCcqKEAxbKwnbExEGA3VYtxj05EFL2cqg1JBTzknemcJXsx/wKaezqrJUDCsYomHBGwLf6bKO9/cgxrjQMH7/gg80CXxQl6XTc8Wecrcu+hzj3F5CtOoNsTLLBq8KOkKIEfkbyac0Lh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgs24NHn; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZWFfvWTEP53lLfPHNptsUmTEVhlNtUz+Trtf+aOaPlnXmSkxamAW8Vip6DM9oM9VpmRNsMHVFe+CpxqFwENnIwmTJ/oYFLics9Mvqrfce6agwW/VcBAmX73kaPbfQ3++oKk84KpSPxVqHsBDN0lmttGd95Tm0Yalgi+60vNEbhF2+MNxUa+dIl8mAHT2hz0YVN80lqv2YQsyImFtgh6LADvGOpq4Y3eJzE0CwR/fvtXuhU/McVqjzgrEMzy+wiTfVUSFDrKLo9nlrnEQGCENrAKDOS1MukuwpzATy+8nDdVqobiKpR7kVML4a3pRIyoq2jItYFoneSzTLoPo4Q56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9msLwgSbM2L39FzpdHZR4NBaS2X4sYRA4p42v1ZTbY=;
 b=vq4G3pzFIsI6RQPClyg7nX/rXqlPr00Zt2TVFhXi82JqzXiobVb0qWhQjqiqcrjLikuPVsT0oscGXIi0+e3z1UTlpR1OX+iq/rZyPO2P+Do0GhkDOq6CLbZVf+gqUBzB4EP7astF8+nxpZYsQQhfiYK6E31HG1iJCQm0osaqXAUEHuYGjgsvfdaGXcsVUfe9csR8O536Nb8xgSJ/g8aiach7x31O5M/3RdcCnfXaCsNpy0ys1BX8rgJzMk2wKSOn4cIMxrtImaYFvM+n0W5cqfoqjxlbmZUwKmFUpmIhKsfTOSb2OM18Ba+/wIktyHLb21P7ZV6qsSSIIEev8wUWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9msLwgSbM2L39FzpdHZR4NBaS2X4sYRA4p42v1ZTbY=;
 b=cgs24NHnze6na2Gksc2SbJNda3WprEg5X7E/xaljvh/xC4l0ZLPO+YKl3gBuOy7CPRMkhtrt+HzaqYtbHrzX7RdonJA8C4Z2xoyNed1Sqf14S3hw3Vu2rlvIcfM3fjKMLB5mHeDJ7amQav01jrtMwQAD5j3PK0YFvsK2yBmXCSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 23:59:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 23:59:57 +0000
Message-ID: <6dd38997-253f-4e89-88ef-b566039ff291@amd.com>
Date: Tue, 22 Jul 2025 18:59:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 29/34] x86,fs/resctrl: Auto assign counters on mkdir
 and clean up on group removal
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tony.luck@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
 <9c14b9534bb8fb8e7cd1b2e450312061d9c150d3.1752013061.git.babu.moger@amd.com>
 <3cf90472-be2d-4800-b3d2-879b5fca2012@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <3cf90472-be2d-4800-b3d2-879b5fca2012@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:806:127::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ee1f22-1812-4fda-b3f3-08ddc97bdc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHB4U1p2RTl2cFk4ZGo3aEdjckhvYjQ1b2JXYXB4VG9wYi9Nakd4N1RvVjhh?=
 =?utf-8?B?WnVwQmtzaUs4VzdJT2VlSlc4QmxJQ0RzZWUxdG9qaXMzenowL1pTRHF6VldZ?=
 =?utf-8?B?OU9xMXJsREVGWTdoc3ZrZi81NnNocWQ0YjYvQzdIcXBjWm5lQnBJWUZYVE8y?=
 =?utf-8?B?WXZ0WG8wSTBKczgxVlRMVXhicmNjZ1M0WHdDellRV25JN0djR1VEcTNaZmF4?=
 =?utf-8?B?TmUzVFlrMHg0akh6TDRxdmMrUDN3V2VrbnJhSnpYTEZXN0Myek5zajNmRmJ5?=
 =?utf-8?B?MGF1dDJ3bWdmMEdQTEFodGozL1dZNTVtQk5EYjcyNGVyODR5U2JHQmNnZkNI?=
 =?utf-8?B?N20vZ3VYTUlNUldJTWRiVzdJeWZOdVhWaWtWYVdxUHAvWUdNTkgrMEc2VFNV?=
 =?utf-8?B?UWRiMXVDdkFIckxXRkNuMFRQTm9hU0gweHNrVStHL2Q5bnVSNDQrK00rOHlP?=
 =?utf-8?B?d3p6MFhSMFJ6YXgrTVJNc3BkZXdTdHFHMVNsSU1xUTd3djZUS2tJYUxVRkZT?=
 =?utf-8?B?elE3dFpqeWtQTUVubnc3KzQ0UGw5YjJiRFVpTGZ1bldrMUdjRUFidmZncFpR?=
 =?utf-8?B?ZXo3MXoxS05SOTBBNVo4Qk1GMGhWZ0cvandpRUZJL3F0OVdzcEd3S1liOGha?=
 =?utf-8?B?cWNHWnhFSllPb1NvN2xVN0tHWG5lMzNSZU1nVzFzbWNFZW44anJKU1dibnht?=
 =?utf-8?B?Y3VPbUVmSmsrTnEvRkZ1NjMvcVRrb3p4RkhMbGtXU2prYThlRmlNOVY4WmVE?=
 =?utf-8?B?K3duSi96aHhFOUFxNGxRWXdHTUxLZGdiSWdiRTVDM3VjQlRXaUEwWlFvblNY?=
 =?utf-8?B?K3ArWWJXZVhyYlRDamFGOWtORTVnN3VnK1J1WTM5YlJKMHQ4NFFLREJ5Sm93?=
 =?utf-8?B?QmU2ODdhSmtrT29CT0pDdmlZalZkbmdldndjRmZXcFhUWmJhdHB2NVVSYWV3?=
 =?utf-8?B?ZWp4dmhWMGVmREhHS3JYZXlxTUVhcUhERDVicUVncVJ2TlgwVFd5OWZxTUpv?=
 =?utf-8?B?RFR2OXdkbjlVanhORFhvSU5CUEtwWlVPQUtpM0VoUkhqend1ZHNGZnpJekhG?=
 =?utf-8?B?UlJFYldFQVlxTWpDV1h6WUQ0dkhwR0FKMU5WOEpKdWgxWEZicXZCd3RhblpZ?=
 =?utf-8?B?WDBFRlVnMEU4dFh4MCtCN3QrMDQwK3EwTkJ2ZXRHM2xzWFJXd0tNNzIxSXEr?=
 =?utf-8?B?cEpOWVlaL3ROTis5YVpFdHVsUnlLRm9LMlQ5VGUwUUlZTGZKTDRwOUExU21P?=
 =?utf-8?B?bXYrTit4dS9rbWsyUG5ReTdIQ2duRDUyWDV4RFJoNm9TelI1Q3FIOE5lUjFy?=
 =?utf-8?B?UW8wRzJKV1IwdWdCbTliclhtL05iU0pYTmlGUDMwOFNDanNwV3hSM0lzVEl3?=
 =?utf-8?B?bWY4cGhKdzRQRnAxb1hzZUFoY0VFcWNFQVdEUkdTYlU5L1BXdXBielJhV2R1?=
 =?utf-8?B?WUVNVEVOSi9PaFl6amszTnM4SFZ1R3VzS25RZEJENGpsclhZSk9jV1FGU0wy?=
 =?utf-8?B?WDBJVWlZM2oyMVcxS1RMamh1aUx6N3M1Zm1rci9WaS94MjVjbEdLbVI0aE12?=
 =?utf-8?B?NklSeURCaW96VHN5OWYyb2lkWHhBaVBXTjNNRnJTQmpqdFhkTUtqWk41ZnRI?=
 =?utf-8?B?ampjN1IweDZJVjBMLytaSy84blBtODNGeUx5bmhZZUxhNk5QS2c0aW1aZDRM?=
 =?utf-8?B?K3R4dFA2bE5MTjNrVTh2WGFja1V4ejZTMDFrd1ZFbldoSjMxakkyVkFTajlx?=
 =?utf-8?B?UnhpclpqYWg0d292TXNGbTZxSXlVd0VvMG9vdTM3UkhGUENMdnBDT3FKR0Ir?=
 =?utf-8?B?aXc5bU1VRk9wVTlXakgvTDQ5N3NzKy9tRlVkVW5ITUlyMDNMQ2Yyc3lNSk1G?=
 =?utf-8?B?ZTltdmNubEw0RXhoYjhkcTZxYWcvczdYN3FXZUFRMUJuY1BYcEZkOGg1cWNl?=
 =?utf-8?Q?Yo3nxuk56sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXJkNVptMEhOQ1hPTituYVFsa21QMGxwcXpqWDBUMFdWWWs3c0dObmU3N29n?=
 =?utf-8?B?eWtTaFBtM3kxclcyQUlicThDWmpPbjlqK2dCQ2NzMDJDYjBldkdlVldxdE13?=
 =?utf-8?B?cWNINGNPaWhRZmgxbDM4SGlIVnRHVGdRM1pqQnJRQmRVZ0k3ZURWZkkrN2NN?=
 =?utf-8?B?Wm1ZcVBuaFdNTmkrdTZNcWUwQkFnQVhjd0ZWVHBsUldHdDUrYk9CZFRkR2Zw?=
 =?utf-8?B?UE1XMGxxNitXa0FaTDlLdTlBVm9KbUR0RHRGOEd2UE5QMTlHbFhlUHBKeW1t?=
 =?utf-8?B?WDJiSDRsMEhjUGhsMmxJaUc5MFk2UzRJUE1RZVQzQWlMT1Ezb1EyOHZsUUEy?=
 =?utf-8?B?U1VsTjZ1L0k3RkZOVXlMVm8wVzcwNlpPWEN5Uy9VRzkzLzE4ZVFPOGlCT0hY?=
 =?utf-8?B?Mmh5MWRCZ2htUWh0OHA3c21kVzAzeURuMDhsbHcwak44MS9ZQkF6TjRZMmZs?=
 =?utf-8?B?UldIVTU0V1Z5TlJwUXgwT2dKaDdPNnMwWEovem96WE9GUXBMOXBpMnV4SklO?=
 =?utf-8?B?QXRkdlNJbVU3cU9zNURFZmlRUzV5YzNFbGhPUW1vYWZ1MllKRFpWa1AxbmtQ?=
 =?utf-8?B?cW9lVVQvMDhRZnQ4b2h1V3c2UVA0dm9aV3k3QnRON3VqWHNEa0t6OE93TWNE?=
 =?utf-8?B?NnFlZHpTdDJDK3BSbVVSWlVkcjI2U21zdGNGNDFnWUxwdUJUT3JOYnR5Z3JG?=
 =?utf-8?B?ZVN2RVhXQnVGNFFhb2VwR1JkTGZGdllMTVZMbEpjMXBqNlRtRm92UGVWdDdx?=
 =?utf-8?B?d0RaYzBoQnM4SVo2UFV2SmhXTTB5Z0t5dGxGU2VEZlBScmdKZW54aTh1V0lS?=
 =?utf-8?B?aVI2TXY3dTh0UjZlYnFBMmw2TUZBdXVIZnd3NnpPc3dTSTBsb1hRNWFsUUwz?=
 =?utf-8?B?Y1pmdzltTTRYT2lkNnhSU0JuSmJneTJlWFBlSktzRmVWU3d3aWlNb0l0K3B4?=
 =?utf-8?B?ZFhxNzh4cjFjRnhyVVdXOEVBS2lvaVN5aDFMYXVYbWw2Y1JWL0x4WXNOdHR3?=
 =?utf-8?B?WW84cUNoNThsVWE3RmVTREgvU0lHcGFuZExnV3VsdjMzRk5xNmFucTFjN1Fx?=
 =?utf-8?B?VStCcFNOODJub3FaUGVzK0N5dXFYSzYwMm54YUx5MUYrNWMwZVYvRkkxeTNy?=
 =?utf-8?B?ZWhrNTVuS3lFWXRiT3FmdFF5M1U1MGJEQXJEWVIwRno2VGw5alNCNCtWb1dv?=
 =?utf-8?B?SkdDOEVzR3FVdmlkaWxna1RnT1pmamlXTnBwdGNxdkJMZ3RqTFh4RnRDSDNZ?=
 =?utf-8?B?dWZQSEJadzZDU1lpY29yeVRHWVQ0c3drMmlyMlVpNkpMMER3dEd3TzIrODV4?=
 =?utf-8?B?dEI3UituN3IrTUkxTU8zY1dFZFI3VWhSZEtQSS9vK0RoNnBqbHQwdXZXRXFy?=
 =?utf-8?B?TTFsUmdQb3ZJWHZnbzRaSktDVjB1RC80WTFKUE9XRExkNUFnRWxDY0xBUWYx?=
 =?utf-8?B?SDhBRm0vckd3eDdMTExvSnFROHdCeEFYZHpuVHJuWFNoSk95TjU1UTIzYkpT?=
 =?utf-8?B?WXVCUGRRUVlsL1Z5azIwWXFYUjlmaDFTVUxrM3RBV1RoWWFTTitBbmovU2I4?=
 =?utf-8?B?WmtZcEdJSHBMN25zWWNOeCtwR0ZKMExMMXhZTzlkeDVyNGhzU0pKY0NWaXNV?=
 =?utf-8?B?TWZyUTF6QlZta1c2L3luUkJPdkVqNFJISldyNUNNWGh4VHZXcnoybGRtWjBK?=
 =?utf-8?B?ZTVNTWNReCtNNkJmS05SK3pxRElBRDNTR0J6QVVDMWpPZmJoK2h2ZXhoRGlP?=
 =?utf-8?B?ZEk0YjVwZGw3UlZjOHVmeFg3N3h4aXZ4Z3lVaWcya0gvdmxOd05pbjdRVFRp?=
 =?utf-8?B?OElSa0g3VkQ4YThWbWxydUFTMy9JRWExNXFvMnd6R2t5QVcrdnlTRVZIeTNQ?=
 =?utf-8?B?Q3krMFhWTlM5RkZjTmRwdUxPNDRMR2dRd3lmQnVaMTVERW9hSnZoSUx5NWQr?=
 =?utf-8?B?NVdhSFl5aDcwQnR4OUEwSFExM0xhR2plVjRlNVZhQyt6bGpsNXo1U1Bza2p6?=
 =?utf-8?B?dW9Qd0Z5TnRIcFUwaHR2dVZNdGVwdnFhSHdwa1hzWjFhOWw2dE80K3RlYThs?=
 =?utf-8?B?enZoNXVob1NXQ3N5dVZQQnFMNWYvT2RSR083NnJDcHBFdU53T0JrTWJNZUlY?=
 =?utf-8?Q?0iuPfp37EZFct7md3+9KFSINY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ee1f22-1812-4fda-b3f3-08ddc97bdc5b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 23:59:57.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkO6fzwRGMtnaPnFZrsYmMfoRDg2PADPy3xK/KjQRXRNyOM71cMv9/vaUFHJ0F3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

Hi Reinette,

On 7/17/2025 10:56 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> Resctrl provides a user-configurable option mbm_assign_on_mkdir that
>> determines if a counter will automatically be assigned to an RMID, event
>> pair when its associated monitor group is created via mkdir.
>>
>> Enable mbm_assign_on_mkdir by default and automatically assign the counters
>> when a resctrl group is created.
>>
>> Counters allocated to a resctrl group should be released when the group is
>> deleted. Add support to unassign and free counters during the group
>> teardown.
>>
>> By default, each group requires two counters: one for the MBM total event
>> and one for the MBM local event.
>>
>> If the counters are exhausted, the kernel will log the error message
>> "Unable to allocate counter in domain" in
>> /sys/fs/resctrl/info/last_cmd_status when a new group is created and the
>> counter assignment will fail. However, the creation of a group should not
>> fail due to assignment failures. Users have the flexibility to modify the
>> assignments at a later time.
> 
> I find that this changelog jumps around a bit. Below is an attempt at some
> re-organization. Please feel free to improve:
> 
> 	Resctrl provides a user-configurable option mbm_assign_on_mkdir that
> 	determines if a counter will automatically be assigned to an RMID, event
> 	pair when its associated monitor group is created via mkdir.
>                                                                                  
> 	Enable mbm_assign_on_mkdir by default to automatically assign
> 	counters to the two default events (MBM total and MBM local) of a new
> 	monitoring group created via mkdir. This maintains backward compatibility
> 	with original resctrl support for these two events.
>                                                                                  
> 	Unassign and free counters belonging to a monitoring group when the group is
> 	deleted.
>                                                                                  
> 	Monitor group creation does not fail if a counter cannot be assigned to
> 	one or both events. There may be limited counters and users have the
> 	flexibility to modify counter assignments at a later time.
> 	Log the error message "Unable to allocate counter in domain" in
> 	/sys/fs/resctrl/info/last_cmd_status when a new monitoring group is created
> 	but counter assignment failed.
> 

Looks good. Thanks

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/monitor.c |  1 +
>>   fs/resctrl/rdtgroup.c                 | 70 ++++++++++++++++++++++++++-
>>   2 files changed, 69 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 026c2e2d19d3..e0706083fe0e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -457,6 +457,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>   		r->mon.mbm_cntr_assignable = true;
>>   		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>   		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>> +		r->mon.mbm_assign_on_mkdir = true;
> 
> This is a resctrl fs default. Should it not be set in
> resctrl_mon_resource_init()?
> 

Yes. Moved it in resctrl_mon_resource_init().

> 
>>   	}
>>   
>>   	r->mon_capable = true;
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index b7289ce2b3a6..645245f274e9 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -2884,6 +2884,54 @@ static void schemata_list_destroy(void)
>>   	}
>>   }
>>   
>> +/*
>> + * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
>> + *			     a new group is created.
>> + * If "mbm_event" counter assignment mode is enabled, counters should be
>> + * automatically assigned if the "mbm_assign_on_mkdir" is set.
>> + * Each group can accommodate two counters: one for the total event and
> 
> "Each group can accommodate two counters" -> "Each group can accommodate two counters
> per domain"?
> 
Sure.

>> + * one for the local event. Assignments may fail due to the limited number
>> + * of counters. However, it is not necessary to fail the group creation
>> + * and thus no failure is returned. Users have the option to modify the
>> + * counter assignments after the group has been created.
>> + */
>> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>> +
>> +	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
>> +	    !r->mon.mbm_assign_on_mkdir)
>> +		return;
>> +
>> +	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
>> +		rdtgroup_assign_cntr_event(NULL, rdtgrp,
>> +					   &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
>> +
>> +	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
>> +		rdtgroup_assign_cntr_event(NULL, rdtgrp,
>> +					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
>> +}
>> +
> 
> Reinette
> 
> 

Thanks
Babu

