Return-Path: <linux-kernel+bounces-778041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB7B2E0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C63A27E84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5E32277E;
	Wed, 20 Aug 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dl1SiI3u"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9C322758
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702210; cv=none; b=jkQvOOeasN2sBDYaXZku+JG857VACqM2QF15YNRtQtV7k2mM/oJq5eZAz8K972un1AMx3io1sOBmELaffZO7AiEkeXwLfGPMJ4EfAxg+BgeEeUaHeXPWKTxu/8e6R4FkSi1PbN4B31cQN1BT2ko05X0iVNsoHwpK0+5zy8J4EUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702210; c=relaxed/simple;
	bh=8Mr0tio44r+dJjJIN2VKzAkfGUftUtYKPI/egC5gViQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF0Jm30A6IsZ0j08JC/81XMMLw3SwiBnu3HdVMfdFYqYIBRDGva8XvAaqEiN0tmnO7vN8A8g36TqDNX3ss7AM6WAcOD/U+YYsBYXukkvelZm2VtjPGwfJutIFm/5HrkoaMEevenOahxvvbjtGKjKLva6w4OHAvz+aiOyBI541wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dl1SiI3u; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso9305723a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755702207; x=1756307007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdxbwdm478L0zqoazN7KpullU/D4AnCbXZQkeiEdPmc=;
        b=Dl1SiI3uS92MJD+Pj868HHbVYVebdnnNVq7C3g6K6r2dyRQFunPSL8XLMzSxX0/aWv
         t/pdr6npz1RdakdB3EFEbQRrx5yIUtLBsUlamTMWubsEnZtc8Rdd7Cqhpf9Amqr9m+Gf
         yFuhsm5oQdbM+fJm23RaH+ctgD0q9Q9pZVFgBLi7ZJAHFbywyO87BH7UQkOXqVEdYlQW
         s4LUgcFhd+IKBJOAtpEivEgQQ21zd741Iwsyz7Q6GX41GztWJ6PphP4/rIwJEzsg84qc
         Ma79NFQGhw07GPwoYZxkys7Xe9QcRv8Al8Ee/Slp7bSyRxJ8BqUpRt5PI+NslqVTxBZl
         z/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755702207; x=1756307007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fdxbwdm478L0zqoazN7KpullU/D4AnCbXZQkeiEdPmc=;
        b=FOtj/MQXl5J2EsuzEnyzuJ6nKO4Sv+ZnN9yPcfhT5RKOWr9Gvk9G1nVjOsY5RKomjw
         +wdgZZ2dBmxPDXgbKwlUpUoDzhArTdu4jnmP4GOVyxEZqLO0Wjl+it//5WqPhKz1A1nk
         mwvyTTrmRxqyL3athHB9PjpocoIX3M2gKTRiz9FaYiO7QC49hPXfLhHgN2C/yMwl7YVA
         3ENhUlNAmTHvlXFc/GFIYKIGUAPXP6LC3mSW+QGZI6HEBl05PaC4uoNBckMAn3kQuBWv
         OrVkQvTVF5dfPwnwJipqtjtV7PeoJlJ9F75EQhIdrfqy8f1bUPGrdvT4DOKrAeuYHi3/
         WEkg==
X-Forwarded-Encrypted: i=1; AJvYcCUnumcY8sIsJoe5dWy1oHtVXY7SgqbysCwhq/1NSZ20PY8iwkjPQOLAyK5+B7rnIIZ02HOKLB2XyScY4VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ngYkMyOEfKBnEnskAlQMC1rqat4Dq2e5S9I8k+sGOH83SkQb
	xK8K4lQeNabkhPq6vAcecG0l/UZeagRx/h7TZCm/x0OhWR96QkvQuB12sd9zzo8LXpw=
X-Gm-Gg: ASbGncvAZEFOoWM4gBC3cijwuTLT7n6bHUv+OOmgB6A0l5fvgg+80Rp7EvVs0tV/Wn9
	2DB2Zp5/D4d81GUdOBs2hQ8btyifAjvfoYnc1OgeMjLXUBOCyMX/mibEfibdK9Rc5bQ+jIKWTbs
	Q7x9NUeJwbrbIH8t50j9aeEbh947/8YBloUGXtA1jLH59YOcESPpEyhFZTkWULSsDS/rMXfWpFf
	No9KGkZIXC2b5mgToHDMRC+cKJT4dtvYTqk83LBAZQ7Y92rivgfa/55KTDdOpLF93SW7BPg8tdN
	kZYuQFdlcLvEczqlux0e8ACoDOp1NvzSFo1l2vjaKYDshQVoQouEnAO3LAzO5pQWaj53a3KXr4B
	wtc233XShmjfrgVEMxco/7b9uTw==
X-Google-Smtp-Source: AGHT+IERfCeojuiZGaaBeud++WOySgMRV/LbfgcXF7j062uDmGhunKjky7xHcyj74+ty+at1+JCgYQ==
X-Received: by 2002:a05:6402:4405:b0:609:9115:60f1 with SMTP id 4fb4d7f45d1cf-61a9759a18bmr3333840a12.16.1755702206715;
        Wed, 20 Aug 2025 08:03:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75777beesm3589743a12.26.2025.08.20.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:03:25 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:03:23 +0200
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
Subject: Re: [PATCH v2 1/3] printk: nbcon: Export console_is_usable
Message-ID: <aKXju6tnHAjp1I5F@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-1-c7c72bcdeaf6@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-nbcon-kgdboc-v2-1-c7c72bcdeaf6@suse.com>

On Mon 2025-08-11 10:32:45, Marcos Paulo de Souza wrote:
> The helper will be used on KDB code in the next commits.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  include/linux/console.h  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/internal.h | 41 -----------------------------------------
>  2 files changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8f10d0a85bb4536e4b0dda4e8ccbdf87978bbb4a..67af483574727c00eea1d5a1eacc994755c92607 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -612,6 +654,8 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     bool use_atomic) { return false; }

The patch should also remove the duplicated definition in
kernel/printk/internal.h.

>  #endif
>  
>  extern int console_set_on_cmdline;

Otherwise, it looks good.

Best Regards,
Petr

