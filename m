Return-Path: <linux-kernel+bounces-867964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A59D6C04059
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD51F4E9EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159BD19E7D1;
	Fri, 24 Oct 2025 01:29:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35284E552
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761269344; cv=none; b=c110xLYuSNKA1St/JYKO8wJXNunMnlRshJ7vcYR55uvp532HkiEaSEt7JNoOa3jwC0pKa3hpwVg5Vov6+q3yrAd9oRKpmWCPD6c5KD5b1XKjWsjdM/mu1fUbsi2qcL9WIS7CKUbcf1shNalOOG6OyXgV3VNgX/40Rw0xkwM33H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761269344; c=relaxed/simple;
	bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MgcwGu8iesh7YtsNs7Db3wvDlv05RJWVvGLQR9MGuS20Ay0ZK+YDh3hOiE75V2m/cbWg6mU7nJ5hSJs7ARJzmWZw7Vzd685TErZDxSFuyWWWc7dCeJyg3ZeOc7T2zCO1xk9TjcVBCalPVZM8um4ZMKvAVknXkGzU6WA7df2Qd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so20434375ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761269342; x=1761874142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
        b=ZNdrDScgiX1Jt9i9/TSY6BtqrSJ5IGcgGKkCr7FQEEn9OmdsdSka0A6nNcbXDB+3I8
         trJGldYqitaU4ouTwolocgkgvWX/r9ZIj4deoojiXsUFYJDugatUFy+Zp8tl3fwPdu5H
         oe4NPJFTvFUZ0JWKkbSAqoSGqxbuR3Be6NzsgA0X5Na5vXTmdo4vExfhDq0c5gQRlm1B
         JEZRCv2QMkY34ON3o5iVwxSAxtuLeK3UxLbnFLV/w9K2UTX78HVgijJB4SFB2SOk342I
         IF9cvxmqyKdrn51SMtHWMz/DZ3/duEr/85XB5ANO16L7QxUaFA3prnsTw+S3tCj5ri5w
         IsaA==
X-Gm-Message-State: AOJu0YygMfBIn1VCilEpMvpfA2/EkMvlDtBnkPPVZwB0AVlJTowSZMuA
	dhGxNvp9dn9rNtgUhyDDrj2hT2/3H6osJG8kABjlY5QLCuNaeCw5xgkOxMaRpvodX+cV0LCmFnd
	88LTVprnEOkltoxbyyvmUY2qj+isV/2cb+sPvFiXIS2ZIB/g5oJ+wgHmFF6Y=
X-Google-Smtp-Source: AGHT+IFe8/UsLexJwQzNbeNoTQrRnd/NNnsLrLKjCb9C4y98cYpDxHsEdAPxAR014YY0tl1bIrEF4PGEBrPZGBR26TS9BBi7CF8h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:370d:b0:430:d14c:7dba with SMTP id
 e9e14a558f8ab-431eb67c48fmr16254785ab.12.1761269342371; Thu, 23 Oct 2025
 18:29:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:29:02 -0700
In-Reply-To: <67867bcd.050a0220.216c54.007e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fad65e.050a0220.346f24.008a.GAE@google.com>
Subject: Forwarded: WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ocfs2_unlink
Author: eraykrdg1@gmail.com

#syz test

