Return-Path: <linux-kernel+bounces-886722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DFC36665
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4DA3A9586
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C6233557E;
	Wed,  5 Nov 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TP844x3Q"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72741335579
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355810; cv=none; b=jkExJWRtt65Ty5b0V7bZapb4lmdKl6AFeZ0ioNlki+qGsQptGx3gAq/7FbuIV/llbNWUiFg+ugvwOSfxUGEH9uZSCy0A9/gSX/MS57+e1wFgNf5WT8mKGZyyCPhx5VRr3onvTUuusREljEPpB4/doLhu8793ZVHbrVlSBHjRxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355810; c=relaxed/simple;
	bh=KRJgPeOHt3J03w/6SwMYkig/uxN9MD1qS/4R3ANDnHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYQkt6OB+FWg2mQCYKsKkMuRJG+BWY9TjeQq1H5tQqbR1zHLsd/sqfxYzytpJ2tjMulVarT8o9LjaCNUSo924oKGHg1HJ4qxTTbztIR3FT8PInUv8GyiwCPfjdCWuO+1Ze/EzI/PYqNvMm5ukCT5REZ74XrFktFPTOhU42uC8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TP844x3Q; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b9a6ff216faso3414142a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1762355808; x=1762960608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNgh7VDJjGplpkdhRnu/Eqvj7iQH18Iu6DdCKwBsoiQ=;
        b=TP844x3Q+YXsoekbAOE79lKdAoYsUqkbK9fbysndslx70YJ0NAZXa1NiKB/18XxiKY
         AoB15ZRm8jHBH8LU6sOvEoM4fsaiDWbRhXQS/UOT7eDSZ/lJ+VGObX5YbXv3kLXEoyD+
         imUKEVXwPDyc4iD7TvoUNZG3wHiGmSRsurphk3UcyD3tCTc88sremPUqcnNfRs/H5SPq
         DSn2Von5iK4ELvGHFz0gsJKCxew8BT8f6Gn5tw9fLIQ43VQ7oUP7WEzsiN1nqhic8mIV
         fZr6hyQRQaXgsj+mUmN7gxMKMZddKaOyzg0MezxYSGOzzG23dBhITRDAIC4S6XQMfQ5U
         r6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355808; x=1762960608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNgh7VDJjGplpkdhRnu/Eqvj7iQH18Iu6DdCKwBsoiQ=;
        b=KYFABjRgfvre7WSrldOdHVU6w5+UTMoQkNzWQs44kX1ijjwrQQl6NP0lGcfpUwhiHK
         xWVRsXfrHDzdEqvr/uKLJDSzsTJikcvKKKhtA5V/Bp2yovwdgA8LweCcTCb1wUN85RiZ
         U0+hu8l2Yxi2HEZN3naZaNIZG4IYo5ZpTvX/HkUNccNGyYk3eYyIrI8Kdt2E6jPq8F6b
         6/3JcSxE4V2HxEM2MJY+uR8dCmZbOz5Vsu5XBBfGQ337JYjdrd6K0z3XEr5TkgJkvX57
         UdqMClpkZAH7E5iFLCKBJmRdNcknZ5RW6OUqmW1kQu2FFB/u+R5yIXiQ2HFWgGkNbJuT
         Gn/Q==
X-Gm-Message-State: AOJu0YwnmZBbjDzKlJ9LWsiMoFIP7K2S7mogvDz9fyYDVeGMna1ise34
	3CYexLQ6uOExc9kLiApDz6t+ylHMUGYll/IDcJBA0xhU6Pxm75W3PFz1WGOwQJ6dUCE=
X-Gm-Gg: ASbGncv2qaRXKQ5Sh+vyM1mKv29kxuL835A0t4n2A/0SAgtqxfnsehNFyDzCDSYu7EB
	gTKUNuB4HWX3KZTrvR7EapKXwz1Io0reQZYaOgFOyOE9LOG+IiZ7i2aXCKAHc/MOTT3b5Qs7XLx
	rcWnSJqYa2K+aH4iK/WBtJpyfjJqYXhDQdRlRb9drZXZZjNZvPw9qGD8rOyph+AQ120R5jURMnp
	vxo4uIUq6LaETrInb0uMDIu1JK01qSqUFLX7UZjMcpzPuMaVrYHEtYWYHk25X6T0/nN/DNc0hS/
	kNrOYRC0SzugV7Dg1GS8uDZMyhXTPsB0Cs4On/oZkawrO2/CMjz1X0pQxRMVpjIHeYsGECLxy8R
	q45pH9nxKHQue1Wwoo2zF/HSmJVjqRv9YbtOdus3Sstkl4zonDZ9PrAaTN8rqHy6TMjCjMWZC+D
	2tzQ==
X-Google-Smtp-Source: AGHT+IE8KEN6/YjrDFxvR1MIXgw13QYDHUuajCxoLrCwX9WWh6x1izsDp54esjj+82gaSFd9WLgWdA==
X-Received: by 2002:a17:903:2309:b0:294:f6e2:cea5 with SMTP id d9443c01a7336-2962ad95d7emr56626715ad.28.1762355807550;
        Wed, 05 Nov 2025 07:16:47 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998d4fsm65017065ad.43.2025.11.05.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:16:47 -0800 (PST)
Date: Wed, 5 Nov 2025 07:16:45 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: DEBUG_ATOMIC_SLEEP spew in cgroup_task_dead() on next-20251104
Message-ID: <aQtqXfMfy8SWjS67@mozart.vkv.me>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQpUY7fEp6_ZqGel@slm.duckdns.org>

On Tuesday 11/04 at 09:30 -1000, Tejun Heo wrote:
> Hello, Calvin! How are you?

Still here. Sorry to appear only with problems not solutions :)

I wonder... how much work would it be to make the debugging
instrumentation throw a splat for this class of problem without actually
having to compile the kernel with PREEMPT_RT?

> On Tue, Nov 04, 2025 at 10:11:14AM -0800, Calvin Owens wrote:
> > I'm guessing this is related to d245698d727a ("cgroup: Defer task cgroup
> > unlink until after the task is done switching out")? Is there any other
> > useful info I can provide?
> 
> Ah, I need to make css_set_lock a raw one. I'll reply with patches.
> 
> Thanks.
> 
> -- 
> tejun

