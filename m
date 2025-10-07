Return-Path: <linux-kernel+bounces-844030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D209BBC0DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8143C0775
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267EF2D5A0C;
	Tue,  7 Oct 2025 09:38:13 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E512528FD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829892; cv=none; b=fYxKp/kFbGS/t4kcc0/UcHcJOq6VoHmH4SblNszoCm1zpQdo1ITVBjSa+YBA11KnwwCrdtHobQNjFfDB5rQiy2rVlBShzP3bAcDJnGBH/CSO1tTsscPPmr/YPsipdfurEomWX8MMn+XTFXsTEPgIHZeZ4/HfM9joj9GPzQ4hMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829892; c=relaxed/simple;
	bh=vM8pMTuLE07i2LEgmF4lMZLaKCtkOjD8GlbT6u/BICc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1s5kL4/W1Y6l9yEmzTp8IltAeGL51PIJRO3t6LaOGeN/frXMfEX7ZeLALsfHixBZ7KWCUuidcasxciIATnxGr4pV00D7OorseCYwShrJzVAwBuBFdOu110e7GkdekzGMzykS+DngbXDDar/PfBRKGAwsUwP64n0xU53I44j97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa0792200so4510051e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829888; x=1760434688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q+QEIFXqBPYZCCIeDe/OpyZelbNarCGc2Hc+hYBZL4=;
        b=qRrR1RaRp1y/oA52rreL1OZ0TwxFv+SMV5Gk/GjCT6o6uGFfz1KsOYNpuRItobCa1x
         ETXfy6qGYNnWNHZaJulIAXlnfLUYhnTBrFbm/mO4jI1wLUI19Gb9BiYc7iW27EhVSzxY
         qM0oEOpaM/s588edXrDqM3kwBNK+Qxc3BIKMv2onUq/wW3ZlCKmMWf5iUfJLEJo3igfy
         92cLld9B+zI+3/ugmjLBQlfi0hC2v8nxi9mTClA9Ivlwp/pM6d0o4ZI0K5Bmf0F9W4/A
         iwC/D1LNLO9RfpZjlzGBUxByWe+LKVrSBDFaSFAK25A8QltmZKtbPHbobEogOtNl4lel
         PYng==
X-Forwarded-Encrypted: i=1; AJvYcCVql6TZhKiBsKB0S9C6aUts4nBN7c4EaO+wSGM8xxv1ZQmF5r2VPuGHdLppoTqZL6Sb2FWJWp0/kt3jZik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBgaWmXVT1BQiLSERKzj4s3/br+juLdezLqLzb4dU8NgOzxMX
	ERV5lylesW+e75IvSg7O6Hf4sMn9qGChZwwcftuKRAel9M3KftQ5aANGy7xbu5DW
X-Gm-Gg: ASbGncvJxAleh09IXM+i+PRhx+k28HHIp76vELV6HfP/odHrq5QSccxrQlF6Sw0W59X
	HpgBBm/PBPmLGR8gD2t2iYDS5tIpEqrhJCr9xizH+uBlLHL7AHX/HwleDFNwD2Tg5Z4itE6J8yw
	WljvxTC64tLHzzTjTNRyp585yXcM271+SWCToglpx7QGNjP3pFkIqiYB/uWXklgz7i4bAyq95CX
	M79Nx4DB7t+Vr167f6ZsMMxMqYEPdCXeSo2ycuiEcIOxiljpPe41BfDYHIaArYGcHzYr7JfVK1U
	eBqAHBEYYZb3AsGyZJIkf39X+ez2oQzUSC1yq99/kjQDne9UjautQf8u49pl/02zGXRufqi5iF8
	CX9GTqqtzxi4doX3NPStN7PVwLs51o1o+u6VwSHReMmuiYPk/84l3HhN7S8Zz3xvuVnosaqDnSu
	ukvL3ZbaIk
X-Google-Smtp-Source: AGHT+IEvqzvAUvemoPbdRqeCJAmR5XpQMPSZjKfXPl4eSWHhHX2Z8BzJ3O+lmBHvYy7wPQN6Zh6aTA==
X-Received: by 2002:a05:6102:6d0:b0:5a1:f09f:524e with SMTP id ada2fe7eead31-5d41d1131b0mr6445575137.16.1759829888435;
        Tue, 07 Oct 2025 02:38:08 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554a3cb13dasm804428e0c.13.2025.10.07.02.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:38:08 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5a0d17db499so5589383137.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzXTKj+R8Ij18xGUu6ojNajeY7ZXsWgDEjRC7NzLLnPueROLBewpkAhAE8it2mUDKutWDxvy4Zcb4QdJ4=@vger.kernel.org
X-Received: by 2002:a05:6102:292a:b0:5be:57a1:3eda with SMTP id
 ada2fe7eead31-5d41d020b48mr6240729137.2.1759829888107; Tue, 07 Oct 2025
 02:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007092313.755856-1-daniel@thingy.jp> <20251007092313.755856-4-daniel@thingy.jp>
In-Reply-To: <20251007092313.755856-4-daniel@thingy.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Oct 2025 11:37:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
X-Gm-Features: AS18NWCsRb9Pc5BA4Gs-2WvP7BRo3Mx4GNtWy6MFkPi8rKNsMmOdkKU4tfHRGL8
Message-ID: <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] m68k: amiga: Allow PCI
To: Daniel Palmer <daniel@thingy.jp>
Cc: linux-m68k@lists.linux-m68k.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Tue, 7 Oct 2025 at 11:33, Daniel Palmer <daniel@thingy.jp> wrote:
> The Amiga has various options for adding a PCI bus so select HAVE_PCI.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Thanks for your patch!

> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -7,6 +7,7 @@ config AMIGA
>         bool "Amiga support"
>         depends on MMU
>         select LEGACY_TIMER_TICK
> +       select HAVE_PCI
>         help
>           This option enables support for the Amiga series of computers. If
>           you plan to use this kernel on an Amiga, say Y here and browse the

This doesn't make much sense without upstream support for actual
PCI host bridge controllers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

