Return-Path: <linux-kernel+bounces-862461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D06AABF55B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BFAE35220E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D02328B5D;
	Tue, 21 Oct 2025 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZVvVylep"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831C030BB83
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036544; cv=none; b=RfcLcSZece5Hu9NeeRwGj+tpWlXglEHpX0pYRQ8t1zjC0+FSivPFBS6zdacfvie73Fyf1MelqorbuSWLcBiU8nb6EuViC8ml/BAvq6x368i6Xmt/bCEXs6SWY/g3pdBNWJka0r01RcT92WcqOeRz92WGH1ItQ+VGDijW9S/g+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036544; c=relaxed/simple;
	bh=XPoKmOvkORtTPa9NjvFga22Y6k1YtkHFkJ0SSvV1lJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4dYXXgs0jhfhlPzaVjeIUMYTgB4PrkxbeHEV8geApwIyhX5WkhBKPXZ3OMe8Vt4yaCv1LY2uhomdOTXJl6wljcAAbuuUpYvornwko3OVc0IJcTauajPSxSGo2iMQwAqOX0ymDSjFfhzYS53ccdAYMEJgwOJsh0Rbgthl5ktgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZVvVylep; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-591c9934e0cso5942336e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761036540; x=1761641340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWB7I3uOZH2R37zOj0nUgiboN1KhJcfYPAPWQf++YmE=;
        b=ZVvVylepYlIRipIxlYJ7M2tQIKLOhLUf4xj3CX7eETpiUVZ/SF2VzA55Wtt9jwm9i7
         3jlqyQLTYjFlfHGORHSO9eP4oLxhXRzAA95V3mwhyVan97pV2MhOpA15rUv5OlDUgTEv
         rlxvpB1AapIVPOnzJvdcVZNR/juJDS/c5rVmnS2KoFnr2deH2MWcg6RptvXuX09Ucbr5
         hyDNxItrTSTaN9aodWlRoZ6kS/kgREKf4M2iLMheUR1Friad90qBZVAZKuz0FeFXeQW1
         IuYsPkUg4aUfpzQlAlVX7E3+Kp7j3Qc9sFb8qnYVKsCrx1iI5bSoNHusrObEj2/dICws
         w6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036540; x=1761641340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWB7I3uOZH2R37zOj0nUgiboN1KhJcfYPAPWQf++YmE=;
        b=ndoeLyDk8DZbZRxfVjs4prM5qIbj0th6KZ2OxIYRtRYnhqf1q4toGLdcxRlpYyJ1e4
         NKRHNovZEXV0vFw30kH554QSUgkPEXfIncb7+PEIrXb8IMLtTGebDDVmZ0VDLIm/5Q3v
         Mwzq33QZHbBwHTWbakTKDYrMe+ZPQlpJ+s+jZCT3w7cLe9GxWhU8k/Zx3JLfCPbc1Z0A
         +IR0CuzDRQUQkEvM/Yf8/dze2EaOgiHCrJ02yDegOhGr4OcW6LJC25RkRVjTlD2+tkki
         Oy/2aFwMpLMmnU+zhb0J2k2Oq0QDSjekj1Ftptt9vfHTp5gwXlgl+QgK4dDWYLD/+FLt
         ftHg==
X-Forwarded-Encrypted: i=1; AJvYcCW9VonclUccRoKCX8OyjdmbxKSyxmqFQ3Y8svJTxmXcVzvlkxIrmHBTZvNMONcNeIvNLYy9SmZPypOWmYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzO0VNCX17d9d/it0Frb3ZFr0pDliRPekNpYvF7poM95zKXtc
	LXqQO97T0nFXDPxqJKoV7lHlWLGWvmj5k2SMnMXdj4f9RC55AnI4X+pVeuNT7nkrdqiNJzmvmzU
	nDoX07I77VI6w6nHnjnaSO58ToMl4KKOhESD0zC6f3g==
X-Gm-Gg: ASbGncurScOqKS8pQKYTLUtRKw5aI2Pj4ey/Bd88KHVFYkVvHdqCk2msVwZvLiY4Na4
	4w8g+u/HIM1dWx/X4QD6voL3d1+VxAzkEQKh9/iGczihAC4aXyw1P2TVeweeW/I+5zqUhqjeySu
	6lEm7bkFdIjMk5YUpPBVQFmqQ71J59VlY9ryqWVlVtEy0SRWIqVMHIXPDx/IvCLL6DcsySN36qP
	OWdVqXZajsDGFnBlKFUrLLxgi64pe6ealsNs8fkATczgjo2CrxbVTJQVFjzSwY91Z8Cuje+3dGt
	0IZ5wgNMOj2IBMb8YjK4f6bNh2A=
X-Google-Smtp-Source: AGHT+IGhse0+b3CMkpG2vCzGWzQdyEVQTxsJwBmPyyMaoRdINy22RkUY/oSul+AvEUV91IDbfefUY9oqSpF1cwaoD0w=
X-Received: by 2002:a05:6512:23a2:b0:58b:15b:21df with SMTP id
 2adb3069b0e04-591d8533c83mr6150254e87.32.1761036540599; Tue, 21 Oct 2025
 01:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013174319.GA847155@bhelgaas> <20251016163618.1355923-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20251016163618.1355923-1-vaibhavgupta40@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 10:48:48 +0200
X-Gm-Features: AS18NWBHxy0Kh94MMHCmN-r2YbyHV5c_I_gws2Hy0s5QMWm9HV2uo_-7iwXoW2I
Message-ID: <CAMRc=Mf4FnBoZfdR3gG47te=X53jASzb6MVnUmNw2q1rtUwxzQ@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: bt8xx: use generic power management
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Michael Buesch <m@bues.ch>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:36=E2=80=AFPM Vaibhav Gupta <vaibhavgupta40@gmail=
.com> wrote:
>
> Switch to the generic PCI power management framework and remove legacy
> callbacks like .suspend() and .resume(). With the generic framework, the
> standard PCI related work like:
>         - pci_save/restore_state()
>         - pci_enable/disable_device()
>         - pci_set_power_state()
> is handled by the PCI core and this driver should implement only gpio-bt8=
xx
> specific operations in its respective callback functions.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---

This says it's a v6 but I have no idea what changed since v1. Please
provide a changelog for every version when submitting patches.

Bjorn: does this look good to you?

Bartosz

