Return-Path: <linux-kernel+bounces-880228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D387C252B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 912C74FBCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CE1E834B;
	Fri, 31 Oct 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+1MvRdz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9002183088
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915561; cv=none; b=oas+zCsA3TXkePK+Y8Q84UiVS7NyL9hIxu1EIz5Lr8/wc/XJ0Quo246UkPTeNMU51EVTd9WnNuu71QSBIFdEEMZNXuqxrASiiqK3b8q9SrcLVCofy60ZqqRh42yLhs3hBiXpT6jbRWlvll+W12JjVxlCPKKAkKWeD13pWVOTkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915561; c=relaxed/simple;
	bh=dybpf5GKK2n7h4v1nOx6jkvMz/++Xvmg8UxFM+o1u44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvfajiCADft1DvLcUeGNsE67nkIYvIVRiwbTx3p+/aMCVW6pT5YTZBKuigD82K3uKImAyEOgBQUpOk2OO76itZjikdXnpr9B4Jlc5KyH2cBFRxS2UMgO7+Bpb7hbknokc8pO7HDjWEqKmJavoHklExuwN4zxTeIlnIP5d3nfNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+1MvRdz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710022571cso23711055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761915558; x=1762520358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGlM34W2lpnnNMlmNv2zHPFLrrOcHYWtAmRmuIiXp8E=;
        b=K+1MvRdzOnmei3By3OmjpkZzb11edmjWQ31LTPPcDNxS4d0YdWOddVi3Dnvdc2PJoA
         +uxJj7ZR1KIiPIy6C3y0o8BQHC8ExSvxB4BcJmxIwCcJifxEFRZByqRuWiysEyqNiMgZ
         duZl6B+D+UtCXQPKI/u/cwQiD535z/WW27t9LE8MbwfbvlDFEcu4tUMTlqrNEePJaFuQ
         X1d9wpySmZ3L4TldozwUMlQQHNBFDvF+8vsUjlj0pgRsqv4ULy9M1P+pID0UiId9YygV
         8gnOPpGaUZxz9srWlO/VZ5OilOv9XeLK/c7LLrDQuFRGdTq3p4m3ekxnU/Yme9cDAwLv
         nR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915558; x=1762520358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGlM34W2lpnnNMlmNv2zHPFLrrOcHYWtAmRmuIiXp8E=;
        b=WhXPaayWlT0EFbYoof9OANOUU2QF+CaaLIJtgWDasQrLkTJG02FOFpn0D81YY1+Sb/
         8DHtL+d0zff7yYcKJ3VhcJSWEc9b34a8S8kNh+I7acqZb1LFPV+DpE+LgkKje/EqcBKG
         DKMGER8TShMTYuCdoNnGm5hEkOjcm6JxnpvmzNkoTlCOMfo4Y6+PMj4fVEgAB2K4NlBA
         jRcvzlXlgNkUycuSgiX0TXYdFNRVhwJg0jyhBwNA82Fdi4V0scqEidHWVRFsh4ZtLqkm
         IB6ZOO/CAxlgowofuKjCKWoqfYOF4m1dP2Kznge8B9E05h/ThJ33Nr8WhriNWSWNooWg
         u3rA==
X-Forwarded-Encrypted: i=1; AJvYcCV3Uq0vGmkzWuK7JYqy2zg8iZkMdu9i8KLIHSUXlwuK5SBg5gSeTYFPq+7uru3kLPlp1ciVIRmaveaHuNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLom6LNdyUFdEgCe+HMYPi860y390FmaylFTvZCKBouHKLGJM9
	CpS8DuLKQVf7ojzhghcF1EQCKPS5/XLvondd5qq61Q3IQl+1EmS2prJh
X-Gm-Gg: ASbGncuBea4vtS77tBjFA7aEX+jk/pHOYhxON049br8iwO6SFNpQ/uTbZM5l6kn2o6S
	Of4zy6BMVWeKtDApJfb98geZ/gNMEUx1PV6dFPUMa+cW/mVnCmzeuLlzCxyt5Y6h1+bUkOJlJVc
	iAqu5XQGO34e2uDgPcdOhRLBJHoO36Yy1bnj8ifbbuFGo8cPUj25fV6qgd9Oh0dOWPaQwv3u3zH
	bSORG5IB+80HyXi968KHWU1g3RnLpVMH+geUJbZSyHvP1AUt37hXWIVLl5CdRIkVGv8fPz6sZPA
	YJ0OON81Owotiss4bmWrIoe9N9gPww4x7xBgVJlpB8hdFDJl06yyX2joG5CMUg6dlMvP7pvmX4/
	R5PJejDlS0h/9MogYn6x5UW0kLp2ON7+jaqetM+kR9qevvKxR/H0FEt6Cm8pngVkVstXnmrtL9m
	aTfCHcQiBlSNyEz03dPGuKRH2fV7vidvJd2zjZLsiN7w==
X-Google-Smtp-Source: AGHT+IFzTOTToGktkUKQqr8jh0BWKWUjuCv6bnWZrsKQOk112lKJTQP+IEHPq+CXg603VeI9372WkA==
X-Received: by 2002:a05:600c:5249:b0:477:c37:2ebf with SMTP id 5b1f17b1804b1-4773086dbc6mr29613995e9.22.1761915557693;
        Fri, 31 Oct 2025 05:59:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm3445105f8f.23.2025.10.31.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:59:17 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:59:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
Message-ID: <20251031125916.3b0c8b22@pumpkin>
In-Reply-To: <20251031110647.102728-2-thorsten.blum@linux.dev>
References: <20251031110647.102728-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:06:47 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strcpy() is deprecated and sprintf() does not perform bounds checking
> either. While the current code works correctly, strscpy() and snprintf()
> are safer alternatives that follow secure coding best practices.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/device_cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index dc4df7475081..a41f558f6fdd 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -273,9 +273,9 @@ static char type_to_char(short type)
>  static void set_majmin(char *str, unsigned m)
>  {
>  	if (m == ~0)
> -		strcpy(str, "*");
> +		strscpy(str, "*", MAJMINLEN);
>  	else
> -		sprintf(str, "%u", m);
> +		snprintf(str, MAJMINLEN, "%u", m);
>  }
>  
>  static int devcgroup_seq_show(struct seq_file *m, void *v)

There is no point using sting length limits that aren't passed into the function.

In any case the code seems to be crap (why is 'security' code always bad?)
(See https://elixir.bootlin.com/linux/v6.18-rc3/source/security/device_cgroup.c#L247)
I doubt ex->major or ex->minor can ever be ~0.
So there are two sets of calls, one set passes ~0 and the other doesn't.
The output buffers are then passed into another printf().

Even if ex->major can be ~0 there are much cleaner ways of writing this code.

	David



