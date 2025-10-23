Return-Path: <linux-kernel+bounces-867294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EBC02272
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EBF834D4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C253385A3;
	Thu, 23 Oct 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkjuLaA/"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C22EB85B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233713; cv=none; b=Sd5tRkF3TjiaBD25wUO8NprmuI4jW+7asKY2MagqfBkxVUG7CJUi5S14HlIGctgfqLysk+CCrNqSsfJ+LheQYU10ydPNDMoe4A9Jp8z44AFgfev5qFuS6OfbU8uTzOYOPj0IqkOw0v8rdsQNQJgqRgWX9cSxm+hnuc9RcZPun/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233713; c=relaxed/simple;
	bh=eGBKKT6/ZJA1m271jtEr3HEz9txqNX3YAGujLJ1s9Ic=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W4jdmhlFHlvHbvLblD9U3rJtt3kZN7oUaRyD4R7w5M6hc9vx1ISZvkJybj5lAxDdHJzUlGNl+jhg6t+43t8GmMlJNkQZH8sNEnP2nnb98IwrQG2d6LgO7dzdSNIrAdDigrLnBiFuD6RAWsmDj8p5h3ZQVcoIX4sC/kVTVR+rY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkjuLaA/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761233705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rARSfy8GH9QhaVxHyttQ4gN09rX6JJ4v6HPvqHoA+To=;
	b=rkjuLaA/ajNlzoQfdgze7YaYZiAS6/06k5yb0OVeKHsX0hAHz1b6aFb4tNAvP7n5eKxWMV
	/TQ9Zxm8w8WXmurPQ77oBQc8rP8Ak0jdrVMT2Jc0g/Pw5jgyKzs+C378HG7FXKnpMJ5DHu
	yLxUdxJe91uLGoOea2UlaAG8ccWjJgY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] crypto: qat - use strscpy_pad to simplify buffer
 initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aPkfsuliKYy5UAbB@smile.fi.intel.com>
Date: Thu, 23 Oct 2025 17:35:00 +0200
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Jack Xu <jack.xu@intel.com>,
 Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
 Qianfeng Rong <rongqianfeng@vivo.com>,
 qat-linux@intel.com,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DB96B06-108C-465B-9A54-88B8008DDD60@linux.dev>
References: <20251022123622.349544-1-thorsten.blum@linux.dev>
 <aPkfsuliKYy5UAbB@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On 22. Oct 2025, at 20:17, Andy Shevchenko wrote:
> On Wed, Oct 22, 2025 at 02:36:19PM +0200, Thorsten Blum wrote:
>> Use strscpy_pad() to copy the string and zero-pad the destination =
buffer
>> in a single step instead of zero-initializing the buffer first and =
then
>> immediately overwriting it using strscpy().
>>=20
>> Replace the magic number 16 with sizeof(buf) and remove the redundant
>> parentheses around kstrtoul() while we're at it.
>=20
> I understand that you focused on strscpy*() conversions, but the below =
I think
> needs a bigger refactoring, see my remarks.
>=20
> ...
>=20
>> -	char buf[16] =3D {0};
>> +	char buf[16] =3D {};

Sorry, this should have been just 'char buf[16];' since {} and {0} are
equivalent and both zero-initialize the array.

>> 	unsigned long ae =3D 0;
>> 	int i;
>>=20
>> -	strscpy(buf, str, sizeof(buf));
>> -	for (i =3D 0; i < 16; i++) {
>> +	strscpy_pad(buf, str);
>=20
> First of all, why do we need a _pad() version here? Is the data =
somehow being
> used as a whole?

I honestly didn't question this, but it looks like strscpy() would be
sufficient (with this approach at least).

>> +	for (i =3D 0; i < sizeof(buf); i++) {
>> 		if (!isdigit(buf[i])) {
>> 			buf[i] =3D '\0';
>> 			break;
>> 		}
>> 	}
>> -	if ((kstrtoul(buf, 10, &ae)))
>> +	if (kstrtoul(buf, 10, &ae))
>> 		return -EFAULT;
>=20
> Looking at this, it tries to work around the kstrtoul() inability to =
perform
> partial parses. Instead, this should do something like
>=20
> 	unsigned long long x;
> 	const char *end;
>=20
> 	simple_strtoull(...);
> 	if (x > UINT_MAX || end =3D=3D buf)
> 		return $ERR; // wrong input / overflow

How about this?

diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c =
b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
index 18c3e4416dc5..04628dc01456 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
@@ -200,20 +200,12 @@ qat_uclo_cleanup_batch_init_list(struct =
icp_qat_fw_loader_handle *handle,
=20
 static int qat_uclo_parse_num(char *str, unsigned int *num)
 {
-	char buf[16] =3D {0};
-	unsigned long ae =3D 0;
-	int i;
-
-	strscpy(buf, str, sizeof(buf));
-	for (i =3D 0; i < 16; i++) {
-		if (!isdigit(buf[i])) {
-			buf[i] =3D '\0';
-			break;
-		}
-	}
-	if ((kstrtoul(buf, 10, &ae)))
-		return -EFAULT;
+	unsigned long long ae;
+	char *end;
=20
+	ae =3D simple_strtoull(str, &end, 10);
+	if (ae > UINT_MAX || str =3D=3D end || (end - str) > 20)
+		return -EINVAL;
 	*num =3D (unsigned int)ae;
 	return 0;
 }


