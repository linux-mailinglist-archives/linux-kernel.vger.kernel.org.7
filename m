Return-Path: <linux-kernel+bounces-874910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01287C1779A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322851A20561
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD91D5CC7;
	Wed, 29 Oct 2025 00:07:37 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58AEAF9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696457; cv=none; b=u4q2AgJzs3k/OfSxg8B6wwTT2i+3uhM6zvVDe7VnNJxlreHV9+zLf4NzM1fypJBrU/1SPaelBsOeHqrXJu4GN8sbUN06dVhPI1gpkahAMXBJoyV6Hl+LPoq2VFVHQrd1qs0S+RvVENQKAnCE1XxZnRo8gb9+B2bk9SAWoJ15VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696457; c=relaxed/simple;
	bh=GDf8Ul3RJyttQEhWKJl2eS4q73xdMHAKwY8j3vHSnnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dUEDuAprcbLJjT1vDC2HLxtXrXe5qQ2UBfm5QjGRO5KYcvGdkwDQWmEisWrfpYq8hbgizwG+tyltDjVW9+00PiprEH6miYNe8wfjtFy9Wj9I41bN3PkI651QfUT5zU9CMT29APJwlqMmbnizjj/PPoWaZ7J7mIQDltctkJ9OG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-432fb58f876so643505ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696455; x=1762301255;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDf8Ul3RJyttQEhWKJl2eS4q73xdMHAKwY8j3vHSnnY=;
        b=pNfBW6+JrahHvLSVxuSckzRNLjrlecxh0PXLr4M0c6ZvcXtUU8doCsFjm1/fRrPNKl
         NLsEiiijx4lGFY+Ss02awFwZdkCvk4c3s1QJcH07GT5qHAHXMQOr+aQ/ajz1mZ357/sP
         rxKvFkAl1GHC/Ji9bhNYZ2dm747wki0C1dwcot0BquLvcsati5LCbwoQ06LOMVkvyDIB
         nmup0stgQUz9KmbOh6atkRj+UMfDD9px7fNLNPar3F4L1yV9z7eCy9b6hw5Co5AaqWch
         fbuI9qchfTFtAJdr1vN3V8zGWLOmSa0hmsRqxMrsLvOVJA9svM+br/bHcsgTxKSL6rJW
         eQqA==
X-Gm-Message-State: AOJu0YzDIsxVWD30Deh408gRxtwMmXFYBz3rXFPCYhpif1VFrTRHaYKP
	IVN9GA6bwM3wH/PjiPiM1RcSJNq3gUbugxWlZGr7YMn7TNsK9g4t4lGhqoSA3DVGBFzPYdsxe+f
	F4nmdlpPWdFke1rdEV8AnQiybNFotr42H9AYpH6kZsEMQrRlkgk8tO863dqg=
X-Google-Smtp-Source: AGHT+IFrVLQ8qTxiutfUP2R4L9KrDHocOu225E63ZmsPS0tEvIgjfZ0vyzHrt22glMbiW3fAP7WeGpr5hZfN1QjWtz+0g3Q+QhlB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:746:b0:430:aec5:9be4 with SMTP id
 e9e14a558f8ab-432f8fc8049mr16309325ab.7.1761696454820; Tue, 28 Oct 2025
 17:07:34 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:07:34 -0700
In-Reply-To: <66f0a364.050a0220.a27de.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015ac6.050a0220.3344a1.03f6.GAE@google.com>
Subject: Forwarded: kernel BUG in ocfs2_truncate_file
From: syzbot <syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ocfs2_truncate_file
Author: eraykrdg1@gmail.com

#syz test

