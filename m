Return-Path: <linux-kernel+bounces-726785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD2B01135
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997503A7752
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DB192D83;
	Fri, 11 Jul 2025 02:30:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C318BC3B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201005; cv=none; b=HK6Ks2BqAxZLvF0DBdnLJ9Uu+fs4ntEyApN8fAF5PRHdHytUkgTDkKHbz7n7Zt2Ce9lciff6FZ4i6uyMteUuOckpcTfCdS5VLqEZvXViesr9hxYzq25iSwC0eeSoAVeILPR+mQAOFKXOCF1Sk+mhnir4mogmxyTQvaJYih345ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201005; c=relaxed/simple;
	bh=5q7k1ntRoE4xpShg0KU69Lmc6RAIPz6dMwp3DonQX4g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TuLOqnutWFRc5HB7m5kBfWaJjJygjagknRWhnE+dTO3YSlo9Kup57k/mIhKITRbNnUKB5ZDv+ym0OTRTvghNFiFAPbVZmbExk/cTWP6jZ3xYf/gXlrRaiLqvQJajlE/wmfEtzi3bbfWYl6qddjNbtzyOf1S+11kplLwZLHkiBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8649be94fa1so317310739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 19:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752201003; x=1752805803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faHvFBIwpIECxHDN3IyUBfgh4UV3LBTQ4Tu86iiC3Gk=;
        b=Bj7XLeY8KiX5I5ligAMXoWaNN4i4CGuzJMvd4dj0jkxMZp+t6EAdXppDBAn7c9aBlb
         mj02/Vq8kPbbJWVfCf1TUhGvojkg3X9FuE5jW8+EJFZV4lZB+nLgwm1lxElyGmv1Xa4Q
         /2H0h0EvwzbLwqc9Nll0Vue18yIRJx5nUNAiej5YVkqiI/4SKOj5LIPPBQGJBkLYaRVw
         ro7Ik48xeH5s7p27XpuRkRK2QMWBKeUqIGbtGhbT7utUk3cfDeI4au5+NYhQ94dx9ie3
         A/5DZM9+FrlxpOpvABJUKPda4VYTciZkYvkNYqoX+fyR3dkopoX2izu2gsxinekPN4eB
         Mkkg==
X-Forwarded-Encrypted: i=1; AJvYcCVkhzWDhq3cA81EJiX6vU1JhgLoGXlDujhSYo/CHYau7bk6khLOwU1iCBrePyu5ZPM9gtBOz+mf9Xy8TxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSgmsNlAtGGYHGUBIAW1v0fsInqPDpfnNwAP8+amoxe4dLWc/
	e+QOlfHxKcHhCROAcVWAmsfnewfGWJdnn6voE5DqyCmSrM4M28FEZm/RclHkxLZUl4uJ/aVTSBM
	/HV4cP50v4QHqF7NcX/0YiMEE3OzQGO1wwoES/GhNKLJ/rivKMk97psR/Qi8=
X-Google-Smtp-Source: AGHT+IFKjSyTbmCWLIackHXz6/iQlL++JaSu+pfcKlQ5SW+VfRtT6xM+NyKWI7MVDFmk0g0uJiNN6XPr8yLjLyGeSRoL5cQarIAx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fcc:b0:876:bdb0:db43 with SMTP id
 ca18e2360f4ac-87977fe5a37mr263919939f.14.1752201003493; Thu, 10 Jul 2025
 19:30:03 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:30:03 -0700
In-Reply-To: <20250711022558.3290-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6870772b.a00a0220.26a83e.0030.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/proc/task_mmu.c
Hunk #1 succeeded at 585 (offset -1 lines).
Hunk #2 succeeded at 621 with fuzz 2 (offset -10 lines).
Hunk #4 FAILED at 736.
1 out of 4 hunks FAILED



Tested on:

commit:         b551c4e2 Add linux-next specific files for 20250710
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130120f0580000


