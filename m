Return-Path: <linux-kernel+bounces-727877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A769B020F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942363AE53F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A32ED85F;
	Fri, 11 Jul 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGfd1c3B"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E372ED877
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249330; cv=none; b=ivu9I8zdm8qzyj0grC4ZWjEFiwF05h5xlaZ6lKJz7eOASOQnFhCTZrDu6SdkhCjmB9g7UvWhgR0QhMfhQ/Fzf/XwI8QoNxS4+pWCUCBk25Usldb4+y6VPQmLjvxc+Wx1s3ONYqvkhTabQRt+i2w0A+XtgOm0IZuYc559ZP3BWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249330; c=relaxed/simple;
	bh=ZJmv2kGsngYQ0j91GkPhYp/ZYB34ERAIc1y7RI+IQLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBuXZxQxGUmtC96B5xTFEWKmXt4qskl+nrp/Usyl1i3Lox0IecNMAvW67Bfrz1HD7Hu5zeHyDDRGdjKwDNWgB5lI1UPSokDsgwvRZ9vDZXdRoeKSmVd2hcwJvASFOURhJIT8So4JIChGqCw15qSeRLs5J85cwdPQstxUI3bG1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hGfd1c3B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso2707726a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752249328; x=1752854128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSUEvMdfd3OtQjcJtnT8MNHYb+tPfeWYuWYxCvun5Ec=;
        b=hGfd1c3Bmfs+N0Q6OIahJD/ljkhLyGSm5/VGuW7O7gWMM5pH9pt3Ez+dI1bRb4YxW+
         n5v+S44yuDC7Kf7cTgmJB3Lvl8mPPJgZyCe4P2GtZRgWMzHo6g9fOc1M/fhbo2v0mYKr
         2WdMC98Sy6TuWBe0mFGqj8HmVg/3LugMc+NZmOSggcb8kk1vaIE8G66+1e/c/izjec4f
         QtYd+vkEzmnTJTcJV0AwCqCWv4Z6BaHLpvNAf0Sb8DWxHCm6l1yD2QWDGd7HPje2Qffw
         CAB/y2uox31k7/3FAyMiOh9Sh5w0AORpHsQddsO1/q+pYLs6lEZhhaxrK7xeF9AIZB6s
         4L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249328; x=1752854128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSUEvMdfd3OtQjcJtnT8MNHYb+tPfeWYuWYxCvun5Ec=;
        b=QUqUAWyBGI+NJKP4EfFN2uPV+p3sQA3uNkYyUizgLvXpGBZ3o1buENKl3PeoIE7cwp
         43t39TXy2aZk/NBOJ4jHKqdl5viLbZLVFKyATyWHm81CBJueO+R7DC/1bGMBbI27kL45
         vay7DY026aPIfk9m5nOsvQTjImcq5RspS6W9gA6qdTKxlsbw0qvdhK/aVRs+X2RQ2WDh
         dLqtEF05ZzTD2HTw1bSls62AcnOHIquJZ3DRWmKX26B13rdOBVPLHsH1oV5AR9HNdbne
         8IsljWVmRbVwdno7AB396xBTq5KiV59CiO3dScQDwSiVu+TgcjgsBBneTwdjGwTziM7l
         Jh+w==
X-Forwarded-Encrypted: i=1; AJvYcCXOuL+ZpncRwWna0b+S87GBnawbLGY8++yenMyIID7SkNQwrPNrDJZ4qzv8QK6MJlIgE1vjrTdW/rxRiYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JsXMF6emB0OXWevmTwCyoq4dFf3yB9Le+sTvq3vhJ3K3NuxJ
	meq9HR97XewuEbAAh8wrSpH6mQmTnTGx/VqY8q5NGcI/PiM9VxBwhlUmHYeFDn+LEBnTiU48y/Q
	xS7xhAd1M/VIn0WJ2L044JN4pGWv2hK/vuC3/4fOg1g==
X-Gm-Gg: ASbGncuOJmAmONf+gTkICmA7JfN6bAoKYumzD/nfLdf035zKXFLNNrdQ6KLyKfuMOa/
	wRY+/kXgI2kStvnLiO8m98JYCJvlsQOZhdi6ZNyI9b02MafH1OeCeZygKZ9DQeA3fGzmHpaYMe+
	dxKnWTCHhjQ8gUWhLIUa4FlKphrDidET1VUZVYCqE84WAvP8/QJzfLA4u5VZRHx9OQt/YAWnk3x
	lk5gTDdueVIpb+EXpUU7QOxT7Ne/SPK43/FdVVt
X-Google-Smtp-Source: AGHT+IH2f1kHKtkhmbSDnFwU9FsRvu0+CvMkmIgA/3wZF988KeEXY1isz3v5NjcaxVFtljjYa3Rl3Y2Bu4pS6enpzQo=
X-Received: by 2002:a05:6a20:244a:b0:230:f847:6586 with SMTP id
 adf61e73a8af0-2311f4315fcmr6577705637.29.1752249327964; Fri, 11 Jul 2025
 08:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708151502.561-1-alireza.sanaee@huawei.com> <20250708151502.561-4-alireza.sanaee@huawei.com>
In-Reply-To: <20250708151502.561-4-alireza.sanaee@huawei.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 11 Jul 2025 16:55:15 +0100
X-Gm-Features: Ac12FXy6OFHr0HcNSbuwxmKfYiD99i1dpKvfe3JL9VMIP9NGMICwwAp3JOTw9ag
Message-ID: <CAJ9a7VhfW2RYXv6ZO28m65C75iyJUqTYos1tFXs8gAG5gx9yDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] coresight: cti: Use of_cpu_phandle_to_id for
 grabbing CPU id
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: krzk@kernel.org, robh@kernel.org, coresight@lists.linaro.org, 
	devicetree@vger.kernel.org, dianders@chromium.org, james.clark@linaro.org, 
	jonathan.cameron@huawei.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linuxarm@huawei.com, mark.rutland@arm.com, ruanjinjie@huawei.com, 
	saravanak@google.com, shameerali.kolothum.thodi@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 8 Jul 2025 at 16:16, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
>
> Use the newly created API to grab CPU id.
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  .../hwtracing/coresight/coresight-cti-platform.c   | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index d0ae10bf6128..e1dc559d54aa 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -41,20 +41,8 @@
>   */
>  static int of_cti_get_cpu_at_node(const struct device_node *node)
>  {
> -       int cpu;
> -       struct device_node *dn;
> +       int cpu = of_cpu_phandle_to_id(node, NULL, 0);
>
> -       if (node == NULL)
> -               return -1;
> -
> -       dn = of_parse_phandle(node, "cpu", 0);
> -       /* CTI affinity defaults to no cpu */
> -       if (!dn)
> -               return -1;
> -       cpu = of_cpu_node_to_id(dn);
> -       of_node_put(dn);
> -
> -       /* No Affinity  if no cpu nodes are found */

Leave the above comment in place.

>         return (cpu < 0) ? -1 : cpu;
>  }
>
> --
> 2.43.0
>

With that

Reviewed-by: Mike Leach <mike.leach@linro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

