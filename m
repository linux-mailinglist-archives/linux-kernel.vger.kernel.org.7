Return-Path: <linux-kernel+bounces-731068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F473B04E75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A216F30E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7232D0C7F;
	Tue, 15 Jul 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROoDjuLn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1A2747B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752548363; cv=none; b=YY/SGcZiy7vdiXYsRVJdWOEXBWA+x7yX/zTV9Qiwwj+XEbXij9hHWxjv4soJMQjPbJxD4fTKje0CXiU3iYL7qhmT2NwWzWJ2UdB8iHs3DRShVXkH4/l6Q3/9uWXqLghf0eU2bp6msSIKRHM+efY3eLRVdOf9faztzcW6qPSSxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752548363; c=relaxed/simple;
	bh=FT+EPaJUCg5EV9ubB6H6SXSr22pcLbbvsyVsPlvk+nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USiDRhImv1dwKDeDHRJp8+c4kFeB0TpAZxSRRUbtEwi1eyun4XWcvHMdgatpmecVIcHZ6y+AsWOq2/z9vHbRyuOItnnlTdYRi0Fv8oYx1Lirk++YyFP7hPWjrOZ+jMoNFrXqCd7bglzveIz9fDtzX7OC4a5Ui6D5DS1Tj5+2FYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROoDjuLn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c8a505177so46326105ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752548361; x=1753153161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ThaBBFxLaan5ycPDg8RZ9c/uzgLc+qAqUCDLCkQe+E=;
        b=ROoDjuLnLdm3VmTvgbGZFv1wj1tHtoTDMvjNaYvCyKJwpj2iiXucpmBlWgNTVuRB2n
         Memcj6IRM9p4Gs42fD0Hw7QEJbc8lPaJGp2LUh6SOQaKOD5vUbj13IWHZvOXMREUaTnR
         nx7SZfOwJjS/XVSeuxOBQ4EqApMFlvGjCBIxQkAOG3qWO+/XUOPvT76MTShzcp0qxKtt
         S7krRpk10vPBgWb8y3kk8p9FNZD0of5fQ+xInJpvFQvvrULKJg6Swj2WPsMuiGXWgxJk
         DyuX0cM4w6O3Y/D4LLr8jKLua5yp4RZF7SEs58crtds7tF2RhrL5JffLch+UiP51xOfN
         kddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752548361; x=1753153161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ThaBBFxLaan5ycPDg8RZ9c/uzgLc+qAqUCDLCkQe+E=;
        b=MZ10xWe91WMsi7Dqnvlz5yGC2iCdiChqRzKhQKzl+NbfkqeJqpx6E8W04lIney5nIY
         lzFWHamWmtBcEdX29nQlwQMi7y5/xfv4YjiQyiZ0bTGzWVom1pqlN/J1hgTLmV/VO8hl
         CZ0tzH3QNduj2UeG5YYA59eFMRZbMpGcwioNi0n9b0Jc1lu9fGdaWwhiQK0IX7AZ1qPE
         1Y6n/E1BaAjRpfgYTKj9bdNwbtYYqPUJNwhOFtnf27zkYXN1uhJ6cju9mzlqLlsAoJVI
         WmPJl5fZcq/Hb3mY9gLoUXqtnhX/7KhER1LSBCl9UEHA3bAsGakEz6g0SYLJ++vd9BN7
         4l/w==
X-Forwarded-Encrypted: i=1; AJvYcCWa53DD6rPjEDlTvgwYueLagnmJTMUA76nUYokf7zJA70cJ/xgsb8uPbfnD/xJY8W8vI0Dr+6L+O0hlftA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXFTbwulmsWBZ2siDMvJvWmhFV/MLW+NyYLzHhEu8BPwBe/rN
	PqlmlShT6SMeibS8J2MKIyRb78XRE69uvQ5joqZncTtZFVQ+vH4yamn2WrEaZZo+CNU=
X-Gm-Gg: ASbGncvEzvKvQniqznjf2AOx0abQf62iIqX+kPX3vwpqAAWQ5p2PDv4ljLh9dcedXxq
	ietdgC77lqbMrjGu8vYEnxbifLZRWexqkymBhYOV3wknU2tZgPjq7mOeoBGkC4/2pscOMDm/xjQ
	PScZ64KXLwQCsR5emLjvadQTCZR5RVLvjT1ujZHu5ny2Xldiw/Mw4YguqZ92uYVUXzazpUvE/Gp
	rJwS3OVf19mJkL/5W4L76aEsdjwt1Sm/zYOwaI1BKGT/7KCh1+/tCfXEBw04xJxED/MyL3YJC3h
	pgNeNxsAIF6ypu0YUBZW7tcDZ38r72W76TnnaVAaqQpzhllJ5Dr6LvOQ17BgpMGUnX22+3UPzqR
	mfNBOoRkdnUOye9Gsp5djsR8=
X-Google-Smtp-Source: AGHT+IEZK14JKJx9vQBh1CtChGZSB3DAOZGHhBBAyJvUIa0qYVZBJe8EfzMX4gC9v2p0KEXM1ActbA==
X-Received: by 2002:a17:903:230f:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-23dede86060mr202149485ad.25.1752548361221;
        Mon, 14 Jul 2025 19:59:21 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332e61sm100432215ad.141.2025.07.14.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:59:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 08:29:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert st,spear-spics-gpio to DT
 schema
Message-ID: <20250715025917.3yrffj422v4ggugq@vireshk-i7>
References: <20250714202753.3010240-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714202753.3010240-1-robh@kernel.org>

On 14-07-25, 15:27, Rob Herring (Arm) wrote:
> Convert the ST SPEAr SPI CS GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

