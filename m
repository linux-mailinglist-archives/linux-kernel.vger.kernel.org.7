Return-Path: <linux-kernel+bounces-739703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD6B0C9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E99163E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02022E1754;
	Mon, 21 Jul 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lJGzhVqp"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808932E1741;
	Mon, 21 Jul 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119614; cv=fail; b=rPqiNMibmoHN7Oa5+HUpLXVZZWK3q63o9E/h76UgGHlcdxrsG3b12UXu7blUYn8g/X4dOrRgq+CxBjxsh9jMB2fle40MwzWewQgD6YUQP2ATT9XxyDlGzPmZhl3k9Vv/EYzN4LZSyaxS5JtxW+UiU5KbJtuRuaBSeRMVLCHuIgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119614; c=relaxed/simple;
	bh=IQjh9u6DWaw4/NKyXwvCIjvVGtSqfl6N9kuIhbtlP2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tTAFVawYBTdnONB6b+3KxOEwGgMg7UA5kJtVwbeAaKMnkD0K0aRy2OAP+gdkKuHD1+Rt8I9za0k6pBzm7QM1wl3te1Zp7PwAtbNMQ2gShMj3ahbj+H9SBpSHbUwm/FhCfoeDESxZeqcsGd8oqTqauqkFlJf0wFisQkRtpY0zd5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lJGzhVqp; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whAnBvWQpkXprcWG29CqA99voKaKP3YdjYjeUw+PmMouhRwjgqLtf0TQkz297YsUf4WBzEr4+utdk6+71UtS2K2tMzDC+GSXW4hATQ2Ng3RrWW0D9t4gKn+sJP9JYOc18ln1ZJAbYV9HMpzBMro3Z5l7SYVSjzzk0T07XPyCv2qfKs0G3Fpj3Dh+pcOeYtvdn078HtGklWyRBoELBEVunvh25gK6V2dtBUDU95yjh3ItFoMtb9hkpxBKyroR3YKzgJb82DaDRbeErRshyag/aedAmvVAhEPOpgKkXambrgjTNkxsxGK872FpHtJNF7F/2Wu23Qy3inMexQ7LcHAu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1wfpFZZHcjynrLrPvqqmnz5sguCYEAxREXH6I3HEjI=;
 b=I+xM1w0udQOLKTdRkC5kQQEUIfkO3SoMRoVjnoT0Tci7oP6hC+Z0CAexMLWL/ISQi0GyGTF/48wuTmMtJbRKQ5orBRYdpXYwG3djkQaZSBa/q1dMjr34X+RhZvQKYpaiNFN+OECdcCTnpOQrqJOnLnqPtGmDc5ZjvpSWoQItnHawfNX0tfqK4/kLwoy4LbZ4mk0gQGwxxBNBNGXla1jVzG+TmQfqwYbD5IqOkjkxMwR20BvrTmFhfEAgUa4ClFiv4cxkOgdGmRDkCcAMVM3f5yMIoY/d6dU3KIhgxJJK1uJ2OngqmIJHpEDzCR9ECr/i7m5vJeEICK468rC4kHF5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1wfpFZZHcjynrLrPvqqmnz5sguCYEAxREXH6I3HEjI=;
 b=lJGzhVqpCxTXY1npXaJ8mZs8dFccuXJVMBK12aQNUN7ZqXY8IK1tRdVYJ7+IkRux8tOQTWPgRfSN3DRFqNxOJ9pF0FOUT5zuyq4PEKF+JWi8P/Xh+nnyaSYs0HQ0OKBZODO2lkhRLJK6HMOBNvqwg9w4h1/9d0zBQwjYSkQNc28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 21 Jul
 2025 17:40:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 17:40:05 +0000
Message-ID: <1e704b23-b36e-46fa-af28-f135d78a8ccd@amd.com>
Date: Mon, 21 Jul 2025 12:40:01 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 16/34] x86,fs/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <f68d591f2471953e082ce03fef18c309a002bfb4.1752013061.git.babu.moger@amd.com>
 <e525707b-9d62-49d0-9258-19ea936f6d52@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e525707b-9d62-49d0-9258-19ea936f6d52@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fd5582-0904-4b08-8594-08ddc87da10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3Nmd3VFcFl2TEllbzQ0MG54L3pmWWxjNURyYmtTTVN5ZzNSQTBQaFNDQkpm?=
 =?utf-8?B?TjVTTDBCL1ZpaDhmR0VNM2FiMjVVUGVpa1EySjVsd002R1hZdmpwOFpjeHhJ?=
 =?utf-8?B?bEdZU2wvUk5LZ1Ryb0g3dTFLYVVsbFNZdElWVW44Vy9lVTlrNzNoZjZkVzJi?=
 =?utf-8?B?cnRWWXBveG4vbFRnd2pEdzczK2l6Tks0eVNxbWJDWmZRNlRZRG9qSC9BUEFU?=
 =?utf-8?B?N3E1V0lYaVhEQzFzaDNnSE5BYlJqcmExUTR2TzlnUkwxUDlQSldMTmpGdzE3?=
 =?utf-8?B?ODE5ZG9LUVhSSUoraWViK1RHYm1Hb1JSQ1VmNWdqM0Y3VHJmZ1I3dHJydTAx?=
 =?utf-8?B?QTBpblk2UklJaDlzWWovSnlRbU9Ud0l3MmZFbWN4SU1EeVQvRWgwcUFYeEg2?=
 =?utf-8?B?dGNNRFRZL0VwL25OeXNtb0ZuV3ZaV0UvQVF1UjhIWmhUNnNJYnNSeE1LUGk1?=
 =?utf-8?B?QzVQTmYzTVlJZ3o0SGF5N3E5TmltN2RUcDdXaWx2TEJrblh5SE56SkFhUzl5?=
 =?utf-8?B?Z1hFQXJpN3RzTWdick85ZVdjaEVIQWNCRUNieXVNVTB2WUJsZG5rdXN5Nnk1?=
 =?utf-8?B?b1cyWWdmTkZFS1RLSHhBUnBlS3pzWGtuTXJGblhjM24wNHVHOTVURjZYODBl?=
 =?utf-8?B?UnZEQVBnOWUwbFZIdzhkaExQTXhLWXJMZGk1RFJ5ODM3eFlaZWhjbDlIWkJj?=
 =?utf-8?B?bHQrTERMNFpUamlJRWM1cVArRDQrR0dsM2N3bUU1VFRBWnA5d3pKaWM3NmdI?=
 =?utf-8?B?MUhMR1JsNGZtd2dYNHlHOVEzSWgrN3Q5NjlFMDRFTi9Zc3lGWFZZOEdwSG93?=
 =?utf-8?B?L3lLeVNna1ovQ1BTcE8rVG9PYnM5RDllTDdpMEs2YWtTNk9WNEVVWEdKRHdY?=
 =?utf-8?B?aWg3Z1R6eWREWWdFWUVsNmw2WlhCZXRjYW1tdUg2UE8rVzQ2eG9iNHNDUXBR?=
 =?utf-8?B?Tlo2VkZ5QTBydGZjT0pLaXZSVkRBMDZQWEVtTVQyQ25qL24rdGhvSTZqK3dM?=
 =?utf-8?B?WWk4ckdyYlM1c0NEQ0EzcVlyYTFTQnNPeFFjU3dKR0I1Sm44RUR3Z2NYU2Jt?=
 =?utf-8?B?eTh4czRIWWU1WUpuRkhBU3VabkdXbi92UmJmbSs4U0MxYlN2cW1XOUcyTXZ1?=
 =?utf-8?B?d0RwR2dCRUdDTjZHTGZZNnZUL3oyMjMydWZ4U2ZYYVJKY3JNb3ovTlpwUDl1?=
 =?utf-8?B?bDJKZVNmUGxkbE5lK1Ziemo5d0tWVUtGNHh4YkwwaW5vRzRGMEppSzRWWVFp?=
 =?utf-8?B?UzZaWlF0MGVRUjNXUFI4c2s5RUxaT3VHSndCUStqeGV1VnBTTlpXNlhrTFJi?=
 =?utf-8?B?UE5FOG5QcjNlbDloQjRmVUVEazJ6aXgzWCs0THgzMkZkL1IzR09HQm5UUjht?=
 =?utf-8?B?K05TZ3ZFdzQvaUNNVnZoOTAwNTJRTmx2WXEzSlBMKzhNWDdmeHNzVzRuUlFT?=
 =?utf-8?B?Z3M2ek42YVlTT2paVDA4eklTVTFvUkIrdW40d2lmUVVERjkycGQrQ3orNm1Q?=
 =?utf-8?B?TW1QbkdiS3IwSTVBZTBtYi8ybGVudlBPbGhDWWhZdkQ1b2hzVkpzcEdEUzM1?=
 =?utf-8?B?R3MrMi9pSmhCa3l0UjYwQWZ5dnFzTm05L3gvdkVTOXN1QnN3c084UmJBK1BZ?=
 =?utf-8?B?eVd6b3NCVW53NU1yMWp4TmhWSHdvR3FIUjJtZlhwQzFsUTdhWm5vSnZkOGNn?=
 =?utf-8?B?WUlQNGFOUmFPZVBkQnU0RkhzSU9qa01Ga0txSkVQcG5jOUlUbnVLWEQrY0h2?=
 =?utf-8?B?TVNPRGE0UjRoSXdJekI0bVdOcGFCZmNkWmZNWWJXOVU0Z21pTjY2QzlUdkd0?=
 =?utf-8?B?TUxsazh0WGREZFZTdVFxaTNVZ0xUaTVyR01FRExJZXkyb2Z0dDlSVVVkUFpw?=
 =?utf-8?B?SFpnMHY1NDYzTVlnWDBKUjFjNVJqV1RVanhEbVd5Y1YrTG9xZ0xJZy9xSGdJ?=
 =?utf-8?Q?wEmRb/jBlJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjIzMklwVU04ZjlpMTVsa0p1ajRrNXhxZHJyeTJNaW9ubDRaVjFFQ0dzMk8r?=
 =?utf-8?B?TVBPdGl1US9jcHg1Mzg0NXpwNUN2SVN1bmZ3eCtDWWV4THRvaXFvVWhLTCs4?=
 =?utf-8?B?MXdFMzFzV2Y3Vmt0cXFOYVFKUVdQUVRnRXVtRTFlTzVYSnROVnBoeEczVDNy?=
 =?utf-8?B?SGhNYkM1aWYvc1ZIKzVOVnkvbmN2Qkw0RkpQYVdlbHFlcDI0ZW55SDdpZHlt?=
 =?utf-8?B?Q29sWDVHbjNpUlFNeHN0MjFERkRwSyt6SXQreUNId3VETm9YMWJTZFIzSyt1?=
 =?utf-8?B?MUZEZjZJc1Bnd1dJZzYxd3I0Q1Jxd3FXWURiSDhyNU5Hb1JDeWpUOXBUdWwz?=
 =?utf-8?B?Nkw4OG1lTXBKbXpYZ25xN1VlOTJYUEFjSnFacDM2OVpQYnZ1eWp2bEtCTWVu?=
 =?utf-8?B?djZVbzdHTGxOdkViZlZzMXZHUjI5UUlvTlFCU21qNENaa1UrR1EwUmFaaVlD?=
 =?utf-8?B?dXBISEhXVGJ3SThKTGpXaGw1MjlXaDN0bmwwK0w5V29aRS8wOFFneVN4aGdY?=
 =?utf-8?B?SUxMNWkrd25pa1QzR3BNbTRaQitTdmRmbEVLL3hyTTF1VDJxelhFSlFaOWZW?=
 =?utf-8?B?TVQvRjI1Mmx6T0VBenRSZngrRXM1ZWFBVTFib0RBc0RpYXRWV3MySm5SWkpL?=
 =?utf-8?B?bUNXY083MXdRMEVnZm01ZFBxQTdnSnp0dE40NFh6dnVzeXJKTXNnTlQ1RElm?=
 =?utf-8?B?c0ZxdE43RzlPbVpIVFhiMTZ0emlXa0xHOVM2aVF4OWFPNWFRUFBzQ1FGNzdi?=
 =?utf-8?B?SnNhb1lFeXRFMWNxSFhKL3MvdEllb3VwSU0zQm1tSVFUbWZHeGl2UWoxZ0RS?=
 =?utf-8?B?YjEzZXBmS0paNzFVUWZuVWg0VmhtdHoxTTZFY25XUmxlS2pWRnJubXdWT3p6?=
 =?utf-8?B?VmNHT1A1RWxyeklreGZ0K09wWitpQklDYWNYdXdZUnpoMWdMYnE1YTd0bWdF?=
 =?utf-8?B?UWdYaEhjaCsvbXFSTjFPMWZ5UEdpWW5aZEJiQXNibk5CeWpoNnJwOGxXcTRX?=
 =?utf-8?B?R3VaUTBrcDFNQXJIcG5acmVWNzRYcUxjcVFvbUdKeVdZK3d3QXM2ZEt1a0gr?=
 =?utf-8?B?d3dObXI0Q2psbHRGek90d0NkSUxQWVdNeUZtM1Q5Q0pxbWkzck5nN3NKOGdS?=
 =?utf-8?B?R3dNYWJiQWtuVDRrbUZHVDkwUERHR3F6SENwaWgxbExVdXN4YnY4QjFmWVVV?=
 =?utf-8?B?b2RDLzFxWk5Vbzk0c2h5bldDdWxLdlpoTjlQMWsxdm5DZGVvdUFOdDNiZGo2?=
 =?utf-8?B?cHYveVRCdGZVSEZiYnVEQTRxQWJTS0dlYUh0SmY4L3hGbUxQZkJTVG9Ba0Na?=
 =?utf-8?B?QmIzQitSRzlDYm9IUzFsSUY5Lzh5Zy9YT0pnbzhhSHV6bytqMUVwZXduWGc2?=
 =?utf-8?B?V0tLK0dwcmxCNnNwSHJRNzR5T1FqM0xZNThkU0VPa1VmMUd0WENWbDE0ZHZF?=
 =?utf-8?B?eENTajVuLytZMG9wWmk0RHpTWStKeUdqS2hoS2dlYVZROHhOTkZsa1Z6ZVRi?=
 =?utf-8?B?WkZXU2phT2hsR0QyYWJXK1ZIdkk0T1lBRXZLYWQ1UTh4TzBqSGI1Mml3UHFx?=
 =?utf-8?B?OVJQSW5zanMvcXoyVFRVY2RjMVVLaXhFYTU0MTRpV2x4ZzM3QXpRS1JwSTBI?=
 =?utf-8?B?TloxWG5XSk4xSnd5Q0xYck1aWjQ4b1FzdGRrV1lNRjJWVmp4RmF0dVQ5Vlky?=
 =?utf-8?B?WnNYNFFDZVdqdW0wYzJXRXRvd0dwV2ZZU1hjejV5aXErbjBpYW90UFM1RTcy?=
 =?utf-8?B?QVdDbk93b3RmYnRsU280VXlSWm96cWs0L0Vua2wyNmpHbUtBS0JNU0x0Uko3?=
 =?utf-8?B?MTRCUDgzaEJod2pmeGdYQ1NmTU9oUW1VL29wVzIwcjdhRkhjcTRRK1RMS00z?=
 =?utf-8?B?eDBmTE1NQTJ2L2cvYUVRR01hN1A0bWJlbndKWm14SVJ5L2dqbHZyMnRtY2p5?=
 =?utf-8?B?ZHZEZktBMkRWSXBvWkwvV1RIZmNrK3BsSXFQYlUwVGtjVm9jM3FyYm9rWkhF?=
 =?utf-8?B?dmM3aUl0c01iME1ZVkpaeUxHWDNtZ0lGTFV2QitRT2cvbnBXQTBZM2kyWEd2?=
 =?utf-8?B?UUdTZndZdDROdTRUN0tzb2Y0dmV3Y01ZaytnaTh1UUhsSmlDa1RHbmVIWEM5?=
 =?utf-8?Q?yaY0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fd5582-0904-4b08-8594-08ddc87da10c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 17:40:05.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RRUdk1EHrBkjUmAQRKQ+yJ3zgYivGYYA4LJ1cQTlbaWkIrV+vwMd/hgYhi95uxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Hi Reinette,


On 7/17/25 13:49, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> The ABMC feature allows users to assign a hardware counter to an RMID,
>> event pair and monitor bandwidth usage as long as it is assigned. The
>> hardware continues to track the assigned counter until it is explicitly
>> unassigned by the user.
>>
>> Implement an architecture-specific handler to assign and unassign the
>> counter. Configure counters by writing to the L3_QOS_ABMC_CFG MSR,
>> specifying the counter ID, bandwidth source (RMID), and event
>> configuration.
> 
>>From above description it is not obvious to me how configuring a counter
> is connected to assign/unassign/configure. How about something like:
> 
>   Implement an x86 architecture-specific handler to configure a counter. This
>   architecture specific handler is called by resctrl fs when a counter
>   is assigned or unassigned as well as when an already assigned counter's
>   configuration should be updated. Configure counters by writing to the
>   L3_QOS_ABMC_CFG MSR, specifying the counter ID, bandwidth source (RMID),
>   and event configuration.

Looks good.

> 
> (please feel free to improve)
> 
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>     Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> +/*
>> + * Send an IPI to the domain to assign the counter to RMID, event pair.
>> + */
>> +void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			      u32 cntr_id, bool assign)
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct arch_mbm_state *am;
>> +
>> +	abmc_cfg.split.cfg_en = 1;
>> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
>> +	abmc_cfg.split.cntr_id = cntr_id;
>> +	abmc_cfg.split.bw_src = rmid;
>> +	if (assign)
>> +		abmc_cfg.split.bw_type = resctrl_get_mon_evt_cfg(evtid);
>> +
>> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_cfg, 1);
>> +
>> +	/*
>> +	 * The hardware counter is reset (because cfg_en == 1) so there is no
>> +	 * need to record initial non-zero counts.
>> +	 */
>> +	if (assign) {
> 
> We learned from patch #14 that the counter is reset whenever cfg_en = 1. Since this
> is always the case it is not clear to me why the architectural state is not always
> reset to match what hardware does. Even more, looking how this function is later used in
> resctrl_config_cntr(), the caller resctrl_config_cntr() always resets non-architectural
> state, why not always reset architectural state here?
> 

We initially had reset logic for both assign and unassign cases, but later
thought it might not be necessary during unassign. However, it's better to
keep it in both cases, since resctrl_config_cntr() resets the
non-architectural state regardless."


-- 
Thanks
Babu Moger

