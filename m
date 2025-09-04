Return-Path: <linux-kernel+bounces-801250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E654B442A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5742D54465D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DDA233128;
	Thu,  4 Sep 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OITgQdvq"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7E2F3C21
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003207; cv=none; b=oUV/PaJdx8986IJIuDQ5jl7RnJALgYJsikxwPFWN9+VjyTHXIbmo8apHw5/TBnEQ4WkvilFJCLs4jiNRylXpTGG+/uAwTASbR9oCNDmw/lnstnfaRUC2ReLyo8ns8Ux+Kx/dkOAo6sRYl2grvV0ulxXL2xLFXYjdcMH9VC+UNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003207; c=relaxed/simple;
	bh=tpdzb+X3hV4rVqgPDmCIrMa8rtjh2chkQSZaACf2MMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dlkySuiiZCi8kNr/D86EL9K9PCs78f8FlL/1G9I9k54yBdskxUSQBx//jdSromAKah097tZGPnWRyo52G1Mhv3Bl7Zigcb0GrHbxUXmOui+qRBZhhLHRBRH33ZpcKLgQQxHckU7s6f4PLuUTkSM9+tqFyznBqyRMg0xBC9m2cLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OITgQdvq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd16c484dso6200065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757003204; x=1757608004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Zmn33NQED22wCKZ1Y3FA6Co5AVovjnCCeYLb4pKYh0=;
        b=OITgQdvqXBEkVSwXXuPyxdA3Cy9RHIQQE9PwRXJ8mz9ZMyDXqPcSGKIXkKHnlv4WcF
         IW6a9GQnbREBmCOofxxsM0piK/EyUGJp2Xy7GayofuuQ1PvR6VQpBjTnCCo2+R+P9K09
         ei+VSCkfRa63h6YGTZYPNVHpLqO2qg7pbseYlhcL9pc4crGk2amSSyAlAD+5WzlC0Bhl
         j6ZSU2q+1G8Y68RM4Nji4pTaPMT6CFmH1M0713XNBYV4asACGitbsRy3G+7rLjT/QM9X
         D0HteH7x5XNBkqG7ceYLAoM9ZKrZCNNLjad3sTq6jrMbxpTujYoU7ffmeLKmqA2c+9L1
         wPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003204; x=1757608004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zmn33NQED22wCKZ1Y3FA6Co5AVovjnCCeYLb4pKYh0=;
        b=P5ZIaYP0L/w/Lx7BNSbkpVXo//unEGmTpQ/3dpoXl9Twz8NbzYAkBZtp7OXkWUY7lM
         Jl/3quh7E6zFhc55afyU5MSSwlNhOiiykm844+1MgWHenymycppvPhGGIh5jI0pNYxix
         KRvo6GrR45HW4flOvELPRL8LbFNP4IrHKiyC/gDEnVd4pMdBxSDZQ/wDe29L5ngKTnpm
         Y9crhQs92g50fsCF77tfrckhxkUjacfAPfBbkc3F4vTawSF78fICwNniXiMJ6DMOxBh+
         FLYCOad4CKLhBlrQNc6AfBHtclrh5Jnz6wLMRkmYFuLcoudgGU2fySt26nn/d5wF9Dss
         LlTg==
X-Forwarded-Encrypted: i=1; AJvYcCXlIiW5RcttdeLZI4TC9THjCXXRDVCVkiG8sGO/JMqj+740wqAyV6nrsA06ehHdmlUVnfNxQytx5b7Xm6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiz9hozinoHV+V4JLLwZykX/FBHuVoZxAwreaiATWd77TKlQpB
	FneWb0pVjrUggKU4TtgkUBTt7bUcq014TIBa//j7ePo2eYqzD7U3sCoM
X-Gm-Gg: ASbGncuTwv5OopT0XnYXzksqdQj/EiSzGTEK3p8HATGJZbMP74KXm8PX3HSglWODmSF
	qfVtF4YlVgsU0P5ERWIT60vj8Nh6+TuceVs20iZO+wZENTUz1e/7kb/HI93IDUkhKHVEU4Y4b1x
	11UCphw+A5c/jI7Zlpb9VMQ416zhwBVtkWbHXWX2HJCE15jpceh/RSztHR7+5ydMk9I0eefMMz1
	+oX41AgsYbpRjgTthoblxbYd64PoUxFATLju1u4vZHKJH8iQihKNzlJvzm8FFqumZWX+k9P5hsB
	v4U9MhVwU//PBDWjDa0zo+ZTwwO4smO1Q3DSR3ppd0z6p3cnf2fndGpPbtbs/b0yEKPv5E4ylGB
	nhFBdc+/BQINzscjHd+Oe9SkMx8x0+LW6FIPb4HRzjMwyPYIJHNHS6ajNZYNrEHe29NM3y+R+tL
	hX7Ho=
X-Google-Smtp-Source: AGHT+IGqRoVDL/YvIJCa0D9yyjvv5hQCjZTKHgi7GaUWRGYH3wr2Fe9WEMFB2BkUiphy8qATn7bWNg==
X-Received: by 2002:a05:600c:1389:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-45b85599151mr139128775e9.36.1757003203459;
        Thu, 04 Sep 2025 09:26:43 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb687fe4esm68126895e9.23.2025.09.04.09.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 09:26:42 -0700 (PDT)
Message-ID: <b9433a38-f948-4e16-b7e5-0c2537f7fe0e@gmail.com>
Date: Thu, 4 Sep 2025 18:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sti: Remove redundant ternary operators
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVERS FOR STI" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250904112738.350652-1-liaoyuanhong@vivo.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20250904112738.350652-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/09/2025 à 13:27, Liao Yuanhong a écrit :
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---

Hi,

Acked-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Best regards,
Raphaël

