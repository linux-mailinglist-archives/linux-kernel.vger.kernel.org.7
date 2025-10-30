Return-Path: <linux-kernel+bounces-877852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71DC1F320
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D753B51D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787D33B961;
	Thu, 30 Oct 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="vcVLg75B"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023121.outbound.protection.outlook.com [52.101.127.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197761DF742;
	Thu, 30 Oct 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815384; cv=fail; b=V5w883jAVTwkNJrEbJbBY2jGrXgTjAmv0MTrVvdoRgLa0zM7jz8NiJNOPi7IYOq9aMsjBQe6W51HlBLoy0GG8SIYBpfgJN1vCI7vU2UBogQ9uUhNdaf2Jc7+Y9cyxRfR31Cj7zY3X3z5XlGZ5FigqaZNy64CvMt7Ln6TnEgR+bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815384; c=relaxed/simple;
	bh=ePCipJoTmEqx3X0X9CmcssQ2GOOkK1R/APE16FNr77U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8/zqR1RzR4guwsBTj5OIsorRdPzw4c0hX/hQmqJGbxX7PPIn/29lKsHuLhYyCqJuEzkPygnOs/eIYu8MgQ0qgv5WxvktZRSndIiaekJhpoCpJHamAVcOG5k+kiXS93fnJ4Lp92EjtQNmIbcWY5N8yzTIE7LiXjZpp0pQwTWSrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=vcVLg75B; arc=fail smtp.client-ip=52.101.127.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOrmg478CFlGsOVqvyBxuiPnKgYp7rEkGS9CoqvTQ4+78fKc4ZL2hSK7pyE5lqGt1Nuk9kUUkwoD15nvtJzCplD2sG6+zW9rhn4vcTpm8bTGdo4AuZ0/FHSrAXJhtwc/P2LqrFOs0ZdgyGiWaEWLcE46lzqguCrvaqUA2pWDksz4BHlctg5gHOKiL4fStwU9zLMDsnsx59UbkcPOa44Wh5xaYXwfRB3l9DjRaoJm3EOWtW+MsbjFsNY//5PLKw9LnFxTBIHfM3wrZLhLd1nqAkvJgVIew79M6zl8EntcOh/WTbbPTZfaJx/UvHjzJkueB2XAcHSCRKr3wIOGrV/EbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HaTjDUu8s0h+CGs7MFZg/dIYd5XQCj+dM9XZCtpywc=;
 b=iywlYgyzZVQ5aogfxUjED7wiiRYdF9BECMVVWvJOzAjUPNPmG+1f35Am1yXZ2S1E71BmZkn3OC5WB2nbw4X6UjtxQ8zVIGsBWRA+aUJCyuzs8MNsgW7x53g/s6wnXwc/bJmUgJsREx+WkBGhdO0sewFHUF3r+zQyu1olVC0xUjZupgDx6jRQOFEhSmlR/gA3WonuoywF1ZyXRb3iG8ysyv879walzKuqZ8CFSuw9GVcr4okc4Y+i04MIytDZgPWV/xtaJ2GFGG3Fhh16yWEZpbwpA9pSDk8MIX5YAnlsQuUKGLT8iGyTgD4RIflykP9CXx/2u9w2dp4dkL8svJ8Wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HaTjDUu8s0h+CGs7MFZg/dIYd5XQCj+dM9XZCtpywc=;
 b=vcVLg75BIWFJGDjmv6wrImtb64c2mtZI1UI2y8vGMdQr5JhfmtXYtCr5Rbk4rrDM6a6QKiraciXLfOLCkWLQQovgx5ZlP71HY3a2JhhDSxPvSA7QqXqHmZJnV+A9GpvuqJtj0Q32S2J6NQf0kPOn49K9jj5AxrJzRUhLs6GdMbYwtVU2dihRgWaSo8r0Vp2R6UJI/XxsFukqZIvB1tnv3LhmXoGwgWgysB1GqwoHo87943I1UPgLjSBENdn2Kdgh3Jw8oyT02ts8vHEuEERSE55lwxmcZPRzgUIn6p6kA1uCYH3vOIxa0iwJ6+HLDqoz3VrbSjoxANp9OjNt1GHTMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 09:09:38 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:09:38 +0000
Message-ID: <c9920642-a4d2-41a1-a3ed-2af12a712e24@amlogic.com>
Date: Thu, 30 Oct 2025 17:09:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] clk: amlogic: Improve the issue of PLL lock
 failures
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 da@libre.computer
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
 <20251030-optimize_pll_driver-v2-2-37273f5b25ab@amlogic.com>
 <1jy0osye70.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jy0osye70.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cac95a-9dde-43d1-16bb-08de17940d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUgwU3dWclhnQURMT0NTYU9meFczRzgyWlBWRldNdlN1RUJrR3ZXZVMvVWRm?=
 =?utf-8?B?bExLN29PUTlwZ1pvZUZyU3NZQncxcmh3RnBCZ1ZHeXkxZjQwSDFjdHh5c3pB?=
 =?utf-8?B?T01GNzFJRHFiWkljQUh6NUtFbTBRL1BlRHR2Q3VGSEJLbU1OSTVxenVMT2NW?=
 =?utf-8?B?RGlKNXhhZUJCK3R4NHpKbXlOSkZ2WEgwZFI2bHVpTG9NNGxtMEJ6Vlg4N2Yx?=
 =?utf-8?B?VDJYSkF1d2lHWEhoSEJXa1VhUnZyT2ZOcURQL3ZXL2t3VWhxN3crT3MzcVg4?=
 =?utf-8?B?QVUwUXU1UkN3YXJiamZEbkVJNDZoL1krY1N1N1d3QXo4ZkFrcmpXTEYxL0Vj?=
 =?utf-8?B?QjFVUFVXOTkwVDRQaHlKaGpiRlBUdk4zMWVldythZUV1SjE4OVFCTkh6L0RH?=
 =?utf-8?B?QmRYdVg2czBMSUNzbThpbHRXd3F1RWdsM0VXTjF1cXRWVGkxYTduR2k5eUpH?=
 =?utf-8?B?emJ6Smx2cU5KY0JqS040bmltU2krakdYd3RWZmt0d3dGYnVyNzZ0WTkzcWxP?=
 =?utf-8?B?VDYzL3B3VGpKR2dBVkRIeklFUmZ0bkJKSnZsVEdIam84V0hYcmRMUGwxMzJa?=
 =?utf-8?B?N2xZK0V5ajMyWElnaGJxZ3l6NzRpUW5STVNueUdzZ1dLZkgzcVNSSEJaeS9I?=
 =?utf-8?B?bkp5NE55TGh5ekwzcWs3U3FCR3U2WlNOT3Fqc1M2dFg2cFhkUVRCSEJ1Y2pq?=
 =?utf-8?B?a1BZN3ZreFYvWU9CVnh3L1hPdWNJZEl4VGlIT1B1VmluZXV2THBvWWxNUlVj?=
 =?utf-8?B?Q1BSL2lMMDJuNkMwQWhTWVNaTU9heXFnbXQwcEQvY0pocWlhc2doSURrenVx?=
 =?utf-8?B?N0UzakRRVmh0TzB5K2E1Nll1WjN3eFZXLzB2cmlST1hneUJ0VXhLakorTlZH?=
 =?utf-8?B?U0NtQU9IVFozYXdPdGlNNDhMaEZNU3Qxc2xCK1FkdlF6c2tPUEtxL3NhSXZU?=
 =?utf-8?B?dzBZYVhrRGdpVEtQY1FET0JCaFhNYjZlVjVVSkpDT2xQRnFvTXcyN3U0MndW?=
 =?utf-8?B?enZGK2FJYmlRRVlsQ0dtL3p3b0xGV3VGOVFKWEFlSHZlOEp5dEJpVHJNdnp5?=
 =?utf-8?B?OGJiYlRqN2w5VDA2NkdldjFCSG83d2szZHRRMzNpMlpHRHBvOHVxODlpaU1w?=
 =?utf-8?B?c3ZYR3BGbTZSUC9hdHdaTjE2STlPQTUyL3R2YXhiU0xZWnNVOFo3Vjl2US9O?=
 =?utf-8?B?WlYrTk9mSkYwZW56Q0oxMUd3MEhtOStiS2tnQnVxd28zL00rN3RCMVIrWXh3?=
 =?utf-8?B?cDZnY0krWFFBdVdBSTB2RlZqOU9BaDUyS1g0VFBwRGU4ZzRub3MwamtsTkhG?=
 =?utf-8?B?eCtYZ3Qvckx4Y0RQbEtMODZYMVlKVVVNdFRZeFlZV1dSVzJpYlZReHZMTURJ?=
 =?utf-8?B?TDQvZnRIamkvS2lHRW5pMit4NlVZaE0xbCtPaHNsNXdFckJNaXRhYWxlK2FP?=
 =?utf-8?B?RFdzai9zYjJoSW52SFEvemYyMVRmeGhWVE13S3h1N2R2T2dSVW8yMUREVnhm?=
 =?utf-8?B?ZEx6ZFBYbGs5bVZ0Nkg4aXRVODFvNkZVZkdHNlhNT1BsQVB1UTh0NFZLWFNN?=
 =?utf-8?B?N2JnM1crK3FyRWdnaU5lak5YVUxaNVBpaTVnWWhNTlFjVGhZQlpVNHhOdUVG?=
 =?utf-8?B?VU9CQXdGL1JjZ0hFUk9xVHJraEZhZzRFUFpEUEMzdkhPa01weFE0eGFiWk5n?=
 =?utf-8?B?c3Z5ZHJpSURwdURFMGxRY0w0akdWb3NvYjRZaURQWkkraUlkU3RYWjBCdlRC?=
 =?utf-8?B?RCtwcWNlc2lvM1UxbCsrRjJIa1B3NVk0RHFOWEFOVkpRSHFESEZVM1VvZkEr?=
 =?utf-8?B?V2ptNjdEOWRrNnVnVnVjTU5UOUFGaFJ2bDVZK1hIUlcrMjduMVozREdZVnFI?=
 =?utf-8?B?MmFVNUVicTRpNnZhV3N2VldENUZ3NWVIWlRIVzNESWxBUkRqWkVENnZLdkNh?=
 =?utf-8?Q?0Yp7sw2vl+vC9+/DxkvnZlrOWB4rWXeS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3JQYTJObzgra0NyclhFbjVnSHE4VUpidldnODkxczN4YkVKdmE0WGVKNERQ?=
 =?utf-8?B?RVR6eXdkbnpMcG10aGI2emhZZFRMaFMxcnVIalhGVEtrVUNXRHlmclFUTnQ4?=
 =?utf-8?B?c1lrdk5hbGlyQ0RrZHk2R0orejZPKzg3T3hEZHU0RU1mZElueEpNSDZWdXRO?=
 =?utf-8?B?dmJkd1pmU0lMajlDTVFWc00xZDlERGdrZXp6UGpKUU9pMjlSZVRoSzJBZUIw?=
 =?utf-8?B?QlliT2gzRC9PbVdDWEFqMlZFajNlUEhVcXc5ODU5K2dFNzIvemxudFgwRUh3?=
 =?utf-8?B?UE1GTlpYQTAzclVOeE0yZkhuVHhFdGE0b0hnc0NDT2QwMTNDd3A0M3VLSXBJ?=
 =?utf-8?B?WkRCbjRoTHQwN3dnR0JDcm5RWlo2TDdhVzVxNlNFYnVFdkZDcG9nU2oxR29B?=
 =?utf-8?B?Tm9EVFFBbnhIZDh1QXQyUlphMkVWUDdIN3Nrc3dsMGRBNEFPdTVTTmZKVVVp?=
 =?utf-8?B?eUJHWjJRRkNEV3hQdlV4YllveWhhTEtya0RFSWlobktlUUpxNmpzNXBDTXJT?=
 =?utf-8?B?YWFGK2J2SDBFQ1FyTEg1YysyVnAwalh0WFRHY0x3Q2xIWE01dWZ1eWZiVDIw?=
 =?utf-8?B?dVk5TkRKMjBkem1rVDhhSjNLb3BmTFhPb2dPS2xIa0RPSERmMm5SaTZDWWZ6?=
 =?utf-8?B?Z2lHeXh0RXo4SUFiaTNTN3VMU1BCUTNMSENqRWtRRjhOcUo1bmdrdTdpNEtl?=
 =?utf-8?B?anZDWUNHeXlTMTRmLzNFV3l0SjRuTnU2RWVieiszSG1PTlFoanFISUprUFlt?=
 =?utf-8?B?KzFwQ2gxRmlieUkxOW9iMTA1Ny93Y2VpWFZVa0gzN1JXUEVsMjRTeWVsZW9S?=
 =?utf-8?B?WE1XdEJCT2FPZE9VSHpTWUdPNDVwZGMxQjZGS01IK0JuOXI3YnZzcE5uT3lk?=
 =?utf-8?B?TGJYb24yeWFtM3J2cEdTSTZic2hnQzFEcElKMFUxVnA0U0lwWFNRMmpMTmt6?=
 =?utf-8?B?bXYyb2M4U0F4YlpVMTM0cmRPam5Fbkd3cXN1ZUZsOXAyVDlaRHFic2tIcUho?=
 =?utf-8?B?ZnF5eWNYdEhqc3ozdVFtQXFpV3VHSDl5MFVYZ1pnUW5WTGtiT1hjOW5Mc0k0?=
 =?utf-8?B?U2k5YUVyVFJSNkE0cEYzaEc1LzdJSk5RYnorZ3FMRGRpeDY3TG14dk5uSlJ5?=
 =?utf-8?B?bGpyZS9XOTRwQ3JnUHBsL0Z1KzQyaEprWFUzbFNMTXV3aFZsMzhsY1RwSzFY?=
 =?utf-8?B?NjNXNDNnZ2JzUmJEVk8veElmc0dodVJNQWppUEFRSkNaM3ZNMFFKalc2U0lR?=
 =?utf-8?B?aXdJZzRHd0t3STVJdUZMRTV5eHRCSHZHSmd0Z3BEN3Y3SWZmV2kvc3pnYm9I?=
 =?utf-8?B?aEtsaUUxd1RsWWpJdTVzMitrU2lxOG5DQmxuVzlYOFl4Z3FZR3BkdFdzU3ZI?=
 =?utf-8?B?alpNT2RnWFVWeEpPMi9zaWRaWVk1ZWw2NGJZVm0xOXVWdnBZUzJtOXZ2NWhj?=
 =?utf-8?B?TUtCQmhEZFpEbyt1cmJ6SHNYQjg5N3BSMHZyRE9aVkp6R3lKMWpsVWlMVGtl?=
 =?utf-8?B?MEpyVHF2clVSWjVVWUtTaE1Pb213Mjh3WkhOM0pweTg3MWxZYmVFVFZsdHRy?=
 =?utf-8?B?aWNqUTB3MG0vVENrdUxZY2NuV0pzN2dZazZxbnFEV1ZOaVdNTlVJbnVDME80?=
 =?utf-8?B?cHYwTy80N2gzMjdqM0Z5RjA0ZWhwU3pjVjNCaWMvYmZlQnA5VlJPWWx3dEZw?=
 =?utf-8?B?UVJiRzRqbm1MNURjOEg2aVM0TVZaQk4yVnFOTGd1NHhacFVkMHd1VzA0aUZD?=
 =?utf-8?B?N0htV2JaL1h2MHkrVjVhZ1g5Tm1jQ2NnYWdZVmhka0NGL2pDeGJVcnRaRFpv?=
 =?utf-8?B?Y0RiRityVFh0Uy9kYVhnT3FlaVk5VHQrYWhobWd2Q1BYQkMvdS9EUkJETm5H?=
 =?utf-8?B?Q3FIdi8zUEZQNkwzWG5YbmZwcVljS0EwYTNrMlFjdGVSdlNqdk00Nk9WbytM?=
 =?utf-8?B?bisycitSMnhNVDdxNy9nR2xTR1E4Lzl3dkk4dDk4MTRZQk5QMEFpc0prYUhI?=
 =?utf-8?B?aXdQZUo1aXVoSGRVNkw4cnhKUE56aG9NQ2VOWGFVcUlHU216N2huVTV6ZFFt?=
 =?utf-8?B?cnVBYnhsckxkdjIzUHFJMDc0cEZIc0NSL3ZNVlMxVDJYa3gwcTl4dngzNDRP?=
 =?utf-8?Q?Sf0nbdnpi7lj8O3UBxajR7siA?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cac95a-9dde-43d1-16bb-08de17940d51
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:09:38.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLoGx+TfEN/V6cp7A3FyhuW9tAX9vlYeYuzRn8JeGk5VZg3UHTdfKpYwyj0C8Dn4/2W4uviOT91ZRd1yoHNNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7183

Hi Jerome,

On 10/30/2025 4:41 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Due to factors such as temperature and process variations, the
>> internal circuits of the PLL may require a longer time to reach a
>> steady state, which can result in occasional lock failures on some
>> SoCs under low-temperature conditions.
>>
>> After enabling the PLL and releasing its reset, a 20 us delay is
>> added at each step to provide enough time for the internal PLL
>> circuit to stabilize, thus reducing the probability of PLL lock
>> failure.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index 629f6af18ea1..f81ebf6cc981 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -368,11 +368,16 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>
>>        /* Enable the pll */
>>        meson_parm_write(clk->map, &pll->en, 1);
> 
> New line

Ok, fix it in the next version.

> 
>> +     /* Wait for Bandgap and LDO to power up and stabilize */
>> +     udelay(20);
>>
>>        /* Take the pll out reset */
>>        if (MESON_PARM_APPLICABLE(&pll->rst))
>>                meson_parm_write(clk->map, &pll->rst, 0);
>>
>> +     /* Wait for PLL loop stabilization */
>> +     udelay(20);
>> +
>>        /*
>>         * Compared with the previous SoCs, self-adaption current module
>>         * is newly added for A1, keep the new power-on sequence to enable the
> 
> --
> Jerome


