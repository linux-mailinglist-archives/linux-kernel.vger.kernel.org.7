Return-Path: <linux-kernel+bounces-738727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38CB0BC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5187F189B0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584021FF27;
	Mon, 21 Jul 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D59/0vnB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F621D3C6;
	Mon, 21 Jul 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078224; cv=none; b=YQ2GsHHJ31ub+QpDunBQRpMpXKEzwKiOD37Ap3yaPDxcKpMT7sFZcJONKbheQo9qpq4XUwhO/HxzI7TSgVgKLV2Qru/vqpjL0yHF/8OcIWI24RkzXsLz3kFD4R9C2/wwgQe36McRJNXmb8JuRx4fu9oFRUkd3YoNfWYJOYqdi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078224; c=relaxed/simple;
	bh=pL4gB+LN2z1DLJWxW80bxef+G6EgDgbvYaKvllzLOho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1BJ6NXwnvLHevZoiLgXyI8g5uZFJbwcdfPFQlZqUwQY7To/ccj1vdYBgSFP7MjAc1NRtYTFYT8kiIISjI677uDmLIbD41VesN7UEZl94SpZsjoBKVqkQjssygsHg0vWxuXmNJMJUjI8E8XWeF0j1lwxRn8Z2y2Qdc2VcC+oTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D59/0vnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6AC4CEF5;
	Mon, 21 Jul 2025 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753078224;
	bh=pL4gB+LN2z1DLJWxW80bxef+G6EgDgbvYaKvllzLOho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D59/0vnBCiKbJ6A6r1iCaRyzqCYUcBi2aPQnQ+/TuXn7aibMj/6eR9ph846QwEbu8
	 Wdq2av5RCbWopk+xq3EQr+ESEYKlH9NcTi+iTKBF971Wn+5h1OmFL7FKWStVP0aa+O
	 mvSl/gzh8muueisn3hWaHPklCjRwR8p86cGM6+g6cRjmplvOzjHnIOKuCK9sXlUdTW
	 IAXqz+NmZGyjWGMAuxGOTZqyK9D+MGdVKsaplgYRTnEOzyQRorRxC/u8mGVoTU7er8
	 lvopTKoLwnuR+L4e8Wn9AUZFfgxAxtg/IqZ7th6SljUewPX/ragEhdou2vwdRyxbU9
	 w+FcvFy/ZCY6g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so34855491fa.0;
        Sun, 20 Jul 2025 23:10:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHgWx0QWFgFc7/Hm7OGI8RlPUEnRvn8KK7dJbGl4EiZ2UPQaGZ1dQDMDMILQ9cq7vCNFna8ScE3NfCjEBxwUs=@vger.kernel.org, AJvYcCX7bQSjRGWhbqf3fMo0A/nrgnn7pOR5cgXlKIFmRCoC2QdNIOlfuvHebG8OMg7qfybkeOu3gbOWPMzTjks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOF6WUp7Uw+qr01adtaFE+oI/rxMGmLA2JQxKrFFyWWwhn7kU
	96qAWDhdkiupOvOX33bvaGAWjlI43AY+SjuD0I0E8r0A3a6tEadMzyWFdxDXxbqKnlFFKYtvcIO
	lj+onYw02cs3ES4DFexbB7ftv3iPtlOA=
X-Google-Smtp-Source: AGHT+IHSpf6VOPHmTQugE6c8S02OslSBmIbJ1x6Ulk5G4VH1p6ebdaDxdNH+ZJTK2nfAK9yolEQL81XKX1mgg+yUBIc=
X-Received: by 2002:a05:651c:214d:b0:32b:95ca:8103 with SMTP id
 38308e7fff4ca-3308f54e76bmr32529231fa.14.1753078222300; Sun, 20 Jul 2025
 23:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com> <aHjSwCK98Bpgu_jb@J2N7QTR9R3>
In-Reply-To: <aHjSwCK98Bpgu_jb@J2N7QTR9R3>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Jul 2025 16:10:03 +1000
X-Gmail-Original-Message-ID: <CAMj1kXHMVBqOvk-zzSsv-0sSWgfKxWCj8Vv+FPyHO_8SUWNgPw@mail.gmail.com>
X-Gm-Features: Ac12FXyQ6o18MYF_sYQwqD-s-jqJDfa2At4j3z4wr5_0jY0NKTZRn_K6BOcmEoE
Message-ID: <CAMj1kXHMVBqOvk-zzSsv-0sSWgfKxWCj8Vv+FPyHO_8SUWNgPw@mail.gmail.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
To: Mark Rutland <mark.rutland@arm.com>
Cc: =?UTF-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	=?UTF-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>, 
	=?UTF-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>, 
	=?UTF-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?= <lina.yang@unisoc.com>, 
	=?UTF-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 20:39, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> From a quick scan, I think this might have something to do with
> UNWIND_PATCH_PAC_INTO_SCS, notes below.
>
> On Mon, Jul 14, 2025 at 03:12:33AM +0000, =E5=88=98=E6=B5=B7=E7=87=95 (Ha=
iyan Liu) wrote:
> > I am enabling generic kasan feature in kernel 6.12, and met kernel boot=
 crash.
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000000008
> > pc : do_basic_setup+0x6c/0xac
> > lr : do_basic_setup+0x88/0xac
> > sp : ffffffc080087e40
>
> Can you say which hardware this is on? Given this is a NULL-dereference,
> this looks ike a dodgy pointer (or memory corruption) rather than a PAC
> failure.
>
> > After debug, I find some error in do_ctors().
> > Normally, the complier should insert the paciasp instruction at the fun=
ction entry so that its corresponding autiasp instruction is used to valida=
te the return address when the function returns.
> > NSX:FFFFFFC0800A840C|F800865E     asan.module_ctor:   str  x30,[x18],#0=
x8=EF=BC=9Bx30,[x18],#8
> > NSX:FFFFFFC0800A8410|A9BF7BFD                       stp     x29,x30,[sp=
,#-0x10]!   ; x29,x30,[sp,#-16]!
> > NSX:FFFFFFC0800A8414|910003FD                       mov     x29,sp
> > NSX:FFFFFFC0800A8418|B0023420                       adrp    x0,0xFFFFFF=
C08472D000
> > NSX:FFFFFFC0800A841C|91390000                       add     x0,x0,#0xE4=
0     ; x0,x0,#3648
> > NSX:FFFFFFC0800A8420|528000A1                       mov     w1,#0x5    =
      ; w1,#5
> > NSX:FFFFFFC0800A8424|9422AF50                       bl      0xFFFFFFC08=
0954164   ; __asan_register_globals
> > NSX:FFFFFFC0800A8428|A8C17BFD                       ldp     x29,x30,[sp=
],#0x10   ; x29,x30,[sp],#16
> > NSX:FFFFFFC0800A842C|F85F8E5E                       ldr     x30,[x18,#-=
0x8]!   ; x30,[x18,#-8]!
> > NSX:FFFFFFC0800A8430|D65F03C0                       ret
>
> Here you evidently have shadow call stack enabled...
>
> > NSX:FFFFFFC0800A8478|D503233F  asan.module_ctor:    paciasp
> > NSX:FFFFFFC0800A847C|A9BF7BFD                       stp     x29,x30,[sp=
,#-0x10]!   ; x29,x30,[sp,#-16]!
> > NSX:FFFFFFC0800A8480|910003FD                       mov     x29,sp
> > NSX:FFFFFFC0800A8484|B0023420                       adrp    x0,0xFFFFFF=
C08472D000
> > NSX:FFFFFFC0800A8488|913E0000                       add     x0,x0,#0xF8=
0     ; x0,x0,#3968
> > NSX:FFFFFFC0800A848C|52800021                       mov     w1,#0x1    =
      ; w1,#1
> > NSX:FFFFFFC0800A8490|9422AF35                       bl      0xFFFFFFC08=
0954164   ; __asan_register_globals
> > NSX:FFFFFFC0800A8494|A8C17BFD                       ldp     x29,x30,[sp=
],#0x10   ; x29,x30,[sp],#16
> > NSX:FFFFFFC0800A8498|D50323BF                       autiasp
> > NSX:FFFFFFC0800A849C|D65F03C0                       ret
>
> ... but here you evidently don't, and have PAC instead.
>
> Are these from the same kernel Image?
>
> Are these decoded from the static kernel binary, or are these dumps from
> memory once a kernel has booted (or is in the process of booting)?
>
> > But actually, in two asan.module_ctor functions, there is only autiasp =
 instruction inserted before return, for validation of return address, whil=
e paciasp instruction is missing before.
> > NSX:FFFFFFC0800A72D8|F800865E  asan.module_ctor:    str     x30,[x18],#=
0x8   ; x30,[x18],#8
> > NSX:FFFFFFC0800A72DC|F81F0FFE                       str     x30,[sp,#-0=
x10]!   ; x30,[sp,#-16]!
> > NSX:FFFFFFC0800A72E0|B00233C0                       adrp    x0,0xFFFFFF=
C084720000
> > NSX:FFFFFFC0800A72E4|91350000                       add     x0,x0,#0xD4=
0     ; x0,x0,#3392
> > NSX:FFFFFFC0800A72E8|52803D61                       mov     w1,#0x1EB  =
      ; w1,#491
> > NSX:FFFFFFC0800A72EC|9422B39E                       bl      0xFFFFFFC08=
0954164   ; __asan_register_globals
> > NSX:FFFFFFC0800A72F0|F84107FE                       ldr     x30,[sp],#0=
x10   ; x30,[sp],#16
> > NSX:FFFFFFC0800A72F4|D50323BF                       autiasp
> > NSX:FFFFFFC0800A72F8|D65F03C0                       ret
>
> Thas has a mixture of SCS and PAC; there's a shadow call stack prologue
> but a PAC epilogue:
>
>         str     x30, [x18], #8  // SCS
>         ...
>         autiasp                 // PAC
>
> ... so I'll hazard a guess that these are dumps from memory, and you
> have UNWIND_PATCH_PAC_INTO_SCS selected. Assuming that is the case,
> either this dump has been made mid-patching, or the patching has gone
> wrong somehow and left the prologues/epilogues in an inconsistent state
> (and the NULL dereference could be a secondary effect of that).
>
> Ard, does that sound plausible to you?
>

Yes, that is definitely possible.

Since commit 54c968bec344 ("arm64: Apply dynamic shadow call stack
patching in two passes") we are more careful about patching a function
in its entirety or not at all if any of the DWARF metadata is
misunderstood (or invalid). However, if the DWARF metadata is
inaccurate, but does not trigger an error, the patching will happen
and an error such as this one is likely to occur as a result.

Note that PACIASP and AUTIASP do not necessarily occur in pairs, so it
is not generally feasible to validate the DWARF against the code,
especially at runtime. However, a function (or FDE frame) that has one
PACIASP should at least have one AUTIASP too.

> I can't see why that would depend on KBUILD_RUSTFLAGS, but maybe the
> DWARF generated by rustc has confused the patching code somehow, or the
> linker has aggregated that in a suprising way.
>

I would suspect the DWARF metadata in this case. There are valid cases
where the DW_CFA_negate_ra_state annotation is attached to an
instruction other than PACIASP or AUTIASP, and so we are not able to
detect the case where the annotation is misplaced (i.e., attached to
the preceding or subsequent instruction).

So the important thing to check here is whether the objects in
question have the correct DWARF annotations for these
asan.module_ctor() routines. This can be done using 'llvm-readelf
--unwind' (example below, using an arbitrary object from a defconfig
build with kasan, rust and dynamic shadow call stack enabled): in this
case, both routines are correctly annotated, i.e., that the return
address (RA) state toggles to signed at offset 0x4 and toggles back to
unsigned/authenticated at 0x24.




$ llvm-objdump -d kernel/seccomp.o

Disassembly of section .text.asan.module_ctor:

0000000000000000 <asan.module_ctor>:
       0: d503233f      paciasp
       4: a9bf7bfd      stp x29, x30, [sp, #-0x10]!
       8: 910003fd      mov x29, sp
       c: 90000000      adrp x0, 0x0 <asan.module_ctor>
      10: 91000000      add x0, x0, #0x0
      14: 528003c1      mov w1, #0x1e               // =3D30
      18: 94000000      bl 0x18 <asan.module_ctor+0x18>
      1c: a8c17bfd      ldp x29, x30, [sp], #0x10
      20: d50323bf      autiasp
      24: d65f03c0      ret

Disassembly of section .text.asan.module_dtor:

0000000000000000 <asan.module_dtor>:
       0: d503233f      paciasp
       4: a9bf7bfd      stp x29, x30, [sp, #-0x10]!
       8: 910003fd      mov x29, sp
       c: 90000000      adrp x0, 0x0 <asan.module_dtor>
      10: 91000000      add x0, x0, #0x0
      14: 528003c1      mov w1, #0x1e               // =3D30
      18: 94000000      bl 0x18 <asan.module_dtor+0x18>
      1c: a8c17bfd      ldp x29, x30, [sp], #0x10
      20: d50323bf      autiasp
      24: d65f03c0      ret


$ llvm-readelf -u kernel/seccomp.o

(this requires a bit of manual inspection, given that readelf does not
take the .rela.eh_frame section into account, and so the initial
locations are section relative, and you're looking for FDE frames that
have initial location 0x0)

  ...
  [0x58c] FDE length=3D40 cie=3D[0x0]
    initial_location: 0x0
    address_range: 0x28 (end : 0x28)

    Program:
      DW_CFA_advance_loc: 4 to 0x4
      DW_CFA_AARCH64_negate_ra_state:
      DW_CFA_advance_loc: 4 to 0x8
      DW_CFA_def_cfa_offset: +16
      DW_CFA_advance_loc: 4 to 0xc
      DW_CFA_def_cfa: reg29 +16
      DW_CFA_offset: reg30 -8
      DW_CFA_offset: reg29 -16
      DW_CFA_advance_loc: 16 to 0x1c
      DW_CFA_def_cfa: reg31 +16
      DW_CFA_advance_loc: 4 to 0x20
      DW_CFA_def_cfa_offset: +0
      DW_CFA_advance_loc: 4 to 0x24
      DW_CFA_AARCH64_negate_ra_state:
      DW_CFA_restore: reg30
      DW_CFA_restore: reg29
      DW_CFA_nop:
      DW_CFA_nop:
      DW_CFA_nop:

  [0x5b8] FDE length=3D44 cie=3D[0x0]
    initial_location: 0x0
    address_range: 0x28 (end : 0x28)

    Program:
      DW_CFA_advance_loc: 4 to 0x4
      DW_CFA_AARCH64_negate_ra_state:
      DW_CFA_advance_loc: 4 to 0x8
      DW_CFA_def_cfa_offset: +16
      DW_CFA_advance_loc: 4 to 0xc
      DW_CFA_def_cfa: reg29 +16
      DW_CFA_offset: reg30 -8
      DW_CFA_offset: reg29 -16
      DW_CFA_advance_loc: 16 to 0x1c
      DW_CFA_def_cfa: reg31 +16
      DW_CFA_advance_loc: 4 to 0x20
      DW_CFA_def_cfa_offset: +0
      DW_CFA_advance_loc: 4 to 0x24
      DW_CFA_AARCH64_negate_ra_state:
      DW_CFA_restore: reg30
      DW_CFA_restore: reg29
      DW_CFA_nop:
      DW_CFA_nop:
      DW_CFA_nop:
      DW_CFA_nop:
      DW_CFA_nop:
      DW_CFA_nop:
      DW_CFA_nop:

