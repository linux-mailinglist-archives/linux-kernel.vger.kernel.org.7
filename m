Return-Path: <linux-kernel+bounces-854656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11BBDF01A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172E9424AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CFC25C821;
	Wed, 15 Oct 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ewu4UUlH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692B259CB6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538189; cv=none; b=Iw1YovnUGh/hRHF1iFcwyc8/UVR16YNi+M4FMCopoA1elnnsJqhtXFFg1SlGRCwDq1Ita4ufG0/6Du07b/4zll7153bUXj2oseS94CPbMrcb3/M0jLRRDTbBzvOxzG5lger2y1RqZ7+bgIe/kG1bUBEi5c6CUzRMPZR5qTIUqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538189; c=relaxed/simple;
	bh=PAtt6LJWXf75EYio9dz/gTvlM96/DYgKuXEluISNUPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdiGilpeG88g0cW2hkH8TsXohTWOAcXOaH2XWDtlBdG34eX9qe1uneQYXF5+6FFpsbnuOVgwonDBzM4g0ss4Lws2j+0+I/s1JvJ3rfHjq/s0hu6tcHOihWeTiwCx+LlqwTyeASEwSJp8xibR8pNfa67+nPMOv8jEVvmHgjSSdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ewu4UUlH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso13061703a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760538185; x=1761142985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PAtt6LJWXf75EYio9dz/gTvlM96/DYgKuXEluISNUPw=;
        b=Ewu4UUlH+4pBSo9+9WLd3Fc1lhrubptln5vECsDvqMML0lxV3mn/0IGWx5a/WvBeVo
         4RaV4Bzuwodbclq7xpOk5uHZgse2exRR1RKJ/mtlCqitoF0r8Dczop3Zx/wtlf+xk/7S
         xiMX04fBVZ77Z/bMd11JzGwnaQUnmvbzbemZpIOUl1vrC17f5pm+Bd44EmsllE8RzJAM
         urnlJ83WYpPLA3vwO9r85oa70Cn7dQGT1wuEIrNV91cRRYJk/E7l6XnU8x8LPUhEFqvP
         cNeBGytia/N9JrUtkHrN59QlRZPB1OcP2TT4PmyvkEL7K4p1MUewjIrkIURhEstTmxab
         Ef1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538185; x=1761142985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAtt6LJWXf75EYio9dz/gTvlM96/DYgKuXEluISNUPw=;
        b=swtRu+vie7bd0hVPI76c6JVINPfoOSMu8bcpyj8TsZY53pSoaS8b7mjz9JhcyWbFHE
         aSPveN0NqYmlEvO0D2Lg9/bjWXbBZaWBSjBzbbX/axiTZM2g9r0d/D9HtdZWTcEj07+i
         8YTGXs/xAb9xtM8aYSCdeqUmiv7hyvNRq0OsGHZFAu6JA/MZlEOTQqn3njMPp468fMpA
         dLiv/47m2hFBzYsvLLTkjO3jH45APHhfC6sas4GMqhyP8Htj3bbFcVc+oaSI9CESNv6z
         /OywHwcLYERueACC5YnDFxMqczRfxeYHvivj8L6akBGM1+7w0MEhB2+L5rLKiAKOo4Js
         NpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFa6VkaLSSJNcOhtvaSUxVVuOfUuUXtuyW7zvU6RZYF3oHHCqDV1l3KGEXeShInt8tQw9G1YHFjVBx4Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywas0R4islH11p8WEiXE8t/20v7BXLvP1CWdYWxaPFAcH/QCLFN
	+UV4ioWNtQDPa6kNccrzXjOaCvWGeU/bbA8ZuWQVUdVNNGQxk78zLHI2Hxr8hZVcIpXkzCcwHZn
	+qhYU7RQ2kPwmc+4GUeNpBG+FEYLxrZs6nw0nrzGA1A==
X-Gm-Gg: ASbGnctXPhAsLotYp4KOuiSYOogg8p37itRHFniYuAm6HBCF9Ds/yECxMKlhOGLiknW
	Wfdbl6e/I5k1SOgTZ29PAS9omUUrQcNlpPBbdk8fvr7vMNTeVFaxmetA7hC0oF7JRfNeaxiMKI2
	y7IUQsT+ja1fXsEHKwPg+MheS9wLfruQk1zd0Ix0TzNa9CpDMmVydQwXmiJ2eF+GxgTappVXIln
	Vkh10ZtAbpnVFXr18a8kzSyGFXNEE3dsA==
X-Google-Smtp-Source: AGHT+IHt07hyRkueoFkR4F0w+xF9Gbyc+PiDwaAgXzfFVpNxzbBZcK46A+MFwX9oxnYBoVi3/21yDow56czseXIBw9E=
X-Received: by 2002:a05:6402:27ca:b0:639:4e0b:2724 with SMTP id
 4fb4d7f45d1cf-639d5c31fbfmr28772103a12.24.1760538185250; Wed, 15 Oct 2025
 07:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com> <mafs0v7kgjoxq.fsf@kernel.org>
In-Reply-To: <mafs0v7kgjoxq.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 10:22:28 -0400
X-Gm-Features: AS18NWArNFoBhagluGBh83EOX5thK2VCtA_UuHBzGdmFvoOqbuMsR--L8cHX_oM
Message-ID: <CA+CK2bAHk2JnQwfA0fJo1qmcwoO_9eeG5_DSL_6OC+-pyT=7Jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com, 
	glider@google.com, elver@google.com
Content-Type: text/plain; charset="UTF-8"

> > As part of this change, the metadata bitmap size is increased from 512
> > bytes to PAGE_SIZE to align with the page-based allocations from the
> > buddy system.
>
> The implication of this change is that preservation metadata becomes
> less memory-efficient when preserved pages are sparse. Mainly because if
> only one bit is set in the bitmap, now 4k bytes of memory is used
> instead of 512 bytes.
>
> It is hard to say what difference this makes in practice without
> sampling real workloads, but perhaps still worth mentioning in the
> commit message?

Forgot to reply to the other part:

I agree, however, I suspect the implication is going to be minimal, it
is strange to preserve fragmented state and expect a fast reboot. Most
likely, we are going to be optimizing the preservation pools, such as
using 1G order pages for guest memory.

Also, we are moving toward preserving 4K bitmaps as part of the
Stateless KHO patch series, so I think we will make this change
anyway, as part of this fix or as part of transitioning to radix-tree
stateless KHO.


> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you.
Pasha

