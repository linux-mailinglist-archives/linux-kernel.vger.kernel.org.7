Return-Path: <linux-kernel+bounces-734494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F37B08271
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D93617C6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445081E0DE3;
	Thu, 17 Jul 2025 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLOOS1Hz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450B1DB375
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715981; cv=none; b=WkZYEil6hd3NviPaRhOCjux2NNG8thWR8KzdlhD1sMAQ4do5IwxqTAVIDzN+yk3LYeD/t66XFBeUeWoTnkZ6nwKvjlhpoTmXpvavZ3zgtbT8Kb8vfG+y4bAZnTYev83VytJjMevw7rcRqi+CrYUuXP7RC2y0yNF83ojGO1VjhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715981; c=relaxed/simple;
	bh=dZWEXq1ZCC5EQdteAWjj2u5ej81nBdADeQCB6DBuMA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he7UKT7/WD36f2pkMslxxSAjl7pVKi0vdOMt8D0i7RKU1ijC1yEoId3Vh7s8n+RKZgNI1Y+2xfZMBKLveyqndhM71IBJ4+BmJWcumYjSZFNoDxEjcsUuExiP1xpkrKNs0TgCAg4D+jxKA5vkja3ZNWx3k3tkrOe2R2MKNYyMnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLOOS1Hz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752715979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p9fB8YPoTRku+vs66lft24k3+lG2IfSELNEAhpBx3Ys=;
	b=fLOOS1Hz5pLenKHe+rB4NQcqsm4OVvzYO0urM4GtpdrRPfra53wCtdK9iMhKv9f2z8y53J
	rDREP0BzfCeaW168AgZaugmaEtslnvYN+odqkLUbhSXC/ZcMHg3Y5Vvq3+8gkMbAr7x7/i
	atl1C0A8STn4Nvc3y5D52IH8G6IroWM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-HglOn8tMO0OtZU5jRSbZWA-1; Wed,
 16 Jul 2025 21:32:55 -0400
X-MC-Unique: HglOn8tMO0OtZU5jRSbZWA-1
X-Mimecast-MFC-AGG-ID: HglOn8tMO0OtZU5jRSbZWA_1752715974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B129119560B2;
	Thu, 17 Jul 2025 01:32:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.192])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DBDFB19560AB;
	Thu, 17 Jul 2025 01:32:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 17 Jul 2025 03:32:03 +0200 (CEST)
Date: Thu, 17 Jul 2025 03:31:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce
 freeze latency
Message-ID: <20250717013158.GF16401@redhat.com>
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
 <20250716163854.GE16401@redhat.com>
 <c6c7e8b5-430b-4616-b9e8-46500621bb84@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c7e8b5-430b-4616-b9e8-46500621bb84@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Zihuan,

On 07/17, Zihuan Zhang wrote:
>
> >>+			 */
> >>+			if (p == current || p->exit_state || !freeze_task(p))
> >>  				continue;
> >I leave this to you and Rafael, but this change doesn't look safe to me.
> >What if the exiting task does some IO after exit_notify() ?
>
> Tasks that have passed exit_notify() and entered EXIT_ZOMBIE are no longer
> schedulable,

How so? please look at do_exit(). The exiting task is still running
until it does its last __schedule() in do_task_dead().

> so they cannot do I/O anymore. Skipping them during freezing
> should be safe

Oleg.


