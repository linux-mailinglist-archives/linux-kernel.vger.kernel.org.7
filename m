Return-Path: <linux-kernel+bounces-825003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E29B8AAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E037E8088
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946931A804;
	Fri, 19 Sep 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpKSAip9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027430DEA7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301462; cv=none; b=ro4kQz3ltQPzZN1N9Ii9eJneGOsdOUPtf9e/rPxNlXMbcPQozawr6nuD1I+zTtD+KU7yPsfRIQ1dK0Dl9763iFh7zVOQBNOI2Xove3Gtf9rXyLi2IbGo68PGYeWnnoPmUJnrLYilcFn9xoVrvqELxrZf6EYdPFbJZt7CCpzHTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301462; c=relaxed/simple;
	bh=5CYsOg5jJr8hUkgsKlQmf7YFSaMYtgi4KA1qSuVJ0ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1/5VHqyDZVkQ7LStmJYjVoHTxyVniekxnakTbAwUoBoGoiLe0EnWEdc4C1TyY6sV+vBjrHnHXXAZO5ukSSUQbQHkzxzm58teXsq1ZWh90bK1FL8pg/24JIIJRZmCrprO88sbYombgDuxkO9jnsMCVGybmrfrfYOPkgwls73JdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpKSAip9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBD2C4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758301462;
	bh=5CYsOg5jJr8hUkgsKlQmf7YFSaMYtgi4KA1qSuVJ0ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VpKSAip9WOBcdnECgAc+lQtBy9gF3+soWTxgvZ12sIqlrfaqNlDcJh9NtFDc8fizx
	 K4CV6lGW55IPBVVPRXLWPyNCICyh89HxsRsJMsQ8EkYc5xRkTNMYBwHvQLIe27HjHO
	 fq5CGpl5LbcxtICk6jjq3rl8hRiT6DXWyKFJjdDpVqiIL7Zf+LYMdINQZbymqvUJhO
	 ksj8WL1wLZvvNUQJicqRigsMgubDofNZsl2XK4zTiu37wSRYS9xQmYavt4kkXrC/bT
	 I2anV1GJkjuaKYeKFuDBdT8Qb6ec2BmJuXO7neTUtfyvx7+m4+7/GvVDqNKvsuIZWo
	 ++4M8mQCNit+A==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-62347d880feso1377156eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:04:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmktvmpTLeu5JYYHrtEhDYWx8AIFGb07McEjWVay8VTZKpAye+o7wQLUpIRGBKJjX/7nv7J6l0rpNtdZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdcKHz9ZMgXLmNaPmviSI5anq62a6qmZtP7TJhszRT+2lVQio
	pQUqn0wdpPSB42KUfVqggAQ/OMPZ5ViiucnjwMW1FR9t2ecs98WGWw5filxepmWkLyWQIAHwOZL
	LDhq6rrfVacBeXwyVB5sN+x9WxZjnPzw=
X-Google-Smtp-Source: AGHT+IGGi8IjbMXxwPN6Xb52b4tEX1mdDHXrNYE7hpOJQ3vprC68PbB3fo0xufG4TCA3g48eLNmGSvgnmI/hkbbcRFQ=
X-Received: by 2002:a05:6808:bcd:b0:438:2907:2eb2 with SMTP id
 5614622812f47-43d6c24899emr1965364b6e.27.1758301461293; Fri, 19 Sep 2025
 10:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163147.4743-1-tiwai@suse.de> <20250919163147.4743-2-tiwai@suse.de>
In-Reply-To: <20250919163147.4743-2-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 19:04:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_qFs6D6pMfZT-NxgyDOOYYUzN=Ketw69C4BqsAG8_JQ@mail.gmail.com>
X-Gm-Features: AS18NWDj9nosWVkd3nd92OmaMdphOkBExCsiZSjzHaRETJjzO1RShkRvuC81Smg
Message-ID: <CAJZ5v0h_qFs6D6pMfZT-NxgyDOOYYUzN=Ketw69C4BqsAG8_JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM: runtime: Define class helpers for automatic PM
 runtime cleanup
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:32=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> From: "Rafael J. Wysocki" <rafael@kernel.org>
>
> This patch adds two CLASS macros for the easier use of the
> auto-cleanup feature to manage the runtime PM get/put pairs.
> With the CLASS macro, pm_runtime_put() (or *_autosuspend) is called
> automatically at its scope exit, so you can remove the explicit
> pm_runtime_put() call.

The part of the changelog below is actually really nice.

> Simply put, a code like below
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret < 0)
>                 return ret;
>         .....
>         pm_runtime_put(dev);
>         return 0;
>
> can be simplified with CLASS() like:
>
>         CLASS(pm_runtime_resume_and_get, pm)(dev);
>         if (IS_ERR(pm))
>                 return PTR_ERR(pm);
>         .....
>         return 0;
>
> (see pm_runtime_put() call is gone).
>
> When the original code calls pm_runtime_put_autosuspend(), use
> CLASS(pm_runtime_resume_and_get_auto) variant, instead.
> e.g. a code like:
>
>         ret =3D pm_runtime_resume_and_get(dev);
>         if (ret < 0)
>                 return ret;
>         .....
>         pm_runtime_put_autosuspend(dev);
>         return 0;
>
> will be like:
>
>         CLASS(pm_runtime_resume_and_get_auto, pm)(dev);
>         if (IS_ERR(pm))
>                 return PTR_ERR(pm);
>         .....
>         return 0;
>
> Note that there is no CLASS macro defined for pm_runtime_get_sync().
> With the auto-cleanup, we can unify both usages.
> You can use CLASS(pm_runtime_resume_and_get) but simply skip the error
> check; so a code like below:
>
>         pm_runtime_get_sync(dev);
>         .....
>         pm_runtime_put(dev);
>         return 0;
>
> will become like:
>
>         CLASS(pm_runtime_resume_and_get, pm)(dev);
>         .....
>         return 0;
>
> Link: https://lore.kernel.org/878qimv24u.wl-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

So I'm going to include it into the first patch and add a
Co-developed-by: tag for you to it.

I'll send a v2, but I'll wait some time in case someone else has any
comments.  Probably tomorrow.

