Return-Path: <linux-kernel+bounces-721252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C754AFC6AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DC01BC4D27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD72BF004;
	Tue,  8 Jul 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nvvb4IA6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC62BEC2F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965528; cv=none; b=F/mfr1rQuUqFYgIURVIQyLSEi/ZG9xABoLnzePaUy3MqEMu+ulh9KJvY8uQUkG5YGH40e1qSZ8hsur2OfyrAa7YkaMLKv4wgeXN0NqvyulGapXAr0+eVBz6NaH2h4ecyM0etdu50Hx6CA+kQbsq9gujClUprqgQy1lat84Rmq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965528; c=relaxed/simple;
	bh=93hWr3CW10tqHIXDYbrSHPvQwrzoKnMzBCJG3Vf4aGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQQG/RErIv3besZIZ6hNzEv/PDHeQd02/6lsrZAfiWB/oL1Mpm1XZK97n8lgvI4domIn9o3Q7FwyTxoLg8d0oSqnXiOuNLYKkM+S7LISJ3JxkWmhgLJPpv9qn9vksfSeYoyhK5tMf3PZ0sIRqFvIZvjEqP2uTzPlEomkIO+w2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nvvb4IA6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453643020bdso31393255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751965525; x=1752570325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93hWr3CW10tqHIXDYbrSHPvQwrzoKnMzBCJG3Vf4aGs=;
        b=Nvvb4IA6lDYWNoigOanTVKL4KfMgfq5kH2Lyg9qz1OFF5zPKZHHh04ZqRXNln5QEQ3
         /QfUMlm6EkVPQcN178SVPuHIK/P5tLPR88RAObw+HPCogbRech/KufkZayZohEyKJKEd
         j1lDnq3pYQG6WO3sOkZehWmY9QvE34BagOhCilW5Vs0X69eDH2qJKbP7F87M67JVcC5U
         9jNcWv8SWwB/IS632I7FVS8QUvbIc/5AEAZNa6jBKBY+IyNaLBcf3ZsjgHSyOnLIdnpV
         EtxGTEtXfklJ2fjm7WkHTLvSO4ssliP4I4/sWW2Sdr7cqgtIkb3wwrXyCPlFj6vsSvr1
         Bbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751965525; x=1752570325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93hWr3CW10tqHIXDYbrSHPvQwrzoKnMzBCJG3Vf4aGs=;
        b=hWEsLGyebsLahBi5Bm901yxpm4TkDzti/l7oi0DHDETwglsS3MPyijEmHvJJogO572
         uON+1KkR3qniFOqf38xI1C93ZyVu23eZrfPQa3gJAwPQBixxOwAdW7hBXuAIkBKUv6Zu
         eW5TV5IXKVAIlFI4coigC3yoK5mYJHdF8vr4RCgOtuWaM10pp5LlTq+onwdZ642eI/pI
         Mih5fxCnTCSq6LoBXE7mjhPmSzueqH1dQ+j1MfAReIzPlEaP442SIVnmHgrLS4XbaX1Z
         K80agiKrNF641hfJS23p69/14BIh78kOscJOqXEHUmtIXjHo0oYnQepVoiuDMtRC0AAV
         JuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFd8SrQ2qKwnF1s0paXP6iEzuA6sYe/LDLQZdc0V4U60SYJujqlgW9Kakke9Eav42PYeYbPNZhsiYuuxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprUiquyuA7W3xrOnvtzf5kSLyC5YFF23267lUpaMiMx9RrraF
	BsMfg76F4vzi1jHbxtOvQgnjM7T+aTQNyYo2FlygcAVIT0So6hWv0hyGFJbL8Aij4SeGr2tz2BM
	ttjoxUOzggrCbj6WAVXhWqUEINNZ/6riLZdUcQKxI
X-Gm-Gg: ASbGncv9dcziS9zJeHBbJm5QmKfrJbE+2EIe36Tpjtx8Cj6+sUoB8Fl3KihkfSrcnGv
	XN+eJSdouzzos+J7ZRkTyPdgNSfb94z5Drm+2QojIovWLfCDSOOjeUPKPKfflR4hFgcyXHxPrlv
	N7rRnQcuw1bdpSBUpdr0hcQ1dCOy3333NqvH2evjkTXyi5YAhnAd3dwsMdkfjyqxsoPJzBYP/i
X-Google-Smtp-Source: AGHT+IGLZb2WPMNKWHvsNO2QvMWcnHAsOXW81tbgNp4vh0OL2k38REWdnZHTCfmUYHNCVV2Tu+hxKU2X2ApzXrJkrOI=
X-Received: by 2002:a05:6000:290a:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3b5dde95755mr1690036f8f.13.1751965524785; Tue, 08 Jul 2025
 02:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708075850.25789-1-work@onurozkan.dev>
In-Reply-To: <20250708075850.25789-1-work@onurozkan.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Jul 2025 11:05:12 +0200
X-Gm-Features: Ac12FXzqyncHcpbewNp5JPkS05kMqf8uEOtDV_4zdHcXeFMjqppR223yAjXeBoE
Message-ID: <CAH5fLgiBd7iHiQ6UrMoU_4zxr84UbC6-q+Tve-3mhWJ5ZCr3zw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: simplify finding `current` in `remove_current`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	mattgilbride@google.com, wedsonaf@gmail.com, daniel@sedlak.dev, 
	tamird@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:59=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> The previous version used a verbose `match` to get
> `current`, which may be slightly confusing at first
> glance.
>
> This change makes it shorter and more clearly expresses
> the intent: prefer `next` if available, otherwise fall
> back to `prev`.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

