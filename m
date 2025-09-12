Return-Path: <linux-kernel+bounces-813698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09DB5499A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03C016DE02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923722E9EAC;
	Fri, 12 Sep 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="Xo+3Srx4"
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A17C2D1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672513; cv=none; b=P3hFO170+GfkxabPYLhxgg2pftrf0AlFsTLbpOtsYcCZui5/ZpDCnDhlJakob2qBYE3Nr6hfDKGK/9g9p9jxLKrNigM8dO8AJKY9yTVMCdUyXodc0OnX3TV/zI9FUNDBlB0PxflwBWXJ3vFZmD83xsMWa7nwdoMIb3oU2+gmAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672513; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=hqrjFDA4vgjpA8xKJa/C56jSE4Uj/vkIhgww9f0Dy+eRAaM9/Y76m4j+9CR82wCrDiWQiAHyCLCYILhuzEhlwZ0gPCHkFaXXIBZIRy2HtipDy9BI1juLlaVB7UGxk8amhLsxFTq6CxxEGxGFrpHbD8nG2tvGFyzMFhk3iQbL8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=Xo+3Srx4; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58CALkVk161050
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:21:49 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757672509; bh=Bi+J3OZGVAfOm5T6NkD+urGUk4Y=;
	h=From:To:Subject:Date;
	b=Xo+3Srx4JtkejaYWL0ykdNSiXB0dGN5Nbe84IrlR3/qi2x1Ph8pbjBC2xQRMBp+GS
	 asC5rkr7+TpKegndglABte39NDfKpfWA/lFlmZ9ZjpB93poMNwvI7W1pWLtfuazBMA
	 Us9dTXicY4ZYrWr02HEABQOVfvUjR9wP0R8QTJcQ=
Received: from [127.0.0.1] (61-228-55-181.dynamic-ip.hinet.net [61.228.55.181])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 58CAF6Lk511552
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:16:32 +0800
From: "Info - Albinayah 886" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gODI3MzAgRnJpZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjUgYXQgMTI6MTY6MzEgUE0=?=
Message-ID: <32907fd0-e978-0418-f26a-999caa71329e@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Sep 2025 10:16:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=Au5N3/9P c=0 sm=1 tr=0 ts=68c3f301
	p=OrFXhexWvejrBOeqCD4A:9 a=yt2vnJcufJgYEsdr2blA5A==:117 a=IkcTkHD0fZMA:10
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

