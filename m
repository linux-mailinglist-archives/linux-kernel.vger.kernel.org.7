Return-Path: <linux-kernel+bounces-842826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B497BBDB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEBB3B925E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6912417C5;
	Mon,  6 Oct 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="erDaheEp"
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE823D7EB
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.6.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747084; cv=pass; b=I68K60zZDEcB7Z7PZbSbSoUQJzkRHn7aWiostCIs8uGj+Cs3vw53kLa+wuK/9QZ/7TwUG94/pPKr58uAIlLN/Q7l/1Rim1lT3fl1CzZXsry3hfrbEzGIzVtBIfJk//ge0mNaHBUUEFTl8qo7XS6LfKKdaDSRgFRn549rhdcceUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747084; c=relaxed/simple;
	bh=3laJCbK6f8pgmDZGmZqT9LOuucsVRuqtucORhHnBIrM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=JwSzT7kiQLmRvZMwlCXlQ7N1/phM5dzaNQiYHgtL1bpOybLgTzAd/2MgjFbZuUkZvdAHyI/RV5PXDAQnf6/x1vYmCPrmHqpBdQzPYL+Cezeh1cEtKVEPWFP2EA5K/jv6C4Zu1OAIwlLi3xg61nVHrstEONfZkrnh7p9jA5Q4M9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=erDaheEp; arc=pass smtp.client-ip=135.181.6.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.ecloud.global (Postfix) with ESMTPSA id E4A0672010A;
	Mon,  6 Oct 2025 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
	t=1759746619; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qRQDeA6eimcdyc4WGRHg7lpbdAQmwjp247r98CU7VHM=;
	b=erDaheEpRmN7pFyVZHzL6yyPZyD3Yy3Gfms/Fta+jVC6IDpc5mEkL6vXKXpyivmUrirWV2
	9GCZ+sgaC2EnhK6DnH2kSRUuYdODbEwfaPBqKkl57P/yk7pQFSLwL8iS0kJjbuB7KDHTVu
	vLO7Kxv9IlES9j1lwINrX8x8dAUClwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail2; t=1759746619;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qRQDeA6eimcdyc4WGRHg7lpbdAQmwjp247r98CU7VHM=;
	b=PywK3py6xRJja2td7lnw1jRqi/vFK/OpoVZmxnhgPY4ypu6ES4LELwAsiFIk8mnV0iTnZ7
	rKDIfJ2BSMzFjTnyI0vhpR6s01cQ0rvxh/8XSNk4pHDhDxZ2akg/B7JSvlQaigTu/GmPbI
	RTe0d4K2/sHhxSTm2Wq000HQjn8D/b4=
ARC-Authentication-Results: i=1;
	mail2.ecloud.global;
	auth=pass smtp.mailfrom=craftfever@murena.io
ARC-Seal: i=1; s=mail2; d=murena.io; t=1759746619; a=rsa-sha256; cv=none;
	b=L79ldWm5cY0rntrPG6F6QuCZwWiVDbWl6jlqstLtkghbNTUsGboQFgsBcozQuoLQUiuWzJ
	8pr8SSOsxlUmPd162f7xvjB+vfyHXM+pujGvGYAOBvABfIQzG1O4G7NIFG+BFDwdQeD72u
	Yp2diXNVA22n61X3NXPlLEx5CgoLI4g=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Oct 2025 10:30:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: craftfever@murena.io
Message-ID: <081a1c85c9891bd41fbbb2e0cbb702e696799d40@murena.io>
Reply-To: OaiyHa1----9@tutamail.com
TLS-Required: No
Subject: Re: [Bug] Memory allocation errors and system crashing due to buggy
 disk cache/inode allocations by ntfs3 kernel module.
To: craftfever@tutamail.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, regressions@lists.linux.dev,
 regressions@leemhuis.info

(i'd to change e-mail for setting correspoing headers for reply)
I made interesting investigation about the problem and found that if I pu=
t in kernel parameters preempt=3Dfull and threadirqs, crashing is gone, b=
ut corresponding process (git in this case) hangs and starting  consuming=
 CPU (therefore writing files is not happens) and it's impossible to kill=
 it. But system is not crashing and stable in this case, case with full k=
ernel preemption.

