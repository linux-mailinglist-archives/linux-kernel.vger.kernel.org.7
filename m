Return-Path: <linux-kernel+bounces-778088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA52B2E12D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E006067B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F90321F4A;
	Wed, 20 Aug 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E0KS97i/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B02E8B73
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703522; cv=none; b=i41paM5MY2H02gqW7ZmgdmnWfFjB3gwzmHw9FA0h0OZvtksUa6/jdcIjQVn0sYlMu8nPV1tL6UjWmWq5hC7zR7uC3IusNxHmSKOQXyACSXFqRoGF0/bmcHzDsDNjp1i0vngvauKAytYLiZo5GbVZCJvv3VdX1XYKMXI8fkaMW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703522; c=relaxed/simple;
	bh=Qav1M3tyQmglESrqnGWfLbt/rScnOPtiQBAqrwQENEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml5NxPaUq0trb8rrVsvPbehIFdQaSmmJGfLkmJx8K2hzBR5EtEK0Pjn9IWQSB+Hmjd4vgC2Oylt261r6GeQUHtWZUrUvZzpL9G0rIklQhrHwrho0LvhzNA30vrCxJ6J6txzGgAqZ9tvZzHVWnvYg3aLGILKobX5uqbPuMWJUqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E0KS97i/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e8005bso43241a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755703518; x=1756308318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkmFWE7tq6b3ya/7cYC7Eh1qJoGwKmH4XG/rocLbBXU=;
        b=E0KS97i/cHDzXzamI/E3NW34BfVgyEXAvHzsHP5VModzMXqudWzAmYp1zH1zChtVVo
         StrbHyN2wJZ+cipFcxCZ1TR+w4uRH/HRhGg8cEdcqFjBtQifw7ua2+JsF0McNlwOLnBa
         mAM1fQNAe1GbZKhUxDdg4IhdUBN3HAcpYgqI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703518; x=1756308318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkmFWE7tq6b3ya/7cYC7Eh1qJoGwKmH4XG/rocLbBXU=;
        b=QDEahwTbcN+c7Pv5rtzfK/vW1yEUnCrKxatQFBF/b6qk6CItlu35pfLTTvTLiB1hk9
         bwp2MXR3N6qpDqfBqesvbFau6N6YeVECAVAIEcd0wQpcBYLkaau2QNalWXnjHf1PD+3n
         4ot1ZDAO+tpQQ5rg2Lkavzw26nrtKM5wZB3OnaEMzt0SQoT8dMzjlqv7l+ohWM85YkuP
         nNbgTwaOpVPvDThul+e3Xas+7lrYEMmOsItRbZJCbcfVNAlb8WHMosT7UolTe7E+dqfL
         bU82dgMO+cdM6v6vyUUED4EkNHIV8sqYcElJy4ZFDf0x6Mids/RpyUZmB4F+p4TthEWs
         dUWw==
X-Forwarded-Encrypted: i=1; AJvYcCUm+x4g9N1T/F6p7v6FzQrkcJX3CLpeK//BHRgW7Z/rAk2HAANqZ2xvldaoXIGc3KI+bk7DBeJbu6kYHvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJrsIs9dFuRbsdy+PQ8iCvH5+3t55o9+g4ekW1zuBqh3pUHlO
	TWMWgfa2LMuOTKpHWOajs8SXtPCX4zN5bKv1W201IorDaT/QZ48myixZmJ51iP+x2hjHtSMczHU
	KZHiI3w==
X-Gm-Gg: ASbGncu+2FiYwhzfT27to+3bQbegIGkO9zbaoHVmVhoH0KanKjmm7IjGrSTr46dmb9/
	yml/7PdaJHGyPKUYwMfpnBXLqDeHs9xUzM6rGIkjZ+oaovNhEBhXsUl4OfnGsW7TISizo1AA1/Q
	ypeYbP8BmKDAVzjsrvi1TPaRLZoeJRF+7CLUXnftoWtNvWdlj8OHpUvLhz8Z5Q5WbjRoLC2AP+o
	RZIWr3nYhkRLTNCbDMUcaC+sYsDH9G77sdGujJ//gZO2Nj1eRIApZLQoltvJSJLZxB3WxdksFko
	xj/tn1RFwlt0nvl+PLt3YC1hfLmEjwq58ADCYtBCxNkjOnSEwEE5eRDbpv4KqGS0ZoZ4d802Oh4
	oSqoRr9gDRtYV5oqgqOs2ooiy6Zg7h1IT0RsvBIhzCMGhwx6YthJUYz40Kgn1SzxmQWsGP+8w
X-Google-Smtp-Source: AGHT+IFVtk9qfBu0B36Gz6Cb7LH4T2HllhOULDmi0DOqQi0871wc8EvWLakhIrj9BCj3X5aYsqxe2Q==
X-Received: by 2002:a17:90b:3945:b0:321:1a89:f692 with SMTP id 98e67ed59e1d1-324e1319f93mr4526743a91.8.1755703517731;
        Wed, 20 Aug 2025 08:25:17 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e250e52dsm2655047a91.6.2025.08.20.08.25.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 08:25:15 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e20aadso48640a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:25:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRgi7NdAyTgQWZGESSz+sKWNb41Yg1b8BWRnJWUTHsD+4qrJpmjUaVFljOAo+AdNX0I/TzjA5U6964JpM=@vger.kernel.org
X-Received: by 2002:a17:902:ccd2:b0:245:f7f3:6759 with SMTP id
 d9443c01a7336-245f7f36a54mr17614605ad.50.1755703515111; Wed, 20 Aug 2025
 08:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082135.3351172-1-fshao@chromium.org> <20250812082135.3351172-3-fshao@chromium.org>
In-Reply-To: <20250812082135.3351172-3-fshao@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Aug 2025 08:25:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4y10ejoYKkK+sd4YbtqqaYgXYNf1YAKdK6NodcH=EAw@mail.gmail.com>
X-Gm-Features: Ac12FXxDFSB6mln8t-OwH89VVYymkhP85lC13PmFNjLgZsgGO3Gu1KDH09QT8WQ
Message-ID: <CAD=FV=X4y10ejoYKkK+sd4YbtqqaYgXYNf1YAKdK6NodcH=EAw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/bridge: anx7625: register content protect property
To: Fei Shao <fshao@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>, Sean Paul <seanpaul@chromium.org>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Xin Ji <xji@analogixsemi.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2025 at 1:23=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> From: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Set the `support_hdcp` bit to enable the connector to register content
> protection during initialization.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> ---
>
> Changes in v8:
> - rebase on top of next-20250731
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
>  1 file changed, 1 insertion(+)

Pushed to drm-misc-next:

[2/2] drm/bridge: anx7625: register content protect property
      commit: 043d9c6928b010be7902a01b5cdfa7d754535b1a

