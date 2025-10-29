Return-Path: <linux-kernel+bounces-876660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE621C1C114
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6634632B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EED354704;
	Wed, 29 Oct 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RbJUlx+B"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D834E764
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753927; cv=none; b=UC8cdS6hcnxyXfWq5Pg1q0IlM8XTQhN/OXG+4S5joofKwIFyRSFB9l31I7NXEF7A9L61buvcIwBGsZir+t1cQrlXdJrUE44qIoqp0t2bxqKADUvDrjB/SRiu+PF2488j9v9FkCzcrAvCtzU5VSmOTor5qXJxzv8Ddgt84LlofZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753927; c=relaxed/simple;
	bh=kEAK7ZhSRGbUNqWaJ0QQiDiz9fmOk+Njl0pXJH3ABMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1CbUkOgC2KCuMm96OlVAGdRZQAL2kYWdGmi+QUZ3fl02auebmWSpdHav6EOWNtemDm4LDWKWhC5c8yCu4MgbbnGm1+SlefMzgl00Yd97c/grdB5e5hA1wEV5wu/hue5IxWFmp5FOCH7tY+/Oln5FlYpQGu5KfjT5z6rMYPzvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RbJUlx+B; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290d48e9f1fso221265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761753925; x=1762358725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BIU8Um8BPgL2WzCtUTTPlVESfJGh0Y3j8A6kvteAFhw=;
        b=RbJUlx+B7JliffCG+cvzKGnTwLbDswo8oSxrXU/qhSw1lAQyE6gvry1IQTKwQ/ImyQ
         Y62nyky/FBfpDq18g62nCyMOvJ4Vv+JjaIuiI375QvSbCYzVfefBgV9nnVuS174Tcxko
         0sFoVENhQ8ILoqejO+KOV5i2gsv5yV112AmRp7pTcKDMb4Z9VoauO9FMLCt/vgWaJvmf
         jsOw4lc99FP4yigQM56AapoawY1RRtFsAJ2zHsMDikgqfZtYbDbcUiVGE6M9emHzNrnL
         R0638q0s5broUdhYvAxARZv2E3JGMKHPDUp9XHeXsj41g5gjcfyInSTVU590ZuJISrYU
         DN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753925; x=1762358725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIU8Um8BPgL2WzCtUTTPlVESfJGh0Y3j8A6kvteAFhw=;
        b=VtKgftwe+MRR98H5/Q5lvGLcy3OFqOleZoMtvpxO6j2emFB9yoecsWdDxif2YPbD/p
         ch4A3Gl/p5GyZugZ4JlcotebR1UpM8b6BO6L9qz9Hm8TIKhf5yCXU6t+hVFlj+cOK208
         4WuBX+sFtL0/29HkyFziAUt1BBdNkcAiKSvg4np3pt0yGKr54yKCYD3EJMq7KFsq9pGY
         DXyhjAw6RmA0jRKpq+RmKt4UCLKIN/QF2O4EK7T/g383Ex8ayZkXNzfpqYoPSILFIV4I
         vqEsYKkoG572hBqq9IiRrAyzPawRPwgLSOGnfFBuWxyYrQgeBiJCuvuI++IJ2FWgpHni
         pUPg==
X-Forwarded-Encrypted: i=1; AJvYcCVBqMgluUI4gK8Eg/OOd3ZQiZjCpEsWszjUEH0HCZiVp6iX5Lc4zmIrOuN48EPuBWUS4UA5sP5zmFR0/z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcawmzfA7+ATiycG9fKP1LBiSXNf0hAWRtjYR21ayzk6pQ3pc7
	fc4GpGu0D9VAIvqAzuFw/tsR5YdBnyt7GnVabZnohfZ2x4v87/uQe5EKMcOxMVMVep9e1Kn3ZFG
	ZOHFI+ZvG
X-Gm-Gg: ASbGnct0/GWhRbFFYfTftzYM4lITosXd6UXFgetC+6yohqxSfQa1f3pZmo49Fbe+rp8
	EOtZDWE7cHAeNDl4xFSfxwPoBBTAEE3q/TDpx6z5s0COx/F3vCZfiMBeULE+YyiceG5H4lBURn3
	4qLDTGFWAyGcuW8OnQ2nd8dVCbQIsMMJINtCwFCuIIRxnaqaQNpgOEyJE1t8+cwgrGJSzYf5c8Q
	Hj5z6JsDnL+V0G/W0ZPxLsewdQOrHlp+rhN4OZpnTOhQwGJwP+6WbLjDE1lYjk1w0ADACoHQZ/+
	6Tt2P/TEDIaq8pug5r4asGXgpa+JdG6IoDcZO4ASkeORj7ZIRp55ELIx6wujSEsVpSSB7Ny5eb2
	qyoKvekWNMrBYW2/Hnxqy8MkxA4c15gdTfWNXegrQmLe/iXaVWrdSE+08ciQ7hOVDrv8N5NclBn
	thsi4cS4zaX/eh8BuxLXcJ0ON7qyA1YlVn2fgj/xSQMAsne4hlCLyF
X-Google-Smtp-Source: AGHT+IH50H8XZUhKOk1BG6ZMwEmt+C2yXsqtYcWtxAtNyDfESNv0JPO8bpdkgmBdrdB3py/5H6vBcA==
X-Received: by 2002:a17:902:d4d0:b0:290:dc44:d6fa with SMTP id d9443c01a7336-294de776f6bmr6222625ad.16.1761753924749;
        Wed, 29 Oct 2025 09:05:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9ab7:9682:d77a:f311])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087d2asm16040138b3a.63.2025.10.29.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:05:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:05:18 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
Message-ID: <aQI7PvFcpxFd_IHv@google.com>
References: <20251028191020.413002-1-isaacmanjarres@google.com>
 <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>
 <aQI3z0x0gZ3T1fij@google.com>
 <b13bf4ce-a6fb-491e-a8c7-ecce0d4d87d2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b13bf4ce-a6fb-491e-a8c7-ecce0d4d87d2@redhat.com>

On Wed, Oct 29, 2025 at 04:58:37PM +0100, David Hildenbrand wrote:
> On 29.10.25 16:50, Isaac Manjarres wrote:
> > On Wed, Oct 29, 2025 at 11:03:18AM +0100, David Hildenbrand wrote:
> > > On 28.10.25 20:10, Isaac J. Manjarres wrote:
> > > > When emitting the order of the allocation for a hash table,
> > > > alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
> > > > log base 2 of the allocation size. This is not correct if the
> > > > allocation size is smaller than a page, and yields a negative value
> > > > for the order as seen below:
> > > > 
> > > > TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
> > > > TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
> > > > 
> > > > Use get_order() to compute the order when emitting the hash table
> > > > information to correctly handle cases where the allocation size is
> > > > smaller than a page:
> > > > 
> > > > TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
> > > > TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
> > > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Cc: stable@vger.kernel.org # v5.4+
> > > 
> > > This is a pr_info(), why do you think this is stable material? Just curious,
> > > intuitively I'd have said that it's not that critical.
> > > 
> > 
> > Hi David,
> > 
> > Thank you for taking the time to review this patch! I was just under the
> > impression that any bug--even those for informational logging--should be
> > sent to stable as well.
> 
> See https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> In particular:
> 
> "
> It fixes a problem like an oops, a hang, data corruption, a real security
> issue, a hardware quirk, a build error (but not for things marked
> CONFIG_BROKEN), or some “oh, that’s not good” issue.
> 
> Serious issues as reported by a user of a distribution kernel may also be
> considered if they fix a notable performance or interactivity issue. ...
> "
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

Thank you for pointing that out, sorry about that. I'll keep that in
mind moving forward.

Thanks,
Isaac

