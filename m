Return-Path: <linux-kernel+bounces-765820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EDDB23EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A53B95BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A028C2C6;
	Wed, 13 Aug 2025 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5qJtNNs"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901528B7F9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054076; cv=none; b=oPaF7vCvbvzuPfoxqxCqEMkonj3IqJQAXagRgh91dR+IrgwP1gISzpIjhVJyXm1gOeKjbqA8rS49nQv/Q3dDg7qwZfWR+GtpVrbmtmZ74BQTBJ1uNOyuRf4zpSevKJadcrTXxSzelqNtJ69DNpPkFIOCXcI31oVgFJJ8k/D6vJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054076; c=relaxed/simple;
	bh=Mwogx+eS89jOrYozXKAzAp0ij0rBCaM80NxlzPyEOCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmZs2WY/+lO7GBBwlbT2uF3O3houLwfsELhtRlxCeqH9Irl13Y5V9HaY8UX8LLsSnZpwvN3Nyhaqr3KLGdQLXuUXy7J6J9RLbbzAXsHuMXUzTLoyiTcrtzNlfkUaBNYYSG9uDXGImc7VPeLAxkjgstm1N/hsiyPfggOdkvg0/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k5qJtNNs; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-50e2e0ce5f3so468614137.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755054072; x=1755658872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwogx+eS89jOrYozXKAzAp0ij0rBCaM80NxlzPyEOCk=;
        b=k5qJtNNsIy+fepmRB1570GMnAYRUTDx7Ahk2rArcf9TbJyFl7d0tUWZ6AKTGVtM0KN
         huFKRgpCj1LtbT6dT0u5gz2JyNThp02+9ShN67cYueRZ2UkW1biTxR8Mb6EdqJmQdc3V
         LWf6X35H+StxE+ppEeOg6XF6CZ2ZbQMcufzw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755054072; x=1755658872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mwogx+eS89jOrYozXKAzAp0ij0rBCaM80NxlzPyEOCk=;
        b=qYNtnibzJMl0sZgwWMxCaixpfOJtbWb/l39eAhXMZgLdbo1Pu/FlHB4L2QpZC3x/l0
         3iUTDFnlYcuZEfQeWstxZEev3bDy9Mshak0eVKk2VDjAiqMy6r3GpUeMTIhp2Eyw3P/z
         IMx+n8wBORuflpuzdvjYGLHBaRCN1VJg4oZXz4rI2Fx7XHNC3GOD4iSw+9wT05tfe/7z
         +2udX25pPauKc35Bs/aHjXS/yW7HS1TO0GqfPR1CgtbmaExvF/Gr9LaYQ2PSvQRTq5Ii
         vqN/rcKwyZywsKRY2HLJmWiApQOJU61Mb6zJoUXQtd0cPWMGFfYOP115Un0ASY+rKgrX
         SV0w==
X-Forwarded-Encrypted: i=1; AJvYcCVJAPcizdm7nL1+EWPgGJOrf6O6Y9cO0bFl4CZK1R17enX/o/CSmRLwbmb5KdaY3GJcNE1cgrWuuf5cXxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGv499G0e5Hbfyeiw5wW1yR5b4DNzev4JzxOgRqr53y51iQyMJ
	3otIxmgplKfHAjGhNGXHAxvNc9na68BPj4h1njIjqARku5xnFSE4TDksAIxRIbKCAG0p0ndbyg3
	eFk3LDg==
X-Gm-Gg: ASbGncv4xQXNsAHwBzPCYQc0gGUj0kq/Dog67c9UHlZxupYvbTLE+O6TBNgtU65HZj8
	yE7IFyAixjSqRIhkEAY4E6+KWRitUzKy3qgqHtjkVKvn1BfhnwiZZhN8ngBDR7S7+/eXVWH/zDY
	fQa+SKzRVi9fehX43cMsgRKb08bAlpa74DbeH54JpvP7kfC1qJTITXi83BsrDyhvlZfRnMJlW8Z
	wAUZ3V9sz1nZDf3/dRI9vH0fXl3O3M+A61fes6QE2Vc3k91Mw0g7wdjOwPkkB6uLqLu8ejeRUGu
	6RnzlAkrwqHbJ2xgMNqmMqZ6Tdb20ox+bMlwv133WsFaqyxLK20V14NwSVXSsN3ZSfpwGiuME9y
	X8HSN8j5Pyp5rP1SgjBx2PE7RMvC5fWFtWiuRArYS+KEgpXX5YEQX+9cilCoi1bDF/MU97DqV
X-Google-Smtp-Source: AGHT+IHZURdx7jXNayUzymHB0heF7pd5nz+JiyB6Ni6glaaoY+EBcNR4j8Fp9a9x1GjqDndFtbrvEA==
X-Received: by 2002:a05:6102:5090:b0:4e2:83c4:9298 with SMTP id ada2fe7eead31-50e77cdcd7bmr286804137.3.1755054072642;
        Tue, 12 Aug 2025 20:01:12 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-50ab957df3asm1333995137.16.2025.08.12.20.01.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:01:12 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-53b09bdcb73so437176e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:01:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhtIuHZc77w5vpvjeBb+ne2hpVXXWCXmK3KNuUFCz0nwzIUC8UYjbo+Rgfxtr0gT9uE+4Ub2EnAclnfdU=@vger.kernel.org
X-Received: by 2002:a05:6102:14a8:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-50e782c12b7mr322781137.4.1755054071440; Tue, 12 Aug 2025
 20:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082135.3351172-1-fshao@chromium.org> <20250812082135.3351172-2-fshao@chromium.org>
 <CAD=FV=X_CiSoXyKkg8jBJLPKe3WDBpLEOAngQJNnN8yZfaC+qw@mail.gmail.com>
In-Reply-To: <CAD=FV=X_CiSoXyKkg8jBJLPKe3WDBpLEOAngQJNnN8yZfaC+qw@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 13 Aug 2025 11:00:35 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhXO4mHkxGbLzja2au7RAfDR+-yRoGAkuMCKCc69N4rng@mail.gmail.com>
X-Gm-Features: Ac12FXyWFCZPXff1Dk6BrxbwFMsSYp_Qp3kx0qOfMjgPafXKsWbyukfoMR55OCE
Message-ID: <CAC=S1nhXO4mHkxGbLzja2au7RAfDR+-yRoGAkuMCKCc69N4rng@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] drm_bridge: register content protect property
To: Doug Anderson <dianders@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>, Sean Paul <seanpaul@chromium.org>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:07=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Aug 12, 2025 at 1:23=E2=80=AFAM Fei Shao <fshao@chromium.org> wro=
te:
> >
> > From: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > Some bridges can update HDCP status based on userspace requests if they
> > support HDCP.
> >
> > The HDCP property is created after connector initialization and before
> > registration, just like other connector properties.
> >
> > Add the content protection property to the connector if a bridge
> > supports HDCP.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
>
> nit: your Signed-off-by should always be moved to the bottom when
> posting patches. I wouldn't bother re-posting just for that, though...

Ah sorry, I didn't notice that..
Could you rearrange the tag order for me when applying these patches?

Thanks,
Fei

