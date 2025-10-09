Return-Path: <linux-kernel+bounces-847353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3CBCA999
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA1A1A63DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6B24677D;
	Thu,  9 Oct 2025 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NAmj9lvV"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BD2367B3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035666; cv=none; b=iaIj96q9ZMhZGlP4CO7RK6kr8XAySwnezBZvISj04ZrcxIHxRDcqcYBwBhOSgYUqySpTHwp9T0vrGdFgJCE3aO7HIG9N4d0NBtRm+wrU1pqMbe11IWnywUTu0DdwlBSbJ68MQb+Td+r0umxxwVW36bv2kPAhBSixgtIr2bcejFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035666; c=relaxed/simple;
	bh=6HU2ogOxfConCjwhrj/P+y4fX+mCeV5OQFl17ezkvLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1TCsoGZHDA7OdT7QcY0fqPiXe1S0O2c+U76VLkBFqW9fPVS34lRx9sc9Y7Vf1jLyS7sC7orss6KLOtHRDK9k387NBj6mEtJUi7q6y4ShzXJYXgpUlZZHy4oe1iHGjZqx0jr5L8LTACNSsSCuaK4kTB7oLOJSc/t7SZ8R3sEEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NAmj9lvV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso10564225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760035663; x=1760640463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZuz8JrVqo5e+MsWYBkw7+610nun3cMbHCKwMsKJZxA=;
        b=NAmj9lvVzCccPcKN0AwrekQJkajLbzsyq1nYki1fnf/leQ+2Gb5woLOsi221IFVsaV
         bUWmcRhDScf35pIetUnEwR97VB8LztQwNT4v8A+0lTgylEJmg/8BgnwfUh4lOAim1JHw
         2LLK4u0dvkBKmZ9BaazyZYM9afpKHk/x77aYGXAjV/cPh84rpELKOTl2fqGTibt9Udcv
         595k3egqtn2KZj5+2wD0NuME0v3isETpPvTQ60Fcy5Lr87M96IMrOc/Qk7HHu6tGf9vG
         BeV+bZ6IVYragCsiT5cnu/XNBo/i5WrAKbzMI8P78tvijezZAgd6zSeb3pW2RcrhMk7e
         C4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035663; x=1760640463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZuz8JrVqo5e+MsWYBkw7+610nun3cMbHCKwMsKJZxA=;
        b=sdcmYqH+CnaSlqx0wj+ASSgAphVw+d42qBxTdYCiezH+XiprE2Iyj8sl29elosvOa/
         m9q85ecehAv3JNTapsdcx4zr0jv3b6yooF2EIivWWv7LiTqdWz+EEZGRigMfl68ojEjZ
         aOcvAT8TXF8xnwkfGcYYN6qAvGKik2t1vMulcxlgb6QUfY5DEpazteatpI3+/lNCxHEK
         cWcHqxyEtguSxSHYY5ZSnTmz+vebADMxtXokfFvFi0LcoasstMSzyXmAy/j0Iyt3CKxA
         AgdMH+F7zJQsU+kv7VxSYZq+sWFgzzQUERGeKg0I283iEvQHrs5igWjtgcjnwCOaOe4W
         p7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW67fIuwXynCr1U0EFeYa5J7R9a3b2i6ubJzBJAsJx9TJZfp92dIZoK1tWRms0SGgEop3hEdRsQGV0vdnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTM7FI3ghrFr0ziDT7m3MGm/X+Aj4DAPxyTyXySOPYNFkeg9+
	QSBLN3mQe5yKiiOYGQSZBjbejeLhrBHPLstJDchLrCc9dWEiLO+/VlZbgMnKT4SPr6Q=
X-Gm-Gg: ASbGncvJW1jlF/BvUDb58Nc1h89tJPs3thuvK49z5FyuUGoE/oDOnxNW2ECnsR+toLs
	zWCc5sPVc+kkw7Zzz/jrtePr5Ef0PckZ98IVqXu0mTkmurbRMmroKy4PYqRWd97RZZZNZcEbDdd
	Sz7sMKX2KJal33WpGA4q/YTn5OhMIQ8zREX0gFAk76oHtQiYJfX9zVNPir1kMpJ9nTcKX41bcXZ
	kNQjCW/wq542WNiQ2/bL9SJXq+0IjXhmZkBxx9HgKHk2YUyjxGLZc5mnDpXjkZHp3o0zEmBSpdX
	XScBTCTqvFzqETS2VY+u4shZXDi60//C9qYMl9PiRE0dQFvsuio76X+n3cteBQLdnJep9hUXcHA
	kPMi20ftWDByDrEC0D0Po0sSLSUW04wJuqjCkhXDHWOSfaFis9skjWOvgWW0R
X-Google-Smtp-Source: AGHT+IH2XffCPdVW2wDSNYolrsEznFcKKrupYPDvnhkYrZPBJ7pYB+H9+xoQ8tpot3VyG+35KxzuQw==
X-Received: by 2002:a05:600c:8b74:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-46fa9ebd3edmr60535505e9.12.1760035662797;
        Thu, 09 Oct 2025 11:47:42 -0700 (PDT)
Received: from localhost (109-81-95-234.rct.o2.cz. [109.81.95.234])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fab36a773sm44576745e9.0.2025.10.09.11.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:47:42 -0700 (PDT)
Date: Thu, 9 Oct 2025 20:47:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gourry@gourry.net>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	corbet@lwn.net, muchun.song@linux.dev, osalvador@suse.de,
	akpm@linux-foundation.org, hannes@cmpxchg.org, laoar.shao@gmail.com,
	brauner@kernel.org, mclapinski@google.com, joel.granados@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOgDTc-xix66RxXc@tiehlicka>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
 <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
 <aOaR2gXBX_bOpG61@gourry-fedora-PF4VCD3F>
 <aOdSvriKRoCR5IUs@tiehlicka>
 <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOfU9YTKMPWzYOta@gourry-fedora-PF4VCD3F>

On Thu 09-10-25 11:29:57, Gregory Price wrote:
> On Thu, Oct 09, 2025 at 08:14:22AM +0200, Michal Hocko wrote:
> > On Wed 08-10-25 12:31:22, Gregory Price wrote:
> > > > I'm not quite clear yet on the use case, though. If all the user allocations
> > > > end up fragmenting the memory, there is also not a lot of benefit to be had
> > > > from that zone long term.
> > > >
> > > 
> > > The only real use case i've seen is exactly: 
> > >  - Don't want random GFP_KERNEL to land there
> > >  - Might want it to be pinnable
> > > 
> > > I think that covers what you've described above.
> > > 
> > > But adding an entire zone felt a bit heavy handed.  Allowing gigantic in
> > > movable seemed less - immediately - offensive.
> > 
> > The question is whether we need a full zone for that or we can control
> > those allocation constrains on per memory block bases to override
> > otherwise default. So it wouldn't be MOVABLE but rather something like
> > USER zone.
> 
> 
> Mild ignorance here - but I don't think the buddy allocator currently
> differentiates chunks of memory based on block membership, it just eats
> folios from certain zones/nodes.

No ignorance on your end. As I've said this is not fully thought through
idea. Memory block was meant to be userspace configurable unit.
Internally this would need to be mapped into migrate type or something
like that.
-- 
Michal Hocko
SUSE Labs

