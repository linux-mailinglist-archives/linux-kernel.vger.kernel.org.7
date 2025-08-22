Return-Path: <linux-kernel+bounces-782582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7EB3225D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E3CB2164C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF02BF015;
	Fri, 22 Aug 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="bJT6xkOJ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68F19D07A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888173; cv=none; b=rs02Vxw0WEnp6Xq2tfhhN0jZ69yqJhU0r3wLcggcjHTp/TVvFFyoJAntLNq5R9QgH/yL+64JGXhGFBDx1TNEmoa3VWurLCppA1ETLRTuhHt9dfflX0VZn/J8e8CxGeYlX1JTr6elEVmJ+lDyLa8t98Pt7blmP4/mC20qrMPwWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888173; c=relaxed/simple;
	bh=HMDU6qnc6XToakMxvLwKRSmVgASNQEzig+IwPzLgNjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As9OP8eRlK40OUmFITJgaXzUJ8LVcpR7UUCySls1fkY7ZR2sNkt+lHjalsDQHosb574ZdQPqWLo1vQKaKSg3Nl8h4/QfS/ju1+sTaHYpkFVNyF8ZWX28Op1oDqJudrL8x4b4JgF3yXOMhg2NsUhY8XJFk7beG9a5AUnjK2yuQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=bJT6xkOJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b471740e488so2004314a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755888170; x=1756492970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRqezcJ9J5RPvnfO+uIE5EjJo7z/UAP8PQZlBAlk17k=;
        b=bJT6xkOJEjXFEdRV+M8HSmrKE/fXB2oHLgCgcd4NEc4LqV2+bYbPZ+8qERBydfXFuS
         foV8Ij3jM6CmFkm6HRVy3ZKMVehL3ifxH0flXVkeYrZ6De27I2iA61NoKwY7XIl1UhyV
         7knwdJnBheOxgSf8Lkw4R8jj31Gei94XUkwzAWHA/Uj6eNmaCRtLHR4bjkQZIPH5sl4O
         /c31c4HBTD/W9u7PoLRZmqPYVa4KZRadw2tN9hNVoy3pe/TU9ashTdyCWo9StNckOZ6x
         IlLwzAWyzdehA+GnvF8K9kuTW+stLhghVy/HV+GuYmDatgDzUUkRog3Mpody1YdJER+D
         wCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755888170; x=1756492970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqezcJ9J5RPvnfO+uIE5EjJo7z/UAP8PQZlBAlk17k=;
        b=EvVv2oHpT9j9nua83iMSCeMr8dsbtl7E3CIw8ks1AFSI5OssmFn9QGc7imXH3XNPbu
         KPcBODByGtYVIXneEn6K6Kqpt9nGdygz27+hChj87i+6Mw8ZHc4ItDYk0KeTqPjmcYtP
         +tbhOjdA9FqrodanrKhSmbe8Z4zvUfLmukKXpoF0h1wWQiolNDYMNmNNMIax12cMyCr7
         N16Qh3MgaXDi3tcKSN8NvdjEvAUbf82fzJeosmGGt28lPbbAWqj9uSC5vvI8hyiMmZbK
         hu1/NQpdRrvoPp9OMa+ZwQu0pCyD6WxUmOzM7SRnKL23BRx0+cn6VtiSq3vegfSGPZ9+
         jhWA==
X-Forwarded-Encrypted: i=1; AJvYcCUzGohk1hL+Bko+DELLpSi8tE4HLG/ksiyGdS/LGxrzQWnNJ+Miw/jfRh4eT4dDMy+rVNwxqOGC7PQVvtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5iFAYvZiTu/CiWS98r4xvk25saCUuHozqs6tfuNN3Cck6vOf
	FQsIOJLF7NdZVENl3E58KXibDeCp4ltZGsHYe2HzogqktBwAHpom6Yof+HViU+4W0us=
X-Gm-Gg: ASbGncsNZ2nJOckIC4xaxpVg6kXuVLWgEWCvYCjvOrGgsh+8fUdSW5+fTzm6TolQdRV
	sRzrBhS0U3JE96O6tUTMNMMp035xbnvcT1RUWBMEl40Xvr9s8ruinH2bgIyEr3bYnnW6nwl3mLi
	PeJSqE/D25Ln2K2YweXCxWp2EBFZApBRZ9BWPiGil1EMD+eWTYYTLUH6MmqUtQHNjg7ZM+8ITBC
	0PRxI4nY7QzId9M/Ty4ejBHt60MlwnMhb8XD6rHA27aa/vI2X7lYmoA4pK+aJHvvJ6cGg/n6zhc
	eArrxSx3v1gFf99hFqG4+nSbjBYHYWyR7kWI+BUIgA+nFG+KcWcwtbDLlcWoeRpwckfxgL612XE
	TywqmgZLdFc8f89MuSnKNwMJx
X-Google-Smtp-Source: AGHT+IHXhgusmCBljx9j0ynCx//dG3+DQIdpERkIhWbIeVVT8KWK7G8ICDAak5hLnXpQf+JKlRArKA==
X-Received: by 2002:a17:902:dad1:b0:242:befb:b04e with SMTP id d9443c01a7336-2462ee9cbfcmr55698485ad.25.1755888170055;
        Fri, 22 Aug 2025 11:42:50 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f3908fe3sm2553320a91.1.2025.08.22.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:42:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:42:47 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Sun YangKai <sunk67188@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	neelx@suse.com, quwenruo.btrfs@gmx.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKi6J2IkGOytAggj@mozart.vkv.me>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <2022221.PYKUYFuaPT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2022221.PYKUYFuaPT@saltykitkat>

On Friday 08/22 at 18:20 +0800, Sun YangKai wrote:
> > The compression level is meaningless for lzo, but before commit
> > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > it was silently ignored if passed.
> > 
> > After that commit, passing a level with lzo fails to mount:
> >     BTRFS error: unrecognized compression value lzo:1
> > 
> > Restore the old behavior, in case any users were relying on it.
> > 
> > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> > 
> >  fs/btrfs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index a262b494a89f..7ee35038c7fb 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > *ctx,> 
> >  		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >  		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >  		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > 
> > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > 
> >  		ctx->compress_type = BTRFS_COMPRESS_LZO;
> >  		ctx->compress_level = 0;
> >  		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > 
> > --
> > 2.47.2
> 
> A possible improvement would be to emit a warning in
> btrfs_match_compress_type() when @may_have_level is false but a
> level is still provided. And the warning message can be something like 
> "Providing a compression level for {compression_type} is not supported, the 
> level is ignored."
> 
> This way:
> 1. users receive a clearer hint about what happened,
> 2. existing setups relying on this behavior continue to work,
> 3. the @may_have_level semantics remain consistent.

Thanks Sun, sorry for not acknowledging your suggestion in my last
response. Repeating what I said there: if it helps get this in, I'm
happy to do it, but it sounds like Qu is pretty fundamentally opposed
to keeping the old behavior.

> 

