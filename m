Return-Path: <linux-kernel+bounces-840325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2645BB41E0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A1117C603
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DD312803;
	Thu,  2 Oct 2025 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kqSpm3Qx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734325A2A7
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413701; cv=none; b=PzEumIWho40KdPm69pGj38nnJsE2vzYXRxrg0wMzW73zPs/H8bZjs4pIV0eGFfVClaQLUJPC4KNUw8HQYKTl4BSStcTu0zMM0nrsVY21WEqLDKmV9bXyZMsHIfdrlbCe+I6il8O22smWje+9xMH/B3Le8aaa/pcDIMImKoTYDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413701; c=relaxed/simple;
	bh=618BSYEmgS36ili2g+UNYEY8LCBfl6PF30CT4JuRol4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGxA3eNyVN0F9H7Zen1CkzYF/pcOSEdO5pjw/ry5c6MKmic9mb5v0WMiC/yRPq7hAs8RfgCU4OxZVakoan+MebYIhrFDTwWMLohiUewtlrni1t/jXZ1IbxGuwvE7xkGHC/9cdu6u7+acYTfi79ACh/imOFlb14/0tEK/mec1IHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kqSpm3Qx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so9999745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1759413698; x=1760018498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=618BSYEmgS36ili2g+UNYEY8LCBfl6PF30CT4JuRol4=;
        b=kqSpm3QxD08j9LR0hRoezFn+7KvX9qBqxGpysY8VvhK5OKmxIJ3tyaNfVj5gD4Soxx
         isItIpXOf1ZGLRbhxgqCkVcElFfnxVOU2wp2Wt67ch6H2l21Fy+a+jKcFTBfNhDrlWeP
         8ykyG1+rp0DB4kLbNsKLmcvkzNxi6w7Sllw86EKAqaUwY6jkOfJUeJdTHYTiZ7VeWwLE
         V2pBOusYz8x78FmeT40BlOevzSk5ekkcARO/qnxbhtTG+xQvPe5TZfbJ8pba/f8mz/bR
         Wp3/R+4A+q3dbsqQhEOYHWWHJ4ocb1/dJDAw/lG7AprQm8tHjrMs/n1CcxM6A+ur+Jdt
         AUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759413698; x=1760018498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=618BSYEmgS36ili2g+UNYEY8LCBfl6PF30CT4JuRol4=;
        b=nIQdGYHRUo5WF9O9gO3vACJBhYoC4ClluxWdvPm+f9mFJLzr1UYuYtau4VjnOOK3B/
         B8NrCe4wXoH1QePN3oYWpEJGD2o7vdgmtdIl6x6Jo1omPimqpMP8dXZm2gbIvdIhUSaR
         FTZapl+TY0GltRoLzcJsfRFlcT1Wqk5UB285A0sOW0hSSaO0thwl1shpqlw52cXcuGlP
         PULWdbLozxUx99FDIdPExxX8O6cf49i1YfoUCYmfMGUtnqc/btEv0vmnrP/u1E1lFN3y
         GjW7m8ArI7aEezKro5VJfs3AgAvcEcWWmf46WNylHFk9k7siR9OtqByIn/6yxfISPUc2
         /T4g==
X-Forwarded-Encrypted: i=1; AJvYcCU4+OzWWjXwCk2Jwn6+76oY8nHjIZ/49Wd/KyX5E4BY5jApJ+YGDPKrILiXdnGXD01qmVrbAIoujJQVU9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwND1q1h8dQJ67qV+Z/fZNrwzn9ms+HThIyz8MaqCnMNOrVNH
	9Bms5cJ5+pRF7lohIVVm0wq6v5BkqX8kTM9ymqqZVonxIHjxGvpQUEydtBti2ylRmwQ=
X-Gm-Gg: ASbGncvJ7mUW1Oxv8Be+QHpe22iIKa3MZEmZabJLFp+Zol4dC1+D63X/cEPtc32Fkno
	8Ts2Tt7kdMgeezKXTPVFmNyH8HOzqsfN4DHUL9EqOTNlBKX/J+/LUIiqRl9Ak9vMl6ezFhEGZ/b
	7mRnrfc50otyIHJ92YhrNvuon2wvZVXQanMkRq7vSgjKLLRNIDJdNp057Jgjvn2xzjEdU/Xr30n
	fU1ZiOdqMwzytTjVelbdLDNvv9yexVNJJaBIpPZwnOzIF/9yC42Vvzxh6J2Gdzcr65Bl4NFhuJO
	fEsE4mIo9UBZ6Ne2WHzmNbewwR6ThR6oCsCGmp1SPwbzxVcmmCtcuWr2LTUWAT+fRlyWY5ImxQI
	M3SDqLG0Y7Zp0L80UixpGMjzVn7WVxKKydzB9srEic70zTAmwINsjQkhSbBOilME9EqQJrUyk9e
	4rtyrsJvJ7YlUchqUIDvfx/7c9hqv9WXn9g0q/qKIG
X-Google-Smtp-Source: AGHT+IG5EPzxsZqj3ktM8dBJGC4KrYqeEY07Pvs0vWo4hOFgdW8tS/BF6CeIhvLzJ6wrhzsLtCCTXg==
X-Received: by 2002:a05:600c:4586:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-46e6f7ff199mr8275435e9.29.1759413697016;
        Thu, 02 Oct 2025 07:01:37 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bcc2csm36373715e9.12.2025.10.02.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 07:01:36 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:01:33 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v5 0/5] Handle NBCON consoles on KDB
Message-ID: <aN6FvQGj2w70Ejrz@aspen.lan>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>

On Tue, Sep 30, 2025 at 02:21:06PM -0300, Marcos Paulo de Souza wrote:
> In v5 only patch three was changed, changing the check for KDB CPU, as suggested
> by Petr Mladek. Also, it was based on the recent panic API [2], which now sits on
> -mm tree.

Do you keep this work in a git tree anywhere? I wanted to point the kgdb
test suite at it but the patches don't apply cleanly (even after I
grabbed the patches mentioned in [2].


Daniel.

