Return-Path: <linux-kernel+bounces-753683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26071B1865D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA5171C4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583781DFE12;
	Fri,  1 Aug 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZ+UU+Kj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE76F2F2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068375; cv=none; b=MvCsNkgTMYAdMDyXJg9WwkaVyZqfvCQ6S5OP7gvZujtpfULDIfUopD9iTqEBRiLjPXvUxyMz5L+bQ+io9QuJLSgqSV2t9Xh43P8Qyno8GtAZjei28nQuiAcKSZ2DlNyXI6Zzk10KwvgKqCcyETW30MzWX6HTbDaj/sLId5G098A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068375; c=relaxed/simple;
	bh=A/j4Ifuce0u9/jL3Ix+TUiyIc4jO4+FIGeZc4i+1OBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPsrhVIGaJnrSB2XTuMmzPdvCt5g3pEC4LPNn490ArNHjBbhJlbdYI7RHQDaU6OaKFM357A60hIGSXU6xXygQWqdZIP6WeKNM3UOmUWREXq9iUCbalomm18heGrzIhyxVqB1xyNQl2fVD9od4HqxDbjyz36/R5ZZVP4vauXx3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZ+UU+Kj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso6052525e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754068371; x=1754673171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpFchoVzlzh0jyiCYJs375yN6Y3U3tX4URylglb/9mE=;
        b=pZ+UU+KjpF78OXkM1ZjNKUhEWL+nnXhILA+Q6TrdxLt8ENMx93QLGHOKfo1oeD7ui6
         ODIszvaWE5N7jOc10SZa0V8svwhtCt1Jxist2lJ1WKcbWK3dmUVaMX7xZnrQ7g0bd9Ud
         HxjItJ/vJZ2vKAj1GomHhcH2klvLINiOF+13e3ETP7gGKVnd7a4a4SSY0YuklYu5v6Gg
         Fi8YlAHwhMLgHD5cbG2ivMARQOuVhq03PzkI6dUb+K+kswrNCqye/Ym5SJRVhlRILMHZ
         vh23IQqO44zMbEG6du4sT6ezkBY8PrF9NchrBfhF/YCprldtxBarDX7Vops21Mh69jdI
         qS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068371; x=1754673171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpFchoVzlzh0jyiCYJs375yN6Y3U3tX4URylglb/9mE=;
        b=gsUT49T5Okxv2dYthcpDqnI90S6N/tPHvSVq86PCUCV1ZKewK9fSMNurRAXhDaFtYJ
         XfqDjZS8lhHtLiRMTnYvvXRCnnGdbWgAl26v/EJZaGV1h45otWJ/+77ET7lWrHQynbzy
         vQGmauZfrTWlp6mxxg/d1bxbL0rF2A5TBFcZSYvcFkNSBt9omLGjAeH++3Big3qLDyki
         oIOcGw1AABqgyv9uZ3BQind4sG79jHfjWjbZm70exboZgPBrFMNhEAtVM62X8ZWk+OcK
         +0tFe3mmAprsrv0l6XjfTB8L31t51eGwDv2BD6jz2wbSpwwgbTTE6SkFuYgXTSJg51U4
         YOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8X1O5lpIgFhNkq5I1jpZjFPMmRefqiNvKnW6aFCMIs+i+cf1t3PpcimcaZt5GV6r0ACNaWio8J1eQF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNac4K8t7P+WU4qAk03ebQTouvP3sSGXk0FmmbBD5GfplOAoKH
	92t+C3XeAQBgNSR4bM6NXyx8THrS8JETCns6xEp0qX9fGqVyz2SsMlSAnb+kMZcXTJU=
X-Gm-Gg: ASbGncvQDH9QgedMNrVU1Op3UjrCnmHYp7VaU181geNKVC57tL0ZVyqH9ZowEm1kpL6
	DsUZer0qUYZ0CVuUmkL/6Q/thApjFQHZCNCb420uQfVwjJGEhTGhdq9SNMZToUWCnGHvv3nGKOA
	b6HgwEZRWCZqXW0D8i6BAWP3D8wuXxn+8jIO8VHzVUCoX33tFZY4is+ldUOJVI7+w6Z4BK22UfW
	RgaMJJoboEUma6aI9lzEQmrOI38W3NwNPQ6WgmWUz/k60KGD7N9EfV/N65kuYoip9t5Kp+dyhr+
	e4QAC0NhkdZG3Ue31Ei6yf2XZqX5wlJfrQfwYqNnuRII+kUu+fQDtsDoKFt8LT6cY+24/3cgme6
	/qA6lnn5CLj9rddAkq5XdWYxmoKu57SwbWgOIt4Ki68sz8eQXMJ0Jj3pErnEjPw==
X-Google-Smtp-Source: AGHT+IG8FK5nU3TfGOcq2jwE4t/LH9fg3G6zA6CPhqrXPHAhHe8RghP9OG9d+H/XSEzhyijEnqWbyA==
X-Received: by 2002:a05:6000:26ca:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b8d94ca582mr522194f8f.56.1754068371489;
        Fri, 01 Aug 2025 10:12:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm6360936f8f.57.2025.08.01.10.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:12:50 -0700 (PDT)
Message-ID: <8e9f462c-872b-4fac-bcd6-aefbb3bd9493@linaro.org>
Date: Fri, 1 Aug 2025 19:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] thermal/drivers/mediatek/lvts_thermal: remove
 unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20250801063540.2959610-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250801063540.2959610-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 08:35, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./drivers/thermal/mediatek/lvts_thermal.c:642:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=23244
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

