Return-Path: <linux-kernel+bounces-813759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3CB54A64
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B2A3B6CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D6F2FD7BC;
	Fri, 12 Sep 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fayPsz55"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4427C172
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674293; cv=none; b=ghR9vrVsF+wXj3p1m+IK0AQkCRxoloMpmOhyZA+prdBuS56cuWoL0gn5G0e+f2KhgZ7lMt4HR2j92YI4iBN7eYqaDMUMD+5i6A/jsHDnzogcAbpqGKpyuTKOBES369ILqtFQBIdDJgoz4v6FojdqhQZ+yRXtlcEGeCBuIf6HFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674293; c=relaxed/simple;
	bh=Zw+A3t7w4cOmZEzuioU++ZQQcOKhv4BbNs0/KsI0jHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/PoUgxKBjmaiy1Fw6kBjb4ZYo84krZoP5H1XLOyp1enXc5wwjb4fzYKYDHt+mEk5zxE1yqsKQkVRsNG4a6UAqYuOaF1DFJFh3lOJvXibdFUWf4+2zbIYeC4KhbdGeSovFnByvNa6SVt3OEZv6u/7R4Evts57x4Ob5l0gR0sL2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=fayPsz55; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id wvtEuhuvfKXDJx1NEuRaCH; Fri, 12 Sep 2025 10:51:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id x1NDuuZHvg4f0x1NDuh8wm; Fri, 12 Sep 2025 10:51:23 +0000
X-Authority-Analysis: v=2.4 cv=CrO/cm4D c=1 sm=1 tr=0 ts=68c3fb2b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=SsH6CVIiC5XJadHIxOjS0Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=UoEejXNiLGVHoiWwixIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IrnpyBJSPsgtoan6QFAE3chWsefAMYPi8hujFp83vTk=; b=fayPsz55JbZMs+IoOgQInhx0Da
	oiZc4cun30kBj71Aea50mbJY+fkopxtnZDt8VaIVxi4HH9sJLm+dOh0+DeBpCT/hKqVoC3K14ggav
	VkOarbkAz3FrbDu/F2HERAHOSELlXsqYRvv49aJTdox/7/WKO2ODeLLwPIqCFoKicCgAE5mBf+u1E
	Rsvn7wKHh/jVWcwJuYtBbpmnx5MdZdJ2o/sDs/GP9h0uKw7kliWoFQq8I1NvqVKx2T0LAVe5cPC+B
	tXd/IgUXArTxk8d0q/AdSMLdef1x3eIIyAYRz8kdijC094dDNZzhsFtJcNOZwygR72zjiePfjRMOn
	nKs3NpDw==;
Received: from 40-228.dsl.iskon.hr ([89.164.40.228]:48812 helo=[172.30.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ux1NC-00000002dZr-3XGg;
	Fri, 12 Sep 2025 05:51:23 -0500
Message-ID: <7a3964b9-e21e-4ece-98f0-f0a2bb013d2c@embeddedor.com>
Date: Fri, 12 Sep 2025 12:51:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] stddef: Simplify TRAILING_OVERLAP() and improve docs
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 89.164.40.228
X-Source-L: No
X-Exim-ID: 1ux1NC-00000002dZr-3XGg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 40-228.dsl.iskon.hr ([172.30.86.44]) [89.164.40.228]:48812
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNb6tbIJJnMG/v7shOqjpwhhTQroU14Whzblvps909hTQTL9Q89HaLEkL94bqUBXvE2D5Uh8CQEGs1Ugqemx4wlYclqQnUQDmNJFblUQFvESIwACd4zD
 oxzr1bFqWm2TfdU+UVKmrcRL+62OHsqLoracU8Y2puUJJJrSz+AF8/P3SAaVbZq6jV6hE7YfSzS6LjDDpoNPEkHO1/zPZ8Q2LIaSAiojysbO/3XIcnjSdFxi



On 9/12/25 12:28, Uwe Kleine-König wrote:
> Hello,
> 
> as a follup to the discussion I had with Gustavo in reply to
> https://lore.kernel.org/linux-pwm/aJtRPZpc-Lv-C6zD@kspp here comes my
> suggestion to improve TRAILING_OVERLAP() for wider audience.
> 
> While working at it, I wonder if __packed should also better be part of the
> macro to ensure that

I have patch ready for this:

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index dab49e2ec8c0..b20ff76778d5 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -93,6 +93,14 @@ enum {
  #define DECLARE_FLEX_ARRAY(TYPE, NAME) \
         __DECLARE_FLEX_ARRAY(TYPE, NAME)

+#define __TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS, ATTRS)                            \
+       union {                                                                 \
+               TYPE NAME;                                                      \
+               struct {                                                        \
+                       unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];   \
+                       MEMBERS                                                 \
+               } ATTRS;                                                                \
+       }
  /**
   * TRAILING_OVERLAP() - Overlap a flexible-array member with trailing members.
   *

Thanks
-Gustavo



