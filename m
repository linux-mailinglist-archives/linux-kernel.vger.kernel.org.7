Return-Path: <linux-kernel+bounces-844732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22689BC29D5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2324719A1233
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EFD23C507;
	Tue,  7 Oct 2025 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhVGKHs7"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEE1FDE39
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868332; cv=none; b=AeZBwfJFYs6JpXQ6lm2iNzrY9ux0O1XvBEuYAN8VZHtJOyWuo+ncTPIDKSnbr5uSKUj4ohabZufaZIHHpG10WwLGH4rv+hvlO9aGbZhB1A35z5r/3cbIbJCgv9CZdrYOFkAoTbX44ugb5rpzHb31jR1qx0H/hGySL8cBYC+eAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868332; c=relaxed/simple;
	bh=t6o7XkzKv+u7CI1UFQteRyBrmLJdqDMJ8YxEK4sFqGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+MQZE6VQH2DNZ4Gn2yujrZ+SiSI+PKK+H4isnW41T3fH91YVj1t0kwf5H7GJAaIo+zFKDkzBAx6X3azebmJ0KHqSKAuz7mFBSu4sa1eT0zek7dRdGUz5T89tnY6ydTXI0PKGZ0bOVE7dU0o/6i53LFzJjELkE1tcafMJVc5BhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhVGKHs7; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-64fdca63b41so695194eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868329; x=1760473129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6o7XkzKv+u7CI1UFQteRyBrmLJdqDMJ8YxEK4sFqGo=;
        b=rhVGKHs7oYTNAYvO3uyvddwiDnsLj1Apvj6uZxAf68G2GxTNh/nADowc85TrHZ0LIm
         /PNT4M4gDH44gt8PFQRRexTGntgKAwc4L1DtvDxDGRtPQu316KHpS2Ui9zKQVRAgcTXs
         7L/7W0ojPdKo7IagQ1HH9lx3fUq+ERvYwNdibuQDlYQRDAJxG3DlK2FiOdq23UJu8EJj
         Zt2i1N2CaOGUXtsADZkJMuGZadm6y/ukulFMnqFr+alfAc6NjOshH4khKASh75FYbCYi
         Dc0aTObxQbeZNnWgI5VZnWOiKk7ZMp7gdiqAOL6jU6aJC8SIYN/pFlnOzF/sdBgOImZF
         tRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868329; x=1760473129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6o7XkzKv+u7CI1UFQteRyBrmLJdqDMJ8YxEK4sFqGo=;
        b=nADFtrV+TIRwaZzI7xKA/tj9832Z5x3xC9oMuzCRu6KxU7Vg8RT6WaFAAxd9g5KSPF
         nyqtdbMMKsnKB23oqN8tQ/E9z/3Z0E7jYyKlafSNe/WzRc7YmrZUsABRo1BUpjWdnt0M
         wE2suYHdTDj9DOiZfnljcKmIBb9GBS489/uKXRStqfQ7+HyVNQ0ixT9TbhSzfwZLVFws
         AaugjAHjvfHI89gXGOMjuj4/MgSeaeSMP1GMHfja3hNHCHjmFM9KMRni42Oq2RrwjZr7
         3TwrWNiaJyhGVcGVXWvaduhvq0B+hDVCTnRTeuAnpghtdibe4C6qVzsqhScDZRWE0gAg
         s0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV5LivT/z9Y1he2s3LT0X5wjlVQDcg+etQYoI222iezqrGljnSZa5kn1jMJHrppsTC7yXYHAsOcv5ytIG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghqIAq8cPgLkSpovC71ymqIPgUfwS6UiDgGNYmKozRraZnwUR
	FU16FIb7fm8gbvaIy0SrieCx02Cc48pk1ywoZemVOPBLncJBIxA8TD13niaMHN1Ydb0ee3oaKTT
	v81GWrj16YXyKSyhm3XwUGXpZuxZNAfmZwbpcs1IwGQ==
X-Gm-Gg: ASbGncs2wAuVOTrBX8GtTXpDcSJrONNCcVriWq5B3jMvxWPGlps0i6w0XjdwVLzIK5D
	cPeXaxan/svzbygyLar0KlWvS9NwuhGtazUfxrAEM7i09H0xUZBHcizhkUzkNmz5DpmmN7aNKDN
	AhHK87UbnReyHJKzv67YrSUkgNO7ubNR6LbKu28cfeoFZCP1XCBvkJPoFWjZHotbkfAseS5djx/
	N0KaWsOTzVVKFGpUBePf25lgwnc5lfGK+vzeA==
X-Google-Smtp-Source: AGHT+IEL4dmypG8WFgpOU1UIUsrODE8etCKEY8zyKzUkyzhaZJQ8flhaIQqg8X0wJtfFE1WkEjdwwHsi6B9jL21hYVk=
X-Received: by 2002:a05:6820:a10e:b0:63d:bc20:a63f with SMTP id
 006d021491bc7-64fffe6daadmr379683eaf.3.1759868329050; Tue, 07 Oct 2025
 13:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
In-Reply-To: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:18:36 +0100
X-Gm-Features: AS18NWAMBYtEWn2vhviwKZeJuPljrJcOS2KOQNcYCHTnuQAmZAXGTQe_GLqqgoE
Message-ID: <CADrjBPoZpTUN5N_Gh6E0LFmndJs4_nnSpQ0t=XORQHwFn2=BNA@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 09:07, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
> with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
> inverse of clk_bulk_prepare_enable() while it should have of course
> used clk_bulk_disable_unprepare(). This means incorrect reference
> counts to the CMU driver remain.
>
> Update the code accordingly.
>
> Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend wit=
h UDC bound (E850+)")
> CC: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

