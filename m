Return-Path: <linux-kernel+bounces-878901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC9C21B85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0B9C4F62FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5A36CA96;
	Thu, 30 Oct 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM0u0HDh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967B280A3B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847795; cv=none; b=ArX4u/rb1PQC+BzeINermA9Bu4vcwcGYVE7ysfz7oez4H2uhIOvXMtbXKc4yr5BIH55NJ7W/xAp3QG3POZDzmjTZUiVodiQ34qZR5f7BYdbcS2L1nLGXrrao/OtSQrnlsYgMRSNCpGe4mXp1trzwZeYnPTSzH4/jSUs4hgnzKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847795; c=relaxed/simple;
	bh=6HSGwCKAARObug8RlTGlK4x+2BDYXXAzVBJB8jSabFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiQjKu6xfpKrjge4ZfgJr9hG3uQ5YA+ZL8i4LmO2zTIYp2zQ623e/Bogw56HRI98y2Bb/lXHfrlokwjGqmbdEY6nwagxiI8cQty3lpR/mtoFzDmRaqhQyGH4o58bR3dPMuM/A+htE6c5JwH/6EXSH8AVcKrOcgrcFlw9xqe+O5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM0u0HDh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761847792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mctqRaSLMd7c2qit82j5QIoFnAfSUGLlal0MZ5uxEJc=;
	b=LM0u0HDh13LAvLG1bE1tN6BF7EXy2L/K2f5FgcUrokfF2p5Qz1TpLezuJzy3Rt/62TveQ6
	3bIJWX/NI13rk6nGS05NoWzv2XRY8I6yOqORlE44AUUMhdZPMDlNlRoXTN0+hq2nqiztwi
	L9czrwKTLwFQZl30FfDFQ15GziuXArA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-fH_xEM2ZMeaYd69R2SoJUQ-1; Thu, 30 Oct 2025 14:09:51 -0400
X-MC-Unique: fH_xEM2ZMeaYd69R2SoJUQ-1
X-Mimecast-MFC-AGG-ID: fH_xEM2ZMeaYd69R2SoJUQ_1761847790
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429af6b48a8so1597513f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847790; x=1762452590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mctqRaSLMd7c2qit82j5QIoFnAfSUGLlal0MZ5uxEJc=;
        b=TN02ftppiQ3bxgQRnTlT2DXO+IgQ9jBO5lCnG08rf82+zkO7SxOZe96fFntfKZByf7
         6WMweWdajFhyb9QKrN20CSOts3hA278pgSfIrO2iaVr9W8qTGPifvLOWpnAMZeGHF1q1
         Ygg8sytxDWxTRSBRts71tTFlw2m3/5z60fH9uAHAEKirRaOd87M7766whVnrLPQrj9IL
         EqZr84arc1QiyxfjKpApPwm6MeMd1TuThpR2BBWH+JMo4IFl+qcaTeJphW5nJf8IEZay
         +CQ/SIyqc/nPEDpm9VZAx8KJOhO5IItNGowtAkyjg9S/67TI0MgCkqA+z/Jdit9y82r9
         DgiA==
X-Forwarded-Encrypted: i=1; AJvYcCUql6gVIUjw2Q/yV1h9aqphAfM2SgRpx/FtG7SnfjQhCkGdS37UyloXQOZ7TJV0lFWvBNlwXkgRO1IB5Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsemnStTXv0Yv/z+MGZBOzFH7UzNHDmiOWX8yPdYrstMLRCONI
	Xvx/vC0NZjp3nFWsGa9hTrhgkOsJVGPGcBZWZpTF326R81J8L0Vm9xRVWqmX3U2DXyatEWG2Cyv
	ZpccpJGCF0n1Vc5Iz3ckLpYeeaH4ZrUqn108oMy7ahbrKA82grG9Z5oOosFU7T89REK0USYL7Oz
	7ygxOaMEURqBPiFhh2TSuyjupd3P0Pidv1I6aaODD4
X-Gm-Gg: ASbGncslhcOJ4Fw37o/JUpEFGDMRwGexwU/inFaqyuD9ryMfjyVX7FcWvBIwITz+BeI
	XxIGE11mwCrf2pPshw26+ltIppHGudCZ0Diu+nRexcMl/GcFQR60W/p0hJ1GK0qWOVszJhzDJOh
	PL32ZwkDDB5MwArYJME7QDMYmMPwlHnnfLxiSHThwlznQ8qWuzNXVZJA==
X-Received: by 2002:a5d:588e:0:b0:428:5674:7a13 with SMTP id ffacd0b85a97d-429bd6adccamr491061f8f.36.1761847789672;
        Thu, 30 Oct 2025 11:09:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIVcwcrZLyKZAEVO6CsM/z7QkByVRb/zeVY0UBsbLqggacUkqCldcvMgAZwWM0uXZNWZCqwgsj/lVCgmiDrik=
X-Received: by 2002:a5d:588e:0:b0:428:5674:7a13 with SMTP id
 ffacd0b85a97d-429bd6adccamr491032f8f.36.1761847789166; Thu, 30 Oct 2025
 11:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
 <CAFxkdApQVEqCjQMAUqy8cuKnMy8GY9j+brgPZBkxCpeGi5xHxA@mail.gmail.com>
In-Reply-To: <CAFxkdApQVEqCjQMAUqy8cuKnMy8GY9j+brgPZBkxCpeGi5xHxA@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Oct 2025 19:09:31 +0100
X-Gm-Features: AWmQ_bmanZjZxYXwlDN92d79oco1q_2AvRPQQHVSh93R4vGkOq-pVqgD2FItu1g
Message-ID: <CAASaF6zvFa-mPaPfKnBcerfVBkDt5B3TEn7P9jjAfentqSNmxQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check scripts
To: Justin Forbes <jforbes@fedoraproject.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	joe.lawrence@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 10:19=E2=80=AFPM Justin Forbes <jforbes@fedoraprojec=
t.org> wrote:
>
> On Tue, Sep 23, 2025 at 9:31=E2=80=AFAM Jan Stancek <jstancek@redhat.com>=
 wrote:
> >
> > We've been observing rare non-deterministic kconfig failures during
> > olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> > disabled and with it number of other config options that depend on it.
> >
> > The reason is that gcc-check-fpatchable-function-entry.sh can fail
> > if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
> > there is still someone writing on other side of pipe. `pipefail`
> > propagates that error up to kconfig.
> >
> > This can be seen for example with:
> >   # (set -e; set -o pipefail; yes | grep -q y); echo $?
> >   141
> >
> > or by running the actual check script in loop extensively:
> >   ----------------------------- 8< -------------------------------
> >   function kconfig()
> >   {
> >     for i in `seq 1 100`; do
> >       arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
> >         ./scripts/dummy-tools/gcc -mlittle-endian \
> >         || { echo "Oops"; exit 1; }
> >     done
> >   }
> >
> >   for ((i=3D0; i<$(nproc); i++)); do kconfig & done
> >   wait; echo "Done"
> >   ----------------------------- >8 -------------------------------
> >
> > Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-funct=
ion-entry")
> > Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
> > Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
> >  arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh =
b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> > index 06706903503b..baed467a016b 100755
> > --- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> > +++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> > @@ -2,7 +2,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  set -e
> > -set -o pipefail
> >
> >  # To debug, uncomment the following line
> >  # set -x
> > diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/pow=
erpc/tools/gcc-check-mprofile-kernel.sh
> > index 73e331e7660e..6193b0ed0c77 100755
> > --- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> > +++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> > @@ -2,7 +2,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  set -e
> > -set -o pipefail
> >
> >  # To debug, uncomment the following line
> >  # set -x
> > --
> > 2.47.1
>
> Would love to see this picked up, it fixes a problem we have run into
> with our CI.
>
> Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

Thanks Justin.

Would any maintainers also care to review? Ty.


