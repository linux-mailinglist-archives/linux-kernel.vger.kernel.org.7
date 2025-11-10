Return-Path: <linux-kernel+bounces-893802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FFC48675
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C53AE5C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D172DE6F8;
	Mon, 10 Nov 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABXtOHJb"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB12DC797
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796626; cv=none; b=RGX59B5mVkDAf/mnx36ZerZGOPlW9fW2GfiiCKPvwz+M4kU6J9oVQXuVtjtumyT8fe+T1XZUS2DJQZ19spOusWoybsOMuwleDek8GNKrqBJIUVqgVVqzSdna97GoZST1saujcNFYrRABak+IZ8bNZEsChRAKNveqVDp9X0FBKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796626; c=relaxed/simple;
	bh=S4tg3Dr4FAR1CV10xXnkKduKxsDv65SRP68os3+k4kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFxLPpXYvfRrN+/G2uRyaHkssqmv5aUKOzK25DuXme/682MVQGJ9glJE1vdUzgYH8yt/5uSejP4d2KSTeheJNCWCUVnTIXg0JtCdbYXgTgimBJHKGPBxviSPoEFxWWAObozshI5UKVGZNlyvhlUGwGUPl+iK3mMdXDVa4n22Mdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABXtOHJb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so2749093a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796624; x=1763401424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBBN9infbPjez6qdJxMptt1hzq/iyvX0xcfU9jpmlSE=;
        b=ABXtOHJbLr+PXUmEvGomTywTdyDRQpTkFas3NmIaBDWZkYPiDy+bJB6IDy7KAzGen5
         saYkzIYZX7ZvkQfW0b16beMLxJdpuwlug0qqUQwzaXK7sgAptpoYDEXsIzZ6SLeXmMZu
         Cos3BrcLCiMfjgafyBKOMPpTtgNXNiKcyKENofdEuwTdauFjSmRFcSBTdc4Hu1z6UDPR
         6prjvLZe/6m1Z39u8+4gxIIlo6oQN3/rGCaVmQ/lFHCzdqhdXxR03TZcwmeWb4IkCKt9
         0pqR2kBaBLEMtGdHy39Pa7j9WfbqN1mj9/mVSvlFn+FXa3nM9RpIYVnI7WDcXWSzwNfm
         Q6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796624; x=1763401424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBBN9infbPjez6qdJxMptt1hzq/iyvX0xcfU9jpmlSE=;
        b=iaz8Jdqys6dsw+z0/tMTwb/pRz4Gcr5IHibby7r8GLHMZSGJlfj6P0cz1JCtYOm08K
         XtgwD1amSYYsEiJe5JGlg2T3r4Y7oUYu7xKAmBFCt8xA9XC2B79nCViGPvx0G6aIJmi9
         siA8tfBXjkMGUf1ZLUzQobkH7qsaydy9aoWB21ofCuh+4e3tgyK63P/N/FzQegSfBX7Y
         2PFo2X+z1Q472sGZNE84zmYY0VvW77Q0jBvMbqBQAiJJuV5KnMSHqH0JkbATltdNiDAH
         LbUDkjJsFaIXxkpz/ZHEhjNOQLahvHDoOCUpo3LH/pMwOpaiiByHBzDbh2xdytrjcO7F
         x+7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZDtmCnU4Ti+fe4Fgc2sinbuI9HlISVCiX+v899RTC/g6lNDA3zrjmN+nv91Tt9pGpNoNQVpEt8Qq6uAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvMkX/8Kea7/Ti/Qr8mHA9Dby90VyanCh6Ndu414yhFvYc9bk
	9ccHe5lsabeLrAUM7hqW+nyS8ujPGB0CbM8TrmTiBkTPphMg1spRm866p/3Z+r3pMYg=
X-Gm-Gg: ASbGnct8EAiPkQxLqOJuNj36POfv1htmnxVyUZVMTF9HP2A3BN+7x6csBC8vPPNOIBQ
	hGw2Lo+paUo+fhJ9PIUdkruLesaDPMGLKez00tLrkh5Q271VZKm8pL8ci/6SeG0EnktWAg8W4rV
	wpFOPN9dWlxYCcRzgB7rPffZAJeAMum3VizlqWTmjfUIl4stVbGzKt80bXPaG4Ar8XPS2ni+Vyk
	Ig6GGn7TlzucvsFchrG3v8TM4U6wxIbZE32Axcou4l81fUK92u3TefEl8IG1f0fk0cP/ZUHihsh
	ttctBvwZ5NZIDBd/FUvMUfsxMOHQQeXCW0wdQNFWV2lS6fR0RGE5yNms0ug+D8zHt6OoBd3zTPa
	TsE0MrCYL2HpjYzyUbcDtqO/GEBRzB01oCBbRjCbTBh9szN0bYunC+7pKQGjHsid3u8qDUx5HCd
	rd+HFEwpN5OQ8y
X-Google-Smtp-Source: AGHT+IH9KL6qJufmaDst932E6GsFJgG2DPRvV0ZpXeCS06v9BXdY1k3lpKtvHXKr+tDgIwa14Fuucw==
X-Received: by 2002:a17:902:e545:b0:26a:8171:dafa with SMTP id d9443c01a7336-297e564cef9mr133819655ad.21.1762796624024;
        Mon, 10 Nov 2025 09:43:44 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:e689:789c:c35:41e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c747d1sm151325125ad.63.2025.11.10.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:43:43 -0800 (PST)
Date: Mon, 10 Nov 2025 10:43:41 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: mtk_scp: change the snprintf() checking
Message-ID: <aRIkTV8C9gjSyH-o@p14s>
References: <aP8agyKj73bLZrTQ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP8agyKj73bLZrTQ@stanley.mountain>

On Mon, Oct 27, 2025 at 10:08:51AM +0300, Dan Carpenter wrote:
> The snprintf() calls here work but they have several minor style issues:
> 
> 1) It uses ARRAY_SIZE() which is the number of elements in an array.
>    Since were talking about char that works, but it's more common to
>    use sizeof() which is the number of bytes.
> 2) The printf format is "%1d".  The "1" ensures we always print at
>    least 1 character but since numbers all have at least 1 digit this
>    can be removed.
> 3) The kernel implementation of snprintf() cannot return negative error
>    codes.  Also these particular calls to snprintf() can't return zero
>    and the code to handle that zero return is sort of questionable.
> 4) In the current kernel the only "core_id" we print is "0" but if it
>    was more than 9 then the output would be truncated so GCC complains.
>    Add an "a >= sizeof(scp_fw_file)" check for output which is too long.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: The v1 introduced a W=1 warning because of the truncation issue.
>     It's a false positive because GCC assumes that "core_id" can be
>     every possible value of int but actually it can only be zero.  And
>     also generally, in the kernel, truncating is fine and it is fine
>     here too.
> 
>     But let's use that as an opportunity to do more cleanups.
> 
>  drivers/remoteproc/mtk_scp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 10e3f9eb8cd2..db8fd045468d 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1127,11 +1127,11 @@ static const char *scp_get_default_fw_path(struct device *dev, int core_id)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (core_id >= 0)
> -		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);
> +		ret = snprintf(scp_fw_file, sizeof(scp_fw_file), "scp_c%d", core_id);
>  	else
> -		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
> -	if (ret <= 0)
> -		return ERR_PTR(ret);
> +		ret = snprintf(scp_fw_file, sizeof(scp_fw_file), "scp");
> +	if (ret >= sizeof(scp_fw_file))
> +		return ERR_PTR(-ENAMETOOLONG);
>

Applied.

Thanks,
Mathieu
  
>  	/* Not using strchr here, as strlen of a const gets optimized by compiler */
>  	soc = &compatible[strlen("mediatek,")];
> -- 
> 2.51.0
> 

