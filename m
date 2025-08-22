Return-Path: <linux-kernel+bounces-781590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45422B31464
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03A31C25579
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533952F7455;
	Fri, 22 Aug 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="VNi+Hyga"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412102F0C43
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856092; cv=fail; b=RVt1S/ti8c8cvu7MNjPJ/TsroJsQcBEzXosSnFjXPXCN8i1u2upagbNzWS1ytUNUb36mcH98UlIEpwu7xBK0vbZ/Z4j/cImnN1C39uw7TBakohbNJgpWRRK3LSxDnPynXBWzxHk/iwG5Rk7Ggb9fqlR9+ZX401oy64TuWfDaMkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856092; c=relaxed/simple;
	bh=xF0SznCgg12DxTYJX4C0EGAAROU/5kaa/AanhyGZZ6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FuepnqKPLmzIBLoy47GgJlYiENEUQesFitMS3Xxj2MZcmCBQcMMF/0Rx7ylGRXp7r8n+QoEyI3c6QxUaKESv8sqSZPrQSg0DaaKotaZK5I+oJvMRKleZEuCPi7aZTHQM7nAId7LGKx++nwEj05lN5vNDwcu91z5pYwpYAXZn2x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=VNi+Hyga; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjH+RIqB9GC7AtlgQG6DS7xYqzDX0Pf9vOo7OhOO9Emhk9B5JnUOvO4LOfF1sVDYSP7yY4ngMHnBh7nhRzBrWkxa3Sf322T8v63TotXHiP/DaW9SRrGIc90rglgZuO/O+i6Vd3Oj9PLmY28+ejLYI0rMnY9muOHpYN1h8c67DPRhJz/pVWhZ3MO9WnQNaRY8z8o/DrqAUiciWlXGMe51LWk8l4ChGoIQa5jTLxLmvnQdFIPCzOpa/QEdV/JN8kFlp/MyglHAo/XzjO0tCZqdXIhXa/WGm1xmrjzk3Jdq/dgMENCnHic8CKJSAzH2Pt0wRfDlNevmpkTm7FBo4rDL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO3P+RseHi1IEJiaEerKsCyCYkDSgCrymSHVcewWrz8=;
 b=rNmYOpZfxsiJpY0CtgU6ddQ2mzLwIvy/WcI7JiD4yrur4ybdcVYyhcRa6w3/TpcnsOoGq1YUKYqOICzrsVL7cAjMKR8+o4kzWNbhiOFMr5nec+s8gyuvb/p068xSuIkfN3epBCr4DFRLp9BEqeIFkZv9vIDva6n+w40gtDVS3L69Rc1R7nj1iUHflhM/uSKo/kXD5t4evq9SAtCT0Xb6MgsO8HPxeRZBXRustE6TgM1q8z0WZa+AbhB5tmZl9nbFXAN47YjqHdIdGwq1Eg1kLy8ArwNCteS0U4/MUbP41nkDawm4VW2EM7YOxr7PbToHSKv00DnKLqHekEIV0XKBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO3P+RseHi1IEJiaEerKsCyCYkDSgCrymSHVcewWrz8=;
 b=VNi+HygaF8RqaJh/eQrP4Pi0KpvYtgdeWs4eGPXior948iPMuQWpVJvkLvcVfrJPUsaSOpapuTddAq/E7NmYgOpI5mmfrU5/w+8zK8U8uzSijSkpHbd9WgULIsdi7+5/MeEmr5pZ0e1AVLceu31YdIBlLYxeE3PlN+xvt3XTOHa7r7eEFcj7itV030BIfzxpMBsrOckSyInkjhqm6PAydDBHrbk0S9rUWB2h3M56YgSuU72ZflthciBYQjhz++wYGShZUiIcnlqEEh6k2VxbmyinNzh30lCVZpol8qcUr8cDg+Chstj2uWCZD1pqJi0DJKGXy62LAS2is41tKDpkKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:48:08 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%2]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 09:48:08 +0000
Message-ID: <c27930bd-b2b8-4131-95f7-ff8435080c02@altera.com>
Date: Fri, 22 Aug 2025 15:18:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] firmware: stratix10-svc: Add initial support for
 asynchronous communication with Stratix10 service channel
To: Greg KH <gregkh@linuxfoundation.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <20250722163045.168186-3-dinguyen@kernel.org>
 <2025081904-swapping-waving-aa5b@gregkh>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <2025081904-swapping-waving-aa5b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5376d3-efc6-4ae1-b629-08dde160ffd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHpSL3JlM1ZKeXQxS1E4NmlZcndKQm9WUytuRFRUODNIdk9JamxwbXd6MEVk?=
 =?utf-8?B?YW5lVHhySUYvUjFPTFk0TjBqelR2aGlUblJVLzhKUExwRitMWVhxYVk0alhB?=
 =?utf-8?B?Uld0bm1kUk1xR2lOZkZCTGxndENHbCsvZk5tbi83UzRVdUNuNUVvMmdOUXIr?=
 =?utf-8?B?K05TRjFXbjVzWE1yT0puNmJ0Q1pjV0xNVzIwQ2MzWGxMb3RlRHpoS3p5SFVI?=
 =?utf-8?B?dXR0OVdINTcwNUFvckV4WVJzV1dUaFIwZis5N2gvTG1CdHRQazliSlpIcmE0?=
 =?utf-8?B?ck5VYmNDVm54b3BsU01RVHhXd2tZLytKUzM2VENaSDlQL2tsbmNxSFJjOU9W?=
 =?utf-8?B?eWl3dlJRdVNrOVhTb0N0anpKR0NlckRXSzh0aElGREdscS9vYVNiK3hGV2p2?=
 =?utf-8?B?aksvVHZqQW8vM2xoMDlPOW0yaWw1Y3Z5bGFBQnRJSGpHdWtEa1dta1NEODlT?=
 =?utf-8?B?R2VlM2JMNktLUmJLWFZyczRwQVcrblVRWGdPdy9iMmdGV3MvZytEbGVFSHo3?=
 =?utf-8?B?QVV1NGRpSUtDbWVLT0VtNzVRZkZUQXI4SnNpdnlxRTgxcXc1L3BNNW5Sd2dU?=
 =?utf-8?B?T2dCZTdxcm0zcUw3c0d0U2xXRCtybXdLakY2dVM2Nmg4VXY0UExDZVBEZlc0?=
 =?utf-8?B?ZXpBUit2WmRBNXE3WStCZzRDTUlWVlNPbHZPcDc3WWJTWWRJaGRQVXpMbW81?=
 =?utf-8?B?V0hmUlVSalRLajJrQXNhbHovcWpqYnBjeTVnVzZLSFp4Y09iMTZkcTJlb3VG?=
 =?utf-8?B?QXJsU0tMT2w4U25vcGo0M0VxWUZSYmpSa0pmdHlRaDVjTzNqd0lPSllENEsz?=
 =?utf-8?B?TVQ5NG1PU0k3K3g5c2FnNWxZeWY4dkxlQkdHVk1PclBCbHZwdmF4S0lEdXFM?=
 =?utf-8?B?bEdKTDN2S0RXQWRBcHQ2bWYwSW1pSW53UUxxVlV3RGZDR2EwdzJLNnE2N0cx?=
 =?utf-8?B?WXJjN3FxK1lkMDErZCtqZllWTkl1alhkS0NLWDhUWlZSWHRqdCtNUDdvdk1h?=
 =?utf-8?B?SHhZNm9KZHRhQTFlNmpBSXZwWExFb0VGbzBLYi9xSWRnMnNwUTczR1loRjhQ?=
 =?utf-8?B?QzMycjRmcUwrWUdNdUJCYTVUUjJWWjNCT1R6N3ZtUGowTWN2ZGxSWEthV0pq?=
 =?utf-8?B?bFhRMHBKZWM4K3VBQTRHT0R2aDNua1dWd25KeWlVbnFxR0dGazYvZWthejgw?=
 =?utf-8?B?VHM2d1RTLzBBcmlyenRUVHc3SGlCNktINkZsV2hlM2sxd1pPTE9RSGMyUEtx?=
 =?utf-8?B?UzZFM3FiZE5rWkVkU1pUcm92WnZQR1UxYW0xZDg1cVh0SUVoLzBxYVJtaW5o?=
 =?utf-8?B?WUJoc3N6Qi9MQXVRUjdkc2ZxMWdmNVplR1U3bVZKQVBaUFM0aWR1WDRWYVJI?=
 =?utf-8?B?WHdHdVBnYTFIMmg1QjRQMEI3OXdPWlVUOXZWaDBab3EzTzRJTU1kNnhaY1hi?=
 =?utf-8?B?YnRSMk9BZGlGdVhLT1FNL1dlQ0t6UlZoK2RYRUFaRWliekRybWlQdllqUDdB?=
 =?utf-8?B?WkhlVE1Ib1RyWG04N0RuSTMrdGo4NzdJdXYrL0dNcWV4WENVVW5zMjRMK2JN?=
 =?utf-8?B?YTk2bDdmcmswTitMblFTdERRZk9UcmZtZTY2M3UxQmlwekoxczFoRXJhRXg0?=
 =?utf-8?B?cEh2SXZxQW1XNnFwd1BZSktSY0xrdTgwa043bmVOMjllbkZzR1JqSG1yZXo3?=
 =?utf-8?B?SU4yZHlCTGtXZkg3Vi82TGNneitQQ0FFZ2xrMjdUT2ZiRDBrNWp2WTVqRGNW?=
 =?utf-8?B?R2RHVHVaVGpyWjNZalNCeW9jSE04L2prSERLcmdmNmFMSmxDVnlaaGg0NVpu?=
 =?utf-8?B?MTBFZTRveWtIdVc5VXBWZFJzM2dOcndObUEyMVBwK3RkQ2hFSGN6Y1lzeTAx?=
 =?utf-8?B?SVY2L3hKUWprT3VlZzBXVnRPWWR2a0hmNUs4WFRXMGNVS1pJTHgvRHEvaGIv?=
 =?utf-8?Q?GTTnWQZjqzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGFvYlpGS0Y5TDg1OVo1WnE4dE9IM1hIRnJ4RnJreHNFMmxTcmZhWFZTSXZt?=
 =?utf-8?B?SVV0Nit5Q0RycW5DN0drWUM4bVJ4VGo1OEhFTWgwUmR4K01TQmsvZUZhQWFk?=
 =?utf-8?B?eHpPRXVsNlNpd0NiSjRZb2ZHa2FKV2JNNmFLZytzNkJMOGduRDZPb3NsTWRI?=
 =?utf-8?B?dXB4RVBpVmJEVDM1b0k0N0hXQWFKTzRYQi8walp5Rk5mUC90dW9TQTVKUUlT?=
 =?utf-8?B?UVRmdmFYWEl2ZWRKcEc4Q0pqSzhpeVNaSFNFR3pCUG4zSlNNaGF4ZnZqcTVl?=
 =?utf-8?B?T3VBUVRubWVrVE05ZnNPcEJ6dVQzc3E0L05mdzB2aFkvamtmbTZnc2paaXdC?=
 =?utf-8?B?WjhmcERvWDJqSHp3STQrY25FVjJFTUtQZGlPc2JndncxcTBKYTc5dERzT3dy?=
 =?utf-8?B?enpYcmk4UWttajJpU1ZsdFZqdjdzOERUOHI3b0dEK1hIMEtoUWt0THhsYjBo?=
 =?utf-8?B?M01NZlZ4VjdVaWpRT2c2dFlkdjlTTDYwaUFXcU9jWExVTHIvVmhzcTNoaktn?=
 =?utf-8?B?d0JTS2RtMHR2TW5FOFZjSUZuZGpSNzMzeTFMVEtIaHh3K0J1bThYNGhaMjZv?=
 =?utf-8?B?bUF4elRRVHdwalpRTmhaZU0vN2ExaDVwb1pMSGpCMmgrclpzK2s4Wk5vTWgr?=
 =?utf-8?B?L1FIeWczeHFOczZMYkdhOTdHUWt0RlBqV0xKTTZUaTBpSFJiUHJGcE5SY05k?=
 =?utf-8?B?ZWdxd2ppdkdEc2twTE5XK0JSN1hFUlFmM0dtMXpkOXM1WFlsenorQ1FwakZq?=
 =?utf-8?B?OU9sR3VwcEZORDBxbG14WHVzVHMydG4yZDMrdmFFNWVkNEQ0WHVMRWRyRzNB?=
 =?utf-8?B?dWFzNENRQXVCVHBTTEZaNXNoeVduK253OEJuK3ZpZ3E4ZUFWcTZqK1VkRVI4?=
 =?utf-8?B?dUFiNGtEN1BWM1owWHcwbzA2ZGpYb3RSV09QSVh6Qmtld1pkR2ttNU81bHFQ?=
 =?utf-8?B?b2ZGb2NGUTFlQXBQaUxaZ3Fnd0ZtQ0cydXI4OVJteS9LQUZpK3ZXNE9WSTZi?=
 =?utf-8?B?OVRaTXNsdnVzQUZoM1FQNVFUeGRSSGVQdWg0aldINmpLcXdRaEtDR0ltV0NO?=
 =?utf-8?B?UXNEcWMxRWRjSTJSRzZMdnk4RWR6bzU2TC9HRmRZL08raFZGMXVXQk5lUTVE?=
 =?utf-8?B?U1Rsekx6NjNTU1ZLSTNDRlNHU245NThmejVFazlaN1FXbzhqZXAyK1FpSWJy?=
 =?utf-8?B?NURMYktFTmxhNFJHWk1hcEZTb2VENjhKVHVtOVFBSk8zUTR5L09JRmFPdDJ3?=
 =?utf-8?B?cXY0bXF3OFpyVE54UFJ3K2VOUmx6dWl3c1FsWmhCU2hqQk5UcGpvU3BQNm45?=
 =?utf-8?B?T3hMZDVyQ3pud0FhRGlsejVRUTJXWFd5RllQWVR3bklqbkdHOFlCYkUzUWht?=
 =?utf-8?B?RXNvZlpNSjkyMFc0REtDZzZDWHNtTU5uVUxsOHdEYVlXblBHelRwN3dLYTJZ?=
 =?utf-8?B?ZUhSQ1RRMkVmNTRwbW9vKzJZN3MzY29MbkpFWHcrbHJzWjEvS0I5WmFUeGMr?=
 =?utf-8?B?UjNXMU0xZGJ4d1BaQmEydnpLdEdYdmU3L2tnalorcW02Sm1uRXlGQXhTaTd4?=
 =?utf-8?B?M2NpVGx0bnA2SitvZDl4TVp3ZEp0YnRVRVdtejYzanJWdG9KdndNSGRLS1JG?=
 =?utf-8?B?TXllQUgxeUc2ME15eXRlYi9hQ1FmeVE2OGNmVXRxbHkvNkRSVWZZai9HT0Ex?=
 =?utf-8?B?bzZBaTZxVjE3TVlleGpnVTJWeEpiNFIyS2FIa1BqenNCNmFBdlRpMDE2Vkg4?=
 =?utf-8?B?ZGtURElWYzdhbTNuTnJ6c2VDaEJ3UnVVZk1vckhQOHpJcHhqY2dUZjlSb01o?=
 =?utf-8?B?bXNsZm1xTHFIRzBVVzlsbU5NdmphSHByYUViK1NhZVhka0tYSGRmZ0RaUzFT?=
 =?utf-8?B?VzNHVWZIeVljQUpwM2pKVGFNOFRhTnF6MWhWd1VBNlR1U0c2UG5GYk5SSThm?=
 =?utf-8?B?L2lpQUxmME14SDN5T2puUmhKbDdYdnliWE5PZ3N5bVl1Mk1xaG1abHZqSUZY?=
 =?utf-8?B?dFFXWE5jSWdQUFU5emlxWmd3TC81M2pXTC9hc29DSU5FaEhxaGE0blVJaG9s?=
 =?utf-8?B?ckZSTnAyS0gxaytieHBvVit4ellma3k4Q1pJZ2FIRkFKTkRWMGozeEhIakNQ?=
 =?utf-8?Q?ruPn77odF19LBYtEWpddBpElC?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5376d3-efc6-4ae1-b629-08dde160ffd0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:48:08.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnfUYtjAe0rdE06/WeMdKb2DYc/7g1Aoe6LvNOI7bwltUBtdVpjsHCQvNkm143JP1EiZeJ0kyJwksrLR5f2tig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613

Hi Greg,

On 19-08-2025 04:38 pm, Greg KH wrote:
> On Tue, Jul 22, 2025 at 11:30:43AM -0500, Dinh Nguyen wrote:
>> From: Mahesh Rao <mahesh.rao@altera.com>
>>
>> Introduce support for asynchronous communication
>> with the Stratix10 service channel. Define new
>> structures to enable asynchronous messaging with
>> the Secure Device Manager (SDM). Add and remove
>> asynchronous support for existing channels.
>> Implement initialization and cleanup routines for
>> the asynchronous framework. Enable sending and
>> polling of messages to the SDM asynchronously.
>>
>> The new public functions added are:
>> - stratix10_svc_add_async_client: Adds an client
>>          to the service channel.
>> - stratix10_svc_remove_async_client: Removes an
>>          asynchronous client from the service
>>          channel.
>> - stratix10_svc_async_send: Sends an asynchronous
>>          message to the SDM mailbox in EL3 secure
>>          firmware.
>> - stratix10_svc_async_poll: Polls the status of an
>>          asynchronous service request in EL3 secure
>>          firmware.
>> - stratix10_svc_async_done: Marks an asynchronous
>>          transaction as complete and free's up the
>>          resources.
>>
>> These changes enhance the functionality of the
>> Stratix10 service channel by allowing for more
>> efficient and flexible communication with the
>> firmware.
>>
>> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   drivers/firmware/stratix10-svc.c              | 657 +++++++++++++++++-
>>   include/linux/firmware/intel/stratix10-smc.h  |  24 +
>>   .../firmware/intel/stratix10-svc-client.h     |  88 +++
>>   3 files changed, 765 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>> index a8c57963da99..4480ba8b2e11 100644
>> --- a/drivers/firmware/stratix10-svc.c
>> +++ b/drivers/firmware/stratix10-svc.c
>> @@ -4,9 +4,11 @@
>>    * Copyright (C) 2025, Altera Corporation
>>    */
>>   
>> +#include <linux/atomic.h>
>>   #include <linux/completion.h>
>>   #include <linux/delay.h>
>>   #include <linux/genalloc.h>
>> +#include <linux/hashtable.h>
>>   #include <linux/io.h>
>>   #include <linux/kfifo.h>
>>   #include <linux/kthread.h>
>> @@ -44,6 +46,47 @@
>>   #define STRATIX10_RSU				"stratix10-rsu"
>>   #define INTEL_FCS				"intel-fcs"
>>   
>> +/*Maximum number of SDM client IDs.*/
>> +#define MAX_SDM_CLIENT_IDS 16
>> +/*Client ID for SIP Service Version 1.*/
>> +#define SIP_SVC_V1_CLIENT_ID 0x1
>> +/*Maximum number of SDM job IDs.*/
>> +#define MAX_SDM_JOB_IDS 16
>> +/*Number of bits used for asynchronous transaction hashing.*/
>> +#define ASYNC_TRX_HASH_BITS 3
> 
> Tabs for defines to make them more readable?
> 
> And use spaces in your comments please.
> 
> 
>> +/* Total number of transaction IDs, which is a combination of
>> + * client ID and job ID.
>> + */
> 
> Wrong comment style.
> 
> I stopped reading here :(

I will fix this in the next revision.
> 
> thanks,
> 
> greg k-h


