Return-Path: <linux-kernel+bounces-851910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A672BD7994
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066024E91A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E52D23B8;
	Tue, 14 Oct 2025 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUS0zvyh"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78A2C11F9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424208; cv=none; b=tIJzD3UhJ8Qk3e7nCyKcdzj5+l92xfDaCCZgmqevR7y8t9pBX9NnsVp943omqrqtAqZv5MsDmASBVBeHdg3Ne4WPTWA7kWOAFhKgein1mZ5GwWBSf3uMTxIUg2OFllqWt1rO+8wFcQVu0FFZzTxYeyx2x5k4/xP8rRiCz9zwxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424208; c=relaxed/simple;
	bh=8BmtnVuF+NR+683lGUyRlkHB0hCfWgNPU/uJQGt18PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZP4YIDusyJfTuE9jGG0lNIwIl0NUOBcykpxIqCILNTabnhlCdwaSf8kU6qYsc8RPV7b1cr0mJ+/3ZE7NItcfHmktPzrn6xmI5pG7CFHrBet8s/HHV3fx4eChN67M0+7hUkAPOPaD49+RTluwD0v3krIhKavGAqCTF4yTFBwTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUS0zvyh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-854cfde0ca2so1040611785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760424206; x=1761029006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhrDyaN2J3TqzVAMvoBpM4UfVuraiqPhFHlfn6YNa1Q=;
        b=CUS0zvyhgV2/Go22Y7HkQ19GOeOGM7KKKP/JOjpK1ecUY32SpPMkhlzMCad2Pngq3I
         ghnd72vjwOUWBfzW1GQ2LkjOdpClhw4Y+vd/FvRwH1Q0L5L1LVbf+G9agyg5oszD6lst
         mFwbc0HBY092wPiXq9dBHw2Twl7zFWS+rmsgoEM9g01v3Y69XBiU6Zb0R28hJjwEJrsf
         DUTrZX4rXGDfaeXl5MiQENJ5nnJ/6F2LTGR2nVumQDmqzc2kyPEAIW/6I3sV6N50Z10k
         019NEAHfXny7YSruo2tyCkmp5PclMHCw+/gaX1U6Pg8wxkfplCUZAaAi+Ukc2kQ+bwdr
         Un6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424206; x=1761029006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhrDyaN2J3TqzVAMvoBpM4UfVuraiqPhFHlfn6YNa1Q=;
        b=v/YKRti2b1d9uMHC8vrQ53UBo9ttvB262bq+H6sskSZg4Jq8LbYUGMjpmLF9QDK6X+
         +4CHbzSz8QAuzBw2egAJCdyS5eiKz0q1am8iHXurtW/vfatrphbZJ02JjLeOU8sQW66L
         O1PXJbhBTvrWJjMr/tydkK6bIBUZGbjRqQIOTlfF2F7j6jAeJEC34Y16Mi9cAQ5QCrWG
         M4hi2wGQPPFSlLp8Vox53yd5niYX4Q4Lqfnb24VSLHEjvVeiou/zbkIZvI4ZSTNzoEO+
         6zj2Z/GIeExYhb+4JnwAvwEuJkFAcZgdNYtspdkTO0sqnNlWNyX/jLXggR6b+dx/xDUe
         W8TA==
X-Forwarded-Encrypted: i=1; AJvYcCU/+Q9FxTHFJKHayzFEbH761xBoueeebtY94NUkaI5rVXHT4H/+GP8ydn+nQDx6wMCtD6qjSEbiVLrvx8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESSyCnpf293ABDnjrLPU+z8b/qZNWlLI1TtIydwPuZAySLCns
	EnR5rRjRxLwipAWJXokCW5KcGNW5VQHp7kvmVCawiXdJgSv+7Y1Xj6k8D3PReDubHc6SlFmYCYV
	7G59gTZM61m9V9KdIMhj3zodfQ/rEqYk=
X-Gm-Gg: ASbGncuTVnBJOf7FR6VuIp1JXb+0zkA+QDl6mqm4vuWooyRR3W/4IoKwqLV5SDdKnDG
	6MOFDyfkzeDPGxtFcoyvtjCCCFQ9YfN36OExDXsZ+L67sG11JYIGgcCdBK6H0q4qbt26l2GkJg8
	cubvf1CFqkvQEVjY9Pi4Slz6QXjr5M/FH2VzHzwcCpFMXI+uSDIK56NmqX8sw7q1vezPlkYaAc3
	FBkFFDSwZYrWth3qme9QBEY9rlBrUCvxWKjWNMhjnj9RkNmOqTT0npPNeUeSL2PR6uB4BrWrGI2
	3CE=
X-Google-Smtp-Source: AGHT+IFYutlmQKCrkDt8XJQ+cgRq1f7xMcV72qnx5j0NhR1+uR1WTW9C1BFQIW6/sa8OGzcLx/Y98zV9viwi45m4nU0=
X-Received: by 2002:a05:620a:1709:b0:848:6b67:ea57 with SMTP id
 af79cd13be357-883502b6ce7mr3038377185a.16.1760424205591; Mon, 13 Oct 2025
 23:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
 <20251014035846.1519-1-21cnbao@gmail.com> <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
In-Reply-To: <CANn89iKCZyYi+J=5t2sdmvtERnknkwXrGi4QRzM9btYUywkDfw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 14:43:13 +0800
X-Gm-Features: AS18NWBkvzMB1sYbudY7gB27K6cY5x7_rxgh42n5L8scA-jiQSzN7FZuNS0QWLY
Message-ID: <CAGsJ_4ySSn6B+x+4zE0Ld1+AM4q-WnS0LfxzWw22oXr7n5NZ=g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: corbet@lwn.net, davem@davemloft.net, hannes@cmpxchg.org, horms@kernel.org, 
	jackmanb@google.com, kuba@kernel.org, kuniyu@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linyunsheng@huawei.com, mhocko@suse.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, surenb@google.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	willemb@google.com, zhouhuacai@oppo.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> >
> > A problem with the existing sysctl is that it only covers the TX path;
> > for the RX path, we also observe that kswapd consumes significant power.
> > I could add the patch below to make it support the RX path, but it feels
> > like a bit of a layer violation, since the RX path code resides in mm
> > and is intended to serve generic users rather than networking, even
> > though the current callers are primarily network-related.
>
> You might have a buggy driver.

We are observing the RX path as follows:

do_softirq
    taskset_hi_action
       kalPacketAlloc
           __netdev_alloc_skb
               page_frag_alloc_align
                   __page_frag_cache_refill

This appears to be a fairly common stack.

So it is a buggy driver?

>
> High performance drivers use order-0 allocations only.
>

Do you have an example of high-performance drivers that use only order-0 memory?

Thanks
Barry

