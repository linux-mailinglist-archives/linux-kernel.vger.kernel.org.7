Return-Path: <linux-kernel+bounces-782962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD69B327B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BD26014DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249112367AC;
	Sat, 23 Aug 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASfAgF9G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B70225A59
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938596; cv=none; b=AqYNxUjzdzr3dF8zrg/M4uSP9PFVjn4/dPR8aUHoFHYGe++fhRPaNU5gUV6rMdlKu1YuCQd/jc1sLzcLEzjAAVJ0KE1XiurK4hO6s4aKYHk+un0JTZeE/oGbuUPwvB4c9phdQXyB8Dk6oqLv2OfEnf21sBeoxGhKuVYw2kXZG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938596; c=relaxed/simple;
	bh=vwT0CoRft+GqrIkEeWlH5uEscBgnhyYA/SV4+qTNQXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWFnyQN/oLxRiGE9fDD60tzUwGjWupyk5UkXUUXS1whNrs2YH6OZ94mXofbBBvsPf0oAUtuSSRKAYZU5SpxZxQfYokIjOCeOuw0KYl3rQY9E4Hj018gH+FMY/tWA0GkK4tYaZsr+uihFdsWRDw6mS+LGkMlJP5XErzdGci+SwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASfAgF9G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755938589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfULO7YLxz7Z2uNy7z4zt/dNZhLkVeddOKxR2NJeRMc=;
	b=ASfAgF9G0Z/irCFVDXPk4R2nC/kPUGbEBzcLo75QpoFDI317TDikCwj31oPPz0t6e57u7R
	+X0Wq2GHVkNSg82VkFW91SkaTQI9EY5qQwACJ5WE7qNq2bgEF/4rOvbMcKFWNUWTSr7sZj
	dEEY0Yj7hrECBtDeT0NcMKBt7poj8uY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-35X5xQtUPlS_m85UqWZJPg-1; Sat, 23 Aug 2025 04:43:08 -0400
X-MC-Unique: 35X5xQtUPlS_m85UqWZJPg-1
X-Mimecast-MFC-AGG-ID: 35X5xQtUPlS_m85UqWZJPg_1755938587
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso12586265e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755938587; x=1756543387;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfULO7YLxz7Z2uNy7z4zt/dNZhLkVeddOKxR2NJeRMc=;
        b=cZT9ydGCgiqKVsiETwN1+5veMwF6tJxAN2+Zn9fRLT8bSj3m8cO8tIDFTU9X/Sq1DO
         K0OWcg2mrBjcibvi3om7HdAcl5O2nIxPMIfDCDDeujHBMh7jqRkQZ+udS2TDWlLfEW5J
         u2WlZMhPJiZZseqKn1cMaanr/87fzOCvuOr41sHOoVR/APO++SWxJovXL9xWe3LFPGKQ
         EXhawIBKPvGBdLpzRYUYokUwWJD2xu4ZochlJVsIhu/JL71334ObeyGZJaIdUU3WZUMR
         n9t3eEnd4IakpoNUk0RPlADg5D/XhkkiiJhZ+Q7RWq68edFl+z8btkd3363kgYhC+jGA
         Dy6A==
X-Forwarded-Encrypted: i=1; AJvYcCWkN00S/ZaC9yURUsk1QBdgChC/9LlypqOcTe6hh2W/tjEfExMLgZOhnJOYD2CBxX85xN6I05yWsh4Z8KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqyBME0mXUb9WUS/v+hSIBhiBjVJSaLfTXJkc4zPKi+fudxi2
	X9rr0lp0JVKhPz8fmRBHbRtkmfICxM7CkKJIJhoDI3SHMOgKwHR4QJDkTX1zn0cho3epX0oNUOB
	SR3g+Zq7IUdYMJB49t4buuyqWPdfso0Y0ovVUUOF4VSjsXCetOhrSbs723cl802Qqcw==
X-Gm-Gg: ASbGncuWEr/xqAiMlymPAhc7pe621FQp4Yt3mS/7x2DVQ0EyHRfhM4BZ6JgqKOJf61L
	r2U30ITCIjIFtTfSXV0Rdd0CgPtYM5vlCMpg8kdEMYXlpvTzBEArK6gaMI8Bw9rGCQPg92ChbZN
	i8gguNdD2CLQT697QCmofc+A1UvsoOtdpJSQbxpfCAy7Lgy3vdZAF/OFSOjqogVgKpXjj9FvByG
	FIN1EAR/LQBhkJHsMGArBwalCHxQbkDFgpm6oFqWdR/h8+ZHyIrccaVD+YfQ1x/2NKiLJz5TjLi
	JKyVTMqUUxc6KuuZe7e3dIRe2HpS9UnXGKLbYOWLSPFZYwDeZCI=
X-Received: by 2002:a05:600c:45ce:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45b517ad7ebmr46997445e9.13.1755938587181;
        Sat, 23 Aug 2025 01:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvj5I9ZXxDJGaFwa0dfJ5P6LVd376XfbNITRqgnxSw6PLCrBR5O0c8jn+3Z4dPfT9BVo3FDg==
X-Received: by 2002:a05:600c:45ce:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45b517ad7ebmr46997215e9.13.1755938586708;
        Sat, 23 Aug 2025 01:43:06 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9f8dsm2954620f8f.9.2025.08.23.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 01:43:06 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:43:04 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: wangzijie <wangzijie1@honor.com>
Cc: <adobriyan@gmail.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
 <brauner@kernel.org>, <kirill.shutemov@linux.intel.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <passt-dev@passt.top>, <rick.p.edgecombe@intel.com>,
 <viro@zeniv.linux.org.uk>, <jirislaby@kernel.org>, Lars Wendler
 <polynomial-c@gmx.de>
Subject: Re: [PATCH] proc: Bring back lseek() operations for /proc/net
 entries
Message-ID: <20250823104305.148e3a02@elisabeth>
In-Reply-To: <20250823015349.1650855-1-wangzijie1@honor.com>
References: <20250822172335.3187858-1-sbrivio@redhat.com>
	<20250823015349.1650855-1-wangzijie1@honor.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi wangzijie,

On Sat, 23 Aug 2025 09:53:49 +0800
wangzijie <wangzijie1@honor.com> wrote:

> > Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
> > as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
> > entries, as shown for instance by pasta(1), a user-mode network
> > implementation using those entries to scan for bound ports:
> > 
> >   $ strace -e openat,lseek -e s=none pasta -- true
> >   [...]
> >   openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
> >   openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
> >   lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
> >   openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
> >   lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   [...]
> > 
> > That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
> > and it's now mandatory for lseek(). In fact, flags aren't set at all
> > for those entries because pde_set_flags() isn't called for them.
> > 
> > As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
> > files") introduced flags for procfs directory entries, along with the
> > pde_set_flags() helper, they weren't relevant for /proc/net entries,
> > so the lack of pde_set_flags() calls in proc_create_net_*() functions
> > was harmless.
> > 
> > Now that the calls are strictly needed for lseek() functionality,
> > add them.
> > 
> > Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> > Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> > ---
> >  fs/proc/generic.c  | 2 +-
> >  fs/proc/internal.h | 1 +
> >  fs/proc/proc_net.c | 4 ++++
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> > index 76e800e38c8f..57ec5e385d1b 100644
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -561,7 +561,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
> >  	return p;
> >  }
> >  
> > -static void pde_set_flags(struct proc_dir_entry *pde)
> > +void pde_set_flags(struct proc_dir_entry *pde)
> >  {
> >  	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
> >  		pde->flags |= PROC_ENTRY_PERMANENT;
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index e737401d7383..a358974f14d2 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -284,6 +284,7 @@ extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int)
> >  struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
> >  extern int proc_readdir(struct file *, struct dir_context *);
> >  int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> > +void pde_set_flags(struct proc_dir_entry *pde);
> >  
> >  static inline void pde_get(struct proc_dir_entry *pde)
> >  {
> > diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> > index 52f0b75cbce2..20bc7481b02c 100644
> > --- a/fs/proc/proc_net.c
> > +++ b/fs/proc/proc_net.c
> > @@ -124,6 +124,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
> >  	p->proc_ops = &proc_net_seq_ops;
> >  	p->seq_ops = ops;
> >  	p->state_size = state_size;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_data);
> > @@ -170,6 +171,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
> >  	p->seq_ops = ops;
> >  	p->state_size = state_size;
> >  	p->write = write;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_data_write);
> > @@ -217,6 +219,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
> >  	pde_force_lookup(p);
> >  	p->proc_ops = &proc_net_single_ops;
> >  	p->single_show = show;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_single);
> > @@ -261,6 +264,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
> >  	p->proc_ops = &proc_net_single_ops;
> >  	p->single_show = show;
> >  	p->write = write;
> > +	pde_set_flags(p);
> >  	return proc_register(parent, p);
> >  }
> >  EXPORT_SYMBOL_GPL(proc_create_net_single_write);
> > -- 
> > 2.43.0  
> 
> Hi Stefano,
> Thanks for your patch, Lars reported this bug last week:
> https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/

Apologies, I didn't see that. It's definitely the same issue.

> Jiri suggested to make pde_set_flags() part of proc_register(). I think it can help
> to avoid lack of pde_set_flags() calls in the future and make code clean.

Right, I was pondering to try something like that, but I just wanted to
submit a minimal fix for the moment being.

In any case, you have it ready, and it's obviously cleaner than my
solution, so, of course, let's discard my patch.

> I have submitted a patch:
> https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com

I just tested it, it works for me. Thanks for fixing that!

-- 
Stefano


