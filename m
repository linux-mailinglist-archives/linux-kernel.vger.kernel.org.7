Return-Path: <linux-kernel+bounces-824052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB2B88037
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B30566E64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB52BF000;
	Fri, 19 Sep 2025 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gsnpztdn"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760362BE7A7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264216; cv=none; b=TaPYoSlvJwlAsAjl+M0RhkuIQSz7RjpHD53JUcpIO+wtMBFAdIRS86v8PZB9MFdi6R+v9A7szQu/C3i9M/Ib+xeZFtDeQ74x2J71V/R+bO3AxN2KKC2PSNO3WP99rF5fjpnkCq75jbWGmAKU1VVlCpfHqtJv/3lrY+ZDp0pgmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264216; c=relaxed/simple;
	bh=pDgMPvbCzBgKsjWeQYiQdKAYD9d5aE0jVaYl4nco+5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV7jtKzel09AOXdSR3iT0PjNo3exO4n4i5HwgKPcdkCWPmbEnpaT7NQX66Pe+buH3qx4ABXP740VzYspSBeftFx7sVy6gnCoV5OgG3OdfNL4FoZDtaTIlgXlAoyiz2Th4JzdunniP1XZ6/opiiL648/005dPhPsR2g0uOcI+1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gsnpztdn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b58b1b17d7so18636701cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758264213; x=1758869013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDgMPvbCzBgKsjWeQYiQdKAYD9d5aE0jVaYl4nco+5I=;
        b=gsnpztdn4LjvC0gnI9lbp1MZliG9mR3r7ln+aRwhcORX/AXiDXdxql5gPLmoo68dYU
         LLtOk++9Qk223ICoBQNxFYuD3tpZtmQbl5TdynYhiJDicepn8XjU/mAob0/Y5wL3MItX
         aFT2n+FL95UIBPsokjAxEosWtTsD7TdqJNXkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264213; x=1758869013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDgMPvbCzBgKsjWeQYiQdKAYD9d5aE0jVaYl4nco+5I=;
        b=FNU4LCqI5U+T8Stn2EIP33/TB4uNKgtv7L8r/rZFmrNkdIq7DTCEq3neCP08b6YegG
         p1sHpa+VtIpWi7lbJDiSTkI+5p1YIGdEuuuLTcLWf490WQHQqxJIESa+BzQDkjpFJ7nz
         AfRsLj4CnGtpL6u1E73zbBTOWFhYPTa2mEh6Nb82vdcgNE6tDFUHHQTwdo5GTI0sr4Yb
         4CkijgnTAMhg1Y/68DcK8L0s15m7AtsyFTbQQa3gtzlqSkt3+yU/B8wEBt5Iker9HLQc
         X1tC316RfpmGSHtWsc6osz91/MCrtgyOhY0EJ3BL6tE5WhnmUauDDZ5le4uJ7vx9HM4O
         yIEA==
X-Forwarded-Encrypted: i=1; AJvYcCW9vW7c1o/h1lFTcfmsQbo9ICQ/1hkA8GSE5e9D47u4bGjnEcd4tMEPROpJTXeivWx27MxbAhGIw1OaoY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6fI3ZrC+MVcTP+PBt0K/qHA/uMQgtUGnB2YrHsyOT1jw3eWAg
	BTGScQTWjtC+E5NmwXAOpMB8o3ruXpTqo3IEwacRR6sbE9AoPCey+SAxaOqxpMGuJxfCEw31MiM
	8FSsEtFiqUtFtoooeelewUQ44xEyKBo3l+c+vr/i4BA==
X-Gm-Gg: ASbGncss3SoXfbvs8Yx18PdDozWlQ80c8V5mU3AVhRzBNL6aELDmE/Xt31OcUqa2ihM
	y8FZ2l9noRo/Sq8CyNpY8+0NEVVu2MOmWPzDBrPyQ1nck5ZU1ieKvv+jHvgEwRe7F36u57v9n9Z
	m6q2J3wUL29L+pb5ofMLpBTQOscP/WUSGbrQ73ZnbzfOayR4Tpich1WCfuUI/bHDeHjY32Ppvxa
	Xkq03S9kt3mGPLGIpLW1RBmeTEu2zvrRIT3tNc=
X-Google-Smtp-Source: AGHT+IH7BmIHFoa4YKFToivU6LzwYyiK+VHId3cOW37POfKDqGjZItF4zx64vHCHnzeA5DMrgfu5eC0R1Cl4cF0NcpQ=
X-Received: by 2002:a05:622a:349:b0:4b7:ad20:9393 with SMTP id
 d75a77b69052e-4c03c19445bmr29714311cf.4.1758264213118; Thu, 18 Sep 2025
 23:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917205533.214336-1-mssola@mssola.com>
In-Reply-To: <20250917205533.214336-1-mssola@mssola.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 08:43:22 +0200
X-Gm-Features: AS18NWA2eZxV5MToWOOu4fgYvuODb16v-isLriffr0OTySzPgyVq7D5IBxmpe30
Message-ID: <CAJfpegvt8ydN0uKYpbWVAmzZtHJ2kg3PwffZYvB33G_4fnq7BQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: Use strscpy instead of strcpy
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sept 2025 at 22:55, Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.=
com> wrote:
>
> As pointed out in [1], strcpy() is deprecated in favor of
> strscpy().
>
> Furthermore, the length of the name to be copied is well known at this
> point since we are going to move the pointer by that much on the next
> line. Hence, it's safe to assume 'namelen' for the length of the string
> to be copied.

By "length of a string" usually the number of non-null chars is meant
(i.e. strlen(str)).

So the variable 'namelen' is confusingly named, a better one would be names=
ize.

>
> [1] KSPP#88

I don't understand this notation.

Patch itself looks good.

Thanks,
Miklos

