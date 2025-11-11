Return-Path: <linux-kernel+bounces-894440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4009C4A58A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 602F734BFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E93343D84;
	Tue, 11 Nov 2025 01:12:54 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69493343D67
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823573; cv=none; b=LI6zz8BOd+9n6qg0UogrMhBpseSevVSkR9il7/GH6kRjF0CuYTuQ1dyNQSkMh83H/7hMjuihHQ6pJwrbiLNvAQeYWYa1nwRiNX9Y1QUiTNDSQp4PJ6EqXFNp5yv22zYsYEqcHIc+2teCS/tdMvPl1bvau30tEebhfOxK/Z+E5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823573; c=relaxed/simple;
	bh=0wQTgGrNNDVt2uFqYthktj/TJEnRI7WLaEb/wyTxack=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kwc/zVgWe8OhqppIe84rCf6/z1aXfw2LKTahgdfnKSeusUQ6DBqMK6JTETZCvCQqDje/BIuC8MOypo39DOh4yyCEyzlNE0MVbAAeG4VwEcjtEH99L6jw1rMfP7RZLlG0JnmfZkYmag+IYp/Sy5QMtIbwEmlMK0E5Xm1Qdpo9Q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870219dce3so365925539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823571; x=1763428371;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wQTgGrNNDVt2uFqYthktj/TJEnRI7WLaEb/wyTxack=;
        b=Yhhj2VFL1/ZAa0bdVLuaBYBp5vNVooqK4Vk4W378C0Ix6oc8PRTYTuI5g0MOXBrFB6
         TTYDpQAF3dgaWjX/JXEjc62VxGD00+tEstZm7KX+ZPVdrM05yx1RdAqLi857VNrs6F8h
         mNddVMKczFsGN5W4xcXam5HMeMxJ11cOlRM9vOyyrhbLIqzeWXycCmTd6ivSmOuY/XbE
         zbOcx1SZQBoJiNF0zHQ3QeE+r9S17soM0JRNPOpV3nl+KdeGbfhCKF0h6hmyiTT2sp2J
         BVMoSaPja/w1rkaIBzVyOnKWGcl93mYJIeBUYgfeRW/5KbcuqBprHk7SFVqLRrT36iLh
         I3rg==
X-Gm-Message-State: AOJu0YybOck5BaMlY0almy/aDITyIcLRElunKgDMN6T2Hp/rpunjwcdv
	hD0Ws0i4DYXL7afRZnH86j3+2wibPTM9y5ofLSVKvYWnHeRZZ8VZez8DeOyn4C5UqLhbA4F85b8
	srf9GGCpgTEY2HarBOb5ye19ZDZT59e7JLPJ5E5SJAt45y+W2QwCCfzh05ug=
X-Google-Smtp-Source: AGHT+IEQ1NiUgMTRjXveWSlo1TQtSF/1fVfNzmN51/ugUV3wDikW58VGnSBEZoouM2jXIqNXpCQ0nD0xL7C5eNdFE00n/TK+Z9XI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2301:b0:433:7900:f1b6 with SMTP id
 e9e14a558f8ab-4337900f2fdmr104462755ab.7.1762823571588; Mon, 10 Nov 2025
 17:12:51 -0800 (PST)
Date: Mon, 10 Nov 2025 17:12:51 -0800
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69128d93.a70a0220.22f260.0118.GAE@google.com>
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

