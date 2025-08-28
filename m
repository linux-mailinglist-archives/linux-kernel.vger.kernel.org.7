Return-Path: <linux-kernel+bounces-789998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9EB39E03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E051895CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBED30F7FA;
	Thu, 28 Aug 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZMfCwfW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CE30CDAD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386177; cv=none; b=LzmcgcEvVRkguoHIx/jEtXHzq2GUgZ6AgwsGn7Q0PI9xMA1cZ6+Ta1UM9R3ah4Gs1o4l5xMAtDPq+uNrqJbfe3Dc4ToplZTmycZQtTHAEC/rvh2IZ+dBofcnljI8RpHkedeMHmI6XqcqR+YrhxeAhUVs4aZEBjEiDdrX3DzoEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386177; c=relaxed/simple;
	bh=IPlm5S5YIN4Ht1NgFPaU71FGHN88XGb9ttp9n4Ge5pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+aH8X44LL78PR1uopPm2s6traGa9IUOu9/JUctD0yoIcyTZcj8FMVYBTTaEeCoBEqky5qk4yvw+sSfbzfvSbBt0W0FzBPyJKzhY+rRhytsx0/Qo/SiwfcfACoIOzvVTU+g6h8eVTdbBdg3E69kYEL8Vuw3a6hlUN46YvrwQfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZMfCwfW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ceb830dd58so118728f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756386174; x=1756990974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYAEu2X34yJC5N/vh2EYp2lnq4ZIeFPJb3ke4a7CquM=;
        b=zZMfCwfWkLx45Wn0evWDQU+1DUAxzoWDqUKUrqN0TfHt8p0jPiQkvo0p9SjsZySqL4
         3VHlHjmAa9QImF5OLn8OUbRv1wcnN5+n3AZyi2AGiWlcfU/II0uCHy9nV80lD0j4ChSG
         097TgwZG8NDf2yKSAcA45J5FScRe6sR8ImkkQeER70FYWydUvRPEEY9YZWGr5NhW9Co7
         xniW9z+gmooOEm8eVp4X6HrXhF0IkLOGwR3PVb9ugfRqjEiwnEBfkkD5pN1EfppzWDe4
         87BdiLVtHDCV2YIfU3sEeBvgi4MqWtZqQ1sOyGBBYbVAi638jgm+mp70Y48iGpYUteK2
         vTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386174; x=1756990974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYAEu2X34yJC5N/vh2EYp2lnq4ZIeFPJb3ke4a7CquM=;
        b=s6IkXzslbGOML5QtHM6pLaCtSvuwGsUXeEE4zuiyz5SDoDIHEvnJ19hgsM6dvx6+tN
         /g2ZIh9xHLhEgcDR3i+CFZfDEL5r26Nn5er3iSkadCHfRxj+VKvKd6Q8vyzZJAX+cOUW
         LX+55eUF081yMiTJcZbg+kL18/e2AIV0WwLK7ZHhNrn6ql+GOSet6Kuw6pnFJKSl40ns
         ZKRzgdeuTQCG5jfkn9xKVKGCO7gKbHjXw2DUExI8EruVO0F4C73dWzufGSpoQ5ySrlHi
         hslHI7Ftd07tH9RRY2YnnbVJY6nAxvND0iCQo4emzRJnYHsRD97ovpdUeiN+JEQFERPe
         G+7A==
X-Forwarded-Encrypted: i=1; AJvYcCUWzQYn+BZX9esGPIGfZG6mrapevSqy4xs7YUJDTt+xuM6RFaNUlFOVuCxfLZAtbBRAbiOa3UZTUBfBl2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLD2ZHS/6HcnZvdULnG81Q2WujCFRwNljRIS/8w5Hxa/yt0OS
	UAKqF45NJ90abmng/7xFqpekbHjOeSgUhMjtsX5A31yHQCnOK4+/iB3gI84FOoRZBJo=
X-Gm-Gg: ASbGncuK9GeZgDH+HgxlnfAmH0WBk2rUg52OAJzIMnAXjVfry5v62bVfxS+eyFjP54t
	YGjTrIcLN5+1bwCDz7q3nWgT7nGJKUl/wXJR142hYWgdPwpFWnuW4BNNA7L8MQwmPwloVgUIfJB
	esfRucUcd9wPHeMxeIv81UgciXOrh4/u2in3FVOdlX9c09KR0/60rPOka0dyUS5NomVGZhyD5VW
	B/u7aaZY+9puot5V2OMq/vRzpcfTWn8/4TepBFrhoNWfobXDso974irC/rNP+iQvMLa8tnfNP74
	SbR+sHSW7fLsMk1brCF6MdhQP26IESZpojQRnfxpCSK7GM9xCQOU4amRJHbURrEDsgct2Zp7q5S
	Fqjvbz9OCnPFmREU54Qwd9W4nkJQ=
X-Google-Smtp-Source: AGHT+IHQxbX6Q6u6vdwuoTlu7z5xflaVbY+bPcWTO7859yPEOlFmhSSfwk00Y727IE/eLiVBYP2PWA==
X-Received: by 2002:a05:6000:1448:b0:3c5:f975:5f97 with SMTP id ffacd0b85a97d-3cbb15ca266mr9271871f8f.16.1756386174285;
        Thu, 28 Aug 2025 06:02:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cd935931ebsm4081897f8f.55.2025.08.28.06.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:02:53 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:02:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: yingche <zxcv2569763104@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] staging: rtl8723bs: fix fortify warnings by using
 struct_group
Message-ID: <aLBTehFv_VfOWEj3@stanley.mountain>
References: <20250828094537.884046-1-zxcv2569763104@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828094537.884046-1-zxcv2569763104@gmail.com>

On Thu, Aug 28, 2025 at 05:45:37PM +0800, yingche wrote:
> Fix fortify_memcpy_chk warnings in rtw_BIP_verify() and
> rtw_mgmt_xmitframe_coalesce() functions by using struct_group
> to access consecutive address fields.
> 
> Changed memcpy calls to use &hdr->addrs instead of hdr->addr1
> when copying 18 bytes (addr1 + addr2 + addr3).
> 
> This resolves 'detected read beyond size of field' warnings
> by using the proper struct_group mechanism as suggested by
> the compiler.
> 
> Signed-off-by: yingche <zxcv2569763104@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
>  drivers/staging/rtl8723bs/core/rtw_xmit.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 8367fd15c6b1..314ec5894d47 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -1363,7 +1363,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
>  		ClearPwrMgt(BIP_AAD);
>  		ClearMData(BIP_AAD);
>  		/* conscruct AAD, copy address 1 to address 3 */
> -		memcpy(BIP_AAD+2, pwlanhdr->addr1, 18);
> +		memcpy(BIP_AAD + 2, &pwlanhdr->addrs, 18);

Use sizeof(pwlanhdr->addrs) instead of 18 and on the other too.

regards,
dan carpenter


