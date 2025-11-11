Return-Path: <linux-kernel+bounces-896284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E270C50071
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8C24EEA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F862F260C;
	Tue, 11 Nov 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0ZuW6pj"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3F2D0292
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901752; cv=none; b=doSN7NiOZzuI1M6oUBf/WaGRiNh+gof1opfpxc2S60IWmNjhKQ2SC0CFqanCb/Fx/gvxd6Uyp15WQLWKj5dhAgJzz74o72Yn+GuWT1OF9XJBDmIfSEhXQWSWE3Vohl8bYLV2yij8Z2uNqCTWdyw58N/QY9XDLKIK3vu+dW3T7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901752; c=relaxed/simple;
	bh=no6awPYlNWD2ZDTvcdrXtI2J2BOWdlGtNS+ynn3kOI8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=loLqoF6QjFThg/I3eSdm2QOkbnq4fGAjMUi2vIMqmniBqh3Gy9jEMY4k9EB+JSh1p5z84+8vtuUWWYDGx1n52DqKK3DQMfcUwlA2mUfPTjdNDZ6EN7+0A3oZtR4TUXMokaMHj8ldmscj16TpgTL9W4RfR11lYKVrvU/uOCntXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0ZuW6pj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so254610a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762901750; x=1763506550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WV8SpjyToHnox8eW+EUZvNmanBSrZ2+/14Ld9cc4nK4=;
        b=O0ZuW6pjtdjLnJdOtcZ8Nh7lLY6eApabOp/rqBpf0rzuyPrQarGOjciEx0T/T4vWzW
         PnAWOMuIEBR+Q52aPh0nc26J7M0Y2WkCEKi1ZCOBlyCkLj26fiNzlcOFhJaPYtHnsmA9
         DLHQsr4ddq/bTHqSRVFC6663AaOYEZaAMlluRHlRyPr1ii+ebKNUyxPFdfa1kceVZl7H
         FsT5HISWcVLRCljY/0dbEO/kqIwITHikuBUBVtC+/t/vtHbNHEyAbDSrn6oEru62216+
         j/1ImsnLZDyGuIgyGuKwvgSqs6bUE1CDgOzLhQJbQHRF9yF4+tZpZF/aFPIdmkGEz42h
         w4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762901750; x=1763506550;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV8SpjyToHnox8eW+EUZvNmanBSrZ2+/14Ld9cc4nK4=;
        b=jJZ+kkVOUhUzsSNJf/5FzEgudU2GeZl6rcEJETU79zAeBBV14U6MQJHZamF0B6fraC
         aLG0bJmIwlRCokUKMAyqEbkRSUIydM70aVvuRzt+/kp+wWb825UYexEcdBeGHpmli8pS
         kku6bH/epLQCyvqW43ztLxm//jnOGeOmMsIy/UZMHrAJ0W6kjX3TZ2jjdCLuWNBzUjFS
         /DpaUkEr+SWXcMQsNcnkNOAR58m3Od3zC8zrPCg2oK0seRgdeaDitUf8LvKlyV2cWtmc
         EmyjolyuXfNvGDtHAXCWxk8BZrBwmkKV1aWNaJU8RaS1vWajaxZBzBFjtVcvSYgwGW5S
         RKMA==
X-Forwarded-Encrypted: i=1; AJvYcCWGPITIZDqtSrdh3Ub6jmWZHvE8MkHsY8y9IaZx3cl1kP8+ahtVTygKOA7XFAPUHeAj9ANYJEzGrViGzSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/B2hVhbK678+TXfOWRBubZa39r0lZGYhz48FI+LPvO2x9o3F
	SlM9SVGNtr9QaMmFG/YFk1cbeHePlhw01u4TO6IrGNQoMXuHgibVIkD+
X-Gm-Gg: ASbGncuS1AWv7IOmKxTRfxK7m+iNaZLGenKSa+w9UPvvaMN7UTpx8MhgO2bWZ6lJpZ0
	48/VaOd/HQ4KB/LaucAPms5N5zBcOaGq8acIMHLpRnBWBEm8dKURBlRQJ+pHLK6jgDAJZLPD5T+
	AlyJGJeEFSkuoJryqbTemQzLL5zUA/pJqekImGs5hS6g4yU9sv2O79H83wR/Y/R7ZI9UycXc5Od
	RN9kNFt5J9y+LQ2XCcGfBy/QAZJb9mZFAOxuBAORrj7SnQ0S3TsPscFT/GnJhNjw/Z5rxYMjCsp
	LvdQl8xfoF4GciSU50+RNT/rGpgzskb4K+HMoQHMMQY1e/CPuPAhdPevXKEV7xB+RPvjdYJZ5Rg
	wyl9Xe6fapPgKIBCGqem69yNyKNe4yl1R7vqN4lXtY1kjdjQLiTl8Ozb0dhkoO9On9KI9UNJSCI
	15g471ukpWU3JVgAYZnB3IPyFv7bTTQafZ+2kd0aJitLPANwbYVD/S8ER5HKNqQg+B9SPKQ9Ub3
	3E=
X-Google-Smtp-Source: AGHT+IF4OnkRMbd6m4HrTuqN+m+jnjr3E5I1/MHuhkYwY6fxfKQpu9u5zArrBIuDS/wyoE+OqOffGw==
X-Received: by 2002:a17:90b:1b0c:b0:343:7714:4c9e with SMTP id 98e67ed59e1d1-343dddeef91mr1097421a91.2.1762901749896;
        Tue, 11 Nov 2025 14:55:49 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07156absm214042a91.5.2025.11.11.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 14:55:49 -0800 (PST)
Date: Wed, 12 Nov 2025 07:55:34 +0900 (JST)
Message-Id: <20251112.075534.1069241481796218298.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 tmgross@umich.edu, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 guillaume1.gomez@gmail.com
Subject: Re: [PATCH 2/3] rust: net: phy: make example buildable
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=_KAgUZ9u5YY-iw7kyA9R1Nv6eNzZqMLSwOLQk6sR7kw@mail.gmail.com>
References: <20251110122223.1677654-2-ojeda@kernel.org>
	<20251111.083413.2270464617525340597.fujita.tomonori@gmail.com>
	<CANiq72=_KAgUZ9u5YY-iw7kyA9R1Nv6eNzZqMLSwOLQk6sR7kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 22:02:26 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> I think that some code begin lines with # for use lines in a "#
>> Examples" section, while others do not. Which style is recommended?
> 
> There is no hard rule for all cases -- we typically hide things that
> are not important for the example (e.g. fake `mod bindings` that are
> used to support the example but aren't important and would bloat the
> example or confuse the reader).
> 
> For imports, some people prefer to see them, others don't. Here, for
> instance, it may be interesting to show the paths (e.g. that the
> `Device` is a `net::phy::` one, or where `C22` is coming from), so we
> could unhide it. So up to you!
> 
> So I think the rule is really: if it is something that we think people
> should see to actually understand the example, then we should show it.
> 
> And if it is something that would confuse them more than help, or that
> generally should not be used in real code (like the fake bindings),
> then we should hide it.

Understood, thanks!

Then I don't think that the imports in this example are important so
please add:

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


