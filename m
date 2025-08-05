Return-Path: <linux-kernel+bounces-756855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB9B1BA68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E61B17351B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86F299A8E;
	Tue,  5 Aug 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S4QUFLqD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA925394C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419377; cv=none; b=TiSXk3Fj+4pg0Do+JoPRwr5W3AzVqRYk/5tqZgTtXU40o0VLwY+1LG6HBvA+LCr5pF9X3WxRD+TRqRnMQ/6xaB4KA86O0G9ahlpoI0QD2Tvq3yVzGgwePTeig8ahhM6/FZrjuqx7R5EQyLIHqUIp0tlXhTUhEwiGWiOyUjyKTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419377; c=relaxed/simple;
	bh=ARKkRGwhJ+dVBpPJqKX4g9GOAA86TLzqcF5Rq4U+i0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuxVb+j/0GQ/iw9edRtEr8eAQclQBXlqoJt7K4dSSv4n3S1lWu8ToYaPPGocTkHpZ104etvncFS+YwddNSb5U4FlmQWC8EYZtZu7q+q2ahGdYSxiC3eq8tltdfw9b2K8Q01lfPAIfAfUaQX76hcPdyPMZsPon2eHN/CRw82nxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S4QUFLqD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10597192a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754419373; x=1755024173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaXmlHuPY83XfFKjcCzkYdyqwopXmurXMD0RTxSEhdg=;
        b=S4QUFLqDSURl7OOflQIFWPlCInsVQXS9hGTFROP4uxtNN8XX8QGEESLHYh0HUB5Gmo
         LDG2T2nUlIAV5GBbmajePjt7P0K+WX0Kl39WTBfViLM/YPtR0DEqDJS+L1akLp3jnCHU
         c2prwsVWx60r4QdO62fbvTYMC7dmSt3ZK+8vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754419373; x=1755024173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaXmlHuPY83XfFKjcCzkYdyqwopXmurXMD0RTxSEhdg=;
        b=VI55al1cPUUC+3lGqNnVR9JnsymrPuM30+fqiGsBd+ectNvUluwIiATQw1cIi7xRIL
         p3r0etuyBrQtlEnbSJwt5D1bFeQmv1IWo/S9a+qLTR5w2HtBL2DJDaSiwt5AWdMWafIJ
         LEy6mZo2/172fm6H3uu5CLHh5v3J60DjhrVacDIvTMw+km56i6JlaDM/v/Im5KjXqhiQ
         dqh5l7+dbTPdQnsOzewN4+ozl8pmwpCZWZ3eh7lxxXaQe8WDQwc1ux4LPudXQ7JXx/7L
         lryYBR6FNmyWyS9jPLnp7FjMaPJWB/ku0t5SEfPpRwhCSBlC7R+CuL/tFEu4DPRTDXZL
         JM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXM9sBH7j3zVAQSzQmqVgAFBAcq+kVSgJFvpt+mhwTTd1Zj/I4xOtrYKI7ckIr0S6/3rGizCXVnd3/h3Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFphTpw5TIT+ZOTjlMF9CR4HHlaSw7DmKhAgSGcoccDgPgayx
	VOSYA+mfeK6t2Ac7Ex0TNxKt3eQg0nEy04ZJ59bWmc6jfII1qkUakmoCMRaYLMDuFQHd1rH7fWE
	qO5rLiCWURQ==
X-Gm-Gg: ASbGncti+CPgCN9PdVR3N75+tSoJVpgP1ovkr2bYI6J8Ni2/qTt+BSBpQy6Q4Jmo6E+
	YVQHazRh+qCzgtQdrZKGk24GwY2JZGV7GjWStwBhNhTiP4da+CVuLD5aKdGFQ17Wr6sIeTMnmtC
	od/pcItkXYWAvUXU4+mCITnrcjjrmmln7I4JSxImwrLXbk+Z8DBseaIqcDNeZeIe+801TvawC/X
	/bU1EO1BLt8y95Q/Vtixisz4IYeXabVcitOuKEFAkw5rsCPM/q/MroB7DCRn8MKtxZdv1ZZqQuf
	wqNFoaQONruUm4BEK/U9sEhFxsEkz6jRK7B6zr96wWL2zyoytLhurz9iYH2beksM5fdp1DOHUN4
	eeWg+U3VzRgIUFShLHfbGj8kfhRfSpW8cclArCpCrF9vADdfBc7w9x4yExT1/wPLo78mzwj/8zY
	NNgeEKVC8=
X-Google-Smtp-Source: AGHT+IFEpHsiaHe+DyVU31J+SftJrN+SdR15s6YORP4Y26lON9W+tvX23t4nehiINYixyjmGUg/7RA==
X-Received: by 2002:a05:6402:44dc:b0:615:ad1c:f385 with SMTP id 4fb4d7f45d1cf-617960b28bemr73134a12.6.1754419373337;
        Tue, 05 Aug 2025 11:42:53 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15a66sm8831349a12.16.2025.08.05.11.42.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:42:52 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10597156a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:42:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSYIWQUGa0yn02S1Jxruhj0qNepq5FgIMSSpJh93nb2FlzZau9x86sRQLx8YxR6+OfPhGzpl7+MMoDpTc=@vger.kernel.org
X-Received: by 2002:a05:6402:4558:b0:612:d3cf:d1e4 with SMTP id
 4fb4d7f45d1cf-617960d5308mr64129a12.8.1754419372469; Tue, 05 Aug 2025
 11:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org> <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
 <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com> <da6a2585-daa3-4dd7-bc42-5a78a24b29c2@broadcom.com>
In-Reply-To: <da6a2585-daa3-4dd7-bc42-5a78a24b29c2@broadcom.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 21:42:36 +0300
X-Gmail-Original-Message-ID: <CAHk-=wgkvNuGCDUMMs9bW9Mz5o=LcMhcDK_b2ThO6_T7cquoEQ@mail.gmail.com>
X-Gm-Features: Ac12FXybB_ATEobBuTHBVMqqU6GCkvzrxccVRNBP0IuHBzVPItQ6ykQsu8_xU1E
Message-ID: <CAHk-=wgkvNuGCDUMMs9bW9Mz5o=LcMhcDK_b2ThO6_T7cquoEQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Ernberg <john.ernberg@actia.se>, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 21:26, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> Looks like someone posted a fix a few days ago:
>
> https://lore.kernel.org/all/20250801190310.58443-1-ammarfaizi2@gnuweeb.org/
>
> though it does not appear to be in this pull request. Can you test it?

Yup, that fixes it for me too.

             Linus

