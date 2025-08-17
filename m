Return-Path: <linux-kernel+bounces-772634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0251B29521
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBED7A31EB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9D24113D;
	Sun, 17 Aug 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="At8x+lbK"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAA207A18
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755465260; cv=none; b=m0yWa2AivkW7syZL5MSkXfGtPVtBRvPAlGj3qUQiTVp+J/M7KHPfMS49P2DCO8reYYTsJp0cC4SVn/txoQLB3ePtPPan1bpWPEiDAQ8qiFvjLPRsNgN4ZdzKbQdS7ko3jVGToMEdmrN3w/fPmirbFAGJIT86qTWlqtRuXmnXyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755465260; c=relaxed/simple;
	bh=2NnjoaUrv4zdmCQxJb3vMzSGFyP3tOI/u/3EG1PMtlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsArL0ukk/dVZ0x3ezw8ZzD0scbAkNDooqrwNLYKAgnI4tVQGg3yvuFd0WNrJxe4BOQtsgYaap0c6BPYxrDuBKukNmnJShfyEHlQnW6xQGPR2a6d3y7fCm30ag1wXxbeyXfksGDWDOIrjJNZgNw/HPw2hDQmCdAE2cYpfQEaV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li; spf=pass smtp.mailfrom=cock.li; dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b=At8x+lbK; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cock.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cock.li
From: kemal <kmal@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
	t=1755465247; bh=2NnjoaUrv4zdmCQxJb3vMzSGFyP3tOI/u/3EG1PMtlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=At8x+lbKHKAPu3YkGWP4z+WIFgRLmAVEn8Mo6p1Yvgo5xWWiR/QTR/6pOAORCkOiW
	 N0OjDpfrFZq49uj6sLrva8orKsdsWdWsKE4MfCUxmNDHl0P+pRO3oJaSAzcXxSnzCK
	 Zd865AwmieP2l0NLjSWRXuZsOnVqBizLdJNJW4bDsaJrd18cU9fwqR/u/ovZkOoizb
	 qiGt3hHzQzbvjcwv8XH3JPls6TI4uamP/h0Oc8FgtxqMUZ27gDCkuFAKpEPvz8SIzJ
	 TPMKS0YZsPqrXi8IAz62dGAxgGq5hwK9Eu8BYpIG6Z+rRkB+iUWwOzEmPkH8YzXKsp
	 94b8lk2Y7zXgg==
To: ruanjinjie@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/8] arm64: entry: Convert to generic irq entry
Date: Mon, 18 Aug 2025 00:14:03 +0300
Message-ID: <20250817211403.31054-1-kmal@cock.li>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815030633.448613-1-ruanjinjie@huawei.com>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

> Since commit a70e9f647f50 ("entry: Split generic entry into generic
> exception and syscall entry") split the generic entry into generic irq
> entry and generic syscall entry, it is time to convert arm64 to use
> the generic irq entry. And ARM64 will be completely converted to generic
> entry in the upcoming patch series.

I was trying to implement syscall user dispatch support for ARM64,
which is simply about converting arm64 to use the generic entry, and I
stumbled upon your patchset on Google. So I decided to write the code
for generic syscall entry on top of this patchset, and the code seems
to be working. (It boots, and SUD works, but I didn't test ptrace etc.)

Should I send the code here?

