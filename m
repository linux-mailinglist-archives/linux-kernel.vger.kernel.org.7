Return-Path: <linux-kernel+bounces-839037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD5BB0AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118EE3C773F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794C302CA7;
	Wed,  1 Oct 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAn3vjKh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DD2EC0B4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328499; cv=none; b=Ag+NySerFUeLh91EVI5QV3YoEE5MAbilAxVSQUY9Foq04ZSRmPK9otmpEkaI2NvEYEKjxsklFee86XU1rCHMKVuvmmf4yuQWD3e0/G3GWFWYJ0y+IyvfJu1S4djGJiR2KKQ5n9TH0ZlPJn/v79qcgVWdnNvvsFbPTOQH4kXXgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328499; c=relaxed/simple;
	bh=7wPTpyELQmGX2/gHFloY/1M0+2rpxsGFoW7lJYsgJ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IaJmn+9Yj5nUef9xmXFaWW2Z3JF1bDy6BOsZF7ASKKsdcp8/bYeAdnoWAChDn1sFo8PFEioy/d7lnyyuzLkCyImaYaMYFR/b0DUO/HeHYHoDRyegzkcL3Ye0rKRx5KRfsKpA7Z/0o8Gu5ixTa6LbkMyKbuYeB+QT7brUegtfwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAn3vjKh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eceb38eb1so86945185ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759328497; x=1759933297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMWhSbeX6cw48fzbFoy1cFUgN3ejnL4612j1oxAE7Dk=;
        b=KAn3vjKhSUWz2ZlrV40yh3DsNyIluJrX/cz5wnu0PoKMUVNsBOosFOLleig1AOHn2h
         SHUMiNYcIgg93OZPBEJk5IUQeGrYNaxT697orU5i0jxfayn+Lja6X/yuj0fZwtOVqt6Z
         z/hThG/xjnZlCqVs4J8thT0z32uD1ijHH+zlna7o/xjh7g/s/R2e+Elr5Vf9JCQJUGHW
         aMGtI6FBlvH8zlIt/EehOpsz6tY5hKBZ6VGpjwNws5LZVY8uFUx+HGXMOVyQB+M5c3Aj
         O6YHnNW/3ndEpo4b3hXxlJrnQdz/0U+XTja0OkD9+E0FWizl2PZwH8cxhDQ2ufmWGG4p
         mnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328497; x=1759933297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMWhSbeX6cw48fzbFoy1cFUgN3ejnL4612j1oxAE7Dk=;
        b=Qp8IBUZMPu5qF+AwlSdNLHUA/48wsBuPUodhSoo0YbW+RMlgD/IW2+1cdsHkgOPV/u
         VC45P8azPOmXPpTeoHLROy7rAlPR+BmnlJ8iH7swIe/t9J8tkxvbGZw259Eh7xU6HVjC
         Elh5v5WcjReW1qur5B1HNtY4FsFjsaKR+gToqhglNkegibWVNpOa1j3a4ur3GJDhogcL
         52Du8HF3cCDZGSkUkT85Crx2zCh5jAf9rhkGJ7sOpDZTjTMHnpJY1FYJ5HUvW1U0Q8mR
         9Gbta0faVOEryK4ob3f4ApF2CmuzcNKwWZVPOBcLCQxiZI9FohUJsNcYvG0ZJ1LQW7WT
         dn8w==
X-Forwarded-Encrypted: i=1; AJvYcCXq7w4B7OjbiOk/iYIiMX+R32QloY+gH/I2EvS+kwoL3WCqk1gqvvzHlxJqIMQWNQCWx2KPg/10Aro11yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xYS0l+tn3DSE7BIs0FuExp2Wiq5B5ZZ/CgljpU5c8mr4x+UJ
	/yPuZIFJy4oWZSd+3ERQr+kaYmvpxaDt0iuXb9peq+G8Wbw5SKdXgxwz
X-Gm-Gg: ASbGncsuLnXHwSjb+dQ1ZP9wk8n3p+rDg40fHZYnO39gvpTBSP9gE7ht6nfbyUfKwhe
	ZpuIIIjJEyhwFtAA19+U4hzETEghFTxAU/+mlmGmmDrA2tDn0gqWpLyxWuPmdjqpmr5C5oBs1LF
	HwVrZoF0++wvObYZJ0sz/e4ReVNRfUGBQg03W7Nr19nectzLCzk1g1wJLTO05hM5c5rvooHWxot
	HiSJMxXsDyMQLJs0x8QlQwOlCVCMGLtP7RNqxHb2RpJxbMgXyO7cR6RQ9UoCIq5Jme5mzT4VKhP
	VRoxDXezsgXUnD5Jxo7zVjQtkZvnPbWwP1smIsiqNbAv/kvSUXIeIYJYd/p3sGop5mrd5ikkSxk
	+JUiPkoqlLmCbx8QeNc6yc8RjfpzQQEK1wFVj8j8M1Wy1ir8S6K9R2PNw
X-Google-Smtp-Source: AGHT+IER2jDS6uj2GDbaMnP6L4c3WqPqi3KT3PXd625o+OeslYZ1EKXr3ggxx/CbltvRyA/XG6FRGA==
X-Received: by 2002:a17:902:db11:b0:248:7018:c739 with SMTP id d9443c01a7336-28e7f2f7581mr50724135ad.28.1759328496781;
        Wed, 01 Oct 2025 07:21:36 -0700 (PDT)
Received: from archlinux ([205.254.163.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6089794447sm1598595a12.35.2025.10.01.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:21:36 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: verifier: should we handle mark_chain_precision return value properly in loop_flag_is_zero?
Date: Wed,  1 Oct 2025 19:51:26 +0530
Message-ID: <20251001142127.37559-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,
While going through the verifier code, I noticed that the integer return value of mark_chain_precision() is ignored within loop_flag_is_zero().

static bool loop_flag_is_zero(struct bpf_verifier_env *env)
{
    struct bpf_reg_state *regs = cur_regs(env);
    struct bpf_reg_state *reg = &regs[BPF_REG_4];
    bool reg_is_null = register_is_null(reg);

    if (reg_is_null)
        mark_chain_precision(env, BPF_REG_4);

    return reg_is_null;
}

My question is:
Is this behavior intentional (i.e., errors from mark_chain_precision() are safe to ignore here)?
Or should loop_flag_is_zero() propagate the error to update_loop_inline_state() and from there to check_helper_call() function?
I’d appreciate any clarification or suggestions. Apologies if this kind of question isn’t appropriate for the mailing list, I wanted to clarify the intended semantics before attempting a fix.

Thanks,
Suchit Karunakaran

