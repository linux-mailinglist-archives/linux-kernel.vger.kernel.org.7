Return-Path: <linux-kernel+bounces-751726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39440B16CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155FA5A4E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B129E0F2;
	Thu, 31 Jul 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CscC6Enr"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAE29A30A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947158; cv=none; b=NeGhV0e36GFKwQH5H2NKHZhlNnNee9C0rKEJA+d+mGOnxpbuhbsFowSLdnhYzuw7FC3XfqNWe9js6U64UG3mXLDVi1li3jg7WsEzyKDC0WxmJx1ucXOLHdU1kD7PLpcbf/jTXxGvfT0EsEAjM/6unu2p+WJWr9S2oDx7b+m+sIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947158; c=relaxed/simple;
	bh=CgsOD23DzKiBx6LmEw7oJmKjycR3obfhzW3YGcNJqdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix8fgwG7V4JAWLrM+8O4LrXPTZEaAofJAQVOVaTi8EKWPZpfqtJfhjzjXXT6a2l6WmQpRdQJ4Yj40pmv1q400si5D2qGD1A0zqhx31n6mQWF6ATu478meDbo9OQr4vZ4daoF975wZovWkSphtjKTNJd3PBQ8TrJueDHTQ46xoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CscC6Enr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ecdf5faaeso130727a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753947155; x=1754551955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXP1monuf+LNAX5kAVAGy5kk/VpkYINf3yxaWaUA1II=;
        b=CscC6EnrO6TmzV2YyiMcXsCx+eovPRc0YoMzou36/230jOFMAXggyoJn7m2q4Fgqy+
         Gw6Kz/wd5h5M9mHmTE71ZTWWUb4KZm3ms8/JFvOlDQthidd9lMs9n6WaZHFk2AW63IkT
         9+ZWjHgcFd399mTSkXOaoDR00OY1Y54rU+Q+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753947155; x=1754551955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXP1monuf+LNAX5kAVAGy5kk/VpkYINf3yxaWaUA1II=;
        b=uYUhc59LbCyrN/fxkLOz9m6reazxU0wD8JDd10P3Jp4z9pMqpWAXH8EoWZopqnz8OP
         SUeI+idFfvJdkT21qWWph9JdpRub62FvQpwCpGlNmhxlV5FI5ob7Jn0PjYu/EghX8lhb
         SbZZIXXY1kjYspnv8BoECCl9KKQA9YT9Q1pGHY1Z2y6+cESnBmqnlBlyBb81hnHRxV1N
         akOXb7+Yc4aFVpZyzSs6YmJf/scT3DwSq434joJL77IUAUa2/WHAU0Xo2QyRi/tlKE/p
         NdgVlY7e3ONWyVtB/sk0IzpRXC2wxauBIZcgtx/mrKsCeymDfVVpHqaIFviCOdtPIUcA
         oIJg==
X-Forwarded-Encrypted: i=1; AJvYcCU+7wnLEq7L1mt7jHP1nDLAqdyPP5mIllbXZQ0DfcDWGS9HEUtKXS18J3FdGDt8KzmhVYava+rmT/UTub8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfigJHbilTrbFycZvp5tBk9UesSyNEm0L4p6BtE1+/dA0fUd5
	zB+uAvWrd3pkT7U1QRsObzLFWXcCYKtopdl3Z+lawQxlEgCmsMSXj/p1V0J1jkICtA==
X-Gm-Gg: ASbGncvWKCxouG7d/nAdS9fMH3yqgZ9a+/6BMWEoo3YJKNkzYPewZ4qis6H7ljwX5Gg
	MOgT1ZmGAFOfJgRLykG00KKROSDyz3/C7AvZLbbCoCxH9wYpW25WYz+4LcjhGk5rkKXD4md79kr
	jWDwzTH6rCtPuwTshkJPCuiUFgIxWnn12XUkkFbecO9u+IpdwQtGqAwoFwUoiGv3BIrlbASqVW5
	fHvSRRLpeHUQVk1q1l8sQc8YKYJYjOlejf17+Pnv9W6o5bAvS4w/7+0M3vw46ff6woaGqA2BcO6
	tYYmtf6HnLbzpjdDd1zXFIuqTuusZbj9tUa/6Frve585K2fhBn2sHVhBAOsmr79ySeHfzuM4Krq
	tVCnurdCThK8yamUoCvbyEZR8wg==
X-Google-Smtp-Source: AGHT+IGTX+C2I+sElpxt7hSBEnLRE3nYbTRmVTi5BanzA7KPH5nv8cR3HyduhhuEJkvYlQcaAAFztA==
X-Received: by 2002:a17:90b:5285:b0:311:9e59:7aba with SMTP id 98e67ed59e1d1-31f5ddb7e9cmr8315615a91.2.1753947155060;
        Thu, 31 Jul 2025 00:32:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9455:d03d:1e86:6ce4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebcfdd7sm1149263a91.16.2025.07.31.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:32:34 -0700 (PDT)
Date: Thu, 31 Jul 2025 16:32:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: remove redundant panic-cpu backtrace
Message-ID: <2kwymhiz4fcozfmbmj6ju2qatsbmnrtiidfa4nxrqutgwa6xfy@dbf3caohbbay>
References: <20250731030314.3818040-1-senozhatsky@chromium.org>
 <84seichm5t.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84seichm5t.fsf@jogness.linutronix.de>

On (25/07/31 09:15), John Ogness wrote:
> On 2025-07-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > SYS_INFO_ALL_CPU_BT sends NMI backtrace request to
> > all CPUs, which dumps an extra backtrace on panic CPU.
> 
> Isn't this only true if CONFIG_DEBUG_BUGVERBOSE=y?

Are you referring to vpanic()->dump_stack()?

Another way to get backtrace on panic CPU is via BUG(), which routes
through die()->__die_body(), which prints registers, stack trace,
and so on, before it calls into panic().  This might be x86 specific,
though.

> Also, the information is not the same. trigger_all_cpu_backtrace() will
> also dump the registers. For CONFIG_DEBUG_BUGVERBOSE=y on the panic CPU,
> only the stack is dumped.

Hmm, it's getting complicated, probably isn't worth it then.

