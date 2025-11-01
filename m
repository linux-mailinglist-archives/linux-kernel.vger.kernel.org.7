Return-Path: <linux-kernel+bounces-881335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C552C28086
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F39004E1576
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30323AB8A;
	Sat,  1 Nov 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b="mTf2D2Ts"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39E7261B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762005908; cv=none; b=UJTLvtFO5FeGdQsCMgzmMSOVIIvl1wORAiT22dnlk5ok7sdURdolPT0vSe0/BuASsvqtGcrBe1DW6GXLqjR2HK2Vmk2FlG7bMoTIkKCc7em7ufSXxhrh8gszHfK55KXJJOspwjCv2Q6ajfERA4UBdWUOSpRdSxaczw2dOAKYiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762005908; c=relaxed/simple;
	bh=eAm5kFU4eLjfvmS1rz/Fg0P98fu1/zs14s1EHWAT9LY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WgaMKgA8g1vRLRV8wrZJpfwyy6GunLQ342KpC5fNM/GkDKt31Ea3XkH4RCJKf1DNUBOoR+IHBVB1ILfwNnNACRlmK774ZvUZ+9q9a66ctnEDVLLqZ6+ZgBsvIgoX7D4bNT4yVvwGUd6B/WySL3NFWvK/GOke+fV8iYTRiepVhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu; spf=pass smtp.mailfrom=bit-tao.eu; dkim=pass (2048-bit key) header.d=bit-tao.eu header.i=@bit-tao.eu header.b=mTf2D2Ts; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-tao.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-tao.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-tao.eu;
	s=ds202510; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LrfOZLFkmdDc2zPaukbIADOKDBlys/n+6ZBvDpVmvpI=; b=mTf2D2TsVtYMAJFDFVaFFGb97A
	cRvccEl1ZxdJH/7U9TZAmbWAE2HZ5ClVGtQCUa76/4BClmLPEk6pxKud0VD0d7QuyLbFcRNAgv5rH
	mjVFLn2RKERFE7tP1SD94zBB33/glhrQJVceORyYDqR0cOKgfFByZMJK3FICazLG2nSYJdQzHmbh9
	x2p+xnQ7R3b5BT/2hLM4F2vZKTdh4zlS5M7n1/crebi3U1mREMuOP90YfbTmgCdaPGzjaxv8OjEqz
	Xet8rhdFmakQlZd+QFOyq5s9VwGS8JVY7qjPUmiRPpM8FqhrvhYVIdfZVLriGgLO8JcP4dT0qYob8
	OzwtEKTg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1vFCDz-00GWAN-1B
	for linux-kernel@vger.kernel.org;
	Sat, 01 Nov 2025 15:04:59 +0100
Message-ID: <37a9da10-79f4-4f4d-b2e5-12409a0aab52@bit-tao.eu>
Date: Sat, 1 Nov 2025 15:04:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bit-tao.eu>
Subject: GNU GOD = Earlier version of Bit Tao
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Know that GNU is an earlier version of Bit Tao (GNU GOD).

So this should be familiar.

My research and that I should do so, is so famous, that it is this 
phrase already.

Do see https://bit-tao.eu/ for the fininshed version.

LIGHT!
Ywe Cærlyn
Budi, Bit Geeks. (incorporates all of HAC, design, related).


