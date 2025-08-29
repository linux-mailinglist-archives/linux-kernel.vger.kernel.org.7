Return-Path: <linux-kernel+bounces-792556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95168B3C585
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529A85A2CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D535CEA3;
	Fri, 29 Aug 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZoojRlP"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7335AACC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509234; cv=none; b=oYDIfpmhEpVDNLxN2Hej8Y/yaG+Fkt2Basjfofhdmu0I22XXfH66DRnxpr9h60w7+nLM7zxCDdvm2o9UdxaYcsJfQWC0AlHUuLZCmWyqwlGDdyqXfRpZE+79JcuPc0QQQx6mY9ggRDfn1bb9DRDuUB0jzB7xVa1R9pX7FJ1CT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509234; c=relaxed/simple;
	bh=Kd92lFRAIOYgKMUvm6rR4XTGIoE4XXGZuPIE4djDiF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKjovBqazukuLYf40e9znwaQ6PSkGk2bmscDPOow60sxyYAmHpkMWdxdiYw9FrUSmZgPfugai92wD2ovhiF8xKwJf59VrW+RJ3RHOuBXcfgTtzmwMsruPP9+sYabAfV2e2bygu4BOeVp0byvYcgX4uOsjmFtGmrQnriWy7yXvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZoojRlP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c645aaa58so1774681a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756509232; x=1757114032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKMZJwDjsVTmitG4egl5rJvGJupwlZyvs6dgtCP+Rz8=;
        b=SZoojRlPPy0DdJvsA+nm68w6uFtcrV5k/YI97Zleg8zNn8JL9yn+NjdGlfE6JXqNbw
         5r/SXd7Fk5vdlRr+WZyBcLbu+xdTpAhhGoNHkE39/+nPOrYKj/NEoNdhVB3FilQyKpDz
         Le+B8k0FLfarH32/90ylcHzTF2PlO0kBXNMg/bhFA+IEDw19uIrU34iYaBgf1YGevAKg
         FK+DWtrGpRTtDeAAvs7XByF1RM57q0cWoqV2hq+BLSbH+dUezM/CSbcqndoO3SYNiacO
         TstEXSywCbd4nO4/iKYdUy+fLyFUco8+r5AukjcwwUaUrvjxTgTPk+60e9N5KsRKQijn
         sc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756509232; x=1757114032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKMZJwDjsVTmitG4egl5rJvGJupwlZyvs6dgtCP+Rz8=;
        b=BwmHWjq/dkahyEMHVGt6Loig5ALjnHU8GMua7yxUgXMKnJBsttfZFmdLIOfB6Sea4q
         B/+w8pfqfkZ8yDSPNIXz/mgBQu3zQb82TK37egrKTOmB91Ysh2XYrLVSYY24C/olGRUg
         TcZC831w0jjPPHu2sXRKi8QZw1SaO7mCNoGK0BMUtgKMIQm15UY0/STv8IO39Ufirtb7
         uyMXItYgKpHD0Pb+528J4vA8j6AMHOYbnErh0HA7KrGOgVFRY7KAFyPHI/wOnYgafqKv
         M2HkUY7KI8P9cpkwLDE821+/tWwGvlWcLZTJlMjBNJpeSzG/3xwqVnYJMfqLsOfHosoD
         BunQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGMKZL2KYFA8xtkKjq6pT61SHhASzjJ0PnrkbZeGENZ9MVPTk3hbPy37XdXRpUzJD3V2vyEOx3XEP4OZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJZeJEvkNPlpz7NoRdiTQLQJpTC3QUuszS+KS8uTf+yNrTWno
	b6CTmZGDVAI4/DT7wz79VU+cJ9Pk+iI45Cc+g5Uz1fcmxnvbyqRBJ2up
X-Gm-Gg: ASbGncs7WwdrKBkoRb9lCQxnhJ8ZsneQiyLHSA1ueWqmoBIX/+T8SqiM0Vqgyagfi3K
	/7HUZzyBAI07Ia+rtfgrXw69Tm0C1ykAv30Wsxx3y1iL9vEhWpilMk8GiLanAx+zjGhCri1AJyz
	scLeeVfrh/QtJnTioVjtOtpQL2QZ8iQ0egf0k+ihrRHKqbgffI/XCh9x905HkCEvAZyIVOADA4l
	/sqMgI7mSaiOZntfsM2EwrR9fW8fWyi3M38y6+fmuc+rho/+k3gGXnbQ1VPpi6LG4w4aZV3nhZJ
	QZSoFoD5X69h9qemOCWnYWRyNsiuztxWGSSQRnFLacEEcvAR2eeFTxT0gQ/DysBn00AhgTBtyXS
	rYAwOxWPRlwxbX4XZhApwy16eWGiuY/oEZW0WmtkeaXYxpW1FFZkVrdLYvR8M/3Hv0xTDTQZIDv
	w=
X-Google-Smtp-Source: AGHT+IF0f61mr7i9UbhN+swOmPYiYgbOjyDTF5MYXElz2G+ZdhxTXXCpM4fMd0JZVLu8lnyif4ht3w==
X-Received: by 2002:a17:903:228b:b0:246:a16c:5699 with SMTP id d9443c01a7336-24944b3d697mr3667125ad.61.1756509232549;
        Fri, 29 Aug 2025 16:13:52 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327976b5074sm3401820a91.4.2025.08.29.16.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:13:52 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:13:48 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 07/12] parisc/sys_parisc.c: add `const` to
 mmap_upper_limit() parameter
Message-ID: <aLI0LHtS0i5GMnOe@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-8-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-8-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:54PM +0200, Max Kellermann wrote:
> For improved const-correctness.  This piece is necessary to make the
> `rlim_stack` parameter to mmap_base() const.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

