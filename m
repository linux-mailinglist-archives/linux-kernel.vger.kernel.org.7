Return-Path: <linux-kernel+bounces-803367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB3B45E41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F443A1DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55F2F7AA9;
	Fri,  5 Sep 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ua0hAfp4"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1B2C0274
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090103; cv=none; b=KMkSEdH7wpba6O1JgBhrv6rC1taGAtHnlsGF9GbYjUxaUOEbfp/rXV6hUzA72GZxZHIM9Ft2HIr6lD5xU9fKJA8cg7KEZHn5cwBGYwU/R2BHyHn/oWobujW5X4GqxSl6N0Jnx49DNETr5Pqv+w9LtzUvaQfAKIoADKtSvXkbWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090103; c=relaxed/simple;
	bh=s7SrPYl52WuWozmbo5gIbiNPa5h8Fo7Zn10BfZuwANY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMpeET948yDaoWvZbbij6SNM4zHYrTgBatHlzkwyhikof6fyO4gx/gT3HvdjGA2HxvvKW0GAl9zt5xbI2Dr8NMgN+2kbm8ERJM+BNP3hLog3gf5cFMl9WIIuP0HDAOmjpexh3PC8a2pxJwgqrxEZo8+0ysyo5vsT8OuwH5EQy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ua0hAfp4; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f93a6771f1so6438835ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757090101; x=1757694901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNJVMZejeJ0dWtaoJq/BzsUu7eg4eLar9GAHcQR+XNw=;
        b=ua0hAfp4+SIXjbLvQlXPY9K/wCoWcEOM1SaH+NuhyiMhirz59S/mwijGwsxp+6y8kI
         zGGuXFSyWLfYYA+T4uhWp/Hz8V6qDO3p+wF3uEKRdKO6RRC4QCeLbBGbflqeH7gscqCV
         5jgXLB06hIEaEQ4ePoOdcyC0tHQ6bMmRKjFMQgfcjXKykYjvkht/nd2qAM5hFS+Rf0Si
         X2NuJuDk66VkgVWfTwbB4Yf8F1npwtBl0VDVJFBVjiFAZ6/SKdQ7GJxAEH9/yhNJhJod
         dC4SsMdzHPKwLzn0FJmJ544cGS767tOSBkOrtg2x+qttDq8NiihpLnoIN53WVLYX0LQP
         8yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090101; x=1757694901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNJVMZejeJ0dWtaoJq/BzsUu7eg4eLar9GAHcQR+XNw=;
        b=SeVW/YGguyQ7W2VHlz22BDn/FwZ5vnbGAgHaSzyJ1IdqTOkoHFNeju/GwEACC1+54D
         nXd+Rf0wLBMarHUFJaEX3dbBnvbVpkTuCIsiV8tcNJWS+qs9WUJ3rlrlbhRJweQhWivs
         960AaiTcq9ICtiesnb1i5JYc8ZvYPzZJwxllYxsN68J5O2oyr91uBBo1+J+SUMDfPi55
         E8v5Kx9TuvnhzNq8H9B5d00ByrELdO2QNWhFIzMmjh7raWK6Imd9JlFY1/qp/zxoYRuY
         4l7tMsLzk2h36BtkOtWwkesQisOlPBg3JR6QGiwAnVRaI8hWuIbP13+svcw1FRLPI/zV
         Zolw==
X-Forwarded-Encrypted: i=1; AJvYcCXrgWQ77QQf8ZMonRaznFgxWPrOrwgVXkHf2tlrwv2SWFg/KAYIM+JnCe/3SW537Mz/w9EPBrGEQHLgveo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDI1LBOlCC55OUYm0KC19PUmLBybOynnau5LDPQxOLCXYZq0T
	fA3IjUEP4Hc6Qm2vlaNaiitna2OrG2kUxbjXOySbMpoOD2bSld9FnlcOGHLjJAswow==
X-Gm-Gg: ASbGncswYBtcjaYbPHiAeKVP6exBUxLKDXj9d/+xD4GlgXjXaOPFEGJiDTmv5pbnoTd
	4kzHGWJLk0y5JeDxNu0WaJhJFsVYl3gwMMdUyZipVToLg/AAbXGJHUhoHacxM6t2n0y3cY5ggM6
	AA952XGJwlCRCTklr6A3CwLs3tyiVK1luYD4rOazatqC1+/2wjsf6/uEwFEnXYOhTLK3tFffeab
	N221bbmgteGhADoX6b2ZYhL1zBII5wB5RfQq1pEFOWVnKAmSu1e8bbWA3oerhd3hsE7zlM/RTB+
	c3iZdMxjGVbX17kzDZo67XisXfgl7fKI/8S5YXsnymGiW1MGBgSya0o+c2Q00kGp5ivG9yu+TgQ
	Yeo/ayIuIvt99jrOAYRqR+oA5JURcqA/zF4GF/ko2nC3bNcr7G2r086ZlX9KoB1WSjQcDqTbWGw
	==
X-Google-Smtp-Source: AGHT+IFFNvKFGEmjvy9xgKPnnOq+Go0iiWzE8ixq+1GtVP43Q8XMv1fd8zP0NU6M6xvxRKA9GPLB4g==
X-Received: by 2002:a05:6e02:3e06:b0:3f8:b464:6d1c with SMTP id e9e14a558f8ab-3f8b4646df5mr45284865ab.14.1757090101071;
        Fri, 05 Sep 2025 09:35:01 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ec9c752a1sm5721324173.26.2025.09.05.09.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:35:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:34:56 -0700
From: Justin Stitt <justinstitt@google.com>
To: Paul Barker <paul@pbarker.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_compile_commands: Look in KBUILD_OUTPUT if set
Message-ID: <3fya5rij6amcwt36jthyezkzov44m6rdvlacymqfpbkcmzrnw4@fymsxhcqq6tj>
References: <20250905-gen_compile_commands-v1-1-9f5194542d4d@pbarker.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-gen_compile_commands-v1-1-9f5194542d4d@pbarker.dev>

Hi,

On Fri, Sep 05, 2025 at 11:17:43AM +0100, Paul Barker wrote:
> If someone is already using the KBUILD_OUTPUT environment variable to
> specify the directory where object files are placed, they shouldn't need
> to repeat the same information to gen_compile_commands.py.
> 
> Signed-off-by: Paul Barker <paul@pbarker.dev>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index 96e6e46ad1a702cb0fad5d524a9a02d222b236ec..7b94a2ffba0b4d5f1290b51bd602fb3f33acce6a 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -39,8 +39,9 @@ def parse_arguments():
>      parser = argparse.ArgumentParser(description=usage)
>  
>      directory_help = ('specify the output directory used for the kernel build '
> -                      '(defaults to the working directory)')
> -    parser.add_argument('-d', '--directory', type=str, default='.',
> +                      '(defaults to $KBUILD_OUTPUT (if set) or the working directory)')
> +    parser.add_argument('-d', '--directory', type=str,
> +                        default=os.environ.get('KBUILD_OUTPUT', '.'),
>                          help=directory_help)
>  
>      output_help = ('path to the output command database (defaults to ' +
> 

Thinking out loud: It might make sense to also change the default output
path in some cases but not in all cases. For my clangd setup in vim, it
does some discovery for a compile_commands.json and I have some
different ones in various build-* directories -- I guess it'd be cool if
they were automatically placed in their appropriate spot. With all that
being said probably YAGNI.

Tested-by: Justin Stitt <justinstitt@google.com>

> ---
> base-commit: d69eb204c255c35abd9e8cb621484e8074c75eaa
> change-id: 20250905-gen_compile_commands-b03d9c923fe5
> 
> Best regards,
> -- 
> Paul Barker
> 
>

Thanks
Justin

