Return-Path: <linux-kernel+bounces-887345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CABFC37F34
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 477F34F8EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0B190664;
	Wed,  5 Nov 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfNpKQuK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8D2BD5A7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377203; cv=none; b=FTo8p2NLRsuN5sVNPz0MVAHEFdvI22GLxExZhQFceYdH1NbCcAmtGyJcdMLs2hKjqGs6wFczGZZfTYEmI4PQdvMySjXMqtfdK4/J0kmjUoJgIG694kl5M9kJp4hqGmfJu7WRzbq7Pe6ZbG0wlC3HbH1lLBRAyS0WWFKGEjvy7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377203; c=relaxed/simple;
	bh=TtPX5wAsf31XsioAbGBoBPNIeRFsDJtRy/KczWb+LAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5L9HxcttXWgkrqbQMhM3N0l99fLABFhDQSUMbwzvC/iVKizJPivsxhDjGzbpR5vP6AzMZg7kxhxAaNNK/9EVPt4a2IkBqH0rw+r1GVfOzgvUqhX5NSJfboH6xOnjSIrWdUa+P4GSNrV9cXQRnXdGENR707G90o56wA9VQMgKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfNpKQuK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555b384acso2715165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377201; x=1762982001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYl4uAcPw2YN0ysy9XChF1hzlRCusGR8JO4Ns1lam1E=;
        b=YfNpKQuKJ/mEIJ7k9RyfYts2N60S1QVyJxwoOXNvlWVxiFprvAr1nuLEZof7rcfcry
         vj1eRFmcN72OMYiHk47+4r7zlmTkGXLhjNruD8o2nmmgZWs+6rUlZcV0tuZg2+sCbWIw
         Ft1BecP9VVJIATk2OW+jfWKu2IEYVoZdcJvVIptAPU0Oo71JZwZj4wA9cX/kIbZBkBab
         8Vc/j2uPgZWLHDDx+yCQMllejWcsi7iOJHYfnh5IgTBB+8fAQuX7ZnFIGDv5iMAHAoOi
         9ClJLvzoSSdMYb6j6O1YbeB4DEMvHGRfD7vORjhk1GI/joX31Wq2xz/kxUVbN9DkzBmr
         k7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377201; x=1762982001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYl4uAcPw2YN0ysy9XChF1hzlRCusGR8JO4Ns1lam1E=;
        b=KZLZDj4ZtUV+/p2VjATyAb91e/+71qxo94boN33+5DFdJJAUpdVR+KaYwJ5Qb2kvTn
         rGKaOy4z1fsghrvP3jGWsjArqcf+ojo3q2Igwelc5lLTk1bih4NSFBkZnHWHR2T+q2tr
         nhx/UmzPresVHxRhkXE1qws/IMNBaFWqPqIM1K5c7ku04mHLCGi29bibb6IoUXiL+aZW
         OPHmmt98FLRbVOtR81NP93P8pMMGnr4CN9wZ0tIGKuYXJvhTSZvENgfIIbYdopLCgByx
         JwLURXQ9LiF0FhjM+HNmmBSJ7fiFQLH4luDCzLB36NxjlAn7Py8ahC5MBGsYkrI2XqOc
         jCZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTYw9YitUuvMFr/G1XFVes7AWOq1/V7X2t330RWgfO10bUnbOuNtoX5Qmj3QEY3fiGY34na5mUnEB2xgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9OkTSKfaOLaMs5F53JzoicnODIL9pz9KUa5KKYlB0SUDCpyB
	dPHwKBjfxqYMO1kxgMxdPHnByRO03FnHeBaI2wcG8Xaa3pMGIePkBxl9c3ofNguKloy8xMJzGDL
	s2dX4h87ozQoNLm9fXHqYGoHDow8tf70=
X-Gm-Gg: ASbGnctYhy8hwJRmdJuoFnlQH2lujoqwtwAW+wdzgasPuJ9l/JO8kzt/uohscgW35kI
	0vU7jeB6XLuJVDKYUF7SYtqUS1XzQJnZbK8lSCj1eyEFT2GFDsbkGnFz+CS+C8X3IxotkH59DPM
	RTgfdulg3czDXOs6TLpyG5i9ElI/cyv8tsXKy4bIvIao2K0LtZ+bc8TGY2ccg45Slsh/pNC5AJ9
	Kntx1WIWoD6YqQaRKn9hHJUjYE6McLhptdO/lPTT2S0LP1qKaRsmsUqimqgTV9B3YI9B6dD9D9R
	jevYgO5H35sRGx2LvTRxI0FafBmDMe4TVyk=
X-Google-Smtp-Source: AGHT+IHJuaCbV8Dvr3w5WGu51Kk+xXfCjwSmuvKRdYVaKJf7OUcW5sfriYB+7HI9rK4/5a+tYVgAbKZ5vZmFdHN1rt8=
X-Received: by 2002:a17:902:e889:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2962adcfdd4mr62180385ad.44.1762377200682; Wed, 05 Nov 2025
 13:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105143851.4251-1-gautham.shenoy@amd.com>
In-Reply-To: <20251105143851.4251-1-gautham.shenoy@amd.com>
From: Chris H <chris.harris79@gmail.com>
Date: Wed, 5 Nov 2025 13:13:08 -0800
X-Gm-Features: AWmQ_bk9z1xb3CgvzyDGOVjF_ZRV-xAXTvxsOcf3VIYYEJ6ctGNF7I9zc6gJMjo
Message-ID: <CAM+eXpe1j5=PW9AuJCJQWat=ivwViU45y0ortdiav-kX=2Hs+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: CPPC: Fixes to limit actions to online CPUs
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Confirming: I've tested the first two patches in the series on kernel
v6.17.  The patches successfully resolve the issue described, allowing
one to boot with amd-pstate + nosmt=3Dforce.  In other words: receive
the expected amd-pstate scaling driver when SMT logical cores are
disabled.

ACPI: CPPC: Detect preferred core availability on online CPUs
ACPI: CPPC: Check _CPC validity for only the online CPUs

Thank you Mario and Gautham for addressing this so quickly.

Chris Harris

On Wed, Nov 5, 2025 at 6:39=E2=80=AFAM Gautham R. Shenoy <gautham.shenoy@am=
d.com> wrote:
>
> Hello,
>
> Christopher Harris reported a regression between v6.10 to v6.11 that
> the amd-pstate driver failed to load even when the commandline had
> "amd_pstate=3Dpassive"
> (https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d=
0k2_C4Cw@mail.gmail.com/)
>
> On debugging the issue it was observed that when the commandline
> contains "nosmt=3Dforce", the CPPC code fails when performing certain
> checks such as checking for the presence of preferred cores and
> validity of the _CPC object since it iterates through all "present"
> CPUs while the object state was populated only for "online" CPUs.
>
> This patchset contains fixes to address this issue.
>
> The first two patches in the series address the issue reported by
> Chris.
>
> Patches 3 and 4 harden the code in a couple of more functions which
> iterated through the present CPUs when it is more apt to restrict the
> operations to online CPUs
>
>
>
> Gautham R. Shenoy (4):
>   ACPI: CPPC: Detect preferred core availability on online CPUs
>   ACPI: CPPC: Check _CPC validity for only the online CPUs
>   ACPI: CPPC: Perform fast check switch only for online CPUs
>   ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
>
>  arch/x86/kernel/acpi/cppc.c | 2 +-
>  drivers/acpi/cppc_acpi.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.34.1
>

