Return-Path: <linux-kernel+bounces-765471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F0B2381D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3E71B6801D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83F2C21F7;
	Tue, 12 Aug 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3JunAW+h"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546A305E2D;
	Tue, 12 Aug 2025 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026337; cv=fail; b=Iznk0WOoKz6iHj7EsDI3tZdqXOJM0vMzm598AXRNZaLoEUKY9+JGva0qrLYJVHpBXSRQkIbygDWhHehyVzrDy9HyJPzmNKgUktUYfoBopXXmJaUi9r5u599zhW/Dt2hXx4ZwMeaZgZmxkPrm7U2srIKJMXxX7OoPqjivi22KK3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026337; c=relaxed/simple;
	bh=hVNzx9AW41s78oSGElToTBMCSoGBOru7h5rtkko6+u4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtBJJBerXO1s8YjWjmxKgItJ2Ft5pN74El7e71MQzMYmmO4Ucm1Kx4fkgu0YD8XbVbqZDSUvN8moLJJFRfnecuszbMGQZQQuuZAWLQEAQyb/FixRAYIwKdphrijBNwHdTaBypZEEd0x8muhkqMav2TL4lw8FdtfNCc+fKanc4mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3JunAW+h; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymsnp6KxKd4B5T2zJ0TgQWDIRryVCqJc0xQ+m60ZwNE1bDPW/eGBfbhXvg2nPd05kGfPt7P0AGsG+NzIZYOZSnXhKjvFhKXKo7FhcYLes18riDE1E2kyJJXH+U2zEO3SPsNaiuqsAdKt/5fuel8965HTkIK/zVAO04HG8OTjvqN4j8pzd3x5g4NBt+/XE3K5lPFmoQ4bwgna/X8nkZdoJHTHQO0BnfrAc1wypstpegUAY7wP/DIXvSWYYra8nyFVY9adz7CVoL7kCEILvJkgJ45Zf8RZuep87ifqs5q0LR9831mA/HbyMxsFJZZsNfBXDG07zGART7+U9tASbJLSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmRE6bp7a29+kmor3WMTqDqDUx+2g1uqwWb4nFIEbDs=;
 b=ohX/fYz9+W4ALhqW4UVzGQRcRbEsQ2KPB6yA/E0G40EnWuB7YVptlRis65R6jbiCcYZ5YQkMeCeI7PYyVrdayxYZ/s31v7VzKe9I4iBKm1dtYPqd8q3hX3AjcRD2hJwVannH1hNXZNvpR9TVD7bg2EfS658cSFXe1/7PtH6URtPXrbKVwlX0oYMYgz4tDqabsvbmy5uQ8CDGHCA9MDxEuJANa9Vp+cQlFjlPmuxBOXebVSZFwN/I6Pn3vXEcT4enNfq7HNxgdHVagG/VrrZECmyX9496hXhpVfsTogJfdsMJQiQFFbWV7zemNACX9SX3lVOlZFJk8eReueAykBjlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmRE6bp7a29+kmor3WMTqDqDUx+2g1uqwWb4nFIEbDs=;
 b=3JunAW+hjj/aJAJJ+DLkUYX7zggEp7Fbc6VhSdJrWDA7e9L3nhc425Zfi0XCwCQDbjm3KKdkv7PwKwr8avI360ShSxHtcRAkltp9e163tbqawwkS+/CKfqK7x4Hb82oWaMEa5BnVV+8XftvdkVDW022/IF8xUtugay0vSndvJGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4407.namprd12.prod.outlook.com
 (2603:10b6:208:260::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 19:18:52 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Tue, 12 Aug 2025
 19:18:52 +0000
Message-ID: <f2feaa83-b765-4ba0-a85c-df60e2a96aac@amd.com>
Date: Tue, 12 Aug 2025 14:18:48 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 32/34] fs/resctrl: Introduce the interface to switch
 between monitor modes
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
 <9f7816ff6cefbffa2a9a701d2fd3bffbd9777736.1753467772.git.babu.moger@amd.com>
 <fa0276f8-a732-4c15-b55a-7e459cac4811@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <fa0276f8-a732-4c15-b55a-7e459cac4811@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 033a0f70-3a09-4443-e648-08ddd9d512a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlhJdkphWHlqdjR4R1hxRmdWa1ZiRnJFdlMxcW5Qbmc4YzlhUENkeWQyMTJ0?=
 =?utf-8?B?U0luWXVuNDRDSThla2FnQXZia1pYVWdqNktNZXN5eEw1SzJSUzRVNFFnSmlp?=
 =?utf-8?B?blNocWZEVWxNYjBhS25TYk1ybFQva203aW5ERWN3ODY5UDJPTVd5aHRmRG8v?=
 =?utf-8?B?TTNwWUdGMmREVEhnaWtIa3FOcHZZRFpQSG1ZMFRISTR1OW5OOWFnSU9VYW9m?=
 =?utf-8?B?dWR3RzlGcGluUFpnSDN6cXpMZytuSWoxY0VzZUNheGhJTGcvZXZOTXFHQzly?=
 =?utf-8?B?a1FUV0wzY1ZCWXJsS29sWHczU0R3MVpINGhmRWhQaUE1bDB0bjNqVVpJS00r?=
 =?utf-8?B?Z0g1bzZHN0Zqcy8vSHFtanRCc0lwWTZ0YWNaeGx0dWxoWlJzb0FMZmJQSVBI?=
 =?utf-8?B?UkdiZmx3UXNwSWd0M1ZBN2syNE1hais5RXVsTlB5a2lyZTEwV1ZLOVB1aE8w?=
 =?utf-8?B?Qk5NR3ZNVWJiRGVreXdBUzVVekFRNVQrUmlzUGppTG8vZDI1RWFMM3FZRk1X?=
 =?utf-8?B?dFhodHRFRmR2SXo4VmhDR1dYeUlMZ0E4WWFvSFNLaG9QcUh4VzFZMUFtNmtR?=
 =?utf-8?B?WnFWRkYvYTVvelBVbm80S2YyRUhWRkg1UjdwVDJOR0dVMk5UMU9ZMmhPRlpN?=
 =?utf-8?B?NHFqT3pXVnorUGxjRGF5V0l4dUcyVGxhNEhlVldiSlhET2xPNnczY3JQeDV1?=
 =?utf-8?B?WmYvYU9hRlAyZjUreU1KeUkxNzFLM0VWd21VLzJpdGZkc0xyRngxbTJNSURp?=
 =?utf-8?B?M3Zxbi9QdmUvcXRuaDhTdFdpS2V3bUJJakFOUVQ4Z05YdFlkZU9raGxGb2sx?=
 =?utf-8?B?V0wySU5GZnhtNjJFWXozSlY1OXV1RFRqWDMvV3dXN1FDQ0FybDRjcWs2ak5r?=
 =?utf-8?B?Nm1NKzBIbitmUmFNZnlmRExyRzEvNTVWOUcxbVVkYjQyWVFQWmZOTHVmSTYv?=
 =?utf-8?B?TkRRNjAzckVXQ1d5SGhFbWMzU0tKeHpGQzJjSXNscDk2d0tUTzBsdnFCVlRW?=
 =?utf-8?B?elFEc1dGbTFCVnFHSlhucmRTS3IyWXdob1NjbU1EMjBTeTVMK2ZiRDNkeERj?=
 =?utf-8?B?SDEvYUNzWXI4eE43R0RYai9xUm00VHBaSUtDc2hSalRMTzBLcTc3YzA4dWhJ?=
 =?utf-8?B?bGhJNzdLZHd0bHBjdEtEUEIvNUxtV3RVa1MxbmlJT3d6VHlZaUJTa2tlTGRI?=
 =?utf-8?B?ZFhmdjZHK2EzSmIxdTBxaFBLOHFZbnVOOE0zK0R0V3dyb3NPcWxlOCszOWRn?=
 =?utf-8?B?SGNLSnZheGFYMnRBVzRuSW51dGk2Q0JpNG9qZHpISUE3MUV2ME10akdiZFcz?=
 =?utf-8?B?MHo0K25PMURtL0dFR2RYTkxoV2NySitHYzhqdkRiaGdtaENhVTh1S0c5dHRX?=
 =?utf-8?B?M3hRK2NyalJQRnhpL3NCbmRlWUg3MFdZMmxMRUk1SEJYRytNdXlwSnlpcXZi?=
 =?utf-8?B?UWFzei9rTE1QVHVmZnhCbHp3eVVvVVZoRHlvRWJNcUFOZ0Zhb0ZoT0JDcGdY?=
 =?utf-8?B?aTVoQnkvcm5VUGl3d1lsdm9RQm5PQkhJWGpFTGFtbjl2RCs0V1BxaitkbC9t?=
 =?utf-8?B?Z0hNZEdSbWlDWlRBdUdTMmtucmRjMlFhbjlMVU9PUVBURTlBWUM2R0M3UEdh?=
 =?utf-8?B?eTg4cHRjd1FUc3JPTXFTMm85ZHA2ckY3NnU0VFF6RWoxVHFmTFRiUXhlWTVY?=
 =?utf-8?B?VEVXV2EvOEVlM3FBZ1A5UzhDSHVoTEN3QkdxMlgwVEFrU29Qb05zV21xbHMw?=
 =?utf-8?B?aFY2b294bXRkQUE1cllXQ3ZnQjhLQUdFY2YxSVp4Z0ZiZ3BneFBkTDhmOGM3?=
 =?utf-8?B?bXNtTHlEMG5SbEtDR21qYzY3QjduL3R1UEVXOWdXT2RPcGV2VG5rVXA3SnND?=
 =?utf-8?B?cmM1cnBxQ1BldjhEbmh1eUozekkzVmxGZEErRWhESmhMbmJ0NHcyWHZLZ1Ar?=
 =?utf-8?Q?0C4JOsIBijI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekMyVUxGOEl0a2N0aUVobnNuUThkS0hUTkc3ZlNTR2pUclJIelJmbFVYN2Fi?=
 =?utf-8?B?ZUtmSDVoeFJUai85VDFra01rYXhqbG5RaCsrQ2lhWFp2MlFPMTN0ZHJsUFI1?=
 =?utf-8?B?eFd1ejRjZk5kSks5UzlTQ20xci92Q1ZrVDdVQWVCSkNUcWVBTDFqQzBiRlVT?=
 =?utf-8?B?UnQ2QmwwWXA2ZkIwOGRyT0g3ZTdEekIvcWJjd3UxSUllUzRVTkVDL1M4eFZo?=
 =?utf-8?B?Yk9EblNsUm8zRjZxWUZGNDZyNG9iUGdCYzFJM3VveE1LRkh5MUwvb0pEeDlR?=
 =?utf-8?B?OXBSZGhIcnVWKzdoYjRCMkNtck94a0VReS9JQnJBT3p6TGtQS0NFbVFuTTNT?=
 =?utf-8?B?cVhiNlAwbDlrZjNJZEdrajdaOHNJcjFXQ25yd0Q0WHl5V05KM2hCeTB1NWsw?=
 =?utf-8?B?MDZqeUgreEpxNGQvc0ZpUmdLdlgxVytkUzBTQnlqd1A1VU8yWS9IMUhkOUJi?=
 =?utf-8?B?L3lBVXZVMFBHdFdCMHRBQVVCYlF2ZmFNVmp6NjlodktUdmFiNTErM3lKTnZ4?=
 =?utf-8?B?TDM0SG9OQ2pFSER2VEs1SGt0L2wrS2xDRXJNZUFWNmo3b05kR25ERlZlTHNK?=
 =?utf-8?B?bldmcllvMDJoVFc2d0c5a00wTUNoVGVWL3VwMmJMekhCMmw0RmhwcmhPNEZD?=
 =?utf-8?B?bUdOR052TTY3V0V0a2NQYzUydlRPZklLUW8vVTNIYld1T05VVmwrYmxuRHhB?=
 =?utf-8?B?aE9mNWhZU0dBSk1pekl0c29DQXlSdkdNdE5Mcy9nb2NiQStSMlN3ZWJ1VnRC?=
 =?utf-8?B?QVNkZ0dDQmNiMThjSVRBaUEreG1XMHBlTEJQSTAwL24rTlJDczhESzI3REV5?=
 =?utf-8?B?dVdYa0hLa2t2RWczR2dBWGdQOUdvaTg3d0FXeHNocXowZW5odmIvUkZYWmI2?=
 =?utf-8?B?KytUNG5WYmdOQzZQMEJjbWtwSmRoWnk0M3o0azdYNmlEQzVITzhQKzJxWTBq?=
 =?utf-8?B?S1NnbjZ0OHhCZHZVbHNnSkU2VTdTNnVIbERGam5BbGxXeVZnRksrWnpjRXZr?=
 =?utf-8?B?bUZleTFLNUJXdnhUbFg3VHh2K3YrWkdzeVhsbU1leEwxRDFDMUxaV3ZhTXht?=
 =?utf-8?B?dnhyV0FkeXVkZTNBa0RldWROVXVudGpTbXNlS0hFR3dQdWZ2NHZkU2RrUHdT?=
 =?utf-8?B?b1NaaHVGdWZnOTlHVXMvQXFlRjFwZy82RWt5L2ZyN3FqWldieTQxclhLTVJ1?=
 =?utf-8?B?RTFkN2cvQmJHS0xla3o5RTNjOU5KOWhxMkxRSTBhYm95YjRtWlNXUnh3TFFx?=
 =?utf-8?B?Y2VoLzdZbTJ1Zld3eFhBbmd2YjdOVXkwRktNQi9VNEhIcUJSWjJSSGlhSWNP?=
 =?utf-8?B?MkJqYjIvRU5ibndnZ3FrdFdoYTYydzdiWWlYZFhENmhvTmZIaHY2NWJxR1Rw?=
 =?utf-8?B?MWpTc1RhTjBFMGRzcG9XMm5IcXpGRlNXZjhaM3l5RnhqVXN6UVU4S1VxTmx2?=
 =?utf-8?B?SXFzb0JTb1J2YlUweEtqcXUrTTRCSDZWZEQ1TWdGOUVXR1EzSUUvTE1TSEtn?=
 =?utf-8?B?OVd6dFZ4OEhsRnZwMXhoakFlVm5sVXlwcGNFbVNYQ1lMWEJWSU4zN296SzBP?=
 =?utf-8?B?ZjFYTy9mRkc2S1JpcitMd3J2U2FPYzhpQnJKRFZMMFc1ekU4Y1JKeXFuZThT?=
 =?utf-8?B?TUVuQTFVZGtFb2NvOTZBUTR3S0JKb2d6VWJiRFlQWHU4ZC9VZ2pPWGNOY2VZ?=
 =?utf-8?B?QlBNRDczQ1hMU2xJdGNqdy8yUWpuLzMrelN0RExYaVVCbGhyU0lPTXlQczc4?=
 =?utf-8?B?UHltSWM0Z0xabGJFSTh1T3hXeGhPSzNXUis1QzdmTUxRb21LNkc0QjN0dVpM?=
 =?utf-8?B?dDBnK0xhRzZHUTEwdjJaSVBxaVN3M1NraGgvb1J2TzkwMm9MVk41Yk1uNDFh?=
 =?utf-8?B?YVJjR2pEVElwSVVYZkdleGNiUERhM0JFbmhzc0RNQitwRUdmdmU2Y3RGMllZ?=
 =?utf-8?B?U0VaUlk1bUxRWjlPMmtOaXQvQXE3V2lQOE1aYmlOUitqYi82Q0hSTHp0SzJj?=
 =?utf-8?B?V2FaZFZrVE9VdVZENFZOc3R1cWp6Z09qdWQzdjJ0c1NzSXBJenpwSVJvM0Rx?=
 =?utf-8?B?TW1jK3NtbGFmSVA1ZGxDTWpMRFF2dUxHdmFDamJVZ0lnK2h3cW1sZEs1d0h5?=
 =?utf-8?Q?JkOw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033a0f70-3a09-4443-e648-08ddd9d512a5
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:18:52.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbdBiGYIBdWuFZX+pFID4IYaNHsJ7vjPEYwX/VYa7tZEFzTJ2C9Uc9+ffdPGYK3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

Hi Reinette,

On 7/30/25 15:11, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 1aeac350774d..68ba08e95a54 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1865,6 +1865,75 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of,
>> +					     char *buf, size_t nbytes, loff_t off)
> 
> Please move to monitor.c
> 

Sure.

>> +{
>> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_mon_domain *d;
>> +	int ret = 0;
>> +	bool enable;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!strcmp(buf, "default")) {
>> +		enable = 0;
>> +	} else if (!strcmp(buf, "mbm_event")) {
>> +		if (r->mon.mbm_cntr_assignable) {
>> +			enable = 1;
>> +		} else {
>> +			ret = -EINVAL;
>> +			rdt_last_cmd_puts("mbm_event mode is not supported\n");
>> +			goto out_unlock;
>> +		}
>> +	} else {
>> +		ret = -EINVAL;
>> +		rdt_last_cmd_puts("Unsupported assign mode\n");
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
>> +		if (ret)
>> +			goto out_unlock;
>> +
>> +		/* Update the visibility of BMEC related files */
>> +		resctrl_bmec_files_show(r, NULL, !enable);
>> +
>> +		/*
>> +		 * Initialize the default memory transaction values for
>> +		 * total and local events.
>> +		 */
>> +		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
>> +			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
>> +		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
>> +			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
>> +									   READS_TO_LOCAL_S_MEM |
>> +									   NON_TEMP_WRITE_TO_LOCAL_MEM;
> 
> This needs to take into account the configurations that
> hardware supports.
> 

Yes. Sure.

-- 
Thanks
Babu Moger


