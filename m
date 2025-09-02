Return-Path: <linux-kernel+bounces-796390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD46B40036
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12805E1E91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D32FFDFC;
	Tue,  2 Sep 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxyMvXjQ"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995182F0692
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815101; cv=none; b=oucHSFqoB2hn666DlxMir0gc5pIt18RV98BqsWN+YUfHLihaOKvKhBMKE7gkA07zAfakGxN3VGqzxj7H0uEoCIRyjEorQdVmzUUNlb6MgXA4HS48o3WtPfVPnkWIDpG2gsOvMaUrf4oMGtHDiWsZWG+XY3eTNK9ELuD4GHk+ckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815101; c=relaxed/simple;
	bh=/KDit76WR/wN90pG29OCtjslpnm7+69jT6279w37Fcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVraIA8NtwQlMopsmyaYLMRfIcI8DW9Cp9R931Gd00Jv8dWo0Ml2BKzIe3SE09TO5uDvnfhevn9F0CJBulZzV/K+k/GZG6WgrN77JIRqxVQM0BniMdRBNODJKJkvYE3dTkmq9APvL5XtILN5ZY4srLL8mYsgFrG1OZ1xwHWwlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxyMvXjQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4f8bf49aeaso1154823a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756815098; x=1757419898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcxn6D/ibSYdahoq+sKRu0suEG2CO3fUwHn3gn4nLn8=;
        b=ZxyMvXjQMRMALFsiNTJ7TnxHqLqJ5qq+qAILbZdR3YPABZ2QJ13euXBHBjacXkq3Ga
         /N3IQbwBpvoBRpli1WUVHvczEuAI4pCY3H1pSE5TjvTRUVKmED3LLQUEsBRk31Gbca4J
         b51dCVwoNqTCmTB3Fupdt5pHdo2FNCjf34bqTm3q9wmFzvdFCp8qR6WAuzseJAlJkh8Q
         6gnsDe4cwt8SfIlH3Yq5AmllehQdq3Tm8TuHefBEb0duyseW/C8+wf0UUCZ8ph6QrjZ6
         YI17bL+5jJmmQknyp675W14YD3bgDy5QJ37cdxnXpcCmBjGNGBvZqyP09Q0/jBjvBeMU
         66oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815098; x=1757419898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcxn6D/ibSYdahoq+sKRu0suEG2CO3fUwHn3gn4nLn8=;
        b=S5KJ1s0d75mDPdU2TsxDSz8OxxhEMlDTVP2xuMntLFqL4OP9dyLw8h+3SOSYF+UkIn
         2w3iLwsARwqQ/UldYDCnG4hAlCFHrjL98cXDoWwPbBS3pphSxgBkSBBZ50q9Hfbp7xW1
         YArKsNYxCmhOCR0Dq6mZDfNeN48RsT4fdHBBCLGYc+/HzhtrA6OrzuoEuzZ+pUujDUgi
         zlkF6DWW6D9kgND8Zje7u7PNzvzFzFgR11aLCT5ZvHyM3HIumJbqZnx0B0a/vmkq6ArB
         v6JegLVWtfqTRFG7be/nKe9RkI0iDMRxiO13SFvX6zay3b3IYQJPBCmEdrBD0P7mHe8v
         Ztjw==
X-Gm-Message-State: AOJu0YxwwBJ2nAalQcglKXqj8uJUVl2lsiXEe+6ciC6mzTG4kO2Gm0fR
	zHsAVkSWLMCmoydDqZMbBRfUk41M75MwmGIvM+400Dpk9ujIMibh8CIaFkTWb6HIWV0=
X-Gm-Gg: ASbGncvJCSKELPEmdSLxFdufR3D+kxNCf/c26ZN3802owlPy8WIvYR9Asts+rsoLalf
	1nE8GHNgUKUBH24AnTztdKbgn3D6iez20d4sPTWipefKkl7K13cq/LBuuFZb1m0X+YTmLt7tWju
	nUIU4eShQVVs0EBep7vpD0gaoJaVmxKqOfNKt26/vCocpuQWmFblnuDus9b8xZzkSmCWPLHvbSQ
	YVfL+S1NagBGrBiEi1hciTxuul2K0y4pHWDUWEXa0UeXPIwGa0eIDWKjfgC1WTs3C3fPi4zaQLC
	rpmrBy+vyJN8Uqld7spKg0boFAexRRrxC8E63KW2zI8opsT0AzHZXok0/JK2qb9ScW4NtTWRE5J
	97iK8VcxA0Z58TGkZrIPu7GXUDe/vSdW7
X-Google-Smtp-Source: AGHT+IHK7h/brIhIBkBkVRuFxXqX9nhha+NrFh961RzT1s1Bacw+Guvt9CWS/EurPjJI6J0DEz8RPw==
X-Received: by 2002:a17:903:3c4b:b0:24b:1589:5046 with SMTP id d9443c01a7336-24b158958f3mr28356235ad.5.1756815097802;
        Tue, 02 Sep 2025 05:11:37 -0700 (PDT)
Received: from yangwen.localdomain ([117.88.134.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065939b0sm128891565ad.110.2025.09.02.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:11:37 -0700 (PDT)
From: YangWen <anmuxixixi@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix data-race between fat12_ent_put() and fat_mirror_bhs()
Date: Tue,  2 Sep 2025 20:11:34 +0800
Message-ID: <20250902121134.486-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87y0qxp6rf.fsf@mail.parknet.co.jp>
References: <87y0qxp6rf.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 02 Sep 2025 23:13:42 +0900, OGAWA Hirofumi wrote:
> Hm, what is wrong with temporary inconsistent?
> 
> If it had the race with future modification, it can be temporary
> inconsistent. However, future modification will fix it by updating with
> latest blocks, right?
> 
> Or did you actually get the inconsistent state after clean unmount?

Thanks for your comment.

This is not only a temporary in-memory inconsistency.  KCSAN detected a
race where fat12_ent_put() updates two bytes of a 12-bit FAT entry while
fat_mirror_bhs() concurrently memcpy()’s the entire sector.  The mirror
FAT may therefore receive a torn entry.

Since fat_mirror_bhs() marks those buffers dirty, the corrupted mirror
content can be flushed to disk.  In our syzkaller testing, this already
resulted in runtime errors such as:

    FAT-fs (loop4): error, clusters badly computed (421 != 418)
    FAT-fs (loop4): error, fat_bmap_cluster: request beyond EOF (i_pos 2075)

These errors occurred even after a clean unmount, which suggests that the
inconsistent FAT entries were actually written to disk and not corrected
later by "future modification".

FAT16/32 do not suffer from this problem because their entries are
naturally aligned 16/32-bit accesses, which are atomic on supported
architectures.  FAT12 is special because of the 12-bit packing across
two bytes.

So I think it is necessary to protect memcpy() in fat_mirror_bhs() with
fat12_entry_lock to avoid copying a torn FAT12 entry.

Thanks.


