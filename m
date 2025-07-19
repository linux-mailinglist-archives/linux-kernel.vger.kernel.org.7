Return-Path: <linux-kernel+bounces-737880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF241B0B17B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440F73B0D74
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2BA2253F2;
	Sat, 19 Jul 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFenybWe"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06421E08B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752950667; cv=none; b=HIZAwwZ2YiwIXr1GIC6aQUoI+OdCCCTgW5yl/L/qfhMhdWfC++gz3yQ9PAEpcoT96iKC3P7eOCbPfMXRO34SVXg3LuO0m6c0SWoFvUxMveeJCPKI73K9QZCIgvdMiI5abcDXc+Rp9HZ/h5i99psUn2FG39hS0av54zzoJPkgxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752950667; c=relaxed/simple;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2GJ3y4N9o6jdMA2OzXj0TU3qtEcBNUv1FCZyEp2lZgZ6ci/Xc9yrnNpNejxkADSxa6OnyOP9bxlQ1wGs6VzXbMj0HwfMkIvThhecdZPgyu9LR7x64UsIzjQxC8G1N0QAo0YuMvfT+MTEyVgPCMbbzoaJvOJne7riuOrzJKIsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFenybWe; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 14:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752950651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YYOVYUvREZN04Anb5VZesSY/aodjhWQXXvnzRS9byw=;
	b=ZFenybWeJxczejIRk33wGeqTsTmqcsgbonXCnRqEwv/wLB7g0vHQy4RGDqKskmDH3bEbGO
	x5g76dc5cbVLC6o1/jezi1CY79pYIpzZrjmq1FlQgJCzHIL/dF1hO4G5nPLzJFFklLvFXj
	5oQi1XOyg7iMoSK4E7cldBe+4N2Tvw4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+00644eb66b865d7db7f0@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bkey_cmp_packed (2)
Message-ID: <nvehsujuezk2os4dl7oohboxxgpdxm3xsyxghob6fdguc34t6h@m34xhm6jjhmk>
References: <683d5800.a00a0220.d8eae.0047.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683d5800.a00a0220.d8eae.0047.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Don't build aux search tree when still repairing node

