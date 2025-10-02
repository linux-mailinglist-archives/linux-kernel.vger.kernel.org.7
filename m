Return-Path: <linux-kernel+bounces-839999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39732BB33B9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7977B4E09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26A3126A5;
	Thu,  2 Oct 2025 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="MEUyxDip"
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4D2DCBFC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393921; cv=none; b=SJ2Iez70SzgO86CmWBoON+pnz4C+ZNSf7ZGLeM4w72M/SH3lp6QQ+z8vF4z/ANrdLzh+McOcDPXs9Xh0eZOqbHRAbOb0UUyE1pfXTD0fN4NHNOLx3xjiDwTQCdt0T1zofVAkB/er58gFWrguH8FIpT3mAbbiQDvLujw9EAnup/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393921; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=p0mKLNucSB+B/+ii3zSDr1D87WJMQhDNveHnzWe6IaBT/1ymlBShravrL3omtLJjpfE/Bi6px4YkCKod5nUQQor2NQ08Z+2yFtrFVd48wsLGfAdr4z3dR/av09Az5xIXTBoTUCIoGKj0F0EVMX6v/bIIjigX6vEIzWta09+sSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=MEUyxDip; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 5928Vn0p391580
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 16:31:56 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1759393916; bh=Bi+J3OZGVAfOm5T6NkD+urGUk4Y=;
	h=From:To:Subject:Date;
	b=MEUyxDipC0rV5nTPVSc4Os4PPwUimgCNuxCRDyUg3lrjUtOQYK+arPcxak3fHho+4
	 IRnqWNMvK+EujyFiL/ww6ODeErhMh5vqR8k90V8ReW0NbFjqSDX70ysEYqofQg4OBB
	 YduMOdNcxR8HQrxHhdSRsBGlTqaFPJOvIS0tJn6U=
Received: from [127.0.0.1] (114-45-21-187.dynamic-ip.hinet.net [114.45.21.187])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 5928P0Ud206475
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 16:29:47 +0800
From: "Info - Albinayah 011" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMDk1MzYgVGh1cnNkYXksIE9jdG9iZXIgMiwgMjAyNSBhdCAxMDoyOTo0NiBBTQ==?=
Message-ID: <f75cf212-b3d5-1f14-f4e6-1ab5ab57f21b@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Oct 2025 08:29:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=a8CT9lSF c=0 sm=1 tr=0 ts=68de37fc
	p=OrFXhexWvejrBOeqCD4A:9 a=rpFWGKzpIUlGCa7q/y6Wmw==:117 a=IkcTkHD0fZMA:10
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

