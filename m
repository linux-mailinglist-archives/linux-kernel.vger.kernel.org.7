Return-Path: <linux-kernel+bounces-883465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB841C2D854
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 125104EA16D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921601D63F3;
	Mon,  3 Nov 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/S3guJ9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F613D503
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191926; cv=none; b=E6Boaa7ieMNRk3QX3RUq9mkpr/MBackif8q+8RcUx3yLR/uY798NuXNE1Juet2pySsQb9LhtXQ433O8bp+i8NLv2/vr1lT2otBk+reYU1jm+zhZdlcSoxOxglS7SYx1JO8jy/1EdlW4tq0T5gMRhXLQ1tekeIj/7GzaV3BO1Ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191926; c=relaxed/simple;
	bh=lPzxmPWkKKlL56a0yA3jmqyHVglIIZ8sGtfuWP9LymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfzWFpSl1dIuBq75In/DaKtI1XrUDx78zC59sjfyxK/89yZWNROqVJfN3H2sfHTPRV4eesOEOtrsEHjVXwgRo5qh8L/Tw45sfYeFseEN9C0oH1oNDUsqK1KNmmuooBruRZqtUWGMCVrjMYI6TvReE9fNWt2CcrzcNcQnXatA2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G/S3guJ9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7042e50899so802667766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762191922; x=1762796722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjhEEmFz/bm/iYe2xYA7wYjyftdhc9sgCWZzWyyshqg=;
        b=G/S3guJ9tN+cvrwKUW1TYLT4oM4zVRgIyTEBk9Rbcggos9+Rn72UnH/ARhY0Doby4k
         aUAUjH3Y/ae71aKi52IOnD7hpaRE1oUTxUTPAwvZSx22WR7WXzHK3U2zAZjyJQEaPidx
         yJUC8XjuiW7cTyg1CTG+a/NDMN8GM9oBGAxLHwOG9ziLd/Ktwn/hm8REAvtueClysGdp
         yKsfR2MQDRdSFPVDT8COJlxFLL1IXK9gwbdo+BPjLkefWQGyNdw96984H1quqxB91GeX
         Clg1VgNj+0vsTinbhs/KKJqNp8iFa/0eF4azSaQMJLySGhVueSflREzZFVD+a/QXzuQR
         s+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191922; x=1762796722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjhEEmFz/bm/iYe2xYA7wYjyftdhc9sgCWZzWyyshqg=;
        b=E9CsBLFgLpCPJYcr2jnWf+jhOSLV1UUqy6YKze14zV3L4Z6m/zGCXZJZ0uJo3y3yXE
         6EAwYBwevOWdYk3BUoY4LePPDwCcuGJQeDtUk13htn6lLPGERU4DQSkLvg59d+9mD2tq
         jjq/pNS+OWyFnabu/FwOg6r1ZVuAm1rpwFW5VZ9nx9blk24GYBK0GoIFZfr+tTA+nM3f
         kweoZfPfObyiAuQUzQF/0KKFe9nOaMOKOWia5WS7nvAII/RCpuqgL5GrOLha1Ywt6D/w
         gWWWD1Vxp85SGhHMMzIrXjgKkmIHlQm6qwNaKxFWVlYhhG1P1axh+WWIecBt0ZfR0ydu
         dbRA==
X-Forwarded-Encrypted: i=1; AJvYcCVZSGBTe3JZR7agdB2F316O3LzkFJurJAQdp2HVK40+oYp0Pja96RStwum5ismZg7bizxyyDvG+fTCdUyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/66/EJVnhG/rSXJUSeekAXH0Ken4GzDC8qetoTUL08+1ZcW6y
	S3b6hTbvPEhWmuM7oPP5SSgBKWUZlhHYgDCUz6wkOyjPCYltnXUJ0TIr2Bz6iRtISBc=
X-Gm-Gg: ASbGnctzu2dNNWZ8Vj26PyNDge/rE72Zr0pxzTjAOiX/sFoRZ8aWDgQX7s0x48fk+8m
	El/a0D0KKq66VQa92IIi2AwmBVZOttcQMEPfylawPAlR1BNfAbEVM2316JPa4ORn9+VV4MhDDAD
	zMUqIBfSKPQDRxfJOCcZdgHOiBJNpAy6rARQnK6rU+BVBvBmonBc8kL+Bwq6eRpMvv5bwv2IzQz
	jWhfQXH9p6PhJ8TTA1xLYle24T1UbItkICNvKDJ+uWHH3jVIgD7Zek6iqgO9AZNHiFTCYJkBfUY
	B92CbScrj1yIupz7Y6HZCI2VgGczgEa3BQIu+YO4AMRrq+E4ehh+jqoBw2W4xFgPKyb6Z0jyy6G
	zI02VVPZWKB0n01WFUTyt0f3YqUHYCPf2V3dbvNSHnxCHAcSk0d7pr7hyw4ZZVCjeOeV4vI/Jbn
	YD1Qia/6h0ZqSF3g==
X-Google-Smtp-Source: AGHT+IGo5tJKewrI4RaiW9B0KqjqGv4KjNOjijo3dJIfIFw9bBjNUSdfnkNr8uqL2+pKOQTmyq7C5A==
X-Received: by 2002:a17:906:f58a:b0:b6d:babd:97a1 with SMTP id a640c23a62f3a-b707061bddamr1409156066b.41.1762191922249;
        Mon, 03 Nov 2025 09:45:22 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1076420766b.13.2025.11.03.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:45:21 -0800 (PST)
Date: Mon, 3 Nov 2025 18:45:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] lib/vsprintf: Improve vsprintf + sprintf function
 comments
Message-ID: <aQjqL7t2WfMfq-3B@pathway.suse.cz>
References: <20251103090913.2066-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103090913.2066-2-thorsten.blum@linux.dev>

On Mon 2025-11-03 10:09:13, Thorsten Blum wrote:
> Clarify that the return values of vsprintf() and sprintf() exclude the
> trailing NUL character.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

JFYI, the patch has been comitted into printk/linux.git,
branch for-6.19.

Best Regards,
Petr

PS: The patch was trivial so I was not waiting for any additional
    feedback. And better to do not forget about the patch again ;-)

