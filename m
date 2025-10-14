Return-Path: <linux-kernel+bounces-851969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCBBD7D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B65423368
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0623B62B;
	Tue, 14 Oct 2025 07:17:16 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14F2D781E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426235; cv=none; b=upvgecm9TP/g8MPJODj7Fq+3FV1GjJUOh+TX/DEb25KSqTqNzdeF3M1qNYwh14ECeIaC0U9o9c+962eDo6XMGjyfPMyQykgF7/1TtzVH5m2/nVvqgG4y+dZ5bO3vVSfmEvW0uW9Yj0cwDLyyoJBeFAuQpXzKzhTFXVNrqLBwgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426235; c=relaxed/simple;
	bh=qcHTUS0wo1f43VFStYszqJZcg60j4r28QkB5kGixAXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrXr2rgue7YtDfQM2N451YNW5VUCb7meBtCzmWG/kNoVApTSBEEMsLRZImxzB5qw5rxBZ54SiFrOP50aPa0LFjEfOE8e3p0jIgW8FtrjdQR6bbprAvsN1nRv2UZuP+nfsSMNycARfXQ6IHFp+p+F6lshokUiRBHUwCm7d5F2yXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so3549679241.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426231; x=1761031031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LJPJfcpv0pJD66G650kRDT3CGUnlnJtrjGpdse2lj8=;
        b=R+XJayy4fMuc403QA1nw4n5AacQCIBdYTZEuHMHUcLzeMQNzXOXFtWqFTmLyPR5Be3
         B7DkFFQbimhH3jkYNG8iSVsdjY6Pm3oi6waM4WqXcd2pDlfdB9j4apHIwxxFiTonH38F
         tCNz+zxVD0o0ObkX7h1QC1sBAwOvPUz6xCfeWRJERgrg3/eUq0lKcF4u7n5fM9QJfbUG
         fATYs5Qg4EGJQqeJt4S1HtPYKQjhv5DlhX2FX27bVXijxOg/REx2q3fqaPyj/BrmSTrh
         Wg0MrxKVLFB2Ap/oCLgVFjS/oupdGSD3i3Rgv7ByHRLWEvPHdxN5JPFheTVsKfUsC4IH
         HBkA==
X-Forwarded-Encrypted: i=1; AJvYcCXnV0Pq14KxZMcwd1kDnKghJet2aA1V13dm4vERiWP7c5uiDnSxks8LqT9TQ80DDniVUU8QZIS+rV7WtxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfRCbohqk3gtfA6X+Bsmf88mGEwH7RYIn750/SU3HyBjN4VxP
	AbxYnFru1iPbKnjhzXEtUArzedhi6V0coCgpY5fOh6Vj+c0Qv4N4nWYQiIVOUq4K
X-Gm-Gg: ASbGncvc1Ad1QXEih/M4rjvQe38HX092leTCyAgUVu6knQafVFaD4fc+AiiU1XyMeYE
	cU+vvf8J0lBGS99YUYq+EC+NLhlAx520Ug9nB15pX91XMryiYqfu7THGiWFKt3weYvqhDu8ksDV
	lslGRXHtBh/9igNt9DhNwfWO7ZqRpffhjsoL6bBjK4KXtos0sWHbhPDYILpMfPq12t6sV1/4aCK
	QSbVs/4ZLiwh352joGaL3S9l2UYAEeqUNwEM1/EhEdoW+I+166yiZ6nvjQloPDK/WBB9REO0H5r
	RBDvNt/NX46jriqrHS9Nkv6P1SpLAnUWO2O26ZNbvCFby7OTkCmDdFBjBp1MhMeUjBHi5dYQDJe
	nNxFiwTVYhTWtKk1zuYoh5bkMik1xjT722DxM761/Z7oz3ckd0BmJjAG7ayw2G4gFt1QVBDIbcK
	KzKMtmTvVuZOxccA==
X-Google-Smtp-Source: AGHT+IH64efgxQia0DsBe6hjQLcR1CpwCc3YhgR5rDql+nN+UWKoE5D6vhOSaMEjXTyftR0obygIAA==
X-Received: by 2002:a05:6102:2ac3:b0:5d5:d1e1:73e8 with SMTP id ada2fe7eead31-5d5e2204172mr9547290137.13.1760426231163;
        Tue, 14 Oct 2025 00:17:11 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf76cdc0sm3395088241.9.2025.10.14.00.17.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:17:10 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5d28f9b4c8cso4270676137.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:17:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqgRgvE4ZC6tyjBNFwzugxaFAUJERFnjNTNhQgL0aHaUUuufVt9xWf8sgL/10IAWX4SWE7RapOElj8nJs=@vger.kernel.org
X-Received: by 2002:a05:6102:3c8e:b0:4fa:25a2:5804 with SMTP id
 ada2fe7eead31-5d5e220420bmr8840762137.10.1760426229660; Tue, 14 Oct 2025
 00:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
In-Reply-To: <20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 09:16:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
X-Gm-Features: AS18NWBECJtooFXj8wIhcLw2_n3BPi6xXTVAMYxpuf1MNXW6QPz_d-TTeadxeIw
Message-ID: <CAMuHMdXZvoTyWcgRp6TnkybnKY4ekfO9aB33iumPVaR7wvEXkw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-host: Avoid objtool no-cfi warning in rcar_pcie_probe()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Kees Cook <kees@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Mon, 13 Oct 2025 at 20:26, Nathan Chancellor <nathan@kernel.org> wrote:
> After commit 894af4a1cde6 ("objtool: Validate kCFI calls"), compile
> testing pcie-rcar-host.c with CONFIG_FINEIBT=y and CONFIG_OF=n results
> in a no-cfi objtool warning in rcar_pcie_probe():
>
>   $ cat allno.config
>   CONFIG_CFI=y
>   CONFIG_COMPILE_TEST=y
>   CONFIG_CPU_MITIGATIONS=y
>   CONFIG_GENERIC_PHY=y
>   CONFIG_MITIGATION_RETPOLINE=y
>   CONFIG_MODULES=y
>   CONFIG_PCI=y
>   CONFIG_PCI_MSI=y
>   CONFIG_PCIE_RCAR_HOST=y
>   CONFIG_X86_KERNEL_IBT=y
>
>   $ make -skj"$(nproc)" ARCH=x86_64 KCONFIG_ALLCONFIG=1 LLVM=1 clean allnoconfig vmlinux
>   vmlinux.o: warning: objtool: rcar_pcie_probe+0x191: no-cfi indirect call!
>
> When CONFIG_OF is unset, of_device_get_match_data() returns NULL, so
> LLVM knows this indirect call has no valid destination and drops the
> kCFI setup before the call, triggering the objtool check that makes sure
> all indirect calls have kCFI setup.
>
> Check that host->phy_init_fn is not NULL before calling it to avoid the
> warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
> Reviewed-by: Kees Cook <kees@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for your patch!

> ---
> Another alternative is to make this driver depend on CONFIG_OF since it
> clearly requires it but that would restrict compile testing so I went
> with this first.
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa5..15514c9c1927 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>                 goto err_clk_disable;
>
>         host->phy_init_fn = of_device_get_match_data(dev);
> -       err = host->phy_init_fn(host);
> +       err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
>         if (err) {
>                 dev_err(dev, "failed to init PCIe PHY\n");
>                 goto err_clk_disable;

I am afraid you're playing a big game of whack-a-mole, since we tend
to remove these checks, as they can never happen in practice (driver
is probed from DT only, and all entries in rcar_pcie_of_match[] have
a non-NULL .data member)...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

