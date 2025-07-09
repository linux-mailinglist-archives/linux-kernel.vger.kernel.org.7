Return-Path: <linux-kernel+bounces-723429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB7AFE68E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BD6189427A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510C28D8DD;
	Wed,  9 Jul 2025 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="AKUd63V2"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF4237713
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058625; cv=none; b=EBM51BnBc3MQR8PmoF8oronX16o7z9tDBDchPuVTddh/q0H8BDuWFwTTe3nMoOxJtm0BA1FnQq8RA3hUZaOiodr5CdDd0HDBYi5RscPLWZ+NBF+oz7rmHSEYT2ArFkD7uT1A/kwSULXDBkbBPcxpQAcRdV4FbN2q0KCjcy5QCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058625; c=relaxed/simple;
	bh=GD+oLdYPFv5qs0xDlMTc6mpVwvYGxFDDnsxbu3I0gXg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mahzzWbyUJUYI8dW25tNA78pyxVHfWLdDakpzCxJEEVJf2lQKSTyMdwD3Ilr0GsKY19KV9xqK66VYqJg2GR8ATHJF+9FvtoT7C5oHxwO55id7y/ERYARYaU7jnSG146plPIMfJAae8H7Gug7DQ0P+By1qINFIWYJy/BoJ+IJH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=AKUd63V2; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zyub8Y7CWXPwezIoOLfztkuwjghZTnfH08549f8YEFA=; b=AKUd63V2LN+NwjpBDgZ9zR6cq1
	Go9HYHiFozQHOg6kkxblU7SLC26CWCMaLyd3EWI+HY5DBL0kIkVnsKSvtmzLtz/Y9/uwJ+rjUGtAO
	qskwlnBL2ijVxxnmclzsC6eWeTUtwA4McAzteci76H/hXyTqUGBB5zD5IVqfgIuD7VGQnJt5b+pMg
	QcjndiBztxKTEUqlXPdqumSyAVUX7Ycsy+CFRpjKB3Qg8kJJNUnDKqH1RtapKgRg+UYzE8FFIseC6
	6qkGfVk5zZJAY6985P4TVOnyjBz+mJnpMzBZ0MMETkkLDLzWrdYpWUbwgT1FCKCloiCHd8O5kj5Bo
	UYuaCoCQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1uZSTv-006cu0-Us
	for linux-kernel@vger.kernel.org;
	Wed, 09 Jul 2025 12:56:56 +0200
Message-ID: <fa2d2897-6ae8-40f4-a5f2-72f3643c04bd@bitology.eu>
Date: Wed, 9 Jul 2025 12:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bit-budi@bitology.eu>
Subject: A Setup Approximating Bitstream OS (was Fair Pay Philosophy, Low
 Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Img: https://www.youtube.com/@Mugot_Star_Bitstreams

I have ordered a Starlabs Byte with MXLinux and Bitwig and a small 
controller (music) keyboard, updating my phenomena, to an approximation 
of Bitstream OS, and typical setup.

Low Latency of a good Open Source system could be very popular for music 
making, which I have been a mascot for, now this.

I also suggest my AI Wavelet, for correct Constant Q filtering etc.

Highly Recommended.

Ywe Cærlyn,
Bit Budi
https://bitology.eu/





