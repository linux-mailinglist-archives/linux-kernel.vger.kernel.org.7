Return-Path: <linux-kernel+bounces-741447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F372DB0E448
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D8F7A7B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3A283FFA;
	Tue, 22 Jul 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DMA2c9RV"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA26156677;
	Tue, 22 Jul 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212874; cv=fail; b=Yt5mpnaTbvUqmJvTKaGYgMt8ohjFKZ5em8leunNQs07gbAW12j7dcFllDIzm881nMR1ivnIg/4Z4khftuIZG8wN5ShbFIcb17/9yLDuiTVvig4KK0ExkGOX59ivjP4KDAlicKS3cPSmfA0d14xGxknAU/gxYKiFYFc3MOVc4yPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212874; c=relaxed/simple;
	bh=lEVgIo3Rze3ua6nDrY6I01/5xHtEe0jAqu7Ysz9uOmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AwUd0YK+eGdPdqlint6OEuT0qw6CCeN2QeZMjPlqWt7NwPzFG71sbG53aj9KnGpmDhnMmrZZdlLVARygaKAK1xHn2ZDZ4ael1GdRCXo6wdWkOpz1au5S5xTr8PlTZ5PEeOwUo6mDCcxCIokWcvn9ZXR7dQyHbYZhvypkXRh7BUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DMA2c9RV; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/rPLOkwekhDZiJIY3kHJQA30soHIgYDeGnajvofKpFv8k4hAtIJuEzLkUsk5wtZu+8sYNJzNwyU/TGFSPvmDRqrVAtY9dM22tt5oH4kKsYqr2N3h+G2UyBjnBDdrLKh1nK/IeKAMsMqoVGR8njRGNWPhXnDI6XLI0c8S1BvLHDMElg9EDi8ba8YTxyQis07uZrs4u0WzIXIBjuhUXXOJOC6hNYv1oQ/76pFM4IdfUsXgp6tAgzfkQYzPE7soMeuvTCt2VbWLhrWZEIcUCp7sJGfWI0qUOjOxRr/KYdU5pE/IVILY6X/dKj7kuMKV6bHdnd3l+BVEkyaCcKfm1PjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIwH/mVNRdc9U1rmEa3w5tZfTN2mVNIBkBKaYzKRpb0=;
 b=D0AtxvAxLqkVBpg6q8PtiR8h8R6UCaPrIpvfyOpQzCoKIEMsmmjnfQVRtnBn7hbkZDaO/P1aK8gMBJuQOYZwfL5xz1sSIAx7STftwduiULM1Y5ME7QhBhwcnD+7/ByTj9Gf+GGHZPbDnMC8uNrRcMIqDemuaJ2ukfm/iectE7JT/BTeUqt0V3KFH1qlcUuF4uRQ3YSxCb0JmAZXKB8ZzxOHCBdIuRpwtUiaqTbAbw46SFoIwS+f8WaL8AOG09vZVjsQlGJxZ8CDsLrVRwgAJ3hb7hbkleu81Va2CJIAkFidHDPmgFBafy9nBH9UiGmT/OaF2sLJ+TakklhxZpRZVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIwH/mVNRdc9U1rmEa3w5tZfTN2mVNIBkBKaYzKRpb0=;
 b=DMA2c9RVRtsb/cpK2+UKYxev9vPtlWtjoYi+5hSb0Uei6jXIwH9pdYaOIUDzPKSL8VialzgGjzVzxpYi47ur75t/wlCfw3FP9Zo59boZCiaP7StqCUz/hHdGHTFxgR8M7XuZ0bL6sMTMq47Kx47etdYk6rc1u5qcWogceYA5o6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 19:34:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 19:34:28 +0000
Message-ID: <f4437f90-6e73-4901-b2e0-6a215ecb4d24@amd.com>
Date: Tue, 22 Jul 2025 14:34:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 25/34] fs/resctrl: Add definitions for MBM event
 configuration
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
 <4a08cb0b35f3f7aa759cad20cea0733f9480cb34.1752013061.git.babu.moger@amd.com>
 <48df72bd-edcd-483f-8ad6-318a40b07f08@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <48df72bd-edcd-483f-8ad6-318a40b07f08@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0175.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: beed6b8a-b4a3-48a6-fce3-08ddc956c60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?empBcjRNL25QTFAxUTI4NlNHbzJ3T290bkd1UU4vOHlxMTVTeUdJZVZXQTVJ?=
 =?utf-8?B?YjFRZjJqV0xRYklGTWNURUFBOFN0R3Qwa0JuaHlkVGxYYlpjZzVrYTlxT0tj?=
 =?utf-8?B?dHVzUTRNTVp4UU1rejVwb242WDZlMStxdXFGUXFIWlREbVh4elZxMkRkeHJT?=
 =?utf-8?B?TFkzYXpwcGpjdEEzM2RHdHpneVZ6SnhKelM4NTBITHgzQi9hMVFqdDdWQ0pM?=
 =?utf-8?B?WTdlN3VJM0FwczdWRXBHVEhPazhPTk9hMXMwckdXdldZcHJMS0tJblZEWnRv?=
 =?utf-8?B?eCsvSHF5YVpjK0tVejN4ZFBnMnFnRW1KVm1IN2h2R2VHVUd6OUZubURsYVpB?=
 =?utf-8?B?bTZJVGtMWFBOdklleGlOWit2SWVzL3phN0cvVE5wLzVGa1piK1VKZGtHSTlM?=
 =?utf-8?B?Ym5EaWRlSmFGeVd1aGdOd1RJcjd0N1pCWTZzNkZRZXlZVnZlZU1rZE1LKzVi?=
 =?utf-8?B?NXBPN3l5T2lVWE1rVlYwcW9CSmZKYS9USUdsbm1QTjFyYXhKNGNNLzB0bHhq?=
 =?utf-8?B?Nm1TV1A2T1FlZGNYN1hJM2dsRzdoMnd3akZ6bTR5ZldFY1UrWnh0Ym9HQUsx?=
 =?utf-8?B?OUgyUXFGeDVJTENrTURiU2JQeCtnbXdRT09wSlZYcDk5eVRsQkhoYWc1QXBG?=
 =?utf-8?B?ZUVTS2J4K2RreEwzMDE0S0ZDTm1WajFsYmtZZUNmQlN4WVFibzMyRkh5ZXNr?=
 =?utf-8?B?bkE2UmtNcXVta1lzOG85WmF2TStjMHlPODBKSkxoWHNaSzFVdUt0U1NnZ1lP?=
 =?utf-8?B?ektiRk5SbytFQ0JXakVORU9hbEZKWTh3VFVRWGF5YTcrb0l6OG5kMW1PeWZC?=
 =?utf-8?B?dUYrQWN0Ty9yU2ViMFFUNGI2eWdrQzF4S3VERkVnMmJOUnlxaWZONXVJZmJQ?=
 =?utf-8?B?Vll0eDl2STIydElyalBqaGtoU0RrVlExekZRU1QwcU9CcDQzTXMwUC9CV01y?=
 =?utf-8?B?emNZS3huczNsVlpxd3NDUjh5bG1SOEdiZml4cEMyN0lwNWlLK0NweWJjcGV3?=
 =?utf-8?B?QkZmMzBVV2plRHhsck4wUjAzWGp5Vm1ZZWliWWtXdENwby9POWIyMGZQZjJN?=
 =?utf-8?B?bndHUWZlMEUrd2VnZmR4MFp2eVZZZC9RNHdYVm5OTnVnVHZvVFphYmFoTFJ2?=
 =?utf-8?B?dGJmcE1JV0I4WVNGbUVFYjU3OEhDRUNTazA5SjdQQVhwUVBEd2dwSXpseEVq?=
 =?utf-8?B?RXB3WXNlOGhrcDhaMVdyd3ROYzllVzkxeGxZdVBZZDl2cDVBNHA1NXQyQVVl?=
 =?utf-8?B?b292Q05DdWwwb01ha0x6UUZNK0NweHBMZEhVS0dTdFJRT3oydDMvY2EvendX?=
 =?utf-8?B?OGE4Vi85RTlYUlVhQXo5azBoZlI0ZDJOUU9jdUg3S0VXVE5hZHgyMGFib0Yr?=
 =?utf-8?B?ZUlRWjNYV3BxaGlvQU9WR0dYUE9GQjQ2R3M2U0FVcFFiOHUwY3VUTFM2dUZy?=
 =?utf-8?B?YVJXM0oyU3dzNjZYT09QUXR3TXFMMDlqcUxINTNsWS9jQnNYT05DRkNNcUVr?=
 =?utf-8?B?WXd1TDNndXhMbXBDZkJ5anJ3QWYrcktTMC9kRk01M0Nrckp4K1hnc1NhQmZI?=
 =?utf-8?B?TnJINFlDazYyNDBJcDZMcDFMbVhNcGsvZDlBTlBBaXpYYkYxam9xdzZteDIw?=
 =?utf-8?B?Z0FJY1pnSlliTGh6RUMvWWZZbWZnSjVRT2xkbTV1OVRzNWFuUlUrbVBTZzNT?=
 =?utf-8?B?c1VJSkJHWS9DNktWMHZuYVZGMHNlaGNPYnRId0NRSW00aWxKWkhrRUg0aGsr?=
 =?utf-8?B?L2V2UjdWdVZIWmQ1SVNOcFFGWngwWFV5Qzg2VjlkUXIydEwvWUFmTk8rK3Iw?=
 =?utf-8?B?Zno4SGFzYXJyM0RGN3EwZlBaa1RSeERsU21BcU40a0Vzay9PN3ppT01FMW5O?=
 =?utf-8?B?bTZpS09VZDh4YjZSMk5PT0M3S2ZvN2ljSHRkVVpWRE5UbWp1QlZ3Zmc1RExP?=
 =?utf-8?Q?VeSPTv/m31o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUE0NXp6T3BjbDZDTHM4WXl2ei9odXNaa002ZEJidXBhRWE4M25HUEFhVUMz?=
 =?utf-8?B?L2hhT0ZpSUhCUFZuWDNtU3dPM1pHdm5Lb0J4SlhEcDFuVXZkaU1tOS9WNUJT?=
 =?utf-8?B?S1FucnRPWk5zSlJhczluMG8wQUoveGl5VUd6VHNFaFQ0V0IraGJ4OGt0a1pW?=
 =?utf-8?B?U0V4blRIWk1MQjBqeWZUNTd6cWk1RlVDVnUyVWZzNy9nczJ6enY0OUxLNlRz?=
 =?utf-8?B?K3lvWmZZcjQyUDdmS0pWRi9VVTh2MHltT2ppNmw3MklsbWdBMnAxWVh5VTNt?=
 =?utf-8?B?TUNUbWdvQ2gydnR6RnFueTNBbmJkRWYzUjNNR2RBZVFyaExielJLNk9ZUHRM?=
 =?utf-8?B?c3Q0U3Z2V1RRU1YwaXJGME1zaVRrM1d2V0dKMFFUZ2o2L1FyKzhPSmxMSzFT?=
 =?utf-8?B?TWZub0lVM2s0QjZwbjR3b05DMDh3ZFpqSWNtRkx4eTBPbVlKOUkxZEJNRlVl?=
 =?utf-8?B?dzZ1dVBLYVAzalpSU3dkZmJxTGR2d29TN2dmQXpNTkwvN2QzeU1iYjdROFh4?=
 =?utf-8?B?Ri9vSWJjVy9peW9uYTJ2RTY1QkhSQXpJVlo5U1lnbE5xYkVvWHdvdUpHV2s5?=
 =?utf-8?B?RFZjOXRSTFY2ZHE1K1QwV09wSUxVK0hNZXd4bC9Fcll6VlYvUk1JNURHUnVu?=
 =?utf-8?B?d1R0YUpIdWhNNDJUWXhHaWpFZ3VpWGo1ZlVieDJ6ejJCR0JOb3ZhSDFWd2JP?=
 =?utf-8?B?a1BLSFZnelZjZW9YUHYvbkNWU2h6RFVBMnNJU0k0c041T3FLZDZHYTJUNDRX?=
 =?utf-8?B?QmN4Y0J0citDM0lSdXF1dkp3WTJwRytLWUlRanFZYWpHME1lQnZjSERTWldQ?=
 =?utf-8?B?QWFxdlBpRHhsdzZIT0ZCOEhCYTFLcXFUdUxuak1lV3ZCaGt1WWZyaCtjVGlL?=
 =?utf-8?B?eWMwRDUzMkprN0NhYUhiZjlZMW9ETmxsM0pjSUhkN09aRVVDa01KNkFuNTJF?=
 =?utf-8?B?eGk2Z0hwMjRwQWttWmxhRXRLM29QT3RCSUhxc1RZcXJrNzBKOUNIUlVaN2Zz?=
 =?utf-8?B?bUtQMW9JM1phTVpSRlFEaTk4SFhwUHZ3ZUMwTm5rYkUvY1Z5UGdoY01iUXdN?=
 =?utf-8?B?STFxNUJVc3dBcEpScjFMOHJIcWd2Yi9GbjZLcUZTV2VUM1NDR0VQV0UwNmZZ?=
 =?utf-8?B?Zm5kSWozRFNFUnpZQUh0NnpnNHl4bnQ5anFnUlBSZEtaWFNQNkZGcGJKeFdl?=
 =?utf-8?B?SW44TVFkSEpqaGlESFJSdFhDV1dGczBucHEyTlgyWmJDR05YazJCRksyY0sv?=
 =?utf-8?B?TklJaEJIaDJCMjJabk9PRUtrYkFwRmhxM0NBUWR1WGd5aFlKY05qTEI3ZFN0?=
 =?utf-8?B?VDhKbGgxd2hTTWladzFCOHZSczZhdmVCUFl6YzVwWURmeW0vRlc2TjN0d0VW?=
 =?utf-8?B?dVB3T3pUZ0FrVHdHTEVpSzdSVjR6N1RCYWVnUE91eTNhNmFzUjM2VnZGTG1W?=
 =?utf-8?B?cHZzWVA1WkxCZG5SUVUwMjZoOWNPaGR1c3ZBTkw4bzJRRER6UlVNdXVvRkgx?=
 =?utf-8?B?VjM5b0tyc1NvdmVUMXozZS8yVUVLZEx4RDV5VEZZYWNrQkFPMnIrQ1FWZkh0?=
 =?utf-8?B?WGJoY1lySFp6c3ZJTzhhWEozVWMzQTRyU2FGeWZFd1BKelQ5RXpNT1JyUHNY?=
 =?utf-8?B?YngyeVpxYnZOMCs5MWF6RElLZlRLdHpNU1ozRWlOeTdCckgrclk5azZaOHc2?=
 =?utf-8?B?QlF5VXN2QlUzUHJwZjBGY1Q5RjNrMXF0TmwwY0ZBMTJJcG1TRDI0UVFEMmtq?=
 =?utf-8?B?ZmF1T3BsVXBOMUdVc08zcUs1S3p1bGNSTVBxVnNVaG1MV1NON3dKT2EwQ29p?=
 =?utf-8?B?RjFMZ0loQkErOHhxbEF2cEFvc3gzanBjakVPYjhpOS8zakxxUndxcmF6NEo5?=
 =?utf-8?B?R2VrSWc4d0Z1TGJ5cFB1cjE2Ti9IWWIzaDJsK3lydHVESktiem5wbStTeG1S?=
 =?utf-8?B?T1ZYMWptZXhvb3RIN0VSVG4vc2NyaDl2d29zT2praWFBNHIraFhvQTdpM3cv?=
 =?utf-8?B?dW1hYmpNRHI4SWN3cFI5QjMrNHdNdlAzeXYxdVE4a2NWNWhGeFV1U253Ulk2?=
 =?utf-8?B?TlY1ZnhkQytrRmdtZGhFZHExMDIzSFJmcU84dTVRQ1hUZDQ4YldMKzlZeENI?=
 =?utf-8?Q?QwNk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beed6b8a-b4a3-48a6-fce3-08ddc956c60b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 19:34:28.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoXKYTG5ylmOt/pdPZHcQd8MF4xGCRwie0j0wscBNfxFF61Fpmls47r1VDgxV4nY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

Hi Reinette,

On 7/17/25 22:55, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> The "mbm_event" counter assignment mode allows the user to assign a
>> hardware counter to an RMID, event pair and monitor the bandwidth as long
>> as it is assigned. The user can specify the memory transaction(s) for the
>> counter to track.
>>
>> Add the definitions for supported memory transactions (e.g., read, write,
>> etc.) the counter can be configured with.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  fs/resctrl/internal.h         | 11 +++++++++++
>>  fs/resctrl/monitor.c          | 11 +++++++++++
>>  include/linux/resctrl_types.h |  3 +++
>>  3 files changed, 25 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index fb4fec4a4cdc..63526400e632 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -216,6 +216,17 @@ struct rdtgroup {
>>  	struct pseudo_lock_region	*plr;
>>  };
>>  
>> +/**
>> + * struct mbm_transaction - Memory transaction an MBM event can be configured with.
>> + * @name:	Name of memory transaction (read, write ...).
>> + * @val:	The bit used to represent the memory transaction within an
>> + *		event's configuration.
> 
> Please include something similar to the mon_evt::evt_cfg kernel-doc to help reader
> know where bit values come from. For example, 
> 
>     * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to represent
>     *		the memory transaction within an event's configuration.
> 

Sure.


>> + */
>> +struct mbm_transaction {
>> +	char	name[32];
>> +	u32	val;
>> +};
>> +
>>  /* rdtgroup.flags */
>>  #define	RDT_DELETED		1
>>  
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 35faca7ff3b1..1670163649e7 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -920,6 +920,17 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
>>  	return mon_event_all[evtid].evt_cfg;
>>  }
>>  
>> +/* Decoded values for each type of memory transactions */
> 
> "transactions" -> "transaction."?
> 

Sure.

>> +struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>> +	{"local_reads", READS_TO_LOCAL_MEM},
>> +	{"remote_reads", READS_TO_REMOTE_MEM},
>> +	{"local_non_temporal_writes", NON_TEMP_WRITE_TO_LOCAL_MEM},
>> +	{"remote_non_temporal_writes", NON_TEMP_WRITE_TO_REMOTE_MEM},
>> +	{"local_reads_slow_memory", READS_TO_LOCAL_S_MEM},
>> +	{"remote_reads_slow_memory", READS_TO_REMOTE_S_MEM},
>> +	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>> +};
>> +
>>  /**
>>   * resctrl_mon_resource_init() - Initialise global monitoring structures.
>>   *
>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>> index d98351663c2c..acfe07860b34 100644
>> --- a/include/linux/resctrl_types.h
>> +++ b/include/linux/resctrl_types.h
>> @@ -34,6 +34,9 @@
>>  /* Max event bits supported */
>>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>>  
>> +/* Number of memory transactions that an MBM event can be configured with */
>> +#define NUM_MBM_TRANSACTIONS		7
>> +
>>  /* Event IDs */
>>  enum resctrl_event_id {
>>  	/* Must match value of first event below */
> 
> Reinette
> 

-- 
Thanks
Babu Moger

