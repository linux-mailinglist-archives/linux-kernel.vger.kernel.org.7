Return-Path: <linux-kernel+bounces-843394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7FBBF187
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7752D34AFF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C181A83F7;
	Mon,  6 Oct 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ME4e2KPN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13C78F43
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779011; cv=none; b=janVF07pVfTkNHz9aLyfg+fmbdjVLidQRVYrQA/TgtCP7l2gCvTBSCfu44/UW91exl1hy44ZLjwbd8lKY68qOiIVrZnmVt1Drp1WfOAUkfhZ8QG6RcSqrEIJQH8KA4xnGjItOzNUea6GDZjwdpkm/ioercBMtUGbzflmS60Pm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779011; c=relaxed/simple;
	bh=oJtnpIg+R+qK4oiapz5pJH9B6d0O7u0uKM9fGnb29to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AICxqX/JBR7jzc6WDdvBXhl9XzjJ1dmRt9nDyCGTctxtlMC7JBLoMPoR2l3fqGZ8qi+gpGpSVuh0kjW1PpvlSf3ipMyRvsNoD8w8wvWDGaA8R3zdWWacOQvjraLkFifctIJ2KhmLO/Cp0o4JDKbwFXyAoFlRV2sEBQwFa59jNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ME4e2KPN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b403bb7843eso1096171466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759779006; x=1760383806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fx1K28q8EZoOq6NcrsSqSFqNryQpu7AB3eVtIUWzySE=;
        b=ME4e2KPNFiesQDZAgg7zYJ1BVDkGkpF3lHlN0ZWY2R4sX+AMB/sm6bTPaPSkzAceyQ
         qIMcK6VJPyuIrNJecF0pV15+I8gXe28Qv6i4EZkbI9LbdVTivXRgg5vonQgVdnlQgHlY
         MT1c1qA+1Wa3qzLiN1iBpWvGoUXsvJQ0a2mKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779006; x=1760383806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx1K28q8EZoOq6NcrsSqSFqNryQpu7AB3eVtIUWzySE=;
        b=mmrVpmrZxMgG1iFYXSFKS4W95QNwAg6DgTQXCYbt0WFj+hy2dEwISCpOetu6HjvZaK
         UppUNf15/FTNFctzHoF0Eiz+J3hqdPyQ04SdDMKuroyvZdTNoUD3R/UJzYjNQGES/trE
         XQDIV87+C+SyddIQpKX2Fs5BabNVJf6jWsD6kD6/h9tBF7f0H6oXkbsctIFpJ6U8oguX
         pmwyq569WGhcn8YAppYro4rMJ8ViYVxzp9oqSPnlS28EmPLolAwY9wm9M+3YxiY5zaDl
         YJ4LwG5X8URWPobHW3TG1ANO60Wwn6VUVPtLVdesc0IrwqHPHWnQ28M7/ZiXPWGGcYdD
         5EUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrRIARkmbXk12OjOIDQaqKSdl1QGUN8JS9gmWtvZ7G8oH/AAIM6OK0t6zwzTHjehWaPbkY3zCV8Py6nUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5oj4JjSP1cdpkiWBAe+b6kGzxSv0Lch1yqdyCHDtfc97e34y
	mq2s3yT+6r3P6cxV62aVTUKp5snCuUMle1yVbOCY19PrAdbMOF77BTlSGc4BtGIDScvCPNzx4fK
	VqbruPy0=
X-Gm-Gg: ASbGnctUa+WEGXgz8hYgXn5Ekjh3ndrAeVJnFum+QNaZGV0EFDEsPCFlEYhatzNDDwy
	7hRoOcV7A42mrO/tlpQhjOhJ5uNg7emmQuiLvdyvEssHj8cTDD/dSFcdPseW9HQQe78u2XIdIyN
	Ha2fOWoos2Vz5i+5/IKzj7QCu/8tHrFHX8F0XpHzK9DGHICNHYiHBS1WVd9hBiTHT52+ivuddT5
	6xLEvZOEzFqzw0XCNaT6WVxGgdX1GYy7c8GIIBnHVhnwrSeOYTsgKnScYrgN5a0lhLxsROR3UWf
	DerKexsSvIUK3tK0L5rRIIgL1lGJb6g9/AOJR47UmqnPnxwZXzJcTFAtH0ZLXkHpwuesya2UJzo
	PAwvKfdzWEyeYu6zYd6RJ165lZc/h6lQu8UfUR71Sfru0FJ51lWlZhx8du+eW03gfrsh1JmrKB9
	gJg6Nj+1EZ9MVMIRcdJVBdOvS2XxCqB/Y=
X-Google-Smtp-Source: AGHT+IG4+CKVXFpw8mNV4T0V79bh2Rbv0sduTeLWbwkGbG5p+BpjdT7KZZBiwfgSmOJKhoVBugzdUg==
X-Received: by 2002:a17:907:9627:b0:b44:7c83:cc1 with SMTP id a640c23a62f3a-b49c47ac895mr1688411266b.41.1759779005983;
        Mon, 06 Oct 2025 12:30:05 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b37bsm1232045866b.53.2025.10.06.12.30.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:30:04 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so8197203a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:30:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtIuBqnInNR+HjiSd4Q5aopIwJwofVE6N80bNFjfOQr/gSOehUdrnPvrUI51RSyMsSwveyYBYeyOEtKAM=@vger.kernel.org
X-Received: by 2002:a05:6402:3508:b0:634:bdde:d180 with SMTP id
 4fb4d7f45d1cf-639348de6a9mr15286102a12.10.1759779004368; Mon, 06 Oct 2025
 12:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIirh_7k4SWzE-bF@gondor.apana.org.au> <05b7ef65-37bb-4391-9ec9-c382d51bae4d@kernel.org>
 <aN5GO1YLO_yXbMNH@gondor.apana.org.au> <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org> <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com> <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com> <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com> <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
 <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com>
In-Reply-To: <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 12:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7TAP8fD42m_eaHE23ywfp7Y2ciqeGC=ULsKbuVTdMrg@mail.gmail.com>
X-Gm-Features: AS18NWDFEycobIg3uvQ3ZOEKPRIEa2VRgJ-r9kp-mkVxA6gr2b-Ogc2Dp8E1ZOA
Message-ID: <CAHk-=wj7TAP8fD42m_eaHE23ywfp7Y2ciqeGC=ULsKbuVTdMrg@mail.gmail.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, "nstange@suse.de" <nstange@suse.de>, 
	"Wang, Jay" <wanjay@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:12, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Yes, thank you, I've already acknowledged that my patch caused boot
> failures and I apologize for that unintentional breakage. Why does this
> mean we should throw fips=1 in the bin, though?

That's not what I actually ever said.

I said "as long as it's that black-and-white". You entirely ignored that part.

THAT was my point. I don't think it makes much sense to treat this as
some kind of absolute on/off switch.

So I would suggest that "fips=1" mean that we'd *WARN* about use of
things like this that FIPS says should be off the table in 2031.

The whole "disable it entirely" was a mistake. That's obvious in
hindsight. So let's *learn* from that mistake and stop doing that.

If somebody is in a situation where they really need to disable SHA1,
I think they should hard-disable it and just make sure it doesn't get
compiled in at all.

But for the foreseeable immediate future, the reasonable thing to do
is AT MOST to warn about fips rules, not break things.

Because the black-and-white thing is obviously broken. One boot
failure was enough - we're *NOT* doubling down on that mistake.

                Linus

