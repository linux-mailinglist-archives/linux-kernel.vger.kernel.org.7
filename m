Return-Path: <linux-kernel+bounces-819657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E998FB5A436
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4A317D896
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD1306B1A;
	Tue, 16 Sep 2025 21:47:58 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8129B796
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059278; cv=none; b=DxZacQtL8hq5tVUPymJCJJBQldmDsZK4M9J6F/CHschmkcY4o704FAOGt2X2lTXBtxWzcUIPshntNLmPkvyoFfEixvhrTMWKqW119HMeLUCn1DVDcB0hjKWrdKHVHeeRzIDM5N7gSq/545iVD4Lqg7aDAl+tu1ayriIy+EYowKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059278; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z08SEkfTYryW7+tkBwZFIrhpcmK9WWj1Ug9v9UNuI6Yuc8PeuyMx3NwCnZq7wADkvLBIVYYZ6UymjdAReZ0HFLvMfxFqyBw4gk5DrPK72ChD+dNoPu/uGAvCe5GjbwVASMAmu96GxVIicdqJrRnrmeaPIaTVTXVPEkAA0IfLaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-887ee7475faso1278965639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059276; x=1758664076;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=ON1cIH90DA31PyqdhfMVZauHLHDlfhqdz9jfNY5dRrUBo5iAF4tzc0jQ7Bz3LMOtup
         qDbzex49rIe1Cwu+QH2DyWp+RCP29pE4U1Jo811HFt/x4WxZKRNy4ZG6maISkFl6DLMV
         cfxJx6CRuxOxvxcDHtIMEa/3kMFjor7GB/31PixLM26mD3PmjIMRDW9S7Gvxna9U6Bu9
         fOQi792PHskul292DdWt1a2ILUeF4kui0gEe8eAuBM6i8vb3e/p2bpca3WuPDew4ibre
         io7LURUPfRi1MPPOMAxEIG9I19mgfGnhLenahWq1azpAJyBFPHNgC7QxJmT7I2o6eHyc
         Lmsw==
X-Gm-Message-State: AOJu0YxOZZEzuNJYEBHctUI/bXWqpGmLTX3w61cOzbFBJS5H4CeeITdS
	dkDs29y7b9nPHefEBaLTFHcb8eUSVECa9Krsr1ww4Kqn8ngfUsA3RjVg8e8folrnin1GtaTBrEK
	X83yi8tZYU+tH6j4LdRZpF4XxZQpQWPWWaqkB64qG5acVvcouWFD9ye2b/uM=
X-Google-Smtp-Source: AGHT+IE38pgzZcZobFgfQgoaH3zykuyofGbP4xHJ1q28tJXHb5A/arSGsyCREEDJUvMgfNQ8mVXH8pAnVqXjdabPrYMBnXdBIass
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:424:4c7:b6e8 with SMTP id
 e9e14a558f8ab-42404c7b9f3mr76621525ab.5.1758059276223; Tue, 16 Sep 2025
 14:47:56 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:47:56 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9db0c.050a0220.3c6139.0e6a.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

