Return-Path: <linux-kernel+bounces-863723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19350BF8EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F401898D80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83041285418;
	Tue, 21 Oct 2025 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="naUnP9uo"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85808288C24
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081766; cv=none; b=XAYHYflndcm9CcohI6tkkm1QTXCDJd0TAwOqWVnE60FcVLV5hVihdpvOWHhe3WaG4YHyKSoO9vypa7Ta+94E4VXL7+QJ5zzY3cCig/zv/gYRUbmTsDBJ2W35HsfAsYfqZPTgoqGSD1LVzWecHjqvMTtZICxSyofqb1S/14Im/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081766; c=relaxed/simple;
	bh=Ybx4CHPsOLmvIHdoWKQOvulc/D18NFbbASMThaWnL/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GjZplP+eSQLl72XA/FlIpfa8+cZgicoM/y8YnSMtQcEagsTbk8wscrFwOJiHXVBAGeK8+FVNtmnPNtxb7ZXzoVj2VhdVt1DpzpkGw2tjx9d2WnDoQUpM5YZRR4KFOwdxjW9AAD8vV1Sag66UqSjTJu9YK+dr22YvxBRSUeDw2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=naUnP9uo; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761081761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipMH4TfKfLmOBsuRBlv/yfe75TXdRF1bje+9o/VW4f4=;
	b=naUnP9uo2aKuco80ByGsaq15l9rdYxK13SqP5udZzatzjZKd9TDPSxm+egZXnct4pHrK51
	viZDCOApUhXEwT/q96p+BvaXteHVxRpSmCdkUmHSylF3N0Le+YoZVEKT6X9Y+/3WlKTk29
	ZYLgeycXTLcEksTI5qECpM3AsuIimeA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] w1: therm: Replace deprecated strcpy with strscpy in
 alarms_store
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <db33871a-26ad-44f2-8e4b-046aa34f6477@kernel.org>
Date: Tue, 21 Oct 2025 23:22:05 +0200
Cc: Huisong Li <lihuisong@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1BFDA086-7B8E-4FD9-8A8A-B7D23A5FE5CF@linux.dev>
References: <20251017170047.114224-2-thorsten.blum@linux.dev>
 <db33871a-26ad-44f2-8e4b-046aa34f6477@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 20. Oct 2025, at 09:01, Krzysztof Kozlowski wrote:
> On 17/10/2025 19:00, Thorsten Blum wrote:
>> strcpy() is deprecated because it can overflow when the destination
>> buffer is not large enough for the source string. Replace it with
> 
> It cannot overflow. Look at the code - memory is allocated for the size.

The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
bytes to include a NUL terminator. However, the 'size' argument does not
account for this extra byte.

And since 'p_args' is allocated with only 'size' bytes and strcpy()
copies 'buf' until the first '\0' at index 'size', strcpy() writes one
byte past the end of 'p_args'.

Using kstrdup() fixes this issue, as it allocates 'strlen(buf) + 1'
bytes and copies the NUL terminator safely.

I would also remove the misleading comment, drop dev_warn(), and return
-ENOMEM on allocation failure.

Would this work for you?

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..94512f8b60f5 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1841,15 +1841,9 @@ static ssize_t alarms_store(struct device *device,
	s8 tl, th;	/* 1 byte per value + temp ring order */
	char *p_args, *orig;

-	p_args = orig = kmalloc(size, GFP_KERNEL);
-	/* Safe string copys as buf is const */
-	if (!p_args) {
-		dev_warn(device,
-			"%s: error unable to allocate memory %d\n",
-			__func__, -ENOMEM);
-		return size;
-	}
-	strcpy(p_args, buf);
+	p_args = orig = kstrdup(buf, GFP_KERNEL);
+	if (!p_args)
+		return -ENOMEM;

	/* Split string using space char */
	token = strsep(&p_args, " ");


