Return-Path: <linux-kernel+bounces-872635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A9C11A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E2503521EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427A31BCBC;
	Mon, 27 Oct 2025 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/PNmNrw"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06522F99BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603144; cv=none; b=ZC1EZGajVhgodc4oQORY0JiDnXEctjEaQJ6BRmld9qvuxLpND9y/+9Gp/AHKaKrpODcPZRI0JIyn82/oci7wwhEM7d82BV7EPzyVVcGJLjp7H7+0COnds2LeIauelaOs0Yy8fBb13C8MXV5UJtpYH10tG8ZYN8YySM7gn+PjOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603144; c=relaxed/simple;
	bh=dbID/UypVjLamN/9qIMtqE5/TU0mKMuAEmRWZAcTIbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI2ald0sf4UD7s8LlQzL6A3y0McKyJP1eaFSzyYp3iR6QLFgLHAcOTn+dVFlCXH6QdzTxqHi8eF75dIYS7iv1Qu+bIK+9EAbsVVIYkNK6uKQ8If2X8B27JF7lFHWMvbEz4vfufO6vLvmBuBaQAXFWmTaC42c/tkxCDcx3NvoCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/PNmNrw; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378cfbf83f2so57233521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603141; x=1762207941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rva8eNp25Ue0gQsDBJs+PbWTXuUBcdKNczWyrciaM/c=;
        b=R/PNmNrwBK1bFfngf5QXqobXJR9n6dw4a4NONF2lvz6lpQJ3YBASBjvHUNbWv9KhdF
         hSqfxnaOSxI4eBqIszhvmGj/fzviohFUpf4NRBQYjzdFnf2t5eUiEdYMi03JPG6rMYe9
         gLCMXZ5l0+wtX71OHCFjSJuYj69Jagam/qc7Xd6K6rgrOb3Tw+UwW6LoieoVWQusct8l
         PcNZZGHqhCULFHydpPeidwoWPUFnFTj1toHh65778SM+rvou7z8I59wF9IA/4McYviJI
         rM/30wjgGit3MIM1kRBoPTNAVhKYuGZWDovNUD3APA6k2CcGVIgLAkz7Laxrg8E7hDlj
         Q9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603141; x=1762207941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rva8eNp25Ue0gQsDBJs+PbWTXuUBcdKNczWyrciaM/c=;
        b=rWdduk15cUFNNTHpPUiOcS71LZ/zQUHwTRujRA/aBz/domTC7PTk/MfqTNFokbX00h
         WBZe/QCCFf6XV6GiAtRGgC8N7m8hf0YBPCU3aIxXam2IjU9CscxggqqjBaWXYFM4OGuq
         OhcaEt9NLgPOvFqqKR9javSLc7STLuEWDIxvpJ4N74o+YfqspxzdLwks5LUGLuUW91Ws
         c3Dces4avu3Rk3DEaNMNSe1XUrQ2q9SQ6hGR6L/sJNUp8PtFJl8J4xm+Vyj+BABqnHko
         MKGt7V5drMODHcpa0u4m5ZhYp19S9Nkz40rVY90VoUxySPP/XhlYKUSrZmfd58dm5W9c
         V/vg==
X-Forwarded-Encrypted: i=1; AJvYcCXzD9wAQDDRWzdtc56fgdeGvoe/TNEv/z+PkCZRfW+beFfpa5cX/21Go4jx8JvfniNDA9GRfaO60Uo2Als=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6gL/2TtiWavpxK1L/ytfpb1It4tzLH6u9Bmyz6odWZ3qd1vj
	9Q3iLv0aeE5z0qpS2KWRWaZAdG5WbeReVUwwdHBUF71TjOhydCqdDRwpjoMVAbCVBO1AOaaSm64
	pz95e8W0NJ27/jdFS8ls1zXr0JTN4Tw3E4AaZWmOYaA==
X-Gm-Gg: ASbGncvt5YVpOBBJoX+/nLPcqlahptRYyZYxQ12EnKaYHVZ50szP5guUPxK9lxJAVpL
	ZTqiX2sAdWEnqv/NMGUG2YKfBo4JEamGqSaQqdsea+Tm/AB3CecPdZGhx8maGkvR6p6nMIcd2u9
	gieVCqJDSj4y/hInUpuM0ugVlNQ8JzSAkoijLVFZD5lV+8OR4ci6xdYlC1+ovoOmOt/irBvWkdP
	d8fkIpoR7VyRlEyHxCrUI5eXIbPetoC+cMB6YESBdsaSwyGAQzol5gq5eH1
X-Google-Smtp-Source: AGHT+IH9m/NbKfDEBOg7KAI9hfdkDs7TGJGbF3wUoHtsDaxpc5srcl1X8uRL0I9IzeShm5L96wIBCgrx2J3l4dX7aIw=
X-Received: by 2002:a05:651c:1b05:b0:379:348:80da with SMTP id
 38308e7fff4ca-379076be2ebmr3767231fa.8.1761603140859; Mon, 27 Oct 2025
 15:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-6-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-6-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:12:09 +0100
X-Gm-Features: AWmQ_bk9gp6HQ-6BpDwN-PY0mSBFQkGGnyA4wpSZIs-jczVxX4VZCaFGaKlsqZw
Message-ID: <CACRpkdZK9L9q_zLZVc9JLmJ=XPWFBrKgk_3bLxxpCFvRCJr9-g@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] pinctrl: stm32: Rework stm32_pconf_parse_conf()
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

> Reduce the number of parameters of the function by moving inside
> the function the decoding of the field 'config'.
>
> While there:
> - change the type of 'param' to 'unsigned int' to handle the extra
>   values not in 'enum pin_config_param';
> - change the type of 'arg' to 'u32' to avoid additional conversions
>   and align to 'u32' the corresponding param of __stm32_gpio_set().
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

