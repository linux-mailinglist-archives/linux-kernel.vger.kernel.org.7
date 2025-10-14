Return-Path: <linux-kernel+bounces-853305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E65BDB2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3BC5428E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CE30594F;
	Tue, 14 Oct 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mc3xoKx4"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5D1946BC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472844; cv=none; b=aZpf+MJdRjGBvtyS770AapYdhZcCsw6p7TIJXWBTnT6bRot5+7DuXUpMnCAmaidaQppMb/HY5u/K6j+Qvbbr6LsEAL/qg8+tbUZM3O1vJSeE68IcX2H28yJer12WPPheBlY3/3w7vuAKbRwFGHMxwgWfz+5bbdL5HjcgWTiCLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472844; c=relaxed/simple;
	bh=4SjEPEjlWep5gU3J6a93orAuWUCgYWFpGeMwqORKnmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw+N1IwZGDTGcvtyp9trkDxMS24+TRiTtbioIvrUePP+dg3Dl8Yoph40KSZXyjpOKgPkgBxzzBQXqrthg+kONR/nBIW0XFpK0SWWrn6tolx7Wztit4bxxnQBbrxnsJzoctgisb8nYT8QW/6gdwNkSGVUwLgt6dlOibRjWO5qjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mc3xoKx4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-362e291924aso41382801fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760472841; x=1761077641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRL7yP55FZsuArjzHnzTt8bkESp9r+xQAl9w62GS3Mk=;
        b=Mc3xoKx4lEehWzQDHoTU+UXsbFg/vtl31qNH64lbPz/u1e/TEmdDATCsVoDH0bOTsa
         9pEJWzCs+UOgeRmMjQOFC9/APu8+If1m4tnVpF73SnE2/Ik9OAvYz3Z1aqKjeEW5pcni
         K/1S26gIwSihR0YvJ01vr69j3OSEHQ57qiw5xu8HNvMCU8h5wRn6X9hMO1nrR4+qt2pa
         yPa6YpUIxjHiBpErq7e+XzGCyrKL5QyN4b+1iKMu3vCaNCI60nkW9gFH0kHCtk3fCpNe
         afzz2Bb4V/WSYbyd8Dn/x9I8nBopQiCcdwCI56w8BySF2fIyD7mSHB/zjrCYPbqs6oCU
         +/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760472841; x=1761077641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRL7yP55FZsuArjzHnzTt8bkESp9r+xQAl9w62GS3Mk=;
        b=o6IYjMl55/5ph7XhQOhuZZhBRlZOJFmnQz8W+6ecskURKi75zvuAWtxf4ych8Wavoo
         ZdLUB1hKXImoFygdcEghBlql4+QnWWfEiBWW49qrn0t4XoToN2ZeGN/hAFGk7pSD6AX9
         kzoySBTXztvULKZvYRJGqd6JpdY3+yblXU57lXcs0a6wWOGonG5+yQIBNlERVddOZvYs
         Sz3uTc/Ha6jGnSgXkLOUCztyK6QJublLXxI0aclcKe6rBAOzyjerTSbp9MCym151L0JX
         0Ue82ma5pivWiuKmOuBGkaEU6jPPIGzjKR/LA3yiCfiu7PiOIJDaNJ1wY/RFjTgCejrA
         mSBw==
X-Forwarded-Encrypted: i=1; AJvYcCW0OpqkIeyhMV/RL5Iz48z52cvDEmyLsPw3qLepCCMRhYisxzEM/JqNaqhZZy4EpaIWcHGo4UmeCC+pwZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1VSFYbE/UjCGE6PmnB6dyu14xbxDxZua163JUG+0J2YSDuJz
	ZGmqGbijbC4JpfVe8uc5ADZgKT1zevgmLlxq5J3g6FSv7HPD0YsZ1TRhsmlSUqrd0/eOqLUBJoo
	CI4NOxDNghZVNZ0+mJEmaY81zkyDj8wpR9P/36w8JEA==
X-Gm-Gg: ASbGncvm07jPNkoMofAh+TEU/uVjgkneak9fTgwXngcaZ/8BVTHQdBRPqMrWb7yVygX
	brF5Eb+hZDrE1ZCHFXife9V1ca37StW3DNCwAmcFf5/IXQBzbGIPlUcf7W8NZxH5DSX/rJH/M33
	Kk+6VFwIfc5KSqeooLLikfB/YZLvuE9Tiz/i6iUZeO5DZKIRmDSCqPwS7HlbWxiscPm0ssdpJVj
	ZpKV0FL+tu4fG8+r2f2Qm7rfdBCFfiSpTnbxPPV
X-Google-Smtp-Source: AGHT+IG+c/RQZD+0BVP0nLHNcQQpCHhF3SSDuV5EMqiXVv1DgN4Em2i5iNrVkDIsVxWl80rtbzj95RlgyVMuiFXBe08=
X-Received: by 2002:a05:651c:4344:10b0:376:3b32:ad9c with SMTP id
 38308e7fff4ca-3763b32b732mr39537411fa.23.1760472841322; Tue, 14 Oct 2025
 13:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152640.154092-1-herve.codina@bootlin.com>
 <20250922152640.154092-8-herve.codina@bootlin.com> <CACRpkdZPURiag1cUQZ319_QA83u+qOCSRALxpe10_+cTcevy+Q@mail.gmail.com>
 <20251001174205.71a08017@bootlin.com> <CACRpkdZ1qg6ecA5DyVEGUHQxLh0SnC=GC5JZdevT99YVWU0ypA@mail.gmail.com>
 <aO5ekPxeg7tdFlHi@shikoro>
In-Reply-To: <aO5ekPxeg7tdFlHi@shikoro>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 22:13:50 +0200
X-Gm-Features: AS18NWASZOxDjvevo6edLy771RxyP0LAmvYlJlH8qS2O9u5M72Qx7DPeuUj90bc
Message-ID: <CACRpkdacJCp8aCCrCAzD5F=_K3g25t_8kZGzaEoXMBnhY8hkzA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:30=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Because the HW design kind of suggests it, I'd think. The GPIO
> controller is a standard Synopsis one ("snps,dw-apb-gpio") without any
> extras. The GPIOMUX (which is extra) is according to the docs part of
> the system controller with a dedicated set of registers. Luckily,
> self-contained and not mangled with other functionality.

Aha I see. If this is so tightly coupled with the Synopsis
designware GPIO then it should be mentioned in the commit
I guess. Also:

config RZN1_IRQMUX
       bool "Renesas RZ/N1 GPIO IRQ multiplexer support" if COMPILE_TEST

+      depends on GPIO_DWAPB || COMPILE_TEST

?

I understand that it is convenient to make this a separate driver.

I'm not sure it is the right thing to do, but it's no a hill I want to
die on so if everyone else thinks I'm wrong, I can just shut up
about it, it's not like this driver is a big obstacle or anything.

Yours,
Linus Walleij

