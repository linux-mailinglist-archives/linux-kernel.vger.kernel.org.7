Return-Path: <linux-kernel+bounces-879149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979CC22631
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D221D40218D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C4335567;
	Thu, 30 Oct 2025 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR5rhbOJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8D335577
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858819; cv=none; b=CTDI4DZSo9Tm9aSXZP1ssl5rr0LaS9oSAVSl2F0jFXhHSwRjeGKRh0r5csTXWgzftL+l2+kgij1HeQ8ay8xATKgmsPkW9vGZoCefHWA3+WTDEr67tnuFwLbjZvvMlmw95Wc9bT5SOiUhWN+pYE2eRdgWIwm4S9awQ2SoSJnMYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858819; c=relaxed/simple;
	bh=Tkl73WNfo0/AUKTwzV3moq/33xXpIbB7x9Cq5z+ygVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSYT7TkdZoOf/pGIzATSURh1DeED6S7a+amr30RTXWFh6USff7aG5vZpFc01iBHQyBU2Tp/V9uBfUqdCw9ejWExArybsKJoZVxTNhXPOhFyvH5daiQ6g4DRN14MuLIAlcVyqm5QkmZOFtu4hEV3QmBY7ECQBIGC+dto7muFITR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bR5rhbOJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761858817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qSMd9AkD4Z7b3gNm80YcCcg0oGBGt0b/as95bErXJ4=;
	b=bR5rhbOJbrREq6Q/sKimvAcpMC8sV0m9RPSVH0P/cwosHaeE04MRFlF287wN+dfHW2dYpZ
	ziqmHgmBnjM3AGuCPyMwEUP1TAp1tJa2BpvDrEdPc63QL3qne9O07F7k/4k6zv7r4yslEZ
	crCXAd1rsHpb/dfUNIxBHPn1NiXmCug=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Z_UhnjtBPIyWA6zIXyi_mA-1; Thu, 30 Oct 2025 17:13:35 -0400
X-MC-Unique: Z_UhnjtBPIyWA6zIXyi_mA-1
X-Mimecast-MFC-AGG-ID: Z_UhnjtBPIyWA6zIXyi_mA_1761858815
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88025a7fc9aso19410526d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858815; x=1762463615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qSMd9AkD4Z7b3gNm80YcCcg0oGBGt0b/as95bErXJ4=;
        b=WFXptUON2rxyKbm6j3ON06D9WjGVrr7r3lSCDs14rcHryKmCBTSdQ4JYgo8kMXXqzk
         1VFz7K/rtAI9Znqh2HJX69FCINH28OU2zSZ8IqI2eDWNP0zDKzgynRZ3SmyPimrzSvmn
         VS8BZ+n++pMtJRh1A9XLPPmHUKte4qTDLP9bPZlHpkd70pYZMAJNZCp13NacJKHXlRrI
         3HG76QZgzG48cBLqaGbdFGU0uhQaSeq9A1XTUecXI57ttTcfQrwHO47sbKN/ZaUsfFTB
         M2tUg1v6D0fZdo52vfUORsKcg0cSdZY0fOId1038WgrZFMzXIgkD8gexEZEZhYT/NRR+
         o6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSWjN0S/4SJrW5yj/ef55sSEJ6HxhNgd2+QVa6JGrn248xZX+O7q5OOmay1syU0x4joj0oPyVANioSr4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxknb23BTxP3UH6R5H9q+i7iJfnTrRh2GkhVVDki/BfWlnHievQ
	u+GnwWxwqAcUFFL1wQtGVxPVHmGvOu8EkhHjjluvG3bnyxgtTBThxHorOY8SE4bLAurkQfLMKZe
	+IQup3pIhtyFod51KxRBA708Qh6FMGt1oqhvwJXuyvmvtF4Ic4DIzyMA3s+Q1NbpfNA==
X-Gm-Gg: ASbGnctJT6Ag9mBOwbPrZKlhGkf+zDidTKIu4hc8RspYjgkg0j2dPE5imZjBvQi8lNE
	g3ThX6F1ifsQgKMwp69BhcFZHvhETP9qmjz/WNLpCUgf/6PMateK7JaIQOieBZfOxL9SHAObHPI
	LKO5y+7x7adAo0EzC0/vV4kjYSER90m0S2Qf8GwFhuE5VGBVcT758qfbQSYacZ7rPAQdKCIwBVM
	89k/hkcB41YeRY+ExPjywO9PHDCNYwheB27oTRK2JHeoE1D+YnPPaKRFnRXYhJ6cdRUQqSftXnq
	nqjDvMGzXiK+dJMJI+pz9YcUL28vf9uRPdydKQgiT+Xp0iSWmh1sKX/NVQWuuCPpIRw=
X-Received: by 2002:ad4:5f45:0:b0:772:45a0:4e28 with SMTP id 6a1803df08f44-8802cec2b96mr17784266d6.5.1761858815210;
        Thu, 30 Oct 2025 14:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy39LrKID+rYZSIuDUuhKO4bD0gQsxxZgkOrydITJ3UUu9nNWFlxRyOoHC0FWqEtv02hCdfw==
X-Received: by 2002:ad4:5f45:0:b0:772:45a0:4e28 with SMTP id 6a1803df08f44-8802cec2b96mr17783756d6.5.1761858814718;
        Thu, 30 Oct 2025 14:13:34 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49817f0sm125018546d6.47.2025.10.30.14.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:13:33 -0700 (PDT)
Date: Thu, 30 Oct 2025 17:13:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aQPU-tyo_w68cnKK@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>

On Thu, Oct 30, 2025 at 08:23:03PM +0000, Lorenzo Stoakes wrote:
> +cc CoC
> 
> Peter,
> 
> I'm sorry but your reply here is completely out of line.
> 
> I know tensions can run high sometimes, but this is a _good faith_ effort to try
> to find a way forward.
> 
> Please take a step back and show some respect for the fact that Liam has put
> VERY significant effort in preparing this after you _repeatedly_ asked him to
> show him code.
> 
> I am starting to worry that your approach here is to bat off criticism by trying
> to wear reviewers down and that's really not a good thing.
> 
> Again, this is _good faith_. Nobody is trying to unreasonably push back on these
> changes, we are just trying to find the best solution possible.
> 
> Comments like:
> 
> 'Your code allows to operate on pmd* in a module??? That's too risky and mm can
> explode!  Isn't it?'
> 
> and 'that's the wrong way to go. I explained to you multiple times.'
> 
> and 'I'm pretty sure my code introduce zero or very little bug, if there's one, I'll
> fix it, but really, likely not, because the changes are straightforward.'
> 
> vs. 'Your changes are huge.  I would not be surprised you break things here and
> there.  I hope at least you will be around fixing them when it happens, even if
> we're not sure the benefits of most of the changes.'
> 
> are just _entirely_ unhelpful and really unacceptable.
> 
> I have an extremely heavy workload at the moment anyway, but honestly
> interactions like this have seriously put me off being involved in this review
> personally.
> 
> Do we really want this to be how review in mm or the kernel is?
> 
> Is that really the culture we want to have here?

Gosh.. Seriously?

I'm ok if this needs to be audited.  I have all the previous discussions in
the cover letter as links.

-- 
Peter Xu


