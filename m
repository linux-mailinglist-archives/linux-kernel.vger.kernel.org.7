Return-Path: <linux-kernel+bounces-894920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D7C4C72C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599103B502B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122A4A01;
	Tue, 11 Nov 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOIC3tZ8"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145B19067C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850742; cv=none; b=eKg60EChX9ij1q1lcLmeWFFCQA5yrhGVDfIHKa60Uig44DiXlDVYyLTYFebmO6Kb8DtRuLzYlZMkdabo8uDO52z96GGpa6tqgde+FLQismoT80PIZeTrBQGxcjnJGA1Pkm9EOCeNo81s63oO5QCdrsufI5BBtCE02BLr8f/Bd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850742; c=relaxed/simple;
	bh=oS1LAumOqXWizhvJYI0jHuzv5GuWqmwpGq7/WL2Q0Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLlGeMdnYJuEYafLYkaLWsQ9f5YK+nvcRsttZyXGz0sfYcwfsubA3XlpwnofMtSUPlEIm++2hAhYrAPF6sXsHRk6nq7Bwv7Gp/GkdQUKVr+G1Xs4AfyXDhhGtksv3Y4RFm+UxN0KLt9xNmfiDkHZTyIVKyCM23mzBUR3uc39hGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOIC3tZ8; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8804ca2a730so58917056d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762850740; x=1763455540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RoHCmC6TleJl196mHX278WWXDC/QAAy93w1AuUQ3Ou8=;
        b=WOIC3tZ8JIAAFXbBwqGROK7yXmff5RrpOmLi1cmVWtCJ7OQHL3ine8MvgEvObCBuE2
         6N9LY8H3tzDBFOLwV2IuQn/tFGS99NVUdDl0rycgoSIafp7EjE5Ak4LZ8GMmBaj/wyjO
         naDlBNPd5Z1OqQCSZq65dY7gCqtzzZErCy7gRPA9TuauOTd/mTqNm7Sa163S0l9LX3Nz
         nnzLFPsNokrQPF1qlt8WRV0Q5NfRnAOtGiX1x26/rrRiSmjmudFfh15J7RFvGg5y65fr
         jYuwfx6cSZurAd1O4SHFLAWa31qBE+ZTP5TCCiko/03X02dXgFPErg9N7snv6k+1tmk3
         wisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762850740; x=1763455540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoHCmC6TleJl196mHX278WWXDC/QAAy93w1AuUQ3Ou8=;
        b=W1+0cUY0OmXdYGB2LCjO4zCzz5EP2LLUOq7OGte2CLoSErSFjPLT6akol5kzeh3Tb3
         5a6dAc91GuNy5YCz+ApcBf90qCgbQS4kEc2IIcqPPa/ib6FECC84JWbfvaJP/vrNzZpk
         uoMMSMRBtfYn7Zy97ckRQwD+r0musrovDixFYRuhYmYkQcyma8AN5bKaYDp2zmC0wMPI
         /oKlFnJ5iSgZ4cX0/h9Oiiz+n0058uBRfU45Coji1oGad/s10HE/XMEVpgSbvXt/tmVQ
         FFX49Aw4WNHc+OROHu6RMbqyxQ3z3Ue+1/7FZG/aBfJWHICB9+WttTgMBHKQoAVMzDmn
         1bqg==
X-Forwarded-Encrypted: i=1; AJvYcCUmzkvN/5fz/8EnGXNj9wIRuP0wQqoZMsAMZbe1dNpwPfw+jdgYVbTy/+5As+n/wtsFSqcL2s6/myT30Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9f66v+c4LFX34HmveVPAMW/49gi685X7eD0wK1Jf3b4uVsp+
	Ga3sZE9iTkk98ghZyYCD9sVxGCRsNNRy//XKRW8B0utb9X1bJQRza00z
X-Gm-Gg: ASbGnctywBxyd4RTCsO9h4olz0qpaWA0sXDbdhP4SZV4RnF+QTFLNrPtTurGZ4Op759
	/RaftzyfDktgKxl/0JwHL74yjmjQ4h7YSW2i5XezV63McRlXLkUEDqHMf9b97mGu0803wLslW9C
	hIq5+nNw0Bk98+txOew9joz/UAdPtF0gFdL8zBzjIV1GdMp1EqVYH4Gw68uHn1jm701bjQQYsNO
	vktVlZx8upNEdZtm74xkAujwX9RO3ESWIiQNVpLvBecIW/gurzE/Sz2Q2CN87RbnPf+B1YeJ9fc
	6PKlAKYYLIN4PqY+FYCApkzx/MyrnY992+ZRQY4G7tOVRkVVqkR7e6uO/aQ+AhHoFLSJ2d3TTtu
	c5EVXiX62zJBBeofCEfH9b3K/QBbERTrVDGU3oGTkIZ00u4wlNULmo86RTzdaHLvNujQkwqacVs
	ZOpIrw4Q==
X-Google-Smtp-Source: AGHT+IHIakMjA0T9qTUzAb59bDuV1/F1paRxmjYObQTAMoQEgBG2c3QI9Jg7psPckbshmRUirHX17w==
X-Received: by 2002:a05:6214:e42:b0:880:51ab:a3e3 with SMTP id 6a1803df08f44-882387621d9mr168252606d6.67.1762850739953;
        Tue, 11 Nov 2025 00:45:39 -0800 (PST)
Received: from arch-box ([2607:fea8:54de:2200::c98d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b7499esm68465066d6.41.2025.11.11.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 00:45:39 -0800 (PST)
Date: Tue, 11 Nov 2025 03:45:37 -0500
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: synchronize free block counter when detecting
 corruption
Message-ID: <aRL3sT7AbUgZTbem@arch-box>
References: <20251010073801.5921-1-albinbabuvarghese20@gmail.com>
 <20251106153035.GA3125470@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106153035.GA3125470@mit.edu>

Hey Ted, Thanks for the feedback.

On Thu, Nov 06, 2025 at 10:30:35AM -0500, Theodore Ts'o wrote:
> On Fri, Oct 10, 2025 at 03:38:00AM -0400, Albin Babu Varghese wrote:
> > When ext4_mb_generate_buddy() detects block group descriptor
> > corruption (free block count mismatch between descriptor and
> > bitmap), it corrects the in-memory group descriptor (grp->bb_free)
> > but does not synchronize the percpu free clusters counter.
> 
> Actually, we do.  This happens in ext4_mark_group_bitmap_corrupted in
> fs/ext4/super.c.
> 
> 	if (flags & EXT4_GROUP_INFO_BBITMAP_CORRUPT) {
> 		ret = ext4_test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT,
> 					    &grp->bb_state);
> 		if (!ret)
> 			percpu_counter_sub(&sbi->s_freeclusters_counter,
> 					   grp->bb_free);
> 	}
> 
> So we've *already* subtracted out the blocks that were in the block
> group which we've busied out.

Thanks for pointing that out. It was naive of me to overlook the other
occurences.

> > This causes delayed allocation to read stale counter values when
> > checking for available space. The allocator believes space is
> > available based on the stale counter, makes reservation promises,
> > but later fails during writeback when trying to allocate actual
> > blocks from the bitmap. This results in "Delayed block allocation
> > failed" errors and potential system crashes.
> 
> I suspect there is something else going on with s_freeclusters_counter
> being incorrect, but adding an additional correction to
> s_freeclusters_counter is not the answer.
> 
> How is the system crashing?  If we have errors=continue, then we
> really shouldn't let the system crash.  If there is delayed allocation
> failures, the user might lose data, but if the user really cares about
> that, they shouldn't be using errors=continue.

I think the existing check in `ext4_mb_generate_buddy` is for runtime errors,
and the issue here is happening at mount time due to an already corrupted
filesystem. The value of `grp->bb_free` and `s_freeclusters_counter` was
`150994969` vs `25`, which is the actual free clusters count. The existing
update call subtracts `grp->bb_free` from `s_freeclusters_counter` assuming
that the group descriptor is accurate, but in this case it is not. So we
still end up with an incorrect global counter.

I tried the patch here: 
https://syzkaller.appspot.com/text?tag=Patch&x=1771a7cd980000

In that version, I attempted to compute and pass the corrected value to the
update function, but it failed with the warning at `ext4_dirty_folio`: 
https://syzkaller.appspot.com/x/report.txt?x=1306a7cd980000

From what I understand, even after adjusting the counter, the dirty buffers had
already been created, so it returns an error that unmapped dirty buffers
remain.

My earlier fix ended up making `s_freeclusters_counter` become 0 due to the
update in `ext4_mark_group_bitmap_corrupted()` that I had overlooked. As a
result, no warnings or errors were triggered at that time.

I might be off here, and I’m not sure how best to proceed.

Best,
	Albin

