Return-Path: <linux-kernel+bounces-886447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73950C35A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DD73AF5D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006B314B63;
	Wed,  5 Nov 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA8ICoLX"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C23148DA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345616; cv=none; b=cv8m0zJFYRHJyhi54ixQIE+HMv7ji8Z3p66Jgeh8bPEnSxtmKOKQ6HX0lArAPaU3YE8GRRvQMhCg6BxSh5FBLY80BZ7MXt1M0ifC6gvN0ZNS8IssxBWsXk+ZQK0JQspy4tQUn+tXNCdU6GDJlxDmFPgHOKLmr1lXFG6R2ZW+oNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345616; c=relaxed/simple;
	bh=fcuYPwU4TimMOTUunc+Hh3TCgMbgiRZ/hYuPF3TLqsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOhL/edhEl28wIJB2EOy2SdatPdBNnF5IvPXxpxtHrL1OL5Q8yGSYJuybdbQr3SyJcg9l67kS/wliYG4QBkWgZJvc+/arKXX/7wC1XcQ9EtuANkHasi/UhgttBZ3zBfJKqQirq1rPOWaFstn3KbAfjA2xoFUkN4pfTVWrWJlq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA8ICoLX; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63cf0df1abbso6980432d50.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762345614; x=1762950414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVOeN58zyeFjjSDLTxwag0zpnGdW/6CES9AXGiQ47G0=;
        b=cA8ICoLXD5g6uGkujkgcH2gcWCe5qI+QKM2uu+96hO4hH7SeXyLPsBQ0oSW1JTv171
         TbZLVBlDyQF5E5gOEv8057dejt/iRAE+stBUjXzpnxwoKqez9k/6pks3YdRgCkHTSbaZ
         s/9y2rU9AjMiQS2RJgS3ICilBnmnVBluOkD6S2biLI2jT1/tUXDYFjH9CN5r0TQ6iTgy
         MTDV+NbLNba/ymmHiRWKOFPA/0js3g68+0aN5TBXpWgbPgNhkZDjeHe86oX9OZNapG74
         T1EKRGGdIYFBEsUzhHToc5Yh75I8Y6ax6iNuEXaIewQriD8ssWVLU3AQiIRjaPBWv0Ea
         MJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762345614; x=1762950414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVOeN58zyeFjjSDLTxwag0zpnGdW/6CES9AXGiQ47G0=;
        b=ln+guBZvQbKUTAZ/IZ1s5n1aHsDdk/8kQnSruOjmT+VlW2rLQ0mttC0eFZ7uIgwuXD
         DsBK1fIe5zbET83xEZeIKRJJq2KDco1KgPQuttj/a9cC0tMmwD/+qzFyyzH13n8qk/PC
         RQXXW1yKS8CnjQUfjqv6omRiAZA/sA17rDRLOiqvjnNsN/iH6VVnyujJfTl9ubECfc7H
         oRmy0FvXtFmSff5JvX/RqUKTzzWpwmoo9gYxqOMDyJOltN8Leg0vAWHJPithwRVrwwpd
         swNroi0q6kr8eYGVt9T9m6GewrBGyjC/B3lbXuVr7ycibv6ZYlno+hrnmjgK1WclTR7z
         WHow==
X-Forwarded-Encrypted: i=1; AJvYcCWHDifVoYBWXK0/a7RmkW3IRMInxxaW673nIAhaTCMPBNmnJHlUk4ihruVZp9mbxL3z+0bJ5nxgQTYqLkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzT3RF3HBnCObA9Xf4ydD3IQHPyrh978OQXuGx1/CUqGPBE8f
	+fbpcxfNMQZP+RvDVpzj7Rz5Cn5PGmD4+6h3EEiWoFNQzUaQ0blZbCFFSJYXvA==
X-Gm-Gg: ASbGncvQXQc7z4faFM9DOhULuJVA5kd1GWy4yFu5widQEKF5hvaN0MxUXUitQxOHgHp
	GItqdI8/gbkaLvZaSUaboCq92j6lSiD1V+lNvx9Q4KOFoa4T1LnQ8MkrVn2RdpkewN7DNRJV93E
	uBaheX4I+xZnnrUcJGl3dynUIlQlRI15PF3fHWoYhLgTG+xlzG+/lw4xHQbexDvBD+PEFA6dQcw
	a2B2qIZ7ikGqielFDvQx3Vj92rlqCk57tJBHMZMs0ZhRwwyBPnfqv9IxbiYP5+AoOejMQ/CnSoh
	jETK6JhG1AHM5LHciDVZNnzgiZqmHs4bH4XoOJodnKyhajpgIBF8oMGxAPopCZ2MNJlzcQzmQ2P
	h9mTZ1T/gzSwqskEwgqZCYdHSVPjsmDDbKt6njimXQBEl49llRTxkyrZcXyuHZpgyzF9a28lCN9
	eIZLmUXBVUbBQMb9KC/RnBCX7KbQqdDw==
X-Google-Smtp-Source: AGHT+IEFlvx4JyuDk5g+CiYUHaEWVZiY2cIIua5bWi3AU8zL57bRa1V38yrfBU1JtU0MOAk5bZ8jnA==
X-Received: by 2002:a05:690e:d45:b0:63f:bc75:6ead with SMTP id 956f58d0204a3-63fd34b5560mr2320123d50.9.1762345614071;
        Wed, 05 Nov 2025 04:26:54 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7869202ed97sm18637177b3.57.2025.11.05.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:26:53 -0800 (PST)
Date: Wed, 5 Nov 2025 04:26:50 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Tim Hostetler <thostet@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v2] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
Message-ID: <aQtCis59KXvcQSqO@hoboy.vegasvil.org>
References: <20251104225915.2040080-1-thostet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104225915.2040080-1-thostet@google.com>

On Tue, Nov 04, 2025 at 02:59:15PM -0800, Tim Hostetler wrote:
> ptp_clock should never be registered unless it stubs one of gettimex64()
> or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
> of function pointers is null.
> 
> For consistency, n_alarm validation is also folded into the
> WARN_ON_ONCE.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Tim Hostetler <thostet@google.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

