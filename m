Return-Path: <linux-kernel+bounces-883458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B636C2D82D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9813BDCA2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372331C595;
	Mon,  3 Nov 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCK5WYt3"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31731B10E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191484; cv=none; b=ZDawFVyoOpqq002sGi+H8dnd8e5Ufqg11/Z591sL2oTbvfsEJLelPaV7ToYHBwDGcy45seVDV3L+OAsA8FVTM/u7gGdceg37/2Ogvnl7eUDJposbPM7R/VWCdc6M5sZJhtkLE3mw2WoCBzRJ0HKLtf4uI34l7ttu9TPcsOLuDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191484; c=relaxed/simple;
	bh=hQ5VC0/dQba0Gh3YD68I7IxwQy+aFc0CdnyEKTGdTOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmB5bBUnx3CTZ9Sm2rp5bgO7vLomSCJjKwl028XDQPLa1rU876GQrr7sGTa5pwHa2AnUdpZuO5dCmaJ0N1MaIPyTSVOqk4TnvBXaJsTnHFeZzPZXxl+/KFMvjfcTnftgkzW51jqopm3TgrxyWMsipRZD7sNSIwCszcZ5qtpkCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCK5WYt3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-587bdad8919so186e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762191481; x=1762796281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ5VC0/dQba0Gh3YD68I7IxwQy+aFc0CdnyEKTGdTOs=;
        b=aCK5WYt3HoYb0663kEDpCRDGETHcfJD/jiE9V8KRvBdV0ZTF7e+KiPYZRqEbCP/xaj
         /nxRF2k+XYnArCNY4yd2AVtOlOTShM68tahAb7ixIwPmEAXHGr+H57J4c75+Eumbj3oI
         8n36RE3AKH/QwVv8I1LTNpV59Ak2qgse2x/Th9VOLThFoYFlyO8vLd+7aF8sHEz6GogM
         UahDmU3Gie0FkqwIKmnzZ538GKGqnR58JFaKB9NPgrB3pXIftNwwA6xg87PVkmpoQ0Hy
         UVmLTDYUxCH9WA8Aud/3ZgbWLfVyHxDnNfmLraCc+fevwcP1qespG1CjFze9RJoFuqQS
         +jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762191481; x=1762796281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ5VC0/dQba0Gh3YD68I7IxwQy+aFc0CdnyEKTGdTOs=;
        b=o34w6BOboZCa8wQyvFmTC2kBeey1iGDUj+LZrxHat+Zb3W8cWvZ6/pZT3mFPLeXxFe
         EHRk75d4uoDWlhcxU8mXDCWVhIlAk6ObFaXvjumxalhqVUcH6iFdemFVqmuOM6rxkhEP
         8SH00mGOeHbz7zYagav5TVujIW2xrkLiBrXSFu2Z4475H2DkTGQpzDE+VdhHFds6MmMB
         CJ7JAk/K2KqkvDQTONtFSI929yqwZELTGXTCIR/DShb1RIueFvWBSonP024XaDHiqqE6
         tpT8d5UTKSma1KkBUqLvEO+QefPJv3WewiNLhLktlQwTkf8P9Dsg8J8tiZ2XwBcUuAVY
         YVhA==
X-Forwarded-Encrypted: i=1; AJvYcCWAYDOsuq2eqezLifOQnnWTjDPRUZ1snfHC3mmHbKSoqPbtRfplx+ulUEgP0XScnPYKoQ8Tg+JZv/S0CuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9w5NWomzAgprK3JRPtj/KFGdvD1Bp6mmmzNRW/YbJFpV5nF/O
	RjWoc/p7DXJxDGlFlYvGArRfVO4jYj6F5POxcVkgpWm5R3U/D3e2jo8eWxJszGZLEvCv8IQqYlG
	ZBHVROPJMH1RFenwW/JNa96X+ZY0G+6ecH/4TqIS8
X-Gm-Gg: ASbGnct+NRZAevdgzW00fm0NATLFga90OQsJ/AHdF//2PngwUWzpRsUzBGP1d7+Wdj2
	LJybPmwrF7mUrj5MryyQGoDbFtVbbZB2PEBzucFWgKEsFMRorZ5P/sM882dQELNKXUXFSx+8lmZ
	pnaG4yue+gJeA9ef0UZ8PeqlBijdFMwnJ+5dJeLs6IkcwZHS1JTE8nWFXLb5NOIMwdN1gi6c2/b
	YF0nh/UmkqMrIGNXBTQsikfaifaog1nYh7iqh/R7/NIG7AXj6vqGMLs4C+DxTVD/9XXIi4SSz9K
	HvqMP59TIZJbSxbs/ZjojGozJmBC+rCMhM0A
X-Google-Smtp-Source: AGHT+IE9UCICLFPcWntGA18am6x99K6fPgsXAsFiBEHX+FYgiyl8C/S7j9hn6Tifv1E1doUNTdSI8Mntwe4yrMFluYQ=
X-Received: by 2002:ac2:5e31:0:b0:594:24e2:54e5 with SMTP id
 2adb3069b0e04-59434541f82mr35129e87.5.1762191480263; Mon, 03 Nov 2025
 09:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103072046.1670574-1-yuehaibing@huawei.com>
In-Reply-To: <20251103072046.1670574-1-yuehaibing@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Nov 2025 09:37:48 -0800
X-Gm-Features: AWmQ_bmjeIWccYnCsAlpHCIicEVqLOMZ8MWgDqZ2I-CyDLIm1J3m7sQO4camekE
Message-ID: <CAHS8izPf5+97rtUiknXKkxpBUu4ENPUb=-MyeBD=eEAay6NwUQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: Remove unused declaration net_devmem_bind_tx_release()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 10:58=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Commit bd61848900bf ("net: devmem: Implement TX path") declared this
> but never implemented it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thank you.

Reviewed-by: Mina Almasry <almasrymina@google.com>

I thought about asking for a fixes tag, but this seems trivial enough
that it does not need to be backported to stable or anything.

--=20
Thanks,
Mina

