Return-Path: <linux-kernel+bounces-782930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE14B3271B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE27AA6373
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCD221F1F;
	Sat, 23 Aug 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="MyfRWjdX"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7419D880
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931767; cv=none; b=DJlXcC5ujW1CU4B0SgssaoxpMOlyeKcDPdMiCc2HYSjuf7+gBA69jA63jNAWpyIxdTTx8PBvgdTicVK4YJrSXHXs5FtRTIX9OGQx/wIf8MvualyHRlMlsNV284CJVSVh0/eH45w0Jd8EtTjlfR2/LuNxBuVgAH2fqF3vIRwNq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931767; c=relaxed/simple;
	bh=qlQQrwmG2D3XsuziISKs/MALnYMGBzekmMMnxdCaZ5A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=s+neV13zvWwfxmdYXbwnGUvglCPhPPcG3+kcr8dOC/QBvIwzhlupYlY+Tcyu38wccsCAjSb2MYBWnXHSpdAh/nH9tNSv0+O2S0NGb5HJZKrn3P2FVibXCpATYdQ8Yh+4qE8nYymgtTr2vshlhjEtxExMAPQbj98CRLueXpKgrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=MyfRWjdX; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GwJbSX+jOn4V0TBr/easj64+36YMXaFvatVvRwbyOvs=; b=MyfRWjdXScYA2J9UdWjj2Qu3uw
	qys1Rz5BH+riDKjk1Y1dkkoqvLzcbYAGbwEoDQsu4j7LV7RKECXFqz2PP29vXeskbtQaU9AouPE+P
	kqkrLyJywVFgeuJMNUYTMtegEve7v+id+YKYwKapffgkv45TRtQQPZeTltXNQGgIofroluZlFRDLE
	+UplC8ihHuvDa+AQJ5xjfQQ2L+HDaWLKsr5OMdH16GVPtb0UeaGOPkE2HtLm1NIgW/i0/BmGwF4Jg
	NMTQ71yA8XueD/CeGC/Z5P6WLjz5U7H2D9aBHfHpklSfU64KWPXn7CkEvneJto5+bhIoniEUWGzjU
	gzCS9w5A==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1upi3w-0021GB-Nm
	for linux-kernel@vger.kernel.org;
	Sat, 23 Aug 2025 08:49:16 +0200
Message-ID: <8dfd73be-51c0-4acc-9049-97fb59fd20c7@bit-philosophy.net>
Date: Sat, 23 Aug 2025 08:49:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bit-budi@bit-philosophy.net>
Subject: Fair Teo (was Fair Pay Philosophy, Low-Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I´ve talked so much about Fair Pay, that the context may indeed be Fair Teo.

Yes, some connection to The Teo one needs, and particulary the Fair Pay 
aspect is common in todays society.

The interface is a Kawai Computer Bit, on Bitstreams OS. Everything 
there can be done according to the Fair Teo.

I think rather than hallucinogenic icons (that probably some will still 
do) why not Fair Teo related icons?

Hak has been used before. This could be a development further, into Fair 
Pay philosophy oriented space.

It also seems to fix the negative laden hype of Hak.

Indeed for a sustainable paradigm, one needs this.

Light,
Ywe.
Bit Budi.
https://bitology.eu/



