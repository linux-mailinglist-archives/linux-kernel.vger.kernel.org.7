Return-Path: <linux-kernel+bounces-868338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1393C04F96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8D50236F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B992FE04E;
	Fri, 24 Oct 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFdt+/ZQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5622FD7D9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293284; cv=none; b=eqeKAjKsJyo/1ZqXQrty/QtYDlJgbOmYGOG+NW9WL8WkmrD8ofB/BjbA9pUMVOJYquDluhpHm0DwLmaESYf1qj2pf232l2mSAKGrXaiMvAoR/zbyvhxaOduJHwtUArbX4+7mIxCDVVp5/Xbp6x7BviXsbtQw2z6u36A4XsOZyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293284; c=relaxed/simple;
	bh=J4S94DsRoninMSBudglc4Ce8gLtqbhGQOepjq7TbzOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYT4jI4hSZEsuKY5FktWLudrq011jNhCl/hg466XTJ4Zq32v3v51OmwTmTJRyTwZJecaWfjxrWiB8SRrB9phMhYmktu9mxAh7InSvy4jKITZpknJfWJXHVyeq5wdpc/Pdygz/aLez4F4nCHOMZu7HJ4f5/ZuZDJ9Kn2khA5EXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFdt+/ZQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso4030244a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761293281; x=1761898081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4S94DsRoninMSBudglc4Ce8gLtqbhGQOepjq7TbzOM=;
        b=MFdt+/ZQ/Fpmhw8jfiG86GANLs3sWJ1DU4KNPyW0Uka9dRfA/SDIwcGWT6ru1x97N7
         vMyM+nBirflmFtF6oE3jTo52KIhIUKIj9c6jZ7zybxa19pyedrXeoI0nJ9NRrFpDEzaQ
         9UosIjlhC5fMoGMYCKT+R85/FdZLBjInpRAF5G//KQubHAQnojK0W+j7TV/9+GiQ3ZTC
         RbelJfYNikpSjuBvg87FXqDWgo8pTeqgi4OhWfnUKmA2gx2mtYJv9crEUYokIKcvFyJb
         2qJ5SR1ZNjW/QSQOAqr0u6B+/FR9RuBjoUuFZbRTLWcMHUCwOEuypwNuhHEPwIS7KQbk
         eNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293281; x=1761898081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4S94DsRoninMSBudglc4Ce8gLtqbhGQOepjq7TbzOM=;
        b=MWFXQHbqCQsrYPntKQIa0X5QwRSlfDl3biR4hYZSo+bhpWnTvchaBhesTOIwXhH9GO
         kuxaqw6LXfql71tGMDtJYGJloo06o2de4RWYDwLtXwVu1zh4G6Mf2dECiSm9bItfb+xd
         Cr3bVs5sAm9s5TZmJO6vVWOwcDd5kBZrmU2Bl+o0f6BzogbIHLFFjplLMh2cAguIF9fp
         TZWY34YugdMHTxSR8q4MoizU/6oebx81m0qLikuVaDfDVr+OLrv+bJJNf27sMSZEnyUG
         he2Slwj7Ngwvg6jDz4zakw6WCOhBgWX5++215MwoNSagaxYcgWJX84T1vpBhwhZ2Rk+a
         DaaA==
X-Forwarded-Encrypted: i=1; AJvYcCX5MYxY4KjQZj384QrrsZ8+L8VvISsAVTCQa+b8EmkD/7PEOtUy/Is7TiQYjkCHpAEU1ltqP9iPS/CtEsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxksyrbg7SEWYtT3VoHWrQsC6X9ErwEWlSdjeM3mbgbKX5LL8UF
	oMzXrJOkRATijcnb+5cxIcLMUs0CGONUtRXMx3O6HAfRxdizO2zdGvBW1UWUZMRDvOq/laMVsCx
	V4tz6i94lQFnssaIovs1Cy+lK/DWB7XgMab9b/oh1Bw==
X-Gm-Gg: ASbGncsaQ+LhEO+1eCBFSYgwTDEpi7+kfTuZ0Bhq1Pnfbpy4+W6MP7EiWHJh17ss6Cs
	iF5OOsFpIH+XFgCXfvWNmPDwqo3noBH6/4AVCJZidoKVyCCWMR+U87Zklb0owwspDmgqS8jiC9Y
	h0n8pZZKurzxSvvM3ar/YnCsc+EYNkrJ+9A9GigBv4HNUL/OBqGtJg+nEh+zllfwVmc3q42OBjx
	OstwlafPD7M+2omDq2RUOajjqmaT8GIyVQdftN8fRbwp8sWFoZwEL4HuQlnpn4JSXxTVyRH
X-Google-Smtp-Source: AGHT+IGCBRpJ+LtRu0ox9jPypuV4C6ij8WNh28i4Y4jNHo2XazkGYc7aNTT4wZyFuUQXwqrs2AmyVxtO04NXGhYt4bo=
X-Received: by 2002:a05:6402:1451:b0:639:e712:cd75 with SMTP id
 4fb4d7f45d1cf-63e60084372mr1411179a12.8.1761293280483; Fri, 24 Oct 2025
 01:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <206e36398db6075bfb0bb0b98295ee7328c5f64f.camel@pengutronix.de>
 <20251009083703.2038187-1-a.shimko.dev@gmail.com> <c863512af9a13eb92bde7e0d383d4b4c81e5ce3e.camel@pengutronix.de>
In-Reply-To: <c863512af9a13eb92bde7e0d383d4b4c81e5ce3e.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 24 Oct 2025 11:07:49 +0300
X-Gm-Features: AWmQ_blxcEq4dG4iG0CEj1wkIzCyAln6t7Eh-QkpWOlI0opsE8oVHudxGwsyDnA
Message-ID: <CAOPX747hVv-JZ71jtam111KYNiCJNLBnNrcQfNO8EEEihfFwwg@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware-platdrv: handle reset control deassert error
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: andi.shyti@kernel.org, andriy.shevchenko@linux.intel.com, 
	jarkko.nikula@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:39=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Do, 2025-10-09 at 11:37 +0300, Artem Shimko wrote:
> > Handle the error returned by reset_control_deassert() in the probe
> > function to prevent continuing probe when reset deassertion fails.
> >
> > Previously, reset_control_deassert() was called without checking its
> > return value, which could lead to probe continuing even when the
> > device reset wasn't properly deasserted.
> >
> > The fix checks the return value and returns an error with dev_err_probe=
()
> > if reset deassertion fails, providing better error handling and
> > diagnostics.
> >
> > Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Hi Philipp,

Should I do something to bring the changes to linux-next?

--
Best regards,
Artem

