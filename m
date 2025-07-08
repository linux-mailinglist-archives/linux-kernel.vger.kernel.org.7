Return-Path: <linux-kernel+bounces-720874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91207AFC18E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810AE17E7E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F7242D62;
	Tue,  8 Jul 2025 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqskT7Ku"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D390262FFE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751946233; cv=fail; b=TSDJ9eyiUO4ZMH+XY3CQ1YiV1eonPK1v3vPuj4bRNXTty+uttOGans9eCuRHVBOv5h6KgrOE8hJlwI/gxdjklUX03kcOj54vXY9K3xzK6JVWDb77P72pMkUYtjPIpAZa7L0I3aaujrje6WdLdEtLBaowC/M01r2/2tlB4XAcBvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751946233; c=relaxed/simple;
	bh=loHZrsZyC+VBdCxngKhGivCqKgEGKbUM/03QtLKEK4Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tlv8Qok9AUlbsuWHfWDp1sYccX4IIBNDftvcNPwxKpJIYWLKoR4bi1Yih9NdbDgSkppcR1RMpembAU0Cmio0FiBop/PQuvmqIjGmuDGKEdUje60gIRK207/70MQK+heGHT3V2hLz8fgB2G91D0jTPIJvXhevRacRtchczsDP3+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqskT7Ku; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJVtPGLvqNHOllaGaVegx2yEmDt2O8rWDXmrNni4bZi583tFldvYiP8Op7pyhICBFsRCRtLYsRZjiDEMmttNpXqYSURCU1BtouaJXMHAMupzLTcsWBABo6HGZEfPNZp/A75nq/5PkjDddZxu8r8OmYku6D0AOkIncGPReZhWvGfFZpYRtqSEmP0tIbmyKZUdiyWWiRgFM9iLYU934YRv3mfsY4VImlEaVaFZkOeudlULofY5XrXqwRVXl2Srdv/DzIj6JQDgxbb5Apoif+tD6/BD+8Hm1WXdmBRmPvEcVUT3bJnAryjE+tduu5p+ox0VnyxCYwTBZU7kY5RZQ6XE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlvLJEsi6VZvbueT/YvmvMhFBcO8RdRBFPhkVD1V1YI=;
 b=aIiiiXXxanKyPr7hyaxjgcJ9lDcfcF4Ly0hJuJxkd776WGmX9exn05iLrgM76ffV57VCxqIKmvLxxqx0W2AfqVUM1uasDnDGw30XonblqqKRu40UB/GEfdG8QO9e9GXJsIXoTbiVedgkbnGZMb0vF1C1Al2MfbFw08falim63nEORnIVKBqxgVuaGlTpE58yGuv5fL4mu9GcHSSEEwk54AM2xi+vIyOvp8RZwDAb1ugfMsBAyI6PlIat0knTd5dx9IiG5H7LSOAOez+E5g14kSeoeAkvB1q/DI6Bo31WuucG+EL936tB8e30X22zKuRhDsmr5ES6UIzR6DXFUl0LMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlvLJEsi6VZvbueT/YvmvMhFBcO8RdRBFPhkVD1V1YI=;
 b=uqskT7Kue8MHQMK3pvTLrWjQyx4r5wS9ytPK5vz0HXKFibMz/ZTG/ghcmdWv5MmhQwD6SFJT7XT9ASd+UD39Ukq7B3H6kam2dmY3xjU5n20LjOVGOYB+L9aZ5NWUdKhVa0mOkJacVwvxv8n4VEyrJHqLxkdZV0alfmQ9tAJ4pko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 03:43:49 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 03:43:49 +0000
Message-ID: <9afdbe8c-759b-48e4-9c64-099cf5b2d3cd@amd.com>
Date: Tue, 8 Jul 2025 09:13:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm: kmigrated - Async kernel migration thread
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Jonathan.Cameron@huawei.com, dave.hansen@intel.com, gourry@gourry.net,
 hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com,
 peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
 rientjes@google.com, sj@kernel.org, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com,
 akpm@linux-foundation.org, david@redhat.com, kernel_team@skhynix.com
References: <20250616133931.206626-1-bharata@amd.com>
 <20250616133931.206626-4-bharata@amd.com>
 <20250707093631.GA18924@system.software.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20250707093631.GA18924@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: af07efc0-165d-4753-fd70-08ddbdd1a628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bitJRTBGU2djQ21xWUxQSlhaWUlJVG5xK0I3K1Q0VnZjcXBmaldJWG1tQWtV?=
 =?utf-8?B?NFhPbVRnTnZKWEt4eU9uTFJablhWTkZrV0hNTU1nWWF2Mnc0TlEzekRmVFdR?=
 =?utf-8?B?eUZXODRyMFdkL2c4N3Rnc1Vrek9HMUV5c1J1dTZZUUdyR2F0SEo0RzNkQnBz?=
 =?utf-8?B?dEZkSU9GTVJWbkhtVU51K3RtOWhYbyt2UVhQdGVpZjhvWWp4ZlJIZVFZNkJo?=
 =?utf-8?B?K3BDY2dLZ0xqc0tZem1zRWhWOXlwMGszN2J0WGhmaFkwT3FqOEEwSmwwTno3?=
 =?utf-8?B?SmR0STMxUlJMV2hQNm9sZ0xDVzkrMUxnOHAzcnBvQTNCMWN2SlkvRi9Sczgr?=
 =?utf-8?B?TmFWaXFqOWN5clRIRFBIMThhOUxkMWN4TjlqcXIrMllsRnMrVmNFYUM5emcw?=
 =?utf-8?B?RVM2cktDZE5ndVAxeVozdGNiOEY5b0FJZy9wc2dWSEZqNmkxTlpNZTF3STJC?=
 =?utf-8?B?ZVhvTlg1VEZRdkZleFZtMTNBVzk2VllpQkdNUFp3ZU1uREVQYzd6SHAyZUlX?=
 =?utf-8?B?d0hLS1IyaEwxZVQ5SnhkTmp1aGVnMXhqWngzQ3lwR2xjanprcUh6d3dlU0c4?=
 =?utf-8?B?THozM2hTSWJ3QjQ3VW5nakxEbFJwOE9hSmx0ZDQ2UHlvSFM1VmRaOHVCRGF4?=
 =?utf-8?B?RVM0SnBiQTNtc0FWMlpZcTNRSTFtOW9BK3VrWTlJdnByZ3Qrd2xJd3htOEtp?=
 =?utf-8?B?TDk5YnJKcWhwdS9tQWhsbk1iRFl3dU90OHo3SHl2QUZqNmtVNG9LbS9RQVNx?=
 =?utf-8?B?K1RKd2hJQVN0ZERKZEVNeDJJbjJGR1QySFNJaitkR2pYRnlraUlBSXFlT1pu?=
 =?utf-8?B?VG9RdnJPOUM2UWk0QzB2ZEYrWlZZaTJidnQyUDFuQzlWM3RMY0RpTXJsdmFH?=
 =?utf-8?B?dmZNeFg0U2VHelZrY25oK29SMk9LZTlJR01tdGhGOHVlODdkci83OFByYTVH?=
 =?utf-8?B?bHZjQ2ZyN2c5S3BuQkF0M3NwTk5PU2xWTzA2cDc4NjdXeFltNzZISHVibFNo?=
 =?utf-8?B?SFZBMTVGem5QMEpoZ3ZLVmQxL1J0YXB6bW4vZlZlbE51bW1GVWp1QXJLZGZv?=
 =?utf-8?B?VFYzTHpUNjRCcm1HTGpydUVBZG9hWm11U2Z0RXlNTE41MUp3ZDNyV0RKSnJZ?=
 =?utf-8?B?QlNaKyt2TFNsbUM1RFUwNk1HRDZwK2dhZ0RKN2VybkYxazJtN0w1cTZzWXV3?=
 =?utf-8?B?RXBLUm1vNS9GdEd4N3BhbHNDSHc2K29XZ1kwNG1GTnBHSnlSTG1EL1E0NG8z?=
 =?utf-8?B?Mi9uMW8zNWtmT1N1WmpoZGZLTGtGT1ROSGRyQ2c3U25xSllNVWJQMkhXTDVq?=
 =?utf-8?B?TWQwNmhWMnpvTGRwWEI0ZHc0Qi8rQUVkck9LS2E0U20xMUxRcFo1QnVLcFlZ?=
 =?utf-8?B?WDNNYVBjaVhiM1huL04zblZZbGlZZXJKV1pQdlpCb3czVkQ1WkJRVS8zNm9W?=
 =?utf-8?B?ZTFPbXY0alZsZmE0L0JBdndsU1BxWWw2NDBRNFRPZkxldmdSUG9xYmtaYjd3?=
 =?utf-8?B?SFQzYlNDMDhGUGRDdXU2dkNsU3FTZkxXVDI4bDI1R1V6dFpkTGppNjZnYVhy?=
 =?utf-8?B?WHZrajJzYjhVRFYzb1NsUTk0bUYvZkMvWi96S0gwRUpSTVZScjV3a0x5M3B5?=
 =?utf-8?B?UUt3eUgwQ014aWxmZDJCU0MrcVVpWkpBdlpJb1ZOR3dWVVhIODFXZjlqaE9h?=
 =?utf-8?B?OG8zT3REWTZ2NmhYdkR4b1pGWVovYm14VnRLaysreEdwa3Z0bng0QkVkek8y?=
 =?utf-8?B?QWkyc2NRSEdXeUQzbno3NFZaN3kyODZWYXFkRld0MjNiZVRQMjAvNUxqcFZp?=
 =?utf-8?B?dFpISWlhaTk4NWNxaldqbThJRCs2ZTF2U09aYUh2Mm9kNFRGWkcxUE9rbGdn?=
 =?utf-8?B?MXpRZFVnN2loNWUrMS81MnVXcmRsNy9FdmFEeUlaSGNiZ1ZOSkppdW9GOGVF?=
 =?utf-8?Q?XNSjIEAkDfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUlGYVkzamlUZzQ4bjlaMDZGbS9UQ0NYSGV5d0tUaStTcEdiN3FnbjUweFRO?=
 =?utf-8?B?cXB0K2d5dUZQQUVTNWY5WitXSGw1TElnK3FkSDNYaXdHYmJHV0YzTG9jSW1L?=
 =?utf-8?B?RFhVNzJqM1FtTENRbnhvU1JBSzNuOERHWVFxQzUyWmk4WHZINXJqRFZ1eTdQ?=
 =?utf-8?B?TFRnOXBQdmduamVDT2RzblVwZzJSQ2lPQ2VobTE1Szd1dmFDakRvUTNIN01a?=
 =?utf-8?B?eGwrVE5HWE5ta1pocmhZblVtd1d3WXRpYnpSWUFHNkhHVjlzbkcwSllaMWlk?=
 =?utf-8?B?M2hPYW9TOWRqSWQvVFBmY1BZTHRtZVo0SFdHbDRrRm95T3JXNFJORVd6R2Uy?=
 =?utf-8?B?NG5odG5LVEVBTXhPc2VPUTkzVk5Kd216dmp6S3dlQnRXQlRPcjQ4U2JLeEdv?=
 =?utf-8?B?RWdHT0JGVE03dTd0MnZaUVM1M0YwWi9heU9mSHVRWXF2QVF5YlMwL08rSFhQ?=
 =?utf-8?B?U3dLWVZFVUl4SHhLZUVBMFpiMlYyQnBZM2htMkdyUEFuMlhzUlFMV2RDYlps?=
 =?utf-8?B?dWptd29LMjhZVWh5ckovc3NkS1FJWGo2YjErbVRkZ1A0NWpRK0VFZ20vdVJ0?=
 =?utf-8?B?OFRhUTBDeEhuWUZCSDNOdFRHOUQvUEhtbW1WYmp3TWo4cm1naE1rOWtSbGVo?=
 =?utf-8?B?SFB0aFpCRGd1NzNyWU9ROUlZRnBHQWZzVStOc3lCaXlyM1JtcDhoMG83NGlr?=
 =?utf-8?B?VjNxSWdsSkFQQzQzS25WQVlDNzFFMWZERXdjZng5bnZyc3NGYnNVZWFQeWtj?=
 =?utf-8?B?SjNEa29zbmdnNjhxelozUXp0cm9LaERyQWY5bE1td1ZXVFpXRkxOV1pHYkhK?=
 =?utf-8?B?K3B3RThiWFlTSDByaHlYK2FzNzJxYm5qeCs0ZmRDemJyT2hXLy8ybkpsTCtC?=
 =?utf-8?B?UlVDd1Y4L1ZrRTUvZTlUenRTT3JqMzhweVZod0o1UFhrSStFNHBTU1JuNm9P?=
 =?utf-8?B?UlZZN1B0SmhmLzlXN1NhdmEvdTY4ZjlGSldkQnYyeVJjMDRod0FpVENlblRu?=
 =?utf-8?B?SExMZVFubzd5SWNtYk84Tk9Cc0JubXNndEtmZ2FsejljdmtFNDQrYmdSUWxs?=
 =?utf-8?B?MnNOeUxNazVZSGR1aGhwVUk1aXdvTzJ4REFyM3Y4M1c5OXJ6T3RRWFRQMFQv?=
 =?utf-8?B?eUswbkpZOHpIckszc1l0bldiYzNoTzFnL3Z6bzdpeGRIb2wrZDNEU08xMmdy?=
 =?utf-8?B?SHVXYW9JUzU0MGdMeWgyNE83ZkFSTnFVcWdJdUxsWEI4MFpHZnJKUHI2d0xh?=
 =?utf-8?B?K1d3dUVzZmkxWTAySlF1TXdkWmpJRHhKUmhaVDNIU3k5VG1WTTRrRU9hTlZZ?=
 =?utf-8?B?ak9OSHBYQnAxay9qV2dIT2NqMEtnOHNYUHJ6SGlYcHVabU0rWFRDZlU2aFpK?=
 =?utf-8?B?R2VvS0djTHVuQk1GVzR3OENpNlM1SXVGbW5ldC9WN0pyRVJKb1NvOFQvN1l0?=
 =?utf-8?B?TlA1TFVROXpqaTVraUcxR0xISlR0VXkyc0w5Q3lINUpNR1UvbUo5RTJOc3JG?=
 =?utf-8?B?WGhkaStJeXR1SzkwQklCd1MzRkw4ODJKTjdmcWRIVVJCcktaZUZRTTg2b2Nw?=
 =?utf-8?B?aURucXhGcFdxeHNkTktSNE90WXNLVENqZTlEY25Rc2R6aGVBWUFEeUF6Z3lU?=
 =?utf-8?B?anNqNjc1aThrOUl5a3lnM3pldk1rWkF2ZWlWKysrRW5TcDQrRDdROTRFWkpZ?=
 =?utf-8?B?SzA3Qjh5S1ZMYWZYRGtpMzhBcEROMkJENGJVVEZHYjF3U2RuaHRncUlVSlc1?=
 =?utf-8?B?Uk12Ylo1SC8xMENuWGFHQ1BmcCtDN3RmOE5ucURaS3pzbnJrVURVQndHUXhS?=
 =?utf-8?B?dzk5d3dtYmZZTjBZOWtueWZvaHFBQ0VTaTRyNEkzMDhKUyt3a3ZUNU9vQm5K?=
 =?utf-8?B?ZDVyNmUvT2cxMU4xaXpRbE9MSG9hdXhrU1hmSGJEYW4zalIzbzB5eW1PSW9E?=
 =?utf-8?B?L1p5ODFsbUxmdmt4Ti9tOG50L1l1M2ZiTHlHOGE0OG5RTGRSVlJOVGtHelUw?=
 =?utf-8?B?ZU9YQmZRQ2t0K0x5Ulg4S0l4ZGNqWXdxdUZuZktDbU1ZNFVhdGdZMkVDQnN0?=
 =?utf-8?B?dkR4djI3aXg0UGxvcVE5emRtY0xpSHhTWGRKVndkWVdmelZiYXIxaUVKTXgx?=
 =?utf-8?Q?0DGG7ZgDJrkIIJ/GyaaUDPSAW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af07efc0-165d-4753-fd70-08ddbdd1a628
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 03:43:49.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvrpVGEZEXo3Srqfrmvtz7Dz3JgBeeQXFSnF0AmhqWO+cN+yTffKtSVWpSYKwOSAs4m+siON4KZ8/VvAchIV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

On 07-Jul-25 3:06 PM, Byungchul Park wrote:
> On Mon, Jun 16, 2025 at 07:09:30PM +0530, Bharata B Rao wrote:
>> +
>> +/*
>> + * Walks the PFNs of the zone, isolates and migrates them in batches.
>> + */
>> +static void kmigrated_walk_zone(unsigned long start_pfn, unsigned long end_pfn,
>> +                               int src_nid)
>> +{
>> +       int nid, cur_nid = NUMA_NO_NODE;
>> +       LIST_HEAD(migrate_list);
>> +       int batch_count = 0;
>> +       struct folio *folio;
>> +       struct page *page;
>> +       unsigned long pfn;
>> +
>> +       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 
> Hi,
> 
> Is it feasible to scan all the pages in each zone?  I think we should
> figure out a better way so as to reduce CPU time for this purpose.

I incorporated a per-zone indicator to inform kmigrated if it needs to
skip the whole zone when scanning and look at only those zones which
have migrate-ready pages.

CPU time spent is one aspect, but the other aspect I have observed is
the delay in identifying migrate-ready pages depending on where they
exist in the zone. I have been seeing both best case and worst case
behaviors due to which the number of pages migrated for a given workload
can vary based on the given run.

Hence scanning all pages without additional smarts to quickly arrive
the pages of interest may not be ideal. I am working on approaches
to improve this situation.

> 
> Besides the opinion above, I was thinking to design and implement a
> kthread for memory placement between different tiers - I already named
> it e.g. kmplaced, rather than relying on kswapd and hinting fault, lol ;)
> 
> Now that you've started, I'd like to think about it together and improve
> it so that it works better.  Please cc me from the next spin.

Sure, will do from next post.

Regards,
Bharata.

