Return-Path: <linux-kernel+bounces-887795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F2FC391C0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619461A2125F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E922D3EDE;
	Thu,  6 Nov 2025 04:41:15 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020078.outbound.protection.outlook.com [52.101.196.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF725C70D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404074; cv=fail; b=nrovq07w8Rzc83B28Hp185KSPm/vuiEl6aOtTvsfa7aLB8n3VTo61atTMC4LlEIUKC2B3R2iz/4o4XxqmmdXQ5idcKolVaXot2vkZ07WMzim2hIQDdzd0d3ZCd+ldo4Bc5gUvGxVsM0QUXgiq2vebXx4xRvdWKFhMRdhGyTYkOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404074; c=relaxed/simple;
	bh=5DvmliV3m31VoAnK2OS0I7inWdCOZzZI+nGqCw4KpkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uvTMoARHf/dMWpQPSQ9uCJ5RDQlRD1p22ZKcBtyVAxGEjvUP5SmymiQG+0kT0pjsKF/Meq4P9xeygUWvT6FnW2i+I3sKm9SgkIPD7WJ7Jyh13ZpV9Syb8IJ1KKS62EejGMu8gkNoJ8glh6p4LhM8l3y4B0kxA9bZnz141bkJcW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmO8QbafP8FfN5TSccpdCJCIR/+IY1h6EnXwJaM/n4u9q1c/ZdKNma3CxR0rz4UHJCO8dBE/pT7D7DDcFN40PJZ3Bl6lu5sp7pP8TFw3C/O0EdHWlDnt12U2UK8TP56vcLHC5fIcruCij8OVBaGZo6iNlLY0bkVSguF8ZEdMXb23OqPt4wlI7z/A5U5hoWPH+Y4a6eWlCsoJN7qNoBjCwy8pA+0Tp4nhz74b6NCpqDzZqH4ebNiJhJv+LKi6h9VZoE+2ps0QjQf5hrl0RgEdCxKP8tMRoUUjVfawmtD3FIvaDX3xeVJTJNzj9o32ny5Nu2BBY/tXJxmXJDIcWREp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MPlYPGRx31GMODi2gx6NNlYgbEDjYKGb4s4oXAhQjY=;
 b=xJ2vtON2m1OFJ8EM6h2agetjbB1XGIDag0VB+ITQLhMb246RHq2ofzbpAk4mucxDRuI7mQZhUvE0vcDQ2iQmcYgdi4iZ/aIhDacoZPhOJFBPpne71hjzBd12K9Gsj2+WAEupujsiE7Z4h2nypOCfJ74XKdOLI/14tBdoytbZoWo/RFpF42OE0LkqbDyAsyi3M7P+I5Kx2i0miE3xgM2FUlTQSz7jaCiPAXlty3MWTDrq4Fi1ZeygRfbs5pHYevAQ/vGNMMlsKSMwNA9koj0mjvWeTzseBopS2InddazyZHYz24kz/6G+Xi7Ovwix0m+ZkhR1H+mt1OaR7PW+hh5ZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB2918.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 04:41:08 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 04:41:07 +0000
Date: Wed, 5 Nov 2025 23:41:04 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] fs/resctrl: Show domain CPU list in schema output
Message-ID: <6ianowe727m2mhytn4gsthj2pwbkpxmojtktka6p4wnzajm6rd@b5lcez7kjlec>
References: <20251031181722.250851-1-atomlin@atomlin.com>
 <SJ1PR11MB6083A4A7720723C14F3AE314FCF8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c26dierez6gzngp2syreufhdwhx64iuiox6cqrpeomz2ieuwkh@4l35mbkc4ez6>
 <aQjV+Q25+O/8DpBS@e133380.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQjV+Q25+O/8DpBS@e133380.arm.com>
X-ClientProxiedBy: BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB2918:EE_
X-MS-Office365-Filtering-Correlation-Id: af469ada-1c06-4f45-38d6-08de1ceeb3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXpuWnZlT1RYOGhDNVFmVHlsVWt1WlZzV1Q5M1N1S2I3RDJlTi9oVC80dUdY?=
 =?utf-8?B?TWN0YmNteVdkNzVBKys5NzJxSlduamZkQXltSStyRUZET1psWXZKT0V5VmFW?=
 =?utf-8?B?am1BUFhTemJPZElYUXBpbmNRWndLZkxWdjZCQUxoVEtDU0UyUTRRNE5aaExD?=
 =?utf-8?B?bHJ6Z3AwcW9uQjg3YmltZUc3endHcTRGYzlmL28veUJQb0x5ZG1XbFBvQlNr?=
 =?utf-8?B?MUVIZ3g3TTVQQXd2Y3pVZTg2Y090RWhHUXdWMFk3ZmRxaEJpQ3QxRFI3Wnpo?=
 =?utf-8?B?eTRXeEw3cU1kU1lxaWloNWJYVURpS0pzREwvSTJpajQrWlYxMzNVbEFXU1J5?=
 =?utf-8?B?QUR0SWp2bzdScWpZTWFRWjZEWUxicXF5UXpXYWNycVJ0aUZzcjc0QWhxVVov?=
 =?utf-8?B?NkFWSFUyaVpxYmQ3RDdVb0ozUzV5MTFMeU1kTjBaL3hGNmJtSk4zWW4wMDB1?=
 =?utf-8?B?WnhFVHpiWEM3VGxkTzVwUTFGVERqT0lNYWlPYmRaYnN5SHpyYVVKV1g5ZWRM?=
 =?utf-8?B?eWdNZW52ZXZEZGFMYTJWK2lwWGtudUwyTHRtdlYydmRscG1qa0ZjZFFPUkt6?=
 =?utf-8?B?MytLUWZkQ01tQnV6OEVpZkRSSjR1NkNtaytudnoyOUNvZFlvekl6K1N2UmJm?=
 =?utf-8?B?dTJ1bUJnazVuUGRpU2FOMklJUkRGUmxOaWlqMkk0SWl2ampjaHNqRG12RG8r?=
 =?utf-8?B?bzkxSnJtd2l3UDFGcGlHcXEram5uSVlWMTY1VjFpV2daLzJtZHZIc2lobE94?=
 =?utf-8?B?OTNvZk4yQjV5bW1LTXNGTG82RTVScVJwMU1aZi9FM1QyQnUzTTJzdXBaMWs2?=
 =?utf-8?B?SnlvLzg5Ri92RGJkcllSZ1hwa0svckRtNFBWZjVRT25NMjA5SzNYMSs4YXNN?=
 =?utf-8?B?OXkxTkkrb0c0b0VRZk84WUwwWnMvU2UrY29uZWdkVTUvYTZEditIYlpvc21r?=
 =?utf-8?B?R3Fkd1Z4VVBERTdRbmtPcHh4YUIxS3BMRUN5VnhaQTRpLzJLY2lxRlFtVGF2?=
 =?utf-8?B?Z1NKRWtpb0N4SkI5TG9pMlN0dTRnTlRuMXBBbnlTYzNVM0lVVjdTQUcvbWpm?=
 =?utf-8?B?WXdsSEFZMUZlOVhTREk2dXVPbld5N3psN09nTWtwNytXNjFHcGpUUjZRMGdP?=
 =?utf-8?B?U1BYeFFXTGRKQ3RJR2szakZTYnY3S3hibmZTVG1GOWNud3I1NWNLUnBMcEZO?=
 =?utf-8?B?dURsMUdSbHNrWWhXenJUZHpzbXVoL3QrS0UycTYzRHV4eHpkNTlVVjRMM1Ns?=
 =?utf-8?B?MTlJNnlMbDM5N3JaUUN3azliVmxuUlRKcjBHeExFQVJvYSsrTHNQcDdEMWE0?=
 =?utf-8?B?bU5RTzdZZUYxMGx6dTR6Z0h1KzJ4UVVFN01XS2hEeEVQUFFWaXJQZnZNbkdJ?=
 =?utf-8?B?WHEwZHlvNk56citGZE40dVVUcjUwK2xkeWNSODNtenFtZGRXNnpUcDdlTElm?=
 =?utf-8?B?YUszbnUrMDZMM1lZMjVlYmZCMk83emZ5L2xNektXU3V1VVhhL2JoSCtXeW0x?=
 =?utf-8?B?MGwrd2UrQU9yakF0emFSdGNUNDNzWG1xSE5oNm5abjRDLytRaXhZV2dsOTg3?=
 =?utf-8?B?M0MrQ3Q0SkxxS1h3aW5kSUhLVTd6Q3RPUXVTbHJkeFJSOG9iSlp6d0xFd3By?=
 =?utf-8?B?bjZZdlZ5RWxqTGxYWmYrL2dsUzRoN2UrdEhnWEZLTGFZRUhqL1MwRXNMNXZI?=
 =?utf-8?B?eFh1ZTNRS0tuSXM5S0VkQzZ3WlQweHZidHRzM2JBUmdITkxMS1VCMFRmMHlU?=
 =?utf-8?B?cTVsSXdlNk9jTkdTZnlWN29EOW1yOHQxcWUwa05IbHcxbWFhcFBiNnViWFVu?=
 =?utf-8?B?YVE0WGpNV0JBWGY5eFJYMDhyOFJFbVBwZUJMSkQrUi9VMmV4MDl2SVJLYXAw?=
 =?utf-8?B?NWhIdVZQa05ZUjBIL29yTXgvemZTSGJkQjV4MWNYQ3F4Q2ZjTGtDSzFNUXN6?=
 =?utf-8?Q?CMcGsuXlBtQGw860M4XuhC7Cj6GyTJwG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVHbEpaZjl5Y0J6WE9ZTDdUT0hzZDF5ZTRsYUhlWEtaSlgzblZJS2NEQy9N?=
 =?utf-8?B?d0dveThrSjlta3VXNFpBZUxUQmdDRXVCRnlzUWRaVy9nQmJEbGluNUxUdEgx?=
 =?utf-8?B?Smx2cGRGZWZmWDd2d041VmdEdm5lS2ZXWjh2K3NKbjV1WjFqZWtlMzMzcGxF?=
 =?utf-8?B?T3pnTFQza0xHWVR1c2JQSEhHa094b1FRL1hORzdDVkJiYWVndWVRQ2NPK2ZF?=
 =?utf-8?B?STc3VlVwakQ1QnZtSkNNTWdaSjhnOHFjQkVqRkRMbTFIQWNXTUJTeHVETC8x?=
 =?utf-8?B?Syt2VGxxRXBBK1lSV1hxYTYvOFY2UXlvWUdoWlRpdUZkWXUwNTBGUWx1cldn?=
 =?utf-8?B?Y1hpUUJnVUF1NE9xY0thNndSRHJBdjN3VnFNSndsa28xWjRZWEN5YVN3djZl?=
 =?utf-8?B?MFBhRDNBajdYOCtuMjF1SUtaYndxN0lRdXBGSzh6emlVTndHYi9xajh3ZGpl?=
 =?utf-8?B?WUpSOTYzT1VjWE9YeTMvclhqTGlOWkVIT24zN0wrYnFtc1RRZWM4OGVvZHZD?=
 =?utf-8?B?ZE1GRS82ai9sWTRtQmowSG92cjVlZWlZZjMvTGhIb0gyZ1A0SzJXZnd2dzhQ?=
 =?utf-8?B?M0Z0OVp6M25QYXd3aHN0amM0NEJJaFYwUU9pK2hDeENJZ0x5Y3RYdmFCa2py?=
 =?utf-8?B?WVkwMTZuaFdNMUgyY04vRHhWeTR3Z3pnNFdwNDEvT3RFb3p3K3QyL3RzaHR0?=
 =?utf-8?B?b2RieU5GSWpMTkdvS1hwU0xGMFhFK2pnZHcrQkp0SFprRktBQ3orcmpJVFBp?=
 =?utf-8?B?Lzh1Q3NsaGw3Q0JjcHZuTEVuQ0lnaTgxalRERXJVMXRWcFBydENubmZ5UVFF?=
 =?utf-8?B?cEs1TXdDT0I3ZWc4TGhhS2ZJclZMbzdJZS9oYW9ySWpJVHlBTkVTMjhZbFFQ?=
 =?utf-8?B?YkRDUGo5RG9McmQrNmk1QzllbWg4NGNOdFFtMXh2ZThjTTVMc0svZy9yaU5Y?=
 =?utf-8?B?Q2d2clhidldFaXNCOTVSUERRNWsvbXdNRWd4TWdrcjVIeEpYb05FMVdGWUEz?=
 =?utf-8?B?azkrSEgyZEZEeGVXbGk0MGR2NFBUQlFNL0RYcXBrZ0pHb3gxd28wTEVjQnR5?=
 =?utf-8?B?NG9nOFU0NGVVVk16YjIyWHdhZXlTRmthVEpLMUhDdVlmRjNqTnM4bzdUT01G?=
 =?utf-8?B?Unl5Rzc4dm1qYnE1Z2VRS3hldnFTT291ZVRnMW1KVnFpTGJoQzZFMEk3THNt?=
 =?utf-8?B?ME5BRnNCcURpemFpa2Mvc1BOZzVzZzNPM0pBMElPeGhpcExtRmoydlVNQ0lQ?=
 =?utf-8?B?ZVJCSXArelJDT01ocGVjYWQyUkVBQkZQTFhxWmZlTXFyTWNxWG94dW1rdWgx?=
 =?utf-8?B?cXJOcE1DVExPK2tVdDU4MG5NOFVNRUg0aVZrdW1wMFBVbDN1STNnMHlpZTNU?=
 =?utf-8?B?MTdTd0U5VWs5WnZGUkhneU1pRkxpM2t6MFVPVG9UWGg3Q3FYZVZXTnJsb2t0?=
 =?utf-8?B?R3lzOWpqbUFVWkNpUGp2SzhDRE83VGI3ODBPMHhzSG9WY0JwK2d3ZGJ4emFG?=
 =?utf-8?B?UDd6SUZodWtIY0s4VGQ1ZTN3Q3lKR1I1eDFXd3QzeHJjb01KRkRsMndMdStu?=
 =?utf-8?B?Nmt4NjRLcndDQ2NnOWptK3RwRm1Ra25GM3ZFbHhUbFpzUE1Cak5XZUdrbHdj?=
 =?utf-8?B?QUU2YnFqRHh2bkErQUl4aTg5aTJQRXAxMGxjaExCRzdYZzRobDNyMUdITFNY?=
 =?utf-8?B?b29qM3RmMGZ1cmlOTjIyRVpibGc2ZEY4MExIWURXcXV1elRadklRb2NXTHRz?=
 =?utf-8?B?MEY0NGJMWjR6UkxUUzR6WmFoMXZnTy9nWXNFN3h6RHdndW12UGIwYmsrOU55?=
 =?utf-8?B?UVcwa3JjdGI2YXFCTHN3allacHhybklkc0RhT0ZlQVh0OGNJNGo4QVJrczU3?=
 =?utf-8?B?c2cyMlN4bTJjbWFBUFg3T2F5MmhqemVsKytIdDdaU2pXMXRUR205Nm12djV1?=
 =?utf-8?B?Vk1EVEZ0ZEtBb3craFVHM3p6UjBhcXM0QXNZeWhpeXlqZ0dEUlR3dU4rQWRu?=
 =?utf-8?B?dTdBQUFESE1neDdOOFIvTDVyYVlzYUR1aWpsUDk3cVJhY2RZODFzNnp4U3dt?=
 =?utf-8?B?TkZjMDk2ZTUyNlVkZkpnNGg5VndZVlF0bkowR3RIS29pSmpGdTZ4aEx5Z0FQ?=
 =?utf-8?Q?JMxr8xfoy63b/JH6WrOZw9/xm?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af469ada-1c06-4f45-38d6-08de1ceeb3b5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 04:41:07.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOczhCh+mqGoQajFzDGxhAYaDbfgHFW6/o7xQYXIyOcUvLAhZoF3qwXb7Gr5PqrADu0T91XDBJpzYo1fb/SMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2918

On Mon, Nov 03, 2025 at 04:19:05PM +0000, Dave Martin wrote:
> Partly, but existing software that reads the file is also likely to get
> confused by the new syntax appearing when reading the file.

Hi Dave,

Thank you for your feedback.

I agree.

> Note, using a comma as a delimiter may be problematic with %pbl-style
> lists, since if the list is discontiguous then the pretty-printed list
> can contain commas too.

Fair point.

> In theory, a alternate write syntax could be supported without
> breaking compatibility, say:
> 
> 	cpu<n>=<mask>
> 
> instead of
> 
> 	<domain>=<main>
> 
> as a alternative way of referring to the control domain containing
> CPU <n>.
> 
> But I think that this may do as much harm as good -- if the user
> doesn't understand the topology, trying to program the masks on a per-
> CPU basis isn't going to work do what the user wants anyway.
> 
> So I think we'd want a good argument as to why this is needed / useful.

Understood. What Tony mentioned previously is sufficient; I should have
reviewed drivers/base/cacheinfo.c before posting.


Kind regards,
-- 
Aaron Tomlin

