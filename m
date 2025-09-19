Return-Path: <linux-kernel+bounces-824821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396CB8A385
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C6917D498
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC20314B70;
	Fri, 19 Sep 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8XQrelt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C7238C36
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294748; cv=none; b=R1rfmjiJYKY/x9td4eLgkNjc3dmJkhYirHj8nDPZQdO1GKentFqkYLCxfU86tSEbwuI+DdA+TBp5u/5n1lLUajfUJDE5PJLI8490iP42U3ksMIbB3i3qh1HaDMU3QNfmTu8UFq8us6G/nhW9nPPJcET/IxEKI+fC8KG55pIsbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294748; c=relaxed/simple;
	bh=3MIDnjYZ3e7EtfQAgvWZD1tywVTk3vEaWCYg8Q0b2yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olD3QZo2pCEsOVGApxkFRhu23vYdukWNcoBUjoC9vAS3NtWUOJG6zQCVMauz2Tgn7dkI950OECYQi1AA23l2eMlZDvb3WBlr+AaNg2J4Q0PGgWsZcSJSTO5PULao4zwhdyxi5mFieyIMwzSKeYMH8S76c7mcixi/9dWFUojGCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8XQrelt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758294745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmJz52HRci0hnUvV7fGD4Inffu0fj+CyCOx7NYmarUo=;
	b=a8XQreltl8bI3tlY4E+5Qwler7TTqje/q+5yh0ScRvI6gSNcJxAfbaWSWpWTWNyF7LXorq
	7vHXEyt7qsIewDRFu4kfl+aU7m8vgAKA5x8xYtPj18m4GYQU2IcEx7vF+9DtkIsAeqYrdE
	yjKDD1fh0Z0BYI0jIUwuT+Nuqf/kLzk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-cHmJN68KM4axs_xaQl7nOA-1; Fri, 19 Sep 2025 11:12:23 -0400
X-MC-Unique: cHmJN68KM4axs_xaQl7nOA-1
X-Mimecast-MFC-AGG-ID: cHmJN68KM4axs_xaQl7nOA_1758294743
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78f3a8ee4d8so32814026d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294743; x=1758899543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmJz52HRci0hnUvV7fGD4Inffu0fj+CyCOx7NYmarUo=;
        b=SdjIT4zFv764pblEtsLIMvWOy90UuLJ7GtNAK1E6qHUz9e6khl34AqhypHKa5Sgvk0
         SBr1vEiQTejFmRSxEjucOWmUgDwF5SLfKrcfnrztez01PRqmfPNSh0VlPvumA9uTiokQ
         L+311GiO2606oyN+ZF2y0WW6eVlMxyc0oF84QN73YGs1HBXcojQuvchA4lSJ5bLMzrVQ
         DH5iz449s78lLFAHTkAclEK/RcoZVPkZ7UJPeO8nCZggpaIBcyEpfnBe2EmhQa2KyD/M
         7ShzW+aqE8FOXREcr5sEbWvvOQuhZdDokDjfn3wZoYJJTstIaUNwTdVsjguvFGgYFUQ3
         EAJg==
X-Forwarded-Encrypted: i=1; AJvYcCX3plK5FDbKv4ZV4159We64L6ovXHHytmD1XZfqIrN6GJVBqkiX6xuWKfuTueWD6HSHs74Zl39NkXuFMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCsxk4HjzQgfT+lrfLul3enPMHAPw5q3T+U91JokuD5Kneu/x
	dkxdP3/cvs1Ud4jdNB9vYQdHqxZDq2UhEHHwyJDrMjYR5ARU6q0GweKNIxvOTcGPjNiJiA/w+39
	d0e1S0MYbflFFSVTYgZDkIHat3T5KSsmtkP6BS/9Hle8ocb/6E4ynauPP3dyJJ9D2CQ==
X-Gm-Gg: ASbGncs/FE2JssWBKbro8Y+Poqgbl+4Aa6Yo3I59aiMg50oYQ6JrvsO041FUFyQ9DmF
	mc+pdlDnaxlSce1yD6eZElCsZ0WvCFis5bFuxqTI64Lgb7jfN3b1rgRUA14E5O7w70NKIiw8SMc
	+ui8hrBub8wMRzd2p4EaTGferQJenNMGd3RCrM2gXwWGImxY0/QdYEwZ5JnaJspSqWCt1jF8E16
	i5np/tRMkU2g+uuDiL+FrllRNMzW2LzWINa9fue0v8RQQvdntCFx9yFcZYxSlBa9W3a24PeKBTY
	L5Bg+qGL4s3PE2ZDaLUVbymgPH81BJuc
X-Received: by 2002:ad4:5ceb:0:b0:791:cb4c:9b6a with SMTP id 6a1803df08f44-7991a92e840mr35669286d6.42.1758294742594;
        Fri, 19 Sep 2025 08:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCDlUJCkHLQ6VjNNDvf2z4Gu2ZNi6fnE7IirCVygBUyU26zMlumF7vXOau4Gjkxek8FmU4UQ==
X-Received: by 2002:ad4:5ceb:0:b0:791:cb4c:9b6a with SMTP id 6a1803df08f44-7991a92e840mr35668616d6.42.1758294741979;
        Fri, 19 Sep 2025 08:12:21 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79347e4d391sm30251696d6.32.2025.09.19.08.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:12:21 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:12:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aM1y02xaEUkjOIsW@x1.local>
References: <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>
 <aMx0oGwRpSTcfdnf@x1.local>
 <swfs7qpgrezamnijhheiggwdfklfqdc6ahp5g7nvprr64m7wz5@msf2mqajzbuz>
 <aM1l2YMmvBgiXJ8a@x1.local>
 <33dc85e3-f3ac-4179-bf1d-821135fe3c42@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33dc85e3-f3ac-4179-bf1d-821135fe3c42@lucifer.local>

On Fri, Sep 19, 2025 at 03:34:39PM +0100, Lorenzo Stoakes wrote:
> Peter -
> 
> I've been staying out of this discussion as I'm about to go to Kernel
> Recipes and then off on a (well-needed!) holiday, and I simply lack the
> bandwidth right now.
> 
> But I think we should all calm down a little here :)
> 
> Liam and I (more so Liam recently for above reasons) have pushed back
> because we have both personally experienced the consequences of giving
> drivers too much flexibility wrt core mm functionality.
> 
> This is the sole reason we have done so.
> 
> We are both eager to find a way forward that is constructive and works well
> for everybody involved. We WANT this series to land.
> 
> So I think perhaps we should take a step back and identify clearly what the
> issues are and how we might best address them.
> 
> I spoke to Mike off-list who suggested perhaps things aren't quite
> egregious as they seem with uffd_get_folio() so perhaps this is a means of
> moving forward.
> 
> But I think in broad terms - let's identify what the sensible options are,
> and then drill down into whichever one we agree is best to move forwards
> with.
> 
> Again, apologies for not being able to be more involved here,
> workload/other engagements dictate that I am unable to be.

That's totally fine, Lorenzo.  I appreciate your help on figuring things
out.

I do agree the discussion actually went nowhere.

I think so far the "issues" is very much clear, about exporting
uffd_get_folio(), as you correctly pointed out and I'm glad you discussed
with Mike.

My point is that hook is totally fine, and we need that exactly because we
want to keep ->fault() semantic clean.

Just to mention, if this series cannot land, I prefer landing Nikita's very
old version (a).  That'll make mm fault() ugly, I pointed that out, but if
all the people prefer that and all the people like to sign-off with it, I'm
OK from userfaultfd perspective.  I don't make judgement there.

Then this series can drop uffd_get_folio() and keep the rest in one way or
another, describing memory type attributes only, and need to cooperate only
a driver with a ->fault() that works for the new flag.  But then this
series will be a pure cleanup.  I'll likely then put this series aside as
it stops blocking things, and I also have a queue to flush myself elsewhere.

I wished we can just go with this series with uffd_get_folio() only.  Feel
free to discuss with more people, and let me know how this series should
move on.

Thanks a lot,

-- 
Peter Xu


