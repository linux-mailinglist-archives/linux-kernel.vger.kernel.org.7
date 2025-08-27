Return-Path: <linux-kernel+bounces-787865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C8B37C72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFED1BA0172
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7510B321426;
	Wed, 27 Aug 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="n+pitTRN"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650D18DB01
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281438; cv=none; b=oIDwBcdBSoW9UAoNlMvbyXl9qfGANs+i/uQyCNnKVwhhmhQKpATNDW6nlcImeu+PvwFe3YEcrI+StsFJ3ajQSqU494dfLg1zE89R/dRyzfiuDDDGPQf4ya+r8fskmTsPQJVFP6hbKk6QNpG8wfJWZp3BGszoF5i5W+bLfCPbxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281438; c=relaxed/simple;
	bh=8iAgX0sYCl+R5/2X5xJgUxFEnhdPlRhG/mLBJuD38YM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qtTMfO64iGcOWLTFiv3GEvyeOxYgdZfSLLlEl6GQAi7niLcZy3XgkoEJg2uRJ0wLILOkzoPuA3BRmI4G0X4+LzmI9gt/agHf1hhuFdvF5CtZtLs8gUxkgxTB2wQCHRWU3mPh4NoONNeNOh+sY0RJ9W+vn913L3xIiW8dF7kA9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=n+pitTRN; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8iAgX0sYCl+R5/2X5xJgUxFEnhdPlRhG/mLBJuD38YM=; b=n+pitTRNJleL5hSRmpEncpjJYv
	rEMZ9fDzUnMXamBixl1DDeGbbfbstYVQuxd1WEEARJpKZViYkhKyTGsnFwnmQr595DA08qWgAlxJO
	XQ6Er7pHQrSPqTr2ImyeVe/zMeK5nW2zeRuKbRa9wHSK78arGmAjT2MBOUDLjdndlHaMjPqI2cE1T
	iLD+gLL+M8cqrHtkNFL5oWKo7DLe/Dlek0aSuW9LOH/uvJbZ2hBdBk3kwsHMr5QEXhGYkVKFwC9On
	UMiUBjjgX7sXw80DZw1mshdWAbjGY60f4gYYI4NKOFemStdW2ToeuOUuGCCZwEldWXcWEqz88hfG5
	gnLUD4zA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1urB1u-0077xH-Pn
	for linux-kernel@vger.kernel.org;
	Wed, 27 Aug 2025 09:57:14 +0200
Message-ID: <dffb8686-0e9f-4429-b82f-5499783318a0@bitology.eu>
Date: Wed, 27 Aug 2025 09:57:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <bit-budi@bitology.eu>
Subject: Moved Channel (Fair Pau Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Moved channel to: https://www.youtube.com/@Budi-Bitstreams_OS

Some 9x media + history and refutations on playlists.

Light!


