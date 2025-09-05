Return-Path: <linux-kernel+bounces-803507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19495B46147
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43D4188ABED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB635CEA9;
	Fri,  5 Sep 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="Ck9sgU9v"
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0356309F08
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094998; cv=none; b=KWZg+UK8OQX+xydCkDfbUk6iJ+hpLUzTtW3SjK3pRGmVW72L8e3QL20jPP4TseW6ge/fcQ26gzNSW/aK93IL0aBPxL3HmiDVdeLK7M9heBG0rA8EpUFpFiPopxC/8oiCs3mrBKcQVXDkKArNFfprTphWaa6qCJZqmdeLtKGGlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094998; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=VduvJxKddPjxSEMio8dN4Vv+J6NINBUTKZ1Xii5u9uWbr4IYBIUk96dffDHpEMDzo2ichxqumtnEsDGetW02TMRL9kTyfY2iYaZ89s+xki/fVfFTqGogP8n4by4d34LM4w8MXNVc5MqeVOf1wSnLqleIUtWzmRZqFDVZefLUAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=Ck9sgU9v; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 585HAHth544454
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 01:10:18 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757092218; bh=Bi+J3OZGVAfOm5T6NkD+urGUk4Y=;
	h=From:To:Subject:Date;
	b=Ck9sgU9vbjJR/ouqVne8GAQoCDJWY05PGfMN1ll+gajXWXHHUKIrlBoDof60wtXt8
	 1vEKMP62ydkpsLetibTMkr2OHoXtiEC7AZtCyI0rCj50E4sVOynbJ+ift2I7+YpBYo
	 T/10Yi+trUZ55mBcBsig0+GPrnxsLtlCH1bvtq6Y=
Received: from [127.0.0.1] (1-34-243-55.hinet-ip.hinet.net [1.34.243.55])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 585H6MUJ381368
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 01:08:58 +0800
From: "Info - Albinayah 402" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNjk0NjUgRnJpZGF5LCBTZXB0ZW1iZXIgNSwgMjAyNSBhdCAwNzowODo1NyBQTQ==?=
Message-ID: <5b3a9e03-4865-b5b6-718d-7d6c40bdfc6e@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Sep 2025 17:08:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=Xbkqz555 c=0 sm=1 tr=0 ts=68bb192b
	p=OrFXhexWvejrBOeqCD4A:9 a=zRdXdCHvnK3BYvDO02d85w==:117 a=IkcTkHD0fZMA:10
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

