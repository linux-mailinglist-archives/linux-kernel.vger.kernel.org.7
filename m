Return-Path: <linux-kernel+bounces-788291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B7B38257
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19022189757F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352813054D4;
	Wed, 27 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FwJYw79x"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE22765D6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297692; cv=none; b=vCtRy2ojmo2F7cKzUJHjQIiBSwEZvAYHOwkEo73g0GyKf4aYN8UurxLJOdJyltBt0MLH7RvNZ1Hyb3eyBt4ouPevsGXva9nIcwlCP5xoKl6JG4Hn21AOPoNvliyGMDuqn56qJ1abOLJuJGhxJOxD2BH+iv2k3YFHLdkIlGYl1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297692; c=relaxed/simple;
	bh=cciLdDNWk9AkjK+8HEt0e9tOL/3D8lMjgC3N+oRQBJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiI4mrjQ5dMoeWXc+bCnZFbW1cCLwlMwZSSDliiwDmjDyrM/J4BcZ2whvl7b9hynRio08vZA8W1XBF6RI2Q/0Id2IbgcLnBFAuLWK58NMCH0F6lYS+ALJfHpBLLemo0ilPrIz96pHAOTKs65E0xXTWmzBvxiP/Uv4FXai1yLgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FwJYw79x; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2d501db08so38022891cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756297689; x=1756902489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cciLdDNWk9AkjK+8HEt0e9tOL/3D8lMjgC3N+oRQBJ4=;
        b=FwJYw79xLXbdZ8iStPGTmElOefELzvHDRO6bMAQtdejH8iZ3JcPVRkaTzFFLoP/vf2
         YDvrZjGn/HhvnZadGUadIDuvtX3xukXyflx9MkDBbHfHYbiWUcXInFusLuiiRTiqwLTk
         y3Syc4i7U8m+zW9faqX4w8GVkpJDebOqyKx/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756297689; x=1756902489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cciLdDNWk9AkjK+8HEt0e9tOL/3D8lMjgC3N+oRQBJ4=;
        b=MWjzLPujvgKoLw2sXshem4If4sDVyZjReJKStYpFppryU5YfJvTiplGAhjDHzuJX6h
         s0ccSSeGm5bXYpXpGMp3MXbpbbt4KpSBTBWEBLw2Pg6dR/2Twr1P8ZgEzqVQCggFPhjh
         usAwdO5biYpCPIFWz2vhhgEp8YQL/gkthawNZo1j9gFqKC9RAoqYI7vk0pZ+sYDQrN73
         fn7yrsNtrIw0uQsZbiL3fQ4ZaxoYeLFh4XdBMrIbrs5MCSALS5HYJvFWQrMeUv1LjE+K
         ZRiPg+fl3KER7HOJL0GI1Xv0ezQMkrn8AB++azfVJ/jJc/F2W0ZvTkw2nCiA3/r7+fNL
         ZCfw==
X-Forwarded-Encrypted: i=1; AJvYcCV6dM+W1b/rapttIdlg0MBYlELx9AcxG8NMWKxPJ0Lp9kdgwQJR/0gieQrvPzZxUCWxGJmRr0pYqRwSW58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpqYEJoA83LJ9HO8jEYrPG2tUuBl4Drw67/vH7PGCY3BxAogZ
	E8jwwTphFTfuWDqZijYRr3jQ996pY27OOvIWnuLGC3zOw+7j+Uy0AUOGVboMv8zvz2OUCVs6tD3
	kGQhY+z5+aqAdmUTbYByoS2vBn10lROYwDQsXUV287Q==
X-Gm-Gg: ASbGnctNAk46hKXxQoooTIyPPlqJ8Z7yD57vJfDc3vYHQRO+qiMKVgSdlqhKM9+prVf
	4E0lhrkgKK5M6IZN5QuvXWMZdB2f2YxcsoGpp8NRs6yQHLZliUNDMf7UaqbAXCkpI/usUFIUrRZ
	L8OvTheWB7n90qd41QmJ3oUaP1r1ivBAkNpKKg/bs0u8iDYhTlQSnhWH8+xUkMsKuPlOzvEq1Q1
	O041euOug==
X-Google-Smtp-Source: AGHT+IHFYGUTAdyDScXL1Kg7O2sQVX4H/OlxaHU5YMXRscRKJZZrM7lhYrK13HVT2pm1fj6alcTWhr+LxU1+oYexl2c=
X-Received: by 2002:a05:622a:353:b0:4b0:b5ba:bb9 with SMTP id
 d75a77b69052e-4b2aab06870mr239441681cf.56.1756297688908; Wed, 27 Aug 2025
 05:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1acbc80OLZe9Pf7a-8HPRmkJhz=bZVRPOnJQWB78neVVg@mail.gmail.com>
 <tencent_35D325E7BA1BBB7B33559EE41B034B1A1B08@qq.com>
In-Reply-To: <tencent_35D325E7BA1BBB7B33559EE41B034B1A1B08@qq.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Aug 2025 14:27:58 +0200
X-Gm-Features: Ac12FXzdFXIBx0ILGiBZiGUPGjukWoMB-_3YB01BpSNAgI64WyRfmrS4dRFP5wU
Message-ID: <CAJfpegvk_KT7cnGDYbfBwPjQ68a9MkGrOa0Sva6fqYe3o_68cA@mail.gmail.com>
Subject: Re: [PATCH V2] fuse: Block access to folio overlimit
To: Edward Adam Davis <eadavis@qq.com>
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 03:46, Edward Adam Davis <eadavis@qq.com> wrote:
>
> syz reported a slab-out-of-bounds Write in fuse_dev_do_write.
>
> When the number of bytes to be retrieved is truncated to the upper limit
> by fc->max_pages and there is an offset, the oob is triggered.
>
> Add a loop termination condition to prevent overruns.

Applied, thanks.

Miklos

