Return-Path: <linux-kernel+bounces-829123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07292B96564
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A861896CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430F253F1A;
	Tue, 23 Sep 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="nXdsyQpC"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D28231C91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638269; cv=none; b=rww+nMeoGnj9fccrBqvJiP/R5ewKlLY2c3rOlK9cL0ZAngQfjkiAj8eyABfaWgBjgkzzKN/U3mdYTv9akjIOYmhLHMyn3nM2HftedYAgKGavI8/DnItgxViAoXUBHD9bJu36BmSSHC+7Tc7b0rC06P8ewOTZ2J5JOK1QrXAQrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638269; c=relaxed/simple;
	bh=XFPC/BK7RrrbM/6ArKKBKgxpv7IIcB0qBa3VYnTD4CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCfM0JYux/fp/9lI2WmZPuL7xwttejZVhLdOeT/zRPawgiuXz1hD+yRtYa7/OzQx1BexKHJZ93lTS1JxabvTrC1+4UDhA16fQgghLgPO3RyLiSfsLXuqF0TvlgJOieM+O8/c5UiQW7cpTMSQlFyIn+nMmTfG9rQFdbERgjTQMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=nXdsyQpC; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so703196e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1758638267; x=1759243067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFPC/BK7RrrbM/6ArKKBKgxpv7IIcB0qBa3VYnTD4CY=;
        b=nXdsyQpCs1ACf4OnM0hGdcuKe5V1AESGA5I4pqUEREnvxDIiZoacM1ZTSSJJ/x7fi6
         OTwWSCC77phVngDOmnnA1knHitzAvOWHqpigivrLGEvCMHtUNricvh1rlynoIOal485t
         nuQp5ujOTd6Qa3J+LRrjgCYHbKnSP4Y9WjCoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638267; x=1759243067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFPC/BK7RrrbM/6ArKKBKgxpv7IIcB0qBa3VYnTD4CY=;
        b=cDFvUm8zzUY5cO0uSIxl/1Q/FMSs2mHCPU8bK/HXWpFe6IUxLKpL8MJZCHgYiS1H46
         sortvXag68hc2J1c7HJiM8phadXhv7QKBKjP6UKMHmxBZabUM9m5QJ0AqYTkT0T11CHI
         1M06haYYpGDvx6zqRD6WDPkhJDhItjqJ1N0WisDxxbzPWBgDjBrZG4oMpsGFyYQi5RCa
         U21UjKt5dz1IzCKWDqhZDiN+zzIzLaJBRK3VrNW4MdmiYMSKhOEsBAKNwQ08hiCwKF/8
         PcoKcoagvl2+7UzIHvQK0IepmfH9rjY2bidDKdlBYXAGGxh3PMF9xCF1Z5V/OmW/Mzmt
         FqhA==
X-Forwarded-Encrypted: i=1; AJvYcCU22ku4fI0/mrFAzqIIS2XHAuDruvOgMhrUhvGqn8+ouRDcWfHR5CuYeGLQ4aL0InXkReO3mqLDcV1E8+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRMHdohzgZ5XY2ioxxDDIIz/pmqs3qSx070fYEZGQueJ7unAm
	Z2yE0MDQOSp5LXwslYCd98hxW4XlQWp4sfX5nPdH5IJQydtVO4anF1BowdbK+ZUmx+UzuwYEOM0
	rge/2ZBGib1iilqHMtBmLY2jQXs41NV63znz1ic4QOgnTUR5STjCbdrab1w==
X-Gm-Gg: ASbGncvnL2afocPvhc1m+HyO5LqKAcXmOM34vRzn59jkpnx0L5EHQb0ltNQs+EEvdP3
	6YsYqukkZQPZ+p8MDA5CqjYFFibOUUP7w4DlgYli1rcilldNJVBYy351qc5Xyarqb0QoBb7XcYy
	yY0JEy2gN1UOKMqGW0lU9c2TW8bri23o3s1XEooNknNpCRw5HL5oicl1e4KO7g5NxiJJ68OQQSs
	Zz5Xr2u
X-Google-Smtp-Source: AGHT+IHij9lx2AnOHFGmNnUlWqEm6JnPegqIqPjiG5wTqefBFsPSYxSPRwyIlCxZT2X/ycZ/7rUsB6W77nORwXnLY1U=
X-Received: by 2002:a05:6122:c94:b0:53c:6d68:1cdc with SMTP id
 71dfb90a1353d-54bcb1f583bmr769314e0c.14.1758638265119; Tue, 23 Sep 2025
 07:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com> <20250909224520.GC5333@twin.jikos.cz>
In-Reply-To: <20250909224520.GC5333@twin.jikos.cz>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Tue, 23 Sep 2025 11:37:33 -0300
X-Gm-Features: AS18NWBQI2eUBLSAsWj5VWRzlh2lPky9Jor81XegLJB6VSW2SVpeKxySTYz4Ff0
Message-ID: <CAPhRvkzgR+8L93VF8XtZDG9P_q7O0+BSBxnHtesLY5oj6uhwmg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

David, has it been queued somewhere? I don't see it in any of your branches=
.

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

