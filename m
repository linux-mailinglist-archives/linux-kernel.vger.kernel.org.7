Return-Path: <linux-kernel+bounces-757160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A76B1BE73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72BD18A5ED0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8ED1339A4;
	Wed,  6 Aug 2025 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RH8FgW9B"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC6192B96
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445180; cv=none; b=U4zHBItmoCBRBQNQ6WtP1PlQntlDfYi+xBSXzVo/KFS6R5Nu8RyMdW7vbjOiHKJn3HzqVFOsj5UKjWX85v9tpu1hKL2MjzHXY7UNEH35HUt7FH7FehfVYKKGRKEpq347M412hMq5CZAMKvVJWEzgpTdEqsqzqr0ZoxhhjorIbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445180; c=relaxed/simple;
	bh=S3FRCB5dyGt341bp1umt0ivxV1UsCg3YlGgv0bdp+jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZjWEM6fq3buavkaNfF8FtMfSCaoFH0f/JCUTsHGNT+PubVG3Zwag7k2HgB4nNHNCkv/JnU4CeNOCnW/WvTVEPVRvEo35kQE6dNZSF/ZjUBKcechTwEuhOkMclF/SPYomjh9Cn5Ns+77dyT1SaN1pH6OM6pgQCwHJJCQs3ufW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RH8FgW9B; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso6448940a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754445176; x=1755049976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tLJE1Uv/4ZR1r75izz8V1ikU/bjQDHulX75v/Y1kYYY=;
        b=RH8FgW9BFzWNjejAgwPLiLzsrQjamcJYd2ewp3puCtH1x+iBztvmo/HcNZCBwcSJvJ
         KjW6JRQongZ0cQnC9LNym882y9v50iJk0yKdZ4ZTBNsjH2aVHP7P7jCEiB1cp7/uooYE
         t5UrXbM9E2F5UjBCQV4PMuXMkDSbgto/wbrr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445176; x=1755049976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLJE1Uv/4ZR1r75izz8V1ikU/bjQDHulX75v/Y1kYYY=;
        b=jCCnxS67FLkVfSUvhgcHSjhowYZLCvZYQ7TotW2Gpcnbngt00AP6KCVPPP4ns40KaG
         OlgD4mKiWrkIEWmscGXcpsp8xtleMSV797KM7tlX8Afr71WFRsbV9UgmyX2gjcIFO3F4
         bQN+X8R+Qs/15h2p7Ea7axji4XTTAtFAlJai3In1AcrsK5D6Q+V+yekG7usq8cr/W7ma
         iU4NaHdu3VXkWa7GWA0Q8swoe+x+ROj5BqJSKCvkdsAwQkqtc5KH2vPUHftLDeIBlzwI
         b+yw6dShHOPW0RHjaHC3P48uAMecmWP/wJBZjb3oQ7K9hqP/AKC9UexSZFsj9TEULh3v
         z35A==
X-Forwarded-Encrypted: i=1; AJvYcCXZIT3N0cwTWMGcexp7lqEubrsqfEnb4k4O7dM1vNGrW6Nry1FpSs4lRKwBUKmOgCZTQVdyUvPXXlpXcUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZeqNlSry6Hbll19fHIcdN/BZTzimB6sByoS6i1g4taF1FZGA
	DQnVk9aOFS8qtdk1eUXw6XIoUdk7ApzLnImgEajaehxO5bhFXzqeZ6uV8Tt1fTYARxKSEw9zqrc
	LmnsouNg8+w==
X-Gm-Gg: ASbGncvPKKFNNJ0VztjfSuTEQ/bOzLp63CNCdTpafnbOTlbwR1YeS4R1+rym+OiOkFG
	+HRj6CNiM5mGU6NYHoHuhEZ8XZdDVh0icQFCc6ciPXhine2Wg0SHMx+SbIyy58FsVvGYRtkPYZ5
	f2rps15DNUkSwDG0xOqrC+XJGM6TZ8xvndf6eK9hBLV5SGnNO5xyD5MgIBbT4iQMYy5uo5zJma3
	LABbYThQaRk0QN9qCCUMbvrWDZGVBOr9i/j92vBpO3PmkoxY7n+yXW+brsjBqy+3IzoOOzj3DAX
	CaeK7e9JSKnOXKdFr9yLWigs2/GYTFGWG/9y1gsI1GyUCyENQOp9gUCU5e4IqWwQnBAmGdRoTzD
	EuqtCgnzqwgQRkXdve3PhWi1Uv8OP19oTG/goP/kWIrpHzWVTPQP7lPgmfIdb5VVlgUS2HavF
X-Google-Smtp-Source: AGHT+IGcbmYyVXogI3kiMuOrRNWe+OqKzl2KbLSQRh6TIlca2qJQWTKyW2wycgKCGzvxA5tKvDvfzA==
X-Received: by 2002:a17:907:97c1:b0:aec:f8bb:abeb with SMTP id a640c23a62f3a-af992b72872mr48847466b.42.1754445176193;
        Tue, 05 Aug 2025 18:52:56 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm995003866b.59.2025.08.05.18.52.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:52:55 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so6998654a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 18:52:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8vd6Ctyp7rKyxyiFk5C766RKRFkMv2x+SJkWYWqBFdegQYNVcMK0Z8BjF80IaqY7wARFDRoQy7JHoVfM=@vger.kernel.org
X-Received: by 2002:a05:6402:84f:b0:615:4146:72c2 with SMTP id
 4fb4d7f45d1cf-61797e0c23bmr629430a12.31.1754445175031; Tue, 05 Aug 2025
 18:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAQW8b_HEQhWBzaQSPy=qDmKkqz6URtpJ+BYG8eq-sWRwA@mail.gmail.com>
 <20250806030434.10663c09@canb.auug.org.au> <CAK7LNARZivfd7=vU_vD4dtuLVXecYNyMv+TS+O99YGv1E0qR_Q@mail.gmail.com>
 <20250806104814.73fa19b9@canb.auug.org.au> <CAK7LNASw5G1oHb85XSFGhSBUrBq4iDxiX+9rRfgHWOmPj=_ALg@mail.gmail.com>
In-Reply-To: <CAK7LNASw5G1oHb85XSFGhSBUrBq4iDxiX+9rRfgHWOmPj=_ALg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:52:38 +0300
X-Gmail-Original-Message-ID: <CAHk-=wiW1_qRN5h0jy=B7NU+fVo=2X7j_bu6nb_=66P+yQp8-g@mail.gmail.com>
X-Gm-Features: Ac12FXzoajUDqGlyJyjgHvxStQz7RZOp3GtrkMUP7hrx-EYZhO5BCTUIpmtaQyw
Message-ID: <CAHk-=wiW1_qRN5h0jy=B7NU+fVo=2X7j_bu6nb_=66P+yQp8-g@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.17-rc1
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 04:35, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I ended up dropping Alexey's series entirely
> because I also observed the following warning.
> It is too late to fix up the code in the second week
> of the merge window.

I'm assuming I should still expect a v2 pull request from you? I've
archived this one...

             Linus

