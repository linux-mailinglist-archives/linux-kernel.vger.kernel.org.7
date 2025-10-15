Return-Path: <linux-kernel+bounces-854398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1CBDE455
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B321D19A4570
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CA29BDAD;
	Wed, 15 Oct 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il85oQwJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119BA34BA5A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527885; cv=none; b=H8OyDMpoXh5o0sgn9ooCZxqMpl0/WoKnYy69Hkk0JtxIxOR3XasRqUMIfrr6Swm++axVAsdtVpMBp7rpfl2D/QGWQEwdr6Xq0nvrNhhzqi03BnC1IxbI/htbX5/RrcluQOcHBNUvoxe1VeFlrYQSyjj5xVYSjua9p24NgdQlF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527885; c=relaxed/simple;
	bh=gcBpP1ZhLnY9zOIftFnmJ1Hum0VuILkD2+x7sHEaLsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnN5Y9CHvV54P1jrJIyIIcektAG5E53z+3F/O4e1Mz7S0J91KI3pouGFfRnyJ/A1Mz+gbiDsOjjqnho+bkV97KAl8qxfAp6GiWdGTnc5w//GEDDd0AIHWceheVmhxt0K/81ZgPct9ofZn2RicsVA3BLE4cgOq7IlBrriysbZxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il85oQwJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e29d65728so38564765e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760527882; x=1761132682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1heHxgcOS8YwObtzwumeQPol9GYSJNTAFquV9NKRtlU=;
        b=il85oQwJ0UHFp6DDp/XGKwp3O2CiG1No47h29lKd7zzNmrEKXa5+H0ERooGFR0rI5+
         MWKYQBsKwKn3L3o5kdt63LJHFdo9TmECw9uSKlTs/khaOFkh0PrJYUcmqOWcl3WYAVOh
         ICGuZRtPuI9CCyiTIvr+1LaWPfMHxzfVbrPGRTAscbeJ94FSYoN5GgHNWpIwU1eKcE54
         tPZ4d5EKz8tRS27foldVo+DHOuM0CHhaR3N3Ems8ZDzemMqvu/aaOrtSdVgd98zxoPav
         MfYCXfEWzDAsh/KVy468XxlxEOVnPtgdbVj01/6/aaCbm9rKetMvdfJIo9sxSzE6r1h8
         uzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760527882; x=1761132682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1heHxgcOS8YwObtzwumeQPol9GYSJNTAFquV9NKRtlU=;
        b=tf/FNSVTt22uykmkT9kDcUQArP07+2M+1QKMJ22Gud73vJPGz63G3QWVhZnNwiF/JP
         nRexVzJF/Wb4EJElpy1sgOmf9Sx8U0jT7FYQxWd/AT1K3Tv9s4/tcDXn5Jh/5dlq3sEp
         0Nd7g5XV+etNKeKVaIC/f5aqDpwP910ZoHdYfFr17DQFwhQRu51dq2WAzA7eFkMp0xEr
         kuzWgUQ+wAz43nK0/gITkx+qO9Ee7p4eex6qP6S2uXnTPzITM//IitzEmJJ8ddi/FJPc
         wv+v39BzGk7EtzxIbTZfPtn9RlZ1uH+M+76E2POHPc2OHHr45FHJi9M2vG2On3CHBTj8
         G/Gw==
X-Gm-Message-State: AOJu0YwustGZJKTtRaEkWsyZQNskNu7uc3bWrpiVzcdGgaZu76Ec+KMk
	IXmassr6fQxVWbiejcQVx+ylC9Bt7YvrBtY31C3f4bekNdrfNEDKxZ0C
X-Gm-Gg: ASbGncuTnU0vnm8+9KV8hP8J+AxBR3tDN/DVZdgnLZUUr1Rv6ZBwSrEpX79QcFBU7lt
	5acqD4r9u3QwEaszgVyesKCWsCdzbmMtCKG/2BRa+mYpwnbvDVroc7/IO3CSmzGlOF9ZJ7l91c5
	wNM/GYe6WO8me1dWIqs3glZpOrDcoXhCv6kflCrENx/9iMQsP2Yt2Sjj+6r8B75zD6lEMvp9wEg
	FPrhJFJbJl9nWRU1fb6+dNRq+QNpGaugTTrTFyCdL15uVqcJdd3NtNpJebX7ujOzEsMMbIpDyVc
	9M/F19m+zyzDZwJjMtoPw9rKN3UiBaVqA/VP4ReX7baeaKaTiErnnIt2LvLyzJkNm2jsxqiqbpW
	IFmSlz3RDAJ5+ELF6RvhbA8oWq+GDyaUXBoqUD+BUH3bpHITxvTsqa5FquC+KjRVk
X-Google-Smtp-Source: AGHT+IEeavLo8qVSuJwHNTWrRW06IU4UTyYKKnPwZTtIeJz/P9Lq99v7vONin1VzmnIQi8i+dmkz9w==
X-Received: by 2002:a05:600d:416b:b0:46e:4922:6855 with SMTP id 5b1f17b1804b1-46fa9a86398mr211178975e9.3.1760527881992;
        Wed, 15 Oct 2025 04:31:21 -0700 (PDT)
Received: from gmail.com ([51.154.248.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2d65sm171470575e9.2.2025.10.15.04.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:31:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:31:20 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net
Subject: Re: [PATCH] MAINTAINERS: ipack: add ipack.h header file
Message-ID: <aO-GCH3rJfqJig-t@gmail.com>
References: <20251014030038.759222-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014030038.759222-1-rdunlap@infradead.org>

On Mon, Oct 13, 2025 at 08:00:38PM -0700, Randy Dunlap wrote:
> Add the header file so that get_maintainer.pl will report useful
> info instead of just linux-kernel@vger.
> 
> Fixes: 14dc124f1b2f ("MAINTAINERS: Add maintainers for Industry Pack subsystem")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Cc: Jens Taprogge <jens.taprogge@taprogge.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: industrypack-devel@lists.sourceforge.net
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20251013.orig/MAINTAINERS
> +++ linux-next-20251013/MAINTAINERS
> @@ -12216,6 +12216,7 @@ L:	industrypack-devel@lists.sourceforge.
>  S:	Maintained
>  W:	http://industrypack.sourceforge.net
>  F:	drivers/ipack/
> +F:	include/linux/ipack.h
>  
>  INFINEON DPS310 Driver
>  M:	Eddie James <eajames@linux.ibm.com>

Hello Randy,

Thank you for your patch.

Acknowledged-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Hey Greg, could you please add this patch to your misc tree?

Thanks,
Vaibhav

