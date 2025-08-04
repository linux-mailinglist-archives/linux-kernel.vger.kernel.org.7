Return-Path: <linux-kernel+bounces-755036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDEBB1A068
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54CA3BE3DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C881424677E;
	Mon,  4 Aug 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwbzrV9r"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65915DBC1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306418; cv=none; b=lnMjMgaQ/KtL5tprDuFRf8k+BbW7gakK3TxeJz0o1gE5AiQsLu8CfvkkyL1BVbJ7obFc9n/upg06PPNVGbqI3aZ4pqA6mY1ilvVRsujGbU1mZ0QAWiLHUapZdsB/7rZX6GnWDeDbbDS+0g1P26Hw09OTKCcNB4GyW3Z48XnmPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306418; c=relaxed/simple;
	bh=0VWKHdm3BiWuqBGROS/u5ljJ7Xcg9yt975579aFM8/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqW3bRQ5lXgC3OnDiRvNN/Mdco5nqOC85/de8DHp+g3kNuA+lhQEAe/7JmNkEzMK+Rk2GHVSRNrlOzo0hyrfYEl8UEgX9854zxzi1kmaixEKHOjkjHyAyxUWsY6VjBTuLXs9Wzbz5J9SNTmDjLtBMMIQK5DtioPQHkFNwam+a3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwbzrV9r; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6197e7d225bso1074988eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754306415; x=1754911215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b93u56+uTgiRFAxnBL7fM25U7aghKeWgPbDUdKcg554=;
        b=pwbzrV9rnXfcTSWwYekBS0zWqVhG6wu4T+EnBzHBPgz444u6+vRb6rvL+N+CFJoUDc
         d7CnqhsckB4+kWJMP9Hg9s3xs41sIVYMY/pgl6tcvSngS6J3jc0DaHEEItEgxqgBUFdJ
         RT32AK0UVzSCn4nuazdO9SGn5OhN89oLNeIXLV9Imn/P//gv6mJNlYs0rdairDVkYKjw
         uBdjl+5TcNmHJzocOgcQhCOTB5mf+0YW2waj5Y1OgUa1Z8Eav9gX+SHwZ1TcwyEeRNey
         hIQmvGcWqqvQ6dcnLhTx+GgcizssmrnyooOjNnbqXCeM41I7LI6ewTmaRzopd5YN1Ef8
         9NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306415; x=1754911215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b93u56+uTgiRFAxnBL7fM25U7aghKeWgPbDUdKcg554=;
        b=pWJJYMghSXDPU+HFAjKuZbMVbGwc2ZwupvSx77Ya+MxlkfZjYDGI2huuzIoJonq8/5
         lpSXxoshnLfIKvyXuFjXItcWkPUivtozKjaDR4bbQrdgSjeExoBEz5a00ALmi3qG8Bog
         Z4dyz3lt3TP5VgAiTz3MH3nyxMjlMrp6ztvHogdS1u0Pi9+lzwQy0QpVicBeEIZYDa6g
         qC5R4WAW/UyWAzlTiZpLvvtxWko1sYvPkyDvIgMFmkLeJucLbwQH/NJ97U3BFfX6gA73
         oWOFP8tTZf3jEJ1lbMWKHab1yyGmRItz5QtlLy47/vfNsbP0chXTOmHfeCt8Gh6gDXfZ
         O9/w==
X-Forwarded-Encrypted: i=1; AJvYcCXS0/kzB7DvGPe6fqZTCG/dd9sTjYHmZ9nkdwnvOSd6NA5rQqUAZFhxXzNAAGVIRWwzT1uDcWXAI0kO+Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiF1SxRzEPsItGUfT4dMeABnOQAMyc9KWUsr2UPcVqUeyof0J
	q3Vjq3wwYqmDKgX+xDig1Mk+10e09PDAPhGdOutftStw3p2CJJFrrsUBL46+Ufipaqw7cnOzAil
	VT1nkDlM5XbpRpW7k+FP9BBk0Sh3BRAfctk1Y/W5hOg==
X-Gm-Gg: ASbGncvN3fkh1Spp9fyakR8yQG8trpGOD1bsinvGTFczXPzhvUmozeeRwqrXM+THQ3h
	gwCB+fsqn6CX85k0u8YnIFKS8gAuGYbCHxxCGnUh9Bva2+7pYGNS83KNjXf7yKp0enRnzlXEv0J
	uz9EJAqggQZN/OvperBx6ftjEd0Yr78qlkZZboT9O3Yez1BgkxTTdh+OXtOSLiMcX7u7VTxKivw
	eaaDGPDFatgUWtCJhY=
X-Google-Smtp-Source: AGHT+IF1oQvSmC0DUw3ocA0Ng4DtG7XWJo3uEaTvvjJ9MizE2sKgbMBq3d8pzwjFzhJxVfr4akPhyv+PF3cPJSGc4jU=
X-Received: by 2002:a05:6820:1e88:b0:619:a040:a61b with SMTP id
 006d021491bc7-619a040a962mr2538659eaf.8.1754306415477; Mon, 04 Aug 2025
 04:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in> <aH4c-bAN28Gmq86k@sumit-X1>
In-Reply-To: <aH4c-bAN28Gmq86k@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Aug 2025 13:20:04 +0200
X-Gm-Features: Ac12FXx1HcFo7kDJkLn1QiDBQXxv6qeoFbharkQhwFLpksbuBhKbTIPEmdzB5tk
Message-ID: <CAHUa44Eht8TK52tH6WPwnEhLGR_aBB-UySnsPLf=+iD3qQqe_g@mail.gmail.com>
Subject: Re: [PATCH] drivers: tee: improve sysfs interface by using sysfs_emit()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 12:57=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Fri, Jul 18, 2025 at 09:00:13PM +0530, Akhilesh Patil wrote:
> > Replace scnprintf() with sysfs_emit() while formatting buffer that is
> > passed to userspace as per the recommendation in
> > Documentation/filesystems/sysfs.rst. sysfs _show() callbacks should use
> > sysfs_emit() or sysfs_emit_at() while returning values to the userspace=
.
> > This change does not impact functionality, but aligns with sysfs
> > interface usage guidelines for the tee driver.
> >
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > ---
> >  drivers/tee/optee/core.c | 2 +-
> >  drivers/tee/tee_core.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Nice catch.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this for v6.17.

Cheers,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index c75fddc83576..ce44e3498d37 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device =
*dev,
> >       else
> >               s =3D "user";
> >
> > -     return scnprintf(buf, PAGE_SIZE, "%s\n", s);
> > +     return sysfs_emit(buf, "%s\n", s);
> >  }
> >  static DEVICE_ATTR_RO(rpmb_routing_model);
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index acc7998758ad..944f913f8592 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -977,7 +977,7 @@ static ssize_t implementation_id_show(struct device=
 *dev,
> >       struct tee_ioctl_version_data vers;
> >
> >       teedev->desc->ops->get_version(teedev, &vers);
> > -     return scnprintf(buf, PAGE_SIZE, "%d\n", vers.impl_id);
> > +     return sysfs_emit(buf, "%d\n", vers.impl_id);
> >  }
> >  static DEVICE_ATTR_RO(implementation_id);
> >
> > --
> > 2.34.1
> >

