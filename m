Return-Path: <linux-kernel+bounces-813429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E64B54543
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC774627DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10112D63E2;
	Fri, 12 Sep 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDG3gffe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6C2DC780
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665612; cv=none; b=Yk9wK8XVdsx1yX+wkkzX6R0Hd6/XpYXehY1mYRGLupNu5c9nHp2Ci8Ogj4BOvd7kc7wfMX/h9sdSQXzdpS907g1EOXl9r1M2Nugu0TSmXaSkHxP6m7H4chbsXMpmX9iUNSlq17uBXz6QsdtcWjUa62y6b+oKKC5rQbTZzh6RB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665612; c=relaxed/simple;
	bh=RWd3nD6IlVsTPiAyoMEgevjM2cyQPqlGMG47UCwaudY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Afnb0/XE8BB/2M6S+aTICcIVO8IIvX9nhV1vW7pt60/Jn67yYRppGQntuPp6fGpINeFjCAP/JvtPiu0hi8pw9gGtliGr5XZveNwdPpjrqRoKD2PbZxO9gUEbnlkvVW53yYclifsp1e7F/FmkfnlcIKufuutopdcqT/Oi7feesqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDG3gffe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so10278085e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757665609; x=1758270409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyiUzp1OmILWl0JeAa0ePX/K+fXA2HLh+NIs2I/6z+0=;
        b=HDG3gffeF3RvT8Xbwqe3Ucj6hFLxi2oWbfOdFYTWIyc0DyxiSFNsQT+2d4du9GyfJy
         idoAmU/8jz3qDfB5GvNEo8IFCmBOYfxIKAN/Wb7PA8yanZatvr2Bi2jpVvlV/5/fma85
         uchMey9eb5+TlEWIrWlEYy2CM2CWY4meQxn3mV753lfZyFCuftLNHjTATraSQRgetUHS
         TvXpeD5jduA2a+2ne4chyYlrmSurXcShgBi0KjXvG5RBMqTQT6B2zA8+h9D01+jwd47K
         /ZU47rHkUnzbsGB645WRoGXIdCnqwovilo039H6I1MUet4hDEv/gMxA/EWK1yAliswP5
         coew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665609; x=1758270409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyiUzp1OmILWl0JeAa0ePX/K+fXA2HLh+NIs2I/6z+0=;
        b=X4Fceu1cG2DcPAOaGQX3WhEIf7QZuHHh9k9zRSg3yaO0q3Bl6rTy8Cjf1QlvWP3MVj
         7P9EBj9En03ckQBXM4qzpRfjn2X7cD5jSLzdE2ihR7F0DsvNXiqYZ0zjA3rKFlygzGBB
         BaywuOGAYrQskRx3Y5sk9FCzrcYo1JqIzIQTCnsHv9jplV1WCNjgb6CSa53NJqqQKcc3
         WFz9uyZc/8alxns/D3Oa1gGxd9WkxA/gl3PPjwQYAkdsz+kjCgAUh5O8Iv0xuVH2Xvf7
         DTiUuFXRZ1TLeW4MGJWVzxyqAEGptArfVfH2WC1CX6DsB7FM6EwN75/K8vzdPWlUfzkX
         XF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRnmNBEkmEkg5N/L6S9vyQEPnrk0mWitO4fBDD0NvpnagpdWSQOC0sgRMNGh4DYnyKXNLJU3SIzkVO/QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysin7JY4I5rn9MD5Tu7XjePqhvfITnOOT8cbUOcOg+5LFGLtZJ
	ecvRxcz++O64xfgbI/NwbDb1+1K4ntXnXBN8ThutRpbE91T7xFonJ3h7AJ+vWGS8afA=
X-Gm-Gg: ASbGncv/IGcBWN8fIKMlBacLmX0tyiFJR/OL0xll4FfV4h2BzZstEf4puIy13qHT+i2
	BXCv1iTLJSiT1Pt8T1Lh/kbIyqjTxTzdbff8UT7NyumbZDp3+xx+nCE7r9HF4wjopfG9I/xbV5/
	yAOtzvF9S8y49m/MScZS1eo8avs+FcVf2dwteuAC86JXhvu4uNlvviS/lkuQNlpb676623qYJxO
	y5A0k57VKhxiD0/lrc/t2lLJWEeDAEzVoaW4JAET+528lXaL/VN3jbqcyVtigeIXvPAqmfMPw1i
	XrnC2EYwzxE1SIKlGvNDvUchCUeiGDB5RSp4otDgCeSu5oQ5DZ099uPFA3NkKbYopjh2OPzbJ/X
	bBJLu1Pc2bfnCcWhhjzittMY+Kx4=
X-Google-Smtp-Source: AGHT+IGrF5vNadKXMANIOo7pbMCDAPw95Sm2Mv8SUuKbdQleRVw3/g3veQG79ZZmUxPjs879nJczEg==
X-Received: by 2002:a05:600c:1c96:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-45f211fb7c4mr18570905e9.34.1757665608854;
        Fri, 12 Sep 2025 01:26:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037186e5sm53450965e9.5.2025.09.12.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:26:48 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:26:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8723bs: fix typo in comment
Message-ID: <aMPZRUm9vHWQ0_pe@stanley.mountain>
References: <2025091223-dispatch-angriness-7516@gregkh>
 <20250912064406.707039-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912064406.707039-1-weibu@redadmin.org>

On Fri, Sep 12, 2025 at 03:44:06PM +0900, Akiyoshi Kurita wrote:
> Fix a misspelling in a header comment: "configurtions" -> "configurations".
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
> v4:
>   - Correct reversed diff.
>   - Drop "No functional change." per review.
> 

There you go.  :)

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


