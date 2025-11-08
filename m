Return-Path: <linux-kernel+bounces-891250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADDC42419
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3093A827F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35482289824;
	Sat,  8 Nov 2025 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfiJ9ISX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD426288C3D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566146; cv=none; b=U7wVi43k0jMHR7TOUkPI0yULay2n64Wuxq6B3+sOAYskCZt+pb7wqWAdoJEs+ew1mobexLSEKJ8KyG4oC5YFFkoMKD/QgWkOxVbdbNo+Pf45VZL4RrJwaDq5PF3VSJeb43QwHJN9hS+BUEfOeFhUVUYAKa8AlWvo8RDbyeO4GsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566146; c=relaxed/simple;
	bh=2BoJwDhWmDPG4AVqZIXWOTh2l/C5ji/bwn5DT8jGj5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f11dLqqPSJugDlujEW7E1nf4lnefFIDypnAj7SjJ98PNTlfn6a0Q8jxxpBNCt+sAoURlAzggWoWQx9DEpJfRP1eaB5IbxDTwwNdYPZGHNVS1eYLEgLfG4SVLQ9hg9AV6UiLO36MYQjwQMp4+cQ2c//vIF+/uBVNr6ljFJOM6BUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfiJ9ISX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so210895766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762566143; x=1763170943; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txzBDkuu6HQXRdAmWeqGcCpUJ0ARUbkkBrAd0TRurdY=;
        b=LfiJ9ISXQelqWzBVj4ny7A9nTjIbcSg2MeaNw9335bzIYQvQnHaiyWiCz6RNmdwLxK
         pS9CcCNnUkn3CslqMhTBLHZsAHyhgHr0QpNtqiHSHZYxF7V1y8IJ/vq6zOFC+kyER/QC
         jjtvTzynnrWDLdrmkYp/znrm5jTYp8W1iDpePrMKDjVi8jrA3ORN0ks0PtVEBgz8qELJ
         P9uyc/NHMiEhlsXnRSzYWIVr1T/6gdNac/IU0r5EoV2foVU3w+ikCb8XHhaqEZ5cGDbw
         +TWB7odawleaF8uJ0zmeXUSd99DtpGwVIYEsIh4c3iDLkPh3XQkxs1s4DWn0YVgu7V5q
         35Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762566143; x=1763170943;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txzBDkuu6HQXRdAmWeqGcCpUJ0ARUbkkBrAd0TRurdY=;
        b=g2ZdDVCVOAYQODBbyr3T6FVZsl80121g03fVMiLdc6bPDGnR8TLMYZoBHWVzq59q3X
         p6K/9/PpBz+G8I5iw3rDnyblxHsJJta4HNZZv+Kdqkf/NzWMsXS9geqj3byDUAtAMFam
         LqjxRaDFCEMcntLrj5U0HuL3q8oTPFXvgjwQWrds3FtB+gHhin7U1XrbiFkjfUr1nFER
         5q0KbO2aEAAMfmgIbCwqr4BvWbJrwBt1EiK2QnqhZRAQuSzthlnI262PV855xnlGTg3O
         xr77GoIyCEqpBtNviaUtb4KLpE5JdigzUS0hjHz8mEYOliXQD1u2EvdKBeVlzjc4+2Xi
         KFTA==
X-Gm-Message-State: AOJu0Yxs0YTMtfreDUE77LT/XDUqjXgpINcszsU4rpM4tEzr4g7kE9gw
	wKA713TtgPASCiv2onysGF+sTUhxCOz11+6yT825T/eZW7VZ1XroZ7af
X-Gm-Gg: ASbGncuJFjPb1CSD6kiGO3I9Jgg6wC38xFLc0rOUgOkDZEEqjXElIsFAJo6k9V3cQ8Z
	Vc4RS5nDyw191zQ9dPW4GkrV2i4ZDCH8+wBdmGIGRYOHnLr9PzPTIxqtaMOhn8dgraJw/GTJv4n
	DbEmzMr8blBJGQFFP9Ew+COG6QHd+EHtfRA1zmuySUIum5ukHlEVKkA9U4xVV6FoOJgrsS0GB7y
	f6xXgH2QJyg/885WBujcvRgSpqvdU125KrXCITcNyIaDNGFKVfp1p3P8R4MAeiljRYRZeHiC+V1
	qPd2Yv+asAS1KbGxcXOzCPugj7D5UES5l7NpyL7ubIHuesTncKxR2ZMtV7gtztoOuR7bwKcJcLN
	3EiUt/38qsP5v5QOMquAvnuuqIUIW7IgGz+F6LTvxPTycopBOIXSMcnytbECcMavxNFlz9ecB31
	ckMRkotu5LJw==
X-Google-Smtp-Source: AGHT+IE6lrXy8Q8tj4IT56byqhqDOcFo2Ljy91kXlQBEAHGBuKzDKR+fUlhhjwifft9Xb8qZcgHL3A==
X-Received: by 2002:a17:906:6a19:b0:b72:9d56:ab52 with SMTP id a640c23a62f3a-b72e02d20c7mr117552366b.8.1762566143114;
        Fri, 07 Nov 2025 17:42:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d0ffsm406996266b.46.2025.11.07.17.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 17:42:21 -0800 (PST)
Date: Sat, 8 Nov 2025 01:42:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 01/15] khugepaged: rename hpage_collapse_* to
 collapse_*
Message-ID: <20251108014220.wpstoj3kqxxnes26@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-2-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-2-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:03PM -0600, Nico Pache wrote:
>The hpage_collapse functions describe functions used by madvise_collapse
>and khugepaged. remove the unnecessary hpage prefix to shorten the
>function name.
>
>Reviewed-by: Lance Yang <lance.yang@linux.dev>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

