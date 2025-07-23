Return-Path: <linux-kernel+bounces-742421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58581B0F17F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E3C563C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075C2E498D;
	Wed, 23 Jul 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTutTMh9"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39402E426C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270898; cv=none; b=dLJCDUxMpTLHdNE7DP3cho8zx6cnH2d4PixRzKz0RIRLYT3G9yNDQFgjkBNg0XscFuW3T0qpIZ7pfaxYBbzjXGvTxZ/NyXgFzBlVX7jiSV36mxUNc6oR1e7OfsP4+KhOs4jAMb8f2Q7uiLBVLzOF7yvoilp1xiMOraCuai3TT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270898; c=relaxed/simple;
	bh=Nw9fysjUFNBnPqpBPahG5IhvqPdfXTNqHeGEK7bkjVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZst8FwuQzgSQhHCOYtBjHV5EpWnJxpT70Tf1D6ysxWsMCkWsWUFpUeGgMG0YYatmo5E4kVOvZrnT76R3LrfH0EH9KAM6UkUMZPzWI9oh46QT+KecXE3+scXrFTzZniqZ/9ENP8xlXI0OUkbE1bdQ1LAiGdAsKIXt0DsO0fDGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTutTMh9; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8dbe824ee8so1350051276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753270896; x=1753875696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw9fysjUFNBnPqpBPahG5IhvqPdfXTNqHeGEK7bkjVI=;
        b=lTutTMh90ndgWw3dvKhVDfm+0AkTGzvdUmWYMvkDmCS8qkeBlxDiNpuqyiCxo/b70b
         TwgAw7cQ7mNtP2VOQXhLOn2edDVlk1ACygQDyblrTTeXcK/ZLZf7liePlCFaPZ81jiV6
         kwonO5wruwmpDRWZTo78+vqvT8JHcATg594kYDbhafbB/uOUcvv/VdQFdqPcq2EMs6y6
         yf+66TEjOEkgugXDuDmWVjcdkEQAW4wdqQhbTWNaZhWCRQfIHpgxDB3ACvU3Jpx+d8G/
         EbUpm3BCmwM39dtP8XzChN7d/Y9al6/Br3BFn3V+tL/RPxEofq74+1ac5t4IvVuaV5dC
         SOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270896; x=1753875696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw9fysjUFNBnPqpBPahG5IhvqPdfXTNqHeGEK7bkjVI=;
        b=i2HN+X57VY8Xy3R4MwDWctQbQ46vzINooScyHmDNu+pSEN2hW29Uf4L8lLH+fsN4ng
         w01xTdpObhmSiysgXSYdKR9NcQ3n0uFd3pVCQ4rUdObwHalI/YIFUhj+Avr8Smsl6KYa
         I+hTBqjvGwcI+yl2rNSD2VQcyxbzIIs3kfec6VuIw5JdJk+qRUIjdNSHep8iyZ+K2q9n
         VBk9LTSH+SYvG1o+txn5NECFQpy/la1x9Q95VmWfRURM5gXxZb1dY9sPV0f18SX4g2uG
         3jRMmFVexaastVWi0dzM5w29XiKfvO+wYHwgUCnRxrAUHPPxgjjpePb3PpVDkWLtcwqE
         ssKw==
X-Forwarded-Encrypted: i=1; AJvYcCX174WSb17FC6j9lvluuTIqiMZFunvpedcmuN1/G1SRxdpKZX5UoGPj7CzUknH8si8tEic3yoe5kq5kpAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6QS7fo8UUJD7wp6D9UdKomt4kiBJ4eoM9f/Gk+gJSMGI0i0G
	Q5sJZuZA+gNaVONRz07lPO37bYWY5hCHN4nqhf965NTrBzhb+7h0EJ1hg1ixQsugliLPiQFme9s
	YI78pmkvCjMnGdXkf47UWfzZTwQJALiVTdl6/IKKpgA==
X-Gm-Gg: ASbGncuwTRXTinJ7wWjFl4roe91lokRIdg7DgoHMfV5vJj7dN6PCBrSEg+EKIlv+YOC
	ipkCtgmXbcg/c0HMz69bPBeFDOvMwqIOeVvKFNvLCiUft1dKm6j4w03gG1kwoF6FkxsTIxo/L9a
	phkgQANMv9JoqouQ4b38NVIVSMx2pWNNDk33bR5cKQGm6QLwJMlUH3f+Q7ac9VN1MPDQi8cPEM2
	YgrA8g=
X-Google-Smtp-Source: AGHT+IGWcKhCVXkg1msIEVmGS/ymhKW5BdJC9jUDzoeyLepuP7cjRQ71PwnfgzcSt8CZwmzRfOwOfwnqwnX6XBuUIMo=
X-Received: by 2002:a05:690c:3347:b0:70e:1874:b914 with SMTP id
 00721157ae682-719b4133d40mr34871357b3.9.1753270895185; Wed, 23 Jul 2025
 04:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720022129.437094-1-yury.norov@gmail.com>
In-Reply-To: <20250720022129.437094-1-yury.norov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:41:21 +0200
X-Gm-Features: Ac12FXy4Emm7GHQ8mjHs2JHTJya8z2HMRXPPehvvRCGdC2DlowB6xUhZ-7S2d3A
Message-ID: <CACRpkdYuXuTx_JG_7Zd666v_5Axv2jWV9OYJO15DQEZ8AkftQg@mail.gmail.com>
Subject: Re: [PATCH] ste_dma40: simplify d40_handle_interrupt()
To: Yury Norov <yury.norov@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 4:21=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:

> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>
> Use for_each_set_bit() iterator and drop housekeeping code.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Neat, looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

