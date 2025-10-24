Return-Path: <linux-kernel+bounces-869570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5DC082D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B641B84373
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99265303C8F;
	Fri, 24 Oct 2025 21:28:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9A303A3C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341288; cv=none; b=O9Hns7Mjcw3Zu3+mrmY24wMt4LY2A4OZLpkYN554GpTW+Y4e18Rd4n5azvfoRDMvjZlTy587W/yJlVpoLED5L3K7rxqzYlSkd+St+waAWxCN5155Q4rsvNPPDuaT/KCOJ/sD373Aj6lQAQ+dcksFWHM91uVFGqn8dJaDauPAIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341288; c=relaxed/simple;
	bh=PQSBg812Yx1yXTtxwQuWqKA6s47bl8Wen48AF09fm2o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hv5qMp/Qb7kHPQozc1MZqkud7qlGzIgL/a+GsT+ryCH7If11W3n+1NQsfvMNC+qFblVCcqTPSglBsL0eX7zWtKV4NjlqsTsSP6JmvJW4CwMFN+093cjB4GUjeh2PlZLcNBnE6ngCte0kLEcmNVUiLfL9yVuVBCg0/kXqMYmrG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-431f20be851so8726135ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341284; x=1761946084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQSBg812Yx1yXTtxwQuWqKA6s47bl8Wen48AF09fm2o=;
        b=Hn1M5Ipk4EILAM0UkyVFOVLNrsvVdsc2Df5qs8mkoLkyrqkqYyIy4hNYjlRYUYEZ2r
         v6YXDyWYBw1lUHGuhSkvbvF6iKJeQRsSTWAutFSqnxMCmmqrAt3hKF+gtyTniP9bRidJ
         WPLIq8wdxwbaJ0BWM8slRbnksFRfsaEoxI40S0vtZcRvZcvuAM+S2DnRueBROPm8PzhB
         1hEf8rCsWoejpQOrVAe11Pt6WR4X07hoW2btpTfsGD1uOIa+Me20dHBgp/vglF38X248
         ziPfOWZen3Pq3/aAap+gJiTnmUlqfLNZA4+iMSmHWEo70bf43x3uCxSXqWr4Pr7HY6Bp
         9aXA==
X-Gm-Message-State: AOJu0Yw1kCBldJnjjIW7U1rtJ8oZaOFAKkMfV9SBoDmPoOVj+tZHywD6
	GFZrs+WR9iEjpNBY57W7JTw0kAXz4LcK/lhfsEhFhDuEbx8U3Tv9G3jQTvJLZi2KxBWFtir5YCS
	YT6diMVzVoN5z8ABWG0Ca03YRRR4RzuoX/1NtpVrZrnhDE+3cVUxDiTPfqs8=
X-Google-Smtp-Source: AGHT+IFLzfw93nSa5fNTuDPUSG347eWG/791qYrJnq/V3zJmHsXqrY0OQFyiSoI2vv6xW3Xc+JDUBdCu7wmT3NJ3e8nWtKlpjGcJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:42f:9353:c7bc with SMTP id
 e9e14a558f8ab-430c5209537mr368287865ab.6.1761341283949; Fri, 24 Oct 2025
 14:28:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:28:03 -0700
In-Reply-To: <00000000000094071d061e9d0f66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbef63.a70a0220.3bf6c6.01a7.GAE@google.com>
Subject: Forwarded: WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in drm_wait_one_vblank (2)
Author: chintanlike@gmail.com

#syz test

