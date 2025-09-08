Return-Path: <linux-kernel+bounces-805920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C247BB48F52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD977A3E93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7228930ACE3;
	Mon,  8 Sep 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLfdSojr"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465522192E3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337835; cv=none; b=X16wd2Mw5iLtSJVRmGnWfBdKTkBjCsy5sScxbcbAbC5ZfvghLmGUNDFfCZQTe/KNnutGhqtrpMAWTn2rK7rnNmRQAd8uqHQ8OhIof1r1bgkycKbVyxc/lgymvJ8HgQfcPlDax9yC5mO9vJ2W9QYTurqYog3/YAddKZnhay4L+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337835; c=relaxed/simple;
	bh=EPd83UltdMGvJmPx8SdONg4LzaYmS95mYdOCMO52T7s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G8ZlvMyIp/kw79SCYGqLh1uiJPzgyFENjbN/VGtq6wHVXkMXiqOFbafsjoTQGJ+AkgzZ/tfYNnrZiXRNx5WZweatHIyVzuFVY4naB3Z0sCWGZT5yHYcwm39hKQnq69HmEzyR0tJJJnY+kDeXKNq3bQm+SoS2vWbv/UjjF+IUyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLfdSojr; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757337832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPd83UltdMGvJmPx8SdONg4LzaYmS95mYdOCMO52T7s=;
	b=wLfdSojr2Onwr2QVHTO6IRzsZ4wRt0qp54X2B4gao0AsAvEfSRXBAfuK5Uyi9ofzFBIlF0
	MuIajks6at1aYwOYpE/bVO2EAjhNgpCEOQvW34+J0y6z0zZdpRNpaJo3b5QKRBvIOOtN/z
	YlNkJAeS6KdKNo3MednL0G4CiJAVKIg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] alpha: Replace strcpy() with strscpy() in
 setup_arch()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CA+=Fv5QdP-qGjUXQZ4ig1RX=0zx5c11gdrvwT9gqXNqTTqSZvA@mail.gmail.com>
Date: Mon, 8 Sep 2025 15:23:40 +0200
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>,
 linux-hardening@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99A381BA-47F7-410E-AC3C-D6EFA298DD5A@linux.dev>
References: <20250817231753.633899-1-thorsten.blum@linux.dev>
 <CA+=Fv5QdP-qGjUXQZ4ig1RX=0zx5c11gdrvwT9gqXNqTTqSZvA@mail.gmail.com>
To: Magnus Lindholm <linmag7@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Magnus,

On 30. Aug 2025, at 21:11, Magnus Lindholm wrote:
> It can be a bit controversial to replace the platform specific string
> manipulation functions with a generic interface. On Alpha, there is =
nothing
> (at least to my knowledge) that indicates that strcpy is broken or =
used in
> an unsafe way and hence this patch doesn't really fix anything.
> In my opinion, I think this should be a NAK.

My patch doesn't fix anything, it simply replaces the deprecated
strcpy() with the safer strscpy(), without introducing any functional
changes.

I'm not sure whether the platform-specific strcpy() has any performance
benefits over the generic strscpy(), but setup_arch() is already using
strscpy() (converted from strlcpy() [1]) to copy the COMMAND_LINE string
to 'command_line'.

The current code feels unnecessarily inconsistent, with one line using
strscpy() and the next using the platform-specific strcpy().

Thanks,
Thorsten

[1] =
https://lore.kernel.org/all/20220818205936.6144-1-wsa+renesas@sang-enginee=
ring.com/


