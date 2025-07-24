Return-Path: <linux-kernel+bounces-743954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF82B10636
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8E71CE2C64
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA0D28640B;
	Thu, 24 Jul 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsNRxZBq"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4C285C9A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349136; cv=none; b=ZuUnAINKp/9N1PqKsmmdWlMVhQt8/We70y/q++6m0MdsTKZni7PyHVGpv5nL6QgG6nSet6ouADoYIuv97fy5SVt/q27BoupWuzP6Fc4ReF4wXCL2CRo39es4t2GuzoNWQ+gRwJ71GCgxt7PMt9vn0o3ZhfpJUlNrNwLZ4IPQlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349136; c=relaxed/simple;
	bh=lsrdobNXedqupyhEf1nmY4kvJLc1BNFr/lt8SueGFpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g24VzSJkgQU6iZ646+SxICg0tWH3rKxkx6TxCV2iQAi8fIKSBlV9zg4LZCET/8EErOw/8MuabiY0YxS7eaV80BI1MXCzG85OIu04W6G7Yg0001+qepEmrj1FI7fzf8pka/8HeigmP4I/7yDnWjAXxv89SQV3Vt0uo3wPepvXD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsNRxZBq; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4f2fe63d51eso150704137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753349133; x=1753953933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfgfWvgLQHzDdR4FCk0dYuSh23+ZdE0Obn29GMJr5Ao=;
        b=jsNRxZBqjt90nkZG7PuXkxnSeEylN5mxfVZcz0mGqqts0T372v8wlKQOTx3R1fAKZH
         LvXYNeuVWJYWq3FFdN0PC1vEwgFH9nPBKiibQBowiS5rwu5IUpk8jE4xx2UsuxRM9SPh
         fEnohlZCaEbHgrrMhPS9fkvBP1/DuPJnP31PfNTu5zl+E4iT5BnfwLaNW74BB4em9hD/
         p5e0lsaGgY+ro5zKU8JqII+hdqxu0CgEGKviennVP5TdgmftkYnzPG1+vbQGNZDFndty
         Ne1CBUOIK/NdV+c/4gHJyN1kqUY2En8QzG3Njz1yqJrGV9vzfc6MwqGW4ODxctKHLF7n
         AqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349133; x=1753953933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfgfWvgLQHzDdR4FCk0dYuSh23+ZdE0Obn29GMJr5Ao=;
        b=bD2JU9WqGW25f03mSaiVvmKdIuMvvIGUnVaJWuvfC2NdagnixCv/7z5RxRHmz13yZj
         yuaL4LxF+GqItRKgxKhI13oPwInQq0nShI80Mi+nI3k7p4pXlsGGucpEj+2jtkxUxIXF
         Xq4Uus5k6mxU42ufNaOiqRo6C7IuxaTCSUVWBu+TdUHtAFizhP+V3zAudj9YnFuA2/J7
         T/GON+eODmxWQN2i5NwDdX/lJmL0ZdPLTHZx/bg6yBEYE6KVO4/Cpcfur+b7w8vdMVFO
         ldrpQ1jsAiMA/xNrut8482d6yQI5YdhGWpv+Ga+4WvDgK//7hvIKxEyU4+FSjWBqaCzE
         /MRw==
X-Forwarded-Encrypted: i=1; AJvYcCV5+TiXQQ1lQzsyeKfZtY2Yjn+N6HPcrlhOnUQRhMiGHN99hMsd7p1bMjDur5Et/ZcICFO0cR7ouCXKQME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxOK/TwCarJxvaThvchSaMZJrhULGBgO0owB0LBLDbaFx3WUs
	IMX7QYfzr6MWAdeBKkyxhCanBrFVgv3W/4JjKKKS4lacmWXfVjfojqzS1NZzcLZgm9ovUxmM2GU
	O2vYY0piiLW5WGkDL2lK1OS6QE8bvSC0=
X-Gm-Gg: ASbGnct5Vmvc7G972Kl7DTVPIc3lu9UOYlU+1NqhzhbmuvsKURQ22M23e6Mgi0yU3UO
	+a5kwPD+pbT73NLnB1z3xkusu0CtQ8STso28x0C0+P03bprJGpR0irzE5xr9JiZ+oSq2iynJxeL
	J05UaXK+XhSfYBpU5i9Ko8jtC4iocmW9SfygJyfrvh7Q3lLj0+y+53giOJrjGq4Uimc4oWAZF4a
	PCamQU=
X-Google-Smtp-Source: AGHT+IHDqe5a8tkO3pXSqPcj13Abgl7S0fx9ZBBEeCsCH6REszFiywIFLeegwRoqge47mGLogYCLdp3VkKAjoDK9q1g=
X-Received: by 2002:a05:6102:8010:b0:4e5:ac99:e466 with SMTP id
 ada2fe7eead31-4fa151a3c6fmr3055568137.18.1753349132658; Thu, 24 Jul 2025
 02:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com> <20250724085600.4101321-2-xiaqinxin@huawei.com>
In-Reply-To: <20250724085600.4101321-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Jul 2025 17:25:16 +0800
X-Gm-Features: Ac12FXxW120Dk_y6HgixCPO2D95XfBK0RufWFtUptdIUPJkt8TmiDeELPLn6D6k
Message-ID: <CAGsJ_4x1UHW58SjpGcb0vEBdwLPz5gS4i2CFv-eMKs=KObcG8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> dma_map_benchmark is a standalone developer tool rather than an
> automated selftest.  It has no pass/fail criteria, expects manual
> invocation, and is built as a normal userspace binary.Move it to
> tools/dma/ and add a minimal, the original selftest.Makefile entry
> is removed to avoid duplication.
>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  tools/Makefile                                    | 13 +++++++------
>  tools/dma/Makefile                                | 15 +++++++++++++++
>  tools/{testing/selftests =3D> }/dma/config          |  0
>  .../selftests =3D> }/dma/dma_map_benchmark.c        |  0
>  tools/testing/selftests/dma/Makefile              |  7 -------
>  5 files changed, 22 insertions(+), 13 deletions(-)
>  create mode 100644 tools/dma/Makefile
>  rename tools/{testing/selftests =3D> }/dma/config (100%)
>  rename tools/{testing/selftests =3D> }/dma/dma_map_benchmark.c (100%)
>  delete mode 100644 tools/testing/selftests/dma/Makefile
>
> diff --git a/tools/Makefile b/tools/Makefile
> index c31cbbd12c45..72dc0e936632 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -14,6 +14,7 @@ help:
>         @echo '  counter                - counter tools'
>         @echo '  cpupower               - a tool for all things x86 CPU p=
ower'
>         @echo '  debugging              - tools for debugging'
> +       @echo '  dma                    - dma map benchmark'

Please make it more general. Right now we only have the DMA map
benchmark, but we might add more DMA mapping tools in the future.
For examples: tools for dma mapping

>         @echo '  firewire               - the userspace part of nosy, an =
IEEE-1394 traffic sniffer'
>         @echo '  firmware               - Firmware tools'
>         @echo '  freefall               - laptop accelerometer program fo=
r disk protection'
> @@ -69,7 +70,7 @@ acpi: FORCE
>  cpupower: FORCE
>         $(call descend,power/$@)
>
> -counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objt=
ool leds wmi firmware debugging tracing: FORCE
> +counter dma firewire hv guest bootconfig spi usb virtio mm bpf iio gpio =
objtool leds wmi firmware debugging tracing: FORCE
>         $(call descend,$@)
>
>  bpf/%: FORCE
> @@ -122,7 +123,7 @@ kvm_stat: FORCE
>  ynl: FORCE
>         $(call descend,net/ynl)
>
> -all: acpi counter cpupower gpio hv firewire \
> +all: acpi counter cpupower dma gpio hv firewire \
>                 perf selftests bootconfig spi turbostat usb \
>                 virtio mm bpf x86_energy_perf_policy \
>                 tmon freefall iio objtool kvm_stat wmi \
> @@ -134,7 +135,7 @@ acpi_install:
>  cpupower_install:
>         $(call descend,power/$(@:_install=3D),install)
>
> -counter_install firewire_install gpio_install hv_install iio_install per=
f_install bootconfig_install spi_install usb_install virtio_install mm_inst=
all bpf_install objtool_install wmi_install debugging_install tracing_insta=
ll:
> +counter_install dma_install firewire_install gpio_install hv_install iio=
_install perf_install bootconfig_install spi_install usb_install virtio_ins=
tall mm_install bpf_install objtool_install wmi_install debugging_install t=
racing_install:
>         $(call descend,$(@:_install=3D),install)
>
>  selftests_install:
> @@ -164,7 +165,7 @@ kvm_stat_install:
>  ynl_install:
>         $(call descend,net/$(@:_install=3D),install)
>
> -install: acpi_install counter_install cpupower_install gpio_install \
> +install: acpi_install counter_install cpupower_install dma_install gpio_=
install \
>                 hv_install firewire_install iio_install \
>                 perf_install selftests_install turbostat_install usb_inst=
all \
>                 virtio_install mm_install bpf_install x86_energy_perf_pol=
icy_install \
> @@ -178,7 +179,7 @@ acpi_clean:
>  cpupower_clean:
>         $(call descend,power/cpupower,clean)
>
> -counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_cle=
an virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_c=
lean leds_clean firmware_clean debugging_clean tracing_clean:
> +counter_clean dma_clean hv_clean firewire_clean bootconfig_clean spi_cle=
an usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean=
 objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
>         $(call descend,$(@:_clean=3D),clean)
>
>  libapi_clean:
> @@ -224,7 +225,7 @@ build_clean:
>  ynl_clean:
>         $(call descend,net/$(@:_clean=3D),clean)
>
> -clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
> +clean: acpi_clean counter_clean cpupower_clean dma_clean hv_clean firewi=
re_clean \
>                 perf_clean selftests_clean turbostat_clean bootconfig_cle=
an spi_clean usb_clean virtio_clean \
>                 mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean=
 tmon_clean \
>                 freefall_clean build_clean libbpf_clean libsubcmd_clean \
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> new file mode 100644
> index 000000000000..6282eb41e51a
> --- /dev/null
> +++ b/tools/dma/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +bindir ?=3D /usr/bin
> +
> +CFLAGS +=3D -I../../include -I../../usr/include
> +
> +all:
> +       $(CC) $(CFLAGS) dma_map_benchmark.c -o dma_map_benchmark
> +
> +install: all
> +       install -D dma_map_benchmark $(bindir)/bin/dma_map_benchmark
> +
> +clean:
> +       rm -f dma_map_benchmark

Please make the Makefile more general. Right now I only have
dma_map_benchmark, but the Makefile shouldn't be tailored specifically
for just that one. dma_map_benchmark is one of those targets.

And I feel $(bindir)/bin/dma_map_benchmark is an incorrect folder.

Thanks
Barry

