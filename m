Return-Path: <linux-kernel+bounces-720284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9CAFB9A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4845B1BC0119
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004E2E88B1;
	Mon,  7 Jul 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbrGxHAG"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF78253B58;
	Mon,  7 Jul 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907956; cv=none; b=cD+o96XffsHS4+ejlwOoq41EmV/fpd9Mz9e1IRfrQFhkLzQC1c6KQV9O4dTQM8rx2Rk3F/xU3UkoEomXzQN34nuPrgKt7OjuJ1jlnHDoY/fjd5zgvs8NZzQc4wS0TuzmuvPwsPeREZvPc/CJvFnoXB8a0IdMFYBVuube1BoVVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907956; c=relaxed/simple;
	bh=PY+mw4mTUhq/6RadpdMRqZgmrB8wZ5jm+Z1Dkpgo29Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j7jkHLN+0SGGz8QyHLk6e3wsq3seWAqw2fQcavuCrorPVF7WZd2Q529QJKsqNkenJQ1dhO9Utd1wMN+qazgubr0eYPG1P4bcCvB9Rq2VOVKjSA+lCSy2ZXiUtypWqcu4BXl8vSy7+0PuFWXmLHzZDNQ0+Sy//Bu0oS68TJSct7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbrGxHAG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so2761413a91.3;
        Mon, 07 Jul 2025 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751907954; x=1752512754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpMdXzDnCfdN/GalFwfGmK2Pny6VW2Rxcn9/iXdWGFw=;
        b=lbrGxHAGaSV5fsR+2Q3fCX8wlID0lMC68OpJYdZCd0MqwdOnAyAbvYjEhvse1+Ig3r
         tJ7QqjdI8kY7KvSnV83YSi6Ks4L+xW8bLmcFcLnt1Mi9cZFvRU22F45E3OKen2jwzEfl
         +4DkzM73G9HDWFXUK4PhX3oruVXPaPxB+KHgLjsGJxveberQivKXChSOfJ1Hkid2MpfC
         MG3yYGuiBrwBF+amDm6LMaH9vK8Kr5Zi2y+7pG0DJIt2rsla5T96qNTknb3Jyxmuu+DL
         sgEK/ZekbuFM6nmfZBdaf7W74ifDP9ImVqYTKM9xt/wn+Kxg8xbMddzHsNsgz8cYK8kE
         R+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751907954; x=1752512754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpMdXzDnCfdN/GalFwfGmK2Pny6VW2Rxcn9/iXdWGFw=;
        b=ZX2XgjrW6G6xSPs9IRH68ZpyjUjF0DqEI1gjoD82QX8XmkdWSE+2pH7RRPPVEQWlXp
         +Omlo5Z0xOHULAQT5TFjFEmG+OAkp0vb6K/e/9DN18n7rqWFTpKsQZ+S/X+/OCrOAPnn
         50J9+NdrwYgiRRKofPk+XcGlGs6nfR81sc62cKW1bbPAQ8cp2jZg3UqUPqEOyWuvSsr9
         Ufo4pHls+/8kUIxF8xA/Z+UcmLmjaQ7Re4q0cQ0LeOMwp+jocy5DNEy9qk6vrZE6zqLM
         2rME/p7YSN4qKVPYSA1I6cHqXKwUtry4sZNbZC7FeokniS/6Qom0/cyMFX5CkmMj7lVe
         uc1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDzKomL5+B58W1Gq5ap1NhL/qbffyCOuU+Cmjd51haxEVBxtuHG2/GpEK1zDbBMGEE7ebwZfJU6dVPlmkb@vger.kernel.org, AJvYcCWJNa0P5AJ9v68Sq9kmW8nopdm03ptf5jwB9Kz10ipNSbXW4Eto65vVnYx9kjMpYmszrRdueKG0SlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QshsY/JXovlFkPnRefmRnKED7SBlIwUXL1y7REy0iDGxx3wb
	ZIoOpvb9KP+0TOcGtLmzgyc+0pqC3Mc2c7n4KRUSL/Y3VHglRulzQ60F
X-Gm-Gg: ASbGncvVEyrQF8uX2FhNME52SA3AdR5wCHRJvYlFYTKlaw1Zvqv1WhJ0j7RkCCdzAx4
	2R3242i9DGYXGi87ZaLQEWCbDRpHp2CPcz9+XnkCQsfFR0IYaeo15gIiLXiCojS2kH4+y7aruzj
	HyySCfp0uih72ApKxTJiZyMJg3HRIKYYZia5ZDIDysoNNpMTZhM/iiKdnlU4TCJu56bNEB62B1r
	Gbc5KZQZBo9+y4rm7DrVFTulbMaXGr+zKQlFAWc7WpO0KAh5mM9sCQSUKLOe7equWhGGxOR9zT5
	hJrMuy3uWIvh5nc1hRRq9+LTFSnDtC13pixdekQdjz1wkQ+0m1v9zFDlzACU+apcyBfl2V6RnPo
	=
X-Google-Smtp-Source: AGHT+IEF5fattogvax5kob4VN55wmQfM65/bVQ74yFaRHd7Gk2rpdUBuYA2r6FYpXtk6hWnOBGZqww==
X-Received: by 2002:a17:90b:4b43:b0:312:29e:9ed5 with SMTP id 98e67ed59e1d1-31c20e59333mr265155a91.23.1751907954241;
        Mon, 07 Jul 2025 10:05:54 -0700 (PDT)
Received: from [10.0.0.86] ([122.172.85.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9f17bc5bsm11683652a91.48.2025.07.07.10.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 10:05:53 -0700 (PDT)
Message-ID: <c7296a36-0bdd-464d-a681-517c814afed7@gmail.com>
Date: Mon, 7 Jul 2025 22:35:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm: docs: Remove completed task from drm TODO list
To: Brigham Campbell <me@brighamcampbell.com>, dianders@chromium.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>
References: <20250707075659.75810-1-me@brighamcampbell.com>
 <20250707075659.75810-4-me@brighamcampbell.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <20250707075659.75810-4-me@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/7/25 1:26 PM, Brigham Campbell wrote:
> Remove TODO item from drm documentation to transition away from using
> mipi_dsi_*_write_seq() macros now that the work is complete.
> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  Documentation/gpu/todo.rst | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index be8637da3fe9..76afb8a784e3 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -497,24 +497,6 @@ Contact: Douglas Anderson <dianders@chromium.org>
>  
>  Level: Intermediate
>  
> -Transition away from using mipi_dsi_*_write_seq()
> --------------------------------------------------
> -
> -The macros mipi_dsi_generic_write_seq() and mipi_dsi_dcs_write_seq() are
> -non-intuitive because, if there are errors, they return out of the *caller's*
> -function. We should move all callers to use mipi_dsi_generic_write_seq_multi()
> -and mipi_dsi_dcs_write_seq_multi() macros instead.
> -
> -Once all callers are transitioned, the macros and the functions that they call,
> -mipi_dsi_generic_write_chatty() and mipi_dsi_dcs_write_buffer_chatty(), can
> -probably be removed. Alternatively, if people feel like the _multi() variants
> -are overkill for some use cases, we could keep the mipi_dsi_*_write_seq()
> -variants but change them not to return out of the caller.
> -
> -Contact: Douglas Anderson <dianders@chromium.org>
> -
> -Level: Starter
> -
>  Remove devm_drm_put_bridge()
>  ----------------------------
>  

Personally I think there's merit in keeping this TODO around until all
the other mipi_dsi functions are transitioned as well and removed
entirely. Maybe rewording it to reflect this could be better?

-- 
Tejas Vipin

