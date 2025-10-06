Return-Path: <linux-kernel+bounces-843557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4420BBFB91
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E34EDC60
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B882317A2EB;
	Mon,  6 Oct 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jd+16SKy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75BA4A00
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790808; cv=none; b=N9qp+D7qT8m3YD8e0htXv/rvlczg+HL3D3WXEh7lgrc5eL5zQ8aBCQiey1b+xtuplS4DgQtogft2Ajo6OVuvtzH18xv7xD6CayqL9SQMY5777mupdDMqCByUvkjVC/LMQ4KOaq92NRdssZa3zLyT3vFUSsCED6kl6CTWInX93lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790808; c=relaxed/simple;
	bh=x01P2TojjeuexsK+/nsZ7KQP13rOvknnLZt/XjUyHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh5HBvba/bdYqOZP+DCeIo7wHRkt+zdp0FytKDrPeMv8W5RhGleaA2PC9e0oMdxMGgmflJWkZ0vgBD0Nztxn/IG5DBIph1pppCyEQaSaD1tVrFz92GFBEGdtHx7j9J+GZSroTujcMY/tj06vOwhOWOUDRiayCwL0SEfy8mFeadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jd+16SKy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2731ff54949so32175ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759790806; x=1760395606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKwPq2tS6q2Pu8otpiOWgoNVnScGXOXV+vJd0saMBSQ=;
        b=Jd+16SKyDVSunqwqGa+4t4ojHeZu2DH8Btc1W5U7HYANk1INJvQ1HIV47Pp+JESijs
         gTQJW2Gwu6NnlAlHTpCApFtbh+EQhD6r0qeJjGVE40rkA25X+AYt+279BBf5XEj2hYbd
         dI5XGjKP+MNhRE2gm2SQIK/crW7ijZmxj97jHVrDwifXYJY0aAxeyN8fcs6D73opAYl3
         r4pkC4v9oP2LSuV8PNCKALVGwHYd4yUvdoqWqMl2TiJad6qK6Q/jtPJ55tXtOnn5Oni6
         PUWUmA8B1udCt+ei/OZ5dghyBovsi3XkvrKsjE5XJQWJWCp64ttGJmtnJeG3EoY863Zm
         j00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759790806; x=1760395606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKwPq2tS6q2Pu8otpiOWgoNVnScGXOXV+vJd0saMBSQ=;
        b=Jt/M2D8pgRWyGS8gP06f6lTBc52xx8HxHSsVTi0c4ajACYDUqxv7WDT1aSSv/NEiAy
         kuD68qTpNc/mz5x2eFU74mJgm2D6VhdM/5YSpDRxoC4GZZ04Y1r7LcdAUrtFIBOFayep
         BJ9NRXuzf4gYA3xQ6u3mqLG601OWi5nuSqRX1AxQWua47TAGoAcB4nNlU+cTqC4V9JLN
         XbXbQqzT9qKH5tE+O8eSjwsxjYc/zz+gB16y2T6UxrCQx6X+q5l+7dQ1eU5+bJhwfKeQ
         9p/We+NveAktY9Yqv58CnSXPBbwzYLydGBxphCzE6+D6dUQeKewme+s5YS0LWWPQLgvz
         F7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUJabG1cKWQNtjvbFPWS1u9AB0gyPQyRxlRnagRSl5lyODImcwOZl+m2ihSRb4GVSB1wvXV9fu66pdcEPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jx3yrGtS1PgaimGq9FHTExLjCTZNw8SLmJy8fO16gEdBcAXi
	8T1VV0sLq8cH5dXi1hP11QO8bwMUKgy+cEpgwpD1NDkIWGkZUXe6mIEoe5bHaZWfIQ==
X-Gm-Gg: ASbGncvI9AssDacbS4/jVP/PvGunM9iTSYIjYsGnSkYqtvfIPkpg8KP2MQb0X2Vysyn
	9ZLsbTr4uTTz/LE+q/0zxFb4eXV2uhNqCpQ5zj2U4LgtxPeUE7vN3EWliHCcafqcbuPnpq8l/Z8
	ndxLKouVrCNycTKQi8cTEm9oI5s+g4s7UFFft91Vhv56TqPgMOWlAItPm5ugh+CvCarQdZWgJVZ
	zVhDVzN0dykvhWHSwOwBu6jnno3teqiDjnGSUVQsI5mdIelIqEQxcKnHnjUyiqakv4VyOFfUCFu
	mJhVeKjRX29rRdcpaOp1xS9xFAL9AG/sd0McYk4/Slsu/d5TJ/eYPSG+ajeeubJ+P7T80ey7NZt
	q/ryyeK2Ujo0DPJmFGoXOD3CWtsy83Nr9GX8F3SjBqzrXBHKcJXGcgR/QrgV6YDqh2IkA1stfTR
	VTqxEdtECwKP7zwklwFRJgUZDKDJu/x5Mynf0L4HqJD9wyuaQrSF8XGB6jXToZHfo09n9+iqg5K
	Q==
X-Google-Smtp-Source: AGHT+IHqyt+4O5gJK6ew1kRjn8+Dq2ThanBWHG7BaaZgdscBo65q78ZeEiTTskU9WlxSAQBJZInbhw==
X-Received: by 2002:a17:903:13c6:b0:248:dce7:40e1 with SMTP id d9443c01a7336-28ecb74e7c6mr739735ad.9.1759790805276;
        Mon, 06 Oct 2025 15:46:45 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a19csm11793942a91.7.2025.10.06.15.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:46:44 -0700 (PDT)
Date: Mon, 6 Oct 2025 22:46:40 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools headers: kcfi: rename missed CONFIG_CFI_CLANG
Message-ID: <aORG0J52p71WSJ20@google.com>
References: <20251006184412.552339-1-cmllamas@google.com>
 <20251006220500.GC3234160@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006220500.GC3234160@ax162>

On Mon, Oct 06, 2025 at 03:05:00PM -0700, Nathan Chancellor wrote:
> On Mon, Oct 06, 2025 at 06:43:57PM +0000, Carlos Llamas wrote:
> > Commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
> > missed one instance of CONFIG_CFI_CLANG. Rename it to match the original
> 
> Technically, this was correct when 23ef9d439769 committed:
> 
>   $ git show 23ef9d439769:tools/include/linux/cfi_types.h | grep CONFIG_CFI
>   #ifdef CONFIG_CFI
>   #else /* CONFIG_CFI */
>   #endif /* CONFIG_CFI */
> 
> This is a cross tree collision, as
> 
>   aa34642f6fc3 ("tools headers: Sync linux/cfi_types.h with the kernel source")
> 
> was merged in 6.17-rc4 via the perf tools tree but Kees's tree was based
> on -rc2, so he did not have it. It only becomes a problem on the merge.
> 

Ha! Excellent detective skills. I totally missed this.

> > kernel header. This addresses the following build warning:
> > 
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h
> > 
> > Cc: Kees Cook <kees@kernel.org>
> > Fixes: 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
> 
> With all that said, I think this fixes tag should really be:
> 
> Fixes: a5ba183bdeee ("Merge tag 'hardening-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")

I'll swap the fixes tag for v2 as suggested, thanks!

> 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Regardless, I think the fix is obviously correct.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> > ---
> >  tools/include/linux/cfi_types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
> > index fb8d90bff92e..a86af9bc8bdc 100644
> > --- a/tools/include/linux/cfi_types.h
> > +++ b/tools/include/linux/cfi_types.h
> > @@ -43,7 +43,7 @@
> >  
> >  #else /* __ASSEMBLY__ */
> >  
> > -#ifdef CONFIG_CFI_CLANG
> > +#ifdef CONFIG_CFI
> >  #define DEFINE_CFI_TYPE(name, func)						\
> >  	/*									\
> >  	 * Force a reference to the function so the compiler generates		\
> > -- 
> > 2.51.0.618.g983fd99d29-goog
> > 

