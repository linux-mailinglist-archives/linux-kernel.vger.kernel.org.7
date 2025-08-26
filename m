Return-Path: <linux-kernel+bounces-787313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E66B37465
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E025E207A18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B63164B0;
	Tue, 26 Aug 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="UdISUJWX"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21677374280
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243469; cv=none; b=Rf9Bs3XjztT7JZGV3Wu0pcf6/E3A6KVaLYsD15m7fbIpYdR465n72GWleB0pPrrSyAlJJ7isU8itiamPISeNr2wM9K4g1sD7KG8favzPywnB9HaAQHXyeawkocrTm78AKvQPVh/dxOz7ik7UxLUQreDM+C3u3vE9zA5v6BrB8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243469; c=relaxed/simple;
	bh=bIeHqDR5x2Lio+/d9xogm37m8MojaC3CGnMJ83lrAaU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=iRHSvyMUiX3Q1/4sCr4Rq2WVE3CFN5lp6V3NOzV3gMe+FZMrnP0H1eQsWpN5b2+48Hw+A0DTcxtb3aO2sr8e3yAS5WQB3/MUTvjs9+mVy+Zyft8Cv0dlkCGteosxVB3VR1BxKtOy4ho0dgk56QloevIp7jhzE4fAeajEJ3y1F74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=UdISUJWX; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DCjH1rPEREie7egGsPHawnt9rhM3tFAzCy/6DeaZZ4c=; b=UdISUJWXBlZkp+VqX0xyByrBNf
	jdtkQnYul86nLRF1w7SiE0iA0D3CL/L884iD74M6WrsAH4aCX9lEuNH56rlXeNW/ry7Qb7ByRQGgY
	ZfYgJpPBBxg+7R8kHkcjTSKRtMu9+ZpfTlREouH/NBDfcH2+0CbpzTRR040mVhY5Eo1p0+HVc2mM7
	8dnPAI1SZw8fjr+nqCCJxKp5YWV1HLu1U4VJBT4WpdsH8YmqqzZkURrFa8ozzatUC9X0rsDmHO5+5
	OcTWBL8P1cOsv73iQ4Fa+v+bSIeqMM7U1btjg9DmZC8ilFFoq/744kcZoLceWFwMg5x74kt1Nomun
	iEllWv4Q==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1ur19P-004y5p-6B
	for linux-kernel@vger.kernel.org;
	Tue, 26 Aug 2025 23:24:19 +0200
Message-ID: <dc734fa9-4b29-4dd0-a1eb-78e9907e2614@bitology.eu>
Date: Tue, 26 Aug 2025 23:24:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bit-budi@bitology.eu>
Subject: Perfected Philosophy (was low jitter, fair pay philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentlemen!

The finalized concept is Ell, The Real.
I do think repeating The Real with this makes good sence, as some people 
can be in severe fantasies. I am not about fantasies.

This will be excellent fair pay philosophy basis, and it is ofcourse a 
fair Teo.

Bit IT, my mostly 9x related concept:
https://www.youtube.com/@The_Bitstreams_Budi/
As said earlier, resonds with MIT, Git is related..

The Philosophy, I perfected later.
https://bitology.eu/

Hoping for an understanding of unification in Bitstreams OS.

Light! -

Ywe Cærlyn
The Bitstreams Budi.

