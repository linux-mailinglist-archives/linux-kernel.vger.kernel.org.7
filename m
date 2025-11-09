Return-Path: <linux-kernel+bounces-891796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2BC4384D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 05:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646833AFE42
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 04:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285602144CF;
	Sun,  9 Nov 2025 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+xddn9q"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9E1E9B3F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762661094; cv=none; b=AHfSVMC/RlIpDc2iYLh+zlo9MRhN755gvjrI4+/AsGE+Zla5yexSpQXN7zljKAPx+hEmWyHk65mN8geLMq57XC49m4U+wUF3lr1CPd4SbpNAHMlmZs0neJ+IaoYBdtPvRh/nUtM5aXmMXYmXeFKEwVrrwHyBLVgQ0EYYV43qfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762661094; c=relaxed/simple;
	bh=vy7e0Uz1+HoY2uFB4YSEuZK75o24i9fXUAPPGgAPgzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ovc+lcs7oXPQPnM56xI/9fNfJXsvg4VHipvuMt69IrU6dywtpQnFRQlciCelN5aVQGzGMrbl0o7iD/D58UbYYFCnuWMYfoXXcbSbHsQH70RTsFT7jl1AcSukdkI8v4kkp6ieBFICPhxW4L6v9iFMB/OnoysRYdnfAt1rFyk+p7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+xddn9q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so1654372a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 20:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762661092; x=1763265892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv9xrZ2yv0nmyGUfiS3/1XZ0Dl71alHT6BglkhqZupw=;
        b=R+xddn9qEX31BHz7cYv01PqV8p25v0QuFsKYxA0C/IQm1XwW7VYxjTb7UlZbTDq3OJ
         jQfTPnjxez/77WZHDQa5r1B1qNsKIOGCwWDevipLCgh17SJ7hYkDK3LtMgjMx+Nv4dPm
         1dXPGRRe2GD+ttMo6PaOcurqjk4tWG6F5sma5iYgFoWTRKf4/mu9WP3mH9YqUCyaJ3ch
         CuxcuUldhHqzd74+mzyODlhoXrm4q3OjvabdigHJj87ILWZckp5/9Vx3CEjSffef2324
         LOAY80tC8ICiyC0GxI3gxlOuBq4VdaFAppeLmKC6gmOMqNGO31DUOF+cPzk8jJ4JqJvq
         Cu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762661092; x=1763265892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hv9xrZ2yv0nmyGUfiS3/1XZ0Dl71alHT6BglkhqZupw=;
        b=Rsa8pELkbWhkUA7lPwogl4CnnaqqiV/9/YeeVMYDOSBr9FiLmtxXYQhLiprjgs8K8w
         V146RI3DEJM6cBz6KXVUgcePd8tzVrEFdNLaxlpwWJT/lEFC1K2pAkudd+ODNqkJpcl+
         8dkdTzciBVVfD1F6Ru1PiTFtHJthC2P1qBFguDkiaj8qFOY7tVaTBiOiwZQ1s6GRk2bl
         bM96DzbqBG0eez9rsvhIwo0KenKszVWYbB410ZbS7uz0QZyfvw3wzc5FLALI3BM5IkuX
         BqOULjdZvm60fToRTEAM5S7GS2jFfiIIZhWzC1VqRI7Mq0VllFboYho9D2X6a0dbGz7E
         kxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO7hNiCnSUSGYC3DSsArjAAAI+Ba+uOa04vgYi+gGhuGux6JZkLapOv4AAZV0kPJPpYQPG5aOeKJSomhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyavzsGfOwYrdkrR1ZlVc0RY7KZUQktJ/Wtp3x+pLfSnuvyFLHW
	z0RU3oC4Ov3V1I+uVeV7OuG52shvz3QOmk32/C6142n/YK7aGawcxtYkZTNfYUY35tp6vlJQ6bp
	otTmwosJ5CVdeYixmQtRZce5FxFoS3eI=
X-Gm-Gg: ASbGnct8VG0RKrFBW5foUYvYuYRboACtrmsOFRqTT5lLiccR6f82Z2YT41l5uroRFeO
	c3jIiX2soHG5PYYivVpl1wkcyg0277Vu1H6zK2UnlnfkhTymGDP+6Pa7R8Rsd9xFVLiyIpt5X6F
	emCRhcx3nSELYhjHbLbANNJRobF9FONIcTFZvVmeHroA4mWunizFOQSXkeqBJ76AC52M44Hv/ZE
	Ji2dLHMZGLPm78pcZzpWY5Q8HKP7jzaAhGZhZeNft8Ve/Ld24elB0+3cm+lVHzTQdXG0UYJs1zu
	T4s08nn/jWKmbF4zJYpCTA5SmumaraHmTO5/jqNI6Hpf4uAvsGqrl4HU
X-Google-Smtp-Source: AGHT+IEcGZVVTcMhYTPoqkW+BIztOhsUvcA0pcYzLEUPTNs1B9rap7L/jCYqurq1olrU2M+Ac1pBzPS7A+rk7X+tkU4=
X-Received: by 2002:a17:902:ec8d:b0:295:586d:677f with SMTP id
 d9443c01a7336-297e540d259mr55218165ad.10.1762661092036; Sat, 08 Nov 2025
 20:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107074145.2340-1-gautham.shenoy@amd.com> <CAJZ5v0jS_uNRz=3ZQQLsChf2V3UUvhf6BZ+MBL0WMv+rcW4H6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jS_uNRz=3ZQQLsChf2V3UUvhf6BZ+MBL0WMv+rcW4H6w@mail.gmail.com>
From: Chris Harris <chris.harris79@gmail.com>
Date: Sat, 8 Nov 2025 20:04:40 -0800
X-Gm-Features: AWmQ_bl5lUahx-ddHLXQbQC5JBoYj958vCD7_rQlbtTof8rtQnJKJu5Jt7SEWN4
Message-ID: <CAM+eXpe1inRG9Rbb7y=tGOWrKrQ0nnXut09MEtXwwV35Zc-tCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] CPPC/amd-pstate: Fixes to limit actions to online CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Len Brown <lenb@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Jeremy Linton <jeremy.linton@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I've tested all five v2 patches and have observed no issues in the
use case the bug report was based upon.  I continue to successfully
receive the desired amd-pstate scaling driver when 'nosmt=3Dforce' and
'amd_pstate=3Dpassive' are set.  I've not tested other cases/scenarios
for which the additional hardening/patches may have been intended.

Thank you again for the rapid efforts that went into this solution.

Chris Harris

On Fri, Nov 7, 2025 at 9:41=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi,
>
> On Fri, Nov 7, 2025 at 8:42=E2=80=AFAM Gautham R. Shenoy <gautham.shenoy@=
amd.com> wrote:
> >
> > Hello,
> >
> > This is the v2 of the patchset to restrict certain actions to only
> > online CPUs instead of present CPUs.
> >
> > The v1 of this patchset can be found here:
> > https://lore.kernel.org/lkml/20251105143851.4251-1-gautham.shenoy@amd.c=
om/
> >
> > Changes between v1 --> v2:
> >
> >  * Picked up the Reviewed-by tags from Mario for the first four
> >    patches
> >
> >  * Picked up the Tested-by tags from Chris for the first two patches
> >
> >  * Added a fifth patch to fix calling of cppc_set_auto_sel() for only
> >    online CPUs in the amd-pstate driver code (Mario)
> >
> >
> > Gautham R. Shenoy (5):
> >   ACPI: CPPC: Detect preferred core availability on online CPUs
> >   ACPI: CPPC: Check _CPC validity for only the online CPUs
> >   ACPI: CPPC: Perform fast check switch only for online CPUs
> >   ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
>
> The above 4 patches applied as 6.18-rc material.
>
> >   cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs
>
> And I'm leaving this one to Mario.
>
> Thanks!

