Return-Path: <linux-kernel+bounces-820796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FAAB7F39A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D977622C75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411CC227BA4;
	Wed, 17 Sep 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="ffOwpACU"
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D12FBDFF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115314; cv=none; b=XQMVzH5t5ZnMGWe+zuUkCVb34tK3lXqwbjplWZ8q4Nb7WQQZI2cByuf2azYPR9KW/t6J1hKPx/2GRzuR9DfmTYYKkz4dZjOLJdElTE357sYloAqClJTsgWUTJE77Q3iBQ2w6U4SwQqbmPAb8SZ9g2069yJJgOzGy1uVHgY+IqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115314; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ivz+JL3EH3BpgjtN0vAglv2P9yydul/c0kKynsIzmGd/yzPrtwzQ2vxq2PTuWShvvZKUMuP57UfG7xL7yhIPmKG0l25PGT+TmgZgLyCS4kt1X2LZyA6ClCbwkzVC29OXKBzuQM7NbAW5EVIhBqoWGUkXFh+JOR+g5GjrY6Zo1uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=ffOwpACU; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58HDLkPm334785
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:21:49 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758115309; bh=Bi+J3OZGVAfOm5T6NkD+urGUk4Y=;
	h=From:To:Subject:Date;
	b=ffOwpACUfPUgtZig49R0WVwojl729dEeTNHRKSEdCVDP+9yrsAWmeWgUxmmbcQVNV
	 xYzRaPop37cNTFuP5lVk6lS5nGpA3JPImxGvbRa1aH0tJkElY8Zrg2msDvXnauQyfu
	 nKvLqnZPfThkCJWVHKKp49IqSfGVSkjP8OaTQPW0=
Received: from [127.0.0.1] (36-238-8-80.dynamic-ip.hinet.net [36.238.8.80])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 58HDGxk4708064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:18:02 +0800
From: "Info - Albinayah 952" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMjI1NjggV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTcsIDIwMjUgYXQgMDM6MTg6MDEgUE0=?=
Message-ID: <3be869fc-3dc6-37be-e41c-c05599dc045c@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Sep 2025 13:18:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=I/PGR8gg c=0 sm=1 tr=0 ts=68cab50b
	p=OrFXhexWvejrBOeqCD4A:9 a=fMZ249szo2rFLKTy60R/tA==:117 a=IkcTkHD0fZMA:10
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

