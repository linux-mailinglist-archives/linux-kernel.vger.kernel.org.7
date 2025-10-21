Return-Path: <linux-kernel+bounces-862875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411BBF66A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25D624EE267
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3093C32E681;
	Tue, 21 Oct 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="POOJgygX"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB52F6590
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049300; cv=none; b=uhCoQ1p8mK/UG9byF1SO5vwykeRGkVLKUWRrP0Qqm46MhNLw+ei2Hj59dFFF9Lc3SEL7pEp84vgLMLlzYfERX3sU15cQxf8hX2Qw24YT4PdKykP7EVIiLHHGaBCQ+L2T1LR/ZMuJRFVPJS3bt3Iz6iO+XGnafzTuq9o1mnnutOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049300; c=relaxed/simple;
	bh=p8PoWDUe38GeATBcrEhBoKdXkmWRLxhum7J2BWfx+1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwbzRySaza0wkMnOEob/ea9w40gkWQs6ovxsJhRGyriJqfIjnI1NU1YSuc1LmAF2EuC4wTouaKxwLJi2PHV+Tnr1k1x1TxL+FgcxewqOcovOO2T8rcGOsFJ1oA0IM65PaaDvuGYMwoFpVbgx8QhlZMXTdaOkpohB69sTiK/5uws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=POOJgygX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso5087488e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761049295; x=1761654095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8PoWDUe38GeATBcrEhBoKdXkmWRLxhum7J2BWfx+1A=;
        b=POOJgygX1NCgRgBFU0H9mADFXmU/uqRgGTalPpj36SiG8iUOzbyvU7xegmcWzCzSxN
         /sv9xc5TLlaoTCNMX7XhOi6mQad/VfvA7mEw4YinsKWhVJbCQnYaVyOvLY4hdeMA0hex
         1+iIbbGxistsgN6KGktwm/DPJ0kxE+id7BiRSx4CR00b2r4lTESZ2y2/d1LDScJ/B9yy
         XsMAydr7Rg8VG9bbwQS7lYMFYhvQUBLrqkS36vadgeVHMMgp3C0A1rrrV+jgBXtC2iGq
         fYj9Z5nwACemhoQuDSvttiwPwN7SHWnsCTygiaTxsBE8sW0ayMxOt5vArTkUX7LYS/fM
         mdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049295; x=1761654095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8PoWDUe38GeATBcrEhBoKdXkmWRLxhum7J2BWfx+1A=;
        b=TF+i1xYdU0QDJlnuWql8oxHjDyZUn1dcHC+tszAgnLa0ys2CMK8K8poBSMICMsy+5y
         cWFzrz6D6ZSRNImJCw0B7FT0y7hoj6Rm7/B0rc2pWzRm3kno6rQcOuoBv5T70mnZ0bMJ
         rC4Qs/cghevwiPmYDFYdK5UCRnFWut4n6WY3zCZPEaLf0UMidBg0B4qlJ7AjxAbQgjMc
         qvGBldo5GMJibmf/6UEXTYR/wLWmAXBQu1eRqE6lpb69hpVxE/IVYHub3zd1dDqnfU0V
         DnO+Gb3dDj/gWoMYsFGwFcdzyWMj9aC6EkgHZXZSUlKaZ5C/TWYW6zJf8R9CT6qCY9KM
         iHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXUS7yIDsx3I2G4o3flC0fGQ8SAlk40Y7Ld15Pgfu79oB6f0wd2oN2CGnIwVDOpToG3lAti5a05XeUEFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKI3JNuUexywOvhST1R0dklm9WJRE8t5p/2iCHPCnLHGu4LlW3
	Wy2VsyqSYjzc+LFH0PxEdRc0t2lHjTVTqH6wZcPcwSaRB3H9drHwiuoMiVnZzP5PjatcowsQNib
	n12CAdNwTy/2PaSVVhPXEocVQsYZW+xGeGjFqpudWYEWIUxWvTttcmWk=
X-Gm-Gg: ASbGnctSTvhDMYDy//HQ3kislJMiOeGwjxRHH3pC/RxcZ+bjmqfqd900bjGKHDul+CS
	ZIANGdEflDTVfoSHUZGN5waYqCSLFCppPVJWyeLZ9sb+BXsfwTfPnIY0PyRlyRYUGzcG0v5A2l/
	BJVfSrAteSzpZduN677NFqQWAlZ9XJa4ueubxrM2uLGCDIGilEsabKl+5/na+3EWd0Z9lJh83IU
	0Ggu0bA73qboE0mgvzSRtva3up//CaKA3WEPSqbSZxdVwbVqhqHYp0KVoUfgRT2oKUgHDLGipD9
	bQFEYqgv1ClmSZbQ
X-Google-Smtp-Source: AGHT+IHv4TglYoME9k8y+Cf9kIURaChu7OTeBga17eJoWa/HSDvZHHqbfu/wH9BS05ZJ93heiZHjDByHwbia9lKViz4=
X-Received: by 2002:a05:6512:131f:b0:58b:151:bc0f with SMTP id
 2adb3069b0e04-591d85aa254mr5050304e87.54.1761049294940; Tue, 21 Oct 2025
 05:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020115636.55417-1-sander@svanheule.net> <20251020115636.55417-3-sander@svanheule.net>
 <CACRpkdaqXzogkbcnR3uaDeGFcVtwmUq5DbETSqzjVQECJROF7g@mail.gmail.com> <77ae9012af0565fe64e585043541081e48627566.camel@svanheule.net>
In-Reply-To: <77ae9012af0565fe64e585043541081e48627566.camel@svanheule.net>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 14:21:22 +0200
X-Gm-Features: AS18NWDHq2YSNmXMDRZ-1n819DAV0BzEWNWF__ppzibzJcFlIacaLF28QFfPKf4
Message-ID: <CAMRc=MdzjKfhc5vwQVVg=VwCNJ8iMaH5RY3ky1uh_Kxo9gdv=A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] gpio: regmap: Bypass cache for aliased outputs
To: Sander Vanheule <sander@svanheule.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:01=E2=80=AFAM Sander Vanheule <sander@svanheule.=
net> wrote:
>
> Thanks for the reviews, I'll prepare the full respin for the RTL8231 patc=
hes and
> send them later today or tomorrow.

I take it, you'll include these patches in that series?

Bart

