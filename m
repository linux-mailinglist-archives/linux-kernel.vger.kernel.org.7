Return-Path: <linux-kernel+bounces-803352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BF9B45DFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8872F5C6E39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024A8309EFE;
	Fri,  5 Sep 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GAZxz1Aw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51130B509
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089293; cv=none; b=MRT9ArXmleWozjTBjl2NZph2+gvA/VAb895lKdeVRDQqY8Dmh1Zxuezt5woOnmUTTdn3qkiDdF0K2nQjqCHlQnhMABF0XuL+ul7mVzx6++MSNV+6MRdW20wmM2W/0HwyTYCifD26ZxWYQjnBLW7PletHRjEpAPsfHc7Ghi7eqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089293; c=relaxed/simple;
	bh=trrGEMYRQyhMQdhMLHq+V1vq3d+BnWlEQPuDROhG9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjUp0MjII+Cw9FxlAXc5lkr75Xl/9RPNNTnImaZWM4CpCxn0EpMcfK/ahapQik634jmc4xTrbg4b379bvKoztgh518gQtGlOjvsMTgnjNkMfNn5Du+ZT5f7QMMn5oge3EFn4IxjLVWPwPXqQjiVmf8rsjYAMp+LLHNGVcjKFhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GAZxz1Aw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04163fe08dso400585966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757089290; x=1757694090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38RoV3MRt21m9VCpn2yaWDX6X26/U5hWGaVRdsOFlqo=;
        b=GAZxz1AwIOXUq7sda6HEi876MyYTcqiQLwsR6sDvkVBR1Dl5LX1ZITG4fHvl/3ccnD
         xibcUOiveCLhEaLfXiBmsbOjNI0mZ0zIOmyWmg7o50acK2yxbJWIEazuSZPeOLwnde5m
         oXbAU5zMKzEvdsm/KrXOxhIHnixaYfAyx/frcAjDeW4QQ1KpiMqk+fhsfRHUZnQlTGot
         FQzStmsb5GmpJTMPS+SxRqPd2QSNaezReUvXgu7Bzwc/Th6Dqc1KP7PATZI3usEkWkAF
         V2LkbuoK0RizSgEyqRFH0zJIFJ/0jt7nnP5myqOIdqAuoXqx2nUujvnn0qgWtVizAA1e
         NljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089290; x=1757694090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38RoV3MRt21m9VCpn2yaWDX6X26/U5hWGaVRdsOFlqo=;
        b=CW9kDpL8rDffVk5FVvHNRSs+PRDSwwC2ziE37q1rOq9vXyvoAvDKjRnqoSJKhdLkPE
         t5bX9UuWPKYTUfyf/DdzhWlbpOXAI3hy1ZwEWrTaJ3h6KP9XK2yszJAjdPul8xu9DkXv
         Ur3+YAjPBUnUMBnIuO7yKOwz6348kzVeLw+lVqWOD2frnU6T3isfDnfnQ4MTpdkEWwNV
         UgnVbB36V7vGPWDXl4lIARQf0ap0hiiHjX9aArWPHiGppuhB4bHIcnBzpPKqQwVWZQPG
         b4vzWuU/aC/g1OeCCs/BfifgjY62ZBeR2M4pn1UB0kwWLdnTnkxYYOmecq91LvqmXUah
         ZGgA==
X-Forwarded-Encrypted: i=1; AJvYcCX0E+x9g8fYsmy3AIajBiwhx5tfzVJnwt30lgqhNOT57U3lfyjZIXNKJx5qutSX4Q4oZVdRltYDF6J7rUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Wvu7A/aMRicFW6NL5XD8bjfxR4cRx9JcDpO+pf2hO3Vbqe75
	yE2tBJhKK6OmPbLYgIQvpzl2f8MHU9F9To+HaeAvFgp8+ekDCsqg+OBw3dASnCMPP/g=
X-Gm-Gg: ASbGncsjbgvZ36QKS5frl4PpX0Mqkjeh+LO9AdGmBbHKISFkyAuuGBCF12yrMxj4rki
	0nSlem7rJGNDrn4iSiHWAQYxWH5+T1iJIwcr64vrZW63tmWG+ZXlSzJ+ukajM9acP/9wU8JCM+R
	k6j79bg2ptigi0EDb/5SMtO5u+lJD2LtOz+3RoAxooavQVwJOXo5Y0kU5ZdC942wfmGA6eyzKyW
	03gpScSqz6KG9CN8GakArpHYTdMotzqE39S+Q4bQ60tIdoqyUlSfKTnqLKhY7bdrVal56vIj+8D
	yVqMCOgpgopwcLe0DOPUyKqeKLvkCnisYN0RDxGX5yEM3rsQwpqNqklNFa24St0M/zaduXFV+Ye
	5LClOg4hbeS9Zm5xgQFbG2GEevA==
X-Google-Smtp-Source: AGHT+IEbX7TLmTaMwpShKtCjVerZWqrr/UBxB0YUnBbh+NMFi75E+MxyttToNGmKdJlXe36bbMityw==
X-Received: by 2002:a17:907:97d6:b0:b04:6858:13ce with SMTP id a640c23a62f3a-b0468583507mr1159761666b.38.1757089289588;
        Fri, 05 Sep 2025 09:21:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0410a65a68sm1475036366b.110.2025.09.05.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:21:29 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:21:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 2/4] printk: nbcon: Introduce KDB helpers
Message-ID: <aLsOBwV6CVBwG9JV@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-2-cd30a8106f1c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-nbcon-kgdboc-v3-2-cd30a8106f1c@suse.com>

On Tue 2025-09-02 15:33:53, Marcos Paulo de Souza wrote:
> These helpers will be used when calling console->write_atomic on
> KDB code in the next patch. It's basically the same implementaion
> as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
> acquiring the context.
> 
> For release we need to flush the console, since some messages could be
> added before the context was acquired, as KDB emits the messages using
> con->{write,write_atomic} instead of storing them on the ring buffer.

I am a bit confused by the last paragraph. It is a very long sentence.

Sigh, I wanted to propose a simple and clear alternative. But I ended
in a rabbit hole and with a rather complex text:

<proposal>
The atomic flush in the release function is questionable. vkdb_printf()
is primary called only when other CPUs are quiescent in kdb_main_loop()
and do not call the classic printk(). But, for example, the
write_atomic() callback might print debug messages. Or there is
one kdb_printf() called in kgdb_panic() before other CPUs are
quiescent. So the flush might be useful. Especially, when
the kdb code fails to quiescent the CPUs and returns early.

Let's keep it simple and just call __nbcon_atomic_flush_pending_con().
It uses write_atomic() callback which is used by the locked kdb code
anyway.

The legacy loop (console_trylock()/console_unlock()) is not
usable in kdb context.

It might make sense to trigger the flush via the printk kthread.
But it would not work in panic() where is the only known kdb_printf()
called when other CPUs are not quiescent. So, it does not look
worth it.
</proposal>

What do you think?

My opinion:

Honestly, I think that the flush is not much important because
it will most offten have nothing to do.

I am just not sure whether it is better to have it there
or avoid it. It might be better to remove it after all.
And just document the decision.

Best Regards,
Petr

