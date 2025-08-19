Return-Path: <linux-kernel+bounces-776345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E9B2CC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D221C2541D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD62E2295;
	Tue, 19 Aug 2025 18:39:22 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2123815D;
	Tue, 19 Aug 2025 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628761; cv=none; b=dkhDpf3aQlNZqPpHPKGWgvtGIWfVLV1M5hBt26UxW/TE/Gs4cS5HQgcJwJt9jqc6PRD9JBUqxM0YXob9zCtHFjd1vBfSaDY+s3jf3VjPvuTkE09nha64qWHNrfpFo/eyn8Ke5Al5LUUIgD09E4RUOqtjRKaGQpVpHKLdxCsCjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628761; c=relaxed/simple;
	bh=PXzBRIfXwKHZi+PVe3ictws1msxyerhHK53wBLauIiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3bSmniT/CxV+pYRdo7lurj36XfBt4TXvOgfrdpN0HaWMdE8FJ/jXOXHEcZzGaaFZI3MKliN4tbfpG4F2MMxgJqnjWBuQjysrlHCNpzCnnzk3Zf5frNNqId3N9jgcoA/tlzwJt302rJI+xTWZBsTPdS29zsIvUxs4thKLx+Zgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61a8b640e34so1329094a12.1;
        Tue, 19 Aug 2025 11:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628757; x=1756233557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik2CZRraiL4wjLDuUaIjOn1b1SNp0YAfTL1m5BkDZ58=;
        b=kekCatojg+xcsGwyBUKBbo1soZYMJlA/bgmFcK7WoBxrmW9E/LdRNIASuaKT6m2N2W
         zwNDi4Glzb3MmIgYF7eV7E4KPCH1HQTcDSv+i2xpUCYjyNpLhJ6kpG+lnez2hXG1rkw6
         LBy/tRocb5ajajYotI/txFK9a77YWKMlhUPtFcIZoEeCc2M5DOPXkPKeDWUJKh2Aau4f
         9COxRMwQ0yd8mubmdpxsn847tYEjnUKofDWwx4N+WlM2L0ARx2eypoEaoef2zIOKOJAT
         +5yqJs1APwCeLurRmVv55TVu34JX8z6/0Fob16g0u9M7xYu4RcfKW4pteE5aAelXZxqL
         s2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUR3Ed7hJCsPyAuH4TPk5q9xydaIEG1x/5xSwKXhiWroPKcyD73s/2ychD4rxTjbw0GbGoW9wLw+NqI@vger.kernel.org, AJvYcCVCTWZB1UQiVAnnNFW87yRr2dUDS43qRq7TJ0g93nqIjYXNJ2wYw+r9cEAuZUNxOb8Fdzlbx3sde55zqDMd@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVXuelbSlOfWs1b9R4j1aADrg1sUiNQoUMfreSM0XVsmvlsWK
	Mk1K2f5cbOfhJ/iOgUYjauNnJoRSdog3EyVMOOdYzTs3wJXrhp0EcoBK0vDa469VUs8=
X-Gm-Gg: ASbGncsqwMsIZpiQKPrQFRCUizMqAJimuOJUCqW7QDPFGwhAiv84YwVug+vHIJ8BTBp
	eE+EFLGVrK967kdbHqPNO2Z7K14Oq3CoGD/JYxE+N8cqZ6nkK94xbhk13WvJDsTFkb4FU2dVGkc
	R4Gnc4YQVk8thwmZgZyaYt20jA/SSQspcy+Sbx3bStqB1bHvfJq76rdGH5chGDY8noFBBonyhly
	AK8900BbQNUAJD5yWFzz3DL647miwtXg785cTtyiSNIIWFn2vEcy7gso+685V82/JRrJd1CpnB/
	1X/CmEKGGdl1f8KlCFDx74mr0e+3kJAWZTpBtMAN5VAVa9snK0T3nQd4flLzkl0DM5G3If7M5sW
	EePFmxNvptCLx2yLzZL5xdx2PWZnmcWTzfuSuWU9zC015B/8kCNtINO3wKvgEMcM=
X-Google-Smtp-Source: AGHT+IF7AFy6FSUPPsyHhy9n7/V01gRT7a23dcLZNXBOQiiyt098/G3dDt3bs6lWCTEsckZHEmzYlA==
X-Received: by 2002:a05:6402:4407:b0:615:8bee:56b6 with SMTP id 4fb4d7f45d1cf-61a978522c0mr284057a12.34.1755628757067;
        Tue, 19 Aug 2025 11:39:17 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9cfasm2186284a12.9.2025.08.19.11.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 11:39:16 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso7930826a12.0;
        Tue, 19 Aug 2025 11:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPAmP/1OB8cRjPe2bRIyZrN2Z79lxrXnOF3Tk7vT/SbvEimDnjPcpIy+5NoxQrj2AMXHQhHsUNRNrvaRX4@vger.kernel.org, AJvYcCWrPlnuTE0HDJ7DiqhSmTIhVn2298g2CM13NbrSUmX7cuVsYHJ50MbalqRM9Pugy+vChwEm+JYKKzN/@vger.kernel.org
X-Received: by 2002:a05:6402:354a:b0:618:272a:6dc0 with SMTP id
 4fb4d7f45d1cf-61a97825978mr311982a12.27.1755628756633; Tue, 19 Aug 2025
 11:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 19 Aug 2025 14:38:39 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-uMD4xPcmfcoxzdmo_wfHdiUvw=EByY+zG1c5UQ0=EfQ@mail.gmail.com>
X-Gm-Features: Ac12FXwXcPnRZb3XHtBRKxe3pDOsXrkoCrBveLOoTcxv7QMCxYMri1d_dXh5Bt8
Message-ID: <CAEg-Je-uMD4xPcmfcoxzdmo_wfHdiUvw=EByY+zG1c5UQ0=EfQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Apple device tree sync from downstream kernel
To: j@jannau.net
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:53=E2=80=AFAM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> This series pulls changes from the downstream device trees which are
> supported in upstream kernel.
> Most importantly it fixes the PCIe description for a specific iMac model
> (iMac M1, 2 USB-C ports, 2021). This is worked around in the downstream
> kernel by not disabling the port. In preparation for submitting M2
> Pro/Max/Ultra devices trees I investigated the issue on the similarly
> affected M2 Pro Mac mini and fixed it this way.
> It completes the Wlan/BT device nodes for t600x based devices and adds
> the missing 15-inch Macbook Air (M2, 2023).
>
> Checkpatch emits following warnings:
>
> WARNING: DT compatible string vendor "pci14e4" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> Which I chose to ignore. `vendor-prefixes.yaml` prefixes contains no
> other mapping for PCI vendor code and the list of ignored prefixes
> forbids extending it. Both options feel wrong though. "pci${vendor}" is
> clearly a vendor prefix but duplicating the PCI vendor data base feels
> wrong. `vendor-prefixes.yaml` currently does not contain and PCI vendor
> aliases.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Hector Martin (2):
>       arm64: dts: apple: t600x: Comple WiFi properties
>       arm64: dts: apple: t600x: Add bluetooth device nodes
>
> Janne Grunau (3):
>       arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
>       dt-bindings: arm: apple: Add t8112 j415 compatible
>       arm64: dts: apple: Add devicetreee for t8112-j415
>
>  Documentation/devicetree/bindings/arm/apple.yaml |  2 +
>  arch/arm64/boot/dts/apple/Makefile               |  1 +
>  arch/arm64/boot/dts/apple/t6000-j314s.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6000-j316s.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6001-j314c.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6001-j316c.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6001-j375c.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6002-j375d.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi   | 10 +++
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi        | 10 +++
>  arch/arm64/boot/dts/apple/t8103-j457.dts         | 12 +++-
>  arch/arm64/boot/dts/apple/t8112-j415.dts         | 80 ++++++++++++++++++=
++++++
>  12 files changed, 161 insertions(+), 2 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

