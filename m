Return-Path: <linux-kernel+bounces-800351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B7B436AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E0D5A09CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37E2DFA5C;
	Thu,  4 Sep 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ceca3pwi"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E52D12ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976935; cv=none; b=XZrIWofjA9S1jjPJaRzCwL7x6ylhCe8OBmQkGaw5inR6knUGcMuzAf7AcWlgfdamzsYjUyuHltCGphQxeS/PWSlz7Jbh0K8aa/inLYIVJC+/4xVdbLLwvpWgrG1cXje8sRn8Pral6Rfy02rSh+MgrMc+0+4keZQxraZyiWZXHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976935; c=relaxed/simple;
	bh=9OuwB/mKcO6haey57JJkqXea6iJb0zgcty8aAKBWe5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiqi9rNcTDeib1qWrBa3DCMc0/3jweBxrO4OBLy7aqVCR5dd5W8gS9cpWVTL9mVJqEraGuEdCjs0l1lSxofyrZvDNqODse4wM92DTFgzzoyjzve4DaXQPz80lCgVa1IJ7tA7VqJhgU37LwXj0PCPJEqdFKr7cFIWzsW5u/hAunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ceca3pwi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso611437b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756976932; x=1757581732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmBbjONRTs6bzm6TRjxemHxdhBeOSzGNBuBX1gDxW0c=;
        b=Ceca3pwiSSggVuowWec1JaLEyCaRIHEEeuEXh/Pg2vqE4eeee5PYsZ+7FpTWtLbdhj
         b4fSSdlxnHgsOgH0tE4QoRCkkGqnV8SE5M0FsiiPVT59UJZ1++fNuZk20zJPCpBdGnsR
         bpoIUhJsiAOj7N0+5yRiIsQOKPKmMd/wVrADJu5SOAWagOrdk6vbjacvbxuc3sXT4oVw
         zFBGDbt0SKUAyXznewucg5kpr1wGY5ascZUvXoNkaSBuaeaPLSDfGckGKi+g9W59H+W2
         Xcn+nidUd00WcL37TCqzcWFEEUFK96Pv2bIHPNTXA0qI0c0dkaHNtr8W9gP24zxFye5r
         2veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976932; x=1757581732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmBbjONRTs6bzm6TRjxemHxdhBeOSzGNBuBX1gDxW0c=;
        b=sCTkv2vw56Wfzt3W9s675z5GGHotg78f4Z6lNmQlgD/rrientK9nzgFxtKG6myskaZ
         QBP2f+JmyBF0wirruzN9em2KSXkynOHOzAe5+8dsZyN6esZTNq0beoIlrEe89HKCDRJG
         Fw9HIrhAJv4BhLl+6uKTyEoCk52JsBmkimhsgreFfHMf9K6l/DMP7+voi/wrL8AGJTKQ
         DU34VfDyGyGTqwoXLW0OoYb+oH5RRQDk1I5xZREJ5sfFHBcMLxsBs7/tMuQ04wRd3Rrz
         Zfd49yjLiPfGbWYspi2BouVmZlasGkd39B1lG/UTGO5rvZ3rpW3jwrs3/A1YNUReFbmD
         Lk+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9hMW2MFX6GVL7IrwXYRfX85kWKqcOaA6qC05WyCSJTpIWseNjq3EDASv4nOEd7mvLuV8aDjirlLjqobo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZQCn0mkGOhCAWx/FnpvVczvvzI5/7Uh6eZmR6ADW+dAdg2Kr
	jsglur5lGnmA0YRGOBhCf5F7GgtMhpRFdv+6n4ioC4u0tRvEMa2OmsrE1NZhz2ITaNM=
X-Gm-Gg: ASbGnctJKs7akHDLPeE9tBCDurK3w0QkByvfDTpbYdd9WM7cF9S3vwYjZxSvONTxSkR
	fwaF0r9KM//Lx9j3JTCor9n5lt8oekyqtNDtgxfjgZb4v9RbY18YzSzczvvHRR5pQY+klLmY/Fk
	BVZTSt95cmRgBNGEqKLjX6VfJcPJI7/pNtIy9b/TK60S4jhRWbwaBiRnyb9DiEeuvQRnX/m7hmV
	6LlS2hC2dtstpf67xZhC+rN9ixm25SJ9nHU2OQpyeawW4YtXGZ2cEz6lUgg3YvphaJpb/uof9aw
	wnBmhUOQmnNxNBYQ5XwQFfUkBNb8gJHErUB/26W2WGgx2pLK/j23lixHi7nRLKQMqa2daVQpKAw
	42/USB2wn9jyhhkJ6RXl0l7H6ujkJMa6iDSk=
X-Google-Smtp-Source: AGHT+IHI7lc2wZNpnK6c7bml3S96KONYzvjvTqV1qrfL3bzvd/FiM6GZPsewH6KTBQYgX9g7o654HA==
X-Received: by 2002:a05:6a20:3d86:b0:243:a189:f1f8 with SMTP id adf61e73a8af0-243d6ddb3bdmr27908154637.8.1756976931899;
        Thu, 04 Sep 2025 02:08:51 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0736ba7sm16257509a12.12.2025.09.04.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:08:51 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:38:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: clk: implement Send and Sync
Message-ID: <20250904090849.7uiroafxk5juml6b@vireshk-i7>
References: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>

On 04-09-25, 09:03, Alice Ryhl wrote:
> These traits are required for drivers to embed the Clk type in their own
> data structures because driver data structures are usually required to
> be Send. See e.g. [1] for the kind of workaround that drivers currently
> need due to lacking this annotation.
> 
> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@collabora.com/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> I'm not sure if there was already sent a patch for this. I recall
> being told that one had been sent, but I could not find it. Maybe I
> mixed it up with the regulator change, so now I'm sending a change for
> clk.
> ---
>  rust/kernel/clk.rs | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

