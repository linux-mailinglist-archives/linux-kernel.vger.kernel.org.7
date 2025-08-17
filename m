Return-Path: <linux-kernel+bounces-772441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A0B292B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 12:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94B73BB344
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64F283144;
	Sun, 17 Aug 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D4YZbSI0"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8922522B6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755427033; cv=none; b=dfc8fyqCYDvyAiM1iTK1ZbUwEuiXv/qNJJVcCl78ws9vNFTybXbgOkJjb9X1COyACewdZsjUu4mID1EVnZwfzm2PXsmQgEyV8vcRdiHl1IWYF7OiG+e84vbSDlpdIOyptkSunLmULBrGVg9qXTjjhi7ot4gQ2LwYPE3rZ31EyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755427033; c=relaxed/simple;
	bh=iSllK/eVPmkmYdDM1igS9ECfgRrvRcauOGTshfvTr+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toUI3goycYN9DKyqMvZRcClxhaBJIcG0R7vQgqfir+MqSdXa6tCrb7XKdvEBlqGl6KlApuvim9QZQ4S+bM/VtzVjEmzfLQuNXAXMBlA3Lm3iRM3/xkpMG3vPNHUv3RI/7coYYy0xbrydBkz+7JRk4CQuV4+YaAz7/pAn3ruhEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D4YZbSI0; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70a9f5625b7so32675326d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755427031; x=1756031831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G6sCIz2VREySyzsVRI/UsMW0BUAHcF4D9MDx7DRdElc=;
        b=D4YZbSI0+FnY6SFhImS2IUX07svJs1/TSgnCsUvPd0m46tWZc/v09xpLmNdhYJyj1r
         nFZi/G5auMFj1tOAu/3OrCgEQCK1vETvkPZ2P0a7UG7Maq8KKNKtC8sY4WOI7nnGCrkG
         mik+UCqjlqfpROoqP3wugoUmqsI6Yj3vZtlDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755427031; x=1756031831;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6sCIz2VREySyzsVRI/UsMW0BUAHcF4D9MDx7DRdElc=;
        b=wfby+owz0BH/DZ6IH2TGKL2wHfzFOGN1NxRT7KU53WAveynRFigtlF/dM4XkOF+hhP
         SxxAIEpW24jWhoBM2R9+Aa8z1Ieap5SSwOdWx2KhfmKMOY2v9OSRHWxDI5QTiCrblYd9
         npVrsXACLdWMOmR6WriCzi2Bxn9WBWGM+lXL+JTD+FOIz2TSYXvpfGdfDlf9pTbLimYt
         WBLaJwuHB1nDwl3DVHKTvD5nbICBX84wSaYoD1R6Kg5OtcBXlKoFRwJzxtdipHWH65T2
         UUOCEWKqLnDQMTEFMMGUE5EoOagaHGuQmOnLjwYSuI/07n+eTfFYeuf8xeq0prKfS4y2
         GU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXeAHI18b1Jicyih3OCUkEHbbsFc8tZMrSK1k7h/GVlGm7Ekhjv8p1zyxKvCkk2ZoaxNvzSxV5H6xkT8sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGEOjfR5CA3pEddRA0sVx8Vbehnl7RMfVT0RJmVoW6oNyHzNk
	3OkgBSne5VxvA9aGAILiUxRcjUP4VzexqpChep1WDtCE1Ii7+3N58sKhPZw9Rxd4AYSv/tmV9W8
	gVOKDsKut
X-Gm-Gg: ASbGncsqBl1uqTjHCA2cK0CCfVXbXtVtn4FIh4z8uidtB6ecvCC08yHXsCLNx7nHfu9
	AiTzy/9jdO8YIblso/QHV4uxYZAYQzzKpHHow/ghIyW/1IZP5J3+nEuYpNEtH4vrkJ3NCvJdh78
	IXN90Lr0qKjNxUb6QlJMPJgorXJhBne2B00U0JrmLU9KMHP5Yi3huswFNTvsxuOjb5UQuEPxP2p
	TIGRKjwXO+2bz1CoCQ6bi6ct64hY5HtpP6po9vzEiL0Ztyk0xru6f1Mg7D3rcbP5HIuvH1nObyg
	11/FL5jh3ggBncR4gCRAlezayJWshQjD5MoZapiiEj66jqO/L5th6CXiI2gMkMXztID6dM1Pwa3
	XQN1WgKP1iPh9mEyOEkOppZ8bQTv7hPP9kopqbeXgqZUMIDcze6uUxn25MkMTvx82DDzPbVrkD8
	d6ofOqSA==
X-Google-Smtp-Source: AGHT+IHx28JX4MTU+/w2vDqZ1SEYeUwX28qzixq0OdjgrBtHUJZTJMwML13kgpQ+vBUh8/Fm4t9tqQ==
X-Received: by 2002:ad4:5c4d:0:b0:6ff:1665:44ef with SMTP id 6a1803df08f44-70ba7b2648emr99050036d6.22.1755427030588;
        Sun, 17 Aug 2025 03:37:10 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm36080976d6.49.2025.08.17.03.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 03:37:10 -0700 (PDT)
Message-ID: <9fc9a2b6-621f-4d24-a726-fe4309e090ba@broadcom.com>
Date: Sun, 17 Aug 2025 12:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: avoid assignment in if/else-if conditions in
 NVRAM load path
To: darshanrathod475@gmail.com
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20250812123636.2142292-1-darshanrathod475@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250812123636.2142292-1-darshanrathod475@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 2:36 PM, darshanrathod475@gmail.com wrote:
> From: Darshan Rathod <darshanrathod475@gmail.com>
> 
> The NVRAM selection logic in brcmf_fw_request_nvram_done() used
> patterns like:
> 
>      if ((data = bcm47xx_nvram_get_contents(&data_len)))
>          free_bcm47xx_nvram = true;
>      else if ((data = brcmf_fw_nvram_from_efi(&data_len)))
>          kfree_nvram = true;
> 
> This style violates kernel coding style guidelines and triggers
> checkpatch.pl errors. It also slightly reduces readability.
> 
> Refactor these cases by separating the assignment and the check,
> ensuring behavior remains identical while complying with coding
> standards.

Thanks for this patch.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/firmware.c         | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

