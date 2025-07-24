Return-Path: <linux-kernel+bounces-744090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4236B107E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57C7AC4A46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CA26772D;
	Thu, 24 Jul 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0QhvpiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562572676E9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353583; cv=none; b=m2DVm5N3rJ+ZzjwMeuBih6DdL9T+UWJfJU2M8AgOI9b7dn/ws6kH+js3XcIXyiBKliGOqzS4R6NVNPSYk5tEzvzEB7qg7oH8AXwgXaq6HAa2jdbCRV8rYr+Btjm4QZNhvwG3nZ/zkcO9SsMHqqbxn/OFOJFoeRi3pvK5VP0cb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353583; c=relaxed/simple;
	bh=swT+I5pVC2GmckZ0bgwrcHX8Qi+paWJ5n6xyUVa0rjo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kl850sG5H9w9IZjGRGlw2e0cRokl/qpuwzD1UNWCoOrx/3vqWfMFf/nZixfFdisg+PlSrKjMFUTfr61eT7MBUyB+r5e6dlYbm+gD8wSHRJoJzS8WBpNc9Yb2G1USKQH9mem+PLMPF37SVDbLGMAi9/zO/qfqzxEMVZe4qzWm4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0QhvpiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F431C4CEED;
	Thu, 24 Jul 2025 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753353582;
	bh=swT+I5pVC2GmckZ0bgwrcHX8Qi+paWJ5n6xyUVa0rjo=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=c0QhvpiGzhmRxmzNfzOMa7GevpnfG2oGuC7wemdUSSLy0kO11bBtcpaEqqO7p7Moi
	 LltFCLiKyygWSSKhIpdKCrjHOq+uVndBeByLEaJfM6WfR7DIdS9D/KC/R9Ib7HA2vV
	 b5dQXIGEKwUxcbyAwqcItSK/k2cqIPB9b5bKV4m6wlPGx45TRrLuWwQKEZvBk02Qq9
	 cTa3f2ndBd1N/xprg6p5uZXX0uPxR6rvE+vbOZwdqwZ7QfHQwt7fwarA4ONwWa7d+o
	 tiqxk766dQhTcNlI/xVfFP/NqkHLUVBd3Hnu7kDEg+L7viClQWnvzOP21SukLL1Haz
	 QsmfB8ql8ujwA==
From: Michael Ellerman <mpe@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: POWER9: duplicate interrupt line in /proc/interrupts, kernel
 problem or userspace problem?
In-Reply-To: <c4e878ae-e97c-4826-9962-fab15d7da632@hogyros.de>
References: <c4e878ae-e97c-4826-9962-fab15d7da632@hogyros.de>
Date: Thu, 24 Jul 2025 20:39:33 +1000
Message-ID: <877bzxdg9m.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:
> Hi,
>
> I have two lines starting with "LOC:" in /proc/interrupts, one with a 
> comment "Local timer interrupts for timer event device", the other 
> "Local timer interrupts for others".
>
> This makes collectd unhappy, because it uses the first column as a 
> unique identifier.
>
> Is this column supposed to be unique? (i.e. is this a kernel bug, or 
> should collectd expect this?)

It probably is supposed to be unique. In the early days it was just the
irq number (which is unique), and then later the named entries were
added. There's no formal spec for the format, and it's really intended
to be human readable, so who can say for sure.

But yeah I think it's reasonable to call it a powerpc kernel bug.

Having said that, it's been like that on powerpc since 2013, so although
we can fix it now, there's 12 years of kernels out there that have the
duplicate entries.

cheers

