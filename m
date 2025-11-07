Return-Path: <linux-kernel+bounces-890788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7602C40F70
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E07E422CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284E333740;
	Fri,  7 Nov 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT62PiDh"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFB33372D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534744; cv=none; b=iZ+5e/eUG0ir3JV0Uo8oJEQtMZovHnH7AtsTss9MECaQObPToLj7k2x98eJ06YjsYJRd0ya2tGoUE1/fEZZPoo7dyfB4wROpAI9QmI0lMG64RGG4Fc5kxXcS91ArO4DB3mFKAYQSflKU5njodvdJp61vHhZzAMnO7v55prD/uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534744; c=relaxed/simple;
	bh=cJuEyJBd8vNxec7ils9DOazLPyWiTBMKYf6Z8sfY0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjNmbrq1Pd+Yx1zRNRBxzV0rK78PwUWCtPh8j9rjOlBbBzSf7xrP25Vb6j5MNKqJ91PsW7zLlRjJyUHWqMJpGkUsfEYfTakXm0SuL3bC6fRy50t6ZtU8lPzRMKhrRzqWWWAWu98eaA44pUH6vt1mLYlfTM2N7rk1+HPbbUmJ3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT62PiDh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33be037cf73so948874a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762534742; x=1763139542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4sd5p9K6Q7d7iLpd9Xn8vyRDq9SyY6gsIqiEGANBmA=;
        b=DT62PiDhor/0JlwSqPbIOUpWd7T3WeVdwYryLsv+gd1/o/WaSI0y8EuuX3i8j4eiJy
         Qe7oans013JeczyduMoN8WVd3bZTPtgtaiBI0Kki6cAQpZ+1BLrkLvOuB4ltztpZ63oC
         rTbsJerAIVj/cayccEVgNwvGrGTMhNFcTTd5WTtoLHnC9e5hoz+A5UmTPDtInXmo6FAt
         cyqY+2AAQOuPsbOrpTWBdDrN8bp6/jl32MfVQpN+Cx4kHU0S5Rdcs6JJmRzLu/MPxzlU
         auBk9jolBJdvBTPMNU0dWI3ul/AKoRrD/uikzx0nL6FJaQ+Ya7clvbpFoCg5i3GQBCgi
         phGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762534742; x=1763139542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4sd5p9K6Q7d7iLpd9Xn8vyRDq9SyY6gsIqiEGANBmA=;
        b=uVA+w4iTvHe3SY3LkRbcaEA2vjjue9nu2xJwkjnzj43SNRFq9eYXLApWdLEdqdS6hr
         Vcx+NzeK96ed4aFb6zLv2n4MnU8r3SCCs0f5oLgCMtxjfZbOSAnbtmh4pgO6XQ82euV3
         YrN909uC7QbLDIDBoNRgE3G5tKITAPA0bh5/tve4bnihYSzuQaMyCmwvIfLlGAPf6MuM
         cLeGHA30AcIOBPO5dDInYNjLpoUMXsiMOroND4PWuOaqsyKwj26MbHFoAXN2yk6p9jat
         0jUHGMYoyvsH5CCKZOwOoocowXI3I5EI6wW4K4KWYZo1AoAMANy76b9CII5eZ5EYqha2
         zdDw==
X-Forwarded-Encrypted: i=1; AJvYcCVR9lzCTqDIsgi0BgAnlQG1IYqR7PiL1XDnFmdmDQ+EhDrFtdLoc7je8BQIuEfbfvvG8aE/ZmnQOHwU0Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHikobbMEWRp3Cb0WDRig29kpfK6AWqWHmUjZXZTdVeiauj6wZ
	icavWsyQvE6S1MmU/0OZbzXgXiuUs2bz/BVIXDI53IVrwGH8eHXkBoUM
X-Gm-Gg: ASbGncvDXUELEkVMD915KXBcn0joi9QfsU4ksD6ShV+946z5OPDL54HuIFuZhtVmYg5
	iSDpB3927Cj3U2VOQmv6k0fOxeScRa8x6gtIsDGVNDm4eQ4Yw15rHiXMarLZMoMo1nLZgDR2hRJ
	F2Cr/1H8822D5eEe99jUV1w7/u9SKn9bbVgX3J1Wba3K5zt94+wW0odRx1vSwc3NzoAlsVn7yyX
	deZ0IQrgZ07rTQckigmnVp0iH3FmrbPaiBgbe4ceh2NviEOyMDRyQMj+bVnppqPRUYs+dSmjlXm
	b/BCaYZX46xtpCCQ2h8zepQISwBmT30jxnrDoLFWh8YXZu2mEYXfUL0EUDyienW8lQBlvxoOuSu
	664g4C2JmxLduBkYJf7IkCkBP5SyrC3W2y5k8MqYf4mvxVHJRZWUSXfjzzb1xre0UsQt083Sea8
	CEjBGhfhEAdLiLL/QEEm2epjuNnfkWWQHN
X-Google-Smtp-Source: AGHT+IHMVwIIf/5HSM26FvAI00bqSm2Te209tly41PcGS5bZmMWGwjGv3U8TNmpLDYqzMgZOpWO5tg==
X-Received: by 2002:a17:90b:2547:b0:340:ecad:414 with SMTP id 98e67ed59e1d1-3434c575537mr4058720a91.27.1762534742462;
        Fri, 07 Nov 2025 08:59:02 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a67e2f82sm10072766a91.0.2025.11.07.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:59:01 -0800 (PST)
Date: Fri, 7 Nov 2025 08:58:59 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aQ4lU02gPNCO9eXB@fedora>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107095922.3106390-1-chenhuacai@loongson.cn>

On Fri, Nov 07, 2025 at 05:59:22PM +0800, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

I'm not really sure what "Refine ... about HIGHMEM" is supposed to mean.
Might it be clearer to title this something like "Remove unnecessary
highmem in ..."?

