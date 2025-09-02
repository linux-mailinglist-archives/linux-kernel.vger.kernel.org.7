Return-Path: <linux-kernel+bounces-796404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE7B40063
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72791545AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264313002BC;
	Tue,  2 Sep 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzLvHWK1"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EA2FFDF7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815500; cv=none; b=p2Tm4DLkDdXml/dlf0yW2vZnCb0/TqAwWujazG0Rkyu/w5d6RAhtJIv4WCj/Vb5WqhroBJIysIKQ5p9xvakHXP6vP9odYTYkfBzmAAZ6HHpc8h3aFZdzNQF/SGZWZJnRAScIMHXQeBW+ejJUmN5kEuK6AzFc79SZQx1Ny7tpZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815500; c=relaxed/simple;
	bh=NTUciYP4qkVSP3Ids2cPJKg/b3yW1qYXyRE6W2+YvyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5WYduAFiZs0IhxuBwqYkdj6Dq2mGqobfBT7ptaU8HI9ksfksnPC9r9h5r3wZNgXBQqg6i8No0FaMgzCgUD0bH0+mfe/Gr36T2AAeEl11R4ohgq37ZdzzA1a6fvHilnKr0L9OTpP5uoIDMcOLTNO3L+yIS/gT/JI0p7yeAzdpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzLvHWK1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b38d47fa9dso1016681cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756815496; x=1757420296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BtHVQVngraHXwyztIS7rS2FP0vL/znas/2GvCizYvA=;
        b=PzLvHWK1Pbj6WlpmabFlATKlg//2jKQcWFwDO4mh/b2dlSdxKBjbpmonyVzeAuJ7rI
         VQWlfOtS0GKss+npbDB/bsePPacjgaKOmF6ls2gWRa834PXhpzBGVXMhE68Zj9WgQhdM
         St1lWOqyJKaGhZ93OcLYJvivxqHKuHpFwRGNvBOqTUtmrJqayUOEGitfkU6Z+fOKcs2R
         3+60MEz6IvqSvXCJSPmVkx5Iu/RYKeAgAKI3/qTAVKQxSCw6Lp8wDVcZ3iasJQMAEC+Y
         iudGaxk5lAA7bQTYgN8oumhoWT59votstdkrd4PXS2uAjZ4KQVrMlEW08bKqV9A5pdap
         kEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815496; x=1757420296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BtHVQVngraHXwyztIS7rS2FP0vL/znas/2GvCizYvA=;
        b=K3pqYE3dr9K/bKcN9gh1x2e4y6FQlR3lVqFQyFDjmHUdqL0F50mXIMl3NLOO1tbZq7
         kXgfJUrNfbdhJhst3OHxS5FzCu5Zpb8Up6lhwM9eY/MWYC20B+Y0fdJBnb2/4Fn36WXB
         TFKSfSmJgcSjjautWjyba/f8VbYq4j0Oy4aynrYtuA1Zkdp3UH8qPkdVs83YHbNJaUJc
         LQdzXK2aSvMG2qxCSAf/EuacDTj8VOQAToKaI14sa1MO8htxX0xbroA3H3FthaImZvKf
         ON41bax6/0RpQ49e+vM4pYbcquNc4GrpjarV0dMDkYv0WzgMy/0+fG6vrOIpVp+MNzXC
         Byyg==
X-Forwarded-Encrypted: i=1; AJvYcCVJJVX7pHLfLfy8KrXlrT5gLAjm+hZ5AkahCy+YZJr61HUEiky93gXGileesMeD6PtqLAAgjEYgwkDLrJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4GpSKGpk2UIBtT11BTB3FZOCUQoRzLRbeJapqlGXHAAsNn9A
	k75LiiDHIKNMxtN4XpBjOIk2bEcLZeTuL/AKqVoe3Ia6nzXxyvop2xI6f9Ki4nX9GKcBxpzpT2w
	u9yxSzOXD//qKAyX6kAqGU4q2/pXLFKwK2ccElwSK
X-Gm-Gg: ASbGnctq+jK9jLwDLF4Fh0bxVXHyQuj8HFjBOmoLBpio6oK40oKp4OCt7P9t/yM3DS6
	tRYKZs/vyZVa3Ck7synmYsP/5YFtJ2bmzT6TG1mNKV3wzKkxVirFudzsCJWErW2+UcCBS0ekmEm
	cbjYiTLs2IfnbXC8N4umdl+rmGCkr+eOMyajrFk779SJe/uZy/k624L8BSHa78a7mbc+by1Byg0
	rXJ+M83xwsfhQ==
X-Google-Smtp-Source: AGHT+IH5vzEO1QHxkAoblS7kriJ2318EF1KTzHsAZLiCGeoig9qB+yVEkkECgxfzHSgXCz6G9dwSrH92f7veZprPEl4=
X-Received: by 2002:a05:622a:5b09:b0:4b3:140c:ef9d with SMTP id
 d75a77b69052e-4b31d844993mr129778201cf.17.1756815495331; Tue, 02 Sep 2025
 05:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLaQWL9NguWmeM1i@stanley.mountain>
In-Reply-To: <aLaQWL9NguWmeM1i@stanley.mountain>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 05:18:03 -0700
X-Gm-Features: Ac12FXwI4CvJS6_vLUukiLiLi6nGCSauJpahGMDDKoEk8R4QGC_U6PfE1GF1EBA
Message-ID: <CANn89iK9FBmqC78Fn95Aa99+TA128xXSvSsLe408zkk1DG2Ojg@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:36=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The inetdev_init() function never returns NULL.  Check for error
> pointers instead.
>
> Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

