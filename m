Return-Path: <linux-kernel+bounces-891085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6AC41CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA093AE2EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10F312810;
	Fri,  7 Nov 2025 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y45WUhrK"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFB312805
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552967; cv=fail; b=VLrV5KXmA/AYafPfI5NY9G8O+xlUNQ41MYgBtvnnvZ/lMEXj8ohfklOTqv9lHbumSjZKB8IolBt9Y8HOG3SWZ7wzYTG+xVSsgeY0LtlwlhdBa9uGJ6gu/58PXgMAD/EFIXTr4ryKJNo8/kro7yY5J6w4ynRjKXkUeOmePKm3IM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552967; c=relaxed/simple;
	bh=ICBZ6qGsFDAATikD5rqU+p0iUlaqIN97Yi+Ff7EboWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bleXCOTJVz4+dZ4DJG3aBKi70kK6vh+YOvBOgnbIgGKFvAPDzSiLWedPufCB69NUMkucayQGRwMFcbv0cpyiv7qg+wrO7ikSoHBfLbYdZdq2nGNXMbv9dun4jodnQyjFIWG2h4LlvMrZxoiQbWNqgdqJi8DtdRoTkYnYO+LK3Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y45WUhrK; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSeIgXOigvdEMJbvYePiNfQg9mn1aQSTmFKAFt5gCmCI1iVVNDqCP4IyQAif1CC0j+XREmRnxbaH6lgaiMUD6lAsEisZNSMTDP27N7U75Nh03mgaATJcMV4/MCwsEm94pXmZgFWXZJl65v3RAsborY4PkETS2It1mGJtQ2QGpma9WIzc9327ifLAk9Qbadck8OD0RWCIAjbqoG/WiaWs+ug24F2AcyfcHP+Ees3jrqriVo4vvoC7jYzXZIo1fwk9Mr0qWdypzYkBuCD1+ohU6g/feYQzCsi5X3dTTqUzrViB/H+0kWAxBNDLEKS6E1NgmaqhD+lKS+eI7zGKaLHemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twep8fBDwzyfNzG9S4u7tYfaKeF1lgGk+ox0PtYBjAw=;
 b=tNVXsjlEnp6uP7BpgIc0XEuXS/Ctvg0shs1g8+0GOzohRQCPu9QBSvoQSRlwCunq3ro6vZwcWT/8x8BFJZBRpzPisBI5IXmv/8BCRvYklUVTv8Yr/ztjvwJIHR5NeUIUIHGujXNxqrgaHm+PB8VS3n38w3JS40kHC8pu3vcMBmUXi2Fach0pA7cXxIDAopiYBmZYL27KYiqzRU2/1QFMsxSby48Wn8SU6up1wtlfmewflNXXZO2iz/UOD/Dld39MJ11RNH6hmr3IfGkweCj4KXnJHQn+Ct7k8E8oTIEtHjoJlP3TuKDs1YwePIFe6IbkIj+A4jcorGiwl50cWiEt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twep8fBDwzyfNzG9S4u7tYfaKeF1lgGk+ox0PtYBjAw=;
 b=Y45WUhrK1d/h5rgM5WMznTxnLlCfXjB+GUhp1EoXhh8tHfGu0jgXL53kUuP9pT0YlvGjb/3DrPEBCSZCM25wbJMny6GjJNsC01m5pXcf6ea3irtivvPdLWx17yFFNn+y3KYnJR8mYJNREF9I6e8lKHI5tnsQUD8dOKGKGjbgmSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by SA1PR12MB9248.namprd12.prod.outlook.com
 (2603:10b6:806:3a3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Fri, 7 Nov
 2025 22:02:41 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::e4da:dfce:19e5:6405]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::e4da:dfce:19e5:6405%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 22:02:41 +0000
Message-ID: <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
Date: Fri, 7 Nov 2025 16:02:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: Aaron Tomlin <atomlin@atomlin.com>, tony.luck@intel.com,
 reinette.chatre@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 babu.moger@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: linux-kernel@vger.kernel.org
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20251107012401.224515-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:806:6f::35) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 173548db-7b29-43e2-4a8a-08de1e495f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU1YdkI5dndvMkIvNmJVS25ubXY1Ym84a29zcVhuZ1pNblhMZ0dqNkNxMGpq?=
 =?utf-8?B?d2lUSnAwVjRxakdpT2NJY3FjWWFQK2JQVkhJUzdVZmRSSDNiTWVRZ3BJMkdV?=
 =?utf-8?B?SGhuTHQ1MVdmQ093cWI3SUs3cWhQQ2tVQjNwNWhkaUJoditLVGJZTXFqOGRv?=
 =?utf-8?B?eU5hVDRJMUxkWWpsUHZRVTJTSWUrc20vREZVOEsySmRJKzNHR29kbVVpYjFa?=
 =?utf-8?B?VGk1Uk52ZFg0ZXMrMkgrVHFOclpySGJKRGJqZGJtZjZiN2dVZVgyT01vajFa?=
 =?utf-8?B?dS83ejZnQjBRV2I1QTZWZDk4UjhaSE5jaFVYSlFzOVl6UFAxUFRzOG1aUWZq?=
 =?utf-8?B?YlU3dkxPbyswM3BZTk8zSlpmVVZEejl6RkdqY0IyNmVYaHJhZ3B5ZnVOWGgv?=
 =?utf-8?B?ZkFWWHo3VnNZWGUvODFnRFlzZGNxaGdONUpDWDVSRHdWL0hkYUlQTCt6UHpq?=
 =?utf-8?B?Ymo5Y0NvV2IyaEZ5d0hGa1BoMUxSSGNvblY2aC9RQ1FBTyt2VWFDMWs5ZEVS?=
 =?utf-8?B?bHVSR256bnFrSmNUWGlWZEVLRFhCSU42NGpqYWRjdDlYOVZWdEFZaDVFREp4?=
 =?utf-8?B?YVpuM3JEZFovZmRsS0tCR2tTTlN5dTVVeDVWL3k3NXNacU84K2JITHp2YlEv?=
 =?utf-8?B?THBRMFpCUm83ZUNmYmJnUnhRUUphRCtHb0xzN21Kb0VUMXUyV0Q3aUhxRDlV?=
 =?utf-8?B?U3B3ci9yc0M1Z3dPL2RrTHBxQzFwcXdOZ3YvK2xDbnl6VmxaV1NrcEFHd3Ro?=
 =?utf-8?B?TnJuVTF4WVU4cU1wamVPcUFURUVKbW1YMU5wdGhTNStZZmJjVmRXM0JScENi?=
 =?utf-8?B?a2ZPNU9IeWN0WGRnUjhZVGtXa1lKMUZGWnI2ME5BdnI5R0VERzA5ZmxLTWYx?=
 =?utf-8?B?T0M3S2hUVW5aS2F1UEZtYXY2bkNLU1lKYkJQdnVWNnY2KzltSkU0dTFZekRX?=
 =?utf-8?B?SEoyaUFTUjlldGRnblYxOERhaE95ZHE2SXQ0czdkMHVKNHZZNURMOGZZTXY0?=
 =?utf-8?B?SUhXU3N1dmlubzh2WktsUGVrU3N6Y2xKUzI5MEU0TjJiSFZudHVHTHMrUjg5?=
 =?utf-8?B?Vmd6a3V2b1VKQk9TYjhpdXlRR3VOZ1MxTm95U2llMHJvS1R0M2hqYkRyTjBS?=
 =?utf-8?B?bHFvUEx5RVVud01VMUptN0puRlR4UTBPcW54MVJvWllqTStYYlgxVUdkREx0?=
 =?utf-8?B?TXBseFpabGl4RmFpblU4UURZSVc3OEQrTjRwWUxZMk90a1pIQ3U2THllekZq?=
 =?utf-8?B?ZGMvN1U5OGN0U2o0cnFWWGRJZXVWK2w2ZFZrL2p6Kys2Tmd6c3lVTk9URGJM?=
 =?utf-8?B?aTVNR2ZIZEFlSXZoSkE5TE03WnFpU3NDUzNlak5NV0hXd3VoVVl1eHRYcG1w?=
 =?utf-8?B?MGpLZHo5RmpEdXRrcWtQWi9QTWpzNUtxU0tQeXB3TVNvQW5TMC9xVmRyK1Fq?=
 =?utf-8?B?RE5iRHJIRWJtbVBTV2k1VnYrUTBYa0w4RDYzcnVpMVNONjNFMit2dW1selZj?=
 =?utf-8?B?ZGF4TFVOUHR4S1lHbGhJdndHRUtiUGY0aTRZYnBaZzVKdTc0UDRWUGJ6eUtW?=
 =?utf-8?B?UGZMSytQRlIvaTFIdW5tS0dCQ0Nsc0NSR01VclBuT1JrV2l1aHIvVlRUamRM?=
 =?utf-8?B?eVlib3JSVjNYMi9TWUsxdDVOWkxWcGYyYk5oMmR2Q3dwTksveG05Vllpc3Nm?=
 =?utf-8?B?V1VQdjZOZDU2cTNkcDYwYzQvaWtwL2NNd2U1VVFETkwvVUJsb3pHU0ExTzc3?=
 =?utf-8?B?NSsyWWxPZ2NLQUhQMzg1MDhwTUJHcHRGUmYwTWRpQ2VTQkJseUVVNjJVOVgr?=
 =?utf-8?B?UUE0YmtEd0luNHI2Wkw5a3lvYW9SR0RTZnJKZ0IrZW80QlRSMDZNQXB0NGNT?=
 =?utf-8?B?NlFxVTJmL2Zjd0V4NzJqMEhWRFVzdG1qWEZLRDNYWUN4MmI3QUZWZHdTeTIr?=
 =?utf-8?B?WGxkRHhsNmVYS0JKWE9UL2RUNlo5OVVjMVo0RHhPeW05eHZIWVB1MDVtN2M5?=
 =?utf-8?Q?+qVgN3qfPN0bEePqcpf7gmhm6Z3EDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkExdVc2cXRjeHlSbFZkQVA2TjlwZ1NISWtXZ2ZZMEZNZzFJUWJZSGxZNG5W?=
 =?utf-8?B?VWNzSWk5K0dDVU01MDg4TEQrWnFOdHpTdjM5Yk9GN3htVXZ0c29xY3hPUFVs?=
 =?utf-8?B?ZkJxU3o3NVhRM0d5YXp5eVl2U3h4UnZqekE2VVVmbXVyZVhoQXEza2FncGJ6?=
 =?utf-8?B?Wk5EWG00SXUwMWFueWFrVi9lQlZUTzhmRU5NSG1YSGdqbTEvSGp5UXM5MFVy?=
 =?utf-8?B?T0xWZENCc2F3SGtsTGNCak5uWWdScksxU0kyUXg0ZmNxQmRiWGJiZ2hNZ3Qr?=
 =?utf-8?B?djE4MjZqMTY5MnoxTjNLOHFBWDcwNlNVeGg1aTdIVkNTb1M2VDQ4Z3N0cmlX?=
 =?utf-8?B?ZHh1RGlRMENHQm1KN0MycDFkWFFhbzBCSFBHWmFCVUFYRGV2dkRpcllraE1R?=
 =?utf-8?B?WXBvSmFEbGZjU3p5VVk5ODVVS3Zsa05KYkdNUFoveGsvZTZxemZDdmdQVjZI?=
 =?utf-8?B?S0h4WXdtd2VGdCtrSlYyeHREcFd5KzJHenNrWjltVk1FcnY5cUNHQ1lETHMy?=
 =?utf-8?B?cmVJSkRDcVVRMlhHZm9Cd1VYbGhHeVY2dFdMWW4rWW9wdis4R0JOVzJaRkJa?=
 =?utf-8?B?a282eG5CTXM4RzZPblY1ZzZzUi94UEJVV0FiVW9wb1FReXBKdUdDd3FCekJt?=
 =?utf-8?B?RGozM1lQNmQxY2wvRy8wbUFGSEdoRlBGdUtzeGRPTWN3Y2dsMDdzRS9tTXZW?=
 =?utf-8?B?bkRDT2QwV1dvQTkzUmk2bW95TzRJOFIzYlFFMDZrV3I4VnlCYlo4MW9hRU1Q?=
 =?utf-8?B?NS81d3RZZm0zVjljcVRtcEVGWlptenJwQmNaOUZnc0RmNThZMkhuYU1FeFEz?=
 =?utf-8?B?NGtCVmJubUZjWEhTUHpEVFhJRnA5WFBybXU3UmtMdTBTVXZOTTZXK3lNUnNa?=
 =?utf-8?B?NGlEWlB2djhIektDajJxU1BXa2IrMkk1YmgwSXArZkd0UkMzOFJSeXRtdWtH?=
 =?utf-8?B?Smw2MWhGUElMc0E5MUxoNmdaQU1lNXp6empaTExLbURnMUlCenFJRFdJejIy?=
 =?utf-8?B?Zmh4cDRsb3BpM3NlZFRQL2VjeVpxVTNpY0RPZHViMElpWWx6QXZlRUR5aWVk?=
 =?utf-8?B?dHNUTElLSUpSTWt0VXNhWHJKTEl3SjRDSkVpQUtObDJVUldwWEh4R2wyREQ4?=
 =?utf-8?B?bnViaSsvVTBKSTNUNjVlZ2ZmbkdkNlQ4bUlqTzErZHVlVm10d3Mzdnp2NVUz?=
 =?utf-8?B?YmdmazJFWlZNQTJwaWtvNVlZbTdxTkpLQ3pUVTdYZEVCVStILzdudnVhZk5U?=
 =?utf-8?B?ZGxKVzdVZVM3Tm5wUU9TTVp6N2JIRk5MY0ZtZ1ZmZXMvenBQKzVMUEd4c3A3?=
 =?utf-8?B?RGhuM08vQnp0Yi9Ec0wreTFpUDlmbE9EbEd3bndMMmpCL1JscENmOHBJV0xv?=
 =?utf-8?B?QzZLK1JGWVhCMG9mUHlXS1R5QUNOYTU5bWh2TkRkQkc5ZTdkdVJMZWJaME9H?=
 =?utf-8?B?OHhMRmMvdGlJYVJUS1hlUytKNndWVzZVSG92ak1iK2xadldGWm5FSzlWbG5O?=
 =?utf-8?B?YlkxTU12NDZnNDJja0xUYkVqdXZ2QmloSmJLdFZpSUdHbjRpcXI0VDIySkxl?=
 =?utf-8?B?bVVzcThrbUFVNlZPZGpMbWV1eXVQdEtDZWd5ZG1CTEt1ZUducXQvdEN5YU9l?=
 =?utf-8?B?NHpVaG50aEh5QzRhVC9yK0FQQ3NodWdLamVsSGNJVFMrdDVOYXRXUUVXTFli?=
 =?utf-8?B?YXlHYlQ4Q0NjclAxcUFxdVJ1cnc4Y1hpTDQzQUppeFYvd0x6Q3Jxb1ZiS0lK?=
 =?utf-8?B?QmtIdTh3bUt3bnZUSENaamhwNXlEa3NYblBJRllIUExrMWx1TUtQUFk5TTY0?=
 =?utf-8?B?RTNDbGFVL1JPbVNsb3pyRlplNzNyWkVPc3daZWZrQjY2NVE2RFB3L2FEKzRF?=
 =?utf-8?B?WVcwUm5rb0lDZ1F6U0tFZXBVMjFhbGRoaUI3YUZMQzdIVk8vV3pTdGMrT3Zy?=
 =?utf-8?B?OEE3MHEyc0dRczQrL0VmWXBiQllUb0VGM3JDR1F0ZCtKWmRiZUw4QWFoQU1o?=
 =?utf-8?B?OFNhQ25kaThYSC9sVm1HczM4Ym1rRlBQa2U5dVd4TnRGMGd1aGhHaUFKa1Fo?=
 =?utf-8?B?dlE0cHNKWGdES2tWRXVBNEF0cGUyMnE4U1VBc2lRdGl5d0FvK3RBUHFTdW5Z?=
 =?utf-8?Q?oizbP+jKAUNkJAF9PehLCj5su?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173548db-7b29-43e2-4a8a-08de1e495f68
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:02:41.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Tlgddxvhdfxsi9DBX4vrVjTnZ9semahaQ1q8iY4GKySaI2B+/8iQQdefIw13O27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

Hi Aaron,

Thanks for trying the patches.

On 11/6/2025 7:24 PM, Aaron Tomlin wrote:
> This patch introduces the new resctrl interface file "io_alloc_min_cbm_all"
> to provide users with a clean mechanism to reset all I/O allocation CBMs
> (Cache-Block Masks) to their minimum configuration.
> 
> Writing '0' to this file triggers the logic to set each corresponding CBM
> to the minimum number of consecutive bits (effectively clearing them to 0
> or their smallest supported mask). This simplifies the process of clearing
> or resetting the I/O allocation state without requiring manual CBM string
> calculations and eliminating the need for multiple writes to "io_alloc_cbm".

Your patch replaces the need for

[1] # echo "0=0;1=0" > /sys/fs/resctrl/info/L3/io_alloc_cbm

Instead it does

[2] # echo 0 > /sys/fs/resctrl/info/L3/io_alloc_min_cbm_all

Both approaches involve a single system call, with no multiple writes in 
either case.

I don’t see a strong justification for keeping both options. Option [1] 
is consistent with the existing interfaces and is also efficient, so I 
don’t see the need for an additional mechanism.


> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>   Documentation/filesystems/resctrl.rst     |  13 +++
>   arch/x86/kernel/cpu/resctrl/core.c        |   2 +-
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  23 +++--
>   fs/resctrl/ctrlmondata.c                  | 117 ++++++++++++++++++----
>   fs/resctrl/internal.h                     |   3 +
>   fs/resctrl/rdtgroup.c                     |  10 +-
>   include/linux/resctrl.h                   |  30 +++++-
>   7 files changed, 165 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index ccc425b65b27..9899bc716459 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -213,6 +213,19 @@ related to allocation:
>   		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
>   		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
>   
> +"io_alloc_min_cbm_all":
> +		Set each CBM to their minimum number of consecutive bits.
> +
> +		Example::
> +
> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
> +			0=ffff;1=00ff
> +
> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc_min_cbm_all
> +
> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
> +			0=0;1=0
> +
>   Memory bandwidth(MB) subdirectory contains the following files
>   with respect to allocation:
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 3792ab4819dc..44aea6b534e0 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -276,7 +276,7 @@ static void rdt_get_cdp_config(int level)
>   
>   static void rdt_set_io_alloc_capable(struct rdt_resource *r)
>   {
> -	r->cache.io_alloc_capable = true;
> +	r->cache.io_alloc.io_alloc_capable = true;
>   }
>   
>   static void rdt_get_cdp_l3_config(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b20e705606b8..0f051d848422 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -57,14 +57,19 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>   		hw_dom = resctrl_to_arch_ctrl_dom(d);
>   		msr_param.res = NULL;
>   		for (t = 0; t < CDP_NUM_TYPES; t++) {
> -			cfg = &hw_dom->d_resctrl.staged_config[t];
> -			if (!cfg->have_new_ctrl)
> -				continue;
> -
> -			idx = resctrl_get_config_index(closid, t);
> -			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
> -				continue;
> -			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> +			if (resctrl_should_io_alloc_min_cbm(r)) {
> +				idx = resctrl_get_config_index(closid, t);
> +				hw_dom->ctrl_val[idx] = apply_io_alloc_min_cbm(r);
> +			} else {
> +				cfg = &hw_dom->d_resctrl.staged_config[t];
> +				if (!cfg->have_new_ctrl)
> +					continue;
> +
> +				idx = resctrl_get_config_index(closid, t);
> +				if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
> +					continue;
> +				hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> +			}
>   
>   			if (!msr_param.res) {
>   				msr_param.low = idx;
> @@ -123,7 +128,7 @@ int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   
> -	if (hw_res->r_resctrl.cache.io_alloc_capable &&
> +	if (hw_res->r_resctrl.cache.io_alloc.io_alloc_capable &&
>   	    hw_res->sdciae_enabled != enable) {
>   		_resctrl_sdciae_enable(r, enable);
>   		hw_res->sdciae_enabled = enable;
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index b2d178d3556e..6cbf4cfaf974 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -688,7 +688,7 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
>   
>   	mutex_lock(&rdtgroup_mutex);
>   
> -	if (r->cache.io_alloc_capable) {
> +	if (r->cache.io_alloc.io_alloc_capable) {
>   		if (resctrl_arch_get_io_alloc_enabled(r))
>   			seq_puts(seq, "enabled\n");
>   		else
> @@ -758,6 +758,50 @@ u32 resctrl_io_alloc_closid(struct rdt_resource *r)
>   		return resctrl_arch_get_num_closid(r) - 1;
>   }
>   
> +/*
> + * check_io_alloc_support() - Establish if io_alloc is supported
> + *
> + * @s: resctrl resource schema.
> + *
> + * This function must be called under the cpu hotplug lock
> + * and rdtgroup mutex
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int check_io_alloc_support(struct resctrl_schema *s)
> +{
> +	struct rdt_resource *r = s->res;
> +
> +	if (!r->cache.io_alloc.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * check_io_alloc_enabled() - Establish if io_alloc is enabled
> + *
> + * @s: resctrl resource schema
> + *
> + * This function must be called under the cpu hotplug lock
> + * and rdtgroup mutex
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int check_io_alloc_enabled(struct resctrl_schema *s)
> +{
> +	struct rdt_resource *r = s->res;
> +
> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>   			       size_t nbytes, loff_t off)
>   {
> @@ -777,11 +821,9 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>   
>   	rdt_last_cmd_clear();
>   
> -	if (!r->cache.io_alloc_capable) {
> -		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> -		ret = -ENODEV;
> +	ret = check_io_alloc_support(s);
> +	if (ret)
>   		goto out_unlock;
> -	}
>   
>   	/* If the feature is already up to date, no action is needed. */
>   	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
> @@ -828,6 +870,47 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>   	return ret ?: nbytes;
>   }
>   
> +ssize_t resctrl_io_alloc_cbm_min_write(struct kernfs_open_file *of, char *buf,
> +				       size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r = s->res;
> +	bool reset;
> +	u32 io_alloc_closid;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &reset);
> +	if (ret)
> +		return ret;
> +	if (reset)
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	ret = check_io_alloc_support(s);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = check_io_alloc_enabled(s);
> +	if (ret)
> +		goto out_unlock;
> +
> +	r->cache.io_alloc.io_alloc_min_cbm = true;
> +
> +	io_alloc_closid = resctrl_io_alloc_closid(r);
> +	ret = resctrl_arch_update_domains(r, io_alloc_closid);
> +
> +	r->cache.io_alloc.io_alloc_min_cbm = false;
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>   int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>   {
>   	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> @@ -839,17 +922,13 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
>   
>   	rdt_last_cmd_clear();
>   
> -	if (!r->cache.io_alloc_capable) {
> -		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> -		ret = -ENODEV;
> +	ret = check_io_alloc_support(s);
> +	if (ret)
>   		goto out_unlock;
> -	}
>   
> -	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> -		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
> -		ret = -EINVAL;
> +	ret = check_io_alloc_enabled(s);
> +	if (ret)
>   		goto out_unlock;
> -	}
>   
>   	/*
>   	 * When CDP is enabled, the CBMs of the highest CLOSID of CDP_CODE and
> @@ -928,17 +1007,13 @@ ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
>   	mutex_lock(&rdtgroup_mutex);
>   	rdt_last_cmd_clear();
>   
> -	if (!r->cache.io_alloc_capable) {
> -		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> -		ret = -ENODEV;
> +	ret = check_io_alloc_support(s);
> +	if (ret)
>   		goto out_unlock;
> -	}
>   
> -	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> -		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
> -		ret = -EINVAL;
> +	ret = check_io_alloc_enabled(s);
> +	if (ret)
>   		goto out_unlock;
> -	}
>   
>   	io_alloc_closid = resctrl_io_alloc_closid(r);
>   
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index bff4a54ae333..f50f1ab562b0 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -442,6 +442,9 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
>   			      void *v);
>   ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
>   				   size_t nbytes, loff_t off);
> +ssize_t resctrl_io_alloc_cbm_min_write(struct kernfs_open_file *of, char *buf,
> +				       size_t nbytes, loff_t off);
> +
>   u32 resctrl_io_alloc_closid(struct rdt_resource *r);
>   
>   #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index ea320dcf8aba..bd41ab5a8eb4 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1995,6 +1995,12 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= resctrl_io_alloc_cbm_show,
>   		.write		= resctrl_io_alloc_cbm_write,
>   	},
> +	{
> +		.name		= "io_alloc_min_cbm_all",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= resctrl_io_alloc_cbm_min_write,
> +	},
>   	{
>   		.name		= "max_threshold_occupancy",
>   		.mode		= 0644,
> @@ -2195,11 +2201,13 @@ static void io_alloc_init(void)
>   {
>   	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>   
> -	if (r->cache.io_alloc_capable) {
> +	if (r->cache.io_alloc.io_alloc_capable) {
>   		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
>   					 RFTYPE_RES_CACHE);
>   		resctrl_file_fflags_init("io_alloc_cbm",
>   					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
> +		resctrl_file_fflags_init("io_alloc_min_cbm_all",
> +					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
>   	}
>   }
>   
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 54701668b3df..7987d458ebf8 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -215,7 +215,10 @@ struct resctrl_cache {
>   	unsigned int	shareable_bits;
>   	bool		arch_has_sparse_bitmasks;
>   	bool		arch_has_per_cpu_cfg;
> -	bool		io_alloc_capable;
> +	struct {
> +		bool	io_alloc_capable;
> +		bool	io_alloc_min_cbm;
> +	} io_alloc;
>   };
>   
>   /**
> @@ -415,6 +418,31 @@ static inline bool resctrl_is_mbm_event(enum resctrl_event_id eventid)
>   		eventid <= QOS_L3_MBM_LOCAL_EVENT_ID);
>   }
>   
> +/*
> + * apply_io_alloc_min_cbm() - Apply minimum io_alloc CBM
> + *
> + * @r: resctrl resource
> + *
> + * Return: Minimum number of consecutive io_alloc CBM bits to be set.
> + */
> +static inline u32 apply_io_alloc_min_cbm(struct rdt_resource *r)
> +{
> +	return r->cache.min_cbm_bits;
> +}
> +
> +/*
> + * resctrl_should_io_alloc_min_cbm() - Should the minimum io_alloc
> + *				       CBM be applied
> + * @r: resctrl resource
> + *
> + * Return: True if the minimum number of consecutive
> + * bits to be set in the io_alloc CBM should be applied.
> + */
> +static inline bool resctrl_should_io_alloc_min_cbm(struct rdt_resource *r)
> +{
> +	return r->cache.io_alloc.io_alloc_min_cbm;
> +}
> +
>   u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id eventid);
>   
>   /* Iterate over all memory bandwidth events */


