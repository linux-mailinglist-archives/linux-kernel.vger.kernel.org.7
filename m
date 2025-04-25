Return-Path: <linux-kernel+bounces-620914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B478A9D146
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A094C1A25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578C21883C;
	Fri, 25 Apr 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eekEHM0U"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2ED17A2EA;
	Fri, 25 Apr 2025 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608588; cv=none; b=rT0YaKYomO9oH95mGA+MO/0laLstn/PzS4cfKgeK8ZuQisvbvLAkXVO/dJg61KZavcbvL33kZIMX2yIYL5JekSbRBPR6dpsx5jTrTgjSELCl9zEnGwukpJVIwxGY8VYjPPP/GXVWmEGW8Q4oE9g/Pw2J0Wv7wgpUYL75ESweUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608588; c=relaxed/simple;
	bh=nEaUix3oPIX/PaONAjCuYq9Ttt6g0gRM4qf8bTjEmi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtgI3o2W///JRPRf2WfdklxgGAx6B8wD+O0qu1E9/kTI1SepsW0KCDcSDkM4F1OS27oOyf5352DoqH7xOPXhcVteY0Ia4jMFI87RvIFmJQHKA597DT4kcmGnYe7TbIlHafTQN7AmOxzraKK0iwZJ6rcKXU/JiOL/mBChkexV/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eekEHM0U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso17981265e9.2;
        Fri, 25 Apr 2025 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745608585; x=1746213385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VO7oZHom40xEJAYPz0FOxbbQYoxBp4f3tcyurz8ypI0=;
        b=eekEHM0UqtaLtsR1lhrc7UmjC5xx2K8eXK5KSV+sR0qGWjuf1gRujCuMjPCXIYfmlH
         Fh8TCu29VAMyIqLmr7pUrxpQVJse/GtFxWNvvFdYje+XHyw6ru2EnG3BQuyK0FRijv1Z
         FpBBmtKNLSgx2y3/zXiz5cM/PLxxElqYWL5+G8aIxyFQNNMBu6eL57XKeU0t73X1dE1+
         6qYdbplt2gLNiBUjez4oXEQBOKTrlnupYgXJySx6Fsq9nJwzNAPqebq3DJa2yhm4Fcik
         b/3b/1euNTeKMInbHLHX250+yA9FzumEvDzEc1CVgsBkI50iTkiXyxCJxKy3UEmFitrs
         NRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745608585; x=1746213385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO7oZHom40xEJAYPz0FOxbbQYoxBp4f3tcyurz8ypI0=;
        b=gFYIpVhhr/AgbzGo9aB35WQHZTn+lZzsJvclXLS6y0fo6TQ6uxhWK4kiDZJuBEIWlt
         I+cUVH065bLxAQv7CGogxKprlEl+O2avxfj1cseIoEmsTga2icblimt/jgxtcaFhkSSl
         MknX5L922y1Rgt89DyUvn/or/EBVWBjcdyd8zSx/CPMsbeiz0CHVXwo2ZXr1z0AB1bYp
         ygy0NmOgvHGGm+b2id9MbIXpcYguxTYiADBLegX5l01z6CH8r/H4EFx6trE3QAmmCq/9
         bui+oFuhOi0vbJ8ivwwyHbfYMai7dYiqwUeUYB0KZwOAdxXtWIfc5dfdQ2zMuHoS8MN0
         5Eyg==
X-Forwarded-Encrypted: i=1; AJvYcCWPeu3Qompexl4CWMRIHzQ0gyq0f+jxceC1wcIFAagfx5Jxyyrr/w8zIORxH0M7fZjiiWtv7sm21WUkG1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OMGLmJhYnhbMGRVGbgHhq4Wm6tszhGTb3+Zm4NpOx/Xa/4Tp
	1vVKwWc/LdLYEJTN5fDF4cf28PpycPLh6gHgREzTm5P+9pk45yRY
X-Gm-Gg: ASbGncug4qR1wcG9RikNW5c0ze7mXT6n1K54DmuBsLPAGWohh7oX4eFTGOQyg6WBXU3
	UvNJykV5RKUFb+3Hg7d6ReTG2WEnv4/qdE3YaqozkC8VoA4D42yMPyXD/VYjVe5pRyfTO1FIHz8
	ui3G8P/txXmjiDiqippB92pFp5+TbRbRVTJovLO5Xtv4YtJjhDoudqMCdhW61XUAFcl9SrCL/7K
	XqbuJvyZU/6kKkDkaIeiFWW07rSS3gsF6ilwoZxdqt1occ0IUxNdt82FPhFref85wibDfSQ3NaM
	TYuQWXZRAHp9ME1/wtsGP8LZc4GVtuqEyFNkqE1y71F3zj/JhJU=
X-Google-Smtp-Source: AGHT+IFX12NL7RP6Q90t5je39cjcLUJUZ9AAM9/NH+qVQigjZmAEq6h6vRch4MKKemikmmpkPRgpUQ==
X-Received: by 2002:a05:600c:154b:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-440a66b07c5mr33378965e9.30.1745608584948;
        Fri, 25 Apr 2025 12:16:24 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-440a52f8800sm34189695e9.3.2025.04.25.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:16:24 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:16:22 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/sha1 - Set finalize for short finup
Message-ID: <aAvfhkjhgIH5FYoC@Red>
References: <aAop_uMhxVh2l5Fy@Red>
 <aApN64n7i15ArnX4@gondor.apana.org.au>
 <aAqhbdiLmkHV350S@Red>
 <aAsCk3jtbAE7dPpJ@gondor.apana.org.au>
 <aAtnCR5jVAnjfR1i@Red>
 <aAtqxbkGYWRGX-Yv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAtqxbkGYWRGX-Yv@gondor.apana.org.au>

Le Fri, Apr 25, 2025 at 06:58:13PM +0800, Herbert Xu a �crit :
> On Fri, Apr 25, 2025 at 12:42:17PM +0200, Corentin Labbe wrote:
> >
> > No they are still there:
> > [    2.022921] alg: shash: sha1-ce test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
> 
> Thanks, I see the problem now.  The zero-length hash doesn't
> set sctx->finalize correctly:
> 
> ---8<---
> Always set sctx->finalize before calling finup as it may not have
> been set previously on a short final.
> 
> Reported-by: Corentin LABBE <clabbe.montjoie@gmail.com>
> Fixes: b97d31100e36 ("crypto: arm64/sha1 - Use API partial block handling")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 

Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>

Thanks

