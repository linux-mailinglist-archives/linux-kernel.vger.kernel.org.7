Return-Path: <linux-kernel+bounces-894782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DEDC4C17D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9557D3BDA43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3D34AB18;
	Tue, 11 Nov 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0UskhF1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fxe2ZzP9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCF34A775
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845225; cv=none; b=OKn3OYKygT4kn9ichZgM2pKb71kKjOObTxmdo3HfXllqej14V3hPVFKwf8lbn0JIK6mtHQaNrZDLRyVVSsEVULe3Hs1d2yONKR7CkmvI4KcmxtTvQR8rVKCgm4+ZGUmxSPCNvEUqfc39ziQp7UkOt864mY3a//eu4c634qTN7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845225; c=relaxed/simple;
	bh=KJedQhalOpEG5NfPc77xs7k6VW0PXuVbwYfi428j2JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Jf893sDY5XbPiuMAIYYkO1P9Kyv1AKT+qRpMuUCg/AeW/IiSlDV7lDq8HvoLT9tkfoF+UE//ViJSugwFPOatTHF6jQwVh6wJuI/Prs5W6PsZ35E85wUux+GMqsdKAYVTfDP92Yh/rBOIJBTvY6ZXzuf7cjdfhIi8ih8uCFS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0UskhF1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fxe2ZzP9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762845222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQOor7E4dbeNIdzwuyVMMdwivPTgd7AVyRPfTl2aFVc=;
	b=e0UskhF1Qf5gh11Zt06WcgSXS5Epfc1XaeFfKysODjO+iCQ4kHgxPt857IdqT5RhOaPkM3
	0Xj1LzGp4HsVdZaF2SWWdYEzSB84R1XgbqxVIekTL2f7/isp1ZNyxpHKIrloOhLXEoQtXE
	JQSQshk9nHFv4pG72AOAMxv3CxuaHBg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-s8_sTVRIPz-ReIGLF4Rxmg-1; Tue, 11 Nov 2025 02:13:40 -0500
X-MC-Unique: s8_sTVRIPz-ReIGLF4Rxmg-1
X-Mimecast-MFC-AGG-ID: s8_sTVRIPz-ReIGLF4Rxmg_1762845219
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47778daa4d2so16978605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762845219; x=1763450019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQOor7E4dbeNIdzwuyVMMdwivPTgd7AVyRPfTl2aFVc=;
        b=Fxe2ZzP9SBXIzjj/FEwvd503DTRjWyCOhbl5PbSTd3YwFEk0AobjMdhlVVsXZRyJkg
         OIGEfSTeor0OKVvYLizrveUTqy0goCI97JrQ7A596RatLcgB4L3xxPI0ujpBQ75LWLW7
         Y5TXKTJgk6fXGdCWM0JfuDWDkm5qM2QXJRyzyLYbWsTn0wZvcihudLxm5JRGo95YxI6J
         S3WkTdMt4lvm6zWD1q392kt/niYqHd4Sq/yNUKQrdg288a/flRRcdSePl4CPKnM3dk0K
         yj1CbgSAH/WmL/U5yBlFHYW4yuq+H2jizMdA0KI66hBj/Db1hyx3EMRV1+WX0oRtGLvW
         TAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845219; x=1763450019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQOor7E4dbeNIdzwuyVMMdwivPTgd7AVyRPfTl2aFVc=;
        b=OCbDxVXXQw33LG1eFGLgwHyyhQgrh0xZoWuu0M7CHt5ogY+Uc+oNrmxXwKIcBOu5Br
         S2HiXulC9B5ESafpGQ+2dHbHmxbZVssx1KVvRaG3xsMILS82MBkvjUuBeDUJ9NvKftkC
         KeftoN59zpYV4q0kGCtp3tWfJxGdXS727C66dHTvEdRzWNdQaJtBthmuGSYnJSvEWUJv
         mOTa9ECQvo2DuhaIQZ6huOCsEKh2lan8M3Q5ku4LiP6cKyDga6O0xyts1z2emrGrwTfn
         tztRLhVAeOum4eWUrr62D4Rb0C0nrr0qUcyNFzZG+GwiFi8G0yUS2cgkgzt3N1i1ruZp
         s03Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3HzTYXDE5D5YuYBf9T0e5un63F8fjC6SPv+ex8+m6mSM4N7pyGrnFEBNIbdp9QdT7QojwJWD96uJ3UgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM122Y2ewJIeCn5ZNjgd4yy0oVPd/3Qmbdf+tsyKw73ZLcQV5
	kcgBDfwgd0bWfeD4TFTqfB15c2zUCVzb+RFygmzQDDgLoKrGnE5mMkDW+t5U5sQ8eVPlcEWXLA1
	Uw/VGy1tmokf/GoDMLbEfMo5dbtohdsQ0gCtF0vtlVQzCS77XFACpoj9hkpudrylrEs6T17rxJd
	Fc3SccKM2oJ0js5yHR39i9VJzBjkOOPjAspBsp3T8h8gkxUgs9
X-Gm-Gg: ASbGncs7AWal3wTjlrOst43aSL50ugPWueJX7r3ZhTN/IL/+QgaeJJL90iJA3yqbVlM
	XvkZhfCl0Utx6YgmUCFU04wLM5BhXcDCRCPYbz1LPtjbL570HeVaF7FejrOSrzGUElVJ1kQ/8zZ
	yNruOZtlhr+rLECuDx4B7vcE3Y6mO8WUi3/Ij1pOHhEjmR6skHaTH26ow=
X-Received: by 2002:a05:600c:444b:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-4777a783204mr56164145e9.8.1762845219440;
        Mon, 10 Nov 2025 23:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw/+Bs8p75RPgUBjuCYroBPzYtzRIGy+11fRuWx6Iz1E14m6XadOX1hcZgO52e5MYFfXjwjk/ig8B+S2Lnoz4=
X-Received: by 2002:a05:600c:444b:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-4777a783204mr56163945e9.8.1762845218970; Mon, 10 Nov 2025
 23:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
 <CAFxkdApQVEqCjQMAUqy8cuKnMy8GY9j+brgPZBkxCpeGi5xHxA@mail.gmail.com>
 <CAASaF6zvFa-mPaPfKnBcerfVBkDt5B3TEn7P9jjAfentqSNmxQ@mail.gmail.com> <d2e51443-49dd-445a-88aa-f29d7b777bce@csgroup.eu>
In-Reply-To: <d2e51443-49dd-445a-88aa-f29d7b777bce@csgroup.eu>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Nov 2025 08:13:22 +0100
X-Gm-Features: AWmQ_bmxCpD__pGofmjig0yXldv2fVwGSDiIyFzuYlizjt54SnDPYGTazzntDqc
Message-ID: <CAASaF6xv6D+Bebv8u5BpDP4-9hb5qX6HRfcdVNaUxb2ke2vuVA@mail.gmail.com>
Subject: Re: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check scripts
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Justin Forbes <jforbes@fedoraproject.org>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, 
	linux-kernel@vger.kernel.org, joe.lawrence@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:33=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 30/10/2025 =C3=A0 19:09, Jan Stancek a =C3=A9crit :
> > On Mon, Oct 6, 2025 at 10:19=E2=80=AFPM Justin Forbes <jforbes@fedorapr=
oject.org> wrote:
> >>
> >> On Tue, Sep 23, 2025 at 9:31=E2=80=AFAM Jan Stancek <jstancek@redhat.c=
om> wrote:
> >>>
> >>> We've been observing rare non-deterministic kconfig failures during
> >>> olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> >>> disabled and with it number of other config options that depend on it=
.
> >>>
> >>> The reason is that gcc-check-fpatchable-function-entry.sh can fail
> >>> if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit whil=
e
> >>> there is still someone writing on other side of pipe. `pipefail`
> >>> propagates that error up to kconfig.
> >>>
> >>> This can be seen for example with:
> >>>    # (set -e; set -o pipefail; yes | grep -q y); echo $?
> >>>    141
> >>>
> >>> or by running the actual check script in loop extensively:
> >>>    ----------------------------- 8< -------------------------------
> >>>    function kconfig()
> >>>    {
> >>>      for i in `seq 1 100`; do
> >>>        arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
> >>>          ./scripts/dummy-tools/gcc -mlittle-endian \
> >>>          || { echo "Oops"; exit 1; }
> >>>      done
> >>>    }
> >>>
> >>>    for ((i=3D0; i<$(nproc); i++)); do kconfig & done
> >>>    wait; echo "Done"
> >>>    ----------------------------- >8 -------------------------------
> >>>
> >>> Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-fun=
ction-entry")
> >>> Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
> >>> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> >>> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> >>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >>> ---
> >>>   arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
> >>>   arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
> >>>   2 files changed, 2 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.s=
h b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> >>> index 06706903503b..baed467a016b 100755
> >>> --- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> >>> +++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> >>> @@ -2,7 +2,6 @@
> >>>   # SPDX-License-Identifier: GPL-2.0
> >>>
> >>>   set -e
> >>> -set -o pipefail
> >>>
> >>>   # To debug, uncomment the following line
> >>>   # set -x
> >>> diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/p=
owerpc/tools/gcc-check-mprofile-kernel.sh
> >>> index 73e331e7660e..6193b0ed0c77 100755
> >>> --- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> >>> +++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> >>> @@ -2,7 +2,6 @@
> >>>   # SPDX-License-Identifier: GPL-2.0
> >>>
> >>>   set -e
> >>> -set -o pipefail
> >>>
> >>>   # To debug, uncomment the following line
> >>>   # set -x
> >>> --
> >>> 2.47.1
> >>
> >> Would love to see this picked up, it fixes a problem we have run into
> >> with our CI.
> >>
> >> Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
> >
> > Thanks Justin.
> >
> > Would any maintainers also care to review? Ty.
> >
>
> Is the problem only with those scripts ? I see other scripts using
> pipefail in the kernel:

As far as kconfig goes, we've observed this issue only with the two
gcc-check scripts.


>
> arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh:set -o pipefail
> arch/powerpc/tools/gcc-check-mprofile-kernel.sh:set -o pipefail
> drivers/gpu/drm/ci/dt-binding-check.sh:set -euxo pipefail
> drivers/gpu/drm/ci/dtbs-check.sh:set -euxo pipefail
> drivers/gpu/drm/ci/kunit.sh:set -euxo pipefail
> drivers/gpu/drm/ci/setup-llvm-links.sh:set -euo pipefail
> scripts/check-uapi.sh:set -o pipefail
>
> Christophe
>


