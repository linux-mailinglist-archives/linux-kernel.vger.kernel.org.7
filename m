Return-Path: <linux-kernel+bounces-873588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6CC14357
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D37F1884F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A23168E3;
	Tue, 28 Oct 2025 10:46:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB03128C0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648368; cv=none; b=oaRZIN5777NYNot/szjXJ8r6IXtCl6iTnGUcrERdCGc0pj/q/nisDEBUmb4+KIAAGsuPrWEqSHkPUXrLIDDJjKb9Tgh+U0mfh68Y6l4/vC4EDPpHYHB60OqSo+wzbJbpUg+bwfPUZgMjNo3VqOkRh1bSqqT94BnGZsBUpqvk2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648368; c=relaxed/simple;
	bh=n0lgWamzCvoFDk7PQ8MFGSmDHVtogc9UImiyw5MDvy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NnJxYsu2M5J7YOhbDvTD3s9qLaw0Xw72k9ixYeboywQe2Vo71T66w1lnQxvSTMzCftKtILov6YbQwlMvxgm5miaGC7eXFRB2epSwsRiy+AxPDuum+psb1S6TfyIOeOQO0foMrpGRK8YpUq98d4pJ1DV4bU2qQlf/Gg/m6IHPWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d789ee5aso74204485ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648363; x=1762253163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHQMf2L/8ygEN+0jfa67K5QwT91j1LDD/VkFvGs0bs=;
        b=Z04y+UqbgaPe1kvzNEoXMPvIKbQkWl4BpXn+UI74S9kzZv1+p8/+F9KQRSyy78n7Uc
         02D3JqqLpW2Q2sJQaBbpbyIFmfx2nbWPnj8ULr3xgD2xCtHHh7RIKfmOBQ3LMKkTQiZE
         i06ZK0Q9J4Bwd2GYU5AEVm3W2QlLRZMm3eKbJCA5y800rQJPMQq+HoezBSmRlMJlAC7b
         lMoe7suiLjy/PheW6WBcpueJQSfG5UkKt8IhBRNsAJCTZHhhlkN1YDBVJUWioTOkNjH/
         ZGtRtYD19aXDodQjzHA5G7rhodxehOqltJSWwe5kSdSPuOfE0g/9hfocRaRdN7EBNNSj
         E40Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJZSowWP4Kd8OI8XGKv0UG2HFI6kB1ReFLnHS7s9VXu3+cuffy3nvtD4Zh/Z0LzvLZdeAl0ZkO6HVGY2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TP3OpxVxE0+X78MNkS5LLS50bIWnHqJbhrsKqUH62X99uICi
	+kmuSwyyWbO2+m13snD+EqSVkqRzqVTdTfdsfw106k0HuCNZgk+yiZ54ncw+few71MNE+vHL1sy
	Avi4I7Mr7b5/A43oalcBZYWHD4iHoB2Af0WJ80i3xrPWzYu3C7Vqi7zqQE6U=
X-Google-Smtp-Source: AGHT+IFqj2uPMgqaOOfua01acGZi2kNHl4jhyDNTkWGp0KICAvasfFt9nDZW4lnVhl6XnmERM1tw3N4W4le2yOV+7DSpVTimhnEO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:42e:7589:6290 with SMTP id
 e9e14a558f8ab-4320f6ccc11mr47697685ab.12.1761648363591; Tue, 28 Oct 2025
 03:46:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:46:03 -0700
In-Reply-To: <20251028104200.EmW2m%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eeb.050a0220.32483.0186.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c067e2580000


