Return-Path: <linux-kernel+bounces-848350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E56B2BCD7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A614334CCB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA342F60CB;
	Fri, 10 Oct 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="O2ZANWc1"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AE2F5473
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106001; cv=none; b=S8tT5ee2xdpvI/YhvH/LGbOfR7I2xX6/WaR0zFqkFI7QrLBpx1lsKHhJ7GjxR+X21JmQG7NTV72D7zYr5Yy4KoSFUxZGaTpw7tsQUEdP0LKZ+QBhLG8u5ikRo7HwwsFO/BJqSM9JJMeiygS0rQoT1R4KzM3re8tygf0GBhqZ4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106001; c=relaxed/simple;
	bh=8F+uffIDeKD9mpI4P9eBphkFJfVJh26VNPZ/oiKMS+Q=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONAWXF//MDh5N4Le1hChFSppfZ1eLmkKmN/71UsYgcpbXLrsSZCSmydnmiHXZ2fBmtbtLdI/6697CiTMG0iCaNYH4U/KkJ87IRwLLfjFmNdyLb28VaSIUCOao2fkxuYUmWgJAuboLRJJ1AM1Ahck3LdMG3M+toGv1OKaoy6hIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=O2ZANWc1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B6E763F7D8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760105996;
	bh=wZFsc0cqoEjkO7gKnFRYSVcb3ZWZEOVIH/oA4k6SVYM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=O2ZANWc1aJh9qDm0BsJ17JgUiBclSlvysh3FvJCtYCbKAykqYMx4tt7GvbmqcbuTQ
	 I08kPRRWzquYvVguPF+Ng7X9YKiDMrfyAr4BN6bvnHa1+KJBRelWWTpSOs3/fmpKy3
	 A7oxLH0dbkfuqCKjLJ8RZF17j/a9ZrthjXhgG9g9aYwWYGVfKdTwjQCEkOeKfRuoMH
	 tKgW1bkMy5pXdJRRg4S2nXnfUTEN7nvSgguq/1yhrfel562fI5h0unJxAlHQP4jSox
	 VoE8kGpEcTT0lxfNBEMGoLFccn2xxVm4Ty5LPN7roVeZ+L4E7GAqJRpkaaUQ8Ex343
	 ozd7TRPEUW8QvR/WpzGHOTTCEo6x+piSNb0roDl45KR/Xzxsc1z2CfN128X7ACMctT
	 Olh5pJ8o1QYlfwdz0ECBs3TWPRiydxdDLZYqrbhw9gd9PqIET1o2caVUXQgTFwITXs
	 7ET6tcu8kD4Frlo1ixdDycqAVHYABReaUeQBHFVemA0NaO40ivLXganoRb1T4gBcdm
	 7PC//u4zZmukDHipisZrbf7M6N0a1tOn0NCC4Bt1iV7QBDNyFGky8EwEriNnGevYPY
	 dUxkzcaLhAuShSRpUCRBBQvFvZXqGRahL4r8PJEVrJR+JX71Qq0tySeT8MF3OowdMT
	 OoSR9O3mgrf4NFT9WcKWR3sQ=
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8e2196b1f9eso4631557241.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105996; x=1760710796;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZFsc0cqoEjkO7gKnFRYSVcb3ZWZEOVIH/oA4k6SVYM=;
        b=XMJWVy4XRLjAqezQhShLJmZrbvjoFfuISvKPVmXd7Nj2tlIHReuMQ1wKqt/SATHKTy
         0FdGeRZWji/OIn90AWwidLdrQlb5CGMToM9r8OBnlX6mySSqXil5ohDEAMiA0h5+AQsb
         Usf05ICvlk4lyxY2I8ViU0pvxnykXGf9Z6QdPoikZtmZCMc4RPRBfHXMHO/9EFv5WmDo
         tvYzIWGSvIyadmB6o99XiXNUoynLkmOXuElwXj2JNshMoicHa8Cj2lH3EzWj/GjPPw/x
         w3F2wM1LjjUuqYRL0XpmWY75oAcYW8YlKEUJ51IWGFYJ1YIkPBIQ2hcW6ZL+E0G/N6Mu
         ywcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU90+Mjs8t8TXxm2+yXQ9pxTOftJU2GfxkLI9QxXGEBkfKcZcbsmALgIay2bOJrNS+pp59WzVtxw4F3NCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DZyCUlTPtNAQTVLyjGzcqkm/iyX5njEuzLXQs3z6tJFzmcts
	UKnpEeeCR42hp172fwjLqYKZz0LeiFjeyOTjxdgYLAL3vJ2Rg2euez/GotJcwiYLXZXNHoVwLwr
	IYCGF4cHB6mMqg1nycNFYy/X1SQgts+vq6CYKVEpHlYr3j343BM3UFHrQa1qSfo3BVAPb7MmG8R
	MlCdXK6MxSBGYSZDc4/YQFyozXOoDbhO1VbdadO7hROpC8nAq4C67u9CKC
X-Gm-Gg: ASbGnctcsbI01iInBEAJo/xzIP1NZCa0FpcjlWPtgtzpmvJDOX/q2W2SDwwLEDmwEja
	idFG9prjsO55wwSD0FBV/zq0vfkt9dzt9khzufDgbrT5sfXV6o4wIQ/R5PHX6lG0ENkQxD1GzDH
	uuJCLxs66N5v6jywi2G3M=
X-Received: by 2002:a05:6102:290a:b0:5d5:f8df:8eeb with SMTP id ada2fe7eead31-5d5f8df90b1mr2375360137.24.1760105995651;
        Fri, 10 Oct 2025 07:19:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtJ5BK2Kci2VugCpCugcyMp0MfaVnQs+KUCQn6J+Waq0JOsbp/jIivsCDhg0pl1qZjDL6SXhAjfxWgLCXGQEQ=
X-Received: by 2002:a05:6102:290a:b0:5d5:f8df:8eeb with SMTP id
 ada2fe7eead31-5d5f8df90b1mr2375335137.24.1760105995272; Fri, 10 Oct 2025
 07:19:55 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 09:19:54 -0500
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 09:19:54 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20251009015839.3460231-18-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com> <20251009015839.3460231-18-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 10 Oct 2025 09:19:54 -0500
X-Gm-Features: AS18NWBjDcHrw1s8RwyRjhr8EvaCuZc8XkxMvBfhsZ2PsGnZOM9VUAkh7k1guZY
Message-ID: <CAJM55Z_C_ce6wwCpNyGeozxBKW1krSrdzApvGumLn_p7K0hhYw@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] riscv: dts: starfive: jh7100: Use physical
 memory ranges for DMA
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	Emil Renner Berthing <kernel@esmil.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Samuel Holland wrote:
> JH7100 provides a physical memory region which is a noncached alias of
> normal cacheable DRAM. Now that Linux can apply PMAs by selecting
> between aliases of a physical memory region, any page of DRAM can be
> marked as noncached for use with DMA, and the preallocated DMA pool is
> no longer needed. This allows portable kernels to boot on JH7100 boards.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Move the JH7100 DT changes from jh7100-common.dtsi to jh7100.dtsi
>  - Keep RISCV_DMA_NONCOHERENT and RISCV_NONSTANDARD_CACHE_OPS selected
>
>  arch/riscv/Kconfig.errata                     | 19 ---------------
>  arch/riscv/Kconfig.socs                       |  2 ++
>  .../boot/dts/starfive/jh7100-common.dtsi      | 24 -------------------
>  arch/riscv/boot/dts/starfive/jh7100.dtsi      |  4 ++++
>  4 files changed, 6 insertions(+), 43 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e318119d570de..62700631a5c5d 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -53,25 +53,6 @@ config ERRATA_SIFIVE_CIP_1200
>
>  	  If you don't know what to do here, say "Y".
>
> -config ERRATA_STARFIVE_JH7100
> -	bool "StarFive JH7100 support"
> -	depends on ARCH_STARFIVE
> -	depends on !DMA_DIRECT_REMAP
> -	depends on NONPORTABLE
> -	select DMA_GLOBAL_POOL
> -	select RISCV_DMA_NONCOHERENT
> -	select RISCV_NONSTANDARD_CACHE_OPS
> -	select SIFIVE_CCACHE
> -	default n
> -	help
> -	  The StarFive JH7100 was a test chip for the JH7110 and has
> -	  caches that are non-coherent with respect to peripheral DMAs.
> -	  It was designed before the Zicbom extension so needs non-standard
> -	  cache operations through the SiFive cache controller.
> -
> -	  Say "Y" if you want to support the BeagleV Starlight and/or
> -	  StarFive VisionFive V1 boards.
> -
>  config ERRATA_THEAD
>  	bool "T-HEAD errata"
>  	depends on RISCV_ALTERNATIVE
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 848e7149e4435..a8950206fb750 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -50,6 +50,8 @@ config SOC_STARFIVE
>  	bool "StarFive SoCs"
>  	select PINCTRL
>  	select RESET_CONTROLLER
> +	select RISCV_DMA_NONCOHERENT
> +	select RISCV_NONSTANDARD_CACHE_OPS

Hi Samuel,

Thanks for working on this! I think you also need to select DMA_DIRECT_REMAP
here, otherwise devices complain that they can't allocate coherent memory at
all.

But even with that added it still doesn't work for me with 6.17 on the JH7100,
the sdcard isn't initialized properly, and I haven't figured out why yet. I
seem to remember your previous version did work though.

Plain 6.17:          https://esmil.dk/pma/upstream.txt
6.17 + this series:  https://esmil.dk/pma/test.txt

The kernel config I'm using is available here:
https://esmil.dk/pma/config.txt

/Emil

>  	select ARM_AMBA
>  	help
>  	  This enables support for StarFive SoC platform hardware.
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> index ae1a6aeb0aeaa..47d0cf55bfc02 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
> @@ -42,30 +42,6 @@ led-ack {
>  		};
>  	};
>
> -	reserved-memory {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		dma-reserved@fa000000 {
> -			reg = <0x0 0xfa000000 0x0 0x1000000>;
> -			no-map;
> -		};
> -
> -		linux,dma@107a000000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x10 0x7a000000 0x0 0x1000000>;
> -			no-map;
> -			linux,dma-default;
> -		};
> -	};
> -
> -	soc {
> -		dma-ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x7a000000>,
> -			     <0x00 0xfa000000 0x10 0x7a000000 0x00 0x01000000>,
> -			     <0x00 0xfb000000 0x00 0xfb000000 0x07 0x85000000>;
> -	};
> -
>  	wifi_pwrseq: wifi-pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&gpio 37 GPIO_ACTIVE_LOW>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> index 7de0732b8eabe..34ff65d65ac7e 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -7,11 +7,15 @@
>  /dts-v1/;
>  #include <dt-bindings/clock/starfive-jh7100.h>
>  #include <dt-bindings/reset/starfive-jh7100.h>
> +#include <dt-bindings/riscv/physical-memory.h>
>
>  / {
>  	compatible = "starfive,jh7100";
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> +	riscv,physical-memory-regions =
> +		<0x00 0x80000000 0x08 0x00000000 (PMA_RWXA | PMA_NONCOHERENT_MEMORY) 0x0>,
> +		<0x10 0x00000000 0x08 0x00000000 (PMA_RWX | PMA_NONCACHEABLE_MEMORY | PMR_ALIAS(1)) 0x0>;
>
>  	cpus: cpus {
>  		#address-cells = <1>;
> --
> 2.47.2
>

