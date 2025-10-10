Return-Path: <linux-kernel+bounces-848512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FFBCDEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278FB3A3EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9F2FBE06;
	Fri, 10 Oct 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c15LBOFD"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3082FBDF7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112781; cv=none; b=Zu+PkdUONFfWN29urjdtZ8drG5TLaV2typ3j49T9Ea/bKPOnEDD4q5137df2ttBM8SNZYgv149ZVzrob76siFli3q/8chMpbCBzQ4IRE6xcAt00xNQ6oFGnoRYitUbNSq2hwY8qV7yPUmCWLhCavsd5wIvzvFCa7ucnaF2cQ/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112781; c=relaxed/simple;
	bh=IBKRs8NxX2KWV2z0LGyqgKOMivcipimjpZpOscOhTNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7bAbNRfG3lW325XiEkfif9mNYbf9fS5IyxZjVg6k+fJ45MoV7PdLoY0Xa6qqxLNaV3xDl1sp+VgaINh+74/p5NnoZcCSLNQPcepSHZ/DZf9q4ucI1fXjTSx5c/3Uzct5IatYGE+IKw2A6RnkzJl3OzujSnTqIxOPyzd4010NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c15LBOFD; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9032edd72c1so258145039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760112779; x=1760717579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fp12jPQLKHpAtsfH0wirGai124eQvnJsGvFLw1Tx6tc=;
        b=c15LBOFDmlMjkVnjzsQdG1AD/NOrukcRnhf4JMPA0hHtWvDvWmv7abE1MF1aYln9az
         6jLcAZxepoultuiWpqaE+xpAGPsygh7CeDKt0xKkCtRHBj1+1kb423IiICxTBZmgNFRA
         aGjRkH+ghwXfdNBi+tp34alZ0JiZ0nNQjbO/+k1i1eeLJTBw0aPvcWynNCAPplIXaP68
         gPUm2hP1H//zkmiErbxH6Z+wQTJJQbcv7Nfu5TR7B70AFhKKCGMkX5UZA2T/uLi7cZMc
         8AB/Ijn2uu339H5tbWtbTe6JH+ixKZlxUpAKc5nrnBxSgu1QgYtB40Zo279MsVFzOUzl
         pvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760112779; x=1760717579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fp12jPQLKHpAtsfH0wirGai124eQvnJsGvFLw1Tx6tc=;
        b=P98oMkanhZpGxse4/dGzEWZL1Cg3NStHFSXWNgxsnWWtPcMTDoh/YQSr629UU0pDym
         0cXboRB4f8jph+SRYbejthoPUBbLQI+1WRIdv3IwopxcAJ0g/7I7edY0ie6lySXchl4c
         EH94AcZZKq5W4Juaab46Nb2wXpbdQaSSvU6XWhOMJd90mlEs23Cvh8ckghZxO0CajS1d
         i+X18PPZ8QGZb3Z5meuWVu5fGry910RdmMki4Unx0EYgo15YJ/mPwpTG+Ciuhy+8vX+E
         KoF91dTNELx+ZGG0Rgm7VRSOXZvUVgrVJW7iq2tDks1WI1iEnuGPAmNW/KN4PhGj02Vf
         6J0Q==
X-Gm-Message-State: AOJu0YwaGqBfKNvBIcwSfqgOjEY9KN80D0Q2G3Kh2Hv7yNTnkBomKThR
	y0wRqPxlnVSICQaphrfgIe1mcpChTj6Zprcj72p8qbxHnXXEIoOSkE22OkHlJcRxKpHiylyzZHc
	OvZymx8+UC8bQDmAUcUIKJxYsdRFeSKq+mYnMcGI=
X-Gm-Gg: ASbGnctGjjHCaAbISUbCVceUa7Dq1of2mGQ9LRTYtVlyIErCgemLo87pjOq1qAcWO7j
	EUn8NASuRR1UTbe+13iCbqaVETycK1Ntdnobhch9vh3jEJNqc7G3Wjg3yewtYKpiJVM/gXK+BOL
	3U+YGshZgTyuDkr4X0LNx90ecxhikPVMIzjtQFhCj8V8t8tKzh91EZeJVtMhkB+sbx5UUbPpVt0
	hEnLbySxq8ehvTuHN5kxrUMt08uNT5JpJs=
X-Google-Smtp-Source: AGHT+IE4dk1H9DszW1O9cVXYFFigWOgcXsXjBoAmJdpywlxbTBznMKixkOFEwyOd7UI8V5CNqE3/AEmEal+CSAIkS50=
X-Received: by 2002:a05:690e:200e:b0:633:c066:6a6c with SMTP id
 956f58d0204a3-63ccb89811bmr9511136d50.20.1760112388097; Fri, 10 Oct 2025
 09:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp> <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
In-Reply-To: <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 10 Oct 2025 17:06:17 +0100
X-Gm-Features: AS18NWD21inyGdSICE1B8lkGaaJz_weOFSnWayxqoG0RjRoZD9pydUQu5UVRzzQ
Message-ID: <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 16:44, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
> Thank you, but logically this code should simply be inside the "else"
> clause of the previous checks, which already check for BFS_VDIR and
> BFS_VREG, I think.

Actually, I would first of all print the value of vtype, because that
is where the
corruption comes from, and print i_mode as %07o, not %04o. So, I would
suggest a patch like this.

Reviewed-by: Tigran Aivazian <aivazian.tigran@gmail.com>

diff -urN a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c    2025-10-10 16:52:40.968468556 +0100
+++ b/fs/bfs/inode.c    2025-10-10 16:54:09.904052351 +0100
@@ -71,6 +71,11 @@
                inode->i_op = &bfs_file_inops;
                inode->i_fop = &bfs_file_operations;
                inode->i_mapping->a_ops = &bfs_aops;
+       } else {
+               brelse(bh);
+               printf("Bad file type vtype=%u mode=0%07o %s:%08lx\n",
+                       le32_to_cpu(di->i_vtype), inode->i_mode,
inode->i_sb->s_id, ino);
+               goto error;
        }

        BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);

