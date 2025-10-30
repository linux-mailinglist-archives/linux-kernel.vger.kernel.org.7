Return-Path: <linux-kernel+bounces-879159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732AC2268E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2EE94E290A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE907329E4F;
	Thu, 30 Oct 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMThK6dB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361B243946
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859596; cv=none; b=a7YZ3RT+gedNXSbxVJU12QHvlrJiFPNdqNLsfaBQtNjXEfZC4CJuhpzZFWAUNC+mEQ5aUVJjo4XPxgJLQnxu0IX2UQANaiEA4hZZD8ZWH7uFUWvMwlm4/G9ML72D9bDD6q4JgigTzf2nHJhtMAAJOTWgLWjfzDqNFGVN8V7PXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859596; c=relaxed/simple;
	bh=dQEiFXVz0JMpA8N8GHKIXxdZGy9R9gSfkvveVmZZ1hw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYjXRjaQC+SIE+cX3K85OEqUlYbMP8ocQw1KxU3fHf8sBm2o6W4MlCLEnHdlC2iemFCaCv1mJwK3IT6hKCwMuYT+fq3TnOJwkhWV5Lfl1MN/c8wa/63vjbHRYDc9kQgyVU/KAvElgIX8RlaT1oveCeEZ1UJt4zLb5IVIUuiXnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMThK6dB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761859593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XgVIQD5aWQ422fzsIKMP+ZLt+yEoc40OBPASzGap/g0=;
	b=BMThK6dBJqwiENP5MrucMrK+Bxa8hw7FWloBHroXfhSFHOQXCsV0V2Dcr394ennsm9zSUt
	tBtd3Jalkx23xrRmKFUYp/x/6RHLCl47SV+3JcRWUCCWGgIBgOLpzQYeyNE71//cyH5RFA
	KXDQsACVe0OA712kU76IAIjYnbYaqkA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-rJLEHa8qMSG9jzlsbqse2w-1; Thu, 30 Oct 2025 17:26:15 -0400
X-MC-Unique: rJLEHa8qMSG9jzlsbqse2w-1
X-Mimecast-MFC-AGG-ID: rJLEHa8qMSG9jzlsbqse2w_1761859575
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-880047f8636so44800496d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761859575; x=1762464375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgVIQD5aWQ422fzsIKMP+ZLt+yEoc40OBPASzGap/g0=;
        b=H65q/zHLerFQlPbtuq/6d7qoe5FxRw9RzB8au9oG/35kdBk4oDn/LafZJMfSmVPoG7
         ab7pq1bhS3Yb74Z7EycAumIDVFr8e1wZIGE7ksDdZ8lsc0IDaJ6uf7P3czbdjyV8pfem
         qQ0KwiA9WdgUZlbWG3KiOahBtq2NheMnSbglrJORVrTlubqpia4CTj+y1HjD791S9d/n
         GvwaDJkZHGXsSlScCapKkW5PpN2sAQYE85o11CnVcbrSzW15ssqlDoL3VstmzOwjjc+l
         7ewcvqEicGzjnwBhc9UTtScpjrjB+zKwfEFmhu5PFaTUIrAi1VeoSk79PyrC3UsOBmJ5
         l0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBKiQ5K0JBIAYtxwoeQ0EVlkGJI9rryTPgGZ/wV1dJ/Y6llukOBWTg+UQ0IgC8kSuymiXf+eArBk5NrWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2W69kf65UfEDZxkx+qOpk+oewf+Lq9pswjtXDyUPrqGt9pDQ
	7U3Df1kxzst3eeJngs93C2AccTdqpYYVUmTESpmvKjLI9FGDWQZlNGGdkizF1rJUHlR14qHpbt1
	oHZIAZsFPAhKRE9nbGpq9AI20XGeiZa6bsBXMIxcN2HLSjAby9dm+zDA4W8cAbJPMug==
X-Gm-Gg: ASbGncsdTPpab7SHeK6H8CpF5AwSCD9l9IJiCW6OD2U5I+PGUlu5+f+k52l3ynyzWgP
	ln+8+8eTIxH0eMvEHqc75tx0bE+rUtSTXh06D5sFZdKIji/uPGkn2lOutsXL3/ZkkAWaGdb5Yks
	QxZu71iUAkdyGgariqhVyx3Tz/kZ7qyF+/GPpjL0OZ72G+RJBepvlI2K0rvOedk/mRob/ziot/x
	yeEMOiKiwZdGs6D/If/ZGs8Vd/VwZUiaVtSP9fp9BTLMRpcty4v3QRwwve/Zyn7uou0Xu7Bot6Y
	qqWIN3BK0vptWDbtXf+Lqhluy0cEqiXbKDJDvTXrZbzZ9ymeZgq5SHZEXGHApvUjvoQ=
X-Received: by 2002:a05:6214:410a:b0:87c:182f:613d with SMTP id 6a1803df08f44-8802f474589mr13457096d6.31.1761859574796;
        Thu, 30 Oct 2025 14:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0JmLlnzB82e3Kk7AsB2jwv+C0PCCh85J25ND88xbRIoJmCyRx94dBKENilCOgrPNbwyPBw==
X-Received: by 2002:a05:6214:410a:b0:87c:182f:613d with SMTP id 6a1803df08f44-8802f474589mr13456686d6.31.1761859574311;
        Thu, 30 Oct 2025 14:26:14 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4992095sm124571466d6.48.2025.10.30.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:26:13 -0700 (PDT)
Date: Thu, 30 Oct 2025 17:26:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aQPX859LbBg5FmE8@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <6odeeo7bgxgq4v6y3jercrriqyreynuelofrw6k6roh7ws5vy2@wyvx7uiztb5y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6odeeo7bgxgq4v6y3jercrriqyreynuelofrw6k6roh7ws5vy2@wyvx7uiztb5y>

Let me reply in short.

On Thu, Oct 30, 2025 at 04:24:46PM -0400, Liam R. Howlett wrote:
> Right, so the existing code a huge mess today and you won't fix
> anything, ever.

IMHO fix is the wrong word.  Cleanup it is.  I agree the current
userfaultfd code isn't extremely easy to follow.

> 
> We currently have a uffd_flags_t that sets wp or not then passes it
> through to set another part of the flag to pass it through again.  This
> is stupid.

I feel like you're applying very strongly personal preference to this piece
of code.  I won't say that is stupid.  Axel introduced it, and I think it's
still an improvement comparing to before.

> 
> And then it gets more stupid.  We then check that flag exactly once for
> the second argument in a global function and NEVER LOOK AT THAT PART
> AGAIN.  So we now have a type to contain a boolean, but we keep passing
> through the uffd_flags_t, so we can see if wp is set or not.
> 
> And you're fine with it.  In fact, let's add another one.  I mean, we
> tried for two but people didn't like two so lets whine and whine and
> whine until people get frustrated and let you push a second one of those
> gems into the code you REFUSED TO MAINTAIN.

What I refuse to maintain?  I don't really follow.

> 
> This is what owning a problem looks like: I removed the uufd_flags_t,
> because it's stupid.  I removed all the hugetlb checks because I
> modularized the memory types.
> 
> I'm happy to address changes, but I'm not happy to accept more
> middleware and "it's not part of the patch set" to address any problem
> as you push more trash into an already horrible code base.
> 
> We need to fix things too.
> 
> So I'm fixing it.

Let's wait for a 2nd opinion on the approaches.

As I said, I'm OK if everyone likes your solution and if I'm the only one
NACKing it.  If we can support guest-memfd finally whoever adds that, it's
not so bad.

-- 
Peter Xu


