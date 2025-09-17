Return-Path: <linux-kernel+bounces-820417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4AB7DA10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505C81BC75CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CCF34DCF7;
	Wed, 17 Sep 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OxL3SAfo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E7283689
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103323; cv=none; b=c3Curtzrj968mtXxSUxd8NT3vSbwVDL98dbraXHaALXf0DV9weIAcCRkhVXomoxL3V8EE5usANiA8FGKRB3HNdZhCu42SRnpq0Qu5lopN3sp6ZWUNHLw8ahKN0trEJVSgy/kXRPGAjA46dnQfARycOAsCIHLUM6ydvIDq8MnSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103323; c=relaxed/simple;
	bh=05OuWmIx0EGQ+z4Mvd8YfoR1xCyiI2LeN4jLN7AezMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9fo7HJbZTgOMXK2Ed3xbL3AHJa0WTzbr4U0wwy5YG0NhSNigepgE1idsz1Px/hwEObT0GZUOFdNFyrN1l07ZhagFEbABRPspoj/b0APqMLCLhueBKvL5SdEnv2wFVqGKdNP5ydPRs3um3xWIbaMi/Mg48SttuxC82iGV/xdkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OxL3SAfo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-263b1cf4d99so6793525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758103321; x=1758708121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05OuWmIx0EGQ+z4Mvd8YfoR1xCyiI2LeN4jLN7AezMc=;
        b=OxL3SAfomCvtvA+hFQAX5tMVnWzzS9AK+jwAbCXsgBBOHUIn4jEzauBANy2jMg7r6t
         r0KXknwQeKKRnwDdxnMFT4SqCmKBB8PaNKRRc89ZZuFBa3Ho4SsIJxrR5ZaPMUdIR7oG
         Fnukj5DaYSryU3XWQzEmfSR5sJdwb4l0ozuhB1IxhkGVzJaZSplLuwqzrh8JBohfoYmv
         3Eq3tNZuRTNFCDiEfr8VBNWXOMGaALbS/IjJ03B5Q2eCsIirvLEQopgNYDpUfLBdRw4d
         qui984Tl86tSWAkqVFn/p4+lPKm+5ukpBl8nbRLe9wKxZq4bTqJGMTXTDQSgJUyXmhyI
         cE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103321; x=1758708121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05OuWmIx0EGQ+z4Mvd8YfoR1xCyiI2LeN4jLN7AezMc=;
        b=noNGiXvz8JroA5M6cL0zlRcN+/zjaA+C3QOo+DaJWyiXUy9A63qh8pOYQT39QZszlO
         9e29fLjrIaZuQ2wEB9yuoC3mDA5L7zXFdrfY7wlrxu0c7oc7aiEr+9h84OGAc81WaOYV
         AvJzgETivmNAVEQdypaLmOMWKKlQKWeAbGWJ692qpnqBhsgU+FGfjhWIZH5An3BLgzUE
         DZhWpEKFr0MXLm8/PChXPK4ebAuU6GyXMQ8wTwS0z+ZvGwEUQ30kY243NpeMlFD7q/5V
         Yr0P8ewAD+7oXuUJGTUFnEi5K01IWjKLiPHsIH56402fVyKF/cDJrugi4ZM+F/FDCKko
         0xaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy0WeeJULvQnySW1TMZD5uGUgxj48npvGRT1RTdXK9f0rTjEe9QrrU9TZIi1ZP5Any35CwYUOs/YFRkE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhQ4f2+bVws0GtQtxfFgRdQZeUp8hv6lgRHFkKYqNzTcbUcxr
	zEdHwkwssObhRCA8b1VE9DhlKzCQiv+eauaGfWPy4/X8e2MOtM4bvLZsGjnvKmZkdkISB/+w+4c
	DnpL0fon5MaJoKicPe2CjYukj4X59JC6H+X3ePTnN
X-Gm-Gg: ASbGncu5VZ3udqbNE7P6FTUfW1Wf/bnI1BqqxmFxIpI4lgC0qr5bplUQFgveahEaNph
	p5OAt/EJfhrg0mipmV+sHarKg3xJi3rLc4qsZa21dMST3PaGSlnB/fRCQDWNwxWWyL8VtFHPWv+
	lM1dbMM5cy+1OKlDhy+dh8tThTJBq1Gz/reHQmmk6XNpHZPjjWC32Se7aZvsxjsFL8m4lduFmik
	g9966RUJTAS+mWhzE0OxgOjxrv3xGWm2lCu
X-Google-Smtp-Source: AGHT+IGZwHVx6Ssa4CbYrghSzzm/47CthhCvCAGo18dD3J9Ik9FjPw6pxNwNxLFS3lNwcuy4I0jlW5OSWsv/mLRISmY=
X-Received: by 2002:a17:902:d4c8:b0:262:9ac8:6132 with SMTP id
 d9443c01a7336-267d160b79fmr67814045ad.19.1758103320679; Wed, 17 Sep 2025
 03:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-3-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-3-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 17 Sep 2025 18:01:49 +0800
X-Gm-Features: AS18NWD7EY3QwkpBx4m1uRgvB5KcwXIFDktxQSExWKLqQh0PwM10VIVvgqzksGg
Message-ID: <CACycT3vFBpum21PBEdyE-acZb+yPqGcig+xGqWP5qPNT3Ca=5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] vduse: make domain_lock an rwlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> It will be used in a few more scenarios read-only so make it more
> scalable.
>
> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

