Return-Path: <linux-kernel+bounces-820028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775AB7CDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE7F2A4DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AC26F29F;
	Wed, 17 Sep 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hi5asorW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EqiZa9ds"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3A261B6E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089579; cv=none; b=bUfvamNruRf5RXNana8ZHbkCkvS4R7bb32VSGXimhRzD67rqa9+v3egsgiNRS3GZ7/w1V+lF2IXUL9PnsI6IBcwvitvVBpZ6PNFbMK8b6JuEB4l8qsENfw8HaKTD8c90UKKo41gOa2I/F774KXWHR7IdkJe+MVJGn9m8tyaHILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089579; c=relaxed/simple;
	bh=0tJPVcrI7KoGqjTvAF2DQfG6YvxEMkSmvLIfx3jxBHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du1qBr59oN7uO8+J7ZWDi81rlLTeS2AcPLjkjE9Gqlf0YLofV8HTmc2SOhXFVTfnnzxLQvgVEOm5UdWdHpNpiRMVPyOQ61ha6pgqufCqVLVqn2HkJXNCyWA83RM7NeqhWaUjOziTMgIzq32CXHqJa1LCTnJ6kDpwxh4/pjJ5Rrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hi5asorW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EqiZa9ds; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 08:12:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm3XQGuNpzvU7WALjJ302177aZpCGUI+/SYqtjhnqvQ=;
	b=hi5asorW0MRa0dJUiGIVlulXm0HVRXsGvMegW2ksiku98PwZ+5SQkpK4EhEFxBA30Ticru
	VoWEaVThVfaWZ05ur8DwYDgb0zguVvgVCv+x3ZOiQ1M15ekXNcHozqZAtYyonBnPO1gVbx
	/vBak0GAB7lM29zCO5kjNdbtcs/FN3wmHd1QxjhyQcxtXYC8cRMz1kCWUDtD9vff7htuIf
	iF+Mp/E495zzQv5T+TyHWkchwI/Xs57SFU1m6WFhmymBtB44pPH+cgfmY5HRQQKNdY4CB8
	LyXh9vQPpdxhhXE5EU/jP9MLwBNHLigHwSbiGjhL4Ed6vIajEldeL2YFtyOfbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm3XQGuNpzvU7WALjJ302177aZpCGUI+/SYqtjhnqvQ=;
	b=EqiZa9dslwzNdZAl+jHOf2eAEfjiihQFIsrRguyTUV0X3CkAj+r5Y2yP6H1pD1ri4GoF6I
	GPxPX0wkIIfFf5DQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: forward declare struct rcuwait together with
 rcuwait_wake_up()
Message-ID: <20250917080725-14901c66-b02d-4d81-8a42-1283333d3966@linutronix.de>
References: <20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de>
 <CAJuCfpE-DPBp-0b0908FHvguSo_PqxE2LdUXvBiMLu1UCd5icQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE-DPBp-0b0908FHvguSo_PqxE2LdUXvBiMLu1UCd5icQ@mail.gmail.com>

On Tue, Sep 16, 2025 at 03:04:21PM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 16, 2025 at 6:59 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > At the point of the forward declaration of rcuwait_wake_up()
> > in mmap_lock.h 'struct rcuwait' may have not yet been declared,
> > leading to compiler errors.
> >
> > Add an explicit forward declaration for the struct.
> >
> > Fixes: 75404e07663b ("mm: move mmap/vma locking logic into specific files")
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> > This doesn't seem to break any in-tree code right now.
> > I stumbled upon it while building a series for the next cycle.
> > Instead of putting this fix into my series and spamming all the mm
> > maintainers with it, maybe this could be part of the last mm bugfix pull
> > for this cycle.
> 
> `struct rcuwait` is defined inside include/linux/types.h and
> mmap_lock.h includes that file.

Yes, linux/types.h is included, but only after the usage of 'struct rcuwait'.
We could also order around the '#include <linux/types.h>' before the
declaration of rcuwait_wake_up(), but to me my current proposal looks cleaner.

> Could you please explain in more
> detail what exactly failed when you were building it?

With the following change for test purposes:

diff --git a/init/main.c b/init/main.c
index 0d4510a7a5c2..7523786e6ad1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -10,6 +10,8 @@
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org>
  */
 
+#include <linux/mmap_lock.h>
+
 #define DEBUG          /* Enable initcall_debug */
 
 #include <linux/types.h>


This is the error:

In file included from .../init/main.c:13:
.../include/linux/mmap_lock.h:6:35: error: 'struct rcuwait' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    6 | extern int rcuwait_wake_up(struct rcuwait *w);
      |                                   ^~~~~~~
In file included from .../include/linux/percpu-rwsem.h:7,
                 from .../include/linux/fs.h:34,
                 from .../include/linux/proc_fs.h:10,
                 from .../init/main.c:21:
.../include/linux/rcuwait.h:26:12: error: conflicting types for 'rcuwait_wake_up'; have 'int(struct rcuwait *)'
   26 | extern int rcuwait_wake_up(struct rcuwait *w);
      |            ^~~~~~~~~~~~~~~
.../include/linux/mmap_lock.h:6:12: note: previous declaration of 'rcuwait_wake_up' with type 'int(struct rcuwait *)'
    6 | extern int rcuwait_wake_up(struct rcuwait *w);
      |            ^~~~~~~~~~~~~~~

> > ---
> >  include/linux/mmap_lock.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 11a078de9150df1beff4f0bfb16e199333767614..9792dd4fff0ff73829833aae8ea3229a31757d61 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -3,6 +3,7 @@
> >  #define _LINUX_MMAP_LOCK_H
> >
> >  /* Avoid a dependency loop by declaring here. */
> > +struct rcuwait;
> >  extern int rcuwait_wake_up(struct rcuwait *w);
> >
> >  #include <linux/lockdep.h>
> >
> > ---
> > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > change-id: 20250916-mm-rcuwait-03c5fe95f36d
> >
> > Best regards,
> > --
> > Thomas Weißschuh <thomas.weissschuh@linutronix.de>

