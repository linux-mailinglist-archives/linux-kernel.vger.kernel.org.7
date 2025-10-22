Return-Path: <linux-kernel+bounces-864162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC3BFA113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D98A3478C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AD2EBDF2;
	Wed, 22 Oct 2025 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EA4JWB16"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542F2EBBAC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111305; cv=none; b=WHUfaOCaZ0lqfUKRkg7TddFUuwNB5QTiN+4rmyyXMiCehxAT7ile2J6Kjc8+1SJrh4n0biTkWqUGqvrWxdRi4GwsJyCjZq0pLGxYeY9im9CWvs9rXh+boGm8a8NtO4Icm8ZrgBPgeqxoMjvInpuNmbseVFmGU+0LBXxNWE0wx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111305; c=relaxed/simple;
	bh=Yfli7nrNGWAirNBDg6CXZHLXMoqOZK8KHRWfvR153kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+4NQZGVR65ndb/5iy7dVzuTpqcRss19CXYDU5hQTsu0jhh5EH3yKbVL7jAAACDl7E2mboE00j2eYgDwpicax1IEsArpWdvENSaajsgiWtWxCcNLVxQr8JCgYaNDb1YWe1PgRNUsC/XGO9wNjqZpDBA2sKQnTAUdawAUEsCOHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EA4JWB16; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f898fso91617865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761111302; x=1761716102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56ezGE6Ds9KP53wZYmYW6a4SSoZf29RYPFd4r32eFsg=;
        b=EA4JWB16r+NXgjHMeMN9NN9KSu5R9Yy8KCxl56vrgzUuc27h1WpYbekyKs+ngvf9E6
         YpCEaSjFsZqtKKfIR1Ue70YGGJ9nYuBDXFecfpdrhbxJdTQ+nn/VMC9oqoVsDd40p22f
         Ez3Lq5AxcYC280OcvMweY60pM+McAPT2MaBL+pHBXNtixInkzvh2RpLuC5XkD2VlMgyC
         pGgFj606MBeT3mQM8LTJ98jLyjvJi91wfE80JCFpjtcBMm5FgTYh3kOlK7x63zezL0UJ
         EZf5ahL87tSLqOSuxv1gZAPCzM2mTMv5wiFvFHGJhvUJeFZwM0WYnmXHcnR/wulCKIfN
         zDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111302; x=1761716102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56ezGE6Ds9KP53wZYmYW6a4SSoZf29RYPFd4r32eFsg=;
        b=dOFv/XN/WPjy/PJ+Cay16ZNclB4mm6fn8lKqawpcFDFmsgrO0XZGXGY/0jdgjtRE9a
         ftpJdGyqMkgku/Mj/gxzwZKp0AqmHPMT3ig0sd30jEnQOORsMoc42FYWss+Xll+rKULG
         hIH6/QPVSU+trW6fxJdLBWIZt4sWSqSWhRrRLT/RcCFMng0d4L3VSvLcG5s2ORhrbqNi
         CCk4W0euXHYpGkkStC9lReYXIJ7jDbGusv6Yaf2yy3TdHJKhTYTaeb5OqvndN7QC7pfn
         gBBkGFenUp4qmMMqH0Qzx1PUYPrUETZCYvyncYrxJbURuzAVik6Cb/1SILq+26vfiz6l
         tLyw==
X-Forwarded-Encrypted: i=1; AJvYcCW+bpdtTQr2y2PjoMtUKf4WSKBbJP4onB6ee0yVHLnolbtnGoo0dOWzr0OSyjB9GngOL/tso4d3URFvImU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZH0Ywgg6lOQ7I7ZrTLEJukAcqelAmgbEAbGmpg8Latju6KDb2
	Gu0zM5wpmFfF5gZhujg1VCb+MHXcYouX+by8+ndEiEcEWumW5IxxcUeR+LBV67aP49s=
X-Gm-Gg: ASbGncv0ZGUVJcSxaVoOQisyhKy22LMX/cHq6LsZLrNZByEyLODh/wwi7/HLrcDmCS2
	En1UxngjyA0Pm1kLvym5Qj29E1hwBSYLtmRDRqMJun/m+5aMod5tIpR87BPeYcHvZ9/Ko4YyD+y
	R6JKBhuNSlrI+qIg3NMKtKRNOt+TB3JROc5JAcKk6aaB5Skqs4o29ULZ7SvnZe93YWk6X+PzkwU
	9QzTW/F7f2rvO1HEpqihS0lRK4JtgWvVp86FcG7DX25H0isXQ0/VW5vhoUqlYCYLXd+D+VrTx9Q
	EA22s22U638/VS6Mx3M2dVld9TlQob/ACRRJjztvOwlui06Nmfd35jifW4dkZZCP1YVGVCXhmjj
	L+5NhPdLbdMleoUkt18upHkgXw+VELYUHR9yuoDMTp4pGRi5bGs/n/mC33SFHrWgzin43kQVGg+
	amb/NFkE2uXwr9
X-Google-Smtp-Source: AGHT+IGnVjE3oW9jfoMl45fRu62Au+V7hXBYTBJW0Xz1osI8MZwsrdpeSGQan//AK1Laa1HoxY0dkg==
X-Received: by 2002:a17:902:ce07:b0:290:a3b9:d4c7 with SMTP id d9443c01a7336-290ca121944mr241503655ad.30.1761111302331;
        Tue, 21 Oct 2025 22:35:02 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm11961911a12.14.2025.10.21.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:35:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:04:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Replace deprecated strcpy in
 cpufreq_unregister_governor
Message-ID: <rgk3oym7r2gkx4gjqsot3n55s4jtlgyl7vayutaneyuqegybzl@njlf3ohiykjq>
References: <20251017153354.82009-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017153354.82009-2-thorsten.blum@linux.dev>

On 17-10-25, 17:33, Thorsten Blum wrote:
> strcpy() is deprecated; assign the NUL terminator directly instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 852e024facc3..0d3e77cf96a7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2550,7 +2550,7 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
>  	for_each_inactive_policy(policy) {
>  		if (!strcmp(policy->last_governor, governor->name)) {
>  			policy->governor = NULL;
> -			strcpy(policy->last_governor, "\0");
> +			policy->last_governor[0] = '\0';
>  		}
>  	}
>  	read_unlock_irqrestore(&cpufreq_driver_lock, flags);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

