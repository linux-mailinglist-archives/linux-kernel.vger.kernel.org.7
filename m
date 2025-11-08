Return-Path: <linux-kernel+bounces-891400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EFBC42951
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6DC188E557
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3225A630;
	Sat,  8 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC20157A72
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589464; cv=none; b=kBc//lv/vtic7LYUiQ1jJWoltlu0hIZtmOPdD4DPX9Rd9cFG4zo9uROUrHMeCLDHd60SGTv95cEFTjaIFDp0zYItaWtTmw8Hiyn7T0JEmp+TMcDFZeNuiV9UHR5FHDv1rYQuLcjSKYFSsswcyfhSrXkqccM3QSDui056a5DPrns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589464; c=relaxed/simple;
	bh=Sd1onhFEyxcpsF+cT8qog4T6VoiJSrCUYcxB5f8Og1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hRpyP9wQIj4qL/FISq9hOn0o/rtID9wN+tbImIWU8f57nlfgtATgIND8O/IF8IyD9dqtODu3RoX4UwhTg/491276hw5Sn23i+wkyQGisuFw8Q+gZNT1qt8qu/+HgkS3asRPO+iZTWlu5x6kk8YehIwqvL0T3f+KzGuEm/oPlOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9486920a552so463162939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589462; x=1763194262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OZqPpwJs0a844CEW8SvVdFDB11K6NkjQkr9jfusKvQ=;
        b=aZqtSFPWMgS4S3C645E0Lt7QwZzxmxTyYTnFChi3ehS1WpLXJog7t6famlD8IaeUaP
         TJa7luB7qS7Gj8SJE3MRhPNlEtUf31cMuxGTXJ6Ki7RoSZxOpxSKKU8VNuKNmFL7B4Eg
         z9nXfaoFGL0OhGyJ0m60rakqffNnOdA79FoZLNtu95ceh8FZJKEmrPDiIIplSvZEk6zU
         TW1iuVxSns7w3HF2z6jOmIAVZ4dLBHfLw7fSn+V8UI/+Tlsua6Ol87djllxYdUhceTF3
         ZctRh12gxx6InGfzl0GaQ6vximrGBSgMXopW1DT8mkw6fFU8jyCvXngIGRJRg2VjtpZ/
         oXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX02FbiAsm9RAAlj+irIjkp3VlI2+crSy60JYECGypulXRh0aLdmFMhNL24+h/25vo2zsdKpdcAiKFf1Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HdOEteI/nWEHGZMRkartONhQhAvXjyAtpvuYDrSi4yxEOMIL
	Nn9Mvh4sUQMGZnR9kx2R4GWMYEMLi6bOTZR5f4pSP8PX9mbO/gAxF/UC0K/SH8vlwcAOlMhmOPO
	/Bdx1MDa/XWEmOx9Kxjnd1k19XrkKHxvTO1LPu9mhP78xSDO5YLaokiGZxCw=
X-Google-Smtp-Source: AGHT+IFQwG+5ABxrlfscPg2A+g2v6pWKIa+d0zFkzP5ybxNVirqNyrNV1WRhss9Cnry9ylJnOnmYUK4zRedX/gZ5KecRLq+NBT7G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2787:b0:433:2eec:66f7 with SMTP id
 e9e14a558f8ab-43367e48d19mr30798975ab.15.1762589462079; Sat, 08 Nov 2025
 00:11:02 -0800 (PST)
Date: Sat, 08 Nov 2025 00:11:02 -0800
In-Reply-To: <20251108074339.9025-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690efb16.a70a0220.22f260.0077.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com
Tested-by: syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c5117c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11746a58580000

Note: testing is done by a robot and is best-effort only.

