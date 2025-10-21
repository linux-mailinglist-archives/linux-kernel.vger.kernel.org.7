Return-Path: <linux-kernel+bounces-863562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A4BF82BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9004F816C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512E350299;
	Tue, 21 Oct 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqgjPmAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA934E75C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073004; cv=none; b=qwzklPSNmzMy/RK62hbiTxGZbSiteqvAZwsDl0Xm2Uk3+/LMflE4/3kI5OtFBYy/WeIM4E21oSOnDmggLMLRRVqncQZsZIGBDJRRJX6OXaSmiHmEVMX7KKrr9CV+mk1lGJwqbdzjgy0AUxzv0k5WQFYiZ17/h02CByAfP8bzqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073004; c=relaxed/simple;
	bh=8yDmvmglZvjVOp/KRPO8WpehMDxUb0UefPiZgtNhufo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5DyR6dwuaTR9h9BtprV8kaYn2NHTVaLwd9VCgCGtvlV9WkON+QbRFeMZuZJqWV6CH8e9HZNs2lp0qKW7FaE9Jqwm71QNvnB0S0CQLPlnnQBV5s2rOlvYlqc9dhcL6VSHxwJ5esmMUpE2fK7WBSgedG1T7EuQtLDTyK9AL4XE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqgjPmAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C287FC113D0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761073003;
	bh=8yDmvmglZvjVOp/KRPO8WpehMDxUb0UefPiZgtNhufo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QqgjPmAYfYo5cKPjyKGVrru7JcT02HUz1xCJF8TQGSIUQxrdRA6PdSfZiTINP9oJQ
	 92RiWIS2yg3NbJ1tHxiM3apj+zEtsWLdnNoSSd9JXIzq9DSx78Entykbpp12Ty4YdK
	 vf1oFtLqefE4mkaj11eFXjdCSTNmeOoEfwbfwSFc271okdesB377QQDQJFI/xYkYNW
	 w0d9P5UgKBcQnpmA3qHkhQ2n01RHyw0OLtSUT1vD7GFyWr2ATf8PcPzDKUkW9xN9gk
	 i5QX3H7WSgmmHXgL5ywOhG7kIHBDOqYvtEJojkiZolbOUKtfke7TBHgOh1sFzSmGFU
	 nyU0HkUoEBe0w==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-443cef59836so1213186b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:56:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMMprMs8riDUO2TYE8MsgtxAIgjZqo8D0lIm+6AWZp97H1bkhNQqFEmf9soscRgzkqyyculGTg6QlRvlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIfLVrT7FhjLc58fHr8ZLZPBiZ5XoqAq012Q/9b8ZB6apAtD3
	Elmpy6q6Ty/GDwiJZgUqPoF+FNGoPtLVxxvRHO1+v/3sW79Om1FFU2fWKxbpnAzPoJfdjxcQFul
	TBbOnXsu9kzKkCmZjf5qDKJXdtRXsQeM=
X-Google-Smtp-Source: AGHT+IGohavhsojR9mYb/ePcVFaKRZ7g871RvRpy8sKGBnWj3PDmfDeb1aB5bMKDg0Opp/jRvXRPwc6NbeGA5nZsfJs=
X-Received: by 2002:a05:6808:6f8e:b0:43f:5c61:448c with SMTP id
 5614622812f47-443a30d2036mr7827619b6e.39.1761073003108; Tue, 21 Oct 2025
 11:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de> <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com> <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com> <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
 <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
 <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com> <aPfQmy0-7Cd0I9Jp@google.com>
In-Reply-To: <aPfQmy0-7Cd0I9Jp@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 20:56:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbH-S-vQ+rBb6zNE77_pN7n_L0g+LFUmUxontx1xrPZQ@mail.gmail.com>
X-Gm-Features: AS18NWBeMdJjjD5R2mN68_8m6T4J5O_CdkCq2Q4a2fQMD1PJ5_1RxSXECSIhLTk
Message-ID: <CAJZ5v0gbH-S-vQ+rBb6zNE77_pN7n_L0g+LFUmUxontx1xrPZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:27=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Tue, Oct 21, 2025 at 04:18:54PM +0300, Ilpo J=C3=A4rvinen wrote:
> > On Tue, 21 Oct 2025, Rafael J. Wysocki wrote:
> > > So the purpose of this "forbid" call in pci_pm_init() is to "block"
> > > runtime PM for PCI devices by default, but allow user space to
> > > "unblock" it later.
> > >
> > > Would adding a comment to that effect next to that call be useful?
> >
> > It would be useful to improve the wording in PM documentation which is =
too
> > ambiguous. I suggest changing this:
> >
> > "void pm_runtime_forbid(struct device *dev);
> >
> > unset the power.runtime_auto flag for the device and increase its
> > usage counter (used by the /sys/devices/.../power/control interface to
> > effectively prevent the device from being power managed at run time).
> >
> > to:
> >
> > "... (used to prevent the device from being power managed at run time
> > until pm_runtime_allow() or /sys/devices/.../power/control interface
> > allows it)."
>
> Looks like a good change to me, even if just scratching the surface. If
> this goes in a patch, you can add my:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> A separate problem that sorta stopped me from trying to rewrite some of
> the Documentation/ is that we have both
> Documentation/power/runtime_pm.rst and kerneldoc in
> include/linux/pm_runtime.h + drivers/base/power/runtime.c. It doesn't
> feel great having separate variations of the same API docs.
>
> But hey, I shouldn't let "perfect" be the enemy of progress.

Documentation/power/runtime_pm.rst is generally outdated.

There was a plan to replace it with a new document mostly constructed
from pm_runtime.h and pm_runtime.c kerneldocs, but those also require
some work.

I would rather remove the reference to pm_runtime_forbid() from
Documentation/power/runtime_pm.rst entirely and make the other
documentation pieces describe it properly.

