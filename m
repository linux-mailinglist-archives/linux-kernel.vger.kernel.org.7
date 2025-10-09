Return-Path: <linux-kernel+bounces-847234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E3BCA52C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EACC34ECDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A223B61A;
	Thu,  9 Oct 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bNg0lRi+"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212722B584
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029538; cv=none; b=tMOekrBh0TO0aPUtOuiJayIaYok7d/6gLjU6vGn/Y5x+WLhAYBvc33R7YcY9cQV+vFjGSLGRckud2Heb/KQzgjzPkPH4Yr8aTidvqMva534eqRK1WAIC/F2e+J2Zd45LEd9/vdm6Xjs4/+umdrvkDs84PqHJy2QOS2xINKx9YUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029538; c=relaxed/simple;
	bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpzm9r1toDURf6seehDFiXIySi9YxZmvZ//41VnsvTkpI7CsJcagHuiRsUAaD24s3hUw+RmR8SNt3I7zilKnJGv0xteU1ykz5V5/owW9IMtC/bV107W2s3TB5190IUohTt5HI6Nsj2+I/ONQvoBo+ZZNfu00b9Z4vXglMm32HS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bNg0lRi+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-85d5cd6fe9fso104121685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760029536; x=1760634336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
        b=bNg0lRi++rFK10ae92hN4Q+tD9JKalVMgtXOuv5DxPVssEQDJepsowAy+hBIDI1Q3b
         d24YXKnoa9bgNi6emnzdPBZBOj1vfailzHg6agjIpzM3JJyndgZxPINWrJhnqbZ1vHoo
         gxyUdudesuVLETrCGKh8N7SQZnEDE9Fjqoqf5TwzYSV+jg5HRAv5OgbF1Vmfl2urNTiZ
         NAFBJeR7fREu/yildLKrb73j2o2cZA6vZamNc1MA1MdAC5A62yW3Ysh9wW1T9NzoUlK7
         S70a5Kwd5gImEZJvKQVKJgayqIJUTneVBJ9icQs2ulU1PZuMPH/eyMjPDjILTyKSI3TH
         spVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029536; x=1760634336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
        b=BrWkR5GHfbgWehuIyomtcZCowZHPhbvvTgLyMjx5DF3wxy+Vw11VYxsBzCh/lor/2o
         DCDVNNYAx2sRPuQ5mvvhQUI/X1od4FueV9vxiW3Zcnw7q2g3wKqSwpw3bvK1XFVHsSl3
         poHYSgeVy9z/OjBTSvLCCCwQd8/SxplMGQJURIE4a16NnoGmeiF8/yhy1PUZy9GqzRQp
         jeecDZSjXrmG0Mjv25w84YDaNgA+wQCVS+pi/S5tJTNlzWe4Ix50PaMfNOnt5347vgO+
         lpPW7Y7blTNN5BJ/KYtTldAWVfwZwwFMoLvNp4cjTdi2A97z/FlQ3tlPIf1C5ZwHURvy
         I1HA==
X-Forwarded-Encrypted: i=1; AJvYcCUERYseAWN49iVyYK2/joYEkt4YJvVV5gsrYNf2I+1dwi4y0xSBf7VQR3L8Qr0Q23baU1hWKhQbDqeiDos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6zvsb8OcJAiUuJ/ErRbc6CYKcQ1g06QaHztdtMekHEmOZ6inq
	D/x5YglaDi7ypNTAkrEce0jAJVbrWLJYU/sMUnslzOOr4macJnn6TMRvHikh7F0YZxSpm6op7aU
	t7islPwQtTatMDLDe8TJyloxCGjKFgN7BVWi+XjC+4g==
X-Gm-Gg: ASbGncs/Ior7/RSvypTYaZA1m156eQHLGF+myQbP0fZKSeIWHpyHDSSYezsKCCPu1mr
	BQRHQGn21BplDq+rf3KtD93KEfpEsLQzab5dHDNRb3k6+Z+MWwCRDq92rYF9V9av23zSHbVrDLp
	jgEhGebQzq/yNbL9/a1+91U8wLJjfIf5wh1kb6KjcFKxsMfYqYRvQzpLrwELIGdlL0jwFpxjaC5
	/jSDasmwWbwjZT3Rx4kDcTiTQG5Xth/+dJI+b8=
X-Google-Smtp-Source: AGHT+IFE2sAReF4JI9gkbOEBI0GExAG6O+9H49nxZIOW3wiMfCJHnma5AW+apR4GDzx7KvuzWvZY/WusdxfEgE8+CuY=
X-Received: by 2002:a05:620a:2952:b0:870:ab:42f2 with SMTP id
 af79cd13be357-8835384546cmr1185682885a.24.1760029535702; Thu, 09 Oct 2025
 10:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com> <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org> <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
 <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
In-Reply-To: <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 13:04:57 -0400
X-Gm-Features: AS18NWB7Cr_VpUIKYZatXQYpiNUtQ7J6s9XvqZtMcyHaQrrY3c7p0E8zT1F9p7k
Message-ID: <CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 11:35=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2025/10/9 5:01, Pasha Tatashin =E5=86=99=E9=81=93:
> >>> Because the window of kernel live update is short, it is difficult to=
 statistics
> >>> how many times the kernel is live updated.
> >>>
> >>> Is it possible to add a variable to statistics the times that the ker=
nel is live
> >>> updated?
> >> The kernel doesn't do the live update on its own. The process is drive=
n
> >> and sequenced by userspace. So if you want to keep statistics, you
> >> should do it from your userspace (luod maybe?). I don't see any need f=
or
> >> this in the kernel.
> >>
> > One use case I can think of is including information in kdump or the
> > backtrace warning/panic messages about how many times this machine has
> > been live-updated. In the past, I've seen bugs (related to memory
> > corruption) that occurred only after several kexecs, not on the first
> > one. With live updates, especially while the code is being stabilized,
> > I imagine we might have a similar situation. For that reason, it could
> > be useful to have a count in the dmesg logs showing how many times
> > this machine has been live-updated. While this information is also
> > available in userspace, it would be simpler for kernel developers
> > triaging these issues if everything were in one place.
> I=E2=80=99m considering this issue from a system security perspective. Af=
ter the
> kernel is automatically updated, user-space applications are usually
> unaware of the change. In one possible scenario, an attacker could
> replace the kernel with a compromised version, while user-space
> applications remain unaware of it =E2=80=94 which poses a potential secur=
ity risk.
>
> To mitigate this, it would be useful to expose the number of kernel
> updates through a sysfs interface, so that we can detect whether the
> kernel has been updated and then collect information about the new
> kernel to check for possible security issues.
>
> Of course, there are other ways to detect kernel updates =E2=80=94 for ex=
ample,
> by using ftrace to monitor functions involved in live kernel updates =E2=
=80=94
> but such approaches tend to have a higher performance overhead. In
> contrast, adding a simple update counter to track live kernel updates
> would provide similar monitoring capability with minimal overhead.

Would a print during boot, i.e. when we print that this kernel is live
updating, we could include the number, work for you? Otherwise, we
could export this number in a debugfs.

Pasha

