Return-Path: <linux-kernel+bounces-896957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC47C519F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FAB234D5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C04302148;
	Wed, 12 Nov 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="zmRAw9uF"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011493019C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942882; cv=none; b=ekhI8HMOZ3j1+PpDPnP6ZSg6iW5A3HVUftCRYplTjAiJYIECvBBvSfWybXBcQ5eAjvlsk4hCBQ24ZVFXqRYHg2yog2YK45kd5lGla98w4/x4/4FHsXuqSSihS2fiFEJmDK91LEvQreCoD8CGLa8RwG0Rkfbq8U7gb+h+bRCW7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942882; c=relaxed/simple;
	bh=bsBYQtPl8mGsIkKPMkzI8Usm1LM+X6yRbjnMUmzLOx4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aHZ0QlI2rdCEFnxqMuBGs8Sghn3DRwaapsjRfvtMulfo/5Gl16Qt0dOHifxtLePbNbayEHiJ/NsWXMS9iSLjwwgJZvtMX7HG2o75JUScBd9Xcc2qiswHqrCBf8R90GnsO1X88lZiKt/o8blS5u7MhDgVTO7cVKMbv+yk88FNmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=zmRAw9uF; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vuAQe1dv9ghEMscAevQFicw/V9GMdtu4Z2b6tPPz8lk=; b=zmRAw9uFYGmWutEP6i6d/oMEpQ
	0wDvNwBxy4Muuu7+3nUmGsaS5tO7+KxQhiB0dFJGFZPnWBByCzkT4caQrj7xIYzs+18zFdwdc549H
	kE9SgwD4YBU7jcaXNz23kAF7Ue6q1W57GyrNX4qpOmuUIen8YyoIXGvthlB/zi0FQc8SODTgjRWfn
	/986V2SUkWBUgg6/iCKfVJXegF6gOW3UnsXgXJpVC/B66oGQ6rEWddiVr3ur6ede82Zj28ADpz/WE
	hFI1Xygs9piBR4tUXaLBH5jNocuNa+MfTB+ZjRZbkCIwnq56PHeH4k4elujCzhxXaKWD+oVjVw0HY
	z2jL0+rA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vJ7yS-0097zW-LD
	for linux-kernel@vger.kernel.org;
	Wed, 12 Nov 2025 11:21:12 +0100
Message-ID: <3b309213-be06-4386-8c51-6967127f3676@bit-tao.eu>
Date: Wed, 12 Nov 2025 11:21:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bishop@bit-tao.eu>
Subject: Elf Desktop Unification (Was Fair Pay Philosophy, Unification in
 Bitstreams System, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I came to think of tweaking Gnome desktop, being less buggy than KDE. 
But why not try to unify the efforts, indeed in line with the Unity 
project aswell.

Elf Desktop would be this.

Symbolcorrect as usual with things from me.

A good conclusion on Desktop Developments.

And optimal fair pay politics, with max sales potential!

Light,
Ywe Cærlyn
Bishop
Bit Bros.
https://bit-tao.eu/

