Return-Path: <linux-kernel+bounces-792720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8694B3C80C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7841C810E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9C25742F;
	Sat, 30 Aug 2025 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKw2+t1l"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657821930B;
	Sat, 30 Aug 2025 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756530066; cv=none; b=LB/9M3lYa4yWUsocqUwR8a7+pnZgylGBGWNED1Iq7yapl8cQqx2BkAci6bySozd9v2mAXjXaDFXUED8EHkUofGTiscScwJcNG7kt5exrYmqjfRF+emkJdjbzBx7sma0uwTMOpmViOKbO6OJps/cIe4kC6UI3nbiBSAemX7OPxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756530066; c=relaxed/simple;
	bh=jCSIwnw7Mtdqfy9iiPYuutB28MNMakSjx+eOQYX9Xp8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=YaMoZ7qaw6mMLBmtxRD8lcWuW41W1ulX1QaexYPhzbKvQWtwZMu+b7uniGccDU0H3XHTsMoxxXF+mz11rgR2ThXLuYZdNyH9SR7qblrX2E7BE9nxGese+7c5VLFVd8fsQTBnVF/nbOSseFWYOe5JHRFgG6PROEwCLRlJGoWbFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKw2+t1l; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96f401c478so2480943276.3;
        Fri, 29 Aug 2025 22:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756530064; x=1757134864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySHz07CCI/3xmGOniCbCder4okJxP/0F9QnnzMAcm8o=;
        b=HKw2+t1l8FS1qA9C8axI3GYOc0SkjeOAS7TsAr1IkQd4TLRFXXQ5aay+GH4eJMeUKx
         hTMztHiopZ8HBHMXyqjX6i7R1Ct0e1ru/w+qO3Ej79wSXXwPVMLdBOlnWYZMbjCjNBYV
         R0P/oc9/2OmVqXtEjzCQmKu5OBvBe0CZvQMHuuLbyksaZ0ddyvQ3J81PxBUs+odRxh3M
         dJqJXhW32INiL4DsILzxBGraC4z2VzMWyD6s0iXIuiTlY+OcvpQNYgeAA4IB5vi0ybXT
         1YC1W3gkS765bn7d/N8iiHqxdSa6WwsmeCrdeSgr+V33NkQb81oPk68ux/OJ8LoID9iT
         9MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756530064; x=1757134864;
        h=content-transfer-encoding:cc:to:subject:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySHz07CCI/3xmGOniCbCder4okJxP/0F9QnnzMAcm8o=;
        b=kjbuwKczDlEI1Qz7pMBQv80dLDItb7Rt8L6dPRPA5S6h6ZADfktl6+Cyl/RxRl+v7b
         d3c2IAFI5McIMFJv3hDlE5WJylvzNnBrI42ds3IVfuMWHDr524DW/JTWCnAdVcnZODH+
         bI0W8avFL+VXvv6jntKutJXeOEgVyfRZParEAQI4m03Qs+KDN/04t5Wk7xYZXy+i1YbS
         VfO1ZARA921eGPNgtJDxgrpo662XzJDk/ZMsYiSuBjBewoMZKM1qT40wnR6Npkcm9s3U
         XdLg++YrH4GM4Nf7DNsr6Y3QvjkXXRWXqw5qdreB9ei/BvadlDCJopMt+Cr54NywSz33
         Kb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVUn/uUP4iFs4Ev63Ya956sMCFrTpNfo6NVHh7ueoJp6m/XBTWpl4IGqTZs3MQ7m32L/V6LaMheng6XP6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTJxKzNdZdc6pH9zYpcBGyoZWgewlBXdC+Q5/MC9405GKqAZq
	fTLwIlbHhA/QOjC9M46oS4014YwfpmOq52yz3LVznRHjahnSVdfBmCEu
X-Gm-Gg: ASbGncueeErEkEB+8h0Y9kAWn/6Me2N8PRqljtzUPSeDeQTxh3l92rKufYT9jRpTrZ/
	tgJZNZwzvmtWRak7jGvMRGoBMMl2+EJTJNALSLgpdgfbbDCpK3LHgc2/yJ/r6Jo0f3Bhg4s/HQX
	Mem320H9Q7R9GRKcR28fTPIu5v+lhCTI9VqzyOzvWdQWQi+t5twLQQvvT95T8JykyO951YQXmxi
	RsCbmKG+Ihywjox4QtFBupDEZIaykEp9srgqNax/j8fK4UvywID3NdKay5UUpKbMDKmUPsClDXP
	MuAbi/B16UbmGIqbPho8SGoah54D1ZIzvERcq66zyTgyw53DjIvD+2hWMHwZvO8BzDUVEwBEwzw
	BrZyGjtBfH3ofbnEGPs0TLJ5ic2elsWKt7RjGQ0KDIcaBz8+rJnCh
X-Google-Smtp-Source: AGHT+IFTNCicmUzh9ebhvvZRtbgT7yLvuWDKeZxk+wFYkuzGpT8P77jekfRYhnpiqL+NMc4r/32rgw==
X-Received: by 2002:a05:690c:6004:b0:71f:db79:994d with SMTP id 00721157ae682-722763d887dmr11241957b3.19.1756530063292;
        Fri, 29 Aug 2025 22:01:03 -0700 (PDT)
Received: from [192.168.1.209] (74.211.99.176.16clouds.com. [74.211.99.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721c634bb52sm11989857b3.19.2025.08.29.22.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 22:01:02 -0700 (PDT)
From: Asuna Yang <spriteovo@gmail.com>
X-Google-Original-From: Asuna Yang <SpriteOvO@gmail.com>
Message-ID: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>
Date: Sat, 30 Aug 2025 13:00:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Subject: RISC-V: Re-enable GCC+Rust builds
To: Conor Dooley <conor@kernel.org>, Jason Montleon <jmontleo@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Asuna Yang <SpriteOvO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I noticed that GCC+Rust builds for RISC-V were disabled about a year 
ago, as discussed in
https://lore.kernel.org/all/20240917000848.720765-1-jmontleo@redhat.com/

I'm a bit lost here. What are the main obstacles to re-enabling GCC 
builds now?

Conor said:
 > Okay. Short term then is deny gcc + rust, longer term is allow it 
with the same caveats as the aforementioned mixed stuff.
"the same caveats" means detecting what specifically?

We have a RISC-V PWM driver being written in Rust. Currently, GCC being 
disabled for building the kernel with Rust for RISC-V is the primary 
blocker for including these drivers in RISC-V distros. Therefore, I'd 
like to push forward and contribute to the re-enabling of GCC builds. Is 
there a more detailed direction on what I can do here?

Thanks.

