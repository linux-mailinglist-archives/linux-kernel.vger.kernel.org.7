Return-Path: <linux-kernel+bounces-728106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92158B023BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23BEDB4577E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0172F3C36;
	Fri, 11 Jul 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Unc4eNq/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F442F3C1B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258813; cv=none; b=GpOwBcU7viWF4PFPL2uY2thpmbGFaLvCnPLwK5j3OMB//D7XV5bkT1LIjqNGG+Fr8k/sP8CD9XezQdRcBiQYwmit37D1Zy/JgHdHfEcrxHfA3iTYgS+1aFrxtROpramRLH62TJITdtOB9o9mUOeIlw2swvG1hkgwmnJGPERAb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258813; c=relaxed/simple;
	bh=bWCC4ZoPLffqwFBCGshYKFXjSxX0H1BlPT8PIH3CjDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GygF2wpto+CbQqy6NcXBzhlgrDKggdz/yBHkr46mNbP0sxX/36SXyR3eaGb83DMXHveSmnkJ+UmWRFfJIcxgK/ExlYiY/QxfoLq7JCKYaBhWyE9Tqh7YDPb6Fq4b4H8u0z3zX6eAjDf893gbUUagLNOrP99Zjfkiu6YK4aowOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Unc4eNq/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so471419666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752258809; x=1752863609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkiMZ2J4WWxAe30Yz9eXRKes27bISK6iOQFaa/jG/i8=;
        b=Unc4eNq/ltpEup6WB13kLDMZh+EEbnYwSNKiPtqjd4cAi/lKD59yzh+eCMBbTW4A0D
         hn0RBaiBadQ9bVyq/fvK8rAYhSEw+bZlhFC9aV+ZD1pgv1teJeElN8isRdLAWauXkoxm
         YFOISZynAlU1mLzXycae6AY4Ci+rN0qFcMxtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258809; x=1752863609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkiMZ2J4WWxAe30Yz9eXRKes27bISK6iOQFaa/jG/i8=;
        b=ryMMJrt7cZ+dz4GmhvJmMA1pqZcN5o4WjRH+SOlPQCA2xgOrmLyMTGJtc/8nhOq+Qd
         zn4Zw2y0sHSIFHGdkIc+jCmpvwJcZNudWt7slQw3ldd3jKFu3vUtX1/QmyhJdf0G51sj
         mB/D1ySDXDqVpeqO0tu9hUaMxelHwhx9T75vEI0Bk7m50KmDHHrV/+POPtMi+WuhfrBt
         qUwTFFzpjSuKcDxVRTGysTeGwrdOvtKR14xkiH/lYyOk9be4yRJ/pKu8rJuYZ+TpzZo0
         Dy8c5LDeWaH+Ifa2bNU4KZsIQ7b1kGBe82jmlaa3dPE2wt8hDtHNdHrTb6FNVXwLfbK7
         7+pg==
X-Forwarded-Encrypted: i=1; AJvYcCX4FV3qoi4QuyYrGt6DLMB387pqFkaT8NIlefny9Zwdeai6Mku052rNQMD2WW9AlrG6vT8YcH7nThjBPIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlOYUo+QOGXmwgIcmApP+dNFocElCo+lsoSUaX9TEMBx+sirQ
	fnO0Gxup4+kc+o2KR/uCXqbUQSQkiSEILqJ/BcA1eMaUgobHw3VM6mRMHVd4/ZiIyPBLlYKv5Ih
	VQ96gsRtJsg==
X-Gm-Gg: ASbGncuA8QAd3GZQKwhSdv0Sv2B1qoniKDcsaxtVGGlEOZ2Ons/x9qPmHDRCnwwk1Yd
	smODzTyxgpkUOC5t5d1eBKdLWQFokvCztrDaH9kplU9y6VTak5DwwKLTSYhx6xqNHVM5P5ux8Vt
	nPMLc0NljJ76AFFWnxZsQ/0vOBfhdHgR/NrR8b4j2idOuyWWeZoZxeG/paJ/brwUPIH8n9Fb21F
	H1Zz6MSvGuVv8U6CGgAUeLjA0nWfxu2JB9FktyrtjzCblDubMotDzh3sR4DrBLY+ts6vE1ohcwL
	nYKPVb0nuYBXn6Mx2rJHoSYH7hFs9gbOM23lJOXm2QzVrb+3jDWdoSrkxgT8MkQybZdl5tOHBJ7
	BmnNV24GNlNS/WeSefobPJK/62jjjae4vfuyFVNymuxtv0QcDA7z1vIPRm7YfPzzmsYe47TDy
X-Google-Smtp-Source: AGHT+IEsG8smEDJjGW8sqLcXvOn38QtGKoJMpF93dQWfzU2EThoHkVIQxP9DtGiuVfJIPCM9u/KZDA==
X-Received: by 2002:a17:907:1c1e:b0:ae6:f163:5d75 with SMTP id a640c23a62f3a-ae6fbc13d77mr427603366b.11.1752258808828;
        Fri, 11 Jul 2025 11:33:28 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264613sm340569566b.91.2025.07.11.11.33.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:33:27 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0e0271d82so434832066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:33:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYYTgjYh11vPcUGsTwg8XBQ/CkB/uUM6aTWDm4kiDtoOT1qOk2BRBTXb18vzxnSIaocs9jPtlXS+gKfXw=@vger.kernel.org
X-Received: by 2002:a17:907:3e95:b0:ae0:c6fa:ef45 with SMTP id
 a640c23a62f3a-ae6fbf96592mr483791366b.41.1752258807150; Fri, 11 Jul 2025
 11:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org>
In-Reply-To: <20250711151002.3228710-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 11:33:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
X-Gm-Features: Ac12FXykIL-Mz_Bqw9_dzJEakCBd9Y2pyk80DOugpUKw15R_JJAEpkwfYZHB3M4
Message-ID: <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

[ Added in some drm people too, just to give a heads-up that it isn't
all their fault ]

On Fri, 11 Jul 2025 at 08:10, Jakub Kicinski <kuba@kernel.org> wrote:
>
>  The Netlink fixes (on top of the tree) restore
> operation of iw (WiFi CLI) which uses sillily small recv buffer,
> and is the reason for this "emergency PR".

So this was "useful" in the sense that it seems to have taken my
"random long delays at initial graphical login" and made them
"reliable hangs at early boot time" instead.

I originally blamed the drm tree, because there were some other issues
in there with reference counting - and because the hang happened at
that "start graphical environment", but now it really looks like two
independent issues, where the netlink issues cause the delay, and the
drm object refcounting issues were entirely separate and coincidental.

I suspect that there is bootup code that needs more than that "just
one skb", and that all the recent issues with netlink sk_rmem_alloc
are broken and need reverting.

Because this "emergency PR" does seem to have turned my "annoying
problem with timeouts at initial login" into "now it doesn't boot at
all".

Which is good in that the random timeouts and delays were looking like
a nightmare to bisect, and now it looks like at least the cause of
them is more clear.

But it's certainly not good in the sense of "we're at almost rc6, we
shouldn't be having these kinds of issues".

The machine I see this on doesn't actually use WiFi at all, but there
*is* a WiFi chip in it, I just turn off that interface in favor of the
wired ports.

But obviously there might also be various other netlink users that are
unhappy with the accounting changes, so the WiFi angle may be a red
herring.

            Linus

