Return-Path: <linux-kernel+bounces-780993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E0B30C08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA137A953D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95591223DEA;
	Fri, 22 Aug 2025 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoY4MGbM"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D222127A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830978; cv=none; b=M7cMhfpGLq1hzp5kHU+USecBD9gX5zGOOhPAHXgIK+3DJtnF5TxLH+HUjIuZS9EV9n6ZkxWzKysYyQzsqDPiCj+zGDZobbAtg7ys0NPYm51kWxOLryrEZpQefJDyytNI1pIavErjLhrgzI7Uy/1IVwXr90D3QDf1JOwXkNSs8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830978; c=relaxed/simple;
	bh=aPMU73DCWf8/P6XI7AoYL68J4ATtSo5EbLoBMnWRAlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LDTlimxWOTdBDASX86ybimTszBefCnn/jl6ORvZf2TwV5tct2ysNudgXrXDb7Zfcs6rwlTTnEAGM7pEdB2jjXlm7MsVi1s5qzWF6TCb5t2fqqmeN1oZfEUolNgivEpP6A+D4AHU0Ifr9yw1IuxkYyNX13PCh6hfHgLPmVSSLu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoY4MGbM; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e951f2eddf0so194261276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755830976; x=1756435776; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJgMemiOWP2L5ptavtO9iXqPmjWF2lP/8znZnsFWHb0=;
        b=eoY4MGbM402OJ3yhrE1mKjH5TZ134E3HTMrSg/+AHNJLIay1MQ3HOpA57tp35+VjW6
         xosXkvimtclE8OVPszgWfnoe178YCPyI/jqLEX44wCJ+54tGGDBorXLyvDvIx3mAOJxH
         EOQIE8wLkcMYHmsoh0zNZppf3CJ1jzxtGmJy+GaW0E3HULVECxg8hx1K6Xz596TiNKHk
         D11IEd5BdZiE98G9wUXSJC2VvJWS4OL5vYJZujf/jBF9tfMXw5Pc515w8RE71EqdvajA
         TwyD0a/sMTQh1VVRwDAZ3tODhS4YJWGsGHB2XnvIrUAtvm6jiRCcM+A0HZKw+hsBowKB
         q6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755830976; x=1756435776;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJgMemiOWP2L5ptavtO9iXqPmjWF2lP/8znZnsFWHb0=;
        b=jCnXoWtGgBq20QuiFc2yvVGbv3wEnJPOLIchXkHuNRGXkYWGzO+d6QomNBdIT/TMuP
         M/X7ReALYBF0D28Fdv5DhqBBETHp+uQB11wKvDF0N18cUQN3OOEMO1KtDc+9wBTe2BZ5
         Tyr14Tm+I+bGMXa02AAOsJjpCq6cq9OW9v5zjtfatrsGjTw8jNbSDjIOw5NS2lzn9mlV
         9A2LaZcc0UgPKqB8J6GZSNptx+hI1focqGD0UMDgwKz/kVVP4MFyP0ZI1uxEJJqY6lSm
         PwbNnfep9yDcqofTzI7g3R6OcdvSF4s5Hkd2C++9qWqJb9gx0Xt+kTYDZhsJNGV5GUuh
         l0RA==
X-Forwarded-Encrypted: i=1; AJvYcCVkk2s2Cqtl+DjxTt8XZrH0Lb7oPxDCWFOiZbHKwzhT0k8IzXgQZ5UtAp3OodfpBI9ipa1vbW9VwvmwvGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXfkXLfqRkS3neFy0V4oi5+q3MoMygyqDlaLV4YFSfyu55EEt
	u8zQ1ZNW3exzOAL4tl+GNH9lJb8kD/f19SnsznzXlgC6eSXXhzA1muFOj1jDVLMzkg==
X-Gm-Gg: ASbGncuQrHgdJjVfeMGhnBWDMrn6neqlQhknkzlK9SidFczPzg4y83LTs6/5SRGycjR
	yS0mSMTDjnUBHOHpv1gzHVB8nEm3yPlK3/Bkp4v9aw66PqHaA9Qg8eybIwFi9LgzV2GF+/C57NI
	HT4Hb2/PmNP76YnUpGoOoGAHh+O9kvoCGK/5OSocepeteI/l0rPUicqtiqqcmyNdWF0vMskXWfz
	cj+nmT1+inFJUsTC4G4Pe+tmnevXm5Q73WfvrA68fDbLWt2WdHjqjSwQMaXbQMqiFKcwyv95dZo
	U4uJHZy7SCYKzIjPAxlp+xTLMgUBhyRs3IRrllEM3xqbCSjDc9HXE89iKYKmQKfcAhjL3j1Xj7D
	3sGTrKPuHUDgtGN3uZ2ZU/J0LoKIuifVNveKXe8j0mlz8bNa82bB4yKS6VWo2BBGW0sCYjQZnb+
	v7BJDv8zBiT+gWyQ==
X-Google-Smtp-Source: AGHT+IGBZ1EWD4PIYFLvPV8xxJfPnPb/H3KLSOuO3XXH9AV7TfrQ42b2K1Lv37wXn0rhaPYprrXvjw==
X-Received: by 2002:a05:690c:6c0a:b0:71a:17fa:bf07 with SMTP id 00721157ae682-71fdc423f88mr12035667b3.40.1755830975699;
        Thu, 21 Aug 2025 19:49:35 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0a9a26sm48207697b3.55.2025.08.21.19.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 19:49:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 19:49:00 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baokun Li <libaokun1@huawei.com>
cc: Jeff Layton <jlayton@kernel.org>, libaokun@huaweicloud.com, 
    linux-mm@kvack.org, hughd@google.com, baolin.wang@linux.alibaba.com, 
    akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: preserve SB_I_VERSION on remount
In-Reply-To: <0a5c4b7deb443ac5f62d00b0bd0e1dd649bef8fe.camel@kernel.org>
Message-ID: <848440d1-72d9-e9ce-5da6-3e67490f0197@google.com>
References: <20250819061803.1496443-1-libaokun@huaweicloud.com> <0a5c4b7deb443ac5f62d00b0bd0e1dd649bef8fe.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Aug 2025, Jeff Layton wrote:
> On Tue, 2025-08-19 at 14:18 +0800, libaokun@huaweicloud.com wrote:
> > From: Baokun Li <libaokun1@huawei.com>
> > 
> > Now tmpfs enables i_version by default and tmpfs does not modify it. But
> > SB_I_VERSION can also be modified via sb_flags, and reconfigure_super()
> > always overwrites the existing flags with the latest ones. This means that
> > if tmpfs is remounted without specifying iversion, the default i_version
> > will be unexpectedly disabled.

Wow, what a surprise! Thank you so much for finding and fixing this.

> > 
> > To ensure iversion remains enabled, SB_I_VERSION is now always set for
> > fc->sb_flags in shmem_init_fs_context(), instead of for sb->s_flags in
> > shmem_fill_super().

I have to say that your patch looks to me like a hacky workaround. But 
after spending ages trying to work out how this came about, have concluded
that it's an artifact of "iversion" and/or "noiversion" being or having
been a mount option in some filesystems, with MS_I_VERSION in MS_RMT_MASK
getting propagated to sb_flags_mask, implying that the remounter is
changing the option when they have no such intention.  And any attempt
to fix this in a better way would be too likely to cause more trouble
than it's worth - unless other filesystems are also still surprised.

I had to worry, does the same weird disappearance-on-remount happen to
tmpfs's SB_POSIXACL too?  But it looks like not, because MS_POSIXACL is
not in MS_RMT_MASK - a relic of history why one in but not the other.

But I've added linux-fsdevel to the Ccs, mainly as a protest at this
unexpected interface (though no work for Christian to do: Andrew has
already taken the patch, thanks).

> > 
> > Fixes: 36f05cab0a2c ("tmpfs: add support for an i_version counter")
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ---
> >  mm/shmem.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index e2c76a30802b..eebe12ff5bc6 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -5081,7 +5081,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
> >  		sb->s_flags |= SB_NOUSER;
> >  	}
> >  	sb->s_export_op = &shmem_export_ops;
> > -	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
> > +	sb->s_flags |= SB_NOSEC;
> >  
> >  #if IS_ENABLED(CONFIG_UNICODE)
> >  	if (!ctx->encoding && ctx->strict_encoding) {
> > @@ -5385,6 +5385,9 @@ int shmem_init_fs_context(struct fs_context *fc)
> >  
> >  	fc->fs_private = ctx;
> >  	fc->ops = &shmem_fs_context_ops;
> > +#ifdef CONFIG_TMPFS

Ah, you're being very punctilious with that #ifdef: yes, the original
code happened not to set it in the #ifndef CONFIG_TMPFS case (when the
i_version would be invisible anyway).  But I bet that if we had done it
this way originally, we would have preferred not to clutter the source
with #ifdef and #else here.  Oh well, perhaps they will vanish in the
night sometime, it's a nit not worth you resending.

> > +	fc->sb_flags |= SB_I_VERSION;
> > +#endif
> >  	return 0;
> >  }
> >  
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Hugh Dickins <hughd@google.com>

