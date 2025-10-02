Return-Path: <linux-kernel+bounces-840351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E98BB42CE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D1F326F65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA34312803;
	Thu,  2 Oct 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cyR0cNSw"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83395311C16
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759415698; cv=none; b=a9GPXUGe+qUTM2JoAVUiAfBHcaX9H/ILpQ/NM+tVV8qcZLce4Nmv3AKt2TGDz9pKFonrwJ80Gl+vYQxqyt8qZBvAnTeBITZLbG9+P4nwpf+5eb7df0yZLohtniuI/czq8rAToZqzSGYAgHOM9bK/ZZtK7AnL5dqavyvli18yfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759415698; c=relaxed/simple;
	bh=a/A8oXHhPqzKUZBU/1bNk3QBCdhWHAye0YSYfmvBVPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgHl/fhBdUIcIjgEQ5lDW+qEnYbp1nQsmnmrhL3bF414913C3DS8dlaT5TjL7tNr82ezbgUoVFKP33jTln7X8V1Q6TvJ69CgRNwImQfnkANNCzQXauUOjXL34LLRzCaRgeOoH40812rNqTNFggnvwnGvf05foFQU/vH1iI2jScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cyR0cNSw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-368348d30e0so10424041fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759415695; x=1760020495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNmlYeXHhash5zxgH9DhIdlE2KIwH0wWzhgZasITOwI=;
        b=cyR0cNSws7qOYDO7ipx3+224M/CaFFnkTpOnJpL/d2PT6gnvqA10xYIg9QW7bblxjz
         SUkgMB0UPCBxpTMqS8qrD+PLDr0y9MNf+GnmGvoJdMiwu7ItMgogGJUx4vjdxgxZfRm8
         b1kxMZZSpp7ipOlohZi6G+mckATUAchF86lQsOCtO/UPrDhPrVOfUA4AX2rhbJXNAzQC
         FC8kMTerM+F9XBcnuvAhYt8eaoWNdHMknALzPo10FOd4JdNc8N/RKxh/0vLRF/qhnnWF
         pXrPQeEkOgc3KUwU5lE94MsI2SfmWym592N5hxQ2cB7tVNnvZ9OI5G+CiMsJ5biXhu9P
         ZHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759415695; x=1760020495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNmlYeXHhash5zxgH9DhIdlE2KIwH0wWzhgZasITOwI=;
        b=uu9zX2uHVZCB5LevfP/sHQdLYtDm7YbZ1PjpEp+6gVoJz2VtogjFuCRpRSFlafaDG2
         PArup578pEnyuL0ooc12m/W6sA53NDkMx3AAfX67sFTzwAEri98HRdjDbQ5HoDtT64Xh
         5gWGDasrxJ/7huKmYGGDK1QWn5qvxSwspV1DfqUPGh5/nOUscOxl1+Fp9fpb2YoqCS00
         hOxoQpIRvUVzFL4jk8RHEvwZkW866dkEjBCEvo5xdmIZH6CWO5AP1bTvWaW+LFA1srhk
         /Tj3zhUvD624uM6Kcx//BCa0LrFTGdm8o1A1rPw2sMHiSYczIGjzWjxazsFNAtyp20pe
         UvFw==
X-Forwarded-Encrypted: i=1; AJvYcCVu3Ps407kzdG9R60O6T6JmZNJEOS1Z0bajScBzzolfOsUpEKTRMPpoYAKAN3F/ofCpmQkFlAeaUL+hDVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+Ydnp5Ag9VNrqBymaK0McHy/Z6VNJR9LoDX7kSstXMCEyNSe
	VD4lRmNoj7w+Y5TUtQE2gNkabigYeOxIB92q8SdTPlZ6dclBcrEAmT6lvLe3zLa93ToqgPNR1PE
	h3BPAwBBedHbs6iy6j9z5yynmIG1siN5FpTVBAuGveQ==
X-Gm-Gg: ASbGnctPUYcq0TB8c1L9llYSZ0zScql+CBAgswhL+96Csymj5A1PcJtmvKYOPaweLgB
	Xd1d1SaIOal0mg3nCO40jin2IL+H7GsdXBxds/9wIy7uUeOZNCPlGkis0pQXm2kgIftwC5NnA5z
	43Gsh0bhjPNqOO3APELo3j6MXc0ZErmm148ZAAx92Jxmd5ccTNfnumSjBZW0ZfFetgB/FD5pZI7
	/QEA7StnlCfQs0fO5kHyOvWol23d5a8
X-Google-Smtp-Source: AGHT+IFt+HGidyg8l78Emkvj1EGjWohAlX0+/ZRuiXiq0rypVlyjBUdN+69ueNvffFtVc0XtC12AKJQj+2BYsW5GjDM=
X-Received: by 2002:a2e:9a0a:0:b0:364:806d:85a6 with SMTP id
 38308e7fff4ca-373a7461b1cmr28467441fa.33.1759415694471; Thu, 02 Oct 2025
 07:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed37635b59b0765ed3dbed6ea33c562a40b9e287.1759243789.git.geert+renesas@glider.be>
 <6555b47f-919b-b56c-4a76-352c904343c2@kernel.org> <20251002-rubbing-nucleus-b353e09be786@spud>
In-Reply-To: <20251002-rubbing-nucleus-b353e09be786@spud>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 2 Oct 2025 20:04:39 +0530
X-Gm-Features: AS18NWCbya2v7nRYZXyrCc0tzPa3O3zZxhM0w6rmVq8q6ADee_VcxRzs9PCiAGY
Message-ID: <CAK9=C2VC2OHzNFXgxZ4eDCUv8MGsjK1OdrD0FR4WUSrOsyFemA@mail.gmail.com>
Subject: Re: [PATCH] clk: COMMON_CLK_RPMI should depend on RISCV
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rahul Pathak <rpathak@ventanamicro.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:06=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Oct 01, 2025 at 07:15:56PM -0600, Paul Walmsley wrote:
> > On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
> >
> > > The RISC-V platform management interface (RPMI) is only available on
> > > RISC-V platforms.  Hence add a dependency on RISCV, to prevent asking
> > > the user about this driver when configuring a kernel for a different
> > > architecture.
> > >
> > > Fixes: 5ba9f520f41a33c9 ("clk: Add clock driver for the RISC-V RPMI c=
lock service group")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks Geert for catching this.
> >
> > This patch is against unmerged patches in -next.  So I'll plan to add t=
his
> > to the PR that I plan to send to Linus tomorrow -- unless any of the
> > drivers/clk maintainers would prefer that I not.
> >
> > > And perhaps the "default RISCV" should be dropped, too?
> >
> > Probably.  I guess we should just add this to the arch/riscv defconfig
> > instead.  Let's wait on this one for a few days to see if anyone has an=
y
> > comments, and consider that change for v6.18-rc fixes.
>
> There's little point having "default RISCV" if it's only available on
> RISCV in the first place, may as well just be "default y" and be
> simpler.
>
> My 2c is that putting it in defconfig is barely worth doing, unless there
> are actual platforms that use it.
> Does QEMU provide a useful test for it that exercises the various code
> paths, that would make it worthwhile to have in defconfig Anup?

Yes, QEMU RPMI support is in the pipeline. The OpenSBI
upstreaming was completed few months back and Linux patches
are going in this merge window (Linux-6.18)

We (Ventana) have already made the QEMU RPMI implementation
public which can be tried until QEMU RPMI upstreaming is completed.
(Refer, dev-upstream branch of https://github.com/ventanamicro/qemu.git)

NOTE: these details are mentioned in cover-letter as well.
(Refer, https://www.spinics.net/lists/linux-clk/msg118229.html)

Regards,
Anup

