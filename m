Return-Path: <linux-kernel+bounces-757163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ACFB1BE7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F937AF522
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAB1C84BC;
	Wed,  6 Aug 2025 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UplxV76y"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC419DF6A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445297; cv=none; b=tIiIP08dP23uZo3JjG4ScSHpQgsvuOqRU5qXS2ceRW1BVy6GeVUQAosxatsZJsyEx1tyiv9VJF5bE+SBK4uh/z5mFP0137ezHrTZBr6pMLP8AmL5GSSDbZS/Q1+S1g3I7gpNud2dFBlZ867eEyCOVoMaVlBR6FghDiia9fXOI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445297; c=relaxed/simple;
	bh=kQQnVC0izYvjXyrwC7oXu9KciKX+b5K//bAiSMoT01Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A33aQaJhU11PvPsOWZMWMkri8UsGX9uawqs5EIsHuegaRDpU5BborhvL2Czx4gyhAMozIO0dAtlmS83ld68Dy3KhkPTcHBqU5prDDHmA8ldDfMXpsIxjhfo7fUtICjsoBJio0oHfHtkffunpGgvd69hecprGIXBtzO1LpMWrHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UplxV76y; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso9623971a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754445294; x=1755050094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1PkDCTaXOlCgVfN+O/OMDhLH2gXEH5igacRG1rqZxQ=;
        b=UplxV76yN2gbq+P3s54S4t31K4nY8zSj9LjyaUmLUWVWVNH4Hfm/KF77NfrfAYbCSS
         pJGfwX9fgHDt9/Ul+XNWdPyJolSCvqozRrfyY3Lj8QHtgTjFo3i2Rfx5qfrItH43NhAD
         x3Ee0ULrYl7pIUlVOD33r1j/1OClaAPb/20YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445294; x=1755050094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1PkDCTaXOlCgVfN+O/OMDhLH2gXEH5igacRG1rqZxQ=;
        b=wUBHZIG9XpXRQ6tmyf9LfVIwiUbPBJCFt2Nw/jLzEyjJg9EwjxVkOlVdA154vrgUMe
         5xyZog/Dxnfzs9qinWnqxW88kfgXdyUtk0HIrtB079zdbaP+UeEVVZvCb6sigsc8stL3
         3KEviqHVIhG7AMphgJKNZJsn3YjvDFrTPN7S2doYnR4yv7CJp0iVV69bIRc7l9UFl0B0
         EOlLCgys3jBcl8HlHxiveX4lcssVUWKfNzEOJ5x7CHrXcK+3D425m9i9alnkaTOnbLu8
         SYPi0L+0VOK0VsqHPC1WRgrpUfUAj1kmumadA9mMsHiCvAEz2Gxpd7dBcAAS6izNWF4W
         DmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6rmnOYdGl/fw7RHP3Tue8ISnGwbvrZE2TNyxb7zIXNxtg7dCLwb7qwlJq6nQRZNutCmTuua3TOhdT19Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFzyj9b3q1Qtn+rN8Jw2fuaC3Ffe1aHFqlq6yskKweVyWLBeY
	QFnsoGcgVHfX8RYb4fQtjsZ8aQCtsJ0knidJXeDgVXkX88nf4r/Y0JppjhWSig54kXXkf7z0EqD
	pB5KGNWC1Pg==
X-Gm-Gg: ASbGncvTgAhOlHW82vFYqqMr6BO0FgF5ltvHiLUnnhP1PN+CqVW6VgrT0h4GBSyyyRe
	iW9fayzoo7idkKrkCGb9f2HHbsansNECFmQ4tr8QEgbGo8zHxfP+NEnAC8W9Frb8oQtPJTphF/Q
	WYVeFcSzzXlt+5hYss8uHIfCFljIfjQjcAMoQ6bNDZXhB36FMFRssFViHIw+lKkYP/s/2ad8PPg
	M53Zzdveh1bjbbF5gafuHFqj3RpIduvc64JCmHiVH9diy9lBnUzluzbBEgQ3fsrJAFN908vuy3/
	cI3/38hqiF59GXuaq374lGxLo4d48UYFRMwZoN7SuV8aQqRTL0XmfPOsgkrug/piVnulk/RMtD8
	ZAMNjPeMByqZBSArs6gmpZZvfMPsCTsTITabuj5tX2YRSzcMqMP7WcYHsvP9EJ/y4vu12kZd0
X-Google-Smtp-Source: AGHT+IFlJVbiprbzPyoCL9/yQlHoB5flpgbIHz+c9NYRm+Aw3Oa1Zy4MltvuRqUiqeXL720iIEL3dw==
X-Received: by 2002:a17:907:3d8f:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-af990294e51mr110998466b.15.1754445294069;
        Tue, 05 Aug 2025 18:54:54 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92b650c8asm862304166b.65.2025.08.05.18.54.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:54:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11096339a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW8Sx0fJORBZEBQMf8mycEY2LHF/EyM3iw4zY/XpqPxA1RN/18ixO2izpN5OROleVT/Xs351OWLgSP4hI=@vger.kernel.org
X-Received: by 2002:aa7:d64b:0:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-617960b2169mr747725a12.1.1754445292221; Tue, 05 Aug 2025
 18:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com> <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:54:36 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
X-Gm-Features: Ac12FXyVcowt5QK4YaVtsfApiqsjcc5RnE4u3G8HT-dXMHsAGYoNHxft3oIBLvY
Message-ID: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 04:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yeah, the attached patch also fixes the problem for me and makes
> more sense to me.

Ok, crossed emails because I was reading things in odd orders and
going back to bed trying to get over jetlag.

Anyway, I've applied Ammar's v3 that ended up the same patch that I also tested,

              Linus

