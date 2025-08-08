Return-Path: <linux-kernel+bounces-760177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DCB1E76B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AAE58443E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36544257AC7;
	Fri,  8 Aug 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1sl8ecE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EC1DC9B3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652953; cv=none; b=DqSUnqdgql3tbKgNuSFq8oyvM76rAPquzARBDUjhrZ18x9kl8WNWTAfa+8rp6xrq8jyISHrnXFLqSwz6LjeKsrl/9ieKFRCO6SjIp6THeqQ0vH0mjHUZZMs8cmJ0XSUYZX6P8p5V32wYNEzl8k1gn9CtCpufs5gW//GuwwbUVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652953; c=relaxed/simple;
	bh=QAD7rJU1Hc8HGnWSwBg44AH+u2lXTkldlX/xxRuByOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR0Mz7rq4Wc/3Cysm0oexyU0i/HvRplR5luk9PPWrSQp9R/z3tuZUf5ZkPcTYLrdWsmOJK4PWiICo9kvUHwH5h33w9u07NpfV5DgbQq4xwjF16b9dbq/E5gsCirlNPB21wH9zNIvoj/CIkYzWYVH3VstSduS/Jdk52hwgvbv8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1sl8ecE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so1847988a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754652952; x=1755257752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAD7rJU1Hc8HGnWSwBg44AH+u2lXTkldlX/xxRuByOQ=;
        b=c1sl8ecErTXv++RKLU+x9o5eFi7kMJbPzh+vkdBbWeMc0NKBBfNdeoblGjd/5ZDZll
         bal9k1uXhGf/yh1Ovzpbw7sbAwgWgNYhMRKp9SGucKgbm+Bpwnt9L7mmGiCSCmtjPQ5F
         twcu0ZLAzJLNVO0gdIfQrRkqyjsBGipP1Tk1hr1yFsLicDpTb/B9hFWQwMnFQoKiaTG2
         ypNiS3pC+ii7VIGpH58MgivK1AStE6rrfEv+fnXOf2FbbrEKDMoEC2/EGkRSpnhE241T
         fZqFcL0vNOoTQ8vlSkGE6xqgWMpKBM4BJ/d1K6a+MUA0nx9817OmkDQUVab9r9oDMg5Z
         OF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652952; x=1755257752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAD7rJU1Hc8HGnWSwBg44AH+u2lXTkldlX/xxRuByOQ=;
        b=vvJzVTfVVOeYhulbvfQagEK0mKDjUpqureFzg4ZqI8Qy39Isv2eNjs4u9PQh/RTZUZ
         AGNYDWse2CnBMjR0gmR6lpMR4Q+R9S3zJSyKklWqgHjn5S1jEy8tcrJOrZbim5XJfqmG
         ooI53WjQLvy2V1UTCn+aazjkkDupBaX03WdRs2p5nQBSyl6Av6RuFjEDhYRrk+nnHTHx
         qsuASvmTW0ouSWJgCXqqf6VtpYd3cWZAH0BlRcy2GCGp4Cx5+jmo7YoqPOyG5SOg6fMY
         8SqK3tbPaU7C28xxhFoeqYhpykgjZyVGzV2SgJ6nmO1J7oI5RwWZEV5o2vB3z3E7jbY5
         SW+g==
X-Forwarded-Encrypted: i=1; AJvYcCX8f4GhLN9BiTcZX4ZkBQ9rV8tJt4q9tOfBIwfM2k62zvhjJEeM7kCP4msrXJ9+cE2cv/76kY0L5jX722g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHIcL9OuslFhW8/39IupI33JGPbj6SugE95A80sFyoyE2USGR
	32Bx2zc5FkhWhzwcSbZIFoIOjau8oSu85D+90CkPc86Wg1A0qddKUOq43eFoIZvKd3jVZmSbt3H
	IR4aA8Uve5e0YqDzXFXGLicKA+N1Z+Lc=
X-Gm-Gg: ASbGncvDNVY6RMhjXvO3JfULInPNd6VJ+I1ICN9tfWCQFj97fwSpBq+RgVvu5gPs17z
	gKnn6C/8ou4JpXrY3mDgjja4u685pND2vlxl3KBJeoJPNkXwWM3w5iNSyk5ELWIESXGzCLmZs3I
	zs8JLEnIfmzaM3v2L9UwUPJYyxHyxgWy24Mt6RSc2VnC0rCY/B6XLHgJHTQvIbnh0AZL2bhD/cV
	nf2Bg==
X-Google-Smtp-Source: AGHT+IFibUzuC7PIMW/b88XLYM4lA4IZIvE07obnrmykoxG7aOzC/f26bPAO9bOvz6u6YkO34Qzy2p0xSx5Dcssnks8=
X-Received: by 2002:a17:90b:498d:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-321839c8d3cmr4280632a91.4.1754652951490; Fri, 08 Aug 2025
 04:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808095503.906244-1-linchengming884@gmail.com>
 <20250808095503.906244-2-linchengming884@gmail.com> <878qjuazlp.fsf@bootlin.com>
In-Reply-To: <878qjuazlp.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 8 Aug 2025 19:35:41 +0800
X-Gm-Features: Ac12FXzyy70S3yo1kqO-v8rEt6fo-e6sv9cx2MGOgokOTOEyG07YDGEgi4eJQss
Message-ID: <CAAyq3SYHchAXb6_jOsCs_R_iCboAQq6jBpbLmF4_7uGzME=+iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add support for randomizer
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=88=
8=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:15=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng Ming,
>
> On 08/08/2025 at 17:55:02 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add randomizer operation support for user data scrambling.
> >
> > For more high-reliability concern, if subpage write not available with
> > hardware ECC and then to enable randomizer is recommended by default.
>
> Could we adopt a helper that allows to enable and disable the
> randomizer?

I understand the idea, but from the flash=E2=80=99s perspective, once the
randomizer is enabled, it=E2=80=99s generally not intended to be disabled. =
So I
feel that providing a disable option might not be meaningful in this
case.

>
> I have no use case in mind right now, but I feel like it would be a
> better approach.
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

