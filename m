Return-Path: <linux-kernel+bounces-766073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C2B241E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A826803A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828752D3237;
	Wed, 13 Aug 2025 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xbrOMBE/"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A022D12E3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067912; cv=fail; b=CO65S0Le2Cjr9KyUKpoVNYrnxEUtVFKVSAMb+Vj7b1ZHW43XKbo/7+kat33DQd/52NkSFMSmwm4LcM7Q0B70BOl3OaLgXE5cXP32uOfgkDa8rswYWOCKryfpQsxxM4B+iaPdgWoUVugUu1pX5sdUD2jXVpg+Hsv6wJ+pfP43HnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067912; c=relaxed/simple;
	bh=6ye1Nt10CTFtgMxwkGfRQHv0sH7OQwbQl43L0WhcY4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVhFC/wFbOFqUs44+UwITuImbjGI2dMSx0RT5s8iEUeJzwyA7bW7tBxNazla1GTwtHNnxz5TFtMp993mdt1vOD03018YRHRvjtyPBvSD5UlW6MsJt+ifhC7Cs2oqp+EnvuDtOTQZhqmSJd5r0cNPsTEzjCqwGwu5z9jaIzW2OeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xbrOMBE/; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSVt3JOkd01EGEbRt92Dag7kHQXppico0wxd92jktgMigfqZ2bxBINctj3v6FoBZzi4/K5XkkhkHTK5BNWlPAfj9f3+sd7YOjUofIFM7w4tLoztz2LI8Sjhj8R+xWBSOKHuAjepNf2/8vFl75enjLHYVQjm8Mf592bXQPsf+HoSa+is+rHP12N4xVVMGFnIC/6cCB3FicSawNF77AyRoV4NQlQM+daa5fcp5UAVlwHYCsvAq7BYWySsXApw25L9EcbNUNMae3ta/XME07EH4v8VmLz9mvTvDqHBRinwzxqrOSlv77clZzE/7gevBiOAgKAutlt19u1WRwmu/4SEzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3s8RCBEi54+U7lsMBCecbu7/MoniJWSwNGs2KNpNss=;
 b=Wnt6Wlj9GKYz4EfsB1I7QVA/8U2lG46kaqqumV0LintpRrNJXkKyTByn1hMwRTibBB9SBLH4boQfygTgtgXeeCcbUa06WVypxbFB94AiMjpX6KmEMmNU2DMdxnHFMo+N8F3YjJzwv9QhFRbSvJwbJsClaYk3jvEC7lFQl9FGzdSZCM05dSrUbGCTRTWbD0vm0OZ5v/XZtBiQgAeqlUKuL/zBz2eq1lE9QrcO/J+hfn2B4TgtPuUa0mKyW8W3YxKMhX5TFq4lKZMs72PkcFaAkSrRAB/rroPTjYaUfolsJ0QN3y5ijkrrPA3DvDRyYwT2wQxXBY7VUB35fSl1CBvfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3s8RCBEi54+U7lsMBCecbu7/MoniJWSwNGs2KNpNss=;
 b=xbrOMBE/MeACTsoqi0+jNbb09l4m+UvrrtjnVMs21pA+BNfoxlpMvKKuOzpDfR3S2JCvsecQ829M8k1yJxDEoRmbfiRnon0kvdoTZZY+Sn1BPFyH+AnLvIRLR6rdXgZ01Y/wZLDYKVASaYs+G3OHntRCYihidKU8u0IGnDupj/8=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.23; Wed, 13 Aug
 2025 06:51:11 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 06:51:10 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Joseph, Abin" <Abin.Joseph@amd.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"yanzhen@vivo.com" <yanzhen@vivo.com>, "palmer@rivosinc.com"
	<palmer@rivosinc.com>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Joseph, Abin" <Abin.Joseph@amd.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] dmaengine: zynqmp_dma: Add shutdown operation support
Thread-Topic: [PATCH v3] dmaengine: zynqmp_dma: Add shutdown operation support
Thread-Index: AQHb+tcJSqMhsTa22EugsKlmtOnZL7RgR0FQ
Date: Wed, 13 Aug 2025 06:51:10 +0000
Message-ID:
 <MN0PR12MB5953134843F6FD10B839FCA5B72AA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250722070255.28944-1-abin.joseph@amd.com>
In-Reply-To: <20250722070255.28944-1-abin.joseph@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-13T06:50:55.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SJ2PR12MB8875:EE_
x-ms-office365-filtering-correlation-id: 572f859a-14f0-4833-7da8-08ddda35c96c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h4Bo5nJK5FLJhnnqUQBNzdXpXKCefwx/McPdjt8SayJj/eqivgsobPQOWgfS?=
 =?us-ascii?Q?AqxodE0TXoWd7PPQV4t25zkeNKXPRti3+DPemLZzvcewroQjZx0DPDvGZ2nB?=
 =?us-ascii?Q?ju6OQmJZNBAdX95SZg4Q+Tu5fDtmhdZ83or6nJA8vd0Kqe2ZQ1FS36+p0ojP?=
 =?us-ascii?Q?vM3q8FjReB0Ci0x5aDrRTIjrv6QcO9pJMNEmY1tTXTTV7055D/+ryagiE2Zh?=
 =?us-ascii?Q?0bJHmBy3oEJSQw/XPhykpfphQ4GJsz4DzwxDWzdek6CFZqNwEalmOBdlNHXh?=
 =?us-ascii?Q?gadpYiRrxygQ6F2N1LpRe8xS4bqrb2eISDxMPSeMaxsyeABaIsqVB6g3fS86?=
 =?us-ascii?Q?N2OcQ6MWqrk69xvuBWeMpaTq7e6gID3noMhV85qJ+rDsYbil96Enfi7vGHBA?=
 =?us-ascii?Q?Ia/miuOKZTT25E7DAEHErEFoWYyx8P618hP4UqbLBdNpd9g7B/HzPx1tGblW?=
 =?us-ascii?Q?A0PaQoQoPwEtvtxSaELW/tsqtJUQPI2HAcyjox3HkLBkZxPUul0pmGCQWjaP?=
 =?us-ascii?Q?b7sCBDYXe7AuPx0KtGun324QzVPI4fzSYVeNmATzvDGsJ4oApd+UUqdB+9qa?=
 =?us-ascii?Q?OqgoHOEVCRaHYYEApDwewwJBOh6uoIejAYXBNc10tP40Ba5G5aQLw2YdfmSP?=
 =?us-ascii?Q?HVxjWhOB2fdIRkDRldrEDBGCui1h7Fypsq+tENQ0yetBbqKFPogccEe7J+i0?=
 =?us-ascii?Q?dbdIUCDjcWhrBS3svDGV07MZgTWFr8yxe+C6Ck7y3HONfbDYpnUYim25rx85?=
 =?us-ascii?Q?ZjV2BpRd2T/pgxpcULCshxkz7r1NIf5W04UYkqJDqspXvkAGpEH7lSQ3io4M?=
 =?us-ascii?Q?/ImI/79vmEWJc1Rlb7fluwdabmh3SCOHhvK3MLa3jVsBOQg5lLamt+qggPRo?=
 =?us-ascii?Q?suw8B+GbzlDAK6lH1kivxxLA/ML7dyyv58IMQNlPzZspoxgTCRWnFNqhBh3p?=
 =?us-ascii?Q?74MM4ip3hNlDMHNIJZ7Xq55L+8dCVNwNiGUEKb7h3kLiI8Br6FjMhYu3x0d4?=
 =?us-ascii?Q?4lwCNp8bWVrdfz0ESsrnKVSc5KKJDz9MFlRoio3w8pgXHO42qrI31Zj3P4gN?=
 =?us-ascii?Q?i8l9W/eDakPxUKm66+0+BhvL++G86TcLenNGaNCbOtI2bZgVLoXzN6V71osy?=
 =?us-ascii?Q?k100QrX/R6Znz5y0n0aF1fOs/sHOq3pABqCs7HMmNNzsFEDlVvLIBjqzP9mg?=
 =?us-ascii?Q?7F9Lh7LZdp8fH1nwAeuIeKFX28h12RxNm+n8H7rTFYZZ4q93b0J7ZJqpWusN?=
 =?us-ascii?Q?YwJyH1K1ZyV3HJP8S7cNwxlRGr10XqjoKDKn/ZDFh55x8/P7prqdibX5IzJc?=
 =?us-ascii?Q?0D3eZJCvk6I5W3BppKnGkzvn3iJrLamfqSz6uxr9sBlk7OYTSMF2HOM68uBt?=
 =?us-ascii?Q?vL6O1UxPv3bJPquU0pVuQzkP4RroaMgGE/aPATnUMpo64PusVdFjMAQ1bM7s?=
 =?us-ascii?Q?SFpliBTSxb5L5XpOuMJLAOPicDS8FhxRCYYq74Rl7BsyOZy8gfDOAN3sLvFM?=
 =?us-ascii?Q?LThnyIyB6uCI3Is=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T+7FvCo+UydjaKrFFt67YjAu2tM3b2kw/ICVfSnW9fFUKcAIRMw9ZYIzrcgi?=
 =?us-ascii?Q?fhCC5JO2GFmHFQ4/9WLU2RfDgX0EMSm3UCrDX593Z9lzx1LaALlRGbQ5R9Dr?=
 =?us-ascii?Q?PE0jNAtRFbdHEPZbkH+mhs6qsPHxXxmk78o+ZWx6QJ5ZMfoBmttNm2Ff5Nqy?=
 =?us-ascii?Q?yk/2YHSx1go7Ef4NeeBP678niHSCz5pXyxKpPEzK3u5qLJhAKgmTpHEYELEK?=
 =?us-ascii?Q?pvDSlTrNhU1S8sTGAUHqfCcbRZfOFPT76NTgNLdnfjTeg9It6psGb+PVsMAY?=
 =?us-ascii?Q?JdNJtH81FtUAZrt0nRQnK6qmPKBpzYGsa5lrSH9YB0UZKp5mV1fTdR6bKFg0?=
 =?us-ascii?Q?VAhKq7N9h3oGOWGuuNmhezEoM5OvjEDDTIKBN+3GAwEu3JuHmSvY7KfYkHof?=
 =?us-ascii?Q?NoINdzuBTvoEC7Dl7XrBfh77nksD98e2mckAMFRIMezBxLh+MvmMVhoAm9d4?=
 =?us-ascii?Q?v2xSu0KBDxSHIdRh/ETULkm72PVYTn/ipgze60Q2+4aDVWRUgie90nKwksf3?=
 =?us-ascii?Q?pH+kujKPgAJsOanj2FZYeEetnQBqGrlwABFXzwJz/0SOUGmqiCcJTgnUV/iN?=
 =?us-ascii?Q?0I76+HgwWVCcCBFDOZaxtnihkAYA3ZPXI0QeO2QyQIUeSX6SsASSonzw+OcZ?=
 =?us-ascii?Q?G4IF2ovPXn6KnaQMfOytnO/VYFC6+E2SNdoSmm2l4AFZbNyWMCtz3Df3PPoj?=
 =?us-ascii?Q?i7PVt5s4Xps+3KBEDMhIg+rgrM0mlE0+TvNJtQU14t0bwygZqmxVcyVMmGvK?=
 =?us-ascii?Q?ZIuby9dKV1Q2N7oZ3dwEJaiHPY/nqmkGBQsgEUrpUSAbRvKdbe8LeJmvgeGR?=
 =?us-ascii?Q?ClhLPBeoZIntymwU4FP9QPov17m9XOs2s73rNlrdB6J6bJn07uTTz1NWVaAc?=
 =?us-ascii?Q?14PLWbBCf7z0Jno5mJRMaxyKlxpZgGo5SM9RPkugnT3aq/p2ntfIoTZZ+/Tb?=
 =?us-ascii?Q?ClIgo11ugcXRH4MP8Tw6ghVb5+GGpmAZn4snOsx6qMg/7VW6noVLccyep0hw?=
 =?us-ascii?Q?mU0/pVmj0AtcDLFnEDqoXHJii++ZOWqC2GOENELu0XAY0E2l6eEgQBM87jHm?=
 =?us-ascii?Q?G8CumkJsqbJp0VU424WralB+Yp2o/fizlTDjjzbF2KueJnF803qWjmMuAP7c?=
 =?us-ascii?Q?sDaI0DTcWe9rCkrD/HGUtnI4alu4lBhrvob6MSY8IGc8KHRt+OuKOrUb7uPg?=
 =?us-ascii?Q?6B2DMecM8IDeusAAlkRgIMgW5gXx+vZR2LN9lGPf1tjJ4EbGIUMOA3ffQq+X?=
 =?us-ascii?Q?FpGZxtYGncjL5+4LuC6ZapXaDuh4xK5ba3KZJ5vDClyb98n7o6QuADIcL3ok?=
 =?us-ascii?Q?0WMwUoMA3ALhryTGeTr361tA1goFHbaTC2QbeuyW3+ZWj/rXNeBiZdiABtCF?=
 =?us-ascii?Q?StqSk7XQZa0AdHDtRQM/PyKX3JEcMdjKqqOPW9IWsygQC2syNbsAkfuNFTN8?=
 =?us-ascii?Q?vywZ06+/nlyi9sXfAV6EJpCAYUl32dMtZCRALMyUnB91qmxHi0qWOgCGO1TN?=
 =?us-ascii?Q?onbP6jHKRsmB3A0FYvrqQ1PCb1h0nlW0zrMAX609XUSR7UWmzc+ygqKT3rIF?=
 =?us-ascii?Q?iH/a0AY7yWgJODZ1WxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572f859a-14f0-4833-7da8-08ddda35c96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:51:10.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJ6fgwFJaQOS2g/AsfUCSj8CRXrPR5ipuyxybgiI8H6Q+gJHZoTrYvrtJCOLHu67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

[Public]

> -----Original Message-----
> From: Abin Joseph <abin.joseph@amd.com>
> Sent: Tuesday, July 22, 2025 12:33 PM
> To: vkoul@kernel.org; Simek, Michal <michal.simek@amd.com>;
> yanzhen@vivo.com; Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> palmer@rivosinc.com; u.kleine-koenig@baylibre.com
> Cc: git (AMD-Xilinx) <git@amd.com>; Joseph, Abin <Abin.Joseph@amd.com>;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v3] dmaengine: zynqmp_dma: Add shutdown operation support
>
> Add shutdown callback to ensure that DMA operations are properly stopped
> and resources are released during system shutdown or kexec operations.
> Fix incorrect PM state handling in the remove function that was causing
> clock disable warnings during the shutdown operations, which was not
> implemented earlier. The original logic used pm_runtime_enabled() check
> after calling the pm_runtime_disable(), would always evaluate to true
> after the disable call, which leads to unconditionally calling the
> runtime_suspend regardless of the device's actual power state.
>
> During shutdown, the device may already be suspended with clock disabled
> from the autosuspend timer, causing the clock framework to warn about
> the double-disable attempt. The pm_runtime_active() function checks the
> actual device power state rather than the PM subsystem's enabled/disabled
> status. ensuring the runtime_suspend is only called when the device is in
> active power state. This prevents clock warnings during shutdown while
> maintaining proper cleanup during normal remove operations.
>
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>
> Changes in v3:
> Update the commit description
> Update to call remove directly from shutdown hook.
>
> Changes in v2:
> Update the shutdown to perform same operations as remove.
>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_=
dma.c
> index d05fc5fcc77d..f7e584de4335 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1173,9 +1173,9 @@ static void zynqmp_dma_remove(struct platform_devic=
e
> *pdev)
>       dma_async_device_unregister(&zdev->common);
>
>       zynqmp_dma_chan_remove(zdev->chan);
> -     pm_runtime_disable(zdev->dev);
> -     if (!pm_runtime_enabled(zdev->dev))
> +     if (pm_runtime_active(zdev->dev))
>               zynqmp_dma_runtime_suspend(zdev->dev);
> +     pm_runtime_disable(zdev->dev);
>  }
>
>  static const struct of_device_id zynqmp_dma_of_match[] =3D {
> @@ -1193,6 +1193,7 @@ static struct platform_driver zynqmp_dma_driver =3D=
 {
>       },
>       .probe =3D zynqmp_dma_probe,
>       .remove =3D zynqmp_dma_remove,
> +     .shutdown =3D zynqmp_dma_remove,
>  };
>
>  module_platform_driver(zynqmp_dma_driver);
> --
> 2.43.0


