Return-Path: <linux-kernel+bounces-813360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63CB5441F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756BE448416
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6D2BE646;
	Fri, 12 Sep 2025 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ou01/gYm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD495267F58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663134; cv=none; b=GRg0HYMM7mpzycK6n4SrlWlz/kF73ekMJNSj4GK6SvOmOfwM6mS0urhCENuqIf1M9Fcu9N9TSMvFwJYzEyZO+IdTj0CZUbnEjIVGygGHhIDYq0CMW72CJqT0CBlwvD6Eyacck7NNTdctowdMAuzFCk9Fuha+8m2Bh6Efe2L72as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663134; c=relaxed/simple;
	bh=6FZzZpXKOXHzhJ2wnkOGqaqwmyZ8ymDmUm9n/R7xppU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/y2Apv07JDbLKOzhDh77rCNcs2jQZw2INVGe9IurTpaMYPQTmvJAoD/V8Yf9/XGODLnmfMrMphDar54p2JsOSYt2+HUpYLTMK18hiFZXERBjz0FvF5/m5hOv/01urM8oHMUdzQST9XKwVwn8KHCcbYtK5TSpzzeEE7GDiJLITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ou01/gYm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336b88c5362so15277311fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757663131; x=1758267931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FZzZpXKOXHzhJ2wnkOGqaqwmyZ8ymDmUm9n/R7xppU=;
        b=ou01/gYmHWzmRqiHYqhf+HrV5cImsTJB6CuCDvjdCPRBFGWdlWsyYwKoFUiacRx5qP
         gnepZNDoq9grfoKdcfF934UjQu9o/nAC/SPg/NeCpQAD5nYiHbSbZ5co3xX62Y8Y/2nD
         RJJbFB13Ik4LFgjmE4UJYoaRxcRC7UFpfi4WgIckO62d1R66WiwlFEslMmub9jXojb+6
         XzLhbXC2ESDJwnQNom5cbdfCw8S9lEWv0KLnEKK32FCjTgi1zJ/y1/9JNly5UBxLNqZV
         PP8lb4Tzp1hWXoKXvjVu7l5Kv0pWdc0qZEx3sZ/zioQbOI0/Km9adp4KuwXATiJ05hWb
         9Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663131; x=1758267931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FZzZpXKOXHzhJ2wnkOGqaqwmyZ8ymDmUm9n/R7xppU=;
        b=HoFdOEyY00eYGpl+0tjxM0l9T3kK6ZDQRveCgkXYlyYpmlZycU9xBs8M8Pc3fG80RJ
         F5cwu0w478TPN7A5SVqKkR8/cgnvtDYLWQnk7n5fCFLi6a/UEb/+KJWm5HZHsI9g+JVM
         3jihcBh835pNcDAsmiEVE/Qlgjb4vWzXqpP22NGLcXf1shDA7E38UyolpmU8J6I4AVOr
         1MVDrXHWT7RtlvYlCt7tzEISY7ywfQbqphlyH9o00+h1eKPwpKSCrhCGyR1It2O67Jkq
         47afj+gXKoroHFECSc/P6ha3cDiou7XY3l3UtpgHKJnNiw1+9GnCKgVMo7k95Rxnf09d
         3uDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6vv5hqQftOcFdoxVbIQfeLMmmNk3Kh5rEwXUm8ZWc6YULUoum6RK7b7lJ1GOzLtB/psD0MMvSbiA9x/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41xtDiSI21+Noyk5wdGjSbodoLnbJq4+5p7P9AMr5zQGqeqyF
	R8B8hmLdfq8Mb5haMs1j8LLd/r4yDLWAGVaQ0f970IetMz2xp+2iD/2xukqiEhqUZtOaekeUl+7
	uvlxfGRyLzkkPTFU8ePS7RLMmWnvwvLGi9geYg5HXpA==
X-Gm-Gg: ASbGncuh/NYF4PpwBaz7LRACtnJ6ieSlTAmoXTFvUaXCmjoBkjnKH7PYk6uUfKUPZrp
	no0n3pOTj3/8LKSF15LuKEEtcS6lSz9gLemVQMqk6Pd026wC6hgo0LontvyeBQh7zSzwTONJBTb
	TbSqPYRdsL+PNlytVVly+uEL1zSM8O30D5LtH6MjseCHxCcOa9xJHRPoLkHxalcYV1F2ewdZ3w/
	ji6BbI=
X-Google-Smtp-Source: AGHT+IHlmRAHKqSdot79mnaN0SJhfcVcwXH1gxvx+jUHEDO9IZALMIrMYqfVCaNGxNsDXGYCgXZm+lDZA6bq0RfiLP8=
X-Received: by 2002:a05:651c:2359:20b0:336:c290:b321 with SMTP id
 38308e7fff4ca-3513a8f1a35mr3890011fa.13.1757663130915; Fri, 12 Sep 2025
 00:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912060650.2180691-1-gary.yang@cixtech.com>
In-Reply-To: <20250912060650.2180691-1-gary.yang@cixtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Sep 2025 09:45:19 +0200
X-Gm-Features: Ac12FXzUbHER-mkVUjmDr0R7CXpg398gO_vKvZUgNOQ1exRFoKJFGV6d7epl9gM
Message-ID: <CACRpkdbsJ75Th5=K65_teYXv34ECB9yx7hWeHG4QBao3wbCDvA@mail.gmail.com>
Subject: Re: [v2 0/3] Add pinctrl support for sky1
To: Gary Yang <gary.yang@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	cix-kernel-upstream@cixtech.com, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

On Fri, Sep 12, 2025 at 8:06=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:

> Patch 1: add Cix pinctrl driver to support pinmux and pinconfigs
> Patch 2: add Cix pinctrl nodes and header file
> Patch 3: add yaml doc
>
> Changes for v2:
> - restructure the pinctrl driver to support pinmux=3D<..>
> - redefine pinmux macros
> - move header file from dt-bindings to dts
> - fix the code-style issues

If you want help for managing the different revisions of a patch series,
you can use the "b4" tool, here is a tutorial:

https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-=
1

[Konstantin: the doc link on the bottom of the article is wrong
and needs to be augmented to point to latest!]

It's a bit tricky to switch to v3 since you already started without it,
but it can be done with

b4 prep --force-revision 3
(see full docs https://b4.docs.kernel.org/en/latest/ )


Yours,
Linus Walleij

