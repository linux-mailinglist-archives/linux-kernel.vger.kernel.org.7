Return-Path: <linux-kernel+bounces-774458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDFB2B28C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012C8562714
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD62701CC;
	Mon, 18 Aug 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySnic6EQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4685266EE7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549532; cv=none; b=g8MbdanQcaIxrwEoLhtWGU/ZE7K9jcOKoybVSDxk333yOJdIsBEA8/xZlPpFWZu10jE0UykgL04Xp87yvu9LwlwUS4Ivoz1BnVXtoAzrlVssnEddkb9av0/UJ6a3VA7Ed+AcoMN81+Bnnp1FzRfkvwLspOS6JnQwKSucNh7b6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549532; c=relaxed/simple;
	bh=sz7NOl+fgrqNpK2nVMKw/tO/iJarJvYPOgaEmzQIyHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjCIebws963qZ/tHHdwOhMVFuPIv2OSSYg8AjMyfBfikCGGiVYGf5u/67tpTVb0cVW9hG5J4dYFbiW8Dl1BwAvGt0ZeiQ0Jr9Uoae88rmevrrwut3WhxE/WNxgms6nfP5is9B3ZyXphKQe/8gBb3/1wARPTlAD/JiAKffabyCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySnic6EQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-242d1e947feso55695ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755549530; x=1756154330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWVBpHlCEROG5vPrjHJMy+NzPEPZF2lwJBc9InMC8qg=;
        b=ySnic6EQBMTjSqD8h4gQj3vCFyO2WmeQK7yY73k5Z7lJHRojquVHtfMCt7H8NaEJ0b
         fBYDRRqKvwRoX5R0DE5E0ziphkIAve6mOK3q6LfLRY4NvfyoOeIq64RuQkrO68/MOrzK
         9K61LuzhZL1QIoszK0H3FiiCaTU7xv9tFfRrZKQMz3YvCLEmaDBcA2GO2T9WX04ZxyD7
         kfc56mTyG428l3QgU5daYjlkpajAtRqhT2Hm7elfOUBMkKJXjfaYvm5GLq111XcWzbrj
         GBLycC8yeQxErtH/gpiiVY0Sw8f/Bbt/pC+fHxoLPbeotoE8QPsKwcv5ZNARlxg8Bo+o
         zPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549530; x=1756154330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWVBpHlCEROG5vPrjHJMy+NzPEPZF2lwJBc9InMC8qg=;
        b=qipw5kV6x73O9BK8nhVKBMjnGmZjc6aK+QqKao7jhGhu1bEfzcUbJJvB6c3F9bLcPo
         x6xR31XXRItBiNop+fwfQZ1HIBh4poUEAOoSKHOHqIPAh9slokXNry8j32I33kMJ0ol/
         ShQNoX8tZlhE0/XsZRpr/HwoMNj01vnY8MmhFWokPiSWdmJWU0j4Rq+/6Is9CDMh08cA
         81y4F36E0C2yEUZuE6v7FkxYuoIggHLmbQKB66mqaiK4VJx23PkeNXABjBVgBIQD4eo7
         sOa4UuBfwkJvDOvBePFODrn9VlPR7BWk4cSNpvk8K0JCVtMfdcse14BB8Dl6VpeOpZUs
         F42g==
X-Forwarded-Encrypted: i=1; AJvYcCUF/gFHsfz33v1rbI4IeHmOxkIbC3HocfN+1eYL5L1yfu1wYE3go5QCGEs1nsdvQRkFeNrIN+EpQFAsPJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwc8MgLj+LK+Mw1LSkZbrdROnAt+Cre3ZF4ccFyNd6nLbkqMk
	/J1geoK3WZvf6ql5YbyR8ClJGUCbGO5s5uzTRApaC5FOqwEe537tPpGNMJnWL42rNAXycTorDqu
	jPFLhUjqtMQiK35eSAsa3v3dJ6ZauT92pFs5VvLjR
X-Gm-Gg: ASbGncuylzcljfA1K4FBBTVUkoVWF4ZznxAREHJhoCsphfDKODaE7SGBKLK3w7zvSku
	s0e7KnkcE62EEnBAWi43piQJIwch0BtV3WEDIOxvsh75hEozC67R3D4PJfwOfNmFHCBdS3v3l9i
	ZmBhPlEwPUryw5lGkeRdbKllUj2QKzpnSTErQFpTHxocFEOMKEeBD9gAXtu8PZ5e+dTWvlZcWjH
	4q/9DqaWaOG4lprSuOGmzUWGpQ9T7sIp1KCf7edBSY=
X-Google-Smtp-Source: AGHT+IH3tjzSRCFCOW7iAKcAC0SgLTYc7BmvYcDLfXGyGlsPJaZgSG2eggUuwK9HCMqKYzPfWIw1JuYWE8yAbLmEQUE=
X-Received: by 2002:a17:902:ecc7:b0:242:abac:2aae with SMTP id
 d9443c01a7336-245bd9fca9bmr276595ad.12.1755549529421; Mon, 18 Aug 2025
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728093153.2330009-1-changqing.li@windriver.com>
In-Reply-To: <20250728093153.2330009-1-changqing.li@windriver.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 13:38:38 -0700
X-Gm-Features: Ac12FXwxVCsygGvGV4l8trkx-_0w16GjHamI7RWBq0DaCtdziw9C_ni1xL_yXG4
Message-ID: <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
Subject: Re: [PATCH] tools/build: make in-target rule robust against too long
 argument error
To: changqing.li@windriver.com
Cc: namhyung@kernel.org, james.clark@linaro.org, charlie@rivosinc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 2:31=E2=80=AFAM <changqing.li@windriver.com> wrote:
>
> From: Changqing Li <changqing.li@windriver.com>
>
> The command length of in-target scales with the depth of the directory
> times the number of objects in the Makefile. When there are many
> objects, and O=3D[absolute_path] is set, and the absolute_path is
> relatively long. It is possile that this line "$(call
> if_changed,$(host)ld_multi)" will report error:
> "make[4]: /bin/sh: Argument list too long"
>
> For example, build perf tools with O=3D/long/output/path
>
> Like built-in.a and *.mod rules in scripts/Makefile.build, add
> $(objpredix)/ by the shell command instead of by Make's builtin
> function.
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>

Thanks Changqing, the change makes sense to me. The printf is pushing
the values into xargs rather than using $^ with ld. I've tried
reproducing the error to test your fix by creating long directory
names in /tmp and then passing them to O=3D. I've not been able to do
this. Could you send a reproduction for me to test?

Thanks,
Ian

> ---
>  tools/build/Makefile.build | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 3584ff308607..39066a3ef2fc 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -70,11 +70,13 @@ quiet_cmd_gen =3D GEN     $@
>  # If there's nothing to link, create empty $@ object.
>  quiet_cmd_ld_multi =3D LD      $@
>        cmd_ld_multi =3D $(if $(strip $(obj-y)),\
> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(A=
R) rcs $@)
> +                     printf "$(objprefix)%s " $(patsubst $(objprefix)%,%=
,$(filter $(obj-y),$^)) | \
> +                     xargs $(LD) -r -o $@,rm -f $@; $(AR) rcs $@)
>
>  quiet_cmd_host_ld_multi =3D HOSTLD  $@
>        cmd_host_ld_multi =3D $(if $(strip $(obj-y)),\
> -                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -=
f $@; $(HOSTAR) rcs $@)
> +                          printf "$(objprefix)%s " $(patsubst $(objprefi=
x)%,%,$(filter $(obj-y),$^)) | \
> +                          xargs $(HOSTLD) -r -o $@,rm -f $@; $(HOSTAR) r=
cs $@)
>
>  ifneq ($(filter $(obj),$(hostprogs)),)
>    host =3D host_
> --
> 2.34.1
>

