Return-Path: <linux-kernel+bounces-796378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB71B3FFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539B97B7D40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41F3019C0;
	Tue,  2 Sep 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExxceHuH"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E7301491
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814843; cv=none; b=DZOJ35LHzR0vfhH390Fc8OshH4FOmGRG4sMfqLGVz/rtOjgSyR6YyvNCduP8sc2osi9F8fcpDVWcXZtJtJIy7Q8ckCXhZr+LdY/4Y78OqWiUNGqJnGVBdCEm1UPNr5Gs70CW6dB0XkyqT+v5WhTJ5gRufpyB5EakhaBTzdZyFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814843; c=relaxed/simple;
	bh=/KDit76WR/wN90pG29OCtjslpnm7+69jT6279w37Fcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDBIzh7TkrmHpyqb0DPIrE0LeolnAbvGWp985DXI7ue72tJrvhsof4tqCT1xStntjAJ3Gl073iIL7pSt3K1Y6v+txfBoVD8LEBtmTgXKK+VtIVKN71l2RNzCx7ivqhCq9mzznQ1WwMcy25rjR3nP+zXM97kVU7J5GPi/jdP/cqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExxceHuH; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso3240457b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814841; x=1757419641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcxn6D/ibSYdahoq+sKRu0suEG2CO3fUwHn3gn4nLn8=;
        b=ExxceHuHJENOYgw2r9/9d5p4oRyszFt+o15bYY6koptyMZoXi72QQFGatyJHmL/gAZ
         81TA1yaOpPHcc0fPMQzBeIJWnv21XoP4jqz+X7ZvTvESD8J1JFFXwJsjrgc+7MxGGwrX
         s3sYHCclyWl6nV+Nl3XOxPgt1Nf0oj2mMYPnQlqqG+YTWj3yXWJIBUfrQg4vOx3BeQXl
         h1CyxrME/ZsVfCqj+soHKF+13Zkdq6BLB9gafqi1Yy/dJct5qerGzZIT5djtP7G7z6f8
         c5GWXPkWYPaE1gM7RHW6HRp2vRi+IsqxXb4lqrQD1WWIh+ZeJv+eIXWHBZit9dlaHanA
         /8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814841; x=1757419641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcxn6D/ibSYdahoq+sKRu0suEG2CO3fUwHn3gn4nLn8=;
        b=H47bOxkMdOFo0B0z9vdQLOH1WG9Fe66/mZdXccK7yjF9D4X67JnGhENDH+K2KNOZk1
         n7lWndo12NgQHUNx/ngBVta9hlX7/miQzpA7Irpi+A3YPG400/1n2uvSvkqAcyciz0Td
         dTzIPyi/xpq6mas3Jrec8aQb/38m+VZV5hcmErapVKowhOHe+Q2N5X6KJgb3lgi/R9gT
         onp2PTCWM5Jt24X0Be5g3nCxPB/3kM8ONznaNXxnDEKPk5TaQNZlCH0A0viS0fjItOg/
         sAE00ZdwkjRtI57fDmvLro7M0Tr93apjYpuaWuYSEOqWJCBw+g19Y5u2GB0OFeU8tnIn
         S42g==
X-Gm-Message-State: AOJu0YyRl/piCUt5ZmiG0T6rms/BTnTwYmSLMwijhsOp60SfhS5+pi8h
	6eeYmLtKd/XoQbAVCVs+GAqRatwRmWm45FgGq/119XbhyY1jGmrDypjY
X-Gm-Gg: ASbGnct+/CkLZT4w4RK3kQKBlIOFlyrhXxvP+muws5PGWmCFVw1J/IDDYAKV8Z6URXT
	tc+FPlRH5iQp5GFcmit2GOSKwPZoUvCe5CRpLSxREK6bjqbz2MuK97ZGEy/5VYQiKIMc8b45dn1
	Sx//XpYXGFIabaayZnETlj+Pq7YINgPJvcXWU6QJzQq8B3VFUAZ8h4aNWW/S2TiDWMmTLyTutga
	lXwgdzc3SmMnIG4fBttYn5Md+7i1JzLLOFOMxC/0lqQhe3n0ThTrqU1LZoR83yr0GVsHO8o4NNv
	kQ0OD5h3BVV6jyiNBO2ATyEwlgZWIr3NWDQi9VWwR/YJ4NvGwoTGQV+Uub+ZoxPty5hQqJ8e87T
	y0IbFh/hXoOl+KGjEnAUNtPgfyUZUpX0o01D1DzyhW70=
X-Google-Smtp-Source: AGHT+IHnBQFp+bMCKKGLZoUBqEt7ejUsoo8pBiuo5VJi6Ksy7IhWLPhHwBORpP9g0fp+pzUGYjXn1A==
X-Received: by 2002:a05:6a21:6da3:b0:243:d588:9855 with SMTP id adf61e73a8af0-243d6f8edb3mr16202430637.60.1756814840634;
        Tue, 02 Sep 2025 05:07:20 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm11814139a12.2.2025.09.02.05.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:07:20 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: example: fix memory leak
Date: Tue,  2 Sep 2025 20:07:17 +0800
Message-ID: <20250902120717.452-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87y0qxp6rf.fsf@mail.parknet.co.jp>
References: <87y0qxp6rf.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 02 Sep 2025 23:13:42 +0900, OGAWA Hirofumi wrote:
> Hm, what is wrong with temporary inconsistent?
> 
> If it had the race with future modification, it can be temporary
> inconsistent. However, future modification will fix it by updating with
> latest blocks, right?
> 
> Or did you actually get the inconsistent state after clean unmount?

Thanks for your comment.

This is not only a temporary in-memory inconsistency.  KCSAN detected a
race where fat12_ent_put() updates two bytes of a 12-bit FAT entry while
fat_mirror_bhs() concurrently memcpy()’s the entire sector.  The mirror
FAT may therefore receive a torn entry.

Since fat_mirror_bhs() marks those buffers dirty, the corrupted mirror
content can be flushed to disk.  In our syzkaller testing, this already
resulted in runtime errors such as:

    FAT-fs (loop4): error, clusters badly computed (421 != 418)
    FAT-fs (loop4): error, fat_bmap_cluster: request beyond EOF (i_pos 2075)

These errors occurred even after a clean unmount, which suggests that the
inconsistent FAT entries were actually written to disk and not corrected
later by "future modification".

FAT16/32 do not suffer from this problem because their entries are
naturally aligned 16/32-bit accesses, which are atomic on supported
architectures.  FAT12 is special because of the 12-bit packing across
two bytes.

So I think it is necessary to protect memcpy() in fat_mirror_bhs() with
fat12_entry_lock to avoid copying a torn FAT12 entry.

Thanks.


