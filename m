Return-Path: <linux-kernel+bounces-775777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70234B2C4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5A6196614A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA733A039;
	Tue, 19 Aug 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHc2sXXz"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA8305050
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608705; cv=none; b=nBpwLiFapRfVV4ap7X+uJCb2hmvCcjbnAffZD284bJ6bPzLlrFFJKViZvsT2Vj24w3CutRSHXF3F+zishSOeHVbgbNCeBwvyxMCYIuxpOR+6kcWPb627eFvbzRD8pzfWxl5c1DWUt+C6Skf5nBnudQ9ggz2CTsCXs3nvH+pm87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608705; c=relaxed/simple;
	bh=qjShZoo+NiNipfT3WS5f7U40KalFqQBXt1e9Tunigdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxv0S3kUtLcEsKRSStrpEAVeXnnMrG90YAbo8I1t41I+HIeeuxz00tUE8kiYPZgb5i47b1nULcrs0Bsxts1+KqVZksk4rN6ExukXjCURSH+VlXGILoBs47cMrzyfS5xsDpNPNHMfVjuEWQzdccYhh5xx+qmNKXPmOcpzbG1Becg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHc2sXXz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f8d39e94so39997781fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755608702; x=1756213502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjShZoo+NiNipfT3WS5f7U40KalFqQBXt1e9Tunigdg=;
        b=cHc2sXXzMMqTdTc6mFW30Hcx66dkX2Hohv4K5106+l3ZbRjSogJ4Ny+rEiYr6XNebf
         wWOE0+twixzfjOTqK2Acf1N7Yav9u9s/z5jZFaYorFEA895kn0LLCtIBAyKegrSiAlGc
         1b6IIsWN6hDqnWCYiptM4aMV6+gs9O6+OXufHYjQFYc551BdnWG9wNZB9gg/UVCcL95g
         2uSk6l0h+hWTp6RTDH9bZmr86OW7m99CoNsoFoLgZKpXocX3+oWN310t6HEph92Pl0ba
         IVmGHDB0US/Qf5RkcYE2xCB4W4NXFOa3Ks++0891VhLaRcjFAl/QxpGCAPauMvMquhFl
         IrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755608702; x=1756213502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjShZoo+NiNipfT3WS5f7U40KalFqQBXt1e9Tunigdg=;
        b=fs4LgsWT3MSGN7e7rzT5NT4KUr3xjzkUGap+at3Q9H6Wpal6/oR/hVk7aj2dGvZmtx
         xAs2ggh4AEeAj/n6OaPl41LYRGuoopyxiXBzKIyvcCschno52GSkieR4ZcIpu1y7t8uq
         uxDCmd1hsgb7ZgDzBMWY58luyh7sXknHSGhieeF/3sBO+kXPI0/BFCiFpGLK32j9nE0G
         ad8BtYlPaz23vu6Yf65St2V8W+j2JZal6Rfus7Qk8EBw/sf5Iv+YsNGErA3mWcrW2IOy
         rVkXpMkfRSwUlAoeJJ9s3pDrs17aX+DK0EgaBE8AwMx8cyWHiYW7V8kaWdwwih2sx2o0
         ZNGg==
X-Forwarded-Encrypted: i=1; AJvYcCWLFQ3T0jO+1bEXl+vQMGwQqSi/Y1L4w5D6PYa5/sSvjF8kFqMdFfQ0xggEkQVmM8lSsKh48nNsbOLj+T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmvMeMR0q4pxaKxiVnablNLJtpHImIET3/YNmUIYaduPcOmL9
	qQPFxr06eFXHIBE9BkOBc9572E43aurSCR1Oca7m3i6nnVaDv8SGFlbcmM25EAZfK8bjTZY2rKD
	P9JUKu9GnfosnP922T19pT0PGOivkQvn7ZmwbrRmgwQ==
X-Gm-Gg: ASbGncsYFttfk6b1/7yHJJFVAejDjCg9TwN3kvKN7iYrKUuU/NijyBID84qg/uMb6XU
	QxHzgCX2TVJndNiE6JH8s3QjuFK7tUW+5s+9rH/L5CSsExeN2d3jTfIdRvRpeLwmTeMderUzNfw
	QKGd20cGyq4s9bLH1Pghfqt78UUMhuqAicwYVN5KY5sk1qtiLXi35yHt0NMcn2VED1fW+WBFxUJ
	AdyXhOK6ZSG
X-Google-Smtp-Source: AGHT+IHKSCc3BRRWgi/b6UYlklkIt3JL2+XoqGQiac4wdYUlvtkEDiwhts0vXrUKD+OM1NJ41pIR4yVIK8ii7tqOrrE=
X-Received: by 2002:a05:651c:553:b0:332:440d:43bf with SMTP id
 38308e7fff4ca-3353072126emr7293841fa.30.1755608701684; Tue, 19 Aug 2025
 06:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29d89aa43536714b193d9710301341f838fcb5b7.1755519343.git.christophe.leroy@csgroup.eu>
In-Reply-To: <29d89aa43536714b193d9710301341f838fcb5b7.1755519343.git.christophe.leroy@csgroup.eu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 15:04:50 +0200
X-Gm-Features: Ac12FXzPE0z4aQDnczniJjhXVKo7ubVWbJ4EdzLUQpWqZoam6Goakc9VHrWgbMg
Message-ID: <CACRpkdZcoT-hotYikqC1thmiOB_tc20tvXVrrOwu_ymgW=g3Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/44x: Change GPIO driver to a proper platform driver
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 2:17=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> In order to drop legacy-of-mm-gpiochip dependency, first change the
> 44x GPIO driver to a proper platform driver.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

