Return-Path: <linux-kernel+bounces-753280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E69B180F5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E1FA8506B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F524679E;
	Fri,  1 Aug 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zqxuzv2F"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60423D28C;
	Fri,  1 Aug 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047224; cv=fail; b=KTzApzjKC0WlbJpAViPGbmjAR0/ntgccQy9A6UmnseCeAQPBqdiS73r7scbq3M1gJxfijiVFMvsHM/PgKHLI5VYZgIK5taIVeGrpNd7NTpwpQu9ABTbLuUUYV2gAsthRaA0fknPDkzsER2j4c5dh4IdrCJcdJZyMYOjvQIVscZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047224; c=relaxed/simple;
	bh=lBn0vQ0DGpPogRUGoUNdACGbwgttfTv0YsZp3V3PdFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VgTUT14D8qAnlIb1UJoQt9sTHUeVTEVzpNytA/8Aa9jkdsFkyKu7+BEfOrIp9H3YjtYGrKz3NepP3m1f78PxBYVjVSGjXKcay6ZVWy2otW5Vkj4H/4qMcJIaEHwYJ3Va4oSHJ+5c0JncKdZwQfCicoxPoMMEnFqfLiVFUGY0R/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zqxuzv2F; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBGmHDn4b+8B5FwMU8q1+6vTx+ifhVuopchNSdzn7CbtaLi8Xw3XQ9wy1Wcq3btRmtF5zXkWVFejxfuOzITTFXZ2wTDXu0jzk+1q1+Zo16YcKZ0+rh/+HetTWZ1QRaw8NOQGtQyhMgGWfJYI5QmSsNIq464D1usMcJxoFRJIGTk7Jp9krkIz0ox60U04yTMbusLnfwiJspG0qpI3VjqJvnRwZjI3JBjqWoGfE1wTZVpTrOEY0HAZex0zlEQwTi8v9xs6MkGy9mTV+npUDlLqRJ0xK4MgH5eh9XZURcO/2HqVgbNrmNpb3uE8u/qkwoCAaTpWOi8akFvvGNQaxFmhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3McWgWhs7222zCFuaGsU6/zt0g2soAcVVi5EexdzPVg=;
 b=pIORt7EQZpJopU7cSGP+Ucdpv9wWlbtKKjw2/cnPTq9wpwNjsDNG+AjcjYAQLeIVjxl0cZI5lH45gDJAKAC1n74A243wiDAZ7Bz1KB5tGHIZoQzxHv+BlP1okL8JCt9cEO5AelDCXcFxRitzwScKf+5NvMv7w9hiplh7eAButLtN1yhs4VCsnvo5j5yAwsnbiSqpkMq3yRfoyErP4zX86tQ1J5rYXY6KGyQDlLkZUm2l7NsU/4ZOHtdZj0l0HmPuTdcuJjotWUi43CtBSxfwv2FPJ5WYLg4sh86nYb6Az714CJWV3VOyDKvq+49pyOQrZZ2RyVdYucqP5/rED3MkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3McWgWhs7222zCFuaGsU6/zt0g2soAcVVi5EexdzPVg=;
 b=Zqxuzv2Fxs/39Hx8Yok6ivQEahpgCcnLKV7Tejz2uUKjEZEr3C/Pg4NyBje3S+60HvTuWOk82WuQZN33BFJqDPSAJ0uKdfv3BJbmL0Lgqhil8ZRJN6LLB+X5nJ7VT6/5qNfVOX7fQc1GtiSXZEzmJi4oUdcMa48q0LH2jlhih40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 11:20:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 11:20:19 +0000
Message-ID: <1122b41a-92c7-4f10-a095-6f0820a605d4@amd.com>
Date: Fri, 1 Aug 2025 13:20:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] arm64: zynqmp: Misc changes
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1752835501.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1752835501.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: af5428f3-ef17-4f6c-2a4d-08ddd0ed6632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFJZMTN5VXFGekh3NGNwZFVPYVU4dXA5bGpYVm5GWHpnN3BMVDk2dzFCZ2pN?=
 =?utf-8?B?WkM0bUVJc09OOUI3cVdVVDZncWdKYmF5VXhmSVhFVGFJU0phLzFZNVNzYlI0?=
 =?utf-8?B?TkVxYVcwMlZkeExkYURYenJnN1FKVUR3QXQ4YUxBQXBxQ0FFMmhyZ1VVKzV5?=
 =?utf-8?B?ZGVLakpacm4wTXlXL0tuVEVIdXphMWZ2N013eXhkcXBUUjVDOEt5ZjBNMXd2?=
 =?utf-8?B?VWU2R1RUZmpNUVNOZ3ZRYnQveXNicXArL2RudTYrQ1VVcFlTNFdpV25Pb2hZ?=
 =?utf-8?B?aExUMHVUSU03TWFVZDd5SHVwY3pXaWVNYzdVTTJpcnpoUEMrbGVtM24zZ1BF?=
 =?utf-8?B?MHZGSHU3TGlyUzJLUG5zSkwyOEpNL0VYeVRQMzg4aEZ2bTdGWFlmZmNVZC96?=
 =?utf-8?B?TlJVRkV4eEhvZytXeUdKVitwMVJMSTQxOUdpVnM3SENaS2dWQ0VtSjlheFZD?=
 =?utf-8?B?ZVRpZHArRlBFcmt0MUlNYkRhUThHVEFCODVkbkRnSE9TejJrcWFEV0pVSTJo?=
 =?utf-8?B?WnpqUUhnOFF2TWJ2MTBKWXQwS0F5aVZScC9HcTc4bkllUUNpTXRRR0FzRkIv?=
 =?utf-8?B?RzcvSWdURmN3aENvcjRsQTlJMTBCa3c5cGZJTHphNldVazZ6cEkrUzhnUFlz?=
 =?utf-8?B?b2dhSE12WVJmbHdzMlRBdGVKZmVYWTFQb0dBaExROFNnWlhXTTlBdFh4b0Zw?=
 =?utf-8?B?ckFNTi8wL3FIL2FNd1R1d3M5V1FhZ1N6cG5vTDhPMHg4NkVtUVltdGJRdzJT?=
 =?utf-8?B?VlR3REwxUlhCR1FwVzBhOTdjcEFKeXMzWHRzUDFxc2k1NlFoWnpHeThzVngw?=
 =?utf-8?B?cFkxczJLVzBBQjIzYjZ1ZnVod2RzV0lzOXFkbWk1eXVNcVNEeVFhbXF6NzZD?=
 =?utf-8?B?Q2l2NHdoVFVKQnNSOVFUem1mYWROeTdvZkpPeWdYUEFOd09wQTF1RXE5M2gw?=
 =?utf-8?B?cVlwOFNJQmNHNmVhVHprSzkxRmFVUHRna3lMQVBHU1JPcHEyazNkUE1jVG1M?=
 =?utf-8?B?cXJZbnZmazJOby9KKy9rVlpzNFRCcWd5VzRHUjhQaU1LeE1pSTk2QlJpUVQ4?=
 =?utf-8?B?NUVaVDUvemdBMEtScDEvako4YmtTRWRKRmEvWHVzWDJUZ0RKMDc2MHgvNnhU?=
 =?utf-8?B?ZTZmWThJYWZTc1Y4VmtwMGdXdnZPREtwdWg2ZXVrc2lGSkR1NkM5Z2pqYWFy?=
 =?utf-8?B?OWRYRXFOTUh5ZEVqdENucEpBTXIzYnlORU8wNXpxNlVHaHpUdDNrY2hDd0ZV?=
 =?utf-8?B?RmoyMjEzeUlqdWZVaXM5OVVWSDh0N1drUk11VFkxbFBBVEM3cWtINUNveWNE?=
 =?utf-8?B?VWNWVFlkSU9YSmtYRTdvOHZQM0czRWV4R2RlakMrKy80L05qakd5bE1IVUF6?=
 =?utf-8?B?cGVwakdmbXE2UlpqMnB0bFdtVmgwVldCY0pjTXM0RUZwMHZjZU0zSDRvMkVn?=
 =?utf-8?B?R2JabUVQNld0RDB6SUlWRXUrR21KZmhpSmhaNkc1Qy9sMVZMbnd2VGxHUElW?=
 =?utf-8?B?b0lCdU9wMHhROUZUTFJTYWowek5aSnAzLzVLOUlBR0c5SHFsbjB4b05FUFVW?=
 =?utf-8?B?elBGSXJjUWpSeTRYb0ozeWQ4cENtMU5MKzJVd0VMNnI2UU5mWStxdWdnNnls?=
 =?utf-8?B?ZzVWNVNQK1lqTmJGWmNDZnhUVHRwY2hsVjhmQWVUUmdFdk5TVy8vMjVickZ1?=
 =?utf-8?B?WTJPajZUUHBhOGQ5VTlMQ3VHZ0hxbElwcFVwYW16VE9MdnlIS25KSThiUDRC?=
 =?utf-8?B?QUpwMkpJeS9TdVdFZTlra2d6TzFRREVJaGNYVVVSM1NZcEpxaHJid2lrZWg3?=
 =?utf-8?B?b0hkQW1HQ0RoZkt4Y1NlNnlUMzZORFlYQ0ZuNEJZcG5TU1JRd25BaGlOb2RB?=
 =?utf-8?B?dTV2THpzNmIrZTl0V2pYeWpRYmtCc1MzTnNBa3RBQlpqNlRtWHJOcnh6T2Uv?=
 =?utf-8?Q?d5iTkMEvfcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGlCaU5uZGJyNVpka2s4ai9nVHNZb2ZwNU9YcGRrTTI3cW9SUWNLNmZsNlk5?=
 =?utf-8?B?cDJoYWlUcXZKWENuZEZwVzlFWDRWeE1vZFFQY1BKM1FnZ0c4cVN0aDJ5YWt1?=
 =?utf-8?B?QzYrVGx3UXE0RHdvS2J2ZWtjTDFCa2cxUnlWMllHeGRydENna1RybHVhTExx?=
 =?utf-8?B?Mk13UkFkQmxISUZLNGtYNlYvR3VWSmFVY1VtOWhHQ0huWWdSZWhWcS9Tb2da?=
 =?utf-8?B?eGxkLzVDRTY0K3BkUk84cnl0MXRKV1JVMllUMStOaUdDZ1hmOUlYSGhLaDRY?=
 =?utf-8?B?a3VETTlKYU16d2lkSGNwSGl1THUrUmlwOFJzSzlmaDQ0Z0lzQjEyUmV0ZzhZ?=
 =?utf-8?B?amhHdWI2aGp1M0N5Wkx4cE9landkTDdjaEIzNFd1UW1ONDA2L2kydmJsSWcv?=
 =?utf-8?B?N0RMRm1ZbmJzMkJjMnNzM2llTlM3WklQY0d4R0V1MUQ2UHhYc05ZQXB3QVRl?=
 =?utf-8?B?T1c3MWJSRHN1ekdGUXJwcmg1TXV4WnhabkcxZVQ5elRpaVdoZmpvalBYbnBQ?=
 =?utf-8?B?M1hBUUhKczc1eThndXh5K0c3amZEYjVZK3FjWm11OURMQkg4VlVlMzlvUzgy?=
 =?utf-8?B?ZmUzUmdmRHgyc3VqVTFCdzZncElhZkVQQlBlbHpZSW9HTVV3eTJjRHJnRENp?=
 =?utf-8?B?d1FyZDNJYlM4aXYwV3Z0U216aERESlc2RXQ0R1RRWndnTTdHRUhzWjFSMW4y?=
 =?utf-8?B?eFp3ZTFXRkIya3RBbmVTTFBzdkEvY0p6MmFSYTZtYzFja205bm1taTR5NlVT?=
 =?utf-8?B?Rm1Demh3bUZicURPZFY1VkpHQ2Vra3pSUmk3VFFTbW5tNjhGL0szZGwybG96?=
 =?utf-8?B?ZVMrM2JBTWx3VkdIVEVXYU1wZG1hRGk3aHphWlVWSVZhdEtVYnNIanBObkJZ?=
 =?utf-8?B?RkpVZFQya0tGb096WkdHbTNOanI0U2hLUDVic1BTWml2RVNadmVJYllyNVZk?=
 =?utf-8?B?RWlOTC85OTlXUW15Y2NaSTR0bU1BUVB6MjNOWFBHTktGNVdmTlczMlI5Zmla?=
 =?utf-8?B?cWF0YjdNOG52cjB1OGtZRDF3NjlmNGszZ0FtZlluaUI5VGJ3Y29lOWcvYnlm?=
 =?utf-8?B?MVA5U3o2WXNUdHR0ZjMvQTlEeTliWkRIZUVVWWN2NUZGekZXaDlPOVRzMlJX?=
 =?utf-8?B?UlNld1p3V3l5RnlEcmNENWt0T3licjljSEI2Rkt5N0Q1R2o4VUNQcUtsVndU?=
 =?utf-8?B?MC92a0FRejc4d2ViVmh1WkFqTXNwMUJxUEx0UUZXeXAvRGFQVkxDNmVFanQw?=
 =?utf-8?B?TFVkUTVvUllKWkhOaHNZdytIbUlvZ0ZUc2tuUG5iT2U5K1VqWEc3WXJXMldy?=
 =?utf-8?B?dUttNC9sdFBBVlczVHMyREFnV3FJemZUT0F0UUw3QzEvUTBNOEtRNjBBRmxC?=
 =?utf-8?B?d2tmK1RZMXp6SnJpbkdtRS9obmRVMVpUZTk5ZldOWGxxZkphem8zcnd6N3RC?=
 =?utf-8?B?bjFKM1JHZ0xGSjhEZ2QzK2MxOHRhVFFYOUpsTklsQkxQKzdFMWRQdmllOHRt?=
 =?utf-8?B?aHVjRVdoRjhVb1JnYkpGemdQSE05UGtYcm9vd0ZDdnV2WVdUWmRodE5tWFY4?=
 =?utf-8?B?YTVsdXdBenM0N210MEE2dTJyd25uamNVczdRTjlKblowQ2N0aXV4K3hjVDlC?=
 =?utf-8?B?ekJFdjNveExqdyt6SlFkMmVkNkc5SzI2QlpyNlorUldXdTJqUDM2T1NPR2dH?=
 =?utf-8?B?MENkY1M0K0pPRW55NnNWZjkrWWtJNm1PYlhxTGEyd0xwdnNEMEZ1ZTRZalAz?=
 =?utf-8?B?ZDUwSWJ2VEM5YXJmSHk5MXU2bHVNcHdkdnhRK3FzQzluc3YvUHNrOG1hcGlP?=
 =?utf-8?B?R2RQcnQ5YmxTcHNURjJBR1FwSytsVnc0NG5OTW5WZTZ2V1VSeVNrbkU4UHl4?=
 =?utf-8?B?ZmdhSU1pM0RYNzdOZTFPT0hSNlZaY0dKdWo5a3NNOWovUWJCYmlVaG1iL3BH?=
 =?utf-8?B?c0VqOENkVVFuVVZYOEdrcWhhMGN4dEpKNlc4TFMwSmZERmtQMlo3d1phV29p?=
 =?utf-8?B?WUpBTTMyRldiTjg1L2ltVHpZMU1hTkJRVkFOTzAzb1lIODVEdGlSZ1EzR1Vh?=
 =?utf-8?B?ZmhnVGZCM2xIYStDRllBUUpoUjF2cXRzR0xlTUxGVHBabllkUWNDWU1oS2JK?=
 =?utf-8?Q?BhBl/yuKOHLS32HnKWAb0eK+/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5428f3-ef17-4f6c-2a4d-08ddd0ed6632
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:20:19.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R9qtczISu+hf1CuaR9NMO3UUuPTdrYMyrPbWTGDU2wFQ9GRvI20rn3qo54VuOKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197



On 7/18/25 12:45, Michal Simek wrote:
> Hi,
> 
> these are patches which I found in Xilinx tree which have never been
> upstreamed.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (3):
>    arm64: zynqmp: Use generic spi@ name in zcu111-revA
>    arm64: zynqmp: Remove undocumented arasan,has-mdma property
>    arm64: zynqmp: Introduce DP port labels
> 
> Paul Alvin (1):
>    arm64: zynqmp: Add cap-mmc-hw-reset and no-sd, no-sdio property to
>      eMMC
> 
> Rohit Visavalia (1):
>    arm64: zynqmp: Enable DP for zcu100, zcu102, zcu104, zcu111
> 
> Venkatesh Yadav Abbarapu (1):
>    arm64: zynqmp: Update the usb5744 hub node as per binding
> 
> Vishal Patel (1):
>    arm64: zynqmp: Fix pwm-fan polarity
> 
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 19 +++++++++-
>   .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 35 +++++++++++++++----
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  7 ++--
>   .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  1 -
>   .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  1 -
>   .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 21 +++++++++++
>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 18 ++++++++++
>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 18 ++++++++++
>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 18 ++++++++++
>   .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 10 +++---
>   .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 20 ++++++++++-
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 12 +++----
>   12 files changed, 155 insertions(+), 25 deletions(-)
> 

Applied.
M

