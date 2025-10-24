Return-Path: <linux-kernel+bounces-868817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A271C0637C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA901C022EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB78315D4E;
	Fri, 24 Oct 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzJfhn+A"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13396313285
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308483; cv=none; b=WXnQE5N23uGWa8km6vP+0c0XVsSOd29u3mvR6qpGSe5Cx/FsviSZ5VG4iE+Tmd+lJP5j3KHLLg3kAKvkF0d5aCB2fHlAGdfhCEAD59uc9JmrjRKgC2g+gpng8c1iU3GudLKewSlnFsjuMoxFH8z1E7FDkxbLkQxLkRdfChp89mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308483; c=relaxed/simple;
	bh=pRY+BeQgTC3sgFy7x6scZvVx6olKk1HglYkeda9tiVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSjOShvtcskjlsiBY2jnxzFVMVqEl1egwAfS9CVxV/TI+OnmrN+8m/ok+3kEB48VbEaKlOwq+oguwm78TwrQxa1O0UQG4NsY6Ixr7rcgHTBAoKUGp0Ujc8XnKFkRUY1ow3ixpT8fno0EF0P3NkrWos0SabFFew0ggve12ks2zLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzJfhn+A; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so11005295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761308480; x=1761913280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASZh8fudbVWKppfwk7tVsYkXKkMV1873aR5CHOC9ccA=;
        b=TzJfhn+A5+SZQ7k0fRJ1ALwGHZdAYeIku4Mh5MRt+ywtgRa6Rjeq9Nt79bVe1aRlmp
         0/gR9BajZePC7TLwQBOLVDJNWj6TmCgHfXw2n6JtzdnR5g5vd/bQcf3WkrRQrvl52QOO
         TfS/YycznqNX5uZKnkfp6nprzF6tlbG4QVtQ9irbiJIUHDEicL7sKbDEheShNjz9XAdq
         Ub74eRq7zTGe6lR2ee6Wa0t/UlgcFgBtb4DfTurRMGigQJMHIPttkj1hs5x82B7OQS9v
         lVBWUlvgTYJGPD5y+ztsQqroPzY3h+oxmxNGDF062RbTneDhE0d0ENC2YByx05f7d52e
         aWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308480; x=1761913280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASZh8fudbVWKppfwk7tVsYkXKkMV1873aR5CHOC9ccA=;
        b=mrxsHRWI0fquaqJylXFWmzTl03Y1L4FSwdZB54Z43a+K2+aFkSFNXPYupLnezBaBbW
         isgAnLGDaYam4HEBqs0LgteJXt6XELZkseFiFsniGx04m5K3cwgrnCh2XSz0Jc45YozC
         rFy2TmLfuIL7RF2Vc1TVKHHSea9KWnYHaabLwr6q7EmWTUvUUD1K6VsEhw9Wj39vUNqH
         wkEjwgAYzuT7Gkw32BOboeV/KJSvCtP5MOlJjKXeNfrHsRGl9R3jL8NdFFENGktD4rN6
         YvwDEWt5ttN3RUSJXPNG6ScF1AtIGMJkUj+kDV2/YGAY1k5SaTfLzR9zx/4QEfJA02O9
         zE5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6PLnFTCaPSTkZJx5c3C98zLoSol6N41b76tOCxLC4R5qHY9azD9MCoaIyE9Y/KKT8azM68Zr3QWP0NH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVv6UuMJgwdaLViLnmKO0bjcNLlmIut2jXMwje0czZPuZxNC6a
	6+yviF8dKxcuHbRiqDML73qmnmjNf4OlqyuZhZPWxjGBTtDkDFfe2OIl
X-Gm-Gg: ASbGnctLSZaYkSwNofqok8q3XnTVYQeslO3B3qmcLKXYHF/F05FRCNiGDX6LUy9dVFR
	CZaRCx4/KK2qFVl+CDMHVXLCEmS75hkHBMk7UJLvxXto88g3UveZZvZsposCHiv6x6ote0Mjwkv
	2ZBCl6w7MIotz+3HbpNzDRcrIaHqdTW6ZLt4p5f3ysKn6qh2SO2KZnA5yKbliHua2EpJvybhrEH
	NzD0XojpTeNFNCjx9qxDXoEHfVua5+Ljx/SLEjn+A32eb0Fgs/bf74ffM2FjIImLXighB+dKBx6
	pDWL/Fi42WQT93NN/IwhjMKsJEpOJS83Rz5rXY+K2LStfJ85wfhcJ1JQtdIy5wMphwJH27vZSZA
	JTgLSkiHeFwS6RCmVDTbHrXhNlV962l3LjQVj8zMU1ZaUfOU/hmbHWxq8wvnEf2vVln8FIlUFbB
	3Mq3+a7hyCYH//ICLkRlmb0kzXq0wIIsb1Wvm0V+mHMrDtj5gLeEyE
X-Google-Smtp-Source: AGHT+IEbd+4q1oEaYkyVSizSec1ZLMt841VYzmkYm30kaim6aqt9zqjJycOchwQVXvxwo+rJdS246Q==
X-Received: by 2002:a05:600c:470c:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-475d30d21c8mr17720145e9.41.1761308479761;
        Fri, 24 Oct 2025 05:21:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm87470645e9.1.2025.10.24.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:21:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:21:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: yt921x: Fix missing type casting to
 u64
Message-ID: <20251024132117.43f39504@pumpkin>
In-Reply-To: <20251024084918.1353031-1-mmyangfl@gmail.com>
References: <20251024084918.1353031-1-mmyangfl@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 16:49:13 +0800
David Yang <mmyangfl@gmail.com> wrote:

> Reported by the following Smatch static checker warning:
> 
>   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
>   warn: was expecting a 64 bit value instead of '(~0)'
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index ab762ffc4661..8baed8107512 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -699,7 +699,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			if (val < (u32)val)

That check is wrong as well, probably (val0 < (u32)val) is right.
But the code is confusing.

>  				/* overflow */
>  				val += (u64)U32_MAX + 1;
> -			val &= ~U32_MAX;
> +			val &= ~(u64)U32_MAX;
>  			val |= val0;

How about:
		if (desc->size <= 1) {
			u64 old_val = *valp;
			val = upper32_bits(old_val) | val0;
			if (val < old_val)
				val += 1ull << 32;
		}

There is also an inconsistency with the read of *valp and the
WRITE_ONCE() lower down.
If there is a READ_ONCE() elsewhere then it not going to work on
32bit architectures - since both the read and write are still
likely to be two memory cycles.

	David

>  		} else {
>  			res = yt921x_reg_read(priv, reg + 4, &val1);


