Return-Path: <linux-kernel+bounces-774243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB351B2B047
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB87B4008
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B633314B6;
	Mon, 18 Aug 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQ8XGPe2"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A43314B1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541626; cv=none; b=ugRa1ukOqoKHRG8QIo0HXzoi+T9brhmgWcQBtfneampnQBmxoFvu2OStUIEHX9cS4HIM0a8nzmXzKxuc7fRo+pxqSAT4mBVFuFX/GS4QobJ3C6WDI6ioWp1J0uv83NHwHI9zhS5iUVVkllFWZeApW0M4MPPfIDUsPwhSlC4kQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541626; c=relaxed/simple;
	bh=Rwi7Cu8wK8PRPeBmHirEY0WEDhwHCHjnE925WnBAEsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMJszhMnUejpB4Cqo8XBMms0z3WVKtWe11OAMISR9Z8cF1dhaUPO/N3F4+nmyvXAJWKBE+jom+FuAKRutuy3lCf452EcLJWwRE18jK2sxEbl2CdKtVVs/6DsLIsZ5FDo9S+xq77NLK4o113NTH3m1aXKiAmBPywsDCcmt5lo5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQ8XGPe2; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88432ccc0cfso139794439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541624; x=1756146424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xthx9ompS/Nj5CKJ3I4BXZ4xhbM39aiwRjdnUlZCUzI=;
        b=yQ8XGPe2gFoEnEemhwYLrmVWX6+5chnNIbLWOVh66V2X547loRxI0d8t40ZuCFBnGA
         vGRZ09hqJYv7bH2RX7GOg/K9eC6uw8qntF0emVL1Pj5G1hF20lub9/7lHBQIJLc5pDDt
         YeZgoPLN7Sb2plK5u9Mj+9kxwhDnxLGDOqeD5BpUh9dDlgOnCRheWDnC3eACtz4Bxlkd
         sPVJ0xkiWFT+4AnaP7HgusymjDftPJAjKs4fTDBn7SPOuoJ+LvoZ3wT8Cy2AlclbBpg2
         r2yu732fCi5wYnOOF1wgPVt+B4RHZSb4wmFX9FaybLbKL6WXTtltnYT/ZGj6FkasUJsC
         sOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541624; x=1756146424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xthx9ompS/Nj5CKJ3I4BXZ4xhbM39aiwRjdnUlZCUzI=;
        b=Ywp10Z9fW8HwyzaL2SNqRvy0xUNN4GlLPEcD+Hxv6/dv3ZigLmF5lNzn4OsQ6BtcHN
         fnu5F7kPJx5V83/E0KagEpinPEaYreBwYsrC6A7AL5XJXiKZ43BW3ZuVd0jLm1qMXPkC
         /iH2bWJLZA/i7lfYCY/Yvo8D/Cy0Bnuncyy7Ovcnk3BQeDwpMLU/OG69XsGaiRze9Ppo
         6butNZh+P+bybAuMugX/MQg3N8acbYdO0Yg54MPbuwJKXsozFr3GRPZYVmAlciHjaGjz
         Up8kUnNH8+/fH80/QWzxH52K7bVI8QbWtH+FdTBQjnYSlV2blNhuAG/BJzpNabgfejFQ
         LYGw==
X-Forwarded-Encrypted: i=1; AJvYcCXaejiCeC+5kuPQC/DayFNsKqmVuN+p0krkyifyv5KNfD7JX5xFdfXxHEmMAsIYToUXWJpbSG/ispZ0oME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJ7p2P3jaUP8C9VYDIhyAS1o8PvtORad0NHUTiqSA23EzT4t3
	CFEXi9m94Sgnkd/B8DmQqY8E6ds5FwlKhAGnNiDOI+WaMoZ8vcvwr/eztN05NrUfEA==
X-Gm-Gg: ASbGncsk2qpGRlrixNKPCs3BRopWGN6qEgWLwE2ly06MEpHFMUT1MpSIOVVCeCj4AXr
	5HAC0WjeBsDEd+WDhP1d+tkisxJchUXhc2aJbc0EYfWiox8KDBebe4e3oCuOW6U7LmOsljFJdip
	Ko6PWxTWxzN5gKjnczg8lV3jDcX+9rDpuAGDc1Y0wcZ9viaGvR3LDGCpBEkJrMA6TKoNfSaPx4J
	QVoAv7x/eJ2kFNxDhjKsDp1ox3eSIONc8VFUwaUIw1TKEv7lCW5ZpOBl9Id8f2fNuV4DJDhnOU3
	Rqwrv8pGEFlb5UxntJcVlnKUVG4gcEbp4EQnioqV+7u3b9jGJt4QLqiwV/WXu0MmhGvHTHQrGxb
	u05CvYoxPz9rv/wSHFuYkXyRl4rwtYBV/RT1Z+cgD1ck4/nyRChx6nu7vOJLnmiK5XkdVICI6FQ
	==
X-Google-Smtp-Source: AGHT+IF2dotuoGSCZvg+ZyHAacP4HbK0Z2LLDMxgQqs043KhXAhyYpRU6mXhUnrZ2USLYc+dScshIw==
X-Received: by 2002:a05:6602:6d06:b0:861:d8ca:3587 with SMTP id ca18e2360f4ac-884471192d0mr2123993939f.4.1755541623533;
        Mon, 18 Aug 2025 11:27:03 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c2cc7sm323121039f.18.2025.08.18.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:27:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:26:57 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: test: Replace deprecated strcpy() with strscpy()
Message-ID: <hqvjfoaw5ooucqp3mwswrjxletq6vdzztwvlaxvxf5a6bivdzf@7fcytrsqhz4y>
References: <20250815213742.321911-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815213742.321911-3-thorsten.blum@linux.dev>

Hi,

On Fri, Aug 15, 2025 at 11:37:44PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/kcsan/kcsan_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 49ab81faaed9..ea1cb4c8a894 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -125,7 +125,7 @@ static void probe_console(void *ignore, const char *buf, size_t len)
>  				goto out;
>  
>  			/* No second line of interest. */
> -			strcpy(observed.lines[nlines++], "<none>");
> +			strscpy(observed.lines[nlines++], "<none>");

Looks good.

Here's my checklist:
1) strcpy() and strscpy() have differing return values, but we aren't using
it.
2) strscpy() can fail with -E2BIG if source is too big, but it isn't in
this case.
3) two-arg version of strscpy() is OK to use here as the source has a known
size at compile time.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  		}
>  	}
>  
> @@ -231,7 +231,7 @@ static bool __report_matches(const struct expect_report *r)
>  
>  			if (!r->access[1].fn) {
>  				/* Dummy string if no second access is available. */
> -				strcpy(cur, "<none>");
> +				strscpy(expect[2], "<none>");
>  				break;
>  			}
>  		}
> -- 
> 2.50.1
> 
>

Thanks
Justin

