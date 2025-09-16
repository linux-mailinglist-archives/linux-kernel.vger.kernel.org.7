Return-Path: <linux-kernel+bounces-818158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7417EB58DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146371B21C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330E225761;
	Tue, 16 Sep 2025 05:02:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDA1397
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998947; cv=none; b=kyQXmRGBNt7TbIl1JhjOflyHidsHhknV3RTifufFN/sm2DGXnMsTCTChZ98tVTURnHG67/ahTXwe1UMkna4fmLIpBlJ8iw9hVYbVngU8dyDCd+KmrVyuhXF4q9oK85u/nnNVWTWhjCmLoz8sxoRDyA9ot7wV7MoznWsiun5JdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998947; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ushpHKZwPGvKGhPDog3fuQ+c/t3DX30W9tQgiqco9oip29zS6gKdNRNakQ+vPERPS59sKUC+xx0i7kloAzVH6QMpyqnINorcX61gdMDeUa8OSXuExlYTxn91rY1hcJFGpcwkKcEPJV7yF8CppExPxvJu2CwBXnnRTMUiopQp1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-423f9cbfa41so30656955ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998945; x=1758603745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=Nmo/hbHd84PGCNYqEz35YkWaKjXEAhpjuHlxdhwj/vfyhJhdfjOwWultOC6jbBnyT3
         yYItaOMP6YwJM/+I8mkC1KEKcUk+nYqI2kqP4kPuwTL9htAL2d7ASzDh2RodoB2VNJRh
         qNcGBFBVSEsFviGFl3yOLA28EGntdrLZIEVy8xxXgUpNw+OvzK+f0J3to+ZeP9O+VKtD
         GY82LvB/Utue/PpYKb0b2DQ2iSxjtJGeEvP+cg8/4ORj1sYUEnb7R6yQeg3ZfJDlRh1y
         j2JcpQwx+7Ig1LmCNsahBsVjd8RTUD/BlGpuW1iSVieOpHg6oaiAqU2CYtr/kjCulO//
         bRIQ==
X-Gm-Message-State: AOJu0YzMuriv0v7rPnm9abRCKyp7BzbLrSk/xoSiZ7onNXVaat7oldiC
	GdaFntOtBvERqbbZbDByhNSs8Qw3Da3CHwrlmvjtIBoGZ9WpVafsHh8TtETwMC/0fxNoSipfOPL
	7Mfj5HYzcCrOrS4mD8Fb0A9iWXapgAr5Zj7EZYkKGebMPjPz3AkONyobYJOM=
X-Google-Smtp-Source: AGHT+IHMHkpRt/HgUcimG23Sa/59HAjzHXQ7Wd8VcPN6uRXd8ROaUxe3zNxb6ErA590qKrt8k8b6C+3OlX2XRq3ErZ30mdmBjRa1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:41d:5ef3:e06 with SMTP id
 e9e14a558f8ab-4209e834288mr171610095ab.12.1757998944799; Mon, 15 Sep 2025
 22:02:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:02:24 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8ef60.050a0220.2ff435.03bb.GAE@google.com>
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

