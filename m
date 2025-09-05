Return-Path: <linux-kernel+bounces-802544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447AB45390
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DFD3B2B99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA927C17F;
	Fri,  5 Sep 2025 09:41:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1D43147
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065265; cv=none; b=JcwROQDNP/5ObU5p1LQH91uDFTIoJP4cfW/Z9dhU2skIT+2206e7OhxmUJwq1RWXRVpkv8WBGmhov+ZUL4q792DcU98A9vD+jRVgo+DK9o1suc1iucj0ZEMyhU9PijvyJ84ct9PECUiuMmZQBNUgSWvgd9chBNbXHDfxkdzh5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065265; c=relaxed/simple;
	bh=zY3iPCrHKjavbVIMB6JWljwaLMmTnlvXQG8FRJBM1pw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iO7pCTtCbc8VruoHuygam3/kbyUN/VHJHgwlOYSzLooTL88V4zEqtfsyrBF8Ult5lco8w5C0S4tQcesFlOd7+VXKVRZp3wqBpwOAXVgwksT2wxEtxbhqXJIarvcHE17SSbN13b13pOyoLwbw5jLpgbMjdvklXsM1zYuszAhrvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-886b58db928so219874239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065263; x=1757670063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcO9YHpqobesarBM3yKY5yBwnh+DabzfkdcwLv1S+YM=;
        b=LE+wj9GADCP5NytvKbcjbRgrIbgovd+TSf3ko9DoVDYRFmX6eXzSdkDcGxYAy87INH
         d6CYTTGp9wDvbaiFeT40js/Mbogwl6d5KPXPOmPh4MQsLvTrc/Afj17SBqSfR+teYHzy
         cKTz5I7qBk9TZMihkKhnRSXDDafpL7MEE8i4igOY2bCz90Ts27+Xjt/zWqRbWWDjIY+t
         SL8gqQLHd37Pvc1//bnacTF3inH3PgQ3cumJ0KPeBoffx7aaVUFhSVSvjkK2j/0oUXjC
         MXeAxGC9Pw6HDZjcbVPDFyDW2lyC0nedBouvkHV9vTusCBSpTSi+gTGHMOz0fVJ0g2oB
         rW7w==
X-Forwarded-Encrypted: i=1; AJvYcCXnSp5PVbMGyKzHBAGd3Pxo2aM1pIbns5SsWg8OaE3o45z2FFCem612tPHz/BlBiqOloYT5uP1nr7Xnjwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCuZ8csn78D0o6X3jI6TErmdYHbK/UuYEuSPbW1yG+xt5VoXb
	sWLnJfhEJmLcmQyXBzvvtkT7wX+fkEHXdiLXS+/x7S6pHSQ+YVrVowUBHqTrg3HZfoOzDCpXyq6
	Jil1DlOL7UU+hQRBSwAlo+2RE2zy9Inj4m7w5bKNL9werWg2QIXOY3TNUMsc=
X-Google-Smtp-Source: AGHT+IHBN4mhIWYJqdlTPOYVgJ1hmlil3M4t2rTTnp8qFHKFxHD6XafcxWiVyjvT1/R8uTkZuE6jg+80noBzTXVCSqKMb8s1XeeT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cce:b0:887:3ae9:c3d9 with SMTP id
 ca18e2360f4ac-8873ae9c618mr2474046039f.2.1757065263535; Fri, 05 Sep 2025
 02:41:03 -0700 (PDT)
Date: Fri, 05 Sep 2025 02:41:03 -0700
In-Reply-To: <cc7f03f8-da8b-407e-a03a-e8e5a9ec5462@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bab02f.050a0220.192772.0189.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register
From: syzbot <syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, david@redhat.com, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/gup.c
patch: **** unexpected end of file in patch



Tested on:

commit:         be5d4872 Add linux-next specific files for 20250905
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc16d9faf3a88a4
dashboard link: https://syzkaller.appspot.com/bug?extid=1ab243d3eebb2aabf4a4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1127e962580000


