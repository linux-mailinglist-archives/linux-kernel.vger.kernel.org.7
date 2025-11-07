Return-Path: <linux-kernel+bounces-890441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D4C40102
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220A8188271F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BCE21FF3F;
	Fri,  7 Nov 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlHoPCu3"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A422D63F2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521304; cv=none; b=nu7KIPdr3Rw/O1qj6hI4qz04g07MArL11IrStWyeiQHEyIUSrJD17h6QjclwNsJqWML0bnSkMaEpReM6oNPyYID9Vsqk/FOw5zq/2chpGeC5U5So63peKYuXSvjxOSDPHJ/Shw4eyrovcV4UxrvCTPZSno+FYz2aw87X4RZbpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521304; c=relaxed/simple;
	bh=0mPhFFV27EI4HWkCT/K0CutZwM23pABS/zg6xhegD68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A43zyPv1xm5MedLLCC3ST8rpe9qWI8yQ1Ix5aNsQ/IRA4gSq4KrxNQDW+nO3o62yz9pV1mlSrhkx1yODx6onEYKZPFVUYbgi2np9fuubicMc0E1qIDy42MHd3w616Lg0C0IOxV0Q8XBnLvAy2cimB97Ms94Xe9xQZaUvMY1HbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlHoPCu3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7200568b13so132207066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521300; x=1763126100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=BlHoPCu3NqtLtozYF0ZyHTBdobJJ/cANVGnsDwuY6T8dx2F6BpG8CLWuG2V1KWCPn9
         rJqzhFhR33ZMV++LnBz96/RuLoQJElQKD/XgdMcwXWV7h9QKhE6GKnV5S15pYGxSNGqu
         KqaXf2ahPz1ifbkNBO7u8j2yiZH6M0K6PrgMzHi6k6ovXdGBxghrOCwCc/pEwIl/Eo01
         Pk2HH4fQOf3Bw6VYHGk0nxbI0DXzJSh5ufcLRQ9l6RwgF98tgxr22FjT0cjpknUAGNCF
         BA2TawykZDjdpivWUQQk7vyA0EjOpZxziWhEOwjmij06OkYHzpG2iI9J48haI79hsRab
         cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521300; x=1763126100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HZ8kO1EbOdno/Z6LWKvw9cCt6xKTq52Mcwxm+AjrMQ=;
        b=pSDx9q/t81ITYvDuc72ABG+QABgpZcSFy7fpvxgfzZs0zU5dcPoX+gOWQ+0sPL/F7z
         o3HJtUegE/qCeEOrsE6GliMHXtIH+poy82Z5JX9MHaRGeTAY5kti3wnIptzZ+EgPQiCS
         HU+SUeSnUcwY9+PleHSRECAOfyaImf37TMBRenZyynx3s1A1Vu43lK08QJO9eeDt04WJ
         fAlpImM1iHmPasDV6I4KjFM8swKtnAdvVocJ9YQ/zKnxeQI8RSQqw7N2FCUASIQEzHVO
         ctivWfO8Ocmrl/fjaij6AZewzyiqoOwNT0v6nBhSp/0exJ8zjYQuCV6sgtYyvGZrLPkh
         iTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV58gvs3T3pwQh9T94OBayyW9i/979XdDJV6+2ab8BhNYfzj40/BY1IhoAuGxc7bIKPsNa0k1gZFbq4e7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwIJdu/08GKygYznM8t6bDvzWWlGW0zgRLL9QK6eTLTWVxtUf
	TtNGv8Ch1rPWTIu8uifAEsL2TEL3b5XDxB0BtE3G8kOoJGXqjlkGOG2Ny/NOH9uHmgM=
X-Gm-Gg: ASbGncsbm+xg8OuVjGSJNP6n1CEtQDmKqyVl+/HaC1Iy6kLydfqbUL6EmijkZByfmPG
	WiPKbS4RyxGhbEMnYde2o4AeI5DC3QpX8BkIPJhE9e9UNb3DRIsPPHr12clOlgT5pUfShIvjgkd
	engaE4/GuzX8ohwDl1+BuiEDOEnQkB49OBA852DtRgnMP4fPNqo8lz+2QyQ0PW0n1D1anouCs2G
	VE28RpGQu+1VlO0+FjYldbNKUwt12S1PcT4+pSqDpU5D+tvcwVgmEEULD5A5w0WWUJ/csmamaI2
	SnnkHnXvgeTpsf+dYHi9JZDiOoU8Jk2/wkF7RPBcmXGIvBGYJ2UPUBL4qLpvIx5o3gF6PqdnhGu
	j0lClpR7TVNjEOnD4L/tIkRDlpN40ELuBt6+NnKC2vy71bSxH0cgNZLHy1vWu7LhEO3hOrnBn+0
	mUN5A=
X-Google-Smtp-Source: AGHT+IFE2eYy0+Px5WausE/jRL0XZhUzH9bbFk8nsiudCpX/vMQhbSO5rZNKcgvz0+P/IDwF6D5asw==
X-Received: by 2002:a17:907:2da2:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b72c090e4b7mr299535266b.34.1762521300369;
        Fri, 07 Nov 2025 05:15:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d1fsm233492666b.73.2025.11.07.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:14:59 -0800 (PST)
Date: Fri, 7 Nov 2025 14:14:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: bot+bpf-ci@kernel.org
Cc: petr.pavlu@suse.com, rostedt@goodmis.org, ast@kernel.org,
	akpm@linux-foundation.org, kees@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, mhiramat@kernel.org, mark.rutland@arm.com,
	mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/6] kallsyms: Cleanup code for appending the module
 buildid
Message-ID: <aQ3w0awU61mrS_AF@pathway.suse.cz>
References: <20251105142319.1139183-3-pmladek@suse.com>
 <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>

On Wed 2025-11-05 14:59:53, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 1e7635864..9455e3bb0 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
> >  	return lookup_module_symbol_name(addr, symname);
> >  }
> >
> > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > +
> > +static int append_buildid(char *buffer,  const char *modname,
> > +			  const unsigned char *buildid)
> > +{
> > +	if (!modname)
> > +		return 0;
> > +
> > +	if (!buildid) {
> > +		pr_warn_once("Undefined buildid for the module %s\n", modname);
> > +		return 0;
> > +	}
> 
> When ftrace_mod_address_lookup() succeeds in kallsyms_lookup_buildid(),
> it sets *modname but doesn't initialize *modbuildid. This leaves the
> buildid variable uninitialized when __sprint_symbol() calls
> append_buildid().

Just for record. This is a great analyze. This patchset is fixing
this bug in a later patch. ;-)

> Can the check above read uninitialized memory?> 
> Looking at kallsyms_lookup_buildid():
> - module_address_lookup() properly initializes both modname and
>   modbuildid
> - bpf_address_lookup() sets modname=NULL (so append_buildid isn't
>   called)
> - ftrace_mod_address_lookup() sets modname=mod_map->mod->name but has
>   no modbuildid parameter
> 
> The commit message mentions wanting to catch when lookup functions don't
> handle buildid, but shouldn't kallsyms_lookup_buildid() initialize
> *modbuildid=NULL before calling the lookup functions to avoid undefined
> behavior?

It seems that we are going this way, see
https://lore.kernel.org/all/aQ3vWIqG31BgE4YD@pathway.suse.cz/

Best Regards,
Petr

