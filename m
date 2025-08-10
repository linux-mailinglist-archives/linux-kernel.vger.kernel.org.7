Return-Path: <linux-kernel+bounces-761317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917DB1F867
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206DD17ADF3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2281B0420;
	Sun, 10 Aug 2025 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jj1JxeSw"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676A14A0B7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801539; cv=none; b=IC4OcUXpdVLmMHuy1HSOoJa5mLBGPZm1jeI8wRit4W0xw24ApesozY9NjnmrRDxnb1eCCwvjWpkDoKmwo7G7514TdI3eUuJ4qEQM6M3nzHSnbaZsRIHm8tXcfObun5P9IKN0rx3YFUhJceeeXAylnF2sLyLW/w+BuiBqDAVQdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801539; c=relaxed/simple;
	bh=QpYrr5zdwL4EQJjR8CXyru7YDcS9YlE8WhSGCct7Gdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jR3aI+7fqK5z8FVZWwCJ2fFZPLOO6DkcUCqZ4teLdMO0G86cAd5Fik3tNuuGjsr3p9iWAWStHAgzPive/yKJKOlYTkyEsN4p+LDW2W7EvYdR2vEljfIvf/YrtzFqEmrQoneaPdlVL5G4LrtBorL5BGG9cyfykmvsaSR1Ha/aOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jj1JxeSw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso4380603a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754801536; x=1755406336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DIOvpfcvfL+aB8v7AdDV+E3Zb8xwZqXo/sST33XUOtA=;
        b=Jj1JxeSwpYEEafyNJ8czIUQwSAguzRXK/H1ckYPCx3vmIlEqmcqPjMkAZpFmTSxEU1
         h7GfrOfzGp8fjI8QSgZEjhaPHsMiTfZ4e9A3APkl97uv1m5sNwkqe92dIUQLMv64vtGx
         9Aednnnem8g3EROkhADuuPhlucm4wLUWaWD64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754801536; x=1755406336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIOvpfcvfL+aB8v7AdDV+E3Zb8xwZqXo/sST33XUOtA=;
        b=XNl2Ea7KUTn1Fs9PteeMLG+Sh94Y2M/mFB+raTc0cFxlfo3QcftIGLYw/dxEwDT7n+
         +Tn2KD3iHLvzy6psmo3UU2QNddfkriGgALtc6yYi0SekeUPPAZJGqaHHMy1vXRm0sQHT
         JOFTz0UC60jV3N3u7f9XspSdETYAMfyfmNln+tvHOJpDwm/g/MvQr1WKfih/LltcclCP
         DJ8ZhDLN4DfO3J+2BKBC/CjIOEgJBLOaUHq+cNMpo1DLk5V1eLehfeywt7EjTb0O8ImE
         3aCiLXjUFHXQDY1WwSXHL6eYQLLaYArAKzg7DmcSgQKMkXXxvMSizUHAkNE/5KLgA2el
         KX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3JrjXG/hZwr7N7zUEQxFwPSL807vLS54uTJ+/6vgE+I1KdPmO5HlC4SpxmSt6kDIbDBm1Ykf6DcQ19I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvz0M/vAvIhZhX8og3KARtnU+/SYilwLRl0sRDLVA6Yyx8ecs
	ci5uzoD5Fwl2InfnvmMGxDtF5RPydVFTFM/MOSSJV4w0BURohGQJ1cGdIgkrwxlxoWjA7H2qRAW
	dtEfflb5BUA==
X-Gm-Gg: ASbGnctTUOrW9eDXXhqmqX3Uj9AUoYrbj5tvZ0p/VbKsD16GONIt2cVkxnT+0XrCDfK
	MSPwBerq/QgnHQl7uULVLZYLLxMo7sm3JkRk7+XyFe9r6GVg8v81EP5Gtyo3BQUo0hCLpLkdsvP
	F/p+/VqKhtiLOG5Z5L02L99iDqatb1VANSkB0G4RmRjxcE29qkl4Ypwi6ZuGcNyIhys+WNY/9Rb
	TEe6/Iku6H7MoQ/xQ3X9m6KzlP0OWIeULLmOJaQV4cVKfqo40X4AXLYwV2mRQXcx0kUuJNK+7p5
	HpUM7ezA2tnc39N3VjORgChQhz26vInh77Rwr/YcVgc1G4bgNR+13s3LaFgWlCcVB1MPkk8BGKP
	pi8fuA95iXJlXPclaWYeUzJyp1AuY7i4CUwcdLUyuT7uNaCcnKpaoePWN3R36cfRrzFYkt4wI
X-Google-Smtp-Source: AGHT+IGvbe2D/ksm+2TVb7ODFBuBGy8fcLSOnfe7uKJn6f0IWXQWXyJY3cD3r7w8WrHar8TkOQID+Q==
X-Received: by 2002:a05:6402:430f:b0:615:522e:29fe with SMTP id 4fb4d7f45d1cf-617e2c4bc5dmr8002639a12.19.1754801535650;
        Sat, 09 Aug 2025 21:52:15 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615ed86d601sm12364463a12.56.2025.08.09.21.52.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 21:52:14 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so4753243a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 21:52:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFzk+v8q3pp0WRDKjItSqAg4suztEIRsnHcrUELUEIUIWoqe9ak3Kax9SE90YHxzTKDpSaU4Wrqa+45Jo=@vger.kernel.org
X-Received: by 2002:a05:6402:34c8:b0:618:1cc6:af45 with SMTP id
 4fb4d7f45d1cf-6181cc6b72fmr1142596a12.0.1754801533357; Sat, 09 Aug 2025
 21:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJWOH9GgXhoJsHp6@gondor.apana.org.au> <CAHk-=wgE=tX+Bv5y0nWwLKLjrmUTx4NrMs4Qx84Y78YpNqFGBA@mail.gmail.com>
 <72186af9-50c4-461a-bf61-f659935106cc@oracle.com>
In-Reply-To: <72186af9-50c4-461a-bf61-f659935106cc@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Aug 2025 07:51:56 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjn5AtuNixX36qDGWumG4LiSDuuqfbaGH2RZu2ThXzV-A@mail.gmail.com>
X-Gm-Features: Ac12FXyrsiG5csXTsT8XML7TTrnPvAVkGUcnHQ2aFJ6MSlHxgwl1oOGUIedHDGs
Message-ID: <CAHk-=wjn5AtuNixX36qDGWumG4LiSDuuqfbaGH2RZu2ThXzV-A@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Fixes for 6.17
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Aug 2025 at 21:22, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> The actual explanation is given in the email here:

Yeah, that should have been in the commit message somewhere.

And honestly, it should have been in the code too. Having very random
constants in header files with no explanation for them is not great.

> This is an anti-pattern of the crypto code that AFAICT ultimately stems
> from the removal of VLAs:

I'd say that it stems from using random sizes with no logic and the
VLAs were just the *previous* problem case of the same issue.

> As a minimal future-proofing fix, maybe we could add something like
>
> BUILD_BUG_ON(sizeof(struct md5_state) <= HASH_MAX_DESCSIZE);
>
> to every hashing algorithm, and/or a dynamic check in the crypto API
> (completely untested):

The dynamic check may be the right thing to do regardless, but when
fixing outright bugs, at least document what went wrong and why. Not
just "360 was too small for X, so it is now 361".

                Linus

