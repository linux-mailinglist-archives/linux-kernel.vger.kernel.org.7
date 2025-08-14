Return-Path: <linux-kernel+bounces-769611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59599B270F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C07B4AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D42798EC;
	Thu, 14 Aug 2025 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgWsL3cA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF402741BC;
	Thu, 14 Aug 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207688; cv=none; b=Oc5jpFHaHxEzjmgyjX87sn5YJr3V9iUj9MzgFKOWEymA9c+aIg/t6D0ZRCXil/lptauW+OAmZ6KNAz7zU00dsEf/Fchm2WRW/5++sljapovmQui/Ok7goOrJGreVxOm/wxtWk3kIwpoC9k1piXWdRtq5bHOGbAtq9QEqI299y5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207688; c=relaxed/simple;
	bh=aTh+aBS7w14V7J8TtVGANY/XVkuwgHXowm/rD995nHE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mZyvqx4P8geE6Yh8DePXUd1lwEygySw3hcXuzKZPiQyiVw4qiiXuxSAKAavahjkhI3WgIZSYkDePCyVCGzrG5qxt04UI7/F+e4CKT81pjghFUxapOP3Rl4kQ+JJgiKV+GKAO46LcLp2rRmmvZxrCnu9by0QA3Z3+1kCIO7KfGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgWsL3cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B439C4CEED;
	Thu, 14 Aug 2025 21:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755207688;
	bh=aTh+aBS7w14V7J8TtVGANY/XVkuwgHXowm/rD995nHE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dgWsL3cAAYlUePavIfshowAtb/wUm1Gc8e0YmNYAOJLP3p2ax6xfHQNVmstWZazoc
	 J7DHwatdtmL2K/9ichyFzOl5NfWMeFAFExJ9wSMLzo2mQjzaE7HQw5ivY5PVaFDHiw
	 WKPk+No37gkg88J7QMo091xeZbf4xIvfwGOk7Omd4lC7LZBHyvPVM6uJJqISyukBHn
	 T0B78adhKMknTrqtTLqz6Mj5osRFRATkj4+v4AiMwtN4IWJCwdLF+1jIRbQvLD0j7+
	 JXHB+1EVlRZ7t9ZgzIbfR9LUxCVAOto48pjzxjKtJyv+4OOlqWZtpjczDWfqfHR5pS
	 JabgacJJF07kg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250729022735.1437560-1-nichen@iscas.ac.cn>
References: <20250729022735.1437560-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] clk: clk-axi-clkgen: remove unneeded semicolon
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>, mturquette@baylibre.com
Date: Thu, 14 Aug 2025 14:41:27 -0700
Message-ID: <175520768733.11333.8565315039428522536@lazor>
User-Agent: alot/0.11

Quoting Chen Ni (2025-07-28 19:27:35)
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Applied to clk-next

