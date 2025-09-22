Return-Path: <linux-kernel+bounces-827157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95820B9077C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532E8421FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21D279787;
	Mon, 22 Sep 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RYAxhiou"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED6191493
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541561; cv=none; b=ato9hZuAH34Lj/egF/61aNFJxQPkMzvD7lqhKwB7m9a4LIeIZmoF+IfU/77m62OiU7S6sDYke7Vi6cW0Lx8+S5lhWY5vSYvEUjTK9iYfuGZRoTiCpZltyY/MX0l3CVOHY0IjyB0bEV7yjtTRhqZQ/wrAfFNgX87Eh9GEwnaLr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541561; c=relaxed/simple;
	bh=UG2W342Wij95u1fDEqXCT3MDbSwRG7Fy5AfHuK9vjjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZUYSXOb4XchQh+Y3clnCSNjCM1OhCGGnKoXRjEnbRJn3Y0PJi0aO90WPDbKRcEF4fVvPQvDDYCAf2XpZfaiLq3RyFKjHKuQsRY8KCtthNg/cOa/ITlWeD/PYJ7hFCnWsud4ZtSEnVx9LW1D8IgW14F/NCqV/5qG/7C6/EeuO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RYAxhiou; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2ee3c13aa4so22386566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758541557; x=1759146357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od244hgOsyMer9MhVUh92aWlwiWiTwXXULdLgk3jYFg=;
        b=RYAxhioufnyrAwqkKcCG0nrVIvyg7ulUG+xheSLUeADlTE/4E4rDnq4Ie/x5Fd3xmH
         x+8S8D+UPTdsVpwfM+XrNu9ZHpz4ovYvvYk4so3GR5QTI80j0tx/9iDY+R+439EIptPH
         PfXnaHqanLAIW0t+KjwZGQ1lKVpeQX1NiLuz+/qSv3HKYZlh24oaUBWlt74G5s9xTAFM
         Yp2kJXpbBy/oh9qsu6fmM0SVK/NYvWSmDHAqfYocRtYEbrV3Xj7VPwnzES95pl0Esrx8
         MQE5RNpuQy+E2uR7joOXw7vjL10fVNdLwvYLVD5ZC7ZUdNXa7UCKTVbcxWw5b6F6VHu4
         +Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541557; x=1759146357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od244hgOsyMer9MhVUh92aWlwiWiTwXXULdLgk3jYFg=;
        b=M6O4Aj/V87b/xOqKciDvEFcoVQKs0OXxehogYDgmlexNYYZMm11JJ+qDwAihALW2oM
         Mrsc0iiAuAOw1V5JMBVx+mk5He9NceHK7NPIwwOLedXq1KA9f2N6bWszluUO4F54HNQo
         4wzKmo7IN/yxzQiHHuB9PiUwQrXMMh3suH/oXO+JdKrMR83YA6bTJ7TiWxlyo+cmmqTj
         nUTpoj1XEBwSRT3hwISmVk8pL/50XfF0ojyOyP1o2sku1hewpDz+pDYBOPy5iGs5Us04
         iLC6GvgCdnROrzw42J8QkUCNFyQAll3DACY8NUMyM0JazDoJasx+TI+XFf2Sk0GdofOT
         A/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVmPUZBikqNARq+sIGnaRrX2OpXad7aFtBSpUstUR+SE3Y2B9TZvn+JjlX5fW5jBrmug40e8kdFi1THklU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pAXthOTRUUTYJOAbzcjThVVRvPTwSzReVABzq10v6WT3npz0
	zIC6faMA/1w9Grz87OSxaLvG3T6UFYn/sEpqyR19v61IkJt6v6XcOY+3YA5Cp3cuE88JoPg+VW6
	YCJgXx5I=
X-Gm-Gg: ASbGnctHiDvNqw5M8eemEGAaVmjlsJb+qKqY/V21K7ngZME9vUBjqrYebbku5XfZBQ/
	uB2NB3foaCffq2MZMe2s8o79u32N+eo7K12AeT+W3t00NQ/IJUENtYwhgT0+GfCm/rFNljUHpL5
	+sXrIcxENk6MI060kNfJ5HQ4BN60gR7tj9CqnVy/T82E2HYztZ+mXr2IcNKIG+FMP9YjCD9TPXe
	UPzSdHNhdD4thglO8D3oYySG2JmeoCOc24NHnpUbcXgGNILjMtXWSZ91IV+MAyrsof+t/PgAF2z
	nZyNEjgfQZybcaC7Lj5yHwNAX/Fr1qAO3/2Ki3AmZC9RmmMibqFt54J44rVP0KjsgSjg4kmm3bX
	q/NGCROKVRM9UdYJRe3X04KmG2g==
X-Google-Smtp-Source: AGHT+IGxsEzCy90ZwZfzN5Scf1oQ1yFkr5XTxOnHbtbd/GZeQXvdG6DAjzMpwzvdIsAhrvegiPFU+Q==
X-Received: by 2002:a17:906:b248:b0:b29:d157:9a0f with SMTP id a640c23a62f3a-b29d1579c00mr569828166b.25.1758541557525;
        Mon, 22 Sep 2025 04:45:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a44e8c79asm405161366b.63.2025.09.22.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:45:57 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:45:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <aNE284aQjIcIpDpQ@pathway.suse.cz>
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

On Mon 2025-09-22 12:50:04, John Ogness wrote:
> On 2025-09-17, Petr Mladek <pmladek@suse.com> wrote:
> >> After weighing the pros/cons I think that a global variable makes the
> >> most sense. It will simplify internal APIs and provide all
> >> console_is_usable() users a correct value. And the end result is no
> >> different than what we do now.
> >> 
> >> We could also keep its setting inside nbcon_atomic_flush_unsafe() so
> >> that the variable remains a printk-internal variable.
> >
> > Sounds good to me.
> 
> Right now things are a bit of a mess with required changes sitting in
> printk and mm trees. Since this won't be going in to the upcoming merge
> window, I will wait with v2 until you (Petr) can officially rebase the
> printk tree to include the recent panic_*cpu*() changes. That will also
> make it easier to coordinate the upcoming console_is_usable() changes as
> well.

Makes sense.

> The functionality for v2 is the same as the v1, so the network folks can
> continue working on the nbcon netconsole implementation.

Yup.

Best Regards,
Petr

