Return-Path: <linux-kernel+bounces-827463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0CB91D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545862A5A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5A2D6E7C;
	Mon, 22 Sep 2025 14:59:15 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C782D640D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553154; cv=none; b=CZL6eFqqVvfyXVF3z9G/P7dYPzzvG9aDpitui9XjdlURxZ8FBn/R0FOHTKd2ssjx0Ljr8927R6ablOYT4aMGMAmTI4S31638JFNus925uL/WA0RbMkOfDeEU8vu3c4/TLFrDKUamLlSY2M0erwg4e+CnC0WC5dyJqiSr82sM83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553154; c=relaxed/simple;
	bh=L4Tq/wlgBXJplCI0ucRhcEwWqvx9uTyZDFnY9miS8IQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rhPYEklViIcqktbDo5Rnz4Hx6KIpWKsGK9hPsZgjE2oAcfGq7ct/e1V8UANDzrA4gvU/OK3sY0+i11t3lmWvBjbzwW9NCbG+En1FawrdxWTZRCMVj/Dxi5xt1qJXXUSkIMfgReTesUDsEqfis6cHe5yg+wk9Je0fBgUWZs0y+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42571841b59so41457355ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553151; x=1759157951;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4Tq/wlgBXJplCI0ucRhcEwWqvx9uTyZDFnY9miS8IQ=;
        b=h+ctr29CTOL9cLC/1rpG0/cWltFk9CGHp/TY7MjtO9SenVo4ThsIaRTD5IbfsmvC7S
         4wD5iHqMJkvwtypIcbz4RjPmZXHLUFisg+Y6lVcESUUFGxhVmD6c9g9Xt3VSdf32dToL
         usfzilAiAxdOBrcYQaMGi2OVj2ZWSyprXhMvTDETPh2OjrsMoaFqfIESz6ZmZlQZ3PJh
         EEHB4kwF8AaNLUo6HcgNoDRx7um/3TS0amQmUjWxXlfCJwCphEfX3/QPLHIjKKeFy3h1
         gHaKwmx1kT1Q5YmkduEJoLXHHDccHiJMv8KxXAPc7oTDM3gmgtn/mnBM3cPhlD96lFQX
         7bVQ==
X-Gm-Message-State: AOJu0YxzXuW+Ffk7LU6LkuI/oV+ChxHDdafJ3fY5l9awl2v4hGZE8UlW
	Opg5CtfxPPbTbHBp1IzxF4x/B8GN6ycWeYJfUPSbOB73tP21KTzbJCur88KK4ZMsk7Dw/IAX6pA
	4ajPqBXbK3Vc+erGB6WF2peumi+i3A/TcivUKZFh3cVHwKZryeMQhTTFmHIc=
X-Google-Smtp-Source: AGHT+IGVe9VgQ6GnMitUVKZwDp7DyrqGDZjOIsctjvZl6GdMZmiOCqiQiAGS1I5kqDcq8VKquoS/ioU1QTnKepQxALdyetm4eCYp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:b0:424:1c9a:cb09 with SMTP id
 e9e14a558f8ab-424819b5040mr223440035ab.30.1758553147294; Mon, 22 Sep 2025
 07:59:07 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:59:07 -0700
In-Reply-To: <677c7b81.050a0220.3b3668.00f3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d1643b.050a0220.13cd81.05b6.GAE@google.com>
Subject: Forwarded: WARNING in max_vclocks_store
From: syzbot <syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in max_vclocks_store
Author: viswanathiyyappan@gmail.com

#syz test

