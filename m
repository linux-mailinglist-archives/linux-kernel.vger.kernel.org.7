Return-Path: <linux-kernel+bounces-868799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 894ECC0625B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 125394E75D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91831328F;
	Fri, 24 Oct 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPcdRU0c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D77307AFC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307359; cv=none; b=eVjdLIZxhQGjdmyqKt3dsh3sFu2pjeO4DAHYH5HCThPkD52ki0/DapHLnlwJLNerdZk77WdI4uv4PJ1RC8C+NNzFWQ2Atxe61bgUngpfgd1SPaVNe0IUN0/8impmNw0zCpPCqUWgvKgBG7VX762DdRxi/2mZcAJCfKaQVyn7e0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307359; c=relaxed/simple;
	bh=tFRcY03S9pBysIUMdawmEsfvqrNG+fciCRlcmx7O6Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7C8XAPJQDV0Vj7nDijIMWtRWVw91fRt6WfbyrBY8BHTvekg2CEsL0Li5u/4gJrzBn4BLAyTaILoOP1Hrap02SoIDvM+rGgHfuzcHp0NjOw1eX1MnDvVZh5ovuFO3TCRdETeNHWnOQJS5qVlkuh73WwDD2PzHwMtJo8ROZwzwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPcdRU0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D568FC113D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761307358;
	bh=tFRcY03S9pBysIUMdawmEsfvqrNG+fciCRlcmx7O6Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XPcdRU0czc83BsajIw9KFO6NoZSomVwaWfXOi0IgPfjLLQcwPGfGtmQ0UYFQoPTX0
	 jN6AmmnVbyFNYlek3PwG2WXm2jPOLieSDz8VfSo8ZO+uUb3XZD2cNWfxEotCv/9Ika
	 Tdx+vSu+dCrpjf6RZEpholBWj8n/QKagvpL3SeZgMOGzsUeBVMuDBoh0sqXztDtBvI
	 cMlyGT530nhWez3FE8hQjfMaVeLDwcQfBy7J4ULdmjOcsZlXQdmPF/69tTi951456T
	 RLkfakZFk3IcEzmGACrezZH5EivzBaNCFfIhO6dkzjbb3QgYnAoKjwtngXX+BNkSWx
	 w/16F8/2TGaxA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso4236175a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:02:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQV6hj1S+/aQh4BaREnDhp2HE5zquovMhbXPpXM0EhWIgvWv9f8zUzyTGSrveEGL9pNxK4bUnVZsTzXCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PYKt9yQdQIWleq8GYqpTH130qzsAQyK7y8Pnkwdc/FJzuYme
	1Q4nPMmGzCObqa+lLPHB0JrewlC6GuFyeF88GecBX+a7cPXBy4COnQ/1ysVyFiOidXS2fvNRGbx
	s3bmo8IAR05XTavOIATNEDeFSUV6mcw==
X-Google-Smtp-Source: AGHT+IGTfhzju4ppsRKOrxtBpaeTHAnvK9OJtSlhnpNpeQbVDq7TqC2f+5KN7nrrJ1Ua9AMkgX3d1dJ37Sz/n7rfRSo=
X-Received: by 2002:a17:906:794f:b0:b5c:836d:3fda with SMTP id
 a640c23a62f3a-b647324579fmr3242467666b.21.1761307357331; Fri, 24 Oct 2025
 05:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023160415.705294-1-linux@roeck-us.net> <2bef32d0-2c35-c93d-08a8-71966c1212f2@kernel.org>
 <CAL_JsqJjiB3h+hzstXSbnyFy+U39GgtT=rcb4r+QDv=uL54H8g@mail.gmail.com> <1260cd8c-2904-1a21-d7ad-ba9b82f67797@kernel.org>
In-Reply-To: <1260cd8c-2904-1a21-d7ad-ba9b82f67797@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Oct 2025 07:02:25 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=cTOh8YLVaXu-yhn0wKL3ujrtpZEo6_b-c6md0LkK1g@mail.gmail.com>
X-Gm-Features: AWmQ_bluwSCzWVZ_VDiw2fAgBSj1MTumBiAbbRJGgC-PhAG_4d3NVXicPTB_dQc
Message-ID: <CAL_Jsq+=cTOh8YLVaXu-yhn0wKL3ujrtpZEo6_b-c6md0LkK1g@mail.gmail.com>
Subject: Re: [PATCH] of: Skip devicetree kunit tests when RISCV+ACPI doesn't
 populate root node
To: Paul Walmsley <pjw@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:54=E2=80=AFPM Paul Walmsley <pjw@kernel.org> wrot=
e:
>
> On Thu, 23 Oct 2025, Rob Herring wrote:
>
> > On Thu, Oct 23, 2025 at 11:48=E2=80=AFAM Paul Walmsley <pjw@kernel.org>=
 wrote:
> > >
> > > On Thu, 23 Oct 2025, Guenter Roeck wrote:
> > >
> > > > Starting with commit 69a8b62a7aa1 ("riscv: acpi: avoid errors cause=
d by
> > > > probing DT devices when ACPI is used"), riscv images no longer popu=
late
> > > > devicetree if ACPI is enabled. This causes unit tests to fail which=
 require
> > > > the root node to be set.
> > > >
> > > >   # Subtest: of_dtb
> > > >   # module: of_test
> > > >   1..2
> > > >   # of_dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/o=
f/of_test.c:21
> > > >   Expected np is not null, but is
> > > >   # of_dtb_root_node_found_by_path: pass:0 fail:1 skip:0 total:1
> > > >   not ok 1 of_dtb_root_node_found_by_path
> > > >   # of_dtb_root_node_populates_of_root: EXPECTATION FAILED at drive=
rs/of/of_test.c:31
> > > >   Expected of_root is not null, but is
> > > >   # of_dtb_root_node_populates_of_root: pass:0 fail:1 skip:0 total:=
1
> > > >   not ok 2 of_dtb_root_node_populates_of_root
> > > >
> > > > Skip those tests for RISCV if the root node is not populated.
> > > >
> > > > Fixes: 69a8b62a7aa1 ("riscv: acpi: avoid errors caused by probing D=
T devices when ACPI is used")
> > > > Cc: Han Gao <rabenda.cn@gmail.com>
> > > > Cc: Paul Walmsley <pjw@kernel.org>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > Reviewed-by: Paul Walmsley <pjw@kernel.org>  # arch/riscv
> >
> > FWIW, the fixed commit will also prevent enabling features like this
> > series[1] enables. Arm64 is still disabled ATM because of disagreement
> > with the arm64 maintainers, so that can was kicked down the road. It
> > would be better to not disable this and address the issues as they
> > happen rather than breaking people down the road.
>
> Thanks for the context, Rob.  Can you share a pointer to the ARM64
> disagreement thread(s) (either publicly or privately)?

https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/

