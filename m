Return-Path: <linux-kernel+bounces-731933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C1B05D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA907162A69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550032EA482;
	Tue, 15 Jul 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYThkK26"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF92E4993
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586422; cv=none; b=BeHJniepwjGOBBoo7FMw1JnmeRP6sRXeMoY9Vxiu1OyWiK3YmU50Fz75g4zgE2RrdFEioOqkQjolMhh6WxFf2qw+SeLOoDW961a7+7HbQwPBfOwsO7NspMV0JEeNLb1xj7FZDE13KvJCVm2Gfj1qIWq3QAGunX5gPCukRDE7kK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586422; c=relaxed/simple;
	bh=rzsle0lYd4q3WFkhEa4uKuNyg+mZnvPoF11bTF7RytI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpxPOCgsbTyfzQKEanSMk/AYu429HNlENxUd8582a4DzqYousoQzYYCKxijWQeVQEEdP8myTYHHSY6WtnKBFZeGLTWr4wPhecA0oTx48qmUcm7JNyJyFZAcuJJeUPoD5H5hfCx26vV3zgAJPdTpJl+kw5H4uFC7SHhTMQHdHCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYThkK26; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45629702e52so2923785e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752586418; x=1753191218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+O2OICZ/PuWhWK3KhlIFVSdYJvPOM1EVW/PgJZfT+M=;
        b=WYThkK26Z7Ql11GhNHA5izeyQuY5s7b6yi7lhD7yjRlPbvptZHkgeNewrwPcS+pYVw
         1l1BkwnX00vGRAHEjAovJeF8otaJMtVvU9BZw4/8htpxshpNf1o6zLtJHBvnxOFkW/kU
         IEMmuSNhu1vsXhTCVi8yXzGGMfDoosNrVZHb4s/K6CjmLsma/rhqmrBBwPw3ElsDaDUB
         Ud7XP6E2Wh3j88qZKLEgtwfWjNWhyqP8xb+cF2QxPzwcMjywc1lYD/4rDfyzTCJAwk/r
         zer7cd/bykVGOFHOsxCc66QExUyhYNIJdO3ZhDqAbrhPZDH+cV5c5IHpI7pHLTvDbf+y
         MOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586418; x=1753191218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+O2OICZ/PuWhWK3KhlIFVSdYJvPOM1EVW/PgJZfT+M=;
        b=ce5N22oATnsOFwmk7pOU9w4P7wWN7Gu14KAUXAnBWakr/vMhBs4mZBZU8gknbR4XZz
         qwUG8aQmJc0wSKHAG5hCUjbt74rBq3ytoSsLGaeAiMlHbw0tAYPEKVeuxVXzDHlMdWe1
         W6E1PeZL8qtER6zjgCFt7FUF/2fHYc8ZlWqoBkOJn1WD33pI701xkop2Nw5Rxp5PO1u0
         cjfG0qv/mSKdnQeW4YvzLfMsI0L8DFYHrCHLekTM8SpbdmXE4QzM1o+xLWtBFz5qo1ng
         +wIlPRs2aOOYNh/iUULj4md8JbG1QChfZnQkHUNoKTKXSv4SC9n6MBUMbtVj+g5DXUh4
         MFZg==
X-Gm-Message-State: AOJu0Yy5dvz3qcZ5NGRLi8FANx/fvl1hNTvomgtsVbZs02AOqBYdDC1i
	nobTeUFUI12k3b8dzzUkh9ToJS0nCatlYP0sOxZVHc2/A3wDtv5FRWjkds8iti0ZVZ8=
X-Gm-Gg: ASbGncubnPk8wdxIERtnSPn7riZZ4GOLWc9d9kcNdoqFU53Pixv2vCPD4BPfEW2YZbi
	nmSmmNnY76DGGXjYgJJrdfXiPMq63/wkdKVj9DjuoJhhTpr49BlqFaxnnrJptDbQssjqXg66fZg
	fFR348KXyWNoMZPtVaD/N116t8UWxiE3ARE2f8COqVK69za8I906e5QknZ06mSGbXvA7d2qreyg
	T9aKYII3PMqsriGPxuc/xVqPhpx8v9aC6UHqJAbGfeQXrYNy6HpYeTvkArtF09lJ26TS9/4TNlO
	RayGMEOOpeb3rXjsD4OhQ6QlZ5e/ubxOrnN5+wBpLv1e3c2iB0fDMNN9/0EqhXPprRRWQLEX1ki
	y6rwDW49mdKO9Xhqx8TFn1IhegT70nDstOtMocfaa4LkDd03+emOtEHYzdJbH
X-Google-Smtp-Source: AGHT+IENtk1fZji7615Bpw3kcLK5xTHsi34/FWdDqEiS6WLHvSySQx5nMasrQRvOYBkeNVG7ZeVurg==
X-Received: by 2002:a05:600c:4e51:b0:455:eda0:8a8e with SMTP id 5b1f17b1804b1-455eda08c8dmr128078735e9.27.1752586418167;
        Tue, 15 Jul 2025 06:33:38 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50ded8csm199491555e9.20.2025.07.15.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:33:37 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:33:35 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: Use dev_fwnode()
Message-ID: <aHZYrxabtU-7l2FB@mai.linaro.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
 <20250611104348.192092-20-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611104348.192092-20-jirislaby@kernel.org>

On Wed, Jun 11, 2025 at 12:43:48PM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> ---
> Cc: linux-pm@vger.kernel.org
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

