Return-Path: <linux-kernel+bounces-720096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C2AFB6F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83C33B0E44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CE2E264F;
	Mon,  7 Jul 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dLQrPkVU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903822D7B6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901126; cv=none; b=UaylAcrFZmgUlpmNT6ZeTVXE5NVEfkT5lEkW7GQeeqHaPJDTQfcdfFjvZ6Uua8MCEj24L4/pocEDSmNG5dnCNzp5N2141+deISnkZ/x7wTDrddXtKr66PXcH5ssnm2OtqWOp3OxrkL7Wxes16dSmZev403HXLpkKSsWhJp35D7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901126; c=relaxed/simple;
	bh=+f5/FQ9COBhDc5Gb3eyPzB5OSlJiapv/LU2Oz9QooTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJLU7kwzEOfhzkb7uUXopqVD+Azi4PcWkEnTVL097CXBlWP7RkxGQY9/KSd9lKBR9ZmDy6ynfSjCxWYC8oTWGtmNysvVxGiLty2F3nNpCOOdZFXqu45gfw/XtMiedAEP1FaYR++taxfRIoHyhjt6jYwbU2UJIVFRWT+9cLScTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dLQrPkVU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so25550245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751901122; x=1752505922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BUkMO3y8xtFeb8SJ1RGkSZs/uXuWNfET6KZvqytQMs=;
        b=dLQrPkVUvoZXHgKObiVbMrHwZ0TsVl4vtw8h6+mNko1hMS6EoiECXl/OvVw76dDwac
         sSUXyOU3FqBLKRWPmqnUdB9lB5HeD5HA4HWgy6eQinsnp+/FGKkZgWm1imOm426OqGKS
         9SwsUs6E1lrOM+dcOiwJP7HPW8J55Gm7oykm9co3DSP7aNONXBD8odLrDoEwa9QUjocA
         dfuERxYrzLDR7QRzx/M+N4TyEeKdme1YqB00V3XmHXbybZIOjEe7lp2SyvW4dC+WjuNE
         W3KdEpNNuUzCH9rXv/l4UWFKv8RXrL5HG4dv6jt+GCgdm0ji4uYEgVnQZwtsiq9vg+rv
         vRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901122; x=1752505922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BUkMO3y8xtFeb8SJ1RGkSZs/uXuWNfET6KZvqytQMs=;
        b=s5tseotQs+oFVm0rzJvccW1OS5MAJ3F+7SoENHWhsXcDbpcd9+YWOYZvA+aFT4CWEd
         fTlx+0BFClBhM7P+EuPbW0BuBL5lQ//yJOuFUWBrdMlCzRI4OZjk8Wwy88FRUAfdu+/J
         hrTWs58ctTXdh3NJ5Y+uxPdqDSGAO2QeIeO2P54BHIUJlfp64FA4lHOCLBJ7kcr5i7Nf
         9a3DePohxsOQlBjUhMeKegGZFf+1QYp2xg5B+dIHFuh4fKIybyawzYmxYxQP3979JGbw
         1MO9wDCmCMST/Vd/MF/KmFbag7fCE57l+m1BG95tkIyaWgNQ0dTVnJyGRzD7/CZJ48hd
         RLkA==
X-Forwarded-Encrypted: i=1; AJvYcCXlFx9lf5CIOgmqjErfgAjNDSv88xPiEyICCHe/0/w8boYkNkVcixLql07eChKT9p4NPsZTING9tXFIMyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQT0FUjvDZHiMXNRRBhQsWmaL/Qh571oIRk7Cvv0gjBoJMQ0j
	kQFzFv+2dfplksVu6dOAlrvUbGLyKt8g38v43Ue2wmMLnNUKAg34mlsaGgHAbcGQ4cs=
X-Gm-Gg: ASbGncsg96b/8SzC23GjE85NNUK7Ousd78KpnL1QuRT9Ea4yZcUtCMb/4kDXDQjiMLi
	nPRK0pOWVuszXu7MBbaFgfxUdQh6QluD0JSoTDEyShV1OqWFPXZDY5IW0Y8H2SLJ2yEIeskdeXh
	/QbfeX/FzGEvt+QsK4qVB/W8kJEMyMqSBJ81uHrBg4uva11COwRCkTeBX7MhimbphMMUXKas9FI
	YDNor78gLmaSuLs5ANYo5Tj9ShAHjkRduNfTILc4maY8Jm7ijxRzqAkSgJD9OGgXwtwakxLKs//
	TNY9xMleJr7zcyw2NjhrkylGSptbZ+ZQPRvMNydwfZXtYL2U7sb7QAoUKSdCs4wMBjW3IKBUetj
	EWzlkZo5OlQ==
X-Google-Smtp-Source: AGHT+IGTL2Vc6Di2p94FuWpCeMPiGD75E2MydcU0kqogh98a2+K2G9jAxgIXZ2qejZWbrw8R0qpTdg==
X-Received: by 2002:a05:600c:4745:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-454bc5c4004mr77773035e9.12.1751901122277;
        Mon, 07 Jul 2025 08:12:02 -0700 (PDT)
Received: from localhost (109-81-17-167.rct.o2.cz. [109.81.17.167])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47030bd58sm10720459f8f.18.2025.07.07.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:12:01 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:12:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Marco Elver <elver@google.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v3 5/7] mm: Fix benign off-by-one bugs
Message-ID: <aGvjwDqRP1cPaIvX@tiehlicka>
References: <cover.1751862634.git.alx@kernel.org>
 <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
 <CANpmjNNQaAExO-E3-Z83MKfgavX4kb2C5GmefRZ0pXc5FPBazw@mail.gmail.com>
 <aGt8-4Dbgb-XmreV@tiehlicka>
 <g6kp4vwuh7allqnbky6wcic4lbmnlctjldo4nins7ifn3633u7@lwuenzur5d4u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g6kp4vwuh7allqnbky6wcic4lbmnlctjldo4nins7ifn3633u7@lwuenzur5d4u>

On Mon 07-07-25 16:42:43, Alejandro Colomar wrote:
> Hi Michal,
> 
> On Mon, Jul 07, 2025 at 09:53:31AM +0200, Michal Hocko wrote:
> > On Mon 07-07-25 09:46:12, Marco Elver wrote:
> > > On Mon, 7 Jul 2025 at 07:06, Alejandro Colomar <alx@kernel.org> wrote:
> > > >
> > > > We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
> > > > doesn't write more than $2 bytes including the null byte, so trying to
> > > > pass 'size-1' there is wasting one byte.  Now that we use seprintf(),
> > > > the situation isn't different: seprintf() will stop writing *before*
> > > > 'end' --that is, at most the terminating null byte will be written at
> > > > 'end-1'--.
> > > >
> > > > Fixes: bc8fbc5f305a (2021-02-26; "kfence: add test suite")
> > > > Fixes: 8ed691b02ade (2022-10-03; "kmsan: add tests for KMSAN")
> > > 
> > > Not sure about the Fixes - this means it's likely going to be
> > > backported to stable kernels, which is not appropriate. There's no
> > > functional problem, and these are tests only, so not worth the churn.
> > 
> > As long as there is no actual bug fixed then I believe those Fixes tags
> > are more confusing than actually helpful. And that applies to other
> > patches in this series as well.
> 
> For the dead code, I can remove the fixes tags, and even the changes
> themselves, since there are good reasons to keep the dead code
> (consistency, and avoiding a future programmer forgetting to add it back
> when adding a subsequent seprintf() call).
> 
> For the fixes to UB, do you prefer the Fixes tags to be removed too?

Are any of those UB a real or just theoretical problems? To be more
precise I do not question to have those plugged but is there any
evidence that older kernels would need those as well other than just in
case?

-- 
Michal Hocko
SUSE Labs

