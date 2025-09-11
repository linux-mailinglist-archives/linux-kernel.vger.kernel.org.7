Return-Path: <linux-kernel+bounces-811341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C6B527BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9569B3A5519
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED322FE18;
	Thu, 11 Sep 2025 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K9D0Bo/O"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B8329F3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565309; cv=none; b=dja2r5vWcl22mjj1eT9KtRgQBTktg86v5h7Ifs6QeasQXPfRD3wtkdxWO0E3GUrvs7iFrflqDmmN6Kt9hKxu/C2MaEpiiX4+AYNTpFlrWRUBs3sKZS8Vof8jJyhyRTLmOqKRW8CUR34YfZNXIvDOWC8C7PuHO5sqbPa/02it444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565309; c=relaxed/simple;
	bh=l5buXz+oM8EJWAiLJhaIjMLOQxyI93T8dXs5NGyEe/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTTNKv9+qfG17WxB0hxAd2/kOuXN2vGyJjialOYdzOUEts5pP4EiNsHIKFmzlz1QhyaHWWBqjA1DIk2k8YCSxQaGXajIK6uGgGjBZAFzo1n17wPUgVuk8+aX5ITQYuuVboUSA5iTcGfHsSKTJWH42zgV+JlZRXs8GWlpa+sPCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K9D0Bo/O; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757565303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPYJyXQcMkLEdId7BxO4MJ7oFM0qGRofBwW4YEW5VjQ=;
	b=K9D0Bo/OgRTbfllmu4hqFXliRcKyLmmK+1mGlzxGgDMWOvtLZnfGWfRXyi3JWN3hk7cFLy
	lbfaB9oOodE6kWymnrpCc15eEb3PPK8QEsM6Vxk5LjH28y2/ltGw+RPnuhD9MtxpO/qL4Q
	B8hWt+ccyAidGkdy/VaPNkEirN9jfZ8=
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
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
Date: Thu, 11 Sep 2025 12:34:34 +0800
Message-Id: <20250911043434.2897892-1-tiwei.bie@linux.dev>
In-Reply-To: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
References: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > Turn signals_enabled, signals_pending and signals_active into
> > thread-local variables. This enables us to control and track
> > signals independently on each CPU thread. This is a preparation
> > for adding SMP support.
> 
> [...]
> 
> > +static __thread int signals_enabled;
> 
> How much glibc infrastructure does __thread rely on? More specifically:
> Some time ago we had a discussion about building UML as a nolibc binary,
> what would that mean for the __thread usage here?

We would need to parse TLS data (PT_TLS) from the ELF file ourselves
and properly set up TLS when creating threads using clone().

Regards,
Tiwei

