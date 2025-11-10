Return-Path: <linux-kernel+bounces-894028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2672C491DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925263ADB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0043358BD;
	Mon, 10 Nov 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rH1+Kj2t"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CB330D23
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803746; cv=fail; b=Txsii2MNnkfT1fW2uXPXDbAJh4SKpytBq752ncDax3h/N7KrVZD9AJfv6NyK818aA1GW0FJaK/mVgPITO0LJrwHYzwcaJ9/Qhqd8BWcIm7eyJdswSIChcASEhdtlVer644DS7d51d6W+20w3xTEH+HGIepZ+O0vOqpV7cY1FgGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803746; c=relaxed/simple;
	bh=Wzb/74newaisoLNTW/Z5B8LLdjb1+0XyHUhq4L6IFaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Du67oQeisGfPskUDOW+8zB5GM+MN0ixZh6FfhSWtTb7lNxon7515fEHuawF8qKBuoyWNom31APpssUcQXX9dyvZvFRKZXmcMlJgnR+opkK9nhQlXjRiW3kl7mPQ0rRXsLBTrWymgtpcDO1ug2ViDs9C17jCie1v/9PwzzT0RwGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rH1+Kj2t; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnZDNuO7HftUuEGQcRIGFTpt4gxQbXk8ygtUkZzTA/21o2tHrY8H5eXjAQIsB3BSGOA1Y3UKEMBPasGsRYFGoraaQ8Awpk2Qp5urqeMmRSOu3/hW9wSdTrQVMdLimstuIrBaJ5O/CfEhoociK95iULQYowpygVxIqc1v/NbE2SJr9bm1XX+0xgtRRKFe22ks2focNGX37ItKwpbzk59ARfzNYaMBUaF9tJpPoXDf0sdejBKXHKpWY3AfvnraafQkeJxubj8plKUHFRrr6/icD4sRB8ChSvL/lA8orxf7bbqaWXiBwSHqvyBicGoom4DZOf/tSY+anzrgDigSZ2yGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECAz54ink8jrGvifBJXBiBdhS7j+lYTJlZLPbLeNzFg=;
 b=Cnx3mvFiBlWuWxSti5lM4/6/1sXDatzvXC27fkmoeTsTfJ4s3qstkcmzNfg+jSsX7wTuq7yA6hwFlAATTpZfRUbmqu2E18mGloQqS9T2yoabHpKyDpSxVyNbdWKeJhdszQEKuM0f23vaDxmhqjPb/PjU2hChJ0JrdR0hE3ip+qdxMh4giuu/xEuXMuMvGOOAPM0xtMALi48khfy22a1dBy5iUzTr5RqCTsBkTP0z4THz1DOz1mqD+DUk/s9dxPlcJ2C1/m7UbfM6oUi/yfJMyXWdTE4HI/TGNxALl4OvGTFNpGPo6aDyY+ohR2rhf99nqFNT5felKwEvbULbdRcj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECAz54ink8jrGvifBJXBiBdhS7j+lYTJlZLPbLeNzFg=;
 b=rH1+Kj2tLbe4yIv1iFuYAqS6w5iPmarwbjxBfRIvnYpDAANkLNru7SEeyqmFzxLd/xsZIjz+2ENv4SqwVVrOuYG/lI1oZ77zuOGj11BatTWGZ58f/Bp5oQe0Tml+oazDVo0a+xjAW695rhXoUqhM2QZoWgrzKqCeqJmcbqh1J64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ2PR12MB8159.namprd12.prod.outlook.com
 (2603:10b6:a03:4f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:42:20 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:42:19 +0000
Message-ID: <f4a043d2-9cb0-41c9-a45d-31f96fd007d5@amd.com>
Date: Mon, 10 Nov 2025 13:42:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface
 for CBM reset
To: "Luck, Tony" <tony.luck@intel.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "babu.moger@amd.com" <babu.moger@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <SJ1PR11MB6083701B503CE361E3D7A656FCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <SJ1PR11MB6083701B503CE361E3D7A656FCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0169.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::24) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: d975d441-d0b1-4e14-da17-08de209142c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enByZlVsV1BkbG9vZ0w0MFlzc2krY0ZhR3V5eXVYc2tnSUNJbzJCSHB2QkJo?=
 =?utf-8?B?ZmpCMC90YXl6Q2NUNHlnQWhsNm1rQnY0K0paUmR3UjJQbzZYTElTVGQzN2hH?=
 =?utf-8?B?ZFN3TlNsbmhNVG9NVnd2YXpIYjR0cjlkdndhWEJ2S2xUNmp1VzlaQno4Uzg1?=
 =?utf-8?B?ZXpLblRRcXAwV3Fmd0VjMExUMGZ4SWZXYkJMVlVlQjhJUk5YNE1TN0szaDJ2?=
 =?utf-8?B?d0dlV0VaSExTczZ6SSt6V0ZtaHRYajEyWFovMXRNS1pubzBvb0Rpa1ZmNWg3?=
 =?utf-8?B?VExlUjVvVHNCQjE4cTJ5Qk1OVXp3NXFMcmVXQTQvV0Q1QjlyRXl5c3IwMU5H?=
 =?utf-8?B?TVNwVVpMKzlSeFlxY2ZISUxUUFllMVYyaVJQUXRkNlpEOWIwMWJpV0VmcHYx?=
 =?utf-8?B?MWFzSmVJM1JUZG9zdmhmVGd0c3p0RDVOd0hTOHZ5RGpVb2IzVkNDdnhYekZ1?=
 =?utf-8?B?R2FKYVY1aUZhdUU1K0d1NzNNSlh2OUgyL090cXlXM0tHM3BycCtCZnBsNE1T?=
 =?utf-8?B?NnlRcGI0S3ZSUW1xRk1od2puNklXNm5LZnFoZng4eUwrY3FsQ0RBM0crR2xy?=
 =?utf-8?B?eHhvLzFuaHNyeG5MWm1WQTRQbWlmVWM5dHhjcldQeWJMNkJNN2hkcUxVNkNv?=
 =?utf-8?B?NzNjbGc1TTBkdzFIT1B5YjZGdUxwNHd1TVcvQVBnM1B5MGFIUmhmUkNLZmll?=
 =?utf-8?B?Z0F0eWVaVXBlMmVGOUJjbkdTemk4Nkd4U0cwcW9EZUJLNlZaR2l2d2RNWUFK?=
 =?utf-8?B?TjJjMHh2R3RhTG5MR2dtYzExZWdzVyt0N3FxM2I0aHVXKy8rbU4wZnlSOG54?=
 =?utf-8?B?M29CSGYvNnJXQjl5Qnl4SWJSMkJUTFNydk9sZzZBMUFmeGMrUDBFMjR3UVpC?=
 =?utf-8?B?TDhHcXdYQjRoWERWekFreUgvanBSdmtiVlg0R3FzTnN1N2NVM0grK2VUaGlB?=
 =?utf-8?B?RjRBS0MxNXk3RFdleDVPUHlkUzhMNGZ4b1RPOFE2MW4ySjlvWURZLzViazE2?=
 =?utf-8?B?Y0RGdWk1KzJocGtnY3dkWHVXZTlZMXhjYlM3bVlyMVJ1SGNGckZEYTNpUGNL?=
 =?utf-8?B?SWJma0E4TFBoZ1BIS3A3NGtSekVNQ2Z5cm8wQzBZaHNkS2VNUFBZQ2xIWUYx?=
 =?utf-8?B?N09IdHU1RkFhckR5L3o2Q2JSaXNxZ1Q3a1FCZHdkVE1NODJCOG9RQ1pDY0I1?=
 =?utf-8?B?QWRUamhqQVBLbHBXemMvYXVWeDhRaHQ3dlBTd1YrZU8wZVovbTZHcXNRbmsw?=
 =?utf-8?B?Ylc5RTJMWGtkVTdTTFJuMS9GckFmc2g2K1F1cXU1YXAvMnFlZzE4alNiaXNu?=
 =?utf-8?B?bXQ5VDRnbnUwNXhOY3gwOTBpNVB4ZGFPTlIxRTRaeTQ3blRwS01MZWZHbDFm?=
 =?utf-8?B?OGZBbHdyZEo2SXVyRzFuY0xPRGRwSk5ROTNEdThHaUdiakw3WUllTXVtMjZ3?=
 =?utf-8?B?ejJJRmxkYVZrMThEcm8zNVJSSUpIRjlab1RJWW54aDJqQURzMm13RmJMTmpi?=
 =?utf-8?B?TmVmK29PZWRQUUFqNTJQYlpSWUxKSEh1dGMrR2ZVS25VMG8xdUtNSzI1c1g1?=
 =?utf-8?B?R1JkeXBIdWM4Qjc2ZnVGc1pTMnJnc0JyQWpSUEZlQmYxbUY3SHZtQ2NPVzZ3?=
 =?utf-8?B?QU9yTXF4cTJzU0k1Tll3dHk5TDhJbXQydlE2THBMSDA5QWQvYkgzbGZZR1F4?=
 =?utf-8?B?aTBNSmJCWFBZSFYzTXRPTnRaRndNT08zWXU0Yi9xNW42ZW12UnUrL2Y2V0Q5?=
 =?utf-8?B?NVE5eUV6UkluTWF1WDJoT0t3Wm9mOXZ0T29oUFNwejNBU0xnSGx1NWZhQWRN?=
 =?utf-8?B?TzhuWGUzMlBMZlNlQXUyYnNHY2dEMmZseGdEYTUrV2NFeDM2YmlOUjR2NGhW?=
 =?utf-8?B?L0Z5dmdaTkIwYWIvZDNvcFZxaWV0L2FrVXJlcG1wQjdXdWxJOFp3U05LOWVv?=
 =?utf-8?B?STg4UWtneWtKTjBiVDErZWJSMEtKaStvL0trTVZNemRqWnZaSm5WcDdEN1No?=
 =?utf-8?B?aDBiMHV4OER3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JHeXdLN2VuVHpSU2s4SHJvUldTYTBnMkVzZmRGUytxUjYzNjBibmZSNWVU?=
 =?utf-8?B?OEZXNUZZaGYzc3FhYUxDZUFCdlY2aU9EZUNKSUxCMlNqUTA0K3ZzdlNiNEJX?=
 =?utf-8?B?YkdXZXJBL3dYU0FlQ0E2VDBEbWV4N1RqSDlnOXVMQ2gvejBwQUNXQXU5SnI1?=
 =?utf-8?B?TmxoSEJ2WWJza2JERTRZT09HR01OOFN6Z04zR2FsdUZSYVF0eksrSjJMQ2Iv?=
 =?utf-8?B?SWRJYXpZRHlLSXJ0TmV4amUzTDVjUGFVc2NCbURjOGg5aTRQSFBPd1lTVHcv?=
 =?utf-8?B?ZFBZZHZtUnN5elp1MnplTU5YeFp5c3U0SWtXK0w5RnpOMTNkYzdCbEdSM3Jm?=
 =?utf-8?B?Tk43YzhYSlhBR0R4d1VKMWxWSTIrTnVBbE5mM0t5UWpTOWVDOTl6QWV1bEJ3?=
 =?utf-8?B?aE80aisxQ2Exa2tHbEhSZlJoVEZNMUp2SXhsZnpiOVdGSnF3eGpWbFpQeXJR?=
 =?utf-8?B?ZWEyYTZySjNGRWVCdGh1NlRxMTlRUnpjVTBPUUlOQWRjbEh4TVk5K0FNeTNU?=
 =?utf-8?B?aHh1bnJuay8xYzNjSXRZSDA1cXExeUIyQ2pqeXUrdlFCRXBuZFBoanVlNmpn?=
 =?utf-8?B?a015Tlg2UFVZc2c1YVpzYkxFeDNuRGlTSEFTVW16a2M2aWFVVnRBVHF3ZEo2?=
 =?utf-8?B?VldBK2RzUG1SOHJOZjV3MmFiSWhkM3UrRGdxZmVQSVFVL1Ywd1U4N2lwby8v?=
 =?utf-8?B?S1dOUXBjbnZOYVFOMHJ6azdDWXBHdmNxZkorVlRML3dVcXJDNFNKMTNxNEh0?=
 =?utf-8?B?OHhsL2t6TjZEcjBOSzdzdC9NWWw0QnM1a1cwajB1Zkx2SmtNdm83b2tMMG1x?=
 =?utf-8?B?MnkzNDdEeEhpNjVaajNHVS9wMkwraU5KSVNaN3ZIN3RsRUQvTlBvUk1uNHBT?=
 =?utf-8?B?dGhqM3oxeVErdUhlWmRiNFZndktuV0k0K3Z0MmZMbVRsWTFTZnhvaS92bkxa?=
 =?utf-8?B?QmthZ3pucnk5UDFSNy9mYWZoVnRsSzJGNjhqdVpMdHM1eFlEWkx3LzVtVzNP?=
 =?utf-8?B?ZnQvblF4Y244RUVuZHdFU2ZKMGxSeDhNNkV6bCtKcG5CbWkvdWRsSFpWd3M4?=
 =?utf-8?B?VnlBMUMwSHMzUGR6WC93SVlWOERldnl4MTB0WjBzWnFpY3NKU2x6Qy9QR09D?=
 =?utf-8?B?dmg4dE8zaGpOY0EvSnYwWHRKYktXQXNBU29hOGFIMSt4dW5mZzI0Q3NDR3BB?=
 =?utf-8?B?emw4MmFvMUppcmhKLzB1c3pEOUhBVHlPZTltSU8wV2oyRzgrSndJaEVxM09W?=
 =?utf-8?B?UXVnS2ZTb3E0c0hxenFnQlhOMG5OdWZkZ0U4YlRJZkU3akVOZm41YTkxdTNS?=
 =?utf-8?B?UzhPRUt0VWZqM2Rubk5CY3FhcDJ1SytRVjl1TVk0cEZZdjdUZ0NrUHV2RC9D?=
 =?utf-8?B?bThOQnBIbFZubzgrQytVZmVrT0xQRGZLV0ZZSUlYMlhtY1Y4QmpIaU1UUWRF?=
 =?utf-8?B?b0dmN2RIT25Hamk3bkYxblNFL2k2TGVkdXVrSmNzVHNsNE9uQzk1blQxZHNi?=
 =?utf-8?B?cEN0ay9rY0NuaGVLcDJZQ3VmYzNmUHozR1IzOUlIaURvSCt6M0FqQ1E2LzJ6?=
 =?utf-8?B?MFA3MXhLL2xNYnlGWmxQd2lqY3lYV09abUdNeTRsVkh6YzYvMUx2b1Nma2ZH?=
 =?utf-8?B?eTRhRml0MWxuRHZHVWhuSjRDZlZHZlFPMFM3aDZLRmNJcGlIbGF0allFYUps?=
 =?utf-8?B?RGgxYjlpcUt4RWxydFFxaFZzSlFRajM5YkpsaHJBTnRQTFcyazhIOVBiODdq?=
 =?utf-8?B?a2ptTktYbnY3N3ZuT3dtaWpUU2xMVzdDazZ1TGhmL2plSlNnd0VXREZLb3ho?=
 =?utf-8?B?THRRSnQ3U1hpNmsyWHNOOUx4ajA2Z2dBZHdvL3ZRVWlJbXo1Ym1PeVRjUXlE?=
 =?utf-8?B?QWZpYjl0MGNnOHllL0pEVS9Eek0wNThsWUlTTXZtQ1JNTWlmNEhhL1BvcGda?=
 =?utf-8?B?azZuWWxVQUNsUlpCU3RsTzNxMjJNdHdBOHdYNUh6OFlpeFVpU0NQMHQwbVE0?=
 =?utf-8?B?K0JYRVBwMndnT0tqcjVrOGhEalNHc0JmaDJYTG1udUx6UGlxQVEzSWtNNmRV?=
 =?utf-8?B?a3gwM2xLUThnRkxqam1kSnduSGhpMldFMW5ScEgzK1JtaXZPUWExRXNXTmtk?=
 =?utf-8?Q?eSw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d975d441-d0b1-4e14-da17-08de209142c6
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:42:19.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxTxjbzCrD1m/bSTGTyYfGrrbomCx9DsX/3IeuS6FBDK3FIlfo+APF2RYoIMdvCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

Hi Tony,

On 11/10/25 11:50, Luck, Tony wrote:
>> Does the following option work for you?
>>
>> # echo "*=0" > /sys/fs/resctrl/info/L3/io_alloc_cbm
>>
>>
>> Here,|*| represents all domains.
>>
>>
>> This functionality was introduced when adding support for the*"mbm_event" assign mode* (see [1]).
>> [1]https://lore.kernel.org/lkml/b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com/ <https://lore.kernel.org/lkml/b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com/> <https://lore.kernel.org/lkml/b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com/>
>> Also, this needs to be done for all the settings like L3, MBA also SMBA.
>>
>> # echo "L3:*=f" > /sys/fs/resctrl/schemata
>>
>> # echo "MB:*=128" > /sys/fs/resctrl/schemata
>>
>> I’d like to hear from Reinette and Tony if this seems like an acceptable
>> approach.
>>
>> Thanks
> Babu,
>
> It does look like a logical extension of the mbm_event assignment syntax.
>
> But might be awkward to use if the system has asymmetric domains. We don't
> currently. But if we wanted to support L2 cache allocation on hybrid platforms
> with a mix of P-core and E-core, those have historically supported different
> bit masks because the L2 caches may allow 12 bits for one core type and
> 16 for another. On such a platform:
>
> # echo "L2:*=fff" > schemata
>
> would work,. But
>
> # echo "L2:*=ffff" > schemata
>
> would try to set unimplemented bits on some cores and would fail.


I would consider this a user error, as the user is expected to know the 
supported value for the domain.
This situation can occur even now — we simply report the error and exit.

Thanks

Babu


