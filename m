Return-Path: <linux-kernel+bounces-810492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A597B51B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA71BC3383
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F50255F5E;
	Wed, 10 Sep 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sak1+qSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5YyPgmO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24B2376F2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517493; cv=none; b=Dthmm2T5i7tlrb/O5hZtglM+c/M+djQTkgwlMsDW9QgmudkkAJJYE7rYuZZCpU6K4FMFrcsbxlEBcMi0yXanfqbmXntuE4HICbyLlqOjtgA/aw4yvKlg8H4Qry0k0be3O7OWuJO335iJPciYy42sNw9eGrRZL6CH2LZj03yExgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517493; c=relaxed/simple;
	bh=ikOb3d/T/uEENrErdgwGrWMLWLXXEvd32Jm0cJz7Jlo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCjyVaXbQqqLoJILL7TldnghySNs68JrJZyfX6TQXvp7n6NFcdbC3cT97BeJtCBlEHESvN/AoNTx9ZysIWxINwueKFMYU1bCjz1ukP45tOA+7YjR5qxtkh8bH+v6omTeG2WHPI+eim52odpRMYdmULjEiWbPtOavkuBXlYBN+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sak1+qSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5YyPgmO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757517489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kATumCjxwteyvACzg7HAbzBnIY0q9rjMMtmF2Yi/6zo=;
	b=sak1+qSndqV+MlyeCUDhaAIlyF+n1ayc96r74J27EKXD+DH3x4uBSUka12mpq2sY9Ms0xq
	uvdhw7ztxBHzLYatl8//XoLX79Vvb9F97yOlqXEkMphuJ39spyu9BsHwH67w1P/Mi52Mh1
	EHw1mOF9wr2IKG6g9l+pD3d+UvtJFcS84WQ/ld2YyZowapge20HY0uQ1ssFXnRZRrRqCON
	Im3XzbiMfMZwwS0trv3yxqRE0AjOsfzPoxpIFFakCIrU3dzd/gug0NWo0r6TjcCZB8QhIH
	t+RoDNT9QvAOMWSbX5x0F/3cQxyREJiBfu4HEJIV/VDWGd+l3y//5FYdQmKWlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757517489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kATumCjxwteyvACzg7HAbzBnIY0q9rjMMtmF2Yi/6zo=;
	b=v5YyPgmOExya0pMkpfpCWiRqIqz9DGivzXb4z1MJ4noxYOdL98GOaJLtCaCINXDPajuqnK
	nmgXjZj6UtQzwLDA==
To: Enlin Mu <2277901360@qq.com>, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, enlinmu@gmail.com, enlin.mu@unisoc.com,
 enlin.mu@outlook.com
Subject: Re: [PATCH] clocksource: delete unnecessary comments
In-Reply-To: <tencent_9F7BD0CB08BE82E158610B7568B3EBD96B09@qq.com>
References: <tencent_9F7BD0CB08BE82E158610B7568B3EBD96B09@qq.com>
Date: Wed, 10 Sep 2025 17:18:08 +0200
Message-ID: <875xdqtjyn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 09:47, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
>
> The new format is as follows:
>   clocksource: jiffies mask:0xfff max_cycles:0xffff,max_idle_ns: 7645000 ns

What's the point of this exercise?

We are not changing stuff just because, there has to be a reason and a
justification for changes. See Documentation/process/ for further
information.

Also I don't see where this change deletes a comment in the code, which
is what the subject line claims to do.

Thanks,

        tglx

