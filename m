Return-Path: <linux-kernel+bounces-813958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24428B54D93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF61C254E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41361301031;
	Fri, 12 Sep 2025 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXzvEr3p"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C027AC44
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679698; cv=none; b=cjG7Zu5GBCG0eKhdBqVy3blEY4FjOamGwPX63ZG0B6cB2zzjwsaWMPCnSdhwJ/0XVWB7xILOcwvq3QuVcjZhnneSDvdEra3J7T3rEjWEKJj86ZFJP9sB/5qVF9V4lXqADYpw39WuRL0MHsXnA9u+pjNbtQdwZ0g4cJWrSB4Idbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679698; c=relaxed/simple;
	bh=yht0MzjKwXPqfzMkTMQkKpkg4jWPJryjUJrJkqlBlvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iK1fTStdjEchB66n0FR0knz9un7nIGbBAepHOed+vMehvYYJcWWAh2/UgEYMBjT4QFZEkG1fvWGGRtS3iCdVVuF4EO0yeCUOOn+SUdfJU5jaPNwlKjwHf2dAR5y7I430/LQZsYJ1m6uHSsu/ebuJMQk8mJFNY5h4MXE7qJ5dk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXzvEr3p; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336e16f4729so14681231fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757679695; x=1758284495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yht0MzjKwXPqfzMkTMQkKpkg4jWPJryjUJrJkqlBlvA=;
        b=wXzvEr3pmT4Sl4/LCAiyiwjpJqkBr85EdnP+liQFUnK/A0L8tYY+RGAQmasqtUsFMl
         eIEk/4tVwUxGX7JpNfl3JHVivDlbzh/simb9gu64Xn7ztuzuu9cr9LRLNf2wVzXOC9VO
         c84baqU6+a9RUIT2i0hA49E+qEHy+3/JEZBm61IoB6qF5c+S4qp4rkcNZKG0AtJO3jqI
         GI/DXTXrglEbki2f0n9RNlCU/oCu62PU2qFONhhSOF+lExrISRRT3Enwv+CXkFIEMbg1
         qINqs5l56sp7LMoi5B4ElF9+bO9d1OMtzcgRZVAJFaPMnaM182oWecQeTZdVJ6niftCX
         Zhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679695; x=1758284495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yht0MzjKwXPqfzMkTMQkKpkg4jWPJryjUJrJkqlBlvA=;
        b=xBxIzOFP4RvBaqjgNmHyBnMytMijpoFlbtOiNDuI/NwEHV+TXwgyWEpLIilovQld/M
         dSpQchvUxKrX4pqYd1vNeOZZ02NSxAIeBZUZgsVs/V5PWYa/wW18ZEcbspZIXCnVegsI
         jmrhSOYd9/3hHzoFTYU2wBPsqpWiuDRs9jlzjdZWBvRTC200HS1cbzivdqgxR8nkRLTU
         U9GacBjYgt4eyPSmMy3YeKFAyfquqfLoXXNtmT8P5ggqesQZPpeyBsggzKmt/Yl9tuU4
         /GoHMjZIXnMbgyjQRvegG1KNhahJTIMcaXkyS0pSg0pO49RRkfIqoH2DOMejWqKXeurS
         D7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU9TKO93q9ORMCPHgmwIe0knyDmN8GqSgEMEaT0K2afYabhIUTbH7HOTSjtMH6uPFTDUNfaWXYO3IsGlGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPzzAfeHcakuEMYl6+vB+km/KEUArG0qdTZvwi0YDNSln0yO1h
	6Ae0lM4F7Zpj/DYkiQMK2mum4STtK0rUq3/QFiBGpyMyFGEReuLA4c63jP+KUTzEobo0W+0rGvD
	AHI/GOQwbY3dUvGwQix4VxnzgarhE2TtGdEUsPr4JGg==
X-Gm-Gg: ASbGncsIddT4TjK5NPkrj6C+mTcHFLKzxnfNq4d5/bYdfzreQkT7utDOAglTHtuEIMH
	CJSUQULOtctijf/NPRSocn34hqbn7Ak18hCDqlZERNnEvnP4zT6w4bB/e73ED5WBih4o/tRyH5b
	Fxe8xsfHo49K/vkBPFWhiJ/Eua0zUjGqKR7eYZ9DLEJORQvOuk0nXoUwVOwPHRTsYY6KxXmliyF
	B6TuIY=
X-Google-Smtp-Source: AGHT+IGIryVwwWle5BuCNtAg9SWHOa9Fynk/RUJtYWpT4Bd8pqtmMPa6Br277pH3nUbppV/EZnHRiOtwLb2ws10wbU8=
X-Received: by 2002:a2e:a9a4:0:b0:336:cce2:fa5d with SMTP id
 38308e7fff4ca-3513a8ee15dmr9949001fa.11.1757679694596; Fri, 12 Sep 2025
 05:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912092351.162307-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250912092351.162307-2-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Sep 2025 14:21:23 +0200
X-Gm-Features: Ac12FXyVfQQZrEJmw9O1A4dKUe7GIFb_xvJhZW4e_4RrQjwp91fxqMFdqNnM--Q
Message-ID: <CACRpkdY8-j0aCoz+akWHOX6WQ7nNLMbN50A=_7cgNPSUBuQb-Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Simplify printks with pOF format
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:24=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Print full device node name with %pOF format, so the code will be a bit
> simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied.

For the follow-up remark, I think it's an improvement with the
full path, this is better.

Yours,
Linus Walleij

