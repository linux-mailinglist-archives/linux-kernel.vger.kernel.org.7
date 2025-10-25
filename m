Return-Path: <linux-kernel+bounces-869851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A2C08DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEDC1B28633
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D827978C;
	Sat, 25 Oct 2025 08:12:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546F1E0DE8
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761379930; cv=none; b=FNY8fDn7eVb2A6CwtKpXFfi71TQJ02JRYFa2GWrMQqF20M/XjjYSsAwjJ4zEO7EMThWQ3fMupWQIPec9xHBJsycPwVYSNTlHWvHshGxfjynrosBzfcUTd11n8y38Nn+g3zlQJz8Vef8wOxl/KCzVZhnZZ4F5MD2XPrG/0/Y8B+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761379930; c=relaxed/simple;
	bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L1DEVg4ngL86Cpb/JTsIo3WjwMo7Z4ey33gTeezMyl5Gj6x3Ly0/NQjnaQ0ZIjFbnOEY0e/kV4Ge2+jtkyn5NJvtkJZcuTP83o34OizZgYNK6WiFtZQB0s8AGp5vKa/lH7/J4/FSAcWneNkOCeN4UR1XLaYuuLDVAQ8athsfaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so35555505ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761379928; x=1761984728;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
        b=iOhVMQXlvyMGH8uwvOi97K76LgM3XjW7fId6dWWTB0PMsLr+lu4izRr5Q9dMExT0oW
         +f0z2cqDGktuRhONneQYUMVHoLmJ8BYajrg9/HRmi+b8QYft0ykmgHsC0IZxdFn8w4CL
         gNSheXOkIcWafUs00H2e/XOtapnpbJvqr30jGFX3K30EaIkEmCYUtphkl4ByKJ3ezuq8
         Fhc3LkYAhMYQJ6zxdn0Jc9M7woz/zQffifZcPzBRgulSWr1nP15InxaZ8O5bPKpUxNBO
         fQQzeJTnLGR1aDc2p5IcVFJknzoesQzjyu5kZK8k9kx2PGiB7fSlwoxp/rYWcxi+jv4D
         cSlQ==
X-Gm-Message-State: AOJu0YwhkR3wi6ySKoOo5+G5K9JmW5WxKOvnex7q1jfQtZwbA2qYShHb
	8TYkYhuCKf3AnZp+8JY7TyLgPjpvf/dQ12aTY+JPXGTVe8tYbLfK6rAAWZ6tcv6Kz+aiL3YaP/6
	LIIgDZRPQu1ALmje/lGsO+0toxzsobe5L/7wlyI7gkefpMAMUWHGqgdeZZYs=
X-Google-Smtp-Source: AGHT+IGmM3DpFRxzSw/cl5n7qNjvB27oWT+PvZrKgNNoOpcauv6PPy1waouzbZGh5a2rBaZ/BZKpMomHQxk8z3AWIj4yH61RsuBM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a66:b0:42f:a7ee:4922 with SMTP id
 e9e14a558f8ab-430c52b5af3mr403049905ab.16.1761379928231; Sat, 25 Oct 2025
 01:12:08 -0700 (PDT)
Date: Sat, 25 Oct 2025 01:12:08 -0700
In-Reply-To: <67867bcd.050a0220.216c54.007e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc8658.050a0220.1e563d.00c9.GAE@google.com>
Subject: Forwarded: WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ocfs2_unlink
Author: eraykrdg1@gmail.com

#syz test

