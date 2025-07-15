Return-Path: <linux-kernel+bounces-730977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C9B04D24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672C81A67281
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F62A19D081;
	Tue, 15 Jul 2025 00:56:13 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E8367
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540972; cv=none; b=kJi0N9oHanw7TDskJA3xOrLwp2hNIMp9L7q8u6TlgLl3aq3dkudIO5zaCGvjZjJZVV9snU433gY7uIJff9lJvOWW8BztSoaHWij2VjqQtDmTqx3TK6dSOouDrSW5S4DHAkBGTGPfeZsav/z84N0Vxvh5MLFn8DRHyZWKWOEtY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540972; c=relaxed/simple;
	bh=yyQKrZiY83Hr4DK1nc5Abd4bWfPP0wEEWKZ9aP6f6cg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I5LdmQoiGvYKkrJFjVJQ1PXLzK7YojGR2xBq4k0B43YMmb+c2SZTHvhrjAuabeBJcXAmygtcBdRfjwKWUmr3UVj0l6hSw21k6/Xw1tmpNSb3LslD+hkOoKBEiPBQOt1n5KOl7HFk5CwrkAKQq6a0h+wMNvNOTg9bf3kBQJX2/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so894877439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752540970; x=1753145770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7b1qdr4e28dQ2fHkTSy95eFL9kUtQ9eN3cVKNTBaKA=;
        b=kikbxQvw0kwTmmAKyVIZfqLdnIm9kltI8G8W99wdZxISJ9RrZhNFpp10v1j+Y1M+EQ
         fJwpw9RV30F+alu7M9DtK+hRyEzJvgr2FEW5fEWJ3VlUpxeO9lUD8YF8WUjK1KjRLpkb
         4+O0iz9M+YNk5IIi9L35AmWpe/dBMRDOc2IFau0fyFxV6l32vgJjYTwTfh88AEwKirrr
         DO1pR7jq1RouV4g8NNlLIHsTVnPeV4IxX1VrWVVt59olN0LrboBbmq680aXOA5KABnGF
         EDb1vSrvheyVKQmkU8RidSzfA3KtR2VX03YtHnAuDpngIJ1bX16ChMbsOvJM5XnOg96D
         RBMQ==
X-Gm-Message-State: AOJu0YzyvtgJYvZncYDLNg9qVyGtVkfgGTKj3/nkKjPe9hzBdxTyGFFw
	AfbdF5K2mGWXkO7n4BoA1q1U6e/6xjJe/K4oFmk+pppuTI+0ENycW7lpdQrfedzy5OEi3u3GDJl
	0jCYIQmVNDMPDuHGdYkWvpuKgwmb0fDiElX3xEyKWrPOYBdV1fddhXFey198=
X-Google-Smtp-Source: AGHT+IGUCMWjt+AiYwgYv9NehrkwXD7bSVNlGsNEmXxa1zbMdNuR2QVBxBaGQ3+5jTkK0tbDobgi7vIO+mqc44Kg/Z23/RxS+9NB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d89:b0:876:a91a:9098 with SMTP id
 ca18e2360f4ac-87977f57bfdmr1935926139f.2.1752540970332; Mon, 14 Jul 2025
 17:56:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:56:10 -0700
In-Reply-To: <684c5802.a00a0220.279073.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875a72a.a70a0220.18f9d4.0015.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
Author: inwardvessel@gmail.com

#syz test

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5669,6 +5669,12 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,

         init_and_link_css(css, ss, cgrp);

+       err = css_rstat_init(css);
+       if (err) {
+               ss->css_free(css);
+               goto err_out;
+       }
+
         err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
         if (err)
                 goto err_free_css;
@@ -5678,10 +5684,6 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,
                 goto err_free_css;
         css->id = err;

-       err = css_rstat_init(css);
-       if (err)
-               goto err_free_css;
-
         /* @css is ready to be brought online now, make it visible */
         list_add_tail_rcu(&css->sibling, &parent_css->children);
         cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5697,6 +5699,7 @@ static struct cgroup_subsys_state 
*css_create(struct cgroup *cgrp,
  err_free_css:
         INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
         queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+err_out:
         return ERR_PTR(err);
  }
--

