Return-Path: <linux-kernel+bounces-759401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6496B1DD0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B69188CE6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903902737EF;
	Thu,  7 Aug 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSOqNtNn"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D82737E2;
	Thu,  7 Aug 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591393; cv=fail; b=HwJFh4O9m8vH6uwHFhqGf28Le7MzmvlpcAVEMtYDXwHDsuj/1ce+ThaqTbjuTgXYJeusvsD1DHFK4b+QqT7Gp4kdZTGPQH21LIZMzi4KE6QUnIb5LKY6AYVRkpEgCuQa1RQlDJBdzOHo0xbY7MxGbGchcNx7/NreHUkIsO+FxtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591393; c=relaxed/simple;
	bh=Y4fY/ghLYzs89GjH+P/sFAh5zxLp/vGdkGaZHn8sKgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dCGrjXe9XaO3YtLOqqBwNR6aIfSI9obdjpOfsCuJw0Ve9DqS1NIRn+ACN2Zg+Tn3Q4+TJiFs9+LFKoUvusi7B+FWj9xcSLLW0qmxVWdVPIvY1iLcs+zW8ACfYV/7KPNgjbd/hAS/A4H1ORf3xJS19Iv9/Lcx13MdyEchDbxSYU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSOqNtNn; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX8nw3eqJJxIc0p6L03LqkDl9o5yVx2C8CCAGxu9eWRymQkNmRWX/pAmKruwemNf7EZA2hh54Okx3BhpEDwucEkzOEjp46TOlkWiut9Dmu0wayXNYdx74wehwHApWm/KrsR53ZQ/mCi6WquGdatEwo+8fLwwCQwYO4nb063Ef3SQslQjqhowYX9hkUvH3poWSkJEALQoPyfsshvkR6ch+sCdyFTOBJ6xdx/okgfAk+2SurUK/IGVMVvjXncmAeP+1wrlpiEsVPVhAiJDw0DGMdHnT8CWUwnaj3dG+AlihY7Tf3dI3oDUSMDr2psYzQ6/SbJwXF7f9Y0PwviwSclg5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07RUgXOAap0CB0fsqi8jq/YJ2zsMofQX1GVx5l4otrQ=;
 b=jNqZn7bkbjPyCZjz+xsXZhhZOHPU0HAuZ4ZnFhoTWB2hnqCetJuUJtAr5XykD9hRPOvwfKmwMx++zwncwbk+JB3f6e1eWoKPJswHl9NA5jUN2+WlcLGs7fJRbc2fWPvKz4y8BUiInqn5lSeO31laj703KmjHVqpbPjQ2gFnXg4sPXGSGMaW6Eti4Ori3KG0NyFHjOlb9kOFCSGiAyn3g5QmMINVHHMIUcN+xggoO4F8PBYOoQ4pKHLqNxhmlLzaunrHGI6Km4JrQk0jnXM40cePP+on/KQdNiABHVMe+hIzmqx+PruM5Nt9XkVOJiThiFPPrWahCY6uBuGJJ7KHAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07RUgXOAap0CB0fsqi8jq/YJ2zsMofQX1GVx5l4otrQ=;
 b=NSOqNtNnJIdg5ox+Kzu+JQ4YfpKFswQqjUotwAlAzKWp+XmEw2/25Y9scNaP+KSyu79C+fVDTw/YXDmwK+3HR7lT8x9Voa96KsZQt6DJpYSCrcJAzIovgST4unOq5Lga9eWlxqRzethiAh5t3mWCmIlcdVaeEOuum0N2ZErzl4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW4PR12MB6950.namprd12.prod.outlook.com
 (2603:10b6:303:207::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 7 Aug
 2025 18:29:48 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 7 Aug 2025
 18:29:47 +0000
Message-ID: <aaab030c-29ca-4aae-b821-dd8fbb2fe5a8@amd.com>
Date: Thu, 7 Aug 2025 13:29:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 17/34] fs/resctrl: Add the functionality to assign MBM
 events
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <09e6eb24212047908127b8b9fbd1673d6892cad2.1753467772.git.babu.moger@amd.com>
 <0b906083-8579-48e3-9f73-4d80c327a30b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0b906083-8579-48e3-9f73-4d80c327a30b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:5:177::36) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e68368a-e7f7-4d4b-d8f8-08ddd5e06376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anlGcm5lNnJHMmdGK08zdzZVVGpjNjdHVG9QY0hGZnRZVzM0c2NHTU1NTW5E?=
 =?utf-8?B?N3BTdklZYlVZY3ZiQmN4QTJjeHJsdjdzM3JMYWNXbllVOTBxQVZMYW5KQ3BS?=
 =?utf-8?B?VmlyNU54NkVrcllCcGxOSFFqTUlCZm5pK0FnMEd1ellaWnpnbWJKRENLeC9N?=
 =?utf-8?B?cFV2a2RUMWVtMDVRbU1jMGJRREdNN1ZUZFg5WEZWTzNxM1E3eXZ3SGpyellM?=
 =?utf-8?B?NTI4QUhscU1sWGsyN2prQysvaC9yZkRjOVlnVUJRREdOR0g2S3dRZEovMStP?=
 =?utf-8?B?ekhXbE5ucW9vMERsVktpTWZQdXNJdXJNQVcrS2lJRVhNeFFMSHJKK1BWM0pS?=
 =?utf-8?B?c0svcUNIbjhWTDA4Q0diSGMrdndKZ2N0MzRFZUg1OWU4VXI4bU54cnBObWd3?=
 =?utf-8?B?WHFtRGprdm5vRGQ2T1gwR1lyNnVQTHVyVjBHenRoVnhkNTJXbDRscWM2RUNH?=
 =?utf-8?B?NXNpejJzUEp0aDdHejdPOFNQQkord3ZOQXBuK0VjTVY4TkdTLzhaZWVYREp0?=
 =?utf-8?B?T1pMRkZQYllpUXBmM3BhOS84VVoweHpuRkt5S3A3ZXdaMWhoejR4NUIyanBy?=
 =?utf-8?B?dG9pdUtpVHVzWUd5ditNOWNXN2MzWno5S29LYnZ0aCs5cTJCZm8wWUpscjEx?=
 =?utf-8?B?VmtpMkdvUkE2Mm1Xck1aWC8zaElMZnZYRTNVVENmY1FrTmpPWmVzK1dWdHpC?=
 =?utf-8?B?MDFDQ3UvL3MzdkE3L2szZ1F1a3BWdEdOeS95aDF2MFpraDNrZEZkMjNGWWMy?=
 =?utf-8?B?Y09IT3BIK2dSQlBKY2I2NFRCcGhHS0VkSzQ5ZjBDRnNUUFNZT1FISFRIN2dH?=
 =?utf-8?B?QlhDOHpyYzhQSlFFdlI3MEVSM1BrNG4yN3Bsd3Q4ZDkyeVRvdzVRU3Jna2ph?=
 =?utf-8?B?QjFpR1JoSGFTOEZiWEg5T1ZxM1MxOHQ0V0tXNGh2Z2hmcnl1eFFTZDYxNjdP?=
 =?utf-8?B?QmhleVA5ZVArc1RkU0hQNlZaMWVmSEpQYmt1NXoyZG1aVXF0TTNKVUhKVVdP?=
 =?utf-8?B?b2VxUW5vWUJMR0NOVVhjTTdOZ1k2cHcrV2wrOGlFTXAyU2QyZmY0aG05WWVu?=
 =?utf-8?B?R3VIQ3hMVGMzckQybllLU1gxODA4NjRjZDltcGM1cXNkSlgxa3laK3FRaXlK?=
 =?utf-8?B?N0srcm95d051c2loQ3NuNVJjRU9HOHh0RW5qOUF4QklwZFYrM1kvUCsvRlR3?=
 =?utf-8?B?QlowS2hsTTRlcHNSTXgrWDhoZDFLYkhtU2hjckErRXRzenJIUFBOeVRNUCtT?=
 =?utf-8?B?SDAzUWtiTVpveXU3UE5QcHU5bldEREswQlExWGNVa251Y1RmSDYrbjZXOHpS?=
 =?utf-8?B?eTJmbVhEeWU5UloySXRCMnk2Y2RITHdwWnFUaXBTWmJHYjR0V3VTQ3ZsVzdv?=
 =?utf-8?B?YWREd2UwMHNjUUlKTnluRFFxdEwzRDZycmhxMjVtV3NaNDZndkI4aEtsZzgz?=
 =?utf-8?B?Q0h4ZFVvMW0wZHBDc2R1YVBmcjhLcmd5RXBPT1FVQ01WamZwdGRYNUtUbkNu?=
 =?utf-8?B?T05vTDNPUnlTRXI2M1hTOUFDZnczSWJOQlpFeVRmeEVVWThmOXFZcktvN1Nm?=
 =?utf-8?B?RTNlUXNWNnBPaCtSby9zUnczUlVRMEM3M0lydUxFdzBxQWxrNkI3QXpaWE4x?=
 =?utf-8?B?K3E5RkhjTzNpb2g0RVRieEZzZ2FWbEpiWG0zS0V6akVCcEJxbGh6Sng0MEh0?=
 =?utf-8?B?ZlNnbmpLRWZwbEhBZXRwNFNrNGhnOEVMRTRyWnJmSitwSFpYaTdKQTVQdWww?=
 =?utf-8?B?dlFlUkpHeEk0cGRmSU1yRzZ5cyticUJ2NEhHdjRIZmtJclhJeCtjYTRYZmVm?=
 =?utf-8?B?NU5QSmd2cGE5TDJISFFuZU93d29RWmdUazhuUXJPNUpjdkltRTNpRXUrT2h1?=
 =?utf-8?B?bmJzL0RycFVYQ2pnOWl0aHJvZlRVZE5ENTRUZmpDcXFDNm5SdnpKKzdkc045?=
 =?utf-8?Q?Sa1L8oA2nuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUIrckxMRUUraERGM09FY2czSmNMbEl2N3ZIanhYc2pnUWVwT0tOcGtWdUNW?=
 =?utf-8?B?WDQwcG9CL2JNQ20yc3BhalNRWTFDSTAyQnA2NzBBYWVhMUFCV25oelQ4RnFJ?=
 =?utf-8?B?SGN0YmdBMWlVdG1PTWRsUnZxZ2xQelJ4bVVKZy9SdXpZRGxjc2xLMWkxS21q?=
 =?utf-8?B?TFk3bnpaL3gwSjJtbUtmeGFTV0JOTVBhdzJjRXZFYTBxR3ZWM1R4V3Y5OXFD?=
 =?utf-8?B?Vng0blgzMWx2WGhTQWQ0WEpoRGtZd1pKUnliK2ZRN2dRL3Vqaks3SmtDZStk?=
 =?utf-8?B?WnVUU3dwbGhENURNd3ZPa2piUzE2bTZCZkFNaU5keXFOS0d3d0lid013K1lv?=
 =?utf-8?B?L3B2eG5tOGlCTUpSYzdGTmJzVllVVXpLc0JYNmFDVHY2NmQrRklpZ0xLMXNY?=
 =?utf-8?B?dEZPazIzb0RXZEtqRzlpOWZZNm12Z2hnZ2hsRDZNc3kxOGVueHdLZjc4NE9U?=
 =?utf-8?B?Q2lSN1lkcDBwUkx4U1djNVpVT2lDRnRGMW1zRGRpRHRtR1lIWXZsODZIVjZa?=
 =?utf-8?B?L0dPVWpMcFJWaWNVK0FGZEFkbW5lMklOZlM3Zm41VFNQY0pXY0RxUDgxbVY4?=
 =?utf-8?B?c1NQU282ZkJYRk50UGNDeEdzd2M5ZUFRM2RIenoyaVYxb2hGQVJocHdoY253?=
 =?utf-8?B?aThpV0RacGg2UUJEZzBKNnhURllPWEtwRno0VGkrdTFFZ2JCRUVDY000Zzkz?=
 =?utf-8?B?RzZseWZiQUVNdjgvWlpJaGZ5ajBXV1kwT1ZIRzliczM5d3VaVTJYaUtOT1dm?=
 =?utf-8?B?ZDFaLzJhSmNKM0NmQkdSalRhNTFpSVcyZ2diM2RuN0xpelMzQ3VZRnFCM0Zo?=
 =?utf-8?B?L0xjQm5OV2JoejdQbXZvMEl1cWJQQmxqdnM4Zy9zdUR4WVhWRlJJZVBuWVBG?=
 =?utf-8?B?KzVhZFo5NEJYbU9xalYyL2xycmNRNHBqcmlEbFlpdlV3TUlFVGFxWGNxMmxS?=
 =?utf-8?B?YWVTM25rbTdCWnpXTmQ3OUtta0hGT2c3NE5JR1lCNVIrRTR2S3FXTjhGMzJj?=
 =?utf-8?B?R2U4RkxEa1NXSSsxdTU4RnZyVHN2bnJGRkxCelZ6TXFieFRKdzFwTCtvREZm?=
 =?utf-8?B?eGFzUjVENmp1Zys3VmlkN1JBV2FkUWxrR1BjQ2NCNFMxR2prZzJPM3JhOGI3?=
 =?utf-8?B?ZmJ6eEF5dGNtaEEzS3k0TnhHQjhxK1RRb2piaGtxNXVhemp4MWcyd3lGK3RM?=
 =?utf-8?B?ZU1UYmgva09YN3JDYXc5MHVFZGpEZ09lVllsdHljSExTSTdsZVZVeldjOS92?=
 =?utf-8?B?L1E0aUw4anJ2Q1JZMG9zZ0UyUDNSOUFTeGF4aVcvUXZuMVFKaC84cEVOenZw?=
 =?utf-8?B?QVhFYk1COW53aDlhYnh6KzF3Kzc5YStHbkdVZ0VValpESHpkalpVeHZ4eXcy?=
 =?utf-8?B?ZE0wTSszMDBDQWF0ZnR5YjY3Z3RRZTR6Lzh2U2Q2UngyZDFvYk5DVUpxeWRE?=
 =?utf-8?B?L3ZrZkRFbzZPNlQ1NTNJTG11bXFlQkZGWGR2OUw5MU8vRFRiQWp0Q3pFWldw?=
 =?utf-8?B?QTF6M0dWb01ZUkZha0w2VVVjQndXcEdSLytwd3ZiYlpZTXFLd1F4emxqcnRl?=
 =?utf-8?B?Q3dybVJBNngvUEpEdG05TjFsTUhiQ0JIRHFQcEdNdldPUjhndGM1c0hoVmZk?=
 =?utf-8?B?ZlEzc1k2UlhERGtLbVo5Ym56ZU5xVHdxcVNua1EwMDVNSEF6MHlNa1dMZTBa?=
 =?utf-8?B?MGZsRzA2aG5XSzdsS1ZvZjZwb1NMVjJTQnJJdisxM2tQYUhQcVRxRlN5NTI4?=
 =?utf-8?B?V0g0R0M4d1NHakg1NXpRNzlMNkhaajhRVHdaNlBGWmtrTG1ETWt5U2RnSlVy?=
 =?utf-8?B?a1l6S2x6a2ZHbWtCQU92YTRNZjcvSnlvUGdmV09lcDhKRVhLc09kZXRHK1l4?=
 =?utf-8?B?djFSNEEzZ0ZTVDlzbm1ndlREMkR2Q1g5R2k0cENHc0NpL3VRT0k1WlczMWJl?=
 =?utf-8?B?SXBFQzMxMXBpeFpGM2NocmdGb2Q1cURQenNTcVpYemFDU01sM2haMXk2ZmxN?=
 =?utf-8?B?L0pNNFVnMjhoUkNoaFB6QitqOHN4ZWpTeFlzeTJKT3ZkbUZ5VFU5N1MrZk9y?=
 =?utf-8?B?L2t0OUxhSGgrNkhraEkzMGtyYVp6TWFBdEordEhaVzl2UitmSUpFb3cwTzVU?=
 =?utf-8?Q?g2+Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e68368a-e7f7-4d4b-d8f8-08ddd5e06376
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:29:47.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecg8TK9r6v13kBEyyRNKH4sfxrBdExVW/Z6VAWRVx14+sUAlC/eaojkoSRhp/fqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

Hi Reinette,

On 7/30/25 14:52, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
>> number of counters that can be assigned to RMID, event pairs and monitor
>> bandwidth usage as long as it is assigned.
>>
>> Add the functionality to allocate and assign a counter to an RMID, event
>> pair in the domain.
>>
>> If all the counters are in use, kernel will log the error message
> 
> I think dropping "kernel will" will help the text to be imperative.
> 
>> "Failed to allocate counter for <event> in domain <id>" in
>> /sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.
> 
> "when a new assignment is requested" can be dropped. Or alternatively:
> 	Log the error message "Failed to allocate counter for <event> in domain
> 	<id>" in /sys/fs/resctrl/info/last_cmd_status if all the counters
> 	are in use.
> 

Sure. will do.

>> Exit on the first failure when assigning counters across all the domains.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  fs/resctrl/internal.h |   3 +
>>  fs/resctrl/monitor.c  | 130 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 133 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index db3a0f12ad77..419423bdabdc 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -387,6 +387,9 @@ bool closid_allocated(unsigned int closid);
>>  
>>  int resctrl_find_cleanest_closid(void);
>>  
>> +int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>> +			       struct mon_evt *mevt);
>> +
> 
> This internal.h change does not look necessary? Looking ahead this is because 
> rdtgroup.c:rdtgroup_assign_cntrs() needs it, but rdtgroup_assign_cntrs()
> also belongs in monitor.c, no? 

Yes. Brought rdtgroup_assign_cntrs() in this patch for completeness and
moved everything into monitor.c.

> 
>>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>>  
> 
> ...
> 
>> +/*
>> + * rdtgroup_alloc_assign_cntr() - Allocate a counter ID and assign it to the event
>> + * pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
>> + *
>> + * Return:
>> + * 0 on success, < 0 on failure.
>> + */
>> +static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +				      struct rdtgroup *rdtgrp, struct mon_evt *mevt)
>> +{
>> +	int cntr_id;
>> +
>> +	/* No action required if the counter is assigned already. */
>> +	cntr_id = mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
>> +	if (cntr_id >= 0)
>> +		return 0;
>> +
>> +	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, mevt->evtid);
>> +	if (cntr_id <  0) {
> 
> Extra space above.

Sure.

> 
>> +		rdt_last_cmd_printf("Failed to allocate counter for %s in domain %d\n",
>> +				    mevt->name, d->hdr.id);
>> +		return cntr_id;
>> +	}
>> +
>> +	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, cntr_id, true);
>> +
>> +	return 0;
>> +}
>> +
> 
> Reinette
> 

-- 
Thanks
Babu Moger


