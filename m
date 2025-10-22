Return-Path: <linux-kernel+bounces-864634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14FBFB3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8E4F3DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DE1E32A2;
	Wed, 22 Oct 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWBRH/+q"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED49298CDE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126841; cv=none; b=T0OpQDa0Sy4ZzdxoeD43qxBSbwD6WWiPKU+ifZoxUAqLA+VyoPYti8CyPR35cJgjyS4BhrHiI7uP9ApupVP38J15sDXfW+RQnfz8XJWinq5NRQUBrSyzsuiY3bDoomKua8WMpi8dgOyTeZtrelfsor6VU/laY/rKU1AuHP04x1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126841; c=relaxed/simple;
	bh=p6P4qcqDA3YLsBFfKyvteFlo1EPQ1YrLjGB+faTBjmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jklBSRFfk0hnGO717cwlhMvR+P2elKHeT885FkncWmkSg5j+6UllaoBOTC62OPwzTy4D5uOlrf8n0rXEcqnkuCCZ9ZL+vivXrrnRY9s2u+ZHobJQ6H8iZf6HqPcnK4rf6VYozABlz9GebZJILAr90yQ8D3a8NtmmTKIfsJqJ3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWBRH/+q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57bd7f0e2daso1131945e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761126836; x=1761731636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbt/O4Tu98SupoHCWRQkxaJ7zq2Tk+PByeJW8+2lzZw=;
        b=sWBRH/+qELlMFNMskkJao8UpNj9GtiHYk3iSuW9xXvpt1gjwdF3MApH6cX3HWnRGAd
         PijfJ4PVJMiTVc8f6kTOk1tH9vBNis2XpC2CFOIVDE3zfANbPAxdih5EriO5nz/49yoy
         H8C3y2ZjNwRpxURYyv0ik+ojP+BSgkk89bSfhQBSWQ4rP6i0TjETW/oMsxmPideTc05K
         DbiNOxQRaM0eSo3NgHUcjS3XS2kP/GI1YvFRdDkUwkQammn+mIGtLF8njUsgCTN1fo6z
         +2t6JTZS1HIcApaMEdLyAnEaRXhEwonLdDk5hWI/6w5L9fYP6FxKf0GFC5NeParoJEFo
         ODSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126836; x=1761731636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbt/O4Tu98SupoHCWRQkxaJ7zq2Tk+PByeJW8+2lzZw=;
        b=jeq5gUsbLVnclxL4GJozeI3i1REUoJ5cU24gfE1mHE75ULuJ9nSn825BmKwELBmLUN
         TERd3uLYAQnE5OuvLuvIYxSW2iitp0LvK6a+0vggo5UGFYqQWQLjHse1LgzYCftzqwQI
         o74BSjsYa9sHRvnndiakj2pIa5yH9pSt4HbNz6Yo+boKaYPtF+wr0f/XKeCBCTCqjXsO
         Klw1WceLSQ1cox8eBgpLZxTKTDpUG4p7UTZGh4B10JHIwrVcwj00Wbl90fQKi9TlApeq
         76gJ4N4jRrUL3pBnhElTuJuqg4shhHmUtkX13OXLxWhZbT4z3BiqwjsdV/Hg/xvDzNe2
         kZbA==
X-Forwarded-Encrypted: i=1; AJvYcCXN53YO670O294BJ3b5S4mbLeWi1Mf4IEQgRsHmFz7FcyySd3VWhoUZjESmiP5xemFj9jIeK3B5sdGj4cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwBpjgabEReSdrw/zSenGF+Jw7jqhVUwN4MsVYaoLdF811Rjn
	2Um3f95O0prFIKhEyi0aeJRkqF+66/tuHmu+JEf/f7G0veIjdpaograVsYyqN+y/Jck=
X-Gm-Gg: ASbGncvZo+2VYUZbVfql+lvj7o9zoqMpocS975CyLQeRTQdwnQ5WmnYnCXc8TB2oDBJ
	wE6r5B6IgTcZ3yz5Rjg0D32e2TmSAWbq9z0muAXsxxYwvycKaM8esIOzJVuWT3mrCOC966rUXN4
	tfz4txM85jfAJASVgv/zfLy6GA0Y5h+2/evBHKbDtIe+ciSR4P6sFLde/hyS/5h4wlgLC9yQUfv
	9Rn1diiY8/BzwYlUMTrEOIG2C6p+YnNaiOBAuKh81DzaW/iAbbkV1IqHich6y6g4oeuigfQLTaF
	SCaOV93La1fz4r8OCkpgoOlHl7jR7xYkXWGX+eVR40BW0SLn0VtxMTZxM0ggmIKqGEMchqYAnjy
	UpssVgzwjpbAU8QazeRlhtl4kRKJKdOagMlzmT7j4O6J+/5dZBkG3+Ivzur73UI0QQRTwpG9sj0
	ncAQ5wKQx8GA5SB78doxpxyO9Rxx6qog7S8ZWQCtsQ7TYQ
X-Google-Smtp-Source: AGHT+IHiSJK/QTZ2b4xHqPRM58bigb9XVQRBUletKW3JCiAXnSvp7jtl+E7uu6ozuEh3jkAPIKB1aw==
X-Received: by 2002:a05:6512:401b:b0:58a:ffcc:37b2 with SMTP id 2adb3069b0e04-591ea2cbdf8mr1181159e87.2.1761126836431;
        Wed, 22 Oct 2025 02:53:56 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591eaace758sm1808801e87.114.2025.10.22.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:53:55 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:53:54 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH v4 08/63] kbuild: Remove 'kmod_' prefix from
 __KBUILD_MODNAME
Message-ID: <aPipsiGv2OyZyIv7@monster>
References: <cover.1758067942.git.jpoimboe@kernel.org>
 <f382dddad4b7c8079ce3dd91e5eaea921b03af72.1758067942.git.jpoimboe@kernel.org>
 <5936475.DvuYhMxLoT@steina-w>
 <ycrgjcczkgt6morojzfpkjyg4ehrm5ova2hzzxy2dxv23hhyre@nf5bltmr4lxm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ycrgjcczkgt6morojzfpkjyg4ehrm5ova2hzzxy2dxv23hhyre@nf5bltmr4lxm>

On 2025-10-20 10:22, Josh Poimboeuf wrote:
> On Mon, Oct 20, 2025 at 02:20:35PM +0200, Alexander Stein wrote:
> > Hi,
> > 
> > Am Mittwoch, 17. September 2025, 18:03:16 CEST schrieb Josh Poimboeuf:
> > > In preparation for the objtool klp diff subcommand, remove the arbitrary
> > > 'kmod_' prefix from __KBUILD_MODNAME and instead add it explicitly in
> > > the __initcall_id() macro.
> > > 
> > > This change supports the standardization of "unique" symbol naming by
> > > ensuring the non-unique portion of the name comes before the unique
> > > part.  That will enable objtool to properly correlate symbols across
> > > builds.
> > > 
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > Starting with this commit 6717e8f91db71 ("kbuild: Remove 'kmod_' prefix
> > from __KBUILD_MODNAME") in next-20251020 I don't get any
> > module aliases anymore.
> > modinfo spi-fsl-dspi.ko returns:
> > > filename:       /work/repo/linux/build_arm64/drivers/spi/spi-fsl-dspi.ko
> > > alias:          platform:fsl-dspi
> > > license:        GPL
> > > description:    Freescale DSPI Controller Driver
> > > depends:        
> > > intree:         Y
> > > name:           spi_fsl_dspi
> > > vermagic:       6.18.0-rc1+ SMP preempt mod_unload modversions aarch64
> > 
> > but it should be like this:
> > > filename:       /work/repo/linux/build_arm64/drivers/spi/spi-fsl-dspi.ko
> > > alias:          platform:fsl-dspi
> > > license:        GPL
> > > description:    Freescale DSPI Controller Driver
> > > alias:          of:N*T*Cnxp,s32g2-dspiC*
> 
> Thanks, this patch broke the MODULE_DEVICE_TABLE() macro, as it no
> longer produces the format expected by scripts/mod/file2alias.c.
> 
> I didn't see this in x86 testing since it doesn't have device tree.
> 
> I will post the following fix shortly:

Tested-by: Anders Roxell <anders.roxell@linaro.org>

When can we expect it?

Cheers,
Anders

> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index e135cc79aceea..d80c3ea574726 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -251,10 +251,11 @@ struct module_kobject *lookup_or_create_module_kobject(const char *name);
>   */
>  #define __mod_device_table(type, name)	\
>  	__PASTE(__mod_device_table__,	\
> +	__PASTE(kmod_,			\
>  	__PASTE(__KBUILD_MODNAME,	\
>  	__PASTE(__,			\
>  	__PASTE(type,			\
> -	__PASTE(__, name)))))
> +	__PASTE(__, name))))))
>  
>  /* Creates an alias so file2alias.c can find device table. */
>  #define MODULE_DEVICE_TABLE(type, name)					\

