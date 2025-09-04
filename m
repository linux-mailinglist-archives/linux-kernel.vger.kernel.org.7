Return-Path: <linux-kernel+bounces-800441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F005CB4379E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6775189BBCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2884F2F90EB;
	Thu,  4 Sep 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="IzbD0+2u";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="9gUm64XN"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8672F9C23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979526; cv=none; b=l2Z+2np+C6uCtBtsnMVgeFKn40Mxuwk+EUU84ZNPqcRr3CJBCPHvfCTWhQoAGctzV2+NpagYlugO8qQHphpBVA8gJWvMp4Ga4NWNoG6gzEp7CkYSUcBc+brazVRtKFjxccKithGowwa6uZOMgMHT+CYdusLVvuWpt/XxbbeAMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979526; c=relaxed/simple;
	bh=kAhDKjDH0/7hCdvshzbpJuJxL8ynu+aHcOlt/BEHvIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSks/xGcC2stnfrM9A94gpRc5H68qNICBGVez9/vUuDh2S5DBuqk8pwf1ulUv0Eib4mPUKF2Dh88uE3oJIHsbFkPpB9UsUtY1CFAeKpIxI9uaJ+wBHCy6F4kW7JG2EoeTw/qEqH1OQbzvAaoGQnkwpEB9hRdgL4QB3hNTAJ0kGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=IzbD0+2u; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=9gUm64XN; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756979520; x=1757584320;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=4IuKTho9AadcM+Re0nAwehN+zaegfeyCAyeD2EXwBdM=;
	b=IzbD0+2uO5U8AscM4gquZJ3tAqNYStOBjdL12NYAp5Dcjn9XjytYchcTeGTLBkv9MrLBGRQL5iM99
	 Z7SzMmgVKEHmrEp+cahwgJ3hVdsZgsFe7JYrmeYLVabFh+SDMhBPZS9qXF3ypyxo7iZBN5mo+X2m/R
	 VYtWh63Vg8yv8TfqfXXzikRsJUD3wwAXpT6HNW+hEcbT8+pik0DHWx5jqK8J/A4iOs1zGxrBZZTv2G
	 ZtxxUkFwA/zSI7Pmv1D5H/lhj/uEHltqBju9KJCYvwpdQ8RiEHVlRIKQ7ibC/jhh210BjX0/l/0SeX
	 1Zg+/0ryeDCbc/GaMc0+pelej8Oi7bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756979520; x=1757584320;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=4IuKTho9AadcM+Re0nAwehN+zaegfeyCAyeD2EXwBdM=;
	b=9gUm64XNHZ4cOo/2ZWkc5UqXi6ybhDmmSCuReZQFe5x22w732XhYI0nMT0nGI6mlW9Q8rPeC+QePM
	 QMQ/EojDg==
X-HalOne-ID: cca8378f-8974-11f0-940b-632fe8569f3f
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id cca8378f-8974-11f0-940b-632fe8569f3f;
	Thu, 04 Sep 2025 09:52:00 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: Re: [PATCH 0/3] mm: remove zpool
Date: Thu,  4 Sep 2025 11:51:50 +0200
Message-Id: <20250904095150.2770293-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250829162212.208258-1-hannes@cmpxchg.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

