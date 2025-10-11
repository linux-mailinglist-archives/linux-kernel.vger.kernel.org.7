Return-Path: <linux-kernel+bounces-849313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E2BCFCCC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59D6534A1C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600D8280004;
	Sat, 11 Oct 2025 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWTgXxL+"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C727A927
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760216267; cv=none; b=Ukho0/nolopzkSZ7m8NMnc29xbnX4D3SaunR6c/tcAQSInhEAWNNaA3gJi0GWuBfZ4jO/7exkb3zMHKMVx4OcKcQP4hEXLokIDgR8CaskM7xFz7Rka0vlS/P1o4hSzx8gOLGlr4QgCyPZbrgwZgVQT5/U0g22h+AKsYI34F5Ofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760216267; c=relaxed/simple;
	bh=uwtnZCVzSiGkXQoQQFzPEWpYmEYUQSlYyb5Kp9yYodg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dbbThtHhMyepRkWX5bte3E227sCTvpYfK90A+szw7O0DwVkW9wUlMJaBpMN9+qJU86ZLwvdJjjDKoLnDAtHt3All3mkq5h7Ua1/H1xp3M3JkNvKWUDcO/phsAvgHqg2DYRZXDKk1qr+cHtdTFqeHgKU9DiKJC84Ui+ALgDriOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWTgXxL+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3652d7800a8so22996361fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760216264; x=1760821064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgJzFjoax8SxBIJMa0V5iy0K+W/kny5Ci0/lMx8+7Ig=;
        b=UWTgXxL+vSVZgdcwxI0BNW95j+GfWiIfCKzR97vEleC2srFxPjEr7jsXlpqEQFKXAF
         1InHOYB3QMsSjyIHIqxZzX06HFaM+t1duvJm5ovCG3I0zrhhJofTmeGo/+Fyhn1g65sF
         8r3mcFYiZHI+NT1u0jrD7ZrV3S3C1/a0nfDPPBkDApt2JpGS9Si7Jlo5+sQ5ga1pkjFm
         ynLzNpBq48bwfPR8Ha5DyioTotwi1p64j0VvuxB9Ywvvv4JMqCpADbPpSN+3kgBcjKuS
         uwHq7f4DzwJjOC4s+xKWS1DbOVBuHx2FKJiqdx2Uvo/S0/UIn8SpdOjTgh+fcnVDBDhV
         2iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760216264; x=1760821064;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgJzFjoax8SxBIJMa0V5iy0K+W/kny5Ci0/lMx8+7Ig=;
        b=mMegGJL808pROjuVxcsneprN9p6+QjoLQkeHzL7CuBHh8SnZ7fsaO5AtyxByK0YaAc
         2SVd/OIpQ7j6iQmh5QiDpFTtnqJZKHOZBb4AdTskACFmRcDYUHleiwMouWITni10FF7f
         2L8uaoOjn9VxmzZ5GEhFGfkf0MMvrSKB9TbKxPUlBL0PxD2FVpyKd5CfdFwR15frfOU2
         TyChkvKnRJvPm95BolKea3jz6vWM5Uk384YhHyGZ8Vg1KP7a12pAsgX+ME1Lg8uxZS8A
         9IeYj60hBqYQMsCLOlZMoUsx0GlR17nop6r4NaP9K53DsNYfgj3ZSuFNSzc4CvE5iKuy
         cjEQ==
X-Gm-Message-State: AOJu0Ywjo8xmzpAOeULlxdOj7dF/9ygch5FEt36PMuYj2xz3QXH7ponQ
	wuHFV3TrizE7ya11XIUTS4eyBX5qofACqODzOTNuDhnQSjgnBD/i8dPl
X-Gm-Gg: ASbGncvaUHaAT8Y82nC3h0LSoA+XmoD6FXpx9+boaL63YXVNUHMovBr42KyAuILiocM
	Vxy610rrqiYuzR9WYmzh9Sp3Dh9LhUe3BRwhfAKqCmV+nL2pFDTY9nv0bFho2kmaqWvmNWm3lL4
	YAyFH0DtnO6OcGZneh1v3ly8a4308rPb12NxOlz63/mqE3N+4zB65SwjF/J/dtCZsqUxOi/rwjM
	CHcUQxnPuKqfQlQTcsUDeSZJmjh1dHr0nnh+q8QtRl1Ri/6kN+fbaKaBHv3wwywbLsEocbfrwY3
	T2YtR927XypssjwdVem76SCQcBS3gJzuloint7rjkQE2Y9LsC1NkE5R+Vs0WhmI9TVM+Vi+Tp5o
	V5KHIk6x9PvokjXWZ90Ne79VVcVOUhYrAYLlh3RxagJhYdbifRmR1U6HQTGG2k10BiA==
X-Google-Smtp-Source: AGHT+IG3wUmm4mK5K+Izfgl7ijfsMQJWlkNPPVMsqlK0VYcP6nSMBV0Zbhe1srQiash5NJKVX0WPuQ==
X-Received: by 2002:a05:6512:1155:b0:581:7695:a14c with SMTP id 2adb3069b0e04-5906d896d0cmr3970311e87.20.1760216263701;
        Sat, 11 Oct 2025 13:57:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e58sm2250927e87.25.2025.10.11.13.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 13:57:43 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<87zfa016bd.fsf@osv.gnss.ru>
	<CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
	<87v7ko11iw.fsf@osv.gnss.ru>
	<CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
	<87plav2186.fsf@osv.gnss.ru>
	<CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
	<87y0piiz04.fsf@osv.gnss.ru>
	<CAOMZO5A2YMQQV8J6jg2o0C3qeFif0fSc5j6-98xhqNz=Lk4T+Q@mail.gmail.com>
Date: Sat, 11 Oct 2025 23:57:42 +0300
In-Reply-To: <CAOMZO5A2YMQQV8J6jg2o0C3qeFif0fSc5j6-98xhqNz=Lk4T+Q@mail.gmail.com>
	(Fabio Estevam's message of "Fri, 10 Oct 2025 12:14:44 -0300")
Message-ID: <87ecr9upfd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Fri, Oct 10, 2025 at 11:59 AM Sergey Organov <sorganov@gmail.com> wrote:
>
>> OK, sent resulting u-boot image off-list.
>
> It still boots for me. Please see the log below. I tested several boots.
>
> My board is a very old one, with i.MX6SX version 1.0.
>
> Looking at the commit you mentioned:
>
> https://github.com/nxp-imx/linux-imx/commit/816978f83b1d8dd6ce3bd5dd62223dbfdf74bdd3
>
> It does add an 'if (imx_get_soc_revision() >= IMX_CHIP_REVISION_1_2) '
> check, so maybe this cpuidle fix is silicon version dependent?
>
> Such a commit is huge. Could you add only the code under the above
> 'if' logic to see if it works in mainline?

I'm not familiar with the code and can't figure what exactly I'm
expected to check. Could you please prepare a patch, and I'll be happy
to apply and check it.

> CPU:   Freescale i.MX6SX rev1.0 996 MHz (running at 792 MHz)
> CPU:   Extended Commercial temperature grade (-20C to 105C) at 39C

I have:

CPU:   Freescale i.MX6SX rev1.3 at 792MHz 
CPU:   Automotive temperature grade (-40C to 125C) at 55C

-- Sergey Organov

