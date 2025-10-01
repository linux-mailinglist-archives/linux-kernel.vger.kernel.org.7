Return-Path: <linux-kernel+bounces-839298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F335BB1477
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B71C2A0E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBEB2C0323;
	Wed,  1 Oct 2025 16:45:14 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949A2BDC0A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337113; cv=none; b=sNsH0uFxEaQ/BANFDJiv26Zrhtm6IybKZEbCZ5gzv6MULZDltrnp+lboiUJSeml4lvXYuXfI5aw6R3euYUq/xxqRvO5XfBASb1FUUFH7oJkBnkgKlbe6heS0e9qS97jCP0VDwgMPUB8w8xO79N0N8NLx1QLW93QAeAdGhZnWmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337113; c=relaxed/simple;
	bh=K7YWwtRoXyrnO3YXAJ6rlkNgEypHfVsTVv9EU7Z16Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRPSkFsibwW3jIOf0GfHX57zzcXAttdY/13rK6LEYMwMa1RmjGUbmT8jMk+R9dQsz1To+yVHI5RYqKUoU41iXQR+UxC/iFi2IvdtT06c0zieIdtGWSfnFRZzjGg+jlB6e14C8vdZHdRJFDJX6cWHgqK41L0Gujdc0dVW19WKvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3d50882cc2so15964966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759337110; x=1759941910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RpMi9Th+Po7AoazGbT2yu6utd+ZudWSIE+dBXn6AEw=;
        b=qB/dz64xk/ePRkUO8LubIHC17XPAKQsRHTCEY51HrfUPNSvWCITIhLjqiJpDsjc61M
         bPJcgLya5sHEvwcHAWB9gcwaK/dAwxAmkfcu6gWfmv9WmUhJb7S+s6wUbEGzOLCKR8Vs
         blLid0VAzQHy8tN0VsbPoG1hzveiQtf9u26MnxwVfF1+/C5snvuMwEZIFq17RuD09cEP
         ADWe6QxTS4iGbZzYR7pROaEyALwOTrH+votcielNkvQObqYzbIRvpEqZ+CXY4me54KVK
         crQYDptD/g1J/n/oEr0AvKXtCl1VHczMSrlxPlAgba7ZkFd0kRULnA2hqqDKd3aunabB
         oi0A==
X-Forwarded-Encrypted: i=1; AJvYcCWmiI2phOCVEXf3JjRZDXdmyICVBvqFRdDyy5jL+U+HkeXbieWa1Q/lT9QKepjlSTs1FXrleYbu+VloVtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuXSq6amlVT6ddgb+NcmWemcvNFc1AvgpZTAajTaw8NlBdDcT
	ekJVW0yO00Dl5X1tdbIwYMqyK58ko6sGIUFHW4gveCR2tgvLELRmzt6P
X-Gm-Gg: ASbGnct7xGf2DfM2L/vYjDMvR8I/aJhDYNDbW0JLMDAHJp5tGL9s66NJpBJegHowbg1
	ONpc5Y2RSyP0hPa/a8dOXI71xiMIR5h7+lQjAlrG9IMvXjNm+vc3Ye7nVYzwKJIJyzRngHrWG2R
	7wPTNdHWKS2SRUeMKY2JgbJgdERXXh+9ZqGODLI0vCSXF6MFGqYoKMmW5H1124JV+FFOHqmqBOn
	UaGoK6q4OnWssG2H/9mAwMjou8NdijQGWDW3g/bZSAV+K1mohESn0yg42xcO83bwU9XFcTp+0EO
	k17xiQKoPvrfMN0A5G5+f96egskn5K8Ju+1/yfj2h41wAMNn7bE1tJxj6j91bchA8MEOsOwrnPP
	dESAI+IG9VSOtkSv3piQqSFYUydFtWKEv8w7eRQ==
X-Google-Smtp-Source: AGHT+IFaatL0zRpXljYvk9pU9uM41+0gFgUFUB28SfXW6ic2vlnE+OWGmtK1CqAf9k3bMM7SwTnkww==
X-Received: by 2002:a17:907:1c95:b0:b3c:31c2:b57d with SMTP id a640c23a62f3a-b46e99531a7mr534332566b.55.1759337109937;
        Wed, 01 Oct 2025 09:45:09 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a178610sm1548866b.92.2025.10.01.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:45:09 -0700 (PDT)
Date: Wed, 1 Oct 2025 09:45:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>, 
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH] stable: crypto: sha256 - fix crash at kexec
Message-ID: <jm3bk53sqkqv6eg7rekzhn6bgld5byhkmksdjyxmrkifku2dmc@w7xnklqsrpee>
References: <20251001-stable_crash-v1-1-3071c0bd795e@debian.org>
 <20251001162305.GE1592@sol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001162305.GE1592@sol>

Hello Eric,

On Wed, Oct 01, 2025 at 09:23:05AM -0700, Eric Biggers wrote:

> This looks fine, but technically 'unsigned int' would be more
> appropriate here, given the context.  If we look at the whole function
> in 6.12, we can see that it took an 'unsigned int' length:

Ack. Do you want me to send a v2 with `unsigned int` instead?

> This also suggests that files with lengths greater than UINT_MAX are
> still broken.  Is that okay?

I've tested it but kexec fails to load it, so, it seems we are safe
here:

	# kexec --load kernel --initrd foo 
	kexec_file_load failed: File too large

> Anyway, I'm glad that I fixed all these functions to use size_t lengths
> in newer kernels...

Thanks for that!
--breno

