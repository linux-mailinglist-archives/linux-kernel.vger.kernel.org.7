Return-Path: <linux-kernel+bounces-874891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E1C17590
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E805401D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F536B960;
	Tue, 28 Oct 2025 23:30:12 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30136B964
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694212; cv=none; b=t2qmkso73lNywVoQmp6jHdx6+0bNdHptBdZqPgB/iva1lZYtL/w0JyIEPFI+tmhmZNk4dDmYaWTAlnWla3ibDHBaTy2902FtWPfE7Y+CeVp4niO+W//y/GCTkihOhMdE5JFKlZGXE1TIGLXj70mJml09W9boIeQwlvZ2N25uFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694212; c=relaxed/simple;
	bh=GDf8Ul3RJyttQEhWKJl2eS4q73xdMHAKwY8j3vHSnnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lz4MLsLuEJDgtqezo5LgfPnVKFoscGpAA3whewmDyBB126p7iz54MAeqrkMMM7itx2+jsxhiquwwSxxXBPM73cSM0w+/NCIQRSnXMh2ssjaplgWtYfyGVR02TJjexmXT9IOZkEn/VEyo6AUZnPZSOl788GN0S/8KSr9HTG7r1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d4a4dea3so6425275ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761694209; x=1762299009;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDf8Ul3RJyttQEhWKJl2eS4q73xdMHAKwY8j3vHSnnY=;
        b=IivVbz1DTYhyLiaB5MMC1CYHWKEPyIdADCEEuW+nD48JCH+7CmHKX6Gl5mQTe0C+lw
         JD8Jxyp61GyYRJXTZoSFJtravdR0c77VnUJ9DIEWZ0pNf9Vsc/eZUMDw8Mw0BJh3Lexs
         Chr97qjFGX6NTTyCK0tpTTMk9Gg/n9GZNWEpyXT1L2FG1qRse5GPb5WlwCd0hD2jjilX
         mF+1L4viXkFvE1nxyx9ZEYRoqoTe0l93Ba170IW+h3sGnUbhc0ywX5IXi9/s8z96kcBL
         +h2XgY4eOqy4/LMg/zBJwAPEI1CwXW37HS9dShWlhCP9Rlc9AOZNtajFQp344BUwuZWn
         g7FA==
X-Gm-Message-State: AOJu0YxhHyKa+etxLm28zcOl/GyECN4latZGICkykQ/wSPwETaV4zhCd
	XsqJrmIM9m3km8CKnSYanAmww9usTeYsKCWVZWEn2qfSPC+oyYvwJUQwF5E3TefwnezvHTRTjnU
	OalKHPyioVb7i+ymjIyJzrv9ALKRs/ain19jg0KmUppms650Tx3nSuhDC9RE=
X-Google-Smtp-Source: AGHT+IHD38991iz8Pvj88XpEuGr2XPqjWmdIkhquN4nhCcM6z3TKsHTje3rDNr1dapgI2Vn9+itNDsDvezYHyN7DS+USYWsT2dBk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c9:b0:42f:8bdd:6e9c with SMTP id
 e9e14a558f8ab-432f8e532e5mr15390705ab.14.1761694207782; Tue, 28 Oct 2025
 16:30:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 16:30:07 -0700
In-Reply-To: <66f0a364.050a0220.a27de.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690151ff.050a0220.32483.01e1.GAE@google.com>
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

