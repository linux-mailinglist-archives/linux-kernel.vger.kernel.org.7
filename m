Return-Path: <linux-kernel+bounces-808039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11249B4AC6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9464E66BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EFD311C13;
	Tue,  9 Sep 2025 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgAsutnV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bG4V1zRE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C94322774
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418140; cv=none; b=MieS23EizNlvn+ftNOdEwo/gXEuNwVrgW3U1z3qaCRdDvrDz2IYT72ehAajsCGbMPWZIowiulFOar4yjmLFSq7KAFddWAHNPGfpWNTOKGoVFMm5g1WGNa2JvVq6YRXM0tbxRsX2fT6tthTnJ3WSA++inu/37hgXxuT0PD8HctfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418140; c=relaxed/simple;
	bh=pESf0H2EQZAIly01z/Z3mZH6pJ2lQ+6yP2paj9rDL5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NP7dhPRXrJAfXnG1rbZ8mz7FQ9Pl5MtNmp730t5zRrVfoD415zEMWvdxzDksGY4QsEilU175d4egrGde+YsQ3K4cjOxyPeq2G6IJBj1fgvim5qVi2B8kwwKRu4piv4ON7q3ookBJNwG7odjIIDTnFoFAHywOxbchNxElNWEbAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hgAsutnV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bG4V1zRE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757418136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASATldV2WbHYCpMK/iv3KbFGige9vefNNw7rHuky/LI=;
	b=hgAsutnV8Yd+6my2jEv8es98beCtabcjPzglUPwMI7fxayNFDv3p8Vus3iPaYYd3F1PcHF
	qP0BfoHiiHulNfE3xG2urdLr0kKD8jHG4ltlSy1TOLVqzGIlxOathpUOPIJAx6P4FWUwha
	7YykWGNIAc7MINuDcvbiFuI0pmQcMNV+D+7w8LiPR6XSFgdWCm9mPewBYTYHcHOxqo9aGp
	1C6q+u/FR+2Er4xwFihAr3OpJj/4t4fA9nRfheuIUC8pFbwMCWqZeojCWEJXIGm+/oPJ0C
	Gxs+/Hn11dnhIbosx30+3v2PTo4Z1QvGjX6ZKEOIRv/X5GWS6sam0xdxsaZk9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757418136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASATldV2WbHYCpMK/iv3KbFGige9vefNNw7rHuky/LI=;
	b=bG4V1zRElQ7Cz98o+5t3NvIhqJrD+00GkMTv6Mod8nE8gbmNXZmN1kmJqsWnrPHJOqKcUM
	ztZtn1nydWQuhDDg==
To: Haofeng Li <920484857@qq.com>, John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Haofeng
 Li <13266079573@163.com>, Haofeng Li <lihaofeng@kylinos.cn>
Subject: Re: [PATCH] timekeeping: Move debug sleep time accounting outside
 spinlock
In-Reply-To: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>
References: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>
Date: Tue, 09 Sep 2025 13:42:15 +0200
Message-ID: <874itbx36w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 18:23, Haofeng Li wrote:
> @@ -1986,7 +1988,8 @@ void timekeeping_resume(void)
>  	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
>  	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
>  
> -	touch_softlockup_watchdog();

Removing this is related to the problem at hand in which way and how is
that even correct to begin with?

Thanks,

        tglx

