Return-Path: <linux-kernel+bounces-813007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4859AB53F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E74587C43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C122097;
	Fri, 12 Sep 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VNgIb7Y+"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EF4C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638502; cv=none; b=JCb3GakwMYPrUMfQ0EFZXt26M2w/1BgH1SSjlcOVo0ay51BzyOssUKOynIBISFzBVTJj73PiAn9sfHaQBfJHYWNDCdkTEtRW1dosg3zEjTXxpQBKqf3itt7CY9+mvy2KzOKO5vPYqRJX2xixCwRrE06iYDeOSCxWNiAsKKOhYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638502; c=relaxed/simple;
	bh=rbFktamvjOBrfE5CgYIrjSiv8plJ8v8ded9GYz6lYJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXFoVTZqK8bK0FXJShXGN3kIEYb96z/tbyHwuPVIRYCxlbrZj2uUE/iIFvA5eo0wDDwnfL8CXfV2GYVHCM044idOC752Zbt+OaE7XWtvrD0Mg5/eTr77ziv/F2pGB+XRqkKADzF7wy6fdH3IgMP8twGhfkCNRc0wrIR19BBzxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VNgIb7Y+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757638497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZADqpJA3chbnPl0WXJWbUaCgH9PLpd374WzwmzV8WI=;
	b=VNgIb7Y+r1rY2UrwKxf6twi9K4pop7vR7RL6IPTh1M5eiUHOpdQ1Ty9fJBgnmB56bx7HVr
	YfORy3vcBD+ZPi/fxmi0p8mbK4K3AjEiILYFyOEvN7wAqSaViF6CcBmQKLilaXZpP/bZWA
	sA9EI5hLSaQFzSPnHh423pWouswL0Is=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
Date: Fri, 12 Sep 2025 08:54:28 +0800
Message-Id: <20250912005428.2567361-1-tiwei.bie@linux.dev>
In-Reply-To: <78c8e39d9719a26c6e492e895b070794eb8218ea.camel@sipsolutions.net>
References: <78c8e39d9719a26c6e492e895b070794eb8218ea.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 11 Sep 2025 11:27:04 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > 
> >  void um_idle_sleep(void)
> >  {
> > -	if (time_travel_mode != TT_MODE_OFF)
> > +	if (time_travel_mode != TT_MODE_OFF) {
> >  		time_travel_sleep();
> > -	else
> > +	} else {
> > +		raw_local_irq_enable();
> >  		os_idle_sleep();
> > +		raw_local_irq_disable();
> > +	}
> 
> This seems wrong, with it, lockdep gets really unhappy, and if I remove
> this change it seems to work OK?
> 
> I'll note that arch_cpu_idle() for x86 also doesn't change anything with
> interrupts.

Thanks for catching that! I missed it. I'll take a closer look.

Regards,
Tiwei

