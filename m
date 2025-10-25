Return-Path: <linux-kernel+bounces-869749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8213C08A62
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 05:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7F614E556A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49819DF6A;
	Sat, 25 Oct 2025 03:42:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901D21254B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363726; cv=none; b=k/E1Kq4rKLV4LybxnjMjNzQ0yPon9odEeSib4I4F5D+zckhxgRWJ0Ex0fRJbt6USRvscA2AfSDSotYKz8Srd+9mJLdRJdu9+GO/YlgV7VG+E7OcB0XJVBUtp3lCtqFC782R5K54YZl0tykwuYp0aWwUeJhbCN25OvJJ2PGHWW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363726; c=relaxed/simple;
	bh=SzP+ivXKYs1J2Q2yZCagZUFPpailgNKQgiqUjWShWdc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m2V/TnRMs1oJ+d/S7dNpacQICVxKEqMgZO0lBZRZ2/pj4pvv2qJ8/cgI5VkGgQmf9ZMCXZbciM53lBclAOx/kHrziSKGwtJQWX+Ryj5SiaAp4DzdVtztj6Cf9NITntFb9KiZdKd+TOKPwrcSLi3NOKYdCNPCLXi2AS9CEQU0t7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so439336339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761363724; x=1761968524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1gAk8yaTaRK74hcvRqkvBNHoM4DeFcCFZCfbuJzKtg=;
        b=B19ctMnv61yXPXvcifwOG4YXT9omle6OMN36QEZyC6qxrwGbeZLQPFn3S7lILFcBCs
         YIwB/w6ZoyzyZyJcpYFyx8ItTtMeC7kwziahCBZtgvUk9RbEcUB6LeGlBJ4OSG1quUMx
         GvxjqnBNEdA/PfwdL8rrBKPJlaktE4VUXtIEqAL9ucRauHDfq0P4ccSn0v9eKhskKbXA
         1EoIhMNl++vJES6JgC8r5WLoBN85BAWYSMLA8hCHLnqY5LBgHTpsSO73Q9Pz3px02Dym
         HfaVLPWaFHjEtGMbOFOa9jZi9jmDFWOuRfS+/Cpw6X7M88VoFAgYaAemBCtWexaFgXvj
         o0+w==
X-Forwarded-Encrypted: i=1; AJvYcCWvBDIlOHlFgUyGgP6YOmR+8BAWZPn0v+2bAuCmXQLRyeaNubdBJgjhHzERPQodjBtYqAjTNrbvDpI5QfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuml2kiv0sGTci8E8xawb98Iv8NgtemQMIi2lYpANkqXzxv2ND
	y4qB+Kc87kgMpqzL/uFFOkQymC/7JQc8028QFnoD/xqHw1UcRPkdiR7YkYHHSpRRcjj7YoflS9M
	D6diLNnUPvPw+EHf4ObA9S5xaB69VxIBPWYkaGZm4fpH6oUeomIR49/k0XMU=
X-Google-Smtp-Source: AGHT+IGAAPxD6J7kBArbJnHS+iLGIEgMqqB2QN7CguVVoXBr8Cvn62ylon9Mf5kewthZfsCshsRxEjwe2AI0Kl0jZ9L69IrYjT9X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:431:da98:3519 with SMTP id
 e9e14a558f8ab-431eb54cf37mr61562235ab.0.1761363724676; Fri, 24 Oct 2025
 20:42:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 20:42:04 -0700
In-Reply-To: <20251025015852.8771-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc470c.a00a0220.9662e.0012.GAE@google.com>
Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>
To: hdanton@sina.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com, tabba@google.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com
Tested-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com

Tested on:

commit:         72fb0170 Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15da53e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcaf4aad77308158
dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161c4258580000

Note: testing is done by a robot and is best-effort only.

