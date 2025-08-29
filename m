Return-Path: <linux-kernel+bounces-791377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF3B3B61E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56D93BB062
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86228750C;
	Fri, 29 Aug 2025 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+Ut5M+m"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83B285CBB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456721; cv=none; b=Ow7cc0j1ZGd3fH7tGujaOQj4SJ7bFGj5qUTXmiFbdwOXC76NrVWFFM8wvvPX0e5Cfb6p1t7W0ILFTGnHFXH25Ucah/RtJXmm9kDk0Ylf4wLhVjFw3/tQ93qmm/JKT+sWJC0bYXqisbI9WHZE42M2GrOtEwkxBCqcSdDyDdu7lDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456721; c=relaxed/simple;
	bh=DoZZZwXXukmJKKuQW8NJX48QJGI/+KS2syWR4iA4d2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3bY/q6VqO06Sx9FEiJtqQEX+rpuA+6p8erEh6ZCtOnB5kmenYJHeFlbqM7tsHsIP9cS6MlYNrqAjuEHK1exWEf3Sjyj7VrrIDd0S/tkVtycwlv4r8KU1wr6Aeq4sCZCh7WdjOXXn81g8znom3d6/3n44XWCYf27yx5Xs3sKI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+Ut5M+m; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so9319935e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756456718; x=1757061518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jjWn/JLKRwrg9AnRIkp554v48bzaMLTS/B7CQiq9I0=;
        b=u+Ut5M+m8dvzUBPl74pg2f23+VXEss9liOi2Ya7sX/ofQY4c+n4xwUwxajxqqLZ7qZ
         XX/MFiyym20LVsrBOqxZKpqlaUXjIS7U/Uh6kQdUgFqbGFZsc9DN17tqW40PTNyCHwLr
         VMLmn3lz2oc+8yd34kqV/qn/poX0/XckY4WCUdotDJa+dg3xikm/4xKFfMVbhWgBfw+1
         W5z0xAARFoyyd/tHOWiPooWK3GQ09VSiBuOv6Ar5oxo96iEIDRJttcziL+nyx1lN88jo
         heedtUgNX6Twl0fLgEArsL7f4RR/dQ5MjM288Y5YZwjAyB3WFKXlnOuQvKL5KyJOHEBY
         Niig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756456718; x=1757061518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jjWn/JLKRwrg9AnRIkp554v48bzaMLTS/B7CQiq9I0=;
        b=DUzYDr5nso+WHUBxmYj88FPwZhPCuTUMwaNDQffoqu7psL4ksoByHcJ+Z2oYndInRZ
         83ZwNmKdKN1DXeh+vkk7txQzYdCz0eHADFvryFrNwT7NsyG26+wjDLftH3aB3EgrdwAT
         iDm/HCdWqphCx0hslcJmSb9T3abDUrqZLMh70/VRdABD30pFoSbaR8jOOo36YlGbnXGJ
         ddhoWNZYXEJnVFe64rZ5fsAs7r6vcw99BzcntXPCFDRqZvUTi2MJ2QcU6JVNfDgiEz7I
         pM4u7XrjhRSxw/lVJ0YQNjdUegx9W1eU2a3RBed3OjUsQ2Lsoz0zpaWF6jOnrFNT9zjb
         Ny0A==
X-Forwarded-Encrypted: i=1; AJvYcCWOM+1BBlOiNbZMdR7hihKEmgZU/GUTM7MwO2XAHh9uvcFfLlltq6tCQW3DOqv0qeFBUlt93LOfz+ozgGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywscm+KgSUioJzwPSEN2nQTdzllIjR0023WSM8UJUlFUt6lAg+/
	I++LKB40fNpi29rKSV5+x0875YgmaGC1M+9FKkwuezVM626VDyCI1cVkSWWGRkeqndmxwrvKCk4
	ath0jPFSa8HYZN/GJog==
X-Google-Smtp-Source: AGHT+IGoiD70A1jH27tST4mNKlIuDTGR/gRna+ZZ4e5bwH4zAAv1pz4WMFOCfptcMxWHYNR80vnn5uw6FjfitXk=
X-Received: from wmbee21.prod.google.com ([2002:a05:600c:6415:b0:459:d6d6:554d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444c:b0:45b:804a:a65e with SMTP id 5b1f17b1804b1-45b804aa8a6mr10568295e9.28.1756456718610;
 Fri, 29 Aug 2025 01:38:38 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:38:37 +0000
In-Reply-To: <cover.1755235180.git.y.j3ms.n@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com>
Message-ID: <aLFnDWwNh1MgBBGw@google.com>
Subject: Re: [PATCH v2 0/5] rust: add `TryFrom` and `Into` derive macros
From: Alice Ryhl <aliceryhl@google.com>
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 05:32:10AM +0000, Jesung Yang wrote:
> This patch series introduces derive macros for `TryFrom` and `Into`
> traits.
> 
> A few enhancements were made to the custom `quote!()` macro to write
> the derive macro. These include support for additional punctuation
> tokens and a fix for an unused variable warning when quoting simple
> forms. Detailed information about these enhancements is provided in the
> relevant patches.
> 
> This series builds on the previous work [1], where the `FromPrimitive`
> trait was considered too heavy for the current use cases. In response
> to the emerging need for functionality similar to `ToPrimitive`, this
> series also implements the `Into` derive macro.
> 
> The original discussion can be found on Zulip [2].
> 
> [1] https://lore.kernel.org/rust-for-linux/cover.1750689857.git.y.j3ms.n@gmail.com/
> [2] https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/524335626

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

