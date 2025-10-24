Return-Path: <linux-kernel+bounces-869121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880BDC07032
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047DD402780
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21E32A3C2;
	Fri, 24 Oct 2025 15:41:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A553254A8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320482; cv=none; b=uUaXVc55W3S73Sx61B0q8z1mbsTWvSTY941h75G8aOusyWtg/1tfW/BImaPRpgqpmfwr3GMG/HWlVr1d7PHp1C9mWpZklmEdjR37nKnpnRYdJKBijXO96zqLkMqSpud8GWqLW3pnCJ5Na62By6UlgTxpZHyIa3uXu1Yt+RwyxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320482; c=relaxed/simple;
	bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BxqGf+6aG1PLv5lDOiG0mzNe2N9fWJEi3aiXQ/m3b3/GjCK+Wzc2UPpgylGq3i1Wrf3p+47kzSBpw98wLKiHENTUB/GHaX5KkM7xQlMwFRdIKWP10Yosiu3j2yi5g8sr3EsAE5qG0m1CI78pJuql4GWaCR2gTQGHt3ZXN6dVTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso608489939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320480; x=1761925280;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRkGrLQrNSh8R9z5Glb4y5FFkCpIsIQK4TzAzzM+zTM=;
        b=a1UctEW/Yt82tZSMAMDy6zJU98Jwp34SvVk+qoU8uow9X4If9itxMVbz3XyUzof6uv
         7UfBV1zzf8vlX8cLGF4ZZYIAfQT3I6WjHsR6hbtWdTyXACHj/djyhic+PnEMVC/6S+B0
         5SAtHUG1G2u/+y2gEQ7L1w1HOzS3uyICikRzOBZHpHl2NMQbC+L9d2UggWkp/3imGv0F
         ESOtP+76T/E5DgTV586WqJsNaFJSRqhpM/6zGgXG2QAAC+fx2UjyFw7pxmWmXm0uqloh
         RZxp+0b7T1vW+pBH3ICdEbpl8XXYhvdwZlgg90yffyvoLyANeCu++IaZxojNNVCQ2UZL
         ujUA==
X-Gm-Message-State: AOJu0YxwRQM6yi/mK3uO5WqY0UTLkDofM9PwRilyxQoM5krN/S9NXly2
	pWTWqtrusFMTKXVOYqn56iPSHK5xJfI31oogzDZjxWeuOdJjfZrio1coTORYroRizr5RwbmqmXp
	s/skTwNx8nAWnrJ9cWiPiW2GJb1+Xho2dIuoXLF7wB0FiszMUO1lnoVR0znY=
X-Google-Smtp-Source: AGHT+IHqK00/qNWrYW9ztN4L9cCEp3DAc5FFwIq4GAqd6Ny5N3WqRZtrsRclvXOlpuUvfwoHRfuYY4uR8TJg8238HIFdZjfMWkgV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:42f:9dd5:3ebb with SMTP id
 e9e14a558f8ab-430c529a04bmr380296505ab.24.1761320479952; Fri, 24 Oct 2025
 08:41:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 08:41:19 -0700
In-Reply-To: <67389a73.050a0220.bb738.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb9e1f.050a0220.346f24.011a.GAE@google.com>
Subject: Forwarded: test fix
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: test fix
Author: rpthibeault@gmail.com

#syz test

