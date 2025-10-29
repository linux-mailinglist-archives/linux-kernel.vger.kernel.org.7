Return-Path: <linux-kernel+bounces-876181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B81BC1ACB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B210B1881530
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9782E62B9;
	Wed, 29 Oct 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfwd39Cw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E82DA75B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744462; cv=none; b=SahLtF8BWWiO0rOk2mWlJ+TtP6t/hlwQyFBxginMubYXpvfGLWHKTPhPc2u0v3xuiR9K1syvt1iMHOKC/AHgz/oXGUR3dEXtZ73uQd3G6wUF51MSnwl/agMAjaqSjplZw4iHP73cdtwYBSBpWJ4bwFQN3sAxK5V4zcnTaYQHPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744462; c=relaxed/simple;
	bh=4jQlm4QL0G/HlPu6AaqVyYXrKj03YxyBn06mrBxHybg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcFsSpQXr+uRsAI0sgUrOKq7N+GxT7dr56w80kbSJwZTQKH44RPHhmoFdq/Zg1a+xsNArzII7+h8Uo/YWJNy30EQFLIsr18nEipIvk2bpLxZ28iwM7Sgdr6m7ofkmPhnHhYagSpqNbKqboF1twBd9pcQJfquCiWPLgQ6hP/Ba3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfwd39Cw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592f22b1e49so6614654e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761744459; x=1762349259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jQlm4QL0G/HlPu6AaqVyYXrKj03YxyBn06mrBxHybg=;
        b=zfwd39CwqfnA3m/tPDkDdoBU6TkYek2sWsR8NAlNhxIC7QNbq7wi6vgWLzylLiE3uB
         mk9E9tBXFxH5R7Xdl9SAdCxXK3PMbrcgakY2epD6frjbn9rtRcAQEUSoS9EDNhk/OjDj
         kNPoRSgNt9BJnpMNAOTz8raqmznKBu7DlDPDm25L6XveXjngUUIuBjVzUGQJW8/1eh60
         eHTH5jK9Qmkmz8+xyTQKaeovTtxhCQT2u4qLipjq3RsVPbpX7EvB4Ug+oJ/Z3fb/ccs5
         RKBe9KFJyb3aKGNUTXbggu1dslr7QkO+Zm0oZ1LVU6vv18tMs8P1HUjc11IOyzj9Gttn
         AoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744459; x=1762349259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jQlm4QL0G/HlPu6AaqVyYXrKj03YxyBn06mrBxHybg=;
        b=uii6KshUtF7iwiqLFWPXQFIghtiekXW1X0mYr9d/6k1juT+8ZrtZfUb2h5wr7rxuwm
         do3cPykSGNFNeuMB9IfLXW+dnbOYsPx9EzVCDmk3Q82xukABz9qp3jGcYjSPFU295+Jl
         fE+54kd/TDqmbKWQsqdwuutqFiRf3cIlmK27q2zHLiZ4fETtaQ1XlZ6o//LOjNyFdcnQ
         ceGtLJBAukM+HUVaY2ZLGEMrPioSKOFd8sNA+25PbSldwhl/j7UcfQa65HffDM7N0tIp
         KCb77bqZSDSnalTPJqXGJQclfea8Ms2LrC9IRVpN9RzVxFWti/iKlsoNaWSfEk7YSHlb
         UboA==
X-Forwarded-Encrypted: i=1; AJvYcCVkdhW+MMIkFKjrbWpkf4r2hlUFlcs2ZZm03yMXqCDpBZ2XOcxAqLuXCTyeibJpcZsGapbUYJEiLYBFO2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9OCLmhLibWQhGng6O09W94+LCalG19hWiIJ/OSFvc8xTTUTw
	OGGeOajoa9nQf7mMdtuxbs+PHk3selWAAyiJvfqkjMK/NwuWjbDdlFm0IxEhzB4h/zMLQHMxhqf
	ndEylGNCE01eltAntSIGhRRES5N5N9KTnModxuJPFzw==
X-Gm-Gg: ASbGnctFazmBIy6Vw1XvVGh8Ys6B1pu+takbySK9/+Ylvfjj+qC+i179uER7FEph/AO
	biZmipAsomQxKiZoq0Re5Wy9VW5TwRDqx+U0tq3hAQMn+3fhAyfwH7+VPtqu48nyh8CGg8XAFor
	9PzQZmcLaWQzFnZ3MmA3xkVWwFCGTqdVt8IBExgcgZLMNeqoKW+cNXZSApLEg4i1GDj6fhv9oSp
	NFi1yARJiaezQewGDF+PKUFGDwwODS3Jghh5ZHMZtfH8mgp+Quzu3TUDux72eKm5GBttf4=
X-Google-Smtp-Source: AGHT+IHNfCne47Z1eBbRQa58ZTteY04bLS9xhtCisnJoPUShci5UwjCrSgpL8aWwPI1wivqZluOA5wXGysoEwwSDBuM=
X-Received: by 2002:a05:6512:2284:b0:594:155a:a055 with SMTP id
 2adb3069b0e04-594155aa157mr499507e87.43.1761744459075; Wed, 29 Oct 2025
 06:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029091138.7995-1-brgl@bgdev.pl>
In-Reply-To: <20251029091138.7995-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 14:27:27 +0100
X-Gm-Features: AWmQ_bkhP4GKHMHamZ9_Sw4YqnmBMd1h4uFCvo1UTXA6q8F0rg4J5dsGaF40x6o
Message-ID: <CACRpkdYxe9A_xtA62zH=7LOKURQZ+vmObhLidzEn4FvYav2CcQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mm-lantiq: update kernel docs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:11=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Update kernel docs which are now outdated following the conversion to
> using the modern GPIO provider API.
>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Fixes: 8d0d46da40c8 ("gpio: mm-lantiq: Drop legacy-of-mm-gpiochip.h heade=
r from GPIO driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510290348.IpSNHCxr-lkp@i=
ntel.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

