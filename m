Return-Path: <linux-kernel+bounces-868793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1854DC06252
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B23B85E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D12DECB0;
	Fri, 24 Oct 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQcvobLz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EC2DC776
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307073; cv=none; b=lGUES53j1Kf4onP802yneAxsy5OlCeOAgjBsCVU6XkrbZ3LRt5i1GfBFdRENrnW/wS/dxNg5O0YJdy0MNPx01Xd7Ld25V5YeMB/lys1skdnDyya0XHSe2GdavZpEOqpIE4S4os39xjtWU4wFLIDo7QBG9rfrlSlKbY2XTTcYSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307073; c=relaxed/simple;
	bh=otaptiYljJ4L8Ixl4ylVIYP5kpRrDvxCoiv8Pn0Kzhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDj97LmeuuV+X7VLbWvaqKHYgzEOM0PCSlqzQRVBbdFTTs/lzMrvMKjQDKgptO0k3CG21QaIMOm4+hWAKD3XXZdjz9zkan6GvXaH9zgLvI1fm5uVuuherpcgcDUflHag3fpEzhJi8r1bXCDajk8zDGxCh+Srs2lek3YXncL869g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQcvobLz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-474975af41dso13536575e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761307069; x=1761911869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAbdJ50faFATYVUU4QEMwOR1mWtVgSTW8fiGw4tcaIU=;
        b=eQcvobLz5z4ytYMauXIplLeWZ1IPpnLhXqYZ5bZkmubyy3SdGyBJbvUK9mUZS8XidC
         VbWWncLAN9NFgSCLwN7yhUQrhPb0zuY/8oqfvjq8xqy4AnSM0X06/Y3pcTBNtVBU2+3i
         s8bYw6vpPYPIRKZzvFdsLdfFV8Nlj66GDt0ooBFcEEf/0hbnRndDNE+FqoogV9x2l43V
         X+e7E9o6YROstxYuS37ZVrTBYyrRZ33PHc4nncvw4rUaB+1MMDf3bXgXQkXKjKpKhyA0
         sL3sR9OTrbn8OSXPRIxkwJfObOSCCFDOt1XwNaaeAE1nR3v4PLzeb+yC5rQmnr+cSLHw
         kliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761307069; x=1761911869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAbdJ50faFATYVUU4QEMwOR1mWtVgSTW8fiGw4tcaIU=;
        b=QWiVquQOETQynQnKhrawxiWL0JuUM7PkCgdgcbZtxbVz+TAALbxL4V+sWCGJ2SXd0C
         +vEJ64OjJpqZTtg1iCbsua192B38uBaywjnuWQK86uGHDtBt5TMMtXX6IfdTf+E3N7wu
         5zCB+8H28Th0GrlgXXHqHd7AmwNngtQ8F4jeEzZdYCfcaZU8GAESERKGQmxXdOGKkqS1
         jOq5XHOBwpDzVQxDJkCDtTU8sd6N6+0ctp9zVNtIP2PT8J/Abw7qoJ1XNVRJigWk+5gH
         LlIyygaKQUPV4oQvO7RkQXZR02ooTiPFCm0K+cmcrPeho1W09qFVMFPwNBL7kCP2IOOJ
         K+eg==
X-Forwarded-Encrypted: i=1; AJvYcCX0J0HiAJL6pXxWrHp6zuk4VhTX8wuUzR7COdU0SsuHmbXwNmIX2mXoqKlVVvhiG0IIV3cCpKMKDqCNWtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzxOsCT8AVQ3vI8AjvFFmEpq21k3dgeDK2wQsD2D2K83Rxm8f
	ULPCsCsrAwvVmnmFls/Nryzb8fKZAJwNB2J0Vx1AjJqkRm0RLaGz3XTXHdpvLaYrLls=
X-Gm-Gg: ASbGncthSq7cKjVgEDdFkIaI688tTejWBi5WNE/3OVTmUCYRyek4BmJYhLQT1/K3F0D
	X4euoyKP3cinVOJtqdfDe0Jybe7uLXoKxLrub3lreL5k4G2EQBVLtx8cesBQTKMKUj0ejaZH/dU
	XFV/uJk9lC522dgSfrbEhpn6nnYIX1uWy2Oh+rnJFyeE+Huokkzk75xcjQln3RRBNdw7qrXvUDt
	2lzm+Wnq7ndD/9I1PCAn0pWPGzzTj0NWHtHxgA4uXLgpMYy5ky4PZJfq2jjxa0rw5gMaZGnalAi
	elMaT51j2GzMxL9iZGIayg+ru41TtOW41CW/RQML6PNb1Xj66d9OyXs+ZMIc8X5PI4XxCvq3eNB
	InISZFBBIdgz/bswImnJZrEncrRj+601a7smIn3jg8AfjSRfUHrsUkqJ0ZlfC+b+ljzuetK3YKr
	aGr3WeRcB3ZZY=
X-Google-Smtp-Source: AGHT+IHkn/lvpCpu0B0ADmiosRvhDFk6JrpJ0ihTHj80p4hmIReVPZhkYJ83NCv6hwHIUkGZp+NwmA==
X-Received: by 2002:a05:6000:2503:b0:3eb:dcf:bfad with SMTP id ffacd0b85a97d-42704da9b9bmr17875433f8f.34.1761307069433;
        Fri, 24 Oct 2025 04:57:49 -0700 (PDT)
Received: from localhost (109-81-19-73.rct.o2.cz. [109.81.19.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff3f5sm9132325f8f.22.2025.10.24.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:57:49 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:57:43 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <aPtpt4hYMuJnwnOO@tiehlicka>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
 <aPstDXRerYqi1O2X@tiehlicka>
 <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>

On Fri 24-10-25 11:19:50, Dmitry Ilvokhin wrote:
> On Fri, Oct 24, 2025 at 09:38:53AM +0200, Michal Hocko wrote:
> > On Thu 23-10-25 18:12:02, Dmitry Ilvokhin wrote:
> > > Allow to override defaults for shemem and tmpfs at config time. This is
> > > consistent with how transparent hugepages can be configured.
> > > 
> > > Same results can be achieved with the existing
> > > 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> > > in the kernel command line, but it is more convenient to define basic
> > > settings at config time instead of changing kernel command line later.
> > 
> > Being consistent is usually nice but you are not telling us _who_ is
> > going to benefit from this. Increasing the config space is not really
> > free. So please focus on Why do we need it rather than it is consistent
> > argument.
> 
> Thanks for the feedback, Michal, totally make sense to me, I should have
> expand on this point in the initial commit message.
> 
> Primary motivation for adding config option is to enable policy
> enforcement at build time. In large-scale production environments
> (Meta's for example), the kernel configuration is often maintained
> centrally close to the kernel code itself and owned by the kernel
> engineers, while boot parameters are managed independently (e.g. by
> provisioning systems). In such setups, the kernel build defines the
> supported and expected behavior in a single place, but there is no
> reliable or uniform control over the kernel command line options.
> 
> A build-time default allows kernel integrators to enforce a predictable
> hugepage policy for shmem/tmpfs on a base layer, ensuring reproducible
> behavior and avoiding configuration drift caused by possible boot-time
> differences.
> 
> In short, primary benefit is mostly operational: it provides a way to
> codify preferred policy in the kernel configuration, which is versioned,
> reviewed, and tested as part of the kernel build process, rather than
> depending on potentially variable boot parameters.

Please expand the changelog with this explanation. Thanks!

> I hope possible operational benefits outweigh downsides from increasing
> the config space. Please, let me know if this argument sounds
> reasonable to you, I'll rephrase commit message for v2 to include this
> reasoning.

Yes, this is exactly what I was looking for. Thank you.

With this information added, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs

