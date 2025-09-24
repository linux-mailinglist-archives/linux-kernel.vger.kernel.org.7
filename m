Return-Path: <linux-kernel+bounces-830042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDAB988CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9932D3BCFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103327BF93;
	Wed, 24 Sep 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apr75Ugi"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730B27B33B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699141; cv=none; b=BQsti72+K+DSHStk59lst0qnQQgEZhwL8m1gTyTKEFWuE0sdQ7J9efY9JjR4ui0N4oe5cXlhWYCIElAAsFcdUFRqUeBXFAOGNktxUaUVwX8kg+YSXk7lcVios5QRrmE9tttYkixgJPrewElrEget4hvpp2FOwEupK/MHW/zT/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699141; c=relaxed/simple;
	bh=TX6kI82yO/RlICOevJbAdNu2g5LXBtW4mVT11ZayfNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwFj4jtNjb95JXZG/o9imm8fMkhSPlzRX7Z+OxJ3dagUpvHlBWkc3+1KcfprW7x21kVmYW9zH9ojQ0UPTB+dG0EKKrDk9AyMLG4E8lBWaOQGGxlbMnT7VsRdgMSNn7Jb/XG62jjoipjlWAiqmotNuCshdXXX4v8pUI9Uw04qEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apr75Ugi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso11000559a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758699138; x=1759303938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ogATJZj1jG8raAY2zUuQe4EmJHk/4W4xvGLcmqNCI=;
        b=Apr75Ugi6SUfNBAH+kYzUGDTjoRx4+4tdqorCAQPRdi6ZhXxBv0peiMsD+V4puAl/L
         VnxwZSNbl9FiKKvSAqE1eYwjqdZWh7FJCNF0dlJCMq2k1bWZYIlAjQgIervtcnAm3t8B
         GN105YKAWQyS6/Cr/MiE0AtzMIVY2JD6Cl6oo5pZJOVanYffCW03eXtoB23UbA49jJ7r
         M37tNlpRwrjn7OtFzfza/vp/LuwUFXCQHnS9le2rzn9s9XBPgWtVSKHOOn2Jak7mhDnY
         wGqCR0eC89eG87mkj1IyXNs4+n6M1Xm2c52C76N990iZ2sIOpbDuxtQDSZpysCj2x7fQ
         cVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699138; x=1759303938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9ogATJZj1jG8raAY2zUuQe4EmJHk/4W4xvGLcmqNCI=;
        b=bM/ihs6zN+zc/tgdI8BUrr2cK/jsGux+CoAM3IsSfLEs+T0d2OAo+wnxwzEEGMJ3hF
         AKeP8VOIirHEe3g0L03oFqp3Sck4yYywyeCpx+IAK7IN0Usc98QtYHHjRE3IyC+VmXml
         3Z2vCXAYP/olPDIYpU+he3bSbeTGbdy/IWJFr4J/JVo3ltsuD6n0jJFnI4UUlm50bbY+
         zTrU2A4q5exsDql9v7/FbZF3Kl53gUDtzaZwyPhv8tb9aLoMOc77YEZOUdtsHTfeHfKC
         zy0+krq/AwCs/o1gg2tr3hNtbbVeVhDyv21DO1tFwmTwf/kViNm34yiMk/FnS7gxMh3U
         5H9w==
X-Forwarded-Encrypted: i=1; AJvYcCUvhgOh9wv0rtr/uwwVRjlQ+D7WWgDM6SyK++pdrY8iNx5ON8yQR4E7zNbvrrwgOP+m1UyLUohpqwN0UzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/AlrfLn6BZTp6M0ay2n0Om7zFN+pSozxRJdysRwarz5fn/4r
	ZOmmQIM9YrDEf6JTbwXUXFLG21sns2eJRZuSf01jc75SgkSvfTNX6z60kSBdZr4gotX3BK1+5GN
	YP8KVCLdA+xtU+D9QGIA6EB1a+YYm0rk=
X-Gm-Gg: ASbGncupNegkQGhyUnO/8sP/BWWQbugzyZl9tnUiBYMmwSdVZg5WrUJPX/NNh3faX38
	KSGgLElkcS4OzAhXkBEn9neDgB/e0cz223BOcVzZn1rRkzCIdiQIg1+mONmVLdqHu/NkbEAMhFB
	i0n6omHN2b4bf3aVh+kD41T2GGzQeBG3IZIB297ulgBbOnjAZdSLq8DxkY7+k/EVSxbuwL3PGPH
	SvGBzeu
X-Google-Smtp-Source: AGHT+IEsD22J4a5V9bbdMWtQv1Ep8AmuRuA2KpP+ndq9VMyD7XFtjS94kSm5rlJirOSxMvazqqoNAsq4GX/ON5RyqyA=
X-Received: by 2002:a05:6402:44dc:b0:633:4726:a077 with SMTP id
 4fb4d7f45d1cf-63467796df4mr4258422a12.15.1758699137992; Wed, 24 Sep 2025
 00:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com>
In-Reply-To: <20250923235318.GD2617119@nvidia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 24 Sep 2025 09:32:06 +0200
X-Gm-Features: AS18NWBrVH-9-wBlZ7ZFV3RxYYp-7iSL9DfIPq4jDzU8rxFLx7xmKKzveUA49as
Message-ID: <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

> Suggest testing the same branch with the alpha patch reverted just to
> rule out any issue in the core code. If it reproduces suggest to
> bisect Leon's branch.
>
I can try to revert just the patch containing the alpha-specific stuff and
see what happens and then, as  you say, maybe do a bisect from there.
First I'll just try the same kernel again a few times more just to make sure
that this is really reproducible.

/Magnus

