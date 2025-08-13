Return-Path: <linux-kernel+bounces-767501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C33AB25546
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C416E3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3612F28FC;
	Wed, 13 Aug 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANM2VVHF"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C428D8DA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120243; cv=none; b=eOHhalU+nvKwJUEWiHIUGe3Tdg7ul38SZ+NnfdH+HiSo9fww9siqTEP1GR7O/QYIjIIagsPIOPeWYBlG2o9yUGfYBufmfcgs1Mj0m8zHsXHdNz/ShhtL+T9klpVYvM79fITyVUMyni6BTJxd6FBwI6viZQHpqU0EPBUX4HXkB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120243; c=relaxed/simple;
	bh=lYfqFlKPWMxCXweXeuuMBCix7a6a6OVoEovtyupYHb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6qdmlwQExAdVj71jSvXXfBJr1jA3ahL7i5AaAdw0yDkYm0OErdBN4O3DrzUgsE54kw+bpFnne5oHoLIHepyOurlWaWT7YTKb7fjNEO9hKS18ZLbsplglJSjJRR2Ir4wYbPWK6PgmO9Vtol6CgaV7ldIfmyDiLlT4zMtl4c+8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANM2VVHF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-333f92d682bso2334761fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755120240; x=1755725040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYfqFlKPWMxCXweXeuuMBCix7a6a6OVoEovtyupYHb8=;
        b=ANM2VVHFFpXzlkSJJSg9WhRqx1O9Rkzf5IyWwmMKvgkEVx1D/4Bh9I0Vj5PyeMmx72
         DFX4Atg/L5VeJDfa3QyP1WnlstajCCGsvbTyVhCxnRKA1ho8QwB2vG81vQ2VD2hdHymj
         BdRZFwPKFMJUJh1KAx71K2G90Kn2cm7D09zeT89b31f3bQwGNMgWgAD3cCQSV2UjlmXA
         FF1SyHCi+3CZHILU+TwtbVvCTMUFbVosSRQKk/X4xBb3ACTXY4J6R1chMMLmrSOMgHh6
         9RFiyTsAPNFmnoT8Lt8j/Y2iJeswStLxPFrh59uspnacLmZILmTkz/FjZ2G2dDWi4N7r
         DgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120240; x=1755725040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYfqFlKPWMxCXweXeuuMBCix7a6a6OVoEovtyupYHb8=;
        b=ZhlzACArw59fC41nwL4xwUXjWSzUvsXyDxifytZt+mmvxakl0fNTx3wDjTTc7ErqX7
         OwsxSOD0aqv5pBIYOvJOB29J7a8l9W0O8fLKBwAJfYakPiVS/pEFRML1zIhS9eWzaB5T
         ovwRZAa5G0f8i+wrSOatn79MMFMNhbHjatv/c+ENMuU8g+0lPQ608wFIyPGt1+4q1Bj4
         C+jwiQS6q2lARJ/8WTlI4EyFVQI7kgbZ0BCe09SpUtfYxtvSKLi2grRta5nqpVy/78U5
         QDDSCP659QQObvm0EHEQKl1t9MqeRxssCf+Mc8+NAAo4mjjaszqZi62sEho/S1REX+6m
         jgcg==
X-Forwarded-Encrypted: i=1; AJvYcCUNfMyw64FK/GLFt2DPJp5PlJGpcW1d3JqcfgwsOEWIOFDI3ZixBBezQw3CsXWVdhzEwem59b/7oHLMJ6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPdDf+Q2duuwpUFaaDxBU4E6u3cdDM8jOmIm8B7qZv4fLJfdE
	7k7rd2EdjEM505ahFJpoBDsoayBtXPeRAAVgePdE+DzxNE7uIIvsJ6ksBhi7JSdM0FReqFxnt/d
	eMQF6qF8HaXZ86rFK4CjtlR+AwbUESNQ6+WDjIR7iPA==
X-Gm-Gg: ASbGncsjP2rAjXDtc0+8z+zxZi7ZSZRPKiiI76k2XcbjkC8ASKX06zYr5sAwXZo66Uc
	rKysMjBSJS0yOTnB7eJGGFCvTSMDpIjXxNrYuXq1jPQ4lvE/UF6W0xwlBIOGyD/qlhrA/UEBSHn
	H/vkZGbMQs9HF0fnXwW4XDlS2Hh+XY4QAH6B5igCdHEbLS9ik6vWOgCn8hLrey/OzYk7X9jofTg
	ZN0NgpZYtKt
X-Google-Smtp-Source: AGHT+IFQKHOl/ks8c2sO6UHCTF4YTUDutnNXPXr1pDQpFnFdbff6CUk7MaNAdBSI0DWGZGIJ0JAWo41qD53Iktm2w2Y=
X-Received: by 2002:a2e:bc15:0:b0:32c:a097:4140 with SMTP id
 38308e7fff4ca-333fa4bfcdamr1324851fa.0.1755120239640; Wed, 13 Aug 2025
 14:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813181023.808528-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250813181023.808528-1-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:23:48 +0200
X-Gm-Features: Ac12FXwCx-uoXVs4aMDgHmYjZ2Ssd7MkYDl7neNxmuZuqzuTHDveVBYFE84fGPc
Message-ID: <CACRpkdaMPB5ydMgFvGOQRQDFJaco5bG8GNn7N6S6rkXa0FSBAA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: remove unnecessary file,
 dentry, inode declarations
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:10=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> These are present since commit d8652956cf37 ("net: dsa: realtek-smi: Add
> Realtek SMI driver") and never needed. Apparently the driver was not
> cleaned up sufficiently for submission.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

