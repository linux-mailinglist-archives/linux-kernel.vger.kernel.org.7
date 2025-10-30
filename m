Return-Path: <linux-kernel+bounces-878240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9847C2018B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899F1423A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD5354ACD;
	Thu, 30 Oct 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI232kW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330034F261
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828666; cv=none; b=OUyXWZkOToKxY5myIdZ1sAn5oQ+gFPkqoOL03/EYokL95lSWl4C2SmFnRKDX8keNuCsuqv3zKMrziSSmGYdZz+6rzfFUSWuU2SlQBE6g8dXhXyuCbQqcpk6Yb0GtvELe9+ZQTBeXLQjiNFv7uqokkmuxcov9GcQ2HbcOnXmusyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828666; c=relaxed/simple;
	bh=5h1cBtFITBHG1V2/GlhDV9ML/aFZc//ywlCUXarzQ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTgR6wVDgba0ogRdsg2qaJFGEP/YC6ALKsDqPpBVKAYhIpHAHiG275FugbHzIqpg1mHz7tBpoowxwHbYRWUMYJTxEyK1XYFHNR7MIOcMYs+TTW6Gcvr49I3QQQkp7FIdzSuRPgnAHQzS15cq39H0QmX6D8v6h9hOcZxyrXNmCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI232kW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B79C2BCF5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761828665;
	bh=5h1cBtFITBHG1V2/GlhDV9ML/aFZc//ywlCUXarzQ70=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=AI232kW637stoac32OMD9iT8DVYqZsxhhTwXZbXJToKQ349wcR3cqdQb+b0k/6It/
	 pDVnyfw4xXoEUQdCrE0+r23FzPsM2wrH5fR7yjGkf10Vm2ySNnffps8OphYBMtpWib
	 Bdrs9kHD6ioJTxCReSV9cwKi0kJqstPvBmydqtydaHv57gUPl+BYSzHXV3gPed+BaH
	 6quC2zqF9sZjQ14hFDyqQTUOO/bJ0sMDYyWy6aHc67x6KsrBzkkxTrn1ofIVFz61lU
	 LJY+jmACwg0HpxfqKeZGPlYaW5hREHeBFqCHZWZ1vc8dGDijgil6Ot2GPvbKzJyTY0
	 x1dAYv3zuxSeg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378e8d10494so9493481fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:51:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHIH2Dj5i7evRHNGflyDnV3VY6I8qch8cictGTTDbb1kpU28Vl6dE3EKUYdkeYpEGv/tA7ZvTzZEV+uEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAR1AD80r2I0w71pRQrnopGN72zppwqVGVivArjsbX5NWzGWE/
	KpcfSvjDcHgTq+FZMBSoTDpJjhm/9pl6rorO0fVwidd4uYzWNSbDkaT2rFuNd1BNdR3tN+hwe/o
	ZXWm3Z97B8a6y89JRZzXCLG6xzUSL3J8=
X-Google-Smtp-Source: AGHT+IF2wqgO5+JWiOGk5Lxz8v6mznrJ55QcuwxhOvm6XRdgGpR1HaqZjN9d9PV9QeWms7D3wKkXKE0oYMSR/IRVYtU=
X-Received: by 2002:a05:651c:23d3:10b0:371:a1d1:7fd1 with SMTP id
 38308e7fff4ca-37a024043d6mr17338711fa.37.1761828663602; Thu, 30 Oct 2025
 05:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com> <aQMUu08phVPqfgEB@stanley.mountain>
 <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com> <aQNccP-lHqgygmsu@stanley.mountain>
In-Reply-To: <aQNccP-lHqgygmsu@stanley.mountain>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 30 Oct 2025 20:50:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com>
X-Gm-Features: AWmQ_bmRlZ7jn33uLRcxndRQZ0Q77mIsBRCbJex-ityA5EQyaj6zPuU5wOLOLfE
Message-ID: <CAGb2v664ybgMVCFWcDK-5cJZegC1HJmCg4-qJdgZ=7GAL4jOTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Madieu <john.madieu.xa@bp.renesas.com>, 
	Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:39=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Thu, Oct 30, 2025 at 09:33:39AM +0100, Arnd Bergmann wrote:
> > On Thu, Oct 30, 2025, at 08:33, Dan Carpenter wrote:
> > > On Wed, Oct 29, 2025 at 08:43:33PM +0100, Arnd Bergmann wrote:
> > >> On Wed, Oct 29, 2025, at 18:27, Dan Carpenter wrote:
> > >> > Most syscons are accessed via MMMIO and created automatically.  Bu=
t one
> > >> > example of a syscon that isn't is in drivers/soc/samsung/exynos-pm=
u.c
> > >> > where the syscon can only be accessed via the secure partition.  W=
e are
> > >> > looking at upstreaming a different driver where the syscon will be
> > >> > accessed via SCMI.
> > >> >
> > >> > Normally, syscons are accessed by doing something like
> > >> > syscon_regmap_lookup_by_phandle_args() but that function will
> > >> > automatically create an MMIO syscon if one hasn't been registered.=
  So
> > >> > the ordering becomes a problem.  The exynos-pmu.c driver solves th=
is
> > >> > but it's a bit awkward and it would be even trickier if there were
> > >> > several drivers accessing the same syscon.
> > >>
> > >> What would happen on the current exynos platform if we just take awa=
y
> > >> the 'regs' property? I would hope that we can avoid encoding what
> > >> is essentially operating system policy in that driver and instead
> > >> just describe it as a device that expects to be implemented by
> > >> firmware and doesn't need registers?
> > >
> > > Exynos solves this because they only have one phandle so when they pa=
rse
> > > it, that's when then they create the syscon.  If you had multiple dri=
vers
> > > accessing the same syscon then that doesn't work.
> >
> > I'm not following the logic here.  Do you mean that they avoid the
> > issue today by ensuring that the regmap is always probed before
> > its only user, or do you mean something else?
> >
> > > If we left out the "regs" property it wouldn't be created automatical=
ly
> > > but syscon_regmap_lookup_by_phandle() will return -EINVAL and probe w=
ould
> > > fail.  It needs to be -EPROBE_DEFER so the probe tries again after th=
e
> > > regmap is registered.  We'd need to add a check like this (untested):
> >
> > Right, this is exactly what I had in mind. With a new kernel and old
> > dtb, this would not change anything, while an old kernel but new dtb
> > would run into a different bug and fail to probe instead of using the
> > wrong device. I think both cases are fine.
> >
> >      Arnd
>
> Actually, probably the right thing to do is to leave out the "syscon"
> compatible.  That's what the drivers/soc/sunxi/sunxi_sram.c driver does.
> There is still an ordering issue where the sunxi_sram SoC driver needs
> to be probed first or the stmmac driver probe will fail.  There is probab=
ly
> some kind of way that SoC drivers are always probed earlier?

Yeah. The syscon API still needs to be modified to return -EPROBE_DEFER
to be complete. In our case the failure is unlikely to happen.

On sunxi, the SRAM controller block just happens to be at the beginning
of the MMIO address space, and being at the top of the device tree, lets
it be the first driver to be probed. Unless someone made it a module and
the rootfs wasn't available yet.

Also, in the past, on most devices we were actually using dev_get_regmap()
to retrieve the regmap tied to the device. I think it _may_ be an abuse
of the API? We did have one platform that had no driver for the block
that had the registers the stmmac driver needed, so that one was indeed
a syscon, which is why the dwmac-sun8i driver tries both methods.


ChenYu

> Beside the exynos driver the only other place that calls
> of_syscon_register_regmap() is drivers/soc/renesas/rz-sysc.c but I don't
> think that syscon has any users yet.
>
> regards,
> dan carpenter

