Return-Path: <linux-kernel+bounces-806181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F910B4930B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854117ABEEE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14F30CD80;
	Mon,  8 Sep 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0UJXQ/g"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6625634
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345056; cv=none; b=V9nOuBCSK7LCZ+2tpffpUteLl20KRn9erbZ629LaAVOPYphdhdLyB8LHZIfXKGlPZNoQ5SObAHsL+HBC4C+NSlHW94332im1zugsQMZvdbJnF8XQ52DqREeIweCQDUtMwkjXvI8LgL13MvRGfKiOnJLpPfxZ+OqjyoUuAJdVS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345056; c=relaxed/simple;
	bh=Ul6hlfdYbZgnkB3U4DVdpwBW0/N3398y4eK7duR9mAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg7SRnBIa6+ejCyFKpkl17po5sjb5rUrKXb3AZhdNlm4tNj0Xqrgb9WeGojYN05KJJ42jEXXMow3FyK9MV+8HImivQeLarDpWS/JrvTkFIMUbCgbZ+r1cwaAncpHrAR5Cg2A6yjbpIbrheVHtNkMgBGpYAgE/pJGsKZ9HPjfu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0UJXQ/g; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e249a4d605so3630203f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757345052; x=1757949852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpRpJmkBBhBD5b0lfqHYrKM4X9axaME4RCmFzxuQADg=;
        b=s0UJXQ/gfysa/arOZ09979lfNWfvsCAI/bHCJQGKxeJKpTv2I0dURGD6DEhabv7PFE
         WRcjk6ok2elo8T7oP0rVrnlz+ExzKC85mYvCpcC1bZtPkYPtG8EEoRlH+FsXzvJYzbaq
         wH7E/nLe6YFSujPMEAd0rh/UqZGSsBecijK6vkFF0raIjxxutqO1GQMKI1kwAm/yWZWT
         fxGCS5p27f64QkC7h4diURG1yDjkg580R3Yx2Z3JQZ6OCC4qz/T4Lc0m2JjDp7W9mlo7
         SrdFIuvNOYrG2ppTM8hLQ/pnFF4KVhm/E+QNtUvmSCETdJy1A+s0XN0hhfRRI48JDYES
         57pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345052; x=1757949852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpRpJmkBBhBD5b0lfqHYrKM4X9axaME4RCmFzxuQADg=;
        b=Q9ndqQXMvD8RMKZz6lA1B0gYZEo/6g4uut06hHtZoEM8coALeiRLkbcPaMOtwm6wCS
         Zq07HK/y37iOOtvg+r2gthqvuMkkRGRM3KvRIa0vlgxSmFdOwMKRV46/jklAstCtC3A4
         6kHQun5R8lUSRrZexJzoYlO9rSjMFYMzjzHfnhFOet/IOrg0fs4IImuUj/XPvV7rAw+6
         nsyaWyOinbDMeXfaf7EKy2X75UTcFcOCazq4m4v3TiH4yIKmlHvHTZ7uvTihCoUHf3Go
         +pw2LwqNWJqNZtGz2PU/R5CQZSRxnlfHIYMToDFGTeR5+oC/LtgI7wIdqAmF9huBrhiY
         H2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVRURBeme01X8t3hBrbPEkn8rfad6sDI/7i8GQ3iFrhOO2Rn0KsmlUBny5ERf3VOu0cMZ9qdODy7X6ufn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5THT7lsFT6WVuKzKF7ihOsy2C+OokQjokthbkx4+U08nJDAwk
	JWm7YPzuhmW2qtV0bfAV4cA9GN44NU2gWq6Fx0yAnCdRqoSTahJbV7o+GZF0UOXh6c8=
X-Gm-Gg: ASbGnct2VVi3/xotTczJI8uYyso8u4Zd2vMpIb9v3AZMP5j6XSwRr7/bgfe+Mmw+EZf
	50MLuzlQ9NMxnG7pFvitNVs3ELNZfyesih5xZ5P0Jt7GKetTKA1hKmOvb36guT8jfn3rkHpAFnD
	rDj3x3OErgPa/B4hvUEM3aptnrxUY+vcI/+wZuaKIMRkuspRgP+kwPBF64BTXk5YemjoImolHI9
	Z+aH9s1lsPvWp3i7DbxFCEoD+CaeFzBAabfLdNOqycRSv0nEeNWAnDtTmrFaes1n/fxWn1Ao1+x
	+CZytOuPtCHwi48FbEpHazkMsIK/PPsUxxJvVaJejoorOU6UBCzC+YbW8SQtFUBCWkyNJn0EYC0
	cXQKktNbxeGU0H/Fx+YLnT3B3rjs=
X-Google-Smtp-Source: AGHT+IEn637DyEwJnrFNRHZCc2UTlG/gZ2HMTDZnWDtxeuY8lE5usCiroODZ2mgOoPTIpShA4kFmBQ==
X-Received: by 2002:a5d:5d05:0:b0:3d0:ae58:e337 with SMTP id ffacd0b85a97d-3e6423fea50mr7224457f8f.14.1757345052575;
        Mon, 08 Sep 2025 08:24:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e329475a13sm14010482f8f.14.2025.09.08.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:24:12 -0700 (PDT)
Date: Mon, 8 Sep 2025 18:24:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix coding style in hal_com_phycfg.c
Message-ID: <aL71GP45JuzS2XMl@stanley.mountain>
References: <20250908144641.39518-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908144641.39518-1-weibu@redadmin.org>

On Mon, Sep 08, 2025 at 11:46:41PM +0900, Akiyoshi Kurita wrote:
> The function definition for phy_StoreTxPowerByRateBase() did not
> follow the kernel coding style.
> 
> Move the closing parenthesis to the same line as the argument to fix
> the style issue reported by checkpatch.pl.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---

There are so many other functions which are declared in exactly this
same format.  Fix the others like this in the file as well in one patch.

regards,
dan carpenter


