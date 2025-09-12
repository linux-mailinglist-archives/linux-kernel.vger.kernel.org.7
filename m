Return-Path: <linux-kernel+bounces-814144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D11CEB54FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E53B1644F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459C73081A8;
	Fri, 12 Sep 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="iJ/w5uMM"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0C2EC55E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684598; cv=none; b=camTjnj+n/VVlploz/X/QXKmcWpwd9JMnPxowqdyNX5D1N1aVwC5/TEIK8RVycB0h0yDqreZ5+/5MfLSvmhFDh03kXKOWX0/wI0Tw7/Vukr1/HQOC6u3uZO2GbN9lqLL8CJN9mmZDmVCtAq9CILIAPCCjF0Gvf6XUEwOnsTGAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684598; c=relaxed/simple;
	bh=CfFqpqFG98wYMQF1/jUIcJaE25FAOXmtT8LtAyWAQV8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sO5SIYlzzxwjXAQ1UfbkF8pt0gbED+k7vocQOOKYknMi2tlF2IIzrgRnF6GTpt1D1AYueGfvzj8Nng0erErDLylrxB+iST3TMgsJ8+QhuFKjZ+f0frC49cunMLDfSVSJnQSc2/N0H8w5tCr924ArelHwrKlMoDjqbErszwcdgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=iJ/w5uMM; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cI9tD8jg1LvYSgAlZe++8bn0rHQlDNRQpLIZKFdSHBU=; b=iJ/w5uMM7CohM3tKz7NlXu5Cah
	gy1DbsoeZNwQ5TThLX2EsGPMG9L++wWp+sa6e6gAUponqjBKgCDTGuuvZoEczk9kmSZuAJhKEFuoe
	4SrOPAyhPJydk5Ml7pMVp+GAjP6/hEd+VDm0VBd28ynO3oU2au59b4/6L8CGJnL+bCxqXpynIKqam
	6wkFDbJu6M8hBmZ8RS7fDwx4Rzog+REezOjqaKe4T9DroKWpGYMLHQeyE0om00jzGk2ZYvtYL4qXP
	O0BfDQ+x9dSauDCOmcxdDgfO+n1LmJFL/AoB/vWAGgJU8bS6214ffSuz9A4ECKfNxZDpb44keXI2Q
	5g0Omipg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1ux3md-00H69W-M2
	for linux-kernel@vger.kernel.org;
	Fri, 12 Sep 2025 15:25:47 +0200
Message-ID: <bc96ceac-9f67-41ac-a47f-175d14dd598a@bitology.eu>
Date: Fri, 12 Sep 2025 15:25:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <Budi-IT@bitology.eu>
Subject: Lambda CPU (was low jitter ,fair pay philosophy, unification of open
 source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I can take a final polish on what I am working on:

Suggesting: Lambda CPU! - should be the best single CPU, everything done 
according to correct academia on the subject, needs no more than 256K 
cache, Lambda language C/Java like, for optimal use of bus. (1/3 reduction).

Task Multiplexing seems like multitasking with 200uS jitter target.

+ deals with suboptimal use of the expression "lamer".


Light,
Ywe Cærlyn
Budi IT
https://bitology.eu/






