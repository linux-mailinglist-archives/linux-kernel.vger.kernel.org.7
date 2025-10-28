Return-Path: <linux-kernel+bounces-874618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BCC16B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90A0C356E52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25334FF70;
	Tue, 28 Oct 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI7RRDf5"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A6C72625
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681642; cv=none; b=fQ8Z3r3u1uDlK7azGEvKnG8sI0Uu8lgbKo2Ev2batycSM7ndjgHuQN9lLX/Ya6/Ljhd0fZXQunMn8KP0VsKxIloA4Ha312KsRMsyaOKHFOdTOg1zRgYp2km3kwoCa4hAsCV4aX+KY5H2ciIX1eyz0MluTkyoP/DUnZXlmz6E8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681642; c=relaxed/simple;
	bh=gKg0Dw7Paitg3iXBUhHKunRE5ysCLnjUhDe/xfwXzrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAbcXHtei45eWDswxEnlyaE84wMmS69CCh7cWiebTuGxhbtYOqE20wVZ5bomKTZPrFgLAFk3IRPpcJ9Dqw54NFeVv+tk93q2V97U2Qcax1wC8uNr1TUVDGMNv/z3IdxRyKiElPTPtcThcJCCQmdAvl6h6haxS2AqWdAKsbWQgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI7RRDf5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so41395285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681639; x=1762286439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mL851umhUPJLZ6fct/l6q3TFneLb85EfFLqNrx5cTZg=;
        b=AI7RRDf5yH6zsSvodwvn/lJD2JvPZgGpoZaVyT0O/ZcWoBkp97oYatqKpn2tR4deJS
         j5GXFZFVnhV7zs1TQNthPh9hnAx5Ffw/OylAlDHCDAswvY3QT/ywImCHD6yCyAnDdrGR
         SR89afuRIgi6oaxoEr13wx7+tjn4H+bjcwGTaC5vemcBOeLSgKhp/krFjpMypXf/O3bC
         cX6eDk39yznXO7lyw4jqtdyaeTvMac9lNqdoKHaZ5N1FJO3az4r1AnYOP3G8cJB3y01B
         xMARHUUohB5D3tnHeFDStaiE8/2xOzX63WG7itOqZDDrFixdkMwd1P/SkYBGMY6wObgo
         Hp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681639; x=1762286439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL851umhUPJLZ6fct/l6q3TFneLb85EfFLqNrx5cTZg=;
        b=fLoIvVXwh8vR97p9Ug0bGQo7Eytv+opRaZlxaRAcdvH6JtEvOt3guOb8YxxmxiwULh
         XUZE1EXZqrmFbFMhKoZsc3L9iup1fPDtHgrQHWQszybgN+rtuvwlRBxY6dbOpRAJ3cNT
         PvuwEVTRSq9ycZj6TbFn1hDjvOtXVgVMj/L10bQ07BM3qw+PBjU7xK4CzrCU/ZH1OMUf
         3UroD65qdXrtysGX+Z2zLm06BcDRTPSBbqJIIFYUi4U6pVn3O1ZSYFVqpyfIsQXPT+ib
         /nXzB6oA54M+SHIUrjHQTqhWUlrKJilz08msG1VUfJeA9rg8i2PyZJPYyC4seWrxgKGX
         CCYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmaxe9CSOxXGs8Napd7AW14uhzdhkfbiGu3aKsEfhfyqzz/uHGCJ7f5n8mma9+AgOiVfBkZVZJmYGYx7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3atPMBnOyqOOJ9KQwzYOGuZZdD0Ch0sRGcs3bttaCkWd3yOLY
	g3g7CdOKr1Hw1ziDtBWvfXqGHE2ITlSYXrIK9yR//fc7Z0asXBo3Avag
X-Gm-Gg: ASbGncvdoC/gQRic2+MOFBK2Utwv8BBQAmmMVJW5Xx2VEHbNF451b2/omnpclqFoAmw
	buFhHIJ8kM72fqUzbZmIGkh2aixg8htEwYJWPYyVoJx0YMxEZYHLL/SrbxiLOS0RinXtEKDGkqx
	Q03ZDcdSuC+PMlMokR6FvBjW27pS4kI2Ojk7a6wWhTGyJnFKTwOV0reiDthQjElRP84txrSYgGt
	DtTaUhQiQhiUFLEZWr8Skz9r1TSqHjbi02+88zuHVCY2PlsUExqO01hSAd6imvI2K3kNh1jKohU
	2anfb+/2WglAYqiIe8DmWNpyaAchJiopAN1aGViTgaNJWZ9WIDMkIcnwxlM2oSVwe2J/ZPAaPYi
	M/HT2zXEFj1axVfmg3IhvCpKtl2LwkaR5vXAuW/v9U8AGxc1N0buQ+5nSKEppG489OjwjBQj/e+
	wu/2CPW3Uib8m48BmtwvB3GdKdCxxwxdquZ9A05l7Onb1a8wp6crV0WmQ9QaUhOKHh
X-Google-Smtp-Source: AGHT+IE/cBkMs1Ecb7E2+3QULB4TXzU55o3BTa1Vq4AzJPk/MOxEfEIBV9ttaFmvDXICTt90aFlWKQ==
X-Received: by 2002:a05:600c:46c3:b0:477:be4:7a52 with SMTP id 5b1f17b1804b1-4771e1f3bc7mr4985065e9.39.1761681639187;
        Tue, 28 Oct 2025 13:00:39 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:8b21:7400:1c86:bfdc:bc48:7705? ([2a02:c7c:8b21:7400:1c86:bfdc:bc48:7705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b9994sm7557365e9.16.2025.10.28.13.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:00:38 -0700 (PDT)
Message-ID: <56672794-727b-4ed2-aa73-9e976e266346@gmail.com>
Date: Tue, 28 Oct 2025 20:00:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] rust: i2c: Add basic I2C driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-i2c@vger.kernel.org
References: <508bd9a1-c75a-4d1d-bed7-ee759ac5a701@kernel.org>
 <20251026184143.280797-1-igor.korotin.linux@gmail.com>
 <4568187f-ab63-4c86-b327-90720ad20ac9@kernel.org>
 <30fbb191-5300-45e9-93d3-8b2ef5cf18ef@gmail.com>
 <DDTFXY5VJCS2.1ZB9EPNLDTPAC@kernel.org>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <DDTFXY5VJCS2.1ZB9EPNLDTPAC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Danilo

On 10/27/2025 10:00 PM, Danilo Krummrich wrote:
> In fact, quite some C drivers are already doing exactly this by hand. For
> instance, see [3]. Four lines after [3], raa215300_rtc_unregister_device() is
> registered with devm_add_action_or_reset(), which calls i2c_unregister_device().

Now that you’ve mentioned the parent device, I finally understand what 
you mean.
Originally, I started my Rust-for-Linux journey with the goal of 
rewriting one of
our platform drivers that has I2C children — and yes, it has a root 
platform_device.
For now, I’ve put that rewrite on hold and focused on the I2C part 
instead, which
is why I was thinking from the perspective of rust_driver_i2c.rs: it’s a 
purely
artificial sample driver that creates an I2C client for a non-existent 
physical
device using an I2C adapter. That’s why the puzzle didn’t fit together 
for me earlier.

> Having that said, I'm a bit curious now: What is your use-case for
> i2c:Registration?

As for my view of i2c::Registration, I see it as a safe wrapper around 
i2c_new_client_device that holds a pointer to the newly created I2C 
client and releases it automatically when dropped.

Thanks for the explanation, I'll drop a new version when ready

Best Regards
Igor

