Return-Path: <linux-kernel+bounces-891355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC6C42844
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 07:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E121C4E70F1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 06:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D82DEA7E;
	Sat,  8 Nov 2025 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZKepcjY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FF218EB1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762583276; cv=none; b=tFNokAN6mOR/maiqvcB8RCzTtAiRIsGSnWRY/dkuoa+e1IxmmjeP4+fSoQT+mKcG6k0361UqXYDk+yagRfrpmKf/ednarglW8q9hvYQNiU0RitnEmP6aPxagEsH5uXA6uuB3D36mMXTPqcOkw63Ti8mAlwQtpMo8cpwGdxQ72rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762583276; c=relaxed/simple;
	bh=jr673S/vviLKQukNOixc31tqvtS/AczogMM32DGArIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1VoCOCQrv7+QEwIgmgbqv0qEbKv/tsiSS0a4DeGC0iJE4dJivwSWoc2Uh82Xf5gycPJ5hQl0Eob6qRD46HwaVSBZ6CLaR29UTZC5fQWuhvaNL54qRfl7TFaSLny0yjwbHOwbYNRpF7vErlDZaMHtIshU634aFt3+lvaAOcHsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZKepcjY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7afc154e411so975275b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 22:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762583274; x=1763188074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muwGka20OQlgVtBzcQxGNcxf2dzVjpN4UKyUNjIPNwc=;
        b=SZKepcjYetbrflksISVaxJJHf1CrnLTtvLIcL4tSmgNg0P3xGw9h7y2da8CuOjrbFS
         MmEtsNZ4Rwc8I2zIYExj5xd9BksVkHQhQC0T89rMwFVeLEd5+VtnKiTVu+oj7jF0C+Qv
         /hJkFL8rBgkA/EW9+mRaIoe9qUggyjhTDprDXMzOYoHVZUF+AxHL/Fnzm/YTtu0YvM3f
         i0CT0VqD/CjPpJ2ZVfMekzFGNIsf6uD8/skISsVAck8/N5tsiJEgCoQQPa9PzH1eveMc
         4GAqyKtMqyqdeO3cITU04dkD3f0blQcmcxXAMmSJjXmEcwsSsJ3GIDb9SxOQcm6XfHYl
         ZQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762583274; x=1763188074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muwGka20OQlgVtBzcQxGNcxf2dzVjpN4UKyUNjIPNwc=;
        b=oVI6hMPvtibrJ2Xfw7NJGn1tVaAYL3wZfU6WPO69su13k14SaLsIU/+vJnUTkihzOt
         jl5ET5DKTPDty9UhViv+jqDqkPc0CKzi4qub1wJVonrsKYvU3exTBrYV7WSAZ54GTTSH
         k0Ddgr4r6tqnRl95GqcJ+lP6x8BlTFgYm6hUw4a4gmW24X2+HX0YZEB9nRx70QqmLBZ3
         +0iVY+OaUqfTFUOUMH3BfTCYwG9kA9JynTIr9Z2pF3kIe1VMooBsHqIjXVID2xzaocVO
         3vZyMynMxh+euYcuGP6w6jn9IH/8tLB+QITolYcSI4NyddfJfED9KYawQfzcmEPw+mY4
         fp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlhfU/l4u2KX8GAXzdnywRWORXV6TMld1PjWJhmCEvF416tZcNsePk159BI6M0FF1hXbFCR5rNOyl52jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygS4ujVSdwOqjje/dbHVqjDxNycdXCWdQThA1YqEP0an9EfyMv
	8kG9N037P2WRAUN34hlqoKDHENzHxxWII0+NdobPL2UG0zYDFI8UgO9U
X-Gm-Gg: ASbGncvlTFrw6SgRbBg4oWZ3fX5YjCd0ZC5X0k1KvPkxNxLdAM9mBVSy7M1DD3t1yXN
	6tK24ft6yK7miE5+Y8ccEHAQw0gT3+ZWpLpFLnE+AywdbjxgsCcXn6/2ohG/mWMrrRCZMcWRzaw
	bidsTc6vZlDR/fQ5bwgmsqzrE7jlucFk3+X4/zge3HFtleks+Z+SZIJJsC8dUwHvi/uhM5HXkwJ
	xeztIl6sUJndiwsxCAZBbD00PG//37PBntdo0MPV0uIHAP9aucLCE3i6pJxsT/sWkQprSKVhVpb
	7EoXcDy6unbj3ZUx5hkq8x07Bj15BqLtIJ4hh1JyHNYFvwKCMuZ4mJHDWxow/FHum7EG8QNEWXn
	rAVoZmzHibPaK3FnmN9EnPl8mZ2xMVCL2U6S9zp7JuyX+0ma7ZlirT0pIxs28uQhDlyhZXA91i4
	4rtTcV6Wxb2Dmkdd+7+U5rD/YgT265LjiVP8Thte6xbbtg64s7VlmA
X-Google-Smtp-Source: AGHT+IG9e2zFV0/4/rzvivbRQoaIRBU8Mc3hMcU/wOqZTUa7pTGvjX3/SKOWyYRT02HwuIW5Xkd7Tg==
X-Received: by 2002:a05:6a00:140e:b0:7b2:1fb0:6da0 with SMTP id d2e1a72fcca58-7b2276c0243mr2601417b3a.28.1762583273712;
        Fri, 07 Nov 2025 22:27:53 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:57b9:b373:19a1:a072])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b214155c8esm1532861b3a.38.2025.11.07.22.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 22:27:53 -0800 (PST)
Date: Fri, 7 Nov 2025 22:27:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: duoming@zju.edu.cn
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, alexander.deucher@amd.com, pali@kernel.org, 
	hverkuil+cisco@kernel.org, akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] Input: psmouse - fix use-after-free bugs due to
 rescheduled delayed works
Message-ID: <fyj4osf7b4ircqyn53kmpnvppr5cmkj7w53tgtgab6gmauprpa@lvlkypjstn4f>
References: <20251108045609.26338-1-duoming@zju.edu.cn>
 <jbkzqczxnnf5el6xxyumeyoact7iw3js6reoand3clrpjyyblf@fhxvbg7fu6n5>
 <15ef9eb6.22570.19a6221252c.Coremail.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15ef9eb6.22570.19a6221252c.Coremail.duoming@zju.edu.cn>

On Sat, Nov 08, 2025 at 02:22:10PM +0800, duoming@zju.edu.cn wrote:
> On Fri, 7 Nov 2025 21:43:37 -0800, Dmitry Torokhov wrote:
> > > The flush_workqueue() in psmouse_disconnect() only blocks and waits for
> > > work items that were already queued to the workqueue prior to its
> > > invocation. Any work items submitted after flush_workqueue() is called
> > > are not included in the set of tasks that the flush operation awaits.
> > > This means that after flush_workqueue() has finished executing, the
> > > resync_work and dev3_register_work could be rescheduled again, resulting
> > > in the following two use-after-free scenarios:
> > > 
> > > 1. The psmouse structure is deallocated in psmouse_disconnect(), while
> > > resync_work remains active and attempts to dereference the already
> > > freed psmouse in psmouse_resync().
> > > 
> > > CPU 0                   | CPU 1
> > > psmouse_disconnect()    | psmouse_receive_byte()
> > >                         |   if(psmouse->state == ...)
> > >   psmouse_set_state()   |
> > >   flush_workqueue()     |
> > >                         |   psmouse_queue_work() //reschedule
> > >   kfree(psmouse); //FREE|
> > >                         | psmouse_resync()
> > >                         |   psmouse = container_of(); //USE
> > >                         |   psmouse-> //USE
> > 
> > Before flushing the workqueue we set psmouse state to PSMOUSE_CMD_MODE,
> > but psmouse_queue_work() is only called from psmouse_receive_byte() if
> > the mouse is PSMOUSE_ACTIVE. Therefore there is no chance that work will
> > be scheduled while psmouse instance is being freed.
> 
> I believe a potential race condition still exists between 
> psmouse_receive_byte() and psmouse_disconnect(). Specifically, 
> if the condition check 'if (psmouse->state == PSMOUSE_ACTIVATED)' 
> has already been passed, and then we set the psmouse state to 
> PSMOUSE_CMD_MODE and flush the workqueue, it is still possible 
> for psmouse_queue_work() to be scheduled after flush_workqueue().

Setting psmouse state can not race with psmouse_receive_byte() because
we take the serio->lock and disable interrupts. 

Thanks.

-- 
Dmitry

