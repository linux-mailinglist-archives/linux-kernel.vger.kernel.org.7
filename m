Return-Path: <linux-kernel+bounces-886844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A1C36B21
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CC8645F00
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45F335064;
	Wed,  5 Nov 2025 16:05:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9A33374E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358731; cv=none; b=j+cB7CYVLYWPf3qi4tWeMWjy7fXvEYY6DRb1EzOs65rZNVzPWGG+WTHtBxedBwV0gh4VdVlRJ7WRl7A/R8r5k8d1J+ka8774+VtLTLDasCTHH9DclJmn0ptxK1p7/e+QAJiGOUMj/049WNK/O0mMB7L3Oqvejx1linomfMmD0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358731; c=relaxed/simple;
	bh=dn4UMedC7Sk/Ra/s80vgLZB69FibUiTfYSTiYhu5Csk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pIu+TG9UpHyTGIFBILpTrLkSUKD/6UuXnDVK9xYRQrL23nV0/J4zATnJpVo+lzal2qdL4vjGiLznChx3pEESl58wu5nArZDfUuWVffBwUu8tMSJPDhq2o5i68FffaWT4RgWhhmchUwkgRkvXgFxCDz3C6ygoQp+FYjpHu6w6Kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433316b78f4so30129045ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358729; x=1762963529;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dn4UMedC7Sk/Ra/s80vgLZB69FibUiTfYSTiYhu5Csk=;
        b=rsvg0aCngzfSEt9oOEd1FoL/8Y8uZOKmtPDdlV6sR41seKJBNBE/TCFduaE/YrUuq2
         vHnXMJThPHrOLUyfgfy1RmHenPYM/jBcHcnrACilIvRsmBmmjJi7lAbGfa+54z3F8v80
         vjKWriBXSclLV5+YJyMutbtd60OlG4nS6URbqRhB13iMPHThOo1XUWRwDlw5yPEvVOJh
         7pvCRdDVZ96DLUGJzpxOu0wdtdMQ+ukfRhsmA/ow0yuSVm4WqlpLJdmi26SyUcO9IBrK
         L0VctXH3OYAdYNqbF2a7Wn+igNjB2oDhSf3nNm+mdu0RLgipin7sf4Y6Ng4iGMj1s25F
         HEig==
X-Gm-Message-State: AOJu0Yw82Kx3xiAuP8hvy6PsyRXBJuYP0k0B6OHN8ccTxpvhCBWyo5NO
	XSz6/EdvswujPOq8BbkEiuABI4dlJMtiUX8+gOIQpmbfVm7wmYSoVG+qH5G/r0PZGLuWscex0H5
	8Md//f7XnkQBaRpBdWWbl3og2SAUJB97vhECkOo1UCqTTVZcdq2/q/frO8ec=
X-Google-Smtp-Source: AGHT+IG/KaRhb6ALdq/apRYYRhb6++D3Wv+7Pa4siEhyY7QwkycMog8YxDJltoRGz8BD02Hq7XWeW1CiXnnfObVvyu9kjcKe9opO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:432:10f9:5e0a with SMTP id
 e9e14a558f8ab-433407d9accmr46249535ab.19.1762358729355; Wed, 05 Nov 2025
 08:05:29 -0800 (PST)
Date: Wed, 05 Nov 2025 08:05:29 -0800
In-Reply-To: <68678de0.a70a0220.29cf51.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b75c9.050a0220.3d0d33.005c.GAE@google.com>
Subject: Forwarded: potential fix
From: syzbot <syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: potential fix
Author: rpthibeault@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

