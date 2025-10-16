Return-Path: <linux-kernel+bounces-855486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E361EBE1649
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596E84ED559
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379721257B;
	Thu, 16 Oct 2025 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="V/hyvNrc"
Received: from cmsr-t-3.hinet.net (cmsr-t-3.hinet.net [203.69.209.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773ECB67A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586824; cv=none; b=ndmhgOGHaBvxJOJyW/UMxPwB8eox6iZwpcSB22FHLBaNuu38iiSdyJWyemAiwEdDXMaAZTJfhRYASk25/sjF1cf83+w9bR0aKn7eul+e4gumDFF9WxFfPp9YeCAG8hWvGFYYCRJSZ1ggIi/h1D5tNK2eizHNLZLwTb5ZWfIDrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586824; c=relaxed/simple;
	bh=IjU/tvkSIXxzeImNoeFGesQuRtdGo7CRzpv96weA7MY=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=L1byNLF9+l25nt3BKPdyirwpsV6MQRABaYwBSEQjWAJ4lUudF33MdHzGxGxjndnSUf+HL3BZy3ysH8Bo6Kz73aqdxhKf0EmBSXJ0e2d/fk9N7eVyLRtgiSOq02dWxrMyoDZFHzDKqhzOad+G8crEFlxPyBEvYctlPe/GLx9MlJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=V/hyvNrc; arc=none smtp.client-ip=203.69.209.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr7.hinet.net ([10.199.216.86])
	by cmsr-t-3.hinet.net (8.15.2/8.15.2) with ESMTPS id 59G3KGKN174772
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:20:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760584816; bh=IjU/tvkSIXxzeImNoeFGesQuRtdGo7CRzpv96weA7MY=;
	h=From:To:Subject:Date;
	b=V/hyvNrc1PMLtOMEDk4YWCcrrInY4EOZr/zLBEkdVK6QXwT9DbiT8lfBErUh1GC5i
	 XsQTFFfWTGXQIACJgi/nkgetM7k84wuN5idoXnfVWXW3okXj4LsSyEGuwbx2xSMP/A
	 wnE2fLsi0ISjNbsy3Fhvy985kxlTi5kF9iXTbcuNmqfkkFC9vT4gG9D0PX4D390obL
	 mVcffqjv7rsw9OstNK86oMspLB5jElidMfGb7bn0HFoM4QzBo4gWFwnElam9kgZ8Lh
	 Vy3AViFfJdSKDDurPgmPo6h5e1JgNmnq2Cof4gmK7sUZD6aw/DwKlVEbFeUxhVUzKE
	 hlY8hgya6E//Q==
Received: from [127.0.0.1] (1-171-117-178.dynamic-ip.hinet.net [1.171.117.178])
	by cmsr7.hinet.net (8.15.2/8.15.2) with ESMTPS id 59G3IM1O298787
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:20:15 +0800
From: "Purchase - PathnSitu 350" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Purchase - PathnSitu." <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IE9jdG9iZXIgT3JkZXIuIDU2MDQwIFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1IGF0IDA1OjIwOjE0IEFN?=
Message-ID: <3f8776d1-8c93-2b71-6dcf-6fabfddef0e9@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Oct 2025 03:20:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=fop/Z04f c=1 sm=1 tr=0 ts=68f06470
	a=YyjmykVegiU0NE4I4/joRQ==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=DzOKOi12GxIKdhb33lMA:9 a=QEXdDO2ut3YA:10

Hi Linux-kernel,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

PathnSitu Trading

