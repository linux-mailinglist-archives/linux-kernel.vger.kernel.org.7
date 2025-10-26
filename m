Return-Path: <linux-kernel+bounces-870181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B497C0A1E9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 03:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58C194E2B09
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6F262FC7;
	Sun, 26 Oct 2025 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWzTYYS"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886522B8AB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447397; cv=none; b=KoJQQescRGCLCRM2LwjET5muVI0bDf4Oue+dZfmGIFDtHRzg+kKrfJ4cJvhlOnFX9KXPO9dEwEZex5vT5Y7sRsOHLkZ55rNfsoDpccnqVI2Kbl/SmS/ZQNL0IwobEkU/RHBPg6kISmDt28QOFcXxfhmmNm+q5yHdlG3IPzB2QZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447397; c=relaxed/simple;
	bh=WMIoHeGDeQN9kTV67+ZtxnZ2djlpcLNFGvv/kEgUiRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1on3gktvXFI3+5xuaj2Hwpnh32yURtDqgpnf5dCXQMiJY4cPsxOf1ZBZ6g7OH1MCskMHOLLpfkagmeC5qJY5WY8pQx8d0XDq44c/QqZ/XgEIwmqfcqnSZTFOEVMSPGT4ZBBxYRv9RtjQhj0XPq1/QOf71nIp9WxUeXWqZIFw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESWzTYYS; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-932bcc0bcf3so2598960241.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447394; x=1762052194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfE2kMhhbNGjJf4FBWUzEJkfsNPGT4ktOzq6Ee9jcQo=;
        b=ESWzTYYS23IUDHqlPUO/Ob+neFQJ/wgJ+TXiQXNLHyz8EDrKnitYefO8Lu5nbznrXD
         6sPVcMZ7xpxpFoOUC3uLGNAAHQ7poTFpCFx3DZnC8kcOdXOvqY8dmpktvmAc3smfeIaj
         gOzA2QI9oZG7CX9mVbbHhG03Ey/vXI/bj7OZndRjsbvkiC7u3jC+mGdxKR0n8eNXRQ4X
         g3CZ7V4wyXzTlXxk8fzXVgOcGaKBmZznDqtqpGmHYkGuELe7ZSscPVP5BfJ2+c/u5VIK
         F1r/fdYFCPh8j2mVVa0Ia1MXG3c31SEZ9+X3UWvOTWC/EqyJD63Gciehx04orP/rCWB1
         SpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447394; x=1762052194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfE2kMhhbNGjJf4FBWUzEJkfsNPGT4ktOzq6Ee9jcQo=;
        b=wQ+Ebhn2x7yiuK7JCfLx/C52KR3or9FveZf3lwfO5KTja38/Fli104y1SW38d3ZVHS
         vyh8vdIbrcLdreGGiUlc8i1M1RLx4TFm3mhaa3Pe2zDWz975su4m5JEo4Ihn351m8b3U
         JDKgn4XIWJ+ueuaGnT0d9l3sMKA6aJasJpcxdTJINGpr20lX8EpSWAeHJypGocOO9B9V
         JEX5qGzcpj3itpCuH1oHUMmyx/G2HzSOE9iYJqKcXhO/kBW6IqggXy1oasSXPYgo8QJV
         hVmk2eqz48MZpRBUqUc8yrDU8nhHOtE3BHYa68bP2Nhb9LhUhOC6hSQXUdoxq9aDTgmo
         lDyA==
X-Forwarded-Encrypted: i=1; AJvYcCW6gzfl3edy3Vr09lu4c8NUyM0OzXsbHil3IRwASiEptMtVzC/Ivf6wIDb8FWmwYJUHPjzZtC1Fp/ySPLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTv7ygcARQDnzm6yzXMKyIvcvgUyAIrD+nNczJMHUOEmgS6qu2
	fTH243lXPezuoF/r+WF2vpvQAEfrE3prLgTC8UsroIFCuBmTmyIbDbql
X-Gm-Gg: ASbGncveJKSz3MGdXSrTg6HzVX99AeL0OADB7ocEcgrzfvRH9V9NKNpFrmDn1YAy9X5
	tVIUvCBfEVqDaglX13xYlVEXoRnw0+nDWv2/D8I46MkVhNUjpJvmbxyXpG3DHAkCcBYpqJr4WM/
	D1WOla0kcFCU6bFTAlHeTUhsuyCoOzulGJTgSA3eK8WTM2RoYXbwoAtp3g2OAn+rdAfurW2Ol58
	XRscZy1X3GH/2sibFKwCdhbSuwFulot04B3Sw/WI+eJ2EdWC4Irldmc07Utnr26eUrhKc5ZhxdE
	qi43mFnIAGTjiD+aEYYxdfo4v1zyRChCITb4c/KMpQVTuqJTzONF8KWm3AHjwAZZKMKSt3Lmscv
	izy4EsW72hhSWfIXgS5ggY85Wrv7RlrMifpUQSh1yasyKIMJz+OV2i+fVFbcciF2vagb1I8TsEA
	s0TeTAbVAAfrPa7xtS
X-Google-Smtp-Source: AGHT+IFEvi5BCIpNjIAk+L8wx9AmdLN0mDrqj0eQcdBvzBhQkclB5kD87AXiHagxZsym14ibMVgy2g==
X-Received: by 2002:a05:6102:50a0:b0:5db:242e:71d with SMTP id ada2fe7eead31-5db242e0a11mr5274445137.37.1761447394606;
        Sat, 25 Oct 2025 19:56:34 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e592e61sm1359406137.13.2025.10.25.19.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 19:56:34 -0700 (PDT)
Message-ID: <d1a483dd-5405-4e8b-8a38-816d49fffbc3@gmail.com>
Date: Sat, 25 Oct 2025 22:56:32 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tty: add tty_tiocsti_test to .gitignore
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 khalid@kernel.org
References: <20251024161909.327158-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251024161909.327158-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 12:19, Gopi Krishna Menon wrote:
> Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
> staging the build artifact.
> 

Why do we want to ignore building this artifact? When submitting a
patch, it is important to list "why" something is needed. Not just what
is done.

> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  tools/testing/selftests/tty/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
> index fe70462a4aad..2453685d2493 100644
> --- a/tools/testing/selftests/tty/.gitignore
> +++ b/tools/testing/selftests/tty/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +tty_tiocsti_test
>  tty_tstamp_update
Thanks,
David Hunter

