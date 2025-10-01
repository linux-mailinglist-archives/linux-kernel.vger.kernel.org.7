Return-Path: <linux-kernel+bounces-838516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA378BAF5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0260E7A2D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C318A93F;
	Wed,  1 Oct 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIJgm6gp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281017C77
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302928; cv=none; b=PSj7+HfGtJxlWv9FD4tdM3kKECxcmGUhTYrJ4RD1AzwFwOkJpQQcsmWMNW7AqNyIGz/VVsafNrnIhizN+p24rpyWOtfrF1fD9jjdaIhTOp9GKh2Hj4aDoPe96xvz2fXu/Nn/M61cDhmLte5xgPxDs9uRJR0uLz5D7KbyiyxYuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302928; c=relaxed/simple;
	bh=KLOUoFvpz3+9Daoni/vqhIeATvg32tx7vSxzv4KrSWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXLjqJZ27hQcDSYWoXw9GG2gwPbMaJ8ZJTYvCZsIk6ViG2cg7D3YOwGNpVgW+OSMHJrtJszpTEs8wOXcOLGJ7pjjjCp5U2uBjhINoJ92ka5K3DTS8WuSTBJ6T4HksInk5zie8CDfBnhYJ3SJWwBl4UcYumlUoV7sWwA+19DZXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIJgm6gp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57db15eeb11so8132583e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759302925; x=1759907725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLOUoFvpz3+9Daoni/vqhIeATvg32tx7vSxzv4KrSWY=;
        b=UIJgm6gpqR34LrvO/Dnj6u1em273Fm2u6GtLGUY8LhyHf1KS8uDKPhLqBOwpfwOyty
         ZA0GI3gBCxNltJ0BT3FQduz0l28HOB5UVptyO5oJ4bbf6DZB9a9SxkOuavPJ3+RCIpgQ
         Vll6meLlYM624OFqPCiqq/gGTiZKjxl253JGjjiCcYS8j3XrxgiUAQNFkokroqhReDHl
         XpxxkHxSI/xtCgkQYsooR4gdtWm5uBHNvD0cwzNM3YUEfmEPrc6S176Lob/zf5IaHdVY
         8NwO2xL/+oYA3+m3Yudp4mbHp/Jqf9ZOw96yQRpq37I0+TlCe6fe3NHhpexVrB1H/3v+
         57jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302925; x=1759907725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLOUoFvpz3+9Daoni/vqhIeATvg32tx7vSxzv4KrSWY=;
        b=X+3wsw7ppdAg8Xlz5ek51XdhpcILUOVLuRIjRaHaC2r7D2SODkK4OoVj+bE1V7nSU0
         8mYs5q6Hd42XCtZkOWSFH6BJ1/BLPGjgFNtRtNfzQfsztPh8g+s9JYdD+0sKdG9swgvi
         8lybk1OcfwiRF+FtACyw/dvuwt9mA0j8H5mVCX3DhkIZwm9JkMH6DA6+Y3ohx1WbLLvb
         pdL9jNxL3yfFyjKQ1zbfb3213sbsNBx3phbWpzjRop5mMPRen/T+ndBGRbGZa7HrdGLb
         Y5dVQUCSelYltlh4pfTBboNYkm0lvzSkSQP7oB8Rr2jnSxyzY/KmnkWL7yU+DQIJi8A2
         hE9Q==
X-Gm-Message-State: AOJu0YylFhQ2+XIXdUFFroV7sfQUNOQ7ejNMCK5EVRIjP7a7QHANgf5O
	0Qmh6T/wXsrZpiDMLVY++0q/awuqCuzTqLkgCMRJdiaKPJFhAhfcLyBbXX1nc0Jt7rlv6QgG0Y5
	wfnhuSGQVsXie/m53cWwp1wChabv9av3XTvQzl1aiJA==
X-Gm-Gg: ASbGnctTPX1ilv4ey5aFwMPDOj6IiIYEY5WOtPTJ3alXjtMfns70zst1f4cXjgqvrfJ
	tH0pXAWnzdDq766EH/XaLWKwnkmL/GPbAc8yRAEhTbjDGJ/2woLsqCMra+y/nzdv4LWnFEWRdJh
	eIiSN3s36z/v0VpeV4AWshgN8XcESwUhobw8s5gJ1D5nHIAE6LUu3AzNdnvEruXxDhirzJDRRAz
	LwXbRN0Q2CNSivPC+RvtEAy4KwLXNM=
X-Google-Smtp-Source: AGHT+IEnqFN8uRHySmhyFBckr+4qfapD0oIDbjAXJpBIKMb/6cpABxlfPjflIdUDyU81H5zIY7PLLDU9mAVEsotGkaw=
X-Received: by 2002:a05:6512:1319:b0:560:8b86:75ba with SMTP id
 2adb3069b0e04-58af9f755c8mr685869e87.52.1759302924877; Wed, 01 Oct 2025
 00:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923133304.273529-1-mstrodl@csh.rit.edu> <20250923133304.273529-2-mstrodl@csh.rit.edu>
In-Reply-To: <20250923133304.273529-2-mstrodl@csh.rit.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 09:15:14 +0200
X-Gm-Features: AS18NWATFpTIxuKt6TOYxlvCdRwC0-rKJPWCBiTCdTUgjY_Zw5e5ezG3W3zJtXc
Message-ID: <CACRpkdZ6_YkUsCNRFfRM1v68fpvAJcdqPRtAKTGqLqHf1geJog@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: mpsse: use rcu to ensure worker is torn down
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: linux-kernel@vger.kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:35=E2=80=AFPM Mary Strodl <mstrodl@csh.rit.edu> w=
rote:

> When an IRQ worker is running, unplugging the device would cause a
> crash. The sealevel hardware this driver was written for was not
> hotpluggable, so I never realized it.
>
> This change uses RCU to create a list of workers, which it tears down on
> disconnect.
>
> Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>

Oh this RCU thing is a bit terse and a lot of code.

Can you look if you can use the new revocable resource
management API? It uses RCU underneath.
https://lwn.net/Articles/1038523/

Yours,
Linus Walleij

