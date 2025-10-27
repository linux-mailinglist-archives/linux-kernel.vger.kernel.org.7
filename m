Return-Path: <linux-kernel+bounces-871026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED9C0C422
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 909F0348D24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBA2E7BBA;
	Mon, 27 Oct 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjY2ucJk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F12E7192
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552855; cv=none; b=ISeUxSOxoAOMREdLIyxweDcDR+gaCeCUujaRHROcpehzWpV04NYpqhY2rsgeBXTyTMUuhohuxXjkCBx069vXsNq0JkaELkQQ5ppDbCbvi3/ToQ+o4EaXtMy5KHJG4EEPZqgM563cGbVDiO+Imxx0vqlNU0QKB3dnE9KlLFCttqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552855; c=relaxed/simple;
	bh=etqLAq7gFst0cSiu6SvH9Ue38STXBB7ceWx2V9z48vY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpOE2vcWw3rWH6qQp0Ru5G/8VFD7L/buzJYlA3j6LptsC1QNKJ07rayGNZjBwacRMdo8EEJLMJ9Eg+x3bjQuIDN3qLWJ+gbqRIs09QrYczB0TfXjVnHL7lfGFgZieJ4ZXf0/vCjoaxRUmZjmc7+VoCdf++xuvxAXb0yZBOUzYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjY2ucJk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42557c5cedcso2885407f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552852; x=1762157652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSHu/ivuk7OTgOMQRpfxc8sNj6kHssvRHTUG1SNhELU=;
        b=ZjY2ucJknPEr5TZb0i7UYyZcYgeYNPXQGodRT4eu7TGRopOFA0AWlOi8AVTlsaTB4o
         V2RiziNFJwmQOHqu1DwDye9JY9Jukubo2DeawpB5RC7yMIFvTk9SUiK47mkLMCn9/Bn7
         aSyybIFMzED2MSXcW6DjGc2M8cm0cOgh7bJGKFQ9vRUMjvXHbEKjsfgFNAAXLhlPbFBy
         FBd5+zsZEIVyWGdOm9L4ArbqSSK7BXt/AXIY9vurTR+CxEZGXJWkK1RgxYhlOInayRe0
         B9lrUw+NEMnqy431MnKpYrJVoU6Ezg7Tywuhq10ai6iTTmip3Ce4JKcFiqMSqgR8yvhS
         pgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552852; x=1762157652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSHu/ivuk7OTgOMQRpfxc8sNj6kHssvRHTUG1SNhELU=;
        b=u8KGuRWwF5uqXBkTXdx9rTlGrlhwo3pVlvvkv4TlnFNAOLX4nNgKBnUoA0/TxNbZXJ
         H7ebwLWS9fWIblPoUg8SH7nBioOeopDCxH/gBpNetj1D2jG56Nw8fq8fx3ZRJwQW5SbE
         cd/UxKE7ra9PbnJpGfc0p+DkfgCspNZTWhjeZIJv0s+LH6uS8vn1eCdjvqUXXWW8cwXK
         g2BECm7hEmY2jigeiJaeLpVa8tM50GtFDq9z2g8JretKpZUJk0deGENr16o7hnO8CPgj
         cwzs906MFyNS1nJoOnO6WY1CG3iSUIqmBtWQPU+i0X9B9kQcGNHOzChHjhyZE2MpavhI
         ylEA==
X-Forwarded-Encrypted: i=1; AJvYcCXMEvchQ/KQhNxogXGNyuoMfMji8LaYONrZzUdqZBaljtwTucKhzznjr/YrpTvUnICLjr9zXs4k3j2z89o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fGfA5IDXp8C5I1wjS/j6H+uDcbJh9W/fxCScXw3r36XlWpuu
	X7Qb7eorXhIICyM2cs8PDI6ALvnwUOOFFqVqKqgYEbpgEPlVYSUc0SNy
X-Gm-Gg: ASbGnctpSOQKlMbdoZBpqF8C6rM9+C+llnQoWHyLdE7pmRLJo/LDPGNExlTz2CMauKk
	6/RHNOuyJ47mlFKqZZ+aEyJps/EmXG03GgHlIiZdmX1iyCtPEh5UeHH30ad99lEupMAQthEYOL7
	YqWNzrqcUdEW2lBAoxxWu/Avsv2tM16Rvg4yifjBGal37iOPpK2O4sPCy8ojqXaSE19tvdq5MLy
	pTJG8UqI+R9Lkyj/txf/RnjeE1kEE6Qi205vYWXe350siT1RPDOO5RohO6xE1GqyzBwnzkhO1o3
	PWrCORRJMpbLHSuVcikZQtvKyOScVbfYEHeKIIza4U2DAvNU8kVBQyCbT9W3U/yFiTObYqC3lpd
	bEG+3DvvOmYwvHRQtjl4AYCOrH+vlXriVLjt9PbFESizYg1NLChdBk2pe0Sv82DhSYAgariE=
X-Google-Smtp-Source: AGHT+IFFKQfLGx2QdYO29wjJqWg+dPw9x5/f0UKf4PSXFO3HYbVj3gV1HeTpZudQpFAVTpuMJ53ygg==
X-Received: by 2002:a05:6000:4a09:b0:427:62b:7f3 with SMTP id ffacd0b85a97d-427062b07f9mr28406369f8f.33.1761552852032;
        Mon, 27 Oct 2025 01:14:12 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm13058047f8f.24.2025.10.27.01.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:14:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 09:14:09 +0100
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev, khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jiri Olsa <olsajiri@gmail.com>, sam@gentoo.org
Subject: Re: [PATCH v2] selftests/seccomp: fix pointer type mismatch in
 UPROBE test
Message-ID: <aP8p0Td0LLa6Odit@krava>
References: <aP0-k3vlEEWNUtF8@krava>
 <20251026091232.166638-2-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026091232.166638-2-nirbhay.lkd@gmail.com>

On Sun, Oct 26, 2025 at 02:42:33PM +0530, Nirbhay Sharma wrote:
> Fix compilation error in UPROBE_setup caused by pointer type mismatch
> in the ternary expression when compiled with -fcf-protection. The
> probed_uprobe function pointer has the __attribute__((nocf_check))
> attribute, which causes the conditional operator to fail when combined
> with the regular probed_uretprobe function pointer:
> 
>   seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>   expression [-Wincompatible-pointer-types]
> 
> Cast both function pointers to 'const void *' to match the expected
> parameter type of get_uprobe_offset(), resolving the type mismatch
> while preserving the function selection logic.
> 
> This error appears with compilers that enable Control Flow Integrity
> (CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
> on Fedora).
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>

Reviwed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 874f17763536..e13ffe18ef95 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>  		ASSERT_GE(bit, 0);
>  	}
>  
> -	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> +	offset = get_uprobe_offset(variant->uretprobe ?
> +		(const void *)probed_uretprobe : (const void *)probed_uprobe);
>  	ASSERT_GE(offset, 0);
>  
>  	if (variant->uretprobe)
> -- 
> 2.48.1
> 

