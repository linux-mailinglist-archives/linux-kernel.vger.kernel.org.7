Return-Path: <linux-kernel+bounces-773235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61948B29CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9818C3BBE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA53009C8;
	Mon, 18 Aug 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEfqujXp"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA629D27A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507707; cv=none; b=nUJZBfEapFJ2YcA8vyXTdtINj8qtMrBEChzaGOyJSlz9Zxt405d7Tloy8Wg9TSN6LGxJAqPJUfB4Ctzq5voLtFK7cwEPkIetQVgKWA+1emnzuIm3ioTXtCBgMeK5omCNyzCTIAp9sJcHHjJz8Mq9Jzl1D3hJGzVV8iCrGGvA0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507707; c=relaxed/simple;
	bh=EBmIGqr9okzPx2vGqCpS7J+AzgDqHAdhPp3xjnLfU28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auLQqspnnByFmDFnx5VpcL7g9vQ6BRLLIOA3lt01rv8iDa63s8tGaEJGr9lR/1T/8EHjHwE2uIsV6rTzkeZaKlIk/aKwJ/qMLgPXQSUyamGwCd9KLmPByhR91Y5opLISLsRtAjIexVBKvU8YL61PuJX7sPzPG9I1fwRiIRFBLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEfqujXp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4717390ad7so2602286a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755507705; x=1756112505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcTOinIlKkgzYvoZaHWXm+nnbinthSn1xXH8lpBhhbM=;
        b=UEfqujXpCfV9pwsqBf5wGzfwnax65OEzQuEijMDCQdutQ4j6o/8Hd8KVe5GON2/kUa
         zZDVkLVH7urHjL9zF6DPb87vfodNGEwslpsQ8ArFApga3aHQuGXUpC4iLM07AjboKQHi
         96OkwmjuFkCb/TouH4mSKSdbgBzZlC2vXviKR/kvUC5Q62EskSf6gnrbYghNLIwlj5Wl
         z3CRIbmrdQY67/zIcAdcS0X5iPxKHZpUnv/2xU00+JY+FenExmOILAvg16daIWNINRyW
         f6ROiBtUNWOpNTlXqXYOhbVYYC/b+0ALsgTyOjni0DbN/RSRkYyJh9h6SOlC2L4F9fyI
         3nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507705; x=1756112505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcTOinIlKkgzYvoZaHWXm+nnbinthSn1xXH8lpBhhbM=;
        b=R8EBvoEeu0MNMpfimb5JQuwPRVxtj0oKP2GoHZKnJX+VLqli7zChkpvrZ/fPRbm9mb
         fw2RnQzocKuH+jM9S+wu7W/DNFBkGubfP2OkyjSj8hwTCwrkxlSE/Zo52n3a1DWrp1cP
         SKeuVjhT7z3jzpBwN6YAEJTfuHohOTuCcEYtbYRKbliNGxqdB16LKIT5OK1SaSJ58MCH
         BkrdgJmYHQTaR+JiWO9IUfMUd7UngV8+iJ2wO4Vkgzk/E74RSH5urXDcgRpib0NODIBL
         JCCAS05BZbC8p7+XLc3IXb8W7KG+O20MrrSDP1MkRU669BKQPigedWhqQdXvkYyN+lQi
         K48Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvmpMJ8uYNSYQChzQMKMQleD0AKMq00ocsyGSzmRHCD3EX98CvYTn71+MQmPVYRT6tR/DPxK1KOCJQkuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTO4I6O1E7WTjNCgM7xo6F9JlfOcyImDwmJ3Tuf5cdT390hKSR
	xbNqxElvNA8h4wUva9JGBTa0qePVUCwXL/qfDiH7Gm82kKyEphqKDODUMQfuAOhvCVu/c3T7Jb9
	slEccmZBAMh0638kgPtvRcVsaXtJO5A0=
X-Gm-Gg: ASbGncvjXu+r/GC/4jR5+Suh2uNxOmFxYgZs/XasC//BLyKH6WxrDk6F+o0UErtBfzO
	At2Z2ktmoqlbhv3cHTzjsmIxuAq9oSQZnTMJPJP6Xco2rBw3P8wV4TWNzVLOHniarSqncDsEqwz
	dt2Etj716xApiGWNIwGYMnR9U/ZaJ7DdZYVTdKR2OxQek96PZyY+ElTB+pHTeHiiL9vv2T7LuaR
	FwWwA==
X-Google-Smtp-Source: AGHT+IHFiMvOj6zE4tw13IbbqMhK1S0rP2Re6EX64vcHvfnbK+PVm/hE+V+4Pgpj6IMVJbdklE9XRrAj8pwnH4P5Dbo=
X-Received: by 2002:a17:903:b07:b0:23d:fa76:5c3b with SMTP id
 d9443c01a7336-2446d745130mr162855865ad.22.1755507705452; Mon, 18 Aug 2025
 02:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818164635573BQolnx5DcBqRicqxF0DMl@zte.com.cn>
In-Reply-To: <20250818164635573BQolnx5DcBqRicqxF0DMl@zte.com.cn>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 18 Aug 2025 11:01:32 +0200
X-Gm-Features: Ac12FXy4yBxw9ty29Vpw3cXzgph1ImGW6cgDm4IopFR2nOck3AfRDA4sfwW0U_k
Message-ID: <CAFLxGvz-NnCRYXrn59Gh9EYnoBTAQ-5LBN=1=MQN=Yz3iEQsTw@mail.gmail.com>
Subject: Re: [PATCH] ubifs: address bit flips in unused free space
To: shao.mingyin@zte.com.cn
Cc: chengzhihao1@huawei.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, 
	yang.tao172@zte.com.cn, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:46=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> When the recovery detects a free space bit flip, the UBIFS mount fails,
> rendering the UBIFS unusable. This issue can be addressed by reclaiming
> the affected erase block, which involves relocating its valid data. So
> attempting to fix free space bit flip during recovery reduces scenarios
> where users cannot access UBIFS normally.

UBIFS should never see bit flips in empty space.
Fixing this situation happens in the NAND layer.
Please see  nand_check_erased_ecc_chunk() and it's users.

Maybe your NAND driver does not call it?

--=20
Thanks,
//richard

