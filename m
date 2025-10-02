Return-Path: <linux-kernel+bounces-840000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A4BB33C2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7B944E2F67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6063009DE;
	Thu,  2 Oct 2025 08:33:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F32EDD52
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393985; cv=none; b=mRBqKsFfBe4zuKEig593c3rdkQ2Ck+t1hYUUYxM+S3Q9x0WixgvTQ5qZlH1xciELATuLW++io3M77JdmEDCG5egILg+gGVS8t4r9/K30/lCzvrIaVmPB55FqSKRENQuQDUl43rT/cNPgUnlfWO9NvyWt8WiqkKD5DVI/OPHFzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393985; c=relaxed/simple;
	bh=GwdG0LgXcPpFF0iNYWG53721cpsBmDZEt4fFYYhZpYY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gmjyvZUkTeiwBxzX7HayMIInPHZmbwRAWAh5gnrrR3EyFRJY7QhICMkGEIMyDDF9DurY3NKD/weu0mms13dGt7sJQ5EWq3ON4iVGzQQR64l6p8PNxjVXpo2WLYXEfTl7oApFvskbbXqdB7f7inbDsIOAMkvHWhiE1sgTktR2EBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886e347d26bso83770439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393983; x=1759998783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaax1dXQz4N3uHy3soJijtPdYU/9vfx4hJFhMaL0iYY=;
        b=pJhZ6CY6RYsLw5/FyWNJgzVYeSwPPb+SMkiP44SIUI+lfp/gfFlqs24FEBjT1aiuyR
         OuKbpRgrTrPuTHF5iE3/BAoWaf2XYTLu8yD8CAmoMA/eoKmJR+Jfm9lGJFA0uPtgUX8S
         ibgvctAVrmD1siwLP7UWzXQJCXRbLMqh+0dqypEqmHkAUHRPJluUl1t1V4p7zamFkESZ
         8mNhuxCeEIG3vaZaupXlpKipeqKvXf2smkT/2fuEP4poKyFEGUmtfn+xaZWFJmL/LXZu
         KK/jK1K+5whglSjGzOeX0ggYcgLvG4JxgyDFo9/cI2mr2N2I8unXF/PAmSk7l4PJaUwD
         941Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4oZsl1S1Z8NWPFON73ieXoU4iIrT98fMxVAbdZcFEht/emRARhgSuglUWcGLxIyshWtQk+p8DQGnCyvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlgtjCqrAqJ8BCBPNOI9fgDflU9AD8a/FTbs2YLuU9kGD9BhV
	R9BxMCKnyCxZQc5rskEbBES0e5oJFm9SG+t66mnWIDb0UhV0Jo8k+efHches8tgCNSBu7mQFJKq
	5j6sneGQq3piNMfVy4uZakYAeUSIxaTKgtAlvjr55XUC9pAQuTZIOcj+Mp1A=
X-Google-Smtp-Source: AGHT+IEkhH6g5PNdLjla1yW96SNW/PdjBCNRzmgw37q+kKCorUgATLSaIuUBTLsTETpJgcgz+FGbVv5W0BEAJN77xuutsfNT/gOT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4284:b0:8ef:c5c:ab5b with SMTP id
 ca18e2360f4ac-93a6b70a4b2mr220604339f.7.1759393983613; Thu, 02 Oct 2025
 01:33:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 01:33:03 -0700
In-Reply-To: <siwzfsrwodz2zfxqmub4yrfcadmnygdoc7a5imvtr3eicgzlsn@2ipfsri5p7ui>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de38bf.050a0220.25d7ab.0781.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in copy_mnt_ns
From: syzbot <syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/Honza: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "Honza"]: exit status 128
fatal: couldn't find remote ref Honza



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git Honza
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e0f8855a87443d6a2413
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1411285b980000


