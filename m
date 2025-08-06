Return-Path: <linux-kernel+bounces-758030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE8B1C9EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0006E3A94B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4729A303;
	Wed,  6 Aug 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSdUI9aH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEE260569
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498819; cv=none; b=WHxRmm2g1WHFujk88f4lN3jofcZT+I2hE8J6cetXNbfrs3iQ3ankB3x0baqhB+iE/WG9HpumXw+TbHpU+v62P4mIuveOixLuBBQCz/iEgSKPAMFkqrDDhgjcRiC0ocae5z96L1e0aE/Yp//5glQnU5pxefeJfvnSRYgBAA/Wfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498819; c=relaxed/simple;
	bh=Fxy1GsxFgTmyC+DciW6Y5utDV003qXLrD39oL6xyDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL+Fi9yUHPEyLbfHGi5MUJqKQEFFoJqtdMwpCPEONOGdu3v+PSqjb30jM88QBGNoeXYOsesY4r5RPRk21tQdf/40Dmwu9me+EKqNtb/mouXrgQgjto83fRaex6gvxe8E2A8PD3QIydjIuEfchFS1BZ4XldIjkaGYQDyF9geLy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSdUI9aH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754498815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Nd9MFnTlr7WVrR7s+mCfQ91mGkWMSL7YSOVN2ZEGg4=;
	b=MSdUI9aHx+JMWzY3IlS5JbXUJxNTkfv7w1Xr5jkua4u4PVemvQeWm/1MPPEt49nDY+IRiU
	WYoiMhS1muP+VcB7Ti61+2PNb7Ihno19ZKbd70wO2EWqqXafJ8IXEfcB+Ziby3n/okasrF
	5UKGeX5e7yc0RbOnnb+wKnIo1nnUv6U=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Y4knSa8hNaCaZi5EAwznqQ-1; Wed, 06 Aug 2025 12:46:54 -0400
X-MC-Unique: Y4knSa8hNaCaZi5EAwznqQ-1
X-Mimecast-MFC-AGG-ID: Y4knSa8hNaCaZi5EAwznqQ_1754498813
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e8e28e1d66cso134641276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498813; x=1755103613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nd9MFnTlr7WVrR7s+mCfQ91mGkWMSL7YSOVN2ZEGg4=;
        b=gz2x2Jmfy8cXJJMEyTRWfTWRcBaieGGGSnUU2XhBttcGzXWdPi1yUOiDFly341WmRX
         BPN5DTTuquFiMMMx7dovwkWo1g9ajtVdOVJuo3GkzQ25ekuw7zhfQkyd9W2JZ0n0Y10r
         moStSExFMw9wqrD1xwye63TfivW4xsqa81j18Xi0hK/28O/4DVCHXAi4YtIQmfxZIM5E
         0UrfCxt+4VUJlAAF6aV1Xe+71SakWKrenm1yjoTwdeEMKWL1gTKd9dZGAY2/M/ua9vWA
         pcTSy1uQic02zef9Afz4GLNap04L7HF7bM6aQM/bCKH+i589VguXqKrC8nAkqxdUpdC4
         FX7g==
X-Forwarded-Encrypted: i=1; AJvYcCX30ZIEmyf4jfGUC+rC+xq2+Lsqtu/ZBNwZqS+rwcXdmM5KDaxRzlBpk3gmnOPclmHMPfivZWdzjAhMWrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+o1aGdnpwRwqhA1GMJotnTijoPV81Cu56ONZ5zpf6VkltT+pW
	GzAuUlPUHYnkwD7b/E3w9EsqRH7JsZOl/Hc6lxsvRjYM8k2et98+NnNFMjPrljDZApVTq93V3ko
	Y5vCHFdTNwYgT05kMRZMcHBizzRzLn4ARVXIn4CazJHY4yEpZNoMZ3J25S+VqaSdo4A==
X-Gm-Gg: ASbGncuOcsZyIw0lRkQjCdyZmFpIAvgiWlfR9vvlkzbgzQyBQPi3A5UelY9wiIpVLIE
	Dt6963TAlrro6rpWjKVtSxqoiNruEOFBQ7CxusbpYNZWhRHkdAIu7J2mSoqaTGTbmLAIFvGngw4
	msRFg6Bd/5kXVpn1HpOtkNKIGlKPG9cVYtRjwHcui5O9zRnx5Tk/jH2KV0iLVFKz1J5XDLIjsgn
	xZ3nJPUAaIAIeJI+/l+hmaQGRHkJFYIOx7r6pmoxopt9ySZp7+n9EzaneL3Qvz4kg9n+qLVemSc
	Nn3QeeZrXYEjg7OKSGgcH9MhtBCh9zr+mCNBFhdrIGj+L/Qsu805oIjE+ZielwdsVsjN1s0VDrZ
	7xzIZy4M4nC8CqI/OgaDqFA==
X-Received: by 2002:a05:6902:1442:b0:e8e:2535:5ce with SMTP id 3f1490d57ef6-e902b825c10mr3495165276.34.1754498813146;
        Wed, 06 Aug 2025 09:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE53Eqc4ZZr2AAoa1BkY+1WkbLTnrnGZkrw+oh/AutRhwg1BqQQfEJzXdO3LO6YcxGkkHaG8Q==
X-Received: by 2002:a05:6902:1442:b0:e8e:2535:5ce with SMTP id 3f1490d57ef6-e902b825c10mr3495120276.34.1754498812599;
        Wed, 06 Aug 2025 09:46:52 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3714cb1sm5654298276.2.2025.08.06.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:46:51 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:46:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: use __auto_type in swap() macro
Message-ID: <aJOG-IAmYhjoYVf-@x1.local>
References: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
 <CAH4c4jJ8VywRUfn2z8HnA73vNxviZ53DZttcR3JaPULF3JFkQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH4c4jJ8VywRUfn2z8HnA73vNxviZ53DZttcR3JaPULF3JFkQA@mail.gmail.com>

On Wed, Aug 06, 2025 at 09:15:50PM +0530, Pranav Tyagi wrote:
> On Wed, Jul 30, 2025 at 7:53 PM Pranav Tyagi <pranav.tyagi03@gmail.com> wrote:
> >
> > Replace typeof() with __auto_type in the swap() macro in uffd-stress.c.
> > __auto_type was introduced in GCC 4.9 and reduces the compile time for
> > all compilers. No functional changes intended.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  tools/testing/selftests/mm/uffd-stress.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > index 40af7f67c407..c0f64df5085c 100644
> > --- a/tools/testing/selftests/mm/uffd-stress.c
> > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > @@ -51,7 +51,7 @@ static char *zeropage;
> >  pthread_attr_t attr;
> >
> >  #define swap(a, b) \
> > -       do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> > +       do { __auto_type __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> >
> >  const char *examples =
> >         "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
> > --
> > 2.49.0
> >
> 
> Hi,
> 
> Just a gentle follow-up on this cleanup patch. From what I could find,
> this is the only use of
> typeof() left in the mm selftests, so this should be the only instance
> needing this change.
> 
> Thanks for considering!

Hi,

Andrew should have queued this one in branch akpm/mm-nonmm-unstable (even
though I'm not familiar with the branch).

Said that, I'm also not familiar with __auto_type.  Looks like it's more
efficiently processed by the compiler in some special use cases, however
it's also new so maybe some tools (sparse?) may not recognize it.

Is it the plan that the whole Linux kernel is moving towards __auto_type?
I still see quite a few of typeof() usages (not "a few", but 2966 instances).

Thanks,

-- 
Peter Xu


