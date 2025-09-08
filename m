Return-Path: <linux-kernel+bounces-805148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB83B4848D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326FC175925
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149342E2DD4;
	Mon,  8 Sep 2025 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+QNeCkJ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F62E06EF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314556; cv=none; b=lzOVwxW2uF1m9LigvH6rIImH+Y5134zIhP++KqeH318Vc/gkG22WAjwXYspCB71R2tdj/tORsFkhI08p/2aOI++NpOcDFyOgdfD/wMbhuVGbXrKCG6cHzOc+W/2017nWalVq0wkoX1XXVewTAaq3XEffSKwp4/YLRtNCmF/Fv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314556; c=relaxed/simple;
	bh=CpGKAIjx9opYm+HfzeDAQ0MJW1WE+sPDSShf9nh5CuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syUc6a/DqLuzm/Ri0ptJPF1uzws7OS+Hh4Bvb9H5/Gp+CUwA3AE+3gjvshyY3QyxSyHXdGol7gj5McvdiL21hP74d52svnLcLJ4hU2DTwCM+v3lEB/gESDe1M1eKFZW6DqfQpMhqCBxt/D6ZOwCNMJxyBn1BnITG2KJLap+WEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+QNeCkJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77256e75eacso3546638b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314554; x=1757919354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjDemfu2IvLbw+qXa34kZRvjbWxOCBrNvY9zl55RAps=;
        b=S+QNeCkJo5vY6/myyb7Q/teXNz6Er8X+ArNhFihobADj5DF7hO2I1+SGcptkb3NkI8
         Kodq9ENIZSOX8UJ/2EYtW4LNlMT700Q79IpRI5Zr/gt34VCodxvOFZnW1Xn2BgqtxkYb
         tn0oObkMX9XNcosl1PXfGzTRFmMDURbOZY687YrVFxg04eIUi4kHRI23I1KCTslL/WCR
         ZeISeY8zoxnaCzlrfBb6xCYQSxtdzMCMKVFTolDzhloziHJ49Mk47SopbLVDL92pnCxa
         I+OCZ8lCOk+nDLhzlat7ETyl7h6KZVT0qkkHm5jxzfRxIuo+j6q8H2NkV238+tnWEmd4
         CTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314554; x=1757919354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjDemfu2IvLbw+qXa34kZRvjbWxOCBrNvY9zl55RAps=;
        b=PTbGVAHggV7NTV4VrWnO+i+pmMAQPRPVqzFUV5C3rM1g2IT7LTakPtlj7KniXh1IIY
         2+JfW809VUl9smuh9YhsTRScLuwv8gwD2ugvoZ9F99bB89oq/mRxf3bXlet2N4jEPbIB
         XfmjftbBs6GpoAB/lCquorRPdgGfBAEV983DLvfNpkjSrzILqlqs4d234mvxhygUkUuS
         qo68RiFrEgLoUztGn1aDuu6XlA3t1HaSaIxhZze+qHQ5JA9hdeKw0UnSeaOP0Z/NvJ24
         WuGDXuhgOGgTFpkkqbXJHKWpXFT20+nm7bH9d4VQWsFLDSvbB8Srb4WSn0r73q3zmB2V
         J/aw==
X-Forwarded-Encrypted: i=1; AJvYcCWz4Vp9Pz0nDbb2JQLiZaLWSdMTA33hMEpDFp5KMHdrwn4brXuvRGYo5v8GNJSxuK9W9rrfvfx/c1gTDuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oYBrIwNFI5K5mF5N4cE+GjH7V/oMp3gHvseoXNmfdCEPRPW3
	SEoOQLvhnGDPO5KYOqRoy3i+/pafPoEhvFlc9FjHRGGBwNV8Fq0PmI2MiAY7pYE6euBfTE4JErm
	FrwTP
X-Gm-Gg: ASbGncsBstmKaWyon6dipoyx//lS8ZXQX+YdbCJnHDjeY1rHfxp04Vv+CfZmLem04IM
	VUUZQL10enFyrN4IDy+2NLbJEEZViiIu4l00atYvGS5FwbN7D8sigsz1OMWN/DsYnHQmf18qWtC
	aFlAPtYeEu9kKfbQ2Af/omJNsL9U74szQWtWiytwp3bHGocths7yIeyiD+JvZgPgxExaoj3VYCL
	K7iiVyp5mcvNfvG0SL0abKm32rvnWPkRw9ZjI2eAdVzExR+yvon5rE61bGak6G2cpUsv/KLuGRf
	s5PgkA/CFaJ9AxiuI4JSJqokWveQhD4+TekszBvW9OzDp8YjRePiutVHIGZACJillMR10PvlvJC
	1WXztXvVmyJXkcjL37Jb0qGEORTdHL0V0cJFBV25LWkOrKQ==
X-Google-Smtp-Source: AGHT+IFUii7IFPGF/GfdssWSzTteSva2Jd9iVfJQLLidaUj532ste3VwU6C9KZtFqK7PJto/9xnrdw==
X-Received: by 2002:a05:6a00:1823:b0:772:1fa1:be4a with SMTP id d2e1a72fcca58-7742de60f4amr7353357b3a.16.1757314554209;
        Sun, 07 Sep 2025 23:55:54 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm28535953b3a.41.2025.09.07.23.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:55:53 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:25:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250908065551.d5jhp5ejix4fzgd2@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
 <20250904053700.abdkh23zwi5x65do@vireshk-i7>
 <e91bd1e9-8db4-4923-92fe-52893623487e@kylinos.cn>
 <20250908061333.rwzq5dj4nxlav6x5@vireshk-i7>
 <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe36377-6f92-4913-8cd7-087e718af368@kylinos.cn>

On 08-09-25, 14:51, Zihuan Zhang wrote:
> We are currently considering moving the check that ensures a driver
> providing a freq_table also implements target_index() into the driver
> registration path.

That won't work AFAIU. The freq table is initialized during
policy->init and that's not done at the time of registration.

> This way, freq_table.c no longer needs to defensively check for NULL
> pointers.
> 
> Additionally, we are thinking about merging the two related APIs into a
> single one. Do you think this is a good idea?

Which ones ? target/target_index ? I am not sure if that can be done.

We are fine with improvements generally, but please make sure whatever
you send doesn't break existing users. That will help saving some of
our review time.

-- 
viresh

