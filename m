Return-Path: <linux-kernel+bounces-773729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D65B2A7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8429A561048
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F9335BC5;
	Mon, 18 Aug 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu9gSNTN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42CA93D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524962; cv=none; b=YbKWf/GHWi9TE5LZRQzZyUQvGL+sOdFPvAJ91ApEU5axwa9vMX1FfO3GPQwMzq8xuOotEbqp2fKFxF8+vclJUKfeFyQ+C4SmJABrLOpykR9gvyBF1MzvdSSx3jkwr2W3TV/mllCjYyg1bgecpAvmndWoof/GwXrd1l8NCJ/pSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524962; c=relaxed/simple;
	bh=2nQR7o/uliH7EaFyztVsvri9UEqQg8d/0CLadaitBw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3prQj446zcuuJeuS+drRD/BwrXoRX451aU6L7e3S2MrkRgOd+EyIzhyaYOYeE5lf6cTJ2+zmtzoYDGcOiDoUj56kzFEn1/4A6xSHt3rnB93zNA5u6w+Cs6/12Fj3+EndNBuZVPdQfO3ZLn3ph0jL//H4XliAGHKOmLGqKuPF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu9gSNTN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244580536efso28415685ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755524960; x=1756129760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlgJL0tyh7FscLdsZMa4hvUraRt5/GA6QxyagwOWsnA=;
        b=Hu9gSNTNP+U2KFQiRGTyTBiFMf+JCxX73i6K37BRgP1wTMpz6XBb02huheI1RkgeSk
         flz57EmL42AkGeSEU+/BacTJIZusj/1TlCZRd/8syyUvj6k896jFwtz+RPZmE1hsxqEq
         aAxbgO+Ez3OMEgUHm2SziyHaOFFe19XPCvoMZEIjOqpwc3Wvg2uMWho76aJrdIyL+W/X
         cPO8tuVCy8SNgDFxVKHx5sAmLp80HHKmE+F5hvvrGokSD9pAC2I+UfgGNyMOeq+gxRtG
         X0O/4uXAa1OBTlYHb5Fl3GE4LghAAZry1DJ59Qr9Woi1HyzhjJXvwbCpvEaBRzO6oabJ
         t2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524960; x=1756129760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlgJL0tyh7FscLdsZMa4hvUraRt5/GA6QxyagwOWsnA=;
        b=ghtCVd4WTui3FomBr4ySnOIYC9O/ZZ0ckSpLO8n4fWYj3JK5PrY35LNcflZlkXYylO
         9mrllYyVndeH8w8yFTgEDrvwhHt6oyEvz616Sy4u5eRf5AoS9j/LuSvFbHQYgw6T3+G5
         /IyNYwR2Hq2DrPuvsH08brBX17tQGswkJE3vxHTBvKvSSB1qD7y7yKdJrFXfKcsYflYY
         rW8W8rQK5q3VSWlLsH4FDokCM/lFj0bGFYWYO/PgWk9xLduy8MAjhstwjSJEhKn/3Awc
         OuymY/d3Nx+5BfuruX+6I6qy73ozcis+1UrqJmWAF4nADVa2kwcRYkTBjnYe3cnV1AMc
         7e7A==
X-Forwarded-Encrypted: i=1; AJvYcCU5ncLesU4b4fDL4jwDwqFq3ZxBwR74DYfLhEfSBcHiuTAoXqvyQoGKbDf3ZOxpwjntkfbHlrxQdM5xIo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2B78YP8z94IeEt2A5AsU2IcReSeohSLqH4lVgxAh6WCXpFQOP
	3IcoSH5XUhhlF7xCtxdP6/r88KnhIRCzhM9JbOf2oqcs86Db1hqetJZ12ayQj3jDvxFkumllIQn
	NWSZwVdZqj7njaOX/jLyR2d4yWr7wCpY=
X-Gm-Gg: ASbGncuhSoRx9PfUdTEh7KxzE0jG7xgtS0PUqZ8A1JltFdZJqWn0ifySiW9LlO01yXC
	0GJmNjboL4gpmqeT9tNQ/xIg4k+aPr9VaiDICM0RKDKpX7WXZhs7Z2CYrl/qkJmjC0h3vrbqcDm
	Q0HDC85G3S9T9CDtc9WOA3V1xlWiIf5nYu9Btj18F7MwlhtYWnaTxhpdiI7yxntLdaifzrv2vk5
	9YGjg==
X-Google-Smtp-Source: AGHT+IEh6PAqvkpw9OZzEtMd/NSgsisJDwtyGqVUx+6Vdt3WvoMhOra/FleqhAWxl6JtXmwlSvWp5H4mu0H+ceKvjKM=
X-Received: by 2002:a17:903:291:b0:242:fc4f:9fe3 with SMTP id
 d9443c01a7336-24478f72ec5mr114593685ad.37.1755524960059; Mon, 18 Aug 2025
 06:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817081238.44785-1-rongqianfeng@vivo.com>
In-Reply-To: <20250817081238.44785-1-rongqianfeng@vivo.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 18 Aug 2025 15:49:07 +0200
X-Gm-Features: Ac12FXyoDjH7XDbWz_6LjBR_vJqC6uFHVGd33eUA12DcLLPINNdW-HOpU0Ig-W4
Message-ID: <CAFLxGvy0c=Ja6WBmpmCmqKMpe-AX5n3xMpuFiKz3JWOanrLqvA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: vmalloc(array_size()) -> vmalloc_array()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 10:12=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> Remove array_size() calls and replace vmalloc() with vmalloc_array() in
> ubifs_create_dflt_lpt()/lpt_init_rd()/lpt_init_wr(). vmalloc_array() is
> optimized better, resulting in less instructions being used [1].
>
> [1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vi=
vo.com/
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  fs/ubifs/lpt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Makes sense. Do you want me to carry this through the ubifs tree or do you =
have
a distinct tree with all your vmalloc_array() patches?

--=20
Thanks,
//richard

