Return-Path: <linux-kernel+bounces-768790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48264B26580
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37244A21A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8C2EA160;
	Thu, 14 Aug 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKRZYtqC"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E125C706
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175108; cv=none; b=FM7ZlxiGtKhsdw8SUJGwg+Xr9QqGAzQQlPllNhmMR5LzuhNs0ALTqH/RivsMT7nJHF4D1C6q7/ZbRB8ITcEjVd2JvVizSYrzp8xJ+XOia75SCwAAR87TOkUUD0oex3lUo61wVf5xwzExrmJOgs66ls8gx46vcYSABEZLWoB4ZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175108; c=relaxed/simple;
	bh=p1B9+ooErqXDUtfYBKduvEAXjnYV8On2TECtaqCtlXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi08j/DuuFC9iJrAL58COgYKkqBKv4y8jyh8pLssm5B6uTFQNPpjE64HhuEuIFL9JAixgom/9eMss2bSZ6bBDz09EW9+wD6TbDFZjeJhu4IqXSgR4I9R5ZDD6fTqXfM56JFTr+Ewl2BcGa89h3LwFIebHqNyUB9MpFE/t1KhWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKRZYtqC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266b2368so652958a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755175106; x=1755779906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/SKouLfB4Dt96a+piQ7gJ9WekR4y2KBR6TTQHeQMIQ=;
        b=DKRZYtqCJo/Z3KCQEUhN6M1pHNEOgy3U+KUucsbx9BRkQ+DBUCt8VsmEDU5y8qYtVT
         YaJXDN7Nn12lKN5VUrsSSBChWrc4O4jpMrov0S8dNd4cimTWp+tbliJaGi+pLZpN4fHO
         QJgst7Vdwq8z+zd7a17o5syIyhLYax5C9edxT9S/iBQ4zedN0xk+c8I1v6/m5m0tFPsq
         ryhuK9VEhQMHdKgeY4pkALCC8Fkk1oHnqSrvshfKK2ZvoyYkM+K25o2cyIt2orD3vbr6
         Go+ezIqxcCYtRqM+KmQutzoUMlfpR1uhOUz/ARpxnQAMJBZKQFV6nnHtWeZn3E760Smf
         cR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175106; x=1755779906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/SKouLfB4Dt96a+piQ7gJ9WekR4y2KBR6TTQHeQMIQ=;
        b=HqEWhpAX/kATX4ylXBofZJgc6WzouZ3+NA/nIKJPkRn/14LJw8/6c8csidmwwK2kVt
         NiKe1DTO8LVvxFkrOt73EmSaiYCJ4DAWu/P47CbXLeY6sIRC40J+KH68ImPVwpo1kpP1
         yxB90L6y+vyzMSde1f+jMTeXXNZY8ZEx7x4Yw+kWhucZ+SQI9seRdo/hJ71IAVyt1v6e
         iVTouWPuLyPj4M8uZ7UmQXJLZ+9A6j0hy6KeUY8D7J9ZdtxYwrQEu5+kVmGMaJm000VD
         KmPL4jOXm7v8LBalyE94XxtxRHebhwOOcvjU/JBrzIuqZCK+LLswFPQr/gOJ3DOzrx0a
         4Lzg==
X-Forwarded-Encrypted: i=1; AJvYcCUlbFVM8uvPXOTvKl3Kd07yVJ8B6pXO6h3S3QsAd1wTUPTdrZ454V84MkHZZDcZR9W+7LJulixlweUojUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTL0bV3jpZV9jb4mrmT/VP7xMSkpsuTBCcYRb6lPtJrhfjFF/V
	5bGSyIKOUOK9TpUNutzQa/HLcUE5PmB3um2malthFDoijUORAdIoGwT0PEg8h4vGkLGcejxcEKj
	tF0FykxKJVDvL4Osvzwd2yHZUox76/vXVI4u3BKRypg==
X-Gm-Gg: ASbGncsK2gIVc+lJX3K5thM8P50SQhc/3c479fq0i4fQtbphmbW5G3bnzV2QLkYqAnw
	3eAVsYD0yhvgE1jwGfXPT/GG5nTGGnsAzzEbYNyqGmghbFnnMM9jyIWoLcChtEYsmHAYL6X7Nps
	+r2d7HVikE4Dpz5Dmg50vDXmHtINCNyN3mUmzp97MukrM2LlNA4MaclMCG7gj/dG5Z4t2XQVATK
	9jOjoAs
X-Google-Smtp-Source: AGHT+IGSclopDnHf9B3zonnvXINSROJBoUEpQ4myknxB/jv0JOS4+2qsCtwFneFqnIPDyDUqajH3gvHZEPoUUbizmJs=
X-Received: by 2002:a17:90b:3e8e:b0:31e:c95a:cef8 with SMTP id
 98e67ed59e1d1-3232b7b7707mr2940353a91.32.1755175105752; Thu, 14 Aug 2025
 05:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org> <20250811-james-cs-syncfreq-v1-3-b001cd6e3404@linaro.org>
In-Reply-To: <20250811-james-cs-syncfreq-v1-3-b001cd6e3404@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 14 Aug 2025 13:38:14 +0100
X-Gm-Features: Ac12FXzyxxKA_BOyrBNq7M0owGv4_wTgorvEm4dWj6LYiHxzxFQ-EPbV7AZ31P0
Message-ID: <CAJ9a7VhXAhDHkpyA6gHWPfr+HAEFLEPa01vx0n=b+82TrEMUTQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] coresight: Repack struct etmv4_drvdata
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Aug 2025 at 10:32, James Clark <james.clark@linaro.org> wrote:
>
> Fix holes and convert the long list of bools to single bits to save
> some space because there's one of these for each ETM.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 39 ++++++++++++++-------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index a355a1e9606d..1c67b263b01b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1020,29 +1020,30 @@ struct etmv4_drvdata {
>         u8                              ns_ex_level;
>         u8                              q_support;
>         u8                              os_lock_model;
> -       bool                            sticky_enable;
> -       bool                            boot_enable;
> -       bool                            os_unlock;
> -       bool                            instrp0;
> -       bool                            q_filt;
> -       bool                            trcbb;
> -       bool                            trccond;
> -       bool                            retstack;
> -       bool                            trccci;
> -       bool                            trc_error;
> -       bool                            syncpr;
> -       bool                            stallctl;
> -       bool                            sysstall;
> -       bool                            nooverflow;
> -       bool                            atbtrig;
> -       bool                            lpoverride;
> +       bool                            sticky_enable : 1;
> +       bool                            boot_enable : 1;
> +       bool                            os_unlock : 1;
> +       bool                            instrp0 : 1;
> +       bool                            q_filt : 1;
> +       bool                            trcbb : 1;
> +       bool                            trccond : 1;
> +       bool                            retstack : 1;
> +       bool                            trccci : 1;
> +       bool                            trc_error : 1;
> +       bool                            syncpr : 1;
> +       bool                            stallctl : 1;
> +       bool                            sysstall : 1;
> +       bool                            nooverflow : 1;
> +       bool                            atbtrig : 1;
> +       bool                            lpoverride : 1;
> +       bool                            state_needs_restore : 1;
> +       bool                            skip_power_up : 1;
> +       bool                            paused : 1;
>         u64                             trfcr;
>         struct etmv4_config             config;
>         u64                             save_trfcr;
>         struct etmv4_save_state         *save_state;
> -       bool                            state_needs_restore;
> -       bool                            skip_power_up;
> -       bool                            paused;
> +
>         DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>  };
>
>
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

