Return-Path: <linux-kernel+bounces-862596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D30BF5B63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDBC3AED17
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99832AAD1;
	Tue, 21 Oct 2025 10:11:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F512EF66D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041464; cv=none; b=P42eh6JsQCe48ZanQnFR3y7B7A4wUasG5cPt+o+JVJ6u6PU33qO2V7ADnDNRK1ngVg73BEPKa3zVCPNYN4ZcH9KrHvTWvpZXFEpuFTwiDynoIbtWtKx9f/HMHTCg+rc1I0VcwhKL6AIGr2AzJtq0xx/ve1BLHV8ZHW0+NgOf9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041464; c=relaxed/simple;
	bh=vpXQiflVU7E/srPq9JfjysqPUwZeetf3iBJFxoNFNfA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hv08sx6+II871cLYjznmQ8+62+3x7WoVoOEhtq0rtO63t8tAmacPaGjq+BkP8E5SrGPk/i0O0VxI9rUFKYZ8KYkrFueUUGUqCVMH+2fyhzpBA/pc2Maa6D/lgb7zas/YS4/rKBF+sbIXAK4BfPqiTyJRHF4Q87VN+Jx+JSzrJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7ff77197so1223376139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041462; x=1761646262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijl+KuktG6GVPgjZkCiCYwgydFvbdcvzoiJcnFOxm7I=;
        b=FWybNyTG+K13usTeynQsYSeyBWKrXFUpIY8xTg/XeW2r5womqa7gbqeOGqYzXgLTUR
         7oAfCLjCQVqTdqzLEOpBky12Xd2mzfLXq2nK8S2HBcz8DLCTWPt2FirzJJc4HwFNQ8jc
         tGrMC6L3kLHZ+9zrVu6e0JN3FY/dlhn1MNbT1Xnz8+IpLDjgUuLQAQJyoTxw7wByUV07
         OL46xyLx9wcPGkn9k6QUEMvXo0m7A48o4+zPxcr8J4a1xxgW1lPvho1msD6Au84MPh97
         /v2J+aeMxsLdT51woxhwl3zNLqYqffExFIHB5x8h7ietl0oU/Kdb+f0FksMz9smCgqbe
         e3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWrhN5z50qYAEEYsCyz+pBPPdzxFT6gZLWzdYXj41Zc5xQtNU1TRRCtJbamGAfToKJVAI37Sun1P3ChZSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFxOl/6y2xAFbYYeFcJILY/GAX796WIKzVFp15VqMqHxdz7G7
	lva1FpMCQllczqX3Ow8HGUpZnArAS1U0wSh1WlgPVPMy2l7+Qwt9IJPm3SglH+4YZoKZn/4sJpt
	aZHP8nQN0kDUG+CqZcBlLVHiKzzslTmUA5y1ffcGz9tGeFE26y7ECBSRJY9g=
X-Google-Smtp-Source: AGHT+IFO/PptUIaZovR6keuCooSX+DOI1vkk7sEagxXGmiTLgzZnl5FSVhzaAIb+vmqRsREXvQCYmlgS7kfKa9KhO/ZMeJlBHq+0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:718a:b0:893:65c1:a018 with SMTP id
 ca18e2360f4ac-93e7627ad1fmr2655618139f.3.1761041462284; Tue, 21 Oct 2025
 03:11:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:11:02 -0700
In-Reply-To: <mpv4ljrxyucr23x4hj7k7s4vmtvv3bgeq7uct3t44ghaw35l4r@wanp7mklhw7x>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f75c36.a70a0220.3bf6c6.0003.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mhal@rbox.co, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/vmw_vsock/af_vsock.c
patch: **** unexpected end of file in patch



Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17204e7c580000


