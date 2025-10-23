Return-Path: <linux-kernel+bounces-866756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710ABC00936
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41063A49BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CD30AD1D;
	Thu, 23 Oct 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNQZ+/yO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2830ACEC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216704; cv=none; b=CpHTXGv3IQbiiUVvkhBH6EXbR6/ISSCfl0euM8DXeZkbqKiPuHrIwGB+reD+i54yMo/wGKkbIDUxkpobG2feGa26f27DjCZp36PKw0GrJMipHZSjA5/bVzBkSELS05qtVYP+FygawWqBPnKIArJD7GwJZNDsTey+WmIOyoq6RcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216704; c=relaxed/simple;
	bh=9nOGCAjhfRW/rA97w2j13qaEfOW0Utgue9GQrZT+8Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lx28KnspKBKitqQhARd3p2BQ+9D3xvdmTIm5xPOeLGHSPMOjD6GVBRC+D1gj9Kfg8eJe0ectTypYhD584Gv/K974nxWN/aVP9THa0RBFyzsFrJFgq7ya9UH4MHtWP9ggttARoieXlicNbP9CK2T1AEQLMHuc5cd+KAuyJEPJcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNQZ+/yO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee130237a8so398897f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216700; x=1761821500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nOGCAjhfRW/rA97w2j13qaEfOW0Utgue9GQrZT+8Kg=;
        b=HNQZ+/yO7YKkbzyMJSOt/vxKPskV5m1iW3CZ7Pnx2E+q3B36bJqiSf9KpWNpKKvNdF
         SNkubrLefH5sFJHYvz/zRcseYfTYaVNkE5OpSCzNUCV01rdg6ZX0XUXB2BHP3zy4rZcH
         vl3gL/1sl7SGH1FJBKEI25FEHVtefoPf4vD2/xFQ4QR5hSEyY52SbcUJbGQtEzExPr5C
         U8T/wse8NzoTi5P11gSsFY3LzLAem0ZR5vaemqx4Qyf1+KYftNQdb6rvw4nyFZEEizPo
         axrD+XCAOSoxV2hg4qfjyr7WF9JwA7GvDUdsiDzRuWl7hDEmSvSqeJoOP/PQ/jqO753f
         ePIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216700; x=1761821500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nOGCAjhfRW/rA97w2j13qaEfOW0Utgue9GQrZT+8Kg=;
        b=dbBICha/K4I3I637FZ/vqDkgx78oG5sdAut1Yec8ngCcb9p6wAfnDPCLOtYIcKu6Gy
         rx4wxc2mNeczt1FtLgNKTS+gwKjqtuUyUGAl8hHRGCh56imbPJfk9GEwD5JYS6AV3ouc
         sX/cA3pZN2fcKp56X3P8wZVSFMm/Sq07InoGu5cVN8LKfFll92f5q5c/tYAkLHuVttJ/
         3p51Dumyp6i8F796AqUzkKzezz7SsrCUccyjRO9YNBOSqoOh74wBnKbZECQy9kNw2aG3
         cvS8C6nff4RBVorc2dzkDz/kcPmLRLGzIKRsBPlMQKgmT83i9kPlXhEAYKdAok02rWRy
         NP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV4g2N2pYQ4abHnVgzPHyyr1UC9V2AtBfPATIObsE1KiL84PWzZLjKMgsH/rDatXOqJEYcMoFURojwXOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHay9nTi9n2hid6zNF7huwihY97g2L/auNva3OJzshczzjYc2
	WtgIuSt6CtwsXh4m764KM6mbE2ZGd8x/EkTErzhmosOotm+SdKR3VdCMsSsIOONcyaprhpK7hl6
	qqI82fCXS6fIE4ARRtVY574hLrNW+qiA=
X-Gm-Gg: ASbGncv+PEVNeHsAPncLadbFa2rCxXKbt4Ojg5kZ/LNaZrL3Pgol4tc58j+xQyvpYLv
	4nps1BKwC/A8A64lTn1n8fbnPImkFhznPyEZCFi5zwXe/Hm1BStwAEAGeJCTsqkD5qf+QbqKZUL
	s2TF18u3AyyQq06TqMjK/tGRlfj/4nYCtF8vHqwlV1B2Inyv35vH1sD+n6U4xLDYCh3f4dr3UKW
	p6AJ+k580qlZJo2bLzF+VRlilNhRhUHyd8giEFOzm6nZgAVXYV2difL4rwKQMOMjC3D3XNL
X-Google-Smtp-Source: AGHT+IGc8Zr6ZHZk/XnNfwwGlbXUYEVek6pmNdJwArcHATOCBwaP/Zs6qyLU5fsWQ9q90QkFzK1qEyjmZ0EWfb2kxIM=
X-Received: by 2002:a05:6000:4606:b0:427:608:c64d with SMTP id
 ffacd0b85a97d-4270608c806mr14232913f8f.37.1761216700403; Thu, 23 Oct 2025
 03:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251017151830.171062-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251022181303.3dc4f41c@kernel.org>
In-Reply-To: <20251022181303.3dc4f41c@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Oct 2025 11:51:14 +0100
X-Gm-Features: AWmQ_blhVXyZRFlAYOOFzj40YpCvwBsR9vUPd4CfvpYi-qsCy1xcznimtCK82Dw
Message-ID: <CA+V-a8uMpr+-F6gQZ+y6wrSUfV5BXV_xDaZcLVnwdpiw8g5W5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: ravb: Make DBAT entry count configurable per-SoC
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thank you for the review.

On Thu, Oct 23, 2025 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Oct 2025 16:18:27 +0100 Prabhakar wrote:
> > The number of CDARq (Current Descriptor Address Register) registers is =
not
> > fixed to 22 across all SoC variants. For example, the GBETH implementat=
ion
> > uses only two entries. Hardcoding the value leads to incorrect resource
> > allocation on such platforms.
>
> What is the user-visible problem? "Incorrect resource allocation" could
> mean anything from slight waste of system memory to the device falling
> over.
>
> If it's the former this is not a fix..
>
Ok, I'll drop the fixes and cc to stable and send it for net-next.

Cheers,
Prabhakar

