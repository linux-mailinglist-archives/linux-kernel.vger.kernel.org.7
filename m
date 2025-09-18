Return-Path: <linux-kernel+bounces-766114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C377B24276
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D535156530E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB692DCF55;
	Wed, 13 Aug 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbipfT0Q"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3521FF46
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069487; cv=none; b=bCoSxsbGeOWzQXok5a58uJgmOaRmIyJYf42M0z27dqxxlkMHzOooHZRmRlFmUW3/w1I6uLSZ96g0G3kdpjgPRxp3ggp1n2+if8VFJJxOFCyfkzfvF27r/7Vs4MbxILK8xQoscO7NaR4hbZjIviXRE0lwA6NzJ8xKQ1b+tUHiNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069487; c=relaxed/simple;
	bh=sPWPCpPwShzFiMT6CKlCXRbcuSDh5ua57E9eE9f66x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZBFbk2vwIBVeKBz47Clr3cQ60l75zciJR3Zxwcb6fWIimeFpKFyXUv9lL12+QT9RrZM22LTeAiq3gyoTyYIA3dt8hYFCOithROTsCrYCr9gnPjxlxPOWFtIbtaF5LX4JHUFaCt2jL8PF1G4LE67pzRFQ1w6So5A3Y40cGnrPYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbipfT0Q; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b788e2581bso2979615f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755069484; x=1755674284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzwpjQYxEeh146hCNuF74/A9Awy7IkKcC2sZoitYFXY=;
        b=bbipfT0QRMoyHXIAdg+gd9Lds5zGi05nUUt7uAzLIaV9D3OHLYWle2/uBLaoHnGlk/
         6XKOknYCBszvL/1M5cHGU4ZpVAEG/khjdmN3OGI158+0rtGzovmYogGMSqDtjfnfEs+t
         y127uxWdQOdBwMTx7k0aznKSY0H3XOXjTiJPhKGf/8GsJoHYjk8OOGOEB5dwK7mR06Y6
         OaM/Xd9Wej5tg3XnzgQ8TQkyfK5zj0RzWLObTd9YtybfKNXbxM8PaUOFr3gtKs9ulcaO
         hOehA1fRES/axMFglhzOuTKQUZMB5+TkIaV5ioQ1vY0TZoawujgMu9lPazT9HQ0m+ZZj
         xGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069484; x=1755674284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzwpjQYxEeh146hCNuF74/A9Awy7IkKcC2sZoitYFXY=;
        b=o7BvkC2RadT4PzGzOVUdZhwV00tdsAO7o9z0kzsLBDan6UE7ayNMyeBvWd78higROa
         8zwNEIu6TyvG9CNCLqjzU2YAWEC3qa2seYRHzOTdm+C2x5lQ289w9Fm8NPkEcpeoZrvp
         S05RXOeyJpx6YucKMZbyP5vAvl9vaL1lGotBGDGR4YC+igtuF3BfcXNy1j+YUW3YuGnC
         nNGaMCOIdHn02YlOZNsv+AWUGvSLes+sT/2lf4F8pDGZLNRkcPjj1H4Zpm6GfapPDwna
         iVo1UhlNeB+2lN4M8e3OJDQGNHNTmxIunZYL9yoC3R1vEV6GSN4aMnmqEyzZIOnbL2Mz
         TgTw==
X-Forwarded-Encrypted: i=1; AJvYcCUxb+jCvxa1tpQxoIgE8DvnA5SS6ws702mcoer3KtRjHPMsfmr9EpEDWvB6vxhmIOOGdcOTKSGI83dTdwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwryAWyoWHFa0seUBldePkXATPjcq01pGr5D/wxwme9oGIDIwKG
	Zm0hxtAI0o1FWb8lVbF9mwtnHhzFMoZnOPysWnlwMgJ9xT6w+1UYKynRqzoSicW0jyoFR1kBbAT
	RBldhGjTaljD6zVgS4Q==
X-Google-Smtp-Source: AGHT+IFYBSCuYTUdmry4oLbAzZ+PQAZNZZrLb+T/c83Ca2zlX+gpWOhZSckyieIV2C06E1FjAI/637OzgaaH4Oo=
X-Received: from wmbek12.prod.google.com ([2002:a05:600c:3ecc:b0:459:df6f:4ef2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4305:b0:3b7:7cb3:1124 with SMTP id ffacd0b85a97d-3b917d2af6dmr1509508f8f.11.1755069483927;
 Wed, 13 Aug 2025 00:18:03 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:18:02 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-2-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-2-ed801dd3ba5c@kernel.org>
Message-ID: <aJw8KiOJfrGAVVBD@google.com>
Subject: Re: [PATCH v4 02/15] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:20AM +0200, Andreas Hindborg wrote:
> Improve `Formatter` so that it can write to an array or slice buffer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

