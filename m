Return-Path: <linux-kernel+bounces-742386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49EB0F0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08621AC4A19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E102E1745;
	Wed, 23 Jul 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HforAuFO"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC792E0910
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269237; cv=none; b=XmESOo8F72Ics5NQJd569NatWH1QffOCkxxf7CAoAhK4nNGT5DX59xvaZaogmhnGK586OWWhSr0lxH3y4V8gB8qYr83B6g1PKhur1R/jLb1/7lPkW3CKn3sH6D/T7uFe+vOUYiYBXk8lKpXcNXvQA0cjeR8HcfPhSKEgf1HneCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269237; c=relaxed/simple;
	bh=Rl5FDHcKst3rDIallQV9+lArjzP33DezoICoPNEKjPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpXJsPeqBVKsxVSwJm0je3M2vJQEvF83ctQAo7Axndn01tgP2yzZh/WZV1Wz/6UeZ7eaZ11TK/93bzl+AwBT5SxH8MSI0wZuHCqvOVYQP5F5Ephq8w6oJyELbiy8MRbp6Qh2PIRd1OvqJPIezTRHLQm8mnXyMfEUQUElpTw1Fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HforAuFO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e34493ecb4so680645285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753269235; x=1753874035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZsZ4ceIkCMjYpv3G+hfUSNyJppKuLhKWJpjluhzw0E=;
        b=HforAuFOriP+RYXzs0MSzeyc1unqBSijQ014tLd+mgnZ9fHtP/+bsE4g37YjGXp35J
         NvI1sM8xUwy8zqQNBDki4tA7g/W6tpsjTOEIGOCldbArN6fOmh3Vi6O+ynW/pxJuUKHI
         d6kS7zp83+D2jv2o1nHi+wiZAG9Gi2siMYh6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269235; x=1753874035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZsZ4ceIkCMjYpv3G+hfUSNyJppKuLhKWJpjluhzw0E=;
        b=ZozRfi5O2NkFeCArYmD1FUJKcHPF2PYFMoRNDvsNcqjUh6/hxBl6+TXLYBG1i+jd7n
         xX1SLwsuSRrbt931VKbb9slmdbkX8Yez1tkIoI42Qyh8NG5IRJcwD8qD6F9wbk3MZt7E
         lCDXcI4KA3jDzklFRQqUJvkcbxHmXuCBZwKCNMb3WYJj2CsY0xMUBndfNLNdrKg71HXZ
         6AGqtcxDkpCDiGtN4brb0XWBWvvklU6tB4kDZ0l/Mbr2ECJ8U+PkvEZLVn0toTk0MAxK
         pvGG22gmdfvzTLh45lHKwnJupuBBl1Y95PGLHhvg4a9ixGXmIYlBysXnRxxgb1u53MEB
         tWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMWUJgQxND8juB2dpDWjZqp+s5qQlENpwF3xgtKS6C9uXF9C9/cMWSL4BcVBEDQRDqfyczLF0aNEBT8Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lpCfaLFPweT+83stej8K6FwhOLW6t6aldE8rKCC9pUNZG1RA
	4IsyB3rSBNzc9kfTNadzybO2Hiwr5Bj1e4UglyMgPkz9yJ1VD28AukFvoYRwk2XE1w==
X-Gm-Gg: ASbGnctrxsDL9PmF8RNxffV5dUtsudhPPGNJPpqBZ7FfJ7o6dDiXBmGVWBgPSD0qROe
	I8ALDiLEy4uMWZwIIvcL2yMTmjsWIRpzfQE3pEdUbX0pmzO06phssc+0rDYdRshdwqXjGtz4kLd
	E58k+6mWAj53n723Y33UhlwbJs6DlkWlSUzX73gsUjnwy1WNh6oV7T5SvRTjgltELnywDQVGuIS
	TJvTaVzlMxP+9IYF9CUpyjYabdtaRKnAYSQQmZPHkV1NuKyEPsYdYoEpsaovsnduoo6gsriwuSD
	vUDCXGIuTkPBzjwiOukSkeosm7usUgpmrZdytx7luQTSyD70DC/lSauLCHJoonLkLxKz6S/rN3g
	T3/kUV9Nu1Jldv0M6Bccipgi7q2cjzvEraVCsAJtkeWJZE95UEyBg256eGgwuQHc=
X-Google-Smtp-Source: AGHT+IH4t7/7bepWnmdaXVZK8YVZIBdABuEFNlaTKLC/CcssAnhPsmY0/sDAGGy3Vv1/VtD+rGPoFQ==
X-Received: by 2002:a05:620a:458f:b0:7e3:300d:f1a with SMTP id af79cd13be357-7e62a0fde65mr324852485a.19.1753269234673;
        Wed, 23 Jul 2025 04:13:54 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9155csm630107985a.95.2025.07.23.04.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:13:54 -0700 (PDT)
Message-ID: <90b48f29-59cb-489e-95df-e3ad36812185@broadcom.com>
Date: Wed, 23 Jul 2025 13:13:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: brcm80211: Remove yet more unused functions
To: linux@treblig.org, kvalo@kernel.org, linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
References: <20250626140812.56700-1-linux@treblig.org>
 <20250626140812.56700-4-linux@treblig.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <20250626140812.56700-4-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2025 4:08 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This is a subset of unused functions in bcrmsmac phy_cmn.c,
> They're unused since the original 2010
> commit a9533e7ea3c4 ("Staging: Add initial release of brcm80211 - Broadcom
> 802.11n wireless LAN driver.")
> 
> Remove them.

Tested on BCM4313 card.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c | 129 ------------------
>   .../broadcom/brcm80211/brcmsmac/phy/phy_hal.h |   4 -
>   .../broadcom/brcm80211/brcmsmac/phy/phy_int.h |   3 -
>   3 files changed, 136 deletions(-)

