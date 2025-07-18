Return-Path: <linux-kernel+bounces-736707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0562B0A0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCB11C225E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DC2BCF4B;
	Fri, 18 Jul 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MEGDTNK7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96429B22F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835025; cv=none; b=fs/loIPdWYrysQJpiaEiAwxMe/CORB/bJ2EGGS9L9Lld3lnP8mLZNn6CTlPd4ptj/TJjqhA9n7Qd0WfwwmSc/vq+BANL3v8vQQWHEA3y2BnbrKC3KHqsCIpOGo/EDfMTraYRgjGxQtX58wllTqiQ+XpngVfB6eG2I9WOxB8sj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835025; c=relaxed/simple;
	bh=o7AiU/V34b0UGWXaW0uOVGBXivX7HWYrqo4HOg5hGI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a2q24BocEdMEvZCepqQBI5L2cD68Ve/vG0Adyj31t8Xkp/0pryP8V2aqFVxf/M1YY2Y1O7ivVCm8PXixgB93js1xB7qOebaieNLAXtaF8YBRHrdssQOSoG+V/SFe2fLaH8L0rcsHzQLe7CJQ4LQtwrBT+l18y3A0yI2wJDYnLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MEGDTNK7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4561ca74829so22017725e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752835022; x=1753439822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=be2WTQLsa5uvXybUvNfmScdP010rblWY6zgN5KBpjt0=;
        b=MEGDTNK7wnRBjnR5CJsIk8UQBa5WAY7ZzNrh14dFymaIHTme90Ovv5HuxQON/qlWpV
         9Bx6HAqyhYXA2IPMN8sKKfEx9/ZbeHyI3/wnjPyA/byyoj8YKPX4Hl3FImCREXeKLa4/
         E6TluHT52LATVutAa0nnIMlkfGMQqGvNS+RDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835022; x=1753439822;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be2WTQLsa5uvXybUvNfmScdP010rblWY6zgN5KBpjt0=;
        b=MIkQ+tmGLHVC38CgRpF4/zkWDSknbSCQSxwuwh/ipKmZ2fDO70dR602DKdS1Hlxp9G
         eVuqviWVDOBM7FLh9bvT75tXlFfzqP2J9KlRYIKsQRc0MMDjBA+tl65EZ/jauLzGNnR4
         i7tobfczIsuIgwaAy4+PX7Is4/gVWb+tT43Bw6KjDgNN999sbbEzqdCmegAP84YQvzX2
         2B6K6ekZWYladVyJRMFMVMcnvyfUY+UtyxT94BJy3TlALlLBTSW0oF31vzEnNp4KZqxn
         40srguQrCYJo2Z1zhvKY7y94eNE2xlslG7eVMHNgq1z+2e7dOazuSQaSFl79noxhLdxD
         u17g==
X-Forwarded-Encrypted: i=1; AJvYcCUnXGgfBRuDgHcEcN+4iqMMyINvGBd9ADlkg6Fh2FvBAFcf17MzuCz0S32fILdkWzCX7/30Orl3f+WXPzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrTdH5u9ma8E5vW28kNCLR9lV8rPMNsY46Od9J6wTaDu9gqff
	0+diikGWpA5/BXESiNjUfO5/kn6vGQ4C11lVGJUvOe0bjvpbCjLqFM2bKHcPW7jA1w==
X-Gm-Gg: ASbGncv539vRlUzsggHn2xTygwP2fKczw34DaPE9DAEnvLKivJWW3xTMBcNy0KwJVMt
	C6yu6Qdu6I1l8hfPJOm+h3BZKD5SFyZ0gC3r6uSHDAMieVNDNt2IZDGCA+Nck9cguOB8+iyUHIa
	FEaPmUQrPK0b/0jwDPb+yUukotsGsSJyDhXPdXG7uahHSY04KzkCCpzeJJoQ/vf6Nw55HwreLFo
	kNj7jbtkOpmLgRgZYhmIBxF+pEMfvbig8Urkcqv3CwdgV/M5YLVGumiUXqwq49c/yIfGTc4W0zQ
	QV5rY7sd9aEj4V5is0GwAfWXD9p43T4wB6D131oB+9p1O+Y3wB3Zh4lXD1O2Lwy4tt1rtH9FcPx
	jsRx2pjYLB2QBhxLrtL/Td5piLiJ2lGcSvrfL6eV/qVgW8M9I58M=
X-Google-Smtp-Source: AGHT+IGaw18z6ZbgBi879Fyj3WOC2+vT3XshuuU7f+qrvOz7x5pcOoeAvZ79K/rtNQcSabe8GjOYiA==
X-Received: by 2002:a05:600c:4688:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-4562e3cbb03mr85040605e9.33.1752835022389;
        Fri, 18 Jul 2025 03:37:02 -0700 (PDT)
Received: from [10.229.41.1] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2ba0asm1461626f8f.21.2025.07.18.03.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:37:01 -0700 (PDT)
Message-ID: <f58ac73c-4d9d-4382-8bdb-65ac40ee529c@broadcom.com>
Date: Fri, 18 Jul 2025 12:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] wifi: brcm80211: Use min() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>, Wentao Liang <vulab@iscas.ac.cn>,
 Johannes Berg <johannes.berg@intel.com>,
 Sai Krishna <saikrishnag@marvell.com>, Ondrej Jirman <megi@xff.cz>,
 Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
 Dmitry Antipov <dmantipov@yandex.ru>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <linux-wireless@vger.kernel.org>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211@lists.linux.dev>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211-dev-list.pdl@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
 <20250715121721.266713-5-rongqianfeng@vivo.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250715121721.266713-5-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2025 2:16 PM, Qianfeng Rong wrote:
> Use min() to reduce the code and improve its readability.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c      | 5 +----
>   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c    | 6 ++----
>   2 files changed, 3 insertions(+), 8 deletions(-)

