Return-Path: <linux-kernel+bounces-819773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477BFB80296
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1291C02EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64286AD51;
	Wed, 17 Sep 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YF8WLnmW"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A910E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067594; cv=none; b=ssh/yPPynXyy3ztW6KcF/jdjmgClXKw46MEL7oawFKRtI5ATQdcG3rRLfihOdmsbhtP6mXGCqvGZ8Dj/hgIDJ7rZRbUmt/26DrFo8bdLVqRkCZFjTsuJX12AyDzDw3L4nTiLFW76mTZY994EeTLEiziLi2hvAfQ/JtDNP09WQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067594; c=relaxed/simple;
	bh=ngJ4kkJ7aphmAfgCY+dWMJwxPcmplYJ6YWrKkonh64U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=osbfbeu98DD5EJXyjzGZJpYBcoSgQb5xIlndIYraDIy2plyIusF93NHTIiy1Fxb00n5RjvKYcg1Yi2chbGKgz+HnqwC6/rKW6EPvnCVMds5Xxkd9nalWN+Qv38y4sbFZs4PP+A4oLLB5vS4pBDYN2YBzb6NI1cAF+QHzVPweJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YF8WLnmW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8072bb631daso572540185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758067591; x=1758672391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6mI7kMMJCYUaZU1FUYIKeSfbHM2lLryh9bTV5PX1CI=;
        b=YF8WLnmWg2kLtLqc9AX6/3+NaOSgCpq5kLQAUnwU5Nc8rtEji9suXSIeQKDerjue8Y
         9sTJRTE8ipMf7ZM9HrtXOC5ThFDPKoOVVqYpJImweH9R6s5dmhy3EVZFl7fRxk+Yyvgh
         2lJeuwBtOGZKpAPJJSMS61lAFdDpIFgUEvEnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067591; x=1758672391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6mI7kMMJCYUaZU1FUYIKeSfbHM2lLryh9bTV5PX1CI=;
        b=NjtWrlwlfd4KJWheC8o4VoHV8Ao+WKp09DG0LY/QjpHUPs7fG0lsPJvdnc/5Pm3ZSb
         MbClgi34V37ec8CWGlauiqCrmbD44hQ+uTM0qQJIiVm9DPgo8ghro9J+4wlTf1zTBVw1
         S+fYRmBSgffGFcLmSXV7piW8975T8ixkp6aEfmLLAWtN7PM8/F0das3xFDuIEh33oP10
         +JW8lZFIW5mHvbnCK4RYvkHrTchv9OBCMVpzTn6ya139Bwgn9FE2gLSzMeF7bq4+RzuL
         CvRXAuH0r+LY0AL3fVuDC6K7b37ztM6bLDgEEdlneRAE8jGslz2VOFa/gkv5IlVexevq
         jlew==
X-Forwarded-Encrypted: i=1; AJvYcCUU/988VrqroEP3ZhEiOiZ3G0K4kXQ7PupSoUwcQ4s0wLjdlntVI5cTILeCy6WRHin1FTmbZzffmamahIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7DUM44gNbiUCnSMHe99BrvXD2Y+2dX4Ur+woVC1kie9ei3pg
	T283hD2xAc8ZqWD8Qwuj/Qxvnm0a8u97BM861LRDPdPNTficfONovDHsuusdoOPEmdU=
X-Gm-Gg: ASbGncvHdvVlwHgR+J5dfY12L5HpBfd55Fp7/Ja6ozh/s93l7SFQflNQwM0kC9tR4Fx
	Si8mP4dD5f4sZh1+yyJFQ1Qq6rzXcNyTzcAsm2+21m5+uSyaSlQ1l96ivTcyEwwvLBau7YBagwD
	1RPRem5yrKpYhfw7qJJ01pjckc0Qp7SMddpGOehunW1KqEQZkaNF0h7oAd6zsKI2ZBowaIM4xm5
	7RWkSvxI14URe7nrDppLQlXSnrB5Ty94X1uR4BEAacfTEgJled5MwLVfwoacyqx2PdyKS+TRjpW
	YJsHYZYfDoocfPqpoWRosogr3+1nM0P/W93PWhBt7vSPe18BHollyDAjfBulP0g1wlHY13SH7S6
	t3OESiogMUEKGDH/xD97DrkYY1HOeLz6xhnlBOomfH9f0r9CSWONHbWmFzndYRJ9BXpVayZu+g5
	DZjuJaymbiMfjdmqYzpF9GAfLJWROvCMW0lFt2qqZOzO8=
X-Google-Smtp-Source: AGHT+IH5c4maWyfkVF5FZpUNfpUKnCiWWiu0hC91XpGrz9njbNR8U16fgNo/b40+XvnCWlfU+uhSmw==
X-Received: by 2002:a05:620a:4607:b0:82b:988:11bb with SMTP id af79cd13be357-831162653fdmr28239185a.73.1758067591381;
        Tue, 16 Sep 2025 17:06:31 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82b19347ef5sm285484585a.44.2025.09.16.17.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 17:06:30 -0700 (PDT)
Message-ID: <39da8772-a44f-466b-ba2e-425ae464abb2@linuxfoundation.org>
Date: Tue, 16 Sep 2025 18:06:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/kselftest_harness: Add
 harness-selftest.expected to TEST_FILES
To: Yi Lai <yi1.lai@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, wad@chromium.org,
 luto@amacapital.net, kees@kernel.org, thomas.weissschuh@linutronix.de,
 usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250909082619.584470-1-yi1.lai@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250909082619.584470-1-yi1.lai@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 02:26, Yi Lai wrote:
> The harness-selftest.expected is not installed in INSTALL_PATH.
> Attempting to execute harness-selftest.sh shows warning:
> 
> diff: ./kselftest_harness/harness-selftest.expected: No such file or
> directory
> 
> Add harness-selftest.expected to TEST_FILES.
> 
> Fixes: df82ffc5a3c1 ("selftests: harness: Add kselftest harness selftest")
> Signed-off-by: Yi Lai <yi1.lai@intel.com>
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/kselftest_harness/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
> index 0617535a6ce4..d2369c01701a 100644
> --- a/tools/testing/selftests/kselftest_harness/Makefile
> +++ b/tools/testing/selftests/kselftest_harness/Makefile
> @@ -2,6 +2,7 @@
>   
>   TEST_GEN_PROGS_EXTENDED := harness-selftest
>   TEST_PROGS := harness-selftest.sh
> +TEST_FILES := harness-selftest.expected
>   EXTRA_CLEAN := harness-selftest.seen
>   
>   include ../lib.mk

Applied to linux-kselftest next for Linux 6.18-rc1

thanks,
-- Shuah

