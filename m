Return-Path: <linux-kernel+bounces-793870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E79FB3D987
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9696189ABBF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A7A24418E;
	Mon,  1 Sep 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9oVSeNk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150C212556
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706910; cv=none; b=l+Qo8e1iWqRgIP+pgXqQI22zpgcxAgWT3O5B4NpyK3Jg07JOvyCl4ufjVx0JlY3+Hbl9tBDG5O+8OuLSaZoCg4OlDdyxNfZRbC655CL4pzqUDZ0BFeHrNSqoUwAm2cWFxVFQTk1QlYC1AeEq8zh4+nRRT137iroFcJmkfkAfWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706910; c=relaxed/simple;
	bh=e1/x6A5urLvTgdY+gnXoSD7qH4dRwjI2/pmtywnvuE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt5NmUB8ORWHICGIW0CuBN0hNwL3H5FLIw5kiSTU6qERtuffmpWaJG7cTxJQvtt9KqIowwE5qGtPMcsYloL/TieJMVroOpEsFVdxt+gSOyihE+R087gM7iPLXm04W5U89U8GAHGeAynqyFa4wTpQkuFJ0PfT8B9pS3I9OlKuDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9oVSeNk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772488c78bcso1147005b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756706907; x=1757311707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe5oE6Vxe0adEfjv7356gkuMjNfz5H4iaVwaqjt3KrE=;
        b=r9oVSeNkB92bzmTA8KCcOTMyOGtXGFOrBquN/1MwVGy7St+EvtZSmeTznC4ROHEiEz
         1XnlsypyGSKj4fe7MyXaz5QX3/m3VSFRh0JEMOrVeHy64zupmB2B2Y7s+h6nBygcAbfF
         0v5Z02M6dcU8OLdrY3lmfAEeNkpik+o7kKuEaTMy4X0Z1HiN4mDggyE7qutHlLUpmMXo
         doGDSCzebtxlmizwpYzPZLfpJPAHkFNZPd+swt3KU+1Iq1grEQAMHgIHdKLgFAfyULmb
         H7l6bImUoCVdjfVEflLPxc4kHDHERLiGsq75wPhWZjZyKEW4v/GUu6W4aJpKLkD0XHRI
         YYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706907; x=1757311707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe5oE6Vxe0adEfjv7356gkuMjNfz5H4iaVwaqjt3KrE=;
        b=OK3zN1Pm+vh5eNZW7o33wPfAFPARkDdwPwLPmC707c6Sc2f2CEAp043W4Ror9W6n4i
         0ccSepZdiccArz+NspRB9O3FrG2Oej5p8wju5+TpDTBGAMd4jkx/JUDhmeTsDjsEQ7yA
         NgkX5gHtdff8rLtZtBKVr3OFFobC3jZAK/dlJKhyW9ZBaBOszLX4uP9+CbAag5m8fLWw
         o/cUrreTXsQFmg/t2DkNO3kji9fsF3dbqcIL3WcoUFfKwNzI2WkQ4r60vmgWqf5Hf9mA
         rWAoGuSJQ8KXaG/uD6DlKiMjK07MmKelwBOZf2mnj7sgroFGBkyZvY+oROjAoRtPMVMO
         eMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX2DySfxktjR8N5/bZYoJ6n5pnY3EV61lFO/wfxtyLZSDTqwYFevKKHHhxX44Xn0ETBL4EONXCu1KK4W8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3eV7O8LcFYiTQMKPMHwchEBE48equS/96/Ft53cmnOYQwaFev
	XnMPq1mykQFt8ACiU59VeeAIxA2LgWSnIpla0Fv5w1lkK3SLuvpeyHq/BhrI4jI811A=
X-Gm-Gg: ASbGnct2PymF6HeScSOImDvi0hqWg7h5U4IhsCyEcNV6x/imS20SyZjiaIl/9KRC0le
	1hBG8bOtEtEvYed6COpOqWcBMfHgxYKdor/gtP8mdFz2cwiqIIb5dwZdT/HwottBQ2zN8/OKogr
	Wwp5eol5bJu7NifFEFcNwqeyvqiTsxnOpJX696PCpClIhVj1n6RP4bawruknV2s7JQ7nD0zmQIJ
	Niz+3IXSyCKdwllUSYipbqtcE6NomC1cNvKHJHq0P/ReyqiF4tECAByFtD5O23uVIrrDmD2D8lH
	j76MborvqwwKoHWvV1S4zRC3UBkGOfRdp1PJUCLGRT+XP6gwxa+IIAR+fZsG1EUHTMzgbYua39K
	2/pG5vedQ7yUObPnPhDmeym7m6b692MwRSMU=
X-Google-Smtp-Source: AGHT+IH3TOlUNGR0bRaH/xbi5/9JMGK8XkYr8G8EH3FSGJe4n9pposHv4cDvSfnGe7rWjHU0JcQavg==
X-Received: by 2002:a05:6a21:6daa:b0:243:a857:4377 with SMTP id adf61e73a8af0-243d6dd15b4mr9304697637.4.1756706907228;
        Sun, 31 Aug 2025 23:08:27 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90ed87sm10064942a91.23.2025.08.31.23.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:08:26 -0700 (PDT)
Date: Mon, 1 Sep 2025 11:38:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Use int type to store negative error codes
Message-ID: <20250901060824.6zenbu5wdko5rot6@vireshk-i7>
References: <20250830093458.642881-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830093458.642881-1-rongqianfeng@vivo.com>

On 30-08-25, 17:34, Qianfeng Rong wrote:
>  drivers/cpufreq/cpufreq.c       |  2 +-
>  drivers/cpufreq/powernow-k7.c   |  2 +-
>  drivers/cpufreq/speedstep-lib.c | 12 ++++++------
>  drivers/cpufreq/speedstep-lib.h | 10 +++++-----

This should really be three different patches instead.

>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a615c98d80ca..f47096683abb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -914,7 +914,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>  					const char *buf, size_t count)
>  {
>  	unsigned int freq = 0;
> -	unsigned int ret;
> +	int ret;
>  
>  	if (!policy->governor || !policy->governor->store_setspeed)
>  		return -EINVAL;
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 31039330a3ba..88616cd14353 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -451,7 +451,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
>  	unsigned int i, j;
>  	unsigned char *p;
>  	unsigned int etuple;
> -	unsigned int ret;
> +	int ret;

I would rather do this instead:

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 31039330a3ba..72430c3c5500 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
        unsigned int i, j;
        unsigned char *p;
        unsigned int etuple;
-       unsigned int ret;

        etuple = cpuid_eax(0x80000001);

@@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
                                    (startvid == pst->startvid)) {
                                        print_pst_entry(pst, j);
                                        p = (char *)pst + sizeof(*pst);
-                                       ret = get_ranges(p);
-                                       return ret;
+                                       return get_ranges(p);
                                } else {
                                        unsigned int k;
                                        p = (char *)pst + sizeof(*pst);

-- 
viresh

