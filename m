Return-Path: <linux-kernel+bounces-847456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B74BCAE53
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 429C834F37A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961228135D;
	Thu,  9 Oct 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9FrS3oK"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E401280A56
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044619; cv=none; b=oRu3gAzMMEIpwPzOGBgOphv5OzlhjcLTjAq7L4BRl7xbfMdVuDjimmKRw7T0YoUWMFFx1o0ZfbHbAkpByg/sAZm1SWoDcx7X76G/VJkK1aEydFkSWRk5keguamFpKn8QIuxjiocJphYORprsAKxLO+MektlLhYlIEhpdTRHrCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044619; c=relaxed/simple;
	bh=136CexwisfHYRTSdMvSRrAqwHTp0d1uHkxOjNbFSOYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXSa7VIUmapjUJDyPsATkuRWGs0IhQfsMIBtYvrK4MJZVWkz4P3Ko2z6l4dAsgkI3uuQrVtyhsFQf7dR6c1naI2aVxdoTfhV93VuCL6fPvbc1Sf5bL0LDsTnDIQo2YShzcZlYj419pnAJl6agsuaLcIqvkkfrU2nyg2OBo4Yi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9FrS3oK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so14252516d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760044616; x=1760649416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oXujwRchI6PxKGzOYCJzzcHleakxO6n61GXgCn1ym4=;
        b=S9FrS3oKttUou3sPq4FEmE+oPAUu2l5YJnTzMF/ECaN0VC72mSYEg01QROZRBhRKrK
         sh15HhV3P60LCS5yGolq2ri165GJ/jPupMP/Huu5yidrFZhFJqCb6KgxkLhvVlXCfuEj
         yth8I6VDiLD2ABucL9AbJIj9P13XjvZlzBsNSvb5NXptMMYIh6ggbqsLJAuHrjG1k+Yl
         8w5SdkJKCO91jmExo6sUXF07tffODrOTP5DfuApxiJOJgtgpA7xp90fpgHHx+4JdDNV4
         6mFVsc9g6iVeuvPOjS2u5KDDNRP2r3uG2zqkC1e2VoKZkn0tgiC2bs0XYEYAOKYg0/dk
         zUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044616; x=1760649416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oXujwRchI6PxKGzOYCJzzcHleakxO6n61GXgCn1ym4=;
        b=DjsXIABSfY08i0jh3hloNdHxQHI6KJzS5JXtWfp5DNimRN49icg8dkaVac9AkzGbp7
         6SyUxTgxOTMbE8zXtktI+cRgcD+Ts8fh+sSCHMRvypzq6aTgNqFOebdRqKyOfUrWoFKH
         n07RSvJE9m7cG2rJt01sDaUtx/OwyffcEDOby8bTKGUVhCvD7yFBAgQDLAwA3GuKmPll
         KauvQPN0VwsIaFZFHXMqwOKeA9TxNTohhTJPaqmYCd1WpjQ6y1VM/VR3BbCiOZkxDvRA
         Sovp5+zdIgfeTHnH2r1A6n+8T4zcBCEHWKT6M0TwZrjMQoP8GWDQhT9DjmsliasOaDrQ
         aCrA==
X-Forwarded-Encrypted: i=1; AJvYcCUkt5lcy9lERnBPd0R4CFhkDuyq7jLeL04tQTYurRKO47kMOvfo1Yl1Pjuxb26T+ndQpaDY3Th3RyVk/4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+0jWXampp/H9KWhLlUbeEy1TpIaxjfUzejMgGPzZCGxnRvQgv
	VMVTzLUfYFzi/fX2w7Wt7AQ1nU9QublAx1aXlcsNHbGFCcg4zXWkcvFw8ravDs4yHogi2BRyFyq
	rkZW49rhswPu2BNRDz2wdF4y0pwcwvhqewnOfAPsb
X-Gm-Gg: ASbGnct6p5ggtpCQdp/9itJOuSSVRY4RELlSO97KX6KwOc1DYBMMJoN8ZpSf/6Rllm+
	CKt4fbOy8ZoZC/eoywfQ0cH7IHu4/DwzDIbQGJLbbquQY6FX7bSjBFTD8a9AQxqeGtO/Dy5843b
	Wug5hey8hwJuYcCfCg3EfIlDhdPA9dqezM4kE1p3eTd5DAHowZpSlPmP1dvuys6CJKEXgdFDtrk
	vJcaMTAUehVt444O0IIdFrI10IN+dQmxNINU98LUmpYBheIi+KwMfMyMkCpBkWnYlsXo3vqREkq
	1Nkkcw==
X-Google-Smtp-Source: AGHT+IFgMc87SPfbFwLab29ropD76NfOZG4X0EerGr5foCM6MZh9OqbnEcVikSCwY/ZZjJyB4s4nCkJ9r5jm77pwerQ=
X-Received: by 2002:ad4:594d:0:b0:7a3:cada:a76c with SMTP id
 6a1803df08f44-87b20ff9c54mr127606196d6.2.1760044615980; Thu, 09 Oct 2025
 14:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193839.1350626-1-elsk@google.com> <aOd6QzKQKcYoxMf0@levanger>
In-Reply-To: <aOd6QzKQKcYoxMf0@levanger>
From: "Hong, Yifan" <elsk@google.com>
Date: Thu, 9 Oct 2025 14:16:20 -0700
X-Gm-Features: AS18NWCtpP9bz2_6t_eEQUI74rYcXjb6NGagQEJgDelu0vtpQU97cxLIeGFTFO0
Message-ID: <CAABy=s0yZ3BOOUHpEf1DXatYkSyk1hUwHVBmBAke7Tdvzn3AVA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use $(obj)/ instead of $(src)/ for COPY
To: Nicolas Schier <nsc@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, kernel-team@android.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 2:16=E2=80=AFAM Nicolas Schier <nsc@kernel.org> wrot=
e:
>
> On Mon, Oct 06, 2025 at 07:38:38PM +0000, HONG Yifan wrote:
> > Similar to
> > commit 9a0ebe5011f4 ("kbuild: use $(obj)/ instead of $(src)/ for common=
 pattern rules")
> >
> > This change updates the COPY rule to use $(obj) instead of $(src). This
> > makes Kbuild rules like
> >
> >     always-y +=3D libfoo/.foo.o.cmd
>
> This is a strange example.  Why should we ship any prebuilt .*.o.cmd file=
?

When one ships the .o file, it might be beneficial to also ship the
accompanying .o.cmd file
so that compdb may work, I guess. Though, I just get this example from one
of the SoC manufacturers, so I actually don't know the true reasoning
behind it. I agree that it
isn't a good example.

Still, this applies to any file that does NOT match any existing
pattern rules in Kbuild. It might be more
generic if I had said instead

    always-y +=3D libfoo/foo.xyz

... and we were providing a libfoo/foo.xyz_shipped in the source tree.

>
> >
> > work when the user provides libfoo/.foo.o.cmd_shipped, even when obj an=
d
> > src is different and src is an absolute path. This is useful when foo.o
> > and .foo.o.cmd are checked-in as prebuilts.
> >
> > (Admittedly, `always-y +=3D libfoo/.foo.o.cmd` is not recommended in
> > kbuild/modules.rst, "Several Subdirectories".)
> >
> > For example, if
> >
> >     obj=3D.
> >     src=3D/some/path
> >
> > then the original rule
> >
> >     $(obj)/%: $(src)/%_shipped
> >
> > expands to
> >
> >     ./%: /some/path/%_shipped
> >
> > And when matching against the above example, the stem is just `bar.o`
> > [^1] so the following is looked up:
> >
> >     libfoo/.foo.o.cmd: libfoo//some/path/.foo.o.cmd_shipped
> >
> > ... and it cannot be matched.
> >
> > With this change, the rule expands to
> >
> >     ./%: ./%_shipped
> >
> > ... and it should work, at least for files that does not have a more
> > specific pattern rule.
> >
> > NOTE: that after this change, code like
> >
> >     bar-y +=3D libfoo/foo.o
> >
> > ... with libfoo/foo.o_shipped provided still DOES NOT work, because
> > the pattern rule $(obj)/%.o takes priority. For .o_shipped files,
> > the user still needs an explicit `$(obj)/%.o: $(obj)/%.o_shipped` rule
> > in its own Kbuild file.
> >
> > [^1]: https://www.gnu.org/software/make/manual/html_node/Pattern-Match.=
html
> >
> > Signed-off-by: HONG Yifan <elsk@google.com>
> > ---
> >  scripts/Makefile.lib | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 1d581ba5df66..e066b7b00bcc 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -272,7 +272,7 @@ endef
> >  quiet_cmd_copy =3D COPY    $@
> >        cmd_copy =3D cat $< > $@
> >
> > -$(obj)/%: $(src)/%_shipped
> > +$(obj)/%: $(obj)/%_shipped
> >       $(call cmd,copy)
>
> No, I don't see a reason to support *_shipped files from the build tree.
> The purpose of *_shipped is to deliver prebuilt files with the source
> tree to allow or simplify building the corresponding output files.

The goal is not to support .o_shipped files from the build tree,
though it is indeed one
side effect of the patch. My goal is that we support .o_shipped files
from the source tree when all
of the following is true:

- We are building with O=3D / MO=3D, so $(obj) and $(src) are different,
and in this case $(obj) is `.` and
  $(src) is an absolute path);
- We have a `xxx-y +=3D libfoo/bar.o` line; in other words, the
bar.o_shipped file is in a **subdirectory**
  libfoo below the directory of the Kbuild file. As I said in the
commit message, this is NOT recommended
  (kbuild/modules.rst, "Several Subdirectories"), but it is a
documented way to include a .o file from
  elsewhere.

And as I said in the commit message at the end, unfortunately this
patch still can't achieve this goal for .o files,
only for files that don't match any existing pattern rules, like .cmd
files for example.

Would you please suggest how we can support .o_shipped files in a
subdirectory when building with
$(obj) =3D . and $(src) =3D <some absolute path>? Thank you!

Yifan

>
> Kind regards,
> Nicolas

