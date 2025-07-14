Return-Path: <linux-kernel+bounces-730286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5EB04257
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AAE16BEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C38246BBA;
	Mon, 14 Jul 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dT2DN7YQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90976259C83
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505152; cv=fail; b=AMJ9FUxD0N+icgtwSlVrJHTd6NntJT++fTCVmOx8lNe/IDkutnHu0urPSnN290JekVfrBsy5af7bQ7/8Y6L65usQbTJByGdJ9onoiW5eI2VK2P27asVf3DgiIyoDCkmPTMTmTSCf8qU76yoRYFxMbNwyQ8XES1spU6/jtWovJ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505152; c=relaxed/simple;
	bh=j1BUqI4aXJrw9yVR2RsZZqwESYyIeUBLSqaQKFPWing=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=ZX9GG5ABfdCUDnodxXm4SzeUO9mG9XlHuSTg9Z+4Vy8/bzjxOxF9FDhwGH3P/nauQ1yzWlAnQyux0BJo08SztDkvtdyQJl8vWbOz+dZcX1UcpVaNphyeVHAuI+4fNK9xsSnaevCL2zN3VYMfZHfdnvWDFu9DVmaXxHYGIMFxIDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dT2DN7YQ; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUtO8/Z2tMo3e2rs/ETw4U0cwsw5ENXUYyA4ht9mIjbsAJrRt3YowZ33htyO7S6KLYK5rGo8YykpMgmEWzGlYvj2frkJtZuX1GKP7yFRm7mit6zHe4TzZvFe/5wEPkK9ZFBtBtgOyRRThIQq6GTBCBNO0e9KsDU4/1GYjfcbLt3ePiNaFvmUFvW1E7gCLfj/MxWGvBdQl0q//tvADe3cz8pCPCHVg/UWOd/Du6exzxFBEewQvesGywfI2nKr7Zmm9uiUU68Mur2Trk8gtwmUF5zoLVmgeL63KUiZy6NNyF+ImMSfl4DmjNOsBwX9wEPTFIn7oEs2NrDh9wDiCR1wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS6dgZf27xQGfeLlPoTq7RkMFcCJrBBh7ApYO+os66Y=;
 b=grbmsdKW3ZJqu4Ji1D1nSsf0kt9jGd9YTe7rI9mondPQZNZ3EX6csJBKW2aggVU1FPY45H60yVCtgh+6bc330HAg6Wewnke7z/R2Tw42CyM35U8Bp0SgZc9r5Ri6okokBXfcrH7krrRGmOiSAYM2flIyUwzzwGvZdiJ3OgZkxIZ/vWLiWGbxUlodIx4PlyT9dgnD8WUh1yt15OTm3Kho1zp1jBbn/kCTDQqHNeVH8tk7UMNTQCHVq5pbkD1+GpYPYiX3vXK6kUQtMzWwoinRSHyr4ee4cyjXnj0/u8WLPvvRB76wYhUl8zGvIMov6jzV1E6TRmNQWHP5xa5TLJ+3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6dgZf27xQGfeLlPoTq7RkMFcCJrBBh7ApYO+os66Y=;
 b=dT2DN7YQa7UQ/BOe0BE2rt1fsVXo1Dkb9wwW6YPoSaYYytkRkGMyM+wymc6icKYMvk1zuItKpLzNwXe8x4oj+ee2UPrDEOvxNk10bKM4tTgPg/ctgPuOeSuKBbACY7d+5WeCbdvCRMWN7hVm6vVmA6BiW0ChpuvJSoXUAcC9pTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 14:59:07 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Mon, 14 Jul 2025
 14:59:07 +0000
Message-ID: <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
Date: Mon, 14 Jul 2025 09:59:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
Cc: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, santosh.shukla@amd.com
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
In-Reply-To: <aHUTMiEJ-nd76lxM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:806:d1::20) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e8abad-3e94-4b8b-e843-08ddc2e6fb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHJ0SmlDY2F5UVA1aXNPeXZMNjhUMWxFMUJHa1AzMi92VEpNVWVveTY4OTEw?=
 =?utf-8?B?UlNBZzhXSEhvS3VqVUpDUFlzUEt1WkIxaU5GRlVtc3pacG93d1MvWjVZUHdO?=
 =?utf-8?B?TS83MGl0MFNTVnV3QUdHTmFCc2JPWTlkS1BhV00wMS9CNURFK2dQN0FGblJx?=
 =?utf-8?B?Y0hPMmN5cGw3U0xyZThFZlhmbVBzYXZEb1hTMjc1YjNNaU9IZ016VjVOT1JY?=
 =?utf-8?B?bFlXN08xbW5iakYxQ2NxRHZoV0srMXNDOG85UXFHQzZ3aDZCZUV4UDdTZ2RS?=
 =?utf-8?B?QmxpQkJJR2ZSSml0ZWl4SlJReHFTT2J3dElKL1JnRGJhQTVtQmpERVk4SUZX?=
 =?utf-8?B?Yi8zbExmQVQzbkdXMVpseDJXRDRvdXJPczdrNGxJT0lHRG8wbUI0UDU2VzJn?=
 =?utf-8?B?bldBUEpSaUp1SDZtR2JDVzAzdzdkQndOOG9GZUFNQTFGU1MxenNCWGRFVFVr?=
 =?utf-8?B?MjQzS3BPTjhVUjZPb2cvODQ0cjVIMmdLSXdVUVNUTis1Q0FuUU4rV3dmdlBl?=
 =?utf-8?B?RENBNGJBRUxocHJHRWRoZllDSm5xbmFJV01xMUI4dnRtMnJGWFlQcWJFUmJY?=
 =?utf-8?B?Vm5haDJ6YlpmQ2Mra01zOVU0d0lpQVFvZnZYR2orVSthd0IvYjFWSVFsS1dY?=
 =?utf-8?B?UGk0cTR5R2tRZkNDNFE3SU5EeDJJbmc2b25wa2wzNngwcThBZzJDeTF2eW8r?=
 =?utf-8?B?bkNkdjdNbGVCWFRkSkxGbzRnSnRNSzZWTWFUZ0lXQWtIN3ZGMFB4TGNKWFF4?=
 =?utf-8?B?S21nNmlRS1lIRjFmOW5MQy9rNXFjOWdKOUJoRjBzdi9CY0Z4ZzJzKzJlaEg2?=
 =?utf-8?B?MzZuOG83a2szRVFURFg5bzNmL0VlV1R5bjV2OEhBbXJyTWh6ZEJkMHJxTEo4?=
 =?utf-8?B?Sld6clQyRk9lVVdrc0tPSmZNNElXOWdRaWZIK1h5dmtmT001TXE0UHU5MVZC?=
 =?utf-8?B?bU1SWUFHcFRuMUQ0Mit4ZFVydGZVVlZubDd5Vll6S0RKWnVEQ0lLbHhpL2Mr?=
 =?utf-8?B?cURhUEgvbG5YYmdYc21PT0pYWlV2MFhzN3J6c2ROL3lRY0NValdjQ3pETE0y?=
 =?utf-8?B?ZU5tMGJLeVR0SldxYU5JQkNFZlZhbkNOajV4cEtKb1YrYkYxU3MrdHlyY3Rr?=
 =?utf-8?B?cGprUU5wYWduTUpxbnV1eFBhd3BBaENKdUNsZnF6TjNpcmFSQWVwaVpFcits?=
 =?utf-8?B?Qi90QVYzdXlDUmpRNlJWWkpDY0VVNGMyTGt6R04wajRmK3R4YjlTRGFNa3pO?=
 =?utf-8?B?OEhYSXh0RWNXbGMwOEUveTJZQnQ4WjNqbkVKQ3dvbnBNaDBnMUp3bXVaSndO?=
 =?utf-8?B?Mk5SMkVLVnpLZWFWeGNCeC9EdkNYWHIveUVxVDhnaTBvWjQ5RmlKYnVucHJr?=
 =?utf-8?B?VVFDUjEvS0g0QW9qQStNVFZFM1dPNEtTYi9sNUNmR3FOckhrY1lkWU5sUUgv?=
 =?utf-8?B?bWtyZE1LQTB0bG5WYnBXeWdablFRL3NoK0REMGhPakZoTisveWdxYXAxdHZH?=
 =?utf-8?B?ZkljWGE0YUhmNVoyWXpEbnhKZXY3RXZibEpHckVwZnBUYVZvTUhjQjNPeTda?=
 =?utf-8?B?VjZKZEVUSUpURkMzcFJwWFpDMkd5VklWaU0zWCtVZ2pSQXdoWlprYWpBZG51?=
 =?utf-8?B?cEtJUmt5V2ZHNm0rbUxrWkhHVkthOUhHR0VCSEFET2VlZUpkRk13M2syMW1N?=
 =?utf-8?B?ZkJGVVMvT1NZVVZLZFFmMDlTSmVGbW14QUZaMUJONTZIdHRQYUxpMDhtZ1B0?=
 =?utf-8?B?MmJvRUZZSjV4cFFOc2pIUGx6NW0raDEyRStxN21sZzl2Njc5ZmZFNUpGakg4?=
 =?utf-8?B?NDNoUHVqaExWbW9VQWpteHlEMXVQSDBTNThMZ2czZW9nc3NiZ1g5T1gxeGNN?=
 =?utf-8?B?TFhCMXlOQ3pSd0hwajVQZ3dEeWVzVWVxSUNyd3RIb053cFZvdGtXV3VSdlY0?=
 =?utf-8?Q?vmd2MW7RnQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUZ1R1FKbHZVWTR4NmJ5R3NUeXErR1lWQm5HL2dpTWw1VGpwK2UrVjBZYXRk?=
 =?utf-8?B?Yi85Qk9jMWJpNXUzV25laXQxOGFTOHRNVi9HU1lWTU5IU2hhSjRKZTdySHlH?=
 =?utf-8?B?VVJmV2RocEgwMUw0aTQ2WXJsR3B3Y2RBWkNjVnFlZlprTTVOYmJ6RTdUZVpX?=
 =?utf-8?B?ZzVESWRBejBJSEN5dU5CQ1dRdDFCd25DYzdoTERVdFZVODh1U0pGQ3VXSHRq?=
 =?utf-8?B?dDgxVTlUS0hkYlJxd0tIVTBxQXU2OXMza2ZrVW1zaDRuSGEwZERZcVNBcGFZ?=
 =?utf-8?B?RWpObjVhUFBtQTF1L0FpNW5WQmhiNXVsclU2MzZ6NUJ2SXFaRlQ1LzZqN0I0?=
 =?utf-8?B?bWZ2Y1Q0bCt3eTBZdGlMRUdSLzN3WXJqWUJvRlZXV01mWjZDSzQ5b0dzdzRO?=
 =?utf-8?B?NzN0VmYrckFRdUhjVVB5Tm1sUklKYkJvWEpOd2Z1MUJvZndEVUtJakFBVFJF?=
 =?utf-8?B?WFkyeE9tdURRUTA0cVdJaGIzSlNjN3BCYW5qSUt2K2tvc3Y1ejFBK29pVDRN?=
 =?utf-8?B?ZFpGU3pEYlQ2UGdRT3V4Y3h5ZGJsMUwvT3ErVjVGc0ZKR2I1SDJWTFFuMVN0?=
 =?utf-8?B?M0hwZEY0aGtsRTNZeUJuUzUwZURYSHdyZEJsUGJNT3c1dGJHSkxXQlJ5ZzVE?=
 =?utf-8?B?N21uMXVNckRkN1ByellCRGNpWWxSdkxvSmNOTm1iUzlWaHU0ZSsrVWZqd1c4?=
 =?utf-8?B?UjU2YUNPT1pZQVV1ZFVaSTc5NEhVSklSMWlId3U3Zjg3UG1MNFZGYitLQTYr?=
 =?utf-8?B?NEplYVczdFpOMmRud3dKZHd3VzNXb3FCNVpjaElVQnJleVN3dEh5bjgvSnVE?=
 =?utf-8?B?V2EwSlJYdHIwRm5zRGt6aHoyVDJNS2NUZmFtVzQ5Q0h0K2JTekJSRVFrVE1Z?=
 =?utf-8?B?QVZQTk1zbjNrM2Y4TjUrYmZsR2FCdTBuRjA0Q2V1THV3MzBkQnJJZ0lTWHVE?=
 =?utf-8?B?eml2MzRySHR1K0NSNU9NQWdETkE5YUZ6d2JheFBxdGdwMi8rUUFBMzZOK003?=
 =?utf-8?B?YlAvRy9SRzh3UWRGOEZuS25WQ2U5OFVnUUpranBCajY2MStucFBRTEk4OXdC?=
 =?utf-8?B?TDVYSUJ0Vys3RGRXRXlXNVNydzVmYkpoV3Zlb3hIME9oOVRhVzdSaHdkMVdJ?=
 =?utf-8?B?OGJLQXBMM1k4SGlTRm1UaldYSjBUVVUrcXVpbUNOR0NZajhUVjVnNnREalpl?=
 =?utf-8?B?WXpYaW1nTEc1ZjNmY2NIQ0ZoZWQyWWc5L09DV0gwWEJ4MDdnOWN0b2tBdXh1?=
 =?utf-8?B?a0I1cm45bTU3cEJEVk5ZVDU5UGtGRnBhbXZKNWIyaFd0Y0R1cGh2dmh4Z2VI?=
 =?utf-8?B?eXZQL1FRdFI2QmV2YW9XRzRyQVZCaEV2MUNoblRSOVRlS1lEaXdzY0Qzcmpj?=
 =?utf-8?B?OTVUQUo4dDQ0UEtLSlNQbjVJT3ZXaTZqU3pwMnBNTit6WUd5SWg3YzZBcVBU?=
 =?utf-8?B?dDgyQjdGVUNjOWV1dGFoOWpFcHN2ZGMwakRRNFBpMWkzVkVUb0lzcEZBTDRh?=
 =?utf-8?B?SGlCdktQTXV1S2JHVGVpZmRONUtjRGhocHJZZFdrejJPUDRtdXd3clBHT1Ir?=
 =?utf-8?B?Q1NqTVYrSmZPMDdseS9uSGtjREpVKyt5eUFNRmFkUnJ3aC9RZTMzRjFPckJp?=
 =?utf-8?B?U3VBYkxyYU1hVWtIQVVyN01nMEJqZWp5T2M3c3lJWnZIWWlxdkNxV0lCd3l0?=
 =?utf-8?B?ZWVTSDc3QnBVdThMeUhuMTdzVCtQYjZJK2ZEOVU1VDhHdEVZd1htbVk2dER1?=
 =?utf-8?B?dHpXRkVEdmtXcTFJQWJXSnovREhtQ09rR2cvVm0wNVBnWWdNYmdjbDVLUjcv?=
 =?utf-8?B?Z1dWOVQrNmtQNmV3UDNvNUlkUjBHM2hybG1WazZZZE1zVUZSM2FRamN4bmky?=
 =?utf-8?B?NXZJT0tnb1FHZm5jZVBVOWhOZlEyQVlQMit6WkowRWtnQnRXL3ljRUdYVXZ0?=
 =?utf-8?B?U3dscTlHWlo4V0dqS29EQUZvMVZWZFlNRm9WQ0N5MFZweU0rZGVWRWpLR2dy?=
 =?utf-8?B?akZOeVVZQjlUaTYwOFBiN2Q4TVFnRkVHYzVGdHlMVU5NMEJLYVJTUnBxVWZk?=
 =?utf-8?B?a09kNE9GR3Z0OWRMeUxOV2hmb2lYN0ZFbUlBcWtIb3FUMjNwN0xza2thcE9S?=
 =?utf-8?Q?EIxgXfFKsI7sC74j40dVrxc06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e8abad-3e94-4b8b-e843-08ddc2e6fb9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:59:07.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh3zXigAjulDoGI81v+H7CukqVVaZanS5xyM91u9rfodcDctKbNVkLpSsOjUoHtO0akIpGhZEUP7fMGnp1iwjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

On 7/14/25 09:24, Sean Christopherson wrote:
> On Mon, Jul 14, 2025, Borislav Petkov wrote:
>> On Fri, Jul 11, 2025 at 09:42:00AM +0530, Nikunj A Dadhania wrote:
>>> From: Sean Christopherson <seanjc@google.com>
>>>
>>> For Secure TSC enabled guests, don't panic when a guest writes to
>>> intercepted GUEST_TSC_FREQ MSR. Instead, ignore writes to GUEST_TSC_FREQ,
>>> similar to MSR_IA32_TSC, and log a warning instead.
>>
>> Why?
>>
>> Nothing should poke at the TSC MSR and those who do, deserve what they get.
>>
>>> Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
>>> with Secure TSC enabled, as this indicates an unexpected hypervisor
>>> configuration.
>>
>> Huh, this sounds weird.
>>
>> What are we "fixing" here?
> 
> Returning ES_VMM_ERROR is misleading/wrong, and panicking doesn't match how the
> kernel handles every other "bad" WRMSR.  How's this for a changelog?
> 
>   For Secure TSC enabled guests, don't panic if the kernel hits a #VC due
>   to attempting to write to GUEST_TSC_FREQ, and instead WARN and drop the
>   write.  The kernel should never write GUEST_TSC_FREQ as it's read-only,
>   but panicking with ES_VMM_ERROR is both misleading (it's entirely
>   reasonable for a VMM to intercept writes to a read-only MSR), and
>   unnecessary, e.g. the kernel eats #GPs with a WARN on every other "bad"
>   WRMSR.

Maybe it should be returning ES_EXCEPTION then instead of ES_VMM_ERROR
and forward a #GP, which is what would have happened if the guest tried
to write to the read-only MSR if it wasn't being intercepted.

I'm still not a fan of intercepting writes to read-only MSRs that are
passed into the guest. If we're trying to replicate bare-metal behavior,
then allowing the write to fail with a #GP seems appropriate.

Thanks,
Tom

