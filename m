Return-Path: <linux-kernel+bounces-892199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FC5C449A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848ED4E4930
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844B221540;
	Sun,  9 Nov 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coGoAD+5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF6145B3E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729323; cv=none; b=Vz2idGyAq7J8ljAp9lDqVe6yhYo3q8hIBZxDcHHuxyytRaLiUDDtMzmrZVqVyskDAyONz3VQ9HBmHpE9U6pnZds9MPDIiK4AyxtHkoN+YXQCRMkYcQTDg/SaKMnZ/gioq5LUFbytySuPyg/VTwHTnUrb3zEcCyraj4531UKC92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729323; c=relaxed/simple;
	bh=3/L0T8rSm6gsiLWrh0ubcOyIYT6RaCJ1Xiq49GwI0nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6kMf+2NlVd5bqOEQXw/EnkKBTG7PbV6u1mVvQUTADgNMk/6HnfqFmtqSxBz+NJJaU2Zjiate9ECQjTDaYnlyP/EtFCXyS6LQ+6II5ndXgpKkgWFYBidPGNr9iIWkSJQ2Z7u1/ZGn8yVD3FIox3vlVuq1/D6mYumuqJMxQM3nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coGoAD+5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943b62c47dso2046731e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762729320; x=1763334120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/L0T8rSm6gsiLWrh0ubcOyIYT6RaCJ1Xiq49GwI0nI=;
        b=coGoAD+5cxjVmuqTw06wNuC42yPJgph15O5XYIQAV4KHu04uIfEVw1/Oz36dpUBWac
         pVYaX2Lk2P0Wr9bPUCojavFmJUPNiw2zk2N0iZRdNa2z5s4g9R9t+jnj2du1KLxJC+jN
         21nO/zmz3Naf1B7y/8ILyhaVfYJNylzR1HZQcKBs9R5hG3f+O5U6Lnf0YKzL73pQEKA1
         X6OUAIdUpgBmvUjWwHyIXWKaTb+ud7tdaRzzBolXmsBjHgiBjuj8JFWFlEWwyuWqETzQ
         PfL1xVOwOMMKJay//Negz2oQQjeH5dIVoRHfVIWdcnrpGMNqHv13Z6vhwsmOpiceUKrb
         7fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729320; x=1763334120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/L0T8rSm6gsiLWrh0ubcOyIYT6RaCJ1Xiq49GwI0nI=;
        b=M9UeiiSxzss6uiIuJJ31mAHI/0UpY3dl1jABJ7EPcavaAWwJCGNUFNI4HCyVmRNd5l
         S/3sOuaXvu4z4UIEZ4E3/NXFSqkmrfBUt/NUi3E7w5B9BsXWp9cKnW7R6ifL5Cenjxsy
         XfGNPh1eSh+jI1oLnyzXII62UNQ0lDhkEPkHUGN1Q01+9QNMVcQW3qWfENCZN95fGdfj
         DLlwA9idWNlp7BvW+xnEYpAY2uUskVp3NUFdzv7pXcpu/zFq1qXmJusgpk7FbHhKgEoC
         URXgNyKhVyI5RdmJOu3x86oxVVCppb3iO1ufCBm8vAHPbTE8EGezKcRVa/r6aVi86IIk
         9/BA==
X-Forwarded-Encrypted: i=1; AJvYcCVRPBJ6MWxXbLgTXYg1B312v6bYchpGbuel5+S9C/+jd+szE1LjY56X1zJ2ayjMzjjk635fLLw0UI8gmGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6w2cSvfzdnuts2ChvlM4Ts7K/PVEC6uvUFL5hhF/BZxfwvJOu
	upDUW6gjTtVzOu/MY6lNxzpQqvNaoultJGACrRCnLcod40M9fNv7KW3U/2d0PndJNFrFLHF7u1c
	QWv4Bx6O9CLspj2oP2dHX2H91YDsUhP60urv05yQJPew53wYY5xfb
X-Gm-Gg: ASbGnctyolDyIBz6AETKlDwNwY8eBnGCK/P2Vvt0y9qDQJrwql6D70ainjDfMn8+MMq
	CCgauReocMVLeMHjfELjjiKPke2XhLJHy99Y9dpPBIr/ToksA4A5WBxAoK5h6W7iywchz99qJxs
	FP1nPznBKqDHmoIcNl3SUummuAe8cHJTHR5fO/wfaLgswJQrq7WsUhRt9Ar+A9gXN9oXzEv+gLA
	TGfY9qWXCCIZeAn/aaV8Nv695IlfvOlv8Aq9G0PCduxiLnTgOCnwbiiFw+ipWwVIb20eww=
X-Google-Smtp-Source: AGHT+IEJqZS9dOiS0BTy1PWLU/LhcYPWlnuekntfeZstCDkN8jIWeEWUqE9o1x1da70TwTio8LtGZ7NuzutBZINWzRY=
X-Received: by 2002:a05:6512:3d04:b0:594:2df2:84ab with SMTP id
 2adb3069b0e04-5945f186cb5mr1826403e87.8.1762729320057; Sun, 09 Nov 2025
 15:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929031031.2230-1-vulab@iscas.ac.cn> <20251028030509.835-1-vulab@iscas.ac.cn>
In-Reply-To: <20251028030509.835-1-vulab@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 00:01:47 +0100
X-Gm-Features: AWmQ_bmRbj12Hfpc6B_yMJuZyJtxM4kU8pIbrDCZ7L1PmiDyOKOscnGYzc0nt7M
Message-ID: <CACRpkdbwzEG8fEO7mbgXTW3nn4rLUJUidHW7GJ+-OWYtch8PNA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: cirrus: Fix fwnode leak in cs42l43_pin_probe()
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:06=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.cn> w=
rote:

> The driver calls fwnode_get_named_child_node() which takes a reference
> on the child node, but never releases it, which causes a reference leak.
>
> Fix by using devm_add_action_or_reset() to automatically release the
> reference when the device is removed.
>
> Fixes: d5282a539297 ("pinctrl: cs42l43: Add support for the cs42l43")
> Suggested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

Patch applied.

Yours,
Linus Walleij

