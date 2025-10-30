Return-Path: <linux-kernel+bounces-878499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7C4C20D04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9933B86D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816AA2DECD3;
	Thu, 30 Oct 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DHaDAYn3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C22DEA74
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836607; cv=none; b=BRRh9NcPTzmCq3cLGKtXlHzFUAZlPYYDKtfv9zRUALbgOEZ0euLawyZ6AyFYnSQ6rNljmnCBmNKEwbj794yjOvUstbB4BLdo/KVBu57vu1aJT6kLEpsT7oY31TGzN58c2Xn3HLCrPbcGd/KEOD4cwLpVU+iqWPH4eQRagTJholE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836607; c=relaxed/simple;
	bh=qN5+ruluEslMYfwABwsiAzDZ654++DBH5v/82CjNTgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce9C3pnGdm0gcUESqnzSveUTGy2YypIWElvrLEGmzjMrOQPMYwpCuUg1FXNUkC8GqlpVKAuge0M6UgrwyR+EJ5/E3qLbY0+1u/3MsolYIbSiNjIE0N8ca2bT6n2FoSs6b13oV9LEgzJcG1aZx3QjOSyZH081ieUPtcok9hvlwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DHaDAYn3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47114a40161so13067495e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761836600; x=1762441400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rX4ZWwZjbz+sCqsuSVmEQevsucF/zOMrkQ0dHaaJmk=;
        b=DHaDAYn3DWCVM8fJRHjdZOFiFfAWIaU57nlbXKP0mAYa8gb1uL42QJj/iGALaORrKI
         ZVGa2CL4Zto32vs/ou9EwZRKin2e2UQscrNsXXF8ZhXW7lV4rXll8N7Ar4g+cCA9GKq+
         5VH+b5s/R7NAXW3wjPiihH3GU6Tm91Vmwidkh+jvErKlEw9kCDSzb77KSlvXHd3mRVW6
         YmqPb90EnScH3VWfwPcZUt2WWCasvovEq3MZIQauXuEIbHcOcTkG7SbDmDdi6MbXDVRs
         PWjPCWYBGtv3+PH4kd/FnmntuzSlHAON3Nmx7Zdt4PPFptIBgFpAaa25nNipuTLlsjIQ
         cGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836600; x=1762441400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rX4ZWwZjbz+sCqsuSVmEQevsucF/zOMrkQ0dHaaJmk=;
        b=cvboPPfKyFNMW7KQus+O9ybKohPlLEtMMupB/OR6asCVLDJ6pHu8OS5tgPLmoPSRHu
         t+07iZu+8iuZq7SpL8xSOf8Ga4lrF670SJRqCBP/g0zOYuE6drvuMpN57b9NoXrVW3j2
         idqjr3CA4pCvrwD/kwtyWcJFbkadC2eN4FUho+F0FuKj5+lZ5H1ybBnw+QOEGgk+A86o
         FYJtZwzcD7gMxZ/AmQbxBBdoEtc57iU8OZlMwKb2MF9facV3Zir29dJSK31MmO9J9hXE
         9S0PKanbLQxMySTT9SDmMSqngWKRAhTWDYcg+M+3Rq9OsCVmIQlkeU2JiRMD6KEQsunC
         iv6A==
X-Forwarded-Encrypted: i=1; AJvYcCWiOOSlc3iX8PBLrxHfUpksGqlNDJB+gMkqdf/A0Zo8C/yTG40LYwPvEX2+zcxJSRd4Ou53kjSccCxjFao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycjlhasao6KSPgz8sGWjcxVgGth17GQ4dnNXYjggzj/X1lDqsR
	eadFoCTTXc3It5HTqwlOAwWWzGe08tNnBIiTzq5j+5tPUDQQd4piXg2Nz2if9F8MAZo=
X-Gm-Gg: ASbGncvJdcvzqE6oLHuGdO2+j8l7KL0r5V74puD6nLm11iIzaQ4B2zPF5frtou/jhE7
	690py93oKaNMms2KnPYJvUFr2fDarkCHeCpH5BQQkURtEVrGBQbIOTvmYMN0GaWh97X+QdSftFm
	v9lTZMysBca6PV4nB3CxaY1ebAZInmixaeif1uf2f4z3kESqIdi/ldKHtckTr4olDszzTC3zw0n
	fZEl+d68jjIUZvl5YvgqrEljx1nT7Vq+uc74yW38uYnJYz139uv4AKyX8yrBmqBzOvhk/ti0k+u
	QOY++RW9l116RJ7iTCNo00xHP6DPLZfSVvxKoQ7XrIBw/wyz7Hu1izSxskMb6P/XZvU/SEi0pLU
	Acp14KWwXia9vIbfvzk7H8pLgh7BKK55PIE+Ll0ErKAbk6uuGJeLVjl7sxJ5xAqEMEK+F3g9C8k
	25JC35FsLusj1hZQ==
X-Google-Smtp-Source: AGHT+IHRHARDP80Knjii2eWVpygOVlNOatxN4qzGZJUhKYH3F/xYgYHJcAY0BQHLLPdeMNoxhT8tWg==
X-Received: by 2002:a05:600c:3149:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-4773089c4a1mr102625e9.22.1761836600017;
        Thu, 30 Oct 2025 08:03:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289b3956sm44133905e9.10.2025.10.30.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:03:19 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:03:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <aQN-NeWzlxtWDLXF@pathway.suse.cz>
References: <20251027161212.334219-1-john.ogness@linutronix.de>
 <20251027161212.334219-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027161212.334219-2-john.ogness@linutronix.de>

On Mon 2025-10-27 17:18:03, John Ogness wrote:
> There may be console drivers that have not yet figured out a way
> to implement safe atomic printing (->write_atomic() callback).
> These drivers could choose to only implement threaded printing
> (->write_thread() callback), but then it is guaranteed that _no_
> output will be printed during panic. Not even attempted.
> 
> As a result, developers may be tempted to implement unsafe
> ->write_atomic() callbacks and/or implement some sort of custom
> deferred printing trickery to try to make it work. This goes
> against the principle intention of the nbcon API as well as
> endangers other nbcon drivers that are doing things correctly
> (safely).
> 
> As a compromise, allow nbcon drivers to implement unsafe
> ->write_atomic() callbacks by providing a new console flag
> CON_NBCON_ATOMIC_UNSAFE. When specified, the ->write_atomic()
> callback for that console will _only_ be called during the
> final "hope and pray" flush attempt at the end of a panic:
> nbcon_atomic_flush_unsafe().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Link: https://lore.kernel.org/lkml/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt

The patch looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, it needs one more hunk to fix build with the patchset
adding support for nbcon into kdb which is
in https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/

It would fix the compilation problem reported by the robot:

--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1935,5 +1935,5 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
 	 * The console was locked only when the write_atomic() callback
 	 * was usable.
 	 */
-	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);
+	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
 }



Also there is one trivial conflict with the new branch which is
preventing hardlockups in atomic flush which is
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=rework/atomic-flush-hardlockup

Namely, it is the last patch which moves nbcon_context_try_acquire()
into to while cycle, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=rework/atomic-flush-hardlockup&id=d5d399efff65773ed82ddaf6c11a0fcfdb5eb029

Commit:

I am not sure how to move forward. IMHO, the original plan was to push
this patch together with the other netconsole-related changes. In this
case, the conflicts will need to be solved when merging pull requests
from netconsole and printk trees. Well, the conflicts are trivial.

Or I could push this patch via the printk tree and queue it for 6.19.
But this might be too late for netconsole.

It primary depends whether the netconsole side might be ready for 6.19
or if it could wait for 6.20.

Best Regards,
Petr

