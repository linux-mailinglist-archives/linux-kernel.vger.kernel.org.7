Return-Path: <linux-kernel+bounces-772986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02948B29A34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84EB5E2833
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74F27817A;
	Mon, 18 Aug 2025 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DpxzcZZM"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71F214228
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499958; cv=none; b=ObGVaDafw/160a1F2pFlPf2PPvb7WdiQ0QrKZ/lYABGgACCddV7gvsIdNkkDgF7VodBdpqGql0kxXgT5OhGslqyPwp9zgvNvse3SGND6XTFpkjLnwdpBZmz8hjleFSDWqKzMxPw4eJauB92P9b/rMxchDCbc+nJKhSUDOrS0uig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499958; c=relaxed/simple;
	bh=IN7kYnIID3443ooQB8DzAtrGSGeD4IzBkmmObpX1OWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj7HkytXRUg9/XF62HcY4X1MO5sLW6yQ/TnFoVkqbHUOo6MSjO1cXWhg4L4KRcOAoy+MAi5YtPknoMi4Qf4sFZbn/MVj+alsI0DO5Qqu6utGytncw3yVFYhUD7dY4/986+dly5xgyPFzt/hSSobnG+g+f3YyZZA9TNGJY6GGOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DpxzcZZM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so2711949f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755499954; x=1756104754; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB2mYWsk8i1r7WgYGZCAEJP8BRkPAULzUmje1GZdi9E=;
        b=DpxzcZZM5GDGlh6oMaqxRpyCINAXGHSyq1eThzLFUFJCIOFfV8RidX9L+IzxAGQAlV
         wY3oU1jfsre0Ljg59skHeD/AeGoIqmMCoYzisqrX+Qlo//cIWbcEQ2XTa78FZzC0GGua
         XxOx+DK2jd91NWPgK/ja/07Od1n3/6eVIxJ+42u4wu80OxY1xDoVFHgDVhl67rQmu84z
         NEb+kmVOjSng0TKOuoP1G3e8t22eeDSpGBL6SuejVm8UE8nYbmaqnkJIcFQmASYdHy2z
         A1x5tEklXY1lJ/mo2TCV1ngLQ6OOmjm5ROvq/QLS+Xu61uZlCu0uPFInLRKyCZrJALXM
         W1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499954; x=1756104754;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB2mYWsk8i1r7WgYGZCAEJP8BRkPAULzUmje1GZdi9E=;
        b=DOg0bq4A7+RFXrEf2volqoAyJgMbfUsEwtFcdNfAJ5n5xHHaSUZsuJpaM/NJejOdHp
         fMIE+jGIQv7DwOCwJeS1Dr8cpNP3LYtC55sBxN8Khd+uvspDTFK2nbkUE937rD25Nb8W
         I54v1VKRg7nmTSFU81UxOKN0bG0WEm07jk+G4imf+rjFlHtLQ60hBT4vPHhhYXGdbV7t
         QTavB8cK4cO3P5IAwPeqN4tQ3XMsaR2clJSSm0BUnrW3Fy43tfwZ/Q1ne2CG3xq1mjIp
         /35ROsQnAbS/wTUxgo/9lgwVnKBQkevuklqv/R1PtJYpOxrWKfey+O5VI5QT4+bTebKK
         awug==
X-Forwarded-Encrypted: i=1; AJvYcCXe/WcxG3URmwyn7AAvBchtjmQSR+Bhkl1DC+DcZ2S6EoSOc/mOzRAovRo785WP9Vv2HXCzdThdW+L6W1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA48dMjogE/XcdHi2V/jzYVwimVPEdkaXOrIj8XG48avYxGKGy
	3mN65xCunPOsAtG1OHJRJLPhE7hIfAvHagzsY23UJa8tYiEVgeRU643jSDR+vCDmlcsvoYu5kpS
	gRjNEJ0UmOA==
X-Gm-Gg: ASbGncvFeduXojDbaqCOdDa4sOyTC8PtNVrNgyJ5LicwRbuJSPb/Xj5g0wggR+PSssW
	T5ZpSAy4zWtIdZvVJOIwTgojPEqF+bkUAbeN+Jwl3b3X7zvBu2fVX9Yh6HVC9E1QenDJKFTjDrC
	43dk14q9pigemOz9UM/ho4lIVzlIzvN6i6etB2WUtgcULF5xcI76HCZlpyndJ0QigMXDlCOLYp9
	mHx2V4cwaXn8+5PD5azLVeA0sWvy4suoK5jDMC+9wc6TXUzFfODfdIHPbBbzNy/wXdIzB29hmp5
	dsXO/xOoz+OEEniSOIisJBIycwJIXHbkXjTmSTJw9zuTzn3svnGjYgvzmD0co/d/PEFYZPrSRMt
	VVxaxOq7rRw53dVKYrddeJS84ETxgR4yoNMpTKagRTCaR
X-Google-Smtp-Source: AGHT+IEeFi+9SxT/8qFVtZnUAEDFzxELnBb+QJjoFAreV6LM14RP2SHQViOexOMNOrwtc7eKLNKieQ==
X-Received: by 2002:a05:6000:2485:b0:3b7:8b2e:cc5a with SMTP id ffacd0b85a97d-3bb68cfa43bmr8155176f8f.40.1755499954559;
        Sun, 17 Aug 2025 23:52:34 -0700 (PDT)
Received: from r1chard (1-164-92-102.dynamic-ip.hinet.net. [1.164.92.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566f8csm6312933b3a.68.2025.08.17.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:52:34 -0700 (PDT)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Mon, 18 Aug 2025 14:52:29 +0800
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text
Message-ID: <aKLNrRzxCOqXcWMq@r1chard>
References: <ed9efeafd80e9827bcc028d20a5bb20653af68e7.1755006858.git.geert+renesas@glider.be>
 <udidf2skqwbhx6mg4tmsxuipqqgh4amwcxvbjdrqs5g5vla6xp@7wiyrojpjok4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <udidf2skqwbhx6mg4tmsxuipqqgh4amwcxvbjdrqs5g5vla6xp@7wiyrojpjok4>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025/08/13 10:03, Gerd Hoffmann wrote:
> On Tue, Aug 12, 2025 at 03:54:29PM +0200, Geert Uytterhoeven wrote:
> > People not very intimate with EFI may not know the meaning of the OVMF
> > acronym.  Write it in full, to help users with making good decisions
> > when configuring their kernels.
> > 
> > Fixes: f393a761763c5427 ("efi: add ovmf debug log driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > +	  Recent versions of the Open Virtual Machine Firmware
> > +	  (edk2-stable202508 + newer) can write their debug log to a memory
> > +	  buffer.  This driver exposes the log content via sysfs
> > +	  (/sys/firmware/efi/ovmf_debug_log).
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Richard Lyu <richard.lyu@suse.com>



