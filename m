Return-Path: <linux-kernel+bounces-750885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43582B1623F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11741AA2AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F32D77E4;
	Wed, 30 Jul 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BoEelpSQ"
Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120362D613
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884397; cv=none; b=INFa6I9T8OEOH+whzybj0SvMYicvISej874ARR9KV8SRcouwGybPoNuQnxxbH4Jt8/uz99C1lhq7uJw2AjALerltbpXp5trgDBYx5yjcbKz6asCpeSlrIDml09b+ZQ+qMycqV7ZuVzSOJwWpk1g2tpEHRtqI8GbJaYcwBx9/LN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884397; c=relaxed/simple;
	bh=PsvjY7RyGo3d3Fonizv10YatysZ4/EGBEC9YTGSUciE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZKXaVUtKIAgdjORuW3Vo6WFBBwknNGYS0IPpdHVHh7jV+Tg+JGVeuJWOtth9kPAzgCTVbzLdgCnouuwgT65SJNAG3HA60W23JNDte/5DdlQM3IEJMEewdo6cIfDALH/IJDbLjf2HRQ9UV//5T28K9Qy2O40pYJTvnV62IQG/7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=BoEelpSQ; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753884392; x=1754143592;
	bh=8hCLhXl8EWYHmx6oKVBi/Zr/40J5Zxpdt7sV999ExRE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BoEelpSQ8W360zAMWC7Yu8kx8xwYS+Ch76wuWutktLIZ7Zlqglqltu9l/2tu9aYqg
	 gEbNHwhD1cOf1XatrgrI9ni1eea+r6QPEjnWmQB7LNVp8Ub5WAOLjq7XkMKvLFB/n7
	 FBQuJd4J3ZQSxlBuNfs8m99p/OJIUlqn71wk7DOpaOEXm9ZsXp/FFq9O2VwdWa/Llb
	 DLT0NY0kuCaiICuxW0hS/uJAYANHS6/4uvHFVJnf+nLmIvGDRHrVSmGilWfgK48GnS
	 lu+qS5EwI3terjS5O10bQUzypFet7pw2F26y9N2XKidCXxYfsphaFBaDIsAUtovibD
	 ifp8sYTOcWGgQ==
Date: Wed, 30 Jul 2025 14:06:27 +0000
To: Yi Yang <yiyang13@huawei.com>, GONG Ruiqi <gongruiqi1@huawei.com>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Text mode VGA-console scrolling is broken in upstream & stable trees
Message-ID: <C4_ogGo3eSdgo3wcbkdIXQDoGk2CShDfiQEjnwmgLUvd1cVp5kKguDC4M7KlWO4Tg9Ny3joveq7vH9K_zpBGvIA8-UkU2ogSE1T9Y6782js=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: e9ec8cab32d2db1109f7c0fec0fa1078417ff721
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The patch that broke text mode VGA-console scrolling is this one:
"vgacon: Add check for vc_origin address range in vgacon_scroll()"
commit 864f9963ec6b4b76d104d595ba28110b87158003 upstream.

How to preproduce:
(1) boot a kernel that is configured to use text mode VGA-console
(2) type commands:  ls -l /usr/bin | less -S
(3) scroll up/down with cursor-down/up keys

Above mentioned patch seems to have landed in upstream and all
kernel.org stable trees with zero testing. Even minimal testing
would have shown that it breaks text mode VGA-console scrolling.

Greg, Sasha, Linus,
Please consider reverting that buggy patch from all affected trees.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


