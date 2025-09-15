Return-Path: <linux-kernel+bounces-817352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33870B580F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BEA3A7AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C21F1538;
	Mon, 15 Sep 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d60afmyZ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B881F7586
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950780; cv=none; b=NMghultbJqEwP1BXvkbccJ0NOPv5LlPFdGl1Ujw2EGhEiZZQVL5ipXFUcF6mYBLq0SSsgptKSqwQP0wTh4P/SXtGnrwLOO+KYB698Y1Cwhx60CaBwGkXrXM6tTEYclPZ54Gduc/5Jh6wHlNZrzt2xa2H5bxYthEP/MBWhUIEdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950780; c=relaxed/simple;
	bh=DZN9ovVs2yiVG0T1O5ZWxdPiYJdhXCeIsqnSYolLq9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUcUjDffFP+EWBJZGm4iCvAYzmqf/jZdmf+5TT1eKt+WYgax7R1ccDlNiV6x2KRk7RljM7GQcSD2ophiDoOgE7czZgUzhObAD72yleaPgKaWWrxD0aB419B4x1qHyvsGSWJuRMLiHCklVG07BpBpSRpMnZ63yan/gJSCrwnuOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d60afmyZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4074167b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950778; x=1758555578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrLIA6IuCnyHBciyJ3q493tzDy/BvKOpOJ0QbU+FQw8=;
        b=d60afmyZzH7NgILiGL/6KX7TMEq9qwokoRQVfBXiw2GoyB2YXpSLBPHPfvjhkZdlP8
         NjbBm6RabzFAOv3ATvHqcd2FFSU9XvF4Y+cFFQIww7v8cgUh3EDJkhAFR8e254w++uUN
         lDc1QGZyDCHEZFrnFWPXE25htvXXrH0uIP4kREEabHKpl/7X/8uEYfOutqbQdZLOB8WS
         7JD/ywADKObGuoIIxUHD7c3UDk8BmhokOmvSltav2+9WWo90Rfg5/YVUnXqjLhRm44uK
         Kaxz9TUhoybQCe/7Op0hXShcp16loI1gfmoTLJLQd/+1LMWFNL8jz3ithdftCgfUIE4r
         Csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950778; x=1758555578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrLIA6IuCnyHBciyJ3q493tzDy/BvKOpOJ0QbU+FQw8=;
        b=Kq5WrbOD/telfiyfkOyS92hutsSZed/G51bnAw9gtYlxhpNH9pVlO4WxM0tBZhAw08
         EKxpNA9yHVtAz4GplSXdKBEVoaFQRiBuJGlasorPLfH6cAl9Ev+WQub6WTFMwxUXTy/y
         en988QLUpXb5jLk3mN6MV59MM+1j9tX8IS1JWcG2FiY+bjYecBLtkKVLHZt/o7TvqmEC
         4Kb2tNShQWHN3lXwohnCwkUeJRYtcmH8AMK4bsqsjAkXj/UPChx54ADIWfKGgl3uGP44
         o/MvI23Yo2284uFqEajq21NkKXGwF7vpYX6rhbuzPeWjYMePaIb5dCHL0OIDItETAG9w
         iZXA==
X-Forwarded-Encrypted: i=1; AJvYcCWKS8G1Tri5vD6Fg0oqDC7K+AG1egybdmo5VHO2w0JbipOvnbFMVUNwfqyGjY4tC21TX+8luouYKR+KNuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Rb4y5Ey8uCs4u2YThfo+WyiiOhThkidx18uRwdrw7QOEIgGK
	L92uenb9FuMQK7eqyW406JTirxblvC3R/nTI5G3ooRiNCYXokFEhXzQlHeKeE1SEYe46zZWo6p8
	d9BurVeBkx54oGepEwRozjNLAD2AUvCpY7Q==
X-Gm-Gg: ASbGncsMKm0iNnTSE1kbENPE6NZI/p6z7hJWLB8r/OePbn3r+69/L8by7dSkV829SsP
	TYNT5oOZhSq+BDM2Gf4jZPwMaV98Y38PnLf7GhLitrLpDt1i8g1WLibTKj/jixoAJdFbfFb/qHJ
	FSbrqpYC8dAAONE7Y28JiXzZqnksrg67GzvZlGZwg7PfkBq1w9uvIo9QSeQVnRTYdWgcmzIqpKV
	CTOsJCww9fgPyO4falQnVA4+19R1Jv6HU2z5/SfTCFLUH+CHpw=
X-Google-Smtp-Source: AGHT+IFbAWAZ/rcXDHcWl/HeTS71hsGMfzSIBuS9wCmhAT25/+RBADwVUHxmphmdG1nCRBgLgLnUlBpBUVn24+ilhmU=
X-Received: by 2002:a05:6a20:2449:b0:23d:45b2:8e3c with SMTP id
 adf61e73a8af0-26027c13800mr16359794637.6.1757950778232; Mon, 15 Sep 2025
 08:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915120540.2150841-3-thorsten.blum@linux.dev>
In-Reply-To: <20250915120540.2150841-3-thorsten.blum@linux.dev>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 15 Sep 2025 08:39:27 -0700
X-Gm-Features: Ac12FXx0gO_7403ZH45uBkr0riPdZ7qrp5TN64xCIXKki5dwHEmXhUvNNO-N3xY
Message-ID: <CAMo8BfKQbkh1-s3xvUmH1872joM9=MkJ09NRZ1xbdwJQhK_R=g@mail.gmail.com>
Subject: Re: [PATCH] xtensa: use HZ_PER_MHZ in platform_calibrate_ccount
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 5:06=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace the hardcoded 1000000UL with the HZ_PER_MHZ unit macro, and add
> a space in "10 MHz" to improve the readability of the error message.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/xtensa/kernel/platform.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks. Applied to my xtensa tree.

-- Max

