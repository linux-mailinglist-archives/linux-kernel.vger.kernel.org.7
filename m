Return-Path: <linux-kernel+bounces-843714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D7BC00DE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6832634C725
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585693BB48;
	Tue,  7 Oct 2025 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="U/xq3k/T"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BFDDD2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806028; cv=none; b=AFIkc3m+bUaehg5vuerCGr89AZ60CpgH7E4BfPcvfVljRyoS85O8ydYMYgt82hnSFmt+2l34dEkS6T2MdcLodAihv6zPXv9WLScyO18/ukJro2ljRY/Y/YPM7hJYun66BVVaOaqnaUfoghNKmVecUj43k8WI33KSqgqC79JdgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806028; c=relaxed/simple;
	bh=DgmUKVVAZxAHjL7E2EyoaY9AqFDFj5rBrGDH69lmLlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDQFBWCnB6DWDBiZ3w+DOM1c6nskxMeGzq3kGloblzgO9d839Nj7iQf5TYC5qf3mPZP3tZ1cfd5QZFiZLGlRGQBpjdemTSVT5LLel2E6oQx6qpKQZkZxqIlYaW2r3bDxNc24Y3KP6HBVj99f4KlNOicO3SmEVhGlhn5nIvHpTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=U/xq3k/T; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-77f947312a5so47705477b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1759806026; x=1760410826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh3JimG/CE0+qqNKzktY8zBG1UkDVFkdOnHFQNnTyw8=;
        b=U/xq3k/TaiCW4WynxSWpjsJKlWkiRkBeSSfgXbdsdJ5B1BMC6z0ET3VhaG6ocehXrj
         XMELG9vn4x2F1NhX5i7rvWqEY3LV9pETPgETgoyKAW1oHabzclm+slUd//gYhqmCp1ZK
         91vb2s3iWQAvIUY7xtvWVE72df5RxYZTK0adYbS1q17AvU5BEBTapc48T5XEgnbe3Y7+
         /Kj2fE9j3GkLS7eAxVmPHNAzNiAG5q3uQ7KkVbXywXoAUxgVPVNdSJD3+jXsR3wLt2h7
         iuCjnQK+QmbSrOFN4N9moSXnlmU6lGygVFuUKOgW7Rfpfo6cc86vULItbz0/oKWLFwT9
         58lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759806026; x=1760410826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rh3JimG/CE0+qqNKzktY8zBG1UkDVFkdOnHFQNnTyw8=;
        b=vDSk7lYSsuQThg4Kg36zvPxIe+u1dowY2BxY43Rvzj7gVDTTnNGVIUPtmHZaw10mpi
         gy74G+GqwsqbNw1V70OTJXapQY+e5qOHJj35IcyK3fNHkSbIVI2UnmmgajPdjDYtIlY/
         ggFggQSQkqyQLdcwOrs0zJSSGWEUanlmRzfuojv7/+Z3hEP/TQqGq1rWbHmt50xZXP5b
         kT3cr60JeQtKaZxlzK0nrd0DovYcCXRnhFih+8I/r/XDVUnhMgex9v8EfvDsna+wG1Cq
         08pYb0vgB6pQam0VMZSqmJBJ6CPfy6EDqwlWhh+kRe35SWLHT7zGAOFqpN197xLmkHPE
         NH9g==
X-Forwarded-Encrypted: i=1; AJvYcCWZU/SIu4wq8Q2VxcHWPQzalTPPeVe/HsJ1zmy4/3phB8KuDCs/111q5WQk4wO490YWLFK1x3qEcazw9MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLJl2Dr2kwkKas56P/jlgJf+cRcsnQaUez/nmksl2irASeZbT
	PgfUmmoPXiue2bY63OuBCHduMkIeAY+zVElPx1hMbRGHeEqohy7KBdKPY2b6r7zaMLd3mmks/k6
	QcCJndFA2nGsC/D1EyH3f/fZFGF8Wfp2f+VuW5jd5gA==
X-Gm-Gg: ASbGncssi5PrNe0EdQfs6RH2ieWiPeHeLkP5BwIa7gv2xFdX83+dH8+9vgCB7wqxYTr
	iMhcHD4a26RptpqIQRxR9i2neZuHqcACN7S1tJiJuAJCUiTF0C7RpXG1xQ24xUu3RrvPmXS+mdM
	AQbFP+Ve+sK6uoLxU//IkzlU0jf3Fx4tp3+pirvyN3Dd8VkOM817KidDTsJX6VFXSHt6uVu+H7f
	32EJTPW/bBHgX9vfJSaWgERGRMKhgU=
X-Google-Smtp-Source: AGHT+IFpDeFYpJdIwoVLGKv3fyPFV65e4Lo6dOLiNHuo0GiL2CcLB0AMN4rustNbq6B28NgtaFZYGIh1Plud38WHyM4=
X-Received: by 2002:a53:bb89:0:b0:636:1f40:2f5a with SMTP id
 956f58d0204a3-63b9a0f0326mr13414591d50.44.1759806025867; Mon, 06 Oct 2025
 20:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com> <CAM3sHeA2HUpcFJ7LOw1XfjJjLA+A5KsnqFoHe03bv1wHJ_zoMA@mail.gmail.com>
In-Reply-To: <CAM3sHeA2HUpcFJ7LOw1XfjJjLA+A5KsnqFoHe03bv1wHJ_zoMA@mail.gmail.com>
From: Joel Stanley <jms@oss.tenstorrent.com>
Date: Tue, 7 Oct 2025 13:30:09 +1030
X-Gm-Features: AS18NWDkCe_iVrENrFktcYB8dLpg514o3M98A_0nmkuNLzig91F_L4PMhgS3hjQ
Message-ID: <CAM3sHeDPN2AVQHL9VnO-Fk=6Vt6Cs6Cv3qTvb1Mtxif2hNseDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] RISC-V: Add support for Tenstorrent Blackhole SoC
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>, 
	Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>, 
	Anirudh Srinivasan <asrinivasan@tenstorrent.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Drew Fustini <dfustini@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 11:32, Joel Stanley <jms@tenstorrent.com> wrote:
>
> On Tue, 7 Oct 2025 at 07:51, Drew Fustini <fustini@kernel.org> wrote:
> >
> > Enable support for the Tenstorrent Blackhole SoC in the Blackhole P100
> > and P150 PCIe cards [1]. The Blackhole SoC contains four RISC-V CPU
> > tiles consisting of 4x SiFive X280 cores. Each tile is capable of
> > running an instance of Linux.
>
> Nice work Drew!
>
> for the series:
>
> Reviewed-by: Joel Stanley <joel@oss@tenstorrent.com>

I got my email address wrong in three different ways. I meant to say:

Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>

I tested it on hardware with v6.17 too:

[    0.000000] Booting Linux on hartid 3
[    0.000000] Linux version
6.17.0-tt-defconfig-jms-00062-g5874d2146391 (jms@donnager-debian)
(riscv64-unknown-linux-gnu-gcc (g5a43bcc73) 16.0.0 20250923
(experimental), GNU ld (GNU Binutils) 2.45.50.20250912) #76 SMP Tue
Oct  7 12:54:40 ACDT 2025
[    0.000000] Machine model: Tenstorrent Blackhole SoC PCIe card

