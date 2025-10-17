Return-Path: <linux-kernel+bounces-858080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FFBE8D34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D0503A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96D34F49F;
	Fri, 17 Oct 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY0x1lJL"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40647332ECD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707483; cv=none; b=WjkmYuy0loLJ7uBNjcQUUuhpAOfhNDlROn7pti4RkHdqz9WXkBhZk+WpaX4EcenHjw9JU4FFRJSBM+YbgCVuVwKDA2aixKtbm+Ec42bmBqa1DHL2nCF1hIMJc1bWRqvKfmfQ+/VUJkjvOvyQ7MLAOfthIyHicH/nTqhKTlR9PFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707483; c=relaxed/simple;
	bh=GgEzp2Fj75nh7OEKAeNg1afv+M1lZPOXZ1gMVZJFyFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EndrRdOAdc7l2XNyGqcerO7qlYZys9wUuV7roAj7EwTdlQVV6g5BIp7976guQYykZHGEnvPE2nHCXHS+wDsmpRsp9Ia0knhhmqKV5B4HwZhcEcWFQPD2fUhZnOaEZMAWfsYmbg+vyOqMkXxUWOcD/uWqG/2TxZhgsyIrSDuKE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PY0x1lJL; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b4068ff9c19so246118966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760707481; x=1761312281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAPzxmZAKRETv1aAgqTv/3Qe7/Q8DRU161MvWKOur7I=;
        b=PY0x1lJL6/OVlUOvGYH6SPyKwg1RpJCQy6ysblvld2lGliHCrnCRbeM/7NsY/Nm82f
         vNYMjNCAePdDgMoA2gX13493Zk6LKV4jIRwkXTe8EA7MVhTi2pCAMc2Fa1/77CmXnAh9
         Eau3HfVn8p+BRz4wnAbPMIji3C8DWcbfpGqJRa4pDX4GHAO2WGlKvWR9bc45exnScTGe
         prVAywqhp2C9880X9euyiteDnpxwNUHSUq7tJbH69Cqy0tLra3KkY18vNZpPQ02Bc5Zo
         TCp98cC+PLPzdOJVaHVo2nPITVBdez1HzHaHNHSsXtdCockw2h7FATG88TeUH1RtSAmU
         zEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707481; x=1761312281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAPzxmZAKRETv1aAgqTv/3Qe7/Q8DRU161MvWKOur7I=;
        b=IucFX/3AdCwMbGQDvudxV7y+iVBfsXdA+s9IKOBk6ZRZGEeVy2uDVDyJ8WDUARuk/R
         8uWPYCxRqWEt7dUvj4U8tUZDYqBEqgdOqNqug7vkfNtvQW4XbVwzCDLDs1m0Ug+VRGZq
         rZTQMSPuUF9eHbJhmVRbPJRfEuDeaqIAXby7IaZ81asEKekU62fUo3WYHCxjgrEvZ/82
         i5mzoowQtSyY7dCGp0cuGRPM7h6kxB6fwLeSxyRluOyXd1I9Pc/K14a/gcwbKpj//fdA
         y5uz91wFj0LeFc4MxSjA4o04v9RIV80M/7P6eZ6kDp1Dwks+W6v4eKtQrJ0o6HikZcD1
         zp9g==
X-Forwarded-Encrypted: i=1; AJvYcCWLSFXQe3N6KkOiIdkti7A1QgGSixT+a7uSEc/UJUp8vp6dOBG6xsoLcI6QA1eVWuYEsFdCctuYCTYGhfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3y7cUuuJVxt3UW3SXNn35ESGdeviA/dNmRO8czxHl1cB3HBFQ
	tdurGeecrUzSl8LNDuFrQEJBreSVnuFfjEEzgIS8bANCR1mYd/+0pkvJTq+REbeXIvHwpilJLjj
	kw+pNFQTqKNefKlcT/Q==
X-Google-Smtp-Source: AGHT+IG+iL14vecShPyktC8BwMaW/uSlauMbjVXn7jXOXVhUbEdp41zM5x6FEcncWa9dDOidM50s71O00B81dbI=
X-Received: from ejap10.prod.google.com ([2002:a17:906:228a:b0:b47:8176:fd79])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e85:b0:b3a:7af8:c4a2 with SMTP id a640c23a62f3a-b6472b5f826mr440021066b.10.1760707476223;
 Fri, 17 Oct 2025 06:24:36 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:24:35 +0000
In-Reply-To: <20251016210955.2813186-6-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016210955.2813186-1-lyude@redhat.com> <20251016210955.2813186-6-lyude@redhat.com>
Message-ID: <aPJDk2mEAOWoyZC7@google.com>
Subject: Re: [PATCH v4 5/9] rust: gem: Introduce DriverObject::Args
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina+kernel@asahilina.net>, Shankari Anand <shankari.ak0208@gmail.com>, 
	"open list:DRM DRIVER FOR NVIDIA GPUS [RUST]" <nouveau@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 05:08:18PM -0400, Lyude Paul wrote:
> This is an associated type that may be used in order to specify a data-type
> to pass to gem objects when construction them, allowing for drivers to more
> easily initialize their private-data for gem objects.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

