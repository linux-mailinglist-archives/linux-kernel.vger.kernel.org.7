Return-Path: <linux-kernel+bounces-882740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B5C2B4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F1918922A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95100279324;
	Mon,  3 Nov 2025 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uwm/QCgn"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079062FC013
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168984; cv=none; b=pWm0LJLwSN1I8Nnp8QY5CRTGcLmqUGzmVq/pMbz9Hb5ieuHvJLQeEMSsLdBrHcJjM3fznchXY2Po4YxGHTo44aro34VJi9DmNkgRb2g6sxaTsp3MPvMZDhkHoQi4dTOkhwW9yDNBHhKUGbZYpqKWIPih77D4gWNvin6z7c63KgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168984; c=relaxed/simple;
	bh=g1eQXAuOq7D0vC5sOgAHDAXaw32TdgOgB2f1s0mir7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMy4j/kJzb5YqaMBtMHKj/VIbmyQr5i5GvQs0lr65sewTlVE/aRuNRtfZ6dP7AJbmLbKZ7CJE2+Ug8N1OoN9WudFZQmsTKgzcZojsPumZwFcJQFJ4Vzcj/B28cKqNilRlIPQWnBmhecKwVjjYsPsvfuoFlWy5ww/1mpauzqraWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uwm/QCgn; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d0Thy6Pz1z9tg0;
	Mon,  3 Nov 2025 12:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762168978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/B5cSi2gvG8WS+XWr9mKVvN8RRTThm5Yd3lpHPpvD0=;
	b=uwm/QCgnP04rIAxBD8Seqrz57i6K8YDaj8DN+RJUocasdzWorlz6UnN9ihGSnyD2RqKfrn
	66U61IRN71+ga3IYZcP13G1k1PyQV92JpIUS3u6RuoF7CN5KlnUI1DdqC5DLsw8ndvHYWy
	bfgaBpt8uUVCvBGGZhohsYLs8WcHt9nsjG1QbP6qHNWSdyhXhobXFBjqdJMbEfFdeZYYZK
	fZ1/DleXb7BaPygi4BeZEF2gSrDtdEgPjQbiQZoT+HFHR3wXQ6M6hQfd0DfdlDDu0ZORyD
	F4e2IKQ/oQV7ZeBIZXGOXUn8awEcuEJrMprA3/sJDfvxsh5Ay3LsMQgYvade1Q==
Message-ID: <f1abafa2-97e8-49ad-abc8-c71914ac2212@mailbox.org>
Date: Mon, 3 Nov 2025 12:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: Add "min bpc" connector property
To: Sasha McIntosh <sashamcintosh@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 trivial@kernel.org
References: <20251031204534.659180-1-sashamcintosh@google.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20251031204534.659180-1-sashamcintosh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: de984f8e742b7750fb9
X-MBO-RS-META: h31ojnu9ox344y78z53c4jqnpaxg5yw1

On 10/31/25 21:45, Sasha McIntosh wrote:
> [Why]
> When playing HDR or WCG content, bandwidth constraints may force the
> driver to downgrade to 6bpc, resulting in visual artifacts like banding.
> 
> Userspace should be able to configure a minimum allowed bpc.
> 
> [How]
> Introduce the "min bpc" connector property so the user can limit the
> minimum bpc. Mirror the "mac bpc" implementation.

One issue with this is that the effective bpc of the link (as observed by the user) can be higher than the physical bpc, due to things like DSC or various dithering techniques. So requiring a minimum physical bpc could artificially exclude configurations which would otherwise work fine.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

