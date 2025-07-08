Return-Path: <linux-kernel+bounces-721927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863DAFCF93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AA1188EF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531E12E091E;
	Tue,  8 Jul 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p/1wFiRG"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8732E06D2;
	Tue,  8 Jul 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989433; cv=fail; b=HxFscBZTyjHzWeRL4k5xeiiE1p7onNJJW8Uw8dUhJPL3n4twWZqw1McAO7Z6e/VWZf6hjA84O8sn7LiGoZ40TqDAROAwaSUHI0C5R67x9Sa4yUeE78PuAlHQfhh3SJ71X7tA8cmt8NI/8gxWXceFuHM03i8D5eBpa9ohYyhffH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989433; c=relaxed/simple;
	bh=QnVQekuterlKvQnaFaHYsqr0div5QbgyIGiAT2NMpQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u00Mo52lfTraS06230FqUAonw82MpddhQrXBCG1oQzBuzyZRwjj2Yfv0RkTzjMbsp5ECxa4M7Gg9Xgqyro349jHVBN92LXjwMkiYZO2+sPAsNEBe4CT3oumXksVhV7mpI3Knf+lRuVoU7SwByRFywDB+V6juGX7Tyqk+bmtgHxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p/1wFiRG; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8/XmaQRpqY8ccHyVKJKaHy4rBad8oLR/nprOd1Bc2eevGk7zQb2ykzMRRLUAr8N+WJuQDK1NgKWK25dgiV7fcYQvWZVwC0Au3cWF5gcswYpM3YfnzNnV78KqaCNlEb+oooGK4p/m1vd5+CKehMV3JObhwz28Aozt5sugO3xzzciD1dMEjN9PFAncftrCLqN5ASUo4hoyrmujd4Vv19LU2SHATS1UkredVKrLSAiK0dTps8IUCebQtfa9kzZeRiz4EtibaU2OFSBMLRzg27EOneyrbZ2Al6g4jzXZR1fMvXApktHJZpyQ9O3Mf/BMR8vA8wtNdYmkRL1aKRrEm8TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEqk5f+2hY1eRbrAUa5qSVGCpCRY2BpYFRe2miWzxSA=;
 b=W1CD0aYQQAJfdfI6D/XSbIN7UGfuH9G2m6GkyKJgicSQsrN2uqtu+isHHyUHOPfKJ4BC68Y/ak+GANYP+E4y0L/DmzB821oOCGL0szJEWXm7TEZ/aO1Tt4ch0EpV34Egt1sdVHvyaSsFoyIgHixUoYv+7QLQl082/vE3Y+ACzUhdaDzpeoYJjShrnIcSO7VAmCD0qzBXBI1i4EHC0lMOhftA8f1xHzQS1/wk3RIrNX7nwZhVwcZf/L1cQLlWD7F1w9Kl6hRIX6ycYGeHfwGwB3vViTRCEhIVvkVruFgmLrnDT1EwYMjJ/Uk2IWSfl7VHKpoxfjDhXP82dYQHlz694Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEqk5f+2hY1eRbrAUa5qSVGCpCRY2BpYFRe2miWzxSA=;
 b=p/1wFiRGg2JRLUGhneKqOrpOfp2sgzzAogmvydJPbtNid2SEwqbZtpqeDMxcaDAUMWL48HDhroW9TeoqsRgzwsroCCwKq8jEF6hz+qGX+SNZqzaQcSrekapBe+jv88mGgiCq1IcA95W7CuaQjuEdmsRYohp1KeODQ3YqXqOYYOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 15:43:47 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:43:46 +0000
Message-ID: <16888c23-08d6-465d-83e5-b5612b46ea96@amd.com>
Date: Tue, 8 Jul 2025 10:43:44 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v14 30/32] fs/resctrl: Hide the BMEC related files when
 mbm_event mode is enabled
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, corbet@lwn.net, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, paulmck@kernel.org, thuth@redhat.com, ardb@kernel.org,
 gregkh@linuxfoundation.org, seanjc@google.com, thomas.lendacky@amd.com,
 pawan.kumar.gupta@linux.intel.com, manali.shukla@amd.com,
 perry.yuan@amd.com, kai.huang@intel.com, peterz@infradead.org,
 xiaoyao.li@intel.com, kan.liang@linux.intel.com, mario.limonciello@amd.com,
 xin3.li@intel.com, gautham.shenoy@amd.com, xin@zytor.com,
 chang.seok.bae@intel.com, fenghuay@nvidia.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1749848714.git.babu.moger@amd.com>
 <4769751d1de7c4f66b1c7f3c5ea7eeeb49951363.1749848715.git.babu.moger@amd.com>
 <3c753f3c-e91b-4cfe-983d-efe8ff07b750@intel.com>
 <f85e467a-1d17-4f34-98e3-512679baad47@amd.com>
 <ff314427-1c03-4e26-be19-c5f5090f3d8a@intel.com>
 <471975cf-1094-42dd-a965-f536cf399d0a@amd.com>
 <d5c4d3e8-6d5f-4892-83b5-867ec8bfc97a@intel.com>
 <f8f434d0-1c44-4d76-9121-7c0acc7aa10a@amd.com>
 <2b49620c-f2b0-4994-8617-e436725d0cf6@amd.com>
 <16cf9877-cb47-4ac3-bd50-c24ee3522296@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <16cf9877-cb47-4ac3-bd50-c24ee3522296@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4f6249-63c2-45b5-3540-08ddbe3639e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkFXcEZ2MzVQQ0lTVytHMWFyWXlIM0ZaTHVJZ09Qa0o1cVM1RWZlSTVIRnZT?=
 =?utf-8?B?SFk5emJ0bklxSzVScjVmdGNyeFZ6ZmVONGFQTFFSaWMydzZwNEdoQlh4anll?=
 =?utf-8?B?WkFMSG8vMElyQWRudDBLczlWZkwyZGN4NWNKcVdXQXZjL0RDT0daZXQvL09i?=
 =?utf-8?B?bW1PRGIxMUowNU0wOFh6cjc5Rm1WRm9ZVGVVYlg2cUI5dkllazdiK3BQUTdn?=
 =?utf-8?B?UHNMYTF4ZW56c3gyYzZWSjFJUVd6MGovcFhBeTZGY3F6OU8xOWhvc0tpWkVL?=
 =?utf-8?B?NWJKRTZhWFl2SnNMZTd0cmxDdDhHRmdUb2UyOTlxTkpOVFBLOXNDam9wTklu?=
 =?utf-8?B?NE9PV1lBZkFycFNHcFpkWUl5VW9hL0JVYjVYaGpRRTVuYkNaMTdUUDZZaSty?=
 =?utf-8?B?Sk5ZMHRyUXZ2cUdZckE2ZWJhZ2NQc29peVVweXFCajQ1eVpIeSttM2hWS1l6?=
 =?utf-8?B?RTVGSm9hRy9vczVWNHh2RFE2M0liVmp0M0dQWG5mN3BXekc1ek9uQUx3VDBa?=
 =?utf-8?B?alBXSGViQ2JRbTMreENUdUJiTExEdTZDdG5ibDBydkE2c0pobFpDcHB5RlFr?=
 =?utf-8?B?eFczUmZzRTUxZDZ5ajFGdXJIS0o3RXZZbW4yNWl2eWFLdUFMNkI0OXVETXRj?=
 =?utf-8?B?VS9VRlRHaXNVNUJDK1VHOUpiOEhlUlRFeXErVHpEVGtybG0xNzdyTFd2L2xQ?=
 =?utf-8?B?SFlOUlh3YzhXdW1Yb0pwSFE5c3dKMFJHRmxtQURsNWhhREdzenZLVS9lQzB4?=
 =?utf-8?B?TC90MDEwN0lrZyt0ejlrNllxdHA3WjIvUkQ3bllLQUgxN3E0MW8ya240Rk5r?=
 =?utf-8?B?WGFzS3hJeHBDY1dRbHIwM2NmaHdHeGFkM2c4bFh3M2hEUlBndVlUTW9oME00?=
 =?utf-8?B?WHp5WHpLa0tRaXZMS3RjWVlKYWx2MXRMQkRoUVFKYmZ2dHB5bmdVWWlQZDlX?=
 =?utf-8?B?ZUdvRUxqb0thS0FvTzNiUWJVL3pQZXpUQUhGb3RCSUpidUNRWHZyblNnbU9w?=
 =?utf-8?B?V2xXNUk4MUJWeHIyVlVQRFpzK1VWejllTGx5SUk5cmhjazZFdUdVcUs4S2VU?=
 =?utf-8?B?RDhxUnVNRXp5V0phSUg4UVR1VTRUc2RjTzFkaTlhd0hYdXdJek1JTmQ3Z0tD?=
 =?utf-8?B?Um1RWlBCVFMxUjZ2NlFvTmhCQjhIRW5YQmYzQjlxT2ZvZkJFUHBBWktIQ2lr?=
 =?utf-8?B?ZldFYTNvUks4UUx1ZWQwU2FnVWhWU082M3FZS1pNcEZqMlU2ZkJ1UDhvWHor?=
 =?utf-8?B?NzA1aVdtQTRmUFpCQ2svYUhiYjFGL0ZsTlpBSDYvTXY2TDFwTCs4eVFsN3RI?=
 =?utf-8?B?WTJjSE5wdDRPSzlvY1NyY2ZXOGhDNWdyMTFoclFGelRma2l5dS9yVXFTQk50?=
 =?utf-8?B?NnRDWWZMUmUrRGVGNzVvQ2ZSQjJoSDZKSVJ6VS94SU9ORFRSb2VsU2dJNjJy?=
 =?utf-8?B?TjlNbVkzbmpjRHl4cU1BMS9vaGVBMHp6SUE5MWR0TzJGSlE1SHZOdll4b3Ji?=
 =?utf-8?B?VW1YTzJrWnFxN1NQUkVKUW81cFhMeHY0L0tKL3N3UVJER09pb0Zxd1A2RjQy?=
 =?utf-8?B?MXFlME1WZ0hWSjl1NVplZ2lJUlpOMlV1SjgyeFZrenBSR2dNMTVSUGg5NkpV?=
 =?utf-8?B?WEVDaUtacmlqSkZuTzRreXpsVzEyNmVLY2ZjMGs3RHc5QXkzZk9iVUZNSUpW?=
 =?utf-8?B?TWpOSDZFMGlwTGR5TCtYQVpBaFRnTWpmcWhTcHJYdWsvcFNtWnFTYkZaeHU4?=
 =?utf-8?B?VHBoQmJhaHRUcFRqOGYyOHJYUzRnK0hEdkNjWGFURTRXNGZHTmFsUnJFaUtL?=
 =?utf-8?B?TzZhNGgvTlZhY29Vc3NXejJ1VDdyZkwvV3AxTkg0dU9IVk84UFl6a2QzQzA2?=
 =?utf-8?B?eVJ4eGtXcWROaTZYMFltdFh2VVVvbTBNNUd3K1pwTXN3djNCczlrNk8raVNR?=
 =?utf-8?B?M1crY21NU1JOK2JIMlFTSy9NSER0UHZac0JmUVltMW1qWUVpRXpPdytnNk4v?=
 =?utf-8?B?ZDQ4eTJJNXJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENlV1BFTnVNYXE2WHRtZHNLWnpQWlljdWZJVWpOUFZMMm45a3JFOHJjTVFz?=
 =?utf-8?B?SmU4cFFIRzRkRFFPWWJQSitvK05pbjRDdnprRnhJVktIMVRnUFZJVDlqaHhv?=
 =?utf-8?B?Rmo3U092RlM0by9YbnVONWppL2lKNHRRQVdIaUhZcVByTVlnTjdVRTBaSFNz?=
 =?utf-8?B?cDZHOW1zdFZUYXE1VEZITk0yaWdhRTlXUlNZbnhwRVhHcEJZbWt0UEN4M3dl?=
 =?utf-8?B?RlZFRGdJL1YvdmFTOStuNG1UdlhLMlpLeHhkUW5ScXdUSDRmdTFteFJFR0J6?=
 =?utf-8?B?UW9NNUNJWmo2UWR0dTJZcEdpVXlXaWdoRlZISVltOXZ0bFhURDNqV0MyV0Ro?=
 =?utf-8?B?eU1HRXhkU3ZKMkZlcFJ2K0I4V1RRdHgyVW0zTDRFTTl5TldUUU9rTGczY3Bq?=
 =?utf-8?B?LzlNaFJoQnRYdVJ6aXhxNXN6YVpzZWo0QW5EcWl1bzBFeWRuNDlla09sU3dw?=
 =?utf-8?B?NHplUkw5Q1RxODAzZUtHUllOV2I2YWZUOWpPaDFKQ0NGVk1vQmVIV3N4c01U?=
 =?utf-8?B?MzYwbGg5S1I1d1FYVTQvVWI0enhWR016WU5LUURsdnNXWGxXSWdCMGtKemZi?=
 =?utf-8?B?dVRqTDRxbnovN3ptVlRXL0xzYk9DSk9GQUQybEVCdG8wd2hGK2IxcDJoeEc4?=
 =?utf-8?B?dXlnM05Xdng0YWxIUHBoRTBxZmRZbWNFck1SZVdXU0RmL3RLcEhVaGtHZk4r?=
 =?utf-8?B?RERMM3V3WXFzMzRNcktMaEs2c0hNemlVTW9lR1ZrS2tuQzNWS08ydGZXSllC?=
 =?utf-8?B?eDB2bUtiT3VQdW9tUDZ5YmVJUE1xMmN3TUFXdElaOFFMRnVTcGRiczh3WVFj?=
 =?utf-8?B?OTJ2eEZPUjUxUjR2Q0NwNVY4MkVUME1pVXd1cXF2bmRqSCtIZ0dxL0FacEdW?=
 =?utf-8?B?Zk1KRHJOb0VRM3RjZHFGSG4zeGhxTWpyRWFNeDR4elU1WjM5SVl3cFFRQi9J?=
 =?utf-8?B?T2hMM2d4UGE4TVZ3aE9sMjRUN3VMSTRlbUNMamF4REIxNi9ITjZNUE5FaGJk?=
 =?utf-8?B?djlUWHlPQ1VHZ3hGNTY3SnJSbFBTT0xlZzV6WlRVQlY4RWdHMXRFUFVVWHdR?=
 =?utf-8?B?S2lvT0l2ZFJrMUZzcmtBS0NwOU9Rb0lCYVNrK09UczgrS251ZHlsenl0THFt?=
 =?utf-8?B?Z2dJeUVyejBQZ0c2OCtPTVZOMnlrekowc3FmUUZxQ2Zya1NkQWJONUc2eVlI?=
 =?utf-8?B?TnRBMXhNZHJraTdyUkxVWEZXbUZTUGxYUWpRVEVSVHFhRVZsN3VNNXppMFQx?=
 =?utf-8?B?NTdDd0RhbG03cDVtZENxTVJvNlgrTkQyUGE0aUVFcUVqWnlUTjFrM1pCengr?=
 =?utf-8?B?aEkvY0xUcnhURCthZHNnWERBSUM2VUlrVXFGZ20yWmNiVHZIdUhvTjEyR1Z5?=
 =?utf-8?B?K09qVjAvMFF5MEYzWmFPTDFiWkJVSUNRS3V2ZjdLbW5CTVhWT3NRZjFkSnA3?=
 =?utf-8?B?VmhnOXlSQnZHZHRBKzFLbEIyMnV6QzZBZVBoR3dmdFVLZkVZQ25GUWU0eUEx?=
 =?utf-8?B?VVEvdzJ2eXhtZFlqemZlMkVWQldReWRFOVJkQXRpQUVsc3VnR1liVWxVbUxY?=
 =?utf-8?B?YmQrajlkN3pDeVJWZzNwTitGMXhKS2pybDB4dW9LN1ZpdmtYMVJjTWNjVW92?=
 =?utf-8?B?TlcyOW5TK2pySTNjN2dJT3plZG5GdDVpQ05RbmJDUWJ2MUoxWnFVUDY4UFBt?=
 =?utf-8?B?T3FFUGoyV09wbjhEcHV1NzVjWEhxVWV6V0F2WFE4cFNwYllPdFNsRmV0S3Fr?=
 =?utf-8?B?dTEzallrdjAzaVFyWWpDWjNmOU4yVUZudjUrOTVJbXErRjAxbHVHOFBZdzlo?=
 =?utf-8?B?bGIveVFMWnFPa09pZ2Q3NW9OcDl3cm9JL0NNa1VCQ1J2RENTa3IyWnFhL2Vk?=
 =?utf-8?B?L2poUTVXaHdvcWN2TDRHT1YzbXQ2TWtYN2tmV1QzQVd5VkhnOXMxckJpZEVR?=
 =?utf-8?B?a01VS2hEWS9UbE5tQjQrYURIQm1nWFRqYjFEWFJGSFhSeGdhTDBIOFR4MUxm?=
 =?utf-8?B?VHpIY3hnZ1QrWTFQQmhSc3VYdWVhNXNKWFNSV255YUppa05jak40ODVya2Fh?=
 =?utf-8?B?d1pRMEFEbGJBU3RuRTRodlVpaGtheU41emloUHZNZEtjdlVPdjhpR1pYWXg3?=
 =?utf-8?Q?2iiw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4f6249-63c2-45b5-3540-08ddbe3639e1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:43:46.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmdVzamYLRTSrZHvnX85x8qTH83Y88lSD0h5KE3o0Yv+iwMQ2oiOskNfJhnZDmId
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

Hi Reinette,

On 7/8/25 10:21, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 6:27 AM, Moger, Babu wrote:
>> On 7/7/2025 5:35 PM, Moger, Babu wrote:
>>> On 7/3/25 11:21, Reinette Chatre wrote:
>>>> On 7/2/25 12:04 PM, Moger, Babu wrote:
>>>>> On 7/2/25 12:21, Reinette Chatre wrote:
>>>>>> On 7/2/25 9:42 AM, Moger, Babu wrote:
>>>>>>> On 6/25/25 18:39, Reinette Chatre wrote:
>>>>>>>> On 6/13/25 2:05 PM, Babu Moger wrote:

>>> Changed the changelog. How does this look?
>>>
>>> "The default monitoring mode and with BMEC (Bandwidth Monitoring Event
>>> Configuration) support, events are configured using the files
>>> mbm_total_bytes_config or mbm_local_bytes_config in
>>> /sys/fs/resctrl/info/L3_MON/.
>>>
>>> When the mbm_event counter assignment mode is enabled, event configuration
>>> is handled via the event_filter files under
>>> /sys/fs/resctrl/info/L3_MON/event_configs/. This mode allows users to read
>>> and write memory transaction events using human-readable strings, making
>>> the interface easier to use and more intuitive. Going forward, this
>>> mechanism can support assigning multiple counters to RMID, event pairs and
>>> may be extended to allow flexible, user-defined event names.
>>>
>>> Given these changes, hide the BMEC-related files when the mbm_event
>>> counter assignment mode is enabled. Also, update the mon_features display
>>> accordingly."
>>>
>>
>> Here is another update.
>>
>> fs/resctrl: Hide the BMEC related files when mbm_event mode is enabled
>>
>> The default monitoring mode and with BMEC (Bandwidth Monitoring Event
>> Configuration) support, events are configured using the files
>> mbm_total_bytes_config or mbm_local_bytes_config in
>> /sys/fs/resctrl/info/L3_MON/.
>>
>> When the mbm_event counter assignment mode is enabled, event configuration is handled via the event_filter files under
>> /sys/fs/resctrl/info/L3_MON/event_configs/. This mode enables users to
>> configure memory transaction events using human-readable strings, providing a more intuitive and user-friendly interface. In the future, this mechanism could be extended to support assigning multiple counters to RMID-event pairs, as well as customizable, user-defined event names. Also, the presence of BMEC-related configuration files may cause confusion when the mbm_event counter assignment mode is enabled.
>>
>> To address this, these files are now hidden when the mode is active.
>> Additionally, the mon_features display has been updated to reflect this
>> change.
> 
> I do not find a concrete motivation in this changelog. The terms "may cause
> confusion" and "providing a more intuitive and user-friendly interface." are
> vague and not something that I think provides a good motivation for disabling
> an entire interface.
> 
> I aim to write a draft below that I hope will help make this changelog more
> convincing. Please do improve it:
> 
> 
> 	fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled
> 
> 	The BMEC (Bandwidth Monitoring Event Configuration) feature enables per-domain
> 	event configuration. With BMEC the MBM events are configured using 
> 	the mbm_total_bytes_config or mbm_local_bytes_config files in
> 	/sys/fs/resctrl/info/L3_MON/ and the per-domain event configuration
> 	affects all monitor resource groups.
> 
> 	The mbm_event counter assignment mode enables counters to be assigned to
> 	RMID (i.e a monitor resource group), event pairs, with potentially unique
> 	event configurations associated	with every counter.
> 
> 	There may be systems that support both BMEC and mbm_event counter assignment
> 	mode, but resctrl supporting both concurrently will present a conflicting
> 	interface to the user with both per-domain and per RMID, event configurations
> 	active at the same time.
> 
> 	mbm_event counter assignment provides most flexibility to user space and
> 	aligns with Arm's counter support. On systems that support both, disable BMEC
> 	event configuration when mbm_event mode is enabled by hiding the
> 	the mbm_total_bytes_config or mbm_local_bytes_config files when mbm_event mode
> 	is enabled. Ensure mon_features always displays accurate information about
> 	monitor features.
> 	

Looks good.

-- 
Thanks
Babu Moger

