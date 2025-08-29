Return-Path: <linux-kernel+bounces-791870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E54B3BD17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724011C866A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9431A05D;
	Fri, 29 Aug 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YjPlQ3Ki"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD62701DC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476242; cv=none; b=cUNaUxq0iyiQuNZ7Z0LCaq9xOeN+1+q/dc+sDJzERJi+PuyrgdLS3sWx4JpExtHTU4B4lheUF1wiil7NmgkJfQJIrBp766O79rGqnaS4TinlHbsvfSks6y9sWKeB86JQlnyURgWLZXAPmTVPNJSCd2lAuUBeLNsxzwGZgmueWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476242; c=relaxed/simple;
	bh=BKtwzTVws+GlX1U8hYHvrnuzxLWlwSNrMt8x+/6N9MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZLPTDnOfjLTeiuTfXVHmaFIM3nn5p6Dq0RKMlqcaccrfswOhy24jU2cnLEvD9XFJ30d318wRQ4XD7o75zh3x6kjiAULLhrC2iM7XAfoLvG9FO6gYupSE541sggqnSDJDfIdPoVUVeqZZJQ8wJOxMswMu2i/KGh6vmBOxSUvyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YjPlQ3Ki; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so5973044a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756476238; x=1757081038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Flku/FfqVL4tI6qgngPLxQJOqs/mCsrPLjGqczpSXU=;
        b=YjPlQ3KiswZJneyaa2hBstFL3QrVU9zqFaSGLF2fmfo/0hiXZNtNN+DFH+elCrD1/Y
         qxrhRJorMpbZgdWg2MPrK+2tYRmu+TUKfHnHRhP0bTzHy1R8OMfoJXeWvQ0y+f1/sXco
         FsPBrx87tXUUGw/xjqFweJ5TGM8/xspMCeLRffgcobGpUpYX7uq1pnMGIXIg23iFG1FK
         svfoYgjpQ5hUHkQRakvB7pnAyHAkPkdzpNnKZu60QahDBObS6ktLt1ScG6u2zLKZ/w7Q
         O1Rra5N9SASYdIi4xAXBENwu36fpUBj15I2wYXxJj36CQHS+dBKNLHD+MSSNuIomQlB1
         e9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756476238; x=1757081038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Flku/FfqVL4tI6qgngPLxQJOqs/mCsrPLjGqczpSXU=;
        b=V0E+IH1l53iCC+vbVfWRsN9RPfG0ixi9Jhw6FyBAjj0pd3XBVStiAhlTLfeTwuwK2/
         1kOZp5ZQIENJAcBEECbgyj56eB1S0u8IZ4042EGAqdie2g0qAvPcYSQwWvnP3GaQv222
         Wdp510hMuoo5kT+vRBny0DnQxU1wjojjM6hwkRNuaUHIeRjzRKDXAcMyfHyf/V6jWyYk
         ziqLj4OxKK17nC/Y/eEc4fFGWpZIYqZqXrZhG1AY4MaaJJ9F2/FGHKRoQxnKL9pamNfo
         YL405Kci3r0Zk9iE7HMXhaZDDF/MhVg8EfkKvpTmYwvIZ84t/7qEzNtkBwWIuOVI5t/l
         DkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvxhMIUBgWSFKwHRBMddp5BOyuIZZIAPd5nEQPXBVBk7qrk1D70TdspfVm6eS+bjKFHYlKoQv6CaZKvgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPoTaLvwke7exZeYueLgAzWvlr6pClxawF18dAQEIV1W1TRj9
	CO69pvfBUauyvkoqeQ0h2xWy4z9ASqc/SunE2pdAflLO0rycJN6nZSALqxeqJDqQmtM=
X-Gm-Gg: ASbGnctmgaGJ0vWOKlGrKKBMPrJqmO5sFINP1g0NWN5gBBvNj05vrfM/eF9xA8ExRqE
	vPK4wQngzaqp+77uUc4T3Dio/bCMpKkbCyJlZQbZJ7OdluE7WiZ+l9gUXxiC3lANPV659Z3X4C6
	qAJKnB6aE9d2mdnj6y9EAcP8WRMHG60l/NM8xcIr1iBsgaWFDFG979lunu44JSosl29JvYS7Gxi
	ZUCFt0lI8TTJMul6s/74KKCIQKyByxzpiWXBUzfAchjiOBXwpo3Yd9zOQvJryd2hh/tB5eycXp3
	8CRdZ9a5Ehj8iSZtPcg6LMO381L7Yh64akJBYl2a6CrccGDAuZZRcdBedPjuyCNJUiRTVEi/It+
	36tMHZeEkziqj5r8trCVyT3aLdg==
X-Google-Smtp-Source: AGHT+IEJpCcVBGwLT63uR40OqtpXMTDym64sstxy0mkGNMJ/UmQe0s4O6ji+pD1mM5wqu9huNMtrMA==
X-Received: by 2002:a17:907:7f0f:b0:afe:ee36:2eb8 with SMTP id a640c23a62f3a-afeee36354emr509518966b.8.1756476238350;
        Fri, 29 Aug 2025 07:03:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff16b57124sm22088666b.28.2025.08.29.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:03:57 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:03:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qianqiang Liu <qianqiang.liu@163.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] panic: use angle-bracket include for panic.h
Message-ID: <aLGzS48jcYX_U0FO@pathway.suse.cz>
References: <20250829051312.33773-1-wangjinchao600@gmail.com>
 <84349ainse.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84349ainse.fsf@jogness.linutronix.de>

On Fri 2025-08-29 09:40:41, John Ogness wrote:
> Added CC printk folks...

Thanks for adding me into Cc.

> On 2025-08-29, Jinchao Wang <wangjinchao600@gmail.com> wrote:
> > Replace quoted includes of panic.h with `#include <linux/panic.h>` for
> > consistency across the kernel.
> >
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

