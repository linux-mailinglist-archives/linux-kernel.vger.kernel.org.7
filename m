Return-Path: <linux-kernel+bounces-750943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7754B1631C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E967A965A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD3A2DBF45;
	Wed, 30 Jul 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYSJWg1z"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181C2D8795
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886919; cv=none; b=O1qaK+JxtVsHFSMJBZpLhEjrWdo1x/wH01nyin4b3wnZUSjn9j2VQcEhThaL+yluIASGLlsaJROCTj5m2TMXaUDEBPXzY4reurBYaVs7qyWkIOeJUCznlv/C95TcZyiYICX/BJMjp9kXKzsyNWPyJo/N3U4yXT6Oh0/vHl2rqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886919; c=relaxed/simple;
	bh=4mghgj0xXZRMOa8OQQTs0VAQ/GrOCZpAVNjw5jYHVBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlqgvlLK7WTlmd5A7+Q2vzzNAeM5I0ZI48jJ1vAVsM6m2WqIw5SA8ZGmI0lx+R/HAAjQZI6OInA9hMTi15ScA72FEOfwFzMRE8LgobVLqkQsymMnZef81bVcOXUd7XUEN7Q710XhkWmluL8zUNmvJN31w/IBzhcJFHKJ1hnM23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYSJWg1z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3f7404710aso888203a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753886918; x=1754491718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eK8YzK7uzNlS0kJpPPbP/f3p/NVOP3trKsIT7CAtwKM=;
        b=fYSJWg1z3upgR7mX58kGIWzE/MkbHsQvSCtqF3eCG7lyVcEp5t4yBujU+hiyvNqxqJ
         0yWSiR3h2/pcid4FTsNW3IwonfspKXoDkelAL8E9UV+GWjwxZTtCHdolKm3D9wkwSGoM
         nqn0Fg12Jwe1HieChZWaP5BhPL9WuWpkOfs6Va72C4DOoKNP8PJI9b00DM4jC3PyuYyg
         eYuLPXCj1e9jfHHnCJRQR8l7u3TVvRCQmhr5N4SyUFx+Tky194a0ihc9vuzWs8edyhhw
         FuNFPlpmCsQbIIcj4cfbonQbZv0XU0W60l5pWZTsKfieE7/NgN39HtQWvn4pJN5tIEbS
         e4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753886918; x=1754491718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eK8YzK7uzNlS0kJpPPbP/f3p/NVOP3trKsIT7CAtwKM=;
        b=k6qpz0CjBOCD3Zff8HhjpdBm/lj9ehMLqOW9t+bC5lCMWE1r3Sqk4zV/0SkKF5cuAV
         mpsl0XlrCDsMsK4MQ29Hsa9LUdHMmYwUT/1zppcqxPq3454xS92uw9NX4rDhW8zL5/JA
         dJJKiSQNZSjaH8j4pq1iDwd1G0vBSIwOrX5VEcif0es+cCoRuL2UO74Q5HeD1FKdViRJ
         G4FeIVnJt2qapV+0ANyZYU2T/QbbQuIyicwe0xbdAuNX+IM3cL02AQxpAO4KQTD7x28l
         ir+vF7EzYkLVuu1lRzNE0VpnO5yTNoXipOzZuSXVzQCuaC0qLi/muVQM2Npc3yvlv51N
         8LeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM5UbF8IJYheMw/vDWz8JhYpjm5JBCggp6pI36NhaUSiwg3I6uzI3UKpUtjeaVjsXK42b+OD3vklj05PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyMz7G3ksh7rjoXb7Zbnz1JxXzblQYgxR+zzZOf27iQfswU5x
	ZmLuLzgaSdIAnNhnR6k9D7DtVV9lkhCd60O9+4pzhYLNJii+qksVMCh3CJ+oEl/feEQ=
X-Gm-Gg: ASbGnctJxKrgyKLlMZIEsX2LBADZb5AtKgAyaOROemZgPjdQWHrXm2h5ZTbIQO7yeGq
	IeO9+fSX0HD27CtxQ/I9k8jJVgYxlYOPz7kGvL0+YmaTKN37w1vXb/RxEdAnIUY4XX/nS/ccyP0
	0yF9rpiyoY6/+mMyBf1Q1uCHh/Pxx7/W5u8Izgu8HDrm0ADW7AbWHiuqafn3SitmwdyrXdnghZB
	MHqlopVNOMjXIWHNvStSxD09E6VUB6CBq5sEQ6Z+ThdxWwTScpmnz6jOPiH0kkXlUeZMcpPWJjj
	PUB59q7uQ3lsmS5O/coxxFbigsUswAsKjQsgG9rOKnGhGv/iPDb0mPxd/Kepvrc7UkGnXkOaDIX
	WmFiMBptLt9sY/nbTxCSuBJw=
X-Google-Smtp-Source: AGHT+IHmCtoI/bWhXT2CXJZ8Yc/kzIn37kaOEzx4dcyEFnc73WRQhsLOgyrX+5HPgOGkzvXZtaUfVA==
X-Received: by 2002:a17:90b:35d1:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31f5dd891dcmr4980616a91.2.1753886917853;
        Wed, 30 Jul 2025 07:48:37 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cb39sm2209790a91.30.2025.07.30.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:48:37 -0700 (PDT)
Date: Wed, 30 Jul 2025 20:18:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] rust: clk: use the type-state pattern
Message-ID: <20250730144834.63pnrsoyrmrkjfrw@vireshk-i7>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <20250730062355.bqifrzvxfmaaugnk@vireshk-i7>
 <9746F6D6-488C-4562-8FB1-BE268C69BA97@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9746F6D6-488C-4562-8FB1-BE268C69BA97@collabora.com>

On 30-07-25, 09:27, Daniel Almeida wrote:
> What’s the issue with clk_prepare? You mean that the parenthesis are missing?

Yes.

-- 
viresh

