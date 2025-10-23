Return-Path: <linux-kernel+bounces-866616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939FC003E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FB21A65988
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB423074A9;
	Thu, 23 Oct 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/qosfyb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB72F6188
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211786; cv=none; b=t8ypyenagem93CuM8883UHzXlgVqOkRdqfsESnBFCrClsy8hVonbpNAVS9siXqKb9+8YlcUYN55WNW8GPVsX36hG/Z7AzmnRE3brr2NUpCO8z1WyPC+58QGp8WzUt22ccbBlYUeRgFhzYoEdFsPZSelc2GLS6kWPKANccIKhUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211786; c=relaxed/simple;
	bh=L8RWOkzr6Ij8k/6lTo+PIqkIi0M0r95sm7S20Bttahk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajbThrOY+g194l7xREi9V8UiLsR6dHrmzbSCDkZJaOstH0w5ZvY4WSsv7gBCyW8Gc1WHDmdGGTfUkEW89JoffTHgD0k/FhA9ZihVSriVJeeHrARSgsDZhzWtM3IWdqepCIAnx7Qhp+74eUCCXwFSm/uEgUOg0JnA+zWgC9ie8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/qosfyb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761211782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86IV4HMydBNHXU1j37MM0rB227Du9QycfFN/bjQEi7E=;
	b=G/qosfybDaD45LnRbGQbNUcyPnn98JVLDiPAdseTbiBJ9hRvZDsPCwc4qFIaRsZyco/yQP
	c5cKirATiRZIrPoCWo/PHGAfSyUkUoDXF7IMsHFglSZwvHkDlb8V7hUpZ416+sSfLgDW41
	QWL0AnHMm9/2CoiNCkXrW3x57yhD84I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-ysqbPwcVNKKenrUptxJemA-1; Thu,
 23 Oct 2025 05:29:36 -0400
X-MC-Unique: ysqbPwcVNKKenrUptxJemA-1
X-Mimecast-MFC-AGG-ID: ysqbPwcVNKKenrUptxJemA_1761211775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83EBB195608E;
	Thu, 23 Oct 2025 09:29:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2709C19540E2;
	Thu, 23 Oct 2025 09:29:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Oct 2025 11:28:17 +0200 (CEST)
Date: Thu, 23 Oct 2025 11:28:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023092812.GA26461@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <aPneEnDQmHhpvRkG@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPneEnDQmHhpvRkG@pathway.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/23, Petr Mladek wrote:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks!

> This is much more clear. It might make sense to improve the comment,
> for example:
>
> <proposal>
> /*
>  * Legacy console printing from printk() caller context does not respect
>  * raw_spinlock/spinlock nesting. However, on PREEMPT_RT the printing
>  * path from atomic context is always avoided and the console driver
>  * is always invoked from a dedicated thread. Thus the lockdep splat
>  * on !PREEMPT_RT is a false positive.
>  *
>  * This map is used to temporarily establish LD_WAIT_CONFIG context for the
>  * console write() callback when legacy printing to avoid false positive
>  * lockdep complaints, thus allowing lockdep to continue to function for
>  * real issues.
>  */
> </proposal>

Agreed, will do and send V2.

Oleg.


