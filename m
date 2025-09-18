Return-Path: <linux-kernel+bounces-821945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34EB82AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB68B3B1BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C822129F;
	Thu, 18 Sep 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="iyrxMfQM"
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F731D54D8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163137; cv=none; b=lE8Gj9d2mcWWeBlNj84Wn8tbq1UbmS7cYIQhiZd69nkSMbKxEWqbPR2K7zfQ3pTi/mXKAxA76Lv61HHOt5UUNi+8ou5pa/g4XMKx+22TzP2O/xO3M/vX7C4xXY0s7uAGp/rppFhjMYjXmsOBbEj5G62OW53DFs+vjN07AVZP+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163137; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=EIZMsGySaCB/dN/66zQIebR1UkMMNGsjeuLj2qp2CbdFBzJti8MBqNNfImL8/DR7aSoO5ZQevJ+So5zx8fHLoS8m8WvLFW6zwY7SYVVBF8CoyrEPY60bnvB1P6zlfwt1DNIymRpd3KhY7f5XUORFhHFGLm3B/e1/5c3umxr/EYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=iyrxMfQM; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr9.hinet.net ([10.199.216.88])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I2cpKn453653
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:38:52 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758163132; bh=Bi+J3OZGVAfOm5T6NkD+urGUk4Y=;
	h=From:To:Subject:Date;
	b=iyrxMfQMAoD1DNs8vXFcs1dWYEmB6fdFxDHE5WL+KMBTbWBhrLN608MkDdJ2QdY2s
	 /HPY9dcHO7rGJCwS3dA2JJrMdOoW9CBzDNOUlTUOigmxzSKNCL/gu+Zk7WQ1FeRwzP
	 mR0Y0HEDtRURhYFG/s/GV68+3QUlFa0vUtXUHScs=
Received: from [127.0.0.1] (220-135-222-141.hinet-ip.hinet.net [220.135.222.141])
	by cmsr9.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I2WOUM559901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:32:35 +0800
From: "Info - Albinayah 441" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMDcwMzUgVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAwNDozMjozNCBBTQ==?=
Message-ID: <1679c4ef-c5e1-63c8-9d4a-5bc5a0952bf8@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 02:32:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=LvQxyWdc c=0 sm=1 tr=0 ts=68cb6f44
	p=OrFXhexWvejrBOeqCD4A:9 a=pzb2b5cqp1ma+Hra5Sxq/A==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Linux-kernel,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

