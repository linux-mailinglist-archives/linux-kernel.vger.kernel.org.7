Return-Path: <linux-kernel+bounces-818489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52FB59269
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827BC3AF88D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCB29ACCD;
	Tue, 16 Sep 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsTWZ5VR"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C629992B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015542; cv=none; b=Rlbh6yR3MYOxMaqNZV0qHLd2ogmneFQYw+mvGsMxN+jxAg0k5uGdHzgTtlneYKg7OXY1GSizBDSjvPAp43Qd61fovuRMkwRaU366zXqDmUmjFyX6BBspj9SWaN3y34za365wz5rkEUokgugTuUGhDenUHZjr6wVbEDQReAGpwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015542; c=relaxed/simple;
	bh=fOm7n0oqTh35bOtTCp2VEPwcj/762d6UfcwiSPgUo3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li205g7napmap4RwFzP/v1PTUptNunQ4fiHLQsaPiJpsGO43bhqHJP3qoIsGzksZDO9UzoAy9x5NZJZgXDXOKiSqUq/hkWlNTwv6zOy1+muY79ORjad0b1LWRXNv6k2eDK+yOiQjONgCXTuezk5/91tnYN74COHQBonqPsXMEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bsTWZ5VR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-816ac9f9507so716121285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758015540; x=1758620340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMmgtmyqL3pSVlf5uAfBg8YLZnU4eepFksA8tWxfUtY=;
        b=bsTWZ5VRxzL/eq8kukNK20lsIP3sO5YsRQ7c5k7l4veJYDijBIfP0tv+nB73b2//zY
         lUbpMy7HT5+8cmtTYMDjuz0Bo0ChkTJhnvLhNkwvVLEGh88PmRldRxKKPwgwpsV7p9h6
         Ho0NkeqzrOGeHH3CVLTYTv/wlm5if8zNRmiTqMWKoEfSuUZZN/4x4SaCcumPsylW19NY
         QrZXgsV8bK5/ku8fKhfaHQG3w5g9I2ynvcnrBGsUlXh/Ye4q8Kn0brpFO6gdA0cp6YeW
         1EuAwmorETWjuCWSGbgnYCRUZhQHYy0voEeTs+fn3Ten9MBVMjX2ZlmRJLh96jGjNEGZ
         yXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015540; x=1758620340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMmgtmyqL3pSVlf5uAfBg8YLZnU4eepFksA8tWxfUtY=;
        b=vTlj0hIr+Z9PD1g1+yxTo50rNN4s3nPNSS3RqrvwTwdoBkHDmFT/qhQZw4ooQmHwtb
         Se7J5KRi+3QsdfqickzSC4fj7k3BX/N2EKOjpCf23R6dpZVsfKiNslAZUa6Wmw+RoSo+
         8s2zZkIriuY9RoonDT1Sjkz8L0bp0oEUKpUwlaWRZxdRkv49D5R7l7FARUqWbqvVYD5P
         6hySmmiLv2dUqFK+2pWra2ZHno80khLzDp845USdf3FQarUXwXI5SetrIMOztOQS+3mx
         OFyTi9PDUsg8cDbgzYc5TalpRE0i58mxXrGitziqkCVeu0bcLg0BUJcYqqzj6vghyH7U
         txvw==
X-Forwarded-Encrypted: i=1; AJvYcCWKpy0RX6ntkEASjGxZFkFkXebQBBaSy9jNzmhjLFGLS7Zv7mjbILHat5RHjeESLPBfd0NhPrnwnCnZ6Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVc3dojPnW89DIhGm016jvPZ/BDBf0+HE9OdWRi+nVcUZw1fQ
	8ikplT2r4dc4dowr0Wlx8SttFS+qzcz0b7tJjG849H4bJjO3mqAwaB9Qb1mEH/K1yIgQtfwnXl+
	8/Au9T9yAWlMqYeUk/NQREFny5+GU7iZZUmoURJwr
X-Gm-Gg: ASbGncvmRdiRzghiMp1X25t5A2CgXruPdX89PLDVDB43hBGNoVw3rrJOC/1E4TMQMa+
	E6IjumbB2yRT9cP5o8tB9KNJuj72upz3JnqxtNUsU42EHRF0L03hDhbnOMK4a5W0giiK/r453PF
	CkI/LitEtmFuKZypr+2PC+DIkTUeEBrOBMKgI2FicOAW14sPFrGq7jzjaBijluN+ygtf1blgfuu
	gd7GPcj/cGac5GxPzdr8u2I58jVKDrNbPWE8c+RGFmfNiBbYHUVI+8=
X-Google-Smtp-Source: AGHT+IGpUtzKURh5f5eNEdht+Fw3FifoSxUl0tHxuZWY/z6ZGb7OmyvobO6UGWMj43Uq8+koYYCVKrSUCM9X3xc1Gas=
X-Received: by 2002:a05:620a:17a8:b0:805:d2df:54b2 with SMTP id
 af79cd13be357-82b9be9cb55mr140912985a.6.1758015539317; Tue, 16 Sep 2025
 02:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-11-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-11-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 16 Sep 2025 11:38:22 +0200
X-Gm-Features: AS18NWDPNjOn1tpd4dh2PjA_D9sETIOVojzQySxiayXszkU2oRRijwgocF7cJt0
Message-ID: <CAG_fn=U-pYHi7R3Bq0zd_n7uzaw1vkL1RM=oyF1Or1Ovx_q1Tw@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] MAINTAINERS: add maintainer information for KFuzzTest
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Ethan Graham
<ethan.w.s.graham@gmail.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add myself as maintainer and Alexander Potapenko as reviewer for
> KFuzzTest.

This patch is missing your Signed-off-by: tag.

Otherwise:

Acked-by: Alexander Potapenko <glider@google.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef..14972e3e9d6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13641,6 +13641,14 @@ F:     include/linux/kfifo.h
>  F:     lib/kfifo.c
>  F:     samples/kfifo/
>
> +KFUZZTEST
> +M:  Ethan Graham <ethan.w.s.graham@gmail.com>
> +R:  Alexander Potapenko <glider@google.com>
> +F:  include/linux/kfuzztest.h
> +F:  lib/kfuzztest/
> +F:  Documentation/dev-tools/kfuzztest.rst
> +F:  tools/kfuzztest-bridge/
> +
>  KGDB / KDB /debug_core
>  M:     Jason Wessel <jason.wessel@windriver.com>
>  M:     Daniel Thompson <danielt@kernel.org>
> --
> 2.51.0.384.g4c02a37b29-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

