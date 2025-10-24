Return-Path: <linux-kernel+bounces-868788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A54C06264
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C9C3B9D15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C302DECB0;
	Fri, 24 Oct 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yz30sDJQ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0872D027F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306748; cv=none; b=oYbh18FcwldEaapEthM+98595GTKZ+Io6bKcw+ZKjeEKLZ21GmGfN9WF8Vz6xUwZwL7ugt7YDL86A9vTPX1sbpvxTkqbEswHmEjXw4yeASKY/w24vXQ0Eg0PfOvA7YfkYjn4NUtr7PC1717u1Gy6XabVLzsIYVfUjSo3s72iKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306748; c=relaxed/simple;
	bh=93wwduhxx8znK61WZcm4YGy2cVGzcr8ayC7IgZECKLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMLX7tnGgFyDhSDcxNBnSFAkSO8Sh/PLrryoZS15RJoAlrtHLtEDbjBm85QxX+cVqAPwm5XWofYQvus0V6LWgVJlJxvyCSUIJhtWBvQHN54/bqGg0P9c9MpCtTK8SKhjMGyr5ulQC3CBc7BQRgv0H+N1xceHFqzIGk8th+imA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yz30sDJQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427060bc0f5so1117707f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761306744; x=1761911544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e/3an1SN+QfTJV8HYIDsA1G0BlqidXgCmoIkvXXg4E=;
        b=Yz30sDJQpZjw3ILUnKtlSQySS5B2X2aMl4b5Fc72xD7jPhnJytOoXNZZ7HAeK4v8av
         p5ohno6Vb4lZ0rxEK48+MizBe7Ee5JDKjqK5YBwe19TWZNcX0kXPcC8peXImN6FjIxC8
         iXT9l028y7Z21lrZJjIOG/LouieD4oPD4AFjOdGpNZU+anUHf19lf545HENk1CZUdIix
         GdMtbG81ye/wm4Zs9/xSZZEzwXuySWIxVq2a22XagG63wqneYO0JOl1/jilXT52FyliK
         NsYmW9wEtfePqxFRMdAvLaOnMQ/gIb8oz10ZDkynbyKy0nJd8GmbJ8jCFS7xO8zCwHS3
         /9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306744; x=1761911544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e/3an1SN+QfTJV8HYIDsA1G0BlqidXgCmoIkvXXg4E=;
        b=TBPhvbEK2JfKy6HQNxCgcDMpGUN+wwundo22pXxt8teO1x2TNcOMAwDozCzlokxkzW
         uMm5Zv6to+XGuwjfwGi4Mp74U0J0I8EkYKg4zmZO0ur1L4EDGTqkUsH7hbri+MXnvVob
         P+BzpKqKL0QMjVRX7UZ+o+eO67RdWpR0o3YhTUucG3gMoIYX7LuFz3Qrj5EUDwVp5g1w
         cSn5GhrBeTitldT3iC/johXkFDPH8cZHjfR7TdFTd4josDbCJ4KBu/lwROuMEY8f3oVG
         cSzqk+gEaSKVySSPZksbiutP/dshof8l6MEXunHotDK0nLCxnFUnWzVFRZzndiUamDR8
         KnDA==
X-Forwarded-Encrypted: i=1; AJvYcCWiQCvM1Gn+J+yGp1e7xg4qa6Wr8teP7s3R3phvIFSfJVfp8KJA0hKAQ9x6x0H3tYA2bsk6L4j6O+Tfucw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5erifD+qEN+G9gKmiV8wyGWKal4rXe88TskQMX0a2pyIrWBA5
	NuXVMY6mXDsPFagjYFAV380c9A16uYDQdsoaXlkZyu83/weDH9WtEc1GUBVewiG4LGU=
X-Gm-Gg: ASbGncswP4ZAPOIrAEl07qLaPX43eNwVqUFKalo26qn3gTC/OWs6ZWWQFkwVxRg5kT7
	/gJXTw8hPZZiZHx8ZGDAjCJ3XJvvEo/IfQoj/y9MJMArba5V6MvXdBzxXBMk9ChWIjJaU67htP9
	BOtTLhtscTIQPNctTW7ALSJ54esST4Ts8fedlls+LOKm/AkTZjeDUM1Uhia54lunqe1UGiSGH+x
	vXRuPq4wFJauZqfLgHnmwY8Fpz3VnhtUKuBiZ8Oeg3s3QQ2hY9q8BG1Bx6JszW2Pia8q9r58Xgx
	tNEs30ugrrw8SGOkkqndiqbz9iZ3UxcJTfbA3GjjxAUUNX3CZyLXpTSK0oWiNopI5ZaCkY+RquA
	EJZdKRzTdG1eGBAMt2uqJ72guxSMcHi+OxUWYYG+IubeZQhM9blzLEip/zmFff3CTE7tqeVbiiO
	Evn58M1rneusQjlUCz7TpbCq3E
X-Google-Smtp-Source: AGHT+IHz70KoqesTwTjY72XM5XeFbqMAa6sWYwIDo+lch3Yuufz1YtUbphcT02Zrk6L8CwDru2KL5Q==
X-Received: by 2002:a05:6000:2086:b0:428:3fbb:83ff with SMTP id ffacd0b85a97d-429907018a4mr1499102f8f.7.1761306744090;
        Fri, 24 Oct 2025 04:52:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add8bsm8807765f8f.23.2025.10.24.04.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:52:23 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:52:21 +0200
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
Subject: Re: [PATCH v6 0/5] Handle NBCON consoles on KDB
Message-ID: <aPtodUgB37thKUMb@pathway.suse.cz>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>

On Thu 2025-10-16 11:47:53, Marcos Paulo de Souza wrote:
> In v6 the patches were rebased on top of v6.18-rc1, added Reviewed-by tags from
> John and did some small changes suggested by him as well.
> 
> As usual, how I tested the changes:
> 
> Testing
> -------
> 
> I did the tests using qemu and reapplying commit f79b163c4231
> ('Revert "serial: 8250: Switch to nbcon console"') created originally by
> John, just to exercise the common 8250 serial from qemu. The commit can
> be checked on [1]. I had to solve some conflicts since the code has been
> reworked after the commit was reverted.
> 
> Then I would create three different serial entries on qemu:
> -serial mon:stdio -serial pty -serial pty
> 
> And for the kernel command line I added:
> earlyprintk=serial,ttyS2 console=ttyS2 console=ttyS1 console=ttyS1 kgdboc=ttyS1,115200
> 
> Without the last patch on this patchset, when KDB is triggered, the mirroring
> only worked on the earlyprintk console, since it's using the legacy console.
> 
> With the last patch applied, KDB mirroring works on legacy and nbcon
> console. For debugging I added some messages to be printed by KDB, showing
> also the console->name and console->index, and I was able to see both
> ->write and ->write_atomic being called, and it all working together.
> 
> [1]: https://github.com/marcosps/linux/commit/618bd49f8533db85d9c322f9ad1cb0da22aca9ee
> [2]: https://lore.kernel.org/lkml/20250825022947.1596226-1-wangjinchao600@gmail.com/
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v6:
> - Rebased on top opf v6.18-rc1
> - Changed some includes, as suggedted by John
> - Reworked comments as suggested by John

> Marcos Paulo de Souza (5):
>       printk: nbcon: Export console_is_usable
>       printk: nbcon: Introduce KDB helpers
>       printk: nbcon: Allow KDB to acquire the NBCON context
>       printk: nbcon: Export nbcon_write_context_set_buf
>       kdb: Adapt kdb_msg_write to work with NBCON consoles
> 
>  include/linux/console.h   | 55 ++++++++++++++++++++++++++++++++++++
>  include/linux/kdb.h       | 16 +++++++++++
>  kernel/debug/kdb/kdb_io.c | 47 +++++++++++++++++++++----------
>  kernel/printk/internal.h  | 45 ------------------------------
>  kernel/printk/nbcon.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 171 insertions(+), 63 deletions(-)

JFYI, the patchset has been committed into printk/linux.git,
branch rework/nbcon-in-kdb.

Note: As promised, I have fixed the two compilation problems reported
      by the robots when committing.

Best Regards,
Petr

