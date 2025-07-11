Return-Path: <linux-kernel+bounces-726936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D087B01308
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D9F7B19B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C41CD215;
	Fri, 11 Jul 2025 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pmt+M7DX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0DF1C700C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213171; cv=fail; b=X389pVUHKLXQPvhCSca9giQrSMvDi+KwBCwfsqsk4zLVRFlwqwwMSI5qG6/r8xsH9rdE47yChsitHD7HkIK7M2GOK/ex1b86roaBs8YEbJD8CNNudamMVfEiiZI3rlqtXKcb99KD0jn7aiauvL6snbV0j/3pLmN9ODDMUtOzb+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213171; c=relaxed/simple;
	bh=+Rja9DOyVllIvSsPEy76CiRO+gQNFCAeS0BnhgIlK/o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNilRbhYQg63uwaOAAW+EjKSCOdbNI5j2QqeDS5ZtNnhFKnSw4TgARpRHh9s6vzLhWgrFy7qA08d+MwNx79P6B7cjE6KvR4ZcvuAy+4qeeiZm4Ebq0kM01TTlivGwiJmnT/OQxhZCZM1ZT8HaZb97PTWEPWECLDSL4IgCsO8QWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pmt+M7DX; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBAbE7QnPTFQc06Snd/1SlNfRR76khpppZ/lBUoKJUYGTR7NA/4Lq8mjQ0YAkM9eSYIzqMaOGhNJb4tna83n6H00wkv2Z71Td2E58XGGtdKDXGwTppEZn/RMGg9WnDxGBls5QsU8M/vvbxldKRr8C3xB1nGIZDCai32szePUcJYgcLfYY0kNWx4/L4qMaU57gafE7DKKJ1Y8qet5Hg6/vw6a1BvhH+Jqa9qo7u46MXfZ5bs8Er8xBU2UOQjsd4aqHWyvmV+sUHGULC0d+MKQjnHDFqF+vo+k64il5E/iPKNEPzHlh7SPy1+Afw+GrFWMwQPsxJz6F/QDpjxdpE05XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pElLWr8vBEieZuUO2oD7M1NubX/EV/pYvupT6hPa14A=;
 b=ANFD6CX39TFwLIK4PW9g+aszOQggoa5jDr96AigMJ8zgZWmkgN8ucizuwY1FVQehU7txwG3tiMSRVaygPV7Px8pVXmw5in/vielcrEJZFG86IrzCP5OIu6Re6IEdARM9PuqrDGjdJrYijwUNnkujjL+qx34DZgIRxD8sxaBRO5X4STN0F4Wi1MuPgFfL1d7Dr74RfLH9vcvrNKUwQsTr2+lAiz6GyxnVnNXcqz5ZGtE/92Q/I0l6WT1sukZ92OXuF02Co1EfkDl+FZY2sqrsP8b9IcnnJkAXSeRhtVnjx6kGj+lx3P5CxFwWk/WEopRfgDbYiM68qSemWonj7dcCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pElLWr8vBEieZuUO2oD7M1NubX/EV/pYvupT6hPa14A=;
 b=pmt+M7DX/Vj6XUbJS1Y46v4+a/9oqwUpumE6oa+QZVqMBTAL5Oc/f3sNTkpOlj1cinv8rUxV6ENdQURrr3PwSW8eHCgUADbiMlSDIt9USGkm8wIZwiFXa3bFlOV2JRaPlHpCPP7lDVqXI1CYq+2fXdslZf2wLTpd4mXMQDP7l7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 05:52:47 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 05:52:47 +0000
Message-ID: <383084c1-370d-4cda-8d5d-01f7da827b50@amd.com>
Date: Fri, 11 Jul 2025 11:22:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] x86/smpboot: tidy sched-topology and drop useless
 SMT level
To: Li Chen <me@linux.beauty>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Sohil Mehta <sohil.mehta@intel.com>,
 Brian Gerst <brgerst@gmail.com>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250710105715.66594-1-me@linux.beauty>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250710105715.66594-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e9bcd0-6c7a-4e22-7b21-08ddc03f2988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9jK3dRVXVJQVJSVWJxMFBrd1VOa1NITVE0OFRwY3l2UmlneUo0QnJ5WDFQ?=
 =?utf-8?B?TjR2YTdvKzgwVi82VUZtUDM4SG02Nmc2c1ZLUGpCeXBDeUR5M3hzeEY3TGZQ?=
 =?utf-8?B?YUU1dVdmejloWHZSaHhDQkxLbU1nQ21xQkJqZGxKWGdUREN1YkUyRmVVU0E2?=
 =?utf-8?B?UTRnOFFjRVdZdVhOQW9hQjBWZE5pZWJtKzZzRVg4a08yNkYxZ0YweWtISVhk?=
 =?utf-8?B?aWdybHJpOW9sN1JmSGdLNE01blJnTHJPb3FGdkxRcWlPSUNFN1BULy9mc0FT?=
 =?utf-8?B?YXU3UGZrcGRGUjVGYlFKd2VXNjBPV3BjRUhlckorOXpVd2hpNlpvamkyYVpw?=
 =?utf-8?B?ZUg4UkJPODUxL1JrQmFNOUNablpReWJ5endvV21xTkxqZjJwbmdtN1VIcm5t?=
 =?utf-8?B?M20wazJzZ3IxSlNnRXdydVlXcVdPbi9URHBzRnJOWWk5RkZoVVNzaTBRNEps?=
 =?utf-8?B?MmpmT1FXYUhETFE4WStzWUNqVFVZeG52K3Y4Ty92Tks5c090SU1oM3FYaVl2?=
 =?utf-8?B?Tm40NUVsWGs4d1hYa3FnMFBWUUQ4TE82VzdhR1FwOHFTbHJYcDdnSnhqSFA5?=
 =?utf-8?B?NmtoYis5OEYvZTJMY1VEOFV3VlM0cytTUWkxY1REMERqbWV2ZGF3L0xtVGJk?=
 =?utf-8?B?UXU2cERkRVRDYm5kYnhablBlam03VUNyRTFzc1poVXhORi9qQkxodzhHMzZN?=
 =?utf-8?B?R1ZpZjEvN3F6UGZHNVorRFQ3QnU5aVRoVWd6SGRDSmZtK2xyWHdqYkhaZXVv?=
 =?utf-8?B?bSttTVdqRHcyZjl1TjhyYTNoUnRvSmMyRkloVStxMjc0VnpaUUcwekFiUW1w?=
 =?utf-8?B?R1l4YVlLS3YyUGxGOUZkclJSWTNSZHp5S1hPR1B3Y281dWUvUHBleU5RK2h4?=
 =?utf-8?B?cGt6T3c2c1ovYmZqSjFiTnJKVzJRVTRmUFdFamg5MURxaHdhWGtsZHc2cXBV?=
 =?utf-8?B?MVNtYWlubEhyTlIrU1J1RmFoQ1JvRndiYVdFYnB5Y3NEbklTdVZuTTVJNU14?=
 =?utf-8?B?WWRNc004a2NJbW9hdzdrSHY4VWR6djJUS2F3eDJ5b1BCeFk0aGVIeDNsdkNX?=
 =?utf-8?B?WDQ2QXpkUEZRejFMMEJDanlxZzAzZ1E0QjlLVG9PT1p4cDFkS2NJK0FhYTB6?=
 =?utf-8?B?ZU4zUnhkY2ZGdTFHaWc5RlBLNTRkODA2SEphak0vMHU0di96aU5hZGRWWE5N?=
 =?utf-8?B?NzRaRlRGK2tXNytiVXJOQktxNVA4YXRKaGFuUDNDZ3FTdUhYVmR2NDVKWjZs?=
 =?utf-8?B?UVVTdXczcDZickdwTHZnNVRTKzcrbzhXTEF6TWlJOHkyYmxjUHNyelB0K0Ur?=
 =?utf-8?B?UmNvMjNGQW5KM1lBaU9MYkhIeU9UNjZxMFVEK01QUmRRQWpFMWNvdGVKcDcr?=
 =?utf-8?B?d3dQck1Qa212RWNTb0NiZkx0ZWVKWDljY1NGTXdScjM2dGd0a3daVld5V25I?=
 =?utf-8?B?RGNCNjZwcSswVXdDd2RPQWVCSGZSd3FOdHFBMnlXL1pIejVGcmIxOGdhT2Vq?=
 =?utf-8?B?ajk4L2lnVHhNR1ZDS3N0TFBQY0lvZng4KzlIaFZHTUUrRnRxanJ5YUo5eFda?=
 =?utf-8?B?a0ZpNlhHTjFONE13elVQMW1ZRGxQdWpwMkswRVpoL3RUc1ZlbktWRjdxc1R2?=
 =?utf-8?B?QmxvTUVWR3g0ZmNhVGVuOGlxQm5Rc3Z6bzMzT3YrcFZCYkVoczlwK1c3UEk2?=
 =?utf-8?B?c254bUt5M1BrcGplK2FyRk85WXhTRzNCT0dObTUxNWorWGFlcDM3b2ljc1ZC?=
 =?utf-8?B?V2pIUm1OK3VhWC9NWEY4bXhFbU91SWpyLzNiakRpNzlnV1hjRWpuQ1Q3c3o5?=
 =?utf-8?B?TU1hOVN0SU1RUW1RZjljOXVLYmpzMmw1bEFUZ2g3TGl0ekhYU2ZYazJ3WDlU?=
 =?utf-8?B?aUZjN2FGamk5WU85NHFmcTViMUtBRVM4Zi9rRE9vTllnb1JhZTJHOXduU3NN?=
 =?utf-8?Q?p4QZMrk86q4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW81QUUrbFVyQmE1Mzg4NFVBa3hwTjI5bk9za3pwdjJSMzc5VkhQTGVua3o0?=
 =?utf-8?B?UzlleFFLTm5RK3hiUkJ1TjdSQjhtRGxWczhVdHdhTnZQYSs2dTgzeDUvQm5v?=
 =?utf-8?B?VVNPeXlDL25iUU1jUGhOZUwvRjZOL0NlR2U5VmVPUWJ1bmRod1RpczJkTHo1?=
 =?utf-8?B?cXNuZ2tpRWFicCtRS1o5MTc0NDh5UFNtc01Xdnd4MXJNZHVnazhxRFZia3o0?=
 =?utf-8?B?OXlIVFFjUGxhV3JEcXZ1K2JodUdvd2hhcncwTGRhL1gwMjFTMjNmSTNzd1FU?=
 =?utf-8?B?dTIrdzU4MFJDQW5BSHg4cFcxcDNQSmpPZGZQbEdpNEhBZkd5NGxZUlZUWE1i?=
 =?utf-8?B?WEtpK21OVVBVY0VWOTc2K3UvMUltK0p6RmdzK2lSRkhrUjdVcStPZTAzQTNV?=
 =?utf-8?B?ZTBISkExU2lpdFdiSFk2Y1N2MEk0QktUVWZvcEdFTDBoQVRVZ2hWbzNFOEgv?=
 =?utf-8?B?dXVxemVJZm5PQnl1bi8xUW9Kdis2S01vMU9PRnZNVmlhakJrRGFGT2lsU241?=
 =?utf-8?B?bEtyMGJKemRseGwvSGRjOWMyTGRobGFGeWk0aFRzKzV3QmhzcEg2VVNNWTkr?=
 =?utf-8?B?V2RpNmg3ZFFINHZyWW5mL2V6NHhIbVFjRUhKOWpVb3JnMlRXeG5kVVc0Tjc5?=
 =?utf-8?B?b2xBa0tHSEdUYkhnV1Q5WFgxVk1qbnJwbFBTbnJsdGM3cmtoZ1ViZlJtWC9W?=
 =?utf-8?B?V3dEUFJiZ0JyVjFpQ2RaTW1Ka0tmSXhyYk1lZzdsNnFyb0xreEFNSE9lMlRE?=
 =?utf-8?B?T1hTMzVtVHY1Q01IUkR0bHpKZWgxRjFDM090ZTJ1cjQyVHliNGlHNDk4S051?=
 =?utf-8?B?c2IxNTFiZG53MXQ3cUFCSmQ5cE5JbDZYVHV3b1g0dXZISUk2WTVnbXEwSHNM?=
 =?utf-8?B?ZnUzMHE0VGc5b09zQ2VXVHpaY3FxOHpPYlVNdTVISDVXeTQ2YlBmalhZYUZ6?=
 =?utf-8?B?QVgzUDZJSngyVXd1S1JEL3l6aEpqSmlsR3NLNzJyMzByVmR5ekI0OGQ1aTdB?=
 =?utf-8?B?aEtTc2UxbUhucW1BWkdieUtHaGtqUFcrbWxiMjA1czhvUHE0OG5ZWElNQy9X?=
 =?utf-8?B?UitMMUJOSTR1VStBWkd1VHRtMDdxbU5pM0ZGTUdqZ3dKa2Y1MlhUcDhEbHFI?=
 =?utf-8?B?MkpXRk5oU0ZIbHFVS01haHhzellybFdDWlJtcmFPSE1IaGFhdTgwSTdieDJN?=
 =?utf-8?B?K2MwbXJxaW9vZXJRakVucUhFNUdoSXZvc0xJQkFmMC9qRmZGTlB3blZ4cWxs?=
 =?utf-8?B?SFBGVGlpeUdHVG90c0VaQ3BLdlNrNmlVUmdXK1FXMHBKL0hXZWZRaEhraXh2?=
 =?utf-8?B?cmk4KzF5dmRtdy9RZ2k3OTZsZmNyRjhXMEdyczlFSUw3bU5UMk1CTG9OYUtE?=
 =?utf-8?B?WmRkczJOdVBZSWxBTzFCbTNYdmhXNXNLaC85Wk1SNE9VRzFzMitmOHV6V1hY?=
 =?utf-8?B?WmdUck1LNEEwZzZlYnhpdTY1TnB6MjdmbHE1VHFGMWZ6ZUFXci9WN3lWL0x2?=
 =?utf-8?B?VkFSVE9QQmNTdU1VYnQ5MkczdkpxZWl5aWdGVElTRW5nbzRyZ2RLS3Fhd1hN?=
 =?utf-8?B?QkUxTEthYTNaZitFdjQzZzZSSlF0Nnl4TmFlOGExMTVzOUpVSE5ndWxPWk1P?=
 =?utf-8?B?eStoNS9Oc2F0amZ3ZjF0ZE1oOFVMdEUxalpIWXRjMmd2OFNkVXpNbDBsREls?=
 =?utf-8?B?bDE3NGpiaERlSnZvSTZyWnI3NzVQMVl0THZ4VUVwNFRWZTNrM3BibEM3RkhY?=
 =?utf-8?B?dHlGWjVlRnF0YmlMM0F0eW9aTlo2ZXpjVDRoM1BtSTcrTGFDT1NuczNDNTBL?=
 =?utf-8?B?V3RKRDNRb1ZnR01NckxhbFVtVXdxcGJGaVhSR25hOW9ZQmw5VUw5enIzcXVu?=
 =?utf-8?B?RFFZaE5FbitpandEWUUvTU1yT2wxaFVWd1Evak5QZmJMSzNtY0UyL1gwdkg0?=
 =?utf-8?B?Y0lHckZ2eEZPUGU4cXVPYkNKc1lHWHZ1K3Q2U0E4ZEFMREowbHdsallSTDcy?=
 =?utf-8?B?ZnhDcCtaTXVKYzI4aXRidVQ3MlZlZGtUL3lGNTVOeGJlbWVpYlhxYlAzSWRL?=
 =?utf-8?B?b2dOdmd2aytxZnRQWUUwbEt4YTdodTBtNFFHNXV6eGg5VTcrS1BGREdLT3Vr?=
 =?utf-8?Q?5gno2W3jWmulLVCkcd0jmgmmH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e9bcd0-6c7a-4e22-7b21-08ddc03f2988
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 05:52:47.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GuG8ZtktzYiEMtr30rRcr79tFey72R6Kb4NdsmOaG5eQj/JBgbNjBfZJ4NrGdIDSCc6PJ3bYybfZ0IfFXE7Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

Hello Li,

On 7/10/2025 4:27 PM, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> This series cleans up sched-domain topology handling and
> eliminates hundreds of pointless attach/destroy cycles for large
> machines when SMT is not available.
> 
> Patch 1, 2, and 3 do some cleanup and refactor.
> 
> Patch 4 is a follow-up that simply skip SMT domain when
> cpu_smt_num_threads <= 1, so the SMT level never gets created.
> 
> Tested on Qemu.

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

I've given this series a spin again when looking at "tl->flags"
and everything runs as expected on x86 :)

> changelog:
> v2: fix wording issue as suggested by Thomas [1]
> v3: remove pointless memset and adjust PKG index accordingly, as
>     suggested by Thomas [2], and refine some other wording issues.
> v4: v4: Split refactor patche into three parts (as suggested by Peter [3])
>     and refined patch 4 logic (as done by K. [4]).
> v5: fix some style issues and do some improvements as pointed out by K. [5][6]
> 
> [1]: https://lore.kernel.org/all/87msa2r018.ffs@tglx/
> [2]: https://lore.kernel.org/all/875xglntx1.ffs@tglx/
> [3]: https://lkml.org/lkml/2025/6/25/584
> [4]: https://lore.kernel.org/lkml/1b706790-2fec-4582-a425-55eeff36c32e@amd.com/
> [5]: https://lore.kernel.org/all/f391491d-f886-4579-9b40-78a57f2ed1b5@amd.com/
> [6]: https://lore.kernel.org/all/7e7f686b-1f5a-46dc-8b16-c6d491160d1c@amd.com/
> 
> Li Chen (4):
>   smpboot: introduce SDTL() helper to tidy sched topology setup
>   x86/smpboot: remove redundant CONFIG_SCHED_SMT
>   x86/smpboot: moves x86_topology to static initialize and truncate
>   x86/smpboot: avoid SMT domain attach/destroy if SMT is not enabled
> 
>  arch/powerpc/kernel/smp.c      | 34 +++++++++--------------
>  arch/s390/kernel/topology.c    | 10 +++----
>  arch/x86/kernel/smpboot.c      | 51 ++++++++++++++++------------------
>  include/linux/sched/topology.h |  4 +--
>  kernel/sched/topology.c        | 24 ++++++----------
>  5 files changed, 52 insertions(+), 71 deletions(-)
> 

-- 
Thanks and Regards,
Prateek


