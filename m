Return-Path: <linux-kernel+bounces-881457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B2C283F5
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D4313498AD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76602FAC0D;
	Sat,  1 Nov 2025 17:41:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CB1C54AF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018864; cv=none; b=VpufTXJDmnQhAwn+GdWBVRv+rP7QS7iLOT3R7pRd/caeD8syx4cqJtEY7pcJTCmfZRiHRDc7e/HpEdteE0tODjAo9t2VVopC6OmFCeAK3YR8+1JuwqOfZCGv3zNxV8ioXX3wBAzOtbsW/3tcfeOFyeOqSaBMkDTAe1neju1M8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018864; c=relaxed/simple;
	bh=rKFcAyL0bVgM1YtLmkPWCtgpoQjL68uiY8P7nc3xI08=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OEXL/sYXFnP1DsjZjv5YE+xI7Zcxd+kp+Yy12TXA90sPGoWKgjyaLJkDjerC91RcUPwpv+rOj5IHznJYWzD5kLtm9+MvKQoo79ZFzeZ3FxoRjAoSywUf1uyGEKtrKvYTagUJ1xp9+QvKQmgnuClULmIbR+7ntYVvb/JtGgipnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43324a2096fso2646265ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762018862; x=1762623662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKFcAyL0bVgM1YtLmkPWCtgpoQjL68uiY8P7nc3xI08=;
        b=MSnlaFPyVJ41w9CfGX1vcpNxUNN37gMiiaPYvpg5CqOa+X87AsQtWEFfVsKtaMYc30
         GSlLbfECP4t+Et6d5UH5pG4jqGaqFFMPHeCxAve7PFVubxv3X/+6Evv5FWJVmPKSExHq
         ypr7vWZcbwzGVBpKOnGimxiiZnXxgDlP9Elh3PeK3OWMmnCmjKLUEczF2/zanOLg6MJM
         tbKKjftB9vlZD7emmT/3kaHT/IU7C6ED7MFEQjSToQfVm38g9SuRkWOypY7sB7NF7QqA
         aNrp/io5E+iMZ2XJsjcdRTjlBTWIkiWfTzBVSIYKNOGGAlhPF07w8299XG6FGgqYuySe
         HZPA==
X-Gm-Message-State: AOJu0YxHhREaPqjKuM4Tjwlbtalw32pE6rQaA+Zo2wpiVEPi4zidUKIR
	BbpmrUwZJGFFOV6Aj6VxK6nA9reflDoNjSaGk7DFhdiJU5dLy06LeMAQe4csBoekmoTMq51R6mT
	Y6jqxjeQtpb9DGxAe8WfHIyM40dfOpx6l0ECvNMtA8rjXo02zTaTxpSjBE0E=
X-Google-Smtp-Source: AGHT+IGcFNMboMGh2uYKtLgc4xymEMpZhqYjg+1U064aC8BAUpYhDxuC3WCDL6v9eQC+n/HsVmea9newaCbU5lIlMf+BVQzsgkiG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3182:b0:431:d8ce:fa15 with SMTP id
 e9e14a558f8ab-4330d10a456mr101437685ab.5.1762018862279; Sat, 01 Nov 2025
 10:41:02 -0700 (PDT)
Date: Sat, 01 Nov 2025 10:41:02 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6906462e.a70a0220.37351b.0007.GAE@google.com>
Subject: Forwarded: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
Author: vnranganath.20@gmail.com

#syz test

