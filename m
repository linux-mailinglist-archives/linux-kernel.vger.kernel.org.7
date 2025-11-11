Return-Path: <linux-kernel+bounces-894643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A7DC4B7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CE233498D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7F1F03D2;
	Tue, 11 Nov 2025 04:50:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489D4369A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762836646; cv=none; b=q7GLvscWUmzYCAnwc5u5EkLyUQs5ZBwtiMdxFacc76dCjcwV0MmOKBopprVUxmhRWdNIW9G8V4RkNPczWH6zFbd6qNSulnFXqKSLz1TPpsaIZhjO8862BE7LwguNfaSZHbsgQyuzU8FEJgw5TYdwTiGLVpuMBVj4lVhVn6/bevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762836646; c=relaxed/simple;
	bh=0wQTgGrNNDVt2uFqYthktj/TJEnRI7WLaEb/wyTxack=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p9S5CT9YMopnqYlloeRPx7o65pP6wsJ3q78gZTprU5lzXGDRLh7xbdBexS6AAD2F2SVJuQX7x5w9jHWjieJH89zpO1hK6kCHbQvcDK6uD+HKsJ03WBvmwV7/vy21ferugXn3fF2m4D3bxBVkOjw7V4Sz5w0xDu6xpKz0rByLF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-948a20160ceso162518339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762836644; x=1763441444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wQTgGrNNDVt2uFqYthktj/TJEnRI7WLaEb/wyTxack=;
        b=m9jFf97HRD9WQ89rS67embZ1DunzbF+VhECuyLUadMZnaWCDW5jyc9psSmh5lzLEEF
         27v+L8dapkItwSD7JrhzlIkLjJ1i81LDJQTCM5F4QawM0q7kbOEvB7+7x7VccP/JqFMU
         JhdPBpZXtqGvVf4uDMruRWyCAyDGiULfOvM0NmTKmZEqMSer0ZGvAvcl57UywfG7GK+t
         Xh5VAuEHONp2Ys5JwdzS1Ka5F0SpxOt/ajbB+a/nHLMa8BWbhChMlqWYEeIKUpP1EoTp
         +Xs62F2TG3KJ49Vgbcl4bw+qPRFO2ppu+C88W8nmrDYi439L3e9Lzej/r2IFRcS00mEv
         zBHQ==
X-Gm-Message-State: AOJu0YzhUwaXP/n4LiiLd3vpY5r1gug8o4GbtKvQy7UTl8kKaZcS52iN
	RBJVlHekGjQhwjbMrmLBw17jyVFupH7NCZ9V2hTsrQljONVBbzVsmBPXk0L0RbcZqctEco/XYjI
	CtO99VZZCHZbVs7Q+91DnklQ4xbFBPlGPRHh7EBdkwXyaLrZTrv5Nl/wG7ng=
X-Google-Smtp-Source: AGHT+IEYIj2P4pmw9QBjSQVfBetOym8XUncrMQc7az/FQDU0ZEJG49dNYrFvg8y6ikQAWi4GUEyZdhQOfHjBLC6nHbEJAEQPqosp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228b:b0:433:330a:a576 with SMTP id
 e9e14a558f8ab-43367e37494mr159085755ab.14.1762836644052; Mon, 10 Nov 2025
 20:50:44 -0800 (PST)
Date: Mon, 10 Nov 2025 20:50:44 -0800
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912c0a4.a70a0220.22f260.0126.GAE@google.com>
Subject: Forwarded: Re: kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: kernel BUG in ext4_write_inline_data (3)
Author: albinbabuvarghese20@gmail.com

#syz test

