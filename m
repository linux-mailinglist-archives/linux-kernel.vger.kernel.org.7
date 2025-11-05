Return-Path: <linux-kernel+bounces-885731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2982C33CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4194918C5C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217A22D785;
	Wed,  5 Nov 2025 02:41:19 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC83221FCC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310478; cv=none; b=KGuJ1k1A6pGWbSvNwP5qSYyYosTJGoZqA+MFo8LtJ/W3mmx7ePLP0kcCvEl7edzA/pqSR74Wx3NHUF4U7LPAbxOVmBR0ijqQ339yhur7Oeprx/T7+ctNaShvyCB0KLZ6lRGrBNvPfcnGwW3JkTvOYFggxhw2Ijk6j0y5IteCi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310478; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/OyvilcA+81/YzUPzx6o1jBrsXtKpjnfUi4dw7oRmmQTqKyWpIAaua/q7G60aLzynObDROhg+bRLXulDHPMKTAuThaqmgRKPfFuXw1OkVdClNVtGiLtsTYK70z2te6Z9FsE1NwCEIjlYTqHpzPY2FUBeMANnHb03/CqbiVa1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433312ee468so4518895ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310476; x=1762915276;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=gu8AX0Tn9SOUJmAPMUa3AfqszHaAAFuwUT/LQAbzLGkX3xJGyQ1s+Z2Cbz6VCAzaa/
         Cb6iLEPdZ7nDDR00DAP1pygvMrXmNQWfTW/Kui5jfC02reQmfYdDsDbOksR9m31xxprf
         biiAyceYCqoPtdijcK6r9ty5GedfUqYZ0Ia18sUAamW/67jQerxT7izZKKleh+SJ8NQT
         Wz3LbfTKiqmrMl6ImgvPfZoavH4qmhgHXeW+YtR+hOdqKw7SWoTkr5lNB8G7AnQ1hf91
         FASPtGqWW53QnUt44kBbG+R1//+4mSYztkEPTFNRw7FJDjLtFiMfNg4iB6Rl/7rckD6x
         z9GA==
X-Forwarded-Encrypted: i=1; AJvYcCVC+cG8E0XEYnt9sAqT85YhRxm3+Ta2NYtSe5FgcUIScjf0yCmdKnNL4bVfyl+B/MUp4jO0a68W4wvGIdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswnBKiBxNXhsS//YEhlke/Sc5wCmm9HWapxks56/s/rA2P98i
	XFbwYiMEv4Bb2GnM/TLQWcpXv4tZsEdrDb3hkPdD5+4Rir2RzWvmnv8JbbhlZr68LIy6DbIxTO/
	GdyTUnSGyoZ0Om8s8gT3pCtJ2k2eYoSqt2+OvKCqxazATp6o8cAhwt64GU/I=
X-Google-Smtp-Source: AGHT+IHn1I0na2eQYhmDaS+CFGlkJ8/sOH/VNzbZeaDqFqCLaE8H6ck1EwJUU6s+CFz0kzcme98O19W525Aohtw24EmnqhTHwWEI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c3:b0:433:3396:5fd3 with SMTP id
 e9e14a558f8ab-4334013f5cemr30262115ab.4.1762310476435; Tue, 04 Nov 2025
 18:41:16 -0800 (PST)
Date: Tue, 04 Nov 2025 18:41:16 -0800
In-Reply-To: <68954e82.050a0220.7f033.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ab94c.050a0220.2e3c35.0000.GAE@google.com>
Subject: Re: [moderation] WARNING: ODEBUG bug in free_netdev (3)
From: syzbot <syzbot+8bfd7bcc98f7300afb84@syzkaller.appspotmail.com>
To: ahmed.zaki@intel.com, aleksander.lobakin@intel.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, samsun1006219@gmail.com, sdf@fomichev.me, 
	syzkaller-bugs@googlegroups.com, 
	syzkaller-upstream-moderation@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.

