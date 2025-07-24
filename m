Return-Path: <linux-kernel+bounces-743907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E0B1053A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FB05619DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49B2750F4;
	Thu, 24 Jul 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqgTXMFg"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293272750EF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348047; cv=none; b=upgT2w+bsHqD8i8eIQVCaidfCT4WAhy/pcZIrbmFym+YoAtOPS4gjtYYsfA2EMSQa/HdFUa/tCYnq0aeYcUBLmodPwRmBoag7Oe1O0KY9DqVEX1jkjFBKVrnGEvMmjy9NmXg3h8lrtb0DU13fQmWZ9cEJFiTeiczCZAVUJEN4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348047; c=relaxed/simple;
	bh=zgMFLUq0fEmtCJ+2Gy519EI1Y1jQDENdFaSS0II49MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4mAOJXS3zB/f+HZwEb7FMFDfs4uwyilKnrT8pIOhTq9qatwEUHSl4FDvAm989fy6oRWUMSUsCpLvVu3e/o4RUx25IkduVFrXhexPnLvFupqmb9m/eIdgrIohThlNZ5yQqkMUAEN9LyOs/U1iSEv0QAJY8ZyzSR+tz2fqnSF3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqgTXMFg; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52b2290e292so239676e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753348045; x=1753952845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9U1sLWBdhx1paPNTeFVGeHZUtaOkySwMikmcsZGJ3Y=;
        b=BqgTXMFgl4tKYuf5WXD2YNxGRBSXs0X9uOugc7m+DBZNMDM7XpjvuMsA6SgL7FBfVv
         REwvf292/zf65YIXUjLejvUiqCbR9WAspJB1C2+dj2G1C4YdPK5ug43xpC6pBsT7bpk+
         i6XAf2bAHhzujs4G0BamDOftAffYLcdMEuG2aj/cMw+54KgtnVYa6WQZhkuWSEJwZ6u7
         6Zl/L3gLRMf1tW0O+tUyggx1aYiq3TLUmG9GE6GqGTd9YWiywUAtta+M2U4EwHqkAs77
         gwCAUch4XhMvleQ2YaQRRc/gya6H7i6cjY9NrP0tlQBfRPo5Mxe/b3IuXs3x7pNRL9yp
         wJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348045; x=1753952845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9U1sLWBdhx1paPNTeFVGeHZUtaOkySwMikmcsZGJ3Y=;
        b=vbH7RqIaqQICrbXXa6Byo+tkMuKmVlWEWLpUgwG6+wR1zF5mYup52sDC3FGOXomA1P
         /0JpH7VTnIasKF7NKufHI+2u9zvtxb/vyITH17mQN4KbWrCQCXARf/RP50UgsO7JaPZQ
         PdegZ7ERdh5Qyf2oCwJ+blqHKPbQhE5Au6DzNvpX7LlVgzcVgFfuRA/zUz9W8r5K/ill
         5AG+Ha97DUChmineDOWfg4ehFuj/zpTefcq3Y/C4jDSPeDOCJl1a2v2wYuOBNXZ8OskM
         UYZ1egntbfEqGfh0GbBgu0vOjOhhilWYJWcRNbju7tnMikCIwRSdMXCiS1o35U10FQY/
         dt3g==
X-Forwarded-Encrypted: i=1; AJvYcCVD6H5KPxw6q1QPMpjL4bCBIeFftpTrsv0uQovtHl+oZRK6I+iHPKmeuZVJjGJhL59UCgeZRRelEg4rcjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNunfJLkiHJ9868xBJ+9esnO5dH9WRMJK9+C3A6aTaB4ELlMy
	gHHOgWsh/ImrXQBd4mS9x6/ekY6Kt4psDR/cZ1lvQn9f4V6CtvsmyCA3Y47Umvr6kjuTBDIezeZ
	8qaNje9wwJeLZ6A5vEjwIuJjC5ILFtNM=
X-Gm-Gg: ASbGncuiV2wOqKF+RUIv6K0FXlQHR8vQRyFdAtX4VQFdY1j4RVCOeJD9cg1rqcY2Qkz
	xmE7SFxpQDsfBnq1HKxzkBI9z5R44Oeq+Q/vvTS/WI19cOqDkj6BHP5+CowQKb0B64d74OGwLoY
	yGMcv59ZCfsJzWh9dZ8VEqUmvykft4cNM6t5TdOr037qVWiAPnJz35gDE0TG8Cwh8y/Kov7CvBS
	4+YCh6YfBWGDU0nPg==
X-Google-Smtp-Source: AGHT+IFKX+YT+nQfMVHoGIbnz5tCTBk3e35DhUZOmmPV1cNhlCz1oWMNfdF0SDe3luc5Mr/mRo1Wv8KWAB38eYODkMM=
X-Received: by 2002:a05:6102:3f02:b0:4dd:b037:d239 with SMTP id
 ada2fe7eead31-4fa1512033amr2994569137.14.1753348044722; Thu, 24 Jul 2025
 02:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com> <20250724085600.4101321-3-xiaqinxin@huawei.com>
In-Reply-To: <20250724085600.4101321-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Jul 2025 17:07:08 +0800
X-Gm-Features: Ac12FXwc8LEw1HxRHbIlcrvJWyoAZgmuRVg1-3tbipJDJAI81oWi9CrI61ErWbk
Message-ID: <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>, m.szyprowski@samsung.com
Cc: robin.murphy@arm.com, jonathan.cameron@huawei.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
>
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
>
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header fil=
e for map_benchmark definition")
> Cc: stable@vger.kernel.org
> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

I don=E2=80=99t think these two patches should be part of the same series. =
This
one is a bug fix and should be handled separately=E2=80=94ideally picked up=
 on
its own and backported to stable.

Also, the subject should not say "Add"=E2=80=94it should be "Restore". I as=
sume
Marek can handle it?

> ---
>  include/linux/map_benchmark.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 62674c83bde4..2ac2fe52f248 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -27,5 +27,6 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> +       __u8 expansion[76];     /* For future use */
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> --
> 2.33.0
>

Thanks
Barry

