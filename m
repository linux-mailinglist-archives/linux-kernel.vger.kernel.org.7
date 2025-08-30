Return-Path: <linux-kernel+bounces-793145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C536EB3CF38
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760815E5D12
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57EC2DFA40;
	Sat, 30 Aug 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="M6qHEDr+"
Received: from cmsr-t-4.hinet.net (cmsr-t-4.hinet.net [203.69.209.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC63264A92
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756584668; cv=none; b=Bg437koYTfluH6rYAN+eDAYDlPeoCfFOQ+sXZ+aNu5vj5D+aGfg9eOW2yl+o9KOL9F3osx8eV0mj2Rg0j7iW1+v9lUACpKh1yaLKyppZLmiK91G+SJkjW6Lndib9RdTU8iOC/tPgwq4+uzmIQlEooZQvS+OV3KDE62ayljCPmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756584668; c=relaxed/simple;
	bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=m5wYAnOvEPSoCKe7jauiWRblg2R3ZYBhdj3r9Tbd9fNU/WvUu+MON/judsMe0XDoUEzocsEp1NV5MFarXVxSbqxrr5e7b2qo6ioDzv86Knh6PEtQqklyKw/8LA+ndBRtN33aZW5xGte2nR5OnSBy9cdW0zexotHUwEns11dgFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=M6qHEDr+; arc=none smtp.client-ip=203.69.209.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr2.hinet.net ([10.199.216.81])
	by cmsr-t-4.hinet.net (8.15.2/8.15.2) with ESMTPS id 57UKB4oB398243
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 04:11:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1756584664; bh=gzREn5ca4+YpMZqnMfnv/TdMXaFQn21PPSInZEkblZU=;
	h=From:To:Subject:Date;
	b=M6qHEDr+KZQBu0nOAIuxsDD4EsuoJWfi3b/su13gJLIcr9UbLa5nZ5vlSZPzaQiTd
	 cAdWvEedSpAHbtTP9fM1YWco4D8+hQPIHXmG/CdAbdyru6nVfisoWuj45yuWPXKYIu
	 w+wrtEi8TLVVHgs5HYAvSozCvb9/iUzw9NhnRL8KJ0O1qk1EwuNftYHG2QT0pK3G/A
	 aFwwaEY1TK7H5ErwvsfEFCZzrpQ63ACJojuzeA7CnRMH7UtP2/ElC1OExdPF4I6aEg
	 u6jQONamR2O6jTq24VQBOHZv1d8Ne18WFwlkuijfOo2kgctXvFmY1N1AQShgiuP5RW
	 svVyLaLzCYJaA==
Received: from [127.0.0.1] (114-32-56-246.hinet-ip.hinet.net [114.32.56.246])
	by cmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 57UK7w0i178844
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 04:11:03 +0800
From: "Info - Albinayah 817" <Linux-kernel@ms29.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMzA5MDQgU2F0dXJkYXksIEF1Z3VzdCAzMCwgMjAyNSBhdCAxMDoxMTowMSBQTQ==?=
Message-ID: <dc5ac00f-f74d-507b-2521-ceb8bd3488d3@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Aug 2025 20:11:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=S5B6w5sP c=1 sm=1 tr=0 ts=68b35ad8
	a=5TO5KX1uzK+j8nwYAzXoyQ==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=OrFXhexWvejrBOeqCD4A:9 a=QEXdDO2ut3YA:10

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

