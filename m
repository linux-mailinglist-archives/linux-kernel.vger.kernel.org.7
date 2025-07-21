Return-Path: <linux-kernel+bounces-739944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09DB0CD61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E049543A02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060D24169A;
	Mon, 21 Jul 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hXRUiXoE"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96F17996
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138665; cv=none; b=kK0x/DE+qDMjyHt4xyGz6MnpTlOH8CgXSMKhhRxgXXHrnMQTcu7g+7ApzomP0bBr5FzNyefLePXN6Izj0aTEAv5heoaHjb1G7sU5CEvP2nQ4f3ndaQIghI70Zlpy4XZ7utzxO8rb+sKg3VNy/quB4SbPLGzxff+1pFJdSMHpECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138665; c=relaxed/simple;
	bh=TyN0LoG7F4PN66yuNaLyVXzWksV0lgHTehNO6bq3yoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xq4+19vP/+NvuBtn89pVJn/HHrQTBfpPg9iXgteQtsnuABU143rQbG7WASaG4AH1l61LKgTekTGNNmsVCLc6pxhCuNFr/JbPneCmgLpmxqSm/IrQTz4jV8P0gfoY+Ip4HO3k0EiTJiXMz85RfBcXdDFiT9Jx+sT3HYjByy4ycB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hXRUiXoE; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753138660;
	bh=m8qjn0N73gpTufx83OtUdh4X+qwhGHuYEx0MW7MuwS8=;
	h=From:Subject:Date:Message-ID;
	b=hXRUiXoE0zjoFJMpOi62CUZXQ3Bg27UUigBtdaxF+UMETKdyQegH/faJYwd+5VoML
	 c0caGxxEe89lUZK0jPbFAFlOiPi4jqg51X22k7Dp6TcLAB+IYb0eNu0ULur5k5mvSu
	 VN4tx3KEzOOj9EZi4E4HbTx8R8gIjyPly0qHAJ9A=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 687EC5B4000061EB; Mon, 22 Jul 2025 06:56:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9752656685171
X-SMAIL-UIID: F1BB4D8D73B94522B5528DCDB2B864AE-20250722-065653-1
From: Hillf Danton <hdanton@sina.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: David Laight <david.laight.linux@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] kernel/fork: Increase minimum number of allowed threads
Date: Tue, 22 Jul 2025 06:56:40 +0800
Message-ID: <20250721225641.2691-1-hdanton@sina.com>
In-Reply-To: <20250721192830.6f8f57d9@pumpkin>
References: <20250711230829.214773-1-hauke@hauke-m.de> <48e6e92d-6b6a-4850-9396-f3afa327ca3a@kernel.org> <20250717223432.2a74e870@pumpkin> <576d1040-4238-4bf0-aa61-e1261a38d780@hauke-m.de> <1f81e064-1b19-475d-b48c-39f56381058c@hauke-m.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Jul 2025 17:28:20 +0200 Hauke Mehrtens wrote:
> Hi,
> 
> I am not exactly sure how I should limit the number of parallel user 
> mode helper calls.
> The user mode helper is calling wait_for_initramfs() so it could be that 
> some calls are getting queued at the early bootup. This is probably the 
> problem I am hitting.
> 
> I do not want to block the device creation till the user mode helper 
> finished. This could also result in a deadlock and would probably slow 
> down bootup.
> 
> When I limit the number of user mode helper calls to 1 and let the 
> others wait in a system queue, I might block other unrelated tasks in 
> the system queue.
> 
Can you specify how system queue is blocked, after a look at the false
deadlock [1]?

[1] https://lore.kernel.org/lkml/20240927112516.1136-1-hdanton@sina.com/

> I would create an own queue and let the async user mode helper wait in 
> this queue to only execute one at a time. When one of them needs a long 
> time in user space it would block the others. This workqueue would also 
> be active all the time. After the bootup it would probably not do much 
> work any more.
> 
> I do not like any of these solutions. Do you have better ideas?

