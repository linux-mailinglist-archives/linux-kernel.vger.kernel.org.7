Return-Path: <linux-kernel+bounces-874802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE2C171C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91751C20EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E07355054;
	Tue, 28 Oct 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+Adm855"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44142DCF46;
	Tue, 28 Oct 2025 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688977; cv=fail; b=S4Ldv2/9/ra3LVvjNO12DIM44qbsYB7pHUv4if/sRp80iTqCkbvcg4UyAvqoYq50WnbxsI02S9ZzrNMcZTF19r9hdBIqBTf6sYZBLJ7eNN5IR2t+lh5/yvApoH4O333QjObGFmGesfQP1BJXhINhUo98O509TxjCL+p6YMDTCGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688977; c=relaxed/simple;
	bh=yBeE7W/7nntlT2MOI95nn639VMdjGLpyeZsL0OL+Ilk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PnZJn1t6zWiZVBv2fOkvbkOFfWwR9KSlEkPqpQ30c1sG5iLw2i3LyU8e1obJhGSG6/Q36EBmLofImUTpRk0JZuRf3vnXeMYaO/5o5dPtxfXA1UX/xMFJQTsTwr7lYGnyqNkEPyf5vD4JSb2GHVF9qGdYCGdBBw88iUc9JcA4CRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+Adm855; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hrx41ouK5ddVvIU7cszVbMFaw14RnrMAPHqpqxO8uZWtpmhok2VOa/rfIDmV9XORmWnk4sdhZlGhnBLnxSGCqZ/Jd3cKlESyp/jf+m4bSwwZJBdWFXxgNva/RPryoIdwaM/WnjFahVd7Bffqo74eYyBC3b4e508c1GiUnJ4FCuvCHVOAI15I1hjet5t2+3cAZ6GPA49FWqtKHmTMCaRL1Vo8cOHsgBdgyXW9JC1U693OXim9fxczxZ1EiOI0XIepCvm35kP/DHL0tHOeSrHe3mDwCwmg4g62NM3Rq+UtfNzEl+x4fHPx0fP15kfa82bKt6KGsJf/PCxvynAWR5HG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH7k4OLx5coaGTFTZKxy0gRxuQ9h+uZrZqBylqXrYW0=;
 b=EKj6YjAku9/uFetb+ZoakX/Ap1WVfvgQIvIPnoBbZeHSHC15/cKSTAojv16CA++jEjHorYjPXbBtOMswQi1xrDXJgUIAxHBcWWFh/fGirC14Pifn38MFOfuorNh34d6M74rRMJ6sKsjE858Sz/aLelzINZWDKoBfPeLSYeC1dwlBrR6pwY9cPnYCtj+CCzHHOlQIL1YRTcdb4NwCPl2dNtrywGt+8n9Hj9huhs2Je6dAWV5zC2Pt8VkdhsaZ7P1jZOgTm2Qa7QakAw5//NrefccWFo7Rv9sU+thDyZoBXfBIRr4nEJd90J6Ctc6zZi/c9FCLr9eJaX/n8T1PmmfQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH7k4OLx5coaGTFTZKxy0gRxuQ9h+uZrZqBylqXrYW0=;
 b=D+Adm855fm6QaCBBIVOJU2R0tFQbZKFPacj+eNgc/wWw2hUPvR4yuCUbx/4iLZUxVeWisrnZnws7/KHi1sYHde+7I4bUZibZqH7QCrNx+scmhRP8hoUCsr9Le1hA4npWL/KHggt05W8jOgjxV0rSOBXwdNgqUWvuMYmTkQScmrBhkxKibtN9I6st6X3v1JvnFeDVZAsQpPAvO3de6flVfk9wEkW1p5oDI6rz/3VIUG/TGd31MHBHVDBGQSnhd2/HVupqYxK30EmWJg0HpHkMLIrdHhKyECKR6ikErQT0GoKC9rRr0dv+v7OS8/K4jXqZLPjnX2MgeQ02rr2/B/jJog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 22:02:50 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 22:02:49 +0000
Message-ID: <98177196-09ac-4678-950d-81f3f1d487b8@nvidia.com>
Date: Tue, 28 Oct 2025 15:02:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust/dma: Take &mut self in
 CoherentAllocation::field_write()
To: Alice Ryhl <aliceryhl@google.com>, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
References: <20251028211801.85215-1-lyude@redhat.com>
 <aQE7KliosIU_0Bll@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <aQE7KliosIU_0Bll@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::23) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a2ebe2-af9b-497f-6988-08de166dbc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm51c3cyVzB4dVRIM2tHN0JaTkp6VDNoVnB0Z1hwNXdKbk9BNFFqaEc0dE03?=
 =?utf-8?B?MGFldGN5cEFsQXprRlNmRGhaUTY4YWp4L1ZPbm80R05KNG5QMGg4WjY0TlA3?=
 =?utf-8?B?T0xEWkl4UjB1RHlJTTVsNm9jMkZsTVlaNEQweHl4Qlg2dXluWWNqZlhHOHdw?=
 =?utf-8?B?eGhNYURXS2c4L2M1UlZyVWxLalRxR1AyYzU3ZFR6K002R1FVKzBxNW1rNHRZ?=
 =?utf-8?B?Tjc5MUxWL2V4bnFQUGtpZFRxbDI2MmJQS1lDaW5tUDI3VWV4bnBQbDZIdnZN?=
 =?utf-8?B?UEw4MXQ4N29tU3V2dDRzQVUrOGt1bXFMUUVQWmVsLzMzWE5RNjZVRDc0eERD?=
 =?utf-8?B?em9GVmdoRlBpL3lHZTZhNWx0QXA0R3poaEs4dnZTdUpSTGF0aHBlbEw5ZGk1?=
 =?utf-8?B?VitKNW5NaitaUHArVlplbmRtYWdNNG40bERsV0R0dERQaHhTY3NrU0N5OHRt?=
 =?utf-8?B?TEdZS0VlSS9QTkxxaUc1czZzaS85emhleWtNdTRKRXNlY2pvZktQbWdLNWJo?=
 =?utf-8?B?MnEyUFQyNS9vWlFOUVEzZWpiTVd3eEFKelhJQXRWS0FUK2dSTkFCUjd5TmhK?=
 =?utf-8?B?R1EwRk1rUUZ5RmdkRmRFL3hWSjV5QU0xNnA4WUV4WVNiVVdjSS9LMzZPNHZ0?=
 =?utf-8?B?UEJiSHR1dFo0VDNxcXQ1dmRRL05Bd2pYaHRIRXV6MUs3ZEFNTVpzcTlwNXUv?=
 =?utf-8?B?NzRoMTE3d2ViTjFxSWVZTWxLUU12ZjFGTXlrTE9OUlJiRlExdXNrcVQ1SHNZ?=
 =?utf-8?B?TlBScWJ4MEVRSVNpZWp5ZUVOZEs2bW1uTHpTMkEyT2Z2elFlajdTQk5GSmNR?=
 =?utf-8?B?NFV1NDhadUNncDUyaEgrbk9BendtMUcxS0V4UjJPSmUrVjJsYk1KUUsvV0V5?=
 =?utf-8?B?b3JxUmU0QTQxc3V3K1EvVWZ1Y1FxaExIZksxaEt3eXNkdm9mYkw3Sm9tdFR5?=
 =?utf-8?B?aU9xbGlyaHZBaW9hVjdqUTRocHlMaUErZnhvTm9IbmdJQnVKa3RKU0lVeW5u?=
 =?utf-8?B?R0NGU1VyMTE4SHlnUFJpc0YxNVZsREVmdGtHc2M4NFJwQ0tPUUtaMDV0eEJl?=
 =?utf-8?B?NXNpaWRsMHc4SWhGeEdaMXB1Q0pINEorTzJJY3QvbVZvRmxkSHBOSDY5Snpn?=
 =?utf-8?B?YlMyNFNyQTJna2hBWGxBTDQ2RlIwbHZOcU4vd21xMS9OQWxTVG1YZ05lMC9o?=
 =?utf-8?B?SS9HU1BEY3psMzZTQitZWjJ5REZrc2lqUGd0SFhTN3Jray9uYU1ZQTdRV2Jn?=
 =?utf-8?B?VCtDaWRjeTFGOVVKcTN3M0x5OVNUUjA1c1dtU1ZBdGk0TmRNcWhMMjBuc3d4?=
 =?utf-8?B?ODZySFA3a05sVE1XOVA5MU9YRHh6Z2g1YzlvZWdWQTkzVVA2N2RNaitQV3ZE?=
 =?utf-8?B?MnFnbWovdTRFUkl1SlNMT0JhZzRJN1R4bHJyQTkvL2Z0Si9FaVZROTlCWWtn?=
 =?utf-8?B?aEZMa012blM5ZEZ5TE1kdk5qbkRUb3ZWY0pIM0E0K3R0YzY1MjYvZlhzTk5x?=
 =?utf-8?B?bkVZNEtLMWlvQWtHT0NyME92cHU0cHVyQ1VTRmMwREFkdzgwUENxYk15elpa?=
 =?utf-8?B?RVNTaHBNbDNqajlRc3NxVkhoUnJjVjNKUnA3ZSsrSnZ6SmpSSnVtZnR1NUxs?=
 =?utf-8?B?c0NqbDJYUEdXWXcyWWQ2WDBsZE9WN3FOY09BQ0hDeHlqOEVFQUFhS0tpZDM3?=
 =?utf-8?B?eEFhSHFOTUgyRXhTdDRBVDBNMzA0STFCa1MxNVhiZG55bWxIL2IrV2FwMkVv?=
 =?utf-8?B?ZlFhTTBpd1M2amNZbWxWdHdiSktMN2g3NkxlZU1RU3huYjM0T0RlR2EwL1lE?=
 =?utf-8?B?dHQ2OFpadmwrVk5EeXNnWjQwamxKNUNzdEJiMDlaSE01ZStjeFpUVHZlUXJT?=
 =?utf-8?B?bGZ2K3ZidUJzZ3paOEZZNVhCSkV2Z1BGTVc5a3l5QUtMN2NLYzY5ckpUTlRG?=
 =?utf-8?Q?/sRO1edaB9dPrDR5O6qvz3hHjlJDBJRt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25BNGszd05WcGNneEJGN3hCcHpCTklUaVVmVmZId05pNkdFOHdNb013bko3?=
 =?utf-8?B?a0kzQllhYytOZ3RQbDRPdytvenp2ejZiTFpQZHpEYVhiM1FTQldPczdrVVJq?=
 =?utf-8?B?bGJMUHBHRk5uUlRKYnpWSk1hV2h5WVpQVCtSSG5DV2ozS1pPaCt6V3pNejVS?=
 =?utf-8?B?MVhqSDRiV0JtbG1idXdnVXJjWUxQdFFiUHZkeXRYdlIwYVExVlhoMmtjV0py?=
 =?utf-8?B?MjJ1ZHphNzZqeDMxOElqYzF4cG9jWGErQlAydWFwNzNzMkVWbWp0ck9MQUNo?=
 =?utf-8?B?eWVJRmxUV2lSa05kc0k0N3pYeVJWZmhjRDRZSnlaRTVvSVcrak8zRlJTL1hQ?=
 =?utf-8?B?VUY3by9jU0FKalp3QS9TejJUY0hMWlNhSzY3dmZ4VFBZTStOMGliL2tma3JG?=
 =?utf-8?B?bUdQdWQ2eTN3SXB0VngxYThBZk0vUVRZM0h2NnMwUnNLYjI0bFpYRm9YT0Er?=
 =?utf-8?B?ZHAvNUJiNVZZTjBWZjNGQ0p2dWtmTCtHbkgrdHgzZXhia0VJVzdvdlVKNEVL?=
 =?utf-8?B?dXVXMlRaejdOS1ZQMHIrc0hQcmM4bWIrTDBJSFZWWThBL1ZnMUVpNDFrcnJt?=
 =?utf-8?B?dlJUVGIxY1BzLzhpMFdWc1cvMXNZREtER2ZoVkVOdlVQY0xVS0hHMDRzVlVK?=
 =?utf-8?B?RmZEVGNsRkc0em5BMUthMVEzNnNubnhBL1lxcnVmcUZrREJ6ZU94U2tMYnVw?=
 =?utf-8?B?WkhSYkxaUEVrMWJKRnVpbnVWWGZaM09nTWo2c0toS2Q4THlZdXVENDNaYkYw?=
 =?utf-8?B?UmhFbW5vV2FPMlgwUy9ySEZOQ0NCOU9zYTlXVUZVdUhOeHhqdmpWYlFPN0cw?=
 =?utf-8?B?OTExeXRoQXhDQnBMdUdsdmR5U1hvUVNITy9CY0EvbkJOMmhHTVZJdkJSV1h4?=
 =?utf-8?B?ZDdDVE5SYkZPdWhaV2NPeEphZURwYXdaTGJvWmJrMXNsS3JoRHN6N0tXS3ZS?=
 =?utf-8?B?Vnc4bGxJV2VDTUVjMW5YeFE4OENCZUFHMFA2cHhGZ1FXV3FGekdqcUhLMEgw?=
 =?utf-8?B?Lzk3WnRqN2g5YlBpbEtNU1BqWEphekJzODl5QmtwSENHOHcxNU1UZS9YWjg5?=
 =?utf-8?B?QWlaUWtvNzFTM3VTdFgzbzRYWHMyditBZkNlT0RmMmU1aUpEWkcrb28wZUYz?=
 =?utf-8?B?L1RCTWRiQzVvcVE2M2dSTlZGemZEa0ZNMTFucWFFQWNCV2JzdUJKT2NJdmpO?=
 =?utf-8?B?ZTIxQytLVndWbFdRbnRWRVZQWHdFbmhsZGNDbisybUNwM1haMmduYzRnWDNQ?=
 =?utf-8?B?SmdZdFVRZ2xDRG5wMUpHYzc0VUpJLy94T0Jta2kvNHJaN1RCOVJKYXNCTitR?=
 =?utf-8?B?Tzc1QXJ6SWxtN3Z3YVdqYWF6YWlsQ0xBQm1zYW81amVnWHczcDY2cmc0cmFK?=
 =?utf-8?B?dE5wYkw0bWEvaGRtV0xIS3JIeHR3dEZFYy9KRGF0MyswK2NzdklCN2ZkRlE1?=
 =?utf-8?B?VnhTU2VJNUI0V2N3ZENjcjViY1hjNnpMRzlZaUpEUTMrQ2dBN0l1V1k4RGdM?=
 =?utf-8?B?emVObFZsYmpIUWFaQWV0WmpocjR2dU9xVEZldXpFSUc3YUdQNjBqMkFKTkxh?=
 =?utf-8?B?dGpuODVzTmUzamJTa0huSzFMMzl1Skl4dlA4N0ZwTEhpVWFuQ3pEUkoxSEVQ?=
 =?utf-8?B?alBxOFFpYkNNTzZuOVhsMVV6S2FMMmxhRm16QmNHZnhSbU1RRTkzQWo1cDFW?=
 =?utf-8?B?UHIzdm1sRHZHZFZ6ME9VeDhMS3lLTnhDdGJLMThPQ1ErM3E1Q2hZVFhjMVpD?=
 =?utf-8?B?VVRvbTlWVk9rSnIyWDh0bkJPbDBxQUNQbUk2N1VLRGJmYmVacmhsaVB2ZDZO?=
 =?utf-8?B?N2hhUmY4a3VGRTFFbStYdXpHWEttWXArZlBRR3l5Q3I1OHcrL1AxMW9sbUhH?=
 =?utf-8?B?Q2xLSS9zWTB3WE9kaVJzLzdUMldndkFib2VKb010T1gyWGl4SXhNekVSK29Q?=
 =?utf-8?B?Qm1pY2J6c3lUM1FNM21CUEZOTzM4eGM1M3FKUGJhSVUwcTNQK1liNTlpQnNV?=
 =?utf-8?B?SEtiQU90UFFoTWRXci9NeGlXUXhSN2hKNzludzVxSFEwOVFUcWx0TjltTnFv?=
 =?utf-8?B?alE2Y043V1cxa2ZxbitVMTg1STNzTEp6MXlla3FHOUFrWnYwV0FvUjQ3TzAv?=
 =?utf-8?Q?vmFiPbUdNt5EkdSAAqpn7TK7c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a2ebe2-af9b-497f-6988-08de166dbc1c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 22:02:49.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GwkejLXL49T21U+zoF0lVHEDNVLHzMOWLZJb83u+ENGU1g5WzRQ7Cerii9oJP2hu9paQV/kw9dRUL63edq2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973

On 10/28/25 2:52 PM, Alice Ryhl wrote:
> On Tue, Oct 28, 2025 at 05:18:01PM -0400, Lyude Paul wrote:
>> At the moment - CoherentAllocation::field_write() only takes an immutable
>> reference to self. This means it's possible for a user to mistakenly call
>> field_write() while Rust still has a slice taken out for the coherent
>> allocation:
>>
>>   let alloc: CoherentAllocation<CoolStruct> = /* … */;
>>
>>   let evil_slice = unsafe { alloc.as_slice(/* … */)? };
>>   dma_write!(alloc[1].cool_field = 42); /* UB! */
>>
>> Keep in mind: the above example is technically a violation of the safety
>> contract of as_slice(), so luckily this detail shouldn't currently be
>> causing any UB in the kernel. But, there's no reason we should be solely
>> relying on the safety contract for enforcing this when we can just use a
>> mutable reference and already do so in other parts of the API.
>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
> 
> Didn't we do this intentionally so that it's possible to write to
> different parts of the allocation without protecting the entire region
> with a lock?
> 

If so, that seems like it was a good decision, IMHO. Because with
DMA, you can't use CPU-side Rust code to provide full safety (the
device is blithely unaware of any of this, and can scribble all over
the area at any time). And while you could prevent the CPU-side code
from interfering with itself in a dma region, the downside is that
we'll take a performance hit and even a deadlock risk, and run slower
than the non-Rust DMA code in the kernel.


thanks,
-- 
John Hubbard


