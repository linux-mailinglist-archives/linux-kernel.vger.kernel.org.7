Return-Path: <linux-kernel+bounces-829098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4DB9640E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A3D64E2ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1742263C8A;
	Tue, 23 Sep 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RKaLv14S"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445492367D6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637370; cv=none; b=qUEsgkq/UuK82F4nHyNJ5d7GwgUNWvh7ygTfFNDmfmanSoKwMpsYWC1Qb5U8LUtr8g8+pN6bxKc1Zg/Te+LVXrCaou2SB1b/z76mlrPLoIh/aloxZBV/CiqlRaQcPbpVll7KLWIfTU1EzG9KvUDFe/r//iCK80SGUtX+7qNGvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637370; c=relaxed/simple;
	bh=k/oXXkphYfLHFq80AydWAZOAvzSIAzGA3lrAGman0uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osKnKPTZo9aTGRFPdIWD9S0Bj7Mzulu3t8JDTIp15WQYiUsQ5VCP2nLj1RfyCZziK+8xCUps9p3/h+cPDE/m719Ca+wArhVFI7JKksAGZwH6N/iTLQHROI8m5qCDbh4fkk8Hd9GtHHwF0/IMSj6E7DSFftn4qpO2lBKP4CkMsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RKaLv14S; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3194020e86so51528066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758637366; x=1759242166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmLl/4ImXxHHubmHbe5dOIW0EoCW9mMDj3LnIx84LVA=;
        b=RKaLv14SUDNGjza5IgHhEk9zldwlxJA6tCxVo37nBTMIWQnrElFcUN60Td5ZxJQp00
         r76NIWhHqqkpFoki35wYDM/2vL+Ru/9M4YbQzrAS5K/fbUN4Stg/moRCH648WehwQ7eV
         tBJOWqawsIyXfsReFrhpghIl3Diko5DLH9PcatYaw7C6RkdS01QTrhQE1SKL+VQuaX3p
         G+ApsScYXW4dK9VizYyeffW58/OysUZ/slEgLsdqZchOWWhK9ReH7H3fLxCWcA8dE0uz
         cvBXb52wLYFEyvVkFowXQ9VpcJds4ujrLUEjMwBqdVnOVpI90ERzHUypCWggeOyTeEVM
         +0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637366; x=1759242166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmLl/4ImXxHHubmHbe5dOIW0EoCW9mMDj3LnIx84LVA=;
        b=Oc7t9bvK8X0fwjrS8e047o/txTE2KAw3NIE3/qj7Uz17lnWTWsoU1n773B+9w4Hn9/
         cX1JDLKvzlnpy0tM1MoxTVA4zxkliahiu5lRzAja/AkgXQR6tqfYvobkhDKmCBnSAdyO
         4dVSow+F/yeHZ9EVKAnPVHHzgvlH/e6QCXHFhner7lCqVbi5MK8erlECxiWS8GHypgWY
         caQ0Ds+re5zijU0DTyBsTLVwMXQNjUMr0hq6D/HGGQUFqiqmXmTjRFLm9XXUiGa6JiS/
         W8LTyT132hftjoPGHMqUCQdhAqBmFw+JcDVw9oBwOqmEVDfzxLGYpxVXIMHev2cGv9Rx
         52cg==
X-Forwarded-Encrypted: i=1; AJvYcCUliHZ5AEffnLxFh2F3eeWX5wIctXOGeBBHc0tLbvua1wV2gvwpul7UTri5oZ0q7fcq9C+Q8/DSjqE7mPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cm5sgQ8Gi3TgWTo1o5/00wYpVjIClE9spwOFJWiLIqOTknHE
	uwjI17Kgdk1lEjDOSLIJpUbQYNaSthtYYtv0niyIdcxX1r9ZJh9i9Sq+RHtIjjkjhuQ=
X-Gm-Gg: ASbGnct83WJWljot7kSW/s7Kj5dXMrA694ilJWs83pnnOgLrhaQ40KpKio8jy5gQOiA
	QXc2CfPoopkL4urOPYQMxi6okUhUh4AZm4Wd3QvEUOrnMIGgQOrAKesAIoMNE+7GY7+cficmAsY
	q7rYb+R8TrSlL3ZZjc5HccOEih0q/sGE+KzGTcfWxfKcuZccSvsylO7dNcC2GV8DsYoj7YMP6Ir
	xEKt4mwL6EVnOyZ+iWBuXrCLCKn4TIKdSkMCfL3PAJoCY7pQ+GznTayP9FiQ7XhSluah7RPbiH/
	LWikG6fb9vIGTlve6n+DL4IPuHqToRVaSdsPqfgqKPTzXcuAEzryyLGQSSKMs3AFM/FWVeqYYuO
	iFgv60C3O4vMy7Eyr98Zg6uYmFw==
X-Google-Smtp-Source: AGHT+IGWmgvDtn+E2Ef38Vqy8EHU7gY9H6L5r+k79CaIYdswzieZTRGHbFt6f6rzUw4xD3UmUD2/dw==
X-Received: by 2002:a17:907:7e88:b0:b27:a432:843b with SMTP id a640c23a62f3a-b302679e8c1mr226323266b.6.1758637366515;
        Tue, 23 Sep 2025 07:22:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394e32sm1007126266b.16.2025.09.23.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:22:46 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:22:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] printk: Use console_flush_one_record for legacy
 printer kthread
Message-ID: <aNKtNP-B3a0UAjHl@pathway.suse.cz>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwy7pFM7EExLxaX@pathway.suse.cz>
 <CALqELGz4ug+YyBvdmPp5aHR3x4qUEp4u4cCpWLL5143VCrf3-w@mail.gmail.com>
 <845xdak47j.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845xdak47j.fsf@jogness.linutronix.de>

On Mon 2025-09-22 15:33:12, John Ogness wrote:
> On 2025-09-19, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> >> I played with the code and came up with:
> >>
> >> static int legacy_kthread_func(void *unused)
> >> {
> >>         bool any_progress;
> >>
> >> wait_for_event:
> >>         wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> >>
> >>         do {
> >>                 bool any_usable;
> >>                 bool handover;
> >>                 u64 next_seq;
> >>
> >>                 if (kthread_should_stop())
> >>                         return 0;
> >
> > This changes the behaviour from the existing legacy_kthread_func. Thus
> > allowing the thread to exit mid way through printing remaining
> > records, whereas previously the whole set of unprinted records would
> > first be printed. But that's probably a good thing.

Good catch! I admit that I just copied this from nbcon_kthread_func()
and it looked reasonable.

> It does not matter. kthread_should_stop() will only return true from
> printk_kthreads_check_locked() when @have_legacy_console and
> @have_boot_console are both false. That means that whatever legacy or
> boot consoles there were, they are now unregistered, and were already
> flushed from within their unregister_console_locked().

Yup. I would keep it in the do/while loop to keep it consistent with
the nbcon kthread.

Best Regards,
Petr

