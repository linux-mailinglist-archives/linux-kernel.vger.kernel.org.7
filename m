Return-Path: <linux-kernel+bounces-877777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E4C1EFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977C73B618B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21855309DCB;
	Thu, 30 Oct 2025 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VZ6uH/4r"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820262EA485
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813153; cv=none; b=jgZuC+qOXMMRRri/AbOFKBzK+A782BuOdcNKXVHts0D98jurAFeoNBR0f3jPDvYpADEqTSbmGbRYp21UwNHOq5kKAqEo5QFpSGO2kYV1ISMHmqLiHrksA7TlRLw/81IHhMw7w8y2WmL4oTGiNGGBzwIf83Mdj285D16GA0raCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813153; c=relaxed/simple;
	bh=zXxknCZ3U78u5YvcdxIZ6E4exEcYwT+ah1NLxftWHqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qdGIRCk2VMQChz57FrmCVcrkOAiX5gxs5I734Z3ps2Rw8X/oHB0o1t8Mcn0WuKOFaWCrQpk4Q4/++G4gpYK2cYEKYygr9HVY+z2Rf7w3VNMUuChcvF0sEH5v0jUj+K6wCS8K6eMPUEfzDS4T6N7b4v3I5z776n+7JvbySq+JvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VZ6uH/4r; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47721743fd0so3933205e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761813149; x=1762417949; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQpNXFj7qvzhx2BPwql3tijlryztnIxnxGrC8hqO70I=;
        b=VZ6uH/4r3hFaHl6qEn4UMk0HX5Cxsn63HkXqsJzCpoxo70fDNP7JMFrF/nO+DVmk7f
         1I3sh440RWcuu2gB1ovgF2DCxZfNbzjrJNPFUN6eVSXIdROE1wpdixBtM1DWzde6dSNT
         m+fhBOGpga89SUPv9C3quXnDxVWg69hWRTB3BXcQb7kAHvlctKAWl/5aeKdXuTQcaJdh
         STa+23BOGzTM6AqtWapt0nAVMIlwa0GPGuyv+0hBCO970CEu+MAxpviXON9w/cAX58M9
         lpu2UkYwZmXcwerzbKRRniNYjVzpOfUZJ15Bn10nHZc3S429+cGnuDW8OuLX66y0+frR
         6SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813149; x=1762417949;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQpNXFj7qvzhx2BPwql3tijlryztnIxnxGrC8hqO70I=;
        b=spmO/ZnTnMeNdqadBe14BIxnZuECUJWL+2y5vxja5deJGZEHrSnK6XRW308AHXMZ3n
         ilLQ6Yn1RC/MdA8T/8paYSO+kdPrssUr8uK/VHOw+9xEs8K5diqF21a5gEHo8JjbkMXG
         +PBTr5lXhhSdUkMKN6CwtfHfQ4fVQY88Oq42jJO0ipwIvSoEtoYZxQx3sYdvftuAQcon
         sPK42ReCcrlTh4S+PwJnpYZtZxDIHqLEyT1waIvHEEx79ILi1/2Jdmmul7jLEdcejUfR
         Z7/8uyJPWJvhei6iAeqFQ2sSUK3AOyelDdNJ1Y5WKo0N1dXX51BA5DrdJ7PryTKCYQ0H
         gkaA==
X-Forwarded-Encrypted: i=1; AJvYcCVrJv7BHzNaA+ccoxmSCHPAjy+81GfE/wjhvFzsPsDVm9vYcjankTomgGG74+fjeE4D+I/uyzDZZP+BtaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQOx3mpQWJCqdLGgW/bUcKh3UExR4sJ4a5EenTWN3HMhfkqvS
	FALTiIHV4TJhAFIYd1ePyjXd1OUBsGADkBh1vjKQqrDCt/Rc53JnrhxWX6cfk3KYDqU=
X-Gm-Gg: ASbGnctFuwCsguPjLXL+opGX99J9S1O2hmVyE06vtn8xZnhGyhVIGPRaUl9WJS94dkE
	E3LPGOl7LAFm8rx1bEhLk6LPEhAbFBPCwlpaVq8YfghF7QYpjgxTXnIvPPAAtnPqgmoyT5Ld/JW
	ulEbGHEXQgpW5jnMPOU7c8ixotHBqL+8a9pCP8uvJul5qVaUh5oKTtVKEGruzuJd8ksuZxSf5Ly
	26kgRRjqHez4A6Sz+4YbvKofNMIVwX0MiOlNO7QyHCp1sHntxKTeAeQy4m+CvHgxN9KSOBWAE3p
	5doT8bxtsgCeAsKc+eCflChy5Z/11LM9vt+WX7gkSVpiUCtiuHYbraiuVihOL9H5Es3F9Lxao/F
	RStix1nzTHMg5ymFmi7x8Hs4yCmY3sV0CivofQoCsgV4oRR1HGKlQjeqZ2Bhyod3sE/IXrqAfgP
	hSDU1Gg8cu
X-Google-Smtp-Source: AGHT+IF53HCqpWXmn28GEFR5xxqhKQykU6oDGofkTXxxX4sugVLIN1Bm6oCHAyukU29ODdUC1YBslg==
X-Received: by 2002:a05:600c:1c22:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-4772686f074mr23463575e9.23.1761813148710;
        Thu, 30 Oct 2025 01:32:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:64bd:9043:d05:7012])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47718fc0335sm62830805e9.2.2025.10.30.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:32:27 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  da@libre.computer
Subject: Re: [PATCH v2 3/5] clk: amlogic: Add handling for PLL lock failure
In-Reply-To: <20251030-optimize_pll_driver-v2-3-37273f5b25ab@amlogic.com>
	(Chuan Liu via's message of "Thu, 30 Oct 2025 13:24:13 +0800")
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
	<20251030-optimize_pll_driver-v2-3-37273f5b25ab@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 30 Oct 2025 09:32:26 +0100
Message-ID: <1jikfwzt5x.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> If the PLL fails to lock, it should be disabled, This makes the logic
> more complete, and also helps save unnecessary power consumption when
> the PLL is malfunctioning.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/clk-pll.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index f81ebf6cc981..6c794adb8ccd 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -353,6 +353,23 @@ static int meson_clk_pcie_pll_enable(struct clk_hw *hw)
>  	return -EIO;
>  }
>  
> +static void meson_clk_pll_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +
> +	/* Put the pll is in reset */
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 1);
> +
> +	/* Disable the pll */
> +	meson_parm_write(clk->map, &pll->en, 0);
> +
> +	/* Disable PLL internal self-adaption current module */
> +	if (MESON_PARM_APPLICABLE(&pll->current_en))
> +		meson_parm_write(clk->map, &pll->current_en, 0);
> +}
> +
>  static int meson_clk_pll_enable(struct clk_hw *hw)
>  {
>  	struct clk_regmap *clk = to_clk_regmap(hw);
> @@ -397,29 +414,17 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  		meson_parm_write(clk->map, &pll->l_detect, 0);
>  	}
>  
> -	if (meson_clk_pll_wait_lock(hw))
> +	if (meson_clk_pll_wait_lock(hw)) {
> +		/* disable PLL when PLL lock failed. */
> +		meson_clk_pll_disable(hw);
> +		pr_warn("%s: PLL lock failed!!!\n", clk_hw_get_name(hw));
> +

This is something that's likely to spam, so pr_warn_once() (if you must warn)
and I don't think 3 "!" are necessary to convey the message.

>  		return -EIO;
> +	}
>  
>  	return 0;
>  }
>  
> -static void meson_clk_pll_disable(struct clk_hw *hw)
> -{
> -	struct clk_regmap *clk = to_clk_regmap(hw);
> -	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> -
> -	/* Put the pll is in reset */
> -	if (MESON_PARM_APPLICABLE(&pll->rst))
> -		meson_parm_write(clk->map, &pll->rst, 1);
> -
> -	/* Disable the pll */
> -	meson_parm_write(clk->map, &pll->en, 0);
> -
> -	/* Disable PLL internal self-adaption current module */
> -	if (MESON_PARM_APPLICABLE(&pll->current_en))
> -		meson_parm_write(clk->map, &pll->current_en, 0);
> -}
> -
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  				  unsigned long parent_rate)
>  {

-- 
Jerome

