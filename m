Return-Path: <linux-kernel+bounces-835961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28606BA8742
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AC216BB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB727D776;
	Mon, 29 Sep 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="WSilErLV"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0072608
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135843; cv=none; b=eIh3baEkYkvbOTRS2cZormbWPRha6YHUS00AGUP3B7WTHGnyljlrZLdCgz138YKqYhJz3qdQsc77zhg+/s6WvtqY94wuS7eiW48OYWclzaimEyDpnLTrtzRrxtlq+OU1lRrfllMwqAN34wgMny/63y7WlG8OM6xN+itwwVSW7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135843; c=relaxed/simple;
	bh=c+9Zr2OF83HBvaK+XqqJLlx3/W86r07CDhX3cEewtsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlOkjno5D6T8ko6T11HkDLjnBRrCd0teJoTFD6HUxpm2wSmL+a9ouqgBWcmiPGhA9QEQgs3O9ACfwjExDmMdRUHmSjhXCzv/W7lajJ30LRGsiG1ZoY6GUR61nV5IHs5yC4CwxdjCk0IcCBZoxd1oeeONH7JmeN7RCY4IcHywQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=WSilErLV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso148980639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759135841; x=1759740641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=omySSYONQjyq4CRJmwEyfFKCPXkUZxqazybffU9Te1w=;
        b=WSilErLVg8cZKkL5QDR4LjFXj4GZt3WzGuYNgaB+WUecUemYLKVgmuZcmiPG2AzHK5
         n9OLKq2sPZE+jErqyk/ri76ocXPqPsXYITEPHKZsTQpktVL1qBrB23rsOYujbigUBHRr
         sdWZr/YyN1jNO8uoZ+D5okpEeTf4aVfq0PvNeHYK3frzHwScIcGZg2S7d5CIn5pVssuE
         DEMcmuUdsr7sBxcTpweh5f1YNI1M+bmH2X7ISPTdh9RTINLUPw7tXzdd/rgW+Jnf4Nel
         CCjA/CmEd0in9TBoJkk6/X5lXym7ES0C4wORBaniFuNTnZvy1fEUzw5qS6xP5LLmtkRb
         ZDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135841; x=1759740641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omySSYONQjyq4CRJmwEyfFKCPXkUZxqazybffU9Te1w=;
        b=IB+825HFKS37ElpwLyh5ZzgoPUfIheam5ndD28EUrXiwJ/r2usCfuf74yivXrPT9N5
         0pVId6I+85B1tO+abykO7CTYmY2XZFVQo/1u5sV6b+4SXBzZz7FT55rqPE+Opcw6MbLX
         /Q5Nsr6dOZL4jGdt/iQT1PZEs4VJp+vkF6lCm0/odXsfzV4Tkcrf2O+KgFc9l8W4y3IR
         Bhy0HKM65CL7huJok3GaHzJJNWLnkJXtJ8/Y6tVvcEtvg7V6M5psF1+tmeZF6/8Y4lT9
         JplXjjCxM9N5MHZO0Dypz6NOWZVvqa82BPv717AG1tOCtbadcE92S3noPsJjngP8/hsI
         UtxA==
X-Forwarded-Encrypted: i=1; AJvYcCV+0Urb/X7EYxEo99GeoSXufIegkJtbT8SvJ+7xOtJcWSQOuXJLrIUZMm1ioLHv12YnE9t74AHPOqEkIp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGc83f7/EQtnnx91zTwTMXKAhXRDyyOt+wkC0tWXkX9G0ySYDL
	YsLP1ngoDpfh90zFWtZQQ8QLqtggCfnAXxLED/YBAmxjCqnE9heztOM01SRBHEMuUtMo0hex8sG
	o9LF3jX7Eumx0xR0txFLAwFIQWZLyllsoj5wpmAOa5g==
X-Gm-Gg: ASbGnctZh/dEcHUqfsaikH5+RBi3C9kGc/ATsfT+T0wCNLJDMzmsOePnZWFi28pvc6Q
	vu429vNAx3M1E/dgEC3YRXb2JwLycyvoYywXR8/YheMm8a1qAp02gzwvQiifrbq9H1EUGmyWnp5
	mcaQXPcS4cJdKzomunNon+FizIZgLB/D3ZvrLDsiUJvI0AIqK6324IwigrhXT6VwWZawl0Af2rk
	OsJRaYpkMdrmyo2DEdxpaywuxqxj4LFNgFrhUmS
X-Google-Smtp-Source: AGHT+IFe2KxVUzzK5sabl2rokVr2v696XAURYfuVjNJ5+CtdiRxH8OO6QdoW1deS8WHtLy12IJabmdlvZ2pPAjcgK3E=
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr234725575ab.11.1759135841140; Mon, 29 Sep 2025
 01:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822142502.69917-1-pmladek@suse.com> <84qzwzbr90.fsf@jogness.linutronix.de>
 <aNFR45fL2L4PavNc@pathway.suse.cz> <84348eju8a.fsf@jogness.linutronix.de>
 <aNO7Qjv_iSUSifTv@pathway.suse.cz> <84348crpi3.fsf@jogness.linutronix.de> <aNQO-zl3k1l4ENfy@pathway.suse.cz>
In-Reply-To: <aNQO-zl3k1l4ENfy@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 29 Sep 2025 09:50:30 +0100
X-Gm-Features: AS18NWAWISHd5SmPiAf9UbtWDXG5PoO98UEAf0UXtMSVTMZ2nK4fH6wu2WCgNHE
Message-ID: <CALqELGycYx7GSVWwoBaWipoF84EG6iYu37F0pWif1MFVEkotaQ@mail.gmail.com>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Tony Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 16:32, Petr Mladek <pmladek@suse.com> wrote:
>
> Added Andred Murray into Cc.
>

Thanks for the CC.


>
> Well, releasing the console context ownership after each record
> might solve also some other problems [*]
>
> I am going to try implementing the 3rd solution and see how
> complicated  it would be.
>
> It would be possible to change it two 2nd easily just by
> using a global counter and updating it in emergency_enter/exit API.
>
>
> [*] Andrew Murray is trying to do similar thing with console_lock
>     and the legacy_kthread, see
>     https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk
>
>     He told me off-list that he saw similar problems also with nbcon_thread.
>     I am not sure but it will likely be related to
>     __nbcon_atomic_flush_pending_con() blocking a nbcon console context
>     for too long.

I replicated my 'slow serial causes delays boot via contention at
filp_open call in console_on_rootfs' test, both with and without the
last patch [1] in your "printk/nbcon: Prevent hardlockup reports
caused by atomic nbcon flush" series. Though I found no obvious
improvement from your patch. I found without the patch the delay at
filp_open (with 8250 nbcon and with PREEMPT_RT) would range from 1.6
second through to 40 seconds, and with the patch from 0.07 through to
26 seconds. Potentially promising, but the numbers are all over the
place, so there must be something else going on. I'll continue to
investigate. In any case, that's not the problem your series was
trying to solve.

[1] https://lore.kernel.org/all/20250926124912.243464-4-pmladek@suse.com/


>
> Best Regards,
> Petr

Thanks,

Andrew Murray

