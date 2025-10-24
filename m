Return-Path: <linux-kernel+bounces-867944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F75C03FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B370D1AA4A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BCE15539A;
	Fri, 24 Oct 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0PZT/z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC811547E7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761267618; cv=none; b=aazAOZasD5tn/r99+ZEej1LGaIxJUFbHcW8/cSe4Jtf06IfMyXoDBiWIkS7zsJXAG3zLLetdvAu+e0XlWIVMrOKwiPoAwLolq4OozlOfOTqnRRCkQ8oSHJIsNvjGCFxBXoKHkOI5hXwFwCCmpBfzTOcq3FL7YBfwpKz46sGeFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761267618; c=relaxed/simple;
	bh=ehk5gqYro75ea+kxBOikbp2b/GK50O48GMIz57SlOmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsmuRo7Ly3bt45NG56ezN3c4ymfpMEH9fpIDSB41zpC/HSX9vLpsAhGtEgkWYA5G3CuULmi9Y76CYMLn40jAWbRysKpBIwZpST5d7GTlWWF5DIUirCAuzSDiycDXvthhfD7v0+HA6YDTzUqDqvt8Qzh/kjZbH1kkXURig89VByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0PZT/z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BA1C4CEFF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761267618;
	bh=ehk5gqYro75ea+kxBOikbp2b/GK50O48GMIz57SlOmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0PZT/z+0uPfmF3EYkTG0YEenwe3enJsw5n0gPlHeJutghzQs8qu1GtLjm8A4Houc
	 IpiuSSBwwz20WqjSVHFd12KQz2blUFJXtRcMoSXBvNSNutEl2KiHMXEPpflVKck525
	 6a0URvMkwseirX/twN3DGWIiHaMXxWe+Gsdqv8NMhF+11LvSgp61ck1o0e1ojs5r7+
	 wmn7KAVmE6wUNRxV7fMNuC2hLwMqEcJrtGIMJ/TVa/ivQomNzKUu+EfNDpbPHNKZ7f
	 QnY3rO/uqMIPnKqXrgkTUbrfQNulGYPB7epHL04iiJgD2oPA8/ZF4krvyE7YpixXdW
	 +p8KXLzPRWIVg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso310733566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQMkGOJ+ikE9+sxwd4vCMd2x9LnNpr6zG7beX51sXPhFtFhWMW6AtLaMsngY7AtXaEyjLjoaG8Y9fHK9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLFgrNu9po123Q38OFK+lCMy+X6xAnOZh6KAT24YMAz2jK153
	PiNuZDiH4R+t65iqG6vWMWKZF689w7qG9GZHt+8LLax2alQbdpN5wAzEBUlF9Wwv6vXIggyXQf9
	lsMkKtNB5MfI/q4MqlT/5gWUdPwmOEw==
X-Google-Smtp-Source: AGHT+IEjEgQeRaKS1MRniIDNB0DeeoIYpOrEvhgQgtjv9aD4ZD7zdo/az8WJFJUar6TfO+DVKuofLO/h/4vazXCE9ws=
X-Received: by 2002:a05:6402:26c4:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-63e3e477b5bmr4280000a12.18.1761267616822; Thu, 23 Oct 2025
 18:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023160415.705294-1-linux@roeck-us.net> <2bef32d0-2c35-c93d-08a8-71966c1212f2@kernel.org>
In-Reply-To: <2bef32d0-2c35-c93d-08a8-71966c1212f2@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Oct 2025 20:00:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJjiB3h+hzstXSbnyFy+U39GgtT=rcb4r+QDv=uL54H8g@mail.gmail.com>
X-Gm-Features: AWmQ_bkV_0VhcZcZAaOK1XDUuJnahwO7hnusuR-jKXe-TZpuwe9eoSVZYP6h4CU
Message-ID: <CAL_JsqJjiB3h+hzstXSbnyFy+U39GgtT=rcb4r+QDv=uL54H8g@mail.gmail.com>
Subject: Re: [PATCH] of: Skip devicetree kunit tests when RISCV+ACPI doesn't
 populate root node
To: Paul Walmsley <pjw@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:48=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wro=
te:
>
> On Thu, 23 Oct 2025, Guenter Roeck wrote:
>
> > Starting with commit 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by
> > probing DT devices when ACPI is used"), riscv images no longer populate
> > devicetree if ACPI is enabled. This causes unit tests to fail which req=
uire
> > the root node to be set.
> >
> >   # Subtest: of_dtb
> >   # module: of_test
> >   1..2
> >   # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of=
_test.c:21
> >   Expected np is not null, but is
> >   # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
> >   not ok 1 of_dtb_root_node_found_by_path
> >   # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/o=
f/of_test.c:31
> >   Expected of_root is not null, but is
> >   # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:1
> >   not ok 2 of_dtb_root_node_populates_of_root
> >
> > Skip those tests for RISCV if the root node is not populated.
> >
> > Fixes: 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing DT de=
vices when ACPI is used")
> > Cc: Han Gao <rabenda.cn@gmail.com>
> > Cc: Paul Walmsley <pjw@kernel.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Reviewed-by: Paul Walmsley <pjw@kernel.org>  # arch/riscv

FWIW, the fixed commit will also prevent enabling features like this
series[1] enables. Arm64 is still disabled ATM because of disagreement
with the arm64 maintainers, so that can was kicked down the road. It
would be better to not disable this and address the issues as they
happen rather than breaking people down the road.

Rob

[1] https://lore.kernel.org/all/20251015071420.1173068-1-herve.codina@bootl=
in.com/

