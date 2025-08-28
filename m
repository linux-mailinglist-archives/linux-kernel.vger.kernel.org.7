Return-Path: <linux-kernel+bounces-789225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D486B3926C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149B67C5D08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2B25A2B5;
	Thu, 28 Aug 2025 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TURctcGd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380741E500C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354027; cv=none; b=XIyqYlAopr2/L5Y5f8qNaToYmr61Lukw1mcAX10fX26E5I3p0VPyQYthgQdCvHjoQwtpGmAP28tmDbSElwhL6T6DaML9Y6diWh//vFdSvtv4apbCbmkBvB6JfeT3rYyrbHqj4cdpR5AUM2YGJGXimVGS+ZYoOrUPeVSXwqA97EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354027; c=relaxed/simple;
	bh=nCQ3pwttBtXCBlCj0GOYSR/MEaVgQ0DVFQSM3EtHDOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj80Rkawe7stxEoU4nFrfWWcqXdLMMRXctu4vrsbPxxL3LQDdOkgriTDnDTDSwurG3RBP+AbUU0L1BeQbVshpTFTHQVnSxEz3M1NHCUMiAg1P//gQtmisbl6AsyeubTn8IfTIChIOz6uycVxjwrRm6t+a9vyTkpLvzYZxYPszxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TURctcGd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248681b5892so104915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756354024; x=1756958824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKxx3AHJzssWTQS4qsQitsY+pTv4aEpgVk4Q3F8J/ZQ=;
        b=TURctcGd7/OT3GB+FhtLzGrXYiVeLj95JykT057tFA6V9TI38QswcM76Ma9Wzp3noK
         +u0KFdp19gahoJbyzBYtkMzBEtxkNU+1fv/kLJi9cPiYYdd7vFdlzDua7NdcgtKcRjR6
         G7dj883ixRixlOuokVz/ofuYz24d8QGIGc9bt20mIjJTu4+mEKleAi5xKOpdZnEiuMab
         g4h11VTO6aZTb39u40HX5P38Iz8FjqLtoV0zKPjc5g9XFKXVoezaw3eddWvDHFKWjBkL
         KQsURFMcv9s4lgmdts5BSbfxRnWiBn7kTBtQap3zYaFZ3UWTW4U+BuU66eqA7z6IisF/
         XWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756354024; x=1756958824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKxx3AHJzssWTQS4qsQitsY+pTv4aEpgVk4Q3F8J/ZQ=;
        b=hsKzYLCdKPYsKG4gd2G2odOhMRUhCWkB4JU64mBR0fJCQdIgnhOHuAyH1YQfPlPmuh
         FMwf7yyDBYuWYAGNIY2//PUZg6T45GTb7GG+tlH5oudcXwgrIl+2f5S5Gs5X/4RIQS9H
         qTWmnn+QB810gBPh8ZPO45paAt+JgPDtTk1e8GitbW/nRC/hJIOZLyXf4AYUlPGaudTF
         YjGdo0haETxqjv1C9+rP+NRfWM+7rtklnz9NwbzvLSUkOiOy9OA+fzp74cXG3y+j/AOU
         vLI++YF8qe7yJ60ylU+QDEL9Rs0GHss0fBYx9i40sqOzKxuAZwv62eNFstjQiYWI2CFn
         /4PA==
X-Forwarded-Encrypted: i=1; AJvYcCVbcFpaB+7YkF4/CvgKZYDr0mSQIP9Wbz5RBnCOhzMnN8oM29vN8VSyOc1sPMB6242V89GZeyBEUcSSQI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hg6wrY66cldDWj/0f0FFLeqMetciA4OTZnifMWdxQnJV05jO
	txl5Pl2mL4R3YiZ45S9E+h1pHEH/v0Izkyqlm65fwhUo/EV1zpq+2QQahQdrxO7sxg==
X-Gm-Gg: ASbGncuxl+os7aVBn/81xAYOiAl11Ae7ft2y1H8X2h8Fss/pk93e713wjVFc+sT15qm
	ndSSqESr+oKC5JwrMiCtRN6v3yh7qiw73WcH++KdseDqsXlm+2Ftbblk5/jrn9VSharYYVripZW
	cOWFCbWDui4SrfDR/fRhoCgFpTDVFcdLpNoCPssKtsGKQE3YUWYliJlxeiU8fmeFeviGYGKPY8V
	z3RoBhUS/cLxFnLP4vAhbr1yHFkstFeKyKbf/ZcIqP6+LNKjZI5oo9KoHqRg87zxYY6WH87IWTL
	c1EGOb+OXGWHge4QziRG6Rog7zsPTGGdRs0Z2XPW30FrN2PAIxKZvOGAu2Zw0WgCWOap+2lR9Dz
	vN48nUQdXKejBLdX7okcOwx2QZYtpEIntbHzp+NGVWSgp2UYytwZI8myxMN0d6a9cLlb+oysd
X-Google-Smtp-Source: AGHT+IEhJaXUpm/3jABKEO0/i+uPSd6jtOc8RtyaMS8Pll7cTZNJiHYF2mPDEp+IH3Qy4jST8wMAwA==
X-Received: by 2002:a17:903:2348:b0:248:a039:b6e3 with SMTP id d9443c01a7336-248a039be4emr5139285ad.10.1756354024077;
        Wed, 27 Aug 2025 21:07:04 -0700 (PDT)
Received: from google.com (3.32.125.34.bc.googleusercontent.com. [34.125.32.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb88f4e5sm12850589a12.1.2025.08.27.21.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 21:07:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 04:06:58 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:MEMORY MAPPING" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/mremap: fix regression in vrm->new_addr check
Message-ID: <aK_V4sOUOIpEhFC-@google.com>
References: <20250828032653.521314-1-cmllamas@google.com>
 <xpxoxn25fzhahdyvjp2vgmcnek6oot2hhvb5niz3tw7au46eno@cixyid6ywf27>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xpxoxn25fzhahdyvjp2vgmcnek6oot2hhvb5niz3tw7au46eno@cixyid6ywf27>

On Wed, Aug 27, 2025 at 11:43:39PM -0400, Liam R. Howlett wrote:
> * Carlos Llamas <cmllamas@google.com> [250827 23:27]:
> > Commit 3215eaceca87 ("mm/mremap: refactor initial parameter sanity
> > checks") moved the sanity check for vrm->new_addr from mremap_to() to
> > check_mremap_params().
> > 
> > However, this caused a regression as vrm->new_addr is now checked even
> > when MREMAP_FIXED and MREMAP_DONTUNMAP flags are not specified. In this
> > case, vrm->new_addr can be garbage and create unexpected failures.
> > 
> > Fix this by moving the new_addr check after the vrm_implies_new_addr()
> > guard. This ensures that the new_addr is only checked when the user has
> > specified one explicitly.
> > 
> > Fixes: 3215eaceca87 ("mm/mremap: refactor initial parameter sanity checks")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> I assume this showed up with clang?

Right.

The specific test that broke on our end was this:
https://android.googlesource.com/platform/bionic/+/HEAD/tests/__cxa_atexit_test.cpp
Although I'm not exactly sure how __cxa_atexit() implementation uses
mremap() underneath.

