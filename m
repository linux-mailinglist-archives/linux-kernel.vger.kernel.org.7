Return-Path: <linux-kernel+bounces-723710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467EAFEA30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49BC5C0C59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4C2E041F;
	Wed,  9 Jul 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGHJiTTK"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49E2DFA2D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067555; cv=none; b=SHgRw9nK2C11fCUPwOumzub+9aecpUXNduld5UcbCVBiTbclwZICvdj6bKQ08ZuqRRLiaFstSiIA8q9TCTrB/bAkMIROBJiRZPMHiQgPJbwH5wR/8xyazk42Ulvru737LoMF8O4FCLZ09O8Yzwf2nClzOZPQ+dSJI8uzPgTRrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067555; c=relaxed/simple;
	bh=+CycetGzVdLehehI9aYmJXxbJo98lkIOECW6qGyf0jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TS9zwiECNygZJ0XIXj2O6e0cGK8g1a3kvKTuSDRmgKHY/lQLZP91s5SVPH4aBoNf+ohlk8uHkjP8S3VkVRvcNifRTP68R4SCvCaFe6ccC61rwqqcyE+04V0m1/i9AfdrZo21Hi0HjKEZDcQh5+7Lob4QnR8pNcJpACWUuiXaUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGHJiTTK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so41412235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067552; x=1752672352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nudfe3LMBXnEpFO20d+2xerOJ+RoR8Nz6J4cQJSJYIM=;
        b=NGHJiTTKm4HgpFV/QLIyL/NuhIzHZEp1V+oDyBaIwYxsX2LEn2BjMA2PALZ6r02t7E
         aRfsBC/1Z0dN6cIamcsWk6Rn5vsr3PJSXTWKCFu749l4IbE+IzKSF1twe7ePAQE9ySix
         HkMJoM8VHIUIeJQuGLgd2q9q2RADed6RHk2mwszu1Ms2ORDAh2NomMataeoOGZJcLviv
         fk8wKhc+Qa00q3xGcbmWCVmngAZD8snf2BgnC20kofzbS9NAAXaszVqs/Xvfo56nP1cn
         EwQuZDe3+StPT4vItlkYZRJMkpxrEZiETmb7iSt4T5a2iV2G5GQ1VFoWXishq80ZwMRi
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067552; x=1752672352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nudfe3LMBXnEpFO20d+2xerOJ+RoR8Nz6J4cQJSJYIM=;
        b=fcFDO4Tz6sW7Z7wwUYCVNS0KqeAElqVhGp7PLXJLeIUvnK10WEzwboh9+adqzME5xb
         B3HBJfgM/eNuEdE3L0snh3lf/8i3CiroIy3RQsyCsCYFLnQ84Gxo2GV/z61CEn73hcqO
         Mcyjx7tLtuMlXsnLMjjQuylBtAVHOkKScU8dGilImHUGzhA2gqLSlyd1TSajJ8xwyxkk
         2PQc8XQwi2mch2Nvp6xR3jtbrdweDIyqnHKc1mDZtJ5T6z9wcouFanXQRTA+w4U54sTi
         EYCSKW+vloa3HLNTRaptTiZVILj82ByUWWcn/HrTtwGK/HfI+sAdOddgJ0QdFJHu9SZ8
         oUgg==
X-Forwarded-Encrypted: i=1; AJvYcCU9x/fr6hZIPJOObjcyDhnH2hqxJIsxmfSpvtghlLviOUxdn0TMno9BGCYygho87JoYTWNHGlZ1BeLR0Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPi97ZcF/Kc8G/31AzuFMbJDM0/RsZq3QfLlVbyTNPiNrrlmt
	5hG25TZJyjvfAWC+EzW/YbP0Pt4AiDSIgqzmTxX4TSbSmzYLxgiTITMRQp+u34SxRbWJgAw9DDC
	2Pz7rSU8N/Kr4xkpYdQ==
X-Google-Smtp-Source: AGHT+IFjwCUuKBGi7YyW0JD/w1lRwcEiAg/jl3/NNA/iOBJCWKQvZrB1uhsRLAuO5rCYZyR58odRAH51V3vaEOs=
X-Received: from wrow10.prod.google.com ([2002:adf:ee4a:0:b0:3a8:2ee1:2bf2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2313:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5e4530f28mr2161366f8f.50.1752067551913;
 Wed, 09 Jul 2025 06:25:51 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:25:51 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-7-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-7-ab93c0ff429b@kernel.org>
Message-ID: <aG5t32-BiZYP1EWm@google.com>
Subject: Re: [PATCH v2 07/14] rust: block: remove trait bound from
 `mq::Request` definition
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:45:02PM +0200, Andreas Hindborg wrote:
> Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
> required, so remove it to reduce complexity.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

