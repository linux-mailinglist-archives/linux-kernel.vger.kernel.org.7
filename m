Return-Path: <linux-kernel+bounces-753102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C37B17EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05437189ABC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3B21772A;
	Fri,  1 Aug 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="HJiCBHxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjwWYFEi"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63D16A956
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038699; cv=none; b=YrSNhHlWLv1dRumBeCohrI9BKpYpxySq2m6w6VkmS77IqGxLvPhEOwZ/Z+eyYM4XDGNjcIxg7pqEu7tfjOs9rXqb+kkal8LdanuSzssAQrZAp+vCrNs2aB4ou3KF5HqjnwmHUJXAbBZMU+TH5uHckWvtTzIfQ10pZ0yRgfnQZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038699; c=relaxed/simple;
	bh=tVQr9Ty/cRVxBZ9vaf6e5e/JJ0s5alpuOythY/zYINo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W3hYhkxPd3am75/N+U50Cqlc2qHnr5y6pY+Qi3/b8axg36Hf3qlpN+yKTVOaskIeGbW6aPA3ZMlD1A63sSyClFgQ9I9CP80niMvT90xOoGRg1l5dAGH95YIKwmKpYqh+fJolCw6mDEVwRnvvwWDIxNR3LnnDwZ9QxQZjWBPrMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=HJiCBHxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjwWYFEi; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE9AD1400047;
	Fri,  1 Aug 2025 04:58:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 04:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754038696;
	 x=1754125096; bh=Sn2Nl2lCAw5/SLjCEsezMQInAgwIbxB/rPsGZ851k1Q=; b=
	HJiCBHxXJ0TM9a07F/e2jVfy2J7XglOwdZubGzFQ5um1nBQUH82disJ8QwHB6ZnL
	GGBX+6UPCIh4n9nhOvdWoBc/bwC4C7iFDVCqBq6p/hVoVPMnL2csRKNSqzkh7urf
	jtBh8YVZvtRxkg870E1uoAe7dYlVHxRtuz14aETPSWjIPB9LH+MnjBstS2nLDANI
	mhPf8RIada2BMe7IWQuc+h7gzuYXRJ+WlHPoR48giFuXZSht6UBEOu9hIN+8CTsT
	446vTtSUo6372WnAFrUmyaIPesEhu3WO1G4JiaNAZYyeVp3BsygowryUcPfVOGyl
	A61HHsyGpgJEasKxDapKiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754038696; x=
	1754125096; bh=Sn2Nl2lCAw5/SLjCEsezMQInAgwIbxB/rPsGZ851k1Q=; b=P
	jwWYFEiqMRIZePduSpWVGA/a/sJ3ZU5Fy0Ngj/MJXLyVs0OqalLLGh3DwrC1FcFz
	QO2NbAF7cnWn+vBO4NhMu6N8JuYbSv2EM2qZQ97s/4urzCVttRmYSHSYP9bfYq8m
	56yrK/sMhdH7WGLjGWufEdwYaObpf1f89oALkm6Hd9XaM5YWjV8VanlHnzMphURt
	zbcxTUdv8hftqAz+OTmAbTRCkJui8dcybQREATpO2wl9P39tE5xW27Z88ctgFPu+
	mLLywDgV3OHo5SVLIKuEPqazn6szMsCLK4wb9JLaXYvPGR0x7+aT9H6Zpf6fA79V
	yhay8AgeC1XV0BolaAQpQ==
X-ME-Sender: <xms:p4GMaOI8MIF7XDhMHrOIk0aqCa9mMNN5rRJa8X3-LXT1Zza4v-QfTQ>
    <xme:p4GMaG7HCttlclt2MmcimKeGoJPI-a9DOYVA2M2GtHEM-qfVUnbvmTmFgm-MyM_2s
    GcevSpkq_CImEXI9Hc>
X-ME-Received: <xmr:p4GMaK3cW7_fm2XF8NcDEZaYrntkoB8Vq0G427pgJ_ad0fWR-rp8kivT_zZmMkUga9XWXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepvefffeefgeejvdektdetueevvdfhieetieevvdejhffhteduudei
    gfekjedugfegnecuffhomhgrihhnpehlughsrdhssgdprhgvlhdruggrthgrnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
    rghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgt
    phhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    gvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopeigrhihudduudesgihrhidu
    uddurdhsihhtvgdprhgtphhtthhopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:p4GMaEfa5IUXiOSCAaWc4aDBDfDYrgYFmv05tNItjYRJ2rLWh4YuJQ>
    <xmx:p4GMaIe-zmgGcJ9BxVjaeeO_7FKYADcZFDBIJM3v7g9zeLpIYjJpRQ>
    <xmx:p4GMaHxF7ACpge1ULUCzZjy84i5pC14fp6VrDh7urlWwEY_AG7qouQ>
    <xmx:p4GMaP9rBtAHBRxoAeW8DPWn1Nzr7w2OTl7Yah8loWOpJZ4R8t4rlQ>
    <xmx:qIGMaC1Cf4mHG7GttPPaaSROJdLe9VlnEPAWU-sJYGdortlxZ9-fHDeM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:58:13 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3] LoongArch: Implement physical address with ELF program
 header
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20250723080640.442339-1-maobibo@loongson.cn>
Date: Fri, 1 Aug 2025 16:57:58 +0800
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>,
 Xi Ruoyao <xry111@xry111.site>,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00651F3A-6649-4C69-B365-352C8D323902@flygoat.com>
References: <20250723080640.442339-1-maobibo@loongson.cn>
To: Bibo Mao <maobibo@loongson.cn>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> 2025=E5=B9=B47=E6=9C=8823=E6=97=A5 16:06=EF=BC=8CBibo Mao =
<maobibo@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> With structure elf64_phdr, field p_paddr is physical address of the
> segment. And it is convenient for qemu to calculate the physical
> address when directly boot ELF kernel image.
>=20
> Otherwise QEMU needs convert virtual address p_vaddr into physical
> address, the conversion logic assumes that DMW method is used where
> 48 bit physical address is supported. However with direct MMU mapping
> method with start address from 0xFFFF800000000000, only 47 bit =
physical
> address is supported. QEMU cannot assume the kernel behavior at kernel
> loading stage.
>=20
> Here add physical address indication in ELF program header, it is
> convenient to get physical kernel loading address.

Hi Bibo,

Thanks for your patch. Unfortunately it breaks PMON=E2=80=99s DWARF =
debugging
Feature, causing exception on list symbols.

I=E2=80=99ll try to investigate.

Thanks
Jiaxun



>=20
> Here is output with command readelf -l vmlinux with patch:
> Elf file type is EXEC (Executable file)
> Entry point 0x90000000015f5000
> There are 2 program headers, starting at offset 64
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000010000 0x9000000000200000 =
0x0000000000200000
>                  0x000000000293b000 0x0000000002a79b98  RWE    0x10000
>=20
> And output with command readelf -l vmlinux without the patch:
> Elf file type is EXEC (Executable file)
> Entry point 0x90000000015f5000
> There are 2 program headers, starting at offset 64
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000010000 0x9000000000200000 =
0x9000000000200000
>                  0x000000000293b000 0x0000000002a79b98  RWE    0x10000
>=20
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v2 ... v3:
> 1. Fix compile issue where macro PHYS_OFFSET is not defined with =
assemble
>    code.
> v1 ... v2:
> 1. Set LOAD_OFFSET with PAGE_OFFSET rather than CACHE_BASE, since it
>    is generic with PAGE_OFFSET.
> 2. Add AT information with missing edata_padding section.
> ---
> arch/loongarch/include/asm/addrspace.h |  2 +-
> arch/loongarch/kernel/vmlinux.lds.S    | 36 +++++++++++++++++---------
> 2 files changed, 25 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/loongarch/include/asm/addrspace.h =
b/arch/loongarch/include/asm/addrspace.h
> index e739dbc6329d..18f6c2b469bb 100644
> --- a/arch/loongarch/include/asm/addrspace.h
> +++ b/arch/loongarch/include/asm/addrspace.h
> @@ -18,10 +18,10 @@
> /*
> * This gives the physical RAM offset.
> */
> -#ifndef __ASSEMBLER__
> #ifndef PHYS_OFFSET
> #define PHYS_OFFSET	_UL(0)
> #endif
> +#ifndef __ASSEMBLER__
> extern unsigned long vm_map_base;
> #endif /* __ASSEMBLER__ */
>=20
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S =
b/arch/loongarch/kernel/vmlinux.lds.S
> index 08ea921cdec1..8ce6b0d948f4 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -3,10 +3,12 @@
> #include <asm/asm-offsets.h>
> #include <asm/thread_info.h>
> #include <asm/orc_lookup.h>
> +#include <asm/addrspace.h>
>=20
> #define PAGE_SIZE _PAGE_SIZE
> #define RO_EXCEPTION_TABLE_ALIGN	4
> #define PHYSADDR_MASK			0xffffffffffff /* 48-bit */
> +#define LOAD_OFFSET			PAGE_OFFSET
>=20
> /*
> * Put .bss..swapper_pg_dir as the first thing in .bss. This will
> @@ -42,7 +44,7 @@ SECTIONS
>=20
> 	. =3D ALIGN(PECOFF_SEGMENT_ALIGN);
> 	_stext =3D .;
> -	.text : {
> +	.text : AT(ADDR(.text) - LOAD_OFFSET) {
> 		TEXT_TEXT
> 		SCHED_TEXT
> 		LOCK_TEXT
> @@ -60,7 +62,7 @@ SECTIONS
> 	__inittext_begin =3D .;
>=20
> 	INIT_TEXT_SECTION(PAGE_SIZE)
> -	.exit.text : {
> +	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
> 		EXIT_TEXT
> 	}
>=20
> @@ -82,7 +84,7 @@ SECTIONS
> 	}
>=20
> 	INIT_DATA_SECTION(16)
> -	.exit.data : {
> +	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
> 		EXIT_DATA
> 	}
>=20
> @@ -90,7 +92,7 @@ SECTIONS
> 	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
> #endif
>=20
> -	.init.bss : {
> +	.init.bss : AT(ADDR(.init.bss) - LOAD_OFFSET) {
> 		*(.init.bss)
> 	}
> 	. =3D ALIGN(PECOFF_SEGMENT_ALIGN);
> @@ -101,27 +103,34 @@ SECTIONS
> 	_sdata =3D .;
> 	RO_DATA(4096)
>=20
> -	.got : ALIGN(16) { *(.got) }
> -	.plt : ALIGN(16) { *(.plt) }
> -	.got.plt : ALIGN(16) { *(.got.plt) }
> +	. =3D  ALIGN(16);
> +	.got : AT(ADDR(.got) - LOAD_OFFSET) { *(.got) }
> +	. =3D  ALIGN(16);
> +	.plt : AT(ADDR(.plt) - LOAD_OFFSET) { *(.plt) }
> +	. =3D  ALIGN(16);
> +	.got.plt : AT(ADDR(.got.plt) - LOAD_OFFSET) { *(.got.plt) }
>=20
> 	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>=20
> -	.rela.dyn : ALIGN(8) {
> +	. =3D ALIGN(8);
> +	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET) {
> 		__rela_dyn_begin =3D .;
> 		 *(.rela.dyn) *(.rela*)
> 		__rela_dyn_end =3D .;
> 	}
>=20
> #ifdef CONFIG_RELR
> -	.relr.dyn : ALIGN(8) {
> +	. =3D ALIGN(8);
> +	.relr.dyn : AT(ADDR(.relr.dyn) - LOAD_OFFSET) {
> 		__relr_dyn_begin =3D .;
> 		 *(.relr.dyn)
> 		__relr_dyn_end =3D .;
> 	}
> #endif
>=20
> -	.data.rel : { *(.data.rel*) }
> +	.data.rel : AT(ADDR(.data.rel) - LOAD_OFFSET) {
> +		*(.data.rel*)
> +	}
>=20
> #ifdef CONFIG_RELOCATABLE
> 	. =3D ALIGN(8);
> @@ -134,10 +143,13 @@ SECTIONS
>=20
> 	ORC_UNWIND_TABLE
>=20
> -	.sdata : {
> +	.sdata : AT(ADDR(.sdata) - LOAD_OFFSET) {
> 		*(.sdata)
> 	}
> -	.edata_padding : { BYTE(0); . =3D ALIGN(PECOFF_FILE_ALIGN); }
> +	.edata_padding : AT(ADDR(.edata_padding) - LOAD_OFFSET) {
> +		BYTE(0);
> +		. =3D ALIGN(PECOFF_FILE_ALIGN);
> +	}
> 	_edata =3D  .;
>=20
> 	BSS_SECTION(0, SZ_64K, 8)
>=20
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> --=20
> 2.39.3
>=20
>=20


