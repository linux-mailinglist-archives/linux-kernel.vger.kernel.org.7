Return-Path: <linux-kernel+bounces-827774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2DB92C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B0F3B64E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B831A553;
	Mon, 22 Sep 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="APoRq/L5"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4B302164;
	Mon, 22 Sep 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568567; cv=fail; b=a8hOBJCryfXbV75UU6L24ol/DFJUqhTMDUEn3TYzR2GR5WN3qopzaDlB/4iV5re+VJHQ7fQyeCX6N6iDqeHxE90JUXRgJHsyBhrSTtVL0uENvQVabX6YruhUri53VTVgBld7f91tnGqLbTpkjvSSocECFC4AMK5CZ3pMWSXUdqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568567; c=relaxed/simple;
	bh=y3Ee7naf4So73ytxpVxb78E/TH2bYlQ+sdSaQVaBnUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1a46DCMTOKew7/m7n3aOCeZmWTrWVzlpc/5vHYcGrIq32pcpLFKx7Ov/kjruaj/cW/ByQEw40MvUagwRpG124GR2RqPC5U1oz7Es7mHrbbh9ZLmawP5ogFzsf67alAxau+ZDJs8B0x5DKQD5zklu0nSMCJjupGfSqaB+bBgNb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=APoRq/L5; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvGE8+iyQnvuBST29R7lQGnDeTmQEzBwfEF8bGrg3uEos67aCS9FGLDGs53kk/gbFXAaO/DzTif3JAZMt7n/HDqgBrUnHcVaDniT/aSJX5iXzT7wAZSN4AVzgSptgEAYd91bxMnVg6mnxyDZk+5tee5Xke5QQcGCCLpcOIUBveVcaXalihH8/BvgJECxeT25JyOY8LOeG6IW5PqHXiTUNvvltHgsOWpeoE+sSUpXlYE45oncogehEJ8bNhQ0I0jjrfhGUUR6yvcyzoCwySUtG0sYBBhWsXnGUQytp0w+7vZ9++BcbJrvsofGEAxJZEgh2ft7ThuSEWxvvmMRSo2zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9Z+t77Qu6agyzVVdf+gF4eKcr2TXZEuPmNdQWAWEWA=;
 b=IhPyjM8SJlfs0O7EeTKlDXxX0zShtn/KDxbHnmnT1SY43Wo2Nh51+Mqtw9WONiCvbwl3lP3OJfcFqv0oer0nuRRRP6xxIOMkOkbBQxgbGlzQGf2/zvs/GFI7TxapSqIAM4yXW7bKnAMcwWTytqcd6zsm8yfy3hGpEoFn8LTA6PCsir5inR8KsSiPvZNfIyq1eiOWSgOphq1/NqDD2ZmEX0mOvdggcn+/Gqz8CvqnCvWfNk5WpM9HKmekenAh8k9B6LZsYmMPnZt6wJfXpTnO+IM20v/ci7R56StQe5hfL+FPgzovWa0IvsqjJhZUmL3TESHwWVnn1mpn4B+fVnLdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9Z+t77Qu6agyzVVdf+gF4eKcr2TXZEuPmNdQWAWEWA=;
 b=APoRq/L5x8wEEI5i+jOHXYzvYY4kTXTSJluoCYkANiyh07lPhJ1yDDZLq0NDsbliQ75NK/eKifQib5R+6iKdQOHRrro33YMXyr0GmtWnCCEp7p3peqxyEp9KDKaEusVp5NV/4LV2TKBPkTcjblBrBQ/yslFtJ3A67adELZDaRGLAeev2G38SFmEiKcL8wtbeDSs0Prf/DAqKMEe8CsWmg70VVYaGcTScQqriIofxNdbV535EX5hccOpFZ8ke/U12yUlRxS2ygCx5iOmSZhz25I30Nq4CgxKbIzjZks8mqXYEbh9SlXxlSmN+NHtSzkQ2nBCOu2N8BcgR+W47S8AB+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 19:16:01 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 19:16:01 +0000
Date: Mon, 22 Sep 2025 15:15:59 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
Message-ID: <20250922191559.GA2463388@joelbox2>
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <CAH5fLggXGMHM1bhmaUb94gDu_LiUbMGugARpOZoUNSTU3phm=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggXGMHM1bhmaUb94gDu_LiUbMGugARpOZoUNSTU3phm=g@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::11) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3eccdb-1994-48e7-5246-08ddfa0c77c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWxMZU1qMnZVbm4wZDNFc3B5RWpOaTgySEpxdEhSQ0hiL0JYY255bEVId0F6?=
 =?utf-8?B?aWx1TGRwRkc5bFVHV2RJc2Vzb21uaHdyYlFDRFdnVG4zTmJRZ3FuYnNIRnNu?=
 =?utf-8?B?elZnVDBHNkNKM1BKbDNEY2JkbEpXUThwTEk0aHVxWkg1eHBLRzFWRVlGeFdq?=
 =?utf-8?B?c3JIK1ZVT3U0TFhvcHdpV1h4WHc5UGNGUmErc01MTVQ2MTA1WWk3cUs0YTE2?=
 =?utf-8?B?NHBUMzBwdUw0ckhObmlRZnhpaEdGM2xtWWE3dEZ1bWxWTmM2UzZ5NFQzRXNM?=
 =?utf-8?B?VEExbXNWR1ArM3pTcE5DRVZUUmczRDZiTGpRQVgybHhlL0YreTkxUVR4VzhW?=
 =?utf-8?B?VTR0MEp3YlZRVnc0dnhLeWpRem0wdGxhQjVtdnZaeC9OMEloN2Uvb0paT0FS?=
 =?utf-8?B?QXRzZkhRTGNhZVc0SHpJSTA4cER4RUxMQlUwN1FGcDErWlZSUDZqbzI5ak1u?=
 =?utf-8?B?emthUlJNRzFwSHRFbEFHNDlyZVdFL0ViVHBrOEJHMkRTbktJQlNQbDNrRGRQ?=
 =?utf-8?B?YllYaFNZQXRCazZpeEtUMFZaZ1QrUDZKZVhWdjNvaGVEYkppaEt6R09LRFAw?=
 =?utf-8?B?WWxlMFpVUTljVkROeWMxUUlRNEFsZ2c1R3Q3T29qUzJ6K3pPeERSamFSelpH?=
 =?utf-8?B?THVUeTJ2SGIvS3BoMTV5UmE4OWFoTEFkUTVvcHZiQVZxN1lWa3ZXU1hhS3pZ?=
 =?utf-8?B?MzZjUFRqNENCS2VWN0JlOEtkYU83RkU3bjJLaGZic1ZpWTROUzZPSFlOeExD?=
 =?utf-8?B?WlRVbWp3WHJSM2hvTWIrNG5rYlY5djNHRTBqdzhkUTZVbG9lNmRUSUhuQmdy?=
 =?utf-8?B?OGliRDZRdXNiRTJrVWUwQlI1d0VCbTdxY0hXUlRSM1Z0QnVpeUlORkdZa0Ru?=
 =?utf-8?B?cmNib1dPSjNOaDlveFhZc0EvN0tyMmk4ZXF0SUd4R0xyUUxpcGROc25WRi8w?=
 =?utf-8?B?VHh0OXRPR0ZiRkZhZU5tQTk3aTluL3JuV25Db2I0VzBXTGFFWWtZcElzSE85?=
 =?utf-8?B?VkE5S2hBY2FCY3pwb0ltekxlR2F1M1ZJdUYrY00rdU1OOXg0cHFOV0lJUGsw?=
 =?utf-8?B?bnVrNXF0NEtwNGtGcXBDbnpTekhLb1BvSk1OaXdobFZTNUg4dEgyamtqM2V1?=
 =?utf-8?B?MU5IS3R4NG9pUVVYVjhIbjBUUDFUaEs4VEgxNFpEVXR5ZkwxSlpScEtoTmtu?=
 =?utf-8?B?U2tpSUltQ2xkTXVUTXEyU2ljZGtqZVgvVU1haE5MRzM3eElWL3pJeEJFSkJu?=
 =?utf-8?B?S3ZCa2N3NkJPQXJmRklZV3Z4S2pzbHljZExzSjlLREl1cDN4MFBwT0tnaEpT?=
 =?utf-8?B?TmhjTVM3SVh4alRMM2MvdzMxWjdyU1ljR0JUMTJBNEhGQ0pGck9DNkVaTmFq?=
 =?utf-8?B?M1dvUnAxSFdDbzhTY0c0TGl5eFlIaUdHb1FOWWttV2tsL3RkdkFzU1pFekFp?=
 =?utf-8?B?VDNIQ3lQdHFrUnFENHVrMy95eFlDT1lsMURMNUZ2MmZzVXVtMmJBaWlnZ2dM?=
 =?utf-8?B?NnZQMVNwK085YkM1VTlQUTV5Q0YrSmVpTmpvUDJycEpDaFlaTTVEQ0x1ak9O?=
 =?utf-8?B?RHM4a2N6V29pSE9USEV0alZkT0tvc3NaVHd0RzBpUis3NWdINzRqak9jVHRh?=
 =?utf-8?B?WVhVRkFtaXl0RjdNTFg3VHJ2cFpQVnlIVTNvek9pRHQxcHExNEFGQ01kaVk4?=
 =?utf-8?B?NXlFU2hnL2g4MDY0UHdNYnNYSS9CaUZXLytzektvMjA0Y0FBOVd2YWZJSUVR?=
 =?utf-8?B?U2hjYWIzRmlqR01VVndkUzQ1ZGpJbGRjdkt4S2dMWGQyZktiR1ZOS0NhTnhY?=
 =?utf-8?B?Z0c2RUFPLzlXbUVMY2tKRFBkQUF2MEUwR3lDZjFBQk1qZVpBa2hqTkZ1cWRU?=
 =?utf-8?B?YngzaktRM1NwUFJJNk9BNzllbkRmb1l6V2FKWDNlTnVJNGhSTmxhSUUvM0cy?=
 =?utf-8?Q?d1OCS7FS7I4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NldXd3N3OVVrc1A2Smt3eW5IZW13M1VGSndzYlZrbXZhdjFUM3d2c2k0cUxL?=
 =?utf-8?B?S0FWU3gzRlU4bWlzeHk4bGlyckdEcDdrMTlaeHhZam5nNVFXNFh2OVZIWUhM?=
 =?utf-8?B?QzN1U0hCdmFzTmNhVEZ5U1BuQTJ2RGdRUVRqaFc4Zm1CWjdTYXVac2o4MjlX?=
 =?utf-8?B?MU1pNDBxRy9iRGVSYUF2K1E5di9jMHBxSlpNK2VGeUJpazJqK0RZMFllcU1P?=
 =?utf-8?B?TEtHVXRkWHNvS1dUV2dvd3AyTTZWM0h6N2p2ckxhRW05ZWtCajFwU3ZsSFRV?=
 =?utf-8?B?eUsvbUVXNzhJOS9uNjBtY1dxenJ1bENhOWtuZGxBa2tMSlZ3eXpMYnNYSTJo?=
 =?utf-8?B?SlhuRnQ4RzJNaVp0YVovNHFLS1RrTlViZTd4TXNLQzdyK3dHdnpkVHdJTHhu?=
 =?utf-8?B?ZDEydHRnWWJNRllXZjlMcjZnQTc1alNkbkU0aWdpUnQzeE5HYmd0QlJGa0J0?=
 =?utf-8?B?cEVwcC81QmhWN3FBUWNwNlYrR3Jjd0VKejdrQmtSMW9NaWNsZ0F0WDJ5eUFS?=
 =?utf-8?B?TFg4Lzh5TitCSC9UUTFxaHQ5NVUwb25rTUhLY2VLVWloakVTL1lTcUF0eHV0?=
 =?utf-8?B?YnV4OXVjcEdLblJ6RElOZW5PNHFOUHJGYm80b3hGbHh4Si9qZURUV3NHbzFS?=
 =?utf-8?B?WTc0N3FVZHdzd3ZKdVp0cEhwb29lRHB1UkdJRnUrYVFXQnQ2SXJvbDdkMTFR?=
 =?utf-8?B?VUxGa2tBZ2tzbURRRlFqVncrUEpEdUtLWXRSL29VSHlDVGdSVC9ZR2RjNVFR?=
 =?utf-8?B?cjF0NVZGcjhEK1NnS2hVWU5XZ3pOcDVaeGFDZmdMYzdqZW9MSzdnUWQ0UjFV?=
 =?utf-8?B?amdmTjZwRUZyS3JlRWRDeUVoVEE5cVhaQldvQmVZYTUwSG81TElBWUZuNWp0?=
 =?utf-8?B?VXo4Q3NKSGlBVDBXV3dSUnB3UTh6THVoenR6ZVVZWFFmb1hGUnVlb0VKUWg3?=
 =?utf-8?B?ZGtNaW9SV0Y4Q2RvRkh2NnZXWEl5MGRLbWZVM2laS3pCL1RBcTFZcFMyTHpu?=
 =?utf-8?B?VjNzNnpEMnIvajl2b1k1TElqekZBQktLSmp2aEVtM0tEZnpIcGJkbHF5cVV1?=
 =?utf-8?B?b3BGSnh4SXFNcUl0M3NHWHl2Rlkrd2VxTURWaUgxK2VOWUlUY2I5eEVMWE5z?=
 =?utf-8?B?T0dsUjJFcHh2NjdkbzltdTZxa3RoWUdGME1IT0I1cEVnSExLK1BOaVpvT2FD?=
 =?utf-8?B?djhNdUJ5ZmhIMWc0eFZaVm9iNkRpM2ZVV2pDcTZJc0VZYUhhWmwxdzRPL2Jz?=
 =?utf-8?B?SXJMTXVkYXhBNW5xVEw4VkdBTnJKQnhTTElDK1ZNSmhZMUtab0dNcytvYjA2?=
 =?utf-8?B?b1prQm1TcDlaSWpXT1E0Qm1sTlFxWW9HcWpNbnM0MWYrNTJubkE4VWlIekM4?=
 =?utf-8?B?YWswZUM4MFJQK29zaTQ5bGxMWStEcHRQR29jM0JDenpRZ0hZaTdKcVp6WGNz?=
 =?utf-8?B?SlZqNE9FNGx1Y01BK0VQcTF5eWY3NVE2RGZPcTRHRDhkcDZvUGJGR2VMZDhj?=
 =?utf-8?B?Uzh4TS9tcU1UQVBWcENZOFhjTHJhM013K3paeG1KYUxBTzR2ZUsxait4ZzRz?=
 =?utf-8?B?clFWZ0MvV2NOaHZwRDRPbFh2aFpVSmtEL0xhTzZ1dWZJeHgyMks3QnlOSmtj?=
 =?utf-8?B?NlQxemlLcU1vRjFJSTZzdDhJckVOalpZR1F4SzloMUhOKzJvclYzYmZOWlZ0?=
 =?utf-8?B?K0tPeTJjRGFpWElLb3QyQU5FTHdPdE12V2llY2lsS2RQL2xhMjM1L2FlS3hJ?=
 =?utf-8?B?cU1oYnJqMHlQWjFJS1psdStTaTAzNHlXSW5sTm1udFBlRjNLUU1KMVNVSi9V?=
 =?utf-8?B?aldONHV1R0RWNzJCSGlOdWx3UUVVcHR2eXVhWFg4RGorMTMySytOdXNyVDlK?=
 =?utf-8?B?cjZWeTE1MXg1VWZTYVNqOHVIcFB0QU9sZWd6VlpPRlZwV3ViT2VoRkxOQVow?=
 =?utf-8?B?ZVpmRjczQkZyV3dZT3pWWXlDU21JVGhBWXZMakpabU1ic0ltTjI3VUk0eklJ?=
 =?utf-8?B?dGNzczFBNTRJSEw3K0VOUHlkZTJBWmpxMVZvS2pITGdwTjdGam1tejVZSHNl?=
 =?utf-8?B?eTNpbXhCZFpJWlo5d2NEbjJVUFBHSGtvQktwblVWQWlIY1NOaks5a2lVZkFO?=
 =?utf-8?Q?UI3UHoiI4vHOktqJ04rlE1/Kg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3eccdb-1994-48e7-5246-08ddfa0c77c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 19:16:01.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dX2Hvg6fYXR5HD9z3m0zYpP2riuTuca4rmtHZEC2BV0eyhzrNw2IBa9H43BcFCvyWNc2bMyvOChUs93oSNaNQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

On Sun, Sep 21, 2025 at 12:46:26PM +0200, Alice Ryhl wrote:
> On Sat, Sep 20, 2025 at 6:20 PM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >
> > When printing just before calling io.write32(), modpost fails due to
> > build_assert's missing rust_build_error symbol. The issue is that, the
> > printk arguments are passed as reference in bindings code, thus Rust
> > cannot trust its value and fails to optimize away the build_assert.
> >
> > The issue can be reproduced with the following simple snippet:
> >   let offset = 0;
> >   pr_err!("{}", offset);
> >   io.write32(base, offset);
> >
> > Fix it by just using a closure to call printk. Rust captures the
> > arguments into the closure's arguments thus breaking the dependency.
> > This can be fixed by simply creating a variable alias for each variable
> > however the closure is a simple and concise fix.
> >
> > Another approach with using const-generics for the io.write32 API was
> > investigated, but it cannot work with code that dynamically calculates
> > the write offset.
> >
> > Disassembly of users of pr_err!() with/without patch shows identical
> > code generation, thus the fix has no difference in the final binary.
> >
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> The actual bug is that write32 uses build_error!.

I don't think that is the issue, I spoke with Gary and he educated me that
failure of the compiler to do simple compiler optimizations (I am guessing in
this case, dead-code elimination) is a compiler bug. Even in the case where
the write offset is dynamic at runtime, since the caller of write should be
using something like try_write or checking for the offset bounds, the
build_error should be optimized out. Right?

> Trying to change the printing macros is just a band-aid. Someone already
> mentioned that it breaks the ? operator. I think this change is a bad idea.
> We should fix the actual problem, rather than making random changes to
> other parts of the kernel to work around build_error!'s inherent fragility.

I don't think the fragility is in build_error since the direction here is the
bug is in the compiler. So if the compiler optimizes things correctly, we may
conclude that build_error is the correct thing to call. Or is there some
other reason you think build_error is fragile?

As for this patch (and its being a bad idea), I think it was already
mentioned that this patch was not intended for a permanent solution but
rather as a starting point for an investigation. I am probably to take the
blame for not tagging it as 'RFC' though. I encourage people personally to
send patches (whether good or bad ideas) to code I maintain. Lets have mercy
on ideas, they may be bad sometimes but every once in a while, they may
happen to turn out to be good too. How would one know if they didn't try? ;-)

thanks,

 - Joel


