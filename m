Return-Path: <linux-kernel+bounces-895383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDCBC4DA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 576644FC732
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEE3559D8;
	Tue, 11 Nov 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1XGru6Z"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E203587DA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863288; cv=none; b=stQtOSu7KOJaU590gHPvahzCP5Emh3ehk+OR1BEDWwV6DgQ3AcKiRAm1raXvVmucU05HgdQu4PKYK200a15oeTa07if3UBHPEZjd6ywgoGznOnU5IvOCFZPfW8bk1j6dxHa+9zlIBiDzd4o0S089WIWrT+h93KthONCvrmBObk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863288; c=relaxed/simple;
	bh=Cm8DAlkq7cNB7eXK9B6TWRGj+2lGvxbjXLY72bWBOVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl4gLOh2h+fjprqh5JL02ooxDd9pynObhWk1NVCgr5rN7/NtgXV6Mn8lAETdpdzfvJ6SrNcMP0opheMonsC7I9P5pbOklNoWJ1NWnhihe+3xKw4LC+Fw8ssFegFZXCN4bFMlSrJ0nhYgpWfKWfc/BtsUOIq2VFyag36sr/4wqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1XGru6Z; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78665368a5cso38933257b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762863285; x=1763468085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfV4LvtG02pkcZqmjoIHQyje6DoWRqzhd0WA5bSXwjM=;
        b=k1XGru6Zb+68rKFkN+KDaFu9/e0bdsQkd0JiJFW1ra9VxV6KbmLGJK3ohRK82IEpiP
         z1jbWu0smIW9hcgRORquFXHpeRteIgZc+tPZqGG2SYBiMDYbXpbKlr8x5JWM/Yiwf09p
         aTresM6PDHBE6E5GldMSyJjAIK6/onJ0ZtWWWcWIyH3KiBbcEhQjTXUIb57C/BQNAYTI
         v2nbphel5etTasaYb4vzQFrSC0R4oezrndpfDvsJJkRI0M041S1d+9eBJYL/1mT22POI
         Wgec/rvojtsUOANrrnZf5aZ8CoBjJIQz8uwzp3K0EQmdI5hre76aUsGMdAYzauBePjUm
         j19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762863285; x=1763468085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfV4LvtG02pkcZqmjoIHQyje6DoWRqzhd0WA5bSXwjM=;
        b=HEwkCg8uxQdngfhsp2sfIr9uH1S4lDNTaqJzR9Lej3NN9/eiQeQ9WXnET2gXFuSVIc
         bPseWBDmhmQUBEU1RlYnX/pzdI2eltf7UYOBYmfTJH1SwhRwvf2WXMfGoKtQR9Fi4qYF
         ZGZSb7iKrLz30bo5MNVS55ilL+bIQB6fS1rf3tz2Vo+Bb6a7l5IuJa142PiWgFeEcImO
         BjOPy710E+k5cBf8eKTueiqMqM3PAL90sG+Fgr0DG0YP0o+srqOUXbvluftpP0aNGNUY
         Q8qhFx/wPCriuqrc0hMu8BjwvIIad4LANlW4sBmORfFEgnarbaBnCuK47d5Pp9y5DvMo
         56Lg==
X-Gm-Message-State: AOJu0YxIgIxL6Sq3+DW72NPx7MpEXpIQ52NsWF9r0z6UcjXgTGwBJ2IA
	K7t7Cr67vD6ryeoJOjMZXtw57mzk+W+nzaMLVcFuT3aeiaHcZX1DcLIgClsZSCYABrqgwU1Wr4g
	aVh6mg38kr+eICS2mdDNSXmpAJe2QRIKQvAbGLqSgLw==
X-Gm-Gg: ASbGnctUc1IpQ+OwEl33HR1XJY+opYjg8EPDJQdMvhUGg216L2R7EVyzzxtf0wNpCVv
	koyXT0u0gH6Mv+5WHsNe4Fc2dF0TdK0t4UWRH30nbD2zUo00YkKTIPoUqbiFcAqZ8Ge2+8ZNDrF
	50qzwnQiHW7II3BJxGz+PC/GpITcNI3xKmlfevUn/fQdWBLBgiv8ADa5By/QE9JGdB/9uwQ577x
	i+7TvOyciJkluCzcngIy7IEUgcWa3IX0t/LqcL6eBy0PLqUYqEBOIBzl87U6XSy3AB4iXM=
X-Google-Smtp-Source: AGHT+IGzBCxItR5F/c1tm+Myz9Jj9DUiAidCyH8elbUYYK5ed+2hTXSOvUuPWDsQh1/9f6VcI8TQwGH/v+rs7F/04hY=
X-Received: by 2002:a05:690c:4d09:b0:786:4fd5:e5df with SMTP id
 00721157ae682-787d541af70mr109409167b3.39.1762863284723; Tue, 11 Nov 2025
 04:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111060009.1959425-1-rdunlap@infradead.org>
In-Reply-To: <20251111060009.1959425-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 13:14:27 +0100
X-Gm-Features: AWmQ_bmQmQW8jMVRgz5D2rAorGCeiuZeYk9-nDFNHjG3RHER32SRPEoKMrN-RAk
Message-ID: <CACRpkdZFmdicvsr+yhmXLHTJSSrVdoZuVwdRm_3_pC3QibicwQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500_chargalg: improve kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:00=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Correct "bad line" warnings and add descriptions for missing entries
> to avoid these warnings:
>
> ab8500_chargalg.c:173: warning: bad line:  is set
> ab8500_chargalg.c:179: warning: bad line:  increased
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  't_hyst_norm' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  't_hyst_lowhigh' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'ccm' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'ac_chg' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'usb_chg' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:308: warning: Function parameter or struct member
>  'state' not described in 'ab8500_chargalg_state_to'
> ab8500_chargalg.c:773: warning: Function parameter or struct member
>  'di' not described in 'ab8500_chargalg_chg_curr_maxim'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this Randy!

Yours,
Linus Walleij

