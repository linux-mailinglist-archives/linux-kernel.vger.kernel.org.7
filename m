Return-Path: <linux-kernel+bounces-859098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EEBECC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C154E9A35
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97329A33E;
	Sat, 18 Oct 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKguXYCC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8028467D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779373; cv=none; b=Squ/lP32KetMju5e4gL0jM+xeB8ygNkAb69TmWTuzVRfbdHrhYGjCpshz2h8bH9SucEuk4EkL9SHMx62VoJExNswtV3TacQ+63Q98bwoVIOrOpK59Jw4y2Sf9wFWrE8R749C1heR6BTzYcq+wA38B218gcKw/B+cedzPSP9GhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779373; c=relaxed/simple;
	bh=TaNfOnzJ37bdn5EXfdLd2aTU48YjWL9W2O/pFm741og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhNIrr3q0oVQroCnwosmHKCzoVEVds0uyvzj3cjrFc4CTwRapikHjvPghcxpcwuj1NSa9i1G4RKoQBXEZc2OmjGGSFYN5yEjvHipmEfPa/eiHsfxsYhdNKdTIRTGGOIUQDjiSKEZnTZ8S8wgZnDIMYwl94RLrx7z+CQgCU25orQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKguXYCC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so4361497a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760779370; x=1761384170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TurObsZFmrfjBqIYEt3cBVpmlVp4mzQxFn3YwyTBUP0=;
        b=bKguXYCCOLX+jMX4AR6a2vfDNmZIPJ2zHZMW+NdflzXyraDI4hat8pQl6iz8Qo6zn1
         4Js2W7/9eUFXNeJ8vpejEMyRClMU/p6cGV2kDS1c4yZ3JvFF4OA5zVnFu01fRrdehSwk
         g+B3Aodl5STcsGIey0S4+ZipJtvt1eGlhDbIKqFHhepwahAIzhkQ9qPzpXYA/14olhPO
         RPpSDaeeX4F2TJdSzU8pF6pKKUKHQaoUk/SG03V1kz3bT7WTvqnbbi4dpLdcO6/gVRPj
         P1vaYIkcG/jQ7FP6+YCTiet2l8ip3mwatkbNSAfg529LoAdPdD2cZElDx0IsY8qPqmdx
         aeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779370; x=1761384170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TurObsZFmrfjBqIYEt3cBVpmlVp4mzQxFn3YwyTBUP0=;
        b=BUmhzQtkkClBim3SwfPDt/oViOx0pTxHcpQcGkpeaduwGLIt4moTdC5/9t3gE5ix0D
         iaiARcvO4TVfwS86w/hqGmy1xg89e9rBwqpo2v+L9kiQlz36Hh6kaD3U1wnzid9TFacj
         ECPu3VMJr8KDnzAPDYV9zy/IveDKmDojzHccM9BSIBY9UMKSanIQi9eyFwblEKYb4x4k
         SD2j3k4naiES0AxrmVAfbdaGWFViwRvHczdCSMf1QtS7rB460xOt1g2jeFFrn977fAvh
         dYOgQBKWzXD2N35RrF5yPyXVq8s8s5gmgl5dQmPNz0kBO/Pz7f9cAINco8GD31e3N1Sm
         4oXA==
X-Forwarded-Encrypted: i=1; AJvYcCXp5n6mJrjehQYJ7kviMtrm4lvjilxxpimEqXpx+LinKzQQbfanrXK5fMp4gElFhf0uYbLWuY2oaVCxBHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0D9GGwvA76wlVIRj1zS9n77/3O24v4nrKiQt3lJ9GuH9D+YtX
	KnjEVAYVyW90aYlk2dS730JVsoOkp9IYaOWZJUnWXpoOEKLWJmnJjhcPzprNsA49itPIdN0yrMI
	hr9C+vetAsxArKziAePdMcJTzxzbeCN0=
X-Gm-Gg: ASbGncviXOEd6c9VeKUAxBOYInEEk+az7FyZ2vvnH+THpI86zz6HhTv6Spv9hkLK1hs
	JFWeiIlpCAqGd5BP0jl2MVkTW8HJU9xFS9QQsvYc22LtFvBBFxADyXJpAJN0tSpwd/KVDgb1Ozx
	u+39ibMzFWDVccFzseHBGJq/nkLmIM4WOGldDWc1c1P5j0gqDSR/Vq873hpzRzY6hNuahoKAxiM
	hu064yGpB+M6HI2i9uvUkoIS01OhfS/Pf6tVjI6xri3OAnICNsPF4tEzliWSOiLu7barQ==
X-Google-Smtp-Source: AGHT+IHw19pBZ9IqmqMp9HxxNmCsj695WdYgJZRejOrWZTvR3/bpEeF5am+muoYu9/EE8QnKVNq6O32MbmibLE6n32Q=
X-Received: by 2002:a05:6402:d09:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-63c1f6f6269mr5785386a12.34.1760779370419; Sat, 18 Oct 2025
 02:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014113234.44418-2-linux.amoon@gmail.com> <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
In-Reply-To: <a2cefc72-de44-4a23-92d2-44b58c8c13fe@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 18 Oct 2025 14:52:34 +0530
X-Gm-Features: AS18NWDbaJ8hdNv-j0Yxl1ICNkckxlgqQRK21f2Q02tESiNZuDiGqp2OynZDz4k
Message-ID: <CANAwSgTtaAtCxtF+DGS-Ay4O3_9JMwk-fJ27yoijhWWbF2URrg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: j721e: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Thanks for the review comments.
On Sat, 18 Oct 2025 at 14:26, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Ensure that the return value from dev_err_probe() is consistently assigned
> > back to ret in all error paths within j721e_pcie_probe(). This ensures
> > the original error code are propagation for debugging.
>
> I find the change description improvable.
>
Ok, I will update this once I get some more feedback on the changes.

>
> I propose to take another source code transformation approach better into account.
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075
>
> Example:
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller/cadence/pci-j721e.c#L444-L636
>
>         ret = dev_err_probe(dev, cdns_pcie_init_phy(dev, cdns_pcie), "Failed to init phy\n");
>         if (ret)
>                 goto err_get_sync;
>
No, the correct code ensures that dev_err_probe() is only called when
an actual error
has occurred, providing a clear and accurate log entry. For deferred
probe (-EPROBE_DEFER),
it will correctly log at a debug level, as intended for that scenario.
For other errors,
it will provide a standard error message.
>
> How do you think about to achieve such a source code variant also with the help of
> the semantic patch language (Coccinelle software)?
I do not have any idea about this.
>
> Regards,
> Markus
Thanks
-Anand

