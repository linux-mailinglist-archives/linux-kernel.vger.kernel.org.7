Return-Path: <linux-kernel+bounces-772557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D9B29424
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D6D1967171
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCF2E7BD0;
	Sun, 17 Aug 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Wxyys2zc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2025.outbound.protection.outlook.com [40.92.41.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58129A33E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447996; cv=fail; b=h7p1RHkgyyZbDMpB7r+GBRPHPeSY8ot5ac+c9um86q4ZHw0irCwdXfm+Na2XiX8pPgXlAOqG+ToLFv2lXVtTvITRoXtDqsuxwJsyiryDP1OShlSe7u+PNfIlbfkJCjo1ssqYCOBulrrxGMwL+c1eEplJylpURfGPf5dpp4146jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447996; c=relaxed/simple;
	bh=pYmyptbEAXjOseEzCRBkrm+Cwmv5ZeUbKybchhxqXvk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FgsVvOE8v08M+lywxwrXl8PubpF63R/yatIbSU5hhSTyKBEKpcD9laDLSpIHZCqGt6IYmMdAbb+QTLdVNoAywNmqd3lrhfjtBmtbHOlsu2RtNyylLOrgeUgPbnLYju2mf6lkRu+C9Idp+VBzc56n0HCmdh8fDkR5yqd8CFDjl6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Wxyys2zc; arc=fail smtp.client-ip=40.92.41.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8Q6aQk17O910d5QiTpn0wXckg7x5n4RU83QLctyFS2R80il+2QDX6rvdCGNsW8UxpY3vapWddZvp0yNm++5ewXNVfVIbEFkfI3Pn9l8vlz275bgg6GzB5u+Tm6WV5vqLjDEr8yGwQxBT1znU7aqT0eELKsb5RfFZhLW/q9brAahtn57TIrN0Nz+KxEGxqPl2J3spXiz8Ed+xsCFia137UI/MkmEM5JxU0TCqniryuDTMslROas9MlYjoC7Es6n4B3nTvt9+yzZ2dkRLtzt5Ll/nkaX7Rj5CXd5SCVH80kJIFeDOABUzjsekXURf8Ffy6zc8LS0XbV3cEB57wRDkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hkN8/NroO456JbFaEUT4jSpZbUs9ozBsuXROg2cGdc=;
 b=hjoe7DiE+JwNbJeoxns3+JCR4e/Oz+o+YkSPPMhUTvpPzfGj6bwhcuIBcTU2Xna91osNuKjxDZtGft/6PFLDb0HUbfsrfkxsNag8BvoOvTXbjQsJnYv1EuAFzwNrSa+KXozIFY6uw9qF4PQHzIiSZ0SRfSQiMRTy/SRpBVVY4SjPLBPxwysapa/U1IGgcelCxEeKfdILY1MZh9D1kdYuaNVzxnarimKPttkU4awA8a30bK3sCmWUL2BLuDU3bytXhXdnC3i57DfokONPeYm23Ig44e5mJjH8PKnuTUco2v+LxcCTGqx+Z9ca6RR8T2A8u0xNBi/w+5z0xVBP65Y1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hkN8/NroO456JbFaEUT4jSpZbUs9ozBsuXROg2cGdc=;
 b=Wxyys2zc7SMSS8jjofhowtp+tsL8NoPmZOOrZFU8/aYy95N23P6q4WYEsOeY6ftsm+JiA68R72EJ/2gmyO88eshku+Gx3ESKqowd3RtWtxq6uR+L71JiSuiZHHiyJsSTKWr5UaoosXten0p8s1vM/YDR78N5kk22U5C5fe/KOknleUbQ9wm3kG2DIye257rrgONfEw+x9f3SbfKHy3o5FFoOpTaotkBCCMcnE/O/AQjHmId1O+lH+Mr5hJBe++OL3TAuCMf1omGVjVqazU/zIiyGKjPaaGV4ATLE6rt2hAqNeRMwTbjhi5qGFaxeDGMY28u9NQfjAZlJGMGepQf0rg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8538.namprd02.prod.outlook.com (2603:10b6:303:159::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 16:26:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9031.023; Sun, 17 Aug 2025
 16:26:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Shixuan Zhao <shixuan.zhao@hotmail.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] x86/tdx: support VM area addresses for
 tdx_enc_status_changed
Thread-Topic: [PATCH] x86/tdx: support VM area addresses for
 tdx_enc_status_changed
Thread-Index: AQHcDY4UcjcFgJKvX0yAj2M/D66z+7RnB2tA
Date: Sun, 17 Aug 2025 16:26:31 +0000
Message-ID:
 <SN6PR02MB41574B8072EDC751270D3FD5D436A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <OS9PR01MB15202A41CF04F0BBF8CE244B48D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OS9PR01MB15202A41CF04F0BBF8CE244B48D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8538:EE_
x-ms-office365-filtering-correlation-id: f2f48e24-6f6f-4abd-34ff-08ddddaad376
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|8022599003|8060799015|31061999003|461199028|15080799012|41001999006|13091999003|4302099013|3412199025|440099028|13041999003|12091999003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZLoZZD07nq53OHEvvxq9AlbHz1slds3aZ2gjVEwyO8gqzHcBxj8IRhBQF+ze?=
 =?us-ascii?Q?lJTmILAQRxibM+xU/jrQ60FhbVdtn614zwZHH1V5i6YDwDxqH25n22KQlwji?=
 =?us-ascii?Q?SA5H1Z0lU4WaVFx1mHLlMtGOYj88ORxgXs2BGTJRCPu5K1rlWLO0cEb9Y/yK?=
 =?us-ascii?Q?/7SNaT3hQ5LlOp5lgtQLbkxAAAauxrYju+b78DzzHj/o34CEztFSiMGiowIj?=
 =?us-ascii?Q?bN0Z1G3Cn89dXrpIzk0W1WbMO3QpUD3n3DUgfGuHT+iuRLWcneTwQwH8IwWD?=
 =?us-ascii?Q?qGRuKJP2HG8g2LjZPnszJp0b5bU2uwI3pSWwaM1m5KHKA+9/cyGxd8IfgCBH?=
 =?us-ascii?Q?DD8rsQaKJXD8QHDoCdFcBmtGTVTNvDMYzKEfWCVWqBatC2OZiRLgQGBpqWeM?=
 =?us-ascii?Q?3QQID/+elCJl8jTXVCR7A979ecENoukWLVMreV/PiQvE0XJIer6CPIObfs8p?=
 =?us-ascii?Q?7YrudG06WKOV/ejGwuwGgB6bdl7FIrQksJ3qkxULjL9QkmPdqNMlp9kjLGun?=
 =?us-ascii?Q?b2F6s4LnNLAUjt2839V1vngO164+zhp8BlA8Amr0Fil9Zt4GSq9FZ+FqskdG?=
 =?us-ascii?Q?UNseP/aFSoHJqg7H93h93Ce2I5kyRh6/zbTNnxDCqH6+R2E2KqGHFGZvLmsC?=
 =?us-ascii?Q?zlqTyOQzDRJusBxO/BJbqtY2T4e4+aDyyzQqXG01MUW8R0sMdUK6BZDzl1CY?=
 =?us-ascii?Q?6cx74wiodX0t6FsQ9YITpBbWwDbpqc52xZleDRV+uBs9c1Nz2+Pccvg5g76y?=
 =?us-ascii?Q?xmtKj9+8v59dFczlMerw5FQDP7YXBZySussiMG0gEemWNsoDb2NyBB2dPWOv?=
 =?us-ascii?Q?uPh/gxZMb8lHknttXuBsO4kepqLXR97FhaZynBaHqtW0rFA16XUjkqRsqQf6?=
 =?us-ascii?Q?lQeQv0eddANsv5SbUFZMcxBuyKioklIXfpGE/JHsNfOCvnsHwzZ44+rtx0gF?=
 =?us-ascii?Q?zH0Udjx/dDX+tD1jSildf/KkeOj2r7nRtKQJBrqN5TVThnnisDLfFVCu9qiF?=
 =?us-ascii?Q?/6j7AVTxGD2aOtaa647szUp3MKWd4OnSBN2ZhvyySN2GioRSlrkTJtDTVN+T?=
 =?us-ascii?Q?wt80zLRWjmwNosa+7aJ6leSSkSAdvZJV2jDxmkcbQOO5PoVlpZIfOTLXtE6n?=
 =?us-ascii?Q?QC5iohAiXdHl65UvpqWnDWSyaCUd7xoED0d7fyB4Q6b0gNoCW3KS/aA9b0vt?=
 =?us-ascii?Q?bc+/8segJKA7QwoQkpWEwy7sOznniC7wi+qeVWlLFOKDbFOnv5n3r2YG756X?=
 =?us-ascii?Q?n2oArJfO0Fua4/9rV9yyX4OyCn52S+W6+g8bZrrVa9Nx7qRmwh+g6qF8hs0t?=
 =?us-ascii?Q?0vASBUyP8ZP2Z0zBcLIYaNOymk261K7HSwBdJiUXMmnx4CcZkCF2UxcaoN5j?=
 =?us-ascii?Q?VmIMOaw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ahx47sawW2WJm6dc4FVC/ZSc5yXBAgKWPXeK+xVgvjP+zEt9noFsZcTvQ4z0?=
 =?us-ascii?Q?ad09aYS3JtQqq6QPEymlCrKFeop0ToGIDWjJnIp8rNNxa8oYeMnhLBSEjmYI?=
 =?us-ascii?Q?kOUHdzMlv34MYEjx9SvVfPPhYha2AsfLCB3DFKg23JQxwzZTsGFqWfJOrpuS?=
 =?us-ascii?Q?WMD19Ngps5hyLo6t1MBqgjl2NMKTqDpsx4ltsyBpQCZmcNELKV8MGaGmudRA?=
 =?us-ascii?Q?OSyV4aUrvWPwQmKT4tF9lc2zupWc79nM/ixMLkGzqlgWPIq7sI4rV586ZJJT?=
 =?us-ascii?Q?wp6mDUeB8GKxs2ApXL/wFIDK1T9ejvZlbq3bir6ubEYaiGpIQewhxtgjtph/?=
 =?us-ascii?Q?KnXVEW23bZU4AHaKFMQSVRppPqUN1dA9vqt81pVpzVG42m7TP1SE/bcPRaON?=
 =?us-ascii?Q?O1rK3pve80mL7KmY3UWNyTpVF/3b0ef4dmLKD4WHZFG3TKb+j79m1yWPlbb9?=
 =?us-ascii?Q?jkqm3uEFHSgD3vTA+szc2v1wgbB2dCQC/Dq57TMwo0hXD99ERRIK8HyvcJBt?=
 =?us-ascii?Q?o1JveQmWMa85shRCguyfR6yIX4IQkU0Y+Sav8H4SluLUH5Z+v9X/wf1Rc8Es?=
 =?us-ascii?Q?id5qZDDJc6GwUvg96kYWhdXt+G18LQ60lm8RRnx7yGubUAgLlycUcsIm5L2/?=
 =?us-ascii?Q?bGlwI/wXyBMcVbXeIxH6sh+WDJBer0cQwCMfteyfKzg5NQbplt1QrampLEX4?=
 =?us-ascii?Q?D8v789dkEXCHsYDKSpU+na3PqWa+9GryrA/wYhJiO8EOtJ5WkE1AzYZfi0nq?=
 =?us-ascii?Q?aHj/SCjQl0pbTpRKvH+m2NYwpKA2jzeNZxzoYhMupTvE5zLALZgyrbtaZcb2?=
 =?us-ascii?Q?gSLDHY6udOTPwFrOEjwXgZNesf66sm3khpOA6lzju+0hTbvvGviWLVC+FGOX?=
 =?us-ascii?Q?NSO8j0M96fAXkebLGgDc1n367FdvUxZO0oug6hkdyv1yuQwpKzWf9Gl9+Zfi?=
 =?us-ascii?Q?ZgKn118eJQxyey7cXtdcoOf9k4egoZEI3jy5lev18IiD7kIf2mHfMdeKZdvL?=
 =?us-ascii?Q?ms8ozO7ou2wSP+0HJaIVHgYnx+HfdcUsf3VGEgWD927rm+lEDIErOfvz2gK5?=
 =?us-ascii?Q?QF5AcPRujT7Q7chq840EXt53lSabSSfoa1YpNP+05qeOTpb5DwuumLm4q3bw?=
 =?us-ascii?Q?Y/600NyfOamKBVERO09Bfwq1PxxeRom6pIIs9ax9v3QhbbQ6TJShCgx+EtJ/?=
 =?us-ascii?Q?OYHj4JIyK7Bcs1mJCXSaJUx9vaeICv6/fY1wUsToZD0SYQMbMLXqZMNJXZw?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f48e24-6f6f-4abd-34ff-08ddddaad376
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2025 16:26:31.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8538

From: Shixuan Zhao <shixuan.zhao@hotmail.com> Sent: Thursday, August 14, 20=
25 7:34 PM
>=20
> Currently tdx_enc_status_changed uses __pa which will only accept
> addresses within the linear mapping. This patch allows memory allocated
> in the VM area to be used.

Dexuan Cui submitted a patch to do this about a year ago [1]. The patch has
a long history, including being part of a larger patch set in an earlier ve=
rsion.
It appears that it still had an issue when the discussion stopped, and the =
patch
was never picked up.

Dexuan's use case was TDX guests running on Hyper-V, and the Hyper-V
synthetic networking driver (netvsc) needing to mark a 16 MiB vmalloc()'ed
receive buffer area as shared. But that use case applied only when running
without a paravisor, and it may have gone on the back-burner because
of Azure/Hyper-V CoCo guests always running with a paravisor.

Adding Dexuan to this thread in case he has additional insight into why his
patch didn't go forward.

Michael Kelley

[1] https://lore.kernel.org/lkml/20240708183946.3991-1-decui@microsoft.com/

>=20
> For VM area addresses, we do it page-by-page since there's no guarantee
> that the physical pages are contiguous. If, however, the entire range
> falls within the linear mapping, we provide a fast path that do the
> entire range just like the current version so that the performance
> would remain roughly the same as current.
>=20
> Signed-off-by: Shixuan Zhao <shixuan.zhao@hotmail.com>
> ---
> Hi,
>=20
> I recently ran into a problem where tdx_enc_status_changed was not
> implemented to handle memory mapped in the kernel VM area (e.g., ioremap
> or vmalloc). I have created a patch that tries to fix this problem. The
> overall idea is to keep a fast path for the current __pa-based routine
> if the range falls within the linear mapping, otherwise fall to a page-by=
-
> page page table walk for those in the VM area.
>=20
> It's the first time I'm submitting a patch to the kernel so although I've
> done the RTFM, feel free to discuss or point out anything improper.
>=20
> Thanks,
> Shixuan
>=20
>  arch/x86/coco/tdx/tdx.c | 42 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 7b2833705..c56cd429f 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -957,15 +957,11 @@ static bool tdx_map_gpa(phys_addr_t start, phys_add=
r_t
> end, bool enc)
>  }
>=20
>  /*
> - * Inform the VMM of the guest's intent for this physical page: shared w=
ith
> - * the VMM or private to the guest.  The VMM is expected to change its m=
apping
> - * of the page in response.
> + * Helper that works on a paddr range for tdx_enc_status_changed
>   */
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bo=
ol enc)
> +static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t e=
nd,
> +					bool enc)
>  {
> -	phys_addr_t start =3D __pa(vaddr);
> -	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
> -
>  	if (!tdx_map_gpa(start, end, enc))
>  		return false;
>=20
> @@ -976,6 +972,38 @@ static bool tdx_enc_status_changed(unsigned long vad=
dr, int
> numpages, bool enc)
>  	return true;
>  }
>=20
> +/*
> + * Inform the VMM of the guest's intent for this vaddr range: shared wit=
h
> + * the VMM or private to the guest.  The VMM is expected to change its m=
apping
> + * of the page in response.
> + */
> +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bo=
ol enc)
> +{
> +	unsigned long va_iter;
> +	unsigned long end_va =3D vaddr + numpages * PAGE_SIZE;
> +	phys_addr_t start_pa, end_pa;
> +
> +	/* fast path when the entire range is within linear mapping */
> +	if (virt_addr_valid((void *)vaddr) &&
> +	    virt_addr_valid((void *)end_va)) {
> +		start_pa =3D __pa(vaddr);
> +		end_pa =3D __pa(end_va);
> +
> +		return tdx_enc_status_changed_phys(start_pa, end_pa, enc);
> +	}
> +
> +	/* use page table walk for memory in VM area */
> +	for (va_iter =3D vaddr; va_iter < end_va; va_iter +=3D PAGE_SIZE) {
> +		start_pa =3D slow_virt_to_phys((void *)va_iter);
> +		end_pa =3D start_pa + PAGE_SIZE;
> +
> +		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpag=
es,
>  					 bool enc)
>  {
> --
> 2.43.0
>=20


