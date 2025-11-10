Return-Path: <linux-kernel+bounces-894294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DAC49B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27FE74E2BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78C3301716;
	Mon, 10 Nov 2025 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3r9yfSy"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACA2F5A18
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816052; cv=none; b=rtW+obPKOVkkJqKbXB25h9lrE7zsWb0Y0gmIaBCFpPHn7Tey8E8Ed0FGCPM9Kep+JRCMUvsdyUwd8Rx6QY0ZWc6azq3qDzmfw82z1CpPIQKtQAfp1STnmB1TE4hwnbsae6+4Iuh0FZF7i50CpVAm9Vmai4a5B6NDaVg8Jfts/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816052; c=relaxed/simple;
	bh=ifTxb2fd80Nni8oK6meGxFKTiLW9n9nNKijfIBRIngE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yzx6OdpgqmnknXMxjUFjSnhad7yQly+J5GmeWfbUN8pGwPL2rgU04Stf+YOZ/xSTaNcXQ7n4bcbziBMF3Dm9L9GsIcRm49ARpyquU39PNGpfvgRzqwBpOX4H7/9vP6qXOvDtpTlf6hjUVKt8K9rX28jFjV/3T/FBxlgWea5qpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3r9yfSy; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018e9f902so1741474241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762816049; x=1763420849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+TEDRVllKiGheH9iPhSOnW7gc7oRa0YYtno5v9NCzU=;
        b=n3r9yfSyKE3IzQL9ORE1ZGcbG2uG7P5DX/Kqy/pLHe7WgBgeA2/PDMV+QyC1dFX2sx
         aIYtfX15fX2KuU0DwHQMlNT4rISWqVJyj9DEN+bwXDPP4djO+vQ85KQY7ZGGpzmgpNas
         3IVs8UZCbOmw9pfLkfNVerRp0fi3nhtDBFtM2MpDo0anbd0HoKpduCQTjuxZ26i5ycUD
         PKBGTo61avn4/6a3kUTl0hmDxTcPLsSKUmkDC80dQPEPQYn//TRKRZ31k0ZPGlUIt99v
         jfEdJFncRUavicFX8KUK5Jo6qv7iCoY6RbHVa8NBELvUwy8WSAXLGCKU9NcMOgDfs08c
         qECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816049; x=1763420849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+TEDRVllKiGheH9iPhSOnW7gc7oRa0YYtno5v9NCzU=;
        b=eWRdfdSRjU0BePG/ROlztDN0vqCxcsmZfCHenIObHsABWVKtVQYrQ8SntVODFAIQ56
         B8ixXhY5i9QFyEAIbUnSk0sAOAIYpAAw3s0TC9/n6ug3MvBN6PnP4BX2TvkiTpu6ijfW
         IsGdUm7JGmBCayIIN9ghdsV+tgliGko1mNJ2py1J4tpQ68ZGbg8BsOdXKLjI3xu4oax6
         xoaaQjYml8QkHsc+okO742wcp5QmJ+ojCPtBhDs9/79pNz6eSwtrixcAUw7jRFly+QVM
         2qMza6WCMCOWUaTgPS6VNzrgWYnS9634VaQPRexRYIejg4KpYcxDXS6XOdNwm5g7VvJP
         s1cg==
X-Forwarded-Encrypted: i=1; AJvYcCW2fHQAz1oE4q9D3nhsMwY5ekWpRKv4pvH2pzuQ78SYEfbAwOuMRbx6tnDLO/2KtEYJZnQPkjMdShdGdjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdD2ip+EslkcajcAr3jJmGQuMgUCg+Y8LmjawxJO2TL1xXLulj
	bXgghOpwnQSlTDeGs4YV7ndx0d7SOY95DKBNkVyPofM18HBMOC0YscXr0w+L+J5t3VbO6vusLim
	AE8vpzKdidiTjy+mSLzT3k2RcdQEgDJfGhZG0TJEsIfpl20XxWVd7pCK1
X-Gm-Gg: ASbGnctsaG3T/uygg27Oj/zOwTwW/0pExLoIZ9ppuWBRhiKw/go7AEwvm2306zwCjWZ
	w4NC0CxcTWkcnTXbEznNj3gyztbMpS4Tn8CX6v7ecfF3CNmutcXiV92DVE3LJyk+TZHGnahVnUx
	v5OhF0jaCp952QY9V/wOPuCOBIwYDrXA1PlDv0s2hqDxU06vlmc9rjcegfJk7PJFQI5ENqzNxVh
	qStPPWQDV9p0M6dj2pxuq055EEexV8wZSBNjjOb654v3rk206Hibsm6OIjhZJnnmNe0uXCLbcb7
	xl4YsA==
X-Google-Smtp-Source: AGHT+IHjmwJDAFc2cXjg3msYUZA3lWk7d5XqAZpIUjQ6p7MF9o2gzZJ/MDrxTGoDvltOyMfSpTaTasHvkcT8023OaSE=
X-Received: by 2002:a05:6102:c88:b0:5db:e0fe:984a with SMTP id
 ada2fe7eead31-5ddc469b7f0mr3590347137.19.1762816049213; Mon, 10 Nov 2025
 15:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 10 Nov 2025 15:06:58 -0800
X-Gm-Features: AWmQ_blpug0sXFFcDvfwK6kurgehZgkyn7cusv2Dm36toryt7-1iUtP1-uzEui4
Message-ID: <CALzav=e5JD4_4+vqa6udd0dSymW7W-=8Fnf-q0VaBv20+BvXBQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
>
> Not all IOMMUs support the same virtual address width as the processor,
> for instance older Intel consumer platforms only support 39-bits of
> IOMMU address space.  On such platforms, using the virtual address as
> the IOVA and mappings at the top of the address space both fail.
>
> VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> respectively.  These provide compatible arrays of ranges from which
> we can construct a simple allocator and record the maximum supported
> IOVA address.
>
> Use this new allocator in place of reusing the virtual address, and
> incorporate the maximum supported IOVA into the limit testing.  This
> latter change doesn't test quite the same absolute end-of-address space
> behavior but still seems to have some value.  Testing for overflow is
> skipped when a reduced address space is supported as the desired errno
> is not generated.
>
> This series is based on Alex Williamson's "Incorporate IOVA range info"
> [1] along with feedback from the discussion in David Matlack's "Skip
> vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
>
> Given David's plans to split IOMMU concerns from devices as described in
> [3], this series' home for `struct iova_allocator` is likely to be short
> lived, since it resides in vfio_pci_device.c. I assume that the rework
> can move this functionality to a more appropriate location next to other
> IOMMU-focused code, once such a place exists.

Yup, I'll rebase my iommu rework on top of this once it goes in, and
move the iova allocator to a new home.

And thanks for getting this out so quickly. We've had an unstaffed
internal task to get rid of iova=3Dvaddr open for a few months now, so
I'm very happy to see it get fixed.

