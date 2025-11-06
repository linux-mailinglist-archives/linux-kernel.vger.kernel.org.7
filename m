Return-Path: <linux-kernel+bounces-888753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53EC3BD54
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B31B4E7F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433433F8A2;
	Thu,  6 Nov 2025 14:36:53 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E824342C8E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439812; cv=none; b=hK/srQeYIwQ28wHz3mp3qGoHmnOwR9D5xLfZQ5j+6XAsLk8RQMRj78jsx+iZ9OPzyKgr1DKmMDJCzaKPIYmG3MdfHfyMCj00kVw7A0HxKcZD6uaeez3v1N7xwO6CvDint16bjqad8zdI2KO0p0Ddp7P06xBXzGagMJLkVmfOkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439812; c=relaxed/simple;
	bh=ijHT8MD0qXeeRdrNvocShs7G6xb5XEhV2+zLzJTXK7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dnx06D8iJ839qcuXUlPRm/b5eAqjR8GGMhX87x4ilLmQIkmYHBh7WyUnX7rL5PCM1j538xh7wg7EUXVEtXEoRCvorU891r/D/SgE46jd+02Z7+839OqSkIG9JOqOg+NtfhZ7A9v8w2gYc6eLjUZxstk2NbEsj8y6ip8qwqfuSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso10956915ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439810; x=1763044610;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijHT8MD0qXeeRdrNvocShs7G6xb5XEhV2+zLzJTXK7A=;
        b=RS6/whYflqjy+kSkI+XlqFPsVb5LC78xVHEIaD/VvDlJ4YR5K6PbbTUPBtBHM9iODn
         Y1UhCZgsWijR0PUesAeSyjX4aqmstg+cUo1vqOfiPJ+i3HhdMbph194MJKFYjkVPYrr4
         GlJjFIzd3Oo+cIm/6wLYCTLeasiXrczw4BLuuA1soxSTD9ZeCYhFi541yEsStc2az/7Z
         Ggf/SMkyNVLbK/4RNaQPG5yx1/qx2KfddlCXekcKQrSupyhiTnv4vpJOEUfPOjrwQqpp
         mIpN/lMG7HxTflKFz8b9YX0F1RebWILCS9PF6g8GYHRnrhtThYA42+6mPMuTBwq8UC0y
         ZrdQ==
X-Gm-Message-State: AOJu0Yxg0toatm0eheGKA5YpQLRkuSUkFXXfmS1va3Lu/zP0VoW8oegd
	j3LaNN+h/kT3tuyffMugPOVPunHcy0z9+Kam35t5wGxFOJZrWIvjpvOUPSa0745xS67zxlAwqBc
	tVf6SAgaf/g5KSFs5OAl5QqMOqvllY1KFB8h+pTto7c1MQvlzgpCAH5cC1/Q=
X-Google-Smtp-Source: AGHT+IF3mUrMGlgk+CEBkD+I12Sgd30CHAGVTXRSt85Qi1Ff+BpRL7w6U8K3JhAhesAkkwl/Wkq3sDv5cSIl/nPZbK2mshMe8scu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228f:b0:433:290d:d978 with SMTP id
 e9e14a558f8ab-433407c369emr96756285ab.15.1762439810220; Thu, 06 Nov 2025
 06:36:50 -0800 (PST)
Date: Thu, 06 Nov 2025 06:36:50 -0800
In-Reply-To: <000000000000a4a7550611e234f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690cb282.050a0220.3d0d33.015b.GAE@google.com>
Subject: Forwarded: KASAN: slab-use-after-free Read in handle_tx (2)
From: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in handle_tx (2)
Author: viswanathiyyappan@gmail.com

#syz test

