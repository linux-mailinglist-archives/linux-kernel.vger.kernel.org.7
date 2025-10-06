Return-Path: <linux-kernel+bounces-843119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9065BBE6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6478134951C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E882D5C8E;
	Mon,  6 Oct 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EeP4oINb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7C2D77FA
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763192; cv=none; b=kj3n4Q41cOHbK1urmSipTJr83PvOUd6oeLgCiDaWH36xseuHhSB5R30+8cB2/oXwJT6cG1SSKVOMUV3s1xZ6crRnxV+6zB3Jqj4VhHwISG1FCTaGVWPmeGWsovaUuKpxg+pvaD3Admd9CbbjnZKYGVHVbSaaTXaXNk18jLrH3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763192; c=relaxed/simple;
	bh=nuu73AmkdduGYHPVenLGjdjAoNdD3eifN2dVNslxPn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOPJ4WK53tUcUiS3/ypkSCNYC0r1uR/EAE/oF+EBNPQ9UVTDgFinycShiJ5Xoohr9z5bta9oIQSZJBaqXqJ0xJL5uEd6Xhvy+/TffoTstzqDECrj6sQg5aTHIKA0ukpEepA1guFBsmAxLV57etYhCvlFkY3qI+Vowz5FHW0a65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EeP4oINb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b456d2dc440so806368266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759763188; x=1760367988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYHZUTt6+ctKIKekChRHoQ96BFtveVN/fubGr+gARRU=;
        b=EeP4oINbJKhkwG7fjpofhPRRpEowB7j4MKSQ4FOdbg2QgWNkhe/knXmDa2m+CyKn4k
         OByWEsxMnGg4B1j3XRQ3wxZZN/U57zlIDXiEjGaYiu1etgQyYdG2zOMTSkFtMG2P4Lpb
         WoocncXv4jWtvHe8WTxeS6FSfKzUAbjQKWc6Vw3Jb2th392c+2r6DFB9AHQAH5Zhn5NT
         gLoWXr+p1nhlzSD4DhaTdtjgE0Dv7Gokt2QVO4T8UhdhQlfXBKbizdzzG0FSJcyM+0ce
         Q5yayvRC1Ow8RG6aA0Rqz6OyFAMuT2X/7C97LRN6F4twAuXvi3A578MM3itpi9/azSUr
         PEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759763188; x=1760367988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYHZUTt6+ctKIKekChRHoQ96BFtveVN/fubGr+gARRU=;
        b=Y6WNyJJzk9lvkJFup+MIFV0pn7WCLH9Zs4MznFmmFw+AVERi++ywh2A/cD3BA9nOtd
         euHZ3WfbhxkQ1eTJPqXiYWG/76Zf6fgq7BUgYAUooNR/NP6ghSD/G/WYXkOub8pDzjhv
         UDaKpC09pv6Emh3F5fa7esdlqJ6BG4JMEHZb+ygL9kIBcENbvNff/qWZK8mRreW9nfi5
         eokzHuYnaB1K6Yl1+Gvu1+fGfMbR6jAbbzsZ/kjGRhv0LcLePlpHlwF+53i43HuHYZtI
         1qowYvltUZMl09UKc6uxtIneE/uV/Tk/krW1tQmYvAmoK377ap6/DEpCjJheXGpDAVAt
         7UYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8Jk0GmjgrXtKBhBbhpniU12178w6oimTYeJgi3oWngWsuy/qqfMuCQqu6qkvO3JzWCORyjO1AX1m0vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Xvk1OE27ogloe0nyI0C19oDHY1+tqK+d0F0qQV8WCUX1OduX
	Kn8P0gLosXveWNS3m5Ere0RSR8SareDyFGNdsKLgyELpLOiraVasTsUJnKceC+oxlU1oGH4IiNq
	dzmAo
X-Gm-Gg: ASbGncs7z/BiR/qPGoU90YU0aqm1hDYNsEVT3wBo1Rvz275wQHmNXHhzcc7yzYGD4Dg
	6Jl60/BmWEDutj2GNMHAKbCib/yYw4V/E5FjsJn060y4KvPbpdMLpqYUg4vV9QK/jJn6OG6mAFj
	S056ztAtOEF30neeERl3qWIZXMWmC8s599gQ5CkaAPKfn6MSILIVmesjjFrt32SqNmUcPwL5QPq
	XMkLHwwjm0fmc7UAe0o/wVOdaQms43oo7wJuiDH45mW7xNUSf4RpKkzOpWDIPKJaDVgOZxEyPKd
	F7MOi75ft4x3Heh6BwSrJ4jXHBu6w/mncFqZHWRa5SiEXtawg0si0h2fc6OzjlFLsgqmIzUfqfv
	npju7MhLFSCnMOfD/1+w+TeFWgyigaGl2iaT9ryKZr3J3pn0g9g==
X-Google-Smtp-Source: AGHT+IH/3MPqJbppieMudTvZEu9xzGULFIuPv/bi1cJR24wUpq77ZE0vkayExKCPrrLGQLtftIVxPw==
X-Received: by 2002:a17:907:3d42:b0:b3c:193:8218 with SMTP id a640c23a62f3a-b49c3936081mr1543747966b.34.1759763187618;
        Mon, 06 Oct 2025 08:06:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48628a6d90sm1177696766b.0.2025.10.06.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:06:27 -0700 (PDT)
Date: Mon, 6 Oct 2025 17:06:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Daniel Xu <dlxu@meta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: move nmi_watchdog sysctl into .rodata
Message-ID: <aOPa8RClyXaeyV6L@pathway.suse.cz>
References: <20250929-jag-nmiwd_const-v1-1-92200d503b1f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-jag-nmiwd_const-v1-1-92200d503b1f@kernel.org>

On Mon 2025-09-29 17:55:07, Joel Granados wrote:
> Move nmi_watchdog into the watchdog_sysctls array to prevent it from
> unnecessary modification. This move effectively moves it inside the
> .rodata section.
> 
> Initially moved out into its own non-const array in commit 9ec272c586b0
> ("watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe
> fails"), which made it writable only when watchdog_hardlockup_available
> was true. Moving it back to watchdog_sysctl keeps this behavior as
> writing to nmi_watchdog still fails when watchdog_hardlockup_available
> is false.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

The patch looks good to me. Updating the access rights was nice to
have. But it does not look not worth complicating the constification.
And proc_nmi_watchdog() works correctly even when the access rights
are always 0644.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

