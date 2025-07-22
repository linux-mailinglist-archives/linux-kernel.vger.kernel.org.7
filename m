Return-Path: <linux-kernel+bounces-741168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA804B0E0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5573BA3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDF27934A;
	Tue, 22 Jul 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtJ7sLLX"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEC7F9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199031; cv=none; b=insy4bCkOYg271McPy0YTZlyaKUNnWM4Zd3Zty4GAM6yaIEXkfyAPEaQHj2DRU36cZLVcFTqy/zic6gFlR574BvlGxucmk3iMWEBy11cryg2UI7OVLuiXfZWH2U7HnVwEaYmdjEu/iee2G9aGWsDGUkyjU3FsZk3P6dZPfz15dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199031; c=relaxed/simple;
	bh=CUrTdEs39c/xgtv2X/zGY8xDO2egeXZ2WsKsIN2+tRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGuqFWOj2ACl72WulxGHgMxJV6miAc7EbNhOlqVlGW6ZHYe9Y1cXtP/mE5/kjp9P+2b82CK6C7WMCEG38KLZ61PQzPAZWwXEFu1/DEMwWJFo/QGL34XcaRdLCCme1tP/NLjixT23cF8VmxjiuXjGySXYcuqwOyPxl29Rav0Eiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtJ7sLLX; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so141025ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753199029; x=1753803829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cRByzjmXlHakbUDADfLIA3gNPpHcsdJJeFT7D+jLIo=;
        b=FtJ7sLLXvjUVett84jUXd3vhbMLOOCrJ+oq0KZHVQX0rajEQy02LMjrVL1RaAt87IA
         jrXn8C+/62L12S/BXzDm8HfiUUcxgPosoYfTOcikrJa6fVrNFFVqCj1MaQGQrM8NHK+j
         f52y4TD/9JTQOvTzWPLV+a/kHeaxBkKEGxokddtijFuKyZURFNv/0xJFiuHHtJsMZ9jV
         66lT2qcN2/CLwVuHNyjhi3wciAHLSp0V1GDhLU2BRV5UJJTLw+CJ9caYY4VnAxEceWm3
         ILr3CBTJ8qbzekaI1OvhzLN/9eA6NDzUIZuV7AIkeuLZE99aGb5AiD2fDOXaIZhigoWJ
         CE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199029; x=1753803829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cRByzjmXlHakbUDADfLIA3gNPpHcsdJJeFT7D+jLIo=;
        b=P4gUV6Yzx8dKo0V3G/uP7KtXsFX/3Hcwh+qk9oFdJltDK7qj+uAEco+4KfY6RdM0S1
         z+ThyNTFLTk27xIuPajka4PQqzV4w3FZXfv0Q/KokNupJgnwv73Pe4/cwEhZmOjFewn3
         mVEyGUfPn84Js5xxJnSYUtACJMy9WzwcU7KnH4qb6WAa1GxKwo7uzqrMuq6qVUHYY3zx
         vVDsnXGtOa7U4khKRpcJJ/onDlRToa8k6FYZ5tpEqrIlT8j7yClPpNIZvyRkXvHXYCaH
         OfUWCCGFSsd1Cueim86QcKiv997pPMxendEPNRL5nQuIs3OK4U26VaoyUmq2PbNA4R16
         czSw==
X-Forwarded-Encrypted: i=1; AJvYcCUb5qBk0QXqPBIzrCbKVrLa7CRLF+nz3IMNP/7+C2YSAzHcvem8ppFyDcNuykQWM0dPOOTI4LqZnnmUILA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxap3jhql4jTkgwgNxscofjsfOS4QWsgNUGmX+rPhNZilZ+hCtb
	X2fyb2T70D2ThCix50iCT5Bj1izpLQ3zDV5qcxVGSKhShgINHF1TdLlx5YV6rgOViiwzMS7h9HO
	B+Ml8LWcNzUQ3VOB+lenEtx0qBBwRErmXzvyb6h2q
X-Gm-Gg: ASbGncsvIXy9S0HO4Ze3cs7gH/izBAZBrOWR5d5U1MNHmxj/osktyzO/GuPxiSKa31i
	HpZGrq7cGaDsyYhOTqBoGyvdFXd9fUaA9XMsx8zgZP1ugUc9Q8aZJdR0fZbrAKXt6Dlmxvy08+i
	kegdFq1tXUNwiPmUMswZmWM7wOER51ClnEoKzc7K3KeVmpmJs4LrCLHz59KTVE5GVJQhTTJiIN6
	S942UConx4uFh9+XASgKTFjRt9dPI9x/bQH
X-Google-Smtp-Source: AGHT+IH+1Dq67RD41KZSIEi7UFc4mBYEq0GfKGkf8/oIBzjLtcGadoHu0BGd9A8Brk9Hqz+0mZw9anBuKj0rUYDY1BU=
X-Received: by 2002:a05:6e02:214c:b0:3e0:51fc:6e8 with SMTP id
 e9e14a558f8ab-3e2c043f895mr3638245ab.15.1753199028463; Tue, 22 Jul 2025
 08:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722061335.285249-1-changqing.li@windriver.com> <20250722061335.285249-2-changqing.li@windriver.com>
In-Reply-To: <20250722061335.285249-2-changqing.li@windriver.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Jul 2025 08:43:37 -0700
X-Gm-Features: Ac12FXyliPqCkQcVPBqslolnXj7AP69BbNQgfIPMLhspxbvqujqVq8jFiYuM56Y
Message-ID: <CAP-5=fWE4y=t0EF0zwnYyyacncFH0xpwJQGAWW3T2Ruu=STotA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/build: Let link command read option from file
To: changqing.li@windriver.com
Cc: namhyung@kernel.org, charlie@rivosinc.com, james.clark@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 11:13=E2=80=AFPM <changqing.li@windriver.com> wrote=
:
>
> From: Changqing Li <changqing.li@windriver.com>
>
> ld_multi will link multiple objects, when there are many objects, and
> O=3D[absolute_path] is set, and the absolute_path is relatively long. It
> is possile that this line "$(call if_changed,$(host)ld_multi)" will
> report error:
> "make[4]: /bin/sh: Argument list too long"
>
> So make the ld command read option from file to fix above error. In
> order to convenient debug, write the file content in dot-target.cmd
> as comments.
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>

Hi Changqing,

I believe your change makes sense. I notice that the regular kernel
build has had to work around this problem too:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/Makefile.build#n290
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/Makefile.build#n463
but in those workarounds the need for an extra .in file isn't
necessary. Would such a change be possible here and avoid the need for
cleaning up an extra file?

Thanks,
Ian

> ---
>  tools/build/Makefile.build | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 3584ff308607..e57ce8c34685 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -70,11 +70,13 @@ quiet_cmd_gen =3D GEN     $@
>  # If there's nothing to link, create empty $@ object.
>  quiet_cmd_ld_multi =3D LD      $@
>        cmd_ld_multi =3D $(if $(strip $(obj-y)),\
> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(A=
R) rcs $@)
> +                     $(LD) -r -o $@ @$@.in,rm -f $@; $(AR) rcs $@)
>
>  quiet_cmd_host_ld_multi =3D HOSTLD  $@
>        cmd_host_ld_multi =3D $(if $(strip $(obj-y)),\
> -                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -=
f $@; $(HOSTAR) rcs $@)
> +                          $(HOSTLD) -r -o $@ @$@.in,rm -f $@; $(HOSTAR) =
rcs $@)
> +
> +output_ld_multi_dotin =3D $(if $(quiet),,@printf "# %s:\n# " $@.in >> $(=
dot-target).cmd;cat $@.in >> $(dot-target).cmd)
>
>  ifneq ($(filter $(obj),$(hostprogs)),)
>    host =3D host_
> @@ -145,7 +147,10 @@ $(sort $(subdir-obj-y)): $(subdir-y) ;
>
>  $(in-target): $(obj-y) $(test-y) FORCE
>         $(call rule_mkdir)
> +       $(file >$@.in,$(filter $(obj-y),$^))
>         $(call if_changed,$(host)ld_multi)
> +       $(if $(strip $(any-prereq) $(arg-check)), $(output_ld_multi_dotin=
))
> +       @rm $@.in
>
>  __build: $(in-target)
>         @:
> --
> 2.34.1
>

