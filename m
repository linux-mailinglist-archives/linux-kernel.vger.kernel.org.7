Return-Path: <linux-kernel+bounces-773993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60AB2AD4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B7C566977
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996C2E22BE;
	Mon, 18 Aug 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I8Bq11ah"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE452C2365
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532034; cv=none; b=E/BgUHfEyY6r/TMplEN1waRbDf1N5RKqDzThCC+v0xnNNvoQ8MfWlDha1txcylVG0kN8TRmRLeYvp8W3YqhrsOmz9B7ep2CHALlc4VpDHFD06cIemH1LafK9zAY1smaSROt1AOrtY4FJC7n+KObaT5HFc+o3cxjVXe9Qgu6AGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532034; c=relaxed/simple;
	bh=WUakmhPTGh3JHJBduDtg9bHzUVeNreikaFApL4jcRsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6bbGRYx7gZAjkx5bHcNf4esImSSVsBhrS6jUvYOVDXD3HfkUQv0F+cYByMLvvZuwAK/EzfqtLMe0yxhekFVVj4z0lGkqEm79tZhJRSxhiIpZ1A1k2wsFtxwexI77pGvrOtOKDiCk0wX6P8GGE7nZL2BqbmksLMtT6cW/ZS/6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=I8Bq11ah; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b134f1c451so17857951cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1755532031; x=1756136831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NZWNuw9uqGyH6UBABpbY9lwXWb90jB/i2Dis4FmyQU=;
        b=I8Bq11ahQhqfEnYtsoH7G5MNTr0RniVsDDpcFBN6FbPC3qcn8JVyOaS2C80/YmoXJh
         g1u7ie7+sP+0lS4MEzyJlP0oS/jhWoi4vLDhkDlpm3cbKKseDCEXtCQDKGRTQt7xWdvw
         7X0t7HkzqpmmCSBgY3ln+Ga3V6AK2TGdZRDON8MLGffvM09MWJJXCNwjsx4KsWVwpiiZ
         bfVTXIGI2zXtnmz+g9mcKnasm2r5EK5PIazfJV3WQ1+gD+5GVIjlq9MJYcGVnCXV/d4P
         lMnYu4tcRpgBZVJN8xep2x6VD7Uzacse/hc+5FPjaAA7BCUOmJLerQ5Z4JCQiBkx6g1I
         Ub+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532031; x=1756136831;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NZWNuw9uqGyH6UBABpbY9lwXWb90jB/i2Dis4FmyQU=;
        b=VpfoAXZUOfTDY8JyoXB7Pu6MUtiIvz9BJGEdOcYCajPQ+8SxpiFN1oTrtIgL5MEFVS
         hZhJzp2udsOpC9IcNH3kK6JMse0K35XfokDcTmHpntxXkmfx0pusr+JAFpAYcjM8jCX1
         aO1x1QNaWumWIXugJEeqyPtB+A3l9CpZc7OVZaxTjqSvShn2RuZO3aJ3Qw16NrBEwth8
         v71f09M68nUuBfjTEkF+7SJYrSgv6Dg2B+FgtKMsgzNwZP05bKdKgHRLIFtF+8IwcvSb
         7xQv4vlxiDc+ODIBNNgIIXZMbYBnuVr8GevswDc+JU7kG101Qx6OX8IJVwpZwMBXLQm+
         JsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO/sH9V3vlump3S6/OMmA6199P5n01xyiNCaTcu88DEV7FCFrzmq/1JPww5XitfW81qMuJQl/Hp+0JfCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/TwwQtMYmIRwrKMg5iZtvBGLooRLM3mCM393dBZiucYMCj7Ng
	asEX69vpIH+CkFsSd02wv7usLb7DtOhSuUxztD7nZCgeNoMLVaoz5amgCcJlhf4hWJY=
X-Gm-Gg: ASbGncvlcI5il57Ya2RHUmGJ5iYc2vPYkVBQ4miZ/jpvq6u7xYDVewi2EYyYJDWgdT4
	8Ih7wIRxxuSdA4JwEnYCrc7TscAtw2982TXn6nDQKypy9IRkMJDEhH0nhVytTQM0Uhct6sOwCPg
	pz0jddxf+3093xVyE4RvVGugxSQ+BXx7myvhiCK77yOnwchScNg5K6+VY0VDkuiav29543htD3N
	VW7eqsCciLT2UyBOrIKzr3t5Mr3aefHoc0b0qOMEjuXwLUtAyJGLTrlfBR8xJ1q8sCca2Q6Yi4W
	Ybi8JM4a7dmAi1ZXwz6A3KHK5WEfr3ZEw04CLbX0zjH2AepEAMl22rSemVi7VcXSKtuaNvDdO2/
	1XYtgVF8R8tw8cR096JystMG7+kZ+p5mbqLxbob6q
X-Google-Smtp-Source: AGHT+IHtyZSzLjJeK5dygj5R68bwBBP999TKqLNyPthvXLv8L+n5/XjRwQcWRiuFAFjpEWW5iC0zvg==
X-Received: by 2002:ac8:58c4:0:b0:4af:1837:778e with SMTP id d75a77b69052e-4b12a74e438mr104897681cf.31.1755532031187;
        Mon, 18 Aug 2025 08:47:11 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.10.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1e15besm610112485a.72.2025.08.18.08.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:47:10 -0700 (PDT)
Message-ID: <7502cad3-ca4c-490e-9b11-50e3297b6e32@sifive.com>
Date: Mon, 18 Aug 2025 10:47:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 046/114] clk: sifive: sifive-prci: convert from
 round_rate() to determine_rate()
To: bmasney@redhat.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com>
 <20250811-clk-for-stephen-round-rate-v1-46-b3bf97b038dc@redhat.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20250811-clk-for-stephen-round-rate-v1-46-b3bf97b038dc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-11 10:18 AM, Brian Masney via B4 Relay wrote:
> From: Brian Masney <bmasney@redhat.com>
> 
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Note that the changes to the three header files were done by hand.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/clk/sifive/fu540-prci.h  |  2 +-
>  drivers/clk/sifive/fu740-prci.h  |  2 +-
>  drivers/clk/sifive/sifive-prci.c | 11 ++++++-----
>  drivers/clk/sifive/sifive-prci.h |  4 ++--
>  4 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


