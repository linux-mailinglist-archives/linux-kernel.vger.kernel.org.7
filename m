Return-Path: <linux-kernel+bounces-833909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D13EBA3532
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03AF17C3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E32F260C;
	Fri, 26 Sep 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7al+Rky"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BA2F25FE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881808; cv=none; b=EN02sE3EKL0zepEf1KPq7nQQmzqtq1uWmGbPa65pupYYA1uznb3Hn+m7ggLMslTKP6jYxPXtBYkwUUicnrz3xNNyTqXPsK2YsUiXYWgccJFjRthBZrfbt0loS2V++sW6ixIk3VXe09D8VaOvwu0nae0GRUzdGK6mUVzUjrHUcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881808; c=relaxed/simple;
	bh=NCt9E8+HGQzZgDhnjKMxG4vLWciVStKsiL0uUNs+2i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdUk81L9Om3zUTRM6NxM1O9TH3156X8aEhNU6HG+XTEvCTmG8O6SDwNsYd1tLoWcP97Cxgzf5L6XKHWrrLUMaRo67oMG9jPPyJX+fEPZSH4U6/ZB7Gt8AjNeE2apB2Siy9K9ReMZpPcqkTmPfOq/bCbY3bAgU4jIM+wt072QJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7al+Rky; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b523fb676efso2006619a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758881806; x=1759486606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCkO+D9kDGCy/+XSUswKupu9H0vZnu+FUXkBu6uOVwg=;
        b=O7al+RkyJEmT4j+x4rp+oYB3YHMaZ+Si3pZpOUA1vKA7VVleOjeMNwDus9qIDAoAiX
         tubjFYMhnoGHptAk8eIvnMNL7wYZIGiuNgA7/MZD2YtQWU4DlGUAddBcFV1EbsTYfhQC
         3/D4P6xEWZID8IkB+U/F4ZhYu9wPocjOfkVmCIf9drs7g3WtH9kJm8PacqAxcfNus1u9
         bKHEe4b3b9rrJWKEMfkq3UqaflqLwK1ci1GYqQBzZZSHjMnCANn/3MQ3lisrOeR8fvyJ
         bb86l4HR4X4cfIYU19MYbdFn4mdG5ydA7FmnTkeEmtjCSLw83KwUQiAROzYgd7kBhApE
         60qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758881806; x=1759486606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCkO+D9kDGCy/+XSUswKupu9H0vZnu+FUXkBu6uOVwg=;
        b=TcOXa/ubRoUptG7Ippj5noUXejt26vIzFL1O59oenuF3rp42/kkXncBjoCN7DHP5Cb
         w+cCP2vJDBH4A1OF6r/gz6u7uGF6/ZkMUUSmSBEGeD19qMcGFmY9dKiO6aNE8zJPEaZ+
         z1YMUuXuPVb0zhzjEK0GsOV2oVCBiGGEYbJeAFtUj41TqJZa8vc4fXyqThGKi/kwtpzq
         JMiEoBN+bSEedf62SGE1Pn6+AVEUf31V63cXmIz+JbsQk4QGI5jNV6cCIes9uUVSSpn2
         pZgO+D51ij/ZUEhlg7QZAFgqLz+srZjnQReENpvc7Wl1HLSf7pxeDteJSllo3ubNK7Vc
         ZBqg==
X-Forwarded-Encrypted: i=1; AJvYcCWKPtGmFExcV5p4oEVpwiE0WL6RZZszB5gfQFiErZ56B50w0Q6F9PXhEcHPf60iFzdvTwgPVJ52kMAYKh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZA7lZk9i45OtZJFk5ARxiG2/txSX15G+pgdI/us6W20mPK2p7
	oMJcq3S9tiiQRWBoCckLs2rxjWP3cF5n6DZKnCMTrmgZrbVz0cUHglzyFhlM72W6kYBGUHUXz6u
	7mSQxriI7Ph+QDqHMeWurUA16eebVnjTkcPIt7i6VPvYm6A2VufJK
X-Gm-Gg: ASbGncuO7U58wqxiyZ12CxWb6iDK3/sIow/jbhtpeKnrC4a0wTTPrT3yK/3F6xVNplR
	hM1We5iITKmLmXTjsLV+kophsERlrss01avj3T/N2x1u1FqFb99mXbRWL5z8WImf5HoKlYJtVxd
	C+hi3jZlAx3zcLJtedP4wSEB3f17GGANdwEBT5cp2ugo6h+qg3K8hAoPnhznBiqtsz9L1UGjyeR
	V3dD2nA
X-Google-Smtp-Source: AGHT+IGzJlxVn5fvoyaE5bTUyWB/9v7sczw+G/GMyXP2+K7YbYeP/z9Wa8AjIVmPF5mdgTCRh5nZo7e/gi20TgvnbRo=
X-Received: by 2002:a17:90b:3b43:b0:32e:329d:3064 with SMTP id
 98e67ed59e1d1-3342a22be07mr6857155a91.9.1758881805764; Fri, 26 Sep 2025
 03:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925150342.1845615-1-sean.anderson@linux.dev> <20250925150342.1845615-2-sean.anderson@linux.dev>
In-Reply-To: <20250925150342.1845615-2-sean.anderson@linux.dev>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 26 Sep 2025 11:16:34 +0100
X-Gm-Features: AS18NWDTsCHFtCAPW1bDwfDXkfQeZu6rm2BiGOisJ47um5m78Fo0JSROz43i8Ck
Message-ID: <CAJ9a7ViDJKRCMn6wqHC-F+ohU_gRa3BzgaFoGzcd0TeDmNLKVg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] coresight: Fix fwnode leak in coresight_register
 error path
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 16:04, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> If registering the CPU map fails, we need to put the fwnode. free_percpu
> works when called with a NULL pointer, so just use
> coresight_device_release.
>
> Fixes: 5ad628a76176 ("coresight: Use per-sink trace ID maps for Perf sessions")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - New
>
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fa758cc21827..022c8384b98d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1352,7 +1352,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>                 raw_spin_lock_init(&csdev->perf_sink_id_map.lock);
>                 csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
>                 if (!csdev->perf_sink_id_map.cpu_map) {
> -                       kfree(csdev);
> +                       coresight_device_release(&csdev->dev);
>                         ret = -ENOMEM;
>                         goto err_out;
>                 }
> --
> 2.35.1.1320.gc452695387.dirty
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

