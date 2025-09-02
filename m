Return-Path: <linux-kernel+bounces-796739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1281B40688
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6059D1B23ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E0305E3A;
	Tue,  2 Sep 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULisa9GN"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEB194098
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822850; cv=none; b=jIQGVYadXV29V5qFGzoMv4i/TTRAcoYncJshsjQxtlQMP4cAZ9vSYUBje/WNDJ0xD11Y1Qc4zjD1m0Qf3Za5Jt4PUMWD7dYuDr3ZgogptGODLmu4xz3zAh2LCL4oAN8AE8xLln07L6biaYdIhSdNTAMe05UbZvBumEGQwN4D6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822850; c=relaxed/simple;
	bh=HA24hN9VaULASQhq5Oz6R8QUvJ6feV9wq2hkWz+YNrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU32TuUC32DqozOkEKX8rY2Na9J1O770siwbGfRAQIA9n03vWFszKH4qaBne1aMfoVBBu3akSpr1+mxN9fQXMC+2NxeUtPBeDiP7Ni8mdV2J7QCIBtdQ4A7Wb5qcAgMZU4ZOwQPlrel5MSRxVAJ7g28JIjoHrIHMl3SbUhvefJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULisa9GN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4f8bf49aeaso1279238a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756822848; x=1757427648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYN6LqldeQnhtRuH+rp7tP263XQiMf4FYhh/LUhbPnA=;
        b=ULisa9GN5Ft7z++St+ujEfQS6dzqLtfjx9Aw4hjDHbG+fLq43PKac/c6BYs2DP8u5C
         Vin6fY2mfp7mrBjAUqbJG0HlyVTS6DoAMSNZuDggZmMqher0RjU8p+L+djJo8SMz9OdO
         mSPELkPQVR/q/AzrGALHyx/3285O1wKaGAIkH9S/gOyuIiQzu/JzzJ7iSg+1BNpDRPZs
         RyOkfNb+7fRIXws8KCxC0pBLG7Xyd+tWlzgCxmAyPopFXtKHHkjPhwBQXqkhvb9uVTwz
         tLcEBhEEyLzqJmn5+Mobw7NjfCxRbDS4Fz+JbkxB4IzM3nRK6hpFRe5UP7R+sUgB7x2W
         pKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822848; x=1757427648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYN6LqldeQnhtRuH+rp7tP263XQiMf4FYhh/LUhbPnA=;
        b=MPlO6SXTlOoW9WlMNWHqh4S0M6iILdrLfTCQpc1yxqinvxERw6t/ZIS5iPABjAhjEB
         hfKMRfesd82xNxf1aVe1SlVNx1GkX+fOWdmAq3r0L3Hq1S6+8087ZvXnzbCZuNaB9m+B
         6aOmbAB2WX+uumK0Vj5oKlnzq8VnQ2bjzLiZsDEK7P3V4YfA4lA2nSS9SYa136yMWOSe
         GvQrhHj86McGDvkZWNKqHE/enbtkqIY2GmMxh/zNJx17YSERGZBu8ffhaOV99W18vck9
         +J9kFD/T62hcvqGjSmxe3w6Qlrb876az5vfkBTOIeO/2Cco65DJ2Cn1GnKZhA73SNvQ/
         kKkw==
X-Gm-Message-State: AOJu0YxeAohKd2Txe06Ygn2ZCURm5FUmzL+wi0+cgv7N6o0cCDRDGJy0
	LQxMc8vWtE2nHJuRPOTLhs3umKX0LBeGhYHmn2H56MN6UAYxU65Tf89ox0cmFRRcgKA=
X-Gm-Gg: ASbGncuAwVf8NJ2oZYCWbzzWMqDfidPCGMiRvsYvRgJF3aS1Os3zDGd7AeUI70Q3HzK
	cdfLucEbkHDnpCbzM543YGrZppsaK71Zli40c2iqYX9vTHzWYUv6RfsTEdbOvNBObNYjKmjekEI
	A2hHiv5LOS2kHTFlNG/Lmpq4wG+4a+bNo0GMDJt/f2ENOXKhP9+L2D0SfFnbe12C4L8GFdS0wOZ
	RXCwyGGapVgyixu5R2+qOvMvpExMyp2DR/kVTkIJK8fhSEHVZH9v9ViHI7B2L+i20fEcnKylMIJ
	z7T45RNp1AbY1x/bIw+Nx2iUIEC5TBmH+Eh+Ut9kuA/wbAeCqEkk/ZrkPkUHJWaQKX7kNwFXD2A
	Pm2RKignBgpM60MVsw9w6ia75tnm3cRKG
X-Google-Smtp-Source: AGHT+IEHmdHPlbkeLHRlbk3j+vZ2U4gzCkT7CofPvYfx6OrFkCt5fyjPGJzZSqNAslDyRHAACqe+4Q==
X-Received: by 2002:a17:90b:33d0:b0:327:a295:320c with SMTP id 98e67ed59e1d1-32815412e71mr15999324a91.3.1756822847919;
        Tue, 02 Sep 2025 07:20:47 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329df26f700sm2746794a91.22.2025.09.02.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:20:47 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and fat_mirror_bhs()
Date: Tue,  2 Sep 2025 22:20:44 +0800
Message-ID: <20250902142044.9815-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ecsp0yar.fsf@mail.parknet.co.jp>
References: <87ecsp0yar.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

OGAWA Hirofumi wrote:
> You are forgetting what I said first. I said, this should be temporary
> inconsistent. When unmount, temporary inconsistent should be fixed by
> later write out.
>
> IOW, I can't see why you claim this race can be the cause of permanent
> inconsistent.

I don’t have a reproducer showing a permanent corruption
after a clean unmount. My concern came only from KCSAN reports under
syzkaller, and then I tried to reason from the code.

In particular, in fat_mirror_bhs() there is a path:

    if (sb->s_flags & SB_SYNCHRONOUS)
        err = sync_dirty_buffer(c_bh);

So with -o sync mount, if memcpy() observes a half-updated FAT12 entry,
the torn value in the backup FAT buffer could be immediately written to
disk. In that case, even though the primary FAT is later corrected, the
backup FAT might persist inconsistent content.

Thanks.

