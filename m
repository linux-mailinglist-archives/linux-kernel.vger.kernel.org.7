Return-Path: <linux-kernel+bounces-726311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF5B00B90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B0E1665C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C72FCFC4;
	Thu, 10 Jul 2025 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="A4+iNgQf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8921E8333
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172983; cv=none; b=HCPOUXf5vq3Lwer0TC3VuE7Ih3DZnbZACb8PnIfYMgJIk6qf1rFYIEC+e5z2mWur49xB/0lZIRQhHrSb5g17paTJa0zJa745K4S9xd4nZOKQxFv6y7T4eq3b5IZUaf9Bqex2oGqDKHQzNlSpt/KIle1mM7lrR9p1GHzELcdmef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172983; c=relaxed/simple;
	bh=N4FGHT9UKyezhJn9onH43AIRNMggWVE+Fhq0WQnJ3Qk=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=k0uN7ZkNA5cS5CL2yiHespywyzZtRq2wSLUFrBsMs/PX+bjB3JMPO+1rYhHBS0EdxUqbB8dd00Dvlj7IT3eZgyq3kF5MMtnpOaxX/QFHE3b28n2NP4FXTkDtSwf+bg1t2Bf06sf1lxV4MqWZe4hVx3cugU1GEHbR475dOOMgLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=A4+iNgQf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235d6de331fso16671695ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752172981; x=1752777781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnY/8UVdnX8e8enjBQ6ujPEYmM4pw/IZppWwmW1hvEo=;
        b=A4+iNgQfGlppxaBmlcFLrVVlo9/I9vgunWnHuVCwpKpbL43KcNG+ZbX79b0NRZuleN
         uh3JpoQyjXNWq15upM9J/o2lDHt2YgsKAZYOwdxF07+V1OUhZyt5AyHzjxQyUTquqsgA
         I6ZYiY8bAZBm7l1lGf8KgkJ3EoGml07Z6Gd8zEARJS7uqwvgJ7sGLQrg8jU8qjFLms1M
         uEaWNfBy0wat07kTtS9yvDXsZXx5y/I0WOqHBa/chzs0oM/Ya88G1oxIoDWFS1ea7Uyy
         dukOAdIfVd25fB8jJiEyJQ1T6icJCbC+ttBNg1rleS570gtyXFitGNp9NQ8PLTZxMrFe
         39LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172981; x=1752777781;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnY/8UVdnX8e8enjBQ6ujPEYmM4pw/IZppWwmW1hvEo=;
        b=jJw9ldV85/yqUml70f/icg29Ue4AcRcjzr4KIREVuZqAKN1mEV5oaXHyZdyd2tI9oh
         uFqxR3Kj/HBr4sqvymRDc9gS8XojTjCdcg+8Z6T6ztIHBV0b9nvU3FaGR6FvG1bdT+lo
         /ZbfZnj9riAKLDcHklt5JUcRuj/+73PHohJJ/WaLluhHOcwG8PNfng7NEcd/q8HwM1i5
         ZYLzl61fMMdlqQ5BuuIc5DbAeBofFdOBCHH8pRyNPNGw2b4KEbshH2vLpMMhoklmKfTI
         REX/AjWcoau84O3XmR9L88Dt0Ff3FaKlJSmR5i1OopBUk2xLwA7Yf03k0hYE68bvx4Ib
         DPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY18lhfNv8RUrRdkqTpONgxIwCFYCE6lMnK+XPNQKrtTdwm4AqK0Rmu+qfI/QXsgAcknFOwrzNHeck8RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhCWN7lMvvdnDB3IBfKC6kofQ3gDk5MRjtGHqZCqoHFEjcZAI
	i1WsUcD2xCZcSCguqo/8RV4qeI499v8ZZFilOzeg+0eqDgjC8qOwSSJsBWkehLg0u6o=
X-Gm-Gg: ASbGncvJOOzQ2ddqzM7G7vOOPg2oNq/sMfwIIVBvQ737inkblMBG9WKq0xpq26R64SJ
	8dGJAk7BevO+O7Ojvh21ZU4BM6rj9goMyhss8c2cyiez7aP0apXcuC3jZYmi7y5qP4JJuOA9YSz
	XkgtFMzQ2s1XHiZcwY1GTZIToJP6Baj7nyA+mbT1wxYu5RkU9K+60koxmueSp8pTRZ1N+1xgRJV
	iC1Jm92ehkGdT3Gv2hCd/mPv11hdIGd3fXy/RbVLzGSJ/tyX7eGv+ZLleEWTe5l0lABqyUlki9J
	Q85hj35UMkpNePoeNZ8DftbNeWe0htsC6+78Rd9EcTH/aE7X2pauVpGNrfELEHel4fvonUQ=
X-Google-Smtp-Source: AGHT+IHMJ/qK3aP4OSEUQCPGpk+pucneFyglGnVh+UdYApQipUCIF0rMuuf71VK8a5/FxU5krGo9cw==
X-Received: by 2002:a17:903:22c5:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23dede96543mr4062745ad.46.1752172980662;
        Thu, 10 Jul 2025 11:43:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::7:a219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de42ae9dfsm26936225ad.73.2025.07.10.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:43:00 -0700 (PDT)
Date: Thu, 10 Jul 2025 11:43:00 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Jul 2025 11:42:57 PDT (-0700)
Subject:     Re: [PATCH] riscv: Stop considering R_RISCV_NONE as bad relocations
In-Reply-To: <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com, Nelson Chu <nelson@rivosinc.com>
Message-ID: <mhng-7CDAD4A1-707B-4ACE-BAF0-643C281B9AD7@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 10 Jul 2025 01:34:31 PDT (-0700), alexghiti@rivosinc.com wrote:
> Even though those relocations should not be present in the final
> vmlinux, there are a lot of them. And since those relocations are
> considered "bad", they flood the compilation output which may hide some
> legitimate bad relocations.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/tools/relocs_check.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/tools/relocs_check.sh b/arch/riscv/tools/relocs_check.sh
> index baeb2e7b2290558d696afbc5429d6a3c69ae49e1..742993e6a8cba72c657dd2f8f5dabc4c415e84bd 100755
> --- a/arch/riscv/tools/relocs_check.sh
> +++ b/arch/riscv/tools/relocs_check.sh
> @@ -14,7 +14,9 @@ bad_relocs=$(
>  ${srctree}/scripts/relocs_check.sh "$@" |
>  	# These relocations are okay
>  	#	R_RISCV_RELATIVE
> -	grep -F -w -v 'R_RISCV_RELATIVE'
> +	#	R_RISCV_NONE
> +	grep -F -w -v 'R_RISCV_RELATIVE
> +R_RISCV_NONE'
>  )

I'm not super opposed to it, but is there a way to just warn once or 
something?  It's probably best to still report something, as there's 
likely some sort of toolchain issue here.

Also: if you can reproduce it, Nelson can probably fix it.  I'm CCing 
him.

>
>  if [ -z "$bad_relocs" ]; then

