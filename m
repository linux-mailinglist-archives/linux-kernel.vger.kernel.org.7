Return-Path: <linux-kernel+bounces-848680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03479BCE53C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83F719A7B40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AB253944;
	Fri, 10 Oct 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/dW9lIO"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A121FF4A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122972; cv=none; b=mo2dMMBdJo/daFrNdRDv/aN8h/CGpLCI0Gz3bbMC8CJv5E931nz4xTNZokxdBO9O0OCe/ZRA81rX3jhsX1SinB+0CdmUQw9UTXCqUwWfQco+mhsIs2IdAldJUY38CDVka7Va7koFB/ULRKFwuy4Mj9PfyxRn+rJ/mlLt3XNjqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122972; c=relaxed/simple;
	bh=ONGm+/fW5tWvXic+jldb8HPXfNQq4JzKLLhXOYU1d8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHKX2bVoux0hYLI3Rrl9Nkl1AiT+jZ1V2tWe4sd4XN6ce5+cOgne+RjwRlFaj4W5eStumUj8KjvAGJaUgHTioPSy34a9DRy8X4q/iGG9MMPRFuPFHIUY5g5CaDaHSRY9ofZRVAOi8A0K4/g9cnqtX4VFXL97SBnu8QYGYLQSNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/dW9lIO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-79599d65f75so23609636d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760122966; x=1760727766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l95sezWNH+Q9ncNOnvjdLwTjn0UUlfu+q2zDGxDlEZA=;
        b=c/dW9lIOnHw6iNkfh5F64azlQ6L0ZMjNgSznJaQI/FSyqRZ2tIr5p7VPpiSlPSOuen
         2a+DX3sANkPn+VnkO6hEiXRpJtyZeIkPioNCk2H8X4RsmJ8RyhR3+N71oNkebZRmV5+w
         Bh/DB/r8mAxQEk1GAe1MfNJzoZSmpVF44NwuhE17ijipeUc1uVdOIoIDoQIbsbyC7uZ4
         uDttXBTsy1EAMORDCJgASnB2PI05y1NaEs0CTeOBXFARQqVlDrCXJQrXE9GjOCD76FlU
         2V0zzKsKK0+IOooFbHLCIse4gSNtYDUc3QOTO7dFmR4hswjY2YoYluq7hYh8Fdt25s6W
         IXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122966; x=1760727766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l95sezWNH+Q9ncNOnvjdLwTjn0UUlfu+q2zDGxDlEZA=;
        b=ZSJUkrK1WFAk8PV7fER1MsocanFfRyoNBJoQsmxlXRaTfPRNETtiyY7ta7lHbkOVtD
         EiSN2NQd6Ue+tjKEZF596aM21XWF/5cfQ4QNJQ+7W0HfRlv8Ca8NmXmg+zTxgF/rTgQ2
         q6xWDlOWguqinFSqhAsn1R1SK66eQn/w5Qs8mVhkW4Wm9htyEbSXkF/s5ECOXYbDtiN6
         l/3N2wW2mzwrKcRGR6TB4p0GsBYEzfL7cX2nW/uX/2dd53b3rCHebebzQVDNMhCy1oOd
         /C5JDTmcg0zPVvdHDbP7wzsWWKbbF9RIiNUtJfM8cCHPAyvxjcUS+nttxQQ6DEnGChlG
         Jntw==
X-Forwarded-Encrypted: i=1; AJvYcCWWx0tdEFGCZg6SsqJNI0xDRYCHOnZQ8NEi/bcJPvSdpNG/3dsdZTxCZCZ/Gg63MDYcZGIoucgKSodl8bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XOhyg8lkWbWLzw2zeF+sWiDadRZ1laE1Jason4lrrupcxRqX
	lNynrkANxQyUa3q6du2L4cHqOuzzeAUMxDCzYjA3pyEjeDnSTHU5/yWmsSIgE8R+ptSG03VmQu+
	nQ8P78XPmthrtijMGI4FuZLAM73N06qHBZv+GBHKk
X-Gm-Gg: ASbGnctqkAiMsf1/+zP9NvwxYpEzwT82bbBs5oH6lyJ2SRXnF4IVA+EDjdiUh33zXey
	6+BB7Br3BmNN/N2GvqM/njqCF4UtbDhgpZFH2QFdrPcsP79vX8cF3jSs+MRUJNsuNYquaYxiV1j
	d97B6hiAGqQ916m07jBLEYj3ZU5JZOQtHM75uecrfeRgCSBTjSDH2PuI5s5SI2ZW5sQmPpN2TSS
	ig2psC68T9Q2ViFOSDDxZWzjUvgRTWiUdyNJqmRpnv/r+S4rtUsJX9mqtpEBF3YNkuMu2HVwQwK
X-Google-Smtp-Source: AGHT+IEpA5EbdioaPf3qKcG8P0ENMXWxtvPYfa7xFgKk/+u0TeiDaVlv//85nDiCUfDvrpoSotwckmQ3+uGHWatx/5o=
X-Received: by 2002:a05:6214:224d:b0:804:9cab:926e with SMTP id
 6a1803df08f44-87b2ef64949mr172438546d6.38.1760122965415; Fri, 10 Oct 2025
 12:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193839.1350626-1-elsk@google.com> <aOd6QzKQKcYoxMf0@levanger>
 <CAABy=s0yZ3BOOUHpEf1DXatYkSyk1hUwHVBmBAke7Tdvzn3AVA@mail.gmail.com> <aOlVYtE-aPpptqh5@levanger>
In-Reply-To: <aOlVYtE-aPpptqh5@levanger>
From: "Hong, Yifan" <elsk@google.com>
Date: Fri, 10 Oct 2025 12:02:09 -0700
X-Gm-Features: AS18NWAieVD9ozu5C9f_mxQ9ta11a-5mST_87LvwguzUKv7eM7lOPuLr7n_E47M
Message-ID: <CAABy=s2TBj4FD+D_VR9JiEuVgZo_KbZ5Z5U4CUD-69SLw-q=3w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use $(obj)/ instead of $(src)/ for COPY
To: Nicolas Schier <nsc@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, kernel-team@android.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:57=E2=80=AFAM Nicolas Schier <nsc@kernel.org> wr=
ote:
>
> On Thu, Oct 09, 2025 at 02:16:20PM -0700, Hong, Yifan wrote:
> > On Thu, Oct 9, 2025 at 2:16=E2=80=AFAM Nicolas Schier <nsc@kernel.org> =
wrote:
> > >
> > > On Mon, Oct 06, 2025 at 07:38:38PM +0000, HONG Yifan wrote:
> > > > Similar to
> > > > commit 9a0ebe5011f4 ("kbuild: use $(obj)/ instead of $(src)/ for co=
mmon pattern rules")
> > > >
> > > > This change updates the COPY rule to use $(obj) instead of $(src). =
This
> > > > makes Kbuild rules like
> > > >
> > > >     always-y +=3D libfoo/.foo.o.cmd
> > >
> > > This is a strange example.  Why should we ship any prebuilt .*.o.cmd =
file?
> >
> > When one ships the .o file, it might be beneficial to also ship the
> > accompanying .o.cmd file
> > so that compdb may work, I guess. Though, I just get this example from =
one
> > of the SoC manufacturers, so I actually don't know the true reasoning
> > behind it. I agree that it
> > isn't a good example.
> >
> > Still, this applies to any file that does NOT match any existing
> > pattern rules in Kbuild. It might be more
> > generic if I had said instead
> >
> >     always-y +=3D libfoo/foo.xyz
> >
> > ... and we were providing a libfoo/foo.xyz_shipped in the source tree.
> >
> > >
> > > >
> > > > work when the user provides libfoo/.foo.o.cmd_shipped, even when ob=
j and
> > > > src is different and src is an absolute path. This is useful when f=
oo.o
> > > > and .foo.o.cmd are checked-in as prebuilts.
> > > >
> > > > (Admittedly, `always-y +=3D libfoo/.foo.o.cmd` is not recommended i=
n
> > > > kbuild/modules.rst, "Several Subdirectories".)
> > > >
> > > > For example, if
> > > >
> > > >     obj=3D.
> > > >     src=3D/some/path
> > > >
> > > > then the original rule
> > > >
> > > >     $(obj)/%: $(src)/%_shipped
> > > >
> > > > expands to
> > > >
> > > >     ./%: /some/path/%_shipped
> > > >
> > > > And when matching against the above example, the stem is just `bar.=
o`
> > > > [^1] so the following is looked up:
> > > >
> > > >     libfoo/.foo.o.cmd: libfoo//some/path/.foo.o.cmd_shipped
> > > >
> > > > ... and it cannot be matched.
> > > >
> > > > With this change, the rule expands to
> > > >
> > > >     ./%: ./%_shipped
> > > >
> > > > ... and it should work, at least for files that does not have a mor=
e
> > > > specific pattern rule.
> > > >
> > > > NOTE: that after this change, code like
> > > >
> > > >     bar-y +=3D libfoo/foo.o
> > > >
> > > > ... with libfoo/foo.o_shipped provided still DOES NOT work, because
> > > > the pattern rule $(obj)/%.o takes priority. For .o_shipped files,
> > > > the user still needs an explicit `$(obj)/%.o: $(obj)/%.o_shipped` r=
ule
> > > > in its own Kbuild file.
> > > >
> > > > [^1]: https://www.gnu.org/software/make/manual/html_node/Pattern-Ma=
tch.html
> > > >
> > > > Signed-off-by: HONG Yifan <elsk@google.com>
> > > > ---
> > > >  scripts/Makefile.lib | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index 1d581ba5df66..e066b7b00bcc 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -272,7 +272,7 @@ endef
> > > >  quiet_cmd_copy =3D COPY    $@
> > > >        cmd_copy =3D cat $< > $@
> > > >
> > > > -$(obj)/%: $(src)/%_shipped
> > > > +$(obj)/%: $(obj)/%_shipped
> > > >       $(call cmd,copy)
> > >
> > > No, I don't see a reason to support *_shipped files from the build tr=
ee.
> > > The purpose of *_shipped is to deliver prebuilt files with the source
> > > tree to allow or simplify building the corresponding output files.
> >
> > The goal is not to support .o_shipped files from the build tree,
> > though it is indeed one
> > side effect of the patch. My goal is that we support .o_shipped files
> > from the source tree when all
> > of the following is true:
> >
> > - We are building with O=3D / MO=3D, so $(obj) and $(src) are different=
,
> > and in this case $(obj) is `.` and
> >   $(src) is an absolute path);
> > - We have a `xxx-y +=3D libfoo/bar.o` line; in other words, the
> > bar.o_shipped file is in a **subdirectory**
> >   libfoo below the directory of the Kbuild file. As I said in the
> > commit message, this is NOT recommended
> >   (kbuild/modules.rst, "Several Subdirectories"), but it is a
> > documented way to include a .o file from
> >   elsewhere.
> >
> > And as I said in the commit message at the end, unfortunately this
> > patch still can't achieve this goal for .o files,
> > only for files that don't match any existing pattern rules, like .cmd
> > files for example.
> >
> > Would you please suggest how we can support .o_shipped files in a
> > subdirectory when building with
> > $(obj) =3D . and $(src) =3D <some absolute path>? Thank you!
>
> Thanks for the clarifications.  Please note that shipping .o_shipped
> files with upstream Linux will not happen out of obvious reasons, and I
> am not willing to invest time into supporting any closed-source
> approach.

Thanks for your reply. This is primarily for out-of-tree modules which
are not yet ready to be upstreamed. I agree that shipping prebuilt .o
files does not make sense in upstream Linux.

>
> You might want to try to add the missing rules to your local modules'
> Kbuild file, e.g. something like
>
> $(obj)/%.o: $(obj)/%.o.cmd
>
> $(obj)/%: $(src)/%_shipped | $(obj)/%.o.cmd
>         $(call cmd,copy)

Thanks. This is my current workaround now. I'll treat this as an
acceptable solution for now.

Please kindly disregard this patch.

>
> (not tested, no support).
>
> Good luck and kind regards,
> Nicolas

