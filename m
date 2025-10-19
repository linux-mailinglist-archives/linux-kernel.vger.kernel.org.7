Return-Path: <linux-kernel+bounces-859638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD37BEE2D1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7505189C29E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FAB2E5D32;
	Sun, 19 Oct 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RORhZ9RV"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A54286412
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760868976; cv=none; b=LEvIGSoiJcnM8Z4eraWCczCgEMoYrIWAAgr1ndifkXwFn+X9Ks95lhEae8KBi8+FJ42fn8R5oIRk6VLwblI2M5Sen1ynvOgAIa+IM+5c05vgpIb/GTGpTigGxyiIagXy6rtlv06UnHB6XTOF6GAYEgWiITrkuED+EVdkzbvLpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760868976; c=relaxed/simple;
	bh=Y08tXfyNPYZyI02pzti3KblHd6VvVvbdphmuQCznqJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd+9294G14t2c5g+ShE7dalobWUzvdUvoF/VFxC1EBXFQoe5LH73j2ywRjXhCxHFTDOrgQYCFw3rpwS40BOKWfgzoInFcWsgxvFHT8RMxNaVqGB7CVXyi2KWSuJYJVIIYZ313kiSH63PiCGjoPRSQ+X1hHfpZ0m2ZWGL5Z0w80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RORhZ9RV; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so5127637a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760868973; x=1761473773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9u83kC+rt7nZCWulip1b6xtkpKKymTmDmInRZDupgQ=;
        b=RORhZ9RVQjE/eG+e8iqUd1Nz4wVVxWisUfjM1Amqx130yHRgfY0VC/r98RDcMMLjDt
         i1eAO10C5GhNXRG/qAZt8hPjKQP65u6TqH/JuU6RoWu762mM2PeP2eWJHjkoCJBD+l1B
         f8Rl27M8YQoJc7J9BadURA9utXknvLaOIOxYhe0yu5/oFRm5/w0blknUnj1F75GLE+zm
         hlG+yjO3MZIQjTGhe0swuUGsKQ6feF5HVhKYXXaLD93RoBiBprOHFG3Sc3IGD/RqsucR
         1wmc6ACTaxNdIuVvdAu0vWjzgM9t+zEiGY5QdUj2FUjyUaY+syKM0u+teJLznhFdK4Xk
         ItNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760868973; x=1761473773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9u83kC+rt7nZCWulip1b6xtkpKKymTmDmInRZDupgQ=;
        b=NFH3j1+ECj3j+s3qShEehdufvQHuuChkmV5TnVnQBVhw1ax9lQa/oBaJ+XawnJxguE
         b9ilUz+Gb//4Dis1/Xj0DL+Fu8d3TemahUmD1sNNsjGpccs6TZ17D0pS+lBpL7EO51qF
         q7Pmw9k+he8ROnA9cSC2x4KEvycRkqMkTOQ574j/QNZt/ux/1FU5Yyh7uRMAIBL9/hfC
         ZqRiaLSQMFGbBV3L7p7jC5Khyf9fFbT9mEYgPrT04B5YW+HCOFkvTahq71flb8doUNEA
         0D2Q1AlZ9H8Afd4oZETk8CB437tGcq8OhdyQNJUSkT1cM/Cr2ZRvsMaDQjH9yu9Xuamj
         3YfA==
X-Forwarded-Encrypted: i=1; AJvYcCV1VerpnmTmjMr3IiQvrq9elY4zHuXVzefYRGbTGvaH9qGvxZmclIU9TFiX0Na62r/zLFBCgAS4ku8FsMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOFWDYb2FGRHlu18sOeSjSOIqt5vlyHxKqL4aUuBBjmQ832h+
	t2WQe0HfmPAE0R406LTffBGbyatYveWD7uy6uo2NscX51+apV8lYU6Aw77jhXVQ3S5tMPNvT4cm
	lHKvv9yQ+tKCJrY+e33SkADZLZItEBT8=
X-Gm-Gg: ASbGnctk8uXSjXP2vNIGMF9I2NEA3cAe2Lu3ObSuLAj1WGCOvLcTDbXvkbdMUHZvoBV
	tnexrsmNtXuIBliyr1NwixmKm6cTrx4N9GOGJtz9mopsnnHP5BXa9u/kDujPoXuO48O2Y/kck0U
	+qfXAnMi1f+rsVzRuDyaxZhn2d16qcr+rKvdHMWueqhjy1t1lIDDpBHw+WLGDGOKDWKp3NYyRk3
	D45kt3tprAvdwtaBnjx99wNnupuSKNi5jZgej45m/YwUTLle2BK8y1oU2QAH1mOVXYqHw==
X-Google-Smtp-Source: AGHT+IHF5j3FxHGqGSMc6gTJFWS25mlgIJJ+B9ZAQH84yMytfrS9hAu85pLm9QkNmBBzhedGsITk+O2Ty5GQr/NWr/Y=
X-Received: by 2002:a05:6402:3492:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-63c1f6458b6mr9014013a12.14.1760868972724; Sun, 19 Oct 2025
 03:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014113234.44418-2-linux.amoon@gmail.com> <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
 <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com> <cf656a57-bb2f-447e-ac6c-0ab118606dc9@web.de>
In-Reply-To: <cf656a57-bb2f-447e-ac6c-0ab118606dc9@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 15:45:58 +0530
X-Gm-Features: AS18NWDvRsVHc0V4iNWmDuNrhP4ZScJhRSS4H0sOBjz9i6y50fgIVE5YKoNz78A
Message-ID: <CANAwSgT0jSQ3pFR3MQo-ENziqrm=yn-rFBTdHegmknMeFd44OQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: j721e: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus, Vignesh,

On Sat, 18 Oct 2025 at 16:12, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >> I propose to take another source code transformation approach better i=
nto account.
> >> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5=
031-L5075
> >>
> >> Example:
> >> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller=
/cadence/pci-j721e.c#L444-L636
> >>
> >>         ret =3D dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie),=
 "Failed to init phy\n");
> >>         if (ret)
> >>                 goto err_get_sync;
> >>
> > No, the correct code ensures that dev_err_probe() is only called when
> > an actual error
> > has occurred, providing a clear and accurate log entry. =E2=80=A6
>
> Where do you see undesirable technical differences?

The primary issue I wanted to confirm was the function execution order.
since cdns_pcie_init_phy within dev_err_probe function

If other developers agree with the approach, I will modify this in a
separate patch

As Dan Carpenter pointed out - " Wait, no, this doesn't make sense.
It's just assigning ret to itself."

This patch seems irrelevant to me as the return value gets propagated
to the error path.
Sorry for the noise. Let's drop these changes.

Since I don't have this hardware for testing, I will verify it on
another available device.
>
> Regards,
> Markus

Thanks
-Anand

