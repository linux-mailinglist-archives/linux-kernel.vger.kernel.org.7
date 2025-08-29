Return-Path: <linux-kernel+bounces-791028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63330B3B14E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E398399D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E520F08E;
	Fri, 29 Aug 2025 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uSOn3ANY"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868BD515
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436632; cv=fail; b=m3J1d0qNNlvKMQ04K+Sn5ZPEuvZPy6PDpyWJlFeR4FrbHlqZYnj4LablO5DjCkLUl92mqgiQSgu2hCEpeW7QP3/FgvJTCUb004ViZBzw7mLja/VZBt4D4e0t+7L3PZDAocqSuQ4tFNYSB2Jd4Y3ZA72Z7HscO4Is9JmjJ/Ga2tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436632; c=relaxed/simple;
	bh=gUsZfk+dXKNbdHnC5AzbGlY4ZFRYo+I+aMouaBRoBr8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=ifuazALHEbwM6l/ZxZef/zCsWW/5jJE2h9E4/auEX4g1OJHwwTr5KhKarh+u2Wn2yMTeVNhtt2IwE9yxt8FK3Ln+0iElH3G1mkWCtZ0LrLWjntsRmbYdk0KxURU9aS82Yh3IXKz6rwzTGkU8PyHhE4FiXpPMHicuswnMMevm5Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uSOn3ANY; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrlmsqa/3AVQIWAnoKK3LQCLqD4JcFIcZy8lCxaH8a6RxCt+B8QO8fgzpMVa3FB4WDg1zfqGIDL3QleXNwNb4jhmteCLE6JCOW4V6cHt6uSiNsmz8cscQdvLv6sWzPPLSpfGC4h2fEpoYm498DLikxYyd9tr7rN/su+5CCU1G7M2PKBxuy2DfOVId+ID0rSk4tIo3gkVMhKynnKBhCTSGzEf4JB+PfNPowzNuQmbFqJwAdQO1T2w69xvIFOGI4H1PPV0h8jtPo3ZjpuXIIBO2XJJOi1GeWJI60BZj2+MJwRFW8i8apzwyrrONY2Z2dvsAgnr4atwGCiBPTx3TjKkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUsZfk+dXKNbdHnC5AzbGlY4ZFRYo+I+aMouaBRoBr8=;
 b=wbPLg6+TXIZar7rByeU8GvijRG+1Gn3y/SOrTYVZ3OKiwRr/229D0hDW1u7uRKsheAGlkX0fGmASxUSEu4TWY7f4OMNlOz7pkaFd11LzOivfz744U0xKzULyqL854Dx4hNnosrFQ6v/0mehecCLb2LhnKlDdt07chvd16oVbpnPT0D1m5b33dhZ64HZ1CbwNVwwdwa2VJB/iaD9fv4glnVuR59vMM56YeD4KtLzmjpVZ+JAxtXFDYlOkdkX52OFf6I/ZMR0iN94Nli/dV6ee+SI6JnKZbyk4J/LKWBPqnLei7GCwATRg0ifQ2d1SB9rpC8WqrRBtTz3we9fsm0kyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUsZfk+dXKNbdHnC5AzbGlY4ZFRYo+I+aMouaBRoBr8=;
 b=uSOn3ANYzf6lQ4/SQ7WdXKI3mLFIl11Gf1qBwIyAkj7F//2ie7TOArPaQv3fhYhmtokiOWVekPoC455gcN9ly2Ba0hskURki9BW+f3fjA0Vgs24AtEhs+I5HOEMgjwHVqCfJmx9TQ0wKC6TQiLx5hd5kW7jdsXS43qhs1ZsfThs1f9XOWvRiGbMKCD2eBwfj6YUz0JL7ArnJYmVvsz8H8hunGl5GSWuhvaw3zHdLF+zSJ2KhVUR11lO435/luWnBTM4TbXVLCKeOrSJKVpFHS8EQBknMrmBv53u++p4wexe2NEdKGA/9hiCd3CThyIEgMwVI1EAIx5vf6TwBibK+FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 03:03:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 03:03:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Aug 2025 12:03:38 +0900
Message-Id: <DCEKTF8CP2GF.ED9G9ECQMBHM@nvidia.com>
To: "Miguel Ojeda" <ojeda@kernel.org>, <apopple@nvidia.com>
Cc: <a.hindborg@kernel.org>, <airlied@gmail.com>, <alex.gaynor@gmail.com>,
 <aliceryhl@google.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <dakr@kernel.org>, <dri-devel@lists.freedesktop.org>, <gary@garyguo.net>,
 <jhubbard@nvidia.com>, <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <nouveau@lists.freedesktop.org>, <simona@ffwll.ch>, <tmgross@umich.edu>,
 <ttabi@nvidia.com>, <tzimmermann@suse.de>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 00/10] gpu: nova-core: Boot GSP to RISC-V active
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250827082015.959430-1-apopple@nvidia.com>
 <20250828083737.22214-1-ojeda@kernel.org>
In-Reply-To: <20250828083737.22214-1-ojeda@kernel.org>
X-ClientProxiedBy: TY4P301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1aca29-aaad-4d7c-5606-08dde6a8a8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDRuaG8wMTB2a2lZaWxjZ1Q1cGt5UVBuQWVHZHFydEljbmVSSVkrUm5SdDZ1?=
 =?utf-8?B?VHltU2pDVEhrWURmUncycFJsNXZpV3FjRlphZnFkWExZb0FxRnpZU24vN0p3?=
 =?utf-8?B?UU1UYTBGajBaLzFVYjRjSlltcUVQdGVuVkdHekptK3NqNUNxcUZWeXlXM2pw?=
 =?utf-8?B?SnBMZ3A3OHlvZExlQm1XdjVIRVhHK3V4WUYyTGMyNzdhWktWdnlvNjhqbmdp?=
 =?utf-8?B?QWdiSWIySkZyem9QVUswUGtERm1GL1JGTyszY0dtbVBvZ0IyRk40bEZtK0VH?=
 =?utf-8?B?ZFJvWjdNSjVad203OE9NVWpZZmRhRkFhMGw2VVk4MmpacTBCL3plQ1FvZU5w?=
 =?utf-8?B?bE93eXVNSy9EWU9nZlEzUXRMU1BlZFJPU3pSV0YvY0luRHhlTCsxaWFKdU9l?=
 =?utf-8?B?bGZYbk44NThHMVlMenJIZy9qVnQyZVBNRTF1QW1tRlBKb0F5Q1Q5QjZMdWQv?=
 =?utf-8?B?RDlleithRjFiQkVKUWhwOWtSRnRqM2IyeWtVVFhJQXBFWDFIcXNXRm8zNnk2?=
 =?utf-8?B?ME1TaElGa1VYZ3dXNDZRVkVFMFFxYXVxWkhvRCt5ck1NYkZ4WUwyU1lSTEdZ?=
 =?utf-8?B?Rlpra0hXN3E3SlRQT0JNVU5xTkdFbFFaeFlUTElBb1JqeXEwMHRGNlpLMG9l?=
 =?utf-8?B?RDhpblkwUm9IZ3RHMjd5d1JNaHFQVWIvWXVmNlI0c24wbm5lWnphK1BmSmhM?=
 =?utf-8?B?TkgxMWltTyt1ZWtTN0p4SzdBaW5IcXMza0VwYWk0bm9ycDRDSkQxR0kyZUI5?=
 =?utf-8?B?MlhEenpWS0VhWjFWSCt2OGpiMlZOS3ZmMmZkQmlQUzdXdEk3UDBLeVlGY3dp?=
 =?utf-8?B?dnBnUHJXM0U5b3VxU1ZCL3JYS2tJSDVQMndDYmQrZFE4cUtaVjJtMFFENUd3?=
 =?utf-8?B?UXRFVTl3VFh1ZFRjamJxcGNIYWZBdmFwVEZWYk5ZdzdHZlhCampRZEJ0Nm5G?=
 =?utf-8?B?NmZOUVFLMUl5WnUwRURNSXdicnJoVm5WU3Q3NXBzdFV0TlRsYVhuZ1NVU0Rm?=
 =?utf-8?B?M09jaFlvVytidHJoeUpycWUvTnJYTUVJeHpmNXdBUGkzWmpOTGdBZ29rVE42?=
 =?utf-8?B?cXlWZU1tSEkrZXgvZUJhOXo4dEdJVkExNm96aUsvZktxWGN0dlhaZE5FUklK?=
 =?utf-8?B?c0UwMUdPVzFhdmQ2Mm1SQWlnSWlXUTlXM3lvZWRRNFNrdzR0bW5YMTFCM1Fs?=
 =?utf-8?B?aUQ0cEJmWlcvaUg0N2RXclpEa1k4WHdrNXlueGo4bTQyQmcvbGVqdHZFRmNP?=
 =?utf-8?B?ZHl4aTdwYTRxSjh0VGltcC9tTGlxQUdUVEgxT1c3d1NEN2R3Ni9DKzVqTW5I?=
 =?utf-8?B?YXRHM2hvVC9EcHU5TzZoRWdQWXU3ZE5qQ2JrQyt6bTFob2Rzb0ZxRGpRQ3dq?=
 =?utf-8?B?K3k2bzIwSjI5S1h0WlpYMDUrNm1rdXVPN1d2a1dzYUZ2ZWRybnRIU1RZQnZQ?=
 =?utf-8?B?czMxbW1OMUc2dzVTRGpIUHA3SkZJeW9QR2FqRDdDTXd3OXd0OXpQeWJSKzB2?=
 =?utf-8?B?NUV2N2hIWitvVGVMZlIrRHM1TTVFNkltVnZVUzBnTVZYZkZRNkJtdzZ6MW5R?=
 =?utf-8?B?TmhBaVVMTnJoSyttNzQwZ24ybFNBd3EzNm1nOVJUVG9qRzMvUm9lRkk2ZDY5?=
 =?utf-8?B?dnFCWUdTUDZINnJVVWpNbGQ4aFpLNE1pa1drMEFITHhsMy9sN1V5NEZRcUFx?=
 =?utf-8?B?ajVEMVdQRVA0STlPdnp0ZW5LYXdwMytDTlA1QlNDSkJQSzN3b0hJSEJCc1M4?=
 =?utf-8?B?T0RvWTVsWEZrTU8zNjZ0aC9jQks3RVlNMlpOeGRyakY5enVWdEQ4VmMrbnRQ?=
 =?utf-8?B?Zmt2dVFsb0FITTRVSDhsVjV3UysySm0yeVQ2ZXh0TVIzWXBxS0JUY2JrUUYy?=
 =?utf-8?B?OU9wKzdncDRNdVphd2Y1VzBUeW9YTE04elZaZlR0ZnI3MWJ6K0NtcmZRVnph?=
 =?utf-8?Q?JJVj6p8oakE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0J5ZWk3OXZKSFU1MHdnQWJkZEJXOVBJMXl1Rys2RWZ3NlRsdFNZdUFQTWN2?=
 =?utf-8?B?cGtuQ3krWEdNWmkySWJBNXQrL0hXZ2pvOGNZNTUrd2w2MkZQUmxuSDEycGNV?=
 =?utf-8?B?Sk50ZUJOMTBXdHp5Mm81SHN1MmFIM2tDcjhlWndkVmZEL1RIUEw4UXF3OVlh?=
 =?utf-8?B?TGIwM1dwRm1YdXNZaTRpazkxcVJCQlFDSUdUNHZyc3ZlNGVEaWs3QVI4VVRj?=
 =?utf-8?B?SkdWTjBTT2ZvbFBybEZUZVBqRUpaMDdmbFJTOXdzczhEQUVxVXhMRm8vdmM3?=
 =?utf-8?B?NEZpU2FRdC9PVWQxZ20wZGV0dE1RZ2VxQUZjRGpHSVBjQ3hZTm1BTWJzK3k5?=
 =?utf-8?B?NWh5Mllaa0I3SVY5bkVpOEdidm83UlQvQmFIc3lJdkUxOXNkN3ptQis1WmFm?=
 =?utf-8?B?eVJ6akVxRVBadlZNTzZsOWljN05DVWVDL3QzYk1rRXRPYTZlM1NyZ0RhOHVa?=
 =?utf-8?B?RGNGZGRYODdwOFdHWTJrZW4yeXFkbGJHM0ViOVpiUWpQZU1tek1OQzVrN2Jo?=
 =?utf-8?B?VFFaYU9yVDN0K3NzVEVNL0ppakdIYXJXTHpseVJKTFlRU0RXZE5QazF4ZXhx?=
 =?utf-8?B?ejZuaFdYUjFwRVZFbUJxWW82eUJQdVBRZWkyeHlaT0VKTlB2ZzQyQ3hTQ0lr?=
 =?utf-8?B?aG5VdHpyNW80WURpSGdEZmZKSzhNbDZpV3lTbGJ0elhkcVdEdjVzZ2ppS2xl?=
 =?utf-8?B?QjgrZEtlYlBzVVlhbE1JVXBYR05aWGVTZWQ1Y2ZyOFIwbmgybEQzQVkrUFkx?=
 =?utf-8?B?MEpmUVNLKzN3Tk5CK2xpUGxRNGdjRmNpSkNJempvUUhIUkdyMVFpcTZFVVZC?=
 =?utf-8?B?Sk5uRWlqeHM1TTQ1RmRuaFJKMW52a2dMU3JRczVoZmVLQWllUGNMUERnTWU0?=
 =?utf-8?B?b09UK0Z6WW5JbndGVmJLQzFYNStrTG9hN3lma2lTbTFGUmtaOVhkaytpNUlQ?=
 =?utf-8?B?cGNZVUphRnRJUzVzbm1renN3VExJN0NFQ2Q0RkQwOFEwMk1FbEs2bjNnS2M5?=
 =?utf-8?B?Um1Ob3dkSUw1WXI4OGQwMmRlT3VPNnpxKzdtZFpnK1d1bjA0SUlTWStJejVh?=
 =?utf-8?B?M28zWlQyeS9jOVNKcFVyREsxUFV5djNqNStEWWdKb0piNzNNaWZ4cVZ4VFY5?=
 =?utf-8?B?ZzN2VFNKT3VGeW1lMWJLZ1RtMVlKaGptaEJZayswc0tmRFRTbjhBTkN4RWtL?=
 =?utf-8?B?WC9HR2NkeWhRMDVBYnhkaFBkT2FWWWt3dkR4Y0dWNE5jcWxwelFUWk5kaVNZ?=
 =?utf-8?B?QmtYRGZBQzFhbUwwVUN3bXVVVGU3cExGOFVFL0FPblNUSmd5QmY3ZzJIbU9y?=
 =?utf-8?B?MWxIL1NNK3ptRHR5YVF4MHpGYkNUWGNpdnlpVlBPL3k2eXhZdkRaU0xnSDVS?=
 =?utf-8?B?TjgrV1E3aVdyNUxkUmt0RkFRa0wyS1BIR3NyWkxYYlhPbEJCcG16NFVMdnh2?=
 =?utf-8?B?WDBDWVY5UUdzL05LcytvWEQ3TVFlM3Z0dm50WXkxcmZnK0RJRGsxaGJzTjdH?=
 =?utf-8?B?OG8wWWFNTTBXZmd5ZlI1bmR6c3FIOGtXQWlFRURQY3owSUpwZTRzK1I4TWJU?=
 =?utf-8?B?Sk85MG1HMGNKL095dTY1UnE4VEdSZkd1Wk1xWG9NN3pmbStZSmhMRmZ4UHdP?=
 =?utf-8?B?TXpQR0JrdmhYcGx2d2dncmxvaEJDWHlWaHNVSzJWZGhEclRvc3B5djhJcmkr?=
 =?utf-8?B?NTV0VkZTbnZZdmE3anNLM29KU29WSmRwY3ZzT0lKbGZQdFIzQWJmODdXUTk0?=
 =?utf-8?B?alN1K0RiNW5yU1kvclZ1Yk1yYy9rbnJ2N0ROcEgyTHA0dEZ2bnVvVzdNWUpB?=
 =?utf-8?B?amdDdlFQclZjS28xYVVnWWd3TDFtblpka0phTnhxMkVUZ3BwTUhQNlY2b21X?=
 =?utf-8?B?b2t4UXV6SkJsOFlSbkR1MGpGajNncU1NbmxzMFBPaTN1K0pKZWx1cmQ5aVJq?=
 =?utf-8?B?bE1xTEFMc2ZCR04zb0JJb0RNakw0T1NuSnpXOVJtY3Y0UG4zbzVpWlFRTnAr?=
 =?utf-8?B?eW1DYkhaWWc1QXYzNm9sdjM0RW1RU1pmTnJOK3RLdDZYQ0x6b0ZmYmVUa0Vr?=
 =?utf-8?B?ZGIwSlR2aXNucklyL2dYQ09Wcmh4cGNUenF4Yy80OGlWRi81ZGZIRU5lQi9C?=
 =?utf-8?B?VGpIaDJ6ME9DQ2QrQXhLdCtXOERNdVlaUzBIZW4ybTcxQS9DcWFlM3V3NnVH?=
 =?utf-8?Q?a1ZL6d7sayYU3WNlndel6rQmKHLtLg2rJy57xyKCi/Zr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1aca29-aaad-4d7c-5606-08dde6a8a8f8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:03:42.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkC/vY7r2dxQRumM4R0//fT79RSojA2f5O+H+bwBwEzUZcDyqhn1f/rOwJYeb/QOBCNWsMdKCkpDHupueMV+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637

On Thu Aug 28, 2025 at 5:37 PM JST, Miguel Ojeda wrote:
> On Wed, 27 Aug 2025 18:19:57 +1000 Alistair Popple <apopple@nvidia.com> w=
rote:
>>
>> This series builds on top of Alex's series[1] to continue initialising t=
he GSP
>> into a state where it becomes active and it starts communicating with th=
e host.
>
> No big deal, but in case it helps since probably it was not intentional g=
iven
> the rest of the people is there: the rust-for-linux Cc is missing.

This did happen to me once as well - should we add the rust-for-linux
list to the Nova MAINTAINERS entry to protect against this?

