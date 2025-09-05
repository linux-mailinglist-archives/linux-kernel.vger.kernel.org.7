Return-Path: <linux-kernel+bounces-803844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1FFB4660D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76F93A73E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5252F747D;
	Fri,  5 Sep 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC+s6T3B"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649462F3C16
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108463; cv=none; b=bGzY9UWQvYal5QmWRWw+YajKxzhQLpTbYjQ78J7cUXEv3PH0+ocpQHnUTRCIM1GKa1uMXLQtmf0dO3YuEo86vY8saW9V7vAkqnOWI5H2vXhYw/XPX5o90dguAC9PLV1AxDqW06quCKfljt8TWfHLFA/5Ez+O5ecvggdjKrbu09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108463; c=relaxed/simple;
	bh=EISgDghY/knXbNwDvDGK2KSaNFpugS1NjVBQvkSH1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQpA6Nlr2E5NMOWNE1HSvgsWCiabDuK6f7lKSE0IY2yCqXvAxn4EBoyQUECttjFZEJSYzfcKVsu9hlH609uSEJm+uPMXxSVQPNv8NtNPNifzAhcTnVVcwr9R3lD7JbjgCwyla+cIkK7SiR5yCa9ovKFXeILNdmxoTCvLJ/AZ0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FC+s6T3B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cca557085so25785ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757108462; x=1757713262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ/emNLCJz3vxOzQ9R3rq9Yl2yjJO1c1zooZAILHbKw=;
        b=FC+s6T3Be9OhbfE3d46wlRbNypqlcHGfaR3fU5bGf9ZyZZ2fmGWCSbQb8rlZzeCopj
         pjofAdVG2MdF0FLFJNlh06l1AmQhy0a4E+kRIKUgBoRZssqSbeOHgvo8vu7514bZHzPK
         iDT+AMRi0oWyCNR/ccVAKWZKlLYIgihTf0MA6nv+onyUu+RUvcXDwHJ727YGTjOItv0X
         dPVBLYEr/8muy7TKkxfBC7ig1GE4nqlEcJTYe9jyEuqO296rAivFxzq/b+lBSBHrxoIQ
         GgNavhIfeBMjXK+1dBa645uzHc1zrm5STYCy4wgaq4yAN/kfLWnwDPyvDSipNESsqV2n
         CGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108462; x=1757713262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ/emNLCJz3vxOzQ9R3rq9Yl2yjJO1c1zooZAILHbKw=;
        b=eS1fZRFe3wZ2i8E3p0gtoi/xR2h6sURxgzasnP3FXCGz7vG7LAoCO13JL0Syai9naj
         FZPppWRO+D9mIEhBMUmGh4MHrh/wtLLnXUQCZ05IG2xUkO2n6lSLatKt3bKbAHsNrXGe
         ZaJ/H0jXVqA11jgxKn7y1sSPC9OIWgp3aztgWXhUlcf8DC7x9oNUUNtu1LyMNF/KwulK
         NxGQnBYdlI6UsLao+AB2FiImwab0VH7CuEaOJOAz1LZMII98gavNHmAC2cyFbH9TDgfy
         P5XlwTKD9RB3wQypRuhjL79iEKz11RAB9fQiJPu5/jKmh/M512oVk66ej4qKJETSFHBM
         MuCw==
X-Forwarded-Encrypted: i=1; AJvYcCWQGVwEmMb5TakrDyOoNQeBYj3LsgSyMBi28XpiWkNDKTe3ty7jw088NEc4eK3LIgCxvuQmBkuUNQmBUl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQN2V0FpQrPvtevRrvhJc8ph6yVkjxhKysuXubiganRX9jMr3K
	Va/VUa1alBcx/ZyYSm70VCtZdlQfgdhWWd+QXwYaKcF8hzgFPQheJgD4QgtD0Wv/Uw==
X-Gm-Gg: ASbGncvfqWwSVqQa3uA5CuD+jQTjOa9LtbSVR045ohUs4Jj6b9dDQe65NCHE8wvQf3L
	kbZ0QnKyl9pfvy1w4/a18067mHsy2p74wPSOvgvoNHPKGYv+uuBoIhHTslVF4/ZxEQFTiRIciBU
	CcbdC5JuVO/WTu9y5g9jxRZk2mPHjxTBjV0ZZsN4MuF7sDDfsDt0r2mcm61J9eKRfhXmsLTuBY9
	Azh/mihbPGkGHne9MTwmjseZldb7TF3YXS365ksw81YOb+M1pwS6uqWnFys2Mg+gGzo6es+Ximx
	BhMfjjoB0456soSwfVe2jiGO39L89L6D+EPHyM5gTKk/Yl7czxQtSpWGEVn0ssyAwMCqTx9CVBL
	qHi9g73L3WHqmE8Tzhk8HodL9MDP7e359Z05RFb0to56Nbf547sVa9rsreqdY+piG+X8=
X-Google-Smtp-Source: AGHT+IEgsoKeEdAOmf7V3AwPOG3rhylbsP/X4Pjd1kcqhKfVj8Dc8zkYrCPZC0GXi2o1KWjaV1iW6Q==
X-Received: by 2002:a17:902:f546:b0:24b:9056:86a5 with SMTP id d9443c01a7336-2517446f701mr288115ad.7.1757108461368;
        Fri, 05 Sep 2025 14:41:01 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aaa70sm22678386b3a.24.2025.09.05.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:41:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:40:56 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aLtY6JqoOTMA-OtG@google.com>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
 <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>

On Fri, Sep 05, 2025 at 02:33:16PM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 08:48:46PM +0000, Peilin Ye wrote:
> > On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > > Generally memcg charging is allowed from all the contexts including NMI
> > > where even spinning on spinlock can cause locking issues. However one
> > > call chain was missed during the addition of memcg charging from any
> > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > cgroup_file_notify().
> > > 
> > > The possible function call tree under cgroup_file_notify() can acquire
> > > many different spin locks in spinning mode. Some of them are
> > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > just skip cgroup_file_notify() from memcg charging if the context does
> > > not allow spinning.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Tested-by: Peilin Ye <yepeilin@google.com>
> 
> Thanks Peilin. When you post the official patch for __GFP_HIGH in
> __bpf_async_init(), please add a comment on why __GFP_HIGH is used
> instead of GFP_ATOMIC.

Got it!  I'll schedule to have that done today.

Thanks,
Peilin Ye


