Return-Path: <linux-kernel+bounces-739561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF3B0C7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB61AA5B38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E572E03EA;
	Mon, 21 Jul 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZtLBSZP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5lJbHEMF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E6170A2B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112662; cv=none; b=eTcqlhfXjF5wfKxSLrZ/3bXcLAD+sSMEyWY6VXY0EWQ+sm15/q0mYCfAfscVr3VaZl5v7VRuAQA7BW4bwsiQgywFIgtm1kPie+ow43Cw2ugUg9E3NJwSpNPyFx4kB0R8CY77ut5Mbpd8HxVMZyVsP/BA7wFP2c4BxuPxWtJNysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112662; c=relaxed/simple;
	bh=0jgzMwOqgB8VyKdwP0IAD2E6MIQfEZeKMMVcErTcotQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qz83TjnPEIFZ/DA7tPYNNrTU0b1z28t8Mfs8f9bMsxeOy61scwUdGHMkciqTpUXdMDa7eljURRVU60ccWNm7flqfC7jaSDMTynxNzOpYddWkvL0GxMa9331wmHJ0ilEPlFDa4QwpDzfX8zBMeJTaeoBi7z2Ev9HOPU1jW9y45vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZtLBSZP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5lJbHEMF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753112658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iG5Dbh5sLGa6ridXZrbiD9xKf7SabseFeQZvslCyuM=;
	b=wZtLBSZP/nMjn4jift2G/TF0x8ysCY+HgikcAdeLW+3JmDdAK883o5gJx4qqnHdkDd9cXJ
	5tSKbYTVCpgZcoq1CmoPzQhMmfjldaAP7eAuCvQVQZnovPuBIz6WxVwwAYqZ0ewfvqlH+5
	zZxKTRbfK1SUatoi6WAwQKXfDuzIVxOIsAZ67gDJ0Dy1xRTervlVZnrhpwwZa9H/sNdpI3
	K3Lf1v+8G/9sjkqDeFCky1ZG5V2a9e7dSLBTQifxR2hTqMu/qtu3LX+yrTiHttr6tEoYBL
	MQBcScPMb+0v8ctUOVGbLBYafzDPKP2sRALVW6JuSoxgbVQ/bcKsETPCh9KNHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753112658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iG5Dbh5sLGa6ridXZrbiD9xKf7SabseFeQZvslCyuM=;
	b=5lJbHEMFqm1YPRd9RbLnjlP9WokN0b7prZxgqWXvs934o1/hpXKpPloJCVWLdCPsYQy0zz
	jwOkqDpVw5oZQgCg==
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] irq: simplify irq_im_handle_irq()
In-Reply-To: <aH5OUChoFx55WnVG@yury>
References: <20250719211818.402115-1-yury.norov@gmail.com>
 <87zfcxtz6t.ffs@tglx> <aH5OUChoFx55WnVG@yury>
Date: Mon, 21 Jul 2025 17:44:16 +0200
Message-ID: <87o6tdtupb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 21 2025 at 10:27, Yury Norov wrote:
> On Mon, Jul 21, 2025 at 04:07:22PM +0200, Thomas Gleixner wrote:
> find_next_bit() and for_each_bit() cannot be used in concurrent
> environment, and having atomic clear_bit() is meaningless here.
> Two concurrent processes, if running in parallel, may pick the
> same offset, ending up executing the handle_simple_irq() twice.

The irq work cannot be run in parallel on multiple CPUs. It's guaranteed
that only one irq work handler runs at a time. So irq_sim_handle_irq()
is fully serialized by the irq work magic.

But the bitmap can be modified concurrently, which is not a problem.

Thanks,

        tglx



