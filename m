Return-Path: <linux-kernel+bounces-827283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6DEB91596
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9191216A033
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC730C625;
	Mon, 22 Sep 2025 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKUGZIPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790C30EF93
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546911; cv=none; b=IA90ry+I4DQmE76+7KZOTkY4pingJsGh/PUI/3WDQXaGTHGGIpsy7b2ipHNycKLdRTv20QB6EvNawQuEPruws/5kK9jlPyOac0SwklLGJYOaYAEIpzeC3jzSQYI0GLN5kKmTVo3k1kvFwGP9fwD9YIhUMntRnCWRqyfgD2yjz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546911; c=relaxed/simple;
	bh=6UJScf8g+nt2Rgo/WhMNYndeCkN5era5i1Ssuuc8Bmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma4IJtEjNPC8Imv1a7KEiNemM3eNsgJ91/VHW6s/Tq0U1KNDEi03fMyohD+66Ii21Y3pszVWZNbXDVs5LsX9Vdg+hNu2MEqRpaPJSss6Ety69yaZYK4FIZmWRjq5vgdesi8CK5KWc2bMnB2uRr3knjt4oD5jzIWd1uyV4Uyz8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKUGZIPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB9C4CEF7;
	Mon, 22 Sep 2025 13:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546910;
	bh=6UJScf8g+nt2Rgo/WhMNYndeCkN5era5i1Ssuuc8Bmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKUGZIPSZrtBgtGO5WbFapidt4G76uWte/XT89E1wpX2qlm7y1jq3k3PLnRlodDJI
	 cFjkCdDJHbd+it1QjxQL8psMPCWPyC/72n1ngAXUTUqaYTibHv3xDTGnkxRNPspKD2
	 LLojmEqbJotufScROYmL/BIift6I8T17tdBA9mMBkqTQzxu6iOEqU0ECQb6XAcZTNm
	 Adfj17w8ZOQE7riJKtRDCwGpbd6DsQYZOfTZZ/XxjBGlrc2RKXYOhRKePuOywzeJsk
	 /nsEFgouCqpKVT2y1GVehPQyRlkYMrxdlsUVfJx8spIV10DfwLtOYL4sa0bw683q7D
	 q2uxtFIDrj9wA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Can Peng <pengcan@kylinos.cn>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm/syscalls: mark syscall invocation as likely in invoke_syscall
Date: Mon, 22 Sep 2025 14:14:49 +0100
Message-Id: <175854396942.3145289.6573440532585531587.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250919100042.497861-1-pengcan@kylinos.cn>
References: <20250919100042.497861-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 18:00:42 +0800, Can Peng wrote:
> The invoke_syscall() function is overwhelmingly called for
> valid system call entries. Annotate the main path with likely()
> to help the compiler generate better branch prediction hints,
> reducing CPU pipeline stalls due to mispredictions.
> 
> This is a micro-optimization targeting syscall-heavy workloads.
> 
> [...]

Applied to arm64 (for-next/entry), thanks!

[1/1] arm/syscalls: mark syscall invocation as likely in invoke_syscall
      https://git.kernel.org/arm64/c/da9e5c04be58

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

