Return-Path: <linux-kernel+bounces-866431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC68BFFBE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FD4EAA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6C2E6CAA;
	Thu, 23 Oct 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GVyFHnn+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBF2E6CA2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206155; cv=none; b=lDdXlMfOdDFItpldIEAgWdpmWwAPqWFX/eQnHLr8IEVQwFU6qHJpnkHZ74+UAC04o9BEfqyTfTJvT8mlN4mYCE7g0+nsrplWfgInXj0IT4+CJ5nsc4eAovCm6F/2YVFB8ca/QIaaCWV4Y5oIVvwNP6n9wAbEK9u5cflcTfFquNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206155; c=relaxed/simple;
	bh=8pCsgcD4bqNCWZyT+UngOBilZd2QN6TVO303H2MtuGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOF4V8bW5pl6sZ4v104TdSFZPOJ0T7IayRejzBUwketEVWes+A53g/2C5pe/i19/BoZQqSCDZfdnGtPqbJm87rXc0nj9uhlObLdj2sRhJRx+ZL1VRW3/+xZRhtdDNBFimS3uDntzbug1HfknDU7t9ZbNEVpwpaUq6pZOoDWJU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GVyFHnn+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57992ba129eso670976e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761206151; x=1761810951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pCsgcD4bqNCWZyT+UngOBilZd2QN6TVO303H2MtuGc=;
        b=GVyFHnn+/KaNlw6mKGxHPONnQXjHs3ISqmXWPqYaTiWRJ92BYF3At4qaT/bPFB0nah
         CgQzPM5/NIHvAk4yKONpyDH99JQwqopxjWvRnjlMBSvSgC59Ylt+ZuORcFCCEnV9WM/P
         JNMCcg9vqSvDrjt0QGpoRrbbAbxnCSRXA40UAte1PwpY+66pgIWTXFQ3FSLf7J0YcpFZ
         HzhLNJmX39bDFxVPWi2dub3G92WeNuDHiLbJp4nh008M5a8GB3B8otdee1revD41MyXj
         xFYBL0k3tKu6zX28YIKNfIMmvbimtmeSM0b5JancWkIpI55W5QVeXEXO0JJYiMA0rWCC
         dwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206151; x=1761810951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pCsgcD4bqNCWZyT+UngOBilZd2QN6TVO303H2MtuGc=;
        b=xLBo5l54R3mnTjbwaseIcl/sP4W3bm6/J8utuE41v2S/SBwLgSzy7mVwENMkNnerMK
         6si7CbggH4kHdriZjQSpNhV2+CZ/atIdc+n1vlX1o4dN8z5EGxSYeo3StsPdgfSFZoxV
         V4yL4O9vBA1Jm//E5Q01M8mAceJJ3VRCDy5Yfles6WcJUGIcd3Vba7v2pupw0KFVEHlS
         uaT9ZEyArvNhMOuDi0Q2B7hnkdTUJxJDzKfuO5qqAttUUPtrSHUJ7phpYE/57RpZ1oMR
         HIufYYMVRdcygNEOa8MblTaZFRMnQX+yuf2GkhfRUOjKxiNNhOs4u1QJSLUm10/viZQn
         7Ckg==
X-Forwarded-Encrypted: i=1; AJvYcCUkiRIOh3hbmcdhTNnXYgr0jMMYudQzemC4kLjkVjkvyG4JAxzz6oIdbZ0rYWngO/74NERguw5O609oGwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09ZoMpGcVZ0GK7SIsmR9qzqo7cIh4FWARdIcEQSQvCEi78O39
	jgH1kFab9Se29E7kZSJ+hXcvKref+0DVOqG/XlJghtW5AsmOy/OGSqHttcziJjfbWPDv3eXps7y
	wWnb8mY0dewRzL7pLMKqaEzlD0sIlE0zOoz7FgRMBmA==
X-Gm-Gg: ASbGncvySUOlDjl7L2k0CliosuJtikEXpXx80TiwR2KZxNcx04VL4XEJAbydU57fWPo
	y8P4JEIaFsOlsy487Bw8UFnGnBGV10ZdgrLYw2i5Snww/2zJ/7xwTJDBl02P8VVk8Xap8KqpzN3
	Xprd3pg2I65RTLP7A2F+/6Nw6kam7oPPxkdbfujB5kSV83onH+TXfU2HcNU+F3BUB9KL8w7QtdJ
	pPfyRgl3ZwE3E9zofHkizL49YQdjqvaiOVjVTYT2eesygTpAdtjqpbTWHRUghfJlI49UjWEBCtk
	sUsyibyX7w6t+5I=
X-Google-Smtp-Source: AGHT+IHOlmCV2+Vg93W0jlAG+gRj0Byqx/PjSQV0edhkqIJLQKKohxwodoQ8/ao7KpCEJ3ghbbA2pl6Ihv2wI5RBYiY=
X-Received: by 2002:a05:6512:33d3:b0:55b:9796:5d5a with SMTP id
 2adb3069b0e04-592f5a597c7mr562701e87.26.1761206151440; Thu, 23 Oct 2025
 00:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=Mf4FnBoZfdR3gG47te=X53jASzb6MVnUmNw2q1rtUwxzQ@mail.gmail.com>
 <20251022192901.GA1265216@bhelgaas> <aPneCYtkbxWp4Hox@gmail.com>
In-Reply-To: <aPneCYtkbxWp4Hox@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 09:55:39 +0200
X-Gm-Features: AS18NWCAB8MfhfubKKbjuEctu3E5mmyu9MaZ391LsVqFBFwyCaxgZ34D24NyEA0
Message-ID: <CAMRc=MdbHqMJv4otgG0Cwc1KcK2WbL4JL0Q75PRqv8582yexyg@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: bt8xx: use generic power management
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Michael Buesch <m@bues.ch>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:49=E2=80=AFAM Vaibhav Gupta <vaibhavgupta40@gmail=
.com> wrote:
>
> Hello Bjorn!
> Thanks for the review and mentioning the diff between v1 and v6.
>
> Hey Randy!
> Please let me know if the diff mentioned by Bjorn is enough or should I s=
end a
> new patch-mail describing the v1-v6 diff?
>

Yes, it's enough, I could have looked it up myself but I shouldn't
have to. Please, next time just list changes under each new iteration.
Preferably just use b4, it helps with version management.

Bart

