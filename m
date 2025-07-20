Return-Path: <linux-kernel+bounces-738000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129AB0B303
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D788178C03
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3624B28;
	Sun, 20 Jul 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="f7g4d8kG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950151E502
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752972100; cv=pass; b=jSOW58EM+JWkFi5o6k1HuZXWSIaYY/yK0V0pko24tpCEcvMq8ZXlu/eNplN1wyppzZDTb/TWko0umjzr36M/Oh81Yc91PMq7li7D8Vx4N+gp+F5wI3/tMP29V+jUkX1TeRAKke93ltKhdXJJaY2QZVJuqX3ObJDkhN9DONMq0s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752972100; c=relaxed/simple;
	bh=0MzLUwc2AwbEQIEJCqyun7kRB8Z38oulGqcv7JkkXDI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CH6dmsjPhfDpStUmMGAmRP1dhgNdZoOE3UqA7tTVfeBEXfvEdYvFHDSL8jlGinrkOceE9PMqKTYUUZU3bc0s5s/flhXF6QCxLxm0UFxzfVVLQGQcTcXLAdIwM7y7HNVq9hP1FpHPK7SLBE0Z0N4XOoKE4JH4lx+q+GRbGZeXLqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=f7g4d8kG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752972085; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cAkYgHtv37ehENtfCSx/MN+lq9+Ylrb6iKdrxUJuM+5FMG77INAPMgkMLsAVBXlTbFjr4sZtJZ4Oux0or0jQWEUadg1/VVEhwN7sNJfOM/mkaSH1YfYI5tEPnjKc+QgMSrRNxHeTdBz3SS34pjhgPiuCMOiQuEV1au+rg+gMfvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752972085; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vvJnn10fiOWDfWVPGX6ZaeZ4E5cJTo1UUcUc8Cx/ki0=; 
	b=XXn+iv0PVSPCUzkeF1MYUf5E9ztSheUr0IT78Nxxycd9xLidbQ/k3C6ldh/OItWVl9CK5cGoszb5AXDBzk8z8ESaQpA+Na4RkFVDN1sb8/xUHN5aAd7h13kvtX0JSdwe8tXMmil8g7Ffh+NdDukHJqCw5puELzEDz1silqeq0vQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752972085;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=vvJnn10fiOWDfWVPGX6ZaeZ4E5cJTo1UUcUc8Cx/ki0=;
	b=f7g4d8kGb7hGMsNPPrvaYEyiryugGXPXgWXoE9wrp6MUzjdJltKbYMiPmIfRkB2H
	iyaVJktaUc9rRZ3URyilTvisasCFRiJypDZtFziiav5Ext0k64mb/Ra/TPEHPtbQVs0
	6tKQEWRilNwNBGhtaKdcwatHqcW/F3Ketrtq1s3o=
Received: by mx.zohomail.com with SMTPS id 1752972082801374.456597010289;
	Sat, 19 Jul 2025 17:41:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 0/9] drm/panthor: add devcoredump support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250720000146.1405060-1-olvaffe@gmail.com>
Date: Sat, 19 Jul 2025 21:41:06 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Message-Id: <0198AAC0-2F53-4A20-A869-9D720A086818@collabora.com>
References: <20250720000146.1405060-1-olvaffe@gmail.com>
To: Chia-I Wu <olvaffe@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Chia-I Wu :)

> On 19 Jul 2025, at 21:01, Chia-I Wu <olvaffe@gmail.com> wrote:
> 
> This series adds devcoredump support to panthor.
> 
> This is written from scratch and is not based on the prior work[1]. The
> main differences are

I wonder why this was started from scratch? IIRC, that work stopped, among
other things, because we were not sure about what exactly to include in the
dump. I don't think it warranted a completely new implementation, IMHO.

Do you plan to work on the userspace part as well?

-- Daniel


