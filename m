Return-Path: <linux-kernel+bounces-846825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01ABC923F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622C23E34D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A682E62B5;
	Thu,  9 Oct 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G5lfVCeL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2C26FA5E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014492; cv=none; b=t6gqP3ARo9zUbv7qc/4sie+kNB1dt0tRPKxm2NTCRhVUNSwvNR5GP9ZsgS/himfF9DGVOI6pmSIM7vk9DBYuKoGt552HRhoKFS64gtmxSlRH1c16Lue3KjRvQALS4aGWQKRR0Moeicv0dnVcAlPJrFc2nHGyTNnjpnWTmwxy638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014492; c=relaxed/simple;
	bh=I9w5uDJCdJtKXxUefk1lr6rXmgvRFSUqW3H/lX3knU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH8uXT/x+KJ7kvA1TOL8nBn7r7v1cjaU8Y4zud4ni80y78lDOFAavIOEKGNL0j0BHbMqLXxRFICm8/KOCMt+llRlH1jzL1oBHPPyoHwa2AZDAY8SZSpEgSfBgVQcN/HmgjIeZPZcyE9pFotHdbcyujTWrakhQ7D3TJDdlpqhdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G5lfVCeL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so10367185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760014487; x=1760619287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYcGuZVsOYaztwq4DboPwGHt7uhiDPn/DiUMDCWNJRA=;
        b=G5lfVCeLd04q/HCfEdrZKlh1mwpFtMN/9Shz9yyaREXOkRjuaL0REiSl7vzHeSeIKR
         1WQQUxMO9Ipyjm3hm+8G/wT5yYBu3O46jELcgki+k3Is4MoxC/+q5zAug5FbDdC3NXkX
         ZD0+x83X1oKgQjSyZStGXWGVSRAwuTn+NJfTXJZFApR5nN+eY4x0VpPlTFlofCilQNkj
         QApoKerkv9tKVMxILGRlqdkrj+2q+eSSvKRCIIiVdxX2E9IWOgJIhEl1mdqYIILYrzh6
         ovt8aDkQK9hcIIIi3eR6Rq12V1LqJI/R9f8KHV8j4le+ptJ3cstfj8MPxgw4KcpqT+zm
         wHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760014487; x=1760619287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYcGuZVsOYaztwq4DboPwGHt7uhiDPn/DiUMDCWNJRA=;
        b=U1fNtxwnlJB53Bk/SIlTFxW+yitta3gl8nvUriDBCviEflnqd6ldXY2bnPJEnCvltb
         1Z7br9p02TJRQOJAnYCTdyiEA+/uCfnRHMsEbdoc/5fZefZ01V5uxxeOQZqIipMnwr7X
         NqSOikHKYN/F49ncCuk6KFtfl95u5I2wo+MLBYOf0LVOh+WYSpwbt03udKbDmm21xZm+
         TjYL1c12k9vj8LDDdA57vCmbbAPb6++5WpA6/Z9yFgYPYqYHPfPNIlqMtT18kQFYtNnb
         l9tXPftiz/G7e4fHZ6JYPPxI8c3HLJEGEWvkLXnGqzJrHaCuKoYnP0uf0prkCvJjKL6W
         akyA==
X-Forwarded-Encrypted: i=1; AJvYcCVqrS4cZVf1djT1U3c70i6Gwa0n4cAzbkiXVHVYUToP4RqYbAJxF1DK4lb+h9cagAMVwBVUtICNcKoyRFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXCa2RisLiY/ziOnMdgJ6AfErrdLZynIyyqrnmuGM50DLTZgj
	W8esvnyACddydA/2m3MGe7y3SKb46fzZvqZhO2b6ADuUuJZlucsShctjPostnQ75SJM=
X-Gm-Gg: ASbGncvtECIvI3UWSEEIClFHDRZwzoVuoEtGGAFIPgeks+Rs8wULHyAKL1sRRA9/Jn2
	qGc9sVsuuwSnw1Zsgefta73YJYaV7bWOPyovVDq5xhu424aSsWQiNy92taRZ1uJf7mxvv7GKRMA
	6Zq20IE3U9e5QbVeoFLzVD82aNh7vtE7xqhsYUdft3qoIHgep/q7qVIypUqTMMZPHtjMYqFWhB7
	ucDZ4m/erk51sATzA7aJiEFz0XhS3kil3QtBEdLEbEQrR+C5OqWtJOtXgSt+xgzSsAyTNol70SB
	0yHdqZbo3hIIkwOnvuSS1GTdyvvQBKTW+XqandadygcwFweJDWIm4PKr625ACQm7C4E8Czu1jJf
	Rdcq1h7TaI/5og5celOJ5CkfY6lElKpNq1fBeYG9HliZG5jWOYg==
X-Google-Smtp-Source: AGHT+IE/RWxYifcmwjawp2o27d7zRSRZhUOGUt89VWZiEjcJlf7xySgMylHOeZ94CeKlshTSc9OhWw==
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr54333115e9.27.1760014486839;
        Thu, 09 Oct 2025 05:54:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf12fd83sm47081995e9.9.2025.10.09.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:54:46 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:54:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <treding@nvidia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
Message-ID: <aOewlFMwploliTIW@pathway.suse.cz>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84a521pets.fsf@jogness.linutronix.de>
 <92b787f4-1f51-4974-9e58-231dddd4b8f2@nvidia.com>
 <csyu222cbxrze5yv3qnwj3gl67x2pwkd6ichpotrwxoj7jru5h@cywpyiqycfre>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csyu222cbxrze5yv3qnwj3gl67x2pwkd6ichpotrwxoj7jru5h@cywpyiqycfre>

On Thu 2025-10-09 12:04:13, Thierry Reding wrote:
> On Wed, Oct 08, 2025 at 08:21:49PM +0100, Jon Hunter wrote:
> > Hi John,
> > 
> > On 08/10/2025 16:56, John Ogness wrote:
> > > Hi Jon,
> > > 
> > > On 2025-01-15, Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > I have noticed a suspend regression on -next for some of our 32-bit
> > > > Tegra (ARM) devices (Tegra20, Tegra30 and Tegra124). Bisect is pointing
> > > > to this commit and reverting this on top of -next (along with reverting
> > > > "serial: 8250: Revert "drop lockdep annotation from
> > > > serial8250_clear_IER()") fixes the issue. So far I have not dug in any
> > > > further. Unfortunately, I don't have any logs to see if there is some
> > > > crash or something happening but I will see if there is any more info I
> > > > can get.
> > > 
> > > I have been looking into reproducing this using other 8250/ARM boards
> > > (BeagleBone Black and Phytec WEGA). Unfortunately it is just showing me
> > > all kinds of other brokenness (in mainline) and essentially making it
> > > impossible to confirm that I am seeing what you are seeing, since
> > > suspend/resume is randomly dying without my 8250-nbcon patch.
> > > 
> > > Before I start spending weeks investigating/fixing most likely totally
> > > unrelated PM or BSP issues, is it possible that I could receive one of
> > > the boards you mentioned so that I can reproduce and debug the actual
> > > problem you are reporting? If this is possible, feel free to take this
> > > conversation offline so that we can discuss delivery details. Thanks!
> > 
> > These boards are really old now and so I don't really have any that we can
> > ship. It would be great to get this change merged as I see that it is needed
> > for RT support. I could see if I can resurrect a Tegra124 Jetson TK1 and
> > test again on that to see if we can get some logs.
> > 
> > Thierry, do you have a Tegra124 Jetson TK1 handy to test this change on?
> 
> Yes, I do. I reapplied patches 5 and 6 from the series (resolved a tiny
> conflict for patch 5) and reran the tests. Same results as back in
> January, though. Basically the first suspend doesn't work (it exits back
> to userspace after a few seconds)

I remember a mail from Jacky Bai (added into Cc, the mail was off-list).
It pointed out that that ARM-specific suspend code checks whether
there are pending interrupts and eventually cancels the suspend,
see
https://github.com/ARM-software/arm-trusted-firmware/blob/f831058437f281e70c2409a9b79828116d4c2915/lib/psci/psci_suspend.c#L154

It might explain this first failure after a timeout.

A possible solution would be to avoid waking consoles in vprintk_emit()
when they are suspended. The functions nbcon_kthreads_wake(),
defer_console_output(), and wake_up_klogd() queue irq_work()
which could not get proceed when interrupts are disabled, ...


> and the second attempt then hangs. No
> idea why that would be happpening.

No possible explanation comes to my mind :-(

> I looked a bit at the code, but nothing jumped out that would explain
> this. Not that I'm very familiar with any of this code, or the specifics
> needed by nbcon. no_console_suspend doesn't have any noticeable effect,
> other than providing a few more messages during suspend, but nothing
> that would indicate what's going wrong.
> 
> John, I'm happy to test any other patches if you've got any ideas on
> what could be wrong.

Best Regards,
Petr

