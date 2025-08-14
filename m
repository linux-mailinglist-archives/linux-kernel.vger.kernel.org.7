Return-Path: <linux-kernel+bounces-769351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28611B26D51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C33A6011DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE21FCF7C;
	Thu, 14 Aug 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbnq6yVw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F241E3DDB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191523; cv=none; b=YLHjre2u41EJz39oYixKCpIXb5rI8dDIQk1G8dhhV0JZNVvCJmqlaIyjOBQR0Ifxp8CUF0AAOLpG2k4tsLY0AvXhJKHGACcFLsswYP2CRrEdL0tkbkVweV/CXbqlMOCk2Eblthii5doS7Yel4rZ4FIUvpYgHw6GYKbxhs27rIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191523; c=relaxed/simple;
	bh=qc5aDxJK1F64LBXPkuZ9lc6/pWc96CzMLXP24y+TBhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kuqzc9xpyhvSUlicHK/N2ysjoTIQY426GnWw7UUPgRafFac4pp6pOC0P9aXEGLHdlmOn4Q1ybDGbOVlWDid5oyxwltzhx21XGBLYjLzTlrTiKqKrQ4Ayx8IkTWP9HCtitVcBguUdktseB1IzomUhOkRiCX+55r0uJYEhp59ynDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbnq6yVw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0b2d21so6008135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755191520; x=1755796320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPB5RNhCbCcAQ6bj3jSC8GzEt+oraETjWNlOpTPSYog=;
        b=Hbnq6yVwrjQ9+QTQKKn1Cyvqml36lFRKdSG4DexDBmVsxfzBg/Czi7kkHE4Uu7awbU
         hCnKIRDIRy7W2t6wJrszLytsyw2BFgKe6mvSZHwzue7R/i1z4S36QY+Z2iFF1k6hbt/t
         r0YJ0CGEdoZxVixz9t9hi60yZQPqqFp7bC+3egDmbQBYt9+GrvsHGD55A/i0wT/Yi9q5
         WxLPlgzIyD+CyhKSQysV1jeW1QIn8f1pWea/gkRPVgSIJm1aquvDAOInYUqvf9I7ruMx
         yuAoSdO8gLkqg2FlxbAwm1+vtSFngNbA17Di8CWhSU77cFAJph8SKs+v973i2+JZmGgU
         7avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191520; x=1755796320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPB5RNhCbCcAQ6bj3jSC8GzEt+oraETjWNlOpTPSYog=;
        b=corDu6at6qnYII7IwR6djBYsbxyGCyQdMHV8hvkFVcn9L+vkCHhCxlze7aiCP3bbYO
         ORI8DRDF+FfqbuwcDvd2q5sNKK/GBcNm1j8gkrFX4GXZ/rrCJTSGgBUbNsosK2D1cPiU
         spqGd9ntQGYUYaTkMoebBFRDc+cDh6wOrBQGH9xGgZG0aqcwf0ezfqBG18pa/lGSXWrL
         NEpntBexDADVcWFL3a74p7rHQpzSMtLxtfg3Z4oWtdQ8D6bTom4s5GjdnI4Ly8E43G2s
         oCrJftpB4a+5I/tT4opsr5vzrKJrq2vzKtVOy9UV9bylKyjO4Mng1rU1roh2HmEU5srP
         s/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9bhZTNFF8nzulttp+nLRrBHifN2cRXF1u/PpxuE5EcsaeR3W9gY47b7sEQg9xmGD1oG7DBQwyzjsflUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMZYgq83ku8rapgcsU5Y3PSxDT6o+6tOgPYrPgw+RBSw7K01a
	Cb8ohwVx3BBSCK9Owc9gqUtY8MrkI1z5PPEALnv0S/Xfw2AM19cPQWn10/zAJxrp
X-Gm-Gg: ASbGnctxP9OliRFWCYgVoxct9iy9wpkA+gBmW7yMLAjg4T1aEWJMz93hTO1MlSaUP4V
	25ZJ+W+nCxUkPdLoRuRnrfq4HJeKR3RcNI09SbkwywMIFm9jcoZT/pz38FlVTCbB+Io+c9NoRmh
	Cok/AR+/WZQDYOKQXLPXZ52dM7nCKyNXUbepjYffgGMZ/ROiHJPGtFfxSSwsN+sRmIHjqD3NGeL
	aHu+CmK5Uhl6BlDOmikvkPjBHIyFta4pm3et3o/YL6X4BrYD49gNWcUtTNzU6D9jionJLhtrkGa
	3RYr2Ja3mBiZM9hSJgbTP9bxEYHqwFcI7+a4LZPxsOvqB6dd3YHA/EKA7tvxbBC+/XnAspdgqd6
	Ic9eczskjiJM=
X-Google-Smtp-Source: AGHT+IEiKVW5cysYs6D9PUPlaCXMJp4HJbkFO4bp/Ybcr87V8BvWMNudwkgIyJLcJXX8zmDW65a0Vw==
X-Received: by 2002:a05:600c:468c:b0:459:d709:e59f with SMTP id 5b1f17b1804b1-45a1badbec6mr33517195e9.0.1755191519354;
        Thu, 14 Aug 2025 10:11:59 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm50127252f8f.57.2025.08.14.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:11:58 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Date: Thu, 14 Aug 2025 10:11:56 -0700
Message-ID: <cover.1755190013.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now in the oom_kill_process if the oom is because of the cgroup 
limit, we won't get memory allocation infomation. In some cases, we 
can have a large cgroup workload running which dominates the machine. 
The reason using cgroup is to leave some resource for system. When this 
cgroup is killed, we would also like to have some memory allocation 
information for the whole server as well. This is reason behind this 
mini change. Is it an acceptable thing to do? Will it be too much 
information for people? I am happy with any suggestions!

Yueyang Pan (1):
  Add memory allocation info for cgroup oom

 mm/oom_kill.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.47.3


