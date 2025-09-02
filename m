Return-Path: <linux-kernel+bounces-795619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F36CB3F563
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037F020373C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD802E3AE3;
	Tue,  2 Sep 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGrZfnDt"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63822D5955
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794234; cv=none; b=DGuJTYlIpBKRW0inzS3jmzhxfzFg0IRBXyqrC1aC2l/NY2ZSpAHH3VFtrPBrJY3kSDQF6Oaz0wmf1EuLmLdYPhc3mz4kq5kS6jyDrGS/rrD8RiUnG7qNaOCru0uBugJ0jTlWmNgnbcBwid0OXb1StaZFHuadJOgjKcSOrnfRvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794234; c=relaxed/simple;
	bh=BfMqR1lpaXjunNeu/f0O3MEaWJtI9f+ZecBRwP2xSJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDvovciDpCa5aH3jmavhGgNIn/gmW3+d5UWYb4xoOx1bgYEIsfVnQfbr0h5GFzmXqkAlWZZp5Uej0vnnEm6nbaNCbVu1J1eOWruQwMY2UmEKyA653B4yPXbJJx0F0utFXn/ZU0iVBNKI9qsFt18AHbrSU5AVbPGHE7T9Sngwj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lGrZfnDt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4df220483fso2107277a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794232; x=1757399032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Giav7j027e4My3B5JV6e08IP7F2a03l4dML9+8XzWV8=;
        b=lGrZfnDt1m2PthetHfXKM4BUxTBc3xnU67xeAXjry087HL0LBf0HPxKhI1QxVCKnPD
         vH6eH/h/y7btmYpvwKSG3lyE+u/t0acx1tstuYs4OqvOk43qxcfamQg8dvih8mHr/2+7
         urgrROQDufmsjXFFvDNX5Mmpdl+i6DXPl8mHY8oJ8tpTb3uiXvKiLn6StuhKT4Pw4P0I
         AG6cMKPuNaFqpfPhuO3PXB4ldERQS/sEyte/WJooL92sv4hNIgoMh6VJLsYc7XeDdjaV
         N2j8eZ14wrBrZKRXeItIAI301W/kvwqricwvXKy69PxAdkIKk2M3NGvOWMLWDcfM3MJO
         3U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794232; x=1757399032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Giav7j027e4My3B5JV6e08IP7F2a03l4dML9+8XzWV8=;
        b=Wx+fKajgnkIqW2IHtPHlpm9UAaXUe5d9sh009s5t9BOw4D3YZ+sFftvi0tMYipVjhC
         asRBP+qIJLIUup0IzxtCYS9iu/dDSp/uSavfijR6FVLWUJPw5Y47AWLApDzfMJznOnmx
         a36uzhzzocqKaK2al+8ZiEwvjtniVB1oBzv2jkQpZeRk+ctvSW7460tTUNPRB2PeMFi3
         IKEr8DdUOlfy52AjNJRMYBEuG4J++QrNKSWptRhlj+34VqzIhZhZ97MH+DDi6XWhd2vo
         130HRbwqp7Xtf3mUchRFE8K3Qx3MVJUaqtuLYC4Xxv7c5rW3irUgvEK+rm14XwKm3pe9
         jvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDgVVeJdHEVu3DvBO5iyfNwmcV4bm2L+5G2TxbnQmUMvvkiE08qRxPI8Ra8BqGurvopj7H4U3Os8oH0nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxf5N0Hq+GtfdlPagRDGQQi+AElF1Hc1wJqh/Q9zCNRyXPNv6Z
	4FHIZg6MBN/WFai82StrxRxvIoYSKjXqeJZAgKrUUn1G2cIafgltgcOaj6QdnMJfI+M=
X-Gm-Gg: ASbGnctFUoo9Iz5MfjzedBufLB/zZIj3CNhCOv5MyLBke/ZGwfTY4VlgPEQMhAv+cRH
	534QTTUrb4taRzjMLYcmVktpBR/y45RAn1KSu/2391BXEB5WdCBOzlJJlnc5kp+rbFDcFlEGDlX
	qg2EJbbVVguDv/4G7ut47mZT0yN7IUGiQPK73cMc+0H2va84c9aZ5f9f1fURwNXo9OIR/HhOd74
	uTFIb9YaZMZui4X9gCLaoozOjTPGn6R5p0gxv6dbDOnLndqLuxNTC53HYtvbweXEEVsC9US1+7k
	6F7Uux7i6SH3Ctc9BjWf77NkTevgElkr8bBe4htjjvevWLqXXNf1GJOc9/0xHtKqDE9Pqf7H16G
	PSM84SrNRuB2zjl3tb8stGA4DbGJigEcDSnU=
X-Google-Smtp-Source: AGHT+IGRPZAvPZasiyY1AtGkY5yYDRJ7Hy2NGyIACxAlh42J8TV0WWag3m8xK4lM8awcR5hl6BmDUw==
X-Received: by 2002:a17:902:e847:b0:248:9c98:2cf4 with SMTP id d9443c01a7336-24944aeebf8mr150113135ad.46.1756794232129;
        Mon, 01 Sep 2025 23:23:52 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390b6bsm121750735ad.99.2025.09.01.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:23:51 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:53:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
Message-ID: <20250902062349.cxg5377chzqtb76r@vireshk-i7>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250901112551.35534-3-zhangzihuan@kylinos.cn>
 <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
 <34092883-c04d-4dbb-a756-eac89fbe6f3e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34092883-c04d-4dbb-a756-eac89fbe6f3e@kylinos.cn>

On 02-09-25, 14:06, Zihuan Zhang wrote:
> I also noticed that in some drivers like acpi-cpufreq.c, if freq_table
> allocation fails, the driver won’t be registered at all.
> 
> In such cases,
> 
> should the NULL check be done inside the core helper functions, or should it
> be left to the drivers?

Not all drivers need a freq-table and so it is fine for them to not
have one. This driver looks like can work without a freq table too.

-- 
viresh

