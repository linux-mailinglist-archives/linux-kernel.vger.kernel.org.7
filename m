Return-Path: <linux-kernel+bounces-870362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3EC0A853
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACEA3B0490
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F65D2DF12E;
	Sun, 26 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbsTvMzn"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021D1F418F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483327; cv=none; b=uh/vnQ8x55DNa6sTQPmgzbJJ+EJMsL0ErBYA1BeDIm001dlLkQKTs9pw5s1oa+dKxt3NFatTnuOGWwYeS3dZY34f/0acEVpdIty8Py1druEMCpeg0rUfaSDx2v22gvuSLAHOlaU03AJ1DBX72GdXZxG+ErVChn8LeYG2Gt8Nk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483327; c=relaxed/simple;
	bh=7hYaukdo0Jdq8vOEcDX/02TcRRrIfzHxZFzM5wkRCO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBU31Ks/n6XQxqTewPg1iLpQ2IOrg48XsHys5wyPMfuWQZffW6n8cAhXM3krHdexKwXMf4Y75K7HRmJYrV4cp3dqMQOmkq74IumMU4L42/X8tEIBegy2Rr6bPhRsJcT4upF/cEdIDMkD0/jU2eEjTR8EuczBJ6SYobGbbMP28Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbsTvMzn; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so3152754a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761483326; x=1762088126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6tCO/cQOJwkdwpg0bYZ2HnPHzmOgjXWnEfvG+kC8Y=;
        b=GbsTvMznh2fS6wyXiKJUWKzg5YBvJriNpH1u3x5fKFrl+ZOY0ASMA2qkvHXNwQo9fZ
         7/HfxSy8wOgl9SH1yW9kx+yfj8IVcv047LVVwZI+6RzJUoOUfOkgUjUgz6JGz5heMT2t
         ycDf9R3vtcLg9smp+tZatDnZH6fwULm2f+6cu48Thf5MwjzRr/pioOeI71J8DApByfpX
         BRmxWFg0kSYENKdDPjkXgkSPmo7xWur7QX+rNy3U4SewjI4amup+wy0T8k5T3YsPMgX2
         +L6ox1eRVFSLrJEMc75JQclORWH1LjDluvlpyFibVraaTM/4zJwXr/UCETH+PJcI0G1X
         WZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761483326; x=1762088126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aH6tCO/cQOJwkdwpg0bYZ2HnPHzmOgjXWnEfvG+kC8Y=;
        b=vAKTU3H4M1bsopPvw6TdReAupYlRbuvQKeum/lU/xd3Q7CtBq9QP3oZk+HFyq+t9Je
         6t8qLxIizJ+/kfPnm2Uq/YuIZ4wOhsoLx+FGIZ2lzJYfIkrGl3DM0WHrFM9xIsBTIXKj
         Xmm9xRc5xeWtn2q7ElWgAJHf8Aln1Szh2cyvG9BbKF5yVg0jWVdRbZtXRNpSuJTReelU
         5ktE0miJgrxw4qe4pTeRrU5YLZpwk1uttpMSG6Ei+QoASeQmQWzI7aQvG/zvu0NKYr/B
         fF/CRiVu1PUckM5sK78JvpdlMxXR32VtISbG80CJnGiqaeeHoe6rynvaRjUxIcGU/Ccm
         iWsA==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ8ixrH2FwDrKUCIJU2UUksrLZtYNw5XjBuhK+qQOUWwylPkQnmucv5g5KK0tAmPYwemB3F7KD3/hn8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KnwYBg82kMt24lL6Peq/qdhQfDrdZPJNWfgqwirEp+mXh6Al
	Tk2zCStGDpfrpM50ZFmfp6dQr07bWS7Cd1Ji+/fmqrz69r/p4kOjWXfc
X-Gm-Gg: ASbGncvNOlDvBR4E8G18CfugCcYpf+HlncZypX4+wK+yUv7EV1tNZQ9VMJRJKO7q2Rb
	InYQt3GipbUmHqNBmZcs+b130a8/jUvmupKk0LyxTvXgb79I1rmMfvDPrA6laz+9raj81rwO0LE
	MEUuCM+bD8rCkrD1HwEE+5WazEW0NErqed4MRNoOHksiwBpeDFBIx4EDddeI38o84fpj0E4ClO9
	qZWy5emjZpP5LyjC+PuHCG20/XkBbYJ+KBejHRXZUOrU1L/03d+AhsdXvTrBZu0I2+ikPckQ69q
	g3oRtD0U5Wm9P222H3XDWl9CNKy1d3bQ1XPbu4fD5nU7tx+sXNhO1S4cFCFNRrcGbWke1n/sZBb
	OwAdj5ApwRRiWijma103DEZwRgsufhU57lMC5cuI50zFO4/XKR92wW9u6TTyLuawz+yyRWnVcqJ
	f3egojIjnP/rqaeG/tyLSdanQ0nR5b8PZxjckIv/9hJY+3dUsm40xpnRN/3VIY5q3w28n6Kg==
X-Google-Smtp-Source: AGHT+IFrOdWWMYR3d25fK5nwTlcliYXymU0pj/pOVfjUBs702aTNlLeGllm9A3rfl/Z7gtdm4PmRNw==
X-Received: by 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id 98e67ed59e1d1-33bcf8f78c4mr45902883a91.20.1761483325564;
        Sun, 26 Oct 2025 05:55:25 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm4641759a12.5.2025.10.26.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 05:55:25 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	ojeda@kernel.org
Cc: anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu
Subject: [PATCH v3 0/2] Add read_poll_timeout_atomic support
Date: Sun, 26 Oct 2025 21:54:56 +0900
Message-ID: <20251026125458.2772103-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout_atomic function which polls periodically until a
condition is met, an error occurs, or the attempt limit is reached.

This helper is used to wait for a condition in atomic context,
mirroring the C's read_poll_timeout_atomic().

In atomic context, the timekeeping infrastructure is unavailable, so
reliable time-based timeouts cannot be implemented. So instead, the
helper accepts a maximum number of attempts and busy-waits (udelay +
cpu_relax) between tries.


v2: https://lore.kernel.org/lkml/20251021071146.2357069-1-fujita.tomonori@gmail.com/
- revert the function name
- simplify the example code
- add debug_assert to check the range for udelay
v1: https://lore.kernel.org/lkml/20250821035710.3692455-1-fujita.tomonori@gmail.com/
- use the attempt limit instead of timeout
- rename the function to read_poll_count_atomic
- add the comment about C's udelay behavior.


FUJITA Tomonori (2):
  rust: add udelay() function
  rust: Add read_poll_timeout_atomic function

 rust/helpers/time.c       |  5 +++
 rust/kernel/io/poll.rs    | 72 ++++++++++++++++++++++++++++++++++++++-
 rust/kernel/time/delay.rs | 39 +++++++++++++++++++++
 3 files changed, 115 insertions(+), 1 deletion(-)


base-commit: 26c1a20bf7ce76e9afe4030f25bec20e3c63dcf8
-- 
2.43.0


