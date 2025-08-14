Return-Path: <linux-kernel+bounces-769101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52080B26A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1201AA1154
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8B201269;
	Thu, 14 Aug 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lPOgKvPi"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0421ABAC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182976; cv=none; b=EbJ9uiYHSVBtF1eUHOF2IgLSQKAIdzJVDrhDfa6+L5DqMCekA8mXWE72P3YNyMzluB6QJv13Lxi78/jstmNeFy6wVCNnnH9JBv5t2t9ExNJL5uEADjA2DEPSlPnl5KSB3W64ZxQamWtxFU1rw96u4ZqeLxKbl/2nVFPmRQoO6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182976; c=relaxed/simple;
	bh=HhbxIxt0mAYsI81UESO8qyUQ+2w1jFxJccSrAeIllxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCkpEyTuM0j8UkK2MJiTuBDzj5Q3zXCmM1d4nPxT3FVu7zt7db4BI485YPzoWu7DRBWVFh5eVOVhWfc5d3bteC/xxU7KBcCatQ5gEDwqU/TtcpOilWj5Eue0h6vZ6c/zDKR9QonF8alS/uSUoU1CsDyHTNKJyZFcuX6Hh4SGgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lPOgKvPi; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmmgN028540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182931; bh=DLHF/zNqFw8TC4bpGo3TS1kaaAbz2WPJb0BI9EMXrJE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lPOgKvPi528fD7yXkJeH/U59VEWUvpLkgD9r8Z3HP0FQNHjNTxpCkp/2luXL8MYdn
	 uYDvtWkeJ+gEl6Lc7yQlFwMcfeBD6h1qaFkWXDisoEqY8TNnbwZnC5nbTRzUhSKSS6
	 qkUItwAVsxoLbjmbxqv6zna/jdymCG99S7Qq/X6fczwtuL3DiLvUu0/WHanRnwWFYi
	 EQ7p+TTpzI7zFf31szeHji7tDE8uUk6mT/GfNlUQgefBmFLRV4gNu6Tj4OcHa53kBq
	 lArl1f++azUXAtOSKoEn9aAvY0m83YTWADgLEZak+7Q2IEKXMyPxOh0/wVXotX/GIk
	 CL4kquSUdwP5g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CE2532E00DB; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] jbd2: prevent softlockup in jbd2_log_do_checkpoint()
Date: Thu, 14 Aug 2025 10:48:43 -0400
Message-ID: <175518289078.1126827.11901276117881575230.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812063752.912130-1-libaokun@huaweicloud.com>
References: <20250812063752.912130-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Aug 2025 14:37:52 +0800, libaokun@huaweicloud.com wrote:
> Both jbd2_log_do_checkpoint() and jbd2_journal_shrink_checkpoint_list()
> periodically release j_list_lock after processing a batch of buffers to
> avoid long hold times on the j_list_lock. However, since both functions
> contend for j_list_lock, the combined time spent waiting and processing
> can be significant.
> 
> jbd2_journal_shrink_checkpoint_list() explicitly calls cond_resched() when
> need_resched() is true to avoid softlockups during prolonged operations.
> But jbd2_log_do_checkpoint() only exits its loop when need_resched() is
> true, relying on potentially sleeping functions like __flush_batch() or
> wait_on_buffer() to trigger rescheduling. If those functions do not sleep,
> the kernel may hit a softlockup.
> 
> [...]

Applied, thanks!

[1/1] jbd2: prevent softlockup in jbd2_log_do_checkpoint()
      commit: 9d98cf4632258720f18265a058e62fde120c0151

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

