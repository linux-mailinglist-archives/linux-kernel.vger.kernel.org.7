Return-Path: <linux-kernel+bounces-893402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D29C4747D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FED03B4065
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9B313547;
	Mon, 10 Nov 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gI+qUF/v"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD530E858
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785778; cv=none; b=rN2b4Xbu0tNud0hESjN1OvpirLvLPUuz4Qu2gtYtXwd0lGXKuQdvqHbAmMZ2PXVqovYpme5HNUpMvymX+Uku/Sym5YQNu9eoqwFAFwerlDhzlz3w1EF/3WProfckFQj4c3k7KnwrFMsNPMoQyjJ8dYLPOjd3yNoSxrow/1otKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785778; c=relaxed/simple;
	bh=YYJDGhYEE+IE3sRD8B2vXjob2uf0ya/UBo8KW6w42aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEGlmR11e7H5lGAgTFtFaOB2gl9AcmpHUNCqwNM8F7CldfW5o3IMSj1gb3RS3S8beSBswuxD498sLTrh3n7+b2KRLXNnZrpAhRjfTrkaIZCfvtDj08kvACqCjzLkSt4Ztq+3BY1oNaLv+u4aodsAB/vIbMKnk06kXAFlsLrearg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gI+qUF/v; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34378cc66f3so384540a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785776; x=1763390576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNzjHQ+WrDJMGz6phMHSxuZiXquRr8z8joipRN7J12Y=;
        b=gI+qUF/vJOGu8cgQAHAdvr0MQUCq8PSqAnUdMHgj4YNxP01V/pBIgU1RtZNYx98+tp
         s0ZBcbZ8G+CwftNj3/XToPhfTd/xvO4YrhWNqKuz/YSXWV22owFCdYhoQwpeQ319AKsH
         xi0cSUYZTeNsZOO+BF44Os5IxeHFLRpqoJmHuN2pufk7Ed4o1lur9js/6B/4lyJK9zNF
         2Min407wl+whzzON7bwlCAyQkBJlKkH9P0Sn3rra1tzJs1alq4q2v9oIMlYh33PyAP1P
         T1qR4gFn7f78UpzdsSzvtepOZ5nLy/NeocFDepx/WSKtVqeeT9CX8Q980phUPfQJKOUz
         pHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785776; x=1763390576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNzjHQ+WrDJMGz6phMHSxuZiXquRr8z8joipRN7J12Y=;
        b=JRJ4hDf6EkOZwo1aoZOVQaUjOF9khDbk+oVYIl6ajKE+tZ6GCNR6ddjf3W6S9Suww2
         B4pGXczf/JwDQAm+67F0AchFg/+wII7l6aZ4RE1bLfU6fe93r/Ya1SyroytdCH/2mhR2
         woyDb9oFzjl0rRqK2FRpMPPfD+gLXi5GXRkXwgrq3orngFXZ6ze5t1HcOBtJWZ/pXdLK
         bJS7H+Jf6KWxlvI6KykGnVzn1fPVsyE3MhYPw3kx6Pozsw5XzeCmyGVj5B6ccpD3LtU1
         d89xDeaLu3EoSTLdPIL4tl//NBPueCV8Xw97j5CoA6jopFUnI2LYizmhrATYRPaMEZGS
         uC0A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4FfDjvP0EjYq6zx3kBpLcDfTB0VNtM1+itIUlLaWpiQ2NrWs8ZN4M96q5TeKwWOMJSEXn6G9SiJb3jI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XcucyvGsxki8C/+39yH2wKQPgYiTEZGkLa/cvyrMFqhQrhvS
	TY1uhBHpnEGPzpdh26TMY+pngIn6r5cuBF+C4PCT7nwFYfE1s1tgFl4J
X-Gm-Gg: ASbGncszWf2vpQdFGhfNr48eSqhIxfndSnfZ7linE+qg7QhQBtpI5OQMylDBRyAjkhV
	Dd3HD9JrvlZxHG+nLbL74pRjZowe/z/naqzmjXq1Mdl48uGAuTy7n9ITiDQtTwpp1Q7XOW0J+tQ
	cPMKghgsODnvw8Anjk7QXqVmNCRBEKUC8QYHoR01I+Br68MvQ9E1Kvf+5/sJAoc63jI75tRJ0aA
	rZF2BZbaxcahdwPVIFKsNi3kn/9I2/teRPraKa3FWRtQ6/IkOKi8fBeuOsjxrDx5OBAh8sjijCw
	dcURLmcT2XJUnnli2nZrtD6JwU3MnPGnYHEGmPoT+4eU1gHgnz8SAlXeBjgiOxu9ZhUzvxd9aiM
	oQTKUXdhscYWXzlBiZIzJIDGR8tES+3K3anO7y7zw9U8yK1xoTqfy/6qamMnIKQ8EQvhujJYdOW
	8XXywxOORqO8/DAJlp6i0QH/MqXav5
X-Google-Smtp-Source: AGHT+IFLIvfvzBAOLg54kuvXq8pVBAwIGNRWPiBHJBuAsnmvQ5Ms9Se5CcOXXisu3gJm6vu1H+yXVg==
X-Received: by 2002:a17:90b:1b44:b0:340:aa74:c2a6 with SMTP id 98e67ed59e1d1-3436cbbec71mr5653917a91.6.1762785776489;
        Mon, 10 Nov 2025 06:42:56 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343abec3836sm2163308a91.18.2025.11.10.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:42:56 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jesper Juhl <jesperjuhl76@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH v2 0/2] uapi/samples: guard renameat2 flag macros
Date: Mon, 10 Nov 2025 23:42:30 +0900
Message-ID: <20251110144232.3765169-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including `<linux/fcntl.h>` after libc headers leaves the renameat2 flag
macros stuck with libc's values, and our sample code in turn redefines
them when it includes the uapi header.  This little series makes the
uapi header resilient to prior definitions and ensures the sample drops
any libc remnants before pulling in the kernel constants.

Changes since v1 (based on feedback from David Laight):
- uapi change now checks the macro values and undefines mismatches
- sample code always undefines the macros up front and documents why

Link: https://lore.kernel.org/all/20251109071304.2415982-1-nogunix@gmail.com/

Masaharu Noguchi (2):
  uapi: fcntl: guard AT_RENAME_* aliases
  samples: vfs: avoid libc AT_RENAME_* redefinitions

 include/uapi/linux/fcntl.h | 15 ++++++++++++++-
 samples/vfs/test-statx.c   |  9 +++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.51.1

