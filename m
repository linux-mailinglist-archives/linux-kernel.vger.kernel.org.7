Return-Path: <linux-kernel+bounces-798158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA8CB41A22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB09E5E5BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7302EC088;
	Wed,  3 Sep 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lLk/zpv2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7C254AFF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892067; cv=none; b=CqHiS2zycpwmLEBrNLD7rRn7BhSVLSeMAe1xU8N+e2Z4PkaUBQ06fZPk04rdqQEewzy4sa05fqYV0SHuO+y7HthX3kO1w8/0PfDrUJhZHk/ZhCKf7ZUugPLO0iC3mnJ16iMeb/ob6908v/qvNGMQRjHjzOzvwauIbLVxy6Stu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892067; c=relaxed/simple;
	bh=50sQqvGWFB+AE9ZMhCtQmSeVgldluKZiJHqM6SF7gQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tvj9WwKLv94MKPX2O4QnuJPhpUC/3jOwAhS09s0ogavc4K6fbIZfOZKQ0uCaIaVdyWKMPyBhYeeIBG5K+tzcac5/RajtQXuxuzPXfX9oLv144qX6YR/iL4ZyvZSD/N9qSRUixo4B6dbhBEDEvUeuzsQf6mCP13m6xoIsIAyV1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lLk/zpv2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7724df82cabso3779604b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756892064; x=1757496864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iEv0lhchMkXvwt2aBzuzLqWhAwcPWm828Slme94R64=;
        b=lLk/zpv2WEsMsY6GhBLSyjFk6LaBPwtKKx0jrJWAogVAzNJY1wBmKIO0fTNoeXAqE4
         tVhPKqqf+VlqIJOzZC+hKiy+4VD3hKoYaX+Shgvr5QHBS4ayQbocBu/pBhM3JWV40lep
         sHx6AFrLb1ciK1SXg/mQ0dA9EbbzCa2ANx5eEINg84c7CEyT0pC0DPikGwBDu7T9HvVX
         XcSvgxkzBhK7KI8ui58mE/1zCF6LuynCYV8yuGQlrBnbrF6DeU0mYUoz8Epw0hyir99J
         Uu6/42v3HR9Sh0VJdelcaItuTUFJkcikv2ZlCwhhrw0lEcmTDNm5Q6T7iHzIck4OrVG2
         Dr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892064; x=1757496864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iEv0lhchMkXvwt2aBzuzLqWhAwcPWm828Slme94R64=;
        b=VV6dfvIzbZa3QZ0vZ/deAm/gv0A8R941wKcAX2f5aUJvf44VPShBoJhJKXv7lEqPE+
         1nz2WApoUgzpHaaiuMztRk+vTEftwp41fMYYoYx1kaiqsK2g+4ij3cCQI5n7WJl/hBrT
         Tp20cOSv9Ifi9+rf3kqPjsfV/vE11N69auP9oPqMfMotNiqVSeAe1PTMrQUkr9H6LJPT
         zfRW1O9wvUgOGlapHN1nYdjfKAbOcIBsOGERBaN645kn/F5urLawgsXMEmATKcj0h1yu
         Dy2ZKUKuJ/I/r4H2D8u8/5sA0b5rpafHgDjFij+Bzn6LU258H3/XXW/l/ZfpeEhGyZj7
         mlZA==
X-Forwarded-Encrypted: i=1; AJvYcCXOi/SvKuaNAj7GDMiI/CLKGip33NC572ItNnMd8ZPSFb1DsK2sAReXKsSBpR+ONmrnRzFRWjieVGTCTAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkc6rr9ivC7SNVFPruOu6D5QNIpF4RVh/j9v3hmTAfGjHqKpx0
	b+A0DPUzqi4XXLoe3xfbBi3p4tcmCnX9yp94ZtQZQ4czZHFnXtTv11H1uF2r5sKbGKY=
X-Gm-Gg: ASbGncvIzq6XSwD78Rcjs+RbZx4OXkdpDvp8suBqD/yySO0I5AU+qtdi5/5g/Kf2vlZ
	2F2KLTX4XDz7LzVfdECmRXrClBctgO5ICdCVZ62d8EH/19XhbOgXfNmy1L6rN39wWcegjJ2+z8V
	g50w+yF0NjOpmlXUlxRd/0vFkhbk4NJv001PepnnIbl2IuAFmqq20DiIl5lNZgSSzsTN4y5hePp
	5YdufCn0hejcn3OcN1ahq9Bk3/yNDVRbPLeorz5GP112lJBkIRjuxZ5ss73rAunuyLsW0zHUXcp
	U9vcJpifl3CDwmZKNsVZA4OvQS4EaJ5eQSBng1VNpFJnsyF+18th8+234igmC43wFJyHe92HfOR
	woFtdpHEYwaT3flCXilNKTvPg8X2Lzz6TUTgUvehDlwjid1pwU3VZuxPLgC/O3zKjExdvZk3YV8
	1IxUGXCAORJQ==
X-Google-Smtp-Source: AGHT+IEEVUX0wLwa9X8Jc/KbIJ0IaEt5bBSO8vdxxjqG1YeAQ8UXvAoQ0vuunV4K3BFPi57oILTcug==
X-Received: by 2002:aa7:88c2:0:b0:772:8694:1d5d with SMTP id d2e1a72fcca58-7728694487fmr586612b3a.29.1756892064045;
        Wed, 03 Sep 2025 02:34:24 -0700 (PDT)
Received: from H7GWF0W104.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16171734b3a.92.2025.09.03.02.34.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Sep 2025 02:34:23 -0700 (PDT)
From: Diangang Li <lidiangang@bytedance.com>
To: jack@suse.cz,
	amir73il@gmail.com,
	stephen.s.brennan@oracle.com,
	changfengnan@bytedance.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 0/1] fsnotify: clear PARENT_WATCHED flags lazily for v5.4
Date: Wed,  3 Sep 2025 17:34:12 +0800
Message-ID: <20250903093413.3434-1-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Amir, Jan, et al,

Commit `41f49be2e51a71` ("fsnotify: clear PARENT_WATCHED flags lazily")
has resolved the softlockup in `__fsnotify_parent` when there are millions
of negative dentries. The Linux kernel CVE team has assigned CVE-2024-47660
to this issue[1]. I noticed that the CVE patch was only backported to the
5.10 stable tree, and not to 5.4. Is there any specific reason or analysis
regarding the 5.4 branch? We have encountered this issue in our production
environments running kernel 5.4. After manually applying and deconflicting
this patch, the problem was resolved.

Any comments or suggestions regarding this backport would be appreciated.

Thanks,
Diangang

[1]: https://lore.kernel.org/all/2024100959-CVE-2024-47660-2d61@gregkh/

Amir Goldstein (1):
  fsnotify: clear PARENT_WATCHED flags lazily

 fs/notify/fsnotify.c             | 31 +++++++++++++++++++++----------
 fs/notify/fsnotify.h             |  2 +-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 17 deletions(-)

-- 
2.39.5


