Return-Path: <linux-kernel+bounces-800405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47227B43746
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677D27C5B20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA372F747F;
	Thu,  4 Sep 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="ZmaUn4wn";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="4kaiBPQt"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D082F7455
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978447; cv=none; b=c3y80Fbl8PR4L0F6phtGPft0jNsgLJY/lFYdLW1UrM4o4Q1PUOA73bl5Aa2wMyhE2EUbNhrmMa/sEToa+zrmz4a31bVKhsILIjkO0EF1tFDzgHF/utBHXUYyeDTiM3T3ulV7GS/l33GYzS9Ggm66GEq33xAtv8kUCywMlt/QJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978447; c=relaxed/simple;
	bh=kAhDKjDH0/7hCdvshzbpJuJxL8ynu+aHcOlt/BEHvIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5kptf5eXvb7nXDuzCOAnhjYU/d1Y9p9dJmHgcgJbtHgTGIgSjxZ8qpnFW3OP8h+Vl3IzHvbLYl/g9cp0X4gmeW0FnF2GwGJOgHK0/iMUtD7uAkliQ6TLAqWoZqXCtt+golmWbgowmKZZQ6Ybf3gCqbrcm1vAt5RQSY/HWI573w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=ZmaUn4wn; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=4kaiBPQt; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756978434; x=1757583234;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=4IuKTho9AadcM+Re0nAwehN+zaegfeyCAyeD2EXwBdM=;
	b=ZmaUn4wnej3tj0YPURzSnREubQR7uz0uoH5s4PsMUCGzyOagNr+E+eR5Ab71zSmt8k5c2nin0lH3i
	 oep89GfftkxOZiLG+tMIBCdq6dUeLMfzNNgB9yBYCi6w/op+YJd6VkpVYegbHJxr+q0x1zeyhza4UH
	 APLp9hlPx0PiEPHsRmskPD0MksbRo9CfpXXt80nXlCaCYzArOj0m+KxB+06lmT389GK0UzbFTn8rBq
	 9yGzGT4OyKzNhNzQ2GSGBhoXiBRfSAXzBm9H6cbhGWvTCUZHNKMMGF4ucrns1b7x9Jfx7cMXDQ1nAA
	 hvSuoLTO0ly/VQ4byqnvjqwP6jZAFaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756978434; x=1757583234;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=4IuKTho9AadcM+Re0nAwehN+zaegfeyCAyeD2EXwBdM=;
	b=4kaiBPQtOZ/PWNLcFNX3C1uWz0M7ZqHYVA1wUtVitG2pKAYKIz0+b7gh2ytX5Qe+YuDykFtycLGbE
	 vE+uZE8Bg==
X-HalOne-ID: 44b5596e-8972-11f0-8a3c-85eb291bc831
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 44b5596e-8972-11f0-8a3c-85eb291bc831;
	Thu, 04 Sep 2025 09:33:54 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: Re: [PATCH 0/3] mm: remove zpool
Date: Thu,  4 Sep 2025 11:33:24 +0200
Message-Id: <20250904093325.2768507-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250829162212.208258-1-hannes@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> With zswap using zsmalloc directly, there are no more in-tree users of
> this code. Remove it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Per the previous discussions, this gets a *NACK* from my side. There is
hardly anything _technical_ preventing new in-tree users of zpool API.
zpool API is neutral and well-defined, I don’t see *any* good reason for
it to be phased out.

BTW, remarkable is that you didn't bother to CC: me to this patch.

Anyway,

Nacked-by: Vitaly Wool <vitaly.wool@konsulko.se>

