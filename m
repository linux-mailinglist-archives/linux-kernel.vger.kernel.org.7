Return-Path: <linux-kernel+bounces-842827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92065BBDB60
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD0CE34A78F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D18244691;
	Mon,  6 Oct 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CteyUWus"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E423D289;
	Mon,  6 Oct 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747102; cv=fail; b=Wc2ZfZ4HYCCDkopiDkNFUSLfJ17P7hqUrs3RH5Vnw2YzFVBlCGrs6dLBiSt1PNewyx8ix42NyGFpEwwOkYMXK0PJEkN0wbjh2xyPbV16LTJz1qRvjeFp8q4wJSjrOoPGL8L9r20ACbUKvdnMnlmazVDj9QGOLWSZZd7A3+QD16I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747102; c=relaxed/simple;
	bh=t8riBpbPaXWwEnV9jbYpYOyNlJPnPiJYvY3W3IxFBmw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=S986cRemGUyfX/huuQx+9cMNekfkLKlEtAVFUTttIVgXtMpdNKqdA5p/2/LcHbu93TzU83pBNsX80hEjdZEWbWeWfR+BDkoOGwnEWBQpN6FEeHP3ctqi8ZE3npjzYmsxPgl2kjKX8+Z6C2IwDk5PeUSKqPDkp9PoiIl2lyWK1SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CteyUWus; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyDXeHMGDXDdwR5OQUglAdRpIFjL7pLJWShvrfvtCqVlZzv1qR6rsGQpha53rMx4BSMZJc/hxcLheiEYOpU9wXczvfEfWZ31vG4P+fcW6MxLrmkaKcYcPGuFOry3TUs9XArLzHcI6j4VFMW7cgLMIdmX8QMpD0ziRRrkI2tjS/hsurdxjYXEUeeDRBFWbqq+XShTz54uTMfprVxzU2L+CcqseZEOXnLQPssvJ0OSvO2InP6gKdW596B4Odg1cDDJxhf2N/tibwMVsjutaqtpPjPAh/oxrl4e59E+dN/cTxa/CCCmkrNnvxFUZaklEOQbyZNksUS2O+CkmqM//+OFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LN02hg6vSWm6kKkb1R9fjvgIU4ApTNSGO8vRU6GQPM=;
 b=vOdI2i8rUroFJmAKbg+lE9nslzSAu4Bcb6cp6C9XB/8AOqNXijQaHQqFZOwQU0Fc9YBDedVgY71xaz9zA1kGngG7V3GwufuUqUdgdGi6NV4PV2uW1gFAX1mlfq7oUmyVe9ZogHARQuugThQrWB8aIp80UQmykZ9FCd1di400UXDAntibypQLTMHebK+wuISIG3KoyLLPnKfABFXp4Ukr1xhlcws3gxhDWyvgjQgew9NTevqXoH6miCG3rtRmzFEFmMi3dWB0OpA5ITVY63NOkeLcGoxdBQ1NEf6aYgBWFlM8mOiAansCmSSjHv7q/OVw4IXLMD+jioYtuWFhv9p9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LN02hg6vSWm6kKkb1R9fjvgIU4ApTNSGO8vRU6GQPM=;
 b=CteyUWusyQx4/9aoW6+hosIFJhGnYRw8Agi2MjGZDch2VxpK4MZZPWoARcJAyVORPQhz229hnuORd70tIrDlfjvbDitFnP5kK5eEsjUb7UHbLcPQ2wEafKnXQmlX3I/5i/DqwuuPYAjEILoUVy6u5UxT/fw6x0QM062rCv6nuoekz687QWzbSNdx5PT6iGAU9ktwyWMpI8myamp9Agf2uTmilbrXqmN6jEUWlQgR6GEljrperqjsToO1kWt1ysOX8crKMb0r9bNnlsTIv7uytvnk4k+dJ9M6AaUFUIJw6dsJj7KR5tu6RYjnKCz4ZtUcAP/umR9I3NutQzNijTe+7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:38:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:38:13 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 19:38:09 +0900
Message-Id: <DDB6A4RDYILH.L45AZY30Z2H0@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "John Hubbard"
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Yury
 Norov" <yury.norov@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Andrea Righi" <arighi@nvidia.com>,
 <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] rust: Move register and bitfield macros out of
 Nova
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <dakr@kernel.org>, <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <20251003154748.1687160-5-joelagnelf@nvidia.com>
In-Reply-To: <20251003154748.1687160-5-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6afb25-ac6d-442f-db67-08de04c47375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUFtcFAvekJsekNySjhnN3kxbys0Yi83QjEyUjE3SEVSL1JJQXIzT0p2TmhQ?=
 =?utf-8?B?Wjh4WFpSSEpBY1hSQmgxZXptRU9mZVY3YnFDckV5eWlza3N3RGtvMk50aGNo?=
 =?utf-8?B?MTBHNTB6aW9EdEdaMHdKYm5RNlJHV0ZqR0xpMWZPSy9ZTVROMGJBUHFZUlZP?=
 =?utf-8?B?NnM2OGhCQkY5WUpWTDVtVzYvcTBmZDJrQzhXZGswTXhzZG4rZHZsYi9sWnBk?=
 =?utf-8?B?SFhMVGw5SWpKWVVnbTZFQXRub2xlOE5FblcyVXRzb2NMYjhrbmpoZlIvMUE3?=
 =?utf-8?B?NnUwYW9DWWxnZ3lwbC9VNERqVDdmTThUSHVwc0YybmpnRHF3NFFYMnFIZ2p3?=
 =?utf-8?B?blpGcVNlWmZ0VWtwY2VMZXIwRU5TQXZJRFJXZDFFcTN4eWNMdkVHQkorVWhp?=
 =?utf-8?B?YWdzbGtlRG1Ta29wMlZLaFNDS2h6elprODVCTVNrSDBvYWxGc3pndFFiU2Fa?=
 =?utf-8?B?T3R0Sm0rWnFuS0l4UXg0VUYxS3JVVlFKWFNNVDZiRnh0VDVhR0toTWlRM09O?=
 =?utf-8?B?b2kxTURxRjJRakk1Z1BvbWRVdmpnQlE5SW5hWE5PWElNRmtjSXE0Tis3L2h1?=
 =?utf-8?B?S3JjTGhWckdlWEtMMWJGQmEvV0VyTzZNcWVkVk1yTDFUNDk0YWRLRm0rQk1K?=
 =?utf-8?B?NC9wamlHRG11TGsxRmoxNlJORFB2M2xVR0pnenpmMU0weUlrc1k0Tk05TnNm?=
 =?utf-8?B?LzE5Z2ZxaUVYZ1o4UWRneDczQXR6bDZ0c0VqTnI0ZjgvWDNldmV6dW1IMEVB?=
 =?utf-8?B?MGlDRHoxOXd3bzMyRWx3anhHcHBIRE5uZUUyclpBdnFMWDU1OVM3blQ3WUo2?=
 =?utf-8?B?VEpDRG1nNUVjZFhoeXRzNUNTOUZFV1duQUlHNm5penFVb1FTdWFHZS8yMUdR?=
 =?utf-8?B?STR1SnBBNlpQMllrTUV1TlBqTTlBVEI3NFlJYW9aQ1hnQUM5cmNPTGVrd2xq?=
 =?utf-8?B?U2FOQzBNNXYrU2kzVS96NXhoQmN0eGgrVnlpeE10bFlHREZaaVpjUjdXbjU2?=
 =?utf-8?B?OUhnSldqS1BWN3VRcGxYMTdhM2NwWHk4L1dVc2Qrd1dVeVZKK0xwakZ6V3VQ?=
 =?utf-8?B?ZmFsYm1PUGJoc3c2VnZwbm8zZGdRdWplYS9FMG1SUk9tSTB5VmZvYWx3dWxn?=
 =?utf-8?B?Nkd5S0tVVjZXQUlMMGFGZTdXM3JnaDQxSDdzdXRyblRMOU5oc0Rpd2lzbUJr?=
 =?utf-8?B?RHEvYTV3N3RrclUyWHVsckJhVCtGcjVJYkxYblRYT3JpZVJjU1U3ZXlLYktr?=
 =?utf-8?B?ZTZtNzYvS3M2ZnBQd3NYMDI5RzB1UmtqSU5sRENyNVdSY054aVQ2bHk2YVRh?=
 =?utf-8?B?dzc1SmVmTG1hbjAzUUpERU5ZTDljVFRYK2c4UkxNckRIRmhWY0wrRm1uRDRh?=
 =?utf-8?B?M1RrZkFlNjB3eUU2cVhDb2NXWWxHYVQ4OUFSZHNZQ0V2YittUm9NNitCY3Rt?=
 =?utf-8?B?YkdoRlRxK2dKbzNKMzF1d2U1NHBpcDNJcGh3M3VTSE9sa0dacnpvdTFQckQr?=
 =?utf-8?B?S2dXOXl3UEltNVdzcWRtcVpFM3c5VnlkZWRydmhqbHJSR2crejZtYkFYeG91?=
 =?utf-8?B?U1R1TndaNmkyT2dzanQ3TjZ5eEpGTFhROEtybXQvSVBBNnVPMnFaSTBOQWdN?=
 =?utf-8?B?bG9uc1ZQMHByQjVrL2JPZTBBa1pKS3ZVOVhYQWluYXZBNGIvRHl2Y1YvUlJB?=
 =?utf-8?B?b200VzdRL3NWcy9nSkprVUJkWjVtVGpDeTBvOFB2Y2dvTzRTVUZPdWpmZVEx?=
 =?utf-8?B?Q3hMMGZ4aEVUcjRjYmR6eEU1VWVHSGJjVXJVSmg1OFFNQXpxSVNwTjd5eGlI?=
 =?utf-8?B?TUVzRTlERzNqZjJJUkFOTGM5eHBEVUgxUDlNL05jcG93RUdRZEJWV0J6cTB6?=
 =?utf-8?B?V296NVdkTDR5Y012bVd0ZXl6MURYc3lZMmEraDZTUmQvRmNYWk1JejlIYk1C?=
 =?utf-8?Q?A/irEn6Bxk70GI3qUaE+4ngeMEZKtV3c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG1qVXVKemJMSTlSQUVSYWZybTQ3aHR0bCszOWpMVnJWMFFEZGxmdXovcUpu?=
 =?utf-8?B?Mi9EV0JJL2VvT05iMVNReWl1MjlhUSsxNTF4bzVmQXAvSUF5d2pVSGtjRDVV?=
 =?utf-8?B?bUVIc3VDS3BOblZWaGNJd2dNOUJsVUFZeStpN0x5UmlpVFYyZzhNMFZiVyti?=
 =?utf-8?B?dTM1TEd2ZUpRbWZ6R0FTSXlHYmg4SjV5N0lCUFovSjJYNWwveWR6ZFJtVksx?=
 =?utf-8?B?ZTN1Q1lXcVQzNGNsQWRBUUIza3AzSko0VWxKL3o3RHc4S2NCTUg1a0ZNRGov?=
 =?utf-8?B?bFBYU3hQZjhpN2dsenpLeCtjRmZaaVdjbi9zeHdqa013QkZtZTFjbXBuRDlS?=
 =?utf-8?B?NmM0bGFnNEp4cFc3RFhSMUJjNzBGcGJBU0t0KzJ1ZE4yWFpYTWxOSlJaV2dv?=
 =?utf-8?B?VzNONk5ncU5BQVVpYU9EaDVBRlZRTzVhdWZyRUN2MzlQOE1YODBCczRKalVm?=
 =?utf-8?B?aEc0Vkl3Sk5GV1V6SWRHWFJpdS9HV0JmelFERERRUnFwb1k2RUpQeDJwTmU0?=
 =?utf-8?B?RCtVbEJPWnJqOXhWYmEzdDdoL3p2R2JsQTd0TDRMckVqVHZPTDNVK2R2UkJJ?=
 =?utf-8?B?eXdUK2JMTkZSeWxvaG9vdUllZHd4cGdGVWFKemZPcUttY211YWk5aEdNVjVV?=
 =?utf-8?B?RUR1czNmWG85T3RrSlkwZVJQaDBaenZRZUtUWG5qS3o3STNDZmVRSjZPSTJx?=
 =?utf-8?B?TVJtaHNDRUFOYjhFVXdEblpqeWxWWVNrZ01UN0grZWZkdnBtZzdnaW94OTNI?=
 =?utf-8?B?RzZNVE9Yd1VodW5ZSUYvRWtsOFlRMkJxQjFwZ3lESDkweWdQelg4T2ErR2dB?=
 =?utf-8?B?V25WQkJ5a3FPNU9KZGtuODF3c3l2TTZkaHpHZGJNZEhtNzBEaFhsb2tvM2Zh?=
 =?utf-8?B?dGR3K3pzRjExTU56dzJqMlhwN1FBZHhudXJpMFhLcm9xcldydnpiM1piazAz?=
 =?utf-8?B?TVVuRjdNSi9CNzVOL1R4b3EvOVcrelA3NndVVS9yTVdFT2VoS3dYLzVHaC9I?=
 =?utf-8?B?ZGhSVGluSEIzRXpIeC8rVkdHQU5FVk5JVnpSZ0tYQjRTN0MveC81d1duS1c2?=
 =?utf-8?B?NGoyMlR6S3dYQ09JTVVWVU9BTGxQdTUwcXoxaGpxOEFjcFdCNHRKL0hORzN0?=
 =?utf-8?B?clUwdERZcm1CY2ttU2Mzd2ozYitHeE13cDhtQjBiQlVLM1hadEt4TTRiTndJ?=
 =?utf-8?B?QmJaaE9JNDFqWU9jY1c0WlNTZ0c4M3pMclpYT0pxN09PWHZmUkU4Ti9JWTVt?=
 =?utf-8?B?dEI0Ump0SlRkeFVIemdQaU1LNFo2d0Nkd0xVR0lPeHRWYmZwZjN1QWlrWTZH?=
 =?utf-8?B?TVFJWENodmN6SnBha3FEaWpiU2M1cS9PcUtnYW1UTEh6aENpejd6b0cvSzNP?=
 =?utf-8?B?bkZoZFBSUHkxQ0F1bC8zVHdBT1ZSeGgvVjdnS29hb2YvaEc2ZVgxY3dQOGo0?=
 =?utf-8?B?Y2pOT2ZaV1owQlJxUjAzQ0RVSk5RdWFSZkpXTXVsa0xtWFF1M3VOWW5iOVl6?=
 =?utf-8?B?Z2JtNmIwSnp5ZWlaYk9McVoyR2hzbzVaYjE5N2Q3d1ZBV2E3NGJNNGdQVTky?=
 =?utf-8?B?NndocHBaRndqMCtYVVpkeVVlQXYzNnZCR2ErWnBYTUgxNG9IVlhhS2c3clR6?=
 =?utf-8?B?bmk0cHJzKzM2dXhJNy9EdGlvSXYxZzR4NE8zZStxWDNtc2tHQUJtZTJpNy85?=
 =?utf-8?B?MEhRdHROMHJrY1ZXamdpaHJwcnRqVDdUS0gyVHlUOXVGMW44MWl2U1VnNG93?=
 =?utf-8?B?QTZ2NUl2NWlGZ1pKMnF0TU9TRm1zWTM2MmRHcHZ1bkxndGI3QVJkZTFTZVRj?=
 =?utf-8?B?S1MvSnpBdFVEYzNBU0REU3RTMnlOMTBSQWRXZmJzUnFGVlI2M3dpeTZ2aFJt?=
 =?utf-8?B?aUlLTlEyVHRjWjBmdkhhL2UvdVEyNnNpTGRxQVZaVnFzSnVxV2RTaGFsVy9h?=
 =?utf-8?B?cUljT3RCQXZZV0ZtbXpFeEthS2VYL2JuWHlQWEdQK0hmczFvS0c1TXVCcFBi?=
 =?utf-8?B?UzgrbEQ1UkRwVFpzeGJ5U3pTZjY0NThoQzZVdmRBWU5UZHZpZzlyYUpURmN0?=
 =?utf-8?B?ZjNmMXc1Smg2NEdCRnF5Qm9vNThFQ2wwaDVrVFluT2V5U09UUWZQc3JZY0ZD?=
 =?utf-8?B?dEd1UmlzQXBDQnh3WUJmVXBJZ2ZlckdXNGphZi80aVVERjEzaWo3dENwcUs0?=
 =?utf-8?Q?w+EFHegO6/Z5EuGXG0cE1Wdq8mpCzsyZQECXVKNxbWj8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6afb25-ac6d-442f-db67-08de04c47375
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:38:13.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+XRzEMsn33HGI28z/YhuLGBh+Ug7ffAX9GtPTfptUIQKeKctOAw6UBlqm8hAIbOjk1OkBcc7sV2w/nW9psW8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526

On Sat Oct 4, 2025 at 12:47 AM JST, Joel Fernandes wrote:
> Out of broad need for the register and bitfield macros in Rust, move
> them out of nova into the kernel crate. Several usecases need them (Nova
> is already using these and Tyr developers said they need them).
>
> bitfield moved into kernel crate - defines bitfields in Rust.
> register moved into io module - defines hardware registers and accessors.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs               |  2 +-
>  drivers/gpu/nova-core/falcon/gsp.rs           |  4 +-
>  drivers/gpu/nova-core/falcon/sec2.rs          |  2 +-
>  drivers/gpu/nova-core/nova_core.rs            |  3 -
>  drivers/gpu/nova-core/regs.rs                 |  6 +-
>  .../gpu/nova-core =3D> rust/kernel}/bitfield.rs | 27 ++++-----
>  rust/kernel/io.rs                             |  1 +
>  .../macros.rs =3D> rust/kernel/io/register.rs   | 58 ++++++++++---------
>  rust/kernel/lib.rs                            |  1 +
>  9 files changed, 54 insertions(+), 50 deletions(-)
>  rename {drivers/gpu/nova-core =3D> rust/kernel}/bitfield.rs (91%)
>  rename drivers/gpu/nova-core/regs/macros.rs =3D> rust/kernel/io/register=
.rs (93%)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 37e6298195e4..a15fa98c8614 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -6,6 +6,7 @@
>  use hal::FalconHal;
>  use kernel::device;
>  use kernel::dma::DmaAddress;
> +use kernel::io::register::RegisterBase;
>  use kernel::prelude::*;
>  use kernel::sync::aref::ARef;
>  use kernel::time::Delta;
> @@ -14,7 +15,6 @@
>  use crate::driver::Bar0;
>  use crate::gpu::Chipset;
>  use crate::regs;
> -use crate::regs::macros::RegisterBase;
>  use crate::util;
> =20
>  pub(crate) mod gsp;
> diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/=
falcon/gsp.rs
> index f17599cb49fa..cd4960e997c8 100644
> --- a/drivers/gpu/nova-core/falcon/gsp.rs
> +++ b/drivers/gpu/nova-core/falcon/gsp.rs
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +use kernel::io::register::RegisterBase;
> +
>  use crate::{
>      driver::Bar0,
>      falcon::{Falcon, FalconEngine, PFalcon2Base, PFalconBase},
> -    regs::{self, macros::RegisterBase},
> +    regs::self,

`rustfmt` was not happy with this one:

--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -5,7 +5,7 @@
 use crate::{
     driver::Bar0,
     falcon::{Falcon, FalconEngine, PFalcon2Base, PFalconBase},
-    regs::self,
+    regs,
 };

No need to resend just for this though.

