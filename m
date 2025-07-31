Return-Path: <linux-kernel+bounces-752421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB70B17559
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92297B5746
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC323E32D;
	Thu, 31 Jul 2025 16:57:21 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE41E51D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981040; cv=none; b=r0w3ed9ITnnoikKrtdj8bXt8kwfb5fk0EiI/lU0Bx1dRLC+TyRQRnb/iwrRI1T/OHbbxSwEqrwANQOPVWvUtalpuqdRUM8iziazQ/GwZGnAOWgojFoyQ88PXKr5KpEA+yWlvTS0PE5L+aNI8e9RavT6fIY1bF+BTTkQhgcokxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981040; c=relaxed/simple;
	bh=Pd7SKnlBwNoYJMuCKXc1pQpcUrJSZsQI109QyY5Mo54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TIrF8Jt7Un6DQLT9+y1R4kDcAIz+tzcwUVF0pFUpOW9+HE1L1yqIzfXE9nGnVa19CiXJ5wxUWVSgzYybk9NJZKboUwguuE6pswr+TG+zVtuWb0UgDpkREn7VzzNweakBjzKKgQjW+zlk5q4R2Na0PCWpMz8OzPhZMutenENfnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8760733a107so50141439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981036; x=1754585836;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd7SKnlBwNoYJMuCKXc1pQpcUrJSZsQI109QyY5Mo54=;
        b=Js+4Axfr3MjNnY7OBIHTQM3LxVfNLpGLclvTgerYizoxuinNSRBLGpoTTQcwM3zxkJ
         UPe5BALWpAmocYqRINMX5b9QqLTDBArS1eb1MSHtI/sDZ+pAr/5Oh/obd5v7kR5digeM
         OzKcFh40m4lA/4jPlQAY5O07uWDOcfW4WnvPq45Iv/PQ6oq9VrfMbBuwVkI41e2bU6Sp
         q6TeVMyvxf1dprsK0Cf2uqTc0QTPmzOeaEO3I5F7eZ6I1hP4uEs7325eB37DR2fsjDvF
         yRHaafnJ+4tsM26I5ihfrA7eWK+YYcOXbLSrGF9/5HCIh5Ai4Wog5kA/ofE8zqxj2jEQ
         7IIg==
X-Gm-Message-State: AOJu0Yxtx8JxHgBPedqdWbQaYRoR2KzQTKeO29QlsGZ0yXVOIzBYqQLE
	t9HIcuYikq26E4ALPbodRJ2qF38+vDE8tSMA4p94GiiU2UST8NP3lvaznWrguDyyPx+OA5Wjovp
	/LSBKtUfn/vBuGjMEZvwgHAQ1Gfl+WYsTiFHeBH8TDBAcsacmzDQb9mUsHaA=
X-Google-Smtp-Source: AGHT+IH/8RVdv2FYybQIxzvNeah57nrjlgOGJvJmA65jO+7cwTckZc32WEkX3MyW4PtWn+SjdHuAmWVTI4IwSXC7JNRIHGgI6Nbx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f86:b0:3e4:b9a:8ae7 with SMTP id
 e9e14a558f8ab-3e40b9a8b84mr16834885ab.7.1753981036722; Thu, 31 Jul 2025
 09:57:16 -0700 (PDT)
Date: Thu, 31 Jul 2025 09:57:16 -0700
In-Reply-To: <000000000000f4447f06202eca5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688ba06c.a00a0220.26d0e1.0048.GAE@google.com>
Subject: Forwarded: KASAN: vmalloc-out-of-bounds in fast_imageblit
From: syzbot <syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: vmalloc-out-of-bounds in fast_imageblit
Author: sravankumarlpu@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 c7fb1692dc0139f95bd4131d3d5fa5eba2ba569e

