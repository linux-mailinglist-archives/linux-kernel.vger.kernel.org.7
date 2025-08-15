Return-Path: <linux-kernel+bounces-770446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A0B27ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1948B619A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DCA23AB90;
	Fri, 15 Aug 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEjJsjXD"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFD213E7A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246077; cv=none; b=RnoRYUUbitm8A3UC2PqnNuOEDokMCnAOTSfTnWLDltQj9LUZAzr3wU3G/h+1vtgjvI0bsq5rwMzMwYac/nreGYdryWt8Ejv+9CIE5+0EhQXt6BQxcpRQT2ne3glIoxM/5UWDbbkUxiR4NXntEaV/uCOonvze7yOLgeICEkWiMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246077; c=relaxed/simple;
	bh=hSfxyTbyhJVUsktaRzvTdGGxGaUMaidseyMOAWvH21E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5/8AOm+8puWHOzCNYep0yWeKVzhkgTATQd2v2RujLLQt4ygBL7oNEsxODI/HYgQ6y0lgphtSSilgrOihFtNMlSRWt9KdbMXevU292r1pOQ66cztPSB8eDNcVBtKbUVVdmDH1X9P679lpsHucThK96dtVOvB2DG1GPNpiiRtf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEjJsjXD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so8535895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755246074; x=1755850874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcSm1OtREGPb104alZ1yzuEUCvwCzNvElhs+/6tX29M=;
        b=kEjJsjXDVSZ0XGKZIoPLMZ8Nd2o3r4RVuTUOTm35nzbBh43JW/HHonuatwlN2jTmck
         t4Pbqy9j9Uxeuni2+Z0fQG7c1OjXJNfowze/AeFN0Nn0IeHJD2iqdeAdJuGKGwI2E+N5
         zPcdKLPdDj0Mx5aZRh7lcI0aOfqEIH1AQYuPpY+/EyHUMOaoxJyTio3JjsbnXUuZ/zaF
         pnpd+hdneYid3xeZWihPFJxoCak3a02djxo4gv387dO9kBley1gdESrJjRkICwpD12lQ
         ZDQj8kpqXIynqkGbqcIFziwPR/S7Eh3w9juCNLq3526dGXouP+kyN82cBjDt5Jv22wyY
         rJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755246074; x=1755850874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcSm1OtREGPb104alZ1yzuEUCvwCzNvElhs+/6tX29M=;
        b=f/O6ouUzuBADO6lQd9+kvkg5ymzDXQnJl9JGd+vNESIZOfnnIwesfskg5/nzCAGh96
         iSrkBkqDc02WdLZ3CFaBOER+8om3gLdHMVepAiJIB6mKrIjSh3eOkLPYX3cdJFleZ0el
         FIFVCglETw186bJdowMriamzcikRHjsOiNcIse5OvIRpaC/aUk+l6vCQiE2loSpdQHnB
         ajFufIuM3LXu2FlMT0fFGxL82GiuLViCXoC7G29UY53MeGRn0W17xZGIKWJCOoDxHhDS
         g/XSa6vRmfxoYqEc2bAqEmV1DlFzpmYEoYnA3GOGGVhJhLHtcYTLS9kNryaqBCkdH3en
         P2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU8j2sq6UG1BZTWhHQOX5tQBrgQu7l9dQeJ8BVEAUGUW9KIwOe9UDdsR5JeahsBFiVTSqWdHhWnuDvAP5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+MQO6/h6QI11kQS6FUcAl8LkHfKHN7ICc+1yX/K5cbqxx00A
	JSJ4gYVO/w0ksyBnS6cipno0OasRgNNSYqRNPCH03TqwS5xKLoGjJPQrUUOn5yy/hoIAs4oJwXx
	GBvbYfZ+Oa4z5DTz+fg==
X-Google-Smtp-Source: AGHT+IFutm5xxBBsC59USuggF9xEm41gGKiB1W5K+wZvTnUgdqDAaA6QwhiqihbNCQ9esv5k56Fiq6NBFva5rrc=
X-Received: from wmbji1.prod.google.com ([2002:a05:600c:a341:b0:459:da33:b20c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524b:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-45a2183a65bmr12532315e9.19.1755246073966;
 Fri, 15 Aug 2025 01:21:13 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:21:13 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-18-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-18-581453124c15@kernel.org>
Message-ID: <aJ7t-XS2mXFc_Xc6@google.com>
Subject: Re: [PATCH v5 18/18] rnull: add soft-irq completion support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:53AM +0200, Andreas Hindborg wrote:
> rnull currently only supports direct completion. Add option for completing
> requests across CPU nodes via soft IRQ or IPI.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


