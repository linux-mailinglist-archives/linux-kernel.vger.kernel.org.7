Return-Path: <linux-kernel+bounces-815061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F75EB55EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F71CC42A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951762E6CDA;
	Sat, 13 Sep 2025 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6blC4sc"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A02DC775
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744074; cv=none; b=NddjeJo1CxwOII805LlNzq1S4psCchiXWPtCmg51VLA+scRHlSMYKiX1R3pwVHexfMV4NVDMQV64J4ohIC2XgYM1wLrwTdEcndvvbQjsvo/obG3SUvkDxKucTWU9PGGMVB8Ojpau/8Ml81yZtf2NRHUujrd52n8+YgZ9+4/72c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744074; c=relaxed/simple;
	bh=aka9VwKHllHoJlb6yXFx6AebhdsgKvLlBtJD6Knv8g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gppo+14sihTQZqjygbwDrZlMAtwrrA3XhHe+TP5yXhlvFl+vFreKvy0XXw3+Wo5YfTFgOli7Ms+Ny3AFz27NGMmfhEqoQCdW5zJ5/bPgFUFADDXiW1Iz82oVdkXNGEh2+zsGd28AArCfIFkyay2QKoEEd9ys0GGJjI1bdNUxFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6blC4sc; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7222f8f2b44so24017376d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757744070; x=1758348870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCvwV5WoqoYVySUmFtMHQmX2ZgogkxDxtUeViriH4AA=;
        b=L6blC4scI58PAMg06Vndw/gvSEYVhePMVkgPsQmpVH8J1uelRwg5GDN0Do+xpFSBjw
         vYLjySfLA8bDAh247QmpRa3m4rv69BuIOyMymY1PdPyvvyEW38z4DFQJ+uNQU/5R1d1q
         FIPDSTFfsTjX0oCjbmZl0DTDe2uEnTYcAQ4nV4ll5YoT7xbNTSfYmx/aP50Y/MAduH5d
         ELa+vwlNpi2XEb3zQ+NfgwXv12rcxGwSR6GN6P0BHD57x03UbOwBQC59TSM9cO97eKYJ
         +2fBfaouFduGWovcZ+7+rpvM/9d7/6a/1EdEbWWqp6Rpy/OcUS2n+kJFvNP2eDTRbGGe
         i5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744070; x=1758348870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCvwV5WoqoYVySUmFtMHQmX2ZgogkxDxtUeViriH4AA=;
        b=RPvFVdYUo8BUKVSnbtGa7FXFnUarwO+SDS8t1gTnq0tsqOns04OO7fau21WTAb7a6f
         IAXPs78wLwOBzEuY37mk4RW92hgEpcsJvT/18kyOra+NMmno4T9QOlEJQsKQOmyct8uG
         kcsReBayGpZcT+UFLfv5RwNSwOn1ZOHshhWSyrQOHJT//TlPYoabk/+frzhyCCIWrBLk
         bfb01U4+JBOoOTxcqKHRIPK4/+sDLBD7OrxwG2mtHNYANzt/Jd7+XS33CyLZt30b9oVp
         SIjhfltV0mkmRCE4n0H9m1SoV/lKFtronNceNz2cYY3ONrwFKG2HGfMVNd4ugCFHtbO/
         upAw==
X-Forwarded-Encrypted: i=1; AJvYcCUGURI8WopdefnyArOsTWFexgw9aI5xZeFkuI6e4w3idzeu6HZAOT9YjfvuzW29SCKeWW422zSAjJ4kYJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXhEH4a6LTytVAHwysVh/HLi3BqGJMwLmWf2McvnWC2GuOo8e
	qZkDLwOZ7PN1sbpSzUbdgauaQPGA0tHAjUYMRArXlIT/YAIHDufxiOb/H8O8+3zvPPHUCBgiPNx
	otRq+2+jtwsMQdGzhnPpucrbe2DaSSfqDUnbsYYOm
X-Gm-Gg: ASbGncsOnYLA6iUs5COGIvBGrXwI9Nrln7yvtHZr09oM35gyGEFTHV+YUf8khpQFb9y
	YxJsq7yJNa47t3IOndFI4Jc+K2P6WPEGKYRsCyAd21BOYy4lLdkWbHmaYRyzvXTjlOrMsDNuxl5
	1l2d0NzIWj+A53JjHXDEZ00M0X2l9gGC8EhA6piPKdtN5aYIaIWissLjNo39RWhcnaWVvKtisjq
	68N2VgASUp6yMrFbCGphhLf2gWPwrcThA==
X-Google-Smtp-Source: AGHT+IHJrx6ozvbMDWYDP71LNjU3nqhgVJjdnL9fmTR9g9kuYNj5UraKu8PJNDMK54JfJxbFZNaR1S+PCFRCKfHmv5I=
X-Received: by 2002:ad4:5cea:0:b0:766:ab7c:3e89 with SMTP id
 6a1803df08f44-767c5621b4bmr71883766d6.64.1757744070327; Fri, 12 Sep 2025
 23:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
In-Reply-To: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Sat, 13 Sep 2025 14:14:18 +0800
X-Gm-Features: AS18NWAwSSI4FfaR6_Z8Utcpxcsk0azDBC1iBVWsOW6hluo678X_JayUhmQMwFs
Message-ID: <CABVgOSmCNs2DQbyj=MAm-LHBRbEiCO1Adb-mSt+fbgOa8v4iYA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering WARN()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 15:03, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Various KUnit tests require PCI infrastructure to work. All normal
> platforms enable PCI by default, but UML does not. Enabling PCI from
> .kunitconfig files is problematic as it would not be portable. So in
> commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=3Dy. However
> CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() i=
n
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
>
> This warning is confusing when debugging test failures.
>
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
>
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Changes in v2:
> - Rebase onto v6.17-rc1
> - Pick up review from Johannes
> - Link to v1: https://lore.kernel.org/r/20250627-kunit-uml-pci-v1-1-a622f=
a445e58@linutronix.de
> ---
>  lib/kunit/Kconfig                           | 7 +++++++
>  tools/testing/kunit/configs/arch_uml.config | 5 ++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index c10ede4b1d2201d5f8cddeb71cc5096e21be9b6a..1823539e96da30e165fa8d395=
ccbd3f6754c836e 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
>           If unsure, the default timeout of 300 seconds is suitable for m=
ost
>           cases.
>
> +config KUNIT_UML_PCI
> +       bool "KUnit UML PCI Support"
> +       depends on UML
> +       select UML_PCI
> +       help
> +         Enables the PCI subsystem on UML for use by KUnit tests.
> +
>  endif # KUNIT
> diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/=
kunit/configs/arch_uml.config
> index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486ef=
ff8898df79ee090 100644
> --- a/tools/testing/kunit/configs/arch_uml.config
> +++ b/tools/testing/kunit/configs/arch_uml.config
> @@ -1,8 +1,7 @@
>  # Config options which are added to UML builds by default
>
> -# Enable virtio/pci, as a lot of tests require it.
> -CONFIG_VIRTIO_UML=3Dy
> -CONFIG_UML_PCI_OVER_VIRTIO=3Dy
> +# Enable pci, as a lot of tests require it.
> +CONFIG_KUNIT_UML_PCI=3Dy
>
>  # Enable FORTIFY_SOURCE for wider checking.
>  CONFIG_FORTIFY_SOURCE=3Dy
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250626-kunit-uml-pci-a2b687553746
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

