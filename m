Return-Path: <linux-kernel+bounces-809155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237DB50954
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCF83A1E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E108628A73A;
	Tue,  9 Sep 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="bNBOyyaE"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F8289E06
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461201; cv=none; b=mSom9h23cjR/pUX7BoH68ssySOYb9jY2GUhWS2Xg1iQleVmPRy+gbgc3Va3zE0AYgtVH1CNPxZKG/FNVtNGW94UtysH1vRRuoAeEx8Y697oWd6iqNWKp2BX+QJ6wjEQAFttowcwfgzcDK6AsPthuzDpg3dNQpQYd/dmJycYfZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461201; c=relaxed/simple;
	bh=CXzV1J9b4X8/ZSQaMwpT4Uky3mv1jyuJJk+Az6e5mFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTCpLlptzTgdNHaiCUf7HgXl19lutF6I6pgsE9l0EB1DPMEfWBT9gY0n1VDKf1Rxs6s/UU2anx4Eb+tra71ZtGgke1PZgJhbuu/uei/DahH7X4jL5X36SX3E+51HTV1P+XTzuki9q2y3ipcFqMzQmnx61/QTJIgJAFAew+AVMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=bNBOyyaE; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-544ad727d19so96676e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757461198; x=1758065998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXzV1J9b4X8/ZSQaMwpT4Uky3mv1jyuJJk+Az6e5mFY=;
        b=bNBOyyaEiWzi8iGcCJ4Rp8MJBDyjrC9WLMxrQZiXpBtGwCsKrzDn8112Shcdk0t3NV
         g4xOs0xONVByQErIgl64pWq/SUKntS7wnjwjFuDCgBul5+5yNVqtD4iWW0kAn1uFJpq1
         om25PX6scXJvBk//15krPqqhMn5l/NlLGN7i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757461198; x=1758065998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXzV1J9b4X8/ZSQaMwpT4Uky3mv1jyuJJk+Az6e5mFY=;
        b=WkJOd62LC2D+iauVyPriGARe9OXKAnLWEkpYhB4olVGm1RkVjKS2UK2n/DQ8dNgog2
         S6xX9pUJ11cb98jpb7kO+b6aVnZ1xW4vl3BV4bvTtwyY92gmWl5CmtmdwWLio1cEEgZG
         ijKtE8wEC56J9wQhnF3wVxxinyO/xqzF4f8WjAVLYqugM0jxUKIsWYm3VwZitrg5LmGK
         V0CKCRXb0grgsaeU7W9/2Jemyfa2qI9PzkJvLcM1ap7ZxMzaM4BEB/+0Bnwj82wH5lmC
         dsXoTDUJdcGYy4EDF61tP0hb0khWMlaaFlZCFFeET8cxoirdtqx4mv4cwBjVLtH1EBzi
         0HAA==
X-Forwarded-Encrypted: i=1; AJvYcCWbsOOQ+E7nIUOmU7t+FgZneBAFaJpTtODihPaAdrpuRRRdofq0+sjltZnPPlpnB9BvqdXpR1F+USb5df4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/kihf5uKrIjuQ+UyZq5JMZm3IX02N4/OzYJP5tyjKUN3ieQ0
	BYYtX+MT4NTrp5C4saqPO9r0BzPIYhf3fdOst2F04lUyvnSEmPL1xRiwS7YnfVeXPzPKKyb8bGk
	z2n5wuJlFKMClKmgdXa3xz2G8stvbUCGiwZlNGrmBF6o76GXT2jG4mYKWFg==
X-Gm-Gg: ASbGnct3Y9jaKcicsUhLaS5iyP/ckG8mjJ/rwD2nKtewLgMVhdSd9w7p8xD/uTKaNn2
	7N9F7tHpNR6y+lpxb6HwYmULchl1DrC2/hbDjekvKBCEIZWxrfs3m8lsdCaxAcr71OjYS2t5h9l
	Y0R6afDxc1dzdMKxjuLz0492+R2RUcBIwj/XBFbhIXxB3fnPTnK9N/eBDF6MoV0i6XGa612v9Rz
	1ahC86RYaT9ljaqJ7A=
X-Google-Smtp-Source: AGHT+IEIp2vYI6Dc5ZDWhG8JNtPTNs9smLCDF5tPVfQuxoQJpoqG35r+lFvhpFLpu0WppBPsv1K2mu57sosnAN/hZVU=
X-Received: by 2002:a05:6122:1828:b0:545:dc3c:a291 with SMTP id
 71dfb90a1353d-547a7344aafmr4544788e0c.6.1757461198406; Tue, 09 Sep 2025
 16:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com> <20250909224520.GC5333@twin.jikos.cz>
In-Reply-To: <20250909224520.GC5333@twin.jikos.cz>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Tue, 9 Sep 2025 20:39:47 -0300
X-Gm-Features: Ac12FXz3aXpRlYx3qCFGkt45W05GgIGRovy0Uu8BDfSs4f4R-BsawXSQhGvddUQ
Message-ID: <CAPhRvkx-72vRwTiuBk0WQPhpegBdvsFFtXi8Kfinzxa9bUmj8A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

On Tue, Sep 9, 2025 at 7:45=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Sep 08, 2025 at 09:49:02AM -0300, Anderson Nascimento wrote:
> > Hello all,
> >
> > The function btrfs_encode_fh() does not properly account for the three
> > cases it handles.
> >
> > Before writing to the file handle (fh), the function only returns to th=
e
> > user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
> > BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).
> >
> > However, when a parent exists and the root ID of the parent and the
> > inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROO=
T
> > (10 dwords, 40 bytes).
> >
> > If *max_len is not large enough, this write goes out of bounds because
> > BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
> > BTRFS_FID_SIZE_CONNECTABLE originally returned.
> >
> > This results in an 8-byte out-of-bounds write at
> > fid->parent_root_objectid =3D parent_root_id.
> >
> > A previous attempt to fix this issue was made but was lost.
> >
> > https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com=
/
> >
> > Although this issue does not seem to be easily triggerable, it is a
> > potential memory corruption bug that should be fixed. This patch
> > resolves the issue by ensuring the function returns the appropriate siz=
e
> > for all three cases and validates that *max_len is large enough before
> > writing any data.
> >
> > Tested on v6.17-rc4.
> >
> > Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
> > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
>
> Thanks for finding the problem and the fix. It's 17 years old though the
> other patch was sent about 2 years after btrfs merge to linux kernel.
> I'll add it to for-next, with the minor whitespace issues fixed.



--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

