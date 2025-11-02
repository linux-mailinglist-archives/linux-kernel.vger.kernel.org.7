Return-Path: <linux-kernel+bounces-881637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2ABC289BE
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 06:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387974E229D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0E52C181;
	Sun,  2 Nov 2025 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="trZIve/j"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6534D3A7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762059624; cv=none; b=UbLbcJDLOFMHJ/dlS0ejOd+ftLFcjSF4Hm96ZDKNMwQHYltMQnixbRm4LeCO1AORCBVVz96AVtJXtc2zq3EoTmrqKa/+h7O787CJ1S6ap0cx5bT7Rky4ctejxrhS7wutVbtTp27zAORsVAHAZfhrGnZQzdfkH5UbT4ahwPp8NB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762059624; c=relaxed/simple;
	bh=Mn//TadgrMRAsx5HYO2uQnPSB2p90LTfLPqR7IBXjSY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LI9I2fp8O7bLrYxc9FuIYRGy5zKyPtKV8pWoX8PbkA/m8f8WPAu1qLktMTM7JWVh6SALwxh8HCHwVcAJ1Ehv5b5RuWEUpAJNKjOmQ+0Qc3zfk25IMTTcl7XRf2/rWIlQFUTT6NnSLcTxYGRrSQU5+k7FHa38hkc72U3ALYwwCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=trZIve/j; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W51CoW71UpWmv8Z+UU8iLapunGZow3WYNRNiY0VaKPA=; b=trZIve/jl4xBhFwgaS81YZlm1u
	J+WH1u6ya9Rzv6wXu8kyGoxbsohwszwrshhlIjA7k2hSvC+NEnL4kesoq7x1bSdOHRlkP9DVVO1gJ
	E2HFsesaV6oMMD65pQKTYM5R9tNkMPI3YwI6Uh2lYQFzANCQGff34YYjNuQ6Rry2zsPq6DXHTLykb
	AdxPecJjQgK+on7TXAE3GOQAtjYOTB95iA7Dp2YHe8iO4bZTiP5gjR5nLiYRhFv+c/wfZHCewihfq
	dlo+ZF7a6EA+ffZMMWG3IQKrNe8XMSt0MMUjFA9c5W7Xpk5Z1zilysW+IG6BbhUFRsbjbdrGmyUqY
	MS9H2ArQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vFQCS-0012mN-NT
	for linux-kernel@vger.kernel.org;
	Sun, 02 Nov 2025 06:00:20 +0100
Message-ID: <1a8ef1ca-8d0d-4de4-86b9-91b0c0d84a7a@bit-tao.eu>
Date: Sun, 2 Nov 2025 06:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-tao.eu>
Subject: Bit Bros (was Fair Pay Philosophy, Unification in Bitstreams System,
 Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Updated group name to Bit Bros. (Better than "Geek").

Updated mascot project channel graphics, with more Islamic themes. 
https://www.youtube.com/@BUDI__Bit_Bros

The big one now is breaking down misconceptions about Islam, enough for 
a smooth ride. I think this will happen with this. Linus seems not with 
it, but I do not schism-attack a Nerd (SABIAN in CORAN) with ALLA like that.

Islamic culture and wellknown flags really want a good OS. Christian 
culture and the American flag, really is about Windows.

There needs to be more Islamic elements for a good OS.

Amiga workers rejected MUSLIM management. Did not use Gayle chip. Not 
following school on Cache.

  -- "Satan cannot Do". MUSLIM must fix. --

Light!
Ywe Cærlyn
Budi,
Bit Bros.



