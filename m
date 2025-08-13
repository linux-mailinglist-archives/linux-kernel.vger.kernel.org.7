Return-Path: <linux-kernel+bounces-767694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B77B257C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB25B7B0FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E82F7443;
	Wed, 13 Aug 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="j3mQ5WKO"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912152FC88B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129003; cv=none; b=XHPYHhW5o/bxVuyCYFLOY9UO4Cz/QaOEPLzwRhW+bFErHvINqQNVX4h47oYV8rVy9rJaCFkLFsKCDXgDZaMs0IohkWWzNtYl27Ig8FXQFyzWuLlp7Mc14Ug1M+rE+DmHFHWNbzZWklo7vyWHd+Ql0BqoHlHTZBy6dL3i16qAjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129003; c=relaxed/simple;
	bh=u1zVyD7rzcExKdgOxK0dG1FH/LUnC/ES8o4VdVTMDko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q/pN1uUGhg8zUaGrh4kZB2PtLlIhmseNc5hXCpHZQTr0o929o7PNKL10/EW1nfWWs7jLP4Yn9DdCpdwmYrUYW/d9fgutD2liSbUff59ScnNPU3AtaIZ25n5WKlKiCbUxP+HeRsdzJL1Z0WTDiysWR2pg0hveKJeBY3GyZaZpOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=j3mQ5WKO; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0628A240027
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1755128994;
	bh=1YxUkmq6FN6LQgr3UahX2gKJFk0JaYwHgo29qh2xlSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=j3mQ5WKO7E/Acc1XukHwREm7u1Ch7fpm+qKAaIvPozKYc2nM3OcqjGZwJNGsfd1ek
	 yZQpcaTyt+zLqy0eK2iUwslSgbuL2xI6TBQZxVuUMEXnuWBT3xyRe4HjrTKpgpRRrq
	 TzZyUq6b4fgdZFDo0Q916HvdzDc/BReiHb7pgvH/gXXdHtXcBQ4pMaZTroqTaoDzIF
	 4WAWYm2MUxgCeLItj6dTN/c3H3KOxuIiSeDXTbs2xptXFRfKhNQH1rQ0+PUmwPT1W1
	 5XaFE3vvvQ9RZXL7sx2vuJ6l+C3W9xF9mS4u03oCD8dnr8e16igD/2evs+hevvdlSz
	 ePjhdeca/fHMizywNSdiguTM9HBOVxkb8psETCoWqmgl6vIFDc+EHwvSailo0mle3o
	 pUun66oWLE33+oOAWR6kByZQgNMmy5Y9zfefzzMohU83+rALIU4L0GdoBoh3KpmPse
	 C3RPaBYT1t22wOC5xi8e/BDAPrCXwGZX7Kk5Lw+6VLhBsCKBPVP
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c2Q8c17Wgz6tsf;
	Thu, 14 Aug 2025 01:49:52 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christian Brauner <brauner@kernel.org>,  Eric Sandeen
 <sandeen@redhat.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  Danilo Krummrich
 <dakr@kernel.org>,  David Howells <dhowells@redhat.com>,
  linux-kernel@vger.kernel.org,  linux-fsdevel
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] debugfs: fix mount options not being applied
In-Reply-To: <495848ab-2493-4701-b514-415377fe877b@sandeen.net>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
	<a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
	<d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
	<8734a53cpx.fsf@posteo.net>
	<cf97c467-6391-44df-8ce3-570f533623b8@sandeen.net>
	<20250808-aufrechnung-geizig-a99993c8e8f4@brauner>
	<495848ab-2493-4701-b514-415377fe877b@sandeen.net>
Date: Wed, 13 Aug 2025 23:49:53 +0000
Message-ID: <87plcyixy9.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@sandeen.net> writes:

> On 8/8/25 9:13 AM, Christian Brauner wrote:
>> On Wed, Aug 06, 2025 at 11:33:11AM -0500, Eric Sandeen wrote:
>>> On 8/5/25 12:22 PM, Charalampos Mitrodimas wrote:
>
> ...
>
>>>> Hi, thanks for the review, and yes you're right.
>>>>
>>>> Maybe a potential systemic fix would be to make get_tree_single() always
>>>> call fc->ops->reconfigure() after vfs_get_super() when reusing an
>>>> existing superblock, fixing all affected filesystems at once.
>>>
>>> Yep, I'm looking into that. mount_single used to do this, and IIRC we discussed
>>> it before but for some reason opted not to. It seems a bit trickier than I first
>>> expected, but I might just be dense. ;)
>> 
>> If we can make it work generically, we should. I too don't remember what
>> the reasons were for not doing it that way.
>
> Sorry for the long delay here. Talked to dhowells about this and his
> POV (which is convincing, I think) is that even though mount_single used to
> call do_remount_sb for an extant single sb, this was probably Bad(tm).
> Bad, IIUC, because it's not a given that options are safe to be changed
> in this way, and that policy really should be up to each individual
> filesystem.
>
> So while we still need to audit and fix any get_tree_single()
> filesystems that changed behavior with the new mount api, may as well
> fix up debugfs for now since the bug was reported.

What if we add a new flag (.fs_flags), say FS_SINGLE_RECONF, to
file_system_type that makes get_tree_single() automatically call
reconfigure() when reusing an existing superblock? Filesystems could
then just opt-in by adding it to .fs_flags.

>
> Charalampos - 
>
> Your patch oopses on boot for me - I think that when you added
>
> 	sb->s_fs_info = fc->s_fs_info;

Yes, did take notice of this yesterday when I revisited it.

>
> in debugfs_fill_super, you're actually NULLing out the one in the sb,
> because sget_fc has already transferred fc->s_fs_info to sb->s_fs_info,
> and NULLed fc->s_fs_info prior to this. Then when we get to
> _debugfs_apply_options, *fsi = sb->s_fs_info; is also NULL so using it
> there oopses.
>
> If you want to send a V2 with fixed up stable cc: I'd suggest following the
> pattern of what was done for tracefs in e4d32142d1de, which I think works
> OK and would at least lend some consistency, as the code is similar.
>
> If not, let me know and I'll work on an update.

As a matter of fact, I have a v2 exactly like this ready to sent. Doing
so in a bit.

>
> Thanks,
> -Eric 

Thanks!
C. Mitrodimas

