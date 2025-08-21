Return-Path: <linux-kernel+bounces-780129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D515B2FDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372EC7B13CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1FF2D6E45;
	Thu, 21 Aug 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnGcPHzq"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980228725A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789046; cv=fail; b=aRPuoFj3DxSxZn34AbCH4lduGKDtUWJZLyiAMJh62FpHNgzZIXj3XjJPSPmXzXZnFuaGKE/NBTMZ43tENtK8whUjYr5BuqHDPZ3ZlqygA/l6e41KshAngXvPUrEDasCr1M8k/eB0z/piIzuYJMt9ty/UjLx/yCE9TQxhAgM3r6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789046; c=relaxed/simple;
	bh=Lqty/zG8EryEUYucislmYnF6woFHN+TeuE60tqEL7AI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZwxEW2ubX2CSs06RklGy4Y9B5mTUOKd7UT14H4NvyBSjofJ29V7iNdZIXAKWxfDPpfR6dd980U0iZmviCNtkou6TrRWOgBOA9ziUjroWF9ulPc8kzqI/EnUSVTMkb6waTCLlYsjurik/4J7Rsa+nmQ2hcIJp8xv8/xyfymAKfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnGcPHzq; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MijM3BSvOTeoQ/wZXFYzhI2JtswAnDiwo2RLZlylIZPuk9wpuvo70jyb0qd10RiAj6qSsrY0zdytM6XWCm+bqTYkp4uDvRNo0QIQBhcFHu1liPRbNk/rI6vKiG5YTzbh1ns5q81W7/+mlnDGKD3Eg+/14Z3dy8WUA8Gj6qUxp4fHUVMXgHp2aIpyEooiVRuOE1Xhmm/ZCVZYN+5LYPS22TVcH9NEa3YciUnMW/xZGJtlZY00b5THeRGH8yIp4mntHLrgpIbhIYBEBiB/h9Ig1yg7+3LE+v9u5hT87BYErAMb6Ap6/A2saldZRmsJy3J9F+0dTsK4wklxvj2WYv4tSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrdQNRSdLJsYgea4TQJDA5nlRrf6twmeq8DDDNf4Rvc=;
 b=mASe9OxzQ9WZtDeFKGDmPDUZ9olkv4S6KmBoU3TqJ55kL05bw6LiLPqN0Xhl8nNflIUwxszI9EpXrlYTm2mjij17rAkxL+UioEnXlkMxrsLDoNisnbts1jmPmBO/fdkHkUwr/eukHP3IxzE6MYWK8zvjyiTjP8pGzySuC9IQtHBYf1U6q1PjoAT3SOQiRKXt9AHgWU631JGYd0ScJaXOvM39cltf6IZhP50sPvQU/3jxU7zFPQMoXXK7Ger3hmDXeAjez/oPQEY/of9SBCdovBr58+ZnObVB4KrIu5YO4oU2uXL7Vo3YL9+znD+lfbElFfooT/pbnEEk5uVrwITioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrdQNRSdLJsYgea4TQJDA5nlRrf6twmeq8DDDNf4Rvc=;
 b=EnGcPHzqrOtEizPZn2X86pYVxfkV52S4iwJ0kIiFuDaYoTiNE2sVrqaGf6+kyYm5Kp9ikKxKx21eupvByjpcS7S1F4pVJV3pA1v/xw/UUkZG/9gAT45+yIHSAJBU0lOkaaCx0oFJiHBhOqSmLSblETRRbXsy3hQLudhYO2k6trY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 15:10:31 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:10:30 +0000
Message-ID: <5a61df0d-f2dd-49f4-97db-36eaf1ef4e62@amd.com>
Date: Thu, 21 Aug 2025 20:40:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/7] mm: Hot page tracking and promotion
To: Alok Rathore <alok.rathore@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Jonathan.Cameron@huawei.com, dave.hansen@intel.com, gourry@gourry.net,
 hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com,
 peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
 rientjes@google.com, sj@kernel.org, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com,
 akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
 kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
 balbirs@nvidia.com, alokrathore20@gmail.com, gost.dev@samsung.com,
 cpgs@samsung.com
References: <20250814134826.154003-1-bharata@amd.com>
 <20250814134826.154003-4-bharata@amd.com>
 <CGME20250821111729epcas5p4b57cdfb4a339e8ac7fc1ea803d6baa34@epcas5p4.samsung.com>
 <1983025922.01755775202288.JavaMail.epsvc@epcpadp1new>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <1983025922.01755775202288.JavaMail.epsvc@epcpadp1new>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6439:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: d79fd799-61af-464d-06c6-08dde0c4de13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2lQa3FCQStsdEkwTWc1TVJKM3ZVM0wzWFh6QlVmbVRSbTdib3IzY0czWUlB?=
 =?utf-8?B?aHNJbDB2SS9WeGN4VGlySXU2dG1Kbk9JZEkrZ3FVdXZrTDRrbmdxR1U0b3lm?=
 =?utf-8?B?dnZNSEUvRm5yekVEOTdxN3dNN0FHeEg5YWJEQnAveTZFT01QbTlrTEJjUlpC?=
 =?utf-8?B?TkZXZUR3QVU4UVBGamdZVkltV2dKVzYxMjZyUVpRZ1c1clk2K1RNcmkvYmlr?=
 =?utf-8?B?TlltMGUvVGt0YXVBQmo0aGNIamsrbkxkRW5GeVN5aWhRNEJsdStzT0QxVk5w?=
 =?utf-8?B?LzRKcTgzMUVYYVhNQ3RQOHUrNHptWjFPcHlCVGpTR0cyNmtDRVV4Lzh3c2tP?=
 =?utf-8?B?UGs0RlFvZHM1eW9rQklXM1FhdUZLeWFKN1lQbzNNT0U2TGluTS9NV0hHUGJJ?=
 =?utf-8?B?YlZkbmFpZEZyZEZCU2MweDBJUkU3b1lyT3RPYkJaemF6RXdlNTBMVk1LLzFJ?=
 =?utf-8?B?dDYwR0ZVYmR2eUFSMnFQYXE0MW9MZUhQQ3p3dTk2Y2xzYkkvUmltRDlaU1Vw?=
 =?utf-8?B?SzVEOVBIcmcxVS9VRE9pYkhxNHhhcVFJcEp1Y1NHSW11Ni9jTFhRU3Q0NUNt?=
 =?utf-8?B?bnd3b2tvTGVzdTFTZEd1WTAwNXNVZnMra3BJdGRpZkdWcTZPK3IzVE8wK2Vx?=
 =?utf-8?B?YkpFR3lWVTl1SjlqeG5FOGx4aHN1eVlJOU1JMC9sczZWS1pFQmxaU1lXNHRt?=
 =?utf-8?B?WmdBZEpsamQ3QytZRWozQ2lGVU1NbEVqUzBUc09DVDhjRnl6YUZCWXZWakt6?=
 =?utf-8?B?NGdZL1d1RVdqRG43VW9PRVl4VlhhSXVpV1licVYxeFBXZ1N3S0JFZmhDUnZJ?=
 =?utf-8?B?UVJSQTFPV0I5clZ2enVlUGJhSnVHQ25lV1orOHBEb09zSklXMHA4MS8zWDNO?=
 =?utf-8?B?dDdYb0c4cE95NnhYUHFwSmlmazJtSnhWdnJqS2REVDZZc1psYUlzRXpPSGho?=
 =?utf-8?B?c01vbC9XejZjWjI3K3NYdytORkplNzhac0l2ZENLMCtuUDBwdVI3VXNPajR5?=
 =?utf-8?B?WHVKYkNMTC90MjlTYTVPeFRuWEFYZzJQenVLenNJUHovZmNYNFFwZ0Nkd0ZY?=
 =?utf-8?B?TFVwTzlPNGpjajBOdjg1YVRDcDRlMm5iWVhQcEt5RG5Ed1pCTkpKdk1wY2w2?=
 =?utf-8?B?cjg3OXZTaUJYdE1sL3BjZkh0WkRBL0xBd3AreXJFMHJ3cmk4REE2QjhWKzJV?=
 =?utf-8?B?N2tHZGVVSnp4V1FqQkxGZ0JhS2UzK29kKzVLZnZvNVl4eFZ1YkxvN1ZSSHBO?=
 =?utf-8?B?YmY4T0RJMFh6R2hlV1FPSWtweHFQdnBwRWJLK0VJR2VjMkJNYkhua21DK3B1?=
 =?utf-8?B?Z3ZvbG13ei91OWlySmtGcXRRNkQwNWRPRWRxckV1amVzY3IraHYxTDVnUTQ0?=
 =?utf-8?B?cjRkakl3dWtNRGphVUV3MDJlSFdoV1ZjWmh2Z01ZTXJkaXp6dU9EZHp6S0Vr?=
 =?utf-8?B?TzNxVXdaTFVvRXF0THZaWEo1US9MOWJHVkRBZElHdlZ1SkZpOWt4RWlNRWh5?=
 =?utf-8?B?cmtPLzJ0MmZtR3IxWS9vT1BadHQvT1c1MXpMR0IwZWovVUxCTXhuemhqbzBo?=
 =?utf-8?B?ZFNINllGem1ZaThsVFFkNElSZDIySWxVT04yb0htNTJsOFZvZUtSanNzRG82?=
 =?utf-8?B?UFFwdWEvSlRyNUpaVGdzbS94dkhvem1qRXdvSC9hdUpOQlFYOVgzaXZ4UkJC?=
 =?utf-8?B?c0l4b01KMXZKMUtEcnVuUHg0WmkyVEEvU3F1WVpRMXVTOWtMbURZc3JBSS8r?=
 =?utf-8?B?bnZrRGFsRXY3Z1dNRjZtSlB0N3RpVVZpSmtYUjZja3QzQnVZeUtWYlZremFJ?=
 =?utf-8?B?MFR4NE41TkU5QzNya2NRY3JBbnR1RmJQdzV5bVA2bnVpRmNuRXJ1WXNqSkNz?=
 =?utf-8?B?ZDlxR1ZqeVdoVEhXWnRHU20wYUxWSlQveDVFUGJhcTlERDNKclptUVY3Umps?=
 =?utf-8?Q?5I7IuzZmbAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFsWlhBMHliTDhPVngrQjNjRVlpK1l0ZHUyOVlrUk9pK0REYVFCTjVQMlVi?=
 =?utf-8?B?ZWVBV3RRQ3NXSEF3SkFvV3hJc0JoVGd4Si9kMHlNczh5d1hIM1VYODNURFpG?=
 =?utf-8?B?K3VKSW84L2NCVmtMSXkzNFBaVndpRHFVRU1IZzBSaXZzT24weFlLVk5JaEZQ?=
 =?utf-8?B?cU1xVFVzL1dDVnlSenlsWkxzdnNBYXpDWnkrNldZTmEzU0VWckpvUGFBa3ly?=
 =?utf-8?B?dEVxVGxpTzFoUmoxM2JqR2h1aWN2ckxUNXJiS1IwY3Q3Y0xCUkFpMGZJTnI1?=
 =?utf-8?B?RUhmYmxVRkRaajVRWExENS9BcnJHTTNGcUp5MENmaHlmZFViYmZsM2lhc3g5?=
 =?utf-8?B?ajI5RXZrRWd2MHpiZHcrUDIzODY0RzBQOXlxakpwZ2xZU1I2Wjk0YkNXTnky?=
 =?utf-8?B?NG1WT2xOVjYrMHkrdThZbC9VMmswaFgxeThmdzVFRUM2Tm5oczVyR0hxYk9Q?=
 =?utf-8?B?M0IrRlduQ0w4YzFpaFR1YVRONHMwem9IU0tTaENYRWZDM1oyMTFMb0VFYldl?=
 =?utf-8?B?NUdjTGZOaXFBRXY0czRTU3lQZTFMaThtajJNQzVqdnFkd0p0Tnp1WEhscTJv?=
 =?utf-8?B?VFFwUDdVdkVpTVZ6YTBmRzk2Qm5Qc29FNEd1K3EwNTIxV3dKY1NlV2NFREw2?=
 =?utf-8?B?QlhScGxoZ1lKSTRkcTZGUXpqM0pLTEZzaFhQUTZOemVGbGJ1aWJscUVaV0Nr?=
 =?utf-8?B?WmpYZ1NWWExVSHVRcTdKeUxjSEZBSEoxZG40TldNdFRIQjVLYm16WFk0WGhi?=
 =?utf-8?B?dCtFS24xQjhBTHJZNloxWHZRaHhRSVpGYURSSkpxay90R3dmblIveG9EVHBr?=
 =?utf-8?B?b0hOc2k5Zmwvb1B5djYwS1B4SmJ0dFRFVlJDNGZyczlhRlczSUdlUzZHd3hH?=
 =?utf-8?B?RzBOSkJJaDYvWHYyWnV0WHBWcUtqelJGTXN3SGp6RWl2VjEyOWVoMnJ6OWYw?=
 =?utf-8?B?Mk9JNzZuTUk5RjFPL2d5RXJCMVJ0RUxQUzR5WkllNDZpVHRLUHdNc2JubjZK?=
 =?utf-8?B?ZnlLeVdaRGE1QzFmdGZhRGlPcVNxYytrUHVCNFZjSzYyNUQzWGNtYXFpVzZt?=
 =?utf-8?B?MHJUcWVwVUpGdWlzeUdTUDBiaC9nRGRVVWNsQzBmUU5ieW5zM2lHS1J2aVRn?=
 =?utf-8?B?alJETFo3Ync4UVVVU2h3ZmFJaE5UQ014MzhaOUR6UENVS3VGTUR4VGVNdHVo?=
 =?utf-8?B?Z2xBcnp4R0hRNzVuSEZ1REtLTFh6K2VUK0owQXR1aWxTcFhDRUdTTXlDcFJO?=
 =?utf-8?B?b0N4cFFmQWZSem0ycXNsT3FHNk91d3pKQVpEZStLdElrR1lIK1d1NlRiNU5G?=
 =?utf-8?B?aUtrdFNJaGpIMlEvMjdDUGlYUGo2Nm1Vb0ptL0lBTEV1K0o5clcvcmFscW5K?=
 =?utf-8?B?WE0xYXNPOVNKUWxPVldaK0dDSlVhbUZ1S0NGUUV1M2J1dWtMZUMvcmRhL2Y1?=
 =?utf-8?B?dW51R3NxRjFSbngrazZWa0FQVk1FTmJ3ZmhSZThvVGt2ckRMMTQ2ZlMzWHVJ?=
 =?utf-8?B?SHZOSG1MUW96TXBCc3hheEVldmpuMkJ4YU1nU0lwc05IMVRGTjF1emI2RFdZ?=
 =?utf-8?B?L0MveDlocStacFhDM2hzQ2xrcFJaY3JPN0RHVkJ6K0hRNmt5enFmaXlSb09l?=
 =?utf-8?B?QzlVR0pUeGZsaHZ3a3czMXF5MEZvODZZVEJBeW9YL3dCTkRHc0o3V2MyVVhZ?=
 =?utf-8?B?aWd1VGp5dEFlWlVGTVVybEFpcWZ2dlFWRlNBeEY0bGkxdlB1bkplbTZLYTM4?=
 =?utf-8?B?L2xPMDhUVjh1RXVNOTVicDNORVFGU0V1bFVTdWVDVUlLaVZmeVVlU0NlMWhz?=
 =?utf-8?B?OE5mRkNBNVp5Nnd5bVJQZG9RM3RSc0h6L05scTFQcE1OSWFlNytuM0hybkF2?=
 =?utf-8?B?LzVNbGZkN1V5TmRLeWhPY1o1K3R1WXZDaDVnV2l2N3U2VGFIUDN6bmZlZDNB?=
 =?utf-8?B?bTN6ZmhvVlo2Z2ZsNUxLa3VtZmo4eUdZelZ3ZU5zUCtQaTdoaDRWWFJlZUFT?=
 =?utf-8?B?SzQrMzBxeEhRSmtOU1NlTm5TaXFNZjQxNGEvRkFKSjBZL1NhMlBNUzc5dG5R?=
 =?utf-8?B?R2J0RVJja1Y3QlNPVWt2ZXpZT3ZwY2hCazdkaEFrN3YvNnk0TFcrNWlKTUtS?=
 =?utf-8?Q?jyBglEucCcttVTBsYrPOe15JM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79fd799-61af-464d-06c6-08dde0c4de13
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:10:30.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8S4sZjLZbZTdFdTVKcqRebTKymKCO6OjWrNoCRIrA9D+N0Ms2IMDXJCOLqWh7tIbvpQArNYAHv0+3uSZ/jxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793

On 21-Aug-25 4:47 PM, Alok Rathore wrote:
> On 14/08/25 07:18PM, Bharata B Rao wrote:
>>
>> diff --git a/mm/Makefile b/mm/Makefile
>> index ef54aa615d9d..8799bd0c68ed 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
>> obj-$(CONFIG_EXECMEM) += execmem.o
>> obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
>> obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
>> +obj-$(CONFIG_PGHOT) += kpromoted.o
> 
> Looks like by mistake used older file name. It should be pghot.o
> 
> Can you please provide base commit. Unable to apply patch cleanly using b4 utility.

Right, sorry about this. The base commit is 8742b2d8935f476449ef37e263bc4da3295c7b58

The updated patchset is available from
https://github.com/AMDESE/linux-mm/tree/bharata/kpromoted-rfcv1

Regards,
Bharata.

