Return-Path: <linux-kernel+bounces-753402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C76B18267
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7087B1329
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F199256C71;
	Fri,  1 Aug 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3QZUoOU"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141025A2BF;
	Fri,  1 Aug 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054670; cv=fail; b=WkNWrcAhgE1kclgXnNjv4hC9+EtRDcgB2pJ4grMoV50oIszYAFBIQnQ4YbULV4lCjbYagJvVIVzgZ99nmL0FbXjqul2ldBxmHr6MbzyLzlSGqIvtglY4qGl0hLJa/bPVoNuec0lEXsOuc4IGNursvH6rvLQ+6+hfugQqSjcqsiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054670; c=relaxed/simple;
	bh=Ek7FUvkliq1YL+9oWR4B5tQwrhCPtCoZhJyYDQ7VGZM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aRN0L9/SF80YiLbZwy65V78/rIR5F/DL9AWKjxUUbjOcx7Ji5v/z7LpMRE2BJ027YifPgECZel38Y02hEo8RzO9WYx0AvD6boMVbPg90OlFCxyn92vX+pL4u/HYwkZiST9MIXunHg+MuuY39avvsuf2IJax9dhhqnkZTvkIflDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3QZUoOU; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AShSrvbhvvmparqIj/926p3/MKUaEKrcM2p/BThcHqMLXHcX+O6bak/q4Ue0IkUvjrZWaG/HdPHUc/dF/hTfe1zJ46FI/oft4JEeytCeKLkKRIdKQD6KTR/1vqDtXU6dyZpW7i5fJDOqFkdEx8hgbs+9H0ygx2vXgSqj+nZRjYEbMN9r7qNSb4DYLVn5cjZy9HtUWab8sJ47ZXFR50InvQEPSG0jSh2eWb5u5GMSm39NDpN4MaM9GA+swFiG7JsvSivJvUjvWkUZGgWspB0ddNsz8DlKTJAvAA6y4GQNQFrT3I4B7cFdH9FwYZ9JNPzK4hm/KNvhmT5+DtlcfUP6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBSos1er9Rnbz88IdFYlF3xgFRJTStVA+t1MU5kxOFU=;
 b=FhLnk5K3L1FtFQV5wfvyqcpfd8FJ47tEeAuBwR2C/o3n16Upmgz/5gFKhOWBF2LKnQfZdmhA6VEMxokFsi8F47WLyuikdMLTfyfdEBTQYWwIaCa2bv748x9qPwehD/XciqaGgMs0vhpGCPcH9Dvw3voHglbliBuhZHby54zu9g7WTPy4CJHkABZRUVrHWbwTeLNzpl8HlQUvUOQ9twM+SwftiSrqOrIF2gDJOw2qS0AET/mD24bOxpzJ3bDNLk16zaevbjE3hMdpcf06y0Xa50FSzTr6sj0UYx64gAFZpnlZJ/sGs5DJI50OehDBHRL2tbRF5rr/d+vuy2L1nF/+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBSos1er9Rnbz88IdFYlF3xgFRJTStVA+t1MU5kxOFU=;
 b=n3QZUoOUqSpt57t41IcdWLUxZ8F4PQokzuF+qPHz1F7JYluvioxf0pCoP0OCZdcYAaI5D0G74c4Uc0VyIbAEcxsahQSc/qKpbBr+rGyix+eXRfKASFfJlxJWNBGYbHElVxP1EWSEdE4e3ZUSReBlCNmGMBLkNV9i1/mxT16Db/6r2ryMg029o9X9OTsfCL1amOzBMgl0zp2XzmWIBAI/oReLactmmNR7WFqIhA2QsJ7vbMD+25V8TOjOR5/JgJvxf/Y/bIn7j5Av6wLEsjAEyW5houfZaA1guwiFQVFB0cqPqZXRPmmZoE8wnX+AawcM2Lp+gV79bTeeKaAiKT5Ygw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 13:24:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.026; Fri, 1 Aug 2025
 13:24:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 01 Aug 2025 22:24:10 +0900
Subject: [PATCH v5 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-as_bytes-v5-2-975f87d5dc85@nvidia.com>
References: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
In-Reply-To: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: OS0P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9559f4-b857-4d88-5244-08ddd0febc54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk55QUYrUUpzWkpSZTJiclRKTis4YlVZMC9nVCtQQ0ZFOVdFVVovQ3dyNUxF?=
 =?utf-8?B?UFE4bGI5bXlNaCtTYTMxcWxMbU9HRkFnWis1cTJuWXpiTWlxS2kreU0vQUI1?=
 =?utf-8?B?YkdDV1czRjFNU0d3cjVlUGhma1RiRCtnMmZ2L2RlZXEvNDBxOGhRQ21lbm5v?=
 =?utf-8?B?MTJ2MitGZzNYU09VTTRZVEF3aGpVTnNKRWVUSCtmSERWTUlEZFdJamlpK3dT?=
 =?utf-8?B?Q1g3b0xqSU9Lc09jU3NFcHgxVE16VCtwUTliazVnVi93VXZXS0M1am1TKzU0?=
 =?utf-8?B?Q24yTXhxaGl2OVVycHV6a1lXUVgwczdyS0F5bjBCUHdUMmFxUnZTbHBsOEJu?=
 =?utf-8?B?d2IrVFRxZlFFZ1RobkNvN3Q0RkNLLzNFZDFPWW15WkFzUWJLRHBHdXA4Zk5l?=
 =?utf-8?B?SkVTRUgwRFc0ZVRWRkszWWZvSFg0OGNPVXpmdW05TndqQXNkQjMyNlhrN3hi?=
 =?utf-8?B?QlBGdVpJNlVsUEhTT1FucFlwa0hqNkgwb2RVTzd1aTBCYUZ5MmkwWlgrMVJ5?=
 =?utf-8?B?MmFpTkJGRW5vSjlCUXVJZlpzb0R1UVRWbHBPNkZaWDhhVXI4Q2F3cmFtZ2c3?=
 =?utf-8?B?SEl4YjdlelZrZ25ySWU2WXR3SGU1OWdQMG5XY0tTZThFUDVPTFhYNWVsREp1?=
 =?utf-8?B?WG01ZlZWbnpkLzNCckI3cTRLQXpHN2h3ODQ2OHh0UjNBY2pTNEJpWTlJNkJJ?=
 =?utf-8?B?S0NYS21LSjBNdTg3RnlpRVlobElVYXp1SnU5UHZjelpPR2J0Tm9qb3BwV2lY?=
 =?utf-8?B?Q2tHT2xSMlVLcmtwWlJiL2psUi9lNlJ1Nk1ZaDEzTUhwNmdRS3RIMFRjd0Vs?=
 =?utf-8?B?RTErU0pORlk2c2o1RDlHYWFqbW9qbWpPNkJmdVVONlk5Ly96UVl2TkY0Q2N5?=
 =?utf-8?B?UHdpYm44WTdHMzNPRXo2WWNCK0NMeHYwVlJFNHBzdjFKeVFNWVpLTjZyVXlU?=
 =?utf-8?B?MTNYaTQrY0dpZktxSXR5dTN4aG5IOWxGWmNJRGVHSkEyR3dXczkrMkFzcmpn?=
 =?utf-8?B?UFVyWlIzNkVHck5LM0hRVkpjbTdXL2dZejFXLzFaWXRuM0ozcjUzcEVLZEx2?=
 =?utf-8?B?SjJsZ0pWc3J5VFJhQ1dsRVArc1hjR3hIbXVYQ3NtN04wcnRIS2lEZDhER3d4?=
 =?utf-8?B?ZlMvdzBxdzA3TDN3OXZuVFllZVgzenI1UEV4TG1RUGpOQnJQZkJBdHp4OVF0?=
 =?utf-8?B?MStVT0NnQnVEZmJONnJGWnJJWUxCUzNrYkJIUURRMDVZMXhvTFpya1F1RXFL?=
 =?utf-8?B?MkpjbHZ2YlFpUlBKYkNXejBMdnduc2pncEhxeFJUNlZ4M2NYVnQ2Vm51WCt1?=
 =?utf-8?B?bjlCc0R3MjZGc0I0SzUrVVI4U1RZcnoydWJkWVBsNGtCZzBnMnN1VDFUc3Ft?=
 =?utf-8?B?QnFHQlYvaGxGK0pTdWFsWnNNKzNKVXV6c2d0cUZvOTBEbk1GZzFRSFNSZm9l?=
 =?utf-8?B?ZWdhMWtxSTYzd3BBZlppUlYyOXRzWEtsc2xtSjVnSmR4ckpTTk1GdFordDRa?=
 =?utf-8?B?djF4R0ZLYUZ6YzFPRlltSXJjeWppVThYRDg0MGc0a2dkbi9SWTY0U3UyM242?=
 =?utf-8?B?N3o0aEM2UnN3eWJmaTBkQzNOa2lwN3pwVHJidWMzT0dHb2lMSFhwbHRjMkF4?=
 =?utf-8?B?aWNHK3R6eEN6TTZIQks1NWhUYjFlekwvZ1dhK2UxN2x0RDlVS1dpNm1UMDMw?=
 =?utf-8?B?RXdNNllueDdTdG1WQUJDTVhnNGU4SklFcHlSYWcwWldReHpzRXJnR1RQaDRs?=
 =?utf-8?B?a1dtdEgxOEI4Rk1mT3hUbnEvR3k0aVMwYnFrMXU1WFVuQjZySWRPaTcrWWlG?=
 =?utf-8?B?M3dia2xlaVJydzcwWlduaGhTZ25wKzB3ZDk1dnk3anFIV2pBeVIwbE5oUVBZ?=
 =?utf-8?B?VWRZY1NTY012Nng1V3NJU042bTBFUnBkcGNYMkxKUDJDSEYyVnhMbTZud25p?=
 =?utf-8?B?aEVIUnoxa2JLdXgyWCtETUZ2dy9XRklNQTBhWUdkWHBzMG9iT084dnVQa3ZQ?=
 =?utf-8?B?U08vTkx0UWpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bldjeC9PTmtaZk0yaVZuaHFMdnR6d2xCd0lnMFJ4alZBVVRCNHFiaWRXYU9I?=
 =?utf-8?B?ditPWnJKZjVjcVdSdkFra1dzaWdHRndmdG5BVGQvUi96cFRCMmxnWElSZTlH?=
 =?utf-8?B?NVREZ3pjd3VHUU5pYnQ0WE1PNmRXYjZickkwbW4xZFV0Nm1OVUJIbGNMMEQ2?=
 =?utf-8?B?NG1vMXdWSVdxN2JSemg2ZHhQY0o4RklmYXgxVlJ4ZTVSaW1VVjdMajRQRnFy?=
 =?utf-8?B?ZTFtKzRnOEYybmJuVDJPdWljQ2FlT3ZZWnVRZ1JmNGN1WVdvM040Y2NLZUNK?=
 =?utf-8?B?WWxtZTNqTjcxb09sL3JxTVRUY1ZHbkh6Y0dCTS8vMmg4RENkR01wdlduWVFh?=
 =?utf-8?B?U2gvVDNMUWdZUTYybWsvcGhSWVFINXozdGNoa0pGbGQ1MXNtNlFHMjV3SzZp?=
 =?utf-8?B?b0xVZ1dLTFIwTlVqdjAwYkR1eFBSMTVWa1V0Q21kQlE5aUFjbWhxMlUvb1p2?=
 =?utf-8?B?cnFrQW05dE9qYzFnNVFUYk1PZHBNNkZCU2pGYjl0cEl3RWFLcFd0YkFBZjhw?=
 =?utf-8?B?dkFMcFBmL0xGbWlYWHpYYlcyQTNsSHpTK3R5ajlCemUzTkc2YlVaeEdTeWZ4?=
 =?utf-8?B?Ry9NdHRNOVdMMGxIRUFUbk52UVZjMkR5K0RYNGdCczVoeHFuWVRodW5aYTJV?=
 =?utf-8?B?TUc0RHpWNmRiRmZ0eDFCK0dDWHp1NDFHMS96WjY3RWEySEE5dStrWVNwQWpx?=
 =?utf-8?B?QjZ2d3ZGbDZYdzcrQ0hqaCtpc3RuOTVBMi9xVEdENEJGelRqZVNSY2FNa2h4?=
 =?utf-8?B?ZlpuaHo1eHFFQ2VTVjBkM0lMZ1dKUFA5bHkrRUdjZWhRVE5XZzZRNVM3R0NY?=
 =?utf-8?B?Tld6bFNuVGR0a3hEenYzQlBhNGlQRWFVVzlzQ2RaYnowOU9KUzBvR2J5cm5E?=
 =?utf-8?B?elhBTVgwZ3hFc094NFZVKzVLczh3M0VmR1JvT1NsTTA1VGtCRTZCc3FDMmJw?=
 =?utf-8?B?amlOeU12ZlVmNDhhT2ZsT1U2WmlXQWYwZ3J6Y3RxVG4zQnFlSEVsR0NEcUZn?=
 =?utf-8?B?ODE1ZUt1Y2hRU1UzNDdlZy9YY2dzZkNEeHVwam04SS8rZGlpcVpwZ3M3MWxJ?=
 =?utf-8?B?ZERkMXZDeGNnRjNRTlJYa1dLK0VRdlZFTCs1Tm1ob2RGR2FDWkQ4bS83aHEw?=
 =?utf-8?B?bUlseGhJbzBPYWhQT2tYMUM2dVltRVBSRCtRRG9uSG1tQmIvTlJSMFBLa011?=
 =?utf-8?B?M0pDZWFsOExzVFVIL09WeVhQdTBPYzhYYnV1czk5SkNJOUJleHE2K3R2ZDND?=
 =?utf-8?B?aGhSa3pWYy83ajNUYUlQNUdjVHQvUkJia0VYOVdmZEl3eWk3cGJUQm1icW1V?=
 =?utf-8?B?U3NHTWYzd0ZLZkhNMnI5Y0Zydm13eUFpUFR3dHJjTEl1VEFMK3g2aERuSTNw?=
 =?utf-8?B?WmV5cU13U3FRTFVzVTJSWW9Pd1kzZnJNUDh5Unl3aitVeVpJb0c3SHNuNXlW?=
 =?utf-8?B?Z04vK1hPY1Nrb0oyVUM3a2dwZ1NsbGdUa0dUZTVScGQ1OEZRK2gvL3A2Y1N5?=
 =?utf-8?B?aEVyQkhEd2JkZnVLbFN3enowaFBORW1NMDRKcFdxeHFIS1AwRk9tU28yY0gz?=
 =?utf-8?B?RlJPZVRhNWtaZUMxY0VDNHErOU44Q01jK0NqMFZXbFNqcGRBYTlGeWFWR2JS?=
 =?utf-8?B?dHlJNUVxaVdCelNoek1NYXZ6dXR0TkhwRmsvcmlNZk05OEtJb0JtTTErUUl2?=
 =?utf-8?B?WTFIQTEzV3pPM1h4Z1FHODBuOTBZcnhyM1ByL2RvRStWTjR6aXpPMTJQb2ZI?=
 =?utf-8?B?N3pvQXNVejg2SHFZQnJnWG54M0RrVmI5d296R2hWN1hFWVdmdzAybHJlTXVO?=
 =?utf-8?B?L2o1bDVEZDhrZk5Uc2hsNFRXUVM5cC9XbXA1amF5MUdlSkFmcFQvZ3hpWWlz?=
 =?utf-8?B?TU9nVmpYTE8zLzBBTC9PUTJDMmlOSzhFd0NkQVVGQS9TOGdaTnpXQnVoa24v?=
 =?utf-8?B?MDRJOVcwZnFRbzM5ZFRtelFzWjEwdkVJTHFsSTlMRS95Ui9ST2FQb3hIc2Iv?=
 =?utf-8?B?eUdTYzRTUmI5VmZsZ0tjVHZEV2xrenlWZ1ErUDlxeUU5ZlhTTzkzeHFBOWpK?=
 =?utf-8?B?MFZMd3ZUK0FJSlJrRVQvSmdJRDkrMktjZE1EQXFVbGJMdHdFMzhvaHZPL0JM?=
 =?utf-8?B?TzE1S0Q0LzRiTTlLY0sxaysvL2ZTYWJiSVZkNFNheUlRQnRRWmFRY0JKa3Vj?=
 =?utf-8?Q?B7DsGZhOyi/MbSuvQ5OhKvtQwYa/sgEU14Z0k3WHW1Ob?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9559f4-b857-4d88-5244-08ddd0febc54
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:24:25.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GH6ZPmwPj4u2mnd2shoaKrJtGplV9V/yIvqw5hwCI1aQrqt601uCw6U8eHcEi1oUtfrvbVTRunxDohvyPN5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

Types that implement both `AsBytes` and `FromBytes` can be safely
modified as a slice of bytes. Add a `as_bytes_mut` method for that
purpose.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/transmute.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 08e6f0ff92a563e90895efa31f31f887aa05a0ae..5b2a53aa5df041e56be0c23993f684aa803551ae 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -57,6 +57,21 @@ fn as_bytes(&self) -> &[u8] {
         // SAFETY: `data` is non-null and valid for reads of `len * sizeof::<u8>()` bytes.
         unsafe { core::slice::from_raw_parts(data, len) }
     }
+
+    /// Returns `self` as a mutable slice of bytes.
+    fn as_bytes_mut(&mut self) -> &mut [u8]
+    where
+        Self: FromBytes,
+    {
+        // CAST: `Self` implements both `AsBytes` and `FromBytes` thus making `Self`
+        // bi-directionally transmutable to `[u8; size_of_val(self)]`.
+        let data = core::ptr::from_mut(self).cast::<u8>();
+        let len = size_of_val(self);
+
+        // SAFETY: `data` is non-null and valid for read and writes of `len * sizeof::<u8>()`
+        // bytes.
+        unsafe { core::slice::from_raw_parts_mut(data, len) }
+    }
 }
 
 macro_rules! impl_asbytes {

-- 
2.50.1


