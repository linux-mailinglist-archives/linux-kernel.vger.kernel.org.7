Return-Path: <linux-kernel+bounces-866913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE9C0106B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAE3B4F52AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633E30F947;
	Thu, 23 Oct 2025 12:10:57 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79E30F948
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221453; cv=none; b=LHStP/IV8p71wnkmFZ9ivr/zaTVEIEHLGJQ9nvY8NJxlthK9hIZkeM5kRiGyglCZSN2S09EyWZL3dZD3D6UkJc0e+cJWHRCWWtRm4if9DpZVVDwB0WVgjEXdO6PJPZMrmsX0qzdWtxG88an+DaypCvy7wOJgCURQlQ2xvWOWMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221453; c=relaxed/simple;
	bh=QtRLj3vOoZMDeu5ioxtwz0mA9axsP99tGxCDQ49INNY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pxIwEozY77dy/ugZKo2ENDmsZpSPQjmTAFcRZAcNPnMACvYTuii5bGuW5Nz6ujs6fcvH203+WCy/aVPaZmbyokzDBmlsWVmISmTX3G1ToLYkhdR4c6UFNuk/PexiBro/Io+rRMBTDSD+OqQ5zmCYJynY5ab1PXlY76g0y6/pHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430ced58cd2so27719805ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221447; x=1761826247;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtRLj3vOoZMDeu5ioxtwz0mA9axsP99tGxCDQ49INNY=;
        b=ZaEM8klICOBR1tj93Tn3MxE6Wh7FNkzCM+IrafDLOJlrukJs1pbOZr8+x90QtZiuXd
         P8ayWAYGWXe/LHXd3XIpDZ9l2C/ty4c86Wsxaw4O082J/jo7JHipoSQ2pvW13OfiUBvV
         Zz2aC3BloxX9tGzprw10hk89HNZcLJIlqrzL3/WY9ShM6KT1BueE+Das4HlR8NqwGldO
         e1hoZqGQT1u7Fg2/UMrim0io5za7i4XQmXBOcsCdANwyZL+dhbF1yizsJsn62tO7JySH
         Igoa8186TbcW0CyTIFaYfGBtrPDTrLW7Vgj7cZ4KNoTzmEHf27J53KUjY8fB0X4kqDQE
         qlqA==
X-Gm-Message-State: AOJu0YxlCTUkANi3llmv17Ru3wj9bB5dTLYl2z7dBpUFkR5eH0C+pgXW
	AqZIEX41Osh6ayOx6JHSPT8lfhRWmjggL0I/2SqPieqXskxbXAXvn8HeUSVqzlpofofndOf0Lou
	w1tpq5OzWPUSXYbXpVnOvKybZ6WJla9R2Dl7shJhLfNAjC9lY1JksR2NY+M0=
X-Google-Smtp-Source: AGHT+IGXXZorBxYBJbJ5uwF67TnFapsFWO9fYrIN+glLKbsPlGl9/JWSNTaZUb4grPhJVzi5W1XFPkm0QtJ2x2SGwz246pHI7Pju
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:430:c323:2bca with SMTP id
 e9e14a558f8ab-430c5223f39mr174011975ab.10.1761221447381; Thu, 23 Oct 2025
 05:10:47 -0700 (PDT)
Date: Thu, 23 Oct 2025 05:10:47 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa1b47.a70a0220.3bf6c6.004c.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
Author: nirbhay.lkd@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master

