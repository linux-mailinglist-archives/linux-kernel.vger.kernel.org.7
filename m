Return-Path: <linux-kernel+bounces-826194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C80B8DCDA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0D51898EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142212D8DD9;
	Sun, 21 Sep 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpsoZ3cl"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D386342
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758464585; cv=none; b=snl7N+mwYI5BHAAQXDU6W0LuUS2NwabL2JN2XoHPrSmAlItAxlNaQfNHFLrk6LHh/x0lRjeF7FLAwr9BO0UDiNqIBmqx4YtTt7xdDuKZBJEGQ9gzkH7D8lO3UZkUhhiYWzOhjvWqVL0g6Vkw+PdMHXlQmbEZw/dKa7PtcwAqbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758464585; c=relaxed/simple;
	bh=9b6F9D5jje7y6/LmiCOtXxc4p3d9Me4XqnbPLCr+gOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VixiZxAKIgHHGqRXzIZCExKUbZk+OxO1GkFj2JduviDxyjto0OHNZnQxmrUlD6PCXdBlZjD2B04aXuzeQZ8oemXflWf+AgcJTfGAw42DZGylg99GAXA+NLZgj+98JisjsLSTXQHvlRPpUtIb605KWY7EsVD9F1BVYSCblzKGPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpsoZ3cl; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78e4056623fso33877436d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758464583; x=1759069383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2S8h80iAduu97mKh30jmuV711hoxhswsxtFwAuztlE=;
        b=fpsoZ3clVtE2VQnpVEcmrsjhQC/esdC0eyAEaXq2CPXEEFHWzwWCKy8o2ejVwEaSbr
         kumsFkzbFifzjqxxexFN02i0ngHoXu9qWFPQYhYU6YnhqWwkRA2JYqMtWYA1PRKKR3oy
         kch7Zo1D6w9FTBNN4rvGL7fRcP0v4dLbs+YewSnr+tlV7mxyIZXCMYi+/mEd5x7b/G8/
         vKBcWFy4ysrIatIgzDH5kCRl7+l4YcJu7A5ouPZAWZL9HIN6hLIitG/qSbhkdeSUsVvi
         0bwxSuBiIUPLYz8z/oNB3HcigTh9fu2W0flhTp3XPlo3YqqoxryswoaI6QItcpLsGTOS
         /Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758464583; x=1759069383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2S8h80iAduu97mKh30jmuV711hoxhswsxtFwAuztlE=;
        b=iEt5cRh/zGoK4QYhU69LmZhe1Y8apjNrtLMv2yQBjOHFN7WwZv6wUlUc7McFfokp3C
         7Rn4Oochid7UzYD/FG/JTNjeWD5dJ+QEmiDrdyQpr+se5c+G/gUpxRMe0L1YU6l/vPcu
         7/ZzugZOyToCmvkEs2kFhA1IVhi94X6M+tUOlcagVGn7vCE/PWlvWUi0kmSUqQu4CrdL
         ge3YtnrNIR5bNBcjZinK8NTMykMuJ+RMwGZcFy+iEuxqObtxqF1vgswrqQMcdOaVinlC
         EGHzKSwiXTfzUkd9EucP6Jzj9dmMWdYDZZ8zdUuLWAUJ4JBwXHmymZJdHPtIDNowbHBn
         2YUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwBfD1DtyAABj0LzSg71z7cSKG2P7VZlK06TXOv3TLE85w7lhXwGUqYdrndSII1X/iZmOLdusYNP56INo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWtpmRF0XF0Ten8/GHZN8bjsaygf7LpGo1MmfBfDvLrN9vC+k
	lY/VopZrM+JF0kserlmCwmhn9Y6JGuYIuERlW1u9O/Td7FWpA8fA7oU9
X-Gm-Gg: ASbGncvUVJidoqTGnPmtyV/2VS7LEVRhL8EruOSw6WmEhjhDXiMpmZ8pNmzd9EzE+Fh
	/nq4ygKFFkg7/gleKV7aq9FW4m8DohOuIrKxa3ho3VWWu3A0toF9Y0E766pWrTUTI32qXQ1gldn
	isxvDURFsbZAsCH9t1oP8J3W/TzANmaF3eOZDu0kIquPX7eUQM+RQaIqlg44xUn9ht6ufNTQwj9
	UisW1pEim2bou6y/bUjY8GBlp00X1gOGKaY2fb/RWHSX05M+PDgHTVdtX9dVNVrOSZMF2Ec7G2V
	H26YmFJHxkRTValLSX4HQ9c2vIZ01UU1j0j7e4Y7W11HF0v09MD+sramS4MRwDjB489WGOSWZ5N
	80TcqWowiuEeUBCT8t3W8LxfKftF0TZ5Ev3hVgyHf3yeK
X-Google-Smtp-Source: AGHT+IFqbWz5JMCQf7zPfQ4YD0JBq9Wwm4X91v0TnqKyBZ1Ok3eymp4E7AQdn1kaqPdypC5ry9p0dA==
X-Received: by 2002:ad4:5de1:0:b0:78e:7f26:686b with SMTP id 6a1803df08f44-799137e264bmr109415806d6.21.1758464582548;
        Sun, 21 Sep 2025 07:23:02 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:eae0:9bbb:1dde:89c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793548c7c21sm58119896d6.59.2025.09.21.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 07:23:02 -0700 (PDT)
Date: Sun, 21 Sep 2025 23:23:00 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] {do_,}lock_mount() behaviour wrt races and move_mount(2)
 with empty to_path (was Re: [PATCH] fs/namespace.c: fix mountpath handling
 in do_lock_mount())
Message-ID: <aNAKRIcAirFMXWmO@gmail.com>
References: <20250818172235.178899-1-seokwoo.chung130@gmail.com>
 <20250818201428.GC222315@ZenIV>
 <20250818205606.GD222315@ZenIV>
 <20250819-qualifizieren-draht-f209a541ac6c@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-qualifizieren-draht-f209a541ac6c@brauner>

On Tue, Aug 19, 2025 at 11:40:14AM +0200, Christian Brauner wrote:
> On Mon, Aug 18, 2025 at 09:56:06PM +0100, Al Viro wrote:
> > On Mon, Aug 18, 2025 at 09:14:28PM +0100, Al Viro wrote:
> > 
> > > Alternative would be to treat these races as "act as if we'd won and
> > > the other guy had overmounted ours", i.e. *NOT* follow mounts.  Again,
> > > for old syscalls that's fine - if another thread has raced with us and
> > > mounted something on top of the place we want to mount on, it could just
> > > as easily have come *after* we'd completed mount(2) and mounted their
> > > stuff on top of ours.  If userland is not fine with such outcome, it needs
> > > to provide serialization between the callers.  For move_mount(2)... again,
> > > the only real question is empty to_path case.
> > > 
> > > Comments?
> > 
> > Thinking about it a bit more...  Unfortunately, there's another corner
> > case: "." as mountpoint.  That would affect that old syscalls as well
> > and I'm not sure that there's no userland code that relies upon the
> > current behaviour.
> > 
> > Background: pathname resolution does *NOT* follow mounts on the starting
> > point and it does not follow mounts after "."
> > 
> > ; mkdir /tmp/foo
> > ; mount -t tmpfs none /tmp/foo
> > ; cd /tmp/foo
> > ; echo under > a
> > ; cat /tmp/foo/a
> > under
> > ; mount -t tmpfs none /tmp/foo
> > ; cat a
> > under
> > ; cat /tmp/foo/a
> > cat: /tmp/foo/a: no such file or directory
> > ; echo under > b
> > ; cat b
> > under
> > ; cat /tmp/foo/b
> > cat: /tmp/foo/b: no such file or directory
> > ;
> > 
> > It's been a bad decision (if it can be called that - it's been more
> > of an accident, AFAICT), but it's decades too late to change it.
> > And interaction with mount is also fun: mount(2) *DOES* follow mounts
> > on the end of any pathname, no matter what.  So in case when we are
> > standing in an overmounted directory, ls . will show the contents of
> > that directory, but mount <something> . will mount on top of whatever's
> > mounted there.
> > 
> > So the alternative I've mentioned above would change the behaviour of
> > old syscalls in a corner case that just might be actually used in userland
> > code - including the scripts run at the boot time, of all things ;-/
> > 
> > IOW, it probably falls under "can't touch that, no matter how much we'd
> > like to" ;-/  Pity, that...
> > 
> > That leaves the question of MOVE_MOUNT_BENEATH with empty pathname -
> > do we want a variant that would say "slide precisely under the opened
> > directory I gave you, no matter what might overmount it"?
> 
> Afaict, right now MOVE_MOUNT_BENEATH will take the overmount into
> account even for "." just like mount(2) will lookup the topmost mount no
> matter what. That is what userspace expects. I don't think we need a
> variant where "." ignores overmounts for MOVE_MOUNT_BENEATH and really
> not unless someone has a specific use-case for it. If it comes to that
> we should probably add a new flag.
> 
> > 
> > At the very least this corner case needs to be documented in move_mount(2)
> > - behaviour of
> > 	move_mount(_, _, dir_fd, "",
> > 		   MOVE_MOUNT_T_EMPTY | MOVE_MOUNT_BENEATH)
> > has two apriori reasonable variants ("slide right under the top of
> > whatever pile there might be over dir_fd" and "slide right under dir_fd
> 
> Yes, that's what's intended and documented also what I wrote in my
> commit messages and what the selftests should test for. I specifically
> did not make it deviate from standard mount(2) behavior.
> 
> > itself, no matter what pile might be on top of that") and leaving it
> > unspecified is not good, IMO...
> 
> Sure, Aleksa can pull that into his documentation patches.

Hello all,

I am writing to follow up on this RFC patch. The last discussion was a
month ago and it seems like the conversation has stalled.

Thank you.

Best regards,
Ryan Chung

