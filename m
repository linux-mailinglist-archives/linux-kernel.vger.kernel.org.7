Return-Path: <linux-kernel+bounces-823999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B70B87E64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BCD1729DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22033279917;
	Fri, 19 Sep 2025 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esfqcG3H"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161561F462C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258763; cv=none; b=ack8MoeeXNdhUhiYAQ7O5lkuxcwAhJ1L2nHRn1tJwdnoL+fUHhsDj5o+xswDj++1fCgE1Qdqohe51roaqlXIqnetNKY+HEbtuXHMKHe8XFIs3J4Xpi3azoqgcuhr+srr/4gLt7B+Wwt3sLcjoful8mac5AAgzB7B4PnpFxdkLz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258763; c=relaxed/simple;
	bh=xy6Nn7ttzn5yTVwsCIsKB/jqw2UMP3C/WLclkEDlZtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo0k+0vToZW/fq5nKNAwDFUjULMF5sg3D5qcOExomO98xpPfogGHERwIYHtU8XxS2GSkee63xVmnoqT3H2T7+pK9qfIQEa8fVH43xs8S+HSkYasZkQRw/d4zlzzufCXSWlYOI+wRt6UZTsbFwsu9f9ZH3CIXMkTxhTbTz32ci6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esfqcG3H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7761b392d50so2284884b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758258761; x=1758863561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eL6RxCRsAs0clRDPdmdT9WoKuQoosuO1QexbLotddZg=;
        b=esfqcG3Hff86cFTJ0Aw6FPqYH0OyHQhpAU7z2PkAeqEibdKfXdxo4dXy0XLVuHq1H2
         M071+9XNex47atdDxZCKPzuV2cnS2igkjiz8Ec3Wok57pplke5G35ADxR2nIpG9Kgxji
         Wpjb4S7zXBEhMKIXKWZ85g0x0DRSG7yY+dPeHv6OLoYfMpzID+gdnC24PtJvflVCo6/U
         M+dITx3kGkG/8YBlA5ANAW0StrtvRGmExePHCpf1cWgWmITifR/+sYQrbilOZmQNjeGd
         C0OA/yz9QVV2rSrLhRzSmVyoOOtHQEcsoQeA12yazsCIT/S9yu4iKnuB63QuS4eQFPz3
         OMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758258761; x=1758863561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eL6RxCRsAs0clRDPdmdT9WoKuQoosuO1QexbLotddZg=;
        b=Q7FPZeJu2vT+4yKVc52K1bS9pB3Zwh/af7RoOQBvrAg+ReTP9hSLZUiD/V3oOaYECi
         UJ4a+zO1Ymbjflh0crA2EHm5/SqMIgkQC+ZKMrh+aZrooyOyy8thsy5z63VnLB4xRU4j
         jUcYUquGEvMd8xqAiHFcHRw2GvagA/9nv0+KXiHvvtQV1rje+F/rMQPjgccXn4Zbyoxj
         Xmxvrl/EB4eIe6nCDU6so/vi9OCubYG5wh4Yey2wtp42ULxD85uqT9FHz0KA3BtI8Eoj
         0SC9Ltscp0vCtyI9e3OxErjd+me/6omHs7Odgmzn4EtrFcnAlqoYYEiIbKmlGwjunfcU
         Klhw==
X-Forwarded-Encrypted: i=1; AJvYcCVjLc/WdeZGNbovmsdTbXwEV+1PRcno1nSQX4y9guRfQqX+mtDcov4t6/sHbN5/vGAGm3wHHs0xQ24mNhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdpLnnfn0fDRzJ5kqfoiv6PPK6Yu4mv4HSobgsdf8SxvYNhYG
	JnB16VSGW/A6uV1jUtUx65mXlzt6gLnZNdS7CPrM4wBO44BxyUhrsoDFtPUKCA==
X-Gm-Gg: ASbGncucEZWQRJoHScsg9E7QJ4lTpJFMDWHSeb69onFcYygqAs94Rcew7w5Pw7rtPxR
	sRrYLhgY3JZKkrkdgg69bByT6khZ6fvT0sr3oj0DAayA1WsI99oTnBNcHrX+YjMcsGnwkDv2zBx
	UKNIH+zWXcHi3uK7WV27FfGwTVyfBYqLM1J5GQ4rGjNCUtDOk4I5xN0OEJ60ldZxDlJLA7qbclT
	QGZLS+BNzdHzUZ/kyfOXrZLtENwwzwjjAqOj1q7HrxSeHbGezBlDDwo3EEnFN8D2a05Xgw/NmNh
	8b5evb1GBhaMJ6mTuyFUtdSc+tKiQI9rYrmMFP94bl1fOQHzJSEj+RVlVMf02sTq7Xhnm7JDgS3
	y5zG5IHLfaIC9YrTfexjUQfw=
X-Google-Smtp-Source: AGHT+IEo/vf8ReoxNqGNHMuy27BBoFacP2Y+vR38N8AQmo9arUvUxjiFYOQoLJSYJK/Xk2XRvUObQg==
X-Received: by 2002:a05:6a20:3ca2:b0:251:fbff:a8d with SMTP id adf61e73a8af0-2927182ba8cmr2982310637.49.1758258761206;
        Thu, 18 Sep 2025 22:12:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8e3e:e1c9:1151:50c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed276d2f8sm7071127a91.24.2025.09.18.22.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 22:12:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 22:12:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Anton Khirnov <anton@khirnov.net>
Cc: Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: allocate a keycode for Fn+space
Message-ID: <u3qzdpgoe2appwnmv2rkcmyg6htrmltna3geymp7llootdwbts@ycmhljii34bz>
References: <20250714150756.21197-1-anton@khirnov.net>
 <20250714150756.21197-2-anton@khirnov.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714150756.21197-2-anton@khirnov.net>

Hi Anton,

On Mon, Jul 14, 2025 at 05:07:57PM +0200, Anton Khirnov wrote:
> The Asus ExpertBook B9 laptop sends a WMI event when Fn+space is
> pressed. Since I could not find any information on what this combination
> is intended to do on this or any other Asus laptop, allocate a
> KEY_FN_SPACE keycode for it.
> 
> Signed-off-by: Anton Khirnov <anton@khirnov.net>
> ---
>  include/uapi/linux/input-event-codes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 3b2524e4b667..a49b0782fd8a 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -548,6 +548,7 @@
>  #define KEY_FN_S		0x1e3
>  #define KEY_FN_B		0x1e4
>  #define KEY_FN_RIGHT_SHIFT	0x1e5
> +#define KEY_FN_SPACE		0x1e6

I'd rather we did not add more codes with no defined meaning. I regret
that we have KEY_FN_* (with the exception of KEY_FN itself). Since
nobody knows what this key is supposed to do maybe map it to
KEY_RESERVED and whoever wants to use it can map it to a concrete key
code via udev?

Thanks.

-- 
Dmitry

