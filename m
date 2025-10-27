Return-Path: <linux-kernel+bounces-872632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E5C119FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10C81A61E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54B32779D;
	Mon, 27 Oct 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BY5MOK84"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4D2D94A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603024; cv=none; b=K0udThy2JBlaP8HsoTJF8tDMFmSgRy4LbYO3Jitf82lARuccRnsSgBMuxzCsUPQqCEEKJEKLAzc27s3T9iAAH59ZBtk0pCeNmtZZck96IGs1BoGHdS/gLrjJAvBrUfYTNUeAy3MBIWvrS8zlUb0HZ/XYwi6FJtpj/YrqHIOb7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603024; c=relaxed/simple;
	bh=P83isQ2gvRt7wdmXJ1hdjP2SDCiz+lwtL0Vt91PBpcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nqv/99RQ+SYsa04BYX66IZOxD2vLaxVaQG2SYa9yaCga24wK0mCyJ7cF2v+6unt0KnKpOXrLuRaVhAQASvdzt8QSjnj6F4pEjBuuEjqGUEWd8PqNO/nbo3JI68ersxhzJrPEjAHdheo/eO26ZzEg2TYNce4RopCsOv4t48s6y10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BY5MOK84; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591eb980286so5439371e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603021; x=1762207821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P83isQ2gvRt7wdmXJ1hdjP2SDCiz+lwtL0Vt91PBpcs=;
        b=BY5MOK84JV+tPp4DbFoSzBG5q5ivc9OWdzGlhRyFq6toPkMeFB7YP8cGA3rUJsMJaJ
         /3pypQxKD+nmoymHtdSSH5yi8foznYAlEP9mN9sWWpci5B/dUJudtlIt1bqXf66VXUxZ
         aHv/dLRRY4j4tPZrhM9WgYO2Bxu3j+LF8X1HRPYsy/1wlTGHq3c+HBTtKVQizXZS6QJi
         M7DNWExbXCfa8477wN2uLooqQ4dDZg3gfhGUCaFGIaqk7qwkOnfI/lzznH3PHavGYJjp
         EdhUflwhlY4+na9Robb22e8mW8Q5BUWyahRPZlvMknVqFGhndgjPI4ZVSLczaJzbYlOG
         HLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603021; x=1762207821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P83isQ2gvRt7wdmXJ1hdjP2SDCiz+lwtL0Vt91PBpcs=;
        b=DDJkgEvHpMqXjH3UAbtGgkTfGxY6apgOnln729+kMjS7GCmi4gKJhE+ZPG++rOFyKC
         HkxMICx3jpU52wVwai0lHfkJ4ps9R2vsqNvLjU2yiO8o0z+IfkREqPada4AzJDI9Yt0X
         qm+iL0qrUPHg7kUj0MTZzWLEBcmrtcIy9dYy1jjLh23DmsHt+6yjjXDDB4as3aZsz9+I
         XYpAVJhjwxr72FqjwjOkd/eND4oMGZRf+UiMoCibwNKD0+1HVuCH4blLX+fF4gn8auxE
         ii+6Nt5mRlJYQLK8yPKd+GHObNd8LUanzeGy+YiRmlAnauuDEIR6W+Jlgp+jSpWiOpXt
         yQSA==
X-Forwarded-Encrypted: i=1; AJvYcCUvKKfYs+DDsLeB3x3YeTeZuDL8yaXxFZ5HGVcA+4pxuYFRV3/TEeNP8UftLgifPoGkatx+Uk+n7iFL/1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3cfAo6Gk8bcABdgFCn39N9EOgvKRzYiToHaPy79cVNB+ZXbE
	0ZWvzmgvS8hWvwy3rhIoI/QqcM7xVMwAfgSB5Kpppa2aiNsrU3UEJbg+zTqIUoBTuJbJsXM8zxg
	1/+DF+TUiEFT5tb0wuyTzuWcCTTcqwBPJrXHMd67Z3A==
X-Gm-Gg: ASbGncs9chFzwaYJKiOCxt5tYryuFhJJMsiz6QZZ7Vf4BJRXExXrd4jqtDnAuWm0K3F
	UNNxiy2+FlpFbGX+imc5cFBoVJwgLklMWKtyj+3Sl5PgAOiME+x8Wi3V+Wj4kCbBVI0zF57gRiT
	psImuGXzM1NcQ1FotKR/vKfmqUKO1QQU6YMRPVLfs3ImNFZbmGOrCq5q2eNuuxSDLjQXOyrxJx3
	naWF+icuba6y6PrrzrPtZBwzTQCUFMaBaMlR7W0eijxB7yM2emBv76OHKG9QZ50fDgi14k=
X-Google-Smtp-Source: AGHT+IG9eaDbYlt05Z9zFZohfCDZwr4gqNsotaN2JZ8jVtyJSZnzH8ZzP5hqxntC1aSKIIT+xacG9uS/M37uyI9DBCI=
X-Received: by 2002:a05:651c:43c8:10b0:372:9992:1b0 with SMTP id
 38308e7fff4ca-3790774ba26mr3083561fa.31.1761603021254; Mon, 27 Oct 2025
 15:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-3-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-3-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:10:10 +0100
X-Gm-Features: AWmQ_bm5etBIx2qF76UfEPLiy1Nl6j4OjIJVT1wJCcuvidRKmWwIeYmy15zR_II
Message-ID: <CACRpkdbitTgbd+DcdTNYeuHMuSeMQMx5PQbZ=qsFxCPU1ZFugA@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] pinctrl: pinconf-generic: Handle string values
 for generic properties
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> Allow a generic pinconf property to specify its argument as one of
> the strings in a match list.
> Convert the matching string to an integer value using the index in
> the list, then keep using this value in the generic pinconf code.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied, I had a hard time to follow the patch fully and unsure
if we should add some docs as well? But let's toss it in there and see
if it works.

Yours,
Linus Walleij

