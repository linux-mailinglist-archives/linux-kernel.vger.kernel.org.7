Return-Path: <linux-kernel+bounces-868249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB968C04B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95EDE4FFE94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407F2DE703;
	Fri, 24 Oct 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="do0n/H+0"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC22C15B6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290455; cv=none; b=hcYfGI3SfRoWguE51tU70VHrNg0l635OFVMmdOhkem6BbeI29RLQR4DawoqKzt96WhgMx/pvp2f0siM0GODbaZg6amilqOcTJP1gzH3/gcZWAY3BpVeipmcV9XqH1sbVRnjWR2PyOu5yY9D6n4I97+EKWbp69udatNcDeGdBa/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290455; c=relaxed/simple;
	bh=CR+8roHK+/LDuQ73yW6ockKv+8Mv8IDa0Xrtz7eQhq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDlwFqbEc/wH89ns0gZ3zK7QOI1wBdkcj/RD5MOPQZeLYQ9PAYnRal1v5AGLIiGxfP2naM/lqCDFCWGdwFtbTTeE39+41/JSSbnyzA+scj818QaGSF1kdfIQpOKp2hdxxZayWGZCQr7bAwJELhGjHm4iQnI2+sYEQLDfSNDXNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=do0n/H+0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592fb80c2faso787392e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761290451; x=1761895251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR+8roHK+/LDuQ73yW6ockKv+8Mv8IDa0Xrtz7eQhq0=;
        b=do0n/H+0YBdSMkTq7sBSXWn2/iExuSH4K0sIPxL9iTSfguBIyMA23Lt0sQVhm0PSy0
         0xOcYCLnv24GEMyEVQXR6ARjMO7Mu8VwfZzGGYTd2CkQ7DgrYJBnTyT8tXGIFBZcd+2z
         /7Aupadl9J7Add8zraBmNJfaTmayqpTtIQYwASfQ+2z9NaRvc8O2BOMxiTcgGNNatDjn
         aTy/UOiUjqg1hTXOt2qLk0r2MeMWkvJxIiPlV9sv20AD3ZIonIu05vFTjISc4bFpTg6o
         fjK97f4HJYjgLkswp9aaoSnhY2zJs1fHeFRj/b/czuWD1FFNJTn+X9mHV6UEvyS/RjPm
         4qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290451; x=1761895251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR+8roHK+/LDuQ73yW6ockKv+8Mv8IDa0Xrtz7eQhq0=;
        b=Dhp+UfHYFe6rNv7cXYTHa+I3i7kq8dJ1nkN1YfCgbXbQ7P/fJMHG7CbjpHTc819mJ/
         5E84X2T9xRhJKY/M7n1mh/dkux15THKqJrL2573oYuXnrcOPXqS0vpjTgYnFXqbawqie
         9EBZ1Qgbh92Px/1jTYGkHEYCby4Wei0CvUCshNSMwoq+JQfHyA2WMI23OB+fL5C9jEPF
         6FuiZ+/Bpadje2IMr3RjrKi1RFHBt/OZB/C6+pzNslvaTLd4jAhrHnaKecbUNkfywi3H
         XpQ94udzR5l2Z7GYHBN0UXTz3UNTr+ckuu0o0i235z3KWg0YmWOS+NqhtfHwBi5+l1Mh
         AP/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9VArBaKILGNkdWpaXIu5emDV0Bt+mP7RtukMhpL29rAXIdauqK01b4lTArgS+0dAXlRnFPmRsMYAp3eE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Wx9IPgI3/FZ0R4BbPmv2xJuksBY/r0KIQhCKEi865PqkJrtT
	2SG0j1cQ3o39CApgPG3E9ASZvko1k4H7CpUUOux5jyiWjPK7Jhdw9Ic5judDrhifgIREPZo7oZ+
	wGCcPR9iZd2YJkuatpSGhqT/ZJunj0pyCG/8kJlJsRg==
X-Gm-Gg: ASbGncspVo7gtncf6Ny/aVoQcVLsKlAgM6FeZawxAwl+WlqKrPRtugXF6D8M6wPgYSO
	ZcF25vdRqhxDBcvAVdfilQ/Ly2nioeoJcTOJ9nFQt/M16/r0dIAnvgISdt8c+6nSW9M4TN7nljx
	8eHrN2oR0sw8W3OU9WQ/mLG5cmoN8aY0V6sQbB9yATpyTjwGRm/eHmSUl/QEjRT2k/PqJwZqBok
	3yXghS008sl6+z2cbTd88j0sPMhtR1/l7dV5/CsiJ64mI6BvLRiPxt4H9pYDM6LJfYB8pzxVTii
	AJyxIhqeshVARf77iZzJ0MRK9g==
X-Google-Smtp-Source: AGHT+IH0zdKNAnAn0HY8zeCAL8aa1oecPklr3WTZJPyPQRrZZ9JAeaLToU97/5gWoSWPOCpiqMgKR7gX6TBItcaDYYE=
X-Received: by 2002:a05:6512:220e:b0:592:f5f9:f5a9 with SMTP id
 2adb3069b0e04-592f5f9f709mr1849794e87.36.1761290451029; Fri, 24 Oct 2025
 00:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org> <db05003c-8ac5-49da-b0ce-e0b668f49caf@linux.intel.com>
In-Reply-To: <db05003c-8ac5-49da-b0ce-e0b668f49caf@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:20:39 +0200
X-Gm-Features: AS18NWBFHHtshqZfLTmGnpCECipG6SuC-vURJ7Hpik3InZgpuKVx4aYTO-AzQUA
Message-ID: <CAMRc=MdWjyTyJh5zfE5qncO8ABn7QSuV1CUZXa+cSMjWoXUrNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] gpio: improve support for shared GPIOs
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:17=E2=80=AFAM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
>
>
> On 22/10/2025 16:10, Bartosz Golaszewski wrote:
> > Problem statement: GPIOs are implemented as a strictly exclusive
> > resource in the kernel but there are lots of platforms on which single
> > pin is shared by multiple devices which don't communicate so need some
> > way of properly sharing access to a GPIO. What we have now is the
> > GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> > doesn't do any locking or arbitration of access - it literally just han=
d
> > the same GPIO descriptor to all interested users.
>
> I had few stabs on this in the past, all got somehow derailed, one
> example was:
> https://lkml.org/lkml/2019/10/30/311
>

The main issue I see with this approach is adding an actual device
node for the shared GPIO which is now not accepted in DT bindings. We
only create nodes for actual HW components. All the information is
already in the device-tree, we just need to scan it which is what I'm
trying to do here.

Bartosz

