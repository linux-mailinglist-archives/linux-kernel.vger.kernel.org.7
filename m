Return-Path: <linux-kernel+bounces-763327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4004B21352
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E75162644C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80702C21F8;
	Mon, 11 Aug 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qey/DLJi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD05817E4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933788; cv=none; b=Dm3AbZ/apTQZR95IoPDeP3AB+IsecuM/B9ht71gY2Qm4HKmRFh6EQdTkSS0WjodBIR51mujr5iFGuh/tRLRCAryl9lfd1T9b4DDmY1u8xwqP6Gv2y90PtmXZlQ/3OE3WJvDmG/jsZXNDcDlH8NvlHN3hKA+nNzd6KxHYVWNoEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933788; c=relaxed/simple;
	bh=CYZuKgDSEl916diOn1xANPiNZHt0r0cmf0wW8EWrhLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZGqaZN9b68/7kLgeC31r886FaUNtmwdPoIvS0UhPMx6J0qpzqoeMCRG5v3maFV3WrZq6yOexsyzfhpQZxrd0f2HDQHywRHymlj2J2hkp0icKeRibXsaSyNqg711Ffk9YNfneJfRYV2YBsjlahwlMSrazMFcWXdw5BQ+tM/7mdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qey/DLJi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-242d3be5bdfso10215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933786; x=1755538586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ2xAZhj5/NR+06E5T8i9HLTZaGMhAakuP54El4iUII=;
        b=qey/DLJiz4D3vBxHVYenSUT2sLPkIfN7OaQKRFKbYsYJLJDbS5a7JRlQ3qA89zrRrD
         dRcqHxqOS2bHVZJO+RrCWxmIE+zd5+wSvO3XR1UZjwZSaRtTIhA7ve1w5WbWztCRPr4/
         v08jeY2GieNZlmrLHLrmifLvATwnAFo1rcR2xnrWVXTa7IMaR1y3bqCphL7qTpZgTge/
         2S/tPOTcOXNQu+h0RHVE+7t4pOPhKJCuKOvb0ly4bOZmKqj4794PGvmK5idmWiFg5Hhf
         JERLep82NjGMnn4aflPWqsNWy/y2RWLTdzvZq3OZmC4V3hH66RREernp+AlICzMvsYuh
         wvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933786; x=1755538586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ2xAZhj5/NR+06E5T8i9HLTZaGMhAakuP54El4iUII=;
        b=lntERgOLDvElG59eQpVuPLSSIIcmwR3yRjx2B/K1O3uMmQcoO2tVrieTaP8X07nzu5
         9PWdrTS6FvD1ssa4rqNTFHToNgBUAwbRjyJ1syOMdtIegl3itE89I6YUi2ZJdRDUxnow
         yFr0YjuNqyC9lcDwQmPuKAOhajshVnDWjxh6R+TFvRifFyF02iRpxkfZyjYDLsfFknS8
         vaAN+qIZdl6VpRrqc0osCueWZiVpMQfmVdEjUOQzf99EQfeSSWcO3nNMoP/yxorSZpDw
         y+CK+WlXpNab6O3Rg7AdSgiDd3tJJnduUj0HT7tlhfRDPeMkLkgDppAlFakk8KYxV7Td
         Ndfg==
X-Forwarded-Encrypted: i=1; AJvYcCUsOHy/riQk1cvoC5XC2JZOPM0mLJdrLyj8o9FxbBsfKRuE8ZeYtJ9Tr1tP1l4OsbRKOgTj3si8gual3RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxY3SL74Ec2lZaMogEnUROpHfZGpsQP5Dio2raKtjQ+do+7ijE
	2o/CSqJP37CiUTtQNNk1C+TYWARlI7+ugNztGv17yPeA9jRnn/+/fJXSK5rhyyzhWg==
X-Gm-Gg: ASbGncv0r9JuGT5Nq0qCgFoytD9CQpmzSgaRdIU6z/AvWN0B1x4ZrK2Z3n4KF6ZNlZJ
	2G9F0te7y7UUeV1AD+TdnNXY4LT0rOkr0cGFhq7hL+8eojVho1VCiyNsZCjC0LGH7xfILt8+bWA
	5HFmAhu0OzUx0ja9B3wQgBIFDGa+65qZzn2aHm0UM7sMtDv1/nr/mjN7Luj/2QBjUmAI89V6Z2N
	1L/hzYsNW1DZXloO7GLyWmTP7UzuWcEuMft+boAclR+FK/RNFX9OECjtDzgWuroeM3bLg7e39/3
	RjfVL526HRWS5xpUBwBOGQWiBS+F3Nt4D3mD6KCXCoFX9+RjI3uGIcDE0sqUDQ9jKixwq1WIISE
	JjqJFTttn+9qx2p4l2HRrQruhS2b6SbR33bKPuFFNZwCTAkXJ/dtvDju9J39v9Vk=
X-Google-Smtp-Source: AGHT+IHkl8lWtTwb+S2MvenYDbm+ELQHZfHdsnWRZd2yLWDcbbI7CeIsyKxeYZddKEHpFC43iSXvrg==
X-Received: by 2002:a17:902:ecd0:b0:223:2630:6b86 with SMTP id d9443c01a7336-242d49878d2mr6631425ad.7.1754933785814;
        Mon, 11 Aug 2025 10:36:25 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216126c96esm15186320a91.22.2025.08.11.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:36:25 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:36:20 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Hutchings <benh@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Add missing module description
Message-ID: <aJoqFKYpWkDCiIJp@google.com>
References: <20250809073018.1720889-1-carnil@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809073018.1720889-1-carnil@debian.org>

On Sat, Aug 09, 2025 at 09:30:18AM +0200, Salvatore Bonaccorso wrote:
> During build modpost issues a warning:
> 
>     # MODPOST Module.symvers
>        ./scripts/mod/modpost -M -m -b        -o Module.symvers -n -T modules.order vmlinux.o
>     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/android/binder_linux.o
> 
> Fix this by adding the missing module description.

I'm not against having a description but binder is not tristate. Judging
from the 'binder_linux.o' this seems to be some OOT version? Otherwise,
I'm not sure you would be able to reproduce the warn.

> 
> Reported-by: Ben Hutchings <benh@debian.org>
> Link: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1587
> Suggested-by: Ben Hutchings <benh@debian.org>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  drivers/android/binder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 312b462e349d..0c2e38ff3a3b 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -7090,3 +7090,4 @@ device_initcall(binder_init);
>  #include "binder_trace.h"
>  
>  MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Android Binder IPC Driver");
> -- 
> 2.50.1
> 

