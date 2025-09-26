Return-Path: <linux-kernel+bounces-834301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FDBA460C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3761BC834F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E621F8AC8;
	Fri, 26 Sep 2025 15:18:00 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58C1E0E08
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899879; cv=none; b=iybzsBvieSr9GV4OFuOpPKEpG0Ut8LuSig/l8lFxazx3rnjb7y1+Xu9n0VYNTvauKifE3ub/WxkdXgxM+Qf5OR87z7++7Aad3C+wImm11X7l6lPwbvaO3ULJcBEnnfpgWytqZ0LPOtQKuw1MNbUaLs643CopNW9DpZXX3/j5fhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899879; c=relaxed/simple;
	bh=TrfqcUSjDXd6qq+zZhv8OoP8FMQD4NrTlvd363MtZBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAz5bCOnAj2PfoFe5Meq7nkaL3DW6xEKjXOXGhSfA8RcLvWWnFmBswuL009udWbIP4OYyltGzqWBuOje7Boq/3NWewiiJnL8Szum8YTxCYIEqyyvC0AYNWnIaOLODtw9wIuncsLeR/zcsMfp4P5AwuObWWQlnFExtCdyowx5PDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2e173b8364so380428866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899876; x=1759504676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnUgrVRWtPXvYNw3cEwCbeGGLt1eWXadjBCbWNpYKBA=;
        b=VFQazMncPGuf9GACiTJNB2i/XyFzeUqaJz/swP9uee3fWJWW9upSINX50pTto50LMM
         XbikYbR2wUAFg5K7M5Nw2a7hU4a+ANkzneLg9920SxtXXNxOG4GgE/ZgQz/Ho5tLvYNp
         ++1Id33MYNL/RduOrZfNUJros8/37d+TWj2Yaf/XFPdWQ9ZBD/OKrVtCcVD+TYIha8dZ
         gTKqVCXK7Yo7baQUGtIeLeSTsnQLVUfUYQjogVMeXtjGWEE+yvM4kZ/36E28gJhISam+
         rN7Op6qoz/oIo9KY/m+aaOzQAyptYbAC28bPpczDM5LlD69llzAaKKGynUiN0fbQxtbJ
         Mz9A==
X-Forwarded-Encrypted: i=1; AJvYcCVlqHrmcrj42dabKE5mycwPqged3g6DT0xxdACvgumaRrwNtm6G8xjOedcKIO6RHaxlLNXiKvKI+fO0BeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbzu2DFTEne6nzNTRdWyPkaZuJ9tIHOf7Z5al9BbYcD/fW42Sw
	JW6deY5P5K7kIv8n6Es1RYvwDFLxrYaiZ4t3t0gIOGYp4BhSbR/XZDRZ
X-Gm-Gg: ASbGnctq8FfQNwlcarI2AR0dxcsVXLqg4CPg0KZhR3Pur8ugwVpQyhrrzU02ErHsiIy
	XLVZiJoAmoL2GADneoLT7r8DJ+K/1+9sTPcZFHC5zBG5FNUvfLBs8kchmvabs//ENcCqB/HzPd6
	2WYaDsQSrJeFimXXYqj/3mrbN3jZ0FiI9/PFLqJH1z4Tn7F534yXmBr2kLg6YlfTn/AvH9zUCg3
	KTeByRGnzHESzyrPh5yxS5aKvBe+FJYQtS278aPyX28aaYliJbe+QMARBxNTpH0v97PuJFI1RZU
	QqHFBnTBBmxjED98VXEjIMCqlDcD8E0RxqO5fsTLJR5DGEq55KX9lC7wC5ZCZBV/sYuzoMSPKIT
	SBzJa6Wsdmbn5G3ExEr/ExGY=
X-Google-Smtp-Source: AGHT+IFV1rFDOexc9Xi+0VScHi8fOmYKgOMMUHfZ/7y0kfN8+3skWPIk783gpsDJGoQ52fkZ7oGJVw==
X-Received: by 2002:a17:907:c21:b0:b1d:285c:e0ef with SMTP id a640c23a62f3a-b34bb701b01mr872574066b.26.1758899875805;
        Fri, 26 Sep 2025 08:17:55 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fcde34sm386695066b.73.2025.09.26.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:17:55 -0700 (PDT)
Date: Fri, 26 Sep 2025 08:17:53 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 0/1] Allow unsafe ->write_atomic() for panic
Message-ID: <bqihuqqrfc4ayghycmtfjcowyflvbku4ledy7pwajryptlp2wg@hq6cctbmimi3>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <5hgyof3yowdw3v76ygz2oxkzv7vpz5kp62nx36gynmr646yrjs@ag4mvynlin4k>
 <844ispin6a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844ispin6a.fsf@jogness.linutronix.de>

Hello John,

On Fri, Sep 26, 2025 at 11:27:49AM +0206, John Ogness wrote:
> On 2025-09-17, Breno Leitao <leitao@debian.org> wrote:
> > Upon further consideration, it's worth noting that not all network
> > drivers rely on irq-unsafe locks. In practice, only a subset of drivers
> > use them, while most network drivers I'm familiar with maintain IRQ-safe
> > TX paths.
> >
> > If we could determine the IRQ safety characteristics (IRQ-safe vs
> > IRQ-unsafe TX) during netconsole registration, this would enable more
> > optimized behavior: netconsole could register as CON_NBCON_ATOMIC_UNSAFE
> > only when the underlying network adapter uses IRQ-unsafe locks. For
> > adapters with IRQ-safe implementations, netconsole could safely utilize
> > the ->write_atomic path without restrictions.
> 
> This is good to read. But note that if CON_NBCON_ATOMIC_UNSAFE is not
> set, it is expected that ->write_atomic() will also function in NMI. So
> being IRQ-safe may not be enough.

What are the other requirements for ->write_atomic() so it could be
executed inside a NMI?

That brings me another point, I suppose that netconsole callbacks are
currently being called from NMI, given it is registered as a legacy
console, and legacy consoles are printked from inside NMIs, right?

Thanks!
--breno

