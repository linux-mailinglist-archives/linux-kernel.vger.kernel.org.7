Return-Path: <linux-kernel+bounces-799056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88DB4266D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A647B5DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02362BEFFD;
	Wed,  3 Sep 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdNCYioA"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAF2C026E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916122; cv=none; b=pFcFtMcIdNQO1DbF/+DfNg0TMxxWaroHBbNkKqbNFsiUQgU9hOFbggyxCViBvdkdCGbyx7T+W6nhELrqReCLAS9ZhjSCYW4CBS/AS9GmyIadYQmzG9fg6T1IywyBGWRTZzrIAwWRl3xJ0oNNtOgYCoXAwyDjEUdwZb5GaSklL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916122; c=relaxed/simple;
	bh=4XUfsT2gmuBg+RLqMUsjIH4P8SSRTDoGWKRp4FELTfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAMQGwBKQMg9YhbrGONH2Etl1nVGcLsmJ3yZagHmfTJsUiwgQgsf6QGYx2di2Ihj9ovDegRTiBo5ZOmRHnZA26oX8GIczEo1dYOt6SLSQsHOfIAQbqmSOKExj1Azv+65g/OQGI7c74TFVB04XyxsVoBzLGSEPw6M0U86jJEtjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdNCYioA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5552b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756916120; x=1757520920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+3qogajRUwV3RdsTyjekkc7GT/6D1fOxq8Rop1jHZ4=;
        b=gdNCYioAVh3reT6dqW1fdzt0WG1QCm34DjI6ChPhEDCAWva7z+9Lr/lIcjcGzv9kTl
         PuLug9R8hMY9WjbF+99gMKC315SGaTJXmN3hk12dLrAQR27G2aMqkjJoyOpU3JRXBVAQ
         bTcW2nfAIWwjkg4yp/L859qt+GakKNozDWkOGDBCs9Mj99vJL0tiSvNtv+ktxzGHhPC6
         OPMM5dp/tRj1Iv+WlilDjoApN5fRGsxYUj5o+NGF1wDpabicUGxwM1R02VTsZCP1iNES
         VduFTvukl7Pv8GLriOpWHSig7cF0hVVn/vA3Xo7rNm4bxM0duOgV/C4McQKVYKZfdi4q
         VPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916120; x=1757520920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+3qogajRUwV3RdsTyjekkc7GT/6D1fOxq8Rop1jHZ4=;
        b=ifLX+JJzJFfU5dNGIk3YXtYlPUD4FN/acRPMkrPLyyz8LCwqdZ4cPgiXFwAuGTXUNr
         /UZFz8dlOedWw0elRhU3fxJuU/6/d/ZdTwaofb0dj8AIBtRkWVBVo8GmeQwV1FRIfiej
         XOatEsBw6/DD0RplbomBS5/D7RdCmvP0TbMBqPbkW1o8tAc8g9QasVuxvim85p1BrTih
         yS0eQZAK5cRYT6tK6uJN1ihfp8s3fP8TXsFnr8ZK90113/0bwuJhzXNZ4IQtXDPMdG2q
         0QRB9T0z50z6bUooOn+FH6e9FweV7KqyIifgLc7SrPv3f5Wfm92qxw3GzkwkMr73AFkP
         mlwg==
X-Forwarded-Encrypted: i=1; AJvYcCWnYP/5b3JP1+Ztg6veKjE4tZM6/tzaX3iA4Qsb63L47a/B40zflghnSQMRwA7BFjrdBnOYe1XjXzQ/EE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQR2b3iaj7RhnSg3SQTrGt6+YMP7RJdGN1Z54IxwNUVtStchuo
	mBoNHwCIk+86TEb6YZefJJob7Fjdu2hVhhO2Mwms9vC0go6jbwYzdl4T
X-Gm-Gg: ASbGncuI3zZ55Ol+6kNRQgaOvKoDHzVpHmsuAla63909qQmuyKCV6zcvxp+Ch/lSnr8
	JfidjFhrIrN18Zw/qV0osZ4ZtWLJE+fPhjoIOmCcKbtKTFzrrgNwxsFDSl3NR3cBM0vCH31MR12
	gfOGqU9UmLke4Vw0cEb3w71ZC0imTnatzYULnkl7slP3aJJcolke/5lDn3G3La8OJppERpVG79H
	+Q/JB3tzG/ylHs3HMX6djIlJ0NPjBO3fw4dpeX8zQOvYeE8tSPdD3kEf/MTiuFJUYejOHA/1b1S
	A6yJpcThyNWIGd1fszvcHzhkKNnRadAUUwYXYXJ6n3jR5N+FGkHhuK0I/YwkbRYmqByFKVln9sJ
	TxcpR29Oi8dXlsSdOPvAtBg5L6mTRjHpC
X-Google-Smtp-Source: AGHT+IHfALfUtiWfUaRmlR4ZxxtB5eUYseu4jQh3m56zCnTdA0qwOa5xP+hw+cxE4hw2Ya6g//e4iQ==
X-Received: by 2002:a05:6a00:85a4:b0:770:580d:87fe with SMTP id d2e1a72fcca58-7723c445dbbmr17669689b3a.7.1756916120214;
        Wed, 03 Sep 2025 09:15:20 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2af911sm16794353b3a.23.2025.09.03.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:15:19 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:15:17 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: PATCH] sched: Fix sched_numa_find_nth_cpu() if mask offline
Message-ID: <aLhplQVvIJqWo1ac@yury>
References: <1ae868cf-470b-44d8-bda3-20a64dedd8b8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae868cf-470b-44d8-bda3-20a64dedd8b8@arm.com>

On Wed, Sep 03, 2025 at 04:48:32PM +0100, Christian Loehle wrote:
> sched_numa_find_nth_cpu() uses a bsearch to look for the 'closest'
> CPU in sched_domains_numa_masks and given cpus mask. However they
> might not intersect if all CPUs in the cpus mask are offline. bsearch
> will return NULL in that case, bail out instead of dereferencing a
> bogus pointer.
> 
> The previous behaviour lead to this bug when using maxcpus=4 on an
> rk3399 (LLLLbb) (i.e. booting with all big CPUs offline):

Thanks! Scheduling for -rc5.

