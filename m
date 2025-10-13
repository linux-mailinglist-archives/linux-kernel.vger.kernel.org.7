Return-Path: <linux-kernel+bounces-851338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5EBD6331
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3E2F4F6257
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428E93101BF;
	Mon, 13 Oct 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2jI27vn"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285630C351
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387703; cv=none; b=qImQdYYLuMEme83VlZzNRNQDhtuH4YAZQKFEuE65dlf0PZStDh4SDJFJ6ILMhBuEZHMM3Yhk6ZB3NkOrMbBqQmYX678JZ49WYp8KD+KIBiE612NVEn1bfEGSlmGoTx3jwI24htrdwDx7lWxF6p5GhQrwAX4cwHt6uXF9c8ky6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387703; c=relaxed/simple;
	bh=3YEF5bzST+wguygMCXS+6Frhc/h64VxVGjpmYffS8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPLG7PDLYolvj2fKsb1sDis16zQLPc64wo63JTDk5x2JmUkbVg8NxrZRAOUYORcqwLunp/L3eJ27ghrZJg4N6/rl+AxZrEm+BrGiWoHDQapa9bu+YCfT3218pLfmtv1UBIPh1nBSz/6d29/9kkVBTyPA1LARfxytC2T4cvdKG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2jI27vn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330631e534eso4989565a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760387701; x=1760992501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi6zpywViHyg0rZmDr2Sj3CEd3jNM8KwSi4LIweWIBc=;
        b=X2jI27vn8OpRro1lMktJ/1V0SjTESEIOhJU/zMdaqKDMe1OxSJkzi7sc4Knl3tStYV
         jhrlPmHqLu7mR5MwvYOqhIAkE/3P9RZENvOjozSFpCQcKZqD44IRsm9lD+b9IWTDYIt4
         odqCVfhzb+9cnrlutp92NgonXmb4QrOv76O5EZBLnfkH+WglScRzDJpoESMFgo4kCRFS
         GJFIV347W2617r4Q/d9xbEjU5FV73cc9doeXdcMEf+CVsHEuYMzgMCfKjCQKKTqFY2tq
         7pl2OnUrSMrxTl+R4M1HzVd4nAkvYkuyuA5q7PHpO1okiCbUvJTfEmPysmlN4ecfU38i
         OLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387701; x=1760992501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi6zpywViHyg0rZmDr2Sj3CEd3jNM8KwSi4LIweWIBc=;
        b=aZyXtTGsMUaiWp4ND+MhrS+uS2wTRQVeKMsAgaW79bdiCVCaDP38A3cJCLbdPrfT0V
         3p7t0kWdy2DrcwnQ0uNV+Cs8inrv+/KWg+iCdCG62arFYQ8lqS34ykbhCYPcM5rVHRnu
         GDYG6oGqzOBORhyeYL7N8ugPJl/1DtCNxDvAaFTUi84763e4uECwW7boLOmAZFv4coW6
         qdUdhWu62rP1mgnxWZBVDHpcY1m+t+kKnAxaexFQCllTa0Z6M4LcBGb8nfdIjd0dKdNd
         29OW0FzK00mypWpJg67wbTsuzM8FWWDqeVQDLkBYd7I6nFTt9sXjNu9KlQyY6urRvg9B
         8JzA==
X-Forwarded-Encrypted: i=1; AJvYcCWfHpTMSc+DB/t//lxVOx8KiAEpkI42Pj6t3E9fcXKTT8eHf3J6kWsdtszUqjqDvtDsojEgZL38p6cltJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACd5Ba9XYGVs6sLunCAGiSjnmBFcnfe68jXAzo0HKlxQ8BN8j
	nxyNkPgWIBjaE2wmU6JPmIRiGNJ1+Zjzr954HcCkb4MEyS4yCQy/mSOc
X-Gm-Gg: ASbGncuuk2wwot+sQH+VMxFnnH3F3q4CjHgoPuZ2+TaDl+X2qa//ozCeU53uGy3j43P
	txI3KBTKFskRhpZD1Ot65VlILd7sB4apt+dwtZphhnpUd3Gcm8CBkPMHjuLFpKCtBPTLEBgjTw6
	NdRWDdi12w75cDjjBgcQjvoMvgpWflF78YATL2jlBOpfaW0Mfc1xRUtTZX3ww9LufIDuRGOU84R
	vZBR6JOktu1RHydGJ/wuIKlrhRrxpmTJ6PVeunwnsADMO9cMpaHBXWoXMhNGHHgDkqWxlhizcoM
	+bANps8Szs7xlZy2r6ii3vK0/gj0cTdPQ+eLzOZIbdvXe4f9X6QINaq+vNhbe4EmJkNLjOsU4wT
	ftQRiY48kuqJqLXuZi1ahR6i3eObRjxYYB92WMSRFpkJnLNEk1KkfGCEHkXcnSlKZ
X-Google-Smtp-Source: AGHT+IHl1TlLnzI0+3hLMy+TX/W0Rf1iCZq/G0iERIs3kuJrY09h/P1rpFFkQByPh2xi0/Y1QQC7ZQ==
X-Received: by 2002:a17:90b:3ec6:b0:339:ec9c:b26d with SMTP id 98e67ed59e1d1-33b510f8488mr32419180a91.8.1760387701161;
        Mon, 13 Oct 2025 13:35:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b0dd26sm13326743a91.22.2025.10.13.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:35:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Oct 2025 13:34:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] ext4: remove obsolete EXT3 config options
Message-ID: <3900725f-c30c-4783-a1e3-b2f3df1b22e1@roeck-us.net>
References: <20250827090808.80287-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827090808.80287-1-lukas.bulwahn@redhat.com>

On Wed, Aug 27, 2025 at 11:08:08AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> In June 2015, commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")
> removed the historic ext3 filesystem support as ext3 partitions are fully
> supported with the ext4 filesystem support. To simplify updating the kernel
> build configuration, which had only EXT3 support but not EXT4 support
> enabled, the three config options EXT3_{FS,FS_POSIX_ACL,FS_SECURITY} were
> kept, instead of immediately removing them. The three options just enable
> the corresponding EXT4 counterparts when configs from older kernel versions
> are used to build on later kernel versions. This ensures that the kernels
> from those kernel build configurations would then continue to have EXT4
> enabled for supporting booting from ext3 and ext4 file systems, to avoid
> potential unexpected surprises.
> 
> Given that the kernel build configuration has no backwards-compatibility
> guarantee and this transition phase for such build configurations has been
> in place for a decade, we can reasonably expect all such users to have
> transitioned to use the EXT4 config options in their config files at this
> point in time. With that in mind, the three EXT3 config options are
> obsolete by now.
> 
> Remove the obsolete EXT3 config options.
> 

It would have been even better if all references in the kernel were updated
as well, avoiding all the resulting boot failures when trying to boot "defconfig"
images.

$ git describe
v6.18-rc1
$ git grep CONFIG_EXT3_FS | wc
    173     201    9817

Guenter

