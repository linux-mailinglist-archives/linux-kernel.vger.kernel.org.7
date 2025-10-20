Return-Path: <linux-kernel+bounces-861586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904FBF320D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B9644EA6A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4802D6E42;
	Mon, 20 Oct 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TQvWVhO4"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320C25A65B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987599; cv=none; b=UQ4BEyDLSfM+Y+sqiQABl5fWZUg2u+6x+gOBNcs8wluMfq1AfQuY3VuZnHdMd4iVs2QOBej6dq8fKAA8D+8I5RCIr+YCF2Yff3BYj07qV5zd+XuRkEamwmnQfNjOoN9SeJB33PoZh1HSvPeapVV3GwywG5niYQyndwnFaCbNuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987599; c=relaxed/simple;
	bh=TmbBKgx0r4SprYQMKJE3Nc7QoAEOdBCYKwJuyxhY/NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8W8JHRnzbjzSghClLVf6wtyZywlD6g7AmUzbnVSux+wESV5W68srj7I6c6r7euQ1WusTJWCTW1t6EGM6sd7ZVr0cyXoUpijBVY0vJxl5/0QGuvYQwVsGTryFeP8eyZXAWyxGTV9DICJhpv2b9W7Wy33mDyx7WkI0rrD426qUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TQvWVhO4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so7783970a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987595; x=1761592395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/1IqfcCUA9YLagYCycxbsY/fycVFokt9Tw0XGGRWeE=;
        b=TQvWVhO4EwIlU4EKPwzhTlm42XIpRxtsmMZmssZ7K1JD3NuSbnd5l2IWAYazegRsMp
         Y7//yZiWPsNngw1rMlCdFw5d6bh3zVEzmJ2B6VQOVZ5DsOJ5i/zoh3SjWs8lDs2vXA4f
         5aUzMDrfeN8MJKlMQDNs+xNtNHvXxNuHHbl5NsT0BqYxYG9DFginp3lNhnltGqRTx63J
         SMXWOm+eP5eI77xyXBSLDoGPIVMeIh41Jd7wgAHlQDX1N2BIdLoQlaoR3Q/USpdkajcn
         /ZPprn4wQgc4LRAbe0fhND9G42GXvYY2jO0YIshmjiiY+laVu2e4FcTi2sEtXhplC5hq
         eTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987595; x=1761592395;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/1IqfcCUA9YLagYCycxbsY/fycVFokt9Tw0XGGRWeE=;
        b=bAqYqXAgIiJlc+y0DUq8fXYDBPNyj5A6qA8QDZH/zAm7ldKf70VhXYDxwcNnWZxFbn
         Lqz9fkcKTVxc7vd5o4CVDekunnpxgf4yikEssWbBaIAoiSwP97SSdb9eDZPKJYu5qacI
         qAHxaAZCqoW8P34O1MEhSV+rZYQ1yhUxPqb4EhVAnlipT0H7CV0B0XmtHeR/im5LR/7e
         TZYkTsJosRXYQ0yeqE+qx+M8f4dC1nkV6zYRuPBsX1t4aQoM99G6CSurgGFEdMS3QM7k
         YAA0/1bKyYP+wzCBPB5IW+ldB318DUMoFZYuZT7wqo/yvxcmQiDuQfhc5+y+yt26cRO9
         sEwg==
X-Forwarded-Encrypted: i=1; AJvYcCWTK6mLAYDocySemSFv2X/+bH93LL6usP1P+QfLDlQ5f0UWN9kRZuUZBCnj6yvVlhd/NpHspRmGONuXRcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWs8C+OYEO+4diXjAtoI55Rf7GWGhnXe5r+qPc9i6hp5RKTxH4
	SEnmaP09XmBvN5jSbr5iTPzGVBUHtu3hhOSn4VzhOlF4dQf/D4rhbgdm+1y0l9gs6aQ=
X-Gm-Gg: ASbGncswiqRSELqsy/tLoUJY6OaKTBLI4hKxOvnAS2pMcpIbtP6dxR9BgzLenHq9q5F
	tZ65foM96jXegs0Twq6OhdfG+g6ykksIOoWfbyS7SeZ2bYafTrk1H4ay+gi+euFteapI9eCZiUF
	hKKvlKIW87lkoPufWaMHl+qJDNVqqXVYADF9z95Gdr19ZbynSQdHjDw7s1DiyIMt8DJqQ0IbqO5
	D93SuTGbnz/S48+SLqPSyFaUJDYVyPBABBBfZG6Xmhx8C9OddHbLtox8RXVVOGkhb6WVesRuH1D
	C173TSdf1EJCknNvX+GX/RYvlyqDlmXJ/TD/CKSlNNW23W9a+pGVNKaYM505XLH+LXztX7qedhu
	eOvPFqqSLwpPMlCkdVTXTmntDXrouczxXXUMZO7NyxAwt1W7xm7USmxAuiCTHXcDR//B9efk6/O
	U7CsZt9Xhi
X-Google-Smtp-Source: AGHT+IFegYM0qEO5npRuzThv182Pha2riR+uFui+GrzI4KaHnCKvwdQOowJPKiLUY+i2Ba0SSvxXbA==
X-Received: by 2002:a05:6402:354f:b0:63c:6537:43d2 with SMTP id 4fb4d7f45d1cf-63c65374608mr6780582a12.38.1760987594661;
        Mon, 20 Oct 2025 12:13:14 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a93998sm7234434a12.4.2025.10.20.12.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:13:14 -0700 (PDT)
Message-ID: <1b33d759-be0e-4bd7-b7ca-586d35b1c1e6@tuxon.dev>
Date: Mon, 20 Oct 2025 22:13:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/31] clk: at91: clk-i2s-mux: add support for
 parent_hw
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
 <276cf23db4b81668bedbcb7b2dd310b62c2ad025.1758226719.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <276cf23db4b81668bedbcb7b2dd310b62c2ad025.1758226719.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/25 00:16, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for parent_hw in i2s mux clock driver.

s/parent_hw/parent_data. Same for the patch title.

> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
> 
> All the SoC based drivers that rely on clk-i2s-mux were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

