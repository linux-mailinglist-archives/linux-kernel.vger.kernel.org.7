Return-Path: <linux-kernel+bounces-899153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD575C56EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8437A351B66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60669330306;
	Thu, 13 Nov 2025 10:37:27 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15435CBAF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030247; cv=none; b=DS2pLfYdYyLneWR4wTY0Yco1voRtpVbaNRJ+TDv65QXT0DmwVKY+h7DKJNQyi6Sv98K2Ag09m3qRHxTXtibAUbF9ub44+8jUH6yQuMJhMX/M2zv+/owavif6DmMjrKCjuJam/9wrXabS9mrouUy6ukhznW965ljrto9XpuG+0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030247; c=relaxed/simple;
	bh=p6X7mpLqRdJ41IfQWmXQUaFJIIzN+K9oUxkNkxRPCFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozgfvp9M0v2CIiWnN2FJwZLmXGcIBLXAOSgL+AFa8O/XWAYqUNzIagi29WezX1Sk30c529XNku31IaSvr1x0oJmtk8BZAygF15XyCoBqoyJRw0qH5AP5ZoCPta1ymuoXXcacNybGnCUcXegsDXUqxTRbMDqtUfoCX8a1fFTFdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4503ee5c160so290226b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030244; x=1763635044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9X7iTrE54YvbjdjoY+sM5rW8UTYJ7bZtGLvp7X0Czrc=;
        b=I4jbVK4wFiUI2XzYzzzI2O9vUVN/Je/9EVmNggKnI/3sYIwBXgKSqoRwe+Bw3ZLqo8
         TxLnv8VlkYEREe4wuGx4mL52ROttniSDxXivhHsSIsVDbzgCNrtJ0YBqNT/7N7PIE2H3
         iX+KbutpXrQiKc2Fn3UkYVtbX21j3gx6fe8zaxyWPb0M2CjRQ4VYyZqRyf/stJCDw1yR
         frRfgGKkpeKD+Q3i7byLJujrkAxInSd46ePyJqjlPo4pODnsHWsBfWAztKmhZzmmyPsT
         TjZvZwp6Ao2ah2rqS0lzN6OjTI2OllBGea2YfX/0Ai0+uyb9x23wkZMioljNcKyYf/G2
         2zKA==
X-Forwarded-Encrypted: i=1; AJvYcCUkF1HA6fJWNJGh7qp/6NX0gyCGWir9kXrWMoHXz0VySL1AUGTwAMVmU4u3FfvWlBPrkRe5KmvABTRyCvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIacEnwY6nNGTC6aPkA8JM31CGqXe/JNKr8DirlQe+mRJ3Rhg
	5JCB8iWZ5mf02d7bpcl1kS3Rfnur18OcOqnGxvGi5KhyevKMyCSap7gS
X-Gm-Gg: ASbGncsPoB1A7uPnmBrVPojMVH3V+W0X13rRoGNjsN5987mmiwU6BPTpZCWk9ffM8TK
	9rT73PEU/qrnMYWluMMxVHUfSXj5iUB3eO2Qp0uZxWD1LdK2pQqllEBozdsj72HC8WxwyYrmlxL
	U5kiicG/YLJGLcC6EGA4lvRoArzUujAsvprHesL2QG2y8Rpj3i2byMG56KaTvFluI84/Ok9n1U8
	khTDUvmrarUzeQN/zonfW+Ms2xtNUnl/k2QxUvMZMa1QTsdts+Kj4QtbTftF1X72VvscnaBtsYo
	1SawUZ7emvOBPsrCWwaSegNE51crYBs0S7meIl6OxYFEFnpgcT0cMrecV212NhGta+zMgLRczww
	FaPfMyN6zDtzUQzdfNi6P/SJoUxSmPzQCEU4zmUzTy4d1r4O96qddXzeVrX9nKXz1ZWhe3hhalo
	JGbkSjmRyHWuuTfg==
X-Google-Smtp-Source: AGHT+IE/f6sikSSSQxq5UoFZC0KflDi2CwXhInx9Gf6bYjFg8swkwTEGM1fl7p9fobc8bv67Tx2JyQ==
X-Received: by 2002:a05:6808:c144:b0:450:10b:a53a with SMTP id 5614622812f47-450746aa372mr2852284b6e.65.1763030244344;
        Thu, 13 Nov 2025 02:37:24 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3d420fsm896950a34.30.2025.11.13.02.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:37:23 -0800 (PST)
Date: Thu, 13 Nov 2025 02:37:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, oss@malat.biz
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	paulmck@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: arm64: pseudo NMI bootconfig question
Message-ID: <wqzhgeu5vlkeuomajvy7vf3x4gf3fsnzmczmkswvjo7xdyzzbo@6uqjqftbzgot>
References: <rs4igmsjrm6r2aio4nbe5jos3vcqk2u4bjhltjwtj2pn3cquip@kv3grgec7qrb>
 <20251113133403.308046d2df1c97ba7dcd2388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113133403.308046d2df1c97ba7dcd2388@kernel.org>

Hello Masami,

On Thu, Nov 13, 2025 at 01:34:03PM +0900, Masami Hiramatsu wrote:
> > I wanted to have pseudo NMI enabled by default in the debug kernel
> > (without relying on kernel command-line parameters), but this isn’t
> > possible today. The reason is that `irqchip.gicv3_pseudo_nmi` is an early
> > parameter, which can’t be set through bootconfig, so, independent of my
> > .config, I need to hack cmdline arguments to have the debuggability
> > I need.
> 
> Yeah, that parameter is for early architecture initialization,
> which is done before parsing bootconfig.
> 
> Can you try building kernel with:
> 
> (arm64)
> cmdline=$(cat /proc/cmdline)
> CONFIG_CMDLINE="irqchip.gicv3_pseudo_nmi=1 ${cmdline}"
> CMDLINE_FORCE=y

This option isn’t practical for my use case since I maintain a generic
debug kernel that needs to support multiple workloads and services, each
with their own kernel command line. I’d need something similar to the
old CMDLINE_EXTEND feature (which was removed some time ago), or perhaps
a mechanism like CMDLINE_PREPEND or CMDLINE_APPEND, which were never
introduced.

Another possible solution would be to load bootconfig earlier in the
boot process so that early parameters can be defined within bootconfig.
Petr suggested this approach some time back, but it doesn’t appear to
have made it upstream.

https://lore.kernel.org/all/20231123194106.08f5832f558fe806b1fd8098@kernel.org/

I’m not fully up to speed on the details of this change, so I want to
ask directly: Would Petr’s approach—allowing early parameters to be set
via bootconfig make sense from a bootconfig design perspective?

> BTW I wonder why you can not configure your bootloader to pass it.

The main issue is that changing cmdline parameters increases the
confusion for users, and updating the kernel command line isn’t simple
in a heterogeneous environment.

My objective is to provide a drop-in kernel replacement, so the user
only needs to swap the kernel binary, gaining additional debugging
capabilities without modifying anything else.

Additionally, it’s common for the same kernel version to be used across
different bootloaders, which makes distributing and installing debug
kernels even more complicated if additional changes (such as appending
configurations to the cmdline) are required.

Thanks for your help!
--breno

