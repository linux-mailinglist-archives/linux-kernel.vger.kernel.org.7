Return-Path: <linux-kernel+bounces-818085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DDFB58C74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95FB17F6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F9266B64;
	Tue, 16 Sep 2025 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="P9eMshch"
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C22AD24
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994111; cv=none; b=UfLIPj7Mf6vVJUOCj/r1cLso3X8thNCZUx6JbNVp6KmN7/QjVtHIGMXNKsm4DB3T2Ky1BYejIGEcKF1cqbJiqeGja1eZtiLjQEqvfQlpzq8BpUeWtWu1q5EBE8yTWEtvS2PMNSrJvCP5HEjRQbFxRZLW7FL6HkiWESlTFRcytBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994111; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=J5OqmG1muIirWeQ+uFijHy+T1iyd8t266jCGb3IlZBiBm0SUqQwq7Vfcy1RAjAgtji1x+UWvxgmaYRKUtU2oCTl+Bv2xKLGZ0+EsvCneoYeClBqSlB2wzS9qHe5dvdn9nVUoh9rQ7zbwa2jgY7cc/u8kbf1fpYMvQMnLZjiYzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=P9eMshch; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G3fibv953935
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:41:47 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757994107; bh=Bi+J3OZGVAfOm5T6NkD+urGUk4Y=;
	h=From:To:Subject:Date;
	b=P9eMshchvbi5jyW/mXe3UmCcmE77F5GYOUBGsZgzOkqUTGLMJMYeo23tUFRDK+tSG
	 GOnmJwQ5PNQqXdf4Q6VAvkzuZM92u5FI/m+BofRU6v4pmWLMBiNViCSb2UAKd598pt
	 e1qo99C7C2/RExWryjv2thUAosd1ifW+KIJiKwj8=
Received: from [127.0.0.1] (111-249-139-199.dynamic-ip.hinet.net [111.249.139.199])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G3a7ng329148
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:36:26 +0800
From: "Info - Albinayah 507" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNTI1NTkgVHVlc2RheSwgU2VwdGVtYmVyIDE2LCAyMDI1IGF0IDA1OjM2OjI1IEFN?=
Message-ID: <6e796fa2-8676-fb01-bcb8-756dcf5761e3@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2025 03:36:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=UojANPwB c=0 sm=1 tr=0 ts=68c8db3b
	p=OrFXhexWvejrBOeqCD4A:9 a=MCuf8VMJZhU/2X3TAKonxg==:117 a=IkcTkHD0fZMA:10
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

