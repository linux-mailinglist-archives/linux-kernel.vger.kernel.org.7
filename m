Return-Path: <linux-kernel+bounces-815746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7EB56AB7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3821E189CB59
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200E2DCF45;
	Sun, 14 Sep 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SFL4RnNg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AD19C560;
	Sun, 14 Sep 2025 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869438; cv=none; b=JvOa9hc9dKlliKDGuazv7cqJGQCYSbH2kIP7MfzYs2snav39HrismiVVMXjVEMbaxlnOIa2+KDB3iawjpayM2G/+yjHLAm0HMrYmHeCJ27txKnUB9em+wksH+jaThFpTYgKb7OtNz6bBqxh8OOke1k5V0ELNSTBV8LKsKJ43jjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869438; c=relaxed/simple;
	bh=jJD1PLKgscuHcdkTTdVPzDMrJvlY5RFXwvnNuKjZ4yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6CrJocBd07Ca9OaNLxoTHcVVTj+ttEyNFgb/pOQAyxgYQYGIKjyVTy3NAxGSODJWVx3NDWw1HX3T135fnSCOGrf5SyZmyIqjHZJaf1H70GPR9ulBN3LRLhp6y8HRt16DQ37KHoJQdUKqT6JuTHuEeoCJv7jcGUOIIhzUSEDmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SFL4RnNg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OZF43+VllNLQUeKcMt+n5So3Zh9+TQrMX0kTZiqDfGU=; b=SFL4RnNgyx5FOPUlz8vOqeslm9
	RBtlzBvgJ3+XlsQMwsIw634XZNQhXpWnYTLHIqdT8d/X5JtJ/c9hJlLRleiFcXmfs6B58HZcH9TQH
	3vQZ9X9mLPtpCRjLz0CWZvANzwP1K0wi11cpEVmdFC3v1MDkw5q08KvG+2Q5ccmdo4QuPUHYJUFGt
	i1Idqos+2SM/JDsS0f75KU1qUx7TvRrhaiAtiujefiOzcaxNXd4lZBP4sipBHAhkJe+3BbYMFahNE
	bnza4EowvLMmEiL3djoroj+tQdq5Yjl/wkOrNYEA3QoE+MpJHgIElY0GJxOGsEGPBk7bkS5fmqBCt
	HGHMOLaw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxq8k-00000001tyv-3nAV;
	Sun, 14 Sep 2025 17:03:50 +0000
Message-ID: <5214509d-a2e6-4e55-823b-49f2dbfb5971@infradead.org>
Date: Sun, 14 Sep 2025 10:03:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: staging: fix spelling error in
 remoteproc.rst
To: Taimoor Zaeem <taimoorzaeem@gmail.com>, andersson@kernel.org,
 "corbet@lwn.net" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <CANQcFN1s_iM8p5tYNz3Q_WyZki6Aw9_3HyoKwyoCVA9JeqG0eA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CANQcFN1s_iM8p5tYNz3Q_WyZki6Aw9_3HyoKwyoCVA9JeqG0eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 9/14/25 4:46 AM, Taimoor Zaeem wrote:
> 

(pasting email from
https://lore.kernel.org/linux-doc/CANQcFN1s_iM8p5tYNz3Q_WyZki6Aw9_3HyoKwyoCVA9JeqG0eA@mail.gmail.com/T/#u
)

From 10321c75f8fc1296775942f13cb3af78fdc8dcc8 Mon Sep 17 00:00:00 2001
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
Date: Sun, 14 Sep 2025 16:31:56 +0500
Subject: [PATCH] Documentation: staging: fix spelling error in remoteproc.rst

Fix typo 'implementors' to 'implementers' in remote processor framework
documentation.

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
---
 Documentation/staging/remoteproc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
index 348ee7e508ac..5c226fa076d6 100644
--- a/Documentation/staging/remoteproc.rst
+++ b/Documentation/staging/remoteproc.rst
@@ -104,7 +104,7 @@ Typical usage
 	rproc_shutdown(my_rproc);
   }
 
-API for implementors
+API for implementers
 ====================
 
 ::
-- 
2.51.0
----------------- end of copy/paste --------------------

How do you know that's a typo?

Did you check on the internet to see if both spellings
are acceptable?

thanks.
-- 
~Randy


