Return-Path: <linux-kernel+bounces-799323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B5CB42A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B43A79E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457D36932E;
	Wed,  3 Sep 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="h11VIORP"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009882C18A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928291; cv=none; b=DjmBsXzF92jcWMLMiSEzJgWV+NfJrfW7RIlvpoIOSM2S8JugMckClJZN3XxqmnjwZIaD4tFRcuTp63zfWGDzmgksACc0/jOfasPVFOZovXa16xTc7euNbMBROpDIkFApC7nabD6RW8hZMJpKfyFOAVDogdlfMwCovY4v1j+dqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928291; c=relaxed/simple;
	bh=ZmCrgvw97Dhr0XpcMksgwRtNx8nISNI3BX7U5aXXbCs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=svTbgJfCNCoylOMWzcgk3fMPrpKzb2JadUHsZoL/e5LTe9N3tM9F5F7EZVePwtnXPk1R7i/V+VNJf/d9ImiTwD3yIbsqociVl/e1aGw1oh3Iadfufm8vVjRw7mU5FPRQb7zpHttvcIEZMaAzDkMMvvucQ3WLPDX1gKAM2GvpDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=h11VIORP; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kN2iyTLdOQEHi5iAqCWbLUvn64aRzNL1Jd0h88WCkNQ=; b=h11VIORPtrY6qpE10VQthU+Igq
	nHef9tj8aFmqQhNfZbHBoJfmCDjHfx8JIIZ9wbmG03fEMJsi4YCg1ih+jPDDCdtLuF+5v2OWfSncw
	LFXtz959HnwosaKxIUAKopNjyB1lzHseJMMDXo0vY7i1+f3MTyE3jvdCdsQ7DMlyjKgJlfAJufmYd
	u6mLMJb2rpzNsEunBlNLAnvGY2Z7lYJtBmpTzALvzA2lPcqz2P05l56CZ/iSVrK+5TtX8Z19c3PEx
	QAlZKNBQHB6N5BRMZbTjKoQuQMVWv6JI/GtkwK6W9zEKaIbUmrmGCTpj/sYbyG1NNjEGAy/Yb/q32
	XdnrZmUQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1uttIv-00H6qE-98
	for linux-kernel@vger.kernel.org;
	Wed, 03 Sep 2025 21:38:01 +0200
Message-ID: <82090833-162f-4a79-803a-ce8144924b04@bitology.eu>
Date: Wed, 3 Sep 2025 21:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <itx-budi@bitology.eu>
Subject: AI (was: ITX Referance Concept, Fair Pay Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

AI is coming on strong these days.

I think it is a good thing. I already based AI wavelet, on AI 
correlation theory, yielding perfect constant Q filters, good relevance 
based audio size compression, bass area compression for loudness (clip 
these days) processing. It can be taken to gaussian EQ, same sound in 
out type processing if wanted.

AI for games seems optimal. This reduces the "leetness" factor of it, 
and demoscene, where everyone seems tired of "lamer" if not "leet".
Gamesdesign for everyone = AI. Storytype, characterstyle etc, can simply 
be a "palette" of options here. This suits Open Source, and could be the 
big gaming factor here. I even think AI looks better than manual work!

So I support that.

Your ITX Budi,
Ywe Cærlyn.
https://bitology.eu/





