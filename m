Return-Path: <linux-kernel+bounces-694906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDBEAE1212
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 06:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43E94A1412
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9801E5B7E;
	Fri, 20 Jun 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPgGB7n7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AC18024
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392606; cv=none; b=eucMREdHq6d1Ok6YTRDbm3zKfAKcoV/Rh93ME0JNn8XNUnk3oxL0sOL0HcCRv/+jwtgL9hYz2B+kqYjoN7gdmXT9tgIGvqTUdwEgqOcxTbPtcmMtlLzWEupgRZ3qjzQHAKDFRA+S4rHKHfVUN91LzTiKxlx/MvdBEOR3tGBnMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392606; c=relaxed/simple;
	bh=ZFwFxwz18sLqOB/ZYXms8m7xw2eOeIJ1+Ts6fVGCxZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlHS8ln1BHuoGjTJgS3SO8QzgzoRl3NH4IW370pWquyrQ8AwySYZezqwqe0aF/O+LD4XLqJzgyXBauX4HK18I7x1xQgS2xhX/EuZM4XR+UEza+f9/PiKnWdWGT2HiaUJKyTSPusC7G2mHXf3+vxJv7cEyfaQtkQUuRAyG0eq67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPgGB7n7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2357c61cda7so192115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 21:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750392604; x=1750997404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0J3pz+vXx4zWhDRnHNe5jTGnCrwT8SdrIPkh78HUGw=;
        b=gPgGB7n7UB++Bs7cddmcHy6D2OnexGBJvlJfFJEgZMnZziAm+0HNHvfL8fk9E+Jluf
         Sf3mPpeNyja0ILzstRqNOf8bmxERASYmLIbxWspBNAFJDpC68jcSy8JBGtx6OJ8y/BZb
         WZFAwMV8cGBG9xD8oswpAbfkwfM0tZ3qpqknt73D/TD2ppof+D5e1pWDJJkb3t/IgjNB
         +gyFGYCQB+8A3mDu/St1xSQ0GhfmnIc2QgGh6nFN+ZFPtUd4GZOzn7FaX/8g4IlvEdg9
         92a6BNuCQvi7pfuQgfcJSFyR6yorqrovuX3AxSO2JXIARaF+SK0NdwJEcOoCD0Twzjt5
         iSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750392604; x=1750997404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0J3pz+vXx4zWhDRnHNe5jTGnCrwT8SdrIPkh78HUGw=;
        b=l28JZscyyLob4/z27001pdqqwyTQBSluQvjNO4s1qbUJv+BgEryd4dLP8pf6FZYFSm
         l+1Jo79x+R5L57Pc/P7urtyQ2lGc3Wz2Vx7Yb+wTzqEL9R7Wu/JPrWFm9etfzD9xo/Ms
         Yo42BYPiUcWSgbsDv7M6ei+I52hssoYqdzDlTYeXvuQaqLS65mC4hDB3ycHf1Zr8+bCf
         73Zj7ySEX0/XahI3Y1sK8VHAdD9KBPX+iOwEuxwj6VNKxe425iRcPqZWBQiO7Bf+Od+S
         Sn/Ze8KtXELevNFzZ/IrNVPqVuLsvYMoqnLQM2exVtx57LbKeYdlnFuIH+B83CiPsTkt
         2BPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjo2RJJeV3ItOZ7g+eNMstvzWgv8knSbp+wzDOCbrTGccHRQPCForQ/dPKel7UGNiy91uq7l7Wl8yZXEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4METD5/g15SxHmkqBAkg1d8VMfu73hYWAutax6E9Gbgy8iaei
	dn3j20bA8U01uEVb46U2EVBBvg2bfR2QiTsm6prFx9JoG8I/MnXPzXk/4FHNpJ+4RXusv9KcEMY
	DRmM2jdH2gW2+846OlomNkSJzA6+s8FHYdXVNhvk=
X-Gm-Gg: ASbGnctSqsuYEc/Arag4Ox6mpDz8F2dNXVumYMklUrscAlbcfqiatknvlgQlCn5V/Xp
	CLc2IWcyS1KCd6ktzprAELkTLq7jMpoW8fDz1vg1OkMdf1ovRE5/lpe+at5CzJT5pRzzpCAgRA9
	CUYNnULZFpOZLS2lg0s+1mkZVlbxeXhqkzFlgQ6WCfjtMswFjoTic=
X-Google-Smtp-Source: AGHT+IEeiO4iWa8EguWAwpdoCgX9FfeOPkwKUTRcK304CQpV58E4RzV9wvrINPgshPqwuZAunqgkJK18ieFfghOTBsY=
X-Received: by 2002:a17:902:da48:b0:234:c37:85a with SMTP id
 d9443c01a7336-237ccb4b061mr4410355ad.24.1750392603867; Thu, 19 Jun 2025
 21:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618132622.3730219-1-richardycc@google.com> <n6sls56srw265fmyuebz6ciqyxqshxyqb53th23kr5d64rwmub@ibdehcnedro6>
In-Reply-To: <n6sls56srw265fmyuebz6ciqyxqshxyqb53th23kr5d64rwmub@ibdehcnedro6>
From: Richard Chang <richardycc@google.com>
Date: Fri, 20 Jun 2025 12:09:51 +0800
X-Gm-Features: AX0GCFtrk97VEBBkmDra-Yk9RA-ymri9HdcNDawwzFbyzXPhM5wZf-3ANJ1sG1Q
Message-ID: <CALC_0q8-98y0v_jV6QOFTKRAGhJ4nCXZ=q9wutLZPCE0KnKymw@mail.gmail.com>
Subject: Re: [PATCH] zram: support asynchronous writeback
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, bgeffon@google.com, 
	liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,
The main idea is to replace submit_bio_wait() to submit_bio(), remove
the one-by-one IO, and rely on the underlying backing device to handle
the asynchronous IO requests.
From my testing results on Android, the idle writeback speed increased 27%.

idle writeback for 185072 4k-pages (~723 MiB)
$ echo all > /sys/block/zram0/idle
$ time echo idle > /sys/block/zram0/writeback

Async writeback:
0m02.49s real     0m00.00s user     0m01.19s system
0m02.32s real     0m00.00s user     0m00.89s system
0m02.35s real     0m00.00s user     0m00.93s system
0m02.29s real     0m00.00s user     0m00.88s system

Sync writeback:
0m03.09s real     0m00.00s user     0m01.07s system
0m03.18s real     0m00.00s user     0m01.12s system
0m03.47s real     0m00.00s user     0m01.16s system
0m03.36s real     0m00.00s user     0m01.27s system

On Thu, Jun 19, 2025 at 10:28=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/06/18 13:26), Richard Chang wrote:
> > This commit introduces asynchronous writeback to zram, improving the
> > idle writeback speed.
>
> Can I please ask for significantly more details here?
> Justification, rationale, testing data/results, etc.

