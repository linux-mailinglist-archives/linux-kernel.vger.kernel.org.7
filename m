Return-Path: <linux-kernel+bounces-799536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C9B42D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC665E53D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E6274FC1;
	Wed,  3 Sep 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDIqPDO0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6D1D88A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941574; cv=none; b=SoPltYKL2VSPur8fWfJFU1QJKTOQhywIQGqn+K2DVqi9w0LE6/7waYAZlsq19f5a72Ium/KgSDF/54tX5wmd1T+MdYgAuCnd6yteoWFZOp7nq3/4CK2MV6O3ChSCRYj2gn+0dYqfTOCjWaduPrCA8dx0kJQkdL6U1FAS2mc1lHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941574; c=relaxed/simple;
	bh=Z3tQCUxkEll0Mc9qQ5HNQGtre2iVUwoNuXuU8aKV3N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3ePsjw/DCdWKrRXDNPA6r+kF7VjpvR4nrVAJVP3tT2EvVx1CjtRUCt538qpYzowIgh5WQePVf97uUdkg4gDd2Eq7GY+RAn3Il2vp/X1GzAxN0c14IV2rrvJDMsMh2zpvuLg638gHjujsWyPMo812Mxr3I4XApGyi2EDm1xzgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDIqPDO0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f646b1db8so409080e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756941570; x=1757546370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29C8qKbyYbX4cfBdW9S4JuoBvyF+ovUmO0AWPsK2m7E=;
        b=WDIqPDO0LwA/zU+CnRp+HcgMbP6qhHJLdkKmswnncFy/7hSVJMB417hH95SHWCYffU
         FZqTa5kCRatdVYApK//mxIUmuF1xVpGBg112IIrUDXcu131JjAq6TCry04ZG974z8Kvz
         En2XGQgy3FvusvTozQTmzROyDIIsC7Ql9hVuVgy1BjPpQstI2XACEQgvpEdPj2Ad92rH
         t8JplPOIL0FMMW0YrKbx/JFvTt17BUh+2N26HO4pseAzpaB+XuXb2dpZ5XTypqg4nNJN
         qMiacrjFCNYZJVslBMdsF7FIwofQhjsYrZbWfeINsDrgt1oEeYamEzfn5WUu98Ysko6C
         xzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941570; x=1757546370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29C8qKbyYbX4cfBdW9S4JuoBvyF+ovUmO0AWPsK2m7E=;
        b=h1iSmQdwwl11IktY/pK7ahjOxHqHsZb/E2BxLwfJX0iQu8L0JtUqshKag8dtmo8q1N
         +MM7LcuslIE0Peu6EBZHFI+CLZ0MnuRlXTkUvRNogYtgEMSX9kHl1VXnEfgH6z46j1l0
         4iFjCTBgN6rGIm1GYkZADZk5i6fRyPUkLJ4Vehv4YH6HgzvdUZenqVeYEz8YVNGT5jEV
         3m11OyizNvKeAAMUTQm1NHbJ2vLzf9OjeQ9Amq4bXsijJ+7EYuSfbl/81mQGcvAIX6XT
         WXpg3ck6nD1AewonMXv0mVCSy+7oHGCoPiB4GVnQpVyVQtBka8WnDV0z0yP+1CIdpGWX
         u7+A==
X-Forwarded-Encrypted: i=1; AJvYcCXo9h1lBbKYexHBl6/dwVMfbszb+dA/FbPQ3KVS/xEZJjS03AfCAGKWva2ZEBBPG0Kri1GyxiYv4ZC/ObU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyaL4bGLYfpd8W5184/9kSlXcBzS8X4D5CG51vXjHO2/vaToS
	/+FhDHgtFZ/4c3GvQpr9Ncsd1Ds2tUNY7dSTrjqca2CziAAAb4ZQb8OJgyluJIunu8jMTnKLgZr
	dYyq33yDxilQoToa9PCdN/R0AhUjiVFhZ7Md16rU=
X-Gm-Gg: ASbGnctUSK4veMUyz/xweGdaY5R2Iz8KleyBjXI9A/1S0DPn84jbJJW5+d53hn9hMd4
	spR1u3JNrIfL4n+hwu77fwM9Jaqwv9cCktQhyo2LZdXLtpqOPk0cDeD2NQR+fGFLEDyU8+bndaF
	+q/SAyrlvi6rBwPAZ2YweGdRz7CdwgxmZ7sd4ytCWHvLnVGsuANhY87htBCeUecxuLxCdVNanTV
	GhN9CckvxahKQ06IND2VriJWSakZwWhhdgi/2nI2upp33ZuUkRF
X-Google-Smtp-Source: AGHT+IFJLxqirZBw/SxLKw2EWgcKpg9jKGRVkvOQcsda4E4g03fmTKsZyBAJsUO+7wIIixb23VB+1p1eKsDyzPgTxwY=
X-Received: by 2002:a05:6512:b02:b0:560:8958:3e92 with SMTP id
 2adb3069b0e04-56089584596mr1730314e87.17.1756941569677; Wed, 03 Sep 2025
 16:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825203425.796034-1-helgaas@kernel.org>
In-Reply-To: <20250825203425.796034-1-helgaas@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Sep 2025 16:19:17 -0700
X-Gm-Features: Ac12FXwqpJdaeTbT4kJoZERuCRgbAOjq9tnGiU34fW2VyCZOyzmS0miZRaBMpOs
Message-ID: <CANDhNCr9Ay0PVCC6S+uT76MicVe6qk3_d4CErshOOSoYk+L=hg@mail.gmail.com>
Subject: Re: [PATCH] jiffies: Remove obsolete SHIFTED_HZ comment
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:34=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> b3c869d35b9b ("jiffies: Remove compile time assumptions about
> CLOCK_TICK_RATE") removed the last definition of SHIFTED_HZ but left
> behind comments about it.  Remove the comments as well.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: John Stultz <jstultz@google.com>

