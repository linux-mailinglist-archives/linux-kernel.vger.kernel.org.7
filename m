Return-Path: <linux-kernel+bounces-830678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC7B9A489
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB934E0462
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE842309F0D;
	Wed, 24 Sep 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL7VXdKB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AE308F13
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724629; cv=none; b=PwgCobkMaBJ/z3t8LBRMY+5LZtoHSlKlsknu80drwsevX7yLKM2x5Wc770sTpyFQhDHViaO4a5PzfvmKv6zecuS8AkUsh3M063NHzHJz1p428UxJytFiJ7JdN3gZfK6UNVCvvns2P6trukKx6pWqHk8CLhY11j7STWplLWPMFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724629; c=relaxed/simple;
	bh=sIBMYcw18+Ht8eXVyZ8dR0xLQoQqWvukpqCuFy0av6A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFRUec/z/F8SGZYYdBlhDB5YBpG3muC6iokpQ87AcmI2VsBfvmSVoibYnO32m7r/7475PlZlAiABRnFKMniFkYRPrGAQNb/z3HDYDA304j0Sl0Skm1Jw7GtJvZVc9eXP5f+N0lcmAlCdD38L4zIsFi5WqY6GUjh5GmF8jV8FzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL7VXdKB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ece1102998so4396503f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724626; x=1759329426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5HShbJ4pb0uvOuUwE85U36B7c1llkadxegnV9SHJtyg=;
        b=XL7VXdKB3JM/deiApRhDlMQkiHB3F+D7w6mocXHXJiUGYZnVQ0rZTVfA+oM1vT+O5s
         r8Ih0w7Mgqmieo7PAZGGcFX2pyHQgR1iSYN+hpI7HjRAhv/bQ49BJFHVnIU/u+KgkK06
         5+a/iAnEmeb/+1wCzXYYyqrkyQ3XIwvn+3uH7NqhIZH9HNGzG+DVMvle4dk+N8sxhy1x
         n/JFrYrqDMLpafKLwjTRBU1guVTcXqv8jVkz9E2LUGAHmlWj2MKkOh9q2k+BWBq3HYKh
         Tax8e5bxHbk2PN2u/zoRIJGFKHRKB1yPpt8F7etb+VlBjr8LIClh5xyphPnLsSdwrIqM
         X9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724626; x=1759329426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HShbJ4pb0uvOuUwE85U36B7c1llkadxegnV9SHJtyg=;
        b=VQfaaCFSV6HZwmzxRo7O6T/gibIBo7L1xM+sgCEhAB1jnGKEVhdD9vFSX1rDjlkubb
         J7TUHX2CW21XO6sxa6+pyMxOYB1gaVLJRqdR6w+eGXdR66gMoYorhTrixQ5isnPHe8Op
         Q8/ZKdVQZpwW5S4fYQPO8Gl+XMgiE07oKAbc6Z47XWWZn3p1KmbIUqxIagTrTGUuYMR3
         3CotpF96SHRrMcHH+hCartCOu/rFQa6CwdSYSO84vizulw/AkhGuKoA8+2Uj5jd0pCp0
         p8VRCDrllTDOyZM1Xeasz09F6+3QYRqoTy0FsPOM/khmv9vngiZPfdwjK/E5peOwNpfI
         GkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7LURxq1o07XjBnib7lg8Ps+db8Lo4ebet8HUwrLLjBnNeacwLSGMEcw1TJZxiG+4rIKJF/elQy+YdXYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlHlHs9nWUggq5LQ6vE+c8VoaiTqItmadzFmmKDqnA9E/jc19
	W6XCIBBn/SRFhhEPvDE30IAzhsyXIl39KZPRKNDWySdjduXTwb6lZOtY
X-Gm-Gg: ASbGnct/OWFmOEByMIEb47v1e24CawpCYsovN0Wf0I4+jst4MhyXlNpygKfcgN3FysN
	fMRYDqxjOpo0POpzp9brN1Rp4/l5HKzeuqC1dCArcyfZsEcrQXBPJzojc+kyNDHWSoQyDUmJSTT
	FPiglDEghvZmI8n3SOChRx9CNsuxKIgHHjQ6MQQukbdNFHsOiHsU8VO+TeGRUV+IVKpScYlepEJ
	FATQC/1/QKqk+54EnJFNxMQI/Lr5L68sQBxk+ER4pjJ/lMTCyDnfAXL+MzRaiZ/aNyCF2zEvwpd
	rY+7myplVxPYloXNtPwP0d4575OPwyU6r1G/zghBnhJ+aYnEnXUpTodC6QtuNj46LYBYTMha
X-Google-Smtp-Source: AGHT+IGEO49EkOTURq2dd80B/jZaZg6Lr95kVlEuO3QoAtObbHlJjeJCYscX19kjXmpcKNM1wSiX9Q==
X-Received: by 2002:a05:6000:3105:b0:3fb:9950:b9fe with SMTP id ffacd0b85a97d-40e48a56cb5mr155880f8f.47.1758724625481;
        Wed, 24 Sep 2025 07:37:05 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fb8ebb0d91sm15724812f8f.54.2025.09.24.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:37:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 16:37:03 +0200
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <aNQCDwYcG0Qo00Vg@krava>
References: <20250923215147.1571952-1-jolsa@kernel.org>
 <20250923215147.1571952-3-jolsa@kernel.org>
 <20250924050415.4aefcb91@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924050415.4aefcb91@batman.local.home>

On Wed, Sep 24, 2025 at 05:04:15AM -0400, Steven Rostedt wrote:
> On Tue, 23 Sep 2025 23:51:40 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding register_ftrace_direct_hash function that registers
> > all entries (ip -> direct) provided in hash argument.
> > 
> > The difference to current register_ftrace_direct is
> >  - hash argument that allows to register multiple ip -> direct
> >    entries at once
> 
> I'm a bit confused. How is this different? Doesn't
> register_ftrace_direct() register multiple ip -> direct entries at once
> too? But instead of using a passed in hash, it uses the hash from
> within the ftrace_ops.

right, but that assumes that we can touch the hash in ftrace_ops directly,
but register_ftrace_direct_hash semantics is bit different, because it allows
to register new (ip,addr) entries on already 'running' ftrace_ops, in which
case you can't change the ftrace_ops hash directly

> 
> >  - we can call register_ftrace_direct_hash multiple times on the
> >    same ftrace_ops object, becase after first registration with
> >    register_ftrace_function_nolock, it uses ftrace_update_ops to
> >    update the ftrace_ops object
> 
> OK, I don't like the name "register" here. "register" should be for the
> first instance and then it is registered. If you call it multiple times
> on the same ops without "unregister" it should give an error.
> 
> Perhaps call this "update_ftrace_direct()" where it can update a direct
> ftrace_ops from?

I agree the 'register' naming is confusing in here.. but we still need to
use 3 functions for register/unregister/modify operations, so perhaps:

   update_ftrace_direct_add(ops, hash)
   update_ftrace_direct_del(ops, hash)
   update_ftrace_direct_mod(ops, hash)

?

> 
> > 
> > This change will allow us to have simple ftrace_ops for all bpf
> > direct interface users in following changes.
> 
> After applying all the patches, I have this:
> 
> $ git grep register_ftrace_direct_hash
> include/linux/ftrace.h:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
> include/linux/ftrace.h:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
> include/linux/ftrace.h:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> include/linux/ftrace.h:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> kernel/trace/ftrace.c:  err = register_ftrace_direct_hash(ops, hash);
> kernel/trace/ftrace.c:  err = unregister_ftrace_direct_hash(ops, hash);
> kernel/trace/ftrace.c:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> kernel/trace/ftrace.c:EXPORT_SYMBOL_GPL(register_ftrace_direct_hash);
> kernel/trace/ftrace.c:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
> kernel/trace/ftrace.c:EXPORT_SYMBOL_GPL(unregister_ftrace_direct_hash);
> 
> Where I do not see it is used outside of ftrace.c. Why is it exported?

I have bpf changes using this that I did not post yet, but even with that
there's probably no reason to export this.. will remove

thanks,
jirka

