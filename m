Return-Path: <linux-kernel+bounces-870260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DFFC0A4F6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3B4E25D4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397B28727D;
	Sun, 26 Oct 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="DpY6M76Z"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5723D7E4
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469050; cv=none; b=aSi2tcGqtipxaFlWbb2DyluYpQau+Bi75KK6eyN7Yjr5nFcavU5OiRK8yogYh9hW/OthZfKzYwOxXuj3tTWBkYUJOvROHzftND8RY/h9Y10MTfbSdjzy8BXFQMeJP2Yt0/N3ViZmuQjfu19C1tM099ZK5jmf5maaKOsZGYoHUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469050; c=relaxed/simple;
	bh=s4z+lnbfoCtbH+DLmKc1rIBSkfVRo3EsKwc/ip1eTNc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OkCAYaJSjqDjwhL8qGfPJgWRz7TiXdiM/AviuyLpiRh9N2/p4RcTWUyRoiy16AFmeRfmFmZGt8emv0vSQA1OVWcltOJJC4yZ22xoEGkqyPgpRkRH1zdC6esLGxw2mt04T8PsdlHHacl/7da22EWedD55MrpEjB1rw3wZzfGB7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=DpY6M76Z; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dqc/gqoXWFuGLOiNGXFq9T5Id9LHBYqsSRf+E9VB94Q=; b=DpY6M76ZCt2YCRw+3nRJm4IvPf
	jKiAinZfdavNjgK6tQJrq9178n5A5gjYhty01FegHM6GavNBWxAVObPhD+6HxHAwFk7g3+CFGwV1D
	R9J873mCd7AfutcZhHmup5XREP50jEg1KzehmFkESRIC+uUvljAbXKMTPHIvPquS0rhugrJgU9qGl
	s5V0vThIvjr/r5NWh7h0LohLW3R7GlQ0f1vr/WW3BTYdCQv6HuJhRtbKeNIVEpQDXnPSEqX2lzSug
	42MHEuMiaXFiuqdBRb/MFUHap7qLfxq8CM6UY3S1ghd1+yRlscU2OynL0I7H615zQcwXqdHM0X11q
	103JqWoQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vCwYz-0016nE-5I
	for linux-kernel@vger.kernel.org;
	Sun, 26 Oct 2025 09:57:21 +0100
Message-ID: <719906ac-199e-46ac-a5d2-06700d43570b@bit-tao.eu>
Date: Sun, 26 Oct 2025 09:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-tao.eu>
Subject: Questioning Linus, Monolithic Kernel, Agreeing on Kind Communication
 Guidelines etc?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As I said in previous mail, the LDA/STA joystick language is not for me.

"Monolithic" kernel, aka one man controlling it that is widely critiqued 
is not something that I agree with either. (So many years for realtime 
patches, then breakpoints outside sched/internals for that, 10ms filter 
in sched.c Rust & Germ symbols etc!)

One needs Kind Communication Guidelines, from GNU. GNU actually seems to 
be the Bit concept I am about, worded as a variant of "GOD".

It would even be better to drop the concept GOD entirely and rather do a 
sane alternative, doing actually someething about this. Linus really is 
L, of aLLA. You can actually try this, and it would be the L segment of 
The Coran only. Which again could be the part about an operating system.

L X actually really being Bitstreams System, a result of my work with 
popularizing the computer Bit, so we can use the native term.

The whole philosohpy (optimally translated) is on my page. Bit Tao a 
macro for all.

https://bit-tao.eu/

LIGHT!











