Return-Path: <linux-kernel+bounces-828918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4001B95D87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E111898EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E6322A3B;
	Tue, 23 Sep 2025 12:30:10 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCD13AF2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630610; cv=none; b=kzGJpu8/H1A54QTIdanJcxVvTpDkX6o2Ef69jXWAkYCH+cWKpl+2URHEnYVq564Zor9iOqOoyq/pABC4QyA9euJ7yD2KItrG1xzR1W/5Kelz6JL9/Pp5gCR48sXlEnWy6MERjrKA5hPOvONdJZHV73PpW5GkYUeFoOuOy+Wqwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630610; c=relaxed/simple;
	bh=XmMLF/m3eGY3yPd9W3Tb10GpU1M2H1wb4pBJaKqSUk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbR0Jc7Vnzj+LtP85IF0Oxd7o4t42oUyW/Qpt8Rh+SajudX0E3Wxs0I2FL/AdFxa0LcMfNM3+qDrSitqLdXSjDY7rPUc0E9S0MVG6gKvUe6skIsyO3MDMjIImCQrkxSq4xt6EDM3HJU34GreIbbeJ3YdHAY3s0DkogBY3Z3unCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b2fcfef5600so130600066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758630606; x=1759235406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJZO7lAyHXBFp7FKgRwx33C9ZybNIhxw72jrBn4zZLY=;
        b=Q9Dj+11wqO8kyclp6AAVps75t3WLxlSdjEbqyr8DJX3mHIVB9YEXI4gU/DC78Yxq79
         uU5GWi1LrZ7ClXUFUPYRA9ZXHfdSQs86jTxS13qr6QFz2aDjf8qk9zwhQIDNlo/61fW+
         rpfEKXok2gDSM5SdALDHzqPCdIv/xXCCyv4ymDNQtfhNydQyQ1lEvaCqNv5/CavXixWx
         tuvV6Ado2w9y/HkJlc+xXp1RcQrkhNyHYpBdAr7CAim56HZxe60gQJeZAG9fmza9yTcG
         r5ZzoiF7e7aeVDD+DZ4f99N/advFDWEdooC47upseBO85wFflnIHGFP4rcNSHUPXcTah
         xAGg==
X-Forwarded-Encrypted: i=1; AJvYcCU5lrU1F7eV8l82noJNr5rPMqR1LEHAFhYg38DLeOa/EOu95kcQaRAkG/PWVmJpmG9Hoc6+twXHnGGXm2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADo+ZIQ0mnRGSpiM++NYFoXd6WBJ0QwUnp7HISHKUO6kpY2Qx
	pEmUxFsBwMXl2yT/9SkSOj9Xh9NZkLpXvT5pXLHrRNFhmM/JBWekiQ7P
X-Gm-Gg: ASbGncsxWByZ3wb6NILwZTCS15r33avcsQ5oQhjXNgd8lqaIEKw9zTl6So8Xm6IlcRV
	rsj1i5VyimWfz5qzQvjaHuIgMMw/tiqtdPnjnmCVeZyUgTIsS4TDXgqpxLu19k6QmaKAFea9nQ5
	AqVJW3ubFVHvAuv73k2wIHXA2bMXhsKffJfiCC2YcZvVn/vGErqQSGRkMHgwOyzxEY6f00aBcE+
	Cz2QumDAgrmuul1iGs0ymO0kjbr1RsezOMJxGeU5K/bQpNy7U+sOfn+7e4yFhBiJl/9K9m3tWam
	P+jqckrZWVcHnjLr8r5isqvSMeS/g/A/ZUNv+mNE3ULpMAr3xeCfhVovQcDUO/v0xNsVryo6IXn
	xXD/ZsrGte/oQLQ==
X-Google-Smtp-Source: AGHT+IF4BnwxyvbqnHCX11spzoctSRHikIJtSIcOaYN6bJgd9Y5MxQ6ESCVH5yS+Qb3iNRS0K/iyjA==
X-Received: by 2002:a17:907:980c:b0:b04:760d:1162 with SMTP id a640c23a62f3a-b302ac40ba3mr215685666b.47.1758630606392;
        Tue, 23 Sep 2025 05:30:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc75ac5e1sm1353400266b.43.2025.09.23.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:30:05 -0700 (PDT)
Date: Tue, 23 Sep 2025 05:30:03 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <swdpckuwwlv3uiessmtnf2jwlx3jusw6u7fpk5iggqo4t2vdws@7rpjso4gr7qp>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <aMl8xX9QCM9jslLH@pathway.suse.cz>
 <848qidw8ip.fsf@jogness.linutronix.de>
 <aMq80xcRtQbthDiT@pathway.suse.cz>
 <848qi6kbrf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848qi6kbrf.fsf@jogness.linutronix.de>

Hello John,

On Mon, Sep 22, 2025 at 12:50:04PM +0206, John Ogness wrote:
> On 2025-09-17, Petr Mladek <pmladek@suse.com> wrote:

> @Breno: Or were you planning on pushing the nbcon netconsole for the 6.18
> merge window next week? (I would guess no.)

Unfortuantely no, for me to get netconsole on top of nbcon, I need to
address a few dependencies:

1) Get the memleak fixed, given this is conflicting with the next item
   * https://lore.kernel.org/all/20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org/

2) Decouple netconsole from netpoll
   * https://lore.kernel.org/all/20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org/#t

3) Convert the target_list_lock to RCU, to avoid having to disable IRQ
   at netconsole side.

4) Move netconsole to nbcon.

Given that these are "core" changes, I would prefer to get, at least, 3)
and 4) into the next (6.19) merge window.

Thanks for asking,
--breno

