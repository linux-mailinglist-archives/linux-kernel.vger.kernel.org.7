Return-Path: <linux-kernel+bounces-875806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D55C19DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA33503B70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E54334C25;
	Wed, 29 Oct 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B90kQBey"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039892FD696
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734432; cv=none; b=FPbw9dEm8OnXj9BElvMiVjXdjteJvAIW2+DZINlFjK/Y4+n/S7kd0zoXkoc4jn1IytWMhbV6ffdd1TR8csu1nfIhATwn5cSN8SrhucDJ9ag4gBadnmQyBGcF9cgLLFD5xRW4EujBH96OttiKPr77P9sLxceo4rUDlDOhoO0tv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734432; c=relaxed/simple;
	bh=JfzAn9sSDc1qDJVZK96W+YHwxa+dh1iExC5K3+gvRks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxdHbcteaE5MW/qiBqN3JVlOVj2MB8qNdKvDUuRqWrp0CBzy94sWu3gXluZX6hzypnHPt9eCygI3abkw2CiC7ruyO+ncfH/nDqUxmGnAvwo7j7xpIXCtEStxR/hQAwt9A/b5nI2y4fG0QBwUybXELDcqCDTJdmkIRku58TrYmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B90kQBey; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so7757511e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761734429; x=1762339229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfzAn9sSDc1qDJVZK96W+YHwxa+dh1iExC5K3+gvRks=;
        b=B90kQBeyS+zPJg7F0wgBnAKs9GiRCuz9v6d9LDEJRe4R5Higmlzol9+w0+GhCnwYAD
         3z1uvjvNoJyoW7w0zkCurW+FQsSkqbSqpSDQykRlM0qUGTjYEYxUjqjAPluZfAYTINM5
         Sue4u6Fpdaz2EcwDf+QReYuTHbL+Uhjad+fqFYK1+/VwNGz5GeuIiHz35nFWQbDJCAis
         k501n11ZL9Gv/3DpuaLD5PfH9X9zF89GnMySJgUfVezpJl1I/FR23h8nPxzuSqDSSJzU
         MAPrP8v8RLJVGGhAWSSec1Pm+yIRWfCWSx4gt2hXVkmvNaF38Z+US6fc1rm+MOQXy9Pj
         Twzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734429; x=1762339229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfzAn9sSDc1qDJVZK96W+YHwxa+dh1iExC5K3+gvRks=;
        b=QbLB9KbBNwTLFBqfUna3z1wLfcfMXHS3Fe8w9knRbibLEdqAkmstJe06/+//T/BYOu
         PUAo7SYC4fH4AIem1slrlJVZVlXY4dcbq1kqIvl+Wia9p/Mr/ulkoomnJTx1p2zaA84u
         7r2kjZlb1VcSUUahpiyjc5LcVmIYlWHqT64NV0Op6r8I/AH+azmObHzeaqao/PqDV5OA
         vGulbeHArdobSXCc/5YZGG2f/rt+MzmjQayFWLrnV0iI7oCqBO1FsPrR5eyitRYX8+6T
         Vh2yDzrbqesUZXh7r05WBoPAUJsO3I0JzEfdd5XW/gi20i94UJZ3+eWoNSpFQO8abtUj
         76Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWH0lKqAdB+KaikNLZGFhiNYVzxcbNbjnSa1ZY4gHh8fKTqvNbsSVSyoD5pSvt1HeW0IXr5hD9HjQ+z9h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCmKqNri7x60W1usKLwRu1neZVv9iTJOVNpyzsLSexYBTWzG9
	TuXoJESMGq4T4E4RN266Tq7lMSsQqdCBYg2SDvOyWy3s6L30f+gBzkv5aD+HN61OuB78+Ren44p
	54FOyeFmE60LLIKo8KZk6MzeUVs474tfIRkLy6bxzYQ==
X-Gm-Gg: ASbGncsNmt0Pt9Fb3R9t1O3SQ5QjPTdblds2+8OHruTr1v6wZWSg+tEP9g1WWM0Zx34
	I38+Qk5CWq3UXfas8McFv7wFiQr0EKv8tCvovdZF/LK+UdC4+JzUIPi3dnftK2prU3LwfrBJmoE
	ZUYByWUakFwysUUEeztNM2+gw8ygZYSmUXM91QZ9mgDBT8tb4up5cgm20qNarEgSUGKqpPF3z3l
	626p7Y0Tie4qp3UDNUatcO9WbziqsfFBLmLvdQ+VrRSUKYwYlE65Bbgd/t1Xw+GpDsE3XPSCrrO
	RuVFyudwmMJi13b8
X-Google-Smtp-Source: AGHT+IHyDLW+hth4EaXe4cLca2vPqJJ5c/R4HYjWQC56YL1rSNqEk6nZ5SgVyrFqOZiGu1SitPQa0Ycy0KVVQyOFy1w=
X-Received: by 2002:a05:6512:a82:b0:592:fad3:9d02 with SMTP id
 2adb3069b0e04-5941287142bmr760380e87.22.1761734428954; Wed, 29 Oct 2025
 03:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029062050.4160517-1-raag.jadav@intel.com> <20251029062050.4160517-3-raag.jadav@intel.com>
In-Reply-To: <20251029062050.4160517-3-raag.jadav@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 11:40:17 +0100
X-Gm-Features: AWmQ_bnr-3SjGf9coBjCZmyQe_Yu7Q0DUNbpdgrzhPxUmo6g2IaZATu8NPPB_bA
Message-ID: <CAMRc=Mcz3df6KUx6q5MLGfB06jQhBTGfhCM7yovHBE3k1vn+nQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: elkhartlake: Convert to auxiliary driver
To: Raag Jadav <raag.jadav@intel.com>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, 
	platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 7:21=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> Since PCI device should not be abusing platform device, MFD parent to
> platform child path is no longer being pursued for this driver. Convert
> it to auxiliary driver, which will be used by EHL PSE auxiliary device.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---

Are there build-time dependencies between this and patch 1/2?

Bart

