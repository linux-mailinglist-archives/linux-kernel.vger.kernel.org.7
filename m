Return-Path: <linux-kernel+bounces-756982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C5B1BBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23117AA429
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820E2566F2;
	Tue,  5 Aug 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RI3YZvef"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020095.outbound.protection.outlook.com [52.101.85.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA24524F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429319; cv=fail; b=Lisd1TZI+9jaSB4Hjtp8hl6/X7OpCqsSFWr7CZ0Sa5jfmACU2MMOkoTzOInxD5bNN5dsZQ3Qjo4rCEoUg6bDMFXFIiwlM8R8xzWl/nenDSEp0gMLtJdl9H1TAzSKmhlwYgADTLc+b1jPdWNb7iY7y4B5w6jzNFt+XDThS3//TMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429319; c=relaxed/simple;
	bh=SXCdQPmYuBWy47jSdb/Y3D9ol6YwlmxnZJcLQPl9Ib4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=na/FsdUCTxIoikRYnGedUzbVfIIh9Jh5MhARndbs68lzebhynXZOcIJ0JWyJOF5Lp61CxqYAhVF2hnY7Y9HtkNWs04qv6AUZxL7utE5BjLy0CS3QbH9aDOMztFvZ2kqKakxqIfuCYZF9EptM8ATvGoF9rQm41FR+PkesoD8hGcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RI3YZvef; arc=fail smtp.client-ip=52.101.85.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGKABbLFvXlfT6ntziBiwgXdXlK2PWB88LxGVD9mGICOLuTn+2+Pi9GuudrGWss+4dewar5h1Kek4U1KVxqM9IQd1HlM3z4rhmZk3YpOX44N9QP+V2P4nLDld+T3Hr9rymr+ByUpaiPyPjTE+N/CKp5OsIwOzWgLPExO9Cq4zxnH+MFsXruwU/qq5u0xXT07MxXxgAXstmZcItbvuMblg+W0ZhYhwkS2mYmI25ag+0AdvfW/DcZkm60Hc3NspebpIa96iavm7oW4KgOzzLxU8B0BTG25KAIhkpEp7/Vsy2/ucyLLbRdTltItyNzm0aCa6++3S7QpJnASJGrxfUiATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++bVRVWht5tgPP2s14edo4F2flTE0DemH0X0G5IyrrM=;
 b=jVWWMX2T2qc2rufw1r9VYbcluv2k59+wFmDDkFW/cSrZuz05ybuH9kuT9eFeT+tvQlRoHKYLZXa8rghr0/UgrRlNLf+Qo2mr593ApE2rwVymrcWtkqgLWyYz2xJPlJ1X6fP3FxB+iT0VdUirylMl5aHL7zRYNVhXYTIcBi0WFDMd/8T7xY7xgFdLYyej+f2XX9G+YcKceUZb4haoOMebkt8hY5ixDFlHbo7AYSC2dW3P5EketMKYJ4xiPqE3VgpQHtOOdcmL+H9SFn8QQVLBT/PKvJUIfVwAhhzep6dBuUccwIYSSUNOppScZzu2YS4/hZhgVtuiWGJaGaIEYiDOSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++bVRVWht5tgPP2s14edo4F2flTE0DemH0X0G5IyrrM=;
 b=RI3YZvefExtZJiWP+k45TyJPWqmmI9YzV6aDMxWCaBzrY+/BGKwVuStsuzh5d4ZXtOJ1toGmeu92Uh6+mtERrzaeiOlFcSmRn86uj1nXQJJmJPJJ67FOoT2ppwJqSur6n/SnVBiTNcFQivLrAGHd67ITZr8gmRkbtoteXz4oBsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB7018.prod.exchangelabs.com (2603:10b6:610:107::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Tue, 5 Aug 2025 21:28:31 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 21:28:31 +0000
Message-ID: <da766ad7-143b-4c7c-b296-f18df8380643@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 14:28:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-4-yang@os.amperecomputing.com>
 <d9960dbc-376d-4d33-9334-e4eb546b69ae@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <d9960dbc-376d-4d33-9334-e4eb546b69ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::19) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e9343-5843-4c8c-f5ea-08ddd46705fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU5NU2tZVytJM3htdTVGd3pEaTd5OVlGamF2WUhIZlNrSDcyckdYQ1BKVGdu?=
 =?utf-8?B?MUdiS2srZEM5YWNuditHN3dpYXA4d0R1QmtzU1pQMEtVSkduOWU5UHVjTDh5?=
 =?utf-8?B?bUNoRXQwSE1tbG11OVdESkt2NFNFbzR1ckNndE9zYU1STU8wUXRJK0NrZEdl?=
 =?utf-8?B?OUpoOWhidXhpWFl6S2VJYVFrd1dCZi9iR1lURlBsUXd1bjRYM0VBZ05PdHhq?=
 =?utf-8?B?RC9uRWtVNTg3NjBhZkdZblJ5YzdiUUdWUWpGbm9qWUk0ZUNQeFNwR3RJMVh2?=
 =?utf-8?B?RkEyK09zWEJ1TTNjc3lySldJRjNkY21DV3hDT3BYLythcWFwT2ZtYjRSV25R?=
 =?utf-8?B?UE5iZXFhWWdzRmcvNy9mNXI2YXRiZlNjenFMd3FPeWJUT3B6cmxtbmhveHVW?=
 =?utf-8?B?c25Fc1dna3Q2Skhpc0NxamtWQ1o0SkErWFpTaUxkSU1zR1ZYNFlIY1lBdTlp?=
 =?utf-8?B?V3hTNzVwZ0krZENUU1NtTlYrdkEydW1WZU91U3R2Tk9NVC9KYWNLWjBNQmVa?=
 =?utf-8?B?c3U3angvdXF0cW1OMTg1WlhSRVpTcEVwS01YSndjRXN1bDhadTNkRG9RSWF6?=
 =?utf-8?B?L1hxV0p4QTFkd2Y0TjJjYWZPVGtIbXl6S3RLSDFlZGdWQkdCd245UlJaN2xu?=
 =?utf-8?B?V0QxMjU0QUY3Q2F4cVY1TkZZVjFuVSsxcmhwTHFyQXBsNUJ0WklGOTVVUm56?=
 =?utf-8?B?blQyOCs1L1ZkUGU5YnV0bHpQOXlMNWc4QTltb09yTllvY05hbHRSOHhqL1NU?=
 =?utf-8?B?RGxHNG5SalhFVUtkVlBoaDNtU2tJZVZhT3VUNnBRQVFOZlFnYmpHSlYwd2Zm?=
 =?utf-8?B?ZEtncUJKWUhxc0JvYXY2UXE5TXNZSDFZdjBjekE5TXcvREVpOHpVL0Nlb3Vv?=
 =?utf-8?B?V09meFVpMjc2UU9JUElUdkNaWHFXOStCZDBEUUMvOWJCTm95emVxRHNFUXpB?=
 =?utf-8?B?YjFqYXBmdzRMZTRIRVUrQUZjaTFiendxQzVvc1ovZno1Lzl2MTlSb2tFT1BY?=
 =?utf-8?B?N1FaNlFUcy9XWW5uTW1udkNnTGtqMjFYcWd4cXBPNkQ0UnZJemtORGlDM05U?=
 =?utf-8?B?bitJNTgrVmZZRi9rTWlDSDVOb2JtTVdLajN4dzkwT2ZzSi9mM1NTZStHQU50?=
 =?utf-8?B?MzZDbTdYQzEzYU93MFo3UUJuS3ZYWDk2cmQvbEEwYUtoOFY0Z3dIWnJtdU9r?=
 =?utf-8?B?RGNEWmF4NTI3YzdBZ3NSa1BlN1R0Nzk4cmJLRThrVFhjY2JETW1NUXhkeHhz?=
 =?utf-8?B?a3RjOWZiRjJqNVdCdFhrSHhPWUpYZWlhTENwSkJib1VCRzU0Y2x5ak5ZRWti?=
 =?utf-8?B?eFRKTmFpV3lRcVRGaG5IeFNmcDlLMjdaZnVwSUZ5T0VpZGI5UVV0TnFmNVB3?=
 =?utf-8?B?dWo0N3loaVJRUDFBZFFIdWt3dmpuUGlEQ2MrOFBqOTJiTlJpNVpwSnhhK3dZ?=
 =?utf-8?B?dEEvaEVERFVXUUMvcE1Bc2pTcFJLUnpoeWRaUGJReHFrZmVIbnpBMUYxM1A2?=
 =?utf-8?B?bUxoaTE5MFJOdFJIenlTakZlK2hhUXN5citnRU9EdnhhQ21DUXVDZWxJMS9L?=
 =?utf-8?B?bkNNZVZPTCtTc0JxRG5WZmpQbDdTTUgrRk5zaWJGSTZjMHNVcHAyV2NlcjYz?=
 =?utf-8?B?TVRIZWxpYUJIa296N3A0SFMvNkRVWjZJWGJXWjdiVnNwQTRhcktiaDhEVlVz?=
 =?utf-8?B?RiszSWI0MGJ2MGtxMVRMNGMxTmFyK0hvWkpQc0NCN2VKSGtJS1N6YnNGSUVR?=
 =?utf-8?B?T1BlT2RmbGFnQ2tzazdHZ3JVUjgwemhFWGtWWFFCU3lLWm5VbXpJSzdndkRn?=
 =?utf-8?B?TVdFUzZlOFJrUlpDNUNrK0x2R01Pd0g3SXBOalBCa0QxTlQ3T0trZlZTSlRx?=
 =?utf-8?B?SVp5RWRqS3RnOW1WaHRsV09VZkFJSG9jbldlZkVPaEI5cXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRIOUZ4S3d3MmtESUpiaVEvVTBRNEtaWjRuQWdrQUsxRmZ4ZXVrV0V0VXlM?=
 =?utf-8?B?WlR3TENtVnNHNnhqR3Q1Vm1xTWkvYVgwenphSksxUW4yWTNWL0JpMTJ2SjV2?=
 =?utf-8?B?T1ltRTdxeWlxVitlZTd6VGxFZ0s0Wm1FSXRIV1loTkhRZjhDUEFPWnNqMkRL?=
 =?utf-8?B?d3J5SGFMN1NSUU9iZ04rc1U4RENmNWVoSXFFWWVKMFlGa3RaeThienVuWlJ0?=
 =?utf-8?B?akZudkpSa3ZWK1k5SngvYkJySElKb0R1NWtQL1RmNmJTRVpGRGN4ejJwanFq?=
 =?utf-8?B?Y1dvb1MzVmc2cFRNQ1R2V2tIdTd0WHAwcTJmZGJqbys3dDZVdzNaVCt1dmpw?=
 =?utf-8?B?ZSt6NUk4cE0wTHJsR2VvalhFVENZWXRlNzdsQ042UmMvTWwwZ0hLYkNPN2Qz?=
 =?utf-8?B?ZHM1YWhBSHpzNitoYS9od1JFUVBaTGhUWEUxU1lPQ3FDZ1ZnNGZFNi8rZFFL?=
 =?utf-8?B?T1VxUDd4SWNPeHBDY21qQUx2THIveEJKOG5CbVl5aitmaXpRb1ZYQmcyd1NQ?=
 =?utf-8?B?dW1vNHhCY0h3Tk5ZdkRmbUNnMWUyT1NCUHVmT2pZaFM2eTR4NTR4UmV2b3Nh?=
 =?utf-8?B?MU5sMlJGd2xKQ1J3SWFpZVVmQnF3RE0zOEl4QllPSlRCRUpxQXZTTDNMNmtU?=
 =?utf-8?B?Zm9MUXV4Z0swSzVSV3hGcmx2OHpUNzVoQjhFSzM3ekU5UXZiQjJMSjI1VDlH?=
 =?utf-8?B?QmdEdUNUOU11YVBHclJpMVRzaUhFbUcybjBPYkw0STY4TElKSjVFeXhhdm91?=
 =?utf-8?B?WlNFNGxqZUVNaVNPNW9yd1gzdGhoQzloKzNXeTRyNWV4eHViSFNrK2Rtb2ZK?=
 =?utf-8?B?Z3NaV1FoTHFWbHNCd0ttQVdVNW9zQlF5MGhqVy9HczNzeFdQaUo4NmNNcWQ5?=
 =?utf-8?B?WmZmM3o4Z1loZkVwdWVPc2FEeFMvZnA0cjdEaHlIaE56R211ZmtRWHlMajBL?=
 =?utf-8?B?MlJNUFlzWkJsaFVDM3VqSWg1MStJYjZDOVZmeXd1WWIvUnpRMFFRdU04SkZJ?=
 =?utf-8?B?TXNyTVFSNlllR0xOSS96aW1KNDVJMkNYbkVlRjUzbDB6VFRWSnUwVjZvZ1Rp?=
 =?utf-8?B?Nm5ZUHJ6aStrVHdNeEVRS3A1SkZDTWdoM1RreUFvVGpZZThWd0JIT2pLeHpG?=
 =?utf-8?B?WGJ4ejhqNXNEN2VtZENwNUs3YWd2Wmh6ZUZQcDFKVDhoQWVjdVIzRkZyaEd5?=
 =?utf-8?B?NGRlVjBlQXRiQ3NJdkMveFZyd29sTHA1SXMyaWkybkNTRitTZDA2TTc0cVFl?=
 =?utf-8?B?a2hWMGlTMzQvbGptYkd1QkFtT2lwZW44YXA0ZjBDVzYrU0orR0toUVBRUlhk?=
 =?utf-8?B?S3BlOVNxVXJiZGRRdUZlclNoOHFyWVNrMGExRTVqdFNnMnlkclYyN0RSTkJL?=
 =?utf-8?B?NXY1eDFKVFA0NFo1SDM1d2prRUVUeDVNMDgyblZUVDV3WThoVFc1bTZoUXpV?=
 =?utf-8?B?M2p4R3JvWUs3OHJFaVRlS0VMV203T2lpYWVwSmVudHQvT0ZKemk5VXc0V2hV?=
 =?utf-8?B?TExVR3kxVDZLcmRmTEtic091OTZRMFhZb2NZWExhVXhvaDl1TVllNjBoSm0v?=
 =?utf-8?B?TC9xN2hlYkxwZmVLUUxXdmJvcFJNUEZDK2dteS8ycS9pZUk5cnIrbllPSGxp?=
 =?utf-8?B?T015NSs2d2lVVHVLTmJ1ZkxYWnl6aDlrMFBjcDRGQXRoWmo1N2g4OUVJNjRi?=
 =?utf-8?B?UmxLQk1yc0hzcm8wdnBaeFJKdFd4Q1BQdHRlZUt6NjZtYnMreVVkQ3BRT2JS?=
 =?utf-8?B?UDJFYnpQdmoyL1ZaVzdWMWpobzZIdis1VEVHbzM0SkQxUE1idWJ1dERlK0t5?=
 =?utf-8?B?MEQ0N3FtYXJyb2pSMEpFUkdDV2c2dmliTDZXS1QvVDFobFEwbjZRcFN5V3RT?=
 =?utf-8?B?OExEcDBHZ0w2VFlEdEdONnZQeGh5U2gwWDB5QlBBdkhvNXlVTWlEUGFJTHF1?=
 =?utf-8?B?c3hZZGRDU1AxV0M3eW81ZDBPdmZjN0svaXJUZUpRWUVUeGQ2dldzaE5SRnFh?=
 =?utf-8?B?cFpYd2pQU0tUZStCRWVNTWNMSGxaK3hDaklUZmJVZUhGMFh5UklWODdBcHNB?=
 =?utf-8?B?Z0I1ck84VDl5aE1OclZZMk9nTWpaaGYrZE1OTGZUMkdjajhJZlFNRlVTbTVG?=
 =?utf-8?B?cHZmYmlVWmpTYnUrNUtEajBpWEx6UmR2LzRBL0xPQWhvZk1lREVxNnpzeTIr?=
 =?utf-8?Q?ezFtj/7uOJx6NqDW4OG1Xoc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e9343-5843-4c8c-f5ea-08ddd46705fc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:28:31.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqYcDbkTpISk7C/ssfBgQlQ3D8GPVt0cDQI03sWHefFn6haoOm9W/inRkJRT8JpKfL8zq1Ed3LB/XzmhKxObje8jKb0GV4h3ornH0Urnejw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7018



On 7/29/25 5:34 AM, Dev Jain wrote:
>
> On 25/07/25 3:41 am, Yang Shi wrote:
>> [----- snip -----]
>>     #ifdef CONFIG_ARM64_PAN
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 3d5fb37424ab..f63b39613571 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -480,6 +480,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, 
>> phys_addr_t phys, unsigned long virt,
>>                    int flags);
>>   #endif
>>   +#define INVALID_PHYS_ADDR    -1
>> +
>>   static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>                          enum pgtable_type pgtable_type)
>>   {
>> @@ -487,7 +489,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct 
>> mm_struct *mm,
>>       struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & 
>> ~__GFP_ZERO, 0);
>>       phys_addr_t pa;
>>   -    BUG_ON(!ptdesc);
>> +    if (!ptdesc)
>> +        return INVALID_PHYS_ADDR;
>> +
>>       pa = page_to_phys(ptdesc_page(ptdesc));
>>         switch (pgtable_type) {
>> @@ -509,15 +513,29 @@ static phys_addr_t __pgd_pgtable_alloc(struct 
>> mm_struct *mm,
>>   }
>>     static phys_addr_t __maybe_unused
>> -pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>> +split_pgtable_alloc(enum pgtable_type pgtable_type)
>>   {
>>       return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>>   }
>>   +static phys_addr_t __maybe_unused
>> +pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>> +{
>> +    phys_addr_t pa;
>> +
>> +    pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
>> +    BUG_ON(pa == INVALID_PHYS_ADDR);
>> +    return pa;
>> +}
>> +
>>   static phys_addr_t
>>   pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>>   {
>> -    return __pgd_pgtable_alloc(NULL, pgtable_type);
>> +    phys_addr_t pa;
>> +
>> +    pa = __pgd_pgtable_alloc(NULL, pgtable_type);
>> +    BUG_ON(pa == INVALID_PHYS_ADDR);
>> +    return pa;
>>   }
>>     /*
>> @@ -552,6 +570,254 @@ void __init create_pgd_mapping(struct mm_struct 
>> *mm, phys_addr_t phys,
>>                    pgd_pgtable_alloc_special_mm, flags);
>>   }
>>   +static DEFINE_MUTEX(pgtable_split_lock);
>
> Thanks for taking a separate lock.
>
>> +
>> +static int split_cont_pte(pmd_t *pmdp, unsigned long addr, unsigned 
>> long end)
>> +{
>> +    pte_t *ptep;
>> +    unsigned long next;
>> +    unsigned int nr;
>> +    unsigned long span;
>> +
>> +    ptep = pte_offset_kernel(pmdp, addr);
>> +
>> +    do {
>> +        pte_t *_ptep;
>> +
>> +        nr = 0;
>> +        next = pte_cont_addr_end(addr, end);
>> +        if (next < end)
>> +            nr = max(nr, ((end - next) / CONT_PTE_SIZE));
>> +        span = nr * CONT_PTE_SIZE;
>> +
>> +        _ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>> +        ptep += pte_index(next) - pte_index(addr) + nr * CONT_PTES;
>> +
>> +        if (((addr | next) & ~CONT_PTE_MASK) == 0)
>> +            continue;
>> +
>> +        if (!pte_cont(__ptep_get(_ptep)))
>> +            continue;
>> +
>> +        for (int i = 0; i < CONT_PTES; i++, _ptep++)
>> +            __set_pte(_ptep, pte_mknoncont(__ptep_get(_ptep)));
>> +    } while (addr = next + span, addr != end);
>> +
>> +    return 0;
>> +}
>> +
>> +static int split_pmd(pmd_t *pmdp, unsigned long addr, unsigned long 
>> end)
>> +{
>> +    unsigned long next;
>> +    unsigned int nr;
>> +    unsigned long span;
>> +    int ret = 0;
>> +
>> +    do {
>> +        pmd_t pmd;
>> +
>> +        nr = 1;
>> +        next = pmd_addr_end(addr, end);
>> +        if (next < end)
>> +            nr = max(nr, ((end - next) / PMD_SIZE));
>> +        span = (nr - 1) * PMD_SIZE;
>> +
>> +        if (((addr | next) & ~PMD_MASK) == 0)
>> +            continue;
>> +
>> +        pmd = pmdp_get(pmdp);
>> +        if (pmd_leaf(pmd)) {
>> +            phys_addr_t pte_phys;
>> +            pte_t *ptep;
>> +            pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN |
>> +                      PMD_TABLE_AF;
>> +            unsigned long pfn = pmd_pfn(pmd);
>> +            pgprot_t prot = pmd_pgprot(pmd);
>> +
>> +            pte_phys = split_pgtable_alloc(TABLE_PTE);
>> +            if (pte_phys == INVALID_PHYS_ADDR)
>> +                return -ENOMEM;
>> +
>> +            if (pgprot_val(prot) & PMD_SECT_PXN)
>> +                pmdval |= PMD_TABLE_PXN;
>> +
>> +            prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) |
>> +                    PTE_TYPE_PAGE);
>> +            prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +            ptep = (pte_t *)phys_to_virt(pte_phys);
>> +            for (int i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>> +                __set_pte(ptep, pfn_pte(pfn, prot));
>> +
>> +            dsb(ishst);
>> +
>> +            __pmd_populate(pmdp, pte_phys, pmdval);
>> +        }
>> +
>> +        ret = split_cont_pte(pmdp, addr, next);
>> +        if (ret)
>> +            break;
>> +    } while (pmdp += nr, addr = next + span, addr != end);
>> +
>> +    return ret;
>> +}
>> +
>> +static int split_cont_pmd(pud_t *pudp, unsigned long addr, unsigned 
>> long end)
>> +{
>> +    pmd_t *pmdp;
>> +    unsigned long next;
>> +    unsigned int nr;
>> +    unsigned long span;
>> +    int ret = 0;
>> +
>> +    pmdp = pmd_offset(pudp, addr);
>> +
>> +    do {
>> +        pmd_t *_pmdp;
>> +
>> +        nr = 0;
>> +        next = pmd_cont_addr_end(addr, end);
>> +        if (next < end)
>> +            nr = max(nr, ((end - next) / CONT_PMD_SIZE));
>> +        span = nr * CONT_PMD_SIZE;
>> +
>> +        if (((addr | next) & ~CONT_PMD_MASK) == 0) {
>> +            pmdp += pmd_index(next) - pmd_index(addr) +
>> +                nr * CONT_PMDS;
>> +            continue;
>> +        }
>> +
>> +        _pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>> +        if (!pmd_cont(pmdp_get(_pmdp)))
>> +            goto split;
>> +
>> +        for (int i = 0; i < CONT_PMDS; i++, _pmdp++)
>> +            set_pmd(_pmdp, pmd_mknoncont(pmdp_get(_pmdp)));
>> +
>> +split:
>> +        ret = split_pmd(pmdp, addr, next);
>> +        if (ret)
>> +            break;
>> +
>> +        pmdp += pmd_index(next) - pmd_index(addr) + nr * CONT_PMDS;
>> +    } while (addr = next + span, addr != end);
>> +
>> +    return ret;
>> +}
>> +
>> +static int split_pud(p4d_t *p4dp, unsigned long addr, unsigned long 
>> end)
>> +{
>> +    pud_t *pudp;
>> +    unsigned long next;
>> +    unsigned int nr;
>> +    unsigned long span;
>> +    int ret = 0;
>> +
>> +    pudp = pud_offset(p4dp, addr);
>> +
>> +    do {
>> +        pud_t pud;
>> +
>> +        nr = 1;
>> +        next = pud_addr_end(addr, end);
>> +        if (next < end)
>> +            nr = max(nr, ((end - next) / PUD_SIZE));
>> +        span = (nr - 1) * PUD_SIZE;
>> +
>> +        if (((addr | next) & ~PUD_MASK) == 0)
>> +            continue;
>> +
>> +        pud = pudp_get(pudp);
>> +        if (pud_leaf(pud)) {
>> +            phys_addr_t pmd_phys;
>> +            pmd_t *pmdp;
>> +            pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN |
>> +                      PUD_TABLE_AF;
>> +            unsigned long pfn = pud_pfn(pud);
>> +            pgprot_t prot = pud_pgprot(pud);
>> +            unsigned int step = PMD_SIZE >> PAGE_SHIFT;
>> +
>> +            pmd_phys = split_pgtable_alloc(TABLE_PMD);
>> +            if (pmd_phys == INVALID_PHYS_ADDR)
>> +                return -ENOMEM;
>> +
>> +            if (pgprot_val(prot) & PMD_SECT_PXN)
>> +                pudval |= PUD_TABLE_PXN;
>> +
>> +            prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) |
>> +                    PMD_TYPE_SECT);
>> +            prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +            pmdp = (pmd_t *)phys_to_virt(pmd_phys);
>> +            for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
>> +                set_pmd(pmdp, pfn_pmd(pfn, prot));
>> +                pfn += step;
>> +            }
>> +
>> +            dsb(ishst);
>> +
>> +            __pud_populate(pudp, pmd_phys, pudval);
>> +        }
>> +
>> +        ret = split_cont_pmd(pudp, addr, next);
>> +        if (ret)
>> +            break;
>> +    } while (pudp += nr, addr = next + span, addr != end);
>> +
>> +    return ret;
>> +}
>> +
>> +static int split_p4d(pgd_t *pgdp, unsigned long addr, unsigned long 
>> end)
>> +{
>> +    p4d_t *p4dp;
>> +    unsigned long next;
>> +    int ret = 0;
>> +
>> +    p4dp = p4d_offset(pgdp, addr);
>> +
>> +    do {
>> +        next = p4d_addr_end(addr, end);
>> +
>> +        ret = split_pud(p4dp, addr, next);
>> +        if (ret)
>> +            break;
>> +    } while (p4dp++, addr = next, addr != end);
>> +
>> +    return ret;
>> +}
>> +
>> +static int split_pgd(pgd_t *pgdp, unsigned long addr, unsigned long 
>> end)
>> +{
>> +    unsigned long next;
>> +    int ret = 0;
>> +
>> +    do {
>> +        next = pgd_addr_end(addr, end);
>> +        ret = split_p4d(pgdp, addr, next);
>> +        if (ret)
>> +            break;
>> +    } while (pgdp++, addr = next, addr != end);
>> +
>> +    return ret;
>> +}
>> +
>> +int split_kernel_pgtable_mapping(unsigned long start, unsigned long 
>> end)
>> +{
>> +    int ret;
>> +
>> +    if (!system_supports_bbml2_noabort())
>> +        return 0;
>> +
>> +    if (start != PAGE_ALIGN(start) || end != PAGE_ALIGN(end))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&pgtable_split_lock);
>> +    arch_enter_lazy_mmu_mode();
>> +    ret = split_pgd(pgd_offset_k(start), start, end);
>> +    arch_leave_lazy_mmu_mode();
>> +    mutex_unlock(&pgtable_split_lock);
>> +
>> +    return ret;
>> +}
>> +
>>       /*
>
> --- snip ---
>
> I'm afraid I'll have to agree with Ryan :) Looking at the signature of 
> split_kernel_pgtable_mapping,
> one would expect that this function splits all block mappings in this 
> region. But that is just a
> nit; it does not seem right to me that we are iterating over the 
> entire space when we know *exactly* where
> we have to make the split, just to save on pgd/p4d/pud loads - the 
> effect of which is probably cancelled
> out by unnecessary iterations your approach takes to skip the 
> intermediate blocks.

The implementation is aimed to reuse the split code for repainting. We 
have to split all leaf mappings down to PTEs for repainting.

Now Ryan suggested use pgtable walk API for repainting, it made the 
duplicate code problem gone. We had some discussion in the other series.

>
> If we are concerned that most change_memory_common() operations are 
> for a single page, then
> we can do something like:
>
> unsigned long size = end - start;
> bool end_split, start_split = false;
>
> if (start not aligned to block mapping)
>     start_split = split(start);
>
> /*
>  * split the end only if the start wasn't split, or
>  * if it cannot be guaranteed that start and end lie
>  * on the same contig block
>  */
> if (!start_split || (size > CONT_PTE_SIZE))
>     end_split = split(end);

Thanks for the suggestion. It works for some cases, but I don't think it 
can work if the range is cross page table IIUC. For example, start is in 
a PMD, but end is in another PMD.

Regards,
Yang

>
>
>


