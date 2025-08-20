Return-Path: <linux-kernel+bounces-777024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D312B2D431
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9F058840D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F92C11E2;
	Wed, 20 Aug 2025 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ir/XRj+l"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A114280325
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672294; cv=none; b=I3vjdSDPwbMV9Z5Rg1YZali3tbna9d2+kShk8gMwyWlHo2l7Zkxi/BpNguyM0rzL4vhQTDc+boYXFbgzLLdfBF8csK7rJml3bkAIUdXOKaRwguH+FWZ9hpnzxlCCUbgJUUzpHfCr4HZ2+gjRylG67CSFT6Cnzb0y81QJnCT1mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672294; c=relaxed/simple;
	bh=XxAiAdPjAqjFYBsF4crlxMLuqhWcBn41XRHdA5KQdTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9jSDsRdi2qYRZvZwk25TU+nkxOOM2OlcdHJzC+Rr+Iu9T/DHn/bo/oY6/ns9XzCAwyZApwiBPbB4Mcp43BcjPEd2qBaD5csnrluoV8QNzQG15+x27ZEWy0olUtfd2h5V5YIr2ftMZA6URrO8fyfp0O6lQfohPkLKPfkeLIVAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ir/XRj+l; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e94f573e4f5so474261276.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755672291; x=1756277091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MFZtmVxFhnecSgkfjhLHB+6EKVJkLrQoIKfKXYcuIYU=;
        b=ir/XRj+lrRXUx6mTXOqiTkJ2oJHu/bMcqRe4t/JcEXbL9VqaDanPUsJ9F58L92L6zb
         hfMq7NBuOISfUDu2ImnFNdEV44fKzyFHOutscTEqHgsFJeTmqXgwOIgFxKfUc3h7BSH5
         t9Ol+kEyy6KXna7XKxFCxigjo4DIQuN0gRGxkLqSsBQmeo5qlJSGude188L2RX8TQhab
         hhbmfDzsCnQawQ5no9VuqsUpgaQtCqIJ8vzE2He6+e9zHdtf/bcH0AoZgDwgiZUckAhL
         MvkUaEOArTJ0z6cv+HgMANgGR2Yq4IdX3QIsEgrEpKOoBim49pFKgb6tqOSHxT85gzC3
         2R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672291; x=1756277091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFZtmVxFhnecSgkfjhLHB+6EKVJkLrQoIKfKXYcuIYU=;
        b=Y9S4T2533c6/6EwPO6lfA7KpLbEmfkiphP+e26w77rwYNC1SXxqSe0zOVF0kuZt1wY
         E9QNxGCt6VP/H9ywxKEHRD/ssQN1izeusoV25HQ/p87xaGMXmRm3owE6RM0f5E+lHKyd
         5DYptOl+ycdfthtMQzdOHmuFhrpsXyrT7JRSrkwn496ZKSsue5+67EHlBG9bmrpM6NUa
         rnUiYxq0Y4hUXzFAwe9Yk08w1+F5W482OF/gs+xTbUEapDeEVFWGFepfN3mzo0Xmw8uc
         NtUbmjaRR9O53CuUbzoeV0l1+tZYW1wUa6O17FNcVIaQ4f9batPgy2r7HYgyjNSpowyk
         MD1w==
X-Forwarded-Encrypted: i=1; AJvYcCVk1VHdgJFuZRpC9BpXpBd14B3PdRhb9WDWuitFcWbQhwLxH8tufTzKg8UqAo2d1FH1zaP4SY8Yo4zXgkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmctQpMZkucix7GfzhwRefQbB4hffBMzMCT3CZDzT5ZW45uFz
	9G1cSeH4K5HIJrQmV6t1EMCjOYwiooYLVgEiZ60BpdCBnjKwgLASyMk0Ugh7uhDU98KhyVneKfJ
	mA6F+SR8jloE3939WWnyoIZAhxNvR3gfT0J/OtqWc+Q==
X-Gm-Gg: ASbGncvUCaQhC+y5nB+sHRYSQ/jY4IFheC/oCw5w9hAQ2ycSrsYvWHIDE+UxAzpgkv4
	4iRjyRdHOmqxtmbs2MXIGYpaCbbr1yqURTiAGHQ2gPDsJfMArbLCqCiX/0xqgy/RKlAmUbwacxO
	ZwAMd+DhVC8M+sYbFdpP6QYy5qcXAhTi+QEnqkkXYuYhkrhYikRsQw0POkfq+jdu24Rq2Gj0LDa
	j5YU174+xpu/UUoKseeeZfgYY1IkgnIN2ugPIFL
X-Google-Smtp-Source: AGHT+IF9n3TPs24mXP/KjwmQUhHu+FJWEtosq1oYeVveVi3oASW8NolDlEZsKCpZBM4rHvLc1LSctNmuAv5MtuhmB68=
X-Received: by 2002:a05:6902:2011:b0:e94:e1e3:85fb with SMTP id
 3f1490d57ef6-e94f66442c8mr2236785276.52.1755672291534; Tue, 19 Aug 2025
 23:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <8b4aeccbc005087ead1c261745877ccdb7dbb9d5.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <8b4aeccbc005087ead1c261745877ccdb7dbb9d5.1755285161.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 09:44:15 +0300
X-Gm-Features: Ac12FXyD7fthuXlBjIwxGPCDwZnQfOaQn3pELvXYWoyyAX9kG_dNCA-jpkTCXA4
Message-ID: <CAC_iWjLzxfSXMAuQe87f4LE=yqQ60ddZ9WX94fagzbcepscLjw@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: stmm: Drop unneeded null pointer check
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jan

On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The API documenation of setup_mm_hdr does not mention that dptr can be
> NULL, this is a local function, and no caller passes NULL. So drop the
> unneeded check.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index bf992b42be70..ff41667b1005 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -191,8 +191,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t *nr_pages, size_t payload_size,
>
>         var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
>         var_hdr->function = func;
> -       if (dptr)
> -               *dptr = comm_buf;
> +       *dptr = comm_buf;

I think this is ok, eventually tee_mm_communicate() will check for a
NULL ptr and return EFI_INVALID_PARAMETER;

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>         *ret = EFI_SUCCESS;
>
>         return var_hdr->data;
> --
> 2.43.0
>

