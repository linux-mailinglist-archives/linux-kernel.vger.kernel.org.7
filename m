Return-Path: <linux-kernel+bounces-824266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5DB88872
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AB31C27F34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FA2F362A;
	Fri, 19 Sep 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-el.eu header.i=@bit-el.eu header.b="Rd2eOTc8"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39C27AC57
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273239; cv=none; b=UwNiHaK7tpmG+CJG+V/0K/d7/aFxy4E1wTiOBCRfCvW9LXDmY6cvsGZQXDEcMlhgteiJYnuURMXZrFKC5rS3nNeJ4Y4mLcqeH3yknIjPhi0iZzBYxlvLTa3rUyKrqVpwBB03a2oLhpuFbUEx6hjtpkSA1zbWW0K/EuP41xeiwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273239; c=relaxed/simple;
	bh=88PCgOjF7t0NdtazfqiqaceXF4wgMjPF7zTjLdKSAmw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BmPusxs9zuGnd0nD9jZbZovhwR0c6AIz5lX+iuwArtoYf6sK6s79Df/oCv5SmL+rkJdzopMIF06k6Mxcu+FddfNwAzuXqVh+lBReijrLyMw+M4YgiOpXziUXite6jKtirZFx36y/mk1k+EkRh9t+DstpG9mmJfEbcvpMX8btEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-el.eu; spf=pass smtp.mailfrom=bit-el.eu; dkim=pass (2048-bit key) header.d=bit-el.eu header.i=@bit-el.eu header.b=Rd2eOTc8; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-el.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-el.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-el.eu;
	s=ds202509; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3kua+5KA59RpK1LCsxcR3eG2bHtC13IFVabv0h74VN0=; b=Rd2eOTc82N0EhaDdnfwGW37568
	/ewHfBZKknxpFSP4qkKMAbWfEFp2sF69vpStwiOAStrgBZjMZ1mZbAmoa8PwfwRJ24OTy3RltInhY
	qRolupJQFxRZwyAJ2ozkp/k8mVNywOEFTLs7WTFWXZvFxWd3Tky+tg4OWQRGMfIAHaZj1lJ7kS5j+
	gq7aaMbAfBD4G9gb2WWj8HJ9o5khrf6vmmy8CaWTmaL9c1QWRZeAiY8F5/y0MsobZ0VA6cxBTlKib
	3oUG0WLD+uTWaKx9jT3ffn495lQMk1zAJo/YS9+ddWgep38zCPL3fMfG0J2Yj3Aj5splz1V9vqcPI
	Wx+ZbQKg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1uzXBc-004pyQ-UH
	for linux-kernel@vger.kernel.org;
	Fri, 19 Sep 2025 11:13:48 +0200
Message-ID: <f566804f-2c11-4ef8-8fa9-1a9ec3584917@bit-el.eu>
Date: Fri, 19 Sep 2025 11:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Budi@bit-el.eu>
Subject: BF Kernel ? (was Low JItter, Fair Pay Philosophy, BF Unification)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Seeing corrodation symbols in the kernel (germ, rust, breakpoints 
outside scheduler etc) I suggest:

BF Kernel.

  - lightweight kernel threads standard
  - breaking/context switch ofcourse inside scheduler/inner loop, using 
cache properly (256kb cache target, well done programming needs no more)
  - no 10ms filter in sched.c, most things have happened by then. 
Instant available resources ofcourse.
  - no heuristics. One needs to set priorities etc. oneself.

Using Lambda subset of C, for later Lambda CPU.

Light,
Ywe.
https://bit-el.eu/

