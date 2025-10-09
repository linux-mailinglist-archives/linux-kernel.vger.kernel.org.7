Return-Path: <linux-kernel+bounces-847426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40CBCACD5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 175494ECECB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143026F471;
	Thu,  9 Oct 2025 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="C91gBTCO"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022122.outbound.protection.outlook.com [40.107.209.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC21E511
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041600; cv=fail; b=SGhGbqMIkgBtF8qTEIe/JYw+X5JjXyOF7oWzSwdw4dwS9n1r15aCVqT1HhF/OfFPgZ27hxfcOZQYQkvG1mjpkHKDjn9IiWHilxsn91fyQqiZuEHaFcHC4UC0/wvaGxzg6Nv+dBR8c9mb0nvTp+k00moQDFW5q5kiB+LfUNUSvAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041600; c=relaxed/simple;
	bh=qxKAL1ZH0YB9mBJbrLP4igB5oM4yxQKMQZQ/oXlqgOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmShxKBlcKCLwEBaPKEVYCEIJ6t0QfoPDjZ82U1kAPZInjB9W9PV/43xjIPCt0m6pV4xTAHyhcNa+j/hwAxxQDMHACa4NVJbTM5ecdN/VcjCQYqt4fFvTHxKMl/ENbHoq8rujBYKvJAAGMdNYqCxhSVr34GQ83pjJ0/lr3Op4WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=C91gBTCO; arc=fail smtp.client-ip=40.107.209.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDowGMfuAFB1gDjEctaw+f0DwsQMvdU+BBKP6xAaZgdUS/Xx7JIbTpXm/ysSNPpbNUqqGKCwS8qZsHz541pbYI5N7EOAtt9U3/X536vb5xsCD5hHtGz+g0fUUQqZye7LArwNT8TPI25aGxSyimWQqB21rF+3m5TFSdjjnHTXGmSzeCgGRDgoEQvghyjg22BTStJy0A6/nKlRduHl5egsHPP93NLrBhZwhWRTxaGVGet5BVfAvFYEBwTmpqZFLgqUAZeSPTvNiQo9uf3hNZdbQxDSDbYJu2dBy+Wb7e9j+OD3D3ZK4AkVi3HbsJcK3tpZH7r5lQLriSe8HA98NirplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znM+yI2K75ED8uygkE3XR60bhcolzgE77OUBIYPG6GU=;
 b=e3lXEY9qSONRNdiXTxMB+v+VFTXcz43Jmf3Nge1055IjiVHxKN4uissSBUVwuVLp0lX53Ey7wCf9rbE5jKrlabYv5Q0TCU+oU6T71eyUcOfi4hfu/rdhnPfoPHA6/XaiWV5ryTncvdVLXt9DzkjhSoO5V4ugWsG3JiKcIV3qnAcTRTykGe0Lx7WG205qG5lbEWzqbK84+mbco6Du1SFRyq0bDEzSaLi/9V4I7UwKaK+WJp9+/GeuacfQs5FMDwLR0X3XG6wo+a9LadoZfU5p5NIgQIzxceYmjdiBrlXRyRKoCok6K5dDYpaIf7JAOpCKFzeo89yR77OZv6aNw/92Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znM+yI2K75ED8uygkE3XR60bhcolzgE77OUBIYPG6GU=;
 b=C91gBTCOV+yM+wKtXAO1zpeDvMx3b+xLVb0YqDG2YHaZF8OjJbadgdGHC91uYkOjBA666AjXaL61uQX92yUlJ2+6M+RvAWdPLg1yTEZP0BbyIqL2klIv20OrEPZqoCjrDGkIDCj+fevdIW2cxKh6mbHoz0DNh3gvMkbiFyx9Xo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CY1PR01MB9222.prod.exchangelabs.com (2603:10b6:930:fe::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 20:26:32 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 20:26:32 +0000
Message-ID: <831e9e0c-a61b-40d8-a8d2-747b760ba6b3@os.amperecomputing.com>
Date: Thu, 9 Oct 2025 13:26:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: pageattr: Explicitly bail out when changing
 permissions for vmalloc_huge mappings
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: gshan@redhat.com, rppt@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, tianyaxiong@kylinos.cn, ardb@kernel.org,
 david@redhat.com, ryan.roberts@arm.com, urezki@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250328062103.79462-1-dev.jain@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250328062103.79462-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0256.namprd15.prod.outlook.com
 (2603:10b6:930:66::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CY1PR01MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: b09976cf-948b-48c9-c5c3-08de0772227b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFZQQXFlb2ZjNU1UYWhFVjc3LzMzUUlzNGdvbnN5T2lvcm1mZk1ET3VwK0FY?=
 =?utf-8?B?YTRrcEhDM29lQzBxUVhpakVnb3FrK3AweVIvZXh2aVg4VWxPbmtUZmhYYTZu?=
 =?utf-8?B?aWFLY1hHV3BaZk54OE9TU24wUTkxb3gvOEMxek1CNmQ0OGRPcFg0d2lNVE9l?=
 =?utf-8?B?RTR1VWwycXd4aW5EYmxGWTVoY1V1NkxCT2o0Y01ybVlTdUVJMmtBLzc5djNw?=
 =?utf-8?B?RHlUalBnaFlaK1Y3dW9aZWpPMVhvWmJSWnhqN3ZhY0dpT1k3TXVLcWpGSnpw?=
 =?utf-8?B?TDRWd2l0L1RiNGY4S0JiNERUUUVoVkxCejhWTG9mc0ExUmJnTEFxOVlxcjVB?=
 =?utf-8?B?K0VvNDBMUm5YTVIrNENWdHhVV1oreEhIL3IxZ0NmYzZXOHBLU091Z0RWNTd1?=
 =?utf-8?B?NXBwbzlvU0pxb05xWmU4c1hqN0djWjV3MThpRjFMaGxXayt4SmxPcHpBRHEv?=
 =?utf-8?B?K25hQ0FreVRXeWV1YXd1K3Z0M29pcE5HZlZyTDZQRFMwOXJQM3d4RHRQajFv?=
 =?utf-8?B?RURTeFF5MG1Xdnp5ZzhiRDhOQklHRlczRTFrcVFUS3p2VG1oaytBaEw0RzUz?=
 =?utf-8?B?c2tVQ2tBdjdYRWt3TVVXTTl0UE9mTFc5NnpSWFhWdnFJaFpBK2NXZ05FWlNS?=
 =?utf-8?B?SFNCQk0yK1YzdlppZE9Kc09abkNCWHQwb2VkZzRpZmJ0Ry92ZjNFb1ZINzBk?=
 =?utf-8?B?d052U2gyc2tESWFVQWpCamtSdU04NUtwZzVoemFHeGZ5Vjdya0VQYnUzUXo0?=
 =?utf-8?B?ckh0dEQwOFI5U3ppOXQ1UnU1OGJ2bnBrRnF6UExiZDhwWERWWFVLS29ZZDJj?=
 =?utf-8?B?bnpMWUZhNFM5UHU4QVNUdXZpVTllbW1ZMzA3K1BLaU9FUzY5aTBYWno5SHVp?=
 =?utf-8?B?ZjRsMVJUZGU1VG82dWdWemk2VFpBaHJQc2NKaTJMemE3cnA1M1VOclBuQjJn?=
 =?utf-8?B?SEg1RDF2NkZaSlJnNTZ1bWRtT3hNcmJYaDZacVpwTWV1UjBETHdjNDNmdW16?=
 =?utf-8?B?WFdzbFJKcjd2ZXQ3RzFxSlZUbDlLeGV5c040RG03TTZzMGNhZFBKQTBZR0Fy?=
 =?utf-8?B?VEcxZE0wZDg0cE90WXdOSmhyUFQxMnZGSnE0K2J2aGZTQTVDTHlCSzF4Sy9Z?=
 =?utf-8?B?M2Z4eDRZVzAyMHcyWmZ6WmgyQXFOWTUyK3VKOFF1UU11MUdtU052NmZGdFRm?=
 =?utf-8?B?d0t5V3hQZjByVlJBMEtlZUh1bzVGYnRhODdldlBNUTBFM01uaEFjREhWb1B0?=
 =?utf-8?B?ZDhpQjgySnlZUC95RUNDa3JaRjIyejRSY0M4a092R0R6R21BNEh3QzY3Y3RO?=
 =?utf-8?B?bzhiMXRWS0pSSGpmZTdjK2tIa1hPaDFWR2pNUWQ3NVpTSWVNN1hWVGEvYkdq?=
 =?utf-8?B?N2hIY01jRXBXU3YvMFY2WlVPQWZabDdMSk84bFlUQ0xDVTlJRkhzODcrL01V?=
 =?utf-8?B?THpWdDRnVXd4eDBBcnViWW5xTkJUb0VxakJQSGxaQ2xOUVl0N2I2cEJIMk9i?=
 =?utf-8?B?dE8rYlVvMWtXM25IVmFjTndFdFlheDdjQVpveWEvWHdHcXVXWVFLdkg4T3lV?=
 =?utf-8?B?MFgyQVZ2L0ZIWDdvUURGbjdEaWZCNlpRMmloVzdVcmNRcE92dEwrU2VMOEhV?=
 =?utf-8?B?SXNqNWF6SzVvNUFXNXpGbUhGNEVzaGRvKzV3cmZxVmRidit2RVN3MlAwVlVs?=
 =?utf-8?B?Rm1kZWRTNDdCTWJ0aHJJKzl3TklHMHFkSzJGOFJXUXRjbXRiRlp2YVFHY0pE?=
 =?utf-8?B?Y05Gb1Fxdy82NDZoaEdLeTlWRUNiWGlDSWxnb2RaYnRhNXJyNm0zWE9xS0pJ?=
 =?utf-8?B?MnVrY2Z4SDhsdjl0SGFLekhQdFhGZzVMSVA4K3d4MitJdElxZ2NGRml2M1BH?=
 =?utf-8?B?NzV4U1JrYzlnSXlYb0ZYYm9RTGdEbWVUV3cvY2dFbEV2Z0tLRWdLY2M3Y1px?=
 =?utf-8?Q?bmw+/j2X5NZxpIY8bW2Fnii8KH1NDjV8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXlueUlNMFQvdVpLL2pFU251SmJNOTJsRjBJajk5RHNwWHVyelZzZm0xODV4?=
 =?utf-8?B?dnZPeElGNnRvU05XR2FtRlZFSC9VdWFFeHZCcVdINk85TlVyRDRSWFNMVFp2?=
 =?utf-8?B?bXBkYkFCQU9yaTJvWkc5bm53dWxzQkNRWUpWUElTdnA5VWR2TXJ4YmNFZXFp?=
 =?utf-8?B?eWd4RXppMkJkTXUyYkM0UUUrc1ZTblQ5S3ZhQjJmcGFIc1p3c25obHNvdzlP?=
 =?utf-8?B?OWxtUm1pRHVNbFdHdHRBYkJyMVByTDIyNzdyZTFqWUxneVMwaDZpcTl6RHFn?=
 =?utf-8?B?U2FKaUhpOXlpWGlGODJCK1Exa2Rvdno1Tm5iaFI2V3BSVFVkdE8zN2xGblZI?=
 =?utf-8?B?dmsxSmFmR3VNSDhvUnI2bjlUVTRmOHEzZ1JIYmFkZXh4Z29NL1craVg5d2pP?=
 =?utf-8?B?YVpEVm9xOXk2MEdaZWZNYXlkNXRMRmU3eDE5UXk0MmpjMXdnbk5YenFxVWo1?=
 =?utf-8?B?am9HV3dJOUk5RHNnTHE0ZHgyR3lRK3puQ1VPd2R2ejhPU3pLZFp3ZUl1QW1Z?=
 =?utf-8?B?NlgwUkd1M05pUzFUUFZhcS95WTNPZUdmaHJnZlFJanlRRWRMSUZjT240cWpu?=
 =?utf-8?B?SjFab3ByS3BPYmNhbTdDN1VwODNMc3RkTDBtVlMxN1BRYzA5NHdXTk9oSE5l?=
 =?utf-8?B?U0NNa0hNeHF1SUxIa3BaSzlTazFzTmRiVkJHQ3FMQU4yMm43dVN3SUk5YXFN?=
 =?utf-8?B?ZDdHZ0p3VS90ejhlbTFWTG5GV0lwdmg5R1lkalBOaFRpTUpMZVl0YjBYVDU5?=
 =?utf-8?B?dEdEdStCK0xBWEg0TlJvckpyc2NNNU9OeCs2OHlnb3R3elluQlFZOHhHWFQ2?=
 =?utf-8?B?bGNqZXFhakFjQlRBSnhMN1B2Q3pKMFFDd1B6VEQ2WWtET3hmbWFjNXVoWi81?=
 =?utf-8?B?VzlmK1E1Qk4wdG8yOW5NOGZ5c0tNTWJPU0NoWEhrcGdIU3gzMC84bGJSbFd6?=
 =?utf-8?B?Q1oxWkYrUGZaVVZlMHZCSEwraXZnZDBxYTZlN3g4UlRiSmFXK0JFT0NtOU9B?=
 =?utf-8?B?UWF2M2xPdDUwVzNuTmNacFpjTnVKdWZQdkxucXd0Q01xNGloSC91VWQwSjEv?=
 =?utf-8?B?ck8rdWxYZ2ZMeGJ0d3RhUG5scGtkZVpNL1RQQk5HM0d0L05abmM0dlk2d2g0?=
 =?utf-8?B?SWhCdGQrYU8xMjhlbTVDTGlUVlBMejkvNC83ZUhLQVZpb2M2SGNMTlg4eFhV?=
 =?utf-8?B?L0JzR2IwdEZOZFlIQjc2OThGTUY5eFQ2T0FHQkhsUElyUnZxSFpKbmk1dlBL?=
 =?utf-8?B?cVNxU1pmVHlwNUIrWkR3c0pXV0RuK3BUeDN3R2lOOGdEME9jMGppckc1a0Vv?=
 =?utf-8?B?K2huenVaWEpUbEtoRXV0OElHdWpac2xvdGlRd0JnQklCa1p1azF5aExDQVlW?=
 =?utf-8?B?YmpZcFlHN3VoeEtTS2NEa1ROeG4rbGdWcFR4SlFFOW03SUQ1VjNHMnEzakVh?=
 =?utf-8?B?TlZFM0RhempWcnRuUFo3cVo3by9xbDA5UzBIdE9rTjhKQ0dBaWZDNUlDbHM5?=
 =?utf-8?B?WElhTkp4a2FzUXR2Y1lyaE52UnBwZ2NuZmd0aVV6RlhKaFhhQjZUdThOTUMx?=
 =?utf-8?B?MFJHZ0RXeDB2SGFJekxBdXBQUC9HcGsra0VLVWgxSkpFN2lRRmpHVXNCTVRh?=
 =?utf-8?B?THdRRFk1Qi9EMm9wbjJVWXJCT3BxRUxLWHZNVzV2cnBicXpieGpoai9NWXJ6?=
 =?utf-8?B?UVVEUjJNRUkxYko4dk11eldjTW1aYWJiSU54M2g0bXc0Qy9Zbk9TU0V6aXhj?=
 =?utf-8?B?L0dhaXN0WVlIdDJXaGZCOVZ1OXB2UFNIQUhOMkFJbmFmYU9Ccm1wRW85bXZN?=
 =?utf-8?B?dUw4bUdJL0VoMHliYkVLTWVoOStNY2oxNkowV0Q4WjhHMUU2a1J4ejJlRnVK?=
 =?utf-8?B?TkhKem5ZdEJEcXR6OXE2WHhtdWhKTjdvc29tanRYNFF6VUJGbHRHSFQzSzRI?=
 =?utf-8?B?NWJKZXFLMWhodEIyNWc4bS9LbThnWEhQeStjUjRMTnFuS2dNTW9BVWVMT3Vn?=
 =?utf-8?B?ZGZtenJUUVNmL0FVMFZTVjNscTRPaTBiUjFWWitvSGFYY3plOExHV1R0bm9V?=
 =?utf-8?B?NitORkFkdnhCa2pnSFdFQzVORExObC8rdWI1YTl0T2pEMWdYd0lQa05JcG1N?=
 =?utf-8?B?OVVRVjI5ZDRZRmdZM0Z0VFdLU2xpZHoxN292UnZXNGoydHlPRW1adytvT0NN?=
 =?utf-8?Q?OT7sZUStgSkMMVgQWjD724E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09976cf-948b-48c9-c5c3-08de0772227b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:26:32.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksaa4ZC4HJg0oaKwRl3232NWunJZlCbMSAbcEtt4CtY1wqwurThPJqJBGsNE51D5QyUPCrdaSVN/9R5mKhTRHoaa8yAP4P/U2DUeKaaPT/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9222



On 3/27/25 11:21 PM, Dev Jain wrote:
> arm64 uses apply_to_page_range to change permissions for kernel VA mappings,
> which does not support changing permissions for leaf mappings. This function
> will change permissions until it encounters a leaf mapping, and will bail
> out. To avoid this partial change, explicitly disallow changing permissions
> for VM_ALLOW_HUGE_VMAP mappings.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   arch/arm64/mm/pageattr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 39fd1f7ff02a..8337c88eec69 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -96,7 +96,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	 * we are operating on does not result in such splitting.
>   	 *
>   	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
> -	 * Those are guaranteed to consist entirely of page mappings, and
> +	 * Disallow VM_ALLOW_HUGE_VMAP vmalloc mappings so that
>   	 * splitting is never needed.
>   	 *
>   	 * So check whether the [addr, addr + size) interval is entirely
> @@ -105,7 +105,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	area = find_vm_area((void *)addr);
>   	if (!area ||
>   	    end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
> -	    !(area->flags & VM_ALLOC))
> +	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>   		return -EINVAL;

I happened to find this patch when I was looking into fixing "splitting 
is never needed" comment to reflect the latest change with BBML2_NOABORT 
and tried to relax this restriction. I agree with the justification for 
this patch to make the code more robust for permission update on partial 
range. But the following linear mapping permission update code seems 
still assume partial range update never happens:

for (i = 0; i < area->nr_pages; i++) {

It iterates all pages for this vm area from the first page then update 
their permissions. So I think we should do the below to make it more 
robust to partial range update like this patch did:

--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -185,8 +185,9 @@ static int change_memory_common(unsigned long addr, 
int numpages,
          */
         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
                             pgprot_val(clear_mask) == PTE_RDONLY)) {
-               for (i = 0; i < area->nr_pages; i++) {
-  __change_memory_common((u64)page_address(area->pages[i]),
+               unsigned long idx = (start - (unsigned long)area->addr) 
 >> PAGE_SHIFT;
+               for (i = 0; i < numpages; i++) {
+  __change_memory_common((u64)page_address(area->pages[idx++]),
                                                PAGE_SIZE, set_mask, 
clear_mask);
                 }
         }

Just build tested. Does it look reasonable?

Thanks,
Yang


>   
>   	if (!numpages)


