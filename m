Return-Path: <linux-kernel+bounces-837612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3762BACBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C9188B4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25552F8BC9;
	Tue, 30 Sep 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVMjpB5P"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A692D29A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233499; cv=none; b=JWMinSjAtWwGYe36iFWdC1O+tI8c0TbL8Pzunt5ZMyatzdM7Qw7V70AXxESVw/H+Vf42I3Um3hU0Gp5dEP+y6Stt2zPLqcKcJrUC+hP6wAjr8cUPk4IyVuWMwpetQpUJKjFAWSvWvdGoEar+pt6zqtm5FYvmaFBzrvzNF5JI+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233499; c=relaxed/simple;
	bh=VcwjoiI7Z+OQfUBE/J+XJHgAGKhZ1AOP0RhfLRLtwcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBMuqfww/y2Ii6v2hAanJWcr0rAymiYCo+Nn2CJYPZoWj8ZWwxDCYK0Vy0NNRjvXB5fz2ILvC5eACUjpLyIouKhq7r3tKuNXJnmvqm6p69OgEqGydTmm1fzmOyT9emlqXCdKLDRzlqNbV1Tye5y57YIcuaw2hdF5OO65fGQM0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVMjpB5P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698d47e6e7so11885465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233497; x=1759838297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcwjoiI7Z+OQfUBE/J+XJHgAGKhZ1AOP0RhfLRLtwcY=;
        b=BVMjpB5PA38Gi3aw1Niul8RltG3nbShJ5VXVI8XjCjgLY6XPMBwVokuLnM9QC7EOlt
         cy+Zfd0UKoyI/8fvfRMnPiJtM1IxsBKl8h14vW52JJ072TDHovDFo3HXAUMfXVkrZG5a
         GAFlNyXkExHxFSoPLBaDwzXQIgZAeBmDFV1iDJ0MwBQo8opV+iXwsrLqIjQJJ9sIHKc2
         GgCFUx7B049Tuilg5bsQwzZBiXt79y1KR2k2iWtcHDFCxilQksJkZ+oGyVU6h2YCymKd
         4c3PCjb55P4xQpiLvvPkNopjbGeN2kGz442ifpCtUYTOqZ8vLjwrybR3FCrWGWl1V2BU
         5viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233497; x=1759838297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcwjoiI7Z+OQfUBE/J+XJHgAGKhZ1AOP0RhfLRLtwcY=;
        b=NDdSGIaaI9+Vg8L75UdoYcXdabF/bjhLtHpzAY/IRotlAImMARfv2zgZERoNC6bXe2
         5PjqjOlqW2Kuwc1N5+20Fe4wS7lX/jWQYgB1W5y0vacooWu9wrN4s5UUkt2m+qOfRkVu
         7um4bD81pRfn4920/fM+1cyqQ6oAdWTG2VRk5RvAHzuPr4lRY15RhPzYbclDZRDUOO/C
         oHu1gsHbu+uwK/7GxYSY5Oc8q7pqjgDb4AR62t21uNzO+yCf4DtkYBDJBqTTUAe5BbU/
         m/oaiRg2EHYp4Q3YQH5XWHwbSrzZY6saLDd2ApbyTw1wrEu068iMDJ4n17s7GAslBBvq
         AImQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHy6b7XcHWUF5Fz33qYN+letusg5GCud2LPhudOjmF+11RwtxL9xRMUMwgD1NwErio7fV4Dq/Mk490ITA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULpYOyACObKHZS/IzCpy/+fuTm2148dH11riTXKorBS0hHCpE
	Y/AjYmTzEwnlj1kIFpZ277B9eM1qpdzWwhKPodKVw07KebUOF0Q7DJ2+Ut33ecdR6GH4uVKdJ9n
	n7PMr3XcfO+tPlpnHgtbvWQ0WVDfHReQ=
X-Gm-Gg: ASbGncsVPiQYyYuGMjsY2DzWdvR2MI10FESTAE8iEr9eZkCcztG/oiK8EMAn86ggxgB
	cYoiF8R3s5SlP5y+6LFjTlAX1STDD/lCJCSKs+TImYJLsDeptAJKNCvXzbVnGtj5EkNYQT29k1N
	DMRg05iRa8n+vNYuh8zxE/ZPYfzT3DrXS/YXGAgbcyeGv+6BOX1nsyJ7G2gGFx5T3E1lFsRCR5w
	Oz64YA3CioMVqoMlSlvuYzfbs0oz/hXEyIlGZ43IOI9AmPoXaSBnbLzJ6ObcpTrpubPSrWFipvk
	SH60b4HQf3Zh/h627AhFdvqrOvQwyvbt2NbIyVvdGi/2XS/QJQ==
X-Google-Smtp-Source: AGHT+IHJ4gNihkr+mad+gS8QEVDP5CM9acJAgm5Gq0rNyMMXGiM3fVx5RNRww0KuhYTEhtNZfq1z3GOBVp8XDPlUzw0=
X-Received: by 2002:a17:903:1105:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-27ed4b5dcf1mr121341885ad.11.1759233497228; Tue, 30 Sep 2025
 04:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922113026.3083103-1-apopple@nvidia.com> <20250922113026.3083103-6-apopple@nvidia.com>
 <DD2GCDGQ7Q4W.1CSFYSETFSN5H@nvidia.com> <7brvf66smc3ltqrw7tm7smth6wnefeqykdm2n4qahi5xnr6d5o@4l5xfdbznlp3>
 <DD5CXDR294YD.2RL474PWBDWTV@nvidia.com> <CANiq72k3qkj1HxjnCoknAdWhdM7O1ZBkZDqBsVS7vxYH-tRCWg@mail.gmail.com>
 <DD5D5SRBMW4P.3JJPQVDF5BZLU@nvidia.com> <had7hms7ex4w4bvy2mfwtltyyt2xhsn572brrxvibvufxt6fuf@lppudpzwct4a>
In-Reply-To: <had7hms7ex4w4bvy2mfwtltyyt2xhsn572brrxvibvufxt6fuf@lppudpzwct4a>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Sep 2025 13:58:04 +0200
X-Gm-Features: AS18NWCdBljfozdePu6TUcKqSpCpdgxpMnivW-rYDv0CmHf3eUP5HKxAK6E3ccI
Message-ID: <CANiq72=hmkF=FNiWknrKXeLz4EK_eqLQa2647ejJSfukb9B+-Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] gpu: nova-core: gsp: Add GSP command queue handling
To: Alistair Popple <apopple@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 1:42=E2=80=AFPM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> Thanks. Is it still expected that `#[allow(clippy::incompatible_msrv)]` i=
s
> required? Just adding it to `rust_allowed_features` doesn't make the warn=
ing go
> away without the allow, but maybe I'm just doing something wrong...

The warning is independent of the allowed features, and yeah, it is
expected that the Clippy may trigger (at this moment when we dance
with these features), so you can just allow it locally.

If it is too cumbersome, I may disable it globally.

I hope that helps!

Cheers,
Miguel

