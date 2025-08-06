Return-Path: <linux-kernel+bounces-757573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D803B1C3C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D43B62446A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63D2904;
	Wed,  6 Aug 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EsiiedlG"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AB27146F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473744; cv=none; b=aOwzjLDQF0pP75o/9FiRA2riLGvCEBMleELOHiaOK5RlSDmTCcdEw+68IIIe146X+/LJYo47MwnePIdap033k/NxmP3Rs2YgNlBP0RMMRHQ6GEp44sZgudmfADrj7Paqf1cvF6zVIUa7kr2NEV1kcS6/9ixD6oJTtAX/SlXE93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473744; c=relaxed/simple;
	bh=5SYIq03Ap7x2Vsl94fmiL13UixJr8VmYZKJRW/hsK6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhdskHIPEqCz7RcSGeowZ9Hl7sZtFTxQM4yt43QYoA5G30GPwRjvPWkud1ldlcZcVBjEV0dvSDIL/c1o59zo3Oodca8DQfVvOug+36IuBKznsPo73zI8RR9ZDJNmZRtYV21zsZgdXDfE3UI4h1C+f3fiYtfJ94sgjaep/ohco1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EsiiedlG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so11865245a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1754473740; x=1755078540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Kr1PaQ/sCS57W91WJtkhDKLb3SosYr+Qg8wrL3X54=;
        b=EsiiedlGOxmygdNwU3L33lBU6q/lr+sskRAwdbIFjQIDj/LTMDkQzgVqFpewWfXmAn
         rXLnrfaZHoRXr2Q6ZaWv0kuTGz1H54rsJRzDu/Zlc+5s7G0K3kXPUkQtir/N6QFtcwlh
         zu+3XuctRrNX3qLIs8Qs5+8Mg/AkCCuzfYlNAUJQJub5cKTHCzZp+hx8Fo0Azl8iPDQ3
         bNQ9DlPjijhOeBAAHI0bxXbZ9mEtV0O0UKfQUkHQiCdwxOePX42q7mzPiyAssimmLna2
         VGi3bQSJHzZ2vTRXo0qfnFFQAd7FYlXOwYnQlvXK6KK81SFiyq5PvRaN4lc4LxdkiuA3
         O9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754473740; x=1755078540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1Kr1PaQ/sCS57W91WJtkhDKLb3SosYr+Qg8wrL3X54=;
        b=wxpMjHzQaKbSgCGgBl0b64501EPpGfMZSLMJLM2GENIwSCD2/CnP5dY8YKdO0qvth4
         OG5nbbbCYlXUgzo05R1+RoAJHZn7GVrNFSjuMg7oOM2QXDardIjWRcZcGpxjwzBWHFlI
         386hTcHk1tKuz9s+t9UKMyRjG5aa1REcZwNdzJCL7sQCHuAu5Pqg3UI6UleqK4mSkTp/
         p7jkM+wWZtjZqkdvpcbG4VjkHu9OpSRA1QOLe0Hmt9vKPM3++yPZYiuC4Rh5eTGvP1bK
         flJ29jloUapYsySbIryQ9Xg8uJCl5CjhnaZP0fGA4zD1cITaBigq2MHB/Ef6sK9zOV19
         SaYg==
X-Forwarded-Encrypted: i=1; AJvYcCXNqaK/clk1p/luDH5RYKfKR4pNKJIp93io3owTE+cNY8t/PM7csIwwxhEHrwE1H6k5YmGP+qA8zKnQdWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysY5bT9TROJnIc+VtXo+h2mA8B/Em0QNTZhANjzW6dPQIDxgo2
	fE3+jLHp5zOJO7v77072T+yuQxgAxydmhEHZ28iC4VVm8FG7ODDZj3Wkmt+r7Vzz4qc=
X-Gm-Gg: ASbGncv93UzVlDi4hszAAK2xsoiySNrCk7rT9PHUcu1O1WJOCxoXQGIc2YX9xEifdSu
	PRZ8Nkahkp5oZojDENwIZ5AKSx8gruXxfxIoNKOJl/8u3xKav/i8e1fnl9shFrvX1S+XvN7og/9
	TPsYRn/7Emx8oZhq8lbc+nHqZ9rqHF7Duboqlp5Ut9AvtebVjSzt0FU0+M8e4aF663xP6m0Em1J
	Vfn+cRIh13t6n8SM7GWfBQzRB7cfgiEMdWPtq1bAeDZanDs+XUlyD3LDzRqfNHOD5AhzG8FRxkZ
	4fd8YHwlLRReJp7fg26d5pO/3pcA7QVTHr3xw1JZEtcwpFP+Fw8bLzgWyST7ehdl+EbgBUN9wcW
	w8H6HWsNuvz0olq6+rfVyexJ3s+XxRWu/oUdoKajmAisz/O+IeARawdD3vPu9XQfYemTmK2cIsN
	3Qx9hrBKZO5maYFQIlIRMn9ZHnWg4T/gE0
X-Google-Smtp-Source: AGHT+IFd7IMVkyVKga4jKFbVEM74esML9mbnuaKUTJXLq/SVH85ZAtHNie1WOgAgCuoAVfu+725UvQ==
X-Received: by 2002:a05:6402:4401:b0:606:ebd9:c58b with SMTP id 4fb4d7f45d1cf-617960b28b1mr1742918a12.1.1754473740332;
        Wed, 06 Aug 2025 02:49:00 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f12d500023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:d500:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f00247sm10139093a12.9.2025.08.06.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:48:59 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 0/3] net/ceph/messenger: micro-optimizations for out_msg
Date: Wed,  6 Aug 2025 11:48:52 +0200
Message-ID: <20250806094855.268799-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches reduce reloads of con->out_msg by passing pointers that
we already have in local variables (i.e. registers) as parameters.

Access to con->out_queue is now gone completely from v1/v2 and only
few references to con->out_msg remain.  In the long run, I'd like to
get rid of con->out_msg completely and instead send the whole
con->out_queue in one kernel_sendmsg() call.  This patch series helps
with preparing that.

Max Kellermann (3):
  net/ceph/messenger: ceph_con_get_out_msg() returns the message pointer
  net/ceph/messenger_v[12]: pass ceph_msg* instead of loading
    con->out_msg
  net/ceph/messenger: add empty check to ceph_con_get_out_msg()

 include/linux/ceph/messenger.h |   6 +-
 net/ceph/messenger.c           |  12 +--
 net/ceph/messenger_v1.c        |  59 ++++++------
 net/ceph/messenger_v2.c        | 160 ++++++++++++++++-----------------
 4 files changed, 119 insertions(+), 118 deletions(-)

-- 
2.47.2


