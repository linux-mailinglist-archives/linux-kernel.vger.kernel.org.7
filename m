Return-Path: <linux-kernel+bounces-848276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA34BCD3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC404FDC49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EB02F0C63;
	Fri, 10 Oct 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXbhgxEt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68791F63FF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102710; cv=none; b=S3x2TDPYaMyoW+TTccvmNtymNQVdUoiD6mkHosU6tOGQ8JowK+rU++AbpS6FI7ON2xyOkYxds2mRy+tYtixV51E54Bpnm5F1gSU19UqQR+y7YlfESe3hHdd4GgjmzfzCnkCr2k+z7F1GHzh3SJhk+rxvWpKeBouKe+xnDlxkK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102710; c=relaxed/simple;
	bh=O8RrubSJRJZ2eKPZ0ANfpKCQVkOdvA+RtzJWOt2fdes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEyTDjtPcPPsTDtYQFRFsxUJdcmFtGqYutk8lIQKKHIB+HLNb3ftjqZVNWhEVimywLxpvslK7dzeWL4gVvG9VV4eAYox6JzJu7jdwZTS/w4jvwPDgdaugznTxKB0/D3vhxeTTE25HLPkWZdjvFsarekWgzD70EY6WCiJ1R6eyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXbhgxEt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760102707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzWKSf9mpTG2YCjUAY9uF/GRv8q15gJjhT+Ik15Q3YU=;
	b=EXbhgxEtoMx1wFfemrRqjNI30R77VW1w54renI372rsE9JrGSqulDcM2UVzi4XzYG8Jt95
	Ct6F7UaMkeuIMMzIZP8+E85rDzBIAqkMIJczMaWsPZRbDCMRlW2M3UDgv6yYQS5fr0eYW+
	f7rMnWLQCEzSPusskDEeNNHf6MLOBTo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-21TGh3QuO7eybEctoHomwg-1; Fri, 10 Oct 2025 09:25:06 -0400
X-MC-Unique: 21TGh3QuO7eybEctoHomwg-1
X-Mimecast-MFC-AGG-ID: 21TGh3QuO7eybEctoHomwg_1760102705
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54bc28a579dso1229922e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760102705; x=1760707505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzWKSf9mpTG2YCjUAY9uF/GRv8q15gJjhT+Ik15Q3YU=;
        b=M7pXjG/nUf0PI0XFT3u8IXsHvL0VxHzT7TPyVh2uyCoX4hShWZ/ELid31I41vSrN21
         OoIz36ZCoWam0iq1pzaEFgDUksQ6ZgARb5Zcy6Hufu093V04gHqrV76xr6fBbVW9jUae
         YC6GLlj0plQvynh+xZv28iuFy0qOLbi+/4kwD20i9UmSkyJ9gPlvX9ts6M+asRtk3Oey
         GIUctSnxgeV6nU3HtrzK4NDDuGHOeuIIE8vptDjlMLHjd/OqFuQklu1Fo5QoyQvmamNe
         /GleLAmtLnByugrFVpzDU82bAjt44lxw9xcjCnGuSm/6F4q0cz5Zc9L5riryPZt8XR37
         Y0qw==
X-Forwarded-Encrypted: i=1; AJvYcCX65Dge4xWH4JD6v0ToAQANceqKbsR84b/ohj2suIRy6DygADzwNFFMWqQ66xRfdDFlD60pMGE47+Ki79Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNikNUqiRYOzotRMiiII2H7bQKABdyO26rX4vz7Ok3CCFeDPJu
	D4ntJqzPkJC+7jkA6h7wZA2Bu303N3RpezqdC8mRG0k9gJ9gB3DHnZC0E+h/m09grz6eNaaMTct
	fqEPMNniBLX+Q8R/rV7y6dvuiVOl2eCj8l/3Rlo5qLxRsnq+qK4jy/5OhbEuR12QaH61dhPWSyW
	2AVgSr0KOfheKR6Po9zVeTuYp2olFDkFum/gJ1w1vg
X-Gm-Gg: ASbGncu3h4t8MEOdD2D5vTu/H5ItzhOvIFDtT6qvuWQKKUG7YYWPh8tPdl/a2IT2bi8
	o8tuO9RFFZxS1n9qagzIrvI0Ls0w3cU9O2ZCdXPwo9gc+NF2I2qInD8lhfqlk61SPS5fIGytqgH
	rVhXSDhUqI1pQasnZ9WkMExMK4byiGDA==
X-Received: by 2002:a05:6122:2228:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-554b8b972b9mr4105603e0c.8.1760102705443;
        Fri, 10 Oct 2025 06:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9OXHOt0tVCCgO6nU5AlWF0F3DLGcppKFsGZNXFWqEcGcaDnZmPBYeJMuUsD+NzvpJu1hAFAcw2aXzLqvRxr4=
X-Received: by 2002:a05:6122:2228:b0:544:75d1:15ba with SMTP id
 71dfb90a1353d-554b8b972b9mr4105589e0c.8.1760102705084; Fri, 10 Oct 2025
 06:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28d4da3b0e3fc8474142746bcf469e03752c3208.1758182101.git.legion@kernel.org>
 <20251007011637.2512413-1-cmirabil@redhat.com> <aOToOeNGiaFVM0Ds@example.org>
 <aOgSaNejdcBWKXx8@levanger> <20251010053736.GA447238@ax162>
In-Reply-To: <20251010053736.GA447238@ax162>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Fri, 10 Oct 2025 09:24:54 -0400
X-Gm-Features: AS18NWDAsD56v33pycRJmWk_jcLYYml8a8mta30luj8tpr3fHieg4TWwum9tzMM
Message-ID: <CABe3_aE+A7JtEp-8p6A8yM9ONGU4-c36AUFrtW4tGhpnXbvSuQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] modpost: Create modalias for builtin modules
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Alexey Gladkov <legion@kernel.org>, da.gomez@samsung.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:37=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Thu, Oct 09, 2025 at 09:52:08PM +0200, Nicolas Schier wrote:
> > On Tue, Oct 07, 2025 at 12:15:21PM +0200, Alexey Gladkov wrote:
> > > Hm. Indeed. I haven't found a good solution yet, but you can use the
> > > following patch to unlock compilation. It won't solve the problem, it=
 will
> > > only hide it.
> > >
> > > --- a/scripts/Makefile.vmlinux
> > > +++ b/scripts/Makefile.vmlinux
> > > @@ -84,7 +84,7 @@ endif
> > >  remove-section-y                                   :=3D .modinfo
> > >  remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) +=3D '.rel*'
> > >
> > > -remove-symbols :=3D -w --strip-symbol=3D'__mod_device_table__*'
> > > +remove-symbols :=3D -w --strip-unneeded-symbol=3D'__mod_device_table=
__*'
> > >
> > >  # To avoid warnings: "empty loadable segment detected at ..." from G=
NU objcopy,
> > >  # it is necessary to remove the PT_LOAD flag from the segment.
> > >
> >
> > Is it problematic to hide that?  Otherwise we'd have to revert the
> > patch, right?
>
> Yeah, I would much prefer to ending up with pointless
> __mod_device_table__ symbols in the final binary than erroring out
> during the build... Does this happen with other architectures? I have
> not seen any reports yet but I have not tested anything yet. Why is
> RISC-V special here?
>
> It seems like the relocation comes from the .LASANLOC4 symbol in
> .data.rel.local?
>
>   $ llvm-objdump -Dr drivers/irqchip/irq-riscv-aplic-main.o
>   ...
>   Disassembly of section .data.rel.local:
>   ...
>   0000000000000130 <.LASANLOC4>:
>   ...
>        1c0: 0000          unimp
>           00000000000001c0:  R_RISCV_64   __mod_device_table__kmod_irq_ri=
scv_aplic_main__acpi__aplic_acpi_match
>   ...
>
> I cannot find much information about this ASANLOC outside of its
> location within the GCC sources, do we even need it? I don't see a way
> to opt out of this section altogether or on a per-variable basis, I
> wonder if there is some way to strip it out...

It seems from reading the gcc source that these are emitted to contain
information about where global declarations came from, presumably to
allow nicer ASAN error messages. (i.e. memory corruption affected this
symbol defined here). I don't think that KASAN uses these, but I am
not sure. I also don't know how they could be removed. I found a hit
using grep.app https://grep.app/search?case=3Dtrue&q=3DASANLOC in the
apache/nuttx repository where they seem to be doing something with
these symbols in a linker script, but I am not familiar enough with
linker scripts, or that project to fully understand what is going on.


>
> I plan to send the initial 6.18 Kbuild fixes pull request on Saturday.
> If we cannot figure out a real solution before then, maybe we can just
> switch to '--strip-unneeded-symbol' with a comment to upgrade that to
> '--strip-symbol' when possible?
>
> Cheers,
> Nathan
>


