Return-Path: <linux-kernel+bounces-856844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC34BE538E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB0C189FC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5AE2D9EDB;
	Thu, 16 Oct 2025 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMYJSQTO"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05C21B9C9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642549; cv=none; b=cjLwm607kpTyGKadzIkERihQP0EdYqRS5R0GVmD2yhNVs8wF7UpPEjaNbZfY5NV+fd6qL3NoIahqlZGEVaV0vzereFdu21jHSIjkZjHA/MAsLNugsD2i9m5tJsxYq0rMnJOgWZlOB6Hm/lP8KBhSh6NVhZyW5aPVaMvK9Grgh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642549; c=relaxed/simple;
	bh=u6TNI6P7uxhJsMAo4Mhkv+owrlXQyJn08NNCI9uXiro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgVNTnFYFuZRNpkoXLSZPWCNGVxkRkf8zx1BLN6JxpuNUt+i2btQScKNsBcP+MF5AUPDbW83yPFJfIBjjpUgN95r2shLr/dav45el/dE4ADpZb7iyFc8XuL4F4ttxqdE6x7d0vmy/wtJJMcjI7BV4suUJZzsrziis15Zyw4W4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMYJSQTO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29094f23eedso1633645ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760642548; x=1761247348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBABBnxn8fN9AsR0d75e1hIi7H9rcgMvSSTa+zi6yEc=;
        b=LMYJSQTOQx6/68djLsNmPLV9djmCB4JNusOBZPW6rwetVzs4Pux9+ucfnk0YUnfAs1
         RmHfA5tDF/Cb3fMjMjkKFAg6ndBuXXsViTcCS5uruWdR96+x9/apfOs4O0nEethEiOWR
         PX2Hnc/MV1MA2WIwtXxOEF7OymM+hqUcclo2l5VS7zcUPEgWfW/KpOoRBr691NODe8sS
         4KEJ05XjLBNhYnwoNk7iiW5AscW+IDkXfl21Z/gQk5b1iYb6Z67m12KfE4vQsCZoVA5W
         ghV8LeRCU7DAJ2kkMfAc/Ztfaui5o3hKbSf/q/WmmNVg7HKjz/4+4Bu0ulkPQUsLCOUA
         nQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642548; x=1761247348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBABBnxn8fN9AsR0d75e1hIi7H9rcgMvSSTa+zi6yEc=;
        b=ThXzj8vwPsXfJg7rsoxc/v0Yf4DE9Ez0RHbPvRNPALabOB0bENF8mWRQJh/sxBstmF
         v1vsmQSNHTM02hT4PXqakbK8SsxBQw1cxk8wI+E5OurbjkAzuQ3OSRx6QcPxOiJCO+fo
         lT+restBLlaRqNcg4smFOsDsHCT6DZKTo0p/dNg3vOqDYVVyGmed+0+il9aSN2m2tyof
         XbBzz+J+wBw0xJNm77GJUiCae2B95uFlV6jIhMKHCM9Go5ef7OBulYmSQpFZrnO03Ogy
         8pBqSu4Y1ITa8u70Rb8d73br2aZEvbIuAmpyq7070Zy4cIhZYtMvqWD2/aH9Wmlq7wDx
         rDdw==
X-Forwarded-Encrypted: i=1; AJvYcCXW/lSswwujb0xz7s7WBuajQNTzRwKkpphJNHF8pXIH1Ii34f3Fj0uJ74lXINCSeB0Glp6LmcHx7o6F5hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jAHvrCzYPEij98de8KHJ4RInAwg6hf+nJ1olj/6TqSNRiMqc
	2muIfeD2xKUad+VqYTwO4B3+DwWY/ccWlGFNjDRxVfGvZ9MTFAJ2wZ5GgF6/TOjfzlQ8owxiFwC
	Q487v/tnfJDLyBBFXrVUPdv1COjwaY9U=
X-Gm-Gg: ASbGnctr5ZkZJWGwPecTIv+HmQ/On5/Zvy1La4zRPgnUW43wEtLluxo8MiHJphma27K
	QYFUG3dnBaEr63N8QMzYYwA7FnhhKs84HxsbukZ6fuhXtkuO3BAInq6eG4kr6U3Gv/4/gn2qDGb
	Zz5xYgGbkiAHyDgIDRB/N5twOKbGKQiSS1jwBWzA9WfShYaQbGa/MN5QPTtLIMp7+wQH1iJrzYb
	NadGNbKiWPNIZcKu6LrBDjlG7vCP0/r1vyJ7D69Np+UkAyrF7cuCDVoYDl1KfEsI9G32BgqPH68
	Bbj+oOZYqYldBQtWb90fRwUnzgQqiWeDQ5OsebZUTlH+jFBsQonREXy9faQ/3O9h6UwDFO+mVpa
	mpTd/ukZ8vGJo7w==
X-Google-Smtp-Source: AGHT+IHjy8KjEMzI/k73gqsgnhmTui+XTn/RvV7qTycBPo1XmiJr5yhiR0piRHANoQ1JkvBfjCgn9II2uzdLiDAifMg=
X-Received: by 2002:a17:902:eccd:b0:290:ccf2:9371 with SMTP id
 d9443c01a7336-290ccf29388mr7338615ad.0.1760642547522; Thu, 16 Oct 2025
 12:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013062041.1639529-1-apopple@nvidia.com> <20251013062041.1639529-7-apopple@nvidia.com>
 <DDJJ4Y320YEC.O6QIUDDLFVOH@nvidia.com>
In-Reply-To: <DDJJ4Y320YEC.O6QIUDDLFVOH@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 21:22:15 +0200
X-Gm-Features: AS18NWDEkVfvPPz-PXmo2P-iezhkJ_4yR77lvhxdIOXjaj9vZ-OB3fMu7gnX7yo
Message-ID: <CANiq72kWof2RL93s5L7t52ax+G65iBrOnfMa3XrqC+LgSO49=Q@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] gpu: nova-core: Add GSP command queue bindings
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, rust-for-linux@vger.kernel.org, 
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

On Thu, Oct 16, 2025 at 8:24=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> There are lots of unused warnings when building on this commit. I know
> we don't like big patches, but since this is semantically related to the
> next one and the two touch different files anyway, how about merging
> them? IMHO this is preferable to adding lots of `#[expect(unused)]` that
> we are going to remove right after.
>
> If you have been told to split in a previous version, let's just add a
> the `#[expect(unused)]`  where needed.

A possible middle-ground is to add the `expect` in a "more global"
position, e.g. at the top, so that it is a single line change. I think
that is fine as long as it is removed right after.

Thanks!

Cheers,
Miguel

