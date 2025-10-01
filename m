Return-Path: <linux-kernel+bounces-838582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06649BAFA00
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D33819409F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B63281508;
	Wed,  1 Oct 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zy9qHqO0"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA023283C87
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307388; cv=none; b=smECJAXVWrhiUZprzu/i9M9R7Cfn/BiTmZSU0xW8Vni18TZ9Byk23Yms6Pn5+OwwVd3yTQeYO1rYGM6U22epW0lCY+0NSD3vMxlCMaFguDJ6EDFHRobPwJsFlJXJ1IbIaZXxnwqiaftEg3KcGvyzbbpmcu8t45feUrOUF+M0j00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307388; c=relaxed/simple;
	bh=7Xx2jvOSZl3TfR9fRrStFK10SHKH19//aJtsgQeAwqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfqWhsaSbSOeuvMzu3Jpvp6nI683FEcEJPND7bPvee0gLhVFY1vzOJDDBcBZZFSpycV21JK8037nVOI8I0lO/rFPKvp5CRWhdxL0uchsLqga19HKWob090mzuwdKOEMNzFLK05fVPN23Iv06TDAtvMpnYyu8HQRH9Qp+GiqHheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zy9qHqO0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36d77de259bso63980911fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759307385; x=1759912185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xx2jvOSZl3TfR9fRrStFK10SHKH19//aJtsgQeAwqw=;
        b=zy9qHqO0QMncBG/acJjQ/B36764D9eNgb5lh2i7E7NDD4/aCAeqYAmZ3G2rru4CiJH
         I5rIbb9MmQuN/qump0bVelVHwABrAnEk0AAwY/3a6caoe3+29rM4VfhyfOdgf2LzefQM
         7+I4RBQh/aWV3K32lCjA+62dqt46P08uJhOv5eYccuWLw2tZn2B4EDKpjRZDwUdU/fVJ
         AujsH2ymBt5DgZuQKDh4NZ2mmgUNEsqw1cxWcY4H2VsBZu6tZtnSyY8sYdpq88L/dXQo
         45QXYBI+DJybCuZXsZet9k1lt2uo5wwH/O3EZPz5VrtdXzxsI6iv9UR9UdMwnv+aUljd
         /iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307385; x=1759912185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xx2jvOSZl3TfR9fRrStFK10SHKH19//aJtsgQeAwqw=;
        b=gKHRjPvh8NhHkfVrozjQw2GtTtWLot15w/7cL2DGPGiKafil7O+BZLyKKg7FyLnYH3
         5D9hT+TrWlVmYwU7wlIUp3e/PASwc/pJohOsqkQbic/59QtVxpeV13nXPYla2lBosfIW
         67i7v9vvbDt1R5f/qjXBnSJRE6M6VawFiUvpqm8AfpJa2P++QnCwL9wWfZZOAwOTTX1I
         qaoTdgxcXeDXQhcOdUi8busjjKI1oaFJOUxmm7WcyHaFQKsEOojOBajlT62V8v7FbUWs
         y7gBrp4LLIzEgz2/O/9KwHNs6+SLfBkLIckC6IzJW9RXe5+4We8xTF6IxM5dfM60u+7y
         1M9g==
X-Forwarded-Encrypted: i=1; AJvYcCVndHK7Pp0/LzVDqCjgKvk0jbbL6ZfXw5k0g5tR2UprlauEc9C4/6TjeyvEpsNP9gAAxisTyJQMUfdMrGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUOWmTWsNZGgwl+yrD1rVLsdeClmNnLPsVIZybyTTQzU0Dmy0
	e8OWpMY4Zh4Gkli03dqTyIFNmzGJm6NlNP5xsyxirNXmOmBv1VtLCNG57yYIP3dH49bh78I2nEn
	nKF5dba2crH2x/8rfYBn2RLlTHi3lUUtdINtu4V8wX+xGET5V/CT2ank=
X-Gm-Gg: ASbGncsKSTEgLRJ7SDQX0mhygeMCNPbSq3bMYoc8CmgcxquQ4wJDCseIc6EbxAr9fX3
	kCzpBEO49mhr7ELkP2cpWpd3hF7Ie7n3jLfpn+EgfVsY31cdlzeqyF5UlC9B3BCrxbjh0qV+8lf
	oLmkQnzShIFfR+i154gvSGY0241KzQv1IJz1kLMKQxiexvfpC9NcKe2UvQcwh22krnZk8fiM2hm
	lgg1xQxKrov+zHoJc3CUqTTBBEpRvo=
X-Google-Smtp-Source: AGHT+IFauam3sdlZB9QJWbh4+GAxmh0ubz1ae25YEEvzWcWVzhEhcPdH1Ybo7BHPZBgqZuxxhl4Xu6FjAIJviWHNZDg=
X-Received: by 2002:a05:651c:1a1e:b0:354:6fe9:8ad2 with SMTP id
 38308e7fff4ca-373a742c8efmr6440061fa.24.1759307384849; Wed, 01 Oct 2025
 01:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928054019.1189591-1-alex.t.tran@gmail.com>
In-Reply-To: <20250928054019.1189591-1-alex.t.tran@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 10:29:33 +0200
X-Gm-Features: AS18NWAMtqMUn24GGcmh7thNWTR5vUbfn3IjRIXldKz77cgiT9aQbr-9m67Tq0I
Message-ID: <CACRpkdZdfcqoX4bQfi1hFTmKPfZcumBFC4tNVrAODGWQJ8bTxw@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: gpio-grgpio: call request_irq after incrementing
 the reference count
To: Alex Tran <alex.t.tran@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 7:41=E2=80=AFAM Alex Tran <alex.t.tran@gmail.com> w=
rote:

> Remove extraneous dropping of the lock just to call 'request_irq'
> and locking again afterwards. Increment reference count
> before calling 'request_irq'. Rollback reference count if
> 'request_irq' fails.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

This looks right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

