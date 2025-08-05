Return-Path: <linux-kernel+bounces-756625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A9B1B6F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6599E189ECC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3427933F;
	Tue,  5 Aug 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WaK1XnyN"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED212264A0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405902; cv=none; b=oVgG/PnRR2rxMnMMyZBDc3OBWTbxqHt5kgrVpWeo7eWznBpL7Oa4518lipA0ze8DhB9niBiO7wpDzwoBTxqcrBetQT18cTkKP3KbVKn4l1AMoylnEP+F2B3/+DxcuWNTwutrt//otnn0945GQYcX/Hr834DOLVjl0PGuUFPNvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405902; c=relaxed/simple;
	bh=LQg6G3mFTry9w1G9BpuHp3BfPSNW7emXMSOrBTBGfjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/7VfxhBiu7pbYzRtseLumbNrJXOCY09XVwEZy3AQClDI0/umLp4N8QXDeZEfwHvhfUdOnqxX/iX6093240CmI1bpUPmtdbVKJ1iZAZS5gEka0ZnjuZePZifLTmIsqTzgFv+neTc1KvvdVsSdPsOnZF+N0DchNFZ6d7XSMcHp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WaK1XnyN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 5 Aug 2025 10:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754405897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQg6G3mFTry9w1G9BpuHp3BfPSNW7emXMSOrBTBGfjs=;
	b=WaK1XnyNeVL1M2DUTRZiAyTZxU4qoL2l8Qh07WxSjLGsuS1IovykRrfQ/JELrGzRXTXiN5
	uN+iMQ7+4W4IYFUUe2QeRO1rPyrcqcXUHhH+d+QrVFDmC6BT2IiWtqXe9y/u0CHvNwt75F
	PgATHonTNX7V5ccc2MtkLy68XnvqLU4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+8f3825f100f660b04204@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] general protection fault in __bch2_err_trace
Message-ID: <mjzuxscbo5fo3ugow25hxbvgwkncocqurhz376qdgi7ec6rfe6@7gtdpp4pqq3t>
References: <6892033d.050a0220.7f033.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6892033d.050a0220.7f033.0023.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Delete faulty read_only/nochanges check in fs_open()

