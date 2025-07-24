Return-Path: <linux-kernel+bounces-744228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B4B109D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8114DAE558E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B32C08CC;
	Thu, 24 Jul 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw7x+ypb"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9BD24FBFF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358442; cv=none; b=bmM3km6QkO0C8P2tW5a+yalJ+nxKahHQnFliW5SHSII2+pE/1FIOWS0ZE0tc3V83h4LgbPdmZqwkcUonh4qKLACQJzaG95IrcRQlgbL8+paGJ+KwoOvkJCW7J+f3S03mgRoiY1fqHcO6zoX3uOUNhwnmWFZQ7TjdRhiVSfivkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358442; c=relaxed/simple;
	bh=wGiIiRAIDkig7sxg1xtk3QqmzHhGVY0/EmsPGPBKEyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy3iftXkLtFjSwSz6eGvEnkwTGZhdBv6MNnBz9GsA/ThjQShGcaJj0hELM3p1oCSwTPXYrQlb6MVk6NvE/pbNY1n4nPMMAkI9G3miis8Vm82fUjB7e1PSQ27/atpj5rV/hG82U5eu2QT9kNEPud8nBP2j6Zk0NhYa5qqzEz4QB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw7x+ypb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so10324885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753358439; x=1753963239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EINZOXVlzKHZGGq4O4rIz4L+9+YS3Z+ducrMiJrOlAk=;
        b=Xw7x+ypbLLHYdQIn7zVWrotslFPsohuK0hF4uzYrPam/2+lPNqFGj2dJTIsJ0hA2Qs
         /5zNhcU/VkyLw4xmDeTrkp0iPNVn7ITnyvQdsQFgpiXSx4BgtdGw10gB6EEyVyRhPg9O
         lkjq4AOV2MJnwxOxyWOueqCeRLDln9GeHsprbW+o8pXZRV0kl+mBi30AnI5gda+OA7WR
         EYMrwbPnBgT/GCDKhHk50KkWLwtSaPrdlG0CJDBm+9HqT3x2G06IZ6siUj98MW42WaZU
         QBWJp6sNztmAxveVU7ZfQAGUp1+0WtmCTpAFs0QFjkUTtUJP8c9AVmLQJtP00KJP6exq
         jOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358439; x=1753963239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EINZOXVlzKHZGGq4O4rIz4L+9+YS3Z+ducrMiJrOlAk=;
        b=e9y2d2SaboBGqahnV0igfhWltzDIB8KAx3+JTOcm1s2Tw3LPAS+Lp5QRA2YrrMLnQX
         LUWCMZSIYqUPdhu19w772u9B/Rmo+2Oez3+VW3DkzMz5G+y60vpGEACRrBYMIqofgWl8
         q+ycYraiSDgqMEf/S+vdLcjANLJBgTiBd4ue8XOdqqv/sIUeS89s4zrSsyz+bFnTxmDY
         rYfY0+0sINib4ukIdDaF9UfBj5pfcHhMsdPsAxNt913rfNyGNXJbQO6XKyypQIgdB9EM
         8ZUaNs2YIj7ypD9AKFdZtVlcENrz2WuJdjsxmN56GJ+zRyttRibI6RC7ohYb8XT4plTt
         nY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5KbR+yR7db24vosfD8vgN+daD2N/XpdCCx2NF2d5wY3A6+ANCFJPeLbvIkf9ziM8qSQLHrIWNVi25gcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwBHtgFpZ6JlBgi5KKxIUxKSr0zV10+95gbTJxMLgFI9vAVBb
	R0nSHs19A/u2i496Bj8+qP1aB5JP6nIJ4FqljY5NKz9Joxza/7H0blRb
X-Gm-Gg: ASbGncvsdO5MISL63YE2WajG/WjiScoC3i+f/XiBP2a8PcQmPl25gxm4t90Mh0NvKPs
	geRRv1BPaFW6jg2HjJ2m/86YhhskWyU4dwF5FTzJDUiCtwj4a5uCVdHks1vHVOZMC3Ppsq59OgG
	X493y2y63VKg9TAHLu/eic6Itbd4HhOe+/4Ujy+8apyKDCgOYPyYVHF36A942Gnxw+Zk1QcsDlT
	OwyNs/oB50GGtZkTm539j+BQs0Ow8b9EPO1Rum2re5GOgQ6DxXP2zeH6sFzbwEwwuXVLv3fV8SD
	XeUlyQ1tPUFk3vp9Mh5TLCCx7jCRnUzkOOCUAPe73mhq4muiL9DtbTahBcf0qqXoD0UARzxicki
	g9QRM09aMUNWAuCRIYbmgX6KoOtgAY1HStYJxq8QWPB/fhEjDQ3w6JYNGfGt6
X-Google-Smtp-Source: AGHT+IGr5gLnp+t2zorbGJJocajx56mOkDi7xvJeKiramoBLhLHRy8yVD/VTL2ErCgecBgFDX0vMtg==
X-Received: by 2002:a05:600c:6309:b0:456:1a87:a6ba with SMTP id 5b1f17b1804b1-45869dad525mr51445545e9.33.1753358438530;
        Thu, 24 Jul 2025 05:00:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bccc5sm17738625e9.22.2025.07.24.05.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:00:38 -0700 (PDT)
Date: Thu, 24 Jul 2025 13:00:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250724130037.1ae77797@pumpkin>
In-Reply-To: <20250724082547.GB10980@redhat.com>
References: <20250721130422.GA31640@redhat.com>
	<20250721192053.58843751@pumpkin>
	<20250722105034.GA2845@redhat.com>
	<20250722130947.0c97c96a@pumpkin>
	<20250722132147.GB2845@redhat.com>
	<20250722230341.5a1cc5e5@pumpkin>
	<20250723093825.GA12884@redhat.com>
	<20250723224831.4492ec75@pumpkin>
	<20250724081125.GA10980@redhat.com>
	<20250724082547.GB10980@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 10:25:48 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/24, Oleg Nesterov wrote:
> > On 07/23, David Laight wrote:  
> > >
> > > On Wed, 23 Jul 2025 11:38:25 +0200
> > > Oleg Nesterov <oleg@redhat.com> wrote:  
> > > >
> > > > to remove the conditional branch and additional variable. Your version
> > > > is probably beterr... But this is without WARN/BUG.  
> > >
> > > I wish there was a way of doing a WARN_ONCE from asm with a single instruction.
> > > Then you could put one after your 2:
> > > Otherwise is it a conditional and a load of inlined code.
> > >  
> > > > So, which version do you prefer?  
> > >
> > > I wish I knew :-)  
> >
> > ;-)
> >
> > David, you understand this asm magic indefinitely better than me. Plus you are
> > working on the generic code. Can you send the patch which looks right to you?
> > I agree in advance with anything you do.
> >
> > I got lost. Now I don't even understand if we want to add BUG and/or WARN into
> > mul_u64_u64_div_u64().  
> 
> Forgot to mention... Not that I think this is a good idea, but if we don't
> use BUG/WARN, we can probably add EX_FLAG_ and do something like below.

I'd not looked there.
That is certainly best if WARN/BUG is deemed unnecessary.
(That is the type of question I'd defer to 'management'!)

> 
> Oleg.
> 
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -38,6 +38,9 @@ static bool ex_handler_default(const struct exception_table_entry *e,
>  	if (e->data & EX_FLAG_CLEAR_DX)
>  		regs->dx = 0;
>  
> +	if (e->data & EX_FLAG_XXX_AX)
> +		regs->ax = -1ul;

That would need to set %eax to a 64bit ~0u;
I don't think the above would sign extend the value.

Makes me think - always bad.
I wonder how hard it would be to implement EX_FLAG_WARN_ONCE.
Mostly it would need a writeable bitmap with one bit for each
extable entry.

	David


> +
>  	regs->ip = ex_fixup_addr(e);
>  	return true;
>  }
> 


